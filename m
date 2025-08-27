Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D71CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 16:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urJRn-0000qo-KY; Wed, 27 Aug 2025 12:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1urJRj-0000pX-MC
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:56:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1urJRc-0006Sk-2J
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 12:56:27 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7tsp4015094;
 Wed, 27 Aug 2025 16:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=TsZJ9XQ/zDT8jis8LrZpe7EUPqOvVyOe++lrWN2n/bs=; b=
 fjy5jODNuFakqNn0FHPrOw5djbWv/a1K8Nzypgi5vIrhMowA3gKaWdBLDlQh62pL
 fcOKyOV5dcVV6FyVS4ib/j/HzEIlgct4zvUJd0DfpUpXda372CTKZjw345ueHKiK
 HZHRrP+CQX9Sl4hHmG3xlG0uoLXCzhRLF99QR8lvUBd5sxqO+iyaiBeqMd9/90fr
 eGSHOmsMGgiWih9WuE8xA93RZlcJmVJ5ADt4szdRdWeoI77sI81cK61yFmArYi3K
 JdQDACXkRdub1I9DPlShq/XfXC7ZmvqR1OEE6emt1mdyvtOUTXghSDrsS4vVYezd
 /+H4ZmgmlESfh4OfOn2fgA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4japw6k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 16:56:15 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57RFoPVn014559; Wed, 27 Aug 2025 16:55:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48q43avfu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Aug 2025 16:55:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9bqYEZg6QIOTMyX+SVYrZq9WK0oLGt6q8EaZv+z3Cri3mSlPnTw0I0+7o7HO3KT1GK8EwM23TELvCKKk9hN/Px4WPpPlvWFVCHYB+MGJnUKJFK17IbyxKYdB1MsZif6htQovy7mFtOB54HgFARhHLJRJeywwbacGa8lnhR0/fdmUmH1jn7ycQmrK5fGyY1QKwURfS60Rpxue+ldXNEnxdat9E4GjgX8gfi7VvcGvuOL2+QAkucrE0HrqZiNSqks81AxWhrgpXD48xiiOisPzJYI/sHfVSpndeFBIhjXUxMOuzvt1N3Byxy2UbT9Rc5lMWhFJg7O/BUpSr+1TqCwUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsZJ9XQ/zDT8jis8LrZpe7EUPqOvVyOe++lrWN2n/bs=;
 b=jS5IuAePTCO7741MvssE0GhVeyTpbd0OQq5zkvzCkSEsIYYPBqvqa3F0+Ml4yYe8FvDimlKnIa+bEJwH+KWBpGOv886gYYGnXudup5kAmHAASxySgSPdAzZFvgr2wR3hZqDkHtAf7b+stK87hmAU7FYMT5N+68ZBWa7lK1JTGzMregaASsZha/VmaANiTHTXnntw3EvWK/Pd+cOEsJXD57Dle4SlEPPX/arES3/vm1EgiVmWUREwhyo7yGOBi7CzztUluW07Z/h/1heSdvKLPgW4AdfIt1yBRDp3cv7xM4Irbj2mrZsheSSEyYYYJabyCWq+vwERZYr3IPNhi9Vjkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsZJ9XQ/zDT8jis8LrZpe7EUPqOvVyOe++lrWN2n/bs=;
 b=P/xvnR2Tk7ay1dO2PK1r2KaEcC19/lBOtwkJB1I3OBMJTfQJyM6L9ypI3JVbT00oygjiDuOmo1NDWLvjvn1A7a1ff4AWLN+ZkUgqIyP+RnJkVfbCSny4RlS4CaKtN9vcclnfqyoFZVStjNuq2haaPlvOVZSAxb72rMOHkH9hVLg=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by DS0PR10MB7453.namprd10.prod.outlook.com (2603:10b6:8:159::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 16:55:41 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.017; Wed, 27 Aug 2025
 16:55:41 +0000
Message-ID: <f143a9a6-56b5-43a8-bced-bec7c7be8a2d@oracle.com>
Date: Wed, 27 Aug 2025 12:55:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
To: Eugenio Perez Martin <eperezma@redhat.com>, Peter Xu <peterx@redhat.com>, 
 si-wei.liu@oracle.com
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 boris.ostrovsky@oracle.com, Dragos Tatulea DE <dtatulea@nvidia.com>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local> <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local> <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
 <aJnydjxFzKwVzi7Y@x1.local> <eafcf9ca-f23f-42d5-b8c2-69f81a395d11@oracle.com>
 <aJpm4-JfmevsI7Ei@x1.local>
 <CAJaqyWfAnH-Lca3zmQTiR2wtaryKUo2KDKa=s5pcuAO9E6Efsw@mail.gmail.com>
 <aJyb6n9Vf4BhHqpb@x1.local>
 <CAJaqyWdUutZrAWKy9d=ip+h+y3BnptUrcL8Xj06XfizNxPtfpw@mail.gmail.com>
 <59317419-e832-4590-ad4f-cfe7d21e8fd4@oracle.com>
 <CAJaqyWfc3G5NLnxqXvZFxw2aRnVvOcZbLds5LHzcdoLjVGmOsw@mail.gmail.com>
 <c5b97e10-a8bb-4d59-b509-734eab7d5be3@oracle.com>
 <CAJaqyWc-vKsqs2boiktJn_cO3fSVk=-EfP3G8QN-z=n59VCoHA@mail.gmail.com>
 <4f067326-6c80-4768-886b-2b819e7184d3@oracle.com>
 <CAJaqyWcNdPyrAmRMBgdEk3o4AR1kK6ZiHWdY6q4MuwvGgjub8Q@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWcNdPyrAmRMBgdEk3o4AR1kK6ZiHWdY6q4MuwvGgjub8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0056.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::14) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|DS0PR10MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 858eafeb-2b3a-4610-ef03-08dde58a8e35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGoveXhLRTg5Sk9kdis4VHBqQ09GMjJlTjlZQ2FLZllIY3FtU2ludmZmVVQ5?=
 =?utf-8?B?TldlcVlUa1kxRFNpSlNFemlLdUl0aXRzOS8xVlF1MHVUL1pwMC9MOXdHLzV2?=
 =?utf-8?B?dDBqZWh5MUQ1VzBtTWVmZ28xQzY2V3N1TG1sblV3L0ZUYmtsU1hmbDFpVTBR?=
 =?utf-8?B?M3J5aitCandvZG9vZ2JNazhaaHh6YVo4cUlUYjVlQ09qY3hpbXlwZVdIdHcw?=
 =?utf-8?B?VkUwQnhaLytSNEs5TFBUV3g1WEhFc1AwdlBOQ3dFNGlRdlFpQVExazlrL2dm?=
 =?utf-8?B?SXU5cDZYOExrdlUxZnBGN3I0SDlLbWUvMUxvaHRoOEJ6ZWxRazRiRnRqYkZ5?=
 =?utf-8?B?MGg3QlJkbFNlMUJ6dXhxaE1FZGZ1bC9HUEdBam84eHgvQi9VQkU4L0tVMjlO?=
 =?utf-8?B?MWZhTWFoTnkzQ3NHVGg0ZTg0aDBrV1V2aUlWangzMms4WjljYVB0Z2I3TDMy?=
 =?utf-8?B?aERhd3RrYngxL1BXYjJLajFIWGlDQXg2dUpxL2FTR05GOXpZQTNINjVINEZu?=
 =?utf-8?B?bXphdDNRd2Y2bzc3SEFyLzdKdmJYdVltcXVTQ3U1aWIwTHJHYlhJRjlpd3N0?=
 =?utf-8?B?TjhvYmw2NW9uU0cvWU1rbGlDNUR6TTYvcVM5cHluWkd2djNWV2oyL3VKdXNV?=
 =?utf-8?B?a254cFRHS29rZU1hVWg2Qm1iVmd2OWNNTTljQS9lTGN3REllYkFoVDJLZ1Jm?=
 =?utf-8?B?SjZsbjJiNGlXQzBNc0ZuUDVBbk5oWXNBY1Zzc1BBTDVLWExveEtSRFdTYkFr?=
 =?utf-8?B?Z3lVcHBoUDB3c2luRDFnem9vYk9MZHBPS3FtSjA3UnI4UXBwcjJqbjlmODEv?=
 =?utf-8?B?bzRzNmYzUVlRdFJmTXRMR1VHQk4ydFVLQmNaZmN1b2RXdkZGQm5ObmtqT0pz?=
 =?utf-8?B?MVcydHFTKzdwdm85dE5MZ0RXVkozVk5CUjE3Ny9JcUZjZ1ZZSkJrQi9QM0dG?=
 =?utf-8?B?Z0h0SUdKSzh0YVhhOUYvQmhDdEorNGdFZzl3bFJSaHF2RE1teDBsTkF0R3FI?=
 =?utf-8?B?UkdtTGdpSHVudFJQQkkxNVFjbEFQSmk5VGZ2UWM1eDVKeVlTTEVGNXJLYnRa?=
 =?utf-8?B?cS9Yb09rZHFTZHdOVWhzMDVnblFYTlNaQUdjbVdFT1pWUGIrWjFHdmVjcEMr?=
 =?utf-8?B?UHVXTEdldjdkKzN3QW1BbUgrYjFQd3B5RG9wMW1ydFUrcm9UL3Z4TlMraXdP?=
 =?utf-8?B?TWtaL1M1QzhLcFZUNHgydWo0cmpZWVJDSjdMUDBXZ3pCV281RExxTlhhdXZ5?=
 =?utf-8?B?cURqRGIyMUVYR3d6a3ljQy9tTUU5c3F4eDJyaFZsZnY1UlA3ZysxeERLendw?=
 =?utf-8?B?Y2MwNUlsTnVlaFpsRUF3c3F3K0lXOGl6NU1Tc0Fqbk9FWDVOZXFyNVR1QXoz?=
 =?utf-8?B?Sm9KVjBlWnlIRTlSdWd5NXJzTlpJOWtrSEVTWSs0OVh5YlRLRTNmZEV1T1NQ?=
 =?utf-8?B?c0lDZ0h2b1puWk43cUJEeVpvb1pXUUd5ZCtKbEpMODE0MjRMdm5sZEl3bTJR?=
 =?utf-8?B?OTNJa0F3SnhLSVRnb2VtSFY3dTdqY1FJYUY2WW1TZVR2OERtQXAzTWo3UTlo?=
 =?utf-8?B?Wm80WmtBdnUxekhrM0tiNWVONmJJTVplYkpUK1hUbUl5K2F0enpIUG5nWWls?=
 =?utf-8?B?b3FuQUd4NUxIQ0xtSStJNE5FMmRRZ2szdjYvRmpRcmE1SDRxb2JHRi9PRWtn?=
 =?utf-8?B?NWV2MXZtS1NBbHJrdE1lVEpvdmJjdkg0OWZqUzk0K3BHcmt5Z1lkSFNRWnhy?=
 =?utf-8?B?NUNoSDJvMXVuWmNGTTNVbmE3RWNIMUhkbGpYWE93MnkraWRqTXN5dmhnYU5m?=
 =?utf-8?B?amkyRG1OdkVweUZ2RjIvbkFET01GZkdydnZkWnQwcXdYQ21oR3JoTnFsSDA3?=
 =?utf-8?Q?e+Qx2MOXIBsLj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRmUzE0WkRBZzNYMVhENS82RmYxZUI0bHhOVlNnUmU5SHpUTG9OVzU0eEFQ?=
 =?utf-8?B?bWhZNzhCWmp3NGdIdHpjSzRMbjI1NzVlZFRhVEU4a3VMd29ZQ0xRakF3aFFO?=
 =?utf-8?B?WXpxaFRMK3NIQkxUdFZaY01vOS8wTUVQMi9TNlM1SUpudzArd0dvbGRpa1JR?=
 =?utf-8?B?ZnJFTDhQVlZqeUJrRloveHdOckplU29Mc21ZZzhNODJJMG5BeCtRcnZ2NXdD?=
 =?utf-8?B?b0tsQjVIZENwOW5VNHhTQTRGSjZqb2hCbzl4RldTMUVKLzhkRnlBWGhDQno2?=
 =?utf-8?B?VElXTmNpczBUbjBIMmFQdnlNTEZnazZrd2lTYitoRnFNMXluc3JIcERqTVJK?=
 =?utf-8?B?YktocUVjRlcwcjErdG90YmNhRGhJeVpVbkllOWdRZHlUY3JFcnpmdGw3M0dl?=
 =?utf-8?B?VkRvOE1ycEEranBpQlVCZ2VzclR6UHgwNy8vMmhzcnNIUzVUK05FRGk2aEZQ?=
 =?utf-8?B?WUFGdnpqYVlXR0lMbUErcjF5cGdGdk56UWNEQ0ZTakFIRHdWYmRuamJmdXNn?=
 =?utf-8?B?cFJiWHhFZndONzEra0c3LzErVHBKRFlqYkJuMFNYNmdjaURkcXNRZmEyRmUy?=
 =?utf-8?B?R0JMMTVUZTJxc3cvZk9KVFN5MVB4a21kYStVclE0VFpVaUFLdS9CL0xzbHVy?=
 =?utf-8?B?UnJqMjNVT3FBQWJudWFFQjZSWEh4eEY2NlA0NjhaV0ZxSm9IeEdnajFERGxn?=
 =?utf-8?B?Z1RHWVlSSVlXZWlYYktQUU1WdHRTK000R3FEazVDcTVIemZqS0tTZGtzWk5v?=
 =?utf-8?B?aHl2bFJtZ3FsUWhCb1FYNmI0ZXVvc0RtWkhLQURMVG5sdG44Nk9ZbHlFdmE2?=
 =?utf-8?B?WGZCYmNOUHR3bXFRS3VaK3lwU2s2aFd1UGlRK3NOaTNEYm1BS2JaYmlIWnhm?=
 =?utf-8?B?QWpvcE5TM0x1UmpWWDBQeTBpZElzdWFkOGY5UkpKa1k1VURMdmNnZ3doOWUz?=
 =?utf-8?B?Zm40NEZ2eEk4WGp6SkRtWHpFMEhHSnlJMVk3MEQ3SG1od25IYVdsWlN4SWpt?=
 =?utf-8?B?QkNQUzZZNDRmakFLcmZJTGNBK3NSUTQ2SmM1OUIrbTN1ZTAxT25jNm1RZDlm?=
 =?utf-8?B?R1NTSnJvL0VFK0xya29BMmVNSFZLMFhDL3ByUk8vSnBGZ3pFNUpqb3JXWXd4?=
 =?utf-8?B?Tkh2Q3hQdHRVN2hOYmlieUZHOS9MM1BmNDZjZWJnOHphTE42V05lQWlwbG9o?=
 =?utf-8?B?bDU5RjdyTHJsdlljTC8rSTk4ZmhyNmE3bkl1UUw4OXRBTTlkazFKNDVMQ3g1?=
 =?utf-8?B?aG5qRTV6cGQxaVplNDNpL0JPV2p1Z3hhbExvU1F2WmszMkFZU0p3ajlXZ2Ix?=
 =?utf-8?B?SzBOTmd0bXpPdXdjOTVxMkRWZTZIY0g0S2JnKzdCNEQ5OGcvaGZkWGlYdERP?=
 =?utf-8?B?cVo2SUZOTzdsd0hNUmZIZUY0RWhCTU9PZ2Y3Qy9lLzFGWnFUQVF3YlRRY3NI?=
 =?utf-8?B?MXl5dFA1SXdISm5qZ3VjSVg0QThIbU5HVGJRVzdHbHFkVGdmQzB1d3ZEemh1?=
 =?utf-8?B?a0ttY3J2SFdEMUZQN2lrNkFWZEc1b0tCZ3NjN3hvL0ZTVDBYNytmR3QyRkE2?=
 =?utf-8?B?ZVI5c1NIVzBnUmZrU01vUVRiK2dnQTFrckh0Y0dKMnBZNGdpNU50eUxrTkNo?=
 =?utf-8?B?bGc3ZXpKbkt5V01sYzA5WWc2LzhINEFIQ0Ezd284dDltMUlFOEVVcGdUSTNq?=
 =?utf-8?B?SU9TeUl3WXVONHVCYWQ5RUE2TGdiNU84UVpocGFnK3lFd0ZYdVNJcFRBQjVz?=
 =?utf-8?B?U0l0TUY3U2NVZVB5UXo0ZGxjYko4UzRmbVF1K3VBVjBHb3gzYjRTUXIzT3NB?=
 =?utf-8?B?VnV1RlFpaXlFMUdyRm1UMnNiREloQ0dpODdCT0k3OTBsZWFCbnF5ZHQ4V0ox?=
 =?utf-8?B?WVFoYVFlaW1PenVheWVyZ3hLK1loWXQzcmRXZXZOdDF3RmQ2TllkaGVGQjBE?=
 =?utf-8?B?RFE0VVZQd0t0Q3VCbU5VRkI5anlXRWNyanE4ODV1K2lxL0RIRkpPN2dPYk5i?=
 =?utf-8?B?R2YxL0pMZkRFSWNsT1VMYUVUOWYwUHFJc0hRVG93dVkyV0xtUzVXWXAzbkxU?=
 =?utf-8?B?UHVDbHk1Y0xhcy9RR01yL0xkd2lCelpkM1R6cXVwb0hoZlhYcXZIYXdSa2Qy?=
 =?utf-8?Q?JhR6eSFxWvOkD8hMg28ukXFZD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XPop/2dBodbNgokq5ObqQPSm4k0U01drNvlJaSfnLG1Ixp53Dkdg/2Wwt74MUByEezzMS8TWF44cSFjKaTYm321auC5Tyq9wZkaI82PtwgFCNiBzvO5gRor9iniZ8PiJJL2k/6HNvjE+I+ZdVBbgbhM9N3Ql11VMLpKFSdjwcZ36UzmjgYJ6nRv6mnTUSC6KEqiuutBxzAqkOsFnfyDB2lfpzlx9XBDPeeZ2ZgVeZLGPNFaAHlR6FXEZ4Mr8yBIUBw6nLTI98EvlP1Dj/VaFGql1IMhzsVz0qiwaFY5yWBYrEAEr8zcDoFrE/k8zZEjw6Hw3ANsHLZnE8a2PQBjBxAmR+kGQlE9W4hHlYRLCuffC2flLTPnYjJuVwGrWuuXs49r9Cxa/zB5FVplbqN9mur1HZ+GvfL84Po6yDYMQZdNqePJX+yzLD4+i0HZNYLHvSuGillpp3jTCkYOQA1k7ktG7j/SFt8LBrhrcR2DwhuuDmSgfInNwzC+DZMABtgQ602zou1+wXmiCwlQVyjg7UX4aWFKkdp+8YZeEqaf5Mo/D6G5Q+2HGQmHSrhKEpdb9j5WuNDPxuDivtafr5J89h/Vdu2BIKJX/q3kDoK7q1w4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858eafeb-2b3a-4610-ef03-08dde58a8e35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 16:55:41.3169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeqkmN3Hjew382AMUhLfEp2LGSX2jZ3Og2qtSwxXNKNZickt+S+xINpNDaHetNm0txQlIaNf1+qw/KRt28t+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX7CWnwe/WKMD9
 YZOsr9qENI8MwgN6LJQG5ZVGiQlfjkSGtI+ls6PF4HjsSAc1+V1kPEVdTXaTqCB6B850FhSAgo4
 O20TucD5s5BQViTON8AwzjPenKFgh9/MDmkjuX/YwBCY5/nYhxoGJAABWT6tEMxmsluREBAnm9p
 hzflkuRYHqoUzS80iGc1p3SYV6vndF7/rjnjLmQggcrBqyb9l49NuKs3OQEFfbt/XwyEm5tKds9
 XhtH6Wl6qedZrZ04aZW+EpXVUZyJNPruVLoEDHPBYjEiPgcIRp4Y5jkCdo0Ziv0pqSht3TDgDIt
 D6709YyX8g7EJ8M2TSH1rZrNAZiDR1uDPomrB8eRnkFpgfM6Ybx37HiwjICwdyy1Dovu1YUDhF4
 g9oAXbg7m6sAYB/uDI312JLYpweKYA==
X-Proofpoint-GUID: OMtYH_5EjOm-P7QZKHiwRmr9J2wsiDut
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68af38af b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=SIGLTjqs26d-7YLF7WcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: OMtYH_5EjOm-P7QZKHiwRmr9J2wsiDut
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 8/20/25 3:59 AM, Eugenio Perez Martin wrote:
> On Tue, Aug 19, 2025 at 5:11 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>>
>>
>> On 8/19/25 3:10 AM, Eugenio Perez Martin wrote:
>>> On Mon, Aug 18, 2025 at 4:46 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>>
>>>> On 8/18/25 2:51 AM, Eugenio Perez Martin wrote:
>>>>> On Fri, Aug 15, 2025 at 4:50 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>> On 8/14/25 5:28 AM, Eugenio Perez Martin wrote:
>>>>>>> On Wed, Aug 13, 2025 at 4:06 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>>>
>>>>>>>> On Wed, Aug 13, 2025 at 11:25:00AM +0200, Eugenio Perez Martin wrote:
>>>>>>>>> On Mon, Aug 11, 2025 at 11:56 PM Peter Xu <peterx@redhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On Mon, Aug 11, 2025 at 05:26:05PM -0400, Jonah Palmer wrote:
>>>>>>>>>>> This effort was started to reduce the guest visible downtime by
>>>>>>>>>>> virtio-net/vhost-net/vhost-vDPA during live migration, especially
>>>>>>>>>>> vhost-vDPA.
>>>>>>>>>>>
>>>>>>>>>>> The downtime contributed by vhost-vDPA, for example, is not from having to
>>>>>>>>>>> migrate a lot of state but rather expensive backend control-plane latency
>>>>>>>>>>> like CVQ configurations (e.g. MQ queue pairs, RSS, MAC/VLAN filters, offload
>>>>>>>>>>> settings, MTU, etc.). Doing this requires kernel/HW NIC operations which
>>>>>>>>>>> dominates its downtime.
>>>>>>>>>>>
>>>>>>>>>>> In other words, by migrating the state of virtio-net early (before the
>>>>>>>>>>> stop-and-copy phase), we can also start staging backend configurations,
>>>>>>>>>>> which is the main contributor of downtime when migrating a vhost-vDPA
>>>>>>>>>>> device.
>>>>>>>>>>>
>>>>>>>>>>> I apologize if this series gives the impression that we're migrating a lot
>>>>>>>>>>> of data here. It's more along the lines of moving control-plane latency out
>>>>>>>>>>> of the stop-and-copy phase.
>>>>>>>>>>
>>>>>>>>>> I see, thanks.
>>>>>>>>>>
>>>>>>>>>> Please add these into the cover letter of the next post.  IMHO it's
>>>>>>>>>> extremely important information to explain the real goal of this work.  I
>>>>>>>>>> bet it is not expected for most people when reading the current cover
>>>>>>>>>> letter.
>>>>>>>>>>
>>>>>>>>>> Then it could have nothing to do with iterative phase, am I right?
>>>>>>>>>>
>>>>>>>>>> What are the data needed for the dest QEMU to start staging backend
>>>>>>>>>> configurations to the HWs underneath?  Does dest QEMU already have them in
>>>>>>>>>> the cmdlines?
>>>>>>>>>>
>>>>>>>>>> Asking this because I want to know whether it can be done completely
>>>>>>>>>> without src QEMU at all, e.g. when dest QEMU starts.
>>>>>>>>>>
>>>>>>>>>> If src QEMU's data is still needed, please also first consider providing
>>>>>>>>>> such facility using an "early VMSD" if it is ever possible: feel free to
>>>>>>>>>> refer to commit 3b95a71b22827d26178.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> While it works for this series, it does not allow to resend the state
>>>>>>>>> when the src device changes. For example, if the number of virtqueues
>>>>>>>>> is modified.
>>>>>>>>
>>>>>>>> Some explanation on "how sync number of vqueues helps downtime" would help.
>>>>>>>> Not "it might preheat things", but exactly why, and how that differs when
>>>>>>>> it's pure software, and when hardware will be involved.
>>>>>>>>
>>>>>>>
>>>>>>> By nvidia engineers to configure vqs (number, size, RSS, etc) takes
>>>>>>> about ~200ms:
>>>>>>> https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/__;!!ACWV5N9M2RV99hQ!OQdf7sGaBlbXhcFHX7AC7HgYxvFljgwWlIgJCvMgWwFvPqMrAMbWqf0862zV5shIjaUvlrk54fLTK6uo2pA$
>>>>>>>
>>>>>>> Adding Dragos here in case he can provide more details. Maybe the
>>>>>>> numbers have changed though.
>>>>>>>
>>>>>>> And I guess the difference with pure SW will always come down to PCI
>>>>>>> communications, which assume it is slower than configuring the host SW
>>>>>>> device in RAM or even CPU cache. But I admin that proper profiling is
>>>>>>> needed before making those claims.
>>>>>>>
>>>>>>> Jonah, can you print the time it takes to configure the vDPA device
>>>>>>> with traces vs the time it takes to enable the dataplane of the
>>>>>>> device? So we can get an idea of how much time we save with this.
>>>>>>>
>>>>>>
>>>>>> Let me know if this isn't what you're looking for.
>>>>>>
>>>>>> I'm assuming by "configuration time" you mean:
>>>>>>      - Time from device startup (entry to vhost_vdpa_dev_start()) to right
>>>>>>        before we start enabling the vrings (e.g.
>>>>>>        VHOST_VDPA_SET_VRING_ENABLE in vhost_vdpa_net_cvq_load()).
>>>>>>
>>>>>> And by "time taken to enable the dataplane" I'm assuming you mean:
>>>>>>      - Time right before we start enabling the vrings (see above) to right
>>>>>>        after we enable the last vring (at the end of
>>>>>>        vhost_vdpa_net_cvq_load())
>>>>>>
>>>>>> Guest specs: 128G Mem, SVQ=on, CVQ=on, 8 queue pairs:
>>>>>>
>>>>>> -netdev type=vhost-vdpa,vhostdev=$VHOST_VDPA_0,id=vhost-vdpa0,
>>>>>>             queues=8,x-svq=on
>>>>>>
>>>>>> -device virtio-net-pci,netdev=vhost-vdpa0,id=vdpa0,bootindex=-1,
>>>>>>             romfile=,page-per-vq=on,mac=$VF1_MAC,ctrl_vq=on,mq=on,
>>>>>>             ctrl_vlan=off,vectors=18,host_mtu=9000,
>>>>>>             disable-legacy=on,disable-modern=off
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Configuration time:    ~31s
>>>>>> Dataplane enable time: ~0.14ms
>>>>>>
>>>>>
>>>>> I was vague, but yes, that's representative enough! It would be more
>>>>> accurate if the configuration time ends by the time QEMU enables the
>>>>> first queue of the dataplane though.
>>>>>
>>>>> As Si-Wei mentions, is v->shared->listener_registered == true at the
>>>>> beginning of vhost_vdpa_dev_start?
>>>>>
>>>>
>>>> Ah, I also realized that Qemu I was using for measurements was using a
>>>> version before the listener_registered member was introduced.
>>>>
>>>> I retested with the latest changes in Qemu and set x-svq=off, e.g.:
>>>> guest specs: 128G Mem, SVQ=off, CVQ=on, 8 queue pairs. I ran testing 3
>>>> times for measurements.
>>>>
>>>> v->shared->listener_registered == false at the beginning of
>>>> vhost_vdpa_dev_start().
>>>>
>>>
>>> Let's move out the effect of the mem pinning from the downtime by
>>> registering the listener before the migration. Can you check why is it
>>> not registered at vhost_vdpa_set_owner?
>>>
>>
>> Sorry I was profiling improperly. The listener is registered at
>> vhost_vdpa_set_owner initially and v->shared->listener_registered is set
>> to true, but once we reach the first vhost_vdpa_dev_start call, it shows
>> as false and is re-registered later in the function.
>>
>> Should we always expect listener_registered == true at every
>> vhost_vdpa_dev_start call during startup?
> 
> Yes, that leaves all the memory pinning time out of the downtime.
> 
>> This is what I traced during
>> startup of a single guest (no migration).
> 
> We can trace the destination's QEMU to be more accurate, but probably
> it makes no difference.
> 
>> Tracepoint is right at the
>> start of the vhost_vdpa_dev_start function:
>>
>> vhost_vdpa_set_owner() - register memory listener
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
> 
> This is surprising. Can you trace how listener_registered goes to 0 again?
> 
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
>> ...
>> * VQs are now being enabled *
>>
>> I'm also seeing that when the guest is being shutdown,
>> dev->vhost_ops->vhost_get_vring_base() is failing in
>> do_vhost_virtqueue_stop():
>>
>> ...
>> [  114.718429] systemd-shutdown[1]: Syncing filesystems and block devices.
>> [  114.719255] systemd-shutdown[1]: Powering off.
>> [  114.719916] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [  114.724826] ACPI: PM: Preparing to enter system sleep state S5
>> [  114.725593] reboot: Power down
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 2 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 3 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 4 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 5 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 6 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 7 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 8 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 9 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 10 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 11 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 12 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 13 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>> qemu-system-x86_64: vhost VQ 14 ring restore failed: -1: Operation not
>> permitted (1)
>> qemu-system-x86_64: vhost VQ 15 ring restore failed: -1: Operation not
>> permitted (1)
>> vhost_vdpa_dev_start() - v->shared->listener_registered = 1, started = 0
>>
>> However when x-svq=on, I don't see these errors on shutdown.
>>
> 
> SVQ can mask this error as it does not need to forward the ring
> restore message to the device. It can just start with 0 and convert
> indexes.
> 
> Let's focus on listened_registered first :).
> 
>>>> ---
>>>>
>>>> Configuration time: Time from first entry into vhost_vdpa_dev_start() to
>>>> right after Qemu enables the first VQ.
>>>>     - 26.947s, 26.606s, 27.326s
>>>>
>>>> Enable dataplane: Time from right after first VQ is enabled to right
>>>> after the last VQ is enabled.
>>>>     - 0.081ms, 0.081ms, 0.079ms
>>>>
>>>
>>
> 

I looked into this a bit more and realized I was being naive thinking 
that the vhost-vDPA device startup path of a single VM would be the same 
as that on a destination VM during live migration. This is **not** the 
case and I apologize for the confusion I caused.

What I described and profiled above is indeed true for the startup of a 
single VM / source VM with a vhost-vDPA device. However, this is not 
true on the destination side and its configuration time is drastically 
different.

Under the same specs, but now with a live migration performed between a 
source and destination VM (128G Mem, SVQ=off, CVQ=on, 8 queue pairs), 
and using the same tracepoints to find the configuration time and enable 
dataplane time, these are the measurements I found for the **destination 
VM**:

Configuration time: Time from first entry into vhost_vdpa_dev_start to 
right after Qemu enables the first VQ.
    - 268.603ms, 241.515ms, 249.007ms

Enable dataplane time: Time from right after the first VQ is enabled to 
right after the last VQ is enabled.
    - 0.072ms, 0.071ms, 0.070ms

---

For those curious, using the same printouts as I did above, this is what 
it actually looks like on the destination side:

* Destination VM is started *

vhost_vdpa_set_owner() - register memory listener
vhost_vdpa_reset_device() - unregistering listener

* Start live migration on source VM *
(qemu) migrate unix:/tmp/lm.sock
...

vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - v->shared->listener_registered = 0, started = 1
vhost_vdpa_dev_start() - register listener

And this is very different than the churning we saw in my previous email 
that happens on the source / single guest VM with vhost-vDPA and its 
startup path.

---

Again, apologies on the confusion this caused. This was my fault for not 
being more careful.

Jonah

