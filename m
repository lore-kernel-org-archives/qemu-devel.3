Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68347C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 15:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Msf-0006xc-Ss; Tue, 07 May 2024 11:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4Msb-0006wD-KB
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:37:22 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1s4Msa-0006o3-08
 for qemu-devel@nongnu.org; Tue, 07 May 2024 11:37:21 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51fdc9af005so5052212e87.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1715096237; x=1715701037; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgoV9bukd4nP3pnHx4FhFgdLsPpBNatHdDaYCvChi+k=;
 b=CgEYZc4CPuBlbwcWEtEX6/u9cjYrHYMdNslR9piWphdGBMQ6laAG++Wja1xpy+7lLv
 QaC1r/nJGh2EoQDE1BRfNz3y+WnCVIBeyLeERNGZEAt8q1W6GeT7yZ6F3QO0SJHICItL
 NS2Fg5ttj18xZ70BH6aL8TbC/4E1jWnjnIbBaYo2bsaOFaMs6zun54+pdCdUWqpxTUlv
 xdkaEmtRtfJLKbyo9TJGE7fJFMF8+ix8yl0eFEiaUgaH5w3pdaWTZjgF47h6R3qyldrO
 QGeAHBVDN6ekd1YCeIJWKqEYC1fKRJAhZkhvgDU+qlW+S9cJS85O4VYQJezc5zF94tAX
 FxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715096237; x=1715701037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgoV9bukd4nP3pnHx4FhFgdLsPpBNatHdDaYCvChi+k=;
 b=XtKB1D0//OUnykvAZ+kEKf1We+wJGHkAyRK3bvB5fKscNdusQDdmQ3r+t0DriPQjEH
 EI5yaDgbW/kkDc2Ti/VuJb0GzYZJbn7xkfDcT/mAVTVKkgIKwEyk63WgUCIjzA8OPcH4
 6JXtXMXrTExA5EmrP8nA5BbMuA8zbnNgDQFlL1YzldiyZyOkip+jz2kxee8NduDyOJ7x
 uT2cDRBk7FUVi7wV1zLMJq/Vl0VYo3Vq/wEVWtKm4i1brKYTwy+rCixbu72G92rQIBdv
 ZFp9i4twOzROMrc8PDnS0BogJWntJJ/6D/fAReua0ZwceG9f8Fh9e6NBUPwQ5l5BZ6WX
 HZDg==
X-Gm-Message-State: AOJu0Yy/pwMSc3Y2PfM9Xr2wVY+dQOn7tCVkSZgMrtJ3wy1VBPCHIA4E
 a12/o1gtW4wlrlyA383HWd39LWMhiKa6d9cjdc9Od7zdu+3t3lUkE/fgF+vSaFpDrBywFwxVCp4
 QWLXNKFDoUCXH2+fnhiuEewQ9OqMrAxxEHSQuIyUPavrMjnRkBJp7n179ffWX77sb5oI1r1yj3R
 yw1LukYL+VYsS28cpfkUaOWQLwmY+KctUv8gkQFXR2Og==
X-Google-Smtp-Source: AGHT+IERvtTMEbjZK7crezzpPTBVtLGwgeqShDTHdGYjc904gdVj5ct9SO9J6ED+/U1MGCsrAKMj+w==
X-Received: by 2002:ac2:532a:0:b0:51f:3e0c:ace3 with SMTP id
 f10-20020ac2532a000000b0051f3e0cace3mr9674155lfh.16.1715096236789; 
 Tue, 07 May 2024 08:37:16 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com.
 [209.85.208.169]) by smtp.gmail.com with ESMTPSA id
 e12-20020a05651236cc00b0051b88cfa076sm2124871lfs.237.2024.05.07.08.37.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 08:37:16 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-2e428242a38so9055801fa.2; 
 Tue, 07 May 2024 08:37:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUeQqYuLTlfFIInskoBrAaN7G2sYyM6picH8qmohj/CjHb+9xFwGJ0WghUuMUFzg2QfYXfCnQ81bB8TfFUqP2fpXtSxVUY=
X-Received: by 2002:a2e:a365:0:b0:2de:ca7f:c849 with SMTP id
 i5-20020a2ea365000000b002deca7fc849mr10900872ljn.43.1715096236217; Tue, 07
 May 2024 08:37:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240503124244.8804-1-dbarboza@ventanamicro.com>
In-Reply-To: <20240503124244.8804-1-dbarboza@ventanamicro.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Tue, 7 May 2024 23:37:05 +0800
X-Gmail-Original-Message-ID: <CANzO1D0g=AoPkyFS_5d5mJwmwDX8hpaj0fjeFy9xt4xi70fh1A@mail.gmail.com>
Message-ID: <CANzO1D0g=AoPkyFS_5d5mJwmwDX8hpaj0fjeFy9xt4xi70fh1A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] pci: allocate a PCI ID for RISC-V IOMMU
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=frank.chang@sifive.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Daniel,

Daniel Henrique Barboza <dbarboza@ventanamicro.com> =E6=96=BC 2024=E5=B9=B4=
5=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:43=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> Hi,
>
> In this RFC I want to check with Gerd and others if it's ok to add a PCI
> id for the RISC-V IOMMU device. It's currently under review in [1]. The

Is the link [1] missing?

Regards,
Frank Chang

> idea is to fold this patch into the RISC-V IOMMU series if we're all ok
> with this change.
>
> Gerd, we picked the ID right after the PCI UFS device. Let me know if
> you want another ID instead.
>
>
> Daniel Henrique Barboza (1):
>   pci-ids.rst: add Red Hat pci-id for generic IOMMU device
>
>  docs/specs/pci-ids.rst | 2 ++
>  include/hw/pci/pci.h   | 1 +
>  2 files changed, 3 insertions(+)
>
> --
> 2.44.0
>
>

