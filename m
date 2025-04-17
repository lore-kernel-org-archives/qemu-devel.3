Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F497C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5S0L-0004MC-Mt; Thu, 17 Apr 2025 12:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5S0F-0004LY-8A
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:22:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1u5S0B-0005xI-VS
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:22:14 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HGIv9F029519;
 Thu, 17 Apr 2025 16:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=h+O7aHYeSIy5gZoeoZXBupxj1nbZQNP2YXtpp/+qdOI=; b=
 iWTIOZA6SjbXR/k1A3TGHufE5VF6YGy+dgmU24NqIh9WlF8xxL3m1fV0oI6qQAuw
 vMhi7jXOjkbr7+RUT7IAiBLz6SqVr6gzYX2seAIEoJa4KaXSMmN3oQ/uYnvgU04u
 l/JPzRV1h/jbYz6o0sDDCiOCmKMWbs8NCdYY7GwXstwoajbl/a2U6Hg8s6bfzzoo
 Sqx7aCDtJmSj4hrQpJJ7s9CmrEwZrCjd2UpZpLk0KyiVllCvjqZakxJshh8rSytu
 n3QMzpc5ZOOZJ/hVmhRFaSxo0Cl9YTMJE8/EdpOK1uQwp1/T2G5OKBsqAtk+Asmx
 6C7CsVL1nBb6+eZPPPII/A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4616uf70wa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 16:22:03 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53HFTGOh024692; Thu, 17 Apr 2025 16:22:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d53qvuv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Apr 2025 16:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzpExnrCPhFM4/f1SWlkx6xulheXXej1wEWvo+2oKlEgsmI1TP9vQbKipAVb5JRtbGy9L0VPUiPt328Xjl0J2KAj6cA/yG3tXisegR89NW1Pkjea6qs9lillqXfPPd4oQ3yc1RfOQKa663sw9ARru7lLkAJgO4XtQKinZxSTbs7dRGeARhv52W09dvuYFu4JVd7okDHeznuRIG2LLqq6Ico+wI7b7Xa52UWzyrEPg1YA5ZCcvv/XCSfX1IV/9CGZ/CcCc+OPpntFOM3RMNYnUK85yyW/Q4iYzGPVA51ngDRathUpcjtMRd78ZkKwQTM35FueHqqxy5ddEdaXsP84fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+O7aHYeSIy5gZoeoZXBupxj1nbZQNP2YXtpp/+qdOI=;
 b=NE0TwMVR+tcOa5K+X/ohZOFTORZjziesAS9i01aSnSs9wf2vgybk08UYc+VPSnRwy80sW2h89qD8umeLT96foSfER8GeyojEMkjwiIpmXI4/BGWkNcOkDEFcbqPzixtuU9AoBu+/RwCktko/4fvdSkzfoFdEMQEt94Mo/qKfz2p96020XkLu26AvQZ09vF0RN/bWOQEdSlscF5Pr46VVt3wTheeXCvB2ej84sqS4SIIxKyOJkodHW8IcUnvRkgelwjYf08fPgpKOgcRSWOSw8aGW74POrWDZAb8KCx8M523bi3ew+uR1dB11i8dgyImbBzl2iM2T8slT2PlnOsTOXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+O7aHYeSIy5gZoeoZXBupxj1nbZQNP2YXtpp/+qdOI=;
 b=uQqXDo3QDZLsSV4dypz5OWlBbQ93zIoOYwOO4t3t0C2YQMvW/27XaVt8seq6Qqnj2BsxeabKHJO5gf7OmQHDBr60tDqnyFUH1t2gSBBHnxZy14Pot1Dq1dPIxAe5hqw84C55zIwQu6muuvzeJM/oyvmLQTG5E22+g4KN2GC1vpc=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 IA0PR10MB6723.namprd10.prod.outlook.com (2603:10b6:208:43f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.32; Thu, 17 Apr 2025 16:22:00 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8655.024; Thu, 17 Apr 2025
 16:22:00 +0000
Message-ID: <8245dc10-4dff-4a89-b4e4-dad5025544fa@oracle.com>
Date: Thu, 17 Apr 2025 12:21:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] amd_iommu: Add support for IOMMU notifier
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 vasant.hegde@amd.com, suravee.suthikulpanit@amd.com,
 santosh.shukla@amd.com, Wei.Huang2@amd.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-4-alejandro.j.jimenez@oracle.com>
 <d4c11455-f28f-4052-9042-5d2c2ed9329d@amd.com>
 <f14bf894-0c95-4bcf-8a7c-25dfa7ebe76d@oracle.com>
 <ce1ae384-ab88-4de5-af14-9479394b9182@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <ce1ae384-ab88-4de5-af14-9479394b9182@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:208:23d::25) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|IA0PR10MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc49a84-7319-46cb-45d1-08dd7dcbfaff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUNiN0N2b2p2bHRFemcxNFRubHBMR21UcWlSUHVGditVdzYvYXBCdDZUS1Nk?=
 =?utf-8?B?ckFpcm85MXpPUytvMmpPUFBWVnJFcG5Yb1FMeUx6c0V5Vlp6dXJ6ZHNxNXFH?=
 =?utf-8?B?QUJEdDB4QlZIb3Nyb3E2YWRRWDlsd1E4WFRaUVhuUURoM3d5SkNQWUVWU0Zj?=
 =?utf-8?B?ZkNtbVBjNi9XWkMySTFCQnBGQWVsZzdXd0JOTXF2MkoySHVqbGJxTm1lL00x?=
 =?utf-8?B?OGFOd2p3bDdxam56R0tMRE16djNFbEY0SmRFV043Y2xDL0VNcllrTlIwQTFh?=
 =?utf-8?B?SVlVZVpWRDZnam5GMHNmN1FrUU9FSHJlS0pxR0lWREtaVC8xc1dYSlhXVUpP?=
 =?utf-8?B?NUlrN1Q1cnBkTlZBbHFqYWpwQmEyWVNSbmZoNTZlbGFnc08xN2VCdG8xT1RB?=
 =?utf-8?B?a1BncVhCZEFPcmZtVlRvSUMwWThaZHNkeDkwdHY1R2ZSK0l0L1k1MzNDOUor?=
 =?utf-8?B?TFFhN1N2Z0ZULzBnSUhLTWdHZWRacFF3Q3NlTllIcTNtQW1BeWhTdlM2eGdp?=
 =?utf-8?B?MW5zNlRhcDlWcm5oalByL0x2WmNBR25ESFF1cUkwalVxblJ2TXBIcDR1bW1R?=
 =?utf-8?B?aHJTL1ltdDB2dGVwQ1NNMS9VRFBYOVkwbCtrVXhWUmhZTWp5Q1JROGx3aU5u?=
 =?utf-8?B?OEJrMmZ5YnVzeVMyM2c1WUFtTzRzU3FHVVRUaHVXQkZlUEJxU1VENWRZL1BU?=
 =?utf-8?B?dDdFTzVMNnc1RjN1RFpyanpjTkNobDVXNjM5YlowSXBua0NpUEg1S2haVEVU?=
 =?utf-8?B?ZlE2dnBMUmhpVGJZRGxpR0RYemJhdEx4czB4ZXRHZ1UxTDh4bEdEMTFWWkVz?=
 =?utf-8?B?dFlhdEUxOUpzMnpSOFdaVkgwL3pWdzk1clVldGxyZDdlaFpXaG9SV3dnc0hh?=
 =?utf-8?B?czYrUlRxMUhDU2Z3cVdvMElwWlNRbTRCTGVsU3NGUCtqejdzR2hxRjNaQ3Rw?=
 =?utf-8?B?QnNhOVlaZjYvR3hGN1pWQndNc2tOenFPRjdPZFJGY0hvNjZuYWtnTnFzTWxj?=
 =?utf-8?B?ZXdRZ1JxMmZ0VjlYVng5bWVQMkV4WC9ua0hFQlNDV000bXdBeWl5Ylluc0hh?=
 =?utf-8?B?eXBidTdMV0NtUFhhS3kwSS9BZlVzR2NiOTZpaU5Gdi9nKy9HNjBjWklqdmc0?=
 =?utf-8?B?VnM5S2toeERnb0VQNVJpOTJNVDdMTllRWTRpeksvZVJ6NkxjYk1tL3FOS2Rv?=
 =?utf-8?B?R2NGSEVLNTMvUlRUNm9sYlhUcHlDYTZyd1dNRndmQUM4NVBCdTZTKzZqNkVL?=
 =?utf-8?B?Y2NrRW1LOWEzdXhNa1JpWmgrK3lMem13Skowcmt6S0p5bmIvci9EbFlLbDRO?=
 =?utf-8?B?blFreFVoaTJUWFNldHVyQWc3TDdYWnkzRTltaTQ4eVppRXhYcjF0ZXE2dEVE?=
 =?utf-8?B?MzYrcmtzS3YwSWFHYjc4bjJBODllbjRDWlpZM3ZjTzhEVStiNjUxTEJVSjVQ?=
 =?utf-8?B?SnI0b2tqeFF0ODBNbzVBakxnaE1ZOTNscndKRGJIWWN4WDBnYWwyeDJXS2R5?=
 =?utf-8?B?M1BxNTlCMGNXRER1OWNMUElqbmlPZUtTUjFiUzI0dkVrWE9hWGhiTThxNG52?=
 =?utf-8?B?eUJJK3V3NWZFNUFRUm0vMHo5Zmt6cFJCTUIzSWJrL1VjbzlJVzNCV2x4TEVr?=
 =?utf-8?B?bitQZkJqZjBoS2NxNElWU1h4K2ZkMjZ6cG1nenIzenBkdm9QY0dkTHVVcWRu?=
 =?utf-8?B?dHNoNFI1eFBvYW9tVXVqeTVUUGhZV2kxOWpuMHpTdkVybk13akxuTXNLNzZq?=
 =?utf-8?B?eGxjSVFXOEZTUkVsajhFbzRrSUZGL2huOEZHZWNkcXczRTJNVGtrSEREcWhv?=
 =?utf-8?B?R2UrVTN1UWhZb1BETERwbnROUWVoT3cyMkJvRVo1UDJHTUM5dWRSd09GWnBw?=
 =?utf-8?B?K25DUEpQTU9pYkVnM2N6cWl3VW9jRW51dVowM05VN1Jhanc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OElsaTFuenVvL0s1NjZUSndON0JsNVd2MHN5dXJVU0x4VjREYVZ0WTYveHo5?=
 =?utf-8?B?Szk1RlhXY25wK25hdDBsTDBQZ3EzSlJHRVJPdDFXZ21Iek9HcWR3Um8xeEto?=
 =?utf-8?B?a1V1S1F4L2pWSSt3VGx2T0RpazZGanVPcFo5blpyblVhWU1YRnRZY0JBaDV6?=
 =?utf-8?B?QWE5Nkx2VTgySzVXVlkxRk9HSU1PTGExS1pXMFByUVNlTytuSGxoWlNrclpT?=
 =?utf-8?B?Mll2MVpQSGxYRHVkNm9PWmJ2NlNWb1JHdURSZkZHaWFFNGFLVjViWUNuSGxN?=
 =?utf-8?B?c2RmOEEzemRnN1VtZElraVpkSFlNUVRxSk5NZkxLbXBpVUc4Tk5DTEVJSkdm?=
 =?utf-8?B?NzVBcTkvZ0gvQUppMGJlS0VjWHZudHJvbXVvcjNydXI5V2J1Vi9FMzJqN01U?=
 =?utf-8?B?RWhyMUZGQ2lUeFJqdFFCbGdXZ2FXbk9CUm93Yk1Yck16bmpScnZDaFNITHY2?=
 =?utf-8?B?b0tFQkJMY3JFRTkwckpiTnJ5L2VYa1hRQVhUamJrOEx4eXdzd0cvRnBtYTJs?=
 =?utf-8?B?WEwyRkc5cGsvbmhPVlRUTlJFWEdFbTkyNlJKR3IvVXlyT29jTDZackJoTjdV?=
 =?utf-8?B?TWE5MjFFVnlJYUI5WTQ5MU00bFV5VlZDa2VuS3J5L0ZXbmplMWdNb0o4YkFP?=
 =?utf-8?B?TFJIamFUTlgzSGJSRkpiVHdRdGVrQWVqQ0x5d3dUa2poeWVUcndoTFF4ODh4?=
 =?utf-8?B?RjRQTE9NTnR6R24vcGdzYTJZYkIxeVdPRU5GSTBrRjdUZnJsWFJ3QVpML0to?=
 =?utf-8?B?MW5MOUNXdVpJbmp2dDlZWTQ5Snp1Ry9SRGNTRllTVHhVQjNSWVlOSlUyMUNP?=
 =?utf-8?B?WkYzcis3NmlDTFBBSk1NcjJCNFIyTWRxUHg4ZnZ1b2xucDQvTkZOUS9nWllY?=
 =?utf-8?B?Q3FMUFlPbUlVbzczVVdTTERGS1A2a2tyUTNieDF6WldtTE82ZjF2a01rY1Rj?=
 =?utf-8?B?c3ZzWk9nNjBPUWtrWUZPcjc2QTNqZUtvQlA1QU1vc3FmU3lkNnVBLzYzS2Rz?=
 =?utf-8?B?QThpWENMQjhtMjg4QlA0LzJaTXhMN3FWR1pkbEZVSGl4dWZKZHdaMHovTnFO?=
 =?utf-8?B?Y3pyRkF2VUZwbngyTG1lb1RmOUgyckFsdGJBdHQwakJuQWdiQjhONWFmVENv?=
 =?utf-8?B?YzhKTkFNZmpwNW9PdXl0ZXRPdTRpY0ZLYks4bDZYN1E3dWo3TURGNm1BYWd2?=
 =?utf-8?B?dzRBbk5wRTJxM0EyTnVFUjVGWkViUExVOUIxa25CL292ZCtNOEx4TkdLcU03?=
 =?utf-8?B?anhNdSsvdUU2TnhWKzhMbks0Z3Qvek5JMEJYeHVUR3doNlNCYjNYVjFhNWhX?=
 =?utf-8?B?eGt5QTRiT095MW9ndnkrVWR4cXpkanpaWjVkc0d4VjhmamViM2sveDM5NFFC?=
 =?utf-8?B?cVl4b0VsekFseDVad0tiNDkrZHZGQXFDRXlYR1Fha25RYkd6VFlhcVdaRUcy?=
 =?utf-8?B?MnZ1WEF1L3U4bTVVM0p1ektrek1QRllxSW1ETVBiVUpCV3JXMGh6NWdjT1dD?=
 =?utf-8?B?YmVmSXIzeFZIZDRoTEFoekxnYmtnR1Avbi9OVGcrMlZadlZLSngzWEVGWm83?=
 =?utf-8?B?bURteThCR3NBa2VRcU1jYzRUN1RndHk5R0RHTEt6eWVpcTNmWjRqT2JMT1px?=
 =?utf-8?B?c3d4YU5XTUdoaThtR3R4VU5LeXlvUE8zMGtBcU5tYjdZS1ViYWUyL2ZMQzc3?=
 =?utf-8?B?L2oxVEJzWVFXTGs3Sm5JeFkxcEtrM3pLM0ZCVUc1VFVIQ0ZQdno2OEZTeUFM?=
 =?utf-8?B?UmZNRCt2VndIaU4vSFVId3ZEb1pkVjhGU0xTQjFjNzdDVC9UcXpRZXVucjZZ?=
 =?utf-8?B?V09vQUphZ05pTTBpUjBRUlh2M1cvWldML21mUXdJRzVFRXNYdTMxZWZzQzFE?=
 =?utf-8?B?OTE5akNtVnNiZjZiTjF6M2UrNnFKRm1FUVRWWGRHaElyUFgzeUJ1WlF3dURF?=
 =?utf-8?B?NHQ2VGJqRVlDVkRVbTlzZnJndUxBMXFYZzJudGNNcXIxSkJUSFV6Yld0bktM?=
 =?utf-8?B?a2NCbWJSYWI1SGE4TWJMNnkvYmcvMlMxQlBydzB2QURnYzlXaWNFTWZiZDlC?=
 =?utf-8?B?Z2V6SERWTlI0dGNWNllDWHdSU1ZVK2tlL1BUUmFBcFhWTXZNZFpQZS9kK0po?=
 =?utf-8?B?MDNLV29XeGtCaEQ0Y08zNjhpdHRHOHY5eTJjeWdFSDBqZ1ZNaGVkRVY0T25E?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tbEpT33gvFl3wyusBiibDrc9tdgLlfCDqvkNMgILtk+s7kJhJGMwuKPLMZzGmlAPd6b2RnBbD1Y8tgkESm7JiQzBIV79NBlqAE/Phb5Vi5/oCbXVSiQj0SxNU7lnqou0rCaaxbR3RGHa8uQro84l7cS5N34Wc7vjKJI2Wk0Tm3ok59MHgKGeHhAj8BQHZjxc4l+orl+/1o1SE9+pMAsDLgTYIkG+0mxHtuXhNO2e27/yXRr1crQhBkqeWKr+b+kBsaDShz35h8rVMUsI+bK4n9paOqnUXj+JSRzgSwzbWO0q0kvHexONGGyz3Vc1aEhfp1IAniibuLNiN1622nZTmsSSNawwd3JmJz4O2fyzL+DtIz3m3XoOeE/DWZ2LLhmPJkI95YSOPrkDrBipSFvyqorsNvwLfHHs4jobqfRbEFqPoEUkh+UFtj3ajI26pgGTTVntDJUgYDMS2yp9cSGCtDynd+UeOt6XX40zvpqnNqnhUbaia0HWH95DMujOdzLnS65Q1pOSngI2r6dEGK2u6Zdkweu1KMaCtas1LAebM2UL86G/5GCdPRV+fHW8vDNGgkFe7mhQKBjKovvE7RVikErR1kqb+iobi2S6lBq33x0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc49a84-7319-46cb-45d1-08dd7dcbfaff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 16:22:00.0804 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j1PDUsO9wfhbEATNgrOec06SE9lxx2Ve60c3n2hSzLDO9jT8lc5emALVQ9M30OkKdgne79linhQ2yiWGXeCJaSy+EquYKGK3Ymvnus0O9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6723
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_05,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504170120
X-Proofpoint-GUID: 5z0zyjf4VLVhCqvbpUzSvvlABK0z0LHj
X-Proofpoint-ORIG-GUID: 5z0zyjf4VLVhCqvbpUzSvvlABK0z0LHj
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



On 4/17/25 6:19 AM, Sairaj Kodilkar wrote:
> 
> 
> On 4/17/2025 3:47 AM, Alejandro Jimenez wrote:
>>
>>
>> On 4/16/25 8:14 AM, Sairaj Kodilkar wrote:
>>


>>>> +
>>>> +    /* DMA address translation */
>>>> +    bool dma_remap;
>>>
>>> I think you should use this flag in the remapping path as well.
>>> I am aware that you are using it later in this series to switch the
>>> address space, but current patch will make things inconsistent for
>>> emulated and vfio devices (possibly breaking the bisect).
>>
>> The change in behavior happens only if the user explicitly sets dma- 
>> remap=on property in the command line, which is why I made it off by 
>> default.
>>
>> To eliminate the possibility of using dma-remap=on before all the 
>> infrastructure to support it is in place, I will move this patch and 
>> [5/18] to the end of the series. Does that address your concern?
>>
> 
> Yep, That works for me. Its always better to introduce flags at the end
> of the series when we have the infrastructure ready !
> 
>>>

>>
>>>
>>> Also, is it a good idea to have default value for dma_remap=false ?
>>> Consider the guest which is not aware of HATDis bit. Things will 
>>> break if such guest boots with iommu.passthrough=0 (recreating the pt=on
>>> scenario).
>>
>> That is not new, that is the current behavior that this series is 
>> trying to fix by adding the missing functionality.
>>
>> As far as the default value for dma-remap property, I think it must be 
>> set to 0/false (i.e. current behavior unchanged) until we deem the DMA 
>> remapping feature stable enough to be made available for guests.
>> On that topic, maybe it should be an experimental feature for now i.e. 
>> "x-dma-remap".
>>
>>
> 
> But the current behaviour for the emulated (virtio devices) is to have 
> dma-remapping on by default... I still think its better to have this 
> flag = on.
> Honestly, I am confused here...

The dma-remap property is meant to be the global on/off switch that 
controls whether any/all the code changes in this series have any 
effect. It is off by default, so the new code doesn't run and behavior 
stays the same.

This example case you mention:

 > guest boots with iommu.passthrough=0

is already broken today if you are using the AMD vIOMMU with VFIO 
devices. We cannot stop guests from doing invalid things if they choose 
to do so. Following up from what you said above:

 > Its always better to introduce flags at the end
 > of the series when we have the infrastructure ready !

and we only enable new features by default once we have sufficiently 
verified them, otherwise we risk regressions when launching guests that 
have not changed their configuration (i.e. explicitly opted in to the 
new feature) but are now running the new code/feature.

Perhaps I missed a different scenario that you are warning about, in 
which case please expand...

Alejandro

> 
> Regards
> Sairaj Kodilkar
> 



