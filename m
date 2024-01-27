Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD71C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaa6-0007TW-SB; Fri, 26 Jan 2024 23:46:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaa1-0007T7-VF
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:46:12 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaZz-0000R8-Au
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:46:09 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-602d2e67217so9706047b3.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706330766; x=1706935566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Ej8Whjb/tkTdOEDA2Nt4kmImNiYJNkqP19h+gvQ05o=;
 b=X0mnIGfRFJ/7Dn/nmsvTsS0IXBvvsVjS4fl5CRZ9fEoFt21ZnyOTH9TrKm2X7hyAYx
 sy6b1AbuNGxvNW1mTPw0KP319Wk1KgVSpwf8rgCTcoLXoCKmQXa6MxqvG9m8Z0R2r9vq
 eJCkAyRx3wTzg0YjAFYNYMIoxvjI1nQ5OG4YeQ/533avmkxUOcJC7X4mpJa3+Df9C/a2
 qZAM61pUrSQN/WvizNg1nMexCOUHhm4L2dv/BYeCz1ua4XMi0+U24M8c26tio1ZvyhQU
 /MmTiL7J/SFtMoewBQxC6FKSB/0gpOpKMyVrlMNja2sUzt+ogdvBBJE4SUThkS0pdabI
 FgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706330766; x=1706935566;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ej8Whjb/tkTdOEDA2Nt4kmImNiYJNkqP19h+gvQ05o=;
 b=mayZw5a1NeWlODQ7H9IfYvK1cYLjo2f0BSbIYnamr/2E9aC9sxPdkOJ9MZ9jO03oku
 xqG38BwAAcCU16NeHLWUvikl3pX9Gr8Fy0RlW0zIyE7wOmmOx2TZT3zhHVUOmThGQWMQ
 nJTUzRW3rLl+IjYxjZmygoahjDvZBilWk+9fVu9ko3tPVXJoyDFmgdP5mJ5qa0eD/aQw
 u8qAyyffPYj2Ot6IueJkRwduRwHgk2RC3bCnPJFIRFYbM+p7/GMgCGExjdFVd1uTACgD
 wCfL5XdmwQDOk+wttBpiIUqubjcpsoD5C0tyGCsme/OHT2lo/eP15+RfRrpYZq5ndBnc
 xLSQ==
X-Gm-Message-State: AOJu0YwZfy/UsuqFJ8eDLtaGGdQOZMTHBnfCaswLwecKBnUbYFtVukTY
 rkxnjRDQ5p4JMnha8NoHZhFTlusN6qy/IyyKeJWSvbXQLRn4IuoMyDSW08n8V+9Lzi1D8QbQhO8
 O5LI=
X-Google-Smtp-Source: AGHT+IFhHpx+NsdREY+Uq7mu1wBWAF1AyEstzYaTrAqpPvoDd4KIJyZaapOaRoShI0hRF+VVTg90fg==
X-Received: by 2002:a0d:d2c2:0:b0:5ff:a9bc:b7f with SMTP id
 u185-20020a0dd2c2000000b005ffa9bc0b7fmr1019806ywd.21.1706330765935; 
 Fri, 26 Jan 2024 20:46:05 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a170902d30400b001d70602f550sm1693037plc.27.2024.01.26.20.46.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:46:05 -0800 (PST)
Message-ID: <4489fd4b-0999-4902-b08e-ac3fd097b516@linaro.org>
Date: Sat, 27 Jan 2024 14:46:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/23] target/s390x: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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

On 1/27/24 08:04, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/s390x/cpu-dump.c        |  3 +--
>   target/s390x/gdbstub.c         |  6 ++----
>   target/s390x/helper.c          |  3 +--
>   target/s390x/kvm/kvm.c         |  6 ++----
>   target/s390x/tcg/excp_helper.c | 11 +++--------
>   target/s390x/tcg/translate.c   |  3 +--
>   6 files changed, 10 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

