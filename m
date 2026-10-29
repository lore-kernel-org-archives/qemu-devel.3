Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11942606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oqAgA3Xe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQ9X-0002ue-4o; Thu, 29 Oct 2026 09:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ9S-0002uJ-U2
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:26:44 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xMQ9R-00006u-1H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 09:26:42 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-7037daaa820so979151eaf.2
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 06:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793280400; x=1793885200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JKx3TS4dtd/4+9huKymfOSTUCi20CAfUFi38vFAgqv4=;
 b=oqAgA3Xe9338G4f6caap8d0HlKe+wH1fV6efu1zpnBQGKQmuhdcrGeB49dt72s6eW6
 G2WFPWNPlehnByNy1mx/vxf7poBsji+F6HIYRAk+ByOQSNO720q7p6KQlpDwQzxApejK
 rueGHMZgvJf0rnBXzt+AKMqX9ilh40ZMEjipsCIg75abD2+CSNW3grspMCt6V0t14NbG
 4lKsszwMszGnmLkDSsc5Qzq6nuJKu5E9RaN0+tsZHqcLVLjbnkYEOz4RJx2hpTXvxbxi
 ohQc0NTumVwazYuH2qwI01LBMXD/GuNcDdQ9w7wEjsWv5B+wFxk655qIOiwfpOj1MREo
 w2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793280400; x=1793885200;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JKx3TS4dtd/4+9huKymfOSTUCi20CAfUFi38vFAgqv4=;
 b=mQnvZ+QtdmUuxmZCb4KVqgtsQW73tiqeBpElx4OUbvrvYsI8wdA7yYto/c41YH4Nds
 Qg3AffsWdPv5k1NwDAsbi/QqzJaTe506LaavHolaUJmvS60LutlwhWs6AAJtttFtB8EO
 8wDH1m3G2BLY54OBU6sIZ7ybmn4siOWsLzTjxtwmVrqxpMr/AXSI1eeHBuhDo61GzAJy
 OBm5n7ZazxoxOjYewSsPL67mbmdSNIOe3tVP+6SO9Ju67kRQDPOrAseOxlh5YkXDDDCF
 3jSfg7V09ZYGWmfMlEYoFfthvSv1O6hGhk0A2V6QjqKMh2wHfbx+0s6GwdtAuP7aNbwK
 AaQg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRY/JcBSz3ZUkqX3TS5HzKSnJLtEdrL88B3+D+uA6V9HA5vdAC90lN0fxg3oTo7ShQh3PEiJYkvbJT@nongnu.org
X-Gm-Message-State: AFq9FYIvVceCS9SgajtzVtCsHwSb/i/9TnHroRHavQ4Xv5SM4AHiU02E
 FqvATv6e/UItpPqE0HaJttG8qZ8/kW4qFa1gq7R0jnW9X4Tkit9l8ez9mQht7qPrdw08VvMH13l
 renCr
X-Gm-Gg: AYBFou257OqaYWGRzipbsWoasb0pteobdL7O7mVhiAG4Yov9E/HPAXMLyt7eyeUblhT
 snaNr6kvWxaN8SS/exU5hb9HOTLl0zcGjoZH/++wM3CLE+5yINNNrlz0ON4tTNnST8wJoukbdQG
 6Y16HMxLOluyiHfo8AZXKw+c3tiW8a15v08UDl51MDwfO2fIOS+gRsDBLG/5QeF2NYHvH2g3gZ3
 AHHvTzTRmpST6jjLnb6Di1wGHVfMNC7LVJFggXGIq8ubFPtzQrB8M7mhJyCydmMLkdF6bdP9Z2X
 QNB4M5xbTa0LElx4CaVl/ShBwXS2zq27X3TMyvEfd+tGwGlRJbAe42+pPAUM/C1EtwLcb3KZp0Z
 yqtmK4K18RgqpCx7LUZs/s/TWP/gnCSM8UxwT/TuEoBPYLIWjgiIIfgwIto97LXv8y/vQeU90HA
 0oVdHQ+b8vyA+GMdKaU73snw2Du9W3bJaI1RB8afH3kwJZStWaoNJOMac3vzohzx/8SbacRbnph
 00C52fVdy6vtF34PT9QFpwgB4ujvxV9ysBw3Zf+JGgUfBA9IrjuXm9wcgffYAYh/hvdKsoJ2A5r
 0JVw6yqVwcGJQiEWK8vI61HTt00mr+k9peeE70vZBEpE
X-Received: by 2002:a05:6820:4606:b0:713:e789:8d5f with SMTP id
 006d021491bc7-713eeb55da5mr2426443eaf.49.1793280399717; 
 Thu, 29 Oct 2026 06:26:39 -0700 (PDT)
Received: from [192.168.129.53] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-7142c7357a5sm4212429eaf.7.2026.10.29.06.26.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 06:26:39 -0700 (PDT)
Message-ID: <63dd2100-a0ae-4369-b5d9-e1e51be570a4@linaro.org>
Date: Thu, 29 Oct 2026 08:26:37 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/33] target/alpha: Use a static table in
 alpha_exception_name()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
 <20261022215115.19680-7-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261022215115.19680-7-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/26 16:50, Philippe Mathieu-Daudé wrote:
> Replace the switch statement with a static lookup table.
> 
> With '-d int', unlisted exception codes are now logged as
> "unknown" instead of "<unknown>".
> 
> Suggested-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/alpha/helper.c | 55 ++++++++++++-------------------------------
>   1 file changed, 15 insertions(+), 40 deletions(-)

Oh, two patches.  Ok.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

