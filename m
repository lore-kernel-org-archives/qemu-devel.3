Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209A8C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 12:42:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRAAS-0004m1-UW; Tue, 09 Jul 2024 08:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRAAO-0004lK-QK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:41:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRAAM-0007yE-FJ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 08:41:56 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT1Hm008016;
 Tue, 9 Jul 2024 12:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:from:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=wD92xbtSO8lVYGYl9nMmjmhzV4MwXLkVcKleiiIa/uI=; b=
 Q3yWpDAB9tP7VGCk3HCcS5Mlg7/N3CL01lnOU0xyhhc/dgCYIYap5rGGAMKcwLpu
 nh7TM9QuyVJ02rPFysw/SWiwUqRS4MHZXLbvpVNrlharAeY55Qb9YODQdiknAPa3
 +JPPXkGLAACve26W8PliNXe0Br8UK7E7hqnp8BudK/FCISzssi6zI8SF9aZTBmDN
 yRkL/k60VLvV3hRVXebenS/Qt2mjMOEsGatrQ3hADl5gjsRM9tS45iQ8TGJTxs9Y
 EW+7YkCJQmTzHWlmyo6XRMTcI28cw5+cYkEXPHYCbQ39tP0oTqe5mWPYNtsiOqaS
 3Ln8mXGUY0tDCqtiP5+MhQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmuxu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 12:41:50 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 469BPtXm005609; Tue, 9 Jul 2024 12:41:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tx2n7jc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 12:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNXXoUgutgOpQ5Qgz4tVq33WByGMdI/1S9tfwXdaxc1UGnxjsjNSpCKwL62C9n0A6M4Io6urI39Pfc9UAFWwL5Z1z8l8ALGx2cglJ6goXYK0jHcbPH2rAhsDiyUfAetZTsM3iMZmHUF2ZCXjgoONcRR3zRs/TOXI94hNhXd8LNv9vuZ1gA68Nme6zpm01xpRQfG37YQDOQIojYTI2WOQ4OFFRw3inBEvzlWr7XVVV+GjuOuTJ1misdnGu1K1h+BYktLGPbBN9aWgK0FieEfXOdoADcYRvCWWre5XVx/LGepkY6IT6TuRbXdEGFcRKhBBfrHg3jcLS5jgTiYqBdZKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD92xbtSO8lVYGYl9nMmjmhzV4MwXLkVcKleiiIa/uI=;
 b=GrsEfGtcdxsG7JcGTesAIPRQfq1JCsDPxmCpDQDJdHMXo99fLlmeT6RCh5bqGd0evqmGeKWJPGRNGM91EFra1PYPkpGYrm8H0XcKH+FP+wT9lUHwhuk4DP9+WDxQOmQbiaF4RXBt8c2+Ev2Li77NQhIXu59ysG6ZaVdIwOEQU4jsptJzTlG19FGKht65wQTM+QlfRhuDExaqbBaDvKam6vAkiM80apO9eOhYgqwYDWZLdO/5CJI+wbiJVEAv2XL/Ej0QbJEqcX7l9A1VCrizu3+KjISfeVC2dfWqoboQKbWnB4szPWsH4QsIxp7m7gvfm/sn2XVQpuixO2plVmpb/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wD92xbtSO8lVYGYl9nMmjmhzV4MwXLkVcKleiiIa/uI=;
 b=Q9/ISrbsSOeH5HDKt/lzQlOdyKters42TIUzaVBk8zQP984zq8p+q4MLpBx4ZhuGVx7VmySjK0o3bYGD8dlrYX2QQOAOR5hrrO7aeTMpugv+OZreTAKxqTwhorSn4kLGfaclRhoWHFMi5KZID546n/ohmbXDkUlSuPSyddC4W6A=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA3PR10MB7044.namprd10.prod.outlook.com (2603:10b6:806:31c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 12:41:46 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 12:41:46 +0000
Message-ID: <a25e93bc-c7f5-47e0-98ef-59d657d59d25@oracle.com>
Date: Tue, 9 Jul 2024 13:41:40 +0100
Subject: Re: [PATCH v3 07/10] vfio/iommufd: Implement
 VFIOIOMMUClass::query_dirty_bitmap support
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-8-joao.m.martins@oracle.com>
 <7dd75280-47a7-4d66-8b39-7347e9194a9e@redhat.com>
 <5844a2f3-2626-489c-a62f-f6a0b324cf01@oracle.com>
Content-Language: en-US
In-Reply-To: <5844a2f3-2626-489c-a62f-f6a0b324cf01@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0025.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA3PR10MB7044:EE_
X-MS-Office365-Filtering-Correlation-Id: 7003278b-a2b3-446e-89d1-08dca0147e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TG1lVklGZWhUYW5JRE5QcVJJempWMWRDTmR3L3cvcncrUHBwSTU0eXBoeUpZ?=
 =?utf-8?B?RTZMRDVzc3NqUnl0dXpzNzEvQTI5ZU4wY2ZpM2JadVZjNklJL2JhdDg3WXBL?=
 =?utf-8?B?OUk5a1cxYWdCekxqRDQyNXpnd1dFMjhydk03MWZmZ0NFM1VlNlFkcnJmUjZj?=
 =?utf-8?B?QVpwSzIxU0M4QlZzSHBvYnFFcFFlcWhNNWxVMkJjWlhhRDhCeGtvemRzMmJD?=
 =?utf-8?B?MmRSMHVQRGJrSUJyeG81R1lxa2Vad1FLQ3g5UkRIR0haMGVVZG9jTUNPMHYw?=
 =?utf-8?B?VmRXN1RhUDBheENTL0VMazRyQ3BjQjE0bjR6Y3VnNm5laTFqc3pvMmUwWnVW?=
 =?utf-8?B?SDM0TEduT216cDlnbm1nYjR3MXlpaWx2SnFvcjgyM1FiWG1FV1AxakxaZWNW?=
 =?utf-8?B?TEtERzVkWXAzdURKL1NlTmI1MGZOYUxKSVBQVVF5bzBYdUZSUWt0a25ZVHFz?=
 =?utf-8?B?Q1BqV0x3UnZlSkhXL3ZjR2dyblBnbWVGWm5mOFVzdkgwWHZsK2w0RnIxbVc5?=
 =?utf-8?B?dnAxY3hEMUEzc0J5Mng3QWJMekxydFl6UmJ0UFV0Y1RPd3ZHMnVLNjZ1L09n?=
 =?utf-8?B?c0U1UWZBOGJDdW9kN24rOTFSanM0b1NvZ2JUdGo5WHpSNkhlSStqM0g4cnJl?=
 =?utf-8?B?QVlFYjV3azRSaG5vREZOSkdob0tabUdqbm01S1FQdTZSU2NQZ3hiRkNnSUVo?=
 =?utf-8?B?bk4rUTFLa25KZmlWN2tEaGNjdXVpY3ZUWXArMGxUbC85UXBTSXcwMktjeFZB?=
 =?utf-8?B?dnE4MHlvYjkzRkQvMmNxTHJvNTU1bHg5OEkyN0ZWd2d4SnlkVkpWWHR5eWRI?=
 =?utf-8?B?enRaV1ZUSmtjeU12L1JvTUZMTTBLM0Npc0psUDhBd2ozV2JybDdGZnlIN2tW?=
 =?utf-8?B?T3M0OVBGdzdKdEJrSTFtSDF0ZzZiZXA2eXF4VG54NGxuWjJXN3NrMHJ6eUx3?=
 =?utf-8?B?bTlxWWp1MlpQTnYwaGxRQzZpaUMwRk81Qm9uTnpCNy80TVB6NEp5UzM3c1VO?=
 =?utf-8?B?OHdnVjBSZFpWcW9MMWE0YWtXbGZ5b245bnYxVS9CRElkd0tQYWx4SG1Vam5V?=
 =?utf-8?B?QjRGVVF2ZkpXRnJGVXQ0NHNGYldxRUdLaDNFZ1Y5MmxYTzUwN0Nyc0ovVUZn?=
 =?utf-8?B?VFo2UHdkQWRkTThwYVdoci9IWG9qT09GQnlmUzkwU2VIVktLWmZlZE1WRHI1?=
 =?utf-8?B?eUFjZWhkalpndVNOVUUxSlovMDJuODJ1VEZQMG9jaUo2YkRPMVpxWUtqQjJu?=
 =?utf-8?B?eHB3c1Btd291YVZvTnFhS3l2M25ZTWQrTVVkNE5ldEFFRU9QNzhFVEpabGFI?=
 =?utf-8?B?SHdVUzF6K21rcVFQakhzSDQyS2JBRTkxNC9HTC9uWUVJWjFVVVpUTzl2M29W?=
 =?utf-8?B?cGdMU1FJM1FrMWJXdDlHYk1POUxVRjI5VTNzNGozVkZBUFpaaW5EM1RiQThG?=
 =?utf-8?B?dUFzdGQyVDhLbmFlU3dTNVlHUDRWSmlzRmd2SlNkaENRUGpRc1czVC9yY0k2?=
 =?utf-8?B?SzJKdy9FRmNoUGlPV05BbjU5TGNWak9RMFJieWZFQzdHNXJBaGZJWEtyWXRL?=
 =?utf-8?B?SUVrUWNhTy9zSFA2ZURJbloxc2p5bGNkZzA3YlBESTBXNkJheFpwdDlPOW9W?=
 =?utf-8?B?WERmMVk4OHp2WkNnWTRTb3ZrV3JyaEIzcnIvTlVZL3RTL1VQaHQxN2lvejcz?=
 =?utf-8?B?bEYwdUMzS1ZiN1Avb0ExZ2l0cXh5dVowNmErRWdlclBGVUhJblB3SUYxckJy?=
 =?utf-8?B?Z2RSRTdrUzlPU2NLRkFrdCtURXBZeTl1SXhQZkRyY1lsc1NLOTJyZEV6bllr?=
 =?utf-8?B?aDg1dWZqOXBIR280Tjdpdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d21yd2I3QUhBTEJOdldxbjZpYXNxVFV3NDUwbU0zMXFkSWxHaUVIUUwzdkMv?=
 =?utf-8?B?TmIxbzh4R3NtQUZNM0lGMkVQWlNGWTFpeWFJV3F4STBRVTcvZCsyUmdZYWVB?=
 =?utf-8?B?UUFYenBXaW5hZmUxZTU2ZkhNd1JIb25DZ3BrZXlyZDRkRE9ZOUNrWWpDQ3hF?=
 =?utf-8?B?VVU3WWpTVS8rUlF2c08wamRXVWJ5SWlDRWJzZ2ZCRlNyK213a3FuN1hwQnl2?=
 =?utf-8?B?eFRBMkxwMmFsRkRmZ2pOc3JQNVJFMmZPNVBJWUxMbDFkSVIxU3BIZzFBRGVw?=
 =?utf-8?B?eG0xY2xIRE1sSUpnL0xJT2NnT3hDRTN3RU1FZ3ZHcUlwZGtVM09wU2ZQSHJt?=
 =?utf-8?B?S2NlUE9Zcyt6VjJoZWNiSUVnS2h6WDhONFQ0S2x3TS9vOWVDR1JCcDNJU1ZP?=
 =?utf-8?B?N1o4Mm82cnNsb1dvNDBEdUE0K280YlNqb3I1eVFyM3lxM0E3elZKWDl3MDBO?=
 =?utf-8?B?UWhvSmRCVmpLcFBvajFiL09ydEtEZm0yQTFWVnRjL1BRRXZqZ1g4Wi9sQmpt?=
 =?utf-8?B?WFNBS1NncUZ0Q1l3Q1Rtc0NnSVAyVGZxT0dTNFNHa1RvV2NxS2NPKzZzQU5z?=
 =?utf-8?B?R1lmUWRPYThoaTZJUyt4T1JEMlpPaTljUGVSWDVnNmtXQUh1Nm0wOEFlTElB?=
 =?utf-8?B?bE4xdGw3RTBnWm5ZK29RVGxLS1loNEJBbXppTTFkYnRjaUI2RDByckR0d21J?=
 =?utf-8?B?eldYc1p5djJzYUpmTjVpZkI2ZHRoNTdXWHNHa1dqS3d5WDRBV1p4LzZYQWJ0?=
 =?utf-8?B?YjZrOGxwTU9wWSsrLzhaSE5ua3lRc2doR0s2ZkU3SGNLeGYrczZrM01Ja3lr?=
 =?utf-8?B?VGNidWwxbURiQ0RBcHB2V2psMW84MDYwMk9wK21LK0VPa1ZkZE9SQTlQektS?=
 =?utf-8?B?WnJSVlFmdTBkR0dpaU8xRFd1Q3hpb08vUVR0MTRYZWt6cDhjMDdCNDVWRFV6?=
 =?utf-8?B?Q0FMeFlEQ3k2VHJWK1JTK0J6SncvSDBSMWRBYi95ZkxqSVBuMnJuUGlQNjJw?=
 =?utf-8?B?OE1iWXZORWsybEpIYTZsYmNrQkFyS2t3OUk3Z1E4L2NTR1d3YTBFaXpCNXcz?=
 =?utf-8?B?QUxLc1VMUDVza2ZnSG1taVNGMTVtOHVOMjZ3RHlGb3UzOFlFWnNGSkN0L1ZT?=
 =?utf-8?B?VE1LcDV5VDJ1WW5TWi9jUS8wbWFESjhoM09hSFlPWWlTTGw0cjdtZUhaYVF3?=
 =?utf-8?B?ekM0SXZSM1NBRkNHVWlBUmlMVDQxMXNWNXRKNGgzSmZ1RHU0cHBtUFNqV0lx?=
 =?utf-8?B?ZlNzYk54eE1yb3QwdXZzRGV2U1o0NUxNR3Z4YnQ5dDk5UU9PbEVhQkNLMTNQ?=
 =?utf-8?B?R25zSWR6SHZJYnl6OWkxNW5kSUx1K1ptL3piVkdWVkpFL0IzODZQTW8rSDEx?=
 =?utf-8?B?blZ1S1h4L0RoRVlMdzArSStrQUVFMmxheWJkSmpFQkJJQXkwNTBEaVR3SUNZ?=
 =?utf-8?B?djJGbXkveHRQUTNXVkVQYjQya1N3UWUyVnFRRkcrNkhxUmVoNjBMT09kZUpI?=
 =?utf-8?B?TGh5UVIxMlBxUDEvZGw2NElTQUlNUWZxSDNGTEs2YzZjMHpPUHloT0NIYXFx?=
 =?utf-8?B?OEo1RlkzNWU1d0V3cTkwdTBsVThLc3Z6QjNVSDAyM28xY2pyU01CdUVuclpL?=
 =?utf-8?B?ZVZ3SFNiNzhYblJJTUhxM2hMQis3QkdtL01vNm5nRzNEVTNONHY4TWk0aVBB?=
 =?utf-8?B?Qlpub1NqZGVYeWNRczVKUjhVVER1d282SS9QZGZyeGt4S29iQTY2SXFpK0Ru?=
 =?utf-8?B?SjZOUnNwQmwranBSREx5amRldTdGanBMOHlQSTlpWGsyb2ZHcElXZGtBSDFU?=
 =?utf-8?B?azJBUWpaQ3BJRE4xL2Rna3V5MEhZRE51SjBVdnBjNVFUbEYyUzFHNkEvTGtM?=
 =?utf-8?B?YVNSUGRRYllWVFlkc2ZydmVOZDBJUnN0SFFKcUhnbVI0RUhwWHFhYUZ5OGFC?=
 =?utf-8?B?Y3BxOVNRSXBlNzNtMjNrRmxkVzZTWlFXbE1aR3ZhSUFkRFFjSG9yYmxXVVgz?=
 =?utf-8?B?V2pERlBFUXpZR3ZMQ1RRRXdWYndOSUpzYUVFK1p6ZW44dE14NEdaNG9kQm1U?=
 =?utf-8?B?emh0M1BNZk1RM3lGWmt0aW4xbkdTN1NyOEdGMXRxT0lmWk52ZmovM1h1djlC?=
 =?utf-8?B?Y2p3eFdaa1NsYjlWRDhoYVkrNjZFWUNZZTZRVUhVN2VwMGFkYjFPMXFNSElB?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MK6MGi//JnS73kUDCqIpzLcGjAZU3mtw1XJcg68BVoPHXK+wHuB/lqtcJZzpLdQmrSYjW5BWt1PSvCR19E2Dr62364c1/iV/0SKWGcrBmkYPd23PA6O+IwKFzkZ4pZ2sAzzc5VsOddRoF6/OMI/4ZQmUNwPBNjAZkU7/wzalfePb4I7IyJqyGf500DdsgsDQuoXkhxrqh10gFML9dJs0FK0ZJzhW3Gn+RS0CYWhhSl8ul/iaTDs2u62YPE3HX//S8r423+d8G0CgtVRyAJL4RcRLVxX2qWJVQTIxRAK0frxeHSYRiNOgTm1AH0dYIMRAwLRoFBclcU/s2JqnOVyxV2hcnCHJVVkYJcd+IYiUf5DdhJNk8l+kPw6BxwY2F18Hd+4g35oPtF3JxuPQ+RGhNMVGaIyEhppT/IbExWK90cqBgQiT4Um+Bh5VUGmvNIF+dM6imess/5lD/Rhr69aM11N1SfcxOV3B4C6xvC5iEHWHE/7DA3baMssFxgpESs8g4aZ75dPzvgiyqobAsnm/iKY6QSiflX3hfkwT1+vl9gyZGKONJVFK+LjRKNLwc/lYuyNVn07mpkouLKv/VS9m07w57AjKwXhjZghmWZnNPqg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7003278b-a2b3-446e-89d1-08dca0147e8f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 12:41:46.5498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7NWEWq2eP7colO6SvrPpQVHLOSuF9iCmQ2oAF1s6qWkptKq+WIawD4c8y/x9UlOLg86NmTOAAAnYQ+jPCcEUYFa+kPGGvP1khw4sZvH0pko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090081
X-Proofpoint-GUID: wO-NLOzLaQMZxzALepQWQ-7_7QS5c77c
X-Proofpoint-ORIG-GUID: wO-NLOzLaQMZxzALepQWQ-7_7QS5c77c
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 09/07/2024 10:13, Joao Martins wrote:
> On 09/07/2024 08:05, Cédric Le Goater wrote:
>> On 7/8/24 4:34 PM, Joao Martins wrote:
>>> ioctl(iommufd, IOMMU_HWPT_GET_DIRTY_BITMAP, arg) is the UAPI
>>> that fetches the bitmap that tells what was dirty in an IOVA
>>> range.
>>>
>>> A single bitmap is allocated and used across all the hwpts
>>> sharing an IOAS which is then used in log_sync() to set Qemu
>>> global bitmaps.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>> ---
>>>   include/sysemu/iommufd.h |  3 +++
>>>   backends/iommufd.c       | 26 ++++++++++++++++++++++++++
>>>   hw/vfio/iommufd.c        | 34 ++++++++++++++++++++++++++++++++++
>>>   backends/trace-events    |  1 +
>>>   4 files changed, 64 insertions(+)
>>>
>>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>>> index 1470377f55ba..223f1ea14e84 100644
>>> --- a/include/sysemu/iommufd.h
>>> +++ b/include/sysemu/iommufd.h
>>> @@ -56,6 +56,9 @@ int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t
>>> dev_id,
>>>                                  void *data_ptr, uint32_t *out_hwpt);
>>>   int iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>>>                                          bool start);
>>> +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>> +                                     uint64_t iova, ram_addr_t size,
>>> +                                     uint64_t page_size, uint64_t *data);
>>>     #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>>   diff --git a/backends/iommufd.c b/backends/iommufd.c
>>> index 69daabc27473..b2d3bbd7c31b 100644
>>> --- a/backends/iommufd.c
>>> +++ b/backends/iommufd.c
>>> @@ -257,6 +257,32 @@ int iommufd_backend_set_dirty_tracking(IOMMUFDBackend
>>> *be, uint32_t hwpt_id,
>>>       return ret;
>>>   }
>>>   +int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>> +                                     uint64_t iova, ram_addr_t size,
>>> +                                     uint64_t page_size, uint64_t *data)
>>> +{
>>> +    int ret;
>>> +    struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>>> +        .size = sizeof(get_dirty_bitmap),
>>> +        .hwpt_id = hwpt_id,
>>> +        .iova = iova,
>>> +        .length = size,
>>> +        .page_size = page_size,
>>> +        .data = (uintptr_t)data,
>>> +    };
>>> +
>>> +    ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
>>> +    trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
>>> +                                           page_size, ret);
>>> +    if (ret) {
>>> +        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
>>> +                     " size: 0x%"PRIx64") failed: %s", iova,
>>> +                     size, strerror(errno));
>>> +    }
>>> +
>>> +    return !ret ? 0 : -errno;
>>> +}
>>> +
>>>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>>                                        uint32_t *type, void *data, uint32_t len,
>>>                                        uint64_t *caps, Error **errp)
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 158a98cb3b12..9fad47baed9e 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -25,6 +25,7 @@
>>>   #include "qemu/cutils.h"
>>>   #include "qemu/chardev_open.h"
>>>   #include "pci.h"
>>> +#include "exec/ram_addr.h"
>>>     static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>>>                               ram_addr_t size, void *vaddr, bool readonly)
>>> @@ -152,6 +153,38 @@ err:
>>>       return ret;
>>>   }
>>>   +static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>> +                                      VFIOBitmap *vbmap, hwaddr iova,
>>> +                                      hwaddr size, Error **errp)
>>> +{
>>> +    VFIOIOMMUFDContainer *container = container_of(bcontainer,
>>> +                                                   VFIOIOMMUFDContainer,
>>> +                                                   bcontainer);
>>> +    int ret;
>>> +    VFIOIOASHwpt *hwpt;
>>> +    unsigned long page_size;
>>> +
>>> +    page_size = qemu_real_host_page_size();
>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>>> +            continue;
>>> +        }
>>> +
>>> +        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
>>> +                                               iova, size, page_size,
>>> +                                               vbmap->bitmap);
>>> +        if (ret) {
>>> +            error_setg_errno(errp, ret,
>>> +                             "Failed to get dirty bitmap report, hwpt_id %u,
>>> iova: "
>>> +                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
>>> +                             hwpt->hwpt_id, iova, size);
>>
>> This error looks redundant with the one printed out in
>> iommufd_backend_get_dirty_bitmap(). Couldn't we add an 'Error **'
>> parameter and simply return a bool ?
>>
> 
> I'll add it.
> 
> Just as a sidebar: This is a odd pattern which seems somewhat spread, that
> somehow we only care about @errno as something to put on a message, rather then
> letting the user know what exact error code it had returned programmatically.
> Here in this series it is only important for the device attach so likely doesn't
> justify a Error structure enhancement, hence the rest of functions I introduced
> here can just adopt bool+errp.
> 
> 
Looks like this. A bit odd as the container ops (and legacy backend) expect an
errno. But I am assuming that you intended that way.

-int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
-                                     uint64_t iova, ram_addr_t size,
-                                     uint64_t page_size, uint64_t *data)
+bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
+                                      uint32_t hwpt_id,
+                                      uint64_t iova, ram_addr_t size,
+                                      uint64_t page_size, uint64_t *data,
+                                     Error **errp)
 {
     int ret;
     struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
@@ -273,14 +278,15 @@ int iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
uint32_t hwpt_id,

     ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
     trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
-                                           page_size, ret);
+                                           page_size, ret ? errno : 0);
     if (ret) {
-        error_report("IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"PRIx64
-                     " size: 0x%"PRIx64") failed: %s", iova,
-                     size, strerror(errno));
+        error_setg_errno(errp, errno,
+                         "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
+                         " size: 0x%"HWADDR_PRIx") failed", iova, size);
+        return false;
     }

-    return !ret ? 0 : -errno;
+    return true;
 }

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 35cf8da22ef7..4369df34a6ac 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -160,25 +154,18 @@ static int iommufd_query_dirty_bitmap(const
VFIOContainerBase *bcontainer,
     VFIOIOMMUFDContainer *container = container_of(bcontainer,
                                                    VFIOIOMMUFDContainer,
                                                    bcontainer);
-    int ret;
+    unsigned long page_size = qemu_real_host_page_size();
     VFIOIOASHwpt *hwpt;
-    unsigned long page_size;

-    page_size = qemu_real_host_page_size();
     QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
         if (!iommufd_hwpt_dirty_tracking(hwpt)) {
             continue;
         }

-        ret = iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
-                                               iova, size, page_size,
-                                               vbmap->bitmap);
-        if (ret) {
-            error_setg_errno(errp, ret,
-                             "Failed to get dirty bitmap report, hwpt_id %u,
iova: "
-                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx,
-                             hwpt->hwpt_id, iova, size);
-            return ret;
+        if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
+                                              iova, size, page_size,
+                                              vbmap->bitmap)) {
+            return -EINVAL;
         }
     }

@@ -287,24 +274,11 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice
*vbasedev, Error **errp)
     return true;
 }
(...)

