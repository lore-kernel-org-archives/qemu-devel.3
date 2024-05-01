Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42BEC10F1A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 11:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s28U3-0007Z5-8r; Wed, 01 May 2024 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1s28U1-0007Yl-Cx
 for qemu-devel@nongnu.org; Wed, 01 May 2024 07:50:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1s28Ty-0001Li-Qa
 for qemu-devel@nongnu.org; Wed, 01 May 2024 07:50:45 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 441ASNGE006723; Wed, 1 May 2024 11:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=qSDAKw6rm9OPOW7KlOYPpL2bcGBtJfhmK+aMrLwTcFY=;
 b=g1T6dRtVJUfdwvcjN9Yhtj/wfepeNhGMDyOi8Tg6IygHcr39h2dw+dVxFjhmgNt4Ei37
 c7/ewG/X/DSEcnGmFxEjcWmPjO8QMybSDoXr8NvW0ES8138CgDRoUULQP8z1q5DtpThM
 JQZ/+1F9nf/DwuTlPNfXI70BV2AjgzAd9MkXvo8P7lSVtcNkSIm+Y5AW3Z2PEJJVdJ9t
 qALanFn+VhYkCs1Eg5YEILCyRBCGC0gqK+NVVqgvM7VrcGoaiXWMsonxxljvCFx8evQr
 7Rp471b3Ijy7T2+IXGjxIjJv9B231iA9qd3KmWflOxTMZigA3NjKkpFvapGFXAH3/onS MA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdeq1n9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 11:50:37 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 441A1MMQ008456; Wed, 1 May 2024 11:50:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3xrqt996e8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 01 May 2024 11:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZy6W4hMEUfNYXw8FxzhYhK7/nB9HTFmWSAWFgOC/bOXIaPaiOTjIrJ8peWaRDRL6oMWp/QxEojWUt98BSzMLfg7kz0Qyd2y+eLiJHR9eP8J4k3yRyiEQMBn/Z/kWGvnPoPbvZGpQBDslkMybROS4xCCcxyJ9QOotjhM89owLlD+EugqaM/39UA9esgiSTBA5TY7MA4x0p5tVJk5gC8xFAZrvqdCjN2IEINFbpzDsivYG+RuZarmbts728Cd8q7K0gLgSPsr07W3Hqj4BoF7BNGuHi7zC9PtHCKt5sJqVekHYAVY54DZNkyFSvbJNxSzNLV47XzixTY1prGcN1M2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSDAKw6rm9OPOW7KlOYPpL2bcGBtJfhmK+aMrLwTcFY=;
 b=C7e49Pqiq5YB6x7nPzSeuJxk5MklbmW0SWWdo86gDnKwOSVATJjbb9I28fMiPRBszWyNY9YwdccAmuU4QJv8g9olDmqWs4AxjdmqyEBKAg193WYonOqrFoqukPTAmA6iXd6msSIPc4No/27521daC5gYn8ovXM+94lgfL3pH1wttF2pKUZXd2rjcyzlCxyWO7Yu8uqWp2OMrc81ZvhQenv5U/OIrS2Noe94i4WAZTJbVhvjlWmKEwkuExLtuIg1QVTXR+ATOxPIOhOR4lJKJAnVBMc848BKOtVOqE7B95mPwJq1pSmvWqj/1lmay8ddGr4bGE/04ST/ueyo79eCIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSDAKw6rm9OPOW7KlOYPpL2bcGBtJfhmK+aMrLwTcFY=;
 b=LiiwLTpk4c7OSGpnTb7B6h9rgI2tRHdCapBNOQT+zCtI6ytnVV+TDOk/GLwTNtMkDt1wbJTR6ZdrM8QqVOujCEGAGdS6c77ixicMkdfbLU5UOWCgX/Z0IsFA+S8+9Phap4gSMJ2h+McSG5xJ14bF2KUJH7PEtHX143LJgDFnopA=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM4PR10MB6816.namprd10.prod.outlook.com (2603:10b6:8:108::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Wed, 1 May
 2024 11:50:34 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::de7c:2c87:8c7f:e14e]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::de7c:2c87:8c7f:e14e%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 11:50:34 +0000
Message-ID: <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
Date: Wed, 1 May 2024 12:50:30 +0100
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20240430051621.19597-3-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAZP264CA0100.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fb::9) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM4PR10MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: e36d2415-b426-4b4e-039e-08dc69d4e8b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cm0xckVlVHp4ck5ZZVNYcEtYdzd2Z01Cb2xxTk9HV1RDTlNiSVFUNTMybmsw?=
 =?utf-8?B?QUFUdDk2ZmRiYkQxbzVLdnMxKzJkR2txOHZ6eWs2dE15UkZWZkt6UkhKbTBN?=
 =?utf-8?B?NFM5Z1pzN2N4d3ZwdHFHM2tqcFVvM294L3BEanZhNlZ4MzRCcWRiVWR4S0c4?=
 =?utf-8?B?U3BtbEozYUl5Nk5iNmxmc1JGN3hTc1JCSU9saHREQ0l3c1NqYjN3cHB5cGNI?=
 =?utf-8?B?QzJQRmx5QWhzQVBTaTNkZ2R4QzZ3VXJ5SFNSbmxFWmRSWUVlUVFFa1BRaCty?=
 =?utf-8?B?Y2Q5azdxWUlzR1RTSWs1dkZlYyt2emVRdlREN0YvT05tWE1IY3c0S25RbnF6?=
 =?utf-8?B?dlcwM3NUcW92eXhoMDkwdTVpclpKQTZpa3RUZ1pmYXdmM25KdWNHczcxQTdY?=
 =?utf-8?B?MHVLOE9hczNscFMxOWk4MlN1T0dHaVZncjV0UDdobU1GbERhdjdkb2ZUUm1z?=
 =?utf-8?B?TjNKUGhUbzkzUjZIdnFwMDM4R3owN0lmNWcwWUp4WUNTcUFlWFR3NlN1MjBB?=
 =?utf-8?B?cjNUTzBDZ0RMTkw3Tm1EajFsc1dKM2VqTVovQXBhdlUzNlEwNDViZ1N0MVMx?=
 =?utf-8?B?YXlESUZkd2VjLzhVSUcyZHJFNVVLT1dhSWFJY0dxK0JDaEhaRmo2VFp2R01H?=
 =?utf-8?B?ZTcvQlhjRjdId0hTY3lIWXFjdzc3Q0dvVWJCN0JmbVpBbGxpbTZ5YnFZWHhL?=
 =?utf-8?B?aDEzMjhwNzcwQXlRbFhEMjVkZlFYQjFuTytjckdESmcrcWo0QlJrdEk4QWxF?=
 =?utf-8?B?eEFvamdjMEQvYnd3Q0E5WGVQaTN5eXZlcDdEZTVmMEc5ZjZRUzJjWEwwRktJ?=
 =?utf-8?B?d1JzSFk5RG8vaWdXMFJmSU1keWpBOGRMR2VEZkMvWFRsWWtLblpCNDVxM1Ni?=
 =?utf-8?B?bVplTnBQeDgxL3UvaUZxZmpKMi9kaFJYNGxyQk9uSVMvT1VEZEkxdVlsdzNI?=
 =?utf-8?B?ejdqcE1Xa1A1SDBvdTBWTzlXS0VYaWxCY2tqOGFxL3l2ZFJQdVM5SUdKSzhP?=
 =?utf-8?B?c00rQ0VqWlFqYysxdXNxM0wxbGE3Q1I3eTVvUTRDTENYMU44c2xvSUg4cXhm?=
 =?utf-8?B?Mk80WWN2aU9jWE1lOTNFNlJzeUJNTjVLSzJlcjlFdkpWT1h3dlFpbHFKVXEv?=
 =?utf-8?B?Y2dBM25iZEs3aE9kdmQwaUNtZUwrSDR0U0JCUTlOSlNsdlYxV0NLbjB0Z1dT?=
 =?utf-8?B?L3JLN05vSktLL1RXU0YxUnZQZGdhYzBsSWxRLzNWN2kva2dVck1TTzdVK2g2?=
 =?utf-8?B?dllmVXExMVZKQjJVSEMvellhSkI0d0FLUER6ZU5ZbWcyWXlpMVI5eVl6OU4v?=
 =?utf-8?B?MkgvbWpuY3pmczlpMm1MaXpMVUtIbTNYVEk4TVlMektCS2x1WTRIQy9aM2pq?=
 =?utf-8?B?MEg5SGNOWFFEck13dVgwN2g4N2lvZk5ZdThVRyt4Rmk5K3ozK1ovTkR0c0Ur?=
 =?utf-8?B?TnRweHViclA3bHJlZHdCeFFiaEt6Wnpid3R0VG9Gb1NyNXNOd3FwZytsQ1BY?=
 =?utf-8?B?RGVsRXZwVWZlUnVDZWlEd210MmV6Q2RaY2JXNlVsaWdBUWFYbk5vZm9ndFJW?=
 =?utf-8?B?TGgwYkRJTTZWemdzK0wrT3VwNXZKWnM3S3lIV3UwZUhWMzFTK3JLa0dra01R?=
 =?utf-8?B?TXlIejVYTTJyTTFrRi80M3d0OGlkeC8wKzJjR200NjNiRWJwbXZQYkRaT1VO?=
 =?utf-8?B?WkpMR0lCU3FQL3lKajZPQnU3Z01tVVBaMGF3YUhzWVpIRlUwYUQ5VmhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGwrM2VxSkNtSVNsVFUvdE1FazMzVUo0akpYbmJBMk1EcFZOREwxUGw3SXh2?=
 =?utf-8?B?aG0weUNMaGVlTzJWL0orUHdheFU1cVNQQlZCVXBWU1kwYXlKK1lJTGVjZEpt?=
 =?utf-8?B?b2ZCUkszdGloOGJzY3RzWk9DNTBzcVlmSUF2R0phT08rcDA2Q1k0SERNbGtE?=
 =?utf-8?B?Q0lEVUQrSXdhVXFHTTNSOHMzQUZMOFRsS0VSMDczdWNyRzBhQ2tpNXpBVW9H?=
 =?utf-8?B?c2pLMWdYcWovaXhhb3dRVWRpWVZUelNuMUpXWkVNaUNyemFVdUZ4d25kd2Ja?=
 =?utf-8?B?TmU1WEo3WVpVUUs2VFBrbW5zc1RGaGJQKzZwYi9DOWJ3dk4vV0dzK0kzc1dK?=
 =?utf-8?B?d3g1ODA2bDU2ZHVWdGZRZkNZNEZhRm9kdTQ1bElMQkkreXJVc0tqWXFnS0Y0?=
 =?utf-8?B?eitiTTFWZkRPVklNNG1GQmFEQUR6RFpXcG5vbEl0UXUvSjQxL25TUHowT2hl?=
 =?utf-8?B?ZURVbUZZYkxiWlhINHdFaU1HUm93ZnZxNUZJMVA4QVArd2J0Q1RGcndLYWpI?=
 =?utf-8?B?NkRoVEJyV3VkeXZPRFc2MW13bWNoNCtxVkdrbm9iamo3dE5NV2xNVVJFK01w?=
 =?utf-8?B?WE9SNExQcnlhRFJsejJhSUlmK0Nwd3dtMEZjK05mekVaL1E5Z2xKaXFvRjJs?=
 =?utf-8?B?OFFKOWJFbWVGWml3cGxzTFVYbGlJWmZ2a3l3clRrQVJ5WXFOdFRhcWs5alY3?=
 =?utf-8?B?R2VsSG50UHFVdksvSC9tbThXVDl0M2JoLzlzWjhWYXZwK3RXSTVxY1BtaThV?=
 =?utf-8?B?Z0lSa2VJNTdydkVDK0wxSHI4UENWeWpjamdwWGJXOEg1RXJlQ0lZREsvbm5x?=
 =?utf-8?B?NmNGS05mMlRaVVFKb3hjZjRVelo5S1doaFl3c3VTbm5QaU10RktRbG1uSXFk?=
 =?utf-8?B?V3JRZGx0a081QlJDcHQzYlh0QlZDMmtjcGsvZUVubHpYaVRHNkpzN3FVWE5q?=
 =?utf-8?B?b1EydjJZZTVUd3pqUmZtNC8zY202WDRoMXBLK1JORUo2bkQ4ZGZIbkZaOXEv?=
 =?utf-8?B?d3ZPNFc0dFlYc2NmZzNLbzRMQVZWNG5WdXBwbEpQTmRlVllteEl5V2NwUG8y?=
 =?utf-8?B?T2JlUnNVTjU1N3dOM1gwdllkdUhFbk50aytEWVIyamFIM1grMjE2TndSSHhw?=
 =?utf-8?B?Y3J1RGNlbEtmYW1nNnp6Z3I0K25SRWx5RldqQ2tkVEx2L0NmUXNDYXdYNmNH?=
 =?utf-8?B?ODR5WFhoWGdidU5ENVFIWGdkcmRTSU5KUHUxODFBY1BxQVYxdTBTbjQycWkw?=
 =?utf-8?B?R1p3VDdjeDFPdFJMNWozOEl2VnhoamZIUytUdVZRUWUwK3ExbVhvMHZHWlJz?=
 =?utf-8?B?ZWhnY29qbnRCeitxWG5zY3kyN3FaQTVmSHZvRE03bzNVY0dGaTVqQ09YUGhZ?=
 =?utf-8?B?NUtwL29TcGhhdlFQcnl0aWRhOGtZaENuSlhuNFVVZUxNd2EyN0pMaUFnVE8w?=
 =?utf-8?B?TTJFV2ZWSDBIb2RiU2phc096Wm96WTlpRWpvUU1GOWlnZStqNkEzQXRjZVUz?=
 =?utf-8?B?eXN5RU0zVFg4QUJEQ3BGNWZ5aE8rVHJTZ3FGVjR2MS9TejVpUEFRRWxwNTZM?=
 =?utf-8?B?cXgrd3Rsajh4dW4wUFZ1TWl6cVdlR3VscmtJbDduN0R2UWovaGRDcTJoWHJu?=
 =?utf-8?B?UTJVTm1pVnByM0hYK3BuR0FvZVNDR3Rkci9hY1cySHF1TmE1ZzU0aWpMSlF6?=
 =?utf-8?B?Y281dDBPWHJTVWRyVFBNRmpTTnMya1NFRW44MjExYlNYRFdXSUhQOWxzUEhr?=
 =?utf-8?B?dDdBbEIrblEzMTZNYWJacHdGdytodHB1dDlHckN1VnM1cGY2OXZTd2ZmaHlB?=
 =?utf-8?B?dWVYdXJ0VFVsSXZwUjE3b0dJcENpRnNkM3dsY0FpY0VsU0pOZVBmcHp5bHFR?=
 =?utf-8?B?aVNxcjloZ2lCWHZxU2h4MFAwVndXMUtJakgzaHVldklYN0dDT29vK1NiejZ5?=
 =?utf-8?B?TGxESlhSZkJ3ZVJTSWRSWnR0bzJOdVJGLy95VzRsR0R1RGhPL2lxa2Y2bXJw?=
 =?utf-8?B?MDhid1lrdkVpdlpYYnVHYUsvZVAwTWRuL1pncmNrZEVYUmsvRGdGTWlDZGJw?=
 =?utf-8?B?VnM5TnYrOUkxaGFkejdtY1o0blNkYUdTODRvQjhuTCtyQkJaWjdnZStMUy80?=
 =?utf-8?B?dHIvM2crMGdwYWpCaElkUnl0VzB3U3A5SEpNMXp2NUhkM0kvaDhMNVhPWTds?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qHGPBqaFMDyZXEidlH0uKsykt2XyCSErTgjStf5BgyoiqYktP3midxVmxDoLBqDFaG8Ij5FOSh0wxH1aWc+iKe9xRfPltAg1uzDTn38tVrumATTp1Rkylrphfl8OIstHHywa/1DNgm76Sye3r/32g6eWR25tONCTvCyrDqBMyT1wUPUE9gOuCWYmGu8KcSdc1gPUN37S7vqdECGCj9X16s6M/DN0oWM/04wjZmI0NyIteOFneyI6G7Blwx9wUcSreBvdEqduO40HvQMg+UVOfxk1h0DiQ/lLBP+u2csAApyuDzbvA9eTGrhC1oBzP/d3d/1pwJEHt5Z48NjI8SuT+sIbxXWnXhcEspapwlGLOQi/YDGbpcmZxbN0L28nzPXFEDQ0RF1yPjU1mJMpbfsBVGlDYRIZ4YLE3Ma5OOnDcLDAIxXKwg4JNmf6uYX6FZITG6Jm1kkQNpgWuay05BTC9RXn9VhisPjRQxIPF9WCNk9FiOmauV1eITE03l7ufUX67qtF+8pLcUq9K6P4zMSrgjUk9GOsseT1S1qxflBiuumRpDZpMvpc/VQm4HeJdNJOfoSMSmPC+ZajwP5cfHQ45KuSFyNp616grxjg8ioEah0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e36d2415-b426-4b4e-039e-08dc69d4e8b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 11:50:34.0799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcnYT7r4iS15tRKvjL9i7wok6m6V2PuesyRaZjB9/FWRH9L+p7hgpOtB4IeA/Z/XnHNxHslQlF/n8ayt3fRFjPcxavzeJ2bbLz5Rx6AednE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6816
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_11,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010083
X-Proofpoint-GUID: QBRt8kFeFh6bBBKKsEn8Y5m86Vc5G7S2
X-Proofpoint-ORIG-GUID: QBRt8kFeFh6bBBKKsEn8Y5m86Vc5G7S2
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

On 30/04/2024 06:16, Avihai Horon wrote:
> Emit VFIO device migration state change QAPI event when a VFIO device
> changes its migration state. This can be used by management applications
> to get updates on the current state of the VFIO device for their own
> purposes.
> 
> A new per VFIO device capability, "migration-events", is added so events
> can be enabled only for the required devices. It is disabled by default.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  include/hw/vfio/vfio-common.h |  1 +
>  hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                 |  2 ++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..3ec5f2425e 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
>      bool no_mmap;
>      bool ram_block_discard_allowed;
>      OnOffAuto enable_migration;
> +    bool migration_events;
>      VFIODeviceOps *ops;
>      unsigned int num_irqs;
>      unsigned int num_regions;
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 06ae40969b..6bbccf6545 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -24,6 +24,7 @@
>  #include "migration/register.h"
>  #include "migration/blocker.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-events-vfio.h"
>  #include "exec/ramlist.h"
>  #include "exec/ram_addr.h"
>  #include "pci.h"
> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum vfio_device_mig_state state)
>      }
>  }
>  
> +static VFIODeviceMigState
> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
> +{
> +    switch (state) {
> +    case VFIO_DEVICE_STATE_STOP:
> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
> +    case VFIO_DEVICE_STATE_RUNNING:
> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
> +    case VFIO_DEVICE_STATE_STOP_COPY:
> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
> +    case VFIO_DEVICE_STATE_RESUMING:
> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
> +    case VFIO_DEVICE_STATE_PRE_COPY:
> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static void vfio_migration_send_state_change_event(VFIODevice *vbasedev)
> +{
> +    VFIOMigration *migration = vbasedev->migration;
> +    const char *id;
> +    Object *obj;
> +
> +    if (!vbasedev->migration_events) {
> +        return;
> +    }
> +

Shouldn't this leap frog migrate_events() capability instead of introducing its
vfio equivalent i.e.

	if (!migrate_events()) {
	    return;
	}

?

Applications that don't understand the event string (migration related or not)
will just discard it (AIUI)

> +    obj = vbasedev->ops->vfio_get_object(vbasedev);
> +    id = object_get_canonical_path_component(obj);
> +
> +    qapi_event_send_vfio_device_mig_state_changed(
> +        id, mig_state_to_qapi_state(migration->device_state));
> +}
> +
>  static int vfio_migration_set_state(VFIODevice *vbasedev,
>                                      enum vfio_device_mig_state new_state,
>                                      enum vfio_device_mig_state recover_state)
> @@ -126,11 +167,13 @@ static int vfio_migration_set_state(VFIODevice *vbasedev,
>          }
>  
>          migration->device_state = recover_state;
> +        vfio_migration_send_state_change_event(vbasedev);
>  
>          return ret;
>      }
>  
>      migration->device_state = new_state;
> +    vfio_migration_send_state_change_event(vbasedev);
>      if (mig_state->data_fd != -1) {
>          if (migration->data_fd != -1) {
>              /*
> @@ -157,6 +200,7 @@ reset_device:
>      }
>  
>      migration->device_state = VFIO_DEVICE_STATE_RUNNING;
> +    vfio_migration_send_state_change_event(vbasedev);
>  
>      return ret;
>  }
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 64780d1b79..8840602c50 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3362,6 +3362,8 @@ static Property vfio_pci_dev_properties[] = {
>                      VFIO_FEATURE_ENABLE_IGD_OPREGION_BIT, false),
>      DEFINE_PROP_ON_OFF_AUTO("enable-migration", VFIOPCIDevice,
>                              vbasedev.enable_migration, ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
> +                     vbasedev.migration_events, false),
>      DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
>      DEFINE_PROP_BOOL("x-balloon-allowed", VFIOPCIDevice,
>                       vbasedev.ram_block_discard_allowed, false),


