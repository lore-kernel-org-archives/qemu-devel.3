Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B5CCAC58F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:49:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux55k-00063L-QG; Fri, 12 Sep 2025 10:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux55g-00062j-IX
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:49:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ux55b-0007c3-LZ
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:49:31 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1twmM022576;
 Fri, 12 Sep 2025 14:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=FuaSXhUGX/CzWMaDGb9tl7iLGMyBHd5wgE0l1TDQDVk=; b=
 U0se9Xd8AUIFs2T9PdR1ZzTKpTNbfk9MN+yaFx77lZYcW9jw/1KPh179QNv2V9Dn
 y6mIzEgRbSdIQjCuy6kkiIsJhYT3RAeMvSa30FuFwzBdaNJbVryyMGiYVbCc4QCD
 Ed+hnLLhwA4JgaqT2/L1PSRi82B+8uGUBjDDxNhaz/yxIGoGv5SUuOrYMqwrE0zA
 ICgLIN6QKrtbeLN9xh9V6k27It1QFo/Kjknz447+PHoe1VpLWGD3uPhRb6aDw88P
 ki7eGyjB0eWHGlK7tHFQbg6hsMq29BtZg5TAsOUuFW8K8kSzSrzS13QzhoYxRLIf
 Zz2ZYfyenSwsXCIZweeqfQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pegckq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:49:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58CEZNGN012839; Fri, 12 Sep 2025 14:49:14 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 490bde5b3g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Sep 2025 14:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N01YwTF86GUP9zeTx4sE46udrMIyDQpAalaEhCmRfEcf3Ys5pWQdoA5sJTkBRKYDKxjHqfOz8I3rmfmQVbKnx4+eqPfrFBNmWFayc/PZCugz+akEffjXQHv2vPGVRcbM78FcOvkTEex/kInUr1fCjTxaH2ebmZAYoJow8kebJAn35QL6OL1XQteKrI/nwpEt6mKl6JjkgikUvbnmbwMHlq0fCt7bYufqA547kyOTclR460Dox4iZTE2HyMgp70h6cTTWmMtU6BTdNsCTBwXhfZiBboWmUKxr7HIb2VQWy5DiFWswzfn3Eyy9GgI58gEfIXva1TNMBgyIKt7WdO5qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuaSXhUGX/CzWMaDGb9tl7iLGMyBHd5wgE0l1TDQDVk=;
 b=tQbkTuTykusogt7kbstbzYentDU5+9lgqFnGoEhlzuk6NeBuSUvs01FM1LUStffRrbUg4NAVQlJei0i/DvW1nARB9yI/2xJJC4N15Gq9HXmsxk7wIh1KrCpbGudu1LJSVjoRrj2OpYBWqE63jtaiTgNhZf2MTcD/TkU+bQWubf1ScoxHPNnSAKxE7z8UDCNAumgeAJ73M5NHbFpYscU6HNVaPDBJ4IxwMK4ATgu113wfJA1DhXMnEYUiKJVZMKhhXO0OylmnKGYpI1K+1s/36TuHVK4cn0LEvYTarATxTJ5WScgb7cZBz2PCErYxTP3Nd96DW7vm+Z6L8+dVJbVaWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuaSXhUGX/CzWMaDGb9tl7iLGMyBHd5wgE0l1TDQDVk=;
 b=Cgp52v82NCfgQ7F5vsWBRRxSUvSOOSJdyiBGb+I6+YAjVOVeGzbCmYW+UTVetYj+HPuWbMxOQsiLzEX+dXhxdT3um3AZ0lv0jIaiefgHmt/xqA9N9trQ4rwTUpHUdUG/m3JDD+sclTHbJluyMiHgToRdbFN2yhfXjgzQon2VsM8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CH2PR10MB4263.namprd10.prod.outlook.com (2603:10b6:610:a6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Fri, 12 Sep
 2025 14:49:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 14:49:12 +0000
Message-ID: <97bc80f9-0d99-4d75-9f0d-d88c48c420a5@oracle.com>
Date: Fri, 12 Sep 2025 10:49:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 7/9] migration: cpr-exec mode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-8-git-send-email-steven.sistare@oracle.com>
 <87v7lpdo18.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87v7lpdo18.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0009.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CH2PR10MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: 81959613-f076-461b-83e6-08ddf20b8947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R1dmT3BEaHZHaHhtTEdOYmhGTHh4RC92N1lkNGNSd1lVdDB5cVQrOFJOUVFm?=
 =?utf-8?B?QmI2NjZDS1Q2WSs3cC82S3pkbmRwNTZleGZaV0dDNDNxWXlVTWhRVzE0enUr?=
 =?utf-8?B?ZDludEtJL3ZkVTFsYmhKWlVNM09jMXZSL1l5UFR2SXYvNVZHbzNiNEw1RGxG?=
 =?utf-8?B?aFJ2Yk5KRGV3TnF1T2dOd0FwWWpLMzhRN29zQ2FXZWZEaHZmOENrcXRYZzRk?=
 =?utf-8?B?RWJzRloxaXJ6MGtIWjRWT2YxQUpxbm9vV2FRMENIWHlNM0tReG96dVFFNlkx?=
 =?utf-8?B?RXJKT1o2d1ZkZXY3Tm9id0l0d09qdWRWU0NJcHprWmcvOE0yTURFTWlJbWhs?=
 =?utf-8?B?UWU2YXVtY3J1UmkxZE9qUU11TW1FbE1JTmVIajQxbFFnTmxTQnhmV2FoWXN3?=
 =?utf-8?B?aitIa2o5MWpyTHU0ZjJLSDNiVlk4OXNmRzlZVE80cC9YTnA0QWJEUU5SQXZD?=
 =?utf-8?B?WmFaVzMxM0xvbGR3NXFKMEJOUUZuTUJOKytoRVNsbVgxWTBaZGRFaHgvdWMw?=
 =?utf-8?B?YUN6M3dXKzhhdnFrVW54ZHFIaFJlVEN0Qkc5UElWTUs0TzRpWjZ0QldwUFIv?=
 =?utf-8?B?UUwzdUdqVXhXVlhWTmVKRUhzVHVBVHJJZFE5aXcxMjNtbCswU2s3bktCa1cw?=
 =?utf-8?B?Qm53dnJLM0V0U2U5eWxnQ3MxS2JQUkh6d1VHTXZGd25jZWozcSttT3ZNWFdY?=
 =?utf-8?B?Wmlheks0SkZYRFpmTnFEc1ZrdlFWVmhYaXVVSk1GTTZTbGlHdHNVZ3MxbTRJ?=
 =?utf-8?B?M1QvY3k1cXdNczVLUE9FSUFWVkhNR28zRlFqT243VFFQMVNhZlhLNVVmQzNX?=
 =?utf-8?B?YmNiazdER2VpUmlWTG9DNnByb2xwUGlOalQzYk1hRTNYZGcxb0ZZdCtvNysv?=
 =?utf-8?B?cDlENWk0VGlWdjNlcGFWMnduZzdYckRlakRDK3ZITllOckdldUZFR25EM1c2?=
 =?utf-8?B?dXBoaVRnWHhLNllsRGxINmU4SmZ3UDVsMUt1WlFsTWNaSFR0VU1ESkgwaHhE?=
 =?utf-8?B?MXRNRFdpdXZkU0VyWm9pbWFkYTljTnlKMWM3YUY3cTBKb0tYakppOGY1Kzk1?=
 =?utf-8?B?Q0tkWEs3WnhWZFphYmNyd0R4cXdGaFFTSmhOeE9NbGhxS1JZQ1VxbGNhY0No?=
 =?utf-8?B?S3pYR2FHL0QrQ1hvZ2dRby9ORVhtQ21HUUdjNGo5Qm1pZ3NjZkVZbEFrc3ph?=
 =?utf-8?B?WWJRV1MzYVBPeHZyd1NVYmR6ZlZtWXZSSFhScUJ5N0JTTlJvbHBjc0NGekxi?=
 =?utf-8?B?YThCY0dWOVNrWGJiVVlEVXBYdFVPT0FLOG5iTzlOZVRhcFVFOENGVGdqYTF3?=
 =?utf-8?B?N285UCtwWW1MbndWRWJPWHI1UnRhVHArd2NqZEVrdVBiUGJiS0p1MUd2aXhq?=
 =?utf-8?B?NHFscmhCQzI1RG03V2NJRnBPR2JYbnlBWTRneTFSazlmY0pXUGsvNGY4eG5Y?=
 =?utf-8?B?MXFqc0xYYUY1T0RnZUZUTjhIMGkxa0lVaTFLTzFyYkpFb2JxdnBaM01OZEdz?=
 =?utf-8?B?TkZsYWtIMDMxNjNpczZmd25YN3NZQnUrWmh1T2YwcVhZUWxheDFQejNyTHdt?=
 =?utf-8?B?ZGRJWWZZWUdPM3paY0ZLcXFrV1AwNlhoNUlOUDYyTkFnbzVKZXVqQVVUVDEy?=
 =?utf-8?B?QS9nVzhxVWxyeFJZMjBTS24xS2V0ems0cFhqSTAzZExqMGNIWmt4L0s0MEE1?=
 =?utf-8?B?NXNNYjArTittQ210b3FBNHlsNGZIbDR1M05TblJ1Z1d3R09Gd2lMV0QvcEw5?=
 =?utf-8?B?cnYzcmNKeE9WdTNVdmw4VWhqTFFLTmQwZzdPbk1BWDNjRDZnRDg0OGhWVjRQ?=
 =?utf-8?B?QVhkamNtQkNTS1lUcG15RE5VRTVDWmNKZGQwcXhFRktOdHNOSU5vVEpGYVJr?=
 =?utf-8?B?V3FlSU51dHlKb3RGd0JPL1RIS3gxOU41MTc2dnVUR1RKNi9FdGxEM3BuTU9F?=
 =?utf-8?Q?IyGKIFNzHZg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUZURzFWMTdFR3ZtWTUxSEZNYTJ4RGNHUHZQWUhDUVA2VUJMWlhUanV2VURw?=
 =?utf-8?B?Q2d3SWpwS1doWUV1dmw0dEdTQk5kVmRmZGZuRUpWbzFXb3FUR0ROdGxwc21u?=
 =?utf-8?B?Mk1KdGVhYU9XUE5zVjYzQURVaDF1OXR5T21jNFhrdFFUbmJxcVdOVVRKSlFD?=
 =?utf-8?B?QXpPS0ZpUmdwN0M3TjJLZHhtdEpJTVAyRXpiV1k3WTF3Y0dyb0ovdlIzOSt6?=
 =?utf-8?B?a3JsMm1UTzU2bDNNTStrMURZRGtWcE5Wa24zdnl4UUFqQUVqVzBRSFJmRmND?=
 =?utf-8?B?M21CQy83L01PV2p1RE9GYVppZ1BnZmxFQ2xDd0ZOUUowWHVTTjRhN0lRTW5m?=
 =?utf-8?B?Z1NzMHJSejJKMVNsMzdGSzdwNCtLV0NCQkxjNEF4N0E1VDF5STJ0RVVKcUhz?=
 =?utf-8?B?amZ5M1UyQUlFZmZQQk9BOUJjbXVoMGtQdDFad0h6cEZmRzBaSWdSRWRWWnV5?=
 =?utf-8?B?NnkyWGJmUFN3QktHZ0dVbHoreWIrcm1pRXhKZnFBS2tPYnh3Y1hwYVNkMkhM?=
 =?utf-8?B?R3QrWExYT3l0bzk3bjFnTm16Q2FvMWtXZW5HdExtUGxYRGNKSlFiL0dOVjZU?=
 =?utf-8?B?dnR2aW0wRkJVSXhZQ3VINGgwRmZWNzE1cmpGbHlXb3FhT2lSZVo2QlFPZEFW?=
 =?utf-8?B?M2l2NGszYmNEbDlSQy82U1FFYkdyWmE1WkE3WG00YnFQYXZ6S092ZGtobDdJ?=
 =?utf-8?B?L1RTNWJ0cFk3cGt3bGdtOHl3VFluYkRnVU1DdVRYSGR0dXJCNk0vd3dPMUp6?=
 =?utf-8?B?bU01UWlqVURoYUZCV05TMlNoQ2ZqdDMxL2JiNlZTNzFFQ2cyNzh0SWppNTVK?=
 =?utf-8?B?R1RWUmFnTzkvK1dxTlJVeW56aHNvQXVmNEFEWktRSzhjdzA4ejNlendFakNV?=
 =?utf-8?B?dkJwR3k4UTI2aTJCQ2U1UG9DVm1aK2NvWWFhY1A4SWFPcU9LWEhZYW1FQTAx?=
 =?utf-8?B?R2p2MXNMdVpPd1RzTG1zT3kxRlYxeE5YQko2MkRoZWgyd1pEZ1VHRFlJM0N6?=
 =?utf-8?B?UUVJVHlncjRuS0VBcVlhWkdVZ2JDeW4yTFdjSnAxSWMrVnA3TU8xZHNMdW9q?=
 =?utf-8?B?MTN4UGdhT3NkSFYwN3djRnROVzZQV3REOU5HL0RlaUhPNjZmT3IrY1g3Mmlv?=
 =?utf-8?B?S2IrWDdhR3g0VXZOQjA1V25qVUh0VzRlbCtydWdxUnpXRWJ2UDR3ZG5DT05a?=
 =?utf-8?B?bVdtKzgvM3Azb2duTmJGL0dhd28raDVQTzhaVFVjNXlsRW5ZSE1KUXo4YzN3?=
 =?utf-8?B?eCtEdjFSckdGTXVRSUY4WUFMYkZGKzNtVW5xSFVjZkhsV1FMK2RMa0dWclgy?=
 =?utf-8?B?YnJ6U1N2TlNLU0RJbUdZNG9BcEZuR1FSbVZjendUVFFReXJzWUd1ajk3eC9n?=
 =?utf-8?B?YVNnVlUydlpEVXllYUFwR2w2ZHA5MzAwNGtjb2hzcXZvb01GZTBZd2VjRUp3?=
 =?utf-8?B?TGdjWTNpZis5c0NDOVgrVmhrNFRpZk1iREFDUEdzM1RTRy9Gcjg4dGx3Z01R?=
 =?utf-8?B?RDdCRWk4Ukd3MnFsT1ZPdXE2cmc1YVlLaldzZkZCTlNFSHVBZDBmS29nL3BB?=
 =?utf-8?B?WkY0bkRoc3BZYXpzOUFQZVVFYTMzek5oMnprSkk2SHpjNjB2OWEvRmJDNGVP?=
 =?utf-8?B?ZGdhWWRKYWFIN1p4bXZiTWlGSloyUGJLazlKejJwYnlZclhML0kyRURzNWVa?=
 =?utf-8?B?ZHdwdDkrQUd1K2N5T0s2NkpZSTFnaHBqejliMERPdVE0cE90MFdPbHR0aXcz?=
 =?utf-8?B?SHBxMEdDRTdkcDdmOHZVbHFZU0pUa3JkY1pyQ1JsRldGeSthdlNuS1N1Zyto?=
 =?utf-8?B?ODlCeUFDZlF1eE9TbnIyRVkxeC9ZcXFHNVY5RnQ0QmJMQTh5VFRsZWVFM0Er?=
 =?utf-8?B?a1VONHVYRDVrM3dBa0VQSGx6OUwzNitGeW95cERqRktPQnNJVlNUcVBqMGo2?=
 =?utf-8?B?VFRreHBDZW9CMEh3K3loOGFZeTIrYXBFL3cwblVaWmFxRFduSWhPQ2V5NXRF?=
 =?utf-8?B?SEpLY2VPb1ltREU0aXNOck4rdmJyU2xDeldnUE1GNzJiWjNhc1o1Ym9hN0pn?=
 =?utf-8?B?QTkrWmNzU0oyN1kvYkpCbEo1ZUhQa2RKek9kUHVBOXRJWXQxVklVT3ZsWjFy?=
 =?utf-8?B?L0IvTzVlQWxpTkllWm9Pd0RDU05lR3d6UndWZUNyTkdKNEF1UnNKUmRNbEZ5?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e4N2bQF8ypPwUiHumK922beUqqoiqLGavOAjg7qAhjowHnU3avBs72PrOzPZ+sgV2+jCt6SD+liXjTUTuYeuF8xSqliXvu7k6nN055P3sMzPlA2Vq9BYBC1O+J6pV7iIFFzM1BQqIqYrpDwbArjDzw//NwYBjVFKABajUz8HXTZ6ePq8Sa2/NJ95zTakbtPpajhJ7ypEeZGPj0AYZZxdp/Zo1wlvbO8j3sMr6gD4SQGpo0pLy/xleUvHDbblbSS58jMH5UNp7gqaOph0d/Z+cqM1O8LB6a/E+Pnfoix7qW+QVsoGWHEVupfAtTLu+X6F/dgEiJh3XLK5cUL5Rvl+gNL/HOFw8zo504CTKvZxsJiOYtZ24oInbho7Ov+KjInxn3uxwjmWlGQdHc7EQbNUojDUoMAcB58aWIZ2wA4n1BDPHc1lrT60ftez8MfdZ6n3Lf4TGq8J3osY5og1q+AFlnKS88qd3m7SaD1YU7JKAtnIVzmJ554ZHgeiT86yzh5lzoX+DSPNW1uTd29iu1QQWZrvPBHVcv8tw1qcwtRZwshoQ9hM8SR4A7QgN2NwWRUPNisBWCEx1/cpz89nVd0ozzW25uL0zlRYKBsgBZc3Jmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81959613-f076-461b-83e6-08ddf20b8947
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:49:11.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDJr+SvgpdLeya4fZhY+RuwfWwDY5HnMSsB0ixWrpuNy76FlV64OuclhiurNCXHMAuqI2jlR7Z5Xg5O8i80ZZT3fJ2dNEZhLMpNosiaJQh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4263
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_05,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120137
X-Proofpoint-GUID: GNU7QuSKjIqpH618_cSxvBx5uS0OeO6K
X-Proofpoint-ORIG-GUID: GNU7QuSKjIqpH618_cSxvBx5uS0OeO6K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX7aJjK3TbvwWI
 8f++X7O19Qc0L4N0nnuEqaNZd9t5j0aKZBK0QsA+/nZYxj1dCkHjrMy/BwbLDgZVmyj2BCgzIOC
 Vwti83FdElXGEwibrYiv84be34MTcc2CVw8FbCldls17RLrY51+OihnMeYj4Tu/e4+RZRa3WGHD
 8gOo3oWon7C17+Fb+RRoCb4xRAHxcpHNellkgoO+Kv1qRxzvZA1YJ8WrbFEeWGMIj7f4TOyjdFE
 gFjSO9qu+50Bj0IFN9hfS3Og/kB/rhHPFztrhVKHLZb4OOpgafA9X6OtrZVtPn9ULDAPAUw8N65
 3cpsun3hfnyRc0eB+B41TSfaNGDGVreTguJBUs7Fo4JQ9kb2MYiROkIXoVYejeSuri5y0wq0Jfo
 /J2zjpZ3
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c432eb b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=-IEZF6TgUwQUI4nEUe0A:9 a=QEXdDO2ut3YA:10
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

On 9/11/2025 11:09 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add the cpr-exec migration mode.  Usage:
>>    qemu-system-$arch -machine aux-ram-share=on ...
>>    migrate_set_parameter mode cpr-exec
>>    migrate_set_parameter cpr-exec-command \
>>      <arg1> <arg2> ... -incoming <uri-1> \
>>    migrate -d <uri-1>
>>
>> The migrate command stops the VM, saves state to uri-1,
>> directly exec's a new version of QEMU on the same host,
>> replacing the original process while retaining its PID, and
>> loads state from uri-1.  Guest RAM is preserved in place,
>> albeit with new virtual addresses.
>>
>> The new QEMU process is started by exec'ing the command
>> specified by the @cpr-exec-command parameter.  The first word of
>> the command is the binary, and the remaining words are its
>> arguments.  The command may be a direct invocation of new QEMU,
>> or may be a non-QEMU command that exec's the new QEMU binary.
>>
>> This mode creates a second migration channel that is not visible
>> to the user.  At the start of migration, old QEMU saves CPR state
>> to the second channel, and at the end of migration, it tells the
>> main loop to call cpr_exec.  New QEMU loads CPR state early, before
>> objects are created.
>>
>> Because old QEMU terminates when new QEMU starts, one cannot
>> stream data between the two, so uri-1 must be a type,
>> such as a file, that accepts all data before old QEMU exits.
>> Otherwise, old QEMU may quietly block writing to the channel.
>>
>> Memory-backend objects must have the share=on attribute, but
>> memory-backend-epc is not supported.  The VM must be started with
>> the '-machine aux-ram-share=on' option, which allows anonymous
>> memory to be transferred in place to the new process.  The memfds
>> are kept open across exec by clearing the close-on-exec flag, their
>> values are saved in CPR state, and they are mmap'd in new QEMU.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   qapi/migration.json       | 25 +++++++++++++++-
>>   include/migration/cpr.h   |  1 +
>>   migration/cpr-exec.c      | 74 +++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/cpr.c           | 26 ++++++++++++++++-
>>   migration/migration.c     | 10 ++++++-
>>   migration/ram.c           |  1 +
>>   migration/vmstate-types.c |  8 +++++
>>   migration/trace-events    |  1 +
>>   8 files changed, 143 insertions(+), 3 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index ea410fd..cbc90e8 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -694,9 +694,32 @@
>>   #     until you issue the `migrate-incoming` command.
>>   #
>>   #     (since 10.0)
>> +#
>> +# @cpr-exec: The migrate command stops the VM, saves state to the
>> +#     migration channel, directly exec's a new version of QEMU on the
>> +#     same host, replacing the original process while retaining its
>> +#     PID, and loads state from the channel.  Guest RAM is preserved
>> +#     in place.  Devices and their pinned pages are also preserved for
>> +#     VFIO and IOMMUFD.
>> +#
>> +#     Old QEMU starts new QEMU by exec'ing the command specified by
>> +#     the @cpr-exec-command parameter.  The command may be a direct
>> +#     invocation of new QEMU, or may be a non-QEMU command that exec's
>> +#     the new QEMU binary.
> 
> Not sure we need the last sentence.
> 
> If we keep it, maybe say "a wrapper script" instead of "a non-QEMU
> command".

I prefer to keep it because the point is not obvious, and I had some
discussions about it in previous versions of the series.  I will
rewrite as:
   or may be a wrapper that exec's the new QEMU binary.

>> +#
>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>> +#     stream data between the two, so the channel must be a type,
>> +#     such as a file, that accepts all data before old QEMU exits.
>> +#     Otherwise, old QEMU may quietly block writing to the channel.
>> +#
>> +#     Memory-backend objects must have the share=on attribute, but
>> +#     memory-backend-epc is not supported.  The VM must be started
>> +#     with the '-machine aux-ram-share=on' option.
> 
> I assume violations of this constraint fail cleanly.

Yes. Migration blockers are added, and print a clear message.

>> +#
>> +#     (since 10.2)
>>   ##
>>   { 'enum': 'MigMode',
>> -  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer', 'cpr-exec' ] }
>>   
>>   ##
>>   # @ZeroPageDetection:
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks! - steve


