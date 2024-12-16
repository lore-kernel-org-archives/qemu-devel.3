Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F23E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBgm-0006LF-IN; Mon, 16 Dec 2024 09:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBgk-0006Fu-5i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:03:10 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBgi-0006Y1-Fl
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:03:09 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f145e5cd83so33626207b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734357787; x=1734962587; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RzNMTvisVl00JWzDIXfMvjdII9ZM6+cpVBAh6Ss7FO4=;
 b=DyvOOJj9K/FEgR1ZL0Y2nF1dHwGQrNf/80bg/K0rCkGBx1VWri12Za4srgzlkKEGKU
 aVUgXnIgFutsiw/vhQyiFs0Cfys8C65fRFewMWGzP57mDWvqOnBJgd3TPsvYHZZugrsU
 qrAifGD44G3IFSoycNkbORXaqtl05hFTCVzXDTdvCXmKktf6azM7d0+oHbi7Ovb4jiTe
 iL5KdwyNNpHtm6W+3/yvspvTFCkdcVijqgGEOACMxwF5a3FwOdyuC12cGZbtGyPaCy8A
 7qUr4PGdRGTWzCMh3h0+rBezEkWL7eCXu159xs6iZ8dEYQVARvYJXh1HfhA3exnlPvxy
 /UHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734357787; x=1734962587;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RzNMTvisVl00JWzDIXfMvjdII9ZM6+cpVBAh6Ss7FO4=;
 b=Zx0w2F1COyTVkYT+m78ruYxpbb0khoxysuvMl8E3/Hv0Kb/Kz5nz/vjKwGenm3QM7k
 M3hE6m0wcSHpIWpy6wHq872pSeFL/gS3+dN0CscsqYmFUb2rQAf9xTxqZUMwPXPd8yei
 IU45PN+FJ5HrY9buWL4B5CZLycfN1+NvfSY09ZYGgrvbLyDNacbclYGFPvM+Goghw8VL
 Xf5qVCMBG1niHIvk7J7RaJ2ApJE73c8nDqc/tLhY6c0bZ+IUwyJ2Pj9l59T6R0+4b1le
 jfKqwf7UcD7nzOe5Ic/0gZKz8L2SfcrsHSDb7cVNkmtSQnC/WRM250oDRT6AoLuCewxu
 orRw==
X-Gm-Message-State: AOJu0YwrwV70TIQEJxzNSLFs3KR38ZjwsjvnXiN8SoEBYI82KgTWC4Ga
 7zISjQ/KfYUUGpHxBX6L6ue7SPvv5Q3Unb6+XAmFHbOJ1yhHpulQfE+d4OMAAiSpumcXSyfclm8
 Z7npDwERI/DvbiU4xVG44t+VR5Ps/IZSiSnUdFKZo20zwf44c
X-Gm-Gg: ASbGncvJPvE5Wfy+Hox60G//WpnfzPc2OVBA5ZO8MsgIB1uSiVCpqVMnD9bFTPcS9AU
 mujgEZ+EmoLjQdq9747oA9jiVurGgcFYlHg3x1Hg=
X-Google-Smtp-Source: AGHT+IEEVSu0vpsy8bvqsQEWExhOs4LtDHA2Ygnbba9EKrVgm3vz5hnYOvlKwSGfGYdJ0naI9rFg4Rzn/F2Ld/6DOVA=
X-Received: by 2002:a05:690c:4b0b:b0:6ee:66d2:e738 with SMTP id
 00721157ae682-6f279adbfb9mr114447157b3.2.1734357787083; Mon, 16 Dec 2024
 06:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20241206031952.78776-1-richard.henderson@linaro.org>
In-Reply-To: <20241206031952.78776-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2024 14:02:55 +0000
Message-ID: <CAFEAcA_ERdrBHqX4nOP7L5Vcs4ZQownF4_=QxYjRfJEuRigfpA@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: Two more float_status conversions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 6 Dec 2024 at 03:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Hi Peter,
>
> You probably have something like this in your AFP tree already,
> but while I'm sending all of the other float_status patches, I
> thought I might as well send these two.
>
> Based-on: 20241206031224.78525-1-richard.henderson@linaro.org
> (target/arm: Helper type cleanups)
>



Applied to target-arm.next, thanks.

-- PMM

