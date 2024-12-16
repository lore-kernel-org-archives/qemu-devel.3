Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C961E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 19:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNH9z-0003hK-1P; Mon, 16 Dec 2024 14:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNH9w-0003h1-PX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:53:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNH9u-00089d-DN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 14:53:40 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGItq4C025168;
 Mon, 16 Dec 2024 19:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=lTRr6icUgTHX9CecIpDDe9e7bifmFHsJAQG7M9lcPu0=; b=
 QDoGVTZKQmeJ/onO4u+6pBBYpOMWEGIkiqnytGJxoQM5AnGhqbcz9JyXQDv1bB5y
 4dB79puVQZVa2anwlko1QT5p0AA4MwUxKvfNUQTbw/bsPcjQ2Erkrvzk/FzF3r1L
 WFfrssOLFDCv4E9yx9Wiu7H6ENOqNQ61PY6lC4pMjKA8wnUM/MjITyDWlR/ewU18
 alTzHl1sXt+6KgkwdydJzlp5Ma+3rhs65AgFhK//ttNk36+UiYsNKbyDbwO1G+vO
 womY727pRNKyVnGCvhZmJci6mPOzBcD3EAPCufoliTmP/j4xs2h1iu6Bx3TuXy9+
 jlDnatENiyAoRxui+WWIOQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec45y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 19:53:35 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGIicEg035469; Mon, 16 Dec 2024 19:53:35 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f7h65u-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 19:53:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXv489hriXigRE/QVZlajg8Llw5fFCMWUitikgJW3fCD9wWzfmBAHW8kBkW1vK01bNKOf4lapAf7RAdoegDTZg3VgJMzF8snrO0gZo6eDcwbYLU5Fxiegc+QDuLBLk7KIyElHGmcpKNVUnZ1fX8H/3cHzn0mpIllS36ucAyK4evrN4Nx+NGyjWGcMeR7npjpyRvTLq2bPPIJkPcJSb6v4jpJweAJCTPNc/srCOeO7lgVIn9XSOBZ/T6axQ1U0jIovIFeDlWWBpbOPlm0zV04TIAKFEvMBq4DoV0VJxIB5Xen6tC8UrKEDr3G7zjBAKegR8t509Dgkqw95ozH8PTnlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTRr6icUgTHX9CecIpDDe9e7bifmFHsJAQG7M9lcPu0=;
 b=tPlxAMNs7sM++fyJFpZL4Zbmmbyrota398avwpi5l1d4SgL3TybeLr1sYwvarRswsh88dpWGN9J3X64EO1K4OMlRdEgeNj/fNNWiFcLm0FT/spSfoLp2QR1+HuhsG2Q2bg3W7ba45iuYjj99IpEvTA3kM1IVYtoTdq9isseEOatVDZXBM/3u/rL5mCzktse/ZsEnNEE5m6oIA2ewj+i0rJCKc82mFZEGg9qMMMNO3edQWlBPFLaPb2rDr56aDdrk83nnZKr3NVT5SwgbCZW3VJMW5d29rdwwM6bBqnTLU4ChjEtkDKip13GdfHCp+e2FLtEiHYcztOjcZMgfNcf9VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTRr6icUgTHX9CecIpDDe9e7bifmFHsJAQG7M9lcPu0=;
 b=iw/2ahLFpnLnTLa+AdTfLmbTFy/ntM1K2cPeJIuar2Ue3mceByUmIDhKML9ha6KUnUouc740HhdCmyhp4kAnhVy158pecr2hfFBgyQMdqwTg2TWCMlpca3F23Ev0y8tq1pWXZSvcHKJd7V7bnvYwnnWDWDO0xdP9EblFlOwVNBI=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by CO1PR10MB4529.namprd10.prod.outlook.com (2603:10b6:303:96::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 19:53:29 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 19:53:29 +0000
Message-ID: <c73e395d-d32e-4ca8-b94e-98203a77e664@oracle.com>
Date: Mon, 16 Dec 2024 19:53:22 +0000
From: Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-3-avihaih@nvidia.com>
 <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
 <50e6d3f8-0642-4a6c-b6fe-21a68ebe9d39@nvidia.com>
 <9d594215-307e-4014-8df6-6e019999a7fe@oracle.com>
 <b6aef9a0-60e8-4b7f-9a42-9a0cc024b0c7@oracle.com>
Content-Language: en-US
In-Reply-To: <b6aef9a0-60e8-4b7f-9a42-9a0cc024b0c7@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0284.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|CO1PR10MB4529:EE_
X-MS-Office365-Filtering-Correlation-Id: e8350f23-4504-4dd9-532b-08dd1e0b5030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmhFL24xOGRHMnR4RVYyZTVpLzlWQXEzZCtlZUZGK0Rxa1RwdUVhUTRWM3FL?=
 =?utf-8?B?dmoxaUx0UEVpUUszd1M4VmZMZFZpbUt5bjZwY0lhOEY2Y1pzSkZyMnd0K0Z2?=
 =?utf-8?B?VVpHUzZ6Y2Y1NnRyaHVNNFhXMjI4ODZEbDF0QXpVTC9rWTN2MEQ5Sy9wc1Za?=
 =?utf-8?B?SHV0eUtnWHg0dHBaMnhieDZNR25WQVI2TWZ0NzRmbUJMa0VBWDRQTVVzZFJw?=
 =?utf-8?B?enluT2NPK0l4UGF5bnRaQWNuUWNGVE5qQkhDdWRJRXRmMEJyQnNTMG50WmRJ?=
 =?utf-8?B?dDFqQWlJTlJoRWd5RU9iaDYyNW9xQlJUMHhJUWtBVVpVZDduS0Mxd0JVZ2kv?=
 =?utf-8?B?eDBpSHJvNWFxTmRwNDBiaUUrNDdlWWVTZWxjVFEyc2tnbVdGYy9rSThkNU91?=
 =?utf-8?B?TG9KanlhNU1aZ09xZmhJeXhRZE16a3FiMG9QS1ZQbXZ5VjlIWVRUaEhVSjlE?=
 =?utf-8?B?ZDd5NXN4WjhEUzBrQzdQMkU2YjJ0UkhyaExOczdVemxWUHpMYzlPZko0Rklo?=
 =?utf-8?B?d25vL2lrWmV2N3gxaVN2NDVWRHdRTEhrWXhMekZxSzQ3ci96MHFwdjVPUGkx?=
 =?utf-8?B?Q05TYWV3VHR4Z2tJY1FnMWVKVyt5d0ZuT21pNXl5TTQrY2w2U1lxSGVKcUlY?=
 =?utf-8?B?V0trYXdEbGwzbC9CRHBadWtxdHZSK0RmazZsY0tRQzIyQjYzYzNZbEFYS0FU?=
 =?utf-8?B?b3d5Ti9HOCtxaFdtU3doOWxwSlhQcENFZWVvUy9ZVFQyZWpUZ2ZZaXV2SmxB?=
 =?utf-8?B?MGZGZ1BMRUNuZFRZWTRzRTlDM01rSkppQnY1N0U2Vlc2Rlg4VGs1ZVFFUmhH?=
 =?utf-8?B?V0ZHcU1yOWtwd0JLVUhMWW5EVkRUNVhaNUJScGVMTDZIZ1FrOVdlVzNpOVh2?=
 =?utf-8?B?b2JBTG1VZlpPQzNWQm13TmZ2MDI4dWV3WldUeUdjODAxNm1CcnJjVHRSRmtS?=
 =?utf-8?B?RWdCRm80QWxCc3RiUDNxVzk0bk4yTGl1TW9pZHpRL3BTdHJWOEdaUzR2eGZT?=
 =?utf-8?B?TCtVQnd1bERBaE52WVhhT013cGFXZlRyenkyTXh2QVJCVkFVbUpWSjZtTVcx?=
 =?utf-8?B?QU85RlNyWS96d2IvRG13QWh3SVJIY1d6ZVUwSlVJbWx4alV4eWgyeTZiNklG?=
 =?utf-8?B?NUVGOXo3T1NDWlAzUHFtT2xCM3J3NzNMbGxrM2x3cEljbjdJa0xCMGZoNWtq?=
 =?utf-8?B?NVdhWWFqbk55NnNDMFJiaUxoRWpUeFRWK3dVREhCeFVjSHVRb20zTE9hdE5Z?=
 =?utf-8?B?VFRXbWlqRUl6ZDVsNWc3ZTA4N3JTZm9HL0xRQzBtTjgrQWxpTDI5WEpCN2dr?=
 =?utf-8?B?YUpYTXBhWnJvbGpQb1dKWGVSK1BmTXVEOVNDUlVSNzQvNFR6dEZsaFpRQzcy?=
 =?utf-8?B?dTJGTXhuT2EvRGVYdnd6UzNFZzB1YmlaaEpGWUZJeEw1VzNLVW8zeG9URTM4?=
 =?utf-8?B?THpxWlpxUlNUQ1hZRXo3MERRUFdWOGdLNEJiOVpIRHEwREV5T3FXWUVwS0Z2?=
 =?utf-8?B?WVliOEhrRi9ZdjVoZGJyeHp5ZkhyRXd5SS9ZMEVMYVFHendKNmIxS05lTGNj?=
 =?utf-8?B?ZHhIWDJRZGdXSVoveTd4TjJpRTZLRm9VQUQ4bmVacVVQUGw4UDVzdlpCaUJQ?=
 =?utf-8?B?eXo4cnZ6YjliM1dFSnBwVllBZHZFTkFGNkQycG5LOVpZUmJIZW1BK3JLNGpo?=
 =?utf-8?B?SWJBcE1KUVNMR0syYmZSWjd2aERtM1haaVRxaXlrZitsZHZWemNrTXFBWC9k?=
 =?utf-8?B?d0JOVUNtUE9taThBZDgzdzV0SFgzOVJGZGY0OE5JdURmaktiZFNTQWdEbmZm?=
 =?utf-8?B?VzlPSVRUaTB2cnVpaysrZkt3YzJHRmk4a0kxckRMaG1ITENFemxKRDM2MlND?=
 =?utf-8?B?VjFJeUZuV3FZcEprdTd1dVNwbUhKdHRpcFBObE45cUxzcVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2FxMzRVVzA3Ri9nU3ZzTU0xbUsxYTh3VlVQeWZWalM2Wkh0aDJZOU5vYkxL?=
 =?utf-8?B?djF1blpocUdCSG5BSENrdHJ0SXdNOUtRMncvQm9MSjBJOUVQcGVQekpTc0Nj?=
 =?utf-8?B?UUhWbEtUdndOQWhIVnVkaFJWZjVuS0RRMTBxVkNFdk5uM1pRenR1RlZJS1lW?=
 =?utf-8?B?VnBvcTJBVXVqanMxb0Urd1lSQ29NNmMrSkhuUmpuTndKR29wdjJRbUE3dytu?=
 =?utf-8?B?d1VmcUliUlc3WlNkaW1zWlRoaVE5T2d6Yjh4ZVZJLzJJSDhpbThhR3hhcTBY?=
 =?utf-8?B?cENwTlZ1NVA2VU1BNWdkRE1sUFlEUGJERW9WL3BwMnpaMmdLRWhyTmdQbjRH?=
 =?utf-8?B?QksxOWVVVXlDZzEyajBHb0ZyVnBGYzd5SUNNSUZQVk1adFdCWFhJa1FjMnY1?=
 =?utf-8?B?WEpzaHdSSWZ3U242Mk83dVNsb2MwQjE0M3BuVk5WUVJ0MDFFYUtuM09BUnMx?=
 =?utf-8?B?QW82dTN3MXAxWm05SjlSU1FsTWNzSUtWSWZobFMxTGx2dTZXYUpDWXlPSVV1?=
 =?utf-8?B?cTdhdzdQMGhLdGxKQ0ZFSlV2a1RUemxaQk93Qko1aTU2NHdZV0tTZjR2ZlZ1?=
 =?utf-8?B?OU5xcnpqNTVkRTJSY0tIcDVILzhPUW5WUWJCRGNzdjhoWkFYaUpjQThzTGE1?=
 =?utf-8?B?VStyVTBtOVhkVDJJZG9XTnhHT01PN2JVN2F2bWcyMzFuMU1iNVBlTXdaeFRQ?=
 =?utf-8?B?OThvUjIrdUx3U2xPNGdrbC9lRTJrZHBRWTdISElIczd0Nm9tazc4c05hN1hX?=
 =?utf-8?B?bjh6bVUxOXVzNzBmMm1sbFAyNSt5THpEL0JXQ2ZNb3BlSW9uby9FOTN0ekto?=
 =?utf-8?B?NUxUOUlhd284bjNURm5yUkxwQVJCbEFHdy9xVnJ1ckdiWCtldTYxRHkwMEli?=
 =?utf-8?B?VGJVUVR4R3VhU2lvcCtwSmY1V2lEYVdKd09CbEUxV0tNNHRXc2xYaFdtMFpy?=
 =?utf-8?B?SWxyWGJXWGVZMzgyajdzNU1aTnBxeTJpR2tYUCtNL3JFQ3p1UTF6bWlQdVdp?=
 =?utf-8?B?VERsK3pYNUk1UGNtU2xUVG1BejdxZ2JvZXM1UGtkR3VMUmh5aStZUWN2UTdw?=
 =?utf-8?B?cjE2QStjeWh3RGE0eHBwTVp0c0xCUUdiSVZxbGFqbk5PQ1I5c0hTTXdBWk9N?=
 =?utf-8?B?bW1mWEFXL3AwRi9ldFdVQXlycWIxZ0oxdU1NMmswY1paQjA0S2pBcnZBbDZV?=
 =?utf-8?B?UHhDNmdkcFBvOHdPY2NRVE5rdlZXT1NJR2ovMytEaW5CVlpDOEhNeW5DMkJ0?=
 =?utf-8?B?UjhiOHJ6MlJ6TTB4WEhmMlVCc0JZTEF3cStsQzU3cXdNNmRVdFZjQVdpQnpL?=
 =?utf-8?B?ZnErbkZIVEd3ZHQ1cC9kZ1l5RXBhUFU2MDRBWEVlbXFkWFNsZkk5blp1K0VX?=
 =?utf-8?B?Z0FicDVYQXFmYmIxeEc1R096eTFHQkdEV1NpWnJUMFhYVHMwejZDTHYwSURu?=
 =?utf-8?B?enpzTjFEVGJzRXpqY0hUUjdpWUZza3BTT1dCQTkySm5hdWZvdEdwTy9BdHU2?=
 =?utf-8?B?WlpKdkdRb0FHOGcwbnFLMGU1akVqTCtuNDhuSjBRNUt6R3lxUHFyN25RMysz?=
 =?utf-8?B?QUxJQVRxZytWVUlSdG9RKzVNM1RLVzQ1Uk12NW9yODF4M2R0ajVyQnE4ejB5?=
 =?utf-8?B?RzZrRS92WU03UFVWWndtWWtDZnN5Y3Q5b2Zma2hFd0MycTkyMmJHR29TN1Zr?=
 =?utf-8?B?eTlTTVhoMFdiYTFLU2pqbjA0aFRYMm9oSDh2OHNCNHZPNERPR1hwUEpPU3U1?=
 =?utf-8?B?MmQvaHM3c2liRlQwQ2RpTEF0Yy93NXdnRTBYK1ZVTktFTjRsOWJpay9nbmha?=
 =?utf-8?B?dGVYZis2V3JkdnM3YkFUNXg4MFNTS3ltUHZSd1l4K25wczVrQW82V00vTzFY?=
 =?utf-8?B?WDQvcHZSRVdNWmRrZUdJeWVtM2xwS3lhK3M3bXlmdVdrVEN2SkZaMVMvVUJy?=
 =?utf-8?B?dERmVFliV3BzTHlwWGkxNFEzT1FzeU9NL0g5eUhPTktXWFdieUVLbXVxNG95?=
 =?utf-8?B?cW5GWlF3NnV0a3JvVmkvSEwwamNTdklCK1dPOUhrZnNSbHF4cTFDMXJnU0F2?=
 =?utf-8?B?SUhwTG1MV1VJN1FpV2piQ3ZvNXNSSlh5K2VSR3Q0UzFxWURUTW9NS0VFaWpU?=
 =?utf-8?B?ZUNLRlFCRnVRT2ZidG9GOEk2ODMxdlZXMHBUVk9uaHBDZXc3YllFaUZoUWVU?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YSKM2u0lWSLPqG70LIPDvFVuFri0U8RQZ7UKRaYR6cDruW111JDY+HblTTpsS+k97EmFaPluKI4aCLV2E1avZL99zRQhhLoIBbgY9BEJAoOm6vLNzY+xm6PeJPskN0WS0Fg/pN98utkrYk7w34a4Qs2iQ2jOn3S/1v2CF4ZOxlsjNjVCaj3Ta/oFw+8y3jxeFMboExU3ymh4xDPwhtpf6O79z2ttq7KGnx7VHX1qVzzmps9WXJQvkqEgAgZ/Z6a8JLfLruVWmdH/k9WX2nszqNrrvdS9+n0/tSFCqf926zBENhcO905FWgHR+mjKB7ahUASZhVp/P/IVM6AcOFH1YYI5FHM2CS91k3Tjp6qWLvSJS4J9aC/gPuv1sBODCZsXwpWA6GpojN2xzgmhFr5md6n18GRW+8IDX3Ye4wuDJpKCB/8sNsY5lMkvZbycirSWpTWrTQZqRlGCWmLeWSHFRzUGLJb7oMNS92OG1moAP57d5nmtuEySSgZ1ZnfAeY92VMyL2Jl5L9aFC+T+m2vcC9c2o3axrLoWmF7MgEFbS2fqNuyE8g5LOMfmQNQyOfGfkm5QJ6pbgPOJLm2AH6lnJUMNimsf1SOEEDgQZfy/v64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8350f23-4504-4dd9-532b-08dd1e0b5030
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 19:53:29.7704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAxPJBuufXWaJFfFcLl2Z9nqqAO8dTsREws960CgLkWbZChb9owJ/ZsF1uI40aHjBRRif8hx15flVLo41dqz+kODrz5zH2BhgtTNBcP7P3c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4529
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_08,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412160164
X-Proofpoint-GUID: plYUf5DjGqqhffcr-YlogCJp9b17tmNS
X-Proofpoint-ORIG-GUID: plYUf5DjGqqhffcr-YlogCJp9b17tmNS
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 16/12/2024 16:05, Joao Martins wrote:
> On 16/12/2024 15:52, Joao Martins wrote:
>> On 16/12/2024 14:52, Avihai Horon wrote:
>>>
>>> On 16/12/2024 14:32, Joao Martins wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On 16/12/2024 09:46, Avihai Horon wrote:
>>>>> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
>>>>> check if dirty tracking has been started in order to avoid errors. The
>>>>> current logic checks if migration is in ACTIVE or DEVICE states to
>>>>> ensure dirty tracking has been started.
>>>>>
>>>>> However, recently there has been an effort to simplify the migration
>>>>> status API and reduce it to a single migration_is_running() function.
>>>>>
>>>>> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
>>>>> it won't use migration_is_active() and migration_is_device(). Instead,
>>>>> use internal VFIO dirty tracking flags.
>>>>>
>>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> The refactor itself is fine except a pre-existing bug:
>>>>
>>>>          Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>>>
>>>>> ---
>>>>>   hw/vfio/common.c | 21 ++++++++++++++++++++-
>>>>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>>> index dcef44fe55..a99796403e 100644
>>>>> --- a/hw/vfio/common.c
>>>>> +++ b/hw/vfio/common.c
>>>>> @@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>>>>              migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>>>>   }
>>>>>
>>>>> +static bool vfio_devices_all_device_dirty_tracking_started(
>>>>> +    const VFIOContainerBase *bcontainer)
>>>>> +{
>>>>> +    VFIODevice *vbasedev;
>>>>> +
>>>>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>>>> +        if (!vbasedev->dirty_tracking) {
>>>>> +            return false;
>>>>> +        }
>>>>> +    }
>>>>> +
>>>>> +    return true;
>>>>> +}
>>>>> +
>>>>>   static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>>>>   {
>>>>>       VFIODevice *vbasedev;
>>>>>
>>>>> -    if (!migration_is_active() && !migration_is_device()) {
>>>>> +    if (!migration_is_running()) {
>>>>> +        return false;
>>>>> +    }
>>>>> +
>>>> Tieing to migration status means that non-KVM dirty trackers cannot be toggled
>>>> unless somebody starts migration. When really your original intention behind
>>>> commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
>>>> was to avoid the setup state when you are indeed during a migration.
>>>
>>> It was tied to migration even prior to this commit, as VFIO log syncs were
>>> restricted to run only during migration (we had "if (!
>>> migration_is_setup_or_active())" check).
>>> This commit only narrowed it down further to not run during SETUP.
>>>
>>
>> Ok, good point.
>>
>> Btw you are regressing from that behaviour with this change above, because if
>> migration has state MIGRATION_STATUS_SETUP and migration_is_running() will
>> return true and so you will log dirty pages.
>>
> 
> Nevermind this comment.
> 
> Just noticed that it was the point of the whole thread:
> 
> https://lore.kernel.org/qemu-devel/78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com/#r
> 
> ... where you discuss this.
> 

Actually, from the thread quoted in the cover letter[0], at the end of this
series we rely on status of dirty tracking to go ahead with the syncs instead of
relying on migration running or not.
Hence just removing migration_is_running() calls wouldn't regress the bug you
fixed with commit ff180c6bd7, neither calc-dirty-rate would miss dirty data from
its reports.

[0]
https://lore.kernel.org/qemu-devel/58146556-d3fa-4d8b-a1db-9bdc68168c78@nvidia.com/

