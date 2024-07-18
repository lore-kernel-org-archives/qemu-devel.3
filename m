Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B87C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUN53-0008Li-Ff; Thu, 18 Jul 2024 05:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUN4y-00083V-NP
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:05:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sUN4v-0005YX-Is
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:05:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I90jE2031316;
 Thu, 18 Jul 2024 09:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=gq5bq2pMvh4xgwTl+zr5ymdRmwgLi334hsjFN/wTZ1c=; b=
 RXvZ6bLxTWbdvkizNLwgqAXPFtYfR22TVfn0OnGnB9XFisTq9LjHAZyA4znKqUaH
 274vxbahn59coHDDY0QF6kdJdssdXnkovWdqbMu99Pz/eT2vgxNm8+UH2iTfxVwz
 WfxYcRvHsubvfe5PQyt/AUPtQEOj8dfxkP0evk7kaxBGHXOJSlR8DgDb9tbWFLsh
 AxgbD5jUe7EYZ66p0oCcSrjFgvwgMDo6UJX6J8V3iTxv7aZh8+Rz1tl4q6jP4tFk
 2r/y5ebBSEvz0DP7gYAqWdMhbrYsOfysVGmLVvhJDcUjDx5SKZll1wflIWUGK1hZ
 OfJjWgJwcBKjdzpaEesnJg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40f01n0097-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 09:05:30 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46I7IQ5W007059; Thu, 18 Jul 2024 09:05:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dweyn4bf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Jul 2024 09:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Brq4RiKuQdzOTVwzB6xQR7IHjPb7ArWso6lG7u9dxWifCq8J96UoSurlPbOOJUH+ERgIAMkVA8Df0Ojzv2+0p/T/PdLkVE+JBptc9yJ2xP20pxsx5/KLv3zHQ/NYFaXiIONfpgt/SmqflAnFxChI6XplCd5ViZGhBh1ipZGjXZLZ6T40WRtx+Yl/eKvIvNBjs9axl/JGuBNOzJtJ+xcpy00D7hHWb44poFe0jFR3yZPfhIr0Lq0eq5EyBePD9KycA0OuFzJxvcZYYhIlNc1BnlIm+8NmnAWjg1FqfiptOTnxm26FqtdYQy49yBSCmRzoNCyjWxU3xbuFmALIAcZIOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq5bq2pMvh4xgwTl+zr5ymdRmwgLi334hsjFN/wTZ1c=;
 b=ApPNwUpaSQEXWurUBXStleraekspIVfyNtMJ0PwWNINcJ+osy1rjj6ujd+HHpIWg17LAHdsbPAhVXpg6Hc7PbFkA3JhgzVLV3EgYAthA6CQNtfMIykFgDIF8IYDEAhIKbS4fvC9Vlf0JWOSbKQwsQOpa/wTfVmzRwDzlCktYTFnu0Z+JKdGav7lHh0GSKMvXzmza2cd8idUJl/P46X2hQi/uhktpDNwCEZhnGgUsfQs5UzF6eWrPUzcNE9NNlQux5CkEknA2jvrWNQ0yOqXQExwfbE9pEgECnV1Si29bBpi/TYs7Di3JbINcDYnTO+HlYHY4xNb8SXOIrb1AdFA9Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq5bq2pMvh4xgwTl+zr5ymdRmwgLi334hsjFN/wTZ1c=;
 b=jY8V8Obl2B8BqZ1TAWNLRmavpbh37U5TYq8lT655W/ttqyisPrOR8Kgyt4aZGry5ZQ37b00fncEOuQU1O7a62IhasdloGKrUrEXgU0cfs2/+AnXlWlGzSPcCYaceZsuL8oqrc5JEk4I8g66yN3tTMV06OUFdlylxFidKKTLezd0=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BLAPR10MB4916.namprd10.prod.outlook.com (2603:10b6:208:326::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 09:05:26 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Thu, 18 Jul 2024
 09:05:26 +0000
Message-ID: <f63eb101-ba27-4691-82de-837a5ff2568b@oracle.com>
Date: Thu, 18 Jul 2024 10:05:20 +0100
Subject: Re: [PATCH v4 11/12] vfio/migration: Don't block migration device
 dirty tracking is unsupported
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-12-joao.m.martins@oracle.com>
 <SJ0PR11MB674456F8871EAC781732D0CD92A32@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <da65c43a-ddca-4d47-bfbf-274e8062c56b@oracle.com>
 <SJ0PR11MB67444526632E358E81C4F17792AC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB67444526632E358E81C4F17792AC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0108.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::23) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BLAPR10MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d052c76-de6d-4cb4-ea09-08dca708c3ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OHpuN2RkR3JHVUNFK1p1L3d5MUJJZjdCRzNGczArTlRzb2xYZWxBbG4xd0Mz?=
 =?utf-8?B?RFRXczNnL2RpRnNEMkt1c25KSk1EVzkwWkM2bkp0QUVrckR0L3NKblN4OGEr?=
 =?utf-8?B?aU9USUt0dHk5QysyUHE3VXZiNEpSRGVsVjF0dUxPclZRL2g0QUpnQW0zYVRI?=
 =?utf-8?B?cUIrMkh2T0I1enRyM3U0MTJZQWNMVlJFRjM1RU5VSjlnbCtnaVRzeDdYTjJT?=
 =?utf-8?B?V0RBa2h3bHNoSStmaTZsTU5vcWhXSnBkVFJtU3RQWnB0OTllOXQ0YVFmV1Bs?=
 =?utf-8?B?VHBQbVlhSTRBMTJIUTR0eDRQVWV6ZmgxcmZFT2h5VDJpTzRuVFVZTmtBK1J4?=
 =?utf-8?B?WWpFK2RBTGFCMDdhbnltKzVKSFJtcXBlZjBlRXBRaXV0U1ZncUZDRmwrNHlo?=
 =?utf-8?B?MllQZVJHc1AwcHpRL1h2bWdXNEtmMEpoTk4xYTJmK2FnOE5Ra0tTaDRLYldE?=
 =?utf-8?B?WGdYRXRpMFZoako2NmJQRmlYRERiUnp2Vy9lK00wYnNJMm9zQzJsL1NSWTB3?=
 =?utf-8?B?QUNrR2RJdE50TituaEdCdHViZE9HTWkzWXdMVTFPaTlhMis1eW9nNkhnTVI5?=
 =?utf-8?B?RGVjelVHa2JSL1duM2s5N2d0dGZEUHRxbXk4eTNGdUFKNFo5aStNcTdPdGYx?=
 =?utf-8?B?amNORG1FV2oxZG9jSWJHWDljUW9jbE9jNXZIT09zRFZIT0lHdE9GMU5tNDho?=
 =?utf-8?B?Q1VJa2hYRzlQSzE0emdoSWFJUzJMWW5pMTcrMzdWMUZLenFmZDh5c1hHMU8w?=
 =?utf-8?B?RXdDdXFRL2dQYjB3Vk9pUnB5UFZUWit2L0I0a0R1WTJ4emRJZWw3RUpLWVNK?=
 =?utf-8?B?b0hQTnJJdzlQSkQ4YVF0dTcvZldtZ3hmTGROZHV3eGEyR1ppOHFDWFpHVGEr?=
 =?utf-8?B?NEpiOStTemZYdzhENUFBM3dsTS9NMWgxbXpnUERPRDdBcVR1VVJTYW9VUjJw?=
 =?utf-8?B?NFdFc3hISWJLenkzU3ZpSVFSY1gvTmNEd3ROZU9abXJvNGswZWVlZDZmTUhV?=
 =?utf-8?B?YXlnN1hNYnhwRU9CM0EvbXJNMXlBT0RjYVRUOElXYm5XSElTYWpoNWhkWXZO?=
 =?utf-8?B?NnZwZmNqb1puL2Z3YWdyR1QxTExsZU5vSzRNd1kzbmpSaXE5NUI3ZEE5b1hI?=
 =?utf-8?B?Q3dhTEJDUVZWaHBIS1hHL2RQb0tSZmpMaWxpSS9hRXFCRmFvRXNKd3hQd2U5?=
 =?utf-8?B?NVI1VWU3YkR4eFcrNml1RVdYZTk3YWp2K1ZDMlJPdkZGZFJPVktzd0trc2Er?=
 =?utf-8?B?UEpuUjhUMFV2UkRkdWpRSW8yanZkYmowZkw3RWswMVVOdmVuMndGMVJZaXBS?=
 =?utf-8?B?bkxmMzdveDdWWUJPamZuM0lZekxGTk1PVis1cy9lYzFIVTlLa1hRQi9uMDI4?=
 =?utf-8?B?US9DSm9PdWtVMzdHMGs1TGxWQ3Vjc2hlMjlUanFFS1NpWWtNaHRpSjNGUkd3?=
 =?utf-8?B?UEtrMjdGSUMzU01HL21FVkxVdHBkM2Vuci9nVFV2aGF1L1o2L0tRTjJhMkx6?=
 =?utf-8?B?VWNqMWQxTEhWd1l5QWhLbTBOWWh3TWdHRUVWZHl3Njl5OXhNVVc4SVdKNzZ2?=
 =?utf-8?B?QnhCZENyaS9qcVIrMHNOUkpNYjc2Z2hHd0FNMnA4QWhZMmx2ZEVlbytzWGdw?=
 =?utf-8?B?MUNrb1V1aTk0MFpQVWkyTmJZSExyckhCV3NuNjA5MlZTQm9FR1hCTDJwdmxh?=
 =?utf-8?B?eDF2TVNpSWpnUlV5MjJMSm9pcVhZTmlYMlQxZFRKYUJTZU93Y0JDa1pEWnN5?=
 =?utf-8?B?TXBEUTdhWmpVNm1SRHd5L2FLM2t5VTlVSjlSRlRiVEd1TmFJd3drSDNaVVNl?=
 =?utf-8?B?OTRpV3dmNU1yZkNJcERwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alp2YVVBV1FRWEE1SjVLd2lNUU9qZzBoS0g2V3V3dHhtV0xRRzZtVjkzMjJM?=
 =?utf-8?B?TExJRzhyTklqV0RPZFZNUVJDQ0NsdVhKeVZDbjk3WCt1RUY3ajQ3THVOMVNh?=
 =?utf-8?B?NzNoZWo2aGlmeGpNNjROTUc3b3VMTGlrazdzWFdPRVRUdkJtZTRpLzZtRVJ2?=
 =?utf-8?B?S1A3SExXbHFYZVhneXlZSzJnaysyMmV4czdKMXFoNFovR1ZYZ0JUOTljc00x?=
 =?utf-8?B?ci9nMUVJcFhmbnVjbDNBald1WjlFRFhrS1ROT3N1TnRRV2k2alN6K2gvWncx?=
 =?utf-8?B?TXVQRDRsVWFpRllFMjRFU1UrQ21BUjFvZVlERmEyQU5rV3AwNENwVG1ocHhs?=
 =?utf-8?B?VHR2VVAxc2xqYUxZUjc5Y1hUNHB4SHVtd3RYMGlGZVJ2N1Vwa2JQQ3YxWTN5?=
 =?utf-8?B?N2llaFBrWFZia1F5YSt3TE10b2pzaHp1eTFkcHZIdERGc1ZXOGdzbWQycldu?=
 =?utf-8?B?Z3Q2b3dCbGsrK0hld1YvWUNnRkRyRHpQMnBrTCtHanVyRitjOG8xQ0c3TXZv?=
 =?utf-8?B?N1V3OGR4QnNqMDIyRDhRZTRRbkQvcEc5NkU0bjZnSTN0S0NRRjY4ZjNDc0ZV?=
 =?utf-8?B?YVdiQ0pNS1dMVVpBSVVjUnZjUzVRdUpSTmRVc2FsMUhCN3hDY1RTTzhDZTFr?=
 =?utf-8?B?ZitFZEkzQ01Pb01NWXdYdUE4cmpRdzJhUVo3cVR1Q29jVFZiUGlEVVRxMjNO?=
 =?utf-8?B?enc4eHRuWjg4TUdwKytYaFpGajQxWS8xTVV3bVBYYXJXbHg3SFJhRjNZWXV1?=
 =?utf-8?B?SWE1RG9hck0wb1ZzMUhEWUJBb0lnQ1FReE94dVB6UHBVVnNzd3BZTENiaFJC?=
 =?utf-8?B?VkhEVzF1NU9qdVlVRHJsdXRvZlpFaU1nS1NFV2FDZWIrM2NIZzNEdTRIb1ND?=
 =?utf-8?B?SGU4dC83akdoUGwvRlVWS0EySlVsR3ljQk0xYjMzbDlxZk5rSGE3ZVhtU3Zs?=
 =?utf-8?B?OW5QYmcwRENWTGNqYkttSEFPcDEzOHhNQU51dG9SRmFOREhqemF3YkpsUkU0?=
 =?utf-8?B?bnNXMzhsQU9PcVNFVHhMTVYydU54UVcwUitLNlMrZlp4aGRXL2s4Umx3OW05?=
 =?utf-8?B?RHU2bE9La3JkNm9aSU1yVHBQYlZUT1dreEZwVFdKbksvN2dZQ2VLaHM2Mkty?=
 =?utf-8?B?Q2lROW9yc2dwajRvaVBUTlNndmFnT3p3SklpaFNoWkgxYUtmTmtUN1R2WWNO?=
 =?utf-8?B?a0FvWDdhTklFM0VSbzVxVUM2ZUdILzVnMUtmMEt5am02Qk01anNiRSs2ZTZa?=
 =?utf-8?B?S2VMVkJoOTNMT1JCRHFpVDNocnRvRUNOZzNKeEp4Z1FRZGl4elN4WFg0anZz?=
 =?utf-8?B?Y1haZXowUGt0M0xob05XTnM0eGkvK1V5M0R6SjdqN2Z5T0ppZE5MdHZ6NW5M?=
 =?utf-8?B?Q0pPeHdNQ21yWGdBMjlVVnFOMHJzWEpSUmJyZldIV3VtZVR6cmNDNy9mNytm?=
 =?utf-8?B?N3ZzdGVYNU1rUk9yVmhGZ0crZE9Ickkxdkg2WVQwTWw1WmN6UVQrUlZScU9I?=
 =?utf-8?B?TnFibmFicExOemEvazRhRTMxOEttaVEvQSt3MlRXcDdIblc1aWQ1UjdiUzhE?=
 =?utf-8?B?WGI1M1RhMUN0TzQ1anpZT2ZkUkdCQlc1eitzaWRndjJOM2FjZUM2MFdBTnVz?=
 =?utf-8?B?cjlYOFM4c0psZU9HUXd0aXZBMDRDRDE1bmN4N3NweEdMb2pvaEhRejZmcmlp?=
 =?utf-8?B?NU05ejIrSVh5VzUycFNnQmhGczdZQk43SGJKVlBUcWxocXFsQ3lwWjJvZFkw?=
 =?utf-8?B?S09ISWR5TkR5ZkJVVTRzaEg4bDZhQjhiUWhRZGNxNml1dVpBWlMzT1llK09W?=
 =?utf-8?B?TUVId2kwRyt1WW9VTG1wcGJpKzhIWGk4NDFPWEpkQmJIRVVjczg4NXV5b09h?=
 =?utf-8?B?R2ZqaUZnMmFiV29yaVdhSEQwUitCWkRyS3hGMS9sb1NnQndnL2FWd0Y1TEo0?=
 =?utf-8?B?Rm5xTjZURWtNTVM5ekQ5UUtnZ1lzaURndFUwVWlhNlBsdUdpcVAvQTFqZUJs?=
 =?utf-8?B?aHpWOVduUUxrY1BkZHhrWGtCVzF1K1R5dW9Dckp0WFdpSWEvT1VQWkpOU1U1?=
 =?utf-8?B?K1A4bmhGQU1qUTRmbFFXMjdKWDlmZFZZaWF6djhpQXhoM3Y0cXlmRmkvbDJ1?=
 =?utf-8?B?cFdzeWc0UTBZUDNRNXVnWTVRTmZub2JmbGtXK2VIMGFadzFJOTBvNzhFa1E1?=
 =?utf-8?B?WXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rwjZHLcNSKxjFtzUt7Rc8p4ytW6pXeXyIy6Jd7HQP3VKZITRJnFL9nSPYRljGRKrE1FT+Jw4+n8HBn+1gwUKZW4tdSFeOlGWYW9bT3cu+9+vS6zenQonMtXVY7Om+d8TFvzCIl08un98KU2maDQCJ8Y9ce+oVqSizHEBZShC+GinqW5KxwyscB1TQO4FYmWIjS+OqeSHmkEUVZSygCP75Ny2QxqSJ3BzNpNhsw0pYXDev+MPTZTb2IlnVXBj2CGJvCrhATcSztCswgzSLcO+a2jBHX+KhX+1mcKCjd8we3V6bs4ai9Zgj19rvMKiR0bfDaOhzm2YyAbe9MrkctXT2zUU9SuDPojEA6u4EMOT2E42w1VWunM9wnNehBRV+XfPT3cnkU/bEDMWECYg7yJ9chrR6hInkT+VSVIB9rxzwkygLSR1SIXrNYeEUQOePFky/hLFs28sU6tML3ZScPgYh9J30Iz7m1l8kl1Amq6tXIvRbcyc4X98TYvjvB22YPKoe3KrwH7vfycSeDBb8b6bJY4aQT2IYE7xtMNRO0EQjEL2lfNrzfO+FsSBVx21PxUc+Si/Kv6hohFnim/mgxx5tDFBdY2wgdqN1XArVyYYEeQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d052c76-de6d-4cb4-ea09-08dca708c3ac
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 09:05:26.6512 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6C1J59Bl4EkM21O7zVxzakuBS3KMh3KtGGvL5C4+v9KTUYgxeHg+M7WZnZvvtVF69OH/CVpyV9llCvwwylKQykHMXOICbUB/QpyOxMV85uw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_05,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407180058
X-Proofpoint-GUID: 4AVJbhYluvNk2okmi8tsSBJcgBGKM91h
X-Proofpoint-ORIG-GUID: 4AVJbhYluvNk2okmi8tsSBJcgBGKM91h
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/07/2024 08:20, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v4 11/12] vfio/migration: Don't block migration device
>> dirty tracking is unsupported
>>
>> On 17/07/2024 03:38, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: [PATCH v4 11/12] vfio/migration: Don't block migration device
>> dirty
>>>> tracking is unsupported
>>>>
>>>> By default VFIO migration is set to auto, which will support live
>>>> migration if the migration capability is set *and* also dirty page
>>>> tracking is supported.
>>>>
>>>> For testing purposes one can force enable without dirty page tracking
>>>> via enable-migration=on, but that option is generally left for testing
>>>> purposes.
>>>>
>>>> So starting with IOMMU dirty tracking it can use to acomodate the lack of
>>>> VF dirty page tracking allowing us to minimize the VF requirements for
>>>> migration and thus enabling migration by default for those too.
>>>>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>> hw/vfio/migration.c | 3 ++-
>>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>>> index 34d4be2ce1b1..ce3d1b6e9a25 100644
>>>> --- a/hw/vfio/migration.c
>>>> +++ b/hw/vfio/migration.c
>>>> @@ -1036,7 +1036,8 @@ bool vfio_migration_realize(VFIODevice
>>>> *vbasedev, Error **errp)
>>>>         return !vfio_block_migration(vbasedev, err, errp);
>>>>     }
>>>>
>>>> -    if (!vbasedev->dirty_pages_supported) {
>>>> +    if (!vbasedev->dirty_pages_supported &&
>>>> +        !vbasedev->bcontainer->dirty_pages_supported) {
>>>>         if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO) {
>>>>             error_setg(&err,
>>>>                        "%s: VFIO device doesn't support device dirty tracking",
>>>
>>> I'm not sure if this message needs to be updated, " VFIO device doesn't
>> support device and IOMMU dirty tracking"
>>>
>>> Same for the below:
>>>
>>> warn_report("%s: VFIO device doesn't support device dirty tracking"
>>
>>
>> Ah yes, good catch. Additionally I think I should check device hwpt rather
>> than
>> container::dirty_pages_supported i.e.
>>
>> if (!vbasedev->dirty_pages_supported &&
>>    (vbasedev->hwpt && !iommufd_hwpt_dirty_tracking(vbasedev->hwpt)))
>>
>> This makes sure that migration is blocked with more accuracy
> 
> Yes, this is better. Looks bcontainer->dirty_pages_supported is not as accurate as in legacy VFIO days.
> 

Heh, That's just because legacy is always marking true (and marking anything as
dirty) regardless of what the hardware does :)

