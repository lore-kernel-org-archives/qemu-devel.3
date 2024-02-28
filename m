Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D91EBC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 16:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfMqm-0002UY-A6; Wed, 28 Feb 2024 11:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfMqj-0002Ou-Nq
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:32:06 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rfMqh-0002yQ-IX
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 11:32:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 41SEG33N012871; Wed, 28 Feb 2024 16:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VTPcd1BWQHBcXTIG2DZdSJa2S//dYFLmz2wx5/tVozo=;
 b=BgREEj9BFE5+w11/Nm8iD2r4If2mzkgR5Hr7FsWLPoVny1MzyqGTEd21SMX1cGpfzWJG
 hFkyQEsaq75SAW1YrSnVhmJ7eG2Mmy08ITXkRhHu3Eu3WD4TLaAltp6t61naZUUQ+zRk
 CEx9n+iFhNJteP7jI/6R2B9Is/KQjmC6hwxkfqxMlZDidbmR9xi1uY+3JL6wjgfirZ1s
 c7+29LDL4LWZ17Rug+KrsTpz3V8S7wmx2y7x+yU3PYLqdW/krBLOR1MmawFmwyAdK0Wv
 hlgLMYHrdKWpcBUGEy+8ddJwu1BOGx4yx8G11CCiz3kDLfic/UXYkgGm3NNP0c5lgEMG JA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784k0pv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Feb 2024 16:31:58 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 41SGIT1x010002; Wed, 28 Feb 2024 16:31:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3wf6w942r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Feb 2024 16:31:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYNouruElErf++tWR/9m4IMxg9BvlSQ4kBs11PjyuIu9sV/bKBkTpcVuGMsLSYCSeMOSEVA3FKRKAPVNtYREw0q0npLIQfklPc89UemATWYfUCHnFACQWqdrltK64Ma4ZhNM+kGYDltxXd/FY02leMqHIng7cmMUigYiaYbckiM9s78teTzp7OupyneFA6R1jXWUYW0IFfOwsR9vuIjLaCqcDgEyN9vhxh1DPrBXZxWK/V5IE85TNMzDp8Pww5b2BQDJbp711lp9W/SqgzcxNdSCKKe0wIYzS8IXJfXY9gvC1vlGN761zhWpRu+Pt9yeH8xzZ/KGQ3C2s4xlUbeLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTPcd1BWQHBcXTIG2DZdSJa2S//dYFLmz2wx5/tVozo=;
 b=Wjoj9vKWoU9Pw5kyceoN9iJlin5gdYorYfz73+B+9lbTXUFLV2jcuF8tAr0yH3TSDytiVPI93m6JUlHGf8Tz/P6oIkNet3UNhz838aUjRB5Kkpsfs4JOtHf2dqAFbTYkr4yzxG+Pn0T++f0XowUGr+cFxQNkZUXgWnDD1/jy+1i4VuLmr4aDd0zPJcmUziFnRPs6b3Zl0HuGAG7dd/v6ZYcWYVIg/e1xWsF3493Fyngr5oiJy7D1WZxgDnv/eDmAKlq+fUxtww5n5yzBewD//8APr819wzmEugny84f/AmIm7HXvdzy3p5z94+KvzP6cFpufWmpSCq7r/PBPkN4n/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTPcd1BWQHBcXTIG2DZdSJa2S//dYFLmz2wx5/tVozo=;
 b=COGnBoRh523Rtr/GIyMLJRr5RCFTQu9koOFMnTVvBMTB5Bx6WqQDtIxppbYso67FesiVJ+QCa45FJ9pUxuLyWIlAwghOaFBFtLLq/HjPxOVJ4KZ4/oqTdSi3qu1FH+6zw5f7VXdDTS6+sH3BhLHYDv8cn0zI7ahFN0PyxzMKwZk=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MW4PR10MB6656.namprd10.prod.outlook.com (2603:10b6:303:227::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 16:31:55 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7316.037; Wed, 28 Feb 2024
 16:31:55 +0000
Message-ID: <2089875c-17fd-4148-ba3b-6a0283d4ea3f@oracle.com>
Date: Wed, 28 Feb 2024 11:31:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 14/14] migration: options incompatible with cpr
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-15-git-send-email-steven.sistare@oracle.com>
 <87cysh3vg0.fsf@pond.sub.org>
 <d54495fa-063d-4cb0-9e6a-4a57a312237d@oracle.com>
 <87il28vajw.fsf@pond.sub.org>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87il28vajw.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MW4PR10MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 70380f65-3860-4c59-e115-08dc387ac69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZwT57ggGUgAMlHnA3AE3XzrNreQR5Q4UMt/D2cSsQV/Efza+CWbU71EXwZpbVJbmOUGLAxdxFAQrC2u1BXaTpjIKsvzenJJRStUC8satYyeCO1K8ezKkRD5WCprZJTSn+7AVwe9PEaS98ZF1WaC4HH60lqblj/cZ9UimrncjM/LzO0CfLwIeVvhxwFYcnMvdCAfAEYxHjrvHEXs5Bk3Q4AIfh2ihz5f3IdVtTiZagJp+SJ9edcaCKPTDFE7O9woeHIQpWuc8b1KgSzYcl0jxcqd0WrSZ5g1+zKZgcT5U2f2kpsvvKjctbm6XupTM1xPPv9bzXoJro2TotJQRFtrDX+jiI719fSzhRi7hM5geO6WipfALYBL8iX85cSiTOo8sohKMCPhcEEEgAxi3h6W4RxY4bycEvbOOQN1IfNp6//Y4KPrvVo0CWuJEvh9YmmUafeOJAQujHK9wu1N2TfrA+bjW0GEJfymY/eDeBLQkqGz8PgedUQtv2AWG7xfKv/8c2QA6NCN15JuZ9et0PlOy8rVJoAhIlLPqBlXJH9Olll9tQSP21tG3hHRPNlw/PQheW4vn1zvSnrmKVxzb2qLyGMp2UXRcZgZhU5j/D2hsOpi+hVEQroQeuSgDr70RlRTCOBWM4pn/bTZ+dz70DxpJAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDYySlYxWVhNWGo5andsMUpzZE43RmFNYjMya1NVaHNGeHFFMGo1OHUvSDAy?=
 =?utf-8?B?dDVJYzlhL2pkQStFY2VSK1g4UDMrQ0RZQytPNkQweEE5Zyt5WmpHdVJoeThk?=
 =?utf-8?B?dDQ2bFJyRkdvcElWWGNaYnJjLzdFcTBuV0JhL1pBNlRuc1pOcWVkMk5mS3BT?=
 =?utf-8?B?ZE02T0dBYkRpQ296Z2FYd3lYdVluOFhzZ2pncGdoWGh5VGh6R3Q5VjVDLy93?=
 =?utf-8?B?MmI5dWpRaUFYV09uYkZTdlI0UmkwTG5tcXpWQWtiWkZLTlV1WDV4WlN6bFBx?=
 =?utf-8?B?UFYxSVNQM1IxUlBiNkcwNTl2Y1Evd2RtMG1kSG1iUlZuSTI4TVNHV2pjbzhH?=
 =?utf-8?B?YjN1dng1UFlCam03UDVhaFlZd0JVU0tjOUl5eHBLaHoyN096U1QrSjVhaC8x?=
 =?utf-8?B?RHdGM2h6d3E3NmNObGQyVlpXcjFGVXRvMWIvOFBsQVBsYkVBK2g0YWxMZWhT?=
 =?utf-8?B?bG1qSVh0S244QWFvdVBmZjBFa1Zkd3NodFBHUzVid2VGaTROQ0l3MFg4b085?=
 =?utf-8?B?L1k4Tk9LTWVBZGVibEZhSm9xWVdQKzZEWE5IR3gwa2tBVDUxOFMzdG43ZmZU?=
 =?utf-8?B?b1RJWHFmSnFQN0hnQkc2NWpONk4wL3YvbXZiZEFRVEU5bjRmK0s0OTIzRTM3?=
 =?utf-8?B?bTNlUG45enVmcUJCdVlMWFMrNGFwazRtcCtna21XcW15S3U2bG5VQnBsaUxW?=
 =?utf-8?B?dHVBMUc4d2pPRGF5L3lQNmUyZWhVNitUbktYM1hjUkpHZGw4STlMczVzOE5T?=
 =?utf-8?B?Ny9obzV4T20zditsMGxSY0F1NEhUeDlnODhORG9pVGlYMXFmSEVJbERXbzFa?=
 =?utf-8?B?UG1xS0hNYVJ0SSsycEVDSG1FWUNBN2h6eHJ5ditqUXk3ajBjcW9USmZXbUFL?=
 =?utf-8?B?MFQzR00rcHZZci9ISHVNM2NIUWxCMkRWREFFSlFBZTE3TDk4ZFlyMnAwWUFG?=
 =?utf-8?B?aHZlQkRqcjlRMGpic3M5WEFGdEdVZE5yL0Y5cG83dE5mTkc3RHJXWFhOemtI?=
 =?utf-8?B?cXNHU0dYUUdKcW9tK085S1E1MWJ1VmplY3hSOFFSREhlbCtSV1YrT0lrelVs?=
 =?utf-8?B?NmRmVmk5R0o3clc5ZmcvKzRhUkszdmxHU3hqeWFnNmpRdmFnZ2VneC9LcjFh?=
 =?utf-8?B?T1lZUkFQL1RiTk5PV0dpTHE2ZUI5ZEtSY3NrU3pYUFN3N0s4ZVp5UExmKzhX?=
 =?utf-8?B?eThEc3prRU1YTWdzNVFyZTY2aWZBbG5aLzFMT0MvRXV2RXlWL0RtYVlmWGtn?=
 =?utf-8?B?WjUvOHMrTzNETXZyTDdGUGtBN0dMb25sWDNYcjZsaFgxbCtLQlBGVFlkMG5C?=
 =?utf-8?B?T0ljaE5CcHZkQjloN0Z5SHh1NlIvejVkRzZ6OTlSdTU1RElGTE1xRVpvU2Nj?=
 =?utf-8?B?QjJlNnYrSHBIeTZVRDJNcEhyREsyM0hwVEJvNUs4cjNlZlAxOVgwclZPZ2JO?=
 =?utf-8?B?Rjl0Ty9HK3NkMmNwNVEyakJ6YVRrR1lSNVp1Z05qN0JFYTNUdzE0L0ttQmZj?=
 =?utf-8?B?TmdjUEc1ZWQwSUZqSVJRQzhWMElFckk1bHh2M25wamlOaEJXUExwMGJ3WHF2?=
 =?utf-8?B?NWhvbThPa3pEQ0pGZmM1ZHBzajZMSlJicUU2TENmU25Nd0RYOFJLUWVvRWZ5?=
 =?utf-8?B?S1Vnc0xGTDRUQk1ndUE4U2ZTdHQvUUx4OGQxV09ZKzBzQlpYUGVoSUdLUVkr?=
 =?utf-8?B?SysvQUhKM1l6dkZhMWVlWVhOZm11L1RJYkNlb01FdS9ZcEF4cDllMTZhaGl2?=
 =?utf-8?B?Wk5pSENnTjVuY0ZNMXBPOHp5Tm10U29TMFhaMHE0SStwRDNtQTdDaEhMOE5Z?=
 =?utf-8?B?N3poeEEzMnN3ckErU1VLSFdJTk81ZVBXY2FoeHh5d09nazEzZktJZ2JCRFAw?=
 =?utf-8?B?b1dveGFHVW8wM09MK0ZwRjV3eVVIdFo0aDhQRUQ5RXBSZndhZlhLOFUrTUpO?=
 =?utf-8?B?L3RUZ1ZLbzNWdE9ET0xNcVFydnFHK292OXpWM0lxcTBnb2dPZ3dNVEw5YUJj?=
 =?utf-8?B?dWd2dytTRmVVaGZNQUxxTWZlaTVqRkxlTmJkRW1BbWxuVGN5VG9vN1lPdERH?=
 =?utf-8?B?M1d2Ry9PbzJVanRqbXovNlloZnJSTWc0VFJ1TnBRcmpCcGZoVGE1aFptUmtY?=
 =?utf-8?B?OEY1TTVRM1NHdkNGRW9xRms5LzIwWk1HSU8vQmNQdVc2ZGxEeG5Fb2xuTHlQ?=
 =?utf-8?B?Mmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cGD/5FHSZl+xR35UkAfucsl+tv0kp4dgQFXRHag1dVuJyD9n9zmGymc54PgnAac6QJ5PzeZ7WRwc+GvylEX0VIofNN4aGDlk/dAcZxbhUzek6+u7oDilrZMjri1gNgvxz69776dbsXPa5QdSF4WdwMtzs3zS/xr3hcGdiRl0xnHgdKwY2ibBoZo8LSz7feAvp59Zp0p4nCVU7/QOOSELlg4Y+S2l3ACikRhWhqz862Vhex+JGNup6IdgKcHe+C2FUJg4D6MAIkeF7urlX6qwOhOFtfKTkQ+HS06VYuZOW4rB+PzlCym6JJwtgmO+qO62viVOxi7e8DIso/wEkmSc/wmrzmArC1bjDCniM5EnCglKBtWqsjgc5CR6xb8OshAUXgDj5kz0mF+CtE7UT9YpWVfRobO1tJGrQ1ENDcp4V9/GBiNeZqsU9LSzlufXGaKrVKwq/fEMQZagoIGuc96FUA/WLLPWrkOtivUd5vgvHpFWgfFBXK3Hlr4wdu6489iKYh90uToMQFAetgECsdWb449gNAt8QH4g71d19kc1f8xR5NNH3LexciXpI4wuY81RsyyEuH2RKN17PZZmtWokX5wvCGvAkwnAMS4lycF9RiU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70380f65-3860-4c59-e115-08dc387ac69a
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 16:31:55.0348 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8xNyW2qqRSgBiIZIs5eUXFGTgKQ1qSdrOiTwinuOIDGv09CZt+w5a62KMdtXxwBxLSN6zVYpHp9nwP+CBCs52SM7ugql0S2dRKxeliJTBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402280129
X-Proofpoint-GUID: gc0hZbH_rPUqvH438AieAdTjwNjUGe7s
X-Proofpoint-ORIG-GUID: gc0hZbH_rPUqvH438AieAdTjwNjUGe7s
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/28/2024 11:05 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 2/28/2024 2:21 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Fail the migration request if options are set that are incompatible
>>>> with cpr.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> [...]
> 
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 0990297..c6bfe2e 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -657,6 +657,8 @@
>>>>  #     shared backend must be be non-volatile across reboot, such as by backing
>>>>  #     it with a dax device.
>>>>  #
>>>> +#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
>>>> +#
>>>
>>> @cpr-reboot
>>>
>>> COLO
>>>
>>> Wrap the line:
>>>
>>>    #     @cpr-reboot may not be used with postcopy, COLO, or
>>>    #     background-snapshot.
>>>
>>> This doesn't tell the reader what settings exactly do not work with
>>> @cpr-reboot.
>>>
>>> For instance "background-snapshot" is about enabling migration
>>> capability @background-snapshot.  We could write something like "is
>>> incompatible with enabling migration capability @background-snapshot".
>>>
>>> Same for the other two.  Worthwhile?
>>
>> I initially was more precise exactly as you suggest, but I realized that
>> postcopy encompasses multiple capabilities, and I did not want to enumerate
>> them, nor require new capabilities related to these 3 to be listed here 
>> if/when they are created, so I generalized.  A keyword search in this file 
>> gives unambiguous matches.
>>
>> Peter pushed the patch a few hours before you sent this.
> 
> Okay.
> 
> A followup patch to correct @cpr-reboot, COLO and line wrapping would be
> nice.

Will do - steve 

