Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B3C4451C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 12:08:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWzr-0003t1-DY; Wed, 21 Jan 2026 07:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viWyi-0002xY-NH
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:06:34 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1viWyg-0004TM-6d
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 07:06:28 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60LBFJoX555478; Wed, 21 Jan 2026 04:06:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=qYwu29swCal8YayiofIX4XaM+l2Abceg9zXWjN6Cd
 P4=; b=frejHEuqyGfDm+xNePsa2lYJ5SEG0vGbSjfWVxw+V0VTAjmC0VLtaOWLo
 DgTrDhaXjOlU5GO+pj5hLgIyzzehQKXNo6XeHEOkT+f/wGrFNKRixHbkE34/ihQi
 VSIzzLt45+FFwG+pixuQdQCYIoe2vgIuwTf4yaYVGPRXqs6gLUY0Ep7625Cev/+t
 gZmgCLREnwuSj5/j9NMXIsyVMGBEh769B1voXoyLZX6UpLPPOI9C9eKogYKhwzRw
 IEes5tsd8h9ydur5JMlFBYaZegR53Qv/OqVu8BF+neTnbkruBY08H/eoiw4DenGV
 W+75TZTGtbY0LsV8gSSTbgrAP74og==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11023098.outbound.protection.outlook.com
 [40.93.201.98])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4btddy2h5e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 21 Jan 2026 04:06:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs/C17owxcy+BX86dOO5Wj+T0Sm53oT+g4bx0EyOgUd1+GH9rfEfQ6E5juDnFt5N7Y083l/jxk+r4z6IYorrdBwuGoWvl9AfQkvQWaHyaXNQWvSifor2ibhDJhdhNCLjXfr3Od4thYIRKLuT5xnziusTqrYec200OtRqIE7m04N3QUmMnkLhh2n5Fyo1sNJf8SX2snrcSiPgyBJ1EOVq+/RqdzZtGlC74qFl5cmflxoaDTx9Pg9BTb93V7BVP2d/oElND+yZAnggUQ1VGTzo60OhP3+wThB+NYLuLkWF1zhJyLthWQyXLXVVHd35IV2X/QScZizrRSFRuaZ42n6hIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYwu29swCal8YayiofIX4XaM+l2Abceg9zXWjN6CdP4=;
 b=GVeNhcKU1Uj/8SWWh9oWB+Wj7yOo/RmkIPDZAE1aD0n+MUbC9Vokz8moNaMR7GkfQyRC1vYnkJpHKH1MSEby3WG/HhdgTaUEvxGFmGp0iayQaiTrYlJFxPoaHaCd6gsFRC7llVRFc+IOiRfOF9X04+dWFYmV2LyskKe1iCenxjZdXFiKAZMYAU1F8WQOxdanHB7LForO+B46DxhhqO/Te6HQ8Gn+s314CSmoCKCok/+wCRgFqQw+Oh1TL+MPIU71Cjj00PeSxGODLS3k9krb6oQpZ4oTcapt76oaFFcUKZppOZI13/APLXGbkuBxp61lEsnogerk1rRZ1i+fHLyEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYwu29swCal8YayiofIX4XaM+l2Abceg9zXWjN6CdP4=;
 b=OQriK/QzNFYzVH+nRNJjtZJSkRL1LunDGQYIBIvNgubzMFWsf7zCx6tj2HOQpu3YUogYlW/NSzk2dS5AAX+S8G4WVJdQtlD5NuP3wzgB/qkNgVzRNhbGF0KpEl7x6Vvt53aJcFlQP+eO6n1A/lNmT+doZreVdXlWvFcH8f/fiOMcMVU5iigr6uH8iDga1UXGGaesxcDGHasZ4sWThqG7hW05/b/VLP0nrkvfKaZWVr0eYwb0Sk+0YGNiYv9Sv7N3Ax3nnfyx61/NM7uOiII/pSDdMK91zB8FEk9qFdGkDEatLY9ZgIxcfo2h1T8ig4oL9V4IOjzsbsJyEErye6ufcg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by PH7PR02MB10028.namprd02.prod.outlook.com (2603:10b6:510:2eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 12:06:21 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 12:06:20 +0000
Message-ID: <e64cc3a1-2192-4bc1-b616-0676c4798a19@nutanix.com>
Date: Wed, 21 Jan 2026 12:06:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio-user: fix VFIO_PROXY_USE_MULTI constant value
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-devel@nongnu.org
References: <20260121110055.2333711-1-mark.caveayland@nutanix.com>
 <20260121110055.2333711-2-mark.caveayland@nutanix.com>
 <21dea4e5-9a08-44c6-b18a-c7da790a173a@redhat.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
In-Reply-To: <21dea4e5-9a08-44c6-b18a-c7da790a173a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:806:122::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|PH7PR02MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b07304f-8788-475d-87cd-08de58e57d27
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmlYbVJOSmp0TGlkL3cvZWFWNDRURVc1MWR1dUE4OXNhdWxjeWRRTWpENElx?=
 =?utf-8?B?aEQ4bFo3VldNcFp5NzRmVHFUcXRoeFZwZUVKMitYblpTZkVPQWowT243aFU5?=
 =?utf-8?B?aTE0MkxvbWpqekcyQTJ1REJneUZ0OFVyNHdjZGpmQ21tckEvaGhTOFZKT1lG?=
 =?utf-8?B?SFR4MW5kUzRsSzBZMlRDcU9DR2lRTHc3Nkw4Qm9DQmp1RFEvYi96akRwMHdO?=
 =?utf-8?B?SlBnZWpaTGMrQUZZc1hlNC9ZNWZNUzA2aUZzYTFURGFLNSt2SVdBQlVsUmNU?=
 =?utf-8?B?VVlZYzBrNzFNc016Q3ROSExlUWU0UDhIMUk1MkF2S0hSUzQrR0R1OW9CNnM0?=
 =?utf-8?B?a2QrSmtLMnpyWmhNYm5nNnpMZmVrSTdsRXpvdmFRTUFYMGRkTUVaZTFMdmFF?=
 =?utf-8?B?NWZHSGNMVEpJdTJ3UWNiUXZXL2dNTFNuYTZtbjJZT2RSQUFoMUdDYnNWR2FJ?=
 =?utf-8?B?M3ZwTGJMYjE1SHcxY0JGOXlzU0l3NFQ1a044bVdZa2E1YWVtNlNUTUNoeDVS?=
 =?utf-8?B?c09WV0JsVzRhNFJvUzRKS2JEMS91bTI2T21lVk1tckxnRjI3b3BFdU94SXRo?=
 =?utf-8?B?bmRXUlBYdUNydkwvb0k0TkhFMzdQbUxjQzNhUitXTmRiNmZEOE44VkJjTWNq?=
 =?utf-8?B?dDBxaStZcFZHRmkreTN6cldRbzdadWRrUkNWZVlGT0ZtNHA0RkZ4dUduOUg0?=
 =?utf-8?B?R1loaStiUTBCV3BSVWJBR051VEY0cTJZbDh0a2syaGVVMTNxVWdFNVl1U091?=
 =?utf-8?B?V1hkdG5BSzBsUFlNT0ZvTUxYWFR1SGpsM2tDbEh6VC9LbFMyYU9PNHdDNndx?=
 =?utf-8?B?elpNdnl1YlQ2cUxTbmQ2WDBOYVBYNW5hNElBYTdtM2xkVTRXTytjc25GdnhU?=
 =?utf-8?B?N0UrRGFCRXFUVEs0eEJ4NUVIaDV6ZGpCa1llMUJFVmc4ZUgyMnRqZm9tL0NY?=
 =?utf-8?B?RHYzNUdjN1hlYm51cW1tUnVYaGtnaXh4OGMwNXgrcGtyVXdqcDNBWHNHdWV1?=
 =?utf-8?B?d1VWTlhJU0szMHBuRGhaU25sL3A1dGJGRFpLck92K3pUZThhOUNFMG1vUEdP?=
 =?utf-8?B?T2FzNGdiSzZ4aHhHQTRiUVhDaTNLZWVqR2MwTU5NR0tIMEczczhlK0tSMmN2?=
 =?utf-8?B?Vzl4VGdIV1EzMldsSitlZHlJY3Y0M2I1dWI0K0UzVVpwRGRCamJDSzBFN3VJ?=
 =?utf-8?B?cFU3NEErNzRnZlhkb21lODlIdENOMVdkMWNxa3p3TStaWGJBTDF4TWxRRjlq?=
 =?utf-8?B?TUUycmN0YkdyZHREVG5IVE9TalU5MlFzLzA2bjBOOXdtN0pNek0zV0dFSGtD?=
 =?utf-8?B?QnpjZTNrQ3RHYVFtK2dXakRaWFBFTWpSd1NUdzYrbUM5UEJveCtkSmF2eWJy?=
 =?utf-8?B?d1Z6OENjdlY4Y256em0ycHE5S2NzMXVUdjVvdnh6aEtXUzBPZFJLMUhzbHkw?=
 =?utf-8?B?YU1tQU91RlQzV3pIdDg2T1A1SDZCcFBlMTZRa284YjlRM2NwbDZHWThOQWZD?=
 =?utf-8?B?K2hWamRlb3RpMk5yVHBrRndlcGczUmlSY0dZSlZIQkl1T3Mva2VNeXNJRWFH?=
 =?utf-8?B?QXdjazF1OFQ3SkxQa2JLSGc5UmJNMndPNUlQL2tMYzkvTzZTejgrS2FqNXcr?=
 =?utf-8?B?d0VoWVREdG5hT1JScmY1VktwcXpuUHh5NFU3Rm1CZUNCMlZMMXh5WllzelVi?=
 =?utf-8?B?MEdQcFhQZjJXNTBKS1d1MnhXVWd0SVEwZlBaa2dRK1o4dHRvNE9WdG5xSDdG?=
 =?utf-8?B?ckJxYXNHc1I1aEhYZXBZVjE4VCtYSllFTHM4RkQrNy8zSDdwUzc1Z2NVZXN0?=
 =?utf-8?B?OE5CKzFVaWU5U3R5NGdCalpQWkxwcFo0WS9GMFMrMDQ3ZXlJbEVSRURjVlBt?=
 =?utf-8?B?UnBBcXBRZTF4eVp5M2t0em5hZjJqV3VqQ2h4eFBoNDdYK21BcnZ5dEZXUndV?=
 =?utf-8?B?Rm91OUVXaEhqeUlDYlI4aWVYYXdxNGxhaFErcXpRZmxwclgxb24vUjRrekFR?=
 =?utf-8?B?elh1V0xUeFFPMHVWb3A0bTFaajd6ZUlpUFZJWmNuSVd6elFvR1Q3Ly8zcVZj?=
 =?utf-8?B?U0ZiaFYxL01wMVBoM3pzbmdsVk1Yb2xsc0huVi9WSVk4OXNQdWdEajk1WDRY?=
 =?utf-8?Q?5IzA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEN1UldpY3pXVVh5OGxyQ3E0bjZXUjF2b3ZtMm9PckViNVJXZUo4SmdYai9y?=
 =?utf-8?B?OUF6Z2hsWE9lcGdGWDFxUFJuQzF6a3RZV0NuVmMwek1mMG9NNnhsSVFzbGNx?=
 =?utf-8?B?MndDZG9zejZhNTJHcHpRZ3k4YnVYUmova0RhRUZ0ZUFEZWVNNXN6YnV6UFdM?=
 =?utf-8?B?MWgrSUVaNGNCTkFEQTJrWjRQZEs5ZHQ3ZUc0aHN5NjFQNUdzdDNpQmp1Q1pG?=
 =?utf-8?B?RFlwNFZhV1o5b1dpREZLeHNweWFyOCtzSEg4M1VzZEZTTTh1eVVSMVlZQWdz?=
 =?utf-8?B?YXcrVFpWV1p4RlIrL0NPejlqZ1VtQ1JGcjd4WUFHd0dTc2s1aGpPa3diTlpj?=
 =?utf-8?B?djZ2dkRPYWZiTWlWeTc3MGFJd21LZzlQQy80VHhGa2lPWFEwazdUdGRpdHM3?=
 =?utf-8?B?QnB6di93c3hEbWFiZldvUkdvTnBvMlZVSzJYOFZuSVhhT2EvSHh5c3FWditm?=
 =?utf-8?B?dWZyMndlb0l4c0tRdE1naSsvRGkwMEVsYStYUmxtK1FnbG5qVnhybmVWOWtF?=
 =?utf-8?B?dTdiNWVnRitzejdHYlZlakVoMFpKTnBBWGlQY2d3ZDdTS3ZwK3c2WTFOb3dX?=
 =?utf-8?B?Y0grOFNoV1pINDdDaW1XbGoySDlKKzNqcW5jcnFKS1UzaHhTNmh3dDRMQXlJ?=
 =?utf-8?B?b2dQTGVKbFdYOHdOVkFJL2NxZVMxQVZHQWtCNnJ3Ym5XeW8wWTl2TlpMVWxj?=
 =?utf-8?B?aitHRHhTSzIwOXZTaWYxeW5aTjUyYThSNzA3REtBMVF4dDd0TUJRWGRMU20w?=
 =?utf-8?B?WWUwa25zSzhZZURueTZEd1ZuNUxRTmpTTzkwcmdrZlVqQVJFV2NFYVVxSnF1?=
 =?utf-8?B?S0RoTmhUemd2ZGV0bW1acUdMaW9ScWE4RG9iaWF5cFJnS1h1STFJdW01ejJO?=
 =?utf-8?B?SXFnV0ZaT3ZLTkV5VUpVV3JaZGJxcTZmNWRQMmxqQjh5TjlmcWxOekJuenc4?=
 =?utf-8?B?R1NIcTMwTzcvQkUwcWVJYUN1Sy9UZG9mQVBFMkJ2OGFNR2tLanY2NWNQZnY1?=
 =?utf-8?B?eFhKdC9lWE8vUUlyOW5vcXpQWDF5WEJ1M0FvV0VsWEdoakZmY2NpdFU2S0dK?=
 =?utf-8?B?M2RKaUY4WWdvdnc3Um9PMnRKWnptVGJmMWN5VHV1MUNFMy9sUjJ1bWM5Vit2?=
 =?utf-8?B?QTNXZ2J3cWlOYnJCZXRLRm5xWG4wNUp1NlYvbHljeDVrMUJsV2tscXJnb2RJ?=
 =?utf-8?B?Z0tvNk9ucFY2MXhPY2YrdGpxV2J0SEg4a1pzajhnNE1lT1c1Z3FES3BSWlRi?=
 =?utf-8?B?UWVuejlqR3Q3bDdZNVFmOWs4VmpSQytBanlFenRGbDJESTliN1g2VFdkNjY5?=
 =?utf-8?B?ZlNPWmRhbjJRQ2JsMzlPS1FpZmpUTTVRdDN3MkJBOHRHNnZ6Qm9RQ1gxQkk1?=
 =?utf-8?B?TmVRaVpuS2UxVURqcSthMllaaFpQWVdwQkljZXJ5eWs3TkZRYjRCV1BWRFVy?=
 =?utf-8?B?NTFqUEVPVU5vam1GVGYzMWg2cmR2SEN3cmo0L0lBVGdJRytreVYrOUFLQVN4?=
 =?utf-8?B?azRMUnFxTUMwVHl0MFg2ZHlPd0U4TFZjMlUxcngwcTcwMFNwTUxuUGJoWUt5?=
 =?utf-8?B?V1JkeTBQTlJVQkY3Y0ZTc0dpdHNMdzB2ZnZwN3oyVXk1MUdXK3ZPMlNVd3Jj?=
 =?utf-8?B?d01pNFRFMVl3QXdxeEpUaGZIeVo4aXFYbTBUMURGdUltRVFwWUgzYmdWZ0ZB?=
 =?utf-8?B?bXMxd3ZTeFNpbzdUTjVBVGFCRGlzdmhWcTUybXBTNHQ0R0tTUmY3d1ZlQUxH?=
 =?utf-8?B?S2JQRC9ad2lvb1RYQWlacUltNGRMRFFwUWpXVThWTzNPQUtHMkhYZFNZZFVD?=
 =?utf-8?B?ckFVZkhoWGtvQ2ZQWFFSUGNGSUlYMlpqSWlCNHNxZEJhbE1EVCt3NmdqYWhM?=
 =?utf-8?B?WWFNQ01aUzBGbU9BN1NkWW9ia1dYcUdkQmluMGF6ejh5MDJvWFJjdXhMbG1W?=
 =?utf-8?B?b21TNWE2aUR2OEErMDlwd3gvTEpONHZoRkZ3Ui9kb3k5cGRyVXJiUGExQW5y?=
 =?utf-8?B?bzRzbGxxRCtWU1Bld0tnMTI0NDdzTjdmSWdTenA5NmZUcVpHZFJGaWNObktn?=
 =?utf-8?B?VG55Q0FpNEFHbXBWUU9VZlMyUmpJR005S09OeVRBOVQ5bUxmTUV5ZHBZR1F1?=
 =?utf-8?B?Um03SjBnUnNQYnphT1ZYTmlweDNSL3pCdjFLSS9EQmI4UmVmcUg5QzgzU1li?=
 =?utf-8?B?L1ZTTGFHTFY4K1BrZDhyRmZEYTN0b2lOT0hiWXB2Mk1DQ3diek1MQ05kZUZY?=
 =?utf-8?B?V21GcVltU0ROaXpTZUQ1TC9rUTJqS3dPc1hCbmlTakRoVGkyNDlxTEFpcDdN?=
 =?utf-8?B?OWR2SGp1QnY0aWNOaUVBSHZ3b0VMNFlmenEyZUc4UnUzY2pGMk5FbnJVeXNZ?=
 =?utf-8?Q?z1m2xfXl0CZBKxWQ=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b07304f-8788-475d-87cd-08de58e57d27
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 12:06:20.4974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rP2FP4SsafVdXo7NAZKF3poEJuKl8wlPM3bT5wJ5mV21XWSK7Ornf4v13Tx6aXIBInqIQ/V4PN+IcDJy33PDigYGOAp163U+y29+P5pOsak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10028
X-Authority-Analysis: v=2.4 cv=cfvfb3DM c=1 sm=1 tr=0 ts=6970c13f cx=c_pps
 a=NqdEbQKaF7DYfWX/hQHPrw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=64Cc0HZtAAAA:8 a=A82sGX1ybfHO2LMDQksA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: evNrni8s-NyHYukcuXUYaIkPkzZ_pa8f
X-Proofpoint-GUID: evNrni8s-NyHYukcuXUYaIkPkzZ_pa8f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDEwMSBTYWx0ZWRfX1/B6ycRWDC7K
 Qx8yGY9FvX7UBC7lFi5Xl0ZePfphCW5k5BrdH+9ak2Trv4yxa+WlIudNj/JQiCwvEp1iduaR/Ob
 aBvSgGrX82rRpuX/kbjw73iFunDa5M/45g+y+nAErw0T9+kcuzi/4a+jXCcvCJ6LCD/yiDzNWhW
 zwtQhQ448/ovnearkXFmXblGrz29Rovt6VNBdctjRMEbubUOLv1ZW7aX2P4HD2H29nfnqRHOPqt
 vilU5GHaNd/4vTwAzIzt3flhMzBMeayeRZaHLUyj6/uYUCx9J0RzZW6QF2OCq7HFE1AYCGdfRFK
 ZgD2yRlZHrujKjAmVwYEUUkX8SdREIucRlvNl+pKh54t+b2H7RfXg15kX2ajb4Je357S1F1/brm
 XzdfiliFK7J73SnvQKBViVvefC9lChqfu4KfPa61wo3aEgBm3Ro3K4mn26iM4OT6oaXnT+5xe3L
 JfJOyOFtlWVPT1p3S8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 21/01/2026 11:15, Cédric Le Goater wrote:

> On 1/21/26 11:59, Mark Cave-Ayland wrote:
>> The constant value should represent the next bit in the VFIOProxy 
>> flags which
>> is 0x10 and not 0x16.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> 
> Should there be a Fixes tag ?

Yes indeed, it should be:

Fixes: 1a0c32a9da ("vfio-user: add coalesced posted writes")

Would you like me to resend a v2?


ATB,

Mark.

> Thanks,
> 
> C.
> 
> 
>> ---
>>   hw/vfio-user/proxy.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio-user/proxy.h b/hw/vfio-user/proxy.h
>> index 61e64a0020..b09fd886f1 100644
>> --- a/hw/vfio-user/proxy.h
>> +++ b/hw/vfio-user/proxy.h
>> @@ -94,7 +94,7 @@ typedef struct VFIOUserProxy {
>>   #define VFIO_PROXY_CLIENT        0x1
>>   #define VFIO_PROXY_FORCE_QUEUED  0x4
>>   #define VFIO_PROXY_NO_POST       0x8
>> -#define VFIO_PROXY_USE_MULTI     0x16
>> +#define VFIO_PROXY_USE_MULTI     0x10
>>   /* coalescing high and low water marks for VFIOProxy num_outgoing */
>>   #define VFIO_USER_OUT_HIGH       1024



