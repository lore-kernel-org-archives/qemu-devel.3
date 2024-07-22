Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A64C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 15:44:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvCC-0006jM-5E; Mon, 22 Jul 2024 11:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVvC4-0006ib-PO
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:43:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVvC1-0002yb-8F
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 11:43:20 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MCBa9b003253;
 Mon, 22 Jul 2024 15:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=rYqdHV/1InaTCLq98tcErvBc6E8pgCmfGiw1VvVAkIg=; b=
 CarvZDUFwLUSNNXVp/YtVQHvL9fxwqgYXAZDR42t4x0UMU+PL1Ydyo40OgiqBZSM
 cETxwgPR45X03WHZkuPgrvaI+dnYowktNVnjomddO3IHd8YbF9njyXNqExOZWqQu
 ZzRVh3Nh2T3NFsr+d42eximzeRgVfS6FuoI2MvQ4aemf8K7pfEwzNa+rF2iLYzYZ
 nAqiPZ0WRZQqdMHAxhbaZ4B6GUT+4757ABg3fVbUcEwPeQUZCW2p/qbvvuJ+CIzY
 Rd3+NM0PXznyaOgiOtRHNDrGMuCFJfFmCkCJuZOXBJrv12reBDTkLFqds0Gh+/NV
 V82D1MASEliknn4GAXqmBw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hft0a8m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:43:13 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MFZaot033620; Mon, 22 Jul 2024 15:43:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h268426b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 15:43:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lAyewlzbKRMiFQaRWw9uYsMs6lz4KsXJw8j2NaS5rTXDj5ooBH/5pT226q23P8G+6TNLOj5it8QjFbduesy8LDYICY7qm2MTC1kktWz7dLcv4QqV6f0kP7MnPKOL09ddrY87ar6SzH5bZ17nSSFuN2yjIJ1/stBEtuscRppJs1oKE5JjNLMEKacw37ztZa32okV32W1YmJLjifiVSb9i2pty10+t2LgnU2sjTGIwOe3yzqw/28Oqy5wej2t0tmmn85LJW6IC/H+hAmit8VLNaKWRASNgj+Ujn6GuscNqz7Y8JhoYzdIOqjdWQYg2IjLz77oQ7e5zWJesQw/P94Dnpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYqdHV/1InaTCLq98tcErvBc6E8pgCmfGiw1VvVAkIg=;
 b=lGbqDUiQS3Bk1NchbtBKocMxPdZA/ikmMg7yZHBeqTPkYEMjpv7FQ/NdOk2Q6HTkj0tidt5FnwtN7u2itoak6RTrVf7rzMu/RVrJSvaGPLah3IqKEUwqW4NR9UmnGONmCdYrGOVJ4DHwTLucz0W1qrJZcJ7xRm4kqiMCTr26YGJoD82CmaH12eRu9QsCrA1f2ANBercxbzSPvvrYZtvnhNRFzSbDTpcTqN4U7NHZ8PjFf/TPrSfa0t6unwFKkIhKDuQZ/WDUWHChxneVKQn6MhsVk4vfL1zl296mXRlul/zXJS5t523gamqHGGmS7eWDNlAScBMNqL7I03ItgKN4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYqdHV/1InaTCLq98tcErvBc6E8pgCmfGiw1VvVAkIg=;
 b=CyLMSy1mx1mp1/5jmZ+mGP98Dfp3eM5uh0hpUtTVQD4SGYlW1mntHj29yCLY6HhQebNJbg0gulPkcNmmZcAe+DJ9DmIHlk/N3nqt54NKO3PMXKimYVtJauM91N5/zeidye1Lu/rcV7dspQYfCRPVmUOpw8J4rPw7xjVvNzNrBoM=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 15:43:07 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 15:43:07 +0000
Message-ID: <27e2792c-6eba-4fab-a22d-40e46dae9cda@oracle.com>
Date: Mon, 22 Jul 2024 16:42:59 +0100
Subject: Re: [PATCH v5 12/13] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-13-joao.m.martins@oracle.com>
 <a8239962-c987-4ca1-b342-95fd8f03179e@redhat.com>
 <f5d64358-70e3-4217-8376-356c8aaac8ea@oracle.com>
 <1304a8c4-be47-4b47-88dd-328a8f167e54@oracle.com>
 <967952f0-e3bd-4c86-b4a8-4906e6b3e248@redhat.com>
 <103a2101-3f9e-46da-b45b-b8a4eaa7d6e7@oracle.com>
 <51012898-c535-4fb1-b101-3d613d46fc30@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <51012898-c535-4fb1-b101-3d613d46fc30@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0472.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f92d54-e0ab-48b8-0253-08dcaa64fb5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VW5tOGhac2RmL2FzRFQ4M0ttYldXQm5oTVZidFI1WjBFdnRjTEZ0cHpnbG93?=
 =?utf-8?B?a0tKd0hMY3ZVYmhJaklvQk1zUGw4ZTVjSFArSy9KNmRlS0prUUsrc0ZLd3ov?=
 =?utf-8?B?Si95cndhM2ZmVnkyMHdMdFBERjRFdE4rUmpubnRRbTl6YlcxSnRiTFg0VUtw?=
 =?utf-8?B?ZjhmbUhld1I5K3BuVzdyUi8zaXB3bHVyR1h3RUlibmlpbFgwcUQxV3JCSGox?=
 =?utf-8?B?aEk5T2djYUVucGYzZjljRkFBUWd4d1VFUVR2TFJnNVg1OXNhUS9Gbk1jcGth?=
 =?utf-8?B?MTdPT0gvNm1tK3NPcHRBeGFYL0l4dHR6M0ZBSlYyZEV4cFRoMGFNaU9XZjd3?=
 =?utf-8?B?NTd4LzRYb2ZuM1NZL09yVW5KRmdtM3hMMVFwcXlEREZmaXkxcWpNdTliSW9H?=
 =?utf-8?B?UDZ2alIyWmZBNUlGY3k5bFgxanlmbmt3YlQ2RUFjeGxudjZzY1ptcExYQ1lT?=
 =?utf-8?B?RGMzNGZ2TzNuOXh6WFErcmtZalhReTBielBtRi91bDhUSWtoRGxTWUVFSDRU?=
 =?utf-8?B?Qm5hRjdCb0k3REdWaThLTWE0R0VPTGs2SkpaK1AwQmxmTEI4TWtsemxUUlE4?=
 =?utf-8?B?UzE3NURkVXErQnhLUzdaYWQxSjB0NUNkdE96aUpMM3JKQzRxekFkUUYvQnNN?=
 =?utf-8?B?VHEvd1JlS01vZXA3eG1oWEtrQ0I2RHV4dExZVmRUd0pkQU5tZnZLWFNHaCth?=
 =?utf-8?B?OUc0bVBpdGN4U3NhV2hRbFZJZFBBSEc4T0NMdVN0bnJSQVJmRWtwWUlXTEdM?=
 =?utf-8?B?L3p5M1RhbURVZXNOd2VDWmNaY29HTDhSTFF4Z00rMEJmSEtLeEZvdDhXanl1?=
 =?utf-8?B?OVdWRUVqZmoyYXZGZ2l3RlFGMUNtQUE3STNzUTJuc0N6dkhEbFl6YjE2YUNH?=
 =?utf-8?B?VjFzUitKSHFtRGZic2cweW91Q0ZiS1psU1YwS1Z4SFR1WnNCb2lmOTFRVXBB?=
 =?utf-8?B?K21ScE5yK0FOQk1rZWpoY3BRQ0VZUTY4Y09XVmwrNCtpdFEybG5jUXlCaTU5?=
 =?utf-8?B?c3AvdklGbEZycnJVc1ZtM3IwUWg4d05ESUhqTXAvcW5QUGJqUkREOUc1VDJI?=
 =?utf-8?B?TnhVNjFJWjZ1UE9BTi84WWJsb1dxK2FNRk9VbjlNdWxlRk1NcVpiZjQxcEN0?=
 =?utf-8?B?V3o5Y25pREtYMGN2aXkyOXRwZ1dTTlovaERDYXF5R1JUa3FYWWVEUXlnMU54?=
 =?utf-8?B?VU8ySUxMOHBmMlZ4QzMra0I1SzdpRlVwbVVyRkVpS2dmUHpxQ1lOL0dFOXJ3?=
 =?utf-8?B?ZWYvVVFrVGdGMGhxU3FhREdDUEQ4NWQycXBsSEhrUEsvbmw0aWV2MUpRYUlQ?=
 =?utf-8?B?aEtGbzFxU0EzNGE5bE5UZ2puVE02dWJ2SEcyWkV4MUJneEVXZzRwWU5qdWov?=
 =?utf-8?B?bzBMdVZEbWI0TTRScndjdHlreGVzcHN0ai9ET3BXZzF1OFJkSU1td29YUVZS?=
 =?utf-8?B?YU5VVCttSFdDdk1Ya3VmZ0R4UmlrT2pYWjBCZThQbUE1Yjh5Q2J2N3NVTW4y?=
 =?utf-8?B?RmtYWmZSemJDSkdkaWIvSGduU0c3WU51TjJVM3JlRUZwbGhhVW5YZkowdndR?=
 =?utf-8?B?SHJzeVNZS1lMLzBuOEtCTG5za0w5TWFQMXhEUkt1b0MveHgyK0V1eVZUYUZI?=
 =?utf-8?B?UUtqUEJiWmZ6SHY2Zlc2NEdNckJ4eENCc2luZFU1MkV5bDlBZ2lRR1RtbXp6?=
 =?utf-8?B?MEhHaFluQXVEUjBnOVBOUEVucDlLdVhXTDl0SDZzbW9PMlBlSVhkbXdCNWxh?=
 =?utf-8?Q?4S+RA9oD1whwLJXAzo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S09OdldSN1NORlIybE5TT0EwM0hUQkZ4bzJHRGhXR250aHo2NTRHYjErZU5O?=
 =?utf-8?B?aWlLR0hGVUJpanNVeWpvVm5LSG5tUEtab2lZcVFvQ1RwZHQvdmNnelQ2aEdH?=
 =?utf-8?B?N3VCc1VHSnh0SlhuOWFlRXBZYTZTaWd3OEdsUGJPNjNtbGs1c1BTUDFKdytt?=
 =?utf-8?B?ZkdPU2hyd3lDd1ovb3RJSzErd0ZFTVF0cGViVVZFd3p5ZUQxdVRRSS9keTZF?=
 =?utf-8?B?cDFNZWd4NnNXM1dJZUJHKzJocDdVVmJWdFZHSloxRVdZOUQ3TnlUVEtXL2Zj?=
 =?utf-8?B?bE5sTHdOcldJSGkrTEtUdkRla1NiM1FkUy8xUS9rYVRXcnNTY1NkdE1MZTJM?=
 =?utf-8?B?WklPRjdTakh5YzZOMnVYYnhaeHo4K2FqeDVFZWxCL2EwVXM4UGdSMmJzVmli?=
 =?utf-8?B?UGF2c0dJT0gySlNZakZuLytDUTBkdjVPVTkzbW50WWlMcVlNd3JoR28xZHZy?=
 =?utf-8?B?SXBDaEQ2UTRqMGplSnJoTGY3NXhjWmRvQnFaQVF5eVVCMnhOdjNrajhHVG1z?=
 =?utf-8?B?K3lrU0MxcnF6RXRHSzJpWHEzbyt6TXAwZDV4K2pYSjB4Y1cwbmdDUFBnalNK?=
 =?utf-8?B?Y0JZVkhmZHMrSXRRbzhjMzlmRUJpSXpaVnVURlJPWitma3ArTVNJUGl5Zk14?=
 =?utf-8?B?MTg1ejQzQ2FqazFFbFVLMElrNjkrdHZrSHNoV0xaSjg5Z29pZEFUUzJkZG55?=
 =?utf-8?B?VHp6UXNGdGhjZEh3WkU4eGFsRlFNNmNWTHB6VTZ3L2Vub2c4eXFLblhjWWJZ?=
 =?utf-8?B?RmdYc2tRVW9qNWs3c0dWRmV3QUhKOFdaeTJOWW5US0hYWUJ0WElSc0ZrSkV2?=
 =?utf-8?B?WWYrZ3lRWG9JL3NQN1ZBMFdqT1g4K09ndXBwRlV0ek1MMDdUR1pndFNtR3dj?=
 =?utf-8?B?cXlaMXBjUW5DYUNLYmZHSDR1NHdFZk5DOVR2SVd4ZTRUT3hGU0hLdUtSK1pa?=
 =?utf-8?B?RDd1QW9iVC85S2l3M25KZlJMeVZiN2R4S01sMG4zTGc2M0pLZUQ5bTIrdlNl?=
 =?utf-8?B?d1I3RnBKTHJhUUZiZWVxaUM3T1o2ZlkwanlYa05WL1hKOXVEVUdEeTNrOFNi?=
 =?utf-8?B?MDhYbHZmQXZ5dyt4dXhkaVY1eEwvaVlJM25qV2VSVHhlTHZIWnVkTFBvK3Nw?=
 =?utf-8?B?cXVSanRoNUlmN29wb2MxeFk3aGVyRmdENFhIK0UzRDc3WmJzKzFqSGlvVnVk?=
 =?utf-8?B?SzE5M3BFcGMySWF4cTNFdVA1NitPc3A1Z2U4YnhUS0YrU0lEYzBVWEV2aHNp?=
 =?utf-8?B?MXN2OHdEMllqc0hVYTIyWWM1REtoRk1IVUxQRlVHbm9valpzRTN4b2ZHUzM3?=
 =?utf-8?B?ZjZkN0tCenNrTFBxd3A2cTlicEZsNkNCMTlramFJVnhmbUN6TksremFGaFFh?=
 =?utf-8?B?bHFRRUU3aWkxNnRsL1d4OEN1YnVTN2hNVllMaGdlTGwrRmhBcXpHaytJcDY4?=
 =?utf-8?B?MkZHd1hKZ3VTMFhJS0YwYjRIUVk0N0VxbVAxZHVZQWtHUGV1QTRDTlI3ZmtR?=
 =?utf-8?B?dDJ3ZW5ZUXI0b21oK2FpcW5McDlkZ2hPTnBQQUxHaTZ1ZmEwSGVkRHo0TnMx?=
 =?utf-8?B?elREK2tFM1BHRTVRQVN3Y2RUS2tCMVE2VjdkUnhTQWFsY2VhQ0x6a0QzTk5w?=
 =?utf-8?B?OGlTc043bVQ4WFBHd0VPWUdLMDZZNCtFampYNVRuUDIyd2VWZzM3RC84T0xJ?=
 =?utf-8?B?OEVwdFBYS1JQSkg0OS9GWHd2M1ppZnh0MkVOd2FVM0p1dDZWQmNWKzNhbWRu?=
 =?utf-8?B?NXlSOS9WVmRRaU10VmpyQlFoRSt4cDRqZldVdXVNWkJ2b2kxb3FMWU5BWklF?=
 =?utf-8?B?S2NwR2o1NjkvVUdrdWVLMnFCT2g0S2hZdS9SNkREeGZPUkhxTUpFL3QreW44?=
 =?utf-8?B?YzIzcGY5NXBsREdqTnJoSVFUSWR6WmF6eHVMekpWTnFMY08yNHZBODUwZnJ5?=
 =?utf-8?B?WGVRcDN5OHVoRC9JU04xVE5HZi92VFhmTUpycHFMZXYwd0ZxQURnR1JvdlVH?=
 =?utf-8?B?WWF4KzFiRmZ5dS9LVHU3bU00UjN0UVFCcHNBaHBjUVdDSEVmSFdPaGQrck1j?=
 =?utf-8?B?ajUrdUJrT1lyc3Bhd2RhMHkwdlZDY1dNQjhPR0hFZkYwby9sRmRRdXhCMDJZ?=
 =?utf-8?B?cVVmUEpjZG45VHA3VFVhaWVRQ2lXbWlybmRWb0lGNGltb2ZSUmYxdXF5TjNW?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K8yAgYe1k4hxbBQwfrqJeo+/YaSEdBqoj1dv2rKl87eSredTBgKz+rQt56eo+Yq1tB4n2cOJ4hv22t8Lg4aJJPvtqi93ZKVQQAryLZY+W9kuCyQI7anKEBYuvNyp1s8y1fs+4kKPbI3c6AY6Bvp1LJqVoqT9YHmhiWiqit3zk4JR7gOmiSt90powL7KZEXHPh340F0TbTOljWfaPZmAwjKC/BbiV3M8lZbgB71rjVRjEpZCi5Yzx8EQ97b+qR/oMftj+C9ZLgkQkpRPiPZVFofg6himfANxpCeKyrGgkpH5QsoIDNJDBKvesOPU+pR/MPNlG9H3JPA/pu7fJtDi2/+9uyMijaMWbVBqLqmfYfs0ddbTDroLwcbPy+M7P0J9ZrS3mhpE+J3tHEy+7APhUyv3iTINYzve2mIl9PqHdDQ2qZxO1wRVKCNlUyBWS1TMlV31nzrCINRCw3dqN2D15F6vXADJhIqhof5XiXQmWHcUmSrj+YSHPNc1xZ2ChaZMtgIRfwcm3TySIF9hqVngiYLl6nVLbaOCdgHMAWxU0ysMvbpM7q78p7rxQRdBeD7nUCUHgbPHlyMXAGlgBtzNsTmOGV3GDnEgCBbasO9HdR1k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f92d54-e0ab-48b8-0253-08dcaa64fb5e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:43:07.2742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRltn5ef/8QEEoQl1M7jNFPdo1pf8YU4OvzyR3yx1ucOlO258ujTwx5rnkFvbH7HSgjvJPW/yvFJsq/HqeLJPBgARQucPBFRQRHB9XsfLWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220118
X-Proofpoint-GUID: lioR2V3STX6fU82HH35CGipgtrdb4wYv
X-Proofpoint-ORIG-GUID: lioR2V3STX6fU82HH35CGipgtrdb4wYv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/07/2024 16:13, Cédric Le Goater wrote:
> On 7/22/24 17:01, Joao Martins wrote:
>> On 22/07/2024 15:53, Cédric Le Goater wrote:
>>> On 7/19/24 19:26, Joao Martins wrote:
>>>> On 19/07/2024 15:24, Joao Martins wrote:
>>>>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>>>>> On 7/19/24 14:05, Joao Martins wrote:
>>>>>>> By default VFIO migration is set to auto, which will support live
>>>>>>> migration if the migration capability is set *and* also dirty page
>>>>>>> tracking is supported.
>>>>>>>
>>>>>>> For testing purposes one can force enable without dirty page tracking
>>>>>>> via enable-migration=on, but that option is generally left for testing
>>>>>>> purposes.
>>>>>>>
>>>>>>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>>>>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>>>>> migration and thus enabling migration by default for those too.
>>>>>>>
>>>>>>> While at it change the error messages to mention IOMMU dirty tracking as
>>>>>>> well.
>>>>>>>
>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>> ---
>>>>>>>     include/hw/vfio/vfio-common.h |  1 +
>>>>>>>     hw/vfio/iommufd.c             |  2 +-
>>>>>>>     hw/vfio/migration.c           | 11 ++++++-----
>>>>>>>     3 files changed, 8 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>>> index 7e530c7869dc..00b9e933449e 100644
>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>> VFIOContainerBase *bcontainer,
>>>>>>>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>>> **errp);
>>>>>>>     int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t
>>>>>>> iova,
>>>>>>>                               uint64_t size, ram_addr_t ram_addr, Error
>>>>>>> **errp);
>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>       /* Returns 0 on success, or a negative errno. */
>>>>>>>     bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>> @@ -111,7 +111,7 @@ static void
>>>>>>> iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>>>>> *vbasedev)
>>>>>>>         iommufd_backend_disconnect(vbasedev->iommufd);
>>>>>>>     }
>>>>>>>     -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>     {
>>>>>>>         return hwpt && hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>>>>     }
>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>>>>> --- a/hw/vfio/migration.c
>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>>>>>>> Error **errp)
>>>>>>>             return !vfio_block_migration(vbasedev, err, errp);
>>>>>>>         }
>>>>>>>     -    if (!vbasedev->dirty_pages_supported) {
>>>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>>>>
>>>>>>
>>>>>> Some platforms do not have IOMMUFD support and this call will need
>>>>>> some kind of abstract wrapper to reflect dirty tracking support in
>>>>>> the IOMMU backend.
>>>>>>
>>>>>
>>>>> This was actually on purpose because only IOMMUFD presents a view of hardware
>>>>> whereas type1 supporting dirty page tracking is not used as means to
>>>>> 'migration
>>>>> is supported'.
>>>>>
>>>>> The hwpt is nil in type1 and the helper checks that, so it should return
>>>>> false.
>>>>>
>>>>
>>>> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
>>>> consider. Maybe this would be a elegant way to address it? Looks to pass my
>>>> build with CONFIG_IOMMUFD=n
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 61dd48e79b71..422ad4a5bdd1 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const
>>>> VFIOContainerBase
>>>> *bcontainer,
>>>>                    VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error **errp);
>>>>    int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t
>>>> iova,
>>>>                              uint64_t size, ram_addr_t ram_addr, Error **errp);
>>>> +#ifdef CONFIG_IOMMUFD
>>>>    bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>> +#else
>>>> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>> +{
>>>> +    return false;
>>>> +}
>>>> +#endif
>>>>
>>>>    /* Returns 0 on success, or a negative errno. */
>>>>    bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>
>>>
>>> hmm, no. You will need to introduce a new Host IOMMU device capability,
>>> something like :
>>>
>>>     HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,
>>>
>>> Then, introduce an helper routine to check the capability  :
>>>
>>>     return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
>>>   and replace the iommufd_hwpt_dirty_tracking call with it.
>>>
>>> Yeah I know, it's cumbersome but it's cleaner !
>>>
>>
>> Funny you mention it, because that's what I did in v3:
>>
>> https://lore.kernel.org/qemu-devel/20240708143420.16953-9-joao.m.martins@oracle.com/
>>
>> But it was suggested to drop (I am assuming to avoid complexity)
> 
> my bad if I did :/
> 

No worries it is all part of review -- I think Zhenzhong proposed with good
intentions, and I probably didn't think too hard about the consequences on
layering with the HIOD.

> we will need an helper such as :
> 
>   bool vfio_device_dirty_tracking(VFIODevice *vbasedev)
>   {
>       HostIOMMUDevice *hiod = vbasedev->hiod ;
>       HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
> 
>       return hiodc->get_cap &&
>           hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL) == 1;
>   }
> 
> and something like,
> 
>   static int hiod_iommufd_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>                                        Error **errp)
>   {
>       switch (cap) {
>       case HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING:
>           return !!(hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING);
>       default:
>           error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>           return -EINVAL;
>       }
>   }
> 
> Feel free to propose your own implementation,
> 

Actually it's close to what I had in v3 link, except the new helper (the name
vfio_device_dirty_tracking is a bit misleading I would call it
vfio_device_iommu_dirty_tracking)

I can follow-up with this improvement in case this gets merged as is, or include
it in the next version if you prefer to adjourn this series into 9.2 (given the
lack of time to get everything right).

	Joao

