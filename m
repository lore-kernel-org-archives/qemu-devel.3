Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2BAEC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4d2V-0008KS-6c; Mon, 23 Mar 2026 07:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4d1k-00088Q-DG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:01:03 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4d1h-00083j-9I
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 07:00:55 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so46579f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263651; x=1774868451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=biDZgCa4iXv46d+XIxztphvTEQ1cGEYkj7pRIQ+AaGY=;
 b=hJrRhEdvdimVoVFY4yIn4Wn20aavO9axgAT9JGFpy9SVyR8tzpTmCkVbO5yqh4zGso
 xqpd4LZ/Whvvjv9bF3fPd7yWx7j2EqGc7tYMDA8f+glFbKAdUPvCp//SqWYGhiGsUQL1
 pvQ2FvSmsIuZNMBucix9O18dViSNdK8DJth3BeVxxDH3Xf+nmWogxH2xHi2Pc4Mwi32M
 QuPmVbu3ktIYffp44Yz8ydigdCfjFNEJRWkB7xY6MBacY913Iw+wLYt2O75ah1WaTmkh
 GL0N1xJgGB0wvZON3ikMzal8aFGKxdYpuHApHCwo1r7b+4Am9RWHeUyI7zp8+UrVvgeQ
 U3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263651; x=1774868451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=biDZgCa4iXv46d+XIxztphvTEQ1cGEYkj7pRIQ+AaGY=;
 b=dto3y9VQI75HCebiY7QVaMipHjenAcq87U04vzRcujxW8slxZxCfJFJ+Dc3EwJNE2h
 VdN9twekLH0/im102b6qqargZD+hR4o6D1IuaEF3n86J5J3Z2as8/Udxrw2mMzcTGCtO
 0JNDf4dsSYWEd0GgawWNZh30BehXLK0lkRJeGC5iUTWBuUcO7Bm14PZecl6hdq55n4Db
 yjp3gtWGE2Pye2pDeyJ+pemPFW+OThg9J9sLmqKBRBTYs1p5cEWVPVBR4MAIZFUNSofm
 y6RLDdPOQlZEUfQslRmgcSk+4ErO3ZWIQQ1rIA7+w0h3KonML53yWLfS/dIomma2oz65
 PcwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPuiE2oVEwFGNRBiC47Sfy2tr2CEhBHdF/7pfq+JSagqUt1rNDkb2YK2VEPZM2BcznhLxgIy+oVmn5@nongnu.org
X-Gm-Message-State: AOJu0YzyzvEG9jPuPnQrZtdLQf930s7XmuJjcY3+aJBcwy3JjJYV0Y9I
 lBxSzN0/RoPal4veyniOXkma7xB36d54gIJzODL5fqzkFAIIyqqsdHyrHqJEMkoijxc=
X-Gm-Gg: ATEYQzztlrPHDVkRAdr9MTt3e+D08m2mh4CqHwLSdspbsLMRNgTgo4os89aqBPDPWWT
 30OhxHlx8Rd3lCVmAgM8P/Nd1kvh5+5pyfda5c6BtIRaIchhDocnRJ5P031SLdlP5NrTJDS5RdC
 CKlI3lj3HiWnwyVSPKEYNUK8yzajLMR5qv+RBLZjrIPqm5Zil1Ss6Fptw2eqNWQCjJ5f198cOGI
 NC0pJpE3o2wzHG5oDulrd96dE5dvIFoEKuqVd8ffn913AxuRg4ExLQDaVA/+r9J+zcO8gdbHQm/
 TROZWqQw0VGumYX+NQEtlisAaH9jkaGVhxNpf8Akob+RZ73nANAM6x3t4UZAISORGEOInsX4ftm
 odALYqYFKxllwKJ5wjy5Fw68wAXOC2v4eGpS5TN+OU6E8V7V6zlrecMOFDr9V+fD64TZrWIHk/m
 LgVf0N7OHfW8lK3Mddztgd5/O2ieH1tEKBEaTxUZ8M6Px6wlI6V8Xj2PaaCaUfiYzO2A==
X-Received: by 2002:a05:600c:45c4:b0:486:f308:94ec with SMTP id
 5b1f17b1804b1-486fee227f8mr153806355e9.24.1774263651350; 
 Mon, 23 Mar 2026 04:00:51 -0700 (PDT)
Received: from [192.168.69.206] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487003ec0d5sm103620725e9.1.2026.03.23.04.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 04:00:49 -0700 (PDT)
Message-ID: <4b8105d5-bd4a-4e62-8740-d402479ff986@linaro.org>
Date: Mon, 23 Mar 2026 12:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ftgmac100: Improve DMA error handling
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <20260322215732.387383-1-clg@redhat.com>
 <20260322215732.387383-3-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260322215732.387383-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/3/26 22:57, Cédric Le Goater wrote:
> Currently, DMA memory operation errors in the ftgmac100 model are not
> all tested and this can lead to a guest-triggerable denial of service
> as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.
> 
> To fix this, check the return value of ftgmac100_write_bd() in the TX
> path and exit the TX loop on error to prevent further processing. In
> the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
> flag as appropriate.
> 
> The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
> AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
> Nevertheless, since it is supported by the Linux driver and it should
> be safe to use in the QEMU implementation across all SoCs.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/net/ftgmac100.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

