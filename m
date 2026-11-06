Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304B606A329
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XAG1dyIM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=qHTdOUAY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPIzU-0005dc-Kl; Fri, 06 Nov 2026 07:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIyu-0005UW-Gh
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:23:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1xPIyr-00087y-Ig
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 07:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793967820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uu+cDuCorZz51VgUzDaApyZ78MqY5eiqcqx1CYytCsc=;
 b=XAG1dyIM/SggpdVjgvktUUxfZNt41tkp7li2oK/EcjzLkbwM1NR0dFnX/4CM4aEqgKJ/Nn
 ldY224BFEAWcStbyU0ZWxsVpFemLMrmiXO6Tx5YajN8m9Zhes6I8HAG1GuyksPi5dmpORB
 z/e6dV/RMG0tsRdgwuHoyxj9eI8W5Vc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Nl9YXE-XNH24cte8d6R0OQ-1; Fri, 06 Nov 2026 07:23:36 -0500
X-MC-Unique: Nl9YXE-XNH24cte8d6R0OQ-1
X-Mimecast-MFC-AGG-ID: Nl9YXE-XNH24cte8d6R0OQ_1793967816
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-490ab0a20ebso512225f8f.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 04:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793967815; x=1794572615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uu+cDuCorZz51VgUzDaApyZ78MqY5eiqcqx1CYytCsc=;
 b=qHTdOUAYxqK+HlvlWI1caVHn3n5TMQh8kLu4EnAE15qP8YAXeGx0iwYq4CDF12q7/m
 ETQWnnSRteMmpazwWfD7BfSQaBI+vDXDwBiTLTwAMkYcQ+D7wmKsFUOnEUclEMTH81ii
 701xCi33K+93bbcX0dmcG8/qiVhSmuqnOrNstC577/stYeAu84DlEQmJRSQOWEXxVvN6
 poUmEk8oUOoxCf5kAtwFoPQ2pW2ozWluj0E4hJBVmOFibRCYe22QaoHbJbF0g0EfzuqU
 bN0vW0hLbY4Pu+eXQZhC094e5YBVqn4MelELuhrngmcnWZpU+CbbnpY4HY21ECO2/DDq
 5FYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793967815; x=1794572615;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uu+cDuCorZz51VgUzDaApyZ78MqY5eiqcqx1CYytCsc=;
 b=k8dq5X5tkx5/aJkdtTelPnWXXgjydOhOd4E6p2hz669ozjtI4+OdY3IK76fAtfaudU
 2J31U5TpDpxy6sXNm8HhWmON0M0FWLs7XgzjxtMo7r7rCkQ+23h8KTyeOaNYt+EjhfFp
 cMFS/I39MpsE2gHvaXCwg8RYPyDZS9K+glmIFFfZPt4bvZdOe+9ADZjM+hvjB+tE71V/
 MpUaaGpOWHCg280hgZxoAJmn9Qak85vgy4WQ06VmZbW55d9mlXMy02kLIXuv0IhxWnat
 P8dRbqC+zgqS6cycg0R5y0yKIWlj+uPFQlVQjEEt1iWj5/mbiQSqUGekbhSv0Rr96yxN
 svQg==
X-Forwarded-Encrypted: i=1;
 AL+hErEFYwf4Xlx74cIwlf5I5uwxZZWYH3sDRwhpQKtsmS95VBDAF/Xpx1o3elf0wTOg/9z4X1dWZN+nmrwd@nongnu.org
X-Gm-Message-State: APuU4Z/8Aop7/9ArgjbSmn5WRo4bChriSBNv7IbkBRBbZog6avJgc77u
 ddua1vHDHXEZkcslIo5O4LawQmWWyKqi+VJ8q4lljgYrimuUfh4y9wVVBRqi/XbdmjWGglDv+vc
 TNZgpvn7cQOv5ncFVgpHtNyhX65tKPy9Dc47hc3RssZct+5b0phP4pKrV
X-Gm-Gg: AYBFou2k/Bw1EAnEszxGJiP5APKThLa/lvWyXaFPwzEAGV/gsBnGABCI0fh2LL9oIOF
 OkbEEs+QMi0i5ZplscEnwRykTNCjTwXdAw3QGVkx5vzPoeLCkR/biHSc7papCAtQYPIvzCyj72k
 /89nQpEMKkWKFKdfgATxtdHWLKGjyjALaLnLwoti49psgeLar61Yy/DEk6g43OMfZ61NSDAoe3k
 6wYhXDjiXz66BKeFh+UBaRKy3NKNsfLopeFMOIfMIMh6y3AY9utNClJGSFmPkvrWG19S6veapmg
 H66omxaiDFvkbC4tN+x450f70s520I3yVSrHkL1IT2XRHa4RKVVb7EOAEx9QlMRjeKCBMeKNI2v
 QTpWN9XAwl26/6oyFN43LTLeK1+RwrV5HG7Yp55D4u126HManEWTGKVIevm6lvGcEFUloFqo=
X-Received: by 2002:a05:6000:310a:b0:48e:5444:a1d3 with SMTP id
 ffacd0b85a97d-4927e553b25mr3926406f8f.11.1793967815264; 
 Fri, 06 Nov 2026 04:23:35 -0800 (PST)
X-Received: by 2002:a05:6000:310a:b0:48e:5444:a1d3 with SMTP id
 ffacd0b85a97d-4927e553b25mr3926359f8f.11.1793967814842; 
 Fri, 06 Nov 2026 04:23:34 -0800 (PST)
Received: from ?IPV6:2a01:599:b03:7322:436f:1f3:b26e:91b8?
 ([2a01:599:b03:7322:436f:1f3:b26e:91b8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7233297sm3590478f8f.27.2026.11.06.04.23.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 04:23:34 -0800 (PST)
Message-ID: <31bf0fb1-06fa-4bae-8b22-853f80548f9e@redhat.com>
Date: Fri, 6 Nov 2026 13:23:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/28] hw/display: mark cirrus and QXL as secure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-28-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20261029131241.2275706-28-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> Most of the display adapters are emulating old hardware which is not
> relevant to virtualization use cases. The previous commit added the
> generic, simple devices.
> 
> This proposes two further devices based on their historical widespread
> usage in virtualization use cases.
> 
> Cirrus (PCI, not ISA) was the recommended default for x86 for an
> incredibly long time and while it is now discouraged, it is likely
> to still be in common use.
> 
> QXL was the recommended default to be used with SPICE, which is designed
> to service virtualization use cases and is still commonly shipped by
> many distros and often used by default in mgmt apps still.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/display/cirrus_vga.c | 1 +
>   hw/display/qxl.c        | 2 ++
>   2 files changed, 3 insertions(+)
> 
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 0a8c74e1374..8232c5c4687 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -3013,6 +3013,7 @@ static const TypeInfo cirrus_vga_info = {
>       .parent        = TYPE_PCI_DEVICE,
>       .instance_size = sizeof(PCICirrusVGAState),
>       .class_init    = cirrus_vga_class_init,
> +    .secure        = true,
>       .interfaces = (const InterfaceInfo[]) {
>           { INTERFACE_CONVENTIONAL_PCI_DEVICE },
>           { },
Considering that the cirrus card also had a bunch of security-related bugs 
already and nobody is really in the mood of maintaining this anymore, I'd 
rather not mark this as secure. I'd recommend to rather drop this patch.

With regards to qxl, maybe better also omit this for now 'til we've got a 
proper maintainer for this again.

  Thomas


