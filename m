Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C67C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfms-0003X6-Sq; Thu, 30 May 2024 09:25:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmq-0003Tz-DS
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmo-0000o5-SZ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so1046016a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075541; x=1717680341; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yob7zqmHE3cJ2DMZKrphgCkOKYW0YBltnOjx7h4hZ2Y=;
 b=fytiEH0q/5BO4rOeDzuFIo3FpEueHjCuEuNeSKXzx9E0wbBYKxg9lvYNrM7/DaxLc1
 Y25ePS35YQn0C9tdmZjYr9vMdSwLE1UjODOaOGXUYM3XdVn8BPbnOD5005Cwb6jLNJy/
 M8ffBwv2JBAzySgKAfQwn4z8lBvj9I5GnBUNmdxNGoWiiVT5JTQF9rWGME0QhdJOqNSU
 h4K9aMfMxEXOPDt9HHq4TcOEs7H6p2PTIbOvPLXdCIdLN2oaIiy+sUeoC11RgvBFBxl4
 fxIiydfTzi4ZZ7MyWmIp4szHb6y3dssZVcRPjozvzZuHriaX5oyz/95frdD62+yGEChT
 RVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075541; x=1717680341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yob7zqmHE3cJ2DMZKrphgCkOKYW0YBltnOjx7h4hZ2Y=;
 b=DayQlP4LG5lMJ8kvnO2H9RYmN6BlXjBZbGbe8q1oS114ntHQ1BoCnduLrotRvst+Zv
 FSAG37ztwY+yrQb208JJUvkfSVpDW7FnGcU/n6DX/EVZehQSbHiVU6UJjwhkv/WiPCSs
 5jR40Rh0qOD2Y/1fROSxlruXz06My9YygNbFLNcSLXTv8DrOYix0H5XSLWptSxKcFa6e
 FXS/1wiDLts5eBjjqrO1qOO+Gev3AnLJwt5cQtqjxnl58Qcvn7tQRk+PTjaPU260G/Dn
 Ep3ZZaVVlst5osZdcAlAgW1QOqjRFHv1IdYGnlBU2AG9y3Mbh6uvoPGXOkf2e+PqbDh6
 MNtA==
X-Gm-Message-State: AOJu0YxNRGwweurY/uFN9bbdXk9o7ZKMJJORdMNUYZ7DvJc2hewgTcM5
 Eg9WKnoZgrE/Skz+v6Vu9lSSe5WRznuRi2S4JYO5J9qkhPI/exnYrl9eBGdLwnI9y281HsuAlKX
 iKfAXiYnpk+RUh33enVNExs7FDqfAmoE0FhmEQQ==
X-Google-Smtp-Source: AGHT+IEsEvTeLDSsxVGOC8fjWPlV4wqE1tggH5VeBoL3wZUbuA23/IwqCPKIg8asWlzcC7Q3BNucCPAR4HLJbG5QkTE=
X-Received: by 2002:a50:8d4d:0:b0:575:954:7ef with SMTP id
 4fb4d7f45d1cf-57a17791d0emr1466667a12.3.1717075540894; 
 Thu, 30 May 2024 06:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-14-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:25:30 +0100
Message-ID: <CAFEAcA_hZUS2-H9djcs774zQoBz2dTm-OipCGZPCzYcPQxZrRA@mail.gmail.com>
Subject: Re: [PATCH RISU v2 13/13] sparc64: Add VIS4 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  sparc64.risu | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

