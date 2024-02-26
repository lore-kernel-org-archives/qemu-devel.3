Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7501BC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 16:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rednx-0006XD-7m; Mon, 26 Feb 2024 11:26:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rednr-0006I8-Ko
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:26:08 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rednq-0001sM-9q
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 11:26:07 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55a035669d5so5820279a12.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 08:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708964764; x=1709569564; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Al7NiyG0DjAOIvuLmW/3Gqmjpit13X+oiA/kiHxVdTs=;
 b=F6QYPBayGDYTpXcjXv6B2VVEipUvnJVQiQMmaGofFWs46gsjRfM/b5G7sdxOIkPc43
 xv6WzTGkqz1xwNZsiSDTv/SfhpDrwdLGOeV0pN3oJDLUQW1g+OCLgei5kuX50TS4W78e
 F2/0YhMK3aDLYIiL23IjxaODuXVGO1Rx24C+brQeosyq0/9u8A2fryEdWFN2M7RDrSMd
 MpU62AjmtELBm1gaZajsF34LUqR2zedUJVpXSj3QEjOf9YvI6/OKXyTFZqpkcaGPqaZ8
 iuf5ilra0Ha2ZI/P3NOWnpJHaX9yP+/4d+qdC5MPLPv75lZlmzzg4bkepssLkoft7tNE
 mcpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708964764; x=1709569564;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Al7NiyG0DjAOIvuLmW/3Gqmjpit13X+oiA/kiHxVdTs=;
 b=MNlMnZ7Ra/Lw72TEnm7UZS2Cvat7Kesg0HoVx8CI/vR1zR7DzH3ACZjVRbEo/RsLm8
 Gj939Q44P1pdrTV1xC74Q+/7DNexaqKRx8hsUul2k5HKAE/aJCDNpOR6gs5LFNf6Ph6+
 WGQN5Vxf+03Uile4RFSEtLopeFoc+QMA1ZLbJ+Vqw+3pctmmuBFbQbH7Z8QEZ+6JM9Nf
 niaf6vHXOtA+IOOzmCjqLI7JFk6Mc6qCyw5otGGBVn18kf5slnqfm7YmHPfOrl5jZB95
 dzh8revDwt2dFk+U9HXROojYpjV3Fpm/zA1lYz0IbCwbyuJUGpdlA6UPdSvnVY4qM9UY
 uwUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI7Sc7PLsvdzK7wresbixPFpgkg5Y8JCdqMIs46Pit18kW0+YlMEfBPF857fWT7StNefB0kvR4aBJTTKtcskLlcVddwRc=
X-Gm-Message-State: AOJu0YwoZGx501LEQkQ+vrfetpSd8doXdXy8Ly7a8UHGPFiGmpQAp1By
 oH1OMEZTu5trHK9QookgAxP5nlVY8shC7feXERJa+btAVyHEDPG2lCFeiKQiGdz55mkIFSuogzd
 NVCS2GV51mw7F/07ERvbqAC1vJ/OBSoQswZynLQ==
X-Google-Smtp-Source: AGHT+IFjbLlwJXTgowIGiTGF8KV7eCcVKH6xHmLXAnRUrNyBJGIA4bgMVi9hIzOwDjfmszdD6ZNVWB14FlWdIJd2vus=
X-Received: by 2002:aa7:d513:0:b0:565:7ddf:548b with SMTP id
 y19-20020aa7d513000000b005657ddf548bmr4990645edq.1.1708964764283; Mon, 26 Feb
 2024 08:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
 <20240226000259.2752893-41-sergey.kambalin@auriga.com>
In-Reply-To: <20240226000259.2752893-41-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 16:25:53 +0000
Message-ID: <CAFEAcA_gp+maY=Dz4=kQMADawu=vrg6pTxLLpjhxG8-yRNJnRw@mail.gmail.com>
Subject: Re: [PATCH v6 40/41] Append added properties to mailbox test
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

On Mon, 26 Feb 2024 at 00:06, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/qtest/bcm2838-mbox-property-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

