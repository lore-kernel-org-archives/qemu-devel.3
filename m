Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBF4E9128E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 08:20:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnuao-000542-4K; Thu, 05 Feb 2026 03:20:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnuaj-000533-Of; Thu, 05 Feb 2026 03:19:57 -0500
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vnuai-0004JC-7f; Thu, 05 Feb 2026 03:19:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BP9ToaAQC8gsszOefREvNGsG8Inj9fEGeUZ2A2W5lQUXrpb4g0nKZy9VATFb3mg0kgJsQatRh/hrQQ6SADzUx0DDnVJpl8WS6v7bggNIJvvEQh5fgbjAY605/N5vHfus7s8iX95lPfCBa7LPzL+wb+7+iEmRCxALqbko9L5cy5WAphSkfUQLdeu1o38CBfP5LkOXrfy1o+W30GoRdzMpU4fmyO/S1jssqO/3mkjyx7AeVqRqi4b4p1e2Po0vUVnLTXP17jRyxj3kq9y6B8yUQv2EtdUIxQzUUflIp8/llijnZfW9PLemER0vmJmCmsM4MyL06tQ6A5avbCjjujeiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Wx/4NiqMLcVRwLxNib12m7wrKY5hkE4wvS25FIqLHQ=;
 b=avRXsnU0133rbnk0nzQzwR88iQeMWk+bMna+/pYQsLPHsZpFPK8FcWuGl+gjRl4nSZjSC69k0i96iotdHbDpH2+AJbws9ArLkgPWvW+dJ4V5Tu4WWaVNt++YXdlhLqwhzkD3DRMY9MguslzKZQVWaLmzapvqrvCh9beCcn6+ob6wig7RgN3rMHKfq8Mpf0C65R49y2hD9+DVs1Vw1OmeNpeVyVZDRhlHCAMusKGNncJ6FMgD59U2reRrcOt0GgWaJJUse0pe0jcR7fm6u/KalAGf9V01og+tTO7PcTPzokzlYSr2CITAUWhKaPxN0XySup0J5TIschBLC7/y8Nj82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Wx/4NiqMLcVRwLxNib12m7wrKY5hkE4wvS25FIqLHQ=;
 b=Wny9XdCIZIpCRwBB3OD/xljDoNHPYw6eJ7tjX+Ziu82h70fH630oCq/70aU3P0vBLE1RhsPh5KBI+Oo5VlMElnhjnYEIdPhVJqy167G3qeFuwc6C9LEcBCb0Eftuu1CReTVUAh6k3NTulRbDAR/f7Mn4mmGbMyM1XZsEAXZ3WBAY4yVXD2LrFE9NWmG6eOguediqRJV9PW2ly09JWs/WqIW57vB14oNix1SYhKVRk7l994THhzgR+cW2IMP70zqxXFoEsesUT43+A7wW+fo/ogPyQzOZxn0rBGO8vePqlBRCVAfeG4kMjHpIIaoOe7Y3PwHVRFoL0cV1BEQQPNicLg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BN3PR12MB9595.namprd12.prod.outlook.com (2603:10b6:408:2cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Thu, 5 Feb
 2026 08:19:51 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 08:19:51 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v4 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Thread-Topic: [PATCH v4 2/5] hw/arm/smmuv3-accel: Add viommu free helper
Thread-Index: AQHclgikpofCcwQ9NUCfK+OaJ1q/kbVy8rqAgADQvHA=
Date: Thu, 5 Feb 2026 08:19:51 +0000
Message-ID: <CH3PR12MB75481983036BA98587D76B4DAB99A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260204190008.20070-1-skolothumtho@nvidia.com>
 <20260204190008.20070-3-skolothumtho@nvidia.com>
 <aYOi07H88pXyqn5j@Asurada-Nvidia>
In-Reply-To: <aYOi07H88pXyqn5j@Asurada-Nvidia>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BN3PR12MB9595:EE_
x-ms-office365-filtering-correlation-id: a80a9d76-191f-4472-3453-08de648f5597
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ZBBPefozCQE9/HccLgjH+O9FBpwzvzm7mxWWO93LPNiUy/OVQhGze9itTaw3?=
 =?us-ascii?Q?KSsoJooTuh0jtoNrIh8SyXvf0TLgVLnHLybyjhWwLj9ye6Wo2hKLV/oStQaa?=
 =?us-ascii?Q?Lq1JSiphaVzpQfoLWyunGhVBqqz/dQwFiEWaxWqEZyjZnlACFxBqUD4qVO6L?=
 =?us-ascii?Q?JEMrjYgV3qq2H5x2ZHUnEt6u3Q1Yto9MTuQy34R9WfjDgamk0OW9keF8MDyY?=
 =?us-ascii?Q?pK5ek4NzHSlP69L1F/udFkRdDegrLUhzYRGWd/z46/4HttHm7BvTc3Bb2agg?=
 =?us-ascii?Q?9yqp0PljyRmPCvnebsOdJiCkMszeKKZV2zy+HSUzGN/hRA7nq88HneKYVxgf?=
 =?us-ascii?Q?pWqmrUVSfqb7WKRmCvPHUChJRarqpysvaebsaNiHhd6q175WN+4k5BZUJrMH?=
 =?us-ascii?Q?edFpiX0vha+XP5etbQsjtb1POGidCVV9RCneb8Q8R7dTEe++mrl124bC7xHo?=
 =?us-ascii?Q?dIMvPqILuRAIwE0HksL8knRWP11bslzgps1kL7/Gx1P57GgwK9NR7/HOteuL?=
 =?us-ascii?Q?bAu2GTG4OxqVtBI3R+GltYyXDa8OiChdkmcscSollqBeJ6HQwOF8KAkWW6JF?=
 =?us-ascii?Q?ROXGAupBleDWLvjiq8uyUwjebSrCi2Tl6P4SOB8/ACxiblagFj5h7adinBJN?=
 =?us-ascii?Q?6f4WZqYcM2Om/abPyrfeUZuv25DKyhXjIkbiK7eDM9dnmjDZX9z/lTTL0k+2?=
 =?us-ascii?Q?qbH8jBNn5kINBpirMqVP3ybbQZELJOG5W3g482G7a+vROKz/Ec+7D70CZHPq?=
 =?us-ascii?Q?7Q41Qemgtf+g7nKnV9q32rgNFMVAYBfLVlW5HbCEE9Ju2I88wiIwvXlJD+ru?=
 =?us-ascii?Q?eqozT5WgnkOBgjqQqBi/9v4lx7OhmDmm3uO/xmkHscUl5TWNQVl7SK4QBAA7?=
 =?us-ascii?Q?Bc427pWgy8AXNH0/Si3qmhTOjY7CERgJqVrlj6dQFFgny+3f1PZUttIUQ6Qo?=
 =?us-ascii?Q?lFclfuqo3gIkQMkHa0tKT88YUQtAkVcdRXCxRX+lPnlGg4lvV2m+TcR3FNH6?=
 =?us-ascii?Q?gjCDqGvHhLQIUTdupsqNNJqmx01/OwJ4VtxP8+gPIhibyz1OeEBU0dfcsHo5?=
 =?us-ascii?Q?y98FgCill8it1YcqKb6pdxADKcRVGWdrAgieUi2yiEXwnzgPpYtvDdE6uI8N?=
 =?us-ascii?Q?o4e+wm4WLBWGM5So98WhtgvaOm+JUAcLZ/k3pbXNn2Twso3xdI7iB5ZxzNYE?=
 =?us-ascii?Q?ZNL8GJkTFZ5sloZP+aUN3/iAFsB+zyHkMWYqv1UdO7PJ81jSg6uDcyIxN0Eu?=
 =?us-ascii?Q?/G0Mz+vaSTl60GBpvaY8P8fGYAD2STzyfj7Y3AdV9R206BqiIg+Ad/4ug07R?=
 =?us-ascii?Q?EFXZv8AFolJMiBx9od8xo3xqoT59G5VMJxIlIRvhltjn5ntdfeBDeW1K8rWB?=
 =?us-ascii?Q?uoAwVu3rJCjLArLAX/x/F5bJNZUA/DzeMsOp2uAWIqRKlDTXDd9s0os85dbL?=
 =?us-ascii?Q?Gpkl/cftAQbah+M7ohXKK/pzO2s6yfOGx6QvbhPKPXIAc7D1vNG6FlIssnHB?=
 =?us-ascii?Q?FlV/zrrkEFmrlRNDJUYb/wM66o0r3RVKloI4My8G0p5+gOX9oThOaRXJgy+5?=
 =?us-ascii?Q?kMvHwx0wC5t7UcvoNVQGSIPTLjOpqU1JseibZklfoTVOful/rV4SHw/yXPx+?=
 =?us-ascii?Q?vBop8YjErPY9phkgVbG9hwA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9dOVAYvo0Nj8SmjHbRQ9+ANTmtD1j0Mhc3y+4eSO928LCMp0F7yHJ0z/eOlB?=
 =?us-ascii?Q?Alb/glalJuWV6rQsegFQ3qRAn9Jo4+/jO1+nsVonLkVAlGJJJDqaXPMqW0gB?=
 =?us-ascii?Q?Zfqonbd+QrMcnQ5dpWG59+ttiPLWCYJHkGdue/FCP8Ib7lotiTtXpCmKpuD+?=
 =?us-ascii?Q?r2pkng4vT32KDzmzazEcYKS0jLatwHppKD/HxuhaFO/6b/vikofKUEa3xIA2?=
 =?us-ascii?Q?HI93hLMF1I6TyzaQr5Brqs+va7RPUEEbuac/ZuD8EDBpjwchyw414QOc2eh7?=
 =?us-ascii?Q?i95JOhCoK0wU6UBqvQgBZR3ShFixrEKXmv3MNcEJsEj9lQ651lj4qbJFmAf8?=
 =?us-ascii?Q?BVsrEXuhILrINn+/KOmls3+6Zbvna3JEBcnjnAPXy+UuwW6b9lgKjFNzbCm+?=
 =?us-ascii?Q?0CySxxY3lHj6vPf92qe7DdLLHA3sSOdD5yxrqM+uIH4d2pao/IRbDOlxWk5h?=
 =?us-ascii?Q?t3ia1WiIwuQzPlrcmlvo1kE6ppQrFLgXqHzTGeG29ixRUKb+SwIxAbDfG+wV?=
 =?us-ascii?Q?iE6eZi6TRPrsEFxVeRugLJ60dD36ZTewdYvfLVKJpasRPHeBjeP9xRp8XirT?=
 =?us-ascii?Q?EuKtFFqA6+UbqwqX3BpMWVD7/Z/fcqCrCw+O40m5jMcV7zRTGXMhRc0b7St9?=
 =?us-ascii?Q?7VOrtn35vEDpn/G5d4cvh71SNtbyd0igSVe7sJQLS6w2IIv/PkPPEb1FX+kj?=
 =?us-ascii?Q?5J84P6omfK8Q44nJlo6k+RPaI4xS+r0HcwC5LiRCLO2CNGJa9KbdC2t98eiK?=
 =?us-ascii?Q?0JJHgl3ZWe+neb5NmucGp9eKQcCi6InPO+Tsh4NyU4CsFGjiNO1Y/Gvt10Gn?=
 =?us-ascii?Q?cooAQ6Xx6tXqtu6LBFXDNfdF8XLHwyaX2owuL1hnrUVYR/s6xnyegMzLOcYi?=
 =?us-ascii?Q?I2cO7ANrx77v+jtkHxXauOOwi4xWw0K4PLv/TU0boqV4L9ypHwYOp6fBW5ur?=
 =?us-ascii?Q?OC8lP97PJi4zliVS93b0L645XB2FJR/EHgMLTldQ6CTxvs1ysk/o+ufc4Iw1?=
 =?us-ascii?Q?5HCqmeETCf1qa3A3ri2cTSSXDHq4hYHyxcfAiN1QfYqRLtAMAL77eKvH3bii?=
 =?us-ascii?Q?B7poTEJyhfK1s0YOr9RB/deV+YIJCPCZCTZSXRfX4l1xLoDc2mtDPKjm5rqL?=
 =?us-ascii?Q?Jd3/b7Dgp3VJrx4Sfff7V3UAXxCfNHGbgu/AvXXte4EqEMTNbSQegJiboxAX?=
 =?us-ascii?Q?wAQHoUmSjSFuOr1Qd3IqgbIw+tiuVb8LjCS/3spU+7MqiauxbcrLA0IiGGgs?=
 =?us-ascii?Q?GaEr9scPWEMkMrhFhEm6W3bIw4sFo2XeZIQqJabNKkIAC3aLBTa9/gPUF505?=
 =?us-ascii?Q?7oWwrJtDAcHD4i9A03WN2q6kE3JBe+Il57ZLEX5GIwinzNYpvNC45nj3cl41?=
 =?us-ascii?Q?7ihFhjlhIBgUmaR3DpwNyL/pZdX6CT51wb1np18yuA6sPcj1GM26NkrLcC1D?=
 =?us-ascii?Q?zW4t5rOPemQGscU/fAkjpROExEjO0Esb/VSIgXV4i+FFWOYAEc5aSy3jGsMt?=
 =?us-ascii?Q?iXYEj6fiQV1JeaMUF+j0hZvtkBBB10e+KXA60vY99vNRJJfmTiElef9D2hwi?=
 =?us-ascii?Q?qn7cmTeCxxFii94leK9u8ciQYpfNMTLfVbAXAlVLjkoRspUSVCx5YWE+8JTA?=
 =?us-ascii?Q?PUkqekL5Dcufr+xE6U+NuWRQ4ynj+1AtPv6K9jZiCX7xPQ2HtjoHiqLhflzt?=
 =?us-ascii?Q?qOYU2FgO6tiNeB633Em2UorHaO68U/ogWyZ+NbD8ROuMKozzgEnVum5HYLqf?=
 =?us-ascii?Q?g7CT3p1GRw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80a9d76-191f-4472-3453-08de648f5597
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2026 08:19:51.1551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4eWE3chI8mkGkPjg2Uw3DWaxIv/4As9e141IfYcmL2WmJmeHr7EZgMeAJh7OHq6LFicmbUdF+/ZB10xu70dEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9595
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 04 February 2026 19:50
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v4 2/5] hw/arm/smmuv3-accel: Add viommu free helper
>=20
> On Wed, Feb 04, 2026 at 07:00:05PM +0000, Shameer Kolothum wrote:
> > Move viommu teardown into a helper function and use it from the last
> > device removal path. No functional change.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> Seems there is still only one caller by the end of the series..

Agree. This is based on one of Eric's comments on v3.  I am fine either way=
,
keeping it as a helper or folding it back if preferred.
=20
> Anyway,
>=20
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks,
Shameer

