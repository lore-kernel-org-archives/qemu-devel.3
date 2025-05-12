Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B6BC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEU9x-0000Dn-3u; Mon, 12 May 2025 10:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEU9v-0000D2-28
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:29:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEU9t-00078Q-7t
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:29:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43ede096d73so31981635e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747060171; x=1747664971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=//8GDY1HZhJwVr5xK9UIS/0xGW36gfpOUZCGVsl4mgM=;
 b=rHpK9XIQxW0BAnWRbG/UbWHOQyUI2MCR7JAaImgfiih5SH7cs1Owr3m5+WwCFah/xz
 esrg+E/Lvhu+STNE6s/SumJ3FQrBvo0G5isF5+rCRPNp4iS7XEWx+74rmLMJpkUlsRDA
 v4JqN8b+PUqBzoqyfJ6J2QfNKj8ZpT7g7vwRSu3e80rz863bzCRzD2AqJzDOgRYIba2a
 WwgSl9OPy4KEOU+U1c39Qi2wiJu7tANiZCTbnJ4IWcSPdG7ZIcKMhTo14LwPUy4Q/LxA
 Ano7DXFIDUaYwVjr+jMsaRo2qxAqKK+aGKTRCJcTEmOJ5s7QDCYO1WH/almllRMBWbix
 Y1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747060171; x=1747664971;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=//8GDY1HZhJwVr5xK9UIS/0xGW36gfpOUZCGVsl4mgM=;
 b=X2wriTFx1WFuaP2RijHF3QtPygNTRuPbdzYN6FxpkmVD9GF9p59X6/StBiOrq1Uz48
 4C4qawmCd/nPwfWk47bx9hlHyh8b/Mksyw1ZCP4P64nkBx70TyYI7Tbi2IbOIHNCviS9
 RdeUTjCAUq7JTk87/0bCdz3hcOjqA8jmyQEefOx5czrV0STTVkBpQa5AvXUap7+S51wk
 4NyK/9jUDxhQYYD3klEHcIjEKsaYZe7gI174m+ivk6UxhuX6wvh6pOu7cBgHvtoaagvz
 4M2TaRluoMeIckwZkhcOvS7joZrkO21CqcQg4YGqOwcqz9u3EhQMrvN7FrewhtPrfZAv
 gSrQ==
X-Gm-Message-State: AOJu0YxDkI99buiUFKpTTbr7ul3cIbjwlq5vuSOV3i3U2n5tqr58RZjO
 GovwVkW8Lrnz3J8CG5t1R+IW1kRXXuPHxrBGdNrupmaVkZ1uwPkerIK1ZdQ64wE=
X-Gm-Gg: ASbGncsNPvfeYJyJemr8tpa9GhFJFdPCifRB/ZxCRGtierqLY+Q4uGTOfjztb1Xhtzu
 JdT/YleZl3h+o9Q2ILQE2cZaQV7vsQEjf8Hh7Vm1g+kTeQnd4E2ZFm1r2syeLz+AwLll+l9IS3I
 K/jcdc9rGMVwD20P60AJlunOR6wASC1UZIJMsyVBg7BNP3dt/gxlPFQWcbBH4BG6Obbgp6UnIAc
 JGxygWnaTTm8p735ugEC5q53kf0nqYrds+WMHnJOnk3ARZNAk9GZO4rwk6XjH/Twj7mDBIQjWg+
 e/jThLLwHo8Bol2Sh+QHAqGD2D5mtKw3dIi8N5SREucIYix84thm2KHjJBVqQp4Ob+cQnAMV+SV
 UphtFVxuyv0p0VgVcLx5oLr8=
X-Google-Smtp-Source: AGHT+IH//LsXsFn0+KsVtI0eYcCGHitwJAq8i3Ubj5aAdTEye9hgxKtA/sAhWhhLbURlJTAKcyjxDg==
X-Received: by 2002:a05:600c:5118:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-442d6dc557cmr89775625e9.25.1747060171553; 
 Mon, 12 May 2025 07:29:31 -0700 (PDT)
Received: from [10.93.5.179] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d685869csm131153685e9.26.2025.05.12.07.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 07:29:30 -0700 (PDT)
Message-ID: <52d6a79c-709f-447c-b92e-e1c827948c05@linaro.org>
Date: Mon, 12 May 2025 15:29:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Add PCI hotplug test for aarch64
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, eric.auger@redhat.com,
 alex.bennee@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
References: <20250512123646.157447-1-gustavo.romero@linaro.org>
 <aCH0ATZVRxI7rtxk@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <aCH0ATZVRxI7rtxk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Daniel,

On 5/12/25 10:13, Daniel P. Berrangé wrote:
> On Mon, May 12, 2025 at 01:36:33PM +0100, Gustavo Romero wrote:
>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>> native controller and does not support ACPI-based hotplugging. However,
>> since support is planned, this test sets 'acpi=force' and specifies an
>> EDK2 firmware image in advance. This is harmless and prepares for future
>> ACPI support.
> 
> Based on what's written here, it sounds like 'acpi=force' will result
> in this test case changing from exercising PCI hotplug, to exercising
> ACPI hotplug at some arbitrary point in the future. This isn't what
> I'd call a harmless future change.

Yeah, your reading is correct.


> If the 'virt' machine ever switches from PCI to ACPI hotplug, this
> will have to be tied to a machine type version. As such QEMU will
> need to support /both/ PCI and ACPI hotplug for a long period of
> time, and by implication we would need to be testing both.
> 
> I'd think this test should be written to exclusively test the current
> PCI hotplug, and at a future date when ACPI hotplug is introduced,
> then a 2nd test method can be addded, albeit with a lot of common
> code shared.

I have to agree :) I removed acpi=force in v3. I'll add the other
test variants as the right time comes. Thanks.


Cheers.
Gustavo

