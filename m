Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7861AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 16:18:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rf09s-00034C-JU; Tue, 27 Feb 2024 11:18:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf09o-00033k-BI
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:18:16 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rf09m-0005lu-S6
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 11:18:16 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33ddd1624beso1208040f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 08:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709050690; x=1709655490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4a8NqXIW2TT9tb2ldyIqd5zA02DDJ27ztOnA+0j8ENg=;
 b=MZktJR1ZnYGvXC4F3gEIdOrCTaSCaCpEZKKm6r4IXM+Ah2mcmy1tN8UBQ2RVuXSlIR
 ZmlOLNGOKf1M3KjZuNc3EIPO0bzKsHSpU1H1YCPOVUwqgh1IynxrU9GkVqHUBGP1w+Li
 m7Ccjprm6aIGAuGeUxUCqGkwuLqlVFzI+r9fgEA5BXEGD0vDxh0cgjMpUYLwXzZGD5vH
 oTl75wVIrd7d6YFhYPDZoKRHYNTJ73+XC/gfYVz48GIibrRIx1X9U1LjzwvIkrXXASgN
 eMg8ZJndULi7Y8gjEE2uRVR+CAikc9oVtxdDgQjISJeqBCteTavVHiXSiLZIkG1/0lf6
 5tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709050690; x=1709655490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4a8NqXIW2TT9tb2ldyIqd5zA02DDJ27ztOnA+0j8ENg=;
 b=xAecdOA39OIH97pbsFuRetX44WBtqXTbbHCG4NtMhPBIGVRLPsfb//OW/782obfDcm
 uGLN0zdtwWmFgdtDw7tba73yQytukMiMmR/JZGoYX6oxok0yY3iADPrLTM/0+J0DUPh1
 p1Yokuv5b4QO1+y1Ucreu6wVc9bBihgFnyQ9pY3hgidumwBTL76AmChe6gB9eCCpGjlI
 SiKtnWdqsZwC1/kOs6PWiwiGMAF2gLIp9QLYv/6ysIzgOxtzvtVjgRR7w79Uw9iItCsY
 c5qx1Mlz/fxw0BRb0WaxZHXAUIs7C32DEFCh0dP+P0g4dyrgqPIvHdhYrTEDpClySZE1
 zTxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNE3tvT5/ZRlxS8N1ZA50rfNvg3bdsH2GGOToMjj84FmxLv+cbmbwRySw34ZQn78p1fuilJsIoJYzFLF1d+lJeEUl+Sjc=
X-Gm-Message-State: AOJu0Yy1LShAHw6tbjdnLDZtHp34IRXL9H+X7XCBMrhq+uMDdDcCY2/D
 lKwHXKFlYjwZnMPqwj5dv/lRpaxKNxnGRR80+RruaQ+F8wWa5KRt0z0ikBQxoVw=
X-Google-Smtp-Source: AGHT+IGt/pQEMvA4isJ+xcYGiWBie7IVL1BEx0ocBORWF7uOx8JGUfMCMGgimPuqonUSEdFJZ76ECQ==
X-Received: by 2002:a5d:5267:0:b0:33d:47c6:24fe with SMTP id
 l7-20020a5d5267000000b0033d47c624femr8827100wrc.12.1709050689921; 
 Tue, 27 Feb 2024 08:18:09 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.23])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a05600c35c100b0041228b2e179sm11755481wmq.39.2024.02.27.08.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 08:18:09 -0800 (PST)
Message-ID: <b7e48172-9dd0-4a4d-a2d4-75b1515597bf@linaro.org>
Date: Tue, 27 Feb 2024 17:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] qapi: New QAPI_LIST_LENGTH()
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: steven.sistare@oracle.com, dave@treblig.org, jasowang@redhat.com,
 michael.roth@amd.com, peterx@redhat.com, farosas@suse.de,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240227153321.467343-1-armbru@redhat.com>
 <20240227153321.467343-2-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240227153321.467343-2-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 27/2/24 16:33, Markus Armbruster wrote:
> From: Steve Sistare <steven.sistare@oracle.com>
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/qapi/util.h | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


