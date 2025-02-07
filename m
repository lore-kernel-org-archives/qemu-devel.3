Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2EAC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 20:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgUYO-00013I-7s; Fri, 07 Feb 2025 15:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tgUYM-000134-UZ
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 15:02:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tgUYK-00035p-9k
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 15:02:18 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517IueK4012101;
 Fri, 7 Feb 2025 20:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=pz1q70sSxd8xrewMgJgKf5yRXbNPcacvNBzIb20cRuw=; b=
 KxbAX8YUvra9d1lkyjliOzYpBSoFFPBCBELgd0A47DgQjZl+GTuEGRJ0iVOH4+T8
 tIpWD3lcJlwshQbZEUZzeOR5c4aGB8oFOpH8XDfXsWnFAdSTNt23gn6Yz/u7X/OC
 Vvuw4iOMf9nPqPLqlxie9NMthEXnCI49fPiMQ2GXYEWT8lo+zvZrC9YC3RTU4uvy
 K3oHkF9+WI78DW6pnVfzckkNrADwnIQ6Gs+IZDLk5S0N7vH1eKm87HonmggwfPxW
 PRSZTjwHm/JYiYOPxJl3akySyTyFwb82Po1eulgC+2Zo1QPOsPbvhUVmylGskOqI
 lDg2h+5cLxtf5yyXynNnBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44n0fsjfbw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2025 20:02:10 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 517J3aPJ022526; Fri, 7 Feb 2025 20:02:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8ecape2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Feb 2025 20:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SCt1stcqr21fujNq2YEUpcS9MJKk3PuNQMcGkuH2RPpjqz3/nniADs69tVFPYvoCOI/809zAvP5UdFcT/9bWG/CKksNMAw2xJ+d1GfC5i+VlDak0l/Hxemm+CnFo6zDRNRp2t9ZZisI2ErHX7/7Q+amuXM1RJBv/ReOdmgcxva7f16Df4XxUC7HJK4uTZE9JmWUa5I3CBQTJbcAosw8pTHQLPec+bmguD2JKzen62/AwjVtKnOAIXnBbyXeeeR7FPKmr27TBRd/LFXN6P+taZZPtqOadfsIp7/zu7BZsyFMQyARgHBAdipkLDHZZp1oOy5kfShbdoT8FjH13zXQDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pz1q70sSxd8xrewMgJgKf5yRXbNPcacvNBzIb20cRuw=;
 b=N/iJL5ZKZUv4rP1NgxaBXS9mDwPu3JDZpkBc8XMnnrwIav/9hRPB+f2NZ5FMJctj7oR5BlcraoFIaILraJGHodviTBYz6PFlJLW1YwmhJSKvyfQjQ3blb2IK/JACpxqRSb0HHhoJhM0A46x2CsrHhO0psU16fP+n3VIhIyEJCADs1r1TMwpDRQp+0WuCdiRX9+CnA0WeKsZhs9zTY3j4vQgE6+9Q2+e7yeb/TbTgN1WrV+wo43o58LXnhbCINokv+UHm4nsuJOf5qoP//DCjhDqkraeN7cup3babasKZotvdBXdUjyEx8A+nWbJ5t4xVUhY+jvzbRIEn9VKq8LOR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pz1q70sSxd8xrewMgJgKf5yRXbNPcacvNBzIb20cRuw=;
 b=e4qhfLf+l1s1Wv9exthmXJ1x+dQjll6+IyObXTR8dMQAfm6Vj+6PTY3WDAO+ZZBKp+IDDpWWaJW3kdRIQjrZCrXtWsYrLunX0UhyXnCB77+0m/6ph6Dpx3nOLQBgvJxi4lLK5T3jBoYc5S+mx35OHfaaQRyn8J4Y1FLxYe5gNnk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB4856.namprd10.prod.outlook.com (2603:10b6:408:12b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 20:02:06 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 20:02:05 +0000
Message-ID: <5dfa4bc5-fa4d-4047-b212-dec3b57457f6@oracle.com>
Date: Fri, 7 Feb 2025 15:02:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: use parameters.mode in cpr_state_save
From: Steven Sistare <steven.sistare@oracle.com>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <1738788841-211843-1-git-send-email-steven.sistare@oracle.com>
 <Z6PX-Shf7UREfLD7@x1.local> <b30ab9b0-2ca2-4bfa-ab11-a09d73bd85b4@oracle.com>
Content-Language: en-US
In-Reply-To: <b30ab9b0-2ca2-4bfa-ab11-a09d73bd85b4@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0262.namprd03.prod.outlook.com
 (2603:10b6:408:ff::27) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB4856:EE_
X-MS-Office365-Filtering-Correlation-Id: 858f143e-dd50-4171-fe3d-08dd47b24b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlQxd0VXRkQ5azl4NGowZnVZL01kb0N0ZVA4Vm1JeXVnTDR6SFRiV3hOYVdp?=
 =?utf-8?B?R0c0K0REZnFHVHZQam9ONEczU2hyOUhKb2pzYjM5cEttMUxQM0xhbHM1Z2lL?=
 =?utf-8?B?U3lDeXdXcGpoNVRKNkNPTmJ2T2R6ZDk5bXFlTWdYVG5CTFJYNTRaMGc1T0xG?=
 =?utf-8?B?amhrcUNTR0h1dXY2ZVZGUENlLzJWc0J4TEdWMlplZFM5Q3BSNHZyandXc2VF?=
 =?utf-8?B?eEtOYUQ5d1ZLTGhnOUZ1dC9PREUwVTlncnhHR09JbUtwOHAzQThJK3A5NldW?=
 =?utf-8?B?NExRaTBNMDlCOUVMUmcvK2dtYkw5cmJpWlViKy9Cb2J3elcyM1g3U2s5MzFt?=
 =?utf-8?B?SVVwd0NwTGxRdDZNSTlOaEZxMGpmUUc3b1UwQVVVQ1FoOFBLQXZ2NnNFbnBV?=
 =?utf-8?B?UVpYQXFMcy9BdEJwZFRhejVMUkVqdGtoS2orZFdOTGNNcENjclVWNThJZit6?=
 =?utf-8?B?NjBPcWpKQ2d2QnF3NzJra0w4dTRjT2pwWW5YK1NjZStpaGhaNk45VEplNmFB?=
 =?utf-8?B?Ujc5RlljM2g0VXVrTkYvVW9hREhWSjY3WUkzN0trb0Jnc3h2VXdLRzF1NkZp?=
 =?utf-8?B?VGNwSGs3UitXcFZpemFqNEl4T1BoK1laRUxGUDFmZFZ2MEt0ZkdGVmtDMGZ6?=
 =?utf-8?B?UXk5ZGdXWlIxajQxak1hUHFEbkhOUEI0Tm9VdWhaVTJhYUdibStibUl0ZERn?=
 =?utf-8?B?K1VxV0g5K1ZZTFJHb2cxK0p0RTdOT1J4WTZpVUt1UmNSMkszY1V3aWRvK3E2?=
 =?utf-8?B?VWVTcDlSTk5Yci9KRlk1T0VNV0o0WDlWTTlOUUVZVmxpemhzOEtWeSt3NTY1?=
 =?utf-8?B?UHVoYVZGUnY0dGljREhFMW9NZko3YnlUM1AvT3EvdDZwbWhweTNDZ2sxNzZ2?=
 =?utf-8?B?dnE5VzBjb0FlRGVsWkRiamVCelN2enR2WU1vek5QZlZHMTRDYzNqNHF3Nmd0?=
 =?utf-8?B?cDFGOXFKUlRpRnJMWW02RTU5YWpMeFg3RDlCbS96UUlxblZJWnZNTEFERmhM?=
 =?utf-8?B?TlBNd040a1NVc2tpV1RVcUtGVjZwUUczNWVuSTVZTWRDMkt0OWlQQW0xM0tj?=
 =?utf-8?B?R3dWNTRmS04zNHc1RUFnZUJRMzRaalpZWE5KSkJKdW1GbjVDOEdwRzduR0dQ?=
 =?utf-8?B?VVpJZE9OTSsvOEhFVVFjTzBTL0FKc1IzRGxNekZtdkFpQ3pwdVJGQ280WWRC?=
 =?utf-8?B?UHhUNFo3OC95U0t6bzkrQ0tMM2U1bUxSQTlsVk5haVFPK3NVSXpvREZjN3JK?=
 =?utf-8?B?Q0dVc0dwNFNIVSt5SFlCaUEyWEltOUwxWUNSQXlHaUtmRGc0K0NkekYrWVFt?=
 =?utf-8?B?ejZ2Qmp4TGpkUFplalJkemYvNGxFVDExMzdGdG1wdlU3NmswL1c5YVprZFhO?=
 =?utf-8?B?WkNtdGJ3V1d3eERwTHVNbHU2LzhxcWRvTVo0WlJKOFE1ZFN0WTE5Wk5UYzg0?=
 =?utf-8?B?OGduTmp1dWxvak5TVzRxM0ZjK0tpem9MSXRKcFg4QXlLRkprRDB3YUZ1Yzgx?=
 =?utf-8?B?R2ZoWmdHQXY3ZDRSZk4rb0V6S2lHQ1N6bXpxS1pFZFZnRkZEY3NNY2dyYWpK?=
 =?utf-8?B?MkFCNTA1THp3MWsxZTVCa1FHdlJGNEdseGVRajlJbFJPK1Jpb09wQy9jSW5E?=
 =?utf-8?B?QnZhdUZhZTE4Vkk2Z1RoN1hMNFVzYXl1ZHVhUUdTZVJidm9IeWpuV09hMGtP?=
 =?utf-8?B?WGlDdWdTbThqd29lUGlHbmhsR0tDUXg3cUtabms4anJHV0VVUmQ1WHl3NWdG?=
 =?utf-8?B?UTdxdXdHOEVQYy9zQndiWjhGaXdaNU4ySm5Vd0pqTGVnMmlKTmYvcDBXVVBv?=
 =?utf-8?B?Wmgzak1QdHpaWXFWSGk2czNCTHQvblByQ3YwUGNqR0tjZGpWYmZ6YnI4WlFD?=
 =?utf-8?Q?d+1hWMENnG1g6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnErNlBqaG5MSCtpTENMQm5wUDJNOHdlZlVnLzVpTkxVWmZESUpTK3dBOWM0?=
 =?utf-8?B?cjAzQlZNeTF4c3RkQnlucHMrNnpDQkthZ1BPRzBKNmd3SEkxSDd1U3BlaW96?=
 =?utf-8?B?WklVV1J1ZkhGYktzd0N5dUtQeXdybWxRK3VUODdUcmRYMkdtTUdqMVlER0pO?=
 =?utf-8?B?dUVCREhWd0l1Q2M3dEN0UTQzWHJDQUFDdU5NMWRreVlJb2pDdittYzFqVXc0?=
 =?utf-8?B?WkVMdzgwV0NmOCt3ZnRtM2tNUWdncTZibkx6SituVk9MMTMxakdrK3lPL09u?=
 =?utf-8?B?VVlESXRxMU0xYzFvNUg3T1NHT3NIaU13T0xiMEJxQ0ZoTzBGdk45UEVxNkls?=
 =?utf-8?B?RDNVOGZoSUx5VHMwM1pZZlpIbHJzRndXMXFTaTczOWZZY09UYWM1bkxDN2Jn?=
 =?utf-8?B?UFJGbGJqOFZ1Ni92Z0hyNlJmUzB0KysyVk9jY2puUjMvOC9OYWVzamtHOHF5?=
 =?utf-8?B?RVZCRWFYandnS0pubGRpWDBETFNWN0VIT2JrM2VnNm5XMFVHZHQ4MDU0R2Nk?=
 =?utf-8?B?VzJUKzM3UEx6UVJaQ2lJb2ZMTStsMGVaZk84MkZCR0VEWDBQS3hHNndWWU1r?=
 =?utf-8?B?TUI5aHo1d1lZUlF6Y3lSL1VLYXFnZlh6Z05yNzFhUFp0Z0I1bkdvU3QrM1Zt?=
 =?utf-8?B?RzltdlNzVHcwWmxEQ2xmUnZjQ2ROZW53Y0NERTIvZnBpRDNPa0labmFzQVZv?=
 =?utf-8?B?bU1yNTdzN0EzdXhZN2FVbjVkMHVVbTZjR09mQm52QmFBc291SUNabVlvR1dR?=
 =?utf-8?B?NjdDNUVObndrTWVnTG9sN01WRng4MUtjaGkwdVlzWnlYMEJ0VGVtRjBHalJY?=
 =?utf-8?B?TWx1V3huKzJPK1k4SVNGYVltUFVKU3pSMm5kZWhzdU44RWlESW9MajdicXl2?=
 =?utf-8?B?cnZwc0JLS20zZmFKREhLSG5mTU9aLzNHS014TnowYzZxeUdUcFNqS2E2L2U3?=
 =?utf-8?B?RGg5UGFYVXNXcGtDQjVLRWNqNmlzY0g4MGUwV2RpM3BWejEyNGQ5WlVlMXk5?=
 =?utf-8?B?L1VDVDNMSEdtQUJmWWMxa1BpU3pxYnhHTFBYWWtKbCt6ak5SM01OSFRiME5u?=
 =?utf-8?B?bTZFdWxJQ2hEcnZhQXc5Mm42c05wZHpMODRuek16MmNqMnN4ZnNtUy9tVi91?=
 =?utf-8?B?dzkvWVM1aGt4dnZRZVRYdFdjcEk0U0pPNDdON3p0ZzZ4eW5RelF3TVhFQ3FH?=
 =?utf-8?B?WC9ibGZyUUdRcVYzTVlFQVRHNVExUXZxQUJKSHZmMmJQdml0cEhFRGdmRW1C?=
 =?utf-8?B?a3ZjUndaVlpHRlAyQ2JycmVQSm1YWmRac2xMNWIzK1dRa3BSUFh2SUpEeE54?=
 =?utf-8?B?WXorcmlzeWdpZmIyMG5iUldpOGdMTXpPMTFBMCtzczQxbVZTNmw1MGlKOXpu?=
 =?utf-8?B?Y25idGs2eDdEUDYxMGRZSVJ4MU1wN3ZwWWJ3d2ZmanJkZFM5V0pRbFpaLzdW?=
 =?utf-8?B?Z0dLVmduWDd6WmlvTUJ2SmsyWlZFcXptaEM0SG84cS94dVRVUGxyTS93bUtu?=
 =?utf-8?B?b2t0eTQ3djRCeXdkaEV6ZXBEejhnV0NHQldxWStUdTdlQ1BndG1JbnJyakVP?=
 =?utf-8?B?Y2tqei9mbm0vTWRzTWFtVUpnMyt6bVBJazgyZldub3JQeDd3aW9hRVZNYW1u?=
 =?utf-8?B?ZWM4TXg1WktibjdSZDAzY1VuVVpCTDcvdENXWGZ1OW92L2lrenV6TzZ5RW9J?=
 =?utf-8?B?cnk4NldrdjI2WVFxMGJZOXcwK2tQMTExeXMycVI1cnd0eWxmUXhROHY0ZGEr?=
 =?utf-8?B?NzZxdnJmUnZqNU9pR3lrWlgybVJqM3Zlcm5NKzNmWldEYkQ3dGpoRGpEeHRr?=
 =?utf-8?B?TDNnR1pRSXlTMUgxYklDWVBiSGYwZHpZTHpiV2dSdWhZK3YyeFZDM1FBd2Zq?=
 =?utf-8?B?MTE0ak5UeU9GaTNEY1l2aWdWVXByZ1VlWUlPbVRhQStmSGRBL25zSnVuQVJP?=
 =?utf-8?B?UEU1bERpeVhqaExjWktUczNZV2FFM1NOYVRUMnQySUs2RXF6UWdCMHA5bmd2?=
 =?utf-8?B?dnlzWU9GaEN0SjdwZlJ6Ti8xRVREOW5valBXU0Zlc3RqaTFaZzVzZ2ZIbkxH?=
 =?utf-8?B?enhMQTRXNjVjNkk4dnhqZVNDeUhsNk5ublV5dGFNMVRhc3BaOGkyZ3NmMzhZ?=
 =?utf-8?B?UG0xa2dNOHI2bGpOd2FhZVdxdGZROG9BejMwVjNuTFg0ZFhjTWdNMWdQL09i?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C0nBNoynSKSzRhKIY3y1jfhKEp0b6RrI1o7EGECZYrm7FocrbYg3y5DhHF6HUStpxJFNZuzDJmI5K7M9QX6qP9bJuVyoXT+cslQFS7n8M1n5xwNToroVTr/UHxxU0w4DL3eMz18LPKHeDsn4e8O/c18CkhoDxhH3cY/zX3vPeLx54FHX2UlKJ2yelsyF3UgsZbitcFSRvI84VkYuiYkT0cXeoZdyCKJYWaWfZuBQN44h0FX9vPdVhMe8i8PJ5tJlRpQ8T0AtCCn9cGvfkSeSc11y98KUGTM55Hci+Gu8qjq5vrWj0IqxG1x1ILNM+DytkQl/wcafWg382jtHXarNFbK0br3l++ugtrCq+wlR6uJ4q23+vh11uthLgEKERgAi1/QGyIem0su264AvfqovkIBnGV7z1RhJvy/wMTfDVjdGD2AFXRlKiVC5sy4qcJNZIBgGRstNcJ2WzYplVa859LkXGsTr+PWyC4yhXGMVwzawVUBb4Bo5bBxKR3RteH7O7xNdS43NLxk1QYz9FnMxPPTky0Pmhqlo4NihQ6TjbK20KoXStxF0No8nfON4VZHwhgTlFMs/j1QirR+DMCeeiRhd1hNbBfcnWfAaPmLbDeE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858f143e-dd50-4171-fe3d-08dd47b24b97
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 20:02:05.6350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np8Okc+3qzM55HYFDsXU83YNFwlh+UGra7X5dK3JVqP6Psa5F40PjtqlovElYdoqzHLREFGGJ0VSYEKlTamutoLUROL2Ui6jxGMzATdjPoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4856
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502070149
X-Proofpoint-ORIG-GUID: EZT0-ZSc98VDncG36q-o0SSNo9WUHSyY
X-Proofpoint-GUID: EZT0-ZSc98VDncG36q-o0SSNo9WUHSyY
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

On 2/5/2025 4:52 PM, Steven Sistare wrote:
> On 2/5/2025 4:28 PM, Peter Xu wrote:
>> On Wed, Feb 05, 2025 at 12:54:01PM -0800, Steve Sistare wrote:
>>> qmp_migrate guarantees that cpr_channel is not null for
>>> MIG_MODE_CPR_TRANSFER when cpr_state_save is called:
>>>
>>>      qmp_migrate()
>>>          if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>>>              return;
>>>          }
>>>          cpr_state_save(cpr_channel)
>>>
>>> but cpr_state_save checks for mode differently before using channel,
>>> and Coverity cannot infer that they are equivalent in outgoing QEMU,
>>> and warns that channel may be NULL:
>>>
>>>      cpr_state_save(channel)
>>>          MigMode mode = migrate_mode();
>>>          if (mode == MIG_MODE_CPR_TRANSFER) {
>>>              f = cpr_transfer_output(channel, errp);
>>>
>>> To make Coverity happy, use parameters.mode in cpr_state_save.
>>>
>>> Resolves: Coverity CID 1590980
>>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   migration/cpr.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>> index 584b0b9..7f20bd5 100644
>>> --- a/migration/cpr.c
>>> +++ b/migration/cpr.c
>>> @@ -8,6 +8,7 @@
>>>   #include "qemu/osdep.h"
>>>   #include "qapi/error.h"
>>>   #include "migration/cpr.h"
>>> +#include "migration/migration.h"
>>>   #include "migration/misc.h"
>>>   #include "migration/options.h"
>>>   #include "migration/qemu-file.h"
>>> @@ -132,7 +133,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
>>>   {
>>>       int ret;
>>>       QEMUFile *f;
>>> -    MigMode mode = migrate_mode();
>>> +    MigMode mode = migrate_get_current()->parameters.mode;
>>
>> Are we sure this can make coverity happy?
> 
> It should, based on Peter Maydell's analysis, but I would appreciate
> if he could apply and test the fix.
> 
>> Another more straightforward change is caching migrate mode in
>> qmp_migrate() and also check that before invoking cpr_state_save().
> 
> Surely anyone would consider my one-line change to be straight forward.


Given that Coverity complains about channel, and not mode, this is the
most direct fix:

----------------------------------------
diff --git a/migration/cpr.c b/migration/cpr.c
index 59644e8..224b6ff 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -160,6 +160,7 @@ int cpr_state_save(MigrationChannel *channel, Error **errp)
      trace_cpr_state_save(MigMode_str(mode));

      if (mode == MIG_MODE_CPR_TRANSFER) {
+        g_assert(channel);
          f = cpr_transfer_output(channel, errp);
      } else {
          return 0;
-------------------------------

- Steve




