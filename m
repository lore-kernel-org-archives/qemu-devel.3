Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3FFD5B857
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 17:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVC05-00022Z-4o; Mon, 15 Dec 2025 12:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vVBys-0001Sa-Rx
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:03:38 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vVByd-00055I-H7
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 12:03:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765817085; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=gqXxSN//NUeCyw2LJMc9OqOcrIIjDL1l6/YEYLTkxJHLPp1ry3qNYHikYYNp19uDJE8R82ArWr4PSe++tO0ECU/DimZzxuDNWnu+cltsHTgn+9JDhHZo/kehCMx3mHCrvFptBoi6/yAYE0dOgEyrAf4v/m+WERNgpLVMh1H3gV4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765817085;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Okhcb+mHrLdZfC5AndPe1wxJVN/L8ZIWn1v3Pzb4PJA=; 
 b=Zg50GKEXJ6oUTgYvl5UKB1H9N/v0G4G6xbnrZikGG+KpxnJxfSsMHxyJiDB7qI6GKAr0K0p5dHh50SF8mGuW8GU00BFir9u1M9CBJh84a1N5tkoJq4HIG0FBGolzrce7Xi/uOCQHrMuKspqfxxUmWUrtdvhdDUDS4VKTL8h0gVI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765817085; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=Okhcb+mHrLdZfC5AndPe1wxJVN/L8ZIWn1v3Pzb4PJA=;
 b=E/2gzbB4lOP8Gt1p3lCTYBK6x5MQh3YKlhFuC/C799wCJRIVQwB9M3xqJ71c6M0B
 QfvqCjBiizsbkeD7y/Xb5LUpVWA15YXfgDGz9hR1u8YgbwIYRHPLgECgJ+UsXUmw3v5
 9SNw42WPGGH3AM6l0Op7RTe6ESn0BMcdCx+iesc75as88OESppRHH4tQ7SvqjjY6zre
 eEOKroOO5RDXOQytaUjeUFSmS+qbdoO4718AGmNHRc0jD7NKSjKD3Ule54f0dwUHMzh
 dL9XsGGSNmTcfsxGo5KFydpHf+davs1+H65wWD8kY+POTZ+LdEmQLZrY1uMzynrWtEd
 XI2UdLg0ww==
Received: by mx.zohomail.com with SMTPS id 1765817082294461.754019425539;
 Mon, 15 Dec 2025 08:44:42 -0800 (PST)
Message-ID: <c496ed9e43adb46c59352baee4507357b6c1d97e.camel@icenowy.me>
Subject: Re: [PATCH 1/7] Add termios2 support to linux-user
From: Icenowy Zheng <uwu@icenowy.me>
To: Luca Bonissi <qemu@bonslack.org>, Richard Henderson
 <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Date: Tue, 16 Dec 2025 00:44:38 +0800
In-Reply-To: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
References: <745f18b6-ee62-4903-9a56-dcb903b610cf@bonslack.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=uwu@icenowy.me;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

=E5=9C=A8 2025-10-31=E6=98=9F=E6=9C=9F=E4=BA=94=E7=9A=84 14:23 +0100=EF=BC=
=8CLuca Bonissi=E5=86=99=E9=81=93=EF=BC=9A
> > From 6ddab7d3ba1035b5e2a6016bde4776436267c18b Mon Sep 17 00:00:00
> > 2001
> From: Luca Bonissi <qemu@bonslack.org>
> Date: Fri, 31 Oct 2025 13:29:19 +0100
> Subject: [PATCH 1/7] Add termios2 support to linux-user

By the way, please add a v3 tag in your subject (like [PATCH v3 1/7])
when resending this patchset again.

I failed to differienate two revisions of your patchset.

>=20
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>

