Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCC0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 20:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6cF7-0000Hk-Q3; Mon, 13 May 2024 16:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6cEa-0000En-JZ
 for qemu-devel@nongnu.org; Mon, 13 May 2024 16:25:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1s6cEW-00027j-KM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 16:25:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44DKFGJC027027; Mon, 13 May 2024 20:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SjAF0OJfLHuaYBLFjlPTXt1wTjMLVka1TbCFoVDpOXg=;
 b=cUtYw5tDVLlQ6LUDwYik2ms3Jt1Ttjm32kFVWKPZfk/U822glovaSIogWecT/YSX4Ymb
 KZ+ZRpFwohZEUHhJ/iR8ebyADgRa/qngk9bO8DO67f8zWS2Bq7nKXfZMfBO4YKASYayH
 R4sSzjo1Uno6p77fQ/jVhfBT5hIwh3snVQrMbO2PpKKSc1ggOPJtGiuPaoezOhoaJH1b
 2OrrWZW1iANIdMzyNC/lyeZWGAa5pdsexLejI0NDxf4xko0vxE7jA/djkOfMC05TWWa2
 H2UkbY1IBd9yX6Jp7S8Hjc8GQHdIOv0Ppq/4fH6qm90FK9sEEUpwVpVz8AXtgZnhq0jJ rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3qgv0cqu-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 20:25:11 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 44DIM8qa038406; Mon, 13 May 2024 20:11:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3y24pv474m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 May 2024 20:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgAHWZ1uGcL+szUMiu4T2tVKuaw1q2jFpObXbefWTwJoyUh/toYkPA1sgCJgsU0drqzkL1fv6q5iN9qg8c67jlrSEZydZHspTf8NSGPaAQnxzmO6EOuYbaQGMO3wnKIrCTZdHjE5ZAtdeuKP4tzNQS3EjE6EWvvIHTD2+MI3I/lP61N3yYQDptdw09wJKE6l6bMG8iTKfv8T6Hkw8jYzy4a+/+YdURyl2Sr5JMwQ+e2crrMTNhYAmAkx3YcwPa9ZQeTPud0umNbUU5dfIwiSPWi1+WQ4Kuk2mUKaOZ+DrPDWO2jwKMGnlaYBOH2dmFid4Wh+sJx7/8O8c0RlNZK+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjAF0OJfLHuaYBLFjlPTXt1wTjMLVka1TbCFoVDpOXg=;
 b=cXxjwSZiAeqBY51Szp8kosYMIlb6wEnNDiIdYniA/XJt2vc+x6+x2G1YC+ErEjSd1OAtGmCALXP9U0bXTrXf4Wp6pk2tksAg1FpQSlaMkDEzUWOjWGF4eiZK7gpFRK1hwbuR0pCGkEvwsWOkPU07qXCm4btIHY4WVTK5/h4+7XIlDvpF6qTBhUWxPchOWcs31zdZT4do+bxeaNPUjaMwpwTuuPazNeIgbnpp+jMdpUQaoR/9m/Jtwd2UUhZ80l2DTcJZMPUARUD2ROR8lcHwZeClL6jTXCeaQ1jgLlLTRn5IndmwErFBJtN354KEdEqUKJQJiZOplFam82NKUPvlRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjAF0OJfLHuaYBLFjlPTXt1wTjMLVka1TbCFoVDpOXg=;
 b=iyfmEZBjfacv6f4u5VGurZLN5Zp5TMFaqocVg8Y2sNsBXQQcwhriANblM5yXI9AWOmcXoHAJgOHBzAh1mePOr5NJKqZXKBLhrw/sgQRi2Sf/bB/GpPTWgZ7i60RBmoBpw+FekDjo9oEjPoTNvrG+U0bQktDr7+KJO8sagcwpHHM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB4440.namprd10.prod.outlook.com (2603:10b6:510:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 20:10:56 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::e06f:6709:57b4:91a2%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 20:10:56 +0000
Message-ID: <82c69792-061d-460f-9db6-88fc8f9df5af@oracle.com>
Date: Mon, 13 May 2024 16:10:50 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: CPR/liveupdate: test results using prior bug fix
To: Michael Galaxy <mgalaxy@akamai.com>, peterx@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Hunt, Joshua" <johunt@akamai.com>
References: <20240228051315.400759-1-peterx@redhat.com>
 <20240228051315.400759-21-peterx@redhat.com>
 <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <f855963e-b7dd-4ce8-89dc-dfaa87e896c4@akamai.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0074.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::15) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: ab8a463d-e811-4397-7c9a-08dc7388ccb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N2p4cDRseDI4blUvMzlsS21JcEtadFE3U0p6NmIxVm1WRkFWbjh1TDBEQ01B?=
 =?utf-8?B?Y3R3NVFaaDNvb2dSY2MvRFdkSCtULzFVR0gxSzZtZDZSZENvbEdjQXY5NzRZ?=
 =?utf-8?B?TVR3cWhMUWlWSFQveVJvWW91RXJFT1cvMlh4MXBYbEVab0VRaWpqbHJrWGhI?=
 =?utf-8?B?ODdYNkJlZW9UMWY5RlZEdGtqVFBPeFY5Y3BudS9OM0g0V0t1cFlQT08xRDR2?=
 =?utf-8?B?VTB5bTByUndWK1Nnd0JrSmhlV1ZCZ1N6aDBRTFBQZ3ZUMURuWUV0ejlJdit1?=
 =?utf-8?B?WUlDajZmWEN3LzUzOHFuSm5ZYnl2LzJ3MnFySjBFWTMyZWRERUdDczY3RW10?=
 =?utf-8?B?WHAvM0lMYWJiVTlpcTBvZTUzTW81MVFWR0JMTUtGcDEwVVA3Nnd3WGlWWVVN?=
 =?utf-8?B?WGFsN0NDcThHMzdFMDJHblhZdkxScWRHUzZaK1ZkSmN5clFZenhiZGZGeldo?=
 =?utf-8?B?cytUTUpabnZWR1dVcE8xRlRrTitEUFR6R3c2ZGRZOE84SGdSYmJQb2M2cGNB?=
 =?utf-8?B?TEliMHk4cXpTRkRnNitHays3aFhOSUdiMTc1Vm1IZGFlMS85bE5ubTdaSWZk?=
 =?utf-8?B?WlZYSVV1ZjRsZ3J5SVloWnlFSXJ4MkZkejI1cS9jdG5nRWUrYWl3czRYdVZS?=
 =?utf-8?B?V1phS0tzcGpPS1BZQk00eUtveGRrZkVlNFRLMWF6cWlxakZucVZkS0hLMXBI?=
 =?utf-8?B?bUZoelQzcjBVM0lRNmNSQXNodUJPUnROckhXUHVDYW9xaHNPVFBsbGNBTC9B?=
 =?utf-8?B?WXFrY0RTWmdJcWdLaTAyblVFNFhoRWR3b08zeUtLdmFPcHdRS0xEVXJoRGxQ?=
 =?utf-8?B?dy91RURicXJjSVkxbmN5aVJDcW1pL29DdlA3SFVLY0o5NHc4U2lMRXFKcjlV?=
 =?utf-8?B?QitET2ZmOGRyWGtwOHI3OUtnMUwxa1NjT0gzbXNqM3dMdWZJdkQ2bXZrMmJE?=
 =?utf-8?B?T0NkQ0Y4SnZRTzB5S1lCRHkrYkV0bHJSTnRxL0xzLzBEUjI1V2F6ZjFYUVdT?=
 =?utf-8?B?b1hLSHpBRE84K2RuMnNWZkF1MWtyeEZPTTVuUUxDUGFzOWdxdlFCRnkwYldI?=
 =?utf-8?B?Z29ZdDFpdTF5NHdoME1DcVpKY1h4Zi9tTzBMSTlsNVhoRlk1OUZKdWNtSitv?=
 =?utf-8?B?K2grTU5vMDQySmtDMmkzT3BWUzM1ZTE0d1RiM3doR3Z3MGZYMXMwM1VPQW9F?=
 =?utf-8?B?NFg1dVZWV3BuUXVUR0d5REF5R05HVEhMSVVsVDBoREQxMlZxUG8zV3ZFZjdm?=
 =?utf-8?B?dXNUWFBrNTl5MUFKN0QvOVk5b0YrQ1dxNmxzc2pzaWtDVTJBSXF0RTRmQ3pE?=
 =?utf-8?B?WXdaNEVQNWtBcHQ1VHA4RUUvVS96VWlHc1ZyeEg4S1Q5NTBxYkdzVmZJUUhW?=
 =?utf-8?B?WVUydzVDckc3VDRVcFZaWjlyY09IaEkzSmlSNENndmxZdUpqWlVpOXd5cFE5?=
 =?utf-8?B?TXpzUE1tQ3hCdU1YZVBPa3BZZkJVZTF3L3ZUall6OUpnV053SHFxL3prb0tM?=
 =?utf-8?B?aFZwenlFeGlPTFlmdWR0ZGl1b0xnU2tDNisvV3IxYThPSUFRQ3dPSTVOU2VJ?=
 =?utf-8?B?bEZDcjBBODdDWjlyTWJ6OEdVZ25jSmErKy94T1J6bkd3QURESVZEQnZBa1Yx?=
 =?utf-8?Q?pkqQb6AnTWj8n/PdXKfC7duJYCm/2YV/rhJqJ7oPRB9I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVlpdXZldGozdGxyWERLMFJwWXpVM2NpeVdsU2dDcVdObGUvWlFid2NqdHJN?=
 =?utf-8?B?bWZIT25hdjF0blM2Q1FVZ0dzTHZzeUpkQ014NkpXQTZKekJXNW1JUzFiVER6?=
 =?utf-8?B?ZlFZVjE0cVREelhwMnJTSHdOWUFjUnlnWUs3bG9TbUNiWS9NL0Z6NWUydmpl?=
 =?utf-8?B?UEtoWGsvdE5jUVQ0ZzQzMkdYUkZTNUI1dCt1R1VCSWRDMDBaQXdDdjRwSGRw?=
 =?utf-8?B?V0NWSXNidm8xbVlDcGRha1B2bGtnb0R1eTdvdU9mZk5oQnFhRWRmNmxzbnpp?=
 =?utf-8?B?VHptV0h1UTh2dHdzcVlxbEYxSjAxWldYeERiNkE5K3pQZUJjOTE0aU03VlM4?=
 =?utf-8?B?NGNYN1FtTWY0c2hzL2xwYnZzN1VBektsSEhzdDcyYXBxWWp2aGRwUFhEdlFP?=
 =?utf-8?B?N3VPTEUzZXBFSXhDeU0xVU1TQVJSRXowVC9ZVVZhYnRPYnNwdFcyQ0J0TXpL?=
 =?utf-8?B?OWdwaGdDZitWZ0NoTWdmYzZ5ZEd3TlVFbUFaT05wSVpLSllUSCtoQWIxRlJt?=
 =?utf-8?B?dEZWMC9UbVNHWmhjbDNOcUFPbjNEb0Fqc3B4Uy8xRXBsYklTcWhlbFQwR2t5?=
 =?utf-8?B?R1dLZ0lUSWt0SFM5UW80VUNmbm9NLzZCZTNIaWR5VW9PaFF2NFhhL2pVQ0I3?=
 =?utf-8?B?NU51KzdxN2swTkZnVUhuT1F0cGhZc3BOYVdUL2hGWk5nVys2VFVJSUpUcHlM?=
 =?utf-8?B?bzlOUTZZaE10cmFOSzVxNDVtRW5nTTI1Rm9EbEVjaE5FZ3RGYlpPNDRjUGdt?=
 =?utf-8?B?WC9wQkdnZ29vTnIrYU1BaVB2UG1CTXJieUVmbzZ4Nm9FamRpcUhtSzkvSjRG?=
 =?utf-8?B?b2pQbjlDZExUYTVJMVA4K0o1MkZMS1VFRldmK3RyTTZlRkVUNFExQmhjbWNz?=
 =?utf-8?B?ZklrVzkyUElSWDhEQVh1QTV3cGhRZ2dtZFF0VGUzUW5VbWtwekhKVjZNVEhF?=
 =?utf-8?B?RDZxTUtyWHJRdElxYU9rTUtpZG5KRGFWTURNem1JTVRYZzlTOTBEaGI1OERy?=
 =?utf-8?B?L3h4VWJmeC9XZXVsNGxMZk1wdkY5RjFkdTlCS3EvOTNLZG51ZjRNdllYRnRC?=
 =?utf-8?B?TytWczh4UlRmNHVyczZkYncvZGdjUVAwbXZCc0RnU2UvQ3JNUVFTU0lqT28r?=
 =?utf-8?B?SVNqLzZrMjNES3RFYXNYTkFsVU94aTZna09RSnJRMmtJRm52eENlMDI4NEZw?=
 =?utf-8?B?ZURmdXdJY0R4UEs4MFQ3QTBBOHN0K2lzMzlWWHpxS0orL0ZVRVBDNEVMT2lx?=
 =?utf-8?B?ejNkSmxVSFY3R2VhclNuS0dnTmE0S0ZIR0Y1bWhlcm5pVjBMYkJZV1ppTFJj?=
 =?utf-8?B?ZTl2dkRVVjVGL3RMT0hJOWhmNHhHZDJMa25nOW11WUZ5dy9aQU9yVkNYbHJ2?=
 =?utf-8?B?Z2g5cUlMRzFUeXRMT1lQcDVuWU5nUzhlWjRSbU9IVmY4OHhQTjZCVnZManBn?=
 =?utf-8?B?anA5NXBGdE11a24yZlZVb2ZXaThkWFFmUWExV1BCZE9BeWxYRjF3T2RVWGho?=
 =?utf-8?B?NTFqa2ZVVUNxaFllNlUxdFZoTlB1WEE4L2d3N3RFQTZhRjZkUFVHV1lZRW9l?=
 =?utf-8?B?MEpxcTNUM0RmTmdoUk51bndJWHFzTG5KT1poOW40a05DUkhDN3hWaUltUmlI?=
 =?utf-8?B?cWxDbTIwVWFuWmJrK05SZ1hlMUxRd2k3ZHJQNXd1STBVVHhFb2s3NWRZcW1i?=
 =?utf-8?B?TVpwMkdHWjdFQ0lsTG83ZnNqMENHVjQ4anhrQ3NtcGl1WHcyR1ZqSE14Mkll?=
 =?utf-8?B?SDZ4ZDN2N2NhMFRvdHFLVFRJYkpob2ROaUZVUERLQUlHcWE3QW83MStZWndW?=
 =?utf-8?B?UGo4YVE3THZITUl4VzB0aVUrU2t2aG5yVE9FNituYlB3dGk0c1lBVHhxMDkz?=
 =?utf-8?B?K0ovY04wRkZyL1EvRjlUTitNK1dYbTNwc2ZIRGtmbHNlM1YzOENnYi9taFFz?=
 =?utf-8?B?eFdPMmlVN1RrTXg2L1M4RHd6MCs3YlNvYnNVZ2duWGlFZ3lOc0NJUlB0VXhZ?=
 =?utf-8?B?dnNSeUlVbk9rYThkRnorVkk4ZVQ4QnpYYUhrbjdDWXVpaVMrbXQxOTYyK2xX?=
 =?utf-8?B?SUUyM0tqeVZKUkk3aW1Dbk1lNVdRcndPK1pwaHFQdHdkU1JCM2UvKzBIQWZE?=
 =?utf-8?B?Mnd3L1ZDd294N0dTQTdBb2EvazRnZEErSW5mYldrUnp0S0RTWE5DUHNCNFI3?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4A28+syK3I2xJIKZEaGBT8iFg6CFX/4/7wRADMHi835PU2PlmEZovBdulf2y1WGar42pVrOGGiY+AuMYlhO+xF7tX5hdNYv7iTG2Dv/4ZITTlZa7G4mc2ljZ/4D5RUq1PBNzSIdzc3gNcSdNpDCitWKTposwKmzxoE9nkv+CF6D8MbsHRJwKx9OWNxnbz3GcawRKWVzZgwQnsqv7HrfVirSIyboV1S+F0VTK5IyZo9ZoTC1453Yfv/prwIENZ5/WCOhzOvD+xuDHLc2MZsa8A9EJ44cginvntpesGuk6vFD/ufEk1ErfcYEmA0uqFQndf4PKfJhR+ovscLk9SZz/fqV+/wa7wgmHtG71VtKxJUzG35ryRtrHdwmw8vNhXatRV8J8qlz3Dfei7K1ZF8lGz62e2zr+/A3Lvq5FYfUz1Ky4uec5MBikHD+BOHPxZUk7adx8pxRhOzwFy2jTZp5kGPFsF8zCNX2yyqxXEu3CjxSrsKL413J+aWUZklY4S3JM9KMb3LC0GcS1VjffbwyWbmJbl+ZSd56KuQtLqBSiAaZSEe3mj+TPVGqCDNNys7HfENZRcG8qrl0EBncqrJeo9gRRIXuWyD3R7Vd4YHT1crU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8a463d-e811-4397-7c9a-08dc7388ccb5
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 20:10:56.8481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/JI06/Fh/78HzC8B/EelgefUeSVxv78LLh24ONM03mzYx0zBOGbYGLQ9WzMtI5Zm6dkAx+ifCKumbPCg7pqwhHz2ksPSFXpiQaSJkXQ9vI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4440
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405130137
X-Proofpoint-GUID: 3JXY7wDrc1i0zMBFZXfKFnpPGnybRaFL
X-Proofpoint-ORIG-GUID: 3JXY7wDrc1i0zMBFZXfKFnpPGnybRaFL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Michael,
   No surprise here, I did see some of the same failure messages and they
prompted me to submit the fix.  They are all symptoms of "the possibility of
ram and device state being out of sync" as mentioned in the commit.

I am not familiar with the process for maintaining old releases for qemu.
Perhaps someone on this list can comment on 8.2.3.

- Steve

On 5/13/2024 2:22 PM, Michael Galaxy wrote:
> Hi Steve,
> 
> We found that this specific change in particular ("migration: stop vm for cpr") 
> fixes a bug that we've identified in testing back-to-back live updates in a lab 
> environment.
> 
> More specifically, *without* this change (which is not available in 8.2.2, but 
> *is* available in 9.0.0) causes the metadata save file to be corrupted when 
> doing live updates one after another. Typically we see a corrupted save file 
> somewhere in between 20 and 30 live updates and while doing a git bisect, we 
> found that this change makes the problem go away.
> 
> Were you aware? Is there any plan in place to cherry pick this for 8.2.3, 
> perhaps or a plan to release 8.2.3 at some point?
> 
> Here are some examples of how the bug manifests in different locations of the 
> QEMU metadata save file:
> 
> 2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load mtrr_var:base
> 2024-04-26T13:28:53Z qemu-system-x86_64: Failed to load cpu:env.mtrr_var
> 2024-04-26T13:28:53Z qemu-system-x86_64: error while loading state for instance 0x1b of device 'cpu'
> 2024-04-26T13:28:53Z qemu-system-x86_64: load of migration failed: Input/output error
> 
> And another:
> 
> 2024-04-17T16:09:47Z qemu-system-x86_64: check_section_footer: Read section footer failed: -5
> 2024-04-17T16:09:47Z qemu-system-x86_64: load of migration failed: Invalid argument
> 
> And another:
> 
> 2024-04-30T21:53:29Z qemu-system-x86_64: Unable to read ID string for section 163
> 2024-04-30T21:53:29Z qemu-system-x86_64: load of migration failed: Invalid argument
> 
> And another:
> 
> 2024-05-01T16:01:44Z qemu-system-x86_64: Unable to read ID string for section 164
> 2024-05-01T16:01:44Z qemu-system-x86_64: load of migration failed: Invalid argument
>   
> 
> As you can see, they occur quite randomly, but generally it takes at least 
> 20-30+ live updates before the problem occurs.
> 
> - Michael
> 
> On 2/27/24 23:13, peterx@redhat.com wrote:
>> From: Steve Sistare<steven.sistare@oracle.com>
>>
>> When migration for cpr is initiated, stop the vm and set state
>> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
>> possibility of ram and device state being out of sync, and guarantees
>> that a guest in the suspended state remains suspended, because qmp_cont
>> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
>>
>> Signed-off-by: Steve Sistare<steven.sistare@oracle.com>
>> Reviewed-by: Peter Xu<peterx@redhat.com>
>> Link:https://urldefense.com/v3/__https://lore.kernel.org/r/1708622920-68779-11-git-send-email-steven.sistare@oracle.com__;!!GjvTz_vk!QLsFOCX-x2U9bzAo98SdidKlomHrmf_t0UmQKtgudoIcaDVoAJOPm39ZqaNP_nT5I8QqVfSgwhDZmg$  
>> Signed-off-by: Peter Xu<peterx@redhat.com>
>> ---
>>   include/migration/misc.h |  1 +
>>   migration/migration.h    |  2 --
>>   migration/migration.c    | 51 ++++++++++++++++++++++++----------------
>>   3 files changed, 32 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index e4933b815b..5d1aa593ed 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -60,6 +60,7 @@ void migration_object_init(void);
>>   void migration_shutdown(void);
>>   bool migration_is_idle(void);
>>   bool migration_is_active(MigrationState *);
>> +bool migrate_mode_is_cpr(MigrationState *);
>>   
>>   typedef enum MigrationEventType {
>>       MIG_EVENT_PRECOPY_SETUP,
>> diff --git a/migration/migration.h b/migration/migration.h
>> index aef8afbe1f..65c0b61cbd 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -541,6 +541,4 @@ int migration_rp_wait(MigrationState *s);
>>    */
>>   void migration_rp_kick(MigrationState *s);
>>   
>> -int migration_stop_vm(RunState state);
>> -
>>   #endif
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 37c836b0b0..90a90947fb 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -167,11 +167,19 @@ static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
>>       return (a > b) - (a < b);
>>   }
>>   
>> -int migration_stop_vm(RunState state)
>> +static int migration_stop_vm(MigrationState *s, RunState state)
>>   {
>> -    int ret = vm_stop_force_state(state);
>> +    int ret;
>> +
>> +    migration_downtime_start(s);
>> +
>> +    s->vm_old_state = runstate_get();
>> +    global_state_store();
>> +
>> +    ret = vm_stop_force_state(state);
>>   
>>       trace_vmstate_downtime_checkpoint("src-vm-stopped");
>> +    trace_migration_completion_vm_stop(ret);
>>   
>>       return ret;
>>   }
>> @@ -1602,6 +1610,11 @@ bool migration_is_active(MigrationState *s)
>>               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>>   }
>>   
>> +bool migrate_mode_is_cpr(MigrationState *s)
>> +{
>> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>> +}
>> +
>>   int migrate_init(MigrationState *s, Error **errp)
>>   {
>>       int ret;
>> @@ -2454,10 +2467,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>>       bql_lock();
>>       trace_postcopy_start_set_run();
>>   
>> -    migration_downtime_start(ms);
>> -
>> -    global_state_store();
>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> +    ret = migration_stop_vm(ms, RUN_STATE_FINISH_MIGRATE);
>>       if (ret < 0) {
>>           goto fail;
>>       }
>> @@ -2652,15 +2662,12 @@ static int migration_completion_precopy(MigrationState *s,
>>       int ret;
>>   
>>       bql_lock();
>> -    migration_downtime_start(s);
>> -
>> -    s->vm_old_state = runstate_get();
>> -    global_state_store();
>>   
>> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
>> -    trace_migration_completion_vm_stop(ret);
>> -    if (ret < 0) {
>> -        goto out_unlock;
>> +    if (!migrate_mode_is_cpr(s)) {
>> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> +        if (ret < 0) {
>> +            goto out_unlock;
>> +        }
>>       }
>>   
>>       ret = migration_maybe_pause(s, current_active_state,
>> @@ -3500,15 +3507,10 @@ static void *bg_migration_thread(void *opaque)
>>       s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>>   
>>       trace_migration_thread_setup_complete();
>> -    migration_downtime_start(s);
>>   
>>       bql_lock();
>>   
>> -    s->vm_old_state = runstate_get();
>> -
>> -    global_state_store();
>> -    /* Forcibly stop VM before saving state of vCPUs and devices */
>> -    if (migration_stop_vm(RUN_STATE_PAUSED)) {
>> +    if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
>>           goto fail;
>>       }
>>       /*
>> @@ -3584,6 +3586,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>       Error *local_err = NULL;
>>       uint64_t rate_limit;
>>       bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
>> +    int ret;
>>   
>>       /*
>>        * If there's a previous error, free it and prepare for another one.
>> @@ -3655,6 +3658,14 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>>           return;
>>       }
>>   
>> +    if (migrate_mode_is_cpr(s)) {
>> +        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
>> +        if (ret < 0) {
>> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
>> +            goto fail;
>> +        }
>> +    }
>> +
>>       if (migrate_background_snapshot()) {
>>           qemu_thread_create(&s->thread, "bg_snapshot",
>>                   bg_migration_thread, s, QEMU_THREAD_JOINABLE);

