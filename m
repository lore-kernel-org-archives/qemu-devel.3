Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B77CFA464
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 20:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3hzC-0006WC-SP; Wed, 23 Oct 2024 16:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3hzA-0006Vz-Rn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1t3hz9-0000SG-4P
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 16:29:40 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfbJV001559;
 Wed, 23 Oct 2024 20:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=mOToxA+yklmyT9XiYdr+AZTa7yZ8lX6Wq9yQG0n4vOY=; b=
 OmACAsxHD8OUHMnPPIuQ5hIfy/3hpUmnYgLB+ynjZrUGhA0/gwksW1FXd/MncHit
 xlYvXbaOGY/GCuLjwbx13XAoOt7sTF6XgPdFoYX28jIvaXvybuvT59hvdafNpQ27
 jZc3NiPLAzVM1x5CxaWq807ZTU530fmjeDFyVkLaGsGgzXoU5fgYsdtzO3DbxPrm
 mcvoS+vyz6zoJXc88qoq5/Yo4ZVCyHNCbyRzZJN3rv3UOIfNRGiADcPm5f5DCkl2
 7LsodA2j8TO4+nLH3Wrcf+JTfHLLBlBN0n24RUf5er1aw9GQxTD5PoDogQBwsyrV
 k0AHZr5EuJwk47vnzyuQ4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qh4u3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 20:29:36 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 49NK0tIn030872; Wed, 23 Oct 2024 20:29:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 42emh20y80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Oct 2024 20:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7/8Cz7JUGgRromoyoVa+cUfRzDbexqKGfIYHs6U3Pp4MtdjS58hp082x099Qtyp2QIf6CWHOGZ2cIEL81SvpCDfVUc1DZAnEZ/EZM2wk6Zl8UQgtKtONmh07E1xZQod8TPINvgO6poZqIIBYu1aK6yJI3BIYtJIAzMxLfHbJKok2mmEjMWBcEqeRaVNRVOyro1BziLQU7vA4hSFs5cCEmr8JTOJe5wn2iEy/08JlN2oAlM6bTd0/rhRPEGJNwpKxMNjf2KhMjV4jdmkjO8rjJzjX0DBi5d1yBp6XDyFNi/X9EE4zih3jpmsBawUcpDpRoGCUFcJDjqdoU377e3SIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOToxA+yklmyT9XiYdr+AZTa7yZ8lX6Wq9yQG0n4vOY=;
 b=W0n01REwROQaOUyilpKJft55roxzO462U+fvvANR8YUw9Ii3dITqScP9lg7Tu5/L1VBwtRVwr14G8eN1ibIoZA0kKZDK2gD3lYtRlj2zJ7z5cMkF5uFnENIcNN2VRCZzqktLR5YkmToSKlCZ78AHcH5KbnU7zueKV9drrevWiyZFcIFr3MrllVbxJlk3Jr5MHNF7KVacajvFtuqCXSgBsZKa8+PZHO0LsXy/7X+vgg7HK9+T2ZZIqB8KqI/wxEFnNipE7J1FUmnxVq77y5kLUZuZLuNBtPi8kHPimMv8xanP6N5Ya7nZgOJC4cUspXvxqQq7GJ29WdeP4VMeWPGEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOToxA+yklmyT9XiYdr+AZTa7yZ8lX6Wq9yQG0n4vOY=;
 b=wyNtPlB1TfgsARyLMMz7BnH/BpEuE5WGBURIUp4ANehmRN4sr7M2XafiGtTKlA09oLmUIRfUxVKR+07EqIULUXm1hpFdMkl2l9z0L99lAFHckswwOUOM3ynS1fGxaE0bfTv42EqmWnTf0Bsr+PVBVkZrVaJq1lcKxRHZwfg3ul0=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6662.namprd10.prod.outlook.com (2603:10b6:806:2b6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 20:29:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 20:29:32 +0000
Message-ID: <0dabc142-7e17-4b87-bb51-86b952494c43@oracle.com>
Date: Wed, 23 Oct 2024 16:29:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 04/14] accel: set accelerator and machine props earlier
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-5-git-send-email-steven.sistare@oracle.com>
 <c4ce511b-bdc2-466f-85e6-2495c0bd2f08@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c4ce511b-bdc2-466f-85e6-2495c0bd2f08@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0195.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::20) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: d2335ffd-bcf7-41c5-6de9-08dcf3a16713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVIyeXNVdE16OEpqbUdXQUhYdkFBd2FYY3kvMDJ3Z0pjRnJKYjZmU09oOWxY?=
 =?utf-8?B?dmZqc1Q1eXc2MUFYTjE1aWFpWDFPclBoSTRNMW9oMmxDZy9uWjlJM0I3Y0dT?=
 =?utf-8?B?cDQzeUp3MjRPc1NiOTUrV2Ntc053VjNqV013cGw1VWFkQWJ4L1VBS3k4TGRF?=
 =?utf-8?B?YXU4clI2c0lZMjNHMTU3TlZIOUpBdE1kVTd4SDdVVXRQUHdTNmt6c1BJUUQr?=
 =?utf-8?B?eTVlVEJRUlVSQnJjY2s5K1dPM0Uwamtnc1ZJeHZ6dUFFeGhUYkF5SDladm5T?=
 =?utf-8?B?ejU5YWd2U0c4YThDTWNkaWhqdUJOZ1NzSTBwZWxMVTFoZGZwQ3ZJZFVTdHlG?=
 =?utf-8?B?cVMyR2xEaENuc1JPYmp1bS9aTVc3Yi9PYzFTeHZoR3lzRUxlNnpwOXU0THZz?=
 =?utf-8?B?ZUhwNnQ3MXZJZXdIVXVlbURtWUZmRHg5ZzNESy9rYnVWaFpnc0lEWldmdTJ4?=
 =?utf-8?B?OHF0UHRXb2dyTTBaaC8zZ01KY3pIZFRib3dhdFRVd1lOd1ZFVXcwYUpPRFFo?=
 =?utf-8?B?QXh3LytPMmZjc00vVVNodFJPR3Y2b3VCY0RwaU1WcHhWSUNzTmp3WXQzMGRi?=
 =?utf-8?B?VllNdEJ3UEpVUVB3bWdxRVpYUGpYakhwOXNsRXMvZEF5bHZSeDNVWjlCSks1?=
 =?utf-8?B?dkxjQjNUb3JJZWpZckpJZVh5QXMvaU1KQ0x3WGZ1cWhsQ2JaV1FpZCsyanAy?=
 =?utf-8?B?TFZnb0h0MGhrVjFIUmhiUGdqcjZJYnRWS2ExKzU5dFI4L2xmZjRkOHpvL3Z0?=
 =?utf-8?B?RkxOVEd0cThGOFdoUlFoL3o0aEVPY040cXcrRU1OVlRRWGNqeHp6WllxNGYz?=
 =?utf-8?B?OEt2dEtWeFZxdSswZytLVHZ0MkZVTlJWWVozWWY4WWpQYmJzaEFxVjhNYW80?=
 =?utf-8?B?TkZtdTVWY0tPR1dac0p0R2x0a21jTVlwZE9hRjF4aDloaDVUTEZjeTJzNGNI?=
 =?utf-8?B?VHhrckFuU2UzNUlzMXNvYTNlOFZHc2xWcFFiRnZJK2lYQ3FhaXdrbkNSOE5a?=
 =?utf-8?B?TzMyR0hPUjhEOFg1NHQ0V2xLUnRidjJBNUNNYXprTjFMNElyVnFkTVdKVkFv?=
 =?utf-8?B?dEpXWUJkQWNjMG5VWjRLNmh4THZyMDhoMG5wSlFzY0w0L2poUmkxc3E0RVRs?=
 =?utf-8?B?KzcrWmNaNEUxYTRDeUZxUC8wbFZwWnlObS8vUXFaaFNiK09vSVpvQ1NIcDFx?=
 =?utf-8?B?LzQ1Rlk0b0xXK0ZrL1VITWFEckFkaTF5ejMvZnN0Ky9LQ0Izc1g4OThFdTFt?=
 =?utf-8?B?NGxLSXVaU0tGRXJ4bWhBdHFiUUNudDM2ZmpQZ1lGdkdwVU5XSFR0dzN4cXk2?=
 =?utf-8?B?eEJzZnhLekVRdmd0VncxaytseElZRlpDSzdOd2xNSlhTTm40TnlIR1lObmd1?=
 =?utf-8?B?dk9VQkM3SFdKNVp5N0Y5R0M4NEJVSW5QRnp6UmJEaURtZ1lVcWN1VlVSR3JP?=
 =?utf-8?B?emdQMG9LVStJRjk5TWVQSUxxMHNFUVhHL1ZiUVE5YlNBVkZSZ1c3N1ZwenZS?=
 =?utf-8?B?SnZlWjE3VVhrVDRQV0NaTnNQM2dBK09KRFhVeHdoczFEY1I3WDNPZWdSN2Rr?=
 =?utf-8?B?bnRHbnZwWTExaitPeUpyc2gzSlBYeDRLNnhwZ0hNbkpUS3o1ZFU0WlZvdDdm?=
 =?utf-8?B?c0JVbk1PRm9VSE5Hb0U3VzNwRUZHalRFQ3ZXRnJDRU83L3lUbVFTNXp1QXZv?=
 =?utf-8?B?U09vWG96NldRTnZjU0dqcFFSRk1rK0xPY2RLYWRScDYwVTNWbjdGOVcxTm9P?=
 =?utf-8?Q?LMPSm0vmIHrTg1mN0yltqDBYByMo/xUuUpb0axz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlBQRXc4dFdIYWZtZXRGV0NkR3F6ZjZnVDRkdFlFSTdBV1NlaG9JT2NLQ2Yx?=
 =?utf-8?B?YVd2V29aMmpmSEtHTXI3NVoyeEY2dytwLzBPdHZodCttc2pWTktncE1HL3lr?=
 =?utf-8?B?djhlcVp6Z2J0dnRyOU41azB1ek8vbWFuTmFxazkzM1RUVTJ0bzU2VXFrZExp?=
 =?utf-8?B?TXE4ZGk3ei9IMkw1SnYxbCtUYUdiRGs4djA4UEdlcWdQTE1YWTFVdmJiNERR?=
 =?utf-8?B?YXJlQk96TFY1dVBqd3ZWZnVPZDByM1hSVjlyTTBBUTlwdkRPVFp0Tm1tTGYy?=
 =?utf-8?B?dUt0QVUxRGxwVnhLS0NJN1JBUis3b2orVjRuVGNtRldJaXJ1eHFPRGJ5NzdR?=
 =?utf-8?B?SHJCeXJ5dnlOS0hscHUzMjRrK3Q0QTlVY08zdk45d3B3cmJJMEFyVks3ZnY1?=
 =?utf-8?B?QWhzQi9zWjA3RXc5MVB3SXZzNzVCMGdUTHlxUjYwY0ZDNGMvbHZiU3V2RmE0?=
 =?utf-8?B?L1kvZXc1NERDbWhhK3o0c3hLNW1DbmJQSUVyakhSeVQ3ci9vSjhqUlgzeklw?=
 =?utf-8?B?Z2lNSm1vNU1wV0d6UHgxVHdaang1OFhsVXprdWNONjJDUWJ2ZXg1aGNrRlhJ?=
 =?utf-8?B?TXlNOVo3NTU0MXRUVzZGNXVyanFjZVpCeVJjcGJGSHZseElYVkNOTVl6UEhE?=
 =?utf-8?B?b3lnSlZzU2ttS0RjVXZLdnQwMlNCY25Sb2RQV1MzYzdyQXU1WUNwWlN6M1Vx?=
 =?utf-8?B?eWtHMThuUlRZQ3dqR1pvemhPOHpQK0IwSTJzSDhDT1VObUhocnJUQVY3Zlh3?=
 =?utf-8?B?ZTM2ZWVNU2x2ZFFTOVJnWmtKZ0wvK2RwR1R5ckhocnoxK3pOWlRUNC9DeW5T?=
 =?utf-8?B?aVlsNkhjby85dVY3bUphd1J5c3dBVW5XY1ZkY3owZWdORngvQUlHUEppNFVk?=
 =?utf-8?B?aDAwU3M5NExHUHM3S0ttWWtFWTJGNmkvVHdoRUlRR1lLSCtLbEF6bXhMZ1Jl?=
 =?utf-8?B?ck9pb1BOTkZWbXNNMXBMelVNa2hmWTJ1S2FvcGtWSmVxbXV1dXdmaXlwOXNz?=
 =?utf-8?B?R3VOcFpYbTBHeHVTb3FQcko5UFpBam9FcFlTNkZqUUFZZGZCblFZMWJLLzJi?=
 =?utf-8?B?QXJETUI1VlFFSjU3cFIrUVZ1L0RGelY3SUZzZkN4QzdvYzM0ODBuUXB5ckp4?=
 =?utf-8?B?c1hKeGxSNEIzZnAzcTBxQXVRQW5yTXhUVmxOeEtERWxCZjM3eWs1TUt0OTRD?=
 =?utf-8?B?Zzl1QkxoRElBTlhCMktDVnhGOW1ybXFENlp3bnZQZG94M1R5YlNwK3R3dzFM?=
 =?utf-8?B?RjRwb2puS2JVTUdseEFiTXMrSXNZTUN0dUFaakZmUWJHSWZ6elk4VldRMGRL?=
 =?utf-8?B?b2l6Q0NsVzNXOWZZM1p4dHNkejdiTi9rZG0zcVRmaTMxeENiN2NoL05raGtx?=
 =?utf-8?B?UFEyNFRPa2FMdlEybXNxQ1VCanN3d01UZGwrcEVheUV5elpIaEtCOHJUOVE0?=
 =?utf-8?B?NjdWbStERkhqRk5JK3ZrREJFSmorSFZLNTVGc3FOMmFUb05iWXNIN1VzWUNJ?=
 =?utf-8?B?VXg5YmpIdXB6N25ITVAwZ1h4UDc4dFEzVnhPNHFwZVljelMwSGVnK3VjZi9i?=
 =?utf-8?B?VVdaZXZrOXFaVmlDQVIxTW96M1NiQTNVSTg3SzIxd0tFc3NEa0JSdXd5UWhR?=
 =?utf-8?B?UmVhVEZsUWhzYkxBNTI0OVNVdER1SDFLRUlONmMyd1cxME05KzFOZnRmRGpm?=
 =?utf-8?B?ZnVzNlkwaDhxM09iWDViNlE5TkxzS1ZjS3lsWXpwWXEvRW9vQ1Q0THVoNzlO?=
 =?utf-8?B?YUVIQldRbUwyWEdnUFZ5SFVUSm9PdGFyNUNtTldLUE9lWjNsVldkdmJvV3ND?=
 =?utf-8?B?UDZXSlh2MVBuaWZYOVJOU05QM28wdFVITi9kZXlmVFZTclZVMjF5QXB1R3Bq?=
 =?utf-8?B?Y0NqV3FOeTRTWDFTUlA3OFBUQUhJL1FWaURHYlNsVjVENXF3WHFwYXIzQVBG?=
 =?utf-8?B?WURJazR5R2xZTVBhQ3NHRzdHMEdibk85UzROZWRLRW1rZ3dxM2c0djVWOVlx?=
 =?utf-8?B?cWtHTHE5clBxU3dXeVFpOFRWRi81Uk5NNEZhWWU0djdEUk1idEJFMDVnWGNo?=
 =?utf-8?B?aE5SMGNyQlg2VG53eTFOSFBBU0VhYTRNZFBFaFJFYzhOMGJEUEdPREJnNzNQ?=
 =?utf-8?B?SXRIdHh3RHpORllSbGlIT3lIVFkzL1ZwY2FSaXFUMm9WT1BoUGZGU0VqbzBo?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ds0UqD1xBJHUd6hACaNUJagXRGzBSIP0oF8bLYWF1dVih0DNBZqgPbR4rO9w78+xQq06PqerX6P/XDLphyEN5v/hfE+UgFlSi+EP8Ed3jH/L2ULCELmtshsH4Ub9ioayBsou06HfxEhdtgE3+26xUOLbqRhX+EXrazqCnFm+r6WC0FXKuCSeYO+OnU7guZuQz8dYqIEtbZP2RGQ1uYQ7a2yZ/m7IGSZmDYWOm1sYFQzD8Kd+RzB55dmRVxHPOqNiy8buknpmBxAKBxT7Rzx4kRcPMhj7EzLOXzHIdYlv3/hHme6xniW+joThXxu91PdcWymo2GXOHz8nNpZkLz/6lNIQ1yfDChrQ9WRfQeCapf5Y3d4hm9krx/G0jjtQL3/YaPLvhtjzbrZUgXNfe8tbgiPpTwnyVjgtr4EoS0xGymNbrO/b287ikTlO9DWKEriDfCH3tjOvaoQY8hIAvLX1qgqL2iHreSuLQ4GVrfIBa3ZdEZn7sxkhLXnGxxisz2RCojAhu2+NaZU20RqK3vERreGQQZuMTBnz/2P5gu817bna7dSLdhuMwIMlLHCBCJaS8hPRcdgxZD9AGiEz1/dl840Bqv5MJLvDvt2ZladzUbk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2335ffd-bcf7-41c5-6de9-08dcf3a16713
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:29:32.5991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3kD6C68CBcIjEqySyfkKNNL7B4JrFFAH9Rx/ACjU6AJ9YNbtJJWXyZMl+djCZ9ceygILwBPJVXgMPeEyxsGepEyFWt6lbjSO8frz6wjAJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230130
X-Proofpoint-ORIG-GUID: 69S2aXu3OQ1JkBRiEo40iriOuvWg_2l_
X-Proofpoint-GUID: 69S2aXu3OQ1JkBRiEo40iriOuvWg_2l_
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

On 10/23/2024 12:00 PM, Paolo Bonzini wrote:
> On 10/17/24 17:14, Steve Sistare wrote:
>> Make all global and compat properties available before the first objects
>> are created.  Set accelerator compatibility properties in
>> configure_accelerators, when the accelerator is chosen, and call
>> configure_accelerators earlier.  Set machine options earlier.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   accel/accel-system.c |  2 --
>>   system/vl.c          | 34 ++++++++++++++++++----------------
>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>
>> diff --git a/accel/accel-system.c b/accel/accel-system.c
>> index f6c947d..c8aeae4 100644
>> --- a/accel/accel-system.c
>> +++ b/accel/accel-system.c
>> @@ -41,8 +41,6 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>>           ms->accelerator = NULL;
>>           *(acc->allowed) = false;
>>           object_unref(OBJECT(accel));
>> -    } else {
>> -        object_set_accelerator_compat_props(acc->compat_props);
>>       }
>>       return ret;
>>   }
>> diff --git a/system/vl.c b/system/vl.c
>> index b94a6b9..bca2292 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -2346,6 +2346,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
>>           goto bad;
>>       }
>> +    object_set_accelerator_compat_props(ac->compat_props);
>>       acs->accel = accel;
>>       return 1;
>> @@ -3728,29 +3729,14 @@ void qemu_init(int argc, char **argv)
>>       parse_memory_options();
>>       qemu_create_machine(machine_opts_dict);
>> -
>> -    suspend_mux_open();
>> -
>> -    qemu_disable_default_devices();
>> -    qemu_setup_display();
>> -    qemu_create_default_devices();
>> -    qemu_create_early_backends();
>> -
>>       qemu_apply_legacy_machine_options(machine_opts_dict);
>>       qemu_apply_machine_options(machine_opts_dict);
> 
> This makes it impossible to refer to a backend in a machine option from the command line.  While this is not done for now, it is not a limitation I'd like to introduce.
> 
> Could qemu_apply_machine_options() be moved after configure_accelerators(), 

Yes, but why?  I don't see any dependency between the two.
Keeping the machine and its options together would be nice.

> and phase_advance(PHASE_MACHINE_CREATED) with it?

Yes, I should phase_advance to PHASE_MACHINE_CREATED right after qemu_apply_machine_options.
I added PHASE_MACHINE_CREATED in qemu_exit_precreate for no good reason.

Yielding:

     qemu_create_machine_objects();          // TBD
     qemu_create_machine(machine_opts_dict);
     qemu_apply_legacy_machine_options(machine_opts_dict);
     qemu_apply_machine_options(machine_opts_dict);
     qobject_unref(machine_opts_dict);
     phase_advance(PHASE_MACHINE_CREATED)

     accel = configure_accelerators(argv[0]);

qemu_create_machine_objects is my proposed fix for the canbus dependency,
which I know you are not keen on.

- Steve

>>       qobject_unref(machine_opts_dict);
>> -    phase_advance(PHASE_MACHINE_CREATED);
>> -    /*
>> -     * Note: uses machine properties such as kernel-irqchip, must run
>> -     * after qemu_apply_machine_options.
>> -     */
>>       accel = configure_accelerators(argv[0]);
>> -    create_accelerator(accel);
>> -    phase_advance(PHASE_ACCEL_CREATED);
>>       /*
>> -     * Beware, QOM objects created before this point miss global and
>> +     * QOM objects created after this point see all global and
>>        * compat properties.
>>        *
>>        * Global properties get set up by qdev_prop_register_global(),
>> @@ -3765,6 +3751,22 @@ void qemu_init(int argc, char **argv)
>>        * called from do_configure_accelerator().
>>        */
>> +    suspend_mux_open();
>> +
>> +    qemu_disable_default_devices();
>> +    qemu_setup_display();
>> +    qemu_create_default_devices();
>> +    qemu_create_early_backends();
>> +
>> +    phase_advance(PHASE_MACHINE_CREATED);
>> +
>> +    /*
>> +     * Note: uses machine properties such as kernel-irqchip, must run
>> +     * after qemu_apply_machine_options.
>> +     */
>> +    create_accelerator(accel);
>> +    phase_advance(PHASE_ACCEL_CREATED);
>> +
>>       machine_class = MACHINE_GET_CLASS(current_machine);
>>       if (!qtest_enabled() && machine_class->deprecation_reason) {
>>           warn_report("Machine type '%s' is deprecated: %s",
> 


