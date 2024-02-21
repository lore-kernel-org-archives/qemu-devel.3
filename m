Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A7EC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcu1O-0007wX-6m; Wed, 21 Feb 2024 16:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcu0q-0006l6-GH
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:20:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rcu0o-0001gc-0q
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:20:20 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41LJFk6H012189; Wed, 21 Feb 2024 21:20:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QGdbJErsuHWopLpQi46c8atYBPsj7ALPVr+YDhFusCU=;
 b=H84Fz/DHbb6KONxjX8LkNrqpN5QlswA9UbjKaI2SuHxufOzlN60GOujDoAIo/h5CgFAb
 wKUtItjqsCEytafxxurzGtmENgJ8xU34XLCPGFmzaueVyX7xJy5uEnShbH5SjQJTZ+H/
 ua2wmHxVHaIYdfOrIZ6Q3EqTbY02YfSmoeLRJxTchbJ0Wc9ynlPrOIfHEZ/dVyc4Tywp
 Ys02O6His11NOsxMkUXquKVmGqllw+XQjIaa55l7bm7oLdPO7oorrvUZef9D3SrRRMBh
 qhSbK9ZdZbXRRknYQJk7LKuBayipDmTpxCEXOkyFSp3/xhoGd6wWmIshj6QR1fxnhzxG sg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd5fw2m0n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 21:20:15 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41LKVao7032667; Wed, 21 Feb 2024 21:20:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak89nd8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Feb 2024 21:20:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTNOWoWP9QmXlT5DbRPK1EooZvKwgbyi5G2EgrhgodDUm6slJ9UHNpxjj6HHkKkO1trh2EMSVypspwJU50gVmLwYuGBYxjxlajQ3epPhkQ6N78y4+6Xz6Xg7i2lTRJzN/cDPg/vFTmYwyPkeZLLVfUXw+UnE+8m71amBb7HEMAU7OwrUQIyf3xPLmdqszFoBv4o70YF3CY/hmyXB+ZA+eNM8Q9vH1lmOcXi/FGubuiZdRAr9czsfV3OnlIHzpZj8bSrpDMmss/Qqx1AfYqg/wdZWl6DqLGH4N/fjGqooo2/BVPxy8G3Uni+fQM1ZIPg94Ai4trubvCW6UUtPDbNnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGdbJErsuHWopLpQi46c8atYBPsj7ALPVr+YDhFusCU=;
 b=I6Md8mbYjZXs+4/tCSA2WCMDp4+zLkQp1Jxpo9s9/HV3Yd+0vSHj08AmT5qEoxSt1kz6qt+oGtJ4ozDDiq2ux/p1oeIb0vYh48ljeAtq/5iTMgHb/WOxtRlanpzj2rj0S729SGwAqD0cA0YrxNdywkr4SGNHlTB5+yedXPlm2OTePkXJw418ubwkPBWZhIasBl0defPacHumlm+duV7hKqGRFBosnt7EFHhjsneFpn3Q6lkRNcddgxTw7DVJUPDeUrFAjAw7CkvltCWHQ95o1yZgFRpMgaiBYy1JqoYeeC+PBNnLL77XU7DXIPRaXWJs6dYwj4McfTP3LzUoSmsbpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGdbJErsuHWopLpQi46c8atYBPsj7ALPVr+YDhFusCU=;
 b=yQOL/fLegdB1uQlURPq1nPcP5/lqf9BSu5ahJwKohRU/5/kLP6U4gxQB5tBZy00w5NV5r7348IKmvToB+p6h3RIPA/2wFd47GEmW9HAeoKSplSj1jLAUzibrggbE7znxPURqnbhXlzlfTsOuCacI/95TS6qtXWdEDMjiEpmvV9Q=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO1PR10MB4739.namprd10.prod.outlook.com (2603:10b6:303:96::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 21:20:11 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 21:20:11 +0000
Message-ID: <91c57365-a61d-4ae7-bc63-454a39c1a6ec@oracle.com>
Date: Wed, 21 Feb 2024 16:20:07 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/13] migration: stop vm for cpr
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
 <ZdRVz7gvh-qGNxXZ@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdRVz7gvh-qGNxXZ@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0080.namprd05.prod.outlook.com
 (2603:10b6:a03:332::25) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO1PR10MB4739:EE_
X-MS-Office365-Filtering-Correlation-Id: bf59fa8b-e517-46af-ea19-08dc3322e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vonKl1d/utuh6KoEWV4xXHlyYUAb0xQAmdulbLK4X39U4k/BEd1NO8eq/Ib7ksZVhl+EjVVcYN386hlgycVakaBjWwXH9RTUZOKFNQ7yywjqAqgPIoGUcPvCSkOjK71ybdQuDiCBkGioGtxkW/RS2OhL4yPwhYNy1xBmfofo8Jqh+5yPw1B+r66IeQu7ELk5yCvYgr36eq/Yq4z/EU5eu4UVJ4cw7VO9kctCjjM4zAQ1K6PzwyurcTucj1YVthKeyESfk8juXSWtSXRIcF81G5eag68JOHQ7o5w8HlyQonTn/acKMQsjp9+ILjucpOg7PrmA6JtA7E5J4ILFWp5TMKo+YW5njvQQkySL7c8sFEFp/LCwdhBuXX40NNVNs/N6NyT/0oWZH1AavmD7jYTCMxyzL6rGmuTA2fz55Qr+IsJua0K0aAWYovqsuJq3h6j+7xdeP85mWJ+G2yhifBr2RTXrbpVIbPLgz7Kzrfw0LbEJJ0QZAY+YzDB7Tq6BcChRVnXzMXmo4GW/mpPDe4la6syUtMhpqzjO/0u4P4iCzcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVXWExad1lvdFVDdk1LeHVQUGw1d0Q3TnZHaXRmd3pKTC9NdW1ZNmo0TlJE?=
 =?utf-8?B?YTNaYjhET000eVliOG1OUFZqNWV2VmNjV2pYVXZMbWh5TmRDYVZLK3ljSzdL?=
 =?utf-8?B?VU9oRlA1bmdKWFQxa0FMNlZYVG1wd3JtaG5rVXZFUE1XMk50cUI5RGNOcnVJ?=
 =?utf-8?B?UFJTbmxjUlJDRWhYMm1CLzVDbUZwOSt5Mm9oNmVYK2NYSlU4MnhzT0FYN3h2?=
 =?utf-8?B?VWVpTUcyQTkzUlBlUWtaMWMycnFJb1hlK01uUi9pbWdZQnVzWEp3OTRLNXEy?=
 =?utf-8?B?eHhuK3RSSDFldUF5cHJHclhxTzdLSG9zNWdaei90UHlvUWpHbVdjb2hLSFVI?=
 =?utf-8?B?U1kyVlJIeTZZMGtBRFMrbjhUUTEwdGZUVlZwTTRvMHRDOGxpQ1ltZ3pyR2xm?=
 =?utf-8?B?RXNFWDV6TCtuRmFtZVR1L1M4RUpWL3VBRUg0Uy83TTJ1U2crRFhDOGU4YWtu?=
 =?utf-8?B?TjFYcG1PenVFSCtUblVEWGVHd2N0QWRPM2cyWlNialFUYmJlSVpYNVh4Syts?=
 =?utf-8?B?QkdOQ2hHVTA3Q3o4VzdkUi9Bem9Hd3BpbXZtclVjdkxLbEZvVVNnNC9OTkRS?=
 =?utf-8?B?YS9SUkg1Y1ovUTRHeUZRR2JxMitJVms1NnI4YWtNL0pzM1RjVGYwbWIzU1di?=
 =?utf-8?B?bEVBODY2TXBEalpTSzJ2Z3FBRldwQ3JBVUJ5NGV4c3BUTGZCaDRUU1NPWHdj?=
 =?utf-8?B?elhRdEhTVXB3MGtQMzY1a3kwa2FGRXBEdElWWW9jMlRhOXNnaW5NTmF4c3hY?=
 =?utf-8?B?N0FpZjVKaDRiSVUwdVQ1RGdVRGU5cmdvSWVhR1VhSnBoNEVTUEQ5dkd4Q2pZ?=
 =?utf-8?B?YjlQOWRIOEdvd3o3VjlHWDZybUpQdzZhZ0Q4MXJMUGJvaE1DUkRDYUlvd2J4?=
 =?utf-8?B?S3dlQnhwdlVWd2F6azdtMk1kMEg4S2lsL3Y4d2NIT25PQldHS29TWnVTbXFI?=
 =?utf-8?B?QmFEdzRSdW9Ed0gvWE9DTzdWMk1sKzRhbGU4TmhyUzMvb1BiTng5MFhmS0pC?=
 =?utf-8?B?NVRiV29Oa3BOK2RvcXB3cmNBUUFQbWRKY2xKM3prTDNOV29udFB4ZGxDQnJz?=
 =?utf-8?B?N01BekY1WnBCMG9BcUV2QUYzYUJEL0tIb2xDS3hjckZwUzh3Z3BLOGxvbGsz?=
 =?utf-8?B?dUF1endXbFZnVHd0TWtGdDlTKzE4RFBrSmFmSzFlb2JtWWZ0a0NCZ3Ftdkl5?=
 =?utf-8?B?bzFJZ3M5Y3dEcjFUdzQwZEQyRStPMWYxSXlReTdwdnIvbEJ5THpxUUhUOXE5?=
 =?utf-8?B?S1hKbzZEbEROdExXZzhvN2xsWklYV1pkQjBPd2dOb2UveWE0NnZWalNGQ3d4?=
 =?utf-8?B?MTRSUjNoWDNXc3d1clNuZHZyb0RVU21lWlQ1TWdDK3F4SzV0NnFDbW42LzZJ?=
 =?utf-8?B?RnhYTXFrdVQ4WUJ1clhiWmNTdWdzajFEMTVQRmVETHJMS2xyVVgwaFgzNzNt?=
 =?utf-8?B?MjBkRUZvU1dLaHlycmRIUGJKdjc3WG1aSCtEd1NBK2ZZWFJBdWxrL0FwL1pS?=
 =?utf-8?B?cHp5Z0llQXJ0OHhiSkpTUnUvSXZra0ZUQzJ5bklWRXRZUUZqL0ZQdjRrMjEw?=
 =?utf-8?B?RnpMdWg5N25LNURadlE3Z3JDbmg5Q2FxWWd0TGM4aG8xblVWMGFISGZHUGc1?=
 =?utf-8?B?VlRsWnYzbEZTTTMzb1Q3eldsUldtWGZjRDR3d2h0MUIyWVRqbnRYSnB5VWpt?=
 =?utf-8?B?MHhMSDl1M2I4bncxaCtmMCsxWXJ1TWVLTSs2S1dBaWhIY2phOFRWc3hDY1JT?=
 =?utf-8?B?K1RmMUpoVmU3WXpzeC9GV2FzZk1lbytISE5xVHFwTStGdnM0dXJHV09kYndl?=
 =?utf-8?B?cjZtUEJna2I4VFB5RGxuU2RwNFZMdFBOTndCZ3pnMDAzTTE0cUY0bTFzTWtu?=
 =?utf-8?B?ZEJ0dFdLM0Zmem5oV0VCM2tsbDNSeWpxekxCMUxoWHZwVjdKaU1XNHBOclh2?=
 =?utf-8?B?QlNESXR1TnBVSFRERDNMNCttaDRma3BEUUUyUHBJblpuVUd5Z09HRlFjb2Fh?=
 =?utf-8?B?cUVmem5BOW9ML2UvWUh6SFJYaWFmZ0RXVzJ2dU5vdVlDMXJXYUtIc0dlV3FM?=
 =?utf-8?B?RmpUenZldm1VRGVac3BHQXJKeVNBTTJSS3Mza2VQUGJCT1pPWU5xY2VoWFR4?=
 =?utf-8?B?SlpLUnBVcWc2cXNXazUya2FFZ3BZSUh4b3hJcC9FM3c4cGdhYVZJMnFHOFRI?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r8rAOFs/g0EHYkVOElSYrimiIIVp3X4/Iea99g2pL9t6s4Nf+XOr2ecThDItetK8hoAKlfHaiV8e9q/9jYk9N4uPAidgzgcqZag4x1JMF3ewKArDwSgUikhqcj8uGx/cl2W5ifcgkC0kTEOkoU2nap90r42mWLkQspSyR01x4ljNwSiyCM1mwQ+8+Ic1N+NuGvVDwxmBiarhrxXOHQthB1y3AmFf7vV9X1dhU/k5bTc4xYvb8HUwvtRO6tXC319i97ODSlYZp43BJL1deBP5XwN1mk5nUvJ2H0yNoEfTF+qCZ5sxZ4vsm07fpYteVHvJO8oz79lbRW63bpbCniGFIwFs/PQgBb5L0vnGZDbfZz2s8zMEGjktWf5mGgo7/5MlZyevBqcJD0es5IFpgT5kDqt54WKhwdR5ok2JqFFPCtmIZxXFKGO/ckt/USX2AOfBk8CHX/gSvNiD/YR5HJkqbNPDxKj8cIsQJtpNF/vaO/aZ1Hj4Gn838igVhh+3CPVyBLbb5L0c9wyGHgUchQLOAA0/KkY5e5vrxycdAgCD7WqmwQt1A2LiC48gKwNNX/3TzYShviSYoNdvk0BDWBKr5hY8psg/BxqmBiPyUwCIadk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf59fa8b-e517-46af-ea19-08dc3322e354
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 21:20:11.6835 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivvivSljGNBHmoqEM0GXJlOHeUBmmrDvC0hk4zuYEtQRQtYB9FyUxBKmbz/Bd4uvY8OjqPADzepdxUiIenYgG+/0+If0rXEmgOjOqcybcQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402210167
X-Proofpoint-GUID: z2xaF36WvbvjXyYKFD3o7h98BgoNy66j
X-Proofpoint-ORIG-GUID: z2xaF36WvbvjXyYKFD3o7h98BgoNy66j
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/20/2024 2:33 AM, Peter Xu wrote:
> On Thu, Feb 08, 2024 at 10:54:03AM -0800, Steve Sistare wrote:
>> When migration for cpr is initiated, stop the vm and set state
>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>> possibility of ram and device state being out of sync, and guarantees
>> that a guest in the suspended state remains suspended, because qmp_cont
>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  include/migration/misc.h |  1 +
>>  migration/migration.c    | 32 +++++++++++++++++++++++++-------
>>  2 files changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 6dc234b..54c99a3 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -60,6 +60,7 @@ void migration_object_init(void);
>>  void migration_shutdown(void);
>>  bool migration_is_idle(void);
>>  bool migration_is_active(MigrationState *);
>> +bool migrate_mode_is_cpr(MigrationState *);
>>  
>>  typedef enum MigrationEventType {
>>      MIG_EVENT_PRECOPY_SETUP,
>> diff --git a/migration/migration.c b/migration/migration.c
>> index d1fce9e..fc5c587 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1603,6 +1603,11 @@ bool migration_is_active(MigrationState *s)
>>              s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>  }
>>  
>> +bool migrate_mode_is_cpr(MigrationState *s)
>> +{
>> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>> +}
>> +
>>  int migrate_init(MigrationState *s, Error **errp)
>>  {
>>      int ret;
>> @@ -2651,13 +2656,14 @@ static int migration_completion_precopy(MigrationState *s,
>>      bql_lock();
>>      migration_downtime_start(s);
>>  
>> -    s->vm_old_state = runstate_get();
>> -    global_state_store();
>> -
>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> -    trace_migration_completion_vm_stop(ret);
>> -    if (ret < 0) {
>> -        goto out_unlock;
>> +    if (!migrate_mode_is_cpr(s)) {
>> +        s->vm_old_state = runstate_get();
>> +        global_state_store();
>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> +        trace_migration_completion_vm_stop(ret);
>> +        if (ret < 0) {
>> +            goto out_unlock;
>> +        }
>>      }
>>  
>>      ret = migration_maybe_pause(s, current_active_state,
>> @@ -3576,6 +3582,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>      Error *local_err = NULL;
>>      uint64_t rate_limit;
>>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>> +    int ret;
>>  
>>      /*
>>       * If there's a previous error, free it and prepare for another one.
>> @@ -3651,6 +3658,17 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>          goto fail;
>>      }
>>  
>> +    if (migrate_mode_is_cpr(s)) {
>> +        s->vm_old_state = runstate_get();
>> +        global_state_store();
>> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> +        trace_migration_completion_vm_stop(ret);
>> +        if (ret < 0) {
>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> +            goto fail;
>> +        }
>> +    }
> 
> Could we have a helper function for the shared codes?

I propose to add code to migration_stop_vm to make it the helper.  Some call sites emit
more traces (via migration_stop_vm) as a result of my refactoring, and postcopy start sets 
vm_old_state, which is not used thereafter in that path.  Those changes seem harmless to me.
Tell me what you think:

-------------------------------------------------------
diff --git a/migration/migration.c b/migration/migration.c
index fc5c587..30d2b08 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -107,12 +107,6 @@ static int migration_maybe_pause(MigrationState *s,
 static void migrate_fd_cancel(MigrationState *s);
 static bool close_return_path_on_source(MigrationState *s);

-static void migration_downtime_start(MigrationState *s)
-{
-    trace_vmstate_downtime_checkpoint("src-downtime-start");
-    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-}
-
 static void migration_downtime_end(MigrationState *s)
 {
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
@@ -161,11 +155,20 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpo
     return (a > b) - (a < b);
 }

-int migration_stop_vm(RunState state)
+static int migration_stop_vm(MigrationState *s, RunState state)
 {
-    int ret = vm_stop_force_state(state);
+    int ret;
+
+    trace_vmstate_downtime_checkpoint("src-downtime-start");
+    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+
+    s->vm_old_state = runstate_get();
+    global_state_store();
+
+    ret = vm_stop_force_state(state);

     trace_vmstate_downtime_checkpoint("src-vm-stopped");
+    trace_migration_completion_vm_stop(ret);

     return ret;
 }
@@ -2454,10 +2457,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     bql_lock();
     trace_postcopy_start_set_run();

-    migration_downtime_start(ms);
-
-    global_state_store();
-    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
+    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
         goto fail;
     }
@@ -2654,13 +2654,9 @@ static int migration_completion_precopy(MigrationState *s,
     int ret;

     bql_lock();
-    migration_downtime_start(s);

     if (!migrate_mode_is_cpr(s)) {
-        s->vm_old_state = runstate_get();
-        global_state_store();
-        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
-        trace_migration_completion_vm_stop(ret);
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
             goto out_unlock;
         }
@@ -3498,15 +3494,10 @@ static void *bg_migration_thread(void *opaque)
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;

     trace_migration_thread_setup_complete();
-    migration_downtime_start(s);

     bql_lock();

-    s->vm_old_state = runstate_get();
-
-    global_state_store();
-    /* Forcibly stop VM before saving state of vCPUs and devices */
-    if (migration_stop_vm(RUN_STATE_PAUSED)) {
+    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
         goto fail;
     }
     /*
@@ -3659,10 +3650,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }

     if (migrate_mode_is_cpr(s)) {
-        s->vm_old_state = runstate_get();
-        global_state_store();
-        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
-        trace_migration_completion_vm_stop(ret);
+        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
         if (ret < 0) {
             error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
             goto fail;
diff --git a/migration/migration.h b/migration/migration.h
index aef8afb..65c0b61 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
  */
 void migration_rp_kick(MigrationState *s);

-int migration_stop_vm(RunState state);
-
 #endif
-------------------------------------------------------

- Steve

