Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D91C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rej92-00080d-1Y; Mon, 26 Feb 2024 17:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rej8z-000802-NE
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 17:08:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rej8x-0000qn-QL
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 17:08:17 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41QGnGH4018474; Mon, 26 Feb 2024 22:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xW/fBOJwguvdh+1j1/XVYVQgH3uYgdprG7iO9hnjbDM=;
 b=R8Y8uf1/GwcPmiIWST2foQOMENZkCy/mKvi4Jq3ZZEuWwgUjiAavLyEqMzYfpbeEUj5l
 jlDPlkpst/b9Eej8sRHdg0sASGeQA6DCZJWdwddfOwhv9gMY1LHsA5Eg1MG9TXqt+v+c
 edHKxrUmdDUbesufl25GsVOU7Jh2hvhfg29mUylgEbFQp5ZJUJrBItkjPTOOGDZ6v5SM
 uWO54Z8VQYHUhLxWjCeYcZnTJZQYKgDpM1IqnHCLuPIz5rwdRLefjnTYJzh7Ekeb6DvB
 lA4vjea1AIN8QHAJxRtcQXFS/BYNLugzN/UkzxraIvXfR3mXMp9XnLS1rRV8CxBrm4gj mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf8bb5kks-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 22:08:12 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41QLu9uu009940; Mon, 26 Feb 2024 22:08:11 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w68gv8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Feb 2024 22:08:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGpUE/89ihN8SMAEOnUGnsXycaqTEbWSw/oflq6bO2sxySVUCv9PvZYDPiLGXSGSkQHNN4cTKboblQaRVyE4Zogaxbbx1FF1vaGOxsRl8VZan1CRuGQiJ0QZE9JypCIJqm6e3pM0rDTYS8wq01nDwDtpfkrGhiyD/KGx0z5fmNyj6UhY+Tn34e/tJ74GB95xGTT4NJxGEETpp1k6TDlgQu1fYD2lTRud8tAqCPJzyKh/m6k4azXrTOEx6FjvvLbJ8btQ31dPu8wbtKDI1Bgk4Zv46s90fQ36q5opK0NuMKQlppLrqmZu58PQwA5XhP2UaWxpkJ5K8Opc29OYlYViZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xW/fBOJwguvdh+1j1/XVYVQgH3uYgdprG7iO9hnjbDM=;
 b=Ox3zrNhtrKLRRfKiOVVfUJ0z8jw3rfNTTpAJAISzfxZaK9SFxmWjEJpGkMddvpKkqhNf6KL6dLwRxE8WhLZpYKagfBe/FFTs19O1eqQVa2dgI0Jjgm+wRM8PRZCnCfQV0clsFquitcevKdJs8/cP9YZ9UvY30JJoMxhHcP3iCbCbdcV/iOoNsslJLy8N8bbrTvoeHVjk+wB/zbVVFIAdWKJ6kbix2AMs3Df+ME2GKA9zjbcKHpRvCE00aLwr83Z+ruGd9qa8IrVQSHGb+KiNiU3c+S0yLaJUFA23fWYeDtfGbAriN2LwW7s1/FjgptOxq9Pk1Vb86rBzjg27duGMwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xW/fBOJwguvdh+1j1/XVYVQgH3uYgdprG7iO9hnjbDM=;
 b=VbQlyZLehJ8Ep4hmhe5yGHPWQosOQJq9VgRUVBD/ke4SkGJIcSjh5mta0GbNKPflTN12oxv7PTeyfDz/Lfeg8Ji3W/LuliaIXeGyR9sM/+4mWgTAA0IbjLQOmG46anGhKNN0cm4y6Cgpdlp26kY27A8J4u+rveIG1n0B/nfPLvU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 22:08:09 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 22:08:09 +0000
Message-ID: <23070076-4ccd-4c1f-af53-ffa19e961604@oracle.com>
Date: Mon, 26 Feb 2024 17:08:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 00/14] allow cpr-reboot for vfio
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <c95b3c15-0154-438c-baa0-98f4c539355a@oracle.com> <Zdv0BNtJxkd8413g@x1n>
 <02bf2132-ed34-4ecd-841b-5f93eded7ea4@redhat.com> <ZdxTVHJ8p4lYRPxo@x1n>
 <0b7b2a2e-efa8-4280-b7cf-dc6bfb6e4bac@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <0b7b2a2e-efa8-4280-b7cf-dc6bfb6e4bac@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::19) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ff62d8-d11a-465f-efaf-08dc37176aa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FU48i6cJgxXaHVtgk4/4hABi5RTZUh3hJnGWa4fKkvqKWvt5byu6sPysUG1bFAWXaSre4s2FwW3IAUxJtYYvEC3lLVDj7aS1WeT8IYCzSVsWxTy0ZiWvVKcX+YYviYrovIN5to5MNV2I3eGMYD3DP+g+nWb9ABmdkKfEjcDW8J5TPqVZoY5/dYjHgHEzOSuSzdO0cK5KwdXdb+TajUdpPele4EQLxhqNiYCtUq9roLEo5D29SqT1cRrZKzRkCQWLH9MshpOKQWJKmFwYnE42vQp0SzUEvPahbwXriDIPJ6p+KkU194fYtRZlWB4CqpEmY/QOlOBKg5jTs7GxFCzb+wiiMiVIkVnZzztOmb/u8KE0aBcyIYPSzTdrhNtuKGuSCD4oN6pgo0Y/F6B1TKCOQj1ufy9DIYWBKTu0E45/eTEHm79Fev6gth1Cju2Ngzn2pp4ICYZiOxLZvZX8ny4gYQFkLctvQYamA2c7A4ZMqvdsdGbg6BsBCsrjhT6OV4aThtPUO5dj018goLUGurXJhb39v1nwEqC98uJ/v2kKUwyokRuuq1uUKlNoCPu9MGMzPY/eMxLuyGtRtNnoEZ+CjnNxAn5db1ToS6Edav37JdaluEffKXSGJtgoZ9onIQpA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW5NY2l0QmtVckNpN0dvM256em96emVkVmtmT2tUUS9Md1dVOTdMZlVkT0pX?=
 =?utf-8?B?OEVuK1c0RUJQSW9pV3lYUWpHOUsrcVpHV2tmbEhlWUxUOFIxWXM0TmxqVDVi?=
 =?utf-8?B?Yzh0Ymo1QVJ3NE90RE5qc0d5UDhKMTNtbCs2QjFBU3FaL05lSnhEdHE1LzBN?=
 =?utf-8?B?Ykg4aTV2aVEzOSt2cHp0R1h6ejMxQ3JER0w3dm5qWmROY1pSRlZtNFRPRG9h?=
 =?utf-8?B?SUJkblpFOEx2SE5sM2lhRFVUOHQxUzMvbFhqZWpFV0cyWE1LVXFxeVUzd0Rz?=
 =?utf-8?B?WG9BTTZlUi9WYkh3ZjNJeVVyTkJxWUtYaHAzRGt6RE9CcDdQZHUweGVhQWts?=
 =?utf-8?B?aDBOdGFYMHIzMzJwMlNBS0ZPQzRBUnpLTGlxb0hTb2lCU2xCaFBqaHNORmJC?=
 =?utf-8?B?bHgvMkVlb21ZazJ3VVJQU244MllqampZVEZrU0hEM1FENmo0ekdVZUlnN1Vk?=
 =?utf-8?B?Wk15RkV6eFA5RW1YTG8xaUlENkgxeTBzVUx6eWJteGxBd2ZqMnlIbklPZmFN?=
 =?utf-8?B?NGwxRUhUY1dveGNMdjl2ZEQ1TFgrRjcyNlBGaXRQelNhRTQ1c3ZlMHB4ajJs?=
 =?utf-8?B?dndOZGFZaERaZzJDaVM2a2VtQXduMFU2bTVyZDEvUXJkUVlMZW40OGRkRUhT?=
 =?utf-8?B?NWRvV3lIdjRMcjRWVGVZczhpbHhMMVR6cW8zVXVUR1NRWkE0VU9OM2VoK2tR?=
 =?utf-8?B?SFdPRnFCckl3SFRwQUswV3FuNy9LQ0ZveDhQNEZkTkJ6VHNnTENLdFNSbk10?=
 =?utf-8?B?bng5T01qWXpVbDl0ak45RUh4OXZaM0FaVEI2MHgwZnZiUUFGSjdSZWxGaHk0?=
 =?utf-8?B?Tks4VDZaNHI2V29RdEt4NW9NV2FhYzRYYzlieU5jZzJxbmVuSC9CaEVsMGdK?=
 =?utf-8?B?b2FDVnFHc0kvamNBOE8xbkdnd3MyZnFQMDZLWjg0TlpSelVMbFUwUUtqUlZ2?=
 =?utf-8?B?MXB5L2hPMm9RTGNYQTFrR0g2aG1SbVFXU3M0dGRtM3dERzc1TnVmYjM0NDdP?=
 =?utf-8?B?TFBWdFRVYmdTckpwNFB6eFFFQjIvOC9kdGlsS05WUXRiaFBZczlnUE90T1JM?=
 =?utf-8?B?YmNYMEE4djM1K2Z5eTN1ZnRKQW03eFNjdS8vcUZuc05ZMEFkaFJEQTdMQmcr?=
 =?utf-8?B?N2N1UFdLV1hYWlJkRzVvSEJ4aFptWk5LS3RvbmlFS3dWcVdUODdMbksvY3p4?=
 =?utf-8?B?bHZzWnUrZzBmbWx6K3N3ZVhWVmJZaG05YXhINnJVeERreVI0NVB0d0kycGRi?=
 =?utf-8?B?RGYrSWpsN25CMFl0S09tWHVWYVNwSTl4L3RWNlNCZmcwZFhXZ2RiaDBEVlpn?=
 =?utf-8?B?Z2pNd3JSY1Zua1ZWTTFQaGViaDVXbDl1aTVBSkpyaDlJU2oxQ09mOTcyeGUv?=
 =?utf-8?B?emZiNGxoamJGSit1TEdJd25nOVFyYmxLSnlPLzlCSlFweEZGRDlKemhHbWFq?=
 =?utf-8?B?dEwxLy8wVG1PUTJ1anV2eFEvK3c5K2RiczRoQXlaL25WRDVYQmhMTWhoQXpx?=
 =?utf-8?B?RnlBejlUYlI3ZEUzOXFpemFqaGNZcldzV1dSdTBpZkdmZXpDei9pZGdHZzl2?=
 =?utf-8?B?TElUb2ZZWXQ4VmNjSko3M1l2dmVmQUppWGdLMW5kVmJXSXdDbEhlQURIangx?=
 =?utf-8?B?Uk5pQm44ZUVMNUtXaHM0Y3BvR29vRGRrNy9KMWZvdG5FaEdKR3NaTXZXZkhW?=
 =?utf-8?B?Sk83UXlTaTA4bEp5RWxleC9lbDBaQlJ2NEp4RDJFU3g2cGZzaEdZVzFUUk43?=
 =?utf-8?B?cUpibjJ2VFZNWnZNeCs3NEFnZk0vTHpZMFFrVTZFamltaVpUTHoxNEdjRi96?=
 =?utf-8?B?bTN2SjVFMmtRY3Q0ZWE0UEJaSUkzQ3ZQczZFM1pxZ1RSL2UzMW00a1Q1TG45?=
 =?utf-8?B?WTdqbkdPMkFyVkpvcXZhWHdqWEFvNitZRk5QWUh3bWRxQldFdlc3bW05eTdr?=
 =?utf-8?B?N2dUQW1ndlBsTWhqK3RVQjdHS2YvWm9OYTdTaXpFZWh0YmhyYWhMSWpRay9u?=
 =?utf-8?B?SEw1OXN0Y2R6KzRWUC9ka2FZdzAzS0xYSGZkQTVLalF2bWFNb0RzS0R6NHJS?=
 =?utf-8?B?Z2M1VFYzTWczbjBRSm4rbGtva0NqYkhSbml3SW1Cd280S1dXRTd4STZkL1pn?=
 =?utf-8?B?VkFZeHZLak5HdTMzUWJaOUtVbHJHM2x0Rk5nUlZROTEzbktyenJzOC9venpo?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2SSgX45nh8JIt3mTka2+w1xpTEyojL0EWKVTVzZBGkO29ZXleosu3Mf9h0yU5hyybiSghaury27i/oVN/vHcrnTFrz9lJmxVG4Xg9uuVCQ3ygUP1q6/6xqojLpck6wZybCpQMwKuJilOaonCUd4YLk1QSIFsXTXJsDKmf2RIINyKEMD/NV0blg1X65E6ZhODEdAzVm8Z1p5PIX3RAemL4Z/LKfZp7aDqXAkati4l9YKJuCFU/eYr+k14l3x8ZWqjxWWRg2es2hgtGlVpxXjdJqBXtB3nGJjGXm7t6UKyihh6tMgRWvRQz3d9Lws7C5RanmEHlNl8ZgMhiszwuIrPgGz5qDgfqTTLWEniKBi5o7v7vEmDlGgJ+Ujoqtb9lLM440PAjVBhxekFYdH+oIpNHzf2DZw5CcBrxGLgtMJAtDrWJr9Z+OqHM6m6tjjKWRefCXMwoAr2y4aeyUuXSBsEmHkqws0GuFXNy/HDAG3syGy/BFH4BsyPGctYppJktJ40lpRZ66W1HeJADitgVNF+KGT0Nz7sUEj8GoDQagTUE7cqwo1TevvMO5D1o4Q/ZI3U93koROD7/RHnooZYp9/AfatAt4Tmq7DpAhA/RI02LAA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ff62d8-d11a-465f-efaf-08dc37176aa6
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:08:09.4230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4tcbo1fEVdG3GNzfTMlDLwzi+Lf/X08dRzVpr6jP7bVqtTzXu9R7iKArk93BsQJQLaTXnl2ODj9YxpggvOl0O/G48W5C0oCwdOZ6qyIHIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=754 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402260171
X-Proofpoint-GUID: fXs2_SqGvxqHysdPA9qsPlSvQtTZoFOt
X-Proofpoint-ORIG-GUID: fXs2_SqGvxqHysdPA9qsPlSvQtTZoFOt
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 2/26/2024 3:21 PM, Steven Sistare wrote:
> On 2/26/2024 4:01 AM, Peter Xu wrote:
>> On Mon, Feb 26, 2024 at 09:49:46AM +0100, Cédric Le Goater wrote:
>>> Go ahead. It will help me for the changes I am doing on error reporting
>>> for VFIO migration. I will rebase on top.
>>
>> Thanks for confirming.  I queued the migration patches then, but leave the
>> two vfio one for further discussion.
> 
> Very good, thanks.  I am always happy to move the ball a few yards closer to
> the goal line :)

Peter, beware that patch 3 needs an edit before being queued.
This hunk snuck in and should be deleted:

[PATCH V4 03/14] migration: convert to NotifierWithReturn
diff --git a/roms/seabios-hppa b/roms/seabios-hppa
index 03774ed..e4eac85 160000
--- a/roms/seabios-hppa
+++ b/roms/seabios-hppa
@@ -1 +1 @@
-Subproject commit 03774edaad3bfae090ac96ca5450353c641637d1
+Subproject commit e4eac85880e8677f96d8b9e94de9f2eec9c0751f


- Steve

