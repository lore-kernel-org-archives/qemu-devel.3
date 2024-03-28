Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E47CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 13:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rppe8-0006Bm-Nr; Thu, 28 Mar 2024 09:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppe4-0006BB-3g
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:18:17 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppe2-0002nJ-2Q
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 09:18:15 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4a393b699fso154828166b.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 06:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711631892; x=1712236692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ys/jO66OvWF4w1xDLXuqwZ0bzs9hD3BUNhxelvyc2Pg=;
 b=AbNJN+iF8Ua3+XAgRlBnMNKdsftxPyDRAdUDjo1hmAdGcJ+kS0Cle4+dWSSfyxf6Ep
 Pt5jR6NdTc3MEgCoTIJ9P6+bjSsKqca+dLUuuSrkY/GpQpYCGoyZzlld7QfIYzpnqP+L
 X56CL8J/pGybMO1PqlvqSkIiHlfk7EeeooZWzvjtNDZ6xj1j/+YanFx9GriK8DZdDFH/
 qOXMcYCsNUiTYPhz4lYft5NST9RmjRH86l7ow55XW2qKosYsDmvReEGi5jxYI3CClv0O
 OGUhM/GifU7OATS+GHkrtOdzC0ONbR4PZKfjMwPCYp+09ipX6dADmAvsxpNmy6aor1in
 nonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711631892; x=1712236692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ys/jO66OvWF4w1xDLXuqwZ0bzs9hD3BUNhxelvyc2Pg=;
 b=J9hH7OovyDJkdt4JDunOZe8/5uz0H9gs1ictTmCSrezwG+gtmOTtgyg/uqtvOg8EvE
 L6y0cGKkRRey5ViykW5P8nPffU5ybXAo2dOy0NXwf07y1iglUlh7wn2EiO9wa+sxRgHf
 Sgt1BXA+2qEWYI8xH3Hq4NJzh8P1Danik1e9WcvyspGImyrEshhfCsuK7C8iy5rWznVr
 46OQr/T84DTnc+W83iZ7+sNkoLpClkEfgqSAecvDiRqlDlGlqW6wPK8G8zq3pOg9USY9
 ZdiURxSjVHFZIQGSUq6ydY2JSJ26Eq2KgrB0lC8a5IdYP6EIObx91wf8xmOT+RuzFf52
 cNMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJDajyYrIpQUsQLZzMBRazvmC+3N/jZZqujJkxnlU3NkY59qZgDaFuGoUCsWK/9wW5sQdDDLw3vE3a7ZUza/4DBNMElwA=
X-Gm-Message-State: AOJu0YyMU5SkSIrGBfUMJGwuKVaKkVddlPUr1KGe2cs6KL6Eytq/iMXu
 KVMO8f7I44gyFXeYFhOA36bNu2xOQuW5Hyao8uWK+IyKBUonFpv0YYNmTAaQpcubdXdIofw6vS1
 R
X-Google-Smtp-Source: AGHT+IGo39utLAA2Nghi9bI22AFSZQ6JAa9f+iIopH8DWvmEFBm/G2sOWESdN/id+edzEau4gNjMaw==
X-Received: by 2002:a17:907:6d21:b0:a4e:24b9:bc23 with SMTP id
 sa33-20020a1709076d2100b00a4e24b9bc23mr1226083ejc.34.1711631891966; 
 Thu, 28 Mar 2024 06:18:11 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 k5-20020a170906a38500b00a4761c94a5esm746982ejz.107.2024.03.28.06.18.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 06:18:11 -0700 (PDT)
Message-ID: <06005d6d-294e-41a3-b8f3-9a090ab4b916@linaro.org>
Date: Thu, 28 Mar 2024 14:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tcg/cputlb: Remove non-synced variants of global TLB
 flushes
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240328053131.2604454-1-npiggin@gmail.com>
 <20240328053131.2604454-3-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240328053131.2604454-3-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 28/3/24 06:31, Nicholas Piggin wrote:
> These are no longer used.

tlb_flush_all_cpus: removed in previous patch
tlb_flush_page_all_cpus: removed in previous patch

tlb_flush_page_bits_by_mmuidx_all_cpus: never used
tlb_flush_page_by_mmuidx_all_cpus: never used
tlb_flush_page_bits_by_mmuidx_all_cpus: never used thus:
  tlb_flush_range_by_mmuidx_all_cpus: never used
  tlb_flush_by_mmuidx_all_cpus: never used

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   docs/devel/multi-thread-tcg.rst |  13 ++--
>   include/exec/exec-all.h         |  97 +++++-------------------------
>   accel/tcg/cputlb.c              | 103 --------------------------------
>   3 files changed, 19 insertions(+), 194 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


