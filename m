Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA81C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3yN-0004mM-ON; Wed, 17 Jul 2024 08:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU3yJ-0004lW-EF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:41:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sU3yH-0007Tm-HC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:41:27 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HCf3lH017995;
 Wed, 17 Jul 2024 12:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=h1c+7gU3qyMRHAHdzWXF2mg/UGgRH0y2q9QkTe657z8=; b=
 h0QCBe/L3dV5rWfQ+bouqJgLBFUZU029nXHlN8b89Hd515Gqd/eXSrDKWtTSuapW
 f+tCRL4j18k23gondzrePHpxGCK4dINm67YnpyTkasbaO0IOiHzRlimOMdibkA0p
 bif05gHOabptDovRYxCh1Xj7Gud7AAe8Y+sFyYF8s/gvH0xms1yWmotkQkT0nnY6
 3t9PBWo1pNMT1XW9Io0NtWYJLfNwPsLa3Am6LS4c32T2HCQ15Q0skUL6lAiJI9CA
 p6wWIbWzy+7awTmbFMNq+8UOwNW6nPJ6lr685lYxFTeOfK6ITvVQxnMWZCBzoQKN
 PyC51GSj+D8B0Avr/apRdg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40ee5q000u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 12:41:21 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46HBsjIC006940; Wed, 17 Jul 2024 12:41:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwexgv4r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2024 12:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0FmPEpJ+bGlbwrQkgVxGYbebDA2MKMjiq57SfV8/BEP9Hst+LioJoLSFPvNJcwE2JnOeAzTDZdJ5HU9B7OeybmTxyHqJTBsAHLKDCPOPMF6MAsJEzA5QQhI/HFHSIRD6ZQmFJHPhJCGauRTR0UISC9bSTOzon/I/+Y7NGn1a4v+Yyh4Nt7GW0eOQa2nowkJmXDVsSwNR2fNcgbW/gCxD+/stZX1wf8qtj/M8wkYC3BB3xfQSDTV2lXOnoJO3MHTEdhWibUZSuu5vz7S9EUjUol9KNcgnEoOZdzaE0R+TPuKDRj2MFnx8/txpW/SbDGVQLTCUWt5H0X2NG8Qk4T6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1c+7gU3qyMRHAHdzWXF2mg/UGgRH0y2q9QkTe657z8=;
 b=OgFqJCZVX+5DQDvE705AgTOtF77+jBff9skLAGdsBs/oP88wk2k1LqXi7L8VFLplnE89UTzz7Y1T2Hg4PXXqRx6l49pqsJA4SD1n+FaIT0rfC+Kct7CUja5pqpmDr1sCs2ZJ2pKOvnOk35YRv1EZwE1hJnFSYy/GwkXztYeEtWL4SfRPybZLbJSsoRFB6v+SWvb/FXofX+jPVbbi0tI1G19Mxq15hPI1UZOFcaCNBNoesrnU9OAiAOYvht0pywA5Xow2wHLqdh9/1CiXo7kCa7LreSpNIdMjjcvzgwlhsuMZoi+L9iTT0Qqx4/AshOqwS6TlGI64LbbRmQZUh+cb2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1c+7gU3qyMRHAHdzWXF2mg/UGgRH0y2q9QkTe657z8=;
 b=Mg1O/VaCutUkfHHQF4gmDA/b58RZUU20M0H7v4KwA6BBtb5TroqId+WXdxwPpVxoNKJcllRaCjGBRlMbvOf8xH02EE/2o0LexE3ojpwWUJO6chHY+UiOypt/grPn+fL0xHZF2fRhS9JRWAcaBPqZT2693ZqvkjSRahfT+8y/LKs=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CH3PR10MB7493.namprd10.prod.outlook.com (2603:10b6:610:15d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Wed, 17 Jul
 2024 12:41:18 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Wed, 17 Jul 2024
 12:41:18 +0000
Message-ID: <bff9d18b-1286-414c-ad47-6898b55ae9dd@oracle.com>
Date: Wed, 17 Jul 2024 13:41:12 +0100
Subject: Re: [PATCH v4 09/12] vfio/iommufd: Implement
 VFIOIOMMUClass::set_dirty_tracking support
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-10-joao.m.martins@oracle.com>
 <bcac1f67-95de-41fb-ae34-9c479db29969@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <bcac1f67-95de-41fb-ae34-9c479db29969@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CH3PR10MB7493:EE_
X-MS-Office365-Filtering-Correlation-Id: d00280a2-a360-4480-c90e-08dca65dc11c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aW5qK1BMMFdINDlOL2YrekI0aTQyMlFSTEk4WXQ2SWsrYms2OXgzV3ZnWjlN?=
 =?utf-8?B?Si9pUy94TGMyb3p1TExTaENMa1pwaEl2TkxKOC9uUjB0TjQzREQzZ0hDTktU?=
 =?utf-8?B?UDZ2R01YVndEeHFWdkNQd0dDTXlWc2txenNUOTYzdFhWUXN2WS9NM3piTEtq?=
 =?utf-8?B?bytlai9vbjhsWlNydDdzZmI4UnFxVmhwZTB3TkNRbTJSQ01uVndiNVVhYUhk?=
 =?utf-8?B?cVBEWGZ2RGV6aHJwV0ttQ2E2cUQ0Unl2STAzL0c5b2dQRkpQdjlUcmVKbFJC?=
 =?utf-8?B?U0FwSUhKdndYOHc0WURieWZXVEc0Y0xpKzFDSUZmSTZLSHFoYXVHazdJRE9m?=
 =?utf-8?B?YlUvSzl4clRST2piRmdJM1F2Y3Z5QUF0WDdPaDUvZFh5WmNxYk1iR3g3aThZ?=
 =?utf-8?B?bndGRFZRdWV6eTB1NkMxY3ZsVTlWd01hNG9IT1VsRHNyRVNkRGFla3dUcXEy?=
 =?utf-8?B?ZWQ4a1FJc0pNcVdSbTNWMXMvMWtJajNPdDFNTkpWNW41b3RpdHpibFBEcUZy?=
 =?utf-8?B?S2k3bXdWRjkwbmZVdjdVVWtLVFZMRjRXOWg0U2ZsM0dybkRNS25jNkVwNTVu?=
 =?utf-8?B?bk1LbmFpK1FsVlhNVFBuWDRTTGZ3Tll2Z0l6Y29IeTBFN1VpdDdVS2lBVEMz?=
 =?utf-8?B?M0J0SFVveGNWY01kQ2x5bzVFQ2hBMHI0am1QSFNDY1hNSTZmSkFJdjlDU3Rj?=
 =?utf-8?B?VDdQdDZtS3VKdnllOXZ1cXU1YUFwZ3hYVDhuakpPY3hUbFdJVC81dlFEOXpM?=
 =?utf-8?B?V3MrMUFGNThydzRSektKYzlCSWw0VXRuckZGcmFNNlpnajBRUXhYTlM5OXFm?=
 =?utf-8?B?dncrc2dET0tFaGtCWjg5K1BPbWVLVG5mQmp3Q2xkL3drNER4YzZ5SnBwc09K?=
 =?utf-8?B?RndJemFjeFBSV2lXekh4MXpGMmRLejljV1RGU2hnWitXMW5aMDZEcUFpdk9u?=
 =?utf-8?B?bkJoVkNBcnNMNHVLZUxzaDVrVGg4Rm42RUFxcEY5a09rMVIzODVtZGdBWEp3?=
 =?utf-8?B?SjdueWNIMjNTZmdVNDBkalhxMzQzU2RsZFNOT2pYMnZTNWVvdGpETWZKMzg3?=
 =?utf-8?B?TTRpcGdmcWNhRFNLZEc3OUE0UDFpUkt3QjRGbER2WU9yVGJyNFRBYW8zQjZW?=
 =?utf-8?B?M0Q5dWl1QUU3WmFWRUE2dEExVXlidTFxRkFTTkdBcUo0eGdqNnVNVU1MV216?=
 =?utf-8?B?L2NTM0I3K1o4bk1WbzZGUjFzRjVBbFhaN3BKK3FOZkRUQnMyamxEOUZwaGUr?=
 =?utf-8?B?Z3ZnUEszSkxWd3hNYWtyYU1MQ3ZkYU1jL3NENURpRUdwOWhCS0gwWXVBT0RB?=
 =?utf-8?B?S2FKbnczV2NTQWR1T2dRTGpkVFFHUWNHMWVVNlJlNTlodFM4VHl1cisyTzVp?=
 =?utf-8?B?Wm1Hd0tKQkdmQzVMNVU4ZEFZVXpub2JjbnBqV0trWXRvaml2aGxtbVNUamhz?=
 =?utf-8?B?dm9yTDh4cEdjYjY0YlNTRmR3UWVieUZ0TVVTY2ZyTGNWVXpEd2dwNmFiZXRB?=
 =?utf-8?B?Nm5YVWV4SFdQNkFXbCtBRlRnTGtvTmJMc2I5YzhWK1RMTGY1K002MU5IK1RY?=
 =?utf-8?B?amFmRjRIdWNxUit2K0QyTlpkWWJicmYvWW5mS1E5ZGFQRkcvaE5yU0lpTXIw?=
 =?utf-8?B?TUM2NFlvVmh0YkxEL251ZUdHSG81MWVWSmpndmttTW0vL2szY1NaRjR4OUlk?=
 =?utf-8?B?Y0lEamZURGw3VjBqZnhzQm5oSzRiSUdKanFDZ2JwNlAvK2F6K2hIeVQrT1pL?=
 =?utf-8?B?eGFiUmNpMUxDVXlPRjhZZUdMSlEzVG1FZFcvbzBWd1p0MW5IYTYvQy9NNGhN?=
 =?utf-8?B?Tm8yejYvWldFVmZLTmk1UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VDMWQybko0dE9WdGpOZFp1RzRDYUdJdnVDdFhvZ29PN3hlSktRYkxCNTZj?=
 =?utf-8?B?RE5QQlJKSDc3cktQeXBlZjBSUnBwRHdJRGJLQnVYclhjZGIwZEw5ZXZZWlZo?=
 =?utf-8?B?aG1hU3ZWVThsNWFJbXRuWE0rMGF0ZHByTU9OK0dxQVQ4WEpOdjZNSkc0aFVo?=
 =?utf-8?B?NGtwTDRLTlJZT2x0aHBFMmp0aXM0dXdFelJJSUFNSysweE85WDJPRnIyZkZk?=
 =?utf-8?B?emJQeGxIK2NmczFGaEJvWHJyOVZVTnI4MFhzWWNtb0ZHOElSZGdTSnovN3FR?=
 =?utf-8?B?elZtVTBRZk5JV1poV2RrVGNNTzh4VXlJajRCOTZ6aWtYb01PWFBsZ2xOVWVh?=
 =?utf-8?B?RnNNZ3VtdSs0UEVFWmlUUk5iV2VDMnVJOFhGK0JORUFOeFI4SFp4aWpodEJy?=
 =?utf-8?B?RXZpL3Z5WFdWWFp2Z2R0NTZuY2VIOVQ3Z01ReG9ibHdkaklGeFlQZGE4elVk?=
 =?utf-8?B?NDlIZEJFdDA1c0RHRXpDV1YxVXdlY2s3U2JJNlh3RDNJU1NRclo1aWl0aG5G?=
 =?utf-8?B?U3V2QWdRdWQyRHVUSnhnZVU2WG0wd0JwYWVGOVUxL08xajZSZFZmaXlTYXVH?=
 =?utf-8?B?Y2xLSkkreEhZOXVsWmRpZEdtYUZyQzVQOGlnZGU1cE1neTFGV0h4UEI5c0U0?=
 =?utf-8?B?Y0pwaEtrYmZ4YVluV2xSdmJ5VVZmM3NsVW40OERDcU90NjF0T1FEUDloeThy?=
 =?utf-8?B?NHZueTFxaTFlWmpWODVYSTl6MkpBWXZ0a3N3TUdFYTZFMmN1SW1BeFlrQkty?=
 =?utf-8?B?UFljdy9zdTlFRnJaOVFHdDFHSi9WZmlENjhVMkRPcWdhRTJhV2Q0cjR1cUJz?=
 =?utf-8?B?QkRPK05nalFzeHFNK0s0aGdWS2hZcjViR2drTUpYdk5xelM1N2Y0YWZSNC9K?=
 =?utf-8?B?OEpzdENuOU4vZlpTQStLaGRXTnp5WUtmc3Npc3JycFNwNFVLYzlMYjI4MjVn?=
 =?utf-8?B?aXlOWEFXU2pxbGhJdmE0WWlSWkVOZVZra0RUT2xoMXBlbEpXK2xDdUwyRzJv?=
 =?utf-8?B?NUZiVU1Kdk9aeFZGc0pmb3drZUtLeEtEaUliRVVwUGUwZTNJNjZsQmRuUDJy?=
 =?utf-8?B?WnpGVUZLOUdYT1BxVE5HRWJYeTZ5U0lLZmUyc0w2SVRYM1RXcXRhNkVKcUpz?=
 =?utf-8?B?bHFBdEpQcVVkSFNJMW94YkpXT1h6bDVKWUlFaEVOYVZkSWxiNEdHY3Y0WW14?=
 =?utf-8?B?TkNPdkliTStBR3lCdVFIbVB3VGtGNG9IbHZEZkpRdFZLQmxMUGpoNUl3TFpT?=
 =?utf-8?B?K1VqaDlwRldTa1dqcHZLQ3grVEhsc0ROcjhBNnhIUkpFUHVhNWRuVEU0QnhD?=
 =?utf-8?B?TjhUZmQvUVVObGc3NUROT2hoME15dWdERTYwazhSZmIwK2ZjekR2SWZtUXhu?=
 =?utf-8?B?SVRJU1M0WmtXVDhnMEF5dDh4WmRjOG1oeGg3U01xaGlvdjdpaGRVeTZHdzNW?=
 =?utf-8?B?U1o1OWd6MjJmd0JiMmlzVzJxYVE4WXllWEowdXQyRXFGbWxWRUxnQVppalZj?=
 =?utf-8?B?QnE3dG5ETm9HQ0Nlb1NTZlVpNW1PWDd2aHdIRzN4bG03cENLNCtPemFSUGVX?=
 =?utf-8?B?Q01BM0VYVFhpZWZVYUhpL21YemV5YVI4bVRnN3ZJMzhkUEU4VUI5aU9ZTHJH?=
 =?utf-8?B?K0pmSGFWVDdNVUY4RHI1Wmh2K3VrQW81N0plMmpvNkpISnRCRnFab0o2MkVN?=
 =?utf-8?B?eDRjS2RvQ055WGJvOEVNVWJtNW5DOUFPRzdPdUJ0eHdDT0xSdFM4WUhzeVdF?=
 =?utf-8?B?RUpSL25TN2x1VnpCVEdSb3VlZmxhQ0x3QzlXSFZyeEVtZDE2TnhKL21wTHlw?=
 =?utf-8?B?dFRyZk5CRUdwL2t5eVZidmMvN1NsNEQxcTFHN3l5Z3duK1pyWTllMGRhb3Fr?=
 =?utf-8?B?TjRmRTdsMW52SW5LcHptUUlZcHpBdFVvSTdnWFRBQ29YQTl4RTNzdkd6Qmtk?=
 =?utf-8?B?dzY0U2ZSNC91dTdOL3p4eHFGLy9UV1AvV0ZKdjRDcUl1b28rVmVKdThkd1dD?=
 =?utf-8?B?QUZrUTBQdnljR3YraGVobDNlazNoRGp4M2RTQlpMNnFMMFVwNHhZRU5tc3lj?=
 =?utf-8?B?V1pFZUZxZCtsTzNseWpRdTZIRFJuY29yUEloWEFaU3lXczVjcTNBZG01N0xx?=
 =?utf-8?B?dHVhMlVNc3htT3J6NEtxanhkYjQ0TGRnQ2NGSW5idzZrc2M4WmxpMmE4b3Ay?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CPX/TjP1zBlgSOS1icozLT8AvlkkjVQkh0VAOyIUJ9Y3nsh/IS8E5eGtBm65k95bNHj7li1BQCa3spDCc4tvCGGSoslfPLEcG3YTVDOdioK9BspZ6lRBn3q2mCrm9XXfMz6ERtg5tNsTLNKn3VbWgGFpUQt90W/IK74uBxTKEOgyLOS2GNCzV+P+m5nskg7M5ZbzQCe5jU+RLXKCiznjmuFKEHkpHzgb/cMNXUqDDLnjCmIkYEEBWFiEPmK2c/+/WEkEz9QTO2qp6Cl/uh17A8kfOw1V0OQ+YYlb6aOB0XAaClGjavfPBnID8GOhYzgTfnVV9fas4sG/U1ZzUajvW8WQ1VkSle099eLy5NxNuaLMRk8u26u93cj5m9TuRMvdq1lo13DuWdmcIPRxxUYOnbwwYv4AtC3fPsGJQ5GCn4KlQkC1MpFJps3Y7pWUbJgCVE2LSHUUK+4VLudmRxmIgzRHPcPudHlmbZalhxtJtgRYHPlbh4peRkhNQqCvHYPhWpjYSGk9rhK95e3qit5Vauqs/O58igiCN3IrXQBFRxSfJ6g0GZC+JmAEXohcbnfPES/iMHt00rYISfHO+TImbxhV1inmH3NYtUIO75B6NFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00280a2-a360-4480-c90e-08dca65dc11c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 12:41:18.3797 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocU9vrTYnwS1gtYv8Z4eZ9WryYkAObCty6lfhLQM87sGueeqH/4CL0VOc5Evy5C7o+p78mvnXMpILKUr0EqRT2zJMFAhFaZkd8N+7Em2Lk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7493
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_08,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170097
X-Proofpoint-GUID: sOEBfslSfZxPsYdbUIi8wOKouCDV4bKp
X-Proofpoint-ORIG-GUID: sOEBfslSfZxPsYdbUIi8wOKouCDV4bKp
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

On 17/07/2024 13:36, Eric Auger wrote:
> 
> 
> On 7/12/24 13:47, Joao Martins wrote:
>> ioctl(iommufd, IOMMU_HWPT_SET_DIRTY_TRACKING, arg) is the UAPI that
>> enables or disables dirty page tracking. It is used if the hwpt
>> has been created with dirty tracking supported domain (stored in
>> hwpt::flags) and it is called on the whole list of iommu domains
>> it is are tracking. On failure it rolls it back.
> 
> it is are tracking ?

*it is*

> also please clearly state what is "it"
>

sure

>>
>> The checking of hwpt::flags is introduced here as a second user
> ?? -> introduce iommufd_hwpt_dirty_tracking() helper to avoid code dup?

Right I am doing that already. Not sure what the problem is with this sentence?

Or you meant to use yours as it's simpler/easier to understand.

>> and thus consolidate such check into a helper function
>> iommufd_hwpt_dirty_tracking().
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/sysemu/iommufd.h |  3 +++
>>  backends/iommufd.c       | 23 +++++++++++++++++++++++
>>  hw/vfio/iommufd.c        | 39 ++++++++++++++++++++++++++++++++++++++-
>>  backends/trace-events    |  1 +
>>  4 files changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index e917e7591d05..7416d9219703 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -55,6 +55,9 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>                                  uint32_t data_type, uint32_t data_len,
>>                                  void *data_ptr, uint32_t *out_hwpt,
>>                                  Error **errp);
>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
>> +                                        bool start, Error **errp);
>>  
>>  #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>> +
> spurious line change

ok

>>  #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 41a9dec3b2c5..239f0976e0ad 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -239,6 +239,29 @@ bool iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>>      return true;
>>  }
>>  
>> +bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be,
>> +                                        uint32_t hwpt_id, bool start,
>> +                                        Error **errp)
>> +{
>> +    int ret;
>> +    struct iommu_hwpt_set_dirty_tracking set_dirty = {
>> +            .size = sizeof(set_dirty),
>> +            .hwpt_id = hwpt_id,
>> +            .flags = !start ? 0 : IOMMU_HWPT_DIRTY_TRACKING_ENABLE,
>> +    };
>> +
>> +    ret = ioctl(be->fd, IOMMU_HWPT_SET_DIRTY_TRACKING, &set_dirty);
>> +    trace_iommufd_backend_set_dirty(be->fd, hwpt_id, start, ret ? errno : 0);
>> +    if (ret) {
>> +        error_setg_errno(errp, errno,
>> +                         "IOMMU_HWPT_SET_DIRTY_TRACKING(hwpt_id %u) failed",
>> +                         hwpt_id);
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>  bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                       uint32_t *type, void *data, uint32_t len,
>>                                       uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index edc8f97d8f3d..da678315faeb 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -110,6 +110,42 @@ static void iommufd_cdev_unbind_and_disconnect(VFIODevice *vbasedev)
>>      iommufd_backend_disconnect(vbasedev->iommufd);
>>  }
>>  
>> +static bool iommufd_hwpt_dirty_tracking(VFIOIOASHwpt *hwpt)
>> +{
>> +    return hwpt->hwpt_flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>> +}
>> +
>> +static int iommufd_set_dirty_page_tracking(const VFIOContainerBase *bcontainer,
>> +                                           bool start, Error **errp)
>> +{
>> +    const VFIOIOMMUFDContainer *container =
>> +        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> +    VFIOIOASHwpt *hwpt;
>> +
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>> +            continue;
>> +        }
>> +
>> +        if (!iommufd_backend_set_dirty_tracking(container->be,
>> +                                                hwpt->hwpt_id, start, errp)) {
>> +            goto err;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +
>> +err:
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        if (!iommufd_hwpt_dirty_tracking(hwpt)) {
>> +            continue;
>> +        }
>> +        iommufd_backend_set_dirty_tracking(container->be,
>> +                                           hwpt->hwpt_id, !start, NULL);
>> +    }
>> +    return -EINVAL;
>> +}
>> +
>>  static int iommufd_cdev_getfd(const char *sysfs_path, Error **errp)
>>  {
>>      ERRP_GUARD();
>> @@ -278,7 +314,7 @@ static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>      QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>>      QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>>      container->bcontainer.dirty_pages_supported |=
>> -                              (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING);
>> +                              iommufd_hwpt_dirty_tracking(hwpt);
>>      return true;
>>  }
>>  
>> @@ -717,6 +753,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass *klass, void *data)
>>      vioc->attach_device = iommufd_cdev_attach;
>>      vioc->detach_device = iommufd_cdev_detach;
>>      vioc->pci_hot_reset = iommufd_cdev_pci_hot_reset;
>> +    vioc->set_dirty_page_tracking = iommufd_set_dirty_page_tracking;
>>  };
>>  
>>  static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 4d8ac02fe7d6..28aca3b859d4 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -16,3 +16,4 @@ iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t si
>>  iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>>  iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>  iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
>> +iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
> 


