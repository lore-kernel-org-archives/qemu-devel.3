Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0EEC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 16:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts2iq-0002ui-D2; Tue, 11 Mar 2025 12:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ts2il-0002pb-D1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:44:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1ts2ie-0005A5-Vo
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 12:44:47 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BGQrCj030786;
 Tue, 11 Mar 2025 16:44:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=vFO+RtQ02eu/4OqQJ1ctE7VlOjpU1GGP877p9wzaB7U=; b=
 hJ5VA1KCgcO0k6UTVW9rdBpebyiqRIJBxbqJthtgv8uyXIWKpOK+33XPt5GAikKn
 xRCq7fZcny//0MnsqkDzarXB6ivrg4ypuFRPpVwwPXC1KUjV3Ok1xT7xks+dkP8K
 hkGSudof04MBDf9+AKf0kWDNOfKDSBSYJUf/8Pkx+GUK59GPSf6fWOfgzVTDxYKx
 NFIXCTQZgjQeOsZ5WrNFxBKxcr2NmawkpqQDoZYhmdgZ6g/9bne+OmqBGkvApWV9
 uFYv4RynVonPj5qcyneVJf7rLi2KmSKeJiG/ZBf1kQehvrwhJYFPBv4zluWXDI3V
 AxbS3U/bJRbFJ68R3FI4KQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0wcae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 16:44:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 52BGVoio020050; Tue, 11 Mar 2025 16:44:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 458cb99s62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Mar 2025 16:44:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W00/IiDvSnnD7SXVf3wO24Rga6gKDo5hsyKEZlV6w/+cSn5KOlLJANwd7Y2p1h+87loP+ut4SZV0eRNFVm6tm9w2rCvY4kmVGb27sYoRPz6X1VYhw6oUYpmWVmeYoP3/IQExUG1UYcJOmv8Cjas6Eg1FvuIMaqowCHzEoEMW62qbORPiJnwYOGhasf8Y+qdrss7CT9X27NttD2U7rZqK/00TfSYgXNWPq5bnxcppTijVxXYIixUoLUz90pa2fCkKxiXUd0syB0bLO96c66+/oMqeuctaRmsR0sUe4TGFOBPNVr0QsvRPisFJJYcaBHAWnVzckbMTXtHXt8zcrZb3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFO+RtQ02eu/4OqQJ1ctE7VlOjpU1GGP877p9wzaB7U=;
 b=mkaANRhhkXAXS6g0gc85b72FHhNkaqEQSUkyjq/OMFfWkx5Q3mNw44Xqev/lMaB9RREjg7VG7YKkrCoS/xvDV7UIcWJ8i0yDMwa9UrBMYUWFCmjC+SFfHnaNeWyaDdCFDa7uGQSSpATZ13m8q5FFqLZPi9pfC1SCl30Ct9s3blgBFGsveujuu7S8Xe8F57gexaQMRiOJmmq2y++nwgEQgtqLqZ7fgrxmTFoSJaQjgEWTamiyA6LDx/HkgledSlZa74+3HrGYN/HpiwW0JxHHa7uu+5fjGAgffap6TXjs79KY8kXbKdNYGtZePypI0AaCvtulGT410ifUau3bhT7qWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFO+RtQ02eu/4OqQJ1ctE7VlOjpU1GGP877p9wzaB7U=;
 b=nkBtySFJlWQvKxNDgxIbM0KMRcCVJOIEKMsGdKT/V/mhGQ0w/8fZe4oB9LFCPsU0XvcwqLk/IHGwO6qUq2EU1r6uQsf7Ml00jh0siWK9nyys0oz+70i0o4w93bMux9W1Tlf5WVdZOD2qbu3y6Iu7DU8kGVesHVa3oqMSkx/X1hY=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS0PR10MB6102.namprd10.prod.outlook.com (2603:10b6:8:c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Tue, 11 Mar
 2025 16:44:29 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:44:28 +0000
Message-ID: <0d6e9836-328f-463d-9db4-c7fa57196781@oracle.com>
Date: Tue, 11 Mar 2025 16:44:24 +0000
Subject: Re: [PATCH v2] vfio: Add property documentation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>,
 tomitamoeko@gmail.com, corvin.koehne@gmail.com
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
 <995ef2ed-a5e0-469e-b780-6800f26d7b22@redhat.com>
 <6985a62f-a091-4087-887c-361570170ef6@oracle.com>
 <8ac4f034-3e68-4c8a-9a63-9eeacc0de113@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <8ac4f034-3e68-4c8a-9a63-9eeacc0de113@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1f8::6) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS0PR10MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2918a85b-ed1a-4e30-909d-08dd60bbfd96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUtrZkpDL3hKak9DVmh3eDIvK3pyT0ptcWZPMVR3SXplRnFIS0piWW41Zmsz?=
 =?utf-8?B?T0pzVVlVYTVMYU9ITU14dGRieUEvYUtuSmpPR2VDcjg4b2QraW82akFrT2hx?=
 =?utf-8?B?K3lJWlphK0g0SUpiM0lIK25uUWVHMWlIQjMvWlNsL25xSlk0eFZtbmNsdGZy?=
 =?utf-8?B?eEhGaWdBdGNpU0tvVWVaSTBEeGkwR29FdFRJV3pIaTZBTlpnUjYzTVdWZFIr?=
 =?utf-8?B?Q2xjSVE4L0dETWJ3TTVtOGd6TiticFMrTzVpQ2V0YmdwWm13cjMvaW81UzBN?=
 =?utf-8?B?ZDh5R2ExamwrVnFCNjJkYWpzam1SakppRUVKWWtnVXJWRU5VVVpBN3hsSGJY?=
 =?utf-8?B?S2s1K1RiaGt2TU1McDJERzNvd3ZFWWtITlhCclg2VEZIaTBPcHVCVm5LaWo3?=
 =?utf-8?B?a2E1dmRWWTMyb1htMmNnZjJUaVFwYTczNFgySUUwc1VITnZSRDFzOUxvdWp1?=
 =?utf-8?B?NWsvcjNlTUFtMkh6cUNEVWpFRkJ0OXQ4Y2g4MEdZSzRqcW1RRjlUQjByak5C?=
 =?utf-8?B?dzd3dkpOQTRzbXJSMjRsVzhMa0NIRVp1Z1NPMFNLcHBTV2QwdmVpZnNDZjZn?=
 =?utf-8?B?QWRvSkNtYnlDenc0aWE0bFlyZjdkOXgzSisvZ3Z0MEI4ZnVuYk5YcGdtMi9k?=
 =?utf-8?B?S29ITG05T3ZPMklTLzIvRXpla1c4UTJWRm1vS0JsME9FanFHV3BtOEk4aG13?=
 =?utf-8?B?ckFnenlYOEdrNW1tWUJYZENCbTBMaklXc1ByVDlwZVVzdnZGZE1vMko4Z1c5?=
 =?utf-8?B?MXN2NGc3VDRYWWNzNnhrUzRiaEJ1UHUwSUd4SHl4SUtscXcveXFuSFVHQ2JI?=
 =?utf-8?B?NGRna1RtU1N0MGxGc0pmcmhZYTFmOVV0aDVST3JWYkZmRWxUcnB3bE1lZHpM?=
 =?utf-8?B?NmhvTjNWbnhuVmh1WkxYREF5QkNSUEJrWlFhWU1BOXFDaWk0cXMvTE4ybDRs?=
 =?utf-8?B?bUZmNzQ4N05RL2N4cGdOWUd2dmxERWVTK0pNb3h2VzJhSVJuaFpkMDdLMDF2?=
 =?utf-8?B?SXdCaWJlN2lvSmlKSzhwRE5lNStRU2E0N3IwRGRjZ004UUowRlBrZDBYS05l?=
 =?utf-8?B?a1E4WXpHNmtlSzZPZ0FkQWdyMGNMRUtNOVpxWjB4bTJBTWg1U3BJeDFkeS8r?=
 =?utf-8?B?OHByWUh3MTlKRk1COEMvajJDQlFmanRvWlA2NFRRbGRwVmkzcHZnZm1pckdY?=
 =?utf-8?B?YStoOVZ2djR2VHkrU1psdmllL2dOcXZOcXFPOHAzSjBTRURoYVVHc2pPZmJo?=
 =?utf-8?B?RExYcFg4TWNCNk94N3FFZm1xYnFDdmx1alpIVmJPN0JtZkRCU25LYjQ4UU10?=
 =?utf-8?B?T0dMTUwyTGtwNjJBVmh6THY1T1dhVDFVeEQrZG9Sd3BkY1YwSGM5WWtXSWlN?=
 =?utf-8?B?elU3UzZ1S3F6cTZPTERuSjFoTjk0UDN3blJzcFRDUnR1WkNZUXF6VTMvS25i?=
 =?utf-8?B?aWcvMGxUTjdDNCtMcG5XY1JJK2lGdnNwbVhKZjJ4bEFLMzRRQTJmR29TNVNZ?=
 =?utf-8?B?a1FyV3NqU2tmMjFXTFRUOTFGd0phRkhad3FSY1VVMkN3QTU4ZmsrQ0xyQ050?=
 =?utf-8?B?dXcvZEx6WXlnZGczZFZjMDRxdVIwdGE4dDFyMHppSThDMHVwY1pYanVNMXdr?=
 =?utf-8?B?UEVGdG9qOWNqZjdjS0NaODRpaTNtdVBNc3dnKzFHaEhWZjRaOVNiTnc4bHdy?=
 =?utf-8?B?STVaNzlocmhObTAzNU9kcjQ2SkJQeUh5VG1FcXVSL0tPUHdwSWVJbWlIUDI1?=
 =?utf-8?B?RTVyN1ZlMmVYM2lTZHFkdXNqMHVUQUdLbWtWRi80bW1XekdqdVdZeWtqM2JC?=
 =?utf-8?B?Q21ERVVOdlRrMyt0YlljTEZMNGxCWVZaUG1pY2lZYWF2cm1sZlZMQ3NHUHQ0?=
 =?utf-8?Q?B2QqCXgEgmXKj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE1EUXJGd0ZhWGIrd2VhS1JqeGk3elNsdnAyZGR5bnlMdW1MWDlWQ2FEM21y?=
 =?utf-8?B?VVlSYXBrUW1ORnljdnJudWU4Y205L1hYK3paL0lpM09aU3M4K00wb3NUbk1w?=
 =?utf-8?B?bW5Pc0hXeXJwdzBXVUVPZS9ldXBJeU94VFZjb0R3aVdUTlp4N0VubUZkdnNU?=
 =?utf-8?B?QVNqUjUySlZWM20xRmh0OU53bkIrQkFHOGJDdnV3Y2pHZ0gyUEtEam5FY2h2?=
 =?utf-8?B?cFZPaVdsekhWQkxldnVLVTRGdzk5blVJTzFKR2hqMWFkR2hwcTlsYU5QRXd6?=
 =?utf-8?B?aFhtSkRRNXArL09vamVhNmlpTC9OUitSRk81Mjc4dE5KbWdwRnY3Ym1uVTFw?=
 =?utf-8?B?cEJJK2VrMmprUU5hZHZLYUhhODFzM3JEaldSNmVnYkVoS0RSSVZRK1N4WDVP?=
 =?utf-8?B?ejFHTnZKMTdXOWN3Sy9CSSszcEt5RlFkU1hWZldQcmIzNTVyK1JYd0FoU3ZL?=
 =?utf-8?B?V3h5eVM3WUdkRlBaYXhVeU43VmQyQldKMHpPSWNiNUY1ZUZ6RjZPZHE2TWsv?=
 =?utf-8?B?RjZQSXkxTnUrZmY0QlB4ZTY1SGVBRDgvNGFUdkpPaVF1Q0t0MlZ3ZjJZZVF4?=
 =?utf-8?B?N1pGQ2JMcElKYk54eHY3MFptc25ncHhscThCZE5QVDJsdEIxRFgzZ0hYU2VL?=
 =?utf-8?B?OUUzRlE2SUIySDVKVkNYY3NPcmNVdERHMElJWkJ0N3Z2eUZleXhoQTYwb1Rn?=
 =?utf-8?B?TUtEaXA5RTRtdTJ4T3JOcmNNNWxpZ3JKVktVa2hkUVhNdWtWSE9XaGhJeTY3?=
 =?utf-8?B?YU9SZ3dBVk5WMktleU5VS0V3Wk15emNPeWxEalpJY2d5b1RyNzN5L1N3dmpB?=
 =?utf-8?B?VlZVVUxleUYzREUrSHZRN0d6eW5tTFNLamZqVk1qYmVYc1Q0REdPWTV2VUVW?=
 =?utf-8?B?SXJuc2U4a2xRYW93SlNqZjg1OGM4c1RudFlRQW5rTUlYVUtwa3pjbHlYcWFB?=
 =?utf-8?B?MWNYelEyaHUxNmhOWng0cklFVE9EM1dBNUlpWjRGd3lFQmRTSGFzYVY2Wmdr?=
 =?utf-8?B?cGl0VTNnU3ExT3p0cXlMY1p0N0R1YUE4OGJRUjZkWEdFVHJvL0x2ZGIvb2Vj?=
 =?utf-8?B?eVA1SzcxNUp6UnV0dTdQSjYwcDN3UmIxNGxnU1ZWU3E0VXdoUEx5YkVJUldj?=
 =?utf-8?B?eEJGT0VaMzB5RTk1VFNoRnM5ZGRIOEd1S0VaOWxnSk5jaUZjczlIdDVxS0Zh?=
 =?utf-8?B?Y0lZM204bDd3c09GdXFkUlFXZlRqQTl6cGNtRGM5THVPZHlRTE1YU3dsd0N6?=
 =?utf-8?B?bTU5cmFvbTBCYW14akkwdnBnaXJmaXdSZ201Uk9TVnd0NlcvR0RXZVNkb2c0?=
 =?utf-8?B?TmxiUTcreEtiZG1MUlRyaksrMlhabml4QldEWHpscGpxbStNYmt2ck94bVl3?=
 =?utf-8?B?VFpvbEEyK0R6bTRRS0dvNk9RWTEyckJOYVplU1lReWpnWjhZK05xbjZhdEc3?=
 =?utf-8?B?eFhXL25mTmhuMVRFSVZQaXQvUlVhdHN5RGQ2UWFiL1IyMmhXdFgvUnNXanlW?=
 =?utf-8?B?T3hzV3VTOEtiZkVOOSswc3M5aFpabmJGMGVrQlJwZ0pVMzA4VC81QlE2dVlK?=
 =?utf-8?B?KzdTOHVRZXAwSzlZdldKUnI4MGtoYzJKVlBUa1pKNUFwQURFTk15T0dTSXpo?=
 =?utf-8?B?MyszUERCeFlYVFJZTHhlTFpJaTIxVWFzalZRc1ZtNHFZbmkzZDk3dUl1d0pQ?=
 =?utf-8?B?OUIzWXhmUFlrb2E2VDBVUjh3VUNtK1JmekFXbHd3RFZDaHRob2MwMzJ5QVVV?=
 =?utf-8?B?Zi9uVFl4WWV0NmFXTFNVSlA5M0l3TjJXNVBGZWszdDNCUVlMTDRrblM3RVVk?=
 =?utf-8?B?OHFLS2ZTOWp6NnBUd2hiM2JMMEEzK29pWTRYUURtZ1Fnc0wrcW5DaytpMXlV?=
 =?utf-8?B?SVdzeWVSdWNSbnpaVk5lQlhhWnR0UVc3THNOMG8vM3dJZnFPTzhSbnUyNEVU?=
 =?utf-8?B?cG4rRnBUb2lMdHVjUXEyaERwSDB1MEROSG9nSjgza29zUlBWZytyL1A0ZHNz?=
 =?utf-8?B?cm52cmkvUUsyOUczSmxxeGpPRTVuWldYTzNhWGxNaVFMcWdGZUh2elVpRFE1?=
 =?utf-8?B?YjRWM0FPRzNLQ01YQnNraVVuRXNkaVJ1dDl2NG9aLzBzNWtYeEhvRTI1NjNh?=
 =?utf-8?B?UjdzMXVOU2dEOS8zM0ZCaFJSMHVYS2J0YTN5T1ZYTjlPUENseU5FVjR4ak1J?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1Z7pDxam8QhNVKT6WeFYLnKkAL3BwYZlgphZM/vMsj2kaYaLSdbPTmNXJWs+n0+YQLDcaphaTWcuq7Ilwa/1qRmUcKxolrNNM1iA8U8BWlvYdWNNTc45o7W/WiaGZuEVGK6xcrjdG7rBgl8kkF+0Qchr1gPylRSXDVd0ZxoKysecedaDlW9vS2Kk0jHgYn+9pf4PkAhdKr0XHNnGb842mP7DXDl/SKBUPOq3GmtxJffJj/X/cGr7DPGiyQ4nYo6N34w2huS8NDzwNTrgLHMdc6PxRvHoXuyKQbitTJnBG83lrhnRHFNhcqAYk7wP/HZTR1YqdTs7m6iq1ugCw2ermbSpTF82oJGxh1xUs0t4GaIp+DD+XfT4odHrrX+FZSXloMsQgp3/CB/vpQWN7nMcWbVYhayU03i25yEa0TePA7HYyEr6ikX3iSZcRfL/GCgsDlUdSmlCoNM2ppTCjRMABNgCMSuAFkA3SOh8S5n++eSWMwYMJnEpBoi7drQGy1NBkhzRRDdNG0b9CKidKTcIy29ipO+f/RTtxdIokz1QSYJ60H7OE7JQH2egMmhPUlTqgRc9qFmwUbsHcBZqgHVlvta7rTySXlHBVacCQZCUJjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2918a85b-ed1a-4e30-909d-08dd60bbfd96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:44:28.8994 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsLMtga1c0OSlv7COFrqBCNvW6CorIDgoh2skzW8X7L1x0RxWmEuiDdlxvHgp3cRMe1wvGSUQuSpQ90vKS8h2f6N+HYMr0aPMAx5bD1DFOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503110106
X-Proofpoint-GUID: DI9C9vglQI-D4EsOfRTcva6GZNo2xaJO
X-Proofpoint-ORIG-GUID: DI9C9vglQI-D4EsOfRTcva6GZNo2xaJO
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 05/03/2025 13:13, Cédric Le Goater wrote:
> Joao,
> 
> On 3/5/25 12:16, Joao Martins wrote:
>> On 14/02/2025 13:05, Cédric Le Goater wrote:
>>> +Kirti
>>> +Joao
>>>
>>> On 2/13/25 22:45, Alex Williamson wrote:
>>>>> +
>>>>> +    /*
>>>>> +     * Migration support
>>>>> +     */
>>>>> +    object_class_property_set_description(klass, /* 5.2 */
>>>>> +                                          "x-pre-copy-dirty-page-tracking",
>>>>> +                                          "Disable dirty pages tracking
>>>>> during iterative phase");
>>>>> +    object_class_property_set_description(klass, /* 9.1 */
>>>>> +                                          "x-device-dirty-page-tracking",
>>>>> +                                          "Disable device dirty page
>>>>> tracking and use container-based dirty page tracking");
>>>> These are really debug as well, right?  They just happen to be
>>>> migration related debug.
>>>
>>> I suppose so. I would rather keep them under the migration topic
>>> and add 'debug' in the comment.
>>>
>>> Changes :
>>>
>>>    commit bb0990d1740f ("vfio: Change default dirty pages tracking behavior
>>> during migration")
>>>    commit 30b916778517 ("vfio/common: Allow disabling device dirty page
>>> tracking")
>>>
>>> do not explicitly explain why these properties are useful in any way.
>>>
>>> Kirti, Joao, could you ?
>>
>> Sorry for the extreme delay but I was out travelling for the past 3 weeks for
>> vacation and work.
>>
>> The property is marked as x- but my intent was both debug/testing and to have
>> something that allows me to select the dirty tracker between device vs platform
>> dirty tracker if something is wrong with say VF dirty tracker or if there's some
>> limitations around it. These days we actually use it a lot as my default to have
>> IOMMU dirty tracker in use. I wouldn't label it exclusively as '(debug)' just
>> yet.
>>
>> The precopy option might be to avoid dirty tracking at all and it's generally
>> useful when you don't have dirty tracking at all or say snapshots or 'offline
>> migration'. But I have never seen real use of it, or need for that matter,
>> except the early days of VFIO migration during testing.
> 
> Could you please send a patch on top of :
> 
>   https://lore.kernel.org/qemu-devel/20250217173455.449983-1-clg@redhat.com/
> 
> This would be great to keep the information in the git history.

I'll send a patch shortly.

