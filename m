Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF07C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 15:47:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdXkg-0007qA-9x; Fri, 23 Feb 2024 10:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdXU5-0000CL-NM
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:29:09 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdXU3-0003b9-10
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 10:29:09 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so745459a12.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 07:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708702145; x=1709306945; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1J3UoHjFJPKnl6Qoer8WhClUd9Q0ATYTkqVr3fZbVRw=;
 b=v/SZeMljtH8ahuFES9nrqIviv8ezt7RB1xvmbUzQ3++NhOmdGeTZ+eLHb1W6G4YpI5
 UCxVcpdy5mrOId2xv8XRqTGJvWMuAE+XSENjMaJ435Jk3nEIjmtIAITsRAd95pg+Tb8K
 qaUHh0pZ2mSbUxg77xI/etdN0O0QQhaawyI98y1JY3qzbrzfGrFjWeSr+dQxwfW9l2yP
 l2dVhOEj6n+zg6qRhJynn3tVlLyDSqFhKA0gEsrY/Ekr9x8Q12phah6sF+mzndvlpfJr
 URZEwcDuiHgi7HG8J+SsQQeQnIH9bsdLTc36tQoTi9I91tkSTy2u5yH6wHYwp8UGGPqn
 WFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708702145; x=1709306945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1J3UoHjFJPKnl6Qoer8WhClUd9Q0ATYTkqVr3fZbVRw=;
 b=br0PK3ymX6FF5jkecSm419Iwnb8reuEcnaFTlFdRuC7n+DvL6WZgTXLYQzuUcPj6PT
 STADASE+J8H7B3oG3SHYsgKBb29KFFq7K6U7jTFR3knddw/mpcmGW/CiYmbLRsgUFSxL
 hLRUAaZQDnE2F0Oyq8twjD4FtPN5sDfzQyT/xnd5m8VuIXyZBsxrW5inkpj0s575gWAn
 aBWM2Ud9jFtXZORFXe4oPrxqyVeNcgB3KliOISdm31urkPV7dWkvrh9wjsCGeOdtXqvP
 8sSRihaMisElxHDlwi/juzxPUzSV+TpcSfeOLCsa1zzVa3mFj9gGsQR3H+LltAXJQxGs
 dZMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvTQjom22LyrChFJjOKZ7V71+QnzUZdQUCsp8q4bINnQ9r2pjZYn2+OxJdDswINodq1hw7sQOAVQGpdTaBqLK1730D8vU=
X-Gm-Message-State: AOJu0YwfeT9rfywyRlkvK2Fa6nkxI5d1FRQqdQppdqNPGwn9+9IAG3JL
 xlhZAE2skkdpGKc8jI6ttbbhXHW+W2WaepNNOvWJ/VAm6a0hedZILuqo87BUutvNCfLIA1cdm7u
 jEJASCSnU+hCOrbWT7qEibJU/8tM71jz3tA/2hQ==
X-Google-Smtp-Source: AGHT+IHSWb391vn7C+NUTqgWCpTp1eUtkCZHH4ukFhpvuUPClt5kq1WPoxMSkI5Rzfg8FJZ5Qf1zU2DlvTVMaDsFkI8=
X-Received: by 2002:aa7:cf18:0:b0:564:9019:d9b1 with SMTP id
 a24-20020aa7cf18000000b005649019d9b1mr85895edy.40.1708702144720; Fri, 23 Feb
 2024 07:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20240221173325.1494895-1-nabihestefan@google.com>
 <20240221173325.1494895-2-nabihestefan@google.com>
In-Reply-To: <20240221173325.1494895-2-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 15:28:53 +0000
Message-ID: <CAFEAcA9rhq=kA0zFde=95xcA6DYWNO-bYhZ9paVLN4h3V7-HmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/intc/arm_gicv3_its_common: Increase DeviceID to 32
 bits
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 its@irrelevant.dk, kbusch@kernel.org, roqueh@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, 21 Feb 2024 at 17:33, Nabih Estefan <nabihestefan@google.com> wrote=
:
>
> From: Roque Arcudia Hernandez <roqueh@google.com>
>
> According to the =E2=80=9CGICv3 and GICv4 Software Overview=E2=80=9D the =
DeviceID is
> IMPLEMENTATION DEFINED. This patch increases the DeviceID in send_msi vir=
tual
> function to 32 bits to allow the possibility of a redefinition of it with=
 a
> bigger DeviceID.

It's IMPLEMENTATION DEFINED, and our implementation defines it
to be 16 bits (see the ITS_DEVBITS #define). So uint16_t is fine.

Again, this change is missing any context that would motivate it,
and needs to be upstreamed along with whatever the actual code
is that needs it, not as a single thing on its own.

thanks
-- PMM

