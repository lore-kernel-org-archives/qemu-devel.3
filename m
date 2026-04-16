Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477D4F433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsB-00083O-1h; Wed, 15 Apr 2026 21:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrb-0007qo-7J; Wed, 15 Apr 2026 21:49:52 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrY-0007PV-L8; Wed, 15 Apr 2026 21:49:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0LydYbU3CkGTMCP7rDkFVN25QUACx+og1mR65g3yk2QbqZRcsYaQz5Nb5P2BGrNePYNY7O3jOEuu10InM0ivpQmtU8AC2v1M21tg8OANL99AqQu0a799UrwBdQPTRA1qo64JQkb/iYlh4egm82WtFumw/8Qau8yl5J1tLKhxTu6OiEMo3aS6+Qvrimx8cmFMo7k8Oh73zwH6DK8C5ryYGtYwA72aiSU0SOmrZfa69mIzitoXOz/enRJOvAlJveB+lOmCmC54508InRekP/wrC+p9rTbA7/V13lZf/cp/sG928OzTjc0JYPldsJjptGwDF8tL/JzsATP5RLMWaQ9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTu2IAjLcue9nOqgFQF/jmkPRZ3iMUww9o8bDsUQs40=;
 b=cEAgUOcnNdzTgstwXRDhmPYpSKrPHDHbwDQFDVLNS1EfYqaK9QnTSSwWyThjbJVpUj3BTpw1VuUkupOsXQTpSESdS/ra49PtsrgnqUk7GvfPKQH7lZtl+HEPpuW3RcOzJGpvnq47dcqNiVWt7VPtkX/a0S1jQGSNBLr8DWASg7PwTRZjGuY6euJh5HAsO9tm+W3y8XkqdfeMLh1K404emhx2sf7BMnDf+3/qwnirkRlkNCSq5LUKIcjZdxswSgyjU8FPxsJD9FT6pM7O3NtK/Y7RnSe+Y1jNP4lD4Ux5vZwlgYFRRpWl75RW8oUACzQvpdsLWLfS5f7wJV1ry9nZjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTu2IAjLcue9nOqgFQF/jmkPRZ3iMUww9o8bDsUQs40=;
 b=PyMLC+skWG8fTSl3t9JccB7RxZgXq262DKbAD+yGzc8AwnRFHyjzcfBpzjbUt1CZSzY9SnFQ1VXejsv4EzVdZzS1t+q3uOr0ndup/acTuzX1utL8F5qXREOIRNJA2/13exbSYW57ubJf2zg4Ci4ugB1Q40g8WmHiWC24Vk3nCBzGf1QJZvTvDfq6f9ieTC5STPx9J5Y3ChURO/xGZmHxE9rjOMSOvafg7xajUv3dGUzFThLnRb5PxkcrKylEP7AAr0f2kjipb+94NEtz2rgnsMDY1as7gxG/dphKCNiEAFhoSYaqqpuRDXwXpBXqy3/NKnDKWtnhRl1gWDFKSg1oDg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:35 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:34 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: [PATCH v3 02/17] hw/usb/hcd-ehci.h: Fix coding style issues reported
 by checkpatch
Thread-Topic: [PATCH v3 02/17] hw/usb/hcd-ehci.h: Fix coding style issues
 reported by checkpatch
Thread-Index: AQHczUNGYl5hzRkyFkqgF8waUPXciQ==
Date: Thu, 16 Apr 2026 01:49:34 +0000
Message-ID: <20260416014928.1279360-3-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: ae947cc2-c5b8-4149-d448-08de9b5a694d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: UtLIKEuAau9Oxh0FOSyul3VOHW/RwWTraZDXETcLEogPaIemnNQNs/vmh9HaLnRXOnhewNctNhmV+yIsKp4/FGDzlRf5kR4Q40tDDvfpr28/UlX8pbkwxsTxHuJi1q/2whmez3y7QTUtvQGLs6tm1C5B5CirBX2oPQ5i+wS+h828ERtI03mOhppY+gQ6kextPFBg4hRj7M/KE4AF2qcTXOr3BcWo2bvc2hDKXKSQGsDi9NHHnCocCIEPm4g+5dnijMQSUA+Dikx86racVDu1rZXUTMsKSlnCotfCCCNgtkvvnkn2JGkFwHWp+7JTVriN8S//HhymLHKbIp6KxF0ZT/5HSrqOQ7lF0fSeiNy4ZfXMYamu4QqRj4zsuEGXHnNGTdEwRG4RreF6zkcXxh8aW3QHPQbuL+0ihmBzu5jMihqZ3vdQkrv+ooTTHRML+AAdOy/pcjZLhxJaTZoDO17ES2+IHyd3NORlnIzt+oEmVuzX9jcrTSmK/pmhsTx4/y8XPtlF6vt7BhKbTaqFNHsNCFb2ALYdrr5uE0WNgqzQxNMNlhUNGAHQpmfD/Jg/oxzZEpyZysXmbDIPM/FFky7CFcRyJSTp5GLM066wrEuy1kL1fAct9K9ZJ5cukvWjmRrJSPjTu7O2jz7I+nD5DoVA77s5hWurgzZnOt75KzdRMiyohD5AS5lWpKcwuZCkB/LxKfv3umJMCB8XAXuFfJy8a5enatg5IwU7pHrCHb6faWuZOx0YKVVob8RfdEoyAXL+BY1Rcur9COfej2/3bcoGHy4Cb2QdEL51UOhFmXOjPQ9wtkwYu9oMxTUirMQnFJee
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xm2aKTOdxBsmb2aZWdoWaM5tS3yWuj236TP9Lm3d9OjlNppmXb4xVnEFY7?=
 =?iso-8859-1?Q?U2/uMt/ttQlljIZgcJX5FgrjWmbsaTkyrD5jpk9y2N3MPaRhL5H4atiX4s?=
 =?iso-8859-1?Q?+gLo8E5KhF34NhAg7Qx3ds7fhmauDqZQw5g/cUgCpvnLQ+/+MtG2OVkCvk?=
 =?iso-8859-1?Q?vCea4vgct0NMh/BnTl8ryZH4V5THAAfhu6F3A37jVNitUTRAoGq+nGTBFW?=
 =?iso-8859-1?Q?V4FdXGXG+PcAdsLCo/D+y16nLcdVCOYxknTbMtrXEi2uysZZQuLFujojrG?=
 =?iso-8859-1?Q?mwB1TAO4ALXj3vc8R7f6pcB0cwaZtPhmfrNZdjqdUbzjBe9T2Bu7fgDrux?=
 =?iso-8859-1?Q?s6iXwdsWZaf556YqBhU/os4jwm1TLU2DIxwfgM4J7LOgBWylUKnBloZ6ZF?=
 =?iso-8859-1?Q?3tujaggTktXrnVL4yxGTHqFTJp/bsjgBDsSIQPA+plaI5R8zaOxhAWXkLQ?=
 =?iso-8859-1?Q?UmYuNSyIbNcxX0msmPc0HZxeRKlbCU2kkC3CtzjxM+f281grODdw9ktG6X?=
 =?iso-8859-1?Q?t/Yab8ostw2VMou6gPlOdh6FIVQkLH8YJVRiOpy0Ss12Ba3tBFM/genrHx?=
 =?iso-8859-1?Q?bC1YgVNcGOvXEdZOsVCBJBvrLW6C+Tb5rdPzLFexrFMd8VDJNRhho8puW3?=
 =?iso-8859-1?Q?NAgtadGvC5Sy2L9IpBI2lNtO0AM6rReQATp8tkmlVmhJNWJNzIqvue381K?=
 =?iso-8859-1?Q?vkkDcjFAJrQ+BZ/OSJ8ZYLnQKdoWDozvMGQgeUjpXjt3BRWxBbIEjNfkkp?=
 =?iso-8859-1?Q?Qy10+a4zXzU8v0SO7BDOk7tbmHcmH6ydKgDT1CHpsTPf+wZ1z67WhUaPi2?=
 =?iso-8859-1?Q?pse9Whj5MqsWKb7YBC/zRP/qvAoYz/FrOcDSCbNU8btZTCqSuqLKeoGVl+?=
 =?iso-8859-1?Q?eGr5uoIBWc8I4J9VnNhxoaoMi+LNj4uFdf70A9tgve62WHSwgUsy5cXbwj?=
 =?iso-8859-1?Q?Rl9Z7smCYYrnOM0a0Cdh3HpqDvogHm1TUucGDy7hwxYBoXQcUt0d/RN4cl?=
 =?iso-8859-1?Q?sb+ZIeJXOUJcWkNN6eK+fxWdkHZ/w5sDZDXndKEBfSghjkNNg7lbOCIYID?=
 =?iso-8859-1?Q?9G9rVOQ2XXtz/ea2EA4AyBoeHrYwH3NKVMqJHRxYqy1L8AV12ucckGkMcD?=
 =?iso-8859-1?Q?X38yNwS/tmOk4Jy8LnSLAj+l9yNuq3a8SaWLefFCb/8C9T42RNSN0DnLGd?=
 =?iso-8859-1?Q?1PqaLOgzr016WqGA7deoFAOmn9jhOyIPcoptW85oz5qMNdvNn7njQ85Wdc?=
 =?iso-8859-1?Q?4GbSBBM6SAWYSvkWTB9A+GOlQoObuOYGh4ISPLmTQl2YY5bCQKvDV6X9bA?=
 =?iso-8859-1?Q?bEM45SiAW4WOF4XgYL6putNlVgUZ0JdsSCpTAyvFWbw09J9+KPtKHW70v6?=
 =?iso-8859-1?Q?cY70unm9SsN4un3tTCKsOZWr2yY53J7JTjAnOauRHUHsVMBB4RvAVIb+uI?=
 =?iso-8859-1?Q?BmYhO6oyFc2/JeSPeKgrDSfT9SCyOOBkNMhvTcfK3qo8MC5x+f2dYKt2Lk?=
 =?iso-8859-1?Q?0kUq+4NOsJ6nzQkWBX5JxWL2A2q1EvnBIhEVMGpA0OowrZo77U2oWGzpbF?=
 =?iso-8859-1?Q?4ybng2KwVQedjpX8a1hXj7A5H7LCxRqdLVfzlz1vybqcv/fO68+mdVjXZR?=
 =?iso-8859-1?Q?2BVZ4lrc+Banx0JHDG1utIoAwjsyP4SOinKxgqenZqYW8sM9bKrkHkIZJz?=
 =?iso-8859-1?Q?kHnW3gsI6S7IyEX0ZRzHGQ4qliQ/6tWQu4JOkX/RyNlnvsNgBz2cLVo2LE?=
 =?iso-8859-1?Q?KXRNzym4RoHJooWX4RkxGhRWedGEGR6/ZTC9cvYRK2MeEqyL8QRX13LcAp?=
 =?iso-8859-1?Q?ZvfJx9+rtw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N+L4ZcsC6dcldyhNVnb3GUQKqgjwVUTR0A6QOkHXKoJU5BYuhjhU7T9adzDxj0KRm+uVg/8glCT4D3Vm+RsHV8K/KehcsBcUmj/0F6cM9e6hneY8WsZEhcwfWNBodkrCaeIyBLHqdkXebC8bWPu1ISCH9PGIDkPTu7zIu12Fuo0eVJ4CKIv/w2o4UvDuGPLqhmOeKTZapGWlqqXfz8HgG2IAy5dU3E1d+Zc4G/iIlu92ss5pDBlRwvkzyqurBJ/4XDCsvKO20SQZs6KmizC04t2sAXiM7VUQvlqov4lJPNMJvuIROKcCTpnjD7u3lpiV3cLWdKZ27xWP5VftDokFuQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae947cc2-c5b8-4149-d448-08de9b5a694d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:34.9148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jA5+qeOKFuJM5b+KKBqij69sXmqrbjtF5inFzem2A5yyP+MujqYwpeTW18O3Xv2FQ5cJEu4Y1dnFxq+pDhx/Yf4zxvdnjCo3pZA7UjeS99Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
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

No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 17 +++++++++++------=0A=
 1 file changed, 11 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 3aec0e047c..736407fd52 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -43,7 +43,8 @@ typedef struct EHCIPacket EHCIPacket;=0A=
 typedef struct EHCIQueue EHCIQueue;=0A=
 typedef struct EHCIState EHCIState;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.3=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.3=0A=
  */=0A=
 typedef struct EHCIitd {=0A=
     uint32_t next;=0A=
@@ -74,7 +75,8 @@ typedef struct EHCIitd {=0A=
 #define ITD_BUFPTR_MULT_SH       0=0A=
 } EHCIitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.4=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.4=0A=
  */=0A=
 typedef struct EHCIsitd {=0A=
     uint32_t next;                  /* Standard next link pointer */=0A=
@@ -118,7 +120,8 @@ typedef struct EHCIsitd {=0A=
     uint32_t backptr;                 /* Standard next link pointer */=0A=
 } EHCIsitd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.5=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.5=0A=
  */=0A=
 typedef struct EHCIqtd {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -148,7 +151,8 @@ typedef struct EHCIqtd {=0A=
 #define QTD_BUFPTR_SH                 12=0A=
 } EHCIqtd;=0A=
 =0A=
-/*  EHCI spec version 1.0 Section 3.6=0A=
+/*=0A=
+ * EHCI spec version 1.0 Section 3.6=0A=
  */=0A=
 typedef struct EHCIqh {=0A=
     uint32_t next;                    /* Standard next link pointer */=0A=
@@ -230,7 +234,8 @@ struct EHCIQueue {=0A=
     int async;=0A=
     int transact_ctr;=0A=
 =0A=
-    /* cached data from guest - needs to be flushed=0A=
+    /*=0A=
+     * cached data from guest - needs to be flushed=0A=
      * when guest removes an entry (doorbell, handshake sequence)=0A=
      */=0A=
     EHCIqh qh;             /* copy of current QH (being worked on) */=0A=
@@ -268,7 +273,7 @@ struct EHCIState {=0A=
      */=0A=
     uint8_t caps[CAPA_SIZE];=0A=
     union {=0A=
-        uint32_t opreg[0x44/sizeof(uint32_t)];=0A=
+        uint32_t opreg[0x44 / sizeof(uint32_t)];=0A=
         struct {=0A=
             uint32_t usbcmd;=0A=
             uint32_t usbsts;=0A=
-- =0A=
2.43.0=0A=

