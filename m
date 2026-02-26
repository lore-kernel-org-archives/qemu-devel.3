Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E182FD461F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvUxS-0007vJ-AN; Thu, 26 Feb 2026 01:34:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vvUxP-0007v6-0c
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:34:43 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vvUxM-0001QM-DZ
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1772087680; x=1803623680;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=7URt/KUMK+5ibwGFYFSft1xhe6Lbk3gFs9R2G8WPdB8=;
 b=ODyE+PJ8mm5rLRJyAOx1i/LZ5Nl+1H43hb5+S+LkWAurcE9RgCG9CLTR
 8px2kloy3cZTMGHjQZ7dQlJKahZ/vhvBBK/MFBx6a9bnw2q6dT3JLFOOi
 X56HWXdb9yY7efQc09vwx1ynd/E0bbQ69nkJLF2eVysoxS/v0yZeQ4ak5
 0f2DZL1Glm0KbIvwRfGlkcAHj9TXf4aH9eQ1/mNF7DpN6DfW72x7f470w
 EJoOgLPdIJy/Ih9f8QUg0kfA8/HsMKA1AaVHJniKmOJQeUQIHG/ctjWaJ
 /5FxTR7S2vIxu5nYumOuP69Z9fid1lpFyJsuNyOXU04eBhxThHjL38VBV w==;
X-CSE-ConnectionGUID: tH7ZxGmYQOq6mVWIsXi+WA==
X-CSE-MsgGUID: yN8tiA8iRCSzfSitySb7Bw==
X-IronPort-AV: E=Sophos;i="6.21,311,1763420400"; d="scan'208,217";a="46676490"
X-MGA-submission: =?us-ascii?q?MDHIcCPHr9woO/v5HwjMavCqkrQuAz1OuHKtkx?=
 =?us-ascii?q?DU+Vs1SQSm5KD+We60SsjksSlq5wPTig4Si8dljXUuGqDE7nDhaE0qPq?=
 =?us-ascii?q?2L13cFx+srTCEIEsBv4gPRsb/NqagqEsrzQredmatGeSf1x1xYIGy+UI?=
 =?us-ascii?q?/jh+0jalgKcfqjnreOiz3Yzw=3D=3D?=
Received: from mail-northeuropeazon11011006.outbound.protection.outlook.com
 (HELO DU2PR03CU002.outbound.protection.outlook.com) ([52.101.65.6])
 by smarthost2.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 26 Feb 2026 07:34:36 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChwaMyfPg0bl4p46G/tZn3NQj2EgljXWvH1Il4kezBWLLUoW2SAykWSPFPWFJqs2NuGdsfeP/uKLCKn41DlDoag0V+7i5xPt7Vgso412WgDx9y4tPrZKyenDw/TOUQiq72LeMbQxeFveUmQpREIbYWaLpSZoqyqP1vQBwVddjwIO1xjGu16TM6CRrdl65WnzNSmelk5xPYDPhsjPwqbzczBL/KEIUgm7MHCshVy7NtqDus8VLTaovXaLnD/Xf8TVBDSk+mBbx+WwP93J89SWa32FFeQ7N9nR7GonCjh+4jHtLQtZaLDqBOKGU8JGir6J9/m5w6xPXTaln1UdsMZz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p3OJ0zmf2LdkrrTTK4/J6IVZA/0pUxcbOanIEUD+gI=;
 b=RV6sHH8AB0ASz4LFBbX7Hx06TklHCmHxQT1WbzYGZFQxxco31SYYDfYyFO3JIOcjfWllm8WgkklSLhcfUGJmJL+HbRrXykK0MFokpmdKjckgTAkxVBLh5sLHZzVGegzqdOt4NPCKqOKnpBT6xSWUFdbkmh5cfRlvnL+p9Yr0yj0NLkWw9BgEZDt67QcQp6G1GAF7gAEEb9ZVP9GhniuXcXNzGP451MCHlSQKuIgSumFkE6kQaitGE/Is2hppipYgeICfmnBJ2uHlhyYeHnPBQj8WiH20hccytn2qJJEFEFsybaPsopXhXKNn1sULBBdy0MZLotsfH7edpmcdRApsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p3OJ0zmf2LdkrrTTK4/J6IVZA/0pUxcbOanIEUD+gI=;
 b=oMJDgQ9iTc8vEEEZGnyhtbC4G+s333u4sgM7GXMw2qRkGc/zAqlq7Z4zCqmmFx1rdQzd06g1BrIdaRBEfB5JArEbrkaqmZN6TklhPYh/R29OckW3qZOGt3JYyiay/KJIFQjMAnE103rVFUtyT26U8Pr5W0arjNNiYDToTbL0NePm5mj0yrOZpQijlWLZ0IneMhTC1b8SiSLKGboXcnnuPuAnXJMqxY56k8xVNPDI8XTVK7fvpir87fVq6eF/92o/pt+pxSRwU8LxM9HZRNwd+KeLG3HrmJ9z5OAJTl+OMLwR/PqwmuYwXsWp6dJDRfT/0WwvpblK4FpTBAC5PsVL+Q==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB9233.eurprd07.prod.outlook.com (2603:10a6:20b:5ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 06:34:34 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 06:34:34 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcnWP20QrD5iQNmEWrT+7sB8IeqrWTBahBgAFiFYCAADDZbQ==
Date: Thu, 26 Feb 2026 06:34:34 +0000
Message-ID: <AM8PR07MB7602232CB25D963A887E9B018672A@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
 <AM8PR07MB7602F76D7799033FFCB1A5608675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
 <IA3PR11MB9136245DC6D58206EC54E2C09272A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136245DC6D58206EC54E2C09272A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-26T06:34:09.791Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB9233:EE_
x-ms-office365-filtering-correlation-id: ab8531c2-4e4f-4fb2-593b-08de75011b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|18082099003|38070700021|8096899003;
x-microsoft-antispam-message-info: EHjekwLnYdMPTyM3tP+S26MN9mNIYS5pA5you3SoKrGzOi57p3uS3u1WeNESbj4Md4wWJ+NtW5LY6PDXJk9lLlBxeiZoyzdllp2NTWb8EL3/pgzkITthV5kFAAF6Em4QWv/eVfNSwJS43idreS1YplLecX01TeBYYJFCQifca1ngigFkagcknR2vB2YXvolvKa4wNi/X6HfIIGFzM85dqFs+soo3DB7YUZjFOBMt+OnJkEerVlAalTKoaPseP7eYQ7Vs48j60d8H6uQ/G9D4VxM0IC7CoH0cSoBnj5yWoAVACa/drePEff0a4d8mhVzEDHcjILQF65ccL8JyqpNdY4PDnS5YHBZwSky7At2FDl9Zdy7dTR1Byqv0csg/y59BlaxhwUq2UsLCPs8s9X+5ZFYjxMsH50mkt2mJPd96nQVq2FEqV8cqCjmq/HjztDMl27CSvTLA6zC8fA5+SP3CFobE0RGnguPhYe9R0O3GG239RsIIUdfsgsYsIw/XThgHTMoTDzzD47q8+Sb0Buz06P2uyu5ZQnGHGxMqfRZw/ePgq5yBHXaIO/A5qZ6zrFNOBu2tWRzsqRF89xHAMpZLlJJPo2N0dkj4i17JpQxHEZNMYj3eL2PqGE4uuScRlSIpdQX+q0KF9YcqHGsIZBaXVNA+IPwPhgKA8GZAhH7XHpT+fH8IzT2dRjUKw00NilZDgezXRVtPq9uMcHDsRhA5kAjl6yzU1U4xK74bfeekVxQ2/8AU17mjQOo1v4xTuZvFonFvK33NjJQnaXrTc23k5ZxpiW2Knt3NhrQpXF9Y5hg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(18082099003)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rvWk8BSQ+OVW536tuY6g6C38IqyNoMExNEQIFGn22QIGXeY3U6P2btrRz+?=
 =?iso-8859-1?Q?IoRtcSmqlfPnzpwyqC7i2moUCE5QLMTgXFeSMTreS4HQrej71ABCOjtSGB?=
 =?iso-8859-1?Q?8GQXPiLBi5q3IUb/X9YM0EulIr6q7Psb256txq5UfD0RPAC3eX2y96nKO1?=
 =?iso-8859-1?Q?U21xEfjUeT2vwlwY1j0yEtngzGTpjV4STNvogXspdj6aI03MNcc6r0glzY?=
 =?iso-8859-1?Q?rzeDNH6HUhWwIR/QduqoHYYC4wDeDRS1A9D+iKmkdpVVp+NXVJHXjon+4R?=
 =?iso-8859-1?Q?KaxvqegiM5t/dyEPqxT6Ri0VJBkwEjBLeqAqdSsFRKj9oHm/uv7MPEqXt6?=
 =?iso-8859-1?Q?1pWA4jmCt1mK+DhjyXYgsPZXzirvrQeX7Dzo/2TkvadFuYFz2qr28aNRks?=
 =?iso-8859-1?Q?HhotUzlIeNNKTNWaY/P10AymyCslIpBknTt9VxP3vXiJ9LHx9fVI02FLX4?=
 =?iso-8859-1?Q?qPCBxxWav3yP3hl/mOmylhOa0S2sK5cJ8DtauUI05Q0zoZ4XhsfCTr4jRY?=
 =?iso-8859-1?Q?gg+ybCTPVo+MbuSlftSNlKiB4OCz6DqR6i63hPGDfHapd87jRj4DVsZDoO?=
 =?iso-8859-1?Q?HO0kx5rLq58oGU1SjIbOPHjtP0bLRiDESJOlTrR9RU3Zsv2Qm72f2pxfiD?=
 =?iso-8859-1?Q?k3WwUCZMXf7GiHoVw61tvR7YeN02yb9sSPfmd3hP6ed8XCUzt6XvvaDJVw?=
 =?iso-8859-1?Q?VTPKMzzNX2oK6jU8q/8PZ8kGgmiTswx7B2ASF1DsU4bi6zQF1dYA6gflHe?=
 =?iso-8859-1?Q?5KjBdQwbGK0+G51EOc3DTWE+ldMcLezGxcOzDXsEI8f8JtpB1+j8NDIvoS?=
 =?iso-8859-1?Q?BuxWqB8s1ZLitNH5v+oq95N6g7WLJRAKII+wbjjyoOnWR4zuxzo3ziBTTm?=
 =?iso-8859-1?Q?oFjIn46UBK+hpPUcFjga7IpQfeCuxQMiAXT/gt4FTyf2lzq+nKG2FuC0xI?=
 =?iso-8859-1?Q?c8VkSz/bMw3Vhqf38lWyg+QR+d3CVPy/Vl/1xNCn3XSQQvP0yC3JYYPe4C?=
 =?iso-8859-1?Q?WoTeHCAZD1SCVsfgs0qTWULlp+wjxZSrmAE6t6HouHfhNiv4BFSWfTUDiZ?=
 =?iso-8859-1?Q?AEhYAGCYkijvigAFYFNEV85N7UOW+bsNx7yp9TK6oHw6JTaGS2ohaUe6K3?=
 =?iso-8859-1?Q?ekNLIYRxrzISCmoy5qH0Py5TMMSTqn4NAFzWpSRA166kpnUtU6JT3r8nm8?=
 =?iso-8859-1?Q?x+kfxisRm7hWiobcLIsMrcecdrL1Dotrgwa5aH47AnoXUnXtgjLPqeiKON?=
 =?iso-8859-1?Q?fCBnQMzMVRiEbkh0UENM4nSC23SrUIIweQ2JEujoUeToLjVNt70kjoon9D?=
 =?iso-8859-1?Q?tx3ZjfKLZ4oGFv3eR8+ytWOAXyEqGogYnZUIRUN3OscT1z6Wscjqbxtkac?=
 =?iso-8859-1?Q?OMAp35ZY9H+0pfDku5LTO6/3NFbar3h2dGGynBdZLXoVEsV08XbJSV1QaV?=
 =?iso-8859-1?Q?P0LvMTYhrxsLOHXefw9LcZD8pmAe4OGOTme7eIiI2EkFpxB55nFJudnx0F?=
 =?iso-8859-1?Q?4/jlVi2n8WoL9DrR728P2LV/EM8hQzh4HHgtoDap7xIWPWQ51ule+fOIra?=
 =?iso-8859-1?Q?D/WujTfL3aZZafU9KWaoaqu/Sc46V1hicuY08yC/lZh3PclU7hlkJ955Lw?=
 =?iso-8859-1?Q?bbmfVGRPb5cV74fqvi/bNXKW828DY95FwlolFQ5yB6dO0y40WOam4FWmQF?=
 =?iso-8859-1?Q?IQgl8pJKPEM/oLgz5OmAPFSm28aSrH21fx2xDhc5RyXHpaVv06TFMHQcVK?=
 =?iso-8859-1?Q?9S7sa7f94+Q6kcfLL/5zgBNF84uVgukuc0rCKYsjKoEbEP7K3P9ngLNEyX?=
 =?iso-8859-1?Q?SbS2NMVDhPhNyApOR7W/jNfC+3xd37Y=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB7602232CB25D963A887E9B018672AAM8PR07MB7602eurp_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8531c2-4e4f-4fb2-593b-08de75011b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 06:34:34.2260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZ0fEZt7qfJ/6ZcUXOzY8IKivFTQ7o/GWPX1c2ocI/JQXcT6jIq69G/h2iozvJCor0zBrmmcELPkwdLBX/iGxXKW20TpMbqy/71DRNd3TQiRUXBiv602oXgBDGIu9BgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9233
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_AM8PR07MB7602232CB25D963A887E9B018672AAM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Zhenzhong,

In this hunk:

if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH)

s->pasid comes from the prop and is the actual size right? not size - 1 ? S=
houldn't the comparison be > instead of >=3D ?

cmd

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
Sent: 26 February 2026 04:37
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>; qemu-devel@no=
ngnu.org <qemu-devel@nongnu.org>
Cc: alex@shazbot.org <alex@shazbot.org>; clg@redhat.com <clg@redhat.com>; e=
ric.auger@redhat.com <eric.auger@redhat.com>; mst@redhat.com <mst@redhat.co=
m>; jasowang@redhat.com <jasowang@redhat.com>; jgg@nvidia.com <jgg@nvidia.c=
om>; nicolinc@nvidia.com <nicolinc@nvidia.com>; skolothumtho@nvidia.com <sk=
olothumtho@nvidia.com>; joao.m.martins@oracle.com <joao.m.martins@oracle.co=
m>; Tian, Kevin <kevin.tian@intel.com>; Liu, Yi L <yi.l.liu@intel.com>; Hao=
, Xudong <xudong.hao@intel.com>
Subject: RE: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


Hi Clement,



Exactly, copied from PCIe spec:



Max PASID Width - Indicates the width of the PASID field supported by an ap=
plicable Endpoint Function. The value n indicates support for PASID values =
0 through 2n -1 (inclusive). The value 0 indicates support for a single PAS=
ID (0). The value 20 indicates support for all PASID values (20 bits). This=
 field must be between 0 and 20 (inclusive)



BRs,

Zhenzhong



From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Wednesday, February 25, 2026 2:42 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@redhat.com=
; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothumtho@nv=
idia.com; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Li=
u, Yi L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck



Hi Zhenzhong,



Why do we capitalize the first letter of each word in "Max PASID Width"?

I guess you try to match the pcie spec, but just want to confirm :)



cmd



________________________________

From: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.=
com>>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> <qemu-devel@nongnu.=
org<mailto:qemu-devel@nongnu.org>>
Cc: alex@shazbot.org<mailto:alex@shazbot.org> <alex@shazbot.org<mailto:alex=
@shazbot.org>>; clg@redhat.com<mailto:clg@redhat.com> <clg@redhat.com<mailt=
o:clg@redhat.com>>; eric.auger@redhat.com<mailto:eric.auger@redhat.com> <er=
ic.auger@redhat.com<mailto:eric.auger@redhat.com>>; mst@redhat.com<mailto:m=
st@redhat.com> <mst@redhat.com<mailto:mst@redhat.com>>; jasowang@redhat.com=
<mailto:jasowang@redhat.com> <jasowang@redhat.com<mailto:jasowang@redhat.co=
m>>; jgg@nvidia.com<mailto:jgg@nvidia.com> <jgg@nvidia.com<mailto:jgg@nvidi=
a.com>>; nicolinc@nvidia.com<mailto:nicolinc@nvidia.com> <nicolinc@nvidia.c=
om<mailto:nicolinc@nvidia.com>>; skolothumtho@nvidia.com<mailto:skolothumth=
o@nvidia.com> <skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>>; jo=
ao.m.martins@oracle.com<mailto:joao.m.martins@oracle.com> <joao.m.martins@o=
racle.com<mailto:joao.m.martins@oracle.com>>; CLEMENT MATHIEU--DRIF <clemen=
t.mathieu--drif@eviden.com<mailto:clement.mathieu--drif@eviden.com>>; kevin=
.tian@intel.com<mailto:kevin.tian@intel.com> <kevin.tian@intel.com<mailto:k=
evin.tian@intel.com>>; yi.l.liu@intel.com<mailto:yi.l.liu@intel.com> <yi.l.=
liu@intel.com<mailto:yi.l.liu@intel.com>>; xudong.hao@intel.com<mailto:xudo=
ng.hao@intel.com> <xudong.hao@intel.com<mailto:xudong.hao@intel.com>>; Zhen=
zhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.com>>
Subject: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check



Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Pasid bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.du=
an@intel.com>>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e4bcc884b0..e5518a94ea 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
+#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6483cb3d85..c1b31b17de 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
     }
+    if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowe=
d "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }

     if (s->svm) {
         if (!x86_iommu->dt_supported) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acb1b1e238..15412123d5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,
     HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
+    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus =3D vtd_hiod->bus;
     PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];

@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }

+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size =
%d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when x-flts=3Don");
--
2.47.3

--_000_AM8PR07MB7602232CB25D963A887E9B018672AAM8PR07MB7602eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Hi Zhenzhong,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
In this&nbsp;hunk:</div>
<div class=3D"elementToProof" style=3D"margin-top: 0px; margin-bottom: 0px;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"margin-top: 0px; margin-bottom: 0px;=
 font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helv=
etica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
if (s-&gt;pasid &gt;=3D PCI_EXT_CAP_PASID_MAX_WIDTH)</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
s-&gt;pasid comes from the prop and is the actual size right? not size - 1 =
? Shouldn't the comparison be &gt; instead of &gt;=3D ?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
cmd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;<br>
<b>Sent:</b>&nbsp;26 February 2026 04:37<br>
<b>To:</b>&nbsp;CLEMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&=
gt;; qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b>&nbsp;alex@shazbot.org &lt;alex@shazbot.org&gt;; clg@redhat.com &=
lt;clg@redhat.com&gt;; eric.auger@redhat.com &lt;eric.auger@redhat.com&gt;;=
 mst@redhat.com &lt;mst@redhat.com&gt;; jasowang@redhat.com &lt;jasowang@re=
dhat.com&gt;; jgg@nvidia.com &lt;jgg@nvidia.com&gt;; nicolinc@nvidia.com
 &lt;nicolinc@nvidia.com&gt;; skolothumtho@nvidia.com &lt;skolothumtho@nvid=
ia.com&gt;; joao.m.martins@oracle.com &lt;joao.m.martins@oracle.com&gt;; Ti=
an, Kevin &lt;kevin.tian@intel.com&gt;; Liu, Yi L &lt;yi.l.liu@intel.com&gt=
;; Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b>&nbsp;RE: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid b=
its size check</div>
<div style=3D"direction: ltr;">&nbsp;</div>
</div>
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"width: 100=
%;" align=3D"left">
<tbody>
<tr>
<td style=3D"background-color: rgb(255, 185, 0); padding: 5pt 2pt;"></td>
<td style=3D"background-color: rgb(255, 77, 77); padding: 5pt 4pt 5pt 12pt;=
 width: 100%;">
<div style=3D"color: rgb(34, 34, 34);"><b>Caution:</b>&nbsp;External email.=
 Do not open attachments or click links, unless this email comes from a kno=
wn sender and you know the content is safe.</div>
</td>
</tr>
</tbody>
</table>
<div><br>
</div>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">Hi Clement,</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">Exactly, copied from PCIe spec:</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">Max PASID Width - Indicates the width of the PASID field suppor=
ted by an applicable Endpoint Function. The value n indicates support for P=
ASID values 0 through 2n -1 (inclusive). The
 value 0 indicates support for a single PASID (0). The value 20 indicates s=
upport for all PASID values (20 bits). This field must be between 0 and 20 =
(inclusive)</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">BRs,</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">Zhenzhong</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<div style=3D"padding: 0in 0in 0in 4pt; border-width: medium medium medium =
1.5pt; border-style: none none none solid; border-color: currentcolor curre=
ntcolor currentcolor blue;">
<div style=3D"padding: 3pt 0in 0in; border-width: 1pt medium medium; border=
-style: solid none none; border-color: rgb(225, 225, 225) currentcolor curr=
entcolor;">
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; fo=
nt-size: 11pt;"><b>From:</b>&nbsp;CLEMENT MATHIEU--DRIF &lt;clement.mathieu=
--drif@eviden.com&gt;<br>
<b>Sent:</b>&nbsp;Wednesday, February 25, 2026 2:42 PM<br>
<b>To:</b>&nbsp;Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;; qemu-deve=
l@nongnu.org<br>
<b>Cc:</b>&nbsp;alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; ms=
t@redhat.com; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; sko=
lothumtho@nvidia.com; joao.m.martins@oracle.com; Tian, Kevin &lt;kevin.tian=
@intel.com&gt;; Liu, Yi L &lt;yi.l.liu@intel.com&gt;;
 Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid b=
its size check</span></p>
</div>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">Hi Zhenzhong,</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">&nbsp;</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">Why do we capitalize the first le=
tter of each word in &quot;Max PASID Width&quot;?</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">I guess you try to match the pcie=
 spec, but just want to confirm :)</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">&nbsp;</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">cmd</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">&nbsp;</span></p>
<hr size=3D"2" align=3D"center" style=3D"margin-right: 0in; margin-left: 0i=
n; width: 98%;">
<div id=3D"x_divRplyFwdMsg">
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; fo=
nt-size: 11pt; color: black;"><b>From:</b>&nbsp;Zhenzhong Duan &lt;</span><=
span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt=
; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margi=
n-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA08dc35b5-67=
38-5ab5-0e95-3532dc072319" href=3D"mailto:zhenzhong.duan@intel.com">zhenzho=
ng.duan@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&q=
uot;, sans-serif; font-size: 11pt; color: black;">&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;</span><span style=3D"font-family: &quot;Calibri&quot;, san=
s-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: =
rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLi=
nk" id=3D"OWA118b68cf-1199-59ca-940a-1336596294b3" href=3D"mailto:qemu-deve=
l@nongnu.org">qemu-devel@nongnu.org</a></u></span><span style=3D"font-famil=
y: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&=
lt;</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font=
-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, =
134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA=
3dc5d203-2d83-6f78-e6bf-5a447fdc0a95" href=3D"mailto:qemu-devel@nongnu.org"=
>qemu-devel@nongnu.org</a></u></span><span style=3D"font-family: &quot;Cali=
bri&quot;, sans-serif; font-size: 11pt; color: black;">&gt;<br>
<b>Cc:</b>&nbsp;</span><span style=3D"font-family: &quot;Calibri&quot;, san=
s-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: =
rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLi=
nk" id=3D"OWA9f48be26-e2ca-d8f2-745a-6951a578c800" href=3D"mailto:alex@shaz=
bot.org">alex@shazbot.org</a></u></span><span style=3D"font-family: &quot;C=
alibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span>=
<span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11p=
t; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); marg=
in-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA94f47cfa-f=
545-5724-3968-5b084bf3166a" href=3D"mailto:alex@shazbot.org">alex@shazbot.o=
rg</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-seri=
f; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA7c5=
63483-6158-5438-314d-615ab1f1fb30" href=3D"mailto:clg@redhat.com">clg@redha=
t.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-s=
erif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=3D"font-=
family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: rgb(70, 12=
0, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-=
bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA14282776-a215-662e-026e-b6cf7d=
93211d" href=3D"mailto:clg@redhat.com">clg@redhat.com</a></u></span><span s=
tyle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; colo=
r: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAc48=
7e0e5-1421-90b6-6f4e-f6415cdaffe0" href=3D"mailto:eric.auger@redhat.com">er=
ic.auger@redhat.com</a></u></span><span style=3D"font-family: &quot;Calibri=
&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span =
style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; col=
or: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top=
: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAfa57599d-57e3-2f=
54-8aa5-ad8a93ffd894" href=3D"mailto:eric.auger@redhat.com">eric.auger@redh=
at.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-=
serif; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAb2e=
67c6f-3ef7-5947-fa1b-68be6631a6c0" href=3D"mailto:mst@redhat.com">mst@redha=
t.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-s=
erif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=3D"font-=
family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: rgb(70, 12=
0, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-=
bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA45ca960d-611b-868b-6b18-97b268=
bd6eb0" href=3D"mailto:mst@redhat.com">mst@redhat.com</a></u></span><span s=
tyle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; colo=
r: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAc49=
e3897-024d-a779-70f1-40f81cf3738f" href=3D"mailto:jasowang@redhat.com">jaso=
wang@redhat.com</a></u></span><span style=3D"font-family: &quot;Calibri&quo=
t;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span styl=
e=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: =
rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0p=
x; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA4afe3a84-18fb-13f5-a=
7d5-8776e0f278b3" href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</=
a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; f=
ont-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAabd=
b415a-dd79-c3cd-37ce-358f1f368ffa" href=3D"mailto:jgg@nvidia.com">jgg@nvidi=
a.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-s=
erif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=3D"font-=
family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: rgb(70, 12=
0, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-=
bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAe800c5b6-f11c-b4a9-d5a8-33bbef=
084466" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></u></span><span s=
tyle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; colo=
r: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA913=
8bad2-0cf3-b0bd-219f-368eba00e037" href=3D"mailto:nicolinc@nvidia.com">nico=
linc@nvidia.com</a></u></span><span style=3D"font-family: &quot;Calibri&quo=
t;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span styl=
e=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: =
rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0p=
x; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA6e34645b-0525-af77-7=
821-e16f6b34c64a" href=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</=
a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; f=
ont-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA428=
53f6e-1396-1f99-7463-f968e15e502f" href=3D"mailto:skolothumtho@nvidia.com">=
skolothumtho@nvidia.com</a></u></span><span style=3D"font-family: &quot;Cal=
ibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><s=
pan style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt;=
 color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin=
-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA5ca1c6a5-d47=
b-461f-ed92-06806744a692" href=3D"mailto:skolothumtho@nvidia.com">skolothum=
tho@nvidia.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot=
;, sans-serif; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAbfe=
f9744-ded5-d1d2-8780-250cabf3aff6" href=3D"mailto:joao.m.martins@oracle.com=
">joao.m.martins@oracle.com</a></u></span><span style=3D"font-family: &quot=
;Calibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</spa=
n><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 1=
1pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA1d4fbb20=
-c9bb-679c-9682-425beb342802" href=3D"mailto:joao.m.martins@oracle.com">joa=
o.m.martins@oracle.com</a></u></span><span style=3D"font-family: &quot;Cali=
bri&quot;, sans-serif; font-size: 11pt; color: black;">&gt;;
 CLEMENT MATHIEU--DRIF &lt;</span><span style=3D"font-family: &quot;Calibri=
&quot;, sans-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=
=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=
=3D"OWAAutoLink" id=3D"OWAe9105c98-f0c2-43d2-fb52-08c31760b340" href=3D"mai=
lto:clement.mathieu--drif@eviden.com">clement.mathieu--drif@eviden.com</a><=
/u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font=
-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAfa3=
30a6e-0ca2-1935-e429-586da6dd5162" href=3D"mailto:kevin.tian@intel.com">kev=
in.tian@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&q=
uot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span st=
yle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color=
: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: =
0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA5250a72f-6c98-f9f7=
-ad57-329a4444d89a" href=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.c=
om</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-seri=
f; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAfb8=
8f86d-ef03-3cb8-b64b-c0139cc8909d" href=3D"mailto:yi.l.liu@intel.com">yi.l.=
liu@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;=
, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=
=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: r=
gb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px=
; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAbed593db-77a1-8ff6-55=
66-39606ff58b7a" href=3D"mailto:yi.l.liu@intel.com">yi.l.liu@intel.com</a><=
/u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font=
-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA335=
c2b05-2046-d33d-7b4f-28d72b9b6502" href=3D"mailto:xudong.hao@intel.com">xud=
ong.hao@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&q=
uot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span st=
yle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color=
: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: =
0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAfcbcf54d-54fa-3950=
-022e-2edbb1e276e4" href=3D"mailto:xudong.hao@intel.com">xudong.hao@intel.c=
om</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-seri=
f; font-size: 11pt; color: black;">&gt;;
 Zhenzhong Duan &lt;</span><span style=3D"font-family: &quot;Calibri&quot;,=
 sans-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"col=
or: rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAu=
toLink" id=3D"OWA50f87c23-c554-acc0-b1a2-e949ccfc4678" href=3D"mailto:zhenz=
hong.duan@intel.com">zhenzhong.duan@intel.com</a></u></span><span style=3D"=
font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: black=
;">&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits =
size check</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
</div>
<p style=3D"margin: 0in 0in 12pt; font-family: &quot;Aptos&quot;, sans-seri=
f; font-size: 12pt;">
<span style=3D"font-size: 11pt;">Caution: External email. Do not open attac=
hments or click links, unless this email comes from a known sender and you =
know the content is safe.<br>
<br>
<br>
If pasid bits size is bigger than host side, host could fail to emulate<br>
all bindings in guest. Add a check to fail device plug early.<br>
<br>
Pasid bits size should also be no more than 20 bits according to PCI spec.<=
br>
<br>
Signed-off-by: Zhenzhong Duan &lt;</span><span style=3D"font-size: 11pt; co=
lor: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-to=
p: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA66d0e964-58bf-1=
e9c-cad3-e15d84b991f7" href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.d=
uan@intel.com</a></u></span><span style=3D"font-size: 11pt;">&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 +<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 5 +++++<br>
&nbsp;hw/i386/intel_iommu_accel.c&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&nbsp;3 files changed, 14 insertions(+)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index e4bcc884b0..e5518a94ea 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,6 +195,7 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
+#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 6483cb3d85..c1b31b17de 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Nee=
d to set scalable mode for PASID&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pasid &gt;=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID wi=
dth %d, exceed Max PASID Width&nbsp;%d allowed &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;in PCI spec&quot;, s-&gt;pasid, PC=
I_EXT_CAP_PASID_MAX_WIDTH);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;svm) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!x86_iommu-&gt;dt_supp=
orted) {<br>
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c<br>
index acb1b1e238..15412123d5 100644<br>
--- a/hw/i386/intel_iommu_accel.c<br>
+++ b/hw/i386/intel_iommu_accel.c<br>
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp; HostIOMMUDevice *hiod =3D vtd_hiod-&gt;hiod;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct HostIOMMUDeviceCaps *caps =3D &amp;hiod-&gt=
;caps;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_hw_info_vtd *vtd =3D &amp;caps-&gt;ve=
ndor_caps.vtd;<br>
+&nbsp;&nbsp;&nbsp; uint8_t hpasid =3D VTD_ECAP_PSS(vtd-&gt;ecap_reg) + 1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIBus *bus =3D vtd_hiod-&gt;bus;<br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIDevice *pdev =3D bus-&gt;devices[vtd_hiod-&gt;d=
evfn];<br>
<br>
@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /* Only do the check when host device support PASIDs */=
<br>
+&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp;&amp; s-&gt;pasid &gt;=
 hpasid) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID bi=
ts size %d &gt; host IOMMU PASID bits size %d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, hpasid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (pci_device_get_iommu_bus_devfn(pdev, &amp;bus,=
 NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Hos=
t device downstream to a PCI bridge is &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unsupported when x-flts=3Don&=
quot;);<br>
--<br>
2.47.3</span></p>
</div>
</body>
</html>

--_000_AM8PR07MB7602232CB25D963A887E9B018672AAM8PR07MB7602eurp_--

