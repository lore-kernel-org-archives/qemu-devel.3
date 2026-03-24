Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089FAF54AC5
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 15:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w53Gl-00056E-HD; Tue, 24 Mar 2026 11:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w53Gi-00055k-72
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:02:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1w53Gf-0003bB-BU
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 11:02:07 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OCFeCT613135; Tue, 24 Mar 2026 15:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=fvYd4c1vWgF46p9LdT448a/66d1bBCHppj8yeCKa+F0=; b=
 OZp53r7FawglBgUoo2NAn+YuIA3Bnf2/jo5cLqBwiApedFECTA3aWiieKHLtb6zw
 JHtmBwEhwpC0c2306sqvsrXVwT7bWxhLUL1ql/tzN1/ls2Z0xq3CKFUvfGdKXaXm
 H068zY6teHV4a55U85N2oFtaH7xy7SWVJc3oGTXJI1F4wSMl/pOr95yBz+U5JEVP
 eFNEhDO500HMkycjWue7f8dB85m1IvbT0igwcDxUIDEOebarMQMInFO9zhukANtW
 +a7KQk0IZ1Ub7zi9s7jf5ic7zSfey/i8izcE4qrV6tCGlEqyBHwDRm900WZRVlIm
 c2U8d45Vg1vHU0b5QKptjA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d1khf4cvs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 15:01:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62OE33Gr022271; Tue, 24 Mar 2026 15:01:42 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4d26xpp5vu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2026 15:01:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/fGkqEwDxoOE99DpptrJR1akF0QAXS0xykiYv22iovCFQjS3NmPii1VBTYrzIC5bZh6sus/snbjYm9ZSeWK1fvFezMpJNtBz0VUoQlRy9jMe1ZRnhy6uTMqsvWsJwuL7jVgUNkKc4iX47Xud9kM2p2joN4dbBXo7FaDBF/+AihQsZKc0wHW0p5D3feIO9/0twsThJHACRYchmnauk8S8MLoeW/eaqFMtg17umfd7NoarFB6PKfQg+74A3Tf3Ls23JcaRE+WbpgDlYbEkWIOk10a0Yucr/XZCtceYgdqKEzX/5dLCLc3nU1Eo6JajNOLky6EoWowzKgR+HV34Ac8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvYd4c1vWgF46p9LdT448a/66d1bBCHppj8yeCKa+F0=;
 b=MUtERdFo+LXSK9/MBLTJtOFMqFXCgPHd61mEvXFm0YxgrIYFSTAlJqsR4GfAIos5BBPXdKEoDb66DVKUL1vP2Uf3mdKnBr0SvN27nQ6C8lwsNgmE9yMNn0bIEYIhwHvWkJH7FDGVMBvTRs9KH8UGvlrPamZCakZLOsh6/EKyGhQVRvtvnAV89MjAhgAJDc/A5x126lcacqpG6PWGbhc3hK1V5PFh5xWyU5fpbM4q/g/FavICQghTbTyaybrvpVTx/TegESayPLdusj4/kcRNJQANhqz5NiGBhiPbJ/kNy5+nPfLfVQHFpNF72IBPWU9uiSVnl3fr173/ww4TIoWYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvYd4c1vWgF46p9LdT448a/66d1bBCHppj8yeCKa+F0=;
 b=HrNQFNayBhZ/lGnixKXL+qu1eyodR85wgvkqFoz7qXAp/Rtp23vXa2CSxI+lzvn9P6MCpaWcufH6uyK/HaF8HbvJhceua5kfibbxpZYX0TbwcSHqmQlkzJaCWWRVhOyhQ+VGn/H5osu0EctjKxDnv8rJZkU0scQQ7CXbrih4zaM=
Received: from CH2PR10MB4360.namprd10.prod.outlook.com (2603:10b6:610:ac::7)
 by DS0PR10MB7091.namprd10.prod.outlook.com (2603:10b6:8:14d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 15:01:36 +0000
Received: from CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f]) by CH2PR10MB4360.namprd10.prod.outlook.com
 ([fe80::2317:1df9:9fcb:284f%4]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 15:01:36 +0000
Message-ID: <654f2356-9c78-45df-95ff-de103557948b@oracle.com>
Date: Tue, 24 Mar 2026 11:01:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 04/14] virtio-net: detect VirtIODevice status
 mid-migration change
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com,
 leiyang@redhat.com, si-wei.liu@oracle.com, boris.ostrovsky@oracle.com,
 armbru@redhat.com, Juraj Marcin <jmarcin@redhat.com>
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-5-jonah.palmer@oracle.com>
 <CAJaqyWfkLCu2RRGaJZdcqG0c3uZH0jWmmTmN23F=Bz-Hfm4KOg@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfkLCu2RRGaJZdcqG0c3uZH0jWmmTmN23F=Bz-Hfm4KOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:510:339::16) To CH2PR10MB4360.namprd10.prod.outlook.com
 (2603:10b6:610:ac::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4360:EE_|DS0PR10MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a8cf19-9800-43c3-d37b-08de89b63e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: mez7+CuLmvKydlj8x/ofoMTaHq+KM4eCgvK7DExHi/soz8Doszu2dfdoBFztMFKVzf3yw0qpkS/VDHLhkEmPurmJRkKiBkyaa50aDAribqaj7+lp6xuw/kb7UvWhKi4qCrMRDakprVteLy72l8Zgmy4njbVbs4pmvUkUMGkBjRxRloEYgn014yCmPYnuUYY4cWcSClIxcfEzjayH3eAM/o3rKBZo1V4siKJgk0tl3P7mGp3QOqtkLdVsi5puPgzZDo0DlvWdeiD9/jluoKDfeMCauWUeI4zxI6ayHoJA7L2BipHJMgwZQLRQxbqwni0ML0aN0PZJJSyCFKlHSkFT5Igx8GpRD5ppPICN+95EC5yg2kmpU6PT0U+xkIXGKDB85FDOaDUN70GJuaDVAZ0nHnxb1GDsLFgQSFI2GcEY3MJwjIVZb1LPW9sYKLCw2Q/bCXXUHfgKUke5Ce0S6OXadt8szvbjVN+5qF98hldq4qQbQJW0g62msCWVVX4FARQ3zmbH5qXMJknFQYYN6YOkckZrRh36h3KIi7F1T3keA95gkzYtcRD3ZAws3neG7OpVqidNLqTuxnZE+U9x2rDMEbJighVhmzS5Xb88OArr+bHtRWFdOSWaoh2os9xyutlw1b3uPIYFB59xMjcwptEk/VGQirdaluvoHW1oMijfy4ZJj+Mf3zEVbERY018oCpMWCdR0+W6GVKN/Ak79pEZUZKrk0GtSOk2U9PPZd8epZy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR10MB4360.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnVaWHAvU29KTlpWZTFFV3V2aGlmdmlNYjNDeW0ySGwzL2R4dktGYkFhazNV?=
 =?utf-8?B?K3VBS21BOE9oK3ZrL0RDMkFEelllRU9vSGpoa095d3ByZFRqeERVblNYditW?=
 =?utf-8?B?RFRXSFl4UlowSmZwM3YyNnRWR3BzNXMrMXR4TC9oQWdqMk8wdjVkWFkyQ0RH?=
 =?utf-8?B?aUZHbDl4dCtaeThsTjk5ZVdhLzh1Q0xtLzdidFFqWGI2V2FTR040MzFYZUR2?=
 =?utf-8?B?WnU4Mzg4RHdrRm43elAzeTVCK283bzArQWlMTmhpL3ZHOXlsODFsQXFNMUhj?=
 =?utf-8?B?SzRiZjNCcU1FSHBlaW40bUlhNGV3ekRYQmNwVDVsV04vQjNDZG95Z1BZOEZV?=
 =?utf-8?B?bjhaS1FHa2FqQW10K21jNDBEaDhORFZNMERHbWovU0xFdUFINTRSNWxHeDh5?=
 =?utf-8?B?dzRPSloyZFB4amRSMHpHUlBmLzRpakQxRWpKV2JVejJQc1Q0NEo0NlIyRDc1?=
 =?utf-8?B?YWFxaE82UkJOSmlQQm1hdGFOVFJ5dWs3ZUFmMDdzQnk0czYyQUl3bmdKdkQr?=
 =?utf-8?B?WjQ2ajV2NFZsekVCTFllNCtUL1VLckFPNTZvcFljYjFvSHQ0K1p3eVNZS3Bh?=
 =?utf-8?B?ekY4dUg0UEdLSGZwdWszREJBcDNBZ01yakNDMG5Zb2h6YjNyUjVHbDNib0tV?=
 =?utf-8?B?TDBhOVRGaEY5VXJjOGZnc1orMWxuR09ORmdEMlVmZ2ZpV05LV2c2SitORUcv?=
 =?utf-8?B?U216SlhpZGlweW5xOWlQVXd3b2dSRFdpRDEwaDF5ZHRNTHJ0WjJKWUFxZ3Fk?=
 =?utf-8?B?aGcwRG01REgwQ3FYTHo2VExvejV4Y05qZGRUNExRbkNMbnlmTEpZbTB3b05Q?=
 =?utf-8?B?azAwZ2pSM3hHek53cEhMa2lqUUVFVTY3bVdSdUZReWZKcW52eVVUWXMxYkRo?=
 =?utf-8?B?Q1BkOXhnNW4yMFRja0M3SzVqRmZncW1mMGNBeCtzTTZVOU1DTlRmNmxoaTV5?=
 =?utf-8?B?ekttSE9Ob1ZDTDFoa3daN0pZUUpiWkdjL2c0TVo5RC84Wk1wdHNaWVl5TmVL?=
 =?utf-8?B?TnBURFI0ckI1cFpQaStEQ21zZ09qRTdrU2FNV2F0SFBhNkg4QlVsYjVrS3JY?=
 =?utf-8?B?OHI0TncyVjUxdE9hbFUwU1c0dWVxWko0V2M3NndnZnF3NlN1UXBKRm9NalpE?=
 =?utf-8?B?Vi9EcE5lODhMMkVlc3BJOXQxY05VNmxoU25EQ21NWitCZ0lxSkh2ZlduV2V3?=
 =?utf-8?B?czMzUGR6bUR4ZXR6N3ppR2g4VUhBRDVrVk9nb3QvMHVYd1FwMmF4dm1iWnM0?=
 =?utf-8?B?WUZjVFZFdURrSG5JUndONlpGQjA4MThkUXlrYjJTdVllVkNpS1BjQkI0V0JV?=
 =?utf-8?B?aW4zbm1BVk9zUWNBRytkVVdiYzlERFM5MUhzVXE2OUxuODJYQWg1ZDVxV2h6?=
 =?utf-8?B?TERiT1JPZzdzTjNnZjNaYnphd2VIVTVCNlpYM25QNEZ6azdWbGN5NEk1blND?=
 =?utf-8?B?UWUwOXF0Q1lHbUNFaWRxVGVRbkhEWGh2VEpkUXdodzFiVzJOc20xL2o5cmRZ?=
 =?utf-8?B?cFlwVmkrMHJqL0dzcnZCZXlXTEJtRlo3aGNFUDBPakd6YjZYYlgyNmltaDBt?=
 =?utf-8?B?Q3ZzRk5GZ0lTZWZpTVJtUTNtVG94dzZ4bjE2NzZNWGVyRi9YTUtiaUpOVWtW?=
 =?utf-8?B?QVpPcXBLY3JRN1hoUFNmSTg1OGx2RC8rUE1mUGI3Y1B4TE5ReGlkRlpRYU5n?=
 =?utf-8?B?cU54aHMzTkRUc3hPc054T2J3SC8rcjhVNzFQWFhVdnJieVJSL0YzeG9CQlJR?=
 =?utf-8?B?c3dOK0FFYlNVWEIycFUySm1JRitSQ2RIU3RMUXNYME92MWdaUEdqa0lpOEVp?=
 =?utf-8?B?Qkx5UjhiTHJQdi9lMklseEtidlZCaWN5NURLZllRaVZ3Q2M5Q3kyMFBEaVV6?=
 =?utf-8?B?VW5RODd4NUtpMzBUZExCVk9LeFFRNUQzZEJqQkttVExKa3hkWVdXVVNCeXN6?=
 =?utf-8?B?NkovT2FlQkZPZHQ0THlURXlrdjRXN09iRVBjVGFVVUdiVVJ5MTlFaDgxU0hq?=
 =?utf-8?B?QTJEYUpCVTVRL1l6cFBLZTZkamtoRElBaHZsM0kxWloxZW9meGo4VXZxYmlr?=
 =?utf-8?B?VG15TjFpMVBoTkdlSTNnakhMbzltT0RpalBzTDFmM20wbWdyN2dER2YxbW4x?=
 =?utf-8?B?TTAzRlN1Z2pQZ2lZWGpFalpxS2xHZVk5OHRpbGV2R0xvOWxOaXdWWmpZbEdZ?=
 =?utf-8?B?ZUZIQklOZmJjMXpUYnlrWDM5WnA1NWppeWIrZ0doWE1DcWx4V3RIcUh6UmhQ?=
 =?utf-8?B?alo1R1JXNUhMbTkzOFhGMURMUE5JUHQ0TmVicTZXZUE4a1lQYWR1ck1SakM3?=
 =?utf-8?B?dW9oeU43STJGY3pGTnQ1eXYxMEFLd0ZtNXpOTnFOV3pqN2hTYUt1UT09?=
X-Exchange-RoutingPolicyChecked: hXlJwWjOlIAMyP/jwEcjlge0QuPMbF3awklZJl3n8WtCwHvLJGJ+K3a9uq1At90k4fReqCCw+LOefyTyakH+msBSvNT/LAmyZV2Zcu3QxQzEzfyZxmgZ95kcGp3h9lCB1/fgf/dlULORtgTnzjzpyRUTaqskE13S8IopYdbvTGApG627snCbj6VyQe0O+WaaNUDbDpMTe5Gj3QnRgUEA7VJQLe5pUIoLIIwa/zE9D2NLK91I70dMs96nqrD7pd9UnRwOY5eNKSeM1cTjs9UwBqQdxXfevt8G4mJFgK9sSeeptU8NEPVlU42B/MoA/dZl/475idMNOHckfexVKfXs9A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hKTcrS4dac4l3mwu1KDMO7DHTK3b6xCTgpeAsO3vwSVYSAy3M1hsLVdG9KUcuGpRL3vqMIknD1XK6flhr+JpNrkp6iL+LQ7/D4B32TOpkRt9b2rudzKZc2X57VdiUhIrCcU1JDvvHOgd5D0+teXLCmaQ8K3Y00gfuyiTOMCHEW3AYGhr1jOKWBYRQ5saRg9ciG2N6I1lo8FXVNoZWT28QE9mhIQwtom9kK/CP65hSYCafqfi9Tt/m8+7QNQjdT6HaWvz1MEaUziV5j/BCWbwhfs7ZE1blu83HiTaq5WYZxgPf4C0owtZNHm9DtA3lI3AP1vImdhlz5F8y/w3vALemASlgM6t9gFn2ywU5T7U9wX66meU4BaVRjcBRm1ccbRZg2WiJHPaOjRePXJiaE/rHz7pOtIBKxq+me0/W02vVDEmiS0R9ucPWB1Bo14qibEkU4Y43fQmqgBXfag5wFlohaKox9DCdDg7oajwnDqLRsASSQvWQB3kpflqX3OHVBCr9uCkIaEUm6V8QDtaZlhyP+/U9hf6O/4g6H/PG1i8ijN81YwEaIt6lfQO4yh7s4fj6vX1aPMb6cDWo5RmNl7OM/D2OHz1Ihwh4FU0FG46N5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a8cf19-9800-43c3-d37b-08de89b63e8c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4360.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 15:01:36.1595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oplfaFDMkUCt3LPpbQ2sP/zMr63cGSdJlLCFB0d5AOFYUcoFFeTfTpdmm3qpQfRFBaZID0wwXneRvJNSS57RWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603240118
X-Proofpoint-GUID: Vo1t7okLdWlwLKjb1GFZ3VDDKPd0O1qH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDExOCBTYWx0ZWRfX2Uky42ndu3Sw
 V+NR0g4eNEaWArYHxF48NGl+a6zF7LB6PEZsNtwq1phVXIuy4+tl+ClCzh7gber6QsR/9exKUDw
 RxrzLkaQjNc/3EKE+qJhfIi4CTJjlTsibhi7CVB5unwAS4657Lsf5G0+b6fcr6+13h1RHLyC+nD
 Cij5Qp4fgMIkTBDv1vyDlu3vYqEx01QgJuOOSmteaHq4OIfmf1rqFVs4YWto8L8p1p9LDGj4MOw
 /ZllCwULDThd+080IIJ26oRy7oQEXTxFMaXHf7ir0SWW3C5lWMKtOT2B65d+A2ZpAF8ygT0cCLm
 8HUbp69i6bORJomhXKVkxCAtHKQJARpSfDHt+xUFoc57ahatxNDNG6RdZjRWzUkzXvgsqtImCu2
 lPOEonhPftWaDNuXnrQ/2gcO7q/gt+1DY+oGQ9fBgb5ZlFybPdc=
X-Authority-Analysis: v=2.4 cv=AIvfpCdw c=1 sm=1 tr=0 ts=69c2a757 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=LzByJgMqCMt144esb50A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12273
X-Proofpoint-ORIG-GUID: Vo1t7okLdWlwLKjb1GFZ3VDDKPd0O1qH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 3/24/26 6:45 AM, Eugenio Perez Martin wrote:
> On Fri, Mar 20, 2026 at 3:20 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> This patch introduces the mechanism in which this series will use to
>> detect VirtIODevice & VirtIONet state deltas, starting with the
>> VirtIODevice's 'status' member of a virtio-net device.
>>
>> Before we send the device's state early, we save each piece of its state
>> in a temporary structure via virtio_net_early_pre_save. Later, once the
>> source VM has been paused,
> 
> While I ack this approach should cover 99% of cases—as I think it is
> unlikely the guest changes device properties during a live migration—I
> still believe these changes should be sent when the guest modifies the
> property, before it is paused. That way we shrink the downtime even
> more. This comparison fits naturally: Instead of sending one state and
> then the deltas at the switchover, we send the state and then the
> delta for every change.
> 
> However, I'm happy enough with this approach because it is more
> self-contained within the migration code. It also reduces the state
> sent over the migration channel if the guest changes its device status
> many times.
> 
> CCing Juraj as we discussed this at the virtio-net upstream meeting.
> 

Right. I agree it would be optimal that, for every change made during 
live migration, the destination is updated with this change and it's not 
left to be handled once the source has been paused, which would impact 
guest-visible downtime (especially if it's an expensive change).

However, the only way to handle mid-migration changes like this is via 
the SaveVMHandlers framework. I did give a stab at this approach in my 
v1 RFC series: 
https://lore.kernel.org/qemu-devel/20250722124127.2497406-1-jonah.palmer@oracle.com/

However, Peter believed that this early-migration work would be better 
suited using the VMStateDescription framework instead. And the VMSD 
framework does not support handling these mid-migration changes before 
the stop-and-copy phase.

>> we compare the current values of those pieces
>> to what we saved earlier. If any mismatch is found, virtio-net's VMSD
>> (vmstate_virtio_net) is enabled and resends all state and device prep
>> work (as it's normally done today when live migrating a virtio-net
>> device).
>>
>> Once all relevant delta checks are in place, a no-delta case will skip
>> vmstate_virtio_net and only resend updated VQ indices.
>>
>> For this patch, keep a temporary always-true fallback in
>> virtio_net_has_delta/virtio_net_needed until follow-up patches cover the
>> remaining VirtIONet & VirtIODevice deltas.
>>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/net/virtio-net.c        | 40 ++++++++++++++++++++++++++++++++++++++
>>   include/hw/virtio/virtio.h |  2 ++
>>   2 files changed, 42 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 5d71ad235e..2733e0130c 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -3864,6 +3864,16 @@ static bool failover_hide_primary_device(DeviceListener *listener,
>>       return qatomic_read(&n->failover_primary_hidden);
>>   }
>>
>> +static int virtio_net_early_pre_save(void *opaque)
>> +{
>> +    VirtIONet *n = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +    VirtIODevMigration *vdev_mig = vdev->migration;
>> +
>> +    vdev_mig->status_early = vdev->status;
>> +    return 0;
>> +}
>> +
>>   static int virtio_net_early_pre_load(void *opaque)
>>   {
>>       VirtIONet *n = opaque;
>> @@ -3887,6 +3897,7 @@ static const VMStateDescription vmstate_virtio_net_early = {
>>       .minimum_version_id = VIRTIO_NET_VM_VERSION,
>>       .version_id = VIRTIO_NET_VM_VERSION,
>>       .early_setup = true,
>> +    .pre_save = virtio_net_early_pre_save,
>>       .pre_load = virtio_net_early_pre_load,
>>       .post_load = virtio_net_early_post_load,
>>       .fields = (const VMStateField[]) {
>> @@ -4231,10 +4242,39 @@ static bool dev_unplug_pending(void *opaque)
>>       return vdc->primary_unplug_pending(dev);
>>   }
>>
>> +static bool virtio_net_has_delta(VirtIONet *n, VirtIODevice *vdev)
>> +{
>> +    VirtIODevMigration *vdev_mig = vdev->migration;
>> +
>> +    /* Has the VirtIODevice's status changed? */
>> +    if (vdev->status != vdev_mig->status_early) {
>> +        return true;
>> +    }
> 
> To clarify my point, I think we should add something like this:
> 
> if (vdev->status != status) {
>    // process it.
>    virtio_send_status_update_to_destination()
> }
> 
> At virtio_net_set_status, or similar.
> 

See comment above.

>> +
>> +    /*
>> +     * Always return true for now until we're able to detect all possible
>> +     * changes to a VirtIONet device.
>> +     */
>> +    return true;
>> +}
>> +
>> +static bool virtio_net_needed(void *opaque)
>> +{
>> +    VirtIONet *n = opaque;
>> +    VirtIODevice *vdev = VIRTIO_DEVICE(n);
>> +
>> +    if (!n->early_mig) {
>> +        return true;
>> +    }
>> +
>> +    return virtio_net_has_delta(n, vdev);
>> +}
>> +
>>   static const VMStateDescription vmstate_virtio_net = {
>>       .name = "virtio-net",
>>       .minimum_version_id = VIRTIO_NET_VM_VERSION,
>>       .version_id = VIRTIO_NET_VM_VERSION,
>> +    .needed = virtio_net_needed,
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_VIRTIO_DEVICE,
>>           VMSTATE_END_OF_LIST()
>> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>> index 74fed8c324..752c46ce53 100644
>> --- a/include/hw/virtio/virtio.h
>> +++ b/include/hw/virtio/virtio.h
>> @@ -102,9 +102,11 @@ enum virtio_device_endian {
>>   /**
>>    * struct VirtIODevMigration - Common VirtIODevice migration structure
>>    * @early_load: Flag to indicate an early virtio_load for the device.
>> + * @status_early: Device status at the time it was sent early.
>>    */
>>   typedef struct VirtIODevMigration {
>>       bool early_load;
>> +    uint8_t status_early;
>>   } VirtIODevMigration;
>>
>>   /**
>> --
>> 2.51.0
>>
> 


