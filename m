Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C881D149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Pq1-0007G6-ON; Fri, 25 Oct 2024 15:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Ppt-0007F2-Qf
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:19:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Pps-0003oo-5J
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:19:01 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20cbcd71012so24115005ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729883938; x=1730488738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MJ9QNAuL6b1gV3z/ZNgXMFXPDD7bVHBcciFaACkVTRc=;
 b=JCRuNcTx2dyyFkT0J9AGDOm4l6nreTjpcyWppJbC1crLmrwZRWZXI5KWj3QlqIUd7b
 2lS82GyITLaH/rz6Z4pEO/hcfkxw/CgNuayzDNCqxMDqyzbDHLPMNXVrkBev2CtsUWIE
 AI5tG7wCqXpQpRAbUpkRp8K2bWOF34Q+vpLI/XXLWJ8Zy7APitsbpdZzULnx9kYQb0bn
 pbzKcpND9wUDjNDBXFOONbao5iuPfXBaIBwGqZhAN4eD9wNPcfWmSeF8XUsZMEK9vr7t
 sEH5yGwsazHZxMe63Sq3kDgFDwL2mGA9SMjtd8yINB6SyGWexKF6GsjXB8cGzTaHx2UU
 ELPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729883938; x=1730488738;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MJ9QNAuL6b1gV3z/ZNgXMFXPDD7bVHBcciFaACkVTRc=;
 b=kvZzpyGz9pQLf4CQ/+RRZBJUJZ2trXMp+CwbYPDUlyTVuppVwQ2B7iVbuIItEyeJW2
 r2iaNLJItIVuIgmZU5iXnQpvVcUFx+xT7TpZQY6kMDzaUJk15dTj2J6NbZ0Why6mam7A
 JNuub2/joYfQ2gfe15jkk5JpMvAkFUaTrPhuuFrUtr5HInnNFUzbwESOtFCQk4Jd1UYf
 70nw2KSreDuTIlK8MGrey9++O4w4BUfQBFcxJfJqN44cK17cp8DMlRMqTekmIApWNdz+
 lPa9hsxnxwEMI8kP7cdxIRqOr7mDOw/FneC6lGInTePbKuIQP/JHwHC9/UtKfaR/9/oT
 ZnLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTONqiUQoq1bdq5q5ThK4G8aliEzG3V5FdIeeTPy+vX3XSZfCpdJfMCnNhjlKOYHGCowWR7rMGP5uj@nongnu.org
X-Gm-Message-State: AOJu0YypNo7UGsxt3WKHUDC7SRugyhSYOHJeAfN/mt+C6Fz3hKxeCxI9
 8wCFCiSIRQR58vB9Lo14dsPB6XbsTvlAP2pzl102ld3+FptanQ5esqnMqmJ71tQ=
X-Google-Smtp-Source: AGHT+IHiXmjKJc5yZp8uu3GMXyWTMIcQvlpAYFP+Q4xBFBajCMTnCUODTqAN1Dda2sCelvZWcekfEw==
X-Received: by 2002:a17:90b:3e82:b0:2e5:5e55:7f18 with SMTP id
 98e67ed59e1d1-2e8f107b9efmr463009a91.24.1729883938228; 
 Fri, 25 Oct 2024 12:18:58 -0700 (PDT)
Received: from [192.168.2.252] ([201.190.186.93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e77e4cbe79sm3896048a91.17.2024.10.25.12.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 12:18:57 -0700 (PDT)
Message-ID: <1464da3f-e9ee-43e1-9b3e-c405b91e0144@linaro.org>
Date: Fri, 25 Oct 2024 16:18:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] target/mips: Enable MSA ASE for mips32r6-generic
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, "arikalo@gmail.com" <arikalo@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
References: <AM9PR09MB485153B7CB706E188DED763484402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AM9PR09MB485153B7CB706E188DED763484402@AM9PR09MB4851.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x630.google.com
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

On 18/10/24 10:20, Aleksandar Rakic wrote:
> Enable MSA ASE for mips32r6-generic CPU.

Commit 4b3bcd016d8 added this comment:

         /* A generic CPU supporting MIPS32 Release 6 ISA.
            FIXME: Support IEEE 754-2008 FP.
                   Eventually this should be replaced by a
                   real CPU model. */
         .name = "mips32r6-generic",

I'd rather we model a real mips32r6 core. Or for generic models
enable a feature using a CLI flag, i.e.:
   -cpu mips32r6-generic,+msa / -cpu mips32r6-generic,msa=on

But this would need quite some rework.

> Cherry-picked 0186e83a0613e90aff6d4c12c91cdb080d695d37
> from https://github.com/MIPS/gnutools-qemu
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>   target/mips/cpu-defs.c.inc | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Patch queued.

