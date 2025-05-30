Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593B0C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 21:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL7JE-0003kX-4A; Fri, 30 May 2025 17:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uL7JA-0003kA-Rd
 for qemu-devel@nongnu.org; Fri, 30 May 2025 17:30:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uL7J8-00034A-Eu
 for qemu-devel@nongnu.org; Fri, 30 May 2025 17:30:32 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UJNb6o028623;
 Fri, 30 May 2025 21:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ID47/4ZgpODtsSN3kVSJydslIPKBWh0lepFS+4iZ4wQ=; b=
 Jf57f4E/EnVXkL1eFq3Pr9I87AILLVixSuCW8ogQPqTW8r0x8kSISFC+b+qaxKDn
 jJ1qpgMtP3l4405Nf5CNEQKgw4Jyq8+D2LpDwEYoXWlQ1Gcyihc/r3Hc0mS3E7rw
 /Sf6jpTmFTB6wptEhuz8eonLpEkZNrHMaSuJDD5oXYtRt3pE07mq5kq/2JqivrP2
 CkrtegPNSQsr0E2OqcwlQebpBtuVrZEfjpbDBh1/QZOXTc6CVt4sh2pyPath4HaF
 ryGVKXtVl98s/hMvDybVMKKlvUSx7HGNB27mxOL8ztJxYIx5sO19zE/dUtGc28Fc
 1tvUQV9G4llm6aOJYCHi6Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u35ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 May 2025 21:30:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54UKLFK6026660; Fri, 30 May 2025 21:30:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jdsfax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 May 2025 21:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZvBOHgPebxQvllEwMb26+AeQ6xiVfP2BN7yTghWMsntlE5CidsbUyPq27O0Hazmlmn9VY0dXHUGWowG2ZAoBi6T9eeNNCiT6TT5kmrxM1b0Fojx0tcHf9dULhsuETB6qU5oANM1aNp/hy6ET/aUAQYjpapUQ+y2go1oGJ+cR6XPsTlpaCYdOEnq5FNQPfVdROmOJYyx6Xm3pAGDOX/TWDzPBkshSBzezB2geW1Gvb/W8PpfWgm8Dj1UaGGUYY2RV4bTIyR0R01tmKrw2CjWNEVs79Agz6MxwFrTakvLEl+arC05xxeVciZLxN3HGsP3bB7EbqmqB739WRVIpRu5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID47/4ZgpODtsSN3kVSJydslIPKBWh0lepFS+4iZ4wQ=;
 b=ecyotqkeooo7LpcArE841BBFfH6lfgafMlYsDTGkS9tSe8O8GQPWFHCO1HtK1T6xS36An9vSNfIL9cbAkzHvUUOSGZzrf5r2BQ3SkpZeG8iXLcYjOEZO7Dy8tE7tLW9JkrB7qCxxh6TeVF+pmONCyClADCe6jdeDOZS8zjUX1QPGtcIusQ24cl0NKjkAgFxrWdpi0wS1mN2DmhV9qieYEm0nHMdEcwPhJr7SSc6VgqCYvmRe+PeWxjhiIZlmkDq7bQ5QM/3Ul+xV66qlWMSDC7bvPgHmH2kTLkLqccISZTNa+mDBWYKp+ymPtbIYtyiy+hz2oaRXWSaHN/IgQrbgeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID47/4ZgpODtsSN3kVSJydslIPKBWh0lepFS+4iZ4wQ=;
 b=zoQ20SleuQSq8I8EErmmdZNAYAk4/ghGVaiX3LAapOd7unZ75Zw9/XmyvOXZC0RJUR21IIze1Oz4Xx/QS2VWn8BhQUqYMVwatgq2A47L24/fqTmPD6TH/ZyWQGBdgra6rDKVVYcT81yl8lEUM67RDtGnVQDSHS8qVJolKR3e79Y=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 CY8PR10MB7169.namprd10.prod.outlook.com (2603:10b6:930:70::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8746.34; Fri, 30 May 2025 21:30:15 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8746.035; Fri, 30 May 2025
 21:30:14 +0000
Message-ID: <18ca629c-0ac5-4a0f-a88f-92a3afa328ab@oracle.com>
Date: Fri, 30 May 2025 17:30:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/20] amd_iommu: Set all address spaces to default
 translation mode on reset
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com,
 clement.mathieu--drif@eviden.com, ethan.milon@eviden.com,
 joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-17-alejandro.j.jimenez@oracle.com>
 <6cfb9c54-d7ac-4e4d-9370-b62175f861bc@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <6cfb9c54-d7ac-4e4d-9370-b62175f861bc@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0066.namprd15.prod.outlook.com
 (2603:10b6:208:237::35) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|CY8PR10MB7169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bbf71d0-e999-4aff-627d-08dd9fc12a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0Y0cG12NlU0c0ZMZFFnZVd5M0lRWkQwYVEyRGJYRXNYR2tHRzZwbjE5UmNz?=
 =?utf-8?B?VzBCdUwrTDFSbkFXUmh1WVg2WXEzcEFjcndzMTY3dTI3bm4rWFA4azJQdTlp?=
 =?utf-8?B?TFNURHg5NDdNQVZVWityMno3YWRKbkRNMmpZTk9kWmxaY2JjeVkvaGhKQmx3?=
 =?utf-8?B?V1ZKblI1V2FlaFlVYXdyTXdqUUdEdjNUK0ljQk5NL0ozL3lzRHA0dUkya1BO?=
 =?utf-8?B?MHVGTzZsejZoWFBUNXVRVHdWbVFqMURkZnYzY1E4M3E4Yll1TmxUMHFLcUZG?=
 =?utf-8?B?WFk1QVFTdlRBUEZ6NjFDUGg2MXk5ZWpxeFhIQUdndFN3ZWppRU1PTnVCZ0wx?=
 =?utf-8?B?T3Z2Nms5TER2a3FmOG9Bb0VKMlptVFhDTk5VajV4RG9MRldYNUMvclRFK1JV?=
 =?utf-8?B?RG1sZ2tBVlQ3d2s3S0RxVDNhWk9BellQSVFpMzZtZEpCTjQ1UmhFOGxTL0Q1?=
 =?utf-8?B?TndUWWJLSVBrdVdrbXcyMi9jVWNtdldUMWxTNzBoZHh1SlRBOUtaakJRWnBr?=
 =?utf-8?B?bGxkaFBhbjVEVTc3UWV6VHQvTE5WRTRVaUsxcXljTWlYTDhMbGx1dUNJNHJn?=
 =?utf-8?B?Vm1qR3IySFNodzhaRkl2bERyQTc5MDNNTHlIelhaWUluUjJYcDVQblhQM2s0?=
 =?utf-8?B?UVpNbjVOdnVNWnFhZDROcjFRMHp4cjlZN1RNSFRlbEYwWTdmUXBUMEVmYnRC?=
 =?utf-8?B?WWtCZm9YWFUzNnlYNFdMT1hSZU5WWU1pbDkzZzdBUkc4ci9YcFdtc1UzRk9F?=
 =?utf-8?B?d0tISkRKRklDV21HeGduQ0lUb0NWVTRMMFpLZmFWOUpnWGJLaUQzcTBXYlJu?=
 =?utf-8?B?cXhiNmVLOVF5RWUzQXAxRERUWXhXZWYySVdvVmZrdnlGTGtTTG9uZVpRbkpJ?=
 =?utf-8?B?VURMWEhERUVCZW1xM0E3Ymphc1hGU3hzVmNwV3I4bHYxZGJPMXpYZ0d0VnR0?=
 =?utf-8?B?dWFUVlFuS2xzRmFzMGhFcnNWb1RlSURjQVNGamJNVlpNZWt0WU9IeWdEYjA4?=
 =?utf-8?B?eWpUc2l4dGc4Z2RpZmZuS1RXTDQrMzlWYnVYUWl6Q1M2N1AzcEFCdSs0d1hC?=
 =?utf-8?B?SlF5WGd3RVlMTHN6ZWFTUzZaNkd2OFVOUTlmb0p0M3h4SklaWmJEUWNhY3ps?=
 =?utf-8?B?azN2d0RydGhRR2Z1a1YvTUV6SU5YSEloWkhiQ3MwYTVWL3pwZEZUQ2tlUDVL?=
 =?utf-8?B?VmxKVm8wazM3dTYwd3VCOWtKQVRGNjUvdWlHODB6aC9zU3Fyd3lpY0t3U2hT?=
 =?utf-8?B?aUhXMUxjbm5naURpaU9CWWdCbXRUa0psOS9uVXRQYVdNYjlnb0sydHU3NXpk?=
 =?utf-8?B?WGVweklzVElLa1UzNnFJNUdiZG5mQk1IZzUram9IMXJXd3ltRXFPRkJEUmdG?=
 =?utf-8?B?VjhNbnJiTGNkQis2RDFmRXA3aE9SamhZRlNvS1JhZkNkdGxwSlpQNmVjMHFt?=
 =?utf-8?B?aVp0THN1SGFHNi8zMDhFY3RkRHhDVUVFZ3ZoSjhqTFd2bHZVdlBkS2NPc29Z?=
 =?utf-8?B?dVZOeUMwQWxvN2EzaENkenFsNmMvVkw1YnIyQWhkQ0hkRUgxR2l0QU1Rditm?=
 =?utf-8?B?eXdJdUNIZEo2MVpuM3pUaTNqUC9xelpmUXVtVVorV0dML3ZaTGZqUGJNcEtO?=
 =?utf-8?B?Q2tZTk5XN1hmUVVHMWdOUStxZXBqYW9aYVc4bWlOY1JUSHF5VGJMMWRyQzFi?=
 =?utf-8?B?M0tWT0hYVWVwNml2RytjWm91cDErTHpycW5xaGxpNjFJMnB2dE1pcHFsN2FX?=
 =?utf-8?B?U2QxYUozUm5kV05TWkwxbWpwcDkvUUY1R1pSa0U3VnpQWUxiQVo4UkFzcnlE?=
 =?utf-8?B?bGh3bTQ4Q0NVeTRxNnZaRU5FaUN5OGMrR0pBcktTdCt4YXpONHdHMnZtYVN3?=
 =?utf-8?B?TDkwWmhldnBaR1pGQUJnWHNabG9lb2l3OE53VFlkb3JPUWdNVmZTdVJSempT?=
 =?utf-8?Q?PP686Fzov4k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTVuNkM2enNFeEo4SjFaQlNFOHlKUzAwZTJnRU04dndCZWNPK21qcjJmamJw?=
 =?utf-8?B?cS9xaTZ1NnR2V1dEYVRKL2hsUkFKZ0hBOVF4c2llV04reWx3WTdtaEJLRERl?=
 =?utf-8?B?U3QzVGxKUkw1K3NvOTlUT0NubGVHTGVIbnM5WjcyaFlpb1JzTWMwRzVodFZ2?=
 =?utf-8?B?MTZGM0dGbjZ5RUgvcGE1eVVaT0ZtU1dWRUZwSFpLdjJhYVlwSjgwa1piZHo5?=
 =?utf-8?B?aDdhMmNPSXE4RkQ1NXlFNXVHOWE1Tm4rTkNzTURPbUloSittcTV5OGtmdnhV?=
 =?utf-8?B?N1JqV1BUSUZhY2E0RFBacHU3RWM5QlI4YjdoaUhhY3BmSTFObG9VOFFrL21J?=
 =?utf-8?B?QTR4dHBLc1Q0MS9TRlRrZ21lY1hzb3ZxSk5RV2gxVWZ2ZjA1UEtmeHIxc0RV?=
 =?utf-8?B?cnRyWXZBSmI0SUF4WDJWUVpHS2pUc0FJMDJwY01ZUFB3dzA0RmsvczRlOEFx?=
 =?utf-8?B?TGlCSUNhMkFuTzA5ZTlRMGV0NHIxand6WnNIdDl6cTFXUG1BcjhKZkVaWFVq?=
 =?utf-8?B?QTFPMDRWbVp0c20rUlpZNlRnUGNEaklZcDhsSkl1MXBGWmY4RFBvTzluZVhE?=
 =?utf-8?B?QU9WNitKaElPRGNSZXk2YXArdGd4R3RteFlZbzdvME5qY20rNVlYNkVTbFhN?=
 =?utf-8?B?NnMvY2Y4UmxEcjcvWHV6blh2YUJUOEhiUERrOXc2M1hXV3BaTTVpSnBYL2Rw?=
 =?utf-8?B?ajBTdmdHby9rMkNDZm9nOFJockY1bGliM0QyUTFvR2xvYzVORTlUbGhUQjRZ?=
 =?utf-8?B?VSswcjFZYnowcEF5Y3NWUUVqL1JjSUJlRVFmdUNkL2hzRzcvVUE2MmVzNEVE?=
 =?utf-8?B?NFZKZk5tUGJROHFSbVlqTzlhdDdHeC9vRVZNR3g2UVZENk1KMGRRZXBkT3N5?=
 =?utf-8?B?cEd1cm9wTFdRNUhld3lmOTBWeXRwMy9WK3hZUzdtai9PTkNkVXFFMDhqendQ?=
 =?utf-8?B?RSs4V1JqUkdmNU1XM3JCZlJkUklGNWJZd1JQcHR3dDU0emhyb2QwTjBkdWl0?=
 =?utf-8?B?dWpyN0pmbG44dHVQZDVwVTZpa3cvR3pWSEtGa2pNZDN2MHFpVlpFcDdzNHE4?=
 =?utf-8?B?VlRuMm1NTVMzTXlnbmpXQ2FxdW1rSEcyemdVc2F1blF3YnhpNWlzRkhDNG1X?=
 =?utf-8?B?Q3R0dzd6M2JzQllqWE1lZUVrdG5PckQ2SjNEaXpaZlB1ME9MZVlQUTdMNS96?=
 =?utf-8?B?ZG5zYVpRMDVvSkh4RlZmckIrdStINC9ybVBBVXRtdFgxL1IweTZKNjIzejdH?=
 =?utf-8?B?dGxxNGg3Y1lDTEYxMFhwWW1jRVIvbnF2MFhmdms1SW15WnNXaWhYSTU3bGdi?=
 =?utf-8?B?U0pQSzEvMDE4T2xFQUo3UGY1ZjhiUW9VUVZ4NW0yZWpTbWx1Um1HbjNWOFg2?=
 =?utf-8?B?MDlTR3libmgrdTAxTXpsTmdWK1piK0VTK3RoZDJ2MDdjL1RHMDlHTThRaU5R?=
 =?utf-8?B?T1MyM1QrbXZhV2tHNVV1b3UwaWw1VC9SaEZMZlk5UXVxVm1CTmVYK1AzTnJ2?=
 =?utf-8?B?UGVrS2ZWTmRNOEtIcVFENU5PZjRsOEFDMm5SMkdjY01adG55Vit6TWs1dmQr?=
 =?utf-8?B?Y01BcW02eXU1b1M3b3pGNE9XbnFHaENVVWZNVzNHRktZQzJIbDFZeDdtaSsz?=
 =?utf-8?B?SFIyd0hvOWpEc0liaG9DMG1YSityby9zOFBCODYzSDRNMXIxcnJuNEVQZU9O?=
 =?utf-8?B?NUFMNVp5SHlncXVMbXowakJqL1prelRJaWUxbXFjSGpGT1B4aEtpOTljS01w?=
 =?utf-8?B?UE1DQ213WjR5eXR0TlFia3JuNXoxNG9DMmx4RlBnNFBjL1J1Ui9RNlZFR3hD?=
 =?utf-8?B?QWdKWE5ENEo1SEtwUTJHajUxVS94eFJTUTF6S05LTFA5bndab08rT1V0OVNO?=
 =?utf-8?B?YU9aNXZyVVRJSE00TnEvRzNPRE1GQ2tQUk9YeWpLTVBIekJkR0FoOHREc3Z4?=
 =?utf-8?B?TFc1dnhUNDEzeFc5aFkrRGxqZi9pRG1NQitBRlpyLzlqc0N1V3JNUWVjcER4?=
 =?utf-8?B?Z2cyWHFvRTVRRTJyYU9ndjROVElxMSt1R0Z4S05iS1pIRVZpNnNEdTVJYUY3?=
 =?utf-8?B?NkY5Rk5Uc0l1SU9zWEM5c2Y3clIzMzlkRDNmNk9HdThxd1hicXFSMVNwOW5L?=
 =?utf-8?B?NVkxdWI3VGpRY1M0c1NvQzU5RGlXVzlsN0pOZFFCY1duNWFCWU5jUXVVL2VM?=
 =?utf-8?B?Nnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eLEPK6AiXWxOh5sx6yrTIvnVDUeykXE7J8oqTXH0TwC8wErInnS6oIHq/zjS0RCTyyCjHEM5kPTmXcENNH+RhZGRv9GFAFFOxvgUAOmI+TxiKUV7wnCtLjDG682wq80jzbCFT0kCkcFbmjCMcBFtzEbZCRaBBZ1BcvFfcbpVAs0V0OAjfr6V44PZ6re3Um5rpvyddnkfVOsrQ+HhdmWZTSbKOrIiVChMJauOcvu85kb5QGosS1yc7zb5DOoq+JixQLt6JZe3MJeczuRBA4DbfS3lWopLi3WSyxmCmUfeKoQp2qcFHtmvy92TpVBYuFt8R8Zrj8Djkz0ZesGK6mCCMe9CoQ5x0KbGn7y9M9WS6wo4mugyCtDDh9ENy/Asrpz96e5SYFn5mM5NTuIw5ZItDZpWpkyPqGpVY6AWgvAtwcIv7YWlAcI6ejnV/eVUr1Q3I22xrssci+QQ2AWCm+9Z3ENxOdZ0em9F6MGacJg2GGmvvNj8wKBsnPAMZ4O70tl7j6IUhs2YlNpzWlLoxQjBFdCnF5rAd4oSk+BJ6Zorb/iWTkSVzV3hDBqZZ0SLpP4WSI70WAPgxEMbQl7nph0P+dYZUsaxivNSnvVy7XTeRas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bbf71d0-e999-4aff-627d-08dd9fc12a2d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 21:30:14.4005 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBkiw6FgtxpJO7iclnKFU39/OE0AGI8FBydFN5CyEaI76FU62w/vsEocCA4pupGs1iwNDaH6YFhb6bQSCR9l80uSP0P8bsLadjefAUgHdk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_09,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300193
X-Proofpoint-GUID: VWz0QYJsD7xzuWyeuJgj5CA6W1cw3zqH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE5MyBTYWx0ZWRfX+gk/ltqcoRo0
 CWRsO41qjZ4ZywAbCRw0KlP2npD/cRb/dN4Pe1Nt9U5YjzyvFgLWyuy07xOnqWRUztlZW/F0BEu
 FrA9V1pBSFsS1ThDT5IKumtaR+tFsMib+27fkfJqdKQyF7M8tIZDpZ58wys1msA7Ny0dqxnALTT
 T3ABkbeDsR4/LF3UgpeQGWBJqDZIDq+x4Frv+7DV/S2qd3yVRg5zOS/skzGCLcFJWWh/QopHBOL
 oUjCfL47pcZIfOg+9tpCoWzy7qAAkx9nsxyx/R9/WuP1KYeSbuCXOhCgYN4G2qbyG7DoXgDwg5/
 rJQioViXyDe3vTsNCirjqPwxGGs6KkHS0PFc/X4SUet7loDGhZPOrMg1EdbW6JMZPtYpA4Cii5a
 xaSZljjT9hrEiL22NTaPkVVaqowcgBNETdC0lBtp2CaFixPucb2OnZRcYY2b4eCdxY89+B/4
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=683a236b b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=2TkQfrFMcPEt5mKLfT0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VWz0QYJsD7xzuWyeuJgj5CA6W1cw3zqH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Hey Sairaj,

On 5/29/25 2:16 AM, Sairaj Kodilkar wrote:
> 
> 
> On 5/2/2025 7:46 AM, Alejandro Jimenez wrote:
>> On reset, restore the default address translation mode for all the
>> address spaces managed by the vIOMMU.
>>
>> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
>> ---
>>   hw/i386/amd_iommu.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 71018d70dd10..90491367594b 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -962,6 +962,33 @@ static void 
>> amdvi_switch_address_space(AMDVIAddressSpace *amdvi_as)
>>       }
>>   }
>> +/*
>> + * For all existing address spaces managed by the IOMMU, enable/ 
>> disable the
>> + * corresponding memory regions depending on the address translation 
>> mode
>> + * as determined by the global and individual address space settings.
>> + */
>> +static void amdvi_switch_address_space_all(AMDVIState *s)
>> +{
>> +    AMDVIAddressSpace **iommu_as;
>> +
>> +    for (int bus_num = 0; bus_num < PCI_BUS_MAX; bus_num++) {
>> +
>> +        /* Nothing to do if there are no devices on the current bus */
>> +        if (!s->address_spaces[bus_num]) {
>> +            continue;
>> +        }
>> +        iommu_as = s->address_spaces[bus_num];
>> +
>> +        for (int devfn = 0; devfn < PCI_DEVFN_MAX; devfn++) {
>> +
>> +            if (!iommu_as[devfn]) {
>> +                continue;
>> +            }
>> +            amdvi_switch_address_space(iommu_as[devfn]);
>> +        }
>> +    }
>> +}
>> +
>>   /* log error without aborting since linux seems to be using reserved 
>> bits */
>>   static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
>>   {
>> @@ -2199,6 +2226,7 @@ static void amdvi_sysbus_reset(DeviceState *dev)
>>       /* Discard all mappings on device reset */
>>       amdvi_address_space_unmap_all(s);
>> +    amdvi_switch_address_space_all(s);
> 
> Hi Alejandro
> 
> I think amdvi_sysbus_reset should set iommu_as->addr_translation flag to
> "false" before switching all the address spaces. Without this, the
> devices will keep using IOMMU address space.
> 
My first impulse is to agree with you, from the standpoint of 
considering the no_dma mode as the "default mode", and a reset should 
bring us back to default. But I wonder that is necessarily the 
architectural behavior...

After a reset, in order for any device transactions to be processed, a 
guest driver must reinitialize the IOMMU data structures, including the 
Device Table and specifically the table entry for the device. That must 
trigger a INVAL_DEVTAB_ENTRY that will be intercepted and 
as->addr_translation will be set correctly. If the guest driver doesn't 
do these operations, then a device won't be able to use the IOMMU 
because it doesn't have a valid DTE, right? The earlier mappings were 
already dropped, so it doesn't affect the host.

Again, I see your point, and making this change is likely the right 
thing to do, which is why I'll make the change for v3. Just wondering if 
implementing such behavior is actually architecturally accurate or just 
the "common sense" approach...

Thank you for your attention to detail and all the valuable feedback. I 
will be out next week, and will send v3 once I am back online.

Alejandro

> Regards
> Sairaj Kodilkar
>>   }
>>   static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
> 


