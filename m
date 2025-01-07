Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73A39E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 16:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVCBS-0003Lg-Ix; Tue, 07 Jan 2025 11:11:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tVCBQ-0003LQ-SH; Tue, 07 Jan 2025 11:11:57 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tVCBO-0001Jr-He; Tue, 07 Jan 2025 11:11:56 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507GBpFG021514;
 Tue, 7 Jan 2025 16:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=PQg2QLxIOK4ToQcCJxWgrLXwMMDn9DMANe0G8bhngJM=; b=
 UXPFStO7AcrMftE3QwjryStz3nHYM6jMUeupCymZwPCBOqcV1w0JYRpE8wiXrV1i
 ukM9/Bf4xskBPAG8XnH+61r0PXe6gvPYbMn+KQq+/cEWHYIn3xL5ZywmeENWAJpu
 Gp6E0w5DdmHcuPT11hOuHD0+gfCsnY18clfzfNUNBmUa2fmotQwlKUEWB2OO/Zeg
 vbLT13FDM1zfXofsQx8lkcqszwDnxSF33V6xDikuP6ypECvOBvA0bLTTVzm8vsdt
 B3OozpYTGBbEM10NqO+4Z07rCKNuvAOnycCvfQitdPxSWXPqcDE8LZhLfSXpGfao
 K/43JH0kJ/hNGhEPzfpXxQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk05bts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2025 16:11:51 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 507FT9xI020639; Tue, 7 Jan 2025 16:11:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43xue8nsfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 07 Jan 2025 16:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2Y0jFIwn3+VFpKp2zMWtcSrFI26w+J9pD9askaf9G++awmXDyqpTI3wRibPfzlIDDAt317u9+M6ZFdeOK3aoEONUqNf0u0P0bVywp+VE5YXEsBVLec4Vd4kPU+m33s0BpGWWMg5D37it1zl1U4yTR3fOjVuJHnUJHCs5WdDni8Rv35Gs0tGn3IUcVwkqN1XdMiSncXg6+mc037wYkB2cWFlCi/NjxsK/4GQYoBqJv+mcP67ecmW8ogwFB27Y0plxgHnZwEdYzWOY2+cGftv1l3vX/aWw5rIY5MqCjGEatgEEXOkO0qsKrTvO8+Nxxc/luIwiSP9KmgJgPtUpPEgDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQg2QLxIOK4ToQcCJxWgrLXwMMDn9DMANe0G8bhngJM=;
 b=GE9AQOGAoEGtJFx8KQeaLQ4G4+FWoJQ+QkuNLTrJUkxURQPtMDavhmjukA4ThH8qVcy14uZXzVL9mFWdqWK/IqK31ActT3Mnqqupeap/xjjixiKaun5pbu0DmEvSiyzuWBgPwt75qZCG4kkhRG/RZHq8NF/WqkmMW2KyzAelLoowjE91oDqJ2gXHH1p3AO2YdllvHzrr5eyb6IzG/x24sd96Aay40o2X0Mi2BWfd7nmaV1jAM38dzacJbWjEpykN3vsIpE5mftSH18fji/yhZCNKSoYWsX2eO3ghqlhdfxDLCg40VqEPix2PuGYMNxmMeQbbDPlQKpGcgnykAx4WXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQg2QLxIOK4ToQcCJxWgrLXwMMDn9DMANe0G8bhngJM=;
 b=B2xauRXGdAdg20IzHX01xg6c2TDROT5RjpAe21ARtg5qMqG9G7MEP0D0Zdcm8lT4ezntJI7s7niHdLIeSopAsopyh1mb9fa4sdIYFf1VcHsgPXC7FGrm+wM8f0EAd4ZNG0b6421v6ek1Te6LWcKv7D+mjaEeywQhpPk/NJW0YdQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 16:11:44 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8335.010; Tue, 7 Jan 2025
 16:11:44 +0000
Message-ID: <ac5d7de0-5eaa-4816-bb5b-d3cf801a2ed8@oracle.com>
Date: Tue, 7 Jan 2025 11:11:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] physmem: fix qemu_ram_alloc_from_fd size calculation
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Xu <peterx@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <1735853532-330037-1-git-send-email-steven.sistare@oracle.com>
 <2dfd3c37-3816-470d-9f8a-9187c93c0c21@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <2dfd3c37-3816-470d-9f8a-9187c93c0c21@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0335.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d78de08-3b5e-43cb-5c1f-08dd2f35fa75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUhiY3FGM2N3OUFpOVlTNkZzenA5eTB1bXhsQ2V1MXV2dklTcTAzOS9sQW1L?=
 =?utf-8?B?WHZOYTAzRlZyNlJ5QXg4bDNuZ1A3T1RaWVVNcVpqZ05JMmtQdlpqSlE5S1pY?=
 =?utf-8?B?Z2hVbmliQnFDYXBsUEZkMU42VmlZYXVKZllYeGRCa2xUeE0yREQwUkhQL0ZE?=
 =?utf-8?B?b2FDWHRpWmpsZnE2YWlGMTVhTXhrUHZsRVZIeFBGRjlzTmw0OTdIdjh3OU9S?=
 =?utf-8?B?TU5ocTgrbzh3THVSTzBYSkdDUU9VVDdNb3pNbElkZ3VIZnR5MWMzSE9hVHVu?=
 =?utf-8?B?Znh5MzgxZTJacjZBd1lkcUlIdXlzZzhxZTlmYWsvK21mUSs3WEp6WnJpQkho?=
 =?utf-8?B?TkR1UVlmbllYVWd6cjhaWjVzUzU4UXV2MDUyRXB5Q0J4eEtkRlRsM1ovaElY?=
 =?utf-8?B?RXN5UFhRejBDd04zY1N5WEtSN3d0cm5kTUpEN2o1aUVMQXUrdE5LSnppdVFR?=
 =?utf-8?B?QWwzTENzd0ZpYnlnOC9BbVVYUWZsT0U1bWRVeTV5TW0zL3BwY0FWdVUxcXp3?=
 =?utf-8?B?VHV1MXB3RUZDZXBvS2krSzcyeUcvMXc2L0kzbm1FRTRaUWcxTzBIdU41R05Z?=
 =?utf-8?B?b29oOFovV2ZIUzl2bURMWTNQRjdBdnRZODcyQmpzd0lwMDFVVGtob0hpdENF?=
 =?utf-8?B?T3JLUFo2ZHUrZ2Mrc0Yzc1ZlVUVQTnVkaE5nRUVNQ1dBSVN6WE1JdWM1MlU3?=
 =?utf-8?B?M2NhU3pockJVU1hSRTFUQWFFMVUrMlpGVkU5c2FqQUlZY2FQWFJHQWt6SzZj?=
 =?utf-8?B?SElTbGgyZVdJUFprWDVCL2tzRHZQdVQ0dGkrZ2FlVllpLzlQdmVYY0ZMcW9F?=
 =?utf-8?B?cmNvTGpMZlk5eWh6RzNrYzlaOVVyd3U3eEtGdTV0ekNqdWhkKzlxSkdFSDNP?=
 =?utf-8?B?R0RRRk5BRXU4ekc2NDJLMUF5Y2dZak9tYmNGOU1leTlXcGkrV1dvZlhodXBB?=
 =?utf-8?B?TjFwR1hEWTJ6RDFKN3hKRUI1Q096M3doM3VkbWg0dGpibjg1bU1FN0tBdlQv?=
 =?utf-8?B?UjhRUmxRc0ZGb3JXTFg0Nmx0Wk4xY0xGRzEwYlNLNnpjMWNNc2lBN2o2T1N4?=
 =?utf-8?B?bi9Idms5dkJXdW1DUU01cjJxaGtrTnRHVzB4Q2NwSXlNSWZUZjFxZ2Q4ZDFz?=
 =?utf-8?B?cngzaE1hMHZMOFlpcWhUK0ZtTUZDZVZXS2tkcE5VMDlsY2NETittSVJjQzFY?=
 =?utf-8?B?enRVRlRqdnlDaXllY1V0RUJXdE1CaW9ha1I1TVB5MExvbytiQ210aGMyMWNQ?=
 =?utf-8?B?QmRZSVhXQlRIdEcxbVNNZ3RVeG13VFFaK1dxRmMzZGk4cE1XS3BRMzhuNHhL?=
 =?utf-8?B?N2FMRkxlVUpHSDNQRWJiUEtvdU52bmhQV09jQk1XVVdGeTR4ZTcyVkFQQVZx?=
 =?utf-8?B?L0F4OWNJL3hTdUE0YXV3M3kzNXpFZTNWRmoza3NMYjQvdnpSVFc0ejQveGhD?=
 =?utf-8?B?TXpTa0QxYnBVZHhMTDBWVnh5ckNCYU5Ed1pUTEVicUdoZ1RJNTg4ZEduR0FY?=
 =?utf-8?B?UnN2TkQxWHBUTXhDZjBMVElRZi9zVW5IZDRxU2Jqc0ovUG5aa2o2cXpXblpa?=
 =?utf-8?B?cXpvMkhPUnRHYUR6amNCeDJKK2k2WVNPVWF6eXRYYzQvQ2RwYW5rSWdiZGwx?=
 =?utf-8?B?bDhDQVo0QVFJVXE1MWNLblBkUVJjMGxEMXQwUk5hcEFZNndPc1RoQWNYTnZN?=
 =?utf-8?B?eE02QStNTG1HTFBMekQ3bkdrU2ZrSS82TWNIU3BTeUdxTnJieFBFa3h5UExv?=
 =?utf-8?B?UkJhZGtzUXVydnExUHVnYTc4TDlGY09pZDlEZXZvS3RsMTUzcmVhOVBaV1F5?=
 =?utf-8?B?MGY3Qyt4QVYySmY2UWNZQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtiSzNUazFBU3BDb3o5RXpYczBhWE1mMXNPQS9lYmRzbHBJekZ6MXJxbzFK?=
 =?utf-8?B?UUtsaG1iUExQTW54RW5TN3lLcEJZSThHTklEMnNIKzdYQVBteU51aGwxYkV0?=
 =?utf-8?B?TzRsME5aRitrblJrMldmcjRNUEtENUNmY2c3ZER4VFlhOUh3MW13Nnl4SEZn?=
 =?utf-8?B?N2M3V1NHSEhFWXlnNTZHdnZZVEJXaXR2V0tsalphWFl3VEZkbDNOZlB6OFJk?=
 =?utf-8?B?Wk95MnNIZHNiWU9NaUdZVFcwZ1lRbmptdVN1RVd3MG1SM2IxWUhhSE1XZzhs?=
 =?utf-8?B?NGtlOFlFRjFFZnFoYit1emtWOVFOVXVnMERLejA3enJrWWJNdUtnSERnOFR1?=
 =?utf-8?B?dnpiUHMvc1VVc0VqdUdYU0pjVHR3RGc3Sm9ZNkVTNVpNRmJQbW1PU2dNZDgr?=
 =?utf-8?B?Rk9zdVNFd1MyS1RWWHlXSUxpNncxWlp2cTZDZWkwa2dHRWxhTDcwYTR6bUQw?=
 =?utf-8?B?OWtvSDBDWE1IZ2UyMHJESXVWb3JjVC9GZnQyRURNbjZ3Z2h4bVUvd2pDRXVi?=
 =?utf-8?B?Vlh4VFZyR3dkaVNSM0xMb0ZSUmhGS21YS0hDY3dkTlk3MGRHSTVoY25KWkta?=
 =?utf-8?B?MkpRVHdzazY0NXprbmg4ZnBVbFNrUjhqdTZBaHVsNk9samVJUzdCWDN3alUv?=
 =?utf-8?B?MmhlUVJCaUw1MFlRdlFkcmJWSFphYWNwbEI1bk80c3hMV0ZtZERjU0tzbHBY?=
 =?utf-8?B?OVk1MkpleC9kNUc4ZDlDRjhmT1BsNlc4Rk45dkYxTlhaTkd0SzFKZEtmMC8w?=
 =?utf-8?B?bUdUajhTdE9rbTdDQm0rSnJnanYwNkNhOGF6RnhvbDJIc1ovakVlVzhSeHN5?=
 =?utf-8?B?bTBYTWhDSSt1UUlEL0hVSXd4Tll1eTFvOU51cGhWcTlkaGpGL2VranYweHdV?=
 =?utf-8?B?MlowTnBpSXh6SUJvUnlNZnJ4Z0VwTUJyZlBLdTlhN2oxczViN2lEblJDSGlD?=
 =?utf-8?B?dTlvaWExRUZCQ3BmS1BBbEQ1STByc0xmRUtLSG5xK0FidjE5N3R4OHhtbVc2?=
 =?utf-8?B?T3FtUzA4SjFrK1JuUnBPcXlzWC9ScWxNWmNoWlZxMGxsUGRDMUFVRVNpMTV2?=
 =?utf-8?B?Q2MrWWgrcndwblBGYUlreWFtZW1WamdIcWVMbEJjRG1yVzZ1VWRMQlBySTRL?=
 =?utf-8?B?Qy9CYTJRQmhnSk8wUTVaTDhOeEQ4TkEwbndyN251dHU1N1dGaGp5RzB6ZzY4?=
 =?utf-8?B?bXZKZXBLQVRxcnVFdjhCR1NWd1RtMDFnb3I1RitSd1FSRk90VlJ1VGhhM3ZW?=
 =?utf-8?B?TjFJWmQrUFI1ZHdDNGU0R1hxbFhKRFp2dkpBL0hhVFE1Y2RRMVh2dERpdzNl?=
 =?utf-8?B?ZUlHRzc1elUwdDZ0ZE4vZmhzTHRkS091ajBaMXlibHlNdnBDNTFTQmY1U0tZ?=
 =?utf-8?B?bGZsSDlQL2hyRXlDSUxwUmJLMnZ1WE55UDFZVUM0T2NhblZFdUp2dnMvSFJO?=
 =?utf-8?B?OXBKVG9XVjg0SzZyb2ZmSWY2SHU1RHhWSkJWOXFEd1lYbFMzNGRXeFY3WC9p?=
 =?utf-8?B?YURzR3ZlN2dmd3c3SVZkT3JFS1IzUlA4aVUxTGd3Zk9taWdwTkxJZUNaVmd1?=
 =?utf-8?B?NUJkMGNRWWZhOHJ1YlA4LzJXb3Y5NjlPYW10U3VjQThLdnRMY2tIeFRmZ1Z2?=
 =?utf-8?B?Mk05QUZld3Bob0VGUHFsb2Q4RXVSOE5WWm1DWS94SkpHK3kwQjRUbi9ndnZi?=
 =?utf-8?B?REdISXFMVVBxbGw2bHRpRmJoaTJIV0lOeXFwaE00RTVOeUppeCtYbjlKbWR1?=
 =?utf-8?B?WERkT0dsRHJ1dERxVjBmdVJITjVoSjFGdlcwa1dnOWcydmxrZkl1bUw0WFRE?=
 =?utf-8?B?OEpCdWR4by84OHo0UkZQK1NsaVc5WCtXU3FQMUpGaXFFS1RHNENIaW1oSlpK?=
 =?utf-8?B?dGdFTXpBcXlQai9OakRLYzc3b1BIN1V2Nm9QSzJ2Q1I4WVNFcXBjVEptN01J?=
 =?utf-8?B?WmhVb2V6TTdjZ092dFBvQ3UvODdKMC8rTlA4S0lmTnllTXFZcEVEMWhrdjVv?=
 =?utf-8?B?ZjgxblRWcjArUzFLNU42U2Y3dFZiWVUyU3h5MGFvMDc0ZElYbUp0ejNITENX?=
 =?utf-8?B?VCsxMzRXczhjK2hjcDd3Wjk4Z1M1SzQzWVpKd3hsUE0rd3NXTkNuNmFhdVZH?=
 =?utf-8?B?akdzOFlZK252eVprU3ZQaWlaNGNrZW55b0k4OVBiQldNTGt0MnFSQU9GSmRr?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1cJy/ACkndbeiXLYsnF77RDhWAfeoRkGyjdlv6RQX3FpVWTEX1Db5CyU5Ic5ouXz8dm7JnWG5EeOwcZ7yU/XG90LoC2WkVPzzqYHsYiEbI7Ly6jBydQnhaLOZRHh1zhzA2jATjKhlRL32iIJeUf3djdcQovI6mHfTppLLedL4NK3tiSz7hDdA1l55aWq9eIWWQabYZXHodOUx/e1F5BvO0Sa6yJXHXJlev9tfu7RmsXq4NuZzQXEsgRq1n7NkLU+wq934fZL2RW9e4KruXWbFluBOBO6fo0LkcAYl4vlaS9KJslhs9bDX53wHSx/DbpMjNM3d/jzy9HJfAHFKYJ5foFr4Z0mrry8JfA+/oR/j/R+ojVIgbo9uWw6NHJOGU3POIKAovpURDwEDgeNxEvP+6mxm6oqWXAOgu/BrjlQeH2t5XIWKglDhWbh7mb2+5NLouuai4Nj24MYGRVpukRoJhHr2xWaRiUU4o4Vx1pyurviPMFZDo5VTqzPIJOR39RwovrUawX3Euic9nehUdMlsalg2+0DWFAjJ4QujE7sMIUO/INzjf5iCgrEoDL4uG1LHt5R6sBVggjkW6zLLnbF18chHzvHh4V/Bxb9EhGx+0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d78de08-3b5e-43cb-5c1f-08dd2f35fa75
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 16:11:44.0390 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxXJdSHAQRaWog36BrvAoCow4RxpNyAi64m/mVQ9V6FRa3AILDp4euwYqMdG15Sv82jq1WWI8x8IS7x6izrBuxp7tk95qHJ55+G3xC1zpDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-07_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070135
X-Proofpoint-ORIG-GUID: KtudOMn5o77usyvqIDmtGl1p6k5lCIRM
X-Proofpoint-GUID: KtudOMn5o77usyvqIDmtGl1p6k5lCIRM
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 1/7/2025 5:01 AM, David Hildenbrand wrote:
> On 02.01.25 22:32, Steve Sistare wrote:
>> qemu_ram_alloc_from_fd allocates space if file_size == 0.  If non-zero,
>> it uses the existing space and verifies it is large enough, but the
>> verification was broken when the offset parameter was introduced.  As
>> a result, a file smaller than offset passes the verification and causes
>> errors later.  Fix that, and update the error message to include offset.
>>
>> Peter provides this concise reproducer:
>>
>>    $ touch ramfile
>>    $ truncate -s 64M ramfile
>>    $ ./qemu-system-x86_64 -object memory-backend-file,mem-path=./ramfile,offset=128M,size=128M,id=mem1,prealloc=on
>>    qemu-system-x86_64: qemu_prealloc_mem: preallocating memory failed: Bad address
>>
>> With the fix, the error message is:
>>    qemu-system-x86_64: mem1 backing store size 0x4000000 is too small for 'size' option 0x8000000 plus 'offset' option 0x8000000
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 4b870dc4d0c0 ("hostmem-file: add offset option")
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> ---
>>   system/physmem.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/system/physmem.c b/system/physmem.c
>> index c76503a..f01325f 100644
>> --- a/system/physmem.c
>> +++ b/system/physmem.c
>> @@ -1970,10 +1970,11 @@ RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, MemoryRegion *mr,
>>       size = REAL_HOST_PAGE_ALIGN(size);
>>       file_size = get_file_size(fd);
>> -    if (file_size > offset && file_size < (offset + size)) {
>> -        error_setg(errp, "backing store size 0x%" PRIx64
>> -                   " does not match 'size' option 0x" RAM_ADDR_FMT,
>> -                   file_size, size);
>> +    if (file_size && file_size < offset + size) {
>> +        error_setg(errp, "%s backing store size 0x%" PRIx64
>> +                   " is too small for 'size' option 0x" RAM_ADDR_FMT
>> +                   " plus 'offset' option 0x" RAM_ADDR_FMT,
> 
> 
> Note that offset is of type "off_t", not ram_addr_t.
> 
> ram_addr_t is a uintptr_t, but off_t can be a different integer type.
> 
> In meson.build we use "-D_FILE_OFFSET_BITS=64". So on 32bit ram_addr_t would be 32bit but off_t will be 64bit.
> 
> 
> Printing off_t can be weird [1]. Maybe just cast it to an uint64_t and print it using PRIx64?

I will fix as you suggest, thanks.  Good catch.
With that, should I add your ack or RB to V3?

- Steve

> [1] https://stackoverflow.com/questions/586928/how-should-i-print-types-like-off-t-and-size-t
> 


