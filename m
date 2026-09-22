Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A514C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8y7R-0004H2-Qr; Tue, 22 Sep 2026 06:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7Q-0004Go-7U
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:53:00 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1x8y7O-0004Wq-Hl
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 06:52:59 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M03Wog2448180
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=PPGucIRf31i7bthZO13QRFhffik8GEIwfD22AGrTf
 QM=; b=e948dLwTHKUIccEcQnaZpUfXTbLyEx3Z6Ritay/GJJtlaLHMdLbBCF7Y9
 K6oW6aShzEEySAbp5GMFBHAXcZ8yrY48aXHLsZg2/+whAPYPLV+fRad3TN2irrDK
 iKUevQGMmz4EY8O3R5FTk4rY7DBkEt+vwBpghq6WiOpcmCLGMCxJIMkiVO0fTy+k
 8yataKggNF8HGZT8ui5u4AffU0dNIZLPeXq/IrSIPXdCtck1IxaLNgT0R1DxKHSb
 zt36Ib7dophPFOpBp/dM+K3VrUlcHij91j0okhpq0zcWYMzqlbdYJwmaDc+xzyIy
 RIapy4m+j6p3oIHQWKc93rsAXqcQg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021130.outbound.protection.outlook.com [52.101.57.130])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4gu8cwj5tt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 03:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXuR+Ex2891LcDMLnen7Vww8IkcqiPWxZS5xVgbkjinclAp0Ac/OjjIGNxIzmqaEsFsp+bZ81kgp7lsLYLzoUS67uvxNMdShoAsAcuiWkUCrHRuKbgGTRaRZsqqDZsOJyMVFWCimW92OYNh+Fspln12EYxy0pO4WMdlMBpA4Gkgq8n70QeB5C+RpPmQF4mo0a82KM7wkNqZJB3acfXrCt6s87xP6KGP29ghUrL+KMXmi88bbW3B4c1ey1rWSCWuaX3z22u2+mcwrw/z78bqGnryLWQgHXIpv+78ohK7gAqM7cd5zK9BCJ01m3yjWzH8JMIoWxn/CeUtAFI7Nl9hV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPGucIRf31i7bthZO13QRFhffik8GEIwfD22AGrTfQM=;
 b=W64zqV2hxUox9wuqD1GgyXjW3771mNsaqHfse46JpNtWfAmJsJH25kJnGCA6BXsmHFTOPIcuDd7twNPcCi4eCyc8ohYzLB33C41/6Y6ipxY4BDB9DKeeDo4Ptj+OIcjFNousqIzdNvYknJwC+fm+ZBeGxINb+fha5qy0OxfZGfZokWt5CN2rNK7L80gRfqPC1k05u/HwaHnOpQrZEpygEyCzB5lw3XHwj7WrFqNdQsF6lOBzu4gI65GcZ+R86rsdrpa2xf9JWH8kMVaAW82blrLAiqsBIO43XBlRvJMQsVBR+QReJ5gnoIhrtXJMxjfL2hNETgjmMTrms7UkRBd+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPGucIRf31i7bthZO13QRFhffik8GEIwfD22AGrTfQM=;
 b=KxvYbPHlKaj5zfFwd8Z8yrIKISf1Z3YPuPiE/BccEv/tGx1QSa0rN5n6JGyWDtP0ZHB2VTjkoCaFPz6YRdqX4FqFV6lLVw9QLL2dwkhFQWzruy1FHehheYyPOXh9JZLtEDy/fDktETFY5jG50494ulgNAurANIrIFjVT2f1Z1d5Xbl/TcN633fsZoIJb1dfzmuT+GUH3zSbHUD/+cAadlC8whlNwmjgS1PxBfHJD35FRDtc8WefNjDVAstWisixbpY8eezvE+APauemAn7iNmSqK/eyXt9bUT8+GpnIxQ/Q5sE4uPCKFh364QGS4MDsZ3S6U8zxDoIOuj+8FmtD8pg==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by DSVPR02MB11939.namprd02.prod.outlook.com (2603:10b6:8:420::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 10:52:55 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::8e97:bc32:822c:b250%4]) with mapi id 15.21.0451.014; Tue, 22 Sep 2026
 10:52:55 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/10] hw/i386/pc.c: convert PC_MACHINE_ACPI_DEVICE_PROP from
 object prop to class prop
Date: Tue, 22 Sep 2026 11:51:36 +0100
Message-ID: <20260922105223.1607725-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
References: <20260922105223.1607725-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|DSVPR02MB11939:EE_
X-MS-Office365-Filtering-Correlation-Id: 9273ff05-8e62-432a-e3c2-08df1897a867
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: iSYRzxmbSQ9h0ciHco+af4WLQDtfqvIyw5FJDJiem9sOo8XXOG8ToEF/NxhzfPkQq38UTMvmJ+bjWYwapbYZzWDx2c/fUtFBWPPAqQWpYBtyjGcLQzGPgmqpUFCXlDMysQYfyfzu3Y13S2c9ZQ7A+em+zSTp+p2UjAprZzf7w6HDi9FQj2L68jzMZ+BUmRt7gfbQllfwPyNwD8wxOFSn2zBnM3TmzzWmLX66sU/goiC2fj6Etdg4agDfs4xKT/sAIT2/W4DoI89kRX33TsY6M7XpBIDCdCQ3bAol6dICgPabO79JznO1Re1Z0MUjSvCuQFyG1uohYQWWzomwa5baohLOGx+v3HUi1gPI+uxUFcPTOQE0z/fL8NsbO7AJHcxvQYndSIig2tpQ89giKonMCMLKoFM/KmSmzHMMWylcadMmH/LocrDlaLiZ9UzjdwUDNqvb5VYW6WJ9UHWt4EqDO3gwcuqSugkL8amjs3qCvq+9OzV3uPnEsN8gEFQuOYa5FvhHDwhZe48s/f+pF7UXN1QLJhYXmDMjARt+cetbKLQPMYQwm/ycLgcN68dGbY621Cfrhf7o1xIq4+tGJM+IvwwEFwxkjtJ2R7D/3c5/rGCCdM2RsuOg7NZsyfhh2L8QxXQu7kXxH+dl2s9292ypKTBoXWHC2Mk+u1Q9D1xbUng=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkVPQkMrV0FjN0J3N1RXL0tYNGhYOFJzWFNVK2N6WEVZdVptbjdaYk1wV2Vq?=
 =?utf-8?B?M3MxcWFnSFdQMEZURnBmWnFrc2xSQmlodFBmbkdGSHdiaExxSkZJaE5EbTk0?=
 =?utf-8?B?U1FNeWlmdVlMWVA2WDlzQWVJRGVqVjEyMWprekhIb3RmL1hHRE9TQ3R2T3ho?=
 =?utf-8?B?dm1JV3hoeW1SendxYm9ON3dPZ0xKcXF1MytWZnNsendMYjFvZUYrbkVMWFBE?=
 =?utf-8?B?WVk3VXF3Si9POXdUQTZjb0pqdFRaL2h1akhPNG0xR1gxd0xpVENKc0p3VHVz?=
 =?utf-8?B?b1pnRmRPUy9DU0JBZkJqREpaWURETVRURVp2NVlEL3kxQmdzdTlEZFRmUktH?=
 =?utf-8?B?Rm14QWNhRTBPRjFibFYycFBNUVJSV0ZPNE1Xai9kQWdybnprZW1QRnA1Rkds?=
 =?utf-8?B?b2J5Zk1kSWNsY0o3cnlVdnlOK2lrbU42TlFyUVkwRmNvS2psK01OMlhaMFVh?=
 =?utf-8?B?TjJaelN2clQrU1FVMkFKOGs5RU5iQURtZzRDNGZLUmFPWkUxaGMzS2FQVzFn?=
 =?utf-8?B?ZEFSdjR1ZEw5TzBRbVdKbmJjcXpDZUR0Z3ZxUmxYa2l4WExKZk9mQ1UxQmFY?=
 =?utf-8?B?c1FZQXNxUXdKd0hObzNtVGZNZFVNMmtXN25ycVZWaGxzb0Nxd3BicktUNFpC?=
 =?utf-8?B?cXpqcmUxT3g5ZlJRMzdZaVFLM0RTc3lYWnhpOUZDRXNZWkd5b3lFR0c4U3BU?=
 =?utf-8?B?SFFLVG5jZURkZGdpNkJ2MDk5NGZzMFhkR28yVm1jSGd4YW9STlpxb1ZGVXRo?=
 =?utf-8?B?TXBMNkNDcmhUTzZ2K1R4TndISEtmdXc4VEFxazc4ek9maTIyN21jdndRV3N2?=
 =?utf-8?B?ZE9uR09kWWY3OW5qTENBU1lqVmVyZm8wUHJoM2ZFR0lYM0NKaWl1R3FnM0lz?=
 =?utf-8?B?WHRlRUxab2lCdUZPTXR3ZStRVElMelZnT2pZMWR6QUk3S0JHaE1SRmxON1VR?=
 =?utf-8?B?d04wbkdCdWdIZXVXZWVodGtvVnVrMmFLb3VnWlNvZlBTZTlySnVBUzBrT0M4?=
 =?utf-8?B?ZmlaVUJDT3ZhRFB2S081MzVHUjJwOUlwQlp6SkpuajZESk9YaC9XQ0FSY1gr?=
 =?utf-8?B?MXhMUVowdXplN3k5Q1N2MjNJRWVVUTdlaXExS3lOSURIMHl0RlZMM1MxaXdO?=
 =?utf-8?B?dG4rTVVGR2ZkdkU0TENzZ1lPTndPcVg3ZlUveWE2dDE3TGc0Uk1VSFB1ZnA3?=
 =?utf-8?B?Y0ZmS3d2WTBtNDcyQ1I3cnVKR21PZmlUbW1BT3h3OFpPeHBYSnk1R25jRmp0?=
 =?utf-8?B?Qld5YjFZc3VFSlVtZjRkRzJJU1lPV2ZHY2RhekpVbWVsODNDNHk5cnpiY1Bq?=
 =?utf-8?B?ZkRNc21Takw5Wk4rSEN6UmRFeUF3Qm9Bam1JcDhVYUM5eitRUzVVclIwdUJu?=
 =?utf-8?B?cWJOdWY5Vmxhd21QdEdJZmpvV2xOalRmTzFWNytjY3Jsbng5V0hCbGM2cE9X?=
 =?utf-8?B?QWo4b0duSnhJRDNqcjZXTGlUQTRmaWRQTzRuaXFsazcrUkVIa0Q0OWk4SUdV?=
 =?utf-8?B?UFVjY0hramVwMU5CR3MwWVZVcW1xcGlybmI3dnFNd1VXa3VoUWZKMUMwQTJ4?=
 =?utf-8?B?MmVPUWtzYW9QL2l5bHZSU2tvb1FwYiswaGczb21UNldFYmFXeXQyVExSZXZq?=
 =?utf-8?B?Y2dpdDI0eVFZQXh6NUwvQXZwaW8vWTlUQ1B0QXJKbE5UN0gyVnpLSzRFSFd4?=
 =?utf-8?B?ZVhMZ3llSVlVWUY0MGcwUmhHQmhIcnZIMU4zRGd1anpjakVTejltK2Y2RlZL?=
 =?utf-8?B?QWZsSmJ5MDM1OGNSNU03Um5NWEhINk00VXlYQ0tLc0tTdUMzUUVXYjllNmYr?=
 =?utf-8?B?SGY3WW1jVW13dUxFeXFhUis0bWo2YXZsTVRuOGttSXI4Qmx6UEpUNHJ4S2dI?=
 =?utf-8?B?a2lTSHZzZDRFZk1uUm9HRXVPYU9DM2FnYm1yL0g4MnVUTHQwYi9iVHpaMmJ2?=
 =?utf-8?B?SnpXbmVHSUVVem1ZWDYwQUF2ZEY2YXlLZkx3bjFWSEF4cUc2ZmtlUG1Ec0dx?=
 =?utf-8?B?ajJ4M2NObnh5aW5NMGU5N1FvYysxQk1JNUdna3I0ZHZENVRJc21xUGR1Q3Rj?=
 =?utf-8?B?eTJITkF4OHJsZitTL0g3UWhMUjBmTkMzemZha1FZNVRnd3NwajVWVVJHSFo5?=
 =?utf-8?B?blVvYjl4VXYwWHA3ZERCOWt3R3U0Y0lZZ2pmUFRjaDNNUG8yZjJZdzgrc1JK?=
 =?utf-8?B?blEwNkZHekVaSGZ4RE0zdUNIdkV6dWdrQ3hkbzRUbzd1aXRFb0EwdUtsdXdZ?=
 =?utf-8?B?UE1tRWx5c3VGWGtnUzZMemlSWEQxRDJ4MTAyTnljUHpzbzR0akJKbGcxYW5I?=
 =?utf-8?B?VmpRMng0bW5pd1laUDE4bDlrVTJPdjFWUXZHb1VGVUdsOXFGN3UzdUplNVBF?=
 =?utf-8?Q?hUex7DEHTzpYze5o=3D?=
X-Exchange-RoutingPolicyChecked: exGxJSOseHTkK1NRNMFn5tdAgW1inYmL46hRZ2uMrmBYoUi8+V8n5PSlYOX86Xe6aM/978DiP/GRa18Bf2+zyDkxC//PAq8MXMf4Nx1E1zIRig0GtWNGwtwdj1dWlSYnuGnDvowaAIzd2janOZUE3rOP8HHPKn2LbEsAf5qfBE5ynDFokEAd/QAEsvftZqwewZ1ncqVPcXyec29X5eFFO2HovgoiEX+nr5ity5DQNGPVQkBROqceeaU8U0yibrnLufK32HHDMAAmCDSo5IlSRmS7xVEegsN8jEcXeG0nB6PpUCIYlznge5Ey1jUKTOQrDEP1UfPiZu3NJuZgXRHNKA==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9273ff05-8e62-432a-e3c2-08df1897a867
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:52:55.7245 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLpWIg7D05hDoMfinLW1OaHOfq7nP/SmzFd63grkc5wYtySrQEFz2tpaOsp4eYEVfBy7A5qLZNgtWjDJFkmAspHPycqRviP+ERO+1E9gCrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR02MB11939
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX20rChnlpca46
 offtvNtg5Z6FCaSFGevK762IVC34SH0e8s1utQIDbKR+MwrYxdLOJ3nfmzvcQTcAsv8XXUHTuO5
 mx6L/CNcpoTT+RqR0ap2u/0Fc7m+8CxFO3NLpVe2jiGtqALQJqM0eh0nTJ4V2SDpvL7mZx7zpZQ
 1XZsAUUyJjGy5n63QOILeBX2+6XP291vg36rLrTnkK5e71t5z4MUvlIOXT7JyWGEJRA3Cjd3Tvy
 grvq4kBgYpfkibGTW/a83LsP/oqdbb5KIBD9+y/LxfySGsNCl2Zh/u5eBJfKazPg9Gr7PFr7PqZ
 4SBHbV1coSjQbC9G8BoR1YziMcWIlQX2V19SW5f/N1liyEK7Gi0ssjmDh5lb9tzGVrO7UUhTVGO
 H5g/9FPkJvG155BZzgsacY28AWXZCL23m3TUEvuU8apXgqlUor+wXZXm1AooTRq4SQ05Cgqrdop
 EzPf/zgnH+Yrn/F7PyA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE1NyBTYWx0ZWRfX/4sNkps8fwSz
 oPIzhsTjePMT8YcKmGd8EVL/BkF+ocLDwPR67uy7hY/h1xl5+0+QKnJMMhkbK4v8+Ry5bGdE2li
 DluysEmGAt4LU5RIK0CpNzRPBzA5Pzs=
X-Proofpoint-GUID: QSuzfVcUbLUb41eTiVihr5xG0UEWLTnE
X-Authority-Analysis: v=2.4 cv=c9I+0h9l c=1 sm=1 tr=0 ts=6ab25e09 cx=c_pps
 a=OWVKM8MH+YfjEG6TIEPqCw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=y4UcunY2MAxhM4LwGdWI:22
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=UgvehuKUCqWQAMUorh8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QSuzfVcUbLUb41eTiVihr5xG0UEWLTnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921113559.1299740-8-mark.caveayland@nutanix.com>
---
 hw/i386/pc.c      | 5 +++++
 hw/i386/pc_piix.c | 5 -----
 hw/i386/pc_q35.c  | 5 -----
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 70677786bf..37d199f2dc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1795,6 +1795,11 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
                                     offsetof(PCMachineState, alias_rtc_time),
                                     TYPE_MC146818_RTC,
                                     "date");
+    object_class_property_add_link(oc, PC_MACHINE_ACPI_DEVICE_PROP,
+                                   TYPE_HOTPLUG_HANDLER,
+                                   offsetof(X86MachineState, acpi_dev),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
 }
 
 static const TypeInfo pc_machine_info = {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index a929cc4dec..63c4667ea3 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -306,11 +306,6 @@ static void pc_init1(MachineState *machine, const char *pci_type)
         /* TODO: Populate SPD eeprom data.  */
         smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
 
-        object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 TYPE_HOTPLUG_HANDLER,
-                                 (Object **)&x86ms->acpi_dev,
-                                 object_property_allow_set_link,
-                                 OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                                  piix4_pm, &error_abort);
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 94cd71124b..c3ce9c5649 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -247,11 +247,6 @@ static void pc_q35_init(MachineState *machine)
 
     x86ms->rtc = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
 
-    object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                             TYPE_HOTPLUG_HANDLER,
-                             (Object **)&x86ms->acpi_dev,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_STRONG);
     object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              OBJECT(lpc), &error_abort);
 
-- 
2.43.0


