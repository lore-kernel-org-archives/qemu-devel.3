Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51106C83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFgG-0006KY-Ar; Fri, 11 Jul 2025 11:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFbe-0006My-Ko
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:24:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFba-00050i-RV
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:24:09 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BFHPfv017380;
 Fri, 11 Jul 2025 15:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Qo41WEzBdjuEIVdd03IBnoaKHzhTltl3MRoZOVbmlQg=; b=
 qy5MUQntm4tuA5iaQFJtKaanXlENDhgUPc5bOrwBvKcIUgWLudzwp0mFQkIuDvwp
 Rp2KOK32XOpI4ZS3j+5uTpDceNffXckN7UJ9SAbRHkqLcOUSoU3PSuyPtoFX5qYN
 mmIkS16+JpBO4VYlGxXrywc+dVOVZk95o7VPg2E9apvb9WHx1MKbfc/rh8I1RsjX
 cvYVIaCDa2j9a+hStAPRUV7+uy/kC0l+4DoikzMw0+IFLRTvLtlKoRPtNmQvnzWX
 eo6Kn4OPW/4cjjU8cm5iMHuuV5msne0F9k3t4iJ3XZbLUeY5FbkqMIaikFpHiwf/
 ax4l6Ds7MQs5Dgfkdwak6A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u545r0er-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:24:01 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BEAuq2014299; Fri, 11 Jul 2025 15:24:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgefrqn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8GqVo6R1qkBfoEi5B/A7+kIAjnMSG7RVNYoU0HEO21cWTNBR7pv/5cEv4GBxTu6XVcj+35RlLxUZPxkdhGAqyRk2yfk6ziLSiHvxzFKZGkwBubFsWwc5m85GTpA0uQKUFjB70DWAJ40/ai6V1BFygDxuSQjFeVRvFAwE5ZMtYSs3FF4Be4k2psrmgBigSn9YiKhPmRLQ6F4cXef6HdMta3wtnZDDziMBCPor/C/OHB4/aBW7hDYgtaP/3KJEIdRvlV2keVEjB/ZnSSIykyjvNLNwQB+PONmnI+APnj3j3xJAfFX1F8KiPDdF/J1gsal0CQS9enrmFX3qMGSSfywxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qo41WEzBdjuEIVdd03IBnoaKHzhTltl3MRoZOVbmlQg=;
 b=pvfmrY2pI66ZFzStsJyuotZI2hn3M9UhYwaSi1uuBzr9ibIuFqW6/tK2gjO4UJOBEp1SJfEi/U2llxYjibYivjTJLxgzVZV+VJc4g0bkJ64aS1xtTM/vYeEsGDGta8f33RaETsS7LI5uo2cg3b9xeN6UdXi8cWHmkZRgxpltNXwxw4GrJyDzbF6od0tTIt1uwSQYazdaHeaa4bs9BXmjx8aPCp5qJW30k6TaIMN/MxIKjzUM7zUYwnrHIMuank2smJ8mQ2yPy84HSPt48126ib5nPHpL/0dDgNll4WIveiZCWr6UuzTEy5UkX7rYhnVthDcOIvvOo/lL5fTVWC+dtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qo41WEzBdjuEIVdd03IBnoaKHzhTltl3MRoZOVbmlQg=;
 b=xriG6gR4pf1+vITP8c7XXQVtKBL22J5xJvnbWWNmIyhM4iG4HKPbCFAX61AhPHEEgvmdttTFudjvP6rD24ZDDJJAUETKYNJe8tZxy80hrtA4kTdcbe7H52YfMZMkK2ElM3oSClVxshesUOkxBKrP/IT44hpO/xJ4XIeUHgMF1rk=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by PH7PR10MB7054.namprd10.prod.outlook.com (2603:10b6:510:276::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 15:23:32 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 15:23:32 +0000
Message-ID: <93f88786-c1ad-471f-9c3f-6c9033287365@oracle.com>
Date: Fri, 11 Jul 2025 11:23:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/3] tests/qtest/qom-test: unit test for qom-list-getv
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-4-git-send-email-steven.sistare@oracle.com>
 <87qzymvkhv.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <87qzymvkhv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:510:339::24) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|PH7PR10MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2331e5-8183-4a92-bef4-08ddc08ee58d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFkyVHJkVVNaeHd1Y0gwOVhWRXpqRmNqWFRtd3lNdEVCS2ZPeUZxbHNwSzRK?=
 =?utf-8?B?eVg4VVl0T0p5aTZvR1FCT3VTWS9ocGxkaXpveDkzd1BjQ0p2b0xVWklyeVNv?=
 =?utf-8?B?WkIwbUpVZkJ5ZnlwTzEraUQ5bnFxb0dOVjNwbVBldDJNQ285RGlmN09Hd3VO?=
 =?utf-8?B?L0xLdmx1cGJqaDZsbG16REtCNlhRcjNITUtTWUo4bW5NSk5makRrOHJ3bnRn?=
 =?utf-8?B?c3JiUkR2MXVENXJPY2N4bGYzU09TZm9paE5xYlNvR1htenRFQzEraTRicUxC?=
 =?utf-8?B?K1k1MklQSGl4aFE0bEw1RTFzSkk3dTlNMXVZOU5vYkFvemNkNWs4QU14M1dt?=
 =?utf-8?B?VVUvOElJWVhRTUFHdmEweVlXd2g0WVRkTnE0MkFNZmN6c1YvZGhkaVFKZzZT?=
 =?utf-8?B?VjBwMlRxZEM1VmFielBZeG5sY3NWcTBVNkwxaTlHK2gxdmJFZndkNDRLbU56?=
 =?utf-8?B?NE16dFBOTFcvTlk5SE84WDhDc1gxNHA4TjRYRGRjaUZkR3RydFp6ZmxNS0lT?=
 =?utf-8?B?WnJRTGhIc2UxSlRCWWRMYi85RGFVa1E5TE9pN1FCakdRb2NXdElRcm1GRkVn?=
 =?utf-8?B?bHRlS1hEUGxvdG1ZK2JuMmNudzRNTFpJb3hwSXZQamFLUUVNMmUzK2M3SjFh?=
 =?utf-8?B?Q1hic2xSMjAwVE8xOHRIdk9WQndSZ0NjczFEMFBzeDhyWHpIZW5NV1pFYXFs?=
 =?utf-8?B?ZEE1OFI3TDZZSXIzNWFlR0JoSnlIaG1DZ0xtb3BpRmZldkJpQ1RHTTVIVnIz?=
 =?utf-8?B?VlpmL0FnVXFMSUUzMWdrSS9CK3o1UjlwMU5MNUFrM2kxMU9hTGphT0YrKzA3?=
 =?utf-8?B?MmtoYnJSMGlERlY3cjhrME5nUkJWUDBSOHpvb2xNZ0loa2F5K2NRZWZzU2x4?=
 =?utf-8?B?ejY3MzRHc1ZRUktCSWo3RmhPVmtUd2pTdlFSVW1aY3dDNmNCS1QrbmNIY1pa?=
 =?utf-8?B?TlJqbDFYaG5BRDVSY3Z3cGtWbGIrOGFYbjNKdmV2dVUyejFXc251dEZ2Yi9E?=
 =?utf-8?B?RTVOaGRYaGtVZ1BoL251dkZ6d1kvUnI0SVVUTW5Bem9SR0FpanpsUUlVOGJy?=
 =?utf-8?B?UEhnY0xNWUdGYTdPT3ZvakhjOEZCSkpHZDlYVDFQVHBvekc0NC82SU9Ub3dt?=
 =?utf-8?B?eXRwNzY5enExWS96cWZyOUFKblZhdmFKY1hQTVBjc1FZYVhoTklBeEkxNEhk?=
 =?utf-8?B?UUtyU2JoYS9vWTUzbS8yVjVZS2JuTUtUUHQvY0RKMGlMaCtPSkZ0MlV0Q0Yy?=
 =?utf-8?B?OUVUZ3RsbHl2VmFSeFUyTEFmNG9pc2Zlak5RWmI2dk5HQzV6bTZVTVBKbUVP?=
 =?utf-8?B?akxNeDdFY3l0ZE1WRFJWT1BlWWtTazRFMldoSTlJWXV5N1JwZnJLMXBCK21s?=
 =?utf-8?B?WWw2TkxUUm1QcFBPdjRmMGdqb1pNSUQ2UmJJZ1pNTE9NNFdzcnJ3UW5vNmlK?=
 =?utf-8?B?SXBvcmM1elBUVEs1KzIxSTlTQy81R0tYTjRIWlBpYldwaklCWjAvL0FLZXRX?=
 =?utf-8?B?ZnJnRVhXTjgycklVd1h4cEFjVEt2UWhRSnl0OEc1U0lzQmoyZ3IrdmNCdmpr?=
 =?utf-8?B?dVRCcFhuL3gvN0JOKytlbDFJc3BLSldUTXlmeVUvdWVsLys5U2hHSXo3OFk1?=
 =?utf-8?B?WjhIa1h4Yk5ZZUZJSVc4RHN1OGQ4TlBNaDFqa0VnUy85UDdodlRLUWtPbjhW?=
 =?utf-8?B?eVAzVjRYS2psWGRrVlFQazMzRmduT3kxN21ac0ZMSWZRQ3BvNFY3SVV6aUFD?=
 =?utf-8?B?YkVmVVJ4Vm44SSswS1FlZlY1Q1BaMCsxdnJ6VGtLSmxsVHFTTk1qbE41OGJm?=
 =?utf-8?B?Z2xQbEM4MHQvTWNPWUVGNHJLZnFFOXd6RW5KQUN6cGFqekVNVVhOdUVKd1Va?=
 =?utf-8?B?UlROK2M3S2hGeTNlSmdNOWI4QWJOT05BaHYwdXBjM1QzaVZQbWd2UStBd1I0?=
 =?utf-8?Q?KQJtPw32Kgw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEk1bUxuRlB4Z1MvRDNhZy9NRlQ0eDRtWlVKT0I5Y0dZVU4yOFIrU0hOUTRH?=
 =?utf-8?B?Wkcvd0gyOFNMeTRGN2swWm1kaUs5aTkvZzRoVXdMMlNKRlVjdmJvQnZJU2xI?=
 =?utf-8?B?UWZrUDd4Z0NBNnova1JPRTQ3YndPaFZpdW53ZmtZYWIwUTFkSTh6cXlsTnJY?=
 =?utf-8?B?WDdRUm1NM2hZMDNIWWVkYXE2QnZ1QXBmalFKYzB4WHhZU0xuUjUyT0Qxd3pV?=
 =?utf-8?B?M0NPTm9hRlliUUhqeTR0c0cxY0pJTmlHWDB0aWQ2NHdLMlpUSVJHVWNpUVZP?=
 =?utf-8?B?ai9HQTVCTDFrZEx3bE41UlRuR0IrYTVqNU1tR3BJZGdCOFZ0blhkdXRqTUsr?=
 =?utf-8?B?bi9KM1hzaERuMWVJN1hDSFlOZnlOYjdKTUJkNWxiV085RUUxSCs0NU9uenl3?=
 =?utf-8?B?cW0zcTZMQVQ5Q2o3OUZxR2NzZ3hKZDBqZnJxVks0U1dQSy9BODNiY0dNbHI4?=
 =?utf-8?B?S2NHWll6enI0MG9Qd0hBOCt1L2FVMGFQQXhVa3hkUWFWcW1ZZGxWMkh0ZnV0?=
 =?utf-8?B?Qkw0Y2N2ejNuVTMwWGJxaHg2T1dTUllzdDBSeStwQ3NjN0Z1eEtnRCtmVUFY?=
 =?utf-8?B?bEFzVU1KYU5iNXdjWVRDWVBBSzZYR1Ayam5USG9tOTNYeUE1NmRYQXU3WW0z?=
 =?utf-8?B?dlNYS2FaSTJqaWF0RDRKb1dVV29UNzQxbGFpRHFkckExNGYwdk0yTEJ3Mk9E?=
 =?utf-8?B?NFRmVVFPSnVMeThlOERDN2gramR6ZStXUmdpMGtvTnVhTmQ1L1JtQ1FybCtL?=
 =?utf-8?B?TTBPUWc2N2dBaG9jbkcyY1g4Q29lT0ZBa0RBY21GcFpHL3RsOHVna2Y2V1F2?=
 =?utf-8?B?K0hBc2p0dndiSEVZZGRQcE44eFltclB1MUZyNjRVRzBBYzluN1ZQNFBFWUFp?=
 =?utf-8?B?UkRMYlIycXJ4RU1IdnBmU3BycFNmLzluUTkzcWtpNlZlc2xnclUvRVNwUHph?=
 =?utf-8?B?eVNyeDBaVHQ4T2kvZDd6bkhWTHJNZmNrYlNWS0oyUzdaQk5yU1hJQUxGaTl3?=
 =?utf-8?B?TXdkV2lVUVgrWkUyL1F1Wjd1alhKQmVVRUdsTW94Z2tCNHZ5RE9QVUU4MUFJ?=
 =?utf-8?B?ME52OXQ5YkYxeFZKMjZyMjIrM0hTUFUwdG84L3hBdU4wcU5wcXg5VE9Lb3pL?=
 =?utf-8?B?TUJwUXMxb0ZuL0MxTFlkQ0U1TWVLajJQSGxGaUlDSHl0M3QrL292WTBaQUpC?=
 =?utf-8?B?dzR0c2tYaHlrNk00OVZkMlVqcTZoK3FPZHlJTGtkN1AzWElUTjhheUJGNFJ4?=
 =?utf-8?B?aXFrcmd1cVhHL0J6cWdqMm9nb1VHOHAraWt4SzRjOW9kdUlib09UaDJDSGI3?=
 =?utf-8?B?eXV1SXVxYnZxRThjeWowVGtHNDdXaVJiWEZ0czlmS3J3Q09TTm9TZWxSeUZR?=
 =?utf-8?B?d1JaZTI3dXVKY0k4c3VaRVM1Y1dQTjk1OUpqcUtLZG03SzdPVTIyZ3RrczhI?=
 =?utf-8?B?MC9nSm9HZWY5RElQN2VwaDg1MVFjT2dGTDNGUG80K1ptL2tOREhLQ0phOTZr?=
 =?utf-8?B?N2FpVk1jWm1IYUY1cDhjSUk3NzVlZjhxYXA5Q1ZhaElSb0MrakVyMjhJQXZu?=
 =?utf-8?B?KzVrSStvbXZYZHRUYnRwY2dUQWpKeWMwSGc1azBKdHRFYy9jVjU0YXhiMDJP?=
 =?utf-8?B?Y3NxOEVvbmRuOFA3NVp2TmJPcVMvWGJYRWMrSHBWQ1FhdGpHNnh4c283bHlq?=
 =?utf-8?B?akJJQkI2NWlRcno5WmdFS0pJUFpRdTNVYzByMDYrUkliTFFKdEdlOEVxYXVC?=
 =?utf-8?B?VC9EMk5NWTdMeWJ4K3B2TlYwUHp3MTlqc3Bpak1EaEIxZTRKVnFJK1RjU3Qx?=
 =?utf-8?B?VzRyK20yK0VwOEJINjB6cjh5N1NNZDRFS3hES3FGZERCM09VYkdzanQ5T1Rs?=
 =?utf-8?B?VFFSNGV4RE1EUnRJbUNTTXBpMTdhQzBReUZqNy9PWFR2S2dDTDl4VTlNWHZ4?=
 =?utf-8?B?eUdqby82b2dYNUFmNTMvMS9DVnBDeWw3RW4xVDduN1JoMzVDM1RFSFhNdFJ5?=
 =?utf-8?B?UXNpblowQ1owVVM2QlgyN0gzbkpkb0tlZHZOM1ZWbkVDU0F4dEVzaVRiQTZE?=
 =?utf-8?B?WmRoNENOaHpJWlZKK0JLNURCc3FLQTV6WC9USGplemdPWnhGYlkvL0dRbDFU?=
 =?utf-8?B?UnM0Qm16U29aclNreVdCUFNsQnJSUlc2RUlPVG9XUFBPUzAwcXE0UDZoci8y?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +goRKyIS7Lc8pOGFMPsdm/sxLNfSX8+29SnV33P0Gpp2tC0Sg36+INm2RE1H5xZvuN7OadBSX5FHS13m+IqqSFhdtddNcyoxxAPRvfrDfld9yszHzGTgCBNcHYBao06Uwi61tVAcvMUlXDI7cmbKmiH0Eq0L7dalmGMnfH88VCnrb7Pdjm+E4ThcEDfjIVIuKQu0l1lfp+pPv18nyZCchJk58DD+DcqMl7THk1aegTJnMXd7vyr29EUWvrQYQ11YveQ+lSAJiOkw37Yj2Evb0qbvcPwVTlzwMZQK9wRCZewc4ftq3zT1TFlcZD0BolUzG14kTb/V+YxYU7fAR+7V8AvqR+tu8F3DugB/L22/CWnL5OE+0md4yNVvmzvX6ZJV9DHi7+mW345y42Cr08C0/7LOFOqe6edpmA0U0WZYgAB0BS0Vwox1/Udet6C4CNcJdOtOaxloX4NRZhNj7SCzv5bHxuTC/CrivExN6U03qIBPqdsj7aBJDhbMjL770VGLC75gslPBuaGCKKy6WashPynr6bFrnSyqxmiCNHuFpi4/pkeZeoFKUVRHqXWxAo8ZdQ45dk6l+e1qa25jSI7X2TGLROw7ikoPF93HGNdZcOM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2331e5-8183-4a92-bef4-08ddc08ee58d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:23:32.7637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cieARYIXhI7B/swMoP/cjaW0/8Qx2Arg0/KHiTfxJdFhzeeQ+zKFELgSpNPnMP35vk6afXcTOCp1P02GZYQLDIdEEcgkYyoeCfayquKu6Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7054
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110111
X-Authority-Analysis: v=2.4 cv=SOlCVPvH c=1 sm=1 tr=0 ts=68712c91 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KKAkSRfTAAAA:8
 a=20KFwNOVAAAA:8 a=rsr6S_pRY-vbXJGtW2EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 cc=ntf awl=host:13600
X-Proofpoint-GUID: dH2Qp5SBB3Fs7pUBMGD2YVrEXhKHi3Zj
X-Proofpoint-ORIG-GUID: dH2Qp5SBB3Fs7pUBMGD2YVrEXhKHi3Zj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMCBTYWx0ZWRfX6r4vUMAcSqMb
 nI438jqsH1hpXZNl38AwucP7C8Q0kANa2OkcDW7b6MuN0Ak7A9lIc9F8lLZVUg6PD9/mkyVWDJV
 6Q9310tBBwjMN1OEknVTG7ULrFY1NC0kHcm1IK4NEQN9xpvwpQ7FrEQfUb3N3rVfHYPAnD/DFdJ
 vbhIhtvWN1C24FuJSzEXAGh+pHElM6bfzdncHRxTvdxrpQZak7ZUXd0GR3GruTTBhU8ehfxck3F
 jd1YP8v1/P6oRUCqjOo6nXyTTWbGVWybGf3WuW6SYdehBNUASvWvZk0lNDRorMiGTTkSS3vszjf
 MUOt2DvBRybISOwrhUuHPal2vSU1INTQz0v39PHpHIUpae3gtVFuieRzvs1vuOaZj+MOTMoTdp5
 cCIQHA+6nH4eKPE0jV4rR8rowQEzNxn6wES9nnz06cjATy3qfWUEcXgsUtSBF9ROg0yg6YRj
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 7/11/2025 11:02 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Add a unit test for qom-list-getv.
> 
> qom-list-get here and in subject.  Could scratch this line, subject
> suffices.

Doh, I missed it.  Will fix.

(re)names are hard :)

>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/qom-test.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 115 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
>> index 27d70bc..4ade1c7 100644
>> --- a/tests/qtest/qom-test.c
>> +++ b/tests/qtest/qom-test.c
>> @@ -11,11 +11,119 @@
>>   
>>   #include "qobject/qdict.h"
>>   #include "qobject/qlist.h"
>> +#include "qobject/qstring.h"
>>   #include "qemu/cutils.h"
>>   #include "libqtest.h"
>>   
>> +#define RAM_NAME "node0"
>> +#define RAM_SIZE 65536
>> +
>>   static int verbosity_level;
>>   
>> +/*
>> + * Verify that the /object/RAM_NAME 'size' property is RAM_SIZE.
>> + */
>> +static void test_list_get_value(QTestState *qts)
>> +{
>> +    QDict *args = qdict_new();
>> +    g_autoptr(QDict) response = NULL;
>> +    g_autoptr(QList) paths = qlist_new();
>> +    QListEntry *entry, *prop_entry;
>> +    const char *prop_name;
>> +    QList *properties, *return_list;
>> +    QDict *obj;
>> +
>> +    qlist_append_str(paths, "/objects/" RAM_NAME);
>> +    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
> 
> Could probably avoid copying @paths.  Good enough.

Thanks, but to wrap this up for both of us, I'll leave it.

- Steve

>> +    response = qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
>> +                              "  'arguments': %p }", args);
>> +    g_assert(response);
>> +    g_assert(qdict_haskey(response, "return"));
>> +    return_list = qobject_to(QList, qdict_get(response, "return"));
>> +
>> +    entry = QTAILQ_FIRST(&return_list->head);
>> +    obj = qobject_to(QDict, qlist_entry_obj(entry));
>> +    g_assert(qdict_haskey(obj, "properties"));
>> +    properties = qobject_to(QList, qdict_get(obj, "properties"));
>> +
>> +    QLIST_FOREACH_ENTRY(properties, prop_entry) {
>> +        QDict *prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
>> +
>> +        g_assert(qdict_haskey(prop, "name"));
>> +        g_assert(qdict_haskey(prop, "value"));
>> +
>> +        prop_name = qdict_get_str(prop, "name");
>> +        if (!strcmp(prop_name, "type")) {
>> +            g_assert_cmpstr(qdict_get_str(prop, "value"), ==,
>> +                            "memory-backend-ram");
>> +
>> +        } else if (!strcmp(prop_name, "size")) {
>> +            g_assert_cmpint(qdict_get_int(prop, "value"), ==, RAM_SIZE);
>> +        }
>> +    }
>> +}
>> +
>> +static void test_list_get(QTestState *qts, QList *paths)
>> +{
>> +    QListEntry *entry, *prop_entry, *path_entry;
>> +    g_autoptr(QDict) response = NULL;
>> +    QDict *args = qdict_new();
>> +    QDict *prop;
>> +    QList *return_list;
>> +
>> +    if (verbosity_level >= 2) {
>> +        g_test_message("Obtaining properties for paths:");
>> +        QLIST_FOREACH_ENTRY(paths, path_entry) {
>> +            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
>> +            g_test_message("  %s", qstring_get_str(qstr));
>> +        }
>> +    }
>> +
>> +    qdict_put_obj(args, "paths", QOBJECT(qlist_copy(paths)));
>> +    response = qtest_qmp(qts, "{ 'execute': 'qom-list-get',"
>> +                              "  'arguments': %p }", args);
>> +    g_assert(response);
>> +    g_assert(qdict_haskey(response, "return"));
>> +    return_list = qobject_to(QList, qdict_get(response, "return"));
>> +    g_assert(!qlist_empty(return_list));
>> +
>> +    path_entry = QTAILQ_FIRST(&paths->head);
>> +    QLIST_FOREACH_ENTRY(return_list, entry) {
>> +        QDict *obj = qobject_to(QDict, qlist_entry_obj(entry));
>> +        g_assert(qdict_haskey(obj, "properties"));
>> +        QList *properties = qobject_to(QList, qdict_get(obj, "properties"));
>> +        bool has_child = false;
>> +
>> +        QLIST_FOREACH_ENTRY(properties, prop_entry) {
>> +            prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
>> +            g_assert(qdict_haskey(prop, "name"));
>> +            g_assert(qdict_haskey(prop, "type"));
>> +            has_child |= strstart(qdict_get_str(prop, "type"), "child<", NULL);
>> +        }
>> +
>> +        if (has_child) {
>> +            /* build a list of child paths */
>> +            QString *qstr = qobject_to(QString, qlist_entry_obj(path_entry));
>> +            const char *path = qstring_get_str(qstr);
>> +            g_autoptr(QList) child_paths = qlist_new();
>> +
>> +            QLIST_FOREACH_ENTRY(properties, prop_entry) {
>> +                prop = qobject_to(QDict, qlist_entry_obj(prop_entry));
>> +                if (strstart(qdict_get_str(prop, "type"), "child<", NULL)) {
>> +                    g_autofree char *child_path = g_strdup_printf(
>> +                        "%s/%s", path, qdict_get_str(prop, "name"));
>> +                    qlist_append_str(child_paths, child_path);
>> +                }
>> +            }
>> +
>> +            /* fetch props for all children with one qom-list-get call */
>> +            test_list_get(qts, child_paths);
>> +        }
>> +
>> +        path_entry = QTAILQ_NEXT(path_entry, next);
>> +    }
>> +}
>> +
>>   static void test_properties(QTestState *qts, const char *path, bool recurse)
>>   {
>>       char *child_path;
>> @@ -85,8 +193,10 @@ static void test_machine(gconstpointer data)
>>       const char *machine = data;
>>       QDict *response;
>>       QTestState *qts;
>> +    g_autoptr(QList) paths = qlist_new();
>>   
>> -    qts = qtest_initf("-machine %s", machine);
>> +    qts = qtest_initf("-machine %s -object memory-backend-ram,id=%s,size=%d",
>> +                      machine, RAM_NAME, RAM_SIZE);
>>   
>>       if (g_test_slow()) {
>>           /* Make sure we can get the machine class properties: */
>> @@ -101,6 +211,10 @@ static void test_machine(gconstpointer data)
>>   
>>       test_properties(qts, "/machine", true);
>>   
>> +    qlist_append_str(paths, "/machine");
>> +    test_list_get(qts, paths);
>> +    test_list_get_value(qts);
>> +
>>       response = qtest_qmp(qts, "{ 'execute': 'quit' }");
>>       g_assert(qdict_haskey(response, "return"));
>>       qobject_unref(response);
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 


