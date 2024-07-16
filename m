Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465D2C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 10:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTfcT-0005Dq-DA; Tue, 16 Jul 2024 06:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTfcM-0005Aj-TV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:41:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTfcI-0002Lb-1O
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 06:41:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G2tUPF032690;
 Tue, 16 Jul 2024 10:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=TA+tLeQDgmib2pqMPhgRONGGjrlf38/TurbtMz5s2fw=; b=
 oNMV3PY0pJCOIcBF6XonqKt4msfo4CNtjV9SJ3+ZSV3RT4ml7T8EQa11O2Xqa94j
 2nbX9nQLYjVz2OwhsB0t9fV74fAxtzBmpkbmUFt8fJ7Q/zjp7swATApadON0dB7X
 1PxHGeRvVSy24C3RZmyHco5t8Vuj5sUbfMf//1Cvvj12qwC86Dn2g4KYYTzbBAQP
 SV92kA8ZvE7DSD7mFKx2IXnOUezcy5VXsSJbclrlxSocaqnQtHmvH3OQSZuTPqDu
 5W6wpBdkkl0FxXSecyfXGJ9Yb3l0hxrS7lgv2czFIUwYnvHSkeixv6a477Cng4Ps
 JS6z/Kdd2WViF9syrzm4vQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bh6swgkb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 10:41:02 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46G8tQ3e040607; Tue, 16 Jul 2024 10:41:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40bg195wjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 10:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EufxZpZe9TqwOhYzu/jpuXYobFssn8saWzct/QhiNKwLNeYB3C1kkE3bVcVCqtHpRUqwu2AmCdYCy+shNEEkgJgGOhqWol9lWhPek60Bebj7XbyOO9fQ5oPCYTsms5z3XJCtYALeajq3+gYbeHPx9VW1TH44jUILktrcmLVblqsN3+QTZQIx5GwJ6r9k0HM3FnwCpAfjRUvin4wcSk1BI/Tkl4+SssS3YUqpd+g7RMerAXXelmTjD9+/4jiXFhKwFqk6C8Yp+3FnHPeK4sdMCWS0lZ87vSBinN1Kyd1z4hU3uGwhoSIjUspcsMB08Y6j6IOi8z4u+TmS+p56vIgFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA+tLeQDgmib2pqMPhgRONGGjrlf38/TurbtMz5s2fw=;
 b=CAa5zvAuvRzutDhixCNge0TpJXlRUpTe62hkSIaR5Qg6JjwVeLD17fxovvXvISyQSuFKYIRqPHZs2flsOUOLyDFlh7TfzoEeEgd49z16t0OED7Vv0lJHaITeqjhryC31fupRRMhQ7dCwfmfMJPshOhyxXdvHtckt90Ya5pTymngLN4xftqV62BEspoBHOnsY7QyttWu/lEs+PZwtdWg74ynXagLdjinvbk0Q+EelvTB1GkXa9I1Ff0/0GjpdGNBOI89CufMbFg24OrwxX6ZAVfc5RG6Xm8QWfjXXjhnGkRsnCYwM/EX72RF5l1MiQMnpYWjTHqdq6P2LxKQ2wWtMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA+tLeQDgmib2pqMPhgRONGGjrlf38/TurbtMz5s2fw=;
 b=S9vWFm1Ct2SZxeX8xFaGMpznZGeTbkqDiu+WUeFhrQEFOhiEa5TDnOeQPI5fMFxqAx+mmIGGHCbrT18bPc7S7ylLuio23zndf0f9DE3emmWwV4GbQfkTjDpIOZmtl5XrjrCqRWHf5J14gWkAB7KD8oxOflWvbSjcMFeHD0lOO9Y=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 10:41:00 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 10:40:59 +0000
Message-ID: <a7115777-85b5-49b7-aa1e-fde9a0b906ee@oracle.com>
Date: Tue, 16 Jul 2024 11:40:28 +0100
Subject: Re: [PATCH v4 07/12] vfio/{iommufd,container}: Initialize
 HostIOMMUDeviceCaps during attach_device()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-8-joao.m.martins@oracle.com>
 <877a409a-4256-4899-96bb-563961a51449@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <877a409a-4256-4899-96bb-563961a51449@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0006.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::18)
 To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH0PR10MB4679:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e126f63-46c9-4000-2d83-08dca583c814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHloQm5jM01lUlYwVzdQaElCK3FwRjM3WTFDKzdNSjZpRzJRd0ExMUMwcHBD?=
 =?utf-8?B?amVPTm9USmg0VkpqaUlrMC9adG9TTmFkUktJaWliYXdGaGV5SEtObjNDZmVM?=
 =?utf-8?B?NjFTZHVPeFFsMTd4TE1TTHROa1liL08yTTZoOTB0T2luWjcvTEd4TGhic2NU?=
 =?utf-8?B?ZjNBc0RDUGZ1cU9OSk9hUjA2RGZXcTkzRk15ZDJrWGo0NktDQmZpTzhPWnR5?=
 =?utf-8?B?QjJvSGtlbGRNL0pPMXdWMEJWUFNzRC9jQjRmdEhuS0lnS0NRdE1lc1F1Nlhy?=
 =?utf-8?B?NFBCdFlEWFdGQkpJaDJSNVRYeVRUY1Y5dkRzQkVsQVVYeTlON2tDbXUvNkZ0?=
 =?utf-8?B?T3UwOWF1Z1o0NGtDSmFlN0xsVVBMbWF1UktzVVFtVWdWYXNpcWhMc0tRY3Ez?=
 =?utf-8?B?RkVyUmUyVUFrMmR2c0s1WUF6MFNHTitjL0ZMWkJVM2g0TktSaVVXTDc3ejk5?=
 =?utf-8?B?d25NUXg0dEVhdWc4OUFSaWo1bXBIYmxlMW5zdkY1N1kraTkzclE3QytPZm1U?=
 =?utf-8?B?OWpmcTBKeUtSK2pMeXFKSEdFb0xRdDBqdHBPc1E5dHI5TXRBZjk0MXBPeUtY?=
 =?utf-8?B?VlRyTjBxejROalRCc0xWZDhBQURjcUVZc3hibDRwaVVPdGJRZlFNczhWZjRX?=
 =?utf-8?B?MHFROWR4WExnQ01CVzZmZWFjTzVMZEttaVBvZkcyS0RJeXVEZ0ZrN25nSW9o?=
 =?utf-8?B?OFp4L3p3R3RNVVRxUHBwdDRyQ0JHZTZ5dmZ4eXNjMWhwQTFhNzN3V0VkYit5?=
 =?utf-8?B?eEN4Q3hWWFAyZjZEdFlIQTVuYmRUcXhCdTdHcWNuRS9Pa3VBVHlIWnNubVhI?=
 =?utf-8?B?eXUrQ3BPR2wxckZqUGsxUWNOTGk4ckY3czIxbEpabkE2VzY1MzFiTXQ0ZmJ4?=
 =?utf-8?B?c05jeXg1bHFXa3Z3cUJCSmZSbmxLaGJscTNXTWRsM2NvMEZ4VmVsRUhyYzFI?=
 =?utf-8?B?NElMQ3F6ME5rMHlWWjZmTGxpWFBMc3pDYlNlQVFkVVBjOWtnaTlSMlBhNXFx?=
 =?utf-8?B?VHNEWit2b2RCOVZUS0p3aW4rTkFnVURFT0taYnFWcUNzSjRodllmNUFtM3NQ?=
 =?utf-8?B?SWk3VElUbnlPZk5XdWhkeC9STllSaHJxOVEwOG9nYW4wS3h3U3kzeWIrbU43?=
 =?utf-8?B?UWRaRGlkNTZaT0lVSC96VGh0S1dIZXNvTTRCaXNhbi9sSW1vdmpHV1dqSmdl?=
 =?utf-8?B?T3pTZTdySHVYWmJDUWd6R1BYeTZ0YmJtT3BKQmdOc2hTU3BOSFp3Sk53Sk1O?=
 =?utf-8?B?TFJ0cC9FSUF3ZWZrbDVUc29sYWJITnpzZ1VpQVVFcGtuQWdNVmFJT1c0cmZN?=
 =?utf-8?B?UHhyYkpqN0liOTZTemQ3K1N2Zjc5M2l0V3ZqbVhuSktwWHU0bXpHSGtGeXRq?=
 =?utf-8?B?RE5Ccm1pRVZ2NFFNU3FPTVFwcXRDMDJTcGpQQnhQTHdzcFJwT3F3MzRMOVl2?=
 =?utf-8?B?dUU0M2hzQnYrbjIweEpBb05IWTFnR0ViV3ZpMHVCQ0FhSWQxdi84aVc5dWRv?=
 =?utf-8?B?cDZkOWg4djlZaXdJcUJMQzY1R0pYTUpPVmlwK05jbUdNdUtOcUgzTlpLWHAw?=
 =?utf-8?B?N2JEdk9Ia3djaitGNTlnMXRTc0JKTkd6L1hjQk91ZWsvcEIreEFwZ1ZlVUNP?=
 =?utf-8?B?bTFrWitMUTErRjNvV3g1aHNUTFhQSVpHS2lHNG1JYWdCVGJRVlY5UDVMOTFW?=
 =?utf-8?B?bm1mLzEzT0pOakV5ejRIVUk0d3hYcDF2K2pVWkk0WGJhUWZnZ3JRR1VmeEJo?=
 =?utf-8?B?ckovak5ZRlZoSmVTemR6UmJDSlNFNFg3RzgwMTFmK1p2QXdYejBuTzdMTmpQ?=
 =?utf-8?B?NlVUTDJmd0N1WW8zcmdRZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzFDd2tMTjFhVEpCZk8yaDEzOGZrNGpsblN1L1lTQWNscG1nbWxqTm95ZmJq?=
 =?utf-8?B?bCtuOXZ5OVQrLzZtOXZ6d3dZOU50Vmc1YVBscjNlUFdNeU5KKzFacU9GMnlr?=
 =?utf-8?B?UU0xeU8weit1RVFiZVBLR1pTWGE0YkFEOW5IWXcvTDdjejZydkJuTTNTQkpv?=
 =?utf-8?B?ditKcStVb20zUkQ2YzFVVTB2aW53d1IrQldweHNHSm44YTRnVHdVQzczajc2?=
 =?utf-8?B?Q2lXa2lwSlFEaDhROWl2SUFSTmU5TXNwenFQMkV3TzZJVFA3TTUyUytVbWZW?=
 =?utf-8?B?NlZjT1RCTEtLVWtoeUQ1MWFBYUVwck1TcEUzSUhTOU9FNHR5bE5jai9sTm9V?=
 =?utf-8?B?dXpQVm5lR2ZWNmMzMkJjTk9Ia1BuT1dPd2ZWZEpMTVZpdjM1SnZSdTY4dXI4?=
 =?utf-8?B?dU1UN21JbFBzMkJkNlRONXoxekg2RE5hR0QxeHoyN09VelZrT0hHcWFLMzlx?=
 =?utf-8?B?VklWaFdYRWNpSHBDV3FKT0VLa0FzTnF5c3lYYkoyb01TREIxNTM0L3RuK2Rp?=
 =?utf-8?B?VEpXT0Q4eURrQXZ6NHlZTG81R096ZHJjYXp1dDFCZHJHSWd0TDdXSUhoNURG?=
 =?utf-8?B?Q3NobnhOTWc0a2hBUFIwZUhSU2ZENTk1ai90QnJpYmYzNDBVVi9aaG15bnZi?=
 =?utf-8?B?TExSQ3ltR2dEdWFHVDVEdTlHbjBWZEUzemRNUjZ3VHdVR2JMejJiQ3F1Tkhq?=
 =?utf-8?B?UC8reTZKMmI3WVMvdmo4ZTdiejN6OUVvU1BnQzI1eUVxc2hXemdqZ25LbUpo?=
 =?utf-8?B?YUR5MWVFaEZITEc1TWhMSzZhOU10MU5Pb1RNTWw1b3BtclJ2azEwYzhxN1NM?=
 =?utf-8?B?MlZKdkF5WlFBWkxqZ2daNjByYS9mKzR3UldTN2w4T2YxNU1qTmoyQitXZm9l?=
 =?utf-8?B?L2VEejhTc0Z0V3NpTWRMK0JORW1FR0pycG4zd0FoL0dHVVpxY1M5NzN2Y1Ew?=
 =?utf-8?B?cHZiR1ZRMWUvTTEzZi9tNlJ4aEFmU0hON2VzbHlsY1pDeU50eHN2QWVIUkxv?=
 =?utf-8?B?VERuc1ozdHFDRCtxbU54aWVYYmhVY1pSYTBPZHl3NGd5eTludnBsbG13MEti?=
 =?utf-8?B?TDdwMW9FUFUxRTJ5Zmt0ZDBmUmRoRWJSVHk4Y1ZWcnNjNDNtSXJERlJGQ3Vp?=
 =?utf-8?B?NklZbDJuYklKVHlzZ2NoQXBialNiZU1XWHRnTDdIUHFTanJCbXpvais2Nk04?=
 =?utf-8?B?U2tnUHRteldDM1RqcitHTU42YUgxTURJd3Z3TGN6OCtDNVRkSTh4Rll6dXcz?=
 =?utf-8?B?Y25MZmd1VW9nUGJzc1hSKzFjTjZnd0hMRnpMMlZkeWgzSU5GMmVqdWE0TjIy?=
 =?utf-8?B?WXVOTnBZSS9BdXBzZVVOZkdwR1JxVVpzdzI1OXE1SGZKVjdxUmZBRTVTaTd5?=
 =?utf-8?B?UDdMc1dRSHNXdFQxODQwOUoyZUFTWXJVTUdRU1VNUUJvR0RLMlVsMURXZW5I?=
 =?utf-8?B?RFVnaGd5ZlpoR2RzTE1uMXU2U2JYQkdZNktxWWFrVDA2UjFHUkt6RmZzY016?=
 =?utf-8?B?SldPdzB4NmdRL3hRM1BIQkRUeTR1MjllVHBVZTNpVDRTVThLSkUvL3ZLR2pk?=
 =?utf-8?B?bnd4OFM4S0dHbjdlRDVYQ3FFcnRiSHVFY1R3a0hwdHZVMVBTd204dDBZclI1?=
 =?utf-8?B?OGk5b3BQV2FMQXphQk9FakV5WXBKcDNNSVE3dzRQQUhKWnIydGs1ZW1HYUt3?=
 =?utf-8?B?MjhYMTk1NlRtbmVvMTFBa0JUaVVQWWpTOXBjM1VzNXdZTkpZWWt3UjA1YU4r?=
 =?utf-8?B?MGZmMm41Vjk2V1FjVGd1czMvRityVjlWbDgrdmVoV1RsUEl2SGJBUWxWU0E4?=
 =?utf-8?B?M1dMa1ZtWUl3S2k5akJlcXVMM3NHbHRiRWdBMWhucWVrcG9UU0UrUi9LaW8x?=
 =?utf-8?B?d1dvcjZiQURMNG9xTGQ1QUI2ZHNKQjEyWXgxZkxGWnJlZEVodmpWTGFtR3Er?=
 =?utf-8?B?NkFjVm9VMEovTEhLYVVQcTdTazgvcEhZYlRadmtuOThPTU9XdVlqUkhHbjNR?=
 =?utf-8?B?MXF5NXF4WnlJQlNuY2xSdkFWMkluSm1zcFJRUWlkKzcxUXBDTzJiZncxZVBO?=
 =?utf-8?B?OWgyT1R0R1VFNmNmeDIrMDdjZ1l5RmNRek5tSDNaaGRVRFZOK2RVS1dVOUtX?=
 =?utf-8?B?TFZXOVdINjVWcDFpUUVqSDJvSVlZb2p5TFVadk9RUUJSdlgrZi9QT1RocFVS?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /XSVsznrr3Nsygz6vONTKsijWQHe79GRZgyVS33TP5GJ0+JyIAXCVEwS0Ll92lMbsfiy53ZFe7eupjgliFUX8jNT0/ZGlAGq7cucU2x/fz0rj31gbWSioAokUfW38RBAeir8ib0hojJx7dwobj41AmNWvLzsraTDNmijyqj3uVxW3CkYP9WDAVSir6ep1/cfqSlHVqBw6arWzvkGpG2ef9Vk02NjDIVj7AU14R0c/La7Fu1jzOxb27PPY1sTpyQvFrW+yJCOiE4VnL4CBBZ5XPmYpjCb+BkTCFsSu5gHhjPq8pFZ+1+T8d4VAcvmokE3tsDMUTok0F7HZQZrjUKetX6fqHpLKQEespPuHM1Q1vfi9jTmbb8ytKhopqCQP5UjS8xX+7jrb3j7SGWSbJjVKUBVmGNuQIEahLtptgsMxoHkdKyEEdAFexpydFP00wR2WyJ5JBoB8yl2ZTkMgSMciuB2e5g/hzUiwJOTRrgowhyffKgQ5vtLB+VhbIC6CElHn/NHp5Trz8EcVi/FEbvc+QXk8XMPgvSpRN4DrGQISQCxk2lp2V3vVKvwIAw2767U5asvJOqp0inPswz9NLtbJuctWRpD5EFjdT0wTBr9R9w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e126f63-46c9-4000-2d83-08dca583c814
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 10:40:59.8776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEEXik4VDi6W5m9faZLV/Sq/KH74aff4ypO+xwNUX542Sgs4Wmj6dSNPN+ajp+IzTsbBWqtkYLxexlQ7fsriQgOB8c07OrLeJ23Otf4EhWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407160077
X-Proofpoint-GUID: 19ZA3l3rurEnU2hKVX2DXQcIl-cdJQ_e
X-Proofpoint-ORIG-GUID: 19ZA3l3rurEnU2hKVX2DXQcIl-cdJQ_e
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 16/07/2024 11:20, Cédric Le Goater wrote:
> On 7/12/24 13:46, Joao Martins wrote:
>> Fetch IOMMU hw raw caps behind the device and thus move the
>> HostIOMMUDevice::realize() to be done during the attach of the device. It
>> allows it to cache the information obtained from IOMMU_GET_HW_INFO from
>> iommufd early on. However, while legacy HostIOMMUDevice caps
>> always return true and doesn't have dependency on other things, the IOMMUFD
>> backend requires the iommufd FD to be connected and having a devid to be
>> able to query capabilities. Hence when exactly is HostIOMMUDevice
>> initialized inside backend ::attach_device() implementation is backend
>> specific.
>>
>> This is in preparation to fetch parse hw capabilities and understand if
>> dirty tracking is supported by device backing IOMMU without necessarily
>> duplicating the amount of calls we do to IOMMU_GET_HW_INFO.
>>
>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/sysemu/host_iommu_device.h |  1 +
>>   hw/vfio/common.c                   | 16 ++++++----------
>>   hw/vfio/container.c                |  6 ++++++
>>   hw/vfio/iommufd.c                  |  7 +++++++
>>   4 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/sysemu/host_iommu_device.h
>> b/include/sysemu/host_iommu_device.h
>> index 20e77cf54568..b1e5f4b8ac3e 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -24,6 +24,7 @@
>>    */
>>   typedef struct HostIOMMUDeviceCaps {
>>       uint32_t type;
>> +    uint64_t hw_caps;
>>   } HostIOMMUDeviceCaps;
>>     #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index b0beed44116e..cc14f0e3fe24 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1544,7 +1544,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>   {
>>       const VFIOIOMMUClass *ops =
>>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
>> -    HostIOMMUDevice *hiod;
>> +    HostIOMMUDevice *hiod = NULL;
>>         if (vbasedev->iommufd) {
>>           ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>> @@ -1552,21 +1552,17 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>         assert(ops);
>>   -    if (!ops->attach_device(name, vbasedev, as, errp)) {
>> -        return false;
>> -    }
>>   -    if (vbasedev->mdev) {
>> -        return true;
>> +    if (!vbasedev->mdev) {
>> +        hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> +        vbasedev->hiod = hiod;
>>       }
>>   -    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>> -    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +    if (!ops->attach_device(name, vbasedev, as, errp)) {
>>           object_unref(hiod);
>> -        ops->detach_device(vbasedev);
>> +        vbasedev->hiod = NULL;
>>           return false;
>>       }
>> -    vbasedev->hiod = hiod;
>>         return true;
>>   }
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index c27f448ba26e..29da261bbf3e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -907,6 +907,7 @@ static bool vfio_legacy_attach_device(const char *name,
>> VFIODevice *vbasedev,
>>                                         AddressSpace *as, Error **errp)
>>   {
>>       int groupid = vfio_device_groupid(vbasedev, errp);
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>       VFIODevice *vbasedev_iter;
>>       VFIOGroup *group;
>>       VFIOContainerBase *bcontainer;
>> @@ -917,6 +918,11 @@ static bool vfio_legacy_attach_device(const char *name,
>> VFIODevice *vbasedev,
>>         trace_vfio_attach_device(vbasedev->name, groupid);
>>   +    if (hiod &&
>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +        return false;
>> +    }
>> +
> 
> 
> Could you please introduce an helper :
> 
>   bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp);
> 

Yeah, let me do that

> 
> Thanks,
> 
> C.
> 
> 
> 
>>       group = vfio_get_group(groupid, as, errp);
>>       if (!group) {
>>           return false;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 873c919e319c..d34dc88231ec 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -384,6 +384,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>       Error *err = NULL;
>>       const VFIOIOMMUClass *iommufd_vioc =
>>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>> +    HostIOMMUDevice *hiod = vbasedev->hiod;
>>         if (vbasedev->fd < 0) {
>>           devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>> @@ -401,6 +402,11 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>         space = vfio_get_address_space(as);
>>   +    if (hiod &&
>> +        !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>> +        return false;
>> +    }
>> +
>>       /* try to attach to an existing container in this space */
>>       QLIST_FOREACH(bcontainer, &space->containers, next) {
>>           container = container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> @@ -722,6 +728,7 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice
>> *hiod, void *opaque,
>>         hiod->name = g_strdup(vdev->name);
>>       caps->type = type;
>> +    caps->hw_caps = hw_caps;
>>         return true;
>>   }
> 


