Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80D6D172D5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 06:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmnHu-00062w-IN; Mon, 02 Feb 2026 01:19:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHm-000602-Of; Mon, 02 Feb 2026 01:19:46 -0500
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vmnHk-0003N7-2h; Mon, 02 Feb 2026 01:19:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcyq1I3Er5LfYHzeYr4yJoJcHKBg/1hISkteulOy+zHD7lEVUFkhpgNXq1Ad7dvnXyEo4pk3gswXheoVBQA9ZtWSFt6dbzR4vCyulaM4qUdcyylq7qZmcZaw4uHxG8OVEpXXTP2MXkDGpGM8d/+KSeyvtDNZEJ+kvyjCVMhIsZ+6LtfwNjuadOePacmMpz1hpr5Z4PPlubuc1zin5ljSMg/4nSI6v3eiwsKllY9mfyWEEiKhZoOvSCt0Z9IH49KcA5L/SwrpNNwtuMEdriJ/yTiQSss5cRhgr8uHBpWh1FXOHMQ9vLvD+RGtPb1LKAPx6o2QyCaUHsx0Dq+N5t8lBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBE6dqRJJJfDrE612XY+l6DYnbsIrROFiLrFjQlS+Ss=;
 b=t+uGmLsGLUvq3+7PILDgxILJ+/F+xRumq2EyK6YRHcvSb/KyJiOiaBBQK8u+1TUKbGdoQ/4uWMae5iXRtNQMdx8ZRJuU7H1TXjaHYhCMbvbbqnU2uMrFJa1xZ7iRtqHV3N39D8MeZCatmJ6QyJQBOEg13m0wSggnA9VR46n6rNz9WHu82DypD5WqB/U9tWf/NEAVxIugiwWxMaN/7aA+4X/99rIb+qVrH887Nca+Zrr7YhRaIrNV2LpsXVgjT7oxGsvDSsY7BEPBPdqtnidFtI2wvLaKv2LW7cx6n46uOZfqU33qONDZQINFfnk6+RTZ9VKGphw1g0GtRzDmxoYnAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBE6dqRJJJfDrE612XY+l6DYnbsIrROFiLrFjQlS+Ss=;
 b=n6TXFbqc8D2x8UfGtwItpbGDgAj97DEG3iERIZwXpYO5sPJzlXfrU8a/pcq7ZS7UE2PV9Hseq5W+QY44Q9Vjemyf/Ux5bLYFtdgSD7eMpvekBWuXA0yY9fsWINMjvawN+qMSUEHlDynOmpCqoJU6x5yWswY0HoebCZvHhrUpwA1QKnh368N9eDvBPA43oriDYnr1l5vr9Xmh4tlw9cwLXkgqo3nWfWpbACe8yqwGPOq353FEGSu2/Nzfoxu6BOF7lKP/2zsME4gcOTwyxaRa5ITDTb/R4Gt+9CX8x88eIthTTveiOvV4BferhRfYSh3ErdfnfMAuUIiQjsa4w04IPQ==
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com (2603:1096:101:2f0::5)
 by SEZPR06MB5142.apcprd06.prod.outlook.com (2603:1096:101:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 06:19:30 +0000
Received: from SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b]) by SE3PR06MB8199.apcprd06.prod.outlook.com
 ([fe80::677:27ca:1e51:129b%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 06:19:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "clg@kaod.org" <clg@kaod.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 8/8] docs/system/arm/aspeed: Load raw U-Boot image in
 AST2700 boot example
Thread-Topic: [PATCH v1 8/8] docs/system/arm/aspeed: Load raw U-Boot image in
 AST2700 boot example
Thread-Index: AQHclAvkIHTCnzUeG06R43OovFmORQ==
Date: Mon, 2 Feb 2026 06:19:30 +0000
Message-ID: <SE3PR06MB8199FA4F57DA20E9DCAC06DDFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SE3PR06MB8199:EE_|SEZPR06MB5142:EE_
x-ms-office365-filtering-correlation-id: efce4969-8f1a-4c18-ffd9-08de6223068e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?CdOj0EehkZOr8wGw2AGSGeOCRYrCJ2vYts0VhL3INgrm2LPmCtTqbNvau3Vb?=
 =?us-ascii?Q?w+bYkwLG53WVD/ITb1CY9EC+QXBamZ87GBLoEqQwTOvJHeK54wkoyRzXv8YS?=
 =?us-ascii?Q?43TWPDw67bjFigiKH5js/lj0WtZKpR8Al0ijtg5IeAyZvpwWMTh+7pHts2QW?=
 =?us-ascii?Q?Ihpu3t+W1Q6bj6mBe78hSa0VwATOPikqrYhRfGRY33E4UHpFQdy5bxG/7XvW?=
 =?us-ascii?Q?6PgSfyZETK3ILDs09F/j1dO0HW3O/yhBZzotIrLmtXs7L5/kGLT8hb4TYvsx?=
 =?us-ascii?Q?zlnz+szWoJSP1WfVfBfnroMQJpWdPtsJdCL21Lu6Y52AhhOTA/DAuqpaG5NB?=
 =?us-ascii?Q?o4HoSlkjS97ZdI5UG0qGxh045cABtKaNa2jpNHdi2EwABXofLkSzOoMtmbcP?=
 =?us-ascii?Q?sYxEQfwTeSNLdj27XxcMRrIaLZW4vkF76cWj9QQ0z5OIIXU3vUbhmvOaMndO?=
 =?us-ascii?Q?FoByJakUJWW8hJQjR9b9mUMkxdEPYG+PZdSRRtnz9tvDuMJPNmhHsaIBlEVx?=
 =?us-ascii?Q?sFYM8nd7Vpvwi/n+NYDfG8VsXEuD2PBO4Qpxu4cU8SvYDxwy6C5azIfc//xJ?=
 =?us-ascii?Q?z7ObTz5pz5nKgUj1W0KgruS5yLIdkRLhFSo4AlhFVIhMYwkTYxYRKshriGjy?=
 =?us-ascii?Q?qKnjFkct51TehSzRhCa3DINClut2oX0QucGSQdlINDMZcHcf6bv8F2qZwKtZ?=
 =?us-ascii?Q?YEIQqnCcoUPTkoRxcKAQHwfRmcdGL6oEdC/fZObTDD0LcwHD1axkreLeOIxN?=
 =?us-ascii?Q?+mU8uoOLaYkki7WvBb8gSho75iIpHXRM/L8FbrrFwXgCyuhlQLdYl/jU49YY?=
 =?us-ascii?Q?AKBZB8PrBWW84bInmaMb7xslP1DlXnrvOwMhfVvSNJrRvw9T3zcrjEaLJnYW?=
 =?us-ascii?Q?InGLlrLb+FHY6o84017HE5FdakKTqDXADPZljda/r5mIpYnqhjZTiNDDhRo9?=
 =?us-ascii?Q?JuAmWl2Pa8yE14z1WdCCZ2V80+HBnAt00hvVMAgEUjoPw52tqimhvKqjgqtU?=
 =?us-ascii?Q?GmIpldN1DZyxgB7Wy3JxcqShXODcWK2jcpO286fGHciNB41utBYSxjveoj1c?=
 =?us-ascii?Q?mK4oPNM+Y6LlGQXPcC+V4l5XLoBA/oe2yNrZur2wVYDByTzCzgMswim+Vjti?=
 =?us-ascii?Q?H/LUNEP1qvHqUG6V3hgP5B+iDDGr2duqy4VgfgGKXC3ZbtA+TCefCmNnpSLH?=
 =?us-ascii?Q?MbURPOOCmTfhnxTUpMNYW1/sOOuvGnHobwWL+/a4jd291GQYVO+okvf1PRq4?=
 =?us-ascii?Q?AREgwchdzDjsLPJXoF1gd4HGaRkS9N1ze8CSOlwCIyDRryEMt2+fzKyWTTH0?=
 =?us-ascii?Q?R0pY5rhpNvSQMqjTpOpr8jNbXK5mq54MLheYahuvpqeshVsey0DsGcKTw4Y3?=
 =?us-ascii?Q?m2NGtTmEOtvAfw+xuwxmEZPCfGKz/BHBvrRWXBIlzujQOwFHFq5XWyJtCn4G?=
 =?us-ascii?Q?cohld3ia/91KYgh1VjQrWOCXS4pqvCp6Fx3ITJ8mNUMctWO+25YKOrpPb9J6?=
 =?us-ascii?Q?j9QCVUc5ix8BkdZTv/dJR7GSYpHXu9vHkILWYXU9FYZRQVvGBl7kQGpQ/RJj?=
 =?us-ascii?Q?Iy7XF75Zm1m674ux9wiXWckIfTNaiETyfkJ9TTb/DuiS1CZrIoLJV+gKefGY?=
 =?us-ascii?Q?zMYmM75C2qdrjAQnVD5Z7G2TupXIiCohUDMEzWZIE4Ju?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SE3PR06MB8199.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LdyPQJQwNnCU+IVI2J8arJ+TGRAHWokwJirhQQiRt8XDCcOmkA/kWVzIf1+s?=
 =?us-ascii?Q?oYkYeq8zHNjc3IVOUB3VEpktgYiCTuJY4que/czSO1Rs/HTH3RLhA74rMcVd?=
 =?us-ascii?Q?ZktgdZVbHurBnriLrZBXcnztO9ddqJ61y/ydSvHUhNqmAdOeQohuDIrmTWl2?=
 =?us-ascii?Q?3A0VozPaSKs90EczdB34cwfXnF+z7uEbjf76hl2qshMVtGR8V/prJ41NtwBh?=
 =?us-ascii?Q?BRxmDYWrgHisTGvBLq2TqQLIrv3N/5nLOLX3qmDdsj0IqEIXaBGhZ4Sbga+O?=
 =?us-ascii?Q?KjVNCLaZ1Jizghpvc1j7DIdMlRckV+6aliBQjB9cmmDtVRIB1R2sdGsny/L9?=
 =?us-ascii?Q?VF0FmhygIcc2QnwzOJ9N7aqSPuBpjgI+OIxXpq0azI7CsYqS6x4jIdhDXU0T?=
 =?us-ascii?Q?mLK1Yjb7+b2yD8bvsO6DJ1LZY+AVwx92D6xiNzwaaaglWaMRvxHZWTfxfkky?=
 =?us-ascii?Q?uM+I42WXt0ycfSNJhaPhCKWG7JE16dNNbbcIU3N5ni2PIXmGFLILObCKAoBR?=
 =?us-ascii?Q?qcjEbzBbpH2Zhoj4DX2+hLLASrvI0Ietm+fXYiPxMMf2UeoqK4akhAYjKo0j?=
 =?us-ascii?Q?PfO8iF861qLXO7U8DncOkrjFIt5+m3dM1S1oSb3h04TNM8znvUqZjGm4Tdyi?=
 =?us-ascii?Q?PrVH25FOO/C77YWLfd5pjykyniGEXaMHEMatrSHmya7bHoGoO85DOXI9k93L?=
 =?us-ascii?Q?sLftXDzANrFUxSDXDDTFauv1mpVbOQbWDMgnWg3GYmUQlDbO2VQ5mOUU5GHF?=
 =?us-ascii?Q?sORVB3oXrKENceHIuglSKPvydLha9Qbqk5Qx8fBYu7o4hREPqQP1Vtdz0/6F?=
 =?us-ascii?Q?NeWANY4Xy05jR3Da2/OH9nl57ufkv0ghINfpCBBJd0aq+zKmIUY+9ZV4O5y4?=
 =?us-ascii?Q?3uaZJTzsd/+zTWmjwFWT+fzRPL761NpXzbWXzhQixjxS/Yb9QAYGmQX62QVt?=
 =?us-ascii?Q?v5L3ncSChHleTsjwwap1MYGLobncB2ou6+Zzz9ENJvkBtArGplxdiJfSeWjy?=
 =?us-ascii?Q?OXuVTP+6asnzgNpQEcam1WCKtFLTWkfEmGLX42R1TvVvrW4jih8Gg7f7dyWW?=
 =?us-ascii?Q?FojBHxUEIE+KrEoszUG/3tuXsEQ2oTI1pzFK3My+h+RC3MptSFIO+00/Khwk?=
 =?us-ascii?Q?+UEXZbaxVptGF/t4zxVQ3ItYEOysJaHYpleuI9XYOzaFPv9ThSWhNiV4sVap?=
 =?us-ascii?Q?ZizwZpdJdajKPUOU6+uSq/zAamzJab3wQbkTnYK8hULR6UIXswwvVN4q88uF?=
 =?us-ascii?Q?c0yvC5NZTUq+uRAjMDWV/zk1+74eRK7KYa0YU52Uk9AnqtNpHYmggERaGcVD?=
 =?us-ascii?Q?d/x7fKZjQSm2+Pajz0ov2HN1RC9ZBIXmnuYTEKML8SX9N+v6OdEeY9UWWgNe?=
 =?us-ascii?Q?APEcUOj/nar8PylWreAH+9aKsw/sjpkZ8calROSLxJw0nFB6lOjrqF+0P72t?=
 =?us-ascii?Q?KTxl4ZMNDnGJncZwggYagPrsJ3+RGGSdDoNdEEwwE9WP6yjLReYA2RzVa1OY?=
 =?us-ascii?Q?N2cz8+JQafUDNXKo6f0wUOv27rZj5M6QRXaSd92s/2R9lcCDFyOu9GHvyZR2?=
 =?us-ascii?Q?9Pf8yQI6DYODTstgLk5pHLaFfDqybl+vt6ayboC6lEqzMdT8WvjYBY5rhKKQ?=
 =?us-ascii?Q?fBnzXxctegBHuFCUk6l/PB2fAksoaytrl218ThQLDQnhpfudczmGIzsOT1u8?=
 =?us-ascii?Q?0DHSBTeU75Ufr720Vv+VUGu3QHBHvuHALNutxb8+ynAUrIQ7zNaU4Rt2O27G?=
 =?us-ascii?Q?Nq5DZfttMw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SE3PR06MB8199.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efce4969-8f1a-4c18-ffd9-08de6223068e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 06:19:30.6498 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IuE4HkxC+Dz7ZfIgEBjD0VSXM8EdvQJPdLzBFUr109j3U1NXnj9lp/gEgLCUFSJS/87mxKIduYz1BMVTbkUi7miBpqdrIGMJ0FcxZvLPoA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5142
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

From: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
=0A=
Recent SDK versions no longer provide a U-Boot FIT image, and U-Boot is=0A=
now built as a single raw binary. Update the documentation to load the=0A=
raw u-boot.bin image directly.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 docs/system/arm/aspeed.rst | 8 ++------=0A=
 1 file changed, 2 insertions(+), 6 deletions(-)=0A=
=0A=
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst=0A=
index 97e14b7d33..d0054a7dbb 100644=0A=
--- a/docs/system/arm/aspeed.rst=0A=
+++ b/docs/system/arm/aspeed.rst=0A=
@@ -350,11 +350,9 @@ corresponds to the BL31 image load address.=0A=
 .. code-block:: bash=0A=
 =0A=
   IMGDIR=3Dast2700-default=0A=
-  UBOOT_SIZE=3D$(stat --format=3D%s -L ${IMGDIR}/u-boot-nodtb.bin)=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700-evb \=0A=
-       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot-nodtb.bin \=0A=
-       -device loader,force-raw=3Don,addr=3D$((0x400000000 + ${UBOOT_SIZE}=
)),file=3D${IMGDIR}/u-boot.dtb \=0A=
+       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
@@ -409,11 +407,9 @@ Steps to boot the AST2700fc machine:=0A=
 .. code-block:: bash=0A=
 =0A=
   IMGDIR=3Dast2700-default=0A=
-  UBOOT_SIZE=3D$(stat --format=3D%s -L ${IMGDIR}/u-boot-nodtb.bin)=0A=
 =0A=
   $ qemu-system-aarch64 -M ast2700fc \=0A=
-       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot-nodtb.bin \=0A=
-       -device loader,force-raw=3Don,addr=3D$((0x400000000 + ${UBOOT_SIZE}=
)),file=3D${IMGDIR}/u-boot.dtb \=0A=
+       -device loader,force-raw=3Don,addr=3D0x400000000,file=3D${IMGDIR}/u=
-boot.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430000000,file=3D${IMGDIR}/b=
l31.bin \=0A=
        -device loader,force-raw=3Don,addr=3D0x430080000,file=3D${IMGDIR}/o=
ptee/tee-raw.bin \=0A=
        -device loader,cpu-num=3D0,addr=3D0x430000000 \=0A=
-- =0A=
2.43.0=0A=
=0A=

