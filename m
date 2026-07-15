Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52637C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 11:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjyDy-0001pN-Or; Wed, 15 Jul 2026 07:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wjyDw-0001ol-8C
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 07:56:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wjyDu-0007aM-KJ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 07:56:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cea3004256so56460025ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 04:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784116581; x=1784721381; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BfvSbRRqaZG2jTmiyYHm9QGHvFmytONzwXXR0lKzL00=;
 b=ol8+YF6ixYUTgZWZJoMm9juc6b86O7zNNLs3/thaaGH8QbGWfJLN1x/k1FVch+5h5n
 rVk+X2z/qAelbZ06eR5zFDUZKgXUUGl8clzJR+RMXlG7GQ6OsmPA8P7peI5yohDzs4yn
 oxFC3dfcpKCI7pWnV6YN4l6lLZYMFkMHWahRliFotdU0xauFvFCaYXc9Wu6Cyfs5lnF8
 MxwBK6PWELVrC12GId55lX7vRSjtSvcpqQYQStmj5XHo4tAuSM5Z1BW/0NgG/KVAmK9j
 T/5CadQwXDGyvYiRair4raXqYLiLuOcGfxeOPli3Jak9qL+z1mtsjbVBZNWqHCBthvQx
 3ALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784116581; x=1784721381;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BfvSbRRqaZG2jTmiyYHm9QGHvFmytONzwXXR0lKzL00=;
 b=JdPfAnVHbyT5K1R3ga2QDbUCRUo8F/qu3pOBZ21NBx+bq2kvVXtzaJnGdjJjTTQfKE
 /WZa8z/lGq5LADfz/Pzk5JJGIN6gpoL08ZO5DhLzwpLjHoGYRa05WgASwWjkaSIzfBPX
 bgA43qd03lNe+d+ItGkhooGpgOuGBvqf1DAIEQj6FuZn2xdNLzPqgXLz+LGikIXUZyj3
 /z8fAMpPQKxbKxhOqrXErv8vJmOLdU953qDM7yXRveLsu54TR0GIzY40N1rTqEHUGdqk
 a/swE2TDVS6pn6hZnS89NtVyOG1/2+14xCP2aWdkAPeYZB6DyQ8WQRBomfHVa83r8mYY
 5PYg==
X-Gm-Message-State: AOJu0Yz0OUcwk7+qQMWFXBCGQGhD2QO1Fb00/TyaPnJmL55Cclx4HpQp
 H1L+oxngyFWrjt/ND/myPkO1FqE0XPF87JMOGngldsZGtH74zN91WSUt+lqomnPo
X-Gm-Gg: AfdE7cmPzl7SVr5XZ+dFs6+mfgtcqn1IISiobx0/C9NKXF7WCa4YSLrtvVtbZFvxHmv
 bo/30mYjhAOtnYZnZzac1x6ip/0ari4erBO9eT55CP1k0MbP3B2wyLZpztjzmy9e9TMg2muB8hP
 hWU6+Y936KIaMOHWuDMMozlO2zRRtVvcGn2WzPbaHHBEJ7XZkCb4wBBK1UMfQIuUssmbhqpWc8v
 jJKHeNxiFhLDdUy5WjGo3n+YlR7BbymjsiEhYsefzgw2y4/nPLhjfY7rIItb/kD0Ez/lwnkz9xQ
 +Pg0gQXMKXtaZ9T36JybslGjxFa54SCUqLpOGlbSm66/FDQfTs8LiZqxuFW8qtyElKVSvnUFqSW
 DAOz+BXWgQouF3hMnci5nVxoGNgU/bYccnNXdD2JM/2+E04GkEAkLjkcxgO/eCo6I3PR+RpI8Wh
 90oqId3LmMRIl4XFfwBg==
X-Received: by 2002:a17:902:d552:b0:2c9:9a2e:dab0 with SMTP id
 d9443c01a7336-2cef12e8eb7mr66198755ad.3.1784116580587; 
 Wed, 15 Jul 2026 04:56:20 -0700 (PDT)
Received: from smtpclient.apple ([82.40.42.115])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf10120441sm1295865ad.20.2026.07.15.04.56.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Jul 2026 04:56:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [RFC PATCH 0/2] *** Add k230 reset management unit support ***
From: Jack wang <163wangjack@gmail.com>
In-Reply-To: <20260709031237.21284-1-163wangjack@gmail.com>
Date: Wed, 15 Jul 2026 19:56:03 +0800
Cc: chao.liu.zevorn@gmail.com, pierrick.bouvier@oss.qualcomm.com,
 pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, farosas@suse.de, lvivier@redhat.com,
 qemu-riscv@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <60AE661F-44A2-41A4-9E59-6F5F8DB99769@gmail.com>
References: <20260709031237.21284-1-163wangjack@gmail.com>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=163wangjack@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi all,

A polite ping for this RFC series.=20
Could anyone please take a look when you have a moment? Any feedback or =
guidance would be greatly appreciated.

Thanks,
Jack Wang

> 2026=E5=B9=B47=E6=9C=889=E6=97=A5 11:12=EF=BC=8Cjack wang =
<163wangjack@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> From: Jack Wang <163wangjack@gmail.com>
>=20
> This series adds support for reset management unit found on k230 soc =
and=20
> successfully  wires it up to k230 machine;
>=20
> The register design are implemented based on k230 trm and linux reset =
driver
> (drivers/reset/reset-k230.c)
>=20
> detailed implementations:
> 1. write-enable mask for control registers(strobe in the upper 16 =
bits)
> 2. hardware auto-clearing for reset and flush request bits
> 3. latching of Done bits and w1c logic
> 4. qtest coverage for register read/write behaviors and hardware state =
modelin
>=20
> There are some checkpatch style warnings (line length, comment
> formatting) that will be addressed in v2 based on reviewer feedback.
>=20
> this is my first time for hardware-unit modeling so apologies for =
possible mistake.
> I am apprecitated for any feedback
>=20
> Jack Wang (2):
>  hw/misc/k230_rmu: add Kendryte K230 Reset Management Unit model
>  hw/riscv/k230: wire up the RMU device
>=20
> docs/system/riscv/k230.rst  |   1 +
> hw/misc/Kconfig             |   3 +
> hw/misc/k230_rmu.c          | 280 ++++++++++++++++++++++++++++++++++++
> hw/misc/meson.build         |   1 +
> hw/misc/trace-events        |   6 +
> hw/riscv/Kconfig            |   1 +
> hw/riscv/k230.c             |  10 +-
> include/hw/misc/k230_rmu.h  |  76 ++++++++++
> include/hw/riscv/k230.h     |   2 +
> tests/qtest/k230-rmu-test.c | 125 ++++++++++++++++
> tests/qtest/meson.build     |   3 +-
> 11 files changed, 504 insertions(+), 4 deletions(-)
> create mode 100644 hw/misc/k230_rmu.c
> create mode 100644 include/hw/misc/k230_rmu.h
> create mode 100644 tests/qtest/k230-rmu-test.c
>=20
> --=20
> 2.53.0
>=20


