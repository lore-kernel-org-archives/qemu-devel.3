Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D200C3DA49
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 19:55:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVG9r-0000PL-9T; Sat, 20 Jul 2024 15:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVG9p-0000Oq-Ti
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:54:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1sVG9n-00085g-Ep
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 15:54:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KJZJNY030218;
 Sat, 20 Jul 2024 19:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=VEUN5PaTnQJ61y87NZ2KnJp6oLy0HLXSo1ULxeM4QHM=; b=
 cD8bcGiiSGwt80GcR1xydbJX2AXaF4C9oIMphHLul3Z0kYjQs9u9minWtC8p7YtG
 3+OeHBslyTY8KSADMmU2eHfcDXdQsjPdknVMLRxEMeEPxRIjql93fonJ0k5dJlp6
 pj/2/psvYi2KWq+slg2n+hHXag6P/vA5+udj+7IcW5QZNenpLpWvsUUCHKj3O74Z
 ORKghrEDDl5SQh59VIRR/f12Pm+Zj9bRrEJ2i+qtSVK1wLxPSSSw06isyMO936mW
 QJgU74f9EINnUmxzaseFvu5QQGTswJzDw79gcnkxxRdRqv2dCIsNzXTFKIY+7S6I
 YvPUf3x1HBHSjUpzk0D1FQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gkhbg096-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:54:10 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46KHe1Pl027443; Sat, 20 Jul 2024 19:54:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40g3p5q9u7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 20 Jul 2024 19:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZhkIgohHN9jVNhusglxTw2flqK2bjMri5cFm+6dfL1zgHcyVEly1o0VzEFrlrrF/9dPZr5gayVA76JNa5jtcXAqKBUjKJSuOzIUR1TO3YHCo2qschBzVx00nCK1z/Xxvffzu1Xxignf6xvNbM1Fuxpf4nQcJp8u9QdbVXLfkYXX4G7X7KKusSrTEeOBXHCGq9MaJDYeuEl16Dl+94ovEeJ2NCsfpGMuPsiQNsEvFhDCakBSYtnUrSjhyNO+fvjicJT0xaOMHGsQCaggkB6JvKQegEZd5rOMme0eXsC1YwPmwdKHuH/gBth2ww4HnCS5DexGz9kjtjqwXH4mXfs/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEUN5PaTnQJ61y87NZ2KnJp6oLy0HLXSo1ULxeM4QHM=;
 b=R7BuZUJFTsDYuJNnsnHLRYUCroLNlhXw+0J51mBETHhHy244tktpeLwDpAZ5G2MEMU0LY5KIE0ljfViVeA3a2u83ykaex+Js6R+G9DrYPJ6DxNgWM2d4lBiX3ya4ExyWw/1EBBJlgmjUGY9A0sGeI34H1jSd7gpgVO238UJ4lynRMcYsIzP7n95orI9GOXvzCBAsK9NJoon3Feu1hCwsWw+hmYi7kRCtA9/SBc5+DlQIi/C3tG2NYS9DRmhNpHdFOQg5zVBFY7tyq5pasunkZYV9PmwDlU3OYEuVYiN5ZOVuqNh8xcU1WUqyGEAotMN5QpoAsxkUxd3EYmwHvR3X5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEUN5PaTnQJ61y87NZ2KnJp6oLy0HLXSo1ULxeM4QHM=;
 b=QnLJfOe4sXLvkeAzPFk5bq8kM2JhFYWU/u4e+dFNMW5oIDHC9tD26wtSOp/cGtsz2I1DxFs67ZEOTNgyPsxCKtoHmVtrtKf6LTfaqrcTwQC/knSjqc3ScitheKrM9yVW2Z+TLVnQ3oiMnaI5JijcVuBT21+dTb52uFBz5+7L7s8=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CO1PR10MB4436.namprd10.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sat, 20 Jul
 2024 19:54:04 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.7784.016; Sat, 20 Jul 2024
 19:54:04 +0000
Message-ID: <dbacdeeb-69ba-4b3f-89ff-0704a88339d5@oracle.com>
Date: Sat, 20 Jul 2024 15:53:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 02/11] migration: cpr-state
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-3-git-send-email-steven.sistare@oracle.com>
 <ZpqAQ6L6XtIyLREq@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZpqAQ6L6XtIyLREq@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::6) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CO1PR10MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7574fbc1-ffd6-490f-fd29-08dca8f5b53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2xvbm1rd0lDWlI4aFcyaGR2MWtXQ3R3L2JNQVVjYkpuOVhKTVZON1FENlJ1?=
 =?utf-8?B?YWlrME1DOVc1a3haK0tPRDBvME45a2ZSU09LRnNLQ2JoNGtLeUNtaCtpb0t1?=
 =?utf-8?B?QjI3OGcySnlSdGxsMmprc3lmenM3cGV4eXQ1MjFOKzRvWVJPQzByNXIvN3N2?=
 =?utf-8?B?SlVmSTdjNmw1aldrR1RjOHV1c21iOUkwMVZ4UklnS2UxZUZRL2NQM0x3N0RC?=
 =?utf-8?B?ejVnVEFFY0xLc0NRZ3pJZWhJWGcyL0hTQTNIU1JDN3g4dHZXUXFTNWs2alhs?=
 =?utf-8?B?NmlTRXpVWDQ2TTE3RlBsa0hERTVxeldXaW5RMmVOS3VMOXlzUEN6ci9kTTA2?=
 =?utf-8?B?TUZKdzg3SkdVRm5tRU0xMWJDWWYyNnZmWmVmS1VPRjBOUjRWbnU3SkVvYlhY?=
 =?utf-8?B?enQ4Y1pTVlBkRCt2R05BNk1lRnBkR2NyNkwwYjdqbW5zV1JYdTQyeEE3RjF5?=
 =?utf-8?B?d3duc0Z4UW9wR2h1NDczWFp2ZXlEZlc5d0ZaWGI4OWpXMGRqeXJES0p0ZnZk?=
 =?utf-8?B?bVN4dllDL3pQRENENFBhdEQ0N3lyKzk0MEFkbHBHMDJtNDNzZjNadFN1dGNC?=
 =?utf-8?B?aDQvQ1d5bnRnMkNSZ3JUNXoxV09MRDdsZE1HRG9ydFVSNlBHMjFCZGhmVkF3?=
 =?utf-8?B?NjVadVdRVzhqc0NGWnlVV2NURCtsaWEzWVBBZDdtVmJpb0Y4T2N6NWU4Z1VH?=
 =?utf-8?B?a1o5UTlDSkh5eVpzU29VM0JaYnBSejk5TVJkZmtPNnVRQ1E0bkh3aUhzSnc5?=
 =?utf-8?B?a01GU0J5bjIzbGZ4SWtFb0lzWjlDZ2MrV1ZiY1hNcG56QUdLUmJqMnQrRTNQ?=
 =?utf-8?B?aW4rUHU5SS9KdjdMRzUrQk1ycGV3K3pyY25BeTlsZUVyeGxhK3VOdlFOTms2?=
 =?utf-8?B?ajFBUEtZc3paOUhDMGR3K0lIRE1RL1dIdU5TMm9ZZlREMDkzK2pPR0dTT0lk?=
 =?utf-8?B?UUY1ZkZUWTZkeWxHd3hHZFNLNkFpMW5GV2JFdG1ZWDhhek9mbjZGaDFucUJQ?=
 =?utf-8?B?MnBpVjVKTUJPbnhTTytyYUdhV2VBV1VPZk12a3l4WThxc1I3cWZyekkzNGty?=
 =?utf-8?B?MFNRL3QxMGdlVHJjbkhxYU9oa0Mza1FoNkhoNGVXY21CMUhmNU42Q2FEbVJO?=
 =?utf-8?B?Q1did0RieElCU1N0cGVRbFN5eXZKZmNZK0YweTRqb2FwUkhkRy80OTRweXlZ?=
 =?utf-8?B?TnZEOVpnR3NJZzVGUXFGZjZBR0FKM3MzaGVQK0F0RHFvNUdwZVVlcUdRdzh0?=
 =?utf-8?B?dG5JaXRUVmF4ZXh3czRWU1JHU3Nabm5xYjYwN1pJT0MxQVVKYTFaZnVzVmdr?=
 =?utf-8?B?WFh2T2RtQnN3QW5lazNjSVNRRmNZQmlPQlNJSFE0ajhKK3ZqVWxnbGVjandh?=
 =?utf-8?B?WlcxREJTRHYzQWxLVUN1RXpOOCswZFRJclJmamJML0EzSFVNb0VtUERKVWlM?=
 =?utf-8?B?eXluMUpvM25sbUF5NjVJRndtYkV1ZlRSN0pwQkNBYThOZEV6MnRUeExQUUFJ?=
 =?utf-8?B?WnRweW5HdEdkN3NhUEE5N1RmSFVlWklDWVplWWZobDlWYVRnUDViM1NMamEr?=
 =?utf-8?B?MGFyVU5kZWJVMS9BM3Q4MnhvcmlrVVcyL25pdmdzVXhCS2ozdGpkUWFhVkI5?=
 =?utf-8?B?NWlzeXZaZmVVeGNxZnNHTjArZW9zaVhXcmJqK1JMbGlkbkpJUWI0V1hCa0Rn?=
 =?utf-8?B?USt0L0RTWm94VDBhbXBNYU9yTzZZUGFlekxNSS9TRHpCWFlVK0NPeXlNWkxE?=
 =?utf-8?B?enFnUUtpcmhVVnVMT1lHS05rRmFJRk9sbEcvS3JHZDI5eXcrZWFlZUMrdWx3?=
 =?utf-8?B?Z1pudVRmRUtNc1ZCa01ZZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXBoQU1rb1FSdE1ocm9qNWVXRHd1c2ZMNlY5T2k3R04rMitPU0NiN0YyaU5j?=
 =?utf-8?B?YWdNRXVYSmFZNzZBb2kyNEp4ZmRrblJmM2FnNEZCdkwrZXpMSUxhdjhBb2J3?=
 =?utf-8?B?dzFIa2RsTjlTSk4xa1JmeE5QMVV6UDI2Nk9NNUlCZmZnT1Jmbk1zRHpRK2RB?=
 =?utf-8?B?alNPa2dWeTBoaUhGUlVxeVBiNzBjMGw0ZFZ6YTVqaU9EMmJWQ09rU1kvL1d3?=
 =?utf-8?B?RVQyejBCa2tDT3VwNFpoL042NlZaY2h2ek9rT25mRjBTK3NCc1FYcVJlS0hZ?=
 =?utf-8?B?WVQxZHZvbWFNK2o4NkxReDFoajdBMnVEWDZYbG5zWUVHbExmUGFIZ1JtcHFO?=
 =?utf-8?B?cmV5RDhzRkZzNDBTR2x2WWRNNFBRbEh1TWZ3QzR6bnl2UWp3cDVGT0JTM2hX?=
 =?utf-8?B?cTlWYzN2U3F5RGdUL0ExcXRMVy9BSUZOUFBvVTltRXFKYmkvWm9JUmRkUVgz?=
 =?utf-8?B?TWtFM0drbXhGeFdKeTVFU1JFODA4ZzZERXdEZlA3R2NoTzExZGQxdWlzTGJn?=
 =?utf-8?B?Uks5RWNkeGJRck1Jcnp0VWpNaHlUNjI3SjB3MUI1TlRBck8yUzdJT3pHK29m?=
 =?utf-8?B?dG5SM1BJWXZCVFBPR0NGRXlnLzZDYnVQK1lmbmk2eTNONGh5bGxKQlpmQnRE?=
 =?utf-8?B?UEg4VEhvK3c2YXlCYU5nL25FYUwyZEpBTUlIQVJtMkJZTGlicjdVZTBpT1pu?=
 =?utf-8?B?ZEhaU1JYNjZ5TTFEblJYZ1RMMUFkZkJ6eVQ3c2VWSHRuR1dSeEJCOUowbllL?=
 =?utf-8?B?czVZbjZXNXFMU2pBM1ByMlZXV2dEL1NGTXUvVitlcDZDMnZoWnVCTlFaUTN5?=
 =?utf-8?B?c3JwVXZ5T0J2cGNhcThITFdrUklwNy8rUGszd1lleElKbGVKaC9RQlhkZ09D?=
 =?utf-8?B?eTI4VmMrM0tjQXZLZ3MzcE5NSzM3QzJDdzZpcU9OL0MxMFhudjJvQ2RNek45?=
 =?utf-8?B?d1g5dWQ3U0hTdmR4NFJnWndFeDF0SU8rVklHd3hBWlJSMDlvT01rNEdtWDkx?=
 =?utf-8?B?TTZhMFl5bldhSlVndHZGNTAzaGtPQU1ZWUVrRWNld1FLQ1U1QUs1ODNOUTFI?=
 =?utf-8?B?VE0yektraVFobVVNNkhSLzczUlR5MWVUNDRjRm1OODlUMFFqQkVqRFJvWG1N?=
 =?utf-8?B?QU9pWXlVdkZ0RytzWUVMTzkxWUUvY0E1T0x5azZFZG1oM3BaTDdmSUNJM2pG?=
 =?utf-8?B?a0dISUp4ano1WVVtbG5lU1BUdDU2MEdDbW0yNVZSRUpqZ0M0M2xKMmpvTkFt?=
 =?utf-8?B?MzQ0SmFYYTA1aWZaSHZHdS9uQTUxTW1XejFUY1FVL2x3a2FiWFlodGdaTXV5?=
 =?utf-8?B?WXJjVUFjT0ZGZTNrMnVxUjJXRWc2R2tlaHJPU01pUS9hTm0wODBkVWpJVVpL?=
 =?utf-8?B?NFRTVHM2VVNaeFQrKzQ2TFVXQ2JyY1FzQmIxZmFiMU9uU0NLb2p4WnY2Vml3?=
 =?utf-8?B?bUZqZFY4Skp2cHZySzBERnIvQktTaU5JTVVYSEQvQ3ZkMUxLQkc3NERjNlpk?=
 =?utf-8?B?VkE4QThEZTVjNGpJVU1SV1pBaEU3MUptZzlZYzRsRFAwQlorOHhacS9rLytj?=
 =?utf-8?B?STUwTlhBOUJSb0tGdTJiemgxODZHOXMwSkFqcXlFdGpFSFg4TGRwM1JjWkdU?=
 =?utf-8?B?S2hHaERjZXVLRGdLUVlTSlZoME1xTE83VGlrdm1wK2svR2xtQlpEaFdmUnoy?=
 =?utf-8?B?SWx5a1lyL0gvY3M4WHYyZmtVOFZBUXBMS3BlbGpLTEFISEdmS2pKZUVMeXpY?=
 =?utf-8?B?YWxpbEVRb1NlUTVlNDdHNk1zTVArL2FYY2R4MTJZOXBBajdmSkgrZkszdzhY?=
 =?utf-8?B?OGRiUlE2K1Y2OG12R0YwSXVSSlpyRnRYK25FSXdGYnNwd2VsbEpjVlpPcXF2?=
 =?utf-8?B?dkFRUVNZNlJWVGw2SGtpZk96NVd6M1RBajRhVFBhWEFiMmJucm9idUVGWGs4?=
 =?utf-8?B?d0FzcFRYOGorTGx5d1Z0VmsrWVdVSlJYZVUwdWNKZHh4SGVVSDlLNGZ5UGpq?=
 =?utf-8?B?OWpyVmtONlRzSFBIUEJoQXZkUFdqZkM4aUlCSk91cmxTcXI2VzR1RmdBOG5Y?=
 =?utf-8?B?UWlxdURkdWZmNVVTa2dDNUhEVk9UUGgyK1YvQzBtSmFITEpiRWh1YWNjQjhu?=
 =?utf-8?B?dDlWYm1KbXVDWThPWXY0cEgybE00RlVXS3BTSVdwcTBxSVZ2MGhrai84OHdh?=
 =?utf-8?B?MFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q/b8a1w3rEOhRpBWcfWGVOXmu36rUDd1kwMP3QetsD96nmA5JZDwej4j+BNmybLoPiRfDdXthR+EfJEmBbSk1akElsFddUJPXURhvKGnkt/1zVPQMM/4omZhHEP/q2he7ZYA3B3ffTnMx978zeAVJR68fVgVbsPEhgu0xai5rL94ZvdP4BUS87J+OME4+ab+OxTR8SOjiEpMtjuwkMcqkTkIlqYG0fxRCm8NFMp1YIWXqC3zV+BVU4kdH8cSwC3W+OLjESX0jIW4g+0uH+dKKLOELxYQYsTvO/3oIoNCPTtM4YNdT3uqJMn8K/Lg1SbuYxEU9U/GIz1mq1VIJlN5iMZEinr9nj+tWVpZBiv8n3R9SbSlIrgiiU/ZwP8aAiQaDtyp+xOvf7vfar18EiPOmoip8A3H1zRrN+T6D1pfrlnlBVmbyhSFEhjD+vW/S3/pAt0TBVvlwavn/B0pzZBDSyG3ndtGHsF0qjnzHIxB17pSFuiDSQr75CpG+2jxWg/NDqUwMzZ5/UKE+irO42ZZ05Ttplo57VI9jm6ZVZl2GDGCE8qqxT6XgayT3IfLcXqpwH9QmQdTzP7P61eSgmNB6RdDGXBsxox6ctyhSmdzxKA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7574fbc1-ffd6-490f-fd29-08dca8f5b53c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2024 19:54:04.2407 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nR0daYSRU5lmBnFWQbsSR4bQ0PHcpIFIvBXrjZb10K5uVI5j80PN7rT9U5uc8y4Gk0UItz6pTGdLKcjWZuC92HJFxymSAadK72mu85C4FB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_17,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200146
X-Proofpoint-GUID: 336ol6adWQVuIO5wiaaGtf2g8_KFL4qh
X-Proofpoint-ORIG-GUID: 336ol6adWQVuIO5wiaaGtf2g8_KFL4qh
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/19/2024 11:03 AM, Peter Xu wrote:
> On Sun, Jun 30, 2024 at 12:40:25PM -0700, Steve Sistare wrote:
>> CPR must save state that is needed after QEMU is restarted, when devices
>> are realized.  Thus the extra state cannot be saved in the migration stream,
>> as objects must already exist before that stream can be loaded.  Instead,
>> define auxilliary state structures and vmstate descriptions, not associated
>> with any registered object, and serialize the aux state to a cpr-specific
>> stream in cpr_state_save.  Deserialize in cpr_state_load after QEMU
>> restarts, before devices are realized.
>>
>> Provide accessors for clients to register file descriptors for saving.
>> The mechanism for passing the fd's to the new process will be specific
>> to each migration mode, and added in subsequent patches.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   include/migration/cpr.h |  21 ++++++
>>   migration/cpr.c         | 188 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/meson.build   |   1 +
>>   migration/migration.c   |   6 ++
>>   migration/trace-events  |   5 ++
>>   system/vl.c             |   3 +
>>   6 files changed, 224 insertions(+)
>>   create mode 100644 include/migration/cpr.h
>>   create mode 100644 migration/cpr.c
>>
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> new file mode 100644
>> index 0000000..8e7e705
>> --- /dev/null
>> +++ b/include/migration/cpr.h
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Copyright (c) 2021, 2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#ifndef MIGRATION_CPR_H
>> +#define MIGRATION_CPR_H
>> +
>> +typedef int (*cpr_walk_fd_cb)(int fd);
>> +void cpr_save_fd(const char *name, int id, int fd);
>> +void cpr_delete_fd(const char *name, int id);
>> +int cpr_find_fd(const char *name, int id);
>> +int cpr_walk_fd(cpr_walk_fd_cb cb);
>> +void cpr_resave_fd(const char *name, int id, int fd);
>> +
>> +int cpr_state_save(Error **errp);
>> +int cpr_state_load(Error **errp);
>> +
>> +#endif
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> new file mode 100644
>> index 0000000..313e74e
>> --- /dev/null
>> +++ b/migration/cpr.c
>> @@ -0,0 +1,188 @@
>> +/*
>> + * Copyright (c) 2021-2024 Oracle and/or its affiliates.
>> + *
>> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
>> + * See the COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qapi/error.h"
>> +#include "migration/cpr.h"
>> +#include "migration/misc.h"
>> +#include "migration/qemu-file.h"
>> +#include "migration/savevm.h"
>> +#include "migration/vmstate.h"
>> +#include "sysemu/runstate.h"
>> +#include "trace.h"
>> +
>> +/*************************************************************************/
>> +/* cpr state container for all information to be saved. */
>> +
>> +typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
>> +
>> +typedef struct CprState {
>> +    CprFdList fds;
>> +} CprState;
>> +
>> +static CprState cpr_state;
>> +
>> +/****************************************************************************/
>> +
>> +typedef struct CprFd {
>> +    char *name;
>> +    unsigned int namelen;
>> +    int id;
>> +    int fd;
> 
> [1]
> 
>> +    QLIST_ENTRY(CprFd) next;
>> +} CprFd;
>> +
>> +static const VMStateDescription vmstate_cpr_fd = {
>> +    .name = "cpr fd",
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_UINT32(namelen, CprFd),
>> +        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
>> +        VMSTATE_INT32(id, CprFd),
>> +        VMSTATE_INT32(fd, CprFd),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>> +void cpr_save_fd(const char *name, int id, int fd)
>> +{
>> +    CprFd *elem = g_new0(CprFd, 1);
>> +
>> +    trace_cpr_save_fd(name, id, fd);
>> +    elem->name = g_strdup(name);
>> +    elem->namelen = strlen(name) + 1;
>> +    elem->id = id;
>> +    elem->fd = fd;
>> +    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
>> +}
>> +
>> +static CprFd *find_fd(CprFdList *head, const char *name, int id)
>> +{
>> +    CprFd *elem;
>> +
>> +    QLIST_FOREACH(elem, head, next) {
>> +        if (!strcmp(elem->name, name) && elem->id == id) {
>> +            return elem;
>> +        }
>> +    }
>> +    return NULL;
>> +}
>> +
>> +void cpr_delete_fd(const char *name, int id)
>> +{
>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>> +
>> +    if (elem) {
>> +        QLIST_REMOVE(elem, next);
>> +        g_free(elem->name);
>> +        g_free(elem);
>> +    }
>> +
>> +    trace_cpr_delete_fd(name, id);
>> +}
>> +
>> +int cpr_find_fd(const char *name, int id)
>> +{
>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>> +    int fd = elem ? elem->fd : -1;
>> +
>> +    trace_cpr_find_fd(name, id, fd);
>> +    return fd;
>> +}
>> +
>> +int cpr_walk_fd(cpr_walk_fd_cb cb)
>> +{
>> +    CprFd *elem;
>> +
>> +    QLIST_FOREACH(elem, &cpr_state.fds, next) {
>> +        if (elem->fd >= 0 && cb(elem->fd)) {
>> +            return 1;
>> +        }
>> +    }
>> +    return 0;
>> +}
>> +
>> +void cpr_resave_fd(const char *name, int id, int fd)
>> +{
>> +    CprFd *elem = find_fd(&cpr_state.fds, name, id);
>> +    int old_fd = elem ? elem->fd : -1;
>> +
>> +    if (old_fd < 0) {
>> +        cpr_save_fd(name, id, fd);
> 
> I don't think I know well on when old_fd<0 would happen yet, as this series
> doesn't look like to use this function at all.  From that POV, maybe nice
> to add a comment above [1] for "fd" field.
cpr_resave_fd can simplify client logic.  It allows the same name,fd,id triplet to
be (re) saved without creating a duplicate entry.  The vfio series uses it.  Yes,
I should add some brief API docs in the header file.

> Meanwhile, do we need to remove the old_fd<0 element here, or is it
> intended to keep that and the new CprFD?

old_fd < 0 is not an entry, it means no entry was found.

>> +    } else if (old_fd != fd) {
>> +        error_setg(&error_fatal,
>> +                   "internal error: cpr fd '%s' id %d value %d "
>> +                   "already saved with a different value %d",
>> +                   name, id, fd, old_fd);
>> +    }
>> +}
>> +/*************************************************************************/
>> +#define CPR_STATE "CprState"
>> +
>> +static const VMStateDescription vmstate_cpr_state = {
>> +    .name = CPR_STATE,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .fields = (VMStateField[]) {
>> +        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +/*************************************************************************/
>> +
>> +int cpr_state_save(Error **errp)
>> +{
>> +    int ret;
>> +    QEMUFile *f;
>> +
>> +    /* set f based on mode in a later patch in this series */
>> +    return 0;
>> +
>> +    qemu_put_be32(f, QEMU_VM_FILE_MAGIC);
>> +    qemu_put_be32(f, QEMU_VM_FILE_VERSION);
> 
> Having magic/version makes sense to me, though I'd suggest we use CPR new
> magic/versions, so that if we see an binary dump we know what it is, and we
> don't mixup a CPR image against a migration stream image.

Will do.

>> +
>> +    ret = vmstate_save_state(f, &vmstate_cpr_state, &cpr_state, 0);
> 
> s/0/NULL/

Will do.

>> +    if (ret) {
>> +        error_setg(errp, "vmstate_save_state error %d", ret);
>> +    }
> 
> Can consider using vmstate_save_state_with_err().

Cool, will do.

>> +
>> +    qemu_fclose(f);
>> +    return ret;
>> +}
>> +
>> +int cpr_state_load(Error **errp)
>> +{
>> +    int ret;
>> +    uint32_t v;
>> +    QEMUFile *f;
>> +
>> +    /* set f based on mode in a later patch in this series */
>> +    return 0;
>> +
>> +    v = qemu_get_be32(f);
>> +    if (v != QEMU_VM_FILE_MAGIC) {
>> +        error_setg(errp, "Not a migration stream (bad magic %x)", v);
>> +        qemu_fclose(f);
>> +        return -EINVAL;
>> +    }
>> +    v = qemu_get_be32(f);
>> +    if (v != QEMU_VM_FILE_VERSION) {
>> +        error_setg(errp, "Unsupported migration stream version %d", v);
>> +        qemu_fclose(f);
>> +        return -ENOTSUP;
>> +    }
>> +
>> +    ret = vmstate_load_state(f, &vmstate_cpr_state, &cpr_state, 1);
>> +    if (ret) {
>> +        error_setg(errp, "vmstate_load_state error %d", ret);
>> +    }
> 
> Simiarly, can use vmstate_save_state_with_err().

Hmm, vmstate_load_state_with_err does not exist.

>> +
>> +    qemu_fclose(f);
>> +    return ret;
>> +}
>> +
>> diff --git a/migration/meson.build b/migration/meson.build
>> index 5ce2acb4..87feb4c 100644
>> --- a/migration/meson.build
>> +++ b/migration/meson.build
>> @@ -13,6 +13,7 @@ system_ss.add(files(
>>     'block-dirty-bitmap.c',
>>     'channel.c',
>>     'channel-block.c',
>> +  'cpr.c',
>>     'dirtyrate.c',
>>     'exec.c',
>>     'fd.c',
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 3dea06d..e394ad7 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -27,6 +27,7 @@
>>   #include "sysemu/cpu-throttle.h"
>>   #include "rdma.h"
>>   #include "ram.h"
>> +#include "migration/cpr.h"
>>   #include "migration/global_state.h"
>>   #include "migration/misc.h"
>>   #include "migration.h"
>> @@ -2118,6 +2119,10 @@ void qmp_migrate(const char *uri, bool has_channels,
>>           }
>>       }
>>   
>> +    if (cpr_state_save(&local_err)) {
>> +        goto out;
>> +    }
>> +
>>       if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
>>           SocketAddress *saddr = &addr->u.socket;
>>           if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
>> @@ -2142,6 +2147,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>                             MIGRATION_STATUS_FAILED);
>>       }
>>   
>> +out:
>>       if (local_err) {
>>           if (!resume_requested) {
>>               yank_unregister_instance(MIGRATION_YANK_INSTANCE);
>> diff --git a/migration/trace-events b/migration/trace-events
>> index 0b7c332..173f2c0 100644
>> --- a/migration/trace-events
>> +++ b/migration/trace-events
>> @@ -340,6 +340,11 @@ colo_receive_message(const char *msg) "Receive '%s' message"
>>   # colo-failover.c
>>   colo_failover_set_state(const char *new_state) "new state %s"
>>   
>> +# cpr.c
>> +cpr_save_fd(const char *name, int id, int fd) "%s, id %d, fd %d"
>> +cpr_delete_fd(const char *name, int id) "%s, id %d"
>> +cpr_find_fd(const char *name, int id, int fd) "%s, id %d returns %d"
>> +
>>   # block-dirty-bitmap.c
>>   send_bitmap_header_enter(void) ""
>>   send_bitmap_bits(uint32_t flags, uint64_t start_sector, uint32_t nr_sectors, uint64_t data_size) "flags: 0x%x, start_sector: %" PRIu64 ", nr_sectors: %" PRIu32 ", data_size: %" PRIu64
>> diff --git a/system/vl.c b/system/vl.c
>> index 03951be..6521ee3 100644
>> --- a/system/vl.c
>> +++ b/system/vl.c
>> @@ -77,6 +77,7 @@
>>   #include "hw/block/block.h"
>>   #include "hw/i386/x86.h"
>>   #include "hw/i386/pc.h"
>> +#include "migration/cpr.h"
>>   #include "migration/misc.h"
>>   #include "migration/snapshot.h"
>>   #include "sysemu/tpm.h"
>> @@ -3713,6 +3714,8 @@ void qemu_init(int argc, char **argv)
>>   
>>       qemu_create_machine(machine_opts_dict);
>>   
>> +    cpr_state_load(&error_fatal);
> 
> Might be good to add a rich comment here explaining the decision on why
> loading here; I think most of the tricks lie here.  E.g., it needs to be
> before XXX and it needs to be after YYY.

Will do.

- Steve

