Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE40FCC9CA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzqFh-0002YG-Eo; Tue, 10 Mar 2026 02:07:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzqFe-0002Xz-OJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:07:30 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@bull.com>)
 id 1vzqFY-0007ZG-UP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=bull.com; i=@bull.com; q=dns/txt; s=mail;
 t=1773122845; x=1804658845;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L4OYmWle6MImiu3sX7ikNO6+xqADbOQSIsf2vFHBCuw=;
 b=Y+gKOnXGAMrH8Q8n3zLBSJ6NSj7HmjD+92myAj0kGq8nsMxc9KIHcDc3
 JfM0GmJgiil7+JIHjabJ3c4TAwYaup4fR3LAeeF9t+y1FqmOOolAaNm1V
 IxARLEf5WasPGMJcd03IuSIwYUg0Tjw524A/LJ/klfG6dSJf8h/QThqoX
 eQ+XQAP7+siWVXz4egyv48mi2EN41DeRRx22zJzcAgp7hHpM8UjJJI5B2
 cfdx2ZP0ntAzYVKwaLV1FovXWT1fNRASJbPb2GMpB52Ufixf6LNprBuSz
 57DWWP8PYlLdQk4xoAzY+3gcDWDqQMdHLp63ZglrI328clOFJBkiyh+du w==;
X-CSE-ConnectionGUID: yQvDwMYqSnWz28UaRufDJA==
X-CSE-MsgGUID: hD5htrQsScWbKPvfbTh1cw==
IronPort-SDR: 69afb518_TjnBSuecidpx2qXoh1izcAlnVBMnRYPLi9xwfRWNhrfp9ej
 sqTdbqyZQrTBVTl81V+n6iOAlREr0/qLIBWorFw==
X-IronPort-AV: E=Sophos;i="6.23,111,1770591600"; d="scan'208";a="46925479"
X-MGA-submission: =?us-ascii?q?MDEGGi+AOP6xMx2zcPr0fDr2QgD90Vda6dOBHt?=
 =?us-ascii?q?k7naUP+ED1XUgow83r9s8GHlB1OZp/AvUVOQfb7Ml/wOQiASr4UyLsuu?=
 =?us-ascii?q?1WzIoB5UVJVuFdayVkeMS5pbitbqlgIzza2+rPefe47phtISQZHAPEjf?=
 =?us-ascii?q?/PftIZGUujWQ0Vf+F6ce6PKg=3D=3D?=
Received: from mail-swedencentralazon11013069.outbound.protection.outlook.com
 (HELO GVXPR05CU001.outbound.protection.outlook.com) ([52.101.83.69])
 by smarthost1.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 10 Mar 2026 07:07:19 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4Cv6dNdVHrxYqRJGw+Geu7nKHAPaxv9zoPfBKmG1Lg9z25RoIeUg30sHvYj/f08Vi9cCkfZIS2qZm9Bj8JRqcUgcEVDuYqXOAcAvOSdnLiqkEAV4D0pbipdZaCbWReJxbIwBn472RnyJrwixLhYDaEKTASZDeGYBGHTSkyISqN4u/O151DBKfNBdVCuXTMtwlPi8DFQvHWX+C16wJnkwq3c6AcyG05tJzLl51M3VUEvbJOFvJ3aTo5ZRPAK7q15bmWwVnHMBFeiooxKht1A4i72B7wTou9xrbzh5w6IRsqBWvgMW5FC395aWtXHa26pMzULymHInCIZuIvATsgBow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4OYmWle6MImiu3sX7ikNO6+xqADbOQSIsf2vFHBCuw=;
 b=wRXCLEqaaxgTPOwpgd+SNDn2rSabTc1A3Y0EAi0HCQN8dRVKm9hftOEK5fkf1kJhAA56FTyfIMtaVkN/1OL/4JCsiy1KPQuUthjkuibOdxREA+e2CXXBeVREC+JGJ54swUvwwmGK3oQap6V59U4acP772Sqp5MbYg9GEFxi/0hcFK/0nKth8LYDtkgtRdEx8ZmFIrCMENve6YJioi9zAf6bDcZvc6A+25+wgUAw1a3AX1s/5Y1tbAc08dG2b/WHqhbU1cLqo+CobQjiIMJQG4Tz7RZ9qUG3nwsNKFaVMMkU6AtghIQ7JymYgax0Q1l1X7q5R99IHnr6Whtc0o79zpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bull.com; dmarc=pass action=none header.from=bull.com;
 dkim=pass header.d=bull.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM8PR07MB7346.eurprd07.prod.outlook.com (2603:10a6:20b:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 06:07:17 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::4b08:9add:5e19:eaaf%6]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 06:07:17 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Zhao Liu <zhao1.liu@intel.com>, Yi Liu <yi.l.liu@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@bull.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 06/10] hw/i386/iommu: Remove IntelIOMMUState::dma_drain
 field
Thread-Topic: [PATCH v2 06/10] hw/i386/iommu: Remove
 IntelIOMMUState::dma_drain field
Thread-Index: AQHcr9Qmf5rD7qU5XEqV7YGkjIWFmrWnSIIA
Date: Tue, 10 Mar 2026 06:07:17 +0000
Message-ID: <4e301c9265d82c51dc795cce0195b8b7d8928be3.camel@eviden.com>
References: <20260309145013.44327-1-philmd@linaro.org>
 <20260309145013.44327-7-philmd@linaro.org>
In-Reply-To: <20260309145013.44327-7-philmd@linaro.org>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM8PR07MB7346:EE_
x-ms-office365-filtering-correlation-id: 6272aeda-a962-4661-d32c-08de7e6b48b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|7053199007|18082099003;
x-microsoft-antispam-message-info: hHz77elNJkaXsVSekThKOKolUhq0rCh04/+UDFotBz2n8nUEMJKpKJG19T6JAcyaNuQsjWx/tPOtZnDj0GbvAIUH81yV5uVPKpE2Q1//9FkNXLxIdYhCg+fnxo8ovaltXBqqH+4Oe9Tfhfv1j4jtlhnJ9zyUu6YPBxyB+BCEEcIp4fUESDOLWcn+pVkg+JkqBP6HzdYOxx3E2r48EvMUKlsRiyOADV/mCkzNBiybNG4uE/2sTKUcoCeKUgUIQZHYENnh/QBEi0HaZPGXqud9tu3QcRqFKjkNT3c3Zlp8m+kOGbWqfGk4uqGEAMdxNkeMhBvc0jQ10uaLJyGUDhifA87abpuIkUkytMq5bbm671EyqWoU6vfwotRRqqLM/RUZ5+ATyWviXAOFc1IJFQLPOzAmiSFaXLKvfwOt3jHNE1ksej47S3Gpwh4XvQDoPvaPqzk0jXeej28eVuuNbit0djg+zFa7GmA/V4OZF26cirZdnZW8+JwnmoIMb8zyO/4cNqPInmi2Y3QSF0MesmtbMMgj4MLcLTj9GQBy8IZ7SCjx3n7Ql4KQBNmY8HY3Zy5+05VbCgWUYa9HPoJUe4bj77PX/eUv+XH8Vl9OefifokF7IPm6/smc4LBdXTu4KvzyXaIN4kcxrzAMgKgVCdFFD0ktndgHngpqpvZc7MSPnorPu8epIBvvPq6jxOs7DKHC1Z1qjKhBmgT6Gb8DILOg4tVuy+JJ3efzwIkip8gHISqUtHei9SwocU73o+FHyayO1xoTCYcW8EdF0ZjjzdNzegfrnY3/onQ2o7wbl7SjqY8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(7053199007)(18082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFdOdmlMN0Rma3UzVm5jWjBzWndFLzNHWnZub2lJOUQvcEw4MzBDQ3YyQW1U?=
 =?utf-8?B?eGhKdzRueHVRNjRZMkd6M2JJSUpZK2cveE8zR3Jrb3lNU3dqQlNRdGRJUlpH?=
 =?utf-8?B?NVVsb3lNWTZmZS80TlZBU2t4cUNjZUQycUhwT3dNWDJkR1J4NDN5T0JadHFO?=
 =?utf-8?B?aytTSWN1eTYrVGpjZE9kUi9wSlZ1SzlyS210RlFDQmFVYWZ2a3BLWjFFcTVy?=
 =?utf-8?B?aWl2WjNqQnJsTlExazdvTkFKRWV1ZFNza3dMSWhmS3FHTXFKT085RUFSaFhT?=
 =?utf-8?B?eVdVeUtwclBCQUdSeGM0eENZK1V0elBMTVIvUHFQOEdnaGZGMnd5WUwzL3Nh?=
 =?utf-8?B?dzFwdVZ2MmdsOFFMWnUwYUNlMFdtOVh3OGIzYkRGcm1kb1Z3a2ZvUlI2Mm1j?=
 =?utf-8?B?QWV5bEJPMUpnWHZBeEs3S25IZmhqUmhjcklsWE9BWDhTYzNpcTk3bW9IbWZM?=
 =?utf-8?B?Rmt6M1IrRkJDbUJOSzFVSzJsQnFFOEltMGlrTXkrb2tCUkNGS0wxdzJ6YVVO?=
 =?utf-8?B?VXNIT045SmFLK0Z5Sk8yY2RibHk5NG5oNUhWbDF6VnNXa2V3Q2NyY2huSjFz?=
 =?utf-8?B?TVhDMjAzMjBFNmlHTHdlMDVuVkRWMHN0YjZJZEpaak1ZcXVIVm9NWGMrU3pD?=
 =?utf-8?B?RGNYM092OG0wNHBYbkpjRGZzSW1DeXlYMkQ1bHRKUUlNSWcrOThIaWJNZFlu?=
 =?utf-8?B?S1lXQ2p2SkhMakJVUFhrMlczbEw1RDR1Ujh1bGpId04yVmRLUGFWTk50Zk9P?=
 =?utf-8?B?SGNzbXhNVUVveWZTUXJxV0tFN3drR1lLaU84SWtNWmhXZ0dHbnhyMnhnMjU5?=
 =?utf-8?B?cEdFRjlsMENVN3R1VmVkQjZIVmpRUmVuRFphTE9lTE1nUElCVUJRK3JjSWtM?=
 =?utf-8?B?VWhQa1kwUkYraXNUZGQ2NEpXT1o1VEVFbG43NjRuMHQ3WnFxbTlKRURXVjls?=
 =?utf-8?B?R1piUjFuNjNvQUMzZnlIMkRMMkJGOFVLTW5KRVZ1WGpqN3BJL1QraVltUGsx?=
 =?utf-8?B?S2tVRjk2eTNoRTZQbVdKeWtNV0xTQnEyVVFyUHlDR2xPQ2VmNTVucnRZSDJj?=
 =?utf-8?B?V2FRT3BjekN3RmdVNWZaOEovd3RKU3lkZ3lrUzFqMGUyc1hlbnZzbFlsWEFs?=
 =?utf-8?B?YWJDcjdQWE0xUXV4aXFkeUdXSUU2WUxWTmVkNzErVmlyL08xK3NYRmlQY2Z1?=
 =?utf-8?B?ckgzeWVtWmsyNjNBVFRqNStRaWU1eEhEb0lBWEpZMzM0Q3VpRVFiS0UvYTBV?=
 =?utf-8?B?Zm1NeHA0aXpIUUtlUldMZ3RlbmJVRTM1OENaNU9jWHdxRWRFL1c0a1FOZU92?=
 =?utf-8?B?eG1qdlZIbnIrYnR4Sk12bjdhVXJkT09jQWF1WEFrbzAxakpEY2JEWEQ2RXJL?=
 =?utf-8?B?a2kybGROeHZaVnYxRU9Sd2NJcG1FZmVveUJ1eE1yaW8zUFkxcE8yRUs0Zmxo?=
 =?utf-8?B?aFhIbCtSb1R5c2dIYzJodkpKb3RpeGtrVzhrMlUyRWo1REV2TC9PSE1mNm9i?=
 =?utf-8?B?UHo5OUlBNHM5TzY2QjBCRGZiLytBZEREVGM2TGxhbkpTekJIZGVNTUg3ZDlH?=
 =?utf-8?B?OVpsZEY1dGxMZWg1d3VtdnRiQllISzhQdlI5Tkh3K3YyV2hjT09BUGJJQ2tK?=
 =?utf-8?B?OHlsS1VPc0JlQ3M5V21DQk9XWHcxMVB0VTZPNGZEQzUwZElFYWRtaXpiaUZ0?=
 =?utf-8?B?L0xDV2NtYlRZcEFnaGlpeS9QSEx3S3p1TnkyZjJoZGFhZ2pWSmVnOWxoZkx5?=
 =?utf-8?B?UStVNXZvY21VaStPMmxGZVZ3MS9rakg2QW83ZTc0R1dGQmVBamdOZkxnMmtu?=
 =?utf-8?B?aHJ4VGhHRWp6cVpUUFVGU0t4RldYbGFtOVZUSW9xZjEwQ3l0ZTQ1WHBUL0t3?=
 =?utf-8?B?UzVTdkpMUXZkcldzUyttM2FiRlVQcStWS0FqQ3RJeFljcHlsd3drcUVtSlRY?=
 =?utf-8?B?cVJDZHljbHo0NmovRk9vSFJld1UvaGQ5c0dLeGNFK1hNUDRWZEVhKzN0VHdO?=
 =?utf-8?B?UFRsbkdFNEV4cUhZTnovMDI0TW4xbkFzckxxUDNjOFRHcUM5aFcyVW1RQURu?=
 =?utf-8?B?ZnpzTW4ra0ZGczNvcjQybThKZ3ZpSmdVMXhsSEJ0aWdycTJwRmh5NnNaSFhH?=
 =?utf-8?B?T0dxdzVVTlpEckRocjlhOENiNzN1bUFKZWtkVWl2SmlKMi9xcCs5aENxTFNT?=
 =?utf-8?B?aHA0MGJ0TWUwUVdDcGFRZTc0UVZjT0N3T3dlRlcxWVYrWXFPSDZrUmcveVUr?=
 =?utf-8?B?cDQvOStQWCtPTnh6bm4vU29ac1Iwd2x2MkpmdElVa3JJWVhoWlFWRE50ZFpu?=
 =?utf-8?B?d2UrUnZjWEFiQmJBRXVVVXZEVWdjdWZYU3llNjRwQTVuaWpJQXZndDZ5Y1JK?=
 =?utf-8?Q?GXPO/gZCu0qzyjQPk0MRC22SwAkBQHQMlndRG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48D63D9CE6DC534084C4B1ABFCEF7BDA@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZPoYtjUwfpUKaDJW9kqQ7gM2VUIa4PcAPEKThi0x9ZYGgSmleKIzXjkvWRxxt6khpiKxe3g78IWqG+r4sYjOPswVJskma9QJtCDgcddUs0zk0D5PtoEPZdR8sZgCg+LUMG+iLMK7ZypVIu0UJZn/HZgs/N4oFc6D+eMhd1Sg+blafW9TH2jx9/LyVIrW79oDl8kVp/KhH/p4Pc9BNhjsmy3vxYGSRfs9uoQi5xnP8eq2VsLaCUUvXEE9exs8BcQk3dNpYC6vV7HPjEq7bUOygrIlbk4y2Ljr9Yngl498U3wIJJ2CV/uZq6qHEa9LYfqNhZEsSwNbuJ5AAiLvAC+2gg==
X-OriginatorOrg: bull.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6272aeda-a962-4661-d32c-08de7e6b48b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 06:07:17.8960 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJ3px5fZtmjAHo1IPjWn3HTazza8xCV5CWcaa+oGgP2YNESFEw0yBe09vqX3OqTFmbBM1+6QKl1MUGhFgtvvLCo2kEBXo8FEq/cTJLo80phxdsCMcO3fRG99PSYMU+n2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7346
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@bull.com; helo=smarthost1.eviden.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

SGkgUGhpbCwKClRoYW5rcyBmb3IgdGhhdCEKClJldmlld2VkLWJ5OiBDbGVtZW50IE1hdGhpZXUt
LURyaWYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4KCk9uIE1vbiwgMjAyNi0wMy0w
OSBhdCAxNTo1MCArMDEwMCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6Cj4gVGhlIElu
dGVsSU9NTVVTdGF0ZTo6ZG1hX2RyYWluIGJvb2xlYW4gd2FzIG9ubHkgc2V0IGluICAKPiB0aGUg
cGNfY29tcGF0XzNfMVtdIGFycmF5LCB2aWEgdGhlICdkbWEtZHJhaW49b2ZmJyBwcm9wZXJ0eS4g
IAo+IFdlIHJlbW92ZWQgYWxsIG1hY2hpbmVzIHVzaW5nIHRoYXQgYXJyYXksIGxldHMgcmVtb3Zl
IHRoYXQgIAo+IHByb3BlcnR5IGFuZCBhbGwgdGhlIGNvZGUgYXJvdW5kIGl0Lgo+IAo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxbcGhpbG1kQGxpbmFyby5vcmddKG1h
aWx0bzpwaGlsbWRAbGluYXJvLm9yZyk+ICAKPiBSZXZpZXdlZC1ieTogVGhvbWFzIEh1dGggPFt0
aHV0aEByZWRoYXQuY29tXShtYWlsdG86dGh1dGhAcmVkaGF0LmNvbSk+ICAKPiBNZXNzYWdlLUlk
OiA8WzIwMjYwMzA3MTUyNjM1LjgzODkzLTctcGhpbG1kQGxpbmFyby5vcmddKG1haWx0bzoyMDI2
MDMwNzE1MjYzNS44Mzg5My03LXBoaWxtZEBsaW5hcm8ub3JnKT4gIAo+IC0tLSAgCj4gwqBpbmNs
dWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaCB8wqAgMSAtICAKPiDCoGh3L2kzODYvaW50ZWxfaW9t
bXUuY8KgwqDCoMKgwqDCoMKgwqAgfCAxMSArLS0tLS0tLS0tLSAgCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxMSBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggYi9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUu
aCAgCj4gaW5kZXggNTRjMmI2Yjc3YTAuLmU0NGNlMzE4NDE3IDEwMDY0NCAgCj4gLS0tIGEvaW5j
bHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmggIAo+ICsrKyBiL2luY2x1ZGUvaHcvaTM4Ni9pbnRl
bF9pb21tdS5oICAKPiBAQCAtMzE0LDcgKzMxNCw2IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUg
eyAgCj4gwqDCoMKgwqAgYm9vbCBpbnRyX2VpbWU7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLyogRXh0ZW5kZWQgaW50ZXJydXB0IG1vZGUgZW5hYmxlZCAqLyAgCj4gwqDCoMKgwqAg
T25PZmZBdXRvIGludHJfZWltO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBUb2dnbGUgZm9y
IEVJTSBjYWJhYmlsaXR5ICovICAKPiDCoMKgwqDCoCB1aW50OF90IGF3X2JpdHM7wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEhvc3QvSU9WQSBhZGRyZXNzIHdpZHRoIChpbiBiaXRz
KSAqLyAgCj4gLcKgwqDCoCBib29sIGRtYV9kcmFpbjvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBXaGV0aGVyIERNQSByL3cgZHJhaW5pbmcgZW5hYmxlZCAqLyAgCj4gwqDCoMKg
wqAgYm9vbCBwYXNpZDvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8q
IFdoZXRoZXIgdG8gc3VwcG9ydCBQQVNJRCAqLyAgCj4gwqDCoMKgwqAgYm9vbCBmczFncDvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEZpcnN0IFN0YWdlIDEtR0J5
dGUgUGFnZSBTdXBwb3J0ICovICAKPiDCoCAgCj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxf
aW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYyAgCj4gaW5kZXggZDI0YmE5ODliZmMuLmYz
OTVmYTI0OGMwIDEwMDY0NCAgCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAKPiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMgIAo+IEBAIC00MjA1LDcgKzQyMDUsNiBAQCBzdGF0aWMg
Y29uc3QgUHJvcGVydHkgdnRkX3Byb3BlcnRpZXNbXSA9IHsgIAo+IMKgwqDCoMKgIERFRklORV9Q
Uk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29wX2NvbnRyb2ws
IGZhbHNlKSwgIAo+IMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woIngtcGFzaWQtbW9kZSIsIElu
dGVsSU9NTVVTdGF0ZSwgcGFzaWQsIGZhbHNlKSwgIAo+IMKgwqDCoMKgIERFRklORV9QUk9QX0JP
T0woInN2bSIsIEludGVsSU9NTVVTdGF0ZSwgc3ZtLCBmYWxzZSksICAKPiAtwqDCoMKgIERFRklO
RV9QUk9QX0JPT0woImRtYS1kcmFpbiIsIEludGVsSU9NTVVTdGF0ZSwgZG1hX2RyYWluLCB0cnVl
KSwgIAo+IMKgwqDCoMKgIERFRklORV9QUk9QX0JPT0woInN0YWxlLXRtIiwgSW50ZWxJT01NVVN0
YXRlLCBzdGFsZV90bSwgZmFsc2UpLCAgCj4gwqDCoMKgwqAgREVGSU5FX1BST1BfQk9PTCgiZnMx
Z3AiLCBJbnRlbElPTU1VU3RhdGUsIGZzMWdwLCB0cnVlKSwgIAo+IMKgfTsgIAo+IEBAIC01MDAw
LDExICs0OTk5LDggQEAgc3RhdGljIHZvaWQgdnRkX2NhcF9pbml0KEludGVsSU9NTVVTdGF0ZSAq
cykgIAo+IMKgwqDCoMKgIFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJ
Q0Uocyk7ICAKPiDCoCAgCj4gwqDCoMKgwqAgcy0+Y2FwID0gVlREX0NBUF9GUk8gfCBWVERfQ0FQ
X05GUiB8IFZURF9DQVBfTkQgfCBWVERfRUNBUF9QVCB8ICAKPiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIFZURF9DQVBfTUFNViB8IFZURF9DQVBfUFNJIHwgVlREX0NBUF9TU0xQUyB8ICAKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFZURF9DQVBfTUFNViB8IFZURF9DQVBfUFNJIHwgVlRE
X0NBUF9TU0xQUyB8IFZURF9DQVBfRFJBSU4gfCAgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgVlREX0NBUF9FU1JUUFMgfCBWVERfQ0FQX01HQVcocy0+YXdfYml0cyk7ICAKPiAtwqDCoMKg
IGlmIChzLT5kbWFfZHJhaW4pIHsgIAo+IC3CoMKgwqDCoMKgwqDCoCBzLT5jYXAgfD0gVlREX0NB
UF9EUkFJTjsgIAo+IC3CoMKgwqAgfSAgCj4gwqDCoMKgwqAgaWYgKHg4Nl9pb21tdS0+ZG1hX3Ry
YW5zbGF0aW9uKSB7ICAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHMtPmF3X2JpdHMg
Pj0gVlREX0hPU1RfQVdfMzlCSVQpIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcy0+Y2FwIHw9IFZURF9DQVBfU0FHQVdfMzliaXQ7ICAKPiBAQCAtNTU4Miwx
MSArNTU3OCw2IEBAIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0
ZSAqcywgRXJyb3IgKiplcnJwKSAgCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7ICAK
PiDCoMKgwqDCoCB9ICAKPiDCoCAgCj4gLcKgwqDCoCBpZiAocy0+c2NhbGFibGVfbW9kZSAmJiAh
cy0+ZG1hX2RyYWluKSB7ICAKPiAtwqDCoMKgwqDCoMKgwqAgZXJyb3Jfc2V0ZyhlcnJwLCAiTmVl
ZCB0byBzZXQgZG1hX2RyYWluIGZvciBzY2FsYWJsZSBtb2RlIik7ICAKPiAtwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIGZhbHNlOyAgCj4gLcKgwqDCoCB9ICAKPiAtICAKPiDCoMKgwqDCoCBpZiAocy0+
cGFzaWQgJiYgIXMtPnNjYWxhYmxlX21vZGUpIHsgIAo+IMKgwqDCoMKgwqDCoMKgwqAgZXJyb3Jf
c2V0ZyhlcnJwLCAiTmVlZCB0byBzZXQgc2NhbGFibGUgbW9kZSBmb3IgUEFTSUQiKTsgIAo+IMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIGZhbHNlOwo=

