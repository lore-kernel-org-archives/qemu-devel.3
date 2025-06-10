Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFA6C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 06:55:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOssP-0007rn-JO; Tue, 10 Jun 2025 02:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uOssG-0007rF-GR
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:54:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uOssC-0004Xv-9L
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 02:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749538454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jTLjeh0ZFAKBjgmIFXj1HF0w+IgIOxtUcHM7LCQkMSI=;
 b=IVgAEOJ+U1MRPmRh6r0iELmxVZR5l5Xwli6qgk2tq0B2bxm9nM5jEYVziL/mt+J7QtJ6os
 RtiaCJknzxsB+VRzVHlv5my3hJKSB/dr7QkCulWVT4UvhDqGRnqV1sMM3qWt07V3/bcG2p
 Moj47BB5F3vOCRfQOeaRisfzrnc8hV4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-jpdX6sdfNJWX2CUBpkc9QA-1; Tue, 10 Jun 2025 02:54:12 -0400
X-MC-Unique: jpdX6sdfNJWX2CUBpkc9QA-1
X-Mimecast-MFC-AGG-ID: jpdX6sdfNJWX2CUBpkc9QA_1749538451
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2362e130be8so14822265ad.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 23:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749538451; x=1750143251;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTLjeh0ZFAKBjgmIFXj1HF0w+IgIOxtUcHM7LCQkMSI=;
 b=sT5NG0McNjUZXArw3baAnpXN0Hy5T/F+9ORqnY2BEDmDhTK/h2DE4aLoRo6T5Hd+qp
 CDMnxZkNxenqEfYutKsaeqtF8Jra0v7/yYd/Pu+cizTEVupZP/bwWlRRqqzEpYyGcRKd
 /ozZTo1e0OeWhyYIUREWBYL4fptbfkAJGEoagMzDbL7YEWNxkj35sLaByVgMd2lKGd6m
 pXrV4KMO8D0Pgn49fR/uA5TQn3D1zKhjy3o2YkN211hTf5y3Mnrm1ZrDofhZOoEj0T+6
 mcJg48ZcZ+t5BttaG4X6eDJdMqd2bpFk3kmhLWcF1V9lxzdXdVJm/j9quWOjwkmz5c0a
 pabg==
X-Gm-Message-State: AOJu0YzoTm5X8kfFlUDvOwWY+wfVBlPfXP1WGRcejonAOq05d5L11zFa
 ZZQ5lPKvRq4T/8ZrvpNGYJBGy8go294P2YLC/+Ff8zlgNI0d8h6Vem3l5tiZsci1aKP3Z+FufLR
 rCe9wX8xOQjkKtn4EpijjO4VBsVPpB1B68jbg0pyQBCbhuv3tw/dPiEiK
X-Gm-Gg: ASbGnctCy9NcSQYjAufr7ze2YZHadiBiRSq93dy4in0A5ZCDOiflfEg4NK8PrqENd0E
 7pwSUh9FA6Jl0jWNwq7P+Ce1drWfZSmBJug0+d2wDPKrA9C6nHY6ogTpGTAT7SY/MnJqwoDrNcA
 gU3T58P9hWs/k+qK3kdA7B+DbZDs8TKaWMvN6KaShwHdKz28wmYfkHd02BaHD1MsoJhg1+sfUxo
 qeWrNQatVS05t0ffxM/MHFe4EceVegAUWhsFJymUO+XVhu//4WwqOm+0HWqPFSOYuIhgq8qpfpB
 J1eSvihmmHjOd0oIJbSieNB754Uv2O4QmTi2SXA=
X-Received: by 2002:a17:902:f693:b0:235:f45f:ed2b with SMTP id
 d9443c01a7336-23601d0417amr236007805ad.1.1749538451275; 
 Mon, 09 Jun 2025 23:54:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrMdM30XleML0XId1VRSYrxBp3VIUkr1sogK7LqsPSwECxN/fqvg3aj/Nw7zyzSwHU7i65mg==
X-Received: by 2002:a17:902:f693:b0:235:f45f:ed2b with SMTP id
 d9443c01a7336-23601d0417amr236007615ad.1.1749538450884; 
 Mon, 09 Jun 2025 23:54:10 -0700 (PDT)
Received: from smtpclient.apple ([171.78.154.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603406916sm64399075ad.169.2025.06.09.23.54.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Jun 2025 23:54:10 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH] MAINTAINERS: Update the paths to the testing
 documentation files
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20250610053734.10417-1-thuth@redhat.com>
Date: Tue, 10 Jun 2025 12:23:56 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>, Fabiano Rosas <farosas@suse.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <58CEF573-E771-44F4-A09C-36D792057953@redhat.com>
References: <20250610053734.10417-1-thuth@redhat.com>
To: Thomas Huth <thuth@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 10 Jun 2025, at 11:07=E2=80=AFAM, Thomas Huth <thuth@redhat.com> =
wrote:
>=20
> From: Thomas Huth <thuth@redhat.com>
>=20
> When the testing docs were moved to a separate subfolder, the entries
> in the MAINTAINERS file were missed. Update them now.
>=20
> Fixes: ff41da50308 ("docs/devel: Split testing docs from the build =
docs and move to separate folder")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> MAINTAINERS | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa6763077ea..eb2b338fb11 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2124,7 +2124,7 @@ M: Michael S. Tsirkin <mst@redhat.com>
> S: Supported
> F: tests/functional/acpi-bits/*
> F: tests/functional/test_acpi_bits.py
> -F: docs/devel/acpi-bits.rst
> +F: docs/devel/testing/acpi-bits.rst
>=20
> ACPI/HEST/GHES
> R: Dongjiu Geng <gengdongjiu1@gmail.com>
> @@ -3440,8 +3440,8 @@ F: system/qtest.c
> F: include/system/qtest.h
> F: accel/qtest/
> F: tests/qtest/
> -F: docs/devel/qgraph.rst
> -F: docs/devel/qtest.rst
> +F: docs/devel/testing/qgraph.rst
> +F: docs/devel/testing/qtest.rst
> X: tests/qtest/bios-tables-test*
> X: tests/qtest/migration-*
>=20
> @@ -3459,7 +3459,7 @@ F: tests/qtest/fuzz-*test.c
> F: tests/docker/test-fuzz
> F: scripts/oss-fuzz/
> F: hw/mem/sparse-mem.c
> -F: docs/devel/fuzzing.rst
> +F: docs/devel/testing/fuzzing.rst
>=20
> Register API
> M: Alistair Francis <alistair@alistair23.me>
> @@ -4078,7 +4078,7 @@ M: Stefan Hajnoczi <stefanha@redhat.com>
> L: qemu-block@nongnu.org
> S: Supported
> F: block/blkverify.c
> -F: docs/devel/blkverify.rst
> +F: docs/devel/testing/blkverify.rst
>=20
> bochs
> M: Stefan Hajnoczi <stefanha@redhat.com>
> @@ -4156,7 +4156,7 @@ M: Hanna Reitz <hreitz@redhat.com>
> L: qemu-block@nongnu.org
> S: Supported
> F: block/blkdebug.c
> -F: docs/devel/blkdebug.rst
> +F: docs/devel/testing/blkdebug.rst
>=20
> vpc
> M: Kevin Wolf <kwolf@redhat.com>
> @@ -4276,7 +4276,8 @@ F: tests/vm/
> F: tests/lcitool/
> F: tests/functional/test_*_tuxrun.py
> F: scripts/archive-source.sh
> -F: docs/devel/testing.rst
> +F: docs/devel/testing/ci*
> +F: docs/devel/testing/main.rst
> W: https://gitlab.com/qemu-project/qemu/pipelines
> W: https://travis-ci.org/qemu/qemu
>=20
> --=20
> 2.49.0
>=20


