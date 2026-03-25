Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E1B1099B44
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5VxI-0001se-KQ; Wed, 25 Mar 2026 17:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5VxH-0001rS-0j
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:39:59 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5VxF-0000o1-KS
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:39:58 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so292976a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774474796; x=1775079596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGb7FEaVSI66PmfG2XUShw5T3uik3Z5T9SJQbu9aEEs=;
 b=wokaiqRnkfunY35+VSSH/zEt6WuJ6yXXqi0JO+nEqvwP+D4zwnILXSDV9aBJXY0G/P
 jsiGfy+yF85QNvgnogm0i1AbypBg2keDLukf/IQrCeVMasNEKWpIPITd31qK8gBTDx7D
 G2v95zpSSNbiHwvaHS/yK9Ud3PIE78xl/mkY4emectLpjJgdmDf3zvA5QJhATq61ZS0W
 HZ/8BywPa5Hlx8KPVVQIHmpP+EgCozyWWaXfz+McNnTQ9gf2hXn8WTBfHx+oxlbqbrUr
 9jBiBDXKCMsiVfuuwzzQJettF3E0HU3IG6csk9ebeHvhVBBwtPv8dPxUbFto9ka3/AUA
 vqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774474796; x=1775079596;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KGb7FEaVSI66PmfG2XUShw5T3uik3Z5T9SJQbu9aEEs=;
 b=DaleEE6uBGC53EZYe0HYLpVY8g8FfpRnSuf/EghTHyC3ykYDRGH17StIzCErn/Xcn8
 hEVhSdCqfGqlIQNyiK/s7EJByHzgeJ5GemtS1AizbIKZ/6o8QZiP3fQEqOz/6rgxeCEI
 N7r/DieLSircl6hMfC40wNElAdlAYmeIigTUFuUqwamMdorbfJdGxvB0tzGVqhPl/e54
 Gr6Aj22Zs4puHppMvYE95mP9y6aFdspv2aocYFOhb15K38HaCYb1tgJw4wbqDSD1urug
 c/DOd8U3Y7DHzRBgmI2F9C48W0ev5IyVIXzhyOwSrG3PTGSl4f5/eH20Fns2g83xMgGE
 t+FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWT5F58EeREUomCFyx2sYm+2+mdlZ5lLztkMNIjn4jW4xC40IlIe31/avyUW5sTq7WZQeL4wA7sFkF5@nongnu.org
X-Gm-Message-State: AOJu0YwtjJCMuondN7gWL1sCjT6IDzAacxPw0sbSIjrajRW3P+/MuhOI
 TrvPqgX1t69c0Xqv54q/T0G0JMM0+GsVXZ4hRLbFar+0Mk49IKGBA/eFWoSatCnzamE=
X-Gm-Gg: ATEYQzwEL6qUTkh+7uWiw0NH0/q8lOoBf3EG6D++7Vznd0GQwOl5z3PB0UyUZEv9UGI
 b5aHEnzq9Ifp3IUIEdh5CmxPcfhlgwH/XdMbBQE2ukYpPBHEvUe4X/qWCPWYthLmh3SsJuUwnKB
 1EIoTJ409Z33k96kd6TbbVEC6b2whHWoiLPfnvQXIxACObi36p0sV0hkYDFzWmgb2f8M95dM7lL
 pxizaZKfLGeGVCLARSZe6IV2mGRxGgkTt+DThSnu4tVZzUzDyJyPLBd7D/ltQoNddRSSRz3ddIi
 WakEXemgG02vfr0o0Xp93EoZe2QQBaFSGwDz2CizW3OeNeqS9GUgtMUT3jj+mHAo0LHUTDS282H
 pB5nZlV0Fcp6TF4lfLiK7Y6cWmAh8G/HD7vOR+Qrhia5a2Z7pmatKx3ZqeK9sL6nYbbo5PgKFo+
 XFMt6vCgqQkvcBy60BhphsQFhrLODTnUS12GOfC0ZX6y9Qzh/DPHVD+UQKi5QmzvUmop7Z2H93T
 CwOxQg=
X-Received: by 2002:a05:6a00:1c81:b0:82a:6569:1f88 with SMTP id
 d2e1a72fcca58-82c6dd8cb25mr4716179b3a.0.1774474796214; 
 Wed, 25 Mar 2026 14:39:56 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7cf78d9esm603265b3a.0.2026.03.25.14.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:39:55 -0700 (PDT)
Message-ID: <a0791d1d-ddcc-4e3a-896b-0b8f856ece39@linaro.org>
Date: Wed, 25 Mar 2026 14:39:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 03/10] migration: Revert "Add
 VMSTATE_UINTTL_2DARRAY()"
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> The VMSTATE_UINTTL_2DARRAY() macro was never used, remove it.
> 
> This reverts commit 4597992f624c015ceb51fedb4628b3fdb1e5bbaa.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/migration/cpu.h | 6 ------
>   1 file changed, 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

