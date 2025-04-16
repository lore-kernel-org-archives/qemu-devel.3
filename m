Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62713C369C2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 22:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5BOO-0000lF-AC; Wed, 16 Apr 2025 18:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5BON-0000kt-J1
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:38:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5BOL-0007QE-GB
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 18:38:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GLN0GV021790;
 Wed, 16 Apr 2025 22:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=wWQymbkjEv6LvwU7eHZDqx+mOyekQCjcLK/2D2bA6z4=; b=
 grPnMnuVwdtCzIctSa3KIMkaUouIlOvKRaDPdE81m6VKP4LIvssXg+DVPwDcE682
 Q4kyJn73yYTY0OOmOizaywmJw6fKzRKPBqfwDqeM+RYOg4rGe6XHqCgL1/KOJqZD
 6qo0TW42PZVoSZMwhBR97fyziHgPPG6GAVGSa/g2nTSKByc7vOszAdeuImxk0kKH
 YohKJ+e2ayIWtcCHJ1T2M6cVYvBlElI2tNds+9hKT2/e4nBJ8wHwOAj2ekOq4Jm0
 xQPwmHOI+xTmQ4w4MqJJ5xEoVEqPuhZ07IyzAfgOyCN+ook0kOlj4wXH3QVTBj1i
 50vmyYqNITzjjELQMeEUrA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 461944cxhq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 22:37:55 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53GLEruK005684; Wed, 16 Apr 2025 22:37:54 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d5xk86s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Apr 2025 22:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CtxquQgPgzW8m8bBmlkOFPjnJHvnB3da+oc/E1XkOpYbnjuoQ8ulS33uVq2eOWZF19NeUUC0YXApb57anRX46PEQikDEWzCbZ2Qlp11uQVdyE7+wnYo+8uKnMGriBqhnWL8ataO0mj13o5UiTut/OBRjjbUV2cEp89eX4OTirHpX91G4y1Ww4wtrS+ir2eKi0Kcs64r5mhG4rrbkvDXcEtRklHCgHVJ4ITkSUqDLiCT/vc5mBxE4nxz5CDZpOwXOcQZKoxycZNN1bsYVcqSlbxujxWTZS5NIDhhLNFGskQFe0nirlo2SN7JXniyg3Ab1LUjnyaI/UpeDl9JE7XhjRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWQymbkjEv6LvwU7eHZDqx+mOyekQCjcLK/2D2bA6z4=;
 b=Byxyv44UyE8OUHsi+5El+h9odsI6ZSFV9czJRm3Uq4gROPMwnKWdEyWjNpeMT+kkuMYr4yNfaZ5sbN2aUSo5YWVqvfz5zS+up3sPdCRb1HdchBIVMCYcx8Z5zYUrSK1MgEA/DiJTSbAfwgAM3M6Mb0pllI4BsDzcv9NaaVKzm4bHAXHFcRQxlW6BclhiSI+AS28ij+U3EP0VX2Zlj4CvBHzkr0v1+KvgvO1kz+dIi1jd4StV4OEnNCaeWXKbLTUfbdawMvrmV1QJ/EZRyoPt7+eN4qp6FikHGoEFvSb621ayZLLdtFfMui/R13ok97cj42AHvD4K9+Oa28Qa8kbhcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWQymbkjEv6LvwU7eHZDqx+mOyekQCjcLK/2D2bA6z4=;
 b=LPI8BubTELoTXHRtkOAmMRue467XgDnYakLEcwtiFpXZziAmN57SFxhimr51O5P6qIRauDnew1pBtBOc0mjbcf4OQX9mOIvHJfdWIibR2qDaMOwp9VsrFuT3QxCD+q+qP6/nI/kbB0+lq+/edAb5e/+b4oIRHDghFJoq6hzdWnI=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 DS0PR10MB6150.namprd10.prod.outlook.com (2603:10b6:8:c6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.35; Wed, 16 Apr 2025 22:37:52 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8632.035; Wed, 16 Apr 2025
 22:37:52 +0000
Message-ID: <7ef6e651-1007-4e19-95dd-706de266b093@oracle.com>
Date: Wed, 16 Apr 2025 18:37:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] amd_iommu: Add helper function to extract the DTE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-3-alejandro.j.jimenez@oracle.com>
 <4a7a8eff-dd21-49b7-9d2a-449ae0424eb2@amd.com>
 <49e7c66f-6527-4ae1-b712-10921c538d5a@oracle.com>
 <20250416144817-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250416144817-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::8) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|DS0PR10MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fb56cf-ba7e-4ccb-5354-08dd7d37526b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW9ldDdjUSswLzJxTmhPYjdCdE1CQUdhUHBla3BlR04wVUJFKzJGY0NZNkRJ?=
 =?utf-8?B?K3lrM1JVM2QxRjQvQ25aVXV6WE8vSzdXRWdXeDNzWWJWOFBWdUp1ZWhnbmJr?=
 =?utf-8?B?Z2ZlQktXbjd3YzhvYnYxaDVVTnB5SG1GVHkxTW5KV2FCSDBKZldqRnA1TzRr?=
 =?utf-8?B?THhhRHhPOEp5cDNQV0dwQVlEdGQ1dkJ6eDFraE1tNGdaUVhFckR2STZRanMr?=
 =?utf-8?B?cGdDTUhMdnY1QVRJNU8zUWE2N1J6dUxqWThiR3N6bi94QjRXazBuem1hb3Rs?=
 =?utf-8?B?RzJ1dzBxSjlXSk9GQ1h1WTlzYXMza25kTXlGaVFiV0lxYkV4OFVuNG0yZTFu?=
 =?utf-8?B?a0t0S283MkhoUExUbEE5MGdFa3lCSGQ2Y3hWMGt3MWVLWm5HcWNEV1FKU3k2?=
 =?utf-8?B?Qi9PZi9lM1N5bTVMaDlyZUNESkRIRVlPL1VteDUreDlmTGEva0lTT3ViRlNh?=
 =?utf-8?B?Y1ZQZmtaNnBjeHBmMnFNME0zUks0bk90TW8vczI3ZE13aGhDNVFvKzdkR3du?=
 =?utf-8?B?aWxLUkZicDZ6WTJyVEk5N1hnclEwS21oWVlxWlpLV3JkbFlyZUpFMHoxK01o?=
 =?utf-8?B?MXR4NXlWWVJRVTU2d2dKNUN3VWhzaVRpaHZvSDhWRWh5eDN4R1dOanpVZi9H?=
 =?utf-8?B?YWxoT3l5VjYya0svbDIxNUplUWhOQWVhOFJ4NitqTExzY3o4SHVIaFEwOXZ1?=
 =?utf-8?B?c1VKZlY0QXhSaUFpYThadjNoVjJpNForM2MrbXFWWXdUckpqdTgxVVZkcmVP?=
 =?utf-8?B?bW1uVWF1WU5RdW1IaCtOeEJnb0p4KzEyd3hWVmRwYW91WDJPYVE5UXo5SlB3?=
 =?utf-8?B?UXhmT2JpM3liUGdUNE5DcFU3bXR1cUxQMFkvRDl2WWJxSHBQV2lSc2x0Qnp2?=
 =?utf-8?B?ZVpSVUpwZGRLS2tWUmo1NHZET2lPYzhxYkYwUEg3Q2dBc2o3VjhEbloyQzVs?=
 =?utf-8?B?K24xMzloMTRacWExd0dmSXNSVlJRSHpzZURsSHNTb2plc1ZaUTJVVmVvTGEz?=
 =?utf-8?B?M0czTFN2bUYvQkJmeCtuOW5DTnJpbFBTend2MU1Ic0hsZVhJaDN3T2wzZzVT?=
 =?utf-8?B?QUFMV0ttczhxSE94TG5nck0rNnlMbHoybk9hOE5mNUNFMGpweXN6alhvbHly?=
 =?utf-8?B?dDk0U1c1QTNZZFJlVGRCS2YyUTl2OGM1cjlza21OdWxtZlVNSkNqNWdRa0pz?=
 =?utf-8?B?bHBFSk1VYmgxQ3c3dTR4R1N2QWp6eXlPM3NkejdKZ3h0cU1xaHhSTGkrL0Rt?=
 =?utf-8?B?bFQ1aVgvb2FoRnp5RUY2L2JVaENOSzJWSHo3dzVGNFFiNllBY3lxblp5Uk5T?=
 =?utf-8?B?R0oxcytQdDlKcGxHR1NQQzltaEFreDMzQnJBTDE4aGhYRmZ4am9pN3RDMW5H?=
 =?utf-8?B?K3R5MG1iRXN5cTIvMXhmcm5jeklkN1QzNWkzTzVYZW1SdHRMbUp5UHFpRWxT?=
 =?utf-8?B?bDBjUlp0dU1SUnp0UE5XN2hxYXVUcGFNdnIyaTBjUjg3YVlPTWd2VHcwVTEz?=
 =?utf-8?B?WDBaTGZpSzBMZkp0ZkFOem0zdk9VZnQzTmNhbllCRTAxM1pKVVl0NHlpQU1F?=
 =?utf-8?B?YTkxNnhrMUxUblN2OFZsdkxTT251UWNPU0laUGwrbitFTlFwdktMeGg0aGNt?=
 =?utf-8?B?RVlBYjhxVVgyNHZuK0svbC83c1h5MDQ1TjBUZVlpOFVPUDBxSDVSdUpIOWY4?=
 =?utf-8?B?Q2Y1OTRHSDdKcEhlZExUTXlVZHM0eDd3MFFGT0R2NWNPZmRBNkhQWFI0azFK?=
 =?utf-8?B?UUxmK0t3M3UvZ3dvTzNJUzlhYjZGMHppcWx4cUt2R1F1a21VMlJ5NkNvSGlG?=
 =?utf-8?B?bFB4MFdwc3Ewb3FITmRLUWg1dzAwbjFNZmF1Ny84aVF5VUpRQ0MralBndTls?=
 =?utf-8?B?eCsyMHppY3pMVlZmU2crdmVENUp1WlJlbjhKcWtUbU9JRFp0M2tORldkWWls?=
 =?utf-8?Q?DM9AXGJWCdY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG1DUnBKTFlpWmZxTk5tb3ZwNXY2M1lVcDkrUzRHZ25QMGhiKzFXSnAvN2Fv?=
 =?utf-8?B?RHMwUGp1MThTZGpURDZ2enNDQzJKU2Z0cXEycmwyWGtLc0Z5WWV6ZDZvQzFZ?=
 =?utf-8?B?QWc3eGcyemp0QUs4WTJNMmxuUmpQZ3NVYjZtUWhrRVlYUHhQZVowN0pONnlW?=
 =?utf-8?B?eG50NE1zcEZrUlROeUs5VDJOT3RiRzBOazVoMEFlQ0MvN3d0cFJZZEFJSjU0?=
 =?utf-8?B?MDJlYVVOL1VVSE5Ic1EwNFF4T01BK0Erc25idWRLVHNXVmhWQzRHdmJGT3Q1?=
 =?utf-8?B?eFpkOFNwdHpubzI0WCsvUzh3R052UzRWZlRwOVpmZXVuemp3aU1McXdSRXJP?=
 =?utf-8?B?K3E5TGc2cUxkUWJJSWpuUk9JNjdJMXE3R1FwUnlGVHI0TDgvRjZJcUF1Q1dG?=
 =?utf-8?B?KzMzRVBnTWRQMitnTVdncUNkNVBpS1BQc1FUWE85T3NoZGoweVZGS0lMNnZo?=
 =?utf-8?B?YS8xM2NYOWthQ2IvcW1WM1JNelVveHJHZ1NUTnhJYXBSOFA1Y0NaSXQ2MHho?=
 =?utf-8?B?ZVdSZzQ3K3JleEJ0Kzl5ZUU5OHNHc1lJTW50R1QxRk8rTy9EejRmNjc2dUxw?=
 =?utf-8?B?UVNCUkVSb2FubFBPQ1FTOC81UU8zbzZ3ZFV6eEVOeU8rQjhtNU84VXRtS2NM?=
 =?utf-8?B?STRVZ0Y0RFVpaDRCUEF6dFlnelQzNUgxbmNCY1ROSTZWZEJCNzVRYTVYYVJr?=
 =?utf-8?B?MjYwMVpNNWN2a05NVEI0dFRCSmtEWmd4T3Rjc3kzMERKZGY5b2l2MmVSSXk3?=
 =?utf-8?B?MktRRlprUVRTdEdKSWFoc3dBajZqOFhUYlRpMGRqUWdycVRyMDJ6aDBEU0Vt?=
 =?utf-8?B?V1M2L0doYkF2MlR4ay9UOXMxbTRpUjM1VUN4d3RlT3h2UHlIa2RMRENKRm5W?=
 =?utf-8?B?TmJWdWlRb2hPTGY4VlloeXd4REtqNERqNGpyREZZRGJDalNNMUEySEs3L3BW?=
 =?utf-8?B?TXpIK3Zzeng3ZEk1Z3NHNmhHTyszQkZkTVE4Sm9nbUdNc05GTG9LTUVEM1l5?=
 =?utf-8?B?QW5kK0s2VmpDZkZxKzJGMm5oczVNYmpOMmFUbzJ4ZHRURmdLb0NGcWFBaGlK?=
 =?utf-8?B?U0NTUmk0a0NveDMwV3lrK1pyenhhUUpLdG8xWE5mNk83RVJZKzhMbjAzMTJm?=
 =?utf-8?B?VDRDZndmaUVwN1Q0T2JLd2syWVd0dnF4NWozOWNEQjVTOFF6eWYyNE5MeXA2?=
 =?utf-8?B?cXEwUm95Y05wOXM0TmkzdnZXTmpQcitlQWpxNkhQT2ZCYWxxWVVtRjc3Sk1h?=
 =?utf-8?B?TmJybmRTV2hjUUE3ZGErTXlJRHZmb2J3WS92WkJZNDZYeVFYUFRMYWtEZGNU?=
 =?utf-8?B?MS9xZVRqMmZPSm13VnFLY3Z5SzFId3c3VU5DNXVXOFF6NE5GNXFJeklhSzNm?=
 =?utf-8?B?dW41amYwRGhzaG41RWwwUmpNd2x3WjVOYWRCVDU1aE01Qk9RcEoxUTBlb25L?=
 =?utf-8?B?V29FTzdYL0tHaWtJb1pkd1NVN1ArSU5lVHI1WDZhUkFrbktGdFN0RE9Tbkh2?=
 =?utf-8?B?eG5mWm9OOFM5L3pDMk5nS1l1N08yaXZyOTFXMWJ6WFE4Wi9NcC96VSswcUZI?=
 =?utf-8?B?MUJBemNGaStjSTRLUVZFLzNDT2FDQ29rV240dzBoVjBPV2FjaldYUUlubFc1?=
 =?utf-8?B?RWlxRTEvSzR0RzRRSDZuT0VYR2djUjlaV2ZpbVRUMzQ4VHZaVFJpNy9YODVE?=
 =?utf-8?B?UzBYN1lrYVVsL2RJN0wzY0Y5NkhHSmVpY1NWUHhjV2pxRFRIL3B5bk5TRjZt?=
 =?utf-8?B?TEJXQ1FQUXlDQVJidFFmVVZ6c091b2p5ZkFvaWc3QWU2ZlFLY3R6M3pzUjZX?=
 =?utf-8?B?aXcyQXlNMUMzVnBmdmdJZGw3QnJldlJqVm9JL3dhaEpZSXBBcGRmWnUrcjRO?=
 =?utf-8?B?QVdDUCsxQ0ZNQXFhNVg5d3BBOFVkYVlFaWZwNlNpcythaVU1M0hmOUliV1Nv?=
 =?utf-8?B?clZqaW96MU5Xb2NTV2hZcGNNT2p2UE1MK1pXc2pIR016T0FhK0hLdWJQUnMx?=
 =?utf-8?B?bkllcnhodjdoNWdxaGxDbi9hUHE4dkh1NCtxOHozY2tSSWlEMThxUXJYSVJt?=
 =?utf-8?B?eWQ1Ny9KN3hYMEgwMjRmWVZqK0xaYnBWakpHdzVQMlhRWTFmN3hJaTVSZkp5?=
 =?utf-8?B?WE4rZFRQOExsc2gvT3ZERDRpNHNJZzlsUlZDcFk3SnhVSkpNamtRVWhTNmJY?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Fa+efG54kauB2Q7mXx/jg5uQ4otz3Tvy509XWcUiEpt91f5mNfG/L8HJp87VBJwpnds3xLZPQP0WwFOKkz6kGkIWzT+9P7Elmw6rXEiyKrvZ76+H0WPIiLMFb8Bk8SsLv0hppKrBDwluVXAf8PfCZBy3onqhpPilMOStC0JYHIkb/RvzOAXklUcIxKQ4Idprkug8iAzHiUQZmzJ2NF26aRm0+KZImpY4frL+FRYYWdC4EbXOECWjbY94TfIYNR/k5MAKlPaMmLgIzhVxAKwgJIP3G9zYk4sTVcC4d8MMYEGLJdAAaeKXFctsvfrrhCMTzXUdF4n2KyqZww1qRjbFdoWZokAayGNs2WFKHBjcIWS5RXFOMRS6mrD5RrYi6A4F5WZHbKuZDDT9hZzL6SZl3qq+wfTF/LiXjlEX1kdsSoEkgM/N02aktsWcrga6HIKQiZIS+iFLF0lpSyN+nsGrLbPQ5/uZMFzDGpP/F+cchHOgw2FjsC89NyPJrT7/g/4Y6r6egBEwe4XAUMtRNwql9r5WUz7MdJ8Ztl5hxAnnBXDxX6X7OeM10cg+YOKBf3hw1D/9ne4OKbR8orlVPDEPgB2I9TCUZ60Me5Q9KxeKqr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fb56cf-ba7e-4ccb-5354-08dd7d37526b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 22:37:51.8613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/p9AJq52qKfJ8J3dFVHaqxxanIWB1LCBZnlDkG3T6haxQ3j1Gat3iqnt1i7ZT2wqsUEGQZW5+Sv1CwTdWx69FOt1qnnggC+rksMuj9otDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6150
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_09,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=985
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504160180
X-Proofpoint-GUID: Vnw0aq9ZGzRfnqC1Q2zAyJk0OjvgEFf7
X-Proofpoint-ORIG-GUID: Vnw0aq9ZGzRfnqC1Q2zAyJk0OjvgEFf7
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



On 4/16/25 2:50 PM, Michael S. Tsirkin wrote:
> On Wed, Apr 16, 2025 at 09:29:23AM -0400, Alejandro Jimenez wrote:
>>
>>
>> On 4/16/25 7:36 AM, Sairaj Kodilkar wrote:
>>>

>>>> +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte);
>>>> +
>>>
>>> No need to have this function declaration as it is a static function.
>>>
>>
>> I am adding a forward declaration since this function will be used by
>> several other new and existing functions throughout the series, and this
>> avoids having to keep moving the function definition. I do the same for many
>> other functions in later patches, since it is more practical than constantly
>> moving definitions around to guarantee ordering constraints. That approach
>> would create patches with large diffs but non-functional changes due to code
>> movement alone, makes it harder to parse the changes that actually matter,
>> harder to rebase and resolve conflicts, etc...
>>
>> Alejandro
> 
> You can add forward declarations temporarily to simplify review.  But in
> the end, I prefer seeing code without forward declarations, with
> functions ordered sensibly by order of calls, rather than spread
> randomly all over the place.

I see. I did try to add the new functions in locations where they would 
logically fit, instead of randomly spread. But as the patchset grew it 
became harder to do without code movement.

I'll rebase the series to avoid using forward declarations.

In a somewhat related note, there are several patches that introduce 
helpers that are not immediately used, so I marked the definitions with 
the unused attribute, to be removed later. I can obviously squash the 
helper patches with the later ones adding the functionality, but I chose 
the more modular approach to split the patches. Please let me know if 
you agree with this approach, or you'd like me to submit larger patches 
instead.

Thank you,
Alejandro

> 
> 
>>>
>>> Regards
>>> Sairaj Kodilkar
> 


