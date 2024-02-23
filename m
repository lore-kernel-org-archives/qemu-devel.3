Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2E3C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 16:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdYqN-0007uA-Qy; Fri, 23 Feb 2024 11:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYYr-0004L0-J3
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:38:11 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdYYq-0000QI-5l
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:38:09 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5640fef9fa6so1331614a12.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708706286; x=1709311086; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pZc25dn41Pr5mgn7N8TPAoYH29m0vSeYFNGuMqZaUnA=;
 b=DZhz1JfPlkKwdj1ZkX7JFlcApFIE1iU/PiH8X+GB2c5faMGe5XjO29qkz7miQ4NQpQ
 BrWBZ4H+MRRfGXWqPFYK1Ocdbc5CvXylPZbto1WXwzxcvPDZmWbfTwQmOqpz/OCGLuBn
 elaIsTjJFPbAg38kSIteRSZ76qG+fRwRDa9QOvH+ar0J1dzLvQkSDiarGAiJhDkxp7sT
 CChCtKM7frZgFwpQdvkJpKZC5A0rMUsPQpcD3HWAkSNFatwMqYe6DSEzijugr4NtohWo
 sAGcJBxaMGqbLIMqiwiUJ/n7uuBpmgvl/G0mTV5iClG/Hwx3TODIFQafmIUT/dB/fDnr
 uQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708706286; x=1709311086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pZc25dn41Pr5mgn7N8TPAoYH29m0vSeYFNGuMqZaUnA=;
 b=pROCS30DPeARyOyJwlB3td+l0Gw3aM7TH4PMsRv06YFsodK1AVLt6GD5PFZNpBP8pz
 /DJ9JQ/XhkBji2Z56BlD829daU5PgCh0AuEMPSdSSN5JM//OlcqsR7noSHZpAieWtcNF
 uwaIPFMqBxLxIgV6Mx9oJyhejXqUzSuEWCiiu7Nuwz+uaOuWwk/Ni8ZQgfEX+ftQJ8DE
 YanAijmD97rweQwVoR6KgRgLSdOB0M6y9T9HzaHt4rpVS2bMHuUv4Lo5IvvQu1kyhSgq
 yfB4SXgFYCvlpsxTdCjwlq5iPfZiWteBp3sNLWku5qkYMN3iZCiOIpOyP5G7dDVszEtX
 aJ/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbN4OSMCtGdDMP/n8ygdpeOKCv68YzAMTkpX1WMEBUWV4JiapHQgHUogfW/MgO+M4h4Cc3BIX5CTc5dTfcnKvPTf4VIW4=
X-Gm-Message-State: AOJu0Yxy//KS1gwvXVeaT9MYI+XHvQo/7IaN91zjWpbcfc6zg4Eib6Wo
 LDBHbYpUf2QpXHMGxrcKjCXDhXZci1fsEUgZ0cYOPRXqDqT3WcPTJNgg+KpCufr/CgMVszM6Znl
 ov7ruqg0T9iRndg/EjgasQF+8Ryqn/+5ejQ+Ezw==
X-Google-Smtp-Source: AGHT+IEO62JGTtyWFYTtTBuRIeykeBiDbHeesuOer7H8xnPeG+RAknPHeu5ytFXwjEd+nY2g23hdAmD/rtOLPAxuW9Q=
X-Received: by 2002:aa7:c0da:0:b0:565:7ce5:abce with SMTP id
 j26-20020aa7c0da000000b005657ce5abcemr248485edp.20.1708706286597; Fri, 23 Feb
 2024 08:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
 <20240219011739.2316619-3-sergey.kambalin@auriga.com>
In-Reply-To: <20240219011739.2316619-3-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 16:37:55 +0000
Message-ID: <CAFEAcA862NjREpcjGmSbB_7zAG8vD=t0AkpqdwwVQj8FnVSUUA@mail.gmail.com>
Subject: Re: [PATCH v5 02/41] Split out common part of peripherals
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 19 Feb 2024 at 01:19, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Pre-setup for BCM2838 introduction
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

