Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EACC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:20:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizld-0007f0-PP; Mon, 04 Aug 2025 14:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyCh-0004uQ-LB
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:38:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uiyCf-0004uA-8k
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:38:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574D6aZf031666;
 Mon, 4 Aug 2025 16:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KJd2231FtOFwE/uPCaEzOfTAKedLnieRB3EhTltzTKg=; b=
 IWDltUKmvoEhs7k4NLoeV9cp6uT3IYiPlAcN3odyIMgztJfuAgclAmxdldfFeyw0
 raUC6yZtjF7sJkROfojMzHslZ50NRHl2s5CDB70z9DgO+398mHoyv7jK9vNODvf0
 FkCYYK7PGNGN5SD1k/a/PWX7POFRXZaBHuWnNoI1c2f7pcC1V22raMg0ZoCMbqgu
 6FZ9EB/Ylr+5dzvGFAodZVpGW3eydT9ldsTcrv7RYk3cL6sG+LzShAeg8l31OWF/
 Qi7o3Vz+aWo6WL0q2v6c3gu0cT0hl/TARbwqfH82RH72wcvr0qmWcPTpcM389qLr
 8gL8KQSeqeAyEb1w7L6YwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489ajdk0a2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 16:38:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 574FcbAe025436; Mon, 4 Aug 2025 16:38:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062.outbound.protection.outlook.com [40.107.95.62])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48a7jsn2gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Aug 2025 16:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYABpIVPQhklxjSN+Sty6TZQF7CHNrVTUpsot4mq8eq3yqLIT/LjjdOB/hVcl8KFlzTd3Sx931IK+Kjro3RMAcsRxoOativP0daMG9JZWTWUBc9wY7UOv4ueASLBjx0lJLGMoRF436CFQaNtK9jehnPJ4ghT4+Wi57r2ikTIw4vT9R30Z2JsIqHK8lQIiqikZkB8bC59Js3VCZJCP/gy8KvydNs5SBUc0YiZ3r1fdBoqkcuT6MWP6l6EiPxGtrQhQr4IIn8fx1eme5zP9eKIdADfHFwgOti2ty07RO84jzF7tkYNJatCZLAOqyi4bAHqtPW7BqzefQDmUDvFUYtLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJd2231FtOFwE/uPCaEzOfTAKedLnieRB3EhTltzTKg=;
 b=l7Dh6vodcyIRWkklGpoIyndNOt292th2U8nWCpUSBvEUWen2/0Wq9N16svY0IUc3vvtd5mU2MywNnCBJljfmaRuC5TxuS9Bkcg3dK3nLizvhDRo7XNJ7RGr2CT/AGLmFnlPsEZHr1kqmM4+nRwhbZAKnIh8ZqXX4K/eAFPuGmQFmy/UCCRcJRDV2oojh4WHJ5PK0puyjBn9/+hLXQsxkstCC3dDkVsZ+ZE/8cTipv7yUgTZ7WgSyG4P+3GdzXxe+HPzauRQnBoLHZU9SohX3dVhPPlWkZBXq+hpeJlqLQ80wa9SNZh9CBeqH7JF6WBS5nrV+s2r5izqgXfqxPPZuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJd2231FtOFwE/uPCaEzOfTAKedLnieRB3EhTltzTKg=;
 b=XTdGiNQr6eJAyb6f1NXOzqom3EKeF0CoygLnzEAmkfDjcDJYtcBDaCN4D9ompER4+sx2UEXPzVhBEgF6VRu3NHT71mShzy6D1/g8VXz5AdNyTxiE/I0BH6LnOEqcxA9ACND0AtrxToBRANiLFRsJkYFbn2E/S0thzsTqFTqXXQM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB7316.namprd10.prod.outlook.com (2603:10b6:930:7a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 16:38:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 16:38:16 +0000
Message-ID: <6f9f2dca-9eb9-420f-b170-e3ae0b3adf07@oracle.com>
Date: Mon, 4 Aug 2025 12:38:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] qtest/qom-test: Shallow testing of qom-list / qom-get
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net
References: <20250725135034.2280477-1-armbru@redhat.com>
 <20250725135034.2280477-3-armbru@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250725135034.2280477-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0001.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed489c2-2dc1-4abf-ac83-08ddd3754fe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmtHay9la0pBQmwrYVVpYXpVVWJ4UWhzSU85MnlBVENob3NaOFlXYVhRM1hQ?=
 =?utf-8?B?QktRd3VneCtpK3k1anpuVThNbFJpdUFpa2JmeW5DSjE3Y0lhY21LZVJZT24x?=
 =?utf-8?B?bUR4UCtPbGZzZTc2U085ZFFJb2tRMFdwTVFxSnpsNUVHaU1vYWtaMVVUSVo1?=
 =?utf-8?B?U3dOUnAvbVE4Wmg1YW9mODdhdXVUWHkxYVMzbDVOY2ZjT0lMTnZYUUFqRmlq?=
 =?utf-8?B?eWk5VjZCZGZMRzJjWS9aT0hKVUljR1Nxd1ZnV2tyVE9pVTAzcjBIaWN2ak9p?=
 =?utf-8?B?N05uN2M5K1BRaVZ3cHRGcVJBa0pGa1hCNUN5d1FjNDk5bG5Uc042djc2UHBu?=
 =?utf-8?B?bk1mdFNlVDBWcFh5d0FYakcvTU1hLzJiV1lMWFJMTHNYVzdEa0NPVjBHdWU4?=
 =?utf-8?B?M0c0ZzFGdHBGbXJpNE9LQXcrRmhMZ1RVaWZEai9hbHA1VStGWEFHUkdlWnV4?=
 =?utf-8?B?MHhzb2RWZDF5aDJBUUJ3dXY5ZGMzVHFRZG5DRFhqd1JjNEdOQWxMQ1VIV2E0?=
 =?utf-8?B?U1krcFk3cjhGZkQyRXJhN1J5YXdncHEvTTd4d3BXRER2NjZjYURYVjRNTnRq?=
 =?utf-8?B?Mm5oamdvN1hRWXh4STUzYnlxaUk3SW5hQjIwTnh0dUxuY3BGRDZvdWhwZGZW?=
 =?utf-8?B?WnQ3TExhNitES25odkV0TDNEMzdjWU4yd0oxS1J1RGRoR3JZc2pMenpkc004?=
 =?utf-8?B?Z00yWFhhZ2laL3hHU2NXV2VXcFRaL3ROOW8zNktPTnVsand5Y3lQZ20rMVlh?=
 =?utf-8?B?N2ZEUXNneS82clpiUVV5djVwVlgyOTNydG1lVS81WUdBdWcxcW0wTCszZlhu?=
 =?utf-8?B?UndyRTRxaFk4OFl2RWxhNWlobnFXN2RoRWtCZWF4b2daazg0eGw4UnVXZGxj?=
 =?utf-8?B?RWV3RERlOXJ0bWN2WnAyYUpvemFSZWtYcERWS1pTeDRPREpzb1VNRG1HOWR3?=
 =?utf-8?B?M0Y5c2oyeWhKc25WeUFZazBMQk50OC9mL3FSWFFwVURmYVpRUFlnbXEreDIz?=
 =?utf-8?B?RCtYTVB2R3YreTZDTWI3bHQzWGxFOVpFcDBvU0FVTUsxSDNGcWRuYUJnWk5V?=
 =?utf-8?B?b1pwUldTUGxVZGlTb2haYTkybEpGNVljVFlmN0VMc2kvKzlOTW9OaEg2enJy?=
 =?utf-8?B?eERobUliZk02cWhvVXgrZnVPVFY2bDJGelNQNkxKK3dZKzFLdEdaT3pxTlBV?=
 =?utf-8?B?dVdVcEJaa09hRXU3SERENFhXUnc3d2ZxR0t3MXp5TUpDY0EvN0IwSXo4WEcw?=
 =?utf-8?B?b29nZmpwUXB6UWo1aFNwUHdWRUNrcXhBeFBkZi84Q0lTMDIzWEZVYU5BbjY0?=
 =?utf-8?B?RzVjSTliZGFOVC9IVzFGU1h0MFprUW9nT010eXoyazQ0OUo1THl2Y0NIWXFE?=
 =?utf-8?B?ZnBrSlNzTlpsbWZYYlMyb3RiMmw3eCtqcGpNRzZVVVpOSXZIN2lzZU1lOG1N?=
 =?utf-8?B?OC81S1ZFL2RwVjBXbGRwcWRxR01nL3VLS2drdy9UOGRiU3VZbjRSUm9RczAy?=
 =?utf-8?B?cml5bWJCRFZ1aXl0TVlTUno0cUVIeXU5RittUVN1Y2tYN0FLeU5Ebm0ra1ZQ?=
 =?utf-8?B?bEJaVEpYNW1EY1k4TkNrajZEeDBSZGhrek1ma0UxL1Q5ZVg0KzRhejFmekho?=
 =?utf-8?B?UVREdkM2MHAxa3BOZklES0R6NHZtODJ5WmlJanoyM0h2cVVSVkZnd2FiVzI4?=
 =?utf-8?B?UTlHMVRKU0tRa0hwSGNKNVoraWNlZkt1RlRjNGJreWZ2VVhTaTljQWxmMXZM?=
 =?utf-8?B?ZUppanNCV3BiZHpabjg4MWxRT3dEZ1c3bzl4V0Z0d0h2dHRIZUk0ZFVZU2tj?=
 =?utf-8?B?cU9lMys0SXpGMWRvM01DR3dNam0vOURzclhadVQ4RjZKMDFBQW5pSDY1UVRa?=
 =?utf-8?B?ZUEvM0dncHJkRlNEMzlsSHVKeUNLdUhXWTY0UFNieGNhQlFralMzR3dYcG1w?=
 =?utf-8?Q?tcanSFR/1qc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXFBSTl6WktMUjY2aDdKYzlhcnRGT0loV2tPZWo5WmpxOGpXQ2gzRUZHM1VN?=
 =?utf-8?B?UklONFNtTnNHOTlZaklLN2MzaHJBaXRESzZHZHcyRWhUVlRlZUlJQ0dWSVZV?=
 =?utf-8?B?dDY1SVZwbTFjaURQK0xVaHJHbkprQUFqak1kNFN3WG8zZDZ2K0NucTNwNW15?=
 =?utf-8?B?M0tYbWlpSE51WjFZdk5TemF2WHdzaWcvZSsvcTZsS0s1YWdsRjlWR3crdnhr?=
 =?utf-8?B?czl0amxpeUNtVVp4d3lhQVhkbWRKbjVFUXFrWDRJcmUyOFFJdk9NVTdWNGsx?=
 =?utf-8?B?blZKWUxoNU5KS3BXeFhFUXV1UnRpVU1JVzFVZW9uWmxaYWFWYnRCRnE1Y2ZN?=
 =?utf-8?B?TzRGd2t6RHJmZDNHbndaZ0c4bVl1WDQzYnByOEdEYkdzekI5SW8zaTVNYzBL?=
 =?utf-8?B?bm9hRktNS2FWb1U0SlliMERLMVdJajYwenZPeTBqU2phV1RyOGZpVmVtL3NK?=
 =?utf-8?B?a1JyNTI4cGJsSEhwTk9NaXdWMnYxRGh0OVhoS0oxVjlUL2pWblJtREcvNlVj?=
 =?utf-8?B?YkZMSmR3MWhkOEpiZ1JoTXpzeHIyV2UzTVpoVTIzR05KbWZtaVdOQnpFT1lL?=
 =?utf-8?B?Mjh4Nkk3V1dyeFJaOGxlK1lMMUYxRlVSUExSV0NRUmlxRE9VNWJuSG56OUVm?=
 =?utf-8?B?d21YNWRMZmtVZnU0V1R0TUN6ZTcvb1hZbkVVanpKSzJId1hkdTcvd3lrZ29v?=
 =?utf-8?B?MEpieTJqdnhKSC9iNlhlTVQyb095czIvc0g4L3loQmowL016LzZMZ2plZkhh?=
 =?utf-8?B?YWt5M2JLbnpPS2VSd0xjMUdpK2ZtRi85WlhWb0JPelNteThrdUhjT1FoditR?=
 =?utf-8?B?a0s1RWZMV0ZLeXdjZW5NTEZ0dC9kRkx4QnJiNTFjcDIxbStpRU11dDFjQ2tX?=
 =?utf-8?B?OGUvSTRwTHVtbUIrME1JanRtU01PdkFEaENLNld4Q3FMSVVOTEllNkxBY1Js?=
 =?utf-8?B?bjhUSVJreGlSU1lFdzBMNytNVTNlcWVlb1JzRUxnQnY2Ti84Qkg1eTlJMi9J?=
 =?utf-8?B?YlZVQ2JwWFREWVVmbjNIbkJOb1hGV3gwSDU2Rk5ROVFnSjdTaFVqSllHcmUv?=
 =?utf-8?B?U3MvWkpJSVI5OGVmTnREV1ptdDNoU2QvcXJEMEpUdlFiQ2N4Tit5VnFmSEpw?=
 =?utf-8?B?cDJ0YkhJdWV0WW80Yi90UDF3WVFFT3B5NGdSRTN0TkxvYlp5Y3ZIbWprWVFH?=
 =?utf-8?B?V0tzY09YOWRsR3IvUG5xNmRWNVR4SjU2UmlxKzJaOSs3ODVoNndIWkNCcjQv?=
 =?utf-8?B?bkIxWFhCNzN6WEo2L2ZUTkxtZ3JhUlpvRTIwMGR0aUJFbEt2OHdORkVjWUFQ?=
 =?utf-8?B?bTArM1AwUnJPU0dvU3lva1VrTDhMbnBaZWtsMXY0eUFsYVRVbk5Pc0NSOGY0?=
 =?utf-8?B?RmRLc0RWb0xPbkFmaEFVOHJtNHU2TEFqeEhTcUZGS0lTWURrekZuZlh6RVhk?=
 =?utf-8?B?ZU1CeTBQUkFreTVMcFdrSzhVejNEcEJkWW9FZFhZdC9IN29FWUN2OHFXWU9L?=
 =?utf-8?B?VDk4YUFvaU4walNzTEVVdytvaDBieG5TZnBZWDdlckRRUWIrTlRTcW5YQUZD?=
 =?utf-8?B?ZnZoTGdYT0hKYlhGOWc1ZURSMG1WeC9GWnpIZzR2UE1rV3JZK25VbDAyYjZ3?=
 =?utf-8?B?ZGwzSTNHWkFZbHVxbDE1QVV6WDU1TXQ1R1M4Kys4U3hBS1FlcXhjb283eEhJ?=
 =?utf-8?B?SnFlSW83Mi8vSittVFlpc3BHRDZ0ZlVCUVArUksrMElPamx4MDR2Y2ZmU0Jl?=
 =?utf-8?B?cWgrbG0vVmdzb293ZXh6WURCRjNHMnZCUUc2NFIzZGVFYm5oTzlTa0JyKzFn?=
 =?utf-8?B?TlZEWVFEWEdnVzdLL0VUeDVoQk1GdjZMZTMyQUxSS2V6dWpXdkNzSlZYQ3dq?=
 =?utf-8?B?OGQvT2xuTTVPNHBWbzdFSE5rSllkYXNTVGZmVTRyOFBLdElSY1RYbHN6ZlFR?=
 =?utf-8?B?dk0zdGl4UzM4bUJpVjluU3V0QmlYOWl0OXFPWWd0YThJT2JLU0hKWEhGdmFM?=
 =?utf-8?B?MGRMMnNXTVhtMVJsRUdjWmRlZHlEZkhmeENlNHJnUllwYUJmWDZJQTIzaEVs?=
 =?utf-8?B?cEVvMGtZSkxRVXN3YU8zdHNaOGsyVGJlendaOS9BbG1KWnhMNS8yV3hiU2tj?=
 =?utf-8?B?SXF4TjU1SXZGNmJVemExTzB5bTRaZDhRQ3pSb0N5cDRHNEpRYStwN2NsMzAz?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +uZMa7w+3nR90IqznRma8smYuqcDJRD++ge5myyid82dxcbqgeLBrpyaHBgmmnzdCEO698dEmpriNfrO74mvqDAnubkTvX/JxmofoILYIE6dmXmldGQfOkh6lJxp2WN/wnHUfj28S/VkWQ6Lf7ZVPIQa/ZQbZV2jaEoMHwvdnHmjuEj/8p4Ss8MuGDUq+/h9rq5Zyb+P1RAAxNEd0lDRhWlmBkNUm/MgO3T/qCUKpjjGwQwcJINOm2V94MJG1JEe5EgiuiD8/OZj8jw178KI1OdqtZtcCti2qPKQvZJ/6pyV6cuIpDhTd4w4e6TD4btDybhk6e0DdlYUjwnl4+akpW7UESDTDlYzFQ24EIILzc/hL4HrPu+zTQPpe7ZGFoQO09EHU/RxAph7dRvXAu+3oZHLMKKnru8k4dzp8OqSIc2s977VKIwh7zcig0vjasVHLM6gChBAB1G6DcTZ8rjI2GF73ZwbHC39NG0zHQ+oGMOofJyty6PLFtgAG2UhurjmNuSaKk6ksranDScuQ34hWN3WXN4VBf3A3NPyfv2XEWMLmvWRZAvdtstCCV38ErhRivNmtBVEH6uWkAU9+DU9RAXUFR8l5aw2Uytqic/TmZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed489c2-2dc1-4abf-ac83-08ddd3754fe5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 16:38:16.3302 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6Ut44vswLdGBKuzeboj0tKmB230BiUG8c5/77RSikl4QWuGXz+LIj26Zj9cTmXKzPQnNMZszh5OsHrMBmRzI6sPVU6A7KAjdyu6FDjqn9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508040092
X-Proofpoint-GUID: Pe-m3H4aRYcpwizcTAXfkXfcH3Tx5A_B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA5MiBTYWx0ZWRfX0zP0eWawroRn
 hrHw2fvy9GpuCPtkS1BJWeKiRnGSUySwUoX4C011PHCiyG3rPUrcMp+Iu7NAC3e4356oT1xSH+x
 yqb5lsNqKHFHGTid+YI9PdVgOEDMkjYPkJh0ulPx8kKXlHmNQVBjYbv0PrNfU8V1gXVAM/q5MbE
 sGKalBh8pBCERKuygGFMfVscAuQjVusLc+qI6RFyV/+m2ThIaodAFUu0HBLkeXUje7t5uIAu0G7
 k9wAzY2lW7Q2PBHg3hR6erlkw1Wqv/Ta5elilbwaBgSiMtVuoyB5N3XnZevuawW6apWuvCAm8/A
 BjH+PTioUvcMDTmJ6SakFXdYlci/N2J14l6tbJ67HYszSS4slEEEV/kxmqB1hTbZgbJS5Xde+TA
 V+5+7TEmtZGGzzm9CweW9ULJCieS6bgJ8M3jse2otx8NbY9+TMuAp5awSqMVlU1BVq9LjlB+
X-Proofpoint-ORIG-GUID: Pe-m3H4aRYcpwizcTAXfkXfcH3Tx5A_B
X-Authority-Analysis: v=2.4 cv=FIobx/os c=1 sm=1 tr=0 ts=6890e1fe cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=elY3Hu4QXnaKg8Aym8QA:9 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/25/2025 9:50 AM, Markus Armbruster wrote:
> This test traverses the QOM sub-tree rooted at /machine with a
> combination of qom-list and qom-get.  In my x86_64 testing, it runs
> almost 12000 QMP commands in 34 seconds.  With -m slow, we test more
> machines, and it takes almost 84000 commands in almost four minutes.
> 
> Since commit 3dd93992ffb (tests/qtest/qom-test: unit test for
> qom-list-get), the test traverses this tree a second time, with
> qom-list-get.  In my x86_64 testing, this takes some 200 QMP commands
> and around two seconds, and some 1100 in just under 12s with -m slow.
> 
> Traversing the entire tree is useful, because it exercise the QOM
> property getters.  Traversing it twice not so much.
> 
> Make the qom-list / qom-get test shallow unless -m slow is given:
> don't recurse.  Cuts the number of commands to around 600, and run
> time to under 5s for me.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/qtest/qom-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
> index cb5dbfe329..40bdc3639f 100644
> --- a/tests/qtest/qom-test.c
> +++ b/tests/qtest/qom-test.c
> @@ -180,7 +180,7 @@ static void test_properties(QTestState *qts, const char *path, bool recurse)
>           links = g_slist_delete_link(links, links);
>       }
>       while (children) {
> -        test_properties(qts, children->data, true);
> +        test_properties(qts, children->data, g_test_slow());
>           g_free(children->data);
>           children = g_slist_delete_link(children, children);
>       }

Nice optimization.  These tests were annoyingly slow!

Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

