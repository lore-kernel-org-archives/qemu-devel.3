Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C88F8E4A5
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 03:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDZsy-0002Ae-To; Thu, 16 Apr 2026 23:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZsw-00029p-FG; Thu, 16 Apr 2026 23:28:50 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDZst-0005oG-SP; Thu, 16 Apr 2026 23:28:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMGI9YIsxQXZ5Lf3atX+GdGGyDwyNU1xAOWcA0BjC1gf+ajvTbc35oVjbGHhC+IR6fYbonb6gGpYeCRObfBUj7LuivHurIBd1ZeC9+ISVLTykRLC3zrzmYpTWzx7AajHmvjhpQsI+7+9vGaabM2JmRzKcyiTKyv+j4t6VrCi3lqCwmAfgBODpHY7e61xg5xizGSjzULiEzFdfDyziacorJE059MUluarATIlxDx7Bdc0HwnsunWI+4DZw760FoT5aYTAO/Fq7BfZZaJJPrC7wQjtD10d3wB68UmN0dC/lyONDSEyxKMLPm+Z/OWhacMhC8pGWP0vWId21+B8fACqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X1/CUfImRJKUwTDSTvyffV8Z4qr6OFYqWkkd5PBicsc=;
 b=CkBr+P7sbMoVOM9bPU96Q+WOrbF0GhJhzIaxqVniE87vZukphN/LHW7S6Mgmclcb/4QXjxUxqYkKASY33SvwfjfjYYiejnlx6kHzypq05sJ2EYMo8712FX5AH+9dko+l4HkANHZyqT2MDVXJYLv/LCnZ1ckO3tiK7I7juFjRr+zGKMcEH9LasVVJdU6AkCJufaUOaSJH0+gUoBECUIG9ONa4Wfa7hwjZCcXRgW6CC4YRULTqaIsw6ADJAiDSF3PFBPzWpTpf7nW/8HX9J9dmP4ncIbYnyQbLcY2lNQ7d1KCTrXss5sJl3fZQ+2ahDK6u2GhFe53w//Yd57QIKeLY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X1/CUfImRJKUwTDSTvyffV8Z4qr6OFYqWkkd5PBicsc=;
 b=RFSr4F2smvIwB2LHTwAdy2OfZHTI7nlOo3iSXmbreTouBp2zoPJApjn23iWBAyv12afHkOPAdk3MqTtSec+MIxDCjUEYEUP2VRxKnfYY8q2GbCbSX8O4H4YUmZWWpJNdAZe12loY86Kolqh6A5QJsq4TZKQ8KwQxSYYM/qBzPCh3bXgHYeVhqbKD+tigSOKnanCWO8ygH5+V6V+Fv51s03rvLjfKwRWP+Q03UXyd4pDtpo8n2kvRgs1EuHSVrz0WzjzQQBqAMaAvIpmX9dBuQJZQFqqnnfQF89I/F7Y8aWE7nMGvaQ+ImUzOWPy+FCwihA2v0OPA1drWUMx+eGQScA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6299.apcprd06.prod.outlook.com (2603:1096:820:ce::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 03:28:40 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 03:28:39 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>, Alistair Francis
 <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 01/21] hw/misc/aspeed_scu: Introduce Aspeed2700SCU subclass
 and separate from generic SCU
Thread-Topic: [PATCH v4 01/21] hw/misc/aspeed_scu: Introduce Aspeed2700SCU
 subclass and separate from generic SCU
Thread-Index: AQHczhpIwQwUTbK4GEqFW40cS4W0FQ==
Date: Fri, 17 Apr 2026 03:28:39 +0000
Message-ID: <20260417032837.2664122-2-jamin_lin@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6299:EE_
x-ms-office365-filtering-correlation-id: 03ca410f-7a5f-40ad-09e5-08de9c316b38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: JeCAiaAePqc1kPG3tNMf7XQmdnDe1HNooiqrJmhwNzrGu/uqJpoKTLtCP2GEsVWWfWyay2VkXfB71Jyogz0JmhGK3SgVJhWjz+NOPGaIXavzkppJmNVCqQXnQqnBKPKehWnmSCNy6njt/fP86kNP9mJo1pSNi3Zpl7teOAOUeck0dBu9EJpQaejnHA8hkA5GAcadKyHXmod2GolaVA6UuspdXompkH/gTcmf7m0wEt/vtBlOyhzXH0DHf7BjTZsC/HdQ5831aBCHU61FIhirkvb6+yLVwahLoxyCUiakWbxQ/lV2g+p1GFTSLxbQjXp91DharoSxpOItPoF1QTBTRAusS6naG5P1PaRbQkH7uZS35FOErx3/5h2RcxAOqp/yLsJ1fS/wvC5b0RCjdl7dmw29LpcIuwMnxhpev9hT+cazbbkPa+ThdAlLvwIOFXgaTN2t+WIexNhwCAHIk/aPtuo4zf6mksZpQfsQi3wqxzPn9ziPX6OR+5fMPLdlQckAsbOuPpK4fYj4bjZU4mn6T3SK5Iz356WVhmDz3ghimVS1h1fTGav78k4UvqvI7YfTgvVxRxLw7N/3VPzpfvquYWb/aS+RdwxD5+SF7dgGW5jO7rnpVN7zZ/NC6ecZ51BlSW+hK8OTjG/ej4rgmXlL7k6tK6Lts3mmT5DCR4lUin6PPnC5m74ZnMjfM6YnmS4G3elN2wUlaxEyuRy4wEpVoDvRpEmEl+AUpl+9wrPJxtsFST4pNbDWrgd12Nh0/RskwlqHhY3NJAOQz3vpCve8nNP7bmj20EnrrApisQ+ARh4QXIlWC9VF8+zXXvVvxVOp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QdP/W28z+vrlX+hcWcmLS/toWctK5wRfK+H6VAIx/A+dCf0bnt3jqaGbaS?=
 =?iso-8859-1?Q?l+XUhQsUO7og7pYzvamniYVzQFEu0QVsQkZ2UeESjamLDhaB/DryFgXth9?=
 =?iso-8859-1?Q?ShPSu9erDi8IZSnA1OLE/3qmnwIdYcJ9rplBcGpMfKWrtna+L4l0g09k2M?=
 =?iso-8859-1?Q?gArTA0CJg3DjU4cGhNM5BIEyHKDhxQk31AbKy1RNP28rCbRxxWti4VWnnL?=
 =?iso-8859-1?Q?9rdGCeG+Jj7KsGMJrF6HosumAJCl/uQIAil2cePz6h1S7QB8FreDvR9/DY?=
 =?iso-8859-1?Q?SiNTSEZ8pOEAYOTqHkqBltN9MS5bQwi5OzOthM0NSgce18uwn884hvhTWm?=
 =?iso-8859-1?Q?eKnOdi1HqnQLK/NbgdV9eQnjpQYLOlPMmJLzpE5qMW89ctgbPYmIgPs0cR?=
 =?iso-8859-1?Q?TvmD9netUoUeQ33heK+BqHJzW+bqO/mo/q0wVDT5M95TKX+AarxxerNOn7?=
 =?iso-8859-1?Q?lh9Nck35olZTDyZkwf+bllgMBuzhteoiXCcWxBdZx7cpLW9YsP34uI1nzO?=
 =?iso-8859-1?Q?8MW3v6HXc3b5Lc2iUfq5S/yVUAL1jrwSQcQ6p2y20GZCbqnwBkPVo0EB3c?=
 =?iso-8859-1?Q?JTexbgQzRLKvq+h0o63aFZ6mP/HcwF2Ikz79sBKRptVivvoQ0jVl+ddD62?=
 =?iso-8859-1?Q?ZSvo228MIemrPeulz0QTJNU42hANeH69w3oVvLGmoateEN3LBDw8+n362o?=
 =?iso-8859-1?Q?a10LvFXbXWo/emHve7AKPtYvfuNuaZIerTGAiKS2PCQNnrAeOMp8a6e9J5?=
 =?iso-8859-1?Q?o0JQJxLA/YVETMuPsTpRz1Bv/G8UeHoeVbSj5xrakY8/RgbxXgtbaCOcCA?=
 =?iso-8859-1?Q?BySYTeFBEVxZZM4gZG/I1aeXNpY2Hk6h29xchCa43568rHbz+XOeqPPEkX?=
 =?iso-8859-1?Q?9a+SIU3rqQ/oFiridH/WLH0r3dFQulUHYM/X2evfh1O1TUdyHUPm5+73+3?=
 =?iso-8859-1?Q?XAEN4yNfryeuOkJ4K3mlJ08o4+YY/engPzoyzVvPHRmN2p145W+RAogNUl?=
 =?iso-8859-1?Q?1Wgf5kM2leA+kY/c41wB4xLoXhbjllxRnnO1rAriNMCII2LtWtFaPoPa9G?=
 =?iso-8859-1?Q?RbwJQgckl4UJPNa9pAAbqctwldkYxwR9Cyvs+4NfG9dXIFnmw8Sib9JHHT?=
 =?iso-8859-1?Q?SkInKNmQfzZTpDM51fczmjar90cc8QGr4EHQuSc+FajhZl4AvHoSkhbV54?=
 =?iso-8859-1?Q?A4qq5YPs70Cjc485S9Sy/XZaK7u8RBU06jFD19YdFDUdDdnAdCr9Rp13ks?=
 =?iso-8859-1?Q?LZnpjxqkOPIlgyeRBHknpHwetRgS7TxfHCtHW9s0aISpxaJZD2CUQRRZH0?=
 =?iso-8859-1?Q?PU1GkVAjaoL1iv7vOnrqWBOOAZhve/E5P93Bceq9fR81M0FGSmxriTazkL?=
 =?iso-8859-1?Q?huSjKS5m8UaKeOG1sErJ+peEwnJmW42xzs75KWw0vle1c08fK6ayaXrmoI?=
 =?iso-8859-1?Q?+YjE0IeMC1Bo+Ck3zlvnPx6kfUSPc6DzT97xwDuIqa/5vBTe11lmfO0RG+?=
 =?iso-8859-1?Q?fD8oiFMKF+mfY5M8MuhlpBKGy6U6kZa8jnT4Wavoka4urlJZzMCU/yA4UQ?=
 =?iso-8859-1?Q?ugL/wmlbYYmGB1syJxh/jjlN54/nh6EU/ho2/mvo+aOBcsYUiWHah4GgPy?=
 =?iso-8859-1?Q?itLxaSbDupSgqdHu/xgQFln449BYke8NBMlJVZNTFo+zrnNprtAqqbEOYV?=
 =?iso-8859-1?Q?avOTqHNx2ugWuI8XTlUadBay0kGTTo9MO3o1msVtTN6PN+m0ZH67nzg2pF?=
 =?iso-8859-1?Q?ZNxEHv68RWg/fxNA1clr/sqq1s4woWUyXUwhYf0kw3MKkRtkG1ZlUK+h01?=
 =?iso-8859-1?Q?FEhedio3/g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P6Bj+g71chr7/e0iwtoTiU1BT6E2OjCgwk2xr5Vj8aIq52ZuH+n+j5v8jM2oHpubAFfyaxBRlTuIu8YBO6G3/KWmeULFtiuHUu8ypl6Krdo13c4YujWTXqKXx9fsm8NHKt/JqPjWKUVbfvw4OnZeb+7bF95cMv8S6V6yTwaY8RjtPCq4cxdUdRTgSxFvD/EodHHQi73ZdYoKiq0uGDHXZWLSs03hZVW+c8tPayXexz5n3JLV/ibHOInFyzCrMCDfky2grT07Ux6fnA9JqLVX18RcBNLswcRLj9lN33OzWu2mSVvVIuLio76VpdKF6xWgm6kxlSnd7vIXYUrSSTMsMw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca410f-7a5f-40ad-09e5-08de9c316b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 03:28:39.8951 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igrXCXqm/LaDPCqeI11AGYAXEJpqKZ4eOEE4Bgykef6wOwC8++6fGwqkdoSIgapWgRbBfNBvcsjxvjzYX7obMh0J3tXRLrncY18+9lm2a9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6299
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

Introduce a dedicated Aspeed2700SCUState subclass to isolate AST2700-specif=
ic=0A=
behavior from the generic AspeedSCUState implementation.=0A=
=0A=
Previously, AST17x0/27x0 platforms reused AspeedSCUState directly, includin=
g=0A=
in coprocessor paths. With AST2700 introducing additional requirements (e.g=
.=0A=
future coprocessor features such as DRAM remapping), continuing to extend t=
he=0A=
generic SCU risks impacting other SoCs.=0A=
=0A=
To address this, add Aspeed2700SCUState as a subclass of AspeedSCUState and=
=0A=
migrate all AST2700-related users to it, including:=0A=
- AST1700 SoC=0A=
- AST27x0 SoC=0A=
- AST27x0 FC=0A=
- AST27x0 coprocessors=0A=
=0A=
As part of this refactoring:=0A=
- Remove SCU linkage from the common AspeedCoprocessorState=0A=
- Add a dedicated 'scu' link property to Aspeed27x0CoprocessorState=0A=
- Update SCU memory aliasing to reference the subclass (parent_obj.iomem)=
=0A=
=0A=
This separation keeps the common code generic while enabling AST2700-specif=
ic=0A=
extensions in both SCU and coprocessor paths.=0A=
=0A=
No functional change.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/arm/aspeed_ast1700.h     |  2 +-=0A=
 include/hw/arm/aspeed_coprocessor.h |  5 +++--=0A=
 include/hw/arm/aspeed_soc.h         |  1 +=0A=
 include/hw/misc/aspeed_scu.h        |  5 +++++=0A=
 hw/arm/aspeed_ast27x0-fc.c          |  4 ++--=0A=
 hw/arm/aspeed_ast27x0-ssp.c         | 14 ++++++++++----=0A=
 hw/arm/aspeed_ast27x0-tsp.c         | 14 ++++++++++----=0A=
 hw/arm/aspeed_ast27x0.c             | 16 ++++++++--------=0A=
 hw/arm/aspeed_coprocessor_common.c  |  2 --=0A=
 hw/misc/aspeed_scu.c                |  8 +++++++-=0A=
 10 files changed, 47 insertions(+), 24 deletions(-)=0A=
=0A=
diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast170=
0.h=0A=
index f7bd4e8650..39c5977cf1 100644=0A=
--- a/include/hw/arm/aspeed_ast1700.h=0A=
+++ b/include/hw/arm/aspeed_ast1700.h=0A=
@@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {=0A=
     MemoryRegion sram;=0A=
     AspeedSMCState spi;=0A=
     AspeedADCState adc;=0A=
-    AspeedSCUState scu;=0A=
+    Aspeed2700SCUState scu;=0A=
     AspeedGPIOState gpio;=0A=
     AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];=0A=
     AspeedI2CState i2c;=0A=
diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_co=
processor.h=0A=
index 4a50f688ec..4db995d251 100644=0A=
--- a/include/hw/arm/aspeed_coprocessor.h=0A=
+++ b/include/hw/arm/aspeed_coprocessor.h=0A=
@@ -20,10 +20,8 @@ struct AspeedCoprocessorState {=0A=
     MemoryRegion *sram;=0A=
     MemoryRegion sram_alias;=0A=
     MemoryRegion uart_alias;=0A=
-    MemoryRegion scu_alias;=0A=
     Clock *sysclk;=0A=
 =0A=
-    AspeedSCUState *scu;=0A=
     AspeedSCUState scuio;=0A=
     AspeedTimerCtrlState timerctrl;=0A=
     SerialMM *uart;=0A=
@@ -50,6 +48,9 @@ struct Aspeed27x0CoprocessorState {=0A=
     UnimplementedDeviceState scuio;=0A=
 =0A=
     ARMv7MState armv7m;=0A=
+=0A=
+    MemoryRegion scu_alias;=0A=
+    Aspeed2700SCUState *scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"=0A=
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h=0A=
index d7b3647ca1..adf2f2898a 100644=0A=
--- a/include/hw/arm/aspeed_soc.h=0A=
+++ b/include/hw/arm/aspeed_soc.h=0A=
@@ -151,6 +151,7 @@ struct Aspeed27x0SoCState {=0A=
     AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];=0A=
     GICv3State gic;=0A=
     MemoryRegion dram_empty;=0A=
+    Aspeed2700SCUState scu;=0A=
 };=0A=
 =0A=
 #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"=0A=
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h=0A=
index d003955428..fd30313e69 100644=0A=
--- a/include/hw/misc/aspeed_scu.h=0A=
+++ b/include/hw/misc/aspeed_scu.h=0A=
@@ -20,6 +20,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEE=
D_SCU)=0A=
 #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"=0A=
 #define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"=0A=
 #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"=0A=
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2700SCUState, ASPEED_2700_SCU)=0A=
 #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"=0A=
 #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"=0A=
 =0A=
@@ -41,6 +42,10 @@ struct AspeedSCUState {=0A=
     uint32_t hw_prot_key;=0A=
 };=0A=
 =0A=
+struct Aspeed2700SCUState {=0A=
+    AspeedSCUState parent_obj;=0A=
+};=0A=
+=0A=
 #define AST2400_A1_SILICON_REV   0x02010303U=0A=
 #define AST2500_A1_SILICON_REV   0x04010303U=0A=
 #define AST2600_A3_SILICON_REV   0x05030303U=0A=
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c=0A=
index 5eb6680da9..46f0c97329 100644=0A=
--- a/hw/arm/aspeed_ast27x0-fc.c=0A=
+++ b/hw/arm/aspeed_ast27x0-fc.c=0A=
@@ -156,7 +156,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->ssp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->ssp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
@@ -188,7 +188,7 @@ static bool ast2700fc_tsp_init(MachineState *machine, E=
rror **errp)=0A=
     object_property_set_link(OBJECT(&s->tsp), "sram",=0A=
                              OBJECT(&psp->sram), &error_abort);=0A=
     object_property_set_link(OBJECT(&s->tsp), "scu",=0A=
-                             OBJECT(&psp->scu), &error_abort);=0A=
+                             OBJECT(&s->ca35.scu), &error_abort);=0A=
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c=0A=
index 8b84300e0f..9a2079668b 100644=0A=
--- a/hw/arm/aspeed_ast27x0-ssp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-ssp.c=0A=
@@ -186,11 +186,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -257,6 +257,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -270,6 +275,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0ssp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0ssp_irqmap;=0A=
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c=0A=
index e7c7b74491..674307103e 100644=0A=
--- a/hw/arm/aspeed_ast27x0-tsp.c=0A=
+++ b/hw/arm/aspeed_ast27x0-tsp.c=0A=
@@ -186,11 +186,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState=
 *dev_soc, Error **errp)=0A=
                                 &s->sram_alias);=0A=
 =0A=
     /* SCU */=0A=
-    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",=0A=
-                             &s->scu->iomem, 0,=0A=
-                             memory_region_size(&s->scu->iomem));=0A=
+    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",=0A=
+                             &a->scu->parent_obj.iomem, 0,=0A=
+                             memory_region_size(&a->scu->parent_obj.iomem)=
);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],=0A=
-                                &s->scu_alias);=0A=
+                                &a->scu_alias);=0A=
 =0A=
     /* INTC */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {=0A=
@@ -257,6 +257,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState =
*dev_soc, Error **errp)=0A=
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);=
=0A=
 }=0A=
 =0A=
+static const Property aspeed_27x0_coprocessor_properties[] =3D {=0A=
+    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,=0A=
+                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),=0A=
+};=0A=
+=0A=
 static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,=0A=
                                              const void *data)=0A=
 {=0A=
@@ -270,6 +275,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClas=
s *klass,=0A=
     /* Reason: The Aspeed Coprocessor can only be instantiated from a boar=
d */=0A=
     dc->user_creatable =3D false;=0A=
     dc->realize =3D aspeed_soc_ast27x0tsp_realize;=0A=
+    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);=0A=
 =0A=
     sc->valid_cpu_types =3D valid_cpu_types;=0A=
     sc->irqmap =3D aspeed_soc_ast27x0tsp_irqmap;=0A=
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c=0A=
index 87dcb82e1b..e84975a9c4 100644=0A=
--- a/hw/arm/aspeed_ast27x0.c=0A=
+++ b/hw/arm/aspeed_ast27x0.c=0A=
@@ -425,12 +425,12 @@ static void aspeed_soc_ast2700_init(Object *obj)=0A=
 =0A=
     object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());=0A=
 =0A=
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);=0A=
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",=0A=
+    object_initialize_child(obj, "scu", &a->scu, TYPE_ASPEED_2700_SCU);=0A=
+    qdev_prop_set_uint32(DEVICE(&a->scu), "silicon-rev",=0A=
                          sc->silicon_rev);=0A=
-    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-strap1", OBJECT(&a->scu),=0A=
                               "hw-strap1");=0A=
-    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),=0A=
+    object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),=0A=
                               "hw-prot-key");=0A=
 =0A=
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUI=
O);=0A=
@@ -794,10 +794,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                                 sc->memmap[ASPEED_DEV_VBOOTROM], &s->vboot=
rom);=0A=
 =0A=
     /* SCU */=0A=
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {=0A=
         return;=0A=
     }=0A=
-    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,=0A=
+    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->scu), 0,=0A=
                     sc->memmap[ASPEED_DEV_SCU]);=0A=
 =0A=
     /* SCU1 */=0A=
@@ -915,7 +915,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev=
, Error **errp)=0A=
         AspeedWDTClass *awc =3D ASPEED_WDT_GET_CLASS(&s->wdt[i]);=0A=
         hwaddr wdt_offset =3D sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize=
;=0A=
 =0A=
-        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu=
),=0A=
+        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&a->scu=
),=0A=
                                  &error_abort);=0A=
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {=0A=
             return;=0A=
@@ -1018,7 +1018,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *d=
ev, Error **errp)=0A=
                        aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));=0A=
 =0A=
     /* Timer */=0A=
-    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu)=
,=0A=
+    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&a->scu)=
,=0A=
                              &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {=0A=
         return;=0A=
diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor=
_common.c=0A=
index a0a4c73d08..43026d2a55 100644=0A=
--- a/hw/arm/aspeed_coprocessor_common.c=0A=
+++ b/hw/arm/aspeed_coprocessor_common.c=0A=
@@ -27,8 +27,6 @@ static const Property aspeed_coprocessor_properties[] =3D=
 {=0A=
                      TYPE_MEMORY_REGION, MemoryRegion *),=0A=
     DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REG=
ION,=0A=
                      MemoryRegion *),=0A=
-    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,=
=0A=
-                     AspeedSCUState *),=0A=
     DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,=
=0A=
                      SerialMM *),=0A=
     DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index e4160356e4..0a2dad4537 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -959,6 +959,11 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)=
=0A=
     s->regs[AST2700_HW_STRAP1] =3D s->hw_strap1;=0A=
 }=0A=
 =0A=
+static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)=0A=
+{=0A=
+    aspeed_scu_realize(dev, errp);=0A=
+}=0A=
+=0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
 {=0A=
     DeviceClass *dc =3D DEVICE_CLASS(klass);=0A=
@@ -966,6 +971,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *kla=
ss, const void *data)=0A=
 =0A=
     dc->desc =3D "ASPEED 2700 System Control Unit";=0A=
     device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);=0A=
+    dc->realize =3D aspeed_2700_scu_realize;=0A=
     asc->resets =3D ast2700_a0_resets;=0A=
     asc->calc_hpll =3D aspeed_2600_scu_calc_hpll;=0A=
     asc->get_apb =3D aspeed_2700_scu_get_apb_freq;=0A=
@@ -1097,7 +1103,7 @@ static void aspeed_2700_scuio_class_init(ObjectClass =
*klass, const void *data)=0A=
 static const TypeInfo aspeed_2700_scu_info =3D {=0A=
     .name =3D TYPE_ASPEED_2700_SCU,=0A=
     .parent =3D TYPE_ASPEED_SCU,=0A=
-    .instance_size =3D sizeof(AspeedSCUState),=0A=
+    .instance_size =3D sizeof(Aspeed2700SCUState),=0A=
     .class_init =3D aspeed_2700_scu_class_init,=0A=
 };=0A=
 =0A=
-- =0A=
2.43.0=0A=

