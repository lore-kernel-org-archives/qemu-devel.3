Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA267C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 16:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3FF-00044V-B2; Mon, 19 May 2025 12:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH3FC-00042r-FM
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:21:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uH3F7-00048o-Ie
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:21:38 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGExjY028313;
 Mon, 19 May 2025 16:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7x2o0PBE6wekdwqtxceH1WWqvnIRdFk8cVYN9qjMMtQ=; b=
 DlfILUYSkLM+6npQmmFbReTlbugn3CONtHKpRYfDXUruxSNcmm0+L0HOHk/25VrL
 aV2VWCs6sZFxMOdeCSYl5pdCqzXf3qWTOaqTmrJFbEgpCENKl3a4NIxj+panKcr3
 OQKFd7JOmr4HW027bb0QTNP5vr0WDpvMvWdvnA40DFSAIaOnMdcDD1XEB2ZbmBlY
 /4YoSy/KARX6K0JTIOJjLTJIKFgEAYItZJcBm1uR2S6BiNXEsDDFRENSxjb+7yaO
 NkkLdzM2Ju7+s3IzYQ3lmpfDK0Z/iPzNRAdjizwYtgYjR4TbfLz5OGkL70gAyVzN
 SnB1k1RqRjitTV3OLOhuMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46phcdug31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 16:21:29 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54JF1fEp000820; Mon, 19 May 2025 16:21:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw6wxy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 May 2025 16:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPWW7F8G701ZMDqPf1t+04y33pgIKdHlSDO4O1M5Ja/ZFQo8OQjY7wlmGKSK3piq+Bzdc07Qj6/S9Q8zw4pu4/ZxtZwfy6aFUMRbrpL8GhKAxVNMdSTef/ARs55NeXJt53/wfgpZjqhbwl9or6TwSeR8YYe8M93Phbsju9TlN5NqqbCdKKdzf9AwxuBUhq8mTLBzHzyxBC1wXB8omcb9AOFB4TA+AU7zC6bXic3kMmiFfZC+LCEtYFtuF1Nu5McMnZhNNIeyzfhHZCtLTFjt4WWuaMcJPz1tTSnPk8gU38wx56NHNr4WM1/pg2odp319ZAd43T/vvID3+7R8Rl8O7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7x2o0PBE6wekdwqtxceH1WWqvnIRdFk8cVYN9qjMMtQ=;
 b=yJIBUxFIXPuSlk/uRSVAIcqGifK1RcYI4287a6qB/FJhE1jmBBgQq5DZsMZAwg2zXc3AIm07sCKHtR+HdwW/FJQrHEhn9DygaoOI0lQJaFjRghIXnP40B4FA2Y0fYjOJlWfu3Z09AChhll41cV0OR/TRXguhz/ud4fYVU1TYgGGEKoIEW/zWnNxMmW92G9UyU4lAif86AyROVqKjwNT9PQi4d5u7DIn9xSWIsv7msYnkmTfbalzHOQU/nCEmhFv535BmlWHEv2zeoIfm/EBgClPIy1JlEO5NILCgUEFHC6L/4GTcFKaVfjw9fCSVmbryddQ5sXLnwtg7XB/OY7hyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7x2o0PBE6wekdwqtxceH1WWqvnIRdFk8cVYN9qjMMtQ=;
 b=xjVmBB6QiNKQlsKHIW0e9y52ZEv8vMoUKNR4s1SGYWIQl3vyDGsJ6eYmxLukTiV0gVNYoeVxpwfo+uKtk4qOjh/JS1HPQJ8czqU02EIe8C2FGV/vHt8EjJKNI1jEUf3BJ5rKbYaAIKgaj9RTsCYYAbfhd6/oNgAWsDlBeKJ8N7s=
Received: from CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7)
 by PH7PR10MB7088.namprd10.prod.outlook.com (2603:10b6:510:268::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Mon, 19 May
 2025 16:21:25 +0000
Received: from CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54]) by CH3PR10MB7436.namprd10.prod.outlook.com
 ([fe80::dfba:d89:d13d:cd54%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 16:21:25 +0000
Message-ID: <e0f6f12a-cf77-465d-ae91-6e3cf1b3a070@oracle.com>
Date: Mon, 19 May 2025 12:21:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 07/42] vfio/container: preserve descriptors
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-8-git-send-email-steven.sistare@oracle.com>
 <90ee0578-44f7-4e42-b69e-934833199eaf@redhat.com>
 <8a2d690b-c49f-4ee0-8887-b0f7c438c3a0@oracle.com>
 <535df78b-0574-406f-a514-b10bafa57ba9@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <535df78b-0574-406f-a514-b10bafa57ba9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To CH3PR10MB7436.namprd10.prod.outlook.com
 (2603:10b6:610:158::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7436:EE_|PH7PR10MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 201bda17-cde0-44a6-84f9-08dd96f13397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eSsrYjltZkxBdkI5WHkwZkV5VnBqNVVGZStlM2NDME55OUVKb2FFVW1UeXNP?=
 =?utf-8?B?bEYySFpwYzlIVHRqSU9uTWdDNlMwYVBSazNvbWo3SjNkeEo3cUwwenRNOGdM?=
 =?utf-8?B?bXJ4a05aR0p6SXZmYUgyVzJRNVpwVk1hNjNPVnlkbTZ1NDFESGZWNGRMWStj?=
 =?utf-8?B?SWcwTnRBdEJoY0x6ZkJtK3NVd1RaeWd3Q1YyY05PZXpkd2YyMGFXemtIK3hQ?=
 =?utf-8?B?YTBFZmFsS051Z0hXOEZwcEE1MTI3eDVmZjFiOUZFcUIzQ0ErMzZsTnBaeGM2?=
 =?utf-8?B?aGxXVzg0L212TzZGL3cwYkhzeVpqOUVjaGdVbzRnV3ExemQwRm43cHVUNkYw?=
 =?utf-8?B?MDlOeEJkVDBSTUhEKytlQzJ6QUhPbDd6Rlhtcm9ObkhSRXB1K1l2TVZzYVNY?=
 =?utf-8?B?bmJ3NjhoSU5rSTdMK1haakk3ZktQVFJ0YnJMRzhQUTBZdHNFQVJGODA4clBZ?=
 =?utf-8?B?eHFVU2FMNG51TFFsRE5jMjZ0NE8vWm9JSXFwOGIxQk1OVWhDSU01dE95Q2s2?=
 =?utf-8?B?RXBKbVNKLzJnL1dyZXZDVkJpaENFY2dRWGkvZnhCSVRVaHZzdzBkeWRpNG1Q?=
 =?utf-8?B?K0VEL0haS1JTN2tISTJpOXNVeTZOUzJlL3BHcW9BRmhxVmtjZ0ZqRUJoQ2ps?=
 =?utf-8?B?UFhXRldHN2FWZzNDaVFxaWdoN1VrZmU3Z3I2d2dPbk1BQXNrLzRZeXNhQW9w?=
 =?utf-8?B?NEtiTEtiL0dqMk5ET1plaHBGQmJUbFBaNGE0YWwwM0pwS05jdUx2dG9aZ3ZE?=
 =?utf-8?B?MkU5d1dmWFRYWHgwcjBRdE5xTlBUY1I3VHBhYWt5a1RhQ1diZWoxR096WHZl?=
 =?utf-8?B?dHNiQ0RESGNUT3FzaEk0VURPdjRCUkNSb2poVFFheTNNbVZRWndhOFAzdG92?=
 =?utf-8?B?Y0hFWWdpcENKQ1RSQmprNlI1NlZ2ZVE1d3QxbENXYW5xZ2RhWTJLTk96U2w1?=
 =?utf-8?B?aG9Udm5BTDFmMEViNm1OZ1R2c1VYaEM0Zll1L1BiQ0hRYUhIa3g4aHFVUGJI?=
 =?utf-8?B?WmREbjhOWjMzYTgxdkdxc0JIQnFpejFnaDF5SktPN0N4eVBIMXB6WkRIbTcx?=
 =?utf-8?B?ai9GRjl2ZGgxMlN0L0YyNHVDMXRSS3BjZTJDVjlxMlF0NUxkdUQxOXdkcUlU?=
 =?utf-8?B?L2FSeW00Z0JuS1A3bmZXcTVoRUNEZkRTeC9WWnJnQ0FyVXNwcHVRV2tSSVkv?=
 =?utf-8?B?Qk9EV09odXhWd2NJTmhNaTZoMW5kbnBBOGt6bmlMOWNLSUQ5UmlBVlk4L1pq?=
 =?utf-8?B?SDNldEhmOUxCN2pBcG5ONGNORnltMkFqcThoMXFUZFVsQ3MzQ1JCbzRBWWl6?=
 =?utf-8?B?Y2UvdDJNejF2WUk5SjE0VmNQRmMrNVdjbVlTckpZbUdlQ0x6cjZNR2J6blZZ?=
 =?utf-8?B?VzNWaDBKNi9jNUxzRU4xVi9jTi9XSXo3Tk1zN0czcGJWQVpVQWdvZnFWeGE2?=
 =?utf-8?B?VXNKKzZmczRLajM4TUZhWHdzRm53WHBiNmxIR2ZyZzFETk1rVTlPVER2cWor?=
 =?utf-8?B?b2svckZWYjJCaitCQlFFb0VyT2NGcldjazJxYTl3VURlUjJ1U1lpT042Risr?=
 =?utf-8?B?ajhGN1loemozTW54emlvU094ZFVyNFR2V3VoTUhxR1NzalREd0l6Sno4cUdr?=
 =?utf-8?B?aU1GZlhXa1F4UHBqa2NRcjI4SWJqN011TmZuRFFNeTdyMVZyQjg3U0x0RkxG?=
 =?utf-8?B?T0w3S1JScE5aMTh3bE1Xbm1SY3BtOCtMa3hhOVZJYVpqU2xZV0dPZUJGd2lJ?=
 =?utf-8?B?dmNtdUlCWnhBQk9VSlNoeGpsVi9CZXViaHZYTUFhdW4rbHR1R3Y4V2ZmR1Nn?=
 =?utf-8?B?SXdmNXJCVVRoZVN2SE44aHh4dnNaZzdlV1lTNWlEUmxQOTVmajVOMTBZaDdY?=
 =?utf-8?B?dW96UGp1aWFneWhEYldRNzV1bXlaZ2diTm9QWC9Bb040eXk2cVJXbDFZajN4?=
 =?utf-8?Q?wXtu6VPIQ3s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR10MB7436.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWRxclZIdkdLalZvS1VVQTlXNDNOZnAzV0d1Z25JbmRKMGxuaFZvZ2VNeWcw?=
 =?utf-8?B?T09lbGkzd0RQMlBYMWE3R3VUbVdleTk0N2VYY2pmeUNMMW5NQjlzakJYTkY4?=
 =?utf-8?B?V2pveTVndEs5K3RvdENmYmpKaWt5K3pqRm00cCtxeFp2WWtrZldzaHIxN0dO?=
 =?utf-8?B?RWhkNWtmZ3dHWlVhVGNtc0cwVVFqRnBKUkZrM2NSTWVUVUZiMEtDYUVMREh2?=
 =?utf-8?B?TFVleGNVMFNDT2ZmUXl5SU8yN0hmNFptbWlrVWljei9raEVyWDZZcXN3WWpB?=
 =?utf-8?B?alZ0QzFPNnJXWVU1azdqYkxhMzNhbGtKMTkrN0puRWtSb0tHUWVaZ2p4VlhP?=
 =?utf-8?B?N3lEemRxZncwUFZySjd1a3hGek9OdU5zREZ0UlUvb3BHSDVzRFVCWWNYVElo?=
 =?utf-8?B?V1I0c3cwY3BoOWZnY0JBbGttVVJ0QTh3MCtMTVZUMi9VOEtocGRxTm1HUUNH?=
 =?utf-8?B?eVFEOGRaZTUxanZQa1lCaDc3NTRPOTVUSmQyWUY2Q3RHYUpPb1Z6WktLaTVu?=
 =?utf-8?B?SjRUZ1FKUGhHK0xxZDUyZnh0NTJaSENmMnFQaDFQQkxma3NxS3BJQWMyY000?=
 =?utf-8?B?UlFIdjdHMkY5N1BiaHNyYTlVWjJPU2RhMEV6T2FpbkYwQ1pHc1hONnBTUTIz?=
 =?utf-8?B?V0dBOGJ3RzRoQWV4WEIzak9yMWpUZ3dTek9vTlNVZnRlQVZnT2hrV2lFbWdM?=
 =?utf-8?B?M2t1V25tRFBKZm4vcTQ1NzIrZDZSL0JGUHh0bC9GMC94cTFqOFh3TUF1YVdo?=
 =?utf-8?B?M1dnVnl0Yk4wczl4WU9tMk00RXZiRWlmU05FbitnMFRPNDF2SXBPa0ZyOVEv?=
 =?utf-8?B?NzZsME9WOVdmN2RibjhTZWV4aWNmVEdVek5RZC8vZ0tSbUdXUXNZZ1pmS3FB?=
 =?utf-8?B?bFQzV2hQTXFUWERxZ2JJV1VmZW91RTJnc1JhZmtmTnhycUNOUjM0V2VnQ0tH?=
 =?utf-8?B?djNhNlhlellLMW93NzdXZjBJb1hvTytFNVEwS2JNMzByZ0V5TVV4RkN2YlJy?=
 =?utf-8?B?djNWQk9rQU5LL3VzNFo1SmVNZmdYbzE0aHNjVDVxWTF5Q3RZYkNYaHZwUW8r?=
 =?utf-8?B?NUdibkN4RnkvU2N3MHFhdUNVUGh3cE1OQloyS1hiOFkxdzdiNm5VUGpKMjQ5?=
 =?utf-8?B?bmc0Q0V4WW42Y3Vhc1o5SUZYQ2NiZ21QU1RTa2hnU2tEcnY2aHZRRGZ5bnl1?=
 =?utf-8?B?dDQ4TysxbjA1VTBsa1FmcEtsM3FDNHVBU0hBVXg1eHRWcG9IZTdWOXBJVll5?=
 =?utf-8?B?K2M1QWxpaW1XQjB4S0dZNlMrUXh4MmIrbStaMDFERTR2d0xya2FJRm5aSWQw?=
 =?utf-8?B?UnpqQUE5aFZ4RjlFOTAzdVhUNklaUEtRMGpLREp5QXpJbTAwTEVBek9ONWw5?=
 =?utf-8?B?dVdZbkVVWmsyZExndGdHSVNldUJiekFiNkFVL2ZWd1E5Nml4bjZuQzUvOTNM?=
 =?utf-8?B?NWdsbEJHYzZWVUJGZGxlaGl1dEd0d1VHWFo1K2Znd2FoOS9UWkhWZEx4S2xP?=
 =?utf-8?B?NGZoQnVMMmhCZDVOemJXM25BM1laMmZRUW1Td0hydWlpT0RoWElnQmRHeW5K?=
 =?utf-8?B?LzRaemJDZEk3bmdsWGp5ekk2WEh1K2h2SSsyVGNIdzRoU1pCUWlZTE5yRWFv?=
 =?utf-8?B?V3JxRWdtRWpwK1Vxb2hCc0lOVEVsMHV2UDVwdGU0MDhBbi9xN0ZKR2tTczgr?=
 =?utf-8?B?Qnk4QnpLczgyd05zMCt5aWQ0VmkzY0hZVll2YUZRb2IrbWZSODN5VFVkMkVD?=
 =?utf-8?B?UE5QZDhpSnU2dVJtZWhkbkJWMlIydGEyZitZTlFyNVpKSUtYaGxWaFg3cmN5?=
 =?utf-8?B?UFVlcTQ3U291d1haaVdiWlhKTk9laW9RbWdOOFhUM0NOenhsZ0MvSnpBaFpB?=
 =?utf-8?B?QXc3MUovTmYwNitJcldEdkhSZHpldEhYZ2pENzcrMkFjWEpMVCs0VlJIYnNn?=
 =?utf-8?B?NDhrcU50TFAzd2U4QkNvUmhhalJNL2FsWElqNHJDdk1yZXZ5bjc3VEV6aEl2?=
 =?utf-8?B?eVdnejkzNmd3d0JvWHczWGI4YlRjVnVxeFJFS3crdFNxS1FsVy94VkNDSlNh?=
 =?utf-8?B?MUE5eUFnVTJUdWxwZCtudWNUbEdLdE5sY0Zyei9aRHUvaG51bzkyM3N5THFZ?=
 =?utf-8?B?dk5FblBSRjloUUZsWjZXMEsyRktad0lVemZQZCtpZE94SHFXSk1nNmpvTGwv?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rKsKHhCv7keGS+kLveBK0FAvJZcnQ6V35PCMMQ/qROOhY3lMYLYkGdKy1HymNSyaowe9P304ahEES6KCnmhULQjWgL5OjIoJqciD8fEfN35Mcng6lZwmDd6Qvreze/gHEyiO5mGz8y3Ne7dbqNccQiR9CBitg9mpGPZK/4/TYcO8lb9Zz7vyJUq71IlPFZDOj/DftrYtqo0lXuMnTHrHFcw8fLG57uZTsIbSW4p8BVlfpnj6w5SJ4nMK1B94ZnfS37CNwqIV2xmJu2KVvrwRPIqrpylPbOTaVCxjRAP2qkVIpMdJ16DEbOJ4QBIAM+JW0VmCqTLeUrSkBmvlBAuaxgzGARCn8nUw7uXWgVhOB0Br+4tT5fnF0f7lshL7pC7Ix3iGbdqLYQ/g+xBs6r3LOCIOLCPoDINDr90/xksmDebX2OE5YblYrdrXitTSafwpwt1g0CjzohxrDpXHMeCQJnedSPzEcEuUfJD9Jx/ev9S5Vsb3KswGBtUoZzETIK5BN9FTMcOy/9qQ3hOs1ETpdW5a0apfTsgE2HJ7BldBuGegL72kIpntuvF8ZlhNj6VEVd683PbPr3tEWWBraCuJcamZwgireuVP+vOhtdS3McM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 201bda17-cde0-44a6-84f9-08dd96f13397
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7436.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 16:21:25.6010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tY/AHhXawRYcKBPSWtaSw+ltY8IuTiviY1+01cEobLZKfQtL1094K3vePXl3q7DHqJ7avaDYmtUFm3FpRb/H6iCuPTS/jmGmPWPzeP9P3Z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190152
X-Authority-Analysis: v=2.4 cv=a6gw9VSF c=1 sm=1 tr=0 ts=682b5a89 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=GtHNnVf7gOhv1mAjZZAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:14694
X-Proofpoint-GUID: zrd6Mr4vQwqJoeSX_sviFwlx1L8Bww3c
X-Proofpoint-ORIG-GUID: zrd6Mr4vQwqJoeSX_sviFwlx1L8Bww3c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE1MiBTYWx0ZWRfX16QNDP75OsQD
 EwCTAd9RpvemUnUXg5g6gUmt5FQPi7pHGv4UBf4ktmBLqVkffWGQpFed1QsmUE5XLZ02PJmbPJL
 rRuMtgGdw+Nnv3/JzH4TztXoUTyk1arbSM88pdtp2PG6MNHroQ4fDE+A0ujYiLZ+M/ej8uX3oVD
 JUAu1Na9GGIt96iuqOuNl4EqBQChICWWk+K8jSXXNxeLQj1SYZ/Da+dPUpZu3DlSDo4P7IflIqD
 9qXnO1VaM7nWxPbEgiJnJ9pm0zVWWuo228Li5ZSonIcMGhNNrmGYozdUuFdvAn7HGGRfKVsAUgF
 bXZnGEFAdU802Cu+pZOaE2qQQ6hxVHhD8+s+O2UcbqE7PTyrDffPAa54rWSbuZpnbO0gIhR695g
 zHZQDpNYPI4glAdsBgxlPOqsts1+gUNszc822Zvtby5oSUYnj59Uv9IGY60fHgl8HxcOWJm4
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 5/19/2025 9:20 AM, Cédric Le Goater wrote:
> On 5/15/25 21:08, Steven Sistare wrote:
>> On 5/15/2025 8:59 AM, Cédric Le Goater wrote:
>>> On 5/12/25 17:32, Steve Sistare wrote:
>>>> At vfio creation time, save the value of vfio container, group, and device
>>>> descriptors in CPR state.  On qemu restart, vfio_realize() finds and uses
>>>> the saved descriptors, and remembers the reused status for subsequent
>>>> patches.  The reused status is cleared when vmstate load finishes.
>>>>
>>>> During reuse, device and iommu state is already configured, so operations
>>>> in vfio_realize that would modify the configuration, such as vfio ioctl's,
>>>> are skipped.  The result is that vfio_realize constructs qemu data
>>>> structures that reflect the current state of the device.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>   hw/vfio/container.c           | 65 ++++++++++++++++++++++++++++++++++++-------
>>>>   hw/vfio/cpr-legacy.c          | 46 ++++++++++++++++++++++++++++++
>>>>   include/hw/vfio/vfio-cpr.h    |  9 ++++++
>>>>   include/hw/vfio/vfio-device.h |  2 ++
>>>>   4 files changed, 112 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>>>> index 85c76da..278a220 100644
>>>> --- a/hw/vfio/container.c
>>>> +++ b/hw/vfio/container.c
>>>> @@ -31,6 +31,8 @@
>>>>   #include "system/reset.h"
>>>>   #include "trace.h"
>>>>   #include "qapi/error.h"
>>>> +#include "migration/cpr.h"
>>>> +#include "migration/blocker.h"
>>>>   #include "pci.h"
>>>>   #include "hw/vfio/vfio-container.h"
>>>>   #include "hw/vfio/vfio-cpr.h"
>>>> @@ -414,7 +416,7 @@ static bool vfio_set_iommu(int container_fd, int group_fd,
>>>>   }
>>>>   static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>>> -                                            Error **errp)
>>>> +                                            bool cpr_reused, Error **errp)
>>>>   {
>>>>       int iommu_type;
>>>>       const char *vioc_name;
>>>> @@ -425,7 +427,11 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>>>           return NULL;
>>>>       }
>>>> -    if (!vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>>>> +    /*
>>>> +     * If container is reused, just set its type and skip the ioctls, as the
>>>> +     * container and group are already configured in the kernel.
>>>> +     */
>>>> +    if (!cpr_reused && !vfio_set_iommu(fd, group->fd, &iommu_type, errp)) {
>>>>           return NULL;
>>>>       }
>>>> @@ -433,6 +439,7 @@ static VFIOContainer *vfio_create_container(int fd, VFIOGroup *group,
>>>>       container = VFIO_IOMMU_LEGACY(object_new(vioc_name));
>>>>       container->fd = fd;
>>>> +    container->cpr.reused = cpr_reused;
>>>>       container->iommu_type = iommu_type;
>>>>       return container;
>>>>   }
>>>> @@ -584,7 +591,7 @@ static bool vfio_container_attach_discard_disable(VFIOContainer *container,
>>>>   }
>>>>   static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>>>> -                                     Error **errp)
>>>> +                                     bool cpr_reused, Error **errp)
>>>>   {
>>>>       if (!vfio_container_attach_discard_disable(container, group, errp)) {
>>>>           return false;
>>>> @@ -592,6 +599,9 @@ static bool vfio_container_group_add(VFIOContainer *container, VFIOGroup *group,
>>>>       group->container = container;
>>>>       QLIST_INSERT_HEAD(&container->group_list, group, container_next);
>>>>       vfio_group_add_kvm_device(group);
>>>> +    if (!cpr_reused) {
>>>> +        cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>>>> +    }
>>>
>>> Could we avoid the test on cpr_reused always call cpr_save_fd() ?
>>
>> No.  If cpr_reused is true, then the fd is already on cpr's save list.
>> We don't want to save duplicates of the same entry.
> 
> Can't we call cpr_find_fd() like in cpr_open_fd() ?

I could indeed, and you have re-invented the cpr_resave_fd() helper which was
used here and elsewhere in V2, and Peter didn't like it.

Peter said:
   If the caller know the fd was created, then IIUC the caller shouldn't
   invoke the call.
   For the other case, could you give an example when the caller may have been
   created, but maybe not?

I said:
   It avoids the need to remember that an fd was reused, and test that fact before
   calling cpr_save_fd.  And sometimes those operations occur in different functions.
   Thus resave saves a few lines of code.

Peter, can I bring back cpr_resave_fd() ?

>>>>       return true;
>>>>   }
>>>> @@ -601,6 +611,7 @@ static void vfio_container_group_del(VFIOContainer *container, VFIOGroup *group)
>>>>       group->container = NULL;
>>>>       vfio_group_del_kvm_device(group);
>>>>       vfio_ram_block_discard_disable(container, false);
>>>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>>>   }
>>>>   static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>> @@ -613,17 +624,37 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>>       VFIOIOMMUClass *vioc = NULL;
>>>>       bool new_container = false;
>>>>       bool group_was_added = false;
>>>> +    bool cpr_reused;
>>>>       space = vfio_address_space_get(as);
>>>> +    fd = cpr_find_fd("vfio_container_for_group", group->groupid);
>>>> +    cpr_reused = (fd > 0);
>>>
>>>
>>> The code above is doing 2 things : it grabs a restored fd and
>>> deduces from the fd value that the VM is doing are doing a CPR
>>> reboot.
>>>
>>> Instead of adding this cpr_reused flag, I would prefer to duplicate
>>> the code into something like:
>>>
>>> if (!cpr_reboot) {
>>>     QLIST_FOREACH(bcontainer, &space->containers, next) {
>>>          container = container_of(bcontainer, VFIOContainer, bcontainer);
>>>          if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>>>              return vfio_container_group_add(container, group, errp);
>>>          }
>>>      }
>>>
>>>      fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>>      if (fd < 0) {
>>>          goto fail;
>>>      }
>>>
>>>      ret = ioctl(fd, VFIO_GET_API_VERSION);
>>>      if (ret != VFIO_API_VERSION) {
>>>          error_setg(errp, "supported vfio version: %d, "
>>>                     "reported version: %d", VFIO_API_VERSION, ret);
>>>          goto fail;
>>>      }
>>>
>>>      container = vfio_create_container(fd, group, errp);
>>> } else {
>>>     /* ... */
>>> }
>>>
>>
>> OK, but there is no sense in duplicating the identical code for
>> VFIO_GET_API_VERSION and vfio_create_container.  If you want me to
>> simplify the loop, I suggest:
>>
>> if (!cpr_reused) {
>>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>>           if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>>               return vfio_container_group_add(container, group, false, errp);
>>           }
>>       }
>>
>>       fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>       if (fd < 0) {
>>           goto fail;
>>       }
>> } else {
>>      QLIST_FOREACH(bcontainer, &space->containers, next) {
>>          container = container_of(bcontainer, VFIOContainer, bcontainer);
>>          if (vfio_cpr_container_match(container, group, &fd)) {
>>              return vfio_container_group_add(container, group, true, errp);
>>          }
>>      }
>> }
>>
>> ret = ioctl(fd, VFIO_GET_API_VERSION);
>> ...
> 
> OK. Let's do that. I find it easier to read.

will do.

>>>> +    /*
>>>> +     * If the container is reused, then the group is already attached in the
>>>> +     * kernel.  If a container with matching fd is found, then update the
>>>> +     * userland group list and return.  If not, then after the loop, create
>>>> +     * the container struct and group list.
>>>> +     */
>>>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>>>           container = container_of(bcontainer, VFIOContainer, bcontainer);
>>>> -        if (!ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>>>> -            return vfio_container_group_add(container, group, errp);
>>>> +
>>>> +        if (cpr_reused) {
>>>> +            if (!vfio_cpr_container_match(container, group, &fd)) {
>>>
>>> why do we need to modify fd ?
>>
>> That is explained by the comments inside vfio_cpr_container_match, where the
>> explanation is more easily understood.
> 
> I haven't been able to see what a modified fd was useful for before because
> we test cpr_reused and in other places !cpr_reused :
> 
>          if (cpr_reused) {
>              if (!vfio_cpr_container_match(container, group, &fd)) {
>                  continue;
>              }
> 
> and later
> 
>      if (!cpr_reused) {
>          fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>      }
> 
> I think I got it now. This was a bit confusing.
> 
>>
>>>> +                continue;
>>>> +            }
>>>> +        } else if (ioctl(group->fd, VFIO_GROUP_SET_CONTAINER, &container->fd)) {
>>>> +            continue;
>>>>           }
>>>> +        return vfio_container_group_add(container, group, cpr_reused, errp);
>>>> +    }
>>>> +
>>>> +    if (!cpr_reused) {
>>>> +        fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>>>       }
>>>> -    fd = qemu_open("/dev/vfio/vfio", O_RDWR, errp);
>>>>       if (fd < 0) {>           goto fail;
>>>>       }
>>>> @@ -635,7 +666,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>>           goto fail;
>>>>       }
>>>> -    container = vfio_create_container(fd, group, errp);
>>>> +    container = vfio_create_container(fd, group, cpr_reused, errp);
>>>>       if (!container) {
>>>>           goto fail;
>>>>       }
>>>> @@ -655,7 +686,7 @@ static bool vfio_container_connect(VFIOGroup *group, AddressSpace *as,
>>>>       vfio_address_space_insert(space, bcontainer);
>>>> -    if (!vfio_container_group_add(container, group, errp)) {
>>>> +    if (!vfio_container_group_add(container, group, cpr_reused, errp)) {
>>>>           goto fail;
>>>>       }
>>>>       group_was_added = true;
>>>> @@ -697,6 +728,7 @@ static void vfio_container_disconnect(VFIOGroup *group)
>>>>       QLIST_REMOVE(group, container_next);
>>>>       group->container = NULL;
>>>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>>>       /*
>>>>        * Explicitly release the listener first before unset container,
>>>> @@ -750,7 +782,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>>>       group = g_malloc0(sizeof(*group));
>>>>       snprintf(path, sizeof(path), "/dev/vfio/%d", groupid);
>>>> -    group->fd = qemu_open(path, O_RDWR, errp);
>>>> +    group->fd = cpr_open_fd(path, O_RDWR, "vfio_group", groupid, NULL, errp);
>>>>       if (group->fd < 0) {
>>>>           goto free_group_exit;
>>>>       }
>>>> @@ -782,6 +814,7 @@ static VFIOGroup *vfio_group_get(int groupid, AddressSpace *as, Error **errp)
>>>>       return group;
>>>>   close_fd_exit:
>>>> +    cpr_delete_fd("vfio_group", groupid);
>>>>       close(group->fd);
>>>>   free_group_exit:
>>>> @@ -803,6 +836,7 @@ static void vfio_group_put(VFIOGroup *group)
>>>>       vfio_container_disconnect(group);
>>>>       QLIST_REMOVE(group, next);
>>>>       trace_vfio_group_put(group->fd);
>>>> +    cpr_delete_fd("vfio_group", group->groupid);
>>>>       close(group->fd);
>>>>       g_free(group);
>>>>   }
>>>> @@ -812,8 +846,14 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>>>   {
>>>>       g_autofree struct vfio_device_info *info = NULL;
>>>>       int fd;
>>>> +    bool cpr_reused;
>>>> +
>>>> +    fd = cpr_find_fd(name, 0);
>>>> +    cpr_reused = (fd >= 0);
>>>> +    if (!cpr_reused) {
>>>> +        fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>>>> +    }
>>>
>>> Could we introduce an helper routine to open this file,  like we have
>>> cpr_open_fd() ?
>>
>> OK, but this would be the only use of the helper, and it would bury
>> generic vfio functionality -- VFIO_GROUP_GET_DEVICE_FD -- inside a cpr
>> flavored helper.  IMO not an improvement.
> 
> VFIO_GROUP_GET_DEVICE_FD would still be passed as a parameter and
> so it won't be buried IMO. I don't dislike it that much.

OK.

> However, I don't like the "if (cpr_reused)" statements scattered
> throughout the code, so I'm looking for ways to bury them.

cpr_resave_fd will help.

- Steve

>>>> -    fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>>>>       if (fd < 0) {
>>>>           error_setg_errno(errp, errno, "error getting device from group %d",
>>>>                            group->groupid);
>>>> @@ -857,6 +897,10 @@ static bool vfio_device_get(VFIOGroup *group, const char *name,
>>>>       vbasedev->group = group;
>>>>       QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
>>>> +    vbasedev->cpr.reused = cpr_reused;
>>>> +    if (!cpr_reused) {
>>>> +        cpr_save_fd(name, 0, fd);
>>>
>>> Could we avoid the test on cpr_reused always call cpr_save_fd() ?
>>
>> No.  Must avoid adding duplicate entries.
>>
>>>> +    }
>>>>       trace_vfio_device_get(name, info->flags, info->num_regions, info->num_irqs);
>>>>       return true;
>>>> @@ -870,6 +914,7 @@ static void vfio_device_put(VFIODevice *vbasedev)
>>>>       QLIST_REMOVE(vbasedev, next);
>>>>       vbasedev->group = NULL;
>>>>       trace_vfio_device_put(vbasedev->fd);
>>>> +    cpr_delete_fd(vbasedev->name, 0);
>>>>       close(vbasedev->fd);
>>>>   }
>>>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>>>> index fac323c..638a8e0 100644
>>>> --- a/hw/vfio/cpr-legacy.c
>>>> +++ b/hw/vfio/cpr-legacy.c
>>>> @@ -10,6 +10,7 @@
>>>>   #include "qemu/osdep.h"
>>>>   #include "hw/vfio/vfio-container.h"
>>>>   #include "hw/vfio/vfio-cpr.h"
>>>> +#include "hw/vfio/vfio-device.h"
>>>>   #include "migration/blocker.h"
>>>>   #include "migration/cpr.h"
>>>>   #include "migration/migration.h"
>>>> @@ -31,10 +32,27 @@ static bool vfio_cpr_supported(VFIOContainer *container, Error **errp)
>>>>       }
>>>>   }
>>>> +static int vfio_container_post_load(void *opaque, int version_id)
>>>> +{
>>>> +    VFIOContainer *container = opaque;
>>>> +    VFIOGroup *group;
>>>> +    VFIODevice *vbasedev;
>>>> +
>>>> +    container->cpr.reused = false;
>>>> +
>>>> +    QLIST_FOREACH(group, &container->group_list, container_next) {
>>>> +        QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>> +            vbasedev->cpr.reused = false;
>>>> +        }
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>>   static const VMStateDescription vfio_container_vmstate = {
>>>>       .name = "vfio-container",
>>>>       .version_id = 0,
>>>>       .minimum_version_id = 0,
>>>> +    .post_load = vfio_container_post_load,
>>>>       .needed = cpr_needed_for_reuse,
>>>>       .fields = (VMStateField[]) {
>>>>           VMSTATE_END_OF_LIST()
>>>> @@ -68,3 +86,31 @@ void vfio_legacy_cpr_unregister_container(VFIOContainer *container)
>>>>       migrate_del_blocker(&container->cpr.blocker);
>>>>       vmstate_unregister(NULL, &vfio_container_vmstate, container);
>>>>   }
>>>> +
>>>> +static bool same_device(int fd1, int fd2)
>>>> +{
>>>> +    struct stat st1, st2;
>>>> +
>>>> +    return !fstat(fd1, &st1) && !fstat(fd2, &st2) && st1.st_dev == st2.st_dev;
>>>> +}
>>>> +
>>>> +bool vfio_cpr_container_match(VFIOContainer *container, VFIOGroup *group,
>>>> +                              int *pfd)
>>>> +{
>>>> +    if (container->fd == *pfd) {
>>>> +        return true;
>>>> +    }
>>>> +    if (!same_device(container->fd, *pfd)) {
>>>> +        return false;
>>>> +    }
>>>> +    /*
>>>> +     * Same device, different fd.  This occurs when the container fd is
>>>> +     * cpr_save'd multiple times, once for each groupid, so SCM_RIGHTS
>>>> +     * produces duplicates.  De-dup it.
>>>> +     */
>>>> +    cpr_delete_fd("vfio_container_for_group", group->groupid);
>>>> +    close(*pfd);
>>>> +    cpr_save_fd("vfio_container_for_group", group->groupid, container->fd);
>>>> +    *pfd = container->fd;
>>>
>>> I am not sure 'pfd' is used afterwards. Is it ?
>>
>> True, good eye.  I will change it to "int fd" and stop returning the new value.
>>
>> - Steve
>>
>>>
>>>> +    return true;
>>>> +}
>>>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>>>> index f864547..1c4f070 100644
>>>> --- a/include/hw/vfio/vfio-cpr.h
>>>> +++ b/include/hw/vfio/vfio-cpr.h
>>>> @@ -13,10 +13,16 @@
>>>>   typedef struct VFIOContainerCPR {
>>>>       Error *blocker;
>>>> +    bool reused;
>>>>   } VFIOContainerCPR;
>>>> +typedef struct VFIODeviceCPR {
>>>> +    bool reused;
>>>> +} VFIODeviceCPR;
>>>> +
>>>>   struct VFIOContainer;
>>>>   struct VFIOContainerBase;
>>>> +struct VFIOGroup;
>>>>   bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>>>>                                           Error **errp);
>>>> @@ -29,4 +35,7 @@ bool vfio_cpr_register_container(struct VFIOContainerBase *bcontainer,
>>>>                                    Error **errp);
>>>>   void vfio_cpr_unregister_container(struct VFIOContainerBase *bcontainer);
>>>> +bool vfio_cpr_container_match(struct VFIOContainer *container,
>>>> +                              struct VFIOGroup *group, int *fd);
>>>> +
>>>>   #endif /* HW_VFIO_VFIO_CPR_H */
>>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>>> index 8bcb3c1..4e4d0b6 100644
>>>> --- a/include/hw/vfio/vfio-device.h
>>>> +++ b/include/hw/vfio/vfio-device.h
>>>> @@ -28,6 +28,7 @@
>>>>   #endif
>>>>   #include "system/system.h"
>>>>   #include "hw/vfio/vfio-container-base.h"
>>>> +#include "hw/vfio/vfio-cpr.h"
>>>>   #include "system/host_iommu_device.h"
>>>>   #include "system/iommufd.h"
>>>> @@ -84,6 +85,7 @@ typedef struct VFIODevice {
>>>>       VFIOIOASHwpt *hwpt;
>>>>       QLIST_ENTRY(VFIODevice) hwpt_next;
>>>>       struct vfio_region_info **reginfo;
>>>> +    VFIODeviceCPR cpr;
>>>>   } VFIODevice;
>>>>   struct VFIODeviceOps {
>>>
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>>
>>
> 


