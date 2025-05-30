Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11598C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 14:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL0tO-0003bt-HT; Fri, 30 May 2025 10:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uL0tM-0003bb-WA
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:39:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uL0tK-0006q0-DM
 for qemu-devel@nongnu.org; Fri, 30 May 2025 10:39:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UAt0IA015496;
 Fri, 30 May 2025 14:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=FPzKHHMuFjYiy39OLCe67Bz56u9yQoJUHFIazb87UOI=; b=
 etUKpfqlkXfsbA+51JvXhwSHcF8WWx1QXf9bTLNNCktXzzQLGKJ4VySDW2BZZ2Dd
 QuT/9oe/cEtYO6U0wGNrTJtXJxUx9ZSA5K6Eq/NLZe6gR5+amHz/kcsBzxnz33YG
 icJvIJTJugw/EEE214EaV1LBCmroTw5NBSux8jlulOfZ16GwCNCfVZLx4X2nMpSw
 /29j09TZFWUbUbrk2cz3+lHv/Q9kjk8NbaF55+wqwUT1lI1Do5F+wM+O1EGxeF6B
 LXIVsiuE0euWjSfKdmf8tc17Ej2d78siMIouva3d592loUhDkVpUKk0mlxYtWSu9
 qgtOIBdczriKXMAcA+eA7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v46u2dxn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 May 2025 14:39:14 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54UDDatb020363; Fri, 30 May 2025 14:39:14 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013052.outbound.protection.outlook.com
 [40.93.201.52])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jd4485-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 May 2025 14:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5jWeQf4vnubSf5ndBl8yQy/ZfIzKb3IjPdp3/sUyVqrCCgYR3Vcui0DfwCJxagAw+i2U6ureFu9kGBKU6ivafSCEYM1D40rUZCac/3oopAFWApy0hbpUEocEFjCxobpj32M7cY7+xcE9NJlPNW7K1FEAWZ315WUx72GIpiYRzJCgQvSP2OieSdKbjFsapgEWCgpKFwDvAwCA8qSK1/x5a3B4ykzPaHoIcOmQ5//JX5//LPLVq8HcAmhRYuXG+fkfDmyR0sxIG7iPHQUvBJwj4VEE16GLHo0kN14hkfadoDDi0yIZgHrj7qCTAjrQAnFFhXSAEk1Et6vTnIjTQ1Gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPzKHHMuFjYiy39OLCe67Bz56u9yQoJUHFIazb87UOI=;
 b=PZsQur3w9+MJYmIRYW12hQutxQd12DKsms7lHo14D3mGZN4azQmJs8TKc5pikwgF3U/3R2Ybg8Q56nj5R8nkMlVUgVaF97kC/z6L5R35fDoTZH9GdPoX9pX/1FOsi+UA67WF1XQQvh9AQ6GlvsLGIlhnbShmXcoGaWosd74d/bD0HROIUixOQLnAc7AfRsdJRN+c+BcXg+hMst2eJBLLibNeegzSwJ/Rl/CpXnz0WKxJiTF/iEGcW+puyrLKBfz13dGNAIYltk1N0GAcnnjlAJu64M5f59xiZ6wVY6d1yjxUefUfHo9x/n1YaURixn/R9HUGBQpGp5K2dUj2OsYcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPzKHHMuFjYiy39OLCe67Bz56u9yQoJUHFIazb87UOI=;
 b=QpriboCFoqyivgU+GnqM/I7MQiDt7W+krz4tY/KZyXaf5eh+x/EimxEBbU6g/oMOFoSpmmFxmV2oMW9D+L9lnaubsqAt8IoK3G0+Y9hEqM2st2TzV06/watvf8Y+U2T0GLRBUK6mUsN2XW4/G9sNt51M2vpBKlXe19kmo0dd+qU=
Received: from DS7PR10MB5280.namprd10.prod.outlook.com (2603:10b6:5:3a7::5) by
 SA1PR10MB6319.namprd10.prod.outlook.com (2603:10b6:806:252::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Fri, 30 May
 2025 14:39:10 +0000
Received: from DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da]) by DS7PR10MB5280.namprd10.prod.outlook.com
 ([fe80::da22:796e:d798:14da%3]) with mapi id 15.20.8746.035; Fri, 30 May 2025
 14:39:10 +0000
Message-ID: <9942f812-496d-4f9e-ba92-abe6bd6ef9db@oracle.com>
Date: Fri, 30 May 2025 10:39:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] AMD vIOMMU: DMA remapping support for VFIO
 devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, santosh.shukla@amd.com,
 sarunkod@amd.com, Wei.Huang2@amd.com, clement.mathieu--drif@eviden.com,
 ethan.milon@eviden.com, joao.m.martins@oracle.com,
 boris.ostrovsky@oracle.com
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250530074128-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20250530074128-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:a03:333::18) To DS7PR10MB5280.namprd10.prod.outlook.com
 (2603:10b6:5:3a7::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5280:EE_|SA1PR10MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 157d38db-487f-4d49-03f1-08dd9f87bd08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTRxc1BZcEFsTWFkc0RUTVh2NHVTeVBEVzhWRTFzY1FFaGRwM0FtYThWdHFY?=
 =?utf-8?B?M0NFUng4b3ZVbDRQcjdBMi9hUWVLQVlJY1FxblZEQjRCSEJDeFBsQ0FRUWJJ?=
 =?utf-8?B?a0M1anI3anZ5b0ZxZFNWRWdtUnFpRGVuMkhnRWRjcHFBd1kwUlpPNlk2VlAx?=
 =?utf-8?B?clpBZHB1RWFVNWhqNEJpeUFHN0tOcTJjMzZjMVA3MHBmR3REUC90cC9tZWhI?=
 =?utf-8?B?YkRtOThXd3l4c01SZ1JKNlovTWhyNzFIZkN1aHFqK2JETS8wY0JWUXJXdEVD?=
 =?utf-8?B?alN5dTA2Qml0OU5LcUtIUmJGYWJiblZ5dXovSUxua1NWR0NBMmh3U0JRaS9R?=
 =?utf-8?B?ZHVSM2JaWHdYOEh3QXpXWC9DcnpURWVyaU9meXIvVmlpVW5BQ0g5aVpzSzZR?=
 =?utf-8?B?S3ZSMUN0RUNHaDZ5cnZuOExYa2VpMUt2dlZWajlhMm9HZlJIdG9aWFlVTXlX?=
 =?utf-8?B?V1NHdWZ6ZloxSS80Z1FlSEloZjZGTzNNaGdHWitDMmFicjZSajRFSDdjdlRT?=
 =?utf-8?B?VVFjSDRyK1RlS2NyT2xQWTFLZG1zcDAwSkJWdjF2ck51NzI2SEp4cE5mMFRL?=
 =?utf-8?B?N1J6dUtkbDFJcEpleHFqQ3JMM1diMXBZMlBPSXZVTytzMnJzWEhhNWY2VXA0?=
 =?utf-8?B?MkpaTXNFelZsRG1wc0I5ejB2ejBCMlQ5UXYycmY4d3JaMC85YXhRODhpOVEz?=
 =?utf-8?B?MEoxVHVaUlNtREJUY0pUYkxUWDlhYmVjU0xML0xiTzFvTGRoWCtPZHBOdXVs?=
 =?utf-8?B?NitSUmppclJGcFo5WFRHZk4yVmkzcldNUnk1V1BKRjRmN3dkbEl3dlJHS1RX?=
 =?utf-8?B?WU1NQUZIT1Q4NVRDaDcxWmtUVnBTanNaRDJyNFA4clZTQTNkMVJ3ZDZQOXZP?=
 =?utf-8?B?MmJFUmFsUGowNTVkckxXbW9LZ0x3anRtd09ObVRBNit2aytmY01pUnJRWFpt?=
 =?utf-8?B?RjFHcFlPQTBNbDcxOVNMa0NJVWo0blpGVEV4YVZCT1I4aGNpRm5HT1IxUDh6?=
 =?utf-8?B?c21CRmI2aXMrakMwTDB1aVh3VGpsekIrMmtWNllaSmtJQjQwZ2VPQmVNYlV3?=
 =?utf-8?B?WDhKckVoVDYweGRLRkdZMGRoamJITzBmSlFJbGQ2YUMyN1JGUmRLM2FZblV0?=
 =?utf-8?B?czVHeTk2OUgwTFJvcmZRODlBMGFRNy9ENU9YRG5KZTl0TFhVOVptVS84ekhY?=
 =?utf-8?B?UWwzMVQzMUEzTmFacTluckVLZVNYaGNKdnAzNStza0lwdnBFWGZmWmhNZE1t?=
 =?utf-8?B?dms0WFNrNzBGUS94NEFRTjBrdEw0bkdQTkxBTVd2R1VJNFJxbTdDRUlmdlJq?=
 =?utf-8?B?OWYrUHUwVW12b3ZiVlBUOGtMMmlYcnAxV2NMRGh1OHJLZmFVcFFvRGN0c2VW?=
 =?utf-8?B?SE1vSitlc2dTSlV3Uk5OVElKOU5uQ1lqd0tYZHZkUmRFMVhsM1o3U0c1Q1k5?=
 =?utf-8?B?RDU5dndPUjk3MjY0Zm5WcXFselI4a3ErQkF4QkJMR01zWUxwKzloSis2S1p2?=
 =?utf-8?B?RERJWVhOWFNvaE1VeU5kNE5mTllRQ0ptQWZHTGJzUFBUMTFzWVBXYlVRYVp2?=
 =?utf-8?B?YStjemVCVUFzQmovUjVMUjRqcGEzTG1MdlAwMTVqQ2J3emNDZi9VUG04dmJj?=
 =?utf-8?B?UjZTeVRkKzlsMmw3dHJGUlVRdXNoZ3UyY1VTdXk1V2czcHhTejJaRzVtcENZ?=
 =?utf-8?B?OUpXczBORFIrK1d0bThkZHhld1ptVDltL0s0a09ZOTh1d0dFZ0FlanJYSlE5?=
 =?utf-8?B?THhIT25aNVdyRlpyVGU4SUpoZ0Q5dHVGNHRLSmhwbHdOemJOTkpyS01ESXV2?=
 =?utf-8?B?VnhncnhzOUxrWmJ0V21KYnFPNFBxcUVxangvWkUvd25xV0dIbEVCckpxMGx0?=
 =?utf-8?B?a3VEZXZOdndOYVljcFR1elpEU3hNWkRLTC9xOVd3ZmpqcHFHWW1DREJxRFRz?=
 =?utf-8?Q?KLXNSE6ej/Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB5280.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2pxRG5XdkFMdW45SEFraUF3U2x3U094YmZBU1pROWxyaXYvUHZJNVdYQWNt?=
 =?utf-8?B?aVBNUGltL29FSEZpSVB5TjFTQlJ2clhQcFIwbEFlK1F2TU9jVGhidERDeC9o?=
 =?utf-8?B?YzFEWlpWa3lIYkpBRTdUclBTQTd6aWxsNjEraGh5SUlZYVN3bG93UXRSNGox?=
 =?utf-8?B?eEFBeCtJSVlJRmhFbjY2MmZWbFU2cGg2a0E2U3p5ZklxZlRBZU1LU093dGRW?=
 =?utf-8?B?TXhiUE45WGJXTDdSQzA3cnJkMzBQWFROUk02NHJvZmxxME1nQ05PN1FjYjRE?=
 =?utf-8?B?SjNMSThGUEptNFArdDNPODUybVJMKzVIempQL1NVbVU3MFVEd010NlVPdGVz?=
 =?utf-8?B?NmdsTW5DKzQxN2VQU0ROc1N2bFpoejZtVFcyZE55bmlGSWkrVmwzRTRQL0xr?=
 =?utf-8?B?c01lRiszTGJDUzdzUkxKeVRmaTVMSzRZb25pUlZZczBDRnQ3a284dXE4Z1dq?=
 =?utf-8?B?OVF1RTY2SWI3Ky9wazNUOEhrdHJRaWpkRUlKTHl3eFRIc080R0xTOUF5amZw?=
 =?utf-8?B?SFNxTDl0RUc0M0swRm51NEp4MlhiWTk5dytMVzBXMEJmV2phSm5GQ0lCUGRv?=
 =?utf-8?B?UkU0NkV6K1VsZlVZVmJtbks4WExYdUdVRkZzV2UyOHpNY2xSTVNaRVdaQ245?=
 =?utf-8?B?WFlham9oQmI1RWhnVmcxQzZkb3VTNi9qZHRJcGFYT0xXaVpuTTdaWDhuVmhV?=
 =?utf-8?B?YUo0SDJFMUptejBvTVpDL1k2KzE0ZXp3b0ZDUnhyRmR2M1UrMW9Hd2lsVm9o?=
 =?utf-8?B?U2U0aS9pOFRpQ2hMOHd3ZHU4QlkvWlVRanlMOHRwbnVCWHVsam04cnI3TDhh?=
 =?utf-8?B?MUlYMXA2OTdTNldKcG1KNitxZTZ1eXJtOFVFb0poK0ZCZFdoTWQyMjZCMFZ1?=
 =?utf-8?B?aDR6SkVtTzE3bkNQK0NDZkwyOEdJOGRwNnZIUEZTeFd4R3oybzQxT1ZoWWRk?=
 =?utf-8?B?aVZvY2FmU0IwL2hQdGUxT3BOOHhWTzc1cHF2cE53MVdXR2ZKV0FpOXhFN01i?=
 =?utf-8?B?R09iUzd2SXJVNk54UDZjSTU4REtjS2srZlpkUVBCYUNIK0k0enlQV2kxbzgr?=
 =?utf-8?B?TU1NODBRRTRQQ1MwTW5jbTdlUEgrMmhDK0x3Z2h0MWRuaGlNMkZsQWFkQWFU?=
 =?utf-8?B?eXJnUjFra01FRCtWNU1td1d6NktNbTd4bUdTQTBoUW9LTHY0cGNuSUhXNkxB?=
 =?utf-8?B?MFpiblhpRjVSc2hCTk1aTDYwc05zQ3IxVG9NTXZYNWNNLy8zai9JWlYxTU5a?=
 =?utf-8?B?SlNOZXB6V0R5LzNqSGd0VlkvT1JNck9WU0NweEt3VEFrZmdFNGZEelZ6a3NK?=
 =?utf-8?B?SmZzMlZxQVJ1cjZLWjJqK0FsUWx3Q2NzSk1jZ1VyQ0J4OW9pa29HZEl1bi9K?=
 =?utf-8?B?c25QcmtNSDY3L2xxMzlJS0xTRG1PMGRpNTRlcmxFYlRHYTNEamVsUzFwUnlZ?=
 =?utf-8?B?MWxwQXdlb3liSWl3K3BMY0Z5dkI0VkFPMHNCa2dRbnQ1OUc0eUxFdUU3a0po?=
 =?utf-8?B?S3EyTU5DZEpKSjBSN2FkSFZRa1JkU3ErdmpGc1l3SzF2c3BOeStjQ1JiZExU?=
 =?utf-8?B?QXYxT3pTSWlHTFYvWHJGcHU1TTRQd29Ic01YUkRGcTVJUS8veHhkbGVtb3p6?=
 =?utf-8?B?aE4zaTRNS3NwYmNPSEoxQndZdDFaNE5GMG1iWlppemdsSFU3VTJPU25xYTVk?=
 =?utf-8?B?MVc2SUEwTnAxa3lPVjBPUm5vL2RyVm12MTlUd3VtM1dVbjhSWENENEpSbTFM?=
 =?utf-8?B?NVR3TVluMTdwWDBLd0hzVkRiRHFLMGhRNHNjV0ZWYzFqRTJONWsydFo1aXNN?=
 =?utf-8?B?bktvWlNYVlI2WVUwajFxV1Niak5hQ1cweUljVUV1eWhyVmdNeFEySUJCZnh4?=
 =?utf-8?B?UG5SNktsOGFQRHIzV1VsQzBSN2JQanJjdHN2RnAzV2tOZFJzanpuMzZwSjcz?=
 =?utf-8?B?L25ad2JMRTYrYllXWlA1YjJIUXNUZzE3SFc3enRyU1QvekM4M3VtbDZUR2Y2?=
 =?utf-8?B?VjBHeUNNTG5lMTlJTjlwZDNIbjcxS0xTODBYdERmZStvTFFEeTlPdVJUMDEx?=
 =?utf-8?B?bHc5QTNlZmRQbEh5TFQvNzdnQk5zY3dzZm8zNWorVXQvNXJXU0c5MlhWNE1B?=
 =?utf-8?B?Z1ppaDJjNlBSSzloQVQyUm9FVkNHcERmL3JOUko5djVVWDYzNzNoQzJpdTZt?=
 =?utf-8?B?emc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3n6Xj83HAvBzgFZr0Z8XDzED/GTT1+EM+2f3RGg/i5a/juFBE5nAGr0QMzmbI4qZ7GGVj+E7OuKi3fCsu20jAULlom4HCg1rzN/WC45PxBLJ45/giXE+sHgkJgCdGjyT1fygGsUOzoic92gTs75fJ2FIiOFQJVFtUnB8wwuHBR+dWIBoAcntDT7+lKwxERxSKGrqbV+JoMK9PSxb1h8iFja7QQKpfYVR3YK4YhfZIaWLlttohzTeGZubXEi3tyj1C1gpjCJWp1Jkr6oR1vaxQbN648pNOR/qV7ukqS9UFzV3FsN/ecvEyBikb9plzYEp+vidhBnSRcLqf1GKqa6PpDFue3sodk5vUHGIAfQeHcD9pOxUbcbWImtata1L2wqmcYzsvZ5WUWNzeFfRkGhnsbGUfEVeZa8cIaOy32GU0zrG/BRXdAsfBFZ8OOHH6IsJAFFda/azbuoETzV3MHATsszyJ/RTYYaANPRSWXZBneDaJ1XsKyCwaSMsOvLkTWG85JZlWLWTSgxjvR/QINXOvfDkFzyZQ/KGEWnSvF94PitN43bugcrbOw5IHDs/cLF9ThPYbCkASgRF6z7wBjMayCG2ZHiBg2/qPTrK562Zg18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 157d38db-487f-4d49-03f1-08dd9f87bd08
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5280.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 14:39:09.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jYweQ+xwUYBRyqaS6/HUclg2MfCuUzglX9CifFv11tJ2aHOumKwgwEAQnNE+laB3Ps9/XhXQE1i5xx1IJX5PPuXJEHGcnpRRmo1BeaOpsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6319
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_06,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505300129
X-Proofpoint-GUID: GR4e-_0_1epOLdzarEUMdOp3z-bwAEDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDEyOSBTYWx0ZWRfXyCDiv6er367r
 lUsYVhVkJuoV26DzV7WOInspVnNTYA+wxYiRepinAXIiFEXRV0JHCwQBMx3ALMb9JuYHnHUTHd4
 R9vWOADtRMQ8szgYa3J5se0enRknWVnGLe33XJWBieISl5OJs7iJzd4FhiguZY8ckFHfqvWcuIv
 /E8gnt12DkZw4y4H08+jt7iVQ5A3ramdQjllnloub/tn7/FwgKG8g3liwMMWNJw0Ej8Wn8qigBU
 RediVa9th70ye5QzUP3/mGGUMUoVg7rGoog6qj0AsWaXIq73jZiVfAa6NkTW2LO8ay86tJ3Kejb
 s1RXnZVcRGf+Wn+S5Ln1uNDJifFmyV9HgctA1q4Rut2PWGOn6Vx8rsUA2gwLqoKgvVc315ROMYC
 sRiiuBzZFY8kkS4Gg8S+68TtZfYyJKHgAR4Aw45+drssxqD6gmc6gHfSlVf3P7bP48oapAex
X-Authority-Analysis: v=2.4 cv=VskjA/2n c=1 sm=1 tr=0 ts=6839c312 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8
 a=yPCof4ZbAAAA:8 a=VrpNjyLPOt3-gQcFioUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GR4e-_0_1epOLdzarEUMdOp3z-bwAEDv
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 5/30/25 7:41 AM, Michael S. Tsirkin wrote:
> On Fri, May 02, 2025 at 02:15:45AM +0000, Alejandro Jimenez wrote:
>> This series adds support for guests using the AMD vIOMMU to enable DMA
>> remapping for VFIO devices. In addition to the currently supported
>> passthrough (PT) mode, guest kernels are now able to to provide DMA
>> address translation and access permission checking to VFs attached to
>> paging domains, using the AMD v1 I/O page table format.
>>
>> Please see v1[0] cover letter for additional details such as example
>> QEMU command line parameters used in testing.
> 
> are you working on v3?

Yes, there are suggestions from Sairaj that I will address on v3. I am 
also planning to include two small patches from Joao Martins that add 
support for the HATDis feature (this is something that Sairaj suggested 
earlier). The Linux changes are being reviewed here:
https://lore.kernel.org/all/cover.1746613368.git.Ankit.Soni@amd.com/

I will be offline from 6/2 to 6/6, so I didn't want to send a new 
revision and disappear. In general, the changes from v2->v3 are minor 
and well contained, so any reviews I receive for v2 will be valid.
That being said, I can send v3 today if you'd prefer that. Please let me 
know.

> there was a bug you wanted to fix.
>

I assume the bug is Sairaj's report of a dmesg warning with an NVME 
passthrough on a 4.15 kernel, but unfortunately I have not been able to 
reproduce that problem. We agreed that given the age of the kernel (and 
reports of the same warning on NVME devices in unrelated scenarios), 
this is likely a guest driver issue, and should not be a blocker.

More details:
I have tested an Ubuntu image with a 4.15 kernel, but I cannot hit any 
issues when I passthrough a CX-6 VF (I don't have access to NMVE VF). 
The kernel is old enough that I have to force bind the mlx5_core driver 
to the VF on the guest, but once I do the VF comes up with no errors and 
I can see DMA map/unmap activity in the traces.

Sairaj: Are you passing a full NVME device to the guest (i.e. a PF)? I 
ask because the BDF in '-device vfio-pci,host=0000:44:00.0' doesn't look 
like a typical VF...

Thank you,
Alejandro

>> Changes since v1[0]:
>> - Added documentation entry for '-device amd-iommu'
>> - Code movement with no functional changes to avoid use of forward
>>    declarations in later patches [Sairaj, mst]
>> - Moved addr_translation and dma-remap property to separate commits.
>>    The dma-remap feature is only available for users to enable after
>>    all required functionality is implemented [Sairaj]
>> - Explicit initialization of significant fields like addr_translation
>>    and notifier_flags [Sairaj]
>> - Fixed bug in decoding of invalidation size [Sairaj]
>> - Changed fetch_pte() to use an out parameter for pte, and be able to
>>    check for error conditions via negative return value [Clement]
>> - Removed UNMAP-only notifier optimization, leaving vhost support for
>>    later series [Sairaj]
>> - Fixed ordering between address space unmap and memory region activation
>>    on devtab invalidation [Sairaj]
>> - Fixed commit message with "V=1, TV=0" [Sairaj]
>> - Dropped patch removing the page_fault event. That area is better
>>    addressed in separate series.
>> - Independent testing by Sairaj (thank you!)
>>
>> Thank you,
>> Alejandro
>>
>> [0] https://lore.kernel.org/all/20250414020253.443831-1-alejandro.j.jimenez@oracle.com/
>>
>> Alejandro Jimenez (20):
>>    memory: Adjust event ranges to fit within notifier boundaries
>>    amd_iommu: Document '-device amd-iommu' common options
>>    amd_iommu: Reorder device and page table helpers
>>    amd_iommu: Helper to decode size of page invalidation command
>>    amd_iommu: Add helper function to extract the DTE
>>    amd_iommu: Return an error when unable to read PTE from guest memory
>>    amd_iommu: Add helpers to walk AMD v1 Page Table format
>>    amd_iommu: Add a page walker to sync shadow page tables on
>>      invalidation
>>    amd_iommu: Add basic structure to support IOMMU notifier updates
>>    amd_iommu: Sync shadow page tables on page invalidation
>>    amd_iommu: Use iova_tree records to determine large page size on UNMAP
>>    amd_iommu: Unmap all address spaces under the AMD IOMMU on reset
>>    amd_iommu: Add replay callback
>>    amd_iommu: Invalidate address translations on INVALIDATE_IOMMU_ALL
>>    amd_iommu: Toggle memory regions based on address translation mode
>>    amd_iommu: Set all address spaces to default translation mode on reset
>>    amd_iommu: Add dma-remap property to AMD vIOMMU device
>>    amd_iommu: Toggle address translation mode on devtab entry
>>      invalidation
>>    amd_iommu: Do not assume passthrough translation when DTE[TV]=0
>>    amd_iommu: Refactor amdvi_page_walk() to use common code for page walk
>>
>>   hw/i386/amd_iommu.c | 1005 ++++++++++++++++++++++++++++++++++++-------
>>   hw/i386/amd_iommu.h |   52 +++
>>   qemu-options.hx     |   23 +
>>   system/memory.c     |   10 +-
>>   4 files changed, 934 insertions(+), 156 deletions(-)
>>
>>
>> base-commit: 5134cf9b5d3aee4475fe7e1c1c11b093731073cf
>> -- 
>> 2.43.5
> 


