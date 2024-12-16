Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E6E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 16:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNDbT-0003oU-4Z; Mon, 16 Dec 2024 11:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDbP-0003lN-Jk
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:05:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNDbN-00067z-FC
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 11:05:47 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BGEtpdQ026814;
 Mon, 16 Dec 2024 16:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=/+7Eu34PB2AC3odgilgF2KgJAKGKpYXsiUeXVEijr4M=; b=
 Y1MbKw3dthliBucgt59fd59uczo8oh3CpyXiB35ftW8XqpBoB0/7yqrAkGzXO2Xg
 rU+DDX+xzu4CNs/r5jw3yiq8S99HR8MVZ2G4u0mpa34qhKxibFt3AiCs2rw80+vE
 D4jKedEzH+EQbnrC4Fvs7I9aXrr60vW1DahP8/lGFalflapQxp9OSlBLQi658ENh
 hzF14xr0FXjN2yNOlOG/A3ibMMlPIsti4YNIDo/Y9q/p1v5z67UQ9tUO0/6RkpNW
 9Lel5tdj5yYuVkvb2Psn2eoy9XFWFFngCjnS0z+TfMfml0L5YZhmM4H6RVwOoPSx
 rYZnlL2zz3iYqsfGVGEUXQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h22ckjmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 16:05:43 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGFTaWs006392; Mon, 16 Dec 2024 16:05:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2045.outbound.protection.outlook.com [104.47.55.45])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f86v96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 16:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5ueieQ/0FCYSFzOHRkIZMTmtW86+oHu12N4yEJnutv+G2Ux+jfbOHe/aPpexpDuxGM3n2kjI1XVYr1hDPspIZrUVLZOi6drFY8kVFMw3ozo1IXf8zDRo0esCe73I72M7OBezARzxz1Xc1Xf1k32zWBsAG0cxBacHQsDloC0Gga/g/U1wyyEiyglwyuywT1HVJA2lTThxhFzvG2k3Hq6k5b4GbTozJlqa24bqM/TBcFt45iyXFknYnEM6Px12CiMuQASFRNpZSYLWKsmyUGzS2Y3bGC7Fv7MSshHyXTYN/oDH5kKtlcCh9Ebt+0/Dfc2PIAKY9WLuyDM/TcAOpB0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+7Eu34PB2AC3odgilgF2KgJAKGKpYXsiUeXVEijr4M=;
 b=iR2JK5GCbIOpi/xYy7QkFYvjIDHR0xSpZaRCCxCY4r5Lxzt7+b2OO0ec+XGcxOeXJeghk1LdkjCE9Y9RibGS0TJWk3qFRYK/jk5FC8xgy4vvginOmx2/JktLwGQsbfNfW8aar6jE8MLn2QATmpjVjJVv+QrfWihF0ng+zpfHPuE34xVG2yVV5ZQou7qndnm/tIolK+AFZZzyS6ID7W3icaqE2T4Fsv0SQv2v+y8YUYVv4jvj9AK7u/GwW9qz1UPY1uXrzBF5msTQ4gYwqpicDC87QS9c0VYVbhiZzOZxP/b/UxviEuSPH637RQgqjUDH59lLo2UF6WuQYRj9STI9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+7Eu34PB2AC3odgilgF2KgJAKGKpYXsiUeXVEijr4M=;
 b=ZtGZwoMuThrLQRhSSBYXH57/WdNdOQtXtJNrm8F8OhQjikmeDb/ydtNyIDWYuMv2bW/dbFfk8SLUrZad3RiP6HiM4v5J3jP0E/XTguDmeW54w9Vj2d99KGu7/OdRKD0DvFXfesvgWzt+lDR8yNoaTGVBOwqp0bIkHf5Z5zc/Mas=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB4974.namprd10.prod.outlook.com (2603:10b6:5:3a0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 16:05:39 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 16:05:39 +0000
Message-ID: <b6aef9a0-60e8-4b7f-9a42-9a0cc024b0c7@oracle.com>
Date: Mon, 16 Dec 2024 16:05:31 +0000
Subject: Re: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
From: Joao Martins <joao.m.martins@oracle.com>
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
Content-Language: en-US
In-Reply-To: <9d594215-307e-4014-8df6-6e019999a7fe@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::19) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB4974:EE_
X-MS-Office365-Filtering-Correlation-Id: 553e89a4-d0cd-4585-3e4c-08dd1deb7baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzRtTCtrRDVvajBOSEVvS1pqMzBzd2tkWHJrRXRRUzJSNU40Y25FS1k0VWJO?=
 =?utf-8?B?WnBvWnltaFZkZFNFaXdMRUhNZ2p3WXZFYzhpRXREMHVYZWw0R1VQc2szcWtZ?=
 =?utf-8?B?aHFKc3lEVm1kNlM3SmZuSEZzOGRPcjJxaGJUYkloaTdxS0tpbVBRL0Z0bktj?=
 =?utf-8?B?bkk1L24xZ2paU3orK2YrNTBaWTNVM3MxMUtsS016VFRlZWZ4YzBOUVE2bWxZ?=
 =?utf-8?B?L0xvc002SUswd2xLalpIYmxnS1VXQ2NCMXlDeXE2d3VsZU5SMmluY2VoR3lL?=
 =?utf-8?B?ZUp0SFhEdks3cjFtd09MbGMyRnZjU0ZqREExdmV0dlE0Z0kzcWI0WFFDaE5q?=
 =?utf-8?B?SmdPYUVCRCtzZ285QlNyMVpZNzY2aURlblRYNzNzdE1NRm1kQUYrSnVTUURD?=
 =?utf-8?B?YzBRUW1WRm4wMVcvQ01Fd2FuMVgrREhzbkttMk1meC9xR2laY084T3FLQk02?=
 =?utf-8?B?SVBMK2xzRjIyL1VWZW5NZEJQZlJWTWZJZHliWjRjYTdmb0h3bTNwMTIySUJ0?=
 =?utf-8?B?M2o3TmdRb3I1K0xEWGZNODdWZlp0bzh4eno5VjBjODlFZVhYOUx5alhnelpz?=
 =?utf-8?B?UEVFeU1HWS92THFuOFdHZnBLdmZiODRobDNuUDBKd1U2TC9DdUNNaEJqWDBl?=
 =?utf-8?B?YWFBaUpaWGtVTyt1WHNXYXVnbWNBRVpySnRvMmpEUlMzMVNNcDVQM1R2NmIw?=
 =?utf-8?B?RnhYRU5BNllITUZBVEsxbXJJTG5RZm9iRWMvZHF4VTd4N0NWeUNqY3c3Z3ln?=
 =?utf-8?B?WGtmRllyVXZCREE4aXZVb1oxOXNkc2x6YkNIODhVVnFZNzZFbFFYbDZYKzdG?=
 =?utf-8?B?NEJaeXY3aTlZVHdvdUJEK0xDaUUvNUlaa3diUms1bElrZkEyU0hNYzFTbWhF?=
 =?utf-8?B?ZWxSaXM0YjJFcTdqekU4b0pWUE8zQ251aGpnQzNSb2lkdm85Qm5oOVJjZDgy?=
 =?utf-8?B?cDdBS1N5UXdFRGJTZ21JbE1VeHp4Y0Z5YzlaUjk1RXFjeXh0NkdmNmdRaXM1?=
 =?utf-8?B?d3B6cG13ekVyZU5EbWVHaXhKakFRRGpjT01sKzFxZEY1VEdtTmdZSWFWZTRJ?=
 =?utf-8?B?ZGpQZExKSkFSWE4xc3A0UEU2RnhpQXdYeHdySStySzAyQVpCZW5MSlM3bGNI?=
 =?utf-8?B?bW1JQXUzUkhCZXN1TnNiZU5tNkhubi9BRDVVTFJOaCtTUUtPY3QwVFdjRGVM?=
 =?utf-8?B?cG55dW9QenBMKzNob2dEMExUMDBKTlF3SkFkNXZTZHh4VFF5aHh3KzdBMkZI?=
 =?utf-8?B?bmN1bVgvbjZ1UUJqVG9qeVdxM2RyY2dncWdHQUt2K0U3dHBTV0pvdVZ2TkxH?=
 =?utf-8?B?aHJXRzl3UXd4alc3b0JONFZFdnVWUFhRazE3d3VLSEF2VWJxdU5vQ1dqQkRx?=
 =?utf-8?B?cTN5L0ZCMkptNWZ6TjQvanAwaE1iRlE3UG0wSlR0NG40YzNVOUtaRmF3SFhJ?=
 =?utf-8?B?NlNZZ2RhSlhGOXpTcU5LN0tCaXh5Zm53ZE1QRk85R0Zhc00xNTIvdi9ERDdP?=
 =?utf-8?B?ME5vaG81bWF6Qyt1d2UyRzJhcTRLREh0WGdCKzV2blVhK05RTm82NVRqU3NQ?=
 =?utf-8?B?UDVwVWZIL1BtWGZQVTV6RzQvZThiOUxTalZBUlJ4MVA2bkJLWWNzZWFyT1JW?=
 =?utf-8?B?T091WDR0QXBraEl5Q0x3ZG1nU2NvUGR2WTdDNVpYZTR1dnJQbnhhR2Z1NkNC?=
 =?utf-8?B?NGRyVG9QT0dvckQ3SDFDVklwL21tNjhiMWlPWEJoQnZINVV0emhvUUhXWUFM?=
 =?utf-8?B?UENpNzFNalpWSGlWdzgzSlBNT0N6UkVnTklOcEdMOVUvdW4wSmMrKy9kcDRN?=
 =?utf-8?B?dkpXVUc5MGJEc1Azcnl0d2N4NWVCNTRNdVAvQkNQWFFmeUVwMUR2QVBNY0M1?=
 =?utf-8?Q?gC529o51jfnkp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG91NTNyUkp5YVMrakMyVnU3SWN2T2QyZjllYXdOZERTbDBDd1MxOVFrMGhJ?=
 =?utf-8?B?NDg1QVB6VFY0MGlEVWk0N0t0S1Z1NWpkYXJCdG9QZTFyUkdxOEwwRnpacE41?=
 =?utf-8?B?VUNrRHZ1b3U0eHpaMmQ3aXdYSEZYR0NyOHFONXQzZkU0anpFVG1IVTM3RmJ0?=
 =?utf-8?B?K3NxV1VFMGtJUkJONWRhL1ZGamcyUjIyalY3NnhYVmZEVWx4SVZTclltdjd6?=
 =?utf-8?B?K21jWW91b3pXem5qazNnN2diTmtXOXZKdlVRbSsycHFVbnZYK2FDV1ZOWmc0?=
 =?utf-8?B?VkZjTFF2TVRYQVB2OW5EWTBvaFVqNGxWbmtQam40MXNQVThRMXlEcFg0cnJS?=
 =?utf-8?B?UXpkdU9OeTB3SlkrS3h5TDVSWCtIT0xWNVFub0NhYlNJbmRHKzFKYjVJMnEy?=
 =?utf-8?B?aVBBL2F3eU5lM3NXcGZkYllEcTlaRFgzbXJQR2h2dVB3blc2UDN3TlUwK1JK?=
 =?utf-8?B?ZWxLS0xKWGo1Tnc3V0d0VVpSYXdmQzE1dHJxR0Fra212QUtaZHdzWEtyTDMr?=
 =?utf-8?B?SS9BMXFRR1JBVmRjUkRRZ3k0Y2dDNG9XcnJLcm1ZcmZuTlZhSkg4Sk5ta21T?=
 =?utf-8?B?RWZPYTdvYTlGU2hvUk9DYnBmaE9rVDdvNVZLOElRT25Lc2NzUWNsNXZON2xy?=
 =?utf-8?B?QkRLRWNIYkJUZEZmVlZxWGpBZDBvYkZtLyt5ejNJZzQxNTNNT3FoZHdEMk5r?=
 =?utf-8?B?RFk0Q1dHcmRoWVdxdzhtYjR1SGJmUVBSRmI5YXVLOXlxbDdSWWs2c3hlMDUr?=
 =?utf-8?B?ZGRNanNJMWp6emJVNmVIL0ZmRHZBVEswY0t2dnMrdkpNWXlHUlFXWGJBZDY0?=
 =?utf-8?B?REVicWNSRHdnaWpWMVdGMmh4azJ6UmZXenN4WnhOTVEyenIwODAySUp4ZEFz?=
 =?utf-8?B?bS9STSs0WGdqdWYzNkZQcFdLZE1kZ1FXa1lTQnRoaVZzUEZ3clNlLytzN3Fk?=
 =?utf-8?B?enZ2MFpmeUFOYkxXdjJTVTgxcXB4VXl5ekdad2toanVYc1Bwblhkakw2MGRP?=
 =?utf-8?B?amlvSVkvMTM4QitnbDRpd1Z1b0RKaHprMHhMZml4cWVtSFZ4UHVpOENNbTUz?=
 =?utf-8?B?VU9kNms0WlFiSTc4Nld1S2lMQXlCNEV0SjN1NkZST0xscE8vTVhmM004a0ww?=
 =?utf-8?B?NStEeVdrRnVmanN6dUdheWh5UzBROG9tUUFQOTc4akRkaDVxdFFXQ0dsMTRo?=
 =?utf-8?B?Y1dPWHY1MjBLeUx0SlMrY3N6SElWM2JYT1FDVEM3cEdHWmwza28rUy8yNzRh?=
 =?utf-8?B?ZnFrMk1Td05LSWJ2alFrZXhPb3djU2hrSWtjNlpJWmhiaEI4UlpqMHpJc1dm?=
 =?utf-8?B?QUZaSURpbC9lOXRYS3NZQlFMRjljaDQ4TVZVWW96Ym5jNzhpdnkzN1lLRUEv?=
 =?utf-8?B?V3g4Mm0yRUtBVGo5ZXl0YTN3T0hwQm5xVS8zVHAwMVNSRnpWbnd1VG1vbTFZ?=
 =?utf-8?B?M3Z6OE5CWmRqbW01S2RGd3N2RjJvVTEyVUZsN1Z3dXRWblJXZjdZVEp5WnA4?=
 =?utf-8?B?TU5MMjNld0JMS3F3QngxVVpwWWdrbU4xem9MNkVVZUxjdlMxdndxV1Vlb21L?=
 =?utf-8?B?dkdZdzhQSG0zSWRiM0c4MmwxbVU5RGFOUCtaTGNUNnNtSUVtZER2bHpxOUlt?=
 =?utf-8?B?ZDJmYTUzZENadjRBdnRIQ1RaUVlCYld5elNSU1ZrbTVXekppWXRrak5KVE5m?=
 =?utf-8?B?T3BSVGExL2ZZREdnUHhnaEdIOU1QUlV5Ukw5N3lrZkhsRUVRV2JJcmo4Q2Ja?=
 =?utf-8?B?NU5wYkY3SWNqbkxVd1puT1kyZWpRNWpiL1dGenU1ZXg2NmgvZ2xNOXo0eG5N?=
 =?utf-8?B?UmF1THFHRk9LbjQvWU1hVFVtNXg0VDVWNDU0WjdnTStKckpDRFRlOTBRZ3kx?=
 =?utf-8?B?SHRFZTNtaTkyOGs1R01PMTZLUGk5Y3FvM0JSZENKZUxOWmdzQ05kZlNTZTkv?=
 =?utf-8?B?WmFPdjg4QXBpWXpXcDdPeGc3eUVLZExlTFE1Z3NsQUp1b2ZTOW5ZOElJaXlz?=
 =?utf-8?B?MnlJVkJOc2JxZ0lqOGpBV1JhZ2RxZW8yTFlCNDBTekQ2MC9IWHROZktzS0Nm?=
 =?utf-8?B?cUN3bnJJaVRrRWhBaWN2Qmx1Z05qajZza1EzR1paaStCeGtJdzQ1eDlkRFJi?=
 =?utf-8?B?Vm96bXh5aldVRnN0MGJLb3hHdnU1b1VmdkRjdjMzcmxoNFBiMlI3TCtiS3VK?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GgKuR2zcuFl45D0DWtEQhw4UUBGU3e8avwz6GZ8w0v/Q0fh/O2D1WKTbqP3iiqXseK4o3u/k0mlQW/2mzGbgFIkwBtKcNcx8SaCdbfXCQv0UOSHURRNRchsE1kintf6UHvUsp/RLC2ePsGI7C+LFRa9rQt4HNIgjuVnXjxfTuLvSu5oGuCVbnVlW22OrfRNz3VMYAa4MncMDZ3sCOx7CI8voumdhad5WnR8IXz0gGz/XKtcb81APLtD97ailLRhjz1e5GEqZw+YUT5IZrTLZflvyFAQ6tmr3thxKxco+u/T4kMEGokrrnDGmJuJiGAXQvS6WqrHxalZ3dPILt9Pr1Ga8puL7qz/98nRsA/i+YFW5vYErw6BeOGWOB1CBlOtn6sM+SyCmnHtMI4YcABWp9S8hyPsAbSPl7IZ+iCL3A+K0AMnJCF9H3TaCKC3Kn2Rs49RtfrK3e6wHD2YVM361gjv9gyKa7Spb7Azf/qDNt++ddzcNxao0g2zYV5LfYP+fTwzeOQx4SvmLEwLYyKoj3a9JFmoihcKPt/mp7aP5fov91tbw6nNUdwpB4C4Q/KSpyHEjIOIzSa6O7HF3TyjUxaehd75djQCNQgL5YVF/Lz0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553e89a4-d0cd-4585-3e4c-08dd1deb7baf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:05:39.1284 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K32uvTMDqQBKIL0XJ7DYt4cdHizgQtKD2MwZ3DFirvSCkli7TCDDUVyjWD1vfV/pnKOunrV2tmwXDMQhYISK4pw6cyWtj+4ujaI9B1Yu8nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_07,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160134
X-Proofpoint-GUID: CoI1yihZHVFARuNLAnPCeoINnG2s8TjJ
X-Proofpoint-ORIG-GUID: CoI1yihZHVFARuNLAnPCeoINnG2s8TjJ
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

On 16/12/2024 15:52, Joao Martins wrote:
> On 16/12/2024 14:52, Avihai Horon wrote:
>>
>> On 16/12/2024 14:32, Joao Martins wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On 16/12/2024 09:46, Avihai Horon wrote:
>>>> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
>>>> check if dirty tracking has been started in order to avoid errors. The
>>>> current logic checks if migration is in ACTIVE or DEVICE states to
>>>> ensure dirty tracking has been started.
>>>>
>>>> However, recently there has been an effort to simplify the migration
>>>> status API and reduce it to a single migration_is_running() function.
>>>>
>>>> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
>>>> it won't use migration_is_active() and migration_is_device(). Instead,
>>>> use internal VFIO dirty tracking flags.
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> The refactor itself is fine except a pre-existing bug:
>>>
>>>          Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
>>>
>>>> ---
>>>>   hw/vfio/common.c | 21 ++++++++++++++++++++-
>>>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>>>> index dcef44fe55..a99796403e 100644
>>>> --- a/hw/vfio/common.c
>>>> +++ b/hw/vfio/common.c
>>>> @@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>>>              migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>>>   }
>>>>
>>>> +static bool vfio_devices_all_device_dirty_tracking_started(
>>>> +    const VFIOContainerBase *bcontainer)
>>>> +{
>>>> +    VFIODevice *vbasedev;
>>>> +
>>>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>>>> +        if (!vbasedev->dirty_tracking) {
>>>> +            return false;
>>>> +        }
>>>> +    }
>>>> +
>>>> +    return true;
>>>> +}
>>>> +
>>>>   static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>>>   {
>>>>       VFIODevice *vbasedev;
>>>>
>>>> -    if (!migration_is_active() && !migration_is_device()) {
>>>> +    if (!migration_is_running()) {
>>>> +        return false;
>>>> +    }
>>>> +
>>> Tieing to migration status means that non-KVM dirty trackers cannot be toggled
>>> unless somebody starts migration. When really your original intention behind
>>> commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
>>> was to avoid the setup state when you are indeed during a migration.
>>
>> It was tied to migration even prior to this commit, as VFIO log syncs were
>> restricted to run only during migration (we had "if (!
>> migration_is_setup_or_active())" check).
>> This commit only narrowed it down further to not run during SETUP.
>>
> 
> Ok, good point.
> 
> Btw you are regressing from that behaviour with this change above, because if
> migration has state MIGRATION_STATUS_SETUP and migration_is_running() will
> return true and so you will log dirty pages.
> 

Nevermind this comment.

Just noticed that it was the point of the whole thread:

https://lore.kernel.org/qemu-devel/78729b4b-3747-4408-8146-12d49e70fed1@nvidia.com/#r

... where you discuss this.

