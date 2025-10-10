Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD3FCCD184
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 01:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v71qb-0002Dj-G8; Thu, 09 Oct 2025 21:23:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v71qU-0002DN-Dp
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 21:22:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1v71qO-0002ku-Mw
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 21:22:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 599Kg4Tu019782;
 Fri, 10 Oct 2025 01:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Nq/ILf8kdy2UzYQk0xNPCTOgVEOe5C6MCqLyWcSgtak=; b=
 OF5liyD6J/6VZBQRVxNM92YmT6Mq7WrZkCgUAJVGDoe8ULgut/4k33r3/6qDALwn
 YABcy/SsBR35aUErNPpWTwhSg7CFz8HqEVSzAjkNlse8wUGIPv1xYPeaZq/vraUJ
 bs5QVDcRlbK87eeuo/PNE2zWvLhgR31EepVm4e+nTbok4h4X+w7btmPqqibxGfQ0
 VKeOiv+5a2FkuQv7TakPlsjLZ1bwiJIJEElh+00nHhGVJ72jMaWR6l+gStn9gWEJ
 iAQJjb3vhIuIVlRmFsuKWT5AYZOEL05smwTXuv/THDP6+d5FeaATvY5TPXX3cbrP
 xyljkz+qlKiFYo2vvxt1QA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv69tqy2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 01:22:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 59A0Xeue022741; Fri, 10 Oct 2025 01:22:45 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv63d8dj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Oct 2025 01:22:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWGC61rmYq8ym1r1OagM3pJ2Pi5Ua6DY/dV/VL2DK3+JM/jDRKk5EJ+4CTBLxaPv2XUhXkV1iNxqz3ygHrL3YGzNyDa8FU7foMWoA47FSfSr+PnX/+R+w2vSzrndj2eaC6nY0zfnUw6poOlSBjjyGQ+Tra1VTY5VnlyekdByqwHLOeWR7v5JZX842vhAtVaPl5GTAYokRM0Nxb/7LiNuAUclVDgkOFApitr3/TRAt3UcyxCjbXPxTAncPGYaV8NbrGgnT5HGyBVELp7p5xd0BcScN24vxMMC2JFZKjQbXuuMPN4gzKyrexvLn5A3kH3Jkt/pMX/ZErysECbc6WINLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nq/ILf8kdy2UzYQk0xNPCTOgVEOe5C6MCqLyWcSgtak=;
 b=KNdcrQgThScPz2ujhyiJW/Unt84UrSiUh1Zktsg8khAb7Eb16wIGi0khGf5dATsWcoJ8jDkMYGEuGZqI8JN++sAc06+5LcRnEkFQeoVKjkdFoSI08Rewp3fm5MwcFq7dZqgPkuTtQ6WAK6EOyb9w1IBJnvX4G1TVir07Dnzrtpz2jjiArLAQCYZmgsiSN5qPCkxDv1tWcWLc+yeGvyQpPq3m9HbvmsSAg4/P7vn6LMvmSs3+g9ehXhmM0zqlq666tlea2sTe7C4QmF/G29q75w6a8YRldJCEqGcavQxE8ZD03PvmvrtK8motxG1r6OIUHejCbQue2dpVG40fKkZWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nq/ILf8kdy2UzYQk0xNPCTOgVEOe5C6MCqLyWcSgtak=;
 b=u2gWzy4ipYVGo0NPpIJ3n3iupZMZ2xTDci2Myn9ti4FurQMnYTBFGaRpXg6Oq2o4CJOQoWcFJg4jDBDx0ZC8WhaaUpWR8YZgNhEOUWN7b/EMbiXsXE2IsHVkyvbUrYJ2Mxf5t8helimQbdkqeri77O0g1XaLAHy54aWOQ0FZ8RM=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by DM4PR10MB5942.namprd10.prod.outlook.com (2603:10b6:8:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 01:22:43 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 01:22:43 +0000
Message-ID: <91118d9e-eba8-47da-8eea-e535685e4a01@oracle.com>
Date: Thu, 9 Oct 2025 21:22:38 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/i386/amd_iommu: Support 64 bit address for IOTLB
 lookup
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 santosh.shukla@amd.com, aik@amd.com
References: <20251008164324.21553-1-sarunkod@amd.com>
 <20251008164324.21553-3-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20251008164324.21553-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0065.namprd03.prod.outlook.com
 (2603:10b6:a03:331::10) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|DM4PR10MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: d78a894f-8da0-486c-2e87-08de079b8284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnJOSmlYemlmQmpmeTJpNDhiYWhzd2dacFZZajZLdzVHWnI5akVJdGt6bjhz?=
 =?utf-8?B?VmxDN3pEUmdtUGc4L3hjalpxckFycVVMemszTXRxWlN4M2s1b2hHMWhkZXFw?=
 =?utf-8?B?bmd3MlV6ZU8vMHRwS3ozQ3U1d3JBVTZxclhqR0ZpMXhzUjRENTB4L0R6eG5P?=
 =?utf-8?B?eFROSkg5M2RBY1hhcVlOWnd2YnBxSHJhRkF0RC94ZlNkNmNBM24rZVF5RVFu?=
 =?utf-8?B?bWpKTU0wQ05UcXBFQWlOYkhVbjFhdExGaVdpdXJHMG9vQTNYM3RRdDlIbkU3?=
 =?utf-8?B?OTF6VzBNemtWcHVrRU5IUDVEWWVxc3JsSE85ZkZVOWk5UFV2cGJaUG40MjlQ?=
 =?utf-8?B?cVVkdTQ5Z0JxVFM2MmxvNExYZkIyTVVKbFN0bGJ6Z1hhQnlFT2o0eXl5cU80?=
 =?utf-8?B?bFRRTDN1THBBZkQzcmFmd3BoT0NjVGJhL1JkVnIyZitIa0UxUFBhaEJzcDlV?=
 =?utf-8?B?R0hFcnhtZzhTZUZqeWxjSmFhOWtpeXlESnhYTWdaMlQxZ096VE5oc3ZZTTh6?=
 =?utf-8?B?NFJTbk5wYUdWVXE1UUI1YWVsZzJBdlA1U09NQUNOZnJhS1BxUlMveWlBOXVa?=
 =?utf-8?B?eDNGMEdJMmFmRmJDR3RTYy9GeVUzK1lGVU0wYVZ0QTBzTUdGOU93WGU5bVg1?=
 =?utf-8?B?Y2szQ0hGS0xwZ0NVeWtEdFd5dTQxVFIreFMrNXg3R2lFb2NOTkRuTlZITmJj?=
 =?utf-8?B?dGNERXF3bm5hNTVpUDdUWCtrcmpSUStPMDJmdnJJa1Q1MDZPMGp4MGpOTE1B?=
 =?utf-8?B?eHY0eEkyQy9QMmQ4eGRtQ2gwd3pBU2cyMTFtenQ0c2tJdEIvZndMMlpZeWgz?=
 =?utf-8?B?WVEyaTJvamVnaXlYNVZxRGtzblVzaDNvN1hwaDlwZ3FDK2ZsVFFHdXQ3dXlr?=
 =?utf-8?B?TlNwc2xLSkdwVHRxOG1yNjNvNHQ5QWhJWkNQcHR6NHY4NlpleURWbFBOTi9p?=
 =?utf-8?B?MVUxZ2p1YnhFR2xSQVpwUEg3Q1FUNTRVUEVvSkM1TEVobjBiSnZrSXl1QlVU?=
 =?utf-8?B?OVEyZi9XV2RSK1dJWm5HUUxlQWFLS3ozS1UzQTUvejhnbUo2QXZXMVpEM1RJ?=
 =?utf-8?B?eW5aSWU4UyttUEdVemdxRkVSeEMzd0RYVHJRUjJXdW5Ed1phdzI0eENTZUtm?=
 =?utf-8?B?dXhBVGR1eGFneHRPRzRienFOZWlvTzQ4R0tEbng5bE55TmhpYmorWGREdEIy?=
 =?utf-8?B?ZEUzQ1NjUmhSQmV0WTJjeHRFcFV0ZThMVlNObmRySHlPQ2hKZjdQZ25VWXZF?=
 =?utf-8?B?WlFPcVVYLzNvUTFITXZmU1JrcHd2Vkk0aWNUNkltSG1maEt6L2FuSzB1SDI0?=
 =?utf-8?B?M1g4T2tnNmhSbGdQL0t3UXc4c0ptRWJOcGRTaHdHeE1HV2xyOG5Sa2lOc2dt?=
 =?utf-8?B?VHUrWDd3MUNGZ3hScEs2a0RZWlFjSVpCVGlIb1RtKzN1cEdQK044TXp5UjNX?=
 =?utf-8?B?aEdzUGVHaFdSVVhvenI1Mk5QV0dMdk1wQTl2RG1TWCtiUkRyMUxhQ0NDWnBY?=
 =?utf-8?B?SDhxNElUVHVtaUdmcVV5bGpxaExrL0JmcXpsdytiTDRQZnJHUkNJMlNWVFgx?=
 =?utf-8?B?RVBrZ0F1UzlNcU5zSVc0VlVWTHpkek43RXVOUXRoeHhYbElsUllvSzhMTTlU?=
 =?utf-8?B?MGxjVi94cDdGTS9PaFlRZzBJbWhFNDJ3RUZpQzMzdkZ2blU2cFNJNnlRYmUv?=
 =?utf-8?B?ajBSaHo3T0Jlb01Zdld6djdjM0IzZGpybHN0b1Z0TUZHSGxEL0ZNVU1FQkRt?=
 =?utf-8?B?bk05ZUNObFdCMVl0UDZVWU5oUkFBUGU4ajNoZWdyemI3bEVtakVWUlVHU21K?=
 =?utf-8?B?TWdUM3QxbG5tdEFMSUVVbFRXQ3V4MXJXK0FSMHlEZHJGQTRzaU5rdGx0ejNJ?=
 =?utf-8?B?ZmNDWk1XK3pSTnkzbGpLOFoyYS9tUWpSaEZDRkVrSWRjeUxkbnJmeFNhQ2dS?=
 =?utf-8?Q?Af20FIpS6tXMxvIq9jk3HeO5rhQiI3rR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzdxNDk1VXpaMFZnVTJOb1hLbms0Rk5vRFVkZ1JtN3p3U0VFWHdLWVd3Ujly?=
 =?utf-8?B?cHErNlJFS1FjUTErbnlrOHZqaVp0QmhPQ3JuV2RZdndMclN4WTlCVXFxeTc2?=
 =?utf-8?B?WWdxdFBEb0FWRlhOaE53YndhbXdhNGs3UmdpeDNvSzk4UHM5UGpXbDZSNnUx?=
 =?utf-8?B?TlRDTFpOLzJTWFhMTHVQOEcwQmYzMDA5dW1xbVNjakUyZkdrTzRmK0VkR0Z1?=
 =?utf-8?B?QXE2ZXVRWnJndEFEcHNtWUtBbnNLbmJNbG1pS09YKzJvYjl5NXpKN3E5SlJM?=
 =?utf-8?B?cXFGOUlyOGhsc01ZbUpjZ0s3RE9ETTFIYXhaUU5zNTdVQkVMUGlsRldxOGVK?=
 =?utf-8?B?b3IzTk1TNVlTMmw3ODZQM3p6UU5zdWkxallnVkdBemNvK2dzZmZLaEVPbW92?=
 =?utf-8?B?NUo2MzlQb2FoWm1PbU5mcC83dDlSbEFOZXNOd3h2Q3ZwOHd4UjFtRjhKMEJw?=
 =?utf-8?B?cWpBRVM5RVIwQlZ4TTF2OE9xT3djdFludkFxR09hSWJUVThGRld6MVJERUNK?=
 =?utf-8?B?aGdQSG5oQk05ekh3c2tyZDRxWVFQa2N1VlRkK0kyNGErNS8va0JIYjc0Z0p2?=
 =?utf-8?B?RXp1VDlid3dEYW9tdE9lYWM4UVBMZVZPc1N0am9BSEVFSXdSTlBNT1RTYm9p?=
 =?utf-8?B?V1VWTXRzSERuQURiMkFzemljRmtseDR3SUx0SlZTTzArUWprMGV5LzYzVm5i?=
 =?utf-8?B?d2VoUTFmczRCVG1jNWQrVlAvbGxYZFVia2R3Z3UxdmcrVmZWMnJVQnhWcC9Y?=
 =?utf-8?B?YmFvT0gyR1hWWGtYTUx0b2puSFNHL0lOYUxvamorZzRTcnFLcmsyMFgxdU05?=
 =?utf-8?B?ZDl6NkVGK1hYZzk1Q0ZNemp2UFRWaEJOdWRGbVczbEVNMU5YcTEvaHNBVGRN?=
 =?utf-8?B?SVhGL2hWdW1RYUhGRndGZjZ2MmtoSEcvMG9iQWZrQ3pGTlFidDB2Z3VzM3M2?=
 =?utf-8?B?ZndEL0lGVXY3Rmg0QURHSU56b2piU3B1M3lKek1IWlhPaGZFczR4U0N5TDYz?=
 =?utf-8?B?bFI4Y1dBRm5iVHJYb3hUVXJJUUtHR2JyNVBRbDZLMlpYdDAxOHZNd3hWM0wv?=
 =?utf-8?B?UUJJY2paMzdMVllycTNVd0tSWEJUL1N4UEluN21mUDVBbUJqNDZiaDdZMTRO?=
 =?utf-8?B?L2J0eTZVeGI0ZlF5eDdTUUpVY2pTYzR0VnlrdkprbnR6R1c1ekpRR3NtcDJE?=
 =?utf-8?B?NHZ4elE0UVRpeEdvODVZcUJsVU5GTmRUT2VXVjZsNXZCWFRKaEIyQU1zcGJB?=
 =?utf-8?B?NGFDZFZqc24wWmUvdmFqUWdSMk0rOWtNc1lBZ00zN0dQN0tNWVVZekVkUjdu?=
 =?utf-8?B?NUVBTkpTUjhqU1ppWDNuUDlYc2FqL201WmtpSlhrTFNCei8rUTZlTWtZQ2I3?=
 =?utf-8?B?Sk1YSVJ2WG5uTVdKUmNtdW5NbU1EZEo3N3k5ckg2eHN0STd5azliU2RLeDJm?=
 =?utf-8?B?KzJ1V01BYmg3U2VMc1RFWWIwTFRMMERJYXVaTjFoZHZBTWluVHZqZEc3NzhB?=
 =?utf-8?B?a09VWmxXaFk5WGh3NkhuR25qM0dvVFMraktDVEZXVWsxNXc4NStjM0N0RTAw?=
 =?utf-8?B?aUtjWXBCQVVOeTB1elBmMG5Hd3JXWThTRDMxY2orSE9GclJVYlVza0c0cHdH?=
 =?utf-8?B?bFFPb2VKd3YyY28zT0w2M1IycGVZcTF6dnB0MFI3aTFTNTM3OWhMdmIxNmxU?=
 =?utf-8?B?Uy9wMVJ6UG1SNDg2NWtZU0tZQ2FINDFucEUrQkFaeldYVjUwUlBkYnUwL2NF?=
 =?utf-8?B?YnRYbHZQK0kzOHhzcnFUWTYxU2xFNEs2bVc5cmllcmJNblhhcUFQSlVzdmcv?=
 =?utf-8?B?S2JXUi9GWnoyVDU1OEUyeDU2MUdOSGpXTVJrNU1qN1JOUzdRTzFWQ3dEekxk?=
 =?utf-8?B?a2VrdHFEcS9tM2hGcVk3ZGVaa1NXTTlUSklCT3B2ZGQ3Yk9mY054MWFmcW1q?=
 =?utf-8?B?am50TkNhVSt6b3RXcVdMajNFZjhmRCtFNS9wQ3ZkSjlWZVNETFlRV05RWTFp?=
 =?utf-8?B?eFNWQVhzelU0aDdmb0V2a3RsNWFRS1RIVmwrVmlOME5FN09lTkYwMy9Vd0VI?=
 =?utf-8?B?eU1rYm9RNDI4MVd6bVNHc0o2aWRVRVB6Z1JSQS9OM0JaOVAwN09aZUlaN3Uw?=
 =?utf-8?B?SkZLSU9uaElZY3ZHWFh3TDQxOHRFOE9WTHU4Zzg5ZjEza0cxL25FMmdQV2lK?=
 =?utf-8?Q?Sg2J0KY6cidleUixukuQCAU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 889NzdYBmxIUY8d5ktxfqfz99Ko+q8ukLd3MqzmVI3anWywUCRC8FaFVajNQKHI0cr//QnsEeD1SIoRiH8FhFNQzo5mQIk7BC/Lr2xR/SrFWHaoQPcjvGhWKY9yZFQ6T+O+JVnREud+f6VnER9hrij3+pOL6o+OUPRzehlTL7p17cxV3OmWdZnbOVfBGDR4SjOdciOMnjvNa048BM9RgPPM4a9tVBZLlvtc23Rpr9RJHbq8rm59Bbtd6DIQW9VS76hkFKnt3/udytpDk6c12hXJz7Ahz2zuF2qnXLc6npy79w+NwpU4uST4QscYMghu30a5V5fW/+aNr5sLkox2TkmayFdfOELdgsVJIv1wggOmG0svobYA2mSceFmj3xSsQdYu0uSYXZGq0GVkK7Yn6JDIs3BZe6arhj6yQQtDjQ2jEwJmv0S2iCvIUx4v+CRov1zNC70YVs4E3rtab9vbkRjpE3aMZSg5K6Hi1hSujtBDMUw7FAGJZ4mv2r6KT7hCeUppnZsMKoVD/TNAyBNG0odmDcr9Kq29tVqKUqg3DKHxzNCCqSFI3Qyztw3Nl0o2YXQYm2y9Tl0Bb1yBqEP2UH+fatvKbVGUJCWKMMVZuUmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78a894f-8da0-486c-2e87-08de079b8284
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 01:22:42.9971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzqIXyOQEdaQnHl6qiPEkd4t6+H4pEgBn1h+zU4kL5+6i4PrSC0qzMaiDcxSII3/U3XWA89nNmwQlULEO73TNY1KD+cPxwxqcj8sjEj8kM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_08,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510100007
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzEo/eWUpukZZ
 QehpZwGnwBTBXxrsuwG/qUGLgMd6nJVPrF8bwTU/SWbKT+VkjL2kAqMZT5v/WJfjWQ4yqLbh9gV
 6PpvGynPERzbTacukF4p1VcyytgXnxU/vGRQl+DkTYs5A1S10CiLwF08I2+gVOk66+G2bSzjuEp
 a6QmuAtNwI8nBLxN/EkkD4g9jbWfnYeq++TBX85Iq9cFh/1NqmWm/bx1txXZfP6MvdkS166mR1V
 4ZMXuF5a3BAF8NdIuPRcm6wznxi9jEM1bvGPiu9vIALkpqZypUWj9X6JqIQu/gpRAU0XcBy0Ikw
 Zx0/KT29DoyUPuOn0tWl9sd+IQvNwAudxt/2auK2i5WiNZzoAMaByfNSvhGvKCNi5fuynKAj88T
 giVXCmKj98sVfDwkmwpQzRyfjMj8aZzfp9N0gfB9kXyoVsNqIwg=
X-Authority-Analysis: v=2.4 cv=dtrWylg4 c=1 sm=1 tr=0 ts=68e85fe6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=zd2uoN0lAAAA:8 a=IhmBEbEcWtrnWi-7MzAA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-GUID: 82eoTcCaCuciop1SF3EfqDZnnnTTqqn6
X-Proofpoint-ORIG-GUID: 82eoTcCaCuciop1SF3EfqDZnnnTTqqn6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Hi Sairaj,

On 10/8/25 12:43 PM, Sairaj Kodilkar wrote:
> Physical AMD IOMMU supports upto 64 bits of DMA address. When device tries

s/upto/up to/ and "a device"

> to read or write from the given DMA address, IOMMU translates the address

"a given DMA address"

> using page table assigned to that device. Since IOMMU uses per device page
> tables, the emulated IOMMU should use the cache tag of 68 bits
> (64 bit address - 12 bit page alignment + 16 device ID).
> 
> Current emulated AMD IOMMU uses GLib hash table to create software iotlb
> and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
> to 60 bits. This cause failure while setting up the device when guest is
> booted with "iommu.forcedac=1".
> 
> To solve this problem, define `struct amdvi_iotlb_key` which uses 64 bit
> IOVA and 16 bit devid as key to store and lookup IOTLB entry.
> 

I wouldn't necessarily mention and quote the structure name since that 
is an implementation detail and it might change in the future.

Also, the current implementation also combines a 64-bit IOVA 
(technically a 52bit gfn) with a 16-bit devid, the real change in this 
patch is in how those same values are being shifted to construct a hash 
key that avoids truncation as much as possible. So I'd reword the commit 
message to highlight that.

> Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>   hw/i386/amd_iommu.c | 51 ++++++++++++++++++++++++++++-----------------
>   hw/i386/amd_iommu.h |  5 +++--
>   2 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 0a4b4d46d885..5106d9cc4036 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
>       int devfn;
>   } amdvi_as_key;
>   
> +typedef struct amdvi_iotlb_key {
> +    uint64_t gfn;
> +    uint16_t devid;
> +} amdvi_iotlb_key;
> +
>   uint64_t amdvi_extended_feature_register(AMDVIState *s)
>   {
>       uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
> @@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
>                PCI_STATUS_SIG_TARGET_ABORT);
>   }
>   
> -static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
> -{
> -    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
> -}
> -
> -static guint amdvi_uint64_hash(gconstpointer v)
> -{
> -    return (guint)*(const uint64_t *)v;
> -}
> -
>   static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
>   {
>       const struct amdvi_as_key *key1 = v1;
> @@ -423,11 +418,27 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
>                                amdvi_find_as_by_devid, &devid);
>   }
>   
> +static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
> +{
> +    const amdvi_iotlb_key *key1 = v1;
> +    const amdvi_iotlb_key *key2 = v2;
> +
> +    return key1->devid == key2->devid && key1->gfn == key2->gfn;
> +}
> +
> +static guint amdvi_iotlb_hash(gconstpointer v)
> +{
> +    const amdvi_iotlb_key *key = v;
> +    /* Use GPA and DEVID to find the bucket */
> +    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
> +                   (key->devid & ~AMDVI_PAGE_MASK_4K));
> +}
> +
> +
>   static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
>                                              uint64_t devid)
>   {
> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};

This line initializes the key fields with the opposite of the intended 
values. Please use this initialization style instead to prevent these 
types of errors, plus it makes the definitions more readable:

-    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
+    amdvi_iotlb_key key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr),
+        .devid = devid,
+    };


>       return g_hash_table_lookup(s->iotlb, &key);
>   }
>   
> @@ -449,8 +460,7 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
>   static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
>                                       uint64_t devid)
>   {
> -    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
> -                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};

Same as above, key fields are initialized in incorrect order. Same easy 
fix by using designated initializers.

>       g_hash_table_remove(s->iotlb, &key);
>   }
>   
> @@ -461,8 +471,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>       /* don't cache erroneous translations */
>       if (to_cache.perm != IOMMU_NONE) {
>           AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
> -        uint64_t *key = g_new(uint64_t, 1);
> -        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
> +        amdvi_iotlb_key *key = g_new(amdvi_iotlb_key, 1);
> +
> +        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
> +        key->devid = devid;
>   
>           trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
>                   PCI_FUNC(devid), gpa, to_cache.translated_addr);
> @@ -475,7 +487,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
>           entry->perms = to_cache.perm;
>           entry->translated_addr = to_cache.translated_addr;
>           entry->page_mask = to_cache.addr_mask;
> -        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
> +        entry->devid = devid;
> +
>           g_hash_table_replace(s->iotlb, key, entry);
>       }
>   }
> @@ -2529,8 +2542,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
> -                                     amdvi_uint64_equal, g_free, g_free);
> +    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
> +                                     amdvi_iotlb_equal, g_free, g_free);
>   
>       s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
>                                        amdvi_as_equal, g_free, g_free);
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index 38471b95d153..8089f9472ac4 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -220,8 +220,9 @@
>   #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
>   
>   /* IOTLB */
> -#define AMDVI_IOTLB_MAX_SIZE 1024
> -#define AMDVI_DEVID_SHIFT    36
> +#define AMDVI_IOTLB_MAX_SIZE        1024
> +#define AMDVI_IOTLB_DEVID_SHIFT     48

Remove AMDVI_IOTLB_DEVID_SHIFT since it is not currently used (I assume 
it is a left over from earlier prototype)...

Thank you,
Alejandro

> +#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
>   
>   /* default extended feature */
>   #define AMDVI_DEFAULT_EXT_FEATURES \


