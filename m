Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CDFC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:11:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJNJ-00049L-8Z; Wed, 28 May 2025 12:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKJNH-000493-7x
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:11:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uKJNE-00031w-PZ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:11:27 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqZTb024180;
 Wed, 28 May 2025 16:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6+y+wWgoRIE1Onu2sGjsW9b4YEOdZayvjaNe7DmvobE=; b=
 ladvPMY2Gojv2Q9Gtm8viLNTSQpPMfsPg36r7fGs//pnITpShOHlPX7NCPbs45vF
 g5AW4ofTgF/UlnOfvhYGPVb7zILNAboHREUV2mg6fkBHijylZH2b8Jw1hvXjJ+7z
 bj+vl4OHnryYNWrlYvLrKNVUg/eM0fI1K6cAFRF5i1BaC/J1hHvAqymt1j3uhdW3
 yoE7RI52D77NfrRqKSBSET1vwevA3nJxKENwMWAmoewzDZGf9i8e8VSas4qIRcNr
 UxTiSy3mr74S+MXU8xvBosFuilSiKSUsuzL7c2qhQ0R+VsxDjetlxE3HI0fCqGD1
 6HrOy7EQe4dk4nqPLtdLNA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33mxbtw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:11:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFcsAL035812; Wed, 28 May 2025 16:11:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jbkvm2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=el47ua3CIL4bDUioS++3yvLVJSlFoqp2kbNk4qBwnzC2fckRb+4HaobqtxiezWa3l3CRI5SkcYKi1NuCmI8qMyaEiCcEeFAdFyIKoDSaZi0bEH/r0YT8/IP9D3R6eWk9HIDDLoU+tKnnNTlgXD8FqTqdzPlkFKqlTy0o8ijbmFmuuJrnvL0LFm7BZPp1PFz2jQwgcb79XTpxx0qtPaK4WrzQlG6/d9wb2s6l9ISNn4qS2Jrg/xOxCVtRl6tCPfUzwi0XiiwjqwQo8uKkXO+STkJnwuGYcko0tiVzu3iNBieOsCM8xT66h1/unl2cccZufnr5hGQK1be3rUOrC9dklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+y+wWgoRIE1Onu2sGjsW9b4YEOdZayvjaNe7DmvobE=;
 b=LTO8dTqQ3OlTr62L5T5/bMs1CNdKWAIf0nPKwx/b6Q17LvNeIL6kOSqaFfUqmOuz9rnneC92y0C2N7wNQbaztoWcljjAVX5A9LqdTLhK+Z+xfflvJlKgXV4jnu8xLVUp8o6lkrIr5Cn+WvDcEWN0EmEQGXhomCP4NNggaN507bmUOlBPkPwMgInLJYfgnNQOBF3kcDjfdxXCjJdesXpqVDPj47LEDXMXGzrJTcMpKWU8VnSosJDGZ/VXzT0xict15lPzQVdVwE6XlS8t09FtPVHNuQgP6mIlHHu3TL26YEHwSG2odycbt1X7PiU+ChFuhO/9GHCjygRN3opHNeNt4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+y+wWgoRIE1Onu2sGjsW9b4YEOdZayvjaNe7DmvobE=;
 b=ePxvjigLwDIFkccTzDoVd2V4dXMkCJWl6OQBuSWCdJSK8w+2TO73x36EW7q/XpLYN/FNsYkM2U8L5qsqFucnz2lVbF07DL974gnOdrv8+0KoFPgJaqJ91hvB2dJdUtIa34ADCSqUtKAkzYTNbbLC41RClOaFd3tYxDJo9SwAobI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 28 May
 2025 16:11:16 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 28 May 2025
 16:11:16 +0000
Message-ID: <3c693fc1-b17b-481f-b1ff-b5d5eda31a28@oracle.com>
Date: Wed, 28 May 2025 12:11:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 14/42] pci: skip reset during cpr
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-15-git-send-email-steven.sistare@oracle.com>
 <c0aa3971-85bd-4e69-bb13-4e13349794b8@redhat.com>
 <20250524053413-mutt-send-email-mst@kernel.org>
 <061a43b2-b96e-4d32-9e81-f5d50824fb12@oracle.com>
 <20250527165128-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250527165128-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: d90ecf79-a9ed-433a-4b39-08dd9e024655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE5NaFFpY3VLTVc0MC9Rc1ozT3ZzV3J5a2syT2tBM0Y3dml6cUc1ajJGcnBz?=
 =?utf-8?B?b3RNODVhUW9CNFduU1hoZnY4VG1QOHgyejlPb0lCMU5sL2hxb1hneldYU2gx?=
 =?utf-8?B?QWx2ZDMxZVJlODAxZFNkakVFMzZRT3hIeTh6NXhPWHZYMlpOaHlsc2FMMTJp?=
 =?utf-8?B?WjRNNXFyNFJ5L3NKTUNVeWFqL20rZkxrd0tGcHhlT3hmdjNVMnA0RElKdXBy?=
 =?utf-8?B?ZkZuOGUrVndsWVo2VHdoOCt4aE5JMUUwbU9yL3dHUlBMUXlNc1NscnhIMm93?=
 =?utf-8?B?NTdCekpTV295cjF4ckpSRkxXczQydVNvemtoRmdqcUthY0ZvaXVxd2YzQy84?=
 =?utf-8?B?ckFodWx2TVg1T2lEREZvUW14N2lPSW9obEVuRnhVQ2k0bm9PRWN6UWptMi9G?=
 =?utf-8?B?UlIva3k4SjYwckRuS0FyZVFKZEZ2bVZka2FWYVpWbjMrQ201dkJaMHRlTlht?=
 =?utf-8?B?Qmk0K1dwcWhObDZWMVNqMzhTY0RtVjg3RnNOcFJvQXhHV1dLQ0ZUOG9ObkJk?=
 =?utf-8?B?NnlKN0pkU3h5cjI5UVJMc1pRSWRkNlBMRVFqQjlMV0MwQnF2Uk0vbkx4cENT?=
 =?utf-8?B?bGg3V1JHVkdKSVl3TVJNY3cwN2pnSDU1L2tJSVVERGhNdjNMT3B0SGR4cUVj?=
 =?utf-8?B?MmIzNDFLM2FHNXBPNmJxS2ltMWRRN1IreXlydTJLS242Q2lWWitFRDRRSzE2?=
 =?utf-8?B?a21yekNYaVdNeHU0YlFBT01ueE1KS1JhdWRDWE9CelB4QTduVHJvWTBmSlZo?=
 =?utf-8?B?d2F0L1ZIaFUybUkzeGdoYTZhOXFUb05kekFTekQrQ24yMEVYWmJPb2JwREg2?=
 =?utf-8?B?Ry95b3lKTk1HTGRyTFMzWnZTNUcrQkhuVWh6RUJ3aXRVdTdWNjFyQ0IxQmY2?=
 =?utf-8?B?Vk9INWJodm5tQjhmQUpPbUJ2TFAyUU9XajYweEtLNm5wRlFXeU5iczZPeGFU?=
 =?utf-8?B?SjNoUEJ1Z1Z4Qm5ObkkwN2lMT1VLQng4Q2Q5YklIRmlMRC9lQlhjSzREZlZu?=
 =?utf-8?B?Y0pPaktVN1NkWVJwU2VPdG5lYlRYTWs2RmNSSjJtYjJtUzh3ZURJODBaZXdw?=
 =?utf-8?B?cFcwSjY1aFNKV05JbDdMdlUwTUlNbXpOa3JBRTQwZGEzNXU1YUpGSWZvenQx?=
 =?utf-8?B?bVFod05QaVBpc0d2K1JKSGRMTlFyMXFBamw1NGc5VUkrR0l6T2lFQ0VoNEJP?=
 =?utf-8?B?ZFB6NEhBbldDcTZPdE8zSHRiU1hZays4KzJaOHFoZC9jcUFrc3RGWHcyV01T?=
 =?utf-8?B?aHZ5eDdVVkVTeXlKdDZnbjEwQWJRbmdpTFhxNitxVXpZZ2kzdDlNS3lZNFA2?=
 =?utf-8?B?dE9PSDh4bE1KdVVnMXMrR3NLcUFrT1ZNSElCY2p1U0xlNmxmZ2prVXBqZGlI?=
 =?utf-8?B?U0ZMZjkrUW90VnpjbUlWRjB6eENWU2NGYXNHTzYxSnZka1FuVFlKaml1bVdW?=
 =?utf-8?B?RSt4MlM3SHA1SEJVVkZBOGJKOWhlVjY3aURWL29RNm5JSWFkZ2xOVXMyRUFa?=
 =?utf-8?B?YjFpMUxDNHdiTnNBMHlZTkVZT0FsSlJ3OVlaaFNYQ2UvY1BOSUxvUkFpTnN5?=
 =?utf-8?B?NGZaOTJzSUpkMHVhY2N5bDdJVzcxV3doemRqM1E0SkhvaHFYZkJ2RVZmOTlJ?=
 =?utf-8?B?WGEzQXdidXRpektVUG1ZeWtNUy83MEhaM0dMY3lGUjBSN1kyclJ6STdGTUla?=
 =?utf-8?B?L1RvbnI1WTdZeEQ2bDN3WW8xU0w2dmdESklLd3NLWFgzYlQ1WDBYaFhVV0tE?=
 =?utf-8?B?c1d3ei92WXJtRTFkOVJIS0xDeVFTK1BDeGxwUGxKdWpidnFOZklBQ3p6eEkr?=
 =?utf-8?B?THV1UWJmMEdudjN4U0JrQUhBQ0ZzZnFaTk9JSE4xNmlsN1BiaDVSWGV4dHEy?=
 =?utf-8?B?SmxUN1pJQ3BJT0RnZXNuL1JuK1NoUGRyNitvQzBwcXJmT0h0MlRwQzVraHVL?=
 =?utf-8?Q?kOl2ZTtynBE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmlaMlI2d0ZMc21QM21FS1lZR0xyb3FlcDNMSmNIRWw3YnorbnppRFgzdEFT?=
 =?utf-8?B?K2pGcVA1Z1Nxd200ZnQ1UlIzVTAwcDJnMHZ2KzgvNXkzczlLVER1Q1dLRzVP?=
 =?utf-8?B?Ty8zQVFCQzJYMnJvUG1FSGV1SjFmV1M2bUhMTm1DNE9KaVhiTWlOL3hQbDRu?=
 =?utf-8?B?MmFFb1pRN3dSTkdLK1NBWk5IUjZMS2JmSkJQVnpKTjBCbitYVEdLUFRMV3pn?=
 =?utf-8?B?ekJzaVBlVXNCNzZPVVk4aUFyZnN0cGJHUmNoZHJQL1EwYXQyMERmU1BPcldW?=
 =?utf-8?B?TmFac3NReDBTL043VjdaUHpzMndobEFxUk91TVNQRDBqNUxqVC9ReXZwSlg1?=
 =?utf-8?B?ZEoyWnY3a1FvM1hHTGQvcDdmRUYvMnBQeC92bTBIakFzZHMxR2dRWHQvRFJM?=
 =?utf-8?B?UEExOU9mcHBVSXpIV0tPWlk0Skw5aVZEUjNjTk1ic3lJWmlaWm1PcisvZkYx?=
 =?utf-8?B?emVJdDhQWkI0WlJjK0ZnSFBveVpJS2FjNWVLeDlsSDVVRWJPcmlyY1dnVkh1?=
 =?utf-8?B?dzk2eUNzdkkzOHYvZTkwcXBoanU0eFdYWnNPZDR1NnJybGV2SjdMSm5mcmdr?=
 =?utf-8?B?ZVJNMFNhaUU3b1ZqRkNQN2xYNUFJKzNkRHA1akJjRFpHS2hSMlQ4T25IcDZs?=
 =?utf-8?B?cGdJWnFEMHhtM3FYM3ZoL21XWmZRdVNPN3VOQldIYkJaY3djOGt3Y0tQNGtu?=
 =?utf-8?B?aHlzMEtlcDNQT2VuWnJaQlJGaGVJaVMxeHV3aUlSK1VucHhaeVBGaXNKOEtM?=
 =?utf-8?B?ZDZqeVJsU1NEZ3Jja1l0ZHBNQ0JGWGdvTmJYc3FsOU9pRnR3SWxRUHowZUl3?=
 =?utf-8?B?cHJLTjNlT2wvWVVGY2s5N0dUSVJTUW5OTHRwN1k1UUlHSDRtN2YxK2QxeVJX?=
 =?utf-8?B?eTdQU2pialRuVTNJZUpQNjg0QW1jMiszbS9rY0ZuTU1JOEI1UC9XNkMzVkx1?=
 =?utf-8?B?WjgxTkVqdDJKNVE4K1N3YXRDYjBHbDJkMXVsQjNvQ1NkajJUWFhIVTl0Nlp5?=
 =?utf-8?B?MGNvUVZEYUVHTWhoRjV2YjlVdkVlQ0FpZWlnNks3a1dxS0Y3Q3ByWFV3Qy9K?=
 =?utf-8?B?bjZaTkd0bFQ1Ym8vLzREZWltQUd6dmFEd3lqOEQzb0JPU093Y212VVlkR3BO?=
 =?utf-8?B?N3M3MWQ2WGp3TC9waEdZelErajd5K00wMVBZYXgrMGoyWmhZUEliTzVLdXVM?=
 =?utf-8?B?YXRmTzIySFlOMHhoNVRNYzdOckpWU2FaTWxWb3BlUHI5MVdNUlJ4R3QrNTFW?=
 =?utf-8?B?dEFCWXRRVlRVa2twMmxsY2pya0ZyS2JVVWlRRXFiVE05S1hxN3hPTldnY2pE?=
 =?utf-8?B?SVJ4TjNOanJzM2pYTGlIMWlCL0tpUVAvOXk0LzcrVGE1MFl4QlY2TUJPZVJF?=
 =?utf-8?B?RzZqdDJuNGo4cm1mbWZFd2tleEdXR3FMcG1JTER1a1ZwMEliUW5ucWNLeFBh?=
 =?utf-8?B?SWpDNWRuNmlaNlJaakhZR0FzRE80K0xYakg2czZURmEyYWh0ZDlJYktPQjhm?=
 =?utf-8?B?aTRPVElnUENGZmtpZXdTOTdyK0hiZ0hsSXhzN0hRWHNYVHdrVXhrN3p1clly?=
 =?utf-8?B?WHpUeVVzT3RZOFlTVUpMbWUycHZqdjg1VEw2SGtjRFRQVm5IRlpvMCt0bzlm?=
 =?utf-8?B?RmpNVDJjeERyM2JCRi9NZHNvT1RCK3h6M2hoVDQ4ODBORCtESFdQRUQyRDJM?=
 =?utf-8?B?K2ZKOHcvN1NQMTZxTk1ZSnVVT0hrc2x1dmoyeXB0WEJ3U3M5aFA0N2VPdmtQ?=
 =?utf-8?B?NTZaV2RlM3ZGWUlYd3Zidklkbk5zcituNWNmZG02Z3JkWmdxRFRPWlpqYk9t?=
 =?utf-8?B?Z2hsQWVtb09WdUxvbjhBN2pic2l0TDRQZmxlY0V1ZEMyN0wzTWFLeG1ybk5J?=
 =?utf-8?B?OTlrUDl1M1FoTTlvbUU1N2pQTkVzWFIwS2VxTFBhV0Z1clZubS9Eb3ZGY1Zh?=
 =?utf-8?B?WjQ0YTdodUExWEZIM29ncS92V2JmNE9qSjhFS2xGWEpCclhsSXoyVm0vOG5D?=
 =?utf-8?B?clN0TDU0RmN1NDFnektrTGljYU5jbmpORDVYYWcxZmJNTGRGUy9NRGpDZU9M?=
 =?utf-8?B?M2k4UllacUwzKzdwUVVHWkxzZ0FXRGNmQUY4SlJ4REdQYmdtc1FVQXMxUTZl?=
 =?utf-8?B?L2lVeUM5NmRYY0Q4Y04zYmNEcFVIYjduby9GN3lYZzZwU0dVcDEyTTB3aU5h?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xoOuOXmu0csnCPDT/ga1Je+mSgG8z4P0C61RY2pM+vwD/uhO50ltsw1tPHVyz+wk9urOlMek/+0QsA85KG9JAmUMlU6cl1IgCsBi1YiFzlqCpCfZL1F78Un0NSgHUB6MxL0tkZS5oiySlVZ09Si0CjDVxLl7an/ow6Za+yVZvEgwt7gikv43j+LoqSckHJPnmOtRz6iFZ/ijPD8phixT0A7glrLHJRZnJ5SBPBFmhypJvRQ8RcGPN3tTIK2ZBV0AocnIC993r1GMsJQh1Lz0OTb58XsSPaxU2lVZVxUhXF2vz9EqZJ1TRj/+ph0pmzTovyMSe7XeZ9YTIdhQWU4Gh+Ye2Fr1GwSzQ2F/9vHRLIGB7zGrup3prXC6T1LvpfDHxpTqpkbh8QdrGoD2IWJxtFGx+aAPLU+ZCuXaab2XT+TzT2BNC9XfS4w5WlQuPAX+JxtSP8fb/gFsg+8+pgXP5lybdEe3ZconubntcleuyGz65JyTar0c+ezPnwURuo6xMd6qvMCSH3aLvIdx+dCt9WVLx/n1pMgEY1f4EVBIueEKfVZZuPiUIc4MkrLKx2aSpmOhbjXH9W1bLlnnZT53e9CEYuepqhIYDFiAEhYMo+M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90ecf79-a9ed-433a-4b39-08dd9e024655
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 16:11:16.5924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1PAewZdaiaGzZSIToXnBkfzd9gPFRrwie+YBDq832P+qlelnFQKaZd3ZDPADDfTLyun8HHDfk1IHzYH8bARqRyOUB6e7m//uKnlABxvY9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505280140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0MCBTYWx0ZWRfX5IBZbLL+bEE+
 X2qzCBNxHYLVr8AAmM+wQO08qp0rx2b3cTpxwlVyy+cpXL0E98nGt1MMaMb/JdmUi1XlL7Bl3wB
 8AiPgdGI6OQP2QJiF/n4o7BSoQgsN/QOCBRoyyaeFybjJIpMg2yUeDeIeqNVVzrt1vTjfisU0rH
 gUZKOmAZf1VaGq14KcLLNfa/qkmkM7d7JpsxTQXTPFE/+a3SxmQXaVpYEwaV9E0k8+hbHh8GuxX
 5nGR4efy8UI7lc2pqViN8LapjzG7mdwMEfdWxM9+Ly4U5ce1u4CaE+b7y9TI2Q/rxEIBvfSKVlf
 5ScH+y5Z0OnPDFbFcmZvvITa/80uuhqnQIM8JxXnEeoGV0hl3rgqkzLPs54/SPeyPVAjpdpckUQ
 htswW0i2K7mSK/THWqrUB0NCG0wFVJ6fU5K7G0XL9iO6KlyzgDvYaB4kmoVcO7os2Gy+a7jW
X-Proofpoint-GUID: 3nPN7vKqrwsbfPnxkhkFGKwmEXqh9tPt
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=683735a8 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=75KstJEBSeGgGG1p4KoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3nPN7vKqrwsbfPnxkhkFGKwmEXqh9tPt
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

On 5/27/2025 5:03 PM, Michael S. Tsirkin wrote:
> On Tue, May 27, 2025 at 04:42:16PM -0400, Steven Sistare wrote:
>> On 5/24/2025 5:34 AM, Michael S. Tsirkin wrote:
>>> On Fri, May 16, 2025 at 10:19:09AM +0200, Cédric Le Goater wrote:
>>>> On 5/12/25 17:32, Steve Sistare wrote:
>>>>> Do not reset a vfio-pci device during CPR.
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>> ---
>>>>>     hw/pci/pci.c | 13 +++++++++++++
>>>>>     1 file changed, 13 insertions(+)
>>>>>
>>>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>>>> index fe38c4c..2ba2e0f 100644
>>>>> --- a/hw/pci/pci.c
>>>>> +++ b/hw/pci/pci.c
>>>>> @@ -32,6 +32,8 @@
>>>>>     #include "hw/pci/pci_host.h"
>>>>>     #include "hw/qdev-properties.h"
>>>>>     #include "hw/qdev-properties-system.h"
>>>>> +#include "migration/cpr.h"
>>>>> +#include "migration/misc.h"
>>>>>     #include "migration/qemu-file-types.h"
>>>>>     #include "migration/vmstate.h"
>>>>>     #include "net/net.h"
>>>>> @@ -537,6 +539,17 @@ static void pci_reset_regions(PCIDevice *dev)
>>>>>     static void pci_do_device_reset(PCIDevice *dev)
>>>>>     {
>>>>> +    /*
>>>>> +     * A PCI device that is resuming for cpr is already configured, so do
>>>>> +     * not reset it here when we are called from qemu_system_reset prior to
>>>>> +     * cpr load, else interrupts may be lost for vfio-pci devices.  It is
>>>>> +     * safe to skip this reset for all PCI devices, because vmstate load will
>>>>> +     * set all fields that would have been set here.
>>>>> +     */
>>>>> +    if (cpr_is_incoming()) {
>>>>
>>>> Why can't we use cpr_is_incoming() in vfio instead of using an heuristic
>>>> on saved fds?
>>>>
>>>> Thanks,
>>>>
>>>> C.
>>>
>>> Think I agree.
>>
>> OK.  I will delete the "reused" variable everywhere, and use cpr_is_incoming.
>>
>> Michael, since I already use cpr_is_incoming in this pci patch, can I have
>> your RB or ack?
>>
>> - Steve
> 
> My problem is not with cpr_is_incoming as such.
> 
> First this comment is a very low level thing to say in common pci code.
> vfio will change and we will not remember to keep this up to date.
> 
> Second, do we really know vmload for all devices sets all fields as
> opposed to assume that qemu_system_reset cleared them?  If not this
> introduces an information leak.
> 
> It feels safer to just add a way for VFIO to opt out of
> (all or part of) reset, instead.

Thanks very much for the feedback.  How about:

hw/vfio/pci.c
vfio_instance_init()
     /*
      * A device that is resuming for cpr is already configured, so do not
      * reset it during qemu_system_reset prior to cpr load, else interrupts
      * may be lost.
      */
     pci_dev->skip_reset_on_cpr = true

hw/pci/pci.c
pci_do_device_reset()
     if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
         return;
     }

- Steve


