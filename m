Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B0BC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcas-0007tA-WC; Thu, 15 May 2025 13:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFcar-0007st-Nd
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:42:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1uFcap-00045l-Cg
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:42:05 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FF1qYm000516;
 Thu, 15 May 2025 17:41:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=uwrf/iz01Y+IG/Wi6KZaX12FhmJy0MBIJmvSC1ASm4s=; b=
 CkzdODrf58LsA/CElI5D8kmcKjC3/qc1s3JYodzFDUjepXO1JSL9Y68HZr+nHyEb
 m/qMOkvLcKg3hQIXZSnH9cGCVAgB5xhQYcT9b5rJqjX0fL/cUiTe1j5BcJgd12R3
 RZiwcV8+V69Gh+Wt5V/BSJzTeSIRKERmiZCI8UEE+gfdfCs9sXInZ376TK5qw9OE
 LpkmEulcPkDI6rQi5reHK0sdCPx7a+MeXkCMpY+WvYf9nPRXTgtet7zWeD7KJe8b
 r7fE3dFfOFr6MvuCrpvNM4g1GBbR1B0pSWA+H5ME94duhp6rrrxHzfS5cVvXj1S8
 Hjm0pMnIa87viF6mUlRuZg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchvptu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 17:41:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54FGo7t7026130; Thu, 15 May 2025 17:41:56 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013075.outbound.protection.outlook.com [40.93.6.75])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mbt9nfmr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 17:41:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BH2JqeUfnFkufGzeP/rAEwmj7SwwbvohEbM/f7vOJ5u3ZL9fzEDhS02juSc40feetrbizUO6JywVyE6TYC4IHYZ1gKVAqyWDQQcE4TALAbrq+vp2PvhLMfQ1cXp5xHZZa1kMfcskSwOEGHqx4vfev+P8ZwwwiqAXHL6iBKLeU8UwQDAVNTfdXU/q6Upes4hJ+d59n2ohuu3J2TJa4lWWju3H95P5wNegjs7Qeu8KRXZeFwLOVtKxyOApIQwFb5vRMlbUuz8qd4CEaoAIShK7WX6fwyWbSeL+BZ4GtUHdLnMhSmiRKsIk6na+IG7TejTpjHZBwMD3XjzfERrjiGUHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwrf/iz01Y+IG/Wi6KZaX12FhmJy0MBIJmvSC1ASm4s=;
 b=atzekSwNHkUperIA8MPaEq0WPyZR+XbrLn9W7SdKG3TSzqibVj/ONeusPsnj0DpaIiq3JE6dq3Vg8qXRoQXlUy22mqMLKgIl/Iy/7gl2/MbPCjY16FQ+GDbPo9LV+ZtHEBYYf41C9WgcT8rwFA6OO7jbluDgPdkHVaN0ocWb2Mcizg588tqiR5VenMxr+brABbl++73WafyKh7HrOzqY1YFYUgPwnbiHw0HwJnjno8h1HsDFLtM2KmkoZ3kzfpZb23Rb2vYKi0M2YvSW7nBMAbTYeVDz9HSnrbrDgHMVYrsL1YD+WY7KGNVnI7ZdqM4FoTIlE5fiFxwMmoAyhDwTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwrf/iz01Y+IG/Wi6KZaX12FhmJy0MBIJmvSC1ASm4s=;
 b=YNWd7BCrgTGKK6cikuuPchdGiy1zhx/c4jlTJI9YsoQoYiuUIY2IaJTn0I/b1rCrBxfl56nzm3d2N03UxA+nuOL5zOtpvdamSqPUlhgjxPRqoO+Zm58TO9ZyA1Pt20mxgxaWLBi1yGYt8xm5WMPQzNb7WwDfI1cmMZzrBNtEQho=
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d) by PH0PR10MB4726.namprd10.prod.outlook.com
 (2603:10b6:510:3d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 15 May
 2025 17:41:49 +0000
Received: from DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd]) by DS4PPF18D5A7206.namprd10.prod.outlook.com
 ([fe80::f77e:d409:2c52:ecd%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 17:41:49 +0000
Message-ID: <16aee564-c2a5-418d-a865-935519c870fa@oracle.com>
Date: Thu, 15 May 2025 10:41:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Move memory listener register to vhost_vdpa_init
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, qemu-devel@nongnu.org,
 peterx@redhat.com, jasowang@redhat.com, lvivier@redhat.com,
 dtatulea@nvidia.com, leiyang@redhat.com, parav@mellanox.com,
 sgarzare@redhat.com, lingshan.zhu@intel.com, boris.ostrovsky@oracle.com
References: <20250507184647.15580-1-jonah.palmer@oracle.com>
 <CAJaqyWcOaGKaCeT1sifCE_sau1Ac2g=F62TkD=arntQ8ka4aDQ@mail.gmail.com>
 <8c465eb3-2db9-47ab-b949-e19a176a5fde@oracle.com>
 <20250515014242-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250515014242-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To DS4PPF18D5A7206.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d0d)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF18D5A7206:EE_|PH0PR10MB4726:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fae4b2d-58aa-4548-5fba-08dd93d7c4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3VadWY1WHVLVGRVcjMwczVKWThuOTZyUFdlYVZ6MTVKckRuaXoxN3RqN0Rv?=
 =?utf-8?B?UW8xWkpYais2L2svSnFSSm91b3dURUxKMzUxdDdWKy9iWHExYWROTmRGQlpX?=
 =?utf-8?B?MzlndHJBRkplcHNtajY2YTVRd1hoWWpzRlhGVWEyYk94VmxIbFNaMlhkaHcv?=
 =?utf-8?B?SktCNHZPaWIvRUdyNE94QzA2Y0lkdVdaVUVXamp0Y2I1a20yNytjNklFZ3ZO?=
 =?utf-8?B?by9CTzdSYlpkZUhSZmxDdmdXQ2lLTXoyUysvQnJJYmt2WFhoWXRnVmJvMGRq?=
 =?utf-8?B?SVRlVzg4ODQ3U2loOFQ2UHZqUnhYRkRDczYySHEzTk1TNGpOM1VWVW9vMkJ3?=
 =?utf-8?B?dk9iYzd1WmJhaHpGK2hhM0EvWDNaK0NpMy9iME1tSEdNYlRNVEhjQ2lyRGVP?=
 =?utf-8?B?dUFXUHNxcnp1Q2tLWVJ1T1RadytiUThpeTN0cSs3TmdyemsvUCtZQmp4bTc5?=
 =?utf-8?B?MU1pNG85bnQ3MjRkVUdZYjNUanZQbllnVGlaaGNCNTAxL3FnUXRHMGZINGFO?=
 =?utf-8?B?TkpkRXNKMzZwcGh1TWZ4REVESmRpVHZBS2o1WmcrV1dsbEFyMGZNc0xCYU1S?=
 =?utf-8?B?UmhRMVkrajZhajI1ZTVrYXJzQXVPK3NoNmRrakt4alFWdk5JdzJRa2x2RmpY?=
 =?utf-8?B?UG5GdHpXTzcwbFRnRmljNzJwM3pZUEtwbUJ6OXlhdS9BNDZBbXlzbjc0NGRK?=
 =?utf-8?B?alk3NE5tY25PMHVxbzVidkVXMzVzMEJxUTUvZWRRSEtjdWNhdVlRRHB1ejlV?=
 =?utf-8?B?eWVWS24yUEtaOXBlQzcyV0w2OUx3UzhyVGJ2TE5hOWZXNTk0VUpsSSs2c0VC?=
 =?utf-8?B?TkxvVG5Xb2x4T0NDTGlhYkxobDlFZ0wzYkxvY1kwcStwOGc4T3NIWXhKVm1x?=
 =?utf-8?B?cmFKVHFZN0VGdE1PS2g4OFh5UTJzWm9zSWpVeHhYYVNmNWwyTmdkV0hHckh3?=
 =?utf-8?B?ZVRaa2ptZHQwZVI4SnpEL3ByNmpaY3dLSzA3Vnd2UzZ2Q2ZEQ3pSTk5oSVpC?=
 =?utf-8?B?NmdLTHJuZXlhS2xyRkhiSWowMjF1djRoUmVNNlNkcE1NMjB2ZUZLYUtXcFBl?=
 =?utf-8?B?eGFaZHRXamdhYnh6N3E4dVkrZTBCSmpDVHNrSitEblcvdjZtK3JFT0VDRE9H?=
 =?utf-8?B?bHdWaDRNNHVBL3NXOEx6NUZ5U1hBaGxsTUowWitvQXBxSEFGUm00ckdWc1cy?=
 =?utf-8?B?UnQ3V201ZEZCQTFmVVFSdTNmeTlFQ0c1SlhWdnlhUkJjUmpTUk5GaFdsVE8y?=
 =?utf-8?B?YmVCVXNjL3RteCtDWTMrbmVicE1CWDNLRXdRVXB4THd0cEROVnUzbkJZMUVi?=
 =?utf-8?B?TTR6M1h4Z01KQWRrUlVSb0NtWklYV21hTTBtZjVDQm05RWdIeTJ4emVmRWRh?=
 =?utf-8?B?UlFEcTNqQlVFR1h5NE1BSnhNcFB0cnJsUGpKZUFIbmFWN1RmRFNGUkVjYXJ1?=
 =?utf-8?B?WUhIRUpSdkJPUlQ1dzBXOGQ5V2ZJdUJLcXRTSU9BOENPNUx0ZGRyWTArZmwv?=
 =?utf-8?B?bjNzT1l5TVBoTHY3Rm9aVTBWa3M3SmZCamxpR2c0d3A0aVU4dndMMStEckh6?=
 =?utf-8?B?dmZRTkU3VGZnaDJXY3FGRnVaczlKZ3ZJeWlEMFd3aGcrRXJjN0JvZjdIRkFN?=
 =?utf-8?B?QnpLV0VNVTkxYW40aFFwL2Zob1QxK0lwZG5JajNaQVQ4OWZHaWFSckV3am1V?=
 =?utf-8?B?UGFKSTFJKzgzZWhiQWg5eE9oaHhZbXBNb3hyYmhSM1JPWms0c3liLzRGc3NB?=
 =?utf-8?B?NWZDbER5d0gwak5RQ1JzSHloTEpvUFRsN1ZESkkwcTc4MVdFc2g4RzRPZ2tP?=
 =?utf-8?B?bUh5akhNQXpGbW9xOU1wTmFvVEpGaHpGY21MVVJsQzdQbDFXY203VFgvNHg0?=
 =?utf-8?B?NXVxdVdjbHd5Ui84bCtsNFhtSTFyV1J1a1Z2YkhLVG5qdGdwVG9FZGdha20y?=
 =?utf-8?Q?pwE8v20iQQQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF18D5A7206.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1aSk5vaVdpeXFPNDZCYnpSZUMrbU0vMUZKaXZkUEMrM3NlUS90VVhIMjBZ?=
 =?utf-8?B?Vk5FSkRtZ056RmkrMjlvL3VGblpxUHNZYityd21ZOFk5ZXNpWUxTeWduZXp6?=
 =?utf-8?B?R3JvZWViR3RzY1dSeEJTNmdvNG16NGMwTlpnZnpkZTYwQnZpcnZUeUdMaHEx?=
 =?utf-8?B?cUdvcnYyWCtQN25mdUdySjYxTnNuRWFPSDF0WElNRVF1VWdIYURXQy9oYjli?=
 =?utf-8?B?SkUvVDVLZ1R0a01MQk5mN1dZQTFycHkzMm8yQmU3cTBheHNzMDhLVjAzZ1FZ?=
 =?utf-8?B?NExXdlVaZlpkcE1aYlY4dncxN2RmbTFWRmNNbUdBblNsaTFKTFBWeHM5bkdr?=
 =?utf-8?B?S1lDV2hxcE85M3lFWkx4Q2FXQUJSaFExSmI5K0NHSFFrT0o1am9DNlJNekZy?=
 =?utf-8?B?RDRGZEJGUExybkw3V3FKTjgreFpVWnJ6VEExWjQzMUVxRzlSWTN5RVE1NUdJ?=
 =?utf-8?B?ODdtZHVJNlVZVE9WMEhqZlM3VU1yN1VoeGhEd0ZUUFhJMlFNSXBkUWJQelJZ?=
 =?utf-8?B?REJkZC9WVE9DRkNTUE03bC9tMU1tY3RTQnNlTGF6cExpK0l3cmQvQW5TRFUw?=
 =?utf-8?B?TFZ3Q0J5RjRFTHcyWUc2cTltME9wQlFITlpsYThIMjlrMmVrdThQZHkxc24y?=
 =?utf-8?B?amZWWTlZZTBFQjdPQUZlZ1M2aFlzeE1NWkR3NEhsVUFzc1REcmp6SmVOOEE5?=
 =?utf-8?B?NThlWnR4azRRckVvQVBzT2RncUd5bFhQRWlNK1VrcE43bVVCOUUzR1gzRXJM?=
 =?utf-8?B?TTZCZTZrQzhoUy9KZEoySmtLV01BSUZ0NDRTaTl3c29lTkdqVWVBODg0MEs0?=
 =?utf-8?B?SEthN3J3YXhtaFFhb05nWjZjTDl6ZTFhMjdWaERoTVZiWnZ0bE9BTE9ZYXY1?=
 =?utf-8?B?SlZERG5BR1FtMElCbjhoeVlndmlJc2NQcE9sV1B0ejFMOUFRenFDZ0oySmph?=
 =?utf-8?B?c3dETk5KZ3RMR0hBM0ZQNy9zWGNKS2c3aUZoRUNSN0RwY0dzTkhJUW5tTnJw?=
 =?utf-8?B?cnQvOGtMMWRnRm1xQ1h1d3RCNC9NRzNDY1ZhOVlOMXFYbEZjanUrTjV4Y3dt?=
 =?utf-8?B?TVlpc0ZFVi91N1JRbi9BK1V5S2hTY2E2L20vSktIZmYrclZKMzZXQ3M0T3BC?=
 =?utf-8?B?VWpJYTRNZ1FqTHhqZmRsajZVeEtaRHk0ODR0UWpmZGFDTWd5UW13eWU0bS9I?=
 =?utf-8?B?K1BDWW9PNHZBRVVFSnRsZm1lYW9BTll4eFZ5ODhyR3FXM1BoaG52ZjNFT3RC?=
 =?utf-8?B?T25SWXhaYjF4STZYWm1ySEZvcE5VdERtOWZSS2xaVWJBd3V6cWFYa0NQVlJM?=
 =?utf-8?B?bGFFNkhhYlJ0NkZWT0FiL2M2WWpONytXRXJFdWhZQWFBcm9MdDFIcWJWQzJ2?=
 =?utf-8?B?K0hZNFErWlcrTWpad2grYXhLL0ZRWWVKcHY2TWxxRzlkNy9WZjFTU2Z6clI3?=
 =?utf-8?B?M2hpbDZzUFNxU0V5b01XNzR4SXFRa2dPVkRFNVJuanowUExjaERXREdKNHFO?=
 =?utf-8?B?QW5jNlJnNFpsNkpjaDJWOG9Nemt4TGIzUzkwSjkzb1A5eXc1MC9wT00ydVNP?=
 =?utf-8?B?QXArbEpJQmNnSVFoaWpFbnIyMWh4WFAwVThJZjNZYktyamExWXNiN0VUVk1B?=
 =?utf-8?B?NjI0aTUyNXdkZVkzN28rN3FGNWdWb2g2OEJraGw0dFJlMWJUOGxlajQvZlJM?=
 =?utf-8?B?eFZYSWNnTDlBekNZU2VIQlVyTTVZUTJPaHR2OGlscVh4aEc2M0R3UnRJbzg4?=
 =?utf-8?B?VVExQVFnci9QMzRVRHVOK1RnMTh0ck84d2J5WDR4OUVoMHFSRGkvRXdKaUFV?=
 =?utf-8?B?OFgrZTRpaDYyR25WNlBJVE5DMkVQalpVTzBSMTRQZDFRcE84VU9ydk9pUnd0?=
 =?utf-8?B?ZjdIOVE2L0tXNkpYMTBNdEtOVis0MlJoWDNSRW9sWExEU3VnaWlWQzVYNXdp?=
 =?utf-8?B?TzNPNzI0WWQyeXFnVU8yR29ObGhpelB0NUlJMGFMOUdmOTlqV29rVWRRWmtG?=
 =?utf-8?B?eFJCL1ZkZUhBWitOcm5GSzRrOE9jRk1lamNUQkJBZGJWL2l5emdEM0tuekJ2?=
 =?utf-8?B?SHdkbENwaXZlR3VaK1czcklyV3dFbXg0V09xbEluRzZmNk1rMlV2a0xWSlRw?=
 =?utf-8?Q?JAgj26GupiAP+7xoKRrJ7wxjp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e/9oljXvXpQlII9HeV1BLO+Cf1L9i1rVLRugb3sCPUyd3ST1BYJrAjmQEGj3f8gpBwZX2545GAwciTdiWYg/+AUK+MvG7jk994JRJMFWNR080Iis8/5AwpWuiHomZF1F33vRbp8gOrn6oa0Qv1yKqzWdxHqhDVolWAPltQurle9+B0snubwv8+hcF/CFhEWC+hzn3KyX+SOeam0aBSYyi40GglyllCZFjV2T71rspVspEtsEkZpccre9NDAuZeDkdxPfs+Gz+AefaAEctRCQfhif6K7Xfb8h/E0P3a/nHp0jANqK8n6oG/0M0Q+TTdy6BkfIygWiKiFbEHDImVnA8punZQMoj1tEtCWxLwJuFFKsr9JbsZ8wSMLbkk9Zpdt2Dabwg7BOZZ7tUvi0xFpscTGj4rLZeUOlyX40uZC05RD2Kyg9JAbUUOpgVyPrbGNAuiE5uBgTFG1eRqUTie8k2kU5Rb8X1XLeE9kZ70daU17aRdVMlBXyZHgYt+4eeoCZGYbZ8Cvos+Weh9LkHJykpc7tH7RpXdjaAt41RElGNhP6XdPFlJZEUDliwgycpDB1eiNkwAl/bwPWRBFr1bkEftSWu5ApYRo8w68cUa6jXis=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fae4b2d-58aa-4548-5fba-08dd93d7c4f6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF18D5A7206.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 17:41:49.0485 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEMsUHe1roFpenq65qUsX0Ja5DNba5EedTHRR+0CKyL2Xl8v/g22dunf3hZWTf6AH9g3DIc+u8gjiE0Ha4NBDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150174
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE3NCBTYWx0ZWRfX7H9TR8kX6Def
 NGYSFp2FgcF48/3ubVoQHPqZjitzWs4eR1XT68LolUfS72QP07gsWvVRlnGxn8N5s+jpCPPw9fw
 wmeCFqJvwcTHH0oTwXWhIAZ7NSiTeUd1towpsLvcD5NW5WRWJDJZL9ovgT+sj3GN0bJjmP0Nctj
 zDAb/AXA8wscfciF47hE+fcARZePOLz0dvL0S+WE3vZtLI5Ala+XVISsNSvi06RlQ2FLH++BKvg
 EqgF1Oq5kiETiL3gUmdcITfMoFX60yoSM/EnIQRPlWR9VHxQP75hzAcMSNbjCEfl5Lw7LFkxlaW
 jRB4w1m892Vdz7eYbbc+HvSKQjHLYK5R9nt17NT2mq2AGuoymXlqKLLnNpRrfp9i53e0TkosfBG
 6u5/eXPHZkMMX4Q82/WxImOCCIiN7+Pv6q/68kiepxjb1CHlIzBKgVt4oI4sK/WhTZstdP9U
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=68262766 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=mDV3o1hIAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=YRlnpgC82K1c-Zono_oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5WABlXvFAscA:10 a=n0c7R5xxTHgA:10 cc=ntf awl=host:14694
X-Proofpoint-ORIG-GUID: bGGpsrEB3PWd8qOGV6huhxDUkwVDuvjQ
X-Proofpoint-GUID: bGGpsrEB3PWd8qOGV6huhxDUkwVDuvjQ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 5/14/2025 10:43 PM, Michael S. Tsirkin wrote:
> On Wed, May 14, 2025 at 05:17:15PM -0700, Si-Wei Liu wrote:
>> Hi Eugenio,
>>
>> On 5/14/2025 8:49 AM, Eugenio Perez Martin wrote:
>>> On Wed, May 7, 2025 at 8:47 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>> Current memory operations like pinning may take a lot of time at the
>>>> destination.  Currently they are done after the source of the migration is
>>>> stopped, and before the workload is resumed at the destination.  This is a
>>>> period where neigher traffic can flow, nor the VM workload can continue
>>>> (downtime).
>>>>
>>>> We can do better as we know the memory layout of the guest RAM at the
>>>> destination from the moment that all devices are initializaed.  So
>>>> moving that operation allows QEMU to communicate the kernel the maps
>>>> while the workload is still running in the source, so Linux can start
>>>> mapping them.
>>>>
>>>> As a small drawback, there is a time in the initialization where QEMU
>>>> cannot respond to QMP etc.  By some testing, this time is about
>>>> 0.2seconds.  This may be further reduced (or increased) depending on the
>>>> vdpa driver and the platform hardware, and it is dominated by the cost
>>>> of memory pinning.
>>>>
>>>> This matches the time that we move out of the called downtime window.
>>>> The downtime is measured as checking the trace timestamp from the moment
>>>> the source suspend the device to the moment the destination starts the
>>>> eight and last virtqueue pair.  For a 39G guest, it goes from ~2.2526
>>>> secs to 2.0949.
>>>>
>>> Hi Jonah,
>>>
>>> Could you update this benchmark? I don't think it changed a lot but
>>> just to be as updated as possible.
>> Jonah is off this week and will be back until next Tuesday, but I recall he
>> indeed did some downtime test with VM with 128GB memory before taking off,
>> which shows obvious improvement from around 10 seconds to 5.8 seconds after
>> applying this series. Since this is related to update on the cover letter,
>> would it be okay for you and Jason to ack now and then proceed to Michael
>> for upcoming merge?
>>
>>> I think I cannot ack the series as I sent the first revision. Jason or
>>> Si-Wei, could you ack it?
>> Sure, I just give my R-b, this series look good to me. Hopefully Jason can
>> ack on his own.
>>
>> Thanks!
>> -Siwei
> I just sent a pull, next one in a week or two, so - no rush.
All right, should be good to wait. In any case you have to repost a v2 
PULL, hope this series can be piggy-back'ed as we did extensive tests 
about it. ;-)

-Siwei

>
>
>>> Thanks!
>>>
>>>> Future directions on top of this series may include to move more things ahead
>>>> of the migration time, like set DRIVER_OK or perform actual iterative migration
>>>> of virtio-net devices.
>>>>
>>>> Comments are welcome.
>>>>
>>>> This series is a different approach of series [1]. As the title does not
>>>> reflect the changes anymore, please refer to the previous one to know the
>>>> series history.
>>>>
>>>> This series is based on [2], it must be applied after it.
>>>>
>>>> [Jonah Palmer]
>>>> This series was rebased after [3] was pulled in, as [3] was a prerequisite
>>>> fix for this series.
>>>>
>>>> v4:
>>>> ---
>>>> * Add memory listener unregistration to vhost_vdpa_reset_device.
>>>> * Remove memory listener unregistration from vhost_vdpa_reset_status.
>>>>
>>>> v3:
>>>> ---
>>>> * Rebase
>>>>
>>>> v2:
>>>> ---
>>>> * Move the memory listener registration to vhost_vdpa_set_owner function.
>>>> * Move the iova_tree allocation to net_vhost_vdpa_init.
>>>>
>>>> v1 at https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02136.html.
>>>>
>>>> [1] https://patchwork.kernel.org/project/qemu-devel/cover/20231215172830.2540987-1-eperezma@redhat.com/
>>>> [2] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05910.html
>>>> [3] https://lore.kernel.org/qemu-devel/20250217144936.3589907-1-jonah.palmer@oracle.com/
>>>>
>>>> Jonah - note: I'll be on vacation from May 10-19. Will respond to
>>>>                 comments when I return.
>>>>
>>>> Eugenio Pérez (7):
>>>>     vdpa: check for iova tree initialized at net_client_start
>>>>     vdpa: reorder vhost_vdpa_set_backend_cap
>>>>     vdpa: set backend capabilities at vhost_vdpa_init
>>>>     vdpa: add listener_registered
>>>>     vdpa: reorder listener assignment
>>>>     vdpa: move iova_tree allocation to net_vhost_vdpa_init
>>>>     vdpa: move memory listener register to vhost_vdpa_init
>>>>
>>>>    hw/virtio/vhost-vdpa.c         | 107 +++++++++++++++++++++------------
>>>>    include/hw/virtio/vhost-vdpa.h |  22 ++++++-
>>>>    net/vhost-vdpa.c               |  34 +----------
>>>>    3 files changed, 93 insertions(+), 70 deletions(-)
>>>>
>>>> --
>>>> 2.43.5
>>>>


