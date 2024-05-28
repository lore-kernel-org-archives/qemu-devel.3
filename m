Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9685C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBy0D-0000yS-Hn; Tue, 28 May 2024 10:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBy0B-0000xi-JZ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:40:35 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBy09-0004GF-94
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:40:35 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52449b7aa2bso1132388e87.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716907224; x=1717512024; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=theRZBDNGK++NqeefakMBCJYyb2WNN2sDus0BMaBITA=;
 b=PvQlph9tm5jRn5Xi8VTea8hnnX7gujkdi3Ah6eyb5kbHjmH9jZX3ETmLx0+oCjwz4g
 wxzJcZhXdp1/AwSyodmDjy3XrNF+bowVSuffstL71NpsV8SXIrdlNTp7SMDk2hdr7Xoh
 tuySW2W1A2zsimAfQzhDwXEDJA+BWBWc+HPEOvG3OQxdUaD3VMfK+zQiKXIDM59KWzEF
 Hny7qK5bkpdkw9vqgsSWX137akq3Pt0+LR0E/5O2qNm9pSIwYNBW99f06lKGv5KxY4wm
 /PMfypCvMtfpMDw+l/vNiUMynPrkC5h0hh3NNOePtq9wI2gkbA2tPZAPxwSWImnt8SIL
 i4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716907224; x=1717512024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=theRZBDNGK++NqeefakMBCJYyb2WNN2sDus0BMaBITA=;
 b=GzvdaVoeL1KKAA4YLIMBYoNqYbazKkA9xGM5Zt5d2QcRqvx5YryANTw001+/0cpDLu
 RqPHZpMqfG8yvJ4ebcxHveij6d2eTY6yoYeuT+ikkSZ8NGtYLcL91cVSeEhaH+rRuBFW
 7QRPr3/uylmjfhLg/15aU/tPod2kl3k/PpKQN7lFF7L031inyBMDSks9xoyQlndoUACU
 z6VNH65AMFbwUp3NyneQhzuaUFHscwioJNdnm8LajXINVXIUAcUsq7W53v21z0BSqsWW
 lY6jDncqfiA1JyAkucvCy5eW7DszvtR/dwee+1RWXI0Sa+fFGrNHG2gBoFomFo7YFFjF
 DLyw==
X-Gm-Message-State: AOJu0YyaAydnrfGAQD6mGfD+VmOsIcvWkXpYCqIBrx5f/Rv342luReE6
 dWy5PrlaCclIBqLRE0WxK7/io2qAYYeVV9goxQVyktPUp1XTvghF1ZtYfl6wd9CAiiq5KXqb3ps
 cFJOwbok37ecldXvn2A9+2d1G2Ek1UVuzuksHxw==
X-Google-Smtp-Source: AGHT+IFsRF39t1vHOe5KvjCPLdL4VGe1Kb/se/5rlCX//nlkHEmy5Gze6OZPcRFje+2Zu26Ljg/EiGoSlaoG44U0i28=
X-Received: by 2002:ac2:4548:0:b0:51c:348:3ba9 with SMTP id
 2adb3069b0e04-52964baf3ebmr7241761e87.22.1716907224210; Tue, 28 May 2024
 07:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240523194441.21036-1-ines.varhol@telecom-paris.fr>
 <20240523194441.21036-2-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240523194441.21036-2-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 15:40:13 +0100
Message-ID: <CAFEAcA_ib6MnFCSbigVcqUHYzD22nVQHQYVCDGN7fkqLduFQvw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] hw/misc: Create STM32L4x5 SYSCFG clock
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Damien Hedde <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc@lmichel.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Thu, 23 May 2024 at 20:44, In=C3=A8s Varhol <ines.varhol@telecom-paris.f=
r> wrote:
>
> This commit creates a clock in STM32L4x5 SYSCFG and wires it up to the
> corresponding clock from STM32L4x5 RCC.
>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

