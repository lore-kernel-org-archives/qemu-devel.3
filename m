Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C817BC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiJm-0001Rz-NG; Mon, 08 Apr 2024 02:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiJf-0001Pk-Du
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:16 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtiJe-0007Gh-1I
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:17:15 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a51a1c8d931so316879366b.0
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712557032; x=1713161832; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xoNnDsmSFmjeDPz+LlGMu+Of6wJcXPoQLD7hQ57Rd7E=;
 b=Cx3aUSTvpqv2PXtECKWhK5E6iAqZkhTNnbOdX5ywAwDBLeXv0HPy+ujQDGXhKVSyf8
 AdoqQJacnWLjl9mwKlcZ9XuqboY65imNbBDEanIeJuyBIyzlCH1A11Nd6afhf61DX/T/
 D4ew/yQqgfdTa2xz+GphncMCR7E6Jb9Xj9NqOrtLxuGQfVIBtCy3pTpTPUmiiyxqyOKe
 050oWEAWAZy3iWs2wCVp2kFQVMmisu2J+pevu9YupX/3C/AxR7nJLbpNhkFKcCh8QnLL
 3aARdHn2Wf/33qWYQiSvaVpL1VT8al4T99YvRxsfRQfLqnYbFQCaYWTSNjH2t6OxJ6I5
 rOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712557032; x=1713161832;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xoNnDsmSFmjeDPz+LlGMu+Of6wJcXPoQLD7hQ57Rd7E=;
 b=SC21sjpeFZlEp+lIAC8ZaxjwdJ6bxPuGbsXpGWt9X24lL1rlVAi4qqxdShBBtGwJS0
 sohAKGdM8kQoKBPKAGqfouDEaeV9tajt3rEyyq4r9iv7cO7TZXuMrH16UcGm61sGlqRn
 RAQ5J8EYeNPkuZ9t0ErazqEnJUTumHKOa58BHtVdbxJEsdNLybXy+QHkcR6QIEc7CF5a
 2POAQMqIy7smNnH5RyOZB5QccbexvfMgM3DUjmEObKV3pkp3/XJWcQr08cVZAa9fTyLJ
 XdG36VY8x2Tq32oZlNjK7q6w11MAcR9IicsmyVbOs7nHNVfTuZXGXk6ONiboo7Q/eFRB
 cDUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6R9qs5EI9Yf5MJb9MKGry5vZpPWnVIYkJ28TcqOeojcOTZGrtNLyyUtOxNOX5iKwBo3VFr6eDstr4NdpLwuRkVIxzub8=
X-Gm-Message-State: AOJu0YyR+S91T+OoTg0P+0hrSrMkV5toFInvty79CnRYhZL5nuPdtp0L
 ToKTghOxtlZ4mfk58jAjgXAgSeTMXBicR730BTGTrxLYXHork6SCeUKA09Xrvo4=
X-Google-Smtp-Source: AGHT+IF/Y57aeHjuHxSHmOb6VVb/24LQqbscN+6q0qrLXAsGl+f1OE0cnXDfhEdNy7qA4bz6Aex/Hg==
X-Received: by 2002:a17:906:f1ca:b0:a51:d716:5e8b with SMTP id
 gx10-20020a170906f1ca00b00a51d7165e8bmr794869ejb.29.1712557031434; 
 Sun, 07 Apr 2024 23:17:11 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 qx27-20020a170907b59b00b00a4519304f8bsm4076466ejc.14.2024.04.07.23.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:17:10 -0700 (PDT)
Message-ID: <5ad1503d-dc17-40f9-b70a-e593f3614ad4@linaro.org>
Date: Mon, 8 Apr 2024 08:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] target/hppa: Use insn_start from DisasContextBase
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jorgen.Hansen@wdc.com,
 Jonathan.Cameron@huawei.com, linux-cxl@vger.kernel.org
References: <20240406223248.502699-1-richard.henderson@linaro.org>
 <20240406223248.502699-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406223248.502699-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 7/4/24 00:32, Richard Henderson wrote:
> To keep the multiple update check, replace insn_start
> with insn_start_updated.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


