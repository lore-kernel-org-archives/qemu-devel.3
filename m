Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE26DE77184
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDOw-0006PT-NX; Mon, 16 Dec 2024 10:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDOu-0006Oy-NT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:52:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDOs-0004WN-1o
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:52:52 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEtt7D017457;
 Mon, 16 Dec 2024 15:52:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=lp2kceqiteCSN9qVYf2iDB/nalGzrf+rntorHCw4Rzk=; b=
 Su3Qg4oCiBCxNa9+O1YBgvFtstWyzhr1YNgxM7+C/IqrOGqT9lk407GZipMb4SeD
 fbH/fDQ9Ie+EdACKxICWEwudW8dfDhRvnkqkYxJgLOMiQGXJLRDFLxrJCFmswrUI
 mHPh5/F/5w2q805OTNb0JVK5/Jl6Kjy7mI5jpgF/EkpPy+EL3I7mc4or370zInx+
 7EXM8SM0WxKQm6PHPYLLk9jVuB+fMJQMlJk9yI2cLoO+83T0HH7ge54e18fDS0y3
 v8cjgTU8Q0ABB/IlHJVXd9Ljab6kMLYbK+Erm3FqhU/Lw27rWFY+redQOmchvL0Z
 jaY0DUQkbmkDKuz2cfUo9w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xauj8g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 15:52:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGFWUOY035464; Mon, 16 Dec 2024 15:52:45 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f77s19-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 15:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHPNN2j9FpJqBIypywsUVYIoid/pPY+/hWNlZcmRZ8L/mvPeCOey6BpvovldseEpQGAEpwMK6yi5LoMIlYgylSiEOac9n/1kWpfD1T1G52ACVljSeWIjXE6PutmWm+mSOMIAoiPPEDTivzt4bISkthAlcRwqLqDWtmfgybOE7mMIWny6YD5o1tV/Cabma1qWtFJ337WrcjYszO8u5n+lGkKk7cfvuzfUrmh2FEgeYkvLf4fnCRB9w4PkWywbf554/jN2aX4L6i9/ZzAs1asm+W5jJl7rDlJed3iwojfiI5MiW3MyLoG/pf6ZfRCFF7dybl4aSNBKq2ePvV0Ft64sXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp2kceqiteCSN9qVYf2iDB/nalGzrf+rntorHCw4Rzk=;
 b=snGqsBYUpeUqfE9nQju2cSmAryyLdhTzNNz+cZure2UG/AU5m64Bcg5Ti4ahFtrGQMsmLsJMUwz3nJtYUxkKtc5ORZtc5vg8udYZeDrrBgp3F0+XNxe0M0RMTeIqq8eeC88MQfgMacoZxILPCRSozz6qnOL5zfY73lv4U9QBnSVQhYlfN8gfth7Pl5e5HftzpKqtp2AfydLLuVekwWc/04B+AMN8X2BQ+BNYHkA5NDz06cn5ZylBnP7NLGIV476LgiRsWeG7FdTN1XklTP6EmaKtfwxZGAtTPo+CA0ChaVZrwQ+kNCfRb+TBgg8dX2kxct/Rn8j1JwGuJXGSZsfIlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp2kceqiteCSN9qVYf2iDB/nalGzrf+rntorHCw4Rzk=;
 b=IfDdY1EMx88LlPAnXSaiO8FHLLLQpMWWNo90kvk9OUn/Ka0UCAcPgT+no/jpZD+M9tMO3XM5jjbAtcUoxWavpI4DLKfUdKJUDEKXm2V1ku6q07t54uxVqe5Fgi+DG/oJ5MajEyCG8J2YKDdyBgl99cVAtZT/UVsYIRWbQIiImNw=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 15:52:43 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 15:52:43 +0000
Message-ID: <9d594215-307e-4014-8df6-6e019999a7fe@oracle.com>
Date: Mon, 16 Dec 2024 15:52:36 +0000
Subject: Re: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-3-avihaih@nvidia.com>
 <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
 <50e6d3f8-0642-4a6c-b6fe-21a68ebe9d39@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <50e6d3f8-0642-4a6c-b6fe-21a68ebe9d39@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0279.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::14) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6ad324-87a4-46d1-6cf6-08dd1de9ad96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R05YTi9VU1BrVHRtc1JYdlVPVXoydTc2aERxc0t1bGoyRml3VHNrSkpYL21N?=
 =?utf-8?B?bDBiSTZrV0dicjlBMFlQOWNLVjRFNE9nQVZPczVuaUFTUzh4a3hYUmcvOHI5?=
 =?utf-8?B?ZktyQ3NPVC9qRyt3YVpCVmJjaTYyNkNoaEczaHAxOGJqdW5ONW5kSVU3UnZH?=
 =?utf-8?B?TnVFSTdjUDM1aHFOY081R05GZ0hjMGdTWXhwMXBZanJzOUxxb1hsTmgwaXp5?=
 =?utf-8?B?U0tSYisvWnJFMkduUU1ZbUUvR3l2bmhid2hEc2x3cWF1OVBYaVJaTGxyTW1k?=
 =?utf-8?B?clFTbFZLQzRzeFFkckc0VVFOWmd5cHlML0JvWGRRek8wZENPZmRhTXJGdk1I?=
 =?utf-8?B?aG5ka3VsU21DckJncDR5b3lucXZES3hnVVY3enBDRnpLWUNpdjNMeTJiN1dB?=
 =?utf-8?B?bkg0TVVjbEhIY01PT3hiSjJhRHg2N0kwVGJPUEFnNEhWTUZ5UlZJMXRxeFhC?=
 =?utf-8?B?dzdxOVkvZGt2dEtTSmEraUFHbDlyQXFiN0ZqWS9rNGNXeFJqdnNCWEVINk1y?=
 =?utf-8?B?Vk1LM255U0dFaWV6WHRJTklJYUZzY3NmZ2tlNlViZk1QVlprMzZaYzJZODNk?=
 =?utf-8?B?cHludkdQZkVrdndncDlWdUVvbVd0SjNablowaWdka1NUbUJvSGd0TGFMZnVk?=
 =?utf-8?B?cFFXTFErWlFhUXdwZXliaWxsdkNaaTJLM0o3WXNIY3JFeEhxRitiQ0NNRDFH?=
 =?utf-8?B?Z0hjSk14S3d3S3Mwbk1zK3FkbWNhb2plU1lDay9EY084QW5jUGhSTnp2RVhu?=
 =?utf-8?B?VXpOcUNnWlVoZnpsSG5memJUaER6YUhuUy80T3hFWjgxUCtFbFA0M25xbHN2?=
 =?utf-8?B?MXdnM2lNcldSUzFCcGo4Nnh0eXBKOXcvbk5CNlVrLzgzL3RvK1NZTWRNUjVV?=
 =?utf-8?B?YWpjU2pkczVKZUg3OFpwa0JFT2VNc1IrbjlGSkh1dXdkMGMxWGRsUDlrNWY4?=
 =?utf-8?B?RllYQXk5UW9IYituOEo0aUpOWDVoOGcvZVh2WDNQVFB3b1F5V1ZZTnU2RU5q?=
 =?utf-8?B?RUFTK1R2aEN3YW9Sa0xIdkZlMUxVYWRBZldQUlFER1hWQk54d1J5THR0eUZi?=
 =?utf-8?B?cEN0cVdaVytpWEEwSDd6VEtsZWVWRm9XZjRTVE9BaU5CQjZYaDB1WlN0YjhB?=
 =?utf-8?B?Vmk2Rnl2WmNqaUFwRGpOdXBjOHVvUmNPTmpzZmYxeUFmU0REd0RYR0ErMFlO?=
 =?utf-8?B?eElMYlp0RXhEWGJlYmhwc21jcGFYeWtPbWhLcWYrQ1RuZmo3ait4dTZxOUFG?=
 =?utf-8?B?RzV2dmVpcUE1V3Z0YU9Hay9WVTZuemZ6NXYyeEpHQVlEaXRRRDd0dDBSd24y?=
 =?utf-8?B?dVphNlR5NFgyWm8wRGx5UllDajNwbitERHpnc3B2M2lIS1VBOUZsK0g4YXZr?=
 =?utf-8?B?cHpTVklubUNZdlE2elVHVjRObXJ1WTluQUxRb3h2U0dteS9OUVV1NDhrdm1a?=
 =?utf-8?B?MWk3bEd5OVFFVXNnZ2MrSm5ZZGJKL21tV0ZlYnlQQ3BXT0dwRzl6MDFISkhu?=
 =?utf-8?B?OUxrclplUHFUbWc4cFVtMXZUSDNuSnVKaWZpWFhYMXN4eEsyMGZsU0tVSlRS?=
 =?utf-8?B?S1gyY3NRbjZRODU1anVBYkxNU0lFWG55RTdhV1JCSVgxMTUvMlRtdzJKQ3BQ?=
 =?utf-8?B?RVJNMnJ6cHZFOTZ2YXo1TStRblFPWkkvd3NXbW5jOVk5NnpMdWliNkZsODBq?=
 =?utf-8?B?VXNtandlYTA1WkRRbFlqamZWUG44eDhweHZPeGxyRHQ2cUVES3J6b3lmeUpT?=
 =?utf-8?B?VnI1bmZ1eDJKSWhqdXBFdWpNNmdVNGRVT3FuS0tpRkpZQlRJTTlRTlJiRmxz?=
 =?utf-8?B?c3F1WFJIZHNET2xxYkpIc0kzd2ZvYzRmdDBmdFpVU004OEtiL05rZFpJeTFY?=
 =?utf-8?Q?izbXnXT+1pkbM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xMSXNycFVVTlpOb2QzRUNpWUFpMTliZ2tTYlg4QnBFN0V2bExYckZ4WUtB?=
 =?utf-8?B?SnRsdTdIdnVEQXpvQnBWSmttTXJEMVhUV0kyQlZQK1BUdjM5Tk1vaTlTclFC?=
 =?utf-8?B?SXEzSVl5SVlKTFFUdjM5bUVlSVB2MHZlTVcvenZXRWRHWnVTdFhHT24rcDVD?=
 =?utf-8?B?NVJzd1AvMFBRem5IVndHOENoSzZWTVhoNGMxeXliWkZVZndrSURGSG1STFFH?=
 =?utf-8?B?b01ZQy9vR1dnWG03eGlIaFVLRnFWQXh2bEVtcWZvbXJwYWZtS1MxQ3plTXNm?=
 =?utf-8?B?bWpUdHRjZ204UEJzTWxVSHJqWHc5VkdVU0Jma0kwbElVTWtpbGVJWVB3VGxE?=
 =?utf-8?B?MnBZeU1mN3VVaFR0bGVNWGhqVDdRVE84OVZFSVR2WW0rZE56eFUvVS9UY0dj?=
 =?utf-8?B?V0llVVNmNERERFBac3F2R01TOEJBanVFQ2VjMFJITWQrY0RLczlIZmIxbDd0?=
 =?utf-8?B?SzhuQ0kzcmtQNzJzUi9wYklJdlFVcDNsd3RJZmFSSWpTWkJaNEdrRHRVWkdX?=
 =?utf-8?B?VzlQQi9YZ3E2dVpPcktEOGdkSEczbkZXcmxjY1BSS1l3QlFjM2ljdWZZZ3hh?=
 =?utf-8?B?SlR0U2FxVHUvaDY1STFra2IyaXRnQWJnS3M0S3F5eFh5cmx5bmpZU3QwZVZl?=
 =?utf-8?B?Yy9BNnVnVmt3Mi9iVGF5MjRQSE02Vmd6a05lcTlHcDJtWDdQSjQ0dzlJSDQ4?=
 =?utf-8?B?bGFSTHpHYTMzL0hIODc0b3VkQS9oQ0p3dHZLUU4rT0R0M0dqVGpyMHNlWDB6?=
 =?utf-8?B?N0gwR05iQlRmVEVNWGJNamc1Szc1clZZMjlHYlJJSTRqZGRQVXlHTitES3dX?=
 =?utf-8?B?blJNbVhiMHZDMlh0eHJ1clF2VGNRb3BCRHkvUVQxRHk5VHo4VlZvWWs4S1g5?=
 =?utf-8?B?L3ppVDUxNWRoSVdkN0pia3V6TEV0RE12TmlJcXcwbjdUaXJVWVFXby9OTGJG?=
 =?utf-8?B?UFZYNU94bHlEMk9RYWQwMzlzZ1V6MWNIbWkzWm9kcklFaHlRd1VrL2dodWlB?=
 =?utf-8?B?MnFTYUdxbmxnTlVQZTRDT241NHFQVmc5RkxxNnFHUlVnVUdlQlFPOVoyZGJZ?=
 =?utf-8?B?a2Y3QkJWVkpUUWppRFpYODcvUm14c2dBaElGcjNMK1NDeG5NWWFaQmVuTVcz?=
 =?utf-8?B?eHFvRzh2VEVSdmpjZkQ2L1pmYk9aaStRSWtLbUlSQnVrVkdSQTcyd0gwRUQr?=
 =?utf-8?B?UzJXVlB4c3BjTFJEYzBmZFNObUdhS3VyTTJPNFkvYjZ6bXFEM2hjMElCV05S?=
 =?utf-8?B?azd3ODNkS1RnZ21hRU9reHl2VVRvbSs1M2VaU3NzM2FhVkkyd29KWVhQd0lN?=
 =?utf-8?B?VGwxaDY3ZEV4VTdpK1MrMlpFdGNWejJVV09ZY0s1aVd4SGUyWHdWUnBjT09K?=
 =?utf-8?B?dlpRUW5iTTZ6cmdLT25SeGlBc0E4N2ZuUHR6N3JqMmJycGNZKzdsVkFlSjgr?=
 =?utf-8?B?V2VUODFlYnR1Q3VUQUpqb2JBSElOTXFwWU5CcU9aYVVETzlESnQ2R2hiOHEr?=
 =?utf-8?B?Ri9tVTBXa0hzRDdWZ3BFSVJiQ3RtMnkwWFNuOXFFeDZMdk5wSlVVWTYreGtK?=
 =?utf-8?B?aGJiVkxSZDUrelFwMGZ5RTBvZ0crc2tQWHhtTlNVTHQxRmtqZjNXSzdoK0dl?=
 =?utf-8?B?NmUxMW1aMHhsNklkN3JzM0JmNm1RZm9Zb2xlaVNrODd5MmxYeERkRTFNVU0z?=
 =?utf-8?B?aTNGS0xjc3VxNTJFUlZmOUNCcTRyeklKdzkvTk1EN0g1eHFUZzQxUVFZbE53?=
 =?utf-8?B?VE16TDZDdEJGK0RoRzlGeW1DZGEyS0R1NEptSnJ3em9qME1QTTZvcVphYUZ2?=
 =?utf-8?B?UjFNY3hmTEhLRkc0T0tiVCtmRWc1a3dUTGkyZXRrQmVkL2pxQmZadXJwcXhm?=
 =?utf-8?B?TEptVFdicURpNS9OeURwNzJNOHozVjhSOUxGcTZMaVdNTWoyUEpFdlREK25q?=
 =?utf-8?B?ZFNtVThTdkhIZ2djaFg1SHFrbVYzeTRpMnV1aXFCaTZFZ2liUEF1c3Z3bzBs?=
 =?utf-8?B?QTZucHR1RXVJTThLWllIN29BN3lLbldadUltRmVicDRkWDlLZ0VtcmZtWjYx?=
 =?utf-8?B?TGxJRkR1MXI3WXJueWZzcXd5Mk9RR1o1Z09ndC9XY3Z4QWVNamhhNlIzaHo0?=
 =?utf-8?B?ckMzeVFLSTJVbXhaWVR5d05vTWlOL3lhMHIyeHVlYXVrNGZzMElvSmh4ZXd4?=
 =?utf-8?B?RWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wKXJ8TBajmZt+bDX4AFFL1vfnwvrWqHb70HuyR5c+Yk4LjhVSEEzIHiKvVO9jm0h7rRwaf0E7z4zpf1wzq9Nqzu0ky1WWFNBVgp1XL9owrsqEYOQoGzVi0pC/zy9MKLeHCsEiADLKTCqzjSG9J9wET/PT1EdpRpHBex7QteqGb5qWuB1/YYp4Ltu6pqW/EFMFoezmoEGdCitAN/dV37u8CSUMDpwLaJEAfzZhiJnTliovygnRMilwA5LUJ6/zc7TSglCm73fYPtUDH2GIhe+F1aUAgqTJYVqRyyI7hZ4FbLgK3Ls4RfDm0aMJvvodPmaEgBMxrAt04sGqtnBd04KajAbSwmDW9Z4Y7YpjC06rmrNYEvH1PVV10kF5OwhxaAgCVHFA6jhga6fEbgjFqicKkU7VaSDwuX9uJoTr/O1DsDtpWtg6YhTRVluqDv1TYKqVIZadWXZHKfxyZH3UFLz/7AVr/5G6sKGMDvcDj/+67k2NmzFuTT0ujhEYj+VbphyZM7fY2WDiereCz0Gw5Shr5kuuOMzeu/5IdLZdn/BelIn2LjPb7ST/WPGnyA3L4dvLd3R3I+uRokloN1q0RDitMjd734EcVHcCkaMz/0P3Fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6ad324-87a4-46d1-6cf6-08dd1de9ad96
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 15:52:43.5924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +42PJIGy3X37Z6DcJ8Fzpo7xW5fXD/0oRBDCQrmx6MZ0ZQ6emAsJnRBaJkF5sdoNmN2El4+9fpC1L1f9vhEQjuJeUV+aw27nFjxIDiOhSMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_07,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160132
X-Proofpoint-GUID: RocWCxbHtWy_LWbxANAQ0_8wIoeAvEKI
X-Proofpoint-ORIG-GUID: RocWCxbHtWy_LWbxANAQ0_8wIoeAvEKI
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.13,
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

On 16/12/2024 14:52, Avihai Horon wrote:
> 
> On 16/12/2024 14:32, Joao Martins wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 16/12/2024 09:46, Avihai Horon wrote:
>>> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
>>> check if dirty tracking has been started in order to avoid errors. The
>>> current logic checks if migration is in ACTIVE or DEVICE states to
>>> ensure dirty tracking has been started.
>>>
>>> However, recently there has been an effort to simplify the migration
>>> status API and reduce it to a single migration_is_running() function.
>>>
>>> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
>>> it won't use migration_is_active() and migration_is_device(). Instead,
>>> use internal VFIO dirty tracking flags.
>>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> The refactor itself is fine except a pre-existing bug:
>>
>>          Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>
>>> ---
>>>   hw/vfio/common.c | 21 ++++++++++++++++++++-
>>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>> index dcef44fe55..a99796403e 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>>              migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>>   }
>>>
>>> +static bool vfio_devices_all_device_dirty_tracking_started(
>>> +    const VFIOContainerBase *bcontainer)
>>> +{
>>> +    VFIODevice *vbasedev;
>>> +
>>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>> +        if (!vbasedev->dirty_tracking) {
>>> +            return false;
>>> +        }
>>> +    }
>>> +
>>> +    return true;
>>> +}
>>> +
>>>   static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>>   {
>>>       VFIODevice *vbasedev;
>>>
>>> -    if (!migration_is_active() && !migration_is_device()) {
>>> +    if (!migration_is_running()) {
>>> +        return false;
>>> +    }
>>> +
>> Tieing to migration status means that non-KVM dirty trackers cannot be toggled
>> unless somebody starts migration. When really your original intention behind
>> commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
>> was to avoid the setup state when you are indeed during a migration.
> 
> It was tied to migration even prior to this commit, as VFIO log syncs were
> restricted to run only during migration (we had "if (!
> migration_is_setup_or_active())" check).
> This commit only narrowed it down further to not run during SETUP.
> 

Ok, good point.

Btw you are regressing from that behaviour with this change above, because if
migration has state MIGRATION_STATUS_SETUP and migration_is_running() will
return true and so you will log dirty pages.

>>
>> Now you can actually start/sync/stop dirty trackers without migration when you
>> use calc-dirty-rate which is immensely useful to draw out how active a VM prior
>> to starting migration.
>>
>> The fix is simple and would be to flex the condition to be something like:
>>
>>          /* Migration status is 'none' with calc-dirty-rate */
>>          if (!migration_is_none() && !migration_is_running()) {
>>              return false;
>>          }
>>
>> This is ortoghonal to your series of course, but given you are skimming around
>> this area, sounded like a good idea to raise this. This patch below is what I
>> had plan to send when the development window started, but this was before folks
>> wanted to unexport migration status helpers.
> 
> I remember you had several patches that formally added VFIO DPT to calc-dirty-
> rate (with a new "-d" QMP parameter and everything).
> Are you still planning to send these?
> 

calc-dirty-rate *implicitly* just logs KVM pages, but in theory it should be
ortoghonal to any dirty tracker that is able to log pages. So in that line of
thought it should be logging pages from all dirty trackers in use.

To actually include all dirty tracking data and while fix the performance issue
to not account for setup migration state then the check is a simple condition
for SETUP state *if* where's a migration started *or* no migration started at all.

I don't think the VF dirty trackers steer the data based on migration -- VFIO
seems to be the only one IIUC. Hence fixing calc-dirty-rate seemed more accurate
in my point of view, and optionally we could restrict scope of dirty tracking as
a bonus

>> What would be the alternative idea
>> forward?
> 
> Now we have an internal VFIO flag to indicate dirty tracking status, so that's
> one thing we can rely on.
> And we can also use the global dirty tracking flags in include/exec/memory.h:
> 
>     /* Possible bits for global_dirty_log_{start|stop} */
> 
>     /* Dirty tracking enabled because migration is running */
>     #define GLOBAL_DIRTY_MIGRATION  (1U << 0)
> 
>     /* Dirty tracking enabled because measuring dirty rate */
>     #define GLOBAL_DIRTY_DIRTY_RATE (1U << 1)
> 
>     /* Dirty tracking enabled because dirty limit */
>     #define GLOBAL_DIRTY_LIMIT      (1U << 2)
> 
>     #define GLOBAL_DIRTY_MASK  (0x7)
> 
>     extern unsigned int global_dirty_tracking;
> 
> So I guess we can add some helpers to access global_dirty_tracking and use them
> in VFIO to decide when to allow log sync.
> 
> But as you wrote, I think that's orthogonal to this series.
> 
Right I also had sketched it like this to reduce the scope of dirty tracking.

This problem preceeds your setup fix so don't wanna go offtopic. Anyway just
wanted to understanding how migration status is going to be exported to see
what's the way forward for that.

> Thanks.
> 
>>
>> -------------------->8---------------------
>>
>>  From ace22f29a0547353e4ed5a0db53292a77f79fa81 Mon Sep 17 00:00:00 2001
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Date: Wed, 9 Oct 2024 00:27:46 +0100
>> Subject: [PATCH] vfio/migration: Allow dirty tracking reports with
>>   MIGRATION_STATUS_NONE
>>
>> Invoking calc-dirty-rate HMP/QMP method queries the VM dirty rate
>> without starting a live migration, which is useful e.g. to understand how
>> active guests are and even for testing purposes. calc-dirty-rate asks
>> the dirty rate from the VM and it's not restricted to a particular dirty
>> tracker.
>>
>> However commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP
>> state")
>> didn't consider this and currently restricts that VF/IOMMU dirty info when
>> migration
>> is active to allow it to be skipped during SETUP stage.
>>
>> The vfio dirty tracker is already started, the reports are just skipped
>> based on migration status. So change vfio_devices_all_dirty_tracking() such
>> that we include MIGRATION_STATUS_NONE to cover calc-dirty-rate case.
>>
>> Fixes: ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/common.c         | 4 +++-
>>   include/migration/misc.h | 1 +
>>   migration/migration.c    | 7 +++++++
>>   3 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index dcef44fe55be..0c188a2baac2 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -174,7 +174,9 @@ static bool
>> vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>   {
>>       VFIODevice *vbasedev;
>>
>> -    if (!migration_is_active() && !migration_is_device()) {
>> +    /* Migration status is 'none' with calc-dirty-rate */
>> +    if (!migration_is_none() &&
>> +        !migration_is_active() && !migration_is_device()) {
>>           return false;
>>       }
>>
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index 804eb23c0607..857768b51383 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -53,6 +53,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>>   void migration_object_init(void);
>>   void migration_shutdown(void);
>>
>> +bool migration_is_none(void);
>>   bool migration_is_active(void);
>>   bool migration_is_device(void);
>>   bool migration_is_running(void);
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 8c5bd0a75c85..49d11e1adf04 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1637,6 +1637,13 @@ bool migration_in_bg_snapshot(void)
>>       return migrate_background_snapshot() && migration_is_running();
>>   }
>>
>> +bool migration_is_none(void)
>> +{
>> +    MigrationState *s = current_migration;
>> +
>> +    return s->state == MIGRATION_STATUS_NONE;
>> +}
>> +
>>   bool migration_is_active(void)
>>   {
>>       MigrationState *s = current_migration;
>> -- 
>> 2.39.3


