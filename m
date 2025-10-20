Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6CFCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqmE-0004ia-0L; Mon, 20 Oct 2025 10:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vAqmA-0004hs-RR; Mon, 20 Oct 2025 10:22:20 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vAqm3-0000N7-DX; Mon, 20 Oct 2025 10:22:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgNs3vwAV+En/qOoNqwwWpKdYQrgFYUjs5m7li6MGbjcqPDr8nNzO2np0yioNnMDwrXzMtmUL691SXwUNyOldisiQfHu6+9DAYJOsEtHxNoT63Tyb4W4x8KqM+yNJJg9BtAhsNphPjRb+aNWvJdNgnWHb3BHIawYtYV6wUD4fVogbxqb8qnOaYjqY3KUecLZpxSMIoIBi73YNYmMP9V0EPpAS1PpUlWW5ez4PB96/N2ctb7k3m+VgMcZh20ISG6bi5F0SVokqp8uy8/RE0wdXmJHdPmlrtBYEC25jYYxbX/ZAQIZBTHv1F1alxYG5HI/tde4brQe5aRCFXGiilwYqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wupuepJm+94LT5p/BYjFx/Uw850yz0kK7nLguq9TIc=;
 b=iG1eAwza1vItZBxKAj7nZFJr1ronta2Y6k9DpKRQzTWGw9sIGvu7myrwfk1yZcWML9eHpMdTbss+1wY7ujV3fB2AgLhp3gMmXbqoWXqclH0wYZn7qcUniIALWiO6Y5UAtq2WgnBseXh/pVxueXef+sMWOMGf1oFCoy8gR8y1J+JKAwAh/3IKKKsjEOX1eohoeNsYfpV5u3D+H9qvsYoHTqNhJBbx8nua6RpPsVk+X2e83I1hVE/hEQXOLw/l/SKgk7uXWFPFR5rF9Lvo/lN8/mgB6aSfM2PCWLAJmKOWtYEB4wT9qR/kdYsrA1IOFNDqjjqM84nc/sbgFSJ5zDPokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wupuepJm+94LT5p/BYjFx/Uw850yz0kK7nLguq9TIc=;
 b=kzFPzTnUjccaTMugjeRKFy3qidmM8geO22bEPyAM3ilNaUZBub/pQbDcidlASvCHYf8fYfRrzeS7sBarEabPqX53RvTOeCoqYb3xEKuv9velOn7olsPhyjf2FNqR+g+vdQWU2sQY+mocORDKfX2b2ojHOo4vhUSXut5hh7CDErp1raJCQydaksCr8HCCBRaG8jbKjdJ+RNY/e2JA6i/AbG/juojwxuHDKF92Sr6alrkG71MkPdh9gz5wjyvhdR44gqL5qfQQdEpWCzX7Cchpvnnv/4Ym6fydfBmYg6ZxHUqt2x8YebNzDKzvwbMUkMxv9EvFRSU+5/eX6qWgnT0MCg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 14:22:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 14:22:00 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Thread-Topic: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
Thread-Index: AQHcPvNf8cNe0zISsE6Kcr2+CesP+rTLGI7Q
Date: Mon, 20 Oct 2025 14:22:00 +0000
Message-ID: <CH3PR12MB75485BEEB50D8B5A462D132CABF5A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-20-skolothumtho@nvidia.com>
 <aPF9l5GwctGN0tqT@Asurada-Nvidia>
In-Reply-To: <aPF9l5GwctGN0tqT@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|PH7PR12MB8124:EE_
x-ms-office365-filtering-correlation-id: fa85c310-dfa1-4d64-401a-08de0fe40897
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ItW0kgu6HtWNX77JPectkqDcfM8BmRcsjDRbMQXFRPLukU82D2K178HD15Ni?=
 =?us-ascii?Q?AqG8cRCLukdS6300+uH7klTx3IDOMgTAOrZO2tTWupHboJBxeSO6Ay6ihG+0?=
 =?us-ascii?Q?bqloF9qmEPgeD3vvtJoogAfT0OUMQJJRlAmrG4SFn+tZ89dWKc+ILebPZteN?=
 =?us-ascii?Q?tKEpFySLcRNrtVYsyQv0QPR6E8RcdXUxh65QEpkaNOBkPJ9WjEW8f8l2nFMr?=
 =?us-ascii?Q?nMOB8sa7ADT+ql/YA71sXkyZ0VBSYQ5S+mSANKFHjsfThWpgwDKAIMX6Tmkp?=
 =?us-ascii?Q?J/CktEADBsDDnNXB5P/BWtEfzT6hFAcmPRqpljzougeqHgMqES+TSgpKs6zg?=
 =?us-ascii?Q?JleVJMSUtPMN4QfP+rwXSmBMtXHnIHnJF06dBN7xgB7Bx7hXEhvnf6FllXJD?=
 =?us-ascii?Q?hleSyKNxf3a24TOHIpz48yXUlJZLDc+spKMOoTMq9OeBGw9kwnJBaf6cFAfg?=
 =?us-ascii?Q?mb42lxLRVXFKZJmrv0e3X9aCiMhXg2x+lTtiNadnU3fplz2yWVTa1Ta/ibwV?=
 =?us-ascii?Q?XFWUxkn26kekDKQyDpjO8OuvvskZVE+UnV5lCCUZDXQRb3muametw2Dztt1x?=
 =?us-ascii?Q?EGkSYuHCcDmqhf/tVEXiVUNcGL6ewDrwbGakDUlIV9UNSVY1yxebT5AoI/23?=
 =?us-ascii?Q?wMKoCQTrbJrSKWCDhRP0gX5Qh41bmzyh00yErnbbYZgUj76AFyORrDhiFNdr?=
 =?us-ascii?Q?0DTuWfZz8LVdXWQyMk6IorBqs674g5L0fjK692F84ZIJA1DND7l1o/KYKIFJ?=
 =?us-ascii?Q?Ctolr5wGhn3HQ10BJPrhNVPccAuJhXvACfHI+Zcxe200GaKGJ9l8djZpvfp1?=
 =?us-ascii?Q?cTuV8NrTOxhy15jGU3EtjtppnUkzqqT0khi9GZKKYVfg/RFNpNQjUf4kMBoD?=
 =?us-ascii?Q?M9T0afwQ911pn3G0qeVkpccfE+cROCjVMuW9RT/561Wa8aUNAb9toaBQcPUK?=
 =?us-ascii?Q?oAIUM6I4Mlz2jue+vsrgYqE2pUl+8Pylgkk7aH7NxDitrNv5KURzP6EwO083?=
 =?us-ascii?Q?uO9W+mgO1Q9mO6b0Rrs57NeoN8Qyui24A+Qlxk1lvztJ/Uku29YpFCi/JqcM?=
 =?us-ascii?Q?9+PxQw4P5ujy4OPt6hFNAjspl1IIhvgRoC78HQtBABSBdDD45gEyPEjeq77U?=
 =?us-ascii?Q?V+f1hHxQQBaeN2rzuBiTQJFaIdDj7BkdNGPI3kgQ7lmhP6gE0aHw0SjTacqn?=
 =?us-ascii?Q?I+l0pQd1e8SP6s0BqNyUPWFwiGYWyyUR9KGYz9ZVZZ5a4DMcxVig5okOjIKC?=
 =?us-ascii?Q?v0HPNmub2NzRKnrCUOc822kwj9u2jw8UTFUBaghtmv+jERrNs0aLnb/TLqGK?=
 =?us-ascii?Q?guH+ShqdVSfhmWdNiLK9VrQue2269IzbXapWmjj/qEuxYDJKgia8f25/yupx?=
 =?us-ascii?Q?1e4e7yiXcpdFuIfJdoKJyo43Qv3dPA07Ua4KAMdOoSXkN2ozHCcf2BHFlW7V?=
 =?us-ascii?Q?2I5YlC7zH851OhzJ27VTPrxGtr1qhKq1XVbeKMMqsmRIDtFJ7vd5aupfG0IV?=
 =?us-ascii?Q?EAK9CFg7STeYOlhM0x23aQbkNba70g5xIpZL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(7053199007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LoQURhSB9iMUeJT/b61qBm7l4oVqqeOuH3wjTXoI2AqzlztjDv17C5LDY3TW?=
 =?us-ascii?Q?A43pbZYpJErh/FpmWT12rE5hs/qsDPFiXrSqd1j84frKylxE5G7At1hkxLRo?=
 =?us-ascii?Q?0n2VRi38M5vo0OkG3j1lOvLW35QdomjIurxUTy0YTZoHsb2s0jU1zRTWt+tI?=
 =?us-ascii?Q?dOYq3wXTxjPQNXKq+PsPExxoi/HJWZozrViKk0oikuOJdhj7Bk2hsaLMlTN3?=
 =?us-ascii?Q?4MnDSt9iAUUdXD1k3qdalLNvM1ymNMAWZO09DudKlZ2AERXlcu6IEAvc9go5?=
 =?us-ascii?Q?r3rWOOxFGp4djAhxNHVqtgP3qqD6fLnlEbiYnWaJTp24T016E5Irt3Iw4onx?=
 =?us-ascii?Q?k6Di5K9WVQycFpHiqBGaC7exOj9D/eeTkP/J6jR7ndvdKTEIvI88E+TZDRTL?=
 =?us-ascii?Q?PE6CTo+0vR+uGjO/NdAB2qmUOYfRO/6crEUuLPn655YiDAC+kO1qcmS3DVZ7?=
 =?us-ascii?Q?qJXZv3gZiQWnwYRKdf+1bXWUhxqzq2vkGysU4k4r6fMFrszVK3Sw5Hvfv8X3?=
 =?us-ascii?Q?VAAfkR7WbbyHOeSP47eCijJt+SBleYl/Zo4Kp0JOsSqtt8j8q637D7y3bisg?=
 =?us-ascii?Q?MM4uGYBXOFPaqiNEYz8fiMMO8SnHZcgyewrIg4HaJ1phhHXOaMV1FlShrU82?=
 =?us-ascii?Q?jOq1I6cCJlpX1kfi5OZwym0Ty/X4Isg1cFMkuUQrCfRK+1QHnDNd1eXimmKe?=
 =?us-ascii?Q?B7GxVlM6Arz5Ul4I2GOc1013ZrflzE7gG+T8JHVRaqiWJiCgfUpBccu1FhgN?=
 =?us-ascii?Q?i6X55MaS8on7SkEaTvA5r8Lzo7oZ850ySfDEOHZ/DEp3VtYwL9u5mh9UdHPH?=
 =?us-ascii?Q?rl/Z28EJ7nz8xFWsY3fWdH7bYgN/r+ErbIkRYGKTx8OvDjUR4S/BnmPkNVcS?=
 =?us-ascii?Q?JTmVC3ZPNW6R0fj6DElnKqg1Ux2PuUkIYPbZNFUoAeXU9V3cVneW+F5wXCPA?=
 =?us-ascii?Q?OOzY1sAy0K5UoL88hz1noSQp8406mjlkRz4yNzQMP3e2GW61/I2DFmlPnFBr?=
 =?us-ascii?Q?2JfsWdwtaulbDMCO1gmVtIamgZvhRVKdPr+tz2+nTXkeZEP8QN1+GlTQyNSj?=
 =?us-ascii?Q?e9f/3ZbeGxf3WU/2bNeDYfC7g6PypmFpIAk+y0NhMFXVG2fcum6KRZws1aNK?=
 =?us-ascii?Q?TWh5rjfAQwvJE52qtlP8/jn4ZsRQf5vB9BtlqwqRH+TgQ3egMuA/3Llq9leo?=
 =?us-ascii?Q?EOSuDwOl69atI7ViRGE6FV7SGyk5ybo7ygmxZt6xshDYTW/gT/yterCrHvuV?=
 =?us-ascii?Q?Ss5bCP6i4nrPsYTJfOAlVcXhWwPNFy7qoHxb1XrulPMjjau/6Ta5I4kmUftC?=
 =?us-ascii?Q?KI6//oZ+Utu4ck/3mVivT9P7MJGpdNUbBisOR/+w7s6X09xaAb6anO3NgJDX?=
 =?us-ascii?Q?rQ3ATNUgKHZrdZfqhKa2mpGDvRyG1sAZ2FMVVKsJ4pSNPbeEUdbZ2NSt0ktM?=
 =?us-ascii?Q?+p5tynpN46b+Bzfj11ZRw6nl1CA8msgn/4hkH/44uZX1TRrzRkBrRHsTOfgf?=
 =?us-ascii?Q?37XR+cGbWE+JCSRX2VOa1tC3M0/QavHqTuygc4YEbFrEaFNhTGTfXT7aZwS9?=
 =?us-ascii?Q?iUWwr/lKYUOsBLWLvlhsDFc/MmMxObsZlhzu2mOa?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa85c310-dfa1-4d64-401a-08de0fe40897
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 14:22:00.4210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWR3pVLhI3qPxjE82FAagbUv/ZFP+mgwPO7bhbH34KvpASXy7eU1OhiUdH8jUFXPYEkuVnYDLLGNQiZ4YrmDqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 17 October 2025 00:20
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> <jgg@nvidia.com>; ddutile@redhat.com; berrange@redhat.com; Nathan
> Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> smostafa@google.com; wangzhou1@hisilicon.com;
> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
> shameerkolothum@gmail.com
> Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt
> on reset
>=20
> On Mon, Sep 29, 2025 at 02:36:35PM +0100, Shameer Kolothum wrote:
> > When the guest reboots with devices in nested mode (S1 + S2), any
> > QEMU/UEFI access to those devices can fail because S1 translation is
> > not valid during the reboot. For example, a passthrough NVMe device
> > may hold GRUB boot info that UEFI tries to read during the reboot.
> >
> > Set S1 to bypass mode during reset to avoid such failures.
>=20
> GBPA is set to bypass on reset so I think it's fine. Yet, maybe the code =
should
> check that.

Looking at it again, I think it doesn't now as I moved smmuv3_init_regs() t=
o
smmu_realize() in patch #14 and it is not in smmu_reset_exit() path anymore=
.

I need to carve out the IDR init separately. I will do that in v5.

> > Reported-by: Matthew R. Ochs <mochs@nvidia.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/arm/smmuv3-accel.c | 29 +++++++++++++++++++++++++++++
> > hw/arm/smmuv3-accel.h |  4 ++++
> >  hw/arm/smmuv3.c       |  1 +
> >  3 files changed, 34 insertions(+)
> >
> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c index
> > defeddbd8c..8396053a6c 100644
> > --- a/hw/arm/smmuv3-accel.c
> > +++ b/hw/arm/smmuv3-accel.c
> > @@ -634,6 +634,35 @@ static const PCIIOMMUOps smmuv3_accel_ops =3D {
> >      .get_msi_address_space =3D smmuv3_accel_find_msi_as,  };
> >
> > +/*
> > + * If the guest reboots and devices are configured for S1+S2, Stage1
> > +must
> > + * be switched to bypass. Otherwise, QEMU/UEFI may fail when
> > +accessing a
> > + * device, e.g. when UEFI retrieves boot partition information from
> > +an
> > + * assigned vfio-pci NVMe device.
> > + */
> > +void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
>=20
> We could rename it to something like smmuv3_accel_reset().

Makes sense.

Thanks,
Shameer

