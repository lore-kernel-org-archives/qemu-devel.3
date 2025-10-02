Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D8CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 12:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4IgL-0003V3-Ut; Thu, 02 Oct 2025 08:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4IgB-0003Ud-BJ
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 08:45:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1v4Ifv-00010K-1j
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 08:45:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 592Bg2C4024924;
 Thu, 2 Oct 2025 12:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=corp-2025-04-25; bh=1vqwIgfYLjmT/6vCiE
 heOoBH+WVfdYmoElJuZYbKC/s=; b=enJ2gvbPaNtol5DdZjy2HYL+jz1DNVUziu
 TGyv4KUFRcLjYQlKj6JAdUOc/lOTnczgBx7++MzXLQlxWcapHL7Q5W2Lt1IIyc6G
 y2LcgXgT2XZ0ttVpaa5Gymg6n9r+/B3XIkGBVjQVhW7l7eI6ylAOg74dP5gBFeBU
 z2jgKpc5hop+gEt/E1ztUTzR2y+O22negpK8KTpEEaK1OiC+zgEsc7ifDe0Cruzf
 7rJCFxR946H1hH2QlZJcqnkrntNKjrISksn25xiYIIhCV48IRnd12YOGo3DK0I85
 zysEtM13uqur67b0Wgp0HAAFMSF9V8o+o6OtlUHNIw6JY2RIMyTA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49gmrfu6vr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Oct 2025 12:44:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 592BdCZf036129; Thu, 2 Oct 2025 12:44:32 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011002.outbound.protection.outlook.com [40.107.208.2])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 49e6cakb63-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 02 Oct 2025 12:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVrDGTdifq5HE2I9ZlXRr8e8dl4rqoZ62RSoUzp0DbajarMmcu7ffLwmr60wlXYKmv7hos0AC4qai/I0XPrXdkfcWnx4UJcEqXVg8BiISVIL7Hq7PL6Ws+ci8tMWTbU5ubVE2fHWLz0W3kSojZQpY7rjx1lbVxm0/NvXS5iE1IwGBzCyrHrhTMdWyzj4ANPHbpqRGkWuFNk9DphEFCb1yPE2t3nzrxy8lQGq/CFDng3+QCyykO8/I8WkIzeQuZ/U2ywVyGNUCeuXu398DyqKYhr3Kzey+kO5ARTvIAxixUvjCHfrKu94C7VngLJVr1IsSg0MMweD3vtS21f9VFSkUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vqwIgfYLjmT/6vCiEheOoBH+WVfdYmoElJuZYbKC/s=;
 b=Km4E0YRSmfmcNz/jg7WQWb8iJmzz1u1KkPHGhOdLfbQxJ+LeUWOHfQUcA5+3tnhQ8hiTqitf5HuvobIuFKZTNatdVYt+NIy/m7fkGE6/P0BBXNZOceIO332+cEamNRj+xMcT3uctRtx10+yKcJWO9eZhFAgJK2AAnIYD6mfb7arFA/4dgv4YT3mi2z8YbYp83CLWkEjd3JO1aJmMKaU9ofP90Eu44K1TfBqr25lzl01qbD5cm6ApVKKCtUCCIq8bXMbEKQ4SwwYgflCT4ZHwdVF7rBvWF9psR/8+2rOjTJTWBMs6YtUm1M6mDJ66xoraqFkNe53AYIS1Zochki95OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vqwIgfYLjmT/6vCiEheOoBH+WVfdYmoElJuZYbKC/s=;
 b=RF4EEI2i4+8drON4Bs5M+E3JXRiO+qBcLHdjP6wPmi2cDcqOXYco1yz4G/1NaCcNFkwS5/UH12hxXT7Yoe00J7PD8i824ZFXSjgxWTICPN+NyZAfmzA1umHj1zWT9CTBqOALEPf2qTi9x5XkYu0qasJAVLeBGuDpG4SJhOcL7Q8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 12:44:24 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 12:44:24 +0000
Content-Type: multipart/mixed; boundary="------------gAYZ0XdJXrKBYt7ORz9FExFW"
Message-ID: <30750362-d4a1-4392-8dd6-016624d01be1@oracle.com>
Date: Thu, 2 Oct 2025 08:44:21 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local> <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <d91186b6-24d9-4b3a-a4c5-d68445c267bb@oracle.com> <aN2Je6JssrN1otuQ@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aN2Je6JssrN1otuQ@x1.local>
X-ClientProxiedBy: PH7P220CA0082.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::17) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA2PR10MB4715:EE_
X-MS-Office365-Filtering-Correlation-Id: d18508a7-a65f-4b88-1561-08de01b16ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|4053099003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWZ3K3hibmFuUlE5V3RmK0VETFE3QnA3disrL2t0Y3BqSjZPYnVxZGNLNnNJ?=
 =?utf-8?B?WTVyQklwbldNZi9mVDY0UndoZXF5TzlnYVJ0WVVtY0hFbnBlY1F2a0JITnBy?=
 =?utf-8?B?dENEaC9rV3dRbzdUVEs3bFdWVklCazYrZ1lsYlg5VUk3b1BlVnB5OGNqTndD?=
 =?utf-8?B?Q2t5WW1zeVdDODJSU2VKczNpQ1BvMWVrRTR0YzhMMGM0YW9jTEM4N2c2SjZ1?=
 =?utf-8?B?Mm5XQXZiOHArQXhRSHltZm5NVDlPbkI1L0M5TXI4aU94QUQxcFdYQi9BQ0gv?=
 =?utf-8?B?U005L3g0cVFNYmEwZDBITHU3dEZOVzJXNFlyd0ROS05kbWQ2VFJwWFNsOVh3?=
 =?utf-8?B?elJnNm8ybHpUYkZIbHRmaW9wWFV4SWJYSUtRa1JwRXNmL00rbnVmL0hRUWVO?=
 =?utf-8?B?c2NnbHVvRGpCWUIxd0RKZDVyZGxGdWsxMUpjOTN4bVIwSlhwL0piaFFHblEx?=
 =?utf-8?B?UVp1elpHc1JRN0hwVlZFU291b2hTc1JMNEJ1RjFoVmgxVzBOQmxDNGlIemY0?=
 =?utf-8?B?U2daakRJWGZuSDVXQXFzd3BuOWNtTU90TFFYS1dBR2NsUTZXby8raHdFakNY?=
 =?utf-8?B?Qm42T1F2S1FsNk95Q2Y5dDJhRnc5ZGdER0pYbnhiWUxvbTNYRzNrMXgwNmsy?=
 =?utf-8?B?TWZwbjB5czRpdVpYc1Q4b1llMVFlc243RTJNekhqdERFdzI5U1JiaGh6ZmJC?=
 =?utf-8?B?SlRSUk9QU2tjaE5sMUhWZHpSZ0NBb3BKWHpUL0dKT3J4cjUvemEyYW1OaVlz?=
 =?utf-8?B?azBNNHhNQWhCakpQQ3RiUzVzN1NhTEVXRkxjR3lhN09aak84V1V6aG5ZRVg3?=
 =?utf-8?B?bjcvTVlIRzJKelhZS3hVUElNWlZHbVVoQ2ZYemx5OG1FSDVmOVVDbFM5eVN3?=
 =?utf-8?B?TllqM2FaOHRsSVZUbFhrbFpqYU5SZWVUU3Awa3JUdytKZm1GUkpDbEx0Nzh6?=
 =?utf-8?B?d3J1L1lvY2d3MDNUbmxSeUl6RGJLZWtldDVsVDZVOGJEa2JNQ3RGUVpLa0pL?=
 =?utf-8?B?RzJrTjAzN3ROQ2NIWlkzd1kzWTM0SXRMczNzMXVDSnYrNVVnOVdpbXhZd0dp?=
 =?utf-8?B?cGFERThONXdFMWkrRUdOeGEyWWo2a1FyYVEvUlNSaFhGeTZOS0xVWFN6clUr?=
 =?utf-8?B?QTl2VFgvanEvNENmRko3V0puTExhaGMwTVhhaXBkRjlPYVBwWDJKNno2NHRz?=
 =?utf-8?B?aWpvN0M4NjZvRUdTSXcxejRteUJTdHdLdkgrMjBudDVqZ3pURk1ZVGFFVDcr?=
 =?utf-8?B?VHB0SzV2TytseHJ4OVhwUU1EMGpadVJaVEdBMnVwanZycjZRYTIzUy9TVlNK?=
 =?utf-8?B?QkVJZmp5ZXdDbkZlSUN1Ym1SZkdlM3pnSWZkb2ZGSElPdWhJd20rNko0UFJm?=
 =?utf-8?B?NnlRa0k2Q3J2STNVWnlGaTN0WHJwZjhFajZnQmVJVzJkSXhrQ29kaEpCSXVT?=
 =?utf-8?B?czdRNXRhc3BNcDg1THZSalhKWHc5M3RjKzRkVmtVZVprZ2pDQ0JLTk5Md1hK?=
 =?utf-8?B?WVIwSi9VSmYwOUpqSy9HL3VLRkVpUFk3M1NUZS9ZUXI3SWpMSmtncnNYV1py?=
 =?utf-8?B?Mzc4WmJhOEVqYzlkK2J1eHBCNUd6RlpZd0lDRVM3cjF6QVY1eW1IZ0hpcndG?=
 =?utf-8?B?Q3I5bFo1c2VXbWJheVRyak9aQUhNZitONzFYR2ZCODY4SVpnRGJrcHpFM0w0?=
 =?utf-8?B?Tjc3Zkd4Uk9CeGNVODVsZGo1MW1MZVJlYnpaT0lOemswaUFvMk9nSld5T0VF?=
 =?utf-8?B?dEFuZWI4QTRKRVVic2JPSlo5N0NrdHEzZ09XSzA3RkpLR1dONE8zcExrRmM0?=
 =?utf-8?B?SSt2L1VtT2prN2VnTWVjQ3A3UHA5aVFlZmRuM3ZPb0lLa0RpTGJQUWo3V2pl?=
 =?utf-8?B?YW1lU1FDQURMQTM4cHREUm5yVVN5Z1NyMGZmOGw5ZExSMlo2YmFxS1YrTVgx?=
 =?utf-8?Q?dtR04K5zN5l1u33gWID7OVIg/16bGuHC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(4053099003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmtQU1BjUTZYQWlWNVV5MkdPeTJuSkNXSUhWbzdFVU56S0lrV2FhL1lPQVlW?=
 =?utf-8?B?S010VGRhdzVZbGt5SmhMZEEzdGN3OHZ3ZVhBMzZRNGcxUnM0TU5LRFVuRzkx?=
 =?utf-8?B?TWs2SFEyc3JzZXFRY29oa3duM0xYbzRiMjFqejc4TXJYMnpHVFNTaTMzNk50?=
 =?utf-8?B?WmJyTTJzRXI0MnBVWDMwamhRNktnY01BNGdkRlFjZjU4Wlc2clRIck45aUpO?=
 =?utf-8?B?aWJnWHM1eVlOSDVEbk10dEtlVjZKOU5ac2NrOU15TjJxcUhGR1YwMlNTSTZx?=
 =?utf-8?B?QlYzOU1CaWFVQzlkVytnaWxKajAxdnI5QTdxV0drK0Z3b1ZsK3JtMmxHT3ph?=
 =?utf-8?B?STZsUVk1YmhMdjV0UUZzMGJORTAzWlI4K0pYN1FBQ000U0JlRTU0M2xNSVRG?=
 =?utf-8?B?eGZ2ZU5EcHJKNyt4SWNDOU9wdXlZZVFOMjJQTWJCQjF3eTJVdVFQQjlaQWUx?=
 =?utf-8?B?eWd4eDFyajZJdjRxOHVqOThTR1cyZE0vdHgzeC9lTElFZVEyRmxmR2pLL2tT?=
 =?utf-8?B?NWkvU0R3NXBGdEV0SmJOYUdxdmlOU1BXdFgyLzRtZU9hYWthdndVOU4vWmVL?=
 =?utf-8?B?QjhnKzBuR2YyK0Vjejlka2p3MmIzRGIzUzA1dDkwc3RLc0hGNnpjdkQvMUli?=
 =?utf-8?B?bmpCcmx1Ty9jU0VRTVptRExOcGhCVGNFcFVIZjVLL1Q4bkdsS20vUWRvTk5G?=
 =?utf-8?B?ODljTkRlQ2FPcTYzM29KNFVYMmNNWFVNaFRmTWxIb0tJRWttcElQWWFnbnN5?=
 =?utf-8?B?cGVPNTBHcGg5MkZQRFJKT1NjRytTTVpCa1JhYW9hKzdibC9IQzNMcUIvWExZ?=
 =?utf-8?B?cW93aEVpVU5VczVqcW1NR3d1Z1UwbldQVHpFY0I0czZ2cnVPdGZhWjJGMnAy?=
 =?utf-8?B?Y21iOVkyZzRxdWJpbGJ2eVk0aERUZU1XTWRYWFM1UENJTmF5a21aQ3ZHWllG?=
 =?utf-8?B?ZzBvVGF2YVl3TlZ6Q0V0VUw0RlJaNC9DNSt4dVlkUi80dDRKMEYzblVsQjNV?=
 =?utf-8?B?QzlXZ2pTbTNEbjVoMUIrR2p0WW1Xc3MzRStncXVSbkRWLzdPUFIrYUJMWDNT?=
 =?utf-8?B?UU9jZm52QS90YVd6L004Ky9XTGVWZENLQzNEdmNzeVMrN1QzR3FaOE4ramJi?=
 =?utf-8?B?WllzU2FYL2NCMFV5VHc2d0hlL3RFbHlhcmg1YlZIR2lrRzE5QkxXUHdtSlVm?=
 =?utf-8?B?NlBnZWlSWHl1YVNEWjRSNGlxWFVjYk44WXBCK25vRUdxQVlaR1FXM1lPOTho?=
 =?utf-8?B?RngwRTlEcTJkZ2U5QmlmU040S051a09BUGo5cDQ0aWVwa25CQnUydW12My9G?=
 =?utf-8?B?MFNqREtHNE8yTVZCWC9uSjBMUHlFZlg3UDdITkRUVnU4cUFoNU9QTWhkK1JJ?=
 =?utf-8?B?ZVQxTjc2dWcvQi9nRk1YMllmb1RNaWQ3c04vT0xYM243cE5BRUQzNUNpV0VN?=
 =?utf-8?B?ZXhZSUJMR1RtV2cxaHUvOHdCR3Ztc2IwQjdHSlR0eUorRDZhVzVITEFxbnU5?=
 =?utf-8?B?Ym1lNXdjN2MvS2FNelgrM3MxaHBzRTlFelI1TWNLTFNOdllEZzFPQi9oL01l?=
 =?utf-8?B?OUp6UzJwTUZFTEtORnozMHFDNXpZQU1tYjV2Sk1acWJ5OUxYanlGbnlIajZs?=
 =?utf-8?B?OFRXOCtlK3k5R1hnM2dPejkrVXdmNlNDeXYrdVByVVZPbW8waFd2aVppZzE4?=
 =?utf-8?B?emNENHV1Vm02OFBkcTF2YzM2N0xnN1V2ME9lcEZ5VzltZlFxdlF3czk1MndW?=
 =?utf-8?B?Z0x0MWNiWG5tSkFoNzgwZXlUNVZNRTY4dDREOG0rQ3MzVWtMRzhlYjBPN3lX?=
 =?utf-8?B?YWMvR282dENDNzlEd3VUTGpTMjRIOWU2aU5lVDRFczYxVzU2S21tNTJub0Va?=
 =?utf-8?B?Z3AwdkxJWkhiYTFCMUNYWGlxeC92dko0WVczY2txSG5XVVRIU2FOdmRPWlJa?=
 =?utf-8?B?UmxoUlpDSE01a3gxMzFXcEdHR3E0ajZjU1JQTWIrODVUdENHbDVSakNkdW1Z?=
 =?utf-8?B?WHVXd2lSSmVHSml6MUxQUWJyRjRQaGpmakVuV204VDJUTFlIRWk3Y3lNWmRL?=
 =?utf-8?B?Tnp1N3RhVHIwSkhMRGZzeUY3ZE0vUWNkRVdMTnpUTGFteis5bXVMSjRWUC9u?=
 =?utf-8?B?QU1pK2RIam1OVEpQZGU2aTJCQ21aZExpVW9kZHU1ZHg3QlVHSUpDTDFZQXR2?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MkMTqaPgYm3fXrodYvcUbusEt9Ux446zKyYavpjPYn8bRz+pAI0df9Eebee6padn+EP7+C2SqWlEiMAcF2Z2t3YBUSAIdz5jZSTsswI1gBpTcO29iYNNM5wlzRAhlo1owaQYVjEa4KoYMu09TS35O6cz+uSVAvZgdQp1QnRYl3CqFAWf6n40kquPK29DRXp/HZYqPriO1t61jl0tYPm5T26CrdTS4B2W+nUjhR1l/AM9psTv7GL3M83UsvfUVrlSX/oYb+7yTgiEmLkDqmQ1stUcYH9TZiRCwPF3+K2yPGo0cyQIGN2m/RyAuKHmT/9CTZ0ytTZG/Tj/bkXFZ91CLovZK8A+MXXuAKQGvg5/cyfajD9+YYyfiNPikyuw4R89B6V3tAMMmw5VojMK7sQQSEqhzVzkMW3oD7AeKvA6dRPFLCwXvPE5HeIH+4yVHc7bWwhA3kqtOEoXlQsY/D3tbVptDIc0V+az8S8RsdHhXB4UUzuwXuLbdj+CTfB7dKeB+F7NHnHWS2FvoTZuguyGn2mer6EndpgZN51VqahZQwXQyMJd5j/jeBE8TYah8SLmYsMisXLBTHTW8GT47YUWGHRnJYu9eNw4vhkRHNsKDj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18508a7-a65f-4b88-1561-08de01b16ab2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 12:44:24.7156 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7poO21M3SdmiEfURwzPw0WPUvqrzdodvORpoJtA2FqVE5PZNu7F8l0IxWO+A/WFJZknXYTUt+lvIk8CJbpZjEhuYlbMiECAmE7cjWUrCY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4715
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2510020108
X-Proofpoint-ORIG-GUID: VJ__iSRGZeTdq5XuIAbASTkG7OYlft-n
X-Proofpoint-GUID: VJ__iSRGZeTdq5XuIAbASTkG7OYlft-n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTMwMDE3MCBTYWx0ZWRfX89HDXmwTSsPK
 Y86S7m950mfrLGMO0iPTAa24h3GgvOcMhzhjFZ8PxbMgjTNtIfZmjTx6bdhL5A+5I814CBdAFf4
 N6d6FuxE6aH5LTW37GSLLlkMleWk9jemMMKX/GumFOXYapYYObSNGDWlHBWdb6ZRSlGj0jcx8PA
 ABXofsgPy7EUctWuqGu64ywWLdDmSYbncN6mIsacS0eK6kjFH1rkRlbb4mnvURbkcR7ooW1QMsX
 7rjhHMYqmX+rZfRFQCVYQoRklczaw2Kz8ISJ9QZ4jqCq2hApo+y1qyHA5DOXrj6qUOt/Q+iHYAK
 5pKZrn0U8GOhDHGwCVHyZF3tfOdOnPafICqsVmNitDG7IIs68XO3PK+yHT+shVchmfGYIwyZuew
 /IvAZiM7sYpzsU6N3jvBaRFOUoxvwg==
X-Authority-Analysis: v=2.4 cv=VpMuwu2n c=1 sm=1 tr=0 ts=68de73b1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=ifRTcy9DBJjJqmtr6foA:9 a=QEXdDO2ut3YA:10
 a=V7xkzyaGXGj9tJ5OYwUA:9 a=B2y7HmGcmWMA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
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

--------------gAYZ0XdJXrKBYt7ORz9FExFW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/2025 4:05 PM, Peter Xu wrote:
> On Wed, Oct 01, 2025 at 03:24:44PM -0400, Steven Sistare wrote:
>> Actually that was easy to resolve, not worth a V6?
>>
>> In patch "vfio: cpr-exec mode", drop the change in container.c, and instead
>> add MIG_MODE_CPR_EXEC to container-legacy.c here:
>>
>>          if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
>>                                        MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
>>                                        -1) < 0) {
> 
> If that's the only conflict, could I request to send that new vfio patch
> only, by replying it to this email or that vfio patch?

see attached.

> I can fix the win build.

Cool, thanks!

- Steve

--------------gAYZ0XdJXrKBYt7ORz9FExFW
Content-Type: text/plain; charset=UTF-8; name="0001-vfio-cpr-exec-mode.patch"
Content-Disposition: attachment; filename="0001-vfio-cpr-exec-mode.patch"
Content-Transfer-Encoding: base64

RnJvbSBiMzVhNTg4ZDZjNmQwZGIzMWE1MDMyZjIxM2E0ODI0M2M5NzBiNTg4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lzdGFyZUBvcmFjbGUu
Y29tPgpEYXRlOiBNb24sIDMwIFNlcCAyMDI0IDA5OjMxOjUyIC0wNzAwClN1YmplY3Q6IFtQQVRD
SF0gdmZpbzogY3ByLWV4ZWMgbW9kZQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzogOGJpdAoK
QWxsIGJsb2NrZXJzIGFuZCBub3RpZmllcnMgZm9yIGNwci10cmFuc2ZlciBtb2RlIGFsc28gYXBw
bHkgdG8gY3ByLWV4ZWMuCgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBTaXN0YXJlIDxzdGV2ZW4uc2lz
dGFyZUBvcmFjbGUuY29tPgpBY2tlZC1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQu
Y29tPgotLS0KIGh3L3ZmaW8vY29udGFpbmVyLWxlZ2FjeS5jIHwgIDMgKystCiBody92ZmlvL2Nw
ci1pb21tdWZkLmMgICAgICB8ICAzICsrLQogaHcvdmZpby9jcHItbGVnYWN5LmMgICAgICAgfCAg
OSArKysrKy0tLS0KIGh3L3ZmaW8vY3ByLmMgICAgICAgICAgICAgIHwgMTMgKysrKysrKy0tLS0t
LQogNCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci1sZWdhY3kuYyBiL2h3L3ZmaW8vY29udGFpbmVy
LWxlZ2FjeS5jCmluZGV4IGMwZjg3ZjcuLmMwNTQwZjIgMTAwNjQ0Ci0tLSBhL2h3L3ZmaW8vY29u
dGFpbmVyLWxlZ2FjeS5jCisrKyBiL2h3L3ZmaW8vY29udGFpbmVyLWxlZ2FjeS5jCkBAIC05OTAs
NyArOTkwLDggQEAgc3RhdGljIGJvb2wgdmZpb19sZWdhY3lfYXR0YWNoX2RldmljZShjb25zdCBj
aGFyICpuYW1lLCBWRklPRGV2aWNlICp2YmFzZWRldiwKICAgICAgICAgZXJyb3Jfc2V0ZygmdmJh
c2VkZXYtPmNwci5tZGV2X2Jsb2NrZXIsCiAgICAgICAgICAgICAgICAgICAgIkNQUiBkb2VzIG5v
dCBzdXBwb3J0IHZmaW8gbWRldiAlcyIsIHZiYXNlZGV2LT5uYW1lKTsKICAgICAgICAgaWYgKG1p
Z3JhdGVfYWRkX2Jsb2NrZXJfbW9kZXMoJnZiYXNlZGV2LT5jcHIubWRldl9ibG9ja2VyLCBlcnJw
LAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNSUdfTU9ERV9DUFJfVFJB
TlNGRVIsIC0xKSA8IDApIHsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
TUlHX01PREVfQ1BSX1RSQU5TRkVSLCBNSUdfTU9ERV9DUFJfRVhFQywKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLTEpIDwgMCkgewogICAgICAgICAgICAgZ290byBoaW9k
X3VucmVmX2V4aXQ7CiAgICAgICAgIH0KICAgICB9CmRpZmYgLS1naXQgYS9ody92ZmlvL2Nwci1p
b21tdWZkLmMgYi9ody92ZmlvL2Nwci1pb21tdWZkLmMKaW5kZXggMWQ3MGM4Ny4uOGE0ZDY1ZCAx
MDA2NDQKLS0tIGEvaHcvdmZpby9jcHItaW9tbXVmZC5jCisrKyBiL2h3L3ZmaW8vY3ByLWlvbW11
ZmQuYwpAQCAtMTU5LDcgKzE1OSw4IEBAIGJvb2wgdmZpb19pb21tdWZkX2Nwcl9yZWdpc3Rlcl9p
b21tdWZkKElPTU1VRkRCYWNrZW5kICpiZSwgRXJyb3IgKiplcnJwKQogCiAgICAgaWYgKCF2Zmlv
X2Nwcl9zdXBwb3J0ZWQoYmUsIGNwcl9ibG9ja2VyKSkgewogICAgICAgICByZXR1cm4gbWlncmF0
ZV9hZGRfYmxvY2tlcl9tb2RlcyhjcHJfYmxvY2tlciwgZXJycCwKLSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTUlHX01PREVfQ1BSX1RSQU5TRkVSLCAtMSkgPT0gMDsK
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUlHX01PREVfQ1BSX1RS
QU5TRkVSLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNSUdfTU9E
RV9DUFJfRVhFQywgLTEpID09IDA7CiAgICAgfQogCiAgICAgdm1zdGF0ZV9yZWdpc3RlcihOVUxM
LCAtMSwgJmlvbW11ZmRfY3ByX3Ztc3RhdGUsIGJlKTsKZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY3By
LWxlZ2FjeS5jIGIvaHcvdmZpby9jcHItbGVnYWN5LmMKaW5kZXggYmJmN2EwZC4uMWExNmNiMSAx
MDA2NDQKLS0tIGEvaHcvdmZpby9jcHItbGVnYWN5LmMKKysrIGIvaHcvdmZpby9jcHItbGVnYWN5
LmMKQEAgLTE3OSwxNiArMTc5LDE3IEBAIGJvb2wgdmZpb19sZWdhY3lfY3ByX3JlZ2lzdGVyX2Nv
bnRhaW5lcihWRklPTGVnYWN5Q29udGFpbmVyICpjb250YWluZXIsCiAKICAgICBpZiAoIXZmaW9f
Y3ByX3N1cHBvcnRlZChjb250YWluZXIsIGNwcl9ibG9ja2VyKSkgewogICAgICAgICByZXR1cm4g
bWlncmF0ZV9hZGRfYmxvY2tlcl9tb2RlcyhjcHJfYmxvY2tlciwgZXJycCwKLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUlHX01PREVfQ1BSX1RSQU5TRkVSLCAtMSkg
PT0gMDsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUlHX01PREVf
Q1BSX1RSQU5TRkVSLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBN
SUdfTU9ERV9DUFJfRVhFQywgLTEpID09IDA7CiAgICAgfQogCiAgICAgdmZpb19jcHJfYWRkX2t2
bV9ub3RpZmllcigpOwogCiAgICAgdm1zdGF0ZV9yZWdpc3RlcihOVUxMLCAtMSwgJnZmaW9fY29u
dGFpbmVyX3Ztc3RhdGUsIGNvbnRhaW5lcik7CiAKLSAgICBtaWdyYXRpb25fYWRkX25vdGlmaWVy
X21vZGUoJmNvbnRhaW5lci0+Y3ByLnRyYW5zZmVyX25vdGlmaWVyLAotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB2ZmlvX2Nwcl9mYWlsX25vdGlmaWVyLAotICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBNSUdfTU9ERV9DUFJfVFJBTlNGRVIpOworICAgIG1pZ3JhdGlvbl9h
ZGRfbm90aWZpZXJfbW9kZXMoJmNvbnRhaW5lci0+Y3ByLnRyYW5zZmVyX25vdGlmaWVyLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmZpb19jcHJfZmFpbF9ub3RpZmllciwKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1JR19NT0RFX0NQUl9UUkFOU0ZFUiwgTUlH
X01PREVfQ1BSX0VYRUMsIC0xKTsKICAgICByZXR1cm4gdHJ1ZTsKIH0KIApkaWZmIC0tZ2l0IGEv
aHcvdmZpby9jcHIuYyBiL2h3L3ZmaW8vY3ByLmMKaW5kZXggMmM3MWZjMS4uZGI0NjJhYSAxMDA2
NDQKLS0tIGEvaHcvdmZpby9jcHIuYworKysgYi9ody92ZmlvL2Nwci5jCkBAIC0xOTUsOSArMTk1
LDEwIEBAIHN0YXRpYyBpbnQgdmZpb19jcHJfa3ZtX2Nsb3NlX25vdGlmaWVyKE5vdGlmaWVyV2l0
aFJldHVybiAqbm90aWZpZXIsCiB2b2lkIHZmaW9fY3ByX2FkZF9rdm1fbm90aWZpZXIodm9pZCkK
IHsKICAgICBpZiAoIWt2bV9jbG9zZV9ub3RpZmllci5ub3RpZnkpIHsKLSAgICAgICAgbWlncmF0
aW9uX2FkZF9ub3RpZmllcl9tb2RlKCZrdm1fY2xvc2Vfbm90aWZpZXIsCi0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB2ZmlvX2Nwcl9rdm1fY2xvc2Vfbm90aWZpZXIsCi0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNSUdfTU9ERV9DUFJfVFJBTlNGRVIpOwor
ICAgICAgICBtaWdyYXRpb25fYWRkX25vdGlmaWVyX21vZGVzKCZrdm1fY2xvc2Vfbm90aWZpZXIs
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmZpb19jcHJfa3ZtX2Nsb3Nl
X25vdGlmaWVyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1JR19NT0RF
X0NQUl9UUkFOU0ZFUiwgTUlHX01PREVfQ1BSX0VYRUMsCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLTEpOwogICAgIH0KIH0KIApAQCAtMjgyLDkgKzI4Myw5IEBAIHN0YXRp
YyBpbnQgdmZpb19jcHJfcGNpX25vdGlmaWVyKE5vdGlmaWVyV2l0aFJldHVybiAqbm90aWZpZXIs
CiAKIHZvaWQgdmZpb19jcHJfcGNpX3JlZ2lzdGVyX2RldmljZShWRklPUENJRGV2aWNlICp2ZGV2
KQogewotICAgIG1pZ3JhdGlvbl9hZGRfbm90aWZpZXJfbW9kZSgmdmRldi0+Y3ByLnRyYW5zZmVy
X25vdGlmaWVyLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZmlvX2Nwcl9wY2lf
bm90aWZpZXIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1JR19NT0RFX0NQUl9U
UkFOU0ZFUik7CisgICAgbWlncmF0aW9uX2FkZF9ub3RpZmllcl9tb2RlcygmdmRldi0+Y3ByLnRy
YW5zZmVyX25vdGlmaWVyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmZpb19j
cHJfcGNpX25vdGlmaWVyLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUlHX01P
REVfQ1BSX1RSQU5TRkVSLCBNSUdfTU9ERV9DUFJfRVhFQywgLTEpOwogfQogCiB2b2lkIHZmaW9f
Y3ByX3BjaV91bnJlZ2lzdGVyX2RldmljZShWRklPUENJRGV2aWNlICp2ZGV2KQotLSAKMS44LjMu
MQoK

--------------gAYZ0XdJXrKBYt7ORz9FExFW--

