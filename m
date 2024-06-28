Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAA8C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 22:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNK76-00076v-Au; Fri, 28 Jun 2024 18:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNK74-00076k-7b
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 18:30:38 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNK72-00020w-1u
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 18:30:37 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1fa0f143b85so8368905ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 15:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719613833; x=1720218633; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qDWiO12eOYHfJoO79eO6FoVb1MDlV7dJ/SpQ7en9unE=;
 b=xNNvJ9lhy+V0nkyFAJgz+IbXr0CfeFK4zvO/JMWvJXDMlJsd65bFlsXyLMwQUGOVaJ
 g10EygWs7u3zye5AUdblQyYgbXp6nVF9k2LpR/wasa5aRHsKBig91RzcnsIGEyKooMOW
 ePxh0Rh7ZR0S2aDlht9c2IozI0Z9xQIP8QHQkhhdmZ/PuvZ/iU7IPG3CNIJLqMrSpDqT
 lq0dYVXrmGhBhHJvgMrU5jUjVzirKa15Mquh4puJeQLaq/Iisr515f1JwatnuhrGRmlk
 pS/tfEGIS1CL7VkACjPnGxi4ICMJvmdeEKa1BMhZWcTApJ5wtMmWWpJtDXpuo8kqkzL0
 QJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719613833; x=1720218633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qDWiO12eOYHfJoO79eO6FoVb1MDlV7dJ/SpQ7en9unE=;
 b=E9roi7jQLo8c9596oCWym7/RLASnxNGcBoCHVXG9XbRapA55dFPWEdE3cws/kvP+6f
 8iHOkaYCvr9dEoZ1o9wc+HvXbcO4b/3UfDI40w/d46PPe8Yq3Qe4jueB8sZbKNQOojLY
 H/VV2COcnJOI1LJVvH8qrpqN+UhithEMWNpsWjC7hDdUBNF8TGggci5nWRjPqyTMFRdE
 +Lv6MyV4dxLyV690RxhoMfTpZ07E0hnGUeAs/teL8CoNTofpBTqet0zMs4aFLffSfOM6
 pzraPSueNvTIFVN8yQc8nny1z7htpUCTb/EXXk0TYzoUvTXdV7VDyMnMyYcqJrqSJGmY
 EKSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV07UFQWVuX2+01pQioUqClEHi5LUq8mC/XqUThuJnz2a0y+o0X0mOH5Q44obzTWZF6yGzvvIeI200PPHpW/fhGz4MWXhU=
X-Gm-Message-State: AOJu0YxL5+V/AmjnU4qxq4bF67pm3is+PwLMkOhalq5VOSa2/aAjZ2Nz
 RMfBU3WnIRaJCy+PmMDF/LhvGAvTOjBOzZHz1EZYOR2vNDdLXRDYhSa9eqYQTtU=
X-Google-Smtp-Source: AGHT+IEItdrQCAv6xVgy4oD7xeOhjpyZTpnQp88FspFiZ9fMyvsGQpukTL+lSBkCaQ5MGBbCdr2hoA==
X-Received: by 2002:a17:902:e888:b0:1f7:3314:524a with SMTP id
 d9443c01a7336-1fa23bdf3c3mr179985205ad.6.1719613833230; 
 Fri, 28 Jun 2024 15:30:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1568e90sm20416215ad.188.2024.06.28.15.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 15:30:32 -0700 (PDT)
Message-ID: <9d3ccc4c-8b36-4a85-8f14-465580f1b01a@linaro.org>
Date: Fri, 28 Jun 2024 15:30:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/23] plugins/lockstep: make mixed-mode safe
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-11-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628124258.832466-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 6/28/24 05:42, Alex Bennée wrote:
> The ExecState is shared across the socket and if we want to compare
> say 64 bit and 32 bit binaries we need the two to use the same sizes
> for things.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/lockstep.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
> index 111ec3fa27..761bcdf363 100644
> --- a/contrib/plugins/lockstep.c
> +++ b/contrib/plugins/lockstep.c
> @@ -57,7 +57,7 @@ typedef struct {
>   /* The execution state we compare */
>   typedef struct {
>       uint64_t pc;
> -    unsigned long insn_count;
> +    uint64_t insn_count;
>   } ExecState;

Or long long, but I suppose this is more explicit about the width.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

>   
>   typedef struct {
> @@ -148,7 +148,7 @@ static void report_divergance(ExecState *us, ExecState *them)
>   
>           g_string_printf(out,
>                           "Δ insn_count @ 0x%016" PRIx64
> -                        " (%ld) vs 0x%016" PRIx64 " (%ld)\n",
> +                        " (%"PRId64") vs 0x%016" PRIx64 " (%"PRId64")\n",
>                           us->pc, us->insn_count, them->pc, them->insn_count);
>   
>           for (entry = log, i = 0;


