Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892C9FAD413
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 05:20:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFmSM-0007W0-NY; Thu, 23 Apr 2026 01:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSL-0007V5-Bp; Thu, 23 Apr 2026 01:18:29 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wFmSJ-0003JZ-TD; Thu, 23 Apr 2026 01:18:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBxE1DGqMF1z1BiDG+1b/D88kiTpSWTkMGNxCl4TW5ye5PbK1/oFXTHu7yXZCF/4rmOqAbspkDpUcG5MGU6K1rhHbxrkTvTtUlda2cnuALDiH19IPuD4bv03CLADy1fbpKunLWpUEV6GPEa+D62i5lx5Il/ocuozwafgO6McE4gudZtriMcAtYinQp5L3a9j1uxZhZ82Uy2K+LLJtQtXDIDEhS79TU6t7lhYYacDz+4SuXu0rEjBqEBl8kJ9LPXpmGPwEiwjlcgILuSQzBcmxXfSySwtTb19z8xGSYL4EDQHRqC2oMzHZnifiaVPq6lxjHqy3qszXmNduuqhG4B5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BKsRXVMs7h+1dZJ/njXNJKH4N4rYup2Am3UmnfBNkM=;
 b=ExducexCgZeJKSCdFdlWvumK9KVCTYzFmrUTi77a7rz8VbgdvS5b6Kr7J1rtCVRyH8EXsh1L57EyCkJo8ExUpiK/5EyPYDA8ykGbNOm9IZ8OAidi1u6sdIDbyr2Xv0oa9WhdDijel13dnW2F7Krs4BQ9tfn/Fo5B5W7W9dPNuyiDDww59DRPTKsX5Tn896zhC6fGX30tX7ht9oJwBSJ8pHnxe+R4puOewmcMbUFYbE0zDeva6prcm5BLU7KuRIRZ7HY0CAb9+2VI3VGQh8+15pdujpVlsJPQ3ipa3gXmitJOdolIeqApSix1gGMFkMlwsZEOv43r3sG1CRk6vdqhWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BKsRXVMs7h+1dZJ/njXNJKH4N4rYup2Am3UmnfBNkM=;
 b=eXiPCgmY2HoKOVv6TuilHOiGVkbEvKQq7mBln1eLP6VW1xnqYS9KZgNaZ9xMDUIKEv19814NBQJsVHDoms4zmELj0Nw08xnYOVrsIyWdhTjmNWD3AV8s0fY7ZYY1cQJ1UMDeoKOFFGxUU6+9W/IxlZPOeoQGD1gBz8BqWCvnRBz8YCQnCN+YAF06hwpqHGmT56qM0gkHjX3oWzMMyQXvmpcDLpdB+5nP9nPUlHfXwE4F8v7nxp0DxrpRIKv5VPYA1RITGGbHPVvelS1ioobENj86KfEz9O88f9X+xEhVE255al1Fm0kclJfPe4Dtx7QCSe4kF7zwiR67oFkRpGn7+g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KU4PR06MB8434.apcprd06.prod.outlook.com (2603:1096:d10:7a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 05:18:21 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 05:18:21 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "farosas@suse.de" <farosas@suse.de>
Subject: [PATCH v4 13/17] hw/usb/hcd-ehci: Implement 64-bit siTD descriptor
 addressing
Thread-Topic: [PATCH v4 13/17] hw/usb/hcd-ehci: Implement 64-bit siTD
 descriptor addressing
Thread-Index: AQHc0uCaWzPu3fc1eUyStJqmELsSgA==
Date: Thu, 23 Apr 2026 05:18:21 +0000
Message-ID: <20260423051804.362095-14-jamin_lin@aspeedtech.com>
References: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260423051804.362095-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KU4PR06MB8434:EE_
x-ms-office365-filtering-correlation-id: bc23f6ef-4889-4e01-b4a7-08dea0f7bc87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: TWcStIxSLDPjcWJa+vi28vw6OIhTdrtwcXfMaN/KJv/ajvjn6FrIG1MMZTRtDUEhUZ49CZ3wWt3wAaadMEwmy9Z+CQAF6GV2JqOkpImKcZoLnzAQMnI0lqr5hqJ3pfptsd83jDxOD7OWZxxnLq7x8Y7a8fzijD0j1JPIaV3tych4PbL5BMTBmy+362fYBiTWKzMg+OvzyPWnzrLVjGYJKi4QeIKWM0se+/cFY01CDoPfWXUIRk34xgBc//Dnm+qOtla5Ba60USUaZcXoQIr4hriFTlgCS6DrbjB4qDmFAcYPzE9t9aUrID3vuxk0pAkBOGJUnDsA18+kXeKLE3YvFfPLYD5YhnEjOBRvO54IMpOc11N/sfu65rsz64oe2PuKGHq/A/74xUBGuCL3MwZBuvTspcMVW3Qdx2rYoKrIprgz39507vEiEvNuysFmYhsPv5gHHTdcOedwg4Cr8yv3ZwkuAeJI0aYuvN9+JwLH7RIkAC3+d8oB5FKP1t5gl0DrU+XMgp6TRzPNHSyo8M1aLayabtvls696iIM91yQWwHFPxk5MaKXXAeZIbVGEAI3pbsBVItRA/OaqduJ8go8nvEzKNJm6SBUnFT0OCTzetVfn3x/C/Sy8QSv7F/S5WWSTUleZ2ulugXiGpG3w/ZR9KJ4VPpeqB0tbgzr5a3CQqrhKx8TVqKQ55Fl+i8379tUbiO6yc319O9piDPUgw8MnQ8CLphxokIQlPQ7ByBh2YMAx2bCkqVqCEyGPkqvuw256fwwX/eHtadyYboTztOfqgSZZL/GFpkV/3E7BZ+QZ7tv5erI1/sL1tsXcRCPhGTe1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k2YWUPLA0Tw3IzCIv3PVi2vbmI4KVy9Z4WNYCWx7bm0BChwBdWf6kmwCie?=
 =?iso-8859-1?Q?xd1KHYEt667V03kqjY5IOsFxHVmesV9c60mPBYf8pm1RgSWlY0WQqrTnch?=
 =?iso-8859-1?Q?ma+UwgBlP1eZTSrfdiRlPBTNgWFMeDfbay2NCmmoPjNsUnZcCJ+ZZYrKHU?=
 =?iso-8859-1?Q?KEKh4C+JC9jc/coW/m6ICcE1m2vxANJwXqz5OCYlnXfAgEM7vBO2ucWXUj?=
 =?iso-8859-1?Q?M+vY/lomIOlUOGidDS2Ad6iinZpZeON7pzHORB3EOwEUxQbY7T4HAz4e7/?=
 =?iso-8859-1?Q?B7YIABR2Kjvd7lX97ytPmlHcbyhYzh0qa3J9EXRZ1QZCS1K4q657wRmQ0+?=
 =?iso-8859-1?Q?9Ye+K4XX0kaT6NCDFQMKdEqkymzXha2Rg+gPP1zxHlaUc0xVu4A6CLqqXF?=
 =?iso-8859-1?Q?pnW7knSstEcctIyhsJqav2HSHOysxCwovG3awJMHxIy4m0NBbrVrSMHXo5?=
 =?iso-8859-1?Q?UTnqRSuLFzOGDG6yz4dYjeyIq0uxN8f5IW8wuFxbIHYKGTHaNHt49VLMcf?=
 =?iso-8859-1?Q?5w1N+y8Er3DmS+IhyWKVlki4budhpeJl4A0A/otEzY4jEuhoEUYfkrny/e?=
 =?iso-8859-1?Q?L7VnxY4BwRVEnTk9lAOQAM4k24u1e56Om/8XHq9knAEDSKeoeq84nIFRBh?=
 =?iso-8859-1?Q?2ET8P4Zk6k/SA5RUcPnmgnztvFcsSCsDPszQ2iFP47CtErxc7Fx8wraaQq?=
 =?iso-8859-1?Q?MHnuPJKgD2nLhfe/yjx7+LnIPZOPhjdCWnwHqNLjkqYwN1D4x1hM4NDsRU?=
 =?iso-8859-1?Q?hK0Dmkkrgre/KcKdGpWn0UopSTewHSyMMGverKwkIxqagdUapiMWoPHPT/?=
 =?iso-8859-1?Q?8MSI5qgIj351fVS7BdT3LRY6ZkiF4rBZIoroIVGpURlnvYcvq9QKaEOqGs?=
 =?iso-8859-1?Q?iki69qqQo1Ppo7/u66bbxi8gB0JG3V27pilvZMQ1qOYh7RnE/1D5vw13IB?=
 =?iso-8859-1?Q?gJ0Emf1+FXj5OOKpHb9w2VGOKEVQLBaozykv/O3jfXc1+FEkOaSN2mRWJ9?=
 =?iso-8859-1?Q?FRNiHQN37PSG9Y4sdybkQyMV1n1E+FDJmrs9Fo4fHWnoVc8MtU4DD6iIS7?=
 =?iso-8859-1?Q?IlgPDP/OcNgUUf7ZyVjFGJpDBsaDOU4DcEis4jr4XiBRtmNVDplAnTF4a5?=
 =?iso-8859-1?Q?dhYE4pgjxGGiPazOyfQb9fW+WWvZhGGC/T0iMR3xUrNRnUwOYbt61AOj6h?=
 =?iso-8859-1?Q?NBAZnAqn3lw3jIGji+keX6923SQLg6oi1L1Pl+p2vwSUBPy14VojE4aIcT?=
 =?iso-8859-1?Q?qzsiTy9qiGhdBDaw+4zsOebH8tUs3uVIzOHQfqETOa8wL/aHhVERsn04QQ?=
 =?iso-8859-1?Q?JPT0g8zklsw2WFMeJThVz2WWvYz+tqZw0ygEDpDgZgMyi0qg4E2sY4n9ai?=
 =?iso-8859-1?Q?mvTo2uBmvXOGYa/ryx+GgJFm2sehepNA/pHEQ+ioQXc/NTIdsykdTgAXGG?=
 =?iso-8859-1?Q?HVlbc0Gs0E2NyceKncmyHc+XRW59+lNuBIVnQ1a4n050bIoydTMRw45g7V?=
 =?iso-8859-1?Q?0Cy7R79KiXb431cEMO+1ySQjj0U6X7K+Yejy5PNH8KH4b5RtPj4iG746Tl?=
 =?iso-8859-1?Q?/F2G0cgZ93Rd8v5FOBysMxqMudgj/FdAgUxOY8MfEHQ3xiGChZqCYUlq3w?=
 =?iso-8859-1?Q?Nu88drpGSzEwtpZ38SElc6Tkp5leKtWPsVewjd2WM9yNywa2yibrErvaKd?=
 =?iso-8859-1?Q?xQvhshXW0mZAx/lL2HTxoHM7RNC+72MxlJnIvWd87DkMnObEFk/FxR/OB1?=
 =?iso-8859-1?Q?ZCUEjdxPkwID4CQvRl25l/Wtn0z+9CQjqbj6s2F4ZIfasFhvUry6kMTPqH?=
 =?iso-8859-1?Q?ziNVQBi7eQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: tubhhkfnDRc9OnfdwW55SwI0RNoRhC7LvjDpsWgY3X2uEebwg0mu8JadsqXktY3B2saBM+AIo48XJ+u9jQ5KTMHYAWNNsBzw0SA/Q+80WN5sJmUIki6LI4uw/Wqu+o8P/GgZ8+Zj33OyUsel88d9pLXDWbl2GwwSCRKeySClFISoBTRsgi/p/+LAmMrqlo0oZMmo4hz/EaR/26nezRI62+hlGWjwl3t7Lx23ltmK9Zw5PWkcEjgYSSh93Xu7VrU2qkd5sXgktKQYBmvo0I4MjW12dFfDXfVOjmSM2q1LyETVowc6vudn00H48ILHaLVXfzPwfnjtClRb3PDfkX1wfA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc23f6ef-4889-4e01-b4a7-08dea0f7bc87
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2026 05:18:21.3149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rxNh4DrSm/G3GjXogTNhelooKbRcyIgRtasMz3gW5YEgRLkcKVU6GQEEVcFwsfoDOsGwvHmvtV/1nAdviJ/GEzajvlbusJaxHGx3qShtcKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8434
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

EHCI supports 64-bit control data structure addressing when the=0A=
64-bit Addressing Capability bit in HCCPARAMS is set. In that mode,=0A=
the CTRLDSSEGMENT register provides the upper 32 bits that are=0A=
concatenated with 32-bit link pointer values to form full 64-bit=0A=
descriptor addresses (EHCI 1.0, section 2.3.5 and Appendix B).=0A=
=0A=
siTD link pointers are stored as 32-bit values and must be expanded=0A=
to full 64-bit descriptor addresses when 64-bit mode is enabled.=0A=
Update the siTD traversal path to use ehci_get_desc_addr() when=0A=
following link pointers.=0A=
=0A=
When 64-bit capability is disabled, descriptor addresses remain=0A=
32-bit and existing behaviour is unchanged.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 2 +-=0A=
 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 43a01a796f..dfeb8ef70f 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1792,7 +1792,7 @@ static int ehci_state_fetchsitd(EHCIState *ehci, int =
async)=0A=
         warn_report("Skipping active siTD");=0A=
     }=0A=
 =0A=
-    ehci_set_fetch_addr(ehci, async, sitd.next);=0A=
+    ehci_set_fetch_addr(ehci, async, ehci_get_desc_addr(ehci, sitd.next));=
=0A=
     ehci_set_state(ehci, async, EST_FETCHENTRY);=0A=
     return 1;=0A=
 }=0A=
-- =0A=
2.43.0=0A=

