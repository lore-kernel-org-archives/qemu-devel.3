Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90F3C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 16:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw2WW-0001vW-Ax; Sun, 14 Apr 2024 12:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rw2WS-0001ue-T7
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 12:16:06 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rw2WQ-00058e-Dr
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 12:16:04 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d717603aa5so29175611fa.0
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713111359; x=1713716159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Uck1Qt1Ycd+htozfGY+LR76H53rRIlW25I0ktt2iaY=;
 b=dXpqMxLl+Lni/oc8i7HBMADeUrSQSLgWeeb4SrpBR6epkHBcHeZRRhZy84k/Gzra7U
 YW6J2Kc5OfESquQOzb4RNv/VMqS6rI8+Xu8aU9T9/NYDEBD/ntkr6j06FHR9oJNz6yo8
 lIgWBa+kidXSqPWMC/iylbiJzyBrNVs6GT5ZBTXbLpdxMwZOCY4YXuNTKLI/ia5w26Kh
 w92UdHPf158jvuY5a5pnLg2SQWh8Zv6gw8QY9z3r6FIoCNjwz0i6rDnH50IOa3wWUhZX
 2oTc0WW31qIhrPDFpcy7ByJoqO6TupvenqqbPlmlZMFX9C5HvhojpkkgiCs3FhEN5v+o
 9DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713111359; x=1713716159;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Uck1Qt1Ycd+htozfGY+LR76H53rRIlW25I0ktt2iaY=;
 b=g+suyMGW8hQK2WfrT7sapIImxNrfGlk3cIJL5HRKMVKVTEPo1RmbiMAViAOwRvRYGZ
 ic9t3jaWsMGRjJ2KXrZ8yyGhfCa2uyqXKwCDGx50950nNQ4I5SWNqM7l9Z6fM6QNsrcu
 Ey2J9XQL95Yae0/FCWqppI7HDV54ZbmjapliTGraMl0Og8chGyBWmofMj0hIJynI1Zl6
 nGu4NDAWD2roxWFZzOkiM1mArZCzr1MJgU97w/G3J0ci6S/nDmHavULp2tvfnNHqmRHc
 MpgG5ZBmLHwPp97X/rYazBqq6cRe+kNudZFGW+6dAXaIHAJDTe4B2CR7wnHRlVmI3rvU
 243Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVngzTezkwHQiOyVfHfsicF8zmFmjAJMr+iuWhAV2/nZh1W4HH4NWeNQUwDyrGVMHP8G8kBqcR/Xx/9dJMoFAD4WDv97tQ=
X-Gm-Message-State: AOJu0YzWfbCgombHXtr/zAKmZn/AJIwvuC1IFPsoVsJC8O3+pDEaChP+
 YquhKM+iB781i8D5jdP52GlAXRUaPZ9AeFbU0+8sH4qvrCauCAojx5+fA1FxFzI=
X-Google-Smtp-Source: AGHT+IH6l+Wh0nm8dRTFtEoGTdg0sSCp6UNG9ZvbEDuQ738Ctly+3FNph4ODOFMUMIqEP/tvdAcGKA==
X-Received: by 2002:a2e:9805:0:b0:2d8:9955:cd27 with SMTP id
 a5-20020a2e9805000000b002d89955cd27mr5259621ljj.48.1713111358618; 
 Sun, 14 Apr 2024 09:15:58 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.200])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c444d00b0041663450a4asm15923711wmn.45.2024.04.14.09.15.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 09:15:58 -0700 (PDT)
Message-ID: <07e79630-7171-4cb5-829d-a87a8165adc5@linaro.org>
Date: Sun, 14 Apr 2024 18:15:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu for TC377
To: Sameer Kalliadan Poyil <sameer.kp.in@gmail.com>, qemu-discuss@nongnu.org, 
 qemu-devel@nongnu.org
References: <CAAA2AK8p=RtqeNZXfnqprw+kqEBTvrQo1Va81+ctfYAT6k6jnA@mail.gmail.com>
Content-Language: en-US
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAA2AK8p=RtqeNZXfnqprw+kqEBTvrQo1Va81+ctfYAT6k6jnA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Hi Sameer,

On 13/4/24 14:52, Sameer Kalliadan Poyil wrote:
> Hello All,
> I see that Latest qemu supports for tricore TC277 and TC377
> image.png
> But when I downloaded source code and checked for TC377 related file , I 
> didn't find anything
> 
> I want to run RTOS/bare metal code on TC377 . could you please let me 
> know how to start qemu on TC377 ?
> Here is the latest version of qemu i have , I didn't download 9.0

$ qemu-system-tricore -cpu help
Available CPUs:
   tc1796
   tc1797
   tc27x
   tc37x
$

Try 'qemu-system-tricore -machine KIT_AURIX_TC277_TRB -cpu tc37x',
this should start a TC377 SoC on an AURIX board (~KIT_A2G_TC377_TRB).

Cc'ing Bastian for further help.

Regards,

Phil.

> Regards
> Sameer


