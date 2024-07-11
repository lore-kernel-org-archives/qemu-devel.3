Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977C2C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 10:45:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrIK-00029a-1K; Thu, 11 Jul 2024 06:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRrII-00028z-Ll
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:44:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRrIF-00024x-Fb
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 06:44:58 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tYKw006699;
 Thu, 11 Jul 2024 10:44:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=bWBkGAkdeoN6smAjfx35KgzkWNQtPrIdwuy779pOBQ4=; b=
 mxy4SELW/RMCa41OFFXdXZKmYytToZaYXaB/olTzT+MmzAqzxq2Dmwa+dvkRj39M
 mCNbYlRAf0dTv42PGtlh8d7O/w/pKUF+DjP8AzOTo1E4Dt/3cCA10hQOFDhJTzOE
 4OLgiU86ydH1V5JInHVqMccCIUjpUjNfdidHYWIiL4PsSj2wYjaP5xRqGnetb2D/
 MsCxEltU0KaGDiPJuy7CN6krDfg9IC2OR+CyoiXVrD3fIdYA38+Nv7xjQz7KnEsS
 eePArwayaYIFzhabJGCJaGv0AJ55Ts+bGxSPw9vj8BGinns4cbpX86B65wlrviZF
 BsFDL+0AdqTww4vBpi71EA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq1crk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2024 10:44:52 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46B93gKK022896; Thu, 11 Jul 2024 10:44:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 409vv29qs0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2024 10:44:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnpchRxUktmw3a9ckSiWXIuolWvzv/s9yHEjGNwyzmNG1NN1+ClWLm21Q9JNjZypzOT6TMigwqXJdygUbIn4E1/iR/Rnz3sEmqG9M58AMX33dDsG3lm9r8i+Xg8xkJ3lJV9aZ2tuw0jz+YKxqjg67Ys0iF0RXMctkJRgsQ2x/uAie2Dqje/7WIXOD5ObdFum8Xg3BV+Qa4lwdH3USz6R+eM2ekh+LG2FPlQmVdBlLqs5EvoJgtVjG6GyDemRilgwC74RLTkGG9cRJeLVAlSyLzhFcHNGaf7wlgpkMPpbVyU98ke6g0wHzLiO9QBeb0H2UmIsOC9LwrX/L1WfblyWeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWBkGAkdeoN6smAjfx35KgzkWNQtPrIdwuy779pOBQ4=;
 b=L/fJpTbViixOjLv3P3h2jjP6NmiWPJd8NmC6uGjyfuoKpRpH5TrisTDj/zvxXLWeVhxSV5WZYc3XoZjbMnmHPWsxl8ryiVwilQVl57LtI6WDU+4yUCFOdz23I2FVFp10xlTUfC4yc6XBNnGedIHU9j0TfrEc7OEny9dyN+OdNXLLDqrXhV8+0x0ThR+1+Ll5sZYj8NvTScqrrN1exfdSzvAFsVh4i3ZTi3thoN86tpWy7n3VklxWe5wnY6H+tRkAGjL9IlwhnGLPz2tp64CsYOWrXwwFQ0qOUjjAuH0A3GSe9gWDnf9/hMaftsoO9DVKMl4bd4odj8sggqt5cFBvcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWBkGAkdeoN6smAjfx35KgzkWNQtPrIdwuy779pOBQ4=;
 b=VyifS8GvV1TOJZtHjW/KfGFQ0jEKXOhSoinSOzGu1xTHb2yzNG5L3BTBF+2Ad8XSlV7beqZPQj0v4MayiIsoEhG22hProaXUnQ9B8WM/BwhL0vuxdfBQoiKAcPQk4gxEUyaa/qa+JM+dnrRAooi6hm5fJVVaGRM1K6eP5Mv0Dno=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SA6PR10MB8157.namprd10.prod.outlook.com (2603:10b6:806:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 10:44:32 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 10:44:32 +0000
Message-ID: <e8a510f0-b76b-4f72-ae99-a18a4bfdfb17@oracle.com>
Date: Thu, 11 Jul 2024 11:44:24 +0100
Subject: Re: [PATCH v3 00/10] hw/vfio: IOMMUFD Dirty Tracking
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <bf7bbf89-2930-42d0-9a3e-edff8e6c496d@redhat.com>
 <62aa04db-35e2-45dc-af0e-aea3acc332aa@oracle.com>
 <SJ0PR11MB6744373FFC0993E12FB3A29492A52@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744373FFC0993E12FB3A29492A52@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0270.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::15) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SA6PR10MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: b213ea03-7f9d-494f-dd2d-08dca19672a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVVYUi8wVGhWRXBsQTVPQVV2UmVHWGpKNVJVdVBuTFRBcytyeHIwNmdwWXZi?=
 =?utf-8?B?NHFGclFiUThheE5SdVd4NlpjZitNOUxSV0xFalJIcmVEalpPZHFRcndLUWQ2?=
 =?utf-8?B?aUIwNmdtd0NMVS80ZXlzVC9QNlBZTVRFNmVxUWdVb0c5VkIxU3QwcEVDZDc3?=
 =?utf-8?B?c2lHTnVSemZMSzJsbDJhT1Y1TThZanBjdTJnMDErNGpNRVBPNXdnamRFOFpR?=
 =?utf-8?B?LzFsemdITmlpVG5ncC9QbjlCNHh5SGYraU5aUjFnUGFFMlc0cWpGTTZzM1Nn?=
 =?utf-8?B?U2l4ZDduY1RRZmM2OXFzcGpJN201dzdadGpHUkZFSDJSY1l4S3g3aUZ1WUx2?=
 =?utf-8?B?dUZOSHZTWFkwMEFqVnIwSzZCQmpjYW5yMEhiL1MrdmlieDJxVHJMRUhoTllS?=
 =?utf-8?B?K2drTmhSN3FYamNRNDJ4clI1UldQRUxBbVN5bEJsVktQeFNNWm5VeEl1MGJy?=
 =?utf-8?B?K1p4VVVwd0RTWFdTbHB4K3BJeHBUakg1amkrTUhpejkzS1FMbmp2YXRNMDB0?=
 =?utf-8?B?RjZoN21rL0lFUXRsZmN5T2ppZ0k4WkU3R1ZsZFkyNlhqL1g0UUM5S0hkNk0y?=
 =?utf-8?B?OHdTUUNlRnFESVVGVXo0bmdPbUJsUldmelcrQzNOWHlWSmhHRnRBakVLN3RP?=
 =?utf-8?B?a3BBOEtVL3B3YmNxY2JEdmt3cDJUaTdCQVhPaW1ETkZhWUVHLzlpenFwTFpD?=
 =?utf-8?B?ZVYra3dHOWxEdWw2RmQ3bVBHbU1aYVVDY0hsV1VQRXNodFhGME5leHEzcDhh?=
 =?utf-8?B?QmJRWENsRWI5RnBCd1o2NkJOTFZ5RDBoa05CMGNCZktScUVNMVkzb25DNlVJ?=
 =?utf-8?B?SzREd3dsNXZyelFaS09GYUJvWitTd2lWRmYxSjN3U0xoKzFjSXphcnFSb1Vr?=
 =?utf-8?B?bndObVE4Tk1XWkVDK2dHQVNybEtycmt3ZnhMa1pOMGJibE5aY1VraGJscldV?=
 =?utf-8?B?OEd6NjhyTWh3M0VVamhyVGFuZjkrd0IzODZlQU5oNjZ0R05IbGJlUkJyTXcw?=
 =?utf-8?B?bVkvTjNQb1lMUncwZjZET2J1T1MwbVFMdUhoT1JWbDlGQkRMTTVRajJWNDhN?=
 =?utf-8?B?dno1WHpWVEN4VndYZm01OUlqMktWV1BvMVNlZXNVb2ZkaXBYQVhqUDA1Qm5F?=
 =?utf-8?B?RGQ4RTBPZmpSdkxDTVB1WGJMSHNJQktTaWNZYnZzc1UyVGZFUHkxUFdaVyt3?=
 =?utf-8?B?ZUovRzRUbHMwdGtlYTF4emhGdFVDdGtIc1Z6c2oyVHl4MTJzbzN4QUhQbXpC?=
 =?utf-8?B?ejRGakpDc0hubE9KOTcvbmxOZzJFQnREb2Q5RUtTSkpaVE04MTNyWm5pOVAw?=
 =?utf-8?B?d2pMaGhIdGlidjZicnluNlNJNkF4TkZRTm9USkZsOFpoM1NaRjhBZDVncCtt?=
 =?utf-8?B?b0pvNW93UnRlalI1WTVhVytXS1JSZHdtd2wvK1pyb0dXc1lQd01XcEk5QnJk?=
 =?utf-8?B?SUlSOXpOSmlJWEpGZnZmc1REWlptQmpHRmFhaEhvb21RWU5veXZYZzA1WDFq?=
 =?utf-8?B?bTBjOVNJN1BNMkVPczlDNlowZUljaS9BMTREbXNDK1lFSUhiV0Z6bENadkNr?=
 =?utf-8?B?TlI5b1I3WTE0M0ZBaXFSRWZHS2hQUEFDRzIyNDhHRitrM3N3TCtxTE5iVkI3?=
 =?utf-8?B?c2g5akFkSUtNS1c4dzN2d2U1WE4vclM2a3hYZ3JCSFQ0cEJmd3lDWnIwTDgv?=
 =?utf-8?B?UkZMbHowanptczcyZ21ORktZOUYvM1ZPeUFiNE1qQlRoQXYxWklhQlk1eGYr?=
 =?utf-8?Q?NtnFxmYBvq2i7NK4r5p5ZzvGLGKlk4N9ETD8YsV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3lrcHA4NnBIeGFVZHJaTXQ5Zkord3o3UXNJSmdxWjNYREM3L3BNWDAwL25y?=
 =?utf-8?B?cHZuMm5lNXNOQzVweEJ2UDN6eisyL2MweG4xVDUvbnlhZWhRZUNmTFNFZnZ6?=
 =?utf-8?B?ZmF1cWc0VVE3WjE2L050WEFjUEJ3YzBMN2l2SzEzVzVTUjJzY1Zad2NIbHk2?=
 =?utf-8?B?WkVUYm5vY0JER3NNM1pGQ1N3ZWFFTjJBU05maEJtTEZ5M3RlY3FWa0JUSE01?=
 =?utf-8?B?Vk5ZYXo1Z2tvUG83SlFtZ1UwV0Z3L2JKcGlQOGxkdW1hSTBIZ2Rkc0R6UmN5?=
 =?utf-8?B?aUE4WlNsQkcxaFpKejhDOWJoM0duWHRPNFo2RGFWOVhhOWREdkFpR1lTRkZG?=
 =?utf-8?B?cWx4d1gzeGVWUTkxUUN2QkI5b3ZBWElnbjUreEVmMkRHWis4MUhPQUtZbTZp?=
 =?utf-8?B?dU56TWZSRm1EZUZwaFM5UXNoTzRyQ1p0dkNhUUM5eGNEYkRpaXV5NUs5b0Za?=
 =?utf-8?B?dlFMYkVMUnM0RjVaREdUZWpjc0duK0c3ajMvUVVNNFA1OXZqVXRsWkthZ1Bh?=
 =?utf-8?B?VjZ3L2tvL0hCZWE4REhzV3QzZzF6c3JwMHM1NTl4R1VBdFkxSC85L1ptcGFI?=
 =?utf-8?B?Ynk1VzdUWjNDR3ZHa2xOSjJzWk1JTGUxRmd2OEJoODB2K3I4MzEwSUpsSFAz?=
 =?utf-8?B?MEpJS28wbEN3dFMzQWxUTkVzNzdoWHF0VVVSTWZkWW1JZWl1UG40cCtGN2Ru?=
 =?utf-8?B?dUdJUGsrL29Na1JpZ0JnS0NLZy9GZWlhUUo0VllWeFVNTTZZZGRqQlFBaTM2?=
 =?utf-8?B?QkVzMzlFSk1nakcrMFU1R0xTT1dlOVM1R3lYRkk4dUUrS3hUcmEvWWVsR1Y1?=
 =?utf-8?B?SmxhenRnUkdUem1xR0VuM2lCb2pXS2R4UzdqRFBZVlU2RjB5blB4dWZZRkhr?=
 =?utf-8?B?d0VNUXYrbEZ5UVZERDZDTjN3aGFQbDFjYUtLZnQ1WEc5YnBsZ1pqTjh4MTBG?=
 =?utf-8?B?SDVuWXQrTHRrR3orWUNwS1F6eVIxcm9Ba1IzM04zaGZ0OE5nMzJpOUcxakNx?=
 =?utf-8?B?N0VoNVNnYkhxV0lPTzJUOUtFaUM5cGFGeHF0a2RQMmh3UnN5SmxRSHJMTVhT?=
 =?utf-8?B?RWkrUDdpdDRHL2xTb1lVRk1PaGlwblluckYzZjVqaDdLMWsyRG53bGpQQ2VJ?=
 =?utf-8?B?aWkzZ3hDL0JYSzlybTUzTWNOMjFySS9mZVlzajB2L1BUS3BMVGZjRUw2TjFa?=
 =?utf-8?B?cEVDTUdqSk96UWEydmtmQ1lORzNMYkQ5Rjg2L1N0RGZRK0R0OFZaZjJzNWdr?=
 =?utf-8?B?bGV4YmtPNnRGb3luTWkybmpjbFNJL3ZEKzZTeUsxY2E3NGc4eVBsdlNsMHJQ?=
 =?utf-8?B?czJXZEJDVkRrbHVCQis3M0tRTnZXTjJKcXhkblBZWHBiQWJaamI1V0pMcW56?=
 =?utf-8?B?QWk4b0J0UDlrMjNrU1h5ZUdkNXFiS1RVUzNnekRCQXd2cDREUUlOTmMzTllO?=
 =?utf-8?B?bGZZdi9TazIwSisvMFRXWHhiVHBZTTYyWlhkOXFsS0ZES0RlalVFdjRTNS8v?=
 =?utf-8?B?aldVcGcyS01sdDhxTDhoWTIyQTQ5UEJRcVJITks3WFlINnZUaWdnanJGc3E0?=
 =?utf-8?B?MlZoNHJrUGUvVmhVcm1HYk5uYW9sbi9YN1B6eTVLM0NvWjhQTUdyNXEwUXZX?=
 =?utf-8?B?VUd3WVBTREpiSGw1aGgxdkJJdjFKRVpCTFZVUXZBSW9USllmd0RnZmxOYjJK?=
 =?utf-8?B?aHdIY1lqZzVjbC9HcFV2L0U0YWZlNkpnNTBRdittK2l0K2piaHgrNHBzVVRu?=
 =?utf-8?B?MzliOVFJZ3FLTlRjclNSdTFXdTBDWTcrSVZnRlhxekNpZHNQRkt6YUIwMHUx?=
 =?utf-8?B?WmxOOGIvM0hPbkFYRWR4T0NRdDdKQ1d0VXFIWGdRYTZ3WnllcWxuaGhacDRx?=
 =?utf-8?B?OWxBZUhaSDVDNDNWU01xWUlSUnBPR1plT3M5QnpwdFlLdVBVMHA1VWNuejZ2?=
 =?utf-8?B?RGk2aGlpSTVDZ2IrRXNIeGlnNTl2cTNCaWVLY1RYN3pBbnFOK2RXcjl3THVN?=
 =?utf-8?B?ekFuc3dBTXN4RlYyNTdZbkwxOTQxWmlYeExJQXlESVlyM0xPVERNQVNYUHY4?=
 =?utf-8?B?MkRzazJhRkJGLzhaT1pnVU9MSXVQaUE5U21rUXluSXRxcnB5bUw1OWpiTlFN?=
 =?utf-8?B?TjdmaUVlalRUcytYeW1wNzllOGpoTVppRG1nYlh3L2lmN1lWcFV3Q0prVXVC?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0itqI5t3Wfmd9/fU+vGS6FMweODBiJfS70bUL3fFRoQ+pnxOLklXCTfxJVS5C9SsV1hkPjWJx5JtffVT2AhkfSLfOsC43KQVqkd7ejObc7QJ7jy6Dd0mNhg1sag8fBozTnj6Zh5isZsjaY8Afr+ux511O34ChKRIqt4Wyvnl8Q1/OCWf5cIwQXUxLjHqsradE3Ljb2L+NATNYxFwKFColyJHUKNDXy9fgZJRTGwkmjG3qTuZhu3fDZEw7zdWIsjPiCaL3h1fU1Ko70SiXT/aAPBVO5dO5gJKzJNTi0+g9gbwLUmANER0HrgkAaMd9BIgl+dnv7y8Rv6siuMk2p0192S5Iv/hqBkftChOHXTeTqdjAD7QBwzIucUnCQ/z9tUbGSbrQZf2AzfcFSKWhYrrPz8XYVWmyqAv3mAkwwFYNfTuJFrZY7kBeSRLm+y/TuqzFP5nk8Y3X15HRFTaZdazq+ASSXjMRMubkemTPypqOxkWL/qNElFgeFOaA4u1xCuMzImYxIOm2CyqqecqQAcrDgi02xSkAE3Y48AxYm6VbNr2lUrkQfStZM5dsGqLKHSPNMQaxfHSFthlnFlT3Sjc4vE1iU8YI8wbj4EH9zvGpWY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b213ea03-7f9d-494f-dd2d-08dca19672a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:44:32.2671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KrJYwjJHD/CbEfqV+oaWzwaDD2qDogZyPhDJHk90ZjvtD/IsT5jK9lLM0D3sby6lyMqNZ8GADbRSfkZ3q9AKHE/ZzkhNRiPljX6W6aABck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_06,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110076
X-Proofpoint-ORIG-GUID: ppcYXKF9W489kz2BYaegb0w1eq3ix-xy
X-Proofpoint-GUID: ppcYXKF9W489kz2BYaegb0w1eq3ix-xy
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

On 11/07/2024 11:22, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v3 00/10] hw/vfio: IOMMUFD Dirty Tracking
>>
>> On 11/07/2024 08:41, Cédric Le Goater wrote:
>>> Hello Joao,
>>>
>>> On 7/8/24 4:34 PM, Joao Martins wrote:
>>>> This small series adds support for IOMMU dirty tracking support via the
>>>> IOMMUFD backend. The hardware capability is available on most recent
>> x86
>>>> hardware. The series is divided organized as follows:
>>>>
>>>> * Patch 1: Fixes a regression into mdev support with IOMMUFD. This
>>>>             one is independent of the series but happened to cross it
>>>>             while testing mdev with this series
>>>>
>>>> * Patch 2: Adds a support to iommufd_get_device_info() for capabilities
>>>>
>>>> * Patches 3 - 7: IOMMUFD backend support for dirty tracking;
>>>>
>>>> Introduce auto domains -- Patch 3 goes into more detail, but the gist is
>> that
>>>> we will find and attach a device to a compatible IOMMU domain, or
>> allocate a new
>>>> hardware pagetable *or* rely on kernel IOAS attach (for mdevs).
>> Afterwards the
>>>> workflow is relatively simple:
>>>>
>>>> 1) Probe device and allow dirty tracking in the HWPT
>>>> 2) Toggling dirty tracking on/off
>>>> 3) Read-and-clear of Dirty IOVAs
>>>>
>>>> The heuristics selected for (1) were to always request the HWPT for
>>>> dirty tracking if supported, or rely on device dirty page tracking. This
>>>> is a little simplistic and we aren't necessarily utilizing IOMMU dirty
>>>> tracking even if we ask during hwpt allocation.
>>>>
>>>> The unmap case is deferred until further vIOMMU support with migration
>>>> is added[3] which will then introduce the usage of
>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP
>> ioctl in the
>>>> dma unmap bitmap flow.
>>>>
>>>> * Patches 8-10: Don't block live migration where there's no VF dirty
>>>> tracker, considering that we have IOMMU dirty tracking.
>>>>
>>>> Comments and feedback appreciated.
>>>>
>>>> Cheers,
>>>>      Joao
>>>>
>>>> P.S. Suggest linux-next (or future v6.11) as hypervisor kernel as there's
>>>> some bugs fixed there with regards to IOMMU hugepage dirty tracking.
>>>>
>>>> Changes since RFCv2[4]:
>>>> * Always allocate hwpt with IOMMU_HWPT_ALLOC_DIRTY_TRACKING
>> even if
>>>> we end up not actually toggling dirty tracking. (Avihai)
>>>> * Fix error handling widely in auto domains logic and all patches (Avihai)
>>>> * Reuse iommufd_backend_get_device_info() for capabilities (Zhenzhong)
>>>> * New patches 1 and 2 taking into consideration previous comments.
>>>> * Store hwpt::flags to know if we have dirty tracking (Avihai)
>>>> * New patch 8, that allows to query dirty tracking support after
>>>> provisioning. This is a cleaner way to check IOMMU dirty tracking support
>>>> when vfio::migration is iniitalized, as opposed to RFCv2 via device caps.
>>>> device caps way is still used because at vfio attach we aren't yet with
>>>> a fully initialized migration state.
>>>> * Adopt error propagation in query,set dirty tracking
>>>> * Misc improvements overall broadly and Avihai
>>>> * Drop hugepages as it's a bit unrelated; I can pursue that patch
>>>> * separately. The main motivation is to provide a way to test
>>>> without hugepages similar to what
>> vfio_type1_iommu.disable_hugepages=1
>>>> does.
>>>>
>>>> Changes since RFCv1[2]:
>>>> * Remove intel/amd dirty tracking emulation enabling
>>>> * Remove the dirtyrate improvement for VF/IOMMU dirty tracking
>>>> [Will pursue these two in separate series]
>>>> * Introduce auto domains support
>>>> * Enforce dirty tracking following the IOMMUFD UAPI for this
>>>> * Add support for toggling hugepages in IOMMUFD
>>>> * Auto enable support when VF supports migration to use IOMMU
>>>> when it doesn't have VF dirty tracking
>>>> * Add a parameter to toggle VF dirty tracking
>>>>
>>>> [0]
>>>> https://lore.kernel.org/qemu-devel/20240201072818.327930-1-
>> zhenzhong.duan@intel.com/
>>>> [1]
>>>> https://lore.kernel.org/qemu-devel/20240201072818.327930-10-
>> zhenzhong.duan@intel.com/
>>>> [2]
>>>> https://lore.kernel.org/qemu-devel/20220428211351.3897-1-
>> joao.m.martins@oracle.com/
>>>> [3]
>>>> https://lore.kernel.org/qemu-devel/20230622214845.3980-1-
>> joao.m.martins@oracle.com/
>>>> [4]
>>>> https://lore.kernel.org/qemu-devel/20240212135643.5858-1-
>> joao.m.martins@oracle.com/
>>>>
>>>> Joao Martins (10):
>>>>    vfio/iommufd: don't fail to realize on IOMMU_GET_HW_INFO failure
>>>>    backends/iommufd: Extend iommufd_backend_get_device_info() to
>> fetch HW
>>>> capabilities
>>>>    vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
>>>>    vfio/iommufd: Introduce auto domain creation
>>>>    vfio/iommufd: Probe and request hwpt dirty tracking capability
>>>>    vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking
>> support
>>>>    vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap
>> support
>>>>    vfio/iommufd: Parse hw_caps and store dirty tracking support
>>>>    vfio/migration: Don't block migration device dirty tracking is
>> unsupported
>>>>    vfio/common: Allow disabling device dirty page tracking
>>>>
>>>>   include/hw/vfio/vfio-common.h      |  11 ++
>>>>   include/sysemu/host_iommu_device.h |   2 +
>>>>   include/sysemu/iommufd.h           |  12 +-
>>>>   backends/iommufd.c                 |  81 ++++++++++-
>>>>   hw/vfio/common.c                   |   3 +
>>>>   hw/vfio/iommufd.c                  | 217 +++++++++++++++++++++++++++--
>>>>   hw/vfio/migration.c                |   7 +-
>>>>   hw/vfio/pci.c                      |   3 +
>>>>   backends/trace-events              |   3 +
>>>>   9 files changed, 325 insertions(+), 14 deletions(-)
>>>
>>>
>>> I am a bit confused with all the inline proposals. Would you mind
>>> resending a v4 please ?
>>>
>>
>> Yeap, I'll send it out today, or worst case tomorrow morning.
>>
>>> Regarding my comments on error handling,
>>>
>>> The error should be set in case of failure, which means a routine
>>> can not return 'false' or '-errno' and not setting 'Error **'
>>> parameter at the same time.
>>>
>>> If the returned value needs to be interpreted in some ways, for a
>>> retry or any reason, then it makes sense to use an int, else please
>>> use a bool. This is to avoid random negative values being interpreted
>>> as an errno when they are not.
>>>
>> OK, I'll retain the Error* creation even when expecting to test the errno.
>>
>>> With VFIO migration support, low level errors (from the adapter FW
>>> through the VFIO PCI variant driver) now reach to the core migration
>>> subsystem. It is preferable to propagate this error, possibly literal,
>>> to the VMM, monitor or libvirt. It's not fully symmetric today because
>>> the log_global_stop handler for dirty tracking enablement is not
>>> addressed. Anyhow, an effort on error reporting needs to be made and
>>> any use of error_report() in a low level function is a sign for
>>> improvement.
>>>
>> Gotcha. My earlier comment was mostly that it sounded like there was no
>> place
>> for returning -errno, but it seems it's not that binary and the Error* is the
>> thing that really matters here.
>>
>>> I think it would have value to probe early the host IOMMU device for
>>> its HW features. If the results were cached in the HostIOMMUDevice
>>> struct, it would then remove unnecessary and redundant calls to the
>>> host kernel and avoid error handling in complex code paths. I hope
>>> this is feasible. I haven't looked closely tbh.
>>>
>> OK, I'll post in this series what I had inline[0], as that's what I did.
>>
>> [0]
>> https://lore.kernel.org/qemu-devel/4e85db04-fbaa-4a6b-b133-
>> 59170c471e24@oracle.com/
>>
>> The gotcha in my opinion is that I cache IOMMUFD specific data returned by
>> the
>> GET_HW_INFO ioctl inside a new HostIOMMUDeviceCaps::iommufd. The
>> reason being
>> that vfio_device_get_aw_bits() has a hidden assumption that the container
>> is
>> already populated with the list of allowed iova ranges, which is not true for
>> the first device. So rather than have partial set of caps initialized, I
>> essentially ended up with fetching the raw caps and store them, and serialize
>> caps into named features (e.g. caps::aw_bits) in
>> HostIOMMUDevice::realize().
> 
> Another way is to call vfio_device_get_aw_bits() and return its result directly
> in get_cap(), then no need to initialize caps::aw_bits.
> This way host IOMMU device can be moved ahead as Cédric suggested.

Oh, yes, that's a great alternative. Let me adopt that instead and we don't need
to make so huge changes structure wise.

