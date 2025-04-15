Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1238FC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 21:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4o9h-0001Dd-Ti; Tue, 15 Apr 2025 17:49:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u4o9H-000134-1b
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:48:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1u4o9C-0003mj-Mz
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 17:48:54 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FKu4XP011386;
 Tue, 15 Apr 2025 21:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=pBgyh1x5qO2klEI9yBtv7QUxM24+mOJwOUzDDn47Iec=; b=
 eyagwQmGj+cskkFrpDQBP2W+Fjce2OERq2I90xfiSPlnPnUpMBpLUYPjjnicWL2w
 k7qEIefHU+zr/zCfV3uBlh1tRiJh5yBt2q+ZeqvmhI0aaTsIYEOhXNmMYgrW0Vrb
 6ip2eLq4zRnsbv7QJpfZlkNgKnSXvXeCm63j/dQK4cnstcNaYiPUr7VxVlv77o0x
 UQTipd/eE+Np8UWgchS6CAEfQUu/RjrocawhZ+1/4lIb3XJyjt5vd+i7q8kaDoQA
 WBqHLiPh6nWnvqhlAXdc6Dw3ejf+q/bjYZ7OOy3dtcW7pei+lGR1g9yTObmo6ARd
 8QbivMM/LRKSTR6oHTk4lQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4619442m50-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 21:48:32 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53FKeuj7024671; Tue, 15 Apr 2025 21:48:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 460d50y3g7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 15 Apr 2025 21:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysmIB8qRlp992aV5Yi4wiMYCmFE1NepbA5257ULgT1yWRvzvUZUQOdOHtkc5MNA2tlH53sXksp7QryCq6hJCydpWBF3gcSI7JrfGhStQiQGk5bXwBMdC1GG3soqHAJRUtR1Ykcme9vnawXUJ3hGcGQN7rXvX7SgON2p6OxcpWKCB5A7myAHXgKpi8oaOFjxbv/3YmQCeIb8HehbyQ400VeWIExqpklFhKst7p6BdwMNGWeKN2XHDf/H90Tb4iiPuV1FOz/cGlHeaqq/ec+r2zZNmeWc4TDIa8NV8LKlih8h3QAFFSIiWsgmtY1HkLnzCbLTn5Kss7xNZ4ZfL/T1rdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBgyh1x5qO2klEI9yBtv7QUxM24+mOJwOUzDDn47Iec=;
 b=uv/bwHhuiVYL9wxtOqcTgQ3gEPDQA6GXhLKucpcv755mXL4doYnKYZHU3kbAX55Xo65WvGjT4Y3yI9eQo82vPyuC6qJSU++jBpLPdIXMuueZVKSxkQv75FRmOtUKIBU6Di1kKMEh60JyXEYeTVYeckaiRtVK7+f3c38hx/bUiTjZTUUiiaO3CS6FC+0sWz0lEPQ+b7iEPe5OEMrJA6/UuOX1tX5jck3Lw2qCdEmqYZW3IuLtk3jT954z1c9YvGeOlDdaMSTMVIDJL8gzDipqUfovtYFacJQqe833w7twuByXUsBP02kSuExD1o0kzy4diWO6xRFUR4mANClXvS7gdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBgyh1x5qO2klEI9yBtv7QUxM24+mOJwOUzDDn47Iec=;
 b=bHMm5mJSs0Pj7vMHxjbA0jL0rESRIVPUf1lgtD8sytfc4FODDr++1EIlg0uwjAV4djdg1lkchhv6ZuqfXaUQprJN52FtaI876J1xdhX3Yh0Ud4ijW0jBjOakAolOEvLMNlDgqJwtDVHwJooLf438ceaD1sFmFuoE0NSPvq9lWJM=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by PH7PR10MB5748.namprd10.prod.outlook.com (2603:10b6:510:131::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 15 Apr
 2025 21:48:24 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:48:23 +0000
Message-ID: <07dfb619-d563-4735-ba39-6ff4561d368b@oracle.com>
Date: Tue, 15 Apr 2025 17:48:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 05/13] acpi: Send the GPE event of suspend and
 wakeup for x86
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 zhao1.liu@intel.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 slp@redhat.com, eblake@redhat.com, armbru@redhat.com,
 miguel.luis@oracle.com, Gustavo Romero <gustavo.romero@linaro.org>
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411204133.2955-1-annie.li@oracle.com> <87cydeepp8.fsf@draig.linaro.org>
 <5a567f2d-31d4-442c-b68c-ed85491d77d4@oracle.com>
 <6d771164-bac1-4d99-8e05-0bf65a3351ca@linaro.org>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <6d771164-bac1-4d99-8e05-0bf65a3351ca@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:208:a8::48) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|PH7PR10MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f15a789-a751-477a-d488-08dd7c673f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0pxSVFYR0RrWGdHYW9Ra2RTbnR4cG9SVkFrYXdkQnhiYnBJY29CQW9PZitw?=
 =?utf-8?B?RFlDUVdSV0d1SEJwYXZ1NmplY2gyTHFRMzE0cWY4cnp0OExSMDVSMmpQcnZG?=
 =?utf-8?B?RmxCUjlnVzM1bkovNkFlTG15cm5icGhTYWRzMTdnYms5QXhheVgxREhIaE16?=
 =?utf-8?B?YmpSbGliTmNvQkdWOGh1MHVWVFRGd2taMTVjWTVrSkhKODNDZm9BU2lsL3F3?=
 =?utf-8?B?dnlyd3QyYzJXeThpS3pOSDExZmRiZ0VEN3Ewd2hlYStGU040dkNXdlNPRjVV?=
 =?utf-8?B?dzN0YlE2cWtUZE52WHBZLzZBSCs0NCtiRjM2V1JFeTRFTjNxTWQ2VUVhd0U5?=
 =?utf-8?B?cHJHelFwOGg0TXpvbm5qdWNaaXZIM0ZseWFoejMyTXR0NE92ODRuSWVQcGor?=
 =?utf-8?B?NlNadjZPOHRNQTBoM3VVbkxuVzVCRmEvM3lKeWxXMHpidjhTbmlZNnpyMGJw?=
 =?utf-8?B?OHBFUnB4NzFSMElubGU4Vm1YYW9WUHIvTVNjVWh3VHRUbnkvS1hyL2VCZGlF?=
 =?utf-8?B?UDRxNXpIdHkxeHpNeDRKcm1IZThDRkxqbnRyMU9vZW8rNGFsR2UvVDV4N0VE?=
 =?utf-8?B?WHBWUVFzZjUvblQxUlI2VjNUM2VHZEVvM3pWN3BIN2xnY2hrbE9iNEZIMHdI?=
 =?utf-8?B?NkowVE8rbVUxcmwyeVk5Q0NyWUlhNWk0OTNjNW9WQS9JcjRYMGlHUmw3Tm5C?=
 =?utf-8?B?RVJESmxPdlowaE8zUFFhOXlhTHZSaDNCNkdmbm05aUIzc09CVUZNUHVaRzhP?=
 =?utf-8?B?bVUxNjdkZFljMWRSRWdvNTdUZWovbW9hTUlXZFltcGVFRmxhQWZzd2dubjZS?=
 =?utf-8?B?eFlHNjIwT05RN0lVWGZyMDlxZkRDZU04alRvOVo4R2luMkwwWGVsMGRmL2Yx?=
 =?utf-8?B?RUlIRFFicUs1d1lBU2srQytGSzVJdHhYNkxyangvcXNXQytyajZSZlRpTnhU?=
 =?utf-8?B?NndWbUl6NlZPYm9mNFVaTFVvdDdad0QwNFdRSG5xclNTdlQwZ3FDZ09lc2xX?=
 =?utf-8?B?UTNtUTROZllMUC9yUktWZkxBRUs1Zkpzcm9pY1h3UmJqSWxhUTNYMk1NcEJE?=
 =?utf-8?B?U0N2ZndmSmZHTzA5eWdnN0dXZmIxeG5nVmh3bjhRbWp0QUh0NHl2NEhkL0Fa?=
 =?utf-8?B?aXpOYS83ekZtQzNlMnBRT3d5dkdaaUdXV1NEczNYYXcvVUxLeUF3aWVieit0?=
 =?utf-8?B?cWdVczVBdGwzSVMxRndzRkVBVGRheGE0YytPR0NOQVZrVVVTN0V4NkE4b0hv?=
 =?utf-8?B?YTVzV2piUXFXZTA3RXNxNlFBUUZ2anh3YmpaSU1Ba1VuOHJqdjhkMkdlRlhE?=
 =?utf-8?B?alNpaDZXVC84Mk9MSGo5akpzT1g3aWZLTDhnTU42SjJLUTNLUEYvVEFXZFhm?=
 =?utf-8?B?am1MeDRtUDlPN3d4UWtJSm5IbnJmUi9wZlFkcm8reWVVV041dGd4ZnBONTBt?=
 =?utf-8?B?REM4bXpERk1wV0lZS1VORmdrYzVhQUF2U3pBaFdEUFBqdzNkK0Vya3hkZVpS?=
 =?utf-8?B?RjJkU0pXM0lDcDFCUkxqU1dDSWdtTS9QZzVhaFVZTDEzdlRpODFzK3R4T1Fq?=
 =?utf-8?B?US9nYStQM044WXZsdkRBRXBqWVcxY0h6NnFSb1QvNTI0TzlaakpnOTBNTmdi?=
 =?utf-8?B?TkxhalpjVkJ4VVI1RllqWnpKVWpOdmJPK29FWE1uQm1yb0V6TDBKY0FvSkNi?=
 =?utf-8?B?dVI2WktZYTdNUFJvSFV6VXpyYS84WDdsb1VhN1oyeFRCWHVoWVBFMWxDTjNm?=
 =?utf-8?B?OGh5RmtRSnVZd1c5Y2c1Z3ZFdTF3TmFFdnVkaEVqeUpwTXp2aS9vLzdqTkd1?=
 =?utf-8?B?cFFFL2l5bndiWlFxUlFGcW8zR1cxcVJiVVZoKy9yRFY1Y1ZDRTJ6bmJ0S0pI?=
 =?utf-8?B?M0tqdVduYXZDaHFPbjgzTnVQQ0ZRQVNDRlVjOHRhM2VuVEFOQzJzZ0VXNGli?=
 =?utf-8?Q?VZuDHAxjiJs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clFNYkJGdVp0cjNSNTI4b0hyd0w2TnNHR2RhUjlsQjR0eU1OQVJ0Q1VTVVk5?=
 =?utf-8?B?RWVWS1BQdkppUXlzTWh2REZXYXRhUHh2U2FGTTBhV3Y4dlpsdUpoMzl4d2lo?=
 =?utf-8?B?WkM1cGZsbjlyNnR5V3c4MjlYeHYyT2Q4YjhrQy9jZWRFenRKdGpHU2V6Z1ps?=
 =?utf-8?B?TVU0RUV2aTJ4cmJMbHIzZjZRL2FQN0h3eGwrek9ib2xxbkhGd0V1eHlIWmNM?=
 =?utf-8?B?YURpQ2NGUDFFamRkTGRhSEZ3SUhrUGYrSjAwdnk1aU1DZVNIMnVSa0xJV0lH?=
 =?utf-8?B?c2NpaHNiNmY4eDdwUmJMaXpxaHo0NkhGQWxZRXFURUFmYUdWZ3BzVTBBTzJS?=
 =?utf-8?B?aDRsUExkTUQyb1pkSnFuRStVNzNSdkxRSzBRMDBoQ3dFVjhjR1ZaTTdmWE5n?=
 =?utf-8?B?WmlRd2FJZWxZREdqWDRQQ1gwSEE0UjBHQnFsQm5ranZqQlU0QTVJWmhJS08w?=
 =?utf-8?B?QWtheTRRQzBDNkY2TGl4MVM4K202WWZyOVRUazhMT0pCbVY3Qmh4WnMwSFlO?=
 =?utf-8?B?MUtSS05yajZUN1lWYVUxaWJRUnZ4MUJOZ3NIZlR6QkpyWms4YjZLdEJ3NFFy?=
 =?utf-8?B?eit3MFd6TVpQVGh4UHg2TDB0S01jMTNqd2RaNC9ONzRzajRrR1hSU3ZQck5v?=
 =?utf-8?B?TG5KOFR1V0pmSDZjZWd3QWxXK205eHFZN1VYOFIxQnltR0ExNm5oblcvdEhI?=
 =?utf-8?B?VkZJTUxkNTBCNmY1NnNuUlcvNUwzSmwwRldvV085NFpTQ0dtSmxQNThQL05Z?=
 =?utf-8?B?Z25MS1pUdnNlR1RjUm56c2VHM2UwWmJIdThxTDUwT08rbWtFcm13aDFkTHNk?=
 =?utf-8?B?NG4wVzQxam5pUVBxNWlSMzFCcVJrOFA1ZEswb2FxOVk3SlVjSW1NOEtGMWNO?=
 =?utf-8?B?UzNvbmlXS1JaeXhibXdDcG14c1N6S1RpNlBNQmtUYmJxQnZTekgzclZ0TmlW?=
 =?utf-8?B?SHBVYWpMWjNma0dtK0p4bUVqdDgzUG5nRkh3d1lHRjZCMzlpQUdZUmtPcWdI?=
 =?utf-8?B?cGJpc1NSMW43N2V3TFNLWHQwNkRYWmk4TVR2bkhEeCtWMSs0blFCZVVtalZa?=
 =?utf-8?B?TmFHT292eEk3Ukx0WTl1WUNpMFpmMXdNNW0rYm94Tm1pTm9PTWtxcmk1NE5J?=
 =?utf-8?B?dFJwbXFNZGNvUXBSWHMrTXl6QjMrekVjT2FPQXBLUDU0Q0VJTmhZY25nbDls?=
 =?utf-8?B?bVJPS2hpVzBtcm5PNm9rWW5ySDc0NzJYZ0laQlg0RU5KTmlLTEpuNUdEK0wy?=
 =?utf-8?B?WTdvSHFONGR1WEllK2MvUk5ldXJYMzJNZm4yMlppcjB6dGZQallLSE51Vmkr?=
 =?utf-8?B?cVRwSUxCWWZWUUV0UThjVFlScm8rL3Y4Mkwvdm1MWnVuSG9XclpwRHlzM2xW?=
 =?utf-8?B?U2FTRHBPT0VqOFlmM1Vqa1hLNmhJV0E2L1QvaFFBdzFhWXdTOVlGRzVBbEEz?=
 =?utf-8?B?Z0YzVUVZSHpyc1oxYXpwdW9zMGphNzlESWZOLzJ0QmpYVWdaQVlwVm5YTzJQ?=
 =?utf-8?B?aXA2ekxJaSszVGJCUHRQd2V2ajNLQ1VZQm1GTHJmTCtyWFVuYzlQQlZlc0hI?=
 =?utf-8?B?ZzAxVFd5NjFzL0xaZUd6UVljQVNNdWJ4TDlVTzRHOHd4WHRPNFNSYU92ZU13?=
 =?utf-8?B?RjRVRmxldkJuS0s0OURaSGw4SGViSEd0MEJWOWV2dXZSY0VZNHVuaktzMENB?=
 =?utf-8?B?dHRFT09uazJQdnY0Ui8xbW5lWmhCSFdvSGhCYXRobkF3UzF2MDQ5a09PcE1M?=
 =?utf-8?B?am9CZldGK2RnNnIxVm52RWpDR3hSdkQ3SWVFMDBJSmQxaFNkTnlMWlhObVUr?=
 =?utf-8?B?OXVrVGRtV1ZxMTR2eE1ER2swYnM3NldibEZJWDVXL3MrSVJMSHZCems5UFVh?=
 =?utf-8?B?YWVvVHlYRjYwa2diU0ZnRmJmRFRULzV4cFZ5WmpOZVpzYXdONHdrQ2RkWVc4?=
 =?utf-8?B?cmovTnE4Q0QvaHJWTE04R3FWODIwM0VHMlQyaWEzempSbWs4b3BDNUZIZ1lM?=
 =?utf-8?B?Y2RxY0FkZFhEUFlyVi81VlpucmR4WHlLSjcwYlZjWHcwSU5VU2grQzlpSlBi?=
 =?utf-8?B?UzR0QitFUmRvWHd1OWdkeHJsOXFZUFlMbXNmcXE3RXhEMWEyaGpuVVpWK3lQ?=
 =?utf-8?Q?vx93ni5OZBvKpxegZYHonznbb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pNaTI0v9LPLOqa4ZqEsehoh+/aFSeM0PRid60HipFbLk+6GaB20+sUkWamPlCrYfzKWpL5PObWqmByoKonN6JJay5SMgiz/HLaoQQvt03wsZORaq19Bz0jhoWr8mk7Ywv61EAdSkHupsNuE3oWx6R975eqABAcpS+UwzIzgcvJQGzOk+H9qjK7CInoDP6rTn3jvz3dNg8lf/iE/ZE9eIJThTpgDD4F/ZglHax1KzNN57EacOttLLtAtjvo1KFIEJxbw4VS/zne6GpUChnxvM7C2AADzyLfcN/BTchkNofEm10x2U2w+W5bTEoUBiDEahUZzW/CM4X5fMvtQH4LuX8zwT2t2mOOqgvKXgiwQc5VkrhkSuQbDiwLcTq5CakEAqhaP+SyDAbA+L/vkGbebg8EJOsnRtXQvCPyOId3c0KyY99Z2k05L26OlVemywKcMsed9GP5rNcR6oSS5Hl/9YzCBv/NmqGsjCXED9OyMyUybI9QoY65Q8yCQaYcnS8sPrCop4ov5MbjkkAXsbXXIpU+WddGYSg6MmWJZRxWqc45Go4cbRwnmjierrIJIHKz7u3UvU3kNfMbwH7bAEt5bCaiZVNCqsDGSWxFWKVdYEzUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f15a789-a751-477a-d488-08dd7c673f00
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:48:23.8654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtP5DUJGm3Yc+Oql1xdcGSmO711nTBwEVnq85o2Q6SEz6F9I0d1mPp9lpKxWuqkYqT3/zw038tjGQl+GOE3Y/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_08,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504150155
X-Proofpoint-GUID: pWcKMUwFbkNeOouegYzmDH0ZfvTGawwM
X-Proofpoint-ORIG-GUID: pWcKMUwFbkNeOouegYzmDH0ZfvTGawwM
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


On 4/15/2025 11:29 AM, Philippe Mathieu-Daudé wrote:
> Hi Annie,
>
> On 15/4/25 03:24, Annie Li wrote:
>>
>> On 4/14/2025 11:18 AM, Alex Bennée wrote:
>>> Annie Li <annie.li@oracle.com> writes:
>>>
>>>> The GPE event is triggered to notify x86 guest to suppend
>>>> itself. The function acpi_send_sleep_event will also
>>>> trigger GED events on HW-reduced systems where ACPI GED
>>>> sleep event is supported.
>>>>
>>>> Signed-off-by: Annie Li <annie.li@oracle.com>
>>>> ---
>>>>   hw/acpi/core.c                       | 10 ++++++++++
>>>>   include/hw/acpi/acpi.h               |  1 +
>>>>   include/hw/acpi/acpi_dev_interface.h |  1 +
>>>>   3 files changed, 12 insertions(+)
>>>>
>>>> diff --git a/hw/acpi/core.c b/hw/acpi/core.c
>>>> index 58f8964e13..00a9d226f0 100644
>>>> --- a/hw/acpi/core.c
>>>> +++ b/hw/acpi/core.c
>>>> @@ -359,6 +359,16 @@ int acpi_get_slic_oem(AcpiSlicOem *oem)
>>>>       return -1;
>>>>   }
>>>> +void acpi_send_sleep_event(void)
>>>> +{
>>>> +    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF,
>>>> NULL);
>>> Is it a fair assumption there will only ever be one QOM object that
>>> provides the TYPE_ACPI_DEVICE_IF interface on a system?
>>
>> I supposed it was, but I might be wrong(seeing some classes have the 
>> same interface). Please correct me if I've missed something, thank you!
>
>     /**
>      * object_resolve_path_type:
>      * @path: the path to resolve
>      * @typename: the type to look for.
>      * @ambiguous: (out) (optional): location to store whether the
>      *             lookup failed because it was ambiguous, or %NULL.
>      *             Set to %false on success.
>
> Since you use ambiguous=NULL, your code will only set %obj if there
> is exactly ONE device implementing the ACPI_DEVICE interface created.
>
> So far IIUC nothing forbids creating multiple ones, so if you expect
> only one, you should add code to handle the "2 or more" case. Or at
> least add a comment.
Actually, there is only one QOM object here.
There are 3 classes involves with TYPE_ACPI_DEVICE_IF interface.
PC, Q35, GED.
For x86 system, the PC or Q35 machine doesn't use GED event, instead,
it sends the GPE event.
For microvm/ARM/virt system, GED device is used, its own 
TYPE_ACPI_DEVICE_IF
is involved.
All these objects do not exist at the same time, so it is safe to assume 
only one QOM
object exists here.

Thanks
Annie
>
> Regards,
>
> Phil.
>
>>>> +
>>>> +    if (obj) {
>>>> +        /* Send sleep event */
>>>> +        acpi_send_event(DEVICE(obj), ACPI_SLEEP_STATUS);
>>>> +    }
>>>> +}
>>>> +
>>>>   static void acpi_notify_wakeup(Notifier *notifier, void *data)
>>>>   {
>>>>       ACPIREGS *ar = container_of(notifier, ACPIREGS, wakeup);
>>>> diff --git a/include/hw/acpi/acpi.h b/include/hw/acpi/acpi.h
>>>> index d1a4fa2af8..64d3ff78ed 100644
>>>> --- a/include/hw/acpi/acpi.h
>>>> +++ b/include/hw/acpi/acpi.h
>>>> @@ -184,6 +184,7 @@ uint32_t acpi_gpe_ioport_readb(ACPIREGS *ar, 
>>>> uint32_t addr);
>>>>   void acpi_send_gpe_event(ACPIREGS *ar, qemu_irq irq,
>>>>                            AcpiEventStatusBits status);
>>>> +void acpi_send_sleep_event(void);
>>>>   void acpi_update_sci(ACPIREGS *acpi_regs, qemu_irq irq);
>>>> diff --git a/include/hw/acpi/acpi_dev_interface.h 
>>>> b/include/hw/acpi/ acpi_dev_interface.h
>>>> index 68d9d15f50..1cb050cd3a 100644
>>>> --- a/include/hw/acpi/acpi_dev_interface.h
>>>> +++ b/include/hw/acpi/acpi_dev_interface.h
>>>> @@ -13,6 +13,7 @@ typedef enum {
>>>>       ACPI_NVDIMM_HOTPLUG_STATUS = 16,
>>>>       ACPI_VMGENID_CHANGE_STATUS = 32,
>>>>       ACPI_POWER_DOWN_STATUS = 64,
>>>> +    ACPI_SLEEP_STATUS = 128,
>>>>   } AcpiEventStatusBits;
>>>>   #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
>

