Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCE4CFB449
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpoX-0001v0-KO; Mon, 07 Oct 2024 11:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sxpoV-0001uq-Iv
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:38:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sxpoS-0001T5-Pw
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:38:23 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMcdY005099;
 Mon, 7 Oct 2024 15:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=PXVVGh/6sPSerJyBqufT6ZIDq9lQQZ9QE+KexYpSCg8=; b=
 RnZkfz46JHcXK3RGUjAQMt2fEqM5peG9FBiCnY5LYsi6m4tdv3hI6wdBqmtYG8Qo
 a8Qk3jlufwJyE8IwSlMSGTRnNp6ulS52TsSMWVYhN+PNAR+FcUnYQQV/iDQ2mbgy
 kmcWkBWTOOuJlQ8SBgSaQ6URk+07Z/qciteyVJNFV/x/rWnXwxnR/gQZuvrQjh6l
 9Kth1vGvRRfLMALeulv+/SXcFo7XrkzZowkOg+P9R2ZnSgjocYgNbyFm763PbXyM
 t9UbkJa+Uv9wcvlPxYYZQ6hCLAoysbW+k3fvUWYUQSOv+N+OZ1dbtOcWR4X0Mve8
 vZWb/QwNeeNtEP8KZw2AQw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 422yyv3qt6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 15:38:16 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 497EBZYf003051; Mon, 7 Oct 2024 15:38:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uwc7hcj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 07 Oct 2024 15:38:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oORJVx0Cbz7ALUxSW4bwxpTteM1G9StKzhNEiKRdvHs1Qcybhsn2Knup161Lem5y4UC9FY9zSZ/WzWXrp42aI01QMIxJFa3AIAGKQkUVKtkfNiAJq/0M0zO9zP59nuH/8FFbXH8Zk6q2uNj1Qy1lbtBI5bxmpYYy3WwkTI/vIMx2A5T7sJRpLPhU2hW0r477+ppfDgUSpSTVgaopwDIQooTr/46Wr4tHxbhI73tmZvFSfwh2+BQUVxoI4IpYfqkIXyk/ysCqI3pPz37FBN56h1weFic7xWFl6TSM9OrXWkRzKNB/KryU1RD9U1090WQd7Q39NpsgbhYi2FsZMJWMQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXVVGh/6sPSerJyBqufT6ZIDq9lQQZ9QE+KexYpSCg8=;
 b=hevf/MRFBngMMuz9KP+K8J7vNmt3IzxRiAHWbbt4kDlWLUjlZ4lFfk7rBx+wArDcPoVskXCqPT2DJNW7A1kKiAVagXb3/3TN/rEutD4llN1c6HyYzOk8NtGOruKiLvtrUdeWpOGOyKs9GqxUwsvccpVRFX4yzI15CaPiuGNZ2tGz9e64F+HHEXL8Q1r/r8MweuQOXnOFH1Mp182AqJ/8CfdO5D4c2Jz2mg+INZj+ZfIISd79lTQh586WhN3nE0TfdWYiBNfKmhB1Ks032cx9MBW0xUo1PKQMTs4yUyVD9QOzQYyNiPIlSZt6aYiTKsOvmszU1zUeLtuJKplf6SGO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXVVGh/6sPSerJyBqufT6ZIDq9lQQZ9QE+KexYpSCg8=;
 b=bdzrQzi0EKMe8fExZuJvXnoGfHGa5qfWQHQrSA5j26mmvQZzAzmP7EIkY2wqStChzdSMcSj4qkgs0r7smONmLpjzVvjTq7XWKjvPVnxo1x0GvDq8N3CDpC4csgXiTJimQZ4JG+RHfB81NJzZaCW43yPn1Gr0ePkmo8tfPS1JtDQ=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CO6PR10MB5650.namprd10.prod.outlook.com (2603:10b6:303:14f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 15:38:12 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:38:12 +0000
Message-ID: <b229652a-f651-4ecf-adbb-d8e4a45973f4@oracle.com>
Date: Mon, 7 Oct 2024 11:38:09 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0173.namprd05.prod.outlook.com
 (2603:10b6:a03:339::28) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CO6PR10MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 6356f02e-6697-45c7-f012-08dce6e60d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUxEUHRib2xkcVhPUjlFYU5yV01lejNBdzZua3FiVitUTWtiWTRnWG02NjJ0?=
 =?utf-8?B?U2pkZ1REYm1KaVhRbjc0cC9sWmxJdUJ4MG80SW5XdEJtNkp5UVg4ZkhPNm9N?=
 =?utf-8?B?elpMU1BheWVoOFE3STlVbzVQMWtKcEYvNXVRb1JKUXp0aFREVHFKcDhQT0Ix?=
 =?utf-8?B?eFY3UXpFT3E5NUp6c09lVU8rdWRvbjB2Y1FKVkMxUmV1Rjd1eEFBUVVSa3Np?=
 =?utf-8?B?WTFFbkJRb0dXd05JMzFnTzN2RUdtK3FiMHkweGpvamtVbGdSMGJNdE9lRjFm?=
 =?utf-8?B?NklEQmNPQUVqSlZqbEVhcWlmdXJQL0pyQVhlakh1QVJhbGhGZWg2UkFVTFB5?=
 =?utf-8?B?cFlqdW94QlZNZ2N1akNuU3BsNVg4aWgrajliaEJLSWpETytaRjNKMmQrcTRX?=
 =?utf-8?B?YnNMQU9LZHVsdlA3UG1KTlZTcE9LbVBnMUc4UlVDK0N5MkR6Q2dEN3lsVmt2?=
 =?utf-8?B?N0QzL0RxWnE0WDlMNnNFRmErNG9nV2dUZy9pYzFOSDFzYzFoSnUzNGdUcUcy?=
 =?utf-8?B?eTBsUmUyVlVNaVR3cTFZS013VEEzNGpGZjBxOGdJeXZaUHhaUDRJelZnTmVY?=
 =?utf-8?B?REEzb2o4SGFJOWdxc3E3MEs2QStzeU9HWGxNNUYrOENQSHlzbWRCYjljazBa?=
 =?utf-8?B?N25XL3NiZ3FySE9UL2VhRVcrL2k4VTB4S1hkZWNvbkZublpoSVdSYlFTVjNa?=
 =?utf-8?B?SkpwRStWL3R3VHlxdlJBcURtVlpWS1VxcTlEemMwRUJoM1ZqVk5ldDEwWmNL?=
 =?utf-8?B?YThuZUptRVc2dVM4bjhGbjVDS0FqbXg1ejVPaE1MUzU5cTYyaFdLN2FubkpZ?=
 =?utf-8?B?YXJWaUpHamp2eUo5U1pwYW9lNmtOQVdkR3RXNjNYZHVNNFVqSEdwMm9XQ0NH?=
 =?utf-8?B?RE5HQkdNUWg5eUYxL1luMHZqVDJpRDl4eGMwQ05zeHFmcnJCMjBueTJHN1RR?=
 =?utf-8?B?VEVmcjRrMlRZVmRLbjdkOXhLTDNHcUlSVWkzaHF6WU9ZTW55aElkeXpOMTA1?=
 =?utf-8?B?aVVxaDV2QUpFYUMrWHhtN0pkRGR4QkVTanJRVUc2cUkrZk9TRXNUaFBGcXdF?=
 =?utf-8?B?NHVwVXJ3MTVPalFMV2JGc0RYVG5BTkRDa0k1MFVGS3l1amlsbU1iY09nb2hi?=
 =?utf-8?B?T2pTRCtXUFFIL21tUFlYUDJoelh0Qk9NR013S2l6NFJEQjJ0Z1AyTy9EZnZ2?=
 =?utf-8?B?Nk1sdnhuUFVGZVplY3pVOFkvWXhNZlJnWUJmcHF2cWw5M0xuSmRKbnZ2NGZX?=
 =?utf-8?B?RTVzVFoxK1VwMTIvSnpZbUtGOEhCRnY5amZkUFJsUzczTFgwTDFxUEdzMDdI?=
 =?utf-8?B?U21lSEdrOGJMQWRkQ09JT04xamJwZDBjcTR1Ymx0MXhZU1VQNXduV3lwYnFh?=
 =?utf-8?B?ZHNLOUh4Yk9GTjhSaHJWdHArdjI2MVUrRm1uMHlweUJTZTZ5M1lURjYrZThL?=
 =?utf-8?B?aU5Vd0VBZEh5ZUQvd04rUnZlV21wRjdDQklJck4rTDQ2NnIyalhRSkZPRVEx?=
 =?utf-8?B?bDJxcGs3eWJCa1d1enRTclJsamlCQWcvOGdMeWhHdHJRMGl0MnkzZXdvU2tM?=
 =?utf-8?B?SHFRZkY2M3d5dm40TnUwNUlkSS9HNExDdWd0TXZlVUVUZlRBWjBGVEl3Sld0?=
 =?utf-8?B?UUFmcWtWNUlSdUlMaXNPa0pzcCt0clBINXArYWlNNDRjTUhyQ2x0U0o3b0RH?=
 =?utf-8?B?MERRMU10MWJtL2dSVXN4Z3c1TVMrOCtnblR5QlI2RUpyM044ek5KcElnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm1wQ2RMQUNiM0s5endudlFFTWNGUVpnb05DRTQ1ZCthVGh5YXlJMFNDYzBi?=
 =?utf-8?B?TE9rUnFxbll6V3lyczlYczR0RUpqZk5nZFlkRmxtcVlEdzFzOW5aUDlLT1B0?=
 =?utf-8?B?Z0w4MHRWaDVjZVlYZnJWaFhVK0Y0TzBuVkZ3NHp2SHZVU29keE1sRktzaWVx?=
 =?utf-8?B?YTVvSU1DS0d0c0xKVkRXdjBrTE10OGNWV2hzNTh6cnJyQlgrL3ZYN0NlbzRN?=
 =?utf-8?B?ZDBTTnJDU1BNTk1RaUFwU3psdGM5V3dtM1AvRDgra0ZTMVlPcHBkd1l5VUZW?=
 =?utf-8?B?a3pnbE9ERzJMdWFJb1NWWFNMREZhVGdtZFgxMGtJUGRmVVNITCtZTThYU2F6?=
 =?utf-8?B?RzhBQjRPQXM3VzgvWDlvR2I3cE93VzFPNTdoVHZmbUdtVWhtQWgwRzBTek51?=
 =?utf-8?B?emFzY1hqbXVOUTd6UXpIaTdTM2pmMG84NTcveXVQZGxkLzhIVmEwa0N6dE9B?=
 =?utf-8?B?ZGdwVVkvdDR3TDR6TFFtZEZ5VlFMdGVqNFh6TUJZd1l5RVJZYUc5RlpYV3NP?=
 =?utf-8?B?azJwMGlqR0h3ekZwWEc2Sy9oRDllM3JGQ3o1ZWhvcVVnT0IxQmRyNDMrTzhG?=
 =?utf-8?B?SU9hWDJWclVYTzJqUEV4blo4R3ZiMlFQcGVVcnNxb2hWSWl3clBMaW5BTlkv?=
 =?utf-8?B?WUs5Q2VsY2RtZHBVMUE4bkNwK1VWSDN1SlZLMEJWQ1NwTHR4akhyR3Q1TC9m?=
 =?utf-8?B?YlFhWkM5aTJwUTgvMWh0RTZXUHZuZzVZd01ESmZGdkxpR3pDbVdjRmx6ZkJj?=
 =?utf-8?B?L0ZsdThkZGVuV3RhRGQva1IvQ0d5YlRnTVUvU1RyRU4vek8rS2lYMWdzSmc4?=
 =?utf-8?B?VHJUa3FSSjhOTWYzOHk2Rm5jckJKRDQ2QmoyNlgwSGttdzhmV2ZXcWNMR1Jj?=
 =?utf-8?B?Z3JYUmp1L3hXNlBrNExONFlNckhqVzNlWCsyWVh0YUtPb3NlMlVURnV4SDZ3?=
 =?utf-8?B?WlY4RXZ1VnZNKy93RFZVVERoYU85Zi83OThPaDhpNDFGaWY1eUNCTUMyalhu?=
 =?utf-8?B?djN0RVI0R2RGU0RhS1ZsSDc3amxzVG5pTkMrckFwY2gvWTJDa2FZcjJvNldQ?=
 =?utf-8?B?MFdPaHJPK2FPelNqc0ZPY051TlRuUGJML1luYTAzVGN1NmlxYWQrdFpvNmtM?=
 =?utf-8?B?S1A2TGdoNTMrM2lDY0FyQVBFRnp3WW1td2ZMMkZ4dVZmUWVQYXRCc0pFUlNP?=
 =?utf-8?B?K0NHZUhxWmxab2VWejRXZG5lUXVxVnFmT1Q3Q2l0NEt6SkorVzZuRGtNbnRr?=
 =?utf-8?B?VFZvZVNwTjRvTzVldUtBcTZUc3ROM0xCaGhIS0hxZ1Q4c2NWbHZpSVhidzNz?=
 =?utf-8?B?U1JKNGpycTJVOG16ckh1aG9ocjhlQjhPb1F4THhWcVhaRlNtVURqaWVyczZZ?=
 =?utf-8?B?WUs2dDMwbVh0Y0M5Q2FVSHNIRlJvRW9YeWRHNnlPTVpVQzE1ckE2MEtKQ01S?=
 =?utf-8?B?cWpEallzLytMWEZtQXpyVnlwRmtKMkpHMFV6Ymdzdno3MVNHVTdiUmtVMS9w?=
 =?utf-8?B?bk5YNU9hOUNRa2s4emd2MnBTcUZHQ1VONXNVMmVZL1Zsa3VZOE9NSlVLZ0dR?=
 =?utf-8?B?djNZYVZ0YVBtenNORFlrZ05NWVBmc0xiZzV0VGhCaG11dnBlQ21KM0c5dGxw?=
 =?utf-8?B?VXRnS3RXZGt4UG5oQnMrY2ZXaDJBQys4bmkzQnlpTW42T1U0elEyOFRudGY4?=
 =?utf-8?B?VjI5OWRaa0JQNGRUcXgrUk9GekxOay9BeUpjcFJjV2JSSFMxVHB2ZFhBUEpN?=
 =?utf-8?B?THVPbDFQOWlzaXdPNjVDZ1FLd1dsY3A4OHE1THVyYityRFo4ZGllV00yOVgr?=
 =?utf-8?B?VmorL0dOVTdPYXFPNjNaWVlHWTRFOXJoK1h1cGJHN0FlMHR4SlN4Q2swY2JG?=
 =?utf-8?B?MGtWMGR2eGFtU1dXdlpOV1JxaEtqUWJGb0VuTS8rbDFTV01PTVdXV2dvQkZE?=
 =?utf-8?B?YXk0MSttVlVmeklzWDFvbkJiWldDQUxBK0pLTmZQcUdnS3pXeGtRQVpLVHhs?=
 =?utf-8?B?bmFMdW5EM3c5ODRDdi8vU2ZwOGNodTNRNG05c3oxeHpDeUM4eTlpb2MxQmZ2?=
 =?utf-8?B?bzFNNk94OVR4TmY3WEwwb1ZROWs5MWxNSVp1NXFnS0JXd3pZNnFqTnZhcU1O?=
 =?utf-8?B?QWFNQWt1aVBhdCt1QzRHb1hMeFcyOVA1ZHkzRElzdmk1THgreDNUc3BkODhv?=
 =?utf-8?Q?sV1OhyRXgmBJyasroy69Iwo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MN6QZk0lTx79TIDC7YckXA4v8bc847rMyv/Iu81mZEbxmAGAENpE6YU4T/q89demZ7RyOHsPWNwfUIte29BQl7D87nzMNtrhCIAGmoujd1Zs0S01XZBsG9UFxlUDC3z42WGPLN3/XXttpaBJ34YzVYrrewktqQ9IZ4PTtylSwjjrwwUSn7sRg1z/k/S1xMA06yKRboWp4rAOhXHwI6TWdQpt1tIneB41LOHYWd53+9E8eOg/QMlUTGbmA9paNSKQcdGOMcEw2nf9XZ44B+WBS5SqDXVMT4OJnvNNdQQQqlSkYo1z39OVeJ8YpwBqLzNI67MURTskfZY+bTSuqpIqL3xFOqPfrmq/uRvOUCYOWNMtj6x3TbO4uKaZNUyCPDOaButtPWysu0M1L5N0RCitKAjGvJNHlb8olHca3lJ5ukd20OrXEUM6XnooJzCvCSi8dd8uqzptGahiM82AeVTmluAtTG42FHQ1MJLtJt2ZF/iUih5DCJ6ZajgxnZP9hie0+Lnh1+ckSnH17YPoKn0Vr8626TUdkSVM1UmjNTioLKE6uL5JISJo8vXMYEceE1SdJUWglEeDj9ob2inJBBtR7WlB+7zkbz6/p+2B73a8UhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6356f02e-6697-45c7-f012-08dce6e60d51
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:38:12.1615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t01xrUzOXdO6VMJpb411QIkYtOAsZS91WfX06b/mdwa3LJr+ZMJ+qIfTDTt8Ih+ZeUgG0bZsNiZ1qh0Wypjeng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5650
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070110
X-Proofpoint-GUID: 27Rsnq13nPyylwx3H__DwnyPfcdMVJA6
X-Proofpoint-ORIG-GUID: 27Rsnq13nPyylwx3H__DwnyPfcdMVJA6
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/7/24 9:51 AM, Eugenio Perez Martin wrote:
> On Fri, Oct 4, 2024 at 8:48 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
>>> On Fri, Oct 4, 2024 at 2:45 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
>>>> translations for guest memory regions.
>>>>
>>>> When the guest has overlapping memory regions, an HVA to IOVA translation
>>>> may return an incorrect IOVA when searching the IOVA->HVA tree. This is
>>>> due to one HVA range being contained (overlapping) in another HVA range
>>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPAs to
>>>> translate and find the correct IOVA for guest memory regions.
>>>>
>>>
>>> Yes, this first patch is super close to what I meant, just one issue
>>> and a pair of nits here and there.
>>>
>>> I'd leave the second patch as an optimization on top, if the numbers
>>> prove that adding the code is worth it.
>>>
>>
>> Ah okay, gotcha. I also wasn't sure if what you mentioned below on the
>> previous series you also wanted implemented or if these would also be
>> optimizations on top.
>>
>> [Adding code to the vhost_iova_tree layer for handling multiple buffers
>> returned from translation for the memory area where each iovec covers]:
>> -----------------------------------------------------------------------
>> "Let's say that SVQ wants to translate the HVA range
>> 0xfeda0000-0xfedd0000. So it makes available for the device two
>> chained buffers: One with addr=0x1000 len=0x20000 and the other one
>> with addr=(0x20000c1000 len=0x10000).
>>
>> The VirtIO device should be able to translate these two buffers in
>> isolation and chain them. Not optimal but it helps to keep QEMU source
>> clean, as the device already must support it."
>>
> 
> This is 100% in the device and QEMU is already able to split the
> buffers that way, so we don't need any change in QEMU.
> 
>> [Adding a permission check to iova_tree_find_address_iterator and match
>> the range by permissions]:
>> -----------------------------------------------------------------------
>> "About the permissions, maybe we can make the permissions to be part of
>> the lookup? Instead of returning them at iova_tree_find_iova, make
>> them match at iova_tree_find_address_iterator."
>>
> 
> Ouch, I forgot this part. This is a small change we also need, can you
> add it for the next version? Thanks for remind it!
> 

Sure can!

I apologize for my lack of understanding on this, but for example in 
vhost_svq_translate_addr, how do we know what the permissions are for 
the addresses we're translating?

I'm not sure if this is always true or not, but if the address that 
we're translating is backed by guest memory, then can we always say that 
the permission for the mapping would be IOMMU_RW (since the OS needs to 
be able to modify it)?. Likewise, for addresses backed by host-only 
memory, can we always say that the permission for the mapping would be 
IOMMU_RO to avoid accidental modifications by the guest?

If so, this would mean that these mappings would never have the 
IOMMU_NONE or IOMMU_WO permissions, right?

>> But I understand that the problems with this is that we're assuming the
>> SVQ translation will always be done in a transient manner.
>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/virtio/vhost-iova-tree.c | 78 +++++++++++++++++++++++++++++++++++--
>>>>    hw/virtio/vhost-iova-tree.h |  5 +++
>>>>    hw/virtio/vhost-vdpa.c      | 20 ++++++----
>>>>    3 files changed, 92 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>>>> index 3d03395a77..e33fd56225 100644
>>>> --- a/hw/virtio/vhost-iova-tree.c
>>>> +++ b/hw/virtio/vhost-iova-tree.c
>>>> @@ -28,12 +28,15 @@ struct VhostIOVATree {
>>>>
>>>>        /* IOVA address to qemu memory maps. */
>>>>        IOVATree *iova_taddr_map;
>>>> +
>>>> +    /* IOVA address to guest memory maps. */
>>>> +    IOVATree *iova_gpa_map;
>>>>    };
>>>>
>>>>    /**
>>>> - * Create a new IOVA tree
>>>> + * Create a new VhostIOVATree
>>>>     *
>>>> - * Returns the new IOVA tree
>>>> + * Returns the new VhostIOVATree
>>>>     */
>>>>    VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    {
>>>> @@ -44,6 +47,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>        tree->iova_last = iova_last;
>>>>
>>>>        tree->iova_taddr_map = iova_tree_new();
>>>> +    tree->iova_gpa_map = iova_tree_new();
>>>>        return tree;
>>>>    }
>>>>
>>>> @@ -53,6 +57,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>>>    {
>>>>        iova_tree_destroy(iova_tree->iova_taddr_map);
>>>> +    iova_tree_destroy(iova_tree->iova_gpa_map);
>>>>        g_free(iova_tree);
>>>>    }
>>>>
>>>> @@ -71,7 +76,7 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *tree,
>>>>    }
>>>>
>>>>    /**
>>>> - * Allocate a new mapping
>>>> + * Allocate a new mapping in the IOVA->HVA tree
>>>>     *
>>>>     * @tree: The iova tree
>>>>     * @map: The iova map
>>>> @@ -108,3 +113,70 @@ void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>>>    {
>>>>        iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>>    }
>>>> +
>>>> +/**
>>>> + * Find the IOVA address stored from a guest memory address
>>>> + *
>>>> + * @tree: The VhostIOVATree
>>>> + * @map: The map with the guest memory address
>>>> + *
>>>> + * Return the stored mapping, or NULL if not found.
>>>> + */
>>>> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *tree,
>>>> +                                            const DMAMap *map)
>>>
>>> Nit: Not an english native, but I find vhost_iova_tree should not be
>>> broken for coherency with the rest of the functions. What about
>>> vhost_iova_tree_find_iova_gpa, like _gpa variant?
>>>
>>
>> Yea, I totally understand what you mean here and I have *no problem*
>> making it into vhost_iova_tree_find_iova_gpa.
>>
>> Just to add my two cents on this, for what it's worth, now that we have
>> both an IOVA->HVA tree and a IOVA->GPA tree, coming up with function
>> names that operate on this new tree while conforming to the
>> vhost_iova_tree convention and being descriptive in the naming is a bit
>> difficult.
>>
>> For example, to me, vhost_iova_tree_find_iova_gpa would seem a bit
>> misleading to me if I didn't know about it beforehand (or was just
>> seeing it for the first time). Like, are we finding the IOVA or GPA or
>> both? And what tree are we operating on?
>>
>> If this was some personal code I was writing and I had free reign over
>> it, I personally would go with a format like:
>>
>> vhost_<tree this function concerns>_tree_<action>
>>
>> So a name like vhost_iova_gpa_tree_find_iova communicates to me that
>> we're operating on the iova_gpa (IOVA->GPA) tree and our action is to
>> find_iova (find the IOVA).
>>
>> Similarly for something like vhost_iova_gpa_tree_remove or
>> vhost_iova_hva_tree_remove, etc.
>>
>> But obviously this is the complete opposite of personal code and
>> certainly not something that's needed so I'm totally okay with renaming
>> it to vhost_iova_tree_find_iova_gpa :)
>>
> 
> You're creating the patch and you (and everybody) can comment on it,
> of course :).
> 
> To me, the fact that GPA is stored in a separated *tree* should be an
> implementation detail not exposed by the function names. Ideally, the
> user of the VhostIOVATree just knows that some entries are tagged with
> the GPA and others are not. Saying otherwise, we could replace the GPA
> for another struct, or merge both trees, and the API would remain
> unchanged if we just add the _gpa as suffix.
> 
> Having said that, I'm happy with both names so feel free to keep yours.
> 
> 
> 

Ok! I'll change it to vhost_iova_tree_find_iova_gpa and maybe in the 
future if this kind of change is warranted then we can rename all 
concerned functions and not just this one :)

>>>> +{
>>>> +    return iova_tree_find_iova(tree->iova_gpa_map, map);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Allocate new mappings in the IOVA->HVA & IOVA->GPA trees
>>>> + *
>>>> + * @tree: The VhostIOVATree
>>>> + * @map: The iova map
>>>> + * @gpa: The guest physical address (GPA)
>>>> + *
>>>> + * Returns:
>>>> + * - IOVA_OK if the map fits both containers
>>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>>>> + * - IOVA_ERR_NOMEM if the IOVA->HVA tree cannot allocate more space
>>>> + *
>>>> + * It returns an assigned iova in map->iova if return value is IOVA_OK.
>>>> + */
>>>> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *tree, DMAMap *map, hwaddr gpa)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    /* Some vhost devices don't like addr 0. Skip first page */
>>>> +    hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>>> +
>>>> +    if (map->translated_addr + map->size < map->translated_addr ||
>>>> +        map->perm == IOMMU_NONE) {
>>>> +        return IOVA_ERR_INVALID;
>>>> +    }
>>>> +
>>>> +    /* Allocate a node in the IOVA->HVA tree */
>>>> +    ret = iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>>>> +                              tree->iova_last);
>>>
>>> Why not call vhost_iova_tree_map_alloc instead of duplicating it here?
>>>
>>
>> Great question with no good answer! For some reason I thought against
>> putting it in there but will do that in the next series.
>>
>>>> +    if (unlikely(ret != IOVA_OK)) {
>>>> +        return ret;
>>>> +    }
>>>> +
>>>> +    /* Insert a node in the IOVA->GPA tree */
>>>> +    map->translated_addr = gpa;
>>>> +    return iova_tree_insert(tree->iova_gpa_map, map);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Remove existing mappings from the IOVA->HVA & IOVA->GPA trees
>>>> + *
>>>> + * @iova_tree: The VhostIOVATree
>>>> + * @map: The map to remove
>>>> + */
>>>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
>>>> +{
>>>> +    /* Remove the existing mapping from the IOVA->GPA tree */
>>>> +    iova_tree_remove(iova_tree->iova_gpa_map, map);
>>>> +
>>>> +    /* Remove the corresponding mapping from the IOVA->HVA tree */
>>>> +    iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>
>>> If we remove it blindly from both trees, we are keeping the bug, isn't it?
>>>
>>> I think the remove should receive the "gpa" as a parameter, same as
>>> alloc_gpa. After that, vhost_iova_tree_remove_gpa looks the right iova
>>> into iova_gpa_map. And only after that, it removes that iova from
>>> iova_tree_remove.
>>>
>>> If it makes things easier it could receive (hwaddr gpa, size_t len) or
>>> all of the info in a DMAMap. What do you think?
>>>
>>
>> Initially that was my plan but this only gets called in
>> vhost_vdpa_listener_region_add/del and in both functions, by the time
>> this removal function is called, we already have the correct IOVA.
>>
>> In vhost_vdpa_listener_region_add, we just allocated that IOVA and saved
>> it in mem_region. In vhost_vdpa_listener_region_del, we already found
>> the IOVA via vhost_iova_gpa_tree_find_iova prior to calling the removal
>> function.
>>
>> But I could be misunderstanding something here. Let me know if I am.
>>
> 
> Ok I missed that. I think you're totally right.
> 
>>>> +}
>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>>>> index 4adfd79ff0..511c6d18ae 100644
>>>> --- a/hw/virtio/vhost-iova-tree.h
>>>> +++ b/hw/virtio/vhost-iova-tree.h
>>>> @@ -23,5 +23,10 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>>>                                            const DMAMap *map);
>>>>    int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>>> +const DMAMap *vhost_iova_gpa_tree_find_iova(const VhostIOVATree *iova_tree,
>>>> +                                            const DMAMap *map);
>>>> +int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
>>>> +                                  hwaddr gpa);
>>>> +void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
>>>>
>>>>    #endif
>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>> index 3cdaa12ed5..591ff426e7 100644
>>>> --- a/hw/virtio/vhost-vdpa.c
>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>> @@ -365,9 +365,16 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>            mem_region.size = int128_get64(llsize) - 1,
>>>>            mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>
>>>> -        r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>>> +        r = vhost_iova_tree_map_alloc_gpa(s->iova_tree, &mem_region,
>>>> +                                          section->offset_within_address_space);
>>>>            if (unlikely(r != IOVA_OK)) {
>>>>                error_report("Can't allocate a mapping (%d)", r);
>>>> +
>>>> +            /* Insertion to IOVA->GPA tree failed */
>>>> +            if (mem_region.translated_addr ==
>>>> +                section->offset_within_address_space) {
>>>> +                goto fail_map;
>>>> +            }
>>>
>>> We can move this cleanup code into vhost_iova_tree_map_alloc_gpa, isn't it?
>>>
>>
>> Sure can. We'd still need to check if vhost_iova_tree_map_alloc_gpa
>> returned IOVA_OK though and goto the fail label.
>>
> 
> Yes, right.
> 
> Thanks!
> 
>>>>                goto fail;
>>>>            }
>>>>
>>>> @@ -386,7 +393,7 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>
>>>>    fail_map:
>>>>        if (s->shadow_data) {
>>>> -        vhost_iova_tree_remove(s->iova_tree, mem_region);
>>>> +        vhost_iova_tree_remove_gpa(s->iova_tree, mem_region);
>>>>        }
>>>>
>>>>    fail:
>>>> @@ -440,21 +447,18 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
>>>>
>>>>        if (s->shadow_data) {
>>>>            const DMAMap *result;
>>>> -        const void *vaddr = memory_region_get_ram_ptr(section->mr) +
>>>> -            section->offset_within_region +
>>>> -            (iova - section->offset_within_address_space);
>>>>            DMAMap mem_region = {
>>>> -            .translated_addr = (hwaddr)(uintptr_t)vaddr,
>>>> +            .translated_addr = section->offset_within_address_space,
>>>>                .size = int128_get64(llsize) - 1,
>>>>            };
>>>>
>>>> -        result = vhost_iova_tree_find_iova(s->iova_tree, &mem_region);
>>>> +        result = vhost_iova_gpa_tree_find_iova(s->iova_tree, &mem_region);
>>>>            if (!result) {
>>>>                /* The memory listener map wasn't mapped */
>>>>                return;
>>>>            }
>>>>            iova = result->iova;
>>>> -        vhost_iova_tree_remove(s->iova_tree, *result);
>>>> +        vhost_iova_tree_remove_gpa(s->iova_tree, *result);
>>>>        }
>>>>        vhost_vdpa_iotlb_batch_begin_once(s);
>>>>        /*
>>>> --
>>>> 2.43.5
>>>>
>>>
>>
> 


