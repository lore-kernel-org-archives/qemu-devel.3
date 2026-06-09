Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF45CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:43:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxfb-0008AG-8w; Tue, 09 Jun 2026 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wWxfa-00089u-3H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:43:10 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>) id 1wWxfY-0006kU-Kk
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:43:09 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F27AE4037A;
 Tue,  9 Jun 2026 14:43:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1911F00893;
 Tue,  9 Jun 2026 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781016186;
 bh=X6DlgiFeqiDltReqZUR2C0NXuX8KbDCrPp4/HO9+CYU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=VaiqJ7VONUNBMZi7DavMaeacd3XbOBItSgd1MPcBG2t8HmvFjCVAjyUro4EejVDd+
 Gj1qbmBphQfsLY7mIoyvdgcbJ+iQbMsa6NY/rrpB866F6BDz25PsIFjkx6MrNujhj0
 vMZsmX8q+7qBCBVm3ry7tua1YFlSZ+WK9JPvbxSv4dzicNJemxDqmb920mzA8mwSKz
 ti073pFXho66B0g/cBO/owzmfXQbS7BQnvz7BzNJZebHjm/a9x4Bqfs/pAe/wpBGPg
 Wf8iFrM24skDPdMvR5Roh0lgdDgUok2Oh5fZ19rwM+RqoaHbeaA/N4bPR5/BSxS04y
 +GNIx/f0uk6ew==
Date: Tue, 9 Jun 2026 15:42:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?VGFtw6FzIEtpcsOhbHk=?= <kiraly.tamas@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@mailo.com"
 <philmd@mailo.com>
Subject: Re: RFC sensor simulation in QEMU
Message-ID: <20260609154258.7fae97b3@jic23-huawei>
In-Reply-To: <BESP192MB2919F3C79FA633DBB40571C89C122@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
References: <BESP192MB2919F3C79FA633DBB40571C89C122@BESP192MB2919.EURP192.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=jic23@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2 Jun 2026 13:23:14 +0000
Tam=C3=A1s Kir=C3=A1ly <kiraly.tamas@outlook.com> wrote:

> Hi all,
>=20
> I am interested in implementing sensor simulations. I already saw that th=
ere are some sensor implementations with varying details in QEMU. My questi=
on is the following: Is that a good idea to extend that part of QEMU or new=
 implementations should happen outside of QEMU and some protocol, e.g. vhos=
t user should be used to provide sensors to QEMU? I would like to align wit=
h the long term ideas. What was the original intent with the sensor subsyst=
em?

Hi Tam=C3=A1s

'Sensors' is a very broad term. Could you be a little more specific in what
types of sensors you are interested in?

Thanks,

Jonathan
=20
>=20
> regards
> Tam=C3=A1s Kir=C3=A1ly


