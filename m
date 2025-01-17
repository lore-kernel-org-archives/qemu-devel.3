Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F72C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpgc-00025G-Lr; Fri, 17 Jan 2025 11:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYpgX-00024m-5h
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:59:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tYpgS-0002T2-WF
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 11:59:04 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HEfnL8026592;
 Fri, 17 Jan 2025 16:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=allMd8CM/gdTb6YjhUQH3uO31+Mjr/EVo7Vj+YnxeKk=; b=
 MdhxoBYkcJc2m/ycJMSj3jXQhUi/Az9yadbMkgDSzz/nP08PlooJ1Ntyu/9NBdIi
 AQC+jcsHZez5nfgd53ngszuOparKtBkolG+o7QTMj2gEazHeBscTN4/jJn6M+ppi
 OgPS7gd7j7C/1ZCgC/1qqsCRF7ZUgUV1Jijb7szFY6Q75y9mHOre7BeYDNuHU5g0
 2pN6U7qimhiW1zFMdxyJ8XAn0bawloneCJldWbPwGqi/NqZQno4yfv54hKASF05q
 KM5rfcG6o1OjGUvX81l6TFVcRKeak6dvSbYrVsOyWpz4ynTLoCyonkrehcQtBui1
 M8KSRVOVs5hvoyRSPsyaaA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 443g8sn0r3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 16:58:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50HGmuJk004645; Fri, 17 Jan 2025 16:58:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4473e6jwr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Jan 2025 16:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNTzP5TRv+v8tqKuDxNDaIwhdIkxInt0oFrmNH9DflwYecGgPUiRpbTfFD7fcGFBPFK3QkNLDaPNc+lrXncoDgE3vbx319Hf5lDQ2+6moZ99jEBhL7PF5YznVvDXRpkxCeJLp1SB88E59u5jaFYJpzVXXFaltPJ8xEmTRjEp3KhekfWbFX2DqSH8rU0SvE3Hok0yXa6nH/9jzRTYj56Qv1xB2E/kt2gxo/gUa9dYtkiPuvDMoEf4Y9htQGWcDRNOARteiGn28rIRCFjKQ2M5bsUrBV03Bi+caOezxgm67DdoS034BDSZuE3CEO/whbcfTZ7x7qSz0TVh6cjz4b6SWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=allMd8CM/gdTb6YjhUQH3uO31+Mjr/EVo7Vj+YnxeKk=;
 b=yrbO0469AsJe3rR9eCioF/KOpjdmtRIHDLBGZjkDBxikLNGv9or6VenYDJh64QBGqAGxNf6FTR3n3t0k4+z/XxZ8Pg+zlqT3KXJcTmlRotjncuhpjvo56fiKUPRBnDua+FxAr/gndAvGhdcW2WMQuahWYw9VrYsWyyWbbEG+4QZwwcS0ax+O2ACK4SeGCDiGRRnRZQczghBQPOwP+wMnuGvLjaFoQ5V21mMRjbDOgQ+qwn383Yy/q4Nt6jeAhsCrUth5XEs9dHr4DQaBQ30A9SkRFsJNw9L4QjxdrJi3kjcmcBOdZl4Rch8vRjohko9u28Fyp/CTuxxetRUtVkRASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=allMd8CM/gdTb6YjhUQH3uO31+Mjr/EVo7Vj+YnxeKk=;
 b=w+4ahcP32jXpUKF2Y60ilFWn5PG6VzdmFiORZhZqsRyu59ebtE/CUqLP/iLZ2U2S4Vq1eZ65FRmwPeWZ3nM42TncbtH6T82oOLQDz4kA898BBVkAf5trtdFsKplAKZH36KhYlEmJATxkWgZlS4tV4q1Xc+A0f5QzKoE/pgujTbg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by BN0PR10MB4885.namprd10.prod.outlook.com (2603:10b6:408:126::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 16:58:54 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 16:58:54 +0000
Message-ID: <19a1f016-981e-49ea-9ead-bc64f69fa0c1@oracle.com>
Date: Fri, 17 Jan 2025 11:58:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 24/24] migration: cpr-transfer documentation
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-25-git-send-email-steven.sistare@oracle.com>
 <87tt9xec2y.fsf@suse.de> <68bee183-ba2b-420c-b885-a6ba630f74fe@oracle.com>
 <87r051e9xb.fsf@suse.de>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87r051e9xb.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:408:142::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|BN0PR10MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aa07991-a8d0-4d8a-2483-08dd371839b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGNLSzA2WmVvbUtjVzZ5bjlOZ3NkYmZLcjJxZVpQY0pGYzcrd0xrTDFOZ0c2?=
 =?utf-8?B?bUd3b0gvU0xCU2ovOFNKZUQ3WFRhc2M0R2VCY2NHcXZiVmlIOXNiREFQZWFn?=
 =?utf-8?B?ZzFCL1hGbHZ1SHNVanV0MHVRU3JXSEVlUGdwbDF5N3FXelUxVHJzY3o0Vi8w?=
 =?utf-8?B?Q085Z205ZS9wT1dYLzVhb0I2Sjd2b2lYc1FHd09nVGtxZ3UxMTMvQUt3Tisz?=
 =?utf-8?B?QUhiNHdPdDc2YjZvOUVTNGhldnlxZmx0dDg2THI5TVRZTmhRWGFKUXJTbmUr?=
 =?utf-8?B?VFBldysrWlZBRFJ3RTRQdXcxRFBSSFFUNVNaUUI3aXBYYmtSRHVuc3BhQ3lZ?=
 =?utf-8?B?Z1BYQ3BXRTRaaFZhTHFwQXVrNTgxYUlsZFBIM25mRDRacGxSN0JLc3pwdW1R?=
 =?utf-8?B?anRKRDlFanFPdmptbXhCSXhIcGpNa2lTdlNTUU1CNGJjaEd5NFo5eDhBQmVZ?=
 =?utf-8?B?aDhIS3pnbVhvc0JJemI3dnZrN3lhOXJ3VmZZalhSMVZqSzBka0k3MUJMcVZo?=
 =?utf-8?B?T3FOR01TZGlOREJWcjh1eEx5OXpCcUNzNXpKeXJYZXBLVStYS3ZsLzVtY1Jp?=
 =?utf-8?B?Q3NBZi94QzNBMWh0Vzg0dGdUcDZnTDYyb2ZuZDlSbk5PeUZJdGlYOHpJWWVX?=
 =?utf-8?B?clVBUTNEVVVTelBRK293dEtOWXd5aUZPNDgvdUFKRDVIOWRidEdGRzVycXRq?=
 =?utf-8?B?S2NBWmdFQ1hVTVFMWXlBZW1KS05IWFUxUVhTaFZ5RmJ1cnUwaElZRmZkWlZG?=
 =?utf-8?B?TVpsZ2NyR3VvcGEwdFZIbDYxZlZTR0k3Rjl3RFZZU2pjVXpJMjRGc3oyZk94?=
 =?utf-8?B?M1BZUUMxRCtIVFZZcTNDZndiakR4aUN6QlQ5NVY5TU5vUTJ1d0tTTXhZNU10?=
 =?utf-8?B?SDZuQ0oyUUxBbWlFYldQaFRQWlZuOE5aQ3dCTXcvQ09EU1BLNzVMVGhlUlpG?=
 =?utf-8?B?akE5azd2amlTeDV5U0dwTzJxZTBQK1A3cEJ0UDNJSFpaMHNJTEpVb3VUd3po?=
 =?utf-8?B?RTM1VXZ2MDJkclVuTlo3RmVNTDMrU25oV1VOT3FxdWpmME9OOW9aU1pneVM1?=
 =?utf-8?B?N2tXNnhTc0U4UktCcWFxemZyamlZQjlwRUtuZW5Fa2hqeU9nUlNrcUpTNlhG?=
 =?utf-8?B?WFVld2YzRWRmN1pDNHYzZUQ0Q2RiUGdRaXU3Z1czSStlbDdVeml4bFplNWZV?=
 =?utf-8?B?eHJNaVFWOXRjQWpNaENoOTNTQ0xoajdmSlp4L1Y1MlRyUlVtdTM5ZTAwdEcv?=
 =?utf-8?B?YytaNnlEVWFXbmFQRjhNVXFjMnNjcm1TOVZ6VWlFZTdITkdsc3lvNmNWN0tv?=
 =?utf-8?B?ZjM5SHZEZDIwSFduK2FrRTFiLzRkeHhEVWFIVkNCVEg2a0drekJBQXE2OE5q?=
 =?utf-8?B?TWRTcFdPUWhnaGJMRSt5UXJ4dC83ZGh4bk8xanJWVktZNmc5a1c2dnhtUVlj?=
 =?utf-8?B?ZjRsVzdxbm1DWksxd1BnYTdvY1hXSVhxQW5sN1E2RU1XamIrRW9BUE4vQUFR?=
 =?utf-8?B?T0FsMTNpWno2MW80NnI2MHpjVHFlSjczLzNXaUUwUHNvYmJFRWVXcHdoNER1?=
 =?utf-8?B?NEQ3WnpTcjhoS1RnT0RHN3JPaUdNUHc3bU4vTHNTSFFOenZUZ2xUaW4rVHNr?=
 =?utf-8?B?MUpBVjBSdEU1NHhaU0RacE5SME5TT3NYdDF0RHEvaDRIVlZQRTczald4NG1q?=
 =?utf-8?B?WlhsVjYrSGlRekYyaFZuYTRxTGRybDIzZ1Z4by9Xd3FVc0ppL3N4YTNWR0p6?=
 =?utf-8?B?eTdrNWxySm1pRUU5eHhLdWgrT3ZNTC9tcHhaOE8rcGFRSno5MWZYeER3cmR3?=
 =?utf-8?B?Wi9QckZXUkV2d3lGMmxiUkZNbHlHZS9QZUR2UFZRNlo4dGJLVGxjTE1uREVi?=
 =?utf-8?Q?oJpbLYLkBBd4Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVFFbm96VEgyZFgrM2tXTjN4VXB3dDNhcjJjakVsbDdXZUF1d21xR09vUkc0?=
 =?utf-8?B?bUJMQmJrTnBXS0xDTy84Wnp6VDFUb2JCbmQzamthY01OQi8vOXN0cytKeXZU?=
 =?utf-8?B?bTRNYXMrcnJEQ3JVQ1crdEpKaFN6YmlmdFc2UXJveFYvQ0U0RHBRaDJVb1VZ?=
 =?utf-8?B?RzhBNFJsVmVUTnJYSnoreFVlWS9sejdGSlpmYzJRN2V0d1E2N3B0YU1kUVRC?=
 =?utf-8?B?VHFEL3Jlc1JDR2ZVZE9tMG9WQUdheUJSTnU4ZlJiSDh4MmllYlJtdWd4aUsv?=
 =?utf-8?B?UDc3TDltVjAwQmZIUXErRk5TQ3JVSGk2YWo2WDh2MGdVNmNKQkQwYW0xNTRl?=
 =?utf-8?B?L1JJd0xpMFo1SWRCTjYrcnJvU2Q0NjhEV0MxZUpwM2QrT2duS25xTzNzcTdz?=
 =?utf-8?B?enVyclFhd2o2a1lJc01tZnJ0MlExOVplM0tUMGpQUm9oeXlGaHRzOGdVckwz?=
 =?utf-8?B?bEMySE9uLzFBdFltMGpnYkNBS0U2T1B2dFBXVjlRUCs2eXJBYjRPMXZHWHVs?=
 =?utf-8?B?WVRTUWo1YXNNK2Q3dkt6d2kxa3kwL2FKZ0h6S2NxQWh5Y3hmb1YxUXlEUTA4?=
 =?utf-8?B?YmdTbGJqeE9WZHNFN2NGVDdCVnBFWkRyM3pEaHA5Q2FKQlV4aU9Nb2JFb2JE?=
 =?utf-8?B?Nmx4ZWZFWU1OR2ZkS3pIUWRNMEc5cGhFTU5NV0hpU2NrNEFVWEdGakhlQlVF?=
 =?utf-8?B?TSszbFBvb2dVRjdOWEI1cEYyWXVuaTFRcnZHOGhyRGFITG0rQTYybDNFdSsw?=
 =?utf-8?B?ZlllY0o0Q09yNXF6RWdWdUhtVGYvaG5CdWEwN3NxZm11NkwrcS91czBQN1FZ?=
 =?utf-8?B?WmdSV0pXQkpySkJpOTV2bk41emNoTWhUeVFManhUL2VTR0RuQnNMdUVLVHB4?=
 =?utf-8?B?K1F5bkQwMUhhcGRHN0FhQWwwbDl5Yk9Da204Rk1ETXNWVXpGdzd4TlFjeEwr?=
 =?utf-8?B?RGFCQ0ZpZkpMMUdsL0lLWVVuR1NyWndTcHRRODArVnZhWlFyQ0E5Z3IyVllS?=
 =?utf-8?B?a0xwTlpVZHU1Tm5SRjJ0Y3cwbjNmeW5NTVlaR3RQRkNPdWxBUS9ybWU3LzZC?=
 =?utf-8?B?WWlXdFZYOUJBR0hRMndjdkFzZEtpVG40NmNBU2lDRWZnSGJTZWJrbmE2RHI4?=
 =?utf-8?B?NFdSY3BXTFlENGkzaVlsSWdheWFpM2ZDSERMS3VpVnV4NXpsREgycm5qVFU3?=
 =?utf-8?B?MWhmVXhNQysxSXVPcTNnUnpxbFdKUThsUUh1aW5HU1dOVjBvRWlmdGtIN1Rh?=
 =?utf-8?B?dzJiL3BhMjZNN3Nza01qK20rMHM0cmYrM1R3SXpwZklFZCtObG51YkNqMmJ4?=
 =?utf-8?B?VlhneFpJSldnWjRyTkxBRUtNdW52K3FkdURwWlFtT1o4NGpQOCtDL0NreGxl?=
 =?utf-8?B?dGxid0hpTEpaVWQ1MTkySHc5UkUyT3RodDBEaUdkUTFuRXp6RHFmNzJDemFM?=
 =?utf-8?B?aEpPVWcrSVNaY3RHOFZwQmxyNEdUZ3Y1SHpoK2dHcHRza0VwNmZ5V1FmTEJC?=
 =?utf-8?B?ajFWZjVReDBFV01BYkwvMVkyZ09zb0tSWmdlMFlObm9zaStwK1duQm02S1hz?=
 =?utf-8?B?SXNUMUYrQTBOUnVXeTdZS1pQVnNRWk1UMDRieTd0THlxUXhPZGdoZ3dFNlE3?=
 =?utf-8?B?TlNhc3VPcWR6Q2d2bVAxRnAzQmVqdS9PL0ZPWWl0NHYzb1JGaGJwR2lzZ3VC?=
 =?utf-8?B?N2FlRjBZLzZ3V1Rid3llR0dMQmp2YTJadnA1L01qTTRuZUY1VnFOek04L0dC?=
 =?utf-8?B?eHFBa2tXSGd6NUMxYnRLZndIT05yNVQ2MXF2eklYeGFUZ3VWZ1RCcnJKWTV3?=
 =?utf-8?B?bWtoMnhxS0M3QkZFelRBQ3gycHVmZ2xkSFE2ZTBYNmt6SjBUOFFCYlJnVzNq?=
 =?utf-8?B?VUMyYXNabktkSVBtdUxVT2h1eWg2S25zYS84NVdLVGYzVk1TRG9VUVF5dXdq?=
 =?utf-8?B?SUxkc2xWV0ZkVVJSMmVLYy83MENZN3BNZ1o5L0xqOFBLbTBDUldvZjRLdE9H?=
 =?utf-8?B?N0tIQUgrM3c5QVl6ZUp3OTM3MmNlaENGYi9aaldMZ1ZUTDNiL1NZeWVaaTk2?=
 =?utf-8?B?aVBMLy9qNXh3RkZadFNPRWQzcW0yRjFZZTcyQmZlZDNWaWZhb0c3K3hqRmlk?=
 =?utf-8?B?aGtrckk5Mm9ybTdJRENoNG1Nd1JQd2FzVlJGdmFmWk1SdGY2MWVldTVzbXA5?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /OKVlo5NliSbEg0SvlmKlOx9guIK0dXOSTPZvxc1tqnYup9dKcGSqMF4mFQbLJecguvqp1OZjEAxYG6HIDrOSvcnFGEbNXVhjSDI1bdIomOpbca7rb+0fYVA8Bw8Ze41RcsIC02ipW1TLhn/hCOYe/b8xUabcBRn02rfODDMeqcuj87apz9A54ny6ZH2cKC0sNSrBjp1quya3oxHlVRQZq+d3S8AcaAfKfErvZ29GVPKUMV9tCb44YAFE2l/3mXc1GW7YndZbmpcewtjG+H7q/BjGT/Hz8GC/vUbFGC51QLrOJWNwi7yDtsQ3W11GRqHSn1NyQZciAHx5YlT58l9+/l75zaVQZADppOGO9boEpc2fpADbkdWWGyEQZtZ0oRYjsEjswblf+uRdG8Xjokv8tUkXuCxrjfd31lnMkdNhqXQjmC7Py9dlzfTEH8EUi98mFzwNse+Vo4/U7wxMcXY924vyGCkjEa/ZUQpLM55wyiOGMMm8uorbP98h4HduSpKBY5HaAg4uu5lBF0OvjZoWLCV/B5L6ZEFyjS/Qey1rqdNsuukmcxQAcdGUyM+gsydLfqdSzZWClKEQH2UaapBZpnDW/8FP2V6g1a8/K0XeZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa07991-a8d0-4d8a-2483-08dd371839b1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 16:58:54.4931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yy0JZe+B1xnrZjjOQRutG7sg5du356+Y5D8mVv6cwE7zjO8LoIQ0W9OIct/ioSAyvZf+G9FqXDjdPIHR1pAZnFyjRGiA4d6a6HWJBIYqOE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4885
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501170133
X-Proofpoint-GUID: rCoBGACX757rbAWC9VJcb5aWBeu_Ikwm
X-Proofpoint-ORIG-GUID: rCoBGACX757rbAWC9VJcb5aWBeu_Ikwm
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/17/2025 10:29 AM, Fabiano Rosas wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 1/17/2025 9:42 AM, Fabiano Rosas wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Add documentation for the cpr-transfer migration mode.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>    docs/devel/migration/CPR.rst | 182 ++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 180 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/docs/devel/migration/CPR.rst b/docs/devel/migration/CPR.rst
>>>> index 63c3647..d6021d5 100644
>>>> --- a/docs/devel/migration/CPR.rst
>>>> +++ b/docs/devel/migration/CPR.rst
>>>> @@ -5,7 +5,7 @@ CPR is the umbrella name for a set of migration modes in which the
>>>>    VM is migrated to a new QEMU instance on the same host.  It is
>>>>    intended for use when the goal is to update host software components
>>>>    that run the VM, such as QEMU or even the host kernel.  At this time,
>>>> -cpr-reboot is the only available mode.
>>>> +the cpr-reboot and cpr-transfer modes are available.
>>>>    
>>>>    Because QEMU is restarted on the same host, with access to the same
>>>>    local devices, CPR is allowed in certain cases where normal migration
>>>> @@ -53,7 +53,7 @@ RAM is copied to the migration URI.
>>>>    Outgoing:
>>>>      * Set the migration mode parameter to ``cpr-reboot``.
>>>>      * Set the ``x-ignore-shared`` capability if desired.
>>>> -  * Issue the ``migrate`` command.  It is recommended the the URI be a
>>>> +  * Issue the ``migrate`` command.  It is recommended the URI be a
>>>>        ``file`` type, but one can use other types such as ``exec``,
>>>>        provided the command captures all the data from the outgoing side,
>>>>        and provides all the data to the incoming side.
>>>> @@ -145,3 +145,181 @@ Caveats
>>>>    
>>>>    cpr-reboot mode may not be used with postcopy, background-snapshot,
>>>>    or COLO.
>>>> +
>>>> +cpr-transfer mode
>>>> +-----------------
>>>> +
>>>> +This mode allows the user to transfer a guest to a new QEMU instance
>>>> +on the same host with minimal guest pause time, by preserving guest
>>>> +RAM in place, albeit with new virtual addresses in new QEMU.  Devices
>>>> +and their pinned memory pages will also be preserved in a future QEMU
>>>> +release.
>>>> +
>>>> +The user starts new QEMU on the same host as old QEMU, with command-
>>>> +line arguments to create the same machine, plus the ``-incoming``
>>>> +option for the main migration channel, like normal live migration.
>>>> +In addition, the user adds a second -incoming option with channel
>>>> +type ``cpr``.  This CPR channel must support file descriptor transfer
>>>> +with SCM_RIGHTS, i.e. it must be a UNIX domain socket.
>>>> +
>>>> +To initiate CPR, the user issues a migrate command to old QEMU,
>>>> +adding a second migration channel of type ``cpr`` in the channels
>>>> +argument.  Old QEMU stops the VM, saves state to the migration
>>>> +channels, and enters the postmigrate state.  Execution resumes in
>>>> +new QEMU.
>>>> +
>>>> +New QEMU reads the CPR channel before opening a monitor, hence
>>>> +the CPR channel cannot be specified in the list of channels for a
>>>> +migrate-incoming command.  It may only be specified on the command
>>>> +line.
>>>> +
>>>> +Usage
>>>> +^^^^^
>>>> +
>>>> +Memory backend objects must have the ``share=on`` attribute.
>>>> +
>>>> +The VM must be started with the ``-machine aux-ram-share=on``
>>>> +option.  This causes implicit RAM blocks (those not described by
>>>> +a memory-backend object) to be allocated by mmap'ing a memfd.
>>>> +Examples include VGA and ROM.
>>>> +
>>>> +Outgoing:
>>>> +  * Set the migration mode parameter to ``cpr-transfer``.
>>>> +  * Issue the ``migrate`` command, containing a main channel and
>>>> +    a cpr channel.
>>>> +
>>>> +Incoming:
>>>> +  * Start new QEMU with two ``-incoming`` options.
>>>> +  * If the VM was running when the outgoing ``migrate`` command was
>>>> +    issued, then QEMU automatically resumes VM execution.
>>>> +
>>>> +Caveats
>>>> +^^^^^^^
>>>> +
>>>> +cpr-transfer mode may not be used with postcopy, background-snapshot,
>>>> +or COLO.
>>>> +
>>>> +memory-backend-epc is not supported.
>>>> +
>>>> +The main incoming migration channel address cannot be a file type.
>>>> +
>>>> +If the main incoming channel address is an inet socket, then the port
>>>> +cannot be 0 (meaning dynamically choose a port).
>>>> +
>>>> +When using ``-incoming defer``, you must issue the migrate command to
>>>> +old QEMU before issuing any monitor commands to new QEMU, because new
>>>> +QEMU blocks waiting to read from the cpr channel before starting its
>>>> +monitor, and old QEMU does not write to the channel until the migrate
>>>> +command is issued.  However, new QEMU does not open and read the
>>>> +main migration channel until you issue the migrate incoming command.
>>>> +
>>>> +Example 1: incoming channel
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> +In these examples, we simply restart the same version of QEMU, but
>>>> +in a real scenario one would start new QEMU on the incoming side.
>>>> +Note that new QEMU does not print the monitor prompt until old QEMU
>>>> +has issued the migrate command.  The outgoing side uses QMP because
>>>> +HMP cannot specify a CPR channel.  Some QMP responses are omitted for
>>>> +brevity.
>>>> +
>>>> +::
>>>> +
>>>> +  Outgoing:                             Incoming:
>>>> +
>>>> +  # qemu-kvm -qmp stdio
>>>> +  -object memory-backend-file,id=ram0,size=4G,
>>>> +  mem-path=/dev/shm/ram0,share=on -m 4G
>>>> +  -machine aux-ram-share=on
>>>> +  ...
>>>> +                                        # qemu-kvm -monitor stdio
>>>> +                                        -incoming tcp:0:44444
>>>> +                                        -incoming '{"channel-type": "cpr",
>>>> +                                          "addr": { "transport": "socket",
>>>> +                                          "type": "unix", "path": "cpr.sock"}}'
>>>> +                                        ...
>>>
>>> I'm attempting this and not having much success. Surely I'm missing
>>> something:
>>>
>>>
>>> $ qemu-system-x86_64 -cpu host -smp 16 -machine pc,accel=kvm \
>>>     -drive id=drive0,if=none,format=qcow2,file=img.qcow2 \
>>>     -device virtio-blk-pci,id=image1,drive=drive0,bootindex=0 \
>>>     -qmp unix:./dst-qmp.sock,server,wait=off \
>>>     -nographic -serial mon:stdio \
>>>     -object memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on \
>>>     -m 4G -machine aux-ram-share=on \
>>>
>>>     -incoming tcp:0:44444 \
>>>     -incoming '{"channel-type": "cpr", "addr": { "transport": "socket", "type": "unix", "path": "cpr.sock"}}' \
>>>
>>>     -trace loadvm_* -trace cpr_* -trace migration_* -trace migrate_* -trace qemu_loadvm_*
>>>
>>> cpr_transfer_input cpr.sock
>>> cpr_state_load cpr-transfer mode
>>> cpr_find_fd pc.bios, id 0 returns 15
>>> cpr_find_fd pc.rom, id 0 returns 14
>>> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 13
>>> cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns 12
>>> cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns 11
>>> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 10
>>> cpr_find_fd /rom@etc/table-loader, id 0 returns 8
>>> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 3
>>> migrate_set_state new state setup
>>> migration_socket_incoming_accepted
>>> migration_set_incoming_channel ioc=0x564dc31e7000 ioctype=qio-channel-socket
>>> migrate_set_state new state active
>>> loadvm_state_setup
>>> qemu_loadvm_state_section 1
>>> qemu_loadvm_state_section_startfull 2(ram) 0 4
>>> qemu_loadvm_state_section 3
>>> qemu_loadvm_state_section_partend 2
>>> qemu_loadvm_state_section 4
>>> qemu_loadvm_state_section_startfull 0(timer) 0 2
>>> qemu_loadvm_state_section 4
>>> qemu_loadvm_state_section_startfull 1(slirp) 0 4
>>> qemu_loadvm_state_section 4
>>> qemu_loadvm_state_section_startfull 4(cpu_common) 0 1
>>> qemu_loadvm_state_section 4
>>> qemu_loadvm_state_section_startfull 5(cpu) 0 12
>>> qemu_loadvm_state_section 4
>>> qemu_loadvm_state_section_startfull 6(kvm-tpr-opt) 0 1
>>> qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
>>> qemu_loadvm_state_post_main -1
>>> migrate_set_state new state failed
>>> migrate_error error=load of migration failed: Operation not permitted
>>> loadvm_state_cleanup
>>> qemu-system-x86_64: load of migration failed: Operation not permitted
>>
>> Check for a mismatch between the qemu args on the source vs dest.
>> Maybe -cpu.
> 
> No.. they're the same:
> 
> qemu-system-x86_64 -display none -cpu host -smp 4 -machine pc,accel=kvm
> -object
> memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m
> 4G -machine aux-ram-share=on -qmp stdio
> 
> qemu-system-x86_64 -display none -cpu host -smp 4 -machine pc,accel=kvm
> -object
> memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m
> 4G -machine aux-ram-share=on -incoming tcp:0:44444 -incoming
> '{"channel-type": "cpr", "addr": { "transport": "socket", "type":
> "unix", "path": "cpr.sock"}}' -monitor stdio
> 
> 
> Here's the whole log, see if you spot something:
> 
> $ (sleep 5; echo "{ 'execute': 'qmp_capabilities' }
>                   { 'execute': 'migrate-set-parameters','arguments':{ 'mode': 'cpr-transfer' } }
>                   { 'execute': 'migrate', 'arguments': \
>                     { 'channels': [ \
>                       {'channel-type': 'main', 'addr': { 'transport': 'socket', 'type': 'inet', \
>                                        'host': '0', 'port': '44444' }}, \
>                       {'channel-type': 'cpr', 'addr': { 'transport': 'socket', 'type': 'unix', \
>                                        'path': 'cpr.sock' }} \
>                     ]} \
>                   }") | /home/fabiano/qemu-system-x86_64 -display none
>                   -cpu host -smp 4 -machine pc,accel=kvm -qmp stdio
>                   -object
>                   memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on
>                   -m 4G -machine aux-ram-share=on -trace cpr_* -trace
>                   migration_* -trace migrate_* -trace qemu_savevm_*
>                   -trace savevm_*
> 
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9}, "package": "v9.2.0-987-gfd4129a8b9"}, "capabilities": ["oob"]}}
> cpr_find_fd pc.bios, id 0 returns -1
> cpr_save_fd pc.bios, id 0, fd 22
> cpr_find_fd pc.rom, id 0 returns -1
> cpr_save_fd pc.rom, id 0, fd 23
> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns -1
> cpr_save_fd 0000:00:02.0/vga.vram, id 0, fd 24
> cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns -1
> cpr_save_fd 0000:00:02.0/vga.rom, id 0, fd 26
> cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns -1
> cpr_save_fd 0000:00:03.0/e1000.rom, id 0, fd 27
> cpr_find_fd /rom@etc/acpi/tables, id 0 returns -1
> cpr_save_fd /rom@etc/acpi/tables, id 0, fd 28
> cpr_find_fd /rom@etc/table-loader, id 0 returns -1
> cpr_save_fd /rom@etc/table-loader, id 0, fd 29
> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns -1
> cpr_save_fd /rom@etc/acpi/rsdp, id 0, fd 30
> migration_block_activation active-skipped
> {"return": {}}
> {"return": {}}
> migrate_set_state new state setup
> cpr_state_save cpr-transfer mode
> cpr_transfer_output cpr.sock
> {"return": {}}
> migration_socket_outgoing_connected hostname=0
> migration_set_outgoing_channel ioc=0x55748ba10270 ioctype=qio-channel-socket hostname=0 err=(nil)
> {"timestamp": {"seconds": 1737127025, "microseconds": 606998}, "event": "STOP"}
> migration_completion_vm_stop ret 0
> migration_transferred_bytes qemu_file 224 multifd 0 RDMA 0
> savevm_state_header
> savevm_state_setup
> migration_bitmap_sync_start
> migration_bitmap_sync_end dirty_pages 0
> migrate_set_state new state active
> migration_thread_setup_complete
> migration_transferred_bytes qemu_file 506 multifd 0 RDMA 0
> migrate_pending_estimate estimate pending size 0 (pre = 0 post=0)
> migration_thread_low_pending 0
> migrate_set_state new state device
> migration_block_activation inactive
> migration_precopy_complete
> savevm_section_start ram, section_id 2
> migration_bitmap_sync_start
> migration_bitmap_sync_end dirty_pages 0
> savevm_section_end ram, section_id 2 -> 0
> savevm_section_start timer, section_id 0
> savevm_section_end timer, section_id 0 -> 0
> savevm_section_start slirp, section_id 1
> savevm_section_end slirp, section_id 1 -> 0
> savevm_section_start cpu_common, section_id 4
> savevm_section_end cpu_common, section_id 4 -> 0
> savevm_section_start cpu, section_id 5
> savevm_section_end cpu, section_id 5 -> 0
> savevm_section_start kvm-tpr-opt, section_id 6
> savevm_section_end kvm-tpr-opt, section_id 6 -> 0
> savevm_section_start apic, section_id 7
> savevm_section_end apic, section_id 7 -> 0
> savevm_section_start cpu_common, section_id 8
> savevm_section_end cpu_common, section_id 8 -> 0
> savevm_section_start cpu, section_id 9
> savevm_section_end cpu, section_id 9 -> 0
> savevm_section_start apic, section_id 10
> savevm_section_end apic, section_id 10 -> 0
> savevm_section_start cpu_common, section_id 11
> savevm_section_end cpu_common, section_id 11 -> 0
> savevm_section_start cpu, section_id 12
> savevm_section_end cpu, section_id 12 -> 0
> savevm_section_start apic, section_id 13
> savevm_section_end apic, section_id 13 -> 0
> savevm_section_start cpu_common, section_id 14
> savevm_section_end cpu_common, section_id 14 -> 0
> savevm_section_start cpu, section_id 15
> savevm_section_end cpu, section_id 15 -> 0
> savevm_section_start apic, section_id 16
> savevm_section_end apic, section_id 16 -> 0
> savevm_section_start kvmclock, section_id 17
> savevm_section_end kvmclock, section_id 17 -> 0
> savevm_section_start 0000:00:00.0/I440FX, section_id 18
> savevm_section_end 0000:00:00.0/I440FX, section_id 18 -> 0
> savevm_section_start PCIHost, section_id 19
> savevm_section_end PCIHost, section_id 19 -> 0
> savevm_section_start PCIBUS, section_id 20
> savevm_section_end PCIBUS, section_id 20 -> 0
> savevm_section_start fw_cfg, section_id 21
> savevm_section_end fw_cfg, section_id 21 -> 0
> savevm_section_start dma, section_id 22
> savevm_section_end dma, section_id 22 -> 0
> savevm_section_start dma, section_id 23
> savevm_section_end dma, section_id 23 -> 0
> savevm_section_start mc146818rtc, section_id 24
> savevm_section_end mc146818rtc, section_id 24 -> 0
> savevm_section_start 0000:00:01.1/ide, section_id 25
> savevm_section_end 0000:00:01.1/ide, section_id 25 -> 0
> savevm_section_start i2c_bus, section_id 26
> savevm_section_end i2c_bus, section_id 26 -> 0
> savevm_section_start 0000:00:01.3/piix4_pm, section_id 27
> savevm_section_end 0000:00:01.3/piix4_pm, section_id 27 -> 0
> savevm_section_start 0000:00:01.0/PIIX3, section_id 28
> savevm_section_end 0000:00:01.0/PIIX3, section_id 28 -> 0
> savevm_section_start i8259, section_id 29
> savevm_section_end i8259, section_id 29 -> 0
> savevm_section_start i8259, section_id 30
> savevm_section_end i8259, section_id 30 -> 0
> savevm_section_start ioapic, section_id 31
> savevm_section_end ioapic, section_id 31 -> 0
> savevm_section_start 0000:00:02.0/vga, section_id 32
> savevm_section_end 0000:00:02.0/vga, section_id 32 -> 0
> savevm_section_start hpet, section_id 33
> savevm_section_end hpet, section_id 33 -> 0
> savevm_section_start i8254, section_id 34
> savevm_section_end i8254, section_id 34 -> 0
> savevm_section_start pcspk, section_id 35
> savevm_section_end pcspk, section_id 35 -> 0
> savevm_section_start serial, section_id 36
> savevm_section_end serial, section_id 36 -> 0
> savevm_section_start parallel_isa, section_id 37
> savevm_section_end parallel_isa, section_id 37 -> 0
> savevm_section_start fdc, section_id 38
> savevm_section_end fdc, section_id 38 -> 0
> savevm_section_start ps2kbd, section_id 39
> savevm_section_end ps2kbd, section_id 39 -> 0
> savevm_section_start ps2mouse, section_id 40
> savevm_section_end ps2mouse, section_id 40 -> 0
> savevm_section_start pckbd, section_id 41
> savevm_section_end pckbd, section_id 41 -> 0
> savevm_section_start vmmouse, section_id 42
> savevm_section_end vmmouse, section_id 42 -> 0
> savevm_section_start port92, section_id 43
> savevm_section_end port92, section_id 43 -> 0
> savevm_section_start 0000:00:03.0/e1000, section_id 44
> savevm_section_end 0000:00:03.0/e1000, section_id 44 -> 0
> savevm_section_skip smbus-eeprom, section_id 45
> savevm_section_skip smbus-eeprom, section_id 46
> savevm_section_skip smbus-eeprom, section_id 47
> savevm_section_skip smbus-eeprom, section_id 48
> savevm_section_skip smbus-eeprom, section_id 49
> savevm_section_skip smbus-eeprom, section_id 50
> savevm_section_skip smbus-eeprom, section_id 51
> savevm_section_skip smbus-eeprom, section_id 52
> savevm_section_start acpi_build, section_id 53
> savevm_section_end acpi_build, section_id 53 -> 0
> savevm_section_start globalstate, section_id 54
> migrate_global_state_pre_save saved state: running
> savevm_section_end globalstate, section_id 54 -> 0
> migrate_error error=Unable to write to socket: Connection reset by peer
> migrate_set_state new state failed
> migration_thread_after_loop
> migration_block_activation active
> {"timestamp": {"seconds": 1737127025, "microseconds": 625404}, "event": "RESUME"}
> migrate_fd_cleanup
> savevm_state_cleanup
> qemu-system-x86_64: Unable to write to socket: Connection reset by peer
> 
> 
> $ /home/fabiano/qemu-system-x86_64 -display none -cpu host -smp 4
> -machine pc,accel=kvm -object
> memory-backend-file,id=ram0,size=4G,mem-path=/dev/shm/ram0,share=on -m
> 4G -machine aux-ram-share=on -incoming tcp:0:44444 -incoming
> '{"channel-type": "cpr", "addr": { "transport": "socket", "type":
> "unix", "path": "cpr.sock"}}' -trace loadvm_* -trace cpr_* -trace
> migration_* -trace migrate_* -monitor stdio
> 
> cpr_transfer_input cpr.sock
> cpr_state_load cpr-transfer mode
> QEMU 9.2.50 monitor - type 'help' for more information
> cpr_find_fd pc.bios, id 0 returns 15
> cpr_find_fd pc.rom, id 0 returns 14
> cpr_find_fd 0000:00:02.0/vga.vram, id 0 returns 13
> cpr_find_fd 0000:00:02.0/vga.rom, id 0 returns 12
> cpr_find_fd 0000:00:03.0/e1000.rom, id 0 returns 11
> cpr_find_fd /rom@etc/acpi/tables, id 0 returns 10
> cpr_find_fd /rom@etc/table-loader, id 0 returns 8
> cpr_find_fd /rom@etc/acpi/rsdp, id 0 returns 3
> migrate_set_state new state setup
> (qemu) migration_socket_incoming_accepted
> migration_set_incoming_channel ioc=0x5565cccb8e70 ioctype=qio-channel-socket
> migrate_set_state new state active
> loadvm_state_setup
> qemu-system-x86_64: error while loading state for instance 0x0 of device 'kvm-tpr-opt'
> migrate_set_state new state failed
> migrate_error error=load of migration failed: Operation not permitted
> loadvm_state_cleanup
> qemu-system-x86_64: load of migration failed: Operation not permitted

Thank-you for the simple example.  I reproduced the failure.
To fix, add "-machine aux-ram-share=on -machine memory-backend=ram0"
(The previous longer example had the former but lacked the latter).
Without that, the volatile pc.ram region is still in the mix.

I have a patch that adds a blocker if volatile ram is present, and would
have clearly diagnosed this problem.  I will submit it now.

- Steve


