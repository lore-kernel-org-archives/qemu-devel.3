Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAADCD3424
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 02:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJjRf-0001d0-FS; Sun, 03 May 2026 22:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRb-0001ZH-Gh; Sun, 03 May 2026 22:54:03 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wJjRZ-00040F-S5; Sun, 03 May 2026 22:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrkb1EP+Yxa5nazlc3bqnitxLSgDCCvSGfYFyZVGQUGaRw0chQHWglCr9Op9n4oURa/0d1Jqdy/Df8tr4z/we3zRtwpvxQKyrKeHi0Dk5qgqo7j2gJMOmC1Gjdn3NQw5P1nD1ywhR8icFYYyahZzgdfM8Kv/35+EnbNFv61ZjA49l+jx4T0abT0Cj6gg7ecF9jrWnZ3NSuNapuAGi0PQEHzI0edcykfm02Kw9cQmeHQCVOYu+roHLkyBNKCWXig2shmhb6vQTgu34E3fh7QT6d+8iNhk5n/0X3MnGyRG3fcU8QxhFzRnmf6K+MvI9xXrgzCMo9IiWOIX20n/t/G0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h17ehC0Ciu4yPqEeNYFpSDfDt9Kh0r++HXNDEyx2apQ=;
 b=LhXd/dXJkjZvLwzQqJoRFgLrJWiRSWP0ect+P0e3P+fNvHGr7Hg80Zna3+BxY9T6CuGYoqGer4vu9kMPb14GPS+K9GrmJ079F7gXqJBQqQZsLX6cLlZ9g0k9eQm8mqGyDpANgWEVk4TZ1ljdxaw6+bfAiyXIVlFry3sjK3gPxZ55ax0SLUGaaake9jsuJpo+J7EUhmvlpcaHr4iwMO30blUoQ06g/RxPDA3Q5MVTHXybMDqHf12CEvm+gkBDJDRIZQEHJJM6OGYi/DTBje7YuuHBBBgzQ2kQ9QEVXRqHQKb97hY8hqppAvkYnAR3R6vu4v3I5OVIWg1C6b208cDp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h17ehC0Ciu4yPqEeNYFpSDfDt9Kh0r++HXNDEyx2apQ=;
 b=bAK1yOFSrgvCSME5PzqtHYp5BvKF+0l6cUp/VEZFgxwjpLsUSOFMqfOS9wzpaUfrPUroVDXi2bmIG7D0DLp40bJn7etMBUsT9u6miJHhC1ZuXM2oUWJJGsd2a8MdYJomuQzjb+ARgDfzLOenfu36x60zqpxEkmc5PEMBDUrk2v8qsHgGBw4uTPbRoS6dKI6Ca2W/lDPeBrgFplud6Y9Md84oe8lqJODkYDNTvh0XFSSC5wfAlf16UTK/NOA1oijOt/ytR9rJSI6NO9gWGWauNONNLmI6ihHMtqX6QPDHimxETYOVk32nd80TXUE7QfYkTMUX0iwGsCmezTYpBxEUsA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5111.apcprd06.prod.outlook.com (2603:1096:101:57::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 02:53:52 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%2]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 02:53:52 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Zhao Liu <zhao1.liu@intel.com>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default property
Thread-Topic: [PATCH v6 08/11] hw/usb/hcd-ehci: Add ctrldssegment-default
 property
Thread-Index: AQHc23E97LiOY55oYE6l1HWddzDthA==
Date: Mon, 4 May 2026 02:53:52 +0000
Message-ID: <20260504025342.1452605-9-jamin_lin@aspeedtech.com>
References: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260504025342.1452605-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5111:EE_
x-ms-office365-filtering-correlation-id: 190ee07e-8bc1-46c6-e602-08dea9885fd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: bLoPuM8FJlGNqJWCFSCevbE2tLTg/YaKDw/ik72q2H3I3UhOr8w2Gk82UTxWoTolebG77GbXGaEy4lDewnAehnW5lmXThYQ7Wv0lqPyi8tYd4+olPiQ90p0S3QZfokEL1Ei+lWHqKzoSeqKtEgVpLIzsTgZFjMt7/3BNzdplYLQf/isU8MI5Xveu2IEkpHinvMb94I3lREIRwn0rB6Ntd+tZQGUfP31wCTSrSzllJb9vMTgdW13AhbMO5Jb6s1+e0IvDd/d2lRZhYC6XjBNSh1LqfRsQn1CQOE17pnGYpieQ3uwW12l5Ce2IbCuG4aLF6W6lTAS+0qiKWmEn2TQd6z6+HwjoA5iejN1Rlu1fI5S6AUyzJQDDQA/dEGeumIUnW67y7W5c/StU7qkqXj3x+7x0t4iTyg4Tavvm5s81fRs0mCXw5vheivrqkNT/65NwvHqvfBY0c+iS95p2FbUV3aup5sWv3UI0zX0fHEGrE+FWPWO/MYEuoyCdybQJ9/Ez69LracBl+iI8TB/PNx/mN8PPMaBT/e/WbwI473QzvLTZi0qRrnvA/FEOrqSO77RnhVk/rJOz6YnZJFwlYNovQ2DHUzPddU39TROH/zTH+zu5lo59/Duvf0DiPP2mibNZkMRjPJEmtuh21lEUQaRHxA0HCWaD+ZYXno9bmLOI1iOyM6GeViwARdftJr8f7BdatidvBv4/EF/nVPzwyNZxw5uHsJgJT4/p+dHIXsBBGU/jw7y+eG6iqNEE5xDnD1qpv03HNl+9KGv/DUA0UNyZRg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f9NTF9beFzroWqrQN6REQf5YA4Iw5JXJq//EdTLqzUOheAm1sTMFtXLxZ8?=
 =?iso-8859-1?Q?2oahly4paNpmMc8vh0uqEX2ktAOv8Qx+YeJJTwGSO1DduZz65jDa+elziY?=
 =?iso-8859-1?Q?euxbKF2AWd6QYUfQXB9jEI+qIXj8hVJXYVHUdO2F2KTy7EuwSml+0aisVw?=
 =?iso-8859-1?Q?fWxpsrOrJzh4HIZ/w2+kh+oX8OExxmHtui5Wq/cpg4Lq8y7UbizGOgzBa2?=
 =?iso-8859-1?Q?sDsf41tJmz6fK1ebZDfFAnXUEvbS6zVLAmKhjwr0QwvJxFGI3xYfyjwN9t?=
 =?iso-8859-1?Q?dIo+Hda+YzGpPxovLjqP4ScvH8MK4tBDqj3kMOXPOBK6UrMHx1Bkfc/qmt?=
 =?iso-8859-1?Q?/LLCNA4yjdVo7Xq7GR+Tskx1sKgIQjcTOr72Puz6hHr8z4jk9/pSuhk+y/?=
 =?iso-8859-1?Q?Calha1vXtQopjmfcE8EY7A6QXD0dxATHJg/BeRyq/6USMaMTJr/3kZwUMq?=
 =?iso-8859-1?Q?bhhpYr4dl1+sBT46DD1YdY1n0NCmujZRadY/bP8cg/7TojPBV3gZ1Ux65b?=
 =?iso-8859-1?Q?rFQPYWIUW6YSGim3rEoLqYqXB8khqgVYwh/EFdKCCJpa5meK950nVHcvWc?=
 =?iso-8859-1?Q?38hwpa9f7p/hmLUOOWgz8PUwENQiQFYDXMQi2syTo1OeUKGCA9JjQrvP1B?=
 =?iso-8859-1?Q?zjQxL7HielkjtkAFJP8/nxb8krN1RoBiUVKAk6nHCHl0obIIKJdiz35yCJ?=
 =?iso-8859-1?Q?LxVA932G0Ba0uC3D5VvpQatNBYnnJP6U6gTWBgcqBvy/7zw1Cuk3iqXk7K?=
 =?iso-8859-1?Q?vnUPCMbTtN+nVPKcBnatyHlAuwAaCdlg5fBlIk0o446H9OzrQdcVnnZFjj?=
 =?iso-8859-1?Q?drLTUEOVm4BWxSMrTSW1gvnEC/b81FSxgRbFLzBuq6OIQgNiNV1WHvSTXq?=
 =?iso-8859-1?Q?7eMXGUqCzOEG1QIfeMNq832QB9zq3OyZZpxGxzLsSCP3912nxTPim09OGY?=
 =?iso-8859-1?Q?gEqyC9TOwqGfZ5IsEo/bM53UUnzqqejX0MmWJngOf7buQI8w7niIBnBRna?=
 =?iso-8859-1?Q?apppOQUKIenMWzwpsJkFSkMyxD3qydHnUyu90BNWMNLVFWrX+mnnhi+ekS?=
 =?iso-8859-1?Q?ll7H111ebjBhPVSKhYuxkzjRSPCMD+r0nF8ESaw4Vx3c6HKhBgAotaqMPY?=
 =?iso-8859-1?Q?hrhAngrRoeh864l9bUaWnqr+YEsggS99b0jY43+7MKjhUsjKFn/Ym+p/JE?=
 =?iso-8859-1?Q?z8dgjx0bMpEgBtqZwKrejPy1sLzipk3nQkJXRJgDNYiYBbr+pAelDIVFKu?=
 =?iso-8859-1?Q?VQ6jSjwQXlwriYhXHkgDmZJQ/DckIH4+FUKuNSKMMvwTVtz6DobO9U0ZMa?=
 =?iso-8859-1?Q?dkbCQqLD1rL0UVJ8Bkj06+/CXUCYibf/kaMhU5UUeZ29/kN3QsMaQCsF6u?=
 =?iso-8859-1?Q?6yxqRw/XikI/fXjGNZ8jqQ2YyWZBxx+TVT8Zt+lk/b36kvjnt6DyLzhiUn?=
 =?iso-8859-1?Q?vyQA1DauYz0eke4ZrKt/7dzpqnxFN7sSxXWFLEPWI3AxsO828pztD5qy4K?=
 =?iso-8859-1?Q?qVOcKbi4y69MnqC2edMUCB0se9ktkOZ0WiMXzW9TYNu4sDMnk14TXSIw/o?=
 =?iso-8859-1?Q?fHQQ7idxfsO47D6wATQJMuXLJUpYi4e6D5NkmFjUakXkCB609XxIr8tkuD?=
 =?iso-8859-1?Q?OSo3N9xFPkpXQfKDOyyExe6UFVDnEqkqTdNqWFunGT9lE10AGD/4HOSNug?=
 =?iso-8859-1?Q?DTcXIXdqTVArvEtupjn1DbwIkDav2A2elc9F0T19gwt5DVxquAlvmc2dPe?=
 =?iso-8859-1?Q?Deqxuf+Iafi7iabAAJYgXWNkA8Lo21q2GE8Ujcw89HoKLBY/VCz2cdBvzC?=
 =?iso-8859-1?Q?hcZgLknqGw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Lv7L7gH35JvYKUZkbP2JWnzv8TQ9TpmAVxqqvMQSr+4T8qyYE7QTNQD2ILrx3EInEtLXU0L9KFO35meQlzRwRKeqk3D8Wz2DeUW+jP2Rm841MgXzRYZfieU7eXpFkRxqAbleNXaHPy3mPP09yHcMK8ebw7hH5HXqG1bip+1iJHe1qDxXhGs1AD+MLJnwbjidEN9cXfodT/jTJv78SdFl6pYTg80YPKeyj6iGM5ncNM1QCorGQjP2P90CnZ2napBHSfMYlrTlD8FMa9/vZrZiBG/B3uUVRLxS2bmftkB6c4XTMxpW/HJRxP7SpH8++khuTN3wILSKTSEswnE566hJIQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190ee07e-8bc1-46c6-e602-08dea9885fd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2026 02:53:52.1631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R9L0mcQjNmdoCTN4bQ2M7Kle94q45kTDBGPz6MA2P1oHWCa+rbOXDZSNc3yEs6v/PdzXOoRoJ8DKviaNBMPM8ujfbxIt/K/fL71e6Za9LzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5111
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

When 64-bit addressing is supported, the Linux EHCI driver programs the=0A=
segment register to zero. See ehci_run function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
=0A=
=0A=
The driver comment also notes that descriptor structures allocated from=0A=
the DMA pool use segment zero semantics.=0A=
=0A=
Descriptor memory is allocated using the DMA API. The platform driver=0A=
configures a 64-bit DMA mask so memory can be allocated above 4GB.=0A=
See ehci_platform_probe function:=0A=
https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-platfor=
m.c=0A=
=0A=
On AST2700 platforms, system DRAM is mapped above 4GB at 0x400000000.=0A=
As a result, descriptor addresses constructed directly from the guest=0A=
EHCI registers do not match the actual system address used by the=0A=
controller when fetching queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
Add a ctrldssegment-default property so platforms can provide a=0A=
descriptor address offset when constructing descriptor addresses.=0A=
This allows systems where DRAM resides above 4GB to access EHCI=0A=
descriptors correctly.=0A=
=0A=
The default value is zero, so existing machines are not affected.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: C=E9dric Le Goater <clg@redhat.com>=0A=
---=0A=
 hw/usb/hcd-ehci.h | 5 ++++-=0A=
 hw/usb/hcd-ehci.c | 1 +=0A=
 2 files changed, 5 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.h b/hw/usb/hcd-ehci.h=0A=
index 8e6a8cdfb0..3d57e1de5f 100644=0A=
--- a/hw/usb/hcd-ehci.h=0A=
+++ b/hw/usb/hcd-ehci.h=0A=
@@ -264,6 +264,7 @@ struct EHCIState {=0A=
     uint32_t maxframes;=0A=
     bool migrate_fetch_addr_64bit;=0A=
     bool caps_64bit_addr;=0A=
+    uint32_t ctrldssegment_default;=0A=
 =0A=
     /*=0A=
      *  EHCI spec version 1.0 Section 2.3=0A=
@@ -322,7 +323,9 @@ struct EHCIState {=0A=
     DEFINE_PROP_BOOL("x-migrate-fetch-addr-64bit", _state, \=0A=
                      ehci.migrate_fetch_addr_64bit, true), \=0A=
     DEFINE_PROP_BOOL("caps-64bit-addr", _state, \=0A=
-                     ehci.caps_64bit_addr, false)=0A=
+                     ehci.caps_64bit_addr, false), \=0A=
+    DEFINE_PROP_UINT32("ctrldssegment-default", _state, \=0A=
+                       ehci.ctrldssegment_default, 0)=0A=
 =0A=
 extern const VMStateDescription vmstate_ehci;=0A=
 =0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index b1c7bfd90c..62c3770ac5 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -1134,6 +1134,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
                           "64-bit addressing capability is disabled\n");=
=0A=
             return;=0A=
         }=0A=
+        val |=3D s->ctrldssegment_default;=0A=
         break;=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
-- =0A=
2.43.0=0A=

