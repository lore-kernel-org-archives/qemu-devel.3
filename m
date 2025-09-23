Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F11DCAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z9u-00086p-Iu; Tue, 23 Sep 2025 05:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v0z9c-0007nv-BL
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:17:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1v0z9U-0001Pj-37
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:17:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N7txLx001265;
 Tue, 23 Sep 2025 09:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=L3RPBJrTmFgcxRr/DPgSTaP2EsxiMao4S3RLDfnfINw=; b=
 SsDWWprq+0p47nWNF/pro/913BXAMuXfVjR90tNCqYRGUUiFam17GSap2aH7AWaA
 3+gsz3jvXdnS2QH7XfFsY06+ig19slNSiizjWH5U3jeE0axvFvXGft2aZeyVqx5i
 wIGuvhvG/vROw137/GmbINfnHD5SbD2Cbn4Dl7bq/eVudfZk8TvhivfyhNItaHJ+
 zh9XXm0fcUT8ktaTspoTiX1086vKfV87G6gqBMrUFeXm6Zk/WVW1P944qwGfgO5w
 Ly+fx8vvnrdTc8oUbj+KZ+qSuM04csPuq19Efu9etJAKm6l6thpWa5HPddcPp0xN
 zklp5pssexIe3PSE23clLw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvtv6kx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Sep 2025 09:17:28 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58N7lKFH034333; Tue, 23 Sep 2025 09:17:27 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49a6njcu0s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Sep 2025 09:17:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y2QHgN3iqWQga+8AujEsALv/9o00ySCC/GxZ09G4om89cJoOK8tbTJazYAZazf+kBoleG5VlnZwXfBjlYxisGXLHpiHeiKUwIVyVvAa/cqBXsYTIeKNnDfi9E+I8Iw/5JHN07GQurkDqr5C3+eQteF1uWpJgkC2TZuqVRmKRtqXiEac2LS8RrC1gzEbxxXIFpTpW7mbTfeMLKDOeOWuaoAnbpX0ZkhYWp7pNlqu7wlbZetzUwrl+PKTlo6WhMghXnxzKp2rCbGstasygybXmPAAEudmI5iGmJ/osN37aopEu9OjGrYqtorF+R9rQPdi/16G0pdfbp/xZSN4u57zm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3RPBJrTmFgcxRr/DPgSTaP2EsxiMao4S3RLDfnfINw=;
 b=SSOXowMd7rUbKIsFaLVd+aI1svGFmjMYB4NWkyy/PpTyj8oxwys9uLpQQLYXYgE7SY6LRHib5S3G+HoVZuPyZreZMOWfXTPir9tPEz2AE5JPaBzTB+slcqZsxbaWv+NcpiwpKlbs1o8VnunK6CkPXDj96nxmm7qrShvbChHNsbfbcyOrQEqMH/erbHjYnSiTFe2aTVyAbyqxU7ZyfygLP5A5rOoXigKXIM6TE2yX2QEHaKkDOuMdv7CtK8ig2KLB44Od/BNoerCClCiSy6zGWOLDaFl4FzzyFRmOmxHyBUCfaUKyIupd4vOXHMrTF/sbTPX504XGN5ywAtpaakA1SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3RPBJrTmFgcxRr/DPgSTaP2EsxiMao4S3RLDfnfINw=;
 b=BBLGICzil6s+y8HNlGquh3DIj7GViDdJoj+M7nyh8Wnfw0xTNIe8gH1xSAkO7MiUlq5q5ApnOve11CrZ4eBN6fJzfmQsFz10q2UNzgilMJVQBYJjHG4qwz7b+cnfUNYb3nmcsVmmBdvOsPQqSgHroDlmfA7nth9McYDSBUf4SZ8=
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4) by DS0PR10MB7126.namprd10.prod.outlook.com
 (2603:10b6:8:dc::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 09:17:24 +0000
Received: from PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61]) by PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 ([fe80::39ac:d97e:eafa:8d61%3]) with mapi id 15.20.9137.017; Tue, 23 Sep 2025
 09:17:23 +0000
Message-ID: <54480877-bdda-4acc-be44-b09ed141a00b@oracle.com>
Date: Tue, 23 Sep 2025 10:17:17 +0100
Subject: Re: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, Xudong"
 <xudong.hao@intel.com>, "Cabiddu, Giovanni" <giovanni.cabiddu@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>,
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
 <ce629779-42ea-4850-924a-5803a7547998@oracle.com>
 <4120d83b-9f84-466d-b359-d73a3e7192a8@oracle.com>
 <IA3PR11MB91368B78D35566353217B544921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <IA3PR11MB91368B78D35566353217B544921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0061.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::6) To PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFE6F9E2E1D:EE_|DS0PR10MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d3ca91-cc99-45c3-94e4-08ddfa82019b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEZQTzgxellrTW50Y1g5RjBldnYvblpZamFHUlk1bFU2YVJoVnFSN2JYQk9I?=
 =?utf-8?B?b0VOU0pqZ2JYOGhsUmM2b0pReXVDc2JSck9reWMvSDZadkp4N01xcWEwaVRq?=
 =?utf-8?B?dDRXWm9iU2I4SzJ6bDVvWURtUCttc1o5b3NaOU9CTTFkZW1OM1RkdXFIaVBL?=
 =?utf-8?B?NjcvMThoUXVFckFGU0VYSEdZa3d6L3pGME5KY3BseWJ1cGJtY2JCRGRKUTdp?=
 =?utf-8?B?cWdUSE1aWXRCZzhSVmRieVhENWRvaDFWT0d0amFJclpobVFDa0VRYXJ3MzFL?=
 =?utf-8?B?UjhPam9FTk02clR2VGdweWUvTVk1SnI3Mkt1M1dNNXdWSEg0ZHEwSHBKSmFR?=
 =?utf-8?B?cXl3elFTZmlyVi9FaE92OEhIU0krVkJ3Z3hFeFp2eTVxaGFFR25JOHRrd0dB?=
 =?utf-8?B?ZDlwaXdMYmRabEg3SHg0eVcvZ0xCWFU2andFUzA3WGpIdmxPMmZmR0JpMndV?=
 =?utf-8?B?N0N1Wm44Y1dnQzZualROa2xTaHYwck1YeWxnS2doZVlOUDdRZ1YzOHRvS0Rj?=
 =?utf-8?B?azg5QlFQSzd5cnU4bDVSdGE2QTFuWWEwQ29XVUhUanQzaXlJUzhsTFgraUFX?=
 =?utf-8?B?N3VtdTdXUDIxMlZsdG11ZElvemNzWThiczZtQjVrQ2FxU0FIdGRRV0hBd3BM?=
 =?utf-8?B?Y3JvSHIyOTR0bWtrdlE0eHU0OUhtcjR3eFdDandtdkFmQ0hBYmk0Rm4rT3Vy?=
 =?utf-8?B?NVZWNXdUc0NWOXB3YjN1ZWpkd1A0b0dwcXVFUE5wTVhwQXA3d2EyM0N1bk1B?=
 =?utf-8?B?dHA5MjRva1dLRnM2RkJZZE5WZS91MHZ1bFpKcTA2SGRjQ0RpQWx4Y0EyTzFL?=
 =?utf-8?B?QmNxTktBeDYzSU5oQmwvZHNMUGdqZE5QR3l4U29PclVlQmFwVTFSenBmZldN?=
 =?utf-8?B?QVBvbDdnR3lNUCt5Y2xFbHp3azFXVnBoNEJxdmNERytGUklOdXZpWEtmNG1U?=
 =?utf-8?B?MjdwNGsvaFR1WS9EV2RPend1SzZZdUFZWlpZM0RPeWR1TkJVSGFMWnk1aWVw?=
 =?utf-8?B?aHdUQUc2VjU3UFdKV0tXdERaKzkzWDgrL2pBZzJsMkJrR0d6OU92QzdmZCs1?=
 =?utf-8?B?SkE5RlgrMkZrZG03UU5wS3N2YmN6c25tWmp3eGQ1Z0svZUh5N2ZwaGg3TFMr?=
 =?utf-8?B?dmcvZG81MDMwSk1WK3NaaFdUZnNTRkEvZENNT010VUJubGVvNUxYbk9RaElW?=
 =?utf-8?B?QkxYRGtLdEJpa0piS1BoSW0yeVcvZ1IreEUyNDErVjRreXZuRGI2SmtNeHlH?=
 =?utf-8?B?UThWTG5TQ3FJRk5Sekp0YlRqS2QrRUowLzZNUm1ZZ2NSU3V3clJESHh2RVBV?=
 =?utf-8?B?TmcvVVNmZ2xHdWU1d3Q1aTRMcmJRUVcyTHcyYzU3ZG44MjR4WSttUEtVYXJk?=
 =?utf-8?B?bU9zdWlrem9HNlhyai84SWt5Z2ZHOFdWVmpUV0lMcUI1QXlzUTh2bW9EVW9M?=
 =?utf-8?B?WElQeHFvOXFIZzh0TzM3cnlEZmRNOXFZOTBhclYxN3pPR3ZMYjBDNnhTcVdm?=
 =?utf-8?B?NGxBYTVTeEtUSnk3WGFyK0FFRWhlK3ZMcEJvSUlBOUFhK2xlR2t5Q1pRV3ZG?=
 =?utf-8?B?SEJKS0w5TnptRXJGT2ZqdHNCWFZrQXRFN2tqdmg4TUxMRS9SUzNIZm9UWCtE?=
 =?utf-8?B?a3NaTkNQc0R0V1UxNkZvSEd4U295SU9XVVBLa0xOZWZqQW9VbnQ3M0pEb2Qz?=
 =?utf-8?B?ZjgrTGtpMjhGNkw2dDhuM29MSTRQb0VteTRNU2g2eGFFVk84MFdhZHIwNnYr?=
 =?utf-8?B?Z0d5Z1NKTW5EZFMrUFYxZzByUE1EaWsySlY4OFFDNVhCejRIQTcwMlArS3RO?=
 =?utf-8?B?Z21SbGcwVDhPMUtBS0EveHJYUGcrOUZJdElyL0l3bzZGNFRuY0xxc2x2N1Y5?=
 =?utf-8?B?b1JRcEhDOXNGM3d6cU1qV0FnMkhYNm9ZMlorSkdxL2x0Vm10d25WYzRON00y?=
 =?utf-8?Q?LPr2XD+9T35cKkeK6iwNLjM7qA/tklvY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH3PPFE6F9E2E1D.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXNnOTg2ZlJzQVdabVd4U0ViZnROVVNPTVBIS1VLekpIOXdYRzFDWjZaSHQ3?=
 =?utf-8?B?ZDYyRlhDb2plK0FUQmhwaTdkNjBhNHl4RksyeVhMRmVHQS96THA2YTNwWFVi?=
 =?utf-8?B?RzJnUVJleXRYOE9ENXJjb0ZoWXhOSGZUdlRrQnU1cnlGWUt0UU9XRVVWZFdV?=
 =?utf-8?B?cERlTW0xT3JEY0VwaXViaDNHSkExYUVpbHplcG9GeGtlYzJNdWY0bWhDQ2Mv?=
 =?utf-8?B?c2I4YW9QQUcxV1liSEJvazd3dDdRZlB4S3orajVBbnNKUjlScjZjL1pkaStn?=
 =?utf-8?B?ZWhXQXRyRWR2emNGNDhhb1QwU0gyczhNejFGNm9QQ1VRM3hSR2l0WWJKdldx?=
 =?utf-8?B?MG90aFFyTVA4blpMQWtiWmdpSE4vdG14RjRPeHBhK21MMU5ROTZiZlM2cTFu?=
 =?utf-8?B?RHQ0VVlWS2J2Zm5kcC94bm9halFuYWZKelo2R2tKWWsrNXlOQVZ1UXpaK1Vl?=
 =?utf-8?B?aG9JbXU4QTI1ai9Vdi9MaDdRVmZJTTc1M0hFbURqMnkzbm1pR0Jld1h3TEF0?=
 =?utf-8?B?L2VyeDNiN0Y5SlVENHRtUm5KTEFEQW5OSitCZEsyOWRwZVNjQnAwb01TZHhs?=
 =?utf-8?B?MU0wMGRDYkRjRGl2MFJPWnZYVXI1NktpYW9TNkk0Z1M5RzhGRkw1KzFGWkls?=
 =?utf-8?B?TTRkR1B6UGl6MmRZT0lvYnYreFBkNWxCRW1kQXlPMXlsR3JwVFlNcWNCWFR1?=
 =?utf-8?B?aHBXUGJMWDRKdENMQ05BNi9Semg4MWZQTVM3QzJBQWFQdzduYktCUXB1M2Fl?=
 =?utf-8?B?bW55NHJSbXJOWjg4LzBjV1g1WmdrbG00VXg5czZwR0NYMW5mL2E2aXhZQUxE?=
 =?utf-8?B?aXdlQzgxUWhSWWNXcjhXN2RNQ1M4ZWF4cnJvWlZuUzU1TGJrSWlLcE9GMm92?=
 =?utf-8?B?ZjZneHpMV3lGbmlqVm5kY1hWcm9RZUZOZkZNckNCSFIxRGRNU1d3OUExVVlY?=
 =?utf-8?B?RDhUODZxUWRXUG80S051VGdmRVd0R0pxSHVLemwvaGhoazJXMFlTZFNTTzhh?=
 =?utf-8?B?NGJmNXpQSGozZjBtMlVGSXliV2NZWmt5ZzVHOUU5cHEyb2NsODU1Tk5SRklG?=
 =?utf-8?B?SXk2UDdoTnN1MTNwazV6T2ZLNmZMdDJTK2ZzVWpoa2VuZjJOdkozeFpyL3lC?=
 =?utf-8?B?S2t3YlFMa1hMNENNVCsrWkRQR05rb3NQY05pd24zKzVNbm8vY2ZXWFRjalJo?=
 =?utf-8?B?RVRDTTBWMzhOOTl2V0JVNWt3dVkxc0RWQ0RzdnFXT2R3a3pBVlBCME83dWJE?=
 =?utf-8?B?WkFWeDVTa29Wa29Xb2hoa0gzWkpGTUtIUXcwSFEvTzd2YTE5WnVYTUdBRXly?=
 =?utf-8?B?V29nM3N1WHhoZElDK01yb08zVy9CVXJ4Z0MvU091c01JOS9WbnNiMU1NckN2?=
 =?utf-8?B?bnNWWFFpZ1ZhRS9rUDBzL0lVelk5SVpFS2lSanVuNUFFbTBIeDd1RGl0SGk2?=
 =?utf-8?B?Y3BBUTFNOENvNy9hTjZ1bytwY0FuQndHWUp4M3h0WFk2TGFLekRiaWtUaTBR?=
 =?utf-8?B?b0o1OHlXR1V1VkhNQ2xiMDRqTE5ENVg3cGl6aTlXaEFwaXpHWk1FbllqWUVv?=
 =?utf-8?B?SHV2V1B0Um16SU5QUFVaRkh2bHVJZm1XVkVzK1FscjF5ZnRKemhNL1dvcFQ5?=
 =?utf-8?B?YnVOWi83KytaRkViVEhwRktsUlYvVDlCdkV5dE9UcHNMQkNYck16OXhraWdH?=
 =?utf-8?B?Z3ZXaCtUL1pLWlNYbUVHOWk3SmpRcW1SbEw2RGdLNTRBVDdyNER4S3FrK2N5?=
 =?utf-8?B?T3VKdXZqY1BnWTNOS1MycnI1ZnhJK2tvRWVQVTZmeUtQK3h5TmNxNjJkSzZM?=
 =?utf-8?B?eGpQVHEwMTJkQkxFVzc0UHFQVHIxS3NkYU5CWjRmRVpaRnJDci8vbVI3bE1M?=
 =?utf-8?B?WjA4dGdrMnEyNU1RUTZHSExtRnA5ZVQrWm5tMTFDeFBhazQzeXVESW40NzVD?=
 =?utf-8?B?U0dMaFp5RzFBMFBabnZUdnRTZno1ZmFzUkRBREVrQnB6b2syaWJ0U1Uwc2tq?=
 =?utf-8?B?ekVqWDFaOUwrVjdOV1NhNWJ5cm1TdjRPYmRSSzZRK3g4T2xxbzZrdlNKQTJ3?=
 =?utf-8?B?V1FNcnl4UlpvUktiQUoweWlOM3d6eGRvYjRPb05PME1OaXNibSswcDJmUm90?=
 =?utf-8?B?V3B6TWx2cy9lVXVaWS9yTEdoLy8xTVJPRjh5U1ZuM3BPdEg0TW5TS01MVHRy?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8nEVCVNWYdO8Yv8kuU/47+wzKdyrmUOSHwKQYa14Fg5a4dXys3VFZqUXcQXmhykYmN+LefNm7c78q4QN6D5S61DHU7Yl/jR8sJlAuKrdCNqhlcdoJJp24HXB4c7E6c6Da79DKE0TIGAFuWlrJvFQj47saooMuvZnw5Dq7N+d2naKh6StxQdzuc1sQqg/tRaSHpixwwX9/MahmH9qwGuxKocrUqZYgh2OSvU9Lgpqzh2mtIB6+02BMJw2c6ddwVZCdsnuXXnbzwkCDmUJzj7xRBRdW7FSe95A+8cqpgfs8KfTDIfZbihbkCV50rMkZeKKyTkjnIFAh943cZN081v+4jZ8G6JM+SmHeSm6E4nCqQwSrKpjvQQjilRZkYhOp2umHB4OCyNZkGcHY5twkC95RWcl1JQkSNfkAQd3t17K2CigtP9tHEsaLuiLsJijOJp7oSqJdz4zoEnGTd+kl1SBc2WpOsGQ+FzbuHg/czWWRV8sEvhK/3saQi698JrZ8ADwCNre+ShHj0gAx3OF6HAIifX7PYkCsxjhnxPspInr3SxWL/3fJ24kx5gB+hfdkl2/sOD/w5qpRUL721tH+8rJWRs0sZ8ht/nmgppTYU532l0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d3ca91-cc99-45c3-94e4-08ddfa82019b
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFE6F9E2E1D.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 09:17:23.8203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hCTLG98taiyzv4k/y7G2qVRHcZau48bzfJnfZKcc62hJGrjg1Xis8Xh5vABgs7JZ5O0tpZPXI0nzUl6ufmC3BgLLm3jvSYMM7k0aHG0uLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7126
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509230085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8FcaCvdVpYcO
 iCQrjXZQkSBYerFukpyDmAqeO8zQVUG+ZwO63nT4u3RKhDlcHAr/ZlxmlRi0U0NTJeCo+q/QTKx
 THyHX+5Of4NEOSgpNDTvdhmeCAEwR8+Wiqu8rNhKJfFY6Itih6yvXBj1OJ32xIRST5ZBw0rOvAV
 x3OWdNSgbuwt/Q20W6IHUQZXrKwuVzp3DyigFLrGJmHfDM7ntByipCsysLjhrPScYXEN3fQe66P
 3cpx6ioi2lfSa2RaKVtuzSTEnJuH0367xKynlBcv5u9WMxHf5Sv+vNCo06wjzEb2c7MhAWv027i
 0x9ongGTqSaPcU0ZbtWBKQU1c50gf08bEG0D/N3yeeKu/BN0eF7A2J3XYLONv4E47hm50eB8euB
 e/QRL2azwOfotzvGF6hwb8m3DakxoQ==
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d265a8 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=yPCof4ZbAAAA:8
 a=QyXUC8HyAAAA:8 a=fl7acEF7TXr1czi7wEgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13614
X-Proofpoint-GUID: Ymxa1U_8XW-R8Bqd6Lff_apadnXTWnyS
X-Proofpoint-ORIG-GUID: Ymxa1U_8XW-R8Bqd6Lff_apadnXTWnyS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 23/09/2025 03:50, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>
>> On 22/09/2025 17:06, Joao Martins wrote:
>>> On 22/09/2025 17:02, Cédric Le Goater wrote:
>>>> On 9/22/25 07:49, Duan, Zhenzhong wrote:
>>>>> Hi Joao,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>>>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>>>>>
>>>>>> On 10/09/2025 03:36, Zhenzhong Duan wrote:
>>>>>>> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the
>> last
>>>>>> dirty
>>>>>>> bitmap query right before unmap, no PTEs flushes. This accelerates the
>>>>>>> query without issue because unmap will tear down the mapping
>> anyway.
>>>>>>>
>>>>>>> Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
>>>>>>> be used for the flags of iommufd dirty tracking. Currently it is
>>>>>>> set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0
>> based on
>>>>>>> the scenario.
>>>>>>>
>>>>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>>>>> ---
>>>>>>>   hw/vfio/vfio-iommufd.h   | 1 +
>>>>>>>   include/system/iommufd.h | 2 +-
>>>>>>>   backends/iommufd.c       | 5 +++--
>>>>>>>   hw/vfio/iommufd.c        | 6 +++++-
>>>>>>>   backends/trace-events    | 2 +-
>>>>>>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>>>>>>> index 07ea0f4304..e0af241c75 100644
>>>>>>> --- a/hw/vfio/vfio-iommufd.h
>>>>>>> +++ b/hw/vfio/vfio-iommufd.h
>>>>>>> @@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
>>>>>>>       VFIOContainerBase bcontainer;
>>>>>>>       IOMMUFDBackend *be;
>>>>>>>       uint32_t ioas_id;
>>>>>>> +    uint64_t dirty_tracking_flags;
>>>>>>>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>>>>   } VFIOIOMMUFDContainer;
>>>>>>>
>>>>>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>>>>>> index c9c72ffc45..63898e7b0d 100644
>>>>>>> --- a/include/system/iommufd.h
>>>>>>> +++ b/include/system/iommufd.h
>>>>>>> @@ -64,7 +64,7 @@ bool
>>>>>> iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t
>>>>>> hwpt_id,
>>>>>>>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>>> uint32_t hwpt_id,
>>>>>>>                                         uint64_t
>> iova, ram_addr_t
>>>>>> size,
>>>>>>>                                         uint64_t
>> page_size,
>>>>>> uint64_t *data,
>>>>>>> -                                      Error
>> **errp);
>>>>>>> +                                      uint64_t
>> flags, Error
>>>>>> **errp);
>>>>>>>   bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be,
>>>>>> uint32_t id,
>>>>>>>                                         uint32_t
>> data_type,
>>>>>> uint32_t entry_len,
>>>>>>>                                         uint32_t
>> *entry_num, void
>>>>>> *data,
>>>>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>>>>> index 2a33c7ab0b..3c4f6157e2 100644
>>>>>>> --- a/backends/iommufd.c
>>>>>>> +++ b/backends/iommufd.c
>>>>>>> @@ -361,7 +361,7 @@ bool
>>>>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>>>>                                         uint32_t
>> hwpt_id,
>>>>>>>                                         uint64_t
>> iova, ram_addr_t
>>>>>> size,
>>>>>>>                                         uint64_t
>> page_size,
>>>>>> uint64_t *data,
>>>>>>> -                                      Error **errp)
>>>>>>> +                                      uint64_t
>> flags, Error **errp)
>>>>>>>   {
>>>>>>>       int ret;
>>>>>>>       struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
>>>>>>> @@ -371,11 +371,12 @@ bool
>>>>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>>>>           .length = size,
>>>>>>>           .page_size = page_size,
>>>>>>>           .data = (uintptr_t)data,
>>>>>>> +        .flags = flags,
>>>>>>>       };
>>>>>>>
>>>>>>>       ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP,
>>>>>> &get_dirty_bitmap);
>>>>>>>       trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id,
>> iova,
>>>>>> size,
>>>>>>>
>> -                                           page_size,
>> ret ? errno :
>>>>>> 0);
>>>>>>> +                                           flags,
>> page_size, ret ?
>>>>>> errno : 0);
>>>>>>>       if (ret) {
>>>>>>>           error_setg_errno(errp, errno,
>>>>>>>                            "IOMMU_HWPT_GET_DIRTY_
>> BITMAP
>>>>>> (iova: 0x%"HWADDR_PRIx
>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>> index 0057488ce9..c897aa6b17 100644
>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>> @@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const
>>>>>> VFIOContainerBase *bcontainer,
>>>>>>>                                     hwaddr iova,
>> ram_addr_t size,
>>>>>>>                                     IOMMUTLBEntr
>> y *iotlb)
>>>>>>>   {
>>>>>>> -    const VFIOIOMMUFDContainer *container =
>>>>>>> +    VFIOIOMMUFDContainer *container =
>>>>>>>           container_of(bcontainer, VFIOIOMMUFDContainer,
>>>>>> bcontainer);
>>>>>>>       bool need_dirty_sync = false;
>>>>>>>       Error *local_err = NULL;
>>>>>>> @@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const
>>>>>> VFIOContainerBase *bcontainer,
>>>>>>>       if (iotlb &&
>> vfio_container_dirty_tracking_is_started(bcontainer)) {
>>>>>>>           if
>>>>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>>>>               bcontainer->dirty_pages_supported) {
>>>>>>> +            container->dirty_tracking_flags =
>>>>>>> +
>>>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
>>>>>>>               ret =
>> vfio_container_query_dirty_bitmap(bcontainer, iova,
>>>>>> size,
>>>>>>>
>>>>>> iotlb->translated_addr,
>>>>>>>
>>>>>> &local_err);
>>>>>>> +            container->dirty_tracking_flags = 0;
>>>>>>
>>>>>> Why not changing vfio_container_query_dirty_bitmap to pass a flags
>> too, like
>>>>>> the
>>>>>> original patches? This is a little unnecssary odd style to pass a flag via
>>>>>> container structure rather and then clearing.
>>>>>
>>>>> Just want to be simpler, original patch introduced a new parameter to
>> almost all
>>>>> variants of *_query_dirty_bitmap() while the flags parameter is only used
>> by
>>>>> IOMMUFD backend when doing unmap_bitmap. Currently we already
>> have three
>>>>> backends, legacy VFIO, IOMMUFD and VFIO-user, only IOMMUFD need
>> the flag.
>>>>>
>>>>> I take container->dirty_tracking_flags as a notification mechanism, so set
>> it
>>>>> before
>>>>> vfio_container_query_dirty_bitmap() and clear it thereafter. Maybe
>> clearing it in
>>>>> iommufd_query_dirty_bitmap() is easier to be acceptable?
>>>>>
>>>>>>
>>>>>> Part of the reason the original series had a VFIO_GET_DIRTY_NO_FLUSH
>> for
>>>>>> generic
>>>>>> container abstraction was to not mix IOMMUFD UAPI specifics into base
>>>>>> container
>>>>>> API. Then in getting a VFIO_GET_DIRTY_NO_FLUSH, then type1 backend
>>>>>> could just
>>>>>> ignore the flag, while IOMMUFD translates it to
>>>>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
>>>>>
>>>>> I did port original patch https://github.com/yiliu1765/qemu/
>>>>> commit/99f83595d79d2e4170c9e456cf1a7b9521bd4f80
>>>>> But it looks complex to have 'flags' parameter everywhere.
>>>> I think I would prefer like Joao to avoid caching information if possible
>>>> but I haven't check closely the mess it would introduce in the code. Let
>>>> me check.
>>>>
>>>
>>> My recollection was that it wasn't that much churn added as this series is
>>> already doing the most of the churn. But I am checking how the code would
>> look
>>> like to properly respond to his suggestion on why he changing it towards
>>> structuref field.
>>
>> The churn should be similar to this patch:
>>
>> https://github.com/jpemartins/qemu/commit/5e1f11075299a5fa9564a26788
>> dc9cc1717e297c
>>
>> It's mostly an interface parameter addition of flags.
> 
> Yes, it's a general interface parameter but it's only used by IOMMUFD.
> That's my only argument.
> 

You could use that argument for anything that's not common and unique to each
backend. type1 dirty tracking is effectively "frozen" in UAPI (IIRC) so I won't
expect flags. There's device dirty tracking, IOMMUFD dirty tracking and
vfio-user dirty tracking. While I am not anticipating any new thing here (at
least in the needs I have ahead, can't speak for other companies/contributors);
but you could see the flags as future proofing it.

The ugly part of the alternative is that it sort of limits the interface  to be
single-user only as nobody call into IOMMUFD with the dirty_tracking_flags if
it's called concurrently for some other purpose than unmap. We sort of use the
container data structure as a argument storage for a single call as opposed to
store some intermediary state.

I mean I agree with you that there's churn, but it's essentially a argument
change that's only churn-y because there's 3 users.

>> But there's now a few more callsites and I suppose that's the extra churn. But
>> I don't think
>> vfio-user would need to change. See snip below.
> 
> vfio-user need same change as vfio-legacy though they don't use 'flags' parameter,
> or else there is build error:
> 
> ../hw/vfio-user/container.c:340:30: error: assignment to ‘int (*)(const VFIOContainerBase *, VFIOBitmap *, hwaddr,  hwaddr,  uint64_t,  Error **)’ {aka ‘int (*)(const VFIOContainerBase *, VFIOBitmap *, long unsigned int,  long unsigned int,  long unsigned int,  Error **)’} from incompatible pointer type ‘int (*)(const VFIOContainerBase *, VFIOBitmap *, hwaddr,  hwaddr,  Error **)’ {aka ‘int (*)(const VFIOContainerBase *, VFIOBitmap *, long unsigned int,  long unsigned int,  Error **)’} [-Werror=incompatible-pointer-types]
>   340 |     vioc->query_dirty_bitmap = vfio_user_query_dirty_bitmap;
> 

yes -- I didn't have VFIO_USER compiled in probably why I didn't notice it.

>>
>> I've pushed this here
>> https://github.com/jpemartins/qemu/commits/relax-viommu-lm but showing
>> the
>> series wide changes for discussion. The thing I didn't do was have an
>> intermediate 'backend
>> agnostic' flag thingie like the original one
>> (https://github.com/jpemartins/qemu/commit/1ef8abc896ae69be8896a6870
>> 5fe4a87204709e0) with
>> VFIO_GET_DIRTY_NO_FLUSH
>>

Instead of a flags, an alternative would be to have a 'bool unmap' which then
IOMMUFD can translate to IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR.

That's a bit cleaner as to avoid leaking backend UAPIs into the API but it
limits to 'unmap' case.

>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 56304978e1e8..2fe08e010405 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -211,17 +211,16 @@ static int
>> vfio_device_dma_logging_report(VFIODevice *vbasedev, hwaddr iova,
>> }
>>
>> static int vfio_container_iommu_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer,
>> -                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>> **errp)
>> +                   VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
>> uint64_t flags, Error **errp)
>> {
>>     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>
>>     g_assert(vioc->query_dirty_bitmap);
>> -    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size,
>> -                                               errp);
>> +    return vioc->query_dirty_bitmap(bcontainer, vbmap, iova, size, flags,
>> errp);
>> }
>>
>> static int vfio_container_devices_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer,
>> -                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size, Error
>> **errp)
>> +                 VFIOBitmap *vbmap, hwaddr iova, hwaddr size,
>> uint64_t flags, Error **errp)
> 
> I think we can drop 'flags' here as you did in your old patch?
> 

Yeah

>> {
>>     VFIODevice *vbasedev;
>>     int ret;
>> @@ -243,7 +242,7 @@ static int
>> vfio_container_devices_query_dirty_bitmap(const VFIOContainerBase *bc
>> }
>>
>> int vfio_container_query_dirty_bitmap(const VFIOContainerBase
>> *bcontainer, uint64_t iova,
>> -                          uint64_t size, ram_addr_t ram_addr, Error
>> **errp)
>> +                          uint64_t size, uint64_t flags, ram_addr_t
>> ram_addr, Error **errp)
>> {
>>     bool all_device_dirty_tracking =
>>         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
>> @@ -267,10 +266,10 @@ int vfio_container_query_dirty_bitmap(const
>> VFIOContainerBase *bcontainer, uint6
>>
>>     if (all_device_dirty_tracking) {
>>         ret = vfio_container_devices_query_dirty_bitmap(bcontainer,
>> &vbmap, iova, size,
>> -                                                        errp);
>> +                                                        flags,
>> errp);
> 
> Same here.

/me nods

