Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2142606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=TeyJ4X2S;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=XVgxSDW7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMRU-00021q-RO; Wed, 11 Nov 2026 23:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMRT-00021Y-La; Wed, 11 Nov 2026 23:29:43 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMRR-00015C-2L; Wed, 11 Nov 2026 23:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794457788; x=1825993788;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/Q0XJavYHfXBxZlq9yK9JodExml7vupQywt5OaG81CQ=;
 b=TeyJ4X2SJ8mic6BjBiYvoJhGGIOrFgSTTTKeoBbCyziOfFe0xzUfcdpA
 CQejzR1BXOcuPuzOnQlqHTtYeOiODYCdQWzjzDYgYYkGvIZ+S78A6hFzK
 FmuatKpx0QZ1qFDF6NYbJH8icrN1U5HlYpTpDcT0lFy7IGvr67QanAe1Y
 jUOn8LmJtQUXSucc7aq4RLA83MuSygYByLo5mKkXCWfYSxHj9+xh5MD0p
 qogAz5LM0krLUzmZ7IXB3nqTUl3d4l+2v4OO9y4HILzqudXcx58uCURs8
 73CZDowr2n8olWsvXRRNYm0icpnAq22Hbug2uKMbqS4p8frcN8lAZQGW8 w==;
X-CSE-ConnectionGUID: WeDRj4aiQNqyKgyY3PkiIw==
X-CSE-MsgGUID: WQHSyQfOSh2Y/Mxz//7/eg==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="160699441"
Received: from mail-southcentralusazon11013035.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.35])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:29:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlgA9qtLU6u6ZYxkkOELQxEd5bXycSihXbofB86azoDLJ1E7Fq6B3pCtwNBi7NQ8XkwzWrgLGCyzUgN/DkhEPhZAZJo5zwsUfAf7vKRG3bdRR72RymjoieM71ve98josnMxnIPy+KLJ2Qxjv/MT3G5wQ9tgFNeTFRUmtU6rDNJLIvxwxZWkxUub+d5efvG7j0GW/h1WcMwICGrkbrM17jHcwpqKL4ZKhWWUPXg+T7k0msvIUY5mis1lrbNJ5KBnvLuB87w0lI8DyQFXphJrc9RkxhbglpXHEXcSNxuNaAk2X0mazv3BEegk/u2gjYVJEBRGib0wCKe3fSHo/fxLlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q0XJavYHfXBxZlq9yK9JodExml7vupQywt5OaG81CQ=;
 b=wSG+A7+kPaxOzrLkxuYOAjmvGz+Dyui8AAUVMPKqFH+Ms8d0rZKBXvbTCe/BZubCJSEIpAbPTevbEQ9BSxDt7D79Ty09p4KqodPGKoFYw+HRePUAc74vLKnqdzg6GLghEGIhycruo6b/uAKpxYxkbh5zKa4zJgyw1taDtGy//6nAL/J3i0AZaOSYHQNaU2gi8tu8VqnLDzoBgAB9bAzYlaqclx64B6KhhN4gAzBSdPHNE46caFySLPgmH/op6lxrQTXRMbzl2joUbS6iIkL64UOryv/H6Td0Jw2lb4JQf4PEsjrbXkYv2z8EahBN3ifDBo5nqzn09Zr2RmqF+uJzfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q0XJavYHfXBxZlq9yK9JodExml7vupQywt5OaG81CQ=;
 b=XVgxSDW70OypyQWoo0mzFd7AS/fGCpw75syvimqK4QlkOfhBGEX3u/L4Ig8GjrPp8W0wq6XXzeOP87onremTHKWgHybOH5m4UL0yB9D4uqFIMpsaM3AGwHB+j5+Ne0bEAgtsJXBwuAys75aZdo1sDEnFyVEuaIcXqEvks5IQORA=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by MW4PR04MB7443.namprd04.prod.outlook.com (2603:10b6:303:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 04:27:33 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:27:33 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "fritchleybohrer@gmail.com" <fritchleybohrer@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3] target/riscv: save ELP in MPELP for NMIE=0 exceptions
Thread-Topic: [PATCH v3] target/riscv: save ELP in MPELP for NMIE=0 exceptions
Thread-Index: AQHdbalhrX96fdkD8EOwhR3UEyNj/bcp4PEA
Date: Thu, 12 Nov 2026 04:27:33 +0000
Message-ID: <eeee71079a014b87bd0af7385659068be2ecd4c2.camel@wdc.com>
References: <20261106044306.90168-1-fritchleybohrer@gmail.com>
In-Reply-To: <20261106044306.90168-1-fritchleybohrer@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|MW4PR04MB7443:EE_
x-ms-office365-filtering-correlation-id: 1e9351d6-584b-4544-7bbf-08df40754590
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|10070799003|23010399003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|18002099003|3023799007|261022105027099003|261021121427099003|261021123027099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|56012099006|10067099003|11063799006|38070700021;
x-microsoft-antispam-message-info: wcinGHJ1YzXUeA1cdmUuxom5eZ1/z+D6mzV3a8De141gvgJyAIt6G64NEySxZTlZkYaKhUD5tb2kR2MgqatUZGIycnJwRQ/w0GTUKZfh3CRT/q7baBuVqFJTUo0Z0sKCQQjsJgywtqOm2z0YYjDw8WdSdw9AWA7QxYDWi/GScIsQFBdiLraUg37ZLlSnMdlx6pzdxxrZl3qeheVEVcWBCfrXyep9PBsTq+Oo/ljMu11r/j823Aev43TOYts/DWXgjewIakipLN189L+A+5rRZEctzKOICJ1YV+dIpy3AEKkBvFjjTektyV+/vk5YqEkBowF+2BdpZjk8DSPaOIQDZTxX35MACLlXce59uPF65OaQOjBMkC5HZleJMzJN7olSwVcWMGA19Hc2ooUam3X00n3jDJX6e/WK/eH+/0HzOVAGYmsbE2BEkbWYxKPKeMP9FHXUH0YanNIIrf11oYL3KcGWZ/FyQ6YN4CTZk+i5yV25TuLhKJRuM2iOlZvGo8zvAXw/PcPyGK7c520Rn6fSvhNDcPCCroirp+R4ob3Tpl0f7RC8IB21unjlO98JXQPh+M8BWIJ/oSZMSlDOOVaIlVokOFr1NwsD6tGfkV6xoXKrGKjErQH6pljlKK8MnCRFbgNNvktmWUpDR/gKWb4VobNPAAIV0uGNa8IzJHa5qpQmB2PzNXbXcw/IMmwreMMseW7MC3vEzBv/dhHrZbnmGZem5X4sdJExy4ssHS47cUE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(10070799003)(23010399003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(18002099003)(3023799007)(261022105027099003)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(56012099006)(10067099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHB4VDQyTWhTV1liVEN5eGMrZXZYb1d4bU1nME85M1VHMXB6TTg1MDNjbzJV?=
 =?utf-8?B?dnVIVUdqQUgxR0l3R3I5WSs4UXJWaFh6NlpvWWsxRGlMU0lja1FsajdFUU9Q?=
 =?utf-8?B?Znh0akZjRXVHN3NiWk9tMlU2ME1BWjRSZjVNTitGZmhQNEdLZHBWaFcrNThO?=
 =?utf-8?B?bU9WVmxuY3JwSmVmSERTYllDVENqaklEbzZVQXdtUlVyZHg4eWJtckRUYTgx?=
 =?utf-8?B?Uk5YaXM5bmpEeFRCUDd4dDd4eS8rNkNidXp0aU40bkJYWXQxNGY3K3huZnVW?=
 =?utf-8?B?MEE1SENIYmRrbTJwZ0ROcCtxa3dyRFdLT3RJMjYvaW1qTjUrR3ltcEZ6Q2Rz?=
 =?utf-8?B?SHV3cTY3UUQvS1QybWQwZFBKdXJ6eTJYNkxQK3dRRGNTaCs3MkY2KzRjTUov?=
 =?utf-8?B?UEF1R2tkVUliRHFSRS91SVNobDNFZ3oyWklyNU1mY05jM2hmSEU3M2ZwdE5s?=
 =?utf-8?B?aDNML25JSjFnZDZmYk5VY0xLcmdVYjV5QXRiN1ZBRFpPNUNmMk4xR2ZQRWhj?=
 =?utf-8?B?ZzBTbTBPMW9oSlp3eitJZXhzS1c4MVZaR0JzY1lCRnFOeUJkalFmbFduOURv?=
 =?utf-8?B?akc2SlhnTmVDdHNLRWR2SytacCtBTlpVNFp1QU9Va1VVa1NRWE5CU3lQdnhh?=
 =?utf-8?B?Z3ZxWTd6NVIrY3dITENyNFBDZW40cGs5WlZVeG5kVlBkVGJlajNVVmlyK0NS?=
 =?utf-8?B?RU0wSlkraW9iSHFCTHBWK1IwdEJiV1VDQ0kvNkc5L2JUcGRoWjh0RTZLSUor?=
 =?utf-8?B?UDVFRncyaXdqV05jYVB6eGs1a200SjUrblJYTS9PWldUWE9lVDdJdXJCa1Fa?=
 =?utf-8?B?U3RCNytzWUg2eEJhYVY5YVZvaTZxU004QlRQSFlrRXJGQ01LTXNZZ3ZiRG94?=
 =?utf-8?B?eXhuVTJrZnNrN3pKYys2blZIbUJidmxyV2Q0MmhIVnVwWTA5T2VHU2FGR05I?=
 =?utf-8?B?WW9oSWlRYnZucWdwVnY2bHF6M3JuSVJ1WFRUamcyUzdoeXU5WUJWaHB4My9K?=
 =?utf-8?B?VzVid3l5TXJBUHh2c1M4cG03UlhWQkIvbHRaRVY2WnJLdC9UTytsWFEwL3g3?=
 =?utf-8?B?eHdvSjdkTGRxRS9XWTlPM3hBUUkzRytSY3dzVnhIUWRteWN2ZDRkR0RacTNu?=
 =?utf-8?B?MVFoenlMQ1hlT2FzV1pxYUo5OVJUWnZIOTN5TEpuUDdPOVRlaVV4cDh1TTRn?=
 =?utf-8?B?OFEzTVpkT25kMG90YytIcGY3d1dMazNqcThQUmNpc0pxV05QaTUyenRNNVRI?=
 =?utf-8?B?Ty9Nd3FkaXVpV29OK0lrUlMzWGFzV3pqY2VQQkMwNU1JanU5WE5SamJaallN?=
 =?utf-8?B?YnRWbkZkbENaakJkVkFUL1BEQkdaNmpOWUZoU0lmYlo2QjhLUWhRdFpzY1Nu?=
 =?utf-8?B?YnliU1NEZmNQdWtlWjJtZ3FkSTl2Z21HUk81NVhhNXNJOVAyUHNUREtFQW5B?=
 =?utf-8?B?YnZSZXFOZGliZEJSV2F3L0tXejlkeWk4cjQwMENQK3dCUHRaMno0aTlCMXdz?=
 =?utf-8?B?WHNFajcwSlMyQ3RwTXFMNE9qZFJTRFQrN2hzZ2FxUFVHaDZ3U21xWUZab2N0?=
 =?utf-8?B?cmFiampaaWdoWE5oNmZ3VFNrOVd3MU5VYU5nNDB1WUM3dlIwVm8zenRsR2tD?=
 =?utf-8?B?NHhvQXhtcWZNMnUvNzRLbUs4bzl6ZkV0Vm1lVzE5SjJscjlwaWZONm1FT0dx?=
 =?utf-8?B?TytjLzk2Z1lwTzVuTWhSbk1XdVIzZFVTRWpJOU1CR1NSQUNWWlBIVkNVM0RE?=
 =?utf-8?B?SUxJTUIwNmE4bkpGNGV1T0ZQdStqdDJuYS96THdwZlQwaldUNTJoa1FSaEx0?=
 =?utf-8?B?dmh1N1VBYmpPWlpzNE1nVng2WXlRSFlJZHhvZ0pNZDdVdXhkSzBEM2ZrT0hK?=
 =?utf-8?B?aVczL2Uza25RQWFYR2ZyZm9TcnRFbHo3K2xHL1V4c1NjbkxkeG9jenNKc0Ny?=
 =?utf-8?B?cWpEK1VhVEVSVUpLc1FSa2psbHVuRHAxWEFuZkVXWEU4cUNYSDA0SzNhUE5a?=
 =?utf-8?B?TStXUnVyZTkya2hTY3ZhWk1SYWlLY0Qxb1hnbmFiVUdXYWhQOENoUUQ4L2pL?=
 =?utf-8?B?WEZFUkgyQzcwbzBOZUIzelRNVUhjZEhFcVJDNVdZK2tZVzBoRlJyRGxRb1Jl?=
 =?utf-8?B?NW9GTUJMTzRrVDBnYWpyNzEwa0hHOW00eTBHd2FRL2c5d2UxekV4MUdWQ2Vq?=
 =?utf-8?B?MC8xQVdGQjMrWEVMMnNsTUpNUTVzL1FMOEJZczkrbjBmMVRkNWM4UkNTbXE3?=
 =?utf-8?B?OGhwSHZsWFJIWUo1bThqQUUybEgzSlY1eDFiVXg3VENORnlmQXVvMHJDVElY?=
 =?utf-8?B?NGxHRjlvdTEwbWxBOGlEU2pwOWxMZDdDL01nY3UxMlpJUjk5YkJFaEdoSDg2?=
 =?utf-8?Q?+A8lzEMLkIbHiKnbaKrIgLli5yjefMGnciLTc1kc3+fkb?=
x-ms-exchange-antispam-messagedata-1: 88XPELXgiNAPWU8R5wa1pfozCmRJuD1aWVo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AF851BB400F0847BE6CE66F02990C91@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Mdj37xkFOPQcxm1wZtM1dESLdtWAsSrAg+t7lWALCWr8pwsMuDrebo00UoZeYHQQOD9ub5SQcSxWto//fiDARYJhhklug/gGRZp/2gbg2A2L2iJKJjnXayEBqD/4Z7EKl6ro5xh/wLTGFMGudY+hyq3YiEU5RDkzAxy5N4K8PGpoN0+gj6f3fnDsn9odWQ/JMKwa5Hms0f0X8O6ESl5of4qRa6oqFJtUAK425arfVSgUjimOG8gRAdQBzensMj1/q/xgcophdqbPCUwCcQN03jCFyOJ+UQrU3uRNju6CSXyPnpVbl1hMak5PUwPR3r21jRPZbXYGHeP/pWTss/QcSA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 54FcV/iMf15a0+UQ/Bbv/aEo24Lhylz+KbnIdBYr8EY/Qc2+Lpi1/zn26vyWzdDLbpR27pf6VJU/+Bmev5StrFxSei1ogOLrc5xHzCJxv/5D3sDcLCZ01DPQVRhIDFRhuPoQnagcqZYtcsG2qlK7x0M4/OePcOH0YOD+7Kw/VW/lzsWWKhnUNqtKEVKOtg5ensDYQ0uauQf26MAtA0i5eRZxnRB9m1/q9HsE1bE6H9myaidaZjYQgZt03O48LtQyaNuzgzPSqkUtC/WN0lESHTQn9fTDSgdZ3sfr1heLdoMplI6jh2PhGwW6IC++7gRFP4AfbJROr1qxhun45w4kk0VwkIg+vp30euBW4csOiLIV4UrdfLssXBCDl4bl/hEY4b8Ko/lgwsaLsNXjvMGeWCnWkBKhHC/D6Gr/9blPeH/MyPhfiKTamdjPi0BhSoqdiXnWXnU9z8M3Iyw4mVs9og/5o4Tp0RS/4MJhozCdk85n4agjmP+ro7QCd06qvVKNNHFkWGuApbDeijnYxKwnsPQ3TnDUDkx95wSenPAmZKVhe6kts8ukG0M4VLUcqMzjrd6dqUnU91DpZkifutDBypTnqFHKhUJa3Lzn2q2HCevHeTpJp8IexPdZqJgFvWCC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9351d6-584b-4544-7bbf-08df40754590
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:27:33.1524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmfbArUS+WpJ9DKHsn8Y2O4ovZs8XxK2ndyCw9OhniIZWPQrKmfF1I2jN+EKxeCwMfv4bq7hGdp+uAXbbjuviSyE8OHvRAEGdTe9TGR76Lc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7443
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTExLTA2IGF0IDEyOjQzICswODAwLCBaZXBoeXIgTGkgd3JvdGU6DQo+IFRo
ZSBTbXJubWkgc3BlY2lmaWNhdGlvbiwgc2VjdGlvbiA4LjUsICJSTk1JIE9wZXJhdGlvbiIsIHN0
YXRlczoNCj4gDQo+IMKgIElmIHRoZSBoYXJ0IGVuY291bnRlcnMgYW4gZXhjZXB0aW9uIHdoaWxl
IGV4ZWN1dGluZyBpbiBNLW1vZGUgd2l0aA0KPiB0aGUNCj4gwqAgbW5zdGF0dXMuTk1JRSBiaXQg
Y2xlYXIsIHRoZSBleGNlcHRpb24gaXMgYW4gUk5NSSBleGNlcHRpb24uIFRyYXANCj4gc3RhdGUN
Cj4gwqAgaXMgc3RpbGwgc2F2ZWQgaW4gdGhlIHJlZ3VsYXIgTS1tb2RlIENTUnMgYW5kIHRoZSBo
YW5kbGVyIHJldHVybnMNCj4gd2l0aA0KPiDCoCBNUkVULg0KPiANCj4gcmlzY3ZfY3B1X2RvX2lu
dGVycnVwdCgpIGluc3RlYWQgc2F2ZXMgRUxQIGluIG1uc3RhdHVzLk1OUEVMUCBvbiB0aGlzDQo+
IHBhdGguIE1SRVQgcmVzdG9yZXMgRUxQIGZyb20gbXN0YXR1cy5NUEVMUCwgc28gdGhlIGV4cGVj
dGVkIGxhbmRpbmctDQo+IHBhZA0KPiBzdGF0ZSBpcyBsb3N0Lg0KPiANCj4gQWx3YXlzIHNhdmUg
RUxQIGluIG1zdGF0dXMuTVBFTFAgZm9yIE0tbW9kZSBleGNlcHRpb25zLiBLZWVwIE1OUEVMUA0K
PiBmb3INCj4gdGhlIGFjdHVhbCBSTk1JIGludGVycnVwdCBwYXRoLCB3aGljaCByZXR1cm5zIHdp
dGggTU5SRVQuDQo+IA0KPiBBZGQgYSBUQ0cgdGVzdCB0aGF0IGNoZWNrcyBFTFAgcHJlc2VydmF0
aW9uIGFjcm9zcyBhbiBOTUlFPTAgTS1tb2RlDQo+IGV4Y2VwdGlvbiBhbmQgTVJFVC4NCj4gDQo+
IEZpeGVzOiAwMjY2ZmQ4YjU2YTQgKCJ0YXJnZXQvcmlzY3Y6IEFkZCBaaWNmaWxwIHN1cHBvcnQg
Zm9yIFNtcm5taSIpDQo+IFJlc29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9qZWN0
L3FlbXUvLS93b3JrX2l0ZW1zLzQyMjMNCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1ZSBC
YXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiBTaWduZWQtb2Zm
LWJ5OiBaZXBoeXIgTGkgPGZyaXRjaGxleWJvaHJlckBnbWFpbC5jb20+DQoNClRoYW5rcyENCg0K
QXBwbGllZCB0byByaXNjdi10by1hcHBseS5uZXh0DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IENo
YW5nZXMgaW4gdjM6DQo+IC0gUmViYXNlIG9udG8gY3VycmVudCBtYXN0ZXIuDQo+IC0gTW92ZSB0
ZXN0IHJlZ2lzdHJhdGlvbiBmcm9tIE1ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0IHRvDQo+IHN5c3Rl
bS9tZXNvbi5idWlsZCwNCj4gwqAgcHJlc2VydmluZyB0aGUgQ1BVIG9wdGlvbnMgYW5kIFJOTUkg
ZXhjZXB0aW9uIHZlY3Rvci4NCj4gLSBEaXNhYmxlIHRoZSB0ZXN0J3MgYnVpbGQgSUQgc28gdGhl
IGhhbmRsZXIgc3RheXMgYXQgMHg4MDAwMDEwMC4NCj4gLSBVcGRhdGUgdGhlIHRlc3QgY29tbWVu
dCB0byByZWZlciB0byBzeXN0ZW0vbWVzb24uYnVpbGQuDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0K
PiAtIFF1b3RlIHRoZSByZWxldmFudCBTbXJubWkgc3BlY2lmaWNhdGlvbiB0ZXh0IGluIHRoZSBj
b21taXQgbWVzc2FnZS4NCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9jcHVfaGVscGVyLmPCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgMTggKy0tLQ0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3N5c3Rl
bS9tZXNvbi5idWlsZMKgwqDCoCB8wqAgMTIgKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvdGVz
dC16aWNmaWxwLXNtcm5taS5TIHwgMTE3DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiDC
oDMgZmlsZXMgY2hhbmdlZCwgMTMxIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiDC
oGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LXppY2ZpbHAtc21ybm1p
LlMNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2NwdV9oZWxwZXIuYw0KPiBi
L3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+IGluZGV4IDU4ZTk4ZTk3NWMuLjMzZDZi
NDFjZWIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+ICsr
KyBiL3RhcmdldC9yaXNjdi90Y2cvY3B1X2hlbHBlci5jDQo+IEBAIC0yMzg2LDIzICsyMzg2LDkg
QEAgdm9pZCByaXNjdl9jcHVfZG9faW50ZXJydXB0KENQVVN0YXRlICpjcykNCj4gwqANCj4gwqDC
oMKgwqDCoMKgwqDCoCBzcmMgPSBlbnYtPnNlcGM7DQo+IMKgwqDCoMKgIH0gZWxzZSB7DQo+IC3C
oMKgwqDCoMKgwqDCoCAvKg0KPiAtwqDCoMKgwqDCoMKgwqDCoCAqIElmIHRoZSBoYXJ0IGVuY291
bnRlcnMgYW4gZXhjZXB0aW9uIHdoaWxlIGV4ZWN1dGluZyBpbiBNLQ0KPiBtb2RlDQo+IC3CoMKg
wqDCoMKgwqDCoMKgICogd2l0aCB0aGUgbW5zdGF0dXMuTk1JRSBiaXQgY2xlYXIsIHRoZSBleGNl
cHRpb24gaXMgYW4NCj4gUk5NSSBleGNlcHRpb24uDQo+IC3CoMKgwqDCoMKgwqDCoMKgICovDQo+
IC3CoMKgwqDCoMKgwqDCoCBubm1pX2V4Y2VwID0gY3B1LT5jZmcuZXh0X3Ntcm5taSAmJg0KPiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAhZ2V0X2ZpZWxkKGVudi0+
bW5zdGF0dXMsIE1OU1RBVFVTX05NSUUpICYmDQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgICFhc3luYzsNCj4gLQ0KPiAtwqDCoMKgwqDCoMKgwqAgLyogaGFuZGxl
IHRoZSB0cmFwIGluIE0tbW9kZSAqLw0KPiAtwqDCoMKgwqDCoMKgwqAgLyogc2F2ZSBlbHAgc3Rh
dHVzICovDQo+ICvCoMKgwqDCoMKgwqDCoCAvKiBTYXZlIEVMUCBmb3IgTVJFVC4gKi8NCj4gwqDC
oMKgwqDCoMKgwqDCoCBpZiAoY3B1X2dldF9mY2ZpZW4oZW52KSkgew0KPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAobm5taV9leGNlcCkgew0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGVudi0+bW5zdGF0dXMgPSBzZXRfZmllbGQoZW52LT5tbnN0YXR1cywNCj4gTU5TVEFU
VVNfTU5QRUxQLA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbnYtPmVscCk7DQo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7DQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZW52LT5tc3RhdHVzID0gc2V0X2ZpZWxkKGVudi0+bXN0YXR1cywNCj4gTVNUQVRV
U19NUEVMUCwgZW52LT5lbHApOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGVudi0+bXN0YXR1cyA9IHNldF9maWVsZChlbnYtPm1zdGF0dXMs
IE1TVEFUVVNfTVBFTFAsDQo+IGVudi0+ZWxwKTsNCj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+IMKg
DQo+IMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJpc2N2X2hhc19leHQoZW52LCBSVkgpKSB7DQo+IGRp
ZmYgLS1naXQgYS90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gYi90ZXN0
cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gaW5kZXggM2M4YjAxOGQ5ZS4uZWU0
NjgwZjAxNyAxMDA2NDQNCj4gLS0tIGEvdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1
aWxkDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBAQCAt
ODksNiArODksMTggQEAgdGVzdHMgKz0gew0KPiDCoMKgIH0NCj4gwqB9DQo+IMKgDQo+ICt0ZXN0
cyArPSB7DQo+ICvCoCAndGVzdC16aWNmaWxwLXNtcm5taS5TJzogc2V0dXAgKyB7DQo+ICvCoMKg
wqAgIyBLZWVwIC5vcmcgMHgxMDAgYXQgdGhlIGNvbmZpZ3VyZWQgUk5NSSBleGNlcHRpb24gdmVj
dG9yLg0KPiArwqDCoMKgICdjZmxhZ3MnOiBjZmxhZ3MgKyBbJy1XbCwtLWJ1aWxkLWlkPW5vbmUn
XSwNCj4gK8KgwqDCoCAncWVtdV9hcmdzJzogWw0KPiArwqDCoMKgwqDCoCAnLWNwdScsICdydjY0
LHppY3NyPXRydWUsemljZmlscD10cnVlLHNtcm5taT10cnVlJywNCj4gK8KgwqDCoMKgwqAgJy1n
bG9iYWwnLCAncnY2NC1yaXNjdi1jcHUucm5taS1leGNlcHRpb24tdmVjdG9yPTB4ODAwMDAxMDAn
LA0KPiArwqDCoMKgwqDCoCBxZW11X2FyZ3MsDQo+ICvCoMKgwqAgXSwNCj4gK8KgIH0sDQo+ICt9
DQo+ICsNCj4gwqBpZiAncWVtdS1zeXN0ZW0tcmlzY3Y2NCcgaW4gZW11bGF0b3JzDQo+IMKgwqAg
dGNnX3Rlc3RzICs9IHsNCj4gwqDCoMKgwqAgJ3Jpc2N2NjQtc29mdG1tdSc6IHsNCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtemljZmlscC1zbXJubWkuUw0KPiBiL3Rlc3Rz
L3RjZy9yaXNjdjY0L3Rlc3QtemljZmlscC1zbXJubWkuUw0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwLi4xZGNkMDEyMDBjDQo+IC0tLSAvZGV2L251bGwNCj4gKysr
IGIvdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC16aWNmaWxwLXNtcm5taS5TDQo+IEBAIC0wLDAgKzEs
MTE3IEBADQo+ICsvKg0KPiArICogVGVzdCB0aGF0IGFuIE0tbW9kZSBleGNlcHRpb24gdGFrZW4g
d2l0aCBtbnN0YXR1cy5OTUlFIGNsZWFyDQo+IHNhdmVzIEVMUCBpbg0KPiArICogbXN0YXR1cy5N
UEVMUCwgc28gdGhhdCBpdCBpcyByZXN0b3JlZCBieSBNUkVULsKgIE1OUEVMUCBpcw0KPiByZXNl
cnZlZCBmb3IgdGhlDQo+ICsgKiBhY3R1YWwgUk5NSSBwYXRoLCB3aGljaCByZXR1cm5zIHdpdGgg
TU5SRVQuDQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXINCj4gKyAqLw0KPiArDQo+ICsJLm9wdGlvbglub3J2Yw0KPiArDQo+ICsJLmVxdQlDU1Jf
TU5TVEFUVVMsIDB4NzQ0DQo+ICsJLmVxdQlDU1JfTVNFQ0NGRywgMHg3NDcNCj4gKwkuZXF1CU1O
U1RBVFVTX05NSUUsIDEgPDwgMw0KPiArCS5lcXUJTU5TVEFUVVNfTU5QRUxQLCAxIDw8IDkNCj4g
KwkuZXF1CU1TRUNDRkdfTUxQRSwgMSA8PCAxMA0KPiArCS5lcXUJTVNUQVRVU19NUEVMUCwgMSA8
PCA0MQ0KPiArCS5lcXUJRVhDUF9JTlNUX0FDQ0VTU19GQVVMVCwgMQ0KPiArCS5lcXUJRVhDUF9T
V19DSEVDSywgMTgNCj4gKwkuZXF1CVNXX0NIRUNLX0ZDRklfVFZBTCwgMg0KPiArDQo+ICsJLnRl
eHQNCj4gKwkuZ2xvYmFsCV9zdGFydA0KPiArX3N0YXJ0Og0KPiArCS8qIFZlcmlmeSB0aGF0IE5N
SUUgaXMgY2xlYXIgYmVmb3JlIGV4ZXJjaXNpbmcgdGhlIGV4Y2VwdGlvbg0KPiBwYXRoLiAqLw0K
PiArCWNzcnIJdDAsIENTUl9NTlNUQVRVUw0KPiArCWFuZGkJdDAsIHQwLCBNTlNUQVRVU19OTUlF
DQo+ICsJYm5legl0MCwgZmFpbF9ubWllDQo+ICsNCj4gKwkvKiBFbmFibGUgbGFuZGluZy1wYWQg
Y2hlY2tzIGluIE0tbW9kZSwgdGhlbiBzdGFydCBhIG5ldyBUQi4NCj4gKi8NCj4gKwlsaQl0MCwg
TVNFQ0NGR19NTFBFDQo+ICsJY3NycwlDU1JfTVNFQ0NGRywgdDANCj4gKwlqCXRyYWNrZWRfanVt
cA0KPiArDQo+ICt0cmFja2VkX2p1bXA6DQo+ICsJLyogTWFrZSBhIFppY2ZpbHAtdHJhY2tlZCBp
bmRpcmVjdCBqdW1wIHRvIGFuIGFkZHJlc3MgdGhhdA0KPiBmYXVsdHMuICovDQo+ICsJbGkJdDEs
IDANCj4gKwlqYWxyCXplcm8sIDAodDEpDQo+ICsNCj4gKwkvKg0KPiArCSAqIFRoZSBpbnN0cnVj
dGlvbiBhY2Nlc3MgZmF1bHQgc2hvdWxkIGhhdmUgcmVkaXJlY3RlZCB0bw0KPiB0aGUgaGFuZGxl
ci4NCj4gKwkgKi8NCj4gKwlsaQlhMCwgMQ0KPiArCWoJX2V4aXQNCj4gKw0KPiArZmFpbF9ubWll
Og0KPiArCWxpCWEwLCA2DQo+ICsJaglfZXhpdA0KPiArDQo+ICsJLyogTXVzdCBtYXRjaCBybm1p
LWV4Y2VwdGlvbi12ZWN0b3IgaW4gc3lzdGVtL21lc29uLmJ1aWxkLg0KPiAqLw0KPiArCS5vcmcJ
MHgxMDANCj4gK3JubWlfZXhjZXB0aW9uOg0KPiArCWNzcnIJdDAsIG1jYXVzZQ0KPiArCWxpCXQx
LCBFWENQX0lOU1RfQUNDRVNTX0ZBVUxUDQo+ICsJYmVxCXQwLCB0MSwgaGFuZGxlX2ZldGNoX2Zh
dWx0DQo+ICsJbGkJdDEsIEVYQ1BfU1dfQ0hFQ0sNCj4gKwliZXEJdDAsIHQxLCBoYW5kbGVfc3df
Y2hlY2sNCj4gKw0KPiArCWxpCWEwLCA0DQo+ICsJaglfZXhpdA0KPiArDQo+ICtoYW5kbGVfZmV0
Y2hfZmF1bHQ6DQo+ICsJLyogVGhpcyBpcyBhbiBNLW1vZGUgZXhjZXB0aW9uIGFuZCB3aWxsIHJl
dHVybiB3aXRoIE1SRVQuICovDQo+ICsJY3Nycgl0MCwgbXN0YXR1cw0KPiArCWxpCXQxLCBNU1RB
VFVTX01QRUxQDQo+ICsJYW5kCXQwLCB0MCwgdDENCj4gKwliZXF6CXQwLCBmYWlsX21wZWxwDQo+
ICsNCj4gKwljc3JyCXQwLCBDU1JfTU5TVEFUVVMNCj4gKwlhbmRpCXQwLCB0MCwgTU5TVEFUVVNf
TU5QRUxQDQo+ICsJYm5legl0MCwgZmFpbF9tbnBlbHANCj4gKw0KPiArCWxsYQl0MCwgcmVzdW1l
X25vbl9scGFkDQo+ICsJY3NydwltZXBjLCB0MA0KPiArCW1yZXQNCj4gKw0KPiArcmVzdW1lX25v
bl9scGFkOg0KPiArCS8qIE1SRVQgbXVzdCByZXN0b3JlIEVMUCwgc28gdGhpcyBpbnN0cnVjdGlv
biBtdXN0IG5vdA0KPiByZXRpcmUuICovDQo+ICsJbGkJYTAsIDENCj4gKwlqCV9leGl0DQo+ICsN
Cj4gK2hhbmRsZV9zd19jaGVjazoNCj4gKwljc3JyCXQwLCBtdHZhbA0KPiArCWxpCXQxLCBTV19D
SEVDS19GQ0ZJX1RWQUwNCj4gKwlibmUJdDAsIHQxLCBmYWlsX3R2YWwNCj4gKw0KPiArCWxpCWEw
LCAwDQo+ICsJaglfZXhpdA0KPiArDQo+ICtmYWlsX21wZWxwOg0KPiArCWxpCWEwLCAyDQo+ICsJ
aglfZXhpdA0KPiArDQo+ICtmYWlsX21ucGVscDoNCj4gKwlsaQlhMCwgMw0KPiArCWoJX2V4aXQN
Cj4gKw0KPiArZmFpbF90dmFsOg0KPiArCWxpCWEwLCA1DQo+ICsNCj4gK19leGl0Og0KPiArCWxs
YQlhMSwgc2VtaWFyZ3MNCj4gKwlsaQl0MCwgMHgyMDAyNgkvKiBBRFBfU3RvcHBlZF9BcHBsaWNh
dGlvbkV4aXQgKi8NCj4gKwlzZAl0MCwgMChhMSkNCj4gKwlzZAlhMCwgOChhMSkNCj4gKwlsaQlh
MCwgMHgyMAkvKiBUQVJHRVRfU1lTX0VYSVRfRVhURU5ERUQgKi8NCj4gKw0KPiArCS8qIFNlbWlo
b3N0aW5nIGNhbGwgc2VxdWVuY2UuICovDQo+ICsJLmJhbGlnbgkxNg0KPiArCXNsbGkJemVybywg
emVybywgMHgxZg0KPiArCWVicmVhaw0KPiArCXNyYWkJemVybywgemVybywgMHg3DQo+ICsJagku
DQo+ICsNCj4gKwkuZGF0YQ0KPiArCS5iYWxpZ24JMTYNCj4gK3NlbWlhcmdzOg0KPiArCS5zcGFj
ZQkxNg0K

