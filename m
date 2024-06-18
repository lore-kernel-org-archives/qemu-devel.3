Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573E9C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:55:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWU9-0003de-Db; Tue, 18 Jun 2024 06:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWU8-0003d8-4N
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:54:44 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWU6-0001fq-9I
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:54:43 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a6f04afcce1so674314366b.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718708080; x=1719312880; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xgIw9IKUSsnidIbwU0XCTiXGMITo0Ef+Km6UW4Y49Fk=;
 b=aCF/d6nfyQ5Q/E4n0kz/gKvAxgGNZrpfaBwv4JTHxjnTOnrruB+YJBvKkcKqMa/17y
 SjBhFdk8pI0uuPfl7djQVDDvUnWl0JXAACTqudqZzAXacywrDE7AWXzWJTz3x3v90q0e
 GsdnGy8j59l3GJU2I6Z/ZOi3UAut9XbxmlZgzeTTpqfoYpMgH8OGkYauyOy0vTZRjAM5
 sOG6kdtGbdenis97fmqXj1NpqM8i+1rqm0tW/eDGqfMAGo60HpIBhGgPv53kHtPeFNw6
 0Zf+PJ110IhkzdDIu34vakkgmALSJdODAjKIN8KfasfBie9pmn1uGng2hG/Eq1+exwAN
 J1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718708080; x=1719312880;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xgIw9IKUSsnidIbwU0XCTiXGMITo0Ef+Km6UW4Y49Fk=;
 b=cr/DSdxoRGmSPiGmOexaFLcjRn7CUKcyggalR0NQj6Uy8KuLCuZuIPtV1abfECCPbY
 o69cwX/rM+wJOXxOULSe3uU+DkBIZCsbYXkI3MUh//b1Haxdatd/G7mWESTlxoiRBmbS
 aeNUtz/4Nv8gacyU0p3Q6oImHapW9Q32eOt3IVy/9pRwYZQpnovSElsinAYfyN74q2jY
 dmtZCJOhyT+GJJx6cFhgQ14TmyCJAhV+EtwnxY7kKOQpKPwN4UT/GS+esL3fBiY6Xt/l
 vl3a335MaAS9r4EEQMvZezyCbNvHAuA3YFR7Gr8xFGZCNaNJi2PNFLSkOb7+lDU4unzl
 gWGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdCiN9MAw6jymXb1vo18K+Uoc8w8/9JT0ilYAMQOcf8R63peXPh0wZI/FE8PWxP5QtbifaI9uRF4sFyRVKc54FLj3jDVM=
X-Gm-Message-State: AOJu0YyI9jjr3HXXWb+GIE576ug46Qehr3JYXr48P20J7plpbCR35B+W
 8BO0KAyq8Xr4O6Z3iNyefNIP5C+HCNlwvB27XUaX3OP+wJR/pekz+ARGO/5J5As=
X-Google-Smtp-Source: AGHT+IGxZyGzG0jvmNQ4ewG7UzcAp3hQC312ZJdOYdHrBTypjKckzf6MmQlGUmP6AUsp7l3GaJ6Igw==
X-Received: by 2002:a17:907:c086:b0:a6f:6389:4aba with SMTP id
 a640c23a62f3a-a6f63894c9cmr1099538566b.3.1718708080320; 
 Tue, 18 Jun 2024 03:54:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f5f1c8d6fsm546611866b.0.2024.06.18.03.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 03:54:39 -0700 (PDT)
Message-ID: <dfa19fc2-b049-4856-b118-b7e5cc6a92ae@linaro.org>
Date: Tue, 18 Jun 2024 12:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/dma: Add a trace log for a description loading
 failure
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "open list:Xilinx Zynq" <qemu-arm@nongnu.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Frank Chang <frank.chang@sifive.com>
References: <20240613013501.426905-1-fea.wang@sifive.com>
 <20240613013501.426905-3-fea.wang@sifive.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240613013501.426905-3-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 13/6/24 03:35, Fea.Wang wrote:
> Due to a description loading failure, adding a trace log makes observing
> the DMA behavior easy.
> 
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> ---
>   hw/dma/trace-events    | 3 +++
>   hw/dma/xilinx_axidma.c | 3 +++
>   2 files changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


