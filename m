Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC96CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 00:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX6z0-0001g3-3D; Tue, 09 Jun 2026 20:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6yr-0001ev-HX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:39:43 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX6yp-0008Jn-Dg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 20:39:41 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c8573e75425so2364347a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781051977; x=1781656777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSvcx2+xR6VoUu0CNDsuzJ7SaXu0Isn83t2MX6QpVDg=;
 b=nyCuNVBJiTsm0HbuinECiP+hktpjD4aQwsQ4HwdLyIHBoZbZ8ZjwsSJilq+T47xQLx
 yFBx+q/wcLBAWfqokqkenYYPYHBT2SXf0IkN/glyM0nwSk/pphmzqo3lqVMUtKr7EB9a
 kQVNVVn7LN69H6k4ytsfvf45IuW2QEdKU5q9PB5tpdXSVHOUzk1ZvJoXUpMuOZSaAh+w
 gYxjBumv4Z/DNOl9YQ0Qx4PaAmTpg9NnmgknLKrYpyD+JSjFI0eP/ea1u2gKtW8Do28X
 ESGpmAWFEhKo7koer7QwQZQRtfl1Nr6mcWWwHIy6pLMPA55p7ObGfMZo9Q3xeN+T3N3E
 Heiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781051977; x=1781656777;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSvcx2+xR6VoUu0CNDsuzJ7SaXu0Isn83t2MX6QpVDg=;
 b=HxPfRysnWi4Jqe0BshcWYNB24VH93YPjSC17y78OLVaBIzOuQJvu69LVoInQgS9z8v
 tJi+xoz1GYfbA0zK/YtnOuAyKEBSKVA1sG6lLFOVDq3MYJjkTScixl3ISOb74/Kb0Giy
 Tn+aZhWqZLrlt0dnVp3SHeZq+9AXyAMEQujX9/1PmF4D73OuHF64pKC/hu2zspZP2tNu
 PPjNNEMl3FmcwwHmuwhslmABMIQb3FWrqiQgPq2QMCyX30Eab0vIap5mu85SF5qBuFXa
 aH8XmpK0TeJ8MFWqh7borB3jLVywpZQvLQCbp79qXSiPx21LpyEgz9DG5l9H9boSYp3h
 1SNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w8/N9kRwIo7cdjAV5pFyhm3r6tfDUM/94WIlPBnPVEVI5/b7c8ktgwlgECIlBqOv3IBv1UkC/ZJFO@nongnu.org
X-Gm-Message-State: AOJu0Yy48x9z50IGBdBOAPmtcxmp/yN2SnCtJ9xDPWJhc4YVXce5sH7L
 KfaYR/2IaaaBL6bDMXctXShBfg+WcTZ87cP45hVOY7ISzELpkWdjjU1rb/gpxRW3ck8=
X-Gm-Gg: Acq92OHn4nnTP2U9KmY87V4sEkHdZbZ5xAJPXB0Vot8VAVDP4iTgFkFspFMeUCAV2r8
 +ulbAsO37IqZEgSh7X0A2bGUkSiQFqiLC6sWfn9EeAnsCDUuttylL3XKC8YcJ6p59NSL48Ssma4
 HrBfNtTOdyA98LoYLrNk1v76XvUCRmhv6WDrV/tNbvsUGO57ap7OD56aq3X8DnSMi1gaCvHTq92
 9iI788cusS5+q2LwDFMsOj4RyC8C9YBxS+DjNUrmjBtgPDlyLzrXUDGJ1t9VKDjFwf2crt//iGg
 I0Z3X0XhPN6u79F5PVBxMJa8mJcO4N2jHETdLiQGhM019iShdhF6wNhPTVlg77uTr4AGwQvls6R
 yo+kg5p3rfSc9fBZPxtcjU3VqkMfuWrbrt+vFKxfqvqmAsZW1xcN4SDe7CnfNPV8e3tc9G1VN+P
 zYYNOkrE8n5q9lLSA+crvBFvQHVfeb+bWZUCdD30XU8w8v/AY8FUmtgTqqFQ==
X-Received: by 2002:a05:6a00:2392:b0:842:688f:308a with SMTP id
 d2e1a72fcca58-842b0f50377mr22628878b3a.30.1781051976703; 
 Tue, 09 Jun 2026 17:39:36 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-842828e5638sm23325446b3a.50.2026.06.09.17.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 17:39:36 -0700 (PDT)
Message-ID: <682cbbbd-dea0-42f5-abf4-f1ee36d42346@linaro.org>
Date: Tue, 9 Jun 2026 17:39:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Gustavo Romero <gustavo.romero@linaro.org>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-4-pierrick.bouvier@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260609214745.772536-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/9/26 14:47, Pierrick Bouvier wrote:
> We'll reuse this name later in the series, so change existing script.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/multiarch/Makefile.target                             | 2 +-
>   .../plugin/{check-plugin-output.sh => regex-compare.sh}         | 0
>   2 files changed, 1 insertion(+), 1 deletion(-)
>   rename tests/tcg/multiarch/plugin/{check-plugin-output.sh => regex-compare.sh} (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

