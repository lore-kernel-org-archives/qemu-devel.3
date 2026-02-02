Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF10AE7FDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 23:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn3Mj-0002N5-6V; Mon, 02 Feb 2026 18:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vn3Mf-0002MY-HF
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:29:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1vn3Mc-0007NY-Ef
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 18:29:52 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 612JFVA01113496; Mon, 2 Feb 2026 23:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=25PyP3m52IeoXZkt4AyzYEBknf6IknaB48B6Gi7PBI0=; b=
 gI4TZuzw0wgkX7h1HrqbzbRgYD5qgU3NCsBZ2CUX7fPxsg6jZLe1jthY4IXs1pC8
 HqMXlk5AzWb2oEYA4fGLKUpy9cKkwc3eD6UKmejZdxfecE4GlHPlYY4lRWxKI9Pp
 Jcw/vFzfuRckEItcuCraRrEunA0SFY4ZcdZNykA60Z6wX6Zoyvk8LzgZIrI67tRz
 Q6WtF7A3g4DG+01RXTi6nvEoHiCb55/M63rs2mSoWAlKlzn5RHkbrE0uOvsDYCtz
 aZj3XJdX6HJwWHGWBCqD8xrn1//mv/Fg5rpceKCwwDGUSqZyouubU9K2tFcMCPOK
 JqY3XmPMdyVJ+oEDsbn2gg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1avj374a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Feb 2026 23:29:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 612LSZaB024115; Mon, 2 Feb 2026 23:29:41 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4c18692u3k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Feb 2026 23:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytQEvzRgYgaqe7cR84N72WgninC8A3ta3w/BsOfQ0Rp40g1VD9HHEZm8fuFx1+WEo2WIirY7YCqIqGZxO3iM+3jX/31Ys9S4WTSeo81+QM/jTJeCnlB6axuOYCZmsC4DdQkUTixiLdHIWoehvKTCFg2EnACqrzRIRuH+Ol9JkXNDfTo8UdL4n1crav77Aj0VpFSaqBU5ZRDk5wCYn/wKBjduhs0y5wFiMXIjpS3qFj61cMdMDgRzLR7tfmIshkZT/V06ng737+HEOv2XfTix57y01gI7cjbeh0lRF9mM7aaobMKFljIMr6Yh9gD6EMaJbI55HPnAPvxsS5m45o+P1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25PyP3m52IeoXZkt4AyzYEBknf6IknaB48B6Gi7PBI0=;
 b=Vpwy2rJgB5irFAkZH4Lnd9g9S5scXrpc6rWmHCccLTaR7zuzUWSenrN5gSswJIPrqvacVNwp5U/gy91y2c6T4hJwqKQIbqFlcgKuCiY1qmvanKJplN0rj0HBPuY+s9l4T1p0X2WR0rtpbeY0c7Hp4IWpvRyHqy3UyiLvYLnN12huP+L66TD0c6bQzGgFgbmJitcdu2CkTfDjgOxGK2LoWyf+AeDPqKP9gQQb3zfoPjAefcy/xm80wodzuGsxUo6dWohqq9sTG4V+gOJHdaUwBk3EqG8cMyicSniQeurNtdtZYKfuDUOKNoaaLn24zp0tzKOQ1WLHYqmphBZYgS1rhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25PyP3m52IeoXZkt4AyzYEBknf6IknaB48B6Gi7PBI0=;
 b=qE/1HRs94Dz6EKNO0WfNYHehYZ8lcuqeosOE63rtHEaXDchys2dY+5rfN04YwJwi7D6zp64TWg12gDc5vhz8juvpAIg+y7ybUeh1Rtsqx+bbYwb6xqaSP1+cj8dpQueOoo/alcovqVLx9oT+IX+tv7TJvNPnj0vC5a0PgmmBc7w=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SA1PR10MB6390.namprd10.prod.outlook.com (2603:10b6:806:256::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 23:29:37 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 23:29:37 +0000
Message-ID: <e91cc0cc-bbdd-4d58-8753-7ba267aab79f@oracle.com>
Date: Mon, 2 Feb 2026 18:29:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] amd_iommu: Generate XT interrupts when xt support
 is enabled
To: Sairaj Kodilkar <sarunkod@amd.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com, vasant.hegde@amd.com
References: <20260129102814.4488-1-sarunkod@amd.com>
 <20260129102814.4488-4-sarunkod@amd.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <20260129102814.4488-4-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P220CA0092.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32d::28) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SA1PR10MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dd9b65-0295-480c-fe85-08de62b2edca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFMxZDJybVBieGdreVFROER1YkVJVG83ZHc4QjFVQjdpU0w5dVR0cStHckxX?=
 =?utf-8?B?QnRLRmw1YW1wWVJORzJqRkozOG12amZiMFFoZFluVzVXbmc1WHVqRzBsamlS?=
 =?utf-8?B?WDUwZEtJQlNJWUJuZTdwdlltZVdyY0Znc3pCUkk2WWJyUmhlazhrb1VXSk1k?=
 =?utf-8?B?bU5WQXhWcVRSMTFnRzZLZFoxcjd2cVRiYjlqMFQ4clpwSEpERUdrelJrU1lz?=
 =?utf-8?B?d0J4N3NBc2lHTk0wMlBVQkNwdEJYY3VhYXYzdDBxMnU3ZWNFKytOMVBNVzQ3?=
 =?utf-8?B?T1F2NDRaVXhXb0FRUmZQaEZ1Y1Jma25DOUNXZnRoYWJkU2N6dEVHbzNvWk5s?=
 =?utf-8?B?K3NkU0dMb0c3T051ZUdXZXhheXNMcnNUTHZlYmppR0o0OTdCMEs0b3hpZnZt?=
 =?utf-8?B?cys2eGVydkdTMUJKVFpvMHJUOFlQQ3BxM2ladFpZQUcyaWQ1d0luaHRRRUNl?=
 =?utf-8?B?bVljd3pCa3F6YXFjRjB3T0MrM21LUTg2UFgvVUpoTFBtTGQwakRncEdBcVdI?=
 =?utf-8?B?ejhYcFJKQ3IwNnpCS0wzdlVMYTlUVVErNm9oSVN2Ny9WU2ZPWUhsVGdZVG5h?=
 =?utf-8?B?cGFQLzFlRXFBZXBSRC9PYVhxU1BFb0k3OWdNN2dPcEMvcmduc01kVG8wZ0pS?=
 =?utf-8?B?SlFpMnFFUnFkdGlLbXIvS1ZmcUdjOThCSXdrZDltMXAvU20vK3V5QnJKYzB4?=
 =?utf-8?B?RTBMb2RubmprREtrSCtpOUQvNFg0SGpnMDc0NnNhYTRrVVNTeWRqeE9CMmVa?=
 =?utf-8?B?b0FXeXRYVzAvUEROc2RLelBONTFnVEFPWExOSWIxTCtDNDFOMDhqd2JXYW8v?=
 =?utf-8?B?aXZ2MFAvSlVXSytzNmp4QWljY3pWWnlDWFRiSWVDMjNUZU9yVUpaNG8zVUNZ?=
 =?utf-8?B?S0tZSHNKLzM1VEtjc2NqemdQUHV1dldzSTl4ZThlbkpPOTFJWTdmLy96cWFm?=
 =?utf-8?B?czNVaWkrdkt6c3FFYm9BMEFSeHRkZFdrNjRiazBkNmpuOE83bS83Y0pJbUJ0?=
 =?utf-8?B?ZUVVVW5neWNNdllSZ3J6ZGx6MGZudFNPRFhvaGlaTkt6MjBVUEduK3NXb0dt?=
 =?utf-8?B?OTJZOCtWano1WTVTSmV3RlQwd05XQ0hKS205Y29pdUxWUVcvY09SQkVzWUhS?=
 =?utf-8?B?czg0NkJuRXB4Y2g5RGlyZGJ6ZkxTRGkrUnhWL0hiSzFtejNQUzNLMXBjejBr?=
 =?utf-8?B?VFVIUzBlTSs0NFZMRktGaVpnNTFMUExzcGFwMzdjcCtsWGJlUG9DeURhd0Yy?=
 =?utf-8?B?ck9VdkpJQWJHZCt0WE9MVXRUMGJHdmNGTFh5ZDRFNGh0dzNCMUlYbjBuUDNS?=
 =?utf-8?B?S1crSjBWSzI5cGNZMlc4V1RVbDdxVktPK3pnbTA3Q0FUdHhwMXZiTzZGL3h0?=
 =?utf-8?B?NVN5OUhla3o5UzJGZG9zSE9tUno0bi9DYVhKTitWcjVkU05BSXNPMFBXRTV2?=
 =?utf-8?B?VldQWHpyOUsrd2grRkNBOXdwbVVPa2hMY0x1bmRZVDJlZmpja0lubnppbjF2?=
 =?utf-8?B?aXNMcXk5a3RmQTBNY1B5aXFuQXFWRi9ZZ0VrcUpxZGJkaWthV1dCK1FvbU9S?=
 =?utf-8?B?L3Y1YzNVeHVHSUpFYmdGdG1UUEdPVUVaemFkQzVUNWovU1RMWTR2bEEwVGpk?=
 =?utf-8?B?NDdLdlJmZ25qRElxR3JMMlU5MTBXVzk5MU1rQk5TWTVXU3kxNU5JbnZEdExj?=
 =?utf-8?B?RisxUXBvaENRVys2V0RKeTlramZma0Z5UFAzRmdYM21WUnRDZFpqRlhPTHpi?=
 =?utf-8?B?bGxUaHBqdENxN2RMQXczNElzQ01uYlBjc3BuUkpVOGpOWGZPTlJvZkQ3YWZz?=
 =?utf-8?B?RFgrVWFCczB2RnRmdU5pWkY2ek1aOFpGR09OQkxHenF3QXk2ZGNQYlpla1Fk?=
 =?utf-8?B?a0tTbGVXam81bDBiZHNkT3FaNkpWTGEveGVBM3RWQ3lmNHFYL2RxMjRxK0g3?=
 =?utf-8?B?NVNHUGdtTzRZTU1LbDBFUStmcDZxczNLOTU5SEhaNS9FQ3VleFg4elJ2NkMv?=
 =?utf-8?B?aUlSY0pZM0NYTWZnSFUxZ0tJRFk3bWRySE94VnFuTVhTbzJXMnZ2NXpoQnVr?=
 =?utf-8?B?SWMrTCtIM09PZVJWMVZLYnAveUtCTHNCY01ZSmIzNldGRFJ3Z3FtSXprL0o0?=
 =?utf-8?Q?747Q=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L05BeWRQSnhZc3hKek9UQjI5QmpSa1F4ajYvYlpYOVdVVGJZVEdBT0tYSnZx?=
 =?utf-8?B?ODRJRlJmWjJjdXZIVTQ4aTM0VHhudk53S043Z1BzMHRTTEc5UDNMSWE1THZa?=
 =?utf-8?B?OHRmRElHYUNWL2YxVEIzaUQ0alBFai92c0FJc1ZEMEQ4aHZJMFBKckRodDZX?=
 =?utf-8?B?R1hHZEFBZDVRR1NOeGpoMEwyazNRR2pKb2gvMXZqVUIyWEUvdDFuYTZEZjN6?=
 =?utf-8?B?WnJIbWtnRHBqUnNscWpyRzFzakppcXJQVVlaWGpYMytzanJhN2doUERRODdi?=
 =?utf-8?B?T0ZvZWhNUlVjV2FWWUVXUEFLNWlzUG1YQzNLemx0MWorQ0tpQWN2eXBOcUsy?=
 =?utf-8?B?QzVLV0FHSDZGL2lNSGp6ZGtkakYzQU5Tc3p1SG5DZG1nMDUxdkUrVUJROFVx?=
 =?utf-8?B?ZlJFaDRQSEZTRXo1ZG9sSHJVQnlxTHM5aVBDeDhOc3NaOGUyT0sxQXRWcjRo?=
 =?utf-8?B?N2h3aGU3UjBLNkc4TTE5VVdaVndMLzZIQ3IzK2NhN0hDVDU4bGxpUzQ3Vi9G?=
 =?utf-8?B?M01UVkx4ZzJ3dGFqajh2Z1ZkSWQvZnd5Y1IzeWZNdDgvSCszNmNMZEI4UDB2?=
 =?utf-8?B?RmtKWkUvN1pTNGdTUkMxbHIyQ2RXZnJXcndOVVpBTlBiRlM4OEFSeEU4OGw5?=
 =?utf-8?B?U2ZYemFCakh0TzhXYWFQSjJmNnphQzVIZ0kydEpVQ3NVQU1Ya21MRU1zM0p3?=
 =?utf-8?B?blRBTWplM0tldWowdlhJdnhsR05NZ1kwZWZGUHc3MElzZ2s1VktGN1J4Umxz?=
 =?utf-8?B?am5neXh5N01yUHJVNG9FOFdpZzR0WVBEcHptMHpid1pZQUZyTmhoSDhJOG05?=
 =?utf-8?B?aGtiV3hqWXh1TWxKbytORGI0YnJUVTlWcWwvWHJuaG54MmpNN2oraUlCVTI1?=
 =?utf-8?B?cE9MeThUL01DUURYdzgrSVE5WDZOOVhqSHRFWDdqOCtWTitnRG9jZm5KTXc0?=
 =?utf-8?B?QXhZdWtMbFdTRmY4UUd1TlRLZUpXSkYwemwwSE5wUUQyS2VTYWhXbExzM1hQ?=
 =?utf-8?B?Mm5ia0JKNWN5WnhiNG5kTU9TaHBCZHVoMXF1bWd2b01Ec0FmOEthc09qc2U0?=
 =?utf-8?B?dW5qTVY4ZTQ5anJCbExkU0ZxSnNJbktLazl5T1RHbGQ1WFJFRlg4bWlZbk1Q?=
 =?utf-8?B?ZHF5Wm45cnZJNFVpdFRGREcyN2RJV1N5dklmajZCcU5sbDJCckwrTW1rT1lK?=
 =?utf-8?B?REswYXNveUxxWGI1Vjd5T3oyUXh5dVBCRGJSZTQ4WDZSdUdjT3g5VWVSSldy?=
 =?utf-8?B?OWwwSWRXVUJhc0FQQzVyaXlKN0VEUjIzYnZ1OGdpYWlFZm9seHJCbEloWDRG?=
 =?utf-8?B?bm91ZWRSOXNOQjh4RjVidWlHWkp0SlBwNkhBbFhkYW1PbzJBb3BaMjBRVGEy?=
 =?utf-8?B?dE5xekhFbGlDeVFwSlVnZzd2MVpPMXljbmpRdVpaVXkxOXpRVXcrczJSUDRn?=
 =?utf-8?B?NnUwcGRwckdobkxRTno4dzg2VlhJeXlraFc2QTk4dlhrUW1lVHRIVSt6S3I1?=
 =?utf-8?B?YXFmeDRod3lXZ2ZHaVZzKzB5bjZGVWs1V2pNM2IveU1ZRkNGdE55RmNTbTNx?=
 =?utf-8?B?TDNGR2lhZjBOajVyY3FpZEpQRTJUN0pxZXRwUy9CRVFOTTZLSkRvUCt0Qmty?=
 =?utf-8?B?dy9KL0FwcTJldWNKZTFNd0lvVlZnbUExS0xnKzFibHg5MHhRRk5RbDVaZTBk?=
 =?utf-8?B?VTI0K051Rk4zOUwwTldEWEN1Q29wOVBRQTFkSi9rWHArckUvcHNUMUVOWUkr?=
 =?utf-8?B?dm82Wi8vL3BFZ3cxOHBQc01ZenFvQ1NpVTkwUytjNStkeXVGNzE2a3VmeVlZ?=
 =?utf-8?B?QTVjSXNTcExqaEZhaGc0S2tmTFdEc09BekNWMC9URkl5S2J6a3lsaENDY3BJ?=
 =?utf-8?B?bWdrVjZ2RU5BMmg0VDRDYm5IdXU4c1o1Z2ZQK0NVS1YxdjlQSkhKVGJuOXVV?=
 =?utf-8?B?RXM4cTI4QlZla3NxZVVoWS9Hb0lGWHJOY3NZUHdYZWZaTklPa1FIMmtHYmRa?=
 =?utf-8?B?YThYY293OFo5M09jTm85djZuSHpGUjdsU2Y5QWdvRHFQT0hLWTJRR1JSZjBF?=
 =?utf-8?B?OTFTdHpJMDdHMmZnMHI4TUpyN0l0MXJ5dG5mamJEaGtEeENxbFkrTGp6cFBm?=
 =?utf-8?B?cnpkSEhDVGFyVU91NExHWnJVWlhYcEJyMVVNZDJaOWVySmJIUG1IeERUODZM?=
 =?utf-8?B?cFhmaGtZeWVuQUd6Um8xbGQxMStSNm5NY040T2xnc25RYkcrRFp1eE5QWmox?=
 =?utf-8?B?TERiR1piUW1RYm1ZV0pzME5TYUJLOHNQWFMrZGI2VEhJejFHU3VIMS96ZnVN?=
 =?utf-8?B?Y0pvODJGUGxhaFhFU01nWDVIbDMrV3psWGY3QjJYb0FhOUZDZUcwRlJVRmtP?=
 =?utf-8?Q?j82J5TVAS4qFN3Wo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oCUUDJ4bDgR9JIKtS32F537wZekJC0eeHhOlrwXdjr2AQT5deyN1BsCPo3tk2OevfthkabyS4BcLhPXeoePFbRRGquxuTYidSa6iX67BpKixd/sXnQL69eRsXfmwCfwUBBIno5nPU2lIMv+fm4DKNHLz73kI0ITwqywty7rcuP1pnDegA7c0I1vN2UKb7jMBm9mMd5AaIoiI7xanNypAdm65ZAErXjQGWFMt3gTJ5ewk9dgx7V5+7QrbLy0md6KudsoFLLkYG6G7oTtN47riShgCOtSNkBFV+8k8Hrx/jlKnuU+YWfEy4j8psCzytF5HRrRvYDLiZIiacn+QlUUqUGhTh6MKKvdwfNtHrfDyiouxY0NK2BmnawWgf/h4Id35iiIW/h/berYakTp+uV+J8HdK8SxaraqVchSeyDwZwSDPxd/1XvHKzHh0ns5s/Du6g+lCoCqZ6TjK18gtYLAz5Hun7XzJSfPexQiZ2l6Q8YG9qN83t0iZCi3Etf9N+65OBJaY+BmsYRnd7tNtpSj+uADeQLT18IVuBBkbw2D8oVYf3z0/0s+zKFaG7gaVShRaWW62Iqez3ti31jVzMPJQ36F1jXA+i541rqkS3bUuXd8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dd9b65-0295-480c-fe85-08de62b2edca
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 23:29:36.8320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FKfgv+UeCHcwK8NX+w2iW4FNJSublHcuV+lqizEaOUw2IP7pRRm7w5rBQCLIhUcH+TXuluKgxauPkjjasU+Icc8Dv6sAUQgNbVK7+phQFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6390
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602020185
X-Authority-Analysis: v=2.4 cv=C5DkCAP+ c=1 sm=1 tr=0 ts=69813366 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8 a=8zwtmKUGEUXWUF6YR8gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE4NSBTYWx0ZWRfX+FxjsZEW1qEF
 T9xc3vRuSuAV5h823f/cYslImTFMmfBDgVbokuojeO/TvzU0gMSIIgpUNX4IzQ+anx7x5PfZbLF
 u7Lj/gxNWepCUvYMzS/DOPXD7NU9xjbTGVqDF0n39sPOwK2OGyExrcuNSjKc/XsgYjLFcJTV8hr
 wYbK+SdzRi9DGmkn9SZuL7zM0XgjysurUb8AJ423X00Jbj16vT2kMgTSr4isxtZQ2OqOAn802gA
 iaBIa7NLXt5Jx/5nj78OWVFNjSudFi5WXitJolKYlKp62/rHra4zBSvHR9p3kFNpaK4tkpr4MBG
 Yb7Rmk/4qOX2J20quvudt+LeroHYn2LQpkpXU2/uJrE4hEpgpKvkGjuVw4pS3RPCs5qepiIEsiI
 l0horlFE+7Bs78fHXqfk8pfn3PnTX89ZCgqrInBzsRasIFys5GxzQgx1gxR3WsbLyQgk49mJfBA
 jdljqqKtR1JCW1RqZqA==
X-Proofpoint-GUID: ghz2cGcx_hoMAvEYcRrgv0aP8-eBPPRb
X-Proofpoint-ORIG-GUID: ghz2cGcx_hoMAvEYcRrgv0aP8-eBPPRb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 1/29/26 5:28 AM, Sairaj Kodilkar wrote:
> When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
> sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
> 0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
> The guest programs these registers with appropriate vector and destination
> ID instead of writing to PCI MSI capability.
> 
> Current AMD vIOMMU is capable of generating interrupts only through PCI
> MSI capability and does not care about xt mode. Because of this AMD
> vIOMMU cannot generate event log interrupts using XT event log register
> (0x170) when the guest has enabled xt mode.

I see that you slightly modified this from the initial version, but I would
leave it as it was i.e.:

"Because of this AMD vIOMMU cannot generate event log interrupts when the
guest has enabled xt mode."

There is no "XT event log register (0x170)", it is the "MMIO Offset 0x170h
XT IOMMU General Interrupt Control Register" as you mention in the next
sentence.

> 
> Introduce a new flag "intcapxten" which is set when guest writes control
> register [IntCapXTEn] (bit 51) and use vector and destination field in
> the XT MMIO register (0x170) to support XT mode.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  hw/i386/amd_iommu.c  | 43 +++++++++++++++++++++++++++++++++++++------
>  hw/i386/amd_iommu.h  | 17 +++++++++++++++++
>  hw/i386/trace-events |  1 +
>  3 files changed, 55 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> index 850d3920a76d..742ef5d42561 100644
> --- a/hw/i386/amd_iommu.c
> +++ b/hw/i386/amd_iommu.c
> @@ -194,18 +194,38 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
>     amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
>  }
>  
> +static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
> +{
> +    union mmio_xt_intr xt_reg;
> +    struct X86IOMMUIrq irq;
> +
> +    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
> +
> +    irq.vector = xt_reg.vector;
> +    irq.delivery_mode = xt_reg.delivery_mode;
> +    irq.dest_mode = xt_reg.destination_mode;
> +    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
> +    irq.trigger_mode = 0;
> +    irq.redir_hint = 0;
> +
> +    x86_iommu_irq_to_msi_message(&irq, msg);
> +}
> +
>  static void amdvi_generate_msi_interrupt(AMDVIState *s)
>  {
>      MSIMessage msg = {};
> -    MemTxAttrs attrs = {
> -        .requester_id = pci_requester_id(&s->pci->dev)
> -    };
>  
> -    if (msi_enabled(&s->pci->dev)) {
> +    if (s->intcapxten) {
> +        trace_amdvi_generate_msi_interrupt("XT GEN");
> +        amdvi_build_xt_msi_msg(s, &msg);
> +    } else if (msi_enabled(&s->pci->dev)) {
> +        trace_amdvi_generate_msi_interrupt("MSI");
>          msg = msi_get_message(&s->pci->dev, 0);
> -        address_space_stl_le(&address_space_memory, msg.address, msg.data,
> -                             attrs, NULL);
> +    } else {
> +        trace_amdvi_generate_msi_interrupt("NO MSI");
> +        return;
>      }
> +    apic_get_class(NULL)->send_msi(&msg);
>  }
>  
>  static uint32_t get_next_eventlog_entry(AMDVIState *s)
> @@ -1483,6 +1503,7 @@ const char *amdvi_mmio_get_name(hwaddr addr)
>      MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
>      MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
>      MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
> +    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR);
>      default:
>          return "UNHANDLED";
>      }
> @@ -1537,6 +1558,11 @@ static void amdvi_handle_control_write(AMDVIState *s)
>      s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
>      s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
>                s->ga_enabled;
> +    /*
> +     * intcapxten does not depend on xten flag because IOMMU spec does not
> +     * specify any dependency between these two flags
> +     */

I'd like to modify the comment to add more info/breadcrumbs e.g.:

"
IntCapXTEn controls whether IOMMU-originated interrupts are sent based on
the information in XT IOMMU Interrupt Control Registers rather than the
IOMMU’s MSI capability registers. Therefore it requires IOMMU x2APIC
support capabilities (i.e. XTSup=1), but it is independent of whether a
driver chooses to enable x2APIC mode for interrupt remapping (i.e. XTEn=1)
"

This conveys your reasoning for not linking intcapxten and xten, while also
giving the exact search terms to query the spec and find the relevant
sections. Any concerns with this?

Otherwise,

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

> +    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xtsup;
>  
>      /* update the flags depending on the control register */
>      if (s->cmdbuf_enabled) {
> @@ -1743,6 +1769,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
>      case AMDVI_MMIO_STATUS:
>          amdvi_mmio_reg_write(s, size, val, addr);
>          break;
> +    case AMDVI_MMIO_XT_GEN_INTR:
> +        amdvi_mmio_reg_write(s, size, val, addr);
> +        break;
>      }
>  }
>  
> @@ -2393,6 +2422,7 @@ static void amdvi_init(AMDVIState *s)
>      s->enabled = false;
>      s->cmdbuf_enabled = false;
>      s->xten = false;
> +    s->intcapxten = false;
>  
>      /* reset MMIO */
>      memset(s->mmior, 0, AMDVI_MMIO_SIZE);
> @@ -2463,6 +2493,7 @@ static const VMStateDescription vmstate_xt = {
>         .minimum_version_id = 1,
>         .fields = (VMStateField[]) {
>             VMSTATE_BOOL(xten, AMDVIState),
> +           VMSTATE_BOOL(intcapxten, AMDVIState),
>             VMSTATE_END_OF_LIST()
>         }
>  };
> diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
> index e9401f3a5c27..886814770276 100644
> --- a/hw/i386/amd_iommu.h
> +++ b/hw/i386/amd_iommu.h
> @@ -57,6 +57,7 @@
>  #define AMDVI_MMIO_EXCL_BASE          0x0020
>  #define AMDVI_MMIO_EXCL_LIMIT         0x0028
>  #define AMDVI_MMIO_EXT_FEATURES       0x0030
> +#define AMDVI_MMIO_XT_GEN_INTR        0x0170
>  #define AMDVI_MMIO_COMMAND_HEAD       0x2000
>  #define AMDVI_MMIO_COMMAND_TAIL       0x2008
>  #define AMDVI_MMIO_EVENT_HEAD         0x2010
> @@ -107,6 +108,7 @@
>  #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
>  #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
>  #define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
> +#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
>  
>  /* MMIO status register bits */
>  #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
> @@ -343,6 +345,20 @@ struct irte_ga {
>    union irte_ga_hi hi;
>  };
>  
> +union mmio_xt_intr {
> +    uint64_t val;
> +    struct {
> +        uint64_t rsvd_1:2,
> +                 destination_mode:1,
> +                 rsvd_2:5,
> +                 destination_lo:24,
> +                 vector:8,
> +                 delivery_mode:1,
> +                 rsvd_3:15,
> +                 destination_hi:8;
> +    };
> +};
> +
>  #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
>  OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
>  
> @@ -421,6 +437,7 @@ struct AMDVIState {
>      bool ga_enabled;
>      bool xtsup;     /* xtsup=on command line */
>      bool xten;      /* guest controlled, x2apic mode enabled */
> +    bool intcapxten; /* guest controlled, IOMMU x2apic interrupts enabled */
>  
>      /* DMA address translation */
>      bool dma_remap;
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index 5fa5e93b68dc..a1dfade20f18 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -118,6 +118,7 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
>  amdvi_ir_target_abort(const char *str) "%s"
>  amdvi_ir_delivery_mode(const char *str) "%s"
>  amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
> +amdvi_generate_msi_interrupt(const char *str) "Mode: %s"
>  
>  # vmport.c
>  vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"


