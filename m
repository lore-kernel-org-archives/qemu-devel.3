Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2D6D1D47D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vds6E-0007a2-RK; Thu, 08 Jan 2026 10:38:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vds6A-0007ZB-N5; Thu, 08 Jan 2026 10:38:55 -0500
Received: from mail-norwayeastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20f::7] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vds67-0001xM-TX; Thu, 08 Jan 2026 10:38:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=osh5yZV0BuM8bUrjUos3YDvuSIeSUPjCaew61HAdry+O90uLv+zVZu5jhYxYdXOvNMaEWsDqgR99bKD0F3Zi/7XrePZLSXATiWK0lctd0JnU8DvM8F274/hIblwwfEHEMBYS81B0OojPMHXYp9zbzXVLl/1iXolrLjnMBKiSQaQhkYZEzs/VV6Q58QFI1vbxPlwjbUkDeSvJXpJWanndH04o2cydWAzRDvxd/gGfxCIiizKSf0hFDVHdHFFcHR3GpsdaG4IJRXU2B+M2MeFBIeP0zEb6w2QAyaMVtJ1PB0RvDinhPdCjQsEB1kPrZbY0h43l8w24HA8ezWG1+ZnkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zq2LcgWTIsOMTdLN2HPywNr+L30jGQ5exUYvq7VG0w=;
 b=rcu4Aa/zEsXGW8NfgsFxGOrKxV6MAZ65SANv8Qz5ZpXGjiRReTgg6ydfXRTZOLJEMrJRkRYEe3e5JM9ISAgQhL7zytpJLutAfuuIjPmQ3Nt7+JO3yiSwNkMdCiWvaMdpcQtrtOXk51jIGkaClOs3S3Fmk9M2UKLjlWXgfFrpYSVcSN4O/PoAdN0CLWDlGMPMV0U0gZaE5jw1ZPjAVuqN93BuMQkLefwNjs5Lh2U/qsq3be/bCt15FBwxoiNnCkXG2ZE+rrV0CQS5VegAGnH3l8UL6xGpg+9nPBSnZRfGRZbo92dA/TS5IZO8V0U+aaKWFTBI44jmQniwWkcV8GMaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zq2LcgWTIsOMTdLN2HPywNr+L30jGQ5exUYvq7VG0w=;
 b=MqKmhFjItoH/fiuYh/QtboHM9MbxXjW+kfjjGDHJQPKwxViJmJ6PsjQSTociM1PfyFca/mRLFJKk03oado5/3n66k4AKqk/XocUBwXhDiEv59EjlqADnmt04Wlcl+Y2vs9foN/rUL8fxd1jtV6aYeg4Ydu53YID6KGk1s0HuXLxO0a8xpnsOPBUMcdrZ3rZcE5+gnLHf7fIUaIi9QQnNegIeIi7yuRUtVQUF3OVS9Xiab2r+EvXSli/q3zH67tQCZyYO+dnO3inYDQeeY4/lnFTfFsyLVusK51zv8lqay2YecyYOHKyDcfvnQGZ5FcfkQEXJdsdFwwTWXHWRjjBomQ==
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com (2603:10a6:10:ab::30)
 by DB9PR09MB6505.eurprd09.prod.outlook.com (2603:10a6:10:302::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Thu, 8 Jan
 2026 15:38:47 +0000
Received: from DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe]) by DB8PR09MB2796.eurprd09.prod.outlook.com
 ([fe80::e42:9fbc:3e58:febe%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 15:38:47 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>, "thuth@redhat.com"
 <thuth@redhat.com>
Subject: Re: [PATCH v16 00/12] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v16 00/12] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHcgKSCrpWk4nPqwEqijMInKbuZHLVIZoiAgAAB7wA=
Date: Thu, 8 Jan 2026 15:38:47 +0000
Message-ID: <4aae0504-fd27-450d-8b01-0ad9a052bc39@htecgroup.com>
References: <20260108134128.2218102-1-djordje.todorovic@htecgroup.com>
 <7515c883-1e0f-4a23-b65c-e63067737aea@linaro.org>
In-Reply-To: <7515c883-1e0f-4a23-b65c-e63067737aea@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR09MB2796:EE_|DB9PR09MB6505:EE_
x-ms-office365-filtering-correlation-id: 16b9fbb8-43af-426f-1058-08de4ecc0379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d0RvbDhHamVzOENsTmFyUGVnTWxXRUs2RkwxbTJpVzltVkNTbW5OTjcrTDI3?=
 =?utf-8?B?RDgzWk1LdHpXYkRmUUJMelZHVjkzZGxMaHpwN3RjeWc4MktrWlVPWlloRkd3?=
 =?utf-8?B?RTlMUU9NNzN0dDMzL3hIZXhNNE5wNEpQYVdiTms2SThtRjRLMC95bGJ6REsx?=
 =?utf-8?B?aXlVUmpQWHJZS1ZkS1NWK2swODQvZnFMNWFoZ0NUMEpkTkJ2VVZJcnhydVMw?=
 =?utf-8?B?S0tiTGp5TU9EdmplTk9EUkZPcHFnYnBkQVNrL0xLTVJQWHFKZTBQVTkzNUVu?=
 =?utf-8?B?REF1bUpPYTJQWjZHL0VxbUNaT2NVOXlNZ1BBdEZGb210b240K21VdnVqTWta?=
 =?utf-8?B?dENPQ0N3WjArNE5HaVJ4WEF2eXRTWmpPdkFYcFFXY2ZNY0J2VURjSGRoWldw?=
 =?utf-8?B?YnhWSnlmdDJ6ZHFZQ1JVYk0xL3JDWWlrUGxVa09iUEFad0lzYnRxQ0d4aTJq?=
 =?utf-8?B?Tmw3emw4aUFJZ2pPOFJ5ZG5IVzk1ZVdudS9JQjUyMGxGMFZERVdEbUJxaHl5?=
 =?utf-8?B?NHZFYjJQU0ZhdzhLb2pNaFpFa2M2cjdFL2RyR0pqVEVHWkhyV0F3am5SL2tI?=
 =?utf-8?B?NEJEWGcvMFcybUxUOGdKcHdzNytYaGRVVWIrUFZCL0FyUm1ubDgwWC9BaXE4?=
 =?utf-8?B?KzE1aWt4bStTeDIvZDA3cE9WWVZTdzRyUUtxUWtSdVFZZ3l4RHp2djUrWkxN?=
 =?utf-8?B?TEN5MlV1T0NQdUxxVzJlRGp6L0pZa1BjL1MvckZsUldDd0IyYUh0SDUwb2Zk?=
 =?utf-8?B?WHhaMzJRZmVYRkNuZnVuNkpYcVBNT3BYOWF1cmp5RWJSQ0ZPNE1CME1TTmNE?=
 =?utf-8?B?b0E5UUpGS0E3OFBmcmhUUE40ZXBUZFRpZnJnd3pRcXpOZEFGYTQ1M1hqUTJF?=
 =?utf-8?B?TTNtdkJWM0dXK05xd2JyQzRMdmx6V0QwbVNrZU8rZjdhYTYwUkFId0xBUjZE?=
 =?utf-8?B?NWxtTEVPaU5SQ3VJRzRoSUFhZUF0bThpSEc0bjFnbll0RVN1MVA0cTV2b1VK?=
 =?utf-8?B?eHo5TTFvcytBbEtXNDVMeHVieWhVWkE4b3R2TGZ5SlQvN2ZiQnJEWWk4eWZB?=
 =?utf-8?B?aTR4QlhTb0o0dWlKRkJMUFV0OEMzamZBbjIwQ1BSTzgxak5JRHNMd2xUempz?=
 =?utf-8?B?N0VpczhsNDV2NGY1ZEQ0THZRVnZwUmF2L1M4ckw0VnY1RXFuMkdQb2p4RWIv?=
 =?utf-8?B?bnhQa2hKN3VLbWljMzEvUGFjQlkyK0xkQzBhUU9LNFpaQUJzZ1hsQzArY3NB?=
 =?utf-8?B?N1NNZ05Ia1NnSU9XcXg2WjZVUGhoZzlQYk13MVZiV1hwR3pnR0t4bUx4Tnd5?=
 =?utf-8?B?TWVjT3Zwb1FBMlFuc1BrM2xFbytIYVhiUklTR1dDL3dWU3A2bkxab2xwZ21n?=
 =?utf-8?B?WDRZcEU5QWovN1dSQnNPczRLNW9FSlh4dHRUb2ZweHJmcEh4YkJYS1g4RVY0?=
 =?utf-8?B?azAzZE82YzBaUUt1and1WGJRTm94RU5KeGZPYWFSbWwxbzZPRVNHTTFHRGN0?=
 =?utf-8?B?c3I5a3A5S3ZSWnVta0xZMXp2TGZkdWdzclYyT0o1ZW83RDNQWU4zNExweXFB?=
 =?utf-8?B?UUdHRDlha0RFOWhIeFgrNFZyZk9OTnViMXB2empWclJ3M1lxNUNGdEsrSFdu?=
 =?utf-8?B?WkYzb09yRmo4M284VCtabUpCMHdGNTVWV1FRTW9lekZCOFBSQ1ZnR3k5d2s1?=
 =?utf-8?B?NlAyVHFJS2pkSy85UnNyVHBmdkpJczJHRDVqVWlaaW9Qb2VlV1Mwamg1a0h5?=
 =?utf-8?B?R2J3NzJkOUlNQSs1RG5vbG9xU2lpdEwyeDFVUWlGKzNHYTkyUGxSbUhiVjFs?=
 =?utf-8?B?bk14RjR1SU9acFZzMVZUSmM2U2djd21oOVFmR2EzNnBtSWVlSEVqRnRBdW1y?=
 =?utf-8?B?WVMxV09lbmxsaFRSamlOWGVQQlpMdGE0a1YwY0R3OEt6RkM4UjJwK3FsS1ZT?=
 =?utf-8?B?alhzRE9HY0dtaXk5ZUNxelJna2NLbkhVVkttS09NbVVqaEhtaXVsSG5LVlF6?=
 =?utf-8?B?VEhJOUpUM3A4SnpIQTB3cWxNbDlUVlhjUU03QjBicW1VRFRYK1VnaEhHYk1P?=
 =?utf-8?Q?Vs7GCw?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR09MB2796.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ynhod0lnZG5DdmVia0dvVWRQVW84NER0Rjc1NXRoaG8vU29CbVA0WTdUTGUr?=
 =?utf-8?B?eFZZOWExUU9NejBMVUZNRWNKQkp6bjBnOEN1a3VmOUxqdG5FOTVFU2xTMkU1?=
 =?utf-8?B?VlF5cEhPMXBnR0xlWDZSTzUycHhrdVhEalFnZ0NtdEcrbVZwdUhDSHBNb2tp?=
 =?utf-8?B?WHJWQVlIc0dwaVF0eTB1SURISVNHOGRVVk5scHUrb1JyWjV2YllXdjNObU1r?=
 =?utf-8?B?ck8zMW1NYWp4akU5cWN1QXhNQTloTDdwWWx1YUJyOVBFRm1WTnRSKy9yR1Zj?=
 =?utf-8?B?MjFhVjFqbU43ejNENXAwYzRUbHZFRk1xYXkvVFd4MVZKQzJsV21jSGFPc1Nz?=
 =?utf-8?B?aitiWFo1eWozYVd4VFZHdEtRRjF1QTZHc3RSOVBRZnFxK3c3Tzl3L0d1Zksr?=
 =?utf-8?B?NFRucnk0TFhQcGxtR1dTUEMyRS9EclR4eEtpSkJ0L3lqWkpDNHE1K1BNY0xi?=
 =?utf-8?B?UEFjQlU4aUs2dGtscVFpejIzc2V3RFVUYjZ4bzBMSmlNdFVaNlFkaEVoeEpN?=
 =?utf-8?B?RVJycXYzQ1VQbjZDZm5xUHg0N1BIcVZzQVVJVGx3Mm1yZmpnQ1ROc2Qrc2lV?=
 =?utf-8?B?TWFQa0lYbU0rMmlWdUtzVDJ0N2MzWTRvbkJnSGFoS0wwbUlYZ3FwMWVadWpE?=
 =?utf-8?B?T2x2ZmtaNDZ5WFlyUnB1TFhTZkhXRmM5bHFwVWN4OGswcVVoNmh0Wnl4ZHdO?=
 =?utf-8?B?MFoyL2pGaTV2anRxRnJmWWlQemd4V2RmTXhkbWJtYjVwQndLZXBxL2ZQQ1Ny?=
 =?utf-8?B?d0lSekdjNGtTclpSYXdsT1krTVc5Ujg1MlZYTEJVVWppazBBRE9wdzNrcDBm?=
 =?utf-8?B?aW1wWGFjSWRmWkV1SDNEYjhmNm44bnZrcnJyUmJ0eHVpZk9FMGIzOWZXZG9P?=
 =?utf-8?B?RUxEcTJVTjJiTFVDQmhGZjZxWjdORlVyWXNpMG9zU3NJOEdqZVpYbTFLb1o5?=
 =?utf-8?B?L1ZORTBsb3F5UVdaQjdVcFcrbmdBUENzYlRmempvZlhKbVFWTHk3RjNFb0w3?=
 =?utf-8?B?UXZYa3lqOTdtakZtdFZDK2I1dzVUV0poaTBoem55Qlh6UkplRVpvcHNWSzBT?=
 =?utf-8?B?M3RPRElqTk0xb0RhS1grS2JQZ1NNMmZUQ055ZWtpQ2drOGtpVjBSMW50RTk1?=
 =?utf-8?B?UFhGeDFXb2ZzS1o1TDE0aEU5NGtvSUhocUU2Nko1YlptRUlaMER4cHpIWmNY?=
 =?utf-8?B?SDlPTUxWc2FyUi9LYzI4Yk5qcGU0cHI3Q0dWY0xzNXJaRndQYzJrS242c3pn?=
 =?utf-8?B?NjVtdzF2aXZ4eXJQakdvdWFPZzVmdXJMQXh5UWM3b2ljRitaU1dxaG4wMjlt?=
 =?utf-8?B?emo3SHVXQTRvb0ZrYUd1a043aXZsV3R4clpnSjBjb05lTmJ6eUI3cEU4cDFV?=
 =?utf-8?B?ZCtKcGkzRFF4Mjk0MEp1U3pWRUR2VUpUMXEvL3RIckNIYisxb0VQZ0JnVTZJ?=
 =?utf-8?B?ZHk5cmExM1N1eWdCVE5sT0hzZWpVYW1BbVhzVW1TNXRybHorZUxFd0ZsRGtD?=
 =?utf-8?B?dm5EUlNPZktVRWNFOWpVLzVFQlY1bmszbTZtd0NpNm5KYVc3dTloVzUycVM1?=
 =?utf-8?B?TFBsbXNMRElXbktSTFN0M1pnU1I2YUEzTyt1b3dBTG5iNVZHMnlkdExDbTI2?=
 =?utf-8?B?TGRJOG4rQW1ZeEpnamRScU01cmp1UjRkVlUrUGh4K0NVNU5PQ3JCMEZOeFZ3?=
 =?utf-8?B?aGRFL0VIRDFlUzhoUlZLRjZ5U3d5NkRJUGxadkNEc2FlYmlHeGF5L2FWWCtS?=
 =?utf-8?B?cHl5SUFSUWV6aFYzUktzM2lrQS8rNThDUE9LbmRtbzdub2xHMXdtdGh1d01D?=
 =?utf-8?B?a00vMXN1UzE1cmdKQXJsWXVkc1diNDNsUFVtckRoV3lVcGRGMHZiTjVRandw?=
 =?utf-8?B?Sk9rYy9SSUFTNThFaThzOVFWd0d3ejhIUSttRmlrMTlCWU5GVW80dnJJcnd1?=
 =?utf-8?B?cVdYTEQ4NHUzaVF5cmFOYkZoOTRYUjg5NFprUm51ejNvTGp1R0gyeFpHMEJO?=
 =?utf-8?B?Qmc5QWNIY3VTeFVtcC9SSlJiamx1b3V5STUvd1M4STVnNmR2NGpLQkF5bzVi?=
 =?utf-8?B?eThCbHd0SEVYT0k4OWRCeGV2cW5HcFdXVEQ3VlNEdkpCQUlFV0E0MmZkRkU3?=
 =?utf-8?B?aTdETFY2dWpMNDNSUFN3SHdVVWk3UDZremJLZXd3QmZ5RlNYbGdLY3VaUGZK?=
 =?utf-8?B?S1VUOGtIWE56Q0VTdnlxQlFpekpvek9vMTFkd0lKeHVBM2xnT2J4cHRneFRK?=
 =?utf-8?B?c2lXdWxUSXVVZ2kyaWJlOGxDSU41OVFmME1xWDJVNGxJeUF2NS9FOUU0RG1O?=
 =?utf-8?B?QWRKQTF1MDdCOU5Jb0FmSHNhaGNNQlNUOXlFL1R3MUlBNEU1MlkyUHlOc3pq?=
 =?utf-8?Q?NRZf6E/Obkng4O2Rry0ZigzF3EHIYbnXM5YBW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B51E2735D69424B99D9736FF19F7C04@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR09MB2796.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16b9fbb8-43af-426f-1058-08de4ecc0379
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 15:38:47.1137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U5sXNFQvj/hSFQlb4137Aq77Iv6M1XePmM6qohPPYr1aajisQgFRNJ7shHM09SYqzLE9Bzb7WauQy0hf8ata4KbgogufLIF86Jo6BHv++Yo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR09MB6505
Received-SPF: pass client-ip=2a01:111:f403:c20f::7;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQpPbiA4LiAxLiAyNi4gMTY6MzEsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBD
QVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6
YXRpb24uIERvIA0KPiBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IHJlY29nbml6ZSB0aGUgc2VuZGVyIA0KPiBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZl
Lg0KPg0KPg0KPiBPbiA4LzEvMjYgMTQ6NDEsIERqb3JkamUgVG9kb3JvdmljIHdyb3RlOg0KPj4g
UmViYXNlZCBhZ2FpbiBvbiB0b3Agb2YgdmVyeSBsYXRlc3QgbWFzdGVyIGJyYW5jaCBieSByZXNv
bHZpbmcNCj4+IGJ1aWxkIGlzc3VlcyBvY2N1cmVkIGR1ZSB0byB0aGUgY2hhbmdlcyBpbiB0aGUg
Y29kZSBvcmdhbml6YXRpb24uDQo+DQo+IEknbSBzb3JyeSBmb3IgdGhlIHVuZm9ydHVuYXRlIHdv
cmtmbG93IHBhaW4geW91IGhhZCB3aXRoIHRoaXMgc2VyaWVzIDooDQo+DQpObyBwcm9ibGVtLiA6
KSBJdCBpcyBwYXJ0IG9mIGpvdXJuZXkuIDopDQoNCj4+IERqb3JkamUgVG9kb3JvdmljICgxMik6
DQo+PiDCoMKgIHRhcmdldC9yaXNjdjogQWRkIGNwdV9zZXRfZXhjZXB0aW9uX2Jhc2UNCj4+IMKg
wqAgdGFyZ2V0L3Jpc2N2OiBBZGQgTUlQUyBQODcwMCBDUFUNCj4+IMKgwqAgdGFyZ2V0L3Jpc2N2
OiBBZGQgTUlQUyBQODcwMCBDU1JzDQo+PiDCoMKgIHRhcmdldC9yaXNjdjogQWRkIG1pcHMuY2Nt
b3YgaW5zdHJ1Y3Rpb24NCj4+IMKgwqAgdGFyZ2V0L3Jpc2N2OiBBZGQgbWlwcy5wcmVmIGluc3Ry
dWN0aW9uDQo+PiDCoMKgIHRhcmdldC9yaXNjdjogQWRkIFhtaXBzbHNwIGluc3RydWN0aW9ucw0K
Pj4gwqDCoCBody9taXNjOiBBZGQgUklTQy1WIENNR0NSIGRldmljZSBpbXBsZW1lbnRhdGlvbg0K
Pj4gwqDCoCBody9taXNjOiBBZGQgUklTQy1WIENQQyBkZXZpY2UgaW1wbGVtZW50YXRpb24NCj4+
IMKgwqAgaHcvcmlzY3Y6IEFkZCBzdXBwb3J0IGZvciBSSVNDViBDUFMNCj4+IMKgwqAgaHcvcmlz
Y3Y6IEFkZCBzdXBwb3J0IGZvciBNSVBTIEJvc3Rvbi1haWEgYm9hcmQgbW9kZQ0KPj4gwqDCoCBy
aXNjdi9ib3N0b24tYWlhOiBBZGQgYW4gZTEwMDBlIE5JQyBpbiBzbG90IDAgZnVuYyAxDQo+PiDC
oMKgIHRlc3QvZnVuY3Rpb25hbDogQWRkIHRlc3QgZm9yIGJvc3Rvbi1haWEgYm9hcmQNCj4=

