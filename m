Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD5FFD461F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 06:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvUtp-0006l4-Ve; Thu, 26 Feb 2026 01:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vvUtf-0006ki-Bx
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:30:53 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1vvUta-0000cm-Cf
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 01:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1772087446; x=1803623446;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=lSR+RZ2P4poLpiha/TF+rSewta/DRQJKIa84ZMcY1qM=;
 b=Kp0bMMkhxHoea7qkpk2p1+IGZI2hKT2sKAUxs7mok2x7fQrTV0RS40D1
 NzopZ8sAMUjjEOAMm1qTrjsMipIbFGqgrmObN/APHSchUfPbCfmHGxF1E
 xh5llRNJ1dS4jrF7Bm0mrPMrNdAtQCnWLPK3bZ+0/cVX420CLA3BkLexh
 Yt3rnWqk7H3pFPN78Fck8sGoAXhsHNZcd3XMlynMFk5/Q+L3ceF8cxmLm
 CyPfjT5E269Qv5JlBIM5U6FUV3TBDRNWoJNZJJGYhCN+rsLUMitszNK4i
 fYxEKzpHiScoTcsoENy4h7Mxac1kQKPlFTkJRVCppwEv8FU7ppvh4OXwP Q==;
X-CSE-ConnectionGUID: rXbgpXnJRcuizlL+zeWxxg==
X-CSE-MsgGUID: zpWIUsgLRsaxLj8Dkz99iw==
X-IronPort-AV: E=Sophos;i="6.21,311,1763420400"; d="scan'208,217";a="46673817"
X-MGA-submission: =?us-ascii?q?MDE2JkgNbKp/dP1k6OcIJe3RjduLMIL31vm9xF?=
 =?us-ascii?q?pZcVibzyzFeYxng52TlaNYPnI5PBquDpPafFjdYrXySpKHqmPcFSnWu3?=
 =?us-ascii?q?q9jHBOdNjuYWCtGSpe4qEiUfdhGnEPCgCx+5XlrpF5Phhe8YRBbg94Fp?=
 =?us-ascii?q?dh41VjnUHCHSowQreSZ2UGgw=3D=3D?=
Received: from mail-francecentralazon11013024.outbound.protection.outlook.com
 (HELO PA4PR04CU001.outbound.protection.outlook.com) ([40.107.162.24])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 26 Feb 2026 07:30:24 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wnxoIxbYnYFIodO4YGOV4yIndaMez/9qhNFsVhumt/jx8A8Qj5/SrSDPkyGNOxYJO9tacGDQ6KmaU7zCoG35RyJKpFGxGPBX5N9/PSV0JkYAuYF3zyP6T5ySZhfTC6taSiDfdRdmoKWJGc2MeQuyzBCygD9SYMbaF+mJFrmp/956+PMWJuAzHK/QOAGBAwvg6ERPtYn5JvKopS2elewZ4L2zzRKURXpTFxyvYJmDgnWtigsHfEVWgpzcNj5KNG2XBUczoiPCFI3jRsnRW7w1qw+7IN/4JQy1YJgz0du/dQwnh7sMMG7bCG35mijlVqrVbOjf8YkCHboPEaB2g2C9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kq18suP8i7tfuIjNPwNszjNrIPvVRGE78vIiCb4ltLg=;
 b=PL4YtJydlvcmdrMEppLSzZbYQgRWdNvPzQcCXerBWvtmUqyhaQA2EovLj4BX4scwYsPEiL9QmIULlZZwBUENzjILAga1lNbjEcP7Jb4M1HbM6O+5tFE4d/coVS6AnuQ8kzZpc1si4edj0VPdyWNFY4PIsloxp+17NvUefOudgz8YUpPa7V8x2uK3s4pM0ecAs383qlp/PiRsekrbU2QDF32pPONcAYTsFTji3CmGw0ezwDoJ69xuZc4Jl2v1q8XUlLj2Q047DHSsXXZap+dJ+nEl4B1sLB+aDe6Ifjg992UQcGiuVv9wkrte/ER0Tyf/+2uL1VZgnSxR5FUyxZjtjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kq18suP8i7tfuIjNPwNszjNrIPvVRGE78vIiCb4ltLg=;
 b=NzYm/KGspIsJmHK2l7+kje6kxIFeEcWZULEAUP/p7WOW7ewjyFMsoLKW1QFD0FUfQ+sCnPSPhfOfR6XeculQ4R7ljzse1/iizTR0Hy5lrIBLSCflTjRfb+cXJaAq8V/j8H+3IrjbahBjDB5/xTW75l1wulEuDSskLoU5gIKHjCJystnYC9bddsaNET/sYTxfRJkOyQ1yOSatbP/eXiNv1XcY+ifoh2hLM3VSyEC0OiWAigRUSahd4MdL3DuFa2RBNg6pEK5veolaIwL0JD3CMyoMtdjUFQ3aBO2F5vdakkQdW5J9eEBHYspskbGAQ33NDdcp7rgwVWHINI6Jssgxug==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB9233.eurprd07.prod.outlook.com (2603:10a6:20b:5ee::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 06:30:20 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9654.013; Thu, 26 Feb 2026
 06:30:19 +0000
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
Thread-Index: AQHcnWP20QrD5iQNmEWrT+7sB8IeqrWTBqiXgAFaEYCAADPJMw==
Date: Thu, 26 Feb 2026 06:30:19 +0000
Message-ID: <AM8PR07MB76026D37748B1BEAE5713C2D8672A@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
 <AM8PR07MB760213E1A9BBE02E443F9CD28675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
 <IA3PR11MB9136ADFEF99A8AD8220F497A9272A@IA3PR11MB9136.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB9136ADFEF99A8AD8220F497A9272A@IA3PR11MB9136.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-26T06:29:55.338Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB9233:EE_
x-ms-office365-filtering-correlation-id: 9c7fab72-441b-452a-1509-08de75008365
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|18082099003|38070700021|13003099007|8096899003;
x-microsoft-antispam-message-info: aWTeeU+b9RZdXqjBIsEk50Gf4QDfICZQ7c6LlOebCtEZwejRRTfVTVKMz3wmEv08ILlLL2Udvi9a2emb9mz8tgzY+SIkB2e3Fc/lHBeIJkDnl1e/3W/4Y0xrDEQ83ne9FeGfjcJVic6ZnDzhhV6dk4HFEslt8Z+xQ2DqeU2peVTa3H9vLtGndjp7B9EgG947o0TGkDn8jdGypfWMCDsWZjQPBunjnTqpzn4LJKnWzgcfkedOTv3pHCteMyqOtdq3XLjZW2Gw7idHdTAdf0FqjPw92WSK8Hv6B2Ls329+SSYkV/TNPb+uCKkuH8+NsnBIjWLWEYk1YJ1bj3rNK90m1IGSEadL7QmO7YuYwYg0qSS5oM8CStR8o25qtpzEDyPNSLpe332ADyoYD/XDhsq3bUIQecU2HtNNMUwydNmlTXbgDC/eRlrv9gTslj6jh0za5YuTHNCMHPZC9eMjDQPKqwkF40OT2G1A+tOQJsDK3WVJp3WvJrtz28la2EIq4SpCk3Rn+juvS0N508eZ7xrUcwk7niCKWwDjEJTD5REfcoHmjFxXYmAl8I5uQe4POfbHomtwc8G8AddI+714bMRf1S/Dtd7OHv5bHwoZWkDhaDNLlm0+1q/6IKb5EHIGBZLTj8P8RLztrpUZSNS3Un0VKkYI/iFjE7hw/S0d7tuWtYZ95poPVbXZ8kWx/wuAFICzaaqN/E7ISR8Z2CyJCRozLOoE9cFtP6Fo8ifZQOXnzjevuN7uYQOvJ6pDFNP5jGhZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(18082099003)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?X7QLrxr6op+C7tI3b13E85iIYNnAma6ZG2jsB2jRWnPkJ5llakI1eY1S?=
 =?Windows-1252?Q?oRMROAwkOV4PyViIpbpj/910Jf8LJ8J3g7klP3P77u9saqXkEkxZfaFq?=
 =?Windows-1252?Q?1yJ7SczzPRywNuCUDwBzG72chm3UjHd3EAqV5iOFz2OGo0nGM3zUyXln?=
 =?Windows-1252?Q?hr5AAue0LJBug+3AB1VJfoi9QhBu9IBK8sSbDmbHi95EAgCR3dOqFZlI?=
 =?Windows-1252?Q?qEZVzJUOjlDgtmleSn/Dj8rHUCE2ZNzf5UDkqODIr0nqWbDpjuST17bQ?=
 =?Windows-1252?Q?YxOEu4nL2a9J6ClLySQ8BjMJUD1OaKVOHfQ8hyNMWovhCwTpI/Evk+rx?=
 =?Windows-1252?Q?e4nreDL7egVDbLrYUlzfQbb/4gglLFe4uhDNoxnjdu17gSCE5dE1TFI+?=
 =?Windows-1252?Q?08xXM9VQ//Jm2bpVFxo2JKgo7VqtX2sYPYOtvOh/Ynx+3bFES0O2Fp5F?=
 =?Windows-1252?Q?KA7tx3MmBaESI1FBbBGmQfRggPJaMQRc4HceAfW1g1mcUCYD2f5RbDJV?=
 =?Windows-1252?Q?pNiSg1gdXKqBzK6xcH1aKXIqs5rIwI8ObUp9xZTM8CwXVTvOxSSdv4bA?=
 =?Windows-1252?Q?YGe1N80dgijmvA+PwSncSmtS3NubC2q0x+gas5TJnkpueHY9OjQFWGyX?=
 =?Windows-1252?Q?AWa1L/6L6vYRMIvxNCUWCSLMqmkVoeZK1+Hn/sAEQbstP0GWNP4scbBs?=
 =?Windows-1252?Q?lK/G2Xy1fvvmz+20pVov08Sooh/rszOXz4vUbuPMohxK5Lvgcj23IG/d?=
 =?Windows-1252?Q?H5yNXrZTnMiPR5XlO7pUFsImV4flXPwaQ7I9ISWsUn7CnK6SK3oGgJbC?=
 =?Windows-1252?Q?/FRgY6UZ95LEnGNbT6kh1gvN2CIf+shQNjEG7excQ4ls0+E3mwg6aSch?=
 =?Windows-1252?Q?B1NqBYrVdG+VyP6odWapj1XmWweyWU/24Szcn9adkeQDT2nbNMZHBiEj?=
 =?Windows-1252?Q?vG2086rNYGtjdbgQ0j3lpJ0ZnQmcNB8sMZKFxvNfVVO6NL69Arjv0IwN?=
 =?Windows-1252?Q?9RnL5Rh3ddd4ZT93RbKTd9bgcLfMVFIVe9c3uvM+uSa4CdtmpFwxrmen?=
 =?Windows-1252?Q?uvsTStNd+1surzeicKKIhANjc0kbuC/LId2TEF6lkuFfHPPqCX9uPc55?=
 =?Windows-1252?Q?3jzp2WzFeAyW4863RcHopUI7oJBkASItiUP5VUofqn0w6+eb11YJ1/su?=
 =?Windows-1252?Q?cKtYyZEYVQmy2DEP1iq9wmRPr2qwAtVRfA0l+YudpOPC+wXmDM/I6yzd?=
 =?Windows-1252?Q?sMuFXYZBYJg3bIZhk/rpITIybp/a/pqChpid5W68d4ma9CAQaXysQjEv?=
 =?Windows-1252?Q?cy+t6Nr7xsN0B5wCJH1BdNwL2gVagizadaHaKaqF+4biSG/vTN9L7htw?=
 =?Windows-1252?Q?sSBuy+/+k6zzhGFE13WV3fgdRx1kzelT63plk2xCfr9jSzuHtMzDnZ8c?=
 =?Windows-1252?Q?Ba1UwvU1j8cw5LLize6A0LaUJK35mOt7fClX6pydu3sfbzPGlpcqcmC2?=
 =?Windows-1252?Q?SbSdBygZ1wY8Py3oGZuU51E5Un2bq0hcHEvfIyUG0FKo//jkT1LD6S02?=
 =?Windows-1252?Q?56l9bJpf+sNYwXHKb0tjSty3ITUk8q2oWEaTxze2NhaT1Z9+4jPDolif?=
 =?Windows-1252?Q?H0YA6fLHx1v+ECx1xGYwztt3p0gUKUSOdRnh0VrOhXM5g0AEyDPj/rO2?=
 =?Windows-1252?Q?Q07FIFpxz5srAy78XdyZ4291YgEFJra/T8Z+FMuu0zCBz0Nu2dWGh5FX?=
 =?Windows-1252?Q?QVZTU5kGVzZ6o9y11rmD1NL1ziCqr4Mv3O5FUUGlV4hUffJVkMnuLMop?=
 =?Windows-1252?Q?uAe0iqxW3vjWD+PLWPudZGF3yHqwQACvysAW3gPVpHitQnc5ezeBk7aR?=
 =?Windows-1252?Q?V/EZIz60clD+SCoHm0q5+58kqshN73ebmxI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB76026D37748B1BEAE5713C2D8672AAM8PR07MB7602eurp_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c7fab72-441b-452a-1509-08de75008365
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 06:30:19.7546 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmB0EBbIdHh+qqXyBEVF23gOdU0qIi1CJuBF6RX7sVKSvKjt47uXM4on4oTlFytEsXO+NMWySz+uX3yXJZFL6QVUCuDx00Cz1nfTgkUSdPRVh3yP91XeBMxtIsyAjtci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9233
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

--_000_AM8PR07MB76026D37748B1BEAE5713C2D8672AAM8PR07MB7602eurp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi Zhenzhong,

Oh ok, I did not remember this comment from Eric, my mistake.

From what I see in the smmu:
- "getters" use extract and are named according to the field they extract.
- "setters" use deposit and use the following naming pattern "XXX_SET_THENA=
ME"

Do you think we should follow the same way?

cmd

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
Sent: 26 February 2026 04:12
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



This is to follow Eric=92s suggestion in previous iommufd nesting series

where he suggested to use extra32/64 syntax, copied here:



+#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)

+#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)

+#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)

as those are values for the granularity field using



VTD_INV_DESC_PASIDC_G_* look relevant to me.



I think you would gain in readability if you adopt extract32/64 syntax

like in hw/arm/smmuv3-internal.h

Looks more readable to me.



See https://lore.kernel.org/qemu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b=
@redhat.com/ for details.



BRs,

Zhenzhong



From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Wednesday, February 25, 2026 2:38 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@redhat.com=
; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothumtho@nv=
idia.com; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Li=
u, Yi L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck



Hi Zhenzhong,



I'm a bit confused about this patch.



All the other VTD_ECAP_* are masks for the ecap qword.

The purpose of this new definition of ECAP_PSS differs a bit as it extracts=
 the field itself :/



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

--_000_AM8PR07MB76026D37748B1BEAE5713C2D8672AAM8PR07MB7602eurp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
Oh ok, I did not remember this comment from Eric, my mistake.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
From what I see in the smmu:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &quot;getters&quot; use extract and are named according to the field they=
 extract.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
- &quot;setters&quot; use deposit and use the following naming pattern &quo=
t;XXX_SET_THENAME&quot;</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
Do you think we should follow the same way?</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
cmd</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg">
<div style=3D"direction: ltr; font-family: Calibri, sans-serif; font-size: =
11pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;<br>
<b>Sent:</b>&nbsp;26 February 2026 04:12<br>
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
ize: 12pt;">This is to follow Eric=92s suggestion in previous iommufd nesti=
ng series</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">where he suggested to use extra32/64 syntax, copied here:</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">+#define VTD_INV_DESC_PASIDC_DSI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; (0ULL &lt;&lt; 4)</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">+#define VTD_INV_DESC_PASIDC_PASID_SI&nbsp;&nbsp; (1ULL &lt;&lt=
; 4)</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">+#define VTD_INV_DESC_PASIDC_GLOBAL&nbsp;&nbsp;&nbsp;&nbsp; (3U=
LL &lt;&lt; 4)</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">as those are values for the granularity field using</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">VTD_INV_DESC_PASIDC_G_* look relevant to me.</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">I think you would gain in readability if you adopt extract32/64=
 syntax</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">like in hw/arm/smmuv3-internal.h</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">Looks more readable to me.</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">&nbsp;</p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;">See <span style=3D"color: rgb(70, 120, 134);">
<u><a data-auth=3D"NotApplicable" originalsrc=3D"https://lore.kernel.org/qe=
mu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b@redhat.com/" style=3D"color: =
rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLi=
nk" id=3D"OWA29bef391-7e0e-e2d1-56f9-96ebcd2abe21" href=3D"https://lore.ker=
nel.org/qemu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b@redhat.com/">https:=
//lore.kernel.org/qemu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b@redhat.co=
m/</a></u></span>&nbsp;for
 details.</p>
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
<b>Sent:</b>&nbsp;Wednesday, February 25, 2026 2:38 PM<br>
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
ize: 12pt;"><span style=3D"color: black;">I'm a bit confused about this pat=
ch.</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">&nbsp;</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">All the other VTD_ECAP_* are mask=
s for the ecap qword.</span></p>
<p style=3D"margin: 0in; font-family: &quot;Aptos&quot;, sans-serif; font-s=
ize: 12pt;"><span style=3D"color: black;">The purpose of this new definitio=
n of ECAP_PSS differs a bit as it extracts the field itself :/</span></p>
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
n-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA252209ac-9c=
12-9ed4-f1a6-1f8882dd0396" href=3D"mailto:zhenzhong.duan@intel.com">zhenzho=
ng.duan@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&q=
uot;, sans-serif; font-size: 11pt; color: black;">&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;</span><span style=3D"font-family: &quot;Calibri&quot;, san=
s-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: =
rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLi=
nk" id=3D"OWA76dc4cc4-fdab-7866-58bb-a35b1a150475" href=3D"mailto:qemu-deve=
l@nongnu.org">qemu-devel@nongnu.org</a></u></span><span style=3D"font-famil=
y: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&=
lt;</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font=
-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, =
134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA=
963bd230-899c-83d8-7f60-ade30c9f5ec5" href=3D"mailto:qemu-devel@nongnu.org"=
>qemu-devel@nongnu.org</a></u></span><span style=3D"font-family: &quot;Cali=
bri&quot;, sans-serif; font-size: 11pt; color: black;">&gt;<br>
<b>Cc:</b>&nbsp;</span><span style=3D"font-family: &quot;Calibri&quot;, san=
s-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: =
rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLi=
nk" id=3D"OWA74af7c63-041b-8cc4-cc69-5a12fe964b31" href=3D"mailto:alex@shaz=
bot.org">alex@shazbot.org</a></u></span><span style=3D"font-family: &quot;C=
alibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span>=
<span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11p=
t; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); marg=
in-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA926ab25f-2=
daf-39fb-f599-52ae3b58f3f6" href=3D"mailto:alex@shazbot.org">alex@shazbot.o=
rg</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-seri=
f; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA843=
8150a-5048-fd79-205e-f35ab6b7480b" href=3D"mailto:clg@redhat.com">clg@redha=
t.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-s=
erif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=3D"font-=
family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: rgb(70, 12=
0, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-=
bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAfd850818-fa35-6d45-fff8-c73ec1=
3e73ab" href=3D"mailto:clg@redhat.com">clg@redhat.com</a></u></span><span s=
tyle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; colo=
r: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA34c=
0a0f8-f8f3-b00a-b061-e0df185432e8" href=3D"mailto:eric.auger@redhat.com">er=
ic.auger@redhat.com</a></u></span><span style=3D"font-family: &quot;Calibri=
&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span =
style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; col=
or: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top=
: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA386b7a6c-df8e-3c=
7e-420b-1abb6f7f3ab6" href=3D"mailto:eric.auger@redhat.com">eric.auger@redh=
at.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-=
serif; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA8e8=
74d71-5dc9-b62b-1f29-122756adbd8e" href=3D"mailto:mst@redhat.com">mst@redha=
t.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-s=
erif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=3D"font-=
family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: rgb(70, 12=
0, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-=
bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAf4ffaaf7-3c3f-b551-0b9e-26c574=
e14ba1" href=3D"mailto:mst@redhat.com">mst@redhat.com</a></u></span><span s=
tyle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; colo=
r: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAa79=
eb40e-10c8-0b66-06a0-e2c308933437" href=3D"mailto:jasowang@redhat.com">jaso=
wang@redhat.com</a></u></span><span style=3D"font-family: &quot;Calibri&quo=
t;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span styl=
e=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: =
rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0p=
x; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA7195f45d-ebd9-175f-9=
843-67e1cb0f7887" href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</=
a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; f=
ont-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA2c5=
cf675-1b0c-745c-8b9b-91d93220703d" href=3D"mailto:jgg@nvidia.com">jgg@nvidi=
a.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-s=
erif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=3D"font-=
family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: rgb(70, 12=
0, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-=
bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA8c51eb01-06ad-6188-4e21-8b019f=
57314d" href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a></u></span><span s=
tyle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; colo=
r: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA039=
449b9-9966-da0b-2ee0-84469509a4c5" href=3D"mailto:nicolinc@nvidia.com">nico=
linc@nvidia.com</a></u></span><span style=3D"font-family: &quot;Calibri&quo=
t;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span styl=
e=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: =
rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0p=
x; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAd2959301-0ae2-050f-2=
5a8-0bcfb642bdc1" href=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</=
a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; f=
ont-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA9e0=
dcac9-4c25-eb4f-b1f9-386a2005a249" href=3D"mailto:skolothumtho@nvidia.com">=
skolothumtho@nvidia.com</a></u></span><span style=3D"font-family: &quot;Cal=
ibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><s=
pan style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt;=
 color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin=
-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA5fcbb80c-838=
4-2d28-0227-0d1b4c90ee96" href=3D"mailto:skolothumtho@nvidia.com">skolothum=
tho@nvidia.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot=
;, sans-serif; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA216=
ee08c-080d-40a7-45a3-cf9ccac74f62" href=3D"mailto:joao.m.martins@oracle.com=
">joao.m.martins@oracle.com</a></u></span><span style=3D"font-family: &quot=
;Calibri&quot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</spa=
n><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 1=
1pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); ma=
rgin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAf0581b69=
-2be5-911b-09f7-0a1981d4baa2" href=3D"mailto:joao.m.martins@oracle.com">joa=
o.m.martins@oracle.com</a></u></span><span style=3D"font-family: &quot;Cali=
bri&quot;, sans-serif; font-size: 11pt; color: black;">&gt;;
 CLEMENT MATHIEU--DRIF &lt;</span><span style=3D"font-family: &quot;Calibri=
&quot;, sans-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=
=3D"color: rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=
=3D"OWAAutoLink" id=3D"OWA10d67fb2-6df6-561d-1047-11efe7f0ebca" href=3D"mai=
lto:clement.mathieu--drif@eviden.com">clement.mathieu--drif@eviden.com</a><=
/u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font=
-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWAf18=
b2b71-c48d-d067-ebf0-c1004a171337" href=3D"mailto:kevin.tian@intel.com">kev=
in.tian@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&q=
uot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span st=
yle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color=
: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: =
0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA6dfcde93-720d-9c8d=
-948f-d18c14a08fd0" href=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.c=
om</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-seri=
f; font-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA251=
3637f-4ca1-1ea8-b0ed-3a6f44e53256" href=3D"mailto:yi.l.liu@intel.com">yi.l.=
liu@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&quot;=
, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span style=
=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color: r=
gb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: 0px=
; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA171115e6-dbb6-0fa8-a5=
f8-d02b8d94b102" href=3D"mailto:yi.l.liu@intel.com">yi.l.liu@intel.com</a><=
/u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font=
-size: 11pt; color: black;">&gt;;
</span><span style=3D"font-family: &quot;Calibri&quot;, sans-serif; font-si=
ze: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134=
); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA816=
af58e-4b83-c245-a347-138e0ad2c37f" href=3D"mailto:xudong.hao@intel.com">xud=
ong.hao@intel.com</a></u></span><span style=3D"font-family: &quot;Calibri&q=
uot;, sans-serif; font-size: 11pt; color: black;">&nbsp;&lt;</span><span st=
yle=3D"font-family: &quot;Calibri&quot;, sans-serif; font-size: 11pt; color=
: rgb(70, 120, 134);"><u><a style=3D"color: rgb(70, 120, 134); margin-top: =
0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA66396aeb-79a0-4080=
-29c5-c02e40652b83" href=3D"mailto:xudong.hao@intel.com">xudong.hao@intel.c=
om</a></u></span><span style=3D"font-family: &quot;Calibri&quot;, sans-seri=
f; font-size: 11pt; color: black;">&gt;;
 Zhenzhong Duan &lt;</span><span style=3D"font-family: &quot;Calibri&quot;,=
 sans-serif; font-size: 11pt; color: rgb(70, 120, 134);"><u><a style=3D"col=
or: rgb(70, 120, 134); margin-top: 0px; margin-bottom: 0px;" class=3D"OWAAu=
toLink" id=3D"OWAd122dc49-bd14-4c29-0165-1567ce3d52fe" href=3D"mailto:zhenz=
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
p: 0px; margin-bottom: 0px;" class=3D"OWAAutoLink" id=3D"OWA8144882d-8495-2=
846-a31a-95482dbad443" href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.d=
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
dth %d, exceed Max PASID Width %d allowed &quot;<br>
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

--_000_AM8PR07MB76026D37748B1BEAE5713C2D8672AAM8PR07MB7602eurp_--

