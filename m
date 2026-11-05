Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C37606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 23:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=qxqb7cQx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP6Yg-00047I-B9; Thu, 05 Nov 2026 18:07:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xP6YK-0003vS-En; Thu, 05 Nov 2026 18:07:29 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1xP6YI-0005Np-UQ; Thu, 05 Nov 2026 18:07:28 -0500
Received: from [10.1.83.104] (unknown [31.38.191.99])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp6-g21.free.fr (Postfix) with ESMTPSA id A3BF5780333;
 Fri,  6 Nov 2026 00:06:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1793920044;
 bh=Pr/7uVv2OlLGyXsqN/rdY/EZzSCGzjgFygbkYrCSopM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qxqb7cQxgoW2Dw8e6LIV233ddeO5BufrpMVAoY4u9Yh0mXtmOS0osggOn2RiML6G/
 tpI70UaWrJKRhtr62j3BynLvv/K+4wfgfbDxjZ6YmFie2ZLevrbv8xNkdFJEQFboLH
 z8KGqwaOzMzfKtY4DUh8Rqh1XSypCx2gHQL43OrzzpAB6qNq4UwfbhXhXasRWvjll8
 uhHtrsxxJPuhoZ5kUOYgda/Td5xsAvbwyHyj/JDR4Z5Jxuu7QnDnycBl7/88bd95cW
 W/BZBFE6NrD7zPmTbD1JC2eYPBowKWftezHvl79iW9+10LLNrh3BmXQevmT5iVNqIN
 W+X0c8cXzT3GQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Jamin Lin <jaminlin1207@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Bernhard Beschow <sgentey@gmail.com>, Glenn Miles <milesg@linux.ibm.com>
Subject: Re: [PATCH v3 00/50] Aspeed: I2C device models and the Minerva BMC
 machine
Date: Fri, 06 Nov 2026 07:06:51 +0800
X-Mailer: MailMate (2.0r6272)
Message-ID: <4DF972EB-FDCB-4F0E-B6FE-0B7DFB1AE921@free.fr>
In-Reply-To: <d9865aab-7e92-48f9-a628-3c1d63cf3b16@kaod.org>
References: <20261015-bmc-minerva-v3-0-7d50c8a108e5@free.fr>
 <d9865aab-7e92-48f9-a628-3c1d63cf3b16@kaod.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; markup=markdown
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.27.42.6; envelope-from=emmanuel.blot@free.fr;
 helo=smtp6-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

>> New models:
>>
>>    INA230   TI 36V current-shunt and power monitor
>>    INA238   TI 85V current-shunt, power and temperature monitor
>
> The series has been broken by recent changes. Need a resend. You
> can keep the Reviewed-by.

Done as =E2=80=9C[PATCH 00/16] hw/sensor: add the INA230 and INA238 power=
 monitors=E2=80=9D, free of any BMC machine related patches.

>>    DS1339   RTC, a DS1338 variant
>
> Please send in a separate series.

Done as =E2=80=9C[PATCH 00/19] hw/rtc: DS1338 improvements and DS1339 sup=
port=E2=80=9D, free of any BMC machine related patches.

>>    PCA9545  4-channel I2C mux with per-channel interrupt inputs
>
> That's merged now.

Thanks.

> As said to Alexander, there is not much point in adding new machines
> types (we have tons already) without the sensors and tests. So sensor
> should be reviewed first.

Ok,

Emmanuel.


