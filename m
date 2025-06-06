Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B77BC5B555
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 14:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNXqJ-0002q4-Cx; Fri, 06 Jun 2025 10:14:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNXqG-0002pn-0C
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:14:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uNXqD-0000Zu-BQ
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:14:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5565NJJD028803;
 Fri, 6 Jun 2025 14:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=NL+nL2+elVjuKPrr7dLqlXqxCqPf+ORfZ9FvhrA3c3s=; b=
 doDkVFUpu86vxLG+ct7dpspx40OIx6FULMvcLIYYzdrBWu1hYtOe20e/mNtdaenU
 U/h5EITt9V3JmTlPnofquXlxCc5SFsI8ot/auhshDVa2jPg2HWc74ss/dH0HYsIM
 qFwayeMPscjDYETqQYqJas949lZGldtp+Kgb/+Pfy+nq21OAyzx+F0i4UD4GVACW
 EnkECJNvQ3IneMb6cQuCV3RkuU5Vavk3TCL+eD9PH1bBCeZ0E3U+GGV4stlJ0NPs
 xYEWTi2q1FI0dQVvUdM9t5AXrYE2BZKxJEnRD6Lx3ri6ZQHmmQQE2aIv+WjGyLoc
 jtzBkTFnV/sRhVQcq4GP3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8kg4qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 14:14:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 556E4HBM030799; Fri, 6 Jun 2025 14:14:35 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46yr7db0b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Jun 2025 14:14:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9aHu3c0oYvk7fKy80jvjhIkIRXxfjcj6qwonWNk0jtr+fS/obL7M/1UJ0nSLK6Ri3yNRwwCwXfc9wbL1068wcOFiqWZDroOTNLebYhnJW2s2Fe4UL3EmVpsyzKZvvUeEKU/cvsGFws9IKfYsLYYU1a/dfLOflnUAjNfzFH20GkF6bB/MfktN7a+NvWuyU28V/sTVkZ6cpnvwNk4cPZ55D/m/bBbXhxwpbM2F78KGKDDaSSTb6lXjEjdpkWtAkOezcww5nkvfgqy6HQ6KjftEcN8n3mzY8Vs7l6MfpLT/2aeCwrF79/K3VTozfT/RBU1bV5lxw44SzEroXzMGCtGHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL+nL2+elVjuKPrr7dLqlXqxCqPf+ORfZ9FvhrA3c3s=;
 b=NVPtbEWHOTg3UsGqi9w+OIfnAmTjJZ9MItweb7b0Y/U6hsQvf4fFS8++HjJC0bB5vRgNqvpOUapQeQ63doc6jrHF4zyH7B/Aq2gFSraT/5+Ho+9AX7N38/lRKQ1vRAjHluGQeAGM2mZuShZSY73wB29nHippfMVFz4LY8RCQJdO3Gqu7VBXQ58f7yXdg3H04NXzjBH6ps9nfHhnm36gpf54uUNxyX8bJ/4yf4ZwXVrVnsZEr+Z1bvKWcSZt4839OVpMMcChPddNx/iRVrXo7lAZF4DW7LB2dWtYSKKR+Qm0h+VjEdr7RIJl+7wFRDTdTwELM91F0vnoR3JMDbN99aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL+nL2+elVjuKPrr7dLqlXqxCqPf+ORfZ9FvhrA3c3s=;
 b=cHnFoXzdAn22wYF5OuEFre2GGu0b5R09yBQcrNfvZnjIYmpAW2Fwbi81v8A6dhhk28+yCLIEubtO02GlUMnN46ZP+Lr11MNttihGiBc8IuaYZK7zcZzrh177BwHBk8dVgoy3yagiUepbLcNnY5yvUVAKZHVWPqgJVh/AJl2leCc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB8084.namprd10.prod.outlook.com (2603:10b6:408:282::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 14:14:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8813.018; Fri, 6 Jun 2025
 14:14:30 +0000
Message-ID: <2f36bf89-9664-4552-86c0-646db01b7f1f@oracle.com>
Date: Fri, 6 Jun 2025 10:14:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, jjherne@linux.ibm.com, peterx@redhat.com,
 farosas@suse.de
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <aELy8_1ssb1jTSTa@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <aELy8_1ssb1jTSTa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:408:e4::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: f86e7482-b8a2-41eb-3116-08dda5047435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aS90VDZONllNTnBYZFNOZFgwdk1SVnhSVUdnSmhTMG5pdmdmcGJURTYvK0ZG?=
 =?utf-8?B?RVpDN0ttMytEOGFBNkUreXZGVnY4ZGFYRTJMZ1c4OXQ3RjR2cFpaUWkyTXVa?=
 =?utf-8?B?Z0NqR0ZWOFkvRitSWG5uYWZVMFBVWlpWdnkrNDY1Z09zVUFubU9FUEZHZ1hQ?=
 =?utf-8?B?TVBoU2JqcUtlRXo5ZWdUQkVwRVUzUnJMNFlIcmdGL1VlT28veVJtTGVvaUN4?=
 =?utf-8?B?b3lQSlk1NW5hcTJ4NTZRSlJMYzB5bEdwblRSWmJpL3JJSEhGRnk1SnVLaXJD?=
 =?utf-8?B?a1JveFU2VkYwcytCZDE4ZklIcnhlRjRKVWxRbU1Mc04zeEFKY0UyVUJ0Q1hT?=
 =?utf-8?B?cnhsSHhBUjNUVXQ3R0kvcWQ5Q3UxTDhQRndUMnA4SHJObE1OSlQvLzQya0Er?=
 =?utf-8?B?akozM2I0WmMrMXpqMnFDTjBmalVZWEkxT1ByQWFtQTBOWXhSYjNxTjJySGZz?=
 =?utf-8?B?Q1c1N3dQSlN3SG1Jd1dlU2gvZEpRYmhwdjBEbjNrbGFCaDhqRGcwdlhJeGVK?=
 =?utf-8?B?UXhFSWFSME1GV2dKQWxBVjhoeVl4Z21uQ1YwWTBXTnh6NUhQdUtianovclQ4?=
 =?utf-8?B?dVJHZWpvNlpFbXNxQWNzU1psSFNkS3BheC81M3lTMW9VYi9uRmtCSytCczRK?=
 =?utf-8?B?b0psNzhEejNLcTNjd3ZuT0tGTjhxNkUrSjd4dVdsa0NsVkNKSW12eWcwKzdv?=
 =?utf-8?B?R2RuMGIxeGNFTG5aMDBZTHlKWXhmeTNBMUhjUWd3VGRzSlF1bk1NM2UrOEk2?=
 =?utf-8?B?N0VTU1NleUllM3hZTXpKYURUS1NtbzhQMFFPcHpXVTJhZUx0WER2Y0Z4bE1H?=
 =?utf-8?B?QU93WThWeFhaL2NmR2cvcXRqaWZ4RHBjdUxkY29JaXF0U1NYdFFIZDQ4L1ZG?=
 =?utf-8?B?cTlCOGtRZm4wTFo4ZnYvZ01QNE8zUkJ0Y1YvUGFPeVVkQ21TSFZJTVBrV29y?=
 =?utf-8?B?YllPcFJaVUFxdWJzZDFiaVhzMklYbFVQeVFTZmFtaGg4dVgyd3VwZUhsOWNt?=
 =?utf-8?B?bmRUWWpWbVdEN295RzA5Zko3bWVOaTZ4Mk5IUWZsSjA0NHdGVENmSHdiRXRo?=
 =?utf-8?B?MEgvVzlKbURiaXNFOTJYK0tXK1VrcElzbWpEK2hiczcrcFUwTENFcDJmQ3ZO?=
 =?utf-8?B?ZDZpb3YvOWpHMHRjRUExOU5Hd2hGMXg0MW5XWmdKQmRmT042SmlXNTc2d2Jo?=
 =?utf-8?B?WGl3RURGdWhGY01IZUpsQ1czR1JnSHF5KzdKTVhrRGwrc3htd2VNUlpmdm5J?=
 =?utf-8?B?YkhWZWdiRzNGVnJRMWFYZjVqRjRHa1VvRWk4S0dQL29yN0dHYWdkUVVBK3N6?=
 =?utf-8?B?a2ZJRnhuc3RtWldVWHNSQ2JpYjBlbm5lc0lOSUw4SW1VN3NoMVFkOThscUtz?=
 =?utf-8?B?L0Jsa3pqZFJXTk9LcXdOOEJkRFQ1dkVLLzVGNm5BTjNLSHRITDZlM0VJZ2N2?=
 =?utf-8?B?U080WklPeUhBL2tKOFhreGEvOUhlaGtEL0JyNWZMMVN0cWIzN2Y2OEtEc2tz?=
 =?utf-8?B?UldLclZ2ODlVQ08xNGFEMWtBWXAxUUtwZVVDbERPTWNDejQyMjFUWlBFckpK?=
 =?utf-8?B?em42ek1vZFpES2RlMUpqUEtrUnNuYm1tYkp1QU1KVEhJRnZqZ0o0dFQwVC9y?=
 =?utf-8?B?alJHYnZkQ0d6bzVrNnVqc1F6YjVHZXBGRVlzLzVBUVNWaHJJRWh0ZGZxanZl?=
 =?utf-8?B?dWNmK1R1VDhtd2FLYUh6S2puOVRkTHJZbVQ2bWJLK1VBU3E5QjBuOEZMRDZp?=
 =?utf-8?B?Y01XUlpzZXRZeFByQmx5bzNhU1BVNkxiSTFUOWNqQy9UcDFBOUJIKzRHMnVT?=
 =?utf-8?B?V0dnS3RsSTZ6WDdhNFBRbURRMk1hZWRpWEVoOVBCVTZJN0lWQi8vOU40aUZE?=
 =?utf-8?B?RjV1a1Z1Z0QxNXZKWnBkTTlEbzZQcjJxdS9rcHlYeURMU0phOUZ3c24yS3VX?=
 =?utf-8?Q?omNqwY1CI/U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVRjem5WdGpnK0F4Zk1INFJsbDAyWVJyWTA3elJEMThsMjYzNDVLczg2ZG0z?=
 =?utf-8?B?cXFDcXF3WW9jd09qckdTaXEzWFhMcUtpeTFrOGF2NzhhNEFwZXRPUEEwMUpT?=
 =?utf-8?B?TVc3aisxSGkwVlp3MDF3MmpLdjdMaUJqQXFSVHZCUlo0VzcxYUJpK1kweWJ5?=
 =?utf-8?B?b0xGMkN1SEJPMEhaYkt3L0tmL2Jmc0ZzMmJMdHhYbEY4cHVza3V3eG8zcDVk?=
 =?utf-8?B?SXF5dUFSbHgrQ3pwdCtwVnBweDlFWmpkVysxL1hYMUh0Sk16S3FWV25xS1U1?=
 =?utf-8?B?UXRkMDUxaXVZSHVDL1VKSVo5Qk1mUXhtZEpibk5HeURCQlVQZ1JlNWV3UWxJ?=
 =?utf-8?B?SDVDcE8xK2N0blc1aUVRcGZiU2kxa0ZkYmI3VTQzb1VIa1lRM0NKNHVCTDZM?=
 =?utf-8?B?WEpKbzU1M1plQXdoc2phektTVFNBbFMrL3JxQWpObEE0OGpyeWdCMnBDeHFQ?=
 =?utf-8?B?TDF5RGRybGNGRDhtdkxMelF4eXdCNnp2TDlCdUpmaFV2TVVwSWsyWFhGaWxD?=
 =?utf-8?B?NWFvTHdaenRKdmoyNElhRkJiZTVCQWUzTElrSGR0eHpNT3pNc0xWNUFHUWZM?=
 =?utf-8?B?Q3U4K01LZnc2Y0l4Q251eDA4cW5rTUIwUUNEY216Mjl2TWRaN3ZNbEpMOXln?=
 =?utf-8?B?aEorQVRHZUFCZC8rRmFxbXQwemx5VDhROHVqOGlHUHpqZEJTc0FNWVphMGZ3?=
 =?utf-8?B?UlBaVlkrWHZqOC9pYU9CQ00wU3B1cENaeTh1OXR4SnMwZmNSWmhnWlovbjBH?=
 =?utf-8?B?dGpCRXdabGZmYjEvYmpVckNnenM1ckFwTU4xTzJ0dGZOMnhMcjV5TFl1YW41?=
 =?utf-8?B?SlZFUWhhZEFWN1ljNUhvTTBXTDRGeFB1MFhOaFp3R2oyNkxxU09XRW4ydXlT?=
 =?utf-8?B?SzRJcHRHdUJDRkZHeHRPZnBMZ2luQ01GMDFya3o5alYrbE9XMit4aGt4RFdn?=
 =?utf-8?B?Ymk5SXN3SkVNaFl4ZEJOcGllM1lQV0JLN2l0TDRENVZrMXpyczZOcFMzM3Mz?=
 =?utf-8?B?WmdEcGQwUWdEUk11TWY4RExhYlQzTWlEb2k1elVjS1hnUVNidS9Cd21scG9Y?=
 =?utf-8?B?WHV2NXFBV1V4VFpyNUs3YnpQU3NVc0lBSjRwaDczL2NadmN3Tzlxb2xyRk8y?=
 =?utf-8?B?aGdYN1JOVlpJazNHaGxjcWJIRmRTbE8xVXVxNzZEeUFYNGsrRlJkQ0lvTEI2?=
 =?utf-8?B?MDZ4UDdmYW9ldk1uVkhDTHoyRHR2bU84ODNLVzFJdGJ2ODlRNG9nSjZ3cHlS?=
 =?utf-8?B?NHJJU3kxMUpTaTdkelJMclh0WlpGNk5lUTk3UlhqUVFPempqWGtWL0s4Ni9w?=
 =?utf-8?B?QnpOK0hsWHA3VThqenpFRk1aNFZWdWJ6ME5Td3RpTFZjV3lvRU9MMnR1amJF?=
 =?utf-8?B?UnlCWEdwa2VxSkdKSEN6VlBGRjAzaHovbjJOa2g3UkJNY1lwN2xYaHpzRUlx?=
 =?utf-8?B?aDVqRXM5S213NVZyOG94L3JMQVoxbmpyQUxQV1VmcEZON0gyajFkNHk2M25u?=
 =?utf-8?B?bnFURWJoNnhrYU5xZUJIWG1RaDlUVTAyVzVaeGNSNWFWKys2b1E0RFhENUdQ?=
 =?utf-8?B?UnlqelFudEpzMjRMcER1KzJ0QkdFN1FSeTVSVVUwT0JDK0VSM1J1b1A5VkhV?=
 =?utf-8?B?KzJJQm1lSnd1ZmtJQXBzMFRqczlhN0xNWk5nR1NLUkxDcGZ6Z3oySTVqVVMw?=
 =?utf-8?B?UU9xdDV0V1JLMk1VVkQrcDRoS3hlbkRrWHRqQzFKQnB4Wlh3eTNWbXQzQllQ?=
 =?utf-8?B?cE5iR0ZsYnZYYVZFc0s5dW91TnM5bmt2aGlRZVAzTzJneERZR1VodG1Mby8z?=
 =?utf-8?B?Z3lteXF6N3RocjZ4V1BTdW4rbU1OTmhYRHBMdHlnV2NxN3k2VzJPNHdRZGgz?=
 =?utf-8?B?UVliOC9FWk5oZ3hPT3liLzNoSU1WNE9pTy9YTiswM2VYdm1LbjNweklMQUxR?=
 =?utf-8?B?S292Z2dBTDU0d0dYVjhrKzRYbzNSMzlWSkpPSlFGQ1V2WHpsY09qR3BCZkR4?=
 =?utf-8?B?clBRMkhzQmJKYUU3eVY1d3h6c3loalNsMWUzSENDdktXNE14YXAxREZuTkEz?=
 =?utf-8?B?OG43MTlOSUtxU05yQ21PYTN6elRiaWNmdnczbnNZWWVKT24xeFY1c3NoaDlk?=
 =?utf-8?B?RFpjS05oaTFSVkl4ejRENStRajhEVkdpVFcrWTdxdDdJZ3pGaHhIcVpNVzdv?=
 =?utf-8?B?R0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sMXzgpybAlWuvrauOWT7dl8TWg6pqi9qKi60FTTVqg1JBBggCy25Tm0JyJChCSzIiu5cSoUp/+66oNGLQsE6O2PgsVzaMqh3dZjc3FPX9N0nKibvDJ4G2IAZapry5gOgVSVqPx2EZxFhRNK4rGUiOg7at6YwJ3ZlMhvrMLuVW3S+2Y66DAyY9vuyawC85uuHfPakhykY0QiY0kXlekHUVqLkSBICxQMebCjQvPLsabBiXHOxsUI6CA75SeisASUX7GcsQ/7CYY6vJQ70ws7kH4QFhybpdNg/zP90Xw1TiPdEbNnOVdr358PXyRwyPNwZGjh0dVs5nCpz0mw6Q8CPUr5/agS7OyRqZsKzMG8wHRwP/eCtSDoGIFYcy6L2t3iswSbTqStzjdTMVLhj8aLGCuwUwg2M0AqOxZl8EY9Vt4WDu8ZkjHcEsNluUUFsJ3rgMQOlSlnzuO1btvQZsTvqi05es954P6AedZfReGglfR35ntIXWCzdv3I/SXQHi2AlWyGMVW+ZR8zl1mP3CHcpZW9dhJj0M2hRDbjsSHUHN+4Kd2R/4W9WD5SuGbJicmTUaC8rBeFScoVq8DAprCK2ONLTJquMgV+zcnqJb0xG4yc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86e7482-b8a2-41eb-3116-08dda5047435
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 14:14:30.5987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9p9maAbtroa8AivWwJ9Gis5tIHMKnMj4mULLp3t2UjZOAcQn59LP/LmVU8vt5pqZEhWZAAMzR5y0o/HsfWBxCTNKFl8a1K1W/+uiPD2bqLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506060126
X-Proofpoint-GUID: 0pV9MHKNIwnp14vocleapHcnqAjKEQ8A
X-Proofpoint-ORIG-GUID: 0pV9MHKNIwnp14vocleapHcnqAjKEQ8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEyNiBTYWx0ZWRfX9+NGqMsa800k
 Kzf8YJtpFmNeRkDdrHcj0YJQscTzdhaOr3n7fGByD91Z1aLerLGGYCRxrz+7YqUY9gIVz+7tOW+
 kgzrI9PZFsOlr3Zf74iDKlXsa5Z36zQAklzpAnJgT6RJXNO51P3BK8M/XKSrr1kuxwhS2W8xZIx
 eslJBuYAheGPu3ahmchVu2ElNF4YGakj9WfSNTvy5l1c9rxkVHE6SaKF7MN+d5qz5XVRPozUzy+
 HdOfT9eOauWARjj5Z63/Q72Pzzi/YRzLSDw3Rodt0oAJRscYb9AjsazPLS60Oba4bkDP0uJhTXC
 xnVmBivHmQbx8sjoUzvSUIsN1UXk/VP7kF0pxbQa/VxeaDHbnYeZLHdlK2Z4IFa/akidmDQG6pd
 HlxWtuVdurbAlq7GU3+xUwzf3gHn2pwfORwHhGmDYpt6hZRjNRoV0ya+3HDqt1wRAtwlA6Uh
X-Authority-Analysis: v=2.4 cv=FM4bx/os c=1 sm=1 tr=0 ts=6842f7cc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VnNF1IyMAAAA:8 a=ITGa4-7lPn0y-5_mV7sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/6/2025 9:53 AM, Daniel P. Berrangé wrote:
> On Thu, Jun 05, 2025 at 06:08:08PM -0500, Jaehoon Kim wrote:
>> When the source VM attempts to connect to the destination VM's Unix
>> domain socket(cpr.sock) during CPR transfer, the socket file might not
>> yet be exist if the destination side hasn't completed the bind
>> operation. This can lead to connection failures when running tests with
>> the qtest framework.
> 
> This sounds like a flawed test impl to me - whatever is initiating
> the cpr operation on the source has done so prematurely - it should
> ensure the dest is ready before starting the operation.
> 
>> To address this, add cpr_validate_socket_path(), which wait for the
>> socket file to appear. This avoids intermittent qtest failures caused by
>> early connection attempts.
> 
> IMHO it is dubious to special case cpr in this way.

I agree with Daniel, and unfortunately it is not just a test issue;
every management framework that supports cpr-transfer must add logic to
wait for the cpr socket to appear in the target before proceeding.

This is analogous to waiting for the monitor socket to appear before
connecting to it.

- Steve

>> Signed-off-by: Jaehoon Kim <jhkim@linux.ibm.com>
>> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   include/migration/cpr.h  |  1 +
>>   migration/cpr-transfer.c | 35 +++++++++++++++++++++++++++++++++++
>>   2 files changed, 36 insertions(+)
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index 7561fc75ad..cc9384b4f9 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -23,6 +23,7 @@ MigMode cpr_get_incoming_mode(void);
>>   void cpr_set_incoming_mode(MigMode mode);
>>   bool cpr_is_incoming(void);
>>   
>> +bool cpr_validate_socket_path(const char *path, Error **errp);
>>   int cpr_state_save(MigrationChannel *channel, Error **errp);
>>   int cpr_state_load(MigrationChannel *channel, Error **errp);
>>   void cpr_state_close(void);
>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>> index e1f140359c..3088ed323f 100644
>> --- a/migration/cpr-transfer.c
>> +++ b/migration/cpr-transfer.c
>> @@ -17,6 +17,33 @@
>>   #include "migration/vmstate.h"
>>   #include "trace.h"
>>   
>> +#define CPR_MAX_RETRIES     50     /* Retry for up to 5 seconds */
>> +#define CPR_RETRY_DELAY_US  100000 /* 100 ms per retry */
>> +
>> +bool cpr_validate_socket_path(const char *path, Error **errp)
>> +{
>> +    struct stat st;
>> +    int retries = CPR_MAX_RETRIES;
>> +
>> +    do {
>> +        if (!stat(path, &st) && S_ISSOCK(st.st_mode)) {
>> +            return true;
>> +        }
>> +
>> +        if (errno == ENOENT) {
>> +            usleep(CPR_RETRY_DELAY_US);
>> +        } else {
>> +            error_setg_errno(errp, errno,
>> +                "Unable to check status of socket path '%s'", path);
>> +            return false;
>> +        }
>> +    } while (--retries > 0);
>> +
>> +    error_setg(errp, "Socket path '%s' not found after %d retries",
>> +                                            path, CPR_MAX_RETRIES);
>> +    return false;
>> +}
>> +
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>   {
>>       MigrationAddress *addr = channel->addr;
>> @@ -28,6 +55,14 @@ QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>           QIOChannel *ioc = QIO_CHANNEL(sioc);
>>           SocketAddress *saddr = &addr->u.socket;
>>   
>> +        /*
>> +         * Verify that the cpr.sock Unix domain socket file exists and is ready
>> +         * before proceeding with the connection.
>> +         */
>> +        if (!cpr_validate_socket_path(addr->u.socket.u.q_unix.path, errp)) {
>> +            return NULL;
>> +        }
>> +
>>           if (qio_channel_socket_connect_sync(sioc, saddr, errp) < 0) {
>>               return NULL;
>>           }
>> -- 
>> 2.49.0
>>
>>
> 
> With regards,
> Daniel


