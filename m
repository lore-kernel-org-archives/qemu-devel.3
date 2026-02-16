Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43E5AE63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruQz-0001z4-3R; Mon, 16 Feb 2026 03:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vruQx-0001yS-1G; Mon, 16 Feb 2026 03:58:23 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vruQs-0003TT-8m; Mon, 16 Feb 2026 03:58:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuUzxRGgGWXvA7yBcCJ8vmYmYCzBRFRVvpNXtJ6ocB+W1LmQHnfiPQRiIpytS1KxvmBCwBXNBx9Ybu5e53RXouiQ1Q8iEDc70LlsqFko6qW58v7n1YgU4Mg/BRLNyJQHnjdDxw70XIdH0BowOzg61QG8Kh0C1J09ysn1CgZaneVdhe8RcsQ6j9/YEA5du1rb6YkvLz+o/zVShuzTe8buA7QWS+hgkDg4XHL1VaWwmX5kKE19xwo0qpJoQD66kHNZG75/df5ksXXEzZlztO/LGpdGKt60MS0tDax2zxz4MVsbXAe9wJHPUZH1Pv+NCiZ+Sh75AswYAoMMbicQBjxjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9o9+KIRoY2tW/Qz5Wtd7he4dGzhBNNX8rje3h8cTWA=;
 b=aKXR78HMqiNOWxm+lEtGPfCtLMsEmCMRNHIdbkwMPWAX/jwmytpWrL0yPAax5rmqNsTU+R9hl9McDL+xkJOUVviMd5X3aso4HHRqxq8msg10y0VkZ7ee4iDGfWmw1urDinpKTC+/N1EB1CPWy6dWnf4ivFndF4fCSfD7b1/lDH+1fzuXE830y/4c23pm59KDbva9EV+k1BR9STYpLqpgUEXoGiCYzZyg0hqYlYj1Wec9drj+h1BAfi/FTAbbAuKlySrootMU2tv6hq8j4vDu6HMUbbSc+bcXwMbY+cuQYB0ruuP2UcmMj5d9jAiINExlXPn+zFiixDNKdEVZ80cqBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9o9+KIRoY2tW/Qz5Wtd7he4dGzhBNNX8rje3h8cTWA=;
 b=REOandsnPNm/KFjQokQdacexWBKQdainAT/88Qdl+/A5b3uM9t1eHQhEtbqmjaD9HRJz3Y5kLGyC7fJemwaGP15w+AXhlt/nOXGHUSBiH/cdDQk2hOBjh6a2DKf3+QBTPCJE1J0qh+3eeaVVQv7W1gPr884GygK1JYkTxg8iGJBBlCEzOkDtNix9c9tHm/Rgb9TSsEyvM2sA4b7E8fxhzUqKrMPzSixmN+CRDLtExnNKVXvrio2vvALXgW9gRokoYXz4zRz7d5YO6pFm2lK9B7S0v0KOQGhXr89sIgm66UaRPbx64UtnHe6X8D8ENA2QNHJuUVf9g0IliWfALrl14Q==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 08:58:12 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9611.013; Mon, 16 Feb 2026
 08:58:12 +0000
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
Subject: RE: [PATCH v6 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Topic: [PATCH v6 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Thread-Index: AQHcnNWSbJbcjBWJW0qjaUXjPQ/BMLWBM9eAgAPVAgA=
Date: Mon, 16 Feb 2026 08:58:12 +0000
Message-ID: <CH3PR12MB754850BF9EFF16CEF6130ED8AB6CA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260213103942.142823-1-skolothumtho@nvidia.com>
 <20260213103942.142823-4-skolothumtho@nvidia.com>
 <aY+jVfUUTawwPN+f@nvidia.com>
In-Reply-To: <aY+jVfUUTawwPN+f@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA1PR12MB8642:EE_
x-ms-office365-filtering-correlation-id: 2ad587b4-3742-4339-b99f-08de6d3983cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?MUMBxnZbmcpLk+pxUAV550oFobG8LdgraNV+xF0kKZumOObsxYMAImEROUdY?=
 =?us-ascii?Q?Jt9MFndCxTnSJy3N8RRt5pKzbFGlMCvatxSjOydDKBSgsaW2MOHbdyWOwx/W?=
 =?us-ascii?Q?69tpUdyo9wR7JVQh3i+i9YeLfaJf8FdcgFMbHY9WddWbAVKfRV+Q1QsjN07l?=
 =?us-ascii?Q?dwdmO+nUqHFZXS6LOH2D8/Vhmm7gq6K3iKkElIoEUKDRCCyXBqjYfKyHGxsg?=
 =?us-ascii?Q?J3XVShGqMu967pdJ1u7peZY29TL2aD4STG5DB4ekuybvbOFVCcT/w5hmNvcS?=
 =?us-ascii?Q?MxfpEZGnHshSFLHJ/euUo5/Vp5o3+J78kA64G3D9kjK5xfGTs6oWAZpHsqgZ?=
 =?us-ascii?Q?Kv0XQkUb/V93+3mcwp6jWGHs+ICI8/sDgE5HpOz3rD5uQrAyq/MNzT/+Zevp?=
 =?us-ascii?Q?4Ke1QjHQ/QSFoYFdXWupiO3sfdJr7cKC7N1aePMgZG78aqrEsQqQwp4nVVNQ?=
 =?us-ascii?Q?Q5VnmczjhaqLwYmH7S692VxtG8YPrzC5vR1VRmh9jnyToLVdvUY+eSQp1QAG?=
 =?us-ascii?Q?5F0cENHl6joLmo/cY7HoQeDP6Cuii+miyBUhpf1YXxHTG0bC6R6ysIHQArPt?=
 =?us-ascii?Q?wpVDAIRjbdQ039JB0O4Rh+sNd0lVJvyI8tbjSrOK0NGnRXOTlj64I6uGew0v?=
 =?us-ascii?Q?BLfW5A1sfFYl5r6whLOn7GGWeTPj7oQpcpBlBl5bR8oM2+J/aYlJiItFxv/T?=
 =?us-ascii?Q?K2baI9QqB48VcXeeh5aCxZj3xNhNPaeWfJ+j0DYIMtCVG+G7R0CSyExn41yz?=
 =?us-ascii?Q?K5JZxCIn40nReY4+M5Shit1XPEsNVBdGCPWTin+T6Wl1JpXKmoT+o1UYFY6t?=
 =?us-ascii?Q?QmG1Ocf+kM0DF/1oDruBB5O8hEAnoux9y6b9oHVnhLs3YtzlZqFKO1VaZMBl?=
 =?us-ascii?Q?AJfMVSgMkZ7vUdaZG7XSaY3PustJ30Np8tl30fvLVjR5FaeLAV+AhHmYNhCw?=
 =?us-ascii?Q?PYsets1z/DWQU2jWnAhsdxIgEpzF/V9eWakimFlXg6zShizIkMdCpOSHDZdB?=
 =?us-ascii?Q?Hspk6V0CcmvKImPciWfYTcvsEoJ5KOyLDo9ldB+hR6FGAg898IOYwaFwNnNC?=
 =?us-ascii?Q?Eis0AkKk7sTYUwIimzXMu9F7syj+OCCyBmJfUUEXccdEEh2XJpu0MGV/OQi3?=
 =?us-ascii?Q?y4T+Zk4C1Aksn4CTel2DvsY1OFbrNyt/0t1JcWczhdwk0fL6beas7AY6BmNF?=
 =?us-ascii?Q?MxTxftNLD3MzHS2F0NyzBPj+AT/wzqCuzuyxPGACgOj5ovLpsGwWxY9uwWO1?=
 =?us-ascii?Q?e2Eiq5VzgU5eHXIb00UCGoEYQkNt/H7YA9za4nOU+8rSOJqpKdzZ6Wvr0xXV?=
 =?us-ascii?Q?QvaWYOA1l8anJ8+Twpnhim6D9jzHAwhGepxH2CGPS2fvqpQSKKyumgKCKAvY?=
 =?us-ascii?Q?GD6kpEv8KVS8NvH5FpI77PW1n7Ajf3CRR7/xXXaEiwUJ6atdCLNQDSvN8Vnu?=
 =?us-ascii?Q?sffwAN2T3vUhxADo3jYtMDhMXUYHMQ+gP9QbuC/ZSEFNw2YXdjKO38mMLubb?=
 =?us-ascii?Q?MuqKfPBOKt8aZah7jIcoKVIrIr3h/CC9MBENHo4ZxIjqJYCGTwlhgvWyFa2P?=
 =?us-ascii?Q?kMLhuMosFXxj2nqvtQyV7CB44sy8shROBdB4qWwa+LrKCVAWRV/qzkNJTIm+?=
 =?us-ascii?Q?fzCEEly19y7+pboH7ub2/rg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mkOQBlXaSLrx9SHAJwN5ggvJZzThNn7cz1mQhXe7dOwI8Ij+sP86JTyOaiKc?=
 =?us-ascii?Q?UqZ0MVhCncrpe67kqLNSg7ysB9xf5g6S09Br0uT9rw8o+K5yURq5xSwrJ6I2?=
 =?us-ascii?Q?KJKdEl8lMDUuZgXTyAosuRD3ba0TPWEYH+HleZXvo9DnifTbt8v6aN9mJNcg?=
 =?us-ascii?Q?N5Db4y0A6ONAufIqxUdAkfOQtgS003OOfhhV60McGEkqgSww4/DEX7HNIilz?=
 =?us-ascii?Q?qmFHMCN1IrxeFOy4CDsealj8+L4ISqUfQEIM4e21jQZeD/DHTtuqJYZD0aoW?=
 =?us-ascii?Q?iJYFXs06LM6ECpofSX3G3wtV41ELZF3puzqU/ax+zaAmzbUvveOhHCdVtEAj?=
 =?us-ascii?Q?RkEaR6PiIj5yfBpshVFmJkalbJEnPqDLWqLgVRP3sP+wHJ7Rae0uLupN5xf0?=
 =?us-ascii?Q?GG2Edifyrw0kKNvJkSGJyQTiAQua7v5NjkBavLk7q3w9kw58Qs+fnuii84aV?=
 =?us-ascii?Q?9dnp6dyuGplCai1w6+tb8vf7YQ8J57otCt3wBJwb1Lr+gSIQRx/wilXH7Q+I?=
 =?us-ascii?Q?q4zU5zlgpJeJuwHzu1nQjQf7Gf262IafshM5U1qWjqNXTQ1W96+PIfsQxZPR?=
 =?us-ascii?Q?QOuCG1o8USotOoZbMCnDr0WWhPAOZoPQB1VJtLLyvk5urjmbf8Fb1JyTpadp?=
 =?us-ascii?Q?UujqMuW+I5H+RlKeYGIrr1L79iZbyY/A15K8GBRVBy0zRfWQF28j2KE4qWx6?=
 =?us-ascii?Q?BKSQrxy3LDMpW9qO8C8A5GL6iWe6ofpCwCUBwoSi5b1T456XgUlkT44vaa2K?=
 =?us-ascii?Q?xi1cT9S6AUxoNxaY0dIPVInualg0aQQhyKVvOcgBDNXPn+ZTav5JWlKklx7K?=
 =?us-ascii?Q?bQDStNeZpRfKgL6H59AAgQafugC5iEs26MRTMF0B1Y+wMTUWYfbLZQouHvTx?=
 =?us-ascii?Q?6PaJhjAx1o9P0INDGo84tX3uD2dqT3njltmtLrZSmkpcFhQqsfKc0QTp0xmI?=
 =?us-ascii?Q?oCE7B3o+RQzhzwR31A6920uLtC1Uak0E96HqPKr7qdOS5q6h6iVLLyzCKTz+?=
 =?us-ascii?Q?OZnPorTdgP6gkWFso4E5NkJToj+N8M/OF6DkYqWiIJxojX0ZGgj/8JML+9Pl?=
 =?us-ascii?Q?vje4Y5HMHL9VsHSSnZyQ3oTXi3gWQwgaVfHfMiH3tyjfR4mjwe606mLyuWjN?=
 =?us-ascii?Q?Uj5OMOgyLl5ggJrLKiKOzo3prXA+AM/N7yrE6bFZYmbccVpOwh00il8Cu0QC?=
 =?us-ascii?Q?0KN7tRk0AHzt4OxZygWNIjZgO7HG0ylT8iiep5AYdmY1+m8952tUrE/DuQFM?=
 =?us-ascii?Q?25fX14T5qhMyXiP2gl2PM/4C9I/A+S9N7M90bzaljnZPRHxKz+05wMmqhJQy?=
 =?us-ascii?Q?DAfYxYnn2S+0KKTgDhtufJDwbAJkUgDLTHZsRlTIdnOH6hwsdKSjjSLyVrAp?=
 =?us-ascii?Q?UKP5nXv5VHeyCbx41nnc8jfFz7CsEpdIr8/v5Hdr8IRfsit8y5Po/7dSDsIc?=
 =?us-ascii?Q?utG78+5QWuLHIKVWoOk1Hi6g7f4DmnM9l9yYUtMWfJAFHNSoIX2OGstwfBR5?=
 =?us-ascii?Q?DuAb6D/DGq7fgrkhoD3uxhbaGhmJxSC6vdnSt86bT1/GtOeZqEvBd9L7B5XP?=
 =?us-ascii?Q?FUN5TKEhWzAkKihGJ1qInx6tiIlhubIikuP2HJLaArEE82DQSWzsfanp+uMA?=
 =?us-ascii?Q?5A15vq0qL6E0SI0MJyZoJ3qpjUcDtIzg6hA16DpZhokY1m1362rqJ7U8Jxqq?=
 =?us-ascii?Q?08jfiS4pLULIFyjClIjSxr6yCYK/3vnHZqm40MPGOFCVqt2YtLPBClWujjNM?=
 =?us-ascii?Q?rgOjx8sCsQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad587b4-3742-4339-b99f-08de6d3983cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2026 08:58:12.4722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIeyt1O4AN1HmFrZyGwI5JLmEdf3ABdObX3SjquwDOBcexBKvO7+LDiLmGdXjCZH0DoL71P4boOP8sB5ou79VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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
> Sent: 13 February 2026 22:19
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; peter.maydell@linaro.org; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jiandi An
> <jan@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>;
> jonathan.cameron@huawei.com; zhangfei.gao@linaro.org;
> zhenzhong.duan@intel.com; Krishnakant Jaju <kjaju@nvidia.com>
> Subject: Re: [PATCH v6 3/5] hw/arm/smmuv3-accel: Allocate vEVENTQ for
> accelerated SMMUv3 devices
>=20
> On Fri, Feb 13, 2026 at 10:39:40AM +0000, Shameer Kolothum wrote:
> >  static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
> >                                 uint64_t data, MemTxAttrs attrs)  {
> > -    Error *local_err =3D NULL;
> > +    Error *err =3D NULL, *local_err =3D NULL;
> >
> >      switch (offset) {
> >      case A_CR0:
> >          s->cr[0] =3D data;
> >          s->cr0ack =3D data & ~SMMU_CR0_RESERVED;
> >          /* in case the command queue has been enabled */
> > -        smmuv3_cmdq_consume(s, &local_err);
> > +        smmuv3_cmdq_consume(s, &err);
> > +        /* Allocate vEVENTQ if EVENTQ is enabled and a vIOMMU is avail=
able
> */
> > +        smmuv3_accel_alloc_veventq(s, &local_err);
> > +        error_propagate(&err, local_err);
>=20
> It would be cleaner to have:
>=20
>      Error *local_err2 =3D NULL;
>      Error *local_err =3D NULL;

Yeah. I had a bit of back and forth on this. My thinking was to use err as
an accumulating error pointer in case additional error paths are added
later, with local_err_x used for intermediate calls.

Either way is fine I guess for now.

Thanks,
Shameer


