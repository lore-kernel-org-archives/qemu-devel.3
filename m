Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B88606D027
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=QNV0iuJq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQhFm-0000kf-Hc; Tue, 10 Nov 2026 03:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEg-00005C-0Y; Tue, 10 Nov 2026 03:29:47 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xQhEe-0002yp-Jy; Tue, 10 Nov 2026 03:29:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYAVO41UO13qG2GcwrtbtJlFczwZvxnyuoN/hFQ6X14kjMi3cWq53kJgQFPT95icTOMibQLA7pGItE7ZYNHmHS8y2PrNzLUx+vxvDbycDPFWgVZnLsPL/NkRHDJftaYxy7VbRVISTUKZQVdoPyeXCIoe6KGf2c5xQtfH1sd9V+CYTkq++pgilBjfKiQLAqv0bA+Pym8mzRt4UmCEhy9CKZM3Oie/jcf01CnPl4gpZCnBKqIh4IRKj4urPox7OFtNjkqypUszUQsnB6H85k+NpPIfJR76m862A/Bx/YyHYsJs+u+rOGkRYasGridjxnFib/trURr1O2uFz/HUersA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVJBkpsHxDXm0X+iPITMeWPATnh6kwBbywldlHLXwQM=;
 b=w7Il0ZzwirgANtEjj7+uTcKz7PmevFrNfLn/WDftmUyO6DLN6u7nNXFjev6tVmkRsEbqhUZVMzTSnWH+4MYTu0JeAV+wPngZSQu6LlVzen3PDXco0bT/ocQJknV5q62muAYo58LzZJH56ikxHoea31n9s84nIS89k9psLoN1VR3aI64eZKyZjPy1dmpFc95o86qdYa9Vz1h6d5PSgWY1oTn+hP718q5AFXwv3kA/TVAqBZkOXPCv/6bSOxD3LSLx+2bHSMITrwHMG71DKIjdJkZevIMj/rFQCiB00Bh4PY8kxTwUK/7sozMnfYG/RpCeiEeLMropi+qJggvEu++1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVJBkpsHxDXm0X+iPITMeWPATnh6kwBbywldlHLXwQM=;
 b=QNV0iuJqGcg9xWP38XqRdTe6Lt/qQ7J/B7p2Rg89+azTV5Lf3oKrK1bbrsAFeMvUYyotD3z0LYDDqXNhR0HM4MNGnElNzh7scFPTLjtc+MR5yT2JBz0kQntC3R/vR2xgerp/B/JMJziYVuS42Z2BMrtHqCIzno9K6W1d2WnWIGTrYrg7X8kze+bxGuORmwip20Di0DgxgeUYX+CDM8qHcysfa8cg4mHi6nUCgr8i2EhYZ3LjHViHLc4MIRhEtfkOUwV/h/bguYCxLekVa4yEDaJSp3FDjdPnN4pmRkDkrdgpEPUxbNoWNUApgKhWU1oGQ/975BA3MQgJa7URTrN9nw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB5490.apcprd06.prod.outlook.com (2603:1096:101:b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Tue, 10 Nov
 2026 08:29:25 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0615.005; Tue, 10 Nov 2026
 08:29:25 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v3 04/12] hw/usb/aspeed-udc: Clear EP_POOL_ACK when no
 endpoint ack is left
Thread-Topic: [PATCH v3 04/12] hw/usb/aspeed-udc: Clear EP_POOL_ACK when no
 endpoint ack is left
Thread-Index: AQHdcO2W9UxaA5anB0qIMb6F40JWbw==
Date: Tue, 10 Nov 2026 08:29:22 +0000
Message-ID: <20261110082917.240329-5-jamin_lin@aspeedtech.com>
References: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261110082917.240329-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB5490:EE_
x-ms-office365-filtering-correlation-id: 48bcd65b-ed28-4132-9446-08df3f04baaf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|38070700021|261102123227099003|56012099006|261021121427099003|261009223027099003;
x-microsoft-antispam-message-info: Dgd/Vi+5Ptsu42R0dVmOKj1ELPComzFrsznVg7LEj8NExSj9nSVqpLYykWytz57LLWY4RicsJsvfhtEpsOjg4ImYUVH/nvQK++ydM7L7mXW9amIGZesyo+KHPZ80zS8JGXKQcSH8tt4trbfTWVYF/ddc7RT1mRBTKkl/33ZrmAmw+e/qzAhEqORAWwl1pZR5flAtoqNzZseqwhmEMOXovO4Az+2cx9EHznupIVzDZpheKfU0g2A7B7daqlSlqrrcLl9u29UL+FarcUOLM4ltfjE1AN7yG37ujeg2qbXvyw0msodpyF68UaCFj6g2UCn96DUAzREXqFLgzDD8iZfUGpougiLCyziDKnp7kuyuD4igcA6W6Pk1OTRKuf/mVRV7k1ip+FGMMdpXQ5FijcB5ZJMkdw88QONBzSgQ4y2xqvqhkb5UfASXhYlQu/QAvA2QFBvX7JE38hpk3AiXsnCCDj02HUNNh8mF/aweQtSWuH0z5kxj1EElV5A34+lPMePi0tD8R/w5sRIxVUj3s2ijbEqvDmUkOqi/sWQ02F8F5RXuxA/KF0rT/1pge9W+NxNu3QpYVDMh6NFK8lIUykY1lSb3B+zIs3gxLBB5wvVUwSSD/KV6y3PcKay37Tt3DfoiK7gZYKDKUZBI9mzJUPJVU183N8dw6lNHrz0DJ/evgnno6CP1mF39HYidt5/Jr/DeYlwWUr54ZASjuRkQM8iNG4B93V9i/Z/l+gbPgzrJIcQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(38070700021)(261102123227099003)(56012099006)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?euWU6IusM473tXj6t92Ih43NHPEp4Kh8GZILCp8jA4lRt+3sf6NM/6dCt3?=
 =?iso-8859-1?Q?qH/R/V42T167rkxh45d/4jaXeaASJgk0x6NGzLFh+/gFFuvspQ9rZqaFwO?=
 =?iso-8859-1?Q?2o4XbbBkQGqyIkpDhU2nLgyqiDaTraXCdbZWdVcftUbOEq/v9rSMGvsGW2?=
 =?iso-8859-1?Q?NepZxJtEw+egxCpYPFKfdXWRpH490plbnwmI8iMl34a+L151D2PASQcQxX?=
 =?iso-8859-1?Q?sryE6bE6whs88Lb7jHAc8i2pN0VHchUfzh5o7ZQmBQohWw8bsGm3AhjEbQ?=
 =?iso-8859-1?Q?FnuDZ1YMCQHClBoDxQbPwOAr8w8D2fXg8mzp3ARjUMl1HZNZRmbhvzLP1+?=
 =?iso-8859-1?Q?cxCr+fI11oe3so0X7+2XzoKPEdorsVTzxN5uka50ZH/vTWO1rweRCf6Elz?=
 =?iso-8859-1?Q?hSusYvJ+0KB0UE21LP+0UC5ByXDViBO6RVdKm0eWoK09zYdlArb7qwwlFg?=
 =?iso-8859-1?Q?DNUF6G8RVAo0fii8rVCn64Q8od8JkdYuzonKOSBIrPeiZSH/Prbc0QVVKC?=
 =?iso-8859-1?Q?6B2R8DqQbRM5rqXOx5Ff4nyNaJiZYWGlfCWScch724YlyuFwbaS5tKpMeO?=
 =?iso-8859-1?Q?Qp2upDUEIx0wGnmObSPeLrRPFVea9c9N0h5ZGEuV6m1zyyGTbfPoBNHF3x?=
 =?iso-8859-1?Q?m3G/QnkUeTzv0ipxVV/rIX2zvwcWKJhJb3hQ1VR7w3hDhmZI2oTteNFwD/?=
 =?iso-8859-1?Q?vYs7YSVFTGWuNmNboFB2cpH31Vl7iKbVaN6gzDz8c37TyaWx0Pm1vq7N8h?=
 =?iso-8859-1?Q?iZ+KUMRMbdKxUwoMCsx1h+h8w+scf9y1TzTDiMam4oN7d5UdFlzAu0szKz?=
 =?iso-8859-1?Q?cRzTXyNq0fKevb8B4Tl+c3rOG8EEmP/HHlzC9XehAbgaR8jz2h9nap4sqX?=
 =?iso-8859-1?Q?skD7GqxcMBFzvAKl2P1Pqu3O5XcfbFnXwRG1kJ2PykD/PyuBpZF7TRkB3y?=
 =?iso-8859-1?Q?Ve9h9sxNlS0BKdk3Q++dv3JS4oA7mFhpomdiHZlZaM4zFmPDXmADrcvVwQ?=
 =?iso-8859-1?Q?S+wdo5DePAs1Sknujvhh1RjaMGBadR+v08nP+P6i6b1m4GbUZPm3QwGZXg?=
 =?iso-8859-1?Q?/PkxI53+TekgWNKUR15kNh6BIHKzhiqw1KiUde96KBqOD0D02OGE10leNI?=
 =?iso-8859-1?Q?nV8cx48xqiHpa2/6D583Y/uWJu2YWSQS/MGDquYNQ+AFO8za/Do6MxoSbI?=
 =?iso-8859-1?Q?tU8awT+yKAPktsgMw03IYDbODeQVJK/r6X3DU4cf0zKIi9uVQj6Vf2oxwT?=
 =?iso-8859-1?Q?gst86UN3YjVloQE/wdc1mJjluUi7WbxXVxYJTGkJNyf8fMoHFCoDhP5dd+?=
 =?iso-8859-1?Q?DTt1YRm2l5b5IlStsYHqe8EWrJjoksfsOXBetyYsnghk/kTTgPxIntspCU?=
 =?iso-8859-1?Q?NMYUGOcicWHWa71xEQHXmxWV0YtTlWJmVBO0FQFfoi18echdICrzTWM9vl?=
 =?iso-8859-1?Q?K5FgQX9SJjxcf5pmP/v1I7g8CZqNwfJ2R7xO8FFJDk6ZTW/7rjp8IKFmTQ?=
 =?iso-8859-1?Q?fra5pmo4crOYcLeiOBDhxdkQ7GhOzALCeWHd4XRoYnQtM1ZIlJ78NWdeDJ?=
 =?iso-8859-1?Q?tPYa+QdYOB1WYYtarnatWLcE7xBaay57Z/EXOQKZ7eh2wyZhjpaB2n2uZJ?=
 =?iso-8859-1?Q?bGURVYiRrLKYDvByr/3H4JfKREMaaZSYIHyLjkm0ghRJ8tOOKq6kj+xgrE?=
 =?iso-8859-1?Q?Rr+fkQAYuhSIE3nYqo/t0IV+CETzkj1LepTXCo0o9JMn0K6JMoCjWfccBb?=
 =?iso-8859-1?Q?uiSUm6Tj8w65kwCm55nzdGEMVLO41ma//NbmEWIOgXEvA3xrW8vMNiErXm?=
 =?iso-8859-1?Q?0m55fj99MQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bcd65b-ed28-4132-9446-08df3f04baaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 08:29:22.6660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P66hBzqSmyFzBtgPD85Ke/BFhBnhDChEAq8aZHcJQNZjaOztqFQL8RcpwBt6HZci4wsrztJykAB2/N32hhcy9u+wM6O+6RiSUjlRwmPKpCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5490
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

UDC_ISR.EP_POOL_ACK says that at least one endpoint in UDC_EP_ACK_ISR=0A=
has an ack. It is read only, so a write cannot clear it.=0A=
=0A=
Clear it when bits 3:0 of UDC_EP_ACK_ISR are all 0, which means no=0A=
programmable endpoint has an ack.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 945940cc99..2d024533e7 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -345,6 +345,13 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
et, uint64_t data,=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
     case R_UDC_EP_ACK_ISR:=0A=
+        val &=3D 0x0000000f;=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        if (!s->regs[R_UDC_EP_ACK_ISR]) {=0A=
+            s->regs[R_UDC_ISR] &=3D ~R_UDC_ISR_EP_POOL_ACK_MASK;=0A=
+        }=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
     case R_UDC_EP_NAK_ISR:=0A=
         val &=3D 0x0000000f;=0A=
         s->regs[reg] &=3D ~val;=0A=
-- =0A=
2.43.0=0A=

