Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132BDFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:54:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRk-0001fU-Nu; Sun, 03 May 2026 22:54:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRg-0001dB-62; Sun, 03 May 2026 22:54:09 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRe-00040F-Dj; Sun, 03 May 2026 22:54:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPdStz9AcmqimNISZZXDM8wENx2ant0jNujzAuPRKdNhbCij/m0pBdRNidMrao30SYfi9PyRnj7IdGKVdkcUtRKorc41Q4F8jCXDJK8xgIhx3tfJLuqffkA0FYfnQNx9qT+Qh1c9HDEkUL0kagR1AhmNLImp+qcqgmgAFeFN05DASwzSpy5sSAWWiEqi418EEY9aa8myGJrD2sqZaIQmJ6RV7VQUv4Ew4asXcBVC1kY6zHarLszf+kvtXvfqEe7/n3vR6zbemxbKkXoT2PBR0e961d4YSVQtmLdkH3WKBzHgEtpaMmePfFM8KTX3LDCSpP6J4dDGo92MFvCaAWlDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ7C84LslWcGxMxkAkiKjxLES3iUe3F2g5ARQ+wnKcI=;
 b=bc8URM8qE8/GxC+bzCoeIzGMGrRtjHhkUGkY3wwi2gtCPXghpxcYvWGgJJxMgB3bqbx1RgB1F2tOmrLk2hoadkNeMp929a6DTT1zfUX0cRVR2bf7NXAyvUIsBBQ8nDmJBamQ/te98nlbvdo7OoOWnptt3MGJHCP3H+NL4qiYUuJARJq6zG784F3Y0z4Bh7wt8Ze3xJ0XcTRRCdKQxLiTHbvIXahQMehjK/KeWyBNJz1XfXsH1O0UTT8xlbcToo8ncHOpY+zQgPd0zGbPhInTO3jmplxRH0aRtou1rdKta2B2bnWbfPx8TiU+gDF4ZF2ZHl58eiJcI4d/6H2DPTu4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ7C84LslWcGxMxkAkiKjxLES3iUe3F2g5ARQ+wnKcI=;
 b=Bxlt5jlRTTZJXgjmF+ITK9n0DK5d2u54RXceOU9jFo92HDzB99KNE3vTAOA2ntENWVyyGcUxgKRHt9lwyLncIT7OAq5OAP0EAWdnzLv0ozmtifijQgWdFKwHUa4TGntDR3OK7jWVeO8KwQ8itEf6chXJNyiTMWMBkrtW4W6dlhJN3/SOZTBcKuFltbqDyzrz1jljEHkKqCnmzSVYGeViHySo6TyUX8qXxSNIzT+00JiZmrdKVBzkHuI9w1skTrkyTFbs1+PJasrTkKZeXW07VOp8DTqotmgB3QhaxLgkfS/N029bpFeT6vRpQfmx1ZvG3sMfBKU8X46YZQ0n/b5gdg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:54 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:54 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v6 10/11] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Topic: [PATCH v6 10/11] hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA
 addressing
Thread-Index: AQHc23E+09DWmngc80qI4sBHxcHD/w==
Date: Mon, 4 May 2026 02:53:54 +0000
Message-ID: <20260504025342.1452605-11-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: 6dbe92cc-184d-4b95-8af2-08dea9886121
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: hW0HLkDTVxDA1oNVBaTp1Hhaczay9eDUVv2reWSocFlZyzTqQ85+Vr09emZcAViIbsm6mcQ0RTES6NqTwkGxOzZNZD1RvsqCeRGjqC7OhC+nwZVTDMem2DrcPlc9yFNDyCx8iBxGNOUbSVhmym6RL4s+hjOx8Fd4YwbLR6q2dSXmJ6KgMhosKbYRaDoAm1MLdIxxX57urdNvL0RGsG0YwF3XqJqUqn34ZIYsIL/cL57YiVTlNtEeuUIlRyQvWhlvEWnbW821vOgSbAtkWsUwj9SklzqzVzzQ8hyr3fMlhqK2086+6U3RLmSt36GAZolk81PmWYjN8l0/hfbygithuqx8BhZ6Oav6fV0sTfQ5sRfr/HsS00nkC1gOIpDQY5LOtx2NgY8FwJSs54Xs4+KRQvjZIcxEkdCXWaL99uXnibfk0FfI0TUyFZNN58HZvAY0FN+QufPR9iKOsAO5eGn4RLFcg9ydmH4TU+9X5pz5iEDVdAhO0lNocUNbV53otbyxdq0VHtqjxJ6IU02gYO3FBSlXaqA6EEsTI5lOOB/rdUE/bB2hxtWxh6/iGJR9VOEq+UQ79i8bp4qiqdK0NI+2ZYTWXrIZemLhkHWQPqUoDht8ClPN/pQcr5Dfd+k9+dREmHww9TIfTpjZPWAg3Rexi4vtanKifCSFjY3nkKfnN/4xMbCMRqfcy1WsOJH++OS3pANJWJ3khIPC6k9KaS1MAJcY6t8E5ix9bEs3DWVRXgiiBMXfOLTGgZGwGhfCiAH4ohyyFrmRWqkQJCsts5m3Zw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ONORF/FNjYD2X/2cs+zmC9s6QwPIIcWchoxucimqkJhAEXAIU2RJHonWvU?=
 =?iso-8859-1?Q?VR1HCclOMducl/r2G7OzRckc3JDRlFc/8B246sEGDVjQLdsglS/OKvj99O?=
 =?iso-8859-1?Q?cdCEDzKC0C8DAyEKP9uDAQgeFer/UJ5GRk23yBGnIz2Ek0f1ARt7Pcl604?=
 =?iso-8859-1?Q?rV4Rz4ov9gjFJRbemmNuV0UIE4R1s+bjYAm2+DfXuV7B6yWQVn7ruJMI0o?=
 =?iso-8859-1?Q?F/njM/dn2pAkN49kcUxy0Gf7WhhnVYI/kuqjdwqGnDAEzdAoHMRjQdIUBn?=
 =?iso-8859-1?Q?dsfINGgtovP6HSA1fBCrCp2hHOzdmKO3vw7/vjpaaENz/fRKmU3fkUfiZC?=
 =?iso-8859-1?Q?e53/QxKv3n0O0d4AO2SxadR3KA0vK4ILNsEsh1DfRIrY7MsnFigrPz/mZQ?=
 =?iso-8859-1?Q?xBa3wRbwXCHxmBXmKmOskAnThh88QCUWw0GUq4AX7bAqmG4GCZC4B+kkGR?=
 =?iso-8859-1?Q?7O1A5ykkojMYvOV2FvddN1JG+LTnh05Khep2Gx47J1kVJlb1UQ/YZbvNBc?=
 =?iso-8859-1?Q?DCLgdJ9qCj3YLWPL9TkpAd4EhcY9S/Vt3rMn18N2i7Z6FQBpo3tkXqv08j?=
 =?iso-8859-1?Q?aU5UPm+Is9Pph80yhfbCQlL98cRLUpHWpUpqPTXgkKpP13f/x+llwHmT9d?=
 =?iso-8859-1?Q?40yW0Tqer1mt7Rrp6UbkayBO6fQilZWsDC37wJhn8B4r5+sybrWCVek5D0?=
 =?iso-8859-1?Q?M9ftUn3jvup2HyZaEUoUDVV6B4LDjPkd2NHap5ZWlr8sPAIwangjlxaLvJ?=
 =?iso-8859-1?Q?9QKDjRpR0rLlgSqwjk2e1TQQuF8LzsMRZJEam2nZqAjGg8EcLEvhf5D1t3?=
 =?iso-8859-1?Q?FPyYrRKyskipRvR65URXa3lwnf2Xq0mmSrPRxauDgAtaMZ0JxEDVarvXqt?=
 =?iso-8859-1?Q?iOlSyRe7dI8FsMvn7S0SU5ZLLLr2jbblLLpocWiaUf5kv1QXnRnatwgRp4?=
 =?iso-8859-1?Q?LggMfmH9ARp3s0SITObC5hbkmIcqdwaNumlLpTF0aIGDZgjmRPzlEhaFKv?=
 =?iso-8859-1?Q?enUGRjN4ccTxbvLcP8knAwy1UasnXO5sNj0p8mgYjWGfRh7+Z62FoYcsag?=
 =?iso-8859-1?Q?jVXS3aCh3CE6nt8565ECoaIbeH/GtKMDVvfhnpIvpcw8iCwqUBeN3gipdk?=
 =?iso-8859-1?Q?6e5O7UXZ791VQPh+flH+6fDYat3ygq/krmXuBJDcauXpexZdOfgWHu+sWn?=
 =?iso-8859-1?Q?7u7fnjEQEve/7QlnEzN5FDtR0mcZ/tfVoB8EKdukDNsUQCETApvkK4YRcA?=
 =?iso-8859-1?Q?cl8yMhTTJokul+A4T4CMYi7yGjmItQS4hZmT5HxCyQKhQ0NBOkLuAXjOM/?=
 =?iso-8859-1?Q?oPT39HOJPor8hGijS2veP5bx0tROLYYiu6BJMJ5XAR9xghKWsM97Q3mnsa?=
 =?iso-8859-1?Q?Yxd47lbWP8B+G9+DEYQO9l8pZfB99yJlYE7+66cEWFmoFmjnoMFfDAS+I9?=
 =?iso-8859-1?Q?a0Ao/E6islEjohgquzi9C0wxL/fcIlJE/4MlSlepUq+9I01Rl9O1KuDgt1?=
 =?iso-8859-1?Q?XEB80Z+VPbuFT5AmGuR+PBiPGtZOZg5e85Mb6sfUDsBGzwJMbPlcDlprGc?=
 =?iso-8859-1?Q?iW6eyHvxbL6AJvV34BMDVHTGN+RUQv69l1Xkvgx58TrkwFY7nIK25QnzM8?=
 =?iso-8859-1?Q?kOsGoXTgnneCtWYTdJvuhDe3YPa3dF4OTs59Q/Hg+7i1nsoFqAsmKioWQE?=
 =?iso-8859-1?Q?bztcQhV5YgCdWzKbnESUXogiebYk/mAl7qhfQe5Ni/EhS3fOIFle50Qu0O?=
 =?iso-8859-1?Q?tlLdQs8dtpFkZVLRjJGTIKHRzpNeUqBo2M61P5boB8eY96oo6b2D51aa13?=
 =?iso-8859-1?Q?7IeLdkiGjw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vor10AMi1b8+6KT/W0OMgWKKOVk/iCTHorDc/mnlrqB/3Zr4v8pTThn7VW3ZwBmFMkC+HS1duqhWPlBZes0fGtgYrD4aGzQTZI2YG72g+3nGhEa8ADPRTdOWXUIu9OTZwUDS4OVevKfadnvCP0Oj5rBpMmwxUYdaUlMmMv/e3iEiSpUyqb/LGqe1sRN2/dYudVST7hMQG+WwhSDl6xr4L9ceJVi2WHhnC6tx5+SpewYt/pxbM36UxhcmqUQPafVBojHVieGLSMa5shItHehJluJnDfIKkE4+1kIEbjeTfrd973JB27BKMOcAtQa+xIAowfw6Jx1rttAMdv3TvWLtUw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dbe92cc-184d-4b95-8af2-08dea9886121
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:54.2948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /c1dTVzsDYKUQ88w+9KWlr69+bgzLAjJAsXxE+sFAsZLDdBkp5B6B/uoa3tOxa5H+IUN1r6PQAkOe++oqTB+wDx4w0RodeFHyk8zjJKmaRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

AST2700 supports a 64-bit DRAM address space. Therefore, DMA=0A=
transactions must be capable of accessing 64-bit addresses.=0A=
=0A=
Enable the "caps-64bit-addr" property for the EHCI controllers=0A=
on AST2700 so that USB DMA operations can correctly handle=0A=
64-bit memory addresses.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/arm/aspeed_ast27x0.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index ea527479e6..a8f0bc389c 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -859,6 +859,8 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
         object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-defaul=
t",=0A=
                                 sc->memmap[ASPEED_DEV_SDRAM] >> 32,=0A=
                                 &error_abort);=0A=
+        object_property_set_bool(OBJECT(&s->ehci[i]), "caps-64bit-addr", t=
rue,=0A=
+                                 &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {=0A=
             return;=0A=
         }=0A=
-- =0A=
2.43.0=0A=

