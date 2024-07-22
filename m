Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70456C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 07:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVnEz-0002Bx-SV; Mon, 22 Jul 2024 03:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnEu-0001vB-0J
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:13:45 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVnEs-0000Yf-1d
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 03:13:43 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3684eb5be64so1799963f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 00:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721632420; x=1722237220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8QbqtzH+80bAdyRJysiWzA7WqGjFicVO/p/ujato+Kc=;
 b=YmlOs6zN8wu5pkAdZPgE1n/YhV+cKmOFX8sOWPV7FM/6GrP8tDawGBzjKELU1hLGhH
 mDWcxUhaFi/A/i8LkALQuNdIcbsfrGeMZmxxC10gIvPANkBcCSwMM2+jAuejImvvIjqL
 005Nw2Jq3jUk+l2+J+/FhjdT0ukcQIz3teh5tMXlPnMeUGQAnlSbSexS+fTziNVyvQS3
 6MfqmzDHZbEqFIwAr4SwHb9HREbVTXR+dyJuejOmXs/vXftH8DxNDY1OSYvjPuYpJ/W4
 zyyCWw0yZlDEAAnQn6VbaFpbhVdG2vJ5eVoOIt209pZi+pVcmwEUuhzdSWvSylcBR0bQ
 jE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721632420; x=1722237220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8QbqtzH+80bAdyRJysiWzA7WqGjFicVO/p/ujato+Kc=;
 b=M94+bt3eaibiHTS5nS9xzEINI5fWQZuLDRhrVv7/5YZBmw1Ye64hESz5NFX9Qai7IU
 Mm8TIcWzo5uKkIrguhDbTgcf+GYAylThR2YmzY4lplUY0G+0V6EYGR604soHZlTxpcKS
 azn1iFUCOAIVxYOZrzkp2fVRlfN+8amNhls9nO/mPLBFWwo1krEtMagxpitCD8mm1CdH
 bfqG5iemPHGglLx2E4npO8JCng/aMECkXYdvpwemh6kU4Dw1ZnVDRkepe7iWe/eAkrzg
 KrmyHPG+5r2tQefmPd4+cuVbfiZ5wzMhJG6aiMdZBZhAWvEG/E1aStQQRBwkmHlrJGjV
 k2RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC+7pAtRTkM+nuYYCA3oHLnFMdba0fWOV5qQKZ5Y0Msn5IMxDuNDQRdMDL6sx1jycSkaPBS8YmeQyXNqMRu9mDvMrMzv0=
X-Gm-Message-State: AOJu0YwdOHwxa6qsAXtzmfrguettuqHS1OAQrGGIGT986RbGJZ7lj9Pp
 8BhYqylrotGhA1HafgDIaO/R1ja6HTN/16E8Ri9pYMWZwpHUiRDtB3LHEzV+S6G6bLMmGFP0lYx
 T
X-Google-Smtp-Source: AGHT+IF7RdflSY8ENaUk0DoR3ez/0HshtGXkwdJmBJ4MQG30kKuLyqmoohaNwYVXOP+lNOWwz9iwtw==
X-Received: by 2002:a5d:5105:0:b0:367:9d2c:95ea with SMTP id
 ffacd0b85a97d-369bbcb8af2mr3976363f8f.56.1721632420145; 
 Mon, 22 Jul 2024 00:13:40 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684904sm7705191f8f.20.2024.07.22.00.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 00:13:39 -0700 (PDT)
Message-ID: <fa8dd5fe-04c8-4d1c-b964-61575bdeb4fc@linaro.org>
Date: Mon, 22 Jul 2024 09:13:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] crypto/block-luks: make range overlap check more
 readable
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-12-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240722040742.11513-12-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 22/7/24 06:07, Yao Xingtao via wrote:
> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>   crypto/block-luks.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

