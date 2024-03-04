Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD05DC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 12:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7p7-0006dr-8F; Mon, 04 Mar 2024 07:53:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh7p4-0006dK-TU
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:53:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh7p3-0006W1-Az
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709556815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQTzI5RbwcARNm1W6r+Eijre1yn5IivSnIVIQu26ThQ=;
 b=Y04ZY0gjf46+pohiPYfBwSuoGYcZyv1LSM4I5121LeiQhwEeRYDO7YsuE+jmE0Gxms4f3m
 QWi9EL9R2pnThQPpGrg4Ytn+hplB/1YAJLFJ3PCKSMeKrsND1pghdTJiy1A6/JWNe+08Lu
 3qyTCJh99nn/HGpVeS5fc8g6bzRlOqo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-TcvuKZcnOKy3wSPtPIYw-A-1; Mon, 04 Mar 2024 07:53:34 -0500
X-MC-Unique: TcvuKZcnOKy3wSPtPIYw-A-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cfccde4a54so1558067a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 04:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709556813; x=1710161613;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bQTzI5RbwcARNm1W6r+Eijre1yn5IivSnIVIQu26ThQ=;
 b=tZAEvv/Mt37eco8lNu2hLJq8jkNwyaQrm2YqrwzD0NSvq/uagKViJV6x5h9UE1x6oU
 0W4lZaOzhL8514ynjtmj4mzvYN8R/yJKNinCFSKCLBlDMOuuMxxPTUZ4k+ZAiXLDhaCT
 TsO8HjNBxQVjVgR2I0yUtlODzIPTfpiFmqgUpD16kXNmjKJffWJQqvj3j/C+mmHsP6JV
 pMu6g3DtRYieOfEnOD0culfGHM+8TxdjkKWBSP5sE5PBWayyE5iKtc6iymebUwdS14c8
 hzvF8xK+RrbbEJeWxf4bTZ4V6foDWN6Mx0teJ2y/1tK1ClaEzIRQ5KveXl0w5CsPiPhG
 taig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqXaObj9hvDOUffBz1lUnzHR6fzRkVFcNZ8q6WLlmGlhRF4PHIWPH7VCO9sr7e9PNK6xVmH9AdBI30qFyigC1RaYnR8+I=
X-Gm-Message-State: AOJu0Yy6mFe08g7O7HD6fSqdMxAlYxFj6nnhsy9BS5T3D+GgzRpGgIX0
 N3eIUxm2DwFp+nfVpwp1NQOQO9OtwzwEqfXusJhMPVDLrITS4N6oiG6B8ugL5/YOpHRNLqQ6HZm
 yKWdCakHevWr2mmB7klCJdXRhg2KAyhEhc8xNcJ6LUmM1l8NUaKzg
X-Received: by 2002:a05:6a00:acb:b0:6e6:120b:9b3 with SMTP id
 c11-20020a056a000acb00b006e6120b09b3mr5257965pfl.1.1709556813520; 
 Mon, 04 Mar 2024 04:53:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqylxDFxYiLoV720pHjWyo7bQs91EO8ANI4glbk0+cru+43UmdJViCLMmOGGfqQxGtjOxWgQ==
X-Received: by 2002:a05:6a00:acb:b0:6e6:120b:9b3 with SMTP id
 c11-20020a056a000acb00b006e6120b09b3mr5257952pfl.1.1709556813135; 
 Mon, 04 Mar 2024 04:53:33 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 w8-20020a056a0014c800b006e622f9175asm1623555pfu.217.2024.03.04.04.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 04:53:32 -0800 (PST)
Date: Mon, 4 Mar 2024 20:53:24 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 00/23] migration: File based migration with multifd
 and mapped-ram
Message-ID: <ZeXEROyMmHffj1b2@x1n>
References: <20240229153017.2221-1-farosas@suse.de> <ZeXAGEVFWt4Z8QeN@x1n>
 <ZeXBsR0ctl4evdYb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeXBsR0ctl4evdYb@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Mar 04, 2024 at 12:42:25PM +0000, Daniel P. Berrangé wrote:
> On Mon, Mar 04, 2024 at 08:35:36PM +0800, Peter Xu wrote:
> > Fabiano,
> > 
> > On Thu, Feb 29, 2024 at 12:29:54PM -0300, Fabiano Rosas wrote:
> > > => guest: 128 GB RAM - 120 GB dirty - 1 vcpu in tight loop dirtying memory
> > 
> > I'm curious normally how much time does it take to do the final fdatasync()
> > for you when you did this test.
> > 
> > I finally got a relatively large system today and gave it a quick shot over
> > 128G (100G busy dirty) mapped-ram snapshot with 8 multifd channels.  The
> > migration save/load does all fine, so I don't think there's anything wrong
> > with the patchset, however when save completes (I'll need to stop the
> > workload as my disk isn't fast enough I guess..) I'll always hit a super
> > long hang of QEMU on fdatasync() on XFS during which the main thread is in
> > UNINTERRUPTIBLE state.
> 
> That isn't very surprising. If you don't have O_DIRECT enabled, then
> all that disk I/O from the migrate is going to be in RAM, and thus the
> fdatasync() is likely to trigger writing out alot of data.
> 
> Blocking the main QEMU thread though is pretty unhelpful. That suggests
> the data sync needs to be moved to a non-main thread.

Perhaps migration thread itself can also be a candidate, then.

> 
> With O_DIRECT meanwhile there should be essentially no hit from fdatasync.

The update of COMPLETED status can be a good place of a marker point to
show such flush done if from the gut feeling of a user POV.  If that makes
sense, maybe we can do that sync before setting COMPLETED.

No matter which thread does that sync, it's still a pity that it'll go into
UNINTERRUPTIBLE during fdatasync(), then whoever wants to e.g. attach a gdb
onto it to have a look will also hang.

Thanks,

-- 
Peter Xu


