Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D078CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 14:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqYeL-0000hn-Tx; Mon, 25 Aug 2025 10:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uqYe6-0000cG-4U
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:58:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1uqYdz-0004aS-Jc
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 10:58:04 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PDY2vi018428;
 Mon, 25 Aug 2025 14:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=2v+0M6XvOx3JEDpQD66sBC44OZiMYSC9M3PdKWogOCw=; b=
 L4jqqoY2d89yHZiwI3pBes+yVA5yX85ekr7KCIsnsWh1zVOvfaIqdlycsc//7GBH
 +QtKBRhv2CHSKdOwI+QRJ6dlRjD+eeJaON2kFjd4jhJZ0aF8pu3zwHU6aeWU52Py
 BcfS6pcMiqhtH2vm+EX1Y9NgOPkuU3KY8etagYXeG52OotURia4bBuslr79bef7E
 KKtEAynETfj5UYcYo2PV44qjKAsQ2zZWpfdtqBmRVjYju1DsSv4ICPK7EvRu1UCL
 a2SHuhnKlbDDVGlXd0Pes2EIjfQSNolshVWEaiv5YtJRVI00Vm3Rzllq801Y7WEG
 0RkpvIfMCLPww4QVSAmGww==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt2gmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 14:57:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57PEFaut005001; Mon, 25 Aug 2025 14:57:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48qj88juk1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Aug 2025 14:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTp1lQxWttk6vtQmCjnCZt7noJI0MeRgPpFvX1ZUxJX1sy110/jeI1w9Aad3kR2kAEIxvfU2AaOGQnVWnJYO/Tw4+DVUjyuA19DglWGgTZ8mGLWJKt+PcyPEwcxEplXemFu5sJaq2iCSGroTaW0QmyminYqfZc6xp7xSC+Scgqv/iHYdBZEaQLGPyx08cQcVYbIRQ+mMRJ5AoAyXOg8KRc6Q0O1hi0u1aRrBd68FlI4Bew8EYbJ3JpKGUzwhfUuV0GgwfUkz3uoI/0BcbHnnyM6/+uTAifLc0loIWy5fiLNtShU2lOaEyYED0U3vn7ormV1qHmOmjlwr+tSq9jkvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2v+0M6XvOx3JEDpQD66sBC44OZiMYSC9M3PdKWogOCw=;
 b=UityJmAziVGt/QErtQZYCzJvKxglfpi09sMduoExMVcG7ieN6RhafwWqPcgB3S/hrPurhMlT54anymZnefBvsutD0H5LDlRKTjahM2r50N8pWDTVBkn97SuQDq6sXWjxrix4098qN11dNtO/SZO8PpMn9FZPYnpwenkmAnTQpdGMrxnC7F0iQ1QgSGH+ACewSixni5t9H+SGj8/j5QCj1quwNFn+cFY6fUynl2G0fn0ZNiqnPuRwi0q0u9VGtLrWnn83ByFkQaZTHSm/peSLw2gC1s6dxSqFvXfS4rUssD6eaXNlxwXLy/MBF4l2i3DNDukECJcp+ofwokLhtEELBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v+0M6XvOx3JEDpQD66sBC44OZiMYSC9M3PdKWogOCw=;
 b=I5c2AFq22eQSsnzkJlCAgASyO0NHWjBf8AzJftys1iNvjC3W9eXYWDlcPZ+ohvwXfDy2CN5O8kL9lPOWKHFRB3X+OlRVlywWYulEqnBsC+L1WN+2YSMXofzrZ3hu6nAq7/G5MD9nV94M1dlyL6lQ5mgQX7IHkJCxFQHb5Bfh5Mg=
Received: from DM6PR10MB4363.namprd10.prod.outlook.com (2603:10b6:5:21e::21)
 by BN0PR10MB4918.namprd10.prod.outlook.com (2603:10b6:408:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 14:57:52 +0000
Received: from DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6]) by DM6PR10MB4363.namprd10.prod.outlook.com
 ([fe80::999b:18e4:cc6a:7cc6%7]) with mapi id 15.20.9052.017; Mon, 25 Aug 2025
 14:57:50 +0000
Message-ID: <2764b188-a4cd-40b8-95a7-ccec775d7db9@oracle.com>
Date: Mon, 25 Aug 2025 10:57:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/6] migration: Add virtio-iterative capability
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de,
 eblake@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-2-jonah.palmer@oracle.com>
 <874iuihyxd.fsf@pond.sub.org>
 <5a8bb5ef-c500-4fac-b5fc-566408ae8ffc@oracle.com>
 <87h5xvsh9c.fsf@pond.sub.org>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <87h5xvsh9c.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To DM6PR10MB4363.namprd10.prod.outlook.com
 (2603:10b6:5:21e::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4363:EE_|BN0PR10MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 76812fff-f618-4f4f-bae7-08dde3e7c309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnBDQS92LzN4allHcVVveGFuWHBZd2hHeW5LV09tV1VNL2hldzdLZ1pYcHNn?=
 =?utf-8?B?WWw4Qk9XKzQxU0IyblNpOHVMU1hnYWNpSWtvMVFGVTlMaG9sakR0d1h3ZE4x?=
 =?utf-8?B?ZjJNcU5ERlc2VFRxb01qdVFNL0pma3ZLZUk3ZzlxSlhsaEFMVXI1R1REeXRo?=
 =?utf-8?B?MHd2akttUTBlQ2QyWVNteUF1NEVLSXBweHhDQUhxOUxJQTJqQ2Frcjg3TXBR?=
 =?utf-8?B?alBjcDZvK3JoaWZqYjhsZVJMZXVLWE5lS1hWK3hic29mRmovQWp0UXJNNmlG?=
 =?utf-8?B?TTk2SW5yMERuWEF0bWpObzdwYVNFcGhVUHlwUnBLSUVxVjNFSll4aE95dWRD?=
 =?utf-8?B?aXJBTVRRZ1VkMzNqbTlBRUdaSFBEZjJHcnM2ZTJ0OTV2UU50bzFoMkJvNW45?=
 =?utf-8?B?Z0trV3dWaHdoVGlFcHZHQlRkcGJ4dWZoUmpTSmQyNUJqUWJSUWd3U2ZNeFcy?=
 =?utf-8?B?SlhZNS9qT1ArWkhMRGdKV2cveGZEd0tqTUxabEhaZnZaVTlWRWZFM2NEY25N?=
 =?utf-8?B?V2xtVkU0MHhHQmhKSG1nckNqa1dTWGV5aU03RTFWUXVhMFgvR2dQVWJ3aUth?=
 =?utf-8?B?SUQ0b29mQjRmS1NrSEtqYXdNR2ZwVHAxVDh5bEpvVDRCbjArODNMVjJ4WWJn?=
 =?utf-8?B?VWRMaDF3SmU2WDVEM1pRWHA1NExPYlNMc0hEMkswTzhRcmJPdmQrb0FDTXZI?=
 =?utf-8?B?RkwzMjBhbk45RHhab1ZRMkdGUnVNSlVHUGNTTzBqcEttNkpuWGJLYmwyK3NT?=
 =?utf-8?B?cHErenF2cDMxVlFuK1NUWDhjcStsSThDNERsZVVPVWhSaDJDWEU4YS9DRlpo?=
 =?utf-8?B?L1BMVjNnZGpJbjZMWHdUY1cyRWRCdllyV2xBY1owaUVjbDQreTdpTUhKUXhx?=
 =?utf-8?B?QTJ0bnFiQndyOXBnUkZtMVlidkZsUU00RVBTT0ZzV2dVRmoweFByWVZsYlRX?=
 =?utf-8?B?SGJVQXRNcWFhVno0UVVkSzIxNEg3eVpSbGFQS1llQkNDNDhHNkQvajRwNGlP?=
 =?utf-8?B?ZEJDK2VuWWhCWEtZOERTdjluVk9aTjAvWWJ6dXRwaXVpQzhxMDA1WFBNcWJM?=
 =?utf-8?B?WG1NMmt2cS9jTmQwQ2JVUnMycGVrejQrTTI4QXNXc3Rxd0I5UDBKc1dpYndT?=
 =?utf-8?B?NkxDUHl4RlZSa2hDcGVBWmFpbEF2Mm1nODFjZ3lNTUlpL0tDQkxERkhGMnU2?=
 =?utf-8?B?eTZ1V2tBbHlwdE5RSDdTejdHOTJ4TndPd3BqRVVQQUpOT2YvbzVtQU85RjNQ?=
 =?utf-8?B?azluWWM3LzZZN3dLdlpUM2hOdWt1WVdidXhHZFVVeklaTWs5UE1sTVloN2Fo?=
 =?utf-8?B?Ymd4bkVyQmhQTlJpejVJa0x1Mytib2hJR1Z4eHcwelVLTFR1SUgwY2N2b3B0?=
 =?utf-8?B?MHZOUFpIditXSXlVRHV2VDQ1eU0wMXFsUVR2enBkUE51S2k2U3MwbW1LTm1l?=
 =?utf-8?B?aHNQUHlnNnBFcGhtdGd4LzBxaUI1YWFnT0E2Q29tV0FkdEtjYms2N1dUQmJS?=
 =?utf-8?B?Ym9oYlNEWlZ3ZUM0WitVWnh0OTU5RHkwQmoyM3pTSWJFSjRPb0ppRUl4TUpD?=
 =?utf-8?B?VmdKSkZsK3hNSzRYSzlLNFdURkl2RUhIL0phVEN0OE93djJMbndQR0xTZDd5?=
 =?utf-8?B?Tzh6MmVST1RqRExXTTg5K2FVR01LM1pOVk5IRjhvd3pIeUxEcGZwZlVCWEYr?=
 =?utf-8?B?UEIwNjYyblJJbjRoeVpxdCtPWlpQYklpcVlXMWVSQW1jY1ZxM01rdXdWM01U?=
 =?utf-8?B?Z3Vaamw2SEh3L0NCei9Ba3ZFaC9PUkZ5Uk43aDBzN0poUCtiUmNlT2NORFRO?=
 =?utf-8?B?enhmSDlKNkNUeDcrRGxoNkd2SzJzWkdUWVU1YktLWVZLckV1T0NSV3phY0xO?=
 =?utf-8?B?TkxFUVZ0V0VNS3c4Vk5MdkhxbmVwTDI5MGxPeFpFMGV1bERqZFdtSkczYlVM?=
 =?utf-8?Q?Fg+XsI1SlY0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB4363.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3MrbHZlSVV6ajBlRVlscVFpWTNpY3pCVk85OEdhQnNydG9tNW16UjNvYjZ0?=
 =?utf-8?B?TklxMVA5b1FNRmJmY1V4MGxLRlJzcjhzVHhnWjN5cE5ERmp4cm1WVTMrSW56?=
 =?utf-8?B?OFRlM3lIYjFZSVlEY2JlYkhJZ20rcGhiNlpwbjNvQmpXVzZyQWtLeFhzNU0z?=
 =?utf-8?B?d3RXdUJJUGRrMTZLQSsvUDhKa3NyU25QL1dsOC9iMnl5RW1DRnQ1R1poZi9p?=
 =?utf-8?B?NE1RVzNoUnAvY1lCcG1EZ0JRQlBZdjJCeUc5SzNmVy9CcHk4dHFPSndYNG0v?=
 =?utf-8?B?ai95d0pDeDhPMGZQSnVyajIwQjQyR0lSMmphaHFwT1lmRzRNWUNIRU1PRWlw?=
 =?utf-8?B?VVlUdURVZ3NKaGtGUmp0RlpiN2tHSkcwN1ZpdEpQZGo1UHlvZVNPQUVXRzZ2?=
 =?utf-8?B?ZHVwTTBwQ2p5OWlSQWFhZi9pcHptYWJnanFsMkhoM1JkM1pZTXdhR3h5YzRM?=
 =?utf-8?B?azZPWmJUR3ZaV0pDOWFkT2YxNExuVFVYdkFtNEdybk5McDZMakhFa3NPYytK?=
 =?utf-8?B?bUpDcUxOd1I3bmlaSi81OUhoZ0JzYm4vYjhSMDdtQ25wbW4xRnFmc0tMalph?=
 =?utf-8?B?RzBjQm14aEJJOEdZenpMRVZzenQyNEwyTzNwZEpIcXlXenQxNmFkTCtuT0M2?=
 =?utf-8?B?bmhrMnFFSUI0SXg4T2dSaXF5Wk9zTFRCVDcxQ01NcktxVkZWemNPeDZyNmRO?=
 =?utf-8?B?Z2ZGTUcyV3NRRjIvTDk4K2U5RUZlb3lpQS9yb3Z1RHkwdjJOd0JES3JZeHlh?=
 =?utf-8?B?ZisvQkdXaWFiU3YzckpxYjgxSjQwNUduZGxFRkZqcm9zSzRQeWhjU25QZ2tq?=
 =?utf-8?B?QjBjWHZHZmhzSmd6OE1EV0llUDl1M1BSdm54ckM4VUp4UThWaGxVbGZBdFNJ?=
 =?utf-8?B?aWNaTjRrR2U2ZGF3d0FSMzYrMXRzaFRUZjAzNjNpMVlqQ0hCZ0ROZDBzWXJm?=
 =?utf-8?B?UE96Yks3d1krUVBSQjFTNnlXOFBoMmx6Q1RGWGVKL292WGl3V1BaeElaOHBU?=
 =?utf-8?B?YVpNejJYcndoMmlhamRwTFAvQkdJM1luMk9PV2gzL2RRSVVuTkFKZG1raVV2?=
 =?utf-8?B?N1Rkemdtd3hQL0Jsd3hUbElleDViMDZDSGpzVTBKS3dVWHlGVzdjZmNGc2ZW?=
 =?utf-8?B?OTZQUjRaOVl6SnQ2dWdWb3NWMk5HQWxUS2dmNE1kMytidC9KSDljOUE5WUY3?=
 =?utf-8?B?aGRsc0QxRjNPNFRkYWs1K241bXNZUXJ0UW94M1dhekQxVDNETXdiT0lrUlZa?=
 =?utf-8?B?ekhPMkNsYzNmT0ZMTUdydndleU9ldGJmSHpMdXlvS0Z6RFFvZHlObmdxRTVY?=
 =?utf-8?B?RjZ3UllYbHZaMzc4Ly9jdzhUbXdUcThpS3JnNUJnRDVlZ1pnSTFENWJFNEtN?=
 =?utf-8?B?VFRwUHNhNEN4OHprN3lhRjg2K1BIdUpaRExZSXlCRUZVUDJwZHJUeUF6UjRy?=
 =?utf-8?B?MGQ4SS9WOG0vM0RzNUhrYjJWdVJwZFkyREZxWGxnV3NCSjdGRi9xb3NHT1B5?=
 =?utf-8?B?NURBR0NCSzVtSUFJaU1IRHNYSDhUUmpqN3A5NkNKUWoxby9sT3VnRGpnbjlm?=
 =?utf-8?B?S2lzMFI4NFp2NStSNFIxS1NUaW5LRW5rcVVxeFFYaGtqcVZ0NVd6aXZEd0Ji?=
 =?utf-8?B?Rk5EVEhBaUZNTzJRSk1NK1VudGJHRWNaTjE3b2tuWlhhRVkwY1BHTnhzeitM?=
 =?utf-8?B?R0Z3eThJaHBZclc2eEtEakpIMEJRcGVFN1oxNHoxWTB6Y3Zkb0RDVFZlazcw?=
 =?utf-8?B?Zlk1dUZCVUd4Z3AxQWNkQVNHWi9JQTVMamRreDBpWVNVd2tQVkQzWlNtY1NE?=
 =?utf-8?B?dHFyR2YvVkF2OGJIaUtUVWlJRDU0cmtiKzZ2bC9LM203RitUYUx3WFU4VXZZ?=
 =?utf-8?B?UFk5U2hFME5DbURDeWFHWmhXWGpSVlBpaTJQdkxub2l2blBVdVJQTWQyWDJX?=
 =?utf-8?B?R00rUWxIQXhnUGU1Mm5GTmw5M2M5RE90b1RNUjJVWkhFcGFtYmQ4dllidTZs?=
 =?utf-8?B?bjV0UW5Kazl2TS8rSkxZN3dCQTIxNzlEUlQwUy8wOTFoT2ZSN2FMc0QzZ1lq?=
 =?utf-8?B?ZTBSUFlpL3hlc2VvK21zU09kR3BUMUtUK1pTQlNHUTh3UHRPSUV0STdlWGJ2?=
 =?utf-8?Q?zNkluzCF+4DLTlElNzSGJMp8a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DeqaV+GtmL68EOBnWkqUHCC2n0Zs47BIvq3VI7td+rEddTBEIu9MF2rF2MLf2dpcDtrayFBlrAoGcmO0JSaiMyrvX6IRJkUmPK/hFnWmP0ZygWeR9LyIvIrRvOBczSTJc16AVACA0dS8mThF85iC9foZWM5HqMH8c3qZOTXmz9BXAG9XEC/h3zXlUkZpoCZAVBjWgou1NwQWfiUztbHJMAhJRskxY62PuO6XTWq4NikuPJOIegNSHI6OzbDKQ3A6DZWJoUU16nEI89XdRjhj8718sBJzYGkhrQUUJj+s9xf/FT/mfo/Sq1NvgU0R/NcVG6qHAXlH8WafzZPniPP1U9UMOPTgdFJt27GownNaffQDRt11a862rd3Fb0jcT5mY7zPuLX4Zlt983iALH3QpDbSOYLj8MRJGgDFUH6x/33bxAfOiV3Iy15lMS8gKtxB12nLUG2ApLBf1beleP16PmJqt2Mo+SeC5dmMHqrWW13Zj6gFyjfbpyvDNXtE4XlVcn1Cn/he+dB+V9U+jOfyutU9x8aYLFSixQcwh/l/MFkHumq8toYnYkdkzqV5qTFr1Vz88xv2pzqobtiHqyrUdt+4UlM/jFoHkfszIG7bj7DI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76812fff-f618-4f4f-bae7-08dde3e7c309
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4363.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:57:50.6977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfvJ18Guo2nmyMQli6hXzxoERQVOi3X46r4j9STXU7ut4cF2K3+HL4M3grCIXSlYJ6RqD4sDe/Pbb5fEv0wpvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4918
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_07,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508250135
X-Proofpoint-ORIG-GUID: hEkKnqiz8kJ2xsDJKgMhpy8wH-1Cjw9c
X-Proofpoint-GUID: hEkKnqiz8kJ2xsDJKgMhpy8wH-1Cjw9c
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68ac79f3 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=zu3spmGggHTAvyYcV_cA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX3DybUjD44Nze
 8mGJjnuZTevMqcnQ3mAi6yhN43XgBumWe0fedNmhUX+Mh3r8xTNjIgvHA+DINfxKeUOuuz483OR
 TZ4o+pJyrDmfEtvuSFt5JeikK3qMARdE1dmteza2MUdAMOV2sHYoumdMVwYQSmVpOZ4sKIf42H5
 3KU7xS2AOkNa0m7H3agXNQLLmiR8IadvQcNNOFw8/osAYBxnrA0bco9/wp7WjWPVFzDSSaoqIdi
 DhNRtXmvVwnclXWGVAxbwGxlIZc43sHQYTBBs78nGPbAW41nPniVeb5kRhV9X56UFEyCiS/tNMJ
 UoCqeLZuRZLUiOgp38peJzvRcZhBQetd06VK5by71ytfPRNtB0LINC3ZjwPMNq2OrWmoLRs55i3
 PRWo6Xw6eVFNBhkiZcXgQGxNY+3vtw==
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 8/25/25 8:44 AM, Markus Armbruster wrote:
> Please excuse the delay, I was on vacation.
> 
> Jonah Palmer <jonah.palmer@oracle.com> writes:
> 
>> On 8/8/25 6:48 AM, Markus Armbruster wrote:
>>> I apologize for the lateness of my review.
> 
> Late again: I was on vacation.
> 
>>> Jonah Palmer <jonah.palmer@oracle.com> writes:
>>>
>>>> Adds a new migration capability 'virtio-iterative' that will allow
>>>> virtio devices, where supported, to iteratively migrate configuration
>>>> changes that occur during the migration process.
>>>
>>> Why is that desirable?
>>
>> To be frank, I wasn't sure if having a migration capability, or even
>> have it toggleable at all, would be desirable or not. It appears though
>> that this might be better off as a per-device feature set via
>> --device virtio-net-pci,iterative-mig=on,..., for example.
> 
> See below.
> 
>> And by "iteratively migrate configuration changes" I meant more along
>> the lines of the device's state as it continues running on the source.
> 
> Isn't that what migration does always?
> 

Essentially yes, but today all of the state is only migrated at the end, 
once the source has been paused. So the final correct state is always 
sent to the destination.

If we're no longer waiting until the source has been paused and the 
initial state is sent early, then we need to make sure that any changes 
that happen is still communicated to the destination.

This RFC handles this by just re-sending the entire state again once the 
source has been paused. But of course this isn't optimal and I'm looking 
into how to better optimize this part.

>> But perhaps actual configuration changes (e.g. changing the number of
>> queue pairs) could also be supported mid-migration like this?
> 
> I don't know.
> 
>>>> This capability is added to the validated capabilities list to ensure
>>>> both the source and destination support it before enabling.
>>>
>>> What happens when only one side enables it?
>>
>> The migration stream breaks if only one side enables it.
> 
> How does it break?  Error message pointing out the misconfiguration?
> 

The destination VM is torn down and the source just reports that 
migration failed.

I don't believe the source/destination could be aware of the 
misconfiguration. IIUC the destination reads the migration stream and 
expects certain pieces of data in a certain order. If new data is added 
to the migration stream or the order has changed and the destination 
isn't expecting it, then the migration fails. It doesn't know exactly 
why, just that it read-in data that it wasn't expecting.

>> This is poor wording on my part, my apologies. I don't think it's even
>> possible to know the capabilities between the source & destination.
>>
>>>> The capability defaults to off to maintain backward compatibility.
>>>>
>>>> To enable the capability via HMP:
>>>> (qemu) migrate_set_capability virtio-iterative on
>>>>
>>>> To enable the capability via QMP:
>>>> {"execute": "migrate-set-capabilities", "arguments": {
>>>>        "capabilities": [
>>>>           { "capability": "virtio-iterative", "state": true }
>>>>        ]
>>>>     }
>>>> }
>>>>
>>>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>>>> ---
>>>>   migration/savevm.c  | 1 +
>>>>   qapi/migration.json | 7 ++++++-
>>>>   2 files changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>> index bb04a4520d..40a2189866 100644
>>>> --- a/migration/savevm.c
>>>> +++ b/migration/savevm.c
>>>> @@ -279,6 +279,7 @@ static bool should_validate_capability(int capability)
>>>>       switch (capability) {
>>>>       case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
>>>>       case MIGRATION_CAPABILITY_MAPPED_RAM:
>>>> +    case MIGRATION_CAPABILITY_VIRTIO_ITERATIVE:
>>>>           return true;
>>>>       default:
>>>>           return false;
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index 4963f6ca12..8f042c3ba5 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -479,6 +479,11 @@
>>>>   #     each RAM page.  Requires a migration URI that supports seeking,
>>>>   #     such as a file.  (since 9.0)
>>>>   #
>>>> +# @virtio-iterative: Enable iterative migration for virtio devices, if
>>>> +#     the device supports it. When enabled, and where supported, virtio
>>>> +#     devices will track and migrate configuration changes that may
>>>> +#     occur during the migration process. (Since 10.1)
>>>
>>> When and why should the user enable this?
>>
>> Well if all goes according to plan, always (at least for virtio-net).
>> This should improve the overall speed of live migration for a virtio-net
>> device (and vhost-net/vhost-vdpa).
> 
> So the only use for "disabled" would be when migrating to or from an
> older version of QEMU that doesn't support this.  Fair?
> 

Correct.

> What's the default?
> 

Disabled.

>>> What exactly do you mean by "where supported"?
>>
>> I meant if both source's Qemu and destination's Qemu support it, as well
>> as for other virtio devices in the future if they decide to implement
>> iterative migration (e.g. a more general "enable iterative migration for
>> virtio devices").
>>
>> But I think for now this is better left as a virtio-net configuration
>> rather than as a migration capability (e.g. --device
>> virtio-net-pci,iterative-mig=on/off,...)
> 
> Makes sense to me (but I'm not a migration expert).
> 
> [...]
> 


