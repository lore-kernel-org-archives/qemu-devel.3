Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C45C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 04:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWqEx-0001Am-PR; Sun, 04 Feb 2024 23:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqEw-0001Ae-QK
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWqEs-0000cE-Kv
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 23:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707105945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sPvn6CNRYCtOxiMLgTAjSnV1FOhcb8WigZ8P3cqqSGQ=;
 b=extl22JzgAaZx9J1uzlzep2CGFnkT86YrBpBFbOPkl4Sn6lcHcy0fJMI0Vknp+QaYkqQNu
 P+ExJRuWwrJWxdjiwvhS6YCEW3yANCkpSftSrYlILiqj8stPSmYMu/QaFZrhYEp7/scqo4
 91lEmodxZP4kKMWyQMKdfUr7XLNyeIY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-MaVLvID-Owypv8-j1SbyRA-1; Sun, 04 Feb 2024 23:05:42 -0500
X-MC-Unique: MaVLvID-Owypv8-j1SbyRA-1
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-7bbde31d9b7so128092439f.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 20:05:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707105942; x=1707710742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPvn6CNRYCtOxiMLgTAjSnV1FOhcb8WigZ8P3cqqSGQ=;
 b=Tqpj+dweeaGV8zwHQBW/3wr9O1UM73Li0JuXXcB02TmilnnJ8999e5i9rhdo84sCiu
 cMuwfruxJjBTXc0nQCoFefKgaclMkyh6qKx6XVLCyb8uQDZUMCeGtWX3eQX/tjbltyiA
 nDG//Im5Rq4FOmml+7uHOSHxmgLb9wsT0FJCQBK36aOgyfAs4FJijzRzvwI8a+M5hnm5
 l4NA2aKpXQQy6/3VuS/TEHLRaV7QIp/V3EP9pPZxdX/NXeeQrqMqJp99Wjawc+/8ZIAA
 v+7wjorihfLhRogfmoPQoF1HRse8c9+onVe6lfZLPGqhmrXOZkjFUsPfGxCW1cDtoO77
 I8UQ==
X-Gm-Message-State: AOJu0YwtcbLBfhq98OLm7HWYmMXVk8LUuydevcz7sCRousYduc5mRpxv
 OMy/NOXvwQ7Kf3x+aXFphNph08IloJQAbAQ/yfDBU3MftWLpYiLifbwSEDXI5fIZ7TjPliTX+Xq
 nwMYJ/rX+j5FuNJGy8FIOhxxqc4mpxg8YqfuVgm9XHoLMyNa1mR8Z
X-Received: by 2002:a05:6e02:2186:b0:363:c82e:57d9 with SMTP id
 j6-20020a056e02218600b00363c82e57d9mr1878820ila.3.1707105942159; 
 Sun, 04 Feb 2024 20:05:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8UPI31uxSJ0VD0dA46UQU/bBP1Eo18wcSMrZtWu5UHdzcbQI2Pdek5/HFWsJpK9Omp9DH3g==
X-Received: by 2002:a05:6e02:2186:b0:363:c82e:57d9 with SMTP id
 j6-20020a056e02218600b00363c82e57d9mr1878809ila.3.1707105941831; 
 Sun, 04 Feb 2024 20:05:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCU2CKstV87QC05Bsw8tKGee/FN3jYSs8Xn1YWxW3Oxd+xtw9vD8Vd01On/p85OlqFG5CARXpZfgasx7iP5NcxgLGrz3AJdyTMPLGX2MYn89aLERoHazYzon/O2xGUVTQP8gJAtOANXINwho7/cryt86+wQDPHukxwmTdZNXPMqoeTsUS9JfjhYxj2AODB6d9h99k95eBl0gSDQMEc/sjgZikoRgNzB6vSziaXejTElUfxhNpfbB0KUCScAc
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 h13-20020a63c00d000000b005ceac534e47sm5943946pgg.51.2024.02.04.20.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 20:05:41 -0800 (PST)
Date: Mon, 5 Feb 2024 12:05:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>,
 Prasad Pandit <ppandit@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v2 22/23] migration/multifd: Fix
 MultiFDSendParams.packet_num race
Message-ID: <ZcBejKDHWd4c948M@x1n>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-23-peterx@redhat.com>
 <87zfwifubd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfwifubd.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Feb 02, 2024 at 06:08:22PM -0300, Fabiano Rosas wrote:
> peterx@redhat.com writes:
> 
> > From: Peter Xu <peterx@redhat.com>
> >
> > As reported correctly by Fabiano [1], MultiFDSendParams.packet_num is buggy
> > to be assigned and stored.  Consider two consequent operations of: (1)
> > queue a job into multifd send thread X, then (2) queue another sync request
> > to the same send thread X.  Then the MultiFDSendParams.packet_num will be
> > assigned twice, and the first assignment can get lost already.
> >
> > To avoid that, we move the packet_num assignment from p->packet_num into
> > where the thread will fill in the packet.  Use atomic operations to protect
> > the field, making sure there's no race.
> >
> > Note that atomic fetch_add() may not be good for scaling purposes, however
> > multifd should be fine as number of threads should normally not go beyond
> > 16 threads.  Let's leave that concern for later but fix the issue first.
> >
> > There's also a trick on how to make it always work even on 32 bit hosts for
> > uint64_t packet number.  Switching to uintptr_t as of now to simply the
> > case.  It will cause packet number to overflow easier on 32 bit, but that
> > shouldn't be a major concern for now as 32 bit systems is not the major
> > audience for any performance concerns like what multifd wants to address.
> >
> > We also need to move multifd_send_state definition upper, so that
> > multifd_send_fill_packet() can reference it.
> >
> > [1] https://lore.kernel.org/r/87o7d1jlu5.fsf@suse.de
> >
> > Reported-by: Fabiano Rosas <farosas@suse.de>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Elena had reported this in October already.
> 
> Reported-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Ah, I'll do the replacement.

> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks,

-- 
Peter Xu


