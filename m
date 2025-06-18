Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86DE0C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 17:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRw9G-0003Gk-Tm; Wed, 18 Jun 2025 13:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1uRw94-0003Ed-PW
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:00:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1uRw91-0000oc-Nn
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 13:00:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IGQVj7004889
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 17:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=wrnnhEIf8H8rbllGXFk4f+yT9ETHPzX8OY0+QJ2xySw=; b=
 CEjTCJchy98Pyc0z5coRkfQZJJVd+kJB3i0PSC+ilyNaTMxqpBxyy3w0Nau4uvvG
 KPgKha5xcP0nchWprdfxds7HBBxL4HzcjhHARogFimSZNYX6x/InNqxbAwbOXQyK
 nPPUpoxWNlDktFKWtwzt8g9Gr6l5nYUh/SPKh1FGTIWx6AXtEBKcBeqgGckFBT/1
 lIDntdB9wCXKxx9Shiqb5QLY+gruYrbk2eB5swOW/EEFE48wKSN2D1/0YVuOJv1X
 xsl8l0jsBbumFJnR/JNVJt/qoUYBp0QGAhbwTyzLJDim43VkSvIczSluBQWU2itK
 5VWRCi7oSG1vmEhz6reHOg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4rb0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 17:00:09 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55IGDX46035207
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 17:00:09 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 478yhanhdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 18 Jun 2025 17:00:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXNPTneXDilclJNM57lpJ6bJir16TamsJt/Nm+FkkrrpCkHPSxQLfcUgtddtJ+qyq3lThNYeP0PhW9bZpMmbdLXQ3IvyecXhQzvaFNpavds721YlXgkQUu5A44CTIBNDSzasZe+BvR9+nv4PyJ0T9fa/NcRZyQYG9MpQun/WZBIgjFcxA0QPhfuz5FPf3T4+qI4nUXwlqo8Ng8fCDQaub1W5mW+l4RTHtFk5JgqbB29hYtCxrLL5dL3Ki2Z14j7lqS+SOg4lTHV/y4gursQoqS5IHbMBmPP4TJrs4nhJFhxk8pXIjbvK6g0Q+yMhYadAOy6pupXDNoxblWBaV16Z1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrnnhEIf8H8rbllGXFk4f+yT9ETHPzX8OY0+QJ2xySw=;
 b=pflt6zAyEAnZesQ+Pqc0H4Fr5shCSBX788zmiLKAEtrBASOJuGyy5WsdmVO2Fz5II/at1fr9B9mzT4kqDdOcBjZob0xK3zG5Cp3oAbo+ILJYrUY5sZMuasEO0Y9fhgnRkmIbxP3w3ZOa+kbxKnkcywNcyYfAECGqDCuXwVa24WQvz9rINJEa0x2LBxKRHsBvzYBmC7pmLyr+KRBlYAfTbOmsP0a5xxKkX65EWZhbP7k/Ad519zDgKvfmQ9khhwWHbj3et9mA9Xn+letPnuqp9w+9Hl6sesguoTZRZ11zKkGUwByDMnipg8Txju2hmRiCSgbWvq60jAChvWv4/HDNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrnnhEIf8H8rbllGXFk4f+yT9ETHPzX8OY0+QJ2xySw=;
 b=vpdRChGSuZiUsDwuaT6ZeLTnkTQorUR6l1Jt/xgF/7/Fx3WpG5MiYilHE5i7QsteMgLmeDIDzJJ6JBatDOC2/1ZIkNtRM9vb8IqqyJOCs8VGlfafqYolvaK9MwWk4beJ43Kk7zP7gj9Fmo9MuF77rGz1mrf0tqMBG/aCTBiijRg=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by IA4PR10MB8657.namprd10.prod.outlook.com (2603:10b6:208:563::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Wed, 18 Jun
 2025 17:00:04 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 17:00:04 +0000
Message-ID: <3b68bdfa-d478-49c0-ab17-ab323f5d9e03@oracle.com>
Date: Wed, 18 Jun 2025 17:59:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/16] backends/igvm: Handle policy for SEV guests
To: qemu-devel@nongnu.org
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
 <0d01d74fdf37f13512b91f2b9cc349458b4cbab9.1749820158.git.roy.hopkins@randomman.co.uk>
Content-Language: en-GB
From: Liam Merwick <liam.merwick@oracle.com>
Cc: liam.merwick@oracle.com
In-Reply-To: <0d01d74fdf37f13512b91f2b9cc349458b4cbab9.1749820158.git.roy.hopkins@randomman.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|IA4PR10MB8657:EE_
X-MS-Office365-Filtering-Correlation-Id: c760ba22-0dc5-4f6b-dda4-08ddae8991f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RStUR3JaaDlYbVZiYmRvTWp6ejVST2s0QnFEOXFqQjdGR2x5MnVqOUZ1M0Qz?=
 =?utf-8?B?dmxjdStJaU1ReXVyMVJBNTVjNmNlTWJsNWhsZzdYRXAzTngwZkZmWllyZjNN?=
 =?utf-8?B?Sk1zbm5UQzlCUnRJd1kvMUZLUU9EYlBVeEVRNFF4bnNobnA1UEFtQ2VJTHRm?=
 =?utf-8?B?YnFhY3JiZ0dnMTRxVUJpMHpNN3dHa2drUjEyMWNJd0FVWlVqK2dvVlRKbE5O?=
 =?utf-8?B?NW0vOGZNckQ1bmtEbWkwQ1NOOHllU3dMQllqUDJKU3dJOSt1aVJhK2QxWUFY?=
 =?utf-8?B?WUQrdENjOWdHbSsycmUrWTZ0T1dkd0E4Q3FNM3FhaHlLbWNTZm8wd3Vqbm4w?=
 =?utf-8?B?RGJ6ZVlkK1F1TlA0KzBpUE9XTDQydThWMnhCamppWmJGSTRncGx1MHo1eS8r?=
 =?utf-8?B?QVRMdUlmT2VtQkp0b1UrOGsvaHNQTmU3NWswWlNMZ0JTWnhoamVLekliK2Fw?=
 =?utf-8?B?VFdEMXlFc3NwMjBFK2FlS0dHSzVVNFlReEdWcitDaXFmc0xzSDllenYvZlJ4?=
 =?utf-8?B?L3NWOEtpYVJ1Z25yNkFSd1NQRzVuek1iOEpaL0JUaE1hdzUvQ1p3S0FVU0xi?=
 =?utf-8?B?aE5Ub3FHWFZTVXJ2N2Z4anZvZ0FiWGhQZ053S1l0TjhoWFJqTDl2OU9XM2J4?=
 =?utf-8?B?bkNDRmw1a3FqdTNuRnE5ZG1OZGJ4L1pMeG83MnJLQzcwNTIyaXM2Qy9BVldY?=
 =?utf-8?B?WnBLTCtNNHJoRSttNHBaaEtyYWF0djUwVElsRC9jb0RVR0RFSVZhdmtvT0pQ?=
 =?utf-8?B?bHZISVVDV0VoMDVON1I2WjM0d2JDaWh2MlNzUFl5NDArNFFORE92ZFZQc24z?=
 =?utf-8?B?aXdnbHRvSkFCNkoxcVpTOUNUUmlDUkV6RUN3WStuRzNtNG5pWlh2R2ttem9I?=
 =?utf-8?B?SWhqb2RpcG85aWpDQUxXWkUzUDRQckYxVHMxendHVHFRNkVtdFBlMkZRS2Iz?=
 =?utf-8?B?MExoM2wzYjdKeTlQZ095U3ErWnhBTXRBbGZZaUgzVSs1d3lwL3k0RnVDaS9s?=
 =?utf-8?B?K0Y2Nm5NdlJUVlNRVUN2K1pIMitrTjFVR203d0dXdE9FSlRJNVp5Z2s1Q3Nv?=
 =?utf-8?B?OW41U2l1QUVNMG4wa0FaSTlzUGpnWTNGSS9QN2xlV1pFd2VpV3JocHM1TVcw?=
 =?utf-8?B?TGRrWlJEQnVIWXR3dmRrNXVPcEovQS80SXluakNZdnRUSDliVzlKcGZvRlNj?=
 =?utf-8?B?d2NwSzlzRU5GckExOGF6T0RxMjFLWmljZHE3bGhLRWxIRWYvYWJuNHZtQURw?=
 =?utf-8?B?aHpoSitZTEpITGNyb1FrQkdKL2RTZlIrd2hVWVBCb0NpcndWRFFGa1gyeWJt?=
 =?utf-8?B?d0lRZFdpYVIveDJXOGhaSk50VDZvaGwrc29YR0YreVlRdGkwWENhanY5U2pw?=
 =?utf-8?B?ZnY0Wm9qTFNoTjZ1QzVmenZZVlJuR0VDY2pYalg4MzJDZHdtclNxRnR2UVVZ?=
 =?utf-8?B?aUhJMFhEbThoYTVCNHFVOVcveVZsTWhwQzVzdHhsRTFjVGdvUk00S0FhNm9X?=
 =?utf-8?B?eDZGakdEUkJ5Y3VGRFFNL3VPUTljQjBteDZRRm1LRjVNa2c1NDVvdGVsb3kz?=
 =?utf-8?B?d1ErTFB5RTZqY2VDZE1GMTVZTHpmTXFMdkM4eTlEUzRud0VsOWw0YTFSMXIz?=
 =?utf-8?B?ZlJpbUw0RFdCY1FlenVQUUxabEg4ZjFZZEFBWU92MXVaNHlOT3ZQUHY2MGhj?=
 =?utf-8?B?NUFUc1poNThMeHdGblpKYkFEQk1TNHA5R0ZJSmxuZ29mUTRtRkpYNytYZG1X?=
 =?utf-8?B?Njg3RDBTTDhCaENlWjM5cDlQZnQwenNpTUcvajJHUndzZHRrcFcyTFlScEFj?=
 =?utf-8?B?Tk12OFZRYmJVUXNNM1NEVEh2UHB5ejV5dXlMUG1EZjJwN2Z3NXFvT3VmWDc1?=
 =?utf-8?B?RU8zK2dyOHZMTTh6NFFJYXVYemVqSWJ4Tm5hQ3F1SDVVMXM5ajRDaVRSbmgx?=
 =?utf-8?Q?KFcWzXBMG9s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5030.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDhHV1VwZVZ3cjdJb0wwMDZHZ05qMVJIWWZEaGpVcEEwcFEyT1lleXZ5dkU5?=
 =?utf-8?B?TUgxWVhGQzEraHZzSldYYVZEcFRMeDlxc055VE1JcmM3TWIxVGxxdkp5NWlH?=
 =?utf-8?B?Q0xnWUhhUGhmdzE4TklOTUFyYUJyTllWUmQvWUpscE5pcU04dExSY1BMN2NJ?=
 =?utf-8?B?Z04xOWJrd09FQ2VCZjJrRGgyMFUwcHlGOXl6Y3N3VXVBQVV3SlNrQTB5Y3hB?=
 =?utf-8?B?Q2ZjT0d0b1AweXdVUEVlZjh6YzY3ejYxZTRuWVZlSmVHRkZyR0RBRFpoOEtH?=
 =?utf-8?B?ektRa0hDbTdhUXhNQVV5Zy90STFnTlBLOHJTeHRRWEdJcGpCT3NKcjBTQWV3?=
 =?utf-8?B?Sy9nb1g0WnV6NHdNcXo4c014TTQ1V1luYzcwenZZNzNPbUFEb3pKNEc0Y0M2?=
 =?utf-8?B?WWZwaEhMVmZjOVlFYWhRVGFzaGxWSlpFcVM0c295OUF5TTlFK0thMWh6YVJ1?=
 =?utf-8?B?V21ZakFrNHJ2bSt2T2Y4N2p4ZWx5Z2dYRDBhSUtaWlpPWjdIM0t2R2VuUDJD?=
 =?utf-8?B?TXNIZmZlYjBNTWlzTHVIMyttZ2ZTT2xOalNkVTZma3N0TTF5aFFKWDMzWUg3?=
 =?utf-8?B?WUE4Vm12MzBtQzFsa2dzb2kyOXExcWVmK1NycGM2QWc2Nlh5cGJTZXo2S1JG?=
 =?utf-8?B?UWY0djE2c29YQ1R3NlFud1VUUlpmRUt1d1R0UWxxQzhVU3hHamZvZmxxcE5Z?=
 =?utf-8?B?OHRTaGNVaHltQ3pXRGFkZTZMaDRLL2E3cm50bTlrV0Jiak4zMmtMenV4RFhE?=
 =?utf-8?B?VUViMWdkN3YyYkRHMzhqYTZyNEtlRFQ2anZhOU54OWh3TElkODU3aVA4dUJy?=
 =?utf-8?B?RGNPeXBtODMxRlVVNGdha2V2em1sZDJhdWlaVnpDaFlNcEY5YTdEcnROdmlN?=
 =?utf-8?B?ODk3Mm1qd011ZE9JOExNUUxWc2ZlVXRhMVU2NlhvUXJUMmNBdDAxMWRzbTFo?=
 =?utf-8?B?MnlsL0RBZzlCRG5nVmU5ZFVlRDZLUzI2Skltc3FBVVQxTkRWUGlEM2liZmFG?=
 =?utf-8?B?NFEySm82UkV0QWdPdjVEendlQkRDMXpwQTllU2pHR0JFMWNORDJ2ajQveXdm?=
 =?utf-8?B?WEVPSS9Vam5LT2JQUnE5NWtpZHRjcWVJZy93Q3preEE5WlNaYjA5YWVkeFhX?=
 =?utf-8?B?TDRXYVJRa0p4MkZRRXFlZXY0b05WcW1COXBuVG5OdVlXcEVpUWxpK1YrM1oz?=
 =?utf-8?B?RGcyVFF2em1CeHRnTkN0SFFVZDN6aWZiQ3ZoMUs0ODl1TEo1dGMxb2ZxTG0y?=
 =?utf-8?B?cGkvTWdzNG9iZUN0UkRLN0ZYR0RLdERqYjIrbVZFeUJTS1FXazAvZlFteTBk?=
 =?utf-8?B?MjVjRXNRc0gwYXFJNEJDT3pCT0VSSWRHaWZUb0pGcmJHdzk5RnZkQ0FOSzQx?=
 =?utf-8?B?ZWZrejNpWC9jbHFFSXNuSWFlNUlTZEY1Q2JVZzQrN0xkdG8rb0Y4SVlFQU5H?=
 =?utf-8?B?RzRlVjlVRzA4QmJDUHlJNkZnaWdKNFdxRWRGaG5NWlpMdDZ5ZmRYbjhUeFpy?=
 =?utf-8?B?azFsbFpGMkRBNHhnNTMvaURPcVlISGZuY2tPR0VJVnZGeDJiY0dyR25TTEtR?=
 =?utf-8?B?bVJpOXBjdHBJT1JWZ01URzlUaDNJWjBYZnJHNjdLQW1QL0w0VDlnclRPa09n?=
 =?utf-8?B?SGIzSy81Qm9qbzMvU1BndUswbUZwUmZrWHB6ZHpmYWFodGRKd0FPSy83M1JJ?=
 =?utf-8?B?UkQxTjFaM1hGM3BPTzNXOFFqaHU4RWtNRXEzY0JjUWxOWFQzcWd3S0VjcjJ5?=
 =?utf-8?B?TlVObEdBTEZaa05neGhxbzNJNmhCVWNpc3d2c1IzZWw1MDFSeWt3N2hWUnh5?=
 =?utf-8?B?ZitwYnFkdFFBOVdsTlMzWmpObDNHeGJwcDZLN2pZZ3hVRVhsVWFDRVdTYTh1?=
 =?utf-8?B?MWUrUzNFZ0VmYVJDZFVqNkRyOHZZdnYwS1F2RmZxanNoOFNKdjJvSjFjMXhy?=
 =?utf-8?B?RUdzVEtQNkZNTTY2dFdOMFVkNmtLbWZDemx6QmEvQUJNTS9GSkdOeWpwS3BT?=
 =?utf-8?B?RDJjOVNlMVRZMUVCK21kcDhveVBXalh4Z0sxVWVRclQvVGQ5OEhyM2ozWkMx?=
 =?utf-8?B?VytaeUE0dEtXZFpHTi94Rld1aUZwbmtPa0NWd09YbE9GOFZiMEFaeXhtTmcy?=
 =?utf-8?B?a1paTmtXdGhYa01lWHlrellNUTNYSnVPNGJIMVNqRSt5c0QxcUNSellRQkxx?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3W372nta32ScrUe/JATYZnmL8KNGV4rlO2E8/ckWwVlt6o3csl9wBHKvSrnkcA0vZNXHEVO5yCjQE9ZSywXzJSw3i6bXiD+iYG5bMjNMW03H71Mg6ahdpg3jw4fxpBngkDhfCsWpkVBz7/eMF86up7E+qa/fQkdVTHJGKEKBsemQZqVShI9ylDQYSd6iY7x+OxVkh7IRNiNgxsFG/jmSSjhACaeL8RA2J23C18f/f+rMXwpSAu76ZmAwbr5tw7S9EJkpPAZRhXtmYNFlDsDnXbf2vp+Iqdq+0YYbRPDo/wshQWoz1ujXb7znXyoNQ8VES1blav4rJUPBnWSAXfkrgjwLculnOG7MQB1pR7RSN2zpPgG+ozEaZH0NYB7R6Y4PCQne+yRqqLBF7KirnfxDlufxSoqY14LyKDVrDs+Am42vuqNtjRj55jH7TNVoht9nmMM8ZPQjLxsJqp9O1gwFFwyh0oUPOe/hAk36SYlfFqfIifNzTi3zxk26n2DPP7NINgUxQnU3XZWq89zvE+C9CsdU6e0qXwt10kDsxHRJsIntUVXfzsvHjn/SA7xVn5EmrqLlxreB8m2PsC9E2xcSaNT/dycL/Rzvxj67+JETIfs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c760ba22-0dc5-4f6b-dda4-08ddae8991f4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 17:00:04.0699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRtLNiqtJuMLAyU1BqqxcEdOdbEcCkjfQds04/TgG3Tmce1ZWCz8rv8Qm/qqgVGx1d7Tj/G9CbQXNgs/zkDinw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180144
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE0NCBTYWx0ZWRfXwttJrkr4kRRE
 HvnQ+EhLbkmhteTf1q/vFXr5+z8fBWoo/I8BBQoT8gVXw65QYiG3KYokhKKfGM51Nemb2UlwBuR
 E7CLf0ku4nlufsDj0/ROGgMt89Ly4q7cNI2lgB3PoExVvmX0KyezOV9oBKkRhl2LdgwWHLnl22h
 puBSQCukZE/eMXsH52VUnXw/WxmbHdK0xs/THiiu39BbKErUFq1EC0LUPh00TeCpG7BNdTmJZW5
 RDDgOshOkCUnT4KL2tRAfBM5GbjdpfiuzuXSYoC08yFxGEuBM88/4RWQFKdqeB+zRXeMsDDmzBv
 DPtvhl5iw49ZFBOox2A0F0Kox26yk+R8xileimYCoI7C7Ods4DJeImWzqPrpJVlj7O3s7tKmtmd
 EfvTDajytrZA/x2GWopYDHXTp399I3RChvhMyU1LJ+/WWUojMaQiOBd10+5ijpCe8DiwI+kP
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=6852f099 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=P_Pm0ytiAAAA:8 a=20KFwNOVAAAA:8
 a=qJWPb5UcDmFz-42bLLsA:9 a=QEXdDO2ut3YA:10 a=EOqhNAZniKQb5jRoW5UC:22
X-Proofpoint-GUID: 6sHImG-X-sRibiCGQPG_Jk5Hqz2aYOxU
X-Proofpoint-ORIG-GUID: 6sHImG-X-sRibiCGQPG_Jk5Hqz2aYOxU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=liam.merwick@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 13/06/2025 16:22, Roy Hopkins wrote:
> Adds a handler for the guest policy initialization IGVM section and
> builds an SEV policy based on this information and the ID block
> directive if present. The policy is applied using by calling
> 'set_guest_policy()' on the ConfidentialGuestSupport object.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Gerd Hoffman <kraxel@redhat.com>
> ---
>   backends/igvm.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 138 insertions(+)
> 
> diff --git a/backends/igvm.c b/backends/igvm.c
> index ebdb4594d1..034f504716 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -27,6 +27,33 @@ typedef struct QIgvmParameterData {
>       uint32_t index;
>   } QIgvmParameterData;
>   
> +/*
> + * Some directives are specific to particular confidential computing platforms.
> + * Define required types for each of those platforms here.
> + */
> +
> +/* SEV/SEV-ES/SEV-SNP */


Could mention that the following are in Chapter 8 of
"SEV Secure Nested Paging Firmware ABI Specification"


> +struct QEMU_PACKED sev_id_block {
> +    uint8_t ld[48];
> +    uint8_t family_id[16];
> +    uint8_t image_id[16];
> +    uint32_t version;
> +    uint32_t guest_svn;
> +    uint64_t policy;
> +};
> +
> +struct QEMU_PACKED sev_id_authentication {
> +    uint32_t id_key_alg;
> +    uint32_t auth_key_algo;
> +    uint8_t reserved[56];
> +    uint8_t id_block_sig[512];
> +    uint8_t id_key[1028];
> +    uint8_t reserved2[60];
> +    uint8_t id_key_sig[512];
> +    uint8_t author_key[1028];
> +    uint8_t reserved3[892];
> +};
> +

In the next patch (#15), sev_snp_id_authentication is in target/i386/sev.h
Should they be all together? (and sev_snp_id_authentication seems
identical to sev_id_authentication - do we we need both structs?)

>   /*
>    * QIgvm contains the information required during processing
>    * of a single IGVM file.
> @@ -38,6 +65,17 @@ typedef struct QIgvm {
>       uint32_t compatibility_mask;
>       unsigned current_header_index;
>       QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
> +    IgvmPlatformType platform_type;
> +
> +    /*
> +     * SEV-SNP platforms can contain an ID block and authentication
> +     * that should be verified by the guest.
> +     */
> +    struct sev_id_block *id_block;
> +    struct sev_id_authentication *id_auth;
> +
> +    /* Define the guest policy for SEV guests */
> +    uint64_t sev_policy;
>   
>       /* These variables keep track of contiguous page regions */
>       IGVM_VHS_PAGE_DATA region_prev_page_data;
> @@ -67,6 +105,11 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
>   static int qigvm_directive_required_memory(QIgvm *ctx,
>                                              const uint8_t *header_data,
>                                              Error **errp);
> +static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
> +                                  Error **errp);
> +static int qigvm_initialization_guest_policy(QIgvm *ctx,
> +                                       const uint8_t *header_data,
> +                                       Error **errp);
>   
>   struct QIGVMHandler {
>       uint32_t type;
> @@ -91,6 +134,10 @@ static struct QIGVMHandler handlers[] = {
>         qigvm_directive_environment_info },
>       { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
>         qigvm_directive_required_memory },
> +    { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIVE,
> +      qigvm_directive_snp_id_block },
> +    { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
> +      qigvm_initialization_guest_policy },
>   };
>   
>   static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
> @@ -632,6 +679,70 @@ static int qigvm_directive_required_memory(QIgvm *ctx,
>       return 0;
>   }
>   
> +static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
> +                                  Error **errp)
> +{
> +    const IGVM_VHS_SNP_ID_BLOCK *igvm_id =
> +        (const IGVM_VHS_SNP_ID_BLOCK *)header_data;
> +
> +    if (!(igvm_id->compatibility_mask & ctx->compatibility_mask)) {
> +        return 0;
> +    }
> +
> +    if (ctx->id_block) {
> +        error_setg(errp, "IGVM: Multiple ID blocks encountered "
> +                            "in IGVM file.");

Error string should be on one line to make it easier to search/grep for.

> +        return -1;
> +    }
> +    ctx->id_block = g_new0(struct sev_id_block, 1);
> +    ctx->id_auth = g_new0(struct sev_id_authentication, 1);
> +
> +    memcpy(ctx->id_block->family_id, igvm_id->family_id,
> +            sizeof(ctx->id_block->family_id));
> +    memcpy(ctx->id_block->image_id, igvm_id->image_id,
> +            sizeof(ctx->id_block->image_id));
> +    ctx->id_block->guest_svn = igvm_id->guest_svn;
> +    ctx->id_block->version = 1;

Worth a #define for version?

> +    memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
> +
> +    ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
> +    memcpy(ctx->id_auth->id_block_sig, &igvm_id->id_key_signature,
> +            sizeof(igvm_id->id_key_signature));
> +

Should the sizeof be ctx->id_auth->id_block_sig (the dest) ?

> +    ctx->id_auth->auth_key_algo = igvm_id->author_key_algorithm;
> +    memcpy(ctx->id_auth->id_key_sig, &igvm_id->author_key_signature,
> +            sizeof(igvm_id->author_key_signature));
> +

Should the sizeof be ctx->id_auth->id_key_sig ?

> +    /*
> +     * SEV and IGVM public key structure population are slightly different.
> +     * See SEV Secure Nested Paging Firmware ABI Specification, Chapter 10.
> +     */
> +    *((uint32_t *)ctx->id_auth->id_key) = igvm_id->id_public_key.curve;
> +    memcpy(&ctx->id_auth->id_key[4], &igvm_id->id_public_key.qx, 72);
> +    memcpy(&ctx->id_auth->id_key[76], &igvm_id->id_public_key.qy, 72);
> +
> +    *((uint32_t *)ctx->id_auth->author_key) =
> +        igvm_id->author_public_key.curve;
> +    memcpy(&ctx->id_auth->author_key[4], &igvm_id->author_public_key.qx,
> +            72);
> +    memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
> +            72);
> +

For both memcpy calls, they could fit on one line and be more readable.

> +    return 0;
> +}
> +
> +static int qigvm_initialization_guest_policy(QIgvm *ctx,
> +                                       const uint8_t *header_data, Error **errp)
> +{
> +    const IGVM_VHS_GUEST_POLICY *guest =
> +        (const IGVM_VHS_GUEST_POLICY *)header_data;
> +
> +    if (guest->compatibility_mask & ctx->compatibility_mask) {
> +        ctx->sev_policy = guest->policy;
> +    }
> +    return 0;
> +}
> +
>   static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>   {
>       int32_t header_count;
> @@ -701,12 +812,16 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>       /* Choose the strongest supported isolation technology */
>       if (compatibility_mask_sev_snp != 0) {
>           ctx->compatibility_mask = compatibility_mask_sev_snp;
> +        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV_SNP;
>       } else if (compatibility_mask_sev_es != 0) {
>           ctx->compatibility_mask = compatibility_mask_sev_es;
> +        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV_ES;
>       } else if (compatibility_mask_sev != 0) {
>           ctx->compatibility_mask = compatibility_mask_sev;
> +        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV;
>       } else if (compatibility_mask != 0) {
>           ctx->compatibility_mask = compatibility_mask;
> +        ctx->platform_type = IGVM_PLATFORM_TYPE_NATIVE;
>       } else {
>           error_setg(
>               errp,
> @@ -716,6 +831,23 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>       return 0;
>   }
>   
> +static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
> +{
> +    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
> +        int id_block_len = 0;
> +        int id_auth_len = 0;
> +        if (ctx->id_block) {
> +            ctx->id_block->policy = ctx->sev_policy;
> +            id_block_len = sizeof(struct sev_id_block);
> +            id_auth_len = sizeof(struct sev_id_authentication);
> +        }
> +        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
> +                                          ctx->id_block, id_block_len,
> +                                          ctx->id_auth, id_auth_len, errp);
> +    }
> +    return 0;
> +}
> +
>   static IgvmHandle qigvm_file_init(char *filename, Error **errp)
>   {
>       IgvmHandle igvm;
> @@ -814,12 +946,18 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>        */
>       retval = qigvm_process_mem_page(&ctx, NULL, errp);
>   
> +    if (retval == 0) {
> +        retval = qigvm_handle_policy(&ctx, errp);
> +    }
> +
>   cleanup_parameters:
>       QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
>       {
>           g_free(parameter->data);
>           parameter->data = NULL;
>       }
> +    g_free(ctx.id_block);
> +    g_free(ctx.id_auth);
>   
>   cleanup:
>       igvm_free(ctx.file);


