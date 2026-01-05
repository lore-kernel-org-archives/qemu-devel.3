Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE5FC2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYYi-0005yC-VF; Sun, 04 Jan 2026 19:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYYh-0005xd-4p
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:34:55 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYYf-0000YF-Qn
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:34:54 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so13875402b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767573292; x=1768178092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3IDSwr8TCfQ5DxtMSSf4NmC5ruhlNoJf5PlpdQZtiA=;
 b=Ew6RwNrYPXDF3iIRtJZ/90xIYRPn2T5//mbzbh5dTh3P+dIyNoILGGxq2uivILRHrd
 0SjrYat/HczDLLNIzbesZeCpVD93nTgU/0U6jd01sNGzsZzXehJ602bT4auTfAhWypdL
 a1pzawVLV5HfjYz9ic+GF8CpL6L6VndbBcRIwSilh5bv9WphED2M43tpKg1305KmkViQ
 q8ivd/tHZ1xtTbK7GGgpBpuJ4ETb6M1WVZFoByuaBWLcMGIN5ALUJFf2u3tvFxdf+1ka
 98d3z0yOl7Zzdq3AQOSDmHUzbUUxncrnxdwP+s7/OY0cSDVL+vqoGePHWIWcHqgAXMH/
 dX8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767573292; x=1768178092;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N3IDSwr8TCfQ5DxtMSSf4NmC5ruhlNoJf5PlpdQZtiA=;
 b=FlPGfDFaRojvScE77WIngI0Uo2qCYZAeZiuobIOhg00Z24njhw34qsAJX1iBPtVcdY
 F3vZ74Y31RM+gR8rygwG0mlX2ZhI5ZODobvyBrz/+lgTYb8We7mUqFotKezafSUPsbaz
 ehpirlbDoxddv05vmj7+S03Z79Cm/N4Jr5wQBcqfE2oM3Ei3oc3spVLurm4+JXgsIsk6
 VWaPlxEP7y2p4oS+HV+/qAXvo4J8dyCEKJAEOgRk6tV9X0PAv9PKn3A7k8QvvIDSo/cX
 rYPb7F+NEcJoJnAPPJV29qbAU+rf0eZ1EQHIiS3k4owRABbd/0BKCRbOwQIEC7KxmTCV
 R1Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+nV5weJah7MpAwwhKWWrmpML8sz9Z+ywIHzDUzI6X4O8bZrrmZhxwmbsOqLfKm6sHUICPFxwCnxbg@nongnu.org
X-Gm-Message-State: AOJu0Ywm81sMC9xJQZURMT5/NySzbfGAz/x8sIrH8C67qnS0DZc8oy/z
 q/Q5Z6l34v3Ubs0oXyuBGogaPawJYi6fv/XQ7gUUBmuqM8qrw9NurmgTMYTR6VF7Nr0=
X-Gm-Gg: AY/fxX7RHLpne10thNTAuGnPKBg4DUuZLCJ2SA0q6bHIrSWrD2TBlqX4pDmxCStFwxE
 cUrFvAcIcC5HjlXcm+Y5+wzBhOJoia5rKxTPxnGxk4xFBwRBmc/YAlDRzh/cGZhYtPY6wpT3s6K
 Xm54jVr7IpS9bDB6umgv3vlJlX2Zoxbof/fEq9DoFDlpZuND1tN0+CkUMDr6Uu++/OSMnUrNnFc
 ercJfqBqmCYcKOLb/ydPdLTo2ytdaeKVVnVDTpMdh7C2e3Eqc1tUQKEhGcDcLh+j8E53aao2+Mz
 8HhJ+mBb0wrjw+OWXHI4JrOnx9Co/5MDXDYasG2/wUIJD1pBe8bQuY6cYYPqdSpUBtpN9ZLG1re
 m+zVbwB/4qpG5USVGIPk+mVmQ9F+a40VO44g1tCoKtP/DbjQbFlnfwJzFFnIHRyb8M+yuo3QFGW
 uljl6BYF0vL3ZcI4v1N/6QkVgotMQs3Fexz/9qr5bS
X-Google-Smtp-Source: AGHT+IHw18VY5VCyU5Azuk6KBSVcS4p8M2wLiaTMg6o6KgI/ug/0Z8AoSz83PWMeniO3E1jdssVc2g==
X-Received: by 2002:a05:6a00:4092:b0:7bf:5011:d1e0 with SMTP id
 d2e1a72fcca58-7ff642159efmr37864157b3a.2.1767573292159; 
 Sun, 04 Jan 2026 16:34:52 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e892926sm46307111b3a.66.2026.01.04.16.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:34:51 -0800 (PST)
Message-ID: <da49e094-57f3-4463-a3f2-21bebefd8f87@linaro.org>
Date: Mon, 5 Jan 2026 11:34:44 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] target/sparc: Inline translator_ldl()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20251224162642.90857-1-philmd@linaro.org>
 <20251224162642.90857-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224162642.90857-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 12/25/25 03:26, Philippe Mathieu-Daudé wrote:
> translator_ldl() is defined in "exec/translator.h" as:
> 
>    198 static inline uint32_t
>    199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>    200 {
>    201     return translator_ldl_end(env, db, pc, MO_TE);
>    202 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_BE
> since we only build the SPARC targets as big-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

