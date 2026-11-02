Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9E606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=MFRbz6qX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNoGH-0007be-LG; Mon, 02 Nov 2026 04:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFi-0007OM-C9; Mon, 02 Nov 2026 04:23:01 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xNoFP-0000ZW-Q8; Mon, 02 Nov 2026 04:22:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMkt6zXOXWZ9STLsjYPmZq2oqTvI5Yv9x2Ew3Zb/M6Myg07gQ2UrtOgnb0nE5T6Oi4sBczFa1vZO2n/LRUQnF7MUZ5pxxVPyzFsoekL7px7q/WkXSEtGtkUmy+jO7ZRcsfp3zPg2qL8DK0rnuwAcjBvEp4TECwOovUCuRfjiyXuNS1/19NkSvh5wZKAzxHqCo+DkC9xx0kfVLvN9z7s3CpKdsDama8i2NXkaMEWQ/Pvhb74YXGdrpnTmiqOu7UnNB8xjDSgXSTRMlVEzK+8xBMNR9wIgfBilUVC1k9ACtzA0qiJnt0Fvk71E4xXnl5cLz6i31ypvwNb41k/mt7lhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLj2Owmud6dzaDoLDIP99lKup2W+/g/vdyQI4KPNKSE=;
 b=IaRlO1ojuwbnIKd8aAvtwFUDtUDnYDn6cp6i/4gewptoCjsLmwoLyJtxJOmxkieIMjMCOoM94P7zSf2zpNipv616bbPqFc7DpRuss1v0aqFNSFrSoCDiVIpu7LkKHwQ7KYjJFWQ2OgY6rs41WJuERs0q1Idfc+uR+tq+TO4D9z+bWMRyTtEjMf4V1gxHAIP01RnHy1hlsdiXDaHDCuMp/veR78fPOZ1jxaNt/7294/GKzMHR29M7Hv0sGweJp6r3WOEmej2lTiHTt9b2KYJzD0FnzQ5VH16mBeulAKf9WYla3uJ2iAbI26ZQasD2hws9uLIlSgkYmJxy1vsfj+JUHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLj2Owmud6dzaDoLDIP99lKup2W+/g/vdyQI4KPNKSE=;
 b=MFRbz6qX4GmRSinnIy68eLtU2XGPqOHd4SWp2eOZT1L4OXCJzqJloOrpbD6jRKMMU+fgt7f/W89/BCZ4GXeyl21I/6VihoAhZQZxl/6MHvC3mqAR+UPxWsuS0g07TLsSlfR0Ki5e5K35vhGFQxqa1AJLowBUP0xC3MU5qiPoGzXCJR8klYk89r3mAcBeVqB67p8mYZGzyDrNpU4tg8f8NCBQGbcohAWGHHnluULGp/196rauJrHBnr9uUNtUyYE6OkTMFL/e7TeLG30tYM/qWx4oaHW8BQsqPiH9la467fo2nuFPMggtYneNdGMsKcp+k+aBi3IE7kxgQLBz7UVF1A==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by KL1PR06MB6110.apcprd06.prod.outlook.com (2603:1096:820:d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 09:22:30 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 09:22:29 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "kraxel@redhat.com" <kraxel@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "junjie.cao@intel.com" <junjie.cao@intel.com>, 
 "junjie.cao@linux.dev" <junjie.cao@linux.dev>, "clg@kaod.org" <clg@kaod.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Peter Maydell
 <peter.maydell@linaro.org>, Kane Chen <kane_chen@aspeedtech.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, Tyrone
 Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, Zhao Liu
 <zhao1.liu@intel.com>, Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v8 15/18] hw/usb/redirect-server: Implement bulk and interrupt
 transfers
Thread-Topic: [PATCH v8 15/18] hw/usb/redirect-server: Implement bulk and
 interrupt transfers
Thread-Index: AQHdaqurF85yHNDEXEKWX5f/X6p+yA==
Date: Mon, 2 Nov 2026 09:22:24 +0000
Message-ID: <20261102092201.1729245-16-jamin_lin@aspeedtech.com>
References: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261102092201.1729245-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|KL1PR06MB6110:EE_
x-ms-office365-filtering-correlation-id: 5ce4b888-b41a-443d-1531-08df38c2d0f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|7416014|376014|921020|38070700021|261021135927099003|5023799004|56012099006|261009223027099003|261009221227099003|261028144727099003|261021121427099003|261021123027099003|261021133027099003|261021130227099003|261026135527099003|261026130827099003|261022115727099003|261022105027099003|261022113327099003|261026140227099003|261026121527099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: R5qJ1FDPt8ncC7fdwx1+bVVG37yfo/KX5YEZzdGmY1aa6UYAaN0XqGpDiKO0A6/apBOEaYJYQ3wTSB5hgyWjQSU6QymlVDy/tHrwCETTlKQHUEJUvpCbc3LVGyCcyOa0bXZbDX/pDAMCyEpbkGXf/nZo2kSb0w547XemDE1G5jteqBbpA5wlrbuPqfU6SwfZHsDecZIlXuRwZFyRuH/ORXgbQmtwuuQOT0AdHnSnW0ey3yxlys0l/sA4uT9xjgVokT8Hr3r6ML/TCs7/jDRUdy01u27EMyTbs5Tx0d3PGbf4CrC2TyuEVdha6s7miHbeVhXdNis7Vtolk20cc2DFvGioJ/KWV0w8GjrbJ6BCo+Cwh1VC/A/ciTHehNIw/hs8439Tve4LtqUHcp8WRfWuZ/Ey5LDRJ+rkMNGd//yaAXRMhhaHss+tpzwyoG6p6PGuY70NDeNsBTjEfG/qAD4Lentk4duGeD9EmzxflVv15z05qiF/iKYo7c98m9WAY6PdKsIUBUd2SOVNlTlXpdE+wmlFRObcc81luDE1bJjx87rkm+wOIGyjzWGvsK2psGvt/GFeIqQCFo+ZGY7MKkuFW/58rZUFz6sq4YZvJRy3d4KwO/MBE/6cwHknVdl7yV/wmi79nTckrowdfARMmShtoFzzrqvKt7pzhzBa6AGz87g+Ax9+klqc2vh/i9mSmr1OL5Gw/+xqoI5x4gQth4JOv2eck5p0Gfo2a/JMJVle0+V+fA9VYffhPkpLgg3Kd9t6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(921020)(38070700021)(261021135927099003)(5023799004)(56012099006)(261009223027099003)(261009221227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021133027099003)(261021130227099003)(261026135527099003)(261026130827099003)(261022115727099003)(261022105027099003)(261022113327099003)(261026140227099003)(261026121527099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l6/9uvfvlpTVCFvc9+dwZvXIJU2Ifw6D1b1HMCf6kh8HN4dvVZQ3wDUIph?=
 =?iso-8859-1?Q?eee19/E0tRqDH+J1Wy7FdDOyV/uHJDGWSKtiL7/Eyz0MAzKV9TBGvm7AJH?=
 =?iso-8859-1?Q?zu12mZaIB6Xm6guSSk78kKJctokC+3cIF23Hq+5Xzfza7m9uwj4JQvwkar?=
 =?iso-8859-1?Q?X/1g6gsLvRguHXqzWVUSy2OBhTHettds6w2k1Q++0RWVvYCYre8HSraOj0?=
 =?iso-8859-1?Q?ja5wBYV5KYLBqyrhbs1G7Rnc8LRkXqWFZeLY5iJZS61b7h+/QXv2cZ11DV?=
 =?iso-8859-1?Q?2klHncfv1N+q7A6nIr69FyzU4UEFYl8kvvskPyCu6/+SKm37S3cU9XAqhZ?=
 =?iso-8859-1?Q?40ylOortiGyYKfN1x5aDWVkGyuTVWGbXFsa3rcACdOev5hgQGyvzDCdZff?=
 =?iso-8859-1?Q?2drnJybIxFFHisOWL49CAG/rLxgwxkxCarQwOD61XgG8gwljQo/h77NZ1m?=
 =?iso-8859-1?Q?IxcgtFskmb3lJzhj5yOfx+JnQjhDAFJCT4/HPFS63Z1ex/F9EdMfyZz8ZO?=
 =?iso-8859-1?Q?7MVPyXKNuDR2BQ0aPhhkhmV/Q+l8dqdrdOrBZZQ36P6cNd8OBnLg8/E/dS?=
 =?iso-8859-1?Q?rP8j9jbrjV+GoTpxi1gQU8gL2mkmcT0SxVe2ZO83/JsQ8RsGR544panI7e?=
 =?iso-8859-1?Q?RbBwl1+8/o5iyZKNahZu6HEUrADJqtlYqpELaxDrU5Xy+jeeE9A+h6H3et?=
 =?iso-8859-1?Q?UXKEI0Q0zByxtFJDOnlnmya+avsp68iQZi/XWnOvN9tRXjmCKArVT+yZlF?=
 =?iso-8859-1?Q?HzxMI3pCwhqRoXAvR88e51DSLHJgPayaLsx8aDOeVmp+BarTZx+ixfVKGT?=
 =?iso-8859-1?Q?YJA1fDjJ0DQyY3pJyEMDgDLPzNj8U8hUO8LE4YdHJ1YF5jcA2XI5Oh3uPw?=
 =?iso-8859-1?Q?Nt19y6UgkB2x3+3potOoEn8h8C1BFIHYeeutDJDXoMHbxfEQlqI12opuRp?=
 =?iso-8859-1?Q?8p367KPOwafL1vRsUS7PFZfVdVCJPq3c4oJrClzx9o6+K0W39QYpToE9bB?=
 =?iso-8859-1?Q?ELUS1AG59uYilgr7dG+6R6CsaxcYBF4RpHUFaIemxT9IuacYHWWQreMUiZ?=
 =?iso-8859-1?Q?1gymEMDP4d94hJrMzmH3QXZU0WDKvvMGchj/jlSl8BDGWi/4IXcJ1KIwf1?=
 =?iso-8859-1?Q?RLrBlADx4IfREa/A3Eza9DLpH87hAITUWyFyDyYo8KZzhpMU7hBJK380kh?=
 =?iso-8859-1?Q?+UbUprRc6aEMrR+h9QDvkk8hn0BmsGS3uKoA3d8BmQxFo+62/mXj/P5up8?=
 =?iso-8859-1?Q?d7EOUbHvWpp8AXe1NBSz7XJ01NCNJSnC1rqk+9PVSwgnB4/lJJbsyLAkqE?=
 =?iso-8859-1?Q?4bKyZhBJzkmV8128PGpxBCsHFDVUpl2oQ3tWcKEHU2PDwn+qsyOk5Nii8X?=
 =?iso-8859-1?Q?prQSoUuAdKLR1bENO+AWu0UiMfJBJRAezBVM1OVJoEWLnRh2WoUQo2SyVs?=
 =?iso-8859-1?Q?bfl1HVOzLvRumDmuYYMCUkEjnIr3RaapAcNGYMTcqjsNcAwOAFtzA73Rn5?=
 =?iso-8859-1?Q?NU1vBxKUcKl71J63aYmW9VUOhpWJOL3vlRnIMmVryO//V0KRGN/RFC12CK?=
 =?iso-8859-1?Q?Y+6sOeoSJxK20gbOQCVhJmuw+zvhcWmb5kVSBi489097SIpNrO2FBNUVZS?=
 =?iso-8859-1?Q?hTeEZ2EZgVJkBL6xKAF0rkUGgKbE3K9Kc0eULAwxlVD+w5TDUQSevzSzvt?=
 =?iso-8859-1?Q?8/HWBIcMjlne/ziVOH15r+YvT6z1S9WoeUMYelTbnPgCqrv8bVzpggKLQC?=
 =?iso-8859-1?Q?P6rOl5BQO3vA1NUxvumk4nHL3v+yWfGj8OOTCsE02LK16xVj+0oKjNJBc1?=
 =?iso-8859-1?Q?iJh9IUYZlg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4e9QftlPDp8ufEb9nglbfGauXvELPv5CYRw1jsznzFrl9+5gKByZdkdA5WvfPwYXM4PD9tzVJYvxdxwjVCwpNw7+Qipvf4Zk5W8G9Q6VslTsSiIDUNBMxLE3xlxAgA+HwIdKUfdz9UpO/f92Zne1UoTxWu3v0OQBHrk83r4IoP7MYaGqT9k5KI7ZA+il4M+d+udYnm9UbYde508fA3dpFsS3FxCl/4NcX39l8ABUnp+mvkIbIGiVkl5Y28t+afyc1IHnmolSRM81VveSuVR6UMhP15NTINWHt4BDlsByGk+z5YiSb9Mr8W2H282X7fYUMhLd7bz8QX8jc/8CDlJKqw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce4b888-b41a-443d-1531-08df38c2d0f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 09:22:24.6445 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cITWlXUUB0SB1zEUy13FpSf0Ra9KGeKvcY1APpt9hTesgDzTgDCSB6G5uYhKmr60akS7duph2z4D0X62wqGym+80nSqVjxiBu9b3xj86oYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6110
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Send bulk and interrupt packets to the device and return the result to=0A=
the host. Each one is a request and an answer, so they reuse the packet=0A=
tracking and the NAK handling added for control transfers.=0A=
=0A=
A bulk request carries a 32 bit length, so the host can ask us to=0A=
allocate up to 4 GB. Refuse a request that big. Do not answer it with=0A=
fewer bytes instead: the host counts the bytes it gets back, and it=0A=
resets the device when some are missing.=0A=
=0A=
Advertise usb_redir_cap_32bits_bulk_length. We already read and write=0A=
the high half of the length, but without the capability redirect.c=0A=
asserts when its own guest asks for a transfer larger than 64KiB.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/redirect-server.c | 240 ++++++++++++++++++++++++++++++++++++++-=0A=
 hw/usb/trace-events      |   6 +=0A=
 2 files changed, 245 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/redirect-server.c b/hw/usb/redirect-server.c=0A=
index 55a1f79623..9a83cc22ef 100644=0A=
--- a/hw/usb/redirect-server.c=0A=
+++ b/hw/usb/redirect-server.c=0A=
@@ -90,7 +90,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(USBRedirServer, USB_REDIR_SER=
VER)=0A=
  */=0A=
 #define USBREDIR_SERVER_RETRY_MS 1000=0A=
 =0A=
+/*=0A=
+ * The bulk length field is 32 bits, so the host can ask for up to 4 GB.=
=0A=
+ * This is the largest transfer accepted.=0A=
+ */=0A=
+#define USBREDIR_SERVER_MAX_BULK (1 * MiB)=0A=
+=0A=
 #define USBREDIR_SERVER_CTRL 0=0A=
+#define USBREDIR_SERVER_BULK 1=0A=
+#define USBREDIR_SERVER_INTERRUPT 2=0A=
 =0A=
 /* Which message answers the host when a control transfer ends. */=0A=
 typedef enum {=0A=
@@ -113,7 +121,9 @@ typedef struct USBRedirServerPkt {=0A=
     USBPacket pkt;=0A=
 =0A=
     /* Kept for the usbredir response. */=0A=
+    struct usb_redir_interrupt_packet_header intr_hdr;=0A=
     struct usb_redir_control_packet_header ctrl_hdr;=0A=
+    struct usb_redir_bulk_packet_header bulk_hdr;=0A=
 =0A=
     /*=0A=
      * The IOV points here. IN data lands in it, OUT data is copied in.=0A=
@@ -549,6 +559,67 @@ static void usbredir_server_ctrl_complete(USBRedirServ=
er *s,=0A=
     }=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_reply(USBRedirServer *s, uint64_t id,=0A=
+    const struct usb_redir_bulk_packet_header *hdr, uint8_t status,=0A=
+    uint8_t *data, int actual)=0A=
+{=0A=
+    struct usb_redir_bulk_packet_header resp =3D *hdr;=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int data_len =3D is_in ? actual : 0;=0A=
+=0A=
+    resp.status =3D status;=0A=
+    /* Both directions report how much the device moved. */=0A=
+    resp.length =3D actual;=0A=
+    resp.length_high =3D actual >> 16;=0A=
+=0A=
+    usbredirparser_send_bulk_packet(s->parser, id, &resp,=0A=
+                                    data_len > 0 ? data : NULL, data_len);=
=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_bulk_complete(USBRedirServer *s,=0A=
+                                          USBRedirServerPkt *rp)=0A=
+{=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+=0A=
+    trace_usbredir_server_bulk_complete(rp->redir_id, rp->bulk_hdr.endpoin=
t,=0A=
+                                        status, actual);=0A=
+    usbredir_server_bulk_reply(s, rp->redir_id, &rp->bulk_hdr, status,=0A=
+                               rp->data, actual);=0A=
+}=0A=
+=0A=
+static void usbredir_server_interrupt_reply(USBRedirServer *s, uint64_t id=
,=0A=
+    const struct usb_redir_interrupt_packet_header *hdr, uint8_t status,=
=0A=
+    uint8_t *data, int actual)=0A=
+{=0A=
+    struct usb_redir_interrupt_packet_header resp =3D *hdr;=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int data_len =3D is_in ? actual : 0;=0A=
+=0A=
+    resp.status =3D status;=0A=
+    /* Both directions report how much the device moved. */=0A=
+    resp.length =3D actual;=0A=
+=0A=
+    usbredirparser_send_interrupt_packet(s->parser, id, &resp,=0A=
+                                         data_len > 0 ? data : NULL,=0A=
+                                         data_len);=0A=
+    usbredirparser_do_write(s->parser);=0A=
+}=0A=
+=0A=
+static void usbredir_server_interrupt_complete(USBRedirServer *s,=0A=
+                                               USBRedirServerPkt *rp)=0A=
+{=0A=
+    uint8_t status =3D usbredir_server_status(rp->pkt.status);=0A=
+    int actual =3D rp->pkt.actual_length;=0A=
+=0A=
+    trace_usbredir_server_interrupt_complete(rp->redir_id,=0A=
+                                             rp->intr_hdr.endpoint,=0A=
+                                             status, actual);=0A=
+    usbredir_server_interrupt_reply(s, rp->redir_id, &rp->intr_hdr, status=
,=0A=
+                                    rp->data, actual);=0A=
+}=0A=
+=0A=
 /*=0A=
  * USB port ops=0A=
  */=0A=
@@ -622,6 +693,12 @@ static void usbredir_server_packet_complete(USBPort *p=
ort, USBPacket *p)=0A=
     case USBREDIR_SERVER_CTRL:=0A=
         usbredir_server_ctrl_complete(s, rp);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        usbredir_server_bulk_complete(s, rp);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTERRUPT:=0A=
+        usbredir_server_interrupt_complete(s, rp);=0A=
+        break;=0A=
     default:=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -1033,6 +1110,121 @@ static void usbredir_server_get_alt_setting(void *p=
riv, uint64_t id,=0A=
                                USBREDIR_SERVER_REPLY_ALT);=0A=
 }=0A=
 =0A=
+static void usbredir_server_bulk_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_bulk_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+    uint32_t len;=0A=
+=0A=
+    /* The host still waits for an answer, even to a request we refuse. */=
=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_BULK);=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        trace_usbredir_server_refused(id, hdr->endpoint, status,=0A=
+                                      USB_ENDPOINT_XFER_BULK,=0A=
+                                      s->ep[idx].type);=0A=
+        usbredir_server_bulk_reply(s, id, hdr, status, NULL, 0);=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? (((uint32_t)hdr->length_high << 16) | hdr->length)=0A=
+                : (uint32_t)data_len;=0A=
+=0A=
+    /*=0A=
+     * Too big. Tell the host the transfer failed.=0A=
+     * Do not send back less data instead. The host would see the=0A=
+     * missing bytes as an error and reset the device.=0A=
+     */=0A=
+    if (len > USBREDIR_SERVER_MAX_BULK) {=0A=
+        trace_usbredir_server_bulk_too_big(id, hdr->endpoint, len);=0A=
+        usbredir_server_bulk_reply(s, id, hdr, usb_redir_inval, NULL, 0);=
=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_BULK;=0A=
+    rp->bulk_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_bulk(id, hdr->endpoint, len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
+/*=0A=
+ * The host sends an interrupt_packet. It is a request: interrupt OUT=0A=
+ * data to write, or a single IN request to answer.=0A=
+ */=0A=
+static void usbredir_server_interrupt_packet(void *priv, uint64_t id,=0A=
+    struct usb_redir_interrupt_packet_header *hdr,=0A=
+    uint8_t *data, int data_len)=0A=
+{=0A=
+    USBRedirServer *s =3D priv;=0A=
+    int idx =3D usbredir_server_ep_index(hdr->endpoint);=0A=
+    USBDevice *device =3D usbredir_server_device(s);=0A=
+    bool is_in =3D !!(hdr->endpoint & USB_DIR_IN);=0A=
+    int pid =3D is_in ? USB_TOKEN_IN : USB_TOKEN_OUT;=0A=
+    int ep_nr =3D hdr->endpoint & 0x0f;=0A=
+    USBRedirServerPkt *rp;=0A=
+    USBEndpoint *ep;=0A=
+    uint8_t status;=0A=
+    int len;=0A=
+=0A=
+    /* The host still waits for an answer, even to a request we refuse. */=
=0A=
+    status =3D usbredir_server_ep_status(s, hdr->endpoint,=0A=
+                                       USB_ENDPOINT_XFER_INT);=0A=
+    if (status !=3D usb_redir_success) {=0A=
+        trace_usbredir_server_refused(id, hdr->endpoint, status,=0A=
+                                      USB_ENDPOINT_XFER_INT,=0A=
+                                      s->ep[idx].type);=0A=
+        usbredir_server_interrupt_reply(s, id, hdr, status, NULL, 0);=0A=
+        usbredirparser_free_packet_data(s->parser, data);=0A=
+        return;=0A=
+    }=0A=
+=0A=
+    /* IN: what the host asked for. OUT: what the host sent. */=0A=
+    len =3D is_in ? hdr->length : data_len;=0A=
+=0A=
+    ep =3D usb_ep_get(device, pid, ep_nr);=0A=
+    rp =3D usbredir_server_pkt_alloc(len, idx);=0A=
+    rp->redir_id =3D id;=0A=
+    rp->type =3D USBREDIR_SERVER_INTERRUPT;=0A=
+    rp->intr_hdr =3D *hdr;=0A=
+=0A=
+    usb_packet_setup(&rp->pkt, pid, ep, 0, s->next_id++, false, false);=0A=
+=0A=
+    /* OUT data comes from the host. IN data is written by the device. */=
=0A=
+    if (!is_in && len > 0) {=0A=
+        memcpy(rp->data, data, len);=0A=
+    }=0A=
+    usb_packet_addbuf(&rp->pkt, rp->data, len);=0A=
+=0A=
+    trace_usbredir_server_interrupt(id, hdr->endpoint, len);=0A=
+    usbredirparser_free_packet_data(s->parser, data);=0A=
+    usbredir_server_submit(s, rp);=0A=
+}=0A=
+=0A=
 static void usbredir_server_filter_reject(void *priv)=0A=
 {=0A=
     trace_usbredir_server_filter_reject();=0A=
@@ -1056,6 +1248,24 @@ static void usbredir_server_interface_info(void *pri=
v,=0A=
     /* The host should not send this to a device. Nothing to do. */=0A=
 }=0A=
 =0A=
+static void usbredir_server_alloc_bulk_streams(void *priv, uint64_t id,=0A=
+    struct usb_redir_alloc_bulk_streams_header *hdr)=0A=
+{=0A=
+    /* We do not advertise bulk streams. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_start_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_start_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
+static void usbredir_server_stop_bulk_receiving(void *priv, uint64_t id,=
=0A=
+    struct usb_redir_stop_bulk_receiving_header *hdr)=0A=
+{=0A=
+    /* We do not advertise this. Nothing to do. */=0A=
+}=0A=
+=0A=
 static void usbredir_server_cancel_data_packet(void *priv, uint64_t id)=0A=
 {=0A=
     USBRedirServer *s =3D priv;=0A=
@@ -1096,7 +1306,9 @@ static void usbredir_server_cancel_data_packet(void *=
priv, uint64_t id)=0A=
 static void usbredir_server_send_cancelled(USBRedirServer *s,=0A=
                                            USBRedirServerPkt *rp)=0A=
 {=0A=
+    struct usb_redir_interrupt_packet_header intr;=0A=
     struct usb_redir_control_packet_header ctrl;=0A=
+    struct usb_redir_bulk_packet_header bulk;=0A=
 =0A=
     switch (rp->type) {=0A=
     case USBREDIR_SERVER_CTRL:=0A=
@@ -1106,6 +1318,21 @@ static void usbredir_server_send_cancelled(USBRedirS=
erver *s,=0A=
         usbredirparser_send_control_packet(s->parser, rp->redir_id,=0A=
                                            &ctrl, NULL, 0);=0A=
         break;=0A=
+    case USBREDIR_SERVER_BULK:=0A=
+        bulk =3D rp->bulk_hdr;=0A=
+        bulk.status =3D usb_redir_cancelled;=0A=
+        bulk.length_high =3D 0;=0A=
+        bulk.length =3D 0;=0A=
+        usbredirparser_send_bulk_packet(s->parser, rp->redir_id,=0A=
+                                        &bulk, NULL, 0);=0A=
+        break;=0A=
+    case USBREDIR_SERVER_INTERRUPT:=0A=
+        intr =3D rp->intr_hdr;=0A=
+        intr.status =3D usb_redir_cancelled;=0A=
+        intr.length =3D 0;=0A=
+        usbredirparser_send_interrupt_packet(s->parser, rp->redir_id,=0A=
+                                             &intr, NULL, 0);=0A=
+        break;=0A=
     default:=0A=
         return;=0A=
     }=0A=
@@ -1153,6 +1380,8 @@ static void usbredir_server_create_parser(USBRedirSer=
ver *s)=0A=
     s->parser->hello_func =3D usbredir_server_hello;=0A=
     s->parser->reset_func =3D usbredir_server_reset;=0A=
     s->parser->control_packet_func =3D usbredir_server_control_packet;=0A=
+    s->parser->bulk_packet_func =3D usbredir_server_bulk_packet;=0A=
+    s->parser->interrupt_packet_func =3D usbredir_server_interrupt_packet;=
=0A=
     s->parser->set_configuration_func =3D usbredir_server_set_configuratio=
n;=0A=
 =0A=
     /* The parser calls these directly, so they must not be NULL. */=0A=
@@ -1164,12 +1393,21 @@ static void usbredir_server_create_parser(USBRedirS=
erver *s)=0A=
     s->parser->device_disconnect_ack_func =3D=0A=
         usbredir_server_device_disconnect_ack;=0A=
     s->parser->interface_info_func =3D usbredir_server_interface_info;=0A=
+    s->parser->alloc_bulk_streams_func =3D usbredir_server_alloc_bulk_stre=
ams;=0A=
     s->parser->cancel_data_packet_func =3D usbredir_server_cancel_data_pac=
ket;=0A=
+    s->parser->start_bulk_receiving_func =3D=0A=
+        usbredir_server_start_bulk_receiving;=0A=
+    s->parser->stop_bulk_receiving_func =3D=0A=
+        usbredir_server_stop_bulk_receiving;=0A=
 =0A=
-    /* Capabilities: 64-bit IDs, connect_device_version, ep_info sizes */=
=0A=
+    /*=0A=
+     * Capabilities: 64-bit IDs, connect_device_version, ep_info sizes=0A=
+     * and 32-bit bulk lengths.=0A=
+     */=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_connect_device_version=
);=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_ep_info_max_packet_siz=
e);=0A=
     usbredirparser_caps_set_cap(caps, usb_redir_cap_64bits_ids);=0A=
+    usbredirparser_caps_set_cap(caps, usb_redir_cap_32bits_bulk_length);=
=0A=
 =0A=
     /*=0A=
      * In USB the host is the side that starts every transfer; a device=0A=
diff --git a/hw/usb/trace-events b/hw/usb/trace-events=0A=
index d63156a930..5ec5127efa 100644=0A=
--- a/hw/usb/trace-events=0A=
+++ b/hw/usb/trace-events=0A=
@@ -417,3 +417,9 @@ usbredir_server_nak_park(uint64_t id, int ep) "id %" PR=
Iu64 " ep %d"=0A=
 usbredir_server_nak_retry(uint64_t id, int ep) "id %" PRIu64 " ep %d"=0A=
 usbredir_server_ctrl_complete(uint64_t id, int status, int actual) "id %" =
PRIu64 " status %d actual %d"=0A=
 usbredir_server_ctrl_refused(uint64_t id, int status) "id %" PRIu64 " stat=
us %d"=0A=
+usbredir_server_bulk(uint64_t id, uint8_t ep, size_t len) "id %" PRIu64 " =
ep 0x%02x len %zu"=0A=
+usbredir_server_bulk_complete(uint64_t id, uint8_t ep, int status, int act=
ual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
+usbredir_server_bulk_too_big(uint64_t id, uint8_t ep, uint32_t len) "id %"=
 PRIu64 " ep 0x%02x len %u"=0A=
+usbredir_server_refused(uint64_t id, uint8_t ep, int status, uint8_t want,=
 uint8_t got) "id %" PRIu64 " ep 0x%02x status %d, wanted type %u, it is %u=
"=0A=
+usbredir_server_interrupt(uint64_t id, uint8_t ep, size_t len) "id %" PRIu=
64 " ep 0x%02x len %zu"=0A=
+usbredir_server_interrupt_complete(uint64_t id, uint8_t ep, int status, in=
t actual) "id %" PRIu64 " ep 0x%02x status %d actual %d"=0A=
-- =0A=
2.43.0=0A=

