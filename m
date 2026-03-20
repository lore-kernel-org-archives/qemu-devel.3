Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76911099B40
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3hdp-0007q6-TJ; Fri, 20 Mar 2026 17:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hdo-0007pR-Fg
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:44:24 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hdm-00007b-Ur
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:44:24 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-358ed696623so538683a91.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774043060; x=1774647860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ivupfRbZr2eyN/v/hMMYsYpwwpvfqBk/cQgtwAjOKl4=;
 b=aJAcYdBCKlBpPR23w9WlQCG1lGOV+OHm3hVwrrB013eMihmTbKe+Uiy0qiItKM7FJo
 0n2TByjeQcyvp5LOc2EGTCdAHTDyR9oyrO7oqxPMiOD8szpFoMiscrUpZbi5+QcE6CjO
 JAmfjZOVrOXn+O+xGKBWKqe3YVl7bp37ZXH6TK/kV6wAkWLUGhn4qQ0w2zVrkChTmN2F
 LDRlt3dzgc27vNjy5btv8VfuAN8JflWg4fb+1Kqv9Tvh6Lnq6fE4A3FnOChhTtcfZVRB
 c6DZtpOtS5DwolgtOF06XycuEaatfCX9q+O9LbQb+xExxAQwK78IW5812b+UmU1UBV5Z
 Ugxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043060; x=1774647860;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ivupfRbZr2eyN/v/hMMYsYpwwpvfqBk/cQgtwAjOKl4=;
 b=OAl3vClFcCGwwfbcDWmu/KWQVyzZLsTKdV1zjRRgaZXDYhWStj/9Tf7nOrum9LBxrk
 sTBXzw/+TjvUvVy5r8c/hB338YebL2vDRRUCX8INm3u8xxaLsUCw/mvNCsbov/P+JZO7
 PWO7fChtS3xXVjT9pDkkRrzpcD2GQ95WYTs91b9jLdLs1ONS+iukOg2UPuOqL5DSPXtx
 AhN6apdRZOVVYm26llVsMOKbvTNpH5Y8n1yJpv6KdtzhzGyJ1SxP50+217aIKiD/TjtE
 K4tVmeEFGk6zmjw3scPBLzc8s3fWNcrqv/PN534tym6EZhYj4FaXLfbUNA1zRvzkdXxB
 kJ9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFvsmgtB3xWL/6j8lj+MY+FtBXugIrIUEWiBO0tsXveKKDV0zbTnMhbL/Dlm4ucSs+4OG0m+PJ99u+@nongnu.org
X-Gm-Message-State: AOJu0Yx0JdQMLwI9UhKHKawVoq7vi0j0K50/6XZhX8FPkvPGnkf4LTHW
 V2WiG2FIlsYwBE+QUzGq2kwAdqJmrR2fDDEobxrOmvbgHzCLQVyneHrZ3TJih2ma9HE=
X-Gm-Gg: ATEYQzwEVwBfD/u1CG1HhXKBtp3CZIrrKqiKV7NX9ktY0xBmigAvF3CnVezayBOYWtx
 zxP0tHFoDFGgAcXCtFvFBW5ZLuvaDM01Gc8mPQPd0viPdnobmQW+R3WVvAZZ2Bv9Grhw/QNErAO
 y8YrORUSVI4mpQ4yora55yZtUbkI8l7fRx2l02y+QS00luWwpEWBGXwEb9a5CBp5awvz7ZaPJd4
 57rzrLZa+3RPjj5icKEG1B2ATIEDnDdv1kLvrV0YXuAYLICu2YbIx9gpLkfTQBsKJyIKP433RTd
 SxwrdA2MO5/xlu7SxOYfimBAgO7FEidyJGHBn912a+0ve6/opM2n2BTHzweSBSNAjlLPIyIYvac
 3u6E50cn11q4tpJG3FcGnEQvMlzmPTfGfZ0EfSheiu9BVgq/cbJEDFe/2etftxeKfomSCwFsXLr
 WXpuL4Ms3TjgPa8zCyKH855CgChRmaXbMr6X9L5PNBULtgUiFvOxpUINmJVoMs5V4QaTYq
X-Received: by 2002:a17:90a:d010:b0:359:ff8a:ee55 with SMTP id
 98e67ed59e1d1-35bd2bf6b36mr3340920a91.14.1774043060124; 
 Fri, 20 Mar 2026 14:44:20 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35bd3442d8csm1446534a91.3.2026.03.20.14.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:44:19 -0700 (PDT)
Message-ID: <5f9fe9ce-f7c8-4c5f-8230-9a6d846d3ed6@linaro.org>
Date: Fri, 20 Mar 2026 14:44:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 1/6] target/sparc/monitor: Dump all registers
 as 32-bit
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320091019.59902-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
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

On 3/20/26 2:10 AM, Philippe Mathieu-Daudé wrote:
> All these SPARC64 registers are 32-bit since their introduction
> in commit 3475187dd81 ("sparc64 merge"), see target/sparc/cpu.h:
> 
>    511 #if defined(TARGET_SPARC64)
>    ...
>    515     uint32_t asi;
>    516     uint32_t pstate;
>    ...
>    519     uint32_t cansave, canrestore, otherwin, wstate, cleanwin;
> 
> Set MonitorDef::type to MD_I32 to dump them as 32-bit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/monitor.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

