Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CF0CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 07:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGtkp-0005MA-Dj; Wed, 14 Oct 2026 03:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkn-0005Lq-Ql; Wed, 14 Oct 2026 03:50:25 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xGtkl-0006xt-Fn; Wed, 14 Oct 2026 03:50:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zewa6LSOwU95JbmT0Dth7/nW5nvQveTBbTehyXHB8AMUeNZ7AyyZUAgz7yLLSRJTvdgjFAGjBfB+Ro2yDguiXfQQUc5mXwlNJz+T4zyqPO7G5eriGtBLv64/Ma/rVn44IVoRXoiZOOe6SgQ+1YW5X3FMwkJGhrOh0NpUp9GwXnwXyA6ckhXiPjSg4SFhjKGcaYHKlZNlxGBtoqvJD24bcxbCosNTNF7SMOXPLaRboYIQNk/aS3vuuvM7DjYDd9SYx/V1mnjEwWy/ofScata9iTRn+bY/948uonJJ1ffclPNthscfX4oM05brjoDZH6qtrQpI4MURp98+b9v7W/OZ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U23PJIr2zCrBIIO4P8/Pf2Wi0Fn8XpWOLAS+gb5zWYI=;
 b=fHa+q/JjoCrjwM81rvG5vHzi2q5YNhfUO1pXwOg1v+yp1HISSqHzhadZ5S4i4iN6Av8vW+14Hj1VIypMh2gRZlJxQu9LC4o1Zmu2qL1hOZdO2qXk94KAgsC95+y59331p8f0Jl9f9jK6Z6l3E9NTbEiyKGcYSrJu4iJ89jmmEGkV5hLEN3G13EmmEK96LkR18TKT4qvJMqRasEGaQE4Gp5tNvhspzo2+vKlPP2StRmrQ41bJ8uTR1Y2EMHyrhGrRyAYnBRYFhF5gLtCwcnwQUvpMXHtQUlgzs852TOTY72OtRrU1Zh49qWN3aMUXhIxJPcP5YYjrw9dzvrClCsAgWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U23PJIr2zCrBIIO4P8/Pf2Wi0Fn8XpWOLAS+gb5zWYI=;
 b=EVr80m5UKlQyL3xsLlcYxjxFfCpdiYCjz2eWp47fZKPf5SvGM1ZYm5NwzW1VJiQ/oZCRWc0Ko+ajrRYPKQM91Ib0x/TPMENf1zV/GuD/j9QzabZ45LI31C+y746BCtq9qRVp6YjcjzTpTm8kJqueHbC29wla8ReBcGY22q3j1unw6oJQ0b3WTHK1dHbi8afp0XxNrxIGQX9Ekn2s+gGb2XiT1XfQ57pIp1pf32ytCQJ5VwGcZtm7/y3tD4WvZQbPlAdD5Giit+2/UMGNBSlcGwrpDqEOcOHpxegOeMLRkTV30/hln6WRzhRCdJ4YkBNtk5DkCu4Yqm0uJboRxzdH+Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SEYPR06MB6864.apcprd06.prod.outlook.com (2603:1096:101:1b4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 07:50:14 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 07:50:14 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Topic: [PATCH v4 1/8] hw/usb/bus: Let a bus opt out of automatic hub
 insertion
Thread-Index: AQHdW7ClYNODJ6p7pEKRIESbavdnCA==
Date: Wed, 14 Oct 2026 07:50:13 +0000
Message-ID: <20261014075011.2708115-2-jamin_lin@aspeedtech.com>
References: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261014075011.2708115-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SEYPR06MB6864:EE_
x-ms-office365-filtering-correlation-id: 4e436d66-e58c-4a81-6e4d-08df29c7c869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|22082099003|18002099003|921020|38070700021|56012099006;
x-microsoft-antispam-message-info: nTxjEl8umNJUkMwLF+979Gupr1XTl8k9oH3iFErMNBz6u9jsVQ5N8uXYpBNrb6Wb7TRhJrDCc8ufU3oR8pdj2Elnwsq9EIn8pb6LidO/urnJFTQ3OtPqyJTdXuuNJ131wWzz4FX0qmM5G5b2iMXn+uRMSQxm/2ys3JISmU8whullis6ypkGSKr0wWMXcajWh7oJTlkwiW7ySw4zye/2hEr6WiYcyAd875u0gNQnZzr16MNRjLYVi+NOiXhzix/VT9ac4Fr67y/1sykXCyzVh9q69Cr2c0pEQo3WYfqxggip7Hr8tERTFeU0Le3s7NmJPJBqdHHEmPIHD9EQKD+eTKN1y+si0eiIhudnQb/B4iYAdZNCQEMfWdFREUjUpo953cQhwQqbEcLxDjMlfx4Oq42TZS1IcWUApd/GLc7zfpwdUKEhRDA9p8urh1hVuA1QROGu2lKK13EUn2gBeOI2i15eTg+kIvAA6xH+K8G+U+SP1OOCKGsAg4MMq42Jy7ngofgMVQAY/SuN+cHatw06ORI3ZG31fliBxbEpo5qbn+qi4a89a/FN6Wyj20c6wxzCZAOWHfuS3X41kjdLiV73tiXwAiTntoozCOwp0etUYepXAIP3v56fmhvXpD7wAafVHZYLze6iP72ePoowNp0YUwzVtT8Ctx5zOUrYKZi3Tl/DMgsoRS1Nf2NseS18OSNZb/TP+EFz76cZ78Ho0iqagRb+T2jDyvRDwpFmPXMIRvr2Pw7tIeQbSQml/O7nBIF9T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(921020)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kR+2+AJaNXDR1tOlB9WRZCkxZVooCkoGpaVbXa0nDJwS5Tx29UAqluzBXm?=
 =?iso-8859-1?Q?IVzA15nQF/dfRHLIapHYyi+ppFC4Ve1whiBwT7GEol/J9EZ6fj1LCYxnKy?=
 =?iso-8859-1?Q?huepTmDavxRGP8Olbknhs6bT+oWv2CPoifaUQo2B4ovvNeSYYuK9oPl9Z1?=
 =?iso-8859-1?Q?32ame6qvEzzAnzjNz3U1lfTQMJtDp8ZQc42meBm2Mi3KVHUHm09DZxDSbU?=
 =?iso-8859-1?Q?WMc1F26X0OdKgM2tvFKkTgkLGZK/a6BXwOW8XdE4qmaccZumm1JcDBGGAi?=
 =?iso-8859-1?Q?ZsTQ8XnoevaD6zrO5VEi3ATRKZnYhGgggwuhOj3A/61mdR27U/F8NGj/Qt?=
 =?iso-8859-1?Q?touUfl8tz7FqE+ZDwGM7RNiTZpX0t0I3dYFQ7jyy+n5T70zje3+72ik04Z?=
 =?iso-8859-1?Q?yxoD/SxneixJl9rxvy/VG2fi3/orzdT3BO6Jbu71rkOJAxsSoUUoJLF7i5?=
 =?iso-8859-1?Q?wqmSt7i49r49cUhl7g4Y0JNUJ34gYahCritMAdus54rIoYmbUq5thyzbrR?=
 =?iso-8859-1?Q?R6eEQkrIES1E55SwdHHaa9QtD5/lBZRk5WmOW3xqPqg/brgHRmEVxFUxx2?=
 =?iso-8859-1?Q?4A/rKphb/usQDGPCNEbj1iWFlqEgTOX1ZfL1EFSakUsCv8rjXa+ohX57Q9?=
 =?iso-8859-1?Q?zvJfAI3u+nznYhsukrTYaurLyiXioN8+xeGNo8egqQaxeEKPKsqDqhcILZ?=
 =?iso-8859-1?Q?qI+w+gdqzfvB5a2Kal933Tl5lnpRINX/y42Vm4pBPXHKZG1GKlQvZxKDEt?=
 =?iso-8859-1?Q?hl0gGTI/5RSBpCAJrVYtlLECabm6oDbTt0OtQ298er/S+D/SN80NTyPHni?=
 =?iso-8859-1?Q?7OfsyxrW7Jx+m6/Uj9oLk1BWy/uKxjQRS62nWKBU+U2kLVbLgiqPBzNslK?=
 =?iso-8859-1?Q?PwQYiBw2DzplJzIXfC/mF3WQx6PerZFgmdruezsfStfm4U0K59y9IWAZCV?=
 =?iso-8859-1?Q?GhqSJ1wFAynRrh636Dace7lTGo2SLemtt0v6QRaerJhhqHT6f304fU/E40?=
 =?iso-8859-1?Q?l2yXCf2uy6C/lxHK1qEt35uxhfTSkS3hcTcbvjzuoRgjar1K9W1CI/+8L9?=
 =?iso-8859-1?Q?oT9mVBrjqK9jEDrWAYoG5lMC638oSTkU/yrJqdZwaor4Vd89JG67xsP6g8?=
 =?iso-8859-1?Q?6z6Sm/6TNDZEheSDD8vtypOehiRnB6KjxWDJYX68CPM4PWPbjRQ840Moam?=
 =?iso-8859-1?Q?0Munu2iLUGv5jhTG3q1bSiWfkt43bBToWJtC/ffHCh4AOzW+mqXLT5Ute+?=
 =?iso-8859-1?Q?ePnl90C6fWgCsmDx9vR52rT2s9UYGzjlBcCuIPNUcZUBF2+SNMhURv3S8H?=
 =?iso-8859-1?Q?yoCxdLiK3l+N9vqy4nXWyuNqtstYcX3I2ElIxnUL34bZcJet46cM+rUbja?=
 =?iso-8859-1?Q?MBaX1bZCaNngkVk88Cv/+FOY2hi2w2uyPfoFzYG9myUYBtk7/evUN3oL+t?=
 =?iso-8859-1?Q?NmQZ6WxUEkmLGtLROMd0D6FIuyBtnTah2eFJVX0eDyUOsG+IfxpipHq4Fl?=
 =?iso-8859-1?Q?+wop4VUUJUjmrrBp9c/713Hhg+uKo0w1sGlvbU0wcrZoWvsJxKIcGzVat/?=
 =?iso-8859-1?Q?T0h1FesEMSOzqhT6hSCNUUrrQ31Vsxl37rw3s0nZWadhEfAk9aRQ+WZ1ra?=
 =?iso-8859-1?Q?g/VKDjqJxzaGHdsbPh5A2Y4Zkh9W6n6JW9Rv/Y1CJa9LKj0C5kxnMnAOIr?=
 =?iso-8859-1?Q?EIODTDY22wPoEwR21VpvTZt1dmMgCUJgZ5sttnQ8MjBJyPbTDd7GnvEWK3?=
 =?iso-8859-1?Q?M6YUzjDyWMbx+MADh78pTopAky6Z8mUqt3C0NcYmxcWyLMzz92vPENYOL3?=
 =?iso-8859-1?Q?kwKPOR+uaQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VHHH21oQaON9pErLaYPQQRpOnQw7xYEhZgpfiGQQwvZbArO/jfMKsmT351CWjGD3Iw0Ivw+E1B5UAWONCsH1IMwHgVmPQUpEicaNuckNHpI9Uk9jN34zsY9iWVKWHj5twwc2vt2vg64So8RG3EeLQxIEz495HnkYttdN11Sbab3tz1eWoE5FgxWfvZU2Pmh/o+vq0kLKt8n9Ahsg4bPtDNuWDfE4kDMfa4QaIFR59KjcUvLIPHwUdYXjMaBe/Iu26jt4dG9KJM4zmKmwXyBkAlRAaQcf3USKia44+UHQygQnZudBinkC+ZXpkaYKZvUXjrVo8V67CCeYTSlb3jGa8w==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e436d66-e58c-4a81-6e4d-08df29c7c869
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 07:50:13.6388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LvTNsTzIZlBb4gCll4KyJIp91g9qLT68zkSy/QNbvHJHruuqbyyd7no/pHHXYI1p4f3E6htOepHcekDDq0FxBf95WNmCeKuIqkAOhOENzK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6864
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
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

usb_claim_port() inserts a usb-hub when a device is plugged in and only=0A=
one port is still free, so that more devices can follow. That is what a=0A=
host controller with root ports wants.=0A=
=0A=
It is wrong for a transport that carries exactly one device. The hub=0A=
takes the last port, and the device that was being plugged in ends up=0A=
behind the hub instead of on the port the controller watches.=0A=
=0A=
Add no_auto_hub for such a bus. It keeps the ports it registered, and=0A=
-device fails with "no free ports" once they are used up.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>=0A=
---=0A=
 include/hw/usb/usb.h | 1 +=0A=
 hw/usb/bus.c         | 3 ++-=0A=
 2 files changed, 3 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/usb/usb.h b/include/hw/usb/usb.h=0A=
index cbd4711933..ab96812adb 100644=0A=
--- a/include/hw/usb/usb.h=0A=
+++ b/include/hw/usb/usb.h=0A=
@@ -484,6 +484,7 @@ struct USBBus {=0A=
     int busnr;=0A=
     int nfree;=0A=
     int nused;=0A=
+    bool no_auto_hub;=0A=
     QTAILQ_HEAD(, USBPort) free;=0A=
     QTAILQ_HEAD(, USBPort) used;=0A=
     QTAILQ_ENTRY(USBBus) next;=0A=
diff --git a/hw/usb/bus.c b/hw/usb/bus.c=0A=
index 5cc5ffec33..8a24b1837a 100644=0A=
--- a/hw/usb/bus.c=0A=
+++ b/hw/usb/bus.c=0A=
@@ -413,7 +413,8 @@ void usb_claim_port(USBDevice *dev, Error **errp)=0A=
             return;=0A=
         }=0A=
     } else {=0A=
-        if (bus->nfree =3D=3D 1 && strcmp(object_get_typename(OBJECT(dev))=
, "usb-hub") !=3D 0) {=0A=
+        if (bus->nfree =3D=3D 1 && !bus->no_auto_hub &&=0A=
+            strcmp(object_get_typename(OBJECT(dev)), "usb-hub") !=3D 0) {=
=0A=
             /* Create a new hub and chain it on */=0A=
             hub =3D USB_DEVICE(qdev_try_new("usb-hub"));=0A=
             if (hub) {=0A=
-- =0A=
2.43.0=0A=

