Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE5C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 22:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfnTG-0001yt-Uv; Wed, 05 Feb 2025 17:02:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnTF-0001yi-8X
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:02:09 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnTD-0006qM-Dg
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:02:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfjNY000962;
 Wed, 5 Feb 2025 22:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=+p6jxZj1bwYDK+tmyBvXYZG3EZk2wbeDsAKJpyrWylE=; b=
 QYyaMRl6idfmHczCg4v0gRK+6AdYF5/6nfWgxNxuwYhTSibPJewdY8b5rBeIDTeg
 OnRypeMyaZ8I80FJ4j2+3VxtRqQOOIEnvUhBf6PHGl/S++Lp6B/FBUmkJwqPZgse
 Ta49/XAuerVJlYN/p/Zotg4HirNEcm6lSzDS2tFIJcADKM2FAxms4kmlrgWCyOZC
 SWmGw9sJybLzWRHfClNbcK+MMv+SuPSc06OAwerymtXiQYg+0tz9MVT6EzzRPm0F
 gh4sczAUYWHEdIZ3AyhVzo7K6metJLzJ5MtTPtLJahlM73dG5MV8l4mMh9FD/tz6
 KzzuEjS8fzwQ/QZCOjb2OQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfy881p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:02:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515LmfB9023693; Wed, 5 Feb 2025 22:02:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8gjx75m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSkHfK5fNKe04+lyoE2HLFHyGJtKWtBeFhkvSHCspNaggsJ/kR0bXVhWS6cJQmiYvtRnw7BiG+GHM14I2nB7YdUPj8qZAqxdlRcU8JlVynYWwUZ26w3bWA2FQ+Imc0KaFrz1nbRYmkkkObVH4CiAwOkqOiZMPNT4O2c5vKpNkggD+4B8DcpR7J7biNNrFQT2QHLj0hujBmSMgHXfhDJTpvO65n/ICXbEgUXm4eg3N2sFsBqHqcEhls3BsSJHmdllUg0G3qXgnOlbc0eDBTccOasEH3JVVEMdScQcozzdczpr2pSDYsZDYhWQIq+vbybEkd+f381gWdAlQbSOpcZupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p6jxZj1bwYDK+tmyBvXYZG3EZk2wbeDsAKJpyrWylE=;
 b=huN16H8lrjs0PdLJdqcmBHuqWV/I/YBRx75JC2/Z2+o1FVVVOHwrMiJl60nzIFcAKaj9waDDL3YHyjwXefdvci6ecQnHdCVn8tL2+PTxVZOQyVzveZipAHlhZKNfTko51mhTLILwtVUufT3B/9EyJXhimCAHkB+2eK9EENhL5rMYu6ritfOOH4etaaZx7JGESUa4k0wUkAR3xfW9hrcUiMmVd11QWpRxmITt9KI7vPQHmJVfJI8BT9DMWpzrhjHR3AXpgG3ADbl6ut3gNgsMi0zAI5Ju8mFQAMhPdQ4K8UgoXbViM80mPP4YpTx84P10RUQjgCo5qlDz+0ybSRogLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p6jxZj1bwYDK+tmyBvXYZG3EZk2wbeDsAKJpyrWylE=;
 b=y2np0pkKlMyxzGxE65Bwv+hNba0E8fTNUbfHVgGIVmYdmKnlKwrjcsrRqb8ta0ne7J2aBXQ+pKizC1Bj4Rfh6fRVJSJ2xinpzIQn/E8rExlbxYLRa7DeH96HjnCZygIhWjy/WdDj8JGluC3cFkwV90/7m/7gIu4PO8eiuJyYkOc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 22:02:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 22:02:01 +0000
Message-ID: <95c32317-5a26-4894-bbb2-7208031235f0@oracle.com>
Date: Wed, 5 Feb 2025 17:01:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 20/26] vfio/iommufd: export
 iommufd_cdev_get_info_iova_range
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-21-git-send-email-steven.sistare@oracle.com>
 <c0999ca5-d10d-403a-8b8b-46bb881673aa@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <c0999ca5-d10d-403a-8b8b-46bb881673aa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0115.namprd04.prod.outlook.com
 (2603:10b6:408:ec::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 6354d114-8127-4f8e-d1d0-08dd4630b798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T2VoMnRxTHZpTTJuL1BBQlN3OVUzamNEaTJ3ME1GN05rRGFkcVJIWkNwL1Ri?=
 =?utf-8?B?YjVhbHNJY1Vma0V1TnRUSFpsNzVqZENRclp0OFYxMjJBRDFqOEVaMTRXdEV6?=
 =?utf-8?B?Rjd1bVN2ZTlmSGY1cHA5YVlsYmdkVVNaaGpmSHUvWTBERDJBSmYzZHVsSzBN?=
 =?utf-8?B?WVdhdzROQ2FwZUI0NlNTUm96UGlTc3kxTzU1K255MFNDS1gxUDVuOENqWjF0?=
 =?utf-8?B?amxGNEdTUXVCdHJ5NzdNaUtlcjJGYTBSTjRlNmpKOE1DNytOY1F5SEk3TEtn?=
 =?utf-8?B?VzdZOXdlL1pYNm80eGt6bmdHbC9uVzZpSU93NnQzS3pXM3Q3ZXJDdDB3VVJO?=
 =?utf-8?B?c0lRZnVBaDBqTnc0Nys2ODczS0EzRUZQZS92dGpYKy9JVjRqazhVS296SzVK?=
 =?utf-8?B?Mzg2eGNiS1dZWmh5V2g1Nyttc3V3QUk2T1R0djNrQ1RCdGN5bFNRMSs4dlRh?=
 =?utf-8?B?bmoxL0gzRnUzbU9TZWduKzl0aE0wR0tON000NVFDbGdqbTlsV2dJTlRaamJY?=
 =?utf-8?B?dytXWjAzSEFVVWh2a2x3UkZNekYvemE1TElVdWZycnV3N3BMV2hMZlhXNHNa?=
 =?utf-8?B?TGhQNnNPZUxOUXZFTndFdWtXMDhiRmVEVThOT2JpNFZnRFI4eFZYaWQ3MkVX?=
 =?utf-8?B?N254eDFCczJyNDJ6amJna294dWx0RS9oRXljVEdhV2RTSm41U1NKSlRMYUJN?=
 =?utf-8?B?ZFMvaHFMQ1EzL3VnbjJseGVIYkUzSno5SVJrZUJmaW9KbVVVeXRvekVGSUJq?=
 =?utf-8?B?OTJBa3FPVTdRNXd1dFdzNDFrcVR4R1lGVVBETkVWQUV5NElxSndhZTRDZVNV?=
 =?utf-8?B?Y3IvSjRCa2lhUmhWQS9KbTRDSnFqOTJQT2dJcG16Qm5LR0dqck1Wc1dwM2N1?=
 =?utf-8?B?RlV2WkovVU5PTHFPWXZtRDc4OHhJVUcxcVFpMENEVi9rbWU4TGkwb0RUL3Nw?=
 =?utf-8?B?cW42UkwrUkZPNmlzR2pBSnUrbFU4YUI5ajJsL1lpb1k1RE1LWWFEZDlFTUFj?=
 =?utf-8?B?ampKTDlsdDVkVkV2VGRzekEvMlJnTUc2U1JqS1JYdTZRdUNIUzVvS2p2WTEz?=
 =?utf-8?B?OXhpOGdCN2hJeEZsS3Z4ZE1od1V3YlYxSVpzM25hejFvaGRXWVhHTHdTWE92?=
 =?utf-8?B?UDNpQnF5dVBnRmtUZlkxSHoycDR6ZDV6NEJ0SjJWcXg0Ti9raTZwSW9GNWtw?=
 =?utf-8?B?dkV6MHJEcHRqdGxVVVVTb3NlNzdwYSs4c3hiUjZHV29Cbm5KaHhyZ0dISlI4?=
 =?utf-8?B?b2liNUhFRGlPVkY1NkQyb25oOTVIeGxNKzE0VlpabUZaNTNIZFlzTnNtVklh?=
 =?utf-8?B?bm00Qk9vanVlTjU5WWFDUVlpQnFvWmVzN1RtOGN5ZEYwaGNvL1dHNFdVWll1?=
 =?utf-8?B?bGhqMmdaSjllWU9sbHYydnRIaDR5aXdCdDE2YnNONXZMV3FnVmQyeDVtYmNR?=
 =?utf-8?B?eDdjTkJ0Y3Nqbmo0TWc3N1h4YjVYbVMxRnpTN3hSaDRDdzg4TEQwbUQ1aXhD?=
 =?utf-8?B?U3VFc29iWjdSa1pub1o2V2NOR04yblphUXFaYmcwY21vYklXdmptajlURlMz?=
 =?utf-8?B?S2x5WXd2SkJwL05ZTDl6MVZvRC9jSFR6V2JqK0xaTUg0MEpjZm9vRGZkLy9E?=
 =?utf-8?B?QTBURVk1NHBHazZPb04wSW5pQkltU0pza25ZSWtHMEdrRnZYUnA0UUFpMmJE?=
 =?utf-8?B?VWhpZ21CdnZTRmNsSzk2dW1SOWl2VHYydDQyWjRQM0FOYVo5ZlAya29MODh0?=
 =?utf-8?B?WTRydHNtK0h4ZndiNytFV2FWUG1lQk56NzRJejdsOUV3UndCSU55VVREV2Q2?=
 =?utf-8?B?WjNWMmdEUUlDaEpQUWpid1drNXUyOVlESy9lNFNpN2YwcVJPMHFyekUxdTcv?=
 =?utf-8?Q?oInJvgZ0XdnbC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujk5TncrYnZSNUNvR3lZejQzdVlVU2hId0VSVEQ4TTNMdFJqSW10eDFDRnFs?=
 =?utf-8?B?Q1ZKdm5VQnlXcENOWE1yVitnYjVSdFFQNC9PaytQMmo1SDNGWUQ4ZzM0cFkz?=
 =?utf-8?B?RGQzR3h4SXhFS04vQ2pETjlKOG02amZOOGRvLzBFTnFqUWp0aGxVcmFwQzBW?=
 =?utf-8?B?cFV1eHVwdUt1RyttV2RUK3ZtNzZnRjd5RUp1Mk1pYVM4S3YrWEt2RzE1Z0d5?=
 =?utf-8?B?TWZ4K0V2RXpJNU1UYjhLOHZ1dGs3VUx1bDVmVGFHRFVIL3dvT3F1VVFMSVlB?=
 =?utf-8?B?TnRCZGRRWnovOUMvVFA1SUtGVWVrbmxhcGEzVXNEaXd1aDVhbTRsaXQxcndX?=
 =?utf-8?B?QXNOSmtCeDdQV0xXdjJtRGx3ODZQRXRkOHRqbEFjUGd2YXMvU29jaGFHR1Iw?=
 =?utf-8?B?dXZTQUs2VGx5V3RLYjhqQ0pYY0NkQTl2Qnk0dTljcWdHcjRUUkpWb2RFS2kr?=
 =?utf-8?B?enFSNjhHb2pNdEVPbmxuL0xMZEw2NHpKUkNTWEh1Y1IzTUdmdGhPWXBHYU9x?=
 =?utf-8?B?NEM4SlVXa2YyZjJteFpVT0lHb1hGaXpSdERHaHJ1aEJoVUVMT3NEdUpJaG1s?=
 =?utf-8?B?TGw1NFBZSkNsc2d5ZVc5M0R3TTVMaXhFU1FEK0tPeGN5M0Nnd1plWXc0SWRU?=
 =?utf-8?B?L2JOVTR3MEE3STlKajNlcWpJekc2MGZvV3IxRmhYSXVEcW83blMzbmcyaDJP?=
 =?utf-8?B?a01kblNUTlBKNEltU3B6S2ROQ3ZYR3NZUHMwKzJ1S09XSlpsaVYwWnF3aFU2?=
 =?utf-8?B?aUIrWndKand1RTlacVo5N1o0MlJRT3duNWlHMTErTUF1VGVEVW1Lay9JZVBv?=
 =?utf-8?B?WDhvanVrV2lmTVhLM0FZOVBzdytkNDdtUGhJemtlcldRNVNabEd2N21lK1FO?=
 =?utf-8?B?Vml2OFJESTREM1pZR0VQMnZ1bThSUEZpYm1pa0N2eHMvcDU2Q05jazVndzF2?=
 =?utf-8?B?REUxb2VGQWNGSGl0OW43Mkg0WS90dHRTUDhTSFcxMjByS2pPUTdnL1cxYmsw?=
 =?utf-8?B?NURId3ppU1gzSHdvVGxCR2JBR0xOTTRHMjRKdGt1d0hEb21LWkpQcVNrbmtE?=
 =?utf-8?B?TzB4VkNNeVM3Ly9WQ3QwUkllem8zbnp1NDZFMVNiVHI2M1UwTnZnNStTdnRM?=
 =?utf-8?B?R2xpcGlxNUljQk0yOHdMZUJsOVV1cUdEM1BnUkZIcjZzRFhva0J2blJPTVRm?=
 =?utf-8?B?UmdpbytPQTZmZ0VKQXNlUUVJdHJOY1BzU0Uvc3JaNGRWMUttL0ZzaUhIazF5?=
 =?utf-8?B?dENDU3JxMWFnRlJGWmRoWGh2R3dmRFphWVJENGVIbUQrRnBYUkR0MTIzL2dE?=
 =?utf-8?B?SEhId2NSc3VybnJpTXEvVmoxRkZpWDhtYzkyWHkyQnRlRVBaM0xpcjJuOVp6?=
 =?utf-8?B?VWhrUlRTeXdxNjVDOHNoYXUwaDZCSUJPT0R6M0ZObjhpTXhuNFBvcGIrV2cr?=
 =?utf-8?B?WjMwaGt4cTJpdTREVE51YklKUEJCcTJKU2tiSmlMa2dZOVdIbEROSUVMTmd6?=
 =?utf-8?B?TjJxNnJuYnl4MWp3VW53NlB4d2l1c0d6OVU5eUY0NGRpVXZoNDM5d2pkNmhK?=
 =?utf-8?B?NGpycWhtNU9nOUgwc3ErdGRQOHQ5N3hKV1lNaHVwSjFOellQZnZHMkcrYXFP?=
 =?utf-8?B?TWxhOW5hc3BuYnBqNzV0VDJ5MkRlWGs2a0NKZnJ3SlNROFI1NUp1QUVsaVJC?=
 =?utf-8?B?ZllGWFdUb09XQVE5YXJhN2xDVzRlRkhSUXdnNlp2WGt4ZU8vWjd5M2ZkcFlC?=
 =?utf-8?B?b0trWmhKT0xzUzR2K0RVaW0xL1VRWHdRakRmZzdodDhFRXRoQXBkZTFtelBk?=
 =?utf-8?B?MHRqWDRLeE1qM1ErMndlTWNOSGRJTzhRQnFpMGRPQVFTaVladjBLTk5FcDZS?=
 =?utf-8?B?QXo0ZHVBTmNCV0NscHRwellBUGtrbWx2RTR0QWJGK2VqeDN6RWRwdU00Tnc4?=
 =?utf-8?B?NmltOUFmQllvYVVjT3BiWmM4cTVXK2lXQ3lGL2F5cHBLeVFwUU8yUzZRNHdR?=
 =?utf-8?B?T3NQMmp2VDJWMnZpblQ0OGxHNU9PWGJJeG02NVlwMVZjT3RpMEFZNER3RUdG?=
 =?utf-8?B?Z2gyUlN2N0s5WVYrODEyWlpIdENCV3I2RlpOWEVVby82aUovWDl0dklEZllH?=
 =?utf-8?B?bk5YdWF3QU5zYWhMRVRuQVg2YVg2SXFMSTBPbW03RGZJNTZvWXoxZVdnZE1C?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R7zmXTFKSxIYyuVSDHbzMBGf6UBUuf1svLXvk/5CcT6+l06N/nMswpw20/KBzuXIEcNSSjXQanCaQESnZPeop1Vx5TalEKBeQ5KEqXJjRLgP8H80f/8tCuMfy85q08B6EoGhI//hrLFbiHmj06ln5JEpYWgT1ypaHH56oqWe6a4DSy7Z6xJ9oUznmO+y3zoaCayhsCc+ARN7y+wWi2wm1qpHAAOfXJF07iWk07eVgfSGYynVWafp53eVepxaZa/ahHlswtNQxVb/U2xZSWb66Cbb1Yexa74yHuxA79hgeeHP2in8iKErttBLY+Ymw+OLTjG4A6jUEhM+UGRKJEH4JcfR4yFhs+MDOGyS5j2ekfoUvxpGXqL6R/irWCWI1mg9Bf3eKCpQ90AEb6XPBehL55fvULdbhS67WdyPxV3ItlfVbePH3P7xrf5vp34bR02IfkKxuTGV0iTRIO5uJl8DXt7hSVK0p6p5FjWMu00doka3WD5ef4tYO81uFS2NgfstRcHtE/LHbwa2cHi7tEiMqXDFb6H3sUqLvioVzCNlEwrb43gEyCGxHQeLWXpeBxHyQQt+xjIa/TG19udaQ5Dv4qoLtm+1SRvS5RJFT31P8+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354d114-8127-4f8e-d1d0-08dd4630b798
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:02:01.0249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: it9bmBN6tbXSEYWF6o6X3BCyeEq/KPYi63iCmUB6ib8zd3nnEePUwqzd7UZRuZiNDTo5Cso3gcLETGA/+SwxD8J1tN8kmYjmO3Hdl6uWfYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050168
X-Proofpoint-GUID: sgScNdbUpi4PgGAXaXrC7-ehY08tOypz
X-Proofpoint-ORIG-GUID: sgScNdbUpi4PgGAXaXrC7-ehY08tOypz
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/5/2025 12:33 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Export iommufd_cdev_get_info_iova_range for use by CPR.
> 
> why does CPR need access to the IOVA ranges ?

This is explained in the commit message of a subsequent patch,
"vfio/iommufd: reconstruct device"

- Steve

>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/iommufd.c             | 4 ++--
>>   include/hw/vfio/vfio-common.h | 2 ++
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index a3e7edb..2f888e5 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -442,8 +442,8 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
>>       return ram_block_uncoordinated_discard_disable(state);
>>   }
>> -static bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>> -                                             uint32_t ioas_id, Error **errp)
>> +bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>> +                                      uint32_t ioas_id, Error **errp)
>>   {
>>       VFIOContainerBase *bcontainer = &container->bcontainer;
>>       g_autofree struct iommu_ioas_iova_ranges *info = NULL;
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 5a89aca..ca10abc 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -268,6 +268,8 @@ bool vfio_cpr_register_container(VFIOContainerBase *bcontainer, Error **errp);
>>   void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer);
>>   bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp);
>>   void vfio_legacy_cpr_unregister_container(VFIOContainer *container);
>> +bool iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
>> +                                      uint32_t ioas_id, Error **errp);
>>   extern const MemoryRegionOps vfio_region_ops;
>>   typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
> 


