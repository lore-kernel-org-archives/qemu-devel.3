Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD418C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 10:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY25u-00041N-1s; Thu, 08 Feb 2024 05:57:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rY25s-00040a-5O
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:57:24 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rY25p-0008MB-M4
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 05:57:23 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33b58ca0b95so274024f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 02:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707389838; x=1707994638; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/dw+xWqFYmUkuRfQ2nFPqLvzYy5Cx+uLxeoDYgsKfeA=;
 b=RpS2glSSUznNmB5EjD+WyH3NndZeb2hDNeCZ/ABKJ1C3UfrVm1Rt0LClwsvoWQm6+O
 GGajlJje/SeHYsA3MCH0crkZ03BxUQLax/yi1goMQbG9T/roXW0ZLCTW1/4K9xrSL/i+
 E/5tzqzP9YEKK1p1gZieETdT6N6wHDq6KgqrDTxVLxIOUJekkUqVTm6ea/hgKYz4juJD
 PtySW+8I90TMG/NPL6VKn4+3X4XWU+pz3nFDokOMofZZxt0UL09PBROEJ7+A+KgSyYnS
 umtgbEYqzZ0go77ogpCYN5Egn667CIM6OAInZbh2SvcoXNtlGn33qKKi2jy3ADr2JsdI
 7NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707389838; x=1707994638;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dw+xWqFYmUkuRfQ2nFPqLvzYy5Cx+uLxeoDYgsKfeA=;
 b=m1xWv15ZlHm2h/lN98fuhDwas4FL0UUkNsro70Rzs1+nvXVKa/s8jnAQKCB7XLFs8p
 f4BsJHwZYFhdXcFanT8Qkn2oLXuWiXbU0Kg9hQDsyKD7rbqqP4whpt3vCV72/NMzjtxX
 0iEjQO6/nx30cudmqylNls52EdqzVoFl+7ohMJxxQq+f/YGs8wCVfCCtKlJM14y83xc2
 eOV9/JETqMgJNX0dy61R/LaL+l/3FmdQEsuuyt4jd/iqsyuE5MDliZfxytMg71FU6X7j
 +ux0pVH9R4m+7GTGFzFJaCkjHxvWUqZb0QfH0gyYX3QGWbhSI6SSFdVCSD30YjzIcom0
 QSbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPw+5R6Sk9mvNq5xJbWP/cBLKWeb/axfFTQWqOF324Z6lbtkOPP6UHf7/kl7F+KmR1+rmoEnXLEtCKyf8irwFru20x2U4=
X-Gm-Message-State: AOJu0YwcWpE/YADk+XMuzzRkaZeaBU1pwswQ/BjY/m4fouRHI3pEAkMZ
 ok/R58VbFzCTsi0d95zmrBcIPOW3vgg7Hio6OeHcjvcA4KaNBA4X7f5E8pXhdCI=
X-Google-Smtp-Source: AGHT+IHHVfwzOBDvnsI4PytMOt+cR80CTzeO4WpGMtlso/YCEAkeScLQVx3hxvTL+3IXrNstvaiKSw==
X-Received: by 2002:a5d:4247:0:b0:33b:26e3:3587 with SMTP id
 s7-20020a5d4247000000b0033b26e33587mr4305290wrr.21.1707389838008; 
 Thu, 08 Feb 2024 02:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWoVMu7gtcdUhmriI/xYSLKOd380NLKmOvHcrMPpzNY0A4a/MFDSFPqfDA+3rkiWjMeqsaIE5MZEtOhyxJ6PaKKpJlwNiSJPH6YvY55IavQH2xT+CxCb/bxY37ayb5LOPUf6J3WF5jItPVmWofSlqYN9EjJlp40jFebsomq0ye87O5P44uEy1OQkYpdLXwkd1PHHPqwix8XQJ6/8fevfPZZqnPNV/hkJlOXe/oVTF+6MS5pic8NDpZ1/BjGxOnEmlVlnfyeH3uulfiFUzVxlrFF37ODkFsV5wdKZYx/mHeYF/WOPUYp1DFzhW9EnibJU4gRr0Fn
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 e37-20020a5d5965000000b0033b4f82b301sm3006911wri.3.2024.02.08.02.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Feb 2024 02:57:17 -0800 (PST)
Date: Thu, 8 Feb 2024 10:57:11 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, peter.maydell@linaro.org,
 zhenzhong.duan@intel.com, yanghliu@redhat.com, mst@redhat.com,
 clg@redhat.com, jasowang@redhat.com
Subject: Re: [PATCH v2 1/3] virtio-iommu: Add an option to define the input
 range width
Message-ID: <20240208105711.GA2737746@myrica>
References: <20240201163324.564525-1-eric.auger@redhat.com>
 <20240201163324.564525-2-eric.auger@redhat.com>
 <20240205101322.GA2086490@myrica>
 <1790d917-9360-4ce4-b1ad-aba9b72bc418@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1790d917-9360-4ce4-b1ad-aba9b72bc418@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Feb 08, 2024 at 09:16:35AM +0100, Eric Auger wrote:
> >> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> >> index ec2ba11d1d..7870bdbeee 100644
> >> --- a/hw/virtio/virtio-iommu.c
> >> +++ b/hw/virtio/virtio-iommu.c
> >> @@ -1314,7 +1314,11 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> >>       */
> >>      s->config.bypass = s->boot_bypass;
> >>      s->config.page_size_mask = qemu_real_host_page_mask();
> >> -    s->config.input_range.end = UINT64_MAX;
> >> +    if (s->aw_bits < 32 || s->aw_bits > 64) {
> > I'm wondering if we should lower this to 16 bits, just to support all
> > possible host SMMU configurations (the smallest address space configurable
> > with T0SZ is 25-bit, or 16-bit with the STT extension).
> Is it a valid use case case to assign host devices protected by
> virtio-iommu with a physical SMMU featuring Small Translation Table?

Probably not, I'm guessing STT is for tiny embedded implementations where
QEMU or even virtualization is not a use case. But because smaller mobile
platforms now implement SMMUv3, using smaller IOVA spaces and thus fewer
page tables can be beneficial. One use case I have in mind is android with
pKVM, each app has its own VM, and devices can be partitioned into lots of
address spaces with PASID, so you can save a lot of memory and table-walk
time by shrinking those address space. But that particular case will use
crosvm so isn't relevant here, it's only an example.

Mainly I was concerned that if the Linux driver decides to allow
configuring smaller address spaces (maybe a linux cmdline option), then
using a architectural limit here would be a safe bet that things can still
work. But we can always change it in a later version, or implement finer
controls (ideally the guest driver would configure the VA size in ATTACH).

> It leaves 64kB IOVA space only. Besides in the spec, it is wriiten the
> min T0SZ can even be 12.
> 
> "The minimum valid value is 16 unless all of the following also hold, in
> which case the minimum permitted
> value is 12:
> – SMMUv3.1 or later is supported.
> – SMMU_IDR5.VAX indicates support for 52-bit Vas.
> – The corresponding CD.TGx selects a 64KB granule.
> "

Yes that's confusing because va_size = 64 - T0SZ, so T0SZ=12 actually
describes the largest address size, 52.

> 
> At the moment I would prefer to stick to the limit suggested by Alex
> which looks also sensible for other archs whereas 16 doesn't.

Agreed, it should be sufficient.

Thanks,
Jean

