Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F486CD5BCB
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN8n-0001kV-Km; Mon, 25 May 2026 00:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8T-0001f2-UZ; Mon, 25 May 2026 00:41:54 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN8S-0001Gh-IQ; Mon, 25 May 2026 00:41:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8Y5Fq7/89h15yKOu3Owso9eZ5AJDBPdnbOQVadlfn7nRt6Qb6CkS3UM9t6RBXuYipaWlz+OVMo9tLmZx2XFiDokkN3M6KKMZqxtEq0z4ULO2pj7t7wtBQ1uOJmzDiOmXym+/7xnBlTTpiySlg/s7Pl67TwedHE69ogUVelhasmdqHnD0JFcezM7CzQ8D9q2gyAY7PHH7FxrEY7xyLYmNTyPdDOB94c125pUrcZApgkiPcalDTfICUo+3gpYApnuKNmM3RLxBhdFyaD/uw8WeipJEpcGmmf1q0ibsU+zYEqbkhg9yHyNLWLtp+yibBVrU1l6UYwdoov/P+8AdI/Y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4DlBa6wYmg1DxsFu8w28qKP1f4lOu2NRnsXuncuyh0=;
 b=Qg9Qy0kxvtuZGwAO1/GP/3DvcAh236Yu2x7YDuCXjfQnjGj3GWLozhEORWQDgdryON/vwhgHxgZBJ943+MsHmSwtNQ76k5Q6BCQ1yKroYij1FIov0bTMzpPFf7UWGxtFWaSobKHHv/sbXq2x3UFiDwLqtQENsgaOtD8AwT1kTxiaTgyOZIp0oF6DHn4LM0lay7jnu1f3DthdY5LiqFGpEK/gtG1T7bUf6+782hFPIn+7yEQkk9UmUTg5OoIOqpyrOc3/KOzqHo9b6bWaqa6M008si++B2M4VH3BPQXlljsyh58+RSInD9LhzT2dtYHrchvDUtV8s0H80HaSFNOnlFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4DlBa6wYmg1DxsFu8w28qKP1f4lOu2NRnsXuncuyh0=;
 b=V1XuqKjIOJIklkGHHw+ZoNiBV68PNmnuxgoXHDjHN0iiiMwr1LVuzNG0JFa2mpcHDD2nSTeZERFqK3tXWUaJVVg+zcvFLLijp7xxzC/kZgck2wOrjoycVR9p+MCeuZVW5wOBCxw0QxEIZHlqcDVFsZpd82Nnq6EF74z7opwYOFHfWzxhDRt7f/cR1E2NTCEOr6Q4mafK0kWuXCdST2cStYdgMgpuPg76hUJ7faUnAesWQlCDxWMmpMYfvHE32/UeEbGEgPOCTPM9vSR7im4Ww5dYxx2mTBsqw3ahXUtcgNFWgGQaGntOoftXZdoNlSv4s69kpYufm6lSGZj5WCKmOA==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYZPR06MB6593.apcprd06.prod.outlook.com (2603:1096:400:458::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:47 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:47 +0000
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
Subject: [PATCH v1 11/23] hw/timer/aspeed_timer: convert to use Resettable
 interface
Thread-Topic: [PATCH v1 11/23] hw/timer/aspeed_timer: convert to use
 Resettable interface
Thread-Index: AQHc7ADLZWS8DF/67Um4enLFo9t9ng==
Date: Mon, 25 May 2026 04:41:47 +0000
Message-ID: <20260525044129.3133916-12-kane_chen@aspeedtech.com>
References: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
In-Reply-To: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYZPR06MB6593:EE_
x-ms-office365-filtering-correlation-id: c0040dbe-e0e2-4f24-1316-08deba17edde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: Ipe7tmna2TcDKJlPLBDG5A87wnRjcHylxxGWxa74ci7hcicDTvxf9ZxGIjNu4kasu9OriLfrKSW6dhzND+4la+mLPvgPu9ygxp2iYd2IcyNchQsBxWsrY7/vX0CiqoJ0LQ1avgPaxl70S237HQrOAFaQauBMPCUCkxnsOnzGm2NHjlCOmi/UHzsEhS6RHigqmLozd5vEgExVVLo+FGHm5PfMgvghBNnXEEO7M6qKrqJOxUAXxIl6JEsue5TLFd4zY2B0srfEZbFk+41R4iIJDsNuuBvu98HNN3b78jzdIYSdVNGgNZWj6xuuwgUtGGslF8R9vmxqww8qRE1gInj7MbqnUlKPFZ0xLH5iXyiWGm/pEzjXur9O5ialqQzVzdjQ1GcV/mQwC5hlwUZmF9nUAqkWKM/0Udi4eSJzqG5tTzrdKCCLU9aX29wuGird6Xp+xF/FtKEeTSoHzPlONMxFLfqxsgZxHfqsg6sEQHdWGthkjj0mlA+uoUiVlQW+jrlDx4O5bEqCifewUkEfm6/ZD8oQvBknIuSvsNPXlJtnR9+ikjUZkXXd6pZf6TLgQmX7+iLkQ6gIc+7CT3oX94MiBvJfayq8GdlDU76OsIyhzgcBqZ7be2FQSa1RgqsOMPy/VzYiBhrt6QjQQWg7E/3iMGYb6TNa1vSp8ksL8HcMTZmcf1IqeKXvB/wePua0VlZ3h4A3y83HFuajUxFDWEOzrfmsnLLtli8YRP807So1KtdNfh912arsdX2RoyhQvi1P+icZsXONNXoPNNHtNLHmHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cJE4x3CABI0Rd4+MPUuxj1u2Rl4pT9YvI136IHcKZL2YCJzFHSVqoRfu1x?=
 =?iso-8859-1?Q?F0s9XEs1dd4yDK9GgECoKUnR6bZ0SSbRhCXzHZJcwU6eDiGvYXwUSyv4jj?=
 =?iso-8859-1?Q?dtagF6XG3WMJGhVQZmO1sYM9yphTP6/xR0nTb0+IWuyLhgdPX/92Dnrssa?=
 =?iso-8859-1?Q?zR1IJErgjL0yaVu3Y2UzKta4B+OCo5Js7y6SzavTC2+mUQLNr/DP3MTFmi?=
 =?iso-8859-1?Q?v4nYbpyzXqU2R0ZJnshKbgomflLzEsXB8t9muIHgWzb5iuDW6n0+PC6aaU?=
 =?iso-8859-1?Q?nojKvQkFD4GvJlnzEoUu5NSBA1e1EXgLYrzDdR4AGvytAZ6/ZPhBa+NujP?=
 =?iso-8859-1?Q?uRJo82d5vkaHvY5rhxrE45kO5H2kPN2nMxc8dOgpqkQEPWlqdPpGc4SLNB?=
 =?iso-8859-1?Q?lFixl5stQeenybkVxKlXpH7xbgQsG7tEtzsx646G0TSvYBWTWfOFJi/TWq?=
 =?iso-8859-1?Q?oWK7XGjBgJgZyfNiCJwPHNgA3V0Qz8/7tRRl1tgdgqbehUTDO+D8v3yfa7?=
 =?iso-8859-1?Q?UrKSg2BOoFDJ/yIk05THC5Pe9Nb8/vJ3RCuk0CCgmjdyVzWQmTT3IjZOMD?=
 =?iso-8859-1?Q?Gtd3+a3e+NLIayJTNlGPROX2i1ncVyN1IyIF2RNUH8V1G/0OTWe0dw/WRQ?=
 =?iso-8859-1?Q?Eo4jRoKyTWvl37fa8eFHIwcS0jLRVSd/g2AOnL33ISBHDZyJph10sVqxo/?=
 =?iso-8859-1?Q?1I4qvqbuHjdNAKhgmEb+rNmpDvAWUg5i/xYbbwh3IKy9PkI0cAQtYDDMd+?=
 =?iso-8859-1?Q?jAultcpoE90ihIKxRf+FHe7JnARh5JXLSTcbilaPw8hMe7jADLDNeILsGf?=
 =?iso-8859-1?Q?Aj1QzFwjHNohOxcWjQC1o6O+rweqe1j0XJApQgTl9wY6Jt+piwdcQUdQet?=
 =?iso-8859-1?Q?Vs/OyhAmNXdIHc00GzZhP/LRp0Mtvoov47pI6+VQAI7q8itt3ROJqIaB2s?=
 =?iso-8859-1?Q?bzaIUruLUXVvyyZLkWWlFGeUuo0wTkTgeKNxBsJO0NLJmlalyGUHDtOyDd?=
 =?iso-8859-1?Q?Jaxxh5D3iQyfp5etydyzfpIrQ56rgLZjIkiPs/SgcVxnnJ+4/CpmC8ybO9?=
 =?iso-8859-1?Q?wEkPUnJE4GSTjics0A30CLgeH7EmDGMTRWCpxoCMMiDS7D5HtWf4yB4Scc?=
 =?iso-8859-1?Q?TSafjDxyGVFF+RFgYKH8d6pzQ70nhHrGz+esZCuENCJ3CHJKZ/IDwSSNmO?=
 =?iso-8859-1?Q?DbcLtVo5J3RExPxx623oAAFWCknlqFk5E0TJjBXaTGtpUATJp6Uu22BT44?=
 =?iso-8859-1?Q?reYaWoCwZcq33FqDfS9Vg8C6upaWGjK7G1bdXifyf5Y1iWm7mFQ+/UfxWj?=
 =?iso-8859-1?Q?WnKDnou3Odk2mdQrNnJpD/cc+qkKdRSE6N9fKOl3P36Jf2pubeOcfoRSjp?=
 =?iso-8859-1?Q?+unzVj/Jp8NW3xy8nefIWeVx44gWfezwuE5xARdtq8m4plkS1E0VumP6eg?=
 =?iso-8859-1?Q?hVEfRMdrMSEJlqTw+IG7DApXbClxrMcjmlV3vCvLa4YfVWo+4bj7SxveJp?=
 =?iso-8859-1?Q?1Hai3uDFl0cHy8bxxmJiVAvd/7JA37yyzMftFU5x7JSIeGXG34fbdX1poF?=
 =?iso-8859-1?Q?WczYpD7nFaEbuU8LkSAZZqhuFk7FS5GudzxqFIVyktG4DJ41bw1Tnssu8D?=
 =?iso-8859-1?Q?cVuMt+CfL/za+1Xz/Dvt2rCaVqJihxd+sOVMkzDzoQ8nypQKhMsuLYdJL9?=
 =?iso-8859-1?Q?IjQFAdBUEWjDCJ2FFUtsh2pIOrSyjOpeMSaj2OKI/M3qlIn/pOX2CI2mKv?=
 =?iso-8859-1?Q?VBVQUBQvIvIrSzYjtToNIqJyJgMpt8xW1jkVxT/BA1vJPaJc+Ttznqn0Nk?=
 =?iso-8859-1?Q?RM2e6Z1hQQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: bLCQNg+HIGR8/BSSwzc5A1XmkTR0Xotk1jQzuNku8r+Gw+faDiblAfC7ST8MglzLf3q9TiunBECDxMb5RpnQdlM1d+Djc0LEO0m68XoC0cKRaDSu6F9AXgUjp04beYt+QlpJiiwmz9OG8s+JrxCTAzknRf9oNgHJvYHVuZ8QHwBgRn8qZPwZQJl47BvcUVQisu04VVlABnKUNrPqy1VQwf2s8+JtHu9ytYllHcj6jrZNYrtQ97cHED3kRnksCMZvNzo3bUQ7Qu8O3d4KL8L0yBHkZ+0QlHafRxZ5EVD37+56Zyy2FrDZcfJl2nanMGg3EzdRPNVwM6Sy+30U4XsYng==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0040dbe-e0e2-4f24-1316-08deba17edde
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:47.0608 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xuuR0GNMkZRSQZcXlE1ZiZL/G5LZv3N17SN/QZC6eRk0xCdo83g0y/xBs9z2CdwXdXhbTLqgwOSFfMLDID43CvLy5j+BMyycvHuHjFOHvEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6593
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=kane_chen@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
 hw/timer/aspeed_timer.c | 7 ++++---=0A=
 1 file changed, 4 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c=0A=
index 1e954f7aec..69f5c89215 100644=0A=
--- a/hw/timer/aspeed_timer.c=0A=
+++ b/hw/timer/aspeed_timer.c=0A=
@@ -834,10 +834,10 @@ static void aspeed_timer_realize(DeviceState *dev, Er=
ror **errp)=0A=
     sysbus_init_mmio(sbd, &s->iomem);=0A=
 }=0A=
 =0A=
-static void aspeed_timer_reset(DeviceState *dev)=0A=
+static void aspeed_timer_reset_hold(Object *obj, ResetType type)=0A=
 {=0A=
     int i;=0A=
-    AspeedTimerCtrlState *s =3D ASPEED_TIMER(dev);=0A=
+    AspeedTimerCtrlState *s =3D ASPEED_TIMER(obj);=0A=
 =0A=
     for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {=0A=
         AspeedTimer *t =3D &s->timers[i];=0A=
@@ -898,9 +898,10 @@ static const Property aspeed_timer_properties[] =3D {=
=0A=
 static void timer_class_init(ObjectClass *klass, const void *data)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);=0A=
 =0A=
     dc->realize =3D aspeed_timer_realize;=0A=
-    device_class_set_legacy_reset(dc, aspeed_timer_reset);=0A=
+    rc->phases.hold =3D aspeed_timer_reset_hold;=0A=
     dc->desc =3D "ASPEED Timer";=0A=
     dc->vmsd =3D &vmstate_aspeed_timer_state;=0A=
     device_class_set_props(dc, aspeed_timer_properties);=0A=
-- =0A=
2.43.0=0A=

