Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4FDE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 19:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO06v-0005yV-TS; Wed, 18 Dec 2024 14:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO06t-0005jf-Dp
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:31 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tO06r-0001gf-Rm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 14:53:31 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BIHQlVX012937;
 Wed, 18 Dec 2024 19:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=D34BLz58B7dRZZggflVI074OPdRHH59RWBEbnmilRLM=; b=
 A/DZ8qUXitkdeAA+4TpdZQUItSciuH9T+TICFOm3oSUQCAOiqP9skUjXjRt6/ERS
 RrXXE4RqrpwBlNxGtPPmqso9d/qQa965pWykk1joO6gujgemYIU5F/Ss+nMS2zdE
 iveTJWljIKzk5292FxhETddJJgtlU6xqWSQtmVkdb+GgOnyDOBgquYPtMvo7PMbp
 6vheiZRwnpHxtSig8zRTwAW/w78jSnl3brIRbcusvuf0C7HS7KjKGROheTVbWT/u
 O/IrxcYf08n//tbxilzwnwUplYT41LsDhmAIQcXwR9PKLTm1zMfg4uAkNwP7hbKp
 DNFDRMOCoLCxtDIVfFRfiA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0xb1jbm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 19:53:25 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BIJDuci006409; Wed, 18 Dec 2024 19:53:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0fb5u11-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Dec 2024 19:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3rM7QBpNvCEyucgBxS/IF+y1PZml9+ctRAmiI/zOYdz6wTEGoD07UPREIhqYyVczgO66YezlHwCdGGahNWioFSXlMHUPDzRRuKGzBwK0eoPxXcriBukPeB75b0wUHNMK/hQE+7opaxZD6+heqg7WPFznJcZ/YDtCSW7zUjROJ5sld6ZkCTNT1VFUVOaBjnnCf2Nlw7R9UjgJtCy+A/WIyHytEx+U3pbJrPiYlBVp8j+GZwm/gTgTGmikmlMr8yhjYNas8upXqyzIMNgV5FlawxOI48vDfAJjCwwhxYnC/EASHkjWHh2bsjEb3YnnXS+pCl//HRMTtovD/FHSzChUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D34BLz58B7dRZZggflVI074OPdRHH59RWBEbnmilRLM=;
 b=Ig+liXShQUZToClQ9FTnBCc83SZlrh1sodkqS++UX/X7IXaUIgaHSfvKzHw0y9+Z7lxNGrKh75GdTd7ejV9J6zpl9Hp9cKwEFW+0tCIwupvAb+qqcF1qJiucOUU6wAuVOkyVSOv2VCtdPgW6FWqJWLCb/Sb5YToSIxeG97GKU+ZKkdi3gAvm1Ht5VoY4tPWt+Vv5fhXYo201M5hprYKqtPzTi4T1ghn2IwtLcjoSl6D1Wzpobv1vDjtVMGcLc+tY64Elpj0PdBpwlL9/chIouYEeTpL0tPZ9chCMKiCCc9aRTMG4TqSS9l6pg3gqW0D/W9qaPmjvEOAxaRQhLWevJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D34BLz58B7dRZZggflVI074OPdRHH59RWBEbnmilRLM=;
 b=fsC2m5jrW2fwcaog5ciQTAbWnSo6ksTG0eGmWXz43SC1Fk/2IHiXbWOwlTS3rlbtO5FOJq0Z2/OX5TrEo20ySA2BnxqkXhmR9NT1Soj4Pydx9LAN/IzDtS6fCv2hknfbEKKRsbXYNsb1AitttdKuJ7D9TMH/GHmtIAygH+DzZNM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM6PR10MB4377.namprd10.prod.outlook.com (2603:10b6:5:21a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Wed, 18 Dec
 2024 19:53:22 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 19:53:22 +0000
Message-ID: <eef4a569-2f1e-4e5d-b2e1-31aed7b807fe@oracle.com>
Date: Wed, 18 Dec 2024 14:53:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 10/19] migration: cpr channel
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-11-git-send-email-steven.sistare@oracle.com>
 <87cyi6cf9k.fsf@pond.sub.org>
 <2ac9265b-0092-4636-8238-91331834ea77@oracle.com>
 <877c8d6ttp.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <877c8d6ttp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0123.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::8) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM6PR10MB4377:EE_
X-MS-Office365-Filtering-Correlation-Id: 386db15e-c51f-425c-1edd-08dd1f9da0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVF0TWE1RnZTZFZrSlFIRHlnUHBKYmttZWRmaTlnVW9LeHArU2VVS1gvT1F4?=
 =?utf-8?B?RVFieWZidUxrbmg4OE9TK0VQSVd4aWkrYXBITTJoUDcxdHN5SCtDTzBxZlVF?=
 =?utf-8?B?Vkw2U0tnalZYcjlaTmdmNTV3UHA0S0Y4OTRpb3ljTm11TzdNeFNuOWRGUWph?=
 =?utf-8?B?MTltNnQwL1NRTjE0a0RUdld4cFpwb3VFbEhoL3k1SlRkMG1hL2Q3SXA1VUxW?=
 =?utf-8?B?MVNrYnRoVE9jVXpqWnFKZ0I1QWNKZk84NndGU3Q3MkIwbkM1YVdLZE5BbS8z?=
 =?utf-8?B?QTVxdTBWei9OWG9ITU44ejNjTTNVQzE1STlzbkRHTTgvQ3orbjlZbDlrT0kr?=
 =?utf-8?B?dEJORmpYOXFpbHM5eUVBSXQ2SFhZS0o0bHFJeWJJOFU3Q2xDbzhLa0dRdDRH?=
 =?utf-8?B?VXBNSmJrRnJrU2FiWEgzYzR2ZWxNTktxdi9lU0FNM1J2OUdzQ2pWQThvMkFK?=
 =?utf-8?B?WWM1YUFSRFJiTGI4c04yVUJqdU5pUmx6RFhDU05aVEpOOGNtQTM1S2lIbjA5?=
 =?utf-8?B?RWJIMzg1Si80ZzBySzEvNnNuWnl6bEJDSlhBeWpGUGdQRmN2Rm83Q2lFREF4?=
 =?utf-8?B?ZVJCb1FIZy9qMmdibEhSTElyc0FTOCsxVUs0Zm5DSDEzWFZPcTc0amFmajNK?=
 =?utf-8?B?QlhhZUFHRUZTRHIyUVo2MnI3MUlvZloyWit6Zkp4c0cvaWxYWkxWbzQ4K2Ju?=
 =?utf-8?B?NUVKTkF0WW5oU3hIeHpVQmFKSTBFSWdjK01qZUhJM2FKb3FvWmdKWXFKNzc4?=
 =?utf-8?B?TnJGeGMvVW1Wb3RIaVR0QURWTkRPbVpqVlovWG80WFVvTkVaQ2F3TlZMK1Zt?=
 =?utf-8?B?Zm5XbklnSUg4cVNUWDdrdDBGWjZGZHZGTlVqZ1ZIMGFTL1JxM00weG9rZVB6?=
 =?utf-8?B?eXNUS0VWMWVpVFZlQkx4dGdrUlBmdWNEK0Z3NTcrZnczWjYvRWxpUUpiRUFS?=
 =?utf-8?B?MkttcVorYWNsa2xVSUNsOG9LWnJRcFdZejZjR3dTYVdZbklrWnU4bE5MeTgw?=
 =?utf-8?B?aEJsWURjNmlNVFZhajE5THltUDRUT3RzV3kvS2hWUE51RmhFZk1jYnFSdXpP?=
 =?utf-8?B?V2poTUNIL1l6Q3Y3MHlPZWFPbW5rL3ptNVRKYUxPeHFnaER5UlVlRmoyT2Jn?=
 =?utf-8?B?MXUyNW4rSGZZQndTUUcxSnVWTDNvSHFNdmFnRk9md3RQTXMrZzFmUDl3T3JF?=
 =?utf-8?B?b09hWU53WklseDhhWnJwL0svZ20xQzN2ZGdPaGRsVnJEaGdXZndLNGhwUzhP?=
 =?utf-8?B?UzRudnIyand6Ni9pUHZMa1IyMmRPWWdWb3BaQUNnNkxCV3d6RmVmbjIvY0hM?=
 =?utf-8?B?QWJVRnFEcDJ1NDdGY0JGRlZYU3NZNTllL1NabURhL1UyN20wS0ptV29HYnZy?=
 =?utf-8?B?S3VOeHhRcUFQUTEvN01DRndQam9GNCtIM1Y0YXBtUTQvTFdGbUV6MFFHamp0?=
 =?utf-8?B?OEViYnN4MGRNWTZmeXFCTGVpS0Vqc3hnOThHZld0Z2o2S1Z0UUUyZ1h1YUlq?=
 =?utf-8?B?aEJERGpsTTRvZjkxOWE3VGxLWUxsc1BYNGhQdkdrNTFHK3pMbW9TeGY2RDRm?=
 =?utf-8?B?a0RJQlJYWGF5bk1KRlhXcGxDaFV4Z3NUb0RpR1FaelBKS3ZsN1l3UjdXQ0hT?=
 =?utf-8?B?OFYwV2NTL0l6Tmxubk80QnlNdFZLNW1nZENVYjJIZEUzSkNCdGtYQTcvRW5P?=
 =?utf-8?B?R0NjNytJVzFEeEJrRW9iZVRNNDEwS21IZjlxTXpoUjd5cmhEdnJSMXAxQjJK?=
 =?utf-8?B?a0M1SDQ4amVNWFdXRGwvM1pWMXh3bkFGZUp5QW95QmRoa1dHSTdlSVVRdEZa?=
 =?utf-8?B?Q1cwSDFTVHV0N2NRTDI0aFpSMVV1WThXUFhTOEhyOVgzWEc5eVlCd1d0M3NI?=
 =?utf-8?Q?HmTsmg2UQI5Sl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFFPNS9PSGgvSjg3UHkxU2FrWVdzWGZuTytIeTBWL1F5cUVWRG5wM1YxVjdZ?=
 =?utf-8?B?YlBkU2h3bS9xWW0xM2F0Y1gyU1VUSDA2enhGVGhuZHhldWp0TGxmMTZ5c1RL?=
 =?utf-8?B?ZGU1S0hCQ1BWdEhab01vU3lldC9XK2N0SGNMKzF5WlY5Zzlkd3dYQWdSWGcx?=
 =?utf-8?B?N0MwOVNhODV6dU0yZHhxMVcwK1hwWXVWUEZmWkhsekwwbmROa0lYbVVZQUtU?=
 =?utf-8?B?ZWcrS0VSYVJnaVc4Zk9QVTYrcEl0WHg1NVdjdHhHQnpWMjlINjRpNUFNOGkw?=
 =?utf-8?B?WlBPQjJ0OGtwdnRFNU5VQyt3YUJPaVYzM2t5OHRTMTZqdGthVVlHTXIxSGpB?=
 =?utf-8?B?U2QxR3F5WDlTNmYwMXN1OWZMTGMvbzljanQ5MFZ1K0Z2Q1VNVm95MjU5ME1S?=
 =?utf-8?B?ODh3U25iZzUyYnB3TERlL0pqUG1Lck1Mc3l4NjhMS3BxaEEwcVptRmFyT0x5?=
 =?utf-8?B?TFIyWS9WQWlmcmhTVjhBY3kxSmRER2JNdkkvK01xdS9SZXpoTHgxMkJMdWVF?=
 =?utf-8?B?UHROa3pUVStmdXJXSk5zTTZWdnRzWXQzY2xyTWpBZ2o0MVpIa2pIVFkwTk81?=
 =?utf-8?B?cXJwMDhNbnUyYW9QRUVUQThpckdyZ040WFJmY3NodmNvVThBSmhqRmdpSS96?=
 =?utf-8?B?cEJqTUhKdlJVd1ZyU1NRVGxvVE1XcXBaM2pLYVRoUjZIQlh0anNpb3N3UzZ4?=
 =?utf-8?B?VmZWYlJpd29OSlpzVVJxUTlZNUhrV3dIRzFWaExUalhIc25ZQVZUTnZ1MjRY?=
 =?utf-8?B?WUg5R3RSeXV4RmVGa01YUy9WQys2ZWlDNDZxRUxsanpEVWZ1ZU5FRXNmZTA5?=
 =?utf-8?B?SSsvclNXNHkwZE00NFVkaUNZRGFlUDRoY0wzRzZDNE1iQmhVZmEvRlZ2cThw?=
 =?utf-8?B?QVMzeGw4VWNoaFdJNUZ5bnpFYkNnalNRdXlFRW5KTDNTTk9jZC9lTXUwcHZn?=
 =?utf-8?B?U1ZNZVVBNHpYaU9YZ2FyZjQzY21lOWpBdGhLNUJkaDU4bm84S2xKRVR1SG82?=
 =?utf-8?B?anFhZllzaEdKUUJxQUduQ0dMT2d6RHdnZXFNZzQ2a1NOZ2xTdGlFcUdvQTl4?=
 =?utf-8?B?MU5UM3Ywb3N1UnpSNXJnSzdhbDhRTEZrTWwrS0hJQjVwMVRxLzhVS0RseEFn?=
 =?utf-8?B?YWpNNjhPckFZOHRsQkhQOHZ6ek1yN0ZHWVY1Yjh4dWFkbGNMaFJ4V3VoTFBI?=
 =?utf-8?B?R05YR3NaNktlVFM2bHV0TnBhSUVSdlFqakNOMWVFMWpEbWc5dTliU1RFa3lV?=
 =?utf-8?B?Sittc0R2d3R5UXJMYmt6Zkl6Uy9CK2IwNVBpSEJCYWVVWk0yMmltc2wyd1Bj?=
 =?utf-8?B?Nmhya0tqNXk4L3lpUDhiNGNPK1JZMUxVZXFhQld1NklmcG9FdVdoNVYrTDV0?=
 =?utf-8?B?MGpZVXI2YXFPa2ZPN0x5R3ZGUDNubEp5dzZYUDZkWnBjVHN6WUNkR2E0Mzla?=
 =?utf-8?B?QzVETXdRM2JiM2ptTGQ5elVGVWdreGdyTEE3WkJLbWVSb3YyRlh0blhEWEQv?=
 =?utf-8?B?UnRhcHBkdm1WZzZVZGQvRStIRWhucXFIWHNXMHV1U2lWL2tUajZsUUpvaERW?=
 =?utf-8?B?MjJua1NxQll1ZHN0YnNSRm9BNGEwUkRjaEJwNVV5aWZvU3o4SXZ0VzBReDVp?=
 =?utf-8?B?ZWVkUXR4SmhqbVFqTS9jNEZiY0lJMGRTT1NIKy84N1E0ODh2K1A5UGpxalRs?=
 =?utf-8?B?S2p1L2J3VmZVRDAySFRtOGY4V2ZmUXZXK3pVY0pTZU4rM09kdVd2YzJmMlpr?=
 =?utf-8?B?YmJTNzBIQjUyTGIrWEUwYVE5cGhUd1BaWUZQT3NrZ3VOY1JKd082TEtZclgz?=
 =?utf-8?B?c3VwUzJJOEQyUE1aTjBjRFJQb2xZMzBCektycUt4YlViR2FUdDExamZFTmNo?=
 =?utf-8?B?OE1tRzhtZUhTNVowN0VwNmI2MlVYYWhJdzUzdFVreEtRa1ZIMm5xeGdMdTZF?=
 =?utf-8?B?R3JCYlZ4REtVTjJYLzk4dFlJemlycjhOcEE0cXJSMWZwVnRGRTJpTmtmL1Jk?=
 =?utf-8?B?OWdxQS9nbDlNakd5bXNnd2lTR1FiRmtiYnV5UDhabHdGQnVsenUrajhkY2J5?=
 =?utf-8?B?eUlnSzc1em1WKy9FaGdNMFBYSlVRejRrYjlzS0hzYTdVRjk3NW8zV1JZM1l3?=
 =?utf-8?B?NnFqNC8yZ1dCL0lvcDRRZlhPSWFURzJGNkt0d2NMQ0svUDZScXZHVXNScFZV?=
 =?utf-8?B?R2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: JB9PISAUXvF/dO6iXg5Vv6c8GGYQRLsWqT88Xqt9EnzLjv/PjKMQhYRESBlA9gHI/Fk9qfhUlApojyVdkhNH/2IkPb5j8ThJKax5xOZL+5Lw/5YHTy1ZbyIGQBYzZBYYngqnCIXsQWvVWpSwigR6jiEhTp5FBrUA0icsEhlzaUJ7yVcdLBe424YVwnmzNqUlh2Hp2hNhYU6CZsuUj+6jV7zu90F8UsAY3SrJvFwoy4E4PZrZlc8F6wKCYVL/MMPDFCJzLjr7FVzvY8IGSBUe+2s+LEzJYacMGZy/vtHBzXmKvkv9dX2zzB68to5r3mm06M5RWNGqaXc6Aq2Dk5Cv4DUxkJAYEdbHZ9Ygz2gwQMbwNbZfajt3oM4NMDqxXF1kl1ZJXFMyDGQHj+UrewztIiYn62Bucc5iJbSkbc+/lafyhahKDEIqX36qQOa4P/bLd2QyX93MlpPyfUVs/r0YnnlXTQyChEbI2Mo0LsI+q9Mx3omAAjiTBoNRfWabu56zsJGMv+VOh9v/97sOS1WN/2FpzUHtmMFkvKgB6CCk/ok9CP1RcnoD1TDfcdw+he0MaHpJU93YdmoWbFmIdM9yBhjU7+26W29pUDblfJUdcjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 386db15e-c51f-425c-1edd-08dd1f9da0e6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 19:53:22.7982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Pw0K9vxOmJEUVr3bCAFJ5ajxi26AZacMpcTO242EK1BqHClK+4STSsEvOFvWTZJzFlZjt9Dk1vSwitk1ueFf0PT8L++o/6WvfdHNg8/Ze8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4377
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-18_06,2024-12-18_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412180154
X-Proofpoint-GUID: WYvEyIqBMRROyrRe8Rt4oBNULk8cJnyH
X-Proofpoint-ORIG-GUID: WYvEyIqBMRROyrRe8Rt4oBNULk8cJnyH
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.116,
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

On 12/6/2024 4:31 AM, Markus Armbruster wrote:
> Steven Sistare <steven.sistare@oracle.com> writes:
> 
>> On 12/5/2024 10:37 AM, Markus Armbruster wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>
>>>> Add the 'cpr' channel type, and stash the incoming cpr channel for use
>>>> in a subsequent patch.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> [...]
>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index a605dc2..a26960b 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -1578,11 +1578,12 @@
>>>>   # The migration channel-type request options.
>>>>   #
>>>>   # @main: Main outbound migration channel.
>>>> +# @cpr: cpr state channel.
>>>>
>>> What does "cpr" stand for?
>>
>> docs/devel/migration/CPR.rst:  CheckPoint and Restart (CPR)
> 
> Suggest something like
> 
>       # The migration channel-type request options.
>       #
>       # @main: Main outbound migration channel.
>       #
>       # @cpr: Checkpoint and restart state channel
> 
> A quick glance at docs/devel/migration/CPR.rst makes me wonder: is that
> really *developer* documentation?
> 
> Should we have something meant for *users*, too?  QAPI docs could then
> link to it.

I agree, CPR.rst is user documentation.

Peter, are you OK with me moving it to the "System Emulation" section of
the documention?

- Steve



