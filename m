Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C72C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOro-0001Ec-A5; Thu, 13 Aug 2026 02:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrW-000187-TT; Thu, 13 Aug 2026 02:24:23 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wuOrV-0003Ho-G1; Thu, 13 Aug 2026 02:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ge0eD5dO8y9SG057jvOIgOkqAHvCOy/9O84IrfZU6ra3iG5iHhJdkozutJQ35PDlHJ0QjzFOymkDs2/9CHYdgPNQbefFbxwoDb6POuL62aGeAPL+0Ti6+sdZLrvQnijQJ/aXgVcWcPJR4faEvYF7AYyNsZUeuKAEDlA3k26ddV/4vFsh7yqQtX1MbEXNgXqTmiw1FpLq7hWH37gYF5Qy5DHOU2TqwDZ3XZpnzfRV6WWDv3Jmr/nULDQYzBPH8VaSMO+EqQe3XhAZ+Yss6hVgXPWZ+m9bBCs5SVzJtsABPqpyUbWa+x81GXRXWOoIuTMh8nE0wVmvAWE+b7P+z5zksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKDIUhMBlIJccABX2c6Jkouipk5ew9JyA2h1nKEvWl4=;
 b=vMH0IeiU99QV5O3GtzQRhVUlNdWMpQnGPTCL6n2PNcXRYc9dtBkTrkackVOmV6a3gn30B1ztYIHeO1bPnOOzWXN544Fhv2tXjatVVEaQ+TtybkSPzW0k11IfiD8hiUz1eRzC2psOrMOt2njBU60v8qVC6Rp7TwIFdVQ+xw5QjwA9G+kv+7YQQv1865u6utlJ2t62xGuKCeRZWpvS9EHiKba9F58khckFO2yMywtwn++Awm3sFFNkPOJjVhi1Ley2DM9VsDM2Q/Rkx+1E89SskMtb1h4HdCRmhK9kHc013C2Ml38ZxBw/0C1nuZOk4TBdwQwI6Rt+DFPQIY8ldK4F/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKDIUhMBlIJccABX2c6Jkouipk5ew9JyA2h1nKEvWl4=;
 b=mPVeFN4lfvrTqzmrflaaYeeWr/5lqsyt5ycGli2O68gnk+ebBCfud6TKlvEWOjyvIVvyADjRIvipCk37ctI1YClZybZGKXk4JWL/oJgZyXQ0lowHBSmnWC04567v1/7UFfnwHN0xv+iDPyzI2grROc4rKjBu3Cyd3aw38bLFFKkjGzapa0XgbJQu0in+TrbyIO6XQ/2KzZY0GVfsH86sDqRu9wjjrgozW24puhFx/HnoJAPrWBTgm34DDf3drBKHnHIwNfrLbHFgDWfasmgw+ZS+SkOu0MAEYDXbbGEJesSNZSjRCl70VNwGBDP2Rb44tsZi3Cv5RZgxi7CB943rYg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF56FB370CE.apcprd06.prod.outlook.com (2603:1096:d18::496)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 06:24:05 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:24:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/5] hw/arm/aspeed_soc: Add the ACRY model to AspeedSoCState
Thread-Topic: [PATCH v1 3/5] hw/arm/aspeed_soc: Add the ACRY model to
 AspeedSoCState
Thread-Index: AQHdKuxXB3MNmnWAAEybbVlPXSYo1Q==
Date: Thu, 13 Aug 2026 06:24:05 +0000
Message-ID: <20260813062359.425268-4-jamin_lin@aspeedtech.com>
References: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260813062359.425268-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF56FB370CE:EE_
x-ms-office365-filtering-correlation-id: d87926b4-bd35-46d8-0af1-08def903798f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|1800799024|38070700021|56012099006|10067099003|921020|18002099003|22082099003;
x-microsoft-antispam-message-info: FyBFG5dqig/uw/mdwPQ8lUQKvmalA0bucQ+ChWfcZtYt/at4JIKH2cuolwqsDgzx0JFLOz1aQHnc2Xuc6LTVFze8fIru4X3KH6mWirs2AptdJD91PcdJWrxS35riNaxed0pJCXw9Pe+Hmpu07gi1GmPG8GdU6eiooi//pLdVsZQhZmsGR7+sBoJ2VjVXOpwHluNKWH/i+66ZqcaQuiYyCyc2UUXfMjwNAPp7ENVusWMvdNf9VfF0HgGCv5V6jJrL6Yh8oAZCAZECp0QYsZYpd3DHgNoce2E2z4ed2Gn2ZF0BpFTAmn+aO4RJNf7aZm/tGezWGjW75AHAdYb05lxfnh3bFjicmX8kzZDyX/yLsygoeDvvGYnfhCfjLwi7VVMos7x3If6SFRLn3C959NOQ8epBI/o+e17gWpFLkPGv4h+t8wTibNc0ZvQsjYvCufKpnaKHnvZnsqe1zwmUVVFCOCyg3Lr8rW7vO8eyYG08WmpZmgQ/Oc0YCz555zpRuREHVVsTZsz3YLSS8gDembAHXpwYd/AJUPcxuRy8/ZEt6nCpulbxrisqqdIcNb4pNTgGuMWL7i7Wl8kIOe9W/wH/gaJIqBn5hrg9AzKG9hJKHDlLaCcup4FypOXwUoYIuKhc36xio5F8PzA2uozsryqgjdQmoJwVDSV/5q0EXUOrHzRp7uhbDLl5p/0yNJg6czLHP713fuqA83xY1FEac0AG/0BjhBSh+AB8c9wPLSev5Y2tzB0f+ScfcRtLlPVrQB0K
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(38070700021)(56012099006)(10067099003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ufX8XZe3HC9JK2mKXCX028lQQkPtZvupejCARyWF1PWbHB5VRo+DSpSLma?=
 =?iso-8859-1?Q?w/3WFur26VKv9I2UOeVwhG/39FgyvfiuaH9aY3yZ4OmNz3WUIFiRItqqHp?=
 =?iso-8859-1?Q?maWZPzS887uBoArWqaum7HkCyqeJYoniXofwshptiYFDZOOeU043rljmoD?=
 =?iso-8859-1?Q?qoPBBd8XTT41hS1GZIwehwaPXpoOltzkvLVXRiIDuNx/vkQ3A9id5bAMe9?=
 =?iso-8859-1?Q?ekeXpaghtD+9b2s7T6NTTZY1qKf9V5NUN06J6MImW8wIdCkCHTTEwvPcK9?=
 =?iso-8859-1?Q?qSNbNi+jQyqTpgeJTnlbnTeHZJGyINkGa7cJy2Rc6HL3xKKWkiL7q3LZY/?=
 =?iso-8859-1?Q?mAsSfHXp4w9dlZ6euZ8r4768rw315VdYL3+o5IXEsiQOdIyOMt2OVCfQaH?=
 =?iso-8859-1?Q?v99qDe2c9F42jI2RQwZVxfP6c3svKtFAsutZgN1M3rSh25wU+UbgHuMQv9?=
 =?iso-8859-1?Q?L7BXDAmB1rWrahUZc8MvGojGTZYoO/fsHEUm4sRjddsQTbzVsqiXd7jYl8?=
 =?iso-8859-1?Q?/fR2uFSr5Htjx/b9xY57S9TJn6jmgaekjofy11j77x5lZN9F8XYjfhuu4d?=
 =?iso-8859-1?Q?oZxVuHbN7iWFoh5fjX7vofDVHvBv+ghMHpptlwFBEtWdSP9dX/54J2Yfx6?=
 =?iso-8859-1?Q?zNy83BMZW3vADywGGnjTW/ui0ug7AXxPyOvfWbXqefk08MiEjUfXO4MBdI?=
 =?iso-8859-1?Q?n7KUWEoqSqnPveY550USQBzzh7QOmj8o/IvvfiYatUsy+/ym+DrPzbvy8U?=
 =?iso-8859-1?Q?INIcYQlYfShaUdOY/Kqj1vCSJQscBFom1bHiHvwEqzw2OXBzEzIcR3goxd?=
 =?iso-8859-1?Q?OoK97rjt9T60C9VcRu2mUN5zmJO27O0kXNA+yxVFOtFTvQVxQncN3Vfao2?=
 =?iso-8859-1?Q?xTo7lZpKnFswHKeuo6glyz8bxmFsIUP8qfmPCriHiLaFui78mmUhqHWA3L?=
 =?iso-8859-1?Q?FoTdklGhIN2G8ExNsyM/9NLDfCNlIZpg1l1kVzcL6pz6WKNXK3alG+Xtlm?=
 =?iso-8859-1?Q?4+5R4VZlxfPGo2U5S5iL7JEd2ZlnnQiBSuQgIewXa0unqkVYuuc8msLTFg?=
 =?iso-8859-1?Q?5RhQfDX7yX9C3k7DBrUPF7mzRQTssJQA3qUINhd7oVUpJD1JjiS+vesla/?=
 =?iso-8859-1?Q?TGz07TiZnHKvrqs8oz44mwfC3Ss8IOqIyO9X2kbzTP7LB/Myh2e/XRKxG0?=
 =?iso-8859-1?Q?qyV7Vq/zsDzCLo5A5ablhx4HXIhYWkQL7UZbQiJBDNgiWrR2lmnN0dnrVS?=
 =?iso-8859-1?Q?zm4/NaPE9Nbkvx2xGCQaUMh1gI6ibKhCdUL5aJqB42fQhlgm/K9tG5c4NQ?=
 =?iso-8859-1?Q?rnyOxc5JPAAD2M53+jElsyAPyk/HKMoFyuUJ329U5UzIOB7YPU8N01x3h1?=
 =?iso-8859-1?Q?hs7Y3d3qp2uK6hXL7qWa3ZM+owk0K6tkDdOnBZgAtI6R+GtW0OyfD9pdXZ?=
 =?iso-8859-1?Q?6cXKIAWd1bbkglD4v4euOxlQqvU+/YqAfkycu2IRZQwJDJXj35BdWV1spR?=
 =?iso-8859-1?Q?Fgmxv1VKWA3QA09BI/KQIKlqkT2iSiOFv2b0MwBSDgPwOPinZuF5lYtcEv?=
 =?iso-8859-1?Q?3q/fLa6JPH03zoS3aSHQ8VTBUBYN5/F9MeJYEKi9XeX2qq+Yhi+wy94cwa?=
 =?iso-8859-1?Q?FHHfJVNCd8TPlcHGjDb7RCWWkdGrVXQAFBTcB/VE1D0LD4r9E3xNkKDxST?=
 =?iso-8859-1?Q?Xw+wA+EaGGdEw7zwKDaEBvkdI/U23KNE1/R1djvXdTfiGvdx6HOyosKgAT?=
 =?iso-8859-1?Q?1fxZObIFwMy5EaBg5vZPWDVDF16Ms/ApsUKMbtIgg7MMeZjdqy2LP/SN/G?=
 =?iso-8859-1?Q?LafWnM2ecg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: InYX9EzgxcWdrg83UgSyGxuSNif8FWUoGkeNTs/mMMCOTKPpZ1dnKjvIG5V95ArRn+e1h55hrL9Myv0bgrviC6nR4qZQeQKp+AI7TAUW0VP1U6at52PlcFpiaqJ1BJegSTZyr9IcmKUpzh13GOggS+yjVHfvjNj2yGKCje6/RjDk8v1MsvqXIkkj8ekltZpAz2oT4AEaV3Yjgmx+ntgK5Ei7UaCcZqn/REx17xk40PMgwQczOz0TnZlvJmnbkoaQbYDFfOwcLM0+cg9YgvlbcPkFqU7LbxGCquIGL83KNBJhLTKdl4ISSu4l8FoPaHJatgljo0z2Ashp7itGMPKbmA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87926b4-bd35-46d8-0af1-08def903798f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 06:24:05.2425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XclmstS69/o9ORKTtd2uw00FJSs3oABHezRmBdXQd0a+ivtkgrGShY+W6Y0/VQ86++NSGZ0OfYL8189XAQPMKS1FcUW8LQXMp7kJ9kWSOn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF56FB370CE
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce the ASPEED_DEV_ACRY enum slot and add the ACRY model state=0A=
to AspeedSoCState.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_soc.h | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index cd68c7f1ca..2e7987f9dc 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -25,6 +25,7 @@=0A=
 #include "hw/i2c/aspeed_i2c.h"=0A=
 #include "hw/i3c/aspeed_i3c.h"=0A=
 #include "hw/ssi/aspeed_smc.h"=0A=
+#include "hw/misc/aspeed_acry.h"=0A=
 #include "hw/misc/aspeed_hace.h"=0A=
 #include "hw/misc/aspeed_sbc.h"=0A=
 #include "hw/misc/aspeed_sli.h"=0A=
@@ -81,6 +82,7 @@ struct AspeedSoCState {=0A=
     AspeedSCUState scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedHACEState hace;=0A=
+    AspeedACRYState acry;=0A=
     AspeedXDMAState xdma;=0A=
     AspeedADCState adc;=0A=
     AspeedSMCState fmc;=0A=
@@ -270,6 +272,7 @@ enum {=0A=
     ASPEED_DEV_EMMC,=0A=
     ASPEED_DEV_KCS,=0A=
     ASPEED_DEV_HACE,=0A=
+    ASPEED_DEV_ACRY,=0A=
     ASPEED_DEV_DPMCU,=0A=
     ASPEED_DEV_DP,=0A=
     ASPEED_DEV_I3C,=0A=
-- =0A=
2.43.0=0A=

