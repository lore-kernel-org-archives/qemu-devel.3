Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB36D5B84C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fRZ-0001fi-Op; Tue, 29 Oct 2024 02:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRQ-0001Va-Lw
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRO-0007D8-B9
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:10:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43169902057so49040955e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182251; x=1730787051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1F1wQfyGlx2dTe0Op+HmZFdGoAZYpgptW9U5JoHUQ6Q=;
 b=eRIr5Gtc3mTX+c+pzVOkpUONV07yXnrMWu8TAYNvyRveALhHJlU3WZCwNLQEArArI8
 nRYrgsRTa/MwbLw1zPLnTu34SsEsgdvAOyS7nKWEiRZwybmyLHHCu2h6fAh+08y6c168
 u4gExahLLlCTCThJ8SnuteXPzJStuAuoJ3n67mBpV/sGvegIrUomVkNqWYmtL8UU3pnc
 hFKZ/uQ818rPoa7J4la5cpRK+VnhCTrvOBbMAQAB2aXFLSUoKW2Ucagl0t8TEvqsFnkw
 v5/rvv4CkJLlxTmL9d2o9IRrmFw2dytGTn/Gu5kdf9L+U4rOcwzmgXLsUKqafAkwKSix
 16TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182251; x=1730787051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1F1wQfyGlx2dTe0Op+HmZFdGoAZYpgptW9U5JoHUQ6Q=;
 b=mHlXj4r1UCKQOoZgH/9//YQQN9KkMNATi+T6ocGhKjKPYJuc+OSBWCypP45E6baUCJ
 WOjBWjhQ/QWFi3upnZ3zpvoHFgUl55Bb5oHeGP2nQVrGesxIk6PaejKP9X1keC3ECuxT
 pjCAOnsvJmlQPmL2s14hTC0cSaEyKQstEvkyp+zOZMIhUGS9eksVpxWU+HggBEYmtwSt
 RKdU+vgq+73Coy8A2jv/8OEBvGgGN+GTfAxu59hwxsTUMF25GlTmPeIubiTJpypVeDra
 MKfsP2JyiYhPUwSOKq5tfUx/o5azhKPS2aR7uOAux+JJz+rfXkewWblEcdHJGpKw9gVo
 9/ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCV01f2CpZmS9raHC8F7YXTTpH0tS0OB32Kqyr9sa/2hHlQwz7i4SPd3dNbsj03Mo8eMeV2QaFeGZOhV@nongnu.org
X-Gm-Message-State: AOJu0Yy+KQbWYh/TPKNG10mBcvncDbOqQWPmIhBsgUDYEcctpRdmD/an
 jysXQEi5sGbydyOG3Ocho/xQRfvMuIkCCE3PQURNjMmodoaNnvvJyRySyJIRDzM=
X-Google-Smtp-Source: AGHT+IF/XEB3t8rDOX9R8wrFa9AB5OgvhKOca5YZ5ZgPCiex9iqGl6fRuzz5nlT11jaQr2JRP8bScQ==
X-Received: by 2002:a05:600c:4fcb:b0:431:5ed4:7e7d with SMTP id
 5b1f17b1804b1-4319acad048mr72454495e9.18.1730182251258; 
 Mon, 28 Oct 2024 23:10:51 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f5e1sm165298915e9.14.2024.10.28.23.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:10:50 -0700 (PDT)
Message-ID: <797f110c-8615-4e43-aec6-62564a654c47@linaro.org>
Date: Mon, 28 Oct 2024 12:20:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/21] target/sparc: Move cpu_put_fsr(env, 0) call to reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-12-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-12-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> Currently we call cpu_put_fsr(0) in sparc_cpu_realizefn(), which
> initializes various fields in the CPU struct:
>   * fsr_cexc_ftt
>   * fcc[]
>   * fsr_qne
>   * fsr
> It also sets the rounding mode in env->fp_status.
> 
> This is largely pointless, because when we later reset the CPU
> this will zero out all the fields up until the "end_reset_fields"
> label, which includes all of these (but not fp_status!)
> 
> Move the cpu_put_fsr(env, 0) call to reset, because that expresses
> the logical requirement: we want to reset FSR to 0 on every reset.
> This isn't a behaviour change because the fields are all zero anyway.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

