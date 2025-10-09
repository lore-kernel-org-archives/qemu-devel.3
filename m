Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DDDCCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 12:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6ppY-0005gi-Hk; Thu, 09 Oct 2025 08:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6ppW-0005gN-02; Thu, 09 Oct 2025 08:33:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miguel.luis@oracle.com>)
 id 1v6ppQ-000306-D3; Thu, 09 Oct 2025 08:33:09 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5997u26d009615;
 Thu, 9 Oct 2025 12:32:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=+SbsczOpHTFVbCaISQqCeeyGKhKBB5SGoaxvc/hr4pQ=; b=
 djOrYSIIQZAFonw0KoXL2Ik/HjFnu7WWtZgx+YjjtcpqrPyd7hTQgH3+ERBhy9a7
 pvLE/+FsX1XxxVeu10iD98KmL+kylhP4L795pgs1aIUMEzL2INC0WiukHt6OHDK9
 Tow932UnbLf8IwpOTA8PJEXbDoC/N6Z6FhRTkaESJOKWyzXvpMtPHyJbtcj7TfJj
 ILrhV6691tGCKbcftD4Hqb6DDhKTUKjr2M0mXohAd5NKs+AiXkJ+mVr/mHY8UHKE
 txrd5uTHX20VFEj49qkwPTN/3v7vF4t+4idyh9I6EEph+7K7ruihnwqEzr5snucY
 0lEmz87BPFQE6iB6xzG30g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49nv6dsggd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 12:32:20 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 599BObFR029035; Thu, 9 Oct 2025 12:32:19 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013057.outbound.protection.outlook.com
 [40.93.196.57])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 49nv67ubkn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 09 Oct 2025 12:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPjlvlAboO85cSX+Ln+5d1AKX0VlvWblIuuJyFwB6GR7KK4P0DHefXtUaBHfiB6qE5uyDqxZYMzW/4GFwL/GDc70xZJUglqavZlyalzCtQVcG4wgWoFopvV4du9GPSPwgcI4AfmjNuJvf5329vfSXMbpRXZu+uQIG6xWwMzSSQMnqdSkyhnctolqYCgpMPLR45aZpjbH8c7cYp2pS+g2e2WzzvyLSVskrXUGiFsskZubRkSDul1JwlsMc5HUnw/ALy95fIxM5z8CHUyTqQy25iLprexgNMEHc0BBzYHvLacxF3O11ytyT4x6tauCwO30pvAKbY9G174qDZEwNDqX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SbsczOpHTFVbCaISQqCeeyGKhKBB5SGoaxvc/hr4pQ=;
 b=OBgFuMwvn3m4Py2/arE4ECmbPCOLjJ+Mwkw1g+wGGZ3Mbaa8MBaYkp4THDtEPNTDynTSPUOV8EMav3MNMfpUZN00i9LZ3Q5mmawu2xHSnxKm/Q4weF/JFYkwWUyzfkBScSfErcWlvXZlfXF/nJvgaUZrNB2LUxW+MMKyG5FZtiYBducvrTnhqJlObAOQ65dnMt+ROgZoUbyoqqSW+ffIB4m0mV3yaKfUq19q+Cixky58elf6i9/Qv+z/6yLlrouLqfC5YkCTlQnHcpM7LNrP9KkM1/fcapjAh5pHQO4EoeVr0R7GFQ29UCdeTTqCojnozXX3CHNSfH8RKKOY6cmg4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SbsczOpHTFVbCaISQqCeeyGKhKBB5SGoaxvc/hr4pQ=;
 b=mEjPKl5uBrWccjauP+8jygrkNWcbIaNvQaB1hb3sSgJyjXi9q+FnujVJvh8trr+I8NVOuAI47h5ZwyLCrqdn2IRBZhpKUUCpCx+vl1QS088/qkGObenhw3ZrAd00HX6eUAd/YGYQqDm6XM/Jlhg6Cxd6oaDKs2j9+16BmkgTPjY=
Received: from PH0PR10MB5894.namprd10.prod.outlook.com (2603:10b6:510:14b::22)
 by CY8PR10MB6516.namprd10.prod.outlook.com (2603:10b6:930:5c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 12:32:15 +0000
Received: from PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7]) by PH0PR10MB5894.namprd10.prod.outlook.com
 ([fe80::75ce:9a39:e0cc:96f7%5]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 12:32:15 +0000
From: Miguel Luis <miguel.luis@oracle.com>
To: "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "salil.mehta@huawei.com" <salil.mehta@huawei.com>, "maz@kernel.org"
 <maz@kernel.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "andrew.jones@linux.dev"
 <andrew.jones@linux.dev>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "ardb@kernel.org" <ardb@kernel.org>, "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "gustavo.romero@linaro.org" <gustavo.romero@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>,
 Karl Heubaum <karl.heubaum@oracle.com>, "zhukeqian1@huawei.com"
 <zhukeqian1@huawei.com>, "wangxiongfeng2@huawei.com"
 <wangxiongfeng2@huawei.com>, "wangyanan55@huawei.com"
 <wangyanan55@huawei.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>, "maobibo@loongson.cn"
 <maobibo@loongson.cn>, "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V6 03/24] hw/arm/virt: Clamp 'maxcpus' as-per
 machine's vCPU deferred online-capability
Thread-Topic: [PATCH RFC V6 03/24] hw/arm/virt: Clamp 'maxcpus' as-per
 machine's vCPU deferred online-capability
Thread-Index: AQHcMm8O+gl0XRu+g0GMqrY8zpvDsbS5zJEA
Date: Thu, 9 Oct 2025 12:32:15 +0000
Message-ID: <4764573F-D108-40BB-AF23-B4B29E40BEF8@oracle.com>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
 <20251001010127.3092631-4-salil.mehta@opnsrc.net>
In-Reply-To: <20251001010127.3092631-4-salil.mehta@opnsrc.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5894:EE_|CY8PR10MB6516:EE_
x-ms-office365-filtering-correlation-id: d84bee31-37e0-4bbf-3b2c-08de072fe116
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?ckw4R0ZQaWZYS1N0NUk3RG94RHRnMzNFWTlReEpuS2ovTG9YZURsVkE0OWFk?=
 =?utf-8?B?S1p2K3dSNVFhWmFjVGU2UnR4NzVSdTZvVkF2c0U2RjBRVUV6ZVJVUm5YdWRX?=
 =?utf-8?B?M3FOdm5qamhQVlNJVnV5Qyt6ZnFiYXlyenRCTlE3WFVISVhuTWgxeGhUQXNK?=
 =?utf-8?B?aE55L3U1QjhKdStEOVhCSGJLZGtNVU1SK3hwQncvVGpZMVZTZFZRMHpzaXp6?=
 =?utf-8?B?a3B5MWZiT3VvbnV2cWZkOFhrWEoxb1Rlby9NUEROamduUzRCMlMxM1ZGaGEr?=
 =?utf-8?B?dXNNeWhZS0tWUEptbllJcWpYLzVBMisvSHZ5V3RXeWM2UWNYYnFCTDQwUXBC?=
 =?utf-8?B?UjVuUC9VaEFjSmREYW13MXFlRVFqRHlmcnBMc1c1cWtuak55NGI4bkc0d1Rk?=
 =?utf-8?B?Y2xZZ3VJdlUzYlcwVHl5OUhWeHErYzViQ3lqcVFZa0M3SnpXcGxHL1NhQzJv?=
 =?utf-8?B?T0lFMEE3N0N3cWlDMnNya2VQeWh3eVZqM0FJS2orUjdqdCtSVDg0YVYyNWF6?=
 =?utf-8?B?MzlxSFlkekFORTZqWUZzejVrdit3cHgrY0dxeFZtOW13Q1d3YlBGajRDUDFL?=
 =?utf-8?B?NDd0d0Y4ZElMMy9EWTZ5VGk0MHM5WC9YS242MFBJcmlGWmJhbXdRSnpGRkx0?=
 =?utf-8?B?NkN4VTNPSmxFZE5MRFh1Qkxpb3V4OThFZDl2UUY0L05FQjFFSmk5OXk3ZENt?=
 =?utf-8?B?cERFZi9NMGExMVhYMG4yekErWUhLaTNsZnN6YzNlbjk3dzRTYXZ2MnNtZms2?=
 =?utf-8?B?QzQycUtkeG9ZVktlRDIrNTlQcTdkZ0ZZK2JRLzVSTzYxVVFDdS9VZXA3cEVJ?=
 =?utf-8?B?NjBEeXVoWmVZT1VkcTFXWVJzbEJvU1ltMW9EMXVwQ3lPNmE5R0o2MllGa2Rj?=
 =?utf-8?B?UnJpVy9zTFR2Z3A4ZEwwMk9OT0x2amdkdkhrMTlqSjFkUFRqTHk1T2xoeW5m?=
 =?utf-8?B?dy96VDVGY3JQdTladytKZ0lSYnkrNVVWaFpsVTRxdkxvTmg3QnRIZi9xNEpi?=
 =?utf-8?B?b0N5cDljTjAzcE5CVTZyaHN4Z0R2SVBRZVFuZW54Ny94NWZIN1lUOWp3ZkhR?=
 =?utf-8?B?V0FZbFgrN1RCWFNPcG11T2JzaGd4RkRNM014eEJmTDJGMHhJNmxiSzVpQzZl?=
 =?utf-8?B?QWVYVDJVbkdwS01lNlJZRUx2MVpQNFVvRkZmT1dvWStWSjAvVmVPV1BYMkJo?=
 =?utf-8?B?SERWTWp6bldmVWhnRzVwOTVsYk13V3hjWEVIbG1BeVhiU2xMWDVoSlRkNnQ3?=
 =?utf-8?B?SlVkei9hYXVFRk1VVkhkR2tlbWRsRzdzUkthcm9xMnB4bDdvcGNTNlIyWExm?=
 =?utf-8?B?dEJFRk1MWDBpNzZwTUEzNDRWKzE1bENlaTFuTmxEeU1jZTNjOEZPZVNsOEw1?=
 =?utf-8?B?bThkMzMrazI5YVkxU0RRcFRVL3NzV0dUcWg2OHFkOTMvd0FqaDFrdWEvZ3Qv?=
 =?utf-8?B?U2dPdHJPZFg3d3VJbnpDaVJxMXJTNnJVSUQzSUhjZjloREIzMUpiSVBSNmNo?=
 =?utf-8?B?cEp5Q29wSjlqQUtYQWRYdW8vdVI3dkcwc2d3cC8vOFladm41aExqcnlpeTJU?=
 =?utf-8?B?REZWczlUVERlQWpCWFIxYktMYXRZWnovZTRCUDZUV0FpTkRFRXl3Mnhaak11?=
 =?utf-8?B?RnJ2NHcrRFBIUEZZalJwSTJiUXNlY2pqUFpoR21IcVNIOGZIOXRwVGNjeDVq?=
 =?utf-8?B?bXhlalI2YXA0K1pldEd5S2JpVFUybThDWFJ4Uk1Ud3FSamZRVUcyem1lWXpM?=
 =?utf-8?B?UU5adzVyek5kbGhVZTBTT3V6WklPSzhsa3k4dEUxQUFWTVlySU1ZMDFxcHEz?=
 =?utf-8?B?cmhLVlpRQ1FLTzYrc1Qyb1dvVG9wM0FZQTg2NEtuQzlEZjIzWFlZL29vRjln?=
 =?utf-8?B?K21YM2I1d0lGeXZSc0ZuRWlvZkN3Rk9hbjJzMTl0TjNLbGk0aWowU2hpR3lk?=
 =?utf-8?B?OWR3UEtsMEFUWEtGZ3RYWXMvdGc1cTlOa0pCMzJOc3BreVMzVnREWEkwUzBi?=
 =?utf-8?B?K0R2VEJkNnVEeDJLK0hIZ25nS2xheW9nVVN3Z2tFb2tNajBEWEFtQUhGcUow?=
 =?utf-8?Q?3C+XwQ?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5894.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHJnMk5lOTNhUWNaVHFlY0I5YXJIbkN5UXI2RlloODUzRmVlekJsNXVOOC9m?=
 =?utf-8?B?U0FGd2NJUlJtdzZuT0dteDc4alJGZDRkdFhSTkowR0E3MFhidll2UE1RSDIr?=
 =?utf-8?B?R2x6TUJMdi9DUnJUOS9YZzQ5VGhpYlNjTjlub0RVSk83UHkweWI4em1WTzU4?=
 =?utf-8?B?OS9HMWo2eWVBZEZiNlFJeEd6L25xeEdFOUpKNis4UllHV2dIQWFFVjlTOWc4?=
 =?utf-8?B?WlFaSE54ZERGelNyR252L2hoWThESUZrcDJtRk5mSC9BU084Q1V5L1pzYk83?=
 =?utf-8?B?RU54OEtlaEpwQ3k1eHZaTVBIZnRyQVB4U2pxT2JHZXhadVd1ODcxOURLcVA3?=
 =?utf-8?B?L09WMkRBYTFWTmxCNTAxY0dScUJZVjBZNFpTaGVXV3RWTExlUG5vWmpSLzlE?=
 =?utf-8?B?bnY0WTZVS3Ivdnd3YS91MEk5aUw1ZXRqQWZwVXg4cWtUYWZ3U2VqMUtVVitY?=
 =?utf-8?B?enFIdkNESlpZUElYWTRmRWw1dGlaVERoRXFGbTNmNEdEc3RqOTJsdWFwNGh0?=
 =?utf-8?B?dU9mV3NDZmJieFowdW4vdExvb09hZ29NMkFZaC94eVdMWFVnTUYrRGpjOXNS?=
 =?utf-8?B?VXdhUWxNa0RraHhscUw1c0RrMksxUjJQczFrOXk2UnBOR04xRTJoYUp3eWJx?=
 =?utf-8?B?dlVLRkwyd2lkRG9UeTBKaVdRU2xFejdaeWlBamF3Z0wrdnNXRm9BWXRTeEdI?=
 =?utf-8?B?RXdEQVJYZ0NGSUhvZXF6K2dMQjRJQzJ2NjlTQXJYTk5BaVFXWHRSZkE0aGRD?=
 =?utf-8?B?V2p5RmxYQ1JKQkt2enRUSUk3VDZnTUhiVmpBVzA3MEZoVEFZNG9VRU1OUmE0?=
 =?utf-8?B?dDE2Wm50THdOWklMQk9zaWJVOGxnelRYR0VPZ25iaEp6S0NCU2FuTk42UEow?=
 =?utf-8?B?NTcxWldtN0NFU0Q0UXZoaDNvOCtsMytWT044ekNxZkV3MW50RFMwYUxQNVNF?=
 =?utf-8?B?Sm9JcDVCeEdmTm9EaEJSWEk0VTZBTWFjME1jMnBUMi9kdmFVUGY5eWZ0UEpa?=
 =?utf-8?B?WGtoSVIzZUVwL0xHTFMzdSsxbXhuVVpQeFdWeC93TEtkbjRRcjUwRXkwSXc3?=
 =?utf-8?B?RkhmY3Jma1ZVMFZhYXpiSEdnYmxUZG5Tbjh6a1hlTmlkSlhKVG1JMkxFZmx3?=
 =?utf-8?B?WldNS1ZTcjJGWmd2T2tRZ2dpTkNNZmFuOFZ6Qzdhd3BKcUgrTStGa1ErbEZJ?=
 =?utf-8?B?SEF5bi8wYUhlVUxucnNnU0ZsRTVjTzFNVUk3dWM4eGxST3o2UTljQmdwMkRT?=
 =?utf-8?B?eFdqOGc0RWtJZnJqRzhvUW5oMFFUbit5V2VNK3NLMzRMbDBsMFBtK2RuTVFX?=
 =?utf-8?B?Wnd0YVdqK25EQmtzZFdqaUk3Q3hEdG9JU1dMN1YxZ0pENWVPTkhLRUQrVnJS?=
 =?utf-8?B?ZVhqV01iSTRET0pTQlBJVEZZMUZObHgxOGlMUkdEakFuclZUc09mR1dnYWhV?=
 =?utf-8?B?Y0VpTVJvZVNyNFh1b2ZqTThCZnFHaE8xTFJ3TUs2M052K2huVVUvd3RUSGhu?=
 =?utf-8?B?SnhlYjM4OCtNU2dDZ0hiV1dmSHd2anZJbnJ5MmNJMVJ3ZG1MWTZoZHYrZ0xz?=
 =?utf-8?B?Rkt1R1dYL2Z0ajZlNU9ZcW1MeXBOTWoxMjZUeUpZUU5VSXJFZC9WMEllUVNO?=
 =?utf-8?B?eG9qY1NoWFdhUUFvMEJNWnZHbTJieExudWs0Y0hhU2dhVkhJQVdNMENPaEEy?=
 =?utf-8?B?eThxOE1IN1M2V0M3RjhVUWFtRzlGK05CNWI5ZGU5b2NtaTMrSmxiWXVnMnVF?=
 =?utf-8?B?aUhhYlJscVRiSllKdjVsZTR2aXRZRXpPMnZNanRNOFpYOHpKTkRWV3B4VzJO?=
 =?utf-8?B?eDRqVFJZL0t1TGpqTWs2cFVidStkSkxYcUlLRk1uVEVDZUlJd0pZYnJveWg4?=
 =?utf-8?B?Ymp2aG5PVmV6eEYrQkMvZ2JvbmUyamFFRURWWDNSNVVhRXNJd0RJWWF5SWlU?=
 =?utf-8?B?TUxJb3pyU1V3Z3d6cXo4Q0RaalhNWmRnb1RFdHd2TFQvaG55N0Q4M0xMUFEz?=
 =?utf-8?B?cGxZNUkvamhHMlpNVVBCTlpJRmN5V3RnY3ByRCtsdVFBU3A1SEo4UDJrZkJh?=
 =?utf-8?B?UkFTcHp6RlhneUNFUVl0QitmSlVhY3hQVUg5Mk5HejhlZS8vZS9VN2NXNnFT?=
 =?utf-8?B?bVEwOFBvQmhtN0w0TkxKTis1RE02TXlWSklhbUtnaEdxMVFNSHJUU2k1UGU4?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <23FDC4D9E37C374192A38A2A089BC2A7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: azHHeG7PkLv2LFbnZVif65qU2k7oYmVG/b6ysqVmfERCryKkWa8J1PH93XSbkR571aSTCiqbZjoSfLNHrAUGcfJCbgPJiF0Z/afNjhqfNlpa06jItA0bfJVMhiPBWq9+3pSwpz8ZhKqWdwvptRBt+qZCV736FlvqGCyTxNj/urcZzLyqZ1YA+e2UzSBL9fRkYM9mIo4GpFhKUlBrHRHRdUYrbUZe3TSGiRDsZLLtr8xM+NUrsk+skX0n6sAXssxjuJyJvM7PNuRzgO/LUZycB+1zLkD7FUgJSupcSGzjyipqa3zmEUSTkpMOhwMTlCwg2grXuoRuEl32nxa3+XW9fGtjRNvcSMp0aMaB/4fnHKtCvmcl5m3jYrntHIBYMqW99lh73MB5vYP1TpFqq6zepd9EmSDarAVznmZ439CxKKdGL8YOsiEnp60vZUrCgMcwNo6J83J0JRSm1K0ONgAe2SoRzCZIneOJNVD25JK7Ea6gFr50IjtRsDos/K0HBMq/Nwy1FgfCCW0SvI6ngaXEhAO8FKKW1N0aVUImVt2Wn5UYirVwrzDzSSkaWCwPLLET4fLjaSptCNHGp132NYy0YMirKhLu3ipWpjSEoHZQTGQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5894.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84bee31-37e0-4bbf-3b2c-08de072fe116
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2025 12:32:15.4030 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQBXfHZct4MBr5IZY1hEmpW8F78zzFDtaGLTcdUlXS4MjEucXjojrYZrkQ2Ipcyp5bTDaITe3X2qb+9VmT1whg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6516
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510090073
X-Proofpoint-ORIG-GUID: KTqAakK427sM50cViE8gSGXlxUJqnYX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXxRodjj3IXqHl
 ygxesIPNJF7ppkyiduCtYaiirQZZ6eCDZ6f9+qCT4/lBg3GSrsJDxSWgTcHf6if3M8idwVjDCff
 ECK4Iv9fjK34myOunF+FGuIi5GmuCWs+mcB5Z5KJEt8vPx6bYBJePK0CXS50bT0wgOGSXjymSGf
 Q8kXcLPjYbSWkRA3HRoxsoBuw+PWqG7D6GQRMBSQcftQ/J1fJREao7w5bSirOEZD+7fnTEr2qe1
 u/nx2Ma01Ah9qm1jjZJ9BwkyJryMK34x1N+oNG83ikIGRIxToyN0PDoBnUOyVTBOFdzfFoSS5sP
 MzsvhepfqX4l8MFlG7+ihCSXNFdGCnU9VzCWMoIev/7GKuoBYKmneAy1sp6UtjOzMhtA2AwuCD1
 dZimFbvY17ifUutF6QQ4ALb1C6pLvqlZHGvxx2zQmRypOPgfBaY=
X-Authority-Analysis: v=2.4 cv=etHSD4pX c=1 sm=1 tr=0 ts=68e7ab54 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=N4eUw1WxAAAA:8 a=i0EeH86SAAAA:8 a=h31ryKHT28s1IHztJ-cA:9 a=QEXdDO2ut3YA:10
 a=TyhWUHtFaNKhBFvZzOnD:22 cc=ntf awl=host:12092
X-Proofpoint-GUID: KTqAakK427sM50cViE8gSGXlxUJqnYX1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=miguel.luis@oracle.com; helo=mx0b-00069f02.pphosted.com
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

SGkgU2FsaWwsDQoNCj4gT24gMSBPY3QgMjAyNSwgYXQgMDE6MDEsIHNhbGlsLm1laHRhQG9wbnNy
Yy5uZXQgd3JvdGU6DQo+IA0KPiBGcm9tOiBTYWxpbCBNZWh0YSA8c2FsaWwubWVodGFAaHVhd2Vp
LmNvbT4NCj4gDQo+IFRvIHN1cHBvcnQgYSB2Q1BVIGhvdC1hZGTigJNsaWtlIG1vZGVsIG9uIEFS
TSwgdGhlIHZpcnQgbWFjaGluZSBtYXkgYmUgc2V0dXAgd2l0aA0KPiBtb3JlIENQVXMgdGhhbiBh
cmUgYWN0aXZlIGF0IGJvb3QuIFRoZXNlIGFkZGl0aW9uYWwgQ1BVcyBhcmUgZnVsbHkgcmVhbGl6
ZWQgaW4NCj4gS1ZNIGFuZCBsaXN0ZWQgaW4gQUNQSSB0YWJsZXMgZnJvbSB0aGUgc3RhcnQsIGJ1
dCBiZWdpbiBpbiBhIGRpc2FibGVkIHN0YXRlLg0KPiBUaGV5IGNhbiBsYXRlciBiZSBicm91Z2h0
IG9ubGluZSBvciB0YWtlbiBvZmZsaW5lIHVuZGVyIGhvc3Qgb3IgcGxhdGZvcm0gcG9saWN5DQo+
IGNvbnRyb2wuIFRoZSBDUFUgdG9wb2xvZ3kgaXMgZml4ZWQgYXQgVk0gY3JlYXRpb24gdGltZSBh
bmQgY2Fubm90IGNoYW5nZQ0KPiBkeW5hbWljYWxseSBvbiBBUk0uIFRoZXJlZm9yZSwgd2UgbXVz
dCBkZXRlcm1pbmUgcHJlY2lzZWx5IHRoZSAnbWF4Y3B1cycgdmFsdWUNCj4gdGhhdCBhcHBsaWVz
IGZvciB0aGUgZnVsbCBsaWZldGltZSBvZiB0aGUgVk0uDQo+IA0KPiBPbiBBUk0sIHRoaXMgZGVm
ZXJyZWQgb25saW5lLWNhcGFibGUgbW9kZWwgaXMgb25seSB2YWxpZCBpZjoNCj4gIC0gVGhlIEdJ
QyB2ZXJzaW9uIGlzIDMgb3IgaGlnaGVyLCBhbmQNCj4gIC0gRWFjaCBub24tYm9vdCBDUFXigJlz
IEdJQyBDUFUgSW50ZXJmYWNlIGlzIG1hcmtlZCDigJxvbmxpbmUtY2FwYWJsZeKAnSBpbiBpdHMN
Cj4gICAgQUNQSSBHSUNDIHN0cnVjdHVyZSAoVUVGSSBBQ1BJIFNwZWNpZmljYXRpb24gNi41LCDC
pzUuMi4xMi4xNCwgVGFibGUgNS4zNw0KPiAgICDigJxHSUNDIENQVSBJbnRlcmZhY2UgRmxhZ3Pi
gJ0pLCBhbmQNCj4gIC0gVGhlIGNob3NlbiBhY2NlbGVyYXRvciBzdXBwb3J0cyBzYWZlIGRlZmVy
cmVkIENQVSBvbmxpbmU6DQo+ICAgICAgKiBUQ0cgd2l0aCBtdWx0aS10aHJlYWRlZCBUQ0cgKE1U
VENHKSBlbmFibGVkDQo+ICAgICAgKiBLVk0gKG9uIHN1cHBvcnRlZCBob3N0cykNCj4gICAgICAq
IE5vdCBIVkYgb3IgUVRlc3QNCj4gDQo+IFRoaXMgcGF0Y2ggc2l6ZXMgdGhlIG1hY2hpbmXigJlz
IG1heC1wb3NzaWJsZSBDUFVzIGR1cmluZyBWTSBpbml0Og0KPiAgLSBJZiBhbGwgY29uZGl0aW9u
cyBhcmUgc2F0aXNmaWVkLCByZXRhaW4gdGhlIGZ1bGwgc2V0IG9mIENQVXMgY29ycmVzcG9uZGlu
Zw0KPiAgICB0byAoYC1zbXAgY3B1c2AgKyBgLXNtcCBkaXNhYmxlZGNwdXNgKSwgYWxsb3dpbmcg
dGhlIGFkZGl0aW9uYWwgKGluaXRpYWxseQ0KPiAgICBkaXNhYmxlZCkgQ1BVcyB0byBwYXJ0aWNp
cGF0ZSBpbiBsYXRlciBwb2xpY3ktZHJpdmVuIG9ubGluZS4NCj4gIC0gT3RoZXJ3aXNlLCBjbGFt
cCB0aGUgbWF4LXBvc3NpYmxlIENQVXMgdG8gdGhlIGJvb3QtZW5hYmxlZCBjb3VudA0KPiAgICAo
YC1zbXAgZGlzYWJsZWRjcHVzPTBgIGVxdWl2YWxlbnQpIHRvIGF2b2lkIGFkdmVydGlzaW5nIENQ
VXMgdGhlIGd1ZXN0IGNhbg0KPiAgICBuZXZlciB1c2UuDQo+IA0KPiBBIG5ldyBNYWNoaW5lQ2xh
c3MgZmxhZywgYGhhc19vbmxpbmVfY2FwYWJsZV9jcHVzYCwgcmVjb3JkcyB3aGV0aGVyIHRoZSBt
YWNoaW5lDQo+IHN1cHBvcnRzIGRlZmVycmVkIHZDUFUgb25saW5lLiBUaGlzIGlzIHVzYWJsZSBi
eSBvdGhlciBtYWNoaW5lIHR5cGVzIGFzIHdlbGwuDQoNCg0KQnkgdGhlIGRlZmluaXRpb24gb2YN
Cg0KICogQGhhc19ob3RwbHVnZ2FibGVfY3B1czoNCiAqICAgIElmIHRydWUsIGJvYXJkIHN1cHBv
cnRzIENQVXMgY3JlYXRpb24gd2l0aCAtZGV2aWNlL2RldmljZV9hZGQuDQoNCiBpbiBpbmNsdWRl
L2h3L2JvYXJkcy5oDQoNCnNlZW1zIG9uZSBjb3VsZCB0YWtlIGFkdmFudGFnZSBvZiBNYWNoaW5l
Q2xhc3MncyBoYXNfaG90cGx1Z2dhYmxlX2NwdXMgdmFyaWFibGUNCmluc3RlYWQgb2YgY3JlYXRp
bmcgYSBuZXcgaGFzX29ubGluZV9jYXBhYmxlX2NwdXMgb25lLg0KKEFnYWluLCBJTUhPIOKAmG9u
bGluZSBjYXBhYmxl4oCZIGlzIEFDUEkgbm9tZW5jbGF0dXJlIGFuZCBkb2VzbuKAmXQgbmVlZCB0
byBiZSBicm91Z2h0DQppbiBNYWNoaW5lQ2xhc3PigJlzKQ0KDQpWYXJpYWJsZSB3aGljaCB3b3Vs
ZCBiZSBpbml0aWFsaXplZCBpbiBtYWNodmlydF9pbml0IG9uIGFuIGFzc2lnbm1lbnQgYmFzZWQg
b24NCkdJQyB2ZXJzaW9uIGFuZC9vciB3ZXRoZXIgdGhlcmUncyBpbmFjdGl2ZSBDUFVzIGFuZCBw
cm9jZWVkIGZyb20gdGhlcmUgYW55d2F5cywNCm1ha2luZyB0aGUgZGVmYXVsdCBhc3NpZ25tZW50
IGluIG1hY2hpbmVfdmlydF9jbGFzc19pbml0IHN1cGVyZmx1b3VzLg0KDQpXZSdyZSBhdCBody9h
cm0vdmlydCBhbmQgd2Uga25vdyB0aGVzZSBDUFVzIGFyZSBhZG1pbmlzdHJhdGl2ZWx5IHBvd2Vy
IHN0YXRlDQpjb29yZGluYXRlZCBzbyBhZG1pbl9wb3dlcl9zdGF0ZV9zdXBwb3J0ZWQgY2FuIHN0
aWxsIGJlIHNldCB0aGVyZSBpbiB0aGUNCnByZXNlbmNlIG9mIGluYWN0aXZlIENQVXMuDQoNClRo
YW5rcw0KTWlndWVsDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNhbGlsIE1laHRhIDxzYWxpbC5t
ZWh0YUBodWF3ZWkuY29tPg0KPiAtLS0NCj4gaHcvYXJtL3ZpcnQuYyAgICAgICB8IDg0ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLQ0KPiBpbmNsdWRlL2h3L2Jv
YXJkcy5oIHwgIDEgKw0KPiAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDI4IGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2FybS92aXJ0LmMgYi9ody9hcm0vdmly
dC5jDQo+IGluZGV4IGVmNmJlMzY2MGYuLjc2ZjIxYmQ1NmEgMTAwNjQ0DQo+IC0tLSBhL2h3L2Fy
bS92aXJ0LmMNCj4gKysrIGIvaHcvYXJtL3ZpcnQuYw0KPiBAQCAtMjE2OCw4ICsyMTY4LDcgQEAg
c3RhdGljIHZvaWQgbWFjaHZpcnRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ICAgICBi
b29sIGhhc19nZWQgPSAhdm1jLT5ub19nZWQ7DQo+ICAgICB1bnNpZ25lZCBpbnQgc21wX2NwdXMg
PSBtYWNoaW5lLT5zbXAuY3B1czsNCj4gICAgIHVuc2lnbmVkIGludCBtYXhfY3B1cyA9IG1hY2hp
bmUtPnNtcC5tYXhfY3B1czsNCj4gLQ0KPiAtICAgIHBvc3NpYmxlX2NwdXMgPSBtYy0+cG9zc2li
bGVfY3B1X2FyY2hfaWRzKG1hY2hpbmUpOw0KPiArICAgIERldmljZUNsYXNzICpkYzsNCj4gDQo+
ICAgICAvKg0KPiAgICAgICogSW4gYWNjZWxlcmF0ZWQgbW9kZSwgdGhlIG1lbW9yeSBtYXAgaXMg
Y29tcHV0ZWQgZWFybGllciBpbiBrdm1fdHlwZSgpDQo+IEBAIC0yMTg2LDcgKzIxODUsNyBAQCBz
dGF0aWMgdm9pZCBtYWNodmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4gICAgICAg
ICAgKiB3ZSBhcmUgYWJvdXQgdG8gZGVhbCB3aXRoLiBPbmNlIHRoaXMgaXMgZG9uZSwgZ2V0IHJp
ZCBvZg0KPiAgICAgICAgICAqIHRoZSBvYmplY3QuDQo+ICAgICAgICAgICovDQo+IC0gICAgICAg
IGNwdW9iaiA9IG9iamVjdF9uZXcocG9zc2libGVfY3B1cy0+Y3B1c1swXS50eXBlKTsNCj4gKyAg
ICAgICAgY3B1b2JqID0gb2JqZWN0X25ldyhtYWNoaW5lLT5jcHVfdHlwZSk7DQo+ICAgICAgICAg
YXJtY3B1ID0gQVJNX0NQVShjcHVvYmopOw0KPiANCj4gICAgICAgICBwYV9iaXRzID0gYXJtX3Bh
bWF4KGFybWNwdSk7DQo+IEBAIC0yMjAxLDYgKzIyMDAsNTcgQEAgc3RhdGljIHZvaWQgbWFjaHZp
cnRfaW5pdChNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+ICAgICAgKi8NCj4gICAgIGZpbmFsaXpl
X2dpY192ZXJzaW9uKHZtcyk7DQo+IA0KPiArICAgIC8qDQo+ICsgICAgICogVGhlIG1heGltdW0g
bnVtYmVyIG9mIENQVXMgZGVwZW5kcyBvbiB0aGUgR0lDIHZlcnNpb24sIG9yIG9uIGhvdw0KPiAr
ICAgICAqIG1hbnkgcmVkaXN0cmlidXRvcnMgd2UgY2FuIGZpdCBpbnRvIHRoZSBtZW1vcnkgbWFw
ICh3aGljaCBpbiB0dXJuDQo+ICsgICAgICogZGVwZW5kcyBvbiB3aGV0aGVyIHRoaXMgaXMgYSBH
SUN2MyBvciB2NCkuDQo+ICsgICAgICovDQo+ICsgICAgaWYgKHZtcy0+Z2ljX3ZlcnNpb24gPT0g
VklSVF9HSUNfVkVSU0lPTl8yKSB7DQo+ICsgICAgICAgIHZpcnRfbWF4X2NwdXMgPSBHSUNfTkNQ
VTsNCj4gKyAgICB9IGVsc2Ugew0KPiArICAgICAgICB2aXJ0X21heF9jcHVzID0gdmlydF9yZWRp
c3RfY2FwYWNpdHkodm1zLCBWSVJUX0dJQ19SRURJU1QpOw0KPiArICAgICAgICBpZiAodm1zLT5o
aWdobWVtX3JlZGlzdHMpIHsNCj4gKyAgICAgICAgICAgIHZpcnRfbWF4X2NwdXMgKz0gdmlydF9y
ZWRpc3RfY2FwYWNpdHkodm1zLCBWSVJUX0hJR0hfR0lDX1JFRElTVDIpOw0KPiArICAgICAgICB9
DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgaWYgKCh0Y2dfZW5hYmxlZCgpICYmICFxZW11X3RjZ19t
dHRjZ19lbmFibGVkKCkpIHx8IGh2Zl9lbmFibGVkKCkgfHwNCj4gKyAgICAgICAgcXRlc3RfZW5h
YmxlZCgpIHx8IHZtcy0+Z2ljX3ZlcnNpb24gPT0gVklSVF9HSUNfVkVSU0lPTl8yKSB7DQo+ICsg
ICAgICAgIG1heF9jcHVzID0gbWFjaGluZS0+c21wLm1heF9jcHVzID0gc21wX2NwdXM7DQo+ICsg
ICAgICAgIGlmIChtYy0+aGFzX29ubGluZV9jYXBhYmxlX2NwdXMpIHsNCj4gKyAgICAgICAgICAg
IGlmICh2bXMtPmdpY192ZXJzaW9uID09IFZJUlRfR0lDX1ZFUlNJT05fMikgew0KPiArICAgICAg
ICAgICAgICAgIHdhcm5fcmVwb3J0KCJHSUN2MiBkb2VzIG5vdCBzdXBwb3J0IG9ubGluZS1jYXBh
YmxlIENQVXMiKTsNCj4gKyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgIG1jLT5oYXNfb25s
aW5lX2NhcGFibGVfY3B1cyA9IGZhbHNlOw0KPiArICAgICAgICB9DQo+ICsgICAgfQ0KPiArDQo+
ICsgICAgaWYgKG1jLT5oYXNfb25saW5lX2NhcGFibGVfY3B1cykgew0KPiArICAgICAgICBtYXhf
Y3B1cyA9IHNtcF9jcHVzICsgbWFjaGluZS0+c21wLmRpc2FibGVkY3B1czsNCj4gKyAgICAgICAg
bWFjaGluZS0+c21wLm1heF9jcHVzID0gbWF4X2NwdXM7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAg
aWYgKG1heF9jcHVzID4gdmlydF9tYXhfY3B1cykgew0KPiArICAgICAgICBlcnJvcl9yZXBvcnQo
Ik51bWJlciBvZiBTTVAgQ1BVcyByZXF1ZXN0ZWQgKCVkKSBleGNlZWRzIG1heCBDUFVzICINCj4g
KyAgICAgICAgICAgICAgICAgICAgICJzdXBwb3J0ZWQgYnkgbWFjaGluZSAnbWFjaC12aXJ0JyAo
JWQpIiwNCj4gKyAgICAgICAgICAgICAgICAgICAgIG1heF9jcHVzLCB2aXJ0X21heF9jcHVzKTsN
Cj4gKyAgICAgICAgaWYgKHZtcy0+Z2ljX3ZlcnNpb24gIT0gVklSVF9HSUNfVkVSU0lPTl8yICYm
ICF2bXMtPmhpZ2htZW1fcmVkaXN0cykgew0KPiArICAgICAgICAgICAgZXJyb3JfcHJpbnRmKCJU
cnkgJ2hpZ2htZW0tcmVkaXN0cz1vbicgZm9yIG1vcmUgQ1BVc1xuIik7DQo+ICsgICAgICAgIH0N
Cj4gKw0KPiArICAgICAgICBleGl0KDEpOw0KPiArICAgIH0NCj4gKw0KPiArICAgIGRjID0gREVW
SUNFX0NMQVNTKG9iamVjdF9jbGFzc19ieV9uYW1lKG1hY2hpbmUtPmNwdV90eXBlKSk7DQo+ICsg
ICAgaWYgKCFkYykgew0KPiArICAgICAgICBlcnJvcl9yZXBvcnQoIkNQVSB0eXBlICclcycgbm90
IHJlZ2lzdGVyZWQiLCBtYWNoaW5lLT5jcHVfdHlwZSk7DQo+ICsgICAgICAgIGV4aXQoMSk7DQo+
ICsgICAgfQ0KPiArICAgIGRjLT5hZG1pbl9wb3dlcl9zdGF0ZV9zdXBwb3J0ZWQgPSBtYy0+aGFz
X29ubGluZV9jYXBhYmxlX2NwdXM7DQo+ICsNCj4gKyAgICAvKiB1c2VzIHNtcC5tYXhfY3B1cyB0
byBpbml0aWFsaXplIGFsbCBwb3NzaWJsZSB2Q1BVcyAqLw0KPiArICAgIHBvc3NpYmxlX2NwdXMg
PSBtYy0+cG9zc2libGVfY3B1X2FyY2hfaWRzKG1hY2hpbmUpOw0KPiArDQo+ICAgICBpZiAodm1z
LT5zZWN1cmUpIHsNCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIFRoZSBTZWN1cmUgdmlldyBv
ZiB0aGUgd29ybGQgaXMgdGhlIHNhbWUgYXMgdGhlIE5vblNlY3VyZSwNCj4gQEAgLTIyMzUsMzEg
KzIyODUsNiBAQCBzdGF0aWMgdm9pZCBtYWNodmlydF9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGlu
ZSkNCj4gICAgICAgICB2bXMtPnBzY2lfY29uZHVpdCA9IFFFTVVfUFNDSV9DT05EVUlUX0hWQzsN
Cj4gICAgIH0NCj4gDQo+IC0gICAgLyoNCj4gLSAgICAgKiBUaGUgbWF4aW11bSBudW1iZXIgb2Yg
Q1BVcyBkZXBlbmRzIG9uIHRoZSBHSUMgdmVyc2lvbiwgb3Igb24gaG93DQo+IC0gICAgICogbWFu
eSByZWRpc3RyaWJ1dG9ycyB3ZSBjYW4gZml0IGludG8gdGhlIG1lbW9yeSBtYXAgKHdoaWNoIGlu
IHR1cm4NCj4gLSAgICAgKiBkZXBlbmRzIG9uIHdoZXRoZXIgdGhpcyBpcyBhIEdJQ3YzIG9yIHY0
KS4NCj4gLSAgICAgKi8NCj4gLSAgICBpZiAodm1zLT5naWNfdmVyc2lvbiA9PSBWSVJUX0dJQ19W
RVJTSU9OXzIpIHsNCj4gLSAgICAgICAgdmlydF9tYXhfY3B1cyA9IEdJQ19OQ1BVOw0KPiAtICAg
IH0gZWxzZSB7DQo+IC0gICAgICAgIHZpcnRfbWF4X2NwdXMgPSB2aXJ0X3JlZGlzdF9jYXBhY2l0
eSh2bXMsIFZJUlRfR0lDX1JFRElTVCk7DQo+IC0gICAgICAgIGlmICh2bXMtPmhpZ2htZW1fcmVk
aXN0cykgew0KPiAtICAgICAgICAgICAgdmlydF9tYXhfY3B1cyArPSB2aXJ0X3JlZGlzdF9jYXBh
Y2l0eSh2bXMsIFZJUlRfSElHSF9HSUNfUkVESVNUMik7DQo+IC0gICAgICAgIH0NCj4gLSAgICB9
DQo+IC0NCj4gLSAgICBpZiAobWF4X2NwdXMgPiB2aXJ0X21heF9jcHVzKSB7DQo+IC0gICAgICAg
IGVycm9yX3JlcG9ydCgiTnVtYmVyIG9mIFNNUCBDUFVzIHJlcXVlc3RlZCAoJWQpIGV4Y2VlZHMg
bWF4IENQVXMgIg0KPiAtICAgICAgICAgICAgICAgICAgICAgInN1cHBvcnRlZCBieSBtYWNoaW5l
ICdtYWNoLXZpcnQnICglZCkiLA0KPiAtICAgICAgICAgICAgICAgICAgICAgbWF4X2NwdXMsIHZp
cnRfbWF4X2NwdXMpOw0KPiAtICAgICAgICBpZiAodm1zLT5naWNfdmVyc2lvbiAhPSBWSVJUX0dJ
Q19WRVJTSU9OXzIgJiYgIXZtcy0+aGlnaG1lbV9yZWRpc3RzKSB7DQo+IC0gICAgICAgICAgICBl
cnJvcl9wcmludGYoIlRyeSAnaGlnaG1lbS1yZWRpc3RzPW9uJyBmb3IgbW9yZSBDUFVzXG4iKTsN
Cj4gLSAgICAgICAgfQ0KPiAtDQo+IC0gICAgICAgIGV4aXQoMSk7DQo+IC0gICAgfQ0KPiAtDQo+
ICAgICBpZiAodm1zLT5zZWN1cmUgJiYgIXRjZ19lbmFibGVkKCkgJiYgIXF0ZXN0X2VuYWJsZWQo
KSkgew0KPiAgICAgICAgIGVycm9yX3JlcG9ydCgibWFjaC12aXJ0OiAlcyBkb2VzIG5vdCBzdXBw
b3J0IHByb3ZpZGluZyAiDQo+ICAgICAgICAgICAgICAgICAgICAgICJTZWN1cml0eSBleHRlbnNp
b25zIChUcnVzdFpvbmUpIHRvIHRoZSBndWVzdCBDUFUiLA0KPiBAQCAtMzI0NSw2ICszMjcwLDkg
QEAgc3RhdGljIHZvaWQgdmlydF9tYWNoaW5lX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBj
b25zdCB2b2lkICpkYXRhKQ0KPiAgICAgaGMtPnBsdWcgPSB2aXJ0X21hY2hpbmVfZGV2aWNlX3Bs
dWdfY2I7DQo+ICAgICBoYy0+dW5wbHVnX3JlcXVlc3QgPSB2aXJ0X21hY2hpbmVfZGV2aWNlX3Vu
cGx1Z19yZXF1ZXN0X2NiOw0KPiAgICAgaGMtPnVucGx1ZyA9IHZpcnRfbWFjaGluZV9kZXZpY2Vf
dW5wbHVnX2NiOw0KPiArDQo+ICsgICAgbWMtPmhhc19vbmxpbmVfY2FwYWJsZV9jcHVzID0gdHJ1
ZTsNCj4gKw0KPiAgICAgbWMtPm52ZGltbV9zdXBwb3J0ZWQgPSB0cnVlOw0KPiAgICAgbWMtPnNt
cF9wcm9wcy5jbHVzdGVyc19zdXBwb3J0ZWQgPSB0cnVlOw0KPiAgICAgbWMtPmF1dG9fZW5hYmxl
X251bWFfd2l0aF9tZW1ocCA9IHRydWU7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2JvYXJk
cy5oIGIvaW5jbHVkZS9ody9ib2FyZHMuaA0KPiBpbmRleCAyYjE4MmQ3ODE3Li5iMjdjMjMyNmEy
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L2JvYXJkcy5oDQo+ICsrKyBiL2luY2x1ZGUvaHcv
Ym9hcmRzLmgNCj4gQEAgLTMwMiw2ICszMDIsNyBAQCBzdHJ1Y3QgTWFjaGluZUNsYXNzIHsNCj4g
ICAgIGJvb2wgcm9tX2ZpbGVfaGFzX21yOw0KPiAgICAgaW50IG1pbmltdW1fcGFnZV9iaXRzOw0K
PiAgICAgYm9vbCBoYXNfaG90cGx1Z2dhYmxlX2NwdXM7DQo+ICsgICAgYm9vbCBoYXNfb25saW5l
X2NhcGFibGVfY3B1czsNCj4gICAgIGJvb2wgaWdub3JlX21lbW9yeV90cmFuc2FjdGlvbl9mYWls
dXJlczsNCj4gICAgIGludCBudW1hX21lbV9hbGlnbl9zaGlmdDsNCj4gICAgIGNvbnN0IGNoYXIg
KiBjb25zdCAqdmFsaWRfY3B1X3R5cGVzOw0KPiAtLSANCj4gMi4zNC4xDQo+IA0KDQo=

