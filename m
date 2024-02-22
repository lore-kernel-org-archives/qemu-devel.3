Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC895C48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 19:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdF28-0002yx-Bb; Thu, 22 Feb 2024 14:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdF26-0002yl-JW
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:47:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rdF21-0000X4-81
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 14:47:02 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41MIQVwG020437; Thu, 22 Feb 2024 19:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=P6lZdCUKBPO8xLqdCIAJs6MgnggXcBhE4EY5jPVADeU=;
 b=VwLnn7fl3TQq9UetxZKO5l7jH/Uuo+pRsXrrU2XwsRZpC+xe09Jw1kaU9PIW/kbLsrit
 Rkv8uLcI3CZcYJ+OPfK21ib63NN9UjE6bgfDGdUFWhEA8TAg7/1gbEHym0SsMLuwr82d
 FHTCBQoLxO/+ZrRwezWEzOdrF7GIbo1I/v++WmzsuYG3xUxztfiw2oW6T2H8mu1wTodg
 xhDIJM0hu3UL/v1RyCdMcEIuuodzQdeJYb0FsN/1spCBsre4d3c085IkYvlyigPAsqMg
 OZpu1RpgNhrGbychCDjnXp7lQ4eDMo/h7aL9VsjYpIgWp+evuAVi5QZBNp8uggCDaig2 Bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wd4knwc1p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 19:46:53 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41MJDiQ8022545; Thu, 22 Feb 2024 19:46:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wak8b3gyt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 22 Feb 2024 19:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CqUmFl1v7mhj5syWFkIaa2T4I757qi8Fz0FCOaOmCErjZ9r1Fa4zMP5LVBJaIW32ZkGw+/V4TSdgXxIm/n7IvFl5ai1YenlDQ6D1hZQ+mbUtzIRld7njTWZIVNya/C87t4StqIFvzCpXBTk1pFU0K3ljcIrf3HQCY8F3DiK+nMLKc160e4blNhDnTyy0njPsLPUfOT5jAcEvwBzh3wAaVAublyn2mTqynF7jqnT6VL7V1JTVNYbUfhTHCStKaxvXTMmPQkHewT5Q7rC4bGE6irKKtR4vsKkmnmHV0LOCMkyKdko7aDE5DYkwYTYWr9sNJQowfBO1FYu0jOjkqtIO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6lZdCUKBPO8xLqdCIAJs6MgnggXcBhE4EY5jPVADeU=;
 b=HbHcCwzRhQ8wsZB+8krg+QAzeT7xIX5BdSkhBaKo5dcdGEvTliqxpZipC4xJL91JSgk4FANgk4aLirafIIAi4is6RMhFecJXpMccugoaMiAP7ObFMqnC47jsZofBLpFqrLcOmVVn+r2Gwu5UN1TnfSq/d6TcDBI185lYu7RseViqmxHeDsUDbK5vjORcGdCt5n73X0mGJp7JuIB/I8fLeQAcOYRj9/mMTjOzVaiUllGPxk/aQOGu090ecRY6IX9p1I2LiLyMab9/1eFiiUWPnlPDISrRZD4XRUTo04NZOOEkUVn9Vw6Zx9t4OQHN/V3fv+dKhh2nlxB2FVDEPu1pyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6lZdCUKBPO8xLqdCIAJs6MgnggXcBhE4EY5jPVADeU=;
 b=kl6L/eK82cIKG5dUgeDFVAKQUzwxIn0PSNMN+VWHEvrf0DJDzDiA+620L+Roh4t4A4BkNy0JN1lHFutZshewh2y6F3vtAYXEPw9h35kmgsmUeMQlUQfWRknVZAemT0jQYxqDiuQzri2TS/YIf38N57llfvzRURYsY9bzPvHOpP4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by LV3PR10MB7842.namprd10.prod.outlook.com (2603:10b6:408:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 19:46:50 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7292.036; Thu, 22 Feb 2024
 19:46:50 +0000
Message-ID: <a7389634-f7c6-41c3-9e17-076bb754784f@oracle.com>
Date: Thu, 22 Feb 2024 14:46:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/5] util: strList_from_string
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <1705099758-211963-1-git-send-email-steven.sistare@oracle.com>
 <1705099758-211963-2-git-send-email-steven.sistare@oracle.com>
 <875xyi3pz4.fsf@pond.sub.org>
 <5a07b1f0-8247-47a5-b9f0-7291504587b6@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <5a07b1f0-8247-47a5-b9f0-7291504587b6@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0099.namprd02.prod.outlook.com
 (2603:10b6:208:51::40) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|LV3PR10MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e74a43-29c8-4df6-146a-08dc33df034b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5Y6jX/YPV+IajFTs6p6CS9pGJtU1iYF8dLa+11t3p+JPYpI9X2Eoco2xbmhka1xCrFxOeion6xmtb3iRLrzATIWRhG+aF4t0zr0Otq4VnIZlH1J5VhFCDuopRtzDBBn58qGyFqTgk93VuRtZVIXWh+PvtU2rK4NlWjyhwoWBDxgfsoJTfU2Z3riMKD9TTgejtNZncTigDGTFqNUz/dTAUmbtnP103auJY3LxSH6fYMSR0UjimUoarj77YSI92mJSfxH+3ffefoAw4Ay8PIWgyMbNW/vxA4HLk/zZG+tdDImPHcIBB/Z0kuRXf+XNIUwn2cF6ADAjn9hu13wdB0LOMs0I3VtfnrdXdcGIRyQ/h1V3vn7vT/pZfuGXTXqsM9818F90TQbvQL/UjmRwLJDUj1+lPlRjmT1QKuzBDLTV2jo1ero0o2T4x2mRqHv8/VYnxBhEykiZUTJ9Ni2XAWyIIUVIdR9MhibLbNq171Tkgiah6wRMkHNN2G9Bh0l4J0evBM7dLIsQtC2s5MTDY4+ruwkyZ6tOvpplwhAiFjjvuE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDRodFdkb2pjbElJTTNtSUtmL1BmYWJFVENsYUtxS0sxR0piNUovallaalVI?=
 =?utf-8?B?RGEzc1BzNCtvNE9QcGpSZUFEVEFVZlo3S1NBY1NJQ2ZTSnZlbGsrS1M2dC93?=
 =?utf-8?B?YmtaOXprQUxqQzA3VTh0VFR4d2VreFpCZDZUZUlKNStCb2lVSzQvTkl3amFL?=
 =?utf-8?B?dFlNQktpRlhKb3d1akJRakYvdSt2eG5mRzA4OVQ0THhOVmhBeFBtK1NUTmJX?=
 =?utf-8?B?T25nU3hyUVppUXdVTDRVS1VCL0U0cDZDcEE3V1QzZDV5UzlCNGpVdm9QN1Zs?=
 =?utf-8?B?ZG9DVWkvS0JwQytrSXhyQjRsMjkxZ05WbmFhQlNGTmo5cStWSk5kNzEvMGdo?=
 =?utf-8?B?bnpuSURSREorTDFqTkRJTng2RnJoWTZYbk1vUS8wZmx5NzNIb0dBOFVac3VO?=
 =?utf-8?B?NzJoejN5ZUJmaEVCTzB4aGEreVNNR3Z4cDZXQ1NyancwbUxXbW9aL3ZBY2gx?=
 =?utf-8?B?ODh0YW9GY2tRM0lMZ3BSSU1NQmkwK1ZpRnltQkxrZHVOc2RPLzhPUFdXU0pT?=
 =?utf-8?B?YTZXNmdUa20rTUZjVjAvSW5HUHo1clAxSG9QelNzaGtlTEt6NmhSU0RXVlEy?=
 =?utf-8?B?K09EdmE4YVBMK0tFN0hQUFp1Z0J3b2twa01zRjFXUnVXd0EvT2U2R01xSThr?=
 =?utf-8?B?Rkt6RnZRTjhJTmorRnF2WENUT0JnSDVzNHB0YUJYelhrR0ZPMGNSRklkazRu?=
 =?utf-8?B?QmpDblEyV01MQ0doWkFUaGhKcTRmRklIQ01Ba1dzOVpjbm9oWmJxek5PRngw?=
 =?utf-8?B?N3QyQnBYR3R5L0NMSGUwWnhueWVzSGUzZit5UDNTbGRuaHlGZ1ZvUjJhV3Qw?=
 =?utf-8?B?Mjh6QjV2aHFPa1VPR3ZuNmx4cy9Pc3NIVlNEQ2FibHJTN1hsWnZ2T2lkU2x0?=
 =?utf-8?B?WGI0aEdVc1ozOC9ySzVTN2pFTzI0Ni9iYWRIc3VlY2t1UFUzSEVrQ2NzQ1lH?=
 =?utf-8?B?NEEwdGk5Zy9rK0kyR0pRWVE5ZjBzOXQrYk8zY2dFaVRvNndNVE1wNUxsWDNS?=
 =?utf-8?B?bTlCakRtL3ljMWtDNkNCRm4yS1NSdGNxNFBjUkR0N3VKL3h0aDVjdEdtVHNq?=
 =?utf-8?B?TERYcVp1OGo5N25RQW14RmVBV1lrcHJzbzVQcHc5WkJKclhkdS85SFVPYWdx?=
 =?utf-8?B?YldqY3hWSTZZY3FrZTJDeVZ1eC80Yktsa203U0UralVlbWJyUXhwU0FWMTJv?=
 =?utf-8?B?NXJ1YXhuckFwNTlSMW5QaEwwcFdoR0tOYnZNWnptQmJPRWx3ZjVPdkJuaHhG?=
 =?utf-8?B?aFlzaGgvZ2JXbzdoYVRpQkRiSmJrOFFnbXZJekNsaFRLaThsUVI0aWp0UVZ0?=
 =?utf-8?B?Qm94ZWFDNytieFIzdGNLSVVQL1BLbjJkTGlvUW02a1FoVG1nTzN4QU0xcU5v?=
 =?utf-8?B?L3I3L3RNVWRrTm5NMFN6R000Q1ZFdFpHcldBLzhjWHFVbUJPSEl4TElCV3pu?=
 =?utf-8?B?UVM5NmdiaU5ldTYwUU5tZ2xrcVltWmxXWllyVlhrSWM5WnlVRkhZQnpCcTJH?=
 =?utf-8?B?OGppUDVtWXM1NjV3MThQUkNNb051WnhUU2VBK0g2SDBCL0MzRUdGZkhGSlBt?=
 =?utf-8?B?RFNmZ3lja085c2lIdWFPMGJMWDJ3TUNPRUtuNTBMZ2F5Nms0cGl0c3lFZGx5?=
 =?utf-8?B?VDBCR1JuWXRUOGo1RUE1ME93aW13QWIwcDh4ejNxNm13T0p0M013M1ZrUXMr?=
 =?utf-8?B?Ny9JMXQzT0htdUxpaW9pa3hrZTRBTktpbHpEbEUwZll2N3h2Mkp0bVdDTzJT?=
 =?utf-8?B?bnAzN3JnWVRqM2I5NExZc09nbGx4aG80OEQyT3Z4MGx3ZjJHR2VQSnBINWhH?=
 =?utf-8?B?WFJTZnpNUVMwdVlROEVrUDUwZXdjZFpNMU9Nb21UeTVSbkF5NDA5SnVIeGhG?=
 =?utf-8?B?eXlkd2ZMTmYrRTVtUmptYnJjb200QjBIQ3BvMGwyaEVwUStmRitxUk5oNC9r?=
 =?utf-8?B?RnBucnFYM3ROSGtlWkVjRUhZWGlaWS9nNDFrSzl2TXdTd29TaXFUVDMxdHYy?=
 =?utf-8?B?NUpNdmFDNENqb094aDU4VUovTUErN29PUGpNRnM3ZmdkMjhEalVrdkN5NkhF?=
 =?utf-8?B?Y0dMYzIxV3A2WGpDS0sxdUtHQzdGWjRFSWNvLzAxSVFrenhJZDVhTGUvcm02?=
 =?utf-8?B?WGdnRTlmMDlUTDNiWnA3cWhzN05KR0dJbVAvWkkrblg2MU9BNFQ1RGtsbW5F?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: h3t7U74thUIsBH3oNz8BOVnLfq2Rhlc5KdQnLdjdZ+isMh7QSFl7VN45Fj8O+dxrpQb7I+QyHX/Feo6CoxRr3T8ECpoTzNDUFTRzy8CTTMWlBjzl2UHCB+NkGVv+sxyiLWNQdwgBZgDbR47h/sKUa3zXoy7dbKNUSytch2+j9noLGHA9ZLl45809nUp+C5EhsiTD5r0zUBFdb507K8G9swQ2rmZZPjktUSow3nl5IRSXASchZgEnXh4TrcJWiRO6h7z1QLPyCeZJEP33K8Plmz/htLJJyFM457/lqJkAobhAZNA/RjQLAEZgi1QW/FabuLwPniZBkKU1ot8My1NA8uiKAdT8B3SFPiZi8j/LjZgzWI/qYZ3nRkRDcs7dnIA7aKfwnrbRFFutbKgffdXdt18v/mMjKDc42wm3QN1Aq8s5/e/CbDJ8ippOp93WTQ6Whqvx1+NESgIL6DdCGDwao8vWOGYuSceZ0KsfFCs92go0CH/49Sxd+C1cTHPrzkLmAZB4hDrs9kkxa4mMfN2iBiyr4CxzoZS9p9XCM3HKlQIp8RwxQO5U442YQUNpauOpZQzfVaLwERcHLjkxMGbo0Bj+N9f1ro4b3am7AYn5/Fg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e74a43-29c8-4df6-146a-08dc33df034b
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2024 19:46:50.7295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rfym18zXCqqPCX3NMLvTrfIpM/kxAH7rI8CaWCEuZl4f+BmuasbDKNtEKbzW7F37RpoJcK8suik+po8n4J1UD8yAuHezNePpkYbNToWTsLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7842
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402220155
X-Proofpoint-ORIG-GUID: XED-SLGdNbW0k7oaMa6hAGddjMKK81Pq
X-Proofpoint-GUID: XED-SLGdNbW0k7oaMa6hAGddjMKK81Pq
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 2/21/2024 12:01 PM, Steven Sistare wrote:
> On 2/21/2024 8:29 AM, Markus Armbruster wrote:
>> I apologize for the lateness of my review.
> 
> No problem.  Thanks for the review.
> 
>> Steve Sistare <steven.sistare@oracle.com> writes:
>>
>>> Generalize hmp_split_at_comma() to take any delimiter string, rename
>>> as strList_from_string(), and move it to util/strList.c.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>
>> I can't see an actual use of generalized delimiters outside tests in
>> this series.  Do you have uses?
> 
> In this series, it is called from hmp_announce_self and stats_filter; 
> those were formerly calls to hmp_split_at_comma.
> 
> In my live update cpr-exec series, there is an additional call site, with a
> space delimiter instead of comma.  Live update V9 is posted but is old and obsolete.  
> I will post V10 soon, but I am hoping you can pull this series first, so I can 
> whittle down my pending patches and omit these from V10.
> 
>>> ---
>>>  include/monitor/hmp.h  |  1 -
>>>  include/qemu/strList.h | 24 ++++++++++++++++++++++++
>>>  monitor/hmp-cmds.c     | 19 -------------------
>>>  net/net-hmp-cmds.c     |  3 ++-
>>>  stats/stats-hmp-cmds.c |  3 ++-
>>>  util/meson.build       |  1 +
>>>  util/strList.c         | 24 ++++++++++++++++++++++++
>>>  7 files changed, 53 insertions(+), 22 deletions(-)
>>>  create mode 100644 include/qemu/strList.h
>>>  create mode 100644 util/strList.c
>>>
>>> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
>>> index 13f9a2d..2df661e 100644
>>> --- a/include/monitor/hmp.h
>>> +++ b/include/monitor/hmp.h
>>> @@ -19,7 +19,6 @@
>>>  
>>>  bool hmp_handle_error(Monitor *mon, Error *err);
>>>  void hmp_help_cmd(Monitor *mon, const char *name);
>>> -strList *hmp_split_at_comma(const char *str);
>>>  
>>>  void hmp_info_name(Monitor *mon, const QDict *qdict);
>>>  void hmp_info_version(Monitor *mon, const QDict *qdict);
>>> diff --git a/include/qemu/strList.h b/include/qemu/strList.h
>>> new file mode 100644
>>> index 0000000..010237f
>>> --- /dev/null
>>> +++ b/include/qemu/strList.h
>>> @@ -0,0 +1,24 @@
>>> +/*
>>> + * Copyright (c) 2022 - 2024 Oracle and/or its affiliates.
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>>> + * See the COPYING file in the top-level directory.
>>> + */
>>> +
>>> +#ifndef QEMU_STR_LIST_H
>>> +#define QEMU_STR_LIST_H
>>> +
>>> +#include "qapi/qapi-builtin-types.h"
>>> +
>>> +/*
>>> + * Break @in into a strList using the delimiter string @delim.
>>> + * The delimiter is not included in the result.
>>> + * Return NULL if @in is NULL or an empty string.
>>> + * A leading, trailing, or consecutive delimiter produces an
>>> + * empty string at that position in the output.
>>> + * All strings are g_strdup'd, and the result can be freed
>>> + * using qapi_free_strList.
>>> + */
>>> +strList *strList_from_string(const char *in, const char *delim);
>>
>> The function name no longer tells us explicitly what the function does:
>> splitting the string.
> 
> The first sentence does not say it?
>   "Break @in into a strList using the delimiter string @delim"
> 
> Would you prefer this?
>   "Split string @in into a strList using the delimiter string @delim"

Sorry, I read your comment too quickly.  You want a different function name.
I propose:
  strList *str_split(const char *str, const char *delim);

- Steve

