Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECF9C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 18:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwOMj-0003LC-SB; Tue, 18 Aug 2026 14:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwOMi-0003Km-Aq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:16:48 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dcook@microsoft.com>)
 id 1wwOMg-0000eD-Ky
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 14:16:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3xX2V33G8GqTdOjuv0l7XV5tZElVUkuK9DfrfVQgjV+x8Jxjknt7oQ5Ihso9tXe5NZ8D1IWrsgzNj5nsLjAkbDj/2xgPrbbSH5UWoIkL+Qf4qbI9JGcQ82QXXmDuuMJSxCle49S4G2MqhkZIUXRKnxIOMiSvhpH9BoEIughloME+SV/pNhawFEZ9GPWwmmOQH4Sq013yPlpGYqVRkVNYYPJbclSitUDCpubWfF8BEa0Os1ww4Pmz9IT/sr8VKxwpI7Op4uf2x/vqVaC5P+Oy+eBKXnPenTClRQHoT7rBc+MMp2b/413J7dNnX9LDkzy0UuWnnHo0BSO780RspZmeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41/JXrUCl4ezPEOPi3jRtKSnVXBO39WibDU7sU0f3so=;
 b=J2AlVNFgX+akF6j4P7g+1i3KWu2o0Sk5cmlqE4vHe9E1Ggae1e1I+39RHPIZh5JN3Uv7CM1tfUSgIHdeiCOluzwF98TEqbGdsRpzYQBhYQ2H4220ja03GkUw1ZXP1DuwfxEB+cGmCE1BtovPS6A6RDCKrlSuyT8zrAaOnVOUeSkjpLBFLAedaXeEV1zrsTkFCh4LKpW5SOYqd1FoUjNJZxcXays3H/JjL5sMS6d2dvkGojqyGfpg8WnNwAkY4accuPRJ4M9MG1iV7u9RSl0MGSausYVSIIUVKF1M2axu7LXq49AeS4OqdLkmBZE5E1bXxlc66Y4qlzEtjfSLZH2XXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41/JXrUCl4ezPEOPi3jRtKSnVXBO39WibDU7sU0f3so=;
 b=Vk+Nk2Zq6d1cr5PAtFH2kOUzbBlgsM4Tm3fdY5lh+5SUFGFDscFaJ7tkads98f4P2wFgTXWXyqVVOTbFE4OVUSfoKff6LYrUrch9zb9yJmrp9Qv99uTBKz/aPiCxMNcEN6PDuEKsX7dTWHb/LQA67LFgNU84FNVVk+5aVnu24Ow=
Received: from LVXPR21MB7009.namprd21.prod.outlook.com (2603:10b6:408:37f::24)
 by LV5PR21MB5209.namprd21.prod.outlook.com (2603:10b6:408:2fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.2; Tue, 18 Aug
 2026 18:16:41 +0000
Received: from LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc]) by LVXPR21MB7009.namprd21.prod.outlook.com
 ([fe80::31c0:bc96:2ac3:64dc%4]) with mapi id 15.21.0315.008; Tue, 18 Aug 2026
 18:16:41 +0000
From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pedro d'Aquino Filocre F
 S Barbuda <pbarbuda@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] target/i386/whpx: handle processor reset
Thread-Topic: [EXTERNAL] Re: [PATCH] target/i386/whpx: handle processor reset
Thread-Index: Ad0vOwQLvQ2b1KrLT1yE4QXThu+StwAAQxSAAABH5hA=
Date: Tue, 18 Aug 2026 18:16:41 +0000
Message-ID: <LVXPR21MB700964109EED98A236C929B8ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
References: <LVXPR21MB70093ED095A01CADE104F3A8ADA62@LVXPR21MB7009.namprd21.prod.outlook.com>
 <DAEBEB1C-DB4F-4222-8255-1EC162AA0E71@unpredictable.fr>
In-Reply-To: <DAEBEB1C-DB4F-4222-8255-1EC162AA0E71@unpredictable.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=27d35349-d1c6-40a4-9ac4-fc32f7934e79;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-08-18T18:12:53Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LVXPR21MB7009:EE_|LV5PR21MB5209:EE_
x-ms-office365-filtering-correlation-id: 34dddd0c-a002-40b5-a687-08defd54da92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|7146999003|10067099003|11063799006|4143699003|18002099003|22082099003|56012099006|4133799003;
x-microsoft-antispam-message-info: qkV8dFcYit1gKWYcj2Y1iGLgu8zNbLEkgDNWnyhfzMA5Ygs5sdbFNxD7z0BJel94fDL8Z8uvCvZqAIix7zhR1X8eUUr3SI6j87u1R83HKFCeV/7nslM4mSIZ9E2Z4x4TH5y+mkD8WwZ1MiFOWOz++H36dgrUMhkhGPXA44KSn8KMLvOGCKeshlGRPPRGlP2xfjD/DyyZpOrehh4v747U7Uz1NYL8KoAgCkXSvokKxGNVKfMa1C1hCyP4XUiyuupM/IX0MkjMscAD6EX1UsrpCujxV3kGTa0CeXDrih3+sTpuCvIQqqMxm0moyM5fJ0CQVn/Drrn3SlPMqeFUtDPv0WMYHn8AX+lhttZ5EBIWvUe22Tx3c/EbqzePVOjtgW9VNLKgr7leG4lAaMQQiH1y5eKYJt9OrlSvttTmNNRSdo5SSjBPK/zOK7Xo5xVNX/hc/T70zVRAGOanlfO3Mgn6OALLOP88qFjUNMX2pbhDq/oTHpX5OkuDCb9Z23pgrvb5vKOAmF26043GvnWSYhBpsrUb5+M2+B/FDE83PCqy3yvp9nFZw4tG2Tv19K1LXiha6gwT3zZCHbkjfhsGcah0udR1QpW72v4J858WIaqgYiGTKuko9x48YGcIY185QHOZYP46dtDi8SamayTYB7+rb8Ltfu44tAs+dTqIXD/EG3dLt8A1bRXGBlyL5GLdDY4z28B2Bu94hp6KZphg30Y/q1+CFIGQFupGMfUYdj01Hi8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LVXPR21MB7009.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(7146999003)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006)(4133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GRxcGay8OmCQh8CebdeIVGcZMuSe4Fuwjlzh2QiwZdxsIQAr52Hj85UQo+mY?=
 =?us-ascii?Q?Ij5TFiYsoZi7EcYaATZ6fHoaJ8OblO3f2n/hwVdaLqQ7Kt6w9bJBngoGdqFJ?=
 =?us-ascii?Q?kZMW68vicEHdvMsWcGOLvl1cV6/NFGNxOW/4n9Gma78kbDrvSsV6Qd/EGBdl?=
 =?us-ascii?Q?J/J6kkQaVHo4m1I19rrH0mwgxd2uH8Eld0NSeXMQJjFfVayHQiegQ9Jx95fY?=
 =?us-ascii?Q?Fj4pJdkmfUbQ5WyYqx2VUVp6Kvv9N6j5FwuM7vuop/ocM0uQC+lH0NicUGPp?=
 =?us-ascii?Q?3QeaPukXk0SHQBaBqir0TaJ3XGzAatB80ERR5UNc8a+jgGnSWYiU+yy50hHH?=
 =?us-ascii?Q?cTOAh47nBh55vtCc7vf1q2SO7/8HhdRgLjPpKZMBeqzOA2fzsp6rb1cYX2Hc?=
 =?us-ascii?Q?cFUDaMkXfyn4MTNVhigu2UAh+YgyR/HwpBwgYj/BglVp/GjVPMGYSs99Jy2F?=
 =?us-ascii?Q?ui5dVKDmkWjO1ME3NzU2cUhm56Ol0H9bjjzSRj9klok+IBUNzLmSyIrUXCNU?=
 =?us-ascii?Q?djmJKxerRQIi132ydkiG/ZRCR/fC5Gz1h7u27osP79gH+iFyGI8UX8gl+8Hz?=
 =?us-ascii?Q?sbsQEpgzKG9vmiEVnqjHIanYQ0pK5wcuXCDpQdN6aKQch5WNQ3FHSloW3Q2c?=
 =?us-ascii?Q?anpXloZOmsLu5paMM+++AAtUvcZmu1Dm/9TVrMR6qtPdZ/C/DRXyoLLSyPMg?=
 =?us-ascii?Q?8S6IX5t8v8lMZ4cphfWvMLStpNqtVx0euYNZeuJymiovb3pOcOEfRbJR5tqr?=
 =?us-ascii?Q?E4X7j/qdjonYO7KFRF8AWQ8sKozdFBAnYoE/7o+i1i+igp2aBJEnVsYfRFq/?=
 =?us-ascii?Q?ieixHaeGiYb9Ka9ZrnORtqrDS2uFy9DAWEpj4P/4l8tzB7Xmx+5DPmBidrLh?=
 =?us-ascii?Q?RMsjRYu3+uJnHI/OcdctZZ42QXU9NfcqCiS7vIPd/V1VxoZbkAbwmziWykMQ?=
 =?us-ascii?Q?n0PhWH8f4tC2CPhjDcM8mtEdI7cJDlqXWxHupyqr/Hd+Wcl7Dh1N/0ufHmYk?=
 =?us-ascii?Q?juMeM5Ypadrr9Rx9+ygPV+1I7GD3JZfohFfLwNshFJx55TbGESXSlJQLRHe0?=
 =?us-ascii?Q?umB0DhR6Um0uLWz90c4mMn/REl9CWuKEqi4EqgnWwn3sTbi2TinLus64jY5I?=
 =?us-ascii?Q?KlrjEVMWGA9gD4nPVYWIYCvEu3O1wFnl/4Yo6C1PhLPLhyhfwh66hvhvq+/K?=
 =?us-ascii?Q?xDiSfufUX4Z6L4NCAa1r0aAf+PoncchtyZzlm7xfk7Ga7VPCtGOsxU8Twc1J?=
 =?us-ascii?Q?mSMPescZS6r4+r+Pbw7eX2lnOPnY6fN8r1fiSrOQpw2WH3ePxW/0SHHBDopu?=
 =?us-ascii?Q?xWzPoU/WgRJ/U456d09R3iSVVVVyEbvXtNjsp9K38aPwXQzxIJXTYYQemMUI?=
 =?us-ascii?Q?51gsRb4eSPDwXkmF+AcJFEy7LbAWNyBpFFRdoWib8vNZxsmE7jP3aSvpgDbC?=
 =?us-ascii?Q?mE6LIyJNx85Vvkffz72ZQI6AiOiO+7AP8r4/LbGbo1sQXVuW9H4zmqUQe1zi?=
 =?us-ascii?Q?6501rh5ZLpE+gEqlqoCoKi3e3axUo8oks/TajF0r0XEq2uDQ0/jXKTZSh6qz?=
 =?us-ascii?Q?toIbwjOj3hPbb6TGeRHrscdvct4J8FReHHycN7MFc7VjZBB4vmfi68ML8Jg+?=
 =?us-ascii?Q?gmReEMrbVMf+KWSTgTYeLFQ6sErIS7Eaky60pIuhYuip2cB5asK5pT0Dh3Yu?=
 =?us-ascii?Q?0/Nld+5C7xkLCOJaTTzOTRnHzJ0DqOj2ozxwOyWTxAKsaT2C?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LVXPR21MB7009.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dddd0c-a002-40b5-a687-08defd54da92
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2026 18:16:41.8697 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EdW5QHbNXE5EML0jPSjORmGBQ3JEDKmHqjBqYAk7ZiOH7MJV147RuVS+aKqG/zLhwV/8de4fyumpu5OC0W0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR21MB5209
Received-SPF: pass client-ip=2a01:111:f403:c107::1;
 envelope-from=dcook@microsoft.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

> > On 18. Aug 2026, at 19:58, Doug Cook (WINDOWS)
> <dcook@microsoft.com> wrote:
> >
> > WHPX is not properly handling processor reset:
> >
> > - Does not reset partition, so several registers (e.g. Hypercall,
> >  GuestOsId) carry values forward as "Locked" into the next session.
> > - Does not clear hypervisor-managed TSC deadline (live-lock).
> > - Does not re-arm the wait-for-SIPI trigger, so all CPUs start running
> > immediately after reset.
> >
> > Some firmware may tolerate this, but OVMF does not. Typical result is
> > that boot hangs or ends in triple-fault, e.g.
> >
> >  qemu-system-x86_64: WHPX: Unexpected VP exit code 4
> >
> > After this patch, I am able to boot to Windows desktop, reset, and
> > boot back to Windows desktop. Tried many times in sequence with no
> problems.
> > Used several different reset mechanisms (OS shutdown menu, external
> > "reset", watchdog reset) with no problems.
> >
> > Resolves:
> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
l
> > ab.com%2Fqemu-project%2Fqemu%2F-
> %2Fwork_items%2F2402&data=3D05%7C02%7Cdc
> >
> ook%40microsoft.com%7Cebc7a2c3ae3641f12b8308defd533da1%7C72f98
> 8bf86f14
> >
> 1af91ab2d7cd011db47%7C1%7C0%7C639226731139271283%7CUnknow
> n%7CTWFpbGZsb
> >
> 3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsI
> kFOIjo
> >
> iTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DTMLja23Uf76wlskB
> p7w%2BiaS
> > x190p%2FQblKks2awOf7C8%3D&reserved=3D0
> > Signed-off-by: Doug Cook <dcook@microsoft.com>
>=20
> Hi,
>=20
> Previous version of this concept at:
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc
> hew.org%2FQEMU%2F20260421205749.55060-1-
> mohamed%40unpredictable.fr%2F&data=3D05%7C02%7Cdcook%40microsoft.
> com%7Cebc7a2c3ae3641f12b8308defd533da1%7C72f988bf86f141af91ab
> 2d7cd011db47%7C1%7C0%7C639226731139298436%7CUnknown%7CTW
> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> W4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtE
> M4SLQ74SCFEwIW1LLW6GM2FGcEmzD5KDMVdo8mr14%3D&reserved=3D0
> (with it intertwined in a common path for Arm support)
>=20
> Using WHvResetPartition as a workaround for some state not being fully
> synchronised isn't ideal though...

As far as I can tell (from testing, not from experience), several important
bits of state (Hypercall, GuestOsId) get "locked" and can only be reset
this way. I would be happy to learn a better way, though.

Thanks!
Doug

