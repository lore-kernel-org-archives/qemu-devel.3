Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7E8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 07:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ4uy-0005we-Sa; Wed, 12 Nov 2025 02:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJ4ux-0005w3-CE
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:05:23 -0500
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1vJ4uv-0004J6-9F
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 02:05:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yy8ZysMJpy7PdseoD/cqUVFm5KIulhTFaEwv6ffqBai9WBVnIwCthMLxtX5NZxux4mNS49ISJVQ8SW314FHIvU/wNS0IdiYsI8rzb6SkAzIpHehBie/HJ6qBSztjciLQ4+ApVLA8bXEkYdIsZU3u92elZgwHqLjnG7aqty9Ka7GccJbqAHefHuHkEmd7sdW3hJYNw4pDET3TtbxDs8feEE7FEn8xCIO+UC6vM2hgqK/TZQ5PQqRTyzaCv3v7RPB943vjEWERzziBesFaBj3PcDg6q17QNPynIirdQt/Slr7/2gVhUCyFVrUG6BN40Z79RPCtU7eONDq/YmMPusoTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gLIYmGLrwshpbVIGKC51f2nL6rYDoge3w8fpxeBMo8U=;
 b=npUE3dDbd7mHkcFEFE2UAUB9nqhlu2lI8w4FW1iCclqx5QQ9AkBnCcAlNB99keKYE7kWJXUnAk5K0Qe70pEoFmu6nUvvZf2SB6DM4tK7dq8GHMmWUvdOQD9bhYHfTHdWGKNK1g41Lmsyu7satr+1ysK9ZVPpAV8/rz8PO76H4SzxiWSdeqVywTB1AHjX6XKQEday89YaIUzuUMR+IruMX5l7jBCs+Po54ft6qW2OkGFah0Js0WZBXIAgJoKVbIEBOxIa1FTZ5WVw41dbqXckJzq7sQPjgiFNPx3sKmy+9hih7UbonlotrO/2C62RcXOtlmClJp0DoDkcD25IHZKiHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gLIYmGLrwshpbVIGKC51f2nL6rYDoge3w8fpxeBMo8U=;
 b=UdYwntFEtE0MS4N3mi9J/yekwfTzbYF8+vX0LY00+HBRnYniJdPiC+DCx8n+zIinCwfcV64dcfGdlIGVeoM+B8J4Gq/IUJcdUuMRa+4IbMfGflv9X8lb/TVs7XSBer3UPbIK3FCCHa8dIfKzj1V+NH/9y3nP5C2o/hdJDhIE8HA6XE20mOZ7YK2BOZaPYhw2ly44pmE1bNWzarZPN4e8SQkCGa3HT9LEwynHOaoC6R6M70emNgPOW+jbCSTlkikWKr5SV8kfdwhCGDbYkizUj/ogkYRjTzhOljModQXWAmSmVfnLJOJjVPGENwS4UMmBNqELlyL++mdTRLYCyGh20g==
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com (2603:10a6:20b:41a::6)
 by AMBPR04MB11720.eurprd04.prod.outlook.com (2603:10a6:20b:6f1::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:05:17 +0000
Received: from AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da]) by AM9PR04MB8487.eurprd04.prod.outlook.com
 ([fe80::1e08:e81f:d29:e1da%4]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 07:05:17 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Topic: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional
 testing of iMX8MM emulation
Thread-Index: AQHcUjR4IKJSoyibD0aCjGOoNfN43rTuH2WAgAB2bjCAAAqRsA==
Date: Wed, 12 Nov 2025 07:05:16 +0000
Message-ID: <AM9PR04MB84874E537D542ED6CD0216F387CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
References: <20251110112257.184578-1-gaurav.sharma_7@nxp.com>
 <20251110112257.184578-14-gaurav.sharma_7@nxp.com>
 <61242433-9D75-47F8-BC44-FD35748F055C@gmail.com>
 <AM9PR04MB8487682307D0672DA3F5345B87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB8487682307D0672DA3F5345B87CCA@AM9PR04MB8487.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8487:EE_|AMBPR04MB11720:EE_
x-ms-office365-filtering-correlation-id: f17a28e5-0861-49ec-9d34-08de21b9d5a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?h9Y2DqRdCXMlAFqXDZyYpb2+e19BqBKNPbCB5QnZ5sdNE2QfSgTw4U2keOaA?=
 =?us-ascii?Q?dnDn+tFRYY0IIeKDwbIZe8G9N+qo22Se/QvPCVIjIQfWQdvxqZovEWXsrxg7?=
 =?us-ascii?Q?Fm6PZdr6a05ljW2xz9eCaFMKrNT+RFWXDhyF3EZp95Jp7PouIJkmMq4SsQnE?=
 =?us-ascii?Q?Vipgl5BYd3caa06MlepLA4EUrPaAS44Qccb/aIJvxgqLwfeH7cutxwGlgvEu?=
 =?us-ascii?Q?9Wu+tDjk4ywoMOh+Xi9beoM7C0dxp3+a1TgjEefI7Q3ObT+GRyPp4ceGd7e6?=
 =?us-ascii?Q?MJRj5dbl4NlU/twXrwO/7K6Z/2E0IaKnbNQMRaOD4StSsdFCEopkpy15Efje?=
 =?us-ascii?Q?AZHhvUixUPwqBSXQhpw+OZ8xRwuIcy9EhdJ2StX7K8jBxmvPFFfEnpDOpPUG?=
 =?us-ascii?Q?pv962kicRTypMeucl+INRn2jg3qedCGZSZFy2KzCEt+J4Ju+N8aHFFjI4q6u?=
 =?us-ascii?Q?58mNbttUDEFkgsajq5IYc52vKWP/0tVT0H8KM9PLHZcgRGCjgyA7azrR2Ftn?=
 =?us-ascii?Q?djr4GhYjJzAvACgf9JPwjZz7+EuOuLmNZp5UT25g0MRuYmy8U8POcDtA+Qiw?=
 =?us-ascii?Q?zQNFq4RaAbP2bJAnZOfloUioopIGd8zQv7Xr64MpbhE4w1vZR8416c1Ha/Rh?=
 =?us-ascii?Q?DLk6yRRBZmWBBsD4yOHpNkbtsJHDyvLFMIdtCdwfBZ2v8nwibn2Bs2Enkrwu?=
 =?us-ascii?Q?ZqAMqVNyDLJXsM1FvEhgSrY0jI3lcJ0gbguxAlENZdLZk30yb3xDC4g8OyjZ?=
 =?us-ascii?Q?XiUaLnPm6su5cPNADw0Ixu6TaNTWOmtgY52QYAX3VPHfueRDMwKJEqloVuY8?=
 =?us-ascii?Q?XWgMoVtAebKUaX45LjQEdtRzfRewqdart2IafFCQiwqYJpjljkYHuAk8Y7wi?=
 =?us-ascii?Q?VibdcplfxOhS+/nPrt6WN0zKyQ+31YkEZ4YFwKkokWfRKAtiKpsXbkYHC6li?=
 =?us-ascii?Q?NNJmCvX5ouvTfsqw/ekKureCdczCoMsEVd8GBgJfy4eLJwdoJ4RHUKzlCGnD?=
 =?us-ascii?Q?Enf+8CrHp2ffnknsylEIm19oCXvw7ofgIlTQ6XBj7W30s46WyP2fkQOTv/Y4?=
 =?us-ascii?Q?TG6QPpLmGJnuTicc3w0l2mklTovy37OCw1ta1uK9fvk8vrWJnuEtvJwQFjwr?=
 =?us-ascii?Q?RN2FGs32S6VL9BiHaj+eixvZby5mvCMWDlHzf1oAzA2XRp7+PXPeK2Gq7HOK?=
 =?us-ascii?Q?pNBts0yYhJRKXFSj4YNBKdlqJ1CxMbnjaer7taRqbVLMQ/gA9TB3K46RK0tp?=
 =?us-ascii?Q?dXKD+K1zn+6BRryABzU0EUnnX5aiBMn2PQaPAVhRrjsNdBh3AwKsqmoofoGI?=
 =?us-ascii?Q?Ir5O0QNUe0sTWUJCzpfUNC6Lg4ZlChuh7Kn6Aw3UCg12LxE60uiFaham3JxS?=
 =?us-ascii?Q?zeEFeUXubb0epkMkLLLIqxaVyxS3iksQt4J3r8CqC1kuTEOM0McSJpuWr3Kz?=
 =?us-ascii?Q?Cy1KAOXhCWkzznLsSN4Jj3lxVpx1AEg6ZfDVi5AVRMOLJxlHWZ6Ao97oMcXP?=
 =?us-ascii?Q?nROFmw3I1D9EvJer7hSvPr5Ce5QCDKEL3kZN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8487.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nz/ftGuWV6XhuqnLp9/v7Nfu5K10g/PNoRUHfPXghP0ptdWBfyETL7ckkS7w?=
 =?us-ascii?Q?NdLDBOPrgMV8uycL/tbO5N+TBhx5tNTwVVL85Cj7D+dE3vlUtrhq15zorxhf?=
 =?us-ascii?Q?s5Fcxg+aZq10hY5qkFtXjtntMpFRgDyPUXRmxtxlriIXE2JI7okrxfZP0Kzo?=
 =?us-ascii?Q?+AsQ6JEL8pAqdhmy7mHV8tVBcARYaQEJpiCuBX2cT3T9unMHD78YWOmy5SXa?=
 =?us-ascii?Q?CcC4nAmRiiCQgc8UxVbiaQVGtWAgpfOq7LHNOq0wDm74bcdP8YqbIaL89qvb?=
 =?us-ascii?Q?Un0bGJ8t2oz16Yqg/0pym+/YbEw+rcBxeH3OklS3p4qBQUuVXjROJhZ3ZEFW?=
 =?us-ascii?Q?EZl3htjJr/mNNVBmO4DRzAAuSDOU99xF9sggjrq3ljeNYEJXvZ+mylTIIsjA?=
 =?us-ascii?Q?X4thONutrER7vXhnW/Gg6CvRwqq0mcjk4kYrr9Y+0jgtScNqoeOO2XlMVPss?=
 =?us-ascii?Q?4o9oVg7owVJ57rjdz8Oq/0zxthLsWIkiUjoX/7huPTw0w4Fqc5AC7AsycH/s?=
 =?us-ascii?Q?1B3CsELlHQDL/uvhKVEu99VDeNsO7T797mEwAD8UXUKpqff2PP5i2xFD9H48?=
 =?us-ascii?Q?B2jR2L0iiPYq70f1V05zRv5miKCfP/kzGLvB03InanerGM/TMHaun69C20Dy?=
 =?us-ascii?Q?7InQoLn1Zvr+XPoHVYp4WbUbx4m7qHx4jgONgGnK+6Kpv0IVoS4LFqqY/uhS?=
 =?us-ascii?Q?89eSMJCWq9qQLtgMojPxqMREVxnbZfU1ZuE8lcewfmHCuBi+IBeFjKqh3Fan?=
 =?us-ascii?Q?fHKIuXro9Dt01SNCpPaYmMVU+Yl/K6ZuitOxI06axZzH9jy8y4l/9jjRB26Y?=
 =?us-ascii?Q?gzi3ooMiail+JzI1xRDFVii6pAs208HVA8e0AhX4wnYbP2PPBM4duiBGXIf6?=
 =?us-ascii?Q?LZnUat4KtsyGHpA903n1w68daYVjjQH9ACwaSCW564J3C87vrXQvYYe9N5OM?=
 =?us-ascii?Q?p2usHL5ADytlWRKhRmmpA0rLR57vbUeEmv+5rsn2RzR5diLJeNgg7nIeZNMz?=
 =?us-ascii?Q?oWxlU59Lv1qT7fu8whXbcB72rfjJjmeGQYmTNnFZSfILkQeAtnUzXg13QaL9?=
 =?us-ascii?Q?Rlya1mFY+UesRbcVIwP3myVw3MaddkvhmiUOd1yu3dBUEn08wjF/77Ry/sMU?=
 =?us-ascii?Q?VkdaytuwNDXmn70qOnPvfq66C+xDO6iposPfXg4vppcnkXeEaHeJ2r0LNqO2?=
 =?us-ascii?Q?+Hq8bhclRbkW1YTfk8rj3V2OoZw5XCvlQOWLjNXEajk/Cuv0bEQqITpp9qU0?=
 =?us-ascii?Q?EhumwADfNuwnm0V7aeVqUVq7joadFYtd4sZ48pgyphQpblzy6uAArH9ncZ1c?=
 =?us-ascii?Q?1GPsOUJBtfJdF5BqXJ1kk+XChpWbBk670SkouRz37uvkAJG2t3b5y6sBAnX2?=
 =?us-ascii?Q?YUSMgmntO77nnBaoJ0kJa1Gk5HWegVIixFhL8EcIDuZeTMOxeSGPmW1Yq9Vp?=
 =?us-ascii?Q?KudKU2HxjtxUNmWUaLu8+vM8+yt2wkNC+3BbOY1IFaWaX1zONYi7Nrel7xeD?=
 =?us-ascii?Q?VOJefE8zh1rodVipPlr+WvDI5ZlZtwKAPHRs8rdJO54Suj0njBvuhgzECUL8?=
 =?us-ascii?Q?0PLn1SKr3LSBfffDMulHzDeyd+Sb21SjCqLRIfRT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8487.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17a28e5-0861-49ec-9d34-08de21b9d5a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:05:17.0005 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pbuqg+1W1XHSj2YtFPXTpa1XQvWjKWCqUp2aQWoA1S17smmTFbih5VQS8thpIuRntQqaSTIk8gfyZ7+6l2sX+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11720
Received-SPF: permerror client-ip=2a01:111:f403:c20a::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Sorry The correct xxd dump for dtb offset 0x64F51000:-
xxd -s 0x64F51000 -l 4 disk.raw
64f51000: e103 16aa                                ....


-----Original Message-----
From: Gaurav Sharma
Sent: 12 November 2025 12:28
To: 'Bernhard Beschow' <shentey@gmail.com>; qemu-devel@nongnu.org
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: RE: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional t=
esting of iMX8MM emulation

Thank you for reviewing Bernhard. Yes, iMX8MM is very close to iMX8MP that'=
s why I chose to stick to that structure.

" Looks like these lists are sorted alphabetically. Shall we preserve that?=
"

-- yes "tests_aarch64_system_thorough" should be sorted alphabetically pres=
erving the original order - - will modify it in v2 patch

"This DTB offset is the one for the imx8mp-evk, and in fact the console log=
 confirms it. Both machines seem to be so similar that the test passes anyw=
ay"

-- yes, I just found out in the console log. The test was giving a false po=
sitive. Thank you for the heads up!  I have now modified it to fetch the dt=
b from the Debian stable repository. Verified it's working correctly via co=
nsole log

What you need is the offset in the "disk.raw" image that gets extracted fro=
m above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk", =
then determine the offset of the preceeding "d00df00d" DTB magic. That is y=
our offset.

-- do you mean the DTB magic "d00dfeed" instead of "d00df00d"? Also, while =
I was analysing the DTB offset of the mainlined imx8mp functional testing '=
disk.raw' which has debian-12-generic-arm64-20231210-1590. The script menti=
ons the DTB_OFFSET at 0x64F51000. Dumping this offset using xxd[also verifi=
ed it via hex editor]:- # xxd -s 0x51000000 -l 4 disk.raw
51000000: 6cff 0060
It doesn't mention the DTB magic number at this offset. Please let me know =
if I am missing anything here .
Can we choose not to rely on the hardcoded offset and instead download the =
dtb from the Debian stable repository itself? This way the same functional =
test can be used easily for the future imx board porting as well.
Looking forward to your guidance.



-----Original Message-----
From: Bernhard Beschow <shentey@gmail.com>
Sent: 12 November 2025 04:51
To: qemu-devel@nongnu.org; Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: pbonzini@redhat.com; peter.maydell@linaro.org
Subject: [EXT] Re: [PATCH 13/13] hw/arm/fsl-imx8mm: Adding functional testi=
ng of iMX8MM emulation

[You don't often get email from shentey@gmail.com. Learn why this is import=
ant at https://aka.ms/LearnAboutSenderIdentification ]

Caution: This is an external email. Please take care when clicking links or=
 opening attachments. When in doubt, report the message using the 'Report t=
his email' button


Am 10. November 2025 11:22:57 UTC schrieb Gaurav Sharma <gaurav.sharma_7@nx=
p.com>:
>Added script that would validate the iMX8MM emulation by checking the
>linux console log. If it succeeds, it will return:-
>
>ok 1 test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc
>
>Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>

>Hi Gaurav!

>Nice to see another imx8 machine being contributed! I'm impressed how clos=
e you stick to the imx8mp, both in terms of structuring this series as well=
 as the code.

>I've built your series and ran the functional test. Comments below.




--

>---
> tests/functional/aarch64/meson.build        |  2 +
> tests/functional/aarch64/test_imx8mm_evk.py | 67 +++++++++++++++++++++
> 2 files changed, 69 insertions(+)
> create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py
>
>diff --git a/tests/functional/aarch64/meson.build
>b/tests/functional/aarch64/meson.build
>index 5ad52f93e1..31ecedbf6f 100644
>--- a/tests/functional/aarch64/meson.build
>+++ b/tests/functional/aarch64/meson.build
>@@ -5,6 +5,7 @@ test_aarch64_timeouts =3D {
>   'aspeed_ast2700fc' : 600,
>   'device_passthrough' : 720,
>   'imx8mp_evk' : 240,
>+  'imx8mm_evk' : 240,
>   'raspi4' : 480,
>   'reverse_debug' : 180,
>   'rme_virt' : 1200,
>@@ -28,6 +29,7 @@ tests_aarch64_system_thorough =3D [
>   'device_passthrough',
>   'hotplug_pci',
>   'imx8mp_evk',
>+  'imx8mm_evk',

Looks like these lists are sorted alphabetically. Shall we preserve that?

>   'kvm',
>   'multiprocess',
>   'raspi3',
>diff --git a/tests/functional/aarch64/test_imx8mm_evk.py
>b/tests/functional/aarch64/test_imx8mm_evk.py
>new file mode 100755
>index 0000000000..d5eb43afc6
>--- /dev/null
>+++ b/tests/functional/aarch64/test_imx8mm_evk.py
>@@ -0,0 +1,67 @@
>+#!/usr/bin/env python3
>+#
>+# Functional test that boots a Linux kernel and checks the console # #
>+SPDX-License-Identifier: GPL-2.0-or-later
>+
>+from qemu_test import LinuxKernelTest, Asset
>+
>+class Imx8mmEvkMachine(LinuxKernelTest):
>+
>+    ASSET_IMAGE =3D Asset(
>+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
>+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
>+
>+ '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
>+
>+    KERNEL_OFFSET =3D 0x51000000
>+    KERNEL_SIZE =3D 32622528
>+    INITRD_OFFSET =3D 0x76000000
>+    INITRD_SIZE =3D 30987766
>+    DTB_OFFSET =3D 0x64F51000

This DTB offset is the one for the imx8mp-evk, and in fact the console log =
confirms it. Both machines seem to be so similar that the test passes anywa=
y.

What you need is the offset in the "disk.raw" image that gets extracted fro=
m above file. Open "disk.raw" in a hex editor and search for "imx8mm-evk", =
then determine the offset of the preceeding "d00df00d" DTB magic. That is y=
our offset.

Best regards,
Bernhard

>+    DTB_SIZE =3D 45 * 1024
>+
>+    def extract(self, in_path, out_path, offset, size):
>+        try:
>+            with open(in_path, "rb") as source:
>+                source.seek(offset)
>+                data =3D source.read(size)
>+            with open(out_path, "wb") as target:
>+                target.write(data)
>+        except (IOError, ValueError) as e:
>+            self.log.error(f"Failed to extract {out_path}: {e}")
>+            raise
>+
>+    def setUp(self):
>+        super().setUp()
>+
>+        self.image_path =3D self.scratch_file("disk.raw")
>+        self.kernel_path =3D self.scratch_file("linux")
>+        self.initrd_path =3D self.scratch_file("initrd.zstd")
>+        self.dtb_path =3D self.scratch_file("imx8mm-evk.dtb")
>+
>+        self.archive_extract(self.ASSET_IMAGE)
>+        self.extract(self.image_path, self.kernel_path,
>+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
>+        self.extract(self.image_path, self.initrd_path,
>+                     self.INITRD_OFFSET, self.INITRD_SIZE)
>+        self.extract(self.image_path, self.dtb_path,
>+                     self.DTB_OFFSET, self.DTB_SIZE)
>+
>+    def test_aarch64_imx8mm_evk_usdhc(self):
>+        self.require_accelerator("tcg")
>+        self.set_machine('imx8mm-evk')
>+        self.vm.set_console(console_index=3D1)
>+        self.vm.add_args('-m', '2G',
>+                         '-smp', '4',
>+                         '-kernel', self.kernel_path,
>+                         '-initrd', self.initrd_path,
>+                         '-dtb', self.dtb_path,
>+                         '-append', 'root=3D/dev/mmcblk2p1',
>+                         '-drive', f'file=3D{self.image_path},if=3Dsd,bus=
=3D2,'
>+
>+ 'format=3Draw,id=3Dmmcblk2,snapshot=3Don')
>+
>+        self.vm.launch()
>+        self.wait_for_console_pattern('Welcome to ')
>+
>+if __name__ =3D=3D '__main__':
>+    LinuxKernelTest.main()

