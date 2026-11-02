Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD8606A909
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=tDizX6LE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvTH-0001h4-7J; Mon, 02 Nov 2026 12:05:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xNvT9-0001b6-Fi; Mon, 02 Nov 2026 12:05:16 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1xNvSy-0005fr-FE; Mon, 02 Nov 2026 12:05:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeytSTnX/wzuc7i1bpMCkio7B7KEKRKa91uEw/0ejj5wZEoqUsGqOSgdZmFIqxXCcyh++KAbEKX0aX+poXX3dpFdNeD+LUNSFxTFb0LeiA1bo1FizEW8BCM2uWgWsbe0KbfVUh+LGeM1CLf7Cb9gIBayXO4EDITIoLiR5ODkv5rZKPpPziZYcvah0JKaSGXz1yVe2vzJ6EI0/4ZwkiqXPKMsBxCzf4K2q6wraxO61gKCS4lB4JXrCFYaZG0UM8EBqFkIOWNK7Oq+OxCWMyTP8y5OTOab69row5thQ9FZTP2Tsbj2881GyZPVNdcPJVJEanI94coK4ATTWfSeoqclwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IV6scutLgZzenWDtldS3u/Bu36LOCg7N+ok0cAsDiig=;
 b=KCluUbEqvqdL/jS+h4R7g1XrumJ2KxUP93C51sejV6TxC1Nx8NWPZ/Eelr9s2CYVo7lHHovQZ7v7K53wAC4RLVWGP7/dU5VQrY2Sj0QAtN7LTh2G9+JTW5nvf5bb9LAE6uySymlRMAzg+OzDmNYtCVV5Q7Fyb/Vv97cxbxAs1MozMLw/nSdsQ4lYSUPaeuvggx0r0g4faqJaQosOYNM89g6MxlzQAsK/hLxHkJiMOIpDl80iAtCi55867/xAGClgeGhJ4jIIjsfUhTMXc4GDdRt0hMr1ihT7RJwAPFtT9uVOGnUeEX0vPdotY0Fgb+xJO7qphpTk0bWcLZuMtzs7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IV6scutLgZzenWDtldS3u/Bu36LOCg7N+ok0cAsDiig=;
 b=tDizX6LEvSps8qbcXwmc0d3pI5OBcmrbqTho+VlFabYKCjGrebU9m4ZJV2cJZ6DnRNLtxI61uvhFBhjPM+lxAXPpr54aVsAPbA+U+cAfBcKrXCDg7qVSZ+NzEVQg8EsxWuU0mXqEyBEGjTTVwGz0SV3ks9Ih2nSoCCq6decV/wcXbyPKnf0cd8dhGDQ+Zu+MwRjoEvR7k5KkP5KMzO9Pv7y3UyWl1fNnT5IscI/Tsq0YkPhC7ocMS6RoUCp/JvQY7eMU9fjB1aSuZpIkJFMX7tfN0HOoD2sH8QY8ltcrCKTSkQO2KEJBHvlah795UxwhagswC0GFF/jelq05hZsqbw==
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 by IA6PR12MB438941.namprd12.prod.outlook.com (2603:10b6:208:601::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 17:04:56 +0000
Received: from SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b]) by SJ0PR12MB8614.namprd12.prod.outlook.com
 ([fe80::fe0a:6e6a:fe60:a43b%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 17:04:56 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Tian Zheng <zhengtian10@huawei.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, "jgg@ziepe.ca"
 <jgg@ziepe.ca>, Ankit Agrawal <ankita@nvidia.com>, Aniket Agashe
 <aniketa@nvidia.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, liuyonglong
 <liuyonglong@huawei.com>, "tangchengchang@huawei.com"
 <tangchengchang@huawei.com>
Subject: RE: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=on
Thread-Topic: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=on
Thread-Index: AQHdPJgnxFHep9flGkG9ZpJw3a7LcbcYAQSAgANdsiA=
Date: Mon, 2 Nov 2026 17:04:56 +0000
Message-ID: <SJ0PR12MB861485BE2DAE769A16B32A87AB6A2@SJ0PR12MB8614.namprd12.prod.outlook.com>
References: <20260904180513.248396-1-skolothumtho@nvidia.com>
 <67d6e789-6620-4204-9ae7-37991b1ec432@huawei.com>
In-Reply-To: <67d6e789-6620-4204-9ae7-37991b1ec432@huawei.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8614:EE_|IA6PR12MB438941:EE_
x-ms-office365-filtering-correlation-id: 94c622da-9e99-47c3-e470-08df39036bdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|3023799007|4133799003|56012099006|11063799006|4143699003|261026140227099003|261021123027099003|261022105027099003|261021133027099003|261022115727099003|261022113327099003|261026135527099003|261026121527099003|261022075727099003|261026130827099003|261009221227099003|261021135927099003|261009223027099003|261028144727099003|261009223327099003|261009221727099003|261009220027099003|261021121427099003|261021130227099003|38070700021;
x-microsoft-antispam-message-info: 9U1bGyzD3Ycf4EoK3hjkMKquvg/8PDsCdSpWja8IEye7FUViEBeeWm8sOxTMdh3cl7dKRXa2D7RZQ9GBMGfHmQBBdkMix1yMQIQgVkyU4h2OJhDhAr1N/wf6DkMCzXbsh+VUwpB2zZbwOuYHboGleFm5Dj5EGt+nR2xh7W0l8e+VCHikphQRbTJ48hePprh1UgM6mQHuFqGyzos3a2CwpU3iR3rYJey1RKwhrMl3l/91ZjBhDKfPk60j/JZqDP6NiY3ft9pdF+9eGb9cEOMILTSq9sgUjPhlsdovOtO+uQNtP3Y3RJguy9hn8ZgYeAbAxgix5UMWwHh5d2GDIzrCvOVKukT+j7O892RzV2/e5sBNRnD36g8XFuNczNeHNNrLk0AU4+0L+s7AodNYyhVYkv+I45IBiKFJZhRkfFN1LtTYFcCbg2D5IBu5sTx8Qj/mnUZpv/Nl9/gAgtT5WSDrmIDyUKkO8PWn//6OFtDj8IXlySBoYJiZzPCpyjOeKRuVz78TAuIIETn9sQMaJg4fVUxCPU3iTOhEHGr7TM782XbER+c5PLFTEtO6iOpQlokGAF12w0JNndc4QOKmKgYhziVEmOfZB4hXO+b1/nGjvOQpyBQUy9J3ZgIB3F2x2kCRwJMYh2lgfvoGA/Qv5TygDfEA6SmBlXNVPQgqvjUyDsnja88GbknhAwzUhd5d1AumcD+LjJNGO+nt4u8MgTW054dml0MC6sXff05daa+LVpY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(3023799007)(4133799003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261021123027099003)(261022105027099003)(261021133027099003)(261022115727099003)(261022113327099003)(261026135527099003)(261026121527099003)(261022075727099003)(261026130827099003)(261009221227099003)(261021135927099003)(261009223027099003)(261028144727099003)(261009223327099003)(261009221727099003)(261009220027099003)(261021121427099003)(261021130227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?87IL1gBBjNsmaW/YrSDFLxC3/ZyklJIZvjGCRbXdT950l1WMSMV8i3TaaGIX?=
 =?us-ascii?Q?o+g8Ub7McWhboBJ/ndvBbOQ4ONQn2njVUPMe9CDLl/5PksdyylU9HYKuqVzU?=
 =?us-ascii?Q?SD1K8NuXLrZXt833BIRsrhJmcOfx+VIJA1OLymq8C/mp8vpjyCcS/dubCnEq?=
 =?us-ascii?Q?4puZy4ZS4ySVpg6nxNk+aMux/AHTjJxGQaQjq0WWxmzQwNHjAjuZl8IrKwog?=
 =?us-ascii?Q?/o8e69kk25gGzcHyfnv5nLtwCNJsQJf1OsJcT/gHSgxF9nCZYFh7V74fwB4S?=
 =?us-ascii?Q?Lgb0pNEkV7gEENWb7mDdP6nYOceCcptSQetDvBFfg6kmIspbYJ2k41Qxpln8?=
 =?us-ascii?Q?pDDXVgOfjQyy21idtkYaONDGxihWf12VZZpatlQQSZbWddCXk2zY8HiFMrRq?=
 =?us-ascii?Q?2ewLAi5QVwMFpZLKxKA0FmnPPFgUUHD9nW5SNCQ+S92snYj0Mw9PFbpLCBlw?=
 =?us-ascii?Q?o7iJDqe+djnNxFQwBJeNhbI0XePxY0zkm1QGzCx6RXarYTyHPLYEsB5cI2Db?=
 =?us-ascii?Q?ZYxFbP46CENvESfhL2phd/JIZuFPQy/DIfCUc4YgMWa7ypXowqvRMOzEwkcv?=
 =?us-ascii?Q?4QdyttWxaOErGGnOJckJVsuOlbVglS+XdlmfkZ2c46GlJF4WzhdrXBBBENTi?=
 =?us-ascii?Q?wFgNuSRnm9e7MmoDU45bZWk3u2bivvRTqG0F8iolTSeH+0wLaosmkPIA9mdJ?=
 =?us-ascii?Q?wRkH0f9Un5r6cdyK6SjqZymG+VPBrHAorhqLg7Fe4zXYB9QB7G6wqZvCxqoB?=
 =?us-ascii?Q?TkN7C3Fp8NvFvd+Q3Hi2HUSKXjkvSdKj8/VKRY3BUfeLGpxkNj2/V6tWWv4F?=
 =?us-ascii?Q?ctifE5xPp9uWj5xehFYyWxGgoFJc9Jg8Te2KCdwOT/0o8myWPrr9yjEz7o2+?=
 =?us-ascii?Q?NhUFFV58ulCARL4nPK7frvrR6mz/YCOI/j8gsEhLM0ikrZyAX4e62q/GozNN?=
 =?us-ascii?Q?iJL9WWIq6cHsJp2LtDISP/pRjFLKr545ngXqxqvaYGE4ZX/XWjCFQluUTBDU?=
 =?us-ascii?Q?BJOdeUQS7Mf1DosLuJHFrbMyJBGF96PY5AMqqXAWz0vuX+yvbnlln22VcxoF?=
 =?us-ascii?Q?1IL3pZQM2DI/Oqy5jrq73LDy4xWBbN7OxxR/tl3FfiMg7H47U0bA9UUiIa4M?=
 =?us-ascii?Q?ZC8bFUw4jHUPD6EHkidn+Oy723541Ghq61VabqnSlBJj0GOFsBdnKATjxOEj?=
 =?us-ascii?Q?RMqjfiCPq0DX+hN4qVwFDHdr0Zh3NI3GCLc9p85FAkqeMFDMsukT38o/4Wdg?=
 =?us-ascii?Q?Z9aiohyS9k3rwh0jcS9zRqf//2vrYJGgIOtlx/cCWkgm3dK7FkM8kx3UtwDf?=
 =?us-ascii?Q?bYesoadwyAS3iQ0qQ61tWxmTFmSOVBfH8q0G6mW95WrDN2TB4bMHQcVoXXHh?=
 =?us-ascii?Q?8L/7y5g/ayOOQyzGdpn69tiTU75+fu+PEHmHuTHZ78dTGVUKQ6uurMNAJofi?=
 =?us-ascii?Q?J699XLOO69r/qFJXFcBiJ+CrqRs6ndBRUd5tnFlXwvhof8Khcld4mQVRQEFq?=
 =?us-ascii?Q?LtKKf2petnjtWMYsIP98pF59ZQnhKAOCFtCrMK/C/Y15jHqMaeSMQitBjPlO?=
 =?us-ascii?Q?0S93u/SXL9rJWYZk6ap0RWa4G2wI4nfs4xjlqcDQrYKlB+585/v9oFmEFDUo?=
 =?us-ascii?Q?wxKC3xhomhDSp2alcWmiQZosf+f13qTKQj79u4q6w/MRsh4fn4QPHgYjZywT?=
 =?us-ascii?Q?B785/uewiNhyAAXY5ugx+hDxaTF8saVz0QmAr1BcsKkwOdtB5DlwkI2jiL5K?=
 =?us-ascii?Q?0JzalepawQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c622da-9e99-47c3-e470-08df39036bdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 17:04:56.7077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +heSpvRSOg+F8FodF+QKAcG7mQnMFWc9EAyOUVU7SV2Au8wKJR+EzFWtyF0DfFZEGi48zLieBwNz0YAfrzyrWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR12MB438941
Received-SPF: pass client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> -----Original Message-----
> From: Tian Zheng <zhengtian10@huawei.com>
> Sent: 31 October 2026 13:38
> To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>; qemu-
> arm@nongnu.org; qemu-devel@nongnu.org
> Cc: eric.auger@redhat.com; peter.maydell@linaro.org; Nicolin Chen
> <nicolinc@nvidia.com>; Nathan Chen <nathanc@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Jiandi An <jan@nvidia.com>; jgg@ziepe.ca; Ankit
> Agrawal <ankita@nvidia.com>; Aniket Agashe <aniketa@nvidia.com>;
> wangzhou1@hisilicon.com; jiangkunkun@huawei.com; liuyonglong
> <liuyonglong@huawei.com>; tangchengchang@huawei.com
> Subject: Re: [RFC PATCH 0/7] hw/arm/smmuv3: Live migration for accel=3Don
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On 9/5/2026 2:05 AM, Shameer Kolothum wrote:
> > Hi,
> >
> > This series adds live migration support for an accelerated SMMUv3
> > (-device arm-smmuv3,accel=3Don) with vfio-pci endpoints on the iommufd
> > backend.
> >
> > The destination replays rather than receives. The stream table, the STE=
s,
> > the CDs and the Stage 1 page tables all live in guest RAM, so once that
> > and the registers are restored, the destination walks the stream table
> > again and rebuilds the vDEVICE and the nested HWPT for every device.
> >
> > What the series does:
> >
> >   - drains the kernel vEVENTQ into the guest event queue when the VM
> stops,
> >     so that pending fault events are not lost (1, 2)
> >   - migrates the resolved SMMUv3 feature set in a new smmuv3/accel
> >     subsection and fails the load if the two ends differ (3)
> >   - replays the guest stream table on the destination and restores the
> >     vEVENTQ and the GBPA HWPT (4, 5)
> >   - asks VFIO for dirty tracking on the Stage 2 nesting parent (6)
> >   - replaces the accel migration blocker with one scoped to CMDQV, whic=
h
> >     cannot be migrated for now (7)
> >
> > This depends on the host kernel supporting dirty tracking on the Stage =
2
> > nesting parent, for assigned devices that cannot track dirty pages
> > themselves. A branch based on Jason's iommu page table work is here [0]=
.
> >
> > Big caveat:
> >
> > This is not yet tested with a real device that supports migration as I
> > do not have a test setup for that. Folks who do have such a setup have
> > reached out and are copied here, so hopefully this RFC lets them give
> > it a spin and provide some early feedback.
> >
> > QEMU branch is here:
> >
> >
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2Fshamiali2008%2Fqemu-master%2Ftree%2Fsmmuv3-accel-live-
> migrn-
> rfcv1&data=3D05%7C02%7Cskolothumtho%40nvidia.com%7C1686c4874d5c4be
> 3e7fe08df37543fa0%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C
> 639290507158409428%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOn
> RydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ
> %3D%3D%7C0%7C%7C%7C&sdata=3DM30uWfAzPcqdeQifvQlNcaOmZzHQbalNJ
> uNtB9DhDPQ%3D&reserved=3D0
> >
> > Please let me know your feedback.
> >
> > Thanks,
> > Shameer
> > [0]:
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b
> .com%2Fshamiali2008%2Flinux%2Fcommits%2Fiommu_pt_arm64_s2_dbm%
> 2F&data=3D05%7C02%7Cskolothumtho%40nvidia.com%7C1686c4874d5c4be3e
> 7fe08df37543fa0%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C63
> 9290507158463751%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3
> D%3D%7C0%7C%7C%7C&sdata=3DHO9UHPTS%2FWKbQnGf8DKsDy6oGrFYvNB
> uw%2BZ4uh3ZDJ8%3D&reserved=3D0
> >
> > Shameer Kolothum (7):
> >    hw/arm/smmuv3-accel: Factor out the single vEVENT read
> >    hw/arm/smmuv3-accel: Drain the vEVENTQ when the VM stops
> >    hw/arm/smmuv3: Migrate the accelerator feature set
> >    hw/arm/smmuv3-accel: Add a helper to replay all STEs
> >    hw/arm/smmuv3-accel: Restore accelerator state on incoming migration
> >    hw/arm/smmuv3-accel: Request dirty tracking on the nesting parent
> >    hw/arm/smmuv3: Support migration with accel=3Don
> >
> >   hw/arm/smmuv3-accel.h       |   2 +
> >   include/hw/arm/smmuv3.h     |   7 +-
> >   hw/arm/smmuv3-accel-stubs.c |  17 ++++
> >   hw/arm/smmuv3-accel.c       | 192
> ++++++++++++++++++++++++++++++++++--
> >   hw/arm/smmuv3.c             |   6 +-
> >   5 files changed, 210 insertions(+), 14 deletions(-)
> >
>=20
> Hi Shameer,
>=20
> Thanks for the series. I tested it on a KunPeng 920 with a HiSilicon ZIP
> VF passed through via VFIO, using the non-SVA accel=3Don path.
>=20
> Environment:
> - Intra-host migration only, cross-host migration not tested.
> - QEMU: your smmuv3-accel-live-migrn-rfcv1 branch.
> - Host kernel: your iommu_pt_arm64_s2_dbm branch, plus one local change
>    in arm_smmu_get_httu() to fall back to the hardware IDR0 value when
>    ACPI IORT reports HTTU as 0. No other kernel changes.
> - Guest: openEuler 24.03
>=20
> QEMU config (source; destination differs only by BDF and -incoming):
>    qemu-system-aarch64 -machine
> virt,kernel_irqchip=3Don,gic-version=3D3,nvdimm=3Don \
>      -accel kvm -net none \
>      -device arm-smmuv3,primary-bus=3Dpcie.0,id=3Dsmmuv3.0,accel=3Don \
>      -object iommufd,id=3Diommufd0 \
>      -device pcie-root-port,id=3Drp0,bus=3Dpcie.0 \
>      -device
> vfio-pci,host=3D0000:31:00.1,iommufd=3Diommufd0,bus=3Drp0,enable-
> migration=3Don
>=20
> Two non-SVA workloads ran in the background during migration:
>    # (a) sustained load:
>    uadk_tool benchmark --alg gzip --mode nosva --opt 0 --sync --pktlen
> 4096 --seconds 60 --thread 2 --multi 1
>    # (b) integrity: compress during migration, decompress after, sha256
> compare:
>    kp_utools k_acc -a comp -n "compress-deflate" -s 1 -i big.bin -o
> out.gz -P -l 60
>    kp_utools k_acc -a comp -n "decompress-deflate" -s 1 -i out.gz -o
> restored
>=20
> Results:
>=20
> =3D=3D=3D 1) IDR matching (normal) scenarios =3D=3D=3D
> - Patch 3: matching IDRs migrate successfully, including between two
>    different SMMU instances.
> - Patches 1/2/4/5/7: live migration under sustained non-SVA load
>    completes; no SMMU event storm or event loss observed; STE replay and
>    accel state restore work.
> - Patch 6: S2 dirty-tracking integrity passed. The device kept doing
>    DMA writes during migration, and the decompressed output matched the
>    original input byte-for-byte (sha256 equal). This device has no self
>    dirty tracking and relies on host-side S2 dirty tracking.
> - Repeated/ping-pong migration on the same host also completed and the
>    device worked afterwards.
>=20
> =3D=3D=3D 2) IDR mismatch (negative) scenario =3D=3D=3D
> - Patch 3: with mismatched IDR3 (source ril=3Doff, destination default
>    ril=3Don), the destination correctly rejects the load with
>    "SMMUv3 IDR3 mismatch".
>=20
> No errors were observed in the guest or on the host.
>=20
> Tested-by: Tian Zheng <zhengtian10@huawei.com>

Hi Tian,

Thanks for testing and the detailed results. Good to see this working
with a real device. I will refresh the series, addressing Eric's
feedback as well.

Thanks,
Shameer

