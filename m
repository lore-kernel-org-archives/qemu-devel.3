Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5875C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 15:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaFbG-0005wU-TU; Fri, 11 Jul 2025 11:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFag-0004Ym-VX
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:23:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uaFaf-0004tn-14
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 11:23:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BDRIXj004694;
 Fri, 11 Jul 2025 15:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=TKKf6WnvZCiTAWZuSjhDUDhkUJeQFtL1o+Ryc+CZQfk=; b=
 pa1AylPgy2c5ALzhH2iA9GG8DZcmSnsYPsfHJzrlZAJ442sTNkAFAilKst+mwz8b
 StB4kWd5I/rK4Qf94Qxzv7/IxogyaGkG0W9znlcDo869zpFdfKGAY1FMjnnYTlgq
 BAskimxTe9/Ki8D/eAKFjg7k7yPfP3npm/nM2oMZFg8TgkQYbuaajbMVtrLqXQNt
 G69WwgGxN9BE9bqloG1Mnhvq78aQNfxZaIB+KFRc94BCZe3CBcNYKeeL7TfaJWNl
 y/4He/7Qe2UU+U8AD6oaFMuHKuvssyLrK4dvKwxlbVso4TO+wXyI4kjWSWy3o5YQ
 cCHzDCO+fROfU33tz0vt+g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u3gk87p6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:23:04 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56BEeQPE021575; Fri, 11 Jul 2025 15:23:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ptgdnrx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Jul 2025 15:23:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LAHbLDCM6BNQ2uinMTkQBbUjtGAjXMO0Atw3jdQ6QMUPuaFeQ1SPyeE9q4Ugzm+U9+Rd8YmTvMRwiTBi0O54gjq2/T+YPuLqBj+v2OI1lJLcQlV+lG8SUFjQZdJ12uz3Rs25ispIS/bcAor++DfHhZ2Cb5rsWPAYaAoqTXg9TowmcC+kwxc4IOV9ANKoP76MEI+mk69G/yTkBA7NQJblb8vJm9GsBfLkTrH1/O9Zb5sXyAETEsHRlpSu3syQ7l2TPNmIeJm3JGF9taEGix+JjQe1ytzQL5z01M0SB/sTWjPe7MpVSoy5LSm9Rzr69jUuQZiky78CN7iyvk5j+YNMtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKKf6WnvZCiTAWZuSjhDUDhkUJeQFtL1o+Ryc+CZQfk=;
 b=vsuUm1vMT3ONv2tw3/afCxuv5W6I9rxv49TxG2KwRcOaoRPwnx4NAkwMJUDDybE4JP0jMe0W3pWNE15sA5EegCF5loWQdTJUA0TWXolG5WOCfPwubONy+RWJP+lP9TSD/411HSQ05nNqAXjt87fQztenukI4vgSdhCJwwPZXKw5dfj1+clrmdbd92ywkMgGsI+mGyNXh2UzAASwTUl1fVi5+cKU8iefnCoDhPrI2Gy4OZGZ+TGRDdFBcJ0h1/YHn0/d5dtXx1ALbOI6ljuFgR/XzGwx690apoFMAQQgdEXwXhyCf/pVDNnxKT0n1MgsmFzd2xSOHhoA3lAiJBrarZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKKf6WnvZCiTAWZuSjhDUDhkUJeQFtL1o+Ryc+CZQfk=;
 b=mZYXc58Td5/WGljURBbgzzugA9YoOrBFOs1gBnYDukX6DzoGYgD20Kp5kvy8fZwfeRHkFJpds2xU0yVvUnEeC05fwM9hyvClgJzygsx7ujZcHZNGOvAkGA6wOFRBCbcno1J/7AEMyOWwuokbMjk/gp3iaUW+JLryqTN9hVQQykg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DS0PR10MB7221.namprd10.prod.outlook.com (2603:10b6:8:f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Fri, 11 Jul
 2025 15:23:01 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 15:23:01 +0000
Message-ID: <a84a1482-4ba4-4520-b875-9b3a9a879868@oracle.com>
Date: Fri, 11 Jul 2025 11:23:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 2/3] python: use qom-list-get
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>
References: <1752164694-215567-1-git-send-email-steven.sistare@oracle.com>
 <1752164694-215567-3-git-send-email-steven.sistare@oracle.com>
 <871pqmwzqr.fsf@pond.sub.org>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <871pqmwzqr.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH3PEPF0000409C.namprd05.prod.outlook.com
 (2603:10b6:518:1::48) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DS0PR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: 883de562-2ec9-4411-03f6-08ddc08ed2a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MXdyRitOS0kyRlJ2OGZyMnZ2MVQyUVNHSmE0azdQN1FaRUd6M1FnK2x2M0dn?=
 =?utf-8?B?OGw5M0JCMjZjZEQrbmNlY0Z3UmNKb3BIYlBLTW5WYmtuN1JwTkxLQ0ZDZGpr?=
 =?utf-8?B?L0MxUngrb2FhWnVmSStpQ3lJYS9iRG5FRVVqMmNpU2ZKRFlKSk82RmhuWFIr?=
 =?utf-8?B?Y2pkTDBYY2MybS9hZTZPdzN0KzZYaXBYOFM0dTUxME5MTWJ1NDVzMjVWN0x6?=
 =?utf-8?B?cDNWOE5ERXFOMVg2TjN6U3hXUFVVTzRZYzlVelRlang2WTBCeFU3dGluOFpM?=
 =?utf-8?B?ZG1LVHhXZ2hSUHVTeG9BMnRBKzNVblV2bG5QMXJqQWV6WUczUWtkbjc1MmQr?=
 =?utf-8?B?bDBNTURJWTEzWU5OaUp5T3BNV1htejc0NytYUGR0bW0wWkVxdTkzMW9mUmlp?=
 =?utf-8?B?YXJOd1MrR2RlYVJJRzNya3ZJaDhzcGdad0EvQlM0ZW5zaE9xajVTQmoxb1N5?=
 =?utf-8?B?MGF5SlVyVG9oZjAycUJpSytRUWNCNUdiMFpYUnNNWVRvakY3SHRpK0paemJH?=
 =?utf-8?B?TnBUbzQ5azU0Sk55NmJDcmZ1ZWlUYXk0bC9KOW0zZGVwenFhc2xIckpjcHFn?=
 =?utf-8?B?M0lzbWlLSytmMVBGM3lHSU95dTJkUHRaVTltbVJSUXNBZXV3Tm5oQUcwU05O?=
 =?utf-8?B?OExmdUJBVVo2Nll5RlNxS2dwWk1zZVdrTmg5WXFmRE5zQ1Y0aCtpYUJpRlVk?=
 =?utf-8?B?b3VYNkVwNFQ1T0NzUlZqalphVE5HMmNoSEI3Y0FDQ0d2SGVCRkljNWU0OTNq?=
 =?utf-8?B?UjR3VnU4L29YWkNVc0NXM2p4bEovZUFRbWFpRzd5NEdVbDBZM2t1TTVsTGtC?=
 =?utf-8?B?TUF4Nm9GTW9lSmphNmwyZEljQXd5MjlyS2lkSW5uUXZBMXBSaXY3bDkwYWNQ?=
 =?utf-8?B?TXFScWx2UzIrQU1vK0NQM1dycnA1UFZKalZZQkJwRXo3U2R5Z0lwaHczZm1s?=
 =?utf-8?B?Z2pSVUdrVitoSEFodDZ6YjhiVm9pTjBpVjh0QjFseU45L2dDRkNhanhqMTRz?=
 =?utf-8?B?NTBaUkpXZVRNdHdqSVJsNWdpVlZaaXZhdVR4aUpPa3RUREZsbVpoM3FGdlhy?=
 =?utf-8?B?TDJ0ZFphSGpmVk4rZVlHcXBmaHpvdExFSi9wWjlpOXlkZDMxWnRGR1VkZERP?=
 =?utf-8?B?TkxadEVDYWtrNUEzRndISVRiNGlYUUMxaEd3bU9KelVDeldZNFJDZXprN2ph?=
 =?utf-8?B?Mk9CM0NPNzljSm1ueXFuZU1FUmlvcGtlMmhtc040WTFVd0liYUdHZHdYVVNa?=
 =?utf-8?B?dE1NOFRoZW9kbnl0WUJ2azdjR0lMRjNpSGxVZVpSVStyRnJMY3NoOUxQNmV0?=
 =?utf-8?B?eDNjVk8rVWxBdHM0RU5NeGxRZW9NTUF1SWl2TXBNKzMxU1R0ZzdjSjdiSkc5?=
 =?utf-8?B?ZFlxa3V5allTUzdnZkhHc2hNY3hzQlpCUHF6MTdhczRjOHYxQ090d3NhQWhN?=
 =?utf-8?B?U2k1MUc4ZjhhUmQvQU0xRjBWYzZxS0lVS1ZmM1dFTGgwVnJ2djY4dy9BekxK?=
 =?utf-8?B?VEVVSDRHUXZ4K1IxSzNaL0w5ZEd4MGovKzJ1MnNJWStCNHlDbWVya1pWajJY?=
 =?utf-8?B?c1NwZXBmZ0RRYXQ4bnhGKzhDWHYrb21YT2dMcXBwekdDVmVKV2Z3ZjJmT0NY?=
 =?utf-8?B?cEgyQmVkWVp3UExITXpJRExlUDNUWnBGZG5MdzVEMFZSajhSSzdLM3lJZU84?=
 =?utf-8?B?cllUSlhTMXppa0Ztb05PdExpR3BHQTF5YVNERXpEUE1LWHFsdjA2di9CS1hm?=
 =?utf-8?B?YnZDWU0vVnpSZTRZc2dueFphVFBJcU9uaTNqcVdMcFo3aG5HWXlHM0FLYTJE?=
 =?utf-8?B?cHkyM2FmeHdXRVpMdTVGWDNyQWdLVTVIVzR4MjJIYUxmMGZSbGJFUnhrdlRB?=
 =?utf-8?B?R21tdDNRdjBaZkNUV2VsR3RwZkhkRW5PNHR3R3c1UHB2RWFTSDZuTllRZ2JI?=
 =?utf-8?Q?DK2VHIgdQhs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rmg0Ym1CbXc2NDlKTTVHcytXZDhuTjZubGU0NTFCSjd5RHl0bEI0MFpOam1W?=
 =?utf-8?B?ekRGVjJ2NFErZTNsRGc3enQ1R0J4N1drYllMU3NFUnB6cVE4eXFIVTEyS3Ay?=
 =?utf-8?B?ancwSE1QMDdqYzZ5K2lsSVFqWFBjTzlXQlMzQ3l0SmpYN0RoQmZyT0tKVmhH?=
 =?utf-8?B?bHBTa3dlNmdHOFJ2VkZrUWNWTmhFSEg0bXVKQWI2bWk5MXJvR2xJd0pLYTk0?=
 =?utf-8?B?KzlRWW9JcVdJaFNYRkY0RjduQVdDamk1SHdRWU8yUExEKzBtYnd1WlpxdFRa?=
 =?utf-8?B?dEp3SkVKdTFEQmZnazcyTTAwbVlGWStmVEswRW5yUng0Q3hycGdUdFRQNXQv?=
 =?utf-8?B?SzNkeWFJVktoVjlVWXRaMThweWhHQjJPZHlndm1RYnRpbTFXallmcWJWVkpT?=
 =?utf-8?B?YThMYlc0WVMyODM5d29vQ3ZVS2kzZTB0TmZaSzJrYm9ENVhPQnBlZUhTNkV4?=
 =?utf-8?B?cXVyT2ZFdjMvdVFUUWpOYUl3WTdzcHVpZE5UbExJcHR5RUZJTFV1YmV1T0kw?=
 =?utf-8?B?YTJiVkplOFRVTjZLdXl4N3VjTWh5bFNGYy9NOGFoalBBM1NZSkxsaW9ySUJE?=
 =?utf-8?B?cll2bTliRkVLMFIra2g0d1NzYy9GTXBIY1hpQ0pTOUpHc3ZUd010MTE2aXA0?=
 =?utf-8?B?S3RWZDVheG5Yb1RZWmljWk4rdlRyMmRmZTZNZEpIaEpTd0RreDFJdlVwNWM5?=
 =?utf-8?B?UWlqREhqUFdhRDdlOXhWVUFEbUZPclM2UzdmUk14WUd1ai9wTVdPVTliNVB6?=
 =?utf-8?B?NkdwaU55d05oTDZoQTEvQzRKdGtRY1lMaVIzQTY0Q1hiWTc5LzBsbEc5dXRh?=
 =?utf-8?B?eTluQXhUR0wzVWErcXQyZG8zUWYrcm9UU2cyUGFPZWNUVW85cmlqcE9HWE0r?=
 =?utf-8?B?OWszSmNLQzdFN3ZpSWFUV2JlMHczZDNqSU9Kelc5Nmw4SUV2VFBjbTFXU0k3?=
 =?utf-8?B?UHJlWlNtSjdCTTQ5YW55c1laNEplRWFpa1hCS2lNOXVaamdhZm5oa1pEenNG?=
 =?utf-8?B?Y3k2RHlrZ0VqaHBPaVBoeHE1Mi9nNjlUanJsV2JrWGV4VWZKME5ZWCtuQ0d4?=
 =?utf-8?B?TlVxRXBJWG1rTUF0Um4zdjZxT1JEeGhvc2JXaXV0SU5jSzE5ZDVjM1h3YW0w?=
 =?utf-8?B?dlh0M3FYZEpNRFExcXlvWVpKWlpMRlNiM3p2cXNCYndZbFdEcHhRUW9aK0Iv?=
 =?utf-8?B?cHNGU21aemQ3ZisxTzR5aXRmTlRhcUZNell6MFZBM01ITVJmVVhyNUJDTS9m?=
 =?utf-8?B?ckcwYkE3MGlxOUkwOVpZNHNmWStuV3J1dC9McUxiK2dzOXNpZXlXRGxIc2x0?=
 =?utf-8?B?QjBaL1VwR1FlNittR1BzZ090Ylp2RG5pNnk3N1I4ZzJUNFlCV1NKd3RtMVpM?=
 =?utf-8?B?bWpZc3RQcVRiazgrbk4xZ2ZHRWxhdWxORUtaUm5COTdnYzF5VkRjSkxvK2xr?=
 =?utf-8?B?KzBGN09SUG10T1lTVEgxRS9zWTZTcDlPenRBbmpLcXRERGFpQldKZHpzWWVG?=
 =?utf-8?B?Ykd0K21kYXpYRzl3bWg4Z0M5M3l0Ymo5dUFCR0JybmovR00xekhWd0xMalhI?=
 =?utf-8?B?RHlvOUEwMmxFbktLbTg1cWUxbnRIeXhFSlZueDFYOEt6aE15NW4wZjRKdUxJ?=
 =?utf-8?B?MzZDWEtSR0xqY1cyMDNUcm52eHMvcVRlVmJOT1pWeGdTTlpJcEtzZE1Fb2Uz?=
 =?utf-8?B?OElKUVlsbWZaWFliR091ck1GcVAwY0RzKy9wd085dDkzTm13L1dGWndyY0k3?=
 =?utf-8?B?UDRza0RnL1BXaU9ybHRtWUJ4cEFMcDhjZU81QTk0Y1VZMkM1OEhHVTR3RkRk?=
 =?utf-8?B?Z3dzODZ5NzREMWxjRFgxNU9yaFNKMGxxZHFlR2NFVTFoSWJ0cVNWNEFxa2JF?=
 =?utf-8?B?b3ZXdTR6Y1hUUHRzQW9pQzk2UEVtTnRHSFYwVll2WFFBbFMvandjMVlmekJX?=
 =?utf-8?B?bXNqa2M0bE5Wb2tweWY0T2N0SWp0ZTdLS29vM2lFTVVPcXJhMm14QnBUUkty?=
 =?utf-8?B?ZFJPcWtuamhFQUxoM0RIdGR4U0FmRDBTb3haNXNLNDFxZXhXU0ExOWc2eG05?=
 =?utf-8?B?TkFORFdiZXJ5ZU91SlBtWi9Gak1zbVNyMVBUWWV3bndFT1JsaTRadmRyaEtj?=
 =?utf-8?B?OEcwbVZTVWlmQm9Gc05LRFNGMjZJMkRFcm9XR2ZzVGY1L2pHK1NQL01jcmo5?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vxvlf7pVz1UPoO376QvwmrK1dQWcXffMaOmPsxFgjt10e87wsGkhcMC5d3er2o9sDeo/zwkGx4atfrBtnb1tWxevtMU9KcW2lj82gpgnGVjc2Jnmleb9e+uorcKPL/n2B5Wl4qlOG2QDJtTcZbEqog1NN925RuvNsBQSMeWvsrpxYXib2DC3sgIDjhnH1Bz0Aws3U7e5DAq1yaIpzy7HH+H8jrkE6DR0S15WciDif9DHIuoMqv5UA4bdooT8npDJRPcVb5XrshAf+OR/MsB9MDeYET2JsItt9qJVo/zBoA8BsHibivSfMAUNqyP1+sWzwQ+1OY1WPRHWhHIo5v8z+CzfHZSW1nVbi7k7hxItSP+13xqdIg5B+PcNT/BVME7pibnD8ZJwN2BI3umdgXKtyLmTnMyFzdha5NRtu5/wr0cEnyQuLskKzo5oVVTKb3jDpSWNjPR+Xoi57PcGc69Pg2QO72vJ2BIJE0Z3mEyQUTPPbHvX0Bh87ELi9CydKHw/C6+98rUejmctWwPFd9NkmsV7LtZJnF9YByEkAX6wFKIqqiqaFzEr/d3GI6S3BCNEkPzXaz1t3Au7hQ2xbbI6XeqAYqPZwZjJ0W2wpk1PojE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 883de562-2ec9-4411-03f6-08ddc08ed2a0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 15:23:00.9655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSGisC/Bs40brVBkz0Bhmj0OlaUHH0uhKVd1x9T6zK33DKRb4PDked6CU0xujnZIXlyd21abcXhCUjLLxOryxq91ItcBmxHbgUkkbAq9Wmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110110
X-Proofpoint-ORIG-GUID: QLpZ3iOUqFfPwzV5u6umNABrOJnyTcbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDExMCBTYWx0ZWRfX1i0SkhxBAumk
 fjhOLr9AvaC6Vxlx7opC2ULJMUzX0klvmyL107pQW5lEt2JcSux9neySa2KTWZ7X7lcBlpc8q94
 UqJ5SPmZcwfGTCRIEcnlNjPHav0fVOjJDo98mSBpkAgrm0Q1lwbzUSVJDRh7tjuk4kgufizHT3j
 xVSDdXvZeka9kgZBi+kLEWcpsrZ3GZEVb9L1T5HeFVNJECg3v/mbw4tqxcUxSNfYkvUWRLCOHGZ
 SLhBWAI7HK6Sn8vYJo4DIGmhLZs8x7pPhCrlyc+zVtXdH1+1Rgwvt7n22+H4sg3XMUYaKHm/JkN
 bMXoo82tU7+M6V5cTylUyQN6Jl/oo3WONEj+zcwkt0xBz1LNGwP4fSfkMw0lR7Wzjazu6bvSR2F
 gs3UA2rR5S32DfN8GlUhnOpz9lhHTNPBLBVIjbiC02MFa8X8PB3uaS9B7Y45QNZoSFWseQRL
X-Authority-Analysis: v=2.4 cv=eK0TjGp1 c=1 sm=1 tr=0 ts=68712c58 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Mkyb-cf3pqZsmSkHIv8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QLpZ3iOUqFfPwzV5u6umNABrOJnyTcbn
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

On 7/11/2025 10:47 AM, Markus Armbruster wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
>> Use qom-list-get to speed up the qom-tree command.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> Quick test...  Differences in output before and after match expectations
> (see appended diff).
> 
> New version:
> 
>      real    0m0.446s
>      user    0m0.062s
>      sys     0m0.017s
> 
> Old version barfs a stack backtrace (appended), and is ~18x slower:
> 
>      real    0m8.176s
>      user    0m0.395s
>      sys     0m0.126s
> 
> Did you see the stack backtrace, too?
> 
> Regardless
> Acked-by: Markus Armbruster <armbru@redhat.com>

Thanks.  Do you want a tested-by credit, or is that too little testing
for you to stand behind that endorsement?

I observe the same expected differences.

My test did not backtrace.  Must be a different VM.

- Steve

> $ diff old new
> 59c59
> <   rtc-time: {'tm_year': 125, 'tm_sec': 24, 'tm_hour': 14, 'tm_min': 39, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> ---
>>    rtc-time: {'tm_year': 125, 'tm_sec': 28, 'tm_hour': 14, 'tm_min': 40, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> 486c486
> <   date: {'tm_year': 125, 'tm_sec': 25, 'tm_hour': 14, 'tm_min': 39, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> ---
>>    date: {'tm_year': 125, 'tm_sec': 28, 'tm_hour': 14, 'tm_min': 40, 'tm_mon': 6, 'tm_mday': 11} (struct tm)
> 832c832
> <   legacy-memory: <EXCEPTION: Property 'qemu64-x86_64-cpu.legacy-memory' is not readable> (str)
> ---
>>    legacy-memory: <EXCEPTION: property could not be read> (str)
> 1109c1109
> <   crash-information: <EXCEPTION: No crash occurred> (GuestPanicInformation)
> ---
>>    crash-information: <EXCEPTION: property could not be read> (GuestPanicInformation)
> 1554c1554
> <   legacy-i8042: <EXCEPTION: Property 'vmmouse.legacy-i8042' is not readable> (str)
> ---
>>    legacy-i8042: <EXCEPTION: property could not be read> (str)
> 2436c2436
> <   legacy-iothread: <EXCEPTION: Property 'virtio-blk-device.legacy-iothread' is not readable> (str)
> ---
>>    legacy-iothread: <EXCEPTION: property could not be read> (str)
> 2493c2493
> <   legacy-iothread: <EXCEPTION: Property 'virtio-blk-device.legacy-iothread' is not readable> (str)
> ---
>>    legacy-iothread: <EXCEPTION: property could not be read> (str)
> 
> 
> Exception ignored in: <function QEMUMonitorProtocol.__del__ at 0x7fcfcd080d60>
> Traceback (most recent call last):
>    File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py", line 310, in __del__
>      self.close()
>    File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py", line 281, in close
>      self._sync(
>    File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/legacy.py", line 102, in _sync
>      return self._aloop.run_until_complete(
>    File "/usr/lib64/python3.13/asyncio/base_events.py", line 719, in run_until_complete
>      return future.result()
>    File "/usr/lib64/python3.13/asyncio/tasks.py", line 507, in wait_for
>      return await fut
>    File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py", line 399, in disconnect
>      await self._wait_disconnect()
>    File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py", line 719, in _wait_disconnect
>      await all_defined_tasks  # Raise Exceptions from the bottom half.
>    File "/work/armbru/qemu/scripts/qmp/../../python/qemu/qmp/protocol.py", line 870, in _bh_loop_forever
>      await async_fn()
> RuntimeError: cannot reuse already awaited coroutine
> 


