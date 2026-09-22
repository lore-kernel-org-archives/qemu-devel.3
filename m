Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6959C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wOR-0007ag-21; Tue, 22 Sep 2026 05:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOL-0007XE-OH; Tue, 22 Sep 2026 05:02:21 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x8wOK-0002CW-05; Tue, 22 Sep 2026 05:02:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSQGDLlY3YsNicJYckMXnz4wbtDVy9ciT0aXjF2ddO0ghJ9K8tQavboqZHKZtpiEBkeMAXf2J3XWzxez2+Xl71M/hUaBOW3GatfDRvLz8dO/X/D2PkUbYO+JDwLBSS/omtpYpU3aIOUkFJT4xx+TZ2IjuKAjEdf9F9JoyF8vLgzGCc/FWZSM5pt52ATTgiutWbFoG4nViQkhx17vAD/c+Q5C7974NG43oj654iDdXoL9CWI0PnjvMLL1+POQk12txAYj0MhgZfSnObZ7+Gy2bj6nBXJAie7vmk6EyeGP4GK1MVPn1gDbgDikdNtDHv1VLyGzsd1twgAgnx7EKbRxBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0L/Mwf1RIAr6N98ejl9UawWtjiPcD18EIT02CW9iHM=;
 b=isg8ZhaBTeE0FEATBig8czkCP3xJxQGC8d2MQYHVlzagl8cpOOqJbNzbwRvmAs/vZWnp/PuJWfUnKFk7dJCAVy2b+7aZstE+G1eKRPBq1suUg2kUZGUeBzkCGpbmXZWremiANoQp5eHC2wdIKIxfEOp80wjdNPCFZByjBxlim+T/pve7lwEdf8x9zUF7IeEUISs9jv9nK8F2II+MPSNsJOoDpD+jThkk/aWbui7qmH8gfAJrkKa7RNWqJ/cy3oOFklqEYvOLeWH3Q8F7jdUcLOfL5ppFOC+EnpDvgBrQ99wm47+AZyvvjg9maaRKArq3Ev38rVoJ3te07vFhMey81w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0L/Mwf1RIAr6N98ejl9UawWtjiPcD18EIT02CW9iHM=;
 b=DZ5A9dlkvNWbmEF6jf0r77ZaZk7AYknzs7/mOATRLuBc+x35Gmg/SopOLFQ8xqRH0C5OJAlhbNqo71+UT4Y1s3rzl9LnHVfJW9Uc1O+x2C/h1X9DENTn544D+KRS0w94lwQ9ie9jo2wqy23zSLWMaywCmT+B2yBtzAc9xGTsRbNrOow889J7KiL1Hgp2wY4p69zOJd9R44gUFHb9Vj1MDcG+cxN5LxZtVyLyhdwEVD1V5tk8rpP0YvOjdOnsQW4hl5snd+YMuBdF3DGXtMWid7lOuy67y225kFCrvd8ns6hVSRQ7CEpZvA++PY4sQynQrvEhpmMkn8A1w/IcOeHkEg==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TY1PPFFE5B965AC.apcprd06.prod.outlook.com (2603:1096:408::933)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 09:02:09 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 09:02:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 11/19] hw/usb/aspeed-udc: Clear EP_POOL_ACK when no
 endpoint ack is left
Thread-Topic: [PATCH v1 11/19] hw/usb/aspeed-udc: Clear EP_POOL_ACK when no
 endpoint ack is left
Thread-Index: AQHdSnEMR2xlAsgw/kuAYZPi1utrtg==
Date: Tue, 22 Sep 2026 09:02:09 +0000
Message-ID: <20260922090154.1792077-12-jamin_lin@aspeedtech.com>
References: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260922090154.1792077-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TY1PPFFE5B965AC:EE_
x-ms-office365-filtering-correlation-id: a2690d85-52e0-407b-20da-08df18882efe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|22082099003|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info: CjwMeGQowFiNGLdarsJUZUd5/quIoVeYcJv+Om/fz6JuohAYk249j+QO+0HZ3VT/lpCoJo/WAC0hlvlDeCq8xqXB8KepVIbUnnH8rSCHj8r+NQExcjQWRXeX6cNy9/lgqd5r862bhk4k4zvPWQEVrdrmwz4VtSKWUMS9Ws0EdxT0NWJ9kPoe+3s465i4ZhHUzx635uXpDoL65Qz+wyhXopK0ZvaqEzLjaVbgLyUrWtHSyUw7WdqBq8Kjmlv7k+OnumnYC0VxDkTG0/9I15Qhb+QDndEiaazx1w+tzRIAv+Lc39smRINSOH7XVNEDq/3oANk0Y03g+NpaWmcPc/VrP3QzNWHGMgstFVkRlTnieznk5+GPxegSHByGXBUnVVMoq5TzHlt/2MullnAo3khwI/4ewAmrEkgDNyET1T9YWIbIPgesmX/LyktOkpHcnThXp0ajI6BbxvISqDEZQ9Sv7HNYd8rQfVEL4LS2NNBqxin4swYUbc6rMoVxO8iI/HrIunsEzei26ptjD/LBmtkQasA4VJ/XqXXPuo5tV8nmugs2pAc5jJGNjhGhfW7eSLMe2ZnM7cBhUZ5xIWfg9MBVY+SDifjDmRUp8gOjKJAMq+VCSwCLASC27XViOsWumQf/UI5w27l7B5AHNGSvP/4+fB7Sn+mwTLxwacxmgHOfrYmFOwnmOsTELFIzU/E3Rs8gmwyc3jKb+49cwBeWGGLH9i21BZfT5Ho10pcqURi/eyc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(22082099003)(18002099003)(38070700021)(56012099006)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OYh6BZVmOgRcTAvc8I0AO2/8nrx1h7IV570toTQz6/iTbZEl5nkYcLb33u?=
 =?iso-8859-1?Q?iGXsPHbWwsMSMSJGvuNcBYk5lXGYK3eB/+U37CLx27KyY6Li3I3t2DyIzP?=
 =?iso-8859-1?Q?fXvXrp/pD2t6GkTJr3OZ6y0uwMBLSmiS6kz3Sdf5eF1eCibod9YkLD9+De?=
 =?iso-8859-1?Q?GAEs0vUnVVmdIxcUrR5O6bdykIigvabCgPfEB9ZYgLrWCMIemUAcLYqbxR?=
 =?iso-8859-1?Q?r6e7bQq2W/3nlJ/7fgdh/X0o6HObkH04jHENUxpJ396JOR9btGP7snwXiF?=
 =?iso-8859-1?Q?tgpTaut++Z9G2WjQ7pbvpXwwxGgkDECmnjdRIaqsNacIT05Zx/39czAMWY?=
 =?iso-8859-1?Q?mGRg1A3JkqlQvRw6xY0j5dUN7uaH4QsCuxJahWkvGz8HYGLjObc8soK9aP?=
 =?iso-8859-1?Q?cMMluVCgyVBtrUeZuvvVrIzK3ZN6S7J3M4qPYQj6IOeOIlck/w+5JN/qRf?=
 =?iso-8859-1?Q?H5qiqhD+Xyd5QicOeJHJDZ08wsBqc3CGRjuDpU6XlLgSqRkiu0zRUehY5Y?=
 =?iso-8859-1?Q?T1fQRbRdxuKH5XjhumGMnRDuYPgbUZGE1Eju8MMGgWUU60YIDFEScKfdtc?=
 =?iso-8859-1?Q?pBsI46GMbHKIXyANuKJ56ht37lgCWgOJcJp4JdLsgDHc66Jo+qP4+nZzhm?=
 =?iso-8859-1?Q?Shrk1zgfV9LtJrXO6nyGs073V5lBuWbtO9M+M+yJkQJjsknLSzqGKMTbFa?=
 =?iso-8859-1?Q?7P23oRDC96UGQHAdM+NiAnVDntLCqli8+35bdDgmaPl1ORlsxa/NTrjIVe?=
 =?iso-8859-1?Q?gQWlKTmHZcaN3fod/sc3XZBak0/JT30YJPjf3bSxJ+E4fRY0xgwEDI6bMa?=
 =?iso-8859-1?Q?8R9pzIAecLSMnPj+F066sPhqrNpIUNIZYy+OX83jp+EqYglzLZLhbU+Fm/?=
 =?iso-8859-1?Q?V93i+GRum5O8Yx0rwBH9qqBv0l4Qq18jswZvTKPyDLi+PZxJxYUaoSt88v?=
 =?iso-8859-1?Q?1ITXPB+MO9XtehlU9EtrWkg/Tny2ps6gJTmGlwE+cn2v5/PEew82xLLjcH?=
 =?iso-8859-1?Q?t8SuijLgYYAUUPAHl2TsRl9cK2mVgYaBYnd/lwarorsKhee58yMNem3JQa?=
 =?iso-8859-1?Q?HvUgv1AmvnTVQe+SauK9ckNV0diVzbuxSdVOd8I3+FTHiInA0nbO8FUQ7A?=
 =?iso-8859-1?Q?9LtD0xRhfqoLVhsYwjlE9BUmnYXoPGLfGatBdJzN67YtE+T4DXEOsHECyj?=
 =?iso-8859-1?Q?NoPhYm/R/7aIReMjk8YKEvt+CvbBbzehngEvhP46+zDpHg0WK7j7k4q/Tf?=
 =?iso-8859-1?Q?ey7BVZhQeMwmjca0FBlrSfwfpa05mPuxGpR8RfJBvM+Pnvoq0E/zXO4iuj?=
 =?iso-8859-1?Q?G1Il5H1C+8fgXgR1P2gN8QggyjV/+Bs2VqTGYEUpMW2DIEHBv6mQb7MgAt?=
 =?iso-8859-1?Q?R1PH4tWYQcKstlrLjaEnJPuwk7yyVfN/JensdwPVEFn0WvDUkAjcbi5LAj?=
 =?iso-8859-1?Q?VFsgO/8nxu9LVypICY/Qh4W+4JXry8f8emIh8Ut0k4N/nSnrrJjNbniLin?=
 =?iso-8859-1?Q?budZlJLumRdIkuxQQUI6VzaiuRTceMQ9niiB3oJn5tuQEidHPEPNuN8abC?=
 =?iso-8859-1?Q?qd52OOcLquNtYSteU+C3Do3Sp4HP/ruFsSQrMQ9GgnaScP/COKbNx5Jbtw?=
 =?iso-8859-1?Q?FbcBcNF+C6Umt2AI+7Ikl5ct4jD0ink2eqrKrQ2K21cG9vW1uZ99FUSp07?=
 =?iso-8859-1?Q?Rzy+toOn1/miN1Comu4oUOeYuXmClCYfAjr4AxRzUyRWjDETPQd7INe2uK?=
 =?iso-8859-1?Q?mXVaEjVPdHhm4tKwKRsGl+eVOd3vY0wH8V7Ivoz1tgmPopXKX4pMlMhrmQ?=
 =?iso-8859-1?Q?g1YnZ+GYUA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: T/gQ8PHwBj0D3p73TdCjv7kujQrGyC6dc81cphRAU2C9tbYDE72KPh0u3xh8Rsqf4PP/p6G/fo2tQ0iAx5Q8LwErRlLUEFV5FLAkSHVmC5BR0Eb67pJYHUH+4VhvPyxvLJcKh/xwD5tKEpM4qVCvKXVxwnBQFM3KEVYXNoNnPZFyODMLoSl82CrqC5+CPfpfmVR+skLeT4Idx83dZZ0lUN4xdJs4gZeUr9F8YNDxzbm+ZDzC/oRZamSuEOb7v5Qa9QM5CRPRBMBOiH1XOnbOFiBrhdTEsjWascxFKz1dSk6PWiN7TgfEiS3hjecd4TO3iS7fbuTH1/eiXDlfiMDf4A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2690d85-52e0-407b-20da-08df18882efe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2026 09:02:09.2319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x8fERE43aPFpuF2abvnKNnp+uvesGx+hsAQ6uLqv+N7sg3EutlBH9lUheBpCDpbBDnfqI6dm6vePbVUd2JXwqOmTChB/l0M11D9ABByOJCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFFE5B965AC
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

UDC_ISR.EP_POOL_ACK says that at least one endpoint in UDC_EP_ACK_ISR=0A=
has an ack. It is read only, so a write cannot clear it.=0A=
=0A=
Clear it when bits 3:0 of UDC_EP_ACK_ISR are all 0, which means no=0A=
programmable endpoint has an ack.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/aspeed-udc.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/hw/usb/aspeed-udc.c b/hw/usb/aspeed-udc.c=0A=
index 95fe823534..bdbd1a78b8 100644=0A=
--- a/hw/usb/aspeed-udc.c=0A=
+++ b/hw/usb/aspeed-udc.c=0A=
@@ -335,6 +335,13 @@ static void aspeed_udc_write(void *opaque, hwaddr offs=
et, uint64_t data,=0A=
         aspeed_udc_update_irq(s);=0A=
         break;=0A=
     case R_UDC_EP_ACK_ISR:=0A=
+        val &=3D 0x0000000f;=0A=
+        s->regs[reg] &=3D ~val;=0A=
+        if (!s->regs[R_UDC_EP_ACK_ISR]) {=0A=
+            s->regs[R_UDC_ISR] &=3D ~R_UDC_ISR_EP_POOL_ACK_MASK;=0A=
+        }=0A=
+        aspeed_udc_update_irq(s);=0A=
+        break;=0A=
     case R_UDC_EP_NAK_ISR:=0A=
         val &=3D 0x0000000f;=0A=
         s->regs[reg] &=3D ~val;=0A=
-- =0A=
2.53.0=0A=

