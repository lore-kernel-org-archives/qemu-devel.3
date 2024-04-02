Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B80DCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 16:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrgpu-0005JT-1a; Tue, 02 Apr 2024 12:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgpk-0005AZ-Gu
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:18:00 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrgpg-00019V-6J
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 12:18:00 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-516b80252c6so733358e87.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712074674; x=1712679474; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OBENLPQZl3y0UeDh+S51CxIOH52m3JOW+ZQe8gjUV7I=;
 b=CcXB8Et5BB5BweGbdCBGrUeJM413rlvbQzy+SkC3DM7biAHv4FejjOfNEhkMERiu1e
 0NjL7XAmOcmWFmTPP37kIdEzjY7K1ilzTuHXf/w6eo2IEw9DI2ml20bFHvNWMOvB9aTn
 L9eozk6VtgqZ6R13c8smW2u0w7fvb9pwXNqtL6jkG1roQU7aBWWGXqtZeUrH1SmMpJrX
 f0vbQS+Cmi5aGWReqOnyyZpTnaEBkBZBTkkiZgcZshekqGzKnm0QVWQCW55znUeFgVG7
 kKAFXSobJ6U5VX18kU5YmjH1v4zsYO1tcwwQuKvLnDUKlS0UW/JLw5Bra7Kikg2f207T
 EJJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712074674; x=1712679474;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OBENLPQZl3y0UeDh+S51CxIOH52m3JOW+ZQe8gjUV7I=;
 b=T0zIrfC8F7gaWV/3aO3T+LitxfvKs3I0JkEe85ZaKjMburc3UHpIKMd55h+vTSpQTJ
 pKRTKXyT6ycey90MsnVLCn0AkFIUbmtGgpt6459v4QChkNETyBwQdwoyUDIJ+pn8GwnM
 5YQDzX0iyDOEryspvUnDb4UAV4e9yNm7Fe4HEmWk3WBUHBFi0wS+isrbTkQmaxJudO2l
 /oAdBdUqkb2cQp4ZoR5aYvY/OaounJ7w2ub+gNdwvLtCVk+f3EXjE34eJBWX83tzczlt
 wmxXngF5MSWV0qZhAOQkfS1F2VVK0yWL4l1bM7ewGSFH+2I0dX3W7yVpBEXxS8EpcuWj
 zC4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuv20rC7QpgU7bC4UEwIjpehiozukJ6MO+EW4lp4jPFv/J9m5PydpTUD/96Xk0E8AitH9pmcPSPYGMcqBsjVy4A0VlsZ4=
X-Gm-Message-State: AOJu0YyuIyiuWeW+fe8DMDr0HIYz+NpUui8aOLFizHPsjtdg3EAfbVBg
 jtm+1T3S556ZISHeOW9/piwcvOetOFVK20Edhcmj7uayI6Xo9/ZrLeQ8Bn+jLxM7vI8DJZ2/b7m
 7Pl0xC0nFOvxAkUoUuGbybebav7Zn9ibAbI+mZg==
X-Google-Smtp-Source: AGHT+IFgWtZskWTtFq3oO4fQH13tg2MeTcnAg1hV0QD3qRgdS+tOuU6pFS08Z1VoyBqeifFFc9q1N7EmIGezzSuzXsM=
X-Received: by 2002:ac2:5445:0:b0:515:9479:a997 with SMTP id
 d5-20020ac25445000000b005159479a997mr50711lfn.10.1712074673862; Tue, 02 Apr
 2024 09:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240330103128.3185962-1-ruanjinjie@huawei.com>
 <20240330103128.3185962-22-ruanjinjie@huawei.com>
In-Reply-To: <20240330103128.3185962-22-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2024 17:17:43 +0100
Message-ID: <CAFEAcA9fSMZ+PHgnfHb95_bcUtsYxesfDOixbpmunsYZ7iqFpw@mail.gmail.com>
Subject: Re: [PATCH v11 21/23] hw/intc/arm_gicv3: Report the VINMI interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Sat, 30 Mar 2024 at 10:33, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> In vCPU Interface, if the vIRQ has the non-maskable property, report
> vINMI to the corresponding vPE.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

