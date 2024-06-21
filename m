Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715C2C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 15:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfuJ-0001T0-MB; Fri, 21 Jun 2024 11:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKfuI-0001RM-9F
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:10:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sKfuG-0006be-LZ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 11:10:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718982626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iMYmzjgs7RmHyOURu6YCe8vw2SxfQYn3c8nnORIrf/E=;
 b=fxMH8JKxk+C+/C4CiwDGVQX5xm+5a57MJcuprdAM9tdBJ7oJRBtdq7SvYfgedZea19TVGe
 /WNB3reYhgYKjdYThESyeBaZpTLi87DgmA4DYvWT6htH0mo5bxjpGX1bMYQETC+0Wzkbl0
 pirHeZUA63fLpePSvSaoSv64hMNExSg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-2ioH6Iy_Oa2Bwd9Us1w1NA-1; Fri, 21 Jun 2024 11:10:25 -0400
X-MC-Unique: 2ioH6Iy_Oa2Bwd9Us1w1NA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-422a0f21366so18255865e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718982624; x=1719587424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iMYmzjgs7RmHyOURu6YCe8vw2SxfQYn3c8nnORIrf/E=;
 b=APim1jpsmOH7KkjoDFEuYC5Qj0zpf/DbgGXnm5L6QM4lyVGqrn+8p7mAwODdoRAsSx
 Cq/3qI8S4hPeqzZvta5X7oV/MLFufUu6KTwWgDflWspLDDQQ2X+TaRgyyHQOGod+pjst
 KlWEPBN0W9KYYQQKYPyzo9CfKcpIRQlNPNjDd/fMHPOSdrAiu/Y+7yo+QNJqMzVR1NEP
 5qK5+rOipajVwXUYMn49FdicZFK6hf1FjITvX7uhZz+xU4dTWf34tMrE6lWMV0MWnJ4I
 BhGE/DqhJKN6JlCVCHaYPCNxZ1okgXudG11NIsX8/1gscEUunzapnAvHT7KLh49bKk6y
 eeJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPWQiDluh0Z1f5/8gxc/ou6TmVe7ckfaXrMICyp/hz+0agzKawB3+ubi8FYKgTwAhN2LP6Wp2ZBFpcv3EbdPOmOMRev80=
X-Gm-Message-State: AOJu0Yx1bjN3CJmSkJtgVoDydO5vWbSWBSps5xVk2TS/CXJSRMS5R7Jx
 YHR4tp1z2YOtleUBTN3yK+gCivw8VnbSUY0wMlDHvrAwhH6fPyD2Xkf+2Se/fI5wst7EQgojIJs
 Pi4xftjqdJo2kAaS3j8rZuxw2uo7nO/3k2jGB7Ga45/Xqfb4qpjAE
X-Received: by 2002:a05:600c:1d17:b0:424:760d:75cb with SMTP id
 5b1f17b1804b1-424760d7767mr67246195e9.6.1718982623893; 
 Fri, 21 Jun 2024 08:10:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQPTV8pIpuWdodSx1+f0pF0sCFePiY+rpFiVpNANym5TqpmkYd5S9MpDBmxLNGFT3knEYuFQ==
X-Received: by 2002:a05:600c:1d17:b0:424:760d:75cb with SMTP id
 5b1f17b1804b1-424760d7767mr67246025e9.6.1718982623534; 
 Fri, 21 Jun 2024 08:10:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424817a9667sm30826815e9.15.2024.06.21.08.10.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jun 2024 08:10:23 -0700 (PDT)
Message-ID: <449a8a0a-6149-45af-bfa0-bf7fb29e27c6@redhat.com>
Date: Fri, 21 Jun 2024 17:10:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, harshpb@linux.ibm.com,
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, zhenzhong.duan@intel.com,
 qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
 <11578ca8-2bb3-4504-b7b9-022c1df65942@redhat.com>
 <cef472a4-da2c-449e-8f76-0b3e9105e194@linux.ibm.com>
 <ba376f81-2175-4e3d-bda0-4b08b2ae5158@redhat.com>
 <7b553db9-4d29-4cfe-8874-3c87ad862c74@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <7b553db9-4d29-4cfe-8874-3c87ad862c74@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

On 6/21/24 4:47 PM, Shivaprasad G Bhat wrote:
> 
> On 6/21/24 2:19 PM, Cédric Le Goater wrote:
>>
>> Could you please describe the host/guest OS, hypervisor, processor
>> and adapter ?
>>
> Here is the environment info,
> 
> 
> pSeries:
> 
> Host : Power10 PowerVM  Lpar
> 
> Kernel: Upstream 6.10.0-rc4 + VFIO fixes posted at 171810893836.1721.2640631616827396553.stgit@linux.ibm.com

Great. You should report there too and probably send a PR to Alex to
contribute your changes to the vfio tests.

> Hypervisor : KVM on PowerVM & 

OK. So, this is using the newer nested v2 implementation. With the
legacy XICS IRQ controller or XIVE ? in-kernel device or emulated ?

> also tried without KVM using TCG

Ah nice. Good to know that real HW passthrough works in TCG also.

> Guest : 6.8.5-301.fc40.ppc64le Fedora 40 distro kernel
> 
> Adapter: Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X
>
> PowerNV:
> 
> Host: Power9 Baremetal
> 
> Kernel: kernel-core-6.9.4-200 - Fedora 40 distro kernel

Is there a requirement on the kernel version ? Would an older debian
6.1 work for instance ?

> Hypervisor: KVM
> 
> Guest : 6.8.5-301.fc40.ppc64le - Fedora 40 distro kernel
> 
> Adapter: Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller PM173X

Nice. XIVE I suppose. What about TCG ?

Thanks a lot,

C.


