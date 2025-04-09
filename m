Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 239CDC369A2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 23:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2fA8-00074D-7j; Wed, 09 Apr 2025 19:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2fA5-00073s-H1; Wed, 09 Apr 2025 19:48:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alan.adamson@oracle.com>)
 id 1u2fA3-000112-K6; Wed, 09 Apr 2025 19:48:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539NhVt8019496;
 Wed, 9 Apr 2025 23:48:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=vDxuJpFGDLf6IoIL9yI6RIP5QdWgRBbENRe1vzCw/t0=; b=
 Jxo/KF60KIFeCNHFfNOpGhaXVHJjLe4nS0IvcVvVBRL12DRl1mnoDrnDB+cv45wj
 IbIFxfJUrXW8swdD0r6RRZrkGPb7ZTFqZIUZHjbEuuzC/vwiav8C6i/z8iRczasV
 tKYCHOQvKclQgYpAz3nk67+iazq3I7Pc224jXcAoaNKqkw/COaK7o2ArzO7h8gJc
 ssMHi8iG+Ws+W/o01/uEiOnbWNEdHxoFoG3rMcGkesTN9fXCPdrIyUNKfbUa7PTh
 G0GrABZiVfY1kyACwyUCZfraFirHy2LlXFZuTKX8pqT5sCnh10HPrk6MD987mjJ8
 ndFf3oBGSqz2W1CKC9+WHQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45x2su809q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 23:48:31 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 539M6UhO001275; Wed, 9 Apr 2025 23:37:31 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azlp17010020.outbound.protection.outlook.com [40.93.12.20])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 45ttybfgjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 09 Apr 2025 23:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TI36fM06oSz7Px2+hOP4fYe3qlkfjROXHraHNjpQINOqwL/hKv3RPAVEIkfC2BL6VfzjaJ73CONuyyMUKeAuvw/3afIe6jZccqBAdAcaC9RR1H9WDoRoG/cUOmIhsB0naBt87mQx1IMxJbEnPqsi31OCGRSEcLPWWiVEoAx8y/9TukiAepUEclVVdQ+avyeV5lTXflVfoNygzlBIF4eTpsEPg5OuEE4snNAIHYiCZ920C1V6Z5L2GTfFEg2L8TUqstAMdMIAsXXNLcecj4Iy9VLfxNxQz2Rfvl6+TPEC6bUL+NcNhXgQgF7zv9Ybu1110QHjD+DjkHbxT9w4cLkdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDxuJpFGDLf6IoIL9yI6RIP5QdWgRBbENRe1vzCw/t0=;
 b=u7cMFTzhPfN8VZnTnFngC0KFYjiuvGaARZGga7cjsX6e3yClCAqG7gua55kl5HsbgMjy3KPTOtoYa8UElmzVmsk5GBYKzakJWVR6PR+ktUmL7SqKobNDUc1AHJmhBUUERh7xFvo6uFgqcuJjrwam0/5VmGwa78nh+oH1OhdM25u2mZ+YrLPYYjzE7P14wJM9xstVysRS1yLlvKMk2M6R2Px6DxntnYCXdVCsnY4y4oJxcyzyyf59MUnLkRkHY2Fv/4EI/CExZi1WlUUX7Iqv6gn9/I8tAbb6uJbfiJAe3jjZwK0VazJFZCL5YJPUax4J88R71BRgeu1nDb/Hspb3Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDxuJpFGDLf6IoIL9yI6RIP5QdWgRBbENRe1vzCw/t0=;
 b=BpMdBTb+wGsNcQK6t9cI7a2gXoWBWMe5OwBe+zKrnOF3Z7y+eeNnVZbdki+edAjtHrT5DYs7pcq9LXEgdmcTbC+xhvFZklnJ9yc6/rt5ciqp3j3Nd2nCzHgR1aANM583ERS9A08QoHxbn3oBiI0N+ZkH5J5flBvSkUqniaGBP7k=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CY5PR10MB6190.namprd10.prod.outlook.com (2603:10b6:930:32::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Wed, 9 Apr
 2025 23:37:23 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%3]) with mapi id 15.20.8632.021; Wed, 9 Apr 2025
 23:37:23 +0000
Message-ID: <e0e94b1e-e422-4c77-b162-598a95872458@oracle.com>
Date: Wed, 9 Apr 2025 16:37:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] hw/nvme: create parameter to enable/disable cmic on
 subsystem
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, foss@defmacro.it, kbusch@kernel.org,
 qemu-block@nongnu.org
References: <20250408225644.814616-1-alan.adamson@oracle.com>
 <Z_YX_0KLEfcjWHNh@AALNPWKJENSEN.aal.scsc.local>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <Z_YX_0KLEfcjWHNh@AALNPWKJENSEN.aal.scsc.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CY5PR10MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ac30246-b727-4d53-542b-08dd77bf7a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3ZTdUNGWkQ1NkMxQytCTFdORFZZdUZLOHd4T0gwblpKckY3Vm5XYTZTSE0z?=
 =?utf-8?B?ZmtQMG5nUTNZU245czFkRG9IdEJUWFFxYk1tTmRHT0Z2MHg2aFQzTzdOMnVx?=
 =?utf-8?B?YmY1WGE3QWh4a1JvZTF0Qm5NbFRRYTdzNUFLMGo5ekFTZ2xXeEsyeVNhVk5q?=
 =?utf-8?B?MWhyQXJwRDN1bDlReUY1TnhrMGdqVGZlamVjL29tQmtFc1UrRmdCOXA3NXZp?=
 =?utf-8?B?aTJxZFZzVlZOSlZqejNuZTYrejZhUWNGWDlEV0JKMzhTTG42clkwM3lOSitr?=
 =?utf-8?B?RXFGNEJjNjdZRWJMcndkMTdDL0UyQ1lpWUFOc3BCWGt2SWVUTlIrUU9WaTIr?=
 =?utf-8?B?dG5ybTk4STJUczBERDgrZ3lKVVo2TDdlZlc2VTV5WXd3NlNZallQSXdLdnd5?=
 =?utf-8?B?RzlhQVJ4dFNOaWQ0bGhxYjBKanhhd2ZiL1BuODVDRy83YnZUZ1B1Ym9xakJI?=
 =?utf-8?B?Ymo0bE5TVDRWb2lUS2NYeG9vcFFCRysvZkd5WjNMbXE0bVU2cWxiRm1lYlhr?=
 =?utf-8?B?a05TeG5WOVRxKzliUkhKdUFVY3JiMzNNRE5vYndRcWJqQjIwZlZ6aDNCQ1lK?=
 =?utf-8?B?bVhBSmEzdDNrY3gxNnQ4dzRmZklkcElXeGY1L1ZkTExSVnYrTnVQTmhHbC94?=
 =?utf-8?B?aHplSm9ITzcwWkJYT3R4Sk5MZDdFVzZWVmw2OWV3VlVBbUVUSHU5Y3p1Rk45?=
 =?utf-8?B?MElqcUg2VEN4eGNtSzM2elNWN0hWUTU3U0NvREY1NCt6ZkVLaDRBdHlnV2g1?=
 =?utf-8?B?a0tKQTFaeEE3ZE1QU1lqZEx1NithU0J4dGxrVkVkcHZsb1czTXBxOFNHSWth?=
 =?utf-8?B?UStYZ2pPaW9oMWZyOFNZZzJkSStRWkYwM3lJUUFPWVZ4VE44OFhzeXRMbVo4?=
 =?utf-8?B?bm5CTUduME5TSXJqcFVlanBoSmt6b0EvZEYwb01pZHpCeXJFZlZ1MGY0dXBz?=
 =?utf-8?B?V2lmc1FQMmlHSFd5OS94N3pZQUJqUUhjOG8wU2ROQXgwSGJkeXJ5c2tmbCtS?=
 =?utf-8?B?Tmx6c0UvRktIVFRCQ0RwQkMvYlpMMGFhQ1NHSGJCSTRUZHdpQXYzRG1adkRP?=
 =?utf-8?B?eE5INVFrSFM5eU1jU1luVGltZ0tuWXd4eUJaUTBKeC9vWnFkZnQ4RXRTbWNa?=
 =?utf-8?B?SVdUVHdaaWxCYkorMWtyc0dXeis2Y25QcmJnN2tHOStqeERkUU5lejl1cDVp?=
 =?utf-8?B?R3lRMU45U0hkS2M0N2FWdEhnTEh6bFBxMC9uU1NGLzg5K0w0bzR4dFJ4QTVw?=
 =?utf-8?B?U216RXZCcEhWTUtsZmpPd0hEWnVZTnZuMzVTUGJJcWpIclE5MXBQa1NZeGRt?=
 =?utf-8?B?a2xLejJlUUJDT1QwMmdaeFc1TGpuK2xLVkUybTI3MGt0eC9KaHJTRmlpa1hT?=
 =?utf-8?B?NWFvSmRJOWg5S1BaU0VJbUxxNXN0YUR2SUZYS05LSmFYeHY3MzVCM1VpbE5i?=
 =?utf-8?B?anErQXpGNDVScUNjQmpaTXUvRVRROGZCUVBXTEUvYmEwZHNkM2FxeEQ3ci94?=
 =?utf-8?B?eU50VERoYzB1bHpkNHpkSUNYamliNTRlQWZla29MZ25JemU4SEtlelczREVr?=
 =?utf-8?B?d05IRDhzaTBLY0djajBjckVnNTJ5S3VvcGRLd1hmOEwwMTdHRmRjNEZqZnFX?=
 =?utf-8?B?aXZNaFJpSlR6cUJQV1JqMFp1K2Q4YUhRaTlzczZnVXZiNXgzNUtqVW1ib002?=
 =?utf-8?B?OXk1OUdtZXF3MTJRakNOWEE2bkZrZ1h3WEVCcmVFU09Sd0tZQkJzbk55UmFZ?=
 =?utf-8?B?YUtTc0dPVmdXaHFDOWE4WEhOMVR3dzBsdmphczFxQnNYSk10Mnhhd2xzL0Y3?=
 =?utf-8?B?Z2prQ2MvT2JodTNnUVhVb3dJUG9oUEwySTk3OWIrZnRQcW95dzkzU0Vud0Ji?=
 =?utf-8?B?UEo2M3Q2emtJRXpibkRCMzRtdXJsbWRwdkk1bDNRRWdpWWFjaWxPNVdJVGNn?=
 =?utf-8?Q?pmN5/cJ82f0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB5550.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WE1UVDE3NkFvK3lER1VoOGtic0pKbDQ3NHJZTkk2eS9KUThEUEtpdnhOZ3JS?=
 =?utf-8?B?VCtXZ0JZWndVNkpNRVVGalBWZEljYXRZeXAyYWtkK2ZxUkQxaFZjTUV1cTll?=
 =?utf-8?B?ZSs5ZGFoTEZEcWVkVmt6akY3SnBHWUwxd0FsUlNsSHhyLzBDS3hvUGEyUEpJ?=
 =?utf-8?B?SXFmbUxlS0Y3QlJiNE81MVB2dDRjdmd4c3piR1JlcksxdG93Z0dGbjJBMU1m?=
 =?utf-8?B?eExSZ3FDbG5oYTZ4ckd1QVJSdzZLdUJSUmorK1p5cVZWUTZRc3ZWekQydlJF?=
 =?utf-8?B?ZXU4amR0V0pvUXJPVEM2V05mTnhzZTRiTW5BMnUvcDZ3RTYyak9TZWQ1UGpF?=
 =?utf-8?B?c1BCT3l5eVhtckc2K2FjSDRxVjc4WFZWWkE5ZUNYNmQvWm5IR1haR2N5MStL?=
 =?utf-8?B?bXA5MnQ4OE1MRm51TnI1WEpXaHMzVllhWWd3U1JmeU0xMVMvU011Zm1OU2lY?=
 =?utf-8?B?MEZBL1RYK2EveGRCdktYWUQrQUlXM1dhRU5oWEJiajFUckpyMTlZUDZ1ekta?=
 =?utf-8?B?anBWaTdxeFlTUmF5cHEvczlqR0N0Wit4UWxXa21WeUhCdlNMSHZkNUNmU2xH?=
 =?utf-8?B?ekV1V3ZlZnZmbUdoNDB6bVdLYzVRWUdTN09aWDNsY0RhSVd5VDVldDBNZEN6?=
 =?utf-8?B?YVlGakx5OENUQ0p0MFBIMXUvLzFaR0JJSmZKeHN3eUFyRWl3RkFCSjkrZ2pF?=
 =?utf-8?B?blBiS0EvYURJNTJpMzhvNElkWExrLzhkRktrZnRtRU5GT3VHVHF3cVh5UEJQ?=
 =?utf-8?B?b0RyVHBHdnRKRHdIYWdtdkNoUDZCakJIeEx6ek56ZjI4Ukd0elJEdTlUK1dh?=
 =?utf-8?B?WmJQSkNWaEpFb2J1NnRuWlNXdjVZUGE1ZG9iWitBLzZ3SUR5TXFkd3Y4Mzhk?=
 =?utf-8?B?Nk84ZWFWRVpnUE83UEtJN0dGbjJNU0t3QjNod2RWQUE1MDhOT245MHk2RS8v?=
 =?utf-8?B?SGM4RHRlZnVvRjdYVVBaaU9zcXlLS0k4ZjJQV3JvcVNLRzNQa3NKR0tOZDNH?=
 =?utf-8?B?eWxVbTNaWVBNUUQ0N1pVVW5iaWMrWTZEL2FPeGFRSkFiMDM0cWZ1bGprM3Ji?=
 =?utf-8?B?SUVMdjB3Y1ZqaWtiemJNOE5TdVIrcWdXS1ZMOEp3MjdHZUI4RExBQWtGQ0xC?=
 =?utf-8?B?VmpYUnpHTXZVVUkzV3hkUFdsVCtyQ0hZOGJtTWdtYXRuMEVMU2JYSlc2ekFI?=
 =?utf-8?B?QmdJckliOWxBelA4TWEvbUlRSzdOUnNlVjU1S0xUQ3RTZS96UUFJZ2NneHZL?=
 =?utf-8?B?MUg2azgxUnpHMlFhY0drQVpOemdjMDFEZHdEalcwcFFFL0dWaXhWWXZQblRl?=
 =?utf-8?B?bnFkcU5UdCtDQ3VsT1ZLSWszZzdmcVFoMFNMelgyeEFkNmE5MG9EMDZxSVl5?=
 =?utf-8?B?aXFidmFqZ21wNGdiZ2hvaElPVjNBNmZSWjdrMU5FRGNWL0dvdkxUaVlWMHVh?=
 =?utf-8?B?d3VGUjM1M1hhK0srbmFSUGRrV2l0NzFKSUNuRTlMOTBQRWhBTDRXa0JOWk5J?=
 =?utf-8?B?K0Qwcnp2N3h6MkZ5OENQUytPQ0sxUWd2YW1CbC94aGJGaDM5cWdlVEVNVEw5?=
 =?utf-8?B?aS9PS3lUanhYbzVkQ2FXSlVQZVowS3NSczBXNTR3UXZvUm01ZXg0Q3p4c2VL?=
 =?utf-8?B?TkxMUVhSVk1uSTZqSUpIU21RYXBsVGkxZndCRnpZVFdZd2taODVZaHV0MVRK?=
 =?utf-8?B?L1B2U3FkNEZYYm1lWGpHU2Q3M2Y5VVZvZ0NUcmp2c1l5MlJLOTRXd1YrNU5Y?=
 =?utf-8?B?ek9nOTFvMVJlMkdTMEN1S2dWYStIVGwyMU9KcDZjbnQ0bldBOThTZ0RySld3?=
 =?utf-8?B?UnFKZlVrWnkrbWp6aUtDWk45ZmVqVVluOWdxSHBMdTFqVzlxalQ5Z3FDZmpv?=
 =?utf-8?B?bWxVdGlQb0NlTEUxSUhUTTBzMWlZVWxmRTFmeDhId05QMUhERXFrNkczM3ZY?=
 =?utf-8?B?cVZ5dGkrRkxjQ2I2SzFwWDVQRnh1eUFwVVVnZ0JQY3ZvUlBySHc1d2hnYlI3?=
 =?utf-8?B?OHVCbUdMbEpQcWtFWHI3SElRdlIxZWNQZjdCcDdFbHlJMnp1ODFnNDZ0b0R3?=
 =?utf-8?B?SEtBZ0pMcEJkK0graXFKNmJYQXUrMkt2dDh5ZlpCTWp4VVNNZG9jZ3pBYU5p?=
 =?utf-8?B?cVhLRmxrS281MnNSc01YakpQdk9kU1dyUGNncktHK1NEUXpKUS9QVlpMWXlv?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rv4ySJ7F4LCCEMrybWWAr7mQwPeikzf3xJnG/KmXhSFjhQ9ZBjCezFo1TqQ+1TdEWXjz3VIeMHcFZ0lHlMUIf10GlsS30cWDZfRxGjc7rnIY/ZDep3aB7+G+XX75LDgPUAkZdDF0I6gC02KDiS6PRowJu+eEsEANq5ICpvEJvydGVU9vrjhTj8lHnGxHFZ2qgXqZPE1qy/Wo0fSQsAIN2ln3/l4a6iBkCwi/cNVa3CWONfk7w2ZHKMTQlpLDaUkWSqSXgNHhI8/7+ERouU9v3AtFiKKyde3IRTPyk2FN5EXGZfKep9703wOkh4b1U63BggTJXpR1tWvuHPeR8Xh04dNxc1l4zboucddTJyv8WVJNND4lqlb6opeJ653PVNJJyuTKo6bn9BaA0dJX1rOoRpC8K0nciSmoeKJfaBilzrpc4f3QlTZQnCpEKM/BWionxZaidaXQmdQ/FIvn8ms6BkJvfr7SbaArJylHEhdAHjvWYr4AFcp2Dlaysll96zdNyV73nu63MSjCLU0QntgqZ/8ZbDsYmJ1GbkEfcSgQLDKRWEIiC28GE9xBfVDCDdlpVtx/qAKZvjrdLam5GswTYac4NClv9POJdVtQj75rYi4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac30246-b727-4d53-542b-08dd77bf7a9b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 23:37:23.7599 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zt+ZjsZV3S+GTDqHoEmdx68bxqY+8SPmUQxK6ybYnx4X5LBY5ZNkNGtdyInQ6r5+lq2JSsGJAe0vtbUbmA54Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_06,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504090163
X-Proofpoint-ORIG-GUID: IoNBNQQsPxr8H5YIjx6kWTQmVmnFUWq7
X-Proofpoint-GUID: IoNBNQQsPxr8H5YIjx6kWTQmVmnFUWq7
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=alan.adamson@oracle.com; helo=mx0b-00069f02.pphosted.com
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


On 4/8/25 11:47 PM, Klaus Jensen wrote:
> On Apr  8 15:56, Alan Adamson wrote:
>> While testing Linux atomic writes with qemu-nvme v10.0.0-rc1, Linux was
>> incorrectly displaying atomic_write_max_bytes
>> # cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
>> 0
>> # nvme id-ctrl /dev/nvme0n1 | grep awupf
>> awupf     : 15
>> #
>> Since AWUPF was set to 15, it was expected atomic_write_max_bytes would
>> be set to 8192.
>>
>> The commit cd59f50ab017 ("hw/nvme: always initialize a subsystem")
>> introduced this behavior. The commit hardcodes the subsystem cmic bit
>> to ON which caused the Linux NVMe driver to treat the namespace as
>> multi-pathed which uncovered a bug with how Atomic Write Queue Limits
>> were being inherited.  This Linux issue is being addressed, but the
>> question was asked of why the subsystem cmic bit was hardcoded to ON.
>> Most NVMe devices today don't set cmic to ON. Shouldn't the setting of
>> this bit be a settable parameter?
>>
>> <subsystem>,cmic=BOOLEAN (default: off)
>>
>> Example:
>>      -device nvme-subsys,id=subsys0,cmic=on \
>>      -device nvme,serial=deadbeef,id=nvme0,subsys=subsys0,atomic.dn=off,atomic.awun=31,atomic.awupf=15 \
>>      -drive id=ns1,file=/dev/nullb3,if=none \
>>      -device nvme-ns,drive=ns1,bus=nvme0,nsid=1,shared=false
>>
>> Alan Adamson (1):
>>    hw/nvme: create parameter to enable/disable cmic on subsystem
>>
>>   hw/nvme/ctrl.c   | 5 ++++-
>>   hw/nvme/nvme.h   | 1 +
>>   hw/nvme/subsys.c | 1 +
>>   3 files changed, 6 insertions(+), 1 deletion(-)
>>
>> -- 
>> 2.43.5
>>
>>
> Hi Alan,
>
> I agree that it would be better for CMIC.MCTRS to remain zero for
> single-controller subsystems, but I'd rather not add the parameter
> without verifying it (it would be invalid to have a multi-controller
> subsystem with CMIC.MCTRS zeroed).
>
> An improvement would be to just set it if the subsystems contains
> multiple controllers.
>
> Prior to commit cd59f50ab017 we would also statically set CMIC.MCTRS to
> 1 if a subsystem was configured, regardless of the number of
> controllers.

Klaus,

I'll send out a v2 that automatically sets CMIC.MCTRS for each 
controller of a multi-controller subsystem.  For single controller 
subsystems, CMIC.MCTRS will default to off and the cmic parameter can be 
used to change CMIC.MCTRS to on.

Thanks!

Alan


