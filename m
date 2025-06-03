Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243B3C5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 19:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMXB0-0001fd-Sd; Tue, 03 Jun 2025 15:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXAz-0001eg-3C
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:19:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uMXAv-0001vy-Cf
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 15:19:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553HY16D032254;
 Tue, 3 Jun 2025 19:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=6Z21hCAijHglgQFi2Y3wWw/btD+rK95H3SNaLxQxcPA=; b=
 ZHm0Ja3U6u5HGjAOChViindzlGdWPaA7LKW2zp+Ged31Ut1HR53B7Jrfgd2zYqVV
 fe6SLcqrv4Pehs2juowfXnc739rM1aJCQXb0dmfUabSJA31Nvw6GtHrA24N05/Fv
 PG8KY9dx4TbdgDJwU3JSht+6LNr6Ip6ZJu4aKLoJdoKZdBjLnkGUKFFcng75zkch
 0yrZbx9qamt7ZYAmtN8oRAXJTqNlv2qfUF/bZbs0NwPcGRNfEXKL+0pnqXOpiyJ1
 slTU6jSD06dA/1qzl3rDDwRHEQeoF1aRc0p6tlzYZKbFU81cTX5VQEsnHU3oNQML
 MWKlv0SLnjebPVuqgHY5jg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8gajv2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:19:43 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 553IqSO1040638; Tue, 3 Jun 2025 19:19:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7a32jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Jun 2025 19:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBXq8Y+bZ5ymnEggqDySr3oXR/QrJZRLly4RtczUtMMv3Xn7x/plA4P9xjhz+2WCnmn250xS5vHmMe1ciIiIJauKA3MK7zGbdMkKxsL+toxL69B7zzpU6GxlHq8q9DS1yZk+OYC1wn/bKamPFQmLwWsA+lWQoVyE3YazPS79Oe16V4OrKWeDR8mHcwvr/HRQ1A02f+1NoEdID1Q1YrWHiFcgOOdBFFVkxcGY55OvRpl0hcSANigDtzgmvHjf27Rp8yChKKikyAa4fEazuP9VyJXC21koVnflqOTcjB7WWpPtAXDhrszFEqarn1j3E5KW3CkbiH7TimMdu4nHPicfsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z21hCAijHglgQFi2Y3wWw/btD+rK95H3SNaLxQxcPA=;
 b=If7YhiuDISH2EP2dZvjmaM8bc2O5CAwLdpmMVVnCELaBbhpWP697exFY5k3wI/kj5G5zLM09+Pn31CYbO1cGOE6iQHfz325zAOXgAOgMSaHEHzWVIGzSb7fxAH60VqYvuRtSEAFe7HC39XXDvUPTFufDxyWfAcMG15pU2pGJf3Bwbrtb0MKQxkj5DmrLybMfgHxRH2ngSkOhqPRWJRVEi33rhLEVtQftM1aw2SeRCQ6BYwEqhw0of6HD2uiUihbvCiHNkJSypTRMgCVBOdEJJODvXJXu3HebwrZKOaXhg+XGXDxqbV5OLrrHWd27hZdT/dRBEp3IIeqEIQHpTwV2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z21hCAijHglgQFi2Y3wWw/btD+rK95H3SNaLxQxcPA=;
 b=b9JP0sQQ2GO90bCT5Xhp6lF4vrFE9aM51A7sAHHJB2Zw0lA45y0eHlk54A1tk/qN6yXWxJOkwhquYC7WI3eX6rV9zpCIh+dp5VoXuB7ol9mh82vpSgX4Ev8o2GXdEh5Pp/6Th1L73Qh041/e77LPtcAlEdpFCct/UuNAhN426dk=
Received: from CY8PR10MB6851.namprd10.prod.outlook.com (2603:10b6:930:9f::11)
 by SJ2PR10MB7656.namprd10.prod.outlook.com (2603:10b6:a03:53e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Tue, 3 Jun
 2025 19:19:38 +0000
Received: from CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc]) by CY8PR10MB6851.namprd10.prod.outlook.com
 ([fe80::a218:72a4:83b2:56dc%4]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 19:19:38 +0000
Message-ID: <59ce5b36-4b97-46a5-8b25-727e9575c75b@oracle.com>
Date: Tue, 3 Jun 2025 15:19:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] acpi: Support Control Method sleep button for x86
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, mst@redhat.com,
 anisinha@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, slp@redhat.com,
 eblake@redhat.com, armbru@redhat.com, miguel.luis@oracle.com
References: <20250528163545.2143-1-annie.li@oracle.com>
 <20250528163917.2167-1-annie.li@oracle.com>
 <20250603145206.4e54876e@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Annie Li <annie.li@oracle.com>
In-Reply-To: <20250603145206.4e54876e@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:208:15e::22) To CY8PR10MB6851.namprd10.prod.outlook.com
 (2603:10b6:930:9f::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB6851:EE_|SJ2PR10MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c02155-7bd8-416c-260f-08dda2d3955b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGlrZ2Z4VFhsNG9FalFnbDB0anh3NTVvaWRtd21zNHZuRW85QkVRUG9wcFBj?=
 =?utf-8?B?enZnS2kvSDJJcTlYMWJNMUFlZU1icHNXWTgzZUsrUTNVK1hUSkFOeHhIN0U1?=
 =?utf-8?B?VExhSW1FT2JnVzlmOGNmRU8xZ0t2bEh1ajhxSGY0SUpZWXRycVFKc0hodEtJ?=
 =?utf-8?B?b3ByQUMvZ3BybTM4RFBLZzZDekFmN0JIZHh2QzZRUWppY3lqa2YyOTN1WTJi?=
 =?utf-8?B?d2NpcllKaTRGdzdGOFNpNTdncy9weVI5M2p0SHZjZ0JPQXI2ZlNPeStIT21G?=
 =?utf-8?B?QnBST3lXcFMvTnUyUFE0N3E5UFhtQTVpcnUwK0xscUR6dFBOdkhjOTBzL21u?=
 =?utf-8?B?OHdEMXdqZVNPTDFZOHFUMG1kQmNRT1FjMkZIS2paeGJKSlNJQjNremhQVlRR?=
 =?utf-8?B?R1pwNGhzVndNUWMyQjFxM3RVQ2wxR2tldlpQM1RxZEFmQVNMcGJ4ckxJOWRO?=
 =?utf-8?B?ejNxaXB6dmFRQmZvMENWUk9iOVhPQ1dYZ2RXQVFacXhkZDlCMnVyZ2dXdENj?=
 =?utf-8?B?SHNqUlhYdnc3OG1IMEs5UE02eWU5bGx0RUtFUnVTWGQ4SGppZFE0V2RsYUFk?=
 =?utf-8?B?MmdSUHo5Q2pZYm1nMWJ6L0VlZUpCcHdVclIxNzhFcDVLTm1hKzMyNDVzdHpw?=
 =?utf-8?B?VWZ2aDBIUllSMU1kVHVxTVlseGVWdTdNTTZ6VGhKZEtNcHhsNFllcEljYnZD?=
 =?utf-8?B?YlhadHNFdk0rd1diSlFwMlp3ME5QRG1DZTJKWU5MVFdkN0kxOXY3QWxIbkJ1?=
 =?utf-8?B?M3JWNEdYZHFQOUhyR0p6UjZ3bHVOMlF5WWJ0T0FicjluWEJMVXB4azBKdUMx?=
 =?utf-8?B?UkJkMHBwajk0bk1SSWJ6VnZqeDZtclU2U09zQ0dmQW1tSElZa2l5K0l6Tkov?=
 =?utf-8?B?dGNvalhEMTFZdituUjUwWkhLV0N4TWUyNHUvQzdPdFlmQkw1TlQ0d0lhT3Bx?=
 =?utf-8?B?WjRhNXlpOTdSV1lyVFVrYm5IaFlid21od0Q5UGliV21RR0R0cWFLL3FReFR1?=
 =?utf-8?B?RWVCKzBBQVpuQjJWSmVVMXBsSjdWU3dVdEc3Wm5yaEJ1V0t1dFZEbDNaTWJE?=
 =?utf-8?B?dU9Ja09kcTdWendxVHhldWpyQk9RNDFYV2lBZ3c1cUlPNGpML203UWIzRElT?=
 =?utf-8?B?ZCsxNmVPeGJDd0hjQ29tTzFxUmdkcVM4YkJJb1ZQWW5OS3B6dnRqcXVKNEQw?=
 =?utf-8?B?MWtuV21vSjBoZG5jM0k2bzIvUUppU0dOMnRJbDlLSm5kdndkT3p0aUZPaXl3?=
 =?utf-8?B?UzY5Uml5NUV6VHV4TUZlNGVQc0c1a3pCQWhmTUw4YVAreWxkVTRueHgrSWJ6?=
 =?utf-8?B?M3BFNk5HRjIzeVRDVjN2KzlsVUZub1JGV1czQ21GOG9BUnB1YS9yd2JUVEJq?=
 =?utf-8?B?RkVNT1R5USt3dy9OZHJhaVcvbHE3TFVqZEp1RUhodW43MEc3cS8vMFQwZHpk?=
 =?utf-8?B?dEJpbXJtNTcxVHFhajhSamhCaXhYSmNlM1IvM3dLdlJ4a2FwNTQ0UW5ya1Iw?=
 =?utf-8?B?QitGQWhlYTNJMEs1cGFOWWVud0h4YzlJVlVmeVlacklUYVRpL0w0c0dPVXMv?=
 =?utf-8?B?STVleDQyR0duYXJORFNiazZscmRpZG13cSt4aVEya0htR3ZKelBwdE80cnZH?=
 =?utf-8?B?YnQwa2ZqNGJkaFM5bGJpYVArSlhyMXlJWCtEckNVN1ZWU0E5NU1vc29XcFRz?=
 =?utf-8?B?SWhGK1RXdXB2emtKRGhMb2xKMm5peXJTSld0d2l2K2x6ZC94STNLMElYaXVG?=
 =?utf-8?B?RTJDTlRReDFhdjFJY3RyT1I2ajM4bnhta0RmUUJzL2g4Tjh2UjlhL3F6S0ZS?=
 =?utf-8?B?ZmxZTk9vNDFWRDhIQmdOZzdmUkl4dEp3VmpTSk5yemNjM01LcmpMZUZHdU15?=
 =?utf-8?B?UERFT1QwWnpsck9ieVpGZ1FHeTVsNk5lK3doYUNTS2lYZjJBWjlieVVXTGZi?=
 =?utf-8?Q?R/QE4A8JJaI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR10MB6851.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTdielMxMHVhMXlsT2JpVHBxWkoxdVBDU3ZEejZFK1l4ZEdlQXQ1S2g5VnVr?=
 =?utf-8?B?b2dRUU5zWWNBMENLTk1uTHNTNWhFZEIxMEZrbWtubllnZms5a0NpT1AwZWVR?=
 =?utf-8?B?TVk4NUJsWWo2c1kvdDBaSXJPYTNETkdtNEVXOS9JTFdVZXdqdDVQWHh5UnpS?=
 =?utf-8?B?VUdTV3ViMng2TFJoRURKVEZEVnZka1J3aTFyUXBEY0FEZTFFakJjb1l2dy9p?=
 =?utf-8?B?bklkaHZHM0d5ZG1ZcTN1UXdUMU5rWjAvWDJKMUxQY1kycUljS1lTOVpUbDZJ?=
 =?utf-8?B?dXBQbnp6TUxwMExQbHlMMFZaU3ZiZzI2b2UxQkIweHNBaVpteXlHTE81WHR4?=
 =?utf-8?B?ZDlJdDhTMjk5OVdDQ2UxcUFHTzhPRW40U1IrQ01ZdmMvRWtDbnhqc3lWYzNr?=
 =?utf-8?B?anFXenkyV29hNFhHaUphSVZwVUx5OFlrRGxiWUs2dC9HOFp2cy9SQ2prd2ZC?=
 =?utf-8?B?cmExdWdPdzFEdmMwVk9DR0RQci9FVlByWWZNMHlQOUV2NndhRWRMb0xVN2xQ?=
 =?utf-8?B?cDBVNmQ4czJvUXlrNkdIUU1hSHFJNktJUDJnR1I4QlRuQTZyRG5rK3lFWHNa?=
 =?utf-8?B?cnBBUkRrbzJmNHFGR2ZCT0tFckw0anFCRGRab3hKMkNHNWZLUTBjMU92YzhP?=
 =?utf-8?B?b1NYZGM0ZTFnK3lBYjB3SnhwSkNDQ1A2ZE5HNlltTS8veFN4bGpIYUU4dm9L?=
 =?utf-8?B?RE1CMGw5TjU3aFdXL2VuR1NIbVhuQ282SHh2d0JmMG1zdm1mcmhkRDFuWGpm?=
 =?utf-8?B?a0IzRGNneHRaRDl5M2V5aTdPR014Q2ZJT1NPL0VJdVJiMThidGY1YzdKR1pm?=
 =?utf-8?B?cFkyc0JhaEp5V1A1dmtzMTZXMkI4T29GdVdWSGlPN2lzbkllNWhkU3I1cXJZ?=
 =?utf-8?B?UFUzNHYvOHBmVTlXMVRGNXZCbGRlaGpyd1JROTNTT2xpVm55QjRZcTY3RHJ2?=
 =?utf-8?B?UWVMbFZVdWhraGs3aXIvandtdm90T1l1Tk5tcVNQa1BMQWRZeThrRHFBeEVi?=
 =?utf-8?B?dkdhQ1ZEZW5MaHlMUjJVTnFBdUYybkhDOFViSTRNWEFaQ0I2QnhTa3d3NXJL?=
 =?utf-8?B?MHViSjZJYjlQQTNwOFFYcm9RWURoYk4rc2lPd2VVby9VYWxUZlFzd3dpc29r?=
 =?utf-8?B?OXN5cStHbFdYNzlpNlgwRlNqdDdCSDY4N1ZMQ2NtTHkwNHhNVElYT3pyMlZ2?=
 =?utf-8?B?dGFjdHg4blF2SnZvTnFxeFViMHdUZ1QwbmJ3YWpTOE5vWTFaWFBOTnZSV1lx?=
 =?utf-8?B?UzA2YVB3ckwwaVF5emtYWE92WjhRaS9tZE8wcC9icDFYakhKd0RoaFFQSlZa?=
 =?utf-8?B?ZExUbnQ2ZVMwbGplQks4anR4alB2SnJNc2txaE05aktRUFdLZVpwczR2c3ND?=
 =?utf-8?B?MWkzTk1nZWRzc3MvNGs0eXBzNjU2Z1Z3SFNLSkVmOVRCL3BhRThSa2dlMzNt?=
 =?utf-8?B?b3QrOGFqOFZ4U2NEK3VJVlNNY2F2eE9rV2dnYmFvV25nSUk3eEF5NHAyRzNM?=
 =?utf-8?B?djR6MWFLTmw5R2wvb2ZyTHNhb3BFS0VQOXFxeVpvVzJKZzEweVNNeHhuQVJI?=
 =?utf-8?B?bmdISHJQRlAzWldPamUzSzJSTkpmTklvUjl5aFRQQnh3UFBNcWl3MDJjN0Nj?=
 =?utf-8?B?TW1pcGMyODhIMHlrYUpLK3N4ZlhsOHpVaEkvTEJ6a1JXMGZrZmJlVE5iVUZV?=
 =?utf-8?B?Y2xaUE9yNXR4VFQxNHZQNFJ5S256bGZqMHg1d0VnNUV6OTBvcjUvOFErd1dB?=
 =?utf-8?B?MkxoTXZTU0QrVGxHcndsRzJHSUdGY05KZk5sMmVnZ1JUUUVScnA0T2lxa2FU?=
 =?utf-8?B?Sll1SWs5NEt0RXJmR2gxbTI5amVpRllCNGZvR1pCL2pXTjFTTG1mMU1mUGpU?=
 =?utf-8?B?YmJzUTlTU0ZWQmluK1k1WmM0a0pDRWRPOUt4OVVBbW9rVElZZ1VwN3ozdWJv?=
 =?utf-8?B?L2d3UzJ4WUxwNGNIakdiaDhWSEhEM3RzbGJ0RlVVRTdJZDRQUSsrMjhwcUg3?=
 =?utf-8?B?Q2dMNGhmZS9ya21TbGNhUXRFdU1vZVFkRVJ0V0plMDNVN3NDWExZaFRUaG5I?=
 =?utf-8?B?RVRMZlNIcDllazFpK0JZZlllQU1IYkpTcXFLRlA3OWlLZFFNa2E0TE1IS09r?=
 =?utf-8?Q?uiM3RgMw3ivGz9wd/EcPZmbKj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JweyEV8V++M3j4EwU5ZL71AcwG5JGhCJ/QBe0X4pPk4MTxG7rSwcZWbM3BfScUkTg/hrKPMc8muDscrqb7pwlknYJZCjvevAYtKrLJEXFEX0osOUlZc384lZlwuVJkg+HFhEjxljpwifJIywhsGtm2ymjIeOnlVHcplGZRzuM7q6gTDXY+XlbC+nFPHRuvCIWb9Q5qsUw8reTFB5/GAWJAKUfodyk8cfzxxAyeFBQX1nL0WKlM2LeglZVRnWVX0F3qpTS4ycj9vwuCOhM0Y/mlQuCnZqOqR3B3LPHcBuZ88f2lsPpI9kU2BI65eODDz4RxTVBY8eIhw3IR7Tb3Gf8xWG+vM84wRkPfHa7vqt9lnVSdxDsbOVnIbbN37pXrvKgT1gtVq7p3rtRi0ZPhD4ieWYOfWhYJLGeHIWiHgPmNK44bt8hpGwpIZO9r2/WWgFsmaoBEEdZvfJ9B39FOdADgYIbvpySWBJrT3WOzRYnwbdIZh8IYbIJ2JzX6LtbikUCv1/0V7H92d0H0Ffkg+9VvyAgcAGb+RYEARoH+5ZDslblgjxV3DXZiNYK58rkR5JsGEVt3J1kch7LoZ79lIEpBb/Hy93zuk6f3HGU0z7p6M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c02155-7bd8-416c-260f-08dda2d3955b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 19:19:38.6069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhht3DzTuwGDakVJe4zKkeg7SFHKT3qTkAiEJa7jw4M15AQPcmTmBPlgx05o1zjw1gqaWd4EDeDkyhO/qIMv/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_02,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE2OCBTYWx0ZWRfX60wCy+1/x2mr
 Ct1wyHp956ijrrsCAECgU1OSzTzoAuf0vBRqA2QP6yEvQ4YH0LWbRP06NM4riIyJrcpYOrifb6K
 HhbFGvylqvVXMs9z2xgzPlUzNxir979P65crdTOFNwgLEfemhAWRUBiJiQkTX3SAI4HFZgc17lY
 2GMzyf7YoAj++dqk8ZkFsXt/DxV/r8wpTzpbuwTc8HBRf5HKm4mIXNTvijINa079IFCTd7RfrJV
 G0yBtndBbNBJb5VWr3yO/TR559tLGp4uOvJz3o+4zzFig3F8Aop/m3mFjrOZXr62LUXe9PgujFf
 JrcqWYHYy5qa64oX0loytkT6mNMeqbJRi7huHnEWnAZcN7eTKnB3nDEQLg70Xz6WUZG+txVQRWX
 4VUszqxVjBTqtWixuZBmXNMzezs19Rn6UiPKMY4s+4vwPXLUYblBk/VCRVuvrQviVWBmnx0X
X-Proofpoint-GUID: dwUaWlWhsQsyFSq66Wop3GB8aEYsq5u1
X-Proofpoint-ORIG-GUID: dwUaWlWhsQsyFSq66Wop3GB8aEYsq5u1
X-Authority-Analysis: v=2.4 cv=H5Tbw/Yi c=1 sm=1 tr=0 ts=683f4acf b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=vpMjqwpGjBXEjB8b3aoA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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

Hi Igor,

On 6/3/2025 8:52 AM, Igor Mammedov wrote:
> On Wed, 28 May 2025 12:39:17 -0400
> Annie Li <annie.li@oracle.com> wrote:
>
>> Add Control Method Sleep button and its GPE event handler for
>> x86 platform. The GPE event handler notifies OSPM when the
>> Sleep button event is triggered.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hw/i386/acpi-build.c | 24 +++++++++++++++++++++++-
>>   1 file changed, 23 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 3fffa4a332..2ddf669006 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -40,6 +40,7 @@
>>   #include "hw/acpi/acpi_aml_interface.h"
>>   #include "hw/input/i8042.h"
>>   #include "hw/acpi/memory_hotplug.h"
>> +#include "hw/acpi/control_method_device.h"
>>   #include "system/tpm.h"
>>   #include "hw/acpi/tpm.h"
>>   #include "hw/acpi/vmgenid.h"
>> @@ -1359,7 +1360,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>                                                        NULL);
>>       Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
>>       CrsRangeEntry *entry;
>> -    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
>> +    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs, *condition;
>>       CrsRangeSet crs_range_set;
>>       PCMachineState *pcms = PC_MACHINE(machine);
>>       PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
>> @@ -1465,6 +1466,27 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>>       }
>>       aml_append(dsdt, scope);
>>   
>> +    sb_scope = aml_scope("_SB");
>> +    acpi_dsdt_add_sleep_button(sb_scope);
>> +    aml_append(dsdt, sb_scope);
>> +
>> +    /*
>> +     * The event handler for the control method sleep button is generated
>> +     * for notifying OSPM (ACPI v6.5, Section 4.8.2.2.2.2).
>> +     */
>> +    scope =  aml_scope("\\_GPE");
>> +    method = aml_method("_L07", 0, AML_NOTSERIALIZED);
>> +    condition = aml_if(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE".SBP"));
>         s/condition/if_ctx/
> also use full form 'if something == something' for condtion
Implemented based on the spec, will look into it.
>
>> +    aml_append(condition,
>> +               aml_store(aml_int(1),
>> +                         aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE".SBP")));
> so what is handling this write on qemu side?
Qemu only triggers the GPE event for x86 or GED event for reduced
hardware platforms to notify OSPM to go to sleep. However, no writing
operation has been done corresponding to the above clearing.
Per the spec,
"When this bit is set it is the responsibility of the AML code to clear 
it ".
Since GPE/GED events are being sent to notify the OSPM, I am wondering
if handling this write is needed on qemu side? or just removing this
clearing operation above?
> and why it's here to begin with? (commit says that it sends event to OSMP but nothing about this write)

Added this to clear sleep button status per the spec.

Thanks
Annie

>
>> +    aml_append(condition,
>> +               aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
>> +                                    aml_int(0x80)));
>> +    aml_append(method, condition);
>> +    aml_append(scope, method);
>> +    aml_append(dsdt, scope);
>> +
>>       if (pcmc->legacy_cpu_hotplug) {
>>           build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>>       } else {

