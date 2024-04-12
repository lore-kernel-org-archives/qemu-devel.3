Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E94C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKac-0004l9-Nh; Fri, 12 Apr 2024 13:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKaa-0004kz-NI
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:21:24 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rvKaZ-0001v1-7K
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:21:24 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso856342a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712942481; x=1713547281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=giTUusHE69G77DRHyQglqRjDRIwDR+B0rDQUi+EZv5k=;
 b=SJ2sp1Pkgq1XjSjnRLG6i0mO8BJ9nCkhkqMq/2iSVHQUlMQPtD4GZUUVSLy7OMXvUD
 VVlNiKEHADz8TWmBaB2TZvYDq4sgnISM7DHuVJ4fwOri1bdpUbJz5wiMRnKtC+WZcg8d
 XJHhC3XwEitsmWOeuPfe8W6d+BeLbz7rClZ80s13xUlxKH7tT/PKQ4umcr2bXp0bkK4H
 OAqMWnMvwN5tEuefNbFO9Zux25bo2FOlMtaV277Py+ymDhr5DEQuBuCPpqC2wsNXuGgN
 KmyL3QDgmWTzxumSRYFDUB099Q4bZo4VXm3CSuufxbgioBh2OdKxRW6B96nejNX9hoTE
 oCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712942481; x=1713547281;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=giTUusHE69G77DRHyQglqRjDRIwDR+B0rDQUi+EZv5k=;
 b=rgj8n2iGhTmTk6Mid1PXIm5h8PQphxAOI369fLUzV1lAsCQSSxoXlksHb0jpFicc+Z
 mzGIhYBKooX9jF1MiNOQkIP2U/8pVZyj9XQR3mdhdPKoc/dTU1poKgy40Wc4a12+o0EA
 gY2dgsTjF2as22C7RaiqPJWCojFEOvcc5fMtFeVFATjsWHFp2NyXaMAUdR+xkOxvmWSM
 PJg3tr1yqb7yPy0dM5G09ZBKJkyQYrltPO0AjhMgWyBGsPRJ72XA5BxhSAzsqY0KcUDi
 bGLAKEPgLi1cgObiV/TUvKXSz6IJmChH72mkNaE5sj0IwaVyWZ7/d1j7ZvNMrO4JJ4qY
 knaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAn/QYWh/zxIP7SXqZIj8YU//JTkYGKP9warZzKQr82sbfhL4qryaLfcrSXgU1LsKobyoTWREOejrZtYCRF4XT88KfRgk=
X-Gm-Message-State: AOJu0YwIUGZi8ceAKUg8KB3v4ek04KBN7MwCOJ3szjO8hQu0pkgdy7wp
 1qTFLN4CP/TMQCElsvJAAgXzNI8KcrzzERQVzqpM3AkP+EtytglGhIS1Tlo+Ejc=
X-Google-Smtp-Source: AGHT+IGiSjvPuas8pARaY2+L6K2C+ott31b74U4ZF9zUQGrFyu8uMZ2zn6Vv12QDjd0LiZi6n4pORw==
X-Received: by 2002:a17:902:f78c:b0:1e5:93fc:efb4 with SMTP id
 q12-20020a170902f78c00b001e593fcefb4mr3713052pln.35.1712942481581; 
 Fri, 12 Apr 2024 10:21:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 kw14-20020a170902f90e00b001e249903b0fsm3240601plb.256.2024.04.12.10.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:21:21 -0700 (PDT)
Message-ID: <2abdd5fa-707d-4b7b-9114-cc0143d66a50@linaro.org>
Date: Fri, 12 Apr 2024 10:21:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] hw/misc: Don't special case RESET_TYPE_COLD in
 npcm7xx_clk, gcr
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
 <20240412160809.1260625-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240412160809.1260625-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 4/12/24 09:08, Peter Maydell wrote:
> The npcm7xx_clk and npcm7xx_gcr device reset methods look at
> the ResetType argument and only handle RESET_TYPE_COLD,
> producing a warning if another reset type is passed. This
> is different from how every other three-phase-reset method
> we have works, and makes it difficult to add new reset types.
> 
> A better pattern is "assume that any reset type you don't know
> about should be handled like RESET_TYPE_COLD"; switch these
> devices to do that. Then adding a new reset type will only
> need to touch those devices where its behaviour really needs
> to be different from the standard cold reset.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/misc/npcm7xx_clk.c | 13 +++----------
>   hw/misc/npcm7xx_gcr.c | 12 ++++--------
>   2 files changed, 7 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

