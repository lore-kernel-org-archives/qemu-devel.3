Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D64C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1redlc-0001Hx-PT; Mon, 26 Feb 2024 11:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redlb-0001HV-Qs
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:23:47 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1redlY-0001By-JC
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:23:46 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so2644616a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964623; x=1709569423; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iil6CiX/VdEUbfCHLnk2baxKXUCjytmlEEHy60pWFao=;
 b=AgIf7x3NavIzW9YFNW2bi53sEFB4ZKVg3rnib94iRgraW1MQkICMuCR2ju686L1E23
 nHkjtp5csxV3WSXItV65tZC0vy6a+qReImQPv7AaUN3N+1ncltbD/VuYD1Z/55IIiSNO
 RKNiXYlgKXBkvmsrWaaUTKkCu3WgrxZWz9nyoCKtSywWksX+aqVpAP2G+xnU6sR0OpYS
 DUw3CwAdWWoVfS+1LV/ZuWTQzC4bY5Eg3nMhd/d2PEAmTiYhwNv67yLtMn53bq/rcHXc
 EYYLIcaaaAcQdlejloB50yXjpXQsD5kq18IwuQJA+IQZ+HxdwqTeVlj6Gy3SmpRt2cZa
 Q0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964623; x=1709569423;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iil6CiX/VdEUbfCHLnk2baxKXUCjytmlEEHy60pWFao=;
 b=XBzwqiVv2AHCLiba/1OgDiDxFGnqm9Hun1P5mvaCXKRt284Tvk1b6RsmwcxaBksdBn
 ivgLleS6/EBf1j6xatU0m2zPuNRu09tkr/v9PZ9GF+J+ced6P2AWNb4qW+6k7/EkSKAT
 82ytg4qLzps/X+XKv1kGkAC9FEp7iMMd16HyQTPqdssNCEzdpGZJDaqshOqdFOMzwhK5
 6qHC+XmczpWZau2wPtGDZSiBDsxkpZJaxZnh4N0sPKH4J+GdW7ZuJoKjG6u+VNUQapd/
 KbTBa7WicWBV6YJAiUZ4awU1+XrzNDZY9ffPPNmQ+4qM8FIjLPrAt9XYAaImq8oXvuNG
 x9Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoRcUsQzcpsB4D/lh4nbu8xmqq/XbzZOSF7oH4opuFtrkKybd4xPTMfJY0VCLlL3H62rq2DcXFcyd7EWg9LMYCAVbE1OM=
X-Gm-Message-State: AOJu0Yyjz19ZtqQZHcA2BJBv1gMfomaEor0srM4+TCPW2Ch1KNuIIb9H
 hQXmnCXVzE5kYGiR3ClkHbE4i9/jT0ao5suL5q015bqE1BWutiP8ggSaEXbBPD4wCRCl8zQgtGh
 PS3bnT6JV2WX6JvWLeBq3/fWrtfENv2cZ/ACjpQ==
X-Google-Smtp-Source: AGHT+IHXrRRk9bRHWrEMntsyFrAvb5pceCYtdhxEn5emwCgSKHFO2QCGSvtbhaGvBShRDWF+TcEcd7RCfqtL/jANsqI=
X-Received: by 2002:a17:906:d922:b0:a43:aff:8490 with SMTP id
 rn2-20020a170906d92200b00a430aff8490mr4517613ejb.25.1708964622904; Mon, 26
 Feb 2024 08:23:42 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-34-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-34-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:23:32 +0000
Message-ID: <CAFEAcA9MpH8MaDkmBzsepYtrJ_jJ4igSN1Q+F4tu1Svn7Er5uw@mail.gmail.com>
Subject: Re: [PATCH v6 33/41] Add mailbox tests tags. Part 1
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Mon, 26 Feb 2024 at 00:08, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mailbox.h | 177 ++++++++++++++++++++++++++++++++++
>  1 file changed, 177 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

