Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4389BC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 09:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTeZI-0003Vy-8u; Tue, 16 Jul 2024 05:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTeZG-0003Uh-CY
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:33:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sTeZE-00068k-8c
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 05:33:54 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G2uAqG030147;
 Tue, 16 Jul 2024 09:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=TIHqDqhUTUlJGHsYy4jM69sPhYfyFgPXy3VtEI5pwhE=; b=
 R4bMBfq6CXnlMeCQh3eObTzzg9+xnYCcFjeedtegRr3x3BCd5lFgAtig4X5evmyO
 xW+vM6b2ojGQFK8y4gkIgpPXQFlkfXgyeWrV0vcQ//TgV2bqJ5mV8O5ZqINqDMm7
 XlxVTjeLoevm5lL6Z0rZ76JpgvAV5fjv5BUoCf5894kuq8SRbUkXmfKm2NrhBiXN
 upFcugFoIIgE66qlLpN8gochMiGYAwqVdjcRqn3a8wfk6Mp72O0NicnC+rG2joMG
 sATmTN5rxzFUywdRObGslFw3V3O4bjv/IvHDeE2St2KOz0fbT5xGIpbjuGfiXA3g
 dwfmd9WtAQHU3jye6aXLlw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bggb5emt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 09:33:48 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46G8DZvs010815; Tue, 16 Jul 2024 09:33:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 40bg19agrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Jul 2024 09:33:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHAFUCR/l2gM/7Ii1au7Nwc2qrlkxWumKbdN6srnVTZQCrQnmheSdcDRvIphQyOGEul4Sss5YQVMSbeI4CoZJ0TQbfSQNkqROS7eKVzskfUFmX8P/Qw9HFBtC4wevLKZWL27CTiBPxDG8EuGq37AslXXAdiArskE1QPCA/3JB0kZy+F3QGtNsuqLteVYMsNJymz2TKTWhL2copgk/e1DFPZmcV+CV4YMLjpSLn+sw76TwftFvn+/eAojXLWU6sW+rV5eRcbTLvgaOTQXSJ+kKaYZxlsmJjTa9dH5kXh7437IrYyp+5i1GqAEteazlwOIxJS5/PyyPjFWULy85cbhWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIHqDqhUTUlJGHsYy4jM69sPhYfyFgPXy3VtEI5pwhE=;
 b=MnMAvaQd3xFqSnMwkz7n7anbECgbVKaYURA6s5SjKwWGToWQ3s/BGvScolADo2uajBd885xe2zd8nUhAwoN+CscONA+HdNEdGDG6KXt38DUtfQTy3bHNaakLANgbTfuDfLmEdutw7y9N9oGJIAwPQimXNxcSRu+sWRFCPfocRFJPh1PX+NZd3a8u5lJCTREdNGChf0nLSwWar7oI0M2aI82M4bn5APjGT8mL4f+RNwpzdJyD73KnpdYn7Uoye1hJrkVWQ1SqsIhtrYcTHi7Rqz1uKOX9Dx6hHJfThyRvyD4vw22rMUVDNyB45PCKy4SkPjvMBKqaaNnUo7DhOzCciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIHqDqhUTUlJGHsYy4jM69sPhYfyFgPXy3VtEI5pwhE=;
 b=wCsNJYQvXfDE/TG2yrCCD8SSI9GtzNrOIf9N5dqVwKxek7QpuV2/mqnfZ1I6RX0KmEZsKqSlpVdu1Q77hXoQY+Y1sWl51xT1iu3dPPYyRDYvA0C6Zojt7pnZAr8m+ohkpllV5ZxQAbuO/EDmajH/JJtPunVm0yH5T8XakNtMLvI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DM3PR10MB7948.namprd10.prod.outlook.com (2603:10b6:8:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 09:33:45 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%3]) with mapi id 15.20.7762.025; Tue, 16 Jul 2024
 09:33:45 +0000
Message-ID: <5dbab89f-7396-4748-9d4e-8b7b0c261134@oracle.com>
Date: Tue, 16 Jul 2024 10:33:39 +0100
Subject: Re: [PATCH v4 01/12] vfio/pci: Extract mdev check into an helper
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240712114704.8708-1-joao.m.martins@oracle.com>
 <20240712114704.8708-2-joao.m.martins@oracle.com>
 <36b9e5c2-660e-4020-a645-4f4f33b208b8@redhat.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <36b9e5c2-660e-4020-a645-4f4f33b208b8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::35) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DM3PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 30428091-76d9-419a-8ff6-08dca57a6382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWVZdWk3SFYybjVxQ002ZkQ0QWFwak5oaWF1VTJHTS9HQ3E0ZW1IWld5WG03?=
 =?utf-8?B?RVRZL3dnRXpIZ2EzVk9POHE4TnZKcjBadVpncFlMNWVoRWxSWHV3bXAyRmZ0?=
 =?utf-8?B?cllvNzdHVHJrcXh0ZThwMzhCZGZZUXNLRGt0aERjWDhGTmQ3dXBORW00dElC?=
 =?utf-8?B?MVRDOWV5RkdmYmJHU2NVNkZTeWc3ZnplMmlibWNMSFBlZnFCT2kxWnJlMXRQ?=
 =?utf-8?B?Q0ZPQ1pIQ1BURTRVZk5JVnZOVlZ2RzZMUllXSE50RW1aWDkzV1U2NlZyRUlF?=
 =?utf-8?B?VEVHQ05mc280WXRxT2FKTlJFQWd2ME9RSDhYaHpnMG9NaTlYZGx2THFEMGZ5?=
 =?utf-8?B?SFdVKzkxb1JWUWdXUldRQnJUay8yK3JodGxwaFQ2c09wZzlWbWJIY2Q3VGJL?=
 =?utf-8?B?OEJyY0gyYlBjQ2hzdGZiMXhQMXAvMkUrbmlLdU4xOXRyTys4bnRSa0R6NWJ3?=
 =?utf-8?B?OWJHM1BXRnBqTXo2RkwwSy9VdEhEMnZDcjArZGo5cXF0N2ZURHE0K0R5UWEz?=
 =?utf-8?B?N1ZoWVROQnRIcnlTQy9qOVdQa3IzNmpZdVVmWVRSTHplNFFKUHRnejVnUDZ1?=
 =?utf-8?B?SXkzUUg4VmEvWlBxSlllaVhCTUJxaVVkUFFZY3cxajRLVEQrdVZQNCtqcjJo?=
 =?utf-8?B?dks3elVBazBUUW1SdGFFdDY5ZlhjUFN0SEhVK0lQQ01oN2NiM0pzS0dyblY0?=
 =?utf-8?B?Sjl5eFY5OUErVWhIWWY0Y3R5cUtYcVBNVVJDcktmY0hGVnBTamh1M3ZxSldp?=
 =?utf-8?B?ZFE0RHV1WXFoUzFPQU1KeDdWUGtibzFjdTdBOGZpOUo1M0JzMkRFU3ZOSHBk?=
 =?utf-8?B?Q0h4eHlyTnlraEo3bW43aWNiUnpFYVFuRDhXM2Y1K2hSUkVLais0Z2tVVG9Q?=
 =?utf-8?B?VGR6MHZVc2Q5cHY0ZjFndmIvQkkzOEhINGxDYkFnbnVsTzA2UTFmanFzSnRR?=
 =?utf-8?B?NmxpaGJEdG5GT0JQVVQzc2pHRXRnZSt3TDIwR1dBTTdwMXFZTE5yYVdPNjdP?=
 =?utf-8?B?Z3JWVGxEeUVTNGxzQVA1QlUyN0trclNwZEFtU1dieTZmQWNJVnM5dGNBaHcr?=
 =?utf-8?B?U01HOEp3UGV5RGhVdFJMTklYM3o1djY5V3IwVXFBdnc1REFCVFJFb29MVW5r?=
 =?utf-8?B?b2U5d1I3ZUZZZUVJNFF1Y1BXRW04Z1l3emNmT1ltanU0L2R4aTFLL016N0Vo?=
 =?utf-8?B?SGFHSm5xM2U4c2lON29DcFFNMVp6RzIzRG51RCs4RmZJUE15OE4ra2ltNTUx?=
 =?utf-8?B?bjA1Vk1sa25QTWlaV1NrNEVxbXg2V2hUcCt3TEQ5dGc1d1lhdndTbEJQWnY2?=
 =?utf-8?B?Ny9SWjBhY3U3WmN5bW4wVE9mZVg1N1Y1M2JEdE1GL3ZYWEhBUEJPV1hOY052?=
 =?utf-8?B?ZGpCR3NleUdKR2Q2bmRzc2s1MXlDYXd4VGJuNFF4NDZNaVVidHVHRnIxWndU?=
 =?utf-8?B?TzhHV2JqelMveXhPa3VndGN0UWt6VzFuQi9QNlkrb0s3V1k1M2NzZnZuWXdp?=
 =?utf-8?B?YUFmaU9kOHEwcG5MNUFWSDRJZDA1VXEraHFHRVh3M3F1Y253ZDlOb25LNkRh?=
 =?utf-8?B?YlUvSkhBSlNackx4TDZTd3lUT0JCeXVOQ1MxU1htRUgzKyt2cENKb3F3YlhP?=
 =?utf-8?B?ZkNHS2xlcGxLRVZvUDdxaTNvZTRra2NVRmRDeS9vZGx0ZDlPbFgxaTBlNWlC?=
 =?utf-8?B?aGVYc29LNFlHelcwNmExSG16T3g2b2Y5c2k1R3NGeHEwZ0VTdW83SlBJbHhO?=
 =?utf-8?B?b242SDFMd0VGenZLbGhwenp3WFpTS3J3MVZMUkxzdzVRTk5QN0N4T2tLTkpB?=
 =?utf-8?B?K0VIUU03SWNvUEFWOUNEUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNGUjU5dlBMR3Jad1hIOTZreUhzMDNsbytoZDh6MEc3K0RJWk9EZmFmZlJo?=
 =?utf-8?B?K2IyYUxBZkF5NFY2UWM2N2I1bjFMczUzdWxoREVtajVjVzR1aEtER1BRZmpB?=
 =?utf-8?B?bDVnSUVCVzhKWW5vOE9wZFd6Sy9RcEZOMlY2RUhKclRqS0ltNDNjanNRMmVS?=
 =?utf-8?B?OVNiWEw5VkM5SUdsQWVxbnlLdXA4bitoSWx3Yk1BNStKMUdHVWJoYU81Tm1w?=
 =?utf-8?B?VEJnNDlQeHBtQXZlVXJzWEVtMUxiaCtqcnZTeENMblRGQlJ2RzVpZVhESG5E?=
 =?utf-8?B?YXNkTTBhTVNqR0d1NlRYRFJMZUZsUm81REptbXBhUFlNV1RFNE9Fbmd0UmZF?=
 =?utf-8?B?bFM1WnpLUW9uS3hSaHNwRHJCRHhPZ25BbG81dnFXYzBSV0ZZSUxoaDVhdW11?=
 =?utf-8?B?d1BWV2lMNFFpbzVEc1V1T2hEUlJpLzRDbHovaTd2OEJSWnVFbXRWbE5ucDNL?=
 =?utf-8?B?ajUxL0luMmlTSHdkZHYrdmk5VmRxaW5NdzhJWXp5ZzM1VjkvYkNucXllSkR6?=
 =?utf-8?B?WXNOazNxNDBES2RXSFdORmJXeGlGY1ZRSnFYdHBWVVJXTEdLRmlsQ0tRcU95?=
 =?utf-8?B?bE1aR1BibGZ4U2NjaGtKMFp4bmRBZFh5L2pmSHREN094c3FtM0dTanN0U09U?=
 =?utf-8?B?YjkrdEpHYW9lcStTaWRUcE5pWHlmMW9lTFhwVk05YWd2aW02MnBTbEtFaHA4?=
 =?utf-8?B?YzF6UndMLzkzcjZjQWpLYWQvSXNxMzg5SVZZUDViRnFmOStSUksrQ09HTHpt?=
 =?utf-8?B?ZTM2a29hcExnU2xyQjZlVnNZcTduMTlIcmpuTTdqUkJNZm1Vcit6WWF5SFpN?=
 =?utf-8?B?RldFb1hXbTBIU0d3SFkrOVl4MnVkeEtOcjFOdjVhNG1CR0xCR3VwRldsSFlv?=
 =?utf-8?B?aUgzajFSZlFjNkhody80Y0dCK1AyN3dWSEVrcDdMb3pDSEdOMmkzT05PRWdU?=
 =?utf-8?B?YldHNGxiY21mcjVoTS9oekluRVgvbEdSajMrTkU0RXRDZWx0MFhXeE54VDRs?=
 =?utf-8?B?QmV1QzBkMUtLYjNVVUxMalZ2bXNBd2xtQlo4VXJyUlVpWXB1enUrdndwZWQr?=
 =?utf-8?B?MndNYXZjakdneTdJT041UlkxdW9aVmgzQU8xcGJrd1lhR3plOWtUQ1FGcktM?=
 =?utf-8?B?QUlSRTdna2RCTEprRk9ES3IySDdhZWRVK2xIaE8rc2NjZjM1UHRrbFlDTzJj?=
 =?utf-8?B?Y2s4cmNoUlFVeDJQU2NKQ0V6OTBDalZGam5xV3JmbERTZzBKWFVieXNOQms0?=
 =?utf-8?B?N2MyeW1nK3NKRFMyeFE4TTYrWFdYTU55enlGQlF4WWFLcDBQaGp2YzJvcWRG?=
 =?utf-8?B?YnFkL3drSU1BSmpodWUrbXFyZzZsaHA0SE9kRjM1eE5XM0IrWExNbFVKRFkw?=
 =?utf-8?B?U3BRaHkxYXpqRE8rSmhtQWN6N1pPenhVVkZEUUcvdTlQQTB3VUNuMzlObjJZ?=
 =?utf-8?B?Q0R6a1pmVFlRNkUyS1dUem5zR3ZUUzZYVU9PdGVUUC9XQUg5a3hhYWVvenNv?=
 =?utf-8?B?MUlTWlZWVGExYlcrNEhyK1JReS9TOWtPNnhpTTcrbjNXWlR3Y0puRTAwZmNl?=
 =?utf-8?B?TUZPbVZRTlYrVmpIK2U4allHQnRFaGgyYWNjOFBIS2FTem5UbXBrTmNVWlJR?=
 =?utf-8?B?blkyTjN6Y3VhdHN0cDR4VEcxekdHOWJCTXNwM3dYTkpTdHRFbE1XNUcwNFhi?=
 =?utf-8?B?QnRsWFlmU1hoaXFaNTBsR0EwWVNuSlFSeTN3M0tJTTdOQkhyblJGNHZpMU5Q?=
 =?utf-8?B?TEdBUUNOVE5icS9BQTM0dDdIOXdzTXhkOUc5K0xMVVJSclZmYUhCc251L3gw?=
 =?utf-8?B?VFRWSkZUUFQzS2R4b0lsQkFMM3MzUnJhbEorVTBLQzI4WWZLczFsWkRvMDV4?=
 =?utf-8?B?RFBKejdLN05VNzJ0MjFHZXErNytrT3hKVCsyMU5sWk03UjlGdWtSeElnL3dh?=
 =?utf-8?B?RU1mSk1WdXNyZVRIMnRmWmNEMHBRaUh6eE1nRllmdGZwekFKazBpNzhZL1JK?=
 =?utf-8?B?dXpqanZ0ZHh3Y2VvWjJaU1M5WTlZUDN4dmFqeWhHbE5XdUNsOXZ6bEh3bndX?=
 =?utf-8?B?QStxT2lnbUdSVFVnYW9wUmRFZ2ZDUk9pUnQrUjE1QU05dGk2ZEw2VXVtYUwz?=
 =?utf-8?B?a2dSbUxFcTVQZVZ6UWZpVkRGVWZWcFNNRGtFODI4TnRxcnNoalJ5M3ZmTVFr?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FbUNyYIb/eEMn/JmktgYdH8HIfin2ESwH8TdCeECdJpmWokWISRvp5N3CBR6BbR2Q2pXCVUPxe9GWBUd1jr/3WjlRW71p5uc0oeU/fhD3r4dynTTa9D4XVN1Fhqf2vTsqJVy4aCrS03hRpmX0msiYToaI1lxshAWcmwJyT5YcYx1cm5pjlvPGaiNKBWFvJgWK78BhK50kq8Ux5R2Bab6D5+WTkXv4BiPlQtAShtlCR6CcrM5pC+Zy1DRAim5SUVBu+ZmuHZx0AIMf83xNdn1tdUbtb0vIryub9hvxpNz0w4Y3EndbSjijHeqIf3x62/kCaLL/hApNh9i/OqFkLDhkxIznf1BNBDaZDyp4ulTelRJwfp8PPv8YZM+84+tdPolQxUARsZCpnjJOb6TIJjGzG6wlyV1qfqovlltcMEeFChze3I7w8x94/DnJ6emIC6UT2DNlI70iNQZ5KOZ9e4gSAiXfCg8/yoq6yRjgupbuF929UYmSn3jAwF5VRfOsyOvxcOZZ3wPSr2T9y0KCxWwF6a1M7sxhE8Mp0aAM/gsY6ZBEO/MIg1CwP+DahNdqlhkfVn+n2DFXU/ZfXUF4QOUDJSh7+QfNc7C80k6Dp+TYVA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30428091-76d9-419a-8ff6-08dca57a6382
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:33:45.5981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ySbHiw1syB79Ok5Oa8FHUit+92+mwWd0jKihyFhMMB7YEfFzqRzTOjKYeMUAc66mf8gMYhSBSc9ye76cgelX+yLr53sCE0QGLuK68cWqOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407160069
X-Proofpoint-GUID: BFs--ubAz3TvQ1q0m4IoUpH4_K-FBO5F
X-Proofpoint-ORIG-GUID: BFs--ubAz3TvQ1q0m4IoUpH4_K-FBO5F
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

On 16/07/2024 10:21, Cédric Le Goater wrote:
> Hello Joao
> 
> On 7/12/24 13:46, Joao Martins wrote:
>> In preparation to skip initialization of the HostIOMMUDevice for mdev,
>> extract the checks that validate if a device is an mdev into helpers.
>>
>> A vfio_set_mdev() is created, and subsystems consult VFIODevice::mdev
>> to check if it's mdev or not.
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  2 ++
>>   hw/vfio/helpers.c             | 18 ++++++++++++++++++
>>   hw/vfio/pci.c                 |  9 ++-------
>>   3 files changed, 22 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index e8ddf92bb185..7419466bca92 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -116,6 +116,7 @@ typedef struct VFIODevice {
>>       DeviceState *dev;
>>       int fd;
>>       int type;
>> +    bool mdev;
>>       bool reset_works;
>>       bool needs_reset;
>>       bool no_mmap;
>> @@ -231,6 +232,7 @@ void vfio_region_exit(VFIORegion *region);
>>   void vfio_region_finalize(VFIORegion *region);
>>   void vfio_reset_handler(void *opaque);
>>   struct vfio_device_info *vfio_get_device_info(int fd);
>> +void vfio_set_mdev(VFIODevice *vbasedev);
>>   bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                           AddressSpace *as, Error **errp);
>>   void vfio_detach_device(VFIODevice *vbasedev);
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index b14edd46edc9..bace0e788a09 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -675,3 +675,21 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
>>         return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
>>   }
>> +
>> +void vfio_set_mdev(VFIODevice *vbasedev)
> 
> Could you please change this routine to :
> 
>   bool vfio_device_is_mdev(VFIODevice *vbasedev)
> 
OK

>> +{
>> +    g_autofree char *tmp = NULL;
>> +    char *subsys;
> 
> a g_autofree variable is preferable here.
> 

It was a code move hence why I kept the exact same structure

I will change to your suggestion

>> +    bool is_mdev;
>> +
>> +    if (!vbasedev->sysfsdev) {
>> +        return;
>> +    }
>> +
>> +    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
>> +    subsys = realpath(tmp, NULL);
>> +    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
> 
> simply return is the result here and ....
> 
OK
>> +    free(subsys);
>> +
>> +    vbasedev->mdev = is_mdev;
>> +}
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index e03d9f3ba546..585f23a18406 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2963,12 +2963,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>       ERRP_GUARD();
>>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>>       VFIODevice *vbasedev = &vdev->vbasedev;
>> -    char *subsys;
>>       int i, ret;
>>       bool is_mdev;
>>       char uuid[UUID_STR_LEN];
>>       g_autofree char *name = NULL;
>> -    g_autofree char *tmp = NULL;
>>         if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>>           if (!(~vdev->host.domain || ~vdev->host.bus ||
>> @@ -2997,11 +2995,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>        * stays in sync with the active working set of the guest driver.  Prevent
>>        * the x-balloon-allowed option unless this is minimally an mdev device.
>>        */
>> -    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
>> -    subsys = realpath(tmp, NULL);
>> -    is_mdev = subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
>> -    free(subsys);
>> -
>> +    vfio_set_mdev(vbasedev);
>> +    is_mdev = vbasedev->mdev;
> 
> replace with :
> 
>   vbasedev->mdev = vfio_device_is_mdev(vbasedev);
> 
> and use vbasedev->mdev instead of is_mdev where needed.
> 

OK

> 
> Thanks,
> 
> C.
> 
> 
> 
> 
>>       trace_vfio_mdev(vbasedev->name, is_mdev);
>>         if (vbasedev->ram_block_discard_allowed && !is_mdev) {
> 


