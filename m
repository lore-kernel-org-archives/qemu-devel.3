Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18FBC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvvO-0004MS-Gu; Mon, 22 Jul 2024 12:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVvvL-0004Cj-G1
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:30:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sVvvF-0003uA-UP
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:30:06 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC0J9H021208;
 Mon, 22 Jul 2024 16:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=9ujVeEzNuzfEF0KP2SxQ1uZyaGy9ARFnNt8P2vsBCzA=; b=
 MZEQp4mX2TxdWAGij+DY6m0iF1xbYP1mES1cLzwdbdZ13NJR2MbqZf++/rAXO+Q1
 mP61sZ8Ic2VGo591vfACtqe40Keqp+vMJnmqrAc3Gsaqt2bW1FHFyjnGBp20yDCR
 qVXR/maJFlda6GocMJsUvpVPsHxqxMN/OGuZP1dpC3nPJeY+V/bUk/UICFk4Bipv
 Mvshu/MyZvPWPiIE+u+RnR5KjWHl7ehuFw5xZAV1g573IrMj/djdIatmLLPtw3kX
 Fptwa3lOaROkcY1FHsCTkQHAIa+y2yP1TR0HudDiEFLJpDMe9qM56yo38plDJT/e
 c4f31mUIad4PrBsWDbQjdQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt28cx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 16:29:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46MG05Gd018934; Mon, 22 Jul 2024 16:29:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40h27xdv69-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jul 2024 16:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUSIUc6vdV9OWKpJpebL6LxA+SkNBQXK+C2tDumVvgLPq2R2kJF5UI/xkTdehTMgUfv9e1R8f+OA5b+2gRoW78fs+f6qU0jOhraBYTBsTpqUCq7eSWjQzljNW9NT71exzVLDg3JN4CF3KR3eXPA3Yw42SdDomK7DV3F8YfxTDfEHNycGOIv/qDaGxOsfaMTphWKFtG7+aH+Xc6IsXQVs6JlUZNhq1fLJs7KCkl0vUa9I15UaBns8uDA9GaRHgsKt9Szi+NsuCy3baAlk122CTm9fsHo9Kw6e8gg45TIyvRfwJLK0+VitYkmLu4x6DNrQvJr/nTM7u17wOpDx4X3nOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ujVeEzNuzfEF0KP2SxQ1uZyaGy9ARFnNt8P2vsBCzA=;
 b=r+OBTyie0pHhFFvJk5kztTyENuSGQlMByRRajNG609XD7uwbZVdkGfjTctSGh74FfxKgwpVNKK0pzw98+7kP7d//fUtOFzVb8cKT2Vf1Y2C41iefbTv99oU60/UMDF7sOHFXPf3pkDEJG7k/Chgd4lMAjZhBCzELrkW5oJwX7erNIrqs1FLnnSnaFL4BWveLj8pKa3rSTIG0SzjLAZuTMHnjmvauo5+nGt3HsxxgtdeHo/Q68XB8fK4sQePRX5E7rySHMSkdoQq93p/lbS6dnkQfvdSYdJjQF0Q+8JijtQ1aaofKd7yX6dUL+YM3PuB210W04/bd7BIQY+gKD/VwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ujVeEzNuzfEF0KP2SxQ1uZyaGy9ARFnNt8P2vsBCzA=;
 b=LLqBpjtb9KpENLIkx6fmhIfXULnKQJ1OFDzUZqNb7HX9y7L0BUVXl+EW9eCjvZi2Ehr5bhH7Nsgvkrb9MWc3KGyvGrS9HCtO6pqTbw/CWd62NJhKs+u2DG4W0wyeSPyFRCYf9VEkj3OgDcaBtXEYJSPkdPzRDTdSn6G0a1X2VeY=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA1PR10MB6368.namprd10.prod.outlook.com (2603:10b6:806:258::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 16:29:47 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Mon, 22 Jul 2024
 16:29:47 +0000
Message-ID: <1d7aaeb6-67ab-4897-96e0-e6128680dd4c@oracle.com>
Date: Mon, 22 Jul 2024 17:29:40 +0100
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
 <27e2792c-6eba-4fab-a22d-40e46dae9cda@oracle.com>
 <f9e3bc1c-71f2-442a-8697-19b64a225d57@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <f9e3bc1c-71f2-442a-8697-19b64a225d57@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::11) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA1PR10MB6368:EE_
X-MS-Office365-Filtering-Correlation-Id: 35459f2d-a12a-4f33-7fd4-08dcaa6b8052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWxQOHgrcnBwYlFkRE1yUkVUSzl1TlZzTTk5bEUzZkxzdHFGbjZLS3BxRk1O?=
 =?utf-8?B?ek5lL2l3anR3TVpWSkg2RHVHRWpKR3ViTi83QnRWbmR1b1NmMzBxMmtTNFhK?=
 =?utf-8?B?ZDRUbHVSbTk3QVptTWNrbyt1RzlNNFdHOEU2endua2hya3lZcjl6NGYrdStU?=
 =?utf-8?B?SjV1TXBwNmRNdmw0M1Z4WGdTd3p1YXdOWkFiNE0wLzhWNHJrWGxOckw1TFNZ?=
 =?utf-8?B?RE9JemZDYjVqWWdydUVmOWwweVBtUDJ1MFZTbWpBQS9NS3dkTkc1ZGhLUzdu?=
 =?utf-8?B?d2kxb1NLNUZqOGpWdlNaUVpNOEtNMFZGdUNxOFVxRlcra05zdVAvd3ZzdWNV?=
 =?utf-8?B?TjRVcnBLL0VzR3hmOFBySTFmc0F1bmlxVjhldDk3ZUw3MVQwYmF3VlNWdkdu?=
 =?utf-8?B?Z2JudUY0Rjh1U0htMERWTWQwdXlrYkNCVmY3WE8wS0dpalBZdlp0VlQ4V2V3?=
 =?utf-8?B?YkMveUdxdXRzOVRxTHdTSmZnUlREbWZ3S3BZVzlDbzVFVVlsVk45MVRJL1Qx?=
 =?utf-8?B?TUlnem9za2pUelVlZEcwUk53OUhVeW44T1d2Qk5jNlhZYk8yaTBtNHdHVTJu?=
 =?utf-8?B?enhWOGVycWlUM2RndENUUStHUUtTUldlOUlCSFZ0NllqR3pXNVlwRXhLYVBn?=
 =?utf-8?B?S1J1Y01VZTR6MHgvWXZnRzE3Uk9rNzVTNUNhUVFhV1pRVTZ5L1FqVzdubnZk?=
 =?utf-8?B?dVg2dWNjUGFKd2J3OGMzeGZ1c1BhUEU2T3E4UEJ6WnJ3Q0pob0tiOEZtdXQw?=
 =?utf-8?B?M04vR0V6L203NnVlcVhFaTdjL2FHUWFMZ0ZjOUxRZzF2Q004Nlo5bVFBRXlB?=
 =?utf-8?B?cjlrc0NUM1dIcS81NDNhUlNPbVhxa2ZhZy9wNEhWeDZWeExwWkJzQnhXUHl2?=
 =?utf-8?B?QzY0bmo0cUJnZFJXQzhXdzBoMXQvM0x6YlVMamE0ZVBWNHR3ejFWMjhIWTBq?=
 =?utf-8?B?R0k2WThuTHd1MXlDQUR6eGxsR016NDdUMlBtT0hjVGs4dDdVdTJCYThjcUND?=
 =?utf-8?B?ZFhlVzExU3FPWENjdHlOMFZQOVhrR2tMWWpQVHYrZWUxeUpWRTAxQ2FHL1o0?=
 =?utf-8?B?aXEwUUZXdTQ1a0JGcG5hRDBiN0FLL3RPMzJNNXBpdnpnNysxTDRiN2VhT2Yw?=
 =?utf-8?B?bE5udU1nNmV3aUw3akR2Ri93c1FSTGNNeC9SNkpJc3ErTEZ5Q1Z6L09kcWhk?=
 =?utf-8?B?OXJ5VXZHR3pFV29wa3V6azhmTXFuZkhJN1JyNFJ2L3E0cnA4UExpSVhrOFZV?=
 =?utf-8?B?c0xLVkJTd2pWZnQwUUhlZVdLN1ZHOUxFcUVqQ25WMkVCUHh3Mm1KaGM1dFBw?=
 =?utf-8?B?MDUzSTZ2RGZWWHcwb2lKeUNYdG92T2lUNWQ3eVo1bWtaTTNVU0ZEemNjNVFq?=
 =?utf-8?B?bGZkK0ozMWU5RmNlWFdpdnl5Sm9NS3BJaGp0UWt1YzdNZ0JTTWlhSHhKakdW?=
 =?utf-8?B?Z2VjOVVzc3A5UjJXY25ycm9xbk1zVEpsUkZVL01ZSHUyNUw1OWJ2WnpEeEdX?=
 =?utf-8?B?eFV6UWVZQ3Z6NjVhL01DUmNGcTNJdUZwN29XQlVuR21iT1ZCMEVUaExDejJV?=
 =?utf-8?B?YVBrRGd0OENMWlRIc2ZRNkhGeFl5cnNYSjN1VlM0MDlDQkU1NG9xQ0p2R2Nt?=
 =?utf-8?B?M1YwaU5YNXg0QS8rRk9sR1NBMDJ6SVBQWG8rNjJ6cmtUWGU5d2lTcFpIeXRP?=
 =?utf-8?B?ZEpqWWEwMDNQb1U5SXhTUUh1TnF1Unc5Q2NvcHVnRGdEVHJVZWtwa3d0QU5R?=
 =?utf-8?Q?KYh1uHCOFR5JU60UNo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJUYS9uUGRZZzBSMFlOM2VRUUxlYmp3Qyt2RzdUU0NZZ013V1Q4bFQ5c2lH?=
 =?utf-8?B?MWVYVTBnMEtrdTNTRzBQRTRmamMvU0FQQS9ySnlNbEJEWVRBVHM3RzVETGpK?=
 =?utf-8?B?UTY1QlhIeE83cXF2NURZOWI2YXVqSkpKWWd1ejlGMHdlZnhjbTlKM0JlQThR?=
 =?utf-8?B?UzRrVExDK2FmYnVkSWM2WTJwak5lNlNLdkpZWlNaVW5FQWpOM2RJUkZBUkcx?=
 =?utf-8?B?ckt6UURJczhJbTNHdDUra2N3SkxHSEhUcSsyTEpnemhiVkNyd0pNS2tveGZ3?=
 =?utf-8?B?bGtBUE9HaVF6eXpNejVnRGFzVHhHSlpKTVBDV0hTREJBT0JFTXAzekRLcWgz?=
 =?utf-8?B?L1FqTGFkZ1dncjhmYmlWSW1KeVNmTWNjOE5oRy9xRVZnajN3enJNUVBWdkdP?=
 =?utf-8?B?ZEFUemc4cW5CL3JOb0JoT0toSitOUHgwM2VneXNTTThKK1NrU0RtUVFVczli?=
 =?utf-8?B?ZklyTGZKeEYwL1RzMFJLMjg1Mlo3OG9ockpjQkg3SUFrUndZWmdWYUo5UTRJ?=
 =?utf-8?B?eDUycWlQVGNhZnpHMVNFYlkwY2NHRVVOWFNCWXFrNEcrUHd4ZjJEaXlVbGZo?=
 =?utf-8?B?RjNENnNoRjFuSzBRcHpYakhRaHV1MlU1bnRoMzlDYmsvMyt1M2x3Tk12aDlx?=
 =?utf-8?B?KzF0TEF5L256ekxwZTRMZmh1NW0wcXZmc01Dbm9yWWpCeXJ1a3U4VHNNQkkx?=
 =?utf-8?B?NVNEV0lYQUFicUtuOTEzcDMwOHN0RjFYLzUvZ2ZNWW43MkNqVWxOdEQzUHo0?=
 =?utf-8?B?R2g0QWhnaFY1SGJROEpBL2hPM1NhUlByNlZvUk84WFE5a21BRzFaeFdwU2s4?=
 =?utf-8?B?ODhQOGFNNkpOZmxwM0pXYTVSR0p2blZnY21QWE52OXp0WkJsYUNTZ3pVMXF6?=
 =?utf-8?B?djlpcnNHYTUyOHRhRHdrNUx5VWZ3eWxRcnBVMm5PbjZMaGtyc0dnNGtuRW5z?=
 =?utf-8?B?TlZack54UHArTExuTXRYQkFaN09RMWlrQUZqSkRDcVVrcXlPUTZpUDJYbi9Y?=
 =?utf-8?B?RjJsMUtOYU9EQXF2SFNCRHlqVzRCSXFOdFNXUXpmSEl4MHZjcmc3UTcwSTUw?=
 =?utf-8?B?TUI5c2oyZlRkY0h6ZnhpUmJoVHI3V1k2Zkp6UUlJQVo0bEJZY1FjdDdzdU1h?=
 =?utf-8?B?K2ZnekJVamUrdW5jU2pIRFh6alpya2hXWHhQWS9uK3lPMXZEajJuOUovQUsz?=
 =?utf-8?B?anNlbjhYT1hwUlp2eS9USlBGMExFQm5GWnlWN3NzSE9Ta2lsSmRySWR3T3kw?=
 =?utf-8?B?MjZjek1TNUU5eUp2QnZtWXo2a0J6cUNacW1ESHAwM3NhS0hwVmpIMjhlZHdx?=
 =?utf-8?B?M05YK1ZvNTB2dGtHUzFhSmtTbEJTeGV2WFBTSXRLUWR4R0EzRVBCSDNpQ1c4?=
 =?utf-8?B?L05oNEhtQTZCU01KSmVrTWUyUVNXZHBoUW9XUmN6ZldqNlFFa1pCK2Mxc2k2?=
 =?utf-8?B?dVNrcW51WWJjWnAwM0lJaWZ2RUt3VisxU21YTWxlQkNYMUE1alF2KzZua3RP?=
 =?utf-8?B?WDBrN0dPODViZkZ1ZENqZytESEZNa0dhT1VVeWdSbTJoeEJaR2FjcENrekQ0?=
 =?utf-8?B?aU9LK3U3TUd3ejlTM1NkNjFmbjhaNHZlZUV5M3VIV3pKVzd0UFJpOUN3MG1O?=
 =?utf-8?B?alZ3K3BwUkpiL0oyOWFudlk0R20vQm95a0k3eFowVEppdzVMc2RaZkdaWHp0?=
 =?utf-8?B?SzVLYU1FUEh4ZTFoUWcrTW9UUW10NHpOVUYyKzYzVTY2eFd6RUlKTFdGUitM?=
 =?utf-8?B?Zk1ETEJtV0dFZktHaytjVnRSS1AwNk1HbUltV0YzMSt6N1JCbkJnTkVPekx4?=
 =?utf-8?B?N1BxYy9ubnlBZUtHd256cStuaWE3OTB5dStkL1VIVk1ZZlRvcnZsc2pMd3d3?=
 =?utf-8?B?U3JBWmVWbnMwNklHL0ZNNEYzZmR6dnVuYklHYzllMlhUUzJSdW1CNzNuZTh2?=
 =?utf-8?B?ZzdOQW5UanJ3L2FSMHBvc0x5OEFNZktnNWN6K0hOZ1d5WVVuQVR2SXYvaDRk?=
 =?utf-8?B?NEVVQ0Rpc0dHajl6NXFQb0Z3MGV1b2piT0VQQ01ETmdmVnpaK2NFZTRLMnlH?=
 =?utf-8?B?SmJZaW41V1N3dlZQeDFXakppZzUzZEZleFh6amIvK2l2Q3lMU0c0RHlnb0RV?=
 =?utf-8?B?eDZ6Q0FYWkQvNGhMeG9OaTVXNkV0RTA2N1dYWitnMGJpcTN6ZWExa0lvVzBN?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ExiEv0Dk167Rp8OboW1njp2jZikfXcHJLsTcFIs/echuU04CL2NvW0/f/6XnelAoI/2AXFVhKMVldDK8+SEW3n1jMyhlunJ7sPifCJd5lzA+/uS7BdQrPsJOde/RfIXvsYdKlytTZkqPOiCnMHB/kefDFgky+gBszbF0xr9aU8OIQ09IyNmwjW4+zsDkyy5FJmax3cBTR1p1CUKi9JOqA1ucEEL3ddhVJfx2h+yzsAAxopHrrnuhVM9cP0RGOtGcY5O3IEOjJ3pr03vICmKeDo8Sk15eTvUefCbl8mbCbZ+AkyBIEscbxtdJWJNFRAZdI9SbJbKLJ2tYVXpEbY46/GtEGhPBu4Zg1/6G68TtXh6bLogkQXPsDefsi0GfryYvxN/BMgnSIyDyYT561zgoWCRSJ9SQ6JiPf3+mO/qSofqWBTxv5CznHWkEwzH4UsyzX2a2PWr5tfzeRi80w84KyeRM8NyLy+m5XWdM4Z0yUvLa7fC2F+5EPW77CTWtFBsuwk770Uweawh6fxHHOvegclHnnOo8BSrXngFwcDKjmgMrwdb0CcsC4mHA89yP8hDON0EaJTCDMTrGRbg50E0IB3a0lGHE06SO9pLUIzZ4RO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35459f2d-a12a-4f33-7fd4-08dcaa6b8052
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 16:29:47.2394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/7VwXoTz7wo3Xp+Z5a6CuUkMjTESEeTtIxs7CcIRsHg2ntDew1zpFiDYFdB8iZGmVJPR7wzs37C8qu6xKX1ZfR9MwBHgd+BY9idULzCTmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407220124
X-Proofpoint-GUID: 4dPT_T7TX7SilwzHR1fscN39BOdxDStg
X-Proofpoint-ORIG-GUID: 4dPT_T7TX7SilwzHR1fscN39BOdxDStg
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

On 22/07/2024 16:58, Cédric Le Goater wrote:
> On 7/22/24 17:42, Joao Martins wrote:
>> On 22/07/2024 16:13, Cédric Le Goater wrote:
>>> On 7/22/24 17:01, Joao Martins wrote:
>>>> On 22/07/2024 15:53, Cédric Le Goater wrote:
>>>>> On 7/19/24 19:26, Joao Martins wrote:
>>>>>> On 19/07/2024 15:24, Joao Martins wrote:
>>>>>>> On 19/07/2024 15:17, Cédric Le Goater wrote:
>>>>>>>> On 7/19/24 14:05, Joao Martins wrote:
>>>>>>>>> By default VFIO migration is set to auto, which will support live
>>>>>>>>> migration if the migration capability is set *and* also dirty page
>>>>>>>>> tracking is supported.
>>>>>>>>>
>>>>>>>>> For testing purposes one can force enable without dirty page tracking
>>>>>>>>> via enable-migration=on, but that option is generally left for testing
>>>>>>>>> purposes.
>>>>>>>>>
>>>>>>>>> So starting with IOMMU dirty tracking it can use to accomodate the lack of
>>>>>>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>>>>>>> migration and thus enabling migration by default for those too.
>>>>>>>>>
>>>>>>>>> While at it change the error messages to mention IOMMU dirty tracking as
>>>>>>>>> well.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>>> ---
>>>>>>>>>      include/hw/vfio/vfio-common.h |  1 +
>>>>>>>>>      hw/vfio/iommufd.c             |  2 +-
>>>>>>>>>      hw/vfio/migration.c           | 11 ++++++-----
>>>>>>>>>      3 files changed, 8 insertions(+), 6 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>>>>> index 7e530c7869dc..00b9e933449e 100644
>>>>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>>>>> @@ -299,6 +299,7 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>>>>> VFIOContainerBase *bcontainer,
>>>>>>>>>                      VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>>>>> **errp);
>>>>>>>>>      int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer,
>>>>>>>>> uint64_t
>>>>>>>>> iova,
>>>>>>>>>                                uint64_t size, ram_addr_t ram_addr, Error
>>>>>>>>> **errp);
>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>>>>>        /* Returns 0 on success, or a negative errno. */
>>>>>>>>>      bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>>>> index 7dd5d43ce06a..a998e8578552 100644
>>>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>>>> @@ -111,7 +111,7 @@ static void
>>>>>>>>> iommufd_cdev_unbind_and_disconnect(VFIODevice
>>>>>>>>> *vbasedev)
>>>>>>>>>          iommufd_backend_disconnect(vbasedev->iommufd);
>>>>>>>>>      }
>>>>>>>>>      -static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>> +bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>>>>>      {
>>>>>>>>>          return hwpt && hwpt->hwpt_flags &
>>>>>>>>> IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>>>>>>>>>      }
>>>>>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>>>>>>> index 34d4be2ce1b1..63ffa46c9652 100644
>>>>>>>>> --- a/hw/vfio/migration.c
>>>>>>>>> +++ b/hw/vfio/migration.c
>>>>>>>>> @@ -1036,16 +1036,17 @@ bool vfio_migration_realize(VFIODevice *vbasedev,
>>>>>>>>> Error **errp)
>>>>>>>>>              return !vfio_block_migration(vbasedev, err, errp);
>>>>>>>>>          }
>>>>>>>>>      -    if (!vbasedev->dirty_pages_supported) {
>>>>>>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>>>>>>> +        !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)) {
>>>>>>>>
>>>>>>>>
>>>>>>>> Some platforms do not have IOMMUFD support and this call will need
>>>>>>>> some kind of abstract wrapper to reflect dirty tracking support in
>>>>>>>> the IOMMU backend.
>>>>>>>>
>>>>>>>
>>>>>>> This was actually on purpose because only IOMMUFD presents a view of
>>>>>>> hardware
>>>>>>> whereas type1 supporting dirty page tracking is not used as means to
>>>>>>> 'migration
>>>>>>> is supported'.
>>>>>>>
>>>>>>> The hwpt is nil in type1 and the helper checks that, so it should return
>>>>>>> false.
>>>>>>>
>>>>>>
>>>>>> Oh wait, maybe you're talking about CONFIG_IOMMUFD=n which I totally didn't
>>>>>> consider. Maybe this would be a elegant way to address it? Looks to pass my
>>>>>> build with CONFIG_IOMMUFD=n
>>>>>>
>>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>>>> index 61dd48e79b71..422ad4a5bdd1 100644
>>>>>> --- a/include/hw/vfio/vfio-common.h
>>>>>> +++ b/include/hw/vfio/vfio-common.h
>>>>>> @@ -300,7 +300,14 @@ int vfio_devices_query_dirty_bitmap(const
>>>>>> VFIOContainerBase
>>>>>> *bcontainer,
>>>>>>                     VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>>>>>> **errp);
>>>>>>     int vfio_get_dirty_bitmap(const VFIOContainerBase *bcontainer, uint64_t
>>>>>> iova,
>>>>>>                               uint64_t size, ram_addr_t ram_addr, Error
>>>>>> **errp);
>>>>>> +#ifdef CONFIG_IOMMUFD
>>>>>>     bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt);
>>>>>> +#else
>>>>>> +static inline bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>>>>>> +{
>>>>>> +    return false;
>>>>>> +}
>>>>>> +#endif
>>>>>>
>>>>>>     /* Returns 0 on success, or a negative errno. */
>>>>>>     bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp);
>>>>>>
>>>>>
>>>>> hmm, no. You will need to introduce a new Host IOMMU device capability,
>>>>> something like :
>>>>>
>>>>>      HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING,
>>>>>
>>>>> Then, introduce an helper routine to check the capability  :
>>>>>
>>>>>      return hiodc->get_cap( ... HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING...)
>>>>>    and replace the iommufd_hwpt_dirty_tracking call with it.
>>>>>
>>>>> Yeah I know, it's cumbersome but it's cleaner !
>>>>>
>>>>
>>>> Funny you mention it, because that's what I did in v3:
>>>>
>>>> https://lore.kernel.org/qemu-devel/20240708143420.16953-9-joao.m.martins@oracle.com/
>>>>
>>>> But it was suggested to drop (I am assuming to avoid complexity)
>>>
>>> my bad if I did :/
>>>
>>
>> No worries it is all part of review -- I think Zhenzhong proposed with good
>> intentions, and I probably didn't think too hard about the consequences on
>> layering with the HIOD.
>>
>>> we will need an helper such as :
>>>
>>>    bool vfio_device_dirty_tracking(VFIODevice *vbasedev)
>>>    {
>>>        HostIOMMUDevice *hiod = vbasedev->hiod ;
>>>        HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_GET_CLASS(hiod);
>>>
>>>        return hiodc->get_cap &&
>>>            hiodc->get_cap(hiod, HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL)
>>> == 1;
>>>    }
>>>
>>> and something like,
>>>
>>>    static int hiod_iommufd_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>>                                         Error **errp)
>>>    {
>>>        switch (cap) {
>>>        case HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING:
>>>            return !!(hiod->caps.hw_caps & IOMMU_HW_CAP_DIRTY_TRACKING);
>>>        default:
>>>            error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>>>            return -EINVAL;
>>>        }
>>>    }
>>>
>>> Feel free to propose your own implementation,
>>>
>>
>> Actually it's close to what I had in v3 link, except the new helper (the name
>> vfio_device_dirty_tracking is a bit misleading I would call it
>> vfio_device_iommu_dirty_tracking)
> 
> Let's call it vfio_device_iommu_dirty_tracking.
> 

I thinking about this and I am not that sure it makes sense. That is the
.get_cap() stuff.

Using the hw_caps is only useful when choosing hwpt_flags, then the only thing
that matters for patch 12 is after the device is attached ... hence we gotta
look at hwpt_flags. That ultimately is what tells if dirty tracking can be done
in the device pagetable.

I can expand hiod_iommufd_vfio_get_cap() to return the hwpt flags, but it feels
just as hacky given that I am testing its enablement of the hardware pagetable
(HWPT), and not asking a HIOD capability.

e.g. hiod_iommufd_vfio_get_cap would make more sense in patch 9 for the
attach_device() flow[*], but not for vfio_migration_realize() flow.

[*] though feels unneeded as we only have a local callsite, not external user so
far.

Which would technically make v5.1 patch a more correct right check, perhaps with
better layering/naming.

>> I can follow-up with this improvement in case this gets merged as is, 
> 
> I can't merge as is since it break compiles (I am excluding the v5.1 patch).
> Which means I would prefer a v6 please.
> 

Ah OK -- I thought this discussion assumed v5.1 to be in which does fix the
compilation issue and all that remained were acks.

>> or include
>> it in the next version if you prefer to adjourn this series into 9.2 (given the
>> lack of time to get everything right).
> 
> There aren't many open questions left.
> 
> * PATCH 5 lacks a R-b. I would feel more confortable if ZhenZhong or
>   Eric acked the changes.
> * PATCH 9 is slightly hacky with the use of vfio_device_get_aw_bits().
>   I think it's minor. I would also feel more confortable if ZhenZhong
>   acked the changes.

I guess you meant patch 6 and not 9.

> * PATCH 12 needs the fix we have been talking about.
> * PATCH 13 is for dev/debug.
>
> 
> What's important is to avoid introducing regressions in the current behavior,
> that is when not using IOMMUFD. It looks fine on that aspect AFAICT.

OK


