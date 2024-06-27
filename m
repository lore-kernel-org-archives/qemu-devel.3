Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B57C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMsIJ-0001pT-Kr; Thu, 27 Jun 2024 12:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMsIH-0001bF-Bc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sMsI3-0001Gb-9n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:48:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719506885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rZt77AtMVcEfKzbOM1A7aUOSO3Z0yBNv56LTDVaitTk=;
 b=gB6VlQSno/zVZnezgcrzlvzAdyEH0pJOl7Qe/Oe5GFGNEqujXUHerXy2LPsjBz6v8wpcrX
 C5yRXQImdIdbCjMdXJqnSKk26R98OYEA5jygDxJ45+jfJG6ZUjb6SVM3VLDyM9S81SAjSy
 BozAIKE5G9Yh4WfgQ10iZCVU9srTrMU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-QkQSZ3nJOi6TLLIP6JTIhA-1; Thu, 27 Jun 2024 12:48:03 -0400
X-MC-Unique: QkQSZ3nJOi6TLLIP6JTIhA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b551a62a5eso82290736d6.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719506883; x=1720111683;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZt77AtMVcEfKzbOM1A7aUOSO3Z0yBNv56LTDVaitTk=;
 b=wa2WZETnTSBcB9SZpEpTqYXLF0RNOhLtKiYHzDDqI3hgf5TfKewqc0V6SMjE7sLOap
 E14fcKhhjGeVsI5R+unOiPrBaOPHrfiAZMxJhiYczBU/MsaY0Q+R3oj5o04jpoFftzPo
 P7CZTldrYtV6Zwx6lXir4Be+J5DqpWmJ+ZITFYxVzVnV3UWnaxXAAhSaZSincymk9onh
 kB/bJXyV8LzvofgGrN4GxJqSxhy431SlNJQqMoPdxtVs6JvYOagX/zHkiSNGR8oLDpnM
 rT7eJV0Gt0iLejtOUsRR77yxtuBom3MvSnqe5aYf5mvI0Kvx/Awgu1Qx+dJDIA69ICtF
 v/Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXklN5GvezNOv6HrEyuiXYhIgrONGNddbl1+RMJTBjbjvk+91AeyOgpaH7jM4vvmgUd5V7TwhwMQHo6p1YXF+Dzu35Fnhs=
X-Gm-Message-State: AOJu0Yxnnm99IQp+KQj+YWeBX+AQ/gRG1UBj3fCayiPwPW8uIg5oHd4l
 51X4Aiw/jAarqseH9IjzHOCcKnzEXuII0WuPgXJB+sEdTUTMu85NOLYg1Gz7MJk5mW8D+3+5maG
 L7RuQt9+aCMA7IBp66wwPGFr0V68+ZtQ76c6FAH8Ju9reZ+hCGl6a
X-Received: by 2002:a0c:e0d3:0:b0:6b5:3013:a673 with SMTP id
 6a1803df08f44-6b540bf67d3mr144561246d6.57.1719506883355; 
 Thu, 27 Jun 2024 09:48:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUvVrUWZ8IXJE/ZHVquIh2yvKvtpZckDH2B+PpXacntR3VJRLjISAAhr4QAriufNgctq9gEg==
X-Received: by 2002:a0c:e0d3:0:b0:6b5:3013:a673 with SMTP id
 6a1803df08f44-6b540bf67d3mr144561016d6.57.1719506883049; 
 Thu, 27 Jun 2024 09:48:03 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-43-177-66.web.vodafone.de.
 [109.43.177.66]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b59e5f212fsm113156d6.79.2024.06.27.09.47.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 09:48:02 -0700 (PDT)
Message-ID: <c11ff772-2b85-40ec-b577-a6d996be015d@redhat.com>
Date: Thu, 27 Jun 2024 18:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] tests/qtest: Disable npcm7xx_sdhci tests using
 hardcoded RCA
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Bin Meng <bmeng.cn@gmail.com>,
 Hao Wu <wuhaotsh@google.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 Shengtan Mao <stmao@google.com>
References: <20240627162232.80428-1-philmd@linaro.org>
 <20240627162232.80428-16-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240627162232.80428-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/06/2024 18.22, Philippe Mathieu-Daudé wrote:
> Disable tests using 0x4567 hardcoded RCA otherwise when
> using random RCA we get:
> 
>    ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: assertion failed: (ret == len)
>    not ok /arm/npcm7xx_sdhci/read_sd - ERROR:../../tests/qtest/npcm7xx_sdhci-test.c:69:write_sdread: assertion failed: (ret == len)
>    Bail out!
> 
> See https://lore.kernel.org/qemu-devel/37f83be9-deb5-42a1-b704-14984351d803@linaro.org/
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Cc: Hao Wu <wuhaotsh@google.com>
> Cc: Shengtan Mao <stmao@google.com>
> Cc: Tyrone Ting <kfting@nuvoton.com>
> ---
>   tests/qtest/npcm7xx_sdhci-test.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qtest/npcm7xx_sdhci-test.c b/tests/qtest/npcm7xx_sdhci-test.c
> index 5d68540e52..6a42b142ad 100644
> --- a/tests/qtest/npcm7xx_sdhci-test.c
> +++ b/tests/qtest/npcm7xx_sdhci-test.c
> @@ -44,6 +44,7 @@ static QTestState *setup_sd_card(void)
>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x41200000, 0, (41 << 8));
>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_ALL_SEND_CID);
>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0, 0, SDHC_SEND_RELATIVE_ADDR);
> +    g_test_skip("hardcoded 0x4567 card address");

This g_test_skip here does not make too much sense (since you're doing it in 
the caller site, too) ... could you please replace it with a proper comment 
why this code needs to be reworked? Thanks!

  Thomas


>       sdhci_cmd_regs(qts, NPCM7XX_MMC_BA, 0, 0, 0x45670000, 0,
>                      SDHC_SELECT_DESELECT_CARD);
>   
> @@ -76,6 +77,9 @@ static void test_read_sd(void)
>   {
>       QTestState *qts = setup_sd_card();
>   
> +    g_test_skip("hardcoded 0x4567 card address used in setup_sd_card()");
> +    return;
> +
>       write_sdread(qts, "hello world");
>       write_sdread(qts, "goodbye");
>   
> @@ -108,6 +112,9 @@ static void test_write_sd(void)
>   {
>       QTestState *qts = setup_sd_card();
>   
> +    g_test_skip("hardcoded 0x4567 card address used in setup_sd_card()");
> +    return;
> +
>       sdwrite_read(qts, "hello world");
>       sdwrite_read(qts, "goodbye");
>   


