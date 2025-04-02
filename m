Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C2EC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 13:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzyUL-00078I-JJ; Wed, 02 Apr 2025 09:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyTB-0006jr-0U
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:49:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tzyT0-0003KS-IR
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 09:49:20 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN4IG011878;
 Wed, 2 Apr 2025 13:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=MoXUgEv8HvHkh2UKKdqi9CbTmsT40xBywpkRV7sG8K0=; b=
 QU3gLH66Migpi2kofcumd+lTdW5IZA+GBXYQZV+Bcb2k/Fsh/RY4Ot9IUvC0EZg1
 nlkePGuZxnkZs475r8q2Nxg21/JDfGviJTtofPFEyrXnkNQHJj9XHj1ygV2M42AO
 oSR45UdcKVaTpCVUUodi8O9TsrE9febKUjTIGzAeAuJM7RQg6GqkINxOUM3sRU/S
 S3jqH4zYKSyKYquRbCtDXexibss26QOQBzcGSE+Dt4oZJbLzVZc7zO1xmJyzE8ml
 TSnNgUigW3ue6B3VLwmtFxkcq5o9c5zyDo0R6O/ZjTgzkFrtlP8zh2Gu6nSdqyjZ
 HLPT1ciF/xuTJIyq8plFUQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p9dtje21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:49:15 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 532DH5Vo032609; Wed, 2 Apr 2025 13:49:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45p7aavj2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 02 Apr 2025 13:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWppoa66AW7qp1fa5jWfm/a0yxsNvr3QBhs7ivlSY5w3BjkTtwf31D6U4kTL2ZEQp7I/fZjPHSRU1rhRg6SNgJA6AeF2H2F8EYnk/6oKIDN4wHprdmLCJwvfVBqeDT6j9wFfgkAe9HO37lAHDPe8mWaZPTMz3IUu/euQDUT9XKxP4M9azq64id43mvMsGQY1b7HGeAALed9uBxD6xGVB96grqwT9aenNpNJFy4vGz7l7CIrM/8n1rvcgFVDqFFGK73d+mP7triBGLsyKRkSfebqm/p/huydTy8l8oYj3jgqGrqskgGLtXWaUY2KPWSdxhZfAWEYNhhU58L2OxpryZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MoXUgEv8HvHkh2UKKdqi9CbTmsT40xBywpkRV7sG8K0=;
 b=Qei3eqkOLGL8hBV8+MyBVdwNHVxacwKzP7yRhzSg+mEwodqodf6N6szBjy3Y9073P/VKfmyoGaA4E/lJ5RtdYTbB0Bh6Z4g+zQ0qTE2SiUtx755+PDbrKmjWTk3NWcaG+vs2spgnZF7wgWyM7OPt5LHy5SHxtZjVLUF7fkK1ZqL26AXHDLqPcIrm/zs+5JNpaxn7vu7hBM9MuCIn6xE4/CHmsDjl+ttMTtsSwGrduaFr5+Ywx9yb0LWcQKSf7x+77mSdbf5pf8XwQICO8kJ9TQBLUhMex7F08+w/K7noiQnPW9tXpNQs2OQE+CFNrJ+EUeGqKbiiqqZCIxncPVB3Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MoXUgEv8HvHkh2UKKdqi9CbTmsT40xBywpkRV7sG8K0=;
 b=b+ZWoLQQnR+lzMTGima8WrtbsmxNVs5hyyhRQe8CJaa3inQUmrf5Hs/8h6pqSJc8NNJM4dQqh3sIznif0NJ0G+s9KlrB1s1Y8Y6pGRG/7RP1RCSazB2FlQRUeiWLRzn7M4Jkh44cqBK/Pw0/frEOfN1sX02x6veiE0KweWHDLzc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB4613.namprd10.prod.outlook.com (2603:10b6:510:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 13:49:11 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%5]) with mapi id 15.20.8583.033; Wed, 2 Apr 2025
 13:49:11 +0000
Message-ID: <4e3eccf6-ae54-45b3-91f7-c4868e964042@oracle.com>
Date: Wed, 2 Apr 2025 14:49:07 +0100
Subject: Re: [PATCH for-10.1 v2 34/37] vfio: Introduce
 vfio_listener_un/register() routines
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>
References: <20250326075122.1299361-1-clg@redhat.com>
 <20250326075122.1299361-35-clg@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250326075122.1299361-35-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0087.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::18) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB4613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca9a352-4571-4665-5d3c-08dd71ed25dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVQ4cEZRT1RZZ2IzWm1vY1lOczNWdklvUjNQZm1hR2dhbnNsQjhMVGpHaGNH?=
 =?utf-8?B?UWYxMy9XVUltOVBTMjNRbW5Bcy96TElLRTgyNElOUkYvL21nQUhuVHorNlND?=
 =?utf-8?B?aHpTT0VHM1BvaW1XWXhENit4UCs4SG84eTNqMk0ram1EaEpPSk85Z3UwMVpS?=
 =?utf-8?B?c1BhVzNtaHFnV2dENSt5Y0MzdzBBdnNaV1RLVzBJQ3JoSHZoY3E5UmRvZTZX?=
 =?utf-8?B?RDhOazZUV3Zzb2daVzRKbGRpWGdqUkJqdlIyNDZHUThkTlZvL1hVaUNuV0Jh?=
 =?utf-8?B?L00yU1EyQnZaQS82STMzS0lwZHNWSE0wMStjRTZuU0pNMjJCelR1amdmeUps?=
 =?utf-8?B?N0JBd1FncEFTSHJIUmRUSjdYU2lPa0ZLNlR3aGhFMFNoRVAxSFZac0R2Rjl5?=
 =?utf-8?B?N1pTNGJQanh1eDhleHBwWW5WWlVpaXJHTDhEaVdtNGFwb285Q1B6Y1I1UjFR?=
 =?utf-8?B?bGM0d0JrUmJHMUhNTXV6WjNPRVZOOWtJME9xbmQvQzgxNCtrWGRhWTB2RHJn?=
 =?utf-8?B?blZSU285Zm5meW9UR2tFZjZnS0J6QTBFQ0xXWjBDR2NYOXZtUXdpaHRmM0RH?=
 =?utf-8?B?MERYbHY0NFlac05CWXdwY2pCNEgvMnJJTUc4b1BIWEl0MXJCQkM0Ykl3ZTc1?=
 =?utf-8?B?cFJ5NWtkUzB2cStwUko3QXU5Znh3SW42MVFrRTY2NnU3NkREQlJWVkFtUzNs?=
 =?utf-8?B?U2hFZ1BMWWtkVGpHRVBXaURKQnB6MFhCbmM1a2RhdEQrRkMycnNtQ2c5Y2dI?=
 =?utf-8?B?N3luM0RUK2l0QkRzdWgwMXNzN29QaHpsa3prUEkzNEpHU21KUS8rZzNVcjFj?=
 =?utf-8?B?cHBxMm81T2VQc3FPZGF6V0RGYTBHdlNQY0tWb04rRzZkQm1PNmVOOVJEdkpZ?=
 =?utf-8?B?bVp0MzJoYXZpNC8xdnJua0pNcU5Pb0pvVDdiMkl2ckdlMEZSODV5SndKaFE5?=
 =?utf-8?B?cDJNdUJ2SENORitJM2w3V0dwcHBodU0vZVhlUFZERjRtalZYM2JmdDlXRFV4?=
 =?utf-8?B?aHBVTisyelBxVTljelhOMVpVWjFOdVlyRUJBRnI1TVBHTWNySmFqZ1pPQmYx?=
 =?utf-8?B?MWUvWTJtY1p5QVY2VDRzcE8zM2hEclV1U3M1VWtIVEtJeVM0ZFJ1a1ZRZUkw?=
 =?utf-8?B?cWdVMlNjR094dDJuK0t5M0d2Qkg3c2pLRVJCa1RuMGE0YUhpSUpBbW1Ud2hS?=
 =?utf-8?B?dzVVRjNTZ3dOY1ZwM0pERVZRbElGRzZnWitkb0tkOTVoaW16TkRUOStSbGhJ?=
 =?utf-8?B?ZkpxOGRtdnkvSDlQZHQ4Unp6M01Hd1ZHSGZlaVZSbFJBSjgwVnJsNnpTRElK?=
 =?utf-8?B?Q3B3dnZuQ1RTVWRXdVJnd3NWWkk3R1FOZkUvVGYwYzJ2NHRIbWE1b2w2ci9z?=
 =?utf-8?B?OWF6MEROa1FkMHo4aVl4eXZsUGg3Z1p1OVVWczFYUEVIQ20yaGZWVS9xU1Np?=
 =?utf-8?B?STlJdmRsa05yVTFwdk9veHQ5SS81cG5vdHlxeG9LRUJlSC9SREFMbnY1S0JP?=
 =?utf-8?B?T3p5S0d4Q29iaGExZkM0SllkY1dSTllteEhPRkZHTkk4dFZKeldadDk3dFZR?=
 =?utf-8?B?U1hSTTcxWk5jbUF1QTlwclQ0ck5YbC8xOGFmWG9oVnZYcGJXVm01dnpaMDBk?=
 =?utf-8?B?SW53ZTh0WU1lM3dzdlFwS24wdnFrem11ckpzMVZ0SXBRVTZVKysvUmwwZ0p3?=
 =?utf-8?B?Q1ZONnFxYXdpNWQ3blJ4ckJpQ0F2RUxTUHgvRXVOcHRCNE1RcHJGQTYxWU16?=
 =?utf-8?B?Njc4cmVubE5QNjA2dDNuQWRZZzlrRUUxcHZNWmU0OXZOU1lqR3Z1MHVyK0tt?=
 =?utf-8?B?bDFDTjBxZkozeGwvdnN0QVIzT1dSMVA0Z2pYcm1LWVlaOFZrQndtV3pGRExn?=
 =?utf-8?Q?6vYTggSu05A9A?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFYaXZYZEtDQnZjZFo1c1NDUnJNQmpnL1VpTUpMekdnRURWb0txVktWbzFF?=
 =?utf-8?B?MWVDU3VBNzJQVU1BVkJ6UTNJY21weUJwaVBVWFhyRmhqNVJFNWxXcG5BWTZZ?=
 =?utf-8?B?Zkk2RUcwTXk1UlpzNHIvbzAycWtNa2Z2WnZSbk4rcUdjZC9lTVhBZTlXMjNr?=
 =?utf-8?B?WDJsSkdSeDZ5MEszcUhhUyszcEw0QlZBenZJNzliL3FOUTN3WjV1d2NTdGxk?=
 =?utf-8?B?dmRzUzdsdFJtb3VZR0R5UkJHcWRvcFE5OEZxYTFrR1ZHMFEvZVczQ1NhVkYr?=
 =?utf-8?B?RHBYN0trV1lHbkRNTkREU0xWR2VNaFhjT2FEMG9pWkw0cTNTcm81eGJxZEMw?=
 =?utf-8?B?cEg0QnVZcGdDOXlBOEpFNVdyd0NzNjZmck9PdDBhblF2dVk3cmpjSXdwQUM2?=
 =?utf-8?B?d0RlbFVOZThiMjNWQzFjc0VNVm0yWW5HZjR2MW4xOW9vQXhqN2ZFeThWUndF?=
 =?utf-8?B?ZG5KRnRPRjdaZXltd0plUHB2MkZGMFNZZ2xYMER1STVWNlU0bjFEbHFSbll0?=
 =?utf-8?B?Tys0OXc1Zy95bDBtUG9PNnAraU9QM09BbUtzMU9NSFdHZEN0QTg4NFZlSGJN?=
 =?utf-8?B?SVc1NjRoSFp0anlnMWFUMlZ3cUIzOTM0VVhzK1pCc0NENGVCKytINnFObFVB?=
 =?utf-8?B?MkRpa1RZRjQ5cWUvbi9Hc1lmT0k5dUZqbm9TU1VSa2FhSFZmLzIzQmdOa0cy?=
 =?utf-8?B?dlJiTFBhUXRFNVBIczZndVJ5NVZKeG5QMVdMcC9TWEpZRHkwZThxcVhrT0tX?=
 =?utf-8?B?aGJnNnRjVFhDYUcxanBBaGU0VFNubFdsTWcxQU9nTFREVGx3ek9iWTVjV0Z5?=
 =?utf-8?B?QXl0a2xvL2E2YnRlZThrbUIzSmM5NzB2R3Q3OTNpTkhydEtSL0RIaVl4ckNJ?=
 =?utf-8?B?aTlGNDlaSEcwejF3NXlndVpMUlkwT0tLWVEwMWxaWmI1dWRxOG1RT3dVd09r?=
 =?utf-8?B?WXdEOFE4Yzk4S28zeXNRYUVzUVY0U3JkcnAwWGNFSXlXZkVYcVh3bkJlWWVh?=
 =?utf-8?B?L3NsS0RGNnQ4V1NmZGZpZHR2TkhXd2RjK29RNTZlT2syZHZJKzBHMXZZeVQz?=
 =?utf-8?B?WWlKYUNKdzI2QmV6aWdnR1lUeHk3V1ZKL2hLalFCWGdTZDlZRFZFR3c2aklu?=
 =?utf-8?B?Y2NEMFNRbGI5Ti9PeGZtd3Q2VEh4MlZTWVNlSDdzTWN6UmU2WWhabk94dnBY?=
 =?utf-8?B?S2J5YUZiVi9xU1o3dHdDS0VQcFN4TCtuaVI4RkQwMkhoQVVIYWFHcCtrUEIx?=
 =?utf-8?B?T2NQTlk4eVVmZ2hDdVpoTHZoQi9DaHA4Sm56aXhPL1BCVUhVczE1ZTlDQUN1?=
 =?utf-8?B?cFJrTlJDNDV1dFFYUTVSMDdIczR6VmlsZ1EyWk1UZFpzK2krNEd6dVFBelFN?=
 =?utf-8?B?TzlpaW53dzkyV25tK0NCdVdPbWltREZhOXRWK055aFlHMHV1SHBlVDlkUEh2?=
 =?utf-8?B?SElnT1lxNHRScnJRR1ZBRVFibis3bTM4MC9SVXd0dUx4QmQvMk9WZjNWeHpE?=
 =?utf-8?B?Y24vZGd6YXRxdFZkb2xWRlhtRE1lbW5Edjl4cjRmNTBEMDZTTXBtRlhHNndJ?=
 =?utf-8?B?MHVHOTBoNFpvNmZEN3dsbHQ2MG5GZVhBMXFYUzZBcUI2YSt2VERDTGZnRGdi?=
 =?utf-8?B?YkszZHprZUQ2UHFCODJWMVh6czZyNlpKQnlBTnBxRVZ2djZhVUxreHpXTE1u?=
 =?utf-8?B?NENzVjJpM2p6UHkyU2txcWlJQWNGTnBaZmZjcnJjSUtTdlpKQXdSUHlPeUY2?=
 =?utf-8?B?MU96bTlzSXY4SGtTWFNscEFSSjZaQ1ptNWkrNGF6cVlhM21ScDZLZmdCaHBq?=
 =?utf-8?B?bHFZZ0cyWDYvcG1FUGZabzVHd2xsV3gyUFlIaFJtY2ljUlBKd042NDVJMENi?=
 =?utf-8?B?MGlhS09JRnYzenRRMzBsWEhXUnVaTCtQdDFwSUR1bk5hRFhySSthVjRFMlg4?=
 =?utf-8?B?eU5ZMWFqL3hMRXlub2hPZ0VKeXNhbzVpUTVTTG9Xdm85MlBrVENDQmRyL2xy?=
 =?utf-8?B?SGxsTi9JUElramd1VjVVWCswdW9oWFgzQzhYZnZHaWFicFhXYUY4SkFHUTJs?=
 =?utf-8?B?QWhFNGFaelRzVzN5RUVwa0dmbUM1NkNhWjhBbkRia3lJNHRDalhLcVh4bm40?=
 =?utf-8?B?a2w2Mi9BRk9Db3FVVjJBaTl6L3RiWTVoNkNTM0ZHQmJNcXdyQTJzSEQxemRM?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lm8Jx8kwKgddrqKyjNITZs5oZfGM1BI1mtwwqvR0Xz5KCqHW1WNR7Hr5gHPFEeiqYeBqGzrl9R/CMGpST8vcSGbmpR3C6Uz9hozcNDM7XvhTWXleQJwJyVwkHtt3AFRBRlVYBSaaz5q81uqcAEhV3L1cbiob5VD/tgrvERsMrT7vBOhqHQxzusNRpIfNT3J0XK/WPKzPsODKw17ogClNQlZ+eK6oMpexQb1k0u5dkvcywoYFO9VFSWGCRxHMdDU6nhFDLfMPjynDLXsQc7dMk8BzwTMxOj6x9xugaaizs5bdqCeKt1j+YWm6uijGw4lBTnxJ4v8bCWqSsJ4eG2ID1NA2wyNqOSQwasM9INX6VDwx3XZDCwpDFZrvxQWLjpnWp2UAXadtphIJUhxZlI/GOwWB7wR6jwpNPXOtcjSWUfUiSUiW2P5zhKydsFd4ePgAsSwlaALMfulFjwxPqqpfuW7GkZyT+zK5DfVtEo1QKuT4T95b0W6mOR9FoC5kIVT0wkBpHZAlA9LVOxlNo+yLR9m2G+Mp5zvn6bxL5oq9kMxZyo75Xt4RbkjQarT6FywnKHT/HOUbokPzP0t2pbnryN3qpNRXi9zjwott5KlU80M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca9a352-4571-4665-5d3c-08dd71ed25dd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:49:11.5403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMzX2fBQUBECHF1m00r+Xmpatyqbtsv4QZRb9CwqhFLLOKeg9LcPN4RQSE50jyjW/TbIXv2dUDCJc2sMZZqFP00qBTTPqCZ3c3Er7tjbatg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504020087
X-Proofpoint-ORIG-GUID: VxoK7tdwl16UcZNlvWsHNReR35wt__5N
X-Proofpoint-GUID: VxoK7tdwl16UcZNlvWsHNReR35wt__5N
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 26/03/2025 07:51, Cédric Le Goater wrote:
> This hides the MemoryListener implementation and makes the code common
> to both IOMMU backends, legacy and IOMMUFD.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  hw/vfio/vfio-listener.h |  3 ++-
>  hw/vfio/container.c     | 11 +++--------
>  hw/vfio/iommufd.c       |  9 ++-------
>  hw/vfio/listener.c      | 22 +++++++++++++++++++++-
>  4 files changed, 28 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/vfio/vfio-listener.h b/hw/vfio/vfio-listener.h
> index 93af6747b28955f038454a335b361787f8364a3a..eb69ddd374fa20683007cfc4e9a7bf6fe707f27d 100644
> --- a/hw/vfio/vfio-listener.h
> +++ b/hw/vfio/vfio-listener.h
> @@ -9,6 +9,7 @@
>  #ifndef HW_VFIO_VFIO_LISTENER_H
>  #define HW_VFIO_VFIO_LISTENER_H
>  
> -extern const MemoryListener vfio_memory_listener;
> +bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp);
> +void vfio_listener_unregister(VFIOContainerBase *bcontainer);
>  
>  #endif /* HW_VFIO_VFIO_LISTENER_H */
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index acebb53dcb1b829d31cc31d9f7f2cc9599f952eb..f086e5c802f058c01ca740de338538106874fb03 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -616,12 +616,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>      group->container = container;
>      QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>  
> -    bcontainer->listener = vfio_memory_listener;
> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> -
> -    if (bcontainer->error) {
> -        error_propagate_prepend(errp, bcontainer->error,
> -            "memory listener initialization failed: ");
> +    if (!vfio_listener_register(bcontainer, errp)) {
>          goto listener_release_exit;
>      }
>  
> @@ -631,7 +626,7 @@ static bool vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>  listener_release_exit:
>      QLIST_REMOVE(group, container_next);
>      vfio_kvm_device_del_group(group);
> -    memory_listener_unregister(&bcontainer->listener);
> +    vfio_listener_unregister(bcontainer);
>      if (vioc->release) {
>          vioc->release(bcontainer);
>      }
> @@ -669,7 +664,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       * group.
>       */
>      if (QLIST_EMPTY(&container->group_list)) {
> -        memory_listener_unregister(&bcontainer->listener);
> +        vfio_listener_unregister(bcontainer);
>          if (vioc->release) {
>              vioc->release(bcontainer);
>          }
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 7488d21215b6eee78c9c51cfb227d9c8c59c4978..e47720247d6acfd6ea0e5a2e2a2eecabfa62dce3 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -410,7 +410,7 @@ static void iommufd_cdev_container_destroy(VFIOIOMMUFDContainer *container)
>      if (!QLIST_EMPTY(&bcontainer->device_list)) {
>          return;
>      }
> -    memory_listener_unregister(&bcontainer->listener);
> +    vfio_listener_unregister(bcontainer);
>      iommufd_backend_free_id(container->be, container->ioas_id);
>      object_unref(container);
>  }
> @@ -562,12 +562,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>          bcontainer->pgsizes = qemu_real_host_page_size();
>      }
>  
> -    bcontainer->listener = vfio_memory_listener;
> -    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> -
> -    if (bcontainer->error) {
> -        error_propagate_prepend(errp, bcontainer->error,
> -                                "memory listener initialization failed: ");
> +    if (!vfio_listener_register(bcontainer, errp)) {
>          goto err_listener_register;
>      }
>  
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index 07c8dc6ce343510dea20c5946e64a23a57c0f91b..324dc47183be82933197017f473f67cce6d7ec56 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -46,6 +46,7 @@
>  #include "system/tpm.h"
>  #include "vfio-migration-internal.h"
>  #include "vfio-helpers.h"
> +#include "vfio-listener.h"
>  
>  /*
>   * Device state interfaces
> @@ -1163,7 +1164,7 @@ static void vfio_listener_log_sync(MemoryListener *listener,
>      }
>  }
>  
> -const MemoryListener vfio_memory_listener = {
> +static const MemoryListener vfio_memory_listener = {
>      .name = "vfio",
>      .region_add = vfio_listener_region_add,
>      .region_del = vfio_listener_region_del,
> @@ -1171,3 +1172,22 @@ const MemoryListener vfio_memory_listener = {
>      .log_global_stop = vfio_listener_log_global_stop,
>      .log_sync = vfio_listener_log_sync,
>  };
> +
> +bool vfio_listener_register(VFIOContainerBase *bcontainer, Error **errp)
> +{
> +    bcontainer->listener = vfio_memory_listener;
> +    memory_listener_register(&bcontainer->listener, bcontainer->space->as);
> +
> +    if (bcontainer->error) {
> +        error_propagate_prepend(errp, bcontainer->error,
> +                                "memory listener initialization failed: ");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +void vfio_listener_unregister(VFIOContainerBase *bcontainer)
> +{
> +    memory_listener_unregister(&bcontainer->listener);
> +}


