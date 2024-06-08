Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1A5C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0lY-0003R1-HR; Sat, 08 Jun 2024 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0lW-0003OY-1L
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:26:10 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0lU-0004ku-Fa
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:26:09 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f44b441b08so24933915ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717871167; x=1718475967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rKqYzxdpstXoonRcTE78dlRKdMK1azmrdL/keA6udRE=;
 b=BCVyU12k+3Q65x00jwcXMaDX9xHQiJttkR9mZhw05ehTBiGtWlMX/vo+YuglV5a8Ue
 owfk262veeo3b9RlnAUwui+J+oVygg9HX72k3Cjwhxk+QgVRebSncs8opPAL2l4w5yQz
 EvPHdT3xMQgWuIl6lDHQXNR9RhOP2Qtme5hlCn3zYPZJpofphHN0N8H9zdtanI4DQK8Y
 ouVMJVJ6diDIEdSx8XYxzYUnKBybGX6K+I2VKw0qdCdj95crUBkkayhegkMV1HZzxNfK
 2tpCSdWlYptjB4jQOUzRG9qjzy6hz6cVPMLUGBmQlqlcLJTZNEsJJNpv0acdOSlOjEhM
 Rt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717871167; x=1718475967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKqYzxdpstXoonRcTE78dlRKdMK1azmrdL/keA6udRE=;
 b=Kc24gihATgYXWfMZ43ZicPfNkL4/VC2v0U9dQwfpgjY0FuWEY8DxKl7YuyScBTjzuN
 h7o2oGcSFo5bSIWh1cbis+e50AFwCUc1LnBBMyNY0zy84IKv9V1lss9Ucp98w7eUAWgM
 X834nJBVJFlHjrvaG+zXAP8FPLxYtRIvT2kSsWgQWvGP3swySbdBzNnfu+652fJUYSmj
 65JCpCCQo3ZyV9oaVga6/xTe4Se42rUMoQcvxFkGffd9v4yz94pC28S0m65vAmMyRdBL
 5x6sDrahBx8IdtGJep7rIKF+SLMsaA4GrHV2Ip185K37Et/jPi3KbFdLIAbIpy5+UcxZ
 tGvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBFzuc8DJKJsAhAeAKXdkkY0CvZtDunc4uqrlAsaVCMDvHHA03Dd+OhSLTzHZ0NaiOv8zvTTJ+ywyk1VGFIp8cTNO55XY=
X-Gm-Message-State: AOJu0YxGZV6XKMCKlgR2UQuYLpsEr1Kbco5CPSRIBOryDcBiVeQrWqZw
 5ZsdIbM2QqGUvQ9DsEyb7NIOrVsngC4Cdl23cMeYPZhXUaw/W4deQWLzHO8OhVw=
X-Google-Smtp-Source: AGHT+IHcnR1lA/nQxi4s2tTsn9CipL9ahoCE25FGtj865pcAR+g9XhSmftVz3Im5baYEXsWC2qVZhg==
X-Received: by 2002:a17:902:d491:b0:1f4:962f:6338 with SMTP id
 d9443c01a7336-1f6d02eeb1emr65848075ad.28.1717871166958; 
 Sat, 08 Jun 2024 11:26:06 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6d6617394sm34000835ad.261.2024.06.08.11.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:26:06 -0700 (PDT)
Message-ID: <cdae3542-ae83-4e2f-a3d8-82c24b429f5b@linaro.org>
Date: Sat, 8 Jun 2024 11:26:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/25] target/i386: fix bad sorting of entries in the 0F
 table
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> Aesthetic change only.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 93 ++++++++++++++++----------------
>   1 file changed, 46 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

