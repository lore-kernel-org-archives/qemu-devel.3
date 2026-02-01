Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C86FE65298
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgb6-0000yt-4A; Sun, 01 Feb 2026 18:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgb3-0000xy-AD
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgb1-0007SR-MM
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:11:12 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-43590777e22so2365335f8f.3
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769987470; x=1770592270; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LH/36hKdmsl62PNXLt++jhK6X+7WmL+9EdwUSFp4gm0=;
 b=qDeypRnE9/mKgPRxEwHS0XUGfOnZyglAf/FPwuWufinF8UyKJ8w58b9ZHBzaPKGibn
 8x2IVQp++3CO7Hm+vNV1Zb/V0ESVWnV4ayHAeCdR9ajyDRvnDds52Tfu2SudFKyTbNOt
 g4hign65TJJk4z1fqlSFBnaTxuAxEUNojD0pmyTqE+l033hhMaRwPF7OIW5RUtu/rf7K
 44kyy7awOX1EtG5ykfFoJp71FXN1t72CWZqDZ+qQu20JHRJDLneI7QxuMyDhxqsf2G9S
 oigi510Y9KhrrJJ60O/WacUF/Y5Rl3ruRv+mTzFWviiO4IzPlpC3QimQbheL3XAK4c0Z
 owzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769987470; x=1770592270;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LH/36hKdmsl62PNXLt++jhK6X+7WmL+9EdwUSFp4gm0=;
 b=AukMnsxkTxvhBVY6K4j03wsm30qMGjFsy6bGnl55QZaBmqtiPF56g0zJ1NoPmwYN+e
 BsLQQxVO+3KAzA8+qWGaGo6gV8/yfbkrByHEwJW132niVgyrgNzIijzV2T6RafDh+M09
 ZyPCX4EreXa6ZLhWPrHUifFFRBcUYd9d4bt2ctGwfIEthpD14fld0znBZ3hJ6d57OzsI
 NGwpR1II53Cu5vwq6B+kSMDNpIgK4uyYM+4W2EN1f2mSIqiw3aAK7l5rnJ3Ti3ibJEDP
 0RfRwpwWc1SXpRW/GTRm2y9a/AY9p9fYHi9aRhyIlVi7amXSvcGv9W6mNGFOUe5dKVcX
 VA4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc8DHI+84e12hViru3UU34YSaTGSp2Py0tfixLvmXGAhGhoEuLbzHQJGRuD7PTN9OxRLkifZy8f5TN@nongnu.org
X-Gm-Message-State: AOJu0Yy/jEsQWANhrjufHwAWdMPDs4hBxoG1P4vQ+UeMxp3Orh40Aedi
 t6A9Ov8gmMgCEWlDZ4/ZqqjsA7N7nwWogvTkB9zKTvYRMiXkBitnWnwmyPlyZJJrAj8=
X-Gm-Gg: AZuq6aLDTcq/QKEi9xILPfeeX1+39cjxa3TASGl+wrnYdhR3NmWC1RL2kUO2PNBpu84
 fKoD+hNUxW4WC/aqhNWiWpZdfZo46QpJ1lAlylfKDyUZ1ucZWrUNi3vgm6zT7qBAxFpUehNg7Ro
 sUhzHvFnebR4w4ThTWQ3i2YDp1d7vmrjFxcRjqcK3cs9mFvUI3sazxJqorqw/6Wz+8RpHyrrsZs
 35+nDXILnmYL4TYWTxMYv+UeAJRyAY7NcCRKPcu/eVgOWEwrlrGiPCNd8QpJ/ViPctrSs8fahP5
 D0oRtc4++hdF0k/Jsc51o86BIYeWb8vFPJcaBV2sQlIiA5aDlwRzc7/t5xmXYzEo82juJFCO4vT
 ofIllOOZhP8P5nkRjbvfKW9GC1ETidk24QeoKFP/NZcYnZ6CS1DFbXE8MNUlF90sifftBEBNEFn
 HwkTsYFwk5eV8qimNNdtQFsmwDscMKMpOkRffbH64qeByBUiECa2DzYw==
X-Received: by 2002:a05:6000:3103:b0:435:aaba:b8db with SMTP id
 ffacd0b85a97d-435f3a74568mr12901844f8f.21.1769987469777; 
 Sun, 01 Feb 2026 15:11:09 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e4762sm37522518f8f.6.2026.02.01.15.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Feb 2026 15:11:09 -0800 (PST)
Message-ID: <c8c58d50-dfea-4e99-8094-dbbd8437c4de@linaro.org>
Date: Mon, 2 Feb 2026 00:11:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in
 a new header
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
 <20260131020100.1115203-4-pierrick.bouvier@linaro.org>
 <a31c785e-099f-4fec-bd17-81397c5ac793@linaro.org>
In-Reply-To: <a31c785e-099f-4fec-bd17-81397c5ac793@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/2/26 23:26, Philippe Mathieu-Daudé wrote:
> On 31/1/26 03:00, Pierrick Bouvier wrote:
>> Allow to include it from common code (vhost-user, in next commit), else
>> it pulls ppc/cpu.h which has target specifics.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/hw/ppc/spapr.h        |  8 +-------
>>   include/hw/ppc/spapr_common.h | 16 ++++++++++++++++
>>   2 files changed, 17 insertions(+), 7 deletions(-)
>>   create mode 100644 include/hw/ppc/spapr_common.h
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


