Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9072DD6A221
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBehT-0007zl-Lh; Thu, 14 Nov 2024 13:36:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBehS-0007zJ-Lp
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:36:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tBehR-0003Mb-1k
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:36:14 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEDG2FS008430;
 Thu, 14 Nov 2024 18:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=qhsWd8o3TjG2IKuIkHt9E4NAMgzc1CX9WoA9pIefRdw=; b=
 V7/E1I5Nz4Sz3S5U8hVy8efEcME0ghH1r7NzDDYpqBK7D8kx7ZKNr/N1PbxTwD21
 a87RYn3ZiRa05aYgbFC1CUP3e5iA6mhKnCW5ABbUcoToZ0I73JA+xpK6VWm5F2VH
 lHEPuemU0Y7SojZArmxrjVKH1i4AJH32mPux3/l4toEZGKC8P1hgrgRRPypCu9Yc
 jC7MUIAaf1CY0IlRfX5N9HZ6JFWh7WB8cnKEv7mzi/FAKlbKgevOo1V0u5/ddi/J
 M7jKROa23JXg5WeeqEZt8cH3oLg08zCQG/c7JUYpvCb6PJ5dXtxUSYTU/I3vG+rO
 mfjOEcobleI1sM15TLPRtg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0n51x21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:36:07 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4AEISmTA005663; Thu, 14 Nov 2024 18:36:06 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42sx6bken9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Nov 2024 18:36:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Syp54yoRPdluLmXFrtWRdv/YZEorjyFqSgCK+hJDKR9OwHqnUfA+ysJj7+0Q4sdKdemJpt4FJ3PtPVaz1hyDc5P0fD06yTQETkC2Qkxs3bSCDXUcfEJb9HqCl+3DxF32EdbfCrxfcXiOC2SIU4mTi1J//5VI1O46M8jQDOVQx10H5vUxAaZRtLszvAuGfIvdhZGzHXb1hAg3sVOAg5B4VIsXmPr4KrjTBmIr8ACsqqLIP4RbDZ+bKuwRIPDYvHfYmAqc6BGs5whEYQNR/B2CG7X7zJit2Cnz5hzoHh3SK0lJP9aBqaK17HP1sgXhIRiCnJ7jJ8i3aMJ+2g1rojj8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhsWd8o3TjG2IKuIkHt9E4NAMgzc1CX9WoA9pIefRdw=;
 b=ladNxA/J79U/EQ8Kc71pKlfb4qlCC1f2hngFwP/MspMSSZHIDvO/U2O2TmWTHtbQ8YD/rHcGddbPYsk3yabZKoEkJYpoh7jRIhNELw3vxMfsGFM918E24IcAXeWb6oVa11INUv0tPQkAUZyjcEeQLGzb12jtlcCO8MqzA7qwbdSbfBWEnE0VvEibj9hpo5HG8tHlJcmeR9BayD8C3TwLIZ7bZujVQGwydCUBJ/8vkVgEFNoPr8nzqJzw1eSF+I0XipUQZLohsjF06VGd4eyanzWi/m2JaKABsM4r0D8YMP1Bd05KtyaxA6UIYg8U/4NSbqCJFTaiG0gOKyKc0mUErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhsWd8o3TjG2IKuIkHt9E4NAMgzc1CX9WoA9pIefRdw=;
 b=rgJR4pbcwgt9ne2RcepZ4f/7sQf/Ex8j5XBgmzn784UYPPRftE3qEfm+r9ju6VUa9H6rnvjYABceYjIAJYh5AObz2QcKqLKx3s9O7HOy7n9BDuQPlELt7AUwDXUHSh4pDDPfWxnrIGvy+7ilkhHY5LN9jwyOp0qAfisKO6d4K1o=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH0PR10MB4807.namprd10.prod.outlook.com (2603:10b6:510:3f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 18:36:02 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8158.013; Thu, 14 Nov 2024
 18:36:02 +0000
Message-ID: <51967cb2-05ec-485b-a639-8ff58d565604@oracle.com>
Date: Thu, 14 Nov 2024 13:36:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 11/16] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-12-git-send-email-steven.sistare@oracle.com>
 <ZzUg9w0Kvfuleuxk@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <ZzUg9w0Kvfuleuxk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0569.namprd03.prod.outlook.com
 (2603:10b6:408:138::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH0PR10MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 6509b484-6623-4538-d88d-08dd04db310a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RGZzQ2NQcCtzc2JldDV1SDg5YnFhZ3orNzc3SVNUM3J2dVEyUFNzdWkxWUEv?=
 =?utf-8?B?OXNFL0E3aDZpdi9LY2hxTXIrT0k3TU5FSi94RGV4Yk1sOWhGZ3lGS01oN0dB?=
 =?utf-8?B?c2JFYjR3WUJ5YWZKQ3ppL3lCNFFDdGRXTU11Qy9scEdYbkVhYkdRRHhxR1o2?=
 =?utf-8?B?OHJJcEw1VEZVNHJiSFU2bHRsb2ZPWDZ1TXI1WUVVOUVnYXh1ZmNmcDg4QlRS?=
 =?utf-8?B?YXBoVXJiZXZSdExzYXhLNEo3MHAzdjlzRjRYV3JSY1RRY3B3M05mSlo2R2U3?=
 =?utf-8?B?ZTNGOGN5amhoeXpNUmlsK2Ezc2VRWGxXdVBmazBqMXdPdDFtNkxDWkJ3Q295?=
 =?utf-8?B?MzhseFRDNkRuRTdHTTc3cTBXSzhUZkZPblNtMEZUanNKcWp4Q0M2MXhxeTVB?=
 =?utf-8?B?aVBCRnZudUVYUERMTlRoOWVUbG50cFg3a2JJWmtITzR5TnBNZHZSa1pJVWZo?=
 =?utf-8?B?WlIyQldiRTlFdHEzeUVJK1piN0hPM2JDbkFaZTNqdHJlek9GMHI5WWFXa2NH?=
 =?utf-8?B?ZVAweUJYNXF3WVVJbis2aXdzM25vWExPMWtwY2tqUmtQMjFZUC8yMEdhUm1P?=
 =?utf-8?B?Qk9URmYxZWdQQnNuVm9JblFSbThKbENJTytGK3IzcXgvUE9xVGx4OUw1azBD?=
 =?utf-8?B?cXRQSnpIOG9iNTFUNzBWYkhjUlJOVkJaL04yVkJxdGJ3WDkyRWNmOWF2ZDho?=
 =?utf-8?B?MkZwWnBNcGZFbWhyeHZXNFJhOTRwakpUNDgwVGh5eVMxZVZuUFJaUFFvTXVQ?=
 =?utf-8?B?SHB4ajhUWmMvVCtZTFJMRFdVUkJwS3BHcUp4ajYrRXpSdy9EUU0yOXc0Z3lR?=
 =?utf-8?B?eEZ3c1AxQWZOV0ZJZzFPM0JzRmNqbzVpS05ZYVRNZVc1SWV5cTlCbHRWbDN2?=
 =?utf-8?B?STJDaEtUNndCVTJsV0MweDZ3TFovYUo5YlNOSDkxeVpBOU1PdmovU0V4dDZI?=
 =?utf-8?B?UW5VMHlzVTlwakEvV2swUEhTMTAvVklSSVpLcXZYZGVlU3lpSEhWc3I1RWF4?=
 =?utf-8?B?UTlTa2tvampTdENsMWV0YzRvM09wUnY5TWt0cTV4R2Z5N0NTdlk3ZWRIdFBD?=
 =?utf-8?B?VEFabVh2NDMxbWlGSnlOdFZ6ZEJRWWlRWktsNXhqcitqeG5nSEJ1T2JucG5J?=
 =?utf-8?B?bmh4Nk5lclQrS3ZBS3Q0cGJKWjB6Q0FZTkJQRHhLemMzMVhnbVd0aGFJUFFo?=
 =?utf-8?B?cGN5Y016ajRCM0lCZGZXQ2RPVkZTZ2dkeTVCQjFmdEZwUXN6eDNLY1NXVCtO?=
 =?utf-8?B?WHg5UjdDY0xVYW5aeHRKdGxYeDFLKzRMM3kzRUtZdm5NdDFGRTFyQm9NVVQw?=
 =?utf-8?B?QVhCSjhRV0FYQldXdE9JM05jK25oek1KbUNORjZCR1dqZ1o2QlY4UHZ3ZWph?=
 =?utf-8?B?by9zTE4wUWdFOGp1MkxWMFJPZXJBZjNwZ0kzdVhKeTRNT09BNHQrbGZoQWhh?=
 =?utf-8?B?WFh0SGNkaTJ4bFNDbG9kc25jOW1GV29RS21JS2JBcVNwRkY0RzgwTjdoK0xs?=
 =?utf-8?B?VFpCTEhTVEVKYWV0aHBNcjVETGZYQkJ4b1ErenJoK1dKZGMxeFM0cEtCVU85?=
 =?utf-8?B?WFJaQk0vRGx5WlhEaHo1T2Q3Y3psRHFUYitBY1paZU43TXJuK2cxMFQ3UFZ5?=
 =?utf-8?B?K2UwbEgzQy9EcVFpNXh2NzF1d3U2bm5SbHVXbWtyTzJzaWRsNjNtTTlwcW9W?=
 =?utf-8?B?NFNHdGFTTTRsK1pGTDdFclc5VmlmZ1Naa0luOGMvVnAyUXdJRVRwQWYzeXoz?=
 =?utf-8?Q?uedCVtcQgrIWBgIh2kplApsPOQAKLD8Z1ojTysk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3FMdmlIWmZ4Q2ZIU2gwYUZMOGdEUHBBQVFzVGM0SlRlQlhKWHNZV3JkbVIy?=
 =?utf-8?B?cVIrQmozZExsYTdFajNtd2IyK3M5WTRrZTZlZGlMdmZ4ckU2VWlnbHk0YXNJ?=
 =?utf-8?B?UVhiN1VSSlFhdUZvWTRnLzdKUWZWbTMxcjRtSU1UYlVnUXF6TVIyRjhxSHpQ?=
 =?utf-8?B?cS81ZDNSMTlZeGpTQlVja3hMdG92VUhWcm94YmNRWENQU0V6SWRkWTlXdkJu?=
 =?utf-8?B?VzBpeUVpZTFSOU4xaUpKbkFQbjQ4UUV3Sk0zVmF0WXpGenFBc280M3UzUGdr?=
 =?utf-8?B?TVZOZzY5ZFU5QVNXM2l2cmp2ZHVFekttSDlkMS9lWDh5UjZncnhPUXJBeWhL?=
 =?utf-8?B?VlErM2hpQkxJNU9KTVB4QkZJRkh6TlpKNXdsOWFZd3VkMFRpUEFpZ0I1RWZ1?=
 =?utf-8?B?ZGdpcCtoOG5MeDBQSG9LNUo0dUxSYUJGbXF3OUhSeDhsZVdTMi9LYWU1b2tO?=
 =?utf-8?B?U2lxWGI0ZVVLK3RKU1l0SlM2NHBhNXAxektHa3owZWJ5NStDZUplQThBQi94?=
 =?utf-8?B?NTdPZXhUZ0dQNFRZSm5iNGJXck5NUFl1cnBwQXZYK21NUSs4ZTNKaDlwMzZk?=
 =?utf-8?B?YUwvZVBQak0xWDExK0p1M1hYM3hnbjJja2NyenJKN0E4MTk1eHF6WEZGc3Va?=
 =?utf-8?B?OEl0YnNzMnVvTFYyUlRIc2JDRDR2N2U0ME10clZ3NDN3cm05L2p4RGJBb0Qr?=
 =?utf-8?B?ME4zYzFLQzhtMkcwSDRCcDdxbS9sS2NwUGo1T3ZxNmY0VnpvZGJLTmo3aUhi?=
 =?utf-8?B?Q3N1Y0dqWWlIRG1ScXY5ejdhdHFiZTlpeVczY05rdEY5RXlnQVZvaHMwWi9t?=
 =?utf-8?B?U2huaG80bG52MDBiSTVPN0cxRkRldGNIdUViV2g1RXRESExnOVhwaGFCYzcr?=
 =?utf-8?B?Yys3TnZHL1lsTC9VNDRLUjRtMFB1R0c1bVB2MWxGeWpwZ0lCV2NyL3hJNlpG?=
 =?utf-8?B?eTBvUWU2S21pYTJDTW5ldWYzY1QwRE5odVo4ZUlsMVd2RDBncjltaEg3bG1K?=
 =?utf-8?B?dlp3dnhEYkd4Y0RaUnl1ekhDSG4yL2ZRL0JLOUpHbklJMmg1ZzhFWkdxRFd2?=
 =?utf-8?B?WFZXT2IyMlQ1bnpHb2s3UDVTRGZvS1dLSU1BL1Y4VnVxRFpBRit4eVRJZ3dQ?=
 =?utf-8?B?cE1NZHRrQk1nNkJqMkpvM0hFVVVpODZnL3VjVGRNbVRYWisySmtRRG5JZjFD?=
 =?utf-8?B?dDlaWG9nNDFiS3RSVnBRK01haU5VRFh1VDBra21kUnVHN24xUUI0QUowWGlT?=
 =?utf-8?B?L05EdTA0Q2VxcnBZK3UxRGN3REthOVpWcWU0ZU5tR0ZrTWZlVnJIaDdXWWdj?=
 =?utf-8?B?MzQ5US9tZE9MMDJJRlFkOUU1ajNaUFRpS1VhTDgramZHdFcyZDFxZFFNa0o1?=
 =?utf-8?B?REU0WWxOYjI2MHBZalVZL2hOZTN2SVNjdzhVZ3BpWkMySy84WVFQQThQU0NG?=
 =?utf-8?B?a2lDQUwzQXozUkRyazk3UmlGc0RvaW5RRlVsbWZ1MExrejBDS1A1UThWNW5n?=
 =?utf-8?B?aktYMDJvKzRIVG5KdE1FV0RsVytHZldJTlBtbnkrcVVpMEFBUmd1TndaZ2JC?=
 =?utf-8?B?TnNnUUhtczJBK1VFREVyYVNrM1JKWGo2cjlVL0FWVTlQeVdOSEtYbkRoa2tR?=
 =?utf-8?B?ZEdUYVdFeVhNekhyckVRR3hsTjdHdkFUQkMwYjBiNE5qOXZOZUM2ZGpmNUJy?=
 =?utf-8?B?VFc5RWRDOVd6Ykxxd2RyaVBEVEpjM3lhMS9xTCtXU01zNTN6blNvTXF1dDdJ?=
 =?utf-8?B?ZG5CcEpzOENENFFLRHYwalFmUWdpbTRjc0tBOEJCTjlSQStwMWtlQy9INzVr?=
 =?utf-8?B?RkkvSnlSWGRDRUxkTmd4cXJFcHdpZ3lYZ1BlZ29oeHBaamY5T3VnYU5iMTRG?=
 =?utf-8?B?VHgzeHYvZW0wS1EwVXpSYVQxZ1VPdWJYbkt1Y21QUGJWL0xJNEJ5NTZtTy9G?=
 =?utf-8?B?SjBRZWswMDNwd2NZbWlmdmFkTFZJZGY4dkNpb3o0a0FENFBQd2I3b0ZYMnl4?=
 =?utf-8?B?UUZteW0zajZlTlBRcE1QOTZXUWtQZGlIdnFNYWJidm9tNDd2MldiM0dDSWk2?=
 =?utf-8?B?bXZEWW42NUtpMU5UNG1lUllPZFhHQ2RXYVVINFhUT1FXNHZya1FjYlRjQmx1?=
 =?utf-8?B?dXRGc2VaTmZJYXU3UGZ4RWVqWCticEw3am96bnN2Z0R1VEg0ZWs1Um4yMUZy?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5Sc/M5o4uWJR+p4vujric/O5QOLDIe4TfUE0YpE8PmXuNSEA2/adccsYG5YEtrYIf9eFcUjZbU6pb04YJykNfa8JZFpCQaRQHvB8I22X2BcFEDmHRePHC0yv8DFd18IH2gmMF9g7QkWzj59+usU1o2PgmRPUr5O6alybx5jAgcGqR6ygn0Tk7i7bgJybpgEj0RRq4DeZp8FGPH4pdamRX7B7nsEyZTvIJzL/4vxxf0vCloEkmJxf8buQCe237GHPcY5jNVCu+Tp5cnBTu4dvdA5asQCcLGxje4SPktHTE2bjN+Du78EORN3+XsrGbmSR+WxplGYK+z8eaVG2kFpZ6HPPjIZ/rkthy7v6fmOBQ1fAJtMoXogkZjAZ1XBfg2zSaOuUzXjoDzyZE3W8hBdwX2Abxt0k9sRv9QU9gpfV3OFBHuTqSluVrZ08QsZyBAiOKWJ3Z4uoT7dG2XOPt0byWEbjWPInkD/abNwPCKogs5JVN4rf/7YR68pSe+Kav6JtermpKJqGwx9RAn4u6oxnULTQ7RuWd354a4TBl3Aaq8bn9XeHkXi2EjmCBsmG65/EN4DBscQkXuFLOTObBVR+JyaQBgaAF1vQOtEkq4PLJr8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6509b484-6623-4538-d88d-08dd04db310a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 18:36:02.5047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXZ4a1kXZzIuO+ReT4xFMzrR+7MWSLpsrPiONMGehZhx1hmAqyQUEQx4H2r2OS0psiVP4jGIqGikFO4XALabTkXoVUlGqvuYfASKQH7vYIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=841 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140146
X-Proofpoint-ORIG-GUID: 1Rs-G3Y0NJigGQHc9Yqgkv36MKGHIrWK
X-Proofpoint-GUID: 1Rs-G3Y0NJigGQHc9Yqgkv36MKGHIrWK
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 11/13/2024 4:58 PM, Peter Xu wrote:
> On Fri, Nov 01, 2024 at 06:47:50AM -0700, Steve Sistare wrote:
>> Add the cpr-transfer migration mode.  Usage:
>>    qemu-system-$arch -machine anon-alloc=memfd ...
>>
>>    start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
>>
>>    Issue commands to old QEMU:
>>    migrate_set_parameter mode cpr-transfer
>>    migrate_set_parameter cpr-uri <uri-2>
>>    migrate -d <uri-1>
> 
> QMP command "migrate" already allows taking MigrationChannel lists, cpr can
> be the 2nd supported channel besides "main".
> 
> I apologize on only noticing this until now.. I wished the incoming side
> can do the same already (which also takes 'MigrationChannel') if monitors
> init can be moved earlier, and if precreate worked out.  If not, we should
> still consider doing that on source, because cpr-uri isn't usable on dest
> anyway.. so they need to be treated separately even now.
> 
> Then after we make the monitor code run earlier in the future we could
> introduce that to incoming side too, obsoleting -cpr-uri there.

I have already been shot down on precreate and monitors init, so we are
left with specifying a "cpr" channel on the outgoing side, and -cpr-uri
on the incoming side.  That will confuse users, will require more implementation
and specification work than you perhaps realize to explain this to users,
and only gets us halfway to your desired end point of specifying everything
using channels.  I don't like that plan!

If we ever get the ability to open the monitor early, then we can implement
a complete and clean solution using channels and declare the other options
obsolete.

- Steve

