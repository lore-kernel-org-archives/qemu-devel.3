Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F44CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMo0-0001LH-Sx; Fri, 08 May 2026 11:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLMni-0001H7-Ip
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:07:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1wLMng-00089k-Ou
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:07:38 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648F6uJL2001162; Fri, 8 May 2026 15:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=rKNVqGbPOlrxSPr73gMQssXoXo8kkIThsgGujk3vzNI=; b=
 X38JEMrn7HCWpF/cS1LG15/cFPWtLPP2KUXAD7TKZpTdYcctgbxD0aCmAWrItJ/x
 RjEOtL3LtXrFeXhq5/jVE5guAOhi+EaiWnU8S2SyKpwztmXR+SutVbmK+7vrFdMs
 xLv3IoferPre7YtpIpl4hDDAmMrcbgr2o7MwYmHnsJJV96TtAlI5KN0+1K79iWJV
 vDjKM6+c/eroksri1VC8dpjtCzX0Yh6V+bZ7Sl1FC/VF+/tH4R5JwATGJKx6vzvY
 kq4xRYpRLQw1adz6H47Pi85j65RO09z/kYtyTnXpchVBV0dE4CjV1J8TJtyMYaLs
 WM8WJhtURWmbicVxJD8JaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9gxu1t1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 15:07:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 648F6NRE029527; Fri, 8 May 2026 15:07:33 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx595wjka-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 15:07:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILGuZWmv8WOYt+GSmznIQ87iQkWr7qqA36vjV2PBvYhrz5hL4oFj8wpUBFD0At2mLS4kwkZSuFJP3+x/b71xBJamJBHr67R/mPg45XIME5QkmiGfv1BsUgZFeYkbV8VA72eiuR1TFAoT5zY7gFksYoOKeoBYzAxhAFL3TIFdTTy3BuUSn2CNhldaXnrVTx0lMbbLTneDy3Jhn1CRoo0RVUPJCkXzprbf/IZwcZUAo3CTL6LUyFwDN+c/iY2K8sPpS+7EuXUsgJWnd+htYG45cGDvuEwgdEAsvPzER9/fH2fNCnfTuM91UmUrf54Lj3GNGlA7rgXK/kgK3Jaa15slgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKNVqGbPOlrxSPr73gMQssXoXo8kkIThsgGujk3vzNI=;
 b=DfbmvNWljSkjQ9CI0QQN4VbjIeebFK+CJU9d95B9MNQVNLDA68h0uNNCNTdLyHEH/40LylQL1xmvEQkDWk3aVn2Uz6VT8gR8N8KJ42HzbQ4jbD02RD5zvVY5L+Sb8OfAwAIF0LL7qjvQFpQYftJ09OaSRM5WqQW/3rRQv8xa+zW4gLK7gVJ9QVosw5B/GHrXLP7Mnb7NpH+Yi8QFlUfzVCw7Z5lax1CvgB/KyGAM3jNS3qTL+HML+8TwIhoq4wGinoPGVpcvF8NEa9XpFtEPGQ/p2vRkDoITVE2YxW7jDK2z6LWc32KxM7bfiLvp4N2hcCUIr2YuC4hItE2s5i/O/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKNVqGbPOlrxSPr73gMQssXoXo8kkIThsgGujk3vzNI=;
 b=gGak8TicqQR++5uyafbNkwkuUwd/eeg+r4PcIHKaGOClvX5m7kSmMMKUQRfJX3a3EZ5z/QC+MTXkC5wm3DfoEcukjrjXHqpIYl9jLtR1xB9BgN8XD33qw/RW3jRIpGKvm1uTIW+4IubBed8Be8t/RCZdVJ8JHtIyfkxZXkECUyQ=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 15:07:30 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%3]) with mapi id 15.20.9891.016; Fri, 8 May 2026
 15:07:29 +0000
Message-ID: <d7c29d61-9146-4cf8-83f7-e650572b338b@oracle.com>
Date: Fri, 8 May 2026 11:07:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Mark Multi-Process QEMU as Orphaned
To: John Levon <john.levon@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, "clg@redhat.com"
 <clg@redhat.com>
References: <20260508102657.644247-1-john.levon@nutanix.com>
 <IA4PR10MB8301FE3A10AA391212B387EE903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af3zEgHy7UMYN4Ow@lent>
 <IA4PR10MB83013C640DBB740BE8872FE4903D2@IA4PR10MB8301.namprd10.prod.outlook.com>
 <af31Oo6gXE69c7eb@lent>
Content-Language: en-US
From: Jagannathan Raman <jag.raman@oracle.com>
In-Reply-To: <af31Oo6gXE69c7eb@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:208:530::35) To IA4PR10MB8301.namprd10.prod.outlook.com
 (2603:10b6:208:55e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8301:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: fc21beca-dfeb-4511-4a9a-08dead1385cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: i16TbYKngzA4xerU9bPBHxjZ0aRV4tjTbqeI2ovoLIPoqPi1KkUkrR+zIrCbZ6v9udOUNbuQtjVFxLFnotAu0UpHsoVqQwgqBlCeTHSHO2M1Jqhpo8Z7Qx+J/dzxlxCJE/zM+2MRKoWiQu+vpZ4hS2kQ7fRC3kThEVpofPQbOjKqyARp/yHgD8eXn718oLcppB1MKfoUjtcRF7EAjq+fWVSfcmY+spHxEfvQ2aLKoDZP2WWqBbA6HJVAaWIYUqMiSHBDJ0f/E0Lz3x/dJ94mqt/ih15fjnDfhCOcvUw/zXw+44aOZ/NrD2cFyn0u1/PZWEas5Il6tGnSdzOOJGjuzyN4SsJs1mWN9Oavc8inJA/el/LztLszcGHXrjMdfRtAIiunTJYm0thZW4zcUyWfhhO6L0Iq+OG7qaIray9Kn9/D43BIMxgXFeSbFFd4boF/O0uVMLw1dJ31fAaG5Hi4TIGuZx2SMDMKJlxLo/HkktdwzKPqvM4+n5IiQXhh0OQRD0jiQcnQKktLeSnWuh7bNvbZK83LSZtQl+45RukTZkFQ2QGVTGJ9Ze9lGJWUdBpK5weRpF2mEczjnf4/PWc6LHREmmgQcm9h8B19raW49su6uoDzGW26ZLuPpsrk5M+lAz4twMuAYn/A6zvfqYKZp7e8NzgDgQiyP4FrwRAGkChhNDvuQmRB+Abb6hunDwjB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGE5emZweFZOb1pvVENsdW1xOTdhMGxScDBoMUtDZHorbU9LWllpM0RZcWpP?=
 =?utf-8?B?RnJNanlNT0RETFZJYnhoUGlQdTk2TytWZjB2N0hPRWRnSEw4Qkp0bjgyTzJn?=
 =?utf-8?B?TnVFV3htR3UvdnZSZzU0ZFFzM1hnTVVsNUJrN2VIZUM1cE5laWtobXh6K2t0?=
 =?utf-8?B?ZlJNOTVPOStEallGR01ob3ViNWd3cE93b3lJWG5iZHhjM2d1YVJ2azQrWFRM?=
 =?utf-8?B?TG9KbjMzQ1Z4Ykppek9BVHUzdXF0ZWtFekMrMFY1aFZhYjNsOXhHZTR6SVZQ?=
 =?utf-8?B?TjFnZVJWQ2VjbHVBV0ppYndNaHVlajZ6aEJBUS9uSVFWODVEOTFiSXVXVjk2?=
 =?utf-8?B?dlFiNGdEQ25UNHFoWkMzMjRZYzNzME1GVndYSDJDN3NkTnJCTm1zN1UvbERr?=
 =?utf-8?B?OWNBYkNsZ3lsVWovcUYrU2pqRW1IUityTWl2UWUzQngzQmhWaktTS21mUzNa?=
 =?utf-8?B?dHhNWnN2R29FelM4cTZ5S0JHbXhvTkpKYTdsd2kxZXQrWUk5Z1N1NmFpTUdS?=
 =?utf-8?B?TWdkZlRQd1FORG1rbXdHM0tzSG9NSTRRRVhuUm1jbU9vWUVFMVZuMmlvM0VL?=
 =?utf-8?B?USszYnNlN2FLaVZtcTh5NWVUY3V5SXBISFQwU0I5M3hVdGRDMmhmWG9UVmdp?=
 =?utf-8?B?T09QNmlZQXQzM2l4N3UzQWhRdFNRc3JhamRXT2R6Mnc1b1pTc2E3VytFa2lt?=
 =?utf-8?B?QVl0NU1zMllBeHR2aWwwa3pxM3FBTXpwVysydW9vODJUK1NKWG1MdjVjMU5h?=
 =?utf-8?B?anYxYWZYcE84LzRudTBxOHlFYStuSVRnd01uTmxBTVFHMDN6RUEvSVBGSkc5?=
 =?utf-8?B?TzJzOVZuNWpIWGJuL0NiUk15YVdMWHJsUklPcWd3bWFNbUowRnJvSFowNE9r?=
 =?utf-8?B?WkJqWjlZeVVHUFRUS3EyK21FcDZRbTJXS1o0NmF1dWh5T3p3UjZLM3hMM3Qw?=
 =?utf-8?B?Uk1YTlphaVVuT0lxNm9SNVFHbjJGMnFZR0tyd3gyNnVWenpIZ0xCTDU3b1JZ?=
 =?utf-8?B?bFJmRmphSUZ0Wkx5dnF2a0N4VThEelJsMnp1d2lhK2VGRktrYTczSXlhSWh0?=
 =?utf-8?B?YzV6RUlqODdld3ZRdGRKRy83aC9NWGphYkNFd2w4aEtuSDVGOERFVFJaNmVR?=
 =?utf-8?B?UDZXdnlnZ2s1ZW9YekZMU0ttTjNpY0k1L2EzdGJiN2xwc0daZ1l5dVpVcUFn?=
 =?utf-8?B?ZEdIVHkxR0laS2JKa2JYZ0RlUi9lNjAvV0JXOUwyUHhqaEhOWXJCY2xXMUty?=
 =?utf-8?B?TmVpUENSMUlDS1N3R2tzb0hVSkZvNGs5S0FxbDloN0lvU3JMVDY0YVp2VGls?=
 =?utf-8?B?R3FpNS9sL1RueUxmTTNzZDMzSUlRRC85TUkzY1JGTjlUWXBvWWNMc2ZsdWUy?=
 =?utf-8?B?QzIvZVBCZWg2MXVQOWVoT2pBeEVLaVF2aksvT1dqVi8yZ3E2Q2tRcnRtakc5?=
 =?utf-8?B?ZXFHc2NTTEhsZzBFSUtjRkxKM3BwU2FZeHRpbDVPM2huTXIyL3lsUkF4Y2NK?=
 =?utf-8?B?aStzNjhIZ09vSTIyZXlLRXk3UW5jczZST0NHeW9YVzFmZk1pUTc3MU80OWMy?=
 =?utf-8?B?cFpqampDT3UxaEZ4eEVDWFU3WlZCRGJYbFlDTGM5VUlrZXJ3emtFcFNGVHBo?=
 =?utf-8?B?VnhwU1dPV005Qnl2cUtKMzBxaTNiUFVraWxnKzMxQ08wSGR3Z2ZERkFoV2ZX?=
 =?utf-8?B?QStqbHB1UXlGT0hpZTdId2xmb0VqTEJCYVJnLzYwbWg0MDltUkhieTdQUXdE?=
 =?utf-8?B?QkljTzJjUGtyb3pUdm40cllkQWNaa050NXZrUWw4TVB5VzBkOUk2cGRwVkVt?=
 =?utf-8?B?WXFabmdYNWJIMHlvRE10UE0xMkIydjRXTzIyU2ltcXBUV2dMNmZnVDdGUDRl?=
 =?utf-8?B?THpRTXhZZDVpNldhSUJJRWNkVmJHeEp3Y01KVm9NZEcvSkMvTDdQVFpPdS9D?=
 =?utf-8?B?M0QwWkFPVDk0bkJUV0twbGp4ZzdIekNsWVZKWGRyc2I4Q3lPZmdsSDZ2eFpS?=
 =?utf-8?B?c1h1ZVdjTHQ4a3p0MVhSZVZibjJVOW1jUGswZW5LZkFoMFR5Wk1MSFVWWERs?=
 =?utf-8?B?ZTZMWVpnS0U5K2NBNUpDL1phRzNlb2tUUnhPT21xZlZMT3VXcnBjT01TOWlh?=
 =?utf-8?B?TkNSV0NOaVAxMFFTb2ZnbERoQXFaL21QVlBvUGVORVhpQWFGczNYTHk0bkFY?=
 =?utf-8?B?dkd6YmRBV0VXa3RGMksvVjNvQVdkbFJPdTdGdjQ3OXhUVXR5SkJyVDNtaVdh?=
 =?utf-8?B?bWN4R3JmdXFCWWlmUWpiWXU1ZGF3R0JOV25WWW5mejVLa3NDa0FCUkxDS1FH?=
 =?utf-8?B?aHlublpCVFZBVXRRN2wwZ3UyaTAvc2ZpSHo1bG1yQ3JCMEVtNFllQT09?=
X-Exchange-RoutingPolicyChecked: CZHdgqo2gxnCu5cZU8ZWHR3fMONeP0I6b/yLlg+qt0tGabs/TEKiPLpqjYXSImxhWVPNUypjJW4yYFhyN7a4Omjpopr0qYyEGQDmmXLY39l/fkyAqnsyiaAfirJcM4G5u7JAAHzr1TcLoAdVClvNLBZOSALKSRwNis5Zdc6xgImcuh+6saLVu64IR+156uDzWk1Dj5OSaFQH2Vlu79ni5BIkEqM7hEZOUH+POULdrhVAt1VsC+ntLmPw4LjFljVw0E9/IxAtneQOQl4j8Q5joXlpjeflrL9WvMFmg/R5BvFS5i8tlxx+cq8iy+waMwTa8VB7yWFuvvwHnkCkGz7qew==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hqwaKTjYnRyMzn0aCpIFa+G3HqDnMmNQoCrpoiA/X/XFUuO78gR1x+xJBfKQl6uMF84ek/RvD4Y9QSGAfDC6pKbeHFIGM/AR5P+EInrynBlTYtJu+xLk0k4ZcyfY1m2bZ+MHD3wKzRdjE2CBrIE6t2dhKfAWNPW71ueHmi5dfxnFNulIYkyN7pxQf8ekwQqwwNB4sD8g5doKY8W0hjJjUEpqLWN0QSUxBINa4B169zLx1IkO49YgvQKW3BqCW+sQ8ARveujFFEB/LsCpZSka5eeR0r0MRPg7oQAl84gKWSUCJi9nqsflDqRw8kJ29BUjexgWInJbu894lIcGsq2Uf1hbw9mFZh9dSEluFlvBpNrjvazh2Kl/rrSUUtk3gnJHl0QhDugQPkozoWOzTiQvkF2YniIHufDVeHAYc4HxJSavleGXortMNMiYmpfmucPxABynELrE0D3ssbZvrp6hHW4zqqUMGdR+par4QDzmqrO1jlbSyKiLZ2zj6ZAwNF1qyAH7KlWgpicZU1o7k1sfUEdr/lCo75evAf50Jc7Bt/D0851eCX+YAgzYoQVXbquR1F/wnNUHvJcbGKpNdgEpl3AapbmhrXV7Oo8b4JUdZgg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc21beca-dfeb-4511-4a9a-08dead1385cb
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 15:07:29.5220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5CBZl54GKHQt+LFT0+A5cY5YrAF7HD7tdgerGtZug3Bii/GhcUw/BNZTt70He3WzKDkMcfT2ooEZWLVxrb3Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=949 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605080152
X-Proofpoint-ORIG-GUID: 0lZCIAJ3mpPH9rz51aLYyo6_bEYSfaJd
X-Proofpoint-GUID: 0lZCIAJ3mpPH9rz51aLYyo6_bEYSfaJd
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69fdfc36 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=SLikFv46wgSqiEmqxikA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf
 awl=host:12299
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1MiBTYWx0ZWRfX26xgq9qHO944
 GG76QVd1D4ZoSCqr6nWpIvL5bIPRAcD7qOsW/4fR2cd1+M/beWUPAIkUyEPzGXcetNP769qlU5e
 9j5cWqtOVkwlGOwSCODYJg/4Kt8Pcs+g8E2o4zkHFbne4NWweqngbgn9Zgn3Jk3zfTKBGQJoftC
 /d7uCJMcy8XB04up1AqZGT4jzQCyKNFLRvCEQNJHESocBneH5jN7YHPotJiWnvt2J18q2YKYAWI
 wcvmStCD4HOx725BW09ZRelGJUi8f9wlc+WQqrgxeGfttFdqsSN4MGnIZJpaSV33I3vVHHahXjC
 8hccloxCQAI5OlpIntu5NMgWzCWl+v300uwZxkzbNf0jfZwt0eW7XxXweHCegnDqCYyeAeeJ11q
 DsTP/Y+E9lqPWVY1hv1sbJVPQ5oSeZOZETkGtF7Jbag+kVimZr8HMvoIdzxpeXGyIvUexaz6V3o
 Ust1g/cmczEY05oFWb6U/Wl4skQ1iVejvNg+dcCw=
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
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


On 5/8/26 10:37 AM, John Levon wrote:
> On Fri, May 08, 2026 at 02:33:59PM +0000, Jag Raman wrote:
>
>>> QEMU maintainers can correct me, but I'd think it has to go through a
>>> deprecation cycle first?
>> If the code has to soak in a deprecated state, I think an “Obsolete” status
>> better fits it as it’s replaced by vfio-user.
> Are you saying you and/or Elena are still maintaining the vfio-user
> implementation in hw/remote ? As I don't think there's anything happening there
> either.

The vfio-user implementation is the server part of the vfio-user client 
and it utilizes
the x-remote machine object. I do maintain it - I proposed a fix to bug 
last week and
reviewed an alternative proposal from Marc-Andre. But if no one is using 
it, I'm OK
with removing this support from QEMU.

There's no active development on it due to a lack of inbound feature 
requests. Are
you looking for any specific features?

If you want to bring the maintenance of this under your purview, I'm OK 
with that also.

Thanks,
Jag

>
> regards
> john

