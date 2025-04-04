Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8741DC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 06:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0aDU-0002Jj-R9; Fri, 04 Apr 2025 02:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0aDS-0002JO-ID; Fri, 04 Apr 2025 02:07:46 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0aDQ-0007mR-Oz; Fri, 04 Apr 2025 02:07:46 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5240a432462so1430179e0c.1; 
 Thu, 03 Apr 2025 23:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743746863; x=1744351663; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YX/GARSxYEaPutQVRIkz3Dx5k2kSILORr10A3AuxgCc=;
 b=HVD4ts7HgIQOVYIseU+uP/romOr/ZRCm+FftL7JvauBBqPk4C2N80XNjgDqxnR8eXe
 YCvLrAfwIWJurZyDjJM60PNP/j/kTflkg0ViSKGYyNc4lCwib/5pB6xqot0pxrzrrScs
 YWAoKGh+CudX0c8S703yhbURkohXQLA/gMP6zyhV4DppvrQsccU9BkaJvFr/mXwfrHx8
 Fjt7QIWesM4SLxEuZNF3f9Kfy853U+24qkbUFlaBmYqWAPqk1WTwHMDnHb7I78NkNKx1
 6pC+yir2RhQC1P4Y0pTxm3XQEWzm25VPp+QY8/AvAjZJEm6vpQbUfhc6DVwigGFS4IzR
 CKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743746863; x=1744351663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YX/GARSxYEaPutQVRIkz3Dx5k2kSILORr10A3AuxgCc=;
 b=L5k+245jwv3w4OwSToTXuvoqGKTNUwIFGjWL7WtCpUTlzIkvkWKydqRUDXxfzDwCyR
 j2QJ4qfmKXCIbxXONof9A0K3878rdYSLgOckkLgbim065UHKGy3eF86sKzG5WTlTaXfv
 znvTvsJxx/81X0viN/O4YIGEPmL1J1hpdOpaLsgds+yNdn71O2x7juJQBvmPVE2BdxLz
 14sBkcEOysZ3qM58+PD5EYAJktobRBERpjgKLSAvv+JYPNfTZTvuQCh4gdjwMFit7r65
 DPYUlZT9m5GCAokxBragTx0yJGhhni3Gq6k7xpBxgTQNtGgZbwbGMIZswqm9me8eqR8H
 7S9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOBd6ywUSkXPGY532MnJhQQvcLL3HID/yko56E26dsz0U3Fnku7mMC04TqZIDgegg5XIhHx9qYh+de@nongnu.org
X-Gm-Message-State: AOJu0YxNQPGqCMlHXUouZ4Vw1Z2e9i6hm12Bkms9EFeSaYRhv/Y/kHp+
 BOZIcDSikjscbqdXBj3eDW/FvpTq7s3ZfTTPVK/E6DDc2Io2wdbtt2f2z2LkSzeOMxng7lBzvX4
 OX2ySXkIje/zsKaCfEq25CdWKqBszJg==
X-Gm-Gg: ASbGncu0jHGMxWCZ2FjKLooQEdYz8CRFw0Mro9pt/WeqUwzXHyzTgGy0f1VmFSr+yLU
 KIoe6E4DlnAynfWaJ7jEKrc/Yie8pyhXW6k8JfQ0OzPQmw/cxjtB3KN/o21CZPdH1FuiYxg2Rpy
 HgCpvQOQ1Ep9Fdur6FuARTmE+nodmZX+Ez6yPYHoyf0oYQEuipEfkqwGcIwKOQYn8bVck=
X-Google-Smtp-Source: AGHT+IGLNh+4UOcsXnsqW60ym8dDfdx3uyZLKWOmSO6o4me+MppbP3y63J8L7rRZzBOI2M79uOFXg0xWqO1QLsIgyK8=
X-Received: by 2002:a05:6122:2216:b0:520:4fff:4c85 with SMTP id
 71dfb90a1353d-527647d7e00mr1581261e0c.2.1743746863103; Thu, 03 Apr 2025
 23:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250313123926.374878-1-paolo.savini@embecosm.com>
In-Reply-To: <20250313123926.374878-1-paolo.savini@embecosm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 16:07:16 +1000
X-Gm-Features: ATxdqUESCs7nRXLr2Mi9Gtdu2LPTYLeL1893s3IN3BU6iu8JbDxggxwLKd2M9zg
Message-ID: <CAKmqyKMHW9eJG9N=69knFO4B5tVA8ACj4TEJuqJZn74KcvEqKQ@mail.gmail.com>
Subject: Re: [PATCH 0/1 v2] [RISC-V/RVV] use a single function to probe memory.
To: Paolo Savini <paolo.savini@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, 
 Nathan Egge <negge@google.com>, Max Chou <max.chou@sifive.com>, 
 Jeremy Bennett <jeremy.bennett@embecosm.com>, 
 Craig Blackmore <craig.blackmore@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Mar 13, 2025 at 10:40=E2=80=AFPM Paolo Savini <paolo.savini@embecos=
m.com> wrote:
>
> Previous version:
>
> - v1: https://lore.kernel.org/all/20250221162036.61521-1-paolo.savini@emb=
ecosm.com/
>
> Add reviewer information and rebase on top of riscv-to-apply.next branch.
>
> Cc: Richard Handerson <richard.henderson@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Helene Chelin <helene.chelin@embecosm.com>
> Cc: Nathan Egge <negge@google.com>
> Cc: Max Chou <max.chou@sifive.com>
> Cc: Jeremy Bennett <jeremy.bennett@embecosm.com>
> Cc: Craig Blackmore <craig.blackmore@embecosm.com>
>
> Paolo Savini (1):
>   [RISC-V/RVV] Expand the probe_pages helper function to handle probe
>     flags.

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/vector_helper.c | 57 +++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> --
> 2.34.1
>

