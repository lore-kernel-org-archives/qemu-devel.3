Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56351C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 14:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPNpp-0007sv-5M; Thu, 04 Jul 2024 10:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNpl-0007sV-KB
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:53:19 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sPNpi-00064g-Sm
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 10:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720104795; x=1751640795;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=P3HTSzhviE3BnRb2hjl25gS24uGPnMVMnYbsibQcyQI=;
 b=pUMpRQSG8VkmVhtOsYouQMDnYotn+bzCw1yoAFlzEAF7MQbGJWQBtAPh
 x/bqOv+WRa8bvPTDiVuklQO7fsAh90FlrzhyfTP6ploREu8f3unoZPlAJ
 jNsN3+bjT+Jm+Mnfd82CD2LSvIu3wlI+DGj9j6DtIkqNDcD9Tnx0pqZwN
 rbu0maczunJdN4J6Vu2/DmM4KnQHebo+pIe9VhqF4YisnOqLllawsJ2dO
 zAIZw/vV7BVQ1myrdX19ETsbl/iBDFbi6ItKLM5W399+RpeNjHomFNx3u
 fad6AeWNKfnkCE8XlCBMNYacu0AVNKCv6tMpGBqeC/YSaZc7VH3M7vqwy A==;
X-IronPort-AV: E=Sophos;i="6.09,183,1716242400"; d="scan'208,217";a="16006175"
X-MGA-submission: =?us-ascii?q?MDHJxTBs3mOyWZtwkvrtlRwzaEKswXhvIef01E?=
 =?us-ascii?q?A+QqG+6iKBGUXMkvupEwpc8HmThkKnNK2lWLRK/7sVxJ8wOdpMbiZRlV?=
 =?us-ascii?q?zomm92du1WsW2A6pzWzq8Wvi7DEwYdr6i0reXgWXr9L2BKxiIylMBSFA?=
 =?us-ascii?q?t0jOqYPrRRmWEbgBIYlOmT5g=3D=3D?=
Received: from mail-am6eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.111])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 16:53:12 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFuBG7IZdG2goSsgOt/SIxHBYCp5kA58RYG9SOfq6eQ1kKwDMfKV148drV/pvuFU5QhJftCzFrMHD+7CDKiD/GHF/qxc1mFHW7GMRLdfiO4YOxfYx0WCToGipteXwiFJrX9Z+EOckPjHN8gNeCGNhbPimmkDS8PrKNMwnoJZa65+Vrd4j9vMNAl/jgNdTrt1UdR1sF0NSaMo0A5f1uRaQ58f3EulxhWUjf9OADPNr8mLn6vjg5RbY2Z3/AxJR5WoT1n86dbOWtUJHLHGSJEh4+y6jRUDUwiUs9T9HRHCEcb+qDZ2u3cbymhdo7Nj9e3/PtTs5OOS9/41BtM+3DLgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYjoqbSyetueROgQGu5fhldm6ZK0Gv6tKQn3PW5Qp04=;
 b=ER4dZk86YJXENtGyluqDeqqcaRvhZ/x29EaAraabB4zuS5heTh9X9hgyAcCW20nnF+flfSC6s4myYE86MaE4fz7Ebnl1p7A2ALSFLsrIN3IQNuCHCf98Vp5s7H5y4qk2u0cpmU2vh4z+7LmDk+vVmG2Um3QU0yWxjJMRSMioS6czr2reWF0SlwmVfdFvA2qcsqNGcu5P6ol5rqigE2wlVKT6H2p3gCLCzBaIhGgKAzj7pzkSyenXQe18Yr3vOEwcPlzcNhV3KRJ6/AUFeIWHjYNeXJ6BNBEbTkveI5Sei7daRpmZnt4zA5fhkHBexdRZyu1+6AdwALHPJwo6mB99KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYjoqbSyetueROgQGu5fhldm6ZK0Gv6tKQn3PW5Qp04=;
 b=lQukPEaHAVIOC+rOxf+dkyGbyp117i2U/OJNOJ0n5xSefdf5JB2DYRNfkA+ptkofkn3xLWDCsXINHIhW1iisESp+Avg0zE5JkirN+Z1+I+W149jojXo/a8yLzGL5Q65z6E30m2Dso7raCu1V+JU2Z98NYdyJNK1ESgyAnhjtYEb+q8si1MagZlDtVGNlb641CItykpvbGMRVN3y5PXw+Fz21xBLMGxkRhRL+5VDmTjuqxniM/15vrsR2FO515nJ6IFzOld+LbJ3XHmBFmi2ug9eTQwaa0Sr54NchaR2I4PzuMTFTehHEl6ZRqk90uEYS0gJ0xjl/DcihYe7v69otag==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9856.eurprd07.prod.outlook.com (2603:10a6:102:38c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 14:53:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 14:53:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, 
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v1 0/8] PRI support for VT-d
Thread-Topic: [PATCH v1 0/8] PRI support for VT-d
Thread-Index: AQHasoxiO6+dgN7t50iro7G2HPLUFrHmUH+AgACNeGc=
Date: Thu, 4 Jul 2024 14:53:09 +0000
Message-ID: <AM8PR07MB760289BC5E2BCEC556BB300986DE2@AM8PR07MB7602.eurprd07.prod.outlook.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
 <20240704022318-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240704022318-mutt-send-email-mst@kernel.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2024-07-04T14:53:09.749Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=0;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9856:EE_
x-ms-office365-filtering-correlation-id: b3672930-dd0c-4c12-ad21-08dc9c39058c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?dKk4bhfOp72d9LdB5C4bMsoT89PHtuOzMwInNWeBzfbP8R/4V7CfTC6oC0?=
 =?iso-8859-1?Q?GVYoAPb3FClr0BstEOVxbAzL8qRAqNosTY1p48tEWGm+YA6ZuBToUy2v1Y?=
 =?iso-8859-1?Q?vpChpo7X8GofaOEfbD+bz6aY/98GDs0hlWKPFsUNrhy9HxekQrwrEF0dhb?=
 =?iso-8859-1?Q?B/vyTvJBsL3b5SRMPiVWOwHziZIIxdyCPYqlQlLel+7lxu40FF7lp0liZc?=
 =?iso-8859-1?Q?ClfXyqgXnaODW84Uf4KxqKwquagrLqr3yoMXLSQiVbL8rtmTywtnFLlRfq?=
 =?iso-8859-1?Q?MiULZQZMYsviWV+4x3hlEpTOF0FSK1mZOOmzTWPiBo37gendq3cX7nZZ5a?=
 =?iso-8859-1?Q?QoVUes/6EfBjTxWL/y60GUVGdn2AGIaKb0zDCV/EBb7IxmzqVBczOpe9RP?=
 =?iso-8859-1?Q?ESMxfnAiJSY0mD1m1+DpsWX8HdDHtrn3EPaFQG8mfER/3S80DW7evRFu1P?=
 =?iso-8859-1?Q?7fzj60BHfIPB3/t4T9CoL0yeiu5Z3lyKL1WszbAaVyqw2vMukP6ZI/1umc?=
 =?iso-8859-1?Q?vE2fOBVJSOEP2IahER0gNec1egBEwztBbY1znc7HGgodoA3V2Zd+CzXfJa?=
 =?iso-8859-1?Q?pGqqWCqyeTQOj+tQFDBftRhjb58KkDOr0raCMltPHtFwpvoT+J12AByjcB?=
 =?iso-8859-1?Q?sPOaKWXzimYRDMhK4UuQoyX6IDNUE4PuwMBfBGMsGMDTGdSaC+lUJrSeqe?=
 =?iso-8859-1?Q?KTdfX4nnH50lG/j5gzmCRq8U9aEC89UKkmi4dWgVMtoCs5Vx3p/+1KYxnw?=
 =?iso-8859-1?Q?rvOXBhczakp5WxgSminlIgKXjtK1srcb9FUWw1flAGPAnzh2uYZtOAfyGH?=
 =?iso-8859-1?Q?ZVCi8qcL/eiIOVD92L8Wnq99EzdZoaJicV8ZOXYz5H4ZZkhrM9NZnlsQRA?=
 =?iso-8859-1?Q?q8XwPXGOUPiaY0Ryy28rm5a7JJ8Y09e9SoEaqWLd+SJf8C3YqYlejKGuOz?=
 =?iso-8859-1?Q?/tw28pHtVTVyYud3WCiMB5GjZEukGQWncJfcV+G3+WT/07WjE1FTQrpAgW?=
 =?iso-8859-1?Q?IKiaHjbkdIycJn8e3+HxRW3MCjyvWK8rGYjKRS7/5r3p+LJMZKXL9jK+Wg?=
 =?iso-8859-1?Q?VS5eSLPb2Dn6tXB3P2/0PHWtlwQqYUB5warpXQsk5/lhquqXOCgrDYUP/x?=
 =?iso-8859-1?Q?pC5kpDq+k6JwCKmc+nfrSukWRt0TOh7IiNdXNZiSs/RydHWhPY+VobBuBW?=
 =?iso-8859-1?Q?es+IslJIRGoRjjL1Dch+Y8SrsUrl55/x53A4zVa/Q6o4rMmqkxvBhUOkDd?=
 =?iso-8859-1?Q?2JRpgDnersiukSxVUDWCr9HL8CyjX914VUOmHgAHbAH81WAVsm8x6mxURl?=
 =?iso-8859-1?Q?/cEOdPDzWbpDRxyZpZ/hZS+IAp9+S78Pd1NA2myehBSynkPoUceB4mshaA?=
 =?iso-8859-1?Q?lR06+5SmImUPfBEQIOcihqVptkFZry2xieWrK9q0AP5GbyQ5n9hVQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xeLCDJwiDBtKnCd6Aod2JLZEST/OtfBLd4YtQu60ceTDo4FzE0NBKj1HFM?=
 =?iso-8859-1?Q?+GN+hf/nXzRRHz1RGaBjkDf/osyVnF+pl87ykUgnkjqxyC+P4Gi+5VSSSM?=
 =?iso-8859-1?Q?eWVCa028V6iKu5G+ZEgVDSsm8cf6kqmLsr3jQsflsIRU1Qck446xhj/XlG?=
 =?iso-8859-1?Q?lat/1KD6lSTJmtCvlExnOYe8jqNho9zeRh+Ff3pfYNkMo41+nZT7ly29Ov?=
 =?iso-8859-1?Q?YV2s9bWYb6o2TzCidUDvEpA64nvdwucIjo5M5syRx7L4DPABgOqF16pjIY?=
 =?iso-8859-1?Q?efZuJQWw8cykYXxiDCkeA2gFUf9tX3hoNJc8MY0+4wfdcOSUlvRAEZdSFG?=
 =?iso-8859-1?Q?nTksLGr0dUTyZv35/qJHKxLQK8CZLQxBeSzSZqlyKFVlnoKaayYNe8IVH/?=
 =?iso-8859-1?Q?FZvEoFkMtRJtF3dIJm4vnLeDs2wzi5BZNNiK0CzVcBzCzY2LRIxekrs+G3?=
 =?iso-8859-1?Q?cUFRrkZ1T9q2qf7I3AUYS0vOdb0gCXEJTJqKf/k2XL4vv8SLUQDIDE9qdg?=
 =?iso-8859-1?Q?qgd98KD9c2d/Zdm4pmL6GrVStTcbRu3aEQ4BKQKsbjedhOOgtqvmkND0U5?=
 =?iso-8859-1?Q?1OPlm+byubKj/V/P3KAp6FKGQZmlklucAFBXmdZk+5P4oCjjSyZSnAWYlx?=
 =?iso-8859-1?Q?sCDdEtF4jlJpRxqfaWUJ4kk/6kAZhMl5nR6RFRQ9hbZBUzdf/9KmjJ8ZiZ?=
 =?iso-8859-1?Q?WLKRuH6+6vwNbRfMfTPM4EMGrv0an7tsVygJMEskFUJOLN38RzvslJxXOH?=
 =?iso-8859-1?Q?R/PqSysjUVwRhxgrk8Ma84qEpFi8eQ5UVOeRrTVrWmudE4C2Nk7AyLvV9Q?=
 =?iso-8859-1?Q?CNTlThBB1cmADSHl9NYkY7SrUY19Gz+zvOJhOuGC+ARKm7Bt0DFT+1PRlR?=
 =?iso-8859-1?Q?aRXmh1bp8llH1iyNcnLQXTCANcXzUD/CXnHzXvbm1140R/WoeHmuiPLmAW?=
 =?iso-8859-1?Q?xiIu0hMBV6byouEUzKPhNDopW0RgaUzHUatSEhPYLAdJySuk38mWGZnZRW?=
 =?iso-8859-1?Q?L+TKMb0pktpTr69nnvBevZ1JwIt0baasUDrIXGlIJXfIgSNUssZRBQIera?=
 =?iso-8859-1?Q?inW2Mx0m6ph8figFbbXIiYA+skuhfJ4lN311kFppf7ZBMQNdlkeduAV0z6?=
 =?iso-8859-1?Q?ge2L7j9B7ehqN/NqCsn0lYHe5iejOlU2QXFg7WeXI3eXpPXur0cpPErDY8?=
 =?iso-8859-1?Q?wv4WdgZU/+1KKEAuXbt4i8d8POSBMCAp4t+OAXwaWJCJB2FX0dCUsZw8XT?=
 =?iso-8859-1?Q?LAGKOwZJIlZ0HU7GiASklXIQdnbzSuVKZlSl9L+rzeIpwmoqUgLr8upEbz?=
 =?iso-8859-1?Q?JbhpuoKv14BbI+eW/ayRlVd6w8SK45IkRyjD8kmknHGwpG2rHCL1LPq7F1?=
 =?iso-8859-1?Q?5XhIxUS0Gr5bNMgyed4A/wGlA77uOaCm4y1ku1DANECWre3KkrFBWmlSzA?=
 =?iso-8859-1?Q?DEtHPxBYuAeHqEI9KQCyk/63CMFKtC7gsgfPJwccnTgd5HJZF69Hnx1PpB?=
 =?iso-8859-1?Q?F0QMUjvzZsXxF6ptdAE2rWnA/C2aCJeNRVqYWTzAwFy77VN4F9ErIYFpy6?=
 =?iso-8859-1?Q?RDqFa4y988i1EeCD7bLyRX9cLegiktSKSO37xSU7g03A+vQv4STdMrFlwB?=
 =?iso-8859-1?Q?H7Ek21q8xBF8lYJzzxk2dhvGK6QrQP+iSoVp1pBPOFAofi1QzqGLs199bB?=
 =?iso-8859-1?Q?kNmqp454zJTExlu8QXfWP2E+fymH3/JX5qTcURloQc7riBkRSS22NA07Kh?=
 =?iso-8859-1?Q?UMWg=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_AM8PR07MB760289BC5E2BCEC556BB300986DE2AM8PR07MB7602eurp_"
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3672930-dd0c-4c12-ad21-08dc9c39058c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 14:53:09.9834 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZshdmxOwntRaRx8kgKQCtTsxUkuue/bMKSceyBeMjL6vbW/IOOnJD6F/p8/M07R3aRUz9ti+t/MnHahLazVj7Q+BRiE40SNckkVEZKEYQ0EssNNJJ+LyFmsKclXjx72j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9856
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 HTTPS_HTTP_MISMATCH=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_AM8PR07MB760289BC5E2BCEC556BB300986DE2AM8PR07MB7602eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Michael S. Tsirkin <mst@redhat.com>
Sent: 04 July 2024 08:24
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jasowang@redhat.com <jas=
owang@redhat.com>; zhenzhong.duan@intel.com <zhenzhong.duan@intel.com>; kev=
in.tian@intel.com <kevin.tian@intel.com>; yi.l.liu@intel.com <yi.l.liu@inte=
l.com>; joao.m.martins@oracle.com <joao.m.martins@oracle.com>; peterx@redha=
t.com <peterx@redhat.com>
Subject: Re: [PATCH v1 0/8] PRI support for VT-d

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


On Thu, May 30, 2024 at 12:24:58PM +0000, CLEMENT MATHIEU--DRIF wrote:
> This series belongs to a list of series that add SVM support for VT-d.
>
> Here we focus on the implementation of PRI support in the IOMMU and on a =
PCI-level
> API for PRI to be used by virtual devices.
>
> This work is based on the VT-d specification version 4.1 (March 2023).
> Here is a link to a GitHub repository where you can find the following el=
ements :
>     - Qemu with all the patches for SVM
>         - ATS
>         - PRI
>         - Device IOTLB invalidations
>         - Requests with already translated addresses
>     - A demo device
>     - A simple driver for the demo device
>     - A userspace program (for testing and demonstration purposes)
>
> https://eur06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2FBullSequana%2FQemu-in-guest-SVM-demo&data=3D05%7C02%7Cclement.mathi=
eu--drif%40eviden.com%7C0b2efce63b3b400a2a9408dc9bf1f45c%7C7d1c77852d8a437d=
b8421ed5d8fbe00a%7C0%7C0%7C638556710682005347%7CUnknown%7CTWFpbGZsb3d8eyJWI=
joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&=
sdata=3DQzUQdYTeIxZ0poSL0MvM2x%2F8ar4R%2B7YioDTO3WQeFAU%3D&reserved=3D0<htt=
ps://github.com/BullSequana/Qemu-in-guest-SVM-demo>


To make things clear, is this patchset independent or
does it have a dependency, too?

Hi Michael,
This also depends on the ATS series (which also has dependencies itself).
I will make this very clear in future versions.

> Cl=E9ment Mathieu--Drif (8):
>   pcie: add a helper to declare the PRI capability for a pcie device
>   pcie: helper functions to check to check if PRI is enabled
>   pcie: add a way to get the outstanding page request allocation (pri)
>     from the config space.
>   pci: declare structures and IOMMU operation for PRI
>   pci: add a PCI-level API for PRI
>   intel_iommu: declare PRI constants and structures
>   intel_iommu: declare registers for PRI
>   intel_iommu: add PRI operations support
>
>  hw/i386/intel_iommu.c          | 302 +++++++++++++++++++++++++++++++++
>  hw/i386/intel_iommu_internal.h |  54 +++++-
>  hw/pci/pci.c                   |  37 ++++
>  hw/pci/pcie.c                  |  42 +++++
>  include/exec/memory.h          |  65 +++++++
>  include/hw/pci/pci.h           |  45 +++++
>  include/hw/pci/pci_bus.h       |   1 +
>  include/hw/pci/pcie.h          |   7 +-
>  include/hw/pci/pcie_regs.h     |   4 +
>  system/memory.c                |  49 ++++++
>  10 files changed, 604 insertions(+), 2 deletions(-)
>
> --
> 2.45.1


--_000_AM8PR07MB760289BC5E2BCEC556BB300986DE2AM8PR07MB7602eurp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Michae=
l S. Tsirkin &lt;mst@redhat.com&gt;<br>
<b>Sent:</b>&nbsp;04 July 2024 08:24<br>
<b>To:</b>&nbsp;CLEMENT MATHIEU--DRIF &lt;clement.mathieu--drif@eviden.com&=
gt;<br>
<b>Cc:</b>&nbsp;qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; jasowa=
ng@redhat.com &lt;jasowang@redhat.com&gt;; zhenzhong.duan@intel.com &lt;zhe=
nzhong.duan@intel.com&gt;; kevin.tian@intel.com &lt;kevin.tian@intel.com&gt=
;; yi.l.liu@intel.com &lt;yi.l.liu@intel.com&gt;; joao.m.martins@oracle.com
 &lt;joao.m.martins@oracle.com&gt;; peterx@redhat.com &lt;peterx@redhat.com=
&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v1 0/8] PRI support for VT-d</span>
<div>&nbsp;</div>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;">Caution: External =
email. Do not open attachments or click links, unless this email comes from=
 a known sender and you know the content is safe.<br>
<br>
<br>
On Thu, May 30, 2024 at 12:24:58PM +0000, CLEMENT MATHIEU--DRIF wrote:<br>
&gt; This series belongs to a list of series that add SVM support for VT-d.=
<br>
&gt;<br>
&gt; Here we focus on the implementation of PRI support in the IOMMU and on=
 a PCI-level<br>
&gt; API for PRI to be used by virtual devices.<br>
&gt;<br>
&gt; This work is based on the VT-d specification version 4.1 (March 2023).=
<br>
&gt; Here is a link to a GitHub repository where you can find the following=
 elements :<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - Qemu with all the patches for SVM<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - ATS<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - PRI<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Device IOTLB invalid=
ations<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - Requests with alread=
y translated addresses<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - A demo device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - A simple driver for the demo device<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; - A userspace program (for testing and demonst=
ration purposes)<br>
&gt;<br>
&gt; <a href=3D"https://github.com/BullSequana/Qemu-in-guest-SVM-demo" id=
=3D"OWA5a3ea03c-edcd-fe90-8ce5-226a7825daf2" class=3D"OWAAutoLink" data-aut=
h=3D"NotApplicable">
https://eur06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.=
com%2FBullSequana%2FQemu-in-guest-SVM-demo&amp;data=3D05%7C02%7Cclement.mat=
hieu--drif%40eviden.com%7C0b2efce63b3b400a2a9408dc9bf1f45c%7C7d1c77852d8a43=
7db8421ed5d8fbe00a%7C0%7C0%7C638556710682005347%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7=
C&amp;sdata=3DQzUQdYTeIxZ0poSL0MvM2x%2F8ar4R%2B7YioDTO3WQeFAU%3D&amp;reserv=
ed=3D0</a><br>
<br>
<br>
To make things clear, is this patchset independent or<br>
does it have a dependency, too?</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;">Hi Michael,</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;">This also depends on the ATS series (which also has dependencies itself)=
.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt; color: rgb(0, 0, 0)=
;">I will make this very clear in future versions.</div>
<div class=3D"elementToProof" style=3D"font-size: 11pt;"><br>
&gt; Cl=E9ment Mathieu--Drif (8):<br>
&gt;&nbsp;&nbsp; pcie: add a helper to declare the PRI capability for a pci=
e device<br>
&gt;&nbsp;&nbsp; pcie: helper functions to check to check if PRI is enabled=
<br>
&gt;&nbsp;&nbsp; pcie: add a way to get the outstanding page request alloca=
tion (pri)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp; from the config space.<br>
&gt;&nbsp;&nbsp; pci: declare structures and IOMMU operation for PRI<br>
&gt;&nbsp;&nbsp; pci: add a PCI-level API for PRI<br>
&gt;&nbsp;&nbsp; intel_iommu: declare PRI constants and structures<br>
&gt;&nbsp;&nbsp; intel_iommu: declare registers for PRI<br>
&gt;&nbsp;&nbsp; intel_iommu: add PRI operations support<br>
&gt;<br>
&gt;&nbsp; hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; | 302 +++++++++++++++++++++++++++++++++<br>
&gt;&nbsp; hw/i386/intel_iommu_internal.h |&nbsp; 54 +++++-<br>
&gt;&nbsp; hw/pci/pci.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 37 ++++<br=
>
&gt;&nbsp; hw/pci/pcie.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 42 +++++<br>
&gt;&nbsp; include/exec/memory.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 65 +++++++<br>
&gt;&nbsp; include/hw/pci/pci.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp; 45 +++++<br>
&gt;&nbsp; include/hw/pci/pci_bus.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 1 +<br>
&gt;&nbsp; include/hw/pci/pcie.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp;&nbsp; 7 +-<br>
&gt;&nbsp; include/hw/pci/pcie_regs.h&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;=
 4 +<br>
&gt;&nbsp; system/memory.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 49 ++++++<br>
&gt;&nbsp; 10 files changed, 604 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 2.45.1<br>
<br>
</div>
</body>
</html>

--_000_AM8PR07MB760289BC5E2BCEC556BB300986DE2AM8PR07MB7602eurp_--

