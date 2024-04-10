Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25785CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 11:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruVqg-0003Dy-L6; Wed, 10 Apr 2024 07:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruVqc-00037p-N6
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:10:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ruVqa-0000DG-Py
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 07:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712747430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F413NOHpFMsWFYZVQhFkCG84TJ77ku5or7fivJuTfgw=;
 b=biDJw3zlknW4f1z/P4R9VW07aoFC4ZBK4+D2ZZaOeaJ3x2CdUWm12p7GWmM3SxrRkf4x5P
 dJEMAOqzzjZQTtAMDuW/b4mFEPs2+riflmNurze3n7DOBvPUBF1ldjCO7SyyjZZ/c+JxZX
 Q8dJ7yaSICNDvx3JbkCuOKZFItKQhck=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-6X4KMnV7OEWkd_d_aFYWfg-1; Wed, 10 Apr 2024 07:10:28 -0400
X-MC-Unique: 6X4KMnV7OEWkd_d_aFYWfg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a5198c1a6f4so318540666b.3
 for <qemu-devel@nongnu.org>; Wed, 10 Apr 2024 04:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747427; x=1713352227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F413NOHpFMsWFYZVQhFkCG84TJ77ku5or7fivJuTfgw=;
 b=xBFrmMqlSlJqeIqaZ6+0BWhbrBaaUQaO8oCF1Wz8r5muKmqrKZMyCRGXoCHBzRmoQp
 JLrMu8YSHHjeVFmbu4GPugWBynvX+6Z7IioMYfDmfbWVa4KmHBfejOVrclYYtF8Dmq50
 APodM9MrSLeFNNIv8er/1Tf1OpZk6ZlE9aCKXibwKPzG/5YO7afUCcFtCPLdGBZHn4w1
 ZO4YQ+69UEc9PxmiIe3Mu5S9++GZokf/ozCpHIc/Dzg681k59sdbY7yBHv57qc1YEJOI
 yZbnBQ+1UTg19WNjjgSHhXUFW9Mppne4BgGX2+8HacvdmwSFgrwuZ77FP4rT36Vc/aLg
 /ysg==
X-Gm-Message-State: AOJu0YwHuqwnKgP3xVtvmKeTA9dNR6Gdg5BLrlvgLy4uW23f0GjjAHlV
 +j7Dl3fZ29DwQ5c2V9cug9YnnChYq44ahu3T8LQvqg8jFSfinCUpDBuZHvc5f0jQLSqkdHC1ubH
 qIl746QTJihztXBLjFAFl10af9XXmMTEjKtxvscFwsmhdfd9JK2gs
X-Received: by 2002:a17:906:cb9a:b0:a51:cab2:e55d with SMTP id
 mf26-20020a170906cb9a00b00a51cab2e55dmr1431836ejb.15.1712747427359; 
 Wed, 10 Apr 2024 04:10:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyTlEiwOzdCDRt4eXQrgkHvjufXiRIHFk8ltFVs8TZo4SJk3Abao7PNu+uIGoNivJWAu98nw==
X-Received: by 2002:a17:906:cb9a:b0:a51:cab2:e55d with SMTP id
 mf26-20020a170906cb9a00b00a51cab2e55dmr1431814ejb.15.1712747426854; 
 Wed, 10 Apr 2024 04:10:26 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:8bde:8cd:63ff:6fae:3872])
 by smtp.gmail.com with ESMTPSA id
 qy1-20020a170907688100b00a51a8d91397sm6561799ejc.73.2024.04.10.04.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Apr 2024 04:10:26 -0700 (PDT)
Date: Wed, 10 Apr 2024 07:10:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Daniel Berrange <berrange@redhat.com>, Cole Robinson <crobinso@redhat.com>
Subject: Re: secure boot & direct kernel load (was: Re: [PATCH] x86/loader:
 only patch linux kernels)
Message-ID: <20240410070801-mutt-send-email-mst@kernel.org>
References: <20240410072126.617063-1-kraxel@redhat.com>
 <20240410032448-mutt-send-email-mst@kernel.org>
 <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p4ifsoadheo2phszidswkl63ttt6wkq4luxk55gtlteaz6umpk@mb4gmtrrx3tt>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Apr 10, 2024 at 12:35:13PM +0200, Gerd Hoffmann wrote:
> On Wed, Apr 10, 2024 at 03:26:29AM -0400, Michael S. Tsirkin wrote:
> > On Wed, Apr 10, 2024 at 09:21:26AM +0200, Gerd Hoffmann wrote:
> > > If the binary loaded via -kernel is *not* a linux kernel (in which
> > > case protocol == 0), do not patch the linux kernel header fields.
> > > 
> > > It's (a) pointless and (b) might break binaries by random patching
> > > and (c) changes the binary hash which in turn breaks secure boot
> > > verification.
> > > 
> > > Background: OVMF happily loads and runs not only linux kernels but
> > > any efi binary via direct kernel boot.
> > > 
> > > Note: Breaking the secure boot verification is a problem for linux
> > > kernels too, but fixed that is left for another day ...
> > 
> > Um we kind of care about Linux ;)
> > 
> > What's the plan?  I suspect we should just add a command line flag
> > to skip patching? And once we do that, it seems safer to just
> > always rely on the flag?
> 
> Well, there are more problems to solve here than just the patching.  So
> lets have a look at the bigger picture before discussion the details ...
> 
> [ Cc'ing Daniel + Cole ]
> 
> Current state of affairs is that OVMF supports two ways to boot a linux
> kernel:
> 
>  (1) Just load it as EFI binary and boot via linux kernel EFI stub,
>      which is the modern way to load a linux kernel (which is why you
>      can boot not only linux kernels but any efi binary).
> 
>  (2) Use the old EFI handover protocol.  Which is the RHEL-6 era way to
>      boot a linux kernel on EFI.
> 
> For method (1) secure boot verification must pass.  For (2) not.  So if
> you try to use direct kernel boot with secure boot enabled OVMF will
> first try (1), which will fail, then go fallback to (2).
> 
> The reason for the failure is not only the patching, but also the fact
> that the linux kernel is typically verified by shim.efi (and the distro
> keys compiled into the binary) instead of the firmware.
> 
> Going though (2) is not ideal for multiple reasons, so we need some
> strategy how we'll go handle direct kernel load with uefi and secure
> boot in a way that (1) works.
> 
> Options I see:
> 
>   (a) Stop using direct kernel boot, let virt-install & other tools
>       create vfat boot media with shim+kernel+initrd instead.
> 
>   (b) Enroll the distro signing keys in the efi variable store, so
>       booting the kernel without shim.efi works.
> 
>   (c) Add support for loading shim to qemu (and ovmf), for example
>       with a new '-shim' command line option which stores shim.efi
>       in some new fw_cfg file.
> 
> (b) + (c) both require a fix for the patching issue.  The options
> I see here are:
> 
>   (A) Move the patching from qemu to the linuxboot option rom.
>       Strictly speaking it belongs there anyway.  It doesn't look
>       that easy though, for qemu it is easier to gather all
>       information needed ...
> 
>   (B) Provide both patched and unpatched setup header, so the
>       guest can choose what it needs.
> 
>   (C) When implementing (c) above we can piggyback on the -shim
>       switch and skip patching in case it is present.
> 
>   (D) Add a flag to skip the patching.
> 
> Comments?  Other/better ideas?
> 
> take care,
>   Gerd

So if you didn't decide whether to do b or c then I guess D is
easiest and covers both cases?

-- 
MST


