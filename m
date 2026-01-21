Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8495CC44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 08:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viTVy-00064Z-9V; Wed, 21 Jan 2026 03:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viTVp-00060U-4k; Wed, 21 Jan 2026 03:24:26 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1viTVn-0001W2-Nm; Wed, 21 Jan 2026 03:24:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtTX1NgG1+eODRP2MIFYKnEEOXrAy2OeN5cRcb9TdO/kCakMEXUrINtmVCNC6HReMx5vjYEv3O59ee6Pw0iflJWlmOC37/3CIBe3lBbf3wjPio9kpTjAGx9QlI+yM3iO23yZCQv1k3486sKBmP/u7cdKT/NZrcHJgT2fh0+NmDcBqCNaU+fptMPvhEfd5QdDbsj4nub4KNTnk8oVp7+vwZtRszUrJb3OQDAUKlFCySB7ixSnhJHr57XYo0Mxr5SkSI89Whs9zut4nHUolaikfMqDvbDSpxmNEZXQognldVSmrH9qBjVSC4uvH1WB5xFwseWzljKqRecfK0tjvEQkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1MBe90dcbzRFffVA4I5JLd973s6l8Aqqt6sOvMejxE=;
 b=m6TzQH+YecdR9Mi6NlnTyGZJFKQ5+7NZEn9vQXufHhcTDSCItq4U+P60xyFUjyM7ezZw1YTxwxfspVFO/PrKwfgOGMIrmFPiYEFCqkNcp/AtMRkVOJKE4bz5RAdkosTnxYhpLi7f+1Gm08THDqzAEnLFSVuL6iBSATJ/6eAt8pivBq991vHcIyk5TAH4WUCxfkgZ3QfjANtPo/xdTrjcwcJMO/1c1wSiuuwndlv3+3RvkkWj2RplB6oRWSEPTaFWoFSD7vtRDtJUKjWVv94n8l5hho7vDsS7SE5zgjx2iJWMans+AEi47p4CBZMXZGUg4OWWcVaCGZEQde4BQ9TejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1MBe90dcbzRFffVA4I5JLd973s6l8Aqqt6sOvMejxE=;
 b=QMMkivEIfwD5UP1un90dGfFGxJqwswBlUi56re6BjF9WBjPo9UDtEQPbAS8g6xPjZ85TfsAALxVBLfY9hstFhaHhQ8xSVw1x1ZlSOqtqtwqWPZbfAcpeQoLs8CEyd8GhKfpCufN5aWaL2Lfmf3W05flb74SPqh4OYOK1JG5i+aZPGHT3S+iQKvpicLp/hSSSY1/ll44YzE03F/vKXwUevM4FSW0fsOQh4QbW9w+gPMJUoS2LKF7cWdPYW7h4lkiyK4w788b8LD2C+m6FsmaeVNQlxSg9SXiAzLRYGjobBjokBizbMOSybWprRbpQHPXGsbHqReXu0aZ7sVpHMGKgSQ==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 08:24:15 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 08:24:15 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "vivek.kasireddy@intel.com"
 <vivek.kasireddy@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v3 1/4] linux-headers: Update to Linux v6.19-rc1
Thread-Topic: [PATCH v3 1/4] linux-headers: Update to Linux v6.19-rc1
Thread-Index: AQHcij4EojCfYN9F70KslfxcbxhCuLVcSWmg
Date: Wed, 21 Jan 2026 08:24:14 +0000
Message-ID: <CH3PR12MB7548E062FB7E82F29093E1B3AB96A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260116092950.15796-1-skolothumtho@nvidia.com>
 <20260116092950.15796-2-skolothumtho@nvidia.com>
 <20260120135151-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260120135151-mutt-send-email-mst@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|DM4PR12MB5914:EE_
x-ms-office365-filtering-correlation-id: b70da753-22c4-4908-be2f-08de58c67692
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?qEuwyRTQ62evBiIV/Uat86u3qCKLfC8oG4/lx58kPaeNT5KVYa0svEFlo3?=
 =?iso-8859-1?Q?QsmnqWMjg+0n+KDYgLgh9kXvD2POV3m9CblPH93M0jEnd/rS2CswVB9Pzg?=
 =?iso-8859-1?Q?wOts++/HsHJH2Hb4pE+ZxYfXRQoZeapUFpJYNb3V30esG1Y9uFW7jY+cij?=
 =?iso-8859-1?Q?aOFoozPkI7EHlqdIPIx/UMzz44gbr2M4adofYDV2Pl2nlN0zMEix5pMAJ/?=
 =?iso-8859-1?Q?u5gZ9nQRANaDHDxfJ75QBLpmeAWiEHO42nTIaQteoJsvix/vBMbWTmt+ct?=
 =?iso-8859-1?Q?baD3EywEQowmr+eOY/sswXxacEDp+bvvYMQWwRR54IxBckFewiPfR1bRUF?=
 =?iso-8859-1?Q?4M/JyvNN/7AbM4oE8oc6eqHhl6JBamtZQyIjW3JC/SQ05/93ntcaL/Fq2S?=
 =?iso-8859-1?Q?qOONdfVtv0thrFKZ7+MKY6S7N43qalaDat++q3EzVHKOoaBcjz4zO7YVk5?=
 =?iso-8859-1?Q?/ZjIRQc29TZ/MbVQDWFx1KwCfB+Xya4TsehQF3k6jvsCJ4kaMeHqUrw87v?=
 =?iso-8859-1?Q?kTvYINpaRDG4o12FsSoqub2D/Aulcd5yMW0BbH2yJ4NbE03Ykw58lzN2q7?=
 =?iso-8859-1?Q?hfUGZZoJcR6qElnSZCsTlqfBWjfFcP36gGtHwp7SESWNwi/Wuc33an6DmZ?=
 =?iso-8859-1?Q?NkBRgg5wGUYVjrx30Ry86sEszYRTKS7ThBL0olpHmfZVZzeGFROA2+a4SI?=
 =?iso-8859-1?Q?rrre3ltGfjwV3gOQxUHzdXvpwE2MFXTOlVjqgMs52LSHRP9oRWKPoMNqMx?=
 =?iso-8859-1?Q?mi1uvsKZ1cwA9dFuB3+UF+yiFWXuKW6xLweMQlqBbT5ksPUp9/EoGsntgy?=
 =?iso-8859-1?Q?Y6+JCE+tUhMGCgEb18exwhaOzFpVvxRoulHOhs5iFUhTnP3KQrEcpocVBe?=
 =?iso-8859-1?Q?wzxqi6fgvYN5V/sZKZSVMQa+1fP7Ix1wCfk7pqA717aDbVAHUjjX/hFBvM?=
 =?iso-8859-1?Q?6swZgjs0bNKYRTuRxgq7bOLway1etQrxweel5sBSbOnx8nC14bni+ChdIy?=
 =?iso-8859-1?Q?o+hxNpQP1uwjACKj3IlaJim60juqPOlAQxFn1EYfokjugterQy0Jd4W8+s?=
 =?iso-8859-1?Q?nASG8isQOTf1tN+4UCAFBqtjZc7xmuyMbOYKvFTqRVJLr+WJpaBjuyc4Yu?=
 =?iso-8859-1?Q?XbbmwOGMKf1AGNJSFATyZ6ZPuhMjDzVawnJ+voRM24P16dvwVWwDSXebIJ?=
 =?iso-8859-1?Q?5uM7kxAJu3FL5ce7Hhmafi+h8JU+GAKCKqbpOked0Cu7SQWULs9PLgJ1Qs?=
 =?iso-8859-1?Q?EnZdDSWP0XHJEhNQV48E4JPVRSlhCsdm51ssa2mdkN9YEHUsv8vQSe5gRY?=
 =?iso-8859-1?Q?ByNNdbQnSp9MGzbWlDsF5ALXaCjV/lBgTKUH6QdG2V/UNYzjSytb150c/y?=
 =?iso-8859-1?Q?seTLn2SkulAtTjQKoIUHOzIFNH6j48Xk8dFrxOdSjDdVvHxLedOi4emCkV?=
 =?iso-8859-1?Q?iPd1ycLCXmOlPecfpXh9j+8ig47OZ6B4nUJIEDDx5nCXYiCEZu7OyfEGvO?=
 =?iso-8859-1?Q?ID5AIJb5feY1+VYnIgbgGlFDmb17Esie4MA986GvAubnXWZ+/cBagEc92u?=
 =?iso-8859-1?Q?MFcc5ouiYDwJUI2JP1idFChS6uJyZnTAsFf08mJX9LI6ppjrv2GBO/RZhq?=
 =?iso-8859-1?Q?esqoae2CuXiJo37B9ScfdlXBVkF3eWOEUvJif43zi3h6wFodQFb0yU5Smp?=
 =?iso-8859-1?Q?pPPXdOHB0umSAkbdKjY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dOyU2Qq1B/mbYi8S4vnGMrihW6P3QK9WU+NJif3wgg5O3YNKH7LZo4N2jq?=
 =?iso-8859-1?Q?TWa6N3WBWDFDG0XBRH/ky0WakSbPZWdChZ3Km4/QDmaGkhk26j3zZAicYw?=
 =?iso-8859-1?Q?RKABjn9QfQuZL9nFL/cVBh1OXlBaFe7V16BttkLGGyjL+fnu1eD504O0J8?=
 =?iso-8859-1?Q?Q/pwVe0hGXWv1VDfWsXo/LtxFrYqhDbQo0wb9OSAJTX2WjI4w5mgbJVTNV?=
 =?iso-8859-1?Q?Rmi0MGOt331cOJNldMcj35NKSYopJEyc66v6Z5fNukyhqTEZSFo1yaVkHC?=
 =?iso-8859-1?Q?fwsHgYw+S3J8Hiblcf8kt6l+/qcjOMX192WNIif6xwSRqRyfhaz1rGWZJV?=
 =?iso-8859-1?Q?mrfk3Lw+GGV0SSva3/ltqdpveyEKzftFvqmV/NGPg7xM9tlNt9RXivO6Xb?=
 =?iso-8859-1?Q?JPjBdkOqRgwmwmcuGjM9bN44UF/nZ3VyvjR2kytmKeNU4MyBmXYrDEnwjd?=
 =?iso-8859-1?Q?49pUOi6qACDAP5K/eYS/kQJ9ga93a44/qnPRHCPxOf8TRZH8K7I2smdiEb?=
 =?iso-8859-1?Q?Ikte7SnLCB8G6xaD2ZiBxGmyzxU+iRrVjFuMd1S14lXvZKgbPl//npX9+K?=
 =?iso-8859-1?Q?p+RBueE2GHr8+vEqoGX9aNzA0cZRR8+EHqwTyiESMkCZgm5D0NwUTHy8mW?=
 =?iso-8859-1?Q?ANJueS4e3NPwFSWnTPtLCEui1tBtpYeQpTyw/O2wMz9LkbSua0EbzAAPoH?=
 =?iso-8859-1?Q?sZK8Tkmrrh+6BixYZ64ZqYvo6cUyEmeJ6um5kNSiz6/AnNGqeq3aJUY8mY?=
 =?iso-8859-1?Q?B+JccQ9d9Rs5T7iik+n2S4wNQwMbWZvic4iM0eWpDy4spAjMZU/4pQ4sLt?=
 =?iso-8859-1?Q?W2gxG3dyYbjkpKfMPXEIWloEOd2hDb0xt9l+0vIwpzKGyQvggN5HTQybKd?=
 =?iso-8859-1?Q?OER8E1cI5uPp2nPQWfvj/e+sat4f6cpM/TAsIlm/PFKSRR/c8Ez5EhFVSI?=
 =?iso-8859-1?Q?/80CPX/TrHcNl1VE+mFipXbuTXj2MsDcHgQ3kN0JJYSwBoYE7H/c2prpNJ?=
 =?iso-8859-1?Q?aFWx4d89g6zE8fUXKtawQJbx2yaFxvmHGgvGAbAsjrzf86vqyA5A76j+CC?=
 =?iso-8859-1?Q?NHRxwDn/LFVleNHkKfwxjaqthnlC6LNfYAs7xLqHV1oCMqhnpzqlKg8FQF?=
 =?iso-8859-1?Q?k6Hau9ZgG5Rc/vdSGLjWSnTgBXfK20MEQzXNcLEpb1yRTM7Ht8wgA7SBoU?=
 =?iso-8859-1?Q?EzmlCAs5uKlwnuxq0F3hU5NbuOv2GZI1lv4+a8SMrBOz8OBHmQ9WyscmFY?=
 =?iso-8859-1?Q?mnPAAGM/FQjfoKDLFJXMq+RjimuVQtHRsGU1G4F6epnyIcv2YCs6FG1c1M?=
 =?iso-8859-1?Q?7QkEwgOOx/izUSkIvKcOrTQMH9jiKZwxzXmgFPz9d0ZEI7fZSWtW3PREUS?=
 =?iso-8859-1?Q?qAhjWoAYRq3wFDK3XBVEV6q913Ger9vvOaWyonKfzj1dC9XDV8nMXtuujG?=
 =?iso-8859-1?Q?9MuY47k78383EaP+fLlYxr6PZqC53Vr0nDPcLTwxsQ5nXOpNeyum1LfB3E?=
 =?iso-8859-1?Q?THsERP5fgAv9Crxb/Wk5yhmLLbfJqMW8H2o2QnH8wiDM2VqmjaZENCIITq?=
 =?iso-8859-1?Q?egAdMEbImi5kxk3AFrGuLI3jr3NX5x01U7Qwj5xKVNLtzGvZyEABxDfRRf?=
 =?iso-8859-1?Q?K9DiAyl/BqKJHD65XWH2LBDNdZNkPK8Gya5875cG70HkNhQH+h50tHCl0u?=
 =?iso-8859-1?Q?TSsNtSaYh/t1Lm1+QKX4UHjYTzRwq8oENwKrDm474OywcZrfu3fVMpEoZC?=
 =?iso-8859-1?Q?mJ30GC8O5cVwxd7a0a3LNYzqs2nwM/25mppJcCVVneWvGVAiikL6S8uGyL?=
 =?iso-8859-1?Q?cTk6/FNepw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70da753-22c4-4908-be2f-08de58c67692
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2026 08:24:14.9226 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cqEe8Z97q8sWLGTxh50vBPG/7rHGxODJrN104B6jMs4iZ6WNksoGWaeTOIMyuGRxU7mSaq9OHfrhqSG2JErA2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
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
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: 20 January 2026 18:53
> To: Shameer Kolothum <skolothumtho@nvidia.com>
> Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> eric.auger@redhat.com; alex@shazbot.org; clg@redhat.com;
> cohuck@redhat.com; Nicolin Chen <nicolinc@nvidia.com>; Nathan Chen
> <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Jason Gunthorpe
> <jgg@nvidia.com>; jonathan.cameron@huawei.com;
> zhenzhong.duan@intel.com; vivek.kasireddy@intel.com; Krishnakant Jaju
> <kjaju@nvidia.com>
> Subject: Re: [PATCH v3 1/4] linux-headers: Update to Linux v6.19-rc1
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, Jan 16, 2026 at 09:29:46AM +0000, Shameer Kolothum wrote:
> > Mainly for adding support for VFIO DMABUF. While at it, update all
> > headers.
> >
> > Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> > Reviewed-by: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>=20
> This breaks bisect (next patch fixes build).
> Pls come up with some way to avoid such breakage.

That's right. Can we fold the next patch into this one? That would be
the easiest thing to do, if that's acceptable.

Thanks,
Shameer

