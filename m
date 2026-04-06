Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A195F46C4E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9mEq-0008CS-Ra; Mon, 06 Apr 2026 11:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mEP-0007vr-Pn; Mon, 06 Apr 2026 11:51:19 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1w9mEO-0002Qt-47; Mon, 06 Apr 2026 11:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8wrB0hNmdVyumUzLpkv1sdi9f3CdH3Pj8NWraJ2DBI3JozcSH3V7tBbG/lOIzGHcOeVPS+5vUwRZB//kgIq7BjIny0dZL0e+hHB1NYpIkHpdzRnkPU1vL1EGKMmXetT7gqnU0dGq7YDHB592oXeXPmJtlpFSNQ4UzVkio57SEF0AMCxVd47U9/NDtZmYRX0Cm9U92uVG3XvPVBZWUY6MiI5c94Gd5rvFVMb1U3Ae8h6cSqdOo1dozR440IcRZh26UIGfF43rtkPaU+LRmLvpOYcdyuzRYwE8kOEl0kq5lN1kS0U4DsXnQ5icux7IHOPYJ2xqUkiXBowtdvSFPgWwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaDxt5zmy6DAzDDJKnVSOIqvKEH+KLWmDQDavlHYo0U=;
 b=rWiZGjtDErxuRl1WDTgIPcu+QwWC3IbO8RU/3tRwmneNhfXX/7/b4o5VuOd4lq3RQi/CpaVmM++bxkWJL7mUJ3G4gG+Q1cFZeMZz1QYxPT10KuszGyW91fTUDr/kK4oKyJ0ISnWvY1RSX9dbJCKugxxqGQmfbLuQ78eQvaWhCDZpAIR4Eym34UTKGxM98CL+1Yu2NutNfI3BdDRxqiGZDaTf94GTYmiyDYiQADrh32l/gYv8/qxNyy+PHihRPYV/bLapvFLk8FwYBFEEDhVvoDWU9gK36THSLqlVivqSaGTnT4YldNoJux++i7LxqJyrRgoLKtCIH8y1bx2P+IvvLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaDxt5zmy6DAzDDJKnVSOIqvKEH+KLWmDQDavlHYo0U=;
 b=UI7Opa7cvYMgcaBFsbF1sSpXJob2IZ77o6jfnuerHwQihRpaoieu2UYyQ8GveXTUcOk4F9hnLxU5ZsVYUcdSHsXQxjHiE5uZtcr8PZ58ZgBpY6cf1ud4/ediNVi58rDp6qeLnkQp4qGJRKjb/Y2Pd+FDpiUKK/TD//HpRCoi3SuC5hm3E7k+RbMXVIq6JsARHoBAcS3ZiFzAYROLQr45S6ZxjxHwlONjVMe6MnxTXBI3GjXSExiSaHa8DwC+7S/seKUGuR2KjbGhZubOLaRyDOdOkOCXcpqycf9FUTvNUOkov5aUjS2pX7jJdOet0cZb0hu4hWLgSCnzraZYk2tIIA==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by VI1PR09MB6903.eurprd09.prod.outlook.com (2603:10a6:800:1e2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Mon, 6 Apr
 2026 15:50:37 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9769.014; Mon, 6 Apr 2026
 15:50:37 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v5 6/7] target/riscv: Support runtime endianness in virtio
 via sysemu callback
Thread-Topic: [PATCH v5 6/7] target/riscv: Support runtime endianness in
 virtio via sysemu callback
Thread-Index: AQHcu6zltcJpEkofREi367s+vheM/LXByXIAgBB5awA=
Date: Mon, 6 Apr 2026 15:50:37 +0000
Message-ID: <7a81cb84-e6e2-45c9-b73a-b4f93c14f584@htecgroup.com>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
 <20260324164007.549397-7-djordje.todorovic@htecgroup.com>
 <ad208f30-4454-41a9-a91d-756fb40930df@linaro.org>
In-Reply-To: <ad208f30-4454-41a9-a91d-756fb40930df@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|VI1PR09MB6903:EE_
x-ms-office365-filtering-correlation-id: dca558a5-d769-4626-eb29-08de93f43f1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: kMuuaI5bbMVmYl0GxI6widZMURYabz0MqX/vcYhVJjjO8Pb24I3X5KeRWOLF0FRc0HBvvfFF6cZVBr7GQWwyOhvOEsrIOzf89nBY8F71ccAgBmTuWkpwE5aobUzkMl5gdXOaC12MaypoIMIN/70rScFPrnZZtftO4JDzmab2ewp9zDfipj82GrcxZp6lLRTXmpHJfdTwYG3ZqWrq4VLfm80K7uWScOVNVwIao5jDTrMSl9JRg/jNr8vnek5n6IgH5L/nPHAVKkY4sOnM8Xi3gbT6ES2/A4y7yM1YZjiWxg7NIVqGm/MjoJl3a8bbipTgYvz69KrXCdBS0rsymUMt6I6i1k7/e30oV4WX5TH0l4GEJqK+49y36fFrFvxFiR1DxaMuyUS+/lr+dZbwHvUV37PPhaE7dDZ9fzH0s2O7jQGynMLZ0wqVrOhXCOuKBoe3u9cdlzV3CdAOS/AHmQD2afKYeMEoVUcLbhxXVLlnOeLh2UPgdEKBeRa9QGzTowSogXlkn+G83yP/o6E0BaeFevjawRK1tigMYYpmjEpt5PkLKjiZy11I/xaLuky345vseWeiciuHpSPnuQofWuXY6zqYek4HiGFXtblconP9xJeQoi/Anjt4ydh9rs3zzs0QY3oJ0YbLdKjnDf6vXF9es1oA2LLNnxIgOJh1CwFsu4cs55f4IRue2y0+t9HTsT3y9Fw5GvRiPDgCZIcZ+7J6gk6OPihECP82BQOHU5Jb1iI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2pyb2NnNlIvcmpvdC9UQWJsdXIyeDBkYjFuN29NaWt4Rm16YzAwRURvRDQ3?=
 =?utf-8?B?WHFuc2RJRFlkdGFLanpQcDJnbnlXSWc1QzBXM3g5bE5pQ1RXeUJtR3AxQTVR?=
 =?utf-8?B?QnFmTndaY1Z2OFlHV3FiOUNoNWlNK3VsTi9PWmZpOFpHNmhyS0MrTmlIaDhC?=
 =?utf-8?B?S3YySVV5UThRbExvc0Qza1VVbThuTlB4U2hKVzVmemVmUzl0aTdGR28rN2lo?=
 =?utf-8?B?L2dKQithRGo3L3BTOUxYb2hKc3R0QVpNSFdDdzFST095MnI4dTdvZ1Q3RVY1?=
 =?utf-8?B?Zm9Oc3ZMVWRrVjNLNytrV0JWRTR6UG9zTWd5VWVnQmFHdmpmVDV6YitlcE94?=
 =?utf-8?B?MHU1WnZCWGlPbThuNXloN2FwMlk3M3FQWHNWMlNmVEFyVjlKOEh4ZzRvb0Jm?=
 =?utf-8?B?TFJRdU1jZ1NMQUt0MHpTaEN5eFhkNy9EM0plRCs2OTJnT1V4U1cyREpmblRX?=
 =?utf-8?B?MFFlM3N1SUdUOWtZQTlWaXN0TUpCTTZVOEtQdU0wbHZvRmZTTTVRMk1NVzJY?=
 =?utf-8?B?V0sra1hsZkRBOHUxZENJWVUyeFovQ2Q2Y0VVYXdkVi9ZT3ZrM1I1bkxnVnAz?=
 =?utf-8?B?V1lPcHl4SlZ2djRwU3I4aTFXc0l2Y29zbXpFYnYzV3diRGk1NzdOZkEyL3dD?=
 =?utf-8?B?bGl3SmpxcW5yTlc0K2ZjMGtqRzZhdkNUVFBuZW92ZWNSeW1uK3NkLzZHQkNU?=
 =?utf-8?B?eUJ4YXNDeVdZekI0ak4wNU5VYWFKL29LVm1CM1N5U1d0WVM5bnhwOVNrVE8z?=
 =?utf-8?B?RDIwYXhQVE53bkpmeUZRaEJoS1l5SEo0ZFkzOXdtWDhGV2lvRDV3RkI5TjdC?=
 =?utf-8?B?SnRMcFhZeGI5dXpDVjQwVng4NXRNbWpUODhzb1Z3MldzSnFzN1FCWE5kdVQy?=
 =?utf-8?B?dFlXTnRHVE1UcWRSMG84VlMrY0JJalV4T1ZpZjFsMm9hWmx0bVFHajBtWVMv?=
 =?utf-8?B?bnY0K1VPWm14VkhIT0NIc2RqemlSOGwyeHhlenROM2JTSWc3NmxkSm5oMW9P?=
 =?utf-8?B?dUhDUjY5YVhFRmhneDVHbnJHZXBWdU12cmVCdkN3Y1BOQzhUSk5VVllOeFNW?=
 =?utf-8?B?dDcvYTB2emhlSEZ3S05OTVlYZFFxdElIbTNGV2hyRHk3T2dZazBXS3NjQWpr?=
 =?utf-8?B?b0FGamxPdDlocXhDQi9laVd2ZDdIT0dwaUhYQXVPUVFqeVpxd3cwMmNPU2xC?=
 =?utf-8?B?M1BJNGwyR21OV2o0VzBzVlB0NHA1eGdDK3R1ZGduUXlucVlLKzl2UTVFQk9Z?=
 =?utf-8?B?cS8ySy9zck9UakdMM1lFSldtNUZyRDFSenhneEc4emJaQnZHWDVQdGdMVGJP?=
 =?utf-8?B?c1oyRnBvVkFPQnV4MkxXWmJZUE5kMjJkV0FDT1BhdnBreENORjFNTHNDOWxG?=
 =?utf-8?B?R1RoUjc3UWpGajFqVklmRTZuSm4wdHZCTkQxSmdNcWExTE5GWjB1U3M2ck5K?=
 =?utf-8?B?UXhkMTI0M245SUdHSXJzcWlod01rMHhEbjgybC8yeVcwYWFKRkljQW9LdGxm?=
 =?utf-8?B?NW5jNVhhbUtCQVY0dWszUjBnRThwb041eFB3S3ZsQ1JTbXhJa0V4REdtSEhV?=
 =?utf-8?B?Mm5KUE5rTVFVcXo3VFU3Y0MvR1YxNVdzakV5WHgyZmp2QVFpSTl1OVVjRVMr?=
 =?utf-8?B?Q3pVeWNBOFE4WnRtVlhWcWwraHZPbjhCaXV2YVNJS2NyY3B6QVI1WXJIcXZG?=
 =?utf-8?B?dmlSKzJKNGk5eE1xV1NxcmN5Yk5teDlWVU9KdklxWjFwanB4ZFFKSHNNRkc5?=
 =?utf-8?B?cXpvMVkzYVl3WEo3bVovWXEzUW9CeDFSVk9BenlLcnRPYVpLYk9NdW0xZ2Fj?=
 =?utf-8?B?LzhGR1JyNlllS3hKZFpXOHhNL2pJSXhsckdqMzVmcUxYKzVjMzQvSzVLNkwx?=
 =?utf-8?B?dDFFU3lMZUFjVkEwWGxhbExURlBGUTB6K0M2RzNEQ0ZXTUZDZlpNWHE0bi83?=
 =?utf-8?B?cjBtZVRPdlIvL0NlWHVzVXprTlpGYjluZWdZbmRhTDhnVTNzV2xhRTJWSzYx?=
 =?utf-8?B?c0gwazNUczQrTTFlV2FQcmwyREhXTkszdnB4Z0NrZjY2WngxaCtTLzlpUjZw?=
 =?utf-8?B?U2tZMlkySHJkbGc2dXR4SkFHZU1hZW5oYU5nUkRPeVowU21sNkVuYWJ5dFNO?=
 =?utf-8?B?c0thRUZzenJRamlMZlA2cGFWcjg5czJlUWZ3ZExXeEd3VEpLTHFzazdHVXNy?=
 =?utf-8?B?OWJsemsyeTZJNy93MjMxVmllQkc5VDR6emhmY203MEd5MVZjTGRCN2Q4Ukgv?=
 =?utf-8?B?Z2dZVjRZcXBiZ1loZGVhdFdPektBdUFyR1JFdTRKNFE0SGZxeHMwREZaamhC?=
 =?utf-8?B?WkpmdVBnUEUrSnpTUUFKYkF5N2dSeTQ3MDF2bWRYR3dVS1lLWVJuT2tPMnJV?=
 =?utf-8?Q?qq26N8jAO+p+T75uitGx2LlT1cm4b8FFWxEHf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA2117CB7344DE49B8650304BBA4C1A5@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca558a5-d769-4626-eb29-08de93f43f1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 15:50:37.3171 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bhm4wT+KqHUpmcmzToUZNvpBcRoOgp/b2+66gduTMsvS4BOYdQzea++dFiUg2Gu5SCUovOVkQHBiLlFEQbTCrIJdz8eGpO7+yNEFn8rotTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR09MB6903
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

DQpPbiAzLzI3LzI2IDA1OjE1LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4gW1lvdSBkb24n
dCBvZnRlbiBnZXQgZW1haWwgZnJvbSByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnLiBMZWFy
biANCj4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRT
ZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gDQo+IG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgDQo+
IGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDMvMjUvMjYgMDI6NDAs
IERqb3JkamUgVG9kb3JvdmljIHdyb3RlOg0KPj4gSW1wbGVtZW50IHRoZSAudmlydGlvX2lzX2Jp
Z19lbmRpYW4gU3lzZW11Q1BVT3BzIGNhbGxiYWNrIGZvciBSSVNDLVYuDQo+PiBUaGlzIG1ha2Vz
IGNwdV92aXJ0aW9faXNfYmlnX2VuZGlhbigpIHJldHVybiB0aGUgY29ycmVjdCBlbmRpYW5uZXNz
DQo+PiBiYXNlZCBvbiB0aGUgaGFydCdzIE1TVEFUVVMgTUJFL1NCRS9VQkUgYml0cywgd2hpY2gg
aXMgdXNlZCBieQ0KPj4gdmlydGlvX2N1cnJlbnRfY3B1X2VuZGlhbigpIGR1cmluZyBndWVzdC1p
bml0aWF0ZWQgZGV2aWNlIHJlc2V0cy4NCj4+DQo+PiBGb3IgYmktZW5kaWFuIFJJU0MtViB0YXJn
ZXRzLCB0aGlzIGVuc3VyZXMgbGVnYWN5IHZpcnRpbyBkZXZpY2VzDQo+PiBjb3JyZWN0bHkgZGV0
ZWN0IHRoZSBndWVzdCdzIHJ1bnRpbWUgZGF0YSBlbmRpYW5uZXNzLCBtYXRjaGluZw0KPj4gaG93
IEFSTSBoYW5kbGVzIGl0cyBiaS1lbmRpYW4gc3VwcG9ydC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBEam9yZGplIFRvZG9yb3ZpYyA8ZGpvcmRqZS50b2Rvcm92aWNAaHRlY2dyb3VwLmNvbT4NCj4+
IC0tLQ0KPj4gwqAgdGFyZ2V0L3Jpc2N2L2NwdS5jIHwgMTEgKysrKysrKysrKysNCj4+IMKgIDEg
ZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+DQo+IE5hY2suDQo+DQo+IEkgcmVwbGll
ZCB0byB2NCBiZWZvcmUgSSBzYXcgdjU6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUt
ZGV2ZWwvMjNhMGQyNDAtNmY3Ny00ZWRiLTgxMjgtZmQyYzJiODM1NGRmQGxpbmFyby5vcmcvIA0K
Pg0KPg0KVGhhbmtzIGEgbG90IGZvciB0aGUgY29tbWVudC4gV2UgZG8gbm90IG5lZWQgdGhpcyBw
YXRjaCwgSSB3aWxsIGRyb3AgaXQgDQpmcm9tIHY2Lg0KRGpvcmRqZQ0KDQoNCj4NCj4gcn4NCj4N
Cj4+DQo+PiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2NwdS5jIGIvdGFyZ2V0L3Jpc2N2L2Nw
dS5jDQo+PiBpbmRleCBlZWQ1YWZkMjdlLi5mODEzYWNmNTc5IDEwMDY0NA0KPj4gLS0tIGEvdGFy
Z2V0L3Jpc2N2L2NwdS5jDQo+PiArKysgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4+IEBAIC0zMiw2
ICszMiw3IEBADQo+PiDCoCAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+IMKgICNp
bmNsdWRlICJmcHUvc29mdGZsb2F0LWhlbHBlcnMuaCINCj4+IMKgICNpbmNsdWRlICJzeXN0ZW0v
ZGV2aWNlX3RyZWUuaCINCj4+ICsjaW5jbHVkZSAic3lzdGVtL2h3X2FjY2VsLmgiDQo+PiDCoCAj
aW5jbHVkZSAic3lzdGVtL2t2bS5oIg0KPj4gwqAgI2luY2x1ZGUgInN5c3RlbS90Y2cuaCINCj4+
IMKgICNpbmNsdWRlICJrdm0va3ZtX3Jpc2N2LmgiDQo+PiBAQCAtMjcxMywxMSArMjcxNCwyMSBA
QCBzdGF0aWMgaW50NjRfdCByaXNjdl9nZXRfYXJjaF9pZChDUFVTdGF0ZSAqY3MpDQo+Pg0KPj4g
wqAgI2luY2x1ZGUgImh3L2NvcmUvc3lzZW11LWNwdS1vcHMuaCINCj4+DQo+PiArc3RhdGljIGJv
b2wgcmlzY3ZfY3B1X3ZpcnRpb19pc19iaWdfZW5kaWFuKENQVVN0YXRlICpjcykNCj4+ICt7DQo+
PiArwqDCoMKgIFJJU0NWQ1BVICpjcHUgPSBSSVNDVl9DUFUoY3MpOw0KPj4gK8KgwqDCoCBDUFVS
SVNDVlN0YXRlICplbnYgPSAmY3B1LT5lbnY7DQo+PiArDQo+PiArwqDCoMKgIGNwdV9zeW5jaHJv
bml6ZV9zdGF0ZShjcyk7DQo+PiArwqDCoMKgIHJldHVybiByaXNjdl9jcHVfZGF0YV9pc19iaWdf
ZW5kaWFuKGVudik7DQo+PiArfQ0KPj4gKw0KPj4gwqAgc3RhdGljIGNvbnN0IHN0cnVjdCBTeXNl
bXVDUFVPcHMgcmlzY3Zfc3lzZW11X29wcyA9IHsNCj4+IMKgwqDCoMKgwqAgLmhhc193b3JrID0g
cmlzY3ZfY3B1X2hhc193b3JrLA0KPj4gwqDCoMKgwqDCoCAuZ2V0X3BoeXNfcGFnZV9kZWJ1ZyA9
IHJpc2N2X2NwdV9nZXRfcGh5c19wYWdlX2RlYnVnLA0KPj4gwqDCoMKgwqDCoCAud3JpdGVfZWxm
NjRfbm90ZSA9IHJpc2N2X2NwdV93cml0ZV9lbGY2NF9ub3RlLA0KPj4gwqDCoMKgwqDCoCAud3Jp
dGVfZWxmMzJfbm90ZSA9IHJpc2N2X2NwdV93cml0ZV9lbGYzMl9ub3RlLA0KPj4gK8KgwqDCoCAu
aW50ZXJuYWxfaXNfYmlnX2VuZGlhbiA9IHJpc2N2X2NwdV92aXJ0aW9faXNfYmlnX2VuZGlhbiwN
Cj4+IMKgwqDCoMKgwqAgLmxlZ2FjeV92bXNkID0gJnZtc3RhdGVfcmlzY3ZfY3B1LA0KPj4gwqAg
fTsNCj4+IMKgICNlbmRpZg0KPg==

