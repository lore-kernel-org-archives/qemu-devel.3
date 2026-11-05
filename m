Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3578606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=UrCqY2jf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6TQ-00032h-8h; Thu, 05 Nov 2026 18:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xP6TB-00030v-4X; Thu, 05 Nov 2026 18:02:09 -0500
Received: from smtp6-g21.free.fr ([2a01:e0c:1:1599::15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xP6T9-0004wu-1n; Thu, 05 Nov 2026 18:02:08 -0500
Received: from [10.1.83.104] (unknown [31.38.191.99])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id 77678780383;
 Fri,  6 Nov 2026 00:01:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793919721;
 bh=2qj1kCJg7kVwhIUwhR2RLZTCtA2IgVFSs9kNEUnsysM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UrCqY2jfWkPDexK/MhpB++0pI3Ix9r0czX9m29tr9D6dJ88oSi05r44AoyIXjMuRx
 8XeFinXbaxtju35VyJ02gxtorn6F+yuV7vSug6eUyf9dMpZVdFMSxaN2NMU2bHxSeQ
 FEZY/mTDvkbPFHTzpr5pinaTBH/TX4ljttV/YN4+YBMD5UHMwFrHLHr3vqPqJG/lcW
 lDC5Kd4lhevDfuKGRM2pZV8Eby+a/b2MHCupvJ9fzncs1YjaipriYtHfrsdEscEU/p
 AXCpKRmXdGFc74WFB8L7m1wMFFgY7R+9GnZlCRIaGpsuVVZ8fZOO/GBcJlROlyXN8I
 thmpxOLoqeS6w==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH 00/22] Aspeed: TMP421 and TMP1075 sensors, and the
 Clemente BMC machine
Date: Fri, 06 Nov 2026 07:01:37 +0800
X-Mailer: MailMate (2.0r6272)
Message-ID: <59941AEA-076A-41DC-AFD2-F6F0BC07468D@free.fr>
In-Reply-To: <f8228c8b-a642-4364-b465-85650b4b8c92@kaod.org>
References: <20261015-bmc-clemente-v1-0-bf591886b5b6@free.fr>
 <f8228c8b-a642-4364-b465-85650b4b8c92@kaod.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; markup=markdown
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a01:e0c:1:1599::15;
 envelope-from=emmanuel.blot@free.fr; helo=smtp6-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cedric,

> The series has been broken by recent changes. Need a resend. You
> can keep the Reviewed-by.

Done as =E2=80=9C[PATCH 00/16] hw/sensor: TMP421 improvements=E2=80=9D, f=
ree of any BMC machine related patches.

Emmanuel.

