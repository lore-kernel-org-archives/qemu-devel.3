Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD51E73158
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 11:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmrvC-0005J5-6H; Mon, 02 Feb 2026 06:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmrvA-0005IY-K0
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:16:44 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmrv8-0000xV-V4
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 06:16:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4806bf39419so32006295e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 03:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770031001; x=1770635801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NLKdN2CZVQ2Ws15eaZ8Rqizr/JcBkvPNXP6zlvhL1EQ=;
 b=KDCzD8T9JBW8067vYGiDpMVljGyQh+kYpWeVDK31NeTqymotJ86i1dYMtBL4hePPGa
 yXyMMnQyfH8Mrxq7vXASwlwVOvMddF2wmSh2fVpT6GiPOqgWVtNJnKWA4IESMAUDKou0
 8/jyHYyBo32T7c3WgLmE23XAV+3UntPowqVdsUmitYUIs68HWEVmkVnM97Ukpmii9IMr
 zyW7QOJjCKTOp/PwR9ry0BDNKCNicGWrjJiMrd5BMPCzVqVNLzr26+c3a/MUW8Ma3ICD
 TVcVlzta+BQVS8H1IXa902la4jeCPli2em/pjqlUQcIsiHa9rlCPM/x0+PhaYZSSBvW8
 PskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031001; x=1770635801;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NLKdN2CZVQ2Ws15eaZ8Rqizr/JcBkvPNXP6zlvhL1EQ=;
 b=UwPOfkxhKxvP2v9SG1gtK8E7br8k15+jGbC+XHj7pUev0jhCm90TClG5eA9AR6+ksk
 ke/V01XhMDTK6RI+r4qIHx0niS0E1EWsCC4T8UXPze+kM3Tu1Z0bHj2dEDMP1yWpkC5R
 Sr4QViPkuV/FInmOJT0LFk8MdS9RaLP4GVLtbO0Cur/x8hTERoo6GF8qRi+I6kjxJb8Z
 br31XtD2rWXMBaJvdPJunmVwKGFetyAXeBcFyzWNqkmJW92/CEM3Vcnk8OQ8/TSafp1v
 QrommQhQ9I2t/6zudBP67YmSQ8pWXu0+45NZPCLXqpWmlnLsSwF0sAkcM8478fH1llLe
 4alA==
X-Gm-Message-State: AOJu0Yz7IAiSXfD2VST1NP0KMf1HTnO+TagWSeEKewVjgj+QNepSI5uH
 WKiDxs29g0ZdsGCpWw8up1H71+VJEoVQ7VuGxzzkKoOQmVFh+97dQj+nQF6lovux6dZoou9oWsd
 tDCwAVPU=
X-Gm-Gg: AZuq6aJCnh3LQ+c3OSAXKJ6tS1uMDObeHyh0sYLDwgD9IiLbTbUkXCuEqRCmYkfXFEF
 cXUSTy+3Fiqi/n6NnNLubFCxIgmIspJMofkTuuj3hDRPJoLHBgKU8+Ux0CWppSsjaJLYXaBv2tF
 dLzhO/ovnlQ5NcqWhWIfoaDo0RBygaoA+tbVZ3Kcg9oaRR2UBdhqvFRawM4sQ4Ul04DOds1vCLr
 6eCmAih8MA54X4YrZUOrE+9PLSEhbJEs/ysLKKfmqNP+4dYxVIoKEiq3O/Sl+55f0qkW1dd16NB
 cnyKW3ru3X0Mf1y4XJCehBH58PFWius+NIUmvkaIp7jfpGRGLSH72qfJ0qF2MClCXyufQXW6KYB
 JUz9VGqfZ20i3EOlM3dqCeB0i0EsI8BOGkw++nMFxlWWrjDaaugmCm6Fg3qKakqYihKCX25hfMT
 0ZpSRYTKZ4898kURiJMkRJaJ0pxoZYk2l55JpzzCdUoBgLqKlD2QItjLjAzes36lA6
X-Received: by 2002:a05:600c:354c:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-482db493a87mr130764365e9.15.1770031000979; 
 Mon, 02 Feb 2026 03:16:40 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfe7sm42827964f8f.14.2026.02.02.03.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 03:16:40 -0800 (PST)
Message-ID: <7ccb21e7-b672-4db6-aa5d-8969211ef12c@linaro.org>
Date: Mon, 2 Feb 2026 12:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/11] single-binary: hw/virtio
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
References: <20260201232924.93399-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260201232924.93399-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/2/26 00:29, Philippe Mathieu-Daudé wrote:
> This series eliminates target specifics in hw/virtio and replace them
> with runtime functions where needed.


> Philippe Mathieu-Daudé (6):
>    hw/virtio: Constify virtio_is_big_endian() argument
>    hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
>    hw/virtio: Use VirtIODevice::access_is_big_endian field
>    hw/virtio: Reduce virtio_access_is_big_endian() scope
>    hw/virtio: Check target supports legacy bi-endianness at runtime
>    hw/virtio: Replace TARGET_BIG_ENDIAN -> target_big_endian()
> 
> Pierrick Bouvier (5):
>    target-info: add target_base_ppc, target_ppc and target_ppc64
>    hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
>    hw/virtio/vhost-user: make compilation unit common
>    hw/virtio/virtio-qmp: make compilation unit common
>    hw/virtio: make all compilation units common

FTR I worked on v2 and v3 without previously discussing with Pierrick,
hoping it would help to get a closure on this painful (for me, since
I try to get that fixed since at least 3 years now) topic. I didn't
meant to be disrepectful, and understand this is not a proper teamwork
approach. I will let Pierrick, who kindly offered to help here, follow
his line of work without intervening. Hopefully I won't have to touch
this virtio code ever again.

Regards,

Phil.

