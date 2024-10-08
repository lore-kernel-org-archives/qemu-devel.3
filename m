Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489EFCEFC26
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syCLh-0006WT-Mn; Tue, 08 Oct 2024 11:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1syCLb-0006W0-4m
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:42:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1syCLY-00033k-3w
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:42:02 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Dtar3031985;
 Tue, 8 Oct 2024 15:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=xfpoCOGffj3K8hh/dLMRJVKos+hgizKldhnKv207St0=; b=
 aIre6UKT+fX5CNE1flsGsW28WEcYjvsht5F2fGUnas13v0525zQLoiUyKIuI6GDW
 1MJZG9M/FNuDSG9c5oi0fkH2NDEhx+yK3mOviMIWgYjkNMU4Rkfp6CbRc/4BSJ+6
 cVFctmQl0mt7wuE/j5FgM9vDsGfYh1XO0TC+A2rGv4DC5kwbUi453itRnOF56vB4
 H7BUbX4iZgXoRblcxIAs7R7ByUwswLu4E5wNsD6P+f0XadRoBQEPP6U53sjvPLET
 FptOuM78lU3InSEkbEoiQNwZUu2y9vW9dTBu9/rtrHpqQngqF16IKH44g6CnjEQY
 lq8nzruu6jmfQIQ34kuqcA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ye5ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:41:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498FfbLm038388; Tue, 8 Oct 2024 15:41:54 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7d2g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 15:41:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmZ9gD/lHfvbbFEIWETHXHjaDzLMgZpMVPkLPhJl4Cl3asJRHQkPyjKX0Zbf37OpgwsuNUPZj4NatnIENQOT2pWRJRrBuQ6Zvqb04bO5UnCiC9T0kvvIALeGT2LNFbPaXRBCEYdCnwD3/cEGgpOGG/e3rXvO8/A2mSfjt3nKsfta3QmpRWWk9ZKIlXFjjB39q4L941C4aJLs//s+rp0jP25UX3769oIdk9bwSpIbnVdF8p1Ua2vac4sJVzxoNKDIyLlkPltXWtvn0QV54TocLmph9Vx8ZcrPjYDFfMdMefvMFAB9StrdLxcyh12KKj1DJMgg46/4F/ndzHK61ze4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfpoCOGffj3K8hh/dLMRJVKos+hgizKldhnKv207St0=;
 b=tJyMWSzHsabPHVjQDOElwHB/qAoZifPLll3cQ3NZ+Qno1sb9uKVh+RphBzLx8Ryf/fSyevenuL7TckLe45N02lopyCou9vgbHqLfZJpSQNK0JuFyrvz4oPUhIcKgJL9Fti+IvsOqFosAk+f63lI1mA0xqBD34BWqa0cmH6iH2+vXc81FY6nO8QQljkuCVhtHG6J2JbHYPmOAt3vBCuX3F/2TQKXHy//A8a1dGPaTWev4VHXcS9gNfi1GQK2wBAgT/jqEFSkp+nF5qwbySsPoHOtyV1n4ogX26r8Z2ItS58Sd3hwDRfkVjFhAyaeVRNQCAlyCdmz+nR4n9KgMV7Atjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfpoCOGffj3K8hh/dLMRJVKos+hgizKldhnKv207St0=;
 b=CzJli6g841NvE+B84Yp5hpggT/E53xSs4pD0AhWefHgJluycltYyChAdailpnTjuV/BLSRi33A/dYDadHOCW7LFqCaqqbtMeKaVm+thUzP9cu6yr46Kah4lTMhGhn1TeH+ESjYAljg+KYhlMu86r5A03Bj22Yo0DHDqYWq4I0W4=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by IA0PR10MB7133.namprd10.prod.outlook.com (2603:10b6:208:400::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:40:34 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:40:34 +0000
Message-ID: <5ebfd766-c8b5-4fb3-86ad-17a74212ef5e@oracle.com>
Date: Tue, 8 Oct 2024 11:40:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 1/2] vhost-vdpa: Implement IOVA->GPA tree
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 boris.ostrovsky@oracle.com
References: <20241004124445.3802090-1-jonah.palmer@oracle.com>
 <20241004124445.3802090-2-jonah.palmer@oracle.com>
 <CAJaqyWd7c6ZU_4Hk_Wo79Ghw_LRxxjmvXUvZrASKE6WSWZcytg@mail.gmail.com>
 <e3108f34-f951-47d6-ac41-cbbc045a7bd1@oracle.com>
 <CAJaqyWcmjnPaAFGvE5=2e19wuAxOr2=AHX1y-dj70+49sdQh7Q@mail.gmail.com>
 <a1711695-9d0c-44f4-b799-1879404581d9@oracle.com>
 <CAJaqyWfYvD0nEYU9UgKzYgUo5JzuFu3PBKNEkDrM0BE0Ek5LfA@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWfYvD0nEYU9UgKzYgUo5JzuFu3PBKNEkDrM0BE0Ek5LfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0425.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::16) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|IA0PR10MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: ea4b5e22-05d0-484b-f644-08dce7af8caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cExzS0NJQitKc01WQTNtZm9uK0c4U1N5RllOYzFEaW8yQVlrdHBCYjhUeGFu?=
 =?utf-8?B?WlVvQjR5QVhKMitvam83V0UxeUljbjd3bEsvUm41SGU1ck9SVXBWUUNURDNm?=
 =?utf-8?B?eDlYWUR1RitTS2hrUXdmU3pEaWE0OFk0TWNMa0VGS1Q3b1BQb3JkMFNwd3Iz?=
 =?utf-8?B?WmNJbWRCaG1MemFKdDV3eEtDSUVxNkZZUm5xTThuT3g2TS91eVJjRHdEOFc4?=
 =?utf-8?B?Y2NPaEhNdFZYRGFjNmZwMnU2K1NValdiWFRiMHpCb0xvQXJRRDBaQXdJUytY?=
 =?utf-8?B?T1J4djR6UjgzSWwydStoRjY1bm5lUWFmL0YrUkt5RCtqa2xlWlB1Y09xMkJr?=
 =?utf-8?B?emY0eXM2MWNzd1NGZmhxaTJydVFFSkgvejhXRDNvYjNJcHJxRko3OUtWTXpx?=
 =?utf-8?B?M3VsdVhGNW01a0w1eHlkUUFPaUJ0NDVHU2VmZTFpZWJBRUJzcEFRZk9pRWtp?=
 =?utf-8?B?UVQ4cURYcURPU1pTWWFXbDBBS0hMOWxwVTVHY3hMeUVuTUZ1aHlWMlo3TUFk?=
 =?utf-8?B?RVBHdnpKY1RqMnFUdFEyQ1pWN29obTdLc2l1cHlkYWRDVU1ZREYwRERHdjNm?=
 =?utf-8?B?cHFnS21kdlZkMkh1OWVJbkVGemFqQStKWnF6U3FOTTRFMktYVVV3TjNxeXl0?=
 =?utf-8?B?bVd5eVZxZlZPWlRSM3NFaDBuVGpUMkYxcFJNeHVoNWo5cUVneHpCaUFkYW5t?=
 =?utf-8?B?UStHeTdPaHJjUXpLcjdyWjhjRlFJdkFwVHZ1WndOTk0yR1JnRGhFVHRHTm5y?=
 =?utf-8?B?STcwUENNT0hWT2pPWUszQ1JpWWFrTEFlZXBLejJ0WXZHNE5yNk0xRzM5MUpX?=
 =?utf-8?B?UXJqaFVILzd3QzFhU0ZJYVF1T1oydVlGbkNtMVdiMWhzMXBaVjBDQU42Smw0?=
 =?utf-8?B?UGJIOUlWQzVkWHdTM0ZqYzBrM1NZN3U2VmR5Z3BIcFhLZ2hDVzBSVzhPQ21I?=
 =?utf-8?B?dWtMdlhvc1prS2FRelZNVUo0WTI5VVVhR2t6QW5xYTFIUlBTOFd6V3ZSYW5R?=
 =?utf-8?B?Q2ovdW5pWjJJbVV3YnVEYXo3bmFnR1FFR1Rvb0NtZTNyYjR2ZkwvbStyK1g2?=
 =?utf-8?B?U3BEeWdCMGQ4d0t0TkRwbTVzNkUxZGowSks4VCtUekdvRkUyNDhFZ3RrTk1W?=
 =?utf-8?B?Vit6Z0RaWHl2ZUlYeGlZYnBFZjhjR2lEYlFIbWFXWWcwYUFiN2xvMzFEei8r?=
 =?utf-8?B?c2NUWWcvVFZiaWdJZ0JQeWlWcUtFMlA2VU85enczQ2pDQ05RRHczdUtEMDdh?=
 =?utf-8?B?amhOY2RVMG9aQkg2NndJSXFzWFdPOFZ4MlhVOFVBTnZBYi9VMUw5N3YySlhu?=
 =?utf-8?B?cnF1bGExVFVpSzYwOHZxOEhpQkl0K2UxTytBU1NBdWloQzROd3YxbHRQdk1o?=
 =?utf-8?B?aFdmanhha2Y1clY3VWE1MG9GZFBrY09Cd1FGaEV6dDJiK0t4NFBYWEMxbitH?=
 =?utf-8?B?UXMrY2pIdEYreGVaanFqTkV5VTIzQ2IvOFlpOEEyT0RuNVF5OUxpV0NzU0Jh?=
 =?utf-8?B?VUw1YXpFTUx2UGZ4a3VkeGRabThnZ3hMRkJLTlRYZTE2RGtYejl3QkYxNHo1?=
 =?utf-8?B?RTBZemEzU2N2b0R6VE5FNWE1K3E0WGVXcGZmUkIxR3A0NS94c2FRQTZzcmFa?=
 =?utf-8?B?MEdlSVRra0ZsMlhTQ2tjdWM3VGtlUnNNdC9lT0JFdTc0Sng0bS9rTHpTRTRi?=
 =?utf-8?B?a0kvQmVkd0FjRlF5NkdveXg1N0F3S1FpWG1rYSs2S2x0UkdWc1NYendRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2VJaTdpa3pSVGduc3ovNklsYXpNNzNGVEppaWdhaExMTy9mNjB1Vm5uRGVn?=
 =?utf-8?B?WHBINFgycUJnODZpb1NadEdkZlhtaWZzendlS2ZtWlRxaDZ3K2NRc2RlWTdO?=
 =?utf-8?B?M3BvTTJ2K3oySm5qbVpvMGZHejJtZkdLeEhKWmEzby9Td2dKdGl6UXptM3c3?=
 =?utf-8?B?YzViYWZWdDV6NWZmUFhmTHNCdzFQYjFjQ1BWZklwUEJ3d0YzaVo2SFUyZDc2?=
 =?utf-8?B?YVhRa3lhRHJUZFcvbHRBcDVBYUVheDk5NkJaUHdKQ0pYeTVLUFRYYkh6cVNZ?=
 =?utf-8?B?NSs0UjcyREJpVVBTdzIrWm1PcVR6RDh0em9XczhMRXVSajFPWG5OejI2REVX?=
 =?utf-8?B?REZ2TEl0bWlrVTlPMVp2dHVkOTB1MWwycE5YK1QvK0lrRlg3ZFY2V0Z0WHAy?=
 =?utf-8?B?ZVJRYUw0U09TZ0RKTEVsdURjNUhrNlBZN1FadW8vcGZEa3kvOEk3ZXA2aTNm?=
 =?utf-8?B?UTJ6dDRVSU9DUUExajBtUmlwcmorZ25XeDJLVFlaRjN6ZUs0N3E1a3FYZklY?=
 =?utf-8?B?bExRVjhXdVJvUHc5RGw5Z2E5VzFHNnBVeFNIRnVoTnE2YTFiQ1lDMnFzaUoy?=
 =?utf-8?B?eVEyWTErRzk0QVFvOTlTWU5zekI0Uk53NzVmKzI4OXdmMkloMnNscytqdWha?=
 =?utf-8?B?cnp2Ynl3Mm1oZmp5MEl0ZTZJY3oxQkdLcWlYekorYlc3MDhnRURqejMrTFM1?=
 =?utf-8?B?RmY3NnV5MXpENHhEclJiZUZpTWRTeElEZW9lYWdnQjJGeUtrSDdneGxjK09Z?=
 =?utf-8?B?ajY4eStqWFhPWEx4cEJudy9CT2hjVnF1dEpjclNPOVUzUXVDRWdMaHdDQ25t?=
 =?utf-8?B?TGJXR1lXR1hJWjNSMGVYSStHV3FrVnhDZzFHUXE5ZlVIWUVSZTEzZWl2T0wz?=
 =?utf-8?B?QkF2V0FXS2Y4ZzZQK3FuWVowZzl0ZUhxbExKYWFCOUNmZ3NqMExxNXNvMFdL?=
 =?utf-8?B?NXEwb0IrZFF6QzFVSllJZUFPVksza0F1ellyRG4rTSsyUkk0L0YwMVBYSzVx?=
 =?utf-8?B?cWpmc2tuYjR2WFNBZkdLcDR6bnVqeElxeEtib3I3bjZ1cTFPTmtER242NnBT?=
 =?utf-8?B?akNSb042cWZYZXZ1Y3hwQnhxbDF3N0JQbDNxb0dDYnJETkxMMys2UDEvQnl6?=
 =?utf-8?B?NXdmc1NYQ2VabVdHWFhtSTB2akdxR1VseEg4ZjRSQzhxZXRuZTJKWWxsRmRs?=
 =?utf-8?B?Wmc3V05nM1FINTBqeUFUYm5vOTFHbG1FcHUzVHhVMTlhc3cwZHh0dTd2eHlm?=
 =?utf-8?B?T2gvbGpPYTNLQm5HbEJyd294UkFuNDFZekdmQjZnNGpDOC9YOUlWbnVhZDds?=
 =?utf-8?B?M2ppQTNnWU43VUo5aXJuaTBKUWZHbzRIbDN2SVlFT1lIVFMzWitPaXNxeEdj?=
 =?utf-8?B?dXpPSW96VWZaTDN6ZURYRGlRbXBvVm1OeHhrUHgvWEZOUFg5b2V1UmliNi9C?=
 =?utf-8?B?cXBrUkFzeEZTZ1NvRHRlOVRBdmwvT05tNUdJMFgzeFdXMndmWlN5UDl2ZlFr?=
 =?utf-8?B?ekhQNHhHVFV1aHZ1Q24yT3lpQm0rcCtDTzErbzNzSDdoRERUaTF1UTIxZHAz?=
 =?utf-8?B?bVZPODIwdGhVU2hEUnUwL0JudnZXMHVycnV0WXBZNlNCNmQyTWRLeXdCaC9U?=
 =?utf-8?B?TExsZldXLzNRSXNEUnhiVVBObHdiWHdISms3YnFxZ2VCWk16Sk1ibE42OXkw?=
 =?utf-8?B?V2MrTXJEbUY1RkRja25jZVZxN1JGMEdCVnE4U0J2TWFRdkFwK0FzMjJIWUNW?=
 =?utf-8?B?UVFRVE9GNVljYmNCOXZDRklpOGV3bmV2dEVNYzRYRE8wV3ZHYjdHQTVTSE1i?=
 =?utf-8?B?ZU1hU2U1OElEam9ONE1GU0lwOHBJb1JTckxFVU1ISVRjTTdpRVJKVU9PSUk2?=
 =?utf-8?B?MzJ0aVdOWmhPc3RHd1lzeFpIOXpBWjY0UmF0b28yVll5ZkxIeWFycitVKzhQ?=
 =?utf-8?B?ZGlacjBvOVlqTzhQT2pyTVhrTGpsbUkyT01rQUZGc2ZIZkdtRklvcnEwSXcw?=
 =?utf-8?B?K3VRbXR0QmIvODBjdVAwdDJxc1huT0loaWV5Um5aK0NVcVk5MnFValBSR1E4?=
 =?utf-8?B?STVuU1QvVEpId2o5T0ZPMi92cG9uWmZVRnRWeU8reWJLdmFkcFpmaTh2ckt1?=
 =?utf-8?B?RlgxYTJDeG5yWWN0QzBWTms1dXdrb0dIY3cxV2ZlVFFCc094dlpGZ1pZeFVi?=
 =?utf-8?Q?qLa+SHi4T4Q0OaJ+UDrfgW4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WoinpkoWgMhgPOzAWKrj2pLh0OaX4flZdPKikCXUl46P+B17uJe9Y5CQ5dGBiXo8d1xb0hp0We1UQu4LVV0lW65Dsdb4D4AInlBoE1E3Pa1QUC9KvgU9Sv1gGoLz/nAhhMMWLpVOcV7Bd6ElGNI5iEnqsl3JZmal11taOdWzVfpSEoVRzzRtNbTvAgmFs72Fis8rJqh37GlTtnRrVRdNLwXK1TkXlgsdTmAL4zYZL//GKKsl+tFzXj7xptwH7Cexu//HEfTd8V4sX6k8B38dlNqlvJ+j4CIqP8qJsyNNsF2eE4HzDJT/UOSzxm3/sc33zwzCxWFQv+A4SOjuGJtT6mI1BvYVBUUs2ramnDW4Tcm+h3SgN06i1xG+0WbKdKdc6wLY+eI8eEcpQPm2qPNh2PRaHaKoftZXf5FhQ9LiO0CawgHcLsNMvx+dSv6TePTFtwtXse2r2qkuObK0xueeekAD4n66tV6LEq4gfdRtC7zIT2hL4bge09QSkxJPxm9x4A19u1pSnJgbgtelaAiJvnb5wmeg+mXWDbSrohhc4hJfW15bHvPH4hrD51F8AiBfPhnL3BXVmDJm0zKv5xx3+BsvltmfViClV/TfyP9kNX4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4b5e22-05d0-484b-f644-08dce7af8caf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:40:34.8078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNxEIDmHsIwhVoaP9LyNO5RhZIcGMo0/cbeZdX/XYLoD5LN8WItSWHNg6k48CXBJQajKL8PDOG9Z3ux73oFfAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_14,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080099
X-Proofpoint-ORIG-GUID: Bpc3YNQVXBbBTu1E520MGFQHQD7YTj7k
X-Proofpoint-GUID: Bpc3YNQVXBbBTu1E520MGFQHQD7YTj7k
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 10/8/24 2:51 AM, Eugenio Perez Martin wrote:
> On Tue, Oct 8, 2024 at 2:14 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>
>>
>>
>> On 10/7/2024 6:51 AM, Eugenio Perez Martin wrote:
>>> On Fri, Oct 4, 2024 at 8:48 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>
>>>>
>>>> On 10/4/24 11:17 AM, Eugenio Perez Martin wrote:
>>>>> On Fri, Oct 4, 2024 at 2:45 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>>>>> Implements the IOVA->GPA tree for handling mapping, unmapping, and
>>>>>> translations for guest memory regions.
>>>>>>
>>>>>> When the guest has overlapping memory regions, an HVA to IOVA translation
>>>>>> may return an incorrect IOVA when searching the IOVA->HVA tree. This is
>>>>>> due to one HVA range being contained (overlapping) in another HVA range
>>>>>> in the IOVA->HVA tree. By creating an IOVA->GPA tree, we can use GPAs to
>>>>>> translate and find the correct IOVA for guest memory regions.
>>>>>>
>>>>> Yes, this first patch is super close to what I meant, just one issue
>>>>> and a pair of nits here and there.
>>>>>
>>>>> I'd leave the second patch as an optimization on top, if the numbers
>>>>> prove that adding the code is worth it.
>>>>>
>>>> Ah okay, gotcha. I also wasn't sure if what you mentioned below on the
>>>> previous series you also wanted implemented or if these would also be
>>>> optimizations on top.
>>>>
>>>> [Adding code to the vhost_iova_tree layer for handling multiple buffers
>>>> returned from translation for the memory area where each iovec covers]:
>>>> -----------------------------------------------------------------------
>>>> "Let's say that SVQ wants to translate the HVA range
>>>> 0xfeda0000-0xfedd0000. So it makes available for the device two
>>>> chained buffers: One with addr=0x1000 len=0x20000 and the other one
>>>> with addr=(0x20000c1000 len=0x10000).
>>>>
>>>> The VirtIO device should be able to translate these two buffers in
>>>> isolation and chain them. Not optimal but it helps to keep QEMU source
>>>> clean, as the device already must support it."
>>>>
>>> This is 100% in the device and QEMU is already able to split the
>>> buffers that way, so we don't need any change in QEMU.
>> Noted that if working with the full HVA tree directly, the internal iova
>> tree linear iterator iova_tree_find_address_iterator() today doesn't
>> guarantee the iova range returned can cover the entire length of the
>> iov, so things could happen like that the aliased range with smaller
>> size (than the requested) happens to be hit first in the linear search
>> and be returned, the fragmentation of which can't be guarded against by
>> the VirtIO device or the DMA API mentioned above.
>>
>> The second patch in this series kind of mitigated this side effect by
>> sorting out the backing ram_block with the help of
>> qemu_ram_block_from_host() in case of guest memory backed iov, so it
>> doesn't really count on vhost_iova_gpa_tree_find_iova() to find the
>> matching IOVA, but instead (somehow implicitly) avoids the fragmentation
>> side effect as mentioned above would never happen. Not saying I like the
>> way how it is implemented, but just wanted to point out the implication
>> if the second patch has to be removed - either add special handling code
>> to the iova-tree iterator sizing the range (same as how range selection
>> based upon permission will be done), or add special code in SVQ layer to
>> deal with fragmented IOVA ranges due to aliasing.
>>
> 
> This special code in SVQ is already there. And it will be needed even
> if we look for the buffers by GPA instead of by vaddr, the same way
> virtqueue_map_desc needs to handle it even if it works with GPA.
> Continuous GPA does not imply continuous vaddr.
> 

My apologies if I misunderstood something here regarding size & 
permission matching, but I attempted to implement both the size and 
permission check to iova_tree_find_address_iterator(), however, there's 
a sizing mismatch in the vhost_svq_translate_addr() code path that's 
causing vhost-net to fail to start.

qemu-system-x86_64: unable to start vhost net: 22: falling back on
userspace virtio

More specifically, in vhost_svq_add_split(), the first call to 
vhost_svq_vring_write_descs() returns false:

     ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num >
                                      0, false);
     if (unlikely(!ok)) {
         return false;
     }

Maybe I misunderstood the proposal, but in 
iova_tree_find_address_iterator I'm checking for an exact match for sizes:

     if (map->size != needle->size || map->perm != needle->perm) {
         return false;
     }

During the device setup phase, vhost_svq_add_split() -> 
vhost_svq_vring_write_descs() -> vhost_svq_translate_addr() -> 
vhost_iova_tree_find_iova() -> iova_tree_find_iova() is called, but in 
iova_tree_find_address_iterator() map->size & needle->size mismatch. I 
inserted some printf's to give more information:

...
[    8.019672] ahci 0000:00:1f.2: 6/6 ports implemented (port mask 0x3f)
[    8.020694] ahci 0000:00:1f.2: flags: 64bit ncq only
[    8.022403] scsi host0: ahci
[    8.023511] scsi host1: ahci
[    8.024446] scsi host2: ahci
[    8.025308
vhost_svq_translate_addr: iovec[i].iov_len = 0x8
iova_tree_find_address_iterator: mismatched sizes
map->size: 0xfff, needle->size: 0x8
map->perm: 1, needle->perm: 1
vhost_svq_add_split: _write_descs fail, sgs: 0x7fd85018ea80, out_sg: 
0x7ff8649fbb50, out_num: 1, in_sg: 0x7ff8649fbb60, in_num: 1, 
more_descs: true, write: false
vhost_vdpa_svq_unmap_ring
vhost_vdpa_svq_unmap_ring
vhost_vdpa_listener_region_del
vhost_vdpa_listener_region_del
vhost_vdpa_listener_region_del
vhost_vdpa_listener_region_del
vhost_vdpa_listener_region_del
vhost_vdpa_svq_unmap_ring
vhost_vdpa_svq_unmap_ring
vhost_vdpa_svq_unmap_ring
vhost_vdpa_svq_unmap_ring
2024-10-08T15:12:22.184902Z qemu-system-x86_64: unable to start vhost 
net: 22: falling back on userspace virtio
] scsi host3: ahci
[   10.921733] scsi host4: ahci
[   10.922946] scsi host5: ahci
[   10.923486] virtio_net virtio1 enp0s2: renamed from eth0
...

This is with similar Qemu args as Si-Wei's from way back when:

-m size=128G,slots=8,maxmem=256G

There are also some error catches with just the permission check but it 
appears the vhost-net device is still able to start up (when not 
matching sizes also).

