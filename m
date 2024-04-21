Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77897C05023
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 05:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryPl5-0005uU-TW; Sun, 21 Apr 2024 01:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPl4-0005tu-7a
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:28:58 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryPl0-0000bC-LH
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 01:28:56 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6f07de6ab93so3342094b3a.2
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 22:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713677333; x=1714282133; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eZi0Zl+eRrtJlZBV9jASoIvGganpcphdcyn/Bgxey5I=;
 b=cG6OvNw8Ttlr+rQv+p3PuCN9nt5oOrpfgODxL1WdHxfyKWAySRCQOSmuBgM4EAarjG
 SX1VyyOoG04dbvE2MAbvuQzTV6KvNlIwpRp7EngyVejjjE0oWnOYIayCXC5btNWJZoeW
 6pLeJrEUui7hS4m1bcOlI9F2jud/CbriNIaiAXwHQCxzs8CLYnEmHLKwd+CQ98SiV7Sx
 CJIUu8jf+7zMRAGN1uoXdJMyd45zDNsHlPVED6R+JSJt88n5jwzY281tvt1OD1feIvbM
 QWEiCJBYnzBfAry8zLIvuNdwUssdj9pjKJ3uWkj96cGTkaLC1UG9Uce9rPlrBz6lcIHq
 eHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713677333; x=1714282133;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eZi0Zl+eRrtJlZBV9jASoIvGganpcphdcyn/Bgxey5I=;
 b=iZbcx0nVfKc2XRY+mkDdMgWodZUHV+vVj4w9QjkHRljY6m2Kx0z1/SgRKo4z1nMSC3
 lF+yMyLwypuk/sEdDmw0Hj0ej9pXi6t/5O0qk+Oi7dmZcI7emmlw+F1oGMVDRdjwVISp
 oWqj+EKWErXSF9ATLKobNXmY6qcqFnl+MTKNUAF+zk24OxO8u7Jo2H7wJSA7ptk9Ol3O
 JIcVf4H5a5PjNUyu3Hu+W8+L2eXkqNV8E7Ld8/G7tewQ7gOSeCr2DKhMV+zmcoI8+6XI
 YbH0JEX+P59xIm8PQPRwRNWEwo9EjcvohIsgiEKnliyAdKLmywus+hJcL4jBmSIir/MS
 dvwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3xNKRa3cipyqjYAw4S6fWRRYNZhYoUC0KePrfrfkxVLLzhdn1uq/VJTNnjqXzQeOUyvrsW5qHGALm5bsO5OpDtgqE+Hg=
X-Gm-Message-State: AOJu0Ywftv/qsP8NEfpx9r9LPqBgFZs6AB5qAPioijuoK32frqFvDMqn
 rH0Iub3+Tq7qL3AxpfYjmCQpWB9M712HC9rjolbgzasKdG9YagZF3Po1C3dF7C8=
X-Google-Smtp-Source: AGHT+IEDvY3nuWe1lMygP4ouBTDUeAn+/ljzuHiY3IePX6mA7sRzsOVcnyQdb08HLEFin9X90te+Jw==
X-Received: by 2002:a05:6a20:7290:b0:1a7:53f5:4e01 with SMTP id
 o16-20020a056a20729000b001a753f54e01mr7162273pzk.22.1713677333069; 
 Sat, 20 Apr 2024 22:28:53 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a17090a828300b002abf2057cefsm4988327pjn.0.2024.04.20.22.28.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 22:28:52 -0700 (PDT)
Message-ID: <126e2988-cde2-4eb8-b423-6a4de637b316@linaro.org>
Date: Sat, 20 Apr 2024 22:28:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] exec: Restrict TCG specific declarations of
 'cputlb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> Avoid TCG specific declarations being used from non-TCG accelerators.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cputlb.h | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

