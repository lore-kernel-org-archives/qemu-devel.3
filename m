Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C86C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 17:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryaal-0000le-5M; Sun, 21 Apr 2024 13:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaaj-0000kk-1V
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 13:03:01 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaag-0004wg-Bp
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 13:03:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e40042c13eso26936255ad.2
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 10:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713718977; x=1714323777; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Is9+G+sXsgs9tbaaTE0MWItPvvvb9tGCsHcscT8xhMM=;
 b=d3RhIASZ+5coa4P+/UYQQ3Km/j1VN4+IRHI0wDBTBtMgma+aUyUrLWtFKDuVZ+LoeI
 yO20io33or3QkIMVcnXA5+bryB9ekClNOtBdjwR49zi7o2xbRWbeWYIR2DV7LBk7wXkA
 YsNGPX+hUrvqSnBGWjzfeyfbV3p1E689AjmqoUl6Y6A8r3LoGemjEJHE6nM7Uc0GIQ2c
 TbQeFJlnJuRqSGqfsuRMfsK6EKNxi/ruvvV0jup1OxyRVeDTrlxKQFU+Y7BiFMBeifbv
 h4EXcaPbPYV+BkhdmmWWmDXCH1DADqf5lcKJYzmiANRHdaXT70S9AfKV2zp1w6isjiZ2
 N0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713718977; x=1714323777;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Is9+G+sXsgs9tbaaTE0MWItPvvvb9tGCsHcscT8xhMM=;
 b=D8d6T4P2Hcinr0x2RTeSBvrcPmCvDAAKdumuv999C6jlASvpWj6COQ5voG3YW/pEfI
 RXrg0J+cvGp2T4BMuvJHHX4HZuSpWfKFp0QdBqYPzu5gBoUX436ItR0yxxrSef9jwzot
 /dHf8td4ylO9rgr5f99Q+md/FVnrfY2+e80mhhuMu4NsoudtubonumjiLY4VA6mR30C5
 r1Nth8kTEPXnIqOcwH4T3/LWgqs+suVVq5hp17rFc42EuT/LElML49oUWECsPwruYV5D
 FGR05M8Z7Z0p93pQpobUYRtCu15m/a922WzyPySw5b3etFT8yWA3ND8oOSl7wA0rgoQt
 BZ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF+IYCXhIH7DwNJZoYsjf+j9pbKwkDFFzk7zoBAuyp4HYMGhcTYjbEmn7Q5zt2Si8NM6uMgU9r46y+MsDGC2TesKcNSgQ=
X-Gm-Message-State: AOJu0Yy/h1U5UazwqKk48umtGWgS9jXHPEQGGY21ergWPUhmlglECPD9
 KVWQctftXvnWkShMBIpBqbRQXhijiOaeC9mUHt6WQMpSW7EztdVpke1pqeLFLHw=
X-Google-Smtp-Source: AGHT+IGqGa75UZ+kxBJqZgsES9Nskp+wQBMR1roE2ivdGfjaOP+QEXk2DeP/eOAK1nwdmPgeA4hHkw==
X-Received: by 2002:a17:902:c94c:b0:1e8:2c8d:b793 with SMTP id
 i12-20020a170902c94c00b001e82c8db793mr9482567pla.41.1713718976845; 
 Sun, 21 Apr 2024 10:02:56 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a170902a3cc00b001dd707d5fe6sm6651002plb.158.2024.04.21.10.02.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 10:02:56 -0700 (PDT)
Message-ID: <00a3d489-f51c-4a4b-a5a4-f0cc7cfd3fb2@linaro.org>
Date: Sun, 21 Apr 2024 10:02:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] exec: Remove unnecessary inclusions of
 'hw/core/cpu.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-25-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-25-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> When "hw/core/cpu.h" is not required, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/cpu-all.h    | 1 -
>   include/exec/cpu-defs.h   | 1 -
>   include/hw/boards.h       | 1 -
>   include/hw/ppc/openpic.h  | 1 -
>   include/sysemu/hw_accel.h | 1 -
>   5 files changed, 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

