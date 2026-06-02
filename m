Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98253CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 05:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUHgH-0003wE-4A; Tue, 02 Jun 2026 01:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHgE-0003va-1W; Tue, 02 Jun 2026 01:28:47 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wUHg9-0002fW-ME; Tue, 02 Jun 2026 01:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWOCCIAky6ljWoJs/ihc5CzU4uOE+Sbqv2aAsa8WFIm4xxViocCI8LH7n+IucqzoTcXqU4e0LmbjvFGcVLX+2YEZ7hKrDuXf0xSFCSZqAkKbrl2NxlorQqhF+usfj5enu0QxO1KNjuE/hgE6ZZaLvSt1Hu4+tNxNyMtAvvt6fnxkSSMHqLNpG7UGvu0sh+yi+jJPBoPZ0TdSFuugXu3z3qb0gQYknxd/hcdDpP3RGYJAwzhnHXjhwZ2jsI24/jsrP1ahmHJg1bRfJLdb6qazxvnAfB2W7EtSzpDWXvMSZoZnhpnRnv9Vgi+dvZ32No082fDLvEZvLtlnKFyNzOgaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFTOTnALSubxRKNw4UWsXs+kG+DAqNtpQ+eNasnXxls=;
 b=sVQHUkbALYUoxkDThcJIV0KuYrH7Uz9mp9My6WcUuGqJ+solGkUy+rSO8HAp3rCLEE0q2K5w8OAa5Qdayjk8I5C3tKONZEtUV/s/GgcvHaRcsOzPb2HqyNo4KkLUM1MPF0JQ0oED8/7AzFJgSREFNYI/2DAqoEt8XV8IU1tioaiaKJF251SB4ImDzq689a42NeiAxi41i6l5CKbRRj9uHAk8s2rDANUw/Q8JTA9wTESXjrz7Jpq5Xdcg441tS8KXZkqvPdFH4EuBD4mrTQcULWRLn1AKJq3u7n3Nrg45cxMq9pDhlEzZSV4iIy9u0hf2UC3c+E1oBj3yQGFlu3MC5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFTOTnALSubxRKNw4UWsXs+kG+DAqNtpQ+eNasnXxls=;
 b=dZ7s66hDm8cRiosAP5IQnIp5y8M76SI9xmoLCJNkdjub5JfqT+OnZolmDpJH28CDBvoy2l0DdLzduoAjIp7+dp+bOUYCVMp+Hs4SyEGi1Tk9hZq0xfWuNoV7WMrqQh/tq8bHMVV3q5djZhEdhZG4nxxQzeOLgR5+Y8bYNkpYMsNOt/WIOCzNBT7JVv9hpb2Wjz0IiB76L7osnfVJPWS101LATZ8Sr+Zl8KNdXRryr1eOU8Tl5xVVez2thcvjqA1tERm1Ihx+Xw5+a8c8Ao9aIjbzYEl8zZ9XM/t2Ry7UYgf9IZkz3r5TaFFni6P5GBRA4MxmR2fT1Il2VvE57MmXhA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI2PR06MB5411.apcprd06.prod.outlook.com (2603:1096:4:1ee::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 05:28:31 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%5]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 05:28:31 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size
 and adjust offset
Thread-Topic: [PATCH v2 02/10] hw/i2c/aspeed_i2c: Increase AST2700 buffer mode
 size and adjust offset
Thread-Index: AQHc8lClfE7j1h0c1Ei93ZJaqVx8dg==
Date: Tue, 2 Jun 2026 05:28:30 +0000
Message-ID: <20260602052827.1535299-3-jamin_lin@aspeedtech.com>
References: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260602052827.1535299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI2PR06MB5411:EE_
x-ms-office365-filtering-correlation-id: c2ff7f91-ad53-42de-9080-08dec067c884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099006|18002099003|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: 5AkYurAw0zPLee+K2ZnNKHmb3ay+HGLa/gdYqU9XEt972DydVzFjqYVVwmAOmPX0KNQfLXZKCxcMFwfQ4aSjc455k/PdPPyQA/273/FLP0r2JnKrlZtaIvE4wmh3QMw4GSsHb2QLFTsTJv0wlolOV9d0qDYWKtohL5Gl25kf62r+0bqjy4coCNa8oxA6GpP5VGN+N0tWgYMZWVHDUSMoKDSbqqSvvuNYuBalftABOIuIQn7FcT4lxHq5mfceeqH/L3cyD4YdKhpIvYQuEgAfy0ThvBRigkXxgrJdAXSH8RKl5IgaWwbDv/DA/uwdfqOI/M9F3b0c68FNEz3JPqn9V+YBwGA6zrkGPPVmGZq9V7nVqiZmb9kWbv7wVHyIPCJGsORhDz61B3+LpawPkqcl3SdxxiKigKqASCRwczxiqmrtd0WlVJA3T/QCydg5nHAYG1yjywhUKV/V/7QotY1yVOAbbvPzTElRKst9BzTdnPnWmU91FvrWHrjN05IUGJ4cdLkD3zfi0Z5Lg8nPqFHGzKIQkN0k1+Kkd2gyXftlJmbETCfyCrIjxgEH3LS4uKfhjjE1JBJYLHn9fsdPP6Vv/kaQ0z/CUr9iHHj8jQlXTORRLBxg1OJWSdBRnQ+Ilxc0dEkkOYayoIoYase8iogwIZHkxHDnu5QMJVricnbJGPeRn2ZQB+pKyBP+YXsHaBGAtbeyGge1+2aJ33SBtY+aN9jr4Uf6Gx2xKuPNCOWuL/zW4rbCNdIyeX3n3+rn1Ed+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(18002099003)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MSchi5mOF5H6c7otzXDVKeAplGrRnV2yRj6BDClArvMqALrHRa+7RcyjcU?=
 =?iso-8859-1?Q?jyhu9Cb+dTosvIWIxCrfGxPFIsp/zAfulxPYw8oB5K2bgYHsP8ZSOkfO/H?=
 =?iso-8859-1?Q?yYPRTw0ZJINJdlNTyeItQ09fXp22IZr1lBvY5YCKfAEgyvIPVvqnNf1Rs0?=
 =?iso-8859-1?Q?ihlkYIsthIX7p6MairqUcPBaTtvm40HG3pVKwSQLI9Xqy6VW8No8L+oCgG?=
 =?iso-8859-1?Q?glH4zC2A8sVeR1x+O13g5XTIAZlasSKkj6qBVIdyCkOvA48XMVObUJSwPY?=
 =?iso-8859-1?Q?DDcPbXaIU0vj3KjNVYf4KwNXyklApq+Zzn76t0/JDrDm87dx6Ua1F/K3J6?=
 =?iso-8859-1?Q?9OkNEfmUvGvBTaJ6+If04lpl1quAG5cfSOyph0Kkqr88R9/Hz4q6n6YMcL?=
 =?iso-8859-1?Q?RCUewBQXK74dPgjAni6CaJ5latbQbWb7X9kccvoxowWrHlK4CP/1Fa+uX4?=
 =?iso-8859-1?Q?huYi5SRvAweh4H9mpNKkOhnE4vaDnP9LNigzZepKXqJhPHurlTfwgRPRua?=
 =?iso-8859-1?Q?Z+HXJ4Z0dbpDRcclhsdpLc50pszE600TJ/CgpWTm6AApcCNcuS4aa8r0Lv?=
 =?iso-8859-1?Q?b4j9rgfrOiQ8UBOFkQtJu2PZU5LmCDMtdv+Oz/O7cCbuCBd6Ho6K/Kz65s?=
 =?iso-8859-1?Q?Qtg0uoFzH40Sby4iBSMo22FO1cXZ8lpfhW08MeJ9WoTehsiiNDsD8QkRAQ?=
 =?iso-8859-1?Q?TCmMMHnfeybgelR9KKpQ9yE5JUJukujTGgXX76wa5soHloE5pU/OjBBgJZ?=
 =?iso-8859-1?Q?Hvm48pelKGueKIMWlud2nYQoqnDLMQ5Cu6vVA8HaiedS/b2q+iPf9HXlrC?=
 =?iso-8859-1?Q?5y9rxzofR6gWoJwHBgu4GgAyQ+HHIi25hB8t0QDg7oIAJDv7zHa4t8HSfn?=
 =?iso-8859-1?Q?oEq1wlZkePd7O7SB8OOwzBypLcuzy4PKkRDW4BC9LBqNJE1SP05ee7ypVd?=
 =?iso-8859-1?Q?gFSvpBbgNHf1oFVasQFomAjeNljgiA/GutdRiy4E5qJR8ngHv0G9vuu4ym?=
 =?iso-8859-1?Q?jLgKpgDv6jXfaNHZ5DDNo1KmdmQCdRjGcrzs5AfnA0o4lhSPeu0w21kNpv?=
 =?iso-8859-1?Q?fA/yrG1yWrhpXvF4z23zcOMQuLtd3eDlbFueXBDLUtjDVTD/HvZlG/3ypx?=
 =?iso-8859-1?Q?419YgxqDdEmQW+UJjg7qG/DRvg9V39QVrvifq6xNeD7LXZWxS77treoTaK?=
 =?iso-8859-1?Q?/rSgCDqTW9AzwTPJGugum4SLrRhBp4wvSHhB5LPq+5y9+JpmGECUYAbsK8?=
 =?iso-8859-1?Q?Ec4YG2FYn2Y0WEqv5Y2ZfQindDZTLbpYzAtKQVg4MD5x7G7XjwiE5NEYER?=
 =?iso-8859-1?Q?dtYDlf2D+bSt9gqGU9gspLx9HMYhgW0Uvl/r62nMRLYYf18WWbt8+S1mZ0?=
 =?iso-8859-1?Q?p+4601AmeUS7RIGYxxkU20huEeP5RQjHO7VIsN4PqxSLK25jFkRZdfdsUB?=
 =?iso-8859-1?Q?W4TGaLa+jFdZHanKioBXn3kakTZeNvV4iXVhfHIi5eTN8yQnvm9J0TfkJN?=
 =?iso-8859-1?Q?+krpL33W/osgdUuZ3OyfAa2M1dOz0OzM6YlQIDeLNJLtPFmdfREJehBHGv?=
 =?iso-8859-1?Q?RPUeLEIeYLrE+Miwq5J25jRac3/2zsgJadsxLzilZzJ/VatyhiYkcjj6g2?=
 =?iso-8859-1?Q?HVadDXlcwdmzUiCEz3x9eo/f+/yZ2uKhaLsV0V41aDlaMvRp4IaSI0pu51?=
 =?iso-8859-1?Q?pR/6KWCyDk/na92mv/Oci1DdwgxahUbDBRqydGwXJPNDLr6VT7vKk4m/L4?=
 =?iso-8859-1?Q?f8aUu/l+32gefOHLxz1NwMG9BbnpXgLm25F44ZYbKQxifTghlNf2/iy3Gk?=
 =?iso-8859-1?Q?vd7KKAWfVQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e4hrp+gcboRhu/Y/aisGd1t0RugrCU1Pv7SZnQW1w9+JLuadZ7FfO0dsBd5hq9ahXVAj+jg+i3NjuRYfKEOlPapQSgg3lAAen+4AkhNv6vQUhUM/gkr0u5bNl1VLpR3ixM2qvKH0MjBSNkDaYYHWwOynqCzoP4gcOs3JeMK3w2VaB6ABnB2D7WCSIognHReKQHEPPjgGpTp21BUSHF98q4rdCK2J4OuidFIFBe3CFzzHhykkL6en3veMwkZeBTjasfGOoTM23C243b7Mj+WnN/cJwkI9XB4FPo45w0a783cV3E9BvIqXBF5jSQafWD7RM2UwWmba7XdiAqwQ+fWtiQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ff7f91-ad53-42de-9080-08dec067c884
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 05:28:31.0165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPOB69vz/Cm+xpEr4xeczxTKM55/+RBN9SS2b/xGZjxmHqIHJ7aH1123PfhQMqjXqennPa+JjnY/+v42JUvo8u1dGV7lLeMbCS/hIe/khlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5411
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
index a6b44174f5..595b5fcf5c 100644=0A=
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
+    .minimum_version_id =3D 7,=0A=
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

