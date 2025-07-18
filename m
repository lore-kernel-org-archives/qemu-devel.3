Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 365D4C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 17:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucpHg-0002DM-EN; Fri, 18 Jul 2025 13:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucow9-0005sM-1h
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:31:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ucow3-00010x-DI
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 13:31:56 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHHjeU003790;
 Fri, 18 Jul 2025 17:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rL1dNVKoI5r0ZHK1+6/c5d0uxGDQgcjsOiqcLo/ZAhc=; b=
 jwfMyARTzqxZRrHGziX1sgAI/CCCJtLPbsAe6jrhn83xJwOBrGLJwuXnbU6cOsU6
 K8Bm+OtT3opFCbAGhvtoUKyWNZy7k/OlFHuDuNx0dl8AEhe9WfbALi+CQyhxr1SM
 +KSOZKRj3kJ4TTx9e/DR6JsWmvymbzyuhPW4vb2SfcjZ5blG6bdJozxFg2j7mhzx
 yJfBinyd5tSsUOrGKU7suufCWobNyJZzD922kPERTztzbYnetP7IL1EwZ8SKlFhd
 jyWyHLRhmXZSiHAlImiwBwZr3581RWDaTMdfktEVWRnxb/0uBptFXWXckQl8kwCL
 vKs/Q8Ee6ZaQjlhU1n/VIg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g5m62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jul 2025 17:31:44 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56IH8u9l013811; Fri, 18 Jul 2025 17:31:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5dv8m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Jul 2025 17:31:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZnl4GH6w+iaHsY6OTK6jqkDMtpmQXcLehTDQ4G47lEOfE7XuGvcJ7WvqmP93yiDquWm1YoDzGW8WvLZ8mscAbCITjz3zIr9TzolptQLlfjIqvx1hRg04QXoDnkfIV4xTdgeNt6QVITroW2L1ovLBWcMBIQeovkFMajRpfpdC90OU5PGzcRoRzSLkW3Z0vaAmF/kedTgTHFF5E0fYWYGB82xmfT15Ev/++U80ZB1ALGJ2ze2rZc88l+0sEG/oYNeiavThSyDw/9/V/shLzGfFv19+NvJUPLe3+j8Pc/if2aZ+hvglHAaxmbjKybzV31Duxpj4xnVJlHidkrsPVagDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rL1dNVKoI5r0ZHK1+6/c5d0uxGDQgcjsOiqcLo/ZAhc=;
 b=rNCVqXS64LgM+e7vQF0hv9RKlSyJIM6IrWbhLtUsy2Dl1nNFeoGwMCn05WHdj8eJQHulyovqPxLHUI3Z3z+XJ7M9HNO1zF6hkrJwd0zOepkLoUaUzyLG2DFfC4nsSKCJtseUQtjBknrObY/m8gemXagNkO/5Bal1dGVTXMgfmwXeUbQYvKt5Qhyyq39unCOLdmRZzTf+I1e3uA8dsttnRGBfgunqkpozF27hk8GJxMZEQK8vtG9b+10oyDpPFmTzaCIAXE9Lrm1wkwsHPRAsAuos8cAn7FAjFNwPBS+NdfQAHOzQgineOWXgWdNfrVGEQJffXuyGKNN/EpsjU8H05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rL1dNVKoI5r0ZHK1+6/c5d0uxGDQgcjsOiqcLo/ZAhc=;
 b=GwPMNvcLkXt9VzME8h3y6T2CMrXIOXdtMpyewm05zo2q59Hg9v8eI9zsFaHXKafrgnT4QnchSL90OYIsB79LQK3AJc8LeOThgXxBVhKNzvsQZqv9p5DOT0J8SWrIdrLyzVXQcoIjqpfarZGObPLUVEgN/RmjhR7cWKI/fNOAQMc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA4PR10MB8635.namprd10.prod.outlook.com (2603:10b6:208:569::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 17:31:40 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Fri, 18 Jul 2025
 17:31:39 +0000
Message-ID: <368d11c5-dbd2-4550-99c4-7675a3bbbbb9@oracle.com>
Date: Fri, 18 Jul 2025 13:31:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 0/8] Live update: tap and vhost
To: Lei Yang <leiyang@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <CAPpAL=y=2os30kCA4_MCMT8OdE3PqGZdg7oBPeS8SKCN0heMrg@mail.gmail.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <CAPpAL=y=2os30kCA4_MCMT8OdE3PqGZdg7oBPeS8SKCN0heMrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH3PEPF000040A5.namprd05.prod.outlook.com
 (2603:10b6:518:1::54) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA4PR10MB8635:EE_
X-MS-Office365-Filtering-Correlation-Id: 22840908-6ec6-4ba6-8787-08ddc620f43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zi9IY1RwS2tBRE5SYzZiendlOW4xbnZITjRSRTVRZEJCbjVWVnhxdG5Wc25T?=
 =?utf-8?B?L3VRSUwwK0tyMWd2QUtXYU5DN0JldGZuYk9MSS9adVlFTEZwckVXUnI5UW95?=
 =?utf-8?B?V3FjN2gvbERKZjhWZ0d0S0FGRFk5amhOZWZIc0ZmT3F6aXRiRTg2OVNLeUlN?=
 =?utf-8?B?N0UrTUpHS1ZyWVZpV3VwS25oMzF4akxaWm5ONmxvVmdFc3VSUGIxOWFFWlFV?=
 =?utf-8?B?Vm0zMC9NMW96NzFUdWVsWUhsazBmT3RkbllYS2Y4YkYzVEYxbDgyL2tuQWdK?=
 =?utf-8?B?TStzQklPWEhkbU9ONmhlOUJKUnV2ck9xTzQ0eW5tdHppb1dxSkJ4NkZLb3Zt?=
 =?utf-8?B?cUtiQUY4ZkFZZk9PcFhrUlNuRVA4ZUxoWm5mNjFmL0tMdERpek42dmdXcC82?=
 =?utf-8?B?bkFXY2duNlE0ZXc0OWttVW9acWVyZGtUbHF1WnRUSWtmMTBKdkRPdXBqakpn?=
 =?utf-8?B?enQ4c2w3YnlneURMSVcrcjcydmRrRzRrSzlNU0RKV3pPUTdDVzV0NXpxK3hG?=
 =?utf-8?B?bUtxZUhWRjZTaHhDQXk1MUZOWnJGb0pMMGdXQW9YUEhqVDcyaTJTV1VXczJk?=
 =?utf-8?B?cG9HNHlMVVV1UStYVUNBbUVHVlM0cExLSlYxZ0lrNzQySW9mSDNidm1qdkdr?=
 =?utf-8?B?dWoyU3RIQ1dtWm5haVF5MTF4MzlSdTRkVmVtdFFDR09QRDhHRnV6Q2NuTzlT?=
 =?utf-8?B?cXd4VWh0emRCaXIrTkFsUmRiMnpaOS9hTkc0RVR5K1Vod1d3SVl2TGFFdmtV?=
 =?utf-8?B?VXBOcktjSGVHTTBMSm5keEw1cUduTFNsRkx1NXpVckNIM2JJTi9tMS95ZTVj?=
 =?utf-8?B?THBDNTFSbDZxbWZvdHYzK3ZKalFtRFBQeXhmV29Ed1EzZXZGd29aaTFkdE5E?=
 =?utf-8?B?YndEdGFXMmdTUXp5WlRlT29yeWJ4K1dodW4rNWNjbU9tV2VvWG5idzNlN1Ix?=
 =?utf-8?B?Wlh3M3RUczhNZURTa3o2a0pSS1dyTlRyUy81L05wWnh4c2ZEOHM1MGd0MCtw?=
 =?utf-8?B?bU5ldElKYjV2bXNqcEVnL0s2bmMyaFppSXBJVUcrdEh6VG5pN1pUK1pnRkZv?=
 =?utf-8?B?cmJqRjkzd1pNeE5sbUc0TnRHK0FQbnFTTjVVSUcxa1pLazE0WEg1YjRoa0Mw?=
 =?utf-8?B?bysrMlJCOFlBWjZNekZuZFBMaXpzVTBhamR1NmJCbTNhZGxlSVBjbzZjcHdI?=
 =?utf-8?B?eEpreVZDcTBFSkMxMXFCaXZVM28xRkFKOUpqOG5mMGlwZWp3QVBNdURuMDlK?=
 =?utf-8?B?d3pBbXdMTFVOcURWVlZ4UlpGbmZOdWVjbUZ0VllaWUxpeW5WaFcwYXF6VnA2?=
 =?utf-8?B?UmZWUGo2eVM3QmNVaHQ5NE1OamxXUU40enlTL2JVS3M1RC9ZT2dpRG9aZm1w?=
 =?utf-8?B?SVF1Q3hnZDRRQmJpbzZNWVo1UHFhSmpLaGFpdmxtZ2FWUXNHNENMVmg4Zmln?=
 =?utf-8?B?aFRBY1RyZTZWL1pkR0NkQzRxNzVIOGNXNWFPdTV6V3ladEx1K2NOWnFEWHdl?=
 =?utf-8?B?Ykx6cmhHMGdST2d2RmRvak11ckptVVArNnFtTzl4VFUxM1BhTjZ6OFgwenY1?=
 =?utf-8?B?WGxEVlFIN1NMUllkRHJ6ZnJhZ24zOU1ya3ZkQVAwQ1h0RVF6RU9qenRZSGh4?=
 =?utf-8?B?aFZnQU5wcE1KYmhTQTJLMzFyREwveTJNS2VrcWdGTDdiMjV5Z3ZIOUJpV1Bj?=
 =?utf-8?B?TGJHV1gvUjdZOCsxVFlnUnhLYzVFamFsVWkwc2hJckxzZDBIWUdka1o0N2w1?=
 =?utf-8?B?OHBhMXdVc3VPK3UyOXhiOXpWWUVmdW4xZUlLRHZrcDdGRURabWFPQ0VUYUg1?=
 =?utf-8?B?R2JDYzFHVjh1azRKSE5LamlQd0JHL0l6am5ZdWFpTUdNN0gyS2FIdnVkMHRZ?=
 =?utf-8?B?MWxQYWx0YThMV0NoSUNCMnB4Vlk3ZERqdUlNamJWWW9IRGZXQldvdERKSFFt?=
 =?utf-8?Q?9J2cyiPxZdk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlKazEzYnZVdjh1eUREcVUxTFRsYWhsUmc4NHlENjAycGpwZUlEeGJMdDNB?=
 =?utf-8?B?SVNvd3ZyUHVCMGdIOHdnSVlJOVA2U3ZqckxTYlpkWG9SY01wT3BsRUdzSzJ4?=
 =?utf-8?B?Y0RINVJVeGxGd1lCMElwR1pZU25uM0w3T3lUZmQrMGRzWVh2VlRTTk1TUlpo?=
 =?utf-8?B?NDZVNy85U005WFpEdm02dGRubldzZTNNUnViWVB4WHRBejdjbHdmdUNzT1pH?=
 =?utf-8?B?Sk1FamIxbm9jK2JEZlBKeGYwN09oNk04b3VhL3diZERIQnhHaStxOEN1Yjk2?=
 =?utf-8?B?bUtZWjNzRFp0eDFBbHZNN3pEbG5DVzE0UHFOd3ZHQXRNNnB3c3huQ3p1U2Fn?=
 =?utf-8?B?YU01QmlmNTlWNHc1VEJON1NaOU14WjhTWTVKaDN0Z3ZSOWJmZytFelI1RytI?=
 =?utf-8?B?d2JXNml3VWhBZlA5cFQwQ2dTbStZdzlYNEFyVEd1RjZIa042UUg4MFNWOGI2?=
 =?utf-8?B?ck10M2w0U1dLTTJHaDhlL0U1bzlOamw1TjJnSXk0eEdlb0ViUWZSY3lHSnhJ?=
 =?utf-8?B?dzAvK2h1WEZVWTdBZzZiNVZqUSs1ODFhWDdvMWVCbnk1TG82amVVR0h0Ym5k?=
 =?utf-8?B?b3BhckRYYVdUWlJ1QnNaMllxMmJPYkI3Q0JvSHpqdFd5dUV0bFBHVHlHSzFJ?=
 =?utf-8?B?ak13c2x2VDEySFl2SkRJSjVaZERRVmwxSWxSTU1oeWdtWjJMdWM1TG82SzVn?=
 =?utf-8?B?UjEveEFMTUx3NXErbjlKMllJSHhZRk9Vemt3WGVQaFFsdjVVaE9IaGpWZU9M?=
 =?utf-8?B?aFRzdHV4Z1RFU1pxREx2dkx1eUthdG5TK2xReXZUb3JNb1pBRjMvSkZuNWJ1?=
 =?utf-8?B?S1JrSUlNcmEyYVYrVk85bnMrMEdMLzY4WkM3N0FzVGVqM2UybUhZdlM1SXRJ?=
 =?utf-8?B?STdwSklJVndFWWxHWEFUL3VKR1hYQkRGMDJjSFNZN0RhUGQyd1FrcElxc213?=
 =?utf-8?B?WmwwdXMzek1QNTRteDlMbEZMcGYzVDlKaTZsWDVTNC9mU1k2cEZtODR5MThV?=
 =?utf-8?B?Rm56aGpDQTV0blVITFRScFdwR2w1WUtjQVNqeERxVnZIRytPbG45eVJsN3RD?=
 =?utf-8?B?dW55Zm5WTzJodGVWRldsSWk2cEx5bklZN0dqNWY0VEcyYm9KbEtRUEdzN0FQ?=
 =?utf-8?B?TzRmbUpldEpsd1BGbXpLeXNNQUZadCtWbEMra2pPMTN5SWh0dVNCSHg0TFdx?=
 =?utf-8?B?WE9Uc3I1ajAyWllDVFU5bGlDZmNTcnFpWHdHMzBoTVVycmliNi9xQ2RhWXM3?=
 =?utf-8?B?ME52azRCSFBSM3VObm1UUFQ2VTNSdmMyL2Urd0MxblNTMXEzZ2hsbXhHb2c5?=
 =?utf-8?B?UlhQbW9vbXNSeG9DMCtncHhYQjU1cHBBVGdvV1ZpaHRQYkVQUEQwSy91aU1w?=
 =?utf-8?B?TlQ0VVRkaHpBakdaSnlPZllCcmNTcytrSTBXUUtuelBtK21aeDlLaEVUbDEy?=
 =?utf-8?B?bjQrS0NoZEFqWHFLQ2hsQ0FLMWZXb2lDbit5S0h1Vy9Dc0J2YVFEVzFMcUlJ?=
 =?utf-8?B?L0tiRzhiU2VSMDd2ZnRlY0JOQUdCc0hsY2pnRVF1Z05oOWR1UVQ4ZGJxdHFS?=
 =?utf-8?B?SlVlTDBEakVhYWRZQkp1R01tU2FQcHFyZXlOOHhnVE8xWDlCdjdLRVpia0Va?=
 =?utf-8?B?aXg3OWdET3lja1pBWnlKamI1bkowWDNYaU5mL1NHd0RObDE5OWtTQzA0Q3Vh?=
 =?utf-8?B?cTdUKzdrc3lNeThOaU5jd3hTWFk4NmErVTVoUnFNVFEycE1rK1hIZEVSZHdC?=
 =?utf-8?B?Zjg2VDhaUDFVVHNlcmd1VzhWcm9pU3FiVk05MVFKaWhLRm54aVM3SkZMZGNp?=
 =?utf-8?B?bTJWRHplblZoeW5JS2N5TW9MbDJMQythMG4yRnNkK1ROM1pPRENyVzdPMGlH?=
 =?utf-8?B?VVRSbjE1M2x2TXkybW9MeFBRNmw0bFJCYUNKM3VTSHZHOFV1MnczS0FCdnlR?=
 =?utf-8?B?UUJjZGZNM29nazI2cW9SZ0s4T2NiaDNscVpud2hITVZudGNwTWt4NnpaZzNK?=
 =?utf-8?B?Q1RTRzZjT21VVUN6bC9WQ0QzQU5iMEttSlkrbWF3U0tuM2UwYzlpc0ptZ1E0?=
 =?utf-8?B?WHNWR0haQ21IL3VhU1FwbnJJdE1NZWY2czFKamhEYWl3c1Nxdmc1UTRKOGxZ?=
 =?utf-8?B?b0txYkNXRUpISXA1L3lIdm55VGpxUUxSNDcvQlRwQkJLc0VMOHZLWCtrd2lJ?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dcjKcBZbNt8P+qiqsVj9n/3kFecQ5XvqeaLhz3U2sl1BG6t6UEIX1W+UlC4UY2LAfbxYNfOKUF2KSiTaTo2mpVnDA1Js5GO23KgBHbDptpAW+RujF1S1JZMkyMmKUbMJTpfjBKmqtq/eZBJdfAKsBfaM1lMK5keBlQgBSQd8TrcjuyIXAGizEnhwm1kwxl+zf9jnrKVaegweAOwarKFQ1cTBKeJeNwP6G7Xk9KNvJXoIYWY6/Ai0zqOv/8rw2j2IXX4fdcSzDIXv5t81gdl5pep1eU0nJY61dAa+/gQxN+RNYjHeYAF0DvcMam4J82mt9n7+FVhY0uR22bLOI+5juhRMZQ6DlCb2+B1ThtbhzBa4Dltr2kzuMR4LUh/PwkBnDDT0YCzhEygXKPCXT/k5gGCrBSjyc2/EbGEACGmHmwb+wZIJ7bNChY4FB2Uv+fto4BA6lXV0co+82zYF5rreeWpP79UbXMb/fxVNMOR4Yr60qpt2AQsHPWLdUGfYtgkRh0hQZpeCGQGiX5Cr5YQPzZqGkeMutiF5JrgiwdnVpRadNorbKY8ZWN6e0xFb43dN/rqGAtOT8z7Y8x6YnHOH0FbUrsTynxNnw6n01x2rDfo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22840908-6ec6-4ba6-8787-08ddc620f43f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 17:31:39.8226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moIBrFAUjoNHpX5/iKkZMdTdRM96PLmd+DeyspmPG9XyqaXK4LkuQxSXi35HGGciHLuMW8jKTbbc+g3gLQkh53sEQOzWHFc/AnRPVecGPYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8635
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507180138
X-Proofpoint-ORIG-GUID: e76Y-kdrC_Mc1xYrjWDmy1iZl-D1L0kp
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=687a8500 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jNggveMGteVPl1z8NNEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: e76Y-kdrC_Mc1xYrjWDmy1iZl-D1L0kp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzOSBTYWx0ZWRfX4P4wT0+kziOi
 qc3S9y6r3Hrrgwgds9V/rM4uVCbaSWqg0s4LMNQdSedAyRFwHtHyLcHunrcVHm4kduDHeuSyV4l
 OkrGbTyT18SbBz5NigmDd0XSFthwlh1SE2vOjCIZDjZ2g3pD488gWn+tQZzhBAA6KeOXJ7FErs2
 uHZDTwDNHWtqsMqZnvPVyoyBIgOGLWsqDsyI+r/0+iuaN5MGjZDql+cWWfl2lJvYU0XV7umWxVj
 wdxatFZUvTCekuak3e4uQu5okdyxbUyj7p1qDInTAvRqRpsth3yDE3uRmckJ8VUmdkj8GOdSku1
 scexlXtHWXmW9WOvnNCSucSARUYbaz9O2f66oDoF3qoNLRhWyo90Q3JMooQtm7BXVwMXyKHT8zj
 U+PF1YbiIr4kU3HzNPqB/qUPlNVuyjQp7sAd+JBaeNzd6pVTKnGVg+jNI71Wp5DFGQUQcLy8
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

On 7/18/2025 4:48 AM, Lei Yang wrote:
> Hi Steve
> 
> I tested your patch which hit a problem under enable/disable nic mq
> state(The full test scenario is live migration vm at local under
> enable/disable vm nic mq state):
> Run command: /qemu-img info /home/images/vm1.qcow2 --output=json
> Error info: qemu-img: Could not open '/home/images/vm1.qcow2': Failed
> to get shared "write" lock
> 
> In the same environment if I remove the enable/disable nic mq steps,
> it can work well.
> 
> Note: This issue has not been reproduced 100%, but in order to confirm
> this is really a bug, I test the following:
> 1. Live migration vm at local under enable/disable nic mq state: 3/5
> reproduce ratio
> 2. Only live migration 5 times are all passed.

Thank you Lei for testing this.  I would like to debug it, but I need
more information:

* did you add the cpr=on option for tap devices, or is this just
   a regression test of existing functionality?

* What platform: linux or windows?

* Is this a publicly available test that I can run?  I cannot find any
   reference to "Live migration vm at local under enable/disable nic mq state"

If this is not a public test, can you provide more detail on the commands
issued at each step in the test?

Thanks!

- Steve

> On Fri, Jul 18, 2025 at 4:48 AM Steve Sistare <steven.sistare@oracle.com> wrote:
>>
>> Tap and vhost devices can be preserved during cpr-transfer using
>> traditional live migration methods, wherein the management layer
>> creates new interfaces for the target and fiddles with 'ip link'
>> to deactivate the old interface and activate the new.
>>
>> However, CPR can simply send the file descriptors to new QEMU,
>> with no special management actions required.  The user enables
>> this behavior by specifing '-netdev tap,cpr=on'.  The default
>> is cpr=off.
>>
>> Steve Sistare (8):
>>    migration: stop vm earlier for cpr
>>    migration: cpr setup notifier
>>    vhost: reset vhost devices for cpr
>>    cpr: delete all fds
>>    Revert "vhost-backend: remove vhost_kernel_reset_device()"
>>    tap: common return label
>>    tap: cpr support
>>    tap: postload fix for cpr
>>
>>   qapi/net.json             |   5 +-
>>   include/hw/virtio/vhost.h |   1 +
>>   include/migration/cpr.h   |   3 +-
>>   include/net/tap.h         |   1 +
>>   hw/net/virtio-net.c       |  20 +++++++
>>   hw/vfio/device.c          |   2 +-
>>   hw/virtio/vhost-backend.c |   6 ++
>>   hw/virtio/vhost.c         |  32 +++++++++++
>>   migration/cpr.c           |  24 ++++++--
>>   migration/migration.c     |  38 ++++++++-----
>>   net/tap-win32.c           |   5 ++
>>   net/tap.c                 | 141 +++++++++++++++++++++++++++++++++++-----------
>>   12 files changed, 223 insertions(+), 55 deletions(-)
>>
>> --
>> 1.8.3.1
>>
>>
> 


