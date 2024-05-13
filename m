Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5BAC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 19:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6bN6-0002u2-RL; Mon, 13 May 2024 15:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bN3-0002tG-5I
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:30:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6bN1-0008S9-87
 for qemu-devel@nongnu.org; Mon, 13 May 2024 15:30:00 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DIrd4X016843; Mon, 13 May 2024 19:29:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pwS9cl4HqiOYy7guX01nU8L5H2fxiI2vbSmN04ctdpE=;
 b=dbc0MLs11T+YBbXxq70bIKS/uXnfs/TaBRt+5PGf3mHvTS7FW6AA/XcYro9yChYhqpo7
 G5Dtc49jVPHJa4aucutcjkbnAJMdGHap2dc+gGS/hWfvxnuwwZmJJxJDn/P5LqtoY4+v
 1AHJFhSqrLP89yxQRzXaoX52h8zvT6fwbJyBTZXWNjKqck6AA5hDs59Ihy/YSLNCu8Mj
 krfcL+TyrRivKbystS9OR4qkqeYjc6MlgSYTEhad95rB4pGk8/X2PBsHQC2er8KZj7qp
 pOznD54KSXP2LsK3xs4kkPXyCpU3mvRmgHrQPlnZqGUA9kNpl4Ts6Eldb2Go+bl3CMm5 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh783e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:29:55 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DHtRdI018104; Mon, 13 May 2024 19:29:54 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3y1y4cg8vb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 19:29:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2hYajHVBcfKQHyGo1VrWuI6R6dljk12mAnQDAEgYREa+9Y6vs/SemP6n0oD1/yqbIxY/6JFRqYJ6g/espcpCQ9UV6VdMiGrCd//i4KERxbQjLBpxCBuJVyw/Eybxhb/O9APFQKy643wnUHd4OB22rRP59iihqeyWIxEWoPaM9P9qP9gEd+OHcsjFUeo1oWG5pvXF2vKAIavqaz45/zBRbIs44q3c+M9FXBiioc+35Vimr7y3eOzJ5/5SqDTpZehyBh1V3TZvMaMGwwe7x1MLHqb9FH3ZyO/Y/ZfR9Asy9FSw2xGua9m8DuT7S/4ahZe9mgoQ/xBECXMa32tag9PhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwS9cl4HqiOYy7guX01nU8L5H2fxiI2vbSmN04ctdpE=;
 b=nX1PlAsPtVhJhwf9yj5oKZ5dlWaZfsxdrwjHLk0RFZvMoKCMe635taArm01awsNQp2DlmLZAQjiQ7yi0TWDyBkNynlaj7eShxkp+jIeFYxq1fKBxyNgEzDP6H3XBGitEUWvDHc3wOqNNGZV92GsRCn0ZhM8+2uUbjbCW+s0Bw1IJDHPPfVz0ZXUvJE11YqnD9BcWEPH2hCf6M+tL6igggJ8Wx6l+mc7MaCEdQXw8O5Qtj9iM7lY36j0DDWIIAjH8QeDT04av2uZEsI7fXpov5oQyKBl/4CdMDV/ldp+Q7jg7Awu5lPUJYh2lx/13b7VU/K4LDnX3N3dQSd3O/7AEpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwS9cl4HqiOYy7guX01nU8L5H2fxiI2vbSmN04ctdpE=;
 b=ohu4QMUO+xFrfacbfDI6VOGfzamMKx29lQSOAcna77WrkeSazI4NwdQw/kQG2QzifTJKcY5uYIwc5i+gP2dGTcMnWaYYTs0XZk0TZ+OwB1fdICsz+Cuq7rJkbW9a4UtfObfAKdJt3M9/Yvexz25hta94iB7P+52aDguEqftk8Qc=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 19:29:52 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 19:29:52 +0000
Message-ID: <00db254b-2e0e-4699-8d0f-df0e64853a23@oracle.com>
Date: Mon, 13 May 2024 15:29:48 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 24/26] seccomp: cpr-exec blocker
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-25-git-send-email-steven.sistare@oracle.com>
 <Zj3SyzYMJzluwKoQ@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zj3SyzYMJzluwKoQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0016.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::29) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: e78e4a40-f3ec-4d2a-c13c-08dc73830ffa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlJVRXdtVWQzdUFNUlpXcmNhSmR3UHBmQitURGxMSzF6cW5oWHZ2ZFFaS0Ji?=
 =?utf-8?B?cHRKdXc2OHBzN1hDN2liZkRxVDRRdVk1d2dQK2Z3L21QOHVnTVBWRXdYMnFO?=
 =?utf-8?B?eldDRmVaV2ZnY0xEL29FOHNFa2VKeWdsdytFU1JCYjg3bmF0a3QzaHNrL3Y5?=
 =?utf-8?B?dnY2YmNRL1hBcEUyT1AzRHBINXg3SjZFMEVUNzN6SHZFYis5TWJ6NWlJc1I3?=
 =?utf-8?B?RnhaVmtzWlkxakE5UjhxT2MzaG1jd2tPd3VySmYzZno2NWRaaUZIRW9GZVJM?=
 =?utf-8?B?M1UyRHBGbjRXTnBITm0vUW9NZG1jYTI1bzA1Yk1LYUhVdFMvS3paV0ZvaENJ?=
 =?utf-8?B?bWwydVkwT0xkY2JHMVRnd3RmcGRTTmFWSlFtWGtaUGJLOTNRNHNPMGxFY2JP?=
 =?utf-8?B?RkFUVWZTWExXN0d0Ukl4T0NVWmVoUEJGeVVqRW1icWlkWXc4S2Y5dEtnUm9B?=
 =?utf-8?B?cUpRaFVxYmpuMWh5YlE3Z2ZQSERhR29sTnI2OEc1TXZzaGNxTytNbXVsOWZk?=
 =?utf-8?B?L3A3US9TSWhIMHdOemY1bjF0UlhER09kMzJRdHBtYTltVi9PbHkxRDFmQjgr?=
 =?utf-8?B?N3c4R1pmVXBhdDRiaFQya2xiV29DR2orMmN4WkN6S05TdVVpVU1jTnpUc21s?=
 =?utf-8?B?NEYyYzFIYytSWmE4SGNSeU4vbXdPRm5nT25UMnVtMlpWdk5kOTgyYkNxNkov?=
 =?utf-8?B?NytiQ1daMHVYNE5odmxNU1piTk16aE9tdW4vcGtVai9kM2VWRnk4VFZNVlEz?=
 =?utf-8?B?Sk82eUdHWGJQaTdRT29kQzBBd01jVk5INEhFekh5NkIvUUlVa25sQ3pJWEJY?=
 =?utf-8?B?VDJvUmlZNG1sUDViK09DNFZrUDFvMTNwSm5HNDg0RkNMWTE0aE5NZEQ1ZjBx?=
 =?utf-8?B?NXRHUnQyRGpTeXNYRHdDbWJ6VE9weWVLSkhMcWRsSFdWUGhsQlp4UzYySy96?=
 =?utf-8?B?M3VRWkVGdFNLU0RHQi9OQi9IQ3Y0Yk51N1dpdk9UM2toaituL2xjK0lBZEZr?=
 =?utf-8?B?aHJvck5wQ0tzUnZrUjdSajNXRUExckMxdmVMTjlNV3ZxWXIvdmJnNjNISGN3?=
 =?utf-8?B?SjNrQitQMUtlYTdYUGtBZ0g1SU1IU3JtK21FYWdMK1F2cTBId0d0U05aNENv?=
 =?utf-8?B?R3BmcVpKODhVanZheVFqVTlkTkZPTVNsRnp5dmdldjkvOVIvVXJMWXhtRUJh?=
 =?utf-8?B?bjJGNTY2TlJGMVdYZ2pNNnBDRkYrY1RoN25GMVBlM0YxdlEvbm9aNUZ4Yzlx?=
 =?utf-8?B?U0dkMXdtMUpSVEs2cU14ekxGQWJuU1hPME1waXplSmdVejIwVTBNRldYUE0y?=
 =?utf-8?B?UmxNeTlvcTczVVd5azVBR2NWWUF3REJuTGdFL0lxZ0RXUDBmQWk5MnYrSTcx?=
 =?utf-8?B?ekFoNWZIdFIvbnpFZ29SZm9mV0JUWFFZQi9reDBYeWVzZDZLRFRIL29QMm9s?=
 =?utf-8?B?cXJDRGFmK2gzcVI2dXdvR1QxbThjeWExTWlYdS9MeXBmalNIQ04zWWg5RFdF?=
 =?utf-8?B?a0lQVE8rR3lxTHl0WUwwbjg4Z21CVytHNGQwcnBZMXVVTWc5dEJDN25pUVBr?=
 =?utf-8?B?SHVrYXRTUzVqbjRnczhZQ0pzNFlMWDQyYXRFa0VFakR6KzNOR0hjOEsxUytW?=
 =?utf-8?B?Rm0xSzhhbjdjRHhPdmZYUERWdXlWSDhpb3o1YTdhZW1pSUg4WUtlU3o3VGdY?=
 =?utf-8?B?Q0hZVTdzblptKzQ1Q0lCNGRma21RdHpYc0hrNlR4Y0NPU2RJMHRhNUxBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTl1VjEwb21NZWsxdG9UVW1ST29DYngyS1RUKytKUjRsVm5KaHBubHFraWsr?=
 =?utf-8?B?YldFY1JVeDdvOU1MbkFnQnpIcEVMWGxrVjhJMnZ3Ym1DLzl4Nkk5OHJramdB?=
 =?utf-8?B?Nlc0NXV5aHI5dVVYbDdRdGo4RVNxR25NNTg2eGhqRWJWa1gxNUlDQWM5Rk05?=
 =?utf-8?B?YU5yTkJsbi9IcTJKdEN0SmZ4QmthYWk1SjFlQWl3UUVjYllHZnY0aWhNWTVo?=
 =?utf-8?B?d1NseWZ1eGkxdVpjSVlnNUhqREZUVC9EMkpUVUxNRUF1bUNNdHc1aHRad2h0?=
 =?utf-8?B?TzlIcjVKdEFheVliQmxVbVhrdll4TG15OWZ5TStYS1lTQnl1QTg0NXl2Nnhq?=
 =?utf-8?B?bS9ka3VuS2pQK0ZpL2RxK2taMk5NYXVHaUpmM1gvdHJmbmphRjdpSEZITHRV?=
 =?utf-8?B?U2ZYRDJOUWIvNU4vRE1GN0RIYmJEeEo3RkovNEpneG8yNmhPS3BQY3Y2N2xG?=
 =?utf-8?B?WDBmWnpUTnA4Y1VkSGpOcnkxNEVKMTFuZXoyR3VpcGgvUjlGK25SSGlyaEJw?=
 =?utf-8?B?TkFTMmhDbnJCbG5VRGVmOXVpVGhpZ21yK0xSQzIyZ1RPMmFoMXV1SnJrRzRZ?=
 =?utf-8?B?bWphZ3gwenhUSzl0eTE1MkhqZG5TU3BJc05pSmRDR3laYitiZ3dKa0FxR3Fw?=
 =?utf-8?B?MnVHNXZlSEY0MkhXc0FpOFhJWDZ6ZXNkdW11d214NnNhM2JrckR5UUZrM2k1?=
 =?utf-8?B?NDlxdGpDNFA4Sm9TOXNDU3UyY1pVZlVuZWN3WW5vZytnN1c5U2ZTMXpMRFRs?=
 =?utf-8?B?c0dGNDBzVjMwdFlINWx2N1I4TkJ0SXRUYWdueFE0WEd0L0x0Ykl0TVJGeUNs?=
 =?utf-8?B?M3BocTduc1ozelBpbHJzR0l0UDVnaUVZUlVUWnRkR1hTWHhZQ09BelVkcUhy?=
 =?utf-8?B?czdyTFlzYkFaUlR4Qmg2ZnRGTXl5MVRkeXpmTTNRSENUN1pEVkpvUGhqU293?=
 =?utf-8?B?RWlpNzRmOE9qSUFoUUY1RXdVUkVPNHVUMFlvWkVoZDV3TXliRlhJNjJzeXdn?=
 =?utf-8?B?QmQxU29zbmx6SWY3VE5KcFY4d0dtUGN4ZFRnTVdTdzM4Tll4K2x0MVJpY2xi?=
 =?utf-8?B?NlFjWjMwS2V5YkZlTjA5d09IaFJHVGNvRWNONW11WC9qT3QwOHhheWx6MTdI?=
 =?utf-8?B?UjhNb1hYY3MySExpeC85c3QxRnN2Ty83Q3RLVlNPNG5Ma1VqMXp6ZDRLTXlF?=
 =?utf-8?B?RFZQWXFZTjM3ZEVkOEYyT0U2U0ZYOU5pS0d6WVBFeEM3K2pEeGdLN0FmU3Zu?=
 =?utf-8?B?YjR1bnhQREczeXFRSDJVelBxNTdOTnpYdFJnbWhUWEV4L3NOWUNDOGtjMGlC?=
 =?utf-8?B?YTVSb3VtT3lndXFXemlYVWtPQ0l4RUw2UWlyZXcyVDk2ZzhjQkFUcjljem82?=
 =?utf-8?B?K2xSay9YT2lyRlBNS2NhUldDYU51THZvMTMrQStrU2xpbVNFcm5qSlF6UGxF?=
 =?utf-8?B?UTlCNEJOQUtOVDExWDlrN1p6NU9rYTNkQ1JvTi9WNzVhTUswWHdWUkROY2Zn?=
 =?utf-8?B?Zkd5eUZFUEtRMUxwWWVscnpKN2NNajVzOTdqYnIveGFwbFRPM2o4Q1k2SzBJ?=
 =?utf-8?B?WXNQRnVIYUhrbGx2UERMT09BTVhNZ08rbXVPYjI0WlBEbm8xUUtDWENubFJm?=
 =?utf-8?B?ZVhMRWdNcXQ3V1ZFRHEyTTE4by9tSWIxQVpDWTJ4SjRsSUV3SzhHT3BDTGNz?=
 =?utf-8?B?RktwMllmSVY0TFNoOVY3UFZqaU9MUnlXbHBqZFVybjgwWldicnJWWHBNRG4v?=
 =?utf-8?B?MzRLODVLQXdraUNyMzNZWmFOdFc2M292SitWZFN2TGRvUnA3eEQybGhWbklT?=
 =?utf-8?B?MlZabVNTb0FKb3pjMmxGN3pWWTJrVWxkQVlVZ01tWFp4blEwbmxCcjYveGl1?=
 =?utf-8?B?a3NEZ2JZaHZ0MUo2OXp3YW52Z003WDdEZnpvanpXY3dLYkxhUzdTdjB0MW9v?=
 =?utf-8?B?bVowUWROaW5nbkUyV3dJeFhIVkJZNkhPMWR3NHBRZjlRckVRQk1IUWVESkJj?=
 =?utf-8?B?UWNXZTIwRDJpa3h2TDMrMDdFb3ZKbnlBaEtpZk1SU0FmTEhGRlBud1dwZEFr?=
 =?utf-8?B?WmJUWCt2MmdKVWJqYzJOMDRCWVlER1doK1hzR3dlM09FRXpiYWRNdTFVdXk4?=
 =?utf-8?B?TmpZQXM4ZWZ3OW94MDhRb1JmNlFOYTRaRFVDYUsvL3pmbCtIUm9ORzc3SWJ5?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /rG2E7crQUW5VlpDuEbvx8GiLu36XS+eBWHAj8vqdDF0FgCkdWzWNX1l22GGhc6wLOP7zwizrdqMo9/i0Ktnc7mqpkWl9I+q5ii6glZbH2XOyc4e58KsHjE3Johh5xdXrsMazo5mLfekoo6ZOOwigK6wH/Oub7XHFdrwYKHi/sr+ZhcKBeyG3Zr7Rh4I+AP+GYSycpA7Zdl4Mk55poUoPaufszuLGDTFSeOGWRMAzdQsU7d5M+FnBoPm1fTdSxWknfaXnnQW+M5OkOmX/Cf7sKiAq4UEJ96CAWR5fmNDO+6cfchJCrQVwBWkvhXXeNQGiXPHHgqAlwCr7/lxhsyYfZ+mE77JxsqEU4iumHAyFjL3AKt9rzzOu9Vbetuv51C1hI7IhY+YOPh2VJHmFkFu0FYmvpFZTptNXnmSu/VGJu1ocvnuQ0wnIe402+05+BNrEEIIjehIC10czWUjnAhTpR/1WzR5ecwLmJWQJIkpipNbYP3h86CJHAa+Ph1H6PX7Pvt5B/EsBkNPhTbfoF0DiQgmKGXWwkSw9n3czncTNcyoPf+FysdCyVDcdkDwElPrmATRGt8hldww2R1EySHSQs71Jy5Vh7VrkLbFUbs5kY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e78e4a40-f3ec-4d2a-c13c-08dc73830ffa
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 19:29:52.6704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HE+VT+lyYgquxs4C6ep4RFl9CalnRoQgmZfaOnoSae0WGT07jku35+vDyWhNbrg7uNIUGJ2DbKFsnNkBsboQNGVCal1I5+q73T6aQ9YhnAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130132
X-Proofpoint-ORIG-GUID: Bnv6Uw63_MQfoYe86Q2wRAuEhSudp5n9
X-Proofpoint-GUID: Bnv6Uw63_MQfoYe86Q2wRAuEhSudp5n9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/10/2024 3:54 AM, Daniel P. Berrangé wrote:
> On Mon, Apr 29, 2024 at 08:55:33AM -0700, Steve Sistare wrote:
>> cpr-exec mode needs permission to exec.  Block it if permission is denied.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/sysemu/seccomp.h |  1 +
>>   system/qemu-seccomp.c    | 10 ++++++++--
>>   system/vl.c              |  6 ++++++
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/sysemu/seccomp.h b/include/sysemu/seccomp.h
>> index fe85989..023c0a1 100644
>> --- a/include/sysemu/seccomp.h
>> +++ b/include/sysemu/seccomp.h
>> @@ -22,5 +22,6 @@
>>   #define QEMU_SECCOMP_SET_RESOURCECTL (1 << 4)
>>   
>>   int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp);
>> +uint32_t qemu_seccomp_get_opts(void);
>>   
>>   #endif
>> diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
>> index 5c20ac0..0d2a561 100644
>> --- a/system/qemu-seccomp.c
>> +++ b/system/qemu-seccomp.c
>> @@ -360,12 +360,18 @@ static int seccomp_start(uint32_t seccomp_opts, Error **errp)
>>       return rc < 0 ? -1 : 0;
>>   }
>>   
>> +static uint32_t seccomp_opts;
>> +
>> +uint32_t qemu_seccomp_get_opts(void)
>> +{
>> +    return seccomp_opts;
>> +}
>> +
>>   int parse_sandbox(void *opaque, QemuOpts *opts, Error **errp)
>>   {
>>       if (qemu_opt_get_bool(opts, "enable", false)) {
>> -        uint32_t seccomp_opts = QEMU_SECCOMP_SET_DEFAULT
>> -                | QEMU_SECCOMP_SET_OBSOLETE;
>>           const char *value = NULL;
>> +        seccomp_opts = QEMU_SECCOMP_SET_DEFAULT | QEMU_SECCOMP_SET_OBSOLETE;
>>   
>>           value = qemu_opt_get(opts, "obsolete");
>>           if (value) {
>> diff --git a/system/vl.c b/system/vl.c
>> index 7252100..b76881e 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -76,6 +76,7 @@
>>   #include "hw/block/block.h"
>>   #include "hw/i386/x86.h"
>>   #include "hw/i386/pc.h"
>> +#include "migration/blocker.h"
>>   #include "migration/cpr.h"
>>   #include "migration/misc.h"
>>   #include "migration/snapshot.h"
>> @@ -2493,6 +2494,11 @@ static void qemu_process_early_options(void)
>>       QemuOptsList *olist = qemu_find_opts_err("sandbox", NULL);
>>       if (olist) {
>>           qemu_opts_foreach(olist, parse_sandbox, NULL, &error_fatal);
>> +        if (qemu_seccomp_get_opts() & QEMU_SECCOMP_SET_SPAWN) {
>> +            Error *blocker = NULL;
>> +            error_setg(&blocker, "-sandbox denies exec for cpr-exec");
>> +            migrate_add_blocker_mode(&blocker, MIG_MODE_CPR_EXEC, &error_fatal);
>> +        }
>>       }
>>   #endi
> 
> There are a whole pile of features that get blocked wehn -sandbox is
> used. I'm not convinced we should be adding code to check for specific
> blocked features, as such a list will always be incomplete at best, and
> incorrectly block things at worst.
> 
> I view this primarily as a documentation task for the cpr-exec command.

For cpr and live migration, we do our best to prevent breaking the guest
for cases we know will fail.  Independently, a clear error message here
will reduce error reports for this new cpr feature.

Would it be more palatable if I move this blocker's creation to cpr_mig_init?

- Steve

