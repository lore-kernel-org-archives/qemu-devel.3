Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63167C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVaD-0008B7-Uj; Fri, 24 May 2024 10:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sAVa9-0008AG-HJ
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:07:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sAVa7-0006lD-3H
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:07:41 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44O8wsP3006160; Fri, 24 May 2024 14:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=V2pofW50QUSeDtN0vmas+8cKeLgln+ec7WpC86qApmk=;
 b=XeS6wz844yp9eq8EzXIo6LdVBC45vzz0n4+V6YP9NORamhlSCYDVersT9OuqmMMN8ZFD
 +D2aDZr2Y5fj9sJ3VcrFZRq6RKXDn8n4tCO5/fB/Nbeom5/y6d+eyTE2Ee6TDk3anUrF
 PSOB/4EiEIHPXtaaXbVWK1IXOVcmqVxevZi1OZFQA+nKIvdb2EQTh+4+Z9GehAqFk+jB
 40MmI2fBy7n8ndtAdhWyUsZU/FYpHUxvBJlpsMvgj5G502AsJbi3WpR/rii4rIkovWel
 UWglwuIoKzCDdoQtdMvGH7FEwfh2yJ/RZFrmKcOXfFAGIVlFCsiNPuPKouj7H8h0iSXz qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jreveg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 14:07:29 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44OE1rQL037808; Fri, 24 May 2024 14:07:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3y6jshy76j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 May 2024 14:07:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVaJB9MPUhcGaEi6qsCF+mtveXtg4DmQ8yrvKIlL78iKuLgG11GGeqVKqPJQh1WvpAITe69c4uimsR3AzaQCHsmieAr9RiFpIYC4D/A2M5sC451aeTvnkhuz1DyZHcMWL5J5vphBrPd8HveGFIMkJAEpATTKXt05gAAE4b1vniunpdAmr1lqWMDRBW6VzDCQsVZyVqyFs6+CkZIm8487iN4HIJIcol/ec2G3MO6Ggcq6EZAYDKEuj2IaXw4rANm3vYbojZGoJyxe6/YpNGaoJQx5SUbAu4MINfeocE3Zd2uT7HVPYLO96lRA+KZ1KhJt6+Nps25TntS3VjmHgKBzAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2pofW50QUSeDtN0vmas+8cKeLgln+ec7WpC86qApmk=;
 b=IMvTxL+8p4eKyZJXwtJHhxdquoCHfRC0mcXB5x6BStZVconJNmRMt6s4SvGDjAqqERY/4dGcS/iExySQW8pWmpHLK1o0DeoI8XN3bmTpttewzDEiidOg8pywDomY+Nbn1NU7U/FNw2ML4DxSaiHlG2fnrV+BLyDVYnZ4gEISvg1AxTQZtHHbZzYxv5y5DEoBtufIBnaBWtHhYN7GN1TUbBM+a5Tpe5+gSyS+ewIt2BaeDxuxzDzUaFmKPTuTjOM26QARYmnNtfT618fHs4B6aegmGFWY8aYVxURmeJI8I/LcDnrIVM5tM0h/NSndIdNKg/PJIlaAFiR0dav2xojzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2pofW50QUSeDtN0vmas+8cKeLgln+ec7WpC86qApmk=;
 b=WIi9QgOqkyjLnLZjaP1N866jxOvjWDzUJjk847WYCVtlO+s+jEEAFPLN1IjXaztOsKwqPIj6A7RVXl6UZhq3EZLdz15gdm/0CSp/CNXI7by8jBa221vl4M0CKNLpgttyu608dz0nFhQLQw9lsBSiUJVpE69NeN5zxL91g49G2EU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN7PR10MB6954.namprd10.prod.outlook.com (2603:10b6:806:34f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 14:07:24 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%5]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 14:07:24 +0000
Message-ID: <e81e73f1-48d2-4ec3-a663-40704571d177@oracle.com>
Date: Fri, 24 May 2024 10:07:18 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 00/26] Live update: cpr-exec
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <87le3zgy7r.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87le3zgy7r.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0150.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::35) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN7PR10MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e29a1c-f89b-4507-ee86-08dc7bfad5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OUZaS3lMMTdQTm8wZXBJbWtFRDBrRkkzUjlJdGwrYXVqRk8za0dSWk5mbWZv?=
 =?utf-8?B?WUltdXZ4UXFhSXJVVE10TWJQMDlERTBqdDFweHBiOCtQK0c0VDA0VW41K0RF?=
 =?utf-8?B?NXBBbmsvN3UyVXJ3aGVXVzZTT0FPenZydHk2TWZ6N3c2NU8yTXRvOEFGUWll?=
 =?utf-8?B?RlJLTHRZck52ciszZVVSMjA5ZWhQeC9HRW4zSHRRSTBTem80WmNGOEJSdjdW?=
 =?utf-8?B?SGZrQ051L0U4QkFGUHhjR3phajNPOHM5ZjM0R25BMnZQVXYwcHhKSGd3aTFB?=
 =?utf-8?B?WFpLU0xXQUllbkIvaWFmbGhONVZQbE9pS2ZMOTVCNTBzd2R2WG9lNDdENHpJ?=
 =?utf-8?B?OGpmdko4UUJFQUdMK0NSYUZPQkRIZ3h0T0pSdDB1RW5jY3hlb2JpbkZsdk5Y?=
 =?utf-8?B?VWFNWlM0YVl2Ym93YTlPeFFsb24yVGQvRTNwTHEzNXNVMnBGaDRwd2dLeEhI?=
 =?utf-8?B?U0NoYkZjdUhVK2F3WnlUcG5aUVYweVZyMEFRMTNqWlNhbldUS2JNVnJaSkVn?=
 =?utf-8?B?L0RVSGwvWWlZejQ2Mzg5ODBjeGtnTTlrSFFSZklOTHlVMzJ5ZkFlNC9MUzBj?=
 =?utf-8?B?YmZqb3VPY3pPSlZmZHc2YU1McjdYeHIvd0c1aktaRXlVN2UzYk1NRmw5OEZj?=
 =?utf-8?B?SFBEYnhFZEFlREZvMFVJZXhXdVpad1FoQnQ0T2lZNVE2bWxRNktJMFlLdU9W?=
 =?utf-8?B?SFI2a28zRE94Vlk2TE9adDZWWmxKdm1lV2lPcmYyTEFsVzJRUFQ0REZFOWIw?=
 =?utf-8?B?MlduZG1qeU8xampmaVNFYTZWZjYzVFg3aldvdUZnNHo2MEZxMEJjTHlsYnF2?=
 =?utf-8?B?cFpnbkVRYlBjemhpckF5ZGpQazlIbUxqdDVZcmtLakcrS2NEaEVuL2UwbUQ0?=
 =?utf-8?B?d2ZWdmgvZ1kwWjhiNU03eUNhd09qckpCeWJXQm1zdDlXeUNzVmxabGVYd0F3?=
 =?utf-8?B?QTVBTnljQ0tRdEZmdUtRQ1hRUnI4eTE2TTUvVmpSN2p3MDR1S0tLcFFzbjIr?=
 =?utf-8?B?WnkweEpaQW00NG9ScEEwUGp1TjhObHFyaWlwSFJXN2dGTnlhSVVIMlR5anhH?=
 =?utf-8?B?bzV6YmtSWENkWkE3RU9nQnBvalFaKzgyeFhNcjRnTisxUmlLMm1GOEZXdUpt?=
 =?utf-8?B?VU1HWGJYWisvbVhXZERsVDVmMk04WnQ1bGhidENUQjFjUnFXd05sakZ1eVVj?=
 =?utf-8?B?Zk9yUmpFeUwzRE5ZUk9KK0xRbkNEMkI1YWU4Y2RUNnljRnhub1lBdkNDUnBq?=
 =?utf-8?B?TW43WGUyQ0NzK0RUREt0Tno3T0hvcXA1cExSYVdOcUxwOVI4YlNVMFVqM2Zz?=
 =?utf-8?B?WHZLTGRZbXFDNHA5U2RzVGwvSjJ1YkRSZndHVEVDTjhBWDJvcmcwSGJsSDBL?=
 =?utf-8?B?NmVTbDRQaDFLMWdQbkZYNFlEdS81aGZUUkVBWjlubUNBdlNxQVRIZEx3SWhz?=
 =?utf-8?B?aVU5T25lbnBWYnplbXZaRHdQR3NXbFBLaENCN2U0Tm5HaFlLdkYzdzVHem16?=
 =?utf-8?B?TlNlb2J5alY3Mk1Wb0RZWXZHbkFQTHkrQU5LS1Y5bFErT3ViOXZtZ1RvNmtD?=
 =?utf-8?B?bmZMZTdrQ2FjeUhRZXp0Q0JTQlhVOXdyanc3dGFLL3dySEg4TUxaQzhMdlcx?=
 =?utf-8?Q?4WY8XZ5jGG/5YcD9oZM+hzP26icHEMS9dMjEYpGu+D5M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(7416005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjNlNGEwcnJYeGJ4TTdEaXFjRzg3bUVmeW9XZyt2U2tHZi8xS0FRcHJRWU0r?=
 =?utf-8?B?azlGSklFRzlJTHAvajIrVkJZaEVFd1l2Mmc2bXRWYWswNXRRL0ljL09FQW4w?=
 =?utf-8?B?RXFkME1ON1BzalBPUmJCNWFMdGsvaDlibUFTb2NRWkdwbWMrSjltdENXeXJI?=
 =?utf-8?B?K21jeWR6N3Z1cU84RUlxYXAvSEYyTTJOUE1RM1lrR1V2N2N4UlZ4dnVNdmVL?=
 =?utf-8?B?NkVQWUNZUzhyYkFCYklHMHA0dVNNVGdhc0F2djVhZUcwZHBvMFRnR1BxNStl?=
 =?utf-8?B?RTZEOUdLdXpKa3hrbSszWmE2TStUdHRac2VHL3RYOHFYTHVNOU5wZ3dPeGZI?=
 =?utf-8?B?amZmd05OZFZkTjZYWDFiQktXU1hkOFZLTlRyZnhVU1p2WDhtZEFvdHk4QS9m?=
 =?utf-8?B?bXFMbHVWckxjK1MzQnZsZ2ZPY3dzRTlST0pWUysyZWExUHBRdDFLVWJjSWg5?=
 =?utf-8?B?TjhISXNaN1VUeEwvRHFuMmowV0xOcUpGazFIeWdBaU9ISVZaeEl1SGlES0RW?=
 =?utf-8?B?UDZzVVpmYnhMNGRnaXA5RGpxNEJZRVBOODljT21wbkhEV0JOd1lBZ0J5cVBq?=
 =?utf-8?B?KzM1alJZWGZpcVhIWDc1VTFPU1lBMkw4VmE2emdva1NGdWRTUXBRTGVZaFBs?=
 =?utf-8?B?LzdUMkRUeUZYNDJ6ZmxObmlIN0lIS3ZrUjE1aUM5WEJDRjRoWGYwNHVoSTFy?=
 =?utf-8?B?R0VVMTV2NlVBZWRIQ3FzSEprVDRjVWJEeDlYeVQ2K3JpVWN1RWxwU2pzaHBu?=
 =?utf-8?B?RHNQc2RSWlo4UmxGVk9FNXNRVlRORUVBNUxGbjRPRWlVblVVUnR6bTB4UTlE?=
 =?utf-8?B?Y3ErNWtWNmRwRndHVG13VEpEMGxCa3pCVmlyZFE0SWxORG5YNzk4NWQ1bU1q?=
 =?utf-8?B?TkREUEhJbmtjcXI2c0NnU01MaUduK0pZblZWZGFBNkVVeC9haGE4a2JJUWl6?=
 =?utf-8?B?RW9OblhvaFFtT1NFSmNIK1ZJdi8rTDMybGRNM1llY0RMR3FxK0IwY1U5UWgz?=
 =?utf-8?B?cWZoMmUwZDJ1SjJWaUdETDVwcVRJMTY5ZUplY2VqU1VDWlNsQnBVcjZIMXVx?=
 =?utf-8?B?ckJ1Qi91aHFjNG5sbGFacEVyK0dBTUJycFg3OHNiSkJpZ24wZUlvdHRkVW1E?=
 =?utf-8?B?dHRDa2MzZ0NPd0RIUmlJb01qMFVjbnJsalF3Q1FWbVpJVUFzZUxNZjdQd2pH?=
 =?utf-8?B?eG5GdHM4QXFybVFCL3RxZHhpMXMzUFBUeXZNaG9acUlHbm83NkQyeGxpSlNl?=
 =?utf-8?B?OGVNQ0dNeWtUa0VPZkVWTlp3MHNSa1FFQ2VqZkEzTklrZ3J6dGlDVXFFalgx?=
 =?utf-8?B?dDFmS2E4TXNGcmFpSHJKcGFtOUUrYWF5Yll5RG1pV0hXRTZmeG9EdSs0WWF4?=
 =?utf-8?B?bXQ4S1YzUStqOFhBaDNJNFdIYTVYZ2NDb1E2aEpZeGczSHpRclVCSWkwMm45?=
 =?utf-8?B?TGFjVUV2V0o0SEYvT3VQb1o0S0ZhVDdVQ215K2RnR0dUdk5LMytxUUFwR1ky?=
 =?utf-8?B?TzhzNkNDRVM5aWJJNklBYUtJVU4rVy9HVnk0Zmh6STNPa0l6cHcwOE54VXFw?=
 =?utf-8?B?WFhYbmpYd3h0VmYzZ0IrSnlwZE9LeWVPSS94RGowdzNnYjY1RXJJRzE1S0x2?=
 =?utf-8?B?YStNYUVpSHEzTWJLV3YvdXVJeE12RzFmSHphNGltZkd4c3owOEluYVZyVm9K?=
 =?utf-8?B?MWJmVVdkd2ljcTZxWUh4Y1NZdVBsYldZcGJXNm52UmFmTzNVbGQ1cVNhNkh1?=
 =?utf-8?B?bHQ4TFN5MGNmNnBBVmllWXpxZFhZcERCVER5N0tyRkdmb0Z6ZHhldzBnaDhP?=
 =?utf-8?B?VGNSRnJycEtadVpjQ3o5NVRmQjlBMC9ycGtGMU9BTGcrb0M1N0NsVFgrOTU4?=
 =?utf-8?B?V0xYWkVOTkJGMjZMajRJTmNxYnNyN05RbmJ1MXZId1VLTDFRSE5Mbmp5STA1?=
 =?utf-8?B?ditkVDBlOCtxamFKV0lGanNpSmJhYkNaZFBWOGJwZWFSeDdFendXVTdselJ6?=
 =?utf-8?B?S1pTVlAxWkxXWXdOM2FIQ0FFdG1NVEsvTUt4OTlFd3BFc3BCZjZ4eDBTSmFH?=
 =?utf-8?B?Ulpkc2RONVVQUFNybkZ0cVMxUU03cFVCRHRFZiszMVg4REpsN3ZPRDAwbEd5?=
 =?utf-8?B?V1JzckRQVWhtSG1OR2dtUTVFeWNkc05Jd0VEOE9pU2VkVjkzdTd5UGRXTVFX?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yEKaAdV2Zm/n/OiB3M3iaA5M/402b1vvPYuq/k4cB3fmjfFwBD41f+7tVbgiYg29CCnA6GYxZAM1XFpuyS7j9+JNZ1qKBVvPzxwlHFQazp+F1vc4i+/nZvt69koEYj3gIxLsWs9fH9rU0KiTFQ+cwyfJwXbR5bNz+jGRujDrEFlOIA26XKPEmpcNWZI0q5OXawbPFbOZ6WE0yOZIx9nK7cvmyh/2bEPoRCDlv69Z2Ai2Na9SfHonlakKbcorUIK/6nFiH3mxQuG6/FAxlj63t4vN0qsnkVM0YyNuSv7t7EdbIe/ryESH8Y0OFOttXeofet6SlzWO91CyxLzRpYdQccJqCHNrQep0pFxdlbRpbsknX8NK8UU7rejEzsk8YRq+tsX/MC7TBP0BhdMOi9kdaQIpS7DfgbcOe7jALKJ2eMupBG8fqK7wyiGaI6l+DTfPj3tSYyfD+qhd7yBmB7tA3mzKIK2mFXRm1k2citd3ASAPD4BG5KM4Hvcivpth9vQ/nyiCQILlJDqcyIvTnMtzn8EUsI0dpbGqtnDrcRNrIxq4lEJPgA+ZEo7gT/Ht2123mDXfXWDdZX1wLOFujyoRA8G8ILFPxlJO1bHwAq9yIZk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e29a1c-f89b-4507-ee86-08dc7bfad5c8
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 14:07:23.9864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkhOybWBDsXVIovgNOKjBBKdg5Q0UlWZF5f/TTi/IJw12bqNRaX+aSy5S7/SVwjrwCO+GKSP07hUEdWu+C4xPHWros5cIb+7pe0QcjicDQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6954
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240097
X-Proofpoint-GUID: GPZ-Tr13zxMyE0h-j0VgMldAVcYW6Rth
X-Proofpoint-ORIG-GUID: GPZ-Tr13zxMyE0h-j0VgMldAVcYW6Rth
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

On 5/24/2024 9:02 AM, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> This patch series adds the live migration cpr-exec mode.  In this mode, QEMU
>> stops the VM, writes VM state to the migration URI, and directly exec's a
>> new version of QEMU on the same host, replacing the original process while
>> retaining its PID.  Guest RAM is preserved in place, albeit with new virtual
>> addresses.  The user completes the migration by specifying the -incoming
>> option, and by issuing the migrate-incoming command if necessary.  This
>> saves and restores VM state, with minimal guest pause time, so that QEMU may
>> be updated to a new version in between.
>>
>> The new interfaces are:
>>    * cpr-exec (MigMode migration parameter)
>>    * cpr-exec-args (migration parameter)
>>    * memfd-alloc=on (command-line option for -machine)
>>    * only-migratable-modes (command-line argument)
>>
>> The caller sets the mode parameter before invoking the migrate command.
>>
>> Arguments for the new QEMU process are taken from the cpr-exec-args parameter.
>> The first argument should be the path of a new QEMU binary, or a prefix
>> command that exec's the new QEMU binary, and the arguments should include
>> the -incoming option.
>>
>> Memory backend objects must have the share=on attribute, and must be mmap'able
>> in the new QEMU process.  For example, memory-backend-file is acceptable,
>> but memory-backend-ram is not.
>>
>> QEMU must be started with the '-machine memfd-alloc=on' option.  This causes
>> implicit RAM blocks (those not explicitly described by a memory-backend
>> object) to be allocated by mmap'ing a memfd.  Examples include VGA, ROM,
>> and even guest RAM when it is specified without without reference to a
>> memory-backend object.   The memfds are kept open across exec, their values
>> are saved in vmstate which is retrieved after exec, and they are re-mmap'd.
>>
>> The '-only-migratable-modes cpr-exec' option guarantees that the
>> configuration supports cpr-exec.  QEMU will exit at start time if not.
>>
>> Example:
>>
>> In this example, we simply restart the same version of QEMU, but in
>> a real scenario one would set a new QEMU binary path in cpr-exec-args.
>>
>>    # qemu-kvm -monitor stdio -object
>>    memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>>    -m 4G -machine memfd-alloc=on ...
>>
>>    QEMU 9.1.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>    (qemu) migrate_set_parameter mode cpr-exec
>>    (qemu) migrate_set_parameter cpr-exec-args qemu-kvm ... -incoming file:vm.state
>>    (qemu) migrate -d file:vm.state
>>    (qemu) QEMU 9.1.50 monitor - type 'help' for more information
>>    (qemu) info status
>>    VM status: running
>>
>> cpr-exec mode preserves attributes of outgoing devices that must be known
>> before the device is created on the incoming side, such as the memfd descriptor
>> number, but currently the migration stream is read after all devices are
>> created.  To solve this problem, I add two VMStateDescription options:
>> precreate and factory.  precreate objects are saved to their own migration
>> stream, distinct from the main stream, and are read early by incoming QEMU,
>> before devices are created.  Factory objects are allocated on demand, without
>> relying on a pre-registered object's opaque address, which is necessary
>> because the devices to which the state will apply have not been created yet
>> and hence have not registered an opaque address to receive the state.
>>
>> This patch series implements a minimal version of cpr-exec.  Future series
>> will add support for:
>>    * vfio
>>    * chardev's without loss of connectivity
>>    * vhost
>>    * fine-grained seccomp controls
>>    * hostmem-memfd
>>    * cpr-exec migration test
>>
>>
>> Steve Sistare (26):
>>    oslib: qemu_clear_cloexec
>>    vl: helper to request re-exec
>>    migration: SAVEVM_FOREACH
>>    migration: delete unused parameter mis
>>    migration: precreate vmstate
>>    migration: precreate vmstate for exec
>>    migration: VMStateId
>>    migration: vmstate_info_void_ptr
>>    migration: vmstate_register_named
>>    migration: vmstate_unregister_named
>>    migration: vmstate_register at init time
>>    migration: vmstate factory object
>>    physmem: ram_block_create
>>    physmem: hoist guest_memfd creation
>>    physmem: hoist host memory allocation
>>    physmem: set ram block idstr earlier
>>    machine: memfd-alloc option
>>    migration: cpr-exec-args parameter
>>    physmem: preserve ram blocks for cpr
>>    migration: cpr-exec mode
>>    migration: migrate_add_blocker_mode
>>    migration: ram block cpr-exec blockers
>>    migration: misc cpr-exec blockers
>>    seccomp: cpr-exec blocker
>>    migration: fix mismatched GPAs during cpr-exec
>>    migration: only-migratable-modes
>>
>>   accel/xen/xen-all.c            |   5 +
>>   backends/hostmem-epc.c         |  12 +-
>>   hmp-commands.hx                |   2 +-
>>   hw/core/machine.c              |  22 +++
>>   hw/core/qdev.c                 |   1 +
>>   hw/intc/apic_common.c          |   2 +-
>>   hw/vfio/migration.c            |   3 +-
>>   include/exec/cpu-common.h      |   3 +-
>>   include/exec/memory.h          |  15 ++
>>   include/exec/ramblock.h        |  10 +-
>>   include/hw/boards.h            |   1 +
>>   include/migration/blocker.h    |   7 +
>>   include/migration/cpr.h        |  14 ++
>>   include/migration/misc.h       |  11 ++
>>   include/migration/vmstate.h    | 133 +++++++++++++++-
>>   include/qemu/osdep.h           |   9 ++
>>   include/sysemu/runstate.h      |   3 +
>>   include/sysemu/seccomp.h       |   1 +
>>   include/sysemu/sysemu.h        |   1 -
>>   migration/cpr.c                | 131 ++++++++++++++++
>>   migration/meson.build          |   3 +
>>   migration/migration-hmp-cmds.c |  50 +++++-
>>   migration/migration.c          |  48 +++++-
>>   migration/migration.h          |   5 +-
>>   migration/options.c            |  13 ++
>>   migration/precreate.c          | 139 +++++++++++++++++
>>   migration/ram.c                |  16 +-
>>   migration/savevm.c             | 306 +++++++++++++++++++++++++++++-------
>>   migration/savevm.h             |   3 +
>>   migration/trace-events         |   7 +
>>   migration/vmstate-factory.c    |  78 ++++++++++
>>   migration/vmstate-types.c      |  24 +++
>>   migration/vmstate.c            |   3 +-
>>   qapi/migration.json            |  48 +++++-
>>   qemu-options.hx                |  22 ++-
>>   replay/replay.c                |   6 +
>>   stubs/migr-blocker.c           |   5 +
>>   stubs/vmstate.c                |  13 ++
>>   system/globals.c               |   1 -
>>   system/memory.c                |  19 ++-
>>   system/physmem.c               | 346 +++++++++++++++++++++++++++--------------
>>   system/qemu-seccomp.c          |  10 +-
>>   system/runstate.c              |  29 ++++
>>   system/trace-events            |   4 +
>>   system/vl.c                    |  26 +++-
>>   target/s390x/cpu_models.c      |   4 +-
>>   util/oslib-posix.c             |   9 ++
>>   util/oslib-win32.c             |   4 +
>>   48 files changed, 1417 insertions(+), 210 deletions(-)
>>   create mode 100644 include/migration/cpr.h
>>   create mode 100644 migration/cpr.c
>>   create mode 100644 migration/precreate.c
>>   create mode 100644 migration/vmstate-factory.c
> 
> Hi Steve,
> 
> make check is failing. I applied the series on top of master @
> 70581940ca (Merge tag 'pull-tcg-20240523' of
> https://gitlab.com/rth7680/qemu into staging, 2024-05-23).
> 
> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/ivshmem-test
> ...
> qemu-system-x86_64: ../system/physmem.c:1634: qemu_ram_verify_idstr:
> Assertion `!strcmp(new_block->idstr, idstr)' failed.
> 
> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/test-x86-cpuid-compat -p \
> /x86_64/x86/cpuid/auto-level/pc-2.7
> ...
> qemu-system-x86_64: ../system/physmem.c:1634: qemu_ram_verify_idstr:
> Assertion `!strcmp(new_block->idstr, idstr)' failed.
> 
> $ QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/qmp-cmd-test -p \
> /x86_64/qmp/object-add-failure-modes
> ...
> savevm_state_handler_insert: Detected duplicate SaveStateEntry:
> id=ram1/RAMBlock, instance_id=0x0

Thank you very much, I will investigate.

I suspect the vmstate dup error is due to this bug which I hit after
posting the patches:
-------------------------------
diff --git a/migration/savevm.c b/migration/savevm.c
index bb7fd9f..54aa233 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1012,7 +1012,7 @@ void vmstate_unregister_named(const char *vmsd_name,
      SaveStateEntry *se, *new_se;
      VMStateId idstr;

-    snprintf(idstr, sizeof(idstr), "%s/%s", vmsd_name, instance_name);
+    snprintf(idstr, sizeof(idstr), "%s/%s", instance_name, vmsd_name);

      SAVEVM_FOREACH_SAFE_ALL(se, entry, new_se) {
          if (!strcmp(se->idstr, idstr) &&
-----------------------------------

- Steve

