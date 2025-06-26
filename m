Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B47FC7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 12:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUm6p-0006Ht-H2; Thu, 26 Jun 2025 08:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uUm6n-0006Hj-5X
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:53:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uUm6k-0002nF-LD
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 08:53:40 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCaZNH021266;
 Thu, 26 Jun 2025 12:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=7J1taDCBVMIEAnceCNvbIyd+Wt+/cQ15ZD5Hh3nQK7g=; b=
 YTKF3bwBEqLffQQf4NTNyHFE36yTgQSFAg1c4iRR/OqulXyPYYQoR2KXmGBP9DPp
 1xOiUkkCvyZ16OkSHjBrNXlZB+m+2UvGTkB4TK82hiy5JMBMYQeOB+g8DZON2UW+
 LVv/JWhalRtLt0RAfev5lucK0RnjjleOmGSww4PosYWW2L6ZGLlEQT152wKKW6o+
 Ma9nDnFYf5o7mgX56wOKAigHIorR9fTn2oQ4E8xYgMNZu+zMCtq9F2YgM2KE2m3D
 IJ8p7wFE4UzKWwpFTj1MLWQDGwmMDnvoJ7JoE/mWs5WYZw+3Li/cNWq/E2EHg+42
 lwM+lNy4IojDMVipuy5SzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8y9se7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 12:53:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55QBk9oa034426; Thu, 26 Jun 2025 12:53:30 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehktey9f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 12:53:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNj35Z0HxHMR+XSnp/J+C5kFz+RKjUG85r3OoC5bV8h4H/Byf53xnvZ90zMh/Qs1utyrF/zl673Gg03nIO8TsuY4bvF9wK/P6CcBblk3x0oeeglyO1KisNAufpyn31cR4ZijAKOaxf+zDlBaCrkS5RUMgYlCxvb63kvC+ux6Ni8cbNpj9NKYp71VTv0ezT0UqYQrPQPfD1+F3dYtynEJqliIDvDC+5HWpj8EKLC3xGKA/MeVgNrkl5+oISEcUfRqjEnb+5cjUlM3BL9LJoALwkVaLp2uBzSdFsWEW4j7kscCadLEabTeAFRl9OwcdjHFXxEkvcBOi0vh3NoXTqVLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J1taDCBVMIEAnceCNvbIyd+Wt+/cQ15ZD5Hh3nQK7g=;
 b=WsLDBUGt5cU7X0j/mQJDGjW5EX1JxtEea26cXyLjEA1EXG4bLutOrqycsmnK4SjfWrXnEc9F6Uc9VDHS83+GXOsPPT/Wg1nzD3GXiYEcwLb/LOOCT/s6gpPzOTcEc2UTP0thm/nFPQiWDwOsKC4ECdPLFiWnt0xdWYN80F9nCtFFt7ygeaudROZ/lvYSjPqG/v+1EFfIDS2XKdlmwlegaG6i3Syyeu+5HLMn4J66c/kAMqgSFdnITl7maFGOOt3BB5tEagyAu8z8jgTk+pb6B9XV7aNVK1QQL8z5iMhQXqwwRaG8VMLBjAiNklrGcaH1df4Jgyebp0Tou5sN2MEt1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J1taDCBVMIEAnceCNvbIyd+Wt+/cQ15ZD5Hh3nQK7g=;
 b=po1+lABH+msP6JQ+veQu+jJzSgkrFbCL2dDRMYP1amCznMPdbbKs2mrX3CPA+87kR3b8aN4i8GOiv8LYULJ1UIc00AQg70Em2uxT2MIY4CO04ew+l1AqN8Vm71UCs7Do8ttCSCJOhc0DfuJm2Dd0qpJlp8xt26l+K7ySb8oUdsI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7180.namprd10.prod.outlook.com (2603:10b6:8:ed::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.27; Thu, 26 Jun 2025 12:53:28 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 12:53:28 +0000
Message-ID: <82566d3e-edd9-4860-8fcf-c676fd112bbe@oracle.com>
Date: Thu, 26 Jun 2025 08:53:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] vfio/container: Fix potential SIGSEGV when recover
 from unmap-all-vaddr failure
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
 <20250623102235.94877-4-zhenzhong.duan@intel.com>
 <9479b426-c725-4b8c-baa9-246d0d7d1fa1@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <9479b426-c725-4b8c-baa9-246d0d7d1fa1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P221CA0020.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:32a::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: b03a4c02-f6ce-423b-7a24-08ddb4b07240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RHJhSVYyNnl3YWh4a2QrY05nWjdZSjBpbGlFZkVqcmhDME5ON1ZNdUJobVBB?=
 =?utf-8?B?eG5DL1FNMXQyNHhHbWdDVnhYR1ZXZTBUMy94NjVJaysyVitmT3U2ME5nOHlK?=
 =?utf-8?B?eHdLalBIaFdBa3g3Q0hyRDlCWU8xU09kb2hSSEsxalRpbXdXN0pPSlNDdGxN?=
 =?utf-8?B?bWswYzlIY3pYdjk1Nkg0d0hKeS9ZV0Mrd2dncnhoZFlyR2RER3dSR0F2Zjhm?=
 =?utf-8?B?R21BVVNFVzQ2NlgzMTJOSDB1Y08rOEtvYnAya2l4dEo5STJOenZXL1lBZTdP?=
 =?utf-8?B?SzE0RUJlaldNT0ozNEMxajN4RDRvaW5RSE0wQ2VsOTdWWmlMeEJRaUFJSlE5?=
 =?utf-8?B?dC9aRk50NnJVU3VnbHJQS25GdjlCSDFKTFJMQldqb1lKQ0tRNzlpM2xKdHVa?=
 =?utf-8?B?Vm82MU1yZ2M4MkN4Q0E1OVk1cERleGhtU2NwVjAyQ2JHY0tqOGZFMlF1dm9w?=
 =?utf-8?B?YjVuNXFpZU1tN2VxM0RiRUNNWlJ5VEM3WHVhcXhDNUtBMFZ3ZDRwR3hkTktt?=
 =?utf-8?B?djM0T0tYZVRWM0ZFRlBCTlZ2NTN2ZXBCc2NVZVhOSUt5Y2FuTit0KzV0b09W?=
 =?utf-8?B?Tm5LY2ZHUHdXem5DKzlQaUhRQjVzNlRTZHNJbnlUZzB3dXpFU2Ewei91NXda?=
 =?utf-8?B?WXlvelkweEdqeTV6QmkveW1vM1lUdEN3SlJHdXlueXVrd3FhVzdreFhLWHR3?=
 =?utf-8?B?Ly9JdFcvaWRXS2JjYk1TTU5JN2dlRjZIVG10bGk0TDVYWnJnU3FiUU80disx?=
 =?utf-8?B?d1lKNVdXVUw1UStQbXI4cFFpbFBHSVVRaVI3OEpEQ3ZVOGVUVGRXT0k4MzRD?=
 =?utf-8?B?L1pjT0RyV25Vb3k0L3NQYm00czBGUlVGVzBoY1E1b2Q1SnNEdSsya2pBK1E3?=
 =?utf-8?B?ZEcyd1VHSW1idVI5Z2pNenE1T0NmcFdCeE5WeGMyRkk0K1Uxb2JBeTltL0hM?=
 =?utf-8?B?a1k2bkk2cmVPZjUzWUdjNmxlOXFvWW5lYUZOQ0VXdFJ1SE9aMHJWWWVOdnF6?=
 =?utf-8?B?Uk0rL3N0NW5xK3Ryc3RoTG9tTVQzWFdYM0c2ZGFUVmhTM3N3VkhnN2dkNTRQ?=
 =?utf-8?B?RThLQlNzSmhmbUVEL2dia0ZqZFRreXNubWdDbFZHZXkydVdKVmZZVFNrQTE4?=
 =?utf-8?B?K3NWNmtJRXh6SnQ1NHNadkVZdXNHUHAzTmlTcENTb0kyamtuREVwajVZR0Nn?=
 =?utf-8?B?ZytvUmxGclcwbnlHYmo0UGtrdnNteWVYNjdQbTJlMDhJYkFVclBoNEdmOWx5?=
 =?utf-8?B?SEJEQlVqMW5LamRNTTVxdlpHVWxnZWxvbnlSbC9ndHM3RXNwSnhDNGlBa3g0?=
 =?utf-8?B?OU5lTCtnODltK1A1SnE5RjJ0d3dIUlZXS05IZUZFTGdydld2T1dNRUF6NHlx?=
 =?utf-8?B?cTRCYlRkOUpnWS9YUWhpdys2YjE4aFAvWlRXcTd5U0llUHRCSUlZTnhkNGM2?=
 =?utf-8?B?MHNDVXVwYS93SXNyNjAwL3hBRm9jRzFmaDhaUytuNGVXZ3VvNmxJanZqOFNF?=
 =?utf-8?B?TEt6YzJ4c2lUWWtobjRKcWdlV1BNMWswOVNDSHloalg0ZGZpL2N1S0Fyd25H?=
 =?utf-8?B?cjhlTnBzdFcxSXNIblJCMUZ4MW1xSkZCazkySGQ4SjJWeERDdEdlK0xheDQr?=
 =?utf-8?B?aGczZHMwT1VGRTVaNDdGSWlqb3FHRzRadG5sZVlFM3MyaGRvU2w2SG94cXo4?=
 =?utf-8?B?K2RnMmxhK0hWS24reGIxWDBoM0g3c1JSNmQ4enVna252ZWphcGp2ZDFrRTU0?=
 =?utf-8?B?NExFaXAwbzBhZElLaW1VUHNwSXJtSlFaaGMwaFd1M2NyUlVxKzhSWForVXBJ?=
 =?utf-8?B?S29vMjBqMTFnaHI5T1d4RTZndVE4ejBXVERSKzFEK0ZrU3Q1anlHMHB4ZVdE?=
 =?utf-8?B?Qko1cHNrK0hpY3o0QUJtbkVYZlludE82QVptTC8yZlpqZVJ4Z1N6bDFqTG10?=
 =?utf-8?Q?xeM3WtCJ3XY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlYyTTMxbXBzSDRyMzNWRUhBbG40c0psOVFSSDh2NFpuWHRJK2dxWmVUY2lB?=
 =?utf-8?B?ZU95aEhoQmdxWjRHWjRqT1pERWJHMU9lNGdUNkE3NzR3MGR3ZFY5d0RycFoz?=
 =?utf-8?B?TWNRUytEWXlxYzJnbjRBOEJrWnNiMVIyRGJPR1dEcmFKZGxUckRzZUFzVkhU?=
 =?utf-8?B?aVFpcS9KVG84Qy9LUXBLV3E1VVdGMGxFdkpRc2xyL0RsdWRZTFdwcGNBOERZ?=
 =?utf-8?B?YTNzdGQwb3hLTlhQOFp5Z2xQOUpmR2ZpUkdtaTlDOThraEljNlAvd2xZOEJk?=
 =?utf-8?B?aDFVYXhqaVVvMGtCQkZkblJlZlVLVUFCS2MxcGVwbW90T05CLzN3WW9DUWlx?=
 =?utf-8?B?eTJPVzc3NHBDZVZSUDk1NncwVzRjVmFOUDBMa0NHNWZlYm9ObHhNNkxFVzJP?=
 =?utf-8?B?SUFVdWxXclZzTk1oMnQ1YllGU0pFNkJGVE9pU3krb0V1RHFnTkwyQWcvNXls?=
 =?utf-8?B?Wkl5MjVNZndzMUdMSmt1TkFRK3FocVNtVlF0ZmtkT0szS3BUcE1TeUx2cWEz?=
 =?utf-8?B?RjU3MFdYTGQzbzB2OXdWYzVnSExGaHdwaHJsV2t6a2tlTmFOSzFXWVpvTENJ?=
 =?utf-8?B?SUJ4OEtCTUxKV2wyeU4rVDM4ek4wcUlxWGFRQVZjaU0vVWZ4dnRGSDM1VnZC?=
 =?utf-8?B?emxKbEwrUEhuWHJ4NU84U2paY2R2TnhqUmwrYzM3SUkzVm5uRHZqK1pTQWFn?=
 =?utf-8?B?cGlLVTBVQkRRUG45c25odE9HM3FMcmpIbmNLbkRpV203Mk5SWGlWckN6Q0Y5?=
 =?utf-8?B?UzVwVFRKOFdxRTUyeWw1ZTNIV2VRemJXS0IycS9RZHhQNUc5MVVXS1B5QTg4?=
 =?utf-8?B?MlVXOUR1OUVTTnJsZisyZEloc1NwbEIzQU01b2lYNXJZcWhaTFhNazBKZDV6?=
 =?utf-8?B?dkE3bjFORmRzVDNoNVRtUThjU0FyY09ESlpLM0hhMEQrSVpJdjR3V3NtZm9N?=
 =?utf-8?B?TnhXRmF5UEYrOXhWOTZjRTcvK2tOQWNyeGVRMGxGQ01DRlFZNHZ5U1p6YmJ0?=
 =?utf-8?B?aVJidlNxS21VcDFyRUhoYTl1UnlCellWclA5anZWRFpuUEw2VWs2VVYvWWlz?=
 =?utf-8?B?bVJwM1NzVjVQZHUxb0lPMlVBaG9HNUw2NTYvZWUrYk5BeENMNnduVFltRlh6?=
 =?utf-8?B?WlREOU9SU2EvSktodFN4bCtCdXE0YUZRei94bVUreGk4cStRaTlDMVk1eVZI?=
 =?utf-8?B?M3pYbVdlTmV5VThyVlljUnFJTlNXa1AxekZzZC9qc1paUFVWZ2VMYVZZem1W?=
 =?utf-8?B?RW1CaEgzNDVPUHA5Q3ZnRVJ2bHhET2JVQVd4TmEvWXoyL2w1K0ZTTStzY3JN?=
 =?utf-8?B?U3BNV0h0Ry9raERlRXc1QjdGcHdLQjBiVVNyczJzeml6dTUyam9seU5KMlE5?=
 =?utf-8?B?U2dScjRJT2VWZERncUFlNmpNMEpLRkdzOSs4QUo3NCt6azRVZnlnM25acGlM?=
 =?utf-8?B?b0ZkdVNGemdPWTFSTlNFZlpmRkhPdTA3VWt6OVl3NG94WXBOWU9lRWJzbHFP?=
 =?utf-8?B?Ym91UFVzUGN6VzV3YUt6UWJqNTVKclJmTFpUeUZVQk5rbHlRL0pjSnNkeGdJ?=
 =?utf-8?B?V0czS0k3YmRTVnpOamZxZDgwOXFpaDdUcjh2QVRLb3JldldlTlhsekR1d0R5?=
 =?utf-8?B?RG01U2NqM1VYdlJCVTlzbXZnY05jcGg4OThMUnI1VXFabVR2WDRZRVlXZFN1?=
 =?utf-8?B?WnM4RTFWeFFzazlLNXZpUkxSZWNveVlTUDVQd1hNUTRIellwSFk1QlFzaFl6?=
 =?utf-8?B?cE5qcGFhUEVvUFdFZTJQWmtkT05GcjVzZUYrNWJzTEROU3VyWGN0VENxOG9h?=
 =?utf-8?B?MFZnUnZQbHFjNEtMTmhCTjBtdytTOXQwaGtUTWt4WmQ0NjZ3bCs0NktsVjJL?=
 =?utf-8?B?QW9UME80bktNNFdUSnpjNXRvN2NSc3dISGwveG5DQXVQM01mbElVcCsyUGNh?=
 =?utf-8?B?Y2FOZ0FNK1lVeUVrWFJ6VFQ3MEkrR2NmeEx3Q3h6dmNmUDNxS2QzQk1ZVlYx?=
 =?utf-8?B?Y05VRVNvMEVoSU5raXJwYW9DVXRwbDEzS3BYcEQrbkFKNDNzTWNOblc5SkhE?=
 =?utf-8?B?VHVjVlNhZ0dJdTBvUkpvSUVOa3dubmZmTjZodHV2L1U4Zk1Gd0tmQzdoTHgy?=
 =?utf-8?B?dU5UTXNWNVNXd0dKZ3RjMzM3RDBTRTJaY0pNOFN6M2FXOFMvcnRBTkExWHBu?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9+Y1PWJgRX/pyklKVAoh9NKesrx79ctm3p0Pd4ksctSLolJSafWpIoP7ZimivNNLcUDYwOeot5VurunI90Mgm7WKA+vTfGszs985dFLYIgi+tDJJm+leHk4kcqXBD8dl1G7aIA9p6D5IspiyCxb4lA1dTUeDO2FEm164Lby+5Gulor3q+VjPdiu2zAS1QWHACi9EThTtKn51U1O0b/4+9DKOClg90fbIfrPHnpsKe406ApMk9b8tU/ZT+04MjWwnIYsxzbWHi8xq3d15w9zbsKRbuFvHOw3lwndJaQ00YKhNDP57lPclgmz8/7Mj3odEqQlh2R3hhvnXkwVmsiSiPKyNPc9f9ETjUA9JKKQ7SXRTXo0Wd0ZDRtwYL8EaTMx8AOIb0iiURXvlQ42NZtM2kc5jhqviw+ttEUI2gor84WIGWrkDaNkGMq0FPTDXcsltXmv10/Hxq5AZGYvlCvVgSS7HrAHnqI0Wm+6s351iLgp2flNLlZlXpTqsipCx6Viw7Wij47K7FZFn7s2dl7dXYu2hsA1EoO6bEgmvsmAmjgOAS4YpTOW9w67tRZmpIpYvm7McvR3+rfTcn0yCdH8vibOW/4/V39iAry993S2ufMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03a4c02-f6ce-423b-7a24-08ddb4b07240
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 12:53:28.2525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 37XvZX5VVr+xwALJMX4w1Dc46OkFtMdHASih/5KTlqo30/RA4WnhZ7B+Y0qcXToKNiXJFyQDVFT0WTMe2q3qFalVLlF9gcQGN4fUtEt+sAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506260108
X-Proofpoint-ORIG-GUID: bwpr6mJ2utK-cE1_iPjAWqHoySOJb2g_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDEwOCBTYWx0ZWRfXzuMELWOVOgpp
 8zzZRTsKiTQedQfJ6OoNsv6mADaxb5RWhaTQqZ3/z1QCJTgwk6ypn9n4GWmAfdakN9UBAoNIBOT
 155MoWtU5qmEyXVnPmQvllM7h3wl0CgHmgUaIE742tp2ZQ72Ei3jgTZnZ0Iks1YnRsxIbYdMR8z
 AH4ZIPLqV3mE7mKa+ReJhow05HPd4eBCh17wghwg6zGCbmqKY/40Zn7Cvs3EChqaftwc22dHjD0
 I7xJTA0foQo84tOMpfS4T8nODgRVi1enV0M/GSI8yPmFX80E5OltlCT8fO5yrL1BYyQhvByZgSm
 cXcJXuj4XFP6KzxMen85K5/XHWzl721BE8w7uXKDB+GKe5nRxsT8Qm9fdyFsWyDiaRLj3YuJ/dW
 d6IhBlKKRnOVhK6MfLRSZWw9fdcoaP/hAgVFlu1thZefM3G3ILE+9efLDsJtwrcfbWqNDTde
X-Proofpoint-GUID: bwpr6mJ2utK-cE1_iPjAWqHoySOJb2g_
X-Authority-Analysis: v=2.4 cv=PqSTbxM3 c=1 sm=1 tr=0 ts=685d42cc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=YY4rvWIor2LhVpV8WEsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/24/2025 12:54 PM, Cédric Le Goater wrote:
> On 6/23/25 12:22, Zhenzhong Duan wrote:
>> cpr.saved_dma_map isn't initialized in source qemu which lead to vioc->dma_map
>> assigned a NULL value, this will trigger SIGSEGV.
> 
> I don't understand the scenario. Could you please explain more ?

Thank you Zhenzhong, I see the bug.

CPR overrides then restores dma_map in both outgoing and incoming QEMU, for
different reasons. But it only sets saved_dma_map in the target.

So, a more future-proof fix IMO is to always set saved_dma_map:

@@ -182,9 +182,9 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *conta
      vmstate_register(NULL, -1, &vfio_container_vmstate, container);

      /* During incoming CPR, divert calls to dma_map. */
+    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
+    container->cpr.saved_dma_map = vioc->dma_map;
      if (cpr_is_incoming()) {
-        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
-        container->cpr.saved_dma_map = vioc->dma_map;
          vioc->dma_map = vfio_legacy_cpr_dma_map;
      }

- Steve

>> Fix it by save and restore vioc->dma_map locally.
> 
> Steve, this is cpr territory. Is it still an issue with the rest
> of the patches applied ?
>  
> Thanks,
> 
> C.
> 
>> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   include/hw/vfio/vfio-cpr.h | 8 +++++---
>>   hw/vfio/cpr-legacy.c       | 3 ++-
>>   2 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>> index 8bf85b9f4e..aef542e93c 100644
>> --- a/include/hw/vfio/vfio-cpr.h
>> +++ b/include/hw/vfio/vfio-cpr.h
>> @@ -16,14 +16,16 @@ struct VFIOContainer;
>>   struct VFIOContainerBase;
>>   struct VFIOGroup;
>> +typedef int (*DMA_MAP_FUNC)(const struct VFIOContainerBase *bcontainer,
>> +                            hwaddr iova, ram_addr_t size, void *vaddr,
>> +                            bool readonly, MemoryRegion *mr);
>> +
>>   typedef struct VFIOContainerCPR {
>>       Error *blocker;
>>       bool vaddr_unmapped;
>>       NotifierWithReturn transfer_notifier;
>>       MemoryListener remap_listener;
>> -    int (*saved_dma_map)(const struct VFIOContainerBase *bcontainer,
>> -                         hwaddr iova, ram_addr_t size,
>> -                         void *vaddr, bool readonly, MemoryRegion *mr);
>> +    DMA_MAP_FUNC saved_dma_map;
>>   } VFIOContainerCPR;
>>   typedef struct VFIODeviceCPR {
>> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
>> index a84c3247b7..100a8db74d 100644
>> --- a/hw/vfio/cpr-legacy.c
>> +++ b/hw/vfio/cpr-legacy.c
>> @@ -148,6 +148,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>>            */
>>           VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>> +        DMA_MAP_FUNC saved_dma_map = vioc->dma_map;
>>           vioc->dma_map = vfio_legacy_cpr_dma_map;
>>           container->cpr.remap_listener = (MemoryListener) {
>> @@ -158,7 +159,7 @@ static int vfio_cpr_fail_notifier(NotifierWithReturn *notifier,
>>                                    bcontainer->space->as);
>>           memory_listener_unregister(&container->cpr.remap_listener);
>>           container->cpr.vaddr_unmapped = false;
>> -        vioc->dma_map = container->cpr.saved_dma_map;
>> +        vioc->dma_map = saved_dma_map;
>>       }
>>       return 0;
>>   }
> 


