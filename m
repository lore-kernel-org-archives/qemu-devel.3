Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2767DFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXM-0000A8-Kl; Tue, 07 Apr 2026 14:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wABUB-0003Pl-HE
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:15 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wA0O7-0002A3-JY
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 02:58:16 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-354a18c48b5so4029544a91.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775545094; x=1776149894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XnWq8SxFln/RH/y/L7cp49ARGEJu5PkiuW3cli+99YM=;
 b=Y5nR8lN7JORiLlPj0jsRzNW+EQtVXgtMMBO0HQ8iJETW+S+HFY8JVCvPH2kpmh/lqE
 4tKvZtfmWtsexrSScQ+KFl8lUAeB+ssxvK6jqO9aOAumvZzO/O/97QE7wwkC0r+jSzow
 x9nYfbxTW0B/9XijWBTkFDkVBi5GJsFq3863EYtXUfh7Ov2dMODlFipGgpbH+/A6xmc8
 589P3oRSLl+TtM1QJWs//HiTai2ZezaYKzzwqJfWp4OjQkiP+SOt433Uz2nM8UE1V4z3
 RbDSiVtRrAFXYBKqOFoQn1oT2mwsoWNtblCBsM8E12c/+pbEkMSHT5uP9ZtGMyLyjP0P
 sKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775545094; x=1776149894;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XnWq8SxFln/RH/y/L7cp49ARGEJu5PkiuW3cli+99YM=;
 b=QkwoZsxvUnFGbXDClxIF3RPoLk8wAC/FUoQWAIJ3DamGfMNd2HtNgPnRgfq5Z8eb1n
 TlNJPDLfsVgkn28qErwAPluEuaKugA5ete8KPaCK5U6ORexf7TDfVBTybfIm5adzct7I
 +X0c2If1wBJLI33cH/Rk+SJ8Zrd+KmhGzZO3dQfi7eE896j+OXukTjxRVdm+LNvMysm6
 GDEAM1c3KPGiL+rGAF87VLI6wbMUHKVw2F0obky+mZPM41/l7l56C9pZxP6iOL4lBoHk
 /onmeZ9dxkE0CdQw7aZ3SipHVXzw4asc/cxVgaM7g69mZNaOBEIbV2eGVfLD1lv/D+AH
 v7qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPM2vnGxQdn54m7xsfQjIO8VeguNB7mqZ6/izt+Y0wfNdBiYQjlY2ZXafyHKAsenazuDb4y/nlObU6@nongnu.org
X-Gm-Message-State: AOJu0Yw2up0quaQhcjpR1MGj06B3WTgUZLSZtRImRrAlQ+1lXpM3798R
 FnYGq2ckODeZM+GEkntWZOnFVt/iP243x71CUUIgG3ZH9LaBHWvLM0fGpCtOTQ2/LbqhxPA22sx
 mhTUJ+KQ=
X-Gm-Gg: AeBDieugbsuNojyVOk2pk9Tn0ywgS/SI+8RGHlDLPr0soyToPv+bJRPnQnp8NCyXXcQ
 mQQLMV+ZK61GmzLw2jMXxI+orZDRMQXkYQrIREAdPdxe0WRXvH2N75cS0KjEiAimDDYAvcxIDA4
 CE54hYWCtoodoAClloqWsD0mX9PAH6L3g+hwE0UH9eyhjo8pVWAk5fhNXYOcyhKIMLtzCfNrgjj
 XL4G7LnNvrwROLInPX0pYhvXrv5jw0BQROH0VCTvYv7c+NDPzqtocDQU45W0i5cNjtqEuhdviOf
 TPBgB5ZDaDB4Shf11qV9S6KgWoOKz5Yq1LEQ1B7QtX5+ht4ec81gcPlGFZHegR84FyiJdRLf2uh
 OopHwl46waj6Ttgypgl9HDw6CTQtgcli4384WGwRnmexIRB06fVzHUp9Lofy1M5syy6AM3hhe+Z
 wgXwhI6ptuE/jEt+c7ZCQzSoJqjbc55aQpYVJoJNsIFvquqYU+WmLDAvcupWlZPUYMd2I=
X-Received: by 2002:a17:90b:52c3:b0:35d:a861:36de with SMTP id
 98e67ed59e1d1-35de691b394mr15494501a91.24.1775545094055; 
 Mon, 06 Apr 2026 23:58:14 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de51fde8esm4541783a91.3.2026.04.06.23.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Apr 2026 23:58:13 -0700 (PDT)
Message-ID: <aa164e63-35cf-4a81-b299-dfa3cc4a5ef3@linaro.org>
Date: Tue, 7 Apr 2026 16:58:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/20] target/arm/tcg/translate.c: replace TCGv with
 TCGv_va
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-16-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260407022748.57629-16-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/7/26 12:27, Pierrick Bouvier wrote:
> We know this file is for 32-bit runtime target, so we can set
> TCG_ADDRESS_BITS. TCG_TYPE_VA is derived accordingly and is already
> passed to translator_loop.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

