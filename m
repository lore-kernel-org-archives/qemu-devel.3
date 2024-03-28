Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E634AC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprBu-0001dJ-9a; Thu, 28 Mar 2024 10:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprBr-0001c2-N9
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:57:15 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rprBq-0007VN-2m
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:57:15 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5157af37806so1190529e87.0
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 07:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711637832; x=1712242632; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NKXE0QZhzH3DYh38D3rdCYuqyq9+Ifkyb9HxRIzYy6A=;
 b=dux2djIp/jodczyicx0uqZPBxrcmLnwwYHs1WzJdPzpiejUmoh/l1DAos6fXX5hXVz
 xJDbLjwjjGW0MOnlHven5x7WFm7BM1qfLHGSueAK0GOWiyjk4DATxpograFKVLfWT/uH
 lC4MCSWQVmTHT1xujnudX1fWnKz4PSpkaDVMrsVNRYEyXgKXw8g3+ktT2rMbSIemWnA+
 VNKYlqc2IOZk4RlqPSiPjtvli08XN+Pm2Zv6cOr938rt9Ic76659nLdKZObv9KZbpJES
 68pdBL0kvYBcFTmDyPT9L3JA8GRqxTQwZA54SwTE1+dcEawh/YLuAF86dMHVGRA/Q4Si
 Oxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711637832; x=1712242632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKXE0QZhzH3DYh38D3rdCYuqyq9+Ifkyb9HxRIzYy6A=;
 b=sijgxubAVKKlnXRYU4w6E1vGy9qNA7i5qsM7vNG4ZfzIcnWpTSREJYRdN8UbodIBIE
 0zgsbqv9a+EYX8QeLEEDjLtdmiIPX6l3RphTWjBJ5nfA3UGlJsg6Efh/zbL8IQRO9ATj
 mqcSfdJGVTimwHndY55WmB8FqPACYYhyXYNe1obytHW9w3VNZWIvTNJtpcrlbaPgpP8V
 Bea8QCsA96rmfCo9DX/fkNJl8DWXF1V2N5UsBlTCTGE1OL5kRbRTir2wN9huHaUqUWIl
 AMob0jEmLHwy3gqawtHtzGqmCEARhwE6YELVS4DYkCkwLWOuIXPVV8O6pBNVNjc70tW5
 agbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsFvvOvswAfIc9vIR+VczsDDgoVXfJrxq52IKYfaCO3gpp91wAYLYViNy3smQlNNIQoNa9heFNCXoLg7az2qVgO1VlmEY=
X-Gm-Message-State: AOJu0Yxcsu/FKY8UNZsRURmRFD0kdz9UIvZkTldPypYOLEv5KtqPq1vi
 Wugokn81KtczGENs/k4QvT9245Bfb2Yt8WM2wEsxEY2Qu5Wz3EM7eLCPkby8+ynYCLRYo3D57W6
 jG5zRs1NCg4hIMrjbIBc+8oGDIoACz0J9CRi32w==
X-Google-Smtp-Source: AGHT+IEKZ73V0YY1V2y4QseY93lP3aDNKI2R5DOvULVkF5eWYhLr1G+mXp6AAH47g7mkSBLfTwD7TqSXle3eccG4dRQ=
X-Received: by 2002:a05:6512:23a4:b0:515:c8da:c96d with SMTP id
 c36-20020a05651223a400b00515c8dac96dmr2048109lfv.19.1711637832185; Thu, 28
 Mar 2024 07:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240325084854.3010562-1-ruanjinjie@huawei.com>
 <20240325084854.3010562-17-ruanjinjie@huawei.com>
In-Reply-To: <20240325084854.3010562-17-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 14:57:01 +0000
Message-ID: <CAFEAcA833=Cs3OKPxhxouYKwhtgLcK-brFx_mgfuFa4UhaPOXw@mail.gmail.com>
Subject: Re: [PATCH v10 16/23] hw/intc/arm_gicv3: Implement GICD_INMIR
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Mon, 25 Mar 2024 at 08:52, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add GICD_INMIR, GICD_INMIRnE register and support access GICD_INMIR0.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

