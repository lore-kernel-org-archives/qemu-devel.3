Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01811CF34CA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 22:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swUCL-0002lS-Lb; Thu, 03 Oct 2024 18:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUCK-0002kn-3n
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:21:24 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swUCI-0004cJ-M5
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 18:21:23 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71b0d9535c0so1129249b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 15:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727994081; x=1728598881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sWp2+U8FVfun1jmnCyXG4WVfNTb/AyKz1Clf44L4LuQ=;
 b=FQuk9ye1T4rWLXKdXSfsCuf2RmKzxzje+Y9rsEaBxa24ilFF9InC9Gxyee6ynn/kay
 8F6S17xSAeVec4suy4MLybA/yYmlq9yQsbPZ6V91gz3weMU5VVQTo5c65W+XWiqno3lI
 htumKMUczo9vtFceJ9DhCUsC5cbWnoNudy8Mm6js925H9GobBWaBiTHLBwvfC0X4cQ+z
 n1oFdsO1Jf48rzpZjDbVmsEys1SVwjbFkLlsKkgvEAGXZZ+nari2M4ysF5PJ6JgSIFa1
 oaotdK8MTGlpgHmoCltdL9ukWuIDN1wWxf76bJIL1y+iBJczUqt3Nty/6iyDc7IegdCc
 Tqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727994081; x=1728598881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sWp2+U8FVfun1jmnCyXG4WVfNTb/AyKz1Clf44L4LuQ=;
 b=QZKX4Cvm4hSKKPto8+f/Pryq4kz42Q22NG4FJtIdxYkL31o/gL0efcSJKGyoOA6mQu
 2D88xZORrb+E7ugrKPDJkLNTxk+qfwR3OkcLxzz6qS55w6aO5MvM238N/jGjEVK3Ha84
 xDGdUf2bsZa5NpYZVJ69HxI76RvuFAzudpkGaBhmdnkBm3ICVWzjslaAThq+rRqvG8V+
 hkE/S9wCs112WcfFr7QicOk88/SWkJ/inirTL/E5uQQG3JPEhnh2C6Abepz1Rso1bmFT
 LgwLBhHpHk51bE8oHqX9k56zrkasgwTibWOV4jkP5OAYDx5oFFv7YwO31XYoFP2/1Lv1
 JQgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuzU0eNWM96Tf62Y7Os7tqYIlHVabc4J2ixIPRmnMVocghanMt0xRSt+QVwIV62v/yYYhkSkVtYbAv@nongnu.org
X-Gm-Message-State: AOJu0YwLawzF229rxti2oZnkzjPc379jXICJMXCuIBCAE8YY7Pf18BV8
 EsrIqWomy0q/9IbmXYIlUK9EwKpSMN6XnkefidPVD6BqOQ2vNB4SI0tKMAgmMgc=
X-Google-Smtp-Source: AGHT+IEc+N3NDXGCac81iFchZt/Ay+HXbYwuzcgNIX30d/Ve2yQk5RKkVvrM3qhb1WVBRfAG6ASyqQ==
X-Received: by 2002:a05:6a00:a29:b0:718:f026:6c78 with SMTP id
 d2e1a72fcca58-71de23dc1bamr1098216b3a.13.1727994081197; 
 Thu, 03 Oct 2024 15:21:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71dd9df3ce1sm1883043b3a.182.2024.10.03.15.21.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Oct 2024 15:21:20 -0700 (PDT)
Message-ID: <db86e16c-928c-48f8-950f-c6ac05bf6d20@linaro.org>
Date: Thu, 3 Oct 2024 15:21:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/ppc/spapr_vof: Simplify LD/ST API uses
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20240927215040.20552-1-philmd@linaro.org>
 <20240927215040.20552-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240927215040.20552-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 9/27/24 14:50, Philippe Mathieu-Daudé wrote:
> Directly call ldn_be_p once instead of ldl_be_p / ldq_be_p.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/ppc/spapr_vof.c | 27 +++++++++------------------
>   1 file changed, 9 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

