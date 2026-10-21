Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C720606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZgS/rEG5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJb3y-0007Iz-7R; Wed, 21 Oct 2026 14:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xJb3v-0007Im-HU
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:29:19 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1xJb3t-0001CK-RP
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:29:19 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c34bff61551so127411166b.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792607356; x=1793212156; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ve85i651QXKHC6AkMlHuthRxoWftiPVQU0f3BH5zx3A=;
 b=ZgS/rEG5AyrCDzCgsWWk1ji8XY8Opta1TlNxLYyoTw2gjpCP3ze5nzUw/v8Cudud1p
 7cg1nvLX7x3i51W6NNHu5pmMGC3r4vm4BIs4iN2u5aeeYLwPKrivaHgdK4UhCeIgo7NO
 GpSXKRvc02FCGI9KrlH1LvF5OnE7lAXl+4uud78kbMRQIpEhYwV043hwdbrsGMqSunZu
 VyFzbPaQlWnpAs3/5jZbsnZUn5igA6ipxubdUB++J1bpWMx6nZ7nztGeK0Ogy47OLUV4
 WU9ezkwPK1W71L27KGEJn+eD1uyDYGpymIbcd0s5SPdPp3ToeV+9M3GJs1Jmu4//yvdT
 k67g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792607356; x=1793212156;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ve85i651QXKHC6AkMlHuthRxoWftiPVQU0f3BH5zx3A=;
 b=GCvGilrJmVz86eyMZGJi/PhRIeORa/9uzqP7yWBqdr+fHKGr/TDacG9LjXUwYI6I0Z
 /J6+UmEXLVzuc9a52fhMTNE0bAnZtwWuCtTpafF1YuPlbAqMqB5z4UnSpESjf2PegZJc
 YJlUd7dESQ54DTQOxflBqS2wPIusKjPgvKojqeO5ZKcuyb6SM8j3YRReGrZK0KAQ0sLD
 c9wF5X0vzNQiHLvvnDKGTvb+Kw/CLyd7Gdffr5ZQ5ktmphhkwKDeboexjczQqwOIzoxw
 7OA3xC/dxZ+0LWpXAV37TGXnQj7Oyq7KlMNcwLcX1w870qX0pQiQocTOOsetQtbNZiqK
 I/Gw==
X-Gm-Message-State: AFq9FYJHnWyti6w+1XV2rXSpvLtm/32K3tt0vjTjXPFQWnQmidGyNzMI
 V4wli5sThEj063W3o/AsCCk/JSs+Dnb31gYZM8L8y0i1swUiDDTxt+2Q
X-Gm-Gg: AYBFou1u0SvaS1i+/ifEZSEpOgEX5RvmJF291egCQTchXNekQ/vz39qrGuR0IaaGdiP
 IamQPwdD+CikGzPaabEYI3Kbv9ha9x914gU4widwq2/dRtJQxoKgXckSQPT8ys6odD8Ry7rA5Pq
 HQEABnWAfJBPYYDRCYohME2jRAEANazZNIcl5AvYY447VhanWwRWIZX+UIVaO08Q+1n390iK3sJ
 bvvcJOJWTjbz6/incz2U/K4Xbr8nVf/hT/1Su4DATVpLwj015RWRgdJmsm++T4daViNu3DLOAqv
 wWmunhJPnXh571uHLwBTPfAYEPi2lCP2FUvM4ZPdRtEyuMq3Vat2ZcwpFDMCTT2Z8xafQw8HL6/
 KeGrPnPgXwu2lFi4+g6ZiTmNtc9ns1NbmrQfmOPVMzoU2BV+Y7jE+rT2PaZmFvUeLGZ4f6Ubz3y
 O8enGfR8ovD9R7A2RSq2J1VOx2kyx1wvmnFjRgvFdU2G08H/febpRYWTo/J9oWws/9B3nhEzgwH
 fyzJcFQDdTmbI41GTpBebSHgUrRW9IcsKMkujuPTvhL97GyK8rCI/GxttIIfxCRJkDh/b7LRxjh
 /kdmc10kdn2uklo22aUwoNr4P6vIy0OzgxdSmuNgqjUF8gzjzpvjflUskc82XM0=
X-Received: by 2002:a17:907:9726:b0:c2a:c76c:c743 with SMTP id
 a640c23a62f3a-c467979f74emr228096166b.35.1792607355399; 
 Wed, 21 Oct 2026 11:29:15 -0700 (PDT)
Received: from smtpclient.apple (088156177242.warszawa.vectranet.pl.
 [88.156.177.242]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c468a50aa01sm27992666b.22.2026.10.21.11.29.14
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 21 Oct 2026 11:29:14 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.10\))
Subject: Re: [PATCH v2] target/sparc: implement TTE page-size for 32M/256M
 pages
From: Dmitry Pimenov <sun4qemu@gmail.com>
In-Reply-To: <ebea4a0e-3a70-4f6a-bd4e-0ab80f810e31@ilande.co.uk>
Date: Wed, 21 Oct 2026 20:29:03 +0200
Cc: qemu-devel@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <861B50FD-7E72-4B81-BDC2-6AEA3D4FD12B@gmail.com>
References: <20260918105705.433093-1-sun4qemu@gmail.com>
 <ebea4a0e-3a70-4f6a-bd4e-0ab80f810e31@ilande.co.uk>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
X-Mailer: Apple Mail (2.3826.700.81.1.10)
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=sun4qemu@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>=20
> Hi,
>=20
> I've run this over a few sun4u test images and it doesn't seem to =
introduce any regressions. I just need to make sure there is no conflict =
with our AI policy here, otherwise I'll queue it.
>=20
>=20
> ATB,
>=20
> Mark.
>=20

Hi Mark,=D0=B5hanks for the info, and for testing!
I understand your concern about the AI policy, and I'm fine with =
whatever you decide.

I don't see how to exercise the 32M/256M pagesize code on sun4u qemu =
guests either.=20

Only USIV+ (Panther) and later CPUs support these sizes (as mentioned =
before), and even there OpenSolaris and their derivatives
disables 256M and keeps 32M on sun4u path; on US III both are disabled.
=
https://github.com/illumos/illumos-gate/blob/master/usr/src/uts/sun4u/cpu/=
us3_common_mmu.c


 So I don't know of any sun4u guest that could hit this path under QEMU.

T1/sun4v, by contrast, uses 256M pages.


Rgds,
Dmitry


