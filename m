Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD63CD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 04:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcms-0003WH-WD; Wed, 03 Jun 2026 00:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcme-0003TX-K9; Wed, 03 Jun 2026 00:00:49 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUcmb-0002OB-BX; Wed, 03 Jun 2026 00:00:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9g/6E0Cy/nRWvICo8GkFqVf8TmFrjZNHUor4XIlud1wUMJK2Ub2zfi9OgO6Mm5r/HEtMA/MWZxjz7ta+cad3OBaGYc8Wmvr/+okvBvwT/J8PlMxQqJWzfHLyII6FC+Dc+vkQdJjTInyH1zWacCBCSrWahnQH7BnIIhXL7WDynIMMkmKr9viewZL5oSaOWza+l+NsSb1qScXz5P0HR5Hjb+sQM5VRNXizEn0FKF/iAMjHCI6kbTYK7GbYRBKqDnl89SnKPy9jdASVdIoeFHWZczd/wWwR8hE+BzOI00o9yD52W6bx2kcmie9HICtWJASHjHNyaGFzIF00Zdxb+SMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjfW493m/09TpbqYU3Pf6nWFQheYhQbFT/Q19QLdF3g=;
 b=l8MnYxwbMNrVFvONLaMIZy0N5922UOe4uM6nTAxC7mIPwNdIoS/MvmuW/oO05CK8R5Co1qQipQn7wzWxcFTR2AZU4Nxy8NE+Go2dAp5DWyhS60QIxujNbWHK/Wbtbjkrop/imszb4GbFY0o1OX6nXOdz9FvP52yqn3jXBYTpJ9LCgqIP6YVmoT1t+VyB3AJhjuHK0veF16zvunhbHNI4rxrVkWD7XC1e8xogJFHqlJ+DKj/HmXzeWwpe2Rp1kgQhJWkELjJdU7FYrWTsimE3SBd9zd+dyeRhQOYXE7woK9UbLHICT+LbxzJXWlx6Rbo5dzwcKIAHl+rg2toEUodwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjfW493m/09TpbqYU3Pf6nWFQheYhQbFT/Q19QLdF3g=;
 b=FuOaaP54qIMGWH6jQkieb17sUkLAFC9OqfXn3R8OALrfBtbd86frN6xP8KpBfqKyBoD6XaCIbFDq8dlX+UsfAfQwDOI54Mh9hq3et7OU2GzB+LByyXuU2zuLRXzJ6toX1+erl7AjB8b4IUY64CnldW+LAf7nv7pENEwubqrwnspoSFZ4CGw8yIZ11PH2CACt2ZJp8PeMx6oNv6RhZaoLPzB7u3q/s6CIMh1wugePdlcFtX69MBGufBc7quEzMurpkMKNsJKuDZWcId4YJ1VIfaQKgIYc7UlQ+dTPwb5oKHrheL4QI33RHeeIxk66vGH9JvU0jCyIRVklRIPNuFeZEg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYSPR06MB6921.apcprd06.prod.outlook.com (2603:1096:400:468::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 04:00:31 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 04:00:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size
 and adjust offset
Thread-Topic: [PATCH v3 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
Thread-Index: AQHc8w2FWh1kiIbOwkSs8OOB+aGKuA==
Date: Wed, 3 Jun 2026 04:00:30 +0000
Message-ID: <20260603040027.938816-3-jamin_lin@aspeedtech.com>
References: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260603040027.938816-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYSPR06MB6921:EE_
x-ms-office365-filtering-correlation-id: 50ac5633-8cfc-4696-36fd-08dec124a7a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|6133799003|18002099003|56012099006;
x-microsoft-antispam-message-info: BBSGKyH7gk91Qv8zDYRHhTpTj0L2rRroJ94WefJcuM+bhMPdv0fLaRmIB7/nggWbbSY9TjG7/g7OhtJAP0z4KUuu2zAjqiCWMNOuve1zV3+CovMH4LMhclXgF8EYbmxX6CVzhsY7uXCa3ua5jTxwK7EBbS57DgUlCcDSkVssVXSabKDkTUTwPlX3PCBjPgffbiH3nCUHzC6h51Yu0gwKrXsKp8pmBWll/jeZ7SKwlwkIUrFAsc49hd/SqcUHLMJp+Mf99NpJ+7POrHizGTsuOwH69h9s88XiMYiM4caNwJz2EweaulTQEDUUPuC4PxPhrzeBMOEgvkijb/SU78Dt8vbWcZkM7hojfzYkdlrQwusH2cWYTpFPi5XkanscM7xYu0aMOSZKxq83hTyNKOiJxWVyJxZYF2NY9ytMt3sJAScph/GpG/g+tqY77P1iglTEWItonLWPvJgl+o7FAgWt0H/quCpD/OKuf0NtuJnhkAtMXpubWeRZSn5klxgckRT4aBd8fYNeyDAQw0GMoBsennBHXy8UP2bt1nDt5PQd7moor8UQwdHT0joyRpsNVBAR/LqBDNSGlhJcpbRhDsQRIgbbhCv7IDYxN4ZDVCNr2nJxalRaVqNWwSuiTdaiO/x92AP6TLo5CAyFdMTVO+yuKi4yf+NXiT0NfnJeOy+HmPigz9m5zEJHbrLIQe69uvoJr7BEcZoHDZ4mKMlOtU1qdEZg6I+HHktMTMagKpzbawRMGlSIm4v+sqohMeJz/eqM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(6133799003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sO9CZhiJS6d2fSbJIsWqTqm5u3CFJi8L2+I7Mp5Oze0R9zpcjHbvJXle4k?=
 =?iso-8859-1?Q?lpm5dxRr83CqKP9zqKJYWtViengmpJ8wnvP0/eAHIXfG7HhNIV7LcvkHf3?=
 =?iso-8859-1?Q?eKFP6I8x8QAkHIpPTxWaqToe6Ue5xEVlJQ9qfmQjyKBFusfTtiJ24Z6Y7F?=
 =?iso-8859-1?Q?zncBpr9/6RpWLj/W0K8kYiUzUuUd743YiYG5zZyAXE0cjveJtqukhLKAv8?=
 =?iso-8859-1?Q?PuZfDZtQDvqeZNBOWzwo21dcyjvTqnGfv1VPrzuS9j6o4iowVBlcOZ1GAf?=
 =?iso-8859-1?Q?uBfle+Yi678Wyuo10dfJWem1wnkdWHS8RSFDMBCHiR2+uEtVDzeeN5L+95?=
 =?iso-8859-1?Q?qyuiyWmBjhdFzkvT5BAeIpp/8juiHBdYpH7H0hihStm0duhnd0A2XWpvwT?=
 =?iso-8859-1?Q?i8r+Ws8TefVr2LWRRq1uAO20E6UPmiqqBTCBd1vL9BZMVIj83ck8XGBMMw?=
 =?iso-8859-1?Q?BfcwzfRZSuZs9By9I1uOVILiq7g83zSTybu6gtra+PGSrDrn2xDDWKmd/C?=
 =?iso-8859-1?Q?2mIJblgGJrBI3vLBW3lzmaIayU7hKA++na3f4w5EbT6/wpPFv7qGePhp/t?=
 =?iso-8859-1?Q?xx3svlVSbZ8EJ9zHfqa9QkcrlV/mXnvtIFj2qLPkwlXmD7bGF7D1p/q0PS?=
 =?iso-8859-1?Q?CeCZVthgQaf/GpoFfRRmNPUcD1/tits+5fwnayhmLOYUcq3R7MHAc6DVkI?=
 =?iso-8859-1?Q?SQ4uYkWuHa8lWbSRPz4IgUzx7o8OVJLepr4L9HRqVYUvhLykqhXgHwnoaW?=
 =?iso-8859-1?Q?Ke6ILtxGpX4ra5vtrh4zylWoFLQwjNOfcNoBLcATeTtKWD7iem7eDqfSEA?=
 =?iso-8859-1?Q?PyXT6LG3iekvmHlpaouz02BjmOyCiFzkUGcGEg5qDx43MCKWU+FaP1W77h?=
 =?iso-8859-1?Q?ya2siuM0VM4lzIu9k3EHNTD1XzSycQPedRvo3brcJkfhiRcwepMxMcKc1k?=
 =?iso-8859-1?Q?yqGgOcQZhUj7jI3/1aOIJlE35wtPEaqNx+UqWjTbxJl4edcpqJNcC0YOfg?=
 =?iso-8859-1?Q?64whTbdF/2HDYsU7uWk2HpLuzEo6xgivTLPLf/09dAJ7xCMdCHHE2KP07w?=
 =?iso-8859-1?Q?6v7DFLP2muoIXukfaz4H83r6ESSv6oVtiNKA7LS8Ne2ySv4+nDIb7Qiisj?=
 =?iso-8859-1?Q?gJ709kCWRWvUxz/4w/yUaXkaQojN09swIO8oD6MtlrB7gKNVXhYUuQGmUb?=
 =?iso-8859-1?Q?9fj/vtwTrT7ZyBWssxnMgbIQI9bzJe0KbFa9Pour2cNboPg3y+/2pkcz+n?=
 =?iso-8859-1?Q?E76sgd1vnwxa0ACSJupbrUWDGLG/MDmDDtg+cudWj53w3Fte7CU1xDDf1b?=
 =?iso-8859-1?Q?1HuhoNEjMrhTis6OwtSm5+DT9umS2oWn15xppRDCgkkG5BrDkrbutVv5jm?=
 =?iso-8859-1?Q?W/UMcvyUgvDCkalqMPNOP5uyy0UHiN143JNbzENRjRfgF91U4oupFQvplf?=
 =?iso-8859-1?Q?SVJduT99Hi/dcCgBRiax2QV+qlLQ7nWe/H5Zlz6OkIVhkacbnlPE3sy4Yf?=
 =?iso-8859-1?Q?vIdBRgg6qO2A7/TNTvsetIJRPnYgnlqQf5PoIvE0icQo/0RYB8RsHBTQ7g?=
 =?iso-8859-1?Q?70o4gTzpvoqO2+l17j2EDza0CDuncSvF1RrNW+r1+33ESKClUX6apvYhaE?=
 =?iso-8859-1?Q?xNAFyZO0z+EXJltqJhXE45b1nJMELkElWni++bASetHQmMQ7PAUsc4Q38/?=
 =?iso-8859-1?Q?3TMjx2DIqmlzUVM4UMS7wqkEA5pByxh4czbQAuRqYmVNrydSgJFjTOcsO6?=
 =?iso-8859-1?Q?Ct16Y4O0Bfj/3E1QK87f5JANKifwL2XkbcQVnOL0ow4aj6Q+ITPcbVOLBK?=
 =?iso-8859-1?Q?a2ExDUbACA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kK9zbhrH76VxiX4JFhVHTqXwWRWBQSrCJb/r4BRuCPsgrwLTbc0bFrvRkvWtYsRWHjEp819ooKeJudwFPGdeULdqSNJLsJFYdPfSfErF0+B8X44WiKMQM91rUeO+RLByMnly8gz8VhSXiv4yzoV4mw6ncWtnt2usnetfK+yxnjozenMdNaA2P5XrS98A5V4pwXRkd8ck3Q9hAYTqJ8QTkb3mT7XqqX0QxxAl4iGtjC778iUP08q3iAwWTKnMO4wqSKsARfwxBDqaoAx2XHLNoSAqVvHnCPO+YluD5hw7EkBysgPFIiP3I2hhPFPxVnt69JC4LshYKa49AK0FlOQp2g==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50ac5633-8cfc-4696-36fd-08dec124a7a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 04:00:30.8905 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AUntASusHeRdDI0FCek1nZBAhkoA0mQMFaQX5khrbfGoc92FYpPiJAnrrV9zeI9Wf52CgYB8JvMujELbK/9q6j2ZMkgmcpIU6xFyAFh3zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6921
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Update the AST2700 I2C buffer mode configuration to match=0A=
the latest firmware definition:=0A=
- Increase buffer mode pool size from 0x20 to 0x40=0A=
- Adjust buffer mode base offset to 0x1c0=0A=
=0A=
Since the buffer mode region size changes, the migration state=0A=
layout is also modified. Bump the VMState version numbers to=0A=
prevent incompatible migration between old and new machine states.=0A=
=0A=
Fixes: 1809ab6a67359e0876981cd05d2a50b2843eabad ("hw/i2c/aspeed: Add AST270=
0 support")=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/i2c/aspeed_i2c.h |  2 +-=0A=
 hw/i2c/aspeed_i2c.c         | 46 ++++++++++++++++++-------------------=0A=
 2 files changed, 24 insertions(+), 24 deletions(-)=0A=
=0A=
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h=0A=
index 1fc229f699..b2e4d2fb9d 100644=0A=
--- a/include/hw/i2c/aspeed_i2c.h=0A=
+++ b/include/hw/i2c/aspeed_i2c.h=0A=
@@ -35,7 +35,7 @@ OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEE=
D_I2C)=0A=
 =0A=
 #define ASPEED_I2C_NR_BUSSES 16=0A=
 #define ASPEED_I2C_SHARE_POOL_SIZE 0x800=0A=
-#define ASPEED_I2C_BUS_POOL_SIZE 0x20=0A=
+#define ASPEED_I2C_BUS_POOL_SIZE 0x40=0A=
 #define ASPEED_I2C_NEW_NUM_REG (0xa0 >> 2)=0A=
 =0A=
 #define A_I2CD_M_STOP_CMD       BIT(5)=0A=
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c=0A=
index 9d4e72c858..856d5dc1db 100644=0A=
--- a/hw/i2c/aspeed_i2c.c=0A=
+++ b/hw/i2c/aspeed_i2c.c=0A=
@@ -1132,8 +1132,8 @@ static const MemoryRegionOps aspeed_i2c_bus_pool_ops =
=3D {=0A=
 =0A=
 static const VMStateDescription aspeed_i2c_bus_vmstate =3D {=0A=
     .name =3D TYPE_ASPEED_I2C,=0A=
-    .version_id =3D 7,=0A=
-    .minimum_version_id =3D 6,=0A=
+    .version_id =3D 8,=0A=
+    .minimum_version_id =3D 8,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),=
=0A=
         VMSTATE_UINT32_V(pending_intr_sts, AspeedI2CBus, 7),=0A=
@@ -1145,8 +1145,8 @@ static const VMStateDescription aspeed_i2c_bus_vmstat=
e =3D {=0A=
 =0A=
 static const VMStateDescription aspeed_i2c_vmstate =3D {=0A=
     .name =3D TYPE_ASPEED_I2C,=0A=
-    .version_id =3D 3,=0A=
-    .minimum_version_id =3D 3,=0A=
+    .version_id =3D 4,=0A=
+    .minimum_version_id =3D 4,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32(intr_status, AspeedI2CState),=0A=
         VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,=0A=
@@ -1250,37 +1250,37 @@ static void aspeed_i2c_instance_init(Object *obj)=
=0A=
  * Address Definitions (AST2700)=0A=
  *   0x000 ... 0x0FF: Global Register=0A=
  *   0x100 ... 0x19F: Device 0=0A=
- *   0x1A0 ... 0x1BF: Device 0 buffer=0A=
+ *   0x1C0 ... 0x1FF: Device 0 buffer=0A=
  *   0x200 ... 0x29F: Device 1=0A=
- *   0x2A0 ... 0x2BF: Device 1 buffer=0A=
+ *   0x2C0 ... 0x2FF: Device 1 buffer=0A=
  *   0x300 ... 0x39F: Device 2=0A=
- *   0x3A0 ... 0x3BF: Device 2 buffer=0A=
+ *   0x3C0 ... 0x3FF: Device 2 buffer=0A=
  *   0x400 ... 0x49F: Device 3=0A=
- *   0x4A0 ... 0x4BF: Device 3 buffer=0A=
+ *   0x4C0 ... 0x4FF: Device 3 buffer=0A=
  *   0x500 ... 0x59F: Device 4=0A=
- *   0x5A0 ... 0x5BF: Device 4 buffer=0A=
+ *   0x5C0 ... 0x5FF: Device 4 buffer=0A=
  *   0x600 ... 0x69F: Device 5=0A=
- *   0x6A0 ... 0x6BF: Device 5 buffer=0A=
+ *   0x6C0 ... 0x6FF: Device 5 buffer=0A=
  *   0x700 ... 0x79F: Device 6=0A=
- *   0x7A0 ... 0x7BF: Device 6 buffer=0A=
+ *   0x7C0 ... 0x7FF: Device 6 buffer=0A=
  *   0x800 ... 0x89F: Device 7=0A=
- *   0x8A0 ... 0x8BF: Device 7 buffer=0A=
+ *   0x8C0 ... 0x8FF: Device 7 buffer=0A=
  *   0x900 ... 0x99F: Device 8=0A=
- *   0x9A0 ... 0x9BF: Device 8 buffer=0A=
+ *   0x9C0 ... 0x9FF: Device 8 buffer=0A=
  *   0xA00 ... 0xA9F: Device 9=0A=
- *   0xAA0 ... 0xABF: Device 9 buffer=0A=
+ *   0xAC0 ... 0xAFF: Device 9 buffer=0A=
  *   0xB00 ... 0xB9F: Device 10=0A=
- *   0xBA0 ... 0xBBF: Device 10 buffer=0A=
+ *   0xBC0 ... 0xBFF: Device 10 buffer=0A=
  *   0xC00 ... 0xC9F: Device 11=0A=
- *   0xCA0 ... 0xCBF: Device 11 buffer=0A=
+ *   0xCC0 ... 0xCFF: Device 11 buffer=0A=
  *   0xD00 ... 0xD9F: Device 12=0A=
- *   0xDA0 ... 0xDBF: Device 12 buffer=0A=
+ *   0xDC0 ... 0xDFF: Device 12 buffer=0A=
  *   0xE00 ... 0xE9F: Device 13=0A=
- *   0xEA0 ... 0xEBF: Device 13 buffer=0A=
+ *   0xEC0 ... 0xEFF: Device 13 buffer=0A=
  *   0xF00 ... 0xF9F: Device 14=0A=
- *   0xFA0 ... 0xFBF: Device 14 buffer=0A=
+ *   0xFC0 ... 0xFFF: Device 14 buffer=0A=
  *   0x1000 ... 0x109F: Device 15=0A=
- *   0x10A0 ... 0x10BF: Device 15 buffer=0A=
+ *   0x10C0 ... 0x10BF: Device 15 buffer=0A=
  */=0A=
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)=0A=
 {=0A=
@@ -1666,9 +1666,9 @@ static void aspeed_2700_i2c_class_init(ObjectClass *k=
lass, const void *data)=0A=
     aic->reg_gap_size =3D 0x60;=0A=
     aic->gap =3D -1; /* no gap */=0A=
     aic->bus_get_irq =3D aspeed_2600_i2c_bus_get_irq;=0A=
-    aic->pool_size =3D 0x20;=0A=
-    aic->pool_gap_size =3D 0xe0;=0A=
-    aic->pool_base =3D 0x1a0;=0A=
+    aic->pool_size =3D 0x40;=0A=
+    aic->pool_gap_size =3D 0xc0;=0A=
+    aic->pool_base =3D 0x1c0;=0A=
     aic->bus_pool_base =3D aspeed_2500_i2c_bus_pool_base;=0A=
     aic->has_dma =3D true;=0A=
     aic->mem_size =3D 0x2000;=0A=
-- =0A=
2.43.0=0A=

