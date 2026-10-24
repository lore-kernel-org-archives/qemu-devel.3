Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA382606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qbwkacla
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKZYF-0004zx-FC; Sat, 24 Oct 2026 07:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKZYD-0004yz-6h
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:04:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKZYB-0002PP-CJ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 07:04:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so5751045e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792839872; x=1793444672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4vTTIchfMcP8oYMKGWgDYAhqEQvAP6kIZqeGwGJa/1w=;
 b=qbwkaclagmXZoDajILR/YQ00DGwVUX/lSiW/zrkMRFMHaKl8UZ/RsAEcidN8XXtvA4
 LnX9g7Lc2nMV+uXZYtj8/GXmakmDxYAPV1T0Fn9QcMNtb3YYPTqUKMiTZO5Un7yM8M3J
 7UyzmMiELoKUX/jaTObt/OcZLR0A4LyKiabRHopbhXk8C40u+gA31rWVlyqAefo91r+l
 uRJzvXc9ajXyxXwOKyAHoD0iNV5q9yxpbAMZr/MgRW2dhV+wxAZEYh+s8+1iaENg3DLt
 TKxMj524C11iAaS/3KpKmspiT4mmKcya+sIlln2BxtG2qojNHkv/bD/JVcXpfdr6E4o7
 UZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792839872; x=1793444672;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4vTTIchfMcP8oYMKGWgDYAhqEQvAP6kIZqeGwGJa/1w=;
 b=yedKOwVOusr2cUd+vVNgI87kRhkVxxhxja2nkxfzGtBqRIBUPzudTFDgc6Qb0Wg4+S
 is8Ixp6KDLAEasFtxpBNOtZC9zjHm/mvtNdNaoC1tPID2uLVmUAZOhZVakaXT7vWsuiC
 LWbjXZmCKrxPcgKd4U4MquVqIXBfffwQY24mVIKkWVh3GkARnK5v3u//8tTCwOJwg5xo
 2YPABbIU5Px4RiU/vD5rxFJNNRJV8KqBRyd5fJKBohL2N12Qv0/hm+9UDwLvhP3mXDmV
 QeT92mUQqoj86YvDC25RFPn6RezsnYH3u2AfhCc3o2VCKqDBrOZZebqW6qML1aJgXij3
 ceBw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQoKV74IaYjY7oxQurBTMEkWUh5FuhA8NfZZeTtNx+la5PHRjBqr/jYclnXScYkEZo5AFMfwLl6OEo@nongnu.org
X-Gm-Message-State: AFq9FYLqTElhIZ/lQeP2Z6eusQOD9qebsCLrC8qUguILKE9Xed1KAzsv
 eRtJFkg+bu2qnorxARjiWl5skM/djKuGdW5lvH0OjltLAKaJ59rjxavoKQiA1x1kKCs=
X-Gm-Gg: AYBFou25XfcJGcMEM9lEwVUDi1hlF2AVFFfVJzm9sod8hvPpldpsNwxlzS0I0qEiUva
 QF7U54zvGbC6DzEj7dfHvd7ENklGjnkj7Tfc5eUSiGAtBpupkRnBx5nljg/l5e8nsrhIwxnA6Ko
 89Ii1YMb4cteAPxbOGzzccbODvpGQw1yFHdYLG4TfbwyWiC8XBOImaJnfN84TawgIBy9epKlwVp
 u5ea3c2Ah1i4/elb4UZx8z3aEMPoiunCZjLTfSO75lDvtOrru9Iv9GMJ2XVLsO2jhC7kG9+kMTW
 3Mp8FN1avcO1Rb6Ci0ODMjI+NVsZGunzE7sbuZFpfdjJUjZAD0XyC6EdOUCf/+xo5CbqDHrR0Jv
 mhEBYbyFPXS3qM0o/UnNRSLjpJ2O+Z8yK6wjyX1AJnVdcy1Sw1ZWBrAE3EzNXt8yug39AyfR/42
 eGHSU6NBCRsM2KWLZatwel2+zyoXyTkbB66J2CtUL6XaRTav7vxnmHcQnOxsHMztXch6VtgIE1M
 wUi7zRU8/ZGftKkvdx5ddkBv4AxqoGNPOtxrHHrblvm1erM8S+HuyFgJw0EpeEbx3up
X-Received: by 2002:a05:600c:34c9:b0:4a2:994:575c with SMTP id
 5b1f17b1804b1-4a35acb994bmr25961355e9.34.1792839872397; 
 Sat, 24 Oct 2026 04:04:32 -0700 (PDT)
Received: from [172.20.4.74] ([176.95.65.245])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4be6sm3307708f8f.37.2026.10.24.04.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 04:04:31 -0700 (PDT)
Message-ID: <6502a380-3bdb-489f-b6f6-dfc875c93831@linaro.org>
Date: Sat, 24 Oct 2026 13:04:27 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/23/26 16:14, Peter Maydell wrote:
> The following changes since commit 4f4225874d4d3747ec1142e935dbd314218992fa:
> 
>    Merge tag 'pull-request-2026-10-22' ofhttps://gitlab.com/thuth/qemu into staging (2026-10-22 12:47:21 +0200)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20261023
> 
> for you to fetch changes up to 02e9aebb8ecdf9c19c7e2d0ecd62de8ff0c6827f:
> 
>    hw/adc/stm32f2xx_adc: fix left-aligned conversion results (2026-10-23 10:01:16 +0100)
> 
> ----------------------------------------------------------------
> target-arm queue:
>   * raspi4: emulated RNG and thermal sensor devices
>   * hw/gpio: Add EINT CFG to Allwinner GPIO, fix interrupt handling
>   * target/arm: Deprecate using named CPU models with KVM
>   * include/hw/core/qdev.h: Fix where device_class_set_parent_realize docs suggest putting parent_realize
>   * tests: arm/virt: add GWDT tests
>   * hw/misc/bcm2835_cprman: Treat invalid clock mux source select as GND
>   * hw/intc/exynos4210_combiner: Fix various bounds-check issues
>   * hw/adc/stm32f2xx_adc: fix left-aligned conversion results

Applied, thanks.

r~

