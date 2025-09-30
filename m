Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845E9CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 19:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3gLw-0008Lf-2o; Tue, 30 Sep 2025 15:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3gLs-0008Kr-Ib
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:49:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v3gLn-0003DT-3O
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 15:49:32 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UIEcud007706;
 Tue, 30 Sep 2025 19:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=31OTJEUcxGhjHNJOVw2kHbai/hv+huksYTzmey8CVCk=; b=
 fQIcac8ueMapkScPugk8toBYUB8ggTa3H5LrxOU8y7UU2orNliOUO/D+UAmpzJmQ
 OCi5Kpa+HFD2QcY01t6BE4YmHUPDDU9C1MMucFFR1bUuv5KoR3pVEaWi5VwYd2SK
 qqhEMZf0Uu7MjoxMQhFqSGB8Q3ySG9H2Olq7COnL/BKdB8GzQGkOgkgGnnd3JUuE
 1zVskQduw/f8RxNCGoTtw9vpp/yzhg1iEMCcvg3lV3sfxgJHGhzIHUY06jxDVBD/
 YOHLainaioHqQQX4fg5StisOzEhfuwRapvoEZYyOBV2UBmCV3u8sEvb8narA4iwX
 HbnaMe6uUO6LhQ+GCMA3ow==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmacr5yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 19:49:23 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58UIgvl8000612; Tue, 30 Sep 2025 19:49:21 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6c8badh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Sep 2025 19:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afpWMVbDQgRwyvoWkzaNTo1vUmRvj6l+eaQi/fINqG8J+rnCUcwoZQnQANrwPUefr5mqgWBdfoUL47kM5imQADukg8EoB5jnxZN80dAENC/jIEbiwEfgQx6aFfPdLXZs08EWNUcB6cXEsqqB1HCuc1Z+oOAoJKgwSDjqPHV9Z65ZV1e9k8QUY4vi/14Of8zDiKctZqPa+wKRs5cOJj3AezsowgoYtiV2y0j9MjTVfWxRh3mL9fTrZkv5wHinxgS10Yho3GcjHPpSAOaT0SSZp1tMSs8DPHgrhIYVA0EKA/nqvy2Ozp/VesCSuz7zkS+Aw+2XOGS2B4NPPMwW0lHXiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31OTJEUcxGhjHNJOVw2kHbai/hv+huksYTzmey8CVCk=;
 b=o1cdJIpGkL9aC+lVggObPeG2PBN29IxUM5KVAmD8/k9a4pIjY+YS+P2VqBA8i1MoYX0DnMZmkeNEzteIJbDLVFtwQM6et/NNHqt1TkZFhf8DLkHsZ9iq9Hq5E4I3GDDmupTvAJahyyLGbGly/tzCgeyZcIbEwct9F4S9goVI0G0bjgEYoI9Tcu3ipKnOflifpbVR0Pcai2NHZexpDxC/kJ7BsDRpD8g/lQgmot8v4BW2oNKbkfGkUOWBPIcmA9KZdaN72B0gaOLFTlWJKs2gPKocWY9NJSNY1W8GEvu7TOo7IbL09wOggIBIuGztNy8DuwKIcRmhJjKlVQLCNfcBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31OTJEUcxGhjHNJOVw2kHbai/hv+huksYTzmey8CVCk=;
 b=LXkiAgU/8/yFLGZ4Lbd6KMrIljkOVTxNB+igsHE8NPmNekwcG3Vzv8R+IztUYiCY5HkDiVKiEQdKi4/WEh5RJapSk0Y1Ayt0mhT9LRwBKJ+PiDwqPu5tqy0Fj2jdsZNpXDlBFVEs/npwc0wESDxBhhO6P3Ovv0YBHe08XDcwpJk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BY5PR10MB4113.namprd10.prod.outlook.com (2603:10b6:a03:20d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 19:49:17 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 19:49:17 +0000
Message-ID: <9ce21a1c-5e0b-4d57-bc9e-1cb5bf978ee7@oracle.com>
Date: Tue, 30 Sep 2025 15:49:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/8] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <7bc0e3f9-f4c4-4088-8ade-4c8cd7c0835c@oracle.com> <aNwIXx_gqvvL1Ouj@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aNwIXx_gqvvL1Ouj@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BY5PR10MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 56a2e7d8-3de5-4b9e-2f83-08de005a70a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cndRY0VhVUx2RkF4VDI5RTBsbUNhRDViUkRlaExMMUtWWjJEUWJVRjJPbHAr?=
 =?utf-8?B?aXF5ZWxjRDhYYTE3Y09rcjhZam8venNDSWFVZmFjMWhZb0txVmNtRkU3WDJp?=
 =?utf-8?B?MmZnNE9TQnQ5bFNsK2I2Z3RhZEhnVXRVYjZQZzFyZ3Z3SnR1Sm5PZ282Y2Fr?=
 =?utf-8?B?ZWNEZ1d0WnpuODVUR2ZZTW9XVk5naWVNUXNEaDBzWDRzdHFteGtWU1IvRzdV?=
 =?utf-8?B?N2Vlc1doUUJqbXlDQTMxZmVNUEtJSi9Kbk96ekFNcFlTZk91d1NUcFFFOGFp?=
 =?utf-8?B?VmVTcElPWXVld0p0NjNUeWErZUlhVkpIRkdSZEcvbndtMDBaN2pHbTluVEVz?=
 =?utf-8?B?UUp2bEV5NnZiZzFibnFjcllTR2ozN3JVMFBPOVZHdWZTRTlCZlpRdlBBdDRa?=
 =?utf-8?B?NEZUbXVvS0NGOFFRaWZwckFtc3ZPa0dBaUN2YXNkaDJNNlhqb1oxbFFBQjYw?=
 =?utf-8?B?MzFmTkpJTTB5SkJ4VnNlZGc1c3BlV2lPMDI1RjI0dGxpM1psRy93ekFyTC9H?=
 =?utf-8?B?eFJ2NmdvcDE0Q2NFVjhieWlxYWZMZy91ZytqVC9sd3hLZi9NYWduUEFXdmVD?=
 =?utf-8?B?bVkxeFZ6Qkg2QlEwZis1RFNCcE90YkRUUEMzYlNqOHpRV1dlUlZONVdSKzBt?=
 =?utf-8?B?d1Q2ZnNaVzlBcG9JYkk4dVZLQ2VOZmtNbll5bjF5V0pnaVNvKy8rcFl2bStj?=
 =?utf-8?B?L3NvclJxc1FoOHBmUHdWNkc0Q2dtK3I1YVRoRU4wNE9HVGIxS2F0QTg5RUlZ?=
 =?utf-8?B?Wm02MS91Um9TN0FscVdrczMyUUVYZGh3MmVIRVN3a2hZWEpXNzZ2SytsWTgy?=
 =?utf-8?B?QjI2K3p6WGN1VW1lclFmQU9KMmQ3MzBRdUdSeFBsUnkreU9SRk9OUVNIeXVK?=
 =?utf-8?B?TmIyNFU0VUkzd0tCZ0U2RW1adVJqZVYrc2x3R3owVUFtbFMwT252dmg2YTZU?=
 =?utf-8?B?RmRVcDBuUDExNk1oYTlaQUsxOHdyWkJZVjdaeDF4elJBdGRlU0J5U1ZLTWZ2?=
 =?utf-8?B?NU8wMFlxVElpaVl3TFlBMlBrbDhCWVozUXg4YTJTa1c2WXhFM3h6MVU0YW5J?=
 =?utf-8?B?Vy9tV0NyTFJsWGVJWis5SW9udnlPTnF1cE1TbEJTR1pxbXljM0xuNzZKcmt0?=
 =?utf-8?B?dkxCZC9LVmJYOG94aFllK0ZLMkNwRHFlRmpZSndvKzQ2N0wwWWdPMHZmKzlQ?=
 =?utf-8?B?ZVhkYTR3SEltdVQ5UnBVU0V1c3pDa3cxSkF6R3lnbEl5VEhJRzltUkJ0STJU?=
 =?utf-8?B?OUd0Y3hPZDdRVHJMQWJYR284U0FFRkR1c1A2TG9tMXphN0R5d0Q0SHZhekhQ?=
 =?utf-8?B?cFhsNWZJejNCSVVxbERTZk5jQnZ2ZllEdmE2M0VwSWxPVnl5SmpCZkRRTC9n?=
 =?utf-8?B?YXZValJUd3N4ZzdJUmVzdDVyS3BoQ09KdTBSVXlNWWM1R1ZpMHB6dTlwOWVr?=
 =?utf-8?B?enR2YUc4OW9wUXM4ZnNjTzBHRGp3WnduaG9XdDdzcDk1VnFuaDVPWTZzSit1?=
 =?utf-8?B?NnVPTC9DY3dUZmE3aklWTlNCd1U1dStyT3lxbmhpRm4zUkoyb0laaWpxazVR?=
 =?utf-8?B?QnZodDl4RmFtVXdKVk85TTV3dGV6ZXNyd1k4dW12dTJOdjhOL2xmUnlPaDBP?=
 =?utf-8?B?Qm55cHNQcWVNK0pLQVZDVWpEZThydDdjbWtlNzlpbVZPSThhdS9kRWdWZkVP?=
 =?utf-8?B?TlptVENzSmUzS3o3WnVGRXB3VkJZTHNkSERZME4wSGJyTHR6Y0dnSVJqYnVj?=
 =?utf-8?B?WkxtM2VReFRDZXpGVE5hb1YwMTNuancrZUlpSFNKblBoeS9yTHJTY3FqOWxR?=
 =?utf-8?B?b2NmSGFkRzNNQklleUpPYnpvdnhzRU9VWnF2amNkSkE3WVJsWW1aWGZ3ZFpP?=
 =?utf-8?B?M2RCUTlrQmxDL2JpQzY1a2FQZDk1bS9tbEFGbXlYYjNrTXNNTVJuc0hEQjRr?=
 =?utf-8?Q?XRqwT2Gw7LSmGIWb/IwzD9OtiviXjn9n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2hHUzVwckFVVVE5ZnAwSHlEMDZrWSs1d2JHeHVIYysrTUZUaXJHV0VDS3I0?=
 =?utf-8?B?YmhDdHFzT1FLVnRIT2E2RlNNV1g0dWk4T1JXQlE4K0UrTkVrOEZNaDhRZzk3?=
 =?utf-8?B?OTl2RlRIazd5clpWUWU0N0tQbFRGcVROQndyTGtvbGdiU0ZZUmE1VURMRTU1?=
 =?utf-8?B?bWdVSTV1bzBGVEhOUk1CNE9xTW5UU08rM1hvMTVGSWVyT1hwdk13S28yN252?=
 =?utf-8?B?ZU1UREs4eXlVVGNiY08rWGFWMmRuZWZIaEpPVGdzT2ozbHdJSlNkUUkzZWFk?=
 =?utf-8?B?WDk4ejFIeUVkMG5SZkI0aWhNb05ZSDdqbmdpV09IV0gySmZCdFBOQUJVMkNY?=
 =?utf-8?B?N1d4d0F1azV0YzRPeGFNRUZQRFQwK3pHRmZQZzlxZnRGd2VPWU94c3c4QnU5?=
 =?utf-8?B?TTVBbmVFYVJlbHh6bUZKQkE0ZW9HbnV4NG9LVmpDem4wOE4vQzhWNE5kVW41?=
 =?utf-8?B?d1dMQzFLdjk2UTl4U01NcHFQbUJ1RTZIOGYzNTZmRWVsczVZT01raFJ2RXps?=
 =?utf-8?B?QTNIWFIxMTBtYW54N0N6bGFkYmhmN3JNVWFoSUJKS0pXQklhOXB0Y3F5ZDJh?=
 =?utf-8?B?TE5wYklqTUNjM0c3N2ZDcmNsYmN3Z3J1MG9TK3lBTkVNWGl5VzNzVnVJNUUx?=
 =?utf-8?B?RUwwZXIyRDEvQ0txQWllUVFaOXc3U3BZeTNJMTR0RjFMMW82UVJpc0NBdHZN?=
 =?utf-8?B?MDJGVk1YbWltcmtRR1FkMW1aTFRpbXlZNUlSWVNGUzdCYWNGTy95UTlnK2Fq?=
 =?utf-8?B?OWt1Y3k1ZU1UeHhxdGgxb0trUGNmZVpnWlo3LzN0ZEZnMXFZT05UZ05JTU1O?=
 =?utf-8?B?a0dIcnM5SWVVRUhWMjY1V09GNi83VWhNQ3AzS05WNThYTEtiL0lhelJ5dmdt?=
 =?utf-8?B?K0tNMkY0c3Fic1NsVXZ5VzgxY2hLTFgrdmpRbzljTkdzbzBBVWJYSXZZblJr?=
 =?utf-8?B?STNZTUp5djQwRU9XWnJlWnhUclR3dmZ4ek15dDM5SURBcklOMlYvWFJHV3Ja?=
 =?utf-8?B?T2FPQ1greW04VzNoa01DSlVtakxDZVc0L3VQVXBjWFhyaEFZRE56c2tXKzJl?=
 =?utf-8?B?K1R6Nkp5eVlwU0Vzd3ViSnZJb2NZNVBCdndIZ2dVdVJPMUxDQzl0eHFwOXJx?=
 =?utf-8?B?MnA4SWhmNk9VNWJQc01XUFdEeTRpNWFwelNqMXgrQ2JNNDYwbFdkTmhuZC9L?=
 =?utf-8?B?V3YvZzdob1IxSkZWNTdrRHRsOE9lTFcvMGRnejd2RGFQVGZUd085WFp2VzN2?=
 =?utf-8?B?RHZKTUhsQ1hWVERyUkppYU5mdmdaVjZPOFd2R1p2Zkk2Wml3NUMxQ0VSUVBQ?=
 =?utf-8?B?aWJYMTFvVmZDUXlBVjk1aFkrKytnUE5ocXJ0WjlmQzQ5czNXRjAxdHloZ0wy?=
 =?utf-8?B?QkMrdEpHTG1KZGU4Q2JUeEQ4S0FWcGVIQ3o0QUM4cURseVFnUExpWnp6NnY0?=
 =?utf-8?B?NVQ4dXpQY01WNFY2SXlpUlhFbk96TGZNSW10OTJJeEZKQjJnbXZGenVkQTdX?=
 =?utf-8?B?RHJMVGUyOXFTeFg5cEFlL01uV3VFajdtVVVEZlF5a0FocE0rMWl6eEVKZnBk?=
 =?utf-8?B?VnVkWWRKNWRiN3N1YkNRQ25WSjcycFpRZFEvQnY4YkREY2JJRm8xU1NmN0Fl?=
 =?utf-8?B?S2FNMTBHc0tNSW1HMlZaZ3hreTZ2eFdESExWWTc5MXprTE1JTjFiVHFyMTNo?=
 =?utf-8?B?SkM1U1E1a3FzTm9rKzZRQklERG42bUFQWXBRU2FobE45bHk3ZjNUdllPcHBS?=
 =?utf-8?B?QVZvL0M2clZEdVBIUk5RcTB1bjVwS3g1VWtkN2JZYW52bE9MTFdrdytzWDF2?=
 =?utf-8?B?eXZFZ3J3VnBkZHFwU2wxdDIrVVc0N0RycWgzNEN2UlQvT3RFdE9IYVU3OEti?=
 =?utf-8?B?MWRNZ2ZOUS9TVWY4UGFrZ3BBRC81cm13TzE4dllXdlV1THpVRXJXZjRpMkgz?=
 =?utf-8?B?SEsyTzFCZ2FmZ3J5WXorV2Fpb1RuVXFOdVNpQTdiRlZRQXFxcW04TFM2R1h0?=
 =?utf-8?B?S2NzTUVUTHhIQzJIMHdSS2Z3UWlKMUNQUU5TZEsvRTc3Rk1rSVp3OEVFdGdx?=
 =?utf-8?B?ZndiOGY5U1JuTWhHSnVBYjdyRmxPUnBMZHFKRkhsVlYxRVZLUUNZZHZ1UVJh?=
 =?utf-8?B?VDh1R1QzSlQ4Wk5IYU85eVpUbTArQlF4Q0p5ZDgreXZZeTlLckFpYnV4UFF4?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7xw7ISsVBwDtrx5zuhKhR77mwf+92RdMZ9H/+bHtJ1QLUthxrK6qvSQwCHi4c1Td+3vsu2lkymd8ofIZmRP8b+ifNwr/UCkC5hPgjxBR+qFHUbKhxtlShGRAnjYWI4odAiO4FGtLDsyScFWTFTWio26toLyAtNkN94BQyLggdEAT0xHfzTWiqfiwYpy3wUuvW+dtTbe/8h6eiZuEAmHpBHqGdxHjFRHDshWyaCoaOomPEG1fvncUCNdfs2aTNmoWfvaITf5pN7wWNvaCijPaXgMMDJ89cnGYgIe0CsolhALVEhqCDqkfNWTn6fkLYLRrHAEo1r/len+qcXQuAnRHpZ49BIGqhHw2UslYsAfe/Ae8ulnNM9/lhfT3hvD0yXbofh2TXRAW8HqNuJ31Y+sR13eYnuYVHpOckHrvDY2eeZBFHmm3H5XRWMBJi033NglEeDXusZNSOAUc6o1mgtDnV9lLrJX5n04WIMnFlWa7m51ZNfTWMQcVdo3ujjhfAHLO/q1ZpvOlpdRTsIX9owW+aslW4oT8wuu2Ew3RIzD2sT8jmxfcW1W4m5KXAJRdwUBwwzIfcHAAQhVDNhnARbqFqGLRYWT64v19XErSZePma/s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a2e7d8-3de5-4b9e-2f83-08de005a70a7
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 19:49:17.2628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inms1Pwz4ldFn1OL/eWo1/ydIJ8CQDJkp/e3XX6eq4QpJkP8tWzTst/4as/syQeStYNitFkU5La6891eNAf8mdhC84gYRe+lfilMEJhIlFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4113
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_04,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=871 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509300180
X-Authority-Analysis: v=2.4 cv=P5I3RyAu c=1 sm=1 tr=0 ts=68dc3443 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=SS84QB1fohumvhdZw0wA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12090
X-Proofpoint-ORIG-GUID: 90_nXTP6fqH1klKYw6oNPPTL3eFJfyIp
X-Proofpoint-GUID: 90_nXTP6fqH1klKYw6oNPPTL3eFJfyIp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE2NSBTYWx0ZWRfX7JivBuc2hHQt
 TyrtsLIbkqHMnkHYoMo+z/JHWLGOHPL37MP2pQpwZT1rYtfFkSk4TgUIHa7TX830CnpUYxPBF7x
 eE5sqSJEFFLCd1EDZ0fH8ReIlH1SCqOtaBwKttHIM4llKVuuQjAZK4Ysj6v23Bq171QvNWYiYQ4
 sR8EcZJEhfkAM/z3m4PS0DH2YhVsta26PDkjPd0uSB/4RN2XIrR4po2MIL9opTBUACaVm8u5uof
 HLMmOpU+76SHRxsLNMN21qMxYZ/Xy5WwQNBUCkiluyJUe0Th3p+y3bIwdfutYkjd0uolRWnqQVu
 0Zuq8MCE1UJ60dZAOGqYHyAYyPVfdWZKOUUbqRVosZRTn7os4by63INasdEVJKIbLWslnexGcPk
 blU/40YSgo0OVeVfoDxDJMwLkCMPVRg+4OGis1PC8YKzS9sJRlc=
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 9/30/2025 12:42 PM, Peter Xu wrote:
> On Tue, Sep 30, 2025 at 11:28:58AM -0400, Steven Sistare wrote:
>> Just a reminder, these patches still need review from Peter and/or Fabiano:
>>
>>    Patch 5/8: migration: cpr-exec save and load
>>    Patch 6/8: migration: cpr-exec mode
> 
> I read them and left some comments where I have.  For patch 5 please
> remember to include the header that Cedric pointed out, because it does
> break the builds.
> 
> Other than that the series looks OK.  I suggest when you repost, have the
> testcases be together.  I saw Fabiano queued most of the test patches, but
> it shouldn't be an issue no matter which lands first.

If I post V5 with the patch "cpr-exec test", and it lands before the
other test patches, then V5 will not build.  "cpr-exec test" depends on
a handful of new test functions.

- Steve

