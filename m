Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F076C04FF8
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryaEG-00087q-9r; Sun, 21 Apr 2024 12:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaEE-000875-Bw
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:39:46 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaED-0000yJ-0O
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:39:46 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6ed627829e6so4116095b3a.1
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713717584; x=1714322384; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zzO2PNgNf25sBWOLBMeh/HbHQD9is6hj3U7UeE02hcg=;
 b=AHYQJZOpFg1r0CuBiipKUeGnlTfQeQNSlpN/OMMV5TLcpltfS7NM4vLHljjf9hEvVU
 RLqEztFZyrxRG4A9tW153GwY4K0WL5LuRK2qhb+jnKBaH76eWzg75HzYrNzsVAuZ/5OT
 rc3nvaCcYrL9qJ7TYwQlCWkYY3JNREaO9pEqxe16nsCudlBpksrlpiVD0pUsI5LU03H/
 FnyFmhE+vtFKuiyiLThFuMKEVBJ2po+OvbwaCFzV/93qYWWs5kuQ76Cl/xlcxcvZDAlj
 vKBD+Ispu2y6ZLTMhqNP+6P3E0vr+LRC152xqu/JgXFg0IqoFrGB+nJ/UP5OBWPqIS/S
 Z+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713717584; x=1714322384;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zzO2PNgNf25sBWOLBMeh/HbHQD9is6hj3U7UeE02hcg=;
 b=csF8vOxvEf3XF1E7RRxpCN1v7UFb5NpjSIYoHNwTOxaeqlUBBzZosnqo3YwCLF5pWr
 m1Bq1GBt240CO8iCMuObn3pq/bvYIhPkHNX6Rc3VMwwhC7VayVc5WKnFrlI7VQyGZIRx
 oCThVzw8wbub2XJiJwIpDXweJqs7UGGss+65mUpeINIAYbiFb3Hxvc9z/g796TNhCbop
 QUQbZvFJSrR3+WK1ccDfEdvYSJe5EloxDZRlXMN1k+3pH5wL0cUobOZtmf2pl7yAhUes
 vkw3rdZwc5pi7m/F2zZV7fOLN79qGPN6JlebluuigXAaQs0w26/XBZqUVV3iAN7+HFU5
 GwSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlhLvnTRBqSIki9dV1keJCZaeEb7FC3apPnj2sbSoQKqK8n2NyrPDw/mJTdJRXQM+EdppHJpt5doWDSebF3UbgQM4Az1c=
X-Gm-Message-State: AOJu0Yyi972GfzQvFq8nJDpWxZAmc4JFNblw+THdZnvECJQfkwE45e1Q
 6lAHBRjSL9C10dequmQt1U9C7ZeCnGEdrXOjH5ZnhToxMNcelcuBJgJTZLqJHpU=
X-Google-Smtp-Source: AGHT+IH/SKE6UEfKYxylVBwIcibVOLa+qMlbo38nXDqQgX2EgKuPT0FYHg8DfaVI8dwZWcGh80JWuQ==
X-Received: by 2002:a05:6a20:6f87:b0:1ad:27ca:6347 with SMTP id
 gv7-20020a056a206f8700b001ad27ca6347mr730485pzb.43.1713717583731; 
 Sun, 21 Apr 2024 09:39:43 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 fi41-20020a056a0039a900b006e6c6a50e5esm6344423pfb.34.2024.04.21.09.39.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:39:43 -0700 (PDT)
Message-ID: <f1fc19c6-77e0-4f67-9f59-ae9670b7dec6@linaro.org>
Date: Sun, 21 Apr 2024 09:39:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] target/sparc: Replace abi_ulong by uint32_t for
 TARGET_ABI32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-14-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-14-philmd@linaro.org>
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> We have abi_ulong == uint32_t for the 32-bit ABI.
> Use the generic type to avoid to depend on the
> "exec/user/abitypes.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/sparc/gdbstub.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

