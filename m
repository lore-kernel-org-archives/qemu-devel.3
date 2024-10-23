Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A056CFA466
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 20:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hys-0006V1-Gi; Wed, 23 Oct 2024 16:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3hyq-0006Ui-R9
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3hyp-0000Pf-7y
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:20 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFffog001663;
 Wed, 23 Oct 2024 20:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=LDpf4qQ4A6khrAJqO6MSu6XKmIqlBUQP7EaetN/Yw6g=; b=
 fX/lxwoFjD0XbrPEdhe3OmHDeTBdpKVFNVFn2VaSYzCzppfMRJhjOb1GioOEypBu
 BwNhCjeCqIh6M470ZggBrELI8PR6rMrKCaXb+Ac3OslfpEXtjap1s3Bl9hGW3AiF
 NlIXxBnMOliLKYm5kurl/GR9sJ7Z56pncfsfNDVBjw7BVfi0M3kHwsyCDCF8Q6JN
 1kGVgOfYonDawnstATvHA2EYB4AJc04B4rb6/OjQD0zFrxDBDEYWX+DkWKgWlc/w
 6mn6W6offGGeyz4qc9Z92oTUbhkaV/Tc+a0Zang/C0xCfDcGQbCbiB07fK0bD4qA
 95d7GDvmAbCQsQjfs6diyg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qh4ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 20:29:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NK7Z5n036212; Wed, 23 Oct 2024 20:29:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh310xv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 20:29:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ht9e5rTQppV670mVaR1yW44BqMgXr3tQIhwJx2e4pFhNAkanlt6i2wDSE6U1sP0dnU9OUGlhQjAFmAUVszG3g5tBJknSN/CgIvoKdmnLU9Hx+sdWVzrSxtAYIvfZ/xWxX/INkffyiIChPE6XR7ap6JNA5t0mvDr0oW0WIT8gvGtjwdUqHqdUQi2oUx7plMiEqKSN5nH+3b9ACUEgbO3rbcLRgi33tUaG92V2cJ4w9V4dGCquCCYpSlPw9wLKPyo2Eq9UAUSc/Kiy7QtF+DQukObCQxFbDK0uFRxlwQJ9MGIKRKMTK+9Md8n6JTOkYkx97xV/tEmS56GGNGOIZz2f5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDpf4qQ4A6khrAJqO6MSu6XKmIqlBUQP7EaetN/Yw6g=;
 b=PL4k1ZEOJF49Hz/lKxA9KYVx+TqQhHwYBe/HarIUron5g4ql/mJaY79OViD8GkEr7esmy0URIqM9VeFTICaByc2zUXoUF8lC8r/2w9UERJGr/Tt5wKxk/YCONTyVlv6fuI+1yqG/tLmRG5lVzCOtc7Ll2LYHMskGuEQENHQdZiQKUx8awgqganxUOo0ootRxVzTz8/hbebed/s90JYVFiafdzGvgINt6k9tGuGtLdSscmz4SquqmC+Bch0LvFjlYvxByLOnLfXC4IyqGQpuM2QGTsxM6Z4arCHUXORgrzs4gbXisDLcREGKVo5dY33+UVXW+xF6VJW1dQF0AHmDqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDpf4qQ4A6khrAJqO6MSu6XKmIqlBUQP7EaetN/Yw6g=;
 b=UwdN/ae2wbuv1M8sPA3Ugny9CLbWwoWTBsZxe1XI5ek8PN/jleoHoe2THHMiIcSkDiGvk2SsyGJ8x1ue4wtc97IPd2qJUwzVxiZh6BnSwJu26bmnVu5uab6M3UNkqCxVrWAyFrmHIsWlG7pJcFdrTeFpgSHSfeevkwkBzMNz4Gc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6662.namprd10.prod.outlook.com (2603:10b6:806:2b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 20:29:12 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 20:29:12 +0000
Message-ID: <faf6e836-d441-4817-a520-9e747a5eb8be@oracle.com>
Date: Wed, 23 Oct 2024 16:29:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <ZxZw5xnN4cY7j680@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxZw5xnN4cY7j680@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0136.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3567c8-faef-41bb-eb50-08dcf3a15b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3lWdzN3dkYwU1VkaFdMUE5ESlpIWWhVdExRZ0h1Rk9tTmY0NHoyRGdqWEQv?=
 =?utf-8?B?anBXTVNxMVpwakpZOVJEYTFJYnl2NDM0L0RVSS9mTlM1RWRkTlRmQklnWXBy?=
 =?utf-8?B?bllsLzMwOEVjMEhLZkpTTTJVa1VJc0ZXQ28xZWxxdVg3QVZjdVdnYXVGTzUz?=
 =?utf-8?B?YzJNZFVuN0lTbDdFYnpPRVBtRjhuTlQ3S0RrZmhqMFRweHNva3plV0F2WXBB?=
 =?utf-8?B?NGJhdXBOaHN5ejFXL1c3QTRGTUhwNTBVMThYVFJBM2Q4S1dLcGhVd2UyOW9K?=
 =?utf-8?B?eEd1aUxvRW1hV3dXZHEzMUgyU0xuOU5TNllacUpNaUx6NDVBR2JuTVVGWGtR?=
 =?utf-8?B?SEE2NkN2MHhaRWFWSHJhdW1sQSt1YVhsVnRicFJOTG1LZnJTMUd0K21ValNz?=
 =?utf-8?B?cUZIb25LWU50MElBWFJxQ1JNMkdQRkJPeUVZUnNXSDFFR2lUdWZlQWVKUWZ2?=
 =?utf-8?B?RGpZNUI1QTFmR0pEeThmTWhKNGdDMzBFaldNSmpsU2VROFBabmk2b1ozV1E5?=
 =?utf-8?B?M1I3dGZtclB2MmpLdlRzL2NNMmxYODUvNWwxTWRlUFRQcWFNTzNDYzM2L3Rp?=
 =?utf-8?B?L0pHTkJPc2RoVVZySmFxV0dBb2ZkVGo5eWIxOUs0R2NwMGZuUSt3MzE0T0VG?=
 =?utf-8?B?dFlsTzdXMkprTEVEb0o0ejRGZTk3WUZqV09LekUycTlLWm1NejI5SkZNblB4?=
 =?utf-8?B?ZS8zWnBiUlJPSXBUOWZLd3VUOGNjKzU3OVRrQlVVeHBoSzNLRkdKaGZMUVN4?=
 =?utf-8?B?Y3FtZUM1Z3REWVJZck5PTGU4YVJNUDlyTjE2TW41ZXJvbTRXK2M4bHM2SW9F?=
 =?utf-8?B?SFZ2bDZrcERIdldLNFlpUE9jclg0UldGMHd1S2R1a3B6Q3NlRUVoaExaRHFv?=
 =?utf-8?B?TnVZYlF1dnVyVFQwYm8yeWZLT3N1aGprYklFU3hMSnVYSDhJZnlzSTJiWitL?=
 =?utf-8?B?K3hZckF2QUFpSDIxdGd1T2VOeFRqcXRHNjhCOUhxbXFWQUorMGNxVy9rbDJW?=
 =?utf-8?B?K2VKSHBadWhjbi9JenJSVXl5UU44U3lWMlh3djFnYjM2ZHpwaXZkekJrVTdK?=
 =?utf-8?B?REdhNUtJOFpoSlNzcGtjL24zZmV4TjRwQUpTdm5pZkdsNGd4RlR3MUxrUU53?=
 =?utf-8?B?RzVRK21SQ3pEUkFrK0dkZDRtdGhsWCtQeCtJOTlQZ1Z0engvcWpkRUdCd2Jz?=
 =?utf-8?B?aXM5WUFGTndlVGZXcWJmUjJKYUkyMHcvMDlXaXV5QmR3UzBjVUh5b2RNUEpu?=
 =?utf-8?B?RVNPM0dlY0Rma09qSnh2R25ZWjhFTEtVWUVDOXR4dWYwZzdSZXlWN2w2SUhX?=
 =?utf-8?B?OUVTNHRmS0JNYVhzKzNLclhpMzhUSTJUcE5YOHJRcGY4d2puV2FVV3dsSnlQ?=
 =?utf-8?B?MjMzYXFVRlExb2xkVktFTENpL0tmbXJPR1oxL2JWaGVtUFptd2NGNXZFMDBz?=
 =?utf-8?B?ZTRIOEN0OVRJQkpTOEM4M2FJNWhtKzVUQTZwY3JUdTY5cjNNSUN6WEpFUTJJ?=
 =?utf-8?B?Yi9hRFIrTFozZjQ3a3RIOXFNeG5NeWJCQ1YzNUVOM2NOWDRsRzQ1MjNPYU9G?=
 =?utf-8?B?RzhNRmVjUG5sUCthYUpYM0QzYWdQT0VHSGFDRXZrSHlPczdBR3R5SDE5S1lC?=
 =?utf-8?B?SG5CcXZLSFp3RDc5SFFOSi9hSjhUVGtlU2NpTXBRWjJHSTNpSVZYUFNxY1J1?=
 =?utf-8?B?L3lWUU9xVWdOaTkrRlV6TnhLMWp5OFRuOGRNcmorY3lTL21wRDhtQUV1VGhT?=
 =?utf-8?Q?QhNKyUfFT46WxeVrFsH5BY57x7s3yWu6YzmPAbI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEZiQXV2cmE3d01TWVZ0SlF1L2lQWHNndFZvWmYrN3J3L3ZXNm5GY2dKQXJ0?=
 =?utf-8?B?cEFKeG9Vb3ZqUG1MR1lvOEVTc1VOS1YvNnd6WGVZcG15c0RyWEpwbWxCdVl0?=
 =?utf-8?B?TlJ3K1JTMzlXTS93akxheEJQRFJPMFQyTDY5NjVINGNsVnI1WVJ3aWtFaGJs?=
 =?utf-8?B?VGFuVHJFanJITWJIcHJRamZZR09EcDAxTk44czduUzVFQkpVWStzeWFPcCtC?=
 =?utf-8?B?aHBPN0R1ZDNudG1tN29mc09SYy90U3VGbVFLNHd4MXFXaytLaTFnNlkzcWFt?=
 =?utf-8?B?eGVNYTF1aWRSQW9PakFlMktvSWlmQm0vSEZRQzdXSkI0bmUxYnVDZWtkc1NT?=
 =?utf-8?B?NVJrSUw2VlUvNWg4WFVjZ2w3UlR4TW1wblgwUW5BVWRCN2d5L1I5YnUxOXI0?=
 =?utf-8?B?SGcvRUw0WGNrVHVsYktDYXhlOTA1YXJ1WFBLaW51OU1adGM4bHNJaDNnNnJH?=
 =?utf-8?B?MFBzQUZkWVJoTUVHa0dtYzdCeWFvbVk2Y1BLL3dMWHJKZzdsbXRSdEFkTDQ1?=
 =?utf-8?B?NlErMEgrNG4ySVdXMERoQ1BXU2UrdFhUM2ZTSmo2WWJiNUFuNGd2MmZ2QXhI?=
 =?utf-8?B?MWRZQlRBYTlNOGEzakF3ZVBhd0M0dW1RY09oY3VVaXVjTTZoSGZDYzhaNDNP?=
 =?utf-8?B?NW1kanVOWUI5bWlsM0Z1aGMyYUpZNHZYWUtxOEx0VXZYT3JBWit6eVlmVUZT?=
 =?utf-8?B?TTUrR0Y5ZW1ScktXbmF5ck51NHhkMEM5S2dOb2JMVkZKYUo2dkRjN1hPc2Q3?=
 =?utf-8?B?UlhZZ0o2SUJCRE9NYlZsczlUREd1YUlkc2Z6d1Nsa3dCelhqaytNTlZCck5V?=
 =?utf-8?B?YzgyY3hzdlBHWjBJeGlXVGZhYnl5d3ZWNWJrbUVFcU9HYWhuRmpXVDIzMUFa?=
 =?utf-8?B?aExRUGNhcWpETVFPaDQ5M3MzV1JkNGVOWlRTK3BqaTgxalJ1aVEvaG5aTmpv?=
 =?utf-8?B?amQxbFY3TC9HSlF2RlR2VGdNL2ZLKzVLRG0xYWhlWTdUN3U5L0hkbjhEZjlP?=
 =?utf-8?B?WjdSMEtxSjNkditKZXo2WnY4NFNZbm5mZmVIdVJneTM3b1Jnd1duRzhSOHdR?=
 =?utf-8?B?MnQwazErby9nNWFJK1RJcVBTa3JCV1BlWkphV0xuNTRCNjdmNVBIOHdXWDBq?=
 =?utf-8?B?QmVIN2tCU2VsaEYvbXp5S3RvZVpzTmFtVVpqZFhnMXIwZjVub0xTa0NJT1B2?=
 =?utf-8?B?U3Q0MGNGSXBrOURjOEZTcHV6c2w1WGYxdUpxVTJ3SjdxTUtzYzdXNjNVb0gz?=
 =?utf-8?B?NDZOMUxVdy9kU21OVFljZDZ4MlFDMTZseWxmYzQzWFdaY1dWemNtaDI2RE1U?=
 =?utf-8?B?MmdPRFdHV1pKK0FvN21TWVBFaWo2T0w2QTBsL2dvMzNaUXZ4M2NmalpqWE5F?=
 =?utf-8?B?dktIK3prVzZyRnZTQnNCODlhVzJPRWVralVHUkN4Y2FtdkFUbllkQ041dHp4?=
 =?utf-8?B?SWlOYW55bWpPMUVjUG05OHp6NXhPaWkzSE8zeXRXTldpQzVHbGwzUjJOVjBR?=
 =?utf-8?B?UVM4ZkNVQjhPa3NsclZFZDNPbGRJQTNOZjE5MFBPU2szc0tLWDliMWVtUmpv?=
 =?utf-8?B?Ty9GbEFOdWdJWXZxS21EN1ZnN0tEV0crMUI3amlUazdhRDhGRzFBN3hXeC9H?=
 =?utf-8?B?Wk5SM09zdnkxVmRpM2FnS3g1WTJsK1pBbGcrZHpxWVk5ekw1RCsyTWJxdGNk?=
 =?utf-8?B?bjlUVnpUNWNzcnV6WU1FU2h3N0thTnUwcksydDgvQ3o5djQvdG1YYmxCcVdV?=
 =?utf-8?B?OFZxRHI3OGYrdkorbVUzbjRqNkxmcjd4MkNxY1VDRjZuNTM2YlBDOUF6cVBL?=
 =?utf-8?B?bFhnTU10KzhTVWtwaEN6dXJHUlBoRU9sdDcwbm80WXI0L1RSWExDK28vVzVk?=
 =?utf-8?B?ai84aHYraCtxN2JzT2ltZURuTENqWHgwNzl4aE96Qkt3RDN5TlpwTVNLdGxV?=
 =?utf-8?B?cXdnQlVERE5uV3ZXdGFuL2NGQjJRUnhFMTV5bmdOMzF5VXBJbXZHNVpwQk5R?=
 =?utf-8?B?OVZMWFNQM0NXRGFic0FFY05uOE81MVZwdDBaWXlINjhXaHdyZlU2Sk52c05k?=
 =?utf-8?B?Zy9ZN2ZIK01rUHpYM0JpZ2Z4WFdhc1E1SmFqS2lZTkc1Rk1RNFlIWWdTazFD?=
 =?utf-8?B?TXM0bSt3cFlKczlLYnlJUXRMRDRDckhGRC83ZkRyKzhKeW4zSmV5Y0xLN3ZP?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dw2Ic4imKh1QoqgQdLRkwe6275fcxeZ3Gz1tyXlCGeGaNILcwIa3kEgHeZSJHvRRQbYVKr1CctoDmrMUGigFpOvJroazf1kaAbzkuxvwAMeS2keS7x5tC3q2X4RtlG09+8XU3ruqD4lG/5IvI6Nb+UKMp0Ic/Ri0h15OxoN1SDu+7kxzn9CrreQwNamtjlVNIEHc78Y7RXPbdFL75+akh1+KCWFverbNcX8wdGW6Cl3cgyQULZQd1kuBMxd1GmeCjHB9iHEnfh0RERuVrfiZKt2WaXA5sEGsIDj7V5lZQNt6qQoPO+/M2rcTxEqkCuROpYys3NQqONX+WGtmdsyTsqspVM/CiyOL+mMp+uU33x8oyeDJZerphl4PoT5z1g7UqKXda9dfVhoJmJGECeGzysEw6JyshRUUeDiq5F6GfUN4lQx2RTETTUzlLpkA8CNpig49i0GXOfuPYWWkMrkupz9TLola4IpSCKrhITyFZfayUU1ZMNS4fSQej2s1pJkIDTW8Eeis1RDUwOrTjlBF/INmkVM9WLijItvlVbNHplJ49fyTDmHiK3XBhnRyT5L9WeROcVMyvHr809uh7CQkiZ1z1RuV4J98nZT+ANzcMqU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3567c8-faef-41bb-eb50-08dcf3a15b1b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:29:12.5505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr+wIdlNn1gmKXyYPhboTBe64Gx+i4ULVecTIhnDhCQTkO/hz26C0q+9a+J3uV9LC80HOzUHI7vLaNiZIFKtrlOHCcvlquk+FZMXHi+aNq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230130
X-Proofpoint-ORIG-GUID: 0kpENWuxTmiTUKondh7AHeEBFdZ8Uu6-
X-Proofpoint-GUID: 0kpENWuxTmiTUKondh7AHeEBFdZ8Uu6-
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

On 10/21/2024 11:19 AM, Peter Xu wrote:
> On Thu, Oct 17, 2024 at 08:14:05AM -0700, Steve Sistare wrote:
>> Make all global and compat properties available before the first objects
>> are created.  Set accelerator compatibility properties in
>> configure_accelerators, when the accelerator is chosen, and call
>> configure_accelerators earlier.  Set machine options earlier.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   accel/accel-system.c |  2 --
>>   system/vl.c          | 34 ++++++++++++++++++----------------
>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index f6c947d..c8aeae4 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>           ms->accelerator = NULL;
>>           *(acc->allowed) = false;
>>           object_unref(OBJECT(accel));
>> -    } else {
>> -        object_set_accelerator_compat_props(acc->compat_props);
>>       }
>>       return ret;
>>   }
>> diff --git a/system/vl.c b/system/vl.c
>> index b94a6b9..bca2292 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>           goto bad;
>>       }
>>   
>> +    object_set_accelerator_compat_props(ac->compat_props);
> 
> This is the probe/preinit iterator, might be good to keep it simple to only
> make the decision of choosing one accel, then move this line over to
> configure_accelerators() at the end.

It's actually simpler to leave it here.  Hoisting object_set_accelerator_compat_props
would require extra code to derive the ac parameter.

- Steve

>>       acs->accel = accel;
>>       return 1;
>>   
>> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>>       parse_memory_options();
>>   
>>       qemu_create_machine(machine_opts_dict);
>> -
>> -    suspend_mux_open();
>> -
>> -    qemu_disable_default_devices();
>> -    qemu_setup_display();
>> -    qemu_create_default_devices();
>> -    qemu_create_early_backends();
>> -
>>       qemu_apply_legacy_machine_options(machine_opts_dict);
>>       qemu_apply_machine_options(machine_opts_dict);
>>       qobject_unref(machine_opts_dict);
>> -    phase_advance(PHASE_MACHINE_CREATED);
>>   
>> -    /*
>> -     * Note: uses machine properties such as kernel-irqchip, must run
>> -     * after qemu_apply_machine_options.
>> -     */
>>       accel = configure_accelerators(argv[0]);
>> -    create_accelerator(accel);
>> -    phase_advance(PHASE_ACCEL_CREATED);
>>   
>>       /*
>> -     * Beware, QOM objects created before this point miss global and
>> +     * QOM objects created after this point see all global and
>>        * compat properties.
>>        *
>>        * Global properties get set up by qdev_prop_register_global(),
>> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>>        * called from do_configure_accelerator().
>>        */
>>   
>> +    suspend_mux_open();
>> +
>> +    qemu_disable_default_devices();
>> +    qemu_setup_display();
>> +    qemu_create_default_devices();
>> +    qemu_create_early_backends();
>> +
>> +    phase_advance(PHASE_MACHINE_CREATED);
>> +
>> +    /*
>> +     * Note: uses machine properties such as kernel-irqchip, must run
>> +     * after qemu_apply_machine_options.
>> +     */
>> +    create_accelerator(accel);
>> +    phase_advance(PHASE_ACCEL_CREATED);
>> +
>>       machine_class = MACHINE_GET_CLASS(current_machine);
>>       if (!qtest_enabled() && machine_class->deprecation_reason) {
>>           warn_report("Machine type '%s' is deprecated: %s",
>> -- 
>> 1.8.3.1
>>
> 


