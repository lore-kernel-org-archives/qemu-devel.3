Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EE8CA6CBC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 09:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkfNk-0002Ji-NG; Tue, 27 Jan 2026 04:29:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1vkfNj-0002FS-2Z
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:29:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1vkfNg-0004Fl-CE
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 04:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769506142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G5bG6PKsqEtorcKsG2IjxGd9y3gQfMI+PkhENIjujEs=;
 b=fOsmoMwbUXmkQLUmnVrlIjSgf6iy4XxTjjisMFJqLnxMzbNq0KVk6XnxBVIEmIkhRCDMpJ
 rEki+2AQIKEUwYiv7LhVZALaiqe6FjflFE4pDRVii0OIDgAiBjlXv4c5nV7k2Pm9LSSGAj
 BWKuiGAbLjenejc33beGuCquPCoVJHw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-OZnSyXeCMOerffniC8X1CQ-1; Tue, 27 Jan 2026 04:27:39 -0500
X-MC-Unique: OZnSyXeCMOerffniC8X1CQ-1
X-Mimecast-MFC-AGG-ID: OZnSyXeCMOerffniC8X1CQ_1769506059
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4801bceb317so57348345e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769506058; x=1770110858; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G5bG6PKsqEtorcKsG2IjxGd9y3gQfMI+PkhENIjujEs=;
 b=rGUBPovx8T4eqeI4COVgO9Eo4wWXBQC+6omHyntNx9GLEq+t06FWxC7FRqDsASfk7k
 wbybN9M+dKVgQsWiv5RnxvFgzLlS9TyoZzGoT64hUI5D0jBFQUvOQN8nvoKd28Eubn9C
 iuqgLuEP6oNtHkIuWCMgrlYY4iNAOv24c0frAb09clPE2ArDbcmDG+NtOt9/2TNoYOvG
 wmI0HlmTJW6bVpwanvTAXlzlAvdyKV/xMHzMdDbm9bRCOsXi/zC8m2wOqOuui2zf8xom
 AFI0GO1ewg9odf3jb4eaSe8x3Mi40sE1vw/72JtMaU/3UAMKrLRldNia6uZf0w+NPQB0
 yfZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769506058; x=1770110858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5bG6PKsqEtorcKsG2IjxGd9y3gQfMI+PkhENIjujEs=;
 b=OclPsQupDemirjoSF6ilHdSqSDtdXh7ylvJedWx2c3rEQvDwwYwWt+iwIKGjONqkvc
 t+NgUMvzNybFEKBm7Gj6KY9Hdktvom5ht22b8oybhFZ7K21Y4YN097jrbnk1q6YsYPrh
 e2lwzi8Thw8pC/HWHpGIlmc12RWJu8p7/PcCk8YGfKHbD6/bMZIh1NHjP8IVX1FA6s1s
 LBnNIpHbTOwwu197eZxWhPVfo2GNjbSQed4C8OrOiF+WCDgdiJo3vmk2vVeD/5G6CcjH
 HT1QxcqoZWBvwWlVlNGG28v7mKmAeb2V3Alk1GMsv6GuhxLKJ3Jf+Htn26yYpsm7pu1/
 yA1g==
X-Gm-Message-State: AOJu0YwHWf0cuoUBkeDS1K7uQniYC5L+24BEsZNXBwaRXlREn7rCrLqJ
 SRO1eZ3rpKBOYxf0Ge9ViWeD3HtLmOT2fqiDuTuSCjpdzDzgaSPCn1kOvhwS9eTUeQn3NHUGkVj
 O/sCrSy18NFZP/jt6/1p5EKDbINzBRPOdvT8AL3s6EYbWdxSGre9mADcR
X-Gm-Gg: AZuq6aLtdPBrcNe4do2cDAkENhd1SxCPRnRs0EDz8qla7nvszXUgCKma4Vuur21nA76
 oC8922rpRnMyXYEzvRx/XO2ZkghhiMvdMYuwZgRKsOZ7mZyWBqU17yZBgk6eTbsXTphXxXH2arQ
 X7hRQf1IDCE/Hgk7favAUjb9ffpNv9R2zP9FFdO7pbFWY0xsirXqtT5kzsqHuqYdHx0fYOD4uNn
 MhCWN8tBcwg8VVEWPzFaNPyj6R9HZBs9A3h3cR7lcXYSYRIrNi+XS1DtzxwcRqdQZ0uylqQmKgt
 EESOgUcKqLMHM0PMtLVN4/MGfPNiFj1afZKYDhX7gT1zvoaYp0Lc3B92mQeoGAo+Cr0O6E3bSLI
 +uLg=
X-Received: by 2002:a05:600c:8b24:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-48069c20e88mr15110065e9.10.1769506058542; 
 Tue, 27 Jan 2026 01:27:38 -0800 (PST)
X-Received: by 2002:a05:600c:8b24:b0:477:5c58:3d42 with SMTP id
 5b1f17b1804b1-48069c20e88mr15109675e9.10.1769506058129; 
 Tue, 27 Jan 2026 01:27:38 -0800 (PST)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066be7623sm47204815e9.2.2026.01.27.01.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 01:27:37 -0800 (PST)
Date: Tue, 27 Jan 2026 10:27:35 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 German Maglione <gmaglione@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francesco Valla <francesco@valla.it>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aXiFBwcLg4PQ/4m7@fedora>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 05, 2026 at 04:47:22PM -0500, Stefan Hajnoczi wrote:
> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code internship
> program again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email by
> January 30th.
> 

Hello,

We came up with the following idea.

Thanks.

=== virtio-rtc vhost-user device ===

'''Summary:''' Implement virtio-rtc device as a vhost-device-user

Implement virtio-rtc device using the vhost-user-device framework.

The goal of this project is to implement a virtio-rtc device as a
vhost-user-device. At the moment, there is no open implementation of a
virtio-rtc device, even though a virtio-rtc driver exists and appears to
be tested against a closed device implementation. This project aims to
fill that gap by providing a fully open and spec-aligned device.

The virtio-rtc device provides access to real-time clocks, such as UTC
or TAI, or physical time elapsed since a given epoch. The driver can
read the time using simple or more accurate methods and may optionally
set an alarm.

The work starts with understanding the virtio-rtc device as described in
the virtio specification, as well as studying the existing virtio-rtc
driver. In parallel, an existing vhost-user-device implementation can be
used as a reference to design and write the new device. The device will
be implemented in Rust and must follow the virtio specification closely.

The project also includes debugging interoperability issues, identifying
possible mismatches between the driver and the specification, and
submitting the final implementation to the vhost-device project.

High-level tasks:
- Study the virtio-rtc specification and understand the existing
  virtio-rtc driver. Also, it may help study the QEMU implementation of
  the rtc clock.
- Design and implement the virtio-rtc device as a vhost-user-device in
  Rust. Existing vhost-user-devices may help to get inspiration. This
  step also requires adding the glue code in QEMU to support this
  device.
- Build and test the virtio-rtc driver.
- Test, debug, and submit the new device to the vhost-device project.

'''Links:'''
* Linux Driver Series:
  https://lore.kernel.org/all/20250509160734.1772-1-quic_philber@quicinc.com/
* vhost-device repo: https://github.com/rust-vmm/vhost-device
* VirtIO 1.4 specification:
  https://github.com/oasis-tcs/virtio-spec/tree/virtio-1.4/device-types/rtc

'''Details:'''
* Skill level: intermediate
* Language: C/Rust
* Mentors: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
  Francesco Valla <francesco@valla.it> and Stefano Garzarella
  <garzare@redhat.com>


