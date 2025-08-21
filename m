Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11FACA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 16:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up8JW-00068W-TP; Thu, 21 Aug 2025 12:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1up8JU-000684-Jh
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:38:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1up8JR-00053w-CJ
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:38:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LG17f1013855;
 Thu, 21 Aug 2025 16:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=KShwAPZtt9ziVF3sYhd7utPpIDUTFSt9rVEuBC/TmtI=; b=
 AXTo9Z5rJVJwf55NaMJE0G4jAgHqbFkyLz4LxKAyt2VJd9SfqtrnfmowbcHVntn+
 KuZLtDZUXxTQOu0BRN8io5MCwNtF6JRVbM3L3gZ1ndqVbaxDroS01O+ac8jtpmBQ
 0b/fYhukQxqlVvWTSEDQqT95DgVH0RbsmNW3r4E3EDTWpUaiXwxGjIOKiYQ1oaK6
 wfKM8WCmnNsKMmjTEI30y8+jxOGZwDYUOyu3A2oHkPNCBLYBKMvPiL5HSCkCxHmk
 61WrUrjtCQblds2pQ6Uj8J0NDgeGs68NHhXVHpW+jIgzkzD7f0cb2LrEXbcSkWyJ
 D37uT2U5UVyDhr8hOjEoSA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0w2by7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 16:38:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57LFAgqS020714; Thu, 21 Aug 2025 16:38:46 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48nj6g9pph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Aug 2025 16:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcaOZOhyIRTPjNiwMAM2Ft139krqTOjFgsuFRXDqKoW5+k8OOXq1UvTqPEM1Bece3VM97VFFWtY0rQRGPGFR4Qori7pyYThLFsduRWzVvvKQhJyaozfQocfABSHeSwP1lR8LDZqGNC1Cm7600G97jmMM/VDp1Hq3mcJV6Tb6eVKBuUb5hmnKe51/TTbdeuiEv61UBqSzDIR+3ESXMf46O9uTsKpBrUMTVgQrFx6XNlYJQV2fD8bRZGESiKOGpmc/IXXXX2G4dP6vchjzYCElZI6mq9vpzGnqO1kBtmUVm59NqRW+A8jr7uUqIph+D2GZ/elVRc/FAfGp5+JlIO4hkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KShwAPZtt9ziVF3sYhd7utPpIDUTFSt9rVEuBC/TmtI=;
 b=GnYxa6YtVw6bpzAjK4C9wvJ00n3zxIRAT0LcGGFSU2IZaOJ7feFotN1ZfD/m4/v8TlXWpTKtaye392VZ1CPFDunERnhF6zVf23C2/ioRhdBYjBLwub0G7LiLiFPr812U8stHa6OOZIOwiYX3iqmGZFbDm6M2Iddb7rnd1JBrE3LBpQOcXeTbE3TlGlzJnVBltZzHLXHaG2HFXwkHZDzUThJb3gNTXZ4qPs9HKbSlJ/la3POPB906krSuzPtUKzGNZB0rCoafotP1lnK6CWHUMC9otFYKf8V/GfnnhbG9DbGLe4daNhJbwNfgpXPjcYp4G/aV5mqD1a8bG17x9WOjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KShwAPZtt9ziVF3sYhd7utPpIDUTFSt9rVEuBC/TmtI=;
 b=wiR9FHP7YlTFW0CGtebZjMLcXrjCELbHlLjb3pddtwk+DfjkWCbWJvB1Ezgv1EIe7yf+GQDWfLW7BJf1JcFmVBZF58IZJhQElEDwCJw8ZxOmyBD9RRmgrG1qzdHppaKARJXvr+Kfh31VbLN4vuGJJwxU5VyaLdLRzz/brFEmI/8=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by SA2PR10MB4553.namprd10.prod.outlook.com (2603:10b6:806:11a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 16:38:43 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 16:38:42 +0000
Message-ID: <e9623342-e6f3-4b7f-b51c-4b2c1ccc6157@oracle.com>
Date: Thu, 21 Aug 2025 12:38:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/hub: make net_hub_port_cleanup idempotent
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, eperezma@redhat.com, leiyang@redhat.com
References: <20250821142641.359132-1-jonah.palmer@oracle.com>
 <96b2392ae6f091a0d49a74c73122889c78d80dfa.camel@infradead.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <96b2392ae6f091a0d49a74c73122889c78d80dfa.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF00013313.namprd07.prod.outlook.com
 (2603:10b6:518:1::4) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|SA2PR10MB4553:EE_
X-MS-Office365-Filtering-Correlation-Id: a8d6be9a-9b0f-408c-d564-08dde0d130b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LytnLzk4TU52MVZqNmZoR0U0MEJvakpiRE5yeVUzN084ZXNoZVNTUUUweCtx?=
 =?utf-8?B?TS92R3RRQlJLSDdOT2NvSWszWWlnN2VTUGp3T2o0TEJ5ZDNjdEZIOWYwa3Jh?=
 =?utf-8?B?cEU1QWpxM0J4N3Njb0Q4bW5uaHJ2aW1QM1RjVUdLQnAzeTRrMFZ4UEFFY0RB?=
 =?utf-8?B?cFRvZGZnV0tTODV3bmdjbFYwVUVZYit3dFAxVnlOYmYrLzFzTmJ2Y2xWeFda?=
 =?utf-8?B?VEFib0VSV0FvQXhiNG02eFFFeGREbVBiQVNRekYvRnZEeGhUNVNmZmhBU0tX?=
 =?utf-8?B?ZWFNdWVsajd4L3NnUW5SR1dSOHo5RHByMXRhbndJSjBoVllyY1AvV2NjMU5u?=
 =?utf-8?B?ZG9uR05JMk5qUlB3aDhpbG4yalRrakZFRkVpaE1vZFhXMFI3Z0tmY1B5a3hY?=
 =?utf-8?B?Vm5maEpTODhQNDUzMzdTZnJVdTluY0lDbitvL3Y0OTkyNytrU08xZDFVWTFK?=
 =?utf-8?B?UHkyRE5iZHhqSXJUSEFaZEFyZnFESHhSMXo2RVBFdHBWZjV0bnlSQWxxRUha?=
 =?utf-8?B?NzVlblJXM29pb3d0OGtjNnFBZFVjQi8wT0VlUGo3ditqYms2TGhzcmdkL1BZ?=
 =?utf-8?B?dnRJWkVBVVUxTXRHVlhNeTdJSC94cnA1R3FpdXNod1o3MTV2Z1JFT1RheGxx?=
 =?utf-8?B?NVVRbEpUd0o0Z2wwM0svUHpDOUErVzYwZUhVdGpEaDNEWXRzNnFmR0wwMHcw?=
 =?utf-8?B?dkJjN2Zjdkx5YU1GUVVLZUJWNG5rSlFrU2NPSXliZXY3Y3JYblRGTEk2NlAr?=
 =?utf-8?B?Nm85eXNvRkc2dWw2ejFUekdLaytiSjhEOVFYVjZybkxFQWxvNGhkM3kydW5F?=
 =?utf-8?B?dEVnb05wb042ZXlVWDRxWWFSeEU5aDJLRmZJSlB6REZCTitDSkYxd2tGc1dv?=
 =?utf-8?B?YmVmUnROWkcxdE1TdlNZSTZpZG9HdEcvSmk1WGxEN0YvTHlORXVFMjgwc2ty?=
 =?utf-8?B?ajZBYTkxRWlkZFA1OEw4NlE0WTgrQlVsbUxWVjRuTU9kem9VTzFHa1JUSmV0?=
 =?utf-8?B?SnFpZ1Z2VkY2SjQveG50aFdSb1RPTHZ4S0xUdEtldDBFdkk4YjdDdTRuV0Nx?=
 =?utf-8?B?TFB0T2ZqUGZaUWhPR2lVRHgyajcxRTd1Z1E4S0lKcE40LzMxMjB2UmkvZDFW?=
 =?utf-8?B?WUltaU42QTFYaWQyMXY5WkNOZFJmSzEwTzY0UWROYXVRSTB0VEpvMGhYUEc1?=
 =?utf-8?B?M2JoU3Z5eG1GZzREVzE4ZGJ3OWVCTVlZUGdwc2ZOVVhBQU9ZZmZpSzJFZXNR?=
 =?utf-8?B?UTJOUUQ3cHBuS3gzTC8zcHlUVmZwK0ovZGVtdzFFbFpsZDJIQ3pQOFdxOXVn?=
 =?utf-8?B?ZkVyV3dQb1UzNDlGa0swUW9VZnFrY3c5b2VoZERXekk5TkUrcGx6OE1LcFF1?=
 =?utf-8?B?eVVKNzdFby9LTlRSNnp6VjN2aHlOLzlyWDlsVWYzV2JCVmFka1NjMXFVN2hw?=
 =?utf-8?B?cU9aZjZ0djQwUHZwMHFDaWtFSWllQjFUZlhON2pkQ2Rrd2FFTnBnbnNpZGF4?=
 =?utf-8?B?OXQ2a0pta1Y1MERRVFNyQ1NzN3JNSTN6bTZSNmN5a3UweEVTUll1bHJDaThj?=
 =?utf-8?B?b0NibmpKdFI4VWxZTGNzaXlZaTFJaHp5cHYxM3dwY3hHUlhpbGNYaGtadEM4?=
 =?utf-8?B?TW0vY1JZK21GT3cxa21jdERzNE1wSTNFUHJaaXlWcGU1SlNaVThDYW9Ba2Zk?=
 =?utf-8?B?MTBkZStCT1FBUTlJUFIvSUdXUDVnVGhzY3l5ODdYcDgwVDh0VFlZWmk1UEZo?=
 =?utf-8?B?SVpBRmRsQWx5TFJPK25EcFYzRFNORnhSMlh6WlUvVk5LOXhFVWtJSlB5Q3pL?=
 =?utf-8?B?S1orRG1IM1A4L25RUmJwaDRWSTdUOE5iclFTU3I2TEZMdStwNHo4LzkzWDhi?=
 =?utf-8?B?dUhjL0tmdExVN1dWRkV2cEVBbmI0ZmhMUmVJNG16VkhQWUdqbzBCRzljcVdF?=
 =?utf-8?Q?ZtvXxlFec6c=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXVpZjM4a3NzcFNDc0ZwOFN4Y0xyOWg2YjhZMFNkY0hwNHdxd3JCTUlabDZq?=
 =?utf-8?B?MG03WEVEQlJ2R2MxeUJqRUhwYlFDUGtwbjEySkNhYW1KbkQ0KzgrVjNGVUwv?=
 =?utf-8?B?TUR6aWl1QzJZNmdyU2RnN0tXOUt5TDRjK2liYWFUQXB6bWtmcXFDbmlyZURH?=
 =?utf-8?B?OEk5TFN0Y2V1NzgyakVsQ2JDMnU1NzRnZU1xWU1DTGlLaGcvY252MmhWcnR6?=
 =?utf-8?B?MzJhQW5FMzJsbXA2ZHhRNkMya2FsNEZ6QUdPNFJYL25MOHZGWnhaUDJWRm55?=
 =?utf-8?B?N2xaVGUxY3Q4aHduMStYUHk5a093QlJvZXl1MjFQQTJ4eDcxTHNub1ZCZ2Ro?=
 =?utf-8?B?N3RXSkdWWEhEN0ZsT1Exa0M5dHk1a0xYaTd1R0d1MVEraHVUR0l5TXhFcHEz?=
 =?utf-8?B?dFJVREc5QUhvdmdpM2c1N3pMZmJ3ZCt2VGJBRU16RkNxOGdJRTJhWHBWQlp0?=
 =?utf-8?B?TmdLSUJrNnlYbnowUUZpTXJad1FMMlYxNHpHWnQxVmV3VlBadUJweWVhdldi?=
 =?utf-8?B?MG9lcXlKNVM5SVlrTENVSTd0OGowc0F2cFBxTXlVWmJhcXFUR3p5bnliRDc3?=
 =?utf-8?B?L0djS2pzQ1U5SllzNWgrazJzVTd6ejVMYngxa0pSMWszUkhicWZVV3BNdFBQ?=
 =?utf-8?B?NTdzcFRUNHdHOEJQNW1VRHloV3dtTDhCempHbVVpRjZxMzMyZmVycTQ0YWtr?=
 =?utf-8?B?VVhveGE3VmZuajU0aEY0S3h3ZXRld21PNFVndGpqOWFWTzdnQm8vUEZnbUxB?=
 =?utf-8?B?U2JZT3hjUEMyUERhUFBZZFlvZHZ1WGU4cHpXTnFEOVM1ekRtVWxnNDNTUWx1?=
 =?utf-8?B?ZVV0clN4YlRFYys2Ykl1M3FOdHJiZVppTjFRSjFHVnpxYjJlWGYxN1o1bVBK?=
 =?utf-8?B?VDJUREVXUTBJdjNrdG1RSWk2Sm5MU0ZrallIV1hucEdnOFNGV0tndTVnRXZl?=
 =?utf-8?B?bFVzSVRYT1dpN3kzMkljVE55T3A0T2dpQm44ZG9PQTFEMFJLcU96RGtyckds?=
 =?utf-8?B?aTR6Y0FNV1k2QzBQMGZZdS9sN3NvZ1NJd2tLYjgrMnNXUmN2MUlYMFBZNTc5?=
 =?utf-8?B?b1ZmVkJmMUtiZlh4eXMzcXA4eC9zV3k2bGpUVzZaVG1IbDIyUCtTZ0lYMXRQ?=
 =?utf-8?B?MEZ0dGduQ3lZMGFmSmVDcVhxVjJWWTF4K1pwU3pra2lyUzBIYmg3RWkwUGw5?=
 =?utf-8?B?SlV2Ri83ZTFHWkpWN0UvWk5SVVNzWFRLYjlHdEplcWdWL1JyT0ZoUWVqMWcz?=
 =?utf-8?B?dTNaYlZUcmd5YlJhc0VSdEtlV0Y1K01scWo1WXB3S0Yya04xdjJwdWNXZXRT?=
 =?utf-8?B?WTNHZ0kvUTY0VW5SSXBJUlpRSTBUQlIvZTdPMmthbE01bURKVlFKMlhQV3ZM?=
 =?utf-8?B?N21SS056L3F3R3B3ODlZOW9FNElEeFVJQllyQ0t2OU8rcHlNTmFhbU1YQThr?=
 =?utf-8?B?a2FIZmx2ekUySlRFbXEweFN6NFZidTAvQkREOU9xWlFlR2VNV0x2djlTdmY4?=
 =?utf-8?B?S01nYTNDM05QNnYzcEE1eGZ0NFM3Vk9uc2d5eFNabFdjbGJrZ2J4OG1DbjVT?=
 =?utf-8?B?U1hxYXZyZ09scy9LeHRnVXVkQk9QU3kwdEh3OHlnZWlYYnFzamc1NFJUckhh?=
 =?utf-8?B?MlVlYjh2STduRnQ1N09KUzBLdDBYU3hLQTdtVWpKd3c0UFNrd21uMXNkUVpD?=
 =?utf-8?B?MjhRN0NFbmhWdEdITHQ3ZTE1dWIydVJaT3RrcTV0RDY5VE5wMHhDZ3RmZVN3?=
 =?utf-8?B?eXA3WDNSdGl1V1YwemR3dmhGRXY0RWRrREN6aXRRK3lhbnh4QjFFUXBIcWs5?=
 =?utf-8?B?ejgzU3hIN0xUU2VTQ2RWbXFtWlFraTJJOFA1WU0yZDYxUnBsbDBNenFsait0?=
 =?utf-8?B?YWZLQnZheTV4RDI0NVI0TFRmOGFaUnFBVE4zYk5DNHRMM0RGQVV0N3NwaTlx?=
 =?utf-8?B?cHk4akN3N0hmU2tTS1ZielM2UWJoUjlyRGN1SVl4cy9iZUY3RUdaTG9STGtX?=
 =?utf-8?B?NURINmErQkV3dExaNlA0OTFyajlUTnFTdExIZ0ZhMTE5cE1ubDF4S2NsSVdy?=
 =?utf-8?B?cEFYMUh6elBSM0gxTGtNQzdRRnJxR1g3MjJRdXFzd2c2QVQxVUQxTHB5aUVR?=
 =?utf-8?Q?Avp7FSCmc0AqyRIgyXiWs9/tu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TlD9AWmyuU+1nj3WvcNMdURJ62momdZgoorM3DBgJekxS8PLBYomCdIVHQiv8P+X4ANNezurAGjXoIJhXrhamBfGiQ/EaGo0Tf5r39a/i2W3WHW/6TRGsWgjlBoG5bCjsxgBsjc5xtexY3Kntn5xmt/f+m0Wkrf0t029awTpezalHPBX7fdCrFO9uXC/O1QR77uV2xJApjCyz2v4jNEsnAdV4PsqxG3PYlbTuyMxvT2EIPKSa13ETxDLt9vpb27CJfJp5qyKh9YJlWKwRyXBFtG/fi3XNfCPcDV+dnHlqULX4isl0SeX/M9loUdu/c+hlxydOa/Nisg5xAa+2HBUJ1yirchFMMsU50uUylJ6PjLzhPKLj+mwOXnMz5BtU9z5mtG6UxlMyTBUwulYL8Y81KgdS47QsvwRzh5tq8D2SkYHER6yw9bhWVlBDmDWy/tx4V8B3ij9m48tReVpMxHhCOiabX2QIEUN1cCUHtEFTSpDMx7M/ee2Z+wq4uSGtOG1vSY3HIbcfwZlqQGh8xM5cXzg6ppqSZfnS5XSll1fY4ntpdQx1SUFgub0w6n/LbAgpZ08ANLK4IK8cGEf30G8+iTCanzJmGaNlj8qGe2r/pI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d6be9a-9b0f-408c-d564-08dde0d130b9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 16:38:42.9036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MLaFdqbulMLMEAPDBOrXOBm0vcxxgqofrf5WR1hxw9bNm5tWDj8wX8tpsMEYGjf1+pNRXsk6sdnT2y2h+DgKLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX9isoTsiujcAq
 Sh0802CfbZ2N7z7QJy371Nv7h7SmjlFSk9OTU0YAUzpriqFDsP+4qPcmSzJWJr5RpXyrTGgwCzI
 KZNTMKOecACbk1mcm5N1EEVUQyf49NdbxAtUCFrxHyiYoxzFZwryXb00QYbKbvJpIF07987ypRf
 PgP0dLRJwr6m6MYdsDEGYdWl6Ea7ou1aGtpxe6eqHLYaHbTk3nr/Z6Ad2VWz1yzOq6xp80PEA4f
 WGeEted9bDpngYkGrlO2knZhlvusV+nUQ5ZQDwv0QhbZtc8SKaCPpDF71roD9XnIihA5Lzcroow
 FkCuYkkhmcAjInBRyzSL+vPsMvN3VQylsq2hP7AFDySVrCgKUGlrZ1D5x2iaYzLX+XpxUSM+sIE
 r5y2cok5BzNM0Y2khHetwl8ZOHd1JvB0iZVkiHvyvaQQ5hY7pAY=
X-Proofpoint-ORIG-GUID: jQGmjbQa2pytQMUC5t9UYcmt-C9pC9Bi
X-Proofpoint-GUID: jQGmjbQa2pytQMUC5t9UYcmt-C9pC9Bi
X-Authority-Analysis: v=2.4 cv=GoIbOk1C c=1 sm=1 tr=0 ts=68a74b96 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pBOR-ozoAAAA:8 a=V0PCGdmKbiXTkNsBQBkA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 8/21/25 11:13 AM, David Woodhouse wrote:
> On Thu, 2025-08-21 at 14:26 +0000, Jonah Palmer wrote:
>> Makes the net_hub_port_cleanup function idempotent to avoid double
>> removals by guarding its QLIST_REMOVE with a flag.
>>
>> When using a Xen networking device with hubport backends, e.g.:
>>
>> -accel kvm,xen-version=0x40011
>> -netdev hubport,...
>> -device xen-net-device,...
>>
>> the shutdown order starts with net_cleanup, which walks the list and
>> deletes netdevs (including hubports). Then Xen's xen_device_unrealize is
>> called, which eventually leads to a second net_hub_port_cleanup call,
>> resulting in a segfault.
>>
>> Fixes: e7891c57 ("net: move backend cleanup to NIC cleanup")
> 
> Tested-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> But I hate it.
> 
> The lifetime of these objects is confusing, and this patch doesn't make
> it nicer.
> 
> Why is it OK for the object to be taken off the list while it still
> exists and is findable by other pointers? What does it *mean* for it to
> be in that state? Doesn't it have a refcount? Can't it be unlisted
> *and* freed only when that refcount goes to zero?
> 
> 

I believe this "off-list but still exists" state is intentional and is 
the model for NIC peer backends. IIUC, it essentially means "detached 
from hub broadcast but owned by the NIC until device teardown".

The net core explicitly transfers ownership of a backend from the global 
list to the NIC without freeing it, so it can be torn down later by the 
device itself. See the comments in qemu_del_net_client and net_cleanup 
in net/net.c.

In other words, a backend can be removed from net_clients and still 
exist (owned by the NIC) until qemu_del_nic cleans it up and frees it. 
There's no refcount today and lifetime is manual.

The real bug here is that hubport's cleanup is not idempotent, not 
necessarily the ownership model itself.

I do agree though that the lifetime of these objects is confusing. And a 
refcount model would be theoretically cleaner, but current code 
explicitly relies on ownership transfer without refcounts.

---

Actually, now that I think about it, perhaps we don't need this extra 
'listed' state and instead can just check 'if (port->hub)' and set it to 
NULL after it's removed from the list.


