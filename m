Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD20CD37B1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 00:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sldZK-0002kp-2j; Tue, 03 Sep 2024 20:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldZD-0002j1-EM; Tue, 03 Sep 2024 20:08:13 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sldZB-00046g-LE; Tue, 03 Sep 2024 20:08:11 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-4fea2546b31so1566474e0c.2; 
 Tue, 03 Sep 2024 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725408488; x=1726013288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UykzW5LB6MK2DG9TgizLyqE31PfQgHQmGvp3SfPlYRk=;
 b=kJcb9zTvW5xOEuKCCRvYRVN7N7H1mx5XnPGGs9rZbN2vcUICFwqt1G43eAX+04fF+U
 udpZ3M2OkPTAxipcrgtRSpxI0xyX7Ke1K+SaA/+F1GVWdHH0t8dm8Hfnl+xHJlq+NsIA
 H0UqFPeSOw3lG6syGkbbOyuqFrW+oUXRZ709YqI15HXo79VVz4VGLxFtIXGQ0ApvEymw
 3GLjDepA5ksGw4Td/+IJO22qS0PwbdXWeiVFHHahlUNUNObBUWOBiE4p7/gYVPLtiN6Y
 ajGyb5U5PM1G/Ub7/BdiskhH2zS72htzlFU2DvTmUHEKCdd8U65Ty7MK00O2X2ipS1Wu
 Yazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725408488; x=1726013288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UykzW5LB6MK2DG9TgizLyqE31PfQgHQmGvp3SfPlYRk=;
 b=o1V7b+GhovGheFRd4dWb6ONvF6mokxNPl0+ieQMn8iWvJ8ZAZiNX0JhsdMqm9OZTKs
 iG4aH1ZnDbGisxWmk1aBVVxjkTLoqeTJuO7TZWS4p2xsxAqVigDP+Hy3P2HHjlP7FsP0
 JWegnmpCh0eDGeHldcwFrVbakAJrvqPSCbJpCr5YJifgO1Qigo0tGIENqu/iFoJq6chC
 MQSO4r61GC8miSvKKnobdgUbvZYrL0w64CKSXizH/M+dJvVco8s5Fvl7ZvErApHdDRng
 Hv8v27d6Rm/yegP2XVkcx7J+u8sgQDhGsSVAxhApSYEAR82QwzXKArRpErbG9m29HRw5
 6m7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuHuq8APxh2ou6BD+3Yn5LWEPP+Le1FZR5Uwnmq77VXPKAJlp2Tnaa9FR6Duf6/ufK45o4WErWE60z@nongnu.org
X-Gm-Message-State: AOJu0Yz/XB+JFAFbiV9NIRxgLy2CIoDk3rMGpwYmTbA0weO/ERY9A5KT
 i6ufwkl2UkBhtq2DD6ebgWr0AqYrL2EgpeDB8h7upuj5vrQRW8ibzfKMwQ9x+nAVyGwroN6qzhY
 wewLA+MZ72yMl1b28VpNapkADBQiiUw==
X-Google-Smtp-Source: AGHT+IErWQnBMPu1euT5UGIgnuTiJemWu9QImUrOEFTY1rkXX2mmoStnezEnM0X8/PG6ZDAICI9aRQ+Klg4LpMw5m28=
X-Received: by 2002:a05:6122:221b:b0:4f6:ca2:ad0 with SMTP id
 71dfb90a1353d-4ffe4a5c7dcmr16324699e0c.1.1725408487902; Tue, 03 Sep 2024
 17:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240903061757.1114957-1-fea.wang@sifive.com>
In-Reply-To: <20240903061757.1114957-1-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Sep 2024 10:07:42 +1000
Message-ID: <CAKmqyKPu9vCDpUrszmbyqojzJ_Y8DOXGnHm2brL38FPeKpcj7g@mail.gmail.com>
Subject: Re: [PATCH 0/5] Introduce svukte ISA extension
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, Sep 3, 2024 at 4:16=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrote=
:
>
> Refer to the draft of svukte extension from:
> https://github.com/riscv/riscv-isa-manual/pull/1564
>
> Svukte provides a means to make user-mode accesses to supervisor memory
> raise page faults in constant time, mitigating attacks that attempt to
> discover the supervisor software's address-space layout.

Overall looks fine, let's just wait for the spec to be a little more finali=
sed

Alistair

>
> base-commit: 8d0a03f689bff16c93df311fdd724c2736d28556
>
> * Add svukte extension
>
> Fea.Wang (5):
>   target/riscv: Add svukte extension capability variable
>   target/riscv: Support senvcfg[UKTE] bit when svukte extension is
>     enabled
>   target/riscv: Support hstatus[HUKTE] bit when svukte extension is
>     enabled
>   target/riscv: Check memory access to meet svuket rule
>   target/riscv: Expose svukte ISA extension
>
>  target/riscv/cpu.c        |  2 ++
>  target/riscv/cpu_bits.h   |  2 ++
>  target/riscv/cpu_cfg.h    |  1 +
>  target/riscv/cpu_helper.c | 55 +++++++++++++++++++++++++++++++++++++++
>  target/riscv/csr.c        |  7 +++++
>  5 files changed, 67 insertions(+)
>
> --
> 2.34.1
>
>

