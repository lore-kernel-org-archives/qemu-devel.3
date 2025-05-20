Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1E5C54E90
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 19:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHSo9-0007jg-Ak; Tue, 20 May 2025 15:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHSo7-0007jQ-AU
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:39:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHSo1-0004CG-6O
 for qemu-devel@nongnu.org; Tue, 20 May 2025 15:39:22 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KJMaJg009458;
 Tue, 20 May 2025 19:39:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=/q8svywIO48rmYQHJ+RXDUJ8E4qVQb9o7G11xvUtfJo=; b=
 c2opiF+5cA4ffp8aAFSqi5KAKFTGxhyFARN/SPTATbeRneBNSDzFNuFmxDIT9VUw
 J/24pSHaO+vubMQUGhgWh/Wv97ztCVa60sR2UYnRBAX4cVV0wLtwYreg0JDdSNbL
 hGbI6a8z/YzemDra3rYWJXuV7Q5Z76YjoF5peVbASwWlUfSDfr3GY937sAtOezSc
 NRv+At2OdvTggIa7i+E0zQQCHSuOv2FuTrmSvA4mqm2s/Rz2sTZ+HYxBdrc5kjL1
 ejXwzlRj0K03VpJgLU4llnWW2zYgRiMhCE8sCVkrphT7n99XzrtrJA5h4zn4wrRg
 RFRcl0QkFs3UDzSGHKYeSg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ry8fr4k8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 19:39:13 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KI4QxW030514; Tue, 20 May 2025 19:39:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwesyfm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 19:39:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hk7YbBW8E/YONutFWz+f5RH+9JR3ppOIpdF7V9VUPnqlRp9JG16He/Sljaf3B/BVx7OpTxCrFndIVetRD4eg8RFDyc7/TLjvC1+ct0py/SZ1lliiuc2fv5nJh/dUeqDyD0lHdh/3zAum8TlcFp1Ooebnc74wgv+uUK990cc5HCen3RjAjpE1yJt87EDk+LiuGHEQvCiww8TIlLa2CoYLBK7mZsF8haN2p2UG2XxHesth3aw4eJKDfoTwgxy8RyBdTu2bpu6HB3LY6nqjhHs0Mk1M1x/uMhaa8Lo1o8JrtftNYa/kN263ZnWJH4s3sJQkN5WwMH63KiB1if4GW1ohPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/q8svywIO48rmYQHJ+RXDUJ8E4qVQb9o7G11xvUtfJo=;
 b=GXfYdbTwWJn4FbIV41+UhGqKL70BdPuvgq62UfbhSk3kaHontzl09jth/3y/kXZ07jjHo/oLYGeJq4PmIhBGbX/neobL6k9NCkir5sY87/WuqwXGGL8FjmcOsBQdgaePEIabuNUsvOzzjfOu3GVNcYC7+eL9Od3Fv1IR8r4WeHoQhir4fgU15pCCZZr803vIvaFPdhuwCy/MyLaK3zmhsfR9xz33bIc5V8YGuhnEavMlcyW7tzghZxDkKUccQ7eKWnA0ooh4Cw4cl2610q6Pdy7AhCM9ESc4cXG/xJh4MumXPTIseALJ8TPsjYW4I3NfabKVMI0CBMuesa4YLBmBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q8svywIO48rmYQHJ+RXDUJ8E4qVQb9o7G11xvUtfJo=;
 b=Xpu/96Ixi8eyzRPOoP8njX5PMyfst9zKudXOFuqk24CpzX5w1mCCeGs288rTLob8bFHsRg8Zwq9NPKAnkok2w0Yv50lScU0H8UmDGevPRGLxahRf4TCWrv5rtJjo9Igt9X7i1Y129KqUB3YZWThNfLpwGFD4veWKu+3llBa+lOw=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA4PR10MB8279.namprd10.prod.outlook.com (2603:10b6:208:55f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 19:39:09 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 19:39:08 +0000
Message-ID: <1090e1fb-8ab1-41d4-8e9f-36559dd880cf@oracle.com>
Date: Tue, 20 May 2025 15:39:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
From: Steven Sistare <steven.sistare@oracle.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
 <SJ0PR11MB6744E4675DF4622F4414F5B49293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <bed13219-6c24-4f51-86d2-923909d5b18e@oracle.com>
Content-Language: en-US
In-Reply-To: <bed13219-6c24-4f51-86d2-923909d5b18e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::15) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA4PR10MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: 581cb383-8b76-4160-08ba-08dd97d5fd2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWpOb2VoYWNUUU1BRGkvbmROeEZLd1ZQTTR2L1NzRlhTdkI1U0VvUm9PZ0M4?=
 =?utf-8?B?YTltbHJzbVZTK3JPR3FLV1pKT05JVGNHNFBUV2gyV3daRFh6Rk9kd2hqNEJj?=
 =?utf-8?B?SjF0Q2lLK0M3NmhBemNydEtPTi9XMFBpbWhuejRmaFFZRU1SL2RodjhLazZt?=
 =?utf-8?B?eWZKREhlOWYySzRrb3lyMU44bVFScHp6dkllRHVINGs5bUFGd1Rjc1lTQmQr?=
 =?utf-8?B?UEtLaEYwUXVRekFBOGZ5WjNYMVhkRDRTRmQ1Z0k3S1FaNGhycXluU0dkVGhw?=
 =?utf-8?B?T25jMTQ4ZCthT2tReWJ3enhqNW9QMGtvVjlsTDEvNzRDRUk3MzRyc2xuWDNs?=
 =?utf-8?B?SmhYYjM2YUYxbTVlMXhUZFhlS3N1elBMWnZ6WWpvRjd3WXR3N0JIRWQ0cXZp?=
 =?utf-8?B?ODM2QWF4dmFJbGVWZG5SOTBIRUFZMUtvekFCVVZhOEE0TnhPQmRVaGl0aWVS?=
 =?utf-8?B?YjZSUmxrb0xYK0MyKzEvNXBXOVY0NjJoZ3VJSHI2NGRGVGZ5UmkvODRmQXIv?=
 =?utf-8?B?UEZOYjNFcE5WdXowZUNDTzdEWWlTUGJYZlhoYkoxQklsNHNLZFN6bWRBUjVi?=
 =?utf-8?B?TnJIZnVFODdTVGNhcXFyMTFORDVuN0hMMUNmcW84WjFveDd0eUhZNkJ5M1ZX?=
 =?utf-8?B?L0ptVVY1cE01SFhjWDJmbmFUSm1McDEvWGowcXVDZDVhd2Uyc0hpU3FKSnRP?=
 =?utf-8?B?UkJ2TnZrRmFubmlYNWc3WGJzOS9YOXF5WDF0RndXdEtZdU5FSmtWNjVudjNv?=
 =?utf-8?B?TDFSSUIyaTBCb3UvcnNmb24xendPcm1oOFc4V1ZPMm5XQVdrcjRGcEVxcUhs?=
 =?utf-8?B?Tzh5eStISzc5bi8rREU1cGVxN3NvN0h3YXF1RVgwOHl3QkswdGQ0dzZscEI1?=
 =?utf-8?B?elpmRXQ4YmdIVlg0Rkt2QnpncVVBbmd1SkRUZ2NJOThGUFF6Umd5WTkrelVr?=
 =?utf-8?B?d2VtY1J0dy9DTlFPQXdTRUc0N052QTZBYmwwZVNrdDljcmJjZmVVbG9pK3Fy?=
 =?utf-8?B?MURKbGs1WDhabEg1QlBXZGE4NnJuajlaOFkzMFdEalc0VlNKMUNTei9sUHNv?=
 =?utf-8?B?NmRBZUF1L0hONTN5Z2Vrekp0ZUVjb3JiWFRQVEhFb21wM0VOWDZNYktKaThx?=
 =?utf-8?B?dzRJTlh2TUpCd0FQM2xLM0lWUVYyTzJuUW01akhENGc0K3NPbWM1SnR6YzRU?=
 =?utf-8?B?RnRlODlndnNaVTlDbDB1ZEhZZ0RjSzdicWFVRXlhYWl5VFJSUytDRnJiREYy?=
 =?utf-8?B?dURNc0Q0TUhkTFY5bEFYbFBqTWNwODFjVVZuYjZsQ1F5SjZybTR4R1Blc3lR?=
 =?utf-8?B?NFJ5clZBTTRYZzNRVm8yZ1kzQ3F1b2pSS1Ryb3RrU2wva2RiS1lOQmZsSm5v?=
 =?utf-8?B?em9FUkl0RDMwVEpTWWYxaUJScmVzZ2h6aTF5bVJRdThiQUNqbVhWMVRuZ1hm?=
 =?utf-8?B?bitOYWtYdHBLRUhkeUZHKzZPQ214RURJYXBwNUpUUnpaN1c5VnlCNzhIdVlV?=
 =?utf-8?B?TDFBWVVOVVM0UGFvVjR0RU9jY1Z1WERnSVlSNkljeXZiQXdYbzRJeW1WdFZT?=
 =?utf-8?B?WXJOZytxL1NXNlltalFURHl2R2dYTlVkK0dGTzVtOC90TDE0YVN2TzRJQ1FE?=
 =?utf-8?B?T1BFa1FrYmtSVWpLVEhXNmduVlcreWYzRStnemVlcjRmUFRHMEQ0ZGpqWG4r?=
 =?utf-8?B?c3JxazJUZjU4SlBJaDNXanZYemc3U0VkamFjeEVCbnNvVytCTU9LZkxrYUhh?=
 =?utf-8?B?NlQxSDlpQ0NkTlFmdUlMZXgvUTQzNURJMnJtZXFNb21FdTlwenNXRjg5dkcr?=
 =?utf-8?B?V1N5YWFzd0YxbXFEcDJwOHJQNFhlTkJDZ0k2ZG4rbWNSNWNITExZZEhYRHAy?=
 =?utf-8?B?WjNnSWxoV3NLR29KQUhjZHNJUUp0dU1RMm1lWlVkanBBdUxBV0FQRldJYWR0?=
 =?utf-8?Q?kAJhftMPTH0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpacmt5ZE9uSms3MkQ2MFU4bldJRzhyelhldjJ5c3lTT0xDVWFTNUM2RU9j?=
 =?utf-8?B?MFBqZlo2dDkyU2tnc2NmT05SWk0zT1ZVaGJiNFhIeG10ekRRcmFwYjloWUky?=
 =?utf-8?B?dE5iT1ZhVUhVMG42ZWdFbkVhdGpDMHN4N3ZSSmJXTDdWY0x4eXVlOUwyb2hR?=
 =?utf-8?B?RE9aYWtXL1gzRU1GaUMyL2ZyNXp6cVBTQm04V0tzYnVZQ1psbk5YTXJhT2s2?=
 =?utf-8?B?bXE0UitOaC8veHBKSTJkWS9PelUveGc3VTlyM29QM2h5M2pXZFhXL0Zsd2dC?=
 =?utf-8?B?SHF0T0crTnkwcFJta2VTWHh3N3NaY0ZpbTJwMDI3VjJhRThtemk1VEo5Z2ZE?=
 =?utf-8?B?QktmNW1nb3ljTU9rcmxEOFRSZldRdW9QRUljWFM2SXVkNzg4c2s4dFZaRzJj?=
 =?utf-8?B?VytGRTBhUnRIMm53eTFJR1J3SGVDMjJwbU1qY3lTZWRMS2J3TEd0MWZocW53?=
 =?utf-8?B?bTMzc2FoVDFvZ2xzNDViRVZScGxyK3d2ejQ5enZrRGJVVVpxKzQ3VXVjUGx1?=
 =?utf-8?B?dGozV3cyOFRNNHJaeHlXTGZMaWdNWTBnT0ZENVJscUtjdVk0aHdxVWpkSmx2?=
 =?utf-8?B?V1pUdzlwYXMremZXSDgyVnJ5dVI5SmdqSnd4aTZ5RXlQWnVoZXNZRWQzZ3lN?=
 =?utf-8?B?djZZcngvRTFyV1psS2VTT0g0RWRla1BrVXcwYkxXRmxvL2JIUTVmNHkraTBi?=
 =?utf-8?B?L2xyeTg0eHRDVEI3WnkxbzAvb2MvMU1RTzZrNnk0ajVZTmFzZ2N3VWgxcnM0?=
 =?utf-8?B?a0hmanRINEEvRk1iR1k5elBDVEdlUDA4Q1BBVDZ5cHBDa3B2c2d5MVJkR1dn?=
 =?utf-8?B?OWdId25oZDhSZGdQcUc5WStOaXFHb2ZxZUVra1JiSEh3cjNBU2FocWxTSXdR?=
 =?utf-8?B?SjBEZHJlWU0xM3hSdHo1ZHRDajhoSUpoQjdEeEdxTmtSaURUU3U4dDRtWEhm?=
 =?utf-8?B?M3VMWElDKzIybUc3QmhTLzJpQ3V5ZDVlMHVGRkxVa2l4T1FHdWx3NENrenJ2?=
 =?utf-8?B?K2hrajQrSmtLQlZTdDZqQkc1NDFVaVBtY1lFUWlyL3g1c1JURUtJSXdvU08z?=
 =?utf-8?B?ZUlxaG5KUExzTVZZUjIza0VEcEs3RTRzRHpYVzQxMU1OMGNieTFzdTNnYktP?=
 =?utf-8?B?NGtLRWRBUld5VFozMnR2SzdLMG1mYUlMS1B5alRMaGJnMitQU3BpalFjUTlJ?=
 =?utf-8?B?OFFIYUpoRmFLWEpndEVDMWI2WHhuMnhralh3TVBzYWZ4U1Y1WEdiTDhod1RR?=
 =?utf-8?B?SUVMamJ5QmV6RFR2bXpNTGY5aEZXNHIrbXdEZm5YRDJHNWtqQ3JvRG1NSEtU?=
 =?utf-8?B?NWVzUldMVHVKRUhNeXRJcDhDT0pDMkRBcXdlNXcxelU0cXpwQ0NWbXdJdzIw?=
 =?utf-8?B?aU1jYUZXYkd1MUpGempRMVMrZnRySnJudGxEdEE4QnRqZHpacVpnY3locm9r?=
 =?utf-8?B?cmxwYk5YeS9QQ1p2RHA0bTJUWmgvZ1NmYUlpM1VUTVpwRzV1OEhGNjNpOGVu?=
 =?utf-8?B?UGN4VVRvWFl3Ti8vSVVZNWI3RkdRMUxyVi96a1lqaEcyZ0VwMC80MW1ZMU9X?=
 =?utf-8?B?dWlXVXJiMVVrVkkyQ1lXOVR0VXYzRitWSjdUOXdoNDRoSFpLSU93ZndoMkpj?=
 =?utf-8?B?MklxcTRWUEtZRGdIL0pRNUMwOGk2V3lSbjM3elh1V3FYSkxjbHFFb0lQcXhX?=
 =?utf-8?B?SzJnVkJMNW9oeVNydmxVeG9QVHlXbk9tNWhjOVpxT2FNM3phRjBrNEtQamlY?=
 =?utf-8?B?TG5TL1ZTaUZNMlptVW9tODVXdFRBbVhEK3kyLzdQOUJ1MG1IWlhma0twWEUr?=
 =?utf-8?B?L0VQSE5UUE05RUxzdUp5dVhCQUwwRDZDVVhZK3Yvbmd5ZjN4bHMvTnFMa2xD?=
 =?utf-8?B?KzVYSEI3aHRXS3NQckVjSGMrdjA2M3c4TkRiUGM0K054RTI2NTVYTFdNYnFn?=
 =?utf-8?B?TzRIN29FcGh3U1pzZk9NanVZVUppNldjdjhzdElqeW9zbC9Fd1dKVEdkbjc4?=
 =?utf-8?B?RmlVY3lJOFZ6YkxJS0NGK0lZY2NQYzR1Ty83S0dHL1dvR2toZFVSY1VZckpD?=
 =?utf-8?B?citCT0VxV01wblFDNlVzV0tMSk1sQVlKWitkNHRodlY0bWNlOG02RFNVbWkx?=
 =?utf-8?B?N0VtUitvZkhwR3g3UlF4VlJFZVJtcXEwTDhZWXJxM0xuenlRRGhoN3lYd21T?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C4Pf2ik/lRUqL/E2X8RZuxevOQYvQdbsL7kM94LXx28oh+U2uL9KORq6StyCRv159aD6Y8NGX5qu+x8yUbCE/i9H/8YidHLWu6dGecKyoTiv9+fpGYUDnCUqO/hUgOYoeKeNUrGWmOLhriluHm7Z+8syDnkRgEzyBJ6Qc3DIY7AZ/fV30VtUw6mZUApNcNipmJxHBBxq5zDxyNsSxk434R+m7ZZTSfEzmBr0atAzwIpOfphDwT4WpZ6XZ+cirrytbKOQCe97Tp0QBD0anjRksEWApZTVx2aw3sI9sGvrSOS5m6j/BizeyecM7mx9u2yWIAqgM2OkyMkPMKuKrFYBwA3+j6lWnxqYdGmoZxMv808esq53atnapgA5HLQ6qw3e5MnY05WmLBoDgu7CkFHIylsFwFvp7PHfgcaDm+uD3Mxlg/dFjQDN0RRHh97Ro37IP0UFt0SN6vz+KBzyFn5B7K86qXsPqVohasqe8RCySCxRAzL5X+XTaNHTiEjlFj7oKY/0fIQH0d0ReaKlrmdJjmJLYsNPtw+oPgPYdsIP6LDqErMM2FCagqqfsnLwl3aEaHlwo4u/iXfncg+tKJmucl38dGRdTuB8aXR6MTNCEgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 581cb383-8b76-4160-08ba-08dd97d5fd2a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 19:39:08.9293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GuFlJ+Af317Ay3o2JjB/0govX0a3QFUbft+hohJICoK+OYmv5yfLKPMlwZCSWV8irqcuwG0GYvvKHVbiqlUMt3vAFwD94pIpLX9faAMtEx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_08,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505200160
X-Proofpoint-GUID: DHHi1Jc1RsQU_QH3ZtlEyFUrl9AQZuwm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDE2MCBTYWx0ZWRfX++pN6IZ34RAV
 CiZg3AOupT4AB2bKNd20oBlpdmdfiGdhVIZbijuG4357VdeaCQINOp2m0RUe1uLEIfl0pOaRNMa
 ACY+CqhzI2tX5+9xsKpGYUL+V0pLFMFBfaWEgHAGY+lIqfqDLCAvD4MNT9g7A5i3ty2xej/RFbY
 QA6MAYUXFNfFO3ZdzSXCf2oPWOxUNStN+ZUKqxrSG8wvspj+CEgkfSrSGLsLzxBQp0IPOIWroBD
 uKT5ivMLXOm5go7/0uO84bQgc6LAhodeOV4KtapNsDuK+SH4SH16qVfACqQynkM5mmTv6LC4Ccy
 nCYY3tRWk6ztIq/0HXyRaiKg6mvHTAnPKF6qTc1EFnycmoxH6bgBlkPZlraV+Z59jDpqnfpIcuw
 sNeKR1qjogHEK9YPcX2ASRvDArLLf68GMI7b4fM0ZMgarcxcHybGwMl/ZNHKByhUEa5UV44t
X-Proofpoint-ORIG-GUID: DHHi1Jc1RsQU_QH3ZtlEyFUrl9AQZuwm
X-Authority-Analysis: v=2.4 cv=BKmzrEQG c=1 sm=1 tr=0 ts=682cda61 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=YasVGE7cOCIjA9xYBgMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13189
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

On 5/19/2025 11:52 AM, Steven Sistare wrote:
> On 5/16/2025 4:48 AM, Duan, Zhenzhong wrote:
>>> -----Original Message-----
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>> Subject: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>>>
>>> Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
>>> Such a mapping can be preserved without modification during CPR,
>>> because it depends on the file's address space, which does not change,
>>> rather than on the process's address space, which does change.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>> hw/vfio/container-base.c              |  9 +++++++++
>>> hw/vfio/iommufd.c                     | 13 +++++++++++++
>>> include/hw/vfio/vfio-container-base.h |  3 +++
>>> 3 files changed, 25 insertions(+)
>>>
>>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>>> index 8f43bc8..72a51a6 100644
>>> --- a/hw/vfio/container-base.c
>>> +++ b/hw/vfio/container-base.c
>>> @@ -79,7 +79,16 @@ int vfio_container_dma_map(VFIOContainerBase
>>> *bcontainer,
>>>                             RAMBlock *rb)
>>> {
>>>      VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>> +    int mfd = rb ? qemu_ram_get_fd(rb) : -1;
>>>
>>> +    if (mfd >= 0 && vioc->dma_map_file) {
>>> +        unsigned long start = vaddr - qemu_ram_get_host_addr(rb);
>>> +        unsigned long offset = qemu_ram_get_fd_offset(rb);
>>> +
>>> +        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
>>> +                           readonly);
>>
>> Shouldn't we return result to call site?
> 
> Yes!  Good catch, thanks.

With that simple fix:
   return vioc->dma_map_file(...)
can I add your RB?

- Steve

>>> +        return 0;
>>> +    }
>>>      g_assert(vioc->dma_map);
>>>      return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>>> }
>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>> index 167bda4..6eb417a 100644
>>> --- a/hw/vfio/iommufd.c
>>> +++ b/hw/vfio/iommufd.c
>>> @@ -44,6 +44,18 @@ static int iommufd_cdev_map(const VFIOContainerBase
>>> *bcontainer, hwaddr iova,
>>>                                     iova, size, vaddr, readonly);
>>> }
>>>
>>> +static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
>>> +                                 hwaddr iova, ram_addr_t size,
>>> +                                 int fd, unsigned long start, bool readonly)
>>> +{
>>> +    const VFIOIOMMUFDContainer *container =
>>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>>> +
>>> +    return iommufd_backend_map_file_dma(container->be,
>>> +                                        container->ioas_id,
>>> +                                        iova, size, fd, start, readonly);
>>> +}
>>> +
>>> static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>>>                                hwaddr iova, ram_addr_t size,
>>>                                IOMMUTLBEntry *iotlb, bool unmap_all)
>>> @@ -802,6 +814,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass
>>> *klass, const void *data)
>>>      VFIOIOMMUClass *vioc = VFIO_IOMMU_CLASS(klass);
>>>
>>>      vioc->dma_map = iommufd_cdev_map;
>>> +    vioc->dma_map_file = iommufd_cdev_map_file;
>>>      vioc->dma_unmap = iommufd_cdev_unmap;
>>>      vioc->attach_device = iommufd_cdev_attach;
>>>      vioc->detach_device = iommufd_cdev_detach;
>>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>>> container-base.h
>>> index 03b3f9c..f30f828 100644
>>> --- a/include/hw/vfio/vfio-container-base.h
>>> +++ b/include/hw/vfio/vfio-container-base.h
>>> @@ -123,6 +123,9 @@ struct VFIOIOMMUClass {
>>>      int (*dma_map)(const VFIOContainerBase *bcontainer,
>>>                     hwaddr iova, ram_addr_t size,
>>>                     void *vaddr, bool readonly);
>>> +    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
>>> +                        hwaddr iova, ram_addr_t size,
>>> +                        int fd, unsigned long start, bool readonly);
>>>      /**
>>>       * @dma_unmap
>>>       *
>>> -- 
>>> 1.8.3.1
>>
> 


