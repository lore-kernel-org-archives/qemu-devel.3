Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD025C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR6qz-0001TK-RT; Tue, 09 Jul 2024 05:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6qv-0001Sn-NK
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:09:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sR6qs-0008N4-BV
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 05:09:36 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tTDB007086;
 Tue, 9 Jul 2024 09:09:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=/NRNHtJHql/siMe3v/bifIkK5oUXXRctyBCJRrAoOng=; b=
 kl0MDJQlaqAJt3XNR+/VtdCzZurU3/YqOVs/Gqd3BSGfGLXPX6nsGLnhAOxMb8Ec
 u/ppD8itEFORjIJwUhw/LJptyM1lpHiYhjoM+pWyejDoeosApKI7i3Hhjxh9kH9y
 ePcPmqIU/FM3yLxZbIDyXeVUU52Hfr3qdacAhu7XU1Bai30XOPmuhc1+koV1gMjc
 lDfp45JY5ffIpHLQGt4hMvAcFQPnKZk1XeiD8PrC+5+SBVDp5kwOmA7kVdXdXW5r
 FYBVEq69hMM83VZtsVfBG6TgKnW/jNTAsZ4iLBFfZ01dzV63BBQihY7MsX+4DPQp
 5EJge/E2CjoBjbX45i5b3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmh6d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:09:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 4697ZgFo013671; Tue, 9 Jul 2024 09:09:30 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 407txgnj62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 09 Jul 2024 09:09:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETyE47ErUkeB8qXswmEaMosr3gKDx29iNCTGr6dH9Lv/RUNEUoZZHu6SS5XMMEto7rNhSvjb4cqq7FcSFrLXdrdLkQuOEP78xXL+RQ9N50NBsiUCWC7GWqwlSj3yDn1VDRIMLuUf+hFOie43Ta9qcPDIg79E1fpIhxApBFJQKhjqyJuAsHgYTWrCFBkHwpMFa07XHYwlfSKUz0dDFnBAZtseNxvYNFKRhSfAZk+1lp89GY2xKcd/wVCaTrwewoDtdnnQE+SD7xIx2DeAlsrxWpbMjlFSUo0QCOdhVPCarFkACEJ5UIVJXttI7XcogEIoZn/V+VV2kOAXtddWiq4uDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NRNHtJHql/siMe3v/bifIkK5oUXXRctyBCJRrAoOng=;
 b=dbWa7RytBtJeGTAvweNKBvJVOv1nC2UDssLy56hjSGFm+bVAvgURS8G0YikIiHAVNgQKfYrhiv1ap/iW64z0bMGkLVhLTpUlqL16kAZVTpy/ij8Donv1Rx8bP/LiZMqgYzgae4LxC2v/Ec9czXpmUpMkAGfAXHvFmD1diLHNaMp5MzriVT6b77DbqMMJ+WVRQYgNRzwn6fAEjuQ+IpkEbySRkTQPq5i3dSm836SJ+22wlfoAZDvM59OEVrPqQWd7/r1+/XllfqsYXlpLrCeU5aLrRDG4ME4uOeryOUyxhd+2EYiUWuNx4prZbCRhVAW8hq19jA48PARTC8bmzkI2HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NRNHtJHql/siMe3v/bifIkK5oUXXRctyBCJRrAoOng=;
 b=lzxOMw5Oe9oukPUMOPW+yge4VZZCUrztc0oByt7r6Jaffq2HtKkCNgoetVB3Q9brE/LB4YriKkr/1eh6s8qr9j+sWOyqEze5bTP9qsBB+LWvJBMcM9Wy9Eh0nZFoucAD3s02liZWCdydmhgsS1bR5zVtKU0qX8xfMiPutFisvjQ=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ0PR10MB5891.namprd10.prod.outlook.com (2603:10b6:a03:425::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Tue, 9 Jul
 2024 09:09:28 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:09:28 +0000
Message-ID: <82a8623d-2dfe-449d-9218-c64790af2f90@oracle.com>
Date: Tue, 9 Jul 2024 10:09:15 +0100
Subject: Re: [PATCH v3 04/10] vfio/iommufd: Introduce auto domain creation
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-5-joao.m.martins@oracle.com>
 <6b5f84b5-134c-4507-84aa-5086f20f6eaa@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <6b5f84b5-134c-4507-84aa-5086f20f6eaa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0029.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::16) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ0PR10MB5891:EE_
X-MS-Office365-Filtering-Correlation-Id: 730ea485-1acc-4bb7-f25f-08dc9ff6d605
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MWJKUCthczRrN3E2N2hsSHM2TXRqMXY0cnV3SUVmN0dPSzVFRlhDdFZXcjhz?=
 =?utf-8?B?MjdqY25ldCtCYWEweDJjUkljaG81bTc5MTFpNU9tK0FYc3NhektWbUU5ZlNo?=
 =?utf-8?B?MlNlN2RwOUhDWFFBTHhzcndvZHNzN1huN0wzNThpNXg2ZmppQ0w2YTlweDRK?=
 =?utf-8?B?MmV5MW9xYXgxL3d5Wmh0NHY5UEdJQzJSTVBSS1FZRG15VnhXRXBPcWsyYzdO?=
 =?utf-8?B?L1BVM0FmZEdRRFkzVlNTRFdJdGQwUGFrcG16TzNVNGZObFZlODdKdWZGaVlt?=
 =?utf-8?B?S0tLNDFkUkFwNmxjdW1SbHloOGQ1RW9NTUJweGl5WlhtVWVUUGNrb1h1MlQx?=
 =?utf-8?B?KzczSXVMODhBbnJjenMrNFEvY3NwSnliQXVZQVlrWEIxamdNbXkrOUFsZmpI?=
 =?utf-8?B?SjVWQkp0NnRnWmY2ek4yMlRCS2N1ZmhuVmdhcjJVdnNraHZpbElrTkxkVjdY?=
 =?utf-8?B?NzByUS9DYWQweFladXh6d01KZHVWTFROMHdMN0lFRHlTMHRhM0NZY3dRNFlz?=
 =?utf-8?B?QW9Ud0UySUIzZXJFSEdDcWp2bFlxcnJ4aWZaOWVzbzlFdk11a05mdFgvWU52?=
 =?utf-8?B?OFhGT3NVOVY2cVlMNGQ5azNrdnFFWFI1RENITmVHMXN6d0ZnRW03RFlHcFRT?=
 =?utf-8?B?TmN5M1JoclJwMkNrMXNUT1Z0SlpjY01EUlhtZVFoMC92Rm5kUHUyVUJLQ012?=
 =?utf-8?B?TFk5TEJkamtnWFdvQ3hERGZMOEdwNUZXZHltYVhNMzNaTDQ0VHVtdytEN1lM?=
 =?utf-8?B?dC9mY3hZRFJBZ2sxcW9oNm1WQWpRREJJUlBwc1dYK3NERVc0SWdoemlKQVd4?=
 =?utf-8?B?bURaUGlxTlNJU2s3eTQzSktjRWIxQ0laNWNYL2RzSC9ReERWem4xWVJJUWY3?=
 =?utf-8?B?dEhkK3pBOWs2cEQvc1owT1F6WTRWZnFsTXpYVlZidDVNMjRwRWI5VmVtOVNa?=
 =?utf-8?B?WXVoZEhxTTZzTm1DYXRxL243bnp2WW1BOXlTTjdvSlpIUTlFbUI3ZEdETW41?=
 =?utf-8?B?eTUzNDFHQkFtcFl2cU4xQ3NMalNMUmR6a25yVHhUZzJTWkpyeUttdjN3QVpw?=
 =?utf-8?B?b1ZNbklPS05ydHEzdndxMWpPZ2VnRmxnWlVmQjJ0WTNMNFdqc2ZoWjY2NTlZ?=
 =?utf-8?B?d3Q2VnFZZzIwZXpaTldLZXJ2Y2xKY1RDaDBPWU1wdndQYzFXMXpKVWd4bHdu?=
 =?utf-8?B?M2RmME96dG1haGtFY1JGUzBaamhxV1I1YlRQRjkxN0hmOUdTWmJCZjhWaExG?=
 =?utf-8?B?MEpGQlZ5NFh4cHJPdzlUdzkyQlQxcVQ4MG54Znc0TmNFeUZQNE5Bem4rbC9x?=
 =?utf-8?B?UmVsWGZXU2hYb3FXWFdIZEhBNndNQ0U5VTVMd2tCR05vdmpOUERqMmZIdDVV?=
 =?utf-8?B?UElpRWFsSGVYR1VOT1ZmZ1pSWGlDVDFaQXlIV2VLUGM0OVVITXJabG5tcmxK?=
 =?utf-8?B?MHZEcWo4bUwrNzJZS2xiWHJ2Tll1ZjJKRjNrSGF0L1JqbFIrdk9EcEJFK2ZO?=
 =?utf-8?B?bWk1TkZRd0QxUXVBaVlTLzcxanRZK2l0SXJPbGQ5Unk1OUV3L3hnSmNOdUc5?=
 =?utf-8?B?RVhaMDlCNmp4cHlJcUVNa0FHb3psTjgzblpITUJIQUZUUFlQR05DU0xYY1Jz?=
 =?utf-8?B?bXpJTWxheGNVb1ROOEh2eXZFVHVHM052cEtDejh1UUdTQ3RYS3pjMzJDQlJE?=
 =?utf-8?B?WHpFZ05QNnBUa3dBQ2JrcXpJU3FzWFppTjJqb284T0syMUlsdzd0c0UyeHR2?=
 =?utf-8?B?WFRlM2taT1VkUDlUZmliQ1B0dzJLVUdiRmhra05WdnpOVDFRL2lXMU1wUmFr?=
 =?utf-8?B?TWZlTE42VXF6QUFoRUIzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlVZem1ZbndsbFBhMW1XekdVY3ZtTHlHN2hsZnZ3dVBqUWEyUlZiUzV4MDlM?=
 =?utf-8?B?OVdsOGlEemszZC8vOHZINWpGaXl1aGlTQ251WGl3UUtVQW13U2dBMnlGdEN4?=
 =?utf-8?B?QWk2NjZ4cWRKTzBRNGZRTjJ0QWJRdXFDOWVBZElobUVhSm1rUTY3QXdlNEF4?=
 =?utf-8?B?Qk5idHFZSjFsQlQ5QSszUFYzcXVhUzNRTFN1YkZtZXUwV0FueC9JVlhSbncw?=
 =?utf-8?B?OW1yd0k0aEpwZzJEdklvdFpxeFdYWVhXOXRXbllqckxNRWsvSFp5TFBLd3JJ?=
 =?utf-8?B?Z2RHMVZQcTJYRnBrUDdKbDFNTjdGcnJGQVE0YTY4TklxTm1sSEdkWkF6RDFZ?=
 =?utf-8?B?dG1nSENhWFd4aUh6eGRrOGp3YktXVjM3K3hPMTNCUjVubm1zVms4dVpkYVBF?=
 =?utf-8?B?ZnA4SW11aHZPSEtwdjdwOUZwcUVuOGZ0VVVoNVBiZlJUNjJnTW5xWTFCMVFk?=
 =?utf-8?B?TTE1elh1TTMxc3ZUdkVVNjFTaXNUVGc3aFhkWXB6cGJmTnU1R1VGb3k4RGVF?=
 =?utf-8?B?eFVqeXhVcVA0bFU5Z0EvbnovQkxUY3BlODI0dy80eXBqZmNvT2FkVXdOcElp?=
 =?utf-8?B?bzFyajJtZDlmTnQrOE9xL2NocVBIN2ZlOGtIRERwZytLQWduUzg4MkpBUWNQ?=
 =?utf-8?B?enRSUEJTRDg1Yk9PWldvV2R3aVd4N2psTmJIUGRoYnZscENnUE43bWEvYzRh?=
 =?utf-8?B?WHlWT2tsNlVIOWtaTWRuQnVVUkdsdVZMM1J6cDJ5elMwSWlDOGpaTE5MdUxX?=
 =?utf-8?B?K1o3RmtDNENObW5iVHBpTGNCYUpoV2p4RWh3citIdzJNbkl6SDB0SjBOaUNo?=
 =?utf-8?B?RWNNMkY4QUVzZUp5WUhPSGR0bXpFVWt1OFhxenpyeWxHODBHZm1lL2NZckhU?=
 =?utf-8?B?M3lDOHJoelhpQ1UxRm8xNDkzWmE2cHEzeTFDOGt5NVRXV2pHWUVXRGR2ZFhE?=
 =?utf-8?B?RWE4aGJlYUY3V2t4Rm01OGd0Z2I3MVJGVVlET1ZsUlhYVkkyeDZuc2pXcXVn?=
 =?utf-8?B?cUFpMURHdW1VZ013OVk5RmxGeWl6YUwvYldRcEdPR2c2akE3b3I3WGVLM1pi?=
 =?utf-8?B?RUZMYVhIem9FeXRuWmdQVUcwZGN0d0hsMzlnWTNERzhuOEFrVVZNeElNaG4y?=
 =?utf-8?B?S0Q1K1YrY0hZTk5GcG9CNlFQSVlxNnk5NThzQ0VPeEkwMlRielpMYk9SMjdH?=
 =?utf-8?B?dGNvbDQzbEFQdnJ4UHprT1prN0FhZFVqUHFBR2FzMVJMM0luOWw3M1JzTXM0?=
 =?utf-8?B?U1lVR3hqQlJuOGVlQU1lQ3k4OTE0Wm5KUldLOVhRRENzS2FnbURFZEhqL0R0?=
 =?utf-8?B?RmY0SW0vRmg2by9qb3ZpeGxQbWhNUUdLSHhaMjFKWW43OWtzTmdHb0o1YXJm?=
 =?utf-8?B?bU1Tb1RRODlaOU42NHVYOTFFMWdLV3F1MkFxYjJJN1ZYdzBKK1N2VGtZeVVw?=
 =?utf-8?B?TW1YdE14YWh3VW1wczhLMCttTm00ejlHaEtzS0ZsU2ZLM3ZkOU1hdklxcG01?=
 =?utf-8?B?b2dkK1RZRVlEWFdMRXdlOTRUTmp1VzMzbXU0TEMxb2NLNmo3S1grU1NDa2Y4?=
 =?utf-8?B?QUVmWjl3d0orRURmUjFlSS9MU0hvVVdPNEljdm4vQ1B3eU5HVUVtMFVOM2ts?=
 =?utf-8?B?OWswa2MrYjVYQUJUdjNwMFphUWR0LzZHb2hqVU5qbUJXdXVmQkZCWTNmc3hD?=
 =?utf-8?B?NnM0aHZNck4zb2Rmb3ovcXJZM3VGaXZDNUpidFYvSTZ3eFlNOHl5bTAvNDVz?=
 =?utf-8?B?TU96R0RvQmk1aHhLSjVmZUEzK1c4cklpMzhpaXdSdmxzQUt5SXlUeFJKK2lj?=
 =?utf-8?B?ZXhWMkdabnZUZDMwdDJ6L3ppRkl6TkdEVlhLTjJsVU1IaFZkNEFCUERtM0pB?=
 =?utf-8?B?clZtYmxkK2tzcXNiSzBzcHEyTUtpcE1SRmtKZUhpaEt6WGJBdS9FODRlR1U5?=
 =?utf-8?B?K3p2aXc0bHZmTE44c1NId0M3Sks2NlVCeWh2Mnltb0ltcDBoN3QyZGZNeGt3?=
 =?utf-8?B?UlM3Mjg2VHlpK2trV0QxYXRha0d1Ykx4SHZqcTdRNGxvV3kraUxOSkNHMmRK?=
 =?utf-8?B?RFpUWXc2Nzk1QzJGL1BScE5SZnFJU0NyeTdjZ0R2aDlpUEg2d3Q3OWRXL0Na?=
 =?utf-8?B?SHNHdHVaSjFvN0JkUDA3K3RZSjUyRjhndDJjdW5vM1NwejhydVVaY3N5VFhm?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KepIyD5mWPYSpyXlDw6EvuOhywIo2QYQ1HkSVTtavQ1DACH6lxEIBdCzrvFpcduVNH3v0BAgxzAmDzJXAvLiTl7ICJEEijG4iQSIMV+EeG6/NTLF37MshllPfW6aPNBbZ7J7GMJc1toHMuSSQUluRJqkZMIncI1XTKbFjQUcFYITHVtYo6QU9zF2TPGAA3islun02zMtFdDbakySECm9ZPzH3GfOIUwU8e02sOP1L//4VcJA62GwuLyUNWeuCqfQlM1999x9XgPDIMsDTBPoeuD7+p0gm82jK71F2DdhN+0wDFljHaFxkpLKtiVNzVFjVTSPgCC8eVEdC3uGmVvAVLUScDW36sU9PFb02GDKDkLd5dxMYyv2Qh0AEp9xGa8XuODg+MnoDMwBbkTf1SK1yRjkB8+tRmrhEBojb6k/VDb1wPL6RYVhvGG77D88r4U3P/10y8kcZyZjfPyjiHzvbHzXbnqXUXalT7Ut4wJJ0P6uTbEuapq8SQ41Q/Z0ZoE4qBqTVhk8OxTwctPxTJB6AHv17dykgZMT54+6PXdtlAC0f2SbV9YJ/HxgcJNnAPM8C/hmlF0wU4dGp4GzOwYtHVsMp38Eb20U/OTtORzpG2U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 730ea485-1acc-4bb7-f25f-08dc9ff6d605
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 09:09:28.3541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bG2/TBuI0J6nnUsd9CiUZEcCc819keM7utNsqsa+L+VUsOBYvbUYBtfwk9aQBU/Eaj9kP7GTwSEd5TUfcdwfofv4cTvYpLR5sDNYbHJ1zBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5891
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090061
X-Proofpoint-GUID: dDkBLLIHtO1o4zeJFd03M9NPmiPanmMt
X-Proofpoint-ORIG-GUID: dDkBLLIHtO1o4zeJFd03M9NPmiPanmMt
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

On 09/07/2024 07:50, Cédric Le Goater wrote:
> On 7/8/24 4:34 PM, Joao Martins wrote:
>> There's generally two modes of operation for IOMMUFD:
>>
>> * The simple user API which intends to perform relatively simple things
>> with IOMMUs e.g. DPDK. It generally creates an IOAS and attach to VFIO
>> and mainly performs IOAS_MAP and UNMAP.
>>
>> * The native IOMMUFD API where you have fine grained control of the
>> IOMMU domain and model it accordingly. This is where most new feature
>> are being steered to.
>>
>> For dirty tracking 2) is required, as it needs to ensure that
>> the stage-2/parent IOMMU domain will only attach devices
>> that support dirty tracking (so far it is all homogeneous in x86, likely
>> not the case for smmuv3). Such invariant on dirty tracking provides a
>> useful guarantee to VMMs that will refuse incompatible device
>> attachments for IOMMU domains.
>>
>> Dirty tracking insurance is enforced via HWPT_ALLOC, which is
>> responsible for creating an IOMMU domain. This is contrast to the
>> 'simple API' where the IOMMU domain is created by IOMMUFD automatically
>> when it attaches to VFIO (usually referred as autodomains) but it has
>> the needed handling for mdevs.
>>
>> To support dirty tracking with the advanced IOMMUFD API, it needs
>> similar logic, where IOMMU domains are created and devices attached to
>> compatible domains. Essentially mimmicing kernel
>> iommufd_device_auto_get_domain(). If this fails (i.e. mdevs) it falls back
>> to IOAS attach (which again is always the case for mdevs).
>>
>> The auto domain logic allows different IOMMU domains to be created when
>> DMA dirty tracking is not desired (and VF can provide it), and others where
>> it is. Here is not used in this way here given how VFIODevice migration
>> state is initialized after the device attachment. But such mixed mode of
>> IOMMU dirty tracking + device dirty tracking is an improvement that can
>> be added on. Keep the 'all of nothing' approach that we have been using
>> so far between container vs device dirty tracking.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  9 ++++
>>   include/sysemu/iommufd.h      |  4 ++
>>   backends/iommufd.c            | 29 +++++++++++
>>   hw/vfio/iommufd.c             | 91 +++++++++++++++++++++++++++++++++++
>>   backends/trace-events         |  1 +
>>   5 files changed, 134 insertions(+)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index e8ddf92bb185..82c5a4aaa61e 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -95,10 +95,17 @@ typedef struct VFIOHostDMAWindow {
>>     typedef struct IOMMUFDBackend IOMMUFDBackend;
>>   +typedef struct VFIOIOASHwpt {
>> +    uint32_t hwpt_id;
>> +    QLIST_HEAD(, VFIODevice) device_list;
>> +    QLIST_ENTRY(VFIOIOASHwpt) next;
>> +} VFIOIOASHwpt;
>> +
>>   typedef struct VFIOIOMMUFDContainer {
>>       VFIOContainerBase bcontainer;
>>       IOMMUFDBackend *be;
>>       uint32_t ioas_id;
>> +    QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>   } VFIOIOMMUFDContainer;
>>     OBJECT_DECLARE_SIMPLE_TYPE(VFIOIOMMUFDContainer, VFIO_IOMMU_IOMMUFD);
>> @@ -134,6 +141,8 @@ typedef struct VFIODevice {
>>       HostIOMMUDevice *hiod;
>>       int devid;
>>       IOMMUFDBackend *iommufd;
>> +    VFIOIOASHwpt *hwpt;
>> +    QLIST_ENTRY(VFIODevice) hwpt_next;
>>   } VFIODevice;
>>     struct VFIODeviceOps {
>> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
>> index 57d502a1c79a..35a8cec9780f 100644
>> --- a/include/sysemu/iommufd.h
>> +++ b/include/sysemu/iommufd.h
>> @@ -50,6 +50,10 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t
>> ioas_id,
>>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                        uint32_t *type, void *data, uint32_t len,
>>                                        uint64_t *caps, Error **errp);
>> +int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>> +                               uint32_t pt_id, uint32_t flags,
>> +                               uint32_t data_type, uint32_t data_len,
>> +                               void *data_ptr, uint32_t *out_hwpt);
>>     #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>   #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 2b3d51af26d2..f5f73eaf4a1a 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -208,6 +208,35 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be,
>> uint32_t ioas_id,
>>       return ret;
>>   }
>>   +int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
>> +                               uint32_t pt_id, uint32_t flags,
>> +                               uint32_t data_type, uint32_t data_len,
>> +                               void *data_ptr, uint32_t *out_hwpt)
>> +{
>> +    int ret, fd = be->fd;
>> +    struct iommu_hwpt_alloc alloc_hwpt = {
>> +        .size = sizeof(struct iommu_hwpt_alloc),
>> +        .flags = flags,
>> +        .dev_id = dev_id,
>> +        .pt_id = pt_id,
>> +        .data_type = data_type,
>> +        .data_len = data_len,
>> +        .data_uptr = (uint64_t)data_ptr,
>> +    };
>> +
>> +    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
>> +    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
>> +                                     data_len, (uint64_t)data_ptr,
>> +                                     alloc_hwpt.out_hwpt_id, ret);
>> +    if (ret) {
>> +        ret = -errno;
>> +        error_report("IOMMU_HWPT_ALLOC failed: %m");
> 
> Please add an 'Error **errp' parameter.
> 

Yes, but I need to do some special casing for mdev then. I'll expand below.

>> +    } else {
>> +        *out_hwpt = alloc_hwpt.out_hwpt_id;
>> +    }
>> +    return ret;
>> +}
>> +
>>   bool iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>>                                        uint32_t *type, void *data, uint32_t len,
>>                                        uint64_t *caps, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 5a5993b17c2e..2ca9a32cc7b6 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -212,10 +212,95 @@ static bool iommufd_cdev_detach_ioas_hwpt(VFIODevice
>> *vbasedev, Error **errp)
>>       return true;
>>   }
>>   +static bool iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container,
>> +                                         Error **errp)
>> +{
>> +    IOMMUFDBackend *iommufd = vbasedev->iommufd;
>> +    uint32_t flags = 0;
>> +    VFIOIOASHwpt *hwpt;
>> +    uint32_t hwpt_id;
>> +    int ret;
>> +
>> +    /* Try to find a domain */
>> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
>> +        ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, NULL);
>> +        if (ret) {
>> +            /* -EINVAL means the domain is incompatible with the device. */
>> +            if (ret == -EINVAL) {
>> +                continue;
>> +            }
> 
> We should propagate an error in the false case.
> 
Same as before due to mdev.

When we are dealing with physical devices this is correct to handle as an error
and stops the attach. However we may still get a -ENOENT for mdevs which is why
I wasn't making an error here.

It just so seems confusing that all the code tries not to special case mdev,
that I went along with it. But honestly on a second look I should really special
case mdev to avoid autodomains given that we know it will fail. This way I
should be able to propagate all errors causes and not wrongly hide errors that
might be applicable for physical devices.

Now the -EINVAL is not an error we are supposed to propagate, as we expect
-EINVAL as a 'this domain can't be used try the next one'.

>> +            return false;
>> +        } else {
>> +            vbasedev->hwpt = hwpt;
>> +            QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +            return true;
>> +        }
>> +    }
>> +
>> +    ret = iommufd_backend_alloc_hwpt(iommufd,
>> +                                     vbasedev->devid,
>> +                                     container->ioas_id, flags,
>> +                                     IOMMU_HWPT_DATA_NONE, 0, NULL, &hwpt_id);
>> +    if (ret) {
>> +        /*
>> +         * When there's no domains allocated we can still attempt a hardware
>> +         * pagetable allocation for an mdev, which ends up returning -ENOENT
>> +         * This is benign and meant to fallback into IOAS attach, hence don't
>> +         * set errp.
>> +         */
> 
> same here.
> 
As the comment says the previous paragraph was the reason for not propagating an
error here.

>> +        return false;
>> +    }
>> +
>> +    hwpt = g_malloc0(sizeof(*hwpt));
>> +    hwpt->hwpt_id = hwpt_id;
>> +    QLIST_INIT(&hwpt->device_list);
>> +
>> +    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt->hwpt_id, errp);
>> +    if (ret) {
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +        return false;
>> +    }
>> +
>> +    vbasedev->hwpt = hwpt;
>> +    QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, hwpt_next);
>> +    QLIST_INSERT_HEAD(&container->hwpt_list, hwpt, next);
>> +    return true;
>> +}
>> +
>> +static void iommufd_cdev_autodomains_put(VFIODevice *vbasedev,
>> +                                         VFIOIOMMUFDContainer *container)
>> +{
>> +    VFIOIOASHwpt *hwpt = vbasedev->hwpt;
>> +
>> +    QLIST_REMOVE(vbasedev, hwpt_next);
>> +    if (QLIST_EMPTY(&hwpt->device_list)) {
>> +        QLIST_REMOVE(hwpt, next);
>> +        iommufd_backend_free_id(container->be, hwpt->hwpt_id);
>> +        g_free(hwpt);
>> +    }
>> +}
>> +
>>   static bool iommufd_cdev_attach_container(VFIODevice *vbasedev,
>>                                             VFIOIOMMUFDContainer *container,
>>                                             Error **errp)
>>   {
>> +    if (iommufd_cdev_autodomains_get(vbasedev, container, errp)) {
>> +        return true;
>> +    }
>> +
>> +    /*
>> +     * iommufd_cdev_autodomains_get() may have an expected failure (-ENOENT)
>> +     * for mdevs as they aren't real physical devices. @errp is only set
>> +     * when real failures happened i.e. failing to attach to a newly created
>> +     * hardware pagetable. These are fatal and should fail the attachment.
>> +     */
>> +    if (*errp) {
>> +        return false;
>> +    }
>> +
>>       return !iommufd_cdev_attach_ioas_hwpt(vbasedev, container->ioas_id, errp);
>>   }
>>   @@ -224,6 +309,11 @@ static void iommufd_cdev_detach_container(VFIODevice
>> *vbasedev,
>>   {
>>       Error *err = NULL;
>>   +    if (vbasedev->hwpt) {
>> +        iommufd_cdev_autodomains_put(vbasedev, container);
>> +        return;
>> +    }
>> +
>>       if (!iommufd_cdev_detach_ioas_hwpt(vbasedev, &err)) {
>>           error_report_err(err);
>>       }
>> @@ -354,6 +444,7 @@ static bool iommufd_cdev_attach(const char *name,
>> VFIODevice *vbasedev,
>>       container = VFIO_IOMMU_IOMMUFD(object_new(TYPE_VFIO_IOMMU_IOMMUFD));
>>       container->be = vbasedev->iommufd;
>>       container->ioas_id = ioas_id;
>> +    QLIST_INIT(&container->hwpt_list);
>>         bcontainer = &container->bcontainer;
>>       vfio_address_space_insert(space, bcontainer);
>> diff --git a/backends/trace-events b/backends/trace-events
>> index 211e6f374adc..4d8ac02fe7d6 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -14,4 +14,5 @@ iommufd_backend_map_dma(int iommufd, uint32_t ioas, uint64_t
>> iova, uint64_t size
>>   iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t
>> iova, uint64_t size, int ret) " Unmap nonexistent mapping: iommufd=%d ioas=%d
>> iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
>>   iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova,
>> uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64"
>> (%d)"
>>   iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
>> +iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id,
>> uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t
>> out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u
>> len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
>>   iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d
>> id=%d (%d)"
> 


