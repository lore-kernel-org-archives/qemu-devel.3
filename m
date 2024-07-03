Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014B0C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 19:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP5vW-0005J6-8J; Wed, 03 Jul 2024 15:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP5vU-0005Ir-Qk
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:46:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP5vS-0008Vx-OJ
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 15:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720035958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jkfJgJdQyPpR/uKMkszX457QIseL5l5oOCR+b9FS7WI=;
 b=SLxRRJFpTUkR3FckzPkZwM1XqdEP8+UH91zsAiSLKhHcAR3Qx750/GN97Vpvk9v/XYZIRP
 cjYcR3r98+d+aP/vVZX6pD107GcwoXbVx+cGwzkG4M2L4ab5QXrXSuZ3qei/ldEMF0PIuq
 hH1BkK2u84iC6mhGhgVLKSrM0Gbm6rM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-pGAU_xVzMmSi2-OS2btLpQ-1; Wed, 03 Jul 2024 15:45:56 -0400
X-MC-Unique: pGAU_xVzMmSi2-OS2btLpQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-425685183edso45675275e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 12:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720035954; x=1720640754;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jkfJgJdQyPpR/uKMkszX457QIseL5l5oOCR+b9FS7WI=;
 b=HzNcgFUT0F7AgrFlruY1kAis1N1OxPoEfeFLmXLPTzqDNgT+3caDyYoOYokbETskgn
 KQy6NPzLPmacFbzJ+iQYTMGzmKfs7luQRTmw6jE6ck4PTyqZ4FTKV3CjTVfsOt4gF2LG
 dTiaaNxOS/myAM74NnpvOsu+WoCAbwEJNojDGu9ZjH0AtBOEUIR7EyW2446++7fgqkfe
 jpO2WfTopb1vVAwDjcG44zwVcg1pDpOdAYrTupOPWl9gHgDWjGz2jvCZvAaLbUwluh4P
 RY4BNi/JMiQlX7LXcKk8NkvdVYMJ/P6b//dK6l2hsLJ3zTWHTGwURyHPYvh4nwqq+9q/
 E3mA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnutPRcfa/M4ovLiCDwiKeKSWtX2/QG2R8dV+5OZm+09Rgjtt9wbzI+DcyJ0ttenPRfqococZFc6eJ8qsHBTnmpTomMrc=
X-Gm-Message-State: AOJu0YzSndDe54ty9K4G1JkxWOwGBcKkeEBJZ/1V+JccWYkztwDNz+3d
 uWMNAfK/uqkd2hRZNcpE+SLGHLivt/PW2Bm0utrjPBDar6zlainW2aQoXE00emaOxfx+Rg8Z9do
 n4oLhR78mJEzl7qZZ2UK+y4DaO7VQPrVl/9G+XHPjjliH1Kl5+y0D
X-Received: by 2002:adf:ff8f:0:b0:367:9791:2939 with SMTP id
 ffacd0b85a97d-36797912a1amr965156f8f.21.1720035954624; 
 Wed, 03 Jul 2024 12:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpk/lS4KurhEIFDv5trwsO7NSGrOgKFLIfed+Jub5vbUnoXaY4xesk/afCLEY/dcEOqD7DSA==
X-Received: by 2002:adf:ff8f:0:b0:367:9791:2939 with SMTP id
 ffacd0b85a97d-36797912a1amr965141f8f.21.1720035953638; 
 Wed, 03 Jul 2024 12:45:53 -0700 (PDT)
Received: from redhat.com ([31.187.78.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a10337csm16569208f8f.97.2024.07.03.12.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 12:45:53 -0700 (PDT)
Date: Wed, 3 Jul 2024 15:45:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/88] virtio: features,fixes
Message-ID: <20240703154436-mutt-send-email-mst@kernel.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
 <20240703125101-mutt-send-email-mst@kernel.org>
 <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
 <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jul 03, 2024 at 08:46:38PM +0200, Thomas Huth wrote:
> On 03/07/2024 19.01, Richard Henderson wrote:
> > On 7/3/24 09:51, Michael S. Tsirkin wrote:
> > > On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
> > > > On 7/2/24 13:15, Michael S. Tsirkin wrote:
> > > > > The following changes since commit
> > > > > 1152a0414944f03231f3177207d379d58125890e:
> > > > > 
> > > > >     Merge tag 'pull-xen-20240701'
> > > > > ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm 
> > > > > into staging (2024-07-01 09:06:25 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> > > > > 
> > > > > for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
> > > > > 
> > > > >     hw/pci: Replace -1 with UINT32_MAX for romsize
> > > > > (2024-07-02 11:27:19 -0400)
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > virtio: features,fixes
> > > > > 
> > > > > A bunch of improvements:
> > > > > - vhost dirty log is now only scanned once, not once per device
> > > > > - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> > > > > - cxl gained DCD emulation support
> > > > > - pvpanic gained shutdown support
> > > > > - beginning of patchset for Generic Port Affinity Structure
> > > > > - s3 support
> > > > > - friendlier error messages when boot fails on some illegal configs
> > > > > - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
> > > > > - vhost-user now works on any POSIX system
> > > > > - sr-iov VF setup code has been reworked significantly
> > > > > - new tests, particularly for risc-v ACPI
> > > > > - bugfixes
> > > > > 
> > > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > 
> > > > Fails testing:
> > > > 
> > > > https://gitlab.com/qemu-project/qemu/-/jobs/7257337667
> > > 
> > > Could you give me a hint how to trigger this in CI pls?
> > > All tests seem to pass when I push it to gitlab.
> > > Any special variables to set?
> > 
> > In CI, FreeBSD uses travis; I'm not sure what's involved.
> 
> s/travis/cirrus-ci/
> 
> See .gitlab-ci.d/cirrus/README.rst for information how to enable it in your
> private gitlab repo.
> 
> > I replicated it locally within a FreeBSD VM.
> > 
> > It should be reproducible with 'make vm-build-freebsd', but I think
> > that's more difficult to debug after the fact than a full vm.
> 
> Just use "make vm-build-freebsd DEBUG=1" and you should get a shell prompt
> for interactive debugging, so that's likely the best way to tackle such
> issues.
> 
>  HTH,
>   Thomas

Well 1st failure had to do with inabilit to find qemu-img.
Which I guess should be used from build directory really?

After adding that to path for now, it crashes with:

./scripts/archive-source.sh: line 55: meson: command not found


Would appreciate some help here.


