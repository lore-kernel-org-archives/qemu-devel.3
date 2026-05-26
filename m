Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CBCCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsk9-0007FU-VF; Tue, 26 May 2026 10:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRsk2-0007D0-2k; Tue, 26 May 2026 10:26:46 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wRsjy-0000Q5-UZ; Tue, 26 May 2026 10:26:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX2GUarIuJ6VwWWofY5zcVrK8EP4+oDS7RNVCf0u5AKKJSnKCK6mrW0E6/G0bLbgU8LGa4E4qjkuf64M5bvOUNQt5tHVBL+kwPEX+ArQUf6+txDtAvon/ZQiMQ/LbvE3fAPc45+ARdhMRl1SD5iTR3uOhmdRhz2fdjXOPfjmGdb0lai7yktRMZR2tySntyY+rTmlMbOhsdntVS9nBZOLQJoqpb/lnvLy4CW5Jfg6vOU3On/6/99K5bmVVsRxrhEFenKXs87B3sSu0l0W4SclDwBRQ9sPlkLmr2UwYAcnGJCRC0sondPjo0hN2tirE0FJJ6P9Y1fMDkAooJaPbhW7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tyht8oF3mNCfk/LhSrypPrmE8v3tP33vKphoIOXnr4k=;
 b=Msfd0lTIPxzlnh8nA/y9eTKV91R0MPGf4Yys0IQW7UPapAXEZfEsmQ3czEw5zR/bpv+pWzyxVZGv8a0HcBnuq+ZP+xJ5q8JaO4+cMEwUk0KKLfpPwS5cIRcjIRLnZ9VFa3vxfusqQNhKrzHn8H6h1iIxYp6VhNR7t1SqHg6gowGayZqns+hwi+UX4zoLyn6XkKfDg4j4Dv7xLuWHFgC/ySQycT89u9+VQPd//etgVWNbvQD8esXC2ZoXHvGsXgpia5RfBHh5Z+fOBO0X93TVoDs6Vb4Eg01B7GkgUe95mTsVrVvWO36egFTY0DQMkXF6wS8yzSgCdWt58n6rDYPhzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyht8oF3mNCfk/LhSrypPrmE8v3tP33vKphoIOXnr4k=;
 b=U1Sj2uLzi4zPvlP1nDvM9bkRRMGxg3Z8JamoIfQOedjZBpZAO7SvpPEO65ZBpCzFuS0BekRzyg7vFL5nQXjoty1WLWxCJYAYlHzroOI/wMaGL7ZJwNBpjmclRUGeiyukdBaNiNid7k97GR5Y1vdgRSelqNu2BVFAXQ+oeNOLj8U1dw31gTma59t1ljMHWGfbt1PoYwAeXGB3+TxX0sWCUz4PcKhLbPlQSULVFQ5fN6nEKc2hGYIs8LomsQtcFnTCdQezXS8Mf1bpzcvGZrJEMmycZ5WKwKEOjX2V/tRdJQ6/lwe6fzDuP0uUDGs+NxGKr7VbTJagzcNIzUzfR/vocg==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 14:26:34 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 14:26:34 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jiandi An <jan@nvidia.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>, "phrdina@redhat.com"
 <phrdina@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [PATCH v5 26/32] system/physmem: Add
 qemu_ram_backend_pagesize_min() helper
Thread-Topic: [PATCH v5 26/32] system/physmem: Add
 qemu_ram_backend_pagesize_min() helper
Thread-Index: AQHc53vlqXbPhUMx40OCSeDDmbyeW7YgFdAAgABRcfA=
Date: Tue, 26 May 2026 14:26:34 +0000
Message-ID: <CH3PR12MB75485AE00E92FB6C4AAF4C34AB0B2@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
 <20260519103727.899332-27-skolothumtho@nvidia.com>
 <6b944d99-617e-4ae9-a48d-9e28c6a8bcde@redhat.com>
In-Reply-To: <6b944d99-617e-4ae9-a48d-9e28c6a8bcde@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|IA1PR12MB7736:EE_
x-ms-office365-filtering-correlation-id: 480f58c7-b08f-4ea2-89aa-08debb32ca0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|11063799006|4143699003|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: wPPGFxO2qZCP2JBL+CY0x8S+6/6z+vpvt7HBKTbxWOhL0ovSoJxJgjieX1ou9jnfH/GTyWEgj8hu2czPZ4+A0KI0XVw4pbb9XPQ/sh0KrxEr54Q5X92YYU2Yr7EE4tR5JcBqd6aMuSAzugmkNP+ylHvRYoNlO+Jnt+NRJ2iU5GEVjD025dwyS7VNU6e+MJlFcXeTi47j/Mq1/UPEcnVZUUsGiXPHHpRQ8qa7QlztjlSU8OllBQUVhsqtoEUKAVHnI33AhFErbRBKlxGqjGU5exUTE5p3u9RiiinEO3ydDhdiZENRJJouSgezjyD1KC58YaueGSEaTxVDWJ5FFHyJ0LhIwNzQQWsNUECjjQaX/1q1Rz5DhykRZmvcYsObh5JvL0oBGJSv3aXaqOWWqeEmMzPjW9EbOzpIvhflIC8dNfPW3Q0DZtNj4VVcXXnwc9agG7r6FJkm2ERtVtJlD12Qgj+iwc23mTKkY7qqHvuw/7TbDf+xGS+SZl0xqiShSgtGHrbJkXUJNVHsRKmNSMKg1X9puKmQQJn3wQHFt2Wtz0PbM6iDl1QqEymhbw3uSL3ZPpYh83X6pRcJ2p3Em5aqdQ/gJrZEecRTbA8IpzdLYqGb20LX6PPWzVrWruRAQDObfxWfKX6FT7/h7eGuRZY1CSNA6Npc2DSi/144tEunvgXUVcvOVKwcqWCGQ3t7FPwgptIK3AoByfC0AFrXgQEfxQcwTXomyQM+Go3ElKHnJfXdQcWuRGJF6uiw8FdEnCM6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFY0eGsvM1FIS0tjeUYvRStpbUVVWHl1Y290SjIxZVBWVGFzSlp5OFNiczha?=
 =?utf-8?B?Y2FWbWVicWpGT0ZPMFppUWNlSXd0dGljZVBvUjhobTBDV3FOb1dvSi9pbFNr?=
 =?utf-8?B?OVJTM0VCUjFVWFJ0YXZpZHBIMWpHSHV5WmdEM1VuRjRnUy9PUTcwOEJNcDRr?=
 =?utf-8?B?WGxqd29FMGhVbGdzNGNQL3Y0cGp3czBvYkdXNlpMb2NDZ0ttZkRsOVRGdk4w?=
 =?utf-8?B?ZlJoWk95RW41N3orbm9YNWx2Z2dEL3ozenYyODBHMC9SVThrZlBxejlmNjJM?=
 =?utf-8?B?L0pTVnJLbWFSKzFORENMdjVldW9MZVo2YXBwU0JUdS9BcndmekRka2tUMEFX?=
 =?utf-8?B?VVRqT210a3JtV3RvaHlYS2w1ZTdWQ3RDbCtKWjJGYWxNYTFqQ0I2ekQ1UVY3?=
 =?utf-8?B?bE04QWhVVGVXVTZmajNhalBHQ3JNME1KTVg1YjkxWGlTZHhJQVBpMzdUdUZt?=
 =?utf-8?B?bE9iTUxiTVFrMkhSa1lqODJScmlYYzZvMVYxbWgyNmVoWVdOTTZqblNhMVFL?=
 =?utf-8?B?Z1dwUHFybXByRUJmZVdqemdtQ0dGREJxM1MzRkdsNkwzWE9wYTk2MTZiU2xU?=
 =?utf-8?B?QTR1dXRBV1Y2ajZtclNsaGFiMG5hMEcwYlpOaTV5dFBNMDV1UHNwbDV5b0tR?=
 =?utf-8?B?VFhuY3g2RmpXM2FaMEpXV21talhDVG9PQ2lHWGV4d2NqVlQ1MWJiOUZQK01M?=
 =?utf-8?B?dXpxdTRvVjdtdXpQQ3FEUHcxT0h6QnByK3lXN01oV2pHY1ViSDllWUZoK1VI?=
 =?utf-8?B?LyswQzdUMC9PU2twb2R0dHB4NmM4TFJkM3dQRGFZN1VKek1UT3dadzEwSUps?=
 =?utf-8?B?czVPZHJ4YitIQ1lUWlZHaG1aTnJML1dESExQb01KNlhtbzNFNUYrdXRpQ3p1?=
 =?utf-8?B?T3RtMkN3K0VCc3l2T0M2SktNOG5NRWpUeTVGSUJpZUZycnVoNW4zWi9XNE1O?=
 =?utf-8?B?VGJTSG8yZmpFSjFBTmRWY0NJSkxQQ2h2bVc3K1ZTVFd6SStxTVNFYVBSNW5C?=
 =?utf-8?B?bTJpNEtlWlhaR2R6MmVhQ2hTYmdzaTJ5OTgweEM1M1FIL3VZUCtUbkx3ZEx0?=
 =?utf-8?B?K2ZOd3RIbEgvQkpLQkIxY0gzQS93VUZJOEw1ZDh4SWY4VWRpNUZuKzZ4d1lW?=
 =?utf-8?B?SDdHbUZ6am56ZCtnaGY1RERBaFZCazBXenZtRUNXMGExSG9KY0tuYzdJWk5I?=
 =?utf-8?B?SEpLdWZoRVFvc0hRamhJRjI5YUU1L1BUamhqaUFyUURQdTRuazFNZkcvTUNi?=
 =?utf-8?B?WjhFbHh0V0xTUE9zdGxUMXRFY2ZiamtZYXIxN1NnK0dncXBVQ3NMQ1UzYTZn?=
 =?utf-8?B?ZVEzV0xueDZsSUhucklWSWMxN3dHQjhRcnByQUNMN3J3aGx3RS8xUm5GQkp4?=
 =?utf-8?B?TDJtclpqMWFhQTVHYkZYY2p5VGhDUW1XUFVPZzMzeUpDaDVoVmhocHdFSXIw?=
 =?utf-8?B?enlWb2dwZDl2YXBnSkwvUHdFY0JoQVpBakk2NjB3OG9jZmcwMnBKWEJYbWhq?=
 =?utf-8?B?VmRxdm10ajVqb1RGTmUwR2VWaDhRUlVmeFFhelVKQUNHMTV6K1NFZFRvRmZG?=
 =?utf-8?B?bWNYbTQzNy9vR2ZrZHJZZWcvWGozUWVaNGFPandNTk14Tk1hbHJCaXFKYzY4?=
 =?utf-8?B?M3BDZmI1LzhYbklPQ2RDYUROM3gzQTdDRXFkTWd4aENiSnpHaU53NFpGakhq?=
 =?utf-8?B?alpoTHpiR2NlTDB3bGh6NlVlS2JSdmN0L29NZ052MzUra0loSUd5c0ZkMmN1?=
 =?utf-8?B?SzBCRVpUdGM1cE9GM3VpWWs5S3FXbWVTc2Z1VTJwUHdkZ3dvZDBzbU4vdFdy?=
 =?utf-8?B?Tk9sQ3F6NWlhcTFxOTg1OS9EVnBibEo3NjhwemdPOU9UQ0pibmxSU3o0clRa?=
 =?utf-8?B?Ly80T2pqRVAyekVtRHNNZUUrOWhPa2ZoMXVQcUpyOXBEQk9tZEYzR0ppNlIy?=
 =?utf-8?B?TEVTNDAwa0hXYXFZMXdRd2x0b2tzcGNCMUdSd2g1cWRTRm9VWEFYcjZwd25G?=
 =?utf-8?B?aTZQVjVSWWRmUnNIK2xKaFpUU3A4VmN6bUtGV0RWbTg4NXc5azdXc0VKRURZ?=
 =?utf-8?B?WitBU3lIemtSei9YUzc4MElCeWxrdlZEWEY3QUZTRy9ZSElwOCtNZmljbWJj?=
 =?utf-8?B?VVdKbUdJQXpPTFp1cUtSVHZiQkJxOE4xZnFqMnBYSEhNQnlZZWhBTDI0alg1?=
 =?utf-8?B?MjZHRlo3a3kzeTZYVE9HczJxUGo4Sk1pOXFwUG1icW12MUJWdzI4YWlaZlVD?=
 =?utf-8?B?YjI1dnlFREozOEE2MHhZWlpwUklQQnl4RDhqZFZ3c0tRZ3VvblMwWUJhd3Fq?=
 =?utf-8?B?ZXlUTWY3cUNHS0k3QjJ0RDR3bFR5UFJCeE1DVlVJMzJjN255Q2U3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 480f58c7-b08f-4ea2-89aa-08debb32ca0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 14:26:34.5084 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h4WGO/BfXks2f0/x8/YAhYUwQYc5k9D6ZPlbXwinyiV6BFO0G1YpLG10GStopioHM0MqlpYRUbqq9LkRjyizMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7736
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRXJpYyBBdWdlciA8ZXJp
Yy5hdWdlckByZWRoYXQuY29tPg0KPiBTZW50OiAyNiBNYXkgMjAyNiAxMDozMQ0KPiBUbzogU2hh
bWVlciBLb2xvdGh1bSBUaG9kaSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+OyBxZW11LQ0KPiBh
cm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBwZXRlci5tYXlkZWxs
QGxpbmFyby5vcmc7IGNsZ0ByZWRoYXQuY29tOyBhbGV4QHNoYXpib3Qub3JnOyBOaWNvbGluDQo+
IENoZW4gPG5pY29saW5jQG52aWRpYS5jb20+OyBOYXRoYW4gQ2hlbiA8bmF0aGFuY0BudmlkaWEu
Y29tPjsgTWF0dA0KPiBPY2hzIDxtb2Noc0BudmlkaWEuY29tPjsgSmlhbmRpIEFuIDxqYW5AbnZp
ZGlhLmNvbT47IEphc29uIEd1bnRob3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyB6aGVuemhvbmcu
ZHVhbkBpbnRlbC5jb207IEtyaXNobmFrYW50IEphanUNCj4gPGtqYWp1QG52aWRpYS5jb20+OyBw
aHJkaW5hQHJlZGhhdC5jb207IFBldGVyIFh1IDxwZXRlcnhAcmVkaGF0LmNvbT47DQo+IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2NSAyNi8zMl0gc3lzdGVtL3BoeXNtZW06IEFkZA0KPiBxZW11X3JhbV9iYWNrZW5kX3Bh
Z2VzaXplX21pbigpIGhlbHBlcg0KPiANCj4gRXh0ZXJuYWwgZW1haWw6IFVzZSBjYXV0aW9uIG9w
ZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPiBPbiA1LzE5LzI2IDEyOjM3IFBN
LCBTaGFtZWVyIEtvbG90aHVtIHdyb3RlOg0KPiA+IFNvbWUgaGFyZHdhcmUgYWNjZWxlcmF0b3Jz
IERNQSBkaXJlY3RseSB0byB0aGUgaG9zdCBwaHlzaWNhbCBhZGRyZXNzDQo+IHMvRE1BL3BlcmZv
cm0gRE1BIGFjY2Vzc2VzDQo+ID4gb2YgYSBndWVzdC1yZXNpZGVudCBidWZmZXIgKGUuZy4gc2V0
IHVwIHZpYSBJT01NVUZEKS4gVGhlIEhQQSBpcw0KPiA+IGNvbnRpZ3VvdXMgb25seSB3aXRoaW4g
YSBzaW5nbGUgaG9zdCBiYWNraW5nIHBhZ2U7IGEgYnVmZmVyIGxhcmdlcg0KPiA+IHRoYW4gdGhl
IHNtYWxsZXN0IGJhY2tpbmcgcGFnZSBpbiB1c2UgbWF5IHNwYW4gbm9uLWNvbnRpZ3VvdXMgaG9z
dA0KPiA+IHBhZ2VzIGFuZCBmYXVsdC4NCj4gPg0KPiA+IEludHJvZHVjZSBxZW11X3JhbV9iYWNr
ZW5kX3BhZ2VzaXplX21pbigpLCB3aGljaCByZXR1cm5zIHRoZSBzbWFsbGVzdA0KPiA+IHBhZ2Ug
c2l6ZSBhbW9uZyBSQU0gcmVnaW9ucyBiYWNrZWQgYnkgYSBtZW1vcnktYmFja2VuZCBvYmplY3Qu
IEZhbGxzDQo+IERvbid0IHlvdSBoYXZlIG1lYW5zIHRvIGJlIG1vcmUgcHJlY2lzZT8gSSBtZWFu
IHlvdSBrbm93IHRoZSBHUEEgb2YgdGhlDQo+IGNtZHEsIGNhbid0IHlvdSBtYWtlIHN1cmUgaXQg
YmVsb25ncyB0byBhIHNwZWNpZmljIHJhbWJsb2NrIGFuZCBjaGVjaw0KPiBpdHMgbWluIHBhZ2Vf
c2l6ZT8NCg0KQXMgeW91IG5vdGVkIGluIHRoZSBuZXh0IHBhdGNoIHdlIGRvbuKAmXQgaGF2ZSBH
UEEgYXQgdGhlIHRpbWUgb2YgaW5pdC4NCg0KPiANCj4gQnkgdGhlIHdheSB0aGVyZSBpcyBmaW5k
X21pbl9iYWNrZW5kX3BhZ2VzaXplKCkgdGhhdCBleGlzdHMuIENhbid0IHlvdQ0KPiByZXVzZSB0
aGF0Pw0KDQpBaC4uIFRoYW5rcyEuIFRoYXQgbG9va3MgbGlrZSBpcyBkb2luZyB0aGUgc2FtZSB0
aGluZy4gQW5kIHdlIGFsc28gaGF2ZQ0Kd2FycHBlciB0aGF0IHVzZXMgaXQsIHFlbXVfbWlucmFt
cGFnZXNpemUoKS4NCg0KSSB3aWxsIGdldCByaWQgb2YgdGhpcyBwYXRjaCBhbmQgdXNlIHRoYXQg
aW5zdGVhZC4NCg0KVGhhbmtzLA0KU2hhbWVlcg0K

