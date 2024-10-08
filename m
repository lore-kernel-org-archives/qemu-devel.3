Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CA7CEFC42
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 19:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syFdg-0001Dt-Vc; Tue, 08 Oct 2024 15:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFdd-00017C-Bu
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:12:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1syFdZ-0004Se-GT
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:12:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498JBd9X011807;
 Tue, 8 Oct 2024 19:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=jaP8mcTZcNqlSar6bIdvLOp7+BK9M1Ao98HufyBXrak=; b=
 PiVWrxh9B1WwsTz8LFPURfZbaEawaFDwkw4e/gWYw/K0eY+iCIz135wFjylhvsbA
 89Ka+HBAYdrsXmjJnx65xdTZTlhVq5l33TAMqMbV10NSWbtSAtVlY2c86OTvI6b+
 tBquqDPrXavIIv8WCe9rGWb5IsgtZkuWi4q4tYq3h5pOitg1fcTD1Cs1YIxSvphI
 7VOpxS2gKdynUyjvVXAyWOgdVxNbU+an3wYi+PKp63fezUl/LvFZbzCR+5+HaEKz
 t77hMGyly9HNMK5VqDGVbGidzDcH9PQT7Rv+ARPdl3M9XZWjpdM66mvKyO652QY6
 oAEfR2AfRzs8sl8vwgiqTg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306een26-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:12:42 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 498IsTc4022931; Tue, 8 Oct 2024 19:12:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 422uw7kv9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 08 Oct 2024 19:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXu1jTZs4DPEbmwTSHJtjexzcrzzhSryVB2JyTovlY7k2IndEiAWe9w6RN4oGueA670b9wi0EkuVC9rUcb4nEl5tOtovus9EtZvckhfDpK8rcYoDnGUepcMDqMrBtFUPSsMql8+uo9TjtxbySnBOQhR30pxQPF1g0eoaUyvCTikuRpAJMVrPkCeHFagCJJW0rO2ErqRZueoFxJO85fCnOpXLkaLSZ0qLnI3VHiiwl4lZf8y7ZIFjgJiTkfWE0En53FHCxmxl5jW5007bzaRsdkn3V6TrQPCckjD7g+1e2HnoaWqJlAjlgxxabHI0BUetndpPY66OYO3Ar3X0OvYcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jaP8mcTZcNqlSar6bIdvLOp7+BK9M1Ao98HufyBXrak=;
 b=lR/Z7K8xFqEWEZ1biEo9emjbnMte2splXQqSjLpB0l/D1jqHaRgNTHeqHOZts9TfBKM5iZel/3+ejPP5ZqpzJIRoZ416WMbiZB/xv4mX2yRam3OW7Dv3NdJFWP0g55b0tUaLruV9DgN14YyuuqjYBOVYiQZ46ExM0a81rjzbgP8ustsQMPGmEzjTqV+gzZyvAZAJdoEnZ1DsyBrLSWQA9xkbuAW2dLvZz9Lw1D3fKVaAgAlWjR027WaIdySxWxSS+F38bq3PJUoxh67XnCXJvWiFHZVQqoRBd+HgR6ceFyKg+yib8bWrl2Tf8/3EQ435GoKNU8SIs4M0Ge+erGtsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jaP8mcTZcNqlSar6bIdvLOp7+BK9M1Ao98HufyBXrak=;
 b=xBZVslKRiElrUgwCHYRuL5wdaffA+MfzdFRcPhj6ch6GsThrd+biWnxNhXfM9sB3owkyRrTrLxw1rhdrHTyE79IWTcRi18YAQ19jMJCrohjZBfhLD8VyL9BF7PUs1yFLbj3G3RopUBwaPlQK1TrHntVItq5x6WZJizfS5FbRFVE=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS7PR10MB7180.namprd10.prod.outlook.com (2603:10b6:8:ed::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Tue, 8 Oct 2024 19:12:39 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 19:12:38 +0000
Message-ID: <5da33a31-bdcc-45ff-89c0-55b8ab08954b@oracle.com>
Date: Tue, 8 Oct 2024 15:12:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n> <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <ZwVTgl9t3KButBDs@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZwVTgl9t3KButBDs@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0115.namprd05.prod.outlook.com
 (2603:10b6:a03:334::30) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS7PR10MB7180:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d68f72-2cb4-439b-4499-08dce7cd2c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGZVMEhhNkloZWh1TlBuaVJ3b2xyTWhYM3M3T3dYTXBSKy9pL3Bsblprdzgz?=
 =?utf-8?B?dVRGUjVwZzRyUmxuYkRvSzhnZjZLR0tHc0RyU2Q4UHI5R3J6a3JiQXp2dUNH?=
 =?utf-8?B?eGRZaXlpODFaajlRa3JERjNYR29aMDRXcTVIRWhMaTNlQlIvYmxHL1grNUk2?=
 =?utf-8?B?dEZVLzY3NGYrSEtPU3Z6Z3laaVAxR2tuSGdrTlEyUzBlWjhlaFMzbUJSL3lz?=
 =?utf-8?B?TlkrZHZ0KzRYRnVlZ0V5RE9kY1d2RGxHaHBsbE5TVXpWWS9Nb21FVEZQNWF2?=
 =?utf-8?B?Wk9INTl2ekwxQzMvMVhEYVA5V0g1SjVuWmRLTkcvSThhNnNPRG1GZ3p1L1dm?=
 =?utf-8?B?aVk3VGt6dmVSbllGNmM3bngxZHZXVTdLZEh4ajZEa09WWjZoVmFwV085Q0Zx?=
 =?utf-8?B?TlpCNGJ1dEF4aTgzV0JUcDhtbnFObVRPNG0rRkErSkdoMllneitmTTArQWxs?=
 =?utf-8?B?bXdsTkw0aTBSTHMvMG12aTgxbmRjSThMbmtkUXArT011UUZ3TFNGQ2cwdk5J?=
 =?utf-8?B?YUlDZDBCMXJodmRMMEQwOFB1L3VOTkc2ZVAvQVhWejdndW4wS1A5eWtoRkRJ?=
 =?utf-8?B?ZjFUSzdKTEtnNDlPYVRsYlk2aTlCSFNwOHZUa3lJbDBGMkRBTURWbC9oUVFY?=
 =?utf-8?B?NUxwNy9rdjN2YVQ1Y1lsYlZHWVpYK2o1eFR5NE5uM3NrNURNZ245RjNnQklV?=
 =?utf-8?B?M2t2ZzBmZmdvbzhSTm1rSHhWek5qa3o3Z1RXbXkxVUFZclBTTnp3bk9pY2VR?=
 =?utf-8?B?ME1BcWd5TXZOQlR2OFJ6VVJYYlN6RGlsRGszQ0pOdFdTRWN0Zm4xbndlNVBy?=
 =?utf-8?B?TGlNTXhRL0FHNlRkdE9yeVpKUXpUYkVsTzYwTWp0L0tzNHZvVjBKa00rUDFV?=
 =?utf-8?B?SzVkMzh4QytDeENiNldKSDh6aDJaWWp6TDMveWNUcDRKVmQ4Vmg2QmY1bmN6?=
 =?utf-8?B?cko0Qnd6WCt5TXNCaTFtZEp2MFJhQjJMR0ZjRkNyMlZUU3VXdUoxS0ZYY3N3?=
 =?utf-8?B?bHg1Q3ZMMjBQZDlFTEFjNmZHd0hPZVd0UXBUQU1KVC9EM1dJN0VGNUxlMmxt?=
 =?utf-8?B?ZWdoUVBzUlNVV3NxL0MyL1BhOWRoL3lldUUxcjhIRnpVT2FPTGc5c0NJSndu?=
 =?utf-8?B?bHZjallJMDVDQVNRcUpEaGdLOUhUTjR2TFcyaVpzcWNGcUFoOUxrMVFyY0c1?=
 =?utf-8?B?SUJGZG1hRXU4OGhHVmdXKzZBUys2emhjMEpEVGZRVUw4bmlaZVNHaEdsWmh5?=
 =?utf-8?B?WmVadjRjSHMvYW92ckFtbEd1UkdnNFQ1eWMyZ3kzTU13Q0M2ZmNhWHJrRUY0?=
 =?utf-8?B?a2NUYk1TOS85a0w5d3dhVmJhWmxHNjQ5Nmpsa1ZkRVI3eExsTFFhQVlEcHB1?=
 =?utf-8?B?U2pUejBuQS9IeGcwZzl6WWFnbjc1aEY2UHVZZ3VKbExCSnQ4QWRoMWplY3Nw?=
 =?utf-8?B?d2F0cXRqS1lzRW5pRzIraWhXeExGellJR2Y0NFZzUzlLWC9KZzlhR2JBaTFn?=
 =?utf-8?B?SXBuMkw2VmdQckRkUzNmTUw3dHZnQlZKK0VRcnRPRzlJWnZ3OEhXQnF6TWxZ?=
 =?utf-8?B?bGczMmozbURQbXloblZrY2F5U2wwOXdhdkZtNlNmbE43Q0JnaXpNMUcrTzJZ?=
 =?utf-8?B?c1VvQVpuaFFiUlBZbXZHdjdQSVBuallKZW5kSGgwVm9jRGNINjZJT0N2QnRu?=
 =?utf-8?B?TmVvQlk5Wm5oUEFVVUpJMUU0SEliQlFyUVdIMHJ2UGtDblU2K2VTbTlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE5FSmZqa0FtdDBaRTFuWVNnaW9BUlpVQ3dEbWc1eFVteVlmeUlDcG05U1hW?=
 =?utf-8?B?K003WFl0a0FPZkVkMmd3SW1PM1AyYTZpdnFxME4yQUoxQ3N6NWtmZHdIbjlk?=
 =?utf-8?B?eGFTa2lXaEgybXR6RkdCZGhPOWRtMnQrVmkzSGxhRmxkdjRpU2owQnFJdy9a?=
 =?utf-8?B?K1p0dXJ3TWpwMjNuL3NUSXlHeEd0NXNzOXVocFBtN2tGeGVHR0dyeGJLLzZD?=
 =?utf-8?B?K0VqMTh6YmRMRnhpMzJuRHpoOXhydUFSVnVkT2NFSklaOWYwOWZ2dTg2akFJ?=
 =?utf-8?B?RzhvR1piUHliUFhZRHAwUHZsNGsrSDhXWmtwR1EwbTVjaGZQMHdtNWJGRVFq?=
 =?utf-8?B?SGFlL210Z1VrY3VtakwzUUxmbE8xeG5GSGYzM1lhUDI2TXhuQmNUL0VkUW4x?=
 =?utf-8?B?b1ZiZUl2M0JkUzZxcFlKQ29pdXNWanNhSW5WditjUFBUMWlFbXB3QXdrbFlE?=
 =?utf-8?B?dUFydFM3anIrU3JBZEZIRnB3eW94dTAxU0xpdkt5MmxmUmlSUVo2cmxya2FI?=
 =?utf-8?B?QStlYzVhY1B3aGRUL0pIVXZaY3F2MHh4a3hyYUFubGYxcE1TRmZ4VzB5VGl6?=
 =?utf-8?B?NWRabm83K3ZvTXBULzhDekZMKzhvelo5R2FGMXhxTlFWcEhkZ0ZZTkk3TDV2?=
 =?utf-8?B?NkFtVitMcjF6aXdBalFydHVQbmdBR1h1cndiaGpWeUtWS1l2MUhoa2tWSDNF?=
 =?utf-8?B?NHMrUmIzSks2ZHFRaFdZRTEwUU14TlVkdTJlUHYweGRoV2dXZnkrMVhaL29j?=
 =?utf-8?B?QTRSc080N2t2NEl0bGhIU2JXcW9iNDk1RU1YTWpuaE9tM0hzWkc4dFM0L2tz?=
 =?utf-8?B?aWwwdmJYNWlOUEZYY2VWL3NIUmtYbm04UFlDYXNmc2dHMnhSZzRtUEFJeG5F?=
 =?utf-8?B?T3o1K3R6N1FpZ1hMODdobXJpMjJNYURDMmQyWkNrVVJwQnMySC9wTzFWdUNs?=
 =?utf-8?B?WDFuRG5jZzh6NkhJV1VRa0h5cGwvZm1JdndHanFIQldRYkRJUVN1T0tXYm1P?=
 =?utf-8?B?ZVVBVHhkOUY4K2poVGRRWGZlOEdZYlNEY0NEc2N3eGtyRXBBYXV4RUYyVCtD?=
 =?utf-8?B?MU5ENzlJbStNUTNxK0NJWE5xdzYvbSs1bzAwOWl1SDNXcUdDREhCNFNDYmJh?=
 =?utf-8?B?STJlMFBEaExjRzlEeHRRRVliVmUvOW1zbjVwVjJkaVV5RXIrVmNHMzVLUm51?=
 =?utf-8?B?Y1NrQXA3YS9wL0hVQzBzSGVDb0VaSVlvTjhTcWVkV3BRa3JKc0hoYzJ4YTEv?=
 =?utf-8?B?K1ZmZmYvZVMyT3plM0RZRkpJMWxJUStpU0Q2KzNiV3VUdGRUSFFad24ySkVL?=
 =?utf-8?B?dm0zVmNmb05jajZvOXQzMWpCZFNjMVFLYnFtWnlsR1NvRVoxeTZCODV2eDVq?=
 =?utf-8?B?MTZ4dnRlTFVwb1lGaW9Fd29vd3NhaWN4dmRiTm5OYUlYQWZMY1FoVzJUUnVJ?=
 =?utf-8?B?OTdxRVVWSzNNZE5qOHhPa1dHU2prNTNkYVRxR3J5a08vZTZiR2xGYU92WkFK?=
 =?utf-8?B?YU1mbXJyTDhxdW4ra3dPa0tERGFtSjJMMEFwOU5QWjV6cExEdEQwVWtvVUxq?=
 =?utf-8?B?YWpnbFZxYVlsVE5FYnV0MjhlZW0ybTlCTjBUc1pZeVF5aEVIWk9mRk5kYVNV?=
 =?utf-8?B?cGdGZ1VVQVRreS9HTnNBM0ZUaFdrL2ZBbUFnclg1R0FBaDcxRHNaNmswK29N?=
 =?utf-8?B?NTVQVE1FcHdlQk5ORW82SlR4YUxSRkoxdFg0RVhteWxodFpYNnNlN25BbE9y?=
 =?utf-8?B?MVduVEVteVAvUGtGaWl0Q1BsQTJVWE5paGUraEwraEZac01QTklTVnNTY0k4?=
 =?utf-8?B?bHVmeCsxMTZtdGY5VUpwN0JJV1pXcDdDaEN1WG1HOUYzTTlzL3hzTkpoL3J3?=
 =?utf-8?B?cldvZlh0QTZDbGFGM1hTaEE1cG9CMkRRMDF2K3lDSjlwR2FpOW5pNFl4RWJV?=
 =?utf-8?B?TDBmSkowM0FHRndsaGsxWkhOTXduT1o1OFkrYWNheE10ekJKZUdWbm15RXVm?=
 =?utf-8?B?Y090VzhCNTdQd0RodlFTeVZINFVkUDRQRk1SY2RmaGRxcGFvcmZIZ0tQZ0Nz?=
 =?utf-8?B?ZS9SRFdodkE5QkJCOEZnWW5qZThTUGtuZXROdnNsSTdlU0VraTZ4OXRVaWVO?=
 =?utf-8?B?emNReWw0NGwxWHYvd0RJN3hiTVo4dlpjazJraEhVSDdoM3p5a3doUC9BUWlO?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fTboHgFS9Vxgeu16XXyg9Ki9TEI3A1QNHz6NlKNWc/o1hXBnAga/r15oiERPXO89Pr9sbG4rfYdSTdUJGOoOKrj8MQZlKL0/WffqZBMCMEOUen2iHLIde9wONLFeJUuUUAfk+8/JXBkUpI9GeM6Z2fjkkDu3zMXVxAsb0vr92+nkUhzIU/n2KNtcY30KcSwt85v8kvKpRm5tvr3zTvzfJUYFFXVFa4tzjeHWxC8GxJ8tyLdM5yUoVKibZcSSKbLx0MZ2cexlIyu1Qe6OsNsuCKZMKd9gostBumeBPIJ+9FkFa7CcVEWPDP/8RzwOt5zddJsT+9AJQap7IhBYONLi5KXkbLlZ7dAW85hXUkJVX7pjjxEh/QiUJ9N4JoI9u5Vx7wGx7tnI1YtTCLTyrPKT9gY5JMx8E0jl8Ib8Q0YF2CRrv8RXoU7jZljHRt5yd3GbRiu21U9iGEIVaZnfYsqJOFrrPnjMvsAIkXcD+g1vVt5lm/slpZ3KDDt9rOiB/lPA6k5ZfsWLV+kbiiVS6oSZwCUP/XQFEGZTbhYrTGnGgzyUuY2+C65/x9ldymUo0ti5THTD5w83gtN6HO26DHfNcIonirFNWyR/vudSSUf3oEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d68f72-2cb4-439b-4499-08dce7cd2c7f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 19:12:38.3148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTAS7/rW2RV+N7wCisJyH49Yr1rCsjO53hDAPXsm5dU2y5Taicch6Ih+K3CjmhM9QGearl9Z2mx/SJMyGuxmFPuJu8CrBBsJgjHXXsDxU0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_17,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080123
X-Proofpoint-GUID: 1mRUZx7E6bMCqJgF45JWHy-egogJQoUb
X-Proofpoint-ORIG-GUID: 1mRUZx7E6bMCqJgF45JWHy-egogJQoUb
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/8/2024 11:45 AM, Peter Xu wrote:
> On Mon, Oct 07, 2024 at 04:39:25PM -0400, Steven Sistare wrote:
>> On 10/7/2024 3:44 PM, Peter Xu wrote:
>>> On Mon, Sep 30, 2024 at 12:40:44PM -0700, Steve Sistare wrote:
>>>> Add the cpr-transfer migration mode.  Usage:
>>>>     qemu-system-$arch -machine anon-alloc=memfd ...
>>>>
>>>>     start new QEMU with "-incoming <uri-1> -cpr-uri <uri-2>"
>>>>
>>>>     Issue commands to old QEMU:
>>>>     migrate_set_parameter mode cpr-transfer
>>>>     migrate_set_parameter cpr-uri <uri-2>
>>>>     migrate -d <uri-1>
>>>>
>>>> The migrate command stops the VM, saves CPR state to uri-2, saves
>>>> normal migration state to uri-1, and old QEMU enters the postmigrate
>>>> state.  The user starts new QEMU on the same host as old QEMU, with the
>>>> same arguments as old QEMU, plus the -incoming option.  Guest RAM is
>>>> preserved in place, albeit with new virtual addresses in new QEMU.
>>>>
>>>> This mode requires a second migration channel, specified by the
>>>> cpr-uri migration property on the outgoing side, and by the cpr-uri
>>>> QEMU command-line option on the incoming side.  The channel must
>>>> be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>
>>>> Memory-backend objects must have the share=on attribute, but
>>>> memory-backend-epc is not supported.  The VM must be started with
>>>> the '-machine anon-alloc=memfd' option, which allows anonymous
>>>> memory to be transferred in place to the new process.  The memfds
>>>> are kept open by sending the descriptors to new QEMU via the
>>>> cpr-uri, which must support SCM_RIGHTS, and they are mmap'd
>>>> in new QEMU.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>    include/migration/cpr.h   |  1 +
>>>>    migration/cpr.c           | 34 +++++++++++++++++++----
>>>>    migration/migration.c     | 69 +++++++++++++++++++++++++++++++++++++++++++++--
>>>>    migration/migration.h     |  2 ++
>>>>    migration/ram.c           |  2 ++
>>>>    migration/vmstate-types.c |  5 ++--
>>>>    qapi/migration.json       | 27 ++++++++++++++++++-
>>>>    stubs/vmstate.c           |  7 +++++
>>>>    8 files changed, 137 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>>> index e886c98..5cd373f 100644
>>>> --- a/include/migration/cpr.h
>>>> +++ b/include/migration/cpr.h
>>>> @@ -30,6 +30,7 @@ int cpr_state_save(Error **errp);
>>>>    int cpr_state_load(Error **errp);
>>>>    void cpr_state_close(void);
>>>>    struct QIOChannel *cpr_state_ioc(void);
>>>> +bool cpr_needed_for_reuse(void *opaque);
>>>>    QEMUFile *cpr_transfer_output(const char *uri, Error **errp);
>>>>    QEMUFile *cpr_transfer_input(const char *uri, Error **errp);
>>>> diff --git a/migration/cpr.c b/migration/cpr.c
>>>> index 86f66c1..911b556 100644
>>>> --- a/migration/cpr.c
>>>> +++ b/migration/cpr.c
>>>> @@ -9,6 +9,7 @@
>>>>    #include "qapi/error.h"
>>>>    #include "migration/cpr.h"
>>>>    #include "migration/misc.h"
>>>> +#include "migration/options.h"
>>>>    #include "migration/qemu-file.h"
>>>>    #include "migration/savevm.h"
>>>>    #include "migration/vmstate.h"
>>>> @@ -57,7 +58,7 @@ static const VMStateDescription vmstate_cpr_fd = {
>>>>            VMSTATE_UINT32(namelen, CprFd),
>>>>            VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>>>>            VMSTATE_INT32(id, CprFd),
>>>> -        VMSTATE_INT32(fd, CprFd),
>>>> +        VMSTATE_FD(fd, CprFd),
>>>>            VMSTATE_END_OF_LIST()
>>>>        }
>>>>    };
>>>> @@ -174,9 +175,16 @@ int cpr_state_save(Error **errp)
>>>>    {
>>>>        int ret;
>>>>        QEMUFile *f;
>>>> +    MigMode mode = migrate_mode();
>>>> -    /* set f based on mode in a later patch in this series */
>>>> -    return 0;
>>>> +    if (mode == MIG_MODE_CPR_TRANSFER) {
>>>> +        f = cpr_transfer_output(migrate_cpr_uri(), errp);
>>>> +    } else {
>>>> +        return 0;
>>>> +    }
>>>> +    if (!f) {
>>>> +        return -1;
>>>> +    }
>>>>        qemu_put_be32(f, QEMU_CPR_FILE_MAGIC);
>>>>        qemu_put_be32(f, QEMU_CPR_FILE_VERSION);
>>>> @@ -205,8 +213,18 @@ int cpr_state_load(Error **errp)
>>>>        uint32_t v;
>>>>        QEMUFile *f;
>>>> -    /* set f based on mode in a later patch in this series */
>>>> -    return 0;
>>>> +    /*
>>>> +     * Mode will be loaded in CPR state, so cannot use it to decide which
>>>> +     * form of state to load.
>>>> +     */
>>>> +    if (cpr_uri) {
>>>> +        f = cpr_transfer_input(cpr_uri, errp);
>>>> +    } else {
>>>> +        return 0;
>>>> +    }
>>>> +    if (!f) {
>>>> +        return -1;
>>>> +    }
>>>>        v = qemu_get_be32(f);
>>>>        if (v != QEMU_CPR_FILE_MAGIC) {
>>>> @@ -243,3 +261,9 @@ void cpr_state_close(void)
>>>>            cpr_state_file = NULL;
>>>>        }
>>>>    }
>>>> +
>>>> +bool cpr_needed_for_reuse(void *opaque)
>>>> +{
>>>> +    MigMode mode = migrate_mode();
>>>> +    return mode == MIG_MODE_CPR_TRANSFER;
>>>> +}
>>>
>>> Drop it until used?
>>
>> Maybe, but here is my reason for including it here.
>>
>> These common functions like cpr_needed_for_reuse and cpr_resave_fd are needed
>> by multiple follow-on series: vfio, tap, iommufd.  To send those for comment,
>> as I have beem, I need to prepend a patch for cpr_needed_for_reuse to each of
>> those series, which is redundant.  It makes more sense IMO to include them in
>> this initial series.
>>
>> But, it's your call.
> 
> Hmm, logically we shouldn't keep any dead code in QEMU, but indeed this is
> slightly special.
> 
> Would you mind keeping all these helpers in a separate patch after the base
> patches?  The commit message should describe what future projects will
> start to use it, then whoever noticed later (I at least know Dave has quite
> a few patches recently removing dead code in QEMU) will know that's
> potentially to-be-used code, so should keep them around.

I have split the functions into a separate patch.
I'll hold onto it until posting the next series, no big deal.

>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index 3301583..73b85aa 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -76,6 +76,7 @@
>>>>    static NotifierWithReturnList migration_state_notifiers[] = {
>>>>        NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
>>>>        NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
>>>> +    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_TRANSFER),
>>>>    };
>>>>    /* Messages sent on the return path from destination to source */
>>>> @@ -109,6 +110,7 @@ static int migration_maybe_pause(MigrationState *s,
>>>>    static void migrate_fd_cancel(MigrationState *s);
>>>>    static bool close_return_path_on_source(MigrationState *s);
>>>>    static void migration_completion_end(MigrationState *s);
>>>> +static void migrate_hup_delete(MigrationState *s);
>>>>    static void migration_downtime_start(MigrationState *s)
>>>>    {
>>>> @@ -204,6 +206,12 @@ migration_channels_and_transport_compatible(MigrationAddress *addr,
>>>>            return false;
>>>>        }
>>>> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
>>>> +        addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
>>>> +        error_setg(errp, "Migration requires streamable transport (eg unix)");
>>>> +        return false;
>>>> +    }
>>>> +
>>>>        return true;
>>>>    }
>>>> @@ -316,6 +324,7 @@ void migration_cancel(const Error *error)
>>>>            qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
>>>>        }
>>>>        migrate_fd_cancel(current_migration);
>>>> +    migrate_hup_delete(current_migration);
>>>>    }
>>>>    void migration_shutdown(void)
>>>> @@ -718,6 +727,9 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
>>>>        } else {
>>>>            error_setg(errp, "unknown migration protocol: %s", uri);
>>>>        }
>>>> +
>>>> +    /* Close cpr socket to tell source that we are listening */
>>>> +    cpr_state_close();
>>>
>>> Would it be possible to use some explicit reply message to mark this?
>>
>> In theory yes, but I fear that using a return channel with message parsing and
>> dispatch adds more code than it is worth.
>>
>>> So
>>> far looks like src QEMU will continue with qmp_migrate_finish() even if the
>>> cpr channel was closed due to error.
>>
>> Yes, but we recover just fine.  The target hits some error, fails to read all the
>> cpr state, closes the channel prematurely, and does *not* create a listen socket
>> for the normal migration channel.  Hence qmp_migrate_finish fails to connect to the
>> normal channel, and recovers.
> 
> This is slightly tricky part and would be nice to be documented somewhere,
> perhaps starting from in the commit message.

I will extend the block comment in qmp_migrate:

     /*
      * For cpr-transfer, the target may not be listening yet on the migration
      * channel, because first it must finish cpr_load_state.  The target tells
      * us it is listening by closing the cpr-state socket.  Wait for that HUP
      * event before connecting in qmp_migrate_finish.
      *
      * The HUP could occur because the target fails while reading CPR state,
      * in which case the target will not listen for the incoming migration
      * connection, so qmp_migrate_finish will fail to connect, and then recover.
      */

> Then the error will say "failed to connect to destination QEMU" hiding the
> real failure (cpr save/load failed), right?  That's slightly a pity.

Yes, but destination qemu will also emit a more specific message.

> I'm OK with the HUP as of now, but if you care about accurate CPR-stage
> error reporting, then feel free to draft something else in the next post.

I'll think about it, but to get cpr into 9.2, this will probably need to be
deferred as a future enhancement.

>>> I still didn't see how that kind of issue was captured below [1] (e.g., cpr
>>> channel broken after sending partial fds)?
>>
>> Same as above.
>>
>>>>    }
>>>>    static void process_incoming_migration_bh(void *opaque)
>>>> @@ -1414,6 +1426,8 @@ static void migrate_fd_cleanup(MigrationState *s)
>>>>        s->vmdesc = NULL;
>>>>        qemu_savevm_state_cleanup();
>>>> +    cpr_state_close();
>>>> +    migrate_hup_delete(s);
>>>>        close_return_path_on_source(s);
>>>> @@ -1698,7 +1712,9 @@ bool migration_thread_is_self(void)
>>>>    bool migrate_mode_is_cpr(MigrationState *s)
>>>>    {
>>>> -    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
>>>> +    MigMode mode = s->parameters.mode;
>>>> +    return mode == MIG_MODE_CPR_REBOOT ||
>>>> +           mode == MIG_MODE_CPR_TRANSFER;
>>>>    }
>>>>    int migrate_init(MigrationState *s, Error **errp)
>>>> @@ -2033,6 +2049,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>>>            return false;
>>>>        }
>>>> +    if (migrate_mode() == MIG_MODE_CPR_TRANSFER &&
>>>> +        !s->parameters.cpr_uri) {
>>>> +        error_setg(errp, "cpr-transfer mode requires setting cpr-uri");
>>>> +        return false;
>>>> +    }
>>>> +
>>>>        if (migration_is_blocked(errp)) {
>>>>            return false;
>>>>        }
>>>> @@ -2076,6 +2098,37 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>>>    static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>>>>                                   Error **errp);
>>>> +static void migrate_hup_add(MigrationState *s, QIOChannel *ioc, GSourceFunc cb,
>>>> +                            void *opaque)
>>>> +{
>>>> +        s->hup_source = qio_channel_create_watch(ioc, G_IO_HUP);
>>>> +        g_source_set_callback(s->hup_source, cb, opaque, NULL);
>>>> +        g_source_attach(s->hup_source, NULL);
>>>> +}
>>>> +
>>>> +static void migrate_hup_delete(MigrationState *s)
>>>> +{
>>>> +    if (s->hup_source) {
>>>> +        g_source_destroy(s->hup_source);
>>>> +        g_source_unref(s->hup_source);
>>>> +        s->hup_source = NULL;
>>>> +    }
>>>> +}
>>>> +
>>>> +static gboolean qmp_migrate_finish_cb(QIOChannel *channel,
>>>> +                                      GIOCondition cond,
>>>> +                                      void *opaque)
>>>> +{
>>>> +    MigrationAddress *addr = opaque;
>>>
>>> [1]
>>>
>>>> +
>>>> +    qmp_migrate_finish(addr, false, NULL);
>>>> +
>>>> +    cpr_state_close();
>>>> +    migrate_hup_delete(migrate_get_current());
>>>> +    qapi_free_MigrationAddress(addr);
>>>> +    return G_SOURCE_REMOVE;
>>>> +}
>>>> +
>>>>    void qmp_migrate(const char *uri, bool has_channels,
>>>>                     MigrationChannelList *channels, bool has_detach, bool detach,
>>>>                     bool has_resume, bool resume, Error **errp)
>>>> @@ -2136,7 +2189,19 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>>            goto out;
>>>>        }
>>>> -    qmp_migrate_finish(addr, resume_requested, errp);
>>>> +    /*
>>>> +     * For cpr-transfer, the target may not be listening yet on the migration
>>>> +     * channel, because first it must finish cpr_load_state.  The target tells
>>>> +     * us it is listening by closing the cpr-state socket.  Wait for that HUP
>>>> +     * event before connecting in qmp_migrate_finish.
>>>> +     */
>>>> +    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER) {
>>>> +        migrate_hup_add(s, cpr_state_ioc(), (GSourceFunc)qmp_migrate_finish_cb,
>>>> +                        QAPI_CLONE(MigrationAddress, addr));
>>>> +
>>>> +    } else {
>>>> +        qmp_migrate_finish(addr, resume_requested, errp);
>>>> +    }
>>>>    out:
>>>>        if (local_err) {
>>>> diff --git a/migration/migration.h b/migration/migration.h
>>>> index 38aa140..74c167b 100644
>>>> --- a/migration/migration.h
>>>> +++ b/migration/migration.h
>>>> @@ -457,6 +457,8 @@ struct MigrationState {
>>>>        bool switchover_acked;
>>>>        /* Is this a rdma migration */
>>>>        bool rdma_migration;
>>>> +
>>>> +    GSource *hup_source;
>>>>    };
>>>>    void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>>>> diff --git a/migration/ram.c b/migration/ram.c
>>>> index 81eda27..e2cef50 100644
>>>> --- a/migration/ram.c
>>>> +++ b/migration/ram.c
>>>> @@ -216,7 +216,9 @@ static bool postcopy_preempt_active(void)
>>>>    bool migrate_ram_is_ignored(RAMBlock *block)
>>>>    {
>>>> +    MigMode mode = migrate_mode();
>>>>        return !qemu_ram_is_migratable(block) ||
>>>> +           mode == MIG_MODE_CPR_TRANSFER ||
>>>>               (migrate_ignore_shared() && qemu_ram_is_shared(block)
>>>>                                        && qemu_ram_is_named_file(block));
>>>>    }
>>>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>>>> index 6e45a4a..b5a55b8 100644
>>>> --- a/migration/vmstate-types.c
>>>> +++ b/migration/vmstate-types.c
>>>> @@ -15,6 +15,7 @@
>>>>    #include "qemu-file.h"
>>>>    #include "migration.h"
>>>>    #include "migration/vmstate.h"
>>>> +#include "migration/client-options.h"
>>>>    #include "qemu/error-report.h"
>>>>    #include "qemu/queue.h"
>>>>    #include "trace.h"
>>>> @@ -321,7 +322,7 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>>>>    {
>>>>        int32_t *v = pv;
>>>>        qemu_get_sbe32s(f, v);
>>>> -    if (*v < 0) {
>>>> +    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
>>>>            return 0;
>>>>        }
>>>>        *v = qemu_file_get_fd(f);
>>>> @@ -334,7 +335,7 @@ static int put_fd(QEMUFile *f, void *pv, size_t size,
>>>>        int32_t *v = pv;
>>>>        qemu_put_sbe32s(f, v);
>>>> -    if (*v < 0) {
>>>> +    if (*v < 0 || migrate_mode() != MIG_MODE_CPR_TRANSFER) {
>>>
>>> So I suppose you wanted to guard VMSTATE_FD being abused.  Then I wonder
>>> whether it'll help more by adding a comment above VMSTATE_FD instead; it'll
>>> be more straightforward to me.
>>>
>>> And if you want to fail hard, assert should work better too in runtime, or
>>> the "return 0" can be pretty hard to notice.
>>
>> No, this code is not about detecting abuse or errors.  It is there to skip
>> the qemu_file_put_fd for cpr-exec mode.  In my next version this function will
>> simply be:
>>
>> static int put_fd(QEMUFile *f, void *pv, size_t size,
>>                    const VMStateField *field, JSONWriter *vmdesc)
>> {
>>      int32_t *v = pv;
>>      return qemu_file_put_fd(f, *v);
>> }
> 
> Great, thanks.
> 
>>
>>>>            return 0;
>>>>        }
>>>>        return qemu_file_put_fd(f, *v);
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index c0d8bcc..f51b4cb 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -611,9 +611,34 @@
>>>>    #     or COLO.
>>>>    #
>>>>    #     (since 8.2)
>>>> +#
>>>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>>>> +#     new QEMU instance on the same host with minimal guest pause
>>>> +#     time, by preserving guest RAM in place, albeit with new virtual
>>>> +#     addresses in new QEMU.
>>>> +#
>>>> +#     The user starts new QEMU on the same host as old QEMU, with the
>>>> +#     the same arguments as old QEMU, plus the -incoming option.  The
>>>> +#     user issues the migrate command to old QEMU, which stops the VM,
>>>> +#     saves state to the migration channels, and enters the
>>>> +#     postmigrate state.  Execution resumes in new QEMU.  Guest RAM is
>>>> +#     preserved in place, albeit with new virtual addresses in new
>>>> +#     QEMU.  The incoming migration channel cannot be a file type.
>>>> +#
>>>> +#     This mode requires a second migration channel, specified by the
>>>> +#     cpr-uri migration property on the outgoing side, and by
>>>> +#     the cpr-uri QEMU command-line option on the incoming
>>>> +#     side.  The channel must be a type, such as unix socket, that
>>>> +#     supports SCM_RIGHTS.
>>>> +#
>>>> +#     Memory-backend objects must have the share=on attribute, but
>>>> +#     memory-backend-epc is not supported.  The VM must be started
>>>> +#     with the '-machine anon-alloc=memfd' option.
>>>> +#
>>>> +#     (since 9.2)
>>>>    ##
>>>>    { 'enum': 'MigMode',
>>>> -  'data': [ 'normal', 'cpr-reboot' ] }
>>>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-transfer' ] }
>>>
>>> No need to rush, but please add the CPR.rst and unit test updates when you
>>> feel confident on the protocol.  It looks pretty good to me now.
>>>
>>> Especially it'll be nice to describe the separate cpr-channel protocol in
>>> the new doc page.
>>
>> Will do, now that there is light at the end of the tunnel.
> 
> I just noticed that we have 1 month left before soft freeze. I'll try to
> prioritize review of this series (and the other VFIO one) in the upcoming
> month.  Let's see whether it can hit 9.2.

Cool, thanks, I will also make an extra effort to hit that goal.

- Steve



