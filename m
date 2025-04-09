Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA32C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 14:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2W4W-00052Q-8J; Wed, 09 Apr 2025 10:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2W4J-0004tK-8X
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:06:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1u2W4G-00081T-Ot
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 10:06:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5397twn4001174;
 Wed, 9 Apr 2025 14:06:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=WglDVfoL17/jDkZSpNI45yi4oV8LRFiLUfpdZ7I1jiE=; b=
 MIY/baAP2D2KFP31IWHCRS7COTsV+1Jjm8U+vB4wVwzk8BAm/WKA84K4Wl+PfJ9c
 lkZRdnph36nsQ2VkRe7RUA4pzW/yS5WFrlSY6jZzVHDoMNFT/NLbSVLNlYBDiSHL
 vpx4u8SgTBQacmHujmqgJrKMDK8feeHHuOJdkh2pQsB8MOlYKD+9rzyl1pIGcmVH
 9UHoTc1ySwO8DBUptDHfBfTz+KbqPRC7x2LFXnM7h3skz8YJcHV95jCRoHBHTYPs
 INGf5Hq64PwHnCukdLCX+t41vBIX4bN4MoesidoFtOnKahyoAKPTalRnxL3zTZIJ
 /3INg9pExhEw2ZBrBomYUQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxcy798-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 14:06:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 539CaCnO023896; Wed, 9 Apr 2025 14:06:13 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011026.outbound.protection.outlook.com [40.93.6.26])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttyh5ku4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 14:06:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bz+mMjUiupfMftIPA5l8rUUSkK2Xj8U2MZU0RpujaWix9HckDcO6OwSzChBGvnmExgsF707RGUk+yr2PEKA4TJ27RGsM1QoyIrYDH3UwHqZFqZreSbGJPMry4/1uqJDN9PqenDuj/1kdsV/IZgGm0aaQi4ejbuuWqZhzup5Y83lcSBlEbLq0UTkF4mq1cr889+soocsB4xpS13IepEgDuydsfcjHGIVWqP08SnDM/RWcvSRrQbe9AZQI2SKapaaoawpyff9r0Xva4VHyQGeMDwISg76vlBBQadWJhDroCTmKJd7yyaNlCZh61/pfYfHMayhMuSy68a/94rU/mrGKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WglDVfoL17/jDkZSpNI45yi4oV8LRFiLUfpdZ7I1jiE=;
 b=WIND/gUkpyQUXfPJQ0V4inb+dzDOhDUTNZQV7g80DOZqyN1oGV9KUhAjs9K+fJRflyPbHmxNWA/4b/vH2/btktCCKifHTG7U5oY2dhRPtvtWizZBMH1kl3g/i/nazIDjNcEhYW73rQHoxyoEC6fz6z4L0r058rIZGjwvDAZKdaiJQKvrgjiNtcdiyklc48gT+Ni9CqdC6wCah3eT3nLajcSyKbnnhPyWssboz0JjZT4WqnNqQN6tobrbc8ta5mthBgm51JWpzZgM3G1mrj1IpvFcFSLYErJ6YWWp9PTNKpdk/iBlIshlHzvDpnF6U7DXYflx8e5EmB9hUXhqSyEWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WglDVfoL17/jDkZSpNI45yi4oV8LRFiLUfpdZ7I1jiE=;
 b=XXv1nbd5pC1Kk3eCbpBYZjNzJJVXaflsAKcGVPqaT9qaR3Vzk92q9kaK/Bd5u4/jCV6Mg4Kq8K5qpNLDksfJxVLGPrfRMe71JkUjNpMnqTfKngsau5w7OWTZZ8zdTcQlvVh1aECpKc1yaEjJe1GYID8pHcYalqFR69vfnlzHiR4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8273.namprd10.prod.outlook.com (2603:10b6:208:573::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Wed, 9 Apr
 2025 14:06:05 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%5]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 14:06:05 +0000
Message-ID: <507cd943-5922-44b2-a0cb-1b85f0cfd074@oracle.com>
Date: Wed, 9 Apr 2025 10:06:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/6] fast qom tree get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, devel@lists.libvirt.org
References: <1741036202-265696-1-git-send-email-steven.sistare@oracle.com>
 <87friheqcp.fsf@pond.sub.org>
 <86bb6d0f-63a1-4643-b58a-1186a73e3b17@oracle.com>
 <87mscp8nlu.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87mscp8nlu.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5ad2b8-9ee9-4fc2-d03d-08dd776fab45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1htWVRwTlcvRm1WNnBrRTZwK3gxTTY0K0ZqVnNITW94bXl3cDh4M2JsZmJT?=
 =?utf-8?B?WlBCc0NVU0hGOG9aUmxTTTh6QkFwWHgxOFFQeFFZRHBTMTFmaTUrdjFYaWJY?=
 =?utf-8?B?Mm01UFM0NWFxYTI4VmJyZmJEQmdLWjFkbVRVREZmWkVIRGxlSUhoZks3aVJ2?=
 =?utf-8?B?dHRMWk1OWWZuK1dSWGRvVi9RMzdaMWRpdTc4b21FT3BOOFB0bVpMamJNZWps?=
 =?utf-8?B?YzludVhTUlRBeW44UWh0TmRrTmtMNHNUVkNxL2tKRG9rSjV2TUR1OVJhZUhJ?=
 =?utf-8?B?eGdUMnBFMDJ5eDVMQXo0cjZiM2piQVdSbmlGUXNrOGRQRXVNdm5WQU5yR3hT?=
 =?utf-8?B?bEsxOUthUGtrQUVLaGZSaTNGNFNqQkNjbWI5WitONDVWcnF3UEIvcHVFREtz?=
 =?utf-8?B?L29VQ0wwZ24weVhITGNFTS9nanF5MDEyc1JRTlVTb0ltWGFCQVgwUkEzUEpS?=
 =?utf-8?B?QWEyYWdSWGlUa2o0RFYzZHNYSWVhVUhkMHlwZ0JvMVNzK0NkTllLaTY2Lytw?=
 =?utf-8?B?TldIUUFSVDJHenBqRjgxTEZSS1VLWDRQN0ZDbDVyeDllL1ZWUm1lSHg1amJv?=
 =?utf-8?B?Z0d0MDZ5SXJQelZ6ZEREdk1QKy9ZOVNLOCsrNC9tUGp5L2I1cVJybjZFK1VS?=
 =?utf-8?B?cExuVzVJdGNkSDZDOE5DRkNCd0NydnZrUkJmbUxSbEVoZjFSN3ZTeGIvbm5w?=
 =?utf-8?B?MFNucDNwS1JHOWo3VSs5YXVWTmd1dXZ2Q3lhYTIyNThabHFkdmova09yZGhv?=
 =?utf-8?B?eFlYTFpDT2hYTWtlLzlOT0JLNzdacUVIenhPY0dzNUZJcnlTQms4R1p2RXNn?=
 =?utf-8?B?dEVFNGJnY0Y4N0dpN0RJZ3J3c0NOQ3FXdml6VGxKcEJmU2tiZzBQbitYYjM1?=
 =?utf-8?B?UmJLOGlsRUVjTVRTT2tJS0RoM3Q2TUxOcHFLRzFtRm90U21odkM1LzFmUXhH?=
 =?utf-8?B?TURpR1FWR1FaY2J1M1M3cjNPeU1Rd0c5bEExOWxLbk9VSVpzL0FoSWRDWmN4?=
 =?utf-8?B?dFJxcjNyN21lTFRTS2wwSUoyL0hFWGJqMzdyaFVkaDZSck0vVHYrakFpSXpL?=
 =?utf-8?B?OG5KcDdoVldKcUpUdzM5ek9kSDBsdlY1MVMrM0VNWGk3N1ZxWHJPblJHZnl0?=
 =?utf-8?B?ZjBqOWE0ZTFLa1docFVVT3JoMW84R1lDWFlTZGhNOHJ6azljMEphY3ZXdHRG?=
 =?utf-8?B?Y0s2SkFQYytkbUltSXpnb3h2ZzErZDlia0NubW9IVHlUZVZwUFpRS3hLb0J1?=
 =?utf-8?B?UVF2cCtESDlaWWpGSC9kTlpuQUd1UkQzdTJDTzVhQW1uTUt4a2Q5Y2JqU1dW?=
 =?utf-8?B?dnpoMjVjM3c5QTRzVjlzYUhadTBvNFEwVkdjbWFCQWVwRTd6TDh5c2x2Y0M3?=
 =?utf-8?B?RlBHNkhRelBrMHBVQ2xSTzdhT2dWaUgzQWluTlVKOE5tcXE2VU85cmFBYml3?=
 =?utf-8?B?cUJhaGVXdHZTZTlNT0NPbytJbFB6U2VycFpObjJDUEZYOXBrVUgyRXYwSjBX?=
 =?utf-8?B?MVU4ZStWM2FZYWZvWjdEb1RhMWdKSldXak5VL1doVTdaYXpPcDhrelByZC9t?=
 =?utf-8?B?M2REMGtpY2xlWG5vdnBvWEhuVkJMT1Y4dExFaGdyWE16M3FNZUYvWE1mcGZY?=
 =?utf-8?B?OHJxSTcwVjJ6bnJBMU5OMGhCTWI3U1NLSXNKNGNYSlZjMk53U29MUXlRNm1j?=
 =?utf-8?B?UVFBSW9OSlVzOVBEWGFvWFVlbkt6YmJyQUFvUHRkdUhIMEk1dlMvRzN6SmEy?=
 =?utf-8?B?dU1RUW5yVUttS01qTlYxTDgrVlNzcHJ1T2pwMUpZTGsrNHVPRTlFcGRUeUc4?=
 =?utf-8?B?aTJzSlJ5VDdZd1VsVGhJaUFwVzB4a1lhQys5U1dGZ2Z2YnQzSW02MHNPMjVz?=
 =?utf-8?Q?zVqUIQRHK0jun?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHMwQWtUQVJRUTAvZFdzQXRtb0xMdnVFR1E5Lyt1Y1pESGQyakhXTWdQYUp4?=
 =?utf-8?B?T0xQSkZ4dC9hak5QZzdQNjI2b1FKM1BtakRXKy9wUDA3MjdKYTh1QVVJTy8w?=
 =?utf-8?B?UUhOOWc5b1ZuVmUxM1o0cFZ3UDVFay9RblZ1MXhiLzRETXZGOEYxdDlSMjRK?=
 =?utf-8?B?NzZKMDJmdE1jbUJFZGJoYUEvN0dEQjlMVEhWbUNIdzdKNjNYcUswUUJQZUZS?=
 =?utf-8?B?NDRzMWpKdnRSSSt3Q1FRUWNKbzdaOUN0VUlhU1pUOVZIUGd5eTVmK3JiQzFp?=
 =?utf-8?B?OUJXQ3hVc2tOV1V2Vk1CTktyOE02eHhOMHBXalNRUmVtS0ZsNnJnNmRsZDdM?=
 =?utf-8?B?bDU3VlltY2Y4RWdodXlIcWR5WFd4S0lzdE84bnVLbFRUUkZlbWlZSGxnRGRQ?=
 =?utf-8?B?TVBnRjJSVmErOTNqQThwbUFVZXVRWUpRV1lVNlNVREx3Uk1MK2R4V3hlYjFB?=
 =?utf-8?B?STZjNmdkd3JhNDlxSGZyTWVPR084aW1vaHUvRGFVVjFZSzhXS2ZBMkhxcml4?=
 =?utf-8?B?dUcrVHlQUGY0T0lvV051d09aOE92aHRCK1lUcGlVaEFqRkRJM3JIdjlPQW5D?=
 =?utf-8?B?dzV6d2txSDFkMzhyazdnU2g0dHBwRml2UlJjZUM2aWdsblZDaUhlOEF6T1ZN?=
 =?utf-8?B?QzVJWkE5SHVrU0NYcUpFUFp3dnFDU2kxdUF3USsxMFQ2SldCUW0zMFJyQU9p?=
 =?utf-8?B?Qnhic1cyMzhsZ1pwNUdPQkI1VjJmMTBuamp0NVRsVlhpS1ZMbnJrUTJZaXRD?=
 =?utf-8?B?TUpLOHRCdG1mTkpHdmdJNC9ZUnZBVGRPTjRHMVgxL0JzSnE5YmR6VENvczBY?=
 =?utf-8?B?NGV2NHhydWVFWEFEbXd2VTlIMTVxbkZveE16a0kwcFE0MGg3NVRCNzFYeDlX?=
 =?utf-8?B?QmdDb2tqa0hYdU1qbS9SM0JjR0p1QnhkN0FXMmhkWWllTUdPMTE0RXg3NThO?=
 =?utf-8?B?bnZTMkNNVjJBNEZPOHYvUTI2eXlMVXByMVFIZXFsV1lZczJoQzYyV29RMFUx?=
 =?utf-8?B?ZDErcmVCL211enZkSXdDMXFHNG9kRm4vSE9IQzNmRS9QQStERlZJR0FyeGho?=
 =?utf-8?B?RGVtcFQ1OFcwbTgyNWM1bE5HV1h5bE1HRmx1MUtsT1ZJRkpSYTRWZE84YlIv?=
 =?utf-8?B?V2gvMUxMbzErSGRFMTdMK2t3bVU1S0xyZVNVWE1IWTgvZWl6SldnNVVNem5G?=
 =?utf-8?B?RG9vL0hlbEdBVUtvdFNjTGsyVFZ5NExkaXg3cEVUVHYrSVBLb2JkUDZsLzhC?=
 =?utf-8?B?MHF0RzB3cDBRQ0VDTWF4MmtZZWZ2VDVEMTc5dXEwL2VPaWV3QXM3Q3lsT1I4?=
 =?utf-8?B?d0FGb2dSM0YrajhqSEUxRGNQZlVSTEx2bzFvVGthY1F0alNPQURwNk9WTjlx?=
 =?utf-8?B?Mm5MT0Z6ZmNyRk9xMnpORWVLd0tSK3RjeU15ajA4dGxDREY2SGM1UzNZSmhi?=
 =?utf-8?B?T3dMcy81VE9rV0hXOEdZU3RjbVVCUm1kcEx2MzNGVmJhYXNPcFVOSytZaWxW?=
 =?utf-8?B?eE9NZzh0SjliZmtVVzF2eEJCZlFERkE3RUtqR3FTUXllSS9FbmNMVlRvMUlU?=
 =?utf-8?B?NS9nNS82ZnlkbDhaSXdoaGF2WDR5SFZTY05UR3dFLy92Y1IvSHhyRWVlbGZm?=
 =?utf-8?B?UTY1U0p0dHg0QU1TT2oxYkhNVHpmTzV2QVNQdFI5OFdaZU5kZ0QyUXhlTU13?=
 =?utf-8?B?SGYxL1RleG4vRFlpNVllRDUxdzJreUJuUEpObWd0RmN1M3F2ODdIdTBMMHp2?=
 =?utf-8?B?QlhvM015bFRnUjl6eHpKTkpubGY1VUltNW5wNVJPTWhOM1I4RnhVZ2NTNEhI?=
 =?utf-8?B?alJqUkJZblE1ZFd0clhGdzhNc3RrT3p3M1EzdGl0RFJraUxHVCtPOGl2NTZR?=
 =?utf-8?B?ZHZBZTRyc0I2UFd6OE81QlZKMDhNMXRycmxORC9md2dKZ0RIcW0rQVc0V3pL?=
 =?utf-8?B?SFBPOTNUdVFodkdLREJWU0R5b0dPZTUvZ0JpNFpDcjJsRFpxaklIcHBPY29p?=
 =?utf-8?B?cndKc2dXOUQvMElDWTZ0amdLNW83WDNsYVl4N2JpMXJHbllHQVJuQVdNRnJC?=
 =?utf-8?B?Tm5yNGE1dHUyZDJONGNBc0pKbUpMYjg0MXQ1V2pHNUZRMDdSbmRuaEZzYU05?=
 =?utf-8?B?VkpMSTE2S25ZNHd6bTV3c24rU3NHZGhSb1dRUyttT0RWWklPeDNNRDRnQzdH?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 75uFNHagdzVIP6ZzdEl3qNoG2Y0A752+EdYCQakb1d4FwWVyDvC5hvYMe0kGT0vzMy1YkRHDCsFjEFxdwI+QSAXBMHEipy1+lsXp2RL5oFtlzn+INE3j5vpVjfQZDvIbicpSjUtIjYIgmCRgd33h1Tb8O4PSzZmxSjPqJhrDJFnbDGWQSkkvJtZw/94lrZ7yW2+PXxy16ur7aq9cSelNvwhAtvkQ202sISOhzz4VWXalYxAZjz7JxIoj+g88vcVLXXdY0fdq8mYVQPlHJez3Cx8bjpp3hdqPKgrUlndeEiMPpwoAISlrA7A1R5ODN88URCPUHEs7YW+LZzUZyc26acRvJ4sGyGAevmeNbMYnxPHQPHZlXjjfdsJPtibIuDU6E3aSNyCPsmnKtwU64PYsiOrjiqdjaN9PN/2kncfeE0GeCKpCpwfA/uRNDzMy5yHEKmpLYD7l5YFcuylc0iSKQjQvbEub6V3NyQLULx0wyShPTmW5A7dI1sfClri34sjbpSImfNQvRbw5R1Djvdt88c5Zk1cLsfFg0+9SDS+ur4gtDImHevW7vVLybYKIKmYRZZa86BA2PNMb8cBVP9lAYYyUuSDu1aIr+z2tenyQyi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5ad2b8-9ee9-4fc2-d03d-08dd776fab45
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 14:06:05.7726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IqKDpcHjpk0Z5OgDuuRi5FkQwJaqaRy3AFAhoe9JKcsOy5NVrQqVUv1JlvkRFpZxob09LXoRkQtQelOL/T6N9Gc/CCo8zigAcVvXeoJ49mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8273
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504090087
X-Proofpoint-GUID: B8BWdKvizF9ON4-dkwM021d8ayPUa3at
X-Proofpoint-ORIG-GUID: B8BWdKvizF9ON4-dkwM021d8ayPUa3at
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 4/9/2025 9:34 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
>> On 4/9/2025 3:39 AM, Markus Armbruster wrote:
>>> Hi Steve, I apologize for the slow response.
>>>
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Using qom-list and qom-get to get all the nodes and property values in a
>>>> QOM tree can take multiple seconds because it requires 1000's of individual
>>>> QOM requests.  Some managers fetch the entire tree or a large subset
>>>> of it when starting a new VM, and this cost is a substantial fraction of
>>>> start up time.
>>>
>>> "Some managers"... could you name one?
>>
>> My personal experience is with Oracle's OCI, but likely others could benefit.
> 
> Peter Krempa tells us libvirt would benefit.
> 
>>>> To reduce this cost, consider QAPI calls that fetch more information in
>>>> each call:
>>>>     * qom-list-get: given a path, return a list of properties and values.
>>>>     * qom-list-getv: given a list of paths, return a list of properties and
>>>>       values for each path.
>>>>     * qom-tree-get: given a path, return all descendant nodes rooted at that
>>>>       path, with properties and values for each.
>>>
>>> Libvirt developers, would you be interested in any of these?
>>>
>>>> In all cases, a returned property is represented by ObjectPropertyValue,
>>>> with fields name, type, value, and error.  If an error occurs when reading
>>>> a value, the value field is omitted, and the error message is returned in the
>>>> the error field.  Thus an error for one property will not cause a bulk fetch
>>>> operation to fail.
>>>
>>> Returning errors this way is highly unusual.  Observation; I'm not
>>> rejecting this out of hand.  Can you elaborate a bit on why it's useful?
>>
>> It is considered an error to read some properties if they are not valid for
>> the configuration.  And some properties are write-only and return an error
>> if they are read.  Examples:
>>
>>     legacy-i8042: <EXCEPTION: Property 'vmmouse.legacy-i8042' is not readable> (str)
>>     legacy-memory: <EXCEPTION: Property 'qemu64-x86_64-cpu.legacy-memory' is not readable> (str)
>>     crash-information: <EXCEPTION: No crash occurred> (GuestPanicInformation)
>>
>> With conventional error handling, if any of these poison pills falls in the
>> scope of a bulk get operation, the entire operation fails.
> 
> I suspect many of these poison pills are design mistakes.
> 
> If a property is not valid for the configuration, why does it exist?
> QOM is by design dynamic.  I wish it wasn't, but as long as it is
> dynamic, I can't see why we should create properties we know to be
> unusable.
> 
> Why is reading crash-information an error when no crash occured?  This
> is the *normal* case.  Errors are for the abnormal.
> 
> Anyway, asking you to fix design mistakes all over the place wouldn't be
> fair.  So I'm asking you something else instead: do you actually need
> the error information?

I don't need the specific error message.

I could return a boolean meaning "property not available" instead of returning
the exact error message, as long as folks are OK with the output of the qom-tree
script changing for these properties.

- Steve

