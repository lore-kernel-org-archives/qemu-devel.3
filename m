Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513F5CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 18:40:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urL2q-0001oI-7Q; Wed, 27 Aug 2025 14:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1urL2k-0001mr-OL
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:38:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1urL2e-0007oS-6r
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 14:38:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RH7MYM001500;
 Wed, 27 Aug 2025 18:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=mZdWOxy4/DgGXICxkg8Q4t+oplP5cX/4fGH6eGPNnl4=; b=
 shGzDpfVnOQHOZC+T89nKg10ssWMC/WrzI1MSwf9Qql3OIwmVHElxaO46dWy3ITP
 hqm/lYqo0dVSNnJimOKKQXQ6G39pyZ9Lmi1X2NYWNG4cI9sX32L71d+VpiwU8TzW
 D/U6zrsETd1macgm9D53fMxj+VPoRoNLzwzOSCpfeJKVoJ77bPlAbIr9skFPIQkt
 lmbCPFsPb/2IFdp0L1JxuBihyVSoSnTo3WJvfbZUHqlgjVJcYi8iGy+95dX5Ix9U
 WjGEzLHQ9DJ88M+sMOkgGi2V1BnYiq3SmTED/OkwAH4vjqdm8cG79gl52W1O4j8D
 Zzqh3IouVUcTQOSV2SOXHA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4e275ss-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 18:38:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57RGwJg4026711; Wed, 27 Aug 2025 18:38:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48q43avjsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 18:38:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IROzXtvwXF/Ww7UXcLgnrHSC/DuP75ex00QcxkKDkveFSYKxdw70699xGWexYpJ1TQ7cP1Bejng/duNeDc2+WrkluOTugRM2o4zQN9076vmvOTnCEC0mhDjstdqgzuLufDUolpVujtzfyRPPqTgtAeo3BFzeAuVcHJm9cQAwO1KanH7pjMNskglcJofuMOdBlfXHYIXQwvZe5T448xnFn2rgFXGRBJQ33eNXMM+OYePrR9yMe7atOPfXxHNjmqSPSsym+D9nFZ2OcDZT0dRwRn/lODo6ZcNhCKgajIypxL/W/l7YRhr/kZpwED0Qf6ACqFz2T8DFsv9vo/GkenIyig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZdWOxy4/DgGXICxkg8Q4t+oplP5cX/4fGH6eGPNnl4=;
 b=AOMJfcOZFNvJX1280nViPva7ueywhqjqawf7mbmPUMduBp985nxQ1Vuh1j9s6h2sXDv805RrEqkkMGZl5cBuM6uNTpVdUtVJ7wHnvQqb4HQWLAes38kXaGBS9L2VRJgcPLgJtzhsaAgEV/NTNflukWI2wANIz5gq6MNWtMC47j7CFGTUZ+wGr7t0nGy7E6uJBbUJa4z/r/3CP88OKR+aNZ0Ri4sQQ+rHrTdesiutkJruFhyoZHHpnKob0GTwEQgtvbteXmT2AFZe5Yy70UkJZOzVhrdbOnJEoKVp725GJ7p/1j+Cn5oJSWcHXGAQX2Avnis9hbDjQ6Dfu+donnrdtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZdWOxy4/DgGXICxkg8Q4t+oplP5cX/4fGH6eGPNnl4=;
 b=MzlBmWruTUJ0MkeyWOz/KdJSo82fsNCQj1upE1YghPexzB8FcmxuI/d1sMVmr/3dCgQGpNMyNuIc6iqpPzMQ2T5SojiCA9kxVFgdH37Xqkm2oa1GUciy0yD+UjBef1+v3HYAEtGXdG5vVjRE5o5QXZ70KVTEolnIXzO/YHH+RRw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ5PPF972B28679.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7ba) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 18:38:27 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 18:38:26 +0000
Message-ID: <167a6839-2b8b-45aa-bec2-4edba69c9754@oracle.com>
Date: Wed, 27 Aug 2025 14:38:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 3/8] vhost: reset vhost devices for cpr
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hamza Khan <hamza.khan@nutanix.com>
References: <1752777568-236368-1-git-send-email-steven.sistare@oracle.com>
 <1752777568-236368-4-git-send-email-steven.sistare@oracle.com>
 <9de70bbe-4cb0-495e-91b5-6b64bf634bdd@yandex-team.ru>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <9de70bbe-4cb0-495e-91b5-6b64bf634bdd@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ5PPF972B28679:EE_
X-MS-Office365-Filtering-Correlation-Id: b18dd631-df4f-4965-9970-08dde598e919
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnR3TkkyTTd0TDNwbFJnNjFEOVJIUzE1UVJVSU45VkFSVGhZcHJHa3Jiaith?=
 =?utf-8?B?dnprVWJETCtUbzdBekxqelYvRk40NXYzelVhVndzRGgyaE1ManNzWjBBd3g2?=
 =?utf-8?B?MkpNLzQwMnV3dStKZTJNSW00OGdhMWZENWFpRzg0ODJQQU56ZnNjRzNVNGhr?=
 =?utf-8?B?b0dLNEJXUnE1WmR3WDRLSy9iTXhkYVJFY04vbzNyc0FjUFpYQTZoM3VYZXdk?=
 =?utf-8?B?bjlDczhRT0Vrc0U3RFBudmtjQ2gvbHo0UGNaeisya3MrMGlEcVUrRHh0OWJM?=
 =?utf-8?B?TUxmbko5emJaZXh2bDM1VlVMODZ5aGQwd3RTZFNXbUhwY1B3SkFpdnFSNWlx?=
 =?utf-8?B?U2x3d2hmcXVaY21TSWdjdUx5M2hUUE8ySXh0eXgrRDZXWnZSUlNHU0VQUXJP?=
 =?utf-8?B?aVFGNDZRK2xreUc4REVQalZPcnhWVjRwYm9NNG9Ta3hYVXRtUU5MelVMeTlL?=
 =?utf-8?B?K1pQaDZjWmNValE0eml3MGlUcUFONGRXOFhac2NRc0xSdEtuNXNIK0FramhJ?=
 =?utf-8?B?cEcwaVdsOEtieGdXcWFVSDNlSkNHSFNMR3hDbisyckRvNVlxY0NCdjZTSTBX?=
 =?utf-8?B?N29qQWtlNTRkT1JhQ1FjKzNVZUwwaGVpTWNReENidUZub2NwR0FJWU1pak1j?=
 =?utf-8?B?clR4Qy96dW9aTzdleWZRUWRWcTFFYm9oL1RoSm5VU0tQMlZ3UFY2aENiVDRW?=
 =?utf-8?B?WjNsa1FERjlYaSs5SlQrYmQ4bU5XRkxYTGlSWnlXejM2ckdKNnJzei9EVHRC?=
 =?utf-8?B?MzJKSy9sbG9lYUZIa25HZjVpWThGSjQvVWQydHFWNnlrVlMzdlkvUWQwckRw?=
 =?utf-8?B?Qk9GVmJ6cG1VWTRtdEFXNWVzQUFneDdTK0VSNEdjcytKY0RqNkZScEdnM1Fo?=
 =?utf-8?B?L0VTVHFFR21Ta0xCMVJld3JpQzZnS0kwWEF4ZkM5Z1RlS2RJT0llZ2d4VUcx?=
 =?utf-8?B?aGE5dXJUbmV6VXpoaGpJdHVraUs5UkQvOG1VOXVwN0g5Z2ptVFFoWXN4aVBu?=
 =?utf-8?B?K3dBdDR1bWVBMHFMank4Q25QR3p1YTQ0OGk1ZFRuOTZLNEQydFRVeEtKV1I1?=
 =?utf-8?B?MDltalVtS3U4NTF2bmdVVGhXcTYybFcycGJxd2R0eGdlVll0ZmdVRjd3WUVy?=
 =?utf-8?B?Nmg1U3JxSlFGUUxsekZ1ZlBWd1RPRG1vODJteEhvYXVzWnhKZkdsRjVQaWg2?=
 =?utf-8?B?WHNSeDF4N1BxWm9rSGtSWWs0TGtqZmpRRnUwR1VyUmd3SnlmOEFPbGZhdnNN?=
 =?utf-8?B?WjlHc2JsZFFsRm14NWdXQlJ3cWtwOStGQ2sxSFNDSFdHREJFUXJsbFcremx3?=
 =?utf-8?B?QXRyZ2gwNE1udG8rOUxxVWF2bEZqY281WTQ4akdaRU94dSthY2ZDV2lUYSt4?=
 =?utf-8?B?QnF4VTIvb3R5bVgrc0dQNUtxVUV5R05TaFVpV29ubHI0VE5HblN4MnJ0alRV?=
 =?utf-8?B?cHl1OFUybVVRYStZUmpGdE0rREJXNWc5L2xkNmowdXZwc2NncHdFZ2ErRFlO?=
 =?utf-8?B?R2M3ZnROWEcrNWZXR2Ywb0REWTFMZXFqUW9vK3dxNFd5QXRiQWM3TkJaVm9i?=
 =?utf-8?B?TUpZZUo5aXRtOUNJVjVueDh0M3dkYk9WeHBjR0htOVpwUzFHZUFDNmJUS3lU?=
 =?utf-8?B?VGRQRDZvMFlHN0VobGdxaldWSkpVUmYrSm9PblBSRW5LdzRUcFoyNjA4MnhV?=
 =?utf-8?B?WnFVdVZMV2c0K1IxK09QaE5HeDJpNElMMjVlR0ZtWjZlRFZFcU4xWDRzTVkr?=
 =?utf-8?B?NDZBbEpnTFdNMzl2L0xJVC9SZU1Da2hBZndwUWFPNGRDSXk1b0g0UnhEdS94?=
 =?utf-8?B?L0pWQXdIOXJxeEtHdzRqYmtEU3F3aW9ZNW9SNkt4QWx1Y21oOWwzZTM5aUpX?=
 =?utf-8?B?R29tcDNOd2lLNyswS3FHR1U5bVZiVTdXU2tMMzJQT1lJemc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Snl0NXZIc2hjcEcvR29ubFQwZkJVZTZadEo2SjJDT1IxVUIrYTRzVVBvZ0VI?=
 =?utf-8?B?OXRWVDFHVitjY1RsUVZDQXpXL3F2WHBIK1NocWZiRGFSNFhWdXEvcGxhQUlG?=
 =?utf-8?B?NlM1Q2ErYXpTMFJpNlFVVVV5R2pyUW02bjgzdnEydm9LOGZwenJLWkYzdmds?=
 =?utf-8?B?OFUzSTlicDJXVU9GQUNoNFpnT1ByNG5HSmcrdmVHQ1EzeC8vcGwxRU9aSVRl?=
 =?utf-8?B?cXpTbVVXazVBYjN4TXAwMVRzalVYUHd0VmVKYi9RcVg5MmdtQ3ZDeGFCdk5l?=
 =?utf-8?B?UnIrbE9mZitxaW9lc3FKMzFWY1NRTGxsOUtGTVlWaExMaC92bHhoeU9Cd0Qz?=
 =?utf-8?B?cFRIQS8yTlNXd0FFeGtNZThQQlE0OXRJVGQ4YW9ZOUEwUHJMZ1RFZkxtbS9q?=
 =?utf-8?B?Z0FMUTFGUEFMNzRRd2Nvb1k3NDU1ZXN5bU9iVVF4S1g5U1VXMFVTY01BaEZ2?=
 =?utf-8?B?dVNtWU1kR3k0c0lxSmx3aVN6WGk3S00zOGJsMkNmcUtJSzZwSzBDSGlRQjlZ?=
 =?utf-8?B?bmtFSGVQTGhac2F2cTRQSlBxdUlVQTFoemFJMlpGTzZQcHovcTNsYzlkU3BP?=
 =?utf-8?B?VHBSVjd6NFJGdUFCRUJMNjRyY3l4OG0wKzQvK2lSMlRqeFpjOGxxQWlJYzBX?=
 =?utf-8?B?VnJhMkkvdm1vN3dvcGVKc0NuRzZWM3Vnb21xcTVhY1pNNlZWZ2t2R0J3T1FK?=
 =?utf-8?B?MzQrRWcxaHZUNGZPZk4wZk03Uk1RaHpheWtNRStoSlNJdWNTcUdhMnNvZXVh?=
 =?utf-8?B?RnNyUUFoVDZ6d3AwWTljM2RLaWlwNnNJVjRFajJaM0c1N0libXJNUXMzaUMz?=
 =?utf-8?B?N2VSS2FDVnFxWElBQ3k4NklqOUxIbWhOWlBTbCtBVW9NK0hHeEZrNnNsRDI3?=
 =?utf-8?B?VXlWSEpjS2dPVk91Vk9xM0ZTUnM0SEZlb3l3cVJ4SktjWjVLOHJSZXZTak9J?=
 =?utf-8?B?bGtwYWZRSnBNb2pZQ2J5ZGlyUmFoWlZRM2IxVThvaW96K2ZoT0xCYXVGZGdk?=
 =?utf-8?B?a1RITEtjSUt0ZnlqUnRVUnVFVTNERjNoaC9IdzVFOXNocmpOYTVsSzR3SVNW?=
 =?utf-8?B?U1gwQkwzankrM0g3dytlMm9WNXhSY2VoSjA0SFVUV20rTE4yUDhCWjZQWC9i?=
 =?utf-8?B?V2p6elo2NUhhN2F6TUt6Y2lXNkJabWo5OHRrSVI5MkFNeEVtaDdFZml4YmFY?=
 =?utf-8?B?U0xqOWduemU2OHVFSnlxOUE4WlA2NG0rYWIyYllkTlJNY1ZWeC9pSEhVQkFM?=
 =?utf-8?B?WGVXT2FJcnRzSU91OFhyNENoUUluTHdtUFlDTngxUzdqODl0Vk1iTmlUVlhn?=
 =?utf-8?B?WWFBc1hQN3BnSHk4SitPVGx2b3RWUllSUVFGTS9wdDUrS2VnTkhBQXdpUTN6?=
 =?utf-8?B?YjI5LzdlRy9Zd3JCQVdmOUd0UkRGczdvSlVwM2pCZEhPdjRZZWtGald3aUIy?=
 =?utf-8?B?d0Q0SVVGL0xkYm5FR3k2bTZyZUw1ajVRaFk1RnovUTN4bnVrV2pFWXBFb0hm?=
 =?utf-8?B?by93T0Nmc3dvT01PWW1abm9uZSttalB4ZERVQ1RQamJqcytDZFdHTVhsVmFi?=
 =?utf-8?B?bHNHUElRclEydGE5Z1NMNzFCNzhqdC9mMHZYOC9DaWRGUFFYKzBoY0dudCtr?=
 =?utf-8?B?RVZQOEcvNnpmczFjZ3EzK0hhRDlaNW4rOUl1M1E5MXRKL1podkhXYlNIZmwv?=
 =?utf-8?B?bUx2eTUxVG9SZFlXZVZRTkNhZ1VRdERIRnZFWTQwV3QwUUF5N0VlWjdRV1dZ?=
 =?utf-8?B?N25LbGc3SDBWaXB2bkR0WVhPSXU1T3VDUnNCbGpBa3Q4ek5UclVyaVhxdTRB?=
 =?utf-8?B?dm52amRta1Y5N1M4b25qVG1WaGNuQVZ1MktIcjRlS0w4SlAzZmh6M0xxc0JM?=
 =?utf-8?B?ZEMzU3dUeXkzbnYvdWFUUTFLamVGdkNSbVhYZlR2VXZ1WHlSczBwV05KUVNG?=
 =?utf-8?B?cEdORXJxOGt5eFRWMkRtYmR4bWxwMFNHQzZld1lOYmJHNTBib04xNVBHbTgv?=
 =?utf-8?B?elVVRk1BYTlWZkNCTS93UzlVYTlUd3NDclF6eDJvM2Z5c1MyeXVhRFh2NGxv?=
 =?utf-8?B?STNEVTVLOWRiemN5bU0vYk5ndlU2cGFmSndFWi9xQnpkb1BZSVJaWWp2VEk5?=
 =?utf-8?B?RGdCTkY2dUJibWZ3OFl6SWFPakJLSVhCRHk3WUNuQ2RDUUNhaU5OSnc2R3Zl?=
 =?utf-8?B?Z0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DMCvWmh0R8r763Yc7jReE9mXomt+ySfOEbxuiO4eLgmEoWxl4gnn/M5IBKi4LksUz/OWxqRfuWQcsPtPkydlFOjwVCRdGQF4dh/QaBSgIw+rMjqDt1qCrdxOpHaVDv6xxaTMGntkmmvWEQODZAfoNtqK2/Yunrda8nO7IDUPNNc497/l/TIizJ1qqlk/2mf1HZJYkf91EcF/Ax+Mnt+bpCATrGv3UT9CSmH5MWkSAiy+afCR6PvSWRsn9bWcOBO/KlLI+DP9iRPVZ6qDt3S2h6EUQaU914aFcKLkXJZ8iRuLJNxisVe4HRc37yOt68F6w7gkxDRI5Ug1eZhlX+l6DvCVQjiL1kFjfxr/YpWzFoVFrw39cavZyk3a0bTC9bq8narXVVFCE5b6ok9CSZ0CSvAEs4+w7SDN8Wvu6ZWLejVGk/D9vpXgMg25iro13cS19tXa5HGtXJNw+Lvwtc2w16HIr//8c3gPzStZmQVEA2B2QhqL+z8wf3BPGFRMVub8+/mTm/GP1ABy6YNIw4eB9oqTJMC/s1WVUzhi22Dou+V66dWYjPDtLjZ9F/pnJgKbnTfLcyZcPUbjXc7FrUK297I0vaKmTNfqCd8GDRzNv98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b18dd631-df4f-4965-9970-08dde598e919
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 18:38:26.8368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1D1sFRB4zgVtCPeuWOOcFbu9NNe5/e/7cUu6w3Gg+S88DM3nFHUxmRCChsJJOQkvze1EtYYjd5zJaT17S1DMXe0ZdxTCCe/LtrSx56IqqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF972B28679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 malwarescore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNyBTYWx0ZWRfX67Yr7UUtg+YG
 eV+Ta7BMiJtD+SRHP6lpWomFvcmItktZPbbBnjH/r3BlQmRBCOjAEJYmssb52b8x7zICvDIPiAi
 PoW0lSPcR14OiU2uT05U5XXW65qX7YOj2HSiSnhcxWzKmsuHLJGuldN7G3LZr2A2I/p8yyqud4o
 dies4kJ+vSGemb8VI0fTkG0ebv4PrAoRvLB056o9i7FN5Pv+UxOCZ+9LrzIJ5prMbrwbCSZxYY5
 2tyIPqzZavnZPQH0W5p8s6dgKtwyU+yTRR27akrXV1WTnOGzU/k0JtLbqUgmTiv31MIEoVLOu4B
 TCjNdOcpLDFQ67bF5LdhsOz3AsruMf1gFqAvkdBlzAapbj+nC06O4cmG6IKFFDNcO59qyr7m4Z4
 k+OcQl6R
X-Proofpoint-ORIG-GUID: R8HEzHp7JnjIXi9fafCvdcEIjsjpMUKn
X-Proofpoint-GUID: R8HEzHp7JnjIXi9fafCvdcEIjsjpMUKn
X-Authority-Analysis: v=2.4 cv=IauHWXqa c=1 sm=1 tr=0 ts=68af50a9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=J6MRi5YDZk8jKEtH9dEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 8/27/2025 7:29 AM, Vladimir Sementsov-Ogievskiy wrote:
> On 17.07.25 21:39, Steve Sistare wrote:
>> When preserving a vhost fd using CPR, call VHOST_RESET_OWNER prior to CPR
>> in old QEMU.  Otherwise, new QEMU will fail when it calls VHOST_SET_OWNER
>> during vhost_dev_init.
>>
> 
> But, is there a benefit in passing vhostnet fd to target QEMU? As I understand,
> we anyway need a full renitialization of vhost device, as it's just reset
> on RESET_OWNER. So, is passing this fd better then reopen /dev/vhost-net
> on target?

Some orchestraters pass pre-opened tap and vhost fd's on the qemu command line
when initially starting qemu.  For that model, preserving the open fd's in new
QEMU is the most natural solution.

- Steve

