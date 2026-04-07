Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7E9FF513E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:42:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wADEg-0000nC-B3; Tue, 07 Apr 2026 16:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADEe-0000n2-T9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:41:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wADEd-0006Ov-6a
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 16:41:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so4772848f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775594477; x=1776199277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XWkFj3hica1vJLCO+xLthVYAydhITPNKb1tOO09J7u0=;
 b=bN+a1uD+3ZKwqQ1BSIF4Rncgj0e+sRPpgodpgH2e9A9fvomGIiH8xPps4CVqmwNCUw
 Ze2BeiHwwcIk8I/WbthkOr/3PWIJbyHn3m08A2Zg3DO6on5MC5lLwQEgK84o6WWOf8mU
 35pGz27rJ4YeIvpv009s6cnz5Nn0F+WQeJCZ6t4862QZZTOCc6skn/1nc0uuNMixfGn8
 k1RqYCMfhmZ/F/+RDcO3H8wsssA94j9n/i98GQNfyRszMSJetd+ncsL/V0532lIwGzvN
 T9w8cy7adQG5w2JzmH1ee9ZqyOKxddAcrzNeFFSNkSQ9biyNmWSCCHsuNY16HOokRNM6
 bjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775594477; x=1776199277;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWkFj3hica1vJLCO+xLthVYAydhITPNKb1tOO09J7u0=;
 b=Z+AWw1OVB0clKbD26lNfZX5/V3BgBTGrodOIGBn+Gzrx4r87tQqAwgTd42YB9J3Fuu
 F6Nah2kJPyHNtriaur9dVqkHN8MHgKSYXiENAPfykXPBOZpheV47d0bu3c6M7dzKutd4
 m02Gwt/2ddSnrs74ChxbppuUV2TPtzECBNK4HBp+tipmLMK+wF4jvEffVfU4Sc3l8MWH
 SZmFMYMHT5ooBixeQVt0/EGssFs6aXYkmmpghyKzu/vAkyv3Fa21YBBYeHVond7K07Sp
 NobIU3Kr6dwHxohPtT8CLjBQ1JfSFl0msAyfmYFHJWucKSEcXh6VuUJL2ZoTZg/hxK2U
 681A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvA6NO7PfkEyu5ylEN/yN4//1lmSCrQpMttvFXpFmd6yznfgnFawD1cmO4Fcfa6D7yremGQOLtviHg@nongnu.org
X-Gm-Message-State: AOJu0YxEhpoOpjESLxiIE3S2kHBvASthRWxHw1kWth864FedFwpsUVAQ
 zFqFiynWDL/BHFU1N1ADPvutfFDPsRjVWX5SHQ6wY3psAgIqqj6Qr/YQcdU7T7XVnOc=
X-Gm-Gg: AeBDiesCk7CNcrlzEr60ckjbc8I8tiGJioslf636kKhqYI/V2qihfYsFAnpQJIwpbMR
 TBxgXyG7BhXvT7zqWnTlsRfvr0PLMgvHs+uUeo7NayF+eJfAHNra8L0gEvZjkxkBmMUDdX/n02m
 zMkmLL191y5s6YZ25s1lwYItkUhJIO9SuQpZqQMOp15iGbMQkJ6CDmFa9Z41oTLtiwf1OtXumec
 Oxh//IRhgs8M9LSTtnd46Ha8mS/Mg+RbTkLUlHlA0TeS2hIejHl04SMS7nwV1OteBt5hD0DRure
 wSX0qXPOlCSdHG/CIm7SFFJKJV9bG6Ilik1GlxyOdXhJRGTMdyI1fFTVsh3tOE65O0e2cCPacTA
 rOM9VgK95jDFcU1+F4X8O0vm4XU1HorqKfohzD+Ao4uks4IBquOw/uncjSiBNPo+9Hp/DLw1FmY
 TZH3reB7M4VqaDpZlUyfnG7+7zJViUWB/C5M4zXAtqBilX8GkvULjev6fcFallDU1zCA==
X-Received: by 2002:a05:6000:1446:b0:439:c157:2577 with SMTP id
 ffacd0b85a97d-43d292d39f0mr27488318f8f.34.1775594477479; 
 Tue, 07 Apr 2026 13:41:17 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d2738sm53644201f8f.24.2026.04.07.13.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 13:41:16 -0700 (PDT)
Message-ID: <0cf190cf-1e8e-4741-87c9-80635401c834@linaro.org>
Date: Tue, 7 Apr 2026 22:41:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0] docs/about/removed-features: Replace 'since' ->
 'removed in'
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260323151934.92880-1-philmd@linaro.org>
 <cf2415ba-1ced-4455-84cb-fbde3a121686@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <cf2415ba-1ced-4455-84cb-fbde3a121686@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/3/26 04:14, Pierrick Bouvier wrote:
> On 3/23/26 8:19 AM, Philippe Mathieu-Daudé wrote:
>> We use "deprecated since ..." and "removed in ...".
>> Replace "since" by "removed in" for removed features.
>>
>> Fixes: 762c8554394 ("vfio: Remove 'vfio-platform'")
>> Fixes: aeb1a50d4a7 ("vfio: Remove 'vfio-amd-xgbe' device")
>> Fixes: e50a021a451 ("hw/arm: Remove ast2700a0-evb machine")
>> Fixes: 4af2433a81b ("docs: Mention 32-bit PPC host as removed")
>> Fixes: 8ebc416ac17 ("vfio: Remove 'vfio-calxeda-xgmac' device")
>> Fixes: a80151c9da1 ("hw/sd/sdcard: Remove support for spec v1.10")
>> Fixes: 269ffaabc84 ("buildsys: Remove support for 32-bit MIPS hosts")
>> Fixes: fc37c122fff ("migration: Drop deprecated QMP migrate argument 
>> @detach")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/about/removed-features.rst | 32 ++++++++++++++++----------------
>>   1 file changed, 16 insertions(+), 16 deletions(-)


> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Good for me, do you want me to pull this patch, or you feel ok 
> integrating in one of your series?
I'm queuing it, thanks!


