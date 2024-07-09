Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9D7C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6rA-0001k8-Nv; Tue, 09 Jul 2024 05:09:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6r8-0001jS-ND
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:09:51 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6r6-0008Ne-VH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:09:50 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tpXP016228;
 Tue, 9 Jul 2024 09:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=O6WT+Gvbj+J0Ov3z/q6pNHQYglfLKGYf8NF172Vcucw=; b=
 NIPVAWFYeC37/fAIcZ4mxEJIOqS8YxLRFdNJ6mo7YZR6MCeF4GzoicexPrCuSQQF
 lyqKWciy8PtFEDvLnsbbS212g/KfGGjLORrm1rsVKOW6GxCC+Zmpsuo3gyGBvXoE
 0acprVmNgh5tjTOsqDpIaHrACDjq08zL04n1nsW43NJtJwt/zcr2Q0YTQumFJMel
 idzISV/DSQ7lISxoIcpBf898KZwxTsY6K1sweCtk0jJGqGuNG1LDAreTIQLHyOWd
 UWYv1cr0tKSg8nti5baY41sRul2qrfhj2e4TZRRKdrkcNJvjXscsRKwQKySXayZ1
 XwkT0ZJ+gEmZ4olfFzkxcA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcceym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:09:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4698P7WC005679; Tue, 9 Jul 2024 09:09:45 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407tx2dr4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODQMQO83q6VM4Cwa4PC0wEEVlnKIeAFfMzypW7lpdVEZMTjY62JiY7TUQikwbTJR6kpmllueJXxCvT/JLhMCcnXz1HOXDydMjcFkzkrRYaSWPugn6BvJK9cao1Fmo3yUecpBsvFUiU0ZFkMjEsa4B93SmWwAl2BSBtOPPlAFpZmqPMy8PJlc17UJ502wXwiUS3TLckYClnat/ZoiwefhdmzigWaVfMZcULx7xr9kEFTHQP53wHXHDK84f1fNlecN8Wai9GTN5zgOvZ5lmn5N3bQo4HWHe5PVad5Qlx0JV2cAyCtAkwhlH0C8EQ1h1URfhGUO/zt0gQKV0AiJd2uvhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6WT+Gvbj+J0Ov3z/q6pNHQYglfLKGYf8NF172Vcucw=;
 b=kAWVu8bUDB/jx0CFJkz0TMXNN8MnnprIOVHMQzZpuhF4ZZhYAONAt0yniQldPguSoQYc7WTt9Yh0+oweESCqPntzOjBQot5viPpcGLpY3LD4AEKUfwAAZkLiZcVEHp0LM5ekY5YAnPbNlnFBIM06pQspnRdcCOKVTAxvtfqYuMQlVbSSnIK82QRCh5BYpY0KhSHnEjddbcAw28Reg1hpiKD9ky2Syg3BQtM8IkG/HyFWr1CRdcd5UvJBqXaaBdycI6rZ/64UX3oZz/04u5qDaAJClde7UHlvU5DRn3Ud94P0D1wsZMHBpYTGx/HyWKZV0tcgGrsPDrjqPkMSIPocLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6WT+Gvbj+J0Ov3z/q6pNHQYglfLKGYf8NF172Vcucw=;
 b=xpeyRUVPVdda9PpPjToVV7U9FaP9DDme8E5T9mflutFVxdyzWYYvy1KSh7bi9XMwFnpLnC2VRc6BuW6sxIqtLQzxR1ANdcsZI05XouMzM7C2aa+9TLKFn2R/wrBMv+jvNX2TVZnCa94Zy8aiFr7AW8g2C0hJGCk5huqAzMBwfls=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 09:09:43 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:09:43 +0000
Message-ID: <d481a5e4-c745-40a8-a8a0-28383b101964@oracle.com>
Date: Tue, 9 Jul 2024 10:09:36 +0100
Subject: Re: [PATCH v3 09/10] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-10-joao.m.martins@oracle.com>
 <5f6ec773-536d-48f3-8d11-1acefe17abb8@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <5f6ec773-536d-48f3-8d11-1acefe17abb8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0034.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::21) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d1f4d9f-53cf-4eff-fafb-08dc9ff6decf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGhQOFR2ZHMxdWVqK2VseFZwMWFMaWhEd1BlQ1dkSzVWODhCSjlHZUQ4cXkw?=
 =?utf-8?B?TFE4OFkxMnhIZkNxWER4cURjd0RrTmRBUHN1UWI1dC9JWUlOQXFpdWQ5OGhL?=
 =?utf-8?B?K0ovUU9zcVZodzNNUzRXekpNTEQ0V1YwR1ArdmVKU0hNVkYvWDN2WjRrY2pY?=
 =?utf-8?B?VUFZbytxVWtKL1BXdnB1Smw4aTliV0U5S003MmRZSVlSRnk0WCswVVFaMkpB?=
 =?utf-8?B?QlFrM0ZQWlRiaFJPZ21iVys5S0toeWxIZXNhMVNOUitKcnVxeEltUzdZRjhF?=
 =?utf-8?B?bkZ2NTYrWFhZUnhzY0J4eHljTjF2SitIdUx5VG1vSkkxM0xneUt1dEhxcHVr?=
 =?utf-8?B?eUMyaGFkUDU4ak85eEp1WHlpREFHOW1neEdEVkpCbGJmbUkzZlBmTkg4d0tN?=
 =?utf-8?B?NFZIYndqa0RoT0g1QTFBbFR2YmM4dS9JNjkwWVoxcEx1WXd2VDhBU0V0SklK?=
 =?utf-8?B?dStVZExhSVBidm0rTjNrR2xNSUZZNDVZcnVkMUVuNEZsOUtCYWFpazRYOFNm?=
 =?utf-8?B?eXJBelg0UEhOZXN0c2k4elVOYnA0eWlVeVhNWWlsd2ZBcEtCejlXVEVVTDdX?=
 =?utf-8?B?RjZIV1FOMEhyc1ZVMkszQ3pBdEl1RVpXaHp0WVpwSVlKWStKb204YThpNDN5?=
 =?utf-8?B?cVVzdzM3N2kweXNFenNNVFl6Z0h1YVNyS1JUUVFOVzQrK2tyVldsSGIyZ2Jn?=
 =?utf-8?B?TVExaVFtRXd4N0xCSm9SbFJCQ2cveGVseXhQNThJY3l2YXhzbTFRemlQU1h6?=
 =?utf-8?B?aEJuM2FndElJeFVtdm1pN3M1Rm1YNWhyUlJIK1RjTkJIWkxKbzBmNDQ3azFk?=
 =?utf-8?B?OC9Ob1ZVVGU0NmFQaEMrNmxCSHlIcEZVclBPRy9tSmc0b2REWENsVmp4V0w3?=
 =?utf-8?B?eG4vMUtodDVNUE5qem1LOTE5WkhtOEtCTU9Qa0FUSVNpaFdGODFwMnprdGhX?=
 =?utf-8?B?eHNHY0dpTDhNVFlCV2NyQzN2TSs4VUJyQVpHS2hxaGEvTTRNaGpiam13YW5O?=
 =?utf-8?B?WGJvZ0lVMXgwUzN4QW5oYXhFaEsvM1FUNHpRcDlPZ0s1M2pjYWpXa0czUTgr?=
 =?utf-8?B?K2NLREtmdDIrOXdXZEk5QmsrblJIamZQMFRrdC9PRkhVWm5Jc014L1ZlWENP?=
 =?utf-8?B?Vk1uNkxnVmErMmNodHVDUjBqWVZpUmtXY1oxRUxIUFZXOEtpMzFnbHlzRmEr?=
 =?utf-8?B?eW9pSWIxcEh3VlFMaStxSUFUYXg4dUJVMjRyVjAyc3VGdjFRZUFEMlMzNGZm?=
 =?utf-8?B?N0RVcmNvei81ckxFWGk1b1dHR1NzRXV5TFdOMVoxdVB1MzR4eEN5YnFicGNH?=
 =?utf-8?B?MlVBTkhUZ1VYdHRzb24raHZOeFF3eENWNUhnYWNnTHE0N1M0eEJPN2dRNXda?=
 =?utf-8?B?c1FzNEhZRzZ2UnZSdkJpNjQrS3NmUG51Qnh4a1R5WUR1MERISGZPOVd3RGVT?=
 =?utf-8?B?QVNQa3RhMDVMdUljTFpPOWc5amNuOFpXeGFuMTJQQVNTYTQ5TzVURDBoQWdj?=
 =?utf-8?B?Q2FydnRrTmM5dlVPNFNKajMzcWRzd2hPVnVVWDA3d3F5dGlJb3dQWklOanNL?=
 =?utf-8?B?YTFNZ0diK2hqblU4YytQZmtMYWxsOVMySE1mU3FRbnBpUGVnVEdHb1BFQU85?=
 =?utf-8?B?QzR4RUZlMlFBQzhuT1p2cStnWlgwTjFERnk0aDRMbG1Pdmd0QWVHU20wa3FM?=
 =?utf-8?B?YldLb3VITE5YdnRGbm5kaitFV205b3BERGhla01Ja1laaW9WT21kb3ZXRC8y?=
 =?utf-8?B?MisrRlZyTGtQOXMrMUVhZU1TSXNSalVTb1lUL1VaRWVobzl4TCtDS1JXclVP?=
 =?utf-8?B?eDJIeEpFanVGTzNxMzEwUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3VVL3Y2elN6QmFud3V3VUtnbXBiWXF6cDRWUGNuaDQ5dG9yYzlNOVdOZlEz?=
 =?utf-8?B?OEd3bS9EdEpzc1R3ellIdFVTbzlWblBVRDdSQ0paU0hXOXBodlZ2T0ljSTBF?=
 =?utf-8?B?QkxzamUvR1JoZ1VtTHB1VU9YY251S0FxZ3I5NmVPYXdoT043cktsMkxRbVNF?=
 =?utf-8?B?Qlp6dFREUkcvbWdkRTRZZ2E0eTJNZHl5eWtyNkRTT0lRbG1mc0tTdU9NUTMv?=
 =?utf-8?B?dEpBUHU4dzJyRnc2d2U2R3hOaEkya3BlQUFLR0JtU3dCNUFhOVJZTmhzQUJG?=
 =?utf-8?B?alZ5SkhQeGVyTmpjT1FWak1QKzQ5OEtFR2U1c242SXJPUTI0UEVueHhEY3RM?=
 =?utf-8?B?MFBJemhJV1dZaWFBNEF1cEN0N2M2M0ZHbWZ2Yk5sd2hwcFdmNXY3R0dPRjRZ?=
 =?utf-8?B?c3pHdktadXVUbGVRMThNR0JoK01rTzNUWU0xMVRJYTZ1N1BXVmpadUxiTVV6?=
 =?utf-8?B?akVNU016WVN5MDNYRmNMS0d0K1VwbkUzcjlaODZIT0xKOG1ZYk5vSEFUbkNI?=
 =?utf-8?B?ckhmKzlqZ0F2NktXSWFRS1doVm02cmRZak5aM3FubXZtSnN0bURDRkx6WFhW?=
 =?utf-8?B?aVZib2haR0QybnRJM0pZTkxSNTNWYWhjQlFHRVBGUmpoeVhwaFlOQk90NDls?=
 =?utf-8?B?V2JMa1dYNkJoR205Qlltcy9CUnh4ZkU1bWw1bGxkZEZLeUNuWGRMbEdqcTV5?=
 =?utf-8?B?N25vcEVZdWRON0V0eGxKcW1SUDREY0xlRUNUeWxtUHYzOEZsKzdvdmdUb0Nq?=
 =?utf-8?B?Skw0ek9LOXFCR0VMSElUSlVtaUFQTFp1TUJNWUc0NFpHb216YnJPemFvTXE3?=
 =?utf-8?B?dlJNczJkR2Y5VWRranYvbFZqYjVjQXJIZm9yZFF4TzYrcjBoTWFmdU1RbGFL?=
 =?utf-8?B?bEV6NU9HMkQ0UHZvQkpNRU5aNFkvalNMOGhNOE1qTUNtVk9OMzBTRG43Y0d1?=
 =?utf-8?B?c3poUisvMG9LQ0VsSUVTTWNpVWJDUCtuSVVVcUUxVm1zOXRERGxPRW1TTEpV?=
 =?utf-8?B?eEpVOUh5c29uVi8waXk1MXlTVG1tU0ZIOXlBZFkyRnZRUG93aURXbCtyNmFq?=
 =?utf-8?B?MmJEVDJxMDhqTjRVdU4xWDFYaC9yNHlreWZQSnJUYW9WNDZEenRvZmJPcU5K?=
 =?utf-8?B?dnZjTGtFQytFQ2s3bksrQXZTQUlXeU1uUEwwSnlvRCsvbFV4eVIySjFacy83?=
 =?utf-8?B?SlQzZ0pWQ3U5OFR1RlVIVnVEemxYeVd3OTlncHQ0VExEVy9oNXJnWFZnbCt2?=
 =?utf-8?B?cEtnWEx5UzNkV3FNamtUVDhtcUZ3YmVYUkdoT3d5SGM3dGRONzA2eVQrTDNL?=
 =?utf-8?B?YXI3ZmE2aStmNVBXZE43cEtFbGg0QldXcGc4NzlOdjJLQlZhdm9sUlIydUIv?=
 =?utf-8?B?OUpiZU05ck9kcWxDZzBESjBHd1hVRlRtMkZFa2tlSEg4Tk8zS3FZWk5PY0FZ?=
 =?utf-8?B?RGEyYTJwL1VLai8yU0EvYlNTUkpNblViZHZEVm5td0JsNDZKTjR2YTBSMzN2?=
 =?utf-8?B?RlpqNzdKVGpKRldhNSsxYnpuSHY4N2ZnNjJzYVc5Zk5RRzExU3dFYjhOM1Fm?=
 =?utf-8?B?VTFrdVZPTUpTaGplSVFhQlpLUlhCSXQ5NndtSk5tWFAraGhZNTF1R21HZmJJ?=
 =?utf-8?B?TExTZGxVb3hCTHM1WlpDb1I3UmZmNlpDeGVhZ1RZZ3Q0aGQwdU5PdDJQdE1N?=
 =?utf-8?B?Q1hNQ2FHMmMva2lTZ3p3dVpiRU9ET2dnd1c0NVZydGxpNjFZbVV4ekxiU054?=
 =?utf-8?B?bmtXSHFRQmFIcVRLVEpUTHZ6VVlOd0VybTliRm4xR0paZmswb3AyZ1d6UkVI?=
 =?utf-8?B?alEzRzcxSkU4bnRZSjd3a2Z0ZUt6Y1JPeTRGY0JqeWJEb2VpSjdyWDJvTWh6?=
 =?utf-8?B?VFgxMENiemFpT0RFRkVzdyswUkpNdVJENFo4YitmVVFldzAyK1pRbU1WTloy?=
 =?utf-8?B?c2M5S2NYTFgzNkZsM21nczN2QXNFRFJ4eStsNWhhZEsyVUFEdndPMElUaGt4?=
 =?utf-8?B?UXcxOWNwRXJIdDJVbWRSb0FaUUhGeGRzNmMrUzhKYW5sZGduczluT09HeW5Z?=
 =?utf-8?B?NXJsZEZScFFXR3R0aG12WGxGdkx3MEVFOFZYMFl3TittdU81ZU5lTGVGNnYy?=
 =?utf-8?B?b0pRcG9DWjAyYzZ3K3ZKMmp1ZUt3bytaaUNRM3N0OGloUDF4QlVoZXhjYlNE?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eO7d64zJuZf/rJvFWNjYcAS+myX/JdWx0SQnjagg+HzL7d+wYABBWKU3qmJP4yt/oMmJPgYg5JP7aKIUF1KSeegAHOUZ+CWBHNRkgnfOvLguOP+CUcV1n4+hlQl9gXZt6ORs44PKWcr/4RTOaPf9hZs15HpQ1Y2NyYGvD3hoXStP6Vy6Tz0yabJjGGdsWf10+ssOTlnxhR39qmg6GPZtGt6TWMiyuYPA7D7T1GJF87RGX1nAY+8BgzhwEWakpSUoMQ9esyX5Eh3QmAEDbJ+6SMG8bJ/Ybm/88rCZ6WvRKex9JcBptF+EoV5CKjKNVU88Sm2t6MzYVt1ukTg9z6+FSJddta2j/Bg3CLeSp+evF9NzwoKnwol77rBvVcV4vZFPjrmS2zlGMVSIfd3VvRz5aT0gKCgKnc7ZvcBoYK/kwm2UPno3V/cwRrc60KmYp+beEVY5V7oA7JeRNRP8w2c7rdmqPzIlMUruDK6e4GV9N4xzCE9jEl6CRw+sxJtflIKZ4ctAMayfIuYgHuUaUnJYaVCs48pJ5o5UbjuF+wB9un8SQlK5esQ54Tl04ukoBxfLqzs05C+ZvHC8uEaawow9Agsb1HLs65/pI61OjFRN2WM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1f4d9f-53cf-4eff-fafb-08dc9ff6decf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:09:43.1545 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFe1h9igCYZ0Ik5JW/S9SvjM2JiV2C4bpPR0OksriKoFpbAHsHyqXMBYycTCyegwOX9cAoKX0/7nJ3VDYhE7/ukylZOXZPGP1THnGSwBlkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090061
X-Proofpoint-ORIG-GUID: 7iMNRCUiujAUArIWumkrj1zP2fEXOQaW
X-Proofpoint-GUID: 7iMNRCUiujAUArIWumkrj1zP2fEXOQaW
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

On 09/07/2024 08:02, Cédric Le Goater wrote:
> On 7/8/24 4:34 PM, Joao Martins wrote:
>> By default VFIO migration is set to auto, which will support live
>> migration if the migration capability is set *and* also dirty page
>> tracking is supported.
>>
>> For testing purposes one can force enable without dirty page tracking
>> via enable-migration=on, but that option is generally left for testing
>> purposes.
>>
>> So starting with IOMMU dirty tracking it can use to acomodate the lack of
>> VF dirty page tracking allowing us to minimize the VF requirements for
>> migration and thus enabling migration by default for those.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/migration.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index 34d4be2ce1b1..89195928666f 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -1012,6 +1012,7 @@ void vfio_reset_bytes_transferred(void)
>>    */
>>   bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>>   {
>> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(vbasedev->hiod);
>>       Error *err = NULL;
>>       int ret;
>>   @@ -1036,7 +1037,10 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>> Error **errp)
>>           return !vfio_block_migration(vbasedev, err, errp);
>>       }
>>   -    if (!vbasedev->dirty_pages_supported) {
>> +    if (!vbasedev->dirty_pages_supported &&
>> +        (vbasedev->iommufd &&
> 
> 
> I don't think we need to check ->iommufd. The class handler below will
> return false for the vfio/legacy backend.
> 

OK

	Joao

