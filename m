Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29E0E81A5D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 17:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs2lf-00017U-Jy; Mon, 16 Feb 2026 12:52:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vs2lc-00017C-V2; Mon, 16 Feb 2026 12:52:16 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vs2lb-0000MT-58; Mon, 16 Feb 2026 12:52:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UgbNK1h5CQxggmA42HTiW9Neag9yZOlQ9p2RHrW2mVbh7xNQ8AxZDewckn/R3WNwcEqiaQ0Md/lDH0NGPmm79diU+wQu2JA9kyThrdLzky6ZBjmVISJtC6kfF39k9sC90x2O9iP2MwR4hGm6vHtEQM29sULTKY11x7gwhWm7RdHAECwKYYyvAedl+Dzlg2igfdC1xytWmiy+bg6ddwuVoQ/AXpTCntH/UanJBhlVN3hSXgzXRuxgg+m8UGjATOm1JUR2/G2ltchJoMZgrTHZH+mtGTw3ZjDcNJBMgfnRBQ/7fK7ShwTiD5bFuBWo5uz1CJdZm5kxlCE0wZgRfwv1AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X3iIE7BMNePgWHw6YANtrrduBjvdkaUk5CqUWvc8IU=;
 b=bMGxYLwf4K+kVrx/JoM/NGh3trEe1V5L43qHUUmfPsimuxR2K34hIXD+yUb4kf43M2ho+4BJqZi++Fmnjc+KxmHTCUQN76CkeOG0Zw1/cQrFCPD5KAS9WHwZJE21m8vhIjhjVoegWG5Z/y9LiKsmPQBGpAkXqgmfXjRx/X+4G8noQKk+aUtxgMnhsrQK48DjcWwuORDhGQB9Uy/LC22mQfNxZFMSthAPwN3Jfga25pN5CbiR+oEo3ZJPN2xGGrOJC+sSsCb348o+XUSTk+EJMy/LYgZ+IfJrXbgK/Yh8i5BTCoWm2yir7BH5hj9TXCBziI5ejA3DVp8+YXP/2voXIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X3iIE7BMNePgWHw6YANtrrduBjvdkaUk5CqUWvc8IU=;
 b=M+Ok4s/n+HsYUuZMYJX/mlFERKOkJXuLT/PAj52Cr6ekZa9DKIJ2tP57AIlfAZ9d9I03GRfnM5l6S5GDfsbseQYMf81/27smfEF7aaK1Tgo2+M+1lL9DAHeMORrsEEDqOQlmuFtpTWpLbGU41W3Qj0dyP5ZRmtVb5cv1aEXP+uQN5svHFI7Ox5mgya6MzzVCvsFTvNqNXNLsEdB6bozSfOLb6hUKFtvIwEAVfEr6Vi+b2FPqASRF8N4O1x2krxqo5MXytDwhGRLPJmcUpLKBO1VxFvLNDHgYiG4X01OyAEE5kmawpABYRP4M8VJf2wyyJTgZXdiwJDV0NFMgbkf1sA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Mon, 16 Feb
 2026 17:52:06 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 17:52:06 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v6 4/5] hw/arm/smmuv3: Introduce a helper function for
 event propagation
Thread-Topic: [PATCH v6 4/5] hw/arm/smmuv3: Introduce a helper function for
 event propagation
Thread-Index: AQHcnNWS1+wV1r5od0inPr/1EQLQHbWFiV4AgAAQUlA=
Date: Mon, 16 Feb 2026 17:52:06 +0000
Message-ID: <CH3PR12MB7548C59FD3DC795B732A9E4DAB6CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <20260213103942.142823-5-skolothumtho@nvidia.com>
 <20260216163010.00007797@huawei.com>
In-Reply-To: <20260216163010.00007797@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BY5PR12MB4260:EE_
x-ms-office365-filtering-correlation-id: 7802f8b5-f772-487c-2a7f-08de6d84199e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?S3z46P+KA9xYmW0wfuSVtp3Jf9hJg1Mky+7yEJRYcsCvIU4XA7ltwF0O4jzf?=
 =?us-ascii?Q?+ZuPgaN2keDnsfRrCYSeJfrjM1S/AaEFrMBQ4EJXGHwl84MNWdxAg1vgKrxn?=
 =?us-ascii?Q?pV+RYp9DeWKxdKynQgNEgu4dYCOe7ivkJyOUg4jVZSkjlNlSmkJ7MUerGK2P?=
 =?us-ascii?Q?ElqmTD8JnUvQ0iDlk/TkH5wm6TN5dR+CvEU4qj8GItYiyd3sw+UcgUSlOr4A?=
 =?us-ascii?Q?LDcXRs3v8WkOXhQGRNCqBuWKgqprHtn/wk/YkD34zRn1gHzOhuNLKPKCRx1q?=
 =?us-ascii?Q?GwK5074eDd54E8YzFeCn2m9dkPln19iKTH+cCqFcaTksPr9HQLgKryAGU4yu?=
 =?us-ascii?Q?8qQQYqLFN7lAw6YuWKFOnwDKCFh0DHAA5r+V1wkmDQRZj5Zi5kyLsBryDKWa?=
 =?us-ascii?Q?+hbkk4GnhQTNa2gozCMtFAnkERKyhLk3m0Pi69TkLpr68C6T9bZ5F2OQuSSX?=
 =?us-ascii?Q?Ki2FEdRqMDnGZIs8nQWEDrYF+NM4aAYd2l8rUGpGIOKpG3e5mMLUI3+DNnrU?=
 =?us-ascii?Q?YsVxZBzaek5kP2JtH4wgD/aKLrBZL5V2WLsX4AxS9D2rdhRtS+EHpnZW8eLE?=
 =?us-ascii?Q?H+43yFZLohXgIE0d0I9kynnhJmhre3vl+AYhYRMAPtUpdgC9lLghEoqhzfr6?=
 =?us-ascii?Q?qTMZpmSVqD/S+0FavryIAWReCi0UxICZ79lAeved1CYMdk8x+3KK3xOVB1Sp?=
 =?us-ascii?Q?tSTqDQMMailA0YmFV4A3EcuCDQ8AK4/8I/lJaghzToXps2SkFvZCkXqOJdpm?=
 =?us-ascii?Q?s7EMj31jvOqlNe5GO1n04UOfutR62EboF8yzCd6hdLDtRSWnaPhM0NzosyKD?=
 =?us-ascii?Q?NMM2Rzdk2dM/RGMCVZbKYbm3M2mgNC0iqnRF3B0PQQzLLIc0jbIfeMJLXGG/?=
 =?us-ascii?Q?Ph4KGBoQg7IQU6AmoVzqPRQqZzpdnQuanjJbMXlEzLkiGOohf3sNa0KBglbi?=
 =?us-ascii?Q?JbCzCvARKqVKCDzbKFsTyt3T8oIlQ02yvB8BqpbvW7ElEHHCCxh7HXiaCuqh?=
 =?us-ascii?Q?/K88fwj0V+t76ILmOwAWfogMAVzKzZMd6OODXYQ50Qlnx9n1zKSGoK4Vx8jW?=
 =?us-ascii?Q?ReJfhwZcY1rF1SxCHQwKqfsr66D+FSFLDPIOwP5l9bGSl3UjmVXmPNjqVhlz?=
 =?us-ascii?Q?nCRM9SVppc/iVq4+qkRjQ4EsnzeICUByMqO9uli8VjX7eEAsoTVgE6xbWP+5?=
 =?us-ascii?Q?GWjXmaH4ntzYjx/5aRZIpNkMXEswEgyJiqklHD9mtEEh4STy08I4NbuL9QuR?=
 =?us-ascii?Q?2aOmHcBRWNgbxjKRNEfPt7c8ghJ/YID2XAGclcbMzZ0Z0ssCwQ80nWxq/l2A?=
 =?us-ascii?Q?NHLUHVG+GhWN61Sse/rD8CUVdcLL9HEP9GtfAm2N5IOCryDE6dRFLapCUpBl?=
 =?us-ascii?Q?1PckhNbbOsI8G0weSW8VmLdcOViSRjWOESlO1tS6YEFCnD5LyV2gX/ZfF8y1?=
 =?us-ascii?Q?BHIYsbT5Xur24eGscvxqT22eCGcb4as5jnark8wf6HIrRFXMnPdWvjEYJ9aN?=
 =?us-ascii?Q?HIxh2ualia+1eOK/eZSk40Zp5SxZLIvO0NAVl97XAckqSmTDh0V0KRRCKAyy?=
 =?us-ascii?Q?+pwaK6DLQv+kAf8OztU/N1Oe5uBkh41aWhPlspHd93l/xQWuc4OrHSZxChJm?=
 =?us-ascii?Q?Kk/c2M/ohn9F0qLQmpJqCnk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gdXkVpr+e6SZFvCcgEr5b4+nOBxY5QzDyUo1t/BJYwUbAj5BI8iCHWcnFk9O?=
 =?us-ascii?Q?E7ea6HzeXECmPKRSd7eo6S0Cu9OrnmCIlucsWzPC3eA3Pkj72fWAT5wbaS+i?=
 =?us-ascii?Q?T0xe5q7Yp0v/MR2MWFigJju3qM9L3CQ46YIbpptPoIw+CNUFiqZw4ehtNhw6?=
 =?us-ascii?Q?3WgGje1hVSOMeBL8VGrK/mPF+lYhcvzpcaKBDKkB9wuuLbI48sGxEMgbN/yv?=
 =?us-ascii?Q?fYOnJB+pWhfaFDK1CsQBq0xq8A0W0VRsthMMbDXmwUdsyWe/+q3IHj48ehzs?=
 =?us-ascii?Q?EQVxIvVcZ/Ol8JRk5Yl8y44aGQpMwHpbtVVpG6SXcZ+SVXb3QSxOEYBVgS4t?=
 =?us-ascii?Q?jc+CmEhvGfIUryx/kQdjfIXpBDq2j5CGQZuxhqskgtGWEomK4S2JBIjDf0H7?=
 =?us-ascii?Q?RZC3Ca6G+N8CnGkN3RLs5QCAfbpl0hcysaA7Q9z8bHNkhvNFAfFuIxFvUW9C?=
 =?us-ascii?Q?34dX7+pbOR118DOWbbVWcVwu7dONyx/xgMwKb9pKMa3SgYB7oeTzdTFfPTB4?=
 =?us-ascii?Q?tw18B8cF7YeAjZOCLFOyDcMVcHYcuoA5ULb8iElV6FoSGilDN2Df0KsZKj95?=
 =?us-ascii?Q?7hscOQDs6bOPnpEU4DkxwzLSOdeOiI+veUSTYpdkS1QJBxGO60Sc0HQXQalv?=
 =?us-ascii?Q?FWS+eWDW53yEekQuCX49ufpy1xiYbbTwWx2BHcZdVXPf5IpKfqVy3zOho8gc?=
 =?us-ascii?Q?2VHTi/IC33fbQike2hwh2famq56NnMQzAdrQ6nsy3C0pmMpBMtlu+0XEtlx8?=
 =?us-ascii?Q?H7Al8VeMDv3td2OlkDbUgfHZnckhUGMoASzctwoyXc2/OMaK0mD81KmYbro6?=
 =?us-ascii?Q?6w7zRX/Y/MfbMNGOIE9fe4E/OW1DW8OBs8G5L988M3K33MZWC7IYXVWx4Q2m?=
 =?us-ascii?Q?7dfuYOKjGLpLXxE+uAtUGJNZ8n400BIFCP9JdQLDbWaSi8QzYGuf38aPJzTT?=
 =?us-ascii?Q?c2Dw8hNPDfD/kfHF2jZYznPpOCvkV3PKmdPX28eLb8ViACwUrDS38LnoUxOf?=
 =?us-ascii?Q?Gvq9px/bTv8FJRCSszCteParnxAAtnR3YlSL15B9BAkJlFaR31j5IEXRIdIE?=
 =?us-ascii?Q?RFgmgZoB7h255jLeSO2gk6UpknGC1oiThoTbjEckLaggCN/D95vpYW1JPFzx?=
 =?us-ascii?Q?PFLzOnwbDOysKeqYiq3I6CG0xZ0OiV3v+rQRMnNb77wt1+Wf982JzQ0PiVmL?=
 =?us-ascii?Q?Dt0OmBlwHSWQcPlmiAYqTIjKT8HuLau9m5XtmIYPdxbhbM5hO4q7eiAuPK0K?=
 =?us-ascii?Q?AhJ0fCmlqvopr9ScIBYRd2W7N44tbxHjdBfz0xW3t+kutajwFggqxV3+dXYs?=
 =?us-ascii?Q?Id1B9La6gNqazUcLFr7aDllHKNc3yvOazxK+frLtvwaFuHwDMM+h/ipdzcm9?=
 =?us-ascii?Q?DAIEPX5vzdRfrrb2k6Hvn48y20PlG9+Z+8a8DYrrVMKixOa4NtBH5LByU7Hg?=
 =?us-ascii?Q?AbTq1/n5B9G95w5joGEofbcHUjBbaVDIH7dGYr5YZJTL0NoRWTwTlFd4rNuY?=
 =?us-ascii?Q?4WiLPJ0KPq29Z/+0DHF1R6rxYJs4ycD6TXkdwtCyXpMlp8KKdw7LaqlF2iwR?=
 =?us-ascii?Q?628FauYyctkHGPUydIT10NCJsXD0mzOhHXdPPu8KlCEy+fKrXi0NbPA6oCBF?=
 =?us-ascii?Q?JGXiRTlMrwc7HIxATrVDtnaayVirX9NiO3zYtzEl/TPCSZjy//oRZRUvx5y7?=
 =?us-ascii?Q?3FONedohtfp8aBXDOkJszC3zyjB8pg5jTbOt5qHOjAsyxMi0cKiSYiEIgsW5?=
 =?us-ascii?Q?xbVK50jOHA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7802f8b5-f772-487c-2a7f-08de6d84199e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 17:52:06.5964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxXqk9u6hYnuX4Y1SXqORCAPOFIuESnUqkxrW4d4Zdh9bhJqZgOpqKageU0hoL/iDutzzRSSUejtSuIt9fSDBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 16 February 2026 16:30
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; zhangfei.gao@linaro.org; zhenzhong.duan@intel.com;
> Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v6 4/5] hw/arm/smmuv3: Introduce a helper function fo=
r
> event propagation
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 13 Feb 2026 10:39:41 +0000
> Shameer Kolothum <skolothumtho@nvidia.com> wrote:
>=20
> > Factor out the code that propagates event records to the guest into a
> > helper function. The accelerated SMMUv3 path can use this to propagate
> > host events in a subsequent patch.
> >
> > Since this helper may be called from outside the SMMUv3 core, take the
> > mutex before accessing the Event Queue.
>=20
> Totally trivial but it might be worth stating that / why it is harmless
> (or indeed necessary?) to take the lock in existing paths. I was kind
> of expecting to see locked helper wrapping an unlocked version that was
> used to replace the original code.  So guess I'm missing something.

Until now, event propagation happens only via the
 smmuv3_translate()
  smmuv3_record_event()
 =20
path, which does not take any explicit lock.

In a subsequent patch, this helper will also be called from the
smmuv3_accel_event_read() path, which may run concurrently due
to host SMMUv3 event notifications. Hence the lock here.

Since both callers need serialized access to the Event Queue, don't
think we need a separate unlocked version.

I will clarify this in the commit message.

Thanks,
Shameer

> >
> > No functional change intended.
> >
> > Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > ---
> >  hw/arm/smmuv3-internal.h |  4 ++++
> >  hw/arm/smmuv3.c          | 21 +++++++++++++++------
> >  hw/arm/trace-events      |  2 +-
> >  3 files changed, 20 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> > index a6464425ec..b666109ad9 100644
> > --- a/hw/arm/smmuv3-internal.h
> > +++ b/hw/arm/smmuv3-internal.h
> > @@ -352,7 +352,11 @@ typedef struct SMMUEventInfo {
> >              (x)->word[6] =3D (uint32_t)(addr & 0xffffffff); \
> >      } while (0)
> >
> > +#define EVT_GET_TYPE(x)  extract32((x)->word[0], 0, 8)
> > +#define EVT_GET_SID(x)   ((x)->word[1])
> > +
> >  void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *event);
> > +void smmuv3_propagate_event(SMMUv3State *s, Evt *evt);
> >  int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> SMMUEventInfo *event);
> >
> >  static inline int oas2bits(int oas_field)
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index f804d3af25..bcb9176c51 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -168,10 +168,23 @@ static MemTxResult
> smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
> >      return MEMTX_OK;
> >  }
> >
> > +void smmuv3_propagate_event(SMMUv3State *s, Evt *evt)
> > +{
> > +    MemTxResult r;
> > +
> > +
> trace_smmuv3_propagate_event(smmu_event_string(EVT_GET_TYPE(evt)),
> > +                                 EVT_GET_SID(evt));
> > +    qemu_mutex_lock(&s->mutex);
>=20
> Could use
>     QEMU_LOCK_GUARD(&s->mutex);
>=20
> though gain is minor so feel free to not do so.
>=20
> > +    r =3D smmuv3_write_eventq(s, evt);
> > +    if (r !=3D MEMTX_OK) {
> > +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR,
> R_GERROR_EVENTQ_ABT_ERR_MASK);
> > +    }
> > +    qemu_mutex_unlock(&s->mutex);
> > +}
>=20


