Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7588C25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 06:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCCoZ-00034S-0y; Wed, 29 May 2024 02:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCoW-000342-Mf
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:29:32 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCCoV-00063T-4f
 for qemu-devel@nongnu.org; Wed, 29 May 2024 02:29:32 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a62972c88a9so206644766b.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 23:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716964167; x=1717568967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZzJ4uOqB+i4ABBaqSYZOOF8LNBWUA9jQNVV04Yu/4Tc=;
 b=WBrhy2vbcz8zrryNgbaN8ynkGNSz+p4MxyA2Gl0Ob0FAT0Fxt92ryUJt03xekoVxOa
 eaMBlTVsLrStxKhNsplXy6V6OlaZezPzZq+q6QrKTwRMg44ZaQuDZvt8NxKx72FfVbJY
 qLueGISXCovi+g9GdTvqKTPIm2qsWLixVf/PnNNkFx2JD9wPW6eRNV9uwP/xqPt1/7cn
 4EYN/2aMCSJ6OsHpxx64TTGetMV56h8neXDl1haIyudrMWkqdDY4QCqBwwNzdvsK2vv/
 l5io1ouCXdYFei1Lqsz2U5rgGTmNwPa5Dy2SDbio0D8ig6d9xuqURwECBv2loGjQL3ku
 91uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716964167; x=1717568967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZzJ4uOqB+i4ABBaqSYZOOF8LNBWUA9jQNVV04Yu/4Tc=;
 b=f1uz+umSbpGaE47SolvVU1/B0kMJVnHiAV0pn4LWLTZK7oM5zxWGsNjdtTl6dJejXx
 x9T7Z4mQhuOWi26nThXmxQ4jk5qq6pbdj765v2cMaEgtzQxP8Tu+UmHNBdyhWSkvyOLj
 rul2m69fX2D69QcO0QvDu2uxw9oPEnAks30Sb21JcgoQM3z/5Zd6NmsMvpNjhoabuVnv
 1ol4i/NK2yQWfZMGnXyDB6NmvNBlKdLbSIqwHbL2YsBx3BIwk38yFhq+OtRrqhC1ZZPH
 DNaE6/5n7MdteuYGV5n1aFsotRLgJFlEtCpny13TPNhFeiQs54hYdRnTsDyYM5Ad1Oey
 L1/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD7CgL5NMh5fwfO7hBWz416PDLb68Z/pc7lXATI/o3cDxpn25Ka1Xup5dhnqUXhKdLqJJiq92yD+6g5lBwEfZarXcCU7w=
X-Gm-Message-State: AOJu0YzOvunKB5NvcKiUMvDVaOjvaPS/+vEILOJvgSLK80Pu3prx1LBk
 BULtQShTMzbfmDhXbyHQnV74bZpi79T+3lYtX/hjrrwEChNIpE5h0rKskH3a4x859O0vI9fe3Sz
 S
X-Google-Smtp-Source: AGHT+IEK70ktaXUf+bHcCU22wK85S2cQKY9kTV8KzSnBQlqZM1QWUDBQsZXQuSnuBpAlfbvGAL+qKg==
X-Received: by 2002:a17:906:6854:b0:a59:d4f0:cfc3 with SMTP id
 a640c23a62f3a-a6264f0162dmr972290366b.59.1716964167183; 
 Tue, 28 May 2024 23:29:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda6d74sm680795266b.201.2024.05.28.23.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 23:29:26 -0700 (PDT)
Message-ID: <ce04cd88-8098-4737-b85b-61405d015d04@linaro.org>
Date: Wed, 29 May 2024 08:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] tcg/loongarch64: Support TCG_TYPE_V64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name, gaosong@loongson.cn
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527211912.14060-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 27/5/24 23:18, Richard Henderson wrote:
> We can implement this with fld_d, fst_d for load and store,
> and then use the normal v128 operations in registers.
> This will improve support for guests which use v64.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/loongarch64/tcg-target.h     | 2 +-
>   tcg/loongarch64/tcg-target.c.inc | 8 ++++++--
>   2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


