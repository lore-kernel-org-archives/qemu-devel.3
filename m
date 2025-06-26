Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D976C7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 13:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUmYP-0004Gf-SK; Thu, 26 Jun 2025 09:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uUmYN-0004GR-N8
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 09:22:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uUmYF-0000DN-3I
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 09:22:10 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55QCaY9G005332;
 Thu, 26 Jun 2025 13:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=ZOpGdBgnLGXYVEZo02QcYTwRXC/GVB9pnh2kggZ6Dh0=; b=
 NHrkNG70656IAvqTPZUHqZ+3brRqME42zI65KlNgyt/zXVI2nQvlLJZKqJHXh7FD
 0mYjCNcnCDUD/1n7OG8SsuKlhB1xIv+vc5FgK4u5txt7Bo5cuNwNDPR6+3VhMbHJ
 hgdNbJAu5/kn0UabYMOrCspQ54mIGyeY+F93ZL7dpQ6r276SpPA/7xtk2wvtGBdA
 9LKU3jhYRXb4Ggl0wzjbzxXpz7sm8cT5H6DJJTKniJ2kbj5pxElqwX+B4M/qjHzN
 O0LIJCuJTplFnC/LDZcPjO6ihMjiCrjfOFciDVTw7lWNaMoT1Q+sGCYvwAkH2vc/
 ho6T+NKBdT32hslA7WO8UQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt1gjkm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 13:21:59 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55QDL67W012798; Thu, 26 Jun 2025 13:21:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehw0002k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Jun 2025 13:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBFGOk3rFZ+ad8+fl+EIPYGaMCxpGSPH7tNBA9+4oPIY6BH3xCTW+oqjYjolNNp7sDdBk+YnnXe9G6QGD3MTpuy1hH/enaSIYsHVrHTNYy6CAY0cxxrCTuwaCNfTjIiYWtcZOqith8koWuugWyhIIZYfnkM9U2UEH8MVM5EcNJqf6LARHeixqoIYb61Pr7YeMNup4qg4Xajn8GorgNd1mFuBeF9ABqCKt5gXghnELixNe0c+NmHtBSA4jQZxvE1cj8Ipm+b+2y66o7FvFj8wmdDYjlh1mCJCPmwwiB2eUU59AMFOU0hmiRfkpWRPTIYL6NB7h8JFhLC7C6mJFacDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOpGdBgnLGXYVEZo02QcYTwRXC/GVB9pnh2kggZ6Dh0=;
 b=DJB/2RLu7/XFerkDcixuAzIwuu08C64KHfndZa6Cp2A0Kp3uZF6qtW86i5j1ptVr4otzDJnLu+bdDThk0pP5KgYlNuwZKC0iRC7YRXiP9BqVce2u//JDGUHwoHlSkSX9i1GOB8Ei5uUgigiLsBiyEABKeI00H71CSWUilNh5uNGxGV2SWGJe5XROhtIAkyuG4PCBL4assY9JI6svJYfTVH9yd13OMWS6mEwHOsH6cF+cg4Mv6ah2HLTZBCfHVnpveLfC6xNA4E8lLsw1lhgiQLdp4P9qUH6Eq8amxoMx5JzImfxQ9X0a/2VxCAZg+b6SD8bGUYyIeNapl2+tTOrFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOpGdBgnLGXYVEZo02QcYTwRXC/GVB9pnh2kggZ6Dh0=;
 b=M2r+9y/ydzyC4t1ojRadgNWg7DnrjZJmxwUfD8N/q+QROK81CdmK+N5dde9KT92Ros19L43CL+eGgt6bHAxUUjkMni//cqHlwExyBnZAn60Bzee4n/A4wm7eSaoRyUGKUCKJ8WmP+Q5sLnnaSV2S12iWljSkO2p1A06Rbt0SkTA=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7040.namprd10.prod.outlook.com (2603:10b6:a03:4c6::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 13:21:56 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 13:21:56 +0000
Message-ID: <eb21e8c9-b5c2-4cfc-b171-cf325690bf67@oracle.com>
Date: Thu, 26 Jun 2025 09:21:51 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] vfio/container: Fix vfio_container_post_load()
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com
References: <20250623102235.94877-1-zhenzhong.duan@intel.com>
 <20250623102235.94877-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <20250623102235.94877-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0057.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::34) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 334543d7-7e4e-496b-6fe7-08ddb4b46c71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHpMZEFJQUs4UkNSck1uVVlURVVmRnpkNmhTRkZIUjJ6U2R2bGEvZzY3Yk80?=
 =?utf-8?B?aGZDL1A1bXJRaUpRd0lTeEZGMVVOeklJalRzSDFzb3ozWnRHYVZ3eGIxV2l1?=
 =?utf-8?B?a0hwOTFwcFprbEVJTUJGRFhSR2FWN3gzczUwQ1BJWmg3ejB4U1dOVmxBcE9m?=
 =?utf-8?B?TGhDQU5pV1UvSDJzeFREQXBKZzJJZHpqamJ0UkZiVmc0T3E4K3Rpc3NjV2JP?=
 =?utf-8?B?NGVia1k1eWNGVysvemhINzFyZStwVGxDZFdmaEpENGx5NUV0TDhJUWdobzZM?=
 =?utf-8?B?dDFuT3JMZEdDVFFPRS9IM3hCNkxQamlwNFhaTHJFby8rdjYxS1RhZ3MvSk1y?=
 =?utf-8?B?a2F1TTVWaGw4MnpPUDczcnN2ZytscG4xdXorOU1RaUswamJzNkQvVVEzVmxU?=
 =?utf-8?B?Vy95cmdqUzNtZXY5S2NLQW10U0FYd2dYbW9kRTNzVGNFVC9kU1AwN0pWM1pv?=
 =?utf-8?B?bWtNU0JGY1kzZWtvOVZVR25IU2dWU255RzRyUXlOZUJQdWVLUXdzcjZlSWJp?=
 =?utf-8?B?MUNjRk4vRVI0VldqVEhPMnkvWmRERzE0RVJQRzlTc1VldnF1b0FMR3UyanJP?=
 =?utf-8?B?QjRobWYwS3FNVW1Zb1BQejkzWlV6RzF3SWhGT00zRlNnMC9yT05vVFpWSmUr?=
 =?utf-8?B?OUJmY2t1cm52c0RlMlNieEVFY3Nza0dNWCtSYUliWHI3TXZpVXF2V29IV1h1?=
 =?utf-8?B?YUl4RUpUanZ1bVgyNVpnMXVzNVVrNlR3Zmd1VHZySnFZQkdzL1pvZnZDU0g5?=
 =?utf-8?B?UGVodE50ZjhadHpIK1RwZzhsM0Nyc3NSdzJuQXRsWlpQZ1dGLzJwVmxoYlpQ?=
 =?utf-8?B?a21LUjcxYXVKamxxMm8vRFpQdyt6TmxVNUdsQTVuMG5DRXdDdjcvSk93SE5J?=
 =?utf-8?B?MXlNa3BtVS94amdTNWtwR1lUcXJRb09ZTEhQK1pvbE9EbFB4Yk95S0crMWNM?=
 =?utf-8?B?QkdSbVFQcUVEa1NhbURrNWl3c24ycEo5OStJbkdCeC9nRW1aUmRJR1N4QVhs?=
 =?utf-8?B?bCtpbUozUzNtYmtZeC9OekNIZmlqVFY5NnRFa1l5MWptaVFXdi96UWFWT21L?=
 =?utf-8?B?VlJCNVppRWtsUTh4WlhUaWdPaFphQ2pRZEtBM24ra09wVW4yUGxLT0VpMWVk?=
 =?utf-8?B?bzhrZGROaGhKMWhaNDZIdlgrNUFMOWlTWlN4Mk5wanhNN2l1YXUxV0FERDdY?=
 =?utf-8?B?UmJyRVpwT2dpcEhBUlJISXpMNmpHR1lEdUNRSXhieFRxaFJRcVpMUFJZRDMx?=
 =?utf-8?B?M1ZwUEJ0dDlJelZEZS8xNGp0VlNrdm5NTUMyV0F6aFJCSzZseEZWa1QxSkR4?=
 =?utf-8?B?bzlhT3FTRitUVXEyLzJQRW5aVmJINDhhbXZZa2ZaS1N5aDRHeVk2cHEyaGFl?=
 =?utf-8?B?VVpVR1lCSEc2aVdlS05iNFRzcDh0ZXp2b0xqNUZMMnJHSERCUWhxN2gzbFdt?=
 =?utf-8?B?N1dMeGttVWRsK2U0U1hydkN4WVU0ZFF6OUZZdUt6eEsvYjJsajFRTUlDeC9S?=
 =?utf-8?B?dmM0bWMwaGtQdHhkTzdHMkl4YmVuTlJRU0p6YWlnQUZKRGJhNVlpUm95N1g0?=
 =?utf-8?B?N1NmZXo0VU5KSTJ0T1VhWHJRRkNLaHhmSzdnQ3QvTGY1d3NNaTFoT1FDaU9Q?=
 =?utf-8?B?OE1WenV6R1VzcmNMZVY1aGVuYkhGRU44S3QxU2cvTi83cWlib2IrWnhZNmhE?=
 =?utf-8?B?anQ0YXhzUlkwTTZpNGx6OStYSlh3cVExQjdXYmZOUW05ZDNReFUyMURPaVFk?=
 =?utf-8?B?ZDExZEZ4WGs5cklDSEdpZjU5VUV6ZVpwUEozM3Q2TjRLa1JmM2lPd2h2bDJv?=
 =?utf-8?B?YkI3aFVqb3NtZGovRUFac2F0N1R0ak1ubVVzalNudlZjQzdLTzhMUHN4TUpT?=
 =?utf-8?B?cG54RHNNNm4vV1FNNVpWSzZWTVdRbkh6dWtIN1JNRytKb1dSZ0d2RDFGSENr?=
 =?utf-8?Q?QQH/OpcM1Bk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVoTkI2VFJadUw3a3Y0RkRSTU9NTU5RU0tlcCtLNW9MWWM5RVlhYmc1N281?=
 =?utf-8?B?dCtEd1M5Rmc0YXhRTlYrcDRBakFxeThvUENIUjVTVWJmK3ZyZEhSdC8yZHRv?=
 =?utf-8?B?WjZrQmlNMTNHelJOaUpDQk0rYk5pR2doeVZMTGJkZkdiTjZqbkZPOEUycURE?=
 =?utf-8?B?ZHR3LzRwTkhpbVFHNUUvcTJHUzd2SzI5TWhWb3gwR3o1eHNENkNDZ3RYWUR6?=
 =?utf-8?B?Y0sxNU41Nm0wRkZJZ2w2WUpUMU1GYVhld00yYnVBZ1Y4YUIrbG5aYUxadC9j?=
 =?utf-8?B?c3pMcHYweFhYN3o5SlpLdnE4bnhabHhqR2wya3JYb2lCNEdETkwxK004YS9Q?=
 =?utf-8?B?cVJOUWNDSUQyZ29nOHVtWjQwcHRiUHErWlBwSndqWUVIN2xRQmZUTDBvYlh0?=
 =?utf-8?B?SzhYRVVwaExCZm5abVlPeVNCeGRpZ0FtOHhaZWxBN01TUTl5N3UrZjA4S1pB?=
 =?utf-8?B?YmtuUVVsOWJ3Q0Q0eThaYkN2SERDNU1NWnJWN0MvUERRK3k4cFVRMHgzUGZk?=
 =?utf-8?B?dmt0TVNLWDBadExKQVgvZlpqSHQrVWdrYXRPU0R6a3pDdzBrL2hyUDhlSW1l?=
 =?utf-8?B?N2grU2tYaXRFK1lIc0hYRDRYUFpQRGdYM1hKQ2JidkY1ODQ3K203b2s2TGVB?=
 =?utf-8?B?eStpd2RUcFArVFJaSkNaTFBmSUQxdVZ1dVRkYk5FWW5TYXIwL2lsdTFBUExF?=
 =?utf-8?B?bXRPc0s1ZmI3SW1vR3U0S1IvYTNqTThyZUtjQ2IrT1NJWHEraG1rNWYrN2tx?=
 =?utf-8?B?VTc3Z2dQRTFOVkdwZll1SCtoencvcFNCZEhWM0htZ0sxVS80L3lHOXk2UXNG?=
 =?utf-8?B?UVlNbFhIRFJONld3ZElHS3A5NEhLMWVLUmMvWGpRK215NGlpMmtlVGVLWjRx?=
 =?utf-8?B?dnJkVjl3VTVOWWhjVWo5b2M2Sk4yY1BZdzJwbWNrajFJYkdNbnF4Ny91bCt2?=
 =?utf-8?B?ekduajZkTmZzMm81QUhCUkF3WXdYbXEvckd1aEJuRFA1MWxrSFlMaGNWUnVB?=
 =?utf-8?B?M0o3ckN6aVVoSXdpL3NtbmMrN0UrWW1idDlxT0F2QTVURFpFRER6WllWL0tY?=
 =?utf-8?B?YndGYWZPZHY3WFNMRDRjM2J5RDh4cEgvWllNNTFLdGxIMzhISG9kaHFrenRB?=
 =?utf-8?B?TFZXQWZxS3JST1FxcjloWllFRjFscUxXVzU1Q0pTbnFhWjFGT3BERy93eW10?=
 =?utf-8?B?STVBYlB2UUFncE5XM1RoSkNlanY4TGp3SGpSRUtuQ240K3JiUThicUpuV1o1?=
 =?utf-8?B?bnlRbWVNYlVjL1dqb1I2cFNUMkhVTXczbkNpV1o5YVhBWW5jUFRBeUtxbjJ5?=
 =?utf-8?B?N2huUXBYWkdPMkV3ZDV6QW9NWlJNbnV0bUNPNzBsVVFBSTZNUUI4MkgxQkRh?=
 =?utf-8?B?Y2k0NFB4cFA1VnFIUDlxb0FpMk1YZ0dkcmFIcmsxUEl5SDJBS3RjZEFEMG1x?=
 =?utf-8?B?clhBeEZwYVRmZzRCMjlPaitaUllsK0hwK2FteHhJRnkrSXcxN2JaMlRPeVpU?=
 =?utf-8?B?WWFlN1JCVWFkSUZrcVlxUkE5VVBsVUdVN1JySnNTM3RUWGRFTG5TVGJtTnZF?=
 =?utf-8?B?Rlg5aWNkMG41NWcxLzBxMHBlc2I1R2JuZDgraVVkYnRibW9YczAvWWxBMGE0?=
 =?utf-8?B?ei9uUmJDWjlld0JLNEtDR2ZSVVA4czd3eWNBZ2JIL2tpbDdqcVV0YzV0YVAv?=
 =?utf-8?B?eVAxSXhiTUZvZXhMOW9sd0lDUDdnRWZQaE1UbDNaYitOMG1pYW0wWTcwdDNi?=
 =?utf-8?B?cE5zQVhiMTJtQ0MydUk2aDBhNUVQcHpBTXMxZXhGY2h2YnpqbHk1YlhQV3hS?=
 =?utf-8?B?bGtQN2I3ZGliTUNVREJZYWxXd1llTWR3MHhacFRDMnJPc0llekk3Wm1Gbjhz?=
 =?utf-8?B?WVJSak8rc09HQWF3MTBTejBsVXE5NmxFeXBZTU5BRmNvS3FjcVZINkZObk9W?=
 =?utf-8?B?eXlILzhpdzJ1NDltNnk2SzVLK1lBbUVib01JbFR5UDJsMzUvRldjRThHWkxm?=
 =?utf-8?B?QW9xVlNQZVFJN0pUbGViLzZURCs3elpOeXVQSi8wOVQzYXlYNEgvWnl0SmNS?=
 =?utf-8?B?Ry9IOFl6K3dlYkFwU3FVRUt3WW9iYlVScVZtcjRGK0t2cHpZdkVNcFVmMFJy?=
 =?utf-8?B?MUozUkE4SDJXbjY3RzRkL2VKREdxZlAxZ2xsdUF1aFdxbzZ4Q1BtVjJJMVhS?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jh1/oQucOvyaqGs54tI+cVkTBd4sa4AH5UmfC5AQcaBOGdQdz0tdrUopdBpUSPD8sIx2zwZkApxz06F8AeJrTDblX1T1xd2y9hgOlHgl2U9qyKzxdmQ8x/+za5t3ACRZtN9ZtCjCNe+OcIKhr8ou/x7v2a5hfQ0Z6YjxIW6DZsmjsYO1GGJyCSJ4C9JZFjOKSLGaTJZH2dD/QI7+k9xhNOioYZMeuQUN5v51XLgSHgU8TPwtLGZaIZZRjHpSad8vml/ppz0A8Ip7zlUpEXKPvkAnR4Vnq9oUFOsdzjGDR1IRdWtZfA8woeaSkn1WVRSb15GOSkQWvNoBDOMQOejTIAEYVhstlF/EuIkcDa9XvLDKSsmuQH4OuQoehWxZhMWtguBlpU0n1Pfo7H8zv9RSccP8ijbu3f0Y4ZiscZSnX7Hj9wTSa2K2AvWD7TYNVXWEMjeVAWbqp3Zd4+6S0ads+cayMFGIkj2/4Rwt1nCG8eMT+fWBuaFQ3jhs7pAyVH6jzK4eQwKYM2OBPPjp8eIffxQhC/zEh70Yvpu4YAROU8B0AKxldZuLjRxmoimkh6+GSZAXMeQXlMgddK7BgzCYMGYxBHbUuMzhpCvPthAVYag=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 334543d7-7e4e-496b-6fe7-08ddb4b46c71
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 13:21:56.5049 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6VVNqLuBavmvK4QaqeYEw1muBFjYiqj8n1KXii4vvNhsyW/pKFD3S3VYegtejCp+iEoVze2cCSI0wx/fh53JVfpFxxXBKsLWiejj1WdNB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_05,2025-06-26_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506260112
X-Proofpoint-GUID: 94IzdJvengxIa1TistFY41muU7aXESVA
X-Proofpoint-ORIG-GUID: 94IzdJvengxIa1TistFY41muU7aXESVA
X-Authority-Analysis: v=2.4 cv=cpebk04i c=1 sm=1 tr=0 ts=685d4977 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=QyXUC8HyAAAA:8 a=MQk4XK5RaLLtIQjluU0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDExMyBTYWx0ZWRfX03SaK+TRjWJj
 7w2TnE5GwEI9rb63grdoOdqFsWJlc/F91uWBeY7VnbIFc5NTqdqepVDLeXuJhuJzBbBickO6hef
 ddbPYeyO+bysdO8mNJKBQHbRxsfVZD8Ns2CtEHVc64HnwJJJ1iRtXEySgQeczWOYbAHMOI2nFpX
 8FlUV1RTv9NzmSHz86abUxD9TO24W/IhygToCraYGpD+/wCpWYvh3iOqJdZiWD3XDMK4xhguH6I
 kOwvSKpEQSLEMxkIGdvB3+6lCA4+ueC1V5tHiPOFZ98gYelNxItSRpov56Jd3IZ9dKK800dXX43
 33U0CclrpM7J8KMnX45AWz1xQUpX/4FJeIGfUsgWClU8mlJoghuvCUFzgRqrKjeuJwhhRb4XsF6
 1spZUi7M0vEJvodFlAqCLxpHOI1skkys+yOLTw14L3fTXZ5ZSBkk+f8lrtlf2yefotn1gMqR
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/23/2025 6:22 AM, Zhenzhong Duan wrote:
> When there are multiple VFIO containers, vioc->dma_map is restored
> multiple times, this made only first container work and remaining
> containers using vioc->dma_map restored by first container.
> 
> Fix it by save and restore vioc->dma_map locally. saved_dma_map in
> VFIOContainerCPR becomes useless and is removed.
> 
> Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-cpr.h |  1 -
>   hw/vfio/cpr-legacy.c       | 20 +++++++-------------
>   2 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index aef542e93c..71a1c1a70c 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -25,7 +25,6 @@ typedef struct VFIOContainerCPR {
>       bool vaddr_unmapped;
>       NotifierWithReturn transfer_notifier;
>       MemoryListener remap_listener;
> -    DMA_MAP_FUNC saved_dma_map;
>   } VFIOContainerCPR;
>   
>   typedef struct VFIODeviceCPR {
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 100a8db74d..ff45a5128f 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -99,20 +99,21 @@ static int vfio_container_post_load(void *opaque, int version_id)
>   {
>       VFIOContainer *container = opaque;
>       VFIOContainerBase *bcontainer = &container->bcontainer;
> -    VFIOGroup *group;
> +    VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    DMA_MAP_FUNC saved_dma_map = vioc->dma_map;
>       Error *local_err = NULL;
>   
> +    /* During incoming CPR, divert calls to dma_map. */
> +    vioc->dma_map = vfio_legacy_cpr_dma_map;
> +
>       if (!vfio_listener_register(bcontainer, &local_err)) {
>           error_report_err(local_err);
>           return -1;
>       }
>   
> -    QLIST_FOREACH(group, &container->group_list, container_next) {
> -        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> +    /* Restore original dma_map function */
> +    vioc->dma_map = saved_dma_map;
>   
> -        /* Restore original dma_map function */
> -        vioc->dma_map = container->cpr.saved_dma_map;
> -    }
>       return 0;
>   }
>   
> @@ -180,13 +181,6 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
> -    /* During incoming CPR, divert calls to dma_map. */
> -    if (cpr_is_incoming()) {
> -        VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
> -        container->cpr.saved_dma_map = vioc->dma_map;
> -        vioc->dma_map = vfio_legacy_cpr_dma_map;
> -    }
> -
>       migration_add_notifier_mode(&container->cpr.transfer_notifier,
>                                   vfio_cpr_fail_notifier,
>                                   MIG_MODE_CPR_TRANSFER);

Good fix, thanks. All looks good.  I will wait to see the "local save" parts
of patch 3 squashed into patch 4 before sending RB.

One nit about DMA_MAP_FUNC -- the majority of typedefs for function signatures
use lower case.  See
   git grep typedef | fgrep '(*'

- Steve


