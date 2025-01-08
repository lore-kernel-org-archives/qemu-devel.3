Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8215BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdAJ-0001YO-As; Wed, 08 Jan 2025 16:00:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdAF-0001Y8-Jp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:00:31 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdAE-00081l-97
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:00:31 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436202dd730so2041475e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736370028; x=1736974828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svlsN5LRzfjU1yHS9TGXWTpTanhIVGfVa4dR2ovC84o=;
 b=A5mrCHe+jaqwtjrOnPz/mEMYbsOz8pEz2Vp5ewk3BN/fXlL5Ngx/YYjPWUfipFIImt
 ObCBnV19bOK1QugnLVop/wTdKR7jCTLMPt5GzPktSFfjwOhOSte+LamJGgrU/d2E/zcB
 RqZvnLloZtXIXvjj2iZ0myS61KUgIZPA1+CCm5ACZcDAXOnI+JBI2LslVv7463+DXULv
 YpefoWO/QfHJ062m8f5NsWCu0V+E5yx/6dGxLZPtRHE086ky/oHKRomfXlqesnueDYGx
 r5NnNnR8U/EYcgM4ItOHlJD4ccxnwnQXUX2nm4PtfUxJwglJMD3IXjUd1lVR9gvCgeII
 lDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736370028; x=1736974828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=svlsN5LRzfjU1yHS9TGXWTpTanhIVGfVa4dR2ovC84o=;
 b=mH/Fa7PhkIGl9lXlh2DtcumQ1dpIhuj44GeYkV99wKpCMYisRbfUiiBlaKUP26MX3P
 p+E2f/kh2f4UxLWKBXpkhyj8Uam9fV7Jy/TsWkSLIyRA2a/IKQTCLmxTfk8ERzrnrMco
 3baekfxc34WzwcMIuXy3AsnCm8Q+4lwmRcFHYwZvMREfi/uRPDvdLWU2imKDtKBKduEq
 64wXN+/SnCvpG5jdfEfIcaKlj7NNv8c1Qg2vnIfcOutOwxPRUinX6/kZ6QeAV2NqLnaq
 b8iCt8NBoiqg74fSJMAD61gerxcfTmGAYSrKrzfTEwGkylWEdUtSu19UjIx9WErM+uIK
 T7Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr/MZzft05XMUln1N/edQFeKjKr94IhmbD4ytJEtr85GgB9fx2yT/JvnW69sqXJ5M9WxYaiBt3MdMx@nongnu.org
X-Gm-Message-State: AOJu0YztsWMdp3Y7zRPnFfvpwmKQvN1ybfHSdR/dOmTJ3SCNg24Evgsc
 4cONK2bWoPGrsERGFgg1auYbVbd3L3gPBtDZk2UKtsrDwxBKj9iffIy5sRMd9C4=
X-Gm-Gg: ASbGnctFIQY5FIgO72bLQslDBaOgiBj8z1T3ymXjgKGyxu9a6ot9wCJettuE1uBONku
 258P+Jkd0tUBR0eDb6QtOgZiAv0QFYtRBvTFxBF8NMuVRc4QgHQNcA2IWQDY9GhtRLitH8Pc45Q
 OlhzbPRgZdGw7MuoKzvPipXd2MzrIFQNl3NA/lyQF4f+u+0RbzTl4PdbDp8rYN46r291wYohMw4
 S012n+IvieG6N3qtZabJY8UJlR0j0TybowvFiHszzOXc+2T1UwSWKjjIwpz7BdylBEgy0j1UPZh
 62cXd4aDcTNfTqt2oaPTbzyQ
X-Google-Smtp-Source: AGHT+IENqHb525PzEjg+9BYA8ttZPj4oTVjk9Fib+TidveHAL8Rffvr9z5F0tolKB6XODoEsfKw+NQ==
X-Received: by 2002:a05:6000:1849:b0:386:2ebe:7ae2 with SMTP id
 ffacd0b85a97d-38a8733df9emr4200102f8f.45.1736370028578; 
 Wed, 08 Jan 2025 13:00:28 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e278sm54454392f8f.75.2025.01.08.13.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 13:00:27 -0800 (PST)
Message-ID: <a930937c-730b-4d15-8cdd-9088df6349df@linaro.org>
Date: Wed, 8 Jan 2025 22:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 66/81] tcg: Merge INDEX_op_xor_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-67-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-67-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   target/sh4/translate.c   |  6 +++---
>   tcg/optimize.c           | 18 ++++++++----------
>   tcg/tcg-op.c             |  4 ++--
>   tcg/tcg.c                |  9 +++------
>   tcg/tci.c                |  5 ++---
>   tcg/tci/tcg-target.c.inc |  2 +-
>   7 files changed, 20 insertions(+), 27 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


