Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EF0C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 20:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhbhS-0000RV-14; Tue, 05 Mar 2024 15:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbhP-0000Pp-Sm
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:47:43 -0500
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhbhJ-0002DZ-6L
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 15:47:43 -0500
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-36602d8ae4fso1006655ab.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 12:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709671656; x=1710276456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zLz1/qEubDlP7+h+vCe+IK9tAcLW2bVswjkwmijQg3E=;
 b=sBws8X5W9iJLhmOrAfSqg7II9iLAP/vO1y3Za+ZbG/XLNYJAYr/8oRqZQh5oCWrkdN
 YM6Ohjgcqn1dFdKLDmBk5RbIioIM3YE86jVbj2HdBMidechnxmrwHIhCFcN18KuwJ0ek
 OZCIZ98n3iG2/btSFa5uUH2Y2/73vitCuE90mt4Qj8MGnISe9qtRgO6lgAlMKH3GvVSp
 YcnJeD0CdKrA/d8ckFnrQalRb09J4qINmBvZ3AV99Kr7+JZ4LSGbPOBCnG79F42HiT4J
 1U01zf48faPZPNoaNm053FH0p+4fLz94X5lKZxdbqLpKcgJQIzapZR1EcnrcNe02jN1e
 k8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709671656; x=1710276456;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLz1/qEubDlP7+h+vCe+IK9tAcLW2bVswjkwmijQg3E=;
 b=NcsBbKD3/rF97j+Jdj2KAg32iH1BKP/LAghnxZzPsOsf7GaNNaQ3ANLLU5/SCxrB9B
 b3lpO7G+GtxtXv33C5/t0yQpEouV9YScsmvVktCgqqTl/SacrNEqmNreBu4bAWazSk49
 CGppY3rlEFTrrBIyr+3PELGC5bPUD6daHsWxO8CpGcdBOAbg+apH2hg3euDkNIy6Aeo2
 djnJ/21gYUNPykBSLFDDENGtpjWJEhihK2Tv8PlSoiWdP4zicdDnc1k4lIsaOgVDX8rI
 ykUJid3KVdVMOeCQRCXs/1QC6EE5BR1h8h0JLi4noyxz7ojOKBYDvrLK5y8ONooghFEi
 JGXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUANjsDKp9K6pTy/PLigO7b//12kAY49HYcqB2hh52hzYQz5bph+S7SvLvfvsiRKMbpb5OeOjFJLmnAoG4q/NbymzVFliw=
X-Gm-Message-State: AOJu0Yyhei3Fza+rVh8ZltvcthfQczKTCfuSZ0KgDfBMSBRFEX17dvYG
 eXvWM+E4HTRVDzw4RIv3RUN1QEYeR04A2N3mV1xrVmL39RpzMDive9CJViMKeVw=
X-Google-Smtp-Source: AGHT+IE0W08xXE4Q4iwsBNpziroMTobpWCZZEdOuZTBTr2QHwWxdzzlav/hFy2CdhGMzys8wjjhm4g==
X-Received: by 2002:a05:6e02:2141:b0:365:4e45:543a with SMTP id
 d1-20020a056e02214100b003654e45543amr16497859ilv.23.1709671655908; 
 Tue, 05 Mar 2024 12:47:35 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 q67-20020a634346000000b005dc49afed53sm9621106pga.55.2024.03.05.12.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 12:47:35 -0800 (PST)
Message-ID: <5a2cbe11-3d48-4bf2-8cbe-1c6d074cc1ac@linaro.org>
Date: Tue, 5 Mar 2024 10:47:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/29] target/loongarch: honour show_opcodes when
 disassembling
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240305121005.3528075-1-alex.bennee@linaro.org>
 <20240305121005.3528075-29-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240305121005.3528075-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 3/5/24 02:10, Alex Bennée wrote:
> This makes the output suitable when used for plugins.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/loongarch/disas.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

