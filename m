Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6B1C48BC3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcp3P-0008El-Jh; Wed, 21 Feb 2024 11:02:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcp3L-0008E1-FM
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:02:35 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcp35-0006pX-4O
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:02:35 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d1094b5568so88920671fa.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708531333; x=1709136133; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ApPQItg98og6zq2J05n9e9u66PAxLnH8bTWx7s01yEc=;
 b=Rd4pv6vRBTlpXmyT6A0cTPoGimriGlsQ6XcRZzadInYto/0au+n+AuIIYrnAEZkN1M
 6JcwIgt3Fdgrn1d+FtGrEaIh6xjeKhBjCahGk/79EqufuTZXLDhhSU0N6txuDWDcPev0
 JEGzopoorD/wMna1m3YD1+N0KSB+em/pusdnjYK4Uw7EXTp7hbff740ND925yDBetWZF
 OeKXRia2QLoKlIHK2f4bw+KhQ/aTZ9hOEZyBA2YmVRzoORXWZZ7ZHzKrAvH2KX48Ff1z
 +G0wtfnm9uqupTSHeOBUWmowitA3qXeHPxFXd9yWBr6P+WSGemhO32vj87WWuR/8ejWc
 JriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531333; x=1709136133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ApPQItg98og6zq2J05n9e9u66PAxLnH8bTWx7s01yEc=;
 b=RA5xiYGcIEqYwoUCUelqrYmoHE3x1QPFV8brLu80B+Fq4DzV6DT4DBXiMYhEaP5wps
 frWXgqI9QGH+sU/BTgg539Xr0Im5Oa9rwHWzLYiLWWQIwYrwcUcjoz+veO5EQY9yea8I
 6j+qLDpISJ6MTWCstqtjWvBDoQ7ZaimQBXko2CHVxr9jRMCdHsfu3CUchZbPHnIuuP8N
 kWrNusQNHL1v1Ii6wIlB+xELAOTajEBOmtx8/W1svZS7e1cTNvkwFVczgTNeDGAcpDNv
 abtekzTwJqWTBrahPG9NiQekeb4PmLgEJxK6oWjpRozmPJTdgJQlzU4ui+Iz37WWswA8
 cbWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7zV78KwPrZtHHfGkV2u4mDBsEQlFzyA50Gcz/KUJzsd8sDIWEE3aIL6f4PD6DuJNJth7ighZ8sSCEnzPg23d9MsF/kp4=
X-Gm-Message-State: AOJu0YxHAWj+yKB190kO/z46G0/ttgDskFF0lYYNBWSKKsV2t3PznLyI
 5aGHL1Y3wjr3YVxvTcbAw2igRTDhLsbCLz0/6IgSeLbNuBFNb+S5cA1fxJ3Oixrd/XIVuWFX3/3
 3usX1K4gQDxeYkz5/2iNifOQZeJWnjd+n52V0cg==
X-Google-Smtp-Source: AGHT+IGcTKu2jC2ziJ2mD8gD7I6/qsXyxLH9Y02kntFzl8Kt4NLfnw9q/IzMxpXea7C6dmM11v32lbKC+1URngXP5R8=
X-Received: by 2002:ac2:4eca:0:b0:512:be76:ad37 with SMTP id
 p10-20020ac24eca000000b00512be76ad37mr4528493lfr.32.1708531333521; Wed, 21
 Feb 2024 08:02:13 -0800 (PST)
MIME-Version: 1.0
References: <CAOpGCn+KdhjnXRHup6GXVbkoZkUBc7f-2urNzmvLjK1To_pp0A@mail.gmail.com>
 <87a5nvci5n.fsf@draig.linaro.org>
 <CAOpGCnLxVGhbJuAq+K+DNZBESEGGkSr8Sa0_cHsfMR7S-_ahkQ@mail.gmail.com>
 <87y1bfawik.fsf@draig.linaro.org>
 <CAOpGCn+_=5Uxi9mt-C1V3pguNT0OUJura-H3SwBOsJnW5tyJ4g@mail.gmail.com>
 <CAFEAcA-03JYx9szd3FrQ_786gaRLWCJVHeMgjBxxvgH85f-78A@mail.gmail.com>
 <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
In-Reply-To: <CAOpGCn+vQ7wupMqeH8ZLarT0c4gD85R6cgRqBMhVeAXtZ1F_Mg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Feb 2024 16:02:02 +0000
Message-ID: <CAFEAcA9Yp=ObPhgagAbf2Ev=6=D+9sCfHC_HCxPUr2JgvWa4oQ@mail.gmail.com>
Subject: Re: QNX VM hang on Qemu
To: Faiq Ali Sayed <faiqueali.109@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 20 Feb 2024 at 22:22, Faiq Ali Sayed <faiqueali.109@gmail.com> wrote:
>
> The real hardware ( xlnx-zcu102 ) is being used for our software. The software is in the development phase, and for that, I need to create a VM for simulation purposes.
> Qemu has a machine type (-M xlnx-zcu102) which is supported with the board/hardware.

Cool. So in principle this should work and there's likely some
fixable issue with how you're loading the image.

> I have two more images for the same hardware and I can create a VM using these two images, but in the VM some basic binaries are missing like mkdir and virtual disk etc.

This is also useful information. I would suggest you look
at what the difference is between the image that boots and
the one that doesn't: is it the same format (and what format
is that)? is the way it is loaded on the real hardware the
same, or different?

From the debug info from gdb you provided, the file clearly
is not a raw binary file -- the initial bytes seem to be
largely ASCII text. So it might be that this image is in
a file format that whatever the real-hardware loader
recognizes, but QEMU doesn't, whereas the images you have
that work are really raw binaries. In that case you'd want
to convert the image somehow to a format QEMU can understand
(eg ELF, or raw-binary).

thanks
-- PMM

