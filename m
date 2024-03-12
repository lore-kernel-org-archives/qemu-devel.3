Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8058EC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9er-00069M-CD; Tue, 12 Mar 2024 17:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9eq-00069B-3U
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:27:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9el-0001Kc-La
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:27:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1dc29f1956cso30704875ad.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710278850; x=1710883650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=54IwvtBvIP3IUSfCoxzzuZS6kcCpm1YhTesKGWJwN6Y=;
 b=OB52u7PVlHebvIqUjXoKD6z1xrb4jjUrRDWcL4VltjTW4Sed8TMGNY9/Uj/KycuLGs
 1kw/UdEpnZ75RyL/wxJMXSXB8NQp/ldx7MpNHn9yDuCmFCCMneLl3wAE025oVKbPd5Pn
 OYJn9NQNAjkN8fGBuCAJEdaKTwy/yCpYmyZjmy16ipODvgG4DQrbnxJYDzqiosXhwfjr
 gafN3jMyU5bx0oZq3RmmClcJGfCv3Ww/+t7KwO5eOmg502Gz6lT11CYG1D01ckbTB+NE
 e4chhgZ3xecSW7N/aXL+m1hVVH+nghdFjBGoP5xOc9/qsUBfTqpq3Z8zihw6Qo4KI5r0
 +JQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710278850; x=1710883650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=54IwvtBvIP3IUSfCoxzzuZS6kcCpm1YhTesKGWJwN6Y=;
 b=JIeCIH4VEA1LNWVUqGPcm/q6FqgC1v7h5ugMJDsIsO7KveBijSXKhAn6ahqoCXMW2g
 K4tco+CHa8mdNcvWyHc91BaEH91ZqquB+fdlPtv3rzeHQ5woxSktseu6xvXv8FjXa8gM
 xyjBKXbf6K8n3s9ZmzONN0MLPUF+vLXcFuzzheMB6ttybdc8AlB0lLZaiur0GZRlOKrP
 ltBC5rIK2I0ySCKcBj6kMHKe2QkoubYR1ruY0T78ENiZa8mQiua7o4cFeDo8nGj45wBH
 pht+8hRgLUbeVe026ugNVh5wu0caJ2R5zlAYh1mauSYQgJpyhU4bWt/IFSlzCV5HCAep
 YuIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMP5HcZo/y+XNUjipsbFrhvukZPWpL++15pPSRh6bxCky7QJ2z4v3ilcWSvnAW6oHksXpNFLapkpAQifQ2uyk4jag5xpo=
X-Gm-Message-State: AOJu0YwVj3gzj+Odi1o+DZ1H51RwCCs6b9ViKB8ocKTXwMIw09FbiZNy
 IfgmqIf2+ME1FJgy6vrQrcd83e6TZQfOd0UnsxI7LdsdVk9zDRpYsgsQrS7YzYc=
X-Google-Smtp-Source: AGHT+IGR2Ch7KVzbbb6nK2tsJ8afCtZkZsYeRMi+ZlPQt9HCifsDP0r1GY53AcZreeynuCErvKBnKw==
X-Received: by 2002:a17:902:c952:b0:1dd:b728:b8d8 with SMTP id
 i18-20020a170902c95200b001ddb728b8d8mr3896057pla.45.1710278850158; 
 Tue, 12 Mar 2024 14:27:30 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 t11-20020a170902dccb00b001dd90ce4e35sm5362465pll.29.2024.03.12.14.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 14:27:29 -0700 (PDT)
Message-ID: <4f31292b-769f-489b-8515-60da88175d63@linaro.org>
Date: Tue, 12 Mar 2024 11:27:26 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 0/3] system/physmem: Fix migration dirty bitmap
 coherency with TCG memory access
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240312201458.79532-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312201458.79532-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 3/12/24 10:14, Philippe Mathieu-Daudé wrote:
> Nicholas Piggin (2):
>    physmem: Factor cpu_physical_memory_dirty_bits_cleared() out
>    physmem: Fix migration dirty bitmap coherency with TCG memory access
> 
> Philippe Mathieu-Daudé (1):
>    physmem: Expose tlb_reset_dirty_range_all()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

