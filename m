Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F06C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 22:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfnTV-00021t-Dg; Wed, 05 Feb 2025 17:02:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnTT-00021j-MB
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:02:23 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnTR-0006uV-Pa
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:02:23 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515GfrvG032359;
 Wed, 5 Feb 2025 22:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=WJ1ZDIo7FcObV7XEvwWRXu1HZqjU3tGXvGxXXPkD9m4=; b=
 Ye262c8FydO78XgtUiTblAhvYw7CkT37v8XpnTQblV7qQ3Gy3Tse4qtZqZwrcbXn
 h9XT5SqeOczg1Nz8UxsnowkolxS/JoQ1GCTfdlP7w0TxWqliEYvNeEQ4jyur2SfU
 YUGJqQ0RocDl3TpZzI6GZ4QN/aQHry6zL3Nw3ewD8VOZ7P3rr/MQ4wBvM3Rx2u3n
 mC4fKLpI3lJiJrdyTlML4r3L9ghQNymVTQjSP6EhppOIv6YGFL2bBEUjuNpWygge
 kSTaY1RZy1siHTv1tfqye0JbP2zMu8m/V8pEi23KK4kYt+oOvwU2X62QWYy29NAe
 eRlj11vjdcsM4OfpT5zl6Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhju0504-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:02:18 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515LtggD021106; Wed, 5 Feb 2025 22:02:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fr119p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I4BXGZ5BXyciKhX4mwQv7A7YVqyYLpSiF1ewLQvq3vjNZCMIErwWA+JLg5S3iTG1bAa4IFYg/sMC6r8EZMsTLVTWPth0DYrMHKncqw8hm53IIlonVhjHWnrSapDw5hATis7ee5YMNC/ouEJYiAlrQAk4nOpHHOAmglVhc6CdGAJ1P96DZkmzv7xJQZPX4IFjh1eZ+MpyMoLTu0Aql1XbQyMlj26Hz6f25MKMuIWifXdA7v3ch+OF7CjOqU1s44cLgDUT1NQFiMa1pIlkN5ORPC+j766BU5xfLQ0EciTh2HccumCHuZZ1nNPNVacjnpbsuGVRUVa1WPwrAZKwGWA4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ1ZDIo7FcObV7XEvwWRXu1HZqjU3tGXvGxXXPkD9m4=;
 b=QTIDUHUwvfOHrxP+RPjCZdx4Vi9lDchHpPWmVyOE5tEV7l+3ZJMOMas4p0nwlYFT7j6A/dEj48m++Yn/b4+J3LkyDt+Vce6DLeH/dxfFifJ7D0Q6lJQrKNNrdpQPvUzqs2CSLvKkBdP9yI1qWkQWqq39+LgK6hXlSoX0BNPMK4+SDl0hY+gNNWKs/4OD/d+BUNJ6BS3Sv77bm4SWteaJglDfGOSyg8HfoXhdkmwaIJTMXnBA7JaiKOI8MSHpxvvWYmNdo/vvMpukuM7d3Z7NfA5NSLUKaOKtrumevPa3FG32Ylb5rcLqS50VxjXWq6Ph3k8o8nBPJGFMG6dugRNcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ1ZDIo7FcObV7XEvwWRXu1HZqjU3tGXvGxXXPkD9m4=;
 b=gAmJa5sll9o+NuodbvqfgpcQooEXxM75wQ9VJIWoeS2lFBd94rLiHzaatA0If2ITy6+IOGCcmbcWkUYB05L1VY1UKWRT6KveKiR5U4uhNr2k1T7oV8fQBJDt33C8Y6ruqnkA5iT4OJulVaJxztaxT+/ciObpGqh3ne4fD/xIz6E=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 22:02:15 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 22:02:14 +0000
Message-ID: <1437e55f-2a89-45a5-8d30-c935da240d67@oracle.com>
Date: Wed, 5 Feb 2025 17:02:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 21/26] iommufd: change process ioctl
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-22-git-send-email-steven.sistare@oracle.com>
 <6371885e-4dd3-401c-8fb1-c675f9ac4c72@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <6371885e-4dd3-401c-8fb1-c675f9ac4c72@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:408:ea::18) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b77fba-2d97-49b9-cdbe-08dd4630bf9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?alNlZ0tGdmdLZVZXTUhHU1VWTk5HL1pKRW13aWVPQVdmVjBxZUw1YTYzYmFy?=
 =?utf-8?B?dFZyamxHNHMrbG9wTkZRcnJHUlphS05yR2U5Y0lNb2JRREpPS0dQVWZHWEFZ?=
 =?utf-8?B?ZGl0RTJ3Wks1TmxTaUMvMUY5d1Y0eWNXdklsT3RMaDN0MGZRbEMxVGdueW10?=
 =?utf-8?B?RnBGZWNoVHF0alMyamk3dmhSQjBBcDhodHEwZmhCbHRla1lETndCazNyYUI4?=
 =?utf-8?B?QWQwTEpaaGh0bGxzbDVvdTVqdVdpS1RGcnMvNXFQVFZsNmdBTUNVVkZLM0Y2?=
 =?utf-8?B?b000enNEMkU2UlBjSmovbGQ1STZ6WDdxb2R4N2dLeUFXaUczSTl4dFB6c2du?=
 =?utf-8?B?SFNwVGMrdWtETzFORTdlUjIyUkpiQU4wSmZaUGJZV0p5a2p1UmpvM3dwc3RJ?=
 =?utf-8?B?bzA1RUVYUiswd0NqR2YzU3Q0ZE9NejFyUmlTSUZSdEVuZHQyWndUNTdxNE51?=
 =?utf-8?B?U2VZYnQ4dm5GV0JITjBOREVrL01iWTVUMXNiQTQ5c2h5c3B5V0xrVHIwSVdB?=
 =?utf-8?B?ZDZ6Z1FNYTY3Wnh0aWQ4M0FFUGdZU2xvaEh4YnZmU1h5bDBidURFclhYOG90?=
 =?utf-8?B?bnlJN1daUlBZcE5JQzZ4TEFpOXIzWFpJT01jbG0xTXVNSS9pZEc0SEdkZ24v?=
 =?utf-8?B?NWdQUjRRNk9aVzNwdWtScXcvUXlabGJUVTJUUlIvS0FCV2k4cStlRU1YYmVq?=
 =?utf-8?B?WGdnMm0xdy9LQ1VNV0JLUnllY3E3bnF5Z3R6ZWVGKzVsZ0Y5eE5yQ3E0c01m?=
 =?utf-8?B?RFBQS3JqU0pxZWVyaUFkZ21HaktZbjFwUVZCR1hLcVd3eFdkaVlzMjVqelRq?=
 =?utf-8?B?bE1EQWhsaHFjei94bDBFQlM5SHgyZmZLMlJGcnIvMDZ0c2pxRG1uWTFLVHBs?=
 =?utf-8?B?akZXRy9saU9PeGNBMGExeFhidWxuT2dsNW5xaG8zNS9EeE5HL2d4UlRwNzI5?=
 =?utf-8?B?eW1hcGRLTzJ6eXdVMmdRcXZvSHNwUjBnWmZHV3pvY0h6Z0lxemtST0pibi9F?=
 =?utf-8?B?aStFMnBYYjk3NWZzMG5EdjRJR21TUnBoZjAyK2tDTTBrdEh3YlJDaEhNN3di?=
 =?utf-8?B?cFV3NmRZdWZLRWNQcTNXb01SczY1K2g2VjdJZmwwU2ltZC9LNkJGcnkzaFpX?=
 =?utf-8?B?OStuY0ZaWHZ3MncrT1VyR2dkZWo4RDY1NFhBOEZ1d0czMFNZTHNCdE1XM0d3?=
 =?utf-8?B?MlkycE16RXpuUS9jL2w3alorL1J0MmtnclN0QjVFMWk4R0ZkTkM0L2pDeFQ2?=
 =?utf-8?B?QzE5ZGFINWN3dy9EUWJ6Q2N2VEJnNUVhNjEzNlBLb1RRQ1FPUys3Q1QxVEtj?=
 =?utf-8?B?dVNJNFRHOUZCZmVoMllST296cUtlaHcwSEphVFVZaFF3ZklvdUUvNlJGeHpV?=
 =?utf-8?B?ajkwOW12cm55aUVWdFYySEdUeFRLMDVEQmtzTHBXQjM5azVjZHNCM3UyZkhZ?=
 =?utf-8?B?QXN6Zjg4dTQ1TXdMR0Q1QWc4NERNSUVuazRaTkVaOEJWN3RkMUFMYW9HSGND?=
 =?utf-8?B?YlNzbVJsN0kxNmZRaUlnN2hJQmFPTEdIT0xEL1dIRzVVVnhidUhueGc1cTZ2?=
 =?utf-8?B?UkZjckw5SUVZTDFvdnVIVkYydFVkYUZaUVgvVm5vWjdzVEQ4bzkxZ3lTSWNS?=
 =?utf-8?B?QjFWVzMrMFp0bWhPVTlrYmsyY2t1Nk56aEYwMmF3SW1zUXdhcndySWJKYVY0?=
 =?utf-8?B?SUI4eUFzd21YRjVaQUpTUzA0WmdvN2V3ZHZXVko0SDZGKzNoRlYyZmhWeExv?=
 =?utf-8?B?Q1VBZ1VkQm5yWHk4bUxxQWhMZStxM0QrdnY5NHdDTWtqVjV1dGtibjdYWi85?=
 =?utf-8?B?M0c1VE9pdnFMc0M1RkZYWnJSRDRyTk54MldOWFZvY1lnNGhkZWMrTDE2UEFB?=
 =?utf-8?Q?XQRkpabRJGxmY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTh2SDlTOHNjOGlmVWV1T3ZwOTlWVzNsNjNTZ0lLU3BxbkdPWi96SmNlQXJv?=
 =?utf-8?B?OHNzV2NHTWd0ckw5SXp1dEhiTnRyN1dVZ1RVUUd5dklEOHNucCtIWlF3eHY2?=
 =?utf-8?B?QVpHZlB6eDc2a0JDdGxGd0xQT1lnM3hqREhmNEpad1VZcTgxZkYxRmtEbE80?=
 =?utf-8?B?L0lWRFdCNllnUGFlajJQZStHd1VMTVlNWjRHMTJtQXJLbTRVZWlQM0UwcDJJ?=
 =?utf-8?B?UFBaM2ZlMmpFNi9PL2tQTFRKZGlSZ0o5NXJsakxkcGhEWWNaeTV4dDRWYWJE?=
 =?utf-8?B?SzQ0bHRveWM0UGhaZ1hjNGlPOUhkRjFuSm5vTDAvMmdmZVJsWmFrZDNrRjFC?=
 =?utf-8?B?ZkplYldTUmpFbWI3b0FBQlV5YmsycFhZcEhpSmM3bFV3MDBqaFBsWGl3anJj?=
 =?utf-8?B?b3ltTnJTSW9sVG5jR3BNTEY5QlFpRWJ0S1RScExYN2RualJiQ2RXSWRUUWx6?=
 =?utf-8?B?R1Z1dDNjd29KWmVHeDdZaW1DaFdEZyt6dFhpcUkycGFlN01uWk1ZbmxaTjMw?=
 =?utf-8?B?NUpYKzE1UUNac1o3MVREZDN1UkNUUG9oenNiWjI0U05jUUpaRDdFcndwaUNR?=
 =?utf-8?B?T2M1RkJpMDNjcGQwMjdENDBUYmcwR2dBbXg5bmRhY1hVTFZGQkF6UTUwdFMz?=
 =?utf-8?B?V3Q4Y1VJQ1NVUHBwcUlxS3pjeGtvZGl5WndQa2dTMHYvNmNsM3MrdWtiTVZz?=
 =?utf-8?B?bXJrSVM4RjVkdkV4U1hHNUxKdFlhbjJENmplM2d2eko2ZGZQRzBqSmVSYnFk?=
 =?utf-8?B?QmpsbW14czNRSHFIaUljbWEwMjY0bXprUDR3VlVnSENWeDFLcVI1bHdXRXp4?=
 =?utf-8?B?YS9KTVFxcnJtdHNvakpMVW1FT0c1b2UzTnBZT3Z6bVR1clBEcWRQaXBibGRm?=
 =?utf-8?B?N3ZsR29CT09ZT1VWaVRaTXlvQkF6eTlJc2QzSWhUT1VXeGtjYUdTVFRuQ0pS?=
 =?utf-8?B?NzB1c1JUWm43ZXhkTmR5N2dNdjQvUUNkaU12eFZMKzZzYW1QMXFGRkJma0tt?=
 =?utf-8?B?dU01NnVuWEJuVWMyQXRCM2dnSWR4Y2JkVlFZOXBINU54WDNzT2ZuaWFtR0Z1?=
 =?utf-8?B?U0lOSmpPRG9yeE1MOHFLU0tZTnFPU1A0RnF4VXplRk5hTXVRYlc3eXRHQVpX?=
 =?utf-8?B?b2JWRnBSaWdtRnJNWG9yNmQ4eW5ZQjQ3RWtORzF0UDFtWnNGdXU4VHIzUmFP?=
 =?utf-8?B?K3VTM01sa2wva1d2ZEY5aGdMcTJyYTFYZEp1UkhScWcvUWxWc1RxUHFwelcz?=
 =?utf-8?B?a2tjaW1WdGszNjBac2Q2VWdCUmtwcjFIWWFWNzl5bWExNFpLMmJGYXNRNVVT?=
 =?utf-8?B?MlRnNWRrV1RLWW1JUmlIbmc3MjJWQ0plRWQ0M2hZc3d6T0xpRnZGbHgvYTBI?=
 =?utf-8?B?bFcvVDVVMC8ybEVUNTF5RnR5L09qbnYveTlPbzhzMnRRYlc2TnhhSkMwMytl?=
 =?utf-8?B?NmFQZFdGdFhJRDY4WjZZYXF4NXZ1ancyVytrNUpoeFBoQzk0U1phSDFBODBa?=
 =?utf-8?B?TXZkT2lsWFk3ZWxJd2lOU3UwTVBJZEJDeUpxcXFSY3NMYTdBRk9GSnV2Zm9w?=
 =?utf-8?B?YlhpWWU2Yk1ZUE9BV1VQOHNqU1lyRGtTbTU1b2dLVStjTm4rakFSV0k0QThK?=
 =?utf-8?B?eGFneFJ1OWdWaUUxNVE3NVlnODNHb3VENlRIQ3N6ZE5MRjF2ZU5JRmJsdEFn?=
 =?utf-8?B?ZzV2Z3hoODFBOThFQ2NYRU40Wlc4eFdDSE1BRnQ2b2NaMUZadVVaOUd3eDZv?=
 =?utf-8?B?V3hWSVkzNmN4UkpQeE1uL3k3d1M3SS94Y3IwNFZQSTYrZzZiNWpvVi9TcU1j?=
 =?utf-8?B?QjJMeE5nUDdIRitIaElnU2MzcWYyUnpxOGFVSndEMHlRdDF0Vlc5QW8wdUJt?=
 =?utf-8?B?OGtSMXM3ZEd2eDN6ekRpWGd2MzNKZ28zNFl0RmthNzFlZjBEdlhBb3cwR2U2?=
 =?utf-8?B?RXluSnV0U2dmcWxVZTlyRFUveTB1T01KMzBvOFZUdUdQMTh2N0FmM0VIcFIr?=
 =?utf-8?B?WlczdjNXU0dFYVcybGEvbzlVUkVRTHA3NjJOVUs0U0RkWm5HNEtvWEJiYWZZ?=
 =?utf-8?B?V25ITXl2dlgvdU1NZnR6T0NPdFRMSkE1NldtRTZHbVpqc2NRU3hpckhDaFM2?=
 =?utf-8?B?VkZhU1MvT003bzJRUFZZU0RGRFZkTTkvcG9NZGFTNjQ4cmw5QXo3UUZsZTZF?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yQNNJlOD3cpFHIWrzLfN2gaJPqGSBj8V7KBjrOD0+sVQO00MIZTR2CaProyDTpNRIXm6Bm1ZhbzZPkOUrFyn00Fn0d+4cFzMFroBADwSsC5hYZjgvGyF90WzLqIO6WlNWsqkzqSpVNS4VTHcPJKkJgdNtGkMH6tB99C9q67BVsYCv4GWL4vzofrqBIuoxklhi0472bRZ7y9WO45x5nKUjJ2xX1Z+Q6AyATNeWXKjrJieFPVdqpoaxcrr1pAjMSfNiSc51h30D2JEADV4ThNI0daDJQ0TW9/kh6ZjD9E6Utka99c47JekAZYUbJP+8kCVSGtWiF7icFPSZ3XJnhuo+VHlCq3WZ8L1nO28FxPR2hjQ0IfZtt03pkmoD1HPSQ3JSVlUp6MOho1pEhp97WLUwee8oJdv8bssf3WOPcI5UsXLKPj7sKxIO8JYUobDSf3ON1Jv8JeLckbybZ+5++ju7WogY5BhZL8xza2+ywWn3PDMoBL3QW+JhArJ5R/pbterzbXuDddUYEL9kTWMksAxQ80xVAT0cZH1FpYNSGmHDPiFdiDWsbzipZ0NrMjI8u66dIMO1RUvyBXxX8H8xQTJzHyPBlY/u7LiVKUlmYjc9bg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b77fba-2d97-49b9-cdbe-08dd4630bf9f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:02:14.5028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFki/E1AfJUqE79UJ/LnKZNe8OSePHj5F+cvh6yTZE972q5mw90+F+xI78X1S8bcTO2rvajfBdl133+SHd8gm67IDiuFUc2qF96Q2wvrdPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050168
X-Proofpoint-GUID: kAOP3TcIfMH_fJgFA4t3gfWlVHJhTBGU
X-Proofpoint-ORIG-GUID: kAOP3TcIfMH_fJgFA4t3gfWlVHJhTBGU
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


On 2/5/2025 12:34 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> Define the change process ioctl
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   backends/iommufd.c       | 20 ++++++++++++++++++++
>>   backends/trace-events    |  1 +
>>   include/system/iommufd.h |  2 ++
>>   3 files changed, 23 insertions(+)
>>
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 6d29221..be5f6a3 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -73,6 +73,26 @@ static void iommufd_backend_class_init(ObjectClass *oc, void *data)
>>       object_class_property_add_str(oc, "fd", NULL, iommufd_backend_set_fd);
>>   }
>> +bool iommufd_change_process_capable(IOMMUFDBackend *be)
>> +{
>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>> +
>> +    return !ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>> +}
>> +
>> +int iommufd_change_process(IOMMUFDBackend *be)
>> +{
>> +    struct iommu_ioas_change_process args = {.size = sizeof(args)};
>> +    int ret = ioctl(be->fd, IOMMU_IOAS_CHANGE_PROCESS, &args);
>> +
>> +    if (ret) {
>> +        ret = -errno;
>> +        error_report("IOMMU_IOAS_CHANGE_PROCESS fd %d failed: %m", be->fd);
> 
> please add  an 'Error **errp' parameter.

OK - steve

>> +    }
>> +    trace_iommufd_change_process(be->fd, ret);
>> +    return ret;
>> +}
>> +
>>   bool iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
>>   {
>>       int fd;
>> diff --git a/backends/trace-events b/backends/trace-events
>> index f478e18..9b33dc3 100644
>> --- a/backends/trace-events
>> +++ b/backends/trace-events
>> @@ -7,6 +7,7 @@ dbus_vmstate_loading(const char *id) "id: %s"
>>   dbus_vmstate_saving(const char *id) "id: %s"
>>   # iommufd.c
>> +iommufd_change_process(int fd, int ret) "fd=%d (%d)"
>>   iommufd_backend_connect(int fd, bool owned, uint32_t users) "fd=%d owned=%d users=%d"
>>   iommufd_backend_disconnect(int fd, uint32_t users) "fd=%d users=%d"
>>   iommu_backend_set_fd(int fd) "pre-opened /dev/iommu fd=%d"
>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>> index ac700b8..4e9c037 100644
>> --- a/include/system/iommufd.h
>> +++ b/include/system/iommufd.h
>> @@ -64,6 +64,8 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
>>                                         uint64_t iova, ram_addr_t size,
>>                                         uint64_t page_size, uint64_t *data,
>>                                         Error **errp);
>> +bool iommufd_change_process_capable(IOMMUFDBackend *be);
>> +int iommufd_change_process(IOMMUFDBackend *be);
>>   #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>>   #endif
> 


