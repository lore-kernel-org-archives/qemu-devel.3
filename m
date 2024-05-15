Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27070C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s78qe-0004cO-7W; Wed, 15 May 2024 03:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qM-0004Yq-IJ
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:31 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s78qK-0000pL-DX
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1715757268; x=1747293268;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SQ5EBdFXBuQPjyxJF1qpaAn6WNCxfDRml9Uogf1wA/I=;
 b=BWjSXCCiec6Nr6CeMtLvrFPqSpDPx/AlEjn193vhbKm5nD3YKNOa3TWN
 56yyVJAFtkd5JnUyxpPhyJDRZXCnPT9mwP9FkMqv0SdIoZ/NnBYaQF9wC
 ZiUGguYPni7MeNmbfyAl/fvvwf7A67xAWe69eYY5rp+t8b8XkCqPZpNSX
 UYNMKgD/GK+3kjm6EL0+fmvyZi8cPVjLe58tyj1hhBQQt3Pfupg2RBOXI
 Stm0+SMbyUMttYdlQcuKgFhXtcdoMnuuXMHuRZppSkAxW3I7Iz0funvTo
 QV1cFYb/nzIaTRlTLoKCbXiXKDzEA50xtU5WSMULGOHMsC+b3xVbiay43 A==;
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; d="scan'208";a="12580203"
X-MGA-submission: =?us-ascii?q?MDGmmE3d3CIwkf1cumBBYKB2oqcPqbu27qHwj2?=
 =?us-ascii?q?Xe0VMpFj7mUOp7kJqZ2ldy5Hb3eaj/clZbhKRKCAxVg4iNYmB+TchwJX?=
 =?us-ascii?q?P27wQuQk/IbN6UYGk6eqskXMGufHZ4ofE0ugo2g7Wynns/4SXE0c/Qrc?=
 =?us-ascii?q?4YZDTleeRH8vombqGtOUxNig=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2024 09:14:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4iohuzC7IeprcSgpY8NW5EByn+7Lt89/nwjx8QdNcPAgV5wmfEwimd5vRbHkS6ANLx+yrmOo6Y/VloISN3z+jmYzkRVVWvMosi3qJVz8A8ipuZn1VPTKujGG6IDF9o7hZZIexMQ9Y4ZR9Mn4u2EcF4rpSmt10GMbiyJ1QIO+Pw73vcwFt19bSP4ZHDWL83gzctFJeK+HGUqQ+Y9hOm+157pZgrTL6lyobNU9xYybv/PWWlKEiE37dmEkoixqlPsIZOrYF5HfuWxnR0y8ca9Ap5SGrjBAUsPUtDbqtbXS9hT3Bj9A83Y9cNnyJwncuxBSsEx6eEyLp/k2FolMyXhKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ5EBdFXBuQPjyxJF1qpaAn6WNCxfDRml9Uogf1wA/I=;
 b=nEUR/8HanKdMf27mfDfpd6q7Q4CrGq6fF7rP+tXypodmvmgCfmMTiwQfEcqoTeWm1zWbV+pEqlMPOqzO4uffXOe1SwWRecwGxF4nx1xRI9XArJIexrKIF+rafz6nXWSVFqpDnwOQf/QCpjtEAvPPp0S0MsTvL8pRfRtya4wa66jUjCO+2lAeYAATrm5DdFOxdmKL/zRkkFoNnvoRJYM+n7pJfwdpwd1EE3II9dcW/FtzunwrtYp/HGueI2jLLuuStQ/dj4JjPMb5rRyiHmQrvRArR4OL+fQFoJf7MTE37pIwmBxjwj00jfzrHOr8b8Efw+jVmskhNdazxERoY+5iZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS5PR07MB9896.eurprd07.prod.outlook.com (2603:10a6:20b:676::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:14:16 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7544.056; Wed, 15 May 2024
 07:14:16 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v2 11/25] intel_iommu: declare supported PASID size
Thread-Topic: [PATCH ats_vtd v2 11/25] intel_iommu: declare supported PASID
 size
Thread-Index: AQHappd/Z5e9p1ha2ECfEwYekTPbnA==
Date: Wed, 15 May 2024 07:14:16 +0000
Message-ID: <20240515071057.33990-12-clement.mathieu--drif@eviden.com>
References: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240515071057.33990-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS5PR07MB9896:EE_
x-ms-office365-filtering-correlation-id: b29eab28-4e97-4db6-5656-08dc74aea1d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dUFMeWxqNVdBTEliT2JnZDJtRURSbVpWd1hiWkJSenpxang0S3EvRW1vMmd5?=
 =?utf-8?B?RElta1lSa05yVHZEcFU3Wlgvb01ZYTR2VEd0alU5Yml5ZWtreXE4cGZJdXhR?=
 =?utf-8?B?WDdRY2U1aHNwQ0VKMUdJeHo3WUU3N1dCOXRHZ3lJeVRxRGYwR1JsbCtpVDdB?=
 =?utf-8?B?ZDVLZkt1RnJNdUpBY1NsdmdPeDhldG5PMjI0R0pyN2RrVzMxd0NjWGEwZERY?=
 =?utf-8?B?cCs3SU9aTm1mYjVaODN4UWQvM2N2alJObXdVNXB4cnRpTk9uc3JGejBaL2NP?=
 =?utf-8?B?L0JUcEJoZEw3aXFMZkJ5RkMrS3pSUjBLOFZxOHIvR1duWGthYzMvcDBGd2Yr?=
 =?utf-8?B?aDJrZ0hTcmp4OEZhNnR6UVhDL2NWUEt5MzZwUnp2aEgyNXJmdmtweG5uN1BJ?=
 =?utf-8?B?RVNaUGNJQlZIQ2p1bG1Va1hmb1VndWxUTXdHSzd5OXduVHZEeC9GVngrZFdS?=
 =?utf-8?B?aWNxL3d0RGhRMlB4S0t1MHozRlArK1RZaXd1MG9HWTVWVEpMVitMazlwQzhB?=
 =?utf-8?B?L3ZVRTA0c002LzRuM01sVlZjOFROTGVJeEkwczVWTXJ3eUVOSXAvc1hFc09s?=
 =?utf-8?B?ZEVZUFQvVnhnZGhPL2J3ajZSTEE0d3FVU21hVklZaTV1QktXb0p1aW81MFNC?=
 =?utf-8?B?a0pYRFNzLzZYdFMrODdHNXZTMDhjalZhMW52b2ljS1hCZ0ZEd1NQOGRUcFZW?=
 =?utf-8?B?U3JwTkd2YXY5QS9tRFVDa28xMGQrUzZqOGhyRmxxQUZNd3ZHUVlPMzRhczRx?=
 =?utf-8?B?THh0TFp4bWYyNU1sOThmbnZhYjdwK0ZrZFpLaWpoU2xEZVhUQllYdU9iZzZv?=
 =?utf-8?B?QnZmZGNLcVB5OHl0S1ZVL2xxemw4NzF1Mk4wdUVsYVgvTm9EL1dLZ2Fac0pZ?=
 =?utf-8?B?VW1KcFlLaXo4ZGdscmhRS0MwMHBjTmFuSkRCelo3TXpzSllodGVQVlRKR0lo?=
 =?utf-8?B?WUFiWnIwa2dYdjZ2VXZNWEM5Z2lRaE1ORUdPMDVvTlp3S2NLc0J1THZMd2Fy?=
 =?utf-8?B?YnNJSUhZUFRtQjYwNDNuZzczVVBUcE9lSUwreGNOYXdKbDl5UGRhTTVVUGsy?=
 =?utf-8?B?Y25tSHgySzQzcDliVVJLMGd2alpEVnNkZVNWTWl1T01ERDNucUM3S3Y2SVh6?=
 =?utf-8?B?OXFoVkN4WG9QQnY2VHR4NGQ2VUpIY1hySUpkSlNZbk5kOVY5NHY0L0ZoZjZP?=
 =?utf-8?B?emxhTXd2UmhsdlVpbXU3RjhRRlB0TmNpZUh2MzVzOW8yeHAxRVdEb2JlVVN4?=
 =?utf-8?B?TDM1N0ZscWVZQ0R0L3NpcFFac1lpekFpZ2FYSTMrK0s1R2FMdGFjNEZNNWlz?=
 =?utf-8?B?TUdKd0pqT3dNSENHU0E4Tlc0ZUViMU9kZ29nRFdBVUQ4Q3hISUIxR0FkRHBi?=
 =?utf-8?B?ZnZkalpHU2VPeHNXSTArYmtKN1JTcEEzS05mYWVqNk5WZjNVeEhYSUFkZk9u?=
 =?utf-8?B?UW0zKzc2VnlZNmlPZEszNzR1dkVGRVgvOXFmZ1h0OVlHd2JqNDhIYjFQS1dJ?=
 =?utf-8?B?WVZWdXVmaTk1S2tlN2I4V0kwTmxqUmFBUXl2M2tnYnZWb0hkQWdZaFgremdl?=
 =?utf-8?B?OVpSN0ROeHI1OXQ4T2prK01PS1BETmZqYUlKU0Y5SUZ6RldWRk5pTEVFZVov?=
 =?utf-8?B?Ri9wOHRyMit2NXBMTGl3Ti9RZ2RScmxJMDYrR1c1NCtkTzNJc0djSU84VXhm?=
 =?utf-8?B?WFQ1a0VoZlNLbkE0cjJjTjIrY3VMYmQ1UzNldS8zOExxaCt2bTM3Ukt3Z3F4?=
 =?utf-8?Q?dtrkpzbOCJWN4XPNrPW5GbH5hiHi1jwnBA2zkcL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXdsdEViUHdiVFMyalVCMTNYS1JuVG1sckJGekhjbThKem56WUVhV2FOLzVQ?=
 =?utf-8?B?Ylg0amxxa0FtUmlpUmdNS1NuZzdkZ29xS3FqcDQxSXFkT3N4d3ExRDN3WlEr?=
 =?utf-8?B?NHBoQVljYUpDZWU2ek9CMkdzVURYRTN4S3Y5UVVydm9rOWx1em04US9pQjlv?=
 =?utf-8?B?OGZxSDFNQ0N2aWdFb25rMEVqamlrdTNDQjlhWUNFVXJyRytCdStKNjBMQkN5?=
 =?utf-8?B?VUNyUG45K3ArS1FDZ0E0OStHT1ZjTzcrYm1FaVhmYUFPUWpENk9rN0lrYjZG?=
 =?utf-8?B?MXZlbitHQml0dnpocXREdHVqcjFheHZNVHNUMVFoNWwxUUdDOFRYQzQyRFBZ?=
 =?utf-8?B?ZldDL0h3YkVhUnVLdUhhOWExTHVLSFJPV3Rib0hsTHBsaG1WRFZNUGhMWDh2?=
 =?utf-8?B?N0g4NjdwaXBuVWFqNDRXeW40Ky85dFdwdXVGSlhJdmpDZ0FDTCtPazQvWnBt?=
 =?utf-8?B?L3k4ZU5nK0VTV1M4VnN6MklnZytxdW54WVRBaTg5YXdkODBtZGMydENxWjFU?=
 =?utf-8?B?N2dHSW0wL3MzcnhKcE5lWmI0NjZrQUdZdVZ6eXltOVVvV3NDQjV3QnVaeUl4?=
 =?utf-8?B?VzRzZE1ucHprSXd2VGt5ck5Kd2JpbGxBRGMxWTkyU2xXZlR2bVo5MDBEekJr?=
 =?utf-8?B?aXhDM3B4U2Z6Ty9ZcDVzL0lBb3VHdnI1eVlTWkpOYk9VcE4yTDRKMS9FcVpU?=
 =?utf-8?B?eVVpdTMzSGRpVjB6RVh2MmtvNklaSlArZ3VJcUNIU0tzdDdJZEJsQ3ZheGw1?=
 =?utf-8?B?U3RhNXQwQXBlWmw5c0ZUbWI4aXVKYm1HTFowZDJUREJqNGt6dHljVXRHZ0VF?=
 =?utf-8?B?VzAxRlRFYVR0cTV2cGhxTVVtUmdHV01EbzZialJybHlCV3hNaG93dmpxVTd1?=
 =?utf-8?B?c1lPdWUyMndsZGtZRDBrdFZzNmtmOVZEeGplN1d1WnQ5VU9MdEt1SlpuUjNF?=
 =?utf-8?B?UzlSNFVWMm85SzhEUzFUYVJUcnk3dWUwWmprdEtzYWdNQXh6d2daT3FHMG5j?=
 =?utf-8?B?bEVnRDdWeFFCOGNjdDhiT0YvWWlqaGJ4N3hVMmNFYW5meHo4VnkwL2RyQ3Vj?=
 =?utf-8?B?Z2ZQMzdzWlpvU0I5RjNLVTA1SjN0b1cwK25jV0NZZmJsUXpMV2IzTE4zay9w?=
 =?utf-8?B?UzdRd1dNNDJtdTRlYjJRN0MvbWxjaGo4QkNWYjl2a3hoWnMydC9TY3FRRVdX?=
 =?utf-8?B?eDJNeS9TdkJ0bzVqaEFNTE9DYktyZDN5blphMFIrZnRSU0ZQQ1lzT3RxcDh6?=
 =?utf-8?B?NTlqUWFjRjdxanF0ZytmenRpdSs2T2VRaklpamlPTTZDMWliVFhnR25Ta1ly?=
 =?utf-8?B?dEl4VVQyOGE4c2pjb1R3YnZQWUNqV29lRDljVERNcmpBVFlWTnNLUXNHNjBZ?=
 =?utf-8?B?NHJ6aDdrT0dDMEhUVE1HdUYxRnVwbDJ0NkhLSG9iZjZGdnRtbS9WTlh3ZW1O?=
 =?utf-8?B?aVJ0b1ZNSXdabksyN09TK1NQVVVDMWF0bmdSL0NmT0dOKzJkUzdIUlJkMmpD?=
 =?utf-8?B?NVJoM0xmU0hTd1BQY01SWFpDNmZHMWFjbUhpSm1ZUGI4ZGVrVGgwWGt2MFdS?=
 =?utf-8?B?dFIwWWdINGdiRHUvcUdRVTBpS3o4MTUzVnpsSHhqWlduY1ZnOVNubTlDZWNT?=
 =?utf-8?B?d2ZydVNVSENvcmYzeEd0azVSa3VObHR2VTVaaTFWK0xWOG5VdEdsYlVBVjFU?=
 =?utf-8?B?LzkyYUI0SlovQmlBSWZBUEVweEZ4eFdvVVkxYWJTV09heE9tS2JMYStNTTQ0?=
 =?utf-8?B?bzh0d2tDcmxLTTFUTnlxT1BGYlg2cEhyQ1JUanZheE1OQUhld2NGTVVORDZ2?=
 =?utf-8?B?Tkp5UkpwQXc4RHVwSGc3RGdCZXArR2NQV0dnaUN1U3JjTXBUaVZQbTErQU93?=
 =?utf-8?B?Q2xPcEtLbmFqUjZEWVlGcVlURkJ5ZGd1M3JNMis5Wmo5OXpxVmFwSFRqM1A4?=
 =?utf-8?B?RU9hVURJaWFHQk1Cd2U5Q0wyMStkVUZLMWYzb05WVWZjOWJQNmJoWXNOcXhO?=
 =?utf-8?B?Tkczc3l1aXFsdFlhMVhHT1JOTW1zSzFXcXAvbjdweEJSUGFzbDN0QU5CMVEv?=
 =?utf-8?B?N2ZFVEdOWmtrVlNSZkQwaWtWd3FsK0VWL0thUXhDNnk4VGZDVURQSlcvMjNi?=
 =?utf-8?B?bHdnQzZpc2doaXQxOVgzeHlvc1BLRGdPekM0MEFOZW05R042Q3ZlOElJZGV2?=
 =?utf-8?Q?csrjASE546EzpKitL1NsbpQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <332E853495862B4F889502CA941A0127@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b29eab28-4e97-4db6-5656-08dc74aea1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:14:16.7389 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDilii34Hk1qpaHqYN7OrvgHpFE2nVXwDPnjJfpNSmWzBP9frYgK40numFU03By3xX3OhgiLSh7L5w0I9xAlOLtHNRipXjr5CEX2dMca/+LTCh06tp5p7ThQGdMqBasm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9896
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCAy
ICstDQogaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgMSArDQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KaW5kZXggMzczZjNkMjU0
YS4uM2JiNGQzODVhOCAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KKysrIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQpAQCAtNTgxOSw3ICs1ODE5LDcgQEAgc3RhdGljIHZvaWQg
dnRkX2NhcF9pbml0KEludGVsSU9NTVVTdGF0ZSAqcykNCiAgICAgfQ0KIA0KICAgICBpZiAocy0+
cGFzaWQpIHsNCi0gICAgICAgIHMtPmVjYXAgfD0gVlREX0VDQVBfUEFTSUQ7DQorICAgICAgICBz
LT5lY2FwIHw9IFZURF9FQ0FQX1BBU0lEIHwgVlREX0VDQVBfUFNTOw0KICAgICB9DQogfQ0KIA0K
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggMTQ4NzlkM2E1OC4uZDYzZmYwNDlhNyAxMDA2NDQN
Ci0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtMTkzLDYgKzE5Myw3IEBADQogI2RlZmluZSBWVERfRUNB
UF9NSE1WICAgICAgICAgICAgICAgKDE1VUxMIDw8IDIwKQ0KICNkZWZpbmUgVlREX0VDQVBfTkVT
VCAgICAgICAgICAgICAgICgxVUxMIDw8IDI2KQ0KICNkZWZpbmUgVlREX0VDQVBfU1JTICAgICAg
ICAgICAgICAgICgxVUxMIDw8IDMxKQ0KKyNkZWZpbmUgVlREX0VDQVBfUFNTICAgICAgICAgICAg
ICAgICgxOVVMTCA8PCAzNSkNCiAjZGVmaW5lIFZURF9FQ0FQX1BBU0lEICAgICAgICAgICAgICAo
MVVMTCA8PCA0MCkNCiAjZGVmaW5lIFZURF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVMTCA8
PCA0MykNCiAjZGVmaW5lIFZURF9FQ0FQX1NMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NikN
Ci0tIA0KMi40NC4wDQo=

