Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE9A7C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:30:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhUro-00046V-7n; Tue, 05 Mar 2024 08:30:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUrk-00045N-5n
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:29:56 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhUrh-0001CK-O5
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:29:55 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-565d1656c12so10045287a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709645392; x=1710250192; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ap3AybvaUQ0kuW3zA15LOOm9W7EMN77RM6On5Dbbezk=;
 b=yLpIIU0vexz3KFVRUoLpuiJ3xuqhXvUsLccZeo8VflMNcwGjsEMLaTvw+/NBZWTvJ1
 bLgn/QtqF4wHshT1iQ5Da3WV5oojQn1kVAqgCT9w2VdL1V5mUyfsHKxbWINRK39kVuza
 yPb/3yGlFAyQGKJ5HsmE9UNvUln+qJUkX+opDmZh143YV590rvXlEjwNosfunOCCty6Q
 gay8/mGAOAJtujlGKTolpamdaFtxRVlMa57880FE1MgRXy7bGYM9c+RDajD2OHbRfBz1
 /4/gGC26lOU434K7Wdadmdk5yv0mSik5ypPtwutki35wda4ju5/6FRluPvu8grXdSkTY
 EYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709645392; x=1710250192;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ap3AybvaUQ0kuW3zA15LOOm9W7EMN77RM6On5Dbbezk=;
 b=vgLD/boTJd2KSp2u1PQA2w4dwufX6+H38NcxVX20o/r4BOjGmFelgwT67gyp2e+FrY
 ocXexR/GcnnUNWteCuAD1x7Qv/j3PVcdomsVb8FlRXVYB8Gzsh1vWZoPLRQVPW34ZO8F
 yh6lD+uWu/T2+e8Q4CLud0zlNmJrtN/dBKGeuDxzS+hYbbBvCrU7QGVB65Cl/o50ngqo
 e5cwXkPQlTbanAZ+S6a+3XSW8EUOgeHHfL4oXuDpol8gTOpcxoF5Eo8lHgijIF9lIXqt
 Lz12x0wkPlu5pgBb1ToPnN5AOzTdntuUZUswc40GTqbaveEibRj+AnYCoNIBxMX+V0Ho
 zsxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaKmvXGzH5HCfIg7Tmay7fRRQLZAL2LbSU2diurTxtQhPcebHdc+0GrQrYmEE4ICivfonnSExUTk8PzaD/zqMFsOfWiB0=
X-Gm-Message-State: AOJu0YwbkBVGjczG+GkLVTEU6rvx+44x7z1rzwS9V+B2tso6CMu/PXiL
 4IMZF8rj7QhE0rWzcvn7kjJ9JY89+LJ1UJnNKMjAOA/NOpnar+3O6ErBMVDH127D6qwxmrbL56s
 bzBWtEpNrTo1WttIx7vJCJ7ODDTe0dXYDQDy/1A==
X-Google-Smtp-Source: AGHT+IHAqfJlf2RjpAjws/ed1jlFoSZ+dXrlFzzPxTbmg11jJGGVxhq/htMruCIUf4bk0IHFsxqquywgjq5CV6lUmxY=
X-Received: by 2002:a50:c94b:0:b0:566:78ff:b24e with SMTP id
 p11-20020a50c94b000000b0056678ffb24emr2643532edh.17.1709645391813; Tue, 05
 Mar 2024 05:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
 <20240305-elf2dmp-v2-5-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-5-86ff2163ad32@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:29:41 +0000
Message-ID: <CAFEAcA-P_hEFV5J==LXxp9CtLb28d17pBhmdn_QBqLMVfA1qUg@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] contrib/elf2dmp: Always check for PA resolution
 failure
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 5 Mar 2024 at 07:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Not checking PA resolution failure can result in NULL deference.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

