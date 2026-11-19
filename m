Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952EA606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=D6O1MRY4;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=K7r2z/Lb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU4U3-0006Dz-2k; Thu, 19 Nov 2026 10:55:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xU4Tw-0006Aq-9c
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:55:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1xU4Tt-0004dI-P0
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 10:55:27 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJFKH60708395; Thu, 19 Nov 2026 15:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=J/QEU3Uf4RRJiZt2O+pP/tWjkKkJ5EQ7ngXaaND1qKs=; b=
 D6O1MRY4iCtdFQAAos6kiDub3Njw+HHD2wKhds1PfLPq0fUAS4LtcZQRZ6RiSwiS
 ogHpIHhx8DG+UVXyWBfiPog4CeLaypONs12xoWuozKNVrzgxuMr31K0A4HYz3S8F
 rMIS7ltOgkt7BYWCN3iwhnv2G15gXrNIRKlma23v+89r7tO3okODkjYsvkOQxotI
 C4EkjhuyJhcWD5l3P+9IGDxzq+Ankq48/FAiLiTgFpF0rRsH1CYKHme6yE4ymvrC
 YrBDbx/Uf7HBnoW1u3phkWL+GtdOd/CjxI5qyFVUGs5DuXrgeymKT190zAUTJsT+
 N7Jg/bef/5U3ntJ+c3MqZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4j0ytsb4xj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 15:55:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11)
 with ESMTP id 6AJF8BLB2443658; Thu, 19 Nov 2026 15:55:18 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4j22tqkq5b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
 Thu, 19 Nov 2026 15:55:18 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ozxsM/oi0f5obvVDVT5sjSK+eZ3xkh2/dGkbxO9pQDdTFEMIr94+pJJBs/yp90Wok0+jgZhehhaTd21PM4+7O2ugak/VhKH0U1rH96jX5Z7oi8cD/BP+wG4PpQK1f+zhOl33EOj4NNwMo6P9ERNXwjwlHQwBpnyn/ItIrBbsin3U3a/hu5se79PtMOL9xio7K0rwU+sGLIRn7mCR2P11VIHQcofI2VwfdDSZfqCLaEbCWebETg7ESCkTREkovgGqKSbzK2Avw72jSUNm7Ud7BMjEvYVUesBe3XPOi8qX5lKfGIhpSZSdZwtVzE4r6eaE5cVN+Rb+mA7uCyGqy9vP5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/QEU3Uf4RRJiZt2O+pP/tWjkKkJ5EQ7ngXaaND1qKs=;
 b=mFjg76mWmcS9S7oB2RaaAoIN5NxTpQWzJ0fF4OFcWEYTze8XWl5q9+PJszxAyIdHvZxS7ESqbvO8leur2G2pqEBwIuHRucCk/H+q8LH+/LIP1lg3739yHnZAC8qmuvVV67WKZ/QVr05wue5SpK9+QzSfxuDHLwOrx6RhcFTW2rYGrfEjhtxtrjakAzNs67D72p4/fuVKGPsl5C2KJWRwbH7Ea92B+5Yq2AejTtv0wB/RlMvw8I3pjC7PWaE/TnDl27GrxGx5xDKZZkM98jOaanpAQPkdBMTTtMIqYNSOTcYWr6H9li+LECmJluJB/Zs9B2hlO++NwJ8VdokZ1cGYBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/QEU3Uf4RRJiZt2O+pP/tWjkKkJ5EQ7ngXaaND1qKs=;
 b=K7r2z/LblE1fbxxNUm8d8MwZNfKA14nxC8DPza/nAikApwko3wcSUeHc1f/ekJyESIYJnD/8vbXzbiuaFjTzZtrxFUCPFt/ooY0kBiwHgw0U06YG0UYb2vmeddfNCOavR1sfDbwO5QfDztVgo5CNNdUXXNDqQtwHWaRQrLWDiKY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by IA0PR10MB6892.namprd10.prod.outlook.com (2603:10b6:208:430::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 15:55:13 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 15:55:12 +0000
Message-ID: <e9298e9d-7f89-4324-9fdb-dcaa1e5bd514@oracle.com>
Date: Thu, 19 Nov 2026 10:55:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] amd_iommu: Bugfix and Cleanup for IO Page Fault
To: mst@redhat.com, dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, sarunkod@amd.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, joe.jin@oracle.com
References: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20261030003817.3521476-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR15CA0018.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::11) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|IA0PR10MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfd2151-1a82-4667-1d5c-08df46557eae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|56012099006|261009223027099003|261021123027099003|261102123227099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 71t0LMh95i3EcbkTHSdwTAjjhXFEkNYRMImdILdjfP06TgWVtghwlchUKLUmKUL6gdcBYs5aByC53KFxivb3roe+vtJAQ14UOyN7e9/zBZ8fnDJ7ug2B2u5VHqxZ89mGXT2uRjFT6Pyu0B/bwa1u8XtlBbW/8Fdm3wpWQ3CpqZy8GgBM+ooCYdo5OBb66epT/WafLxLQ4lXWQh36b8lIlG3qT7/T4eFfvBboUQ56i+tqsu9ie9esbSfAVWOp3YvJX/CmeiUXNpf2Bq2p+tmnjAuXIn+H4Vghhl3B4Pz4NhollNoQ6rtCNX7M7/YqLSEdHIMY4/j9Eq3MDwWVI1pPAhg7X/bNrgWopyfnysjgDYhlFRhqztqTaifEeMV7aX6VCHdOYGAZr4T9ifXTX4iNl3nIgEG7qhbWShBV9t2ffodd62ViQZZGmVxdHghbUx3t0xUmrCAZpkW/wETrWcKOYx1zTPSNL9+I3yZg2hjtAC3TuSo5iEzTBzObqSnPkobSjr5iZRNzngfv+rKB7OB7cXuLEwIU8g20zB+85wJEAklRx/C4whPtdDkw0eYBTHTjTT54mXx8rV/OYPgmKuOxaQsdCr6zmNEtSJ0mQ6hDlYgOvtTp5pmAInLNTtMm0jnh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEdQVDVtdnJkeWxvaHp4dVNaOUMzVFRMUFZVUzE2Tnp5YXhwOUZQVDExTTRa?=
 =?utf-8?B?dEVnNWJyT2dNSFpuUXdPaThiWUlKZzB5UkV3NEp6cFR3RlZ6R2FudUFFbVZu?=
 =?utf-8?B?bTd4cURpYUV2cnJGeGhlQ2tQVVlVeXFwTVYycjJvZmpOdGxGdjRWVzZmUklv?=
 =?utf-8?B?YjFrYVpGVWlsUS9DL3ZqeXcyVk5uelZPU0xPTklrTnliWkt4YjBnMituNXBO?=
 =?utf-8?B?UHJIN3N0aEdJUU4xL3BldjFGNXEwaE00aWFub0JqenkzNzZreklCMXdsRk9t?=
 =?utf-8?B?UDExK2tRTDhadnBJN1ZSdmNoS0JsdFJRSnB3a2s1QkFIK3RacnNMSExuSm11?=
 =?utf-8?B?VUZocDBLY1NuU0hXd0tIYkJsT2ZSYmtGVk8wT3RpaDFQMEdIbytUelRVV3hl?=
 =?utf-8?B?VEROckdyY1ZUMXZrOFVJUXpIeUtiSjhIVnFrZWs1YzRKTHdWNWJHWmpPK1ln?=
 =?utf-8?B?WFowbk5WRUNpcVMwNmNDdmVPSlFtTU9lLzF6NndNWlhaRllOTVRLUUc0UVVU?=
 =?utf-8?B?ZWhaTlkzcUp3SjMvMkRSK1QwRUsyMENjZEJQaUw1LytPUWR1Q1Q5STdsazdP?=
 =?utf-8?B?eExtSVRYYnRUWGdubW0zRWxVbEV6aWNIS2J4WStUNTFpdXNzdk5mQ3FBd2JI?=
 =?utf-8?B?MDMveFVteXY1NS9BbkxIb1IzRGtuZ3lnamMrQ2lvV2szdXh5UE5CSzZxMnNS?=
 =?utf-8?B?TS83dE56TjBNZUd1U2pKZVc4TjF2bTIzVGJjdDdDN0xVdG0vUmJQbjJ1a3pI?=
 =?utf-8?B?UkUxS3VQV0Nud043Q1hVNExxZDA2UXp3b09NbEdWQ0VjRmQ2djd2RmFYZnhR?=
 =?utf-8?B?aG05TVZpME5QUC9rRkJhemRJOEZ4UDJOOTMwQ21GTDFyMVVKMThpRURnQkdS?=
 =?utf-8?B?cnpsYUxkeUcycXRqVFZMcHZnT0xUUmt1c0UvQ0l1dFVQSXFRMlBmeWpLRmxC?=
 =?utf-8?B?dmtMVWpLYkU2UzVwbjZ3ZTNYTHVWUnpnVW9YL0J6VWJHeUowVEdtR2s0anB4?=
 =?utf-8?B?QTJPVnRNcGx0K2pDamdzMHFnenFvdDlwb2NsT0pnUjN3d1plZC82UmJGZDdG?=
 =?utf-8?B?bnNhWEZJdVZGU0ZvMzlsdkN1cGVmZnM3cVM0N0xKMlpUZm5EZ0FqcXI5akZ5?=
 =?utf-8?B?SmVFWERBM245c2hYcHRvN3VWSFB4YlhCeEVQZWM1WDl0MnpuY0owUEg4TXo4?=
 =?utf-8?B?b1c5ZlpUdmZLSGdhdlIzaVV3WjB4WjNoVTB0aTBGbUc0cU5sY2V0dXYzcGUv?=
 =?utf-8?B?WnJlamRXLzVkanZoWXhWbTczNVNsUkxENWgxSWM2SGRmNGtKRlZCd1ZGWkk2?=
 =?utf-8?B?THIwOFlvLzFTcElVRkZCb0xUUmJraStGQ29TYjdQK0VLei9mZHRseUpMb1RX?=
 =?utf-8?B?Ui9xTWpMRWJOMENSRGx0eTZDZFJNNFRIbHNCQi9aSEdsR3NCOGZqRnBZQWJX?=
 =?utf-8?B?d3hkZEgvOUZwcUYzL2NNVkNaMldTbDVCRXhkVXhNYWhmb29lS0dEV0Zsam9L?=
 =?utf-8?B?bkE2K2dtRnMrTWw4ZHo0UWFiZzZuQVVSWjhNYUVuVWNTTFVpQjYxZzBhTVE2?=
 =?utf-8?B?VjVzdXFwcTUyeUs0NFhoTmpPSnM4eThPTW9vWDY1VzFvQTVLejVhcXEwK0NQ?=
 =?utf-8?B?MTdJMDZEVDJRVnNzRll4TG5PTm9yQ3IrTEQyYjlDUGN5SUhKY3Q4NTR6N0o2?=
 =?utf-8?B?MDB5eDJDc21uMEJWTEowWVR3TDNlM0J2WC9neDZUT0pFSlkvUndXYnY2VTFJ?=
 =?utf-8?B?VFA5NmNwWngzajRKSGFlemo1dnFidk81Z24rdE0ydW5LdkJsaWpQRFJnZW5J?=
 =?utf-8?B?eko0TXNTRFAzU3BzdXJKczA5N3pjdC9SdFJ4akVXdnA1WHBlU291TWdBOWFi?=
 =?utf-8?B?MTZoUmxiSTBJb3d4aWROTGF2NTNvUHpRNVZTV2VNUUR2S3huZzd2d3pWK2d5?=
 =?utf-8?B?RTJxeUNsN01VUUVuUkJQMTFMTCs0NVp6RjRWVElrT0ZXcXZxam1yZGhuRklL?=
 =?utf-8?B?NVhNOUFEUVhIb3VHcVlDeVBPUnI5cG9CL3VmRXp1dUFpL3NXb2xGN0NhY1U1?=
 =?utf-8?B?WXFpakVpZmprZVFrVjJ1ejhjYkxIUXN3YTE1VGJHeElGUjZlcnRKd2R1T0k2?=
 =?utf-8?B?bjcxTDNiclhwZmk0WXhsZmFLTW5yR0pEUi83QUwyc0V4UjhWamhHZjRTdTZl?=
 =?utf-8?B?cTlwalJWaXhRNGxiNVVnb0UyRlZMRXRJRnRCNkNLdEN6dlJ2bVI5K2FhcTE5?=
 =?utf-8?B?d0VhVzY1aXVzR0VRaXVVTDYxMkpWcFFUTkMyUnVGWlltem05dE9lMHcrcmlk?=
 =?utf-8?B?R2xKNnNHcXBjOUlPb0dwWnRvL1VEMGljUnl3a211Q0JFdjFEd2ltcEJiUGc5?=
 =?utf-8?Q?pyawG+Q8i9XeJrvU=3D?=
X-Exchange-RoutingPolicyChecked: zo0gjQDmRMqz9lr8jtmY6e7SwcBk+36YOVr4uBmcbDFJm7ZgsfdlK6SShtMVoqeUhS+SUKWmqo3LBOq07BYXvSKThdob4rMRu5IzTyQ8gflH5m/oL+sPYWZjdJE5+vdjrYLzHz1WnyU1V965lnHMeIQ5IA11H/aLLsqJqvFyVAgK4YH6WkouHXvUXjex5ywOkjohEiaK3PvtanX5EJ7uY/4A1wP2U0eRF8B2XAb5DgqEVRPxItGLgKLN9vlrx9HqJgQqtFzvAU2/gJt+A3X8kaMhaGvhNpekLs/Ad4ZVty/Zn1e0XGtC1KFhmhcNZhRy28VVI/3AQpUWWOsu6hKaAg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Hz4LX/wBgine4AdwBUh/ycTEDrR4obKdjYFu5P/5VcaWWNeeS+0HNWF1VqbcNLiXCz4utN+HHHhRv+KaKo30Zx8rrhO5K05wnW2uq4UV+R/M5YWJz10F5U6Id8gT+G+srET7g1+fKdOSeCYeZbgFPGfOhqYvHkOty2dGZAHNk7zF9q3r4bCoWHvVHRA9oIiSbQaTOgK98tUXyyPR1nxBEQYoRhmH916QZBXRrYUa4RdAGmrK1E9ab2Rs29WaCKCVRaJaefo4fYkOGZvzsb7RVwkVzWbNbkY2ows1p87Hwwr9ponaZVV0xFGq+eMQ6jPJh4rV6MfdAUeM/+Q79JTiKJ6QQmeCKfeOG9DeqpqO3iu729ZW+7X7MaEkInaMIri2+wES5/6iT4QfeIbNebmibjQngtgOX6EL+1SU3+rfrt3aZM4/W8ibCsJqW7rRc9X6Z/DzCcDBQoqTMH4Tc10aDMbwBPDb3moD1RfUG+TXFZFNvRGxVEp3tFnF2HiWHfynCA/9p5HDv0kf1n5lpGs/4VR0wHBdfnuBRQIsaK08Y6VNhKxQQqN1JJjMXKgVt+M8za7ildRHtVRIMocnXFi2C5XOJ2bu2JI2HBzhSTzN3cc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dfd2151-1a82-4667-1d5c-08df46557eae
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 15:55:12.3176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDkqnL7y4TATT0KJr/ooSzJs9UvzTi31HsKhzmWvnTz7ieXZ+DY0eQwPSQyUDlpFypAju9B7582RPLluV0VVUbgn/Zw5H6bbkTlIEKWICJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6892
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190063
X-Authority-Analysis: v=2.4 cv=APpTTis9 c=1 sm=1 tr=0 ts=6aff1be7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117
 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=NEAV23lmAAAA:8 a=0tK6qxi10SZbSg_cXNgA:9 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: iGiyUo8EMl3BtWuaU9molg4bpkNCacVZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA2MyBTYWx0ZWRfXz0d3NRx3xF8H
 FO2fo5sK+wh/JrmKaNGlKW6EKz2un6NLdiXMb6u+4plXBuEZoV4X3R49IQ7igqPxa2xUCmr3dwE
 y2As3dnq/lbVuet5kr8W92ksVYeQKQekBujRp1fpp9vLX9iLlLcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA2MyBTYWx0ZWRfX22SNbmBqRozt
 UYlUp+LGcN1kftAMy/ZRleYLLpKsP6RUvekharhmJ+9j+RsHzWKX4WsY1KYos57VWxFnslJyIfg
 uOEQhEFnMBfLRqn6Q6d++aAoIILACC7CdW2p3MgDzP/xtjANSpdpSuv1Ypgkpvu5UqkiSAICKoq
 7NwdDuIKzy1lkf5irBW4sCBrO7C/ZYxLDVUvG3QAcc0vj+KzoXKHvw/ErAHIqBOgqj5v3n1Lxa1
 PkUuhNQqM3o7Q6MwV3KW2S3eBVUExD/DFquGEe9EL+7r3sqQ1RUFxekKgaEe7i6HT48XJEjzz5y
 DcJJaPkZJvLE9Ckh1WrT9eH09lt1E+L0FrS2I7C00m05YQGllMvAuza7x/dTw8B4pa7eFb2hf9V
 /+/Amz9eSFUB5rLPJHaMXbee9vWwAEgHkz30PcKMZN55qJltRbT+x71zh8Av4Tke9pAeRSWzwZA
 TOXGwf3k8Il93xgb5Dw==
X-Proofpoint-GUID: iGiyUo8EMl3BtWuaU9molg4bpkNCacVZ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Michael,

Following up on this series, since it contains bug fixes and it has not
been included in the recent pull requests. Do you have any concerns that we
need to address?

Thank you,
Alejandro

On 10/29/26 8:38 PM, Alejandro Jimenez wrote:
> Hi Michael,
> 
> I am re-sending Dongli's series after reviewing and addressing the comments from
> his earlier v2 submission:
> v2: https://lore.kernel.org/qemu-devel/20260724223216.108667-1-dongli.zhang@oracle.com/
> 
> The series has been rebased on top of:
> b574eaf640f0 ("Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging")
> 
> Please queue it for your next pull request, whenever it is convenient.
> 
> Also available at:
> https://github.com/aljimenezb/qemu/commits/amdvi-dongli-fixes-2026/
> 
> Changes since v2:
>  - Rebased onto b574eaf640f0.
>  - Patch 3: Applied suffix LOG for consistent EVTLOG/PPRLOG/GALOG naming, updated
> the existing macros and all their call sites. I preferred the use of LOG since
> GA by itself is generally used to refer to Guest Virtual APIC support in the docs.
>  - Patch 4: Minor change in commit message, code unchanged from v2.
>  - Patch 5: added GALOG_RUN to the RO mask [Sairaj].
>  - Added Reviewed-by and Signed-off trailers as appropriate.
> 
> Thank you Dongli and Sairaj for your work on these fixes. Please let me know if
> I missed any of your proposed changes.
> 
> Thank you.
> Alejandro
> 
> Dongli Zhang (5):
>   amd_iommu: Do not create duplicate MSI capability
>   amd_iommu: Use full BDF when reporting page faults
>   amd_iommu: Define MMIO register masks
>   amd_iommu: Make extended feature register read-only
>   amd_iommu: Do not latch unsupported GA log status bits
> 
>  hw/i386/amd_iommu.c | 47 +++++++++++++++++++++++++++------------------
>  hw/i386/amd_iommu.h | 25 ++++++++++++++++++++----
>  2 files changed, 49 insertions(+), 23 deletions(-)
> 
> 
> base-commit: b574eaf640f02c4edf28cbee6417378f0d79cda0


