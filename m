Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33AF9C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7fJ-0004Pq-Vf; Thu, 22 May 2025 11:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI7fH-0004PG-W0
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:17:00 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uI7fC-0007b9-A4
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:16:59 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id C69F217FA02
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 17:16:47 +0200 (CEST)
Received: (qmail 12650 invoked by uid 990); 22 May 2025 15:16:47 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Thu, 22 May 2025 17:16:47 +0200
MIME-Version: 1.0
Date: Thu, 22 May 2025 15:16:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <9ce65301b9ca7a16b6b065ded113b9fa098dd786@nut.email>
TLS-Required: No
Subject: Re: [PATCH v3 2/8] Add register write API
To: "Rowan Hart" <rowanbhart@gmail.com>
Cc: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Alexandre Iooss"
 <erdnaxe@crans.org>, "Richard Henderson" <richard.henderson@linaro.org>,
 "=?utf-8?B?QWxleCBCZW5uw6ll?=" <alex.bennee@linaro.org>, "Eduardo
 Habkost" <eduardo@habkost.net>,
 "=?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=" <philmd@linaro.org>,
 "Mahmoud Mandour" <ma.mandourr@gmail.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, qemu-devel@nongnu.org
In-Reply-To: <CAE5MsNZhr8eNvsDHqVSAWkn4=Yw8ZFU713NNBy0ax0cSxtp1yQ@mail.gmail.com>
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-3-rowanbhart@gmail.com>
 <20250522115935.34716-2-neither@nut.email>
 <CAE5MsNZhr8eNvsDHqVSAWkn4=Yw8ZFU713NNBy0ax0cSxtp1yQ@mail.gmail.com>
X-Rspamd-Bar: /
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) BAYES_HAM(-0.491266) MIME_GOOD(-0.1)
X-Rspamd-Score: 0.908733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=EQk4bDtTYATlPrAdVaEfvTVkEkqzllRv6oojSSKNc5w=;
 b=HYkYuAAONt6uBWGbfqCv/iEwB3d8h+ytnpGDPkZu85z32mZxIPYdxitiqFAEoXzG/WLOIKu1Uz
 BcZ3G++5DPwMD6js/urXYx8Dxxx3n2GIC0YcQuoE9R+yIwAKEURu24PfzG4xW+OJ8TCecURp/dpP
 25mItNOJz4ptMtDMqHKz3OCfU60oHsL2iDX/HsKsUT91iuIirgbCtVDECQZS4aLqFK6JyIFTG1EH
 K1thEHkapNtU5bNLrys6qiTofLKyWqpnu4rlTegakaH6VMt3UrWpLSWkHp1feiiJ0IvrnMkru2c3
 9yQ/UamQZcu1fahsCUAgCuv69YqC9TSTkGcYWSn4tWdst9xeaV60XsORgSs1JXYNi2kRBYw8JMYI
 H6V2YLNGH5gR2Wl/x4j+3upbDP+vcmyh66zSPN8raiiAivPbXwfgWaIx7tB739VaapDZG7IRhbVV
 /RDMtx3nCGkGicx7pU2dWTK+x4QP8hdY1WYRNf4ZoP1Rtq5iwdiOsdREryd85xxcbG4Nn2SUJyzH
 uTFaVLcLw/C1azqRdPwUc6wCpAN0Wl0+pEo5fpWElMwGOFa1Znuwr5OL8K11bx+jJkIMQKOLoEMX
 TUM4Nrv+LK3fgCJxB/MwTwbf0DUtnYexpKaatNYmiW/bxM2HXhZOTNdncKeMd5qZ40Hp/MQquqz7
 g=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi Rowan,

May 22, 2025 at 5:02 PM, Rowan Hart wrote:
> > Again, what was the reason for moving `qemu_plugin_read_register`?
>=20
>=20I moved it so it's grouped with get_registers above instead of being =
separated below the memory functions. I can move it back, just seemed nic=
er that way.

The move itself is totally acceptable. However, the commit message
should, in my opinion, state why you did so.

Regards,
Julian

