Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5B8C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 13:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWFfu-0002MK-0h; Tue, 23 Jul 2024 09:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWFfq-0002JM-1s
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:35:26 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWFfn-0006N9-Dd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:35:25 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ef2c56da6cso24512361fa.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721741719; x=1722346519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TtSQA4qzE3qFe+mObrHKurmvnL+QkrVHjWKCqf70jvQ=;
 b=kGtCTtM2yvvQlgF50zfVSk3DHWu5zAr/uzVImzsWqxUHHZm3LTKAChAEqmTHC+n+uz
 uf7JfgzEtjCHx4t4vPU220R8yzgWm8HFf3bjhk/IaWVy4prcCC3UhM+uA32/BT646bJZ
 mw7skEtYAzK2MGo2VwMV27cq5lBSITFHj/4CiBPNU4ZtxpV9hy6DBEa+zi7gBKAkNQ7X
 rwnTjUhNC7H0V7EYz5vpbgcfHl48n6P0zqgBknPiprDcvTPeIdq/0yoX/PPLy4rw+0Le
 ONaT1tCs2F9ZkTeZmk+0FaaVAFNCo1eiGKwE3Sl3kBCfokmuTvuqJxuhXqiOmdgtDHRP
 6X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721741719; x=1722346519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TtSQA4qzE3qFe+mObrHKurmvnL+QkrVHjWKCqf70jvQ=;
 b=Fuc3gDVNM6/HA+1YX3dd15Z0iATluzNO2EWTzsPV8+gYZhBlwU3lsMzvVZAikLzelQ
 Y4t3igqGiuWbsVCaK2tU/ag/rIF013CcEM53lWeTHiKLspQ5iRjXrZ5R6r/Xva/L2BLC
 3KgnaQE2cubjKlu3X+6oM20Yc8mIaixhqKtN8oWSuHvjzQxr2BkSpEuQlRPB9+af1+ha
 8RLDFtChhXrtFd7j2YhwWR/iQ0Y4yPQVIpkp1XR/I2u/rZZUObEt7nG0jOnMSqvuar8v
 HB6EHPjdciHaFZsa+P8c65sTQs4h9nPTGzLIZl93KePLZy1Fep0t4DAieCouqwdCOSPt
 5etA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl7/ct3LRSYz3yHYsvKF6rAfK6D8+0QV3MNE4GxrE3UKEBOEkSeubHQep27ybgMe2mB2Ovb9uudUdLxKAH895M6IdNjRM=
X-Gm-Message-State: AOJu0YwL5yYFg4/yaOYtMnOUXNeMf94pIerNXKH+gDBouh7MAxMhsSYP
 5QFwdADuTKzGarVB13SUynqsDZv0eaIi7uDq2xXs3YfKMHNq7IO45p2L0LUGa2k=
X-Google-Smtp-Source: AGHT+IHTAoGeSwRfsHhqGsfyLf9ar9jmfSXJiewRcu+wWpTjeG/gewAnWRS7kxLRHTn0orzdQeBsEA==
X-Received: by 2002:a2e:8712:0:b0:2ef:2685:177d with SMTP id
 38308e7fff4ca-2ef2685182emr53285681fa.20.1721741719414; 
 Tue, 23 Jul 2024 06:35:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d692998csm174313895e9.32.2024.07.23.06.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 06:35:19 -0700 (PDT)
Message-ID: <e055dc07-a7ac-4243-b97a-98c1cb702c2f@linaro.org>
Date: Tue, 23 Jul 2024 15:35:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/misc/bcm2835_property: Reduce scope of variables
 in mbox push function
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
 <20240723131029.1159908-5-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240723131029.1159908-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

On 23/7/24 15:10, Peter Maydell wrote:
> In bcm2835_property_mbox_push(), some variables are defined at function scope
> but used only in a smaller scope of the function:
>   * tag, bufsize, resplen are used only in the body of the while() loop
>   * tmp is used only for RPI_FWREQ_SET_POWER_STATE (and is badly named)
> 
> Declare these variables in the scope where they're needed, so the code
> is easier to read.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/bcm2835_property.c | 21 ++++++++++-----------
>   1 file changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


