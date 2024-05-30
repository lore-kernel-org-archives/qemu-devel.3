Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB14FC41513
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfo0-0000Bv-Sc; Thu, 30 May 2024 09:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfny-0008Op-NC
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:26:54 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfnw-00013c-Sh
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:26:54 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5295eb47b48so1021184e87.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075609; x=1717680409; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tnUbSfkXGgBkPG9+2xtY3r5CVivQAQiWpVO4PTcBPcs=;
 b=wCU3Rqgqlnace/62pNzgOLtThaTGgGdV7ySUx2oQg3qTSSUdzxbzP93yhK7Ei5G9q9
 AxHPMCVu6fugs1aGvBGVAVOcqepBxtEaACzjNvsptoIInBMP9vovz/4jZb4MpeT7MjzP
 VmLT/B0S2yq4rwwuXK2xd6bfWpAGZKk3DAXJ4JHnpT69rPD5LU15UbJvoi40K0eRuFV5
 ozJJFQtyeSahAR+eifEBFxUL4wtk83cx1jo3s4z2Dhyh76UTSiKT2aDO97/WqcbZ8r1I
 ow67aoXIb0bOKBQKRmVNtplP3YCcUODczPnyfUsirdfYdUXuxEtMzmgQKfdGXyPBO/Fg
 dGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075609; x=1717680409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tnUbSfkXGgBkPG9+2xtY3r5CVivQAQiWpVO4PTcBPcs=;
 b=K7b/L1Wdaq7vp3ymaMfR8j5P4T8eJA+N1guF72/fyf7sSXCj03lSLmuAp2hJqVVrA4
 sx7ORWMto8MlH4+h0U9+VbDiv14hZG99v6qQykVUFi+s+09amImCVPiUdKNOTnWYGc/c
 lxeDG337g54DH1U5SsGUKjEzsk7QG2DDCO/pbSZ5mr4XVsM16j9ttqVyxZIFX/8CDRMp
 8oLBPObO2Choa4hy9qumZqBDPfsK7TMTl0XU+3NBDT+OobK8INgGt4YelqISBc95itsO
 1Mjh1y1Ax6hPkcQ9o7XpNS1Ud03uWnDM1UpRqVrSCjPewa7dQTRrcZi13h8UtgE2xUfS
 1T3A==
X-Gm-Message-State: AOJu0YzfSuB6ajHoCBL3lLXrR1dpoMgLwOUV+d/fUyh8Hgp+2n75Su8w
 DbGxbo4xHb4mWPOtswvTy06bUnoMF7k3g6mX0cti0HxgUpJ2MosvtSI7EpwOvs2Ou43FtXU1sRf
 vIrFfcgMYCRC06qpmB6jSNxHLHvFom21ltz6INA==
X-Google-Smtp-Source: AGHT+IGAaiSwbhvmKYNZAhdqMN/B1BwKevI6x7Bo+8/oyE+pHZS4POOKRbuKdnYIAp4eqTli9FGas8n8l63alQwExAw=
X-Received: by 2002:a05:6512:526:b0:529:9ff8:f45 with SMTP id
 2adb3069b0e04-52b7d48df4amr1450347e87.57.1717075609577; Thu, 30 May 2024
 06:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-12-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:26:38 +0100
Message-ID: <CAFEAcA9_J9dNpkPKcKO34DJ8wSA_PuQXmp2QKvFmqm8S18qELw@mail.gmail.com>
Subject: Re: [PATCH RISU v2 11/13] sparc64: Add VIS3 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Sun, 26 May 2024 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

