Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE92C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 10:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGF7N-000320-5Z; Sat, 17 May 2025 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marko1616@outlook.com>)
 id 1uGF7J-00030t-16
 for qemu-devel@nongnu.org; Sat, 17 May 2025 06:50:10 -0400
Received: from
 mail-australiasoutheastazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d40e::] helo=MEUPR01CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marko1616@outlook.com>)
 id 1uGF7B-000161-Kn
 for qemu-devel@nongnu.org; Sat, 17 May 2025 06:50:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCXpz+chyYGpW/r3dEPVLP7oNQ42TSdGE3fckuyDdODNfi06GGa9AQYfG247K0kYs6MpMaeyWnDh4VRYksGnvTU4gN/PGAbaK8yCILHSTZs9t96Qa/15XL4ZIZp/i5z68UuCzosJkw7GJMyEBwR8d06fiKMxzaEtT0pym7lgYjIF2qlG/Nbdyb5XGiog6FieSp12tNhGXlBUQ+IKNs+UjHBJrbfikz2348ADEsUWqREtS3PoJS1ZR22IFAibjMffqPzgVu8kupqqzMoLYVmHiXUxIQS5cWTMFG2TTp9DkROISgC/NBNwU1m0xSM7OYkG7Z0jj2qpBHwC06KMagFAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzacUvumL40IhuwOflJCr6U/G7TpZRINC7mG2PncOJE=;
 b=DZ29nSqQI9+z552T4VDSXf7psobukvkuY2G1E1W3exSUbf+ZVSZ7l3qyp3LealNbfozkmC1k8uljWJC1NBHxaxAUO4bojdpVsu2FNcfDE/vNHVxU3BOxu7c4WOlv4M+kx5a5TyYL5FXcarKpxn8oYl6/umDZk7i8/52XznDv9F+eZyxA5TCxt7TGx8t1+rvDbcc1wXZFo627CpsN4r05M8m2Yd7A21XiRdPYZEIvtImOrue7tk5LCJUkcHOG3ycf1wUeidcWBEXXo7XXCPJ9WSJ5aY100jUa/yPYijMZ1Sp4l+9y6pc4fcQws1uszOo1OdeNYpMkiyvhAFLLvlkUdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzacUvumL40IhuwOflJCr6U/G7TpZRINC7mG2PncOJE=;
 b=KyFKs7D7OmaTG4pSiPOZ9QMipXU3bhgWI6XT+6/jmI9JH7AYvkqWwgXgNRBrYQkYCcAlZjp3WFL1+jl1+JN9nnJe1+2krjA0LDzuOEr5oui3aYYqUdwanycaPlwhQExmBHTcr9W5ne+cJHxdYVPL+QKT1LLX9LHplh42pofA3B4K9w9wnessnz3meQukq712sYZscuRBOmHpE9Z2OmXGSAwiwpBYC+jtmH1gDdUViL8oNVMdC2e1dJqdosd/KFc7/JOuFxxFEqgGsJ6IHIfsl6uH0mkhh9hAjfmDfi4w44BiGbD/ixhKsA72OHq4cR18GglxU/VDLAqnO5+4/Zp9sA==
Received: from ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:13e::12)
 by MEYP282MB3675.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:175::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Sat, 17 May
 2025 10:49:53 +0000
Received: from ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM
 ([fe80::79ac:1f5e:43da:5460]) by ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM
 ([fe80::79ac:1f5e:43da:5460%4]) with mapi id 15.20.8722.031; Sat, 17 May 2025
 10:49:53 +0000
From: Liu marko <marko1616@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "erdnaxe@crans.org"
 <erdnaxe@crans.org>, "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] plugin: Add callback support for vCPU hardware and
 architecture-specific interrupts
Thread-Topic: [PATCH v2] plugin: Add callback support for vCPU hardware and
 architecture-specific interrupts
Thread-Index: AQHbxxk59hHPdvBsrUSZ9NdONFPRVg==
Date: Sat, 17 May 2025 10:49:53 +0000
Message-ID: <ME3P282MB27931E7D5FDC64EC4BD91C9DA692A@ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME3P282MB2793:EE_|MEYP282MB3675:EE_
x-ms-office365-filtering-correlation-id: 35de7c6f-b5c6-4476-ee5b-08dd95308e4a
x-microsoft-antispam: BCL:0;
 ARA:14566002|15080799009|19110799006|8060799009|8062599006|5062599005|7071999006|15030799003|41001999006|461199028|7092599006|3412199025|440099028|12091999003|10035399007|102099032;
x-microsoft-antispam-message-info: =?gb2312?B?WmhIdXN5RG9xV1ZaM3NYUC9XSldyRUtEY3Z6T1dNVU9Dalc0aVZieFpOS1NB?=
 =?gb2312?B?TFRETVYvQy9qNThtVmtBWkc3d1dYZG1KcXNTY2FsT1VUK2FwRzFUMCtWWTY1?=
 =?gb2312?B?TWNBRDhlUW5uSVQySG5xajBSbG14dStUbHFIMDl1ODRTTGR0bHNRZ0ZtZ0Zl?=
 =?gb2312?B?UVhhK2RJYjRCYy9YSlE1Z1FwU1dhSXREblE3dEFLL2xLbEVPOUExT0plaGFu?=
 =?gb2312?B?aWVEQ2dnRkpwVGgzekJ6ZzRzN3J1NkQvYU5hTDBXYW5lMmtWckJ5ZE5JMy90?=
 =?gb2312?B?WWszNE5hL2Frek90SXFtMVlmQlluT2lYTEtOeEx2aCs4by9uZTIwVG45SkNp?=
 =?gb2312?B?YktYQWtkZmF3QlJrUW0xU3BiLy81cXM0bGd1T1ZKNmlpMWlzYlRBaDJXMkZr?=
 =?gb2312?B?NnVSVjdhcHpyTUR1OUNoY20yazBOVk4vRXhSNDdIR0NZcGltd1JUMENnYi95?=
 =?gb2312?B?MjMxS1U1dnpRNHRGMzBZb2xUTWtpRkJ1MVd4bndLYnlOcHEzM3JPOFFGODlp?=
 =?gb2312?B?Rm5tbmhzUG5RRmw5QlZ6aFl0a0lmR3FUcnRScG4xMEVuWi9mTUNsUTNHZE9L?=
 =?gb2312?B?RkVxUGdDUXlMZDB0Q2h2aGkzdUlaSlNzV0RLUXpGMnpiT29MNjNmNVhhOGMw?=
 =?gb2312?B?MytFTnVXMVFROUgwMmtCVEQ2TWEzaHVRaFdIRnp5VzVsQjQ0Vnp5Qko2RGti?=
 =?gb2312?B?bWl2VDJab1FzVXpIcitGZ1d2MzBCUE0vRXQ5TnpnSXVzcEg3VVBrTlhJVFV1?=
 =?gb2312?B?RTNZYng3aVpjUVdnbmxPaW1YTkJTMjMvSk9EVXdSKy9rdW9uREFMWEFVQjNV?=
 =?gb2312?B?L3lrdjJnMjFZTGZHODdPdUZEcjdqY1h1bjN1UnM2UUQ2Z3h1RTZObnA5Tkdm?=
 =?gb2312?B?U2NxSGo1dkZpeEp1NmYwWStPZ3ZOSC9kMXNLYlBKRmFSbnczQ1JKRWVTL2lI?=
 =?gb2312?B?dEhjbkN1MFB2cFpHMUg3YllpaStSdnluOVRVSGdGam9DQVpGRHBETVgxYlVn?=
 =?gb2312?B?SlFsZHY0VWFuSHF1ZHVNM3BsN0ZwZkZrUUU0RW9nS0JQeFVtSUpNZmRITmNz?=
 =?gb2312?B?UjRGRnFrWkRTQUdpczNXTnVDaFNqeDRzc3VWUU1qUDdDRkJOcUFiWTdrOTBv?=
 =?gb2312?B?blVFZnFacHpqMEl5cXYzVE9BSzg4eXJRazRUb0JCNEtOSGNCY0ZBcDJieVJq?=
 =?gb2312?B?akJ0T3M2b1pLUU5PcDZlQjdOQ1d1SUo0TmV4SXVtTk03QkhMTHNXSHlKSmkv?=
 =?gb2312?B?QzgvMUxDM0E4QW80SnlwdCtlV2pqV0VmRVZRVXBhMFRtN2ZFWThWM3RYSmZn?=
 =?gb2312?B?VzFncE9xcm1xZGNBb256ZlVCajc1eWhiQzZsaEk3NksrRmlCaGdwMkZ6am04?=
 =?gb2312?B?UVdzMVNTck4zSVcyYmY1cHNxME1rMXVWdjRwZk5Ha2VPM1g3dElaU3lUNGZs?=
 =?gb2312?B?MFllYnJaUCtnZjdxbW81MUQrQlIwZ0Ewa2VlYW5MaHhJNFBueStqMUdOTDNw?=
 =?gb2312?B?MU5haGZnZHJGRXlYVHJpMU4wcDF2aFF2SWNTS1A0YkZteDU4b1hwYVpTcGFw?=
 =?gb2312?B?MXc0ZWNHdW0rYW9TVC9QRjBxdlVVdnpzWXBEb2c0NCtuQ0NoM0xtVWh1SFY3?=
 =?gb2312?B?WmE0VG40YUd2UlBZTmNIN2FJWTFrQy9TUC9WanRxcTlnTm1zZ0hlQTVlNDNI?=
 =?gb2312?B?ajY5b2RYQjhKTlFFQWlwaldjRnFVdVZVRGFYWWV3NWFYcm53eFdZdkhVWGdq?=
 =?gb2312?Q?hvqfaheLBw19ySKOKb4tjmvcQnADaVbHw7CGVo4?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZldWNFE3V0wrdVFEMzE3T08wem53SzdjQTdMRVF6emJLUFdWZUJaS2FoeEc4?=
 =?gb2312?B?YSttWncxeUF2TlNnOHZzSVNMN2hsWnhMTlp3aHNxSnJxSEtQS0ZVbVpyYW5y?=
 =?gb2312?B?Y2dWMW8zSFVRVzRSUDVycEhQYUxjSTJxOWdPcTA4aElldFdRdVVXMjVHTG50?=
 =?gb2312?B?OXZkbDN4bGxpQnpTck15TnQ0Y3NLaCt0K0lKVEF1US9XWldJSTdNS1c3TGx5?=
 =?gb2312?B?V3AwZ0pQVWR2b21id1pPdjJBY3kzaEFZOUlVOVcwcXBJcDNtTTZINVpOT0Fi?=
 =?gb2312?B?QnhIYmlyTmdaOWFYa2NOeTdlam5VbGFJZGhlR1NtNWpJSmkwVXFWVkVpVnAz?=
 =?gb2312?B?QUEvUVF3R3lMSkpERGZQTlVaK2d1SXhiZWFFY3dmVWw4eXhVTThlTC9aQy9Q?=
 =?gb2312?B?TUx0Y2RJdHlLT0pUaEVJTlliYS9RZ2g3bTRuNFZnb3NRSzc2K1lFUVJ2V24z?=
 =?gb2312?B?QXBDdTloT3QyVm03ZTNkUUUzc0NFMjM4UEVOa3Uza3dJQVpxUGVPeklCQkxy?=
 =?gb2312?B?YWhRZ29tdzZxZm5lWnBjOS85L0RhbDYyUkFMUXZkdE1FeWNocVdwVHRTK2pp?=
 =?gb2312?B?Mk1LUE85WldpbU82dnZlOU1xclZ2SlFHSXBRT1dFcm16UXpOak1nM015aFoz?=
 =?gb2312?B?NWVXcUFIS2V2Z1JmS1lKdUM3K3ZkeGJPMFdLWEI3UElZY2drYmJzek5Jai9n?=
 =?gb2312?B?TThBWFFVbVZhNzdYVVJvR2Qwa2pnUWJUOW8zNnJqbi84Z25MdE9wS2NJdFBy?=
 =?gb2312?B?bUtDYkdVRDZ4OFhDNXJLbDRSME54bXZReVZianBmSmRORHVpdTFYeG9OZXZ3?=
 =?gb2312?B?QzFkenZ1dXNhNW00SjlCU2JUZVV2Vis2anpKdnBnVndwT1FiVDZCUU1INm1q?=
 =?gb2312?B?Z09jNlVxL3BRNCtiQ1A2dnBmL0dkVkx2NVRyNGNhNFF4RHlwWkdnZ1VwSW52?=
 =?gb2312?B?NURiNU53K09kdzNObUNSQlVWZmZUSTNERk9lQmZSOC9pUnR5UFRFckxIWDUy?=
 =?gb2312?B?K0R2OTZtUEdhamVpM0diaHd1RC9UdDZNN05ZT3BTVXR5QkJZZWRFbGp5Wk5y?=
 =?gb2312?B?WmIvWDR6dllNNjBEb2Q2UGhnUGtvaFJpeXoxcFREWTFud1EyZ0xleFdETjRm?=
 =?gb2312?B?RTdaSjZpVXlWT0NacVBjSG11ZXJLc0NSWDl1bEt3VUdYTU9aS2hMU216bXc3?=
 =?gb2312?B?U3hrK21sVlA5TVRVZHpZZjJvUGU5aGZYMW4vZVlrRG5WNUc0VWZXZ1dYNktn?=
 =?gb2312?B?K2kwSE0ra1ZMd3grbWtHZmxLRGdHRXpMdENVVFJiTkRsTk9SaEg2T24zRVZx?=
 =?gb2312?B?b3lHYlZCcllhR0lYODFCRGQ2dVFUK3dYMUdNYmhLb0dUQVdwd0N6a1hSelc3?=
 =?gb2312?B?bS9Dd3ZlUGI1VDVDOGtCYkl0eXJoV1RxMUJSaWlXVU9sRU1JY0hKZzAwdDdl?=
 =?gb2312?B?cVVKOXpMNXFNNGVUSmVGSGNBSmd6SW1Rd2Rqb3JVL3JiMm9tVHNJTjlGeUVr?=
 =?gb2312?B?WE1zYjlqSWR0ayt2NkNEWGNWZzRNUXdYVEVtT0h2L2l2eW9zRFBJakhmWjVF?=
 =?gb2312?B?Ty9iSUh4enJGc3pBNkxZV0tYWFRhVWllUytMZzF1N1RWb0tpeUQ4MFVlNjJI?=
 =?gb2312?B?UU5PbnRxY3JiTkZDZWkrU052MGRSUDBNUm1lMExKeVl0UVJVT21hb2laZW9q?=
 =?gb2312?B?akU2ZFMrYTN2Z0JXcWhtV0F5R0ZtRm1ia2hONEttcFBtUkh0YnNXNWZKRXd4?=
 =?gb2312?Q?9c4tu+5rt0ybratXI4=3D?=
Content-Type: multipart/alternative;
 boundary="_000_ME3P282MB27931E7D5FDC64EC4BD91C9DA692AME3P282MB2793AUSP_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 35de7c6f-b5c6-4476-ee5b-08dd95308e4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2025 10:49:53.4283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEYP282MB3675
Received-SPF: pass client-ip=2a01:111:f403:d40e::;
 envelope-from=marko1616@outlook.com;
 helo=MEUPR01CU001.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_ME3P282MB27931E7D5FDC64EC4BD91C9DA692AME3P282MB2793AUSP_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SW1wbGVtZW50ZWQgdGhlIGBxZW11X3BsdWdpbl92Y3B1X2ludF9jYmAgY2FsbGJhY2sgdG8gYWxs
b3cgcGx1Z2lucyB0byBvYnNlcnZlIGhhcmR3YXJlIGFuZCBhcmNoaXRlY3R1cmUtc3BlY2lmaWMg
aW50ZXJydXB0cy4gTW9kaWZpZWQgYGNwdS1leGVjLmNgIHRvIGludm9rZSB0aGUgY2FsbGJhY2sg
b24gaGFyZCBpbnRlcnJ1cHRzLCBhbmQgYWRkZWQgYSB0ZXN0IHBsdWdpbiAoYGNvdW50aW50YCkg
dG8gZGVtb25zdHJhdGUgaXRzIGZ1bmN0aW9uYWxpdHkuIEEgc2ltaWxhciBhcHByb2FjaCB3YXMg
cHJldmlvdXNseSBwcm9wb3NlZCAoaHR0cHM6Ly9saXN0cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9x
ZW11LWRldmVsLzIwMjMtMTAvbXNnMDczNTkuaHRtbCkgYnV0IHdhcyBub3QgbWVyZ2VkLg0KDQpD
aGFuZ2VzIHNpbmNlIHYxOg0KLSBGaXhlZCBidWlsZCB3aXRoIGAtLWRpc2FibGUtcGx1Z2luc2AN
Cg0KU2lnbmVkLW9mZi1ieTogbWFya28xNjE2IDxtYXJrbzE2MTZAb3V0bG9vay5jb20+DQotLS0N
CiBhY2NlbC90Y2cvY3B1LWV4ZWMuYyAgICAgICAgfCAxMSArKysrKw0KIGNvbnRyaWIvcGx1Z2lu
cy9jb3VudGludC5jICB8IDkwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
CiBjb250cmliL3BsdWdpbnMvbWVzb24uYnVpbGQgfCAgMiArLQ0KIGluY2x1ZGUvcWVtdS9wbHVn
aW4tZXZlbnQuaCB8ICAxICsNCiBpbmNsdWRlL3FlbXUvcGx1Z2luLmggICAgICAgfCAgNSArKysN
CiBpbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaCAgfCAxNyArKysrKysrDQogcGx1Z2lucy9jb3Jl
LmMgICAgICAgICAgICAgIHwgMjMgKysrKysrKysrKw0KIDcgZmlsZXMgY2hhbmdlZCwgMTQ4IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgY29udHJpYi9w
bHVnaW5zL2NvdW50aW50LmMNCg0KZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9jcHUtZXhlYy5jIGIv
YWNjZWwvdGNnL2NwdS1leGVjLmMNCmluZGV4IGNjNWYzNjIzMDUuLmU0MTEzZjg5NjYgMTAwNjQ0
DQotLS0gYS9hY2NlbC90Y2cvY3B1LWV4ZWMuYw0KKysrIGIvYWNjZWwvdGNnL2NwdS1leGVjLmMN
CkBAIC0zNCw2ICszNCw5IEBADQogI2luY2x1ZGUgInRjZy90Y2cuaCINCiAjaW5jbHVkZSAicWVt
dS9hdG9taWMuaCINCiAjaW5jbHVkZSAicWVtdS9yY3UuaCINCisjaWZkZWYgQ09ORklHX1BMVUdJ
Tg0KKyNpbmNsdWRlICJxZW11L3BsdWdpbi5oIg0KKyNlbmRpZg0KICNpbmNsdWRlICJleGVjL2xv
Zy5oIg0KICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIg0KICNpbmNsdWRlICJleGVjL2ljb3Vu
dC5oIg0KQEAgLTgxOCw3ICs4MjEsMTUgQEAgc3RhdGljIGlubGluZSBib29sIGNwdV9oYW5kbGVf
aW50ZXJydXB0KENQVVN0YXRlICpjcHUsDQogICAgICAgICAgICAgICogVHJ1ZSB3aGVuIGl0IGlz
LCBhbmQgd2Ugc2hvdWxkIHJlc3RhcnQgb24gYSBuZXcgVEIsDQogICAgICAgICAgICAgICogYW5k
IHZpYSBsb25nam1wIHZpYSBjcHVfbG9vcF9leGl0Lg0KICAgICAgICAgICAgICAqLw0KKyNpZmRl
ZiBDT05GSUdfUExVR0lODQorICAgICAgICAgICAgY29uc3QgaW50IHByZXZfaW50ZXJydXB0X3Jl
cXVlc3QgPSBpbnRlcnJ1cHRfcmVxdWVzdDsNCisjZW5kaWYgLyogQ09ORklHX1BMVUdJTiAqLw0K
ICAgICAgICAgICAgIGlmICh0Y2dfb3BzLT5jcHVfZXhlY19pbnRlcnJ1cHQoY3B1LCBpbnRlcnJ1
cHRfcmVxdWVzdCkpIHsNCisjaWZkZWYgQ09ORklHX1BMVUdJTg0KKyAgICAgICAgICAgICAgICBp
ZiAoaW50ZXJydXB0X3JlcXVlc3QgJiBDUFVfSU5URVJSVVBUX0hBUkQpIHsNCisgICAgICAgICAg
ICAgICAgICAgIHFlbXVfcGx1Z2luX3ZjcHVfaW50X2NiKGNwdSwgcHJldl9pbnRlcnJ1cHRfcmVx
dWVzdCk7DQorICAgICAgICAgICAgICAgIH0NCisjZW5kaWYgLyogQ09ORklHX1BMVUdJTiAqLw0K
ICAgICAgICAgICAgICAgICBpZiAoIXRjZ19vcHMtPm5lZWRfcmVwbGF5X2ludGVycnVwdCB8fA0K
ICAgICAgICAgICAgICAgICAgICAgdGNnX29wcy0+bmVlZF9yZXBsYXlfaW50ZXJydXB0KGludGVy
cnVwdF9yZXF1ZXN0KSkgew0KICAgICAgICAgICAgICAgICAgICAgcmVwbGF5X2ludGVycnVwdCgp
Ow0KZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9jb3VudGludC5jIGIvY29udHJpYi9wbHVn
aW5zL2NvdW50aW50LmMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwLi42
MDFiN2YzMGQ1DQotLS0gL2Rldi9udWxsDQorKysgYi9jb250cmliL3BsdWdpbnMvY291bnRpbnQu
Yw0KQEAgLTAsMCArMSw5MCBAQA0KKy8qDQorICogQ29weXJpZ2h0IChjKSAyMDI1IG1hcmtvMTYx
Ng0KKyAqDQorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCisg
Ki8NCisNCisjaW5jbHVkZSA8c3RkaW8uaD4NCisjaW5jbHVkZSA8Z2xpYi5oPg0KKw0KKyNpbmNs
dWRlIDxxZW11LXBsdWdpbi5oPg0KKw0KK1FFTVVfUExVR0lOX0VYUE9SVCBpbnQgcWVtdV9wbHVn
aW5fdmVyc2lvbiA9IFFFTVVfUExVR0lOX1ZFUlNJT047DQorDQordHlwZWRlZiBzdHJ1Y3Qgew0K
KyAgICB1bnNpZ25lZCBpbnQgdmNwdV9pbmRleDsNCisgICAgc3RydWN0IHFlbXVfcGx1Z2luX3Nj
b3JlYm9hcmQgKmludF9jb3VudDsNCit9IEludFN0YXQ7DQorDQorc3RhdGljIEdIYXNoVGFibGUg
KnZjcHVfaW50X3RhYmxlOw0KK3N0YXRpYyBHTXV0ZXggbG9jazsNCisNCitzdGF0aWMgZ3VpbnQg
aW50c3RhdF9oYXNoKGdjb25zdHBvaW50ZXIga2V5KQ0KK3sNCisgICAgY29uc3QgSW50U3RhdCAq
cyA9IGtleTsNCisgICAgcmV0dXJuIHMtPnZjcHVfaW5kZXg7DQorfQ0KKw0KK3N0YXRpYyBnYm9v
bGVhbiBpbnRzdGF0X2VxdWFsKGdjb25zdHBvaW50ZXIgYSwgZ2NvbnN0cG9pbnRlciBiKQ0KK3sN
CisgICAgcmV0dXJuICgoSW50U3RhdCAqKWEpLT52Y3B1X2luZGV4ID09ICgoSW50U3RhdCAqKWIp
LT52Y3B1X2luZGV4Ow0KK30NCisNCitzdGF0aWMgdm9pZCBpbnRzdGF0X2ZyZWUoZ3BvaW50ZXIg
a2V5LCBncG9pbnRlciB2YWx1ZSwgZ3BvaW50ZXIgdXNlcl9kYXRhKQ0KK3sNCisgICAgSW50U3Rh
dCAqcyA9IHZhbHVlOw0KKyAgICBxZW11X3BsdWdpbl9zY29yZWJvYXJkX2ZyZWUocy0+aW50X2Nv
dW50KTsNCisgICAgZ19mcmVlKHMpOw0KK30NCisNCitzdGF0aWMgdm9pZCB2Y3B1X2hhcmRpbnQo
cWVtdV9wbHVnaW5faWRfdCBpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQg
aW50IHZjcHVfaW5kZXgsDQorICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IGludF9y
ZXEpDQorew0KKyAgICBJbnRTdGF0ICpzdGF0ID0gTlVMTDsNCisNCisgICAgZ19tdXRleF9sb2Nr
KCZsb2NrKTsNCisgICAgew0KKyAgICAgICAgSW50U3RhdCBrZXkgPSB7IC52Y3B1X2luZGV4ID0g
dmNwdV9pbmRleCB9Ow0KKyAgICAgICAgc3RhdCA9IGdfaGFzaF90YWJsZV9sb29rdXAodmNwdV9p
bnRfdGFibGUsICZrZXkpOw0KKw0KKyAgICAgICAgaWYgKCFzdGF0KSB7DQorICAgICAgICAgICAg
c3RhdCA9IGdfbmV3MChJbnRTdGF0LCAxKTsNCisgICAgICAgICAgICBzdGF0LT52Y3B1X2luZGV4
ID0gdmNwdV9pbmRleDsNCisgICAgICAgICAgICBzdGF0LT5pbnRfY291bnQgPSBxZW11X3BsdWdp
bl9zY29yZWJvYXJkX25ldyhzaXplb2YodWludDY0X3QpKTsNCisgICAgICAgICAgICBnX2hhc2hf
dGFibGVfaW5zZXJ0KHZjcHVfaW50X3RhYmxlLCBzdGF0LCBzdGF0KTsNCisgICAgICAgIH0NCisg
ICAgfQ0KKyAgICBnX211dGV4X3VubG9jaygmbG9jayk7DQorDQorICAgIHFlbXVfcGx1Z2luX3U2
NF9hZGQoDQorICAgICAgICBxZW11X3BsdWdpbl9zY29yZWJvYXJkX3U2NChzdGF0LT5pbnRfY291
bnQpLA0KKyAgICAgICAgdmNwdV9pbmRleCwNCisgICAgICAgIDENCisgICAgKTsNCit9DQorDQor
c3RhdGljIHZvaWQgcGx1Z2luX2V4aXQocWVtdV9wbHVnaW5faWRfdCBpZCwgdm9pZCAqcCkNCit7
DQorICAgIEdMaXN0ICpzdGF0cyA9IGdfaGFzaF90YWJsZV9nZXRfdmFsdWVzKHZjcHVfaW50X3Rh
YmxlKTsNCisgICAgZm9yIChHTGlzdCAqaXQgPSBzdGF0czsgaXQgIT0gTlVMTDsgaXQgPSBpdC0+
bmV4dCkgew0KKyAgICAgICAgSW50U3RhdCAqc3RhdCA9IChJbnRTdGF0ICopaXQtPmRhdGE7DQor
ICAgICAgICB1aW50NjRfdCBjb3VudCA9IHFlbXVfcGx1Z2luX3U2NF9zdW0oDQorICAgICAgICAg
ICAgcWVtdV9wbHVnaW5fc2NvcmVib2FyZF91NjQoc3RhdC0+aW50X2NvdW50KQ0KKyAgICAgICAg
KTsNCisgICAgICAgIHByaW50ZigidkNQVSAldTogJSIgUFJJdTY0ICIgaW50ZXJydXB0c1xuIiwg
c3RhdC0+dmNwdV9pbmRleCwgY291bnQpOw0KKyAgICB9DQorICAgIGdfbGlzdF9mcmVlKHN0YXRz
KTsNCisgICAgZ19oYXNoX3RhYmxlX2ZvcmVhY2godmNwdV9pbnRfdGFibGUsIGludHN0YXRfZnJl
ZSwgTlVMTCk7DQorICAgIGdfaGFzaF90YWJsZV9kZXN0cm95KHZjcHVfaW50X3RhYmxlKTsNCit9
DQorDQorUUVNVV9QTFVHSU5fRVhQT1JUDQoraW50IHFlbXVfcGx1Z2luX2luc3RhbGwocWVtdV9w
bHVnaW5faWRfdCBpZCwgY29uc3QgcWVtdV9pbmZvX3QgKmluZm8sDQorICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KK3sNCisgICAgdmNwdV9pbnRfdGFibGUg
PSBnX2hhc2hfdGFibGVfbmV3KGludHN0YXRfaGFzaCwgaW50c3RhdF9lcXVhbCk7DQorICAgIHFl
bXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfaW50X2NiKGlkLCB2Y3B1X2hhcmRpbnQpOw0KKyAgICBx
ZW11X3BsdWdpbl9yZWdpc3Rlcl9hdGV4aXRfY2IoaWQsIHBsdWdpbl9leGl0LCBOVUxMKTsNCisg
ICAgcmV0dXJuIDA7DQorfQ0KZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWls
ZCBiL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KaW5kZXggZmE4YTQyNmM4Yi4uMTdlM2Iw
ZWMyNyAxMDA2NDQNCi0tLSBhL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KKysrIGIvY29u
dHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkDQpAQCAtMSw0ICsxLDQgQEANCi1jb250cmliX3BsdWdp
bnMgPSBbJ2JidicsICdjYWNoZScsICdjZmxvdycsICdkcmNvdicsICdleGVjbG9nJywgJ2hvdGJs
b2NrcycsDQorY29udHJpYl9wbHVnaW5zID0gWydiYnYnLCAnY2FjaGUnLCAnY2Zsb3cnLCAnZHJj
b3YnLCAnZXhlY2xvZycsICdjb3VudGludCcsICdob3RibG9ja3MnLA0KICAgICAgICAgICAgICAg
ICAgICAnaG90cGFnZXMnLCAnaG93dmVjJywgJ2h3cHJvZmlsZScsICdpcHMnLCAnc3RvcHRyaWdn
ZXInXQ0KIGlmIGhvc3Rfb3MgIT0gJ3dpbmRvd3MnDQogICAjIGxvY2tzdGVwIHVzZXMgc29ja2V0
LmgNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvcGx1Z2luLWV2ZW50LmggYi9pbmNsdWRlL3Fl
bXUvcGx1Z2luLWV2ZW50LmgNCmluZGV4IDcwNTZkODQyN2IuLmNkOWY5ZWIyNWIgMTAwNjQ0DQot
LS0gYS9pbmNsdWRlL3FlbXUvcGx1Z2luLWV2ZW50LmgNCisrKyBiL2luY2x1ZGUvcWVtdS9wbHVn
aW4tZXZlbnQuaA0KQEAgLTE2LDYgKzE2LDcgQEAgZW51bSBxZW11X3BsdWdpbl9ldmVudCB7DQog
ICAgIFFFTVVfUExVR0lOX0VWX1ZDUFVfVEJfVFJBTlMsDQogICAgIFFFTVVfUExVR0lOX0VWX1ZD
UFVfSURMRSwNCiAgICAgUUVNVV9QTFVHSU5fRVZfVkNQVV9SRVNVTUUsDQorICAgIFFFTVVfUExV
R0lOX0VWX1ZDUFVfSU5ULA0KICAgICBRRU1VX1BMVUdJTl9FVl9WQ1BVX1NZU0NBTEwsDQogICAg
IFFFTVVfUExVR0lOX0VWX1ZDUFVfU1lTQ0FMTF9SRVQsDQogICAgIFFFTVVfUExVR0lOX0VWX0ZM
VVNILA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9wbHVnaW4uaCBiL2luY2x1ZGUvcWVtdS9w
bHVnaW4uaA0KaW5kZXggOTcyNmE5ZWJmMy4uZjFkNWQ5MTE0MSAxMDA2NDQNCi0tLSBhL2luY2x1
ZGUvcWVtdS9wbHVnaW4uaA0KKysrIGIvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQpAQCAtNjEsNiAr
NjEsNyBAQCB1bmlvbiBxZW11X3BsdWdpbl9jYl9zaWcgew0KICAgICBxZW11X3BsdWdpbl92Y3B1
X3VkYXRhX2NiX3QgICAgICB2Y3B1X3VkYXRhOw0KICAgICBxZW11X3BsdWdpbl92Y3B1X3RiX3Ry
YW5zX2NiX3QgICB2Y3B1X3RiX3RyYW5zOw0KICAgICBxZW11X3BsdWdpbl92Y3B1X21lbV9jYl90
ICAgICAgICB2Y3B1X21lbTsNCisgICAgcWVtdV9wbHVnaW5fdmNwdV9pbnRfY2JfdCAgICB2Y3B1
X2hhcmRpbnQ7DQogICAgIHFlbXVfcGx1Z2luX3ZjcHVfc3lzY2FsbF9jYl90ICAgIHZjcHVfc3lz
Y2FsbDsNCiAgICAgcWVtdV9wbHVnaW5fdmNwdV9zeXNjYWxsX3JldF9jYl90IHZjcHVfc3lzY2Fs
bF9yZXQ7DQogICAgIHZvaWQgKmdlbmVyaWM7DQpAQCAtMTYwLDYgKzE2MSw3IEBAIHZvaWQgcWVt
dV9wbHVnaW5fdmNwdV9leGl0X2hvb2soQ1BVU3RhdGUgKmNwdSk7DQogdm9pZCBxZW11X3BsdWdp
bl90Yl90cmFuc19jYihDUFVTdGF0ZSAqY3B1LCBzdHJ1Y3QgcWVtdV9wbHVnaW5fdGIgKnRiKTsN
CiB2b2lkIHFlbXVfcGx1Z2luX3ZjcHVfaWRsZV9jYihDUFVTdGF0ZSAqY3B1KTsNCiB2b2lkIHFl
bXVfcGx1Z2luX3ZjcHVfcmVzdW1lX2NiKENQVVN0YXRlICpjcHUpOw0KK3ZvaWQgcWVtdV9wbHVn
aW5fdmNwdV9pbnRfY2IoQ1BVU3RhdGUgKmNwdSwgaW50IGludGVycnVwdF9yZXF1ZXN0KTsNCiB2
b2lkDQogcWVtdV9wbHVnaW5fdmNwdV9zeXNjYWxsKENQVVN0YXRlICpjcHUsIGludDY0X3QgbnVt
LCB1aW50NjRfdCBhMSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgYTIsIHVp
bnQ2NF90IGEzLCB1aW50NjRfdCBhNCwgdWludDY0X3QgYTUsDQpAQCAtMjQyLDYgKzI0NCw5IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBxZW11X3BsdWdpbl92Y3B1X2lkbGVfY2IoQ1BVU3RhdGUgKmNw
dSkNCiBzdGF0aWMgaW5saW5lIHZvaWQgcWVtdV9wbHVnaW5fdmNwdV9yZXN1bWVfY2IoQ1BVU3Rh
dGUgKmNwdSkNCiB7IH0NCg0KK3N0YXRpYyBpbmxpbmUgdm9pZCBxZW11X3BsdWdpbl92Y3B1X2lu
dF9jYihDUFVTdGF0ZSAqY3B1LCBpbnQgaW50ZXJydXB0X3JlcXVlc3QpDQoreyB9DQorDQogc3Rh
dGljIGlubGluZSB2b2lkDQogcWVtdV9wbHVnaW5fdmNwdV9zeXNjYWxsKENQVVN0YXRlICpjcHUs
IGludDY0X3QgbnVtLCB1aW50NjRfdCBhMSwgdWludDY0X3QgYTIsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgIHVpbnQ2NF90IGEzLCB1aW50NjRfdCBhNCwgdWludDY0X3QgYTUsIHVpbnQ2NF90
IGE2LA0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oIGIvaW5jbHVkZS9x
ZW11L3FlbXUtcGx1Z2luLmgNCmluZGV4IDNhODUwYWEyMTYuLjY1MDk2YzRjNjQgMTAwNjQ0DQot
LS0gYS9pbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaA0KKysrIGIvaW5jbHVkZS9xZW11L3FlbXUt
cGx1Z2luLmgNCkBAIC03MjgsNiArNzI4LDIzIEBAIGNvbnN0IHZvaWQgKnFlbXVfcGx1Z2luX3Jl
cXVlc3RfdGltZV9jb250cm9sKHZvaWQpOw0KIFFFTVVfUExVR0lOX0FQSQ0KIHZvaWQgcWVtdV9w
bHVnaW5fdXBkYXRlX25zKGNvbnN0IHZvaWQgKmhhbmRsZSwgaW50NjRfdCB0aW1lKTsNCg0KK3R5
cGVkZWYgdm9pZA0KKygqcWVtdV9wbHVnaW5fdmNwdV9pbnRfY2JfdCkocWVtdV9wbHVnaW5faWRf
dCBpZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgdmNw
dV9pbmRleCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBpbnRl
cnJ1cHRfcmVxdWVzdCk7DQorDQorLyoqDQorICogcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9p
bnRfY2IoKSAtDQorICogICByZWdpc3RlciBhIHZDUFUgaGFyZHdhcmUgaW50ZXJydXB0aW9uIGNh
bGxiYWNrDQorICogQGlkOiBwbHVnaW4gSUQNCisgKiBAY2I6IGNhbGxiYWNrIGZ1bmN0aW9uDQor
ICoNCisgKiBUaGUgQGNiIGZ1bmN0aW9uIGlzIGNhbGxlZCBldmVyeSB0aW1lIGEgdkNQVSBnZXRz
IGhhcmR3YXJlIGludGVycnVwdGlvbi4NCisgKi8NCitRRU1VX1BMVUdJTl9BUEkNCit2b2lkIHFl
bXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfaW50X2NiKHFlbXVfcGx1Z2luX2lkX3QgaWQsDQorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWVtdV9wbHVnaW5fdmNwdV9p
bnRfY2JfdCBjYik7DQorDQogdHlwZWRlZiB2b2lkDQogKCpxZW11X3BsdWdpbl92Y3B1X3N5c2Nh
bGxfY2JfdCkocWVtdV9wbHVnaW5faWRfdCBpZCwgdW5zaWduZWQgaW50IHZjcHVfaW5kZXgsDQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50NjRfdCBudW0sIHVpbnQ2NF90IGEx
LCB1aW50NjRfdCBhMiwNCmRpZmYgLS1naXQgYS9wbHVnaW5zL2NvcmUuYyBiL3BsdWdpbnMvY29y
ZS5jDQppbmRleCBlYjkyODFmZTU0Li5iNmZiZmUyMGU5IDEwMDY0NA0KLS0tIGEvcGx1Z2lucy9j
b3JlLmMNCisrKyBiL3BsdWdpbnMvY29yZS5jDQpAQCAtNTM5LDYgKzUzOSwyMyBAQCB2b2lkIHFl
bXVfcGx1Z2luX3ZjcHVfcmVzdW1lX2NiKENQVVN0YXRlICpjcHUpDQogICAgIH0NCiB9DQoNCisv
Kg0KKyAqIERpc2FibGUgQ0ZJIGNoZWNrcy4NCisgKiBUaGUgY2FsbGJhY2sgZnVuY3Rpb24gaGFz
IGJlZW4gbG9hZGVkIGZyb20gYW4gZXh0ZXJuYWwgbGlicmFyeSBzbyB3ZSBkbyBub3QNCisgKiBo
YXZlIHR5cGUgaW5mb3JtYXRpb24NCisgKi8NCitRRU1VX0RJU0FCTEVfQ0ZJDQordm9pZCBxZW11
X3BsdWdpbl92Y3B1X2ludF9jYihDUFVTdGF0ZSAqY3B1LCBpbnQgaW50ZXJydXB0X3JlcXVlc3Qp
DQorew0KKyAgICBzdHJ1Y3QgcWVtdV9wbHVnaW5fY2IgKmNiLCAqbmV4dDsNCisgICAgZW51bSBx
ZW11X3BsdWdpbl9ldmVudCBldiA9IFFFTVVfUExVR0lOX0VWX1ZDUFVfSU5UOw0KKw0KKyAgICBR
TElTVF9GT1JFQUNIX1NBRkVfUkNVKGNiLCAmcGx1Z2luLmNiX2xpc3RzW2V2XSwgZW50cnksIG5l
eHQpIHsNCisgICAgICAgIHFlbXVfcGx1Z2luX3ZjcHVfaW50X2NiX3QgZnVuYyA9IGNiLT5mLnZj
cHVfaGFyZGludDsNCisgICAgICAgIGZ1bmMoY2ItPmN0eC0+aWQsIGNwdS0+Y3B1X2luZGV4LCBp
bnRlcnJ1cHRfcmVxdWVzdCk7DQorICAgIH0NCit9DQorDQogdm9pZCBxZW11X3BsdWdpbl9yZWdp
c3Rlcl92Y3B1X2lkbGVfY2IocWVtdV9wbHVnaW5faWRfdCBpZCwNCiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBxZW11X3BsdWdpbl92Y3B1X3NpbXBsZV9jYl90IGNiKQ0K
IHsNCkBAIC01NTEsNiArNTY4LDEyIEBAIHZvaWQgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9y
ZXN1bWVfY2IocWVtdV9wbHVnaW5faWRfdCBpZCwNCiAgICAgcGx1Z2luX3JlZ2lzdGVyX2NiKGlk
LCBRRU1VX1BMVUdJTl9FVl9WQ1BVX1JFU1VNRSwgY2IpOw0KIH0NCg0KK3ZvaWQgcWVtdV9wbHVn
aW5fcmVnaXN0ZXJfdmNwdV9pbnRfY2IocWVtdV9wbHVnaW5faWRfdCBpZCwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxZW11X3BsdWdpbl92Y3B1X2ludF9jYl90
IGNiKQ0KK3sNCisgICAgcGx1Z2luX3JlZ2lzdGVyX2NiKGlkLCBRRU1VX1BMVUdJTl9FVl9WQ1BV
X0lOVCwgY2IpOw0KK30NCisNCiB2b2lkIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX2ZsdXNoX2NiKHFl
bXVfcGx1Z2luX2lkX3QgaWQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBx
ZW11X3BsdWdpbl9zaW1wbGVfY2JfdCBjYikNCiB7DQotLQ0KMi4zOS41DQoNCg==

--_000_ME3P282MB27931E7D5FDC64EC4BD91C9DA692AME3P282MB2793AUSP_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Implemented the `qemu_plugin_vcpu_int_cb` callback to allow plugins to obse=
rve hardware and architecture-specific interrupts. Modified `cpu-exec.c` to=
 invoke the callback on hard interrupts, and added a test plugin (`countint=
`) to demonstrate its functionality.
 A similar approach was previously proposed (https://lists.gnu.org/archive/=
html/qemu-devel/2023-10/msg07359.html) but was not merged.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Changes since v1:</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
-&nbsp;Fixed build with `--disable-plugins`</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
Signed-off-by: marko1616 &lt;marko1616@outlook.com&gt;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<b>---</b></div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;accel/tcg/cpu-exec.c &nbsp; &nbsp; &nbsp; &nbsp;| 11 +++++</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;contrib/plugins/countint.c &nbsp;| 90 +++++++++++++++++++++++++++++++=
++++++</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;contrib/plugins/meson.build | &nbsp;2 +-</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;include/qemu/plugin-event.h | &nbsp;1 +</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;include/qemu/plugin.h &nbsp; &nbsp; &nbsp; | &nbsp;5 +++</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;include/qemu/qemu-plugin.h &nbsp;| 17 +++++++</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;plugins/core.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| 23 +=
+++++++++</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;7 files changed, 148 insertions(+), 1 deletion(-)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;create mode 100644 contrib/plugins/countint.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
index cc5f362305..e4113f8966 100644</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
---&nbsp;a/accel/tcg/cpu-exec.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+++&nbsp;b/accel/tcg/cpu-exec.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-34,6 +34,9 @@</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;#include &quot;tcg/tcg.h&quot;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;#include &quot;qemu/atomic.h&quot;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;#include &quot;qemu/rcu.h&quot;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#ifdef CONFIG_PLUGIN</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#include &quot;qemu/plugin.h&quot;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#endif</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;#include &quot;exec/log.h&quot;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;#include &quot;qemu/main-loop.h&quot;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;#include &quot;exec/icount.h&quot;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-818,7 +821,15 @@&nbsp;static inline bool cpu_handle_interrupt(CPUS=
tate *cpu,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * True when it is, and we =
should restart on a new TB,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; * and via longjmp via cpu_=
loop_exit.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; */</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#ifdef CONFIG_PLUGIN</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;const int prev_interrupt_re=
quest =3D interrupt_request;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#endif /* CONFIG_PLUGIN */</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (tcg_ops-&gt;cpu_exec_in=
terrupt(cpu, interrupt_request)) {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#ifdef CONFIG_PLUGIN</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (interrupt=
_request &amp; CPU_INTERRUPT_HARD) {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;qemu_plugin_vcpu_int_cb(cpu, prev_interrupt_request);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#endif /* CONFIG_PLUGIN */</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if (!tcg_ops-=
&gt;need_replay_interrupt ||</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;tcg_ops-&gt;need_replay_interrupt(interrupt_request)) {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
;replay_interrupt();</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/contrib/plugins/countint.c b/contrib/plugins/countint.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
new file mode 100644</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
index 0000000000..601b7f30d5</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
---&nbsp;/dev/null</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+++&nbsp;b/contrib/plugins/countint.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-0,0 +1,90 @@</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+/*</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* Copyright (c) 2025 marko1616</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;*</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* SPDX-License-Identifier: GPL-2.0-or-later</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;*/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#include &lt;stdio.h&gt;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#include &lt;glib.h&gt;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+#include &lt;qemu-plugin.h&gt;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+typedef struct {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;unsigned int vcpu_index;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;struct qemu_plugin_scoreboard *int_count;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+} IntStat;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static GHashTable *vcpu_int_table;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static GMutex lock;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static guint intstat_hash(gconstpointer key)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;const IntStat *s =3D key;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;return s-&gt;vcpu_index;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static gboolean intstat_equal(gconstpointer a, gconstpointer b)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;return ((IntStat *)a)-&gt;vcpu_index =3D=3D ((IntStat *=
)b)-&gt;vcpu_index;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static void intstat_free(gpointer key, gpointer value, gpointer user_data)=
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;IntStat *s =3D value;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;qemu_plugin_scoreboard_free(s-&gt;int_count);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;g_free(s);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static void vcpu_hardint(qemu_plugin_id_t id,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; unsigned int vcpu_index,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; uint32_t int_req)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;IntStat *stat =3D NULL;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;g_mutex_lock(&amp;lock);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;IntStat key =3D { .vcpu_index =3D vcpu_in=
dex };</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;stat =3D g_hash_table_lookup(vcpu_int_tab=
le, &amp;key);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;if (!stat) {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stat =3D g_new0(IntStat, 1)=
;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stat-&gt;vcpu_index =3D vcp=
u_index;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;stat-&gt;int_count =3D qemu=
_plugin_scoreboard_new(sizeof(uint64_t));</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;g_hash_table_insert(vcpu_in=
t_table, stat, stat);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;g_mutex_unlock(&amp;lock);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;qemu_plugin_u64_add(</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;qemu_plugin_scoreboard_u64(stat-&gt;int_c=
ount),</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;vcpu_index,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;1</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static void plugin_exit(qemu_plugin_id_t id, void *p)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;GList *stats =3D g_hash_table_get_values(vcpu_int_table=
);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;for (GList *it =3D stats; it !=3D NULL; it =3D it-&gt;n=
ext) {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;IntStat *stat =3D (IntStat *)it-&gt;data;=
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;uint64_t count =3D qemu_plugin_u64_sum(</=
div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;qemu_plugin_scoreboard_u64(=
stat-&gt;int_count)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;printf(&quot;vCPU %u: %&quot; PRIu64 &quo=
t; interrupts\n&quot;, stat-&gt;vcpu_index, count);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;g_list_free(stats);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;g_hash_table_foreach(vcpu_int_table, intstat_free, NULL=
);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;g_hash_table_destroy(vcpu_int_table);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+QEMU_PLUGIN_EXPORT</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,</div=
>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp;int argc, char **argv)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;vcpu_int_table =3D g_hash_table_new(intstat_hash, intst=
at_equal);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;qemu_plugin_register_vcpu_int_cb(id, vcpu_hardint);</di=
v>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);<=
/div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;return 0;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build</div=
>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
index fa8a426c8b..17e3b0ec27 100644</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
---&nbsp;a/contrib/plugins/meson.build</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+++&nbsp;b/contrib/plugins/meson.build</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-1,4 +1,4 @@</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
-contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotbloc=
ks',</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'countin=
t', 'hotblocks',</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 'hotp=
ages', 'howvec', 'hwprofile', 'ips', 'stoptrigger']</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;if host_os !=3D 'windows'</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;# lockstep uses socket.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h</div=
>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
index 7056d8427b..cd9f9eb25b 100644</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
---&nbsp;a/include/qemu/plugin-event.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+++&nbsp;b/include/qemu/plugin-event.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-16,6 +16,7 @@&nbsp;enum qemu_plugin_event {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_TB_TRANS,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_IDLE,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_RESUME,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_INT,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_SYSCALL,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;QEMU_PLUGIN_EV_FLUSH,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
index 9726a9ebf3..f1d5d91141 100644</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
---&nbsp;a/include/qemu/plugin.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+++&nbsp;b/include/qemu/plugin.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-61,6 +61,7 @@&nbsp;union qemu_plugin_cb_sig {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_udata_cb_t &nbsp; &nbsp; &nbsp;vcpu_ud=
ata;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_tb_trans_cb_t &nbsp; vcpu_tb_trans;</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_mem_cb_t &nbsp; &nbsp; &nbsp; &nbsp;vc=
pu_mem;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;qemu_plugin_vcpu_int_cb_t &nbsp; &nbsp;vcpu_hardint;</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_syscall_cb_t &nbsp; &nbsp;vcpu_syscall=
;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;</di=
v>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;void *generic;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-160,6 +161,7 @@&nbsp;void qemu_plugin_vcpu_exit_hook(CPUState *cpu=
);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb=
);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;void qemu_plugin_vcpu_idle_cb(CPUState *cpu);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;void qemu_plugin_vcpu_resume_cb(CPUState *cpu);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_request);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;void</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,</di=
v>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-242,6 +244,9 @@&nbsp;static inline void qemu_plugin_vcpu_idle_cb(C=
PUState *cpu)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;{ }</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+static inline void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_re=
quest)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{ }</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;static inline void</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uin=
t64_t a2,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; uint64_t a3, uint64_t a4, uint64_t a5, uint64_t a6,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
index 3a850aa216..65096c4c64 100644</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
---&nbsp;a/include/qemu/qemu-plugin.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+++&nbsp;b/include/qemu/qemu-plugin.h</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-728,6 +728,23 @@&nbsp;const void *qemu_plugin_request_time_control=
(void);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;QEMU_PLUGIN_API</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;void qemu_plugin_update_ns(const void *handle, int64_t time);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+typedef void</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+(*qemu_plugin_vcpu_int_cb_t)(qemu_plugin_id_t id,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; unsigned int vcpu_index,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; uint32_t interrupt_request);</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+/**</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* qemu_plugin_register_vcpu_int_cb() -</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* &nbsp; register a vCPU hardware interruption callback</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* @id: plugin ID</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* @cb: callback function</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;*</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* The @cb function is called every time a vCPU gets hardware interru=
ption.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;*/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+QEMU_PLUGIN_API</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+void qemu_plugin_register_vcpu_int_cb(qemu_plugin_id_t id,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;qemu_plugin_vcpu_int_cb_t cb);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;typedef void</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vc=
pu_index,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; int64_t num, uint64_t a1, uint6=
4_t a2,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
diff --git a/plugins/core.c b/plugins/core.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
index eb9281fe54..b6fbfe20e9 100644</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
---&nbsp;a/plugins/core.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+++&nbsp;b/plugins/core.c</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-539,6 +539,23 @@&nbsp;void qemu_plugin_vcpu_resume_cb(CPUState *cp=
u)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+/*</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* Disable CFI checks.</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* The callback function has been loaded from an external library so =
we do not</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;* have type information</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;*/</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+QEMU_DISABLE_CFI</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_request)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;struct qemu_plugin_cb *cb, *next;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;enum qemu_plugin_event ev =3D QEMU_PLUGIN_EV_VCPU_INT;<=
/div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;QLIST_FOREACH_SAFE_RCU(cb, &amp;plugin.cb_lists[ev], en=
try, next) {</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;qemu_plugin_vcpu_int_cb_t func =3D cb-&gt=
;f.vcpu_hardint;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;func(cb-&gt;ctx-&gt;id, cpu-&gt;cpu_index=
, interrupt_request);</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; qemu_plugi=
n_vcpu_simple_cb_t cb)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
@@&nbsp;-551,6 +568,12 @@&nbsp;void qemu_plugin_register_vcpu_resume_cb(qem=
u_plugin_id_t id,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);=
</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+void qemu_plugin_register_vcpu_int_cb(qemu_plugin_id_t id,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;qemu_plugin_vcpu_int_cb_t cb)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp; &nbsp;plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INT, cb);</d=
iv>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; qemu_plugin_simple_cb_t =
cb)</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;{</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
--</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
2.39.5</div>
<div class=3D"elementToProof" style=3D"line-height: 19px; font-family: Apto=
s, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif;=
 font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_ME3P282MB27931E7D5FDC64EC4BD91C9DA692AME3P282MB2793AUSP_--

