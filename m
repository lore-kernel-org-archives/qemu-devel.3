Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3E1C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmoo-0006h2-Tt; Tue, 16 Jul 2024 14:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTmol-0006VH-RO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:22:28 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTmoj-0003QO-LL
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:22:27 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GHfMqs019302;
 Tue, 16 Jul 2024 18:22:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=9NyZ066yQXCVJtmWorVJ4Df9HoYXtHYwuuxp7hSvtBQ=; b=
 Nm+pyCNLZscwpzF/iiJEZOwg1M4U1GDYFRwGkn4EyIEo2YzMpG7xy0cFSOOiQUqs
 4VPcQ5XmyMTPyQK5AXjmZoimEkv6D+DnlYSb5C7/G2nPBBjmu20+iktV9o7twCrn
 wcLOEgAAcPDUcsi6JomsbVFIDJqtQ6rMuT1iQ8JhxHvTj2OROKaK8nBXK4K4SEZz
 l1smt9JskbvHcmehxZEiVzxTC2iSRbYQVSJcHM/rhY3vHCI+1u1BOXgGFrzkzsaC
 TTm47acTVp8eAyZA4QOag+gCeADKkCKFG1YtCYrlTyAxLCbX49FeLfHjJ+TbUUmo
 OTz4Uz0ku9tyupCeDS3tew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40dwfkg2wj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 18:22:22 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46GHdAwr003660; Tue, 16 Jul 2024 18:22:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40dwex1nc5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 18:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPHsz+TE/fPDDX0njnohvQSQy9UdaNILmUj4D8zMywf/rZP44akwVyMjENooAbx02RF0ZGzHNIgw7Nfr/EHjfPc1VsWxjhsdjfnXZIWvuZF8x0BQQ8cEmtTOI0vDUJmlg+/Q5Ob9lT76wvnkp/havdLtPz3cCoDXt9SQ+uve0wQPicBwyqWPsrJL1K8yc61iZl05is8orw/elXHCAwcxQCRhO8Hy5CRH4SXnwQ0HHHaTO+w1utRYinqJxLKzZRRfwe2YJ/IvSfUr5vKWNw9cg5bSOPardRJXeqxmBjarGP6j9YBa5CB595/GZMmrnfGub6K8BElhBar0GN1KyqadkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NyZ066yQXCVJtmWorVJ4Df9HoYXtHYwuuxp7hSvtBQ=;
 b=akdZYsTf/o3xV3Efbulsc8cg/UcrXf2QMCa+1xEIOXPu17G2Ww0CelaqmX538XqR8bco8Ik/qvTb//vUtZMZXNmJQueANK7xsofMrhDuAzvdLLImsY4J3QDYYs3+p2No1qSfPP985Vqnkn7zYi0NxPKveWw4CtQi7KkbRApqL43yJsAGT0yiKCH/QEwOjin/Ji5he5K8fS68WHQJNqS3CW4ZCDmRqdTKAwSbdvIDgZ3OmQKZFmpPd/8kAq6qjSEhhWigcS7ziXbNAI+gMIltg6irzEAjz5mujzr9nZRFBceoNPhKvOT1h7pXdtQShYeka+o4e2IyrPJNYyuJOV13Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NyZ066yQXCVJtmWorVJ4Df9HoYXtHYwuuxp7hSvtBQ=;
 b=qLA2zxVsw8IEZT4k35E1hYiVUUh/FCVufkVVAhZH8CPo9QLj5ViXi1f9Aa/H1gml2oudfdttnpVRjhuVp19xfUhPw94m+b08EvS8BWTeJ91HhqOVTh41Zel0MVvgBwJDE8s9CPrPIkdXp9Q6HGw4SgdiejTOb5Ca0dwv4uSnBjk=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by PH7PR10MB7718.namprd10.prod.outlook.com (2603:10b6:510:30d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 18:22:20 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 18:22:20 +0000
Message-ID: <7fa60a68-0670-4bdc-b1a7-b4dbec77aa9b@oracle.com>
Date: Tue, 16 Jul 2024 19:22:14 +0100
Subject: Re: [PATCH v4 06/12] vfio/{iommufd,container}: Remove caps::aw_bits
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-7-joao.m.martins@oracle.com>
 <903e6f5a-76fc-4f8c-b83e-d7d2a0f45d7c@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <903e6f5a-76fc-4f8c-b83e-d7d2a0f45d7c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::23) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|PH7PR10MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: e1007100-c92b-40da-a427-08dca5c43b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDU4UlZ6bHY1bDF5bXk2UmZ0Y2FrSkhrWHpvNWhMSlFkbnRFeTgrRHRiZXI3?=
 =?utf-8?B?RnU5NTA2Ny9CVksxUTBJVDFpRnBXN2RxV3NJaEc4MlJZZVdobkI4YncySFVW?=
 =?utf-8?B?YWdYdU94azRvYVB4bGdzeEdNYlBvWVJNeFFNSHhCY2xxQ2xwcW9TUXYrcHl4?=
 =?utf-8?B?d003eDRTTHVRdTdaM0NpQTRQOXJxTzlzZTYxVk81eWxvV0VlcnlBQ1dwRzA4?=
 =?utf-8?B?eXpPNWo1M1lVaUZ3VGtFOWZzb3BJYVRseUdPRGE4RVBXMHF1bjYzcy80SkI5?=
 =?utf-8?B?cDJHcTBKL1A3em9ZUFJjaFJQRURLUXdBaXdMaEdJc1ArTmpDS3RWM2JwZVhv?=
 =?utf-8?B?QnVyM29OTXhLOVdvRlZNUmlNbjh3aDlTVG9hbUlvcHIvaDN4V2NvUXFIYXlI?=
 =?utf-8?B?OFZBaEZzUkJ6Tm4zUXgrVEd4YXh6TVN3Ty9KTXhwMkxQazFwT2JBTm1SQ2d2?=
 =?utf-8?B?REZMemRxUkU2U1FZSUpCSk9YM3NYU2E1R2pnbG5Xd2VmOWplT3dyWFFUbjN6?=
 =?utf-8?B?Vno4NklCS0NXOGtBV202NDRhNUFVaXlSanM4M1NLMXF2UXVPTmptOS9JTmo0?=
 =?utf-8?B?eDByN3dCWVRSZ25ONmRYRzRBY04wYy9RRVNTSTMyTmJKYjh6OFhVOUlXWkta?=
 =?utf-8?B?NHoyeUtjZGY3M09SdmlGWnI1M05IMGtPaUlNZ1dTbGhmQVhJZkErUW40V05W?=
 =?utf-8?B?MFpUNXRXWTFQa3lQM1dQNG8yRTJkZ29DNFZockI0NFNjUWdHMCt3V0tXTWFR?=
 =?utf-8?B?YktRNjVZL1pZQ3VhcTRtMnJxVzB2UFJxWVMyTy9Eam03SHpVb1JHNGZicXJG?=
 =?utf-8?B?YmF6V3RQcTJ6Z2hPV1NKb2psb2tmMkV1SVppdXpDeHhBcklzOTUxQWY3aERl?=
 =?utf-8?B?SDRSa0JBTTNkSDZFRjJMd2tCYlFzWGVWK0hHeEFqU2w4WTliMld5enRnYUc5?=
 =?utf-8?B?dUtxbDA3UHV1aEUrdEFYdUpVc1RZdURDV1JpcDA0aXhzUlp4dkE0NHltak9q?=
 =?utf-8?B?bk5tdUttcU9sY2NLUTdCM0pZRmdna2d6Q3dPeElTUkFtNHRhWVpHTkJqMHhD?=
 =?utf-8?B?Q05TMGpuMTIra1BnR0xEUGJWUy8xMjFXbVM0ZkZpZksxYmduNkxyNG1wdjYz?=
 =?utf-8?B?NldEWVUzS0lDOUJBV1JDaFFCNjVqQmlpQld2cFJyUm1oSVVQRERMdFptWWtp?=
 =?utf-8?B?UzlhNlFZZ1F3YnQ4Sjc3bFhabXg3SG1WbHNQZUdrT1BPazhZcDdaMSs2YXJP?=
 =?utf-8?B?TW5qRXdrT1RVWVYzbmFKVjZOM1U0bE9Fa21HSzJKSHNnQkhKaGgzNWNsTytO?=
 =?utf-8?B?M2taZ3UyQk4rajZkcHMrOWdDWU1iNWp0YnFpbnk3OXFWRWs2c1NaYUhqZGtw?=
 =?utf-8?B?cC9aUVRvRFhwYlFoWC9hNlROeUxjdHIwV0ZtOEtldXdHSW5adXNlOWhMSHB1?=
 =?utf-8?B?RzFDTWpvSGRlTmJJcjZVNjdqbktVRUFGSlorQnVlMVRabHE0RUt6Q2x2M0VJ?=
 =?utf-8?B?TEprQ2owcWxRMElTaHd1TC9zZzZNRWlvZno4c3dCZHJnRC9jNGNtRk1pZERz?=
 =?utf-8?B?UEdtd29sUFJNbVlUR1dNUkxiRmtNaHJvRGI3SDVLSW9wUmRrMzZkNXB4Mm9m?=
 =?utf-8?B?MU90SzFnWDZaanF0bUV0UWtxME0xWWU5ME5LRG1ac05nVkl2V2ZGaGk0TWp2?=
 =?utf-8?B?bGVoUXp2Vm5DRUNNQzhKYTYwZjZQRGttUFVwbjVkOVlpK2ZJbnBoc3RIaFZ2?=
 =?utf-8?B?SXZNY01uOTF0Z2Y0ZUwrakFBMHVGWVhLeEZkYTc2bkFBU0cxbC9ZOWIyZ1RE?=
 =?utf-8?B?WFRoZEEwVFpaU0E4S0xlUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cS9ESWM5ai9MVTFjVEFudTYzWCtlL0tYb0pnMysybTB1MXMxM0IwQTViT0Yy?=
 =?utf-8?B?T2tmUjZOWXpYbTVqc3NzeWhvYXFDQmMrNXBFbGZtTnpicmIrenRMWTE0Z3hX?=
 =?utf-8?B?MlQ1L0daczlYaGkrSmlBZ3d3NDBYMmtPYS9OTFA5RGtKZ0VBYmtHRnRJVDho?=
 =?utf-8?B?RXhmZ1hJVFl4eVZlRnFxWG9CMHNmZVNMUUNvOEZIZXVnNEFtS1NqZmJiQW5x?=
 =?utf-8?B?MHcxbWsvS1l4VSszM08wdHpKcGgyek1jVVVZSmZvOHhuQTJ1aWRlbDF6U0NT?=
 =?utf-8?B?UXF1ZkhDeElhQ3VXSTBpZGxLaHdGVEN6VWx6VnQ5T2tNYWdQRjBYT3BZS055?=
 =?utf-8?B?Wm1SazRmcXBYOFZaWjZEakRJTTNJMUVtRjdjL2p0MmhCaUFQenREWU1DUGZr?=
 =?utf-8?B?a2NtbFNiZWFWNUxvMGhDeGhtS2VwWlhoS3U5RVlIbnVYYXlRc2Zva240cVox?=
 =?utf-8?B?dHBhcUdyUVBER1pzL2tjQStnTmx5eW40ZE5YYjQrM0tRZGVRVldoVzJWakpR?=
 =?utf-8?B?RGFtd0JBWHpjay9OYnNqVUw4a1crQ21XUjJZZFg0eWk4QXZTbkNHU2UrUTUv?=
 =?utf-8?B?R20xcTdhREVkNlZrNUZoV0ZyNjNpSFpkRGk5bVNjUWpIeCtXYnV3cUZhdW9O?=
 =?utf-8?B?NVowa2tjOUJXM2lsTm90Qjliakl4anM1TU9CbnVnV1JTOXB4S2lDUW52VTgr?=
 =?utf-8?B?eSt2QlI0WHVIbnVTckxHWXZzd2I1dzJ0WUx4eTI2b2tKbjRWeFVPRGN3ampY?=
 =?utf-8?B?dGFEYlRnL1NHVzVnVitsYXQ0dkpEUmswM1hHeEYrU1JYaUMwWTR2R0JpWUx5?=
 =?utf-8?B?bjhKY24rWnRMRE41bWRtNjVhTWNEZ0podFFYUFFBcnYrUWlWUG85QUt2QWp4?=
 =?utf-8?B?dG51S0dMS2xkYW05aHV4QW0xQ2liQ1VnVlozREF1TlEzZnpyNEtuL0Vwd09k?=
 =?utf-8?B?VmVLeXJjdEEvWTNjbGpDSE1VdFd3akNmekhmVHJyd3dsZlBmWTlzcEkxdTVu?=
 =?utf-8?B?N3FKVDEwOWlpT1pvSG16U3k0bnRqQ3krcW1oTENwK3N1VjdxbExIbWJyRWxX?=
 =?utf-8?B?QlU0ZDJLU2tiZThRTlJvZmh0Z0NwZ01PM3lmMWdnZGwzM056OUVOUUVSZmdp?=
 =?utf-8?B?Ty9kYkhrd2k2ZkRtYjZkcVNtNFBtSUlyNitlV0Zub1RWNWVFK3VCanMwSUtp?=
 =?utf-8?B?RGFlOG5uZVN4bDh2QXZBbjlFSUpWTVVxZXg1MUIyZURVZXJnKzRoallTOGhB?=
 =?utf-8?B?MnFaN3VIdUptM3l3Qy9LREg2eUNRMHk1ZmJ3Vnpva2MzRWs2M3Bmd21zNEgx?=
 =?utf-8?B?Y2NHeGdXTGpCbGVCa0lxaVkrN29oZkg1Y1YrUU1yOFA3Y1hRdFU2a3pkRnJ6?=
 =?utf-8?B?RUN3aDd6Mmt3YlhEdmpERWxUT20xSG0yY29oMXd2UmZ5bjRnZDRwUXptUlpw?=
 =?utf-8?B?aFRTSSsreUNEVjFGSUF2WnR6MnJNUnppUVFnMmI3NVBDdWpLRm80QjI4eCsw?=
 =?utf-8?B?NUlQY2RkWEh6WjhmdCtxdndPWTRTdSt1YXFiWStMcHkzdDZ3RUhOSlpzT2Vh?=
 =?utf-8?B?bjBQd1BRdXZNS0NzQ0RpaEE1VkJqRVBwUHVQOEZkbnFJelRad25LR2ZLVHNV?=
 =?utf-8?B?MVl1NXpxY2xhT2k2UDYzU05aU21HWWlvS0czZVpsdHcrdkhJOTVYd3VMUDJ0?=
 =?utf-8?B?OWJld0VXRzJ5RTJxRzRMTXdMYWw1R3ZQdUZmQmxjTFNvNlpLczlzN3dWTW9l?=
 =?utf-8?B?TkVldnowUVdJekgzTHpOVG1ockROVDlDZzFIVnJkamhjMERnVTArUkFxYlc2?=
 =?utf-8?B?c1dlSFpPNVl4WHk2RlY3U2d4bUd4aWxmZmpJVzdxMlk3c3RwUVZZMEtLaTh6?=
 =?utf-8?B?QzdJd1ZYUlRDY1l0UFR0WmQvaWdnY1RwakEvT09MTDBRQkxKd25SUS9YRDBq?=
 =?utf-8?B?SzhOUDhxeCtoZDJ0dUpTVTRmZlAzMGFISUVLS04rQXk4WHBmR1NXOVM3Sis3?=
 =?utf-8?B?SWJBM0tQeGQxR1pET205cTlXRGNiK1ZNTkRRdHNBcmhxTjZFUkhMNGUvVnZo?=
 =?utf-8?B?VkVOWTNwZCtyYlMzNDRhZ1FROVRhZHFuTklva3d4K3djM1RzKzAwOHNoY2Zq?=
 =?utf-8?B?TUlhRFl6ZmR4eDB5dXVULy9NcmczR3hvZlAxWGVqOVd3b3Raczdyb2xTQ0ZP?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VEoaycYMNY5qqakpuJ15JDRUZti4dIM+LiaDTk/BXaStsw3IiYZWWHugftCELNrvGGByy/G5/FU1zMJ92wdQYaprtZZTy9HBqxF3xQhQMiePcqcvjQttgxqgplkBvwfOGd7Y9xQBzHb77MMmzNN6Qmi0O68me/abnZDxRcAvugNK4goBjPZU4eBIy5/fPoBCKtcKLYPfWbPRGtnShZDrsrucC9KnopvEUz9uUfgA8mJZv3H6WcTU9dJO3OxZPVIA4jq39gcq84R2zs4i9ieh7U9xAxhnaLG6Cprk5GM7hInhSKY8pF/COfngwLn5KDY2J96BfUnK+f1yd93SEu5+3c+tIAVBb2inc8PONBdWhGH+4ULs/Ldb/T5Jkf2S36/xLvN8eE5DC+zYtV2aw6eFOz9gVin4f8BovVpqFC0gnpp8DE2hQsRloz9GkCF5hFO9KC3zCRWRfoUGDBQ3aoqY6mO00+YODjEDp+AKKpVS46G8QXSo3k7vpQ0SiqERH55UJjCWmHAEddkOjnrUoSlJ5wPtF/kjYlcdNBZH8MZDgwyYO9tFkGHQrkAjHoNKQyNVcGVqN7I1Kc1TsgbEGZBTkJG9JO2KG1GN6dwT9CXaQlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1007100-c92b-40da-a427-08dca5c43b47
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:22:20.8465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdBBbjCzFn/89I1t3DP2hhdiGNiYk0FOmQ/dmXKhvxzjxvRBtCMge1GpA+kx5LKZf33mxxhBX9G+EL3bk0jnko/R6QIKH4athXn930uhZH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407160133
X-Proofpoint-GUID: oBV3VOx3pqaccNZKnNasteWioMDKc6YF
X-Proofpoint-ORIG-GUID: oBV3VOx3pqaccNZKnNasteWioMDKc6YF
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

On 16/07/2024 18:40, Eric Auger wrote:
> Hi Joao,
> 
> On 7/12/24 13:46, Joao Martins wrote:
>> In preparation to moving HostIOMMUDevice realize() being able to called
>> early during attach_device(), remove properties that rely on container
>> being initialized.
> It is difficult to parse the above sentence. Would deserve some rephrasing.
> 
> Also properties have a different meaning in qemu.

I think I will remove the above paragraph and instead adopt below with some
rephrasing:

Remove caps::aw_bits which requires the
bcontainer::iova_ranges to be inititalized after device is actually
initialized attached. Instead defer that to .get_cap() and call
vfio_device_get_aw_bits() directly.

This is in preparation for HostIOMMUDevice::realize() being called early during
attach_device().

Better?

>>
>> This means removing caps::aw_bits which requires the
>> bcontainer::iova_ranges to be inititalized after device is actually
> initialized

Yes

>> attached. Instead defer that to .get_cap() and call
>> vfio_device_get_aw_bits() directly.
>>
>> Suggested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>  include/sysemu/host_iommu_device.h | 1 -
>>  backends/iommufd.c                 | 3 ++-
>>  hw/vfio/container.c                | 5 +----
>>  hw/vfio/iommufd.c                  | 1 -
>>  4 files changed, 3 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/sysemu/host_iommu_device.h b/include/sysemu/host_iommu_device.h
>> index ee6c813c8b22..20e77cf54568 100644
>> --- a/include/sysemu/host_iommu_device.h
>> +++ b/include/sysemu/host_iommu_device.h
>> @@ -24,7 +24,6 @@
>>   */
>>  typedef struct HostIOMMUDeviceCaps {
>>      uint32_t type;
>> -    uint8_t aw_bits;
> the doc comment needs to be updated accordingly.
>>  } HostIOMMUDeviceCaps;
>>  
>>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 5d3dfa917415..41a9dec3b2c5 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -18,6 +18,7 @@
>>  #include "qemu/error-report.h"
>>  #include "monitor/monitor.h"
>>  #include "trace.h"
>> +#include "hw/vfio/vfio-common.h"
>>  #include <sys/ioctl.h>
>>  #include <linux/iommufd.h>
>>  
>> @@ -270,7 +271,7 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice *hiod, int cap, Error **errp)
>>      case HOST_IOMMU_DEVICE_CAP_IOMMU_TYPE:
>>          return caps->type;
>>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>> -        return caps->aw_bits;
>> +        return vfio_device_get_aw_bits(hiod->agent);
>>      default:
>>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>>          return -EINVAL;
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 88ede913d6f7..c27f448ba26e 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -1144,7 +1144,6 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>      VFIODevice *vdev = opaque;
>>  
>>      hiod->name = g_strdup(vdev->name);
>> -    hiod->caps.aw_bits = vfio_device_get_aw_bits(vdev);
>>      hiod->agent = opaque;
>>  
>>      return true;
>> @@ -1153,11 +1152,9 @@ static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>  static int hiod_legacy_vfio_get_cap(HostIOMMUDevice *hiod, int cap,
>>                                      Error **errp)
>>  {
>> -    HostIOMMUDeviceCaps *caps = &hiod->caps;
>> -
>>      switch (cap) {
>>      case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>> -        return caps->aw_bits;
>> +        return vfio_device_get_aw_bits(hiod->agent);
>>      default:
>>          error_setg(errp, "%s: unsupported capability %x", hiod->name, cap);
>>          return -EINVAL;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 325c7598d5a1..873c919e319c 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -722,7 +722,6 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>  
>>      hiod->name = g_strdup(vdev->name);
>>      caps->type = type;
>> -    caps->aw_bits = vfio_device_get_aw_bits(vdev);
>>  
>>      return true;
>>  }
> 


