Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B414C606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=selector1 header.b=YhVOT5zf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzK3-0005jd-14; Tue, 10 Nov 2026 22:48:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1xQzK2-0005jU-7y
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:48:30 -0500
Received: from mail-japanwestazlp170100003.outbound.protection.outlook.com
 ([2a01:111:f403:c407::3] helo=OS0P286CU011.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1xQzJz-0005Cn-6P
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:48:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y8QXrn8o/si1vH6N2iK1dwNTzPZLnUGkTKCQjeACjzkSYGhIsfEk2ubfEaTOGCQ4IodwfKVuHN8IW9p8xL1oxWtg9aF5iiDn0N16n1KvP+/fd8+i4sdmZZpp8E9PiNGWqEwcV3zxKfI9z6L8OwonbvCwo8VwToIhkftwAz2jwTrMQ0ftPVrgF0F0BwpF+bf7ZbO67wLLH8MJJ3eUP8t1BdmmUxoWdtB7x2xjPoxgPHTIjTbnQrQGAi6YNZ+uT1n9mzm1UaZMFpqU1+eRKI8OB8r6NP/l1hN1cQwAtiovb9zH9T/5lDh3NhpGhHuU/k8vPiQ3OchjtIJns6C8eoEQag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVFarcY//Hum/l1FzwqjJB7RWhyCwpzfEtYe8OK4WiM=;
 b=Ps5OQa+eL2GgQTX/cDSik/UPjc43y42SO5f4p+DBYokphUEPSugRjDhLO6Sy0qBuA+REo13O0G00wY3xN4UdblgCCGwmMS51+n9aF8wXpGVjeV4HGB5J3MsDN8DQEbmLArCKkRvLn1r6MiHBzJMCJCeOkzGbkyM8TTvHbacuRBx3zxgvxjdFVHFH9E5FzACzOY96SLlXi/yfaoxuDq0KdGrlVTHp9cacnaN491GAneIoUSoOt6UgP7jDkef7jlU3XbMYJZQXys8tjaZ0AX9K1D/yjZDEvTaGxy1qE1Gq266vua1oVM1DGSoW5c+AJhV0wWZba02J5KoRrU1l/Og4MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVFarcY//Hum/l1FzwqjJB7RWhyCwpzfEtYe8OK4WiM=;
 b=YhVOT5zfKDIwQL/JNaSm3MQQPSCQqJ6Wnqdl+hJW76klDAOHLqZ9pXx9RQAnas6XY9h8VUm0CEBoPNJiUdCdvd/WW5YRTrEbSi9QEBPlfWcYK9etg1zVvSa4V5mwq/mRE+yv1UIwTEdohOAau6DZOMNSRsolb16WycI6tLw/uMwg0W739Pfs9dqAjPABNbZIda7HPqtpFsZQGe2htuPExXKQY0GiyTk5BuWtMC1pWkNa5l70C29MjX2CpavRop20XYaw97dgrbrP6n0CraJ6L3rVnvs1GSG5u2v0ZwbcobtBz2UUsrVdo63LZx2s2NOEKLUJD3tosQrRbQNZXpEfmw==
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com (2603:1096:604:2e6::7)
 by OS7PR01MB15130.jpnprd01.prod.outlook.com (2603:1096:604:370::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 03:47:48 +0000
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131]) by OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 03:47:47 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Dmitrii Omelchenko <dmitrii.omelchenko@cloud.ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>, "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>, 
 "yanfei.xu@bytedance.com" <yanfei.xu@bytedance.com>
Subject: Re: [RFC PATCH RESEND 04/13] migration/rdma: Add the send consumer
 thread (drain only)
Thread-Topic: [RFC PATCH RESEND 04/13] migration/rdma: Add the send consumer
 thread (drain only)
Thread-Index: AQHdcSS0M/50rwZ4OEKfBMfOuh+fGLcoPIoA
Date: Wed, 11 Nov 2026 03:47:47 +0000
Message-ID: <92973d7d-88d9-4036-801b-f3cd68d68f2b@fujitsu.com>
References: <20261110150247.193208-1-dmitrii.omelchenko@cloud.ionos.com>
 <20261110150247.193208-5-dmitrii.omelchenko@cloud.ionos.com>
In-Reply-To: <20261110150247.193208-5-dmitrii.omelchenko@cloud.ionos.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12148:EE_|OS7PR01MB15130:EE_
x-ms-office365-filtering-correlation-id: 687e1e09-b973-4b73-5f75-08df3fa68d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|1580799027|10067099003|261028144727099003|261026140227099003|261022075727099003|261026121527099003|261022105027099003|38070700021|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: Og13q3M+8tpX727RJHluZ8s8ELYNuXid1ds2LcwEPwJjv/ReZy4urkOxv5iFYUZ/jNtWlmtabM7rJdAUiji6Ow9jwMdNY1sCN+e4RG9/dQk4n+93BZhQnIaV9D3mtV5y9ZDXzNJBR56X1cmhy5wg/DYc5q0zN72dT96MJ7a0vHVqXJGD7JTuqTuft7ZB7nA6efjLoEOLrDXc4vmCVzyCQu3BENXtuHl8Sl6sOwEJTaK4d8e/BT2idsDRmEf/s6BRnsFrOifyvgLLkB0wPtN/7+VUyj7Pe/clx5iYiq+FR2dEUvLSGOLWwpFBPZuGqejJyfh9LsHBqHZlFO22X/cuMSG95OBzdZecoRRVi4uGMQkmRmj+PoyzLgRBqLE0uVtMYsbAAc2DE5EodcmQFi8qvB3QqKsMSfNqZZPVYBKf+4thEwEbcgIyfI7Zj1vbGCy5QQxQhD2iMOkFeIoMfBZkXEPzZ3v1VKvIml7eV55h92i+vOP+YP9DYE403X2/nn6TfmU2p0cvzPJD+VHROiOZOYTy9stbuT5yeuK4KddsG4IVwA0uYiVYRUn/3u7EUQYtHhR5b7m9ZdRREH9csI80oMavOvNqGbVEiPJ3ruuJPAoOBaOMcoLTX+6/Ttw+xQ7EgToTXPpqWo/CEO29NnRMS/BP/P5Zvw2A8vpmkqJLywv9DXQnJW28RtrpOQL9AeO8M9jn2tovP0YvjDlnlU8LtC9RXNDElqhqgQvL3hlKltbLNN9ClFfgcDztkzftrc6x
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS9PR01MB12148.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(1580799027)(10067099003)(261028144727099003)(261026140227099003)(261022075727099003)(261026121527099003)(261022105027099003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajNwelBISEY4eXpBK1U3Z2RYUmw5Z3lVemdITUdMVEpWc2k3R3BVdHZKSHZS?=
 =?utf-8?B?ZHNtMnpsSzhURXp1RWMvQU1rRXF4eldjMVp4YlhDaWZqZlB4Z3F2N1VtZXhB?=
 =?utf-8?B?L1IzZ1IzMVNObkkzOEhaWXFJRGE2S0szTWYyOGlKZFNkYTlzQTc5ZmZFdnNj?=
 =?utf-8?B?aVQ3MStlRjNmSm1UdzVzUkZ0NGk5VVNjajkvMCtlMmoyTFB4eC9GWHNHQTVB?=
 =?utf-8?B?YmNqRUFNWEdRYUovTEU5bjdNNVR3UktPWWZmTU9XRmdKcURrNDdDTmhZekVD?=
 =?utf-8?B?clJ1TS8xM2pCaU5lWTVKVy9CY3V4a0hFckNpb3lnQXo0elc5NkE0Mnd6NDhn?=
 =?utf-8?B?QVpKUC90RHZWVCsvZXE1Tjk4MzFzdG9QcGV1TDR4Q3d5L043TnB0U2NMVkdB?=
 =?utf-8?B?eEllZWQxcStXcko0bDlXclJmczhnRnFHdmFEV05OR1lKOUNic3BHY2swdkta?=
 =?utf-8?B?cmNKQjNCWGhnWms5SjJheHkvaGhKVFBkVm1sc0tCS1l5Nkd4ZGtNUzlvNnRi?=
 =?utf-8?B?Z2xoaDcxaE1IcGRrTHNWbEdycXVWNUJWaG5zYkZwZldxNWhrZUlURWFzWjM1?=
 =?utf-8?B?cEc2VzErRGRuY1JUNlVnMmFuWXoyR3FRTm5uR0RVR3JBN3k2WW95b1czelo4?=
 =?utf-8?B?QTlRUVVWOHVPTmp3akZPcU5HVWdTVTMwWlY1Q0wxR1BKNDYxTElsZWd1K2JV?=
 =?utf-8?B?UmluNW00K0lVY3FtZjZySEFjdHVSOTZRVUMrQ2FkQW1OVkpNbzNGRmVldGZV?=
 =?utf-8?B?YnZ4NEhHWncvNU55MTdORk9OOTNMSXJGSytkclZOK2RaQ3NJRTJaTEQyUnFW?=
 =?utf-8?B?ZFZCQUw5NDJ0Z3VoWEpDY2xHTTByUUZ6R0VXSXhaTHNSc2tWakxvUHNSZysr?=
 =?utf-8?B?L29IVUF4aEJpMkNKOEoycE1ZMWpQRjduZmhiMFdrNlZNSk0xS0lLK0xNdEFz?=
 =?utf-8?B?cXArTm9mZHNLdkRoekZXU1JrZXV2YU43VW9IQ0tWc2oyVFM1bXUrQmVVaDVp?=
 =?utf-8?B?Ym1iV3RaUmV5ek96QzZva2tESzVEQkozUEpkM04rb3BHR3BFcy9NaVc5aUpi?=
 =?utf-8?B?YUJvVFI1a0xQUC9pbGdzaTJUa2l5QzFNZk5IUm9GVkRFdnZxcFVYV3NtdWRK?=
 =?utf-8?B?TUI5aXJ2aGxFM2IxVGFiZU1iM3hPbUNDZE1CMWdzQnYwdzhPeG1uczJ2QkJj?=
 =?utf-8?B?c2J3aWtoSXp2VmIzVkRxRk5QSFVZeFFCWFBtcm53K3gvZGZReFp6b3kxM0pS?=
 =?utf-8?B?RDQzUTNIMDdJVWZ4anpLZlRsK054cnNFMG1yQVZBcjdnK3llMXRCN1FRbGdW?=
 =?utf-8?B?RUhxNnZ0WWRjd1JVUTlRM2d2Ujg2UllSTzVDeWt6OGQyS1p2Q0FnQTNnN0FO?=
 =?utf-8?B?SEZhRjNLWGZxRElQZURaaDVCdTFLWUVrZ3NRVjFqYXBrVndBQTBuUXlTYWhZ?=
 =?utf-8?B?RUpPYi9UZFYzbmxsbGc2S2pSMmRIZHUvNXRaYWp0dmtrZjhWN2xQL1VwSTdo?=
 =?utf-8?B?UndPKzN2NnRuOW5iWGJDMHlOdFhRVkpLWE9tSEpEMGZaemlLd0hPeGlZUklH?=
 =?utf-8?B?TVBrQ1ArWW81RE9aZytSdEJVVEhxWGVTS1NxVmxlL3BXR2pQOXFOeXh2SE4x?=
 =?utf-8?B?dWlJZGtWbkJIWHBGbmpsNCtrckExamhaenhjWng2eGk4YlJnbVhvaGR4YUV5?=
 =?utf-8?B?eHlaSEMvQXZFTFlSNkdUZHJHbkt1TXp0bmFCQ2c1dUxFaEFNSnB2dksyUmxv?=
 =?utf-8?B?dmo0c0V2ZjZLM1YvQm1RTnN6N1Joa1dRdVFJWkEyNVhVd1pXQTZmbGpieXFv?=
 =?utf-8?B?NUdMbHp1alJuTUI4V3IxSGlrUWZGM3dQTStUVG9WYUU1RlkxZlluL1ZLSHR3?=
 =?utf-8?B?c0FFL3RpZzEySkl5WlhXNXNqVW9kdkR6WlN5dHRTT0sxWDU4MVFZNTFYVWkw?=
 =?utf-8?B?N0dhT2FGVkpBUlRQL0JKcmh6SG5MQTYzNjRqanU2ZzNOaDkrTWt1TytrYTdr?=
 =?utf-8?B?QTk1RHBFbVpVdVlhbk5Oa0xwSEQwU0UvTnpRb3dIMGdnbXNhWjVzTXphSEhm?=
 =?utf-8?B?UlQ0ZkNYdktydHN6VSthZnUwdWN4Y3Q0TjRLNlVjd0JXT0FsZktYUlRrbHUv?=
 =?utf-8?B?VWR5Y2JFU1pweFBDWjFpV1ZDc3BVUUx5Q1VmbFJobHFrUGxqRzQxRjh5UXcv?=
 =?utf-8?B?VWp1Tm1oMjBvOFRBc3N5OTYzYmxQVnNNb29OaFMzOENHak1lZG9ZY01mb1h2?=
 =?utf-8?B?SGNIY3ZTT3pvNVRWcWxoejc5NHJXNjFOK3pPODRabGpWWjRvamZ4dHV1eTBv?=
 =?utf-8?B?aW5EeGROci9uTjQ2cFR1Vmh2bFRGQ01Ja1FLZE5OK1hwYWs2NHZPZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45A3EF43E4756D49A88A9DD92ADC0004@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: EpdKc6luqaJeZ3SJ2LjD7T4/jfNAjcrpe+XaCimuVQecC1Egpj2q7hPfbz+r8UGOoBxB9VvNHjsxQhLaVgChws9GgYptsgcWSdF4yH/hkdEqPdF0GulggONT6KQBsQhh7qPq463/boB7L3fmxZqNEGpUH9U04NHh0Ma1YhhVgxXRAN9OZNSNbHoLp6SVCHetWlJjLitooKU2F3U+WYb2ximX6wMzC5fmmIHQNcUYvxJ7rP0MY2iwlt+Uf9uxUDYQhR5y0dZQLeE3eRoHcu40hTMLx3MYD8Dxn79/4V9fR3Y6kXkaN7JLS3hFYqFi622XnkASgD0kKgx+qFeoozwPSg==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12148.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687e1e09-b973-4b73-5f75-08df3fa68d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 03:47:47.4151 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJg5O221tcwIXanPo1zJYy0mDigfnILdmA8sy5ht6Rt/a0sk+dZUn43O8JtsgIxQesNwylxJKBc+6QIvU4n0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15130
Received-SPF: pass client-ip=2a01:111:f403:c407::3;
 envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU011.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DQoNCk9uIDEwLzExLzIwMjYgMjM6MDIsIERtaXRyaWkgT21lbGNoZW5rbyB3cm90ZToNCj4gKw0K
PiArc3RhdGljIHZvaWQgKnJkbWFfY29uc3VtZXJfdGhyZWFkKHZvaWQgKm9wYXF1ZSkNCj4gK3sN
Cj4gKyAgICBSRE1BQ29udGV4dCAqcmRtYSA9IG9wYXF1ZTsNCj4gKyAgICBSRE1BU2VuZFJpbmcg
KnIgPSByZG1hLT5zZW5kX3Jpbmc7DQo+ICsgICAgYm9vbCBzdG9wID0gZmFsc2U7DQo+ICsNCj4g
KyAgICByY3VfcmVnaXN0ZXJfdGhyZWFkKCk7DQo+ICsNCj4gKyAgICB3aGlsZSAoIXFhdG9taWNf
cmVhZCgmci0+YWJvcnQpICYmICFzdG9wKSB7DQo+ICsgICAgICAgIFJETUFDbWQgY21kOw0KPiAr
DQo+ICsgICAgICAgIGlmIChyaW5nX3BvcChyLCAmY21kKSkgew0KPiArICAgICAgICAgICAgaWYg
KHJkbWFfY29uc3VtZXJfZGlzcGF0Y2gocmRtYSwgJmNtZCwgJnN0b3ApIDwgMCkgew0KPiArICAg
ICAgICAgICAgICAgIHJpbmdfc2V0X2Fib3J0KHJkbWEpOw0KPiArICAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiArICAgICAgICAgICAgfQ0KPiArICAgICAgICAgICAgcmluZ19hZHZhbmNlX3RhaWwo
cik7DQo+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4gKyAgICAgICAgfQ0KPiArICAgICAgICBy
aW5nX2lkbGVfd2FpdChyKTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICBpZiAocWF0b21pY19yZWFk
KCZyLT5hYm9ydCkpIHsNCj4gKyAgICAgICAgLyogbWFrZSB0aGUgZmFpbHVyZSB2aXNpYmxlIHRv
IHRoZSBwcm9kdWNlcidzIHJkbWFfZXJyb3JlZCgpIGNoZWNrcyAqLw0KPiArICAgICAgICByZG1h
LT5lcnJvcmVkID0gdHJ1ZTsNCj4gKyAgICB9DQo+ICsgICAgcmN1X3VucmVnaXN0ZXJfdGhyZWFk
KCk7DQo+ICsgICAgcmV0dXJuIE5VTEw7DQo+ICt9DQo+ICsNCg0KDQpUaGUgY29uc3VtZXIgdGhy
ZWFkIHdyaXRlcyByZG1hLT5lcnJvcmVkIGhlcmU6DQoNCiAgICAgaWYgKHFhdG9taWNfcmVhZCgm
ci0+YWJvcnQpKSB7DQogICAgICAgICByZG1hLT5lcnJvcmVkID0gdHJ1ZTsNCiAgICAgfQ0KDQpI
b3dldmVyLCByZG1hLT5lcnJvcmVkIGlzIHJlYWQgYnkgdGhlIHByb2R1Y2VyL21pZ3JhdGlvbiB0
aHJlYWQgdGhyb3VnaA0KcmRtYV9lcnJvcmVkKCkgYW5kIGRpcmVjdGx5IGluIHRoZSBjb250cm9s
LWNoYW5uZWwgcGF0aC4gU2luY2UgdGhpcyBpcyBhDQpwbGFpbiBub24tYXRvbWljIHN0b3JlL3Jl
YWQgcGFpciwgdGhlIG5ldyBjb25zdW1lciB0aHJlYWQgaW50cm9kdWNlcyBhIGRhdGENCnJhY2Uu
DQoNClRoZSBhdG9taWMgYWNjZXNzIHRvIHItPmFib3J0IGRvZXMgbm90IG1ha2UgdGhlIHN1YnNl
cXVlbnQgcmRtYS0+ZXJyb3JlZA0Kc3RvcmUgc2FmZSwgc2luY2UgdGhlIHN0b3JlIGhhcHBlbnMg
YWZ0ZXIgdGhlIGFib3J0IGhhbmRsaW5nIGFuZCBpcyBub3QNCnByb3RlY3RlZCBieSB3YWl0X2xv
Y2suIEluIHBhcnRpY3VsYXIsIHRoZSBwcm9kdWNlciBtYXkgcmFjZSB3aXRoIHRoaXMNCnN0b3Jl
IHdoaWxlIHNjYW5uaW5nIGRpcnR5IHBhZ2VzIG9yIHdhaXRpbmcgZm9yIGEgYmFycmllci4NCg0K
UGxlYXNlIGVpdGhlciBtYWtlIHJkbWEtPmVycm9yZWQgYXRvbWljIGFuZCB1c2UgYXRvbWljIGFj
Y2Vzc2VzIGNvbnNpc3RlbnRseSwNCm9yIHVzZSB0aGUgZXhpc3RpbmcgYXRvbWljIHJpbmcgYWJv
cnQgc3RhdGUgYXMgdGhlIHNvbGUgY3Jvc3MtdGhyZWFkIGVycm9yDQppbmRpY2F0b3IgYW5kIGhh
dmUgdGhlIHByb2R1Y2VyLXNpZGUgZXJyb3IgY2hlY2tzIGNvbnN1bHQgdGhhdCBzdGF0ZS4NCg0K
V2l0aCB0aGlzIHN5bmNocm9uaXphdGlvbiBpc3N1ZSBmaXhlZCwgdGhlIGNvbnN1bWVyLXRocmVh
ZCBlcnJvciBwYXRoIHdpbGwNCmJlIG11Y2ggZWFzaWVyIHRvIHJlYXNvbiBhYm91dC4NCg0K

