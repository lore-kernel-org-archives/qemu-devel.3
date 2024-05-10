Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CED4C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 16:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5Sv3-0001cK-Ts; Fri, 10 May 2024 12:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Suz-0001ar-OM
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:16:22 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5Sux-0003je-Go
 for qemu-devel@nongnu.org; Fri, 10 May 2024 12:16:21 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e3fa13f018so26511781fa.3
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715357776; x=1715962576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LLdTeDNjA6HeGlyD31S7ZLtiY2wluJxt83tGOKtheD0=;
 b=MbOg1rPVBKYEYenw2UbyCy0Q/BzUcehp7VnowPqRC6Bm2anJIjmCeicpGUyGIuvafW
 i9SjOXgG6SLLxSLIVSeoCMQE6Tr9P9LVgqhyZI8y0XhTF4goMKMcjegWm4vAF4gmjMSu
 +ZFaBarSFQvhytkbcvZ25zdoiCSgGlMEyzHlUnT88EwbYfrnO3MA6k27ip5ObFPns3W4
 AtQIN0CXkBrmUqukTnXwHD2JS4tZG7J20bURrBQNtbYmvICCHbaU7YsvBeAUF4Mv252E
 ahVg6c2cRNzNmTxdWVr8CXT3ZoK46vNmpdpm4IUvbDugeDTrLd/yb45JBiA7lIPnzuCR
 l2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715357776; x=1715962576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LLdTeDNjA6HeGlyD31S7ZLtiY2wluJxt83tGOKtheD0=;
 b=tpZLDhc4fUKCALxG6vZ3vNgrx26CSdWpxcDMliQp0Sf1nYdsTg0ceFceicYJzyWazc
 XNxE8NKX+LwAPmx7dK5wTp/ipOV5uK7vmhUwUqBJXP8dPAJ5hE34vxn3iXBmP1Tktkov
 QjjXwtoTdHWCmLXgdCKvGKxq6rFejswhh4tl0ydQCot4Fx2olpmI8OtOkwDeV3meD/PK
 dd2QOSN1yAMqJWLF2cGeuQNRHZX0Cf56e7gKGY5YbMJfG0jH7fimU/8mV40YNmh8YyEj
 gzM5RODhsWWUUpmo38A9vLirCCNvScViWvdJEZNiLidiHqaHf2Tx2d8N98HFXsofOxo4
 gycg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzBGpp7dvQm3ZqFXZF5LT/hRWtbgCEhw2MMjl5rQj20TC/J4/rwJdEVz3yabD4QNk3tqooBnMQEF/RSoT4ScCAHuANVvc=
X-Gm-Message-State: AOJu0Yyg88mHMPoJnvsib0v0JKx15wLDK3UXyp798kWUFhdlO2MICC3Q
 XEoCz74VouGOGOpxOjON88FkG1OzDHahyNPctD5wAxzGUeN+VU/fq2nlobi6soQ=
X-Google-Smtp-Source: AGHT+IFpKzMt3o0gGZ2v+D/mKp5lViQITX8wohBmtZWkCtnKBia39xjID9xSFKuQnwZGpVXMAKowyQ==
X-Received: by 2002:a05:6512:3b07:b0:51b:de3a:33ac with SMTP id
 2adb3069b0e04-5221058453amr2331780e87.59.1715357776442; 
 Fri, 10 May 2024 09:16:16 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1787c715sm198090166b.46.2024.05.10.09.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 09:16:15 -0700 (PDT)
Message-ID: <18ae7061-fd52-47ad-873a-142dce18d9d1@linaro.org>
Date: Fri, 10 May 2024 18:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/41] target/sparc: Implement ADDXC, ADDXCcc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
References: <20240302051601.53649-1-richard.henderson@linaro.org>
 <20240302051601.53649-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240302051601.53649-15-richard.henderson@linaro.org>
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

On 2/3/24 06:15, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c  | 14 ++++++++++++++
>   target/sparc/insns.decode |  3 +++
>   2 files changed, 17 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


