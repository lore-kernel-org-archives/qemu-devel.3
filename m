Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E7CCD5BC0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN96-0001ut-2u; Mon, 25 May 2026 00:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8Y-0001gT-6A; Mon, 25 May 2026 00:41:59 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8U-0001Dc-Kb; Mon, 25 May 2026 00:41:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7mJnUrITf+OipizOWTb31m5YNABnQVuOCRNMjKv7dNugxKPaDQNcncS9QoEfbtm02bL+vrreyybrjkFVmQa3UZ2BbfFdAM0vCkHKwcavtfSe2Vb9GS1/oJ3uz0PEIH1yxePIwXyHkcKlrWsHF5cYEUvKWHNsQgoWBi68tA46UnO3TrP1fzgeFGZlckSyFwSye2XyWcvSQCmkWqv7omCcR3vzPJ+0mrzVfvNoVy5KM1KuVQ4V7AKRni2O8DLdm29kOG3TsWngUbxNoQKwNnbLgn7nkiUN4+vC6ZpEYva+BfaNq5Rx6orkonhEZ4gjOeh88Y0NtaXavpbElOuKucRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frClfAVznRwZLUPvTWHbIQ2uJtEoisyOROc8okPaahA=;
 b=hdcpE6cuGN7LuwwMYg6bHcRpQ4tCAJ0nYdTgHIjh99U48JuQmOloaI3Bp+L6FgwlWkNtCsIBO5m2/2ps0P0MLZtDEHykMFT59gEey6d7rfs8ay0lnR8tGAnwSmFchthQ0l/KKCVEopSUFSunUSCMBMFjwB+ziJd4M+OsZo07a1xcc2z5CK0qrp08A4y1dOj9sZIfM8vIico5iC9JfXPipTm/Tj9LCOdVL/Px8rb20V5TYsE+AvTj/ihK0y7Wx5O047eZYv9kdXlnnWUFNT11UTeO/azFZQbmQ8L0EPCMwVVcX/ahdpiUWRWg4K5DlymQ7XIbyiDQvcgs6bBhky+e/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frClfAVznRwZLUPvTWHbIQ2uJtEoisyOROc8okPaahA=;
 b=P3A/aded91GlXajXNNJ/+2LowuLYj7GBy9oClRZsk7afGjHpe/bn6wKzsf6B12lUZeUXKFcmrYV4oliAwkzH5+vvrLnVu2fHFhEPFgrTjCnE1IU6duJZdvluEM2CQO/mTK3F50GXFSoBP63xOz3JeuBxJN5o4qlVHOfJFnVdaKQxIl3LTtuA/jMnxAdKdFt7tAvyZQrAuuf/ib3vrWL703urRo1RBvb+xh+JL5x7k8Tpjb0WesrsUFk76mFRUI063tEe2G8yJdmKnZPo4CHn1GjBBImV5UvTNRQbGBU4kjRrOgAIk/qf9L3leDuJ0sRHe3dc8oF/2lifnfxpEWQSZw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:43 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:43 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ninad Palsule
 <ninad@linux.ibm.com>, Joe Komlodi <komlodi@google.com>, Nabih Estefan
 <nabihestefan@google.com>, Jason Wang <jasowang@redhat.com>, "open
 list:STM32F205" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 09/23] hw/misc/aspeed_ltpi: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 09/23] hw/misc/aspeed_ltpi: convert to use Resettable
 interface
Thread-Index: AQHc7ADJgPtyJ1FQjkCOogacighNMw==
Date: Mon, 25 May 2026 04:41:43 +0000
Message-ID: <20260525044129.3133916-10-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: a3332cf8-aae7-4313-58ed-08deba17ebb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: m7TKeNNIfFObhiTTROgKHWtBcStv1XIMS2kw8tebVaJRU5nNf1hwq0Gj5O66eVDJqiH+WfMBtz18xQ/vpGBSMDjA1J/sKS7zgWLd1yv/ruJAiVjP93SqzIYOcwGOMsio5BfMVhDtLryJoXbDCKY4YaZp7wOeQnDiLzk5SgRB3QiIycgA0VZ5XM0Tmf0BaKaLS867V583IRpHbEJ8wlASbhHnWJwgjU/PC6erQSeAT3Gibl2FB5v6GZZGfP4iYPkHGKMAyfPVg0Yob4A89gJV+8KQC52eEX+fYlwjwd1FhYM72Q41wkPOBpegYQ6xzhEGndOac4jd7QWdRR0znz8jwfPiqyZLRnTRLAZU6cf4L7sUxKeQFuSA3lA1xNau3ipQ8JsE1V1K5Bk+MHG0KBiv5UzwJNWpvQrvb6rSpSGCUmdHwt8fMTL+1Jm7+jI+4LSOpSLke5v2FA4ITVgo4lg/4AfiPgTGEdooSUusixatOG9VrZqHysstl7rQIb6bV3TR+q87vRQ2a1dh4l53xiP3JUpoXcI0yyKwfUBA3hhR1SFFvGK9saDNBgYdOhVuHKXZEfx+TQQ2eOjscW+1JpGWCzQbHZrJeMK4bf5B1jn/dxIVthjZZ8tXXsouKwiCBOSiwBkBRDCLzZ7mG2o2Qd7KMtwS8vNID/aWlN00Vd0jICD+yUkzhuZiwLbQi4RR9G/iTvyPOHue/GPQv2Ci65sd+QWFZCAYVUMc1BaChKt8d/MeTxhg76D4YwWfzI+UkH1a8JL4Jae449infyG32vBxOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RvCMBm8nXJQpYWzmgyEmyqQQ0Qdep7seO/xyajoQVmi60OehILoXCAwIYq?=
 =?iso-8859-1?Q?H7METE5L3zptKcYfFyB11Q8q3tZmy5F0nubpGlRqKzg7hLzqEDkXbVMnn7?=
 =?iso-8859-1?Q?AuHS4kbDIz8oiunQl6dcSqD3cb0EzI53BRc+zGW68lUMTa15BZwG5JGtWZ?=
 =?iso-8859-1?Q?7oFAcO5RlSt/afkglZ6H8/q+iR+SqVP/NsagtFPrJZ4024GI6lWTRFsZNG?=
 =?iso-8859-1?Q?J7BwiYU9PKtcb6qnIcuOugfeyU5v0Cc3xzDPhZcsMXspuMOaUeYJAYQxg0?=
 =?iso-8859-1?Q?+PpeBcEBvfe8MG4pDLgb6FOEsbn0pGp2xjcu1N8wS46I55G8lk4hLWXDQ5?=
 =?iso-8859-1?Q?lXcC+yfuet+BLwCtn8cQvLZe0vllRjpADGsWl208VMLLwvkmr9sXVHuLe+?=
 =?iso-8859-1?Q?qzyP9igmHI/00+c8Q4T3PwUlMvZqYGkevrHLyt9Kcg0sVBQ4j1idGDrIEv?=
 =?iso-8859-1?Q?saUb6HaOOb/sU7vXqwk/Etvr5VnvashFntanVD+TCnD+CFHiw+/NZSRPXc?=
 =?iso-8859-1?Q?4BhsHSV0gX+hD1IdTRGBrWLlJC9PZN4kW1H/d/p3ykbCOfqH7Ms/oaK/8v?=
 =?iso-8859-1?Q?dbQmB6tas2bX31ZMJvhtJlGpOM57SPgRps7qI3HsJNzGtrtJ89JG1ECbb6?=
 =?iso-8859-1?Q?qt521BwSozjD6sG2L1nH76rOWGHVo+dmiMQxuuW2EIkNbmLXid4pmBa70S?=
 =?iso-8859-1?Q?R875YKaPSi15Jll9gfHYRfWk735ndHFW1rIs7r3p/WKJVE4ECLib4qfSb5?=
 =?iso-8859-1?Q?kHkpS9wGG39hGHdxWJRXp7QDC4k7+dEJe/Kf7fOWtJVrEROwNa22Q+XY2/?=
 =?iso-8859-1?Q?lfIUmHNMU0/URFKAuBJq+qFm7Ql46dEQh6Tksj5psYZCbaGxzgktOmX8NR?=
 =?iso-8859-1?Q?EDikFsrtPGUkuL9mdW6B8mLh3O6CcvTClpFOGhnWtLa5HwXYyeKDSnwm6T?=
 =?iso-8859-1?Q?mEHNijYZZbPl0+ZBItYks/m1Nfcp7rrVtnAhGoxQrpzFRq5BBTA1GVVSp1?=
 =?iso-8859-1?Q?q9DEBRrMcoXaD7ZmF9cnQrY7s+vNlRrz4GuC5Gd+4CocVq5yQtrZ4zhfOm?=
 =?iso-8859-1?Q?fYIPZMUWLehratRWkzIpRDIUtxDwG7InzVl3ZHuERQswCnh58dhWpDUUTv?=
 =?iso-8859-1?Q?ASqSvrZL4wKdHCSnfIrdb7CN34CsGDnrk7A+o0u07RHFEGjUMqj8jZeVbY?=
 =?iso-8859-1?Q?DlxeU+VLha9Imi+2x6mCFfaZbia7qM7Ovb5CrQH/rh+0UT/GqiDm0AbjnB?=
 =?iso-8859-1?Q?mCp4lin/u69M7iVa9NFVlAK6Htlq6kNqQKZStCBMsipwsgIr7uMY3d+luJ?=
 =?iso-8859-1?Q?Fgsm2fgXItgQ12bgVYIhFc84PqnXqSgwFKsSfAocLImHRNt6aMbNPkUFBv?=
 =?iso-8859-1?Q?7H9pz5pwtYi7JQ1lBOYmqT1ruR06YCsLPBXuYROwy1k2U3JMHIActrWlW3?=
 =?iso-8859-1?Q?M+PgIzwuS2tShbXOMoBRe8iwX7ivgm6NcH9E05VeMJA5BEIgSoyj4An/Ku?=
 =?iso-8859-1?Q?ogdIf3wzd9cUb3Oq6s8xuHeMnGsP77FgMiLKytRpVqxoHeShq/ev8i1SYW?=
 =?iso-8859-1?Q?wRQIZOqC8zJQ+ozKkZXT+/Yb8ZipuBMQSJZyu9S9AGzVL6JaQ6TMiQijPi?=
 =?iso-8859-1?Q?4HpI+z9T5ZhMD/QE3I2MVSwv4SOTz6dmEtii5KQeuW4DEj1d3NY8PmW5MH?=
 =?iso-8859-1?Q?SZiD/neiHOcyaYCF3/uMhMpT4z8kwdU7FLV3RbY43yOoZEnkCPD24OkmPY?=
 =?iso-8859-1?Q?nud4CAEizbQAgP6u8xBlmlXkgILjjWDZK1B1GrchU5rii/x09GaJlm1pXc?=
 =?iso-8859-1?Q?lwkheF5lIA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cIGKZyiIrWWWoM6fF/XnzCxiS9kSkeG1hida0XQ1QKnnBuTvJcN3lkXxt+pdWSbAD2z1FTQ76Kt7GNsKYTMEKkFaDeGWA1M9tNj21hM8Y1diW0ygdb3bpGslO6Il7XMAzRSBFeMYVf6PqPaH6/BiPkLbqCMauIeWqDkSdgZ9r0CajMzF7IdadF9SF5vP86h1bETd0v6IWSG2/Av2SrNmKdyeBBnwHCUCsK18i9JXJ04kMwqEMhtzoru6QvYMA1zYoylpYDaVP/Vl9j5sMeymYAynRcCMTBHdoDEV3bRJsgvC/hsX9cIKH1HkTC2P8SWIuyQF5sBG79HT69lOxoUGwQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3332cf8-aae7-4313-58ed-08deba17ebb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:43.4362 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smMf+XlwTmxXbgZwKQ/BcqXsTszccAYoGrGghG188IKvrz3hID61BUZT9iE0WMJyPWnjGD+RZ6r34nVbLIJY+wsIG+UiyIM8NbBsFAallJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
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

Replace the legacy reset callback registered via=0A=
device_class_set_legacy_reset() with the Resettable interface.=0A=
=0A=
Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_ltpi.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c=0A=
index 131cea9c6b..956e91d143 100644=0A=
--- a/hw/misc/aspeed_ltpi.c=0A=
+++ b/hw/misc/aspeed_ltpi.c=0A=
@@ -112,9 +112,9 @@ static const MemoryRegionOps aspeed_ltpi_ctrl_ops =3D {=
=0A=
     },=0A=
 };=0A=
 =0A=
-static void aspeed_ltpi_reset(DeviceState *dev)=0A=
+static void aspeed_ltpi_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedLTPIState *s =3D ASPEED_LTPI(dev);=0A=
+    AspeedLTPIState *s =3D ASPEED_LTPI(obj);=0A=
 =0A=
     memset(s->ctrl_regs, 0, sizeof(s->ctrl_regs));=0A=
     memset(s->phy_regs, 0, sizeof(s->phy_regs));=0A=
@@ -173,9 +173,10 @@ static void aspeed_ltpi_realize(DeviceState *dev, Erro=
r **errp)=0A=
 static void aspeed_ltpi_class_init(ObjectClass *klass, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     dc->realize =3D aspeed_ltpi_realize;=0A=
     dc->vmsd =3D &vmstate_aspeed_ltpi;=0A=
-    device_class_set_legacy_reset(dc, aspeed_ltpi_reset);=0A=
+    rc->phases.hold =3D aspeed_ltpi_reset_hold;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_ltpi_info =3D {=0A=
-- =0A=
2.43.0=0A=

