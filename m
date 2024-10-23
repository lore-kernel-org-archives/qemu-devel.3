Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F8FCFA459
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 17:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fGl-0001u4-RJ; Wed, 23 Oct 2024 13:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fGi-0001tf-Un
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:35:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3fGg-0008Vn-Cj
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 13:35:36 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeT6012081;
 Wed, 23 Oct 2024 17:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=88Wq+MZFpmn+xSQ+Tb2eefr5pH8zsm4IuWRL0Qytru8=; b=
 QjeLUe3ww3ywClIHW3CKRwP96D8V/JjEiKeNhC1f3ytNWcE0BEb7yAIwZUh7iKKf
 1chlh3i115MBwa70ZfOMcOkV0sYpELmGtkirTpNME537PDaIgqr/QU7KC79Tqgbd
 e5rVRlAnlgSqH9DPePmcQ+iNvnzk6wZv17VbSUtVXKbgmAn8i4plnlZzvLOvdNaT
 0BhITwn4DRyNYL/LJEOpyaBf42jJ5r+y1WEbEUAsrUDXKqIF7vAigsFPvsFV4wq2
 aQfffkgZXY8HAtLNZL21X/Trivm9vran7b6Jc8N9x8+VnD8hoZOSLHBirI6hQw+C
 SBAO5iWTyF00z04B6wWbEw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urq3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:35:27 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NFubuT031268; Wed, 23 Oct 2024 17:35:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh1txj3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 17:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jow9p25eqgcVl9UMjBsckn9d5qbrcMNSKnvYCzha6P+sPP6pV5h+AXZ6+Htp6USGjZ7cgHd/NjRHISHb1WVJa2ZatTNpPqRcYZWHR/MNTYohaHjn0KbDmGEhTHiF+vOhdmUj5Gj7RWkoEixVByDPOSEKOh10QQsV8aNTFgnT5niXHTwhgmfJusXDqnLzoC31De0k+GVEE0zB6NTM2+BXT/VvZ7FeYR8uFDCrvaeT2t7QcdUECvuFNXTsNymc/oqvZAsiazeW4feqYf0S0d5zoqmIuUiPWru8NAkGvVHr1J6Ij4jxsf+c69fcwU+jso0ZCwPXFpPYrPVLzWXWYOvMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88Wq+MZFpmn+xSQ+Tb2eefr5pH8zsm4IuWRL0Qytru8=;
 b=EnxqFKGODq5VUlB80V8mDdv34AsO2gtF/pa/FmZoG0hz4v5ivOxMr1erZQOV0N7lNZincBDCAke9kzdX+lx1O4JySaQskwJbPOzsbj+34DEUFBq9TI5IlKEE9+3g8YyHM3/09u5xZmSj4Ii7b1mNKJyVJ0i+Y0JChMILKdf8g3WqIov1p7A5q7zz5u5nVyRSjiiwtNIeX35OYnSvspc3WVHFOiOjZ4N3lSUhrkwR+ySVczwiLtbYibQ+4LFCxzBgDIZ58WyYvTTBWQhe3yBIo1F9vkENBTUXV9N36vIaXbWGg0F3Vb/IQiEGkOwWX8l9yrcQlOtxVl4wkuZTmkek4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88Wq+MZFpmn+xSQ+Tb2eefr5pH8zsm4IuWRL0Qytru8=;
 b=pUkL14d1UoKL/3PNezvnxJ95F9o/MXDYl/WaJvpEZLQ+TADGL8BZZ7NjsLjR/ty75HheJR1EX1ibLpeIdNk5DHHOdPOVZXr7KFzaF1cJljKP1bTrc9uYHWpKwR4LZAjf7CZtvAjbXL5dCRmCWlTtzlBI4L5/aZRJCe/AeAB0IKA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY8PR10MB7146.namprd10.prod.outlook.com (2603:10b6:930:74::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 17:35:23 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 17:35:23 +0000
Message-ID: <da6c5467-523d-4258-ac8c-24851d7fb9f4@oracle.com>
Date: Wed, 23 Oct 2024 13:35:17 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 11/14] monitor: connect in precreate
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-12-git-send-email-steven.sistare@oracle.com>
 <eca2be66-957f-493e-b788-c2f3c927821f@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <eca2be66-957f-493e-b788-c2f3c927821f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY8PR10MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: c953fba2-dea0-4047-ae8e-08dcf38912bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1pMTG5VOUFrcWEwYTNXMXFUdnEwV2VRbzhGSGdvWU5VOS9DbHhoc0hxYUdU?=
 =?utf-8?B?L2pXZ1dDTkc1a0NrL1g2SGJuSHlSY3B0SG8rdEpXRXpOTWY4Sy9leUVpVWkv?=
 =?utf-8?B?bW10aHg2ZytTWXZNa2lzY2dyMDBucTRPSEtZRHhueWNFTnhHN2xzZktNSXZU?=
 =?utf-8?B?RmhzQk5GdXd0d1piZUVYZS9JS0tzTW9vZmp2TE9tZ2hmMFkxak11dHRMTWZW?=
 =?utf-8?B?eURJN3JXTDF6N0RmZ1lyaGYzbmVxRUFvWndMMEFneWFsdUhoYzdQbW9Vckly?=
 =?utf-8?B?VDVCSXhRUXVUdW9KM1NGTnA2eGRRMW5UV1J5eDBSb2NBeWI0UXNaaUVPSWdW?=
 =?utf-8?B?MmhQL1ZOTXcvLzAyRHZWYjFLS0xyZkpFZHhrVCtXU0VUMkR3KzhIUy9OV3Ba?=
 =?utf-8?B?WXlJVnY2ZURXVGxIRklPYStXN1dTYUdncUxQVGVxRlo0N0Y0S2FjUDhuNzVV?=
 =?utf-8?B?aUFsbHZHS29kdkhwM05aS2ZGQ1JkVkNJVG5lbWQ2Nlp5U2Y5Z1ZJQ2FWMkh0?=
 =?utf-8?B?UHM4cWRxRFI1b1VEUnNLNVVDQy9VUmw3b0JRUm1zaWhMdGg4eTMxTmlibG92?=
 =?utf-8?B?aUlySmNFS29iWElHZDhvYWUxb3lONVB1M01wbjhQYzZVZFpSRHhmNWhINm9n?=
 =?utf-8?B?N2dpdzBKZVlDMGJ1WXRsWFlGcXIyRjJoZmpidG5PNGJmSVVMRmZtdlhmZHUw?=
 =?utf-8?B?YVdqZ1g4ZFgrbVV3MjFrMEcrTDI3ZXNqcm5ybVQwa1JNTHVVL1hBVTI5ZzBo?=
 =?utf-8?B?Mk5CUE9DZGdqL0FrNHFmc3E3QXFlMk9Kc0NEUnFpRjZjdEMrTExpc0hiaHpr?=
 =?utf-8?B?U2xUcjNPZDVWbWxKbXBhL0dhTlJPN1pZVEJWbXRLUll0Vm43VFZJZFIxenps?=
 =?utf-8?B?dDZVVWJIbHNlckRYaDRRY1d0R2ZHQUY5ZDVDaWQ3QmRSOEdYTDdBS1BKTEFZ?=
 =?utf-8?B?U1RvcGZIYUNhZjByRXRtcU1ZL2RGRXgxOHcwSlR3U0pXZjBTWk9udnJHM3Qr?=
 =?utf-8?B?a28rNGllNVFBTEU5d2hZNDhqTlRVYXlZNER0Q2ZLWGpsNFJ4OGgyZVhMODJp?=
 =?utf-8?B?Q0N1Zmo0OVNEbnJNRGVzRnkvOW9aZTRseVV2TkhYc1NtQ25YbW9Nd2NUR0xX?=
 =?utf-8?B?K3J2Z3RBKzZoZUdMM3FhdkdzVWhjSkdkWG5rdFM5RldoT0UrYkhBc0FjZWNF?=
 =?utf-8?B?R3pvb2tZU05zQzdJT2FwUzY3QnJGMWJZTmp4dEZHKzVvM0FNMHBlQjN0TkRo?=
 =?utf-8?B?emJyK05MZW5JRzFmblNnNWp0eE92czlMU2pVaVJaeFlFdUdXQWcyNmNkUDFq?=
 =?utf-8?B?N0lEMXprbHBtbnRkMWR4SWM4UjQ0SUl0bWVWVjUzM3Q5cTJLT0hMR2NXbDAz?=
 =?utf-8?B?WmJibXNxN2plUDV6Z0JkL1dsVTNldnBud3YyRFNRVzBvSVE3V3lLOHEwRTJh?=
 =?utf-8?B?cThvdksrWnBnTHNRbDJKWFhKVXI1L2l5OWZ0aXU1WlpJNU1nQ3lOOWwvcVI0?=
 =?utf-8?B?bnZINlUzaVI1MUZTRUVtNHprVHZRN0dQaUdVZzBKQ2hHYzFQczN6ZUlYRUxm?=
 =?utf-8?B?NmZPT04zelRxSlVUbnJ2WUp2L3d3dWpRdWxaTndBMml5TEF4dml1WjV3UXpX?=
 =?utf-8?B?UmtwT1MvbWFaemN6OUlsNFJBZkpTbVB0cmlKVThXRnlxOTNCZkN1RTQ5TU9I?=
 =?utf-8?B?YzdrUUpGTnNoZGdveXdqdUxkb0Q0T0YzTitzZlVPZnRBYXI5YXQrN1EvdEho?=
 =?utf-8?Q?j944frqBIL0CR55Av/IFBI9emEwLnTP7hMBz+3Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDV3N29ZMVZHbFo0SWpiOW9GeHFRMVdHbngxdzdFNHpQU1pnMHp4Q3VIV1ZG?=
 =?utf-8?B?TjZINmg5eFpVdlpOY1I5dFVjZ2lrRnlsV3B0TVdJbDBpa3VhM2RTekZzVXhE?=
 =?utf-8?B?OTNnV0JvMDhxdzYyeTM1V0tETDBMdG9IT3VTa2FZOEprNUVoZm1xakE1UmVt?=
 =?utf-8?B?eEJVRjBhYkxBcUc5dFFGWjBnMGovOEE1eW91aGtrTWlESjFDVWlRQXZ0WDM0?=
 =?utf-8?B?OUdKekl1eUV0YmZvaGpvY1FWZFpLOGFFQmtPaWZOaVJYc201R0FiUTRjRFVv?=
 =?utf-8?B?Ykk5WmN4cE5VTUtXb2RjUXFiT2QvMUs2Ykg3Y3Q3UllNYzlMc2kwMlhhT0Rv?=
 =?utf-8?B?QjlXcHVheUc1a205QjhrTXBpQW1LZE50UjNhWHRBczlTVVE5Vk9vQlNwSzdH?=
 =?utf-8?B?am1JODZvQ2wrQ1VrQklRSithcllVMEJVTzdZS3hmYmg5cWZsQWJDN0dGVjMv?=
 =?utf-8?B?dURqSFNWQ3EzejNTRE8rNkxpWmlvbVEySFBtK24yVEdkclRKOWtBaGpwaWt1?=
 =?utf-8?B?RjV5VlBVNEtVWkY4UTI1WXZIWGJZYXM2OXEzeUxrTDdiR1d3N29JUCtGY0tF?=
 =?utf-8?B?Wkg5L29XajJBUjl6cEhia2hKRW1STWg1MmdJcXpvQjREK3lKckF6TnNxOENx?=
 =?utf-8?B?aDArTnlkKzUzZStRbXVFbEZPem55blFhRWpFMlNzWHhHNHFWWlcrU1M2N3Ru?=
 =?utf-8?B?cE9odjhEUE5EYzRGOTdiOUZTdmQrWkFBd295NE90S0Rac1BPY0lCU05CYXQ4?=
 =?utf-8?B?UE5YdWJ1MFU4TzJRTGxhZ09FRmM5c1RXZHM2RDJHYW12S0kzSGo0K3BnVjJS?=
 =?utf-8?B?MnB6aGhxNWJpSnRNTC9tK0JqNkFHQVA5S0xLc29HRGIzMm1Oak5LOEEvdXRk?=
 =?utf-8?B?V3FOcGhLZHFaMTBpazVPMisrWFA3YWI2SWx5S0t5NnFLSWFGS055M3VBNkFC?=
 =?utf-8?B?ZC9qWVVLZW1vQUVidkttbUpQQjJUL014NHVxeFBWS2dsdGJINkwwYWttUk9i?=
 =?utf-8?B?Mmh3L0Y0Z0VoOHlkV2ZpV28vZmlrNCsrbzZtMTlQaWZ0NmZySXU3QVFTSlBU?=
 =?utf-8?B?OXhhTTArRGlBZXNHd1Z6S3FIdXQxQzZsRnRrNldHaENGVzFRSzV0N3k4VFVT?=
 =?utf-8?B?bysycXpUUUhwc3ZaTm1tVFVDMElTajY2WFV0SnFra3hPSVdEWVoveEcySFBF?=
 =?utf-8?B?MTU2bVIrYnRjY01wU25xVUNiSHJOWFJZQk1xZFhqVFFieVRWbVo5TmJpeGF5?=
 =?utf-8?B?UXFxUWJPbEpvZDJUa3RwT0Jnemx6N1NuY1FiZGVncWJPTU9SNzY0eHNoQnZK?=
 =?utf-8?B?Mlk5dWM5SVJ0cEFJWWlQeFRDN2xOSEFhS3NVSEpyalFURmhZL2tZU09KV3dz?=
 =?utf-8?B?WmJQdm15N2FjbWNRd0pQVjNuLzEyeXBoQnkvVlVSRFlWQXhpL3VDcW1YOXBz?=
 =?utf-8?B?ZHMzcVdCQktEVlhWaFZnUTRDVjRJdTlyWmhadzN1VWVENHlLZXgwa2NRN3RF?=
 =?utf-8?B?YUhLbkdSVlBYZHdrd0t4REYvMS8rak1lWGZ1UjV1N0FDa1RJZjBUMWEzMW1v?=
 =?utf-8?B?YVNzRHZBblF0VE1NQU4xTUI3ZUNuTVpkQ2l2ZUNGRWlEdWdiazFLYTN1NXVh?=
 =?utf-8?B?a3JocGY0V21OWWRTYmRHczRUaVBNajVIb1FHUExNbERFK0dma0V1dVk0NHJM?=
 =?utf-8?B?T3FYcDVRam1rYWgyaUIvbUxTRWFsK0JUTGVmQzVpNHJVWjkzVmVVek4xTEU4?=
 =?utf-8?B?VWlKY1FNSjNoQ2RqYmQ3QVBzLzVXS3F1cmYxRXd5VVFqc2hiL0ExVnArYU1o?=
 =?utf-8?B?NVZONmU2K0JseU5EcUVWTEVGN3c3VnZ4ajYyTVZIeW5uZWRrcXdlZHVaZG1R?=
 =?utf-8?B?L28ydytnWFZMVTJxTkJRMW1senovcFo4TFJYMFJwVmtEcHFkTHlDR0tSd2NF?=
 =?utf-8?B?NFhLeFlET0hnTlpYREZmbGhGUE85TS9XYklBd2tBTkIvYXpwZUs2SGpQa0xx?=
 =?utf-8?B?UVpRRlFlY3ZFZnNLM1U2Z3dBUWVvU3crQWN5K0kyQ2hOMDIyTVNQWXFvWXdz?=
 =?utf-8?B?Z3NCYm5pejY4VzNBQlBFMHFJOVcyalZWbnVLdkhjQjFJN1ptcEhkQXErZnVx?=
 =?utf-8?B?NVkwNXV3VkFoK3FwZWlaVUlnWGJGajFjQUMwU1Yxc2s3RXVFMFhJZVI3d0JE?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BUSHYAdRzKWx+hnhmR6/bYs8aqXk8OR6yiwclinx5986yzK+IN1K2BrLsC81lv4m922dzRM6N57sYJDRvcVDfEh8+qwFIH3qOgleri15k2OstAr8ar67Xn0uml0V6ndbofUJgGfGyP02Plz+WK/HuGG+zbR9n2NUJ5wxjtppvPFCQDuPJrexl9uWmo9DZjq2PwyQLGBdknwPSx080dEWtFKQaZdbWpwtGzipqkcb6Ak423FXbV1bgjc4t9MhIz1aL/saKiQ93IZ1qEYp3n1NYpHTy+n/LWtkCl1aacgIECcCw0Oog+l3B8i6ozKQHOJBOEZwNJ/cnKRwLkVbvS7j+JPYIbcyz7nla/zs3lBDXIcHbc/XJRjzPn2ppcLvl2wWsmbLX9imToI6pW46RWmqeWidFrybp2thAETCWioQ7iaTPxvE39WtR7Jh9KQE8eNvke6nDHG9PgF1JSq5hO0O9KoyX4bVPhwer80or0IFvOergD9zCwSJEo/3WsC2b0YZ86+ZVrMeEwZDgWtTTjpxBoPoe+xoRQKdyWt89oqozaZ2pBCh0bdtAgu11uWosRISDfrLp3KALkSqTXcXnybuMvYiqetJbsdy1Ca6EzwLP7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c953fba2-dea0-4047-ae8e-08dcf38912bf
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:35:23.2239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FkL8EkUBF4++N3ZsF0y77V9C8Etnd9Od0Q38a5RlbKlsvOWJulU88Q7lWwHxMdt18TYUCZlZquN6fJjoigppLcBkygmXpyQVoXAYp0EHZEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230111
X-Proofpoint-GUID: m2c40im-Ejfqhg7G0GuN6OhVinuQQ1WG
X-Proofpoint-ORIG-GUID: m2c40im-Ejfqhg7G0GuN6OhVinuQQ1WG
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/23/2024 12:05 PM, Paolo Bonzini wrote:
> On 10/17/24 17:14, Steve Sistare wrote:
>> Complete monitor connections as early as possible, prior to
>> qemu_create_early_backends, so the user can issue commands during the
>> precreate phase.
>>
>> Make a list of the chardev's referenced by all monitors.  Create the
>> chardevs, then create the monitors.  Exclude monitor chardevs and
>> monitors from the later creation phases.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   system/vl.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 77 insertions(+), 4 deletions(-)
>>
>> diff --git a/system/vl.c b/system/vl.c
>> index 3c592b9..a985ab8 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -1939,6 +1939,11 @@ static bool object_create_early(const ObjectOption *opt)
>>           return false;
>>       }
>> +    /* Reason: already created. */
>> +    if (g_str_equal(type, "mon")) {
>> +        return false;
>> +    }
> 
> This is incorrect as mentioned by Peter.

Got it.

>>       return true;
>>   }
>> @@ -1956,6 +1961,68 @@ static void qemu_apply_machine_options(QDict *qdict)
>>       }
>>   }
>> +typedef struct NamedElement {
>> +    char *name;
>> +    QTAILQ_ENTRY(NamedElement) next;
>> +} NamedElement;
>> +
>> +static QTAILQ_HEAD(, NamedElement) monitor_chardevs =
>> +    QTAILQ_HEAD_INITIALIZER(monitor_chardevs);
>> +
>> +static void chardev_add(const char *name)
>> +{
>> +    NamedElement *elem = g_new0(NamedElement, 1);
>> +
>> +    elem->name = g_strdup(name);
>> +    QTAILQ_INSERT_TAIL(&monitor_chardevs, elem, next);
>> +}
>> +
>> +static bool chardev_find(const char *name)
>> +{
>> +    NamedElement *elem;
>> +
>> +    QTAILQ_FOREACH(elem, &monitor_chardevs, next) {
>> +        if (g_str_equal(elem->name, name)) {
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
> 
> No new special casing and no tricky differentiation of how a single command line option is processed.  If you need to create monitors so early, create _all_ chardevs and _all_ monitors; same for qtest.

I do create all monitors.  But for chardevs, I only create those needed by the monitors
and qtest. That is so CPR can be used to preserve chardevs in a future patch.  But I will
defer that functionality to simplify this series, and create all chardevs early.

But hey, you have to admit the filtering patches are pretty spiffy :)

- Steve


