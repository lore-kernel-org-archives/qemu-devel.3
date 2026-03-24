Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF50F54AC6
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52zu-0004Zj-Po; Tue, 24 Mar 2026 10:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52zt-0004ZJ-DG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:44:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w52zn-00085z-U8
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 10:44:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so35756245e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774363477; x=1774968277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hp4pL/bF8hNGCmBBphkw7BUQWdKqYjXyhDc/M3BZwoY=;
 b=HzlBC5BtKZf5648+HTeyVV1xwm7nfheXCf0O3fNxbHZRyZNEGeM3wnUQXJYgfN0hxm
 jVCgFA0WMIlrvXcxl0a/QCooTQlWj4hebK7K/G7g0v79uoLBqFPWxtzAHMyfv7MCocy1
 5lJHn88neknkTvgT11ob5ts9cQu16SkHuCuhKGFXeZa7n8j9FUm9gI031VqBucnEW8qt
 PgSMVtudw3LIYPKm09rb2dgbYZdvjEDUf4sjb28jPIcT+7ZsJ37xxtQEoiNI1LvdXvUy
 2/HUNUtcYAr3JSX8iFvngqFruzxYAoEQc6dp1bRzx89Bb+BJzAJysM4c/E7ozRiR3m0A
 ovqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774363477; x=1774968277;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hp4pL/bF8hNGCmBBphkw7BUQWdKqYjXyhDc/M3BZwoY=;
 b=CXr6gqCD/gpcHFT2TNXgkgFJvCfm9+qOPDyfKdKhLjcPIvoZ4rC0LbAO0jrMegU8vX
 DR0Xn4l9+MRYGKqoX2kaTkvFpNepq3qhexl3kv9yCMN06GQUsKWGPf7o6G8a8P3Ur1Or
 MNT5QRCKD7h84V7g83CYYBEqANK0Hucx/lIWK5rk1akROpjlLykfMTdLORkH19SwlNxL
 C8McUvrHP7RX8KqbrSEGz65tMehMqFXwsvoMfG60sIsXRdwXCxECuT80K5J5VSlnEqA1
 GFSIHR4fpYnOxwqcS3sWB3JTU4nErDdE33geaIWJNYGqinB+GqTIxrAzNGHAXDYpdE9r
 NshQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVii8fUCNuPpv6gLOpalytEQRmFEGCqn5pu2n0QFAfaGhKU4Q6Gv8RkQsSG38JnO25QZA1MuIHhzHx2@nongnu.org
X-Gm-Message-State: AOJu0YxYGYteEmoxk2EItqz5hBMdzfLDSBuvFObCdnLKyOVy++QZCmeM
 0OaCFIdbfTQhKDFUfQDK2UmEcg6X/5TK7S3VmewgJ6HpkVXhleMa5mIVmCSva/RksDg=
X-Gm-Gg: ATEYQzwBDAZqgA5KsN68H4yApxZiySbrf9UEgRp/0PQi1I41MIRHW2Nh2KF+drsa7va
 eeJFejdsqeCZKdHn3uASdjngdkl/x08ZWp0Xjf1bpM+F+sE2MA33FUXoz2dpm+usNokIUEKyCWx
 ohZWTOjmx6J3Rmc41W3tA6nbzXfR+NMAkKc8P2EdI39Cp3h/rjauuvJUjXJkUhp03W/pQv65wcJ
 a3VXqrIBjE/oI4IXBDYdjXJ2qLdVR9u4lU4AQ12Zqpxal+vbSlQ+4128JujFA9j4ldOrmFPcGQ4
 KcgIS6gAkD/hXkmlTHO64Pj8Wnzj7r96PqpLa+hZlmCEnmE+UI7cD1AeCJURQRaLRbjaHJvGakB
 jJzm3RXADhXiDWz/9XR8uo9p0dGouajAKefvDgg6RsuvjFDLeCVBIaysvfL0LhfPmVIvuloRjRg
 NfRcqRapEAGuqHBH/eNZw/wB0lugrNBvweoTAy2ImHsfaMfx7w8ZP/Aw7bLsEdU55uUw==
X-Received: by 2002:a05:600c:4da5:b0:485:3ae8:2231 with SMTP id
 5b1f17b1804b1-48716092864mr183905e9.30.1774363476867; 
 Tue, 24 Mar 2026 07:44:36 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b644bd0dcsm38087469f8f.11.2026.03.24.07.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Mar 2026 07:44:36 -0700 (PDT)
Message-ID: <9e8f20c1-9562-4091-85fb-73c050156331@linaro.org>
Date: Tue, 24 Mar 2026 15:44:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] hw/core/loader: fix error handling for
 get_image_size callers
Content-Language: en-US
To: corey@minyard.net, Peter Maydell <peter.maydell@linaro.org>
Cc: Trieu Huynh <vikingtc4@gmail.com>, qemu-devel@nongnu.org,
 Corey Minyard <minyard@acm.org>
References: <20260318141415.8538-1-vikingtc4@gmail.com>
 <20260318141415.8538-3-vikingtc4@gmail.com>
 <CAFEAcA8pktQGG5Fd-F=0SRO9MTrC0GVcOf3p8BnneqG3F504xw@mail.gmail.com>
 <abxAcZs2hXzFPKor@mail.minyard.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <abxAcZs2hXzFPKor@mail.minyard.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 19/3/26 19:29, Corey Minyard wrote:
> On Thu, Mar 19, 2026 at 06:04:33PM +0000, Peter Maydell wrote:
>> On Wed, 18 Mar 2026 at 14:15, Trieu Huynh <vikingtc4@gmail.com> wrote:
>>>
>>> Check the return value of get_image_size() and report failures
>>> for non-mandatory file such as FRU image.
> 
> Yes, this makes sense.  You want to do this through my tree, or do you
> have another way you want to get it in?
Merged via hw-misc tree, thanks!

