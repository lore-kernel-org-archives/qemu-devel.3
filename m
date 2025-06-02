Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9ACC5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 12:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM4PV-0006zm-V2; Mon, 02 Jun 2025 08:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uM4PR-0006zS-Ae
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 08:36:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uM4PP-0006Qd-0q
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 08:36:57 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552C4avH025309;
 Mon, 2 Jun 2025 12:36:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0s9TSVAjpsERngjZ2FDW+DAOkYcucI/qUkPw8pROUCw=; b=
 hMOb7k+/+9Ysop5Q78Xn0o93q7qD2d9F8QBlPwNS92mKAgnd6rJA928xn4emipnn
 bQ2+hToiTum8fVHLpVHhs9MYqu9L5paW0ktHYRyx4Bpb0qL3Z4RWzNbjR++1NzRf
 Y9/zKuqHhYdWvWit55A1nkI+F43TfE10GJTzaov+BAJ3tfK879FY0H/CJpeCcKxo
 CQbQ8OX/pIqMv3yy3Pb8n9U8m3GXN/kj21LArcUNX63swOBD5NR75ikCnr71beKh
 GL2Pxxp3h0QTKlovrZ46aDmyatqI4MfZF2iGrDQUvroKc3xRbX9h5ztXmJve77eT
 KfLHtyfsQbil5sumIDiO/w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ysnctfs8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 12:36:49 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 552CIRno030717; Mon, 2 Jun 2025 12:36:48 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr77ws04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Jun 2025 12:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiByyDvysnw5bBKbT9VdSbMxFcKCTL+aydYGhWrP5vMmkru0jsRHlHao1SUvPihrEX9p4xgpNUgbz5CEaZYnvajolzcaKrGsIx2FgwOflucpVkIkCvr43OqRiCxKRFNU9AYkFOK6DAG+BL8mXAxfdSTCimRLzZtaFjD+5Ub7J8PBbQCyFmEmYkht88/joIk0XQuVW+WhZaLP3k/iRx+zerJXASv38LtJ4CJQRJ/oNySAnCJ10/QKb0b9+D0H1on5TdTUlKMIVVXzkrOvcTulFPmFls6CSKxZ9kCrurwoSgj2+GZA3ouLr6XGTNL6bT5L5JX5WrNN9gcSzrnpgk+lWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s9TSVAjpsERngjZ2FDW+DAOkYcucI/qUkPw8pROUCw=;
 b=Kp1mFO9K9LZ0ogXtScXzkfydaDVDh6SEKmMpCowQjqfQ3Kys032tdpfS9SBzRolbt7fnWNwOfZ3dRiGRxKo6v2LVvO9C+qVv4+y82ZlE7ZqhHW03WxF3uxqf2XDdUFsiWXG+HrfGvOl1Hwk0zc4GlJSc7ukhlSuxMBV7kwCH8XwgHgwimHHDlkPaCMxJ/OGmp8834zl8oPifz/wnh+VkFdquxc6RtCBo2LnSwxBheEo1j3ch8nLNDQxXCA1Z/SNHJSiM5tTTqPo+pdgrN21lHCFYTw1n0xiu6iV4F2Oh/rd17yb4PcDR8osWkzNCYLIbzW3MUw0LJmMW2gmiVH1qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s9TSVAjpsERngjZ2FDW+DAOkYcucI/qUkPw8pROUCw=;
 b=wL5a8efwhxxvijH/teRjZPvhkvlJ5+QG56lCBCEYNpKHvsrVaPQzYwXqjGsoIFJj4NF+wPnwl7k/fqC2oZ/011YjmJIeVuX6UKnpww1Pn9PtwNp2caDidI+cqWOM9U9ECoD4WLmCY5hJJm+0psRjuqRAghAxd0i+VE+6ISZOH08=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8090.namprd10.prod.outlook.com (2603:10b6:208:50e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 12:36:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.035; Mon, 2 Jun 2025
 12:36:45 +0000
Message-ID: <899ee161-2c5d-4aa2-aa64-5135b26bc3ff@oracle.com>
Date: Mon, 2 Jun 2025 08:36:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 16/43] pci: skip reset during cpr
To: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1748546679-154091-1-git-send-email-steven.sistare@oracle.com>
 <1748546679-154091-17-git-send-email-steven.sistare@oracle.com>
 <d62bd9c6-1660-4d16-8d7d-5445ba6c5031@redhat.com>
 <20250601150607-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250601150607-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0140.namprd11.prod.outlook.com
 (2603:10b6:806:131::25) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 861a5a39-c64e-47af-58c3-08dda1d222af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWFuSlRlK2wrQXVzTlFSSjF0SnpmT3J4eUNSS1J1aXVVNFNIZ2NveTdiN1lF?=
 =?utf-8?B?aEw1YnVYQlRLWEVqUDBjQ1RoQU9idjkrTUpVZ1dVSEdpNk5ic0tsU3pMRktj?=
 =?utf-8?B?V1l1blc2UlIrdFRDYUhxVnR3a3AreURlbytpMUJ4V2xqT0ZiZXhXVzJzTStG?=
 =?utf-8?B?MUJFeGU0K2dwM2Z2WTIzRTJnbkRJM0pzT09UemU5OFo3ak9rWGtEZU81dm9p?=
 =?utf-8?B?M3d0QVMvaVF3T1Y1Q21TWXJ3cUlPRXNxM1pqcS9sckJjZW92MWVjN1dPQWtX?=
 =?utf-8?B?bGxqVGduWEJJaGFmSjJ1RDVhUkdmVHVoT3Q2Zzg0VFVqbzB6SlJNRHU0NWpS?=
 =?utf-8?B?Si9ZZVVXSG1EVUxZS2JIV0twSjBKNFlUNUZQTmdPaG1qcTIwc3NpMTMvUVE4?=
 =?utf-8?B?QmppU0dPOU5jdkhFZU84bHY1L0FzK3dQVE02ME9xQ2dwbll6OVh1elVIZFdh?=
 =?utf-8?B?eVZqV0xQdzRKby9tMHpvTUo3aXpMK0FFL0RmS0J3SWRmZnV4ckZ3cmswekNa?=
 =?utf-8?B?djNpalRaY1RpWWNTUEtiTTZkWUg0Zk9JemdPNE0wbGNuNjNZVGh0MmhTck13?=
 =?utf-8?B?OVNkeVdNL0FoZjJsVmNxa3VTSFhSZTFHVlZQS054VEhoR3lEbzdPM2FxcFpi?=
 =?utf-8?B?MGorTnJDU2dBNlpnTHRJUmY2TlZhNko3WU1sWGxZTUM1T0dDWFkxM2VQVVRs?=
 =?utf-8?B?VG40K2pRc3F4cWFaMG15cldCY1VueVBLcjBGQnNpVG1DWDdpUExOV1VrM2lC?=
 =?utf-8?B?WHBjMFNveXV5dzJpOGtjSFB0YSs2UmFSN1F6cFZoZVVNTlhrdEplaVc2cHND?=
 =?utf-8?B?R2tFemVJR21VTHdqRDdkdTNFQ0VrNldJeGlxaVcwemVqRmFRWG1RS0xQZVhq?=
 =?utf-8?B?M0s5d0dnNnJKOStGMmtKd0l1VWZmOW5ZeGJwbjdkclpST0FOUTVwUG8rZWs2?=
 =?utf-8?B?V3JoNC93RnVlem8zTU1FSnAzSWFLcFVSUXkyN01SZWsyNnNwOE1zbGFWWG9m?=
 =?utf-8?B?a3dPVlUvNmhvcGs4ZlpyM3F1ZUJkbHBtR3VVSXAzWTRFUkI0N3J3eDR1VGpp?=
 =?utf-8?B?c0VGS2tQdExQS0VnOCthZEZNU2djMUt4SEdYcDB2RFlhb1VyRHMzNGVvaVN0?=
 =?utf-8?B?WUZnbkNUTzUzS0pneU5naCs4NkhCVFJQcXdJSjJuclVVTzlEd0RURlovQ0lr?=
 =?utf-8?B?eTE3NkM0MnYyNFhWUTZaMFJubHcxUVRYUmg5Um8reWtJczY2QXBWamRiTS9m?=
 =?utf-8?B?dEc3YUFHcjRjQnNUTW9uZ2pjMm9mTlZVY1pzU1Q4eENoV2dSSmJka01keG5t?=
 =?utf-8?B?SlhEODVyaXF5SWVlK09sTkNmTjJSUGNWRXByY2V6Tm5tTnFSWXJWQlFFd2VT?=
 =?utf-8?B?QS9wTHd2NnZOQnVXaS9LbmZQU0tRUjNmYjZ0cG1CK0FFaG9wS0tEbkh3VTB6?=
 =?utf-8?B?azgvajBvVDl0L0kzY25hdzcxSnRTK1VVdThMemNJY0VZa3VYQVIwOG5BZFVw?=
 =?utf-8?B?ZUNzN0JOTVM0RlFINXhhWDgrdi9xTmNWTDRxREF5S3lqK3hBRFJnMngyYTI2?=
 =?utf-8?B?U3VEYXpmL1lMUmhLZ1lSVUNSM2RnN2thcW5xak9BcmtPa0M4L0pnekZSRTdx?=
 =?utf-8?B?bXIwNTBnd2Nkc2F6TS9LV2xvUXF3S2JrdmlRRkEwZS9zc1Brd1FCQUpWR0dn?=
 =?utf-8?B?ZGI1NlkzN05zOFJEVytkOHJlMDFFT09VbDlOMUo4S2pzRENNdGN6TGFRbC95?=
 =?utf-8?B?RzBWYU1QSXFOVkxlYjdWWW1iK05WaS9Yd2ZhdGpIMzZHZGx3YnBpQnZma0d4?=
 =?utf-8?B?dysvY1pQQlRxYk83aWtHL3BUaCt1Rk9XZzZBNDhVb1NUYnRxcVVReFV5bE9K?=
 =?utf-8?B?MEx6N011NjdhTnlVazRMVXhMNy8vSkczRFRsSGpGL0pCN205WHpCL1oydEhR?=
 =?utf-8?Q?6FW7h7JLaSI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU1aUk42M0cwSmFxUnM5Uy92enN6dkpkSVJMSGM5T1A1RUJ5K21MMXE4MXll?=
 =?utf-8?B?bEx6MW5aSjJNbEdYS1RZRm5CaUpzK2pLdnlRVVdzSWltZmZHb0ZSb1crdXc1?=
 =?utf-8?B?elVsRFppNlllT20rMFdiR3g4MURWWGlwUEtEc0NHTWxvdGlPMThoWW5neVpN?=
 =?utf-8?B?U3pGZHhoWGlCZ3ZWcDBHcnVweDh0clRPcXVpSk9JMVN4NGtPY2xPSXRGNmNm?=
 =?utf-8?B?NGpwU21iRkNQa01VcExLZ0ZVa0tUYW5DR1Z6Q1E4RlhZdXFza2RqL1Z1TlNn?=
 =?utf-8?B?TS9WRUhDWGJCTmNDUjN4eXFDQ2YzUis3Mysva203cWxWWC9oWWx2SFBoNTNw?=
 =?utf-8?B?QnJqbEpUUjIxdFYvRFhXb1BwaHFNNWt3RS9neUVqK283S1grRENzUGJzak1F?=
 =?utf-8?B?WlloajNzc0xmdllYenV4bHpHdVp2ekRsQVJEVlY5NzdtN3BHdTFLWThaejNV?=
 =?utf-8?B?bjR6aDZ5UDFQempxZVY3cjBQZTUwVzZVNmUvajJyei9tWXRFNTh4aEZhaWFU?=
 =?utf-8?B?QkdEUERmNnhQaTBUc0h2OXlxYWNjMkVrczNuUmNJMkhQZThYWG5UQTh3VndB?=
 =?utf-8?B?QlE4ZWlvRlVtU2FhbFZQcjZaNkIxMWgwRElsS0hqUlBFLzh1eGFIdFZYQ0tx?=
 =?utf-8?B?VWdmTTQwVlVPbjdHWTU1MWNwZEwwcUpBc242QW10d0pQUUJydC9FTHNDVi9C?=
 =?utf-8?B?UlJGd0tuaVQzL245RzAvRUduLzZBUVRYdStYbUIxQ0JCclhSQ1p5aktYWjYx?=
 =?utf-8?B?OTVmVWlGT2tpc2JQNUMvMHVicHgxWnkzdjJuYnhJRGsvWmQxSHVzanhjZEQ5?=
 =?utf-8?B?TEd2TkViTUUrd0xxSW9tcG1xelJyYWdHOHZxVGdXcWVkd1ArZjROU2lXdHJR?=
 =?utf-8?B?TUo2Vkk1eDVJYno5MzdWbDJuWTNlZVRGNnBkTG9kOVY3RmZjRzhaaXBEUnZW?=
 =?utf-8?B?SGp3enhCdmlNRDdJRURzZXM5TzZnaG4yVnk4ak85OHFlRk9jNk0zOUFQanZX?=
 =?utf-8?B?dlh2Ly9aU2xHbE5YVnVYaWVvN0t4NVF5NUxBa1pvWTdSUVBXTnVnMUVJK216?=
 =?utf-8?B?ZEhZZGFQOXRyWmpobTIxenRUM3JYR21hSGhSelkzYU5tMVJoVkVJNFg5bHpZ?=
 =?utf-8?B?bDJ3OTI0QjlnUEtBUGhuUllXYmJSMTE1SzZiOWlCM2JGSDUvNVpPVlNuUFNQ?=
 =?utf-8?B?VEVHbWcyZmJtR3R6MlZnT2ROUWc2OC81N29ITXJwSGZTbXhsUnlhY3gzMTNw?=
 =?utf-8?B?emVscnNQeEw1bEZQODZMcFVOUnY0SGVZRHpLdFZPcHV1cVZyb2pyTFNSUWpy?=
 =?utf-8?B?dXdVb2gwU0JuejFIU25YLzJrR1NwU0doK3FjNUlmRVdGNXJXSXRpbURQTFly?=
 =?utf-8?B?UFZERUJOak1BY2w5ZzVvNG12MmRSbEllQ1ZYRjNOWnVkenBkMXhDVnNzc1Zm?=
 =?utf-8?B?NjNhcGJaeXI4WmNJbHlnT3lldEFOL3dQQ0dULzFqbmVxZFVCTmNOaUp5MVkz?=
 =?utf-8?B?SHpDWWN1WGJCaSt4Z2N2MHVFQy9DMGo1SXhBb0VKeHJNalk4YVEzWUJpRm81?=
 =?utf-8?B?R3BkQmxDNU1VSllzWWNHTnRkbXcwOG1FWmdTd3JFdlJYRGYvc2hzc3VrbXRH?=
 =?utf-8?B?QnduZzg3dGZnQjlXUWFHTzZ4Z3RDK1RHZ3N6c3M0Zm5QdzlEVlp6c01QZnJB?=
 =?utf-8?B?SUZ6NmdLdlRjNTJiSmtTMEJ0MVNxVFJYbndiaFdQZnZBQjYzVi8zeTZlQnpy?=
 =?utf-8?B?VGhBQWlQT0k2TmFacC9sYzN6VkpicSttMmNNL1hMekd2NDFQT2RpZWx3Y1BR?=
 =?utf-8?B?M0tzd0ZyamJVZ3FKQnlQQ0hQWDlDSGgzNnRlOUNSVllMZ2pkdnlWQmZBN25p?=
 =?utf-8?B?cFZGWm5YRmwzUUora2ZvK1FVVk83OGdKT2lFY3BuSFJoVDY1MDRKb0RhanFt?=
 =?utf-8?B?RXFlM3oyVnBUUWdDblcrdWNDYmNmYVJBMzFJd1lmSzg5UnNFZDBnajM1YXF3?=
 =?utf-8?B?RGxTNWZSdUhpSGZreVI3bUl1UHU0Ymp2N2lDSXJqeUJuOGx2OFRIMmNXY3BD?=
 =?utf-8?B?QXJEeTNmMllZZXpDNVVBZU9mN21oSmZwOVpnTGpQMVoyY3orWnNyUlM3anVC?=
 =?utf-8?B?UHFZalA1RlN4TitYQ3pBUkI2QTVmUDZsVHQ3VWZmamczVDM4RXpKcXR0SGFm?=
 =?utf-8?B?Rnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AC+ctWd1DoFVm39r1nnQlx0rY5gPw37l1Cn9QxOdgZbNwRpgeUIdwhjz3SQuJJ2zWmQ3/Fk6W96jHKeTyuZ4XdF/OISoBv4L9z8Ka6l9q9NR1/r3mzQyQPISnCX8Eg93riO0gAXP/+c4cJmL14i1YpiGtpl46flwyPfetiMhy5a/2LEBB8RO+FoNmvqp+u31kWF/LRoMvjhQb1sMlJYpM/oB1Zy/akUTrUmf6b5GYbxnYXQiPCj6/CuubN0ma30SLcVrmS2BSbEuKpesZy3a6QpGgiLlvtDl2Xb2Jdc1ncxHFehY1gdsVHXWoMUVkWQge0srEE47FRRAzUWnZORs4tROHnXLUmEoM9yKp3GcX51/FuUV15Er8/i6pmX8cgrW9Lx8yqElJpF9Z106aqiJ6Ee4tMfqNKzFvxzOWEoCf9Njud45hsYN/cWh4uSjBsA+4x1BTgp14njM07IT6zbfrNW6sbp3aliOqYM7df6axpYZ3WFMtB+oM2ZHCL+tuq4DhvT8NJekqrktkIwFFsv4QV0/cG7Yh2QvgIlTR7E0GNdwZJZGjebJNE8ho0Vz7aRt70lglcFEJXIboVKVaBgbQJD+bAZhzSkO5w4lp5ekXI8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861a5a39-c64e-47af-58c3-08dda1d222af
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 12:36:45.6331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5rxe3GjqJilAN1IMgUprE1WzA22oT0XFfSjSqWUokA1WSPBnNI4Kb3CI1JGTkEktn6qaAzkQmdkN0v0fbV3wL3WDK05V7/bucgPwxCW8Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020106
X-Authority-Analysis: v=2.4 cv=Jdu8rVKV c=1 sm=1 tr=0 ts=683d9ae1 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=x06qnIS0INxPzv-sdeIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwNiBTYWx0ZWRfX+gLSLrdQUT/N
 BdOgjrk6oPn9ThRCnfpFerEqh0JJFSVUAphf1y5Jgx3fDzU7CyS8JHQ+D+IyCAtC3S9wV+v5nxY
 o3a5tt/ARbQrfH+DBL2DClgop8BnbrNMgUVlw8r6aB8+GmjMyR+FMhKdL6yYCJ+6HIl/xIV/m1W
 iSo/AbhY9rFFmEBwgjzpJUYdCUtBgOkDH+RaMAXNc/O42/CA3DxCDBb24f76qdHBLbSC6y1eZ8o
 36LeIWIlR3/OaWWSTJVyQDWLpbP8x0CTMM7PEERUCyytiGSuFwqrMPjfEeFqXyKcnlw0VT75KIf
 bnd3TCAlVgwK5b6jpA85cPzLoTkOf2U90d0Ykm9+L34YvfxDoc9pnzln4fFXdoYvuYPPHzLWFoJ
 c9jlcVULc9pK8q7KlojhxftysjeT3oBPFYGWwBfqjfbR4qGUmkQrOqxUwaG5jpzypRcBseYN
X-Proofpoint-GUID: W4HRyu7QK8HnNuJ2ZlgOJLvETpTHuvtg
X-Proofpoint-ORIG-GUID: W4HRyu7QK8HnNuJ2ZlgOJLvETpTHuvtg
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

On 6/1/2025 3:07 PM, Michael S. Tsirkin wrote:
> On Sun, Jun 01, 2025 at 06:38:43PM +0200, Cédric Le Goater wrote:
>> On 5/29/25 21:24, Steve Sistare wrote:
>>> Do not reset a vfio-pci device during CPR.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>    include/hw/pci/pci_device.h | 3 +++
>>>    hw/pci/pci.c                | 5 +++++
>>>    hw/vfio/pci.c               | 7 +++++++
>>>    3 files changed, 15 insertions(+)
>>>
>>> diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
>>> index e41d95b..b481c5d 100644
>>> --- a/include/hw/pci/pci_device.h
>>> +++ b/include/hw/pci/pci_device.h
>>> @@ -181,6 +181,9 @@ struct PCIDevice {
>>>        uint32_t max_bounce_buffer_size;
>>>        char *sriov_pf;
>>> +
>>> +    /* CPR */
>>> +    bool skip_reset_on_cpr;
>>>    };
>>>    static inline int pci_intx(PCIDevice *pci_dev)
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index f5ab510..21eb11c 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -32,6 +32,7 @@
>>>    #include "hw/pci/pci_host.h"
>>>    #include "hw/qdev-properties.h"
>>>    #include "hw/qdev-properties-system.h"
>>> +#include "migration/cpr.h"
>>>    #include "migration/qemu-file-types.h"
>>>    #include "migration/vmstate.h"
>>>    #include "net/net.h"
>>> @@ -531,6 +532,10 @@ static void pci_reset_regions(PCIDevice *dev)
>>>    static void pci_do_device_reset(PCIDevice *dev)
>>>    {
>>> +    if (dev->skip_reset_on_cpr && cpr_is_incoming()) {
>>> +        return;
>>> +    }
>>
>> Since ->skip_reset_on_cpr is only true for vfio-pci devices, it could be
>> replaced by : object_dynamic_cast(OBJECT(dev), "vfio-pci")
>>
>> Thanks,
>>
>> C.
> 
> True but I don't really like driver dependent hacks.
> what exactly about vfio makes it survive without this reset?

The kernel descriptors remain open and all the active kernel PCI state
remains in place.  The device was never quiesced or de-configured in old QEMU.

The cast is fine with me; it depends on what Michael wants.

- Steve

>>>        pci_device_deassert_intx(dev);
>>>        assert(dev->irq_state == 0);
>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>> index 7d3b9ff..56e7fdd 100644
>>> --- a/hw/vfio/pci.c
>>> +++ b/hw/vfio/pci.c
>>> @@ -3402,6 +3402,13 @@ static void vfio_instance_init(Object *obj)
>>>        /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
>>>         * line, therefore, no need to wait to realize like other devices */
>>>        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
>>> +
>>> +    /*
>>> +     * A device that is resuming for cpr is already configured, so do not
>>> +     * reset it during qemu_system_reset prior to cpr load, else interrupts
>>> +     * may be lost.
>>> +     */
>>> +    pci_dev->skip_reset_on_cpr = true;
>>>    }>     static void vfio_pci_base_dev_class_init(ObjectClass *klass,
>>> const void *data)
> 


