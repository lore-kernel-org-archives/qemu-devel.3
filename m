Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D535C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 18:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMAYw-0002oF-UZ; Tue, 25 Jun 2024 14:06:51 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMAYC-0002im-SR
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:06:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sMAXH-0001Ya-Et
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 14:05:36 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PD3gHN027737;
 Tue, 25 Jun 2024 16:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=UzPhpBGyoBLyzA+Ra+9DZYSnxN4kfaynfijNfM091gU=; b=
 C0GVChGBvUvlWwTx1aFG/9a4P3u7d/qayTYanu24UQ6h4ihSCsFlprSxesL4ywB1
 M8XI+kzV7kjNgaqN9sR8zbX13iyoyx85rAXBPnGm97PfUb079mr5EotTin7BIyBG
 ObT4WMdReACUipn/D8qQQq7N7x9ch38ylcTAkSp0Lu69GPp3Gm3s8JL2rNtnj+kw
 0ktdsCYwzZHfZUHPfAhjshdk5u2rXhBT20JZZjtbVLb/28HiDOTiPMQh1pb3MyRT
 2yw/O/qNMH+heZfkisxrV586EmhzhAzooI59UN6aSqr0XmBvVchB1AVpuAAHvYxj
 66wgJqDiZa0A3p96KZuVNQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpnc9g6n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2024 16:31:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 45PFOwPQ017796; Tue, 25 Jun 2024 16:31:30 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3ywn27sn8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2024 16:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTOPaR0cIdE6Cg+8Y2tVhaIYLg/X5U5pI6YCvAthye/CN3PIFhg0t+9RnuDwQaH4dpel3g7WWi8/l42RcGv7YJ+I6aY+kiIDpSP3KT9GlMZ2fAlKaS3NGcEaU2yQN85F7cVW0/m/Hwo/Necnwxj5/0H8+7BIe1SbJbNnYCxYuBCGp2WqNsML/73QcGXChH4mNeBi1bCwvWVcFKKwTbbEZ3aQj6rIqG0wimOM1Fulg7dL5HRiehFAWemFhiQBMB5Qz/xq8pVqPIRkUhG8sv7N99OA2hM2ixR4KZ63SYmBv8Sw3MaPpb6WkeCAjeZyuxLiesr/1pAvp2tTtErH79WHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzPhpBGyoBLyzA+Ra+9DZYSnxN4kfaynfijNfM091gU=;
 b=bksdArropY+9dlhiwNnoPO+kjNJ0c8rRCSevK1Etu8PYa9BCpGtA9CryyBqbDp4/raHpaG2r2yT5+ZQ1P202iQm74G7ynd7b4nu0ZhPao2HKV0AgK9GeK4oFnhgbeZ1Ww/NMrhieGbhzz6xq2wm6ZzlXUyzYcgKG+qRpA6BYHrtDa8eGXiVu52K+4juJtw2bvnhSM7gHDM4dpTuuE5znY4wMfeiPAV55IXqZlq51FZFZ1VRJWg//8Cr3VuL6PyArK7QLaUM4kbsHSFs3mCcBStHQZiHOfVMDblTJUE90lJiqGKNoAlyuHYq967OOY8vl5rew+g+mC+bpPWRCbDVRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzPhpBGyoBLyzA+Ra+9DZYSnxN4kfaynfijNfM091gU=;
 b=FuH9fZjGrvCRBbj4c+Cfsz6KoCXcd0Hn7zdaaUCSVoD1NQwFEhZTWp+Dwnl5ik9xmwhnlnb51FAaqqCFoDO0FnEacVyvLNuxGWXOxrcWJxc31j9ZL/tWadxZQSyZb7Ad9gb287+EX5I24TB5wi/hry9Ydemk+aecPjr0kESWLWE=
Received: from MW5PR10MB5876.namprd10.prod.outlook.com (2603:10b6:303:190::16)
 by IA1PR10MB7165.namprd10.prod.outlook.com (2603:10b6:208:3fd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 16:31:27 +0000
Received: from MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a]) by MW5PR10MB5876.namprd10.prod.outlook.com
 ([fe80::4e4b:84a9:89a9:c43a%6]) with mapi id 15.20.7698.020; Tue, 25 Jun 2024
 16:31:27 +0000
Message-ID: <5953224c-9763-4806-ba72-c3cd87a71210@oracle.com>
Date: Tue, 25 Jun 2024 17:31:19 +0100
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
To: Peter Xu <peterx@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com> <ZnnL42_iDip3hfUh@x1n>
 <9eeea2a9-b3ef-4791-94de-fb06ad2bd9b4@oracle.com> <ZnrZ9W6WpvmDBpgv@x1n>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <ZnrZ9W6WpvmDBpgv@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0420.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::11) To MW5PR10MB5876.namprd10.prod.outlook.com
 (2603:10b6:303:190::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5876:EE_|IA1PR10MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1755c5-6c16-4a8c-1ed4-08dc9534428a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?LytIRW1jSytVYkREM3B0NGZCMExBVXlDSEQ2dHpheDRIUzloSFl3UjBiNDJy?=
 =?utf-8?B?UkFhSHA5Y3BTUWlRRjhQNDVlS3dBN1pyRHc1N1FqSmhvOGxzSWRZTXo2TThq?=
 =?utf-8?B?RXRqNTA4WXhvQVRmMFNVUThuM2k3Q1kwTkdxcXVGSmdvUm1IK3pJS1o4ZjBt?=
 =?utf-8?B?LzNUekRqdjdDUHN4MEV4TFJEQkJwTnE5dlJkZjhsRUI2NmthamhQR09jWFBJ?=
 =?utf-8?B?Sms2VGd2bFg3dUZYN3RsbUUyYVpVV1NOMjI3WFhNajRIWnlJdk5nMmNVb0tl?=
 =?utf-8?B?OFlheTNEeXlWV0krYWpUemlYdFZIWDBaWGVVSDZrR21mcmhNSWl3enZBSk51?=
 =?utf-8?B?NEYwTXR2RlZIczhWWkhYOHJRMnZWZE9vWktSQ29zUGdJNVJ2N2xOdzNhVG5Y?=
 =?utf-8?B?V0I5QWxVeGJUM3NoTnpkR2JoeExSQTltQTcrTys0UXludk1RL2dmUElwUnpT?=
 =?utf-8?B?MzJnYm1rbktGazB2cFNHNjhUbTloWnpoaVVEWktBVWtydnFQdGU5WllqNTFs?=
 =?utf-8?B?VExqZ2g1d0ZGQ1B4MnBjRnhxeHlEalBoRm5UVlc1cE5LSWErZzIzanpFU3Yw?=
 =?utf-8?B?NFhTSHI3TExmRHFaem43Qjg0V3lBZFZYelljVy84TWhFZzh0V0s2MFZNTndE?=
 =?utf-8?B?ajZkMFU1SlBkdXM2MXFOenRZQnREWUorWFNkR0VaZlg2VWw0dVNIWitPVVVE?=
 =?utf-8?B?QjRTL0NDN1JUTG5SdGZFcmh5UzhEN05IVGkvWXJicnF3SEo3WGVNN2QvOVoz?=
 =?utf-8?B?VFg0TkM3Q1drR1BUZ2hWUlMrMGMvd2tnaDYyOXAzUTJ0ZHRydzE1UyswTGJw?=
 =?utf-8?B?aW11WmpBcjBENEFUSjFRUDBTdXl2SCszQUJ4RSs3ZFZ4UEgrVjQ4SWcxTlJx?=
 =?utf-8?B?aCtmQURkdnhSaHkwekZ1MXNVTmNJTVRCRjQ1UEM5cEF1eVN5QmpyN1ZDQ1ls?=
 =?utf-8?B?SlVPWWVVNTUyQUw0NDlSbUhyaitiMGdLL0dQU1Q2SkZvZ3piSDRMZEt1NGlW?=
 =?utf-8?B?K1cvSFhkOTJ6em5PZE9ZVk4wNVh5M3QwU0JoeVB4UGNVWC85N2RscysvUFlW?=
 =?utf-8?B?b1NMMHR4bnlqbmNnWkE2OUdLRlJ3VStwK1FhTFlwdWlNY0J0b3JVbWtHZkcx?=
 =?utf-8?B?M0JHQVlFMW1HRDFUcVhsMUVBZnNtcVhMVVlDWWdtdTBKQ0tVcTNlaGdIeitB?=
 =?utf-8?B?VlFLMXRjQzAyamNUc1Z3MExZZVo3WjNDOG1tRGJDMEZPVHEyUUVXMVYrTllT?=
 =?utf-8?B?S0Y2SU9Ra3VSMHVBdmxBU0thSVdQSVN3bEZLS0gydlZOZmdxZkMzNHpDY0dT?=
 =?utf-8?B?aTlZdjBNWi9XN1E1VkhtVHFDQjJJdHEyUzVGZmsyRTRRSExyQ1ZzS3BITzA0?=
 =?utf-8?B?WUpqRzZaR1RvaUI2QjFhdmhkcS80N2IxTWdJTXphQnZ5UGp0Sm5jU3puZHVh?=
 =?utf-8?B?Y2ZnVmpTUWs1azNjTFp6cFhFemkvMzdrTFVocmpGcjVOazl3Zm1lYXBiVU8v?=
 =?utf-8?B?N3JNMGpkRzBwc2RLQkNmKzBPeWVhYmRJa1l1RDVMU0gwMWE5TlluTGplY0Jw?=
 =?utf-8?B?cDMrLzhyRXc3V3hVR1htTC81UElMVnBLQjRuNDRlVUw4a3hTdkNuZWFRcmE3?=
 =?utf-8?B?Y3p1N2M2a1FXc0FUdzZUT2dIVHRoZEY0UlZScG1mUjVqbWlGMTNSWGdNYkhM?=
 =?utf-8?B?djJvSlI2QlVmK1JqS1p2bUpSbXR2N0NaazdoaWRCV0ZyT0Z1Q2FnNCtHMlVv?=
 =?utf-8?Q?9sI3HMvPmHWp6vxZIE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR10MB5876.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(376012)(1800799022); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajI4NG51SWxta0xKTW1WZ2UrNytRdFRzSHNWbERuQXpqWFhDaVJoOW1MYjNP?=
 =?utf-8?B?NWJvR2lPb0NpMUJJSFdpUDZMUlBTaGRndVBpZDNjRU1iYm1rUHBHZjBuaVQy?=
 =?utf-8?B?czV2d3lmNUErOEFZQ1BSWkFjcEZ2SGxwTVpWYWVpMkNZNWFqc2k1Z1lXN0I2?=
 =?utf-8?B?bkVDUzZBdUJMczgxM1dqbGVsaytPNVh6aE1pVW1mQnozbHRBY0M4V2JRYjI4?=
 =?utf-8?B?UElIczhDSnBTNzFKRGo5b2tId2JOZGQ1dnRjRmtwSGFib2xUSWNPR0VQcEF4?=
 =?utf-8?B?K3M0RUFKSW9qNnBhY3F4N1JtTEh3M0J6N3pjcWNwdkgvYnVSQVJFUVN0RjNq?=
 =?utf-8?B?UEpOdnorbkl2ZHpHZUVlZmZ5WnA4enhobWdUa1FWdlVmVERBaFd4eklBZEx1?=
 =?utf-8?B?Q1E2NzhzNGNOWmF1akg5bU56dnB0a0ROMG5tb0VKUWkyK0VaczkzYnZWeTAw?=
 =?utf-8?B?b2JBbHVxbmRNK0hkOGlpVnRCSlVWeDZlTWRxNW5Dd3VvZDNCblVIZzJaVWpE?=
 =?utf-8?B?REVGcHJNY1ZRcFNYdDF2T3g1bnFtR1l2Z3RlQU5PSndqaG1DSjlNa0hxVWlF?=
 =?utf-8?B?SU8rVDBQb2UwUXB0UXdyL0lDVFJFZUk4L1QwQlJTK1RtRjZ3dmxvcDdDek85?=
 =?utf-8?B?UWExZnVpVzRLV2Uvb0ROTWx5MHdVTHlhZ2hxTDM5aldycFNpc0FsUTd3MFV1?=
 =?utf-8?B?UTI1MG5FVmk4TEloYXZoeGVJRUF4TVBFY1ErdDY3TUlaMk5OS1Nia0c2Ulp2?=
 =?utf-8?B?WUdHcitoUElyYTJyQ2QzdG9reWJGZ2NHM2hQRS9tMnAyOENhRGFha0JKMUtK?=
 =?utf-8?B?L3VEN2dUMGtMOE1OTnc1VmRmbjdVYTAxeGl4RjV1UnQ4RGI2NkJZano3amU3?=
 =?utf-8?B?QzJXV1NqN1A2UWNkaVFCaDRzOHJDa0VCTzNWOElPLzZQOVRySGxoSHUwRUh3?=
 =?utf-8?B?eUR1ZnNkSDY4ZWx1QUJrL0lEcndXZVJMK3locktaRnQ1OTAxcEtwMEdndG1H?=
 =?utf-8?B?ODZscnFZaVg4MmF4ak1hZGU4NitrV2ZzL2l6M3VIT1ZwUVBocWNIaW5PcHNO?=
 =?utf-8?B?dy9LL3JYQlhqeDY0Sk9Ma2F2WS9RdVFYc291UHo4MnB5UUVzMEJjZ0l0a1BG?=
 =?utf-8?B?R0J2VlVWeHhUa1lPWXJQSkRtMmJkbnlyU3dHOWpyK3JxeTg2eitUM0lCUGV6?=
 =?utf-8?B?S0hGUlBOUEkyYmE4eHVRUXh0NFlPRUxEUFhJZzh0b0lKcXNJU1EvNFpqdlBW?=
 =?utf-8?B?a3R6Y0M1YkVrbDlxWm92aDBoZ0ZVM2dybWUwZDBrOW5BaGRob010RE93d2Fw?=
 =?utf-8?B?TWNha201NFhuNFJpdFRoNEtqU0FCZmFIeU84Mlg5YkRlNUtNOUQ5YjJvdXZq?=
 =?utf-8?B?bjBQbmk1dnI4WU1xcTFqVUhHUFVHb3hKanRTUEk3MVdZK1loVHBPZVdDUUEr?=
 =?utf-8?B?QTFxTjlUajUrcm5TVGpZWXhhRkZtZ2swWE9LbWtBV2x6b3lHM1hpY0MyUDlE?=
 =?utf-8?B?aFJWUnhzSG1VMTgxNHJOblFwTEp5ekpWcXBOa0VzZ0JSR2JCR3U5dnQ0Rjh5?=
 =?utf-8?B?WUVBNUtGUGtlMjJHcUZyN1FqaWhkd3lEbXM5aG5GdjRNcVBlcDZHemprTVVO?=
 =?utf-8?B?eFBpNkN0YjBtV1NIT08xUWNoNnIvZmg3QkxRNWtraGt5cVFRbDhZbzJaSnJX?=
 =?utf-8?B?Rm5nd1Bpem1HS1dwRzh3TGxqa292RnM0UDFwZldXODBNMWZoT1FGOGlWdjFk?=
 =?utf-8?B?K2k1TVJSUkkzZ3VsTk1iQzYwc3VQdmxidUwxYUFKbDR4d2xraWdxeXdOVVAz?=
 =?utf-8?B?TmUxTTVoK0R1ZDBlb3RmODU2MTZUYVNTaFdhU0J3Wnk5U3E0cTdEbVZGeHZp?=
 =?utf-8?B?TE5VNjdoRTEvdTdMSzhpaXFvYzZGR2xrTm9kVGh3dCtwZnl1SjAyNjRMMVdP?=
 =?utf-8?B?WmxmN01aZmF6VGVwQnVVOTRYU2hMV0JPK2R1d01WMHdoMEl6dllGNFUwTFdn?=
 =?utf-8?B?SFVMRkRFaUVkWmhOU0NCcUFwcThCckhKREJLZGdiZTJmcUVMcG9CR2FQR3BU?=
 =?utf-8?B?UC92djF4WFQxT3NwZEY2SkdqcC8vVmIyQ254eVlaZ3NpS1dGZXdZcXM3a1dn?=
 =?utf-8?B?eFpWVFk5WEQ2RUdSOGZweXIrK0FjSDBsa2FxZ3ZYTHpkdmx6N1RtL21SVVV6?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dfPgXd7p7uT4AWVXlRPKoQlXBN7enev2+XKcvIPeh55yN7yz1xIulIpPUShQ7VZjkkaBZOX7dFqr3oL6ypyT2Ul2ftWUDI7XIPx/jrTR6yLbu6BCCfMCT3/v8m4DeqMLewC/L4lMdOBziiH2dHzw8Ydj6epJgEbE8+nOJyyQTNIphNMlkslKPsG9etDFHxyM+WYf3epkmjMWDkdQR0I0jbva/GsbAmvA3Scy/MpZ2ZFRoxb7pWYXvOzRagwmvFjmylSDtBntC1KDy2j/moglE2vQ+COOixuwzKuC/etNulxcchpbDmO1+HqPyFG/1LaCMF2r9w1JovNaXFRrOb+zr+h4f+3t6DjBko1VFhUspH0yUwbF57PJONXnI/SP7GNgxBiakcAy+qOSFm1Tbj7wVhADkIfHt/jOAy/pRWGHEWDBSHjfZ9dqqVjoTaskRRtUxLYPIXUAw96PFBxLGnxLck1ImUp6xYoB8K+ysjCnlbiKQC4LTTqvSCN4e3YXR8AEHIQ5PXP5Uu0+d7q0yaLvbLcKE5ba6DVRnYbrF7gBJ9AXcDfJIh7eZIk8F4SdYaB+0wNmI7uDFMiY2FawV228nov568J+SAViUMOYBqSOSvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1755c5-6c16-4a8c-1ed4-08dc9534428a
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5876.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 16:31:26.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MDdlPWngM4RBU8f7az0emb3MYtBlrAidKgkiBq3C86wn7z9Cbv5LBeLVFvD2tJFiPZR9WdrisRR/u0LuELL3EhCxNSJCs+AEaawHoqdVHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7165
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_11,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250121
X-Proofpoint-GUID: QTjrTQ90UNv10uQioOriboqDafTjNjSv
X-Proofpoint-ORIG-GUID: QTjrTQ90UNv10uQioOriboqDafTjNjSv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 25/06/2024 15:53, Peter Xu wrote:
> On Tue, Jun 25, 2024 at 12:38:50PM +0100, Joao Martins wrote:
>> On 24/06/2024 20:41, Peter Xu wrote:
>>> On Fri, Jun 21, 2024 at 07:32:21AM -0700, Elena Ufimtseva wrote:
>>>> @@ -2659,6 +2698,18 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
>>  >>      if (!check_section_footer(f, se)) {
>>>>          return -EINVAL;
>>>> @@ -2714,6 +2765,19 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
>>>>                                      se->instance_id, end_ts - start_ts);
>>>>      }
>>>>  
>>>> +    if (migrate_switchover_abort() && type == QEMU_VM_SECTION_END &&
>>>> +        mis->downtime_start) {
>>>> +        mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>>> +        uint64_t dst_downtime = mis->downtime_now - mis->downtime_start;
>>>> +        if (mis->src_downtime + dst_downtime >= mis->abort_limit) {
>>>> +            error_report("Shutdown destination migration, migration abort_limit (%lu ms)"
>>>> +                          "was reached.", mis->abort_limit);
>>>> +            trace_qemu_loadvm_downtime_abort(mis->abort_limit, dst_downtime,
>>>> +                                             mis->src_downtime);
>>>> +            return -EINVAL;
>>>> +        }
>>>> +    }
>>>
>>> So this traps both iteration and non-iteration phase.  What if the downtime
>>> was caused by after these, or unluckily at the last non-iterator device
>>> state?
>>>
>>> After trying to think about it, I figured this is not easy to do right.
>>> Also, I start to doubt whether it's definitely a good idea on having this
>>> in the first place.
>>>
>>> Firstly, I'm wondering how we should treat this new feature
>>> v.s. downtime_limit.  It's about how the user should set both.
>>>
>>> If this is about "cancel migration if downtime more than xxx",
>>> then.. AFAICT that's exactly what downtime_limit was "designed" to be..
>>> It's just that downtime_limit says the other way round, as: "don't
>>> switchover if the downtime will be more than xxx".
>>>
>>> Then, if the user has option to set both these parameters, what would be
>>> the right thing to do?  Shouldn't they simply always set both parameters to
>>> be the same value already?  But if so, what's the point on having two?
>>>
>>> This caused me to think whether the 2nd parameter is needed at all, instead
>>> whether we should simply make downtime_limit more accurate, so that it will
>>> start to account more things than before.  It won't be accurate, but the
>>> same case here: making this new feature "accurate" can also be very hard.
>>>
>>
>> The way I think about it is that current downtime-limit captures nicely the data
>> part as the only calculations it cares about is how much outstanding data it
>> sends to the destination (be it VF device state or RAM). This second parameter
>> captures what is *not* related to data, i.e. costs of hypervisor quiescing the
>> VM or added latencies in hypervisor *in addition* to sending outstanding data to
>> destination.
>>
>> If we were to merge this all into a single parameter (aka downtime-limit) we are
>> possibility artificially increasing the downtime thanks to relaxing the
>> oustanding data part, as opposed to trying to capture the switchover cost (hence
>> the name the parameter) that can't be reflected in the former equation.
>>
>> So I feel like this needs two parameters whereby this second new parameter
>> covers 'switchover cost' (hence the name) with current migration algorithm.
> 
> Then the question is how should we suggest the user to specify these two
> parameters.
> 
> The cover letter used:
> 
>   migrate_set_parameter downtime-limit 300
>   migrate_set_parameter switchover-limit 10
> 
> But it does look like a testing sample only and not valid in real world
> setup, as logically the new limit should be larger than the old one,
> afaict.  If the new limit is larger, how larger should it be?
> 
> So far I can understand how it works intenrally, but even with that I don't
> know how I should set this parameter, e.g., when downtime_limit used to be
> 300ms, I'd say 500ms could be a suitable value, but is it?  In that case,
> perhaps the 500ms is the "real" limit that I don't want a VM to be halted
> for more than 500ms, but in that case the user should have already setup
> downtime_limit to 500ms.
> 

Yeap -- I think you're right that it presents a UX confusion on what should a
user should set.

> I also don't know how should an user understand all these details and
> figure out how to set these.  Note that currently we definitely allow the
> user to specify downtime_limit and it's so far understandable, even though
> the user may assume that contains the whole blackout phase (that's also
> what we wish it can achieve..), rather than the fact that it only takes
> ram/vfio/... reported remaining data into account v.s. the bandwidth.
> 
> Maybe we could consider introducing the parameters/caps in some other form,
> so that we can keep the downtime_limit to be "the total downtime", instead
> of a new definition of downtime.  E.g., it's at least not fair indeed to
> take the whole "downtime_limit" for data transfers, so maybe some ratio
> parameter can be introduced to say how much portion of that downtime can be
> used for data transfer 

I like this idea -- it fixes another problem that downtime-limit (solely) makes
the algorithm be too optimistic and just utilize the whole bandwidth (e.g.
migrating after the first dirty sync depending on downtime-limit)

e.g. "iterable-downtime" (or "precopy-downtime" for lack of a better idea) for
such proerty

Then when we set downtime-limit it can represent the whole thing including
blackout as it is the case today and we configure it by minimizing
iterable-downtime to give enough headroom for switchover.

>, and then it might be ok to work with the new cap
> introduced so that when total downtime is over the limit it will abort the
> migration (but without a new "max downtime" definition which might be
> confusing).
> 

Yes, improving 'downtime-limit' with a sub parameter above for RAM/state
downtime, this migration capability then becomes a boolean instead of a value
where it's more like 'downtime-limit-strict' and going above downtime limit is
enforced/aborted is also performed like these patches. To prevent essentially this:

> IOW, I wonder whether there can
> be case where user specifies these parameters, migration simply keeps
> switching over and keep aborting, requiring a retry.  That's pretty
> unwanted.  We may simply doesn't allow that switchover to happen at all.

(...)

> Said that, I also wonder whether you have thought about improving
> downtime_limit itself.  It'll be definitely better if we simply don't
> switchover at all if that won't make it.  

The device-state multifd scaling is a take on improving switchover phase, and we
will keep improving it whenever we find things... but the switchover itself
can't be 'precomputed' into a downtime number equation ahead of time to
encompass all possible latencies/costs. Part of the reason that at least we
couldn't think of a way besides this proposal here, which at the core it's meant
to bounds check switchover. Even without taking into account VFs/HW[0], it is
simply not considered how long it might take and giving some sort of downtime
buffer coupled with enforcement that can be enforced helps not violating
migration SLAs.

[0]
https://lore.kernel.org/qemu-devel/20230317081904.24389-1-xuchuangxclwt@bytedance.com/

