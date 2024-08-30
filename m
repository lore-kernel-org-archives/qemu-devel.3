Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F19CA0FF5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk22q-0004qO-Ki; Fri, 30 Aug 2024 09:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sk22p-0004n6-G0
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:52:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1sk22m-0006le-6D
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:52:07 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UDoZWl030230;
 Fri, 30 Aug 2024 13:52:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=Sfc1cG1c5cW1mtf3am2cLuBWkZdrHCSRTCS5WEm5AGE=; b=
 iJPjz49ErYENM7p+rJCuBp+4oQ+Zrj5NOB0xMypVVn8SA+WUX/sFbNizObt7WKWc
 jRuGZyCtLsI2cnbq7rcTKyRqinbxJUb2L77UEboJk6046hBg1GM2VzfZGaacHX2w
 ElRpRk7meXBLc8UhaJLSfW2aNkN3el2B+L6Xs2f+eAg0vGBPls3MrFCQLnuN0dmK
 yjqPziabwXMahyhwFFbthA+r3BX8DzHKB9Cdwv3qjKVnA4AQGSVgSWxCVKarmHvJ
 Bpo+OI00NBfCQiapPzrfRwhW9YfEGB4kaxLGGGXVeKOhwfQOUb/D5ZBGsaurRFAr
 qxXNNXBBY9BelGz0TFikyw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugxrau-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 13:51:59 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47UD1BMp016694; Fri, 30 Aug 2024 13:51:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 418a5wg4up-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 13:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVV3YL1/0pQ5ugLnk3w3VrMcpMTPytkSOSbqSXrW6DISUjoiOaECfEcfn3qXna0rK8CCg0bLQFmR4kC6PAW2NWLXABne/6thwU8tG2z4m6m1R9TQSfZ7LL3wFBsnMWhObZ4eiXi9Q/O86B8DZVGFVEOnS2OzizQ+l6kzO6F4SixPNz3SVV7iY2zl/8JzIseJzvA7Ek7ackgg3wEhR/OFh0yNdSg3pDp8ICJElUF/A57Zit/jKJJ+YsNd0OvXVglbapMBQ6/JXce4hRxnVOgot9q59/c7O+ldDb2v0qSEbNMg96fnfS24vbT6eHCcVH7yavU6+l+CaH0jL7uGhGDPTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sfc1cG1c5cW1mtf3am2cLuBWkZdrHCSRTCS5WEm5AGE=;
 b=dYOCvhMIa/5wpI/nZFs8yNRDmb8G/LsQdtp0mxWbduscdKyeQJZr8jS4rI7btkkstMbcKyUqv2MeWsUUzvyw8lIHIiifCdi9ZX+XjVy2sfOCF+8spTtfNNYjD+iGvFSAQOc/krL3r9CBFoJN66iidSvRBL1c3cyWVhZzcX2/rnCrPAS2pU/bTqoTlwD+j0+9VyqZE/ZU7VctNN6kjIITtydutaYEeoTuTDefExfEtLQYTxrZxMwTZnnWxxLDWvz50p5YN44zkXpOBk+2zhKK8DvD84KG9hbzcjzd/HEburXk5TwaZT+hBt7D7w6TUsDatrgCIOapR/s7uyl4DSa50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sfc1cG1c5cW1mtf3am2cLuBWkZdrHCSRTCS5WEm5AGE=;
 b=F6nxYHdk5DIbqf7dNfxiqOCep11t7rO9vz3ro721lgkYs961IAZGp/mh4wiNJMz3AQM/e70+WeEqig8KivxN4FkM1Opmm9eRCduIwY4AQJ8ln5BOoIqs4XufU2N/eT4sq2ehh+p+ZEMvIEfyLmA3/bRtCDUYwQm2rA0IQf3d6y8=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA1PR10MB7198.namprd10.prod.outlook.com (2603:10b6:208:3f3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 13:51:55 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 13:51:55 +0000
Message-ID: <82663e6b-0591-44da-ba88-58622e0ca56d@oracle.com>
Date: Fri, 30 Aug 2024 09:51:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 boris.ostrovsky@oracle.com
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
 <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
 <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWeEgSar8f_O26aw+WoSKFGc8DoVkxTv-XEPPo_AeLXLSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA1PR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 52a75c64-f371-42e7-b5b5-08dcc8fae8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTE1Z0ZJRVpIblhNWFVvVTJ5RmRSNzZDSzcxMXRnZmFXVXNnb0RpdUUvTGtj?=
 =?utf-8?B?NVhIc0VHa3NoOW1BWEEzRGwyZ1BObGwwbDZ0Q08yV0I3OUE5dXJkNHBwY0k5?=
 =?utf-8?B?V2liZDU4YWs0cU54bGVnK1Q1bElwWlJuNVF4cm94T0NWQmhzK2VUNWlLQ25Y?=
 =?utf-8?B?NnNGY1QwUnRYUGx4aHVWaHE4ZDZjNEtkNmZJZlNmRTA4N2kwc3ZPbElMQ0R0?=
 =?utf-8?B?NVhtOWE0OW51TjhiQTM2YWFCNTlDRHhuRzRLeFJjZGpobkczMUNqeFNZdUp6?=
 =?utf-8?B?OTVPOGg3UWMrSXZTT3VoaXdMUXFNK0ErTXVLVmoyVy9IQ0VDdDFqbkw2dDlk?=
 =?utf-8?B?Uk1NZi9LRWdFaVdCYThRSUlrKzNKelFPaW5QUThQUXNYazZsMXFyS2RDNTVM?=
 =?utf-8?B?Rk9OQ2pOT1RZWnFKZE91bThRQi9pOFBpNXoxT3Zob2VsaGJOeEY4VXA0c0hJ?=
 =?utf-8?B?L0Z1YU9mTHZiWUtnbGNUM3dPQWZSeWoweE5SZWg0dk9EejFOMTJJeFA4T1RC?=
 =?utf-8?B?Yk5KR1BMSkUxdElMeGRybG9JSU1PaUE5WHo1UW5BOW8xai8vMk5EaENIUEs0?=
 =?utf-8?B?OEV1T3B3NURXVG5HdWQ2ejkxT1ZKbituWjBaQjhhSFRuS2ZPREdXTVZPRi95?=
 =?utf-8?B?UU8yRnpydlREcE5GcW1SeXYzRDBMQW05S3BkbTRSN3RVUFZuYi9waUxZYmRW?=
 =?utf-8?B?SGxSUE5tejdSbkppNlNhRDRYWVl1VDZ6Y3YxTW9sQWlXUlVGK0hBUEhyZUdN?=
 =?utf-8?B?M2hvdlQ1OHZNc2s5N2s5U1Q3NVY2aFpRcVFERndXb2drd0w2ZVp0Q3hpWnN1?=
 =?utf-8?B?Y0ViMjYxckRoZE1GU2lXaTVCWEljaWV5OTM2Ym0yc21VLy9SZitGSjV1YUJK?=
 =?utf-8?B?YktzUUVRNkJvck9rK2xzNlJ1OU1uTDVnSkgyUEdQM2w0WDI3YmszQXlzTE4z?=
 =?utf-8?B?d1grcGd6VUVPdCt1Sm85aDhiNVRqdVpYQzYrTnRjdk8xRmNtTGVBbGs5N25V?=
 =?utf-8?B?NVNuMmZzVFR2SHF4YjdMVURSOHg4cmluU2w5ZG5SbWEreFFnZW1pRHdSeXlX?=
 =?utf-8?B?MFQwSS9sbk11RzhDQVE4a3YrK1NNSThOOWdBV3JCZHRvQzRtYTBJUlc3STk5?=
 =?utf-8?B?ZTlDckF0aVJKYm5wQVVDOE1qWW1yL2syWWVxVXJRRHl6bTltajBacHF6U1lL?=
 =?utf-8?B?VkkvSVdjZlhUNTYzeTY0akI0T0JPOGtyVlFzUmxuM0YxK081RVZwaHYrNk9p?=
 =?utf-8?B?VlRZQXlIN1dVYjJzbXhadmRaeW5vRHUxdzZXREdWbGhqQjJDU1cwMmVSQ2dG?=
 =?utf-8?B?T3l1R2RUYnRVTWlGVnJXS0FvS2tYTmcyQWkwdENwbjZTdnBxWTltTUNHMFk4?=
 =?utf-8?B?L1paeGVhSUdDbk9BQ2FZSVcvaVBCdDR6UStKZTNEdS9mNUVpR3VXT2tDUDdL?=
 =?utf-8?B?MlEvSTB2dG5kMjRISUUzMmRydUNUTzBaVkdoTlRnQzhyUldhVmF5eE8vVTVY?=
 =?utf-8?B?UThEczVwd3BCWC9LRmlzL3U2T2Q3VTBFWThyVjJ4RG5NVEN4QlJBU1IxYms0?=
 =?utf-8?B?NDRIVEJ6cHNiZUNEWlUzaVViOFd0S1JzRWdlWlBleVdtNUJoOFRWcGdzQUZo?=
 =?utf-8?B?RE10Nkk1VTlaSFFSSnFMdUU2ZU5JdmJWTitrUVFhZUdBUm5LSXAzSFFtOXpK?=
 =?utf-8?B?U2ZIdXorL3YzRExIODAwY091d2dRT0dMblhkZC9SWDlVK0dSNVd3elVFMGV5?=
 =?utf-8?B?alhJL1lMa2k0clI3MSs2TGYxblhpRWN6RXpMbXNRT1M0NVE2cW5GMEdOQWlo?=
 =?utf-8?B?WmNQYk14d2NUOXZpdWFLdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1NyT096WWRJY01TNUFYYXpneWRrQzkyNGZ5SmVoYjVzZy9NeG9lbVhzdHVM?=
 =?utf-8?B?ZjE1YmZwa0phS0VhQWhwZmpEZDFHb09aSHd2ZmZnSXI4K0tmVWp1SWdWdVJ3?=
 =?utf-8?B?NWNZSGlnT2h0bEFMK2UzcFlSZnI2ZFJ5NDV6UXM5UFRlUVpVTmJZOEtRYzF6?=
 =?utf-8?B?UUw1bk0vVEZBUmkyMnRyaytwdXN4NXFFc1RYUmN5SVc4WEJoM1h5SVJzWjBi?=
 =?utf-8?B?Mll3YU1LSEdqZzFJUUxKdkFzOVdKOEM0TC9IejFXbVlhVjR0dnJ3dE5QR1I5?=
 =?utf-8?B?OEtrbWp5L1gvRFJMWXBHc3RXam9TODJQUDN1cDVpdGVmMEhKYUx3elVGZDQ0?=
 =?utf-8?B?WDZUQWtzSVVhVFBVVDJRK21jSmhnRFo4L2Z2S0JteUQ5ZjI5aHJDWC8vN2I5?=
 =?utf-8?B?YlhudWxwOE5JeGR3NmdyQXFQQ0wyczkrQkRWck0zeTJRVitPbVBtSFExb3Mx?=
 =?utf-8?B?YnMrV09DSENjbG1LNEoxQ1M2cWRIbVRYdWNNWk4rTEc5UGgvcGdRL3J4ajhC?=
 =?utf-8?B?TWsrZ2lNSGdheXVpdU8zaU9LS1c2ektFNVRHaXRwNjVTNElwOGgyZUZ3eTc1?=
 =?utf-8?B?L0IyQklQaEZoT0p2akQ2ZWNuY1RvSjhXcC9sZEhrZ3JCOWlVc1dvN0h5RXNH?=
 =?utf-8?B?cnBrYnpwUHdJOEZHczZwQ0tiZ2RJQXphM08vY1VDL1A0WktEWnlQUG0vdnA5?=
 =?utf-8?B?UVJwOWQ2REZNMXlONzBUemlNMHdNVXVGWE00N0Z0RUVzQ0NTNzcyWHZUMTdC?=
 =?utf-8?B?RmdEQnFLQk9pQ1d1YzJZT3RVbkF1ZjhZK3BkVDhoUkZKMUdoSzFqQlNubTli?=
 =?utf-8?B?c3loM2lVZjc5N3VnM2kwSS9reFpDbDNEekkrQnRqSzdCR2ZHaEE5ZnN5czZp?=
 =?utf-8?B?QlBHcnFwN0ZpT0d1eTIrOFdNT2U2Y2ZVU0F3U0E5QXI2WkxnRGJ0SzhYR2tY?=
 =?utf-8?B?TGFDRzBRS29URG9aWU4xWHBpWHY0aXpJVWZ4M2JIZTRKNUhlcFhmWG1DejBk?=
 =?utf-8?B?ZVczUjllTUN2SFppRVdvNFA2dHpNTDhWUi9BbGQycWlzV0VtUk9yUU9JelB6?=
 =?utf-8?B?dU1KdU15WlVsN2x5cXFNQndsUkwyMlowbFg0dFhtcUw0bHgva0szYld0MVdp?=
 =?utf-8?B?ZTd6UzBJSlBReE15NXRpeEFTM0h5d2RWTUZXcSt1dWlGYUIwbHpVWmNNSVMr?=
 =?utf-8?B?NG5JV1dWZWNYRkV6VEZCRllzTEhTd3FreUFBb3Y1M1ZGNmo4enBLMk1NRTFQ?=
 =?utf-8?B?WTQ1NlFJaS9OcGNtZkJOaGRWaGdWSGVUMTRHcUFDZDlRUVo0U2lIS2I4aWtO?=
 =?utf-8?B?V2Y0dCtYKzM0aUxlY0pickRhUEhSR2dSZ1gxSVhhbDdaNGxCMVR4WUF1UXVD?=
 =?utf-8?B?MFZUMHFINUR4QlNKK1ZVYWx5MjVyNmlIUmFQSnE3bTdFS0QrSkthSmFkWmda?=
 =?utf-8?B?TTZyZWpsUFZsNzIzOXlDVlQrOGc0cHhzZWNOQ09VazFJdnJaRGd1RjlaaXhC?=
 =?utf-8?B?SnhsYmhMMHZVUUlVbDdQRWoyYVc3T21CN3MzNDZlVjZJS1B6amFBamxHalR1?=
 =?utf-8?B?aDVHNjdPOGpGRjdLOXZJcTczVlN5SWthVWRZeURyRU9RdFhlU2ovSEpoOEdO?=
 =?utf-8?B?Z00yMENyWnpvbGh6aXFWTzUwUmd0OXZkQ1hwN3h1KzIydkVVSVB6MFZ6R1da?=
 =?utf-8?B?TTAyY2FwT1VFNit1L1JiSVBzS2dEaXlCd3JHMkQ1dGFDdWJBdHhrNTcvMGkv?=
 =?utf-8?B?Q3MrUEhwRGlvWURiUEtDcDZzazNSWjNPY2I3eWx3Tmt5b0l2QzFJSm1GSldw?=
 =?utf-8?B?ZGZma1N0YjJxNWMvYS9DRWVVMjBzS1RXQUd4aHI0L0VTWGswc3FpenVtOWhh?=
 =?utf-8?B?dDlJOXgyVDNPL3llYjRIdFJFVHZ2aEJOSnlpOWl6eG8vYVpMRkxQTTRaMDlP?=
 =?utf-8?B?VVZJMTlPa2ZGUE5FNWs3SDIvTlRiWXBCT3Z1VU5YSGpVUzF4VDFWQ0FsR0lw?=
 =?utf-8?B?dGZ2Q05nZklzdTJ0NHZzVHY2T013TG1KbTJmSVVjc3M3QUtLNzlRQitya1hw?=
 =?utf-8?B?UzhPRnFlSWdzLzh0V0EzbGc5WVI3ditxU2ovWDBGVmtTdW5Wd1d1aWltNzBi?=
 =?utf-8?B?ZjdlbHBkR0QrTS9DU1FCdldKYXlVSUhtT0FBUXkwQzRGSWxYUTFnbUlvQXl3?=
 =?utf-8?Q?sgpNbPAdAARPaIkEQjlWgMo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j7O87/ZeTRrfF20fAB3l9iBUQArUHFqzfs8IabD9sb++h1pKJbgx0RY+r1pmZe5o+GGfwAuCIgKnrU9KixbPMRandglg4J8k4JZLG2JSC8VLyhDK/Yzs9yQPJvwfoA/vPv/8PKfrZJoBpuOP48F7eU4EHkLSaowVutVMEPpfa88HAHwfiZZU2LBIgzK4YHVbrWx1de2W9mWbVShOgssOsTkntTtt5pPCIB83dKweuMsrHX99dBXR6UKvhCSNdFFZEWbSqR6KCllrbQ3pZGfmKBNlGCBh1mi1E1d95TZNHuLqBBobvZVWRg20lKBC2gOrdUNmRyo8gOCmZk6pNC0Y2KxQac2JzsrrK9Y2CuqFBCXPIUaw/GeZtlhnXdBYSGDN4Qa0TJ3RWseXu2GdRLnLKe74h134PrZJOpgHzWyBgDBopoWAIwaC2OMxg2khSZGMDSmj2qOHaGsVRrwJUiM9GWp3EtTx5yT88QQ4gtBYW+YaqzLU6EzulS24SpSxtJEcm77gn4LF68gXHlE/wcs6sP1BRRpsEXHKEShs7ylARCc72vDRr0TYHBNw+aDLBjE+C50Z3geUgWRKr6e78uAUik3cxmRmzX3IgRawhomi6gA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52a75c64-f371-42e7-b5b5-08dcc8fae8c5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:51:55.3529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPyQt1OoOWe/zGRoeE8T3BiCHvwJN8bYUiSaIAMS99q0bTwePHIneoooB5UcbW/XB8PTDT3wiuzQS1ndp55FGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7198
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_08,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300105
X-Proofpoint-GUID: sMTsYgKkbhJJHxm1J1UuaYv8gIKzZFEg
X-Proofpoint-ORIG-GUID: sMTsYgKkbhJJHxm1J1UuaYv8gIKzZFEg
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 8/30/24 4:05 AM, Eugenio Perez Martin wrote:
> On Fri, Aug 30, 2024 at 6:20 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>>
>> On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
>>> On Wed, Aug 21, 2024 at 2:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
>>>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
>>>> will hold all IOVA ranges that have been allocated (e.g. in the
>>>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
>>>>
>>>> A new API function vhost_iova_tree_insert() is also created to add a
>>>> IOVA->HVA mapping into the IOVA->HVA tree.
>>>>
>>> I think this is a good first iteration but we can take steps to
>>> simplify it. Also, it is great to be able to make points on real code
>>> instead of designs on the air :).
>>>

I can add more comments in the code if this is what you mean, no problem!

>>> I expected a split of vhost_iova_tree_map_alloc between the current
>>> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
>>> similar. Similarly, a vhost_iova_tree_remove and
>>> vhost_iova_tree_remove_gpa would be needed.
>>> >>> The first one is used for regions that don't exist in the guest, like
>>> SVQ vrings or CVQ buffers. The second one is the one used by the
>>> memory listener to map the guest regions into the vdpa device.
>>>
>>> Implementation wise, only two trees are actually needed:
>>> * Current iova_taddr_map that contains all IOVA->vaddr translations as
>>> seen by the device, so both allocation functions can work on a single
>>> tree. The function iova_tree_find_iova keeps using this one, so the
>> I thought we had thorough discussion about this and agreed upon the
>> decoupled IOVA allocator solution.
> 
> My interpretation of it is to leave the allocator as the current one,
> and create a new tree with GPA which is guaranteed to be unique. But
> we can talk over it of course.
> 

So you mean keep the full IOVA->HVA tree but also have a GPA->IOVA tree 
as well for guest memory regions, correct?

>> But maybe I missed something earlier,
>> I am not clear how come this iova_tree_find_iova function could still
>> work with the full IOVA-> HVA tree when it comes to aliased memory or
>> overlapped HVAs? Granted, for the memory map removal in the
>> .region_del() path, we could rely on the GPA tree to locate the
>> corresponding IOVA, but how come the translation path could figure out
>> which IOVA range to return when the vaddr happens to fall in an
>> overlapped HVA range?
> 
> That is not a problem, as they both translate to the same address at the device.
> 
> The most complicated situation is where we have a region contained in
> another region, and the requested buffer crosses them. If the IOVA
> tree returns the inner region, it will return the buffer chained with
> the rest of the content in the outer region. Not optimal, but solved
> either way.
> 
> The only problem that comes to my mind is the case where the inner
> region is RO and it is a write command, but I don't think we have this
> case in a sane guest. A malicious guest cannot do any harm this way
> anyway.
> 
>> Do we still assume some overlapping order so we
>> always return the first match from the tree? Or we expect every current
>> user of iova_tree_find_iova should pass in GPA rather than HVA and use
>> the vhost_iova_xxx_gpa API variant to look up IOVA?
>>
> 
> No, iova_tree_find_iova should keep asking for vaddr, as the result is
> guaranteed to be there. Users of VhostIOVATree only need to modify how
> they add or remove regions, knowing if they come from the guest or
> not. As shown by this series, it is easier to do in that place than in
> translation.
> 
>> Thanks,
>> -Siwei
>>
>>> user does not need to know if the address is from the guest or only
>>> exists in QEMU by using RAMBlock etc. All insert and remove functions
>>> use this tree.
>>> * A new tree that relates IOVA to GPA, that only
>>> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
>>>
>>> The ideal case is that the key in this new tree is the GPA and the
>>> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
>>> the key and translated_addr is the vaddr. We can create a new tree
>>> struct for that, use GTree directly, or translate the reverse
>>> linearly. As memory add / remove should not be frequent, I think the
>>> simpler is the last one, but I'd be ok with creating a new tree.
>>>

Is the concern here that making the gpa_map (GPA->IOVA tree) of type 
IOVATree can be confusing for users from an API perspective?

In other words, IOVATree users should always use its iova member as the 
key and the translated_addr member as the value (and thus IOVATree 
gpa_map feels out of place since it uses the translated_addr as the key 
and iova as the value)?

Also, could you elaborate a bit more on "translate the reverse 
linearly"? Do you mean to create an IOVA->GPA tree but always search the 
tree using the GPA (e.g. via iova_tree_find_iova)?

>>> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
>>> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
>>> this tree, and only remove the associated DMAMap in iova_taddr_map
>>> that matches the IOVA.
>>>
>>> Does it make sense to you?

Would using a name like vhost_iova_tree_map_alloc_gpa seem a bit 
misleading given that we're already allocating the IOVA range in 
vhost_iova_tree_map_alloc? It seems this would be more of an insertion 
rather than an allocation when adding a map to the GPA->IOVA tree.

Also, are you saying that vhost_iova_tree_remove_gpa only removes the 
DMAMap in the IOVA->HVA tree or should it also remove the corresponding 
mapping in the GPA->IOVA tree?

>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>    hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++-----
>>>>    hw/virtio/vhost-iova-tree.h |  1 +
>>>>    hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
>>>>    net/vhost-vdpa.c            | 13 +++++++++++--
>>>>    4 files changed, 70 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>>>> index 3d03395a77..32c03db2f5 100644
>>>> --- a/hw/virtio/vhost-iova-tree.c
>>>> +++ b/hw/virtio/vhost-iova-tree.c
>>>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
>>>>
>>>>        /* IOVA address to qemu memory maps. */
>>>>        IOVATree *iova_taddr_map;
>>>> +
>>>> +    /* IOVA tree (IOVA allocator) */
>>>> +    IOVATree *iova_map;
>>>>    };
>>>>
>>>>    /**
>>>> - * Create a new IOVA tree
>>>> + * Create a new VhostIOVATree with a new set of IOVATree's:
>>> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
>>> implementation detail.
>>>

Gotcha. Would you like me to remove the other comments then?

>>>> + * - IOVA allocator (iova_map)
>>>> + * - IOVA->HVA tree (iova_taddr_map)
>>>>     *
>>>> - * Returns the new IOVA tree
>>>> + * Returns the new VhostIOVATree
>>>>     */
>>>>    VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    {
>>>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>        tree->iova_last = iova_last;
>>>>
>>>>        tree->iova_taddr_map = iova_tree_new();
>>>> +    tree->iova_map = iova_tree_new();
>>>>        return tree;
>>>>    }
>>>>
>>>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>>>    void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>>>    {
>>>>        iova_tree_destroy(iova_tree->iova_taddr_map);
>>>> +    iova_tree_destroy(iova_tree->iova_map);
>>>>        g_free(iova_tree);
>>>>    }
>>>>
>>>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>        /* Some vhost devices do not like addr 0. Skip first page */
>>>>        hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>>>
>>>> -    if (map->translated_addr + map->size < map->translated_addr ||
>>> Why remove this condition? If the request is invalid we still need to
>>> return an error here.
>>>
>>> Maybe we should move it to iova_tree_alloc_map though.
>>>

This series decoupled the IOVA allocator from also adding a mapping to 
the IOVA->HVA tree and instead added IOVA ranges only to an IOVA-only 
tree. So no value existed under translated_addr for these mappings 
specifically.

This check was moved to vhost_iova_tree_insert since that function 
covered adding the host-only memory mappings to the IOVA->SVQ HVA tree.

>>>> -        map->perm == IOMMU_NONE) {
>>>> +    if (map->perm == IOMMU_NONE) {
>>>>            return IOVA_ERR_INVALID;
>>>>        }
>>>>
>>>>        /* Allocate a node in IOVA address */
>>>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>>>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>>>>                                   tree->iova_last);
>>>>    }
>>>>
>>>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>>>    {
>>>>        iova_tree_remove(iova_tree->iova_taddr_map, map);
>>>> +    iova_tree_remove(iova_tree->iova_map, map);
>>>> +}
>>>> +
>>>> +/**
>>>> + * Insert a new mapping to the IOVA->HVA tree
>>>> + *
>>>> + * @tree: The VhostIOVATree
>>>> + * @map: The iova map
>>>> + *
>>>> + * Returns:
>>>> + * - IOVA_OK if the map fits in the container
>>>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>>>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
>>>> + */
>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>>>> +{
>>>> +    if (map->translated_addr + map->size < map->translated_addr ||
>>>> +        map->perm == IOMMU_NONE) {
>>>> +        return IOVA_ERR_INVALID;
>>>> +    }
>>>> +
>>>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>>>    }
>>>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>>>> index 4adfd79ff0..8bf7b64786 100644
>>>> --- a/hw/virtio/vhost-iova-tree.h
>>>> +++ b/hw/virtio/vhost-iova-tree.h
>>>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>>>                                            const DMAMap *map);
>>>>    int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>>>    void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>>>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>>>>
>>>>    #endif
>>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>>> index 3cdaa12ed5..6702459065 100644
>>>> --- a/hw/virtio/vhost-vdpa.c
>>>> +++ b/hw/virtio/vhost-vdpa.c
>>>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>        if (s->shadow_data) {
>>>>            int r;
>>>>
>>>> -        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
>>>>            mem_region.size = int128_get64(llsize) - 1,
>>>>            mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>>>
>>>> +        /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>            r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>>>            if (unlikely(r != IOVA_OK)) {
>>>>                error_report("Can't allocate a mapping (%d)", r);
>>>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>>>            }
>>>>
>>>>            iova = mem_region.iova;
>>>> +
>>>> +        /* Add mapping to the IOVA->HVA tree */
>>>> +        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
>>>> +        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
>>>> +        if (unlikely(r != IOVA_OK)) {
>>>> +            error_report("Can't add listener region mapping (%d)", r);
>>>> +            goto fail_map;
>>>> +        }
>>> I'd say it is not intuitive for the caller code.
>>>

Sorry, I'm not sure what you mean by this here. Would you mind 
elaborating a bit more?

>>>>        }
>>>>
>>>>        vhost_vdpa_iotlb_batch_begin_once(s);
>>>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
>>>>     *
>>>>     * @v: Vhost-vdpa device
>>>>     * @needle: The area to search iova
>>>> + * @taddr: The translated address (SVQ HVA)
>>>>     * @errorp: Error pointer
>>>>     */
>>>>    static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>>>> -                                    Error **errp)
>>>> +                                    hwaddr taddr, Error **errp)
>>>>    {
>>>>        int r;
>>>>
>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>>>>        if (unlikely(r != IOVA_OK)) {
>>>>            error_setg(errp, "Cannot allocate iova (%d)", r);
>>>>            return false;
>>>>        }
>>>>
>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>> +    needle->translated_addr = taddr;
>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
>>>> +    if (unlikely(r != IOVA_OK)) {
>>>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
>>>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>>>> +        return false;
>>>> +    }
>>>> +
>>>>        r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>>>>                               needle->size + 1,
>>>>                               (void *)(uintptr_t)needle->translated_addr,
>>>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>        vhost_svq_get_vring_addr(svq, &svq_addr);
>>>>
>>>>        driver_region = (DMAMap) {
>>>> -        .translated_addr = svq_addr.desc_user_addr,
>>>>            .size = driver_size - 1,
>>>>            .perm = IOMMU_RO,
>>>>        };
>>>> -    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>>>> +    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
>>>> +                                 errp);
>>>>        if (unlikely(!ok)) {
>>>>            error_prepend(errp, "Cannot create vq driver region: ");
>>>>            return false;
>>>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>>>        addr->avail_user_addr = driver_region.iova + avail_offset;
>>>>
>>>>        device_region = (DMAMap) {
>>>> -        .translated_addr = svq_addr.used_user_addr,
>>>>            .size = device_size - 1,
>>>>            .perm = IOMMU_RW,
>>>>        };
>>>> -    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
>>>> +    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
>>>> +                                 errp);
>>>>        if (unlikely(!ok)) {
>>>>            error_prepend(errp, "Cannot create vq device region: ");
>>>>            vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>>>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>>>> index 03457ead66..81da956b92 100644
>>>> --- a/net/vhost-vdpa.c
>>>> +++ b/net/vhost-vdpa.c
>>>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>>>>        DMAMap map = {};
>>>>        int r;
>>>>
>>>> -    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>>        map.size = size - 1;
>>>>        map.perm = write ? IOMMU_RW : IOMMU_RO,
>>>> +
>>>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>>>        r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>>>>        if (unlikely(r != IOVA_OK)) {
>>>> -        error_report("Cannot map injected element");
>>>> +        error_report("Cannot allocate IOVA range for injected element");
>>>>            return r;
>>>>        }
>>>>
>>>> +    /* Add mapping to the IOVA->HVA tree */
>>>> +    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
>>>> +    if (unlikely(r != IOVA_OK)) {
>>>> +        error_report("Cannot map injected element into IOVA->HVA tree");
>>>> +        goto dma_map_err;
>>>> +    }
>>>> +
>>>>        r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>>>>                               vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
>>>>        if (unlikely(r < 0)) {
>>>> --
>>>> 2.43.5
>>>>
>>
> 

