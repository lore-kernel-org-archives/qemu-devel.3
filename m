Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C639EF531CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 19:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCNMl-0007T5-05; Mon, 13 Apr 2026 15:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCNMj-0007Ss-Sw
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 15:54:37 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wCNMh-0003VU-GI
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 15:54:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ogd6twLo57AvzXsFtR4YR7MCfcaKTfPUa+j4pt9rDBKZroyqsXW+OwkyoMybi2JFbmJckFUTQsS0zVOQFH1Km2dsDUpvj3RuqkAk54Lu4EQLCjJQ5LFKgpsADea+iayLltjbkfo6+Jcp7fc2H2EQtHgs1dKRkSniVfnPdvGgn2c+lqgfQx82Smf39K6HYeoNTjifMlg1wK83e1qk5Y8Rfy67mVQdaBjYsZKmzWhPFCz+ZjN64j5D5DowDP513sMl5Ykpqc8kgV9PWPpkB8rJKv+XH2d+RC2vhwAzhC5/cLbKFyR0/90dlnc5qhQW6f95Av2Go9D0PZTVblggcseDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FfgDF/MGoWL/MOMUT/hRoCHwwHKubxq/lEZXGN+43I=;
 b=ykMmuK6UHAHWiJtqJvldQg7gEEilAeyhDIUdVZrMll1MBygNDdeDGGyT27PxBcIR+BsZpScUH0vJxZkcARNUouFz+WNzPZ3J1yP1dTQEbf8gZvbKD/fh3iaL8hogY9x3j6SoRNzxwBLipfcR2pdYG6ZBIuASPw8aLi2P02jbRJkeAET1U4E9Tfvrqe5eXlX0JeDYXqRUqkhBWCVEGcsAyvwOTqGgMgQfsczb1ecnHtbLqWEqX6R5OGSfM0lNv2prnqiWytYVzRvSs9jc1TyDEZqXUdZQtG2e6q3ojmdaZOTx83AtUjjejeIF3Ezcmt23zOkoFMo2u/S6NCsHCzK0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FfgDF/MGoWL/MOMUT/hRoCHwwHKubxq/lEZXGN+43I=;
 b=U6N9tJ9cIJGYrXQ0DnDJqWlLry+fTWHZfjK+xLSDMl0xg9dzl+AsnnN5G+RlD6kbFgIREk+V1pMuLQ/yloGl5NCkP4CDo/dFRY5aQnozIa6b3QHz+4OERZyQShy13s820mBi0mGLGFBbrw5jHcliwNmUk+Mf3B4ADnDJsJjxjT2QPalK5jsqnKVvGYzepSD9qZROkwZZPf84krGdjqJC1qSvdpuBY7qk2Z4bztMBCtYJIDXxyf1ojnZJmwPqymcbqPf/VrY3XQWZenlSG3XDiB+y09AMkNpv8f0ZTTuy3CynhJoTsDHgFj3GAf7RMuhQf61uTdxu+ejUY+dQ57MRTQ==
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com (2603:10a6:208:6e::32)
 by VI1PR04MB7135.eurprd04.prod.outlook.com (2603:10a6:800:12c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 19:54:31 +0000
Received: from AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b]) by AM0PR04MB4370.eurprd04.prod.outlook.com
 ([fe80::fe3b:fb2c:9dfc:9b%6]) with mapi id 15.20.9745.035; Mon, 13 Apr 2026
 19:54:29 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Bernhard Beschow <shentey@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Topic: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
 i.MX8MM EVK board
Thread-Index: AQHcyxhq2POQGlihkUmOWoImS6Nbv7Xc/V4AgABboCCAAAaFAA==
Date: Mon, 13 Apr 2026 19:54:29 +0000
Message-ID: <AM0PR04MB4370028D6C330307CADBF81D87242@AM0PR04MB4370.eurprd04.prod.outlook.com>
References: <20260413073737.986219-1-gaurav.sharma_7@nxp.com>
 <9BF9D1F9-DA94-41AE-8C81-2226B17E096A@gmail.com>
 <AM0PR04MB43700A10A6F9E20DE479701887242@AM0PR04MB4370.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB43700A10A6F9E20DE479701887242@AM0PR04MB4370.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: shentey@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR04MB4370:EE_|VI1PR04MB7135:EE_
x-ms-office365-filtering-correlation-id: b9f1a342-875e-463c-a84a-08de999679b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|1800799024|366016|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: R384Gu4MYM2bdZCyBDpNdodL199x+cCxyeQFW9K8uywvY18aZRrQJZW0HdOotlD0FlawuXmCBDfjUhsxgc+NDJVkI/xKIuBH8D6qtaEOERvtKWptr4tWT3LxP2xg8zWCuEDYDtX9A8LvxQfDhOIdzGcTB+pgpbakmbJKH7LrIR+WV9K98bklcrIUOByvMYo0vtYXmu3tSjeeJ/eAAaWbnqh3hI2ddCQQG7Gza+/SQOlCpxKeGW0q3rhdPRBSqfJn/J20PMNmXEKprs1KI4kqXfsIKCFz16pE38jGdAbruANgTXYZeUwvFvVNc2jZSOHUPL47wxb7S+K2lmfSsOOzJdUk1wIDnM4Fd8fn22iOCF999LxbIrZR7SRM6FbbwTZ3hARd2BiXGqRHkz9wxPMwDNuCHcSH8Ha1KXx9JiLy4/eySoVakCCowbDZhElY3G5Sok6itUVwg7c2g4HBHUwftRiaSm5adiGvALUiDS/gIqX37SlkFtdTObQTa52yJGXOA9yO+Z6YBd91J4RDuzbCkByHtCxOcHe3EgY+1EkVEKIGAKbR5VA/gYXlQGObMMlsWX90FhPEp+skUZnbJDzQBz5p6I9wVh/Hu1gBNtGKderVR3HBHWUkoyfWi4uuhSXONfiGwXCcy5AiLr6IjBmdI5tOX420+Lz6PvqmeUd+6n6W+brZhU5RTzIAGmKp2r40Mx30sRAEFEKWE5c0WLe1Ruksw543H2kZwlEF4MUIvOp7qEE/g5V1fnX4ZBKVsHQ3yBpjgImjn1OSlkepyh8k4sLf3AH5+jEL0swaJdVWdDY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB4370.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?n4ZhhJdBQrrGiSU2z1p3qN0GXV9XAVQjw0qv637CWL84S9M5Cb5qCNXVcrZ8?=
 =?us-ascii?Q?CGh4N1NTa5GuJpHAelcYUQGiXJQnHUfuGOjOUDgO+eOz/ssOqaNdDmTG8wn6?=
 =?us-ascii?Q?UT9136QQr7o4ybYJZTalOFjGNjuSXJAEwjzIPx58DaaWmxAI4SWnVitJfzcQ?=
 =?us-ascii?Q?ye1pa6bL5Nan7KuM8nmetcMp0hXr1l3OGB8bNlLn7Tm0dgRPstUpZXjLiAYZ?=
 =?us-ascii?Q?9/l7eIr8b2ftrVE5kMuj4gZpPhBgMhCstvtoPSR+x6kwLSWTRfslvHXk0xhk?=
 =?us-ascii?Q?aYKKtuD5e2/xqPUrECxT1TGG4Gv9UuM2dWzk+rQuCHylGy35dH9SMpglciu2?=
 =?us-ascii?Q?flCBvAs+/lKmH3N2DF6HR9p477RM740BcTCXQ2RMYB5g7cQ+dyWy6BK1F2WD?=
 =?us-ascii?Q?uV8nz9vsxt4Vw1P80xkcqxW16zc2AdZSRyzrM0Gi4tmKp9Dxj5sKdK4AfQ+K?=
 =?us-ascii?Q?p/EzX8JYl0phbQszubA4G5/Q7JX9M+VRyszwWd9asFeHKu3kEyC/U2Hplyfx?=
 =?us-ascii?Q?emRG0DdGBAneixMIHNPPfXUQOz5yja8FmZ/woS1NrlcAk9PfnfFuZPxaUF5A?=
 =?us-ascii?Q?fwTPDeGry9+N+HcqIt4DzTaTKAXMPMPEK5D4tMuohJ/Rb24Y5nrJkQgQBaNQ?=
 =?us-ascii?Q?2lLI45URgMcCzEGdGjOIoA0gLP685AvforInG/TCc9o0N/fJoRKem30LM4YL?=
 =?us-ascii?Q?B9Lzv0P73w3iFPfZTHSePylmSlICbHza3ypmMb9PNZqfAb+tQAQ/u6Zl8Dqy?=
 =?us-ascii?Q?VuVmL/am+xU66nidu5bKe18OYHLaKGEv4m3QpafFslhF0rxj92qYqLLSsogh?=
 =?us-ascii?Q?EnVE/xsK3zSMcCXAq8AOsUnH/NvTbxcNBJhxe635gug3HjuGaWmbtcMav+UJ?=
 =?us-ascii?Q?cXXtE7MT5AsKgtpeHYixLtWrKJgHZ8HQIRT7l2yiXYNy69FTGin+tEnXjpr/?=
 =?us-ascii?Q?RCwKln3lgXPk6QSzo7El6jNIGZWsEcLX8JTANuM4WjfTnCZFzIvW0qmUAObA?=
 =?us-ascii?Q?x0sDy0V/nxjEjcWxAHcENnzzF4wNOLhpXhWYF173/JeK8QJWZ3LFH63ij2UE?=
 =?us-ascii?Q?kQ0VzHMGy86TiycFqNPvkX5ecxY/4UoYuZxbwW5t1KjCvH/w5RlzRHlxEfMd?=
 =?us-ascii?Q?RLpWa3cSuurq3Asa3X910XcVjz0eLbC5uSA9Dt80uuUpcxvZ1IyIh4CTpFY7?=
 =?us-ascii?Q?IZpl3Cj7kiDvLSN5pCeVol5qYypTd8cPB/yaG9T2oViIrqtXHXkATgE6CQi5?=
 =?us-ascii?Q?AXuCYONN8UwFd3fhvfPoqdRi5Hee3jbKpSRtIYBsPU716Q0F6ua5LS6p4VU3?=
 =?us-ascii?Q?g3paFPxYO90vgLVJxfN/mv1CtnLCp0iQjWy0fzUNLAj4V1sD3nsTp0HsulMf?=
 =?us-ascii?Q?Dt4enwlowMCTaewUwkhMnsxEu/4zF1Xhy7nm8ZCoQRCIatHwa7KWFTuQCaU8?=
 =?us-ascii?Q?QmiIP88zRPj7xHpVIaIXXzqkKWpwqPe4SKJATthinSXbpsqW25eBimI1DoTA?=
 =?us-ascii?Q?AA2bRLYXVgn9CZN8mBR6qUAAGRtlFdFblHAYVVl3ivEcqQ3+w5IH6BbO84c6?=
 =?us-ascii?Q?qaDetzkb4KfnlF1HFtvSzTFbN6lo3dM3phE+43HsUrz+lSREH+5INBMIxCOb?=
 =?us-ascii?Q?Xw4jQEQx0zdHTTwi9icVpCz+Tb4u1wSr0ZGfKXadSWR/966TLdSLfxvMXvid?=
 =?us-ascii?Q?p4icqW5toDIwm99KMPXjuWZ5SfghdKyc9wNtVFVWuRiNTbJrflsQLGeJW3zi?=
 =?us-ascii?Q?kKLscMmitA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4370.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f1a342-875e-463c-a84a-08de999679b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 19:54:29.8515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a/A/44ksVoZYF5nAuY1hsnXVkwd4U6R/Pc8x2L2xWDnCZlnZPEVSpBgqKderGbOrJQLyphcvd2Q6l4twUPrYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7135
Received-SPF: permerror client-ip=2a01:111:f403:c202::7;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

@'Bernhard Beschow', after I rebased to master and build the changes, so fa=
r I have observed build errors like:-

1. 2 of those attributed to qdev-properties.h header file moved from hw/ to=
 hw/core/
2. 2 errors attributed to boards.h header file moved from hw/ to hw/core/
3. One attributed to smmu :-

In file included from ../hw/arm/smmuv3.c:37:
../hw/arm/smmuv3-accel.h:17:10: error: #include expects "FILENAME" or <FILE=
NAME>
   17 | #include CONFIG_DEVICES
      |          ^~~~~~~~~~~~~~
../hw/arm/smmuv3-accel.h:44:8: error: attempt to use poisoned "CONFIG_ARM_S=
MMUV3_ACCEL"
   44 | #ifdef CONFIG_ARM_SMMUV3_ACCEL
      |        ^
../hw/arm/smmuv3.c: In function 'smmu_validate_property':
../hw/arm/smmuv3.c:1968:9: error: attempt to use poisoned "CONFIG_ARM_SMMUV=
3_ACCEL"
 1968 | #ifndef CONFIG_ARM_SMMUV3_ACCEL
      |         ^

Build command used:-

../configure --target-list=3Daarch64-softmmu
make -j$(nproc)

are these expected ?=20



> -----Original Message-----
> From: Gaurav Sharma
> Sent: 14 April 2026 00:30
> To: 'Bernhard Beschow' <shentey@gmail.com>; qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> Subject: RE: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
> i.MX8MM EVK board
>=20
>=20
>=20
> > -----Original Message-----
> > From: Bernhard Beschow <shentey@gmail.com>
> > Sent: 13 April 2026 19:01
> > To: qemu-devel@nongnu.org; Gaurav Sharma
> <gaurav.sharma_7@nxp.com>
> > Cc: pbonzini@redhat.com; peter.maydell@linaro.org
> > Subject: [EXT] Re: [PATCHv5 00/15] Adding comprehensive support for
> > i.MX8MM EVK board
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > Am 13. April 2026 07:37:22 UTC schrieb Gaurav Sharma
> > <gaurav.sharma_7@nxp.com>:
> >
> > Hi Gurav,
> >
> > >Changes in v5:
> > >- Fixed SoC object reference counting by using
> > >object_new_with_props()
> > >  instead of object_new() + object_property_add_child()
> > >- Merged imx8mm-evk.rst documentation into imx8mp-evk.rst to avoid
> > >  duplication and updated the title accordingly
> > >- Added on-chip RAM (OCRAM) support to match iMX8MP dev
> >
> > I tried to apply v5 but I'm hitting the same issues as Patchew:
> > <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa=
t
> > ch
> > ew.org%2FQEMU%2F20260413073737.986219-1-
> >
> gaurav.sharma._5F7%40nxp.com%2F&data=3D05%7C02%7Cgaurav.sharma_7%4
> >
> 0nxp.com%7Cfbdcd381f0014ebd086a08de9960ed16%7C686ea1d3bc2b4c6fa
> >
> 92cd99c5c301635%7C0%7C0%7C639116838724991885%7CUnknown%7CTWF
> >
> pbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> >
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DnyynvYO
> > v87nTkxEFkU8k3eSt4r%2Fa17rQkr9STABgaaA%3D&reserved=3D0> Mind
> resending a
> > version rebased onto master?
> >
> > Moreover, you may keep my R-b tags which I've given during v4.
> >
> > Best regards,
> > Bernhard
> >
>=20
> Hey Bernhard,
> yes, looks like I need to rebase and create patches again. Lemme do that =
and
> send over as v6.
>=20
> > >
> > >Changes in v4:
> > >- Update Maintainers file
> > >- Re-used iMX8MP CCM and Analog IP for iMX8MM by introducing a
> > >variant
> > >  specific property
> > >- Split up the patch that enabled CCM and Analog in the previous
> > >  revision. Now we have 3 patches to enable CCM and Analog in iMX8MM
> > >- Updated copyrights
> > >- Removed '|| KVM' from hw/arm/Kconfig to prevent 'make check'
> > >failures
> > >
> > >Changes in v3:
> > >- Minor documentation change - Added KVM Acceleration section in
> > >docs/system/arm/imx8mm-evk.rst
> > >
> > >Changes in v2:
> > >- Fixed the DTB offset in functional testing script
> > >test_imx8mm_evk.py
> > >  and preserved alphabetical order of machine names in
> > >tests/functional/aarch64/meson.build
> > >- Fixed a typo and updated the documentation
> > >- Modified structures type to static const in fsl-imx8mm.c wherever
> > >  applicable.
> > >- Added CSI and DSI nodes to the nodes_to_remove list in imx8mm-evk.c.
> > >This
> > >  is needed because the default DTB in the iMX LF BSP images have CSI
> > >  and DSI enabled. Developers/Hobbyists using these BSP images will
> > >  observe CSI and DSI crash logs on the console since these are
> > unimplemented.
> > >  With this change, both debian and iMX LF images will boot up
> > > without any
> > issues.
> > >
> > >Changes in v1:
> > >
> > >This patch series adds support for the NXP i.MX8MM EVK (Evaluation
> > >Kit) board to QEMU, enabling emulation of this ARM Cortex-A53 based
> > >development platform.
> > >
> > >The series includes:
> > >
> > >1. Core peripheral support (CCM clock controller, Analog module) 2.
> > >GPT(General Purpose Timer) and WDT(Watchdog Timer) Emulation
> support
> > 3.
> > >GPIO,I2C,SPI,USDHC and USB Emulation support 4. PCIe and ENET
> > >Controller Emulation support 5. Documentation and functional test
> > >included
> > >
> > >Key features ported:
> > >- Basic boot support with Linux
> > >- UART console for serial communication
> > >- Interrupt handling
> > >- Clock and power management infrastructure
> > >
> > >Testing:
> > >- Linux kernel boots to console
> > >
> > >Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> > >
> > >Gaurav Sharma (15):
> > >  hw/arm: Add the i.MX 8MM EVK(Evaluation Kit) board
> > >  hw/misc/imx8mp_analog: Add property to analog device
> > >  hw/arm/fsl-imx8mm: Add Analog device IP to iMX8MM SOC
> > >  hw/arm/fsl-imx8mm: Add Clock Control Module IP to iMX8MM
> > >  hw/arm/fsl-imx8mm: Implemented support for SNVS
> > >  hw/arm/fsl-imx8mm: Adding support for USDHC storage controllers
> > >  hw/arm/fsl-imx8mm: Add PCIe support
> > >  hw/arm/fsl-imx8mm: Add GPIO controllers
> > >  hw/arm/fsl-imx8mm: Adding support for I2C emulation
> > >  hw/arm/fsl-imx8mm: Adding support for SPI controller
> > >  hw/arm/fsl-imx8mm: Adding support for Watchdog Timers
> > >  hw/arm/fsl-imx8mm: Adding support for General Purpose Timers
> > >  hw/arm/fsl-imx8mm: Adding support for ENET ethernet controller
> > >  hw/arm/fsl-imx8mm: Adding support for USB controller
> > >  hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM emulation
> > >
> > > MAINTAINERS                                 |  10 +
> > > docs/system/arm/imx8mp-evk.rst              |  33 +-
> > > docs/system/target-arm.rst                  |   1 +
> > > hw/arm/Kconfig                              |  24 +
> > > hw/arm/fsl-imx8mm.c                         | 704 +++++++++++++++++++=
+
> > > hw/arm/imx8mm-evk.c                         | 130 ++++
> > > hw/arm/meson.build                          |   2 +
> > > hw/misc/imx8mp_analog.c                     |  12 +-
> > > hw/timer/imx_gpt.c                          |  26 +
> > > include/hw/arm/fsl-imx8mm.h                 | 242 +++++++
> > > include/hw/misc/imx8mp_analog.h             |   3 +
> > > include/hw/timer/imx_gpt.h                  |   2 +
> > > tests/functional/aarch64/meson.build        |   2 +
> > > tests/functional/aarch64/test_imx8mm_evk.py |  67 ++
> > > 14 files changed, 1251 insertions(+), 7 deletions(-) create mode
> > > 100644 hw/arm/fsl-imx8mm.c create mode 100644 hw/arm/imx8mm-
> evk.c
> > > create mode 100644 include/hw/arm/fsl-imx8mm.h create mode 100755
> > > tests/functional/aarch64/test_imx8mm_evk.py
> > >

