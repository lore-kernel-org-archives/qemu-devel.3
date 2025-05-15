Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C80C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 19:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFdxD-00064y-5F; Thu, 15 May 2025 15:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdxB-000637-Lr
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:09:13 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFdx9-00057S-A7
 for qemu-devel@nongnu.org; Thu, 15 May 2025 15:09:13 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1lmE023103;
 Thu, 15 May 2025 19:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=8PYnQPUoIZwwFL+DNLeZ0Bp0fo6iu+Yw7tDLa7Uly2c=; b=
 hbgsQI7sMo690IGW8QAd+nuGhJUFWMAGIrLGDb8Vl31Z5+/AWvU+LZ3MJ8wtg0kg
 LOWj0uYiU3deTptCbTln3KNgU6C/uhD+vVnpCQomRAhSfzcaZS0fHoimiTgaSZCL
 ciloJ5uPHKD0DLeA0aoI9dqJBDov6BtrO/8SQo7naaIAJG6yKC5Oe5NL4wCjWn+P
 60sOhye4E0+OhmT603vF0x7lDpT1fzHwCtYhP0DbaNswXdS6TLWi/0o4ZRs8vikS
 CMsNV+kd2+0h38FP1b4OwaXoJqsPNbxjkGlaq0n+L65x853hJw3akgXHUWWrj58V
 Cjb5Oc7v5BceplGSIuNTLQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccw63g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:09:08 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FHphHC026316; Thu, 15 May 2025 19:09:07 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com
 (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbt9rhaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 19:09:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X36iHdjs+Z8vTE/54bgpHlv52nam6gReddlbdcXMKJTN+ee7N8r5m1+2Fcp8S2PXtwSn4XRplkFivrSCauAziQVy0oh8M2YLU/5HosE7Z5VSC1HKNtdB+7Nh5ZXwGvcMXzVQDtQiAcZV7E5zBgsSSeaKdCz7ZwK179mCLs9jzxlOdtaC6KQCKGIzD90XzoA21ghCPY2bFZrL64n7Gs+Q4QGVo5Afh/O4WjhmOFi1sbE+7qr7YsgIwDW+ip0+RO60waVUw17g8gp+xDrcXdUKEXfievtkltDdFR5wVC9Y2TYwIgErE1/HvSjMfkj4rqCGEsoGTb/p2MbhfFOURbigsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PYnQPUoIZwwFL+DNLeZ0Bp0fo6iu+Yw7tDLa7Uly2c=;
 b=hRV4oKbnvycZm1IiLXpcImbd3itK3NUTxstThZUKtCWly+GwMmmOQWz7WiYtnCxy6c+SrmGTsGdACk8i40q8mEfcJfUF0fJQVhV6CyhrhHiDvNkZAHUYsrHwS6TbYlEYkmbOUnJ5+bv8Zov/yDH57idIcjv2jUBqXez1XnIKHvvJAQ7jab7BjD6BBzJlvLLAchuQbzBWFip5zr9VvMcWAZm+DI5BkJCvKmqjg+0BJFWXRdEMSdIcDcRlZI4tSB0f/OcLtsRWX7i8IJhf7SfnZWlH/B8vandGZ0AL/LEJjfJXRRcn15TEJ8kvVeLCPt4As4rigrUFhFosV/PIH1Y3AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PYnQPUoIZwwFL+DNLeZ0Bp0fo6iu+Yw7tDLa7Uly2c=;
 b=B5kQoL9t4pXGCYOmyFV/lMSTa5Lbb2ojSV2VtZ96Q9I73lh/sZONAK/6LusSeSUnPrgAO6tcwn8UyaL/LUEns6P9HVqelRzl7bh1yRoho1NSr6kkm5F5554WERdGUa6dKedQnmrV472JjZzOtmImFatZj+IrxxZaunxSpqKgjo4=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4450.namprd10.prod.outlook.com (2603:10b6:303:93::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 15 May
 2025 19:09:03 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 19:09:03 +0000
Message-ID: <8a5c86ea-f0aa-4b84-9efd-1ce0edb2e7fc@oracle.com>
Date: Thu, 15 May 2025 15:08:59 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/42] vfio/container: restore DMA vaddr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-11-git-send-email-steven.sistare@oracle.com>
 <0501dd8f-7cae-456e-b4d7-e80b8aaaa5b2@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <0501dd8f-7cae-456e-b4d7-e80b8aaaa5b2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0964.namprd03.prod.outlook.com
 (2603:10b6:408:109::9) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: e0440360-7e24-4c06-60c4-08dd93e3f4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Mkt0aXAvN20ycmV2RlhacXRCK3N2S1g5dm53eU5xOG1PNTAwQWZ1eDgyVHNq?=
 =?utf-8?B?Wm1tejIxckxUU0FxZ28rQkxTVE5YY3l4MzJhUTFBMXcrVGxNWTNlM1VzNkFI?=
 =?utf-8?B?N3BFZGV3ZVpIY05kVXNHcEhISFY1ZHZmSEZsNlpDdHpSNWlKdEVDYWNydXRH?=
 =?utf-8?B?MDIreVNWZ3U5emgwRHdwVlJMZHVQZWRYUXQvTXU5amlKS3ZVYW90UkhJVmJR?=
 =?utf-8?B?R21GUVRmVkUrb0MyQ2VueFFiODhvRVhqcmR3dXloZlZkVlRBZzA5c2R5d0No?=
 =?utf-8?B?NzdMdWwreEN4bTAyRW9jQnpLYkxhdHpLZ1RNamhObTFObnFUMUx4VVhuMVZ1?=
 =?utf-8?B?Z0dlZkxXd3RkZHBoSEFGWmxtY0FJUjI3dVRidnVxSWRhejdtd2RWdnZVM2x2?=
 =?utf-8?B?a2dYa0xESDFoUGpyQ000RUdvK2Z5MXMwMnJSRU5YeGVObTdEYyszRFo1NCsx?=
 =?utf-8?B?QlZ3WjdiSkVRaXdReDlSY2FjZ0gvK1l6WCs3NWtvaHBpbE42MGVTZlo3cHpL?=
 =?utf-8?B?SUVRK2JudUI0d0NIOVVmMUFsa1lVajNRT0p4bDhJSUtveUVGc3ZlOU91Y2Jt?=
 =?utf-8?B?d2NtSlVqUFl6MkFFVlp4bWpHeTJESWhKNDFTL2dVRUdMb2s1clB0NkdhbDlW?=
 =?utf-8?B?ZEt0aUJHNHpWNU5wT2l4MVF4SnlGVmZXU3ZWc0lQcmRHQjM2eTczbnMrUDR0?=
 =?utf-8?B?RWY5M2d0YnVzNXRMTGRCUjFaVHYvbHpUdFd5MFNJV2xldy9jckpVanU1YnY0?=
 =?utf-8?B?aTErYkJ1U214MVNXa0oxRGlnWFlrbURRQnlObEVDZVVpV0tpcnVScnhPMTZj?=
 =?utf-8?B?SFo3N3kwb2xGZWJwditBVWZwY2gzNldHYVoyNFhXWWgxd2krZ1JpdGh6Qm4z?=
 =?utf-8?B?cjE0Q0tmVHpHSFJhbDJnQ0dUaithSk1Sc0I2bTNxbTEvYTM2R2ZLcTd1dnNs?=
 =?utf-8?B?dG1rZ1dYR1Bwb2tOQlBmb0U3RjlMb1o2ZFJTNnNqY21haUFSdSt1cy85ZFRN?=
 =?utf-8?B?aDFnNndTK0FsMnN5VXRGZlBvUGtXZU5ubHoxVXdlcmVnYitlT0FsL0p5UGd5?=
 =?utf-8?B?UVFuV1VPbUZMOFdMVGRyajZybmdtZE9ha0JkYWdBMi92enNmYVZuQzVodXQz?=
 =?utf-8?B?UjZiY2MzNjEyMjhCb0NqaVdETmZTZHZZa3NEYjh0NHQwV0psSjhSWUFidC9v?=
 =?utf-8?B?MzlRM3l4KzRhVzF0QmI3SDJYT1dEWTNBUWhDSzlOTDdnclg1VnVrbEF5Y1Mr?=
 =?utf-8?B?T0dMQnFkd3FtQ0RjaE8vVjZYdng0TnFBRFBkNGNIRHROUXJXS2dhK3RQMlkz?=
 =?utf-8?B?NHlYMTdBeElOVUtvUkY0ZU1XTnY0bzhRb3dWUlU4bFFBanpuS3RvOUQ2bUJt?=
 =?utf-8?B?dkpEc1E3NENpeURRckpVUkI3dzlyTGxBc0FDVDJnem1zL1FmS3E0ME9UL3E2?=
 =?utf-8?B?OEZWcUNWMit5Zk5sczVWbnovbC93MGtLSTBzUkhaeUtGNDBQdCtxZnRhZUVa?=
 =?utf-8?B?NkRVcUNkZ3R1NDBHZngxNkZrY1QvNmRNRVVlLzVlcElyS2w0Sm1hWDd6YWRU?=
 =?utf-8?B?QW1TTUxQTU5vNEpnSURTOGtFSVBMVld2cFBsSldxTnNqV0ZZdmNqL0hyaTly?=
 =?utf-8?B?Vk1IUEhqSVZZTDYvdnZCS0VCV3FvSnJ4cU55WDlNeG1tQ041YXZjcjdGOVAr?=
 =?utf-8?B?SWh5ZFFBaHpiTk5BdGg4QXZYK2VTM0VNQmZ1eWo4dStuWEo0RDlMTjdxakhN?=
 =?utf-8?B?UXovcW8wRUdpK1BsNWRTTTlTcE1FbzBuY0ErS1RHdWR2Q0lpNmUya2M5bkp2?=
 =?utf-8?B?M2xvdWZvODUwNGcxYnRoM0lZQXA3a28xQWVFOVlLVmhQdGJKTWZEblRHNExU?=
 =?utf-8?B?Sy8yWjkyQzRISjhIYmV6T2d6bFkvcW9Ec1A0TVQ3aUNUTVJRNm5nTkJWMnpl?=
 =?utf-8?Q?2wxuUk8baeE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXlMSDh3REJwcWxoZFl2N1JydDRHb2VhbUNjdE5rRkNwNzREOXFJTUNBa3I0?=
 =?utf-8?B?dmt4azBESzU3L3FDRnRndjRQRWowdUdtaHA4bzR3Ky9PR3VLWEwyL2x6d252?=
 =?utf-8?B?ZHN5N3UrZUV4QlA0UUNzV3NTQllabHNXVVpqZytqOGNQd05iT25VdUVtQTE3?=
 =?utf-8?B?RUpTL3ZsbVhNWlFzTk03MElWcGJuN0tQcFJRKzZBQTVHbkdGdEpPYXgrMFcw?=
 =?utf-8?B?anFxTWRycHBjZVdpTFl1SnZOVjF3TXdsTEZoS0hjd21lUzBpc3dwUy9EZ0t1?=
 =?utf-8?B?SHY0Z0R3VVgxalJPREt3VDVmUTh0SkJPZUNBcVdLY2w5WFVGejZsb0IzL0Uz?=
 =?utf-8?B?L3h0REhYU2NBc0JVTDY2SUk2SXhRMzNReTZ0QlMyakliMnJlY250RlhMU05E?=
 =?utf-8?B?eUtVZUhnclc4TmRwMDJaMEl3aXFVaGhPWUx5YmtFK0tWYWtNRlZIWDBHcU5S?=
 =?utf-8?B?Z28raVMvSjVyazlLK1lJTEcydkVjUlpmczFRWjg0Kzdhbi9oTGRBU3p6TG0r?=
 =?utf-8?B?RG51YkQvS2xQTlVzYWJkMlRDVXV4UVhFQ2JzY0RpaFZSMkRzdEN4Nk8yYk4x?=
 =?utf-8?B?VSswL1BTOFdpbkxJa2VwYkRYZUdEcHluLzZ5cWQ1dUJXTzl4RjZDOGxIUSt1?=
 =?utf-8?B?dUZsZzVIKzFYQktyOXlLZ2U1bkV3cVZUUnVkOXlLdUZvQzEySEk2dVhYR3ZQ?=
 =?utf-8?B?aFM5bXRMb1hoOUJtR0kwM0JnQ0EveE9nM1FZM1duamFTZmo3Mnp1T09yQUoz?=
 =?utf-8?B?eTNGRkZFT3NpYVUxZ1NWcFZYdVdYRzBYU0tZVncrU1VzYVVKRWxhZnVlNHNT?=
 =?utf-8?B?K0hwWkZDUjVFbVJ6NS9RYlpDcmh6cVoyeE0yZFBvMmlCa3BrZXZzbzNyNW1p?=
 =?utf-8?B?aENkM2I1NHNIdkpSaTRvcmFWTUZlS3lUd1pBRE82SjhLbUZHRW8rMjhDSlVB?=
 =?utf-8?B?Yjg1TGVxU01nMEtWdmtXM2Y5L3hsOWExUncvczlVZ3Z6eHRROEU0eURrRGZs?=
 =?utf-8?B?WnVJMkJXOTQ4ajNLajdBWEZoWGxwUHFQK0MzSFB6SU80R0lKS1Vwc0kxcWI1?=
 =?utf-8?B?Y0U3SEp4UHRqajZ6NVk2NjM1NXBLVXRPeVp5QVJWSFo1NWx6bHdmV0wrN29R?=
 =?utf-8?B?YXBRR2ZtcXcwY2RSQ09RQ0tCM2h3OU9Sbzd1R3lPdXZyblRWU2t5ZlE0Y0RK?=
 =?utf-8?B?b0NDeEFVbmlFaXdsNTNNamx5MllmVmRLVThZY2pDS2o2RVB0eVc3Mmh4Ykli?=
 =?utf-8?B?Y1Yya1JLRjlsVWh5WmYxc2wrMTdDd0dnUzJLVG9seVNxUHNaQ0NMdWYwZzdq?=
 =?utf-8?B?MktHcE9PUlhIamMzS1MxVENFZ3NkSUNybHlwcE1oOHBhZG1zNmozU0FHMzB0?=
 =?utf-8?B?c1JSN3FoL1NpbTYyclBuUmZCSTVveXJ2VW5HS3Z2TG9xenNUSUpVcmgyYUVi?=
 =?utf-8?B?d0Z3SVNYQ3ZsOHFsZVV6ajFsUFNmVndvYzhsT3AwbDlxVHJTM2ExclBZb210?=
 =?utf-8?B?bU54MlR5aWJjbm1ZWG5aMENMRTVDdG5YTklzcyt2MERNMUJNRUhiSXdNTHN2?=
 =?utf-8?B?M0xmb0NpblNaMFU0NmpFaTV4amlhem9BclVEeUxWTis0QWxsc0VQdE5TNGlU?=
 =?utf-8?B?dGhXQlR2OGFWR0YvUFdvS1R5YXFoQmZrVmc5R1Jza0ZPd0xmT0M4N3ZyeU0z?=
 =?utf-8?B?WGErRlMwVExGandFbW1FSzNqbnJJSmtTVzJSL3RVbEplYzFLdHhobTN1U2I5?=
 =?utf-8?B?UTNidGkvM0oxb3o2ZUNQTm9GYjJBd0Jyak5BQVhUVkZIVVVFSWxYMEZRdjhn?=
 =?utf-8?B?ZzQwZDNVMk8vQWRCV09oNVg0RTRveTdsSjBaT1p2eCt0TVZlZXVxT0Y3VTJV?=
 =?utf-8?B?T3c2dVRSWjMvNERWK2Qzd05MZjMrSVJCQnZwdlVjZWtpRHhTSVEzVStNZ1h0?=
 =?utf-8?B?cE9TejNsVlNLMnFDUTc4Mjk4ckNNQUxGZ3A1WFlvNXJ0TDd3VU1FTzhQSGZG?=
 =?utf-8?B?VG1GRGNsZWN4S3ZFdHlKMnN5QnJqK0p0QWZkcnN5cjNVV1hzSkhKN1ZKMXJJ?=
 =?utf-8?B?dTZPcnE5cklBSHZFQllTQTMrV2FLZUJHK1NyUHo2c2srK0liWjBDVmtkL3Zo?=
 =?utf-8?B?TWdKZXpFTTJrS3NxSjhacTBZSmIwZ1pKTWQxTWxlTkZubE9uWDJYWDZlR2M1?=
 =?utf-8?B?eWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /HG9nQzMWSu+DqPHuNr8IL6+a6E72RpPUQbC/A9qKeP4Wa+NeglwplK6SVjabrXZoWWfo9a2uFwbP134f4o7E5zHFI1YgrKIk/pP8KUGmxnWZt/+EM+4gIPFXycOMKEMFk6tgnyeVviK4tQ5h2McFfGmHZHEMuyMP6QFfkHgvXMnaY5ovYUIxEA/nGX1zc50xdf7OJS90OpCl1n5G3ZNF6pTQ4jqk+APP7YkEYhEuD8iUIHm8WXrjgVeVVuBzznIrGBuH3Gij87VEyqlVsZ51P0lRQgmW30IAzdhX6Icn949SrtiL/NjuB9cUOeDLam9/lZSI0LQFELCMgYdn6jWvnWzH48GN2/GmHs+CU2G6nWTj0NZIVaQ05QcFA6lhQcuD3w4bvfh1Lh9FpM/+wRGbrZ1Pvaz/FExShsRhZFvVYLhxhbQjL8PtDgqf00sl/R3lqYahxwQ3a7X9pmwepH31eSLtGQj6SNHRUoZTCRyz5Rjl+AObCGnY8xha7PK0PB899Pyfup0slfOsRKAZjycWvz42ofMo83wWyr+kIoa3wcyIPI3jBsO83IxLEvpm6J/gpC+s9r9svbttRWXaqR765sLR4HUpcU6FBQnjyijxQs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0440360-7e24-4c06-60c4-08dd93e3f4e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 19:09:03.3432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PHkAT7p/W0KFtYRD4m4COoR66V8SJqAvRV3AH2SpAuOFck/JAbPUGbCSSUYMiauwUo+f5s3t/dYOGxCQh7NEpX9udVbjhwphe88BGPgC/uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_08,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE4OSBTYWx0ZWRfX+f6w7hrmZdCQ
 b2uSDcWK5IC/JUSY6w0eDdL1hTEPn6f0iqtIhxiRZ+sHHAO3/xuDExzwbXx5SBfPqMZQLBlpgDw
 5DUfMJhCpB7p5Z70m52zAnjC/A2y2/qi0CIxBPernCFGOWOoikjZx2KkHxhjo2Q35VgUuWOCwgX
 ytZIR2NZLGJJYNX+vake/7L6zH3E++ytbFYuR7SmNYFExCXO9cHoxI2C09WidP60ZBg4+OkSCFr
 9Q/AmCJGnoH+Gp3Xx29JRLHEBarkL+mGcAPTTJXIJ5TnQUSI2St7ugJ+8LIO0cCe6ib+LEkFZF5
 VcX8YTJM725c7X5UuzRE7syIdVPq7tKwVZz/+3WrSmbc0U9cbkEWzCUVX97PP64aPO5ekpvy8Go
 LCj25sb5Py97rvM9WDsohhjusvneOQ0ThEgs1QPfHY4y+Uj0coEZsINMlijzxrJhgBWGEZIC
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=68263bd4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=pfo2m88UJNmgxuZIXMkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:14694
X-Proofpoint-GUID: y2LzBIZ41qnh4YO-xjyXEP4-utpYom6I
X-Proofpoint-ORIG-GUID: y2LzBIZ41qnh4YO-xjyXEP4-utpYom6I
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 5/15/2025 9:42 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> In new QEMU, do not register the memory listener at device creation time.
>> Register it later, in the container post_load handler, after all vmstate
>> that may affect regions and mapping boundaries has been loaded.  The
>> post_load registration will cause the listener to invoke its callback on
>> each flat section, and the calls will match the mappings remembered by the
>> kernel.
>>
>> The listener calls a special dma_map handler that passes the new VA of each
>> section to the kernel using VFIO_DMA_MAP_FLAG_VADDR.  Restore the normal
>> handler at the end.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/container.c  | 15 +++++++++++++--
>>   hw/vfio/cpr-legacy.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 61 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index a554683..0e02726 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -137,6 +137,8 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainerBase *bcontainer,
>>       int ret;
>>       Error *local_err = NULL;
>> +    assert(!container->cpr.reused);
>> +
>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
>>           if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>               bcontainer->dirty_pages_supported) {
>> @@ -691,8 +693,17 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>       }
>>       group_was_added = true;
>> -    if (!vfio_listener_register(bcontainer, errp)) {
>> -        goto fail;
>> +    /*
>> +     * If reused, register the listener later, after all state that may
>> +     * affect regions and mapping boundaries has been cpr load'ed.  Later,
>> +     * the listener will invoke its callback on each flat section and call
>> +     * dma_map to supply the new vaddr, and the calls will match the mappings
>> +     * remembered by the kernel.
>> +     */
>> +    if (!cpr_reused) {
>> +        if (!vfio_listener_register(bcontainer, errp)) {
>> +            goto fail;
>> +        }
> 
> hmm, I am starting to think we should have a vfio_cpr_container_connect
> routine too.

I think that would obscure rather than clarify the code, since the normal
non-cpr action of calling vfio_listener_register would be buried in a
cpr flavored function name.

>>       }
>>       bcontainer->initialized = true;
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index 519d772..bbcf71e 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -11,11 +11,13 @@
>>   #include "hw/vfio/vfio-container.h"
>>   #include "hw/vfio/vfio-cpr.h"
>>   #include "hw/vfio/vfio-device.h"
>> +#include "hw/vfio/vfio-listener.h"
>>   #include "migration/blocker.h"
>>   #include "migration/cpr.h"
>>   #include "migration/migration.h"
>>   #include "migration/vmstate.h"
>>   #include "qapi/error.h"
>> +#include "qemu/error-report.h"
>>   static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>   {
>> @@ -32,6 +34,34 @@ static bool vfio_dma_unmap_vaddr_all(VFIOContainer *container, Error **errp)
>>       return true;
>>   }
>> +/*
>> + * Set the new @vaddr for any mappings registered during cpr load.
>> + * Reused is cleared thereafter.
>> + */
>> +static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
>> +                                   hwaddr iova, ram_addr_t size, void *vaddr,
>> +                                   bool readonly)
>> +{
>> +    const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>> +                                                  bcontainer);
>> +    struct vfio_iommu_type1_dma_map map = {
>> +        .argsz = sizeof(map),
>> +        .flags = VFIO_DMA_MAP_FLAG_VADDR,
>> +        .vaddr = (__u64)(uintptr_t)vaddr,
>> +        .iova = iova,
>> +        .size = size,
>> +    };
>> +
>> +    assert(container->cpr.reused);
>> +
>> +    if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
>> +        error_report("vfio_legacy_cpr_dma_map (iova %lu, size %ld, va %p): %s",
>> +                     iova, size, vaddr, strerror(errno));
> 
> Callers should also report the error. No need to do it here.

This function has the same signature as the dma_map class method,
which does not return an error message.  It's existing implementations
use error_report.

>> +        return -errno;
>> +    }
>> +
>> +    return 0;
>> +}
>>   static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>   {
>> @@ -63,12 +93,24 @@ static int vfio_container_pre_save(void *opaque)
>>   static int vfio_container_post_load(void *opaque, int version_id)
>>   {
>>       VFIOContainer *container = opaque;
>> +    VFIOContainerBase *bcontainer = &container->bcontainer;
>>       VFIOGroup *group;
>>       VFIODevice *vbasedev;
>> +    Error *err = NULL;
>> +
>> +    if (!vfio_listener_register(bcontainer, &err)) {
>> +        error_report_err(err);
>> +        return -1;
>> +    }
>>       container->cpr.reused = false;
>>       QLIST_FOREACH(group, &container->group_list, container_next) {
>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +
>> +        /* Restore original dma_map function */
>> +        vioc->dma_map = vfio_legacy_dma_map;
>> +
>>           QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>               vbasedev->cpr.reused = false;
>>           }
>> @@ -80,6 +122,7 @@ static const VMStateDescription vfio_container_vmstate = {
>>       .name = "vfio-container",
>>       .version_id = 0,
>>       .minimum_version_id = 0,
>> +    .priority = MIG_PRI_LOW,  /* Must happen after devices and groups */
>>       .pre_save = vfio_container_pre_save,
>>       .post_load = vfio_container_post_load,
>>       .needed = cpr_needed_for_reuse,
>> @@ -104,6 +147,11 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>> +    /* During incoming CPR, divert calls to dma_map. */
>> +    if (container->cpr.reused) {
>> +        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +        vioc->dma_map = vfio_legacy_cpr_dma_map;
> 
> You could backup the previous dma_map() handler in a static variable or,
> better, under container->cpr.

OK.

- Steve

