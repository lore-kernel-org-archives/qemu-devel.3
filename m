Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E21CE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHiT-0004HN-HY; Fri, 10 Jan 2025 11:18:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHiH-0004Gu-Ka
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:18:21 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHiG-0006bf-63
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:18:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so1222828f8f.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736525898; x=1737130698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V+P07vdPSkEX2TuJTRyhZJEGSoIHuX0GpD2DWlL2imE=;
 b=lepwxYu3YHZG+wC/4BZyHt+Sn6FVFlzutSF3V4zeqnab2hATUO0NPq6hkwBvF1zIaV
 gxMmnbAaK7VNMAPkxr8Ki2wzMKaYs6ar4bxAlq1n3Vz/Pp4DjiY0oj3I1gLCV27uXpsJ
 jr0sAMmi1UazlVemu5b3iyndmJmCfNSb7PblTz282AvD0s4UnKYQidPK1qhI4DesaB92
 ff+Mx/X9lqkbEe9sroeGcio9W/t6alzmdBtyD4TTO2h2xMWRgUzKLokrIefv/IwKkSCc
 YiJhHAp3NSiXSnSmtZI9QuKrLjzUvQGXdkQIHqhhfikYGpB/q8dVhbnh8+XsDBy42ayC
 eYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736525898; x=1737130698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V+P07vdPSkEX2TuJTRyhZJEGSoIHuX0GpD2DWlL2imE=;
 b=UD2qIJqgD5SnRh/RqN92h7zxfmQeeZsP9v+Rklkf1BVWQmGGyLJ+cOno0XIA3a+yC5
 A97ZrMV4JDqKG4kPB0HjSu49ig2V3GmKPAtjcqs0HL/U2ZgrK2BdK45hxnyZgdiRP0bh
 gQgYtMsyQU6SGHPM9q9cYTlatFsOw2jUdcm2GilaNrjDgqcg2SKWRAdMmLgumbROOdQY
 0NjQH9GIa5XVtt8ODuFVgsmJyEBRpaZ5XLgNh/mYO9y5JEYVErvWfp+/Sfh5daSqD1Ic
 QBkzjv0CFzRBatE36hxBTiIzuaXyF63meQxXTQlkQspUpX447NFmvn9mXSBONuR4NBwh
 8O4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtHi/wjx5nhl+owI8WXvQPybR2b375E9Pbk4LD/AM6X6mKHjEx3xkXSutHsVvTbXR3VmLWStaJf3Da@nongnu.org
X-Gm-Message-State: AOJu0YwshWYwLrj3l+Vk+Hjppo4E3H6m2DzsLyeLV5dLBvN8UBV6e7+g
 3U4C/nmvBnv7neaOZY85ESDQhBKXpSD0oPZvVZFkPd0BxBg/wn+Li2CL+l5lMgc=
X-Gm-Gg: ASbGncvTxRlevUs/fLnZCFeNHWj0GVzrgr6503gHxthUAtluJp2XDQcrDd+fR3FFQFk
 mpoLhosjhINeLBrgb13uaphhZQH2UG9nu2xRW/YsSRHeM65NiqgIszxT/EQoLKAuATiDETEJ+3+
 TLz3wHq/GCLCdlhBdPw3B8pA01UAPYHItTqLt2VbFPvfmkX2rVy9n++hrdy5iXHHs9Td1GURNDR
 tgV81FueBj5IAv2ol5+tIMhoJplDYZ0hgCRQnq5DqOCCR8053lN4wanxjT33VK3qVgokYPAaCqX
 Ccomn70+xeh4Qb2yX8QsXYPv
X-Google-Smtp-Source: AGHT+IGPH9gNSWLgG9aOfjVcU88cJpIqqszQt8vZCprt/T/mGcBW40BTfM9d8q39U8opbSSRyBlwKw==
X-Received: by 2002:a5d:6d09:0:b0:386:1c13:30d5 with SMTP id
 ffacd0b85a97d-38a872f6ebfmr9843511f8f.7.1736525898558; 
 Fri, 10 Jan 2025 08:18:18 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d2dfsm4829143f8f.7.2025.01.10.08.18.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 08:18:18 -0800 (PST)
Message-ID: <345e6d53-04ef-4c5e-b940-05c892ed87bb@linaro.org>
Date: Fri, 10 Jan 2025 17:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] libqos/fw_cfg: refactor file directory iteraton to
 make it more reusable
To: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org
References: <20250110104619.267564-1-anisinha@redhat.com>
 <20250110104619.267564-2-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110104619.267564-2-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 10/1/25 11:46, Ani Sinha wrote:
> fw-cfg file directory iteration code can be used by other functions that may
> want to implement fw-cfg file operations. Refactor it into a smaller helper
> so that it can be reused.
> 
> No functional change.
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   tests/qtest/libqos/fw_cfg.c | 62 ++++++++++++++++++++++++-------------
>   1 file changed, 40 insertions(+), 22 deletions(-)
> 
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index 89f053ccac..b178d0b1b8 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -60,6 +60,38 @@ static void mm_fw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
>       qtest_writew(fw_cfg->qts, fw_cfg->base, key);
>   }
>   
> +static bool
> +find_pdir_entry(QFWCFG *fw_cfg, const char *filename,
> +                uint16_t *sel, uint32_t *size)

Please use QEMU coding style.

