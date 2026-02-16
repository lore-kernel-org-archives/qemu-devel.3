Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AE3E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 09:13:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrufE-0005Nk-UC; Mon, 16 Feb 2026 04:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vrufD-0005NW-Vu; Mon, 16 Feb 2026 04:13:08 -0500
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vrufC-0005T4-9B; Mon, 16 Feb 2026 04:13:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIpz0eQGAXqqM5yOo6ah+QkSWgOsR6dSKlQO+dFDEZ9RyC6tXBm8XfA4JDb6YG2Uh4Pu7nFJNEgNTZ5dZNBFm1hfWSgc16RWJeifNSO73Q/5eCTlqxNtieokaMxIWFL+67W1s/iOAmviViZoq3xY5RH2GCKJu6m0LeaVyMTIhJu+kERtHJ3Inz1Qd13E4FxJqeYhhjgmrB1iZE3rE+6up1iljo2xFyTplC2X6SKxAwXUMD+uvCgY0hD5DpJcY0FDNRw4WJoTMLEXQsN2+XXrU6sxD6BgN+Up+BxfBXNcORpQkv14svZHqASCFLrAOMDSGkDduAgqq2ZNARF32cOYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4RAyo1/moktCr8Ydt6QEbiJESzSlSeZ2RpJ4NK704w=;
 b=upzt9hd77TloylGSTWyHrstwvITK8jE+XpaPNnTbjp51+GsO/w+8g5orj5jrzB1lUS/6K/ooFGfxzlFml6avK2vz7swXAozztoYUr7qvKiVZn2jBEFz9BjKXhhMXRNjWIRHYOl5jacf+D/RQ5MtfLd64kxe3DfHm9WY6NqbTXDKl0OtYY1NiGG1C1+H6o/2VO/EQKowUJrCMn7Kau6hBRZauer011dh6JeuotLDHWGkgJyeIrZnCLvEj+UWVSYbahZ7maTsS46lAGpsSonldafHEmU1UHBjGvT8ERPGio6+t9f+9mbiGGhOlsU+fZhCCNaULpjdG9/qaaPl8Rs65bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4RAyo1/moktCr8Ydt6QEbiJESzSlSeZ2RpJ4NK704w=;
 b=pjhsZ3x1NI1JsmSXkFnDcA+XNbd+evygYi23Asnlg3I7k+cTyoQCrIKdzZ9Qlql08/EaEsXcsbcFqt3/SOkPzOm2o2ObqfMcUhliIN/CoPy6PkLCo6XM+japKmDsQ98mGVlTpMpiDI9YUxuQRMbd0/eeMVmRiUvkCPDx0S8SP+2LZq5GJrKJnzv5upCYzSjcYRz6rsgLLNYlvRgMMWBlMnCNnkltHb5DIE8vO0Hq80kw3fomR5lglL14HAD5B7RSgzQmCIdRxkFcdIJZFi3jsryzDZZpLYT8mOHt9l7zmV/ev2LtVBOpbScRxyElJ9IkZ4LU1JDS6cikJ7w0uoImAw==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by BY5PR12MB4259.namprd12.prod.outlook.com (2603:10b6:a03:202::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Mon, 16 Feb
 2026 09:13:00 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 09:13:00 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jiandi An
 <jan@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, Krishnakant Jaju
 <kjaju@nvidia.com>
Subject: RE: [PATCH v6 0/5] vEVENTQ support for accelerated SMMUv3 devices
Thread-Topic: [PATCH v6 0/5] vEVENTQ support for accelerated SMMUv3 devices
Thread-Index: AQHcnNWJbrAUCUyEs0yx/M1OvgwZx7WBN2qAgAPWCQA=
Date: Mon, 16 Feb 2026 09:13:00 +0000
Message-ID: <CH3PR12MB75483507A3A764ACD4B46AE8AB6CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <aY+mVQU2w1S3bc9p@nvidia.com>
In-Reply-To: <aY+mVQU2w1S3bc9p@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|BY5PR12MB4259:EE_
x-ms-office365-filtering-correlation-id: 90f03055-c51d-457a-6708-08de6d3b9511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?zqYHRXCydSxvRBzoCySCIglpfyP0lrqZb5/P5GklQ3UrmDBtMAUpEBZ7qmuf?=
 =?us-ascii?Q?aVRbsbK++5WztbZTnBQ9DdEDUSnLeHAj7CIrmkxtjtFJbbdJUfm45n161+vs?=
 =?us-ascii?Q?7GBv1DKW4HX/YNeM9M2nGFM/H9+J/Ic8MFDpIDtWvsNI3P+RrTm9cIv/DxK8?=
 =?us-ascii?Q?uhZbpD1HYXeq2hWB/+XGLzvaNAOjkXJJpR8WHFM/bhR+9eZBMlT+oWAdhZGs?=
 =?us-ascii?Q?hTF/U2sY1IAoQYKDlIKiU+mPakzU3PszawHPz9Q86+Z+rqDN2F+S91tSwMf6?=
 =?us-ascii?Q?dJNkXLDrQxT9EwvCmJdM7eV2PVHc6nXm4XBHHrUlKse5Z7QB0KLbx74eI+Wm?=
 =?us-ascii?Q?PMD1Q7yl6nxrJZm4IoqVSm3pN3Z6YXbBhUL1xU3ZeYN+mX2jS6NY/9YzbBOT?=
 =?us-ascii?Q?JGSAEIlB+rvN8NhidZMxnEzXjpv3K3nRqoecVMRWSBNA/YCAM/Hul6iYbVLA?=
 =?us-ascii?Q?9u5Ao0/QD+XUPLZscw9DfHbXwcwXy52XoIV2U9gS7g5xi9Gn7FqzrjEAJHXy?=
 =?us-ascii?Q?OZGB39g2Sl0YDq5SG5QSrpR0SBh09MeytPnGZhwpqqpr8xIGdO2aqpXieR1d?=
 =?us-ascii?Q?WsjO/tqFZbAUV0txjnh3hWpkbqCn8vTfEjzUzpsYN2lFaEz2eowXnARiJZ41?=
 =?us-ascii?Q?ReL9hLj/x+uP8nZ45vaaNxBb+85ua7oUDcRAWBw1cSChwoq7eZLf96vVHhbV?=
 =?us-ascii?Q?7jI69vOsOHjtLshqVPEMp33lrKvRDG8msU7uYv/loM2b8yBLKDmuZn2WP/2A?=
 =?us-ascii?Q?3CcC3uQuxD0Gjn89NIh4z/0zTcxJ3nWyBXVzJCb0XFB4nY4zQCBfL3Z7yncU?=
 =?us-ascii?Q?6dyvL3aKkz4VQaE4D9IgXFlxWdJRdTdCZRqlaYpp2ldQnkxWaPc6+aJER7FJ?=
 =?us-ascii?Q?EfbJIA6g5wnnu3irrpJgwLLnn4ys4bMzCe3JhnhAP03O/bpacGG/SpeSR5yO?=
 =?us-ascii?Q?Tv1OGsLNMAnR1bFUMHSTaoDoZTL6SBkFubG8A4FDab4gbHl6RsKrpjFUyBut?=
 =?us-ascii?Q?F4U/EeIeaiYExHKUpONcECs5yiHkmhH5Vr1ajupXQ8dkq6Sa0mBv+kFhVcAE?=
 =?us-ascii?Q?2MX5qnf/Q+loTVyZ9+xipdYJvjrq8bb1qvFgMwuagP7oVSXGjOfR5DPCYZgB?=
 =?us-ascii?Q?um9nzjC6FbfefljJJkrhTPEybVJDEypEKSpS/lbUmnvlEmBRX2LEd4g/Cfed?=
 =?us-ascii?Q?ZQYfUPjI4VK+hU18qN38AByxvZ5xh8SfOz6X1lO/uMCxJ4E0eEcQv2Enygfi?=
 =?us-ascii?Q?c2bgv5oDk+Qp+UR5Ww39t9ijSpHRsVLli0+gaKVYQUKUTpGbnA2inmF+ytmg?=
 =?us-ascii?Q?5eZ8rINYvB9lhIP+mqHdEi4pHW3YuMqOhjbfzzZaGOWii+mWG57Ck1r1bgGO?=
 =?us-ascii?Q?fF5SVa/vS51j0neBMCs1hIsJ3Bi1XcKVAMX+rwBttQkUFjjAPlqGCQVLKOmL?=
 =?us-ascii?Q?R13Cpd2eGLrPt8MGaS/VDpfzMRagb6tDYH1oPDowwlCIvFRDl9gmRDzmOGm9?=
 =?us-ascii?Q?fkulcuWSC+lelEhNXWzJ4YxfnFnlmGc9C09tAbmxDyfsyhwiBUaFz1xhtCLY?=
 =?us-ascii?Q?9yRTx9oosOOw3NCSlWeQUqzceoVVJvpICEfhK4KMd+AP12LG+ZBoVcFKYK6S?=
 =?us-ascii?Q?kS3p5o6/yq+PLQ6P5qgGtjg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?63b2+eb36LN6v7EfZfsTXUoM8VFmqLw6Ywlfj/bgqBv2SXWF+h9KSjH4tmlF?=
 =?us-ascii?Q?VrJzOA4KoBOk6askX816dC1JbFB5QG+8egAj5OEbvPb+p/vQitY8rFiIpATW?=
 =?us-ascii?Q?056rSxwyw84HK/dPLeDWqKL0Lf2iI0GzVNsEJDiigkqkBDVw3BTC8+lXknMo?=
 =?us-ascii?Q?YY5d3GRGGZyuv5cly7yjFPKMa+98nb0RjJKhMoC5mmiC92ppp+KWsLpcKDRM?=
 =?us-ascii?Q?NxR4g84/3pvEKqgqwWmT2H67qHkVRL7pZaf9rkeuKejWA6xqpVH+4lFzbyde?=
 =?us-ascii?Q?TKdqi9qvb5rJpNTCwBK7FdBf566/l32FEEUYIBF+/bkPjOppSemRbKBh1cTK?=
 =?us-ascii?Q?auAO5ISHExiGe/H4ltoLxSZQ9g9JcBwJSFWLXrgf+T6jls+E/jykI7A2hATY?=
 =?us-ascii?Q?VuU8YXv2ZsrAjgzh6snGx2HkuXKFx+po5c1DtyEZMHbqL/LoKsxQ7g52ayfS?=
 =?us-ascii?Q?aUUXsXX+YUhr6T71/lwPYryenFTggIFVIKjZMIxPPdnHhI0BDtWsIMW/WcGD?=
 =?us-ascii?Q?s42qS0e/nP7mTmUbBdcHGcuaCx6hhRze1g1f0FNeZfBctWAdS3rBXCdErKL4?=
 =?us-ascii?Q?h0q7dn9GtRfYJW3sfld5p7+kmSb0p9j4mloWQxApAxdCLJ2+cquewoshuRAS?=
 =?us-ascii?Q?DLPJPJjIlaQNfLqkvZF3rEyVuR0gJjht9GMGWVR/TrsYIiFWqJ/M79MmxCzs?=
 =?us-ascii?Q?eWCbYmAv3b6qC7p8DZ9V03Ex+dbfxpKuNHqs6AfOkqEv2fbLvxWaULPTU5CS?=
 =?us-ascii?Q?vnCuDzp4lhvsagDlxQy/6VQThGhqwtBl2QMFXMuMmvbdaM7lo45elCkqTOu/?=
 =?us-ascii?Q?LX7lwMyC4I3XtcIt9z9n4XReNf+V2b8zDa5EJr2ymlgb9Qy9Vypi1tXOYwxW?=
 =?us-ascii?Q?pyigDaPa197NMdgYSXYSOaZu6QF95SVYVuytWLzBKTwr2h9Yc0FB4t8HN7nS?=
 =?us-ascii?Q?C7gML++rXTRyBO5urp/iba2lU31rMC3v460RurGFeWv54teKtmFTZzn4h/5o?=
 =?us-ascii?Q?doNl3gzrm2PpWSt/deGhyeZnyWOl+QHNYyfGKnb5kNE7c1WBX/iQAgwXNWm5?=
 =?us-ascii?Q?yQFtq8/G79J8+qMqn/04uvNAH8PWbl8Urm+ziqeQ+CNE03i6llX8yyRnqZjg?=
 =?us-ascii?Q?4blH+Ogs7+c/a3qv8UH1dcIELEKV35eqF1gZZJPe1uNkXppIYFUIaVpdpcYG?=
 =?us-ascii?Q?X9vFwpxQ6bania0VrmMgGPLbByTHWSJb1HNWly7iHJReI9kIOBrxXbGh1hcj?=
 =?us-ascii?Q?Pc/sXsPlyjUwml7Rj1HxnaES1SwxsGoCJywdyZkRoQSATKEJ7fkE3P5JbK+3?=
 =?us-ascii?Q?f5skhjbSzs6inuiAV0JG+kg2kylbart7o5DuQoCpixwgHenmXezCcWPPWHqx?=
 =?us-ascii?Q?r7BoJ24Cl/Ch6PMIO6uVYqxJ6bbQLrpKNZ7mIH9bihWgvVWVIOzJlRXaGw02?=
 =?us-ascii?Q?DytiOG/PFGqubeOoAvaRZHlZCT3noqwPQHhTnMo93w9F/vDKfx+WpSn5RFEl?=
 =?us-ascii?Q?CzN+OSiOcMhj+ipE1sG+cNr0Zj2x2S7zNXcl8Ohpf1kw6Iy202g25RsQAWPT?=
 =?us-ascii?Q?TMoNMcdmnAuqA/twA0RVHDgKuTG5AdkaqQr9JFvVCt4UNQUwOH6SbNOVcAQ3?=
 =?us-ascii?Q?k4y6xPrRr6p/K5ncE7zj3qUD/kWxoaFOxAeGWa9RvE0ZJil7M0494/n4Q0Rn?=
 =?us-ascii?Q?MyKP+q5tVR7DDv2r0Ts+jjS3SI3wWolcx7vrpYsOWsbIAhSnYrcW8wUca9d7?=
 =?us-ascii?Q?nrHT6BbzQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f03055-c51d-457a-6708-08de6d3b9511
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 09:13:00.4304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drA5yWA1zD0w3WfjIWCgoxtniX7FZM+ciPoL0CWKewVajtQpjFU55PT7khtrYBY87BXutvsCKxi4nWjyY0ECyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4259
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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
> Sent: 13 February 2026 22:32
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v6 0/5] vEVENTQ support for accelerated SMMUv3
> devices
>=20
> On Fri, Feb 13, 2026 at 10:39:37AM +0000, Shameer Kolothum wrote:
> > Hi,
> >
> > Changes from v5:
> >  https://lore.kernel.org/qemu-devel/20260211083415.133534-1-
> skolothumtho@nvidia.com/
> >
> >  -Addressed feedback and picked up tags. Thanks!
> >  -Decoupled alloc_veventq on smmuv3_cmdq_consume() (patch  #3)
> >  -Updated error messages (patch #5)
>=20
> I tested by hacking away the RMR nodes and msi_gpa to trigger some
> translation faults at MSI doorbell.
>=20
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks. I also tested, modifying  STE0_S1CDMAX to trigger BAD_CD ones.

Shameer


