Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C26C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 18:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHoLK-0007O9-58; Wed, 21 May 2025 14:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHoLG-0007NW-Ph
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:39:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHoLE-0008Nl-Q8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 14:39:02 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIapur022153;
 Wed, 21 May 2025 18:38:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Glb+a/3HKzTZVNmSvDQjjDA/K3atmR5HL07yTAc1C98=; b=
 Dj8bW+EBDAVSwLyoDmku/f3AESZ49ZlASBWsVf94E/3gjiFWlcbtUn6mA2VLSBb1
 3Gz6/hYImxj0AyxGJm69VVXay73SDixW88hm+XoRH8lJBsnzjrjVVK6xjcoCk9wl
 1FE3XQrdZAXVKlAb9GXepmx+73FGvE7gZ8YXfdlTA2VnVYaq0R5cSlDI8xGuVfaq
 GSuINCVYVJD/gtRiGYzY2cTxBnWWrD/UCXGmwNNAIHBlT5fQzCO5xw2KeK11k1zN
 sXrZHK08xcl1WbneEa1ZuYwLIKzrB8R619D+iG3n7uym1sAKeglaop5zW2uLRBrk
 V4o4RDVgECJZAyyYiwLSaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sm8w806w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 18:38:57 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LH1mvF020216; Wed, 21 May 2025 18:38:57 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013020.outbound.protection.outlook.com
 [40.107.201.20])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rweu7xgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 18:38:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9BJP+s5H0+roQuTmv/pONO2Fs9kMoNiFJHR5eQhRHnZIRFNqYYgz7pBK3IN8NH5qBO3wuvsdVaHDcUMtBQf/TBOuPdi33cc+FPOoQUjWqx7pqQEU9mscsJK26JGn1dmo7Ypd9g5MkpmyzLGKMmq93O8751JTiYJAgFlbg6rCxTaCwmZWSkYalfx3hQjBZODaNIS18Rba0e5htPaTh9qMgWOMdrJgiQVNoepZQ9TuIquEcksHFJaMxGbxuVPRmhP2RgZswt05hRb4IKwpW1R/BnWRGMP4fKzElaQk8h4FVrQOtcco/AHG7CLk/MEOR2JmJs3DCy1/C+MAi2fWwqoiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Glb+a/3HKzTZVNmSvDQjjDA/K3atmR5HL07yTAc1C98=;
 b=wiaceX6A3WJmfQMGDsE19n9vIMRJrkMORtBkfWeMeXvPK62L48cY+aobrDf7j9CzWASce7GqkZlryl+CvPr4uv04CB3ghON0jFsK0D0ERAeWQpYghSiBJs1WiX36xDOJQ9E6I6BchDImtOKbxtsAmpmMM+EkX5PolgNnwZU65H1+Z7pNTX6dsYz0It4t7eWsoK70gxt0ub9RFAtPMb0yk3lQAm/GLNPHwRyaPUzyF3YEqob72wsIBySjOMUixUoDtHsKO5HGbyHOqYuYLuCU79L6wXjKDeBOqfaflvIghbcxAcdAQsLbyHL1EnIP9pTCHBTgevrKQhgZo4jbRh7oMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Glb+a/3HKzTZVNmSvDQjjDA/K3atmR5HL07yTAc1C98=;
 b=dlPDwRyN6zS+fdoNp/x+XVWD9QJj9PH7K1l/3Wpv5dISG8Iuqn6haHvxHVlsZP2WBZXon32FOYvMt0p/EIs9rJj23+oNaDv1KYnAS60jdmXvR9UFF799RaOuZgKmsw4O/AyZGbGbntmpYiwEVo2/GDSH+rhXX5MXZ2lu1/HeAgk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA3PR10MB8020.namprd10.prod.outlook.com (2603:10b6:208:50d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 21 May
 2025 18:38:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 18:38:49 +0000
Message-ID: <8dfdba5b-312b-4ee5-9090-36c74756e8a2@oracle.com>
Date: Wed, 21 May 2025 14:38:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 37/42] vfio/iommufd: reconstruct device
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-38-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-38-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::12) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA3PR10MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cbe16b1-9dea-49d3-86b4-08dd9896ba35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0p5blFNVzRWZy9nMzRYbHJITld1aC93a1FxUzJuSDBtS3hEd2VQMDBZRnRv?=
 =?utf-8?B?b3pWZkpTSWM2NmRXaUN6aXZVUVgyQmUzaGIzZ1d2eG5kQi85SnBWODNBMjJE?=
 =?utf-8?B?aGpGclU1N3krTUNFYkNxQVh1cjdFdnp0d0lRN0hVd2hkaHlpRzhiTnFobHdX?=
 =?utf-8?B?bnBTbUtrVXRWQzZrRHRmR2hiZFQwN2kyNFIyTW9MblpzY0Eza0VTOHJFdzNH?=
 =?utf-8?B?STdCWEZNRmtBSTBVMDJ4ZDdBd1hoeVkyNkpRVXU1QTRadFgwZENiME9lM1dG?=
 =?utf-8?B?Y3NWaXNKZWxCYkFBbjhWN2htb0RWY080VisrUHZCdWhyWW9ndnJJd2l0NHR6?=
 =?utf-8?B?L1d2alJDemhHaWl3VVdsWUtoUUlINGRVZjlFbkdSVHh3azlTZXZyZmxsbi9l?=
 =?utf-8?B?SCtFb3VwVzJ6ZWRmMnlyV0JDdHc2NWwzUXdnU0RzVllYd2dqeWtkMWlYcU5z?=
 =?utf-8?B?QkxCTDE2d21Wa0hhNmV1QTcwV3hvSG9ycXRlbjY0VklJa3RhMERlbjlIRlBo?=
 =?utf-8?B?TDg1YjhBOXFRRWdnQ3dURTRUdDZVWGU2UlBoTnBSZnFrM1lkcVVIK2hHRzZM?=
 =?utf-8?B?V1V3aWJKZUcwa05QMm1hOUljMGFhdDZsQk5JZEJLaWRrMWlkakhSYjZ0TThn?=
 =?utf-8?B?Uy8yQ3FsRFFGUkIzQlVDOGFSUVpQdE9PM0lCMXdvN2RzVlFyWDh6Zm42NHQx?=
 =?utf-8?B?b2RRa0czaXY2UXlaZ3FWQTA1dFZYZHlmSFNSQ3g1MjRZUUlPMHRQU3pLNS9a?=
 =?utf-8?B?THpERWIxOHlZUE5LQ2NTNE9oZ2IwNTUrWTBtV01ib2IzTVBMOWtPRFowVmxB?=
 =?utf-8?B?N0FLaldUbkZ5SnZRWkE2WnZ4NWo2VC9VeEhyeWUyL1ZSOWFEWHNWT1I4TWY2?=
 =?utf-8?B?dThSQ2k5TXVVSXFEc0tmM0tlR1FtRUtZYkFnd0h2cFh5ZE1CcVJydkhwRzhn?=
 =?utf-8?B?SHY1Mm54emMxR2NKREVtQlNoSVhCU1VCZ0R2bFpkRU5QMnlPdmV1MWVMcFBF?=
 =?utf-8?B?WWtjNGZpOHVBY3JjNUNOMUNoUzNMNmY2bm5NOUg0QUdVZ2NkRFZMV1RJcFRo?=
 =?utf-8?B?ekRwOXh1cVN0WC8vbGVDSkpKeGNtS2loNHhkelYyeHVWZjY1V3loK1FTUG5K?=
 =?utf-8?B?RURPSDRhUTNNTEpUcU93VDlSU3VWaWl3WXZHZFRSd29ZLzBTSm9iSXI3UWxn?=
 =?utf-8?B?QVM5MlUvZ1JwVnFmRjJHbGZGSWdRY1ZwaktIaXNqMFp2cThmZkcyOUVPc3BS?=
 =?utf-8?B?czUrb3VEM0Q0eEs4RVI1bVg2Ynp4YjJPd0dGeVQ5MEwyVkRFZzdCcDNwVTJr?=
 =?utf-8?B?bFFob2t1ZXFRRDZxb1Frb2JSN1diSytHMndpeFFUcXR2UHQ0L2s1M1NkeFN1?=
 =?utf-8?B?eDI3ZW0yZkFHWHFtUUpKWS9uWStzWWJrbzc4eGE5N0xZSUl1T01ZNFJ2N0VD?=
 =?utf-8?B?KzBZbjlGbmJhUzU2RVZhQTViYzZMUGFlU09veDRYSEpxaUthb3lkcDFJcFow?=
 =?utf-8?B?ZVBwQW1hVGU4Y1k2V3N4ZlhRQUNaTVhlVXExa2FwK1pwYUhaOTJ2MFBnTmJH?=
 =?utf-8?B?MkxqZTBUbS9hK3dUT2RyTU1iaFFoSmFKQmJlV1ptK3crZUZaNHNoU3lHRVlr?=
 =?utf-8?B?UWtHT1NqTlpRUEVDVnFDV2tQdklTRzlsRFJVcDF0cW9ib0hoWDhLVy9FcVZj?=
 =?utf-8?B?cGlOMTVINUFOQy9NbjFaT05BSmU3eEc3aTBlVmxia1BnYS83NDdIOExnSk1l?=
 =?utf-8?B?M080UXBiSFhpc2VBaytTekI1cU1mUldLcWRQbUpJMzF0SmxRSVd6ZDFDeHhx?=
 =?utf-8?B?b0FRa1JHSTdEazdZZDlaZGFGdjgxdWFvTXR3N3g1YWVxR2xWNXd4amN3NGZs?=
 =?utf-8?B?WW5sUU9wNEhCMFdlZk50QzVWdkVXQnFtY2MzR20zMERBMmZXZTNldzd4aHZL?=
 =?utf-8?Q?e3eo4udQZAg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJTV0o0ckxYZGcrL25QcFN1RmJDT2xNczhVUWs5bUJzTEFwVlE0YkdEMUFU?=
 =?utf-8?B?R21VRVBENUdaTDh1RmFtaTNBWWpTWFFRcVNoS2lMME9YMVE1K1k2UzlpQjhK?=
 =?utf-8?B?MGlHM1RQcXJOUnlUNGpqQTE1ZEVNUmdqelpUVGdUekltNzVTVTBCeGFCc0ps?=
 =?utf-8?B?VUE4bzBMTFJKUjB0dDJlK29BaEV0ejI2WSs4YXBSYy9BbEFWQ29EbTJsWnZJ?=
 =?utf-8?B?RGZNUzlseElKazdmV004bnQyUjNYZ0o0aEtleC82WGFiejVOY3BRbHFXOVlM?=
 =?utf-8?B?QWNvN0hhSk9TY29GYkxhTGxvaHQxSk82Snp4ZmdEL0F4eHZSUWlXZUtWeEtw?=
 =?utf-8?B?RUh6WUFFbkFZWnRMSmpsazlsQzBiWmdNWGh2VHZPSFkzcXIybEN2MFBya2li?=
 =?utf-8?B?YkYyUVRhQnl0OXVGUC9rTFhCQmpDM0c0azlZZlEyU3loSnJKSDdlc0luSG9i?=
 =?utf-8?B?d2x6R002elJCWG11UkZ1M3pTOFFBaFVSb1J6NHFrQUczY3lvSENNRFlkQVhF?=
 =?utf-8?B?MFI0enR3UW81R2g3cXAyeWdpTXZZVmtyY3lmMWgxdFh6eWFHb3JkTmsrNldR?=
 =?utf-8?B?bEx4dGw0ZHRLWUJaT0IraHA0RVhvUVBUVWJIUTVVcjdFRGlHUXlUZ0hnODBF?=
 =?utf-8?B?VUtLYjNBLzhnWWtIQ0RRV3I4SlMwUUhqczI5ellnYzN0MDIvdmJ5WGJDblFG?=
 =?utf-8?B?cHhlTVVpMWc1VUhZTUVNb3hkK3JmcTM2SUY3Uzk1ejJWcVJKeXhQSXNXUDEz?=
 =?utf-8?B?YVNJSUtDdTlpT1JGVDJkRUhyMTRmek5WWFl3VWlHSjZxcFFYYzJHei9JN1hT?=
 =?utf-8?B?YXhwYUpNM3RFUm5DOE5jY3lGY1B3aWRTTXAwZlJOWTA1cktSSi9KSTBBNHhj?=
 =?utf-8?B?MTkrMzZjelBhT3ZaOWtNUThkY3FCNUJBcWJzUFc5QXVxWEEyKzl0SFVRczYz?=
 =?utf-8?B?R0oxdEV4RE9yY3pGZmVaQlBHR2M3cEN0MmFTZDhjQWFNTTliMVdaNjExNm5H?=
 =?utf-8?B?UDYyd2JyTk1LQXczYjczU0w1VncvYyttRTZQYnlNY0JPaDlBNmN0TEJ4aTFv?=
 =?utf-8?B?UDJNdklVNWZqY0dMMXdTVnpnZWo4RGttWWxBQU83NnBzL3pXb0Q3bnVqL2xv?=
 =?utf-8?B?dkJZbHJiOVNXdUdlQTgxUEpUMzJ3a0pzWU1McjFqTDJ2TW9OUjJPSWVBMTRZ?=
 =?utf-8?B?WEhGa0R2MzExRHg0cUdheGNGT1l2RFdmWjQ3NE5DU0ZORk5MZ2lmS1dkSFlY?=
 =?utf-8?B?b1BoWnZsVzNscW1VRDRtbm00MlR2Z3V5cmc5WDIyaDFJdk9VSnB3WUxQZlNM?=
 =?utf-8?B?eVk3dUtGVlhqbkJTMDZPUmJyZTB3Tm03dXdWRWdzNTNOcXRHMjg1Z24wY1JC?=
 =?utf-8?B?dTJKMVZxQTZXQkJXenhRaFhWUllVVk9RVHQ4c3RkeTBqL2pkenFBd204OXVt?=
 =?utf-8?B?ZmJwbWdjSkZ4Y0Vtd0ZtUktiYUcrQlcrK2c5bVFkV043OHV6alNMWDNaV0NJ?=
 =?utf-8?B?KzF6VG5Qb1JzU1lUaVp6WEtxenJsekZkMmN4NXJxbURLd280U2dyVUxhckR6?=
 =?utf-8?B?WCtiYVFCN05jYlpvcDVrQ3pHZDhLNkI4TWhyMktEZmtkald6aWp1YzJLRmts?=
 =?utf-8?B?dVJnT3crUG9FWndVeFhWQ2Z0T1g1bjU4YmhVUy83eE9OSWYreTJOL05ROUVH?=
 =?utf-8?B?RVVTOHlvRURTTmM3Q1pBMkZWdWZDZXo2bHZ6YlFCVzJNU0FTQjNUOTU5dm1I?=
 =?utf-8?B?MkN2RURyZWd0SmMvREZnVHR5RmRsU05QRFFCQ2VaeFhBbkxLUnN4T2N5QXNU?=
 =?utf-8?B?VzFxSTd0QjhvQjZ3STdUZWZqYnRrdVhYTUtBUFlXS09DNVkzYjhIWVExY2hI?=
 =?utf-8?B?NWJZODZKT2FacXcrOG1ka3pDVzBVM0J3V3lwUE9ZR2paK3NYdWZxeUVIbU9u?=
 =?utf-8?B?ODRaSFJYQ0xJU1M0QzFFTEFQZFBpNUJwYVlDMTBNL2ZHd0tWWGQramdiL3BE?=
 =?utf-8?B?em9jN25EK1RxRjdFYVNWZzNVVy9GMlRJL1AwbklUL0dhdyttRnNYZ1l1STdI?=
 =?utf-8?B?TkQwelFnVGhUZmx3VjJZblNxaTBVRVNTWC9WdXMvZGRSVm5QTHFZVXhvVDVC?=
 =?utf-8?B?VHhBNk5JVDNJeUZFYVpSL2tuVG1Fek1yTkVjS3QvbmsrU3NLMGRhdy9pVEcr?=
 =?utf-8?B?bHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iEb1qn8OOR69NvJb6gYhH7ciVfyumbh4tqwcBRUNvVzpf9oL3AD9aR/zuJC6kN0QeptlTSv9rZXNf6G9jJgYk4j3Jhsge1xagf/elx7MEcFQfFLG1Bz04loIW59rZQJe/UJvEO6c/gYRMeDoLUJDIXJ9T2cLdYwhlYlEobjKFoRxkkd+3mlNZOhikqB/2m3DL9p9y8UO0I29/EZhaouw7S6r9a0SNPrz/1P8A3UIhpCUAvD45rpOMeG1u+vLu0+OyA60Vm9WKTG7GN3EINoQC25i0jF7Dca5E062dYdV68c4JDOBhnlwbYh2PprtMhf/UhvXbenZ0pJ4/Tmy9ZwiILniAMGy4f7FXBqXoRDi3Cl6pYh07yPdgClPy4xC8kBW5qFHnCwKoHDVuvirztnwg0GeG9j3L14qGrvoWj9iHPZisSbnZB982cS/Zztn01NBZlrOWBGfbENdDCPsvdGZw3Kj5u7jrjC7UYzXvuviuQsfN2QmK0ieYrAsG1pjtEufqyzm3t/WxQCY1EuTEOCIKXcpvz6IGRwPyHXE4//kTEQHBuCI9HHZQgXux4UQAVgdvCwBy75zfUIYi50Z+cV24zNn14cSu/meKPpIzs/srWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cbe16b1-9dea-49d3-86b4-08dd9896ba35
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:38:49.5335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI8pia+e/VtjO7AHZFSuaP1H6oOHzb3Yys1PkImKXX57ZZtXZ1LYlhWyQYbL5Fv1S66aBdOtLXcRaQqgWcuDgMzJJdGFNIHSYwqBEMjp/mk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8020
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210185
X-Proofpoint-ORIG-GUID: QvTYP5JgljgNsmhsWHyl6eK2TwZu_6-i
X-Authority-Analysis: v=2.4 cv=Z/bsHGRA c=1 sm=1 tr=0 ts=682e1dc1 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=eoq0gcS1HwgVmIFYlnIA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13207
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE4NSBTYWx0ZWRfX673sm/5dQZo7
 QhCbdAUMvdbzb4YVYMht76++MtvtBLyNUwWf1W2HO/WYHEM50dgB7TB9EFT7vNHUFiiaYkgVtR0
 waD58UkN270JvJCwlDSW0bUAODNBbeVxQHgzVZaOOplk8Ou0LJ+VWOiuYg1sll9NBxdKpzGApNW
 vRbB6ylVrXdJACGSHrDlegbOVyYw0tyrsDBm0Wpl84QLL1y/BpUD4udKBdf7NvaOUU+Vq6X6fx2
 CgpYJRHSoFFWZRlC4cWdSBde5cWtvTgIb+X1SkIXXI+uGcLjSQjvJaWOx4L5FeJT63N7B802bkg
 azdjFkkTGogNNFIOC7p7CCuNricJSVX0Eza9BnavPno0nxO1cNLYPJ6pMYiS0pATyLHYmadukHx
 LIIaip1cvrQSlh43NFJO2rqsjSGwOrXFVV1SjXD5wkOpJEIuYdwHqCapCCuJMDLadJsG/jSw
X-Proofpoint-GUID: QvTYP5JgljgNsmhsWHyl6eK2TwZu_6-i
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

I withdraw this patch.  Most of it is not needed if I save ioas_id
in cpr-state.  I will move a tiny bit that remains to another patch.

- Steve

On 5/12/2025 11:32 AM, Steve Sistare wrote:
> Reconstruct userland device state after CPR.  During vfio_realize, skip
> all ioctls that configure the device, as it was already configured in old
> QEMU.
> 
> Save the ioas_id in vmstate, and skip its allocation in vfio_realize.
> Because we skip ioctl's, it is not needed at realize time.  However, we do
> need the range info, so defer the call to iommufd_cdev_get_info_iova_range
> to a post_load handler, at which time the ioas_id is known.
> 
> This reconstruction is not complete.  hwpt_id and devid need special
> treatment, handled in subsequent patches.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/cpr-iommufd.c |  8 ++++++++
>   hw/vfio/iommufd.c     | 17 +++++++++++++++++
>   2 files changed, 25 insertions(+)
> 
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> index b760bd3..3d430f0 100644
> --- a/hw/vfio/cpr-iommufd.c
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -31,6 +31,13 @@ static int vfio_container_post_load(void *opaque, int version_id)
>       VFIOIOMMUFDContainer *container = opaque;
>       VFIOContainerBase *bcontainer = &container->bcontainer;
>       VFIODevice *vbasedev;
> +    Error *err = NULL;
> +    uint32_t ioas_id = container->ioas_id;
> +
> +    if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
> +        error_report_err(err);
> +        return -1;
> +    }
>   
>       QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>           vbasedev->cpr.reused = false;
> @@ -47,6 +54,7 @@ static const VMStateDescription vfio_container_vmstate = {
>       .post_load = vfio_container_post_load,
>       .needed = cpr_needed_for_reuse,
>       .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(ioas_id, VFIOIOMMUFDContainer),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 046f601..c49a7e7 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -122,6 +122,10 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>           goto err_kvm_device_add;
>       }
>   
> +    if (vbasedev->cpr.reused) {
> +        goto skip_bind;
> +    }
> +
>       /* Bind device to iommufd */
>       bind.iommufd = iommufd->fd;
>       if (ioctl(vbasedev->fd, VFIO_DEVICE_BIND_IOMMUFD, &bind)) {
> @@ -133,6 +137,8 @@ static bool iommufd_cdev_connect_and_bind(VFIODevice *vbasedev, Error **errp)
>       vbasedev->devid = bind.out_devid;
>       trace_iommufd_cdev_connect_and_bind(bind.iommufd, vbasedev->name,
>                                           vbasedev->fd, vbasedev->devid);
> +
> +skip_bind:
>       return true;
>   err_bind:
>       iommufd_cdev_kvm_device_del(vbasedev);
> @@ -580,6 +586,11 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           }
>       }
>   
> +    if (vbasedev->cpr.reused) {
> +        ioas_id = -1;           /* ioas_id will be received from vmstate */
> +        goto skip_ioas_alloc;
> +    }
> +
>       /* Need to allocate a new dedicated container */
>       if (!iommufd_backend_alloc_ioas(vbasedev->iommufd, &ioas_id, errp)) {
>           goto err_alloc_ioas;
> @@ -587,6 +598,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>   
>       trace_iommufd_cdev_alloc_ioas(vbasedev->iommufd->fd, ioas_id);
>   
> +skip_ioas_alloc:
>       container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>       container->be = vbasedev->iommufd;
>       container->ioas_id = ioas_id;
> @@ -605,6 +617,10 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           goto err_discard_disable;
>       }
>   
> +    if (vbasedev->cpr.reused) {
> +        goto skip_info;
> +    }
> +
>       if (!iommufd_cdev_get_info_iova_range(container, ioas_id, &err)) {
>           error_append_hint(&err,
>                      "Fallback to default 64bit IOVA range and 4K page size\n");
> @@ -613,6 +629,7 @@ static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>           bcontainer->pgsizes = qemu_real_host_page_size();
>       }
>   
> +skip_info:
>       if (!vfio_listener_register(bcontainer, errp)) {
>           goto err_listener_register;
>       }


