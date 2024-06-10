Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B966BC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 19:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGkHe-0008Kw-KW; Mon, 10 Jun 2024 15:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGkHc-0008Jt-E9
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sGkHa-0005mh-9G
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 15:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718046136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RZzkEC00PMCmpQtAC/G0+Z2ZIGcd3tBnqEjy7cmCdqg=;
 b=KXScCOSRrCpPlA7nGRSgh0TDAafUNFQxDi90k62mQ5H1rNl5c2OBdkzVJC/zwHrQoxVoul
 hzma1I2s996C6yCq/f7Xchm3vdVLdfoMYwBd6oIaMxwNU4X4vkCZfTJhXi9NHHqKxc9xL7
 l9caouid8MeIcdux2BiMntb26B78B2c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-fHeYOR6XMTmXNJR2_8Spmw-1; Mon, 10 Jun 2024 15:02:15 -0400
X-MC-Unique: fHeYOR6XMTmXNJR2_8Spmw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4405e1818adso969291cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 12:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718046134; x=1718650934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RZzkEC00PMCmpQtAC/G0+Z2ZIGcd3tBnqEjy7cmCdqg=;
 b=h2Npzx6JNC0P2REKmbufNiTJRwrJ2KxWMledZWASz7g3gI125X9hUgCviPy1pncpyS
 rwQDa5Xq9qDV4ygsJSZkStzLMSvgT0bAVnu65Ln23MJPealIZ/HsV1bHA9ebVa0OHTNI
 KxzYEX9yNNx9NyKVDH9UlATUv6WzyP5+0TaBTxeKoA9C4Yx75ZUm11RnZWGLGhT+VAhM
 SIzhrIZAdx4sducK991ZaaZHJ1TsmexLlbG+Y0i6waBafQV4xOx+AU6i3k0/AupQr3eW
 PUs10NxW0I/OYyYUoYz5efd4CDAsM42butM54mtJeQRRACiBMXIHGYL++OabVNKWXN06
 Ix7Q==
X-Gm-Message-State: AOJu0YxqD0qXmbEIoqxE/dzcN7UcBz7prKpYH5CcWFCdmnVrTjDINJ4p
 K/O/8rqgx9QNh7peVW1LqMfoUPDKD1MpzFkOXL5tRh+R0tIyD4owFjqRoxS5h53bAoR3pYq3n/9
 WUPYIPdZpEQVWdD26nn0PtbsT3pcFtHi7c+94eEyG24QzHg+FMM2h
X-Received: by 2002:a05:622a:1883:b0:440:60d9:12a with SMTP id
 d75a77b69052e-44060d905dfmr59418981cf.6.1718046133511; 
 Mon, 10 Jun 2024 12:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7UpqMklzdWXB8wP09q8ER8NOxvbMgj6/IkCFmQKKYbUb7QgEw8oXqKzjYOXDT0bUgWesUNw==
X-Received: by 2002:a05:622a:1883:b0:440:60d9:12a with SMTP id
 d75a77b69052e-44060d905dfmr59418501cf.6.1718046132773; 
 Mon, 10 Jun 2024 12:02:12 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4405cbd8f05sm22080751cf.50.2024.06.10.12.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 12:02:12 -0700 (PDT)
Date: Mon, 10 Jun 2024 15:02:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 18/18] migration/ram: Add direct-io support to precopy
 file migration
Message-ID: <ZmdNstq2bONG-7M7@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-19-farosas@suse.de> <Zl9_ZiC6-743ZosG@x1n>
 <87y17gwq5g.fsf@suse.de> <ZmclVQw0x7KKLxmF@x1n>
 <87r0d4wv1q.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0d4wv1q.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 10, 2024 at 02:45:53PM -0300, Fabiano Rosas wrote:
> >> AIUI, the issue here that users are already allowed to specify in
> >> libvirt the equivalent to direct-io and multifd independent of each
> >> other (bypass-cache, parallel). To start requiring both together now in
> >> some situations would be a regression. I confess I don't know libvirt
> >> code to know whether this can be worked around somehow, but as I said,
> >> it's a relatively simple change from the QEMU side.
> >
> > Firstly, I definitely want to already avoid all the calls to either
> > migration_direct_io_start() or *_finish(), now we already need to
> > explicitly call them in three paths, and that's not intuitive and less
> > readable, just like the hard coded rdma codes.
> 
> Right, but that's just a side-effect of how the code is structured and
> the fact that writes to the stream happen in small chunks. Setting
> O_DIRECT needs to happen around aligned IO. We could move the calls
> further down into qemu_put_buffer_at(), but that would be four fcntl()
> calls for every page.

Hmm.. why we need four fcntl()s instead of two?

> 
> A tangent:
>  one thing that occured to me now is that we may be able to restrict
>  calls to qemu_fflush() to internal code like add_to_iovec() and maybe
>  use that function to gather the correct amount of data before writing,
>  making sure it disables O_DIRECT in case alignment is about to be
>  broken?

IIUC dio doesn't require alignment if we don't care about perf?  I meant it
should be legal to write(fd, buffer, 5) even if O_DIRECT?

I just noticed the asserts you added in previous patch, I think that's
better indeed, but still I'm wondering whether we can avoid enabling it on
qemufile.

It makes me feel slightly nervous when introducing dio to QEMUFile rather
than iochannels - the API design of QEMUFile seems to easily encourage
breaking things in dio worlds with a default and static buffering. And if
we're going to blacklist most of the API anyway except the new one for
mapped-ram, I start to wonder too why bother on top of QEMUFile anyway.

IIRC you also mentioned in the previous doc patch so that libvirt should
always pass in two fds anyway to the fdset if dio is enabled.  I wonder
whether it's also true for multifd=off and directio=on, then would it be
possible to use the dio for guest pages with one fd, while keeping the
normal stream to use !dio with the other fd.  I'm not sure whether it's
easy to avoid qemufile in the dio fd, even if not looks like we may avoid
frequent fcntl()s?

-- 
Peter Xu


