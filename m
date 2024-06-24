Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C8CC2D0D1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:12:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjUq-0007Ya-RD; Mon, 24 Jun 2024 09:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjUe-0007UO-7s
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:12:25 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjUa-0004Ld-UL
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:12:23 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ec002caf3eso63226751fa.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234738; x=1719839538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AGrbWlTqTjPPAYMqOnG2xQY18UQcCus6pKyHNelxrHo=;
 b=uWB29bplEFL/OVvw48IIuXpJwTa0pH8cSa0LL4GAmR79sJL+fkqbwimpu5kn/Ik3YH
 pXvIZwD+i0m3Z8FirjkKmskMffj3Zo3SsQeS3RPIvrsm1qOzmWmu2iJmdGFIZHJohRys
 Z4OkqZCv4m9ToHGKZOlpsddYz4XhycJqHIeMWKo4ga12/QZ7z5SzzKSkAMTo0acDmTR2
 Uc5k94tkpCzY4HoOU1hJFvjLXJRTrBKVfup0Ls+32c1LRAXi2PkqMl1S/nAlcEG46FJt
 MwK+QmE92isI86jFyX0rEITLGkX2Sc4dm1Z4LhzFW1UUoD8ep82itR2lg0B6kpYZB9vy
 6gdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234738; x=1719839538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AGrbWlTqTjPPAYMqOnG2xQY18UQcCus6pKyHNelxrHo=;
 b=Y3PFan+fBny7TKpeKKMKmWuQBIyejC0jf5oOcj1EJvzBtOTpbKosgAVvboPrwJ3pKS
 8YLdt9f4lLLmGx7wvi0lIAYL6f1frqk/0OJaHM7pelRN0DNJWIW38lFrYqlt7d/vqIsy
 enm6Xg1X01dExotLePmfUOUdZWvmGFB1qOJP76H0oePgWfj3Lc/rw6yyb3wrqBGuLVVU
 dGpiQJlPLuOaqvlq90b8vqtDFctU+Qhe6SAK3jl1c2SNgvk31o4xHvaCORVvVAyuAq5M
 BBnaFTPqn21LqjbkFgL43UUgOrDR4Ozqh+Ec7CLXZ6WUx3eC/IOVKo0H2zt0Y2L3R0fO
 MdXQ==
X-Gm-Message-State: AOJu0YwfkodQGZ4kQDRJ+13fZWawhdXorgO8rwTM9q4o+ZQ7ut9WyA+F
 96astG2PjATBtoo9CyReYPMEIydbC+UY/W0NdDNmqwXh3Qm/wJg0Y37pr5C2sn06Cl+wFI709M2
 P
X-Google-Smtp-Source: AGHT+IGSQpe/JLjsz5jDlh9GIikh6j8jrrJ9dzj3uscIoH0dV+MBqKLeS3vOSn2tcI9FnnUV28fytQ==
X-Received: by 2002:a2e:9057:0:b0:2ec:18bc:c455 with SMTP id
 38308e7fff4ca-2ec5b2c4dbdmr35699401fa.10.1719234738459; 
 Mon, 24 Jun 2024 06:12:18 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101a955sm181604805e9.0.2024.06.24.06.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 06:12:18 -0700 (PDT)
Message-ID: <de28a8e1-494b-490e-bf4e-d5386189e4db@linaro.org>
Date: Mon, 24 Jun 2024 15:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bswap: Add st24_be_p() to store 24 bits in big-endian
 order
To: qemu-devel@nongnu.org
Cc: Sai Pavan Boddu <sai.pavan.boddu@amd.com>, Joel Stanley <joel@jms.id.au>, 
 Fan Ni <fan.ni@samsung.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
References: <20240621075607.17902-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240621075607.17902-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 21/6/24 09:56, Philippe Mathieu-Daudé wrote:
> Commit 14180d6221 ("bswap: Add the ability to store to an
> unaligned 24 bit field") added st24_le_p() for little
> endianness, add st24_be_p() equivalent for bit one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Some SD card registers are 3 bytes wide stored MSB first.
> ---
>   include/qemu/bswap.h | 7 +++++++
>   1 file changed, 7 insertions(+)

Patch queued.

