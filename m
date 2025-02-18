Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115DFC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 00:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkBQZ-0004zS-AO; Mon, 17 Feb 2025 19:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkBQX-0004z5-Cf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 19:25:29 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkBQV-000120-F0
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 19:25:28 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-8692998b124so624348241.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 16:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739838326; x=1740443126; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Im61S4+Gc/Ol5Y+wW523xtSwxxa6TZMe51C4ePK5v1g=;
 b=LqltorJU9guViUiehiQ+r45D1r372B0b+1nVZMHITphNuJ/dANhxa36y2Ds826OVbr
 VL9j7Pl6i2gDLEmEh67pAoeulerXSiDouTtI/zd52FuYABvGFJNQXycebwIFzVcRtMYx
 bvCQDaxJayxDFdjGFWfXRV/GQjf85lwShv46lkOptDnYWsxeap/Lu8j4KK1vo1H8Quyk
 RUw0xEhWi5Qcc4NxYp+nsKxndChgc86YUqxiP2m++3NHVJOgF8Y4llagnzPXz2qmsS4e
 /e6CiTPpTRqJoDJJrxMLJ6sXzQkZKjpy4XNCTfbMG2r+G1leJTeYJiikdTBO2gLo31hF
 vlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739838326; x=1740443126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Im61S4+Gc/Ol5Y+wW523xtSwxxa6TZMe51C4ePK5v1g=;
 b=LAPjAPrMX095zvvZ/6bTU3SgzyMmMHHNhnkNDkmzcC/y5WTUpZfM7YJDEkZZIFdtLW
 K6vx9bR2WBvty5eMOoOc03RqSqVoXifBTMxEyLaxazvX6tIcsIC+do5qzBp6mLjhjQCp
 gqwOXaHynhYnN4Cfq1rNbA1NGRP6wQL8l/VutBy4qbvFIAwli0HYAcOwuqoea7t7AGQG
 amb++duvlRLuBVtAzOeWIwF/7EIw8bvef0k00DeD/g1axoK1I5aGFg19vxyY163AQxcY
 I2eUNFX91o0rp6EtQMxbPhIoLj8zyzNeFhNZCZuJnjwU0kt/g4YeByIZbtBltPhgfiRK
 hZew==
X-Gm-Message-State: AOJu0Yz1fB2FaK03eClACugYZ9gHECHalgsndu8o56WUYB0l0G3+VZtk
 78KmE5omLcZXvPjO0PR8+Uibfpft4kqFd888xpAm7ArnrnRpRqNdM1aOIZ2UmLjWJGUYEl8opOf
 uMV7Jje2mfjWnJMBQtJ6Dzs4UTvQ=
X-Gm-Gg: ASbGncv3Xhw28PVx2nXi8c2HBQF+FPAN7ccYiXAHFddSAhugZAebpC/9IpM/JvFC4T1
 Gogu/eXZvV+nzQ4ENgJ9geUuHKPnsk0c1VqLlW9iAKHy5CDyStZ73I1FwQil3jtuAG61Ciuz8WI
 mCC02gAhE0CnfL6chPCHrysFW1+A==
X-Google-Smtp-Source: AGHT+IGKWo/lRVn+16m6/Obpb73M5MtMD8iG5z4XxibaPzSakKGB4nf1B9AK/jYtJIzzkwdtLLVc8iH+StWK/hg7Ioc=
X-Received: by 2002:a05:6102:150f:b0:4bb:c8e5:aa6d with SMTP id
 ada2fe7eead31-4bd3fe46605mr7160726137.17.1739838326073; Mon, 17 Feb 2025
 16:25:26 -0800 (PST)
MIME-Version: 1.0
References: <20250206182711.2420505-1-pbonzini@redhat.com>
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2025 10:25:00 +1000
X-Gm-Features: AWEUYZl14wwVNvax7Yrivde2UmMeI4HhYnxJem_M6Y6yWfTPm9xfc88fbWjxhek
Message-ID: <CAKmqyKNhc3WAkSee0TOsziKO8HJReg0qrxD04WXp3j90O=O9cQ@mail.gmail.com>
Subject: Re: [PATCH 00/22] target/riscv: declarative CPU definitions
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Fri, Feb 7, 2025 at 4:28=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Hi Alastair,
>
> the subject is a slightly underhanded description, in that what I really
> wanted to achieve was removing RISC-V's use of .instance_post_init; that'=
s
> because RISC-V operate with an opposite conception of .instance_post_init
> compared to everyone else: RISC-V wants to register properties there,
> whereas x86 and hw/pci-bridge/pcie_root_port.c want to set them.
> While it's possible to move RISC-V's code to instance_init, the others
> have to run after global properties have been set by device_post_init().
>
> However, I think the result is an improvement anyway, in that it makes
> CPU definitions entirely declarative.  Previously, multiple instance_init
> functions each override the properties that were set by the superclass,
> and the code used a mix of subclassing and direct invocation of other
> functions.  Now, instead, after .class_init all the settings for each
> model are available in a RISCVCPUDef struct, and the result is copied
> into the RISCVCPU at .instance_init time.  This is done with a single
> function that starts from the parent's RISCVCPUDef and applies the delta
> stored in the CPU's class_data.

That is nice!

I don't love the ifdef-ery around `#include "cpu_cfg_fields.h.inc"`
but overall the patches look fine.

>
> Apart from the small reduction in line count, one advantage is that
> more validation of the models can be done unconditionally at startup,
> instead of happening dynamically if a CPU model is chosen.
>
> Tested by running query-cpu-model-expansion on all concrete models,
> before and after applying the patches, with no change except the bugfix
> noted in patch 10.  The 64-bit variant of the script is as follows:
>
>   for i in \
>     "max" "max32" "rv32" "rv64" "x-rv128" "rv32i" "rv32e" "rv64i" "rv64e"=
 \
>     "rva22u64" "rva22s64" "lowrisc-ibex" "shakti-c" "sifive-e31" "sifive-=
e34" \
>     "sifive-e51" "sifive-u34" "sifive-u54" "thead-c906" "veyron-v1" \
>     "tt-ascalon" "xiangshan-nanhu"
>   do
>   echo $i
>   echo "
>   {'execute': 'qmp_capabilities'}
>   {'execute': 'query-cpu-model-expansion', 'arguments':{'type': 'full', '=
model': {'name': '$i'}}}
>   {'execute': 'quit'}
>   " | ./qemu-system-riscv64 -qmp stdio -display none -M none | jq .return=
.model > list-new/$i
>   echo "
>   {'execute': 'qmp_capabilities'}
>   {'execute': 'query-cpu-model-expansion', 'arguments':{'type': 'full', '=
model': {'name': '$i'}}}
>   {'execute': 'quit'}
>   " | ../../qemu-rust/+build/qemu-system-riscv64 -qmp stdio -display none=
 -M none | jq .return.model > list-old/$i
>   done
>
> Do you think this is a good approach?

Seems fine to me :)

Alistair

