Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE357C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 16:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfMAX-0006EJ-0W; Tue, 04 Feb 2025 11:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfMAS-0006AE-BZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:52:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfMAP-000227-OY
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 11:52:55 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GMpvI018045;
 Tue, 4 Feb 2025 16:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=NmfCaKYYmbuUDWDKkUWdEkh06v3hIaCTS5dDDSfqzzk=; b=
 gaJlgg5SdmeDWbTg5NAZy14VgNGg1Zq3lhI76oo2ge/i3CAPdzkd7dg32DH0vngi
 EMMa4uDXsUaRN3ANuN5siM4y9fCxx3Tt55Bguk7cc1Mt7nsnduJlvr+9lk8CzEuu
 aGa4hMfseNyDbKtJceFQZNQRAEDQLriTnStIAQKN4j0sMVvzuxkomjlVju7jWdTM
 8IprzMdulpCzjM/0TeAoiyY/sYSOsMv9/xLIO0ZxLRV5x0WC8pSC4c/8NbUypEJ5
 U40cs6OJnxQCD/IquA1gOfhBwl/C7u0T3kxmxjNuVjF+z0eaNTh2xW6qozsjfPbc
 1U7UQpPC31X8aq1pqHcYrg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44kku4rfrf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:52:49 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 514GoZWk037699; Tue, 4 Feb 2025 16:52:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2048.outbound.protection.outlook.com [104.47.58.48])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8gh6hu8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 04 Feb 2025 16:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZy42CG7d+gNIpffw+HEFf+wNWqu1rkeqMv+fPnyF8Kx3TqjveYTQ/N0VC3j+APSpynbl6QIdHyyCL+w6gF4kA5+p9rlM6G/2/DFDF7KZkjpYasRToU7Z5gnSSw2e7wU9l1rNozNUaV00/kBk4UpR5kpNgWrosAbzmCEHAE387u0bqSJlSwMNMoixRJPMVEXQPlx3q6Oxf/YuXzQu2uBY+5zpqeGhDADYSTJqT7u8vrBIaoQow8s6YE7uEeWzn3Zbh9bakH1nAE8ms7Ah1KI+fM6Ub7dVOlMc5c14xPA5sfmLFOu9qgY+pgyk/c6Fkn78SqdzhiWgeN/eSK0af2k9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmfCaKYYmbuUDWDKkUWdEkh06v3hIaCTS5dDDSfqzzk=;
 b=HBo7XfkdlTmAM2BR9/qhfL2Ypio6bJj/dLmbWJc0Rt9r7wfforYTwjuSMxAxYJwEgaDubz68UI76NWfzTPz0piILut8SHdZT2NscIRAWoh+/1jspodOiuE7Sg90XbnHX9XUVgzW9P96TwT2ZzbmxF9GiEAwaR0k/V0kr8rf0Xq4ty/Ym5WEpxWG8AQNslEwqBuPkYDf3CQ8Onk2fAoVCZVGkv0zSy/eozg7Ue3wFh3IEBu3tDcqq6SEaWcqhLIJ/cLSl5czQgf8iYPO6X6tn04WA0SMNbaQqGGLmJjb+Kr0UM3nDX9BK3j1k2krnUxmU5M36TG0g1OshvCwoBMZKgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmfCaKYYmbuUDWDKkUWdEkh06v3hIaCTS5dDDSfqzzk=;
 b=Jx4caLGVjjgbRD8dO7TfvD66vHPXy8K7Ll1ssnJw55xPm9vO2fJNLFOMTE6lj993VnWbxanO/LfBzEb7p0qc/kS5IJSPwpAK/+xct1i0MmBqfO9paSbG9vtOuxhaqt3hRpHUO8/lxrLzdSm9jUeeIwyK6FCuG1s3l0POIzxIADU=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 16:52:46 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 16:52:45 +0000
Message-ID: <27c6ee8f-d4dd-4ee6-bda8-e9b21289d7d7@oracle.com>
Date: Tue, 4 Feb 2025 11:52:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 17/42] migration: cpr-transfer mode
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20250129160059.6987-1-farosas@suse.de>
 <20250129160059.6987-18-farosas@suse.de>
 <CAFEAcA9q+QLJnyVZDAKLsB0i2iBohNwkTXmycpV5CUsWYWZmFw@mail.gmail.com>
 <Z6I_zJF1dljLK-YI@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z6I_zJF1dljLK-YI@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL6PEPF00013E0D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: 50799141-6861-4cfb-1c96-08dd453c5913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmRnTTVjSnRnUW9QbHhaQUtSME9uMmVqL2xUVWZPazg1UjdwN1BxWW9Na21V?=
 =?utf-8?B?WHh3TmZFTTB6MitUUStHM0k1WU5BQjI5K2tNeXpKaVZmSXZDdUI3UjBiZVpQ?=
 =?utf-8?B?aHZyR0x5OFZRTlY0WFY1UWVCaTdXY3pxUnU1Q1lGRkkzOTJ5Z2F4TXh4T1ZM?=
 =?utf-8?B?TjJLczcvQiszeFBlMTVkWXNFLzhDM2I2cXZYQXRMd3c0WFV5MDdXdzh1M2VB?=
 =?utf-8?B?TzNIQ1RNcElUS3cwQVVqeWx3V2VFZ1k3N1lKbWJxUjJESVZjakNvT3pETzZT?=
 =?utf-8?B?S3MraU84Z3hTanBPNHRKZDN4Y1pGNE1teG9SczFFb0JuNjFVckx6dXl2RzI3?=
 =?utf-8?B?WG1nbWZBbU5ieEhWVmlNcStMTERTNHIxakgxaGEzSTBTOG5pUXVmNnRXd1Rx?=
 =?utf-8?B?V1ZkVWpDVjY4RVJLWkNCZGFIV2F1OXJxVDhGeG1IWGdkWFY1ais0cmtzd1hD?=
 =?utf-8?B?cCtnOWpjY0xpbnFuNEZGSFZVUjUweTFDMEFDM1VBRUlEMHF1S1U3aHNrWjRE?=
 =?utf-8?B?ajdDVlNEUC8zcHErOWxuK0RIN1ptVUZieUpQbC9WOXdEN2swbzY2a0RObFph?=
 =?utf-8?B?K2c1NTBCYUlvZzB3Sm8xNitkdXNxZFBYd3hDTWNYamkrSGxVY2FHaW9SVmdq?=
 =?utf-8?B?akRzZVVSNCt0NllNb3JVbEs1U1c2RDFycXhScFM1Wk45V2dpdks4R3B4Zi9u?=
 =?utf-8?B?SjNOL2U0UXljUklIK3ppRzlzTXNCWUNTL0pBVzZpY05LVEtWbi9VTmFMaUdK?=
 =?utf-8?B?OEtpOWdkVzdXNEdaMGxiZGxTTERBdlVSZFduT29aajBWUTc1R05lTW1ZcWRx?=
 =?utf-8?B?cXJJZVNQYWNjeS9WZUZGS1dyWVg0NlZDekozKzFPSnhGM2VQV0V3OGNhTzdG?=
 =?utf-8?B?Tm5qczQ5UXZPL3c2clgvQXFkRmtlYXJESUh2MlRZWTNqQjF3UER5TVRHNVRs?=
 =?utf-8?B?N2hTaWdCQ0E1WDMwTUhieG1pOWFmMTBWZk5IOG1jUHpWQkgyc3M3VUVvOStO?=
 =?utf-8?B?NjBJSitvSjdGWjJKelNLRk1zY2Q2UzNnUE5ZeGtHT3pjOFJQOGU2allTeWJs?=
 =?utf-8?B?UkNzKzdyYTBicDdsK21oOE5mN0s3TXZET0grZjhjRGU4YXFldHFoM1BRUnZD?=
 =?utf-8?B?K05hZmpZZGpkTWRLVG5hc1AyK25YNW1zVVcrekF3WTA3R1U3V0RKNnY0Ry8v?=
 =?utf-8?B?N3ZtdnMzY2pUb0Q2eTNlM1NPbFhvSnJiN0M5V0pFenkrZ01kSDVuQUhGcXpS?=
 =?utf-8?B?b3FEcHVrZnJnQndYZ3IzbHRwY1lxVUczUGVqSEN2NVpKbU1pb3YrSE9Fdy9B?=
 =?utf-8?B?dUplQW1CSzBGdGdGYWVHZ3RvWVl3TFVMWk8yVUIzQmN3elFHM0NBT2w3RkJS?=
 =?utf-8?B?Rm9ZdUlZM2tTbkdtTUFXUFk4c29WWFdsamhibDVVbXJzdmU1OGNaR2VWU1dn?=
 =?utf-8?B?K25ZeXpxcVhOZElzZHFFSHBtNzgrN2JrYm9mUE8yNnJwdFlCbTlUSUR2dHdV?=
 =?utf-8?B?NnhKTjI5Z01zdElBTU5WT0RaOS8wK1J3NlAwcEJBMkZlVlgxRkNLaTFoK3hx?=
 =?utf-8?B?UytrcGtNdmdOQjRKMGxFMnlWM3BvTDFFY1ZZUVBIZW5NS0UzMy8zeFp5b2xV?=
 =?utf-8?B?bzJncWxMWW12R0N0MTZhd3A3QllDU1QrY1ZzbTM2UlBDaWl2bFNzOG1jNC9L?=
 =?utf-8?B?QXNrdi9nNmFxUGxrVGVzK1krK0RLNmhGSFdlNWZ4Smpib2RYYjEybXdwUlFh?=
 =?utf-8?B?ZmN4UHpOaTFad3RtYzVaNGNUL3psa09Nby93U2J0eTI3bTZwWkZPSmdtVUwz?=
 =?utf-8?B?U25ReDZNV3UxUEwra3B5b2ViYzRBT3krSXM5MmZCcW9US1IxOFpEb25zN3FH?=
 =?utf-8?Q?SL7cZ7Zq2FhxY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cit4WEw1Vkdsa2V3Q3JWUWhVWXVWYzVRVTlFS21pQXlNc2V3NWhGNk5aQkVs?=
 =?utf-8?B?ZkVxUVRiSXROZWxLWVR4TDBwa1VWb095N09NOUlyMVhaVXNhQURGeWYwRmdM?=
 =?utf-8?B?SDBxa0lzVis0Qm9OQU5sUS9BcFBza3pvOS9YcUtBL0xnTytheFExMm5ucm04?=
 =?utf-8?B?OVNVWWJOR2NkOUNSOFRHQXFiZ2ExOUhJZ1p2Ui9BTHFuUi9vL0hXM1RVZmRV?=
 =?utf-8?B?WmpGVDFlZmsrRlZxeGxxbnhDcjZ4SzltSEFwcDdSTm9RSVphYXB4VWFxRlVZ?=
 =?utf-8?B?S1d1YjMxR243V1dvbEI2RTQyQ1RQUTJXclVwblZPcXluUUhlTWthWXg3c1ZM?=
 =?utf-8?B?VEpvUjBlSURUSWpkS1pTOXdzbjZjWkFYRjdXZFI4SkkrWlFVZzVBNW81UFdi?=
 =?utf-8?B?eU5mbVlxcFlNa3hwbnJGeithMUprWlZHU0dNa1A3dG1tUWRZY215R3UyeTh4?=
 =?utf-8?B?bkgyR0FNU2syUnA5TXk0NU05TGdiekF6RVcyc0I1N3FtTTY3Uy9STXRNZEcy?=
 =?utf-8?B?VnF0aXZYblNpMzB5Y1BGbDBMMVUvQTczK2VxMmUxSVlIcUg4emRpdTJUVjN1?=
 =?utf-8?B?UnNtbXE3T3JuaDFsbm83MlBkWWJ6ZzJnMGJuZ1g0Z0MvVFB2WWxBNVV2N1FU?=
 =?utf-8?B?Z0o1SVRyT2QySnltUENuWXY5OFhLRG1ZMzNwNnRmeGVCNGRxbG0rNjRodmxw?=
 =?utf-8?B?eXRDTXltS0R3RmxXalVJakZ3bm90V2hWSkNHdHFjOUhaN2JET3JTL0NpdHFD?=
 =?utf-8?B?d1JsMzRobjZsMnRWSGpFUng2dGhLVlE1OGFUa3BrcndXQjdwTHFQRk9IbGhO?=
 =?utf-8?B?MmpwV1gzRkxmNXB6ZFYxYytwTE03M0p6VzEyNmFlbk10VnUzRzA2bVE5OG5S?=
 =?utf-8?B?bEhjSTl3UGY1L09xWEF3M1NBdE5wdG01dDJXem55dXloZElLT2RMdjh5Z2Ns?=
 =?utf-8?B?TllsN0cvM0NtLzdkc0NvNk16TG9ydHlacFNObTVsMGRqRlJiZHRTMXZrYlRI?=
 =?utf-8?B?TEZaL0pZOXN3RGN1UjZkVVdNSm9LcEN5RVNBWGFvQS9PNUFYV2RIcWkxMnhl?=
 =?utf-8?B?c0RkRnp1MmtSN2N4Sm5JSlJCeTBxb3hJTU8zMWpiUDRmVkZtRkFVMXpaSzJM?=
 =?utf-8?B?NVFGSm1iU2RrZHFGWWhXQUlrL0RkandzMEFFNmpYRzFSTTFhWGE4TlNUYi9s?=
 =?utf-8?B?OVNRRmNlcUl3UHRyRWtoa29BWTYxdU1uaGd0TEFJbnhHamNoYVgySGZhVnlS?=
 =?utf-8?B?RVl5Q3BYaTllMnZxRURKeldVdlBJVHViQXg4NitxbGUwRTFya0VjVzNiSmc3?=
 =?utf-8?B?N3dyaG9rOXkvRkk3bGxKaitrcVdwbXNTVDJBdUxoNG5JVnNmV2d1NTV4RUFx?=
 =?utf-8?B?S05OelErbm4xTk9JUUdkWHdXanhXcEFjWVY4bGQ1eVF2cktXUTVXS2R5TDJC?=
 =?utf-8?B?ZlVFUGhIdlNwVmwvYTk4dHljSmR6eTJXeWtobkg1UVlPNnJCWUhJRFhQTnE1?=
 =?utf-8?B?Y1RaUi8zMGs1azFkZ3NCR2V5aUxNd2tJT1kxUW9rcHRsOFR1emI2RGJuR21y?=
 =?utf-8?B?UkMxM0VJQ21pZjAxKzFqUFdzd29JTmxHRllJSithanJpaWYyaUpic3RubG83?=
 =?utf-8?B?elc5VE9MVzkwbG9kRU9LZUVFNTdBdGloQ1pEMkVLR1dQdFlidmZnYTBwTUdN?=
 =?utf-8?B?a3hsbUR2UXpKczNVQnVvek8xVlFZVStPQlNGUkhXNURPSTJjd2ZHK2xFRGRR?=
 =?utf-8?B?QVJCb29ZOHlMSi9MTXZ2dFhPdFhERmRiRGNSR0h1SmFiYmptSXVqNVZqOGww?=
 =?utf-8?B?UVVsNFRiWHcxNE9pNUtrbWhZVkduOXRUUmVhSE9kMTJjZEl3MVhQVmpjSmtW?=
 =?utf-8?B?dTE2K1VBWnNZYmhidmQ5cnVNLzNBRkxkbVlZcnJqcWswWjE5bTFUc1pPSEx2?=
 =?utf-8?B?UnR2eVAvdStYWG9zdXBPb3NDRWprd3hDUE83N0JOT3FMR1NJL0U2SXRpU1Z3?=
 =?utf-8?B?Qm9DdnFtaHNHZGFOcTlIQjdrcWVwaXJnRXJxa3FYZ2pVdDd6SEJ1dHBrekx0?=
 =?utf-8?B?UGpOWkJmTXpTN01GeWZUY3FiZWJYblU5Sy9VN28zOFYvVEs0NzNla3dtcXJF?=
 =?utf-8?B?WlJRNm94dEZpbmxUaWFDZ1pwNVZ5LzBTSDFCUmJWeTBNcHFRNzJyRzVtUXZ6?=
 =?utf-8?B?VUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Gx4AQiqqWQSiAvQTQPxonVO4ACJFI3/LpT1tIzzaMHAgFHtDrf2yHG3zFXz3MzPDtxTeovrVi1IshIYuWUtIGk1PZANobOIIzNc39FGyL5gLuTy09LSMY/ibo90Qv3qazabya5nqdRQDsOzM18TfTIYXlROhko0cQh7X0Kvpal5ZlCtHeEgXcSKRBhRbmlBK9O6QV3NKclW3G9tK7JHFOhd4/hUdKF50lNZyMWA4KhaMVYRxzy/9j7zFDHi/eTCGV0H3oelLEa0/U5xmK7SBFBQHFsqzRqFimtCw4V+fTlhiD4cVN5um+t4yJ5Tc1an5S1VnvzC1SPL5lJj1Fz1wcC21O/0zfuAN2n8s5vjJ+rjR1x71kDuIzM71zWNzXQUPB50YJ3wRERQTORS5tDsQUnNRFEP4Q9jd8utvgY944/pnWqs4dfbJRYbDsa+2jpl8eIgcVFliI9ZM1qZ/Vt449KE1714YEUMxv2Xli+nwJzTCBS47PXoVmtYvcPpcZkOgiBknMLrm/UkT0G4hMAPMIOxupBHVNA4ym8Psh1p+i3lG8QshiaanOM/4LP/Vhfy8XA9P+DPZOOyHkGlcWoYh7nLZmErydvrbJPv0/dAi3hc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50799141-6861-4cfb-1c96-08dd453c5913
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 16:52:45.3157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+v8YbwKnLsTw+d/cGYwKEoykDQdca5fblSKjv2sU5aX4HJHS4boI2Ilhqjv9FEqPUS0mVypiilIhY60JKRO+FJ9PGX9wLwLHjxXmzsS6CE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_08,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040129
X-Proofpoint-GUID: cy1or6Qn_DtNNeB_h5daFiSP9RNk4F6N
X-Proofpoint-ORIG-GUID: cy1or6Qn_DtNNeB_h5daFiSP9RNk4F6N
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 2/4/2025 11:26 AM, Peter Xu wrote:
> On Tue, Feb 04, 2025 at 01:40:34PM +0000, Peter Maydell wrote:
>> On Wed, 29 Jan 2025 at 16:11, Fabiano Rosas <farosas@suse.de> wrote:
>>>
>>> From: Steve Sistare <steven.sistare@oracle.com>
>>>
>>> Add the cpr-transfer migration mode, which allows the user to transfer
>>> a guest to a new QEMU instance on the same host with minimal guest pause
>>> time, by preserving guest RAM in place, albeit with new virtual addresses
>>> in new QEMU, and by preserving device file descriptors.  Pages that were
>>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>>> descriptor of the device that locked them remains open.
>>>
>>> cpr-transfer preserves memory and devices descriptors by sending them to
>>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>>> be sent over the normal migration channel, because devices and backends
>>> are created prior to reading the channel, so this mode sends CPR state
>>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>>> prior to creating devices or backends.  The user specifies the cpr channel
>>> in the channel arguments on the outgoing side, and in a second -incoming
>>> command-line parameter on the incoming side.
>>>
>>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>>> which allows anonymous memory to be transferred in place to the new process
>>> by transferring a memory descriptor for each ram block.  Memory-backend
>>> objects must have the share=on attribute, but memory-backend-epc is not
>>> supported.
>>>
>>> The user starts new QEMU on the same host as old QEMU, with command-line
>>> arguments to create the same machine, plus the -incoming option for the
>>> main migration channel, like normal live migration.  In addition, the user
>>> adds a second -incoming option with channel type "cpr".  This CPR channel
>>> must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
>>> UNIX domain socket.
>>>
>>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>>> a second migration channel of type "cpr" in the channels argument.
>>> Old QEMU stops the VM, saves state to the migration channels, and enters
>>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>>> resumes.
>>>
>>> The implementation splits qmp_migrate into start and finish functions.
>>> Start sends CPR state to new QEMU, which responds by closing the CPR
>>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>>> main migration channel.
>>>
>>> In summary, the usage is:
>>>
>>>    qemu-system-$arch -machine aux-ram-share=on ...
>>>
>>>    start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>>
>>>    Issue commands to old QEMU:
>>>      migrate_set_parameter mode cpr-transfer
>>>
>>>      {"execute": "migrate", ...
>>>          {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>> Acked-by: Markus Armbruster <armbru@redhat.com>
>>> Link: https://lore.kernel.org/r/1736967650-129648-17-git-send-email-steven.sistare@oracle.com
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> Hi; this commit includes some code that has confused
>> Coverity (CID 1590980) and it also confused me, so maybe
>> it could be usefully made clearer?
>>
>>
>>>   void qmp_migrate(const char *uri, bool has_channels,
>>>                    MigrationChannelList *channels, bool has_detach, bool detach,
>>>                    bool has_resume, bool resume, Error **errp)
>>> @@ -2056,6 +2118,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>       g_autoptr(MigrationChannel) channel = NULL;
>>>       MigrationAddress *addr = NULL;
>>>       MigrationChannel *channelv[MIGRATION_CHANNEL_TYPE__MAX] = { NULL };
>>> +    MigrationChannel *cpr_channel = NULL;
>>>
>>>       /*
>>>        * Having preliminary checks for uri and channel
>>> @@ -2076,6 +2139,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>               }
>>>               channelv[type] = channels->value;
>>>           }
>>> +        cpr_channel = channelv[MIGRATION_CHANNEL_TYPE_CPR];
>>>           addr = channelv[MIGRATION_CHANNEL_TYPE_MAIN]->addr;
>>>           if (!addr) {
>>>               error_setg(errp, "Channel list has no main entry");
>>> @@ -2096,12 +2160,52 @@ void qmp_migrate(const char *uri, bool has_channels,
>>>           return;
>>>       }
>>>
>>> +    if (s->parameters.mode == MIG_MODE_CPR_TRANSFER && !cpr_channel) {
>>> +        error_setg(errp, "missing 'cpr' migration channel");
>>> +        return;
>>> +    }
>>
>> Here in qmp_migrate() we bail out if cpr_channel is NULL,
>> provided that s->parameters.mode is MIG_MODE_CPR_TRANSFER...
>>
>>> +
>>>       resume_requested = has_resume && resume;
>>>       if (!migrate_prepare(s, resume_requested, errp)) {
>>>           /* Error detected, put into errp */
>>>           return;
>>>       }
>>>
>>> +    if (cpr_state_save(cpr_channel, &local_err)) {
>>
>> ...but in cpr_state_save() when we decide whether to dereference
>> cpr_channel or not, we aren't checking s->parameters.mode,
>> we call migrate_mode() and check the result of that.
>> And migrate_mode() isn't completely trivial: it calls
>> cpr_get_incoming_mode(), so it's not obvious that it's
>> necessarily going to be the same value as s->parameters.mode.
>> So Coverity complains that it sees a code path where we
>> might dereference cpr_channel even when it's NULL.
>>
>> Could this be made a bit clearer somehow, do you think?
> 
> That migrate_mode() is indeed tricky, and should only be needed for
> incoming side QEMU to workaround current limitation that the migration
> parameter "mode" cannot be set as early as when cpr_state_load() happens..
> 
> I think we could check s->parameters.mode here before doing
> cpr_state_save(), it can also be more readable.
> 
> Steve, do you want to send a patch?

I am busy today but I will submit a patch tomorrow.  cpr_state_save
is only used on the outgoing side, so internally it can check
s->parameters.mode instead of migrate_mode().

- Steve


