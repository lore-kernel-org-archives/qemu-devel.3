Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577E9CAC59A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 00:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uz2Vp-0004dv-VV; Wed, 17 Sep 2025 20:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uz2Vm-0004dW-Nz
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 20:28:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alejandro.j.jimenez@oracle.com>)
 id 1uz2Vk-000609-2b
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 20:28:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMdAGR014297;
 Thu, 18 Sep 2025 00:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=9H9o/5Rd0VTnRtjHzmwv98aNaPHOKJJA5HlYvSqXGl0=; b=
 QtgSjoBBGs2XtCW4emXf2t86+lP9tvsdjxXS2efdssJBWr8jXN2ZM7+C7nImBfNk
 uo4MXEjRrX6oDl3hr4C7mqgLc5FstDgEgMTbHwEwr5EjdKNVbFFVATaTbvUObzpl
 7pJUDsIdOE3BUg9/uCCKcHLzwrT0qVeSDR1orRAVUj+3yfMaLPV4W9r9ZCv1QUSw
 VpVCwBIq74I03TnG5mVPDQgoLIQq13WnAwwvQg2IKraIREtzkpq5JEDlSFOaM3/p
 AxVyJk04+Z/OcAEFhLG85enWIj9NEgu+ZDdk//Ca97ffWW+RdnwRYfagt1HPllMD
 u9JYwg93ONhHOSNE82IJiQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kaf6u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 00:28:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 58HLV7k1028818; Thu, 18 Sep 2025 00:28:21 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 494y2edmyj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 18 Sep 2025 00:28:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAFk4EmoDhx9r+/23t3ltragfIXtmx/GvvfZ1sNArja08dHLvLHNjsyn40nMxjmnII5UXjUQDFSGli2IH/r6O3pvSdJRwVkijr7DshCPqvDCIx90E46caipMHL8ywcKBCOhAcobFJPf6P4/xUefBFAXwF7f2oMkkfT7tb5ayelTZoH4odbtnrx8wQDxWXvBCtJC9I1AxjhByMNV4ozZM/+F/5eg3wuNqMsJRxZkNPan97OG3hgONj+9YXqZE6UjlITIyMBB7OGCmO9NtJe+ix39Lc7y/m43wUc5/Sfu1iucM2g866XwjRY3LMNn6YSjpp19250tez4x4Sz2JhUMbIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9H9o/5Rd0VTnRtjHzmwv98aNaPHOKJJA5HlYvSqXGl0=;
 b=NA3vs753yhqG0OzU6VT5Rj/VoDq5j1N4wePY4+XDAUpCilWcz/d58aocsMt3DylW31oVixzJ6RYGvTY3+ir3LZgqzQbphOYVq61pkhO1Zf3UNOqy4yDc9l3cxudK+NbdiosGTgImwXI9uu1/rhB4DuoPIEXRV1HmeAjn6QX9oOMFPrTFfkTXFBGXJALbxVZMwkcL6ZJFQuE9Dy8d/8rjXY1p0bK39Lg0Tn73Ml3u3rACpOxM07MibnibUNWS5XNkNn5MFvgWgy7rLRVFdNnW3z6Fw/QEOTfWwq/eKym0FKagzCWfCfHnNflhXOPncWxsz7xzDZBYfSUHNKZuzCbGmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9H9o/5Rd0VTnRtjHzmwv98aNaPHOKJJA5HlYvSqXGl0=;
 b=sA10QdY+88xWRd9U/eLhn64Q3FXMnpjc+l+6BTtFPX9BoPIemiAFrN5O/HNRJoKdQPNQNyF/sfOY6y5DwGI1ZJ6b5PG+ZmhsfXvkyEJaHugHfKLmkxLsKBdVaDZMt6LdKSu16Py90G2wCyM5Jtnfhnl9rP7nOtC8AP6FManOuNU=
Received: from BLAPR10MB5041.namprd10.prod.outlook.com (2603:10b6:208:30e::6)
 by SJ5PPF25BED9404.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::794) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 00:28:19 +0000
Received: from BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4]) by BLAPR10MB5041.namprd10.prod.outlook.com
 ([fe80::2c19:641c:14b9:b1b4%4]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 00:28:18 +0000
Message-ID: <e3c5df9f-5f0b-42ae-bfa2-50dc5afcb7cb@oracle.com>
Date: Wed, 17 Sep 2025 20:28:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/20] amd_iommu: Add helper function to extract the DTE
To: Ethan MILON <ethan.milon@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20250502021605.1795985-1-alejandro.j.jimenez@oracle.com>
 <20250502021605.1795985-6-alejandro.j.jimenez@oracle.com>
 <8e6cdfc0-2c6d-4785-ae49-d0b108e48923@eviden.com>
 <fe4c0209-ae9f-4353-8ebd-8e0d6d251b2f@oracle.com>
 <ea483ab5-6cd1-455a-8dfd-ced8122a7237@eviden.com>
Content-Language: en-US
From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
In-Reply-To: <ea483ab5-6cd1-455a-8dfd-ced8122a7237@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::16) To BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5041:EE_|SJ5PPF25BED9404:EE_
X-MS-Office365-Filtering-Correlation-Id: deb0a8ec-6477-481f-02a3-08ddf64a438a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGc2N2dJcVFsWkowckRRaFpySWUvdlN6alhERG0vbnlpK25HandmUUhXeU1L?=
 =?utf-8?B?TEZBblBGUEorQmFqS1BVVzVucGFzWExqajl2cXo3eGtXc2FvSWdRRzVTVzZR?=
 =?utf-8?B?amJseHpUYmVtVkpTMjY4Y2Y4d0hBN2g3MkpvRTdvQzZtdkJGQ2VPRDBqSFBJ?=
 =?utf-8?B?bXpRWjJoUU41cTNHNXhFbHRXNVJYT0x3anV5KzFQYUt1OU9weGNVWnVFZzFU?=
 =?utf-8?B?WmJMd1Avc2hRa2dyZWVTUXU0T3dTVUUrSVUyWmo1WVBnMUlvK2hBRjY0cjBB?=
 =?utf-8?B?QUhhbHNMaXBGb3ZOQ01GNHhOb3ZpSUFNSmZZMjRLNmU1VkUzQzM2MXBSanBW?=
 =?utf-8?B?M1ZObUh2aFVNZkhaMWliSGNJVG1LSXlNTXFoRmNwU2ZZSURnQnQvRTRxR2Zx?=
 =?utf-8?B?OUY0Y1ZndGF0dURxdCtIYzhVeGpmeXJleGJodnB2cWhjQXI1TWUvZ1RTSmZY?=
 =?utf-8?B?ckkxd3dxSEZCREZOTUs1cnN4S2tHQWRRUmt0NVY1Z2JQZDZGNnF4bDJPT21u?=
 =?utf-8?B?eWw2cDlVSG1YRkllR2VUOXJLRWRodzhlVEQxYzhqamdRMVZpbU9XbWFUamtS?=
 =?utf-8?B?MHRRcVF0MlN4MUhsQnhvUUJtVWJmbEpXZ1ZaMk1jb1hZZUMyS0YxRXgydzFS?=
 =?utf-8?B?TFFwYVBYMG5DbTliellPTDZvVzlLdDNxQ0hFUmh1QkU4b3gwd0ltSlJyNHhv?=
 =?utf-8?B?MXNhcXV2V1pqaXVkZDBvQ29iWkZBSGozbUFqZm9LOEc0Qkxld3Y3VDV1c3Ir?=
 =?utf-8?B?WG00WmxVcFdFZTAvZXZvM3ZYRHNPblRjM0kxT3YrbTNIK2t5cCtRQ2V2eisy?=
 =?utf-8?B?VkhnaU1EajI5WTJmZzFZd002RWJHVnl3VXQ2OFFQSXpQaXpLUmtCakkyU1Ix?=
 =?utf-8?B?SjByR3pmc21Da3RxZU4vRHpsd21lSGZZWDFVdFhORHVjZXJkblJYbVhsUXJ0?=
 =?utf-8?B?cGtqczQ1b0k2R2dxRmo5a2ZrQ0JxRUNpTkpKLzlUK01Rdkw1L1hidWlFWndI?=
 =?utf-8?B?a3R2WXRjSEpsazZlUUptWmZIRGNTSm56aHovN1NJQTRzdC9LaVF2SXpVNVFR?=
 =?utf-8?B?S2NuV0dJc1ZUbmtneGhaTE5pZnU4RHBJb2NSSUhma2gyKzRnZ1RrbW9ZWnVr?=
 =?utf-8?B?eGpjQVlWRkxvME96NUlwZW5TbXBlY09uUmJEczhkOEw2QVdHUlJUWVRZS0kw?=
 =?utf-8?B?aG42V2tqdFBDMmxrY3pWNVBvSTFVcHpjY0RoY3hRMi9kQnZkK1g0c0NCdm5U?=
 =?utf-8?B?eDJmMEJleWZNaHdoajd1ck5xSHZQZDhNL1MzbFFtb1A1TSsxbGRYWlJ1bnN2?=
 =?utf-8?B?MDJZTThrSzQwOEMvOHN1cE1QdHNINjljQmhuakVRNFUyQzRleGJjWFlhcHhG?=
 =?utf-8?B?dVNkMFF4d2VvYUcydGNJUU5Ud2g4SHRsQWFvQ2cxcHBtWnhxZ0prbzQzZHBI?=
 =?utf-8?B?ZVpuUVBZREozTkFRdzFTQUxINllvSER2QmdWcThBZmtMOEZNQ1puVUk4RGY1?=
 =?utf-8?B?UlY0ZUZUeFlXak9iSktSeTE5eVc0Q0xGK3haU3U4RmpiNzNBZUhwUXFsdTVQ?=
 =?utf-8?B?MVVwNEloeVIxS3ZqMHYrcDRCN2gwY3NZK1JoWjc2K2E5Vk1OVjhKWHFLZzEw?=
 =?utf-8?B?RnFRb0VsbURnRlByMWI5QzFKODRZRWJlQVJZNzdKbnUwam96VVNDVHlNZGQx?=
 =?utf-8?B?MnZ6SDJXM0lKYWU0eXRrZzRNNGU2WmJLL0d6RUgwZEhWdit5ek5YVTZaK2tW?=
 =?utf-8?B?TVJCZzAzUVNHMEJpTDBxRCtqL0Y3MGhaYUlsY0pBZWFDT2NScnZzREdwV1JL?=
 =?utf-8?B?MFV4ekhPUlNoY3NVYTlDSzBZcVVHclFZYnovMkJJTU1pb1pqRVgwd2JQVmE0?=
 =?utf-8?B?MHFsZXN6bW16Yk5sRUpSajZyb2pPVGt2M2ZSam1mYm4rOENWUjByZE9YSFZP?=
 =?utf-8?Q?zRKF1GNVUsY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB5041.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym5zdGtwckVKSlFIY09paWtDejJrNk5GSFRubmtGaEpyM3VlY0Q2VzZ5Rkxt?=
 =?utf-8?B?OTd5dTRvTUFIczRyS2t3UzVicEdsRjRwTnRtTVJ1bVQ0ZXVUcnZ4d21xT3hz?=
 =?utf-8?B?MjVyMlJiK0hJN1ZjeWVwQi9lNXVGSlpJNEpibVZIMkQvY3VIOTIrb2ZNQ3Zv?=
 =?utf-8?B?eUFBRGZiMTZ6MjNlUTJZb1JXU3MxYTZWTUpBak43Y0V4NjBZRklFVzh3eS9n?=
 =?utf-8?B?N1AvQU80TzVBNjRaNUcxdHlZNUFrc2xWKzN2ZzAxMDJjeElRU2xTNk9QRERE?=
 =?utf-8?B?cnZ6OGlNaTdaVVZOeXpCVFgrYzAzdFliNmxiOWlBWS9OajVhSURSSHliLzlH?=
 =?utf-8?B?M0s2UjNsL1ZTVzRUamY3bUd6UHA3VXMzbU9WSTM2eUtqZ3dxVFhIekRQN0pQ?=
 =?utf-8?B?dkQxNmlIUjU5aUVORVBYWVdvRWlyVmlrTDE1WVV3cWsybHE2TDAvNWNBZHRi?=
 =?utf-8?B?ZlFCU3NNVll2MnpYVUpaakRPUTN4Skg1bmhtcXk0cndpRW9RbVlRRDQ5WE1u?=
 =?utf-8?B?eEJBNldiVm9XSDEyK21qS2t1cUc1TlE5Q1BzMnJDVVlUSXRYc251dDFYU2hy?=
 =?utf-8?B?V3dGMVdzTUZlVThJS1RqR01LS0NkZFpnT01HNjRJWVV5dGtKblpPNVJlWkFr?=
 =?utf-8?B?K1JmWHVPOHpNajcyVTBvUmlISWFLTjlhYUVVbzJ2WWg3cnRHWGJvNmUxNUJm?=
 =?utf-8?B?NUtpeDliRVZVcFhPb3c0V0VUaWYxRHZ3NkNWSXpmbTBjV2o3VzZqVXIxelVm?=
 =?utf-8?B?ZXA0a2tCUU1LVjh6TzgxTFdCdmszSjhMSWZUeVpVdEpTQjkvMERWbXFXNzFE?=
 =?utf-8?B?cWgrMDIxcG1JeFZVaHNCN2pDNXZrNzllcHNROUllREtJRjlacUhrdnRrOEl0?=
 =?utf-8?B?WnQ0KzEzWVlqTExweWNHYWhERUFQNFBYVGdrNmhRRVhtSmRTVkduSzNxMWp5?=
 =?utf-8?B?clV2VzNZMHBHNHFETStpWVFEbU9MWnV0RDFjaWJpc2dYdlFKWVR3RFFLSk1U?=
 =?utf-8?B?Qy8wd2lVMXNEK3NhQlFwQnh5cXNuejErRXpueXFkQ1lHVWZkckUyY3FoZm9C?=
 =?utf-8?B?dlYvRkRQYnZNcUFNblJqK1pXeHpSSXpidG8yTFp4K2hJNDRPSnhZR0VnNFZZ?=
 =?utf-8?B?dWZwK2hnTU40QllhRnZCNGI0b0FDWHhMU3VzRnFGOTVuc3hMOFBKTVdlTzJY?=
 =?utf-8?B?SmpxMXdIbmEwYXVVeTFmSVdVR2tlb1pvclE0aFZmMmo0TlY4WGFnQjJwWktW?=
 =?utf-8?B?dEhFY3daRWhXWGZpdE5oc0UxbTNiUXJPVERJeU5lWnRNWGZVbC9WUU5wM3Vt?=
 =?utf-8?B?U2JlcGRlQW11SFNteWh1NnZ5UldMblo5U3dXdjZyN2g2M1VndExBTnZTN08y?=
 =?utf-8?B?QzRlWVJDSGVRNmc4N2FPa0JFQXRtdnN4RXg0UzJUU25qNS8vQThvcHlrVHVs?=
 =?utf-8?B?aUVndmVGUVIrVUl1SndFL3NHakVmVy9xdDE5dmxnYkZWZ1JLeFZ5cEU3dnZX?=
 =?utf-8?B?cWZkMC91NDFYK0ZZb3c0YkFLemw3V0VhVVJtVXNLdUF3ZU9McWsrLzlDWmoy?=
 =?utf-8?B?cHRid21aQndmRDNJd2lGcitDQmx5WWtUWTRnR0pWVERBK3dGS0F0Q3dtN1Zl?=
 =?utf-8?B?UUEwSTU1QW5YaENnbEFsejNuNS9CRWp4U3k3YTdQbzAwWE52aW15VG5uWFdn?=
 =?utf-8?B?Y0htbnQyNnR6Yi9WLzBTellpZzVXNXNkcTRPWng5cUNUNjI5eURIaktRY0oz?=
 =?utf-8?B?WjJuMXJBRHRFd1cxS1VOSVpxVk56aVFOYk9xd2EraktEUXVGWVNsMElCZ29D?=
 =?utf-8?B?WUQyQ2ova2NieVdNb0dyRGdjbXpFN2J1ZDRoUzZmbmdaeC83SXhCd2dJQzZR?=
 =?utf-8?B?clZqdHF4SXlmUEVZTnFWYUtQRzhVYkQ2dkNwejZFbENBdkVZUGdTbTdpRitv?=
 =?utf-8?B?dGFibmZhNFArcXN2VHBqMGliaGpRL2ZjbWdRaUN0YXBEamVjY1RYd2V4eU1X?=
 =?utf-8?B?SS9UY21IOFFMSW5QSFZxTnFtT0VQQTczMDlaRVAxbWRVWUtrc1VzdzF6aCsr?=
 =?utf-8?B?RGxqN3VITVAzYzRzdVl2MjBZV2hCdmZKQjQ2UDR6R1FNWmpDRFF6OEpHRjBQ?=
 =?utf-8?B?WjZXZGtQbWNnSXVIbzcrVUlyN254UTNpZlFhcnBjSUQwR00yUnd6UDJBbFV4?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5VJvAokjdp+5ZcpqZ+hoSR/aCeasNnQ9Jop0f/9oI2u5qJlQhgDInCU0pvhnh9bOzay5xS7UEnAP5x9+EJFEDFHfs+KFe3WaTKZUy01i8CEZ472fUW/IWT681W9J9BZ1jxRAEFYIiA5dEqdMW7H+F2e9tQ8Hdiy3MauKpaHyaOCQu3GStUpX8YjjH4oHsIfoZZRsisrb5GShY40RuUEs98s5EwA9ioZqjO+T4nUnXiVafoWT4F4YEggPtBNinlSm9uQZ5/pVTzh2SAUwqP+bqyOhVh036etqhfNJ7EazVfFcj8zipMo5GNpg+8kGPkUk/kbJjyZ33sPMsri7CY/VflU2KUbEDbh4A+926PamIHZJsZwI35JC9pnVSOFEJOMweovQS7Xxe6qmbTO1GV80zlZkvVYh99I/9m1o9aa2zbYyLjSa/eGc7YlwxDmEJR9HDPfiViqk9C79p+89rR0PyPY7WKws2Jn2t+L5TuvulCE3oiMDXzai7RPEMeFhOYay/RyVs4xffPo8kc8/2T5G1LkEwfbm70Eq799yZkXAs3jAlrg+6UlGo/6yNxFsHDm74fWQm5nvXn5+/ReVL739Jn0BA2A6XELVytaqkRujsgc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb0a8ec-6477-481f-02a3-08ddf64a438a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5041.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 00:28:18.0370 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSm130IEtgXQven4+xk8p9HpZbw7GvL0HVnaWEnnBFHYXjYa85EYnXFmoHtCr15kaI9UaYottYac9j4FVOn+Ih6M7tSxLcADzmPtoIXN164=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF25BED9404
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180002
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cb5226 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=fegv8pZgJKTXPSj4wPEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EYaKoEJPDErs9u9ToBVGUMgyqdqwTFCl
X-Proofpoint-ORIG-GUID: EYaKoEJPDErs9u9ToBVGUMgyqdqwTFCl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX0TkLrqiz0+0s
 vyigVMPr9KP4JXOcXZSDEeA1FE/uftJ2J6LfFkjOIO4Xs/1gbXdCXOPKJDDs1t8SKVLSBUqxmrT
 UMNREV3jjarEB7vwsb9Po9xEltLRIvYttMvHaaF1ZN4QEBaSuptKvRwt8U3pMQWOXhMfD72AueS
 SH4fBbicRiFpD085RADzgB+GUcesSk5Co4ysJctgvjazNpMJm6qiDXs9emaLW5NphgCKBY71Vpc
 fRsR3UnKg/AzRlB+LyJsPXAGpfsMgv5xH6TLhB62y7KoXuLeEdpfnMt2m5IwFSRzrGwWI3z/TlW
 rbAcINSMlLBChTnJB/MRrDXnZ7rYh0+cJE1g+NPmbrQvnoKPpWxtYexFTa5T8OL0JdPO+iok99b
 cQBsZu3K
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=alejandro.j.jimenez@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 6/12/25 10:31 AM, Ethan MILON wrote:
> Hi,
> 
> On 5/21/25 4:49 PM, Alejandro Jimenez wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> Hi Ethan,
>>
>> On 5/20/25 6:18 AM, Ethan MILON wrote:
>>> Hi,
>>>
>>> On 5/2/25 4:15 AM, Alejandro Jimenez wrote:
>>
>>>> Extracting the DTE from a given AMDVIAddressSpace pointer structure is a
>>>> common operation required for syncing the shadow page tables. Implement a
>>>> helper to do it and check for common error conditions.
>>>>
>>
>>>> +/*
>>>> + * These 'fault' reasons have an overloaded meaning since they are not only
>>>> + * intended for describing reasons that generate an IO_PAGE_FAULT as per the AMD
>>>> + * IOMMU specification, but are also used to signal internal errors in the
>>>> + * emulation code.
>>>> + */
>>>> +typedef enum AMDVIFaultReason {
>>>> +    AMDVI_FR_DTE_RTR_ERR = 1,   /* Failure to retrieve DTE */
>>>> +    AMDVI_FR_DTE_V,             /* DTE[V] = 0 */
>>>> +    AMDVI_FR_DTE_TV,            /* DTE[TV] = 0 */
>>>> +} AMDVIFaultReason;
>>>> +
>>
>>>>
>>>> +static int amdvi_as_to_dte(AMDVIAddressSpace *as, uint64_t *dte)
>>>> +{
>>>> +    uint16_t devid = PCI_BUILD_BDF(as->bus_num, as->devfn);
>>>> +    AMDVIState *s = as->iommu_state;
>>>> +
>>>> +    if (!amdvi_get_dte(s, devid, dte)) {
>>>> +        /* Unable to retrieve DTE for devid */
>>>> +        return -AMDVI_FR_DTE_RTR_ERR;
>>>> +    }
>>>> +
>>>> +    if (!(dte[0] & AMDVI_DEV_VALID)) {
>>>> +        /* DTE[V] not set, address is passed untranslated for devid */
>>>> +        return -AMDVI_FR_DTE_V;
>>>> +    }
>>>> +
>>>> +    if (!(dte[0] & AMDVI_DEV_TRANSLATION_VALID)) {
>>>> +        /* DTE[TV] not set, host page table not valid for devid */
>>>> +        return -AMDVI_FR_DTE_TV;
>>>> +    }
>>>> +    return 0;
>>>> +}
>>>> +
>>>
>>> I'm not sure the new amdvi_as_to_dte() helper adds much. It just wraps a
>>> few checks and makes it harder to report faults properly in the future.
>>
>> I am afraid I don't understand this argument. How does it make it
>> harder? It returns 0 on success, and a negative value in case of error,
>> and the error type can be checked and handled as needed by the caller.
>>
> 
> You're right, I initially thought the amdvi_as_to_dte() helper might
> make proper fault reporting harder, but on second look, it shouldn't be
> a problem.
> 
>> The current implementation checks for 3 basic possible failures and maps
>> them to errors:
>>
>> AMDVI_FR_DTE_RTR_ERR --> This generally means something is very wrong
>>
> 
> For AMDVI_FR_DTE_RTR_ERR, would it make sense to be more specific? Right
> now, it could mean either a hardware issue or a malformed DTE. Or should
> it be split up in a future patch with proper fault reporting implemented?
> 

I am hoping we can enhance/fix error handling in a later series that 
focuses on that topic. There are already specific events defined for the 
cases you mention, and they are logged when those specific errors are 
detected in amdvi_get_dte(), so if we need to determine why 
AMDVI_FR_DTE_RTR_ERR was raised, those events will be the breadcrumbs. 
In general, the whole logging component also needs to be reviewed, and 
there is plenty to discuss in this series already.

Thank you,
Alejandro

>> AMDVI_FR_DTE_V and/or AMDVI_FR_DTE_TV i.e. V=1, TV=1 --> This is a basic
>> condition that multiple DTE fields require to be considered valid.
>>
>> Every time we need to retrieve a DTE (for current and future features)
>> we need to minimally check for those conditions.
>>
>>> Is there a reason this couldn't be handled inline?
>>
>> Discounting future uses, just by the end of the series you have 5
>> different callers of this function, that is a lot of code duplication...
>>
> 
> Ah, my mistake, I didn’t notice all the callers.
> 
> Thank,
> Ethan
> 
>> Thank you,
>> Alejandro
>>
>>
>>
>>


