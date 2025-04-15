Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE08C369B2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 01:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4V2c-0001ur-Dq; Mon, 14 Apr 2025 21:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u4V2a-0001uI-Uy
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 21:24:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u4V2Y-0002lq-T4
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 21:24:44 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ELBuR6026100;
 Tue, 15 Apr 2025 01:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=N5RmkP1Adc3uJ1wMk4+9eqjUOaagb0kpCZtP9kc4Bsg=; b=
 BwxAwL63NPpZYuHp2Lc+rXiR2kwC3t68LWaWgWN/i4iAAPBbREXJRhFRy7LKcwPG
 HMocpKdK1A45SFCF8Q1y1LNJtYwtwafbhEjlwrp85EfD8lqVUhUmfacf0McJ1yz8
 NPYui9LinPtYAtP1oxZ0jkDJCoAQEnYLC+gRV2uB8BSh6qfDpkkclDA/sWXjPuVk
 HbWMJ+nIIYQYKI/t0XeNdpurz2tTqeg5Co85mLS6LS1dVTvunv9YDbA1OcBnUMQ3
 WawSNQgjmAXguhIK3Fb/GUEslexurnsUxJsmVPF8wkzTvvRB/ChX7REbyYgALivv
 7dyyIqQnfksDnbYk5SCpqw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619448bb0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 01:24:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53F0LIZv005685; Tue, 15 Apr 2025 01:24:32 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011030.outbound.protection.outlook.com [40.93.6.30])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d5ugdc2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 01:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkD0DqkSsvsRlP3mdhlTuASh30Fj+Ib83CE8qxv6CSJEvptyIRokD9PI8mak0s1KIZ3lrm6zFWKzhbIznxZAZqPQ1VRajCvWlK02Wy03WL6dSFfkaZMI5VuWMHiLpvP6n+QUQv5h/AeVuHgMprC907zMJ2fu3y8OY+n4WUzEuS+4obJdDcQipuOooVSS/F+riV+RywvYTEeOORHbBSGhSOkEFNsK2mK8Queh3U9m5P4WyDASlX3/fDniYM90xHBsdVc0TdN/8piDq6nYFJr+W4M8MTqoX3eGVzioxn5QqyH0SCP3WYSz89PYvPpFNyccmoj/idbFxnqt0+T6mHZsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5RmkP1Adc3uJ1wMk4+9eqjUOaagb0kpCZtP9kc4Bsg=;
 b=fkzNIfyuETLzDrWnakV71QahA7pUzZ20qqdbaX8YES1ip7zN3MvkyvgdNU8QR8LW9bhKaz2d1k9SG0Fb2aFbkrmUqOforRzf+/KFhboujkcUW/I7Mte/vX2dOtATVJhVXitfwqaoqiVmxTda6ituaCYQt3d6l/F3jNIWkn9F0sUAjAnV3JYVnVwFA+d+LH/MVu8gD3+fbHCLZs5/2w5GuqxlP3kOzP5LjrGo0ouJTlFt5CaTa+vQQiX12FWCA8CrpjJmofaCkGlXOUnbQ+1S8aqtgbcmYLyxDB/BMw6zG0Vb+WjjUTP/Z4zvMAeVcNTC5IcCvKCTrnGcxn0J7apAaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5RmkP1Adc3uJ1wMk4+9eqjUOaagb0kpCZtP9kc4Bsg=;
 b=AG4k4COuBkJfkDHyAjkA26ey28mxDzFoNX0F1Ac7YUVXEbQC70HcuYL/RlzZetvnLy/lhvxLbRZM9gNWIEOhAgIZGNK1ipMLzmtn7alhH/MnkaKJpRz01k9uo5nUnj42PcsO/yLGXVqRzFFpTMebGgKo0EaAT1ShmFU4v76bSIY=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 01:24:29 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:24:29 +0000
Message-ID: <5a567f2d-31d4-442c-b68c-ed85491d77d4@oracle.com>
Date: Mon, 14 Apr 2025 21:24:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 slp@redhat.com, eblake@redhat.com, armbru@redhat.com,
 miguel.luis@oracle.com, Gustavo Romero <gustavo.romero@linaro.org>
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com> <87cydeepp8.fsf@draig.linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <87cydeepp8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::17) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: e639c11f-8fe2-447b-0916-08dd7bbc4491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjNZRlZzK1JRSUUrNHJkUkdJZUtsekx6QlVEUUI1NHc4Zk9Jc2ZRdTlDUFN1?=
 =?utf-8?B?UDlRUnBSTFJZTkhJcUlnVk9GNVVDcVgybU15TFBlUlZKTmVtN2F6MmMwZ0g1?=
 =?utf-8?B?L3pTSmdLVnhyMjlZc3hyQThKR3NqNzFiR1NUMDBCTEVudm5xYjcwNFhxWGxF?=
 =?utf-8?B?SHBYeGNTYW9HamNKbWNicWhlTHEvdlhrTk9pZXhBblFaWW5EK25WTllYYU05?=
 =?utf-8?B?SGVSUG5WeXl1Q1ZTRk93T2lNZHpSVk5HTTI3U2dhcHlGRk5rcjJpUEtBZkRp?=
 =?utf-8?B?UWpMdktHcmYzcVJKZzR5YU13M0E3RmhPczZ1ZzBSaWxVWDdML3ltbjkxdktq?=
 =?utf-8?B?V2FlUjVYNVJCWDJ5amRtTGxWd1l4UmdvekhIaFNpWWxDSk5nWGk4WUkrblgz?=
 =?utf-8?B?NVcvS3FlNTZHVFBhZnpDVXV3S21oMHBjYjdsWHRXbHBDRG5pNWNHYnFxdjNZ?=
 =?utf-8?B?c1l5NEozeGRLYWFiSkFDSnBXK2tZOGVCSVIrZkxZbVBIMGZCbzVXTzdlejZ4?=
 =?utf-8?B?RmxoNUpzdDZJVGpFV25vS1E3aVZ0eXhtekRrdzRGd2c3VDlNT3NZWkJKSWZs?=
 =?utf-8?B?UncvRW9SdFV5ZTgyemtZZFRTd0pBVTNqQkpNaXVpcnFSSk1Ed0R2VE9KSU1h?=
 =?utf-8?B?WjBKRDNid1g3Y241b0F5UlVNREc4Y1VBU3JwUXo5WEl2QTlIam5TVk1MY0oz?=
 =?utf-8?B?Yjg0S3RTZElXTGpiYVNVc2JzSkhlZTM2YXZmNkk4Z2Npd3czMWlKSlJoM3Rl?=
 =?utf-8?B?RWd0MFVBeVpnQWlMWkFrTkRiS2ZlSjJtd2N4eittdUp6WFprOEg1Wm5NMEpE?=
 =?utf-8?B?MmtJN2RMZHNiWTd4WWxNWHc4ZjVIQkRVZWZnSjRTbHo2Tzk2c3p0dGJoc2M3?=
 =?utf-8?B?RXJzMTBSdjhOSXlyNGZUSXo2a04yTUdUYUVnYlNodUwyTVIwZ2Z0Yk5udS9z?=
 =?utf-8?B?VXU1bXNXSWMzQVNkOGZERGgrQWt6bXd3VDJZaVFlQ1NUaW1vUUYwbUl1WUhx?=
 =?utf-8?B?aExxTWd3OXpkOENrZ1paeHVlUGxHUEk4YmJmZXhVRVg1TFNXUk9aOUpqNUJt?=
 =?utf-8?B?S1BwZDhPd3RaTWZhTG0rbkhvb3o1cTFiSjNnU1VmOTBsV3hCRVUrRnlYVXA3?=
 =?utf-8?B?UDlpV1Fub2l3QlY2WEdUb0gzdG5xR0M2V3pjeW9JcnJTRm5FREEwQThxbjJw?=
 =?utf-8?B?ZDZIY2xEdSs4WElUSE40WmpoRXV6SXRuYXhWc1ZLZWRPMlBCbDR5NjF2VlVK?=
 =?utf-8?B?QnozZFdPSkMzZHJsYTJtWGJIck1aNDl3YjkrNnpwK045VEdUVkYrSUlsRDNh?=
 =?utf-8?B?cU0zSEJQR091OFZTV1Frcm5ZbVJCNmtnRUoxbEtiaEFPZGdjeHhGOGdQRHFE?=
 =?utf-8?B?RUt2bkl0U0FQWnd5Z2tFdFNsaExvTVptY1BOYXljZzhqcWNCZjR0R0JjRXVO?=
 =?utf-8?B?eTZVZnlzV1hTeHAxZVVXc3QvU0J4cVNhY0JhdzV3dUl1QVRhcWdST3Eza2tG?=
 =?utf-8?B?djZkcDkybGE2TnRTKzJmMmtaamRCbGRyTFpTYkdUZkxZVE1iVzJicnJQVHhN?=
 =?utf-8?B?VG5RbC9Vbi91bUZFMGhZMkJOaVVjQkMvb3FXd2g2YW9xbW9VZlQ3amIvZkJq?=
 =?utf-8?B?WFluTW56OE01M0NJRys4WHo2bVhKMkxrREJ0SnB5WDlSZEI1cXBXR0NrVmpD?=
 =?utf-8?B?dEJGQm8rRk1YcVFRYTRKdEFIblJTV0pPay94MFk2Z2R5bU1INjVsU21iblhH?=
 =?utf-8?B?OXFMQmxiT29rYy9JZzkxMGtRUStIeFNmZU41K1l5RHhOZEJmclJ0Z1FQclpR?=
 =?utf-8?B?NTZpZWx3WlJsSStwRVdJUnV0OCtRSmV5OGZQTnhNMEw0T3Z1Ulk2d2tFUWU2?=
 =?utf-8?B?SUthNmdMNUpJeU5Wem9URjJrSU82TmJNWkd1SnFCMkFHbEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk9ZbjdHQXc1TThndjljYmxOYkZVdFdWSGNTN041bGRPeURBdjhOS1VQTUtR?=
 =?utf-8?B?OUxaWUsrdG5BRjZNL3NHY0JnUEVhaVFkdXgvUkxJRElPaFQvdnM4WTh1QkNH?=
 =?utf-8?B?dXc1VVZ5Y0x2SWZLcnlyK2xTZXVVVlNzalREWjdKd3JOWnZWVnBWbnpHS280?=
 =?utf-8?B?OGZXYytYN1hWMEpBcEtoTHZyMzVhRmFlSXVlZXhkSURKblNzZG9tbmlEdy9T?=
 =?utf-8?B?a3Y1VEwxUll3dm1JQnk5d01xcWZlN1NyZTZUYUREejF3dUx6OElOcG9vc0Zp?=
 =?utf-8?B?ZWxwN09MdmtWZFp5RnpMNE1lSEROSUpZMCttTlFGQlkvaTF3aldRVjc3Q1BN?=
 =?utf-8?B?T0hHMGNzeVpUR2E4blJhYzRqWExYQjVhdGdMalQ1WWlvNnlUK205SmhybmF5?=
 =?utf-8?B?cnJ5NnR3OFZwTVZLQkFSRmk3anpZZURVRG5WeEFmRGloZWQra3dnTllFNDZz?=
 =?utf-8?B?S2RZalpoSGF3NytLUnoyaGZRVVlVVm42UjV2dFk2eU1RNTNEdU4wclROU1p3?=
 =?utf-8?B?ZlU5aTU1Uk5kamxRMFV5Yks1NlJta2l3Y2syNFpPak83SVJUZ3N2S3paM0Zs?=
 =?utf-8?B?TUxTdkQ3RkszTWF1VURQeEF5LzNjWncxL2M0dk9IbS9IVFp1TzV5MzhXY2k1?=
 =?utf-8?B?V0dBQmo4Zi9VTnhud2FxYnpXL01KcHN4RE1MSUwzS1BhNGh0b0gvYUdWbjR3?=
 =?utf-8?B?SEM0NWxJOFZpeTk2d0dMeFNic1lsS2llU2tNYXA3ZXJvYmhucC9XWmhUYkdC?=
 =?utf-8?B?Tm5wWWF3WTBDOTd0R25vYlN0RnE4YUY1Q2F6SmhBWnk5L3BjNndiZWVudjZJ?=
 =?utf-8?B?OTB6MHdGd1A2eENFVmdKanBtSXlrSG9nOXgrWnhoalcwQnNUaUZtKy9FNnVT?=
 =?utf-8?B?aVZvQkxPMThkZGhZdWpZOEJvOW02WSt5K0NockFGUGQvUk0vck9UN0ZEWHVK?=
 =?utf-8?B?cGVWdnVOMy9WRVgxSVluK0FzMkdQQUJ1Si83bGhLaisyZG9zVGxad0pTZ3Y1?=
 =?utf-8?B?cVF6eXgvdHpRZmlTS2dNMjFZM2poMTQ3ZFlrc3dkODkwenRhcm1jSjg0bVM3?=
 =?utf-8?B?T3Q2RVVQWmNXU0RhMHVpVTVOa2E1N2VWSU1Ha2p6anBJaHFPaHdrbUZUZElO?=
 =?utf-8?B?dWtqZGNPbk1mU1I2SWJSdDhoSzYwck9VTy9DWGNUaisveFFlQmhrakw2cFdu?=
 =?utf-8?B?SFJ2VWN3N2kzVGtldnBkMG91K25hcTVENnB3eVNCOHN5UHlYWEsrTWJ3MzBC?=
 =?utf-8?B?M2VIZlhFRXhJdTdQZVRPRDdtbFRJUnJRMXZxZ3JwWmZDZkdpUjVvOUZ5bDdz?=
 =?utf-8?B?ZUFLSzJCT2gwbnZXUDlDanNnNXpyYmFycS8wMkFSRGZKVDFhRHorM2x1cEp1?=
 =?utf-8?B?QzYzek5PZ3AreFg4Q2RvSTQycTZaVTZXcVZIcXptVkFySG1RMlBKd29PajR1?=
 =?utf-8?B?alRRR3FpdTA5TXhMbEpIYWU1djVxQ291aXp2a3M4bUdGTW85cVVydDkveTc2?=
 =?utf-8?B?NUc4S1Evd29zMGR2Z0JqSWhmZDB2NjFlbkZhTWhobFlyaXJ4QzhRb1NnOGk0?=
 =?utf-8?B?N0RVV0wySUU0WlBaSmxJTHdFL1JOK3FEc2Y0dG1wQm9LSFRmcFgwMjJuSFlQ?=
 =?utf-8?B?RFdaNGg2ckxkZGR1VWp2cHZmOW9jOE5TZ0czWTFHZ1hlbmJOUy8zUEpJbnJM?=
 =?utf-8?B?ZXd5NEJwaXpVek5hKzNxR1JpSFpQSCtWWVJkNUc5a2hUd0pDVEZTY1RLU0ln?=
 =?utf-8?B?ckpUMnM3T0tBMWZqWXk1RUNXK2FNS3lnUmVYcUErZVhheW8xQjg3WDJQN0c0?=
 =?utf-8?B?a1hOcnN4Sm0xKzBRRmxkNHFxRnBFQWw0SWNMUzhLZStFM2ZHWmxyVlNFZnp1?=
 =?utf-8?B?TlR0dVkyMXM1S0hGcjhsOFFPSDNPQllGUkRCVW8yQWkxdkhQWU1STUxBT0Fq?=
 =?utf-8?B?bGFyNVJTWFdlNHN6MWNESFBTOFZrVGgxdnA5WVhaUzRMdFZia09pdHNnWmRW?=
 =?utf-8?B?V2tyOEkzbHY5RDB1UXFRck5la0w0YVBzdmhXSnRoQmpCL0Y4TFlrWXY5c3dt?=
 =?utf-8?B?NDNuVlJiSnR3SFhLeWdtZzZYVVphZUQrWHIwdXcrMzlNOC9FYVA4MlRqUC8r?=
 =?utf-8?Q?KU2tGt2MiDCDUPcSFJulyGu/O?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ins/4hRf1e0j10bSwmpvZcshG4+EcsTo5uVKgy0XMz/pZj0aHZtr9gmCM1Jas2n+KgOkx54Y9g0HuLVhpPjJe3dXjcF71NBLpaDvQoj7NwilFZTrwqUb8jpcqxgx2ENYrz4VzSK/esZDOs69fHnq7O/WA+dcBmH45PyKw8nwtpOwULOVKNBAQWGmj6sCIzAyhNyf00RYs88zstv7HTW6/aQlu0mAsidKleYotOhyME6KvuFA7WL2aSnlPSjMgqOIzZecHEyhUkPo7r3riO7ALkcFGimHogD2ZfLl7rQ7DH5Fn5vtFAWQfc2Ca+gWapqj313awD4SrGcqHBrkdXMIIh6pB9JsIZb0JMLF9liQrCNbiRk8p4UcCALfgTkOpjxyTbTjDluuXpY8itkgFZAMYEVTIyzpPwiUjH33LOrdVCeXCXd3IjzmBrQsg03D2h6IDJbtZ/luVSj0wdhdWXJYmrR773m7ASi5k4zhl6RwKy7wDQhKfXrl2P4rgoq9OcZAIBzlWh+LksE/IQUaF99/hIEmbcyS3Fl7ZU7fC3y2L9IIEl2Ms1So+1LlMluPnjPDFYXqrc7BJN2yojXwQeqEmQHOm4J1eQsW/ErxxP0F2HE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e639c11f-8fe2-447b-0916-08dd7bbc4491
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:24:29.2753 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhfdJv+RoTKpfRNI1Toe1TstVZ/Xxa21Zg86MX61clQYzV27LhkUt+maN0IOGEoddC+3uXAIrNf2Xi7qAr9AtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150005
X-Proofpoint-GUID: -cCa4ZllsKgfUTWg1lN7LGFDngCRkRMM
X-Proofpoint-ORIG-GUID: -cCa4ZllsKgfUTWg1lN7LGFDngCRkRMM
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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


On 4/14/2025 11:18 AM, Alex Bennée wrote:
> Annie Li <annie.li@oracle.com> writes:
>
>> The GPE event is triggered to notify x86 guest to suppend
>> itself. The function acpi_send_sleep_event will also
>> trigger GED events on HW-reduced systems where ACPI GED
>> sleep event is supported.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/acpi/core.c                       | 10 ++++++++++
>>   include/hw/acpi/acpi.h               |  1 +
>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>> index 58f8964e13..00a9d226f0 100644
>> --- a/hw/acpi/core.c
>> +++ b/hw/acpi/core.c
>> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>       return -1;
>>   }
>>   
>> +void acpi_send_sleep_event(void)
>> +{
>> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF,
>> NULL);
> Is it a fair assumption there will only ever be one QOM object that
> provides the TYPE_ACPI_DEVICE_IF interface on a system?

I supposed it was, but I might be wrong(seeing some classes have the 
same interface). Please correct me if I've missed something, thank you!

Thanks

Annie

>> +
>> +    if (obj) {
>> +        /* Send sleep event */
>> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
>> +    }
>> +}
>> +
>>   static void acpi_notify_wakeup(Notifier *notifier, void *data)
>>   {
>>       ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>> index d1a4fa2af8..64d3ff78ed 100644
>> --- a/include/hw/acpi/acpi.h
>> +++ b/include/hw/acpi/acpi.h
>> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, uint32_t addr);
>>   
>>   void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>>                            AcpiEventStatusBits status);
>> +void acpi_send_sleep_event(void);
>>   
>>   void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>>   
>> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
>> index 68d9d15f50..1cb050cd3a 100644
>> --- a/include/hw/acpi/acpi_dev_interface.h
>> +++ b/include/hw/acpi/acpi_dev_interface.h
>> @@ -13,6 +13,7 @@ typedef enum {
>>       ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>>       ACPI_VMGENID_CHANGE_STATUS = 32,
>>       ACPI_POWER_DOWN_STATUS = 64,
>> +    ACPI_SLEEP_STATUS = 128,
>>   } AcpiEventStatusBits;
>>   
>>   #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"

