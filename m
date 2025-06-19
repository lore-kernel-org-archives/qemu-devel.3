Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D86CC7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 15:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSHLc-0006sj-DR; Thu, 19 Jun 2025 11:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1uSHLb-0006sT-C2
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 11:38:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liam.merwick@oracle.com>)
 id 1uSHLY-0005od-1J
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 11:38:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JEMaOK002964;
 Thu, 19 Jun 2025 15:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=jWAG0XkdTgCkKp5DgHoKPoPEmnTeVOYtzV2+A+i+/P8=; b=
 b10Mw3FvL5/kSb1j6Xz6WOo0bUfzST5ecUG1T9BEqkRhMZpUpsIMdi4dRgSHaHX+
 p3SEuRC9LQ2PU7A7YyXqzJxCsElzWNimaCUXgEpzkWQxpv5rSpSrxykIFqNol8EZ
 CQgGIbOfPCAhY4EphYgBnx8jHwoWwWa6cxcE+tu8TtRxj1GtouKa5LMVhbzuuvWY
 4VspHofnrlMU1FuWzL5Esj/IURBdJihXtryK0skouSXmCPnJzMT0gE0ywTwzXK8j
 DlDf69mfXO2G43MILD6ltpzSYo8UJ9UYn3Buw9XjASrmi6WjHDGPbmIJf4PFuri5
 7QA5Bw5tZYZsB4/Q6pD74w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yda35v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 15:38:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55JFYeWt038493; Thu, 19 Jun 2025 15:38:21 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 478yhc167r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Jun 2025 15:38:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tg25qdCFjKmBDE+uHoxq8YhRWF0KNgQVdDzGAlpaxzeTxNVlfT5103jn/0NN0mV7TGOxezNelRh4mzfYR6GFkjTPAGSOGKRLbH80AO9buY/AncT4OuM3E5fsbi5qZaQMVJIyNdKVzme0mtPgCPON6zvCzhgemcQmDWRR3bJy89CheOSsBy+5M/7Iy4I00emlSxY3MnIEKAvCna0YF6AXkkJR2lfzqROjhtM4J2du230ITBjLZpCdPr9IAaaleD7PfuGpoaJzjFDlInN4E1LEAUCOMoAg063i15zJ0XkH5xaYgua/N3R7orfYAya2J9co8Bz9K/oOnK9oIc7rl1V2bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWAG0XkdTgCkKp5DgHoKPoPEmnTeVOYtzV2+A+i+/P8=;
 b=AWWJpaEyfcLA4LRjmZGE3kP8S81EOR4FPLLAUIWeFy7zUrxbRppBP5lKHuaQTPsZQHo9Kt0l4DP3XKwFoMl6uImOLRT56XOm2YEPLLjFUx2dVCp4qJFJCkl6vcDzdlQZJZ/o4aqtL/4aLwhvC1f8beqif/J1eml6d9kTMTotSDNInUgZgxOJxGQfegxITkHtigl7DeQqHtOky6/Cd6z0LJApch8xwbw/AB74NQdDTQGPmPxSVqFJSM4TRbVGPZ9EA28K1p45IZprFnydPdmCAWPsjpxF1kJtag7TG2r6rhkspKvPlaOoiIutj1D/+W5sA7YIluQbL6TG9x0R6QxfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWAG0XkdTgCkKp5DgHoKPoPEmnTeVOYtzV2+A+i+/P8=;
 b=BlH01HAug6GUeQQobdNfLvgh8jQUU9r5njSRVaXKQaMZ6m0MPoI5jWhdyVs2iXq6OWvIlECAHNtvRfZ3XJuWqPU9izp70Fkks1xR8jIruzP/oVxPKOdlMcWj6VKaGOyauogYAAS/OZiV6IGqLWhBlZkt0zFNV9dOsu9TCQxcZh4=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by CH3PR10MB7501.namprd10.prod.outlook.com (2603:10b6:610:15d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 15:38:18 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 15:38:18 +0000
Message-ID: <394194f3-4653-4625-b121-364bd22f8b87@oracle.com>
Date: Thu, 19 Jun 2025 16:38:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 16/16] sev: Provide sev_features flags from IGVM VMSA
 to KVM_SEV_INIT2
To: Roy Hopkins <roy.hopkins@randomman.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez
 <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffman <kraxel@redhat.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 Joerg Roedel <joro@8bytes.org>, liam.merwick@oracle.com
References: <cover.1749820158.git.roy.hopkins@randomman.co.uk>
 <dc9525b51a7e5872f96dac0468d2f7816b8c9c01.1749820158.git.roy.hopkins@randomman.co.uk>
Content-Language: en-GB
From: Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <dc9525b51a7e5872f96dac0468d2f7816b8c9c01.1749820158.git.roy.hopkins@randomman.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0053.namprd17.prod.outlook.com
 (2603:10b6:a03:167::30) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|CH3PR10MB7501:EE_
X-MS-Office365-Filtering-Correlation-Id: adcfac57-f664-4507-d176-08ddaf47501e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3FmMktuNXlHcU82cjlXUjIwZTI2N01RY24wLytZUXZiSVhQL29nenJCNHU2?=
 =?utf-8?B?VFVRRzVmWFZZSFAzK3B0cTJYQzFRSFZiazNMc2kzSzJuNXBhKzM1RTMxTEUv?=
 =?utf-8?B?SGlMMGVOR1BDRmg2dGJhZFFTNGJUdldCR0V6ODF5Mis2UmVHNzF1dk8rMjBG?=
 =?utf-8?B?NkdGbk9kelU3RzAwSVJjT3didE1nTDhwQ2NMYThOdHZrcVMxV0h0MnZ1L1Mx?=
 =?utf-8?B?YnhyWjF2TFkyZWNpaUV0dHhOS3FUd3N6T2h6V0RlelFpRDRYTWd4azVDbEp3?=
 =?utf-8?B?UXpWdFQvVHRhWllxWCsra0VORWFVMnYweTV4UUlxWTNxTGpQVlFicGxTS0s2?=
 =?utf-8?B?aFdaOWcweG1TSGVYaFkzWUExZGRISEw3WGJLbm9OQjdRa2cxd1BOLzFhTlFB?=
 =?utf-8?B?ejlCOXVDTjlMTHRTRWlVZzJvamhnODA1Q2w3Sk5La0hrSFl0U2lmOEdSaTVB?=
 =?utf-8?B?aGlEZzd2a21paFBNeCtOMDc3cHBoQWVuY0VJRTlsaVFqaXNadFhBZDBtSm80?=
 =?utf-8?B?Yk9FVWxkUEtJTytFSitoSXluVG5LRFdFQkszSytmWjUyUStyZjFnM0VkNTRp?=
 =?utf-8?B?L284SUM1cUFscFVuSVlqSnNmTkdnamF1N2N3QW9USGFKQ3ZZMi8zQ1RxcVZl?=
 =?utf-8?B?c0poY01oOHJCa1UwdnZEV0hjOXNXNXRrNDJRZ285SlZTRmxYZVFXS2RQVjY3?=
 =?utf-8?B?cStueUU3Q3VKZktxcFJvWVo2a2dPTmxpYS83djVtUkh4d1pPeFdIM2FNTGZr?=
 =?utf-8?B?TjNhaEZPbExyUy9IL21PbmswUjVIK3g4Z0diTEZtdFhTbytiR05CZUs0VjFw?=
 =?utf-8?B?aHJLdnIxUDByblFPMFowUGYwWm9mRXF1ZUNYYzArVmQrSGdtZHpEUWpUOEhV?=
 =?utf-8?B?eks1eElqU0NhbldWWDkvWk5WODZSTjFHR2V5YkFsZmZLSS93L1J3VzBvWUNp?=
 =?utf-8?B?M0o0UlVaN3NzeUlVSUJTU1NadThpelFxbUZMUnNlZ1ZoN2k5MmttajRCQ3BC?=
 =?utf-8?B?U0FpNXQzZVIrQ2pzRjBBQVVia1kwVFRYQ1g3U0x1ZjhoYnkzN0FTMmFia2Yz?=
 =?utf-8?B?dmVnTzVxTXF5ankrdUVvNlMxR1F5VTd5ZEZ6bGJuMnRmVFF0SVMrYTZPZ2Q0?=
 =?utf-8?B?U1NOdExBdkNlc1VtUER0Y0ZSNEVNWDBBY25IZDhmVEFraEw2Mm5SMSttUWdp?=
 =?utf-8?B?ODJQZUtxRm03bHczNkV2bGhlWGZvZ1NERTM3K3UwUjFXR2VDc25WRUNrL0pW?=
 =?utf-8?B?aVJmOU1yNksvdEJybnllUGlGUHdmV0libFByT3F2WlN3aEFiZnRlcHo4Z3hN?=
 =?utf-8?B?SVdPMCtZUW81N0Y5ZUJHUkFvZ2dBWFQvdkhOc0hmekFtZFI1YStTajVzVmRK?=
 =?utf-8?B?VlRVOHM4dEcxdTUwa0UyUmNSK0VIYXFONGY4UXZiQ2F2ZmpqdURnZEJHMWNC?=
 =?utf-8?B?QTV3cUFTMkVYTXNVRnVyNkIyZDlSZFQ1a2dOL0o2WlE3amk4Z1V3dEp6MGtW?=
 =?utf-8?B?aWR2Q2dORC9JMGZ0NFNvNVpkT3ArZEREZzJLTlYrYS9nODRTbm9HYXdhNW5t?=
 =?utf-8?B?MUtSRjZkSExhMnJQcHhmaTZJMlRBakRpNGNxVFNmRUd3SGZlTldLSyt5OFRG?=
 =?utf-8?B?L0szYTVZaU5JeDJNbEtSaTVMSG9jcTFsdmR1OG80NnlnNzQ5RUcwZUNESkxt?=
 =?utf-8?B?TGttSUsvM0Z3alliS1pIVzM2dGkxTmYxT3JYbEtxYmRTV09YOUVlV1FEYjJj?=
 =?utf-8?B?ZEFPeGpweE1jZ2pLRkJBcUlURC9Hb0RWLytDMXpEQTNsTURzb0tiU1lmazYw?=
 =?utf-8?B?cjVTZXRaUkVlcU5oS2RyVTFORFlnY3pMN2JiL0pBSitybDc1eDZhZWZMNmND?=
 =?utf-8?B?ZFdjZlJkUmtXNXdQL2tidGgyeUVoZ3NLVXpPT0dkZytuRUVCQjFidzArZEpj?=
 =?utf-8?Q?I9m8gbLzaxY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR10MB5030.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmZicDZUTmR4UFpadW9SdWNVbE1BUlNqV0pZaXhMbGFPRGk3am1sdStjS2V6?=
 =?utf-8?B?QzJtNjNnMXJVZWRsdVpMOS9yL2hxbWpTK0pudGVPbEk3UzNtZHl4cHo4T0l3?=
 =?utf-8?B?NmorYTVoK2dHbE5xa0VlQk9peG1NZlRVUmwxSms3SmpJL1ZTRDZpTHdYSXNk?=
 =?utf-8?B?TGczd3lrR1ZQUVFjcmJHUitESG0rZFVXVHA1VDdNclUrZmg3UXBaL2JSMDBG?=
 =?utf-8?B?K3Z3TG82YTFEYXU1WTMyc1ZBaytzd0habTkxeE96WHpwc3FNTnUvbm14WURh?=
 =?utf-8?B?ZEZyTUtIUDFvQUVxMWI3Vk1VTFNzVk02Mkw4ck5hTnZvSGF1K3RKamNOVC9H?=
 =?utf-8?B?K1R3VkdEMXBaaFJuN2tTWXN0UU5GeTRZUEFteU43Sk9CMW1SMVpndE1lK2JE?=
 =?utf-8?B?Zmo0RzBUVFkvSThGYUtlQWxwYklUQUxpK0N5VmxFbGkwN2NkWC9zbEtML21Z?=
 =?utf-8?B?RVBQV1NxUTRtdy90YW1yekV1QTRDOVBiVVA5UUFDbnpFMXdUM3NyMHJXZldE?=
 =?utf-8?B?UXFvV3VEME5UcW5BcklRM0RMeWpid3ZNS3hOZnNrRkpSU1RPdDc1OWlvb0da?=
 =?utf-8?B?VEdpRjM0LzZRMU9PY2d6T05zbmpvSE5RdHVjMEYzQ2JPdy9pZnRwSCt6VUIx?=
 =?utf-8?B?NTNSRCtHckh1ZlYxNzEvaEZqRnVlb0tjYlNhUU12Zks1WktON1FXd1VwclJG?=
 =?utf-8?B?RC8xQTFXL0RRV3RGa0hUZUQ4MkJ2clkrdi9XQVRsVnhPWnJ2dkN0MFJBSzlT?=
 =?utf-8?B?dGphWkJYNk91UUt5VW8xOE4rbGQxbURwcE9KTEVOSkcrc1Joak0vem1HTTRN?=
 =?utf-8?B?bU9kR1h2UUVhKzh5Q2lSaXh2SFRPZzVkWG5TNnh3K1M3bG1uMDdDNllzbXhH?=
 =?utf-8?B?dzVXMkE2cFhPelNFc3owREI2N3NiZ0FEUEhVNmlGMkcxN09PVzBrbUkzZFI5?=
 =?utf-8?B?U1hFVjVQRUJ3WmlLNDRzNVZ0OXFKRzE2QjU0aGFjZU5aend2aGVsckdCOC9X?=
 =?utf-8?B?eURCaGsvOU1SRnRRZVZIQk0zUFFVTlVJbDY2VzNtZFZ3cnIxN1laUENWTjJV?=
 =?utf-8?B?WkVCRktqcUpKVVhxS2FRNVFCd1hKcUE0OXF4bzR2RWtwL2xvT3JTZ2J2MnRy?=
 =?utf-8?B?OGVDRFlMeVQrU05tR041OHB0TGlGMDJTS1drVnZLY0ZNaEs2QlNleWtuNHlQ?=
 =?utf-8?B?V2l5SGRwNkV0NXppQ3lnblZIZm44YitrTVVKWVhxUmRyUmNPTFV5RGo2MFU2?=
 =?utf-8?B?ZlRpMzQ2bERYL05XcHZpYnN5bEVjNzBQRi9CSWNidlZ0MUYxUUpBUC9yS0xx?=
 =?utf-8?B?VjRsd3JrTEJraTBFNk9RTzI4ZkJ3U3hYckFZZVBRZXJtT3dobGQweHFIcDU5?=
 =?utf-8?B?dXdiR0dWSlFQMGVLMzhrRmJPbGxVSzczZGdGL0g0bEhWYmxhTHN0dk5YZVJR?=
 =?utf-8?B?d00zemRKQUNzL2F0L3ZEY3p0ZjNnUFhzeTU4dWFreHdPK2t4N2RLTERnNUNW?=
 =?utf-8?B?YVgzQ3VTRXIwNURkM1hHLzZCNS9IeTVHajR6cVFnTHArd2FNckZnR1NpVGhR?=
 =?utf-8?B?bHl6enlyT2xsK09ZR1lSS2lUY3BST09GQlFWc3NPOStaZ1JIVmZRbFFEdjkx?=
 =?utf-8?B?RElOUTJoKyttT0xsd3Q3WkVBU21KeGNkcWE0TFRUUkhHMnVQN3p1d3lVcENm?=
 =?utf-8?B?MC8vck8wYmRZOE50Ym8yL3JNOG1nTTdEYjhhdlFhRmZzMVB6enFaZWJQTW5K?=
 =?utf-8?B?VWt2Vmt6UVZJZmVsb01WUWIwQjF0TWNESHpuOFhNcWQ3c3VVRVYwV3dCN1lj?=
 =?utf-8?B?MzNkVEYyZWhBNDN4NHEwOGhpWVRYTjBFRGRGaHFUOXVVZFFHNS9jcVFjRCtk?=
 =?utf-8?B?Q0lWZVhGOW1iVHNhMWlQQVhyQkwwQjdGeTBvRU9yMDEvRFpWTGtiS3JXamRx?=
 =?utf-8?B?MWc1ZHhqYXpWQm1UYXZub1cxS3VZd3J2WXBxaFg3c0hzYVRxc3V3UU4wVHhU?=
 =?utf-8?B?ekEzdzNSeGx4RHRIYTVNSWVpekJobU85eGxHeVNtNmlFSTRPT0FHdXJHaWRP?=
 =?utf-8?B?ekQ3K0VPQmd6MVJMQWxPK3Q0bXplWURRRjZYK2ZhYzNya2dDTHgyOFFkd28w?=
 =?utf-8?B?MWs2c3NQWG90eVVxaEFnMGVyWGU5amhFVi95cUtHQlpuYmxTdzMwMXk0dkU1?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: x6GjZzAafxqTB0vGR6FVnZB5JXUMRvhpX92ONRvF5qct+SBUox5u0On0S3HRoFpc/kE71uPNbKFdev3pYDfs9K2EWD9fen+v1Hj5IwxoWbbJZnYf9sWqwfx8dAhp1oIzI1yr8YaOzyNgN+AZI9yhT1aDWWMCLNPMObyOJ+PfCxRGa96i4WdE6d9GL3wBNxJgGoIY9/a0Eh7gsEOed8BvPn3YKrO+cm4uJ/HxYYaDwj40nOBSYFFBP2VZL9ZZ3UYDpnjfrZiJQ2EXjB3mZFMlEoIW/jpcPx0q7eXoR15O4bZvx9rMPddcLzbIZHu8MbwzVUJoL0WhogzN09DBHKFSk4/SMJ4JmZIOyb0L1ULsO9pJn2fcErMKahkDt8lNrVKt3RmGquEun3mVnsUDmWi0ENENL5DYtRPC94RLV8kx5wZAu8nSVAGg7ysdwj0IWcv7Vn8CQLg6vitvAGAOTHDx0CAcF6Y7czKFvZvCOZRuYzJtyNThEFbwjOmhJmFKO6yGkVAs4NXHuO8reDWtSVT5RJFwK+3XpDmAwK+/BJTYTteCaUvCGwanTLzpLITTGqKao4TMoEA14sE3lMk0V26Nox5nTLeR1rn9uE9jofUyoKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcfac57-f664-4507-d176-08ddaf47501e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 15:38:18.1153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K04qXi+lsLjDUKy7BsF34nONcYHQUkbM/h6j5/7LpebaxZlnRK0j3kZ0mYV2RHo3phmASwX8icIZRGWXPvqKIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7501
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190129
X-Proofpoint-GUID: PW1WTG7WEBmSBlbXlSxvNSlNYbQSv39b
X-Proofpoint-ORIG-GUID: PW1WTG7WEBmSBlbXlSxvNSlNYbQSv39b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDEyOSBTYWx0ZWRfX04mtsO5S8bPy
 1/ptAigHKSaVD+4Nu/w4+ZydMds6zJB1LF5kDWb42/bM+Or5BFuuIG9AKflOFcw386t3kwMXQnC
 bZXJnKASnYHAykgvlrLDoJoTtcsaniIWl9bi+kVu2eyWOCM0OQ7oBGtu/WNHHdnIXa7Bfpd3h1M
 mY3YdRWqEhilDp/tJb8HB+LB4KFRUe6PAB0iidDbDqxeEA2PnOW2qZ7n0BhGyJc7bUmBNK7fOhx
 vRsD9R8rVg3DVSiewPaJHcnzuhiNB5SK3th3rh8gFZ/xJ2r99bbKgLpcOjoOb4jgJ+tD9RlxKRs
 czYTio3oaVvyvUNvNHc9gCeRfomU/mQKUCEoD63k/Qem69Pp6MJijlDq1Kv+3ym6Xvjk/mGNQyg
 nAtN9PHe2erBJE9KB1Emf8QeWUM5NZKVTXSPOw51jZp3evXlvVFZg0zakg7Du7/JsQAv98Vd
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=68542eef b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=P_Pm0ytiAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=WT2IO0CgYU9d-I_nRzgA:9 a=QEXdDO2ut3YA:10
 a=EOqhNAZniKQb5jRoW5UC:22 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=liam.merwick@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 13/06/2025 16:32, Roy Hopkins wrote:
> IGVM files can contain an initial VMSA that should be applied to each
> vcpu as part of the initial guest state. The sev_features flags are
> provided as part of the VMSA structure. However, KVM only allows
> sev_features to be set during initialization and not as the guest is
> being prepared for launch.
> 
> This patch queries KVM for the supported set of sev_features flags and
> processes the VP context entries in the IGVM file during kvm_init to
> determine any sev_features flags set in the IGVM file. These are then
> provided in the call to KVM_SEV_INIT2 to ensure the guest state
> matches that specified in the IGVM file.
> 
> The igvm process() function is modified to allow a partial processing
> of the file during initialization, with on the IGVM_VHT_VP_CONTEXT

s/with on/with only/

> fields being processed. This means the function is called twice,
> firstly to extract the sev_features then secondly to actually
> configure the guest.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> Acked-by: Gerd Hoffman <kraxel@redhat.com>
> Tested-by: Stefano Garzarella <sgarzare@redhat.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

> ---
>   backends/igvm.c           |  17 +++-
>   backends/igvm.h           |   2 +-
>   hw/i386/pc_piix.c         |   2 +-
>   hw/i386/pc_q35.c          |   2 +-
>   include/system/igvm-cfg.h |   5 +-
>   target/i386/sev.c         | 161 +++++++++++++++++++++++++++++++++-----
>   6 files changed, 163 insertions(+), 26 deletions(-)
> 
> diff --git a/backends/igvm.c b/backends/igvm.c
> index 034f504716..9853ba941e 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -869,7 +869,7 @@ static IgvmHandle qigvm_file_init(char *filename, Error **errp)
>   }
>   
>   int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
> -                       Error **errp)
> +                       bool onlyVpContext, Error **errp)
>   {
>       int32_t header_count;
>       QIgvmParameterData *parameter;
> @@ -913,11 +913,22 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>            ctx.current_header_index++) {
>           IgvmVariableHeaderType type = igvm_get_header_type(
>               ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
> -        if (qigvm_handler(&ctx, type, errp) < 0) {
> -            goto cleanup_parameters;
> +        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
> +            if (qigvm_handler(&ctx, type, errp) < 0) {
> +                goto cleanup_parameters;
> +            }
>           }
>       }
>   
> +    /*
> +     * If only processing the VP context then we don't need to process
> +     * any more of the file.
> +     */
> +    if (onlyVpContext) {
> +        retval = 0;
> +        goto cleanup_parameters;
> +    }
> +
>       header_count =
>           igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
>       if (header_count < 0) {
> diff --git a/backends/igvm.h b/backends/igvm.h
> index db02ea9165..a4abab043a 100644
> --- a/backends/igvm.h
> +++ b/backends/igvm.h
> @@ -17,6 +17,6 @@
>   #include "qapi/error.h"
>   
>   int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
> -                      Error **errp);
> +                      bool onlyVpContext, Error **errp);
>   
>   #endif
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 3184ea1b37..a3285fbc64 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -371,7 +371,7 @@ static void pc_init1(MachineState *machine, const char *pci_type)
>       /* Apply guest state from IGVM if supplied */
>       if (x86ms->igvm) {
>           if (IGVM_CFG_GET_CLASS(x86ms->igvm)
> -                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
> +                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
>               g_assert_not_reached();
>           }
>       }
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 6990e1c669..cf871cfdad 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -330,7 +330,7 @@ static void pc_q35_init(MachineState *machine)
>       /* Apply guest state from IGVM if supplied */
>       if (x86ms->igvm) {
>           if (IGVM_CFG_GET_CLASS(x86ms->igvm)
> -                ->process(x86ms->igvm, machine->cgs, &error_fatal) < 0) {
> +                ->process(x86ms->igvm, machine->cgs, false, &error_fatal) < 0) {
>               g_assert_not_reached();
>           }
>       }
> diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
> index 321b3196f0..944f23a814 100644
> --- a/include/system/igvm-cfg.h
> +++ b/include/system/igvm-cfg.h
> @@ -31,11 +31,14 @@ typedef struct IgvmCfgClass {
>       /*
>        * If an IGVM filename has been specified then process the IGVM file.
>        * Performs a no-op if no filename has been specified.
> +     * If onlyVpContext is true then only the IGVM_VHT_VP_CONTEXT entries
> +     * in the IGVM file will be processed, allowing information about the
> +     * CPU state to be determined before processing the entire file.
>        *
>        * Returns 0 for ok and -1 on error.
>        */
>       int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
> -                   Error **errp);
> +                   bool onlyVpContext, Error **errp);
>   
>   } IgvmCfgClass;
>   
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 2798fe1c38..df55a25a67 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -118,6 +118,8 @@ struct SevCommonState {
>       uint32_t cbitpos;
>       uint32_t reduced_phys_bits;
>       bool kernel_hashes;
> +    uint64_t sev_features;
> +    uint64_t supported_sev_features;
>   
>       /* runtime state */
>       uint8_t api_major;
> @@ -485,7 +487,40 @@ static void sev_apply_cpu_context(CPUState *cpu)
>       }
>   }
>   
> -static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
> +static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
> +                              Error **errp)
> +{
> +    /*
> +     * Ensure SEV_FEATURES is configured for correct SEV hardware and that
> +     * the requested features are supported. If SEV-SNP is enabled then
> +     * that feature must be enabled, otherwise it must be cleared.
> +     */
> +    if (sev_snp_enabled() && !(sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
> +        error_setg(
> +            errp,
> +            "%s: SEV_SNP is enabled but is not enabled in VMSA sev_features",
> +            __func__);
> +        return -1;
> +    } else if (!sev_snp_enabled() &&
> +               (sev_features & SVM_SEV_FEAT_SNP_ACTIVE)) {
> +        error_setg(
> +            errp,
> +            "%s: SEV_SNP is not enabled but is enabled in VMSA sev_features",
> +            __func__);
> +        return -1;
> +    }
> +    if (sev_features & ~sev_common->supported_sev_features) {
> +        error_setg(errp,
> +                   "%s: VMSA contains unsupported sev_features: %lX, "
> +                   "supported features: %lX",
> +                   __func__, sev_features, sev_common->supported_sev_features);
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static int check_vmsa_supported(SevCommonState *sev_common, hwaddr gpa,
> +                                const struct sev_es_save_area *vmsa,
>                                   Error **errp)
>   {
>       struct sev_es_save_area vmsa_check;
> @@ -551,24 +586,10 @@ static int check_vmsa_supported(hwaddr gpa, const struct sev_es_save_area *vmsa,
>       vmsa_check.x87_fcw = 0;
>       vmsa_check.mxcsr = 0;
>   
> -    if (sev_snp_enabled()) {
> -        if (vmsa_check.sev_features != SVM_SEV_FEAT_SNP_ACTIVE) {
> -            error_setg(errp,
> -                       "%s: sev_features in the VMSA contains an unsupported "
> -                       "value. For SEV-SNP, sev_features must be set to %x.",
> -                       __func__, SVM_SEV_FEAT_SNP_ACTIVE);
> -            return -1;
> -        }
> -        vmsa_check.sev_features = 0;
> -    } else {
> -        if (vmsa_check.sev_features != 0) {
> -            error_setg(errp,
> -                       "%s: sev_features in the VMSA contains an unsupported "
> -                       "value. For SEV-ES and SEV, sev_features must be "
> -                       "set to 0.", __func__);
> -            return -1;
> -        }
> +    if (check_sev_features(sev_common, vmsa_check.sev_features, errp) < 0) {
> +        return -1;
>       }
> +    vmsa_check.sev_features = 0;
>   
>       if (!buffer_is_zero(&vmsa_check, sizeof(vmsa_check))) {
>           error_setg(errp,
> @@ -1722,6 +1743,39 @@ static int sev_snp_kvm_type(X86ConfidentialGuest *cg)
>       return KVM_X86_SNP_VM;
>   }
>   
> +static int sev_init_supported_features(ConfidentialGuestSupport *cgs,
> +                                       SevCommonState *sev_common, Error **errp)
> +{
> +    X86ConfidentialGuestClass *x86_klass =
> +                               X86_CONFIDENTIAL_GUEST_GET_CLASS(cgs);
> +    /*
> +     * Older kernels do not support query or setting of sev_features. In this
> +     * case the set of supported features must be zero to match the settings
> +     * in the kernel.
> +     */
> +    if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) ==
> +        KVM_X86_DEFAULT_VM) {
> +        sev_common->supported_sev_features = 0;
> +        return 0;
> +    }
> +
> +    /* Query KVM for the supported set of sev_features */
> +    struct kvm_device_attr attr = {
> +        .group = KVM_X86_GRP_SEV,
> +        .attr = KVM_X86_SEV_VMSA_FEATURES,
> +        .addr = (unsigned long)&sev_common->supported_sev_features,
> +    };
> +    if (kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr) < 0) {
> +        error_setg(errp, "%s: failed to query supported sev_features",
> +                   __func__);
> +        return -1;
> +    }
> +    if (sev_snp_enabled()) {
> +        sev_common->supported_sev_features |= SVM_SEV_FEAT_SNP_ACTIVE;
> +    }
> +    return 0;
> +}
> +
>   static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>   {
>       char *devname;
> @@ -1802,6 +1856,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>           }
>       }
>   
> +    if (sev_init_supported_features(cgs, sev_common, errp) < 0) {
> +        return -1;
> +    }
> +
>       trace_kvm_sev_init();
>       switch (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common))) {
>       case KVM_X86_DEFAULT_VM:
> @@ -1813,6 +1871,40 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>       case KVM_X86_SEV_ES_VM:
>       case KVM_X86_SNP_VM: {
>           struct kvm_sev_init args = { 0 };
> +        MachineState *machine = MACHINE(qdev_get_machine());
> +        X86MachineState *x86machine = X86_MACHINE(qdev_get_machine());
> +
> +        /*
> +         * If configuration is provided via an IGVM file then the IGVM file
> +         * might contain configuration of the initial vcpu context. For SEV
> +         * the vcpu context includes the sev_features which should be applied
> +         * to the vcpu.
> +         *
> +         * KVM does not synchronize sev_features from CPU state. Instead it
> +         * requires sev_features to be provided as part of this initialization
> +         * call which is subsequently automatically applied to the VMSA of
> +         * each vcpu.
> +         *
> +         * The IGVM file is normally processed after initialization. Therefore
> +         * we need to pre-process it here to extract sev_features in order to
> +         * provide it to KVM_SEV_INIT2. Each cgs_* function that is called by
> +         * the IGVM processor detects this pre-process by observing the state
> +         * as SEV_STATE_UNINIT.
> +         */
> +        if (x86machine->igvm) {
> +            if (IGVM_CFG_GET_CLASS(x86machine->igvm)
> +                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
> +                -1) {
> +                return -1;
> +            }
> +            /*
> +             * KVM maintains a bitmask of allowed sev_features. This does not
> +             * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
> +             * itself. Therefore we need to clear this flag.
> +             */
> +            args.vmsa_features = sev_common->sev_features &
> +                                 ~SVM_SEV_FEAT_SNP_ACTIVE;
> +        }
>   
>           ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
>           break;
> @@ -2417,6 +2509,24 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>       SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
>       SevCommonStateClass *klass = SEV_COMMON_GET_CLASS(sev_common);
>   
> +    if (sev_common->state == SEV_STATE_UNINIT) {
> +        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
> +        if ((cpu_index == 0) && (memory_type == CGS_PAGE_TYPE_VMSA)) {
> +            const struct sev_es_save_area *sa =
> +                (const struct sev_es_save_area *)ptr;
> +            if (len < sizeof(*sa)) {
> +                error_setg(errp, "%s: invalid VMSA length encountered",
> +                           __func__);
> +                return -1;
> +            }
> +            if (check_sev_features(sev_common, sa->sev_features, errp) < 0) {
> +                return -1;
> +            }
> +            sev_common->sev_features = sa->sev_features;
> +        }
> +        return 0;
> +    }
> +
>       if (!sev_enabled()) {
>           error_setg(errp, "%s: attempt to configure guest memory, but SEV "
>                        "is not enabled", __func__);
> @@ -2436,7 +2546,8 @@ static int cgs_set_guest_state(hwaddr gpa, uint8_t *ptr, uint64_t len,
>                          __func__);
>               return -1;
>           }
> -        if (check_vmsa_supported(gpa, (const struct sev_es_save_area *)ptr,
> +        if (check_vmsa_supported(sev_common, gpa,
> +                                 (const struct sev_es_save_area *)ptr,
>                                    errp) < 0) {
>               return -1;
>           }
> @@ -2493,6 +2604,12 @@ static int cgs_get_mem_map_entry(int index,
>       struct e820_entry *table;
>       int num_entries;
>   
> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    if (sev_common->state == SEV_STATE_UNINIT) {
> +        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
> +        return 1;
> +    }
> +
>       num_entries = e820_get_table(&table);
>       if ((index < 0) || (index >= num_entries)) {
>           return 1;
> @@ -2524,6 +2641,12 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>                                   uint32_t policy_data1_size, void *policy_data2,
>                                   uint32_t policy_data2_size, Error **errp)
>   {
> +    SevCommonState *sev_common = SEV_COMMON(MACHINE(qdev_get_machine())->cgs);
> +    if (sev_common->state == SEV_STATE_UNINIT) {
> +        /* Pre-processing of IGVM file called from sev_common_kvm_init() */
> +        return 0;
> +    }
> +
>       if (policy_type != GUEST_POLICY_SEV) {
>           error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
>           __func__, policy_type);


