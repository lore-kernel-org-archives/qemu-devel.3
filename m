Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CD9C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 18:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taIY5-0002Tn-7V; Tue, 21 Jan 2025 13:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taIXr-0002MX-An
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:00:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1taIXp-0005wr-DN
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 13:00:11 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFDwwp022689;
 Tue, 21 Jan 2025 18:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=H2i/Da1kyPhGm3zGe/iGWDlBTTUIGXSEzvHMYXdB4lA=; b=
 O8BmJpjyNVPjegOBcp8V1+g6J704cxfBebP8VlX+IDSJatiSUBWw9E5iGGbL0DiS
 VTWHdS9x5i7IiO65Acu5YTPw2qYh83iXDNMmEm/LpOsXBTFlA2An2cnqYNbAyFEW
 OI4Hv+wEiQ/2f2+efIub0uBULCGqDe+llVM3wxK7xzOwVWhh6Naq1abTaL1SCu+4
 /Hflr4vL7fiyvFomysa3Iqi6MtXxR1Ga6B5hVq493L5AfZ3G+0zSTeozNiYeRKDE
 njbNW3jHYBJGSXutbnRG7PpqzjGWnCsW6jxKE8rvVGAEto4uLZlF21qh9AO2UgAZ
 KHz68UL+7/zw3fm11X3u2g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485nb62cp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 18:00:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LH4OKq030323; Tue, 21 Jan 2025 18:00:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4491fj4s9v-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 18:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HC9EsRosWZomXIX4gQ82n9F9/tThujTVvHAf5Z4OHe8YDg+zD0zU6I7MJ2OzwNPiVCC87X5RFVgVJaNTUDioUi3f22gp0RLU9YP7+NW0GogAm0CWbXCeKaEWPbXhXGRACVAV7owfag0fwB2f+ClLfXX/bJURLiW0R7HZm2vX5QBrgT/brkvSSdjIhprgzc98Ia5oaDdjyPyZHHcS+Fv6MuoTfcZQCegf0WkYWRP6fTR0f64GgdCu3sKiVvHYRmon+Wm9YNcqva61Q/qfGmHpOv3STGEqup2qqHnMDdFlEWuBub7QdWE5ZimyGrMkdfrlLZCjdTs0QKz5y20cpKMdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2i/Da1kyPhGm3zGe/iGWDlBTTUIGXSEzvHMYXdB4lA=;
 b=fHu2Um9Vqs765pyIH3NL/NVQ2eOULA8NKeUWXFttZJpR0QP1H+6bbTaiVBFIdv1O8WLb11K3G9acFEKYkjjDHwb2lUw4mK9qgmLet3oJWCIRg9I+Co4GEwcHzdnwJcn0G8x39xrnzJ6thTNrha9DzPzKIcgYtyimLF2dvDZBSu98KfoMin6Odn3m2ywmtHsMOlfQl9LuQpmIbyVE/L7+sQvnlzq8rUIT1VLOmQJ8BZSs/nabyPDmLiFi+aU9OOBMJRxBobAXvkMfHVlveru2JX0eFTiZFEZokrvQQFogxQEK2qr0DvYUT5pKio8AOvI72mXxoVq/L6wttAP4WbPrMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2i/Da1kyPhGm3zGe/iGWDlBTTUIGXSEzvHMYXdB4lA=;
 b=psoM8eCUxBO84yVc6x7yxArYSF2WLrzm9XQksTVl0mLjj+wPwKbwSDlHTY9rj1JSkRCVimkVNUles2S9VOXeOu+7taJXR3RDmxJr21zeN//gi+5hd5Fr9XQNLzsm18MdbCC6eQdIycbksJMh1kDYqWwS2FZELlZtPfStjmrQqUs=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 18:00:00 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 17:59:58 +0000
From: =?UTF-8?q?=E2=80=9CWilliam=20Roche?= <william.roche@oracle.com>
To: david@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 pbonzini@redhat.com, philmd@linaro.org
Cc: william.roche@oracle.com
Subject: [PATCH 1/1] system/physmem: take into account fd_offset for file
 fallocate
Date: Tue, 21 Jan 2025 17:59:56 +0000
Message-ID: <20250121175956.3030149-2-william.roche@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121175956.3030149-1-william.roche@oracle.com>
References: <20250121175956.3030149-1-william.roche@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0181.namprd03.prod.outlook.com
 (2603:10b6:408:f9::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|BY5PR10MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5bd20e-4be1-4b8e-74e1-08dd3a456b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OKBJ9HC5Pq8MfuI8SYKcgd8aL7e+HlfXMRZg1TxxULOk3jXEZKQmOcNg3OQY?=
 =?us-ascii?Q?fMTjyMQb8wVoOSOA5ZmuWV/0wA8uju6jiPqWOqaW4j6CP5U7YTBxJW7cnDY+?=
 =?us-ascii?Q?edEIZ7GH15zJX8gv3YlPZBcTPut0k8gzqSLunYL2eWP45NGsiX3kV5bfUOZM?=
 =?us-ascii?Q?nI9LeqmVZrZHCOwGGWMfedbu2/g3UE/Twn7KoA5BZTZA+kSpqB1T+PUVxawc?=
 =?us-ascii?Q?Vbnj5c+brp7RN98tm4t7LC0uByYz0RmDPi7E6siKoLnaQVXlNLw2c7/szTjn?=
 =?us-ascii?Q?GFDkRO2ubmlqPUfPrb+C45R1Bpl56SrN1RxhDTld8rvFsqIHb+nEeDiT/j81?=
 =?us-ascii?Q?BEoRkX43wGnvgR1+FQ/aixfa2Tt+60Q7slvJP5AO3hkelac+8DVGNAlKcaGT?=
 =?us-ascii?Q?nre3+OtCmX3EGKR9nHsBrHs0i4JV7bNCZM25tfjvnvRLL0pBQiyAbL3CAvs5?=
 =?us-ascii?Q?htyIeC+gntb/XZqq28eI59rJJDvj0nC5yOzq+kgwUihiTEVVIb9xDs8bJFZZ?=
 =?us-ascii?Q?vLzcXM0sR8JjaoW876sjxUnry8xFM6TClXpjzXo9RgDl7MdxaGf9dBMKlpXM?=
 =?us-ascii?Q?dbmhkldw1joVxx3RDw9iApszKZiyJ0dNDDLZLNRNGD8YdWrVYS6fPEPIDbyW?=
 =?us-ascii?Q?UQ4nBWAx/Sf7/nyElQ6h4mFhE66ri+m0DB+pFvSqfyfDYeYA/RqHDuXioCpJ?=
 =?us-ascii?Q?yJEoIn1/B/ICNa8U/VLeU/WEVu3Dv39PFZ0bU+arVMqSgMke+6g/DQwuukee?=
 =?us-ascii?Q?j6X7b7UBFUAdtQq357BG8z+7bI4+SdYXmyUdzmRxczbEQ5ELRH2LpCCHFyJT?=
 =?us-ascii?Q?nbMqxFIMTSzuaGl/oi+6t8+TUvlso2m1BQZ9BGCdqLTKr56PZ1F0ClciOMGQ?=
 =?us-ascii?Q?50aRodoZ8sJOZtDOjNqqlrJMH29iF250UZGvmD54aj3nSwDBXGZtZswZvYQd?=
 =?us-ascii?Q?Mz3mSd4pBoWR/I/GM8JCYTOpkXMRbRrU4bnzU5apwqPzT5iIsA3dIPFj4ycI?=
 =?us-ascii?Q?YysAqNo3TBB2BMsdjROx/z6CutfA36cahsFKUgUYhQp2z5/RxAI2kcrsZV/6?=
 =?us-ascii?Q?vuDXb2S7iRMGZEFz4oCcEA9WWACX8kXjBCQZv5Xzc9pK19zCBZoP7mHY1BsL?=
 =?us-ascii?Q?vq293OEKeuqZsYTOqKF1TcpYpcN58ZEK7b2/u7Rbn+oy8Aw6QYE9YDCTxeva?=
 =?us-ascii?Q?avH6aTnxUVvZjbHKrwhaFgvMbbZqohmLiEnlUBnes6lvMVdFcw7zbnYs0/V9?=
 =?us-ascii?Q?iZRdJksIFl96ujxFIlZN21x6wB/RkiEFw1lXK2Bs8JGV9rWZT/gfKa/nbtMU?=
 =?us-ascii?Q?sxwmPN98EHnYyvqGvc3eI7m8Xtn+KjyyV9RpIC7/g4Vpl5UyOmNkkBZ0wmIf?=
 =?us-ascii?Q?6/1fBz4jXEFihwBjnW0vLsJV0D/u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7329.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W1bXKY4b9/45CKXFCqILH1bCV6jIxOZ1qpLHVk2NF3AbHYwT6AUp049AdODC?=
 =?us-ascii?Q?lXn3YpiWAOXRKZHbd8dno5yCxgXgAi4VszI74xVaRZIe61+hD6oeE8UtRyHm?=
 =?us-ascii?Q?oBP3OIZrnnWkwymwbQer/mpRgnuNoyMRHrag9kUwT5LkkKhFdT1nq2jP1w32?=
 =?us-ascii?Q?tCiwT3P+6WAvtM6otf2yEqOnGIZosMCGHnrLgdlO4DTryocjPYNVggSFs4ZQ?=
 =?us-ascii?Q?OLxK2I6Xh6zjqCglrdQ7hUJ5y9c4yeQ3DRsuvbNo5mFoYqalVHC5CpE139TQ?=
 =?us-ascii?Q?dm/fYcKeVpreQgZQInBBSilSiceYlfUXCGuB7QzitHJOkWXGz0si2boRjSXY?=
 =?us-ascii?Q?ex58vrKnQb3yqpy4moeEmR6vLybWpZLGahMlAVhJUgw7dVUARNVy+oujZTRZ?=
 =?us-ascii?Q?yzT6Fg2NZb/9vlplsFszDVe9lbZjE7vShv6FIbu8lXoKlY8oqvHVgHgkOPTF?=
 =?us-ascii?Q?N9g2P3XDveLu4UuXpL3KyD4/pxaj62HU97GFCeBqDBcQ1G8qR5VmY4QeemrI?=
 =?us-ascii?Q?3tCg2JCjW9RSrnJje98hucrrOPqtAbkaQoMAv/AAAzBxP45WQCF7f7mr/hSU?=
 =?us-ascii?Q?7o4nTtlHNGkWammZU5NwQBkH824l77L+bP/AWujmhv3WBnKB5osBJvaFjZaM?=
 =?us-ascii?Q?aTb3I4LGDmMMV1iNEMLXDfT5jIAr/k+kZlYmpmQpH4ttnIRIwtV+hTRXk//O?=
 =?us-ascii?Q?/KOp0lT/in5tCsSGGIj8525012U1LUHkuOilKKcIB7gPrQzKfB1dw39uLvyH?=
 =?us-ascii?Q?iI/fhTRTpBV9Q4ol3chlsgp1vT93hsINMFPzycyeq2wBAun5dRsJeusrlfrU?=
 =?us-ascii?Q?Xw4m5jEPHoXj8pEH+rOFmULQajoiDliSyAnEUjVoLUXwhLI+BiAnnEyM2Iji?=
 =?us-ascii?Q?+EEVckpXmA9fhySik2rGtNsUqVMx4oisdMHqNaZ7kTAdFR8kiXeg7VQLbC9f?=
 =?us-ascii?Q?lS2Wm5C1n8+Y5i11BnnDp0fMYs9Azm1of9swICy3FeNH9a+fWcsV4umNnDAx?=
 =?us-ascii?Q?WZYZvHTciLgJmEgaITR4CdhVVIC1NkcYK9Q8U3sqmPbEdhbqeexEtoKE+j2Q?=
 =?us-ascii?Q?9QGnguS6Yp6OitcjPqJudYGy9QPwJDob2yd6SKQbrwm7MBc6BFf6tL0tx3Og?=
 =?us-ascii?Q?vg24MwSsVfxHZVzZfzXigO7Om/57BrVs7u4VMN/F0VkHlUsxu5vXT4FjRAbs?=
 =?us-ascii?Q?oYXWdljJBDdb7Q1Qg8QVnWvqMZ7/Ix2wrsdmBweg+Z5TxBy2ejuGkbaimHfX?=
 =?us-ascii?Q?qaytwynXp/BonTa/+uLLoA3T8CgxvIfH7K2y82g3YJ34eoortIGiJ0vHW+q6?=
 =?us-ascii?Q?HrYh0bNCAqGGF3wBmuxyMX18yNG2YJBNXN9bgNiX5JKhT7lOgjglwH+toHOp?=
 =?us-ascii?Q?q1OMHoQe9DrSZLD/gXgQBEyL9dGp2ftneqyT6w0S0TCEXUx1BWBg6RbIlvyC?=
 =?us-ascii?Q?3ds6meDoRf7MORUpJjUraM372wbpbs9nOSMEniLNrU1uDOdX6fcdRZSGUK01?=
 =?us-ascii?Q?7OZPT+w/8uoYybcwkRC6Pa0Xto/GI/IjihbePnp8Watfn44CaWDohR6tZX8I?=
 =?us-ascii?Q?ot7wzEP2FvTKO2cN3XiG8XXxGSpGmKFlrAKKhtIjoCXJfXeomguEq4IFf/xR?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jygNRjUWIt26rfuDY9HhpZ9VhXJkygZa5Zvi9ZdINqCXmxc1lCD9dXNgK7+HunV1Vnj+ds2x5HkR/IpeWjXK24x3uHId+Gvc3b+hoeM5rTfTmHxKkifJsorgGAfXWDA76/sFLVaNSAK0FXecLvUl7MVbqrDFNd8v4M93mIsCtBsCbIsvVj8FF3FmdkslPF3FhtMOKEjzC8nFNR9KjJmaxg1YvJufQFGWNUB5iCY9nMLVJ63oTjzBoO5Eo0sjWuPqaCW2jzXF5OtXbC8LllJ2xDZ6yEze5v20YCW8pWId8uDUHmSYXjAehitOShj6WlzpEG7y6NCc+CgvTwm2Oaqzd15qzZNeQwZZx96ToqpimXXpf0IxEj0SWOL59qmG6cmOHO6zA2/RifgLgXav0x/h5+i2UhLsGUkBkGc8miBoNgbTlJhSv4oR9qZJBErxGOhxuxLQI1D2k0pCbW7ykxsgjejnftpaIYC0ZL4TY17KzNyTIH7RhrxhezSQFWwz/SrjU4UmiHf9GKWglgM6HBKwKGWmtLzQCF2eW8k0Lb7ecvaLcRU082u0VYfDkhMvKxXR191i8ozFaU8QTmCpD2bSIo/4bFs0nBHiiAva66Tiil8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5bd20e-4be1-4b8e-74e1-08dd3a456b43
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 17:59:58.4423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1jcy+X5J1KiyidMbf4qEldj9O4Kkn0jMibkiYsezs67mWQVnFkI3guxNzVH0ar+CsGSxwK6RXsv89e4EzlJnOaCH04xTFAzg+kqcoQngIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501210144
X-Proofpoint-GUID: _VtL102bNzFoqatWbZp5d7onPxsSzr0n
X-Proofpoint-ORIG-GUID: _VtL102bNzFoqatWbZp5d7onPxsSzr0n
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=william.roche@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.086,
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

From: William Roche <william.roche@oracle.com>

Punching a hole in a file with fallocate needs to take into account the
fd_offset value for a correct file location.

Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")

Signed-off-by: William Roche <william.roche@oracle.com>
---
 system/physmem.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c76503aea8..687ca94875 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3689,18 +3689,20 @@ int ram_block_discard_range(RAMBlock *rb, uint64_t start, size_t length)
             }
 
             ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                            start, length);
+                            start + rb->fd_offset, length);
             if (ret) {
                 ret = -errno;
                 error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                             __func__, rb->idstr, start, length, ret);
+                             __func__, rb->idstr, start + rb->fd_offset, length,
+                             ret);
                 goto err;
             }
 #else
             ret = -ENOSYS;
             error_report("%s: fallocate not available/file"
                          "%s:%" PRIx64 " +%zx (%d)",
-                         __func__, rb->idstr, start, length, ret);
+                         __func__, rb->idstr, start + rb->fd_offset, length,
+                         ret);
             goto err;
 #endif
         }
@@ -3748,17 +3750,17 @@ int ram_block_discard_guest_memfd_range(RAMBlock *rb, uint64_t start,
 
 #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
     ret = fallocate(rb->guest_memfd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-                    start, length);
+                    start + rb->offset, length);
 
     if (ret) {
         ret = -errno;
         error_report("%s: Failed to fallocate %s:%" PRIx64 " +%zx (%d)",
-                     __func__, rb->idstr, start, length, ret);
+                     __func__, rb->idstr, start + rb->fd_offset, length, ret);
     }
 #else
     ret = -ENOSYS;
     error_report("%s: fallocate not available %s:%" PRIx64 " +%zx (%d)",
-                 __func__, rb->idstr, start, length, ret);
+                 __func__, rb->idstr, start + rb->fd_offset, length, ret);
 #endif
 
     return ret;
-- 
2.43.5


