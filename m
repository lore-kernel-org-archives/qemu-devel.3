Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFD7C5DF80
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwG2N-0001q4-Dd; Tue, 18 Aug 2026 05:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2K-0001lj-9a; Tue, 18 Aug 2026 05:23:12 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wwG2I-0001Yk-TX; Tue, 18 Aug 2026 05:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yes9YnNcYmgGv1MJnmtsEigB/NoJN3od7RiXNJXD+19qqTRivXv79TFvhc6oM6AWVx3/CCVejtg1OAA5OXHSPLbqdOsvRDilofN0PJDNRxvnWEU5XJptX0fHRxRIyXADmQG361oPHOJ3ShBJHzwcsqor2RJhLs3CN0+1FiFOtersOJbeWBDsIiz90qGx3rKl3SMCPttqUNO+y7kSx3VDVELuPs2bWM4E/SHOnVNOsQJ6SHiAYQ8DKRdmiz6lD0AdiQPlQO6sWiogtO7MUQlbLTmWl8H9Yt9Pv7eQHZfUGElToUWqM0LT5/m+jk5QmkILO/bmhLYBeJ1EtU2um1hiEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntlPj2MxlEwQwOST03zQ2jWNYLUtZ7/9sWpUF8tXKHk=;
 b=La8U6xkhK6jVPnEQENK3LjU0MymGjRknrWBSAmJ8mevV+GxKkxJfaEBEAFCW1G4LeeRma+1d8ZZw1B8VRxqDGKFDwuyfSCpGCqpXrxl2mbBZhMC7knrznwaWbUKCeXhrD6OGyB4pXytXKOfK6GfEIaXd4k9EmUdFfZplIL1qH6djnt4p7mBjGPFxhhe34QGGe4JHt+qJ30ATQ1NtXO1xplygaYU1noZ0LnPARkChvJAC+/sg7Z11EAAr4DMbXvcVVm9bpXTpLK96QOUjQ4PtYLSfwDgUEzqFeb4wERyFHJvO1VM0OPL1I4mDwyo0YIEFU6FZLnH4FUyNPRzN88YP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntlPj2MxlEwQwOST03zQ2jWNYLUtZ7/9sWpUF8tXKHk=;
 b=fs1TcuzA8LkVBG9Vtj9B6gUNnxAiN1jrSE4Glrad7z5Io//Wsmw2nmFJu2fxT99wViLJrcGpYS7krkbWPKX/jKEzWh/cUYjNH13GmfmaMR6DDhLCZu+0N4rLpQd5wvqS3VGQONNZyjqtm1aw5x3CZfJavirkYrX8ZGISSvDLGkvCc1dsMMcfMlRvNCs91A/WiVRvNuwZ2PCn0RQHJ4cNT0vhjMvqmyfGzBTe/JCsnxLmwKgoTdf67LcQqFO3u3xm+Ru4iriyM/h1Lgzvk/kbS0zBKzYPGeb60ZFeM3CCHaBadxcOS/fVjoVRII8W5fOX5Ac6cWumxmNpmUk/Nf73PA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5982.apcprd06.prod.outlook.com (2603:1096:301:112::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 09:23:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:23:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 6/8] hw/misc/aspeed_sbc: Increase register space to 0x1000
Thread-Topic: [PATCH v1 6/8] hw/misc/aspeed_sbc: Increase register space to
 0x1000
Thread-Index: AQHdLvMq2uOlWW9HJUupTlkd9Hqmww==
Date: Tue, 18 Aug 2026 09:23:01 +0000
Message-ID: <20260818092249.602137-7-jamin_lin@aspeedtech.com>
References: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260818092249.602137-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5982:EE_
x-ms-office365-filtering-correlation-id: 049f55a5-e268-4fe6-b517-08defd0a4cdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|22082099003|18002099003|56012099006|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: rvAqQ0xySHUnq2B0bGkxn0cARc/pjwJCvcrq9mIm6Yu9u6CwzZDSf39HOT6nrnyo1jzs4aVtG2gZ3gCt9dbZRLKWnL1pKSUC5K7uKM51Ye2bq7bLG5B+icywJw1CNSKJz15kTv5qsmcimdpIalj/KYRvq+oevh2X9PSjHkIDEKlzfJXsswDpNYDJMiLkEoMJef+0qYXbqArNThWr3GnPzNbW8dqCAqaBxnGcEwMKkFdNinkw2oSUlEGG8+3AoZCUg/IS/CG4GAkTuOCKYmLvqOF5gmqlRE+SfPxyR5dz+e9dAe1atojQPDB7AhE3yEVRV6yAHZKOG+N11bdCVBRw742qUcqjUxQ5/K9JOzWbBkybc/gV++MODoH2GnoGOOBOaiio3jYjMMNZr7f2lNiIR8fR+wv6XVNpFw/rL7GbsPSeKVAbx+UQmb2Oqee28Rnbw3PlizlhtOCLNJFy2ofGTe2oYHh4O29v5Cx26G5DM09q8QCr+yGd91CjKH/Bu6PpEprGR9mJdNc1HPWUWz1m2SIhXeI0LzxbZ2xC+xD4Tn/ujOEdKdzvhcZhUjIllVFyzdHZ066t0rx91FBuXUzObUtfVG+TP4mjdUDZIIB9ClYg4x6mHd7JBsVWc5/bHba1jdy+2cU78Lz2q9AQ+pyt3sbTlFQ3gq0O4YUdhd1WpaeQz3mI+Pa1AJTzcADBoHKtCzohkl6qwxeVcl1MkPYx6pInDxwrnnzfVIeePJeV+AixM5iJVz5UU0G2aWb9yI3E
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G+BP8/9AMPNGC5LUj7yq7z/67OdC6y8JnCulcRbunp0dekci5mbJiX77TV?=
 =?iso-8859-1?Q?4Pn0MJNUfCotSrxEzEyw/w9q4s/MZjUGRcI2imBTOAW9z6aTO6TGhAPPBe?=
 =?iso-8859-1?Q?DA3ikJgE5WT3UEs7h2lJDNTnofHpICgE62RMX2kglU7C6Yb9ZiBuwpbwHv?=
 =?iso-8859-1?Q?UpI5G/xF5yMYqF7KDtHCIay54Ev7Pe/Q/GYMl+LVLAE2kpHA3D0xA/xGQ1?=
 =?iso-8859-1?Q?8K0lpzTf6s1w0BvVxRg9NvCXGtCllyaP9zEox+c0VKXe9gub7oYJz0HzwB?=
 =?iso-8859-1?Q?IimIrErx10wqWIu+CLZ8PXl+7ZGX333WwYUk4QX6VFJ2obhS9rDRuI9lq7?=
 =?iso-8859-1?Q?i3OqTVG68DzW4U3OwdtQXMlYwFxcYERB91wli6+uB5aFYi6OnveLSWWgEC?=
 =?iso-8859-1?Q?TV682bBuikjlaW+Tko1HigvDUF/LbZxqD0FMbRly+eZXxW5rmCkhI4fX8X?=
 =?iso-8859-1?Q?hWgM1KeGItz0EdrQShzy+OEKa/aRyktIwPeMgRBhTFfRLGRLAt/+DOc0+E?=
 =?iso-8859-1?Q?rMSrOC2SaKm8E4NtRcWOaoZGOR6G/y/LiDszfR+0TChaI/wv1fAkVaS4wb?=
 =?iso-8859-1?Q?lPVrb6hAFJ33OdRGPPuxvPZw9VTMCK6g0AL5+E0v/SgfYIKHtBSaYQaY0+?=
 =?iso-8859-1?Q?AWVwQ5SqQq6+EdwBI8QmHciJgXNLuZA7rrshBzhQpYPw1uN7OncEIvl15p?=
 =?iso-8859-1?Q?O5zyO5LX8zo12xWwO+xnb3N/iNEFgTtSCScSnQSbimThBCKBrNQsdEj2t2?=
 =?iso-8859-1?Q?0bEKN+7BFLC5TIXx1Oyj12NEim/jQ/mqVYZGbwJ5kMvz5YYsux/7XgTNX4?=
 =?iso-8859-1?Q?TEm0nLUQ/4PRICi3fy32SCI/NN9gPloF62UX8IsKAil6g0/1oZ+CKc5NHz?=
 =?iso-8859-1?Q?FL7OS3SvunW1w4071g4f6OqEFqTE4R5UEZ64YjkHEBc+5Yy0GlatOX0pV1?=
 =?iso-8859-1?Q?NI4WS+ZopIT2/4chTRqrbw1/0Ul5IJrYwTSyafYdBqhsff05w4lY/E7G8l?=
 =?iso-8859-1?Q?NiFMATbFDSxWJhp07blAbrR3SuPyJleaVA8mF9cgYwAs7tEbZdWES1BU0e?=
 =?iso-8859-1?Q?YunBbPoCMQZcanWNodUCASvpaTIccNFDqvMBt8+YkSUkJk+XMBYiX9zhFY?=
 =?iso-8859-1?Q?wNz3Oy30GXaT5qLgFW9J1D26Tc6taUpq5HYZypJdWGMzHwMRgun8dtSf18?=
 =?iso-8859-1?Q?dGuEhQzbjr8TqnaD2+CtP8i0hgg0FWqysiVXfvlGgOE+zF1aoa6uUJJWYT?=
 =?iso-8859-1?Q?rJq/ytRku0dgm7hdWGjfYvrxjy8dhtLmkRoThqD6P+Pf0x6pap+H0FuCx+?=
 =?iso-8859-1?Q?k4BLoRyxn49GnGmdzzEljMEuqH9XlXPXpdYo+4NGurXak1+z0N26sOBSV1?=
 =?iso-8859-1?Q?umLfZXzeiGMxpk+ptaRyr/yRjGPKXE2GQm30Gef5Lj9YvPLY8sX28MTnwf?=
 =?iso-8859-1?Q?k24OSiEig+jGEr8Ek4+FOYD4C4WI6Ll3c1lkyizj7AdPHPUpggiTX6LubT?=
 =?iso-8859-1?Q?3wZOs8qZqAA0gHhdCoCJAX7qT7OcVqWPnhrFWaLh3IzdALe2T+xoeKAbFB?=
 =?iso-8859-1?Q?70/EH5x4bEYK4zuLpTCYATodR/7iLpK9yMJA/ZLWDGDACYA+jKlp3nMcZH?=
 =?iso-8859-1?Q?f6a5zS2U++GoJHuNiLEm1SsL48mcVfvpq6KQeg3O0R208yfYVGygGnK1Ti?=
 =?iso-8859-1?Q?m+f08YGtJHbLF0HVGZZ1MmezZb2O8yD7BvFPYg9ClmBwQyHkpIeYuUYUCz?=
 =?iso-8859-1?Q?jge74UZBrZfS796au53sl7XvW0/RvuiWJH/e49qukKS4gByXGXvn29xCXW?=
 =?iso-8859-1?Q?85wgI6PPfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IQ/3C8lFpDqm4fKFOpm/wPXNzRyK3998ATRy/K2SVqHHPUJqT94UgAuxnseYXWq+OjtBLvEpn4WjqT52k1+no3PwUgKfQX6U7IRSWbA7XPagqQ23irZTvwZyxwuDBmezymydtFsd8j6tpXgU1BOwJvtNBz8xEkkKCvjYtxthHAfXLN70YhOt9+PJGcCRAYU2JP6Oeimb/IbxPkodFxSWHV+A/mxzrn4gaN3c3pEdJNiHAvu72RCCdMYR1u0FKxyFC9bxwiIsomRP6W4perrXMLr4EY3cM1tICJvkThXfuO8KaVcuOBKxu+K5B1xdWW5lr5wqAGoB1inzCK8IojdblA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049f55a5-e268-4fe6-b517-08defd0a4cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 09:23:01.3347 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iBNRIhMGiVKyULe2km2H9rJI8f+Qjq4bx2+w/+vE4gA64mqimldXZei1rY6hHZLU1PRgLHj1OfvLguWdrcvJekPe6340d/rJSkeeZ098EpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5982
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

The SBC controller register space is 0x1000.=0A=
Increase ASPEED_SBC_NR_REGS accordingly to cover the=0A=
full register space.=0A=
=0A=
Bump the VMState version to 2.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_sbc.c         | 4 ++--=0A=
 include/hw/misc/aspeed_sbc.h | 2 +-=0A=
 2 files changed, 3 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 724f4cb06c..951dde5126 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -464,8 +464,8 @@ static void aspeed_sbc_realize(DeviceState *dev, Error =
**errp)=0A=
 =0A=
 static const VMStateDescription vmstate_aspeed_sbc =3D {=0A=
     .name =3D TYPE_ASPEED_SBC,=0A=
-    .version_id =3D 1,=0A=
-    .minimum_version_id =3D 1,=0A=
+    .version_id =3D 2,=0A=
+    .minimum_version_id =3D 2,=0A=
     .fields =3D (const VMStateField[]) {=0A=
         VMSTATE_UINT32_ARRAY(regs, AspeedSBCState, ASPEED_SBC_NR_REGS),=0A=
         VMSTATE_END_OF_LIST(),=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index 9b04a10aed..e37c3a12dd 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -17,7 +17,7 @@=0A=
 #define TYPE_ASPEED_AST10X0_SBC TYPE_ASPEED_SBC "-ast10x0"=0A=
 OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)=0A=
 =0A=
-#define ASPEED_SBC_NR_REGS (0x93c >> 2)=0A=
+#define ASPEED_SBC_NR_REGS (0x1000 >> 2)=0A=
 =0A=
 #define QSR_AES                     BIT(27)=0A=
 #define QSR_RSA1024                 (0x0 << 12)=0A=
-- =0A=
2.53.0=0A=

