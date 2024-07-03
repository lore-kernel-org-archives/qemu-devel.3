Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2708C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 23:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8yF-0000o6-G7; Wed, 03 Jul 2024 19:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8yB-0000lD-3S
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 19:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8y9-0003ee-BM
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 19:00:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720047656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F+6ih40Pd9uCOaYpw+qIWMkjn2ZaTRWOnzxQu9Nl4YU=;
 b=OQChy6kk5GeuzEg9A8+isHU4ucI3qhMv1iW2/E3ocRIvAM67ivcBTAt/QpghPSOHt6bePr
 pwPEHuWoHyspBw3h34jhjlAI22pOlLeMATjlqlHbMuc0ZYT0DapFiSoBG7LVNEZXHFb+un
 nBwW5UhkBoAAqOj78huDXYgjefyM07E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-a8FS3n97NdOJve_pgRMVvQ-1; Wed, 03 Jul 2024 19:00:54 -0400
X-MC-Unique: a8FS3n97NdOJve_pgRMVvQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a725eed1cfeso1818666b.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 16:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720047652; x=1720652452;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F+6ih40Pd9uCOaYpw+qIWMkjn2ZaTRWOnzxQu9Nl4YU=;
 b=OKbThrRiXk3SRc0tG6rXhrigfxWc7IwCyQkxd8qzwfvvJVn/5zRhu9fYBvQVJGEzjC
 o10/Ryw4vevl6OEmBa+qkeYi5yDk61CTtptRzoPX6QXhKd0XiTCupLf9CaXMqrfKU3LM
 fTsV5a5iwrigLndfMo3CukTg3I44NghXZRTcK2sWM3SCvH5JpsEzrN4mMr2eVkPxVFHs
 Crc1m8gCJBN3Zf4NY83ZeUIv2MTrKGxFpL3OGzajOb23W6ks7/96LuBHAkY/z+e0PqDa
 5pr/AnSE+4vK1IBaJwBWrJ1scg2VX0jk40Nt2CiL3DBcpGFt2ajbt/CqB+S2cE+e6W6S
 I5yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUaI/+2ROREQdMUWCHKNmqtIOlaHhlCPTelE8X9rqua5FiXpsnCqdV7TxTYYIQGdSWcImHnrNP3xgzWKL13PGGaY4COG8=
X-Gm-Message-State: AOJu0YxFGzHig9I4YLeCZ3nxzp/2sjLNOq2QW27Yvok+R1+yCVCnbBHa
 ENm9f/8S14btbeXU1yWCSMk631RdxGhAisLG2uWgeL8Jap2cBTU51XUZqNjfjUALiyZJWXFL7TD
 dDqqkQ9WJbjzZIrRymjD7SmkRKmifXESaMittJZu8vsgH1hkTt6TP
X-Received: by 2002:a17:906:6452:b0:a77:aebc:8fad with SMTP id
 a640c23a62f3a-a77aebcbf2emr74930266b.1.1720047652664; 
 Wed, 03 Jul 2024 16:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+AFk/JP9Q2aIN11SdJSCvx4lTAhTMGH6GHkTcIri0bEBeAPmRSvV0OG/kvFk3gEEWnGEbHw==
X-Received: by 2002:a17:906:6452:b0:a77:aebc:8fad with SMTP id
 a640c23a62f3a-a77aebcbf2emr74928866b.1.1720047652068; 
 Wed, 03 Jul 2024 16:00:52 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf63909sm547587466b.77.2024.07.03.16.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 16:00:51 -0700 (PDT)
Date: Wed, 3 Jul 2024 19:00:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v2 00/88] virtio: features,fixes
Message-ID: <20240703185932-mutt-send-email-mst@kernel.org>
References: <cover.1719951168.git.mst@redhat.com>
 <f0961f6f-642c-4dc8-8bf3-1457f71da500@linaro.org>
 <20240703125101-mutt-send-email-mst@kernel.org>
 <d18ab076-47e4-4e8a-85d5-45f14f7b7e71@linaro.org>
 <54f9b0f4-d638-4273-935a-bb9bd129701b@redhat.com>
 <20240703162544-mutt-send-email-mst@kernel.org>
 <95648f85-d4b2-4ceb-bccf-888114e0fe03@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95648f85-d4b2-4ceb-bccf-888114e0fe03@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jul 03, 2024 at 03:37:43PM -0700, Richard Henderson wrote:
> On 7/3/24 13:26, Michael S. Tsirkin wrote:
> > On Wed, Jul 03, 2024 at 08:46:38PM +0200, Thomas Huth wrote:
> > > On 03/07/2024 19.01, Richard Henderson wrote:
> > > > On 7/3/24 09:51, Michael S. Tsirkin wrote:
> > > > > On Wed, Jul 03, 2024 at 09:31:45AM -0700, Richard Henderson wrote:
> > > > > > On 7/2/24 13:15, Michael S. Tsirkin wrote:
> > > > > > > The following changes since commit
> > > > > > > 1152a0414944f03231f3177207d379d58125890e:
> > > > > > > 
> > > > > > >      Merge tag 'pull-xen-20240701'
> > > > > > > ofhttps://xenbits.xen.org/git-http/people/aperard/qemu-dm
> > > > > > > into staging (2024-07-01 09:06:25 -0700)
> > > > > > > 
> > > > > > > are available in the Git repository at:
> > > > > > > 
> > > > > > >      https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> > > > > > > 
> > > > > > > for you to fetch changes up to 29e45afd8d6abf7a67dab5db0ab1cfbc388daefe:
> > > > > > > 
> > > > > > >      hw/pci: Replace -1 with UINT32_MAX for romsize
> > > > > > > (2024-07-02 11:27:19 -0400)
> > > > > > > 
> > > > > > > ----------------------------------------------------------------
> > > > > > > virtio: features,fixes
> > > > > > > 
> > > > > > > A bunch of improvements:
> > > > > > > - vhost dirty log is now only scanned once, not once per device
> > > > > > > - virtio and vhost now support VIRTIO_F_NOTIFICATION_DATA
> > > > > > > - cxl gained DCD emulation support
> > > > > > > - pvpanic gained shutdown support
> > > > > > > - beginning of patchset for Generic Port Affinity Structure
> > > > > > > - s3 support
> > > > > > > - friendlier error messages when boot fails on some illegal configs
> > > > > > > - for vhost-user, VHOST_USER_SET_LOG_BASE is now only sent once
> > > > > > > - vhost-user now works on any POSIX system
> > > > > > > - sr-iov VF setup code has been reworked significantly
> > > > > > > - new tests, particularly for risc-v ACPI
> > > > > > > - bugfixes
> > > > > > > 
> > > > > > > Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> > > > > > 
> > > > > > Fails testing:
> > > > > > 
> > > > > > https://gitlab.com/qemu-project/qemu/-/jobs/7257337667
> > > > > 
> > > > > Could you give me a hint how to trigger this in CI pls?
> > > > > All tests seem to pass when I push it to gitlab.
> > > > > Any special variables to set?
> > > > 
> > > > In CI, FreeBSD uses travis; I'm not sure what's involved.
> > > 
> > > s/travis/cirrus-ci/
> > > 
> > > See .gitlab-ci.d/cirrus/README.rst for information how to enable it in your
> > > private gitlab repo.
> > > 
> > > > I replicated it locally within a FreeBSD VM.
> > > > 
> > > > It should be reproducible with 'make vm-build-freebsd', but I think
> > > > that's more difficult to debug after the fact than a full vm.
> > > 
> > > Just use "make vm-build-freebsd DEBUG=1" and you should get a shell prompt
> > > for interactive debugging, so that's likely the best way to tackle such
> > > issues.
> > > 
> > >   HTH,
> > >    Thomas
> > 
> > Thanks!
> > As a side, is there some way to persist the stuff fetched over the
> > network so it does not happen each time I re-run make?
> 
> That's why I use a proper vm install of freebsd.
> 
> 
> r~

Anyway. This pull attempted to enable vhost user on freebsd,
and it looks like that's failing. So I just dropped the
patches enabling it for now.

-- 
MST


