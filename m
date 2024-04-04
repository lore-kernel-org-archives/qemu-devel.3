Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46469CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNu9-0007kW-Qv; Thu, 04 Apr 2024 10:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNu7-0007k0-TD
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:17:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNu6-0008Uo-48
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:17:23 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56df8e6a376so1965332a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240240; x=1712845040; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ndWlPa6zhRAVmGdn6CTl3nAYatbINrun3kGndczn/7g=;
 b=SXO2kyI3eztU0hyNc+801zA1wrZELqBPYpUBi2pri2ZYwoPnREOKMCSn8zpXBPOplI
 pNLwJLbiXxEmvVKx4DaptyRybjwn+ZZQyOypmvRLWesjns+ahYnk4w3JuWgXIPeio2+q
 uVjUtTC+9VZzCBB7hTV9wv5EceyqLHUJrTo1CWEEPqjczI6rHlT6muRQOzpxxm9T81DC
 w5U8Q440W3viZfOPDZFQVbWQD0h8KlMbNZlVF/dhh7xMvZFOCENaWRBtfKADQGBZcTjf
 QddNeBPjDsEDLv0fXrGhhEOk62fG8FU7++89u5E4DSZYtiwFfX3y3Ek7SvqwCkcXTxbZ
 E+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240240; x=1712845040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ndWlPa6zhRAVmGdn6CTl3nAYatbINrun3kGndczn/7g=;
 b=ug71kvjM26PsEX1GvEbuoHBiHCK+BA4hCtO7kTjbLtWRdoKiXdeEkfst85rY7cgPvo
 y17E6ukjIPDNALyGHJ1tRD38ORimxLnQCiEPlTO3ha2v2NJ88TFZaPD6jLkrcr9uLEaA
 jD0RW4x12opMUuCPWCudfRfzN6J1afkxaVJV7BPOTxOl9jnA6ZO+MVtZ3ssk4tEGNTOJ
 Zg6knnwkuhMkeS6yE+iyObgcntvXRjSsB6KXiuEGh0YlSIT8+R0l6WZ29EdxeDIHuVus
 z6txu7qyIZXN+a74qEVw/2AYLnPzAuDYg/DK78nmXLDHafjE3I/Q+86o6uRyaeTRbMi6
 fTIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqqi/65eYC7emcGC/7epRsSfmhWf7lxINWxLeFzLLsxB/QUqcCIZ0+W2D3MPbDU/1x0qZAm4aARtVkvHfego1rHeH2rP8=
X-Gm-Message-State: AOJu0YymN2XzvhnTUc/YisUw20RQMkAw+c2NWl2Pt1SJA3gUdrQLqYJH
 lbIlTIzPzIWoJGxNM7E81qIm0CaW4QaCZQpZyRZgfbp6ELb6YhjYNuKQqGV5GnXTeU3cBbn/cM+
 NiHY7vaTR2id4qFirywTymKvC2JWF1g/nvQoLyQ==
X-Google-Smtp-Source: AGHT+IFcVPFZlZL+M3deW6dWJWsVbhB8D89qHkCvpteMTaSwG7FvQfIw/SFjvtVlPzeNyOvb/HS9Oa0cV1O2rvffY0Y=
X-Received: by 2002:a50:8d19:0:b0:568:a226:6685 with SMTP id
 s25-20020a508d19000000b00568a2266685mr5457122eds.8.1712240240463; Thu, 04 Apr
 2024 07:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-8-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-8-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:17:09 +0100
Message-ID: <CAFEAcA_=XA2CfUwXkUqJvKWHspjcspsFaND=9vgL86A_bE6mvw@mail.gmail.com>
Subject: Re: [PATCH v12 07/23] target/arm: Add support for NMI in
 arm_phys_excp_target_el()
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan via <qemu-arm@nongnu.org> wrote:
>
> According to Arm GIC section 4.6.3 Interrupt superpriority, the interrupt
> with superpriority is always IRQ, never FIQ, so handle NMI same as IRQ in
> arm_phys_excp_target_el().
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

