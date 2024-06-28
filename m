Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FC0C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:43:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCoJ-0000n0-0q; Fri, 28 Jun 2024 10:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCoH-0000lt-O6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:42:45 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCoG-0007sm-74
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:42:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so888646a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719585762; x=1720190562; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/GIjPQKS9gmuxGPPQ/3teACt5nE1uvfPCy5lFVVL2YA=;
 b=rls4SJrafzKe3v0c9n9ddapKCOR6v4XbFqbgziFCW8cN4xSha2mvAA7h2hOSxaPabv
 dlWBmbMz/84/WTeFIz3VbB06LbqiSAKr9xQ/tRuiyDABIMDWSKL5raEvDz26ckk+DLCr
 x6vbWtSOHQt2YAkMWrQWMZdPhH9J2QhK/lQ6D4rIiKlwKovbUoWPK6jwOZbYNZ0cRSh0
 VqYZHu1FviiSFjX0j9wlv6kqPxNvltZCMeFL2ruMPtKID9LiIh2IB82aKWlNPAUJWh6e
 fpigYlXs/0no/Ps00KIpKe5VL04UgfrecXYe1Kp4Ye6CEZicXa+UQfmZAtsuWcqnYWzu
 n43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719585762; x=1720190562;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/GIjPQKS9gmuxGPPQ/3teACt5nE1uvfPCy5lFVVL2YA=;
 b=IYbbm68zqRGik4jP+pjHUUd8wqBoiJSqtIYqNavsQKN6QVnQ0FjdBL5YLotJYCwzJm
 z+Ckl9JuPz8zAeXkcr/goJL8DVXWhrTxLZvUIB3XHmMOPLR64AU/KJJin3Q2X6TLv6vf
 WxnGY0ZlbHN3M3w+xfsuGVVigx0iIPVCgGnPgCVis+s1swGK2j2OO7imniCsjO7+3R/R
 HHquvZZV9hJhPlA+d4+ShkxKf7p3WjqEF4ga6q88C4CvAbebL5WYpX0omAAjrsT0LZYu
 PkPucO77me3I0lYNn0/JYGktkjYBso+7UxhczFII0EG9majCEgt3QhXsk/pRHVwPQpwV
 SrOA==
X-Gm-Message-State: AOJu0YxEavra615skDf/xyzcc/UcGdqhATR+m5AG4FipFIZh3ioqFDNl
 vXxpKxWyndXBjI0Bqx70CXRj6O3BW0Uao1/Fcr4bqT9h/sKqkJbO2OxDasaZLK1uxUPWtGpjIDA
 uCDudxWFi7MvhUb9ew37QvzsNFvB6AFILZ6NkgQ==
X-Google-Smtp-Source: AGHT+IHXTtgF4j+pk0tWTjJdpt7ugMdWga7cR8HCMa9tYJ/doyHgLqK3HMaqCNI0SoknJQOHIKuss78SgKLQ5JqUs9w=
X-Received: by 2002:a05:6402:27d4:b0:585:3a33:9de0 with SMTP id
 4fb4d7f45d1cf-5853a339f39mr3791734a12.26.1719585762211; Fri, 28 Jun 2024
 07:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240624180915.4528-1-gustavo.romero@linaro.org>
In-Reply-To: <20240624180915.4528-1-gustavo.romero@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 15:42:31 +0100
Message-ID: <CAFEAcA_gvZSDYZge+uAFV8Ka0cmdCTbtJZ+hYaXmczfqw9nNag@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/arm: Enable FEAT_Debugv8p8 for -cpu max
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Mon, 24 Jun 2024 at 19:09, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>
> Enable FEAT_Debugv8p8 on Arm max CPU.
>
> v2:
>  - Revert to the original comment above call to aa32_max_features()
>
> v3:
>  - Added feature entry to docs/system/arm/emulation.rst
>  - Explicitly set t=0 before using it to set DBGDEVID reg.
>  - Put indent fix in a separate patch



Applied to target-arm.next, thanks.

-- PMM

