Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE97BC0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 15:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taGJi-0004W9-5e; Tue, 21 Jan 2025 10:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taGJa-0004Vi-9z
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:37:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1taGJW-0007ol-LD
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 10:37:17 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFDv9o030865;
 Tue, 21 Jan 2025 15:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=99iMROIYvzPKZE8vNC3ojQqHoekFqYQXyCLJ3HCN/fQ=; b=
 DbtiWiuVkhUQYt5fp4lW2/Xo2vdGA2QWgtvcgn5mqkXoYi0kGvyF79ibanhbPx4I
 fTV7KtkLPzQ43HZSYUOTOqOdYECmUag5UHDxp2Q6WQiAJFp+SoTDKd6M/iqge8Or
 1uJ2Q/CYBVJ4Q2PtyjvC3p4rW66TCbiUnLge4SQOxUrFrnlC4IPpdzjZLmURK4a9
 BFAx1Mw8ixgPBJFF5YFlkd/omuwVgPXcScIVzLgwKjcli2nVjdxaYeP6Itxj8Ugw
 mVcWzknencR5HAA0XtHfOIdWlRZ4Ar5tzVWtS+SN0x48PjTatk9yg9bR9pjLFwtL
 XVOB+saPpfDFPJu/NLamZQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4485qkwmys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 15:37:11 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 50LFX0F5036548; Tue, 21 Jan 2025 15:37:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44917pn7tr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jan 2025 15:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFZnRBDXAeFGiNFWVVMWhgqZuhFpazcEHjwQpNOZdB4L5bIT1Z+cOMAW7SijB2t+iyW8O8Wlg2mIfGvuehXQwO7QvrH3xNT6ZqvQGpH8odJgyvVlfgpIwep+fzBYC+bD32uN4Ct4eejnw0WFjKOdJBed1A7BOvpPmB8I3qbYS+i4G9qZxh7pVKCjwvEZjBn6xRCZpS5EZmDfcXjdoM/xi62oTwHGdmAvel+HuroctE8ibkawmQdTo84q9gk6nGQ/IxJTywDk4TIafIUSx7FABIAqzLjLj+HMsDf2V7NzU7L2qHbMKDIeCmjNomdPWT7jd/7RoCNBUMLGfL+JYiTHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99iMROIYvzPKZE8vNC3ojQqHoekFqYQXyCLJ3HCN/fQ=;
 b=ka55EDp03IKTvnOQ5zA6DF+wfr8KZ3e0LnHHXqOcw302EupdBPi5IwdMjhsYjcNgiITh09OM0H+Ev9f5xH4dRzlndgAWvwDSYzuBCLMgTNPSrcnpknomaqfPwSz+A+YLVuPvxQVGBcHKj8pq87e4Z5q9hArgtYG2vN1fBBGDxf1lSwc/B+aB7R6ZOQgRbXYkJcE3ag11+KgiJBQ8FulpaYKdgfrEzgVIr1xdOot6PmjnKqBYYTTrjSx9mkUogYvZincCm+B5v/fiqhwCtLhOiourQZ/PteWsm8Od5EUBJ7YqaYW1aQxWQMECSGBrjOrVd1I4iDt0LquGqeQAl2XXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99iMROIYvzPKZE8vNC3ojQqHoekFqYQXyCLJ3HCN/fQ=;
 b=uIxU/03OEXhqTMRfJn0PdsojrWdW061Xx7yy5v2QOg+AfYI7CtRCZs5oPu99OKpxfRaXvZE8YJq98GYmvvBC7M3wy6rjKvBqwNUew0o7S7qtInzi2KLzHBU+9/0vNKD06ZBuKiyfv32eLRX4cv3bEG16hT56CL/oKR/0dMawnFQ=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by SJ0PR10MB6422.namprd10.prod.outlook.com (2603:10b6:a03:44c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 15:37:08 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::7635:ba00:5d5:c935%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:37:08 +0000
Message-ID: <ad4f21fb-5b6e-40cd-8d29-ecbfca792547@oracle.com>
Date: Tue, 21 Jan 2025 10:36:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 5/5] svq: Support translations via GPAs in
 vhost_svq_translate_addr
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com
References: <20250110170837.2747532-1-jonah.palmer@oracle.com>
 <20250110170837.2747532-6-jonah.palmer@oracle.com>
 <CAJaqyWdxTQ22z17Niw=1dPCL4JX551EMXVkNSbyDO7edeHZm+A@mail.gmail.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <CAJaqyWdxTQ22z17Niw=1dPCL4JX551EMXVkNSbyDO7edeHZm+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0054.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::23) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|SJ0PR10MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: a5603fb4-285b-46dd-dcb3-08dd3a3176cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnNJeUsyWnNib0RmY0ZRVU1xVjBFWEtFYzhLRmkvSGVxWlBQL3ExT3VJaS9U?=
 =?utf-8?B?TzhtZ0MwZnVkVTBRbVBTdEozUnBPM1BsenhoaGhYL0R0b2xOeXZoZnVQSGN3?=
 =?utf-8?B?U245eDRibVZEWWdyTllxZmEzSnNYZjg3QzNFMTJIQmxNZ2JGQ1c1a1gvRHEw?=
 =?utf-8?B?L3Robk4vYmVXZ0ZaYyt5blpqWDJ5N05NNTVjTGkrMW9CS0w3RlMzTllEMFRj?=
 =?utf-8?B?S1kwcnc3eWsvSHk0RHJSNnNUR2hqQlhWaGVFdFlEdWFpbk9scDNqa1Q0RTkz?=
 =?utf-8?B?dER3UkkvNnBEc3FHbW5iSGtUb01VWXFOZW5KUmJKNzNXK3d5eWpjNExWMjhu?=
 =?utf-8?B?Q2tUVlp2dVZXUlNqRlAxWm5NTTRvN1ZWV2Z6MHgwUkNsckRCVWFiR1E5SW1j?=
 =?utf-8?B?eFJEaDYxWWVOU1FKbWVoSFEvQ3lIMXpJclhxQ2JwclU5WG9nSkV6bk5SbTdt?=
 =?utf-8?B?NG95eEp6UEo3Ky84c29RV0dpKzA4RWdrUjA1cUZLTzVRMTA1SkJHNnlKMUlV?=
 =?utf-8?B?cVErY25mQU9OVVczcVVBblBJc0I2MUdkWTduM3UzM2JDZzM3VDJSRDV0MzdL?=
 =?utf-8?B?RmQ0Z0I4aUkzNTZ2bnh2Rk1kZFFVTEc1NGV2VjNMWU9rNGN4a0U2WG42SXR0?=
 =?utf-8?B?aWNzMW4xLzJoM3R1YW9qTW0rcnpnL1Qra09qRnlXYWl1akVTUTJEM0VscVFU?=
 =?utf-8?B?bmZkZWxJOGRGUVRqcHpOWkFZV0lDWHNsYkE0Tyt4eWwreTVxQVdoOEN1NW9z?=
 =?utf-8?B?WUJGVkxkZWpRM1ZOMjI0c0NNbFFIWkdZTi9GcHNKalNXaUd1S20vZWpucW5u?=
 =?utf-8?B?bFl2d1Vxa09VN0oyRVQwK3NWTzJ2b24ra3BqcU5qZUNua3JTeHlTejQ0ZFdO?=
 =?utf-8?B?bjFublgzRnJwRkVCVGY2WldpTUw5NmQ5QUZ2WkxIbjJxdXhydzRWbk8rdHQ3?=
 =?utf-8?B?VHB3aUhHUjFBMWpTa2NGTEZ2bG9vWUNBMnE1Zk5ya0VDUXVZTi9VMWt1VTU4?=
 =?utf-8?B?N0ZPUWt5TDVzUlNsM0hjejdIL0ZOVmhPNFg2eEhYSGQxTFRsd09BUDVUSWkz?=
 =?utf-8?B?MUdTY25ZaS9TOThjM3hpN1NjUlFYdG1EYXFaNzZPaDhIRy9VVXBzdXUwNXM5?=
 =?utf-8?B?dDRjSDE2Nk9sY20veDNrTVhaQU5rb3E5RXJOa3cxT21RbVJmQ2RsMFhWVCtR?=
 =?utf-8?B?MVk0SlRkdW9Tb2FjeFZjMEkyWnMyQjFkSTl1K1JRN1diVEpQNzIyYUZJVzVn?=
 =?utf-8?B?T2ZrY3VUbjNuMEdMUVlYcXZIUEVqc0gzangxeG9IT2VOS24wS2lYcnQxTGd2?=
 =?utf-8?B?YUpXUmJQa3NpN0VGMUUzS0NPYVhweUlWRWRzeG1TUm53bFRwOG1xR3N6cktX?=
 =?utf-8?B?eUlrcnhTSkpJanRBYytmQWZOMEtJQkNWQjY5cEFSSEdyU3Mxek1KblF1SjRv?=
 =?utf-8?B?ZTdKT2pGdVNhWDdZcjFOcTk0d2RPYWtCSWEwTFZrZ2c5Z2t5VWxFRmtFQTdL?=
 =?utf-8?B?enFLVGNFTW8wLzlnNU9yc1E0RURHMlVsYkR3a1N2MWJYV3gvN2hHVzZoamJC?=
 =?utf-8?B?RzB1VUZDd0lNL3hkaFF5cXR2U0RrNjlPajZWRjd2Z3UwT25zU0VxdkgzNzBB?=
 =?utf-8?B?OWVxZ2JPUHNJV3kxait3dVkwZWo5Qm9pSFhOckFvTTUralMrK0NoMFdrYzlC?=
 =?utf-8?B?eklnNmpHQnVPc09QU2k4R0RNbFdDSWdNZ0hQMm1oSHdIK05jbTR5TU1VdWFx?=
 =?utf-8?B?QkpJNDMzUklQL05iL2pUZGQrVGdjaHQ5NFhwTVpjbW5ZNWlTRkRBalpKRVFJ?=
 =?utf-8?B?WkViRk1EbE9MTzI0UEJMbEMrM1B5dlFwb01tUERNWGpnbEo0RzdSc0NLNkNq?=
 =?utf-8?Q?NMZEtT0SIMLmk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRib3dUdS91MlNKQWw0Q2JNYTRMY1YvWjk2eThSWHgyQWlBRXNDaVJnKzIy?=
 =?utf-8?B?MHNZVkg0NU1NeU5GY2ErZENVQmNxUUdCY2VYTSs4eWFtWEJUNHBDWG0yYU5B?=
 =?utf-8?B?WGpQNllsMnYzQWsrNzVBVVZ3dGRmYjZ2UVhmdnl2aW0rNmtudklVOG45aHRG?=
 =?utf-8?B?aUwyZ2RqN2pTb1AzZ0FyNHZFbit1R0hxeVNHNXkwSmNYajAyNmZnNkI5OU56?=
 =?utf-8?B?T1ZnQmxBbGN1WUE4R0ZjcFNUMzU2VDA4VzZwMmQyOVlDdHpiODVGRlpzOWpa?=
 =?utf-8?B?TG9RTDZmUXZUZlgrb1pkbkF5aGdyTzR3dktOdldsbHVxTjRvd1ZFSHJVOWI2?=
 =?utf-8?B?RXNYT2ZSeGY4SEthV0VScVQzMWNncnBjVllWRTNkd2pteTgwRkYvMGRJV3lZ?=
 =?utf-8?B?cmtwYTVza0RMR3VmQzNUSWlIM3ltNWpXV3R5SThTQk9qWExwMlRveUxUak1R?=
 =?utf-8?B?Sk01MWdzcnBNTDRUbnZZUjBTNmxsUkU5UStvYkpTdFVZMUFJZHgvZTdESHdt?=
 =?utf-8?B?SHIyU3hzTzhSQTVmcVR1Mzd4Z2FjSEpsKzljWXhKZ2NNV0F1ZWUrZkpBQm9U?=
 =?utf-8?B?QzVoNGdDbjd4aGN6a29aUmg0ZmkyZ2QwODJ5WUM0dnZseTNjNURMM0lhSHli?=
 =?utf-8?B?Y0FTM2VKei9qSE9EYWhwZFl5M1ZxbzBxUk5ML3k4NGxHd1pyVitocUU2dDlZ?=
 =?utf-8?B?NnNhL0xwUW5yeWppcmQ4RmlndEtVc2E5T1VFRlpQMVJOWWVpRGRNcERQdVBJ?=
 =?utf-8?B?L0VrTGk3bWlORWdBQ2RuTk9xS3d6L2tlcy9JdzZyNGZRMHNzcHEyOFBsMlNh?=
 =?utf-8?B?OUwwSU5BUzFYdnhtdlcxWkJDSFl4RmdYdUdvN0hZU1Q3TEZjNCt6T1FPWU9w?=
 =?utf-8?B?ZnovNXdPbW5HOEdxeHVGRHVMY2h0MEwzMnVOMnlsWWRsTTVvdGhOdlVaSVBG?=
 =?utf-8?B?N2NCR3NQdyt6bmtXaEpMMUZPZlF1MEpxL1ZQZ2w1L3BjVmdlbCtMcFExRkt3?=
 =?utf-8?B?UDVqWGtUUVdkTDI1UUoxN3pxVklkdW45S3d0SUNaSURPZ0ZmcmtvOEhNQW5N?=
 =?utf-8?B?T3dRVC94d0dBMzJYZEhxSGg0VU9xZ0NMUTlKb2YzMG91SlNEKzZYS3V5VFJw?=
 =?utf-8?B?TTI5MXk1WFptTWp6bVkrNzBidGpNVXR3aXpjZFZKWFZaZUVsNy9vaHZwWEpP?=
 =?utf-8?B?Yy9NV04rdUhlTFlOaS91K3czUzBTS3VsNHYvSFl1RUhYSDBOTGxJWVZiejQx?=
 =?utf-8?B?L3JBeENKTnh5d1V2R1UrUitlajQ4WFQwRXhnUmU0YkFvcTdPTjBpSllIUnpu?=
 =?utf-8?B?ZlVHUGI3Qy9ublZrVHFsNGMvYnB5Ui91b1BEMTEvaTZWamdrWEpwdnVJVHhp?=
 =?utf-8?B?NE9CZXdjQVVkeDE2YUtpSVRtSWh3VWpNZGx0RGp0YXgwTTl6ZWlZdEk3VlFv?=
 =?utf-8?B?dzQ0SlNxNnJoYXFMWVRkSHdmNkJ6cEtlNDZsUlNCK2N0SU5HYUVWTzl3ZXNv?=
 =?utf-8?B?Q1AzNVFRNGtSbkxYSWRVWXorNXhKMUZzQ25jdTdRZTFPTFMzSlljbm9YZ2xt?=
 =?utf-8?B?dUxQYWtVdG9YbVlIODJ3Vm9WZWNFYWp2VnFNVzl0SyttRXRqY2N4VlVSN1p6?=
 =?utf-8?B?M2F5RjZMdHZnZm5INmZ2eEIwQ2tMeis0Z1Faelc2YkpWRGdUZkJEZHpubklO?=
 =?utf-8?B?OFdtbzNvL1hON1R6VDJlN2F2UEdsN09ycUdKelZ4KzJ1TkR5Sk95ZTFidmJW?=
 =?utf-8?B?QVAxTklhRjAyQ2NreGhvTWZubElNbitRQ3MzUXFXaWx0cUdsc2hBYzRRNXg5?=
 =?utf-8?B?TGltMStpeEpLcGh1QVhPSnM4L0RTSnN5akxDeXVpVGJMcDJLK1RBRjN4TWl6?=
 =?utf-8?B?M0w2QWlqVU1KZmgxN2ZHOCtuUEQyQ1B3VHlXcllpWlZZQlduaCtSc1dGayth?=
 =?utf-8?B?TlZLT3Q1Nm5TVjJrMmJCd0h5dE82Rmx5UHllN0JJRUl2TlRzMU5MNzJiK2xJ?=
 =?utf-8?B?WmJFUXpCRHozaDNuK05NWGIzRFBYeUtRRDRBTmhUdndITVNnM3FnWG8xTkNv?=
 =?utf-8?B?NHluNnVienpwT1NiNUpFalBJZ2s4SjIwZDdiVlNXc2NMMDVxZ0djY3hpWVVP?=
 =?utf-8?B?R1VSLytJemdQWm1aRWRmK0svN1BSaFJMaXVJRDBOemJPMERVeWtCQnZRL0xj?=
 =?utf-8?Q?h+yt2Z0RpEGDAvLCJZGYMNM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6GMOs0zHx8e1CKu59ET03B34hR2YT4Vo0Ms8H3vZV3GlcgwMN49QxGA8qCsPMMaXRtiQAXVbOMR46HknVcprGFyWT8MUemdKBFPXbkDLQn5QuFJg+25lsdN4Z7zk3yrEgUS8tF/94YhT/eR389F7qwBJKD0GAHcgdSGTEutfZEFwrRvG8AfHNhQvMsJNBVwDwpgiHt+I3Ses/FuoDLwsmKuR9uy2nRlZvowI2RdEQRBH33jsGvHL/jdZb+O9kWRmG2/24uTKwYHVhIVw/Ur9Z7jMYgoN7gy+zPkgd6/XQGg6Lwr5Dq1fbO6HRmB3A+b4L1rnRD+SRaO5vClNknvKbBd+v9H4xJInbST9G1jCU0Dx+rLCRScIo3wTjB5We0RHPWlllEBmzD9rrtrQ1XxJriuehtVgTZNhloMSAid6gX+XYwYxOjsEYNUxnPkpUJL9NzmGaSAUJRaL4XQG9aZ/7IjX0LzOEGoYB4AhemRU54d0BaHpeUYC0s2wC33Uhn3W0wd0Xa/CdGvsPOJ2jOu1RnuXjLZ7MxJwxaC9DWv7g43mkf+it/QElZzr88FFdSqXAVu1/hy6Iv0fkS2Y4swTnha4DteCSkQ31Ixvmn0YXTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5603fb4-285b-46dd-dcb3-08dd3a3176cd
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 15:37:08.0567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqeTXvRe8EOPwibUQOjh5PvA+0w4fL5Iwe9qgfT+6SYEBVzMGsLtK4e2EcRAVjalPTGA/vUd37zkG+PF7G3+iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_06,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501210127
X-Proofpoint-GUID: DpYP-mWrRf-_FKSGhunW100KJgNzYYvu
X-Proofpoint-ORIG-GUID: DpYP-mWrRf-_FKSGhunW100KJgNzYYvu
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 1/16/25 2:29 PM, Eugenio Perez Martin wrote:
> On Fri, Jan 10, 2025 at 6:09 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>>
>> Propagates the GPAs (in_xlat_addr/out_xlat_addr) of a VirtQueueElement
>> to vhost_svq_translate_addr() to translate to IOVAs via GPA->IOVA tree
>> when descriptors are backed by guest memory.
>>
>> For descriptors backed by guest memory, the translation is performed
>> using GPAs via the GPA->IOVA tree. GPAs are unique in the guest's
>> address space, so this ensures unambiguous IOVA translations.
>>
>> For descriptors not backed by guest memory, the existing IOVA->HVA tree
>> is used.
>>
>> This avoids the issue where different GPAs map to the same HVA, causing
>> the HVA->IOVA translation to potentially return an IOVA associated with
>> the wrong intended GPA.
>>
> 
> If SVQ is the only one needing xlat_addrs we can create a new
> SVQElement, following the code of VirtIOBlockReq or VirtIOSCSIReq for
> example.
> 
> But why do we need it? As long as svq->desc_state[qemu_head].elem !=
> NULL the GPA is elem->in_addr or elem->out_addr, and we can use that
> to look into the GPA tree, isn't it? If we don't have any elem, then
> we need to go with "old" HVA -> IOVA lookup.
> 

Oh okay, interesting. I hadn't realized that I was actually duplicating 
information already available in elem->in_addr and elem->out_addr with 
in_xlat_addr and out_xlat_addr.

If this is indeed the case, then yea there's no need for these 
in_xlat_addr and out_xlat_addr members.

I'll look into this! Thanks for your comments Eugenio =]

>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/vhost-shadow-virtqueue.c | 49 ++++++++++++++++++++++--------
>>   1 file changed, 37 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
>> index 37aca8b431..be0db94ab7 100644
>> --- a/hw/virtio/vhost-shadow-virtqueue.c
>> +++ b/hw/virtio/vhost-shadow-virtqueue.c
>> @@ -78,24 +78,37 @@ uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
>>    * @vaddr: Translated IOVA addresses
>>    * @iovec: Source qemu's VA addresses
>>    * @num: Length of iovec and minimum length of vaddr
>> + * @gpas: Descriptors' GPAs, if backed by guest memory
>>    */
>>   static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>>                                        hwaddr *addrs, const struct iovec *iovec,
>> -                                     size_t num)
>> +                                     size_t num, const hwaddr *gpas)
>>   {
>>       if (num == 0) {
>>           return true;
>>       }
>>
>>       for (size_t i = 0; i < num; ++i) {
>> -        DMAMap needle = {
>> -            .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
>> -            .size = iovec[i].iov_len,
>> -        };
>> +        const DMAMap *map;
>> +        DMAMap needle;
>>           Int128 needle_last, map_last;
>>           size_t off;
>>
>> -        const DMAMap *map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>> +        if (gpas) {
>> +            /* Search the GPA->IOVA tree */
>> +            needle = (DMAMap) {
>> +                .translated_addr = gpas[i],
>> +                .size = iovec[i].iov_len,
>> +            };
>> +            map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>> +        } else {
>> +            /* Searh the IOVA->HVA tree */
>> +            needle = (DMAMap) {
>> +                .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
>> +                .size = iovec[i].iov_len,
>> +            };
>> +            map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>> +        }
>>           /*
>>            * Map cannot be NULL since iova map contains all guest space and
>>            * qemu already has a physical address mapped
>> @@ -132,12 +145,14 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>>    * @num: iovec length
>>    * @more_descs: True if more descriptors come in the chain
>>    * @write: True if they are writeable descriptors
>> + * @gpas: Descriptors' GPAs, if backed by guest memory
>>    *
>>    * Return true if success, false otherwise and print error.
>>    */
>>   static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
>>                                           const struct iovec *iovec, size_t num,
>> -                                        bool more_descs, bool write)
>> +                                        bool more_descs, bool write,
>> +                                        const hwaddr *gpas)
>>   {
>>       uint16_t i = svq->free_head, last = svq->free_head;
>>       unsigned n;
>> @@ -149,7 +164,7 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
>>           return true;
>>       }
>>
>> -    ok = vhost_svq_translate_addr(svq, sg, iovec, num);
>> +    ok = vhost_svq_translate_addr(svq, sg, iovec, num, gpas);
>>       if (unlikely(!ok)) {
>>           return false;
>>       }
>> @@ -175,7 +190,8 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
>>   static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
>>                                   const struct iovec *out_sg, size_t out_num,
>>                                   const struct iovec *in_sg, size_t in_num,
>> -                                unsigned *head)
>> +                                unsigned *head, const hwaddr *in_gpas,
>> +                                const hwaddr *out_gpas)
>>   {
>>       unsigned avail_idx;
>>       vring_avail_t *avail = svq->vring.avail;
>> @@ -192,12 +208,13 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
>>       }
>>
>>       ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, in_num > 0,
>> -                                     false);
>> +                                     false, out_gpas);
>>       if (unlikely(!ok)) {
>>           return false;
>>       }
>>
>> -    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true);
>> +    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, false, true,
>> +                                     in_gpas);
>>       if (unlikely(!ok)) {
>>           return false;
>>       }
>> @@ -253,12 +270,20 @@ int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,
>>       unsigned qemu_head;
>>       unsigned ndescs = in_num + out_num;
>>       bool ok;
>> +    hwaddr *in_gpas = NULL;
>> +    hwaddr *out_gpas = NULL;
>>
>>       if (unlikely(ndescs > vhost_svq_available_slots(svq))) {
>>           return -ENOSPC;
>>       }
>>
>> -    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head);
>> +    if (elem) {
>> +        in_gpas = elem->in_xlat_addr;
>> +        out_gpas = elem->out_xlat_addr;
>> +    }
>> +
>> +    ok = vhost_svq_add_split(svq, out_sg, out_num, in_sg, in_num, &qemu_head,
>> +                             in_gpas, out_gpas);
>>       if (unlikely(!ok)) {
>>           return -EINVAL;
>>       }
>> --
>> 2.43.5
>>
> 


