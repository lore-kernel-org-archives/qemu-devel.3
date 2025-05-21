Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDD3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 17:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHnQd-0007Y5-T0; Wed, 21 May 2025 13:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHnQW-0007WL-1a
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:40:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHnQR-0006G0-Sk
 for qemu-devel@nongnu.org; Wed, 21 May 2025 13:40:23 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGurDI013309;
 Wed, 21 May 2025 17:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=RhN/QOkggy+tez54HZ69Lis4o6v6LcwJoya7M3OyVUM=; b=
 gplVtNA0lPa3MADzPxI8ZvJlYKVAsUJ7rDlSSXrxn3S6EvlTtKUYSuT0KT1ba2jC
 AVktS2IaSG455pt4OaW/HgT5zNVg2Lx0+r4+pG6V64vWa4BVMZw47Hnj4jrZ9qpB
 C8kGpusuNRJeKy4sicW6avcwPQwAFXOWjDeJaJn1vFgMVhO5335mUnCW0MTWtnrh
 sM6TOZ4Ni7MQOtolurMVGrfSZkTlguH/3WSSUX5PpBqm67CkuLI0MBJckyNVLBML
 oqwi5Xbo6P9uCB/jK35RUgsM44dD7O1LekN5XX1Au+pNLfcFfkaHW1SU+Hk88aSm
 y5UXva/Klw5JIisS6r5KNQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sjc2r516-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 17:40:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LGtwDh020249; Wed, 21 May 2025 17:40:08 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rweu5vb1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 17:40:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLelY41+lVUZCfy2+wk2TLi5ywl8Kj+3VaUvLTKVEOlls1cTQ7qjClO47E+vWUy+8824h/0CsAQF9x7F5GNZFzGeEljbScWX1wNizuc2ywXYpVK5d+9tswZY1bEYkp0Ubd2MFlfyvp3OHJLIBLk+rkJk0pCvTUeTqtn9nDCJeVQbb/QMlmH7A3OtOYCA9tU3FEasBNVFciQueaQ0gHux6lZKGj/VM2kAcx6idP3/CwKUQV6X2aVO1xNZADXQECQzz2oD/BhDFyk/34X7PYU2sZoP3FO0gcwmOvnayWFCX30La3mQdc4oin9OOKsdVYNHfCkVE0HE64HWeWzw+IEjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhN/QOkggy+tez54HZ69Lis4o6v6LcwJoya7M3OyVUM=;
 b=luGX2jEQjWTlC/W3s0mLnxD4hrpCsHnR1O6bPwfh3B4NK9ERySvdsMbkYlkt/1uMfJzvmQ3qHao+0ODTVg67U1gte0ybTgbv0E9ESwEJ6a6qWht/UABRQL3IqZdnkeeAr5NTNY7YCdSQYLsAUZjNw53rB2SR0UoTmCTQ5bl4z9H+KsRujgBUHAY6EXfkz+48mXVHpG17/I5GuD/zzYHIt+kAkXO95VeXccBzqBa+oPNdjrqD6CyG1RYzfJKdDJuzye/s+g0GCnBe/Jvs3aznNRvppDJGxGXe/ndImmz4c0F8IavjuCPoIHc3mljzkUksfxGdu4bK06klNAUXX8YDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhN/QOkggy+tez54HZ69Lis4o6v6LcwJoya7M3OyVUM=;
 b=JeYcaW1i7MD0dfSwWxI9IGoZwsiE+9sTaPajfzJwvz1MwNIospWQAwGSK7SaNYDH513KW1wN75UvNfDXnJoMwSyOrnEq0PnPCtSFj0g3nhZjDMyw22xcio0nzHB/IQ51YhD4cnzkiWnTr4vmM01TDh6i3RlcNOS4uy76klOLS1A=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Wed, 21 May
 2025 17:40:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 17:40:04 +0000
Message-ID: <4d7f7021-5096-4c6a-95e6-f87f321c1882@oracle.com>
Date: Wed, 21 May 2025 13:40:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-40-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744EFD14811E4BAC0C05BE6929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <050ec82e-3cf9-4058-8db5-04f5263c516d@oracle.com>
 <SJ0PR11MB6744681C4F80BCED61ECACED929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <SJ0PR11MB6744681C4F80BCED61ECACED929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0203.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::28) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c297ed5-42ef-4fda-256a-08dd988e8553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1BYUWpOR1QrUTlwcCtRbFJhNE13YUd6bjNEdDU5K3NBemNBK0p1Q2p2dlZs?=
 =?utf-8?B?U1MxQi9aL0IweitzaGJqZElsY0xCREp5Vy8zYTB4TmdDTGhueW8xTGNmdmlq?=
 =?utf-8?B?SllzeGhGREdZUnZjajN0QUR3NkI5Q0tzUDV6ZjdGSTVYVUFqVnowNWZHcy9G?=
 =?utf-8?B?Y3FBNzhZNzY0QnNKK2hLM1hacFpCVWFvMHVvQlRWRTF4ak05UkxOamdOSjhY?=
 =?utf-8?B?UWYybndoQjJreEtnN0IybjNtUVBKNnVVSERSbU80MmNZbUY0eGlINjRHajEr?=
 =?utf-8?B?QnNEZldxYXlGNFB2WURvblpiUitGd3MxSWliL2dFV0EvMkJnaXFVMWoyUGw1?=
 =?utf-8?B?bjZXNCtHWmFaWUd5aDVvV1RjRkt3L0Fkb203cU5KQkRWVGVUWWhvd0tBMUt1?=
 =?utf-8?B?Z1JSQjFJa2l6Vy9WRzk0VXlYMW1CeHBBTWhBL3dQdjdwOVl2QWF0RzN2d1dz?=
 =?utf-8?B?K1YyQm9BbGFZbE9LbHpFRXBIQ3RXNFpIY2YyNDlYT0RIVlNRNHpqR2JaOFlV?=
 =?utf-8?B?R0xEU3Y5cmE5UjU3d0NVazd4TERWcElNVXhQczhibHRHZm40UVVMWE9IWFM0?=
 =?utf-8?B?eVN2aHdxYVRZZENQczZIanhRdDYwM2pMU29FQ21iS1ljYmc0ZGVSWWladnNs?=
 =?utf-8?B?QWloZEppS3ZBeDdVMmIvRUxnNGFzOFp6aXhZdWx4Qyt0MERwRWFwZDZvdVlR?=
 =?utf-8?B?OTJMTjd1MjBFcjlrOFhtU3lqeUpWTmcvV25QdXNzNmFPRjRxa1N3N0ZlZXhy?=
 =?utf-8?B?KzlKQVJHMENkYU9VQzc0Q0pjU1kwN0s5aVpUeHJodGRLaXFZZ0RtTVl4dzBk?=
 =?utf-8?B?cUF2THJINzJveFBSeUUxWjUrbGRjam1DMi95Rjdqb3VyTThrOG9LdmhiQWFU?=
 =?utf-8?B?NENaV1ZoY2ZLOVI4R1ZtMWt6ODU1Q0F2ZUFaem01ZWo0ZE4yQVByYWgzd2p4?=
 =?utf-8?B?RHhSU21Lcjd4c08rckh2d2NLdVpYUVQ5ZVFwVTRBaWV4YlVGRVZzaDhQTTlQ?=
 =?utf-8?B?NmxoTWxTVzhiRkt0S3Z6czlNZ2lXQkFybE55c1BQYU56bENTdTdlcGdHZ3FW?=
 =?utf-8?B?L09YSzFxOFZSZ2ErUzRFcStQc1dnMEhYK3llZkNYUzRZYXlMZ1djZ0JPUkxZ?=
 =?utf-8?B?S2ppS1lBaUlySkQ3cStZT29wMVNGSVZhaFRNZGw4OTBZaktiY0tURStDbHBt?=
 =?utf-8?B?U29rZUptT21uVkU3S0FUVGwybXU4WVNsTEpJNWlzMTFYdTQ4L2JrRDBGRU5B?=
 =?utf-8?B?ZlVvYUdxOUU3Wm1POStmOEVWK29RRHVZVTV4YURMbmRseU5BaVpjSDAvSENU?=
 =?utf-8?B?cVplSkpHcFVnT3d4QUJFSlR4NmJ0VnBZVHAva3FRLzAxdWEzQjJ3YlE1Smc1?=
 =?utf-8?B?ZHdEODZIdVh5SWJBQzIvUm95VVRJQUp3eU9uQUlmbG9qN2hxZ0VNOW0xbFp5?=
 =?utf-8?B?ckJFT1lBeEFzaDdXQkFXSGVVUUZFRVlyRGRud0RQMjE1L08rQ1kxbHk1S0ti?=
 =?utf-8?B?UkhpRzlVaWtmMXVBclNwQVpkVzNNd3RuaExhYWhXbVdRdTZMRHZPbXAxMkhB?=
 =?utf-8?B?cklTV1RnZ2Roa2FWMjZmbTR5Wit0TkpFUE01YTJRYzdhR1JaTFB5TkgycEpL?=
 =?utf-8?B?Q2hpUUtQSy85cThDNTFybmg4OTFWOWhSUXVyb29NMmV6VVpDOEg5czJhNmxl?=
 =?utf-8?B?V2tUZzNNOUovOHgrUXZiZUhRNnNFMU40UmdEZHBZTUZxUEVlUFlTT2RGeXd1?=
 =?utf-8?B?M2Y4RzJOMGVHYkM1a3hLMFFmdXQrSC9JUGtLeDJUb0NZTHRRUlVORjk2Mjlm?=
 =?utf-8?B?cWVoOHp3eHpSTnI0WXJSemtuSGluM2MvSlArS0Fsbm1RMlA0WVh1K2txK2dr?=
 =?utf-8?B?Y3RhSmtYZzluTjE4SnArYWh3YjViSElkOG92ckNsVWhqREZjcXB5VHhuaWxJ?=
 =?utf-8?Q?sLvVmUq3DJQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWt6RHk4MDhYRnhGQ25KbGxGaHIvL0NrNFQvNEZhRmdhRTlORTJFV2haLytz?=
 =?utf-8?B?U3NyMmpGcThma1cvaG1yd21ZYWtLMXp6bkJUSGRLdEVlTjVMMmlBc3phazFj?=
 =?utf-8?B?K0o5cGFRa1NZRFZGWWlkQ082Q3BHVzhpcEorS3g1V1M0anVodzJnbkh3RXVm?=
 =?utf-8?B?SE5GanJEQmNHQ0FoQlNEYjVESDVJUkhacG1UU05US25tMkcwaWZtR204eFk2?=
 =?utf-8?B?Vlg3dUsxVThhUHZEUjFBUzFiTTF4Y3JaTXZBUUgwU2ZMU1hsQ0dJZWpUU1ZF?=
 =?utf-8?B?eGdrQTNlTEw2S3pWY0k2ZXNpMVQyai9rbWlyTFllbVJWQVdXWXRBL3BlUkVq?=
 =?utf-8?B?ZFpOK0FOY0Mzb2xsTXYvR1cvaU9jMDJTUjVZME0zNmVjQ1dkUGlHeE1vMlpo?=
 =?utf-8?B?VG5DS0hMOE9JTEhFTDlOMnhlWW1aUGhBR0N6TXNadjBkdCtSTFN5YlhKSHFP?=
 =?utf-8?B?bEJ6K1RXaHZQNW5rakN2ZXo4TVVtU0J0WUJuMHRvN1dzQUVsWmNhWHJZNUlr?=
 =?utf-8?B?dlZ6QjhyVHBhN1J5UWlaSnpmUHpqaUdKaVNGRitoV1NhcDRVK2lDNkhIazd0?=
 =?utf-8?B?d1JjZnlkVktkRkhDL0pDN21pSFhUMTNRY2lTODhhcEdwM3BtVjZwSUdyYmJG?=
 =?utf-8?B?UkV5YSs4RVR6TWNnYUlaVDBkVzhkdWhTampIdGdYeGNTZ2FRUVoycUlPYWJ5?=
 =?utf-8?B?cU51SjRaWGU2N21yay96Y2ZZS3N6RzR4cWo2SHIyMWJzcSt0dnpvL0JFaXls?=
 =?utf-8?B?a1dEb1A1azlFR2s1dS9oblpWTVlYRjJQY3Qvc3gwS1NZVURGRXlIbEhpb2dQ?=
 =?utf-8?B?Q25NV09wdEFUcVlDYml3U0N2R3F0eUZxYlQ4MFNiU203RUUvTW54R2VpN0FF?=
 =?utf-8?B?L1N1eXh0ZzlJSkp3UGx0SHp3dHpGZFIvdEpLTStKVWlqY0piUnVuYWU1djJl?=
 =?utf-8?B?cHVJTDZRZEhVU1RxMmtKVmllQUdqU3FuWUhDeS85S0dzWVE2OTQ1RlZsN2Q5?=
 =?utf-8?B?QnAyL09zS0xkenFibnF5RGRpakN4bXJvTlk1TjdwTVhQWUxYeUlaT20rUXlM?=
 =?utf-8?B?dEt4VEp3RGlpNzJEejdXY2wzZFB1S3Zvc2VTeW0xNHlkQjkwaHhCS1JlbWcw?=
 =?utf-8?B?amJUQy95OSs0VDZuZU9tc0lVOFdIclpHUjhiY0cxa0VVbDlEM3VqNm5DQXFT?=
 =?utf-8?B?MUF2WGN6NUJqSkR6K1JsTUlxK3MzUG04WkZKMmcvMTRUOUMvTU1laGJNSTUv?=
 =?utf-8?B?ZWxjR2ZoT0FmVlN6bW1LNUlaL2xKdGJJNDB6WjdBeDBGU0ZIbnlYZlpNZWN5?=
 =?utf-8?B?eUo1aG8zVVBLcS8wK0dWZThoMU5uQndMaHV4MW0xa0NHSDVNT09HNDdtTGRx?=
 =?utf-8?B?UGI2NUozN0p1VEkrTHRlVUpoQWlqaVpscmpuL3Uya1RoQ1dYU0pPRUJWKzhU?=
 =?utf-8?B?TGNOTmgzMVErcDBOUTVPRDhaTWxaaXRoL1NZbnZFSUhmZ3daNXdZYW5zWlAy?=
 =?utf-8?B?ZGZxaitueGYvMFFXU2JleDVWVlA1disydDFNdXRFdTE0SFZ2aXZEVWc5VUhp?=
 =?utf-8?B?eklTSmVuSFlXRkN3SExicUxkWHJjcjU3c0l5V2d1Ty8rODhhdkZNWHM5TFky?=
 =?utf-8?B?ck1JaGtNc091MnViM25wZUM1dUdoUCs0ZEdzSEp2MVI5RlNTK3Y4SCtNTkF2?=
 =?utf-8?B?ZTRGd2o2NUJsdU5SWmFja3lJZGN5WUg1T0ZPZUo3cnZCcU5SSm11YTRla0Uv?=
 =?utf-8?B?T3JwT0xkYWt5ZUxCUUdMZXhDenE3azIyYUlONU8vZlJ1ajFWQ29WcUNiSEVx?=
 =?utf-8?B?SXhRc0NqQzRnSlF3QmNjZUNYWnQ4YXVGYVN3SVFYMyt0REE0MXpTYzkxakZW?=
 =?utf-8?B?ektSMlRkZW1pelhINDhZLzVGZFZoZzJDWmNuUkVsZUlYSGpvM1NZSndiZnda?=
 =?utf-8?B?Y28vbE5LVUhXV005TDhIQVliWWVkVTN3ZVVsemRQaXJxNERacWhvNWhQZnZF?=
 =?utf-8?B?YmdsY3FYeXNpL1RhTCtabXVrQkUzUFZ0UWRrZy9kS1haRCtub1RhTW1Gc0cr?=
 =?utf-8?B?d3dxUTBiMFZ2NzFRQ0I2ZHkzMGFtWlEyVHZ5SGEzbEZlcm5kbC9uOEJKUjVI?=
 =?utf-8?B?aVRML1dBSDFmWVRTdmJjTmp5ZEZkWFNzWlltdmRCVDRoU3ZVd01YZldrRUtH?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bhYFMha2rNGgIIn25iQtPE0sY7D8n91m4eZBOVcr1wIt5YskLdt/ZtvjYahepYMrj7xmZ7wglCOEFbCeBeH68dVqRnRCbYXjp6xn4y3KT+wYslKE7/OBvIfD5xKWTgUl38O/J3ggIC+7ss8PsZ3Aq9dJjUSF2b8eQQgY7kGRbsYmNUPkcCzRaXV85r0fKEBvWiDfpTDFsi1schUJv1WWhEWMmAIIk7MkjYxPTkr5HoUEDUGqOfd8/f7aOsuT8ep8M1w56el8hvLzx+zMQXEvseWEsRKyMo5+Q49ud4dyELdHLNBhclHK830BlPnMcM/813D/1w1BB8RkBal6Oz/zfGOiA1dcUOHyHSDd4jAuU0zRuiiNkoq/xeXRU9T1SAHgcwST4FwyLew1jjKaJJsJ4lMfL0KcfO43e4X4a/6tcJ/IqWsWFCgiZv+o0jit7t2CLBepjHY1DopZHUD+v1iwiExE0VrkouexIlqhcGa7W5ZZR+xmAv5YCQ3m9AkIhpAesjegZchEr8KMfZ9hIosEpShk3hiQq7PtpNEuR6xe/a16Yw8ijlMbgRNl5Mjr/NKAf8Isp/IspI/a9OtRbsH0hYsSISgzbNr81WTPHm69EBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c297ed5-42ef-4fda-256a-08dd988e8553
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 17:40:04.7829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR9wlPMPEaqK1TbzzDq2MAmSlAKENXdWzyz3qOSWfvf/8j5uweSpKb0lOv6XB0XVTJ9N/ctagDjH30etob1GGU8E59JRB2ytJrabLXbADIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210173
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE3NCBTYWx0ZWRfX5jHyBrU8JAsE
 mEqm71tGNLwZvkqLxX3Mcdk3j+yCRGdIvlg6aXhFJccZoqoAjF0a2B4YocuGMCpK3/umO1q2bK7
 kOqo8oidnidsxkFduqppxeOK3bc1MwhQm2AvHsKsYNOhqb/DgtSXVshKglfzgI3ChZyGUm5RoSC
 lJDz6+akpejf2Yf8shOLmLNa2vklSaddlurmbP0bV3qGBhbVj0O75wQJIbtje1iVVV8RcEsL74U
 DxKSxdNwMiORiMKPt2QdIGmYrA9ZWCFUJ35NzOCBGYJ6m1NmMasPmaC4pRS2v01rxYDfOhMIwf9
 0BoIDM9lpDdI7ChByaiThFc0v8WMHGZB/jQP8zENkr586nC+A4uhK9WVGjZv33Xs5VXC68Q1cEb
 bBfFyzKy5kqmoHzezn/TYYN91SUy9UbSfzPYjcLHl7I6N0xT8qrF/LYa28cBOB933C2e9gLb
X-Proofpoint-ORIG-GUID: cwyNRTG_uVxLUwHyUJateYYly5ZntHbU
X-Authority-Analysis: v=2.4 cv=GsFC+l1C c=1 sm=1 tr=0 ts=682e0ffa b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=7bIf-KEFHBV3whkoRREA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13207
X-Proofpoint-GUID: cwyNRTG_uVxLUwHyUJateYYly5ZntHbU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/20/2025 5:16 AM, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Steven Sistare <steven.sistare@oracle.com>
>> Subject: Re: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
>>
>> On 5/18/2025 11:25 PM, Duan, Zhenzhong wrote:
>>>> -----Original Message-----
>>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>> Subject: [PATCH V3 39/42] vfio/iommufd: reconstruct hwpt
>>>>
>>>> Save the hwpt_id in vmstate.  In realize, skip its allocation from
>>>> iommufd_cdev_attach -> iommufd_cdev_attach_container ->
>>>> iommufd_cdev_autodomains_get.
>>>>
>>>> Rebuild userland structures to hold hwpt_id by calling
>>>> iommufd_cdev_rebuild_hwpt at post load time.  This depends on hw_caps,
>> which
>>>> was restored by the post_load call to vfio_device_hiod_create_and_realize.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>> hw/vfio/cpr-iommufd.c      |  7 +++++++
>>>> hw/vfio/iommufd.c          | 24 ++++++++++++++++++++++--
>>>> hw/vfio/trace-events       |  1 +
>>>> hw/vfio/vfio-iommufd.h     |  3 +++
>>>> include/hw/vfio/vfio-cpr.h |  1 +
>>>> 5 files changed, 34 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>>>> index 24cdf10..6d3f4e0 100644
>>>> --- a/hw/vfio/cpr-iommufd.c
>>>> +++ b/hw/vfio/cpr-iommufd.c
>>>> @@ -110,6 +110,12 @@ static int vfio_device_post_load(void *opaque, int
>>>> version_id)
>>>>           error_report_err(err);
>>>>           return false;
>>>>       }
>>>> +    if (!vbasedev->mdev) {
>>>> +        VFIOIOMMUFDContainer *container = container_of(vbasedev-
>>> bcontainer,
>>>> +                                                       VFIOIOMMUFDContainer,
>>>> +                                                       bcontainer);
>>>> +        iommufd_cdev_rebuild_hwpt(vbasedev, container);
>>>> +    }
>>>>       return true;
>>>> }
>>>>
>>>> @@ -121,6 +127,7 @@ static const VMStateDescription vfio_device_vmstate
>> = {
>>>>       .needed = cpr_needed_for_reuse,
>>>>       .fields = (VMStateField[]) {
>>>>           VMSTATE_INT32(devid, VFIODevice),
>>>> +        VMSTATE_UINT32(cpr.hwpt_id, VFIODevice),
>>>>           VMSTATE_END_OF_LIST()
>>>>       }
>>>> };
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index d980684..ec79c83 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -318,6 +318,7 @@ static bool
>>>> iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, Error **errp)
>>>> static void iommufd_cdev_use_hwpt(VFIODevice *vbasedev, VFIOIOASHwpt
>>>> *hwpt)
>>>> {
>>>>       vbasedev->hwpt = hwpt;
>>>> +    vbasedev->cpr.hwpt_id = hwpt->hwpt_id;
>>>>       vbasedev->iommu_dirty_tracking = iommufd_hwpt_dirty_tracking(hwpt);
>>>>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>>> }
>>>> @@ -373,6 +374,23 @@ static bool iommufd_cdev_make_hwpt(VFIODevice
>>>> *vbasedev,
>>>>       return true;
>>>> }
>>>>
>>>> +void iommufd_cdev_rebuild_hwpt(VFIODevice *vbasedev,
>>>> +                               VFIOIOMMUFDContainer *container)
>>>> +{
>>>> +    VFIOIOASHwpt *hwpt;
>>>> +    int hwpt_id = vbasedev->cpr.hwpt_id;
>>>> +
>>>> +    trace_iommufd_cdev_rebuild_hwpt(container->be->fd, hwpt_id);
>>>> +
>>>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>>>> +        if (hwpt->hwpt_id == hwpt_id) {
>>>> +            iommufd_cdev_use_hwpt(vbasedev, hwpt);
>>>> +            return;
>>>> +        }
>>>> +    }
>>>> +    iommufd_cdev_make_hwpt(vbasedev, container, hwpt_id, false, NULL);
>>>> +}
>>>> +
>>>> static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>>>                                            VFIOIOMMUFDContainer *container,
>>>>                                            Error **errp)
>>>> @@ -567,7 +585,8 @@ static bool iommufd_cdev_attach(const char *name,
>>>> VFIODevice *vbasedev,
>>>>               vbasedev->iommufd != container->be) {
>>>>               continue;
>>>>           }
>>>> -        if (!iommufd_cdev_attach_container(vbasedev, container, &err)) {
>>>> +        if (!vbasedev->cpr.reused &&
>>>> +            !iommufd_cdev_attach_container(vbasedev, container, &err)) {
>>>>               const char *msg = error_get_pretty(err);
>>>>
>>>>               trace_iommufd_cdev_fail_attach_existing_container(msg);
>>>> @@ -605,7 +624,8 @@ skip_ioas_alloc:
>>>>       bcontainer = &container->bcontainer;
>>>>       vfio_address_space_insert(space, bcontainer);
>>>>
>>>> -    if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
>>>> +    if (!vbasedev->cpr.reused &&
>>>> +        !iommufd_cdev_attach_container(vbasedev, container, errp)) {
>>>
>>> All container attaching is bypassed in new qemu. I have a concern that new
>> qemu doesn't generate same containers as old qemu if there are more than one
>> container in old qemu.
>>> Then there can be devices attached to wrong container or attaching fail in post
>> load.
>>
>> Yes, this relates to our discussion in patch 35.  Please explain, how can a single
>> iommufd backend have multiple containers?
> 
> Similar as legacy container, there can be multiple containers in one address space.
> If existing mapping in one container conflicts with new device's reserved region,
> Attaching to that container will fail and a new container need to be created to accept new device's reserved region.
> 
> Maybe you need to do same thing just like you do for legacy container, e.g., saving  ioas_id just like you saving container->fd, then checking existing ioas_id and restore iommufd container based on that.

Thanks, now I understand.
iommufd_cdev_attach calls
   iommufd_cdev_attach_container -> iommufd_cdev_attach_ioas_hwpt(container->ioas_id)
until it finds a container that works, or creates a new container with a new ioas_id.

To fix, I need to record each device's ioas_id in cpr-state, so it is available when
vfio_realize -> iommufd_cdev_attach is called.  Saving it in vmstate as I do now and
recovering it in a post_load handler is too late.

- Steve


