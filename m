Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F612C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPDu-00016Z-MO; Thu, 18 Jul 2024 07:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUPDo-00015A-9g
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:22:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUPDl-0002hK-Nk
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:22:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fbc09ef46aso5901825ad.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721301767; x=1721906567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DiabPrMmEkErgmkicdS7WdMwUFcNRxgYubvdjcXmzgo=;
 b=Y888SXNgYQmMj+dXbpsaDCd22dyPMZpUioiSjPWuU1AzFRD+vaR+HsBM/r2ney//hE
 2EPk5PAIPam9ugws2P2ZwWf9pi3xG0oWFOmrPWbXIctX5cbjHrsYtNK4W6FOEkDGLVwU
 jM43qo1gX9YnGe8UEoM3teF5gatD0YKUYCeIkazFUSuuUPogGBd5SJBoUeChIspky1qw
 zQf9UAqaD7q9MfoUMSKleN24nMva/KMJ0mXwZlFLNI5IOoJzNaDPH9ZnxOz5swUOATSn
 yyIExckT8nLNEnU0vrjcs1h4jhcdTcDqd0UnV2k9rGHff5vZ6/ddtW0w/CYacYBEW87r
 gvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721301767; x=1721906567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiabPrMmEkErgmkicdS7WdMwUFcNRxgYubvdjcXmzgo=;
 b=slHRZ0VLX+CVMSKNcWcAddAtPWMENB7uUSRxGmKPVjd/2wvYmCZHVd1C5cbDMwyJph
 rjlUK1WO/LtC+GtFAyZfVspaZJviAgBTsvqobAks1eFno/lUXZ7GbHo09hfLlsqK+VVG
 beMemyZsjsAzLjfqZo18mWlBqmOCaHBIm3Wdi1smmwlmFF/BooOLienfNXP+wAy/l0Vi
 bIBLBUCi1mb+KAN7grdwuagJaYJcayOTly1atZHAxHRPYCQbT2+h+jqPs0LSHEixHaEJ
 0iYLtft7spvN8/ATDVmpQ9gwmez+KNqK/BOZEhglwm3ShUzusmkeOInQbxAP+/VpQFOU
 wOcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV78UX5Vz09YNrYq3/H9a812i6/yvY/GeyAi5eNkqGYEnNahZdtvZ/vrLicPYWv9XclR3wPzBufdgFbpI1lgJZnPDqytb0=
X-Gm-Message-State: AOJu0YyQt4Bu769sJk+EbP9ZzvH1fgdUZ4l37cbw116nX0tTYKBzhZ4B
 ttEIykkc61LUgJS0JcxI4sE0uiw4/yUSzArQgI8XXT9X59DuZS4V2VHdIhj3rL8=
X-Google-Smtp-Source: AGHT+IGNDA12v1vAFoJf2HmaIrWBB3pEOYvn/zLfGeNEFlemq/cmRYfKH3byfpCe2jyEFVXYzufU5A==
X-Received: by 2002:a17:902:cec7:b0:1fb:3474:9527 with SMTP id
 d9443c01a7336-1fc4e142893mr32921045ad.25.1721301766691; 
 Thu, 18 Jul 2024 04:22:46 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fc55ac2a25sm21273335ad.64.2024.07.18.04.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 04:22:46 -0700 (PDT)
Message-ID: <92f1f244-ef3b-4264-95a9-55cce735892e@linaro.org>
Date: Thu, 18 Jul 2024 21:22:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] QAPI patches patches for 2024-07-17
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240717104907.2962784-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240717104907.2962784-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/17/24 20:48, Markus Armbruster wrote:
> The following changes since commit e2f346aa98646e84eabe0256f89d08e89b1837cf:
> 
>    Merge tag 'sdmmc-20240716' ofhttps://github.com/philmd/qemu into staging (2024-07-17 07:59:31 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-07-17
> 
> for you to fetch changes up to 3c5f6114d9ffc70bc9b1a7cc0dddd72a911f966d:
> 
>    qapi: remove "Example" doc section (2024-07-17 10:20:54 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2024-07-17

Applied, thanks.

r~

