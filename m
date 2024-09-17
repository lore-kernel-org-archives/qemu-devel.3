Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48448CAC58D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 16:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqayO-0000Jk-Nv; Tue, 17 Sep 2024 12:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1sqayM-0000IP-Oz; Tue, 17 Sep 2024 12:22:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1sqayJ-0006ku-NA; Tue, 17 Sep 2024 12:22:38 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48HEMiWT004647;
 Tue, 17 Sep 2024 16:22:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=ozMctm4vRN6mQYOhM32Ttdawr86Gk3t7T4jZlrXcIv8=; b=
 d8oBDjsCSUz8aIdSZ5lqeCpmq09+J5/2GdXYzkP2kgeOdbIQtuZKWNfAiSB/IUoy
 qxH6CWtZB4moAsZf/7IoYg5kkoa03YnxAgXs36V67GXlr9mlxH07F/5u7efrfBhM
 KyyPMLDjpRc6VjMfOXMbUS/Vj1jGmK6ijSZGZZqcS53N8tL8gtpXqHqusZpDJKK3
 Cs+5Y9Ard5NObFwspi6DWSxXWSqUfTg9eNU+ROYj/ky9P1H1L7WaNeGoDeIi83DF
 oEkALPhv1eFu33N/7UbhZKQmtVuddubxcBnUJ+tig9y7muO7u3i51cr1MBdU9yIk
 JDjl6xQ5XDSHN5NHzLE9Yg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sfpnpw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 16:22:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 48HFeowq014935; Tue, 17 Sep 2024 16:22:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 41nyg3cpsw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Sep 2024 16:22:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b6QZLC/3Ymx26BNX98w147LTy3s5+8rxWRXXvRqUvfMOrfN/guCkMFWuztTIFvO69UHi/NrUpNDEZlEAoDBApsSgH9q0WKD/iWlxQSPil1i91rlSH2tFOQ5uBRqncuGOrfftjr0sH1hsEMJd7xWTYmJaNL4Ye1pgb0ebrdogeh7U3kIky++Y5pU49RwHjLNz4ZelncWmwUonIUf0eufyKbxjsYmiwW2EjUsJqtp8Oz9lwBYHLJpxpkh594KIUacMiqo3t3VzwA2TJ8777Y79KaPULRiAkiQYSngVR3jgQa3ABojGAeJhkrlzn0MMSVVX/uRGEyHRHZB4eV40PSUKhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ozMctm4vRN6mQYOhM32Ttdawr86Gk3t7T4jZlrXcIv8=;
 b=uCRpI8LQx1UfmC/0tkMkXpg0aABMnRljE5KxSGEWT6IRkK0+/n+dZZz3IZKZ3hOwWkuyjxi8Aew/9vi6gu6bOdDsg2KeHU+XioVI6HjZnINhqG9TS/KJc/7dlLyG0myWuwjhtpO0ruAg4BtZZlgGR0UezkCwHlF19Y8flpbw9qoDGVWwZXvXuHunvK8PcQgkKjEShGQzw6ph79Gm530ROXawtLNBX6gdAGQzu20ZeOvqY5pSS1kAghJxm6goaALZgKUcizrKcCF/Awo9dtuLZmc9Q4x8DjWR0oqRnuyjLhsrHh7aS7pKEWDWFUdWsnER5kMi2aThnKmR7+VFGta+7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ozMctm4vRN6mQYOhM32Ttdawr86Gk3t7T4jZlrXcIv8=;
 b=0EVTE83DGoMWdSGS0ewhGhcsVybdtX4RxxRallK1gMJnrdCAjOB98SEhCq+f7J30eaQPhQy5Q3vdWKqwKOb+7JGJbV4JQpHrNZKnpIIhgu7PcZK+oPPGwjHwsW5bEnCRtryqQb6U3zIBncVkkF+YQN/EvK35D4Wf0bYuRq5NoMA=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM4PR10MB6695.namprd10.prod.outlook.com (2603:10b6:8:111::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.15; Tue, 17 Sep
 2024 16:21:50 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%7]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 16:21:49 +0000
Message-ID: <53d53e7b-247d-4546-8425-8bfa8561f907@oracle.com>
Date: Tue, 17 Sep 2024 09:21:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] hw/nvme: add atomic write support
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, kbusch@kernel.org, qemu-block@nongnu.org
References: <20240820161123.316887-1-alan.adamson@oracle.com>
 <Zuk24CCgPIZgmN1e@AALNPWKJENSEN.aal.scsc.local>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <Zuk24CCgPIZgmN1e@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::15) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DM4PR10MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: 83afea54-390a-4fa9-c175-08dcd734d50e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3BIYnZZay9IU3BVYnBka1gzRU9NNW0xeUhrTnBDV1djZGhrcERvZTdKV3dR?=
 =?utf-8?B?TG82cmMwaFV2eGRJbDUzNmkwWCttaVNEajhoYU5aR3FLSkdUd2R2aXViSW5x?=
 =?utf-8?B?TmF2VE9ya1VWcFV3K282c1NkVS93ZGJVNVNsU0VWS1NzRkFibTUrcEJnTXVo?=
 =?utf-8?B?QUNxMnhZeSt2aE1OQU5VWTRKcXJSRmFpYU91MXB2dFFpNER2MTFhWGxNcG55?=
 =?utf-8?B?amxiWXpFTTFYd3BqYWRTMG14SkJlcEo2aUFZOUdNMjU2Z2ExUGhidjh6UEJ2?=
 =?utf-8?B?ZDNqUVp5UnV2UXJMcUZEbnFoOFJsUjdsVlBCZTJqR2Uxb2x0RWxYN3N2c08v?=
 =?utf-8?B?aEFSdGZBWU1OYlFjaWtZakdKWVBzdGdXM1FmbHRiVDFrVjcxK1RJZ3BjOGRl?=
 =?utf-8?B?cmFIOU9GQnphcThtTzBQQk5iK3Vad3o3eTkvZnFJcjk2UVJJUEU5THlJQVZJ?=
 =?utf-8?B?VzRwdFF4N1R6ekRoOHI1WHhnTTl4UmExZ1l4NnlQQ2ZPWTVHN3FlWXYzVW9w?=
 =?utf-8?B?RkFid1NrdStNNldPOXQ0aEVJK1JESlllQldsWEptTi81dWg4R0NLUnVQYXNM?=
 =?utf-8?B?L1Q3ZUowUFhrcWlIRXV1K1NuY21vQmhkZzEralpRSFBQVkNDWXJPZnJ4clBy?=
 =?utf-8?B?UXlmMFNEYzRqVmw0bTlZTmhrUHduZnhQRkhkcUFXOWZaSWZhUzR3YTZJc051?=
 =?utf-8?B?Rlp0VWJsSHNlTXRCSE9NMXZJNzVNbWIrUlFGbkRYcmxMcGdNMEVrTm8yLzkx?=
 =?utf-8?B?MjhINUhPSzdRelJuZStHUWVNeWpsK2Y4YUZtWWpDaitpVk5zUW5SME9MMTVN?=
 =?utf-8?B?VDBzeXp5UktaVzNqR29UekYwTGtHQ3BTRzRjRFJiWis4aytmL0NaQzdUOTVV?=
 =?utf-8?B?dTlFVjlPdXRFVWp5UXlTUWNjS0thd3F3cUdlTUJzRkNlaWJXM0IwWVQxVEll?=
 =?utf-8?B?Z2FGUnZEMEJ1YjFRcTVKWWZqdTN2RDl4QXZtZFBJWS95Rm9DUnYrRjZDNHRo?=
 =?utf-8?B?UDd3UnloTHFKT2tCcnNOUkFCa0tyMFE5V3BNTU10eVJGdE9NRlluR3VYeWhI?=
 =?utf-8?B?N2xGc3dEQmVpeDJpbFk4MEtWQWFPcy9wbW9adDdGN3dMRU5EMll6RU9Vb0FV?=
 =?utf-8?B?TWRSQUtWZW02Sy92SFZMRG5DY2UzQTI2Q2pKZE9DcWZlcTJRbURjRERDSHBY?=
 =?utf-8?B?L21ZNzVGTzU4T0prVFl6WVY5OHRrME04bS9KWktHVGRnejRUTmtUQjE3T0Ev?=
 =?utf-8?B?RlZjWmZxUFJmMDJGQWpaKzRuanpPUENvaStwZkZDOEZnMDcvM3R0ODlZVTZL?=
 =?utf-8?B?R1pOWHl1S2xzWkhDamYzTCtWZFUwYzRmTE11NXFpdWluQ3QxV1JvNlBjV2Np?=
 =?utf-8?B?ODIxRjhOTjROUGdab3g3SXBuaDhkNGpoYTEzWUt6by83Vkg1cDljRkhjRmpa?=
 =?utf-8?B?QnFMNjltWGYvZGZtYVBJOGF5M21DU0xsek1zRVFoQWlJUVI0WW9lVmlvTWNZ?=
 =?utf-8?B?L0xwM0E3NWNOMjVSWk9uODJIbjFtelR3bERnUFFFeUtrV1RIODZTNjNwZUcr?=
 =?utf-8?B?VXFYb0FhUjR6ekJENDlHekhYcVpyU2l5MFJScHNMTmV5eFJkZkZLVEpjSzI4?=
 =?utf-8?B?Y0N2MCtqUCtQUWRaNURXMjYrWVpGR2JiRDlrVHFRUVIzVHNMSzNIcXRaMUtp?=
 =?utf-8?B?QStLclVlbFRVTDhDMkNZV1JGMG1ySm9YaytRaHREd3h3emJidm5VdmhSenVy?=
 =?utf-8?B?MGNPRGVqUC9PazVxU1FLTGhZQzlQSjV4SSt1enRqQms5QTE1Q2N2MzhpYlRZ?=
 =?utf-8?B?SUFydTA5d0xQV01LYlVtZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STltaHYyT2N4SVZuY3RORTFIdDE0NzZYN0szVzNTcVBnL2tCOUxDNTJ1c3Vi?=
 =?utf-8?B?a29kZHBGM0huKzlscng1dU92N1JIK21nUnpXWHVqNUlGMThvMkRHZks0NU14?=
 =?utf-8?B?SFpNUHNPVCs1bHlTSDBwd3FjU0ZDelIzcUR6elFxeDQ4QTg1NmhaMG9FQVRF?=
 =?utf-8?B?VUdvZ1BYYjIxQ1BsRHUyRlAvL3dIcWFIeUFUT3ZDelBEanNXRjRMQnBKR2g3?=
 =?utf-8?B?V2ptWVJxT0pnc2JETVFYdGRaclplTTdTUWN5dGQvT3BiNWlES1h0Mk9KQUFV?=
 =?utf-8?B?UmhMM3NLbk1ORk0rVWd1M0VVVnVkcTd3VkZtdmZqM29Ccy9Yb0lwaDRWeklv?=
 =?utf-8?B?L0FURWRyeEgxVDVwR1krU2RQdkJmM0szd3JrQXE0WjdIQm44RVUyR0wxWVFD?=
 =?utf-8?B?TFkwT2tzUzRURkxJWG1SNFU0b0kreGVZeWZRTEVycHBNTDNmbmpPdHJRNU8y?=
 =?utf-8?B?NTJUajFZcVpJdnpIcVhpTThNa0x6N1d0OTRFQXNHSEZBMGQ0K1l1VjZnR1pK?=
 =?utf-8?B?SHE2ekpUSEpYVTBiY2xqZTR6bGZ2Z3lIeW9CcVJIUEJVQXh0NTBLRWU0VTd4?=
 =?utf-8?B?QkNLakFkdERETDhVNGk2L3NSN3hHOE1RcmNEdXhqWEw1OXJzUU1QMU0wdnJw?=
 =?utf-8?B?aXh4NlJYb04xTXRvQ3d1cFRKM1JVeHZjR1pNMUFMaCtRSCsweUkyckRzdVN6?=
 =?utf-8?B?bTYxNld6US9FdFArTDBNNGZ2ODFlQkNYYkZxcnJCS01pdENHK2RGTnFhMTR2?=
 =?utf-8?B?Q3ZGNkZzalQyUVY5VndZQ2tQTmdpOHM0bEZ0VW1MNTAwbVZYa2g1NGZJMldC?=
 =?utf-8?B?N2FyWVpaVmZnTy9kY3FhbkloTDg4VU1yYkt4SndOcVlNVms3ODVLSzRkd0lL?=
 =?utf-8?B?YWdobi84aS8rYmNESFRwdkpGMjBxcnVUMVU4R1Z0WVBlb2pZcXJIRXlDbkp2?=
 =?utf-8?B?SjQveDBzbDZqd005RTVKN2tNYTdXSlpQRjNCRE1uK09DQzBJcDlNYnZCK3Ez?=
 =?utf-8?B?UjQxaHFvd2JqcjNZUFkwVTNmLzRKMUJhUTBPaEdpdFRjRzVrS0R4WnpGcGFy?=
 =?utf-8?B?RW5DcmlZVkQxTkl4dVV5YVlodU80WEdkaTJGbkgvcHBLMmtUVzg2SUR6enpw?=
 =?utf-8?B?NTZBL3JzdUdZSU1hKzIvOG9BKzZ3RzQ5VlQxRHVjMG1mTFNsZWp0bzN4MDV2?=
 =?utf-8?B?b1Fob0Q5QzVKN2JuVXB5N1F0VTloVTAvZE5UeWZOUmkwazN5OE5NTHZ5TmNT?=
 =?utf-8?B?dnk1K2VIK2gwKzZRbXZodjhIVnNVb050TGJESnh1YS9UdDJad3oyVDUzZ3RO?=
 =?utf-8?B?dW9yWERGTGsvNXhZUjFGNk9uOFZGQ3BNNUlHOW1UL0wvWk53SWNUMjhGYzhr?=
 =?utf-8?B?QlQ2K3pIR3AyZGxWTnQwaHJMbWt4d2M1NjJia1NaYkwxWjJzb0FYVUFaODRY?=
 =?utf-8?B?Mnl1Zll5cWI1T2lZZjhlbGh6ODVaY0RlU0VtRVZpdXpzdW5LcTY1d05mMVl3?=
 =?utf-8?B?cDQrZExsUXhaeGNMbWJJV1hsQVdiR2FvSXp0R2FQeGR6OSt6UkVYYVZwVEg2?=
 =?utf-8?B?ZXJ3RUtUS3NGSnp6M202Rnp6aUsvSEwyU0YxbnRGbzV4YmJqbllFbm84bzZE?=
 =?utf-8?B?TUIzSXl1UVFna1ZmQzgxdVBibUtQank3clAwZUVMdFJEcldwU096a2lFeW13?=
 =?utf-8?B?cFNTTk03a3Z0bUhtN0xIclhnYmhTSEJVZ1gzSlhnOS9teEpqN1VGcmhwU0xs?=
 =?utf-8?B?YUpycGxmTFJZMWJaNXoyRnZuNVh0WGd3L3VqUWhQU2o5QXIvOGhMMG9IVlhY?=
 =?utf-8?B?cERJSTFwT1dsWmg3MG5hZ2xHUUdkSFl5QjVZNENpSUovTDVwSVZKamRUU2Ez?=
 =?utf-8?B?QkhuTld1MXk5UFNNQTJJazdrVlV2VERPWCtqcjdicVhJTnkrZFp4MWpoMkRw?=
 =?utf-8?B?a211NjhsQ251SFNPbStzVG1rdmNmby9NRHk4TDg2d2c3TkxPM2FWd2NQUWZT?=
 =?utf-8?B?eUVZYzR3anBCUGcwUU1mdGFYZ3pRdmQxNFVaMUR4QUhFUElBa0dRS0UvTVhB?=
 =?utf-8?B?TGdSQ3I5M3hiN0dYTWFxeHVjU1JoRms5UUMxUVdETm9Gdnk4M0k1c3lER3dZ?=
 =?utf-8?Q?ZDbmElGJ4N72fPFBNHP/I10rv?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0IWdhLCtWe5yxiqh7U9ZXr6emJrZokf8dExFxQ8tEYHrkuHEZaSU9kBpu8mMuF2FoUvspQdZiXNhrdEmRzjbvsTRCCbSx0OUI2g+/mFIjZylKH8Ltj1fy9TyrjKnUUSzzCsPWRz2DDB4qakg4PGAb2OyhZMassGZUZsL8ecQxbIadqdbeSJ40oWWxs9gI5teNi1MB9bmi0brCuvCrG336Va0nT+eqXx9kHF7i45fkZxOKeC12OSsd1b2B6aPdee9kzrY2H67/krHJx4iWHpzfd+onHHtz259Aq+2eOHNdWJJ37cKr3EF4nGBD3FvOiw4Tk+IXexmrkgVRG+Qh41nGqPNqsX33H5WDFAaXqjoG+QO+0NfdR4sbumB47c8Y+YI3L43aDjNkd2BY4PcdzcnNQtpbCJDAgXVNVJ5DCzf9JyfRhpjYUKzz5q/mBsK8uWyaDv93R2Q8u+FTSHbz8MKWqGM572rCgvPpl/swT3TKrKBvxqylLsPpeC0rtr1gZt5ihivYtSwUMrYu/kB4Xlwb1q0QmkmmLJgUCyLq/u1RzhHqt4UgXmzRKScVhoGGbkWch3el5Vznaz1X08jJipBc12+lepvOQRDtYdskcs7OWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83afea54-390a-4fa9-c175-08dcd734d50e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 16:21:49.3567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0nSFObWT7rY/Nsb3lAXWuD1jQMWmchcuOlfAZOM6V67njZRncM1yQRXTeOj/qAAYWmh+bIqRowxbGW6pRlU5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6695
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-17_08,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409170118
X-Proofpoint-GUID: wyKshfzIZsQ-ClQt532fBLIg1EN4I0M8
X-Proofpoint-ORIG-GUID: wyKshfzIZsQ-ClQt532fBLIg1EN4I0M8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


On 9/17/24 12:59 AM, Klaus Jensen wrote:
> On Aug 20 09:11, Alan Adamson wrote:
>> Since there is work in the Linux NVMe Driver community to add Atomic Write
>> support, it would be desirable to be able to test it with qemu nvme emulation.
>>   
>> This patch will focus on supporting NVMe controller atomic write parameters (AWUN and
>> AWUPF) but can be extended to support Namespace parameters (NAWUN and NAWUPF)
>> and Boundaries (NABSN, NABO, and NABSPF).
>>   
>   
> Hi Alan,
>
> I am trying to test this with John's atomic-writes-v6.10-v9 linux
> branch, but that does not seem to work for me.
>
> Do I need anything else?

Hi Klaus,

What  are you trying to test?

You can see if it is being setup properly with:

[root@localhost ~]# nvme id-ctrl /dev/nvme0 | grep awupf
awupf     : 31
[root@localhost ~]#  nvme id-ctrl /dev/nvme0 | grep awun
awun      : 63
[root@localhost ~]#

With or without John's atomic support, for this case, 32k writes will be 
atomic while 64k writes will not be. This can be validated with fio 
since corruption is observed when using 64k writes.

Alan





