Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F26CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8h-0001jX-QG; Mon, 25 May 2026 00:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8T-0001f1-84; Mon, 25 May 2026 00:41:54 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8R-0001Dc-Oa; Mon, 25 May 2026 00:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8+bFM6yiEYX0FAxjC1dt4oQSyhlohBCm9EcCK06gI/hV+CxNoMyVW3RNzCSOR4UktxjbNrn31O9lHlZSk08L4Icq+OuskIFkZGuOd8DLKPon/fmHkDuNc9+pwCiv8m7clbwaxFjHt4Un7Mi+My7VMXWP5qvpClXkU6g3ocI7e5uDyEQZGg7wB9C3iJezX/ut1YJsVkD0GxCe8MLX6JsWb8dFaCyJJ4CphKY1RVleaFvCwzi6qmvMG6g+1qykhs6iMxR9KVnH5jiSUjHpO/915cgw4t32z/fu50noCwPlq8An2Weg5y6RPxu9KqJkDgadPPeXUgyD7zCqcavaVGQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkLKE0AXtp5/0jpXzjNjgcxp6tLFvHmRazr7jSlydOM=;
 b=Kaothy6XFS4TLRIylRy0tuKaaSi8oiayitQfUqk+80Un6TY13EPXorYf2PVF3tuB7V18gU5Jr3J3KyisFXTCWp9r1bTbOl6A1IjTVX6ZskrHgt+CYlQaXOxkY4H4KKfHv8Y/uNcRjjJfaxPZ7ldLXYhHBtze/0/jtnBSs3AfiwxizomKgOnplJvVGtDqpZZZpewjkPWRlEVGFtBVMQm/E0mEYDvZXye4En0UJku2XgMbWTjl5meqHR5rCRgsOssI2L7Ck4Gi09PbXgej/XJ0cR2vBGg7Ba+sjdog2xFnK7GUxFdxwL9ilAnzoL5ii+X4XSAlbY9rXhoWItCBL3Qh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkLKE0AXtp5/0jpXzjNjgcxp6tLFvHmRazr7jSlydOM=;
 b=bEon8Qv/9qcWBeGKex05AtPDz4y8zWiDP3I1TPfMpnvyoMX6uzVc8iJ+CA0Hlgp/87mDfJz3uDSqRTcAUOg1o2fsg/pKR1XYvQ+/gsrXR+rlyQS0aHAyCuEsmdSQMUClyu4YoS57Hw/NTQ5ZAMDgCC7uaK6zR4k4R8crywWp1vZKP6v1ksrv4xdCPJgM2UpWeuD946g/krnR27A6yNkNPsd33TByeLjCpIhXX/XMCzJUd9OIlaFPCt0sjOHZuTvwUAR0HOi4KcgYzjNv5hn2W+xDaFt7kg6EJJwn/bovAodUWyPhhwHDyeatruenQzQDO+GOMLqZw08SHq9pDjQ1Dw==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:40 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:40 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 07/23] hw/misc/aspeed_sdmc: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 07/23] hw/misc/aspeed_sdmc: convert to use Resettable
 interface
Thread-Index: AQHc7ADHgPq/CfXM+EKSW0CBCVuVQw==
Date: Mon, 25 May 2026 04:41:40 +0000
Message-ID: <20260525044129.3133916-8-kane_chen@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: b508778f-8916-4ef3-4a7c-08deba17ea15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: wD7DqGcH2ylHpJyWQgPlfxeaCM66b00a9VMQq3qUKEQ1itmVKUvIzTFAgtLsqQq574j9KClHJToyA0S8zDNAsZYqbnBgH7bMf0Xdnu5OxE3YCc6Y3+t2gKYDYB2pWmUf+hajRq5BHwCX9VndBcKduHz50V7eS1Q+c9RtobHtNTilwYFwVkpcp6czG4nozHGpLAzWvIyRIpu0QOW0lUlN5Mwf0bZBskJ372amxIYOZqYdI6Fz+pXdjRt7xn44EtNNKm2bimamdgHh5TNefPhiZDspmiIbCy2VDqV4gFyDIHDOCgu0LjIQYqB7h0b+cd0srW4lfVpIswX6WpwuAn4RAm6mKrNslzjqn65It3qC3LnCFOunFScw4FLco3UA+0TPJZAQ/g+GYkLOPljBzzeAC92Oa+Cp+JfS1bKo5ZxXOly4I0rcHxEavbQiE8ybN43Az7OvzirDIj7SqzbeP6gHv/OD5Z0oVIXx8UoqsYfTbYOPbb3iLbmqBwjzwQFsTAIkKi35bE+geUCC0LYQIt97nIh9nRQTC3ujJxZPgShRiEUzggmyBUWa6J7eOvmChAXdjRXdAqT+rDpOdWGMgn0ckRyfsd3TJazNIqG92twlK1BCeNtlPRmJYsZNZHse51bKxmOzUUxc8Ai1ljzFLKUkAmdfF6VoCupDT8cuHiBTg1vpjnZWwLoj+fUG1LoqaxOTHYMsTV+pq9nFqL1JHYNOOFPd69US9Sn2ac/TS0JXGQAvc9CjFukwZAPvyrpjtaTTzCPIp4/6yHuYZp7UwUBMTg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fq7Urtt7yvUmaj3tv6w4+G/UwfBOVWowdCxvSkbN4xDDW3N2DdM8WwlgbK?=
 =?iso-8859-1?Q?E5AbW7CuyiPb9SGodJ42d+WXKUbuk57ReuJUy7+rnmC3571b9U07WUVQwM?=
 =?iso-8859-1?Q?ZlAnorXTqzSc4MQ+SUUEgAAxf8/vLHYATR7P/tWJXOPJ/pZt6OzF+E1eJg?=
 =?iso-8859-1?Q?Be96EGmsASwql9MgXGd3pdcbQ6rmY5m2t+m+bGAmUThuSn95NDsfoQvEB6?=
 =?iso-8859-1?Q?Je8LA4wh7HTVlyz2LFtYn3AxxbLEnKFoMku50//G6ncaBl4MJLzBRB+fNr?=
 =?iso-8859-1?Q?x2xYlllJegjkM4QOouSm9bqpBWEQG18xmw6IHPm/IEXXoTplRS852mS0i/?=
 =?iso-8859-1?Q?rbSSuDRs2ZAoHdsd1BH/vvDBpDU9ImrLT9zp5c60PUt+pWvcCyaAOJoBbS?=
 =?iso-8859-1?Q?pKoaktSxAbbxPoypScYI6pkfBnqtks1K98cZt0ali3fxLkQCJvcsb8xrur?=
 =?iso-8859-1?Q?X8T0qWNbmDkUcjHo2d9ncuM7rMtmlRwHY4F9gPRPjeYolV1yXmE7h8PMHA?=
 =?iso-8859-1?Q?bWNlNlyfOq7HOes9GDXYpO4Mth5mvKteDIAIGkfrJXpKjyIEFNsopr9OfD?=
 =?iso-8859-1?Q?cqTZAPUIyyuHgr6L8vwCGmYlbQdDzJ08ocUQ/GgaxVlcUJhdBp3YZpnPUb?=
 =?iso-8859-1?Q?szMoPTZOWdn8ccGAa2GsdGOQDlkAbE8usHl0Ld5ezpOW9vH8A3gezZnxSN?=
 =?iso-8859-1?Q?kv8ASIFmecRKgoNZPI6g5h7pA60sLkwOY32OI4sFL8xK4GrwjxhrDMchmF?=
 =?iso-8859-1?Q?Dgkt8AcpzYf6yJlyGdCWtQp91Ud9Wj/d871XNWvd9bKNgei5miTXLUBNPG?=
 =?iso-8859-1?Q?6g88cissPi6FafOswMCPQGx4xWirHzA6M4By7hjGMBofRSSphS2O1BGuIW?=
 =?iso-8859-1?Q?MErCbHl9wAkbUA7oJ748RF61ODff5yBdbyh36gfYGH4l8e235gzgI0lWpw?=
 =?iso-8859-1?Q?HU21U5P/yp4I3mO2z+GcpMBKWfu/W5el4wwCYnAmY1ck6dOPiMUIXfOrIB?=
 =?iso-8859-1?Q?IgvpvsFBFOOGcBk+hEedPXCSoa3ghZF4lOXq7h7icIeLSeXCeeOVy8Wqku?=
 =?iso-8859-1?Q?7NmxtvT5LyChw0YUE8IgD89xMY+BBEkiaUin85T7gUn+ctLMS5ng/3ywyi?=
 =?iso-8859-1?Q?5W0NAMqRr5SwGU8d9ZfnUKvniKhrxDlR/PFtM7fJb/oPl0NSX1Mgm7bxmf?=
 =?iso-8859-1?Q?5DIQVevN+yR+xF2hY5Qta905uEzz0Y7Vsy9vMS10pnrEqNra7zDB66J/9k?=
 =?iso-8859-1?Q?rqn6FgUqWrumy1X+ctcxGgVJ/UT123PqT9D4VPFDkCkEaVwlhkDqkJ/OM0?=
 =?iso-8859-1?Q?qYR59tR8cQQY52sFiWBC8p9BZxqmc5lvY9soaf86R/x0VVj3OokKPMCsxF?=
 =?iso-8859-1?Q?GHZVuA69zT1b4sv3AvOXyPk9AOY8nYG1jkhhPfEFoc+FCUg1vQFP9hOKec?=
 =?iso-8859-1?Q?OrLF8fVemnQFxmivQ4m/WfXIxYqaMi77yKLDz71+bFqzM2/CR/NchtYdY2?=
 =?iso-8859-1?Q?HQ11fpCRBKFC1ueVvCXecUSbVI563RefpaqwQdnqHEahePkqdLjt9HCaNF?=
 =?iso-8859-1?Q?ixN4vlZ/KvIFA5I297LINGlVNRKHUZC8PcXOs9hh1coUMmjqe3opmlL6Vf?=
 =?iso-8859-1?Q?hkFKb0094lLqtCp/MIr13s0hpdaXgkT8OE3VaGMfzh4gNp+tapia6YhVNm?=
 =?iso-8859-1?Q?H/ESLS+2PQH6z/Evm3nB9AIqmjsFBuN6QNHt43XL7pUEPRoiT8kujgsnOy?=
 =?iso-8859-1?Q?CQr9hkxEDRhHtmSuLSIuFnmFtgKlKzHRebHWSQX+OS8ePJN1hd2xRQRkVH?=
 =?iso-8859-1?Q?L+cRBoZpYA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iXkkted47z+nJaAZojwFBy8EOAbKD3Mf3uNr74doGFFUBQodlpc4r/sXQoTmXtSWAZQFfeKm+FvH3v5YvRL4w/CaCo9slipm6+uJoF8ivLNw2mlq/YDSY1gqijWNE05FhOPvyGf0Sqov7dxUmuBiXAtoFzPbJLlHIKxhZfOZHE/10dcDsmFAJ3HyWndzxbcv8YdDqaAUYTR5eYncI712Ia2zGr4dCVY/l/Soc+V9JlR34I7alcuT/vDm14+FGVdXd6eh/PxbIXFuEiShbsZB6Eu+5/XFWvRPbcEu7VEA9EwTMmDyOcrOMF1WQooTKjcLpAszGc3y7tzO5VwMW2jJvA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b508778f-8916-4ef3-4a7c-08deba17ea15
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:40.6281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JZqgTlwXzIjPUXeVdg8GCxmmF9Gdk8K6U9zBcLl4BacNMZrRCtg+m81ZhSRPXkhjZBSWN+udBvUKHnuxYlIGJwFolKVlgbtOALayhsh49Q=
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
 hw/misc/aspeed_sdmc.c | 14 ++++++++------=0A=
 1 file changed, 8 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c=0A=
index 59b4a9a426..055abf7f50 100644=0A=
--- a/hw/misc/aspeed_sdmc.c=0A=
+++ b/hw/misc/aspeed_sdmc.c=0A=
@@ -199,9 +199,9 @@ static const MemoryRegionOps aspeed_sdmc_ops =3D {=0A=
     .valid.max_access_size =3D 4,=0A=
 };=0A=
 =0A=
-static void aspeed_sdmc_reset(DeviceState *dev)=0A=
+static void aspeed_sdmc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSDMCState *s =3D ASPEED_SDMC(dev);=0A=
+    AspeedSDMCState *s =3D ASPEED_SDMC(obj);=0A=
     AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
@@ -302,8 +302,9 @@ static const Property aspeed_sdmc_properties[] =3D {=0A=
 static void aspeed_sdmc_class_init(ObjectClass *klass, const void *data)=
=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     dc->realize =3D aspeed_sdmc_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_sdmc_reset);=0A=
+    rc->phases.hold =3D aspeed_sdmc_reset_hold;=0A=
     dc->desc =3D "ASPEED SDRAM Memory Controller";=0A=
     dc->vmsd =3D &vmstate_aspeed_sdmc;=0A=
     device_class_set_props(dc, aspeed_sdmc_properties);=0A=
@@ -560,9 +561,9 @@ static const TypeInfo aspeed_2600_sdmc_info =3D {=0A=
     .class_init =3D aspeed_2600_sdmc_class_init,=0A=
 };=0A=
 =0A=
-static void aspeed_2700_sdmc_reset(DeviceState *dev)=0A=
+static void aspeed_2700_sdmc_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
-    AspeedSDMCState *s =3D ASPEED_SDMC(dev);=0A=
+    AspeedSDMCState *s =3D ASPEED_SDMC(obj);=0A=
     AspeedSDMCClass *asc =3D ASPEED_SDMC_GET_CLASS(s);=0A=
 =0A=
     memset(s->regs, 0, sizeof(s->regs));=0A=
@@ -676,10 +677,11 @@ static const uint64_t=0A=
 static void aspeed_2700_sdmc_class_init(ObjectClass *klass, const void *da=
ta)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
     AspeedSDMCClass *asc =3D ASPEED_SDMC_CLASS(klass);=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 SDRAM Memory Controller";=0A=
-    device_class_set_legacy_reset(dc, aspeed_2700_sdmc_reset);=0A=
+    rc->phases.hold =3D aspeed_2700_sdmc_reset_hold;=0A=
 =0A=
     asc->is_bus64bit =3D true;=0A=
     asc->max_ram_size =3D 8 * GiB;=0A=
-- =0A=
2.43.0=0A=

