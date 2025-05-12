Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BEBC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV3x-0007oE-8p; Mon, 12 May 2025 11:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1uEV3v-0007nX-JS
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:27:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1uEV3t-0005uo-3z
 for qemu-devel@nongnu.org; Mon, 12 May 2025 11:27:27 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CC9fa5017599;
 Mon, 12 May 2025 15:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=XItRnvY0ZPty2RSbuqlZ/SukkI3rAdDcKWwXBOXZoJQ=; b=
 E4owVjDo/DfrFV41lqcVYeuiPAn/+9d74w9xytD5Aps939q1LaesVTifBz2SHqzM
 aohiR9HwX2R9FYsgGn16nZLrZhM+2TtwvT78m9XODwdOK+IR8UjPBke9nKTc0BJj
 kaVHz640Kcz+MhRdGcJBuX4FgIcdeXQESfAlE9ioxV/L7twLuLu9qiNmUsbQPYYr
 4QdItNYoDAKWmEaeYZ5b99BSJkJiGmIkqOt8UrYfa1eVqWOQD+ZjOkQsqugT9UAT
 pYgsEuNz4TLM2HKPlcLLi3PJcGlITLWcuijIcQHTPAFZhQ9NZX3F19ndbNmiDfFW
 eXzJT5A1oEdegIgVVowQLA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059tv2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:27:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54CE0AbJ002403; Mon, 12 May 2025 15:27:15 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazlp17010006.outbound.protection.outlook.com [40.93.1.6])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46jwx35xxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 May 2025 15:27:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agsYoGHDmHS1wOQgo5tuMz/W+/AHCuOXT4y+IPgG+ivhh+uZI2egZ2xJYqOP0za61+JPs1JRjqmqWlf3+J1OrzMOBFKqQ0296YaRn63EicvoKu9zuVIOWlAD/WQWXBnuinv89pACBrcfuhgfgcQbCw7tWDKqU+Z5EvabyVMBQfEheqqdF3ZNr0+KMjpu9efnGNXdgtsvPg9vx+l1uVcN+2e83LxlcwI2aBs3NOZjRFLv+jcmwS57j9aw8K2wbkVTY+wIIW994V5uU172l5TLFxMUu7JK8owImjlgyzpAbzeMDQIgy5ub1XwFQ7ZK8dAdPHFVKKSB3nuugdCXY4K5ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XItRnvY0ZPty2RSbuqlZ/SukkI3rAdDcKWwXBOXZoJQ=;
 b=Kgt3iLkZiOyRNDNHcFEZRQ9agQQ0FZjX/SC8IfQwrzezf3KmeDldx3d25U8fyQMUtBSmDBHJZjNRD4TWUwROMZ8TFnRVR8wr1C6MVXePmszCSTa+3T37Pej2QWD4MgH3UbTaMZHqL0zRCmkw5Jci2srOrOuNaiJM1FUY/Bnwsk10c9eiaJS7mBzV2uUXlEaZ1oG/DsuTIQOKC1vXVgFfXngWURJzh9wePKhFWmwj7rUJnlFtQqUT+X8EmwP1+bwypxMY9bLmlyQWevqQKy192xO3QMkd77Lr0BA/krdkDbiAXXDv9hUnOemDs041sMv+fq3MV3396Clc4hxFfgyf/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XItRnvY0ZPty2RSbuqlZ/SukkI3rAdDcKWwXBOXZoJQ=;
 b=LeKfe9eiQ7TIYCJMRnbPkHEUq6i0GO8T6T5NUI0K4b0DVWiiIkOvwacZd59eowaAfolQr//LoW7x9ajcM4gW8k4apBGEQNDSCFXX2JuPnC/WVSVpP+uYv/vPHuivq8s4sjYKzF7vDYrN2KyLr502slG4Ri4D/mVLDx+YTM8Fh80=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by CH3PR10MB7529.namprd10.prod.outlook.com
 (2603:10b6:610:154::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 15:27:13 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::dfc3:b0d8:d4e:5c3%2]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 15:27:13 +0000
Message-ID: <0cc5d7f2-1f70-4698-a192-22206ad50910@oracle.com>
Date: Mon, 12 May 2025 16:27:07 +0100
Subject: Re: [PATCH v2 2/2] hw/i386/amd_iommu: Fix xtsup when vcpus < 255
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: mst@redhat.com, marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 suravee.suthikulpanit@amd.com, alejandro.j.jimenez@oracle.com,
 qemu-devel@nongnu.org
References: <20250512040537.15557-1-sarunkod@amd.com>
 <20250512040651.15590-1-sarunkod@amd.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20250512040651.15590-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::6) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|CH3PR10MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 30be91a7-0760-4717-abda-08dd9169782e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHQ3bVFmMXhtdTNUa0htR3VXT3NvT1VEUDNpZjJWRW91bFBjRER0TkhMTXp1?=
 =?utf-8?B?UCt0WnFWWlF1K2NxUFRrYm1uL3pqaG1rb1hrRFJ0cC92aXkzL2RYb3NrUTI1?=
 =?utf-8?B?Wmw4akhTRjZMaDJQNHVCbHQ5Sm0zdnBPQzdmeFpxYlhZZ2ordGdvMHNZTisx?=
 =?utf-8?B?REhaV1c0L1B1dTc3QzN3WEh1elRRckIvZitlOXZLN2FXV0N1OGsxL3Y3T0Rz?=
 =?utf-8?B?UWtEWDBPc0Evd2FPbVV6b3VINVo5dHdrUWd5SElhd1gyMTV4SXRZNDNrMkNj?=
 =?utf-8?B?b0pQTzFicXdZY3dkL2dnMTAxam1KWTJNMk5IaHJOdldCUU1ZeHhFV0Rtc1N0?=
 =?utf-8?B?NG9sc2hqWGhleFRud0dnbkdDYzdqd240Wk96YXVZZGtGakZFUmszZ0JaMUVC?=
 =?utf-8?B?dlNqQzdtN0Y5M0E4VncxVnlyL0lqeUdyNWY5a1FNSmhUTVNYWmtvWDVMaFNl?=
 =?utf-8?B?NTlpRFhBQ0MxeEttWDBFV3BKU05YS2x0REV6ZTVJaVlqTmhpMkp5R0JvTWcw?=
 =?utf-8?B?WEJIZ1lkNVorM2JhcGVQdlA3VktpVzhBSythVklHQm03Zmw3RjdMTDRldUJq?=
 =?utf-8?B?c1IrbU1Kc2ZxZ0cyL1dBbWU4RjF2d0h4bm95TUs4VkR4SXJxZ21KRzk3N1ky?=
 =?utf-8?B?RzVHRDJNaXE5VzF5RS9Zd0ZCcmR4UWxSM1dtak9jQ1lXLzBCZzdaekl0Q3ps?=
 =?utf-8?B?YklZUHByVWJMOWF4VmxwQzZUbWI5ZXRjd2hxaFdPTmtHNFF6TFVpSE1LWmly?=
 =?utf-8?B?Sk03cnYveHQxOFIwOE9iOEoxSXZFK3F0Q1VTNmZxRzNoSzlwcnY4SGRlSFBP?=
 =?utf-8?B?TWwxTGQrcmZnSXh4VXpvVkJSdktWaThCRENZdDNsMURPNVV4YTltSFcvMUx2?=
 =?utf-8?B?TFpMUXJDYkdvVk9pK09rMTR6VE0vN1l5cWxLV0ZLWGVDRlBQOS8yTVZKcE1J?=
 =?utf-8?B?enRMRHdvaXFoYWNvYVc1ZmdVZ0d2ZHE3QkhaNytnS0xjeVZHL3BjTlNVeGVs?=
 =?utf-8?B?UE54QlVRRGlWZEJYWFhXV2ZpSkMzMTJrTlRhbzBRbGxYeUI2bTBuaTNVbkZU?=
 =?utf-8?B?Wms4LzlvNEFHU25ZekRla2ZteG5JUW5xM21tYU5vc01FVGY5a24yRytWVWth?=
 =?utf-8?B?bE4vSTQ2WTdQTGdkYkMwVnFodEhVNEtCWnRZdnN1TTR4WEJ2MnpmcmgxTjlj?=
 =?utf-8?B?MjlqTEI4eldtcDBraHBMbHJXSTFRc0lSamdSbExYZmViRkNmMXVxVGdYSzlR?=
 =?utf-8?B?bG1mUWlLSkVLUGVCRUtWRitValZKUkJ5ZHJGcUtNM2RreGhaYXRiUTFLczBC?=
 =?utf-8?B?RUJWN2VxdnROVXRJTVI2SnFZZ1M5eVNJQWNIOHBkU1ZmNzZaay9Fb2txOEo0?=
 =?utf-8?B?Tk9GVndNenI5Qnpnd2xXVzY5Y2NKNjdDWVpUMFd1OFdYL2J5d1JJZ1N0WG02?=
 =?utf-8?B?amJLVHZXYkptMmdYSlZwQWFWR3B0TE11TkNmcmxSdG1NcDhQUmRVbjZPdVdG?=
 =?utf-8?B?RHJMcUM1YXB6a0U1TGlKYTF0K1JEYk9Vejh0S3FWeVovU1dpQ3J0OUlmbXRI?=
 =?utf-8?B?dmhBOEtUbnV4Vjgya1VYQ0hybTVnNkRSNlJaTm9UTEVWOWQ1Y0UvTnR3SjVQ?=
 =?utf-8?B?Ryt5amhUMERSOE1Ra3diT0RXTlErTmh6V3NKU2tqVjJ6Tjdhd3ZuaDJuVy8z?=
 =?utf-8?B?VWxEaTl4VWFLOW9qQTNkNWkxNlBnUFMxQVFkcTdqemR0RlBsNm1ndndSVnB2?=
 =?utf-8?B?SHNlZzNhT1BJRXZBblk4NDdHWnBrSTZJNEFiT1c1alV6Z2gvZWphZStPclZB?=
 =?utf-8?B?eERDdFNQaVA5WEZOKzFPMWNMZmdZek1qbE91RmVsOWFNeHVRWkV6bTVqa28v?=
 =?utf-8?B?SmhPRmoyS0doSE1tNXgwQzhDSHYxaFZaWldGMDVQdmhLbG5ETzdKaWpFKzYx?=
 =?utf-8?Q?vCRrhjcP23g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0o3VkNPQ0N5b2NqZlNOOUhVVnl3UEovdEhzdjZ4a1F2RldEZmFvcXp5dWNE?=
 =?utf-8?B?bGo5cVJxVU5yVjhxWUtzRU5VV0JSbzhOY3gxdXpnYlRYdDNmWllmdklNTlBS?=
 =?utf-8?B?amVUQnZBL2ZBNUFwNExITEl5bkw1cktQdDZFOTFlQStReXhXcTZyZ0JXS1hr?=
 =?utf-8?B?cG9YSDFRLzZnbW1MUE1jMjYwUmV3UGxRSFRZbTFnVEhMYTE0WTEwSXNGaExN?=
 =?utf-8?B?Qlc5Q3EzTERSR2VqL3IyWUVSeVdkMkRNOXNrdXk2MUxuY0ZrOUpSbFF0MWlJ?=
 =?utf-8?B?Y1dBdWNmMGd2dUkrQ1QrZlJaSTdRc0ptWVBjRElzMlVITGxEV2pMNUlvYXpM?=
 =?utf-8?B?WFhkS0ZYSnduWUpQTTFHQXZIc3JHcXpZZStJRk9ONXZjZUM3ZkwwZVBDV3Bv?=
 =?utf-8?B?R3kxdTh0QWhGaDc1dm42cVdkd2JhcWN5cU84d0xNckZLWkdHZW5IMjY4ekhT?=
 =?utf-8?B?YXQ1ZG5qVFRBcHZBU1RNMW9TNjZPMCtkL252dFdyMFA5d3MwOGZ4NXhkSkV2?=
 =?utf-8?B?S0xKR2txZU1yZ05RU2QwVk5qK0R5TlpCZTJPQWdqeXNEZ1U1UWZ5anhEc0l1?=
 =?utf-8?B?RjhCZDVWaHZWR0JCRzdaSEJnODFzdHhqUDl1YTcvUU4vaFJYeEhhSkVZK0tJ?=
 =?utf-8?B?NUhNVXJEUjgvbHY2NVh0aTA1L1dOcjZnbERQZGVyTWUzdlBXK3F4c2tlOXBx?=
 =?utf-8?B?OXJuOHpDK2xvOVZIaGhrVysvVmZHR2lka2dtVThXNkFIcFlhVW1ZRXBSV3Yv?=
 =?utf-8?B?VXI1Qk5qQkxJVEoybmNobHZQS2hYVnEydzBxR2lVN0F6MWFJaUJ1aWwrR0Q3?=
 =?utf-8?B?N0hXQXJheE4yeWN6NFp3Y1lKdDZ6SnEySERhNzcxY2wrTVV4eEpvNEhlQjB4?=
 =?utf-8?B?NVZ4bW5TeWJhNk1iY0Q4T0VHZGZNcmkwR25HVjA4OXcrL2RFVW81RE1RUDFl?=
 =?utf-8?B?c0k3aFkzbllBS0RzM20yQXdqeklFTWJCZUdYcDRBajlhdTFlZjJ4SEVGd3ZK?=
 =?utf-8?B?TTNrYW5yUEVwMXJvU21zQTZXSGpxUlNwb2VadE15Q3BlNXptUjAyZU9JSkhl?=
 =?utf-8?B?VTRuWlRXazVuRUh5NlFkZFFzMmxhcnBCaVZaMVdxZkV0OFVqUlNtRlRidlJF?=
 =?utf-8?B?eVVRRmN3SEFmY01jSTlUMmQrKy9mc3ByNlNWb1BHRHhibjVjaDdoREpJMUxH?=
 =?utf-8?B?ZkJjaWJNMi9vN01oWjAvOVF6eEM1b25NczluQlErSFRZMkoya3lpV1NVYmRj?=
 =?utf-8?B?RXpVdVl0THdsRE9LWXVYQUI2ajlwT3lMMlh5OUxVcFJqalY0MWJ1ZDJZTWRi?=
 =?utf-8?B?aXFLYnJuNHhSaEtOU3ZDSmsvTCttRXJaQlBPRkpGMFZVRkdjMjNXcUxpVnRL?=
 =?utf-8?B?UGVrRFVBTlZWLzlQbC9STzlEdy9KVms4dVVNT1FraXloR1IranRVYnJycUlK?=
 =?utf-8?B?cHRCVjc2RUpkK0dmeUlYSG9Iakpod0YvRlZnWk9RVzk0T0hwYjNQQWVmMXpV?=
 =?utf-8?B?UWYyT1gzU0FaWHEycWNRVUlXZ2hRVUg1bjdrYk5hNWlJSFJRNVBKdWxSeVJJ?=
 =?utf-8?B?MmR1dS9NOHVRSE9CQzhVRW4zTFZ6L1BXa1Q4NlBvQU1lZ0ZqckRST05IZHls?=
 =?utf-8?B?RW1FcTJ4eHFycnJmMks4UVNMYnJaRWNKUmdnNy82K1E0K3pnbm8rRkljZUVq?=
 =?utf-8?B?Q0pUNDBNQm5OWGwxMFpYMXNYR0ZVc2pqVDlDejUyV0hNdUlWenpzY20zcXUw?=
 =?utf-8?B?REFwWVE5SThER0xvQlN2L3B3Qk1kWUJBNkVyVXQ3bncxWG5GLzM5ZjhranVn?=
 =?utf-8?B?QWkyTmRyRkZMVDFoaUJZYUxGZlZBWkhpVzlGNTJJQVRLSTZ0RjRyYkxvUTJM?=
 =?utf-8?B?U2NYMG9zSUdzaHhHUlRrL1M5Z0RXYTNGM25lRWNhQkZLbUlZYVhKWXJTZlVX?=
 =?utf-8?B?MGZEWHRPL1FtY0ppTDVBQUVTMDlJYnMzNUt6cWd1RUw4b0NYZW42YW9XRkxa?=
 =?utf-8?B?WjJQMHRMVzR1aURnaVFTaXBKSTUrM0o2RnczWkRtRnhIREgxVkR4NXlWdDVD?=
 =?utf-8?B?Qy9uZkJBb0Y5SExCZWRONVBhOXozOWhZWnh1amFmbDQ3YzQxZ1VHWEJRVGxG?=
 =?utf-8?B?eGFJZUZVQlFhS3k4eWF0bUxLc1Q3aGwrUzhKYjdYK1dpR3V0ZW9INzdzR1FR?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +HuUiRYNjQDvDmszPf3nPGk4gsuW4vBVmq+YoTYNS/mXCzIbhX/gdcCJ9ShVhzQ16lAKXk2xbuQM69gBUCdz2q01ColEo/vQgQlxnHzVziCYDQqX2io6yjQjL/VKDTKlfH+NorHvTisY2xslzgnlVRTI4J1ZVfGTz89Oe9uwpdJUjl/aBSYeAUx2wxEHonhpcMEeJCuYU8fBBSr+xcJrzpInq1KWGMALJG9oYf2n3d4ruJSvFl0uZ1gO89+Ti0wdLJyHYz6fJekHkCgivqn65UMppeDWFNeBK6plzSW5Um94sSRNlmFX5tQM+20pBhjKQHDwPPGirakTv8cOSwaFc5fLC4ScBIPnzxyKmj5WAldo0EQpAn7qkGTokVcf73KdJlj527SkD9DIxXKEBivWrcpXtlbPDkWKzRKDJynVYrDuCxb6ubsJy0xtQcFIfWdW9P187YDlzofCujAEv9SZbVwPoItPHhreLX7jgCYndmtMFGCRgbk/f7/4zsvUxmdgXuy1dC/zRo/5NFrv4gKXPia4AsPWIeZvo99+KSJd+wExReVVP94XQMhwp74zuPxuTdXQrwv873CExah64gGX7qgM5LpgK4cjEvjuH0dBvqI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30be91a7-0760-4717-abda-08dd9169782e
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 15:27:13.4567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZBLqJzbdD2uilqtt6gd1w+SYGx7htqr8zgHX4EfZRhJvYoTjxw5CnWpA1dlgIGEAfcBaobZ5XNNIN1BztLOlSo1lVcPMRDGnpdENjZxRz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7529
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_05,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120160
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDE2MSBTYWx0ZWRfX4fscuEX81EQ2
 oFVOI35mA9jPsnp+WwqZzsMxaHg1OmEezdoqC1HJANBawlEYuO4N5iQQCbc7zzB54o4pzvdnNmn
 iCg42biXlWFvO5qt3YRaJOvV36UjZZkeZ2JsQhvVE0X+Vhqu/1YYopFn42U5OTiafSs+XZUSUWd
 bvjo8Qf9vbvQuQG8fa1alAladhWQL7+kcDIS7AnjIz3G9N1iBnOBnFqKWEtcJZOl3VneZYWzlXm
 NCscsifZAt+hl0OQvMZGTRuBawT5iGwXSPlkzLXqP6Il1YBgbbuiZvZzGNtP3E1/T5GpK1+Cumg
 07Eq41xKitKvrZOe5xJp4BBMgzDgziusxa/u/S8iG8tlPwLp/+TyuTXkAsl6vrB3WkduyELvfVs
 vsyvx0/7KCUEW1evnuIH9y/U195dZ9j29fTtJUOzfL/eU4mKakNGeAqg7FT+8SJJBBSi1YXv
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=68221354 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8 a=_JenuFt2P4KJd26fSSQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LjCbDIeG2Al8Gv-kacspdVRo7cy8v99G
X-Proofpoint-GUID: LjCbDIeG2Al8Gv-kacspdVRo7cy8v99G
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 12/05/2025 05:06, Sairaj Kodilkar wrote:
> From: Vasant Hegde <vasant.hegde@amd.com>
> 
> If vCPUs > 255 then x86 common code (x86_cpus_init()) call kvm_enable_x2apic().
> But if vCPUs <= 255 then it won't call kvm_enable_x2apic().
> 
> Booting guest in x2apic mode, amd-iommu,xtsup=on and <= 255 vCPUs is
> broken as it fails to call kvm_enable_x2apic().
> 
> Fix this by adding back kvm_enable_x2apic() call when xtsup=on.
> 
> Fixes: 8c6619f3e692 ("hw/i386/amd_iommu: Simplify non-KVM checks on XTSup feature")
> Reported-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

FWIW I think v2 missed Alejandro's Tested-by

> ---
>  hw/i386/amd_iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index df8ba5d39ada..af85706b8a0d 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -1649,6 +1649,14 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
>          exit(EXIT_FAILURE);
>      }
>  
> +    if (s->xtsup) {
> +        if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
> +            error_report("AMD IOMMU xtsup=on requires x2APIC support on "
> +                          "the KVM side");
> +            exit(EXIT_FAILURE);
> +        }
> +    }
> +
>      pci_setup_iommu(bus, &amdvi_iommu_ops, s);
>      amdvi_init(s);
>  }


