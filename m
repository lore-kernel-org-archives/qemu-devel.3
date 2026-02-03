Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67AAE83041
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 02:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn5vG-0007Xn-3p; Mon, 02 Feb 2026 21:13:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5vD-0007UX-Mn; Mon, 02 Feb 2026 21:13:44 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vn5vB-0007dQ-Cg; Mon, 02 Feb 2026 21:13:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPbFtZulFDpH6jEh9A0OnWoqCs/ZC/VSRfEMLRiRPFIlXX60lpH+51MMw72z3Evjgknn91qtEQ1LST1o0N2aePAZYdNwplCS8jfJJ5rnai8q4hNw8xKbnhVjVAH/5dFTkqb8lRwmmaN+LcyNJ6eaEFnYHLa9tojJVVw80wjko/2sSZexSErE4MiCrz+JpEjU8IhRbzdtPiGK3RXffSaM2eQqyEqTAbv7ECN+wvxxPyU0od3GxUrIRPMSf4JA7I8rG5zXf2zQgi5RKQdIBBP2zrw/vpmV0+CfzbNRUv984zFEg4jj2AWP7tVoe8a7N0vPFi/tUQ43lCg+Y1nPhh6qyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p3yenWgPaCg3EcT0WJN+PWyzga+jl4EH6npgimwWXb4=;
 b=uxW4o4MGmbUt7VzER8e5cJRTjTPFojgyc1k1tLhlG+sEqiva9G+XisyIoJoMW33aPEi+lrANHaIT5XjoEVkOB9YoI7+1zhX27vKoBp4vZvYXY0JELNYwi9c6mbzzVF3jVf41uum0dM0WlF12aWoNpLIzspREPgWh4EtQYhTSLrn5znKZgk9QqtDbK0yAo+6EAI1HXJ6Sy+9oXkNm1NQiS6NwhsUM22E7LyKPtpSaiJLtsQaXSuLKacJevWq9rvK2S/Yq61sCr6iTBba3D+T2zwyu5dDHhLhzhvsZVlf9vCbYqVOJ5fK0Ssk0OuZ1Obt9yrGSLZqoStx/nGRscg9Diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3yenWgPaCg3EcT0WJN+PWyzga+jl4EH6npgimwWXb4=;
 b=nTljp5IFMvRAkYY5KE4yMfO2c0dOctZc8hEbgJlWdCUIapjRyXjyYPLrTw4H/UgqaUa4UNuZylLj/X1FqsNLzHMzg7GzOUebxeAm/C6Jq+zeTD4L7W7RdbLwGH8rvEM4FSEzm+R6+Dp7c1nJbLtWSwIaaOVk2N1jI2ewSfQQ/HNHl9YMrKch0PEDr0p6TZcyYPi45bz2Ar1uTm1fwjpSGbE7N+lcYe+wOoDoXy0KGC1Zy3OYyfjVUHWPi37X+abw6YEVX97kvtuJhKm16NqH2fNaHTVmC1MXUkS/6xjPkVD5IEW/0W9QJ0hvi2dqaT/DZ/qNNmaDa/O90Wa/uAuh4g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYPPR06MB8243.apcprd06.prod.outlook.com (2603:1096:405:382::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 02:13:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 02:13:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, "leetroy@gmail.com" <leetroy@gmail.com>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "pierrick.bouvier@linaro.org"
 <pierrick.bouvier@linaro.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: RE: [PATCH v1 0/8] Update test ASPEED SDK v11.00 for AST2700 A1
Thread-Topic: [PATCH v1 0/8] Update test ASPEED SDK v11.00 for AST2700 A1
Thread-Index: AQHclAveT/dWSLHLHE+hbyZCdC6webVvoVKAgACa+NA=
Date: Tue, 3 Feb 2026 02:13:30 +0000
Message-ID: <TYPPR06MB820603D065385CD29FD62E6AFC9BA@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <SE3PR06MB8199F4B0069F9326034585D6FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
 <6985a23e-b796-45d3-a786-a9b87ae04ab3@kaod.org>
In-Reply-To: <6985a23e-b796-45d3-a786-a9b87ae04ab3@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYPPR06MB8243:EE_
x-ms-office365-filtering-correlation-id: 244c69ef-dfaa-4df8-0bf8-08de62c9d375
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?djNWUUJMZ2liR0FUMm1zSFdKQlBCMzFnQk0wQWN3STRzOGNDempsak5BQ294?=
 =?utf-8?B?VFA0ZXpWWSs0NFpmcGNuVmk0U3hnNDlOaEFvVVk1dmRTL3M4eWtwbG15Vzdz?=
 =?utf-8?B?cGFiTERWVXg3bDAzZzFnNnFwS2NlYTBUSlEwenVPMWJQMS80YkRRd3dNbG1C?=
 =?utf-8?B?NXJMWEpMRDJTL1ltaitzSENlclFmaUtpSEx4cFFRVG1JQkxBU1pYdzhTd2ht?=
 =?utf-8?B?SE1Hd3U0QjNSTG12L0RGQWVMOEhUYzJ5bmk1ZWtvUWpRajF2cW9oLzczVTRw?=
 =?utf-8?B?Q3lhemhTTmh4ZUFNVFhxVktndjJQdDlrM1c3d0Y0OFZ3RVZNUEtWQU1VMFZC?=
 =?utf-8?B?UnVhV1dGQndJWkE0SnEvZXZ3dk12R2ZvMFZMNEJaVmVlYmcyTWtJdWNEbDZz?=
 =?utf-8?B?UjByOU0zVVg0NkcySHlob0ZqL2FtQ1I4KzRVVXNkc3FVUk1EbWVhMnRHd3ha?=
 =?utf-8?B?a21hUkRhcVlMMHhHelpvOXRtQmxhZVIreXY4ZlhSc0pJQ3JVb1F2eDI5OU04?=
 =?utf-8?B?ais2UFBZdjd2Q1dJZ25NRlF5MGY1bk1ITG5pUGRTUWFMM2kxVksyWnA0UXRH?=
 =?utf-8?B?d0Rob1FMYjlDOG13UEZlZmRNdEgzUmdFYXNCZE9GMSsyTXNkc2xZY0ZwUUFz?=
 =?utf-8?B?a3NHd0xweEtVVDRHeG5VYmZVMlRKeGJUZlQyNjl4N29nbnh0bldQMnNYeEhI?=
 =?utf-8?B?QmU2cGFWdVJPSVcvTW9PbThWZG5WOEVxSmpaZHNIdGFqd0p1Z0czdlpZRkh3?=
 =?utf-8?B?QUwwcElrVkFsQmxiUUZZYzltMk1Nb2xtVlFQRmhTQ0pJOHBkOVdETDlEeksy?=
 =?utf-8?B?Tk1EekJ1c0dyYlc4WVFKMzVDa25kalMwZTVWOXIwTHM4ZjAvUkNUTmRwbG8v?=
 =?utf-8?B?eGQ0Rm1TWjQ3QzArKzRlTzM5RERsTU9kMHByU0tMS2hydlFuclV3MjRqV0x5?=
 =?utf-8?B?cUZTU0hnK01iblNQdGx2djJ1NTl1dXl4bW82a2FsaDJ2T0tYdU1ybmFDWmZy?=
 =?utf-8?B?RmdEckVhT1lVRFZZUy9SbCtpN1l0L2cyT3lPTXZBQ1FTUXlZNVFWdG9wZGhY?=
 =?utf-8?B?aUNXQUJkbW5ZWHAwTjVKdWJDb0Z0SElPT2JSRzVsN05TSXZXa3hsZ01tZGV1?=
 =?utf-8?B?Y1FzZnF4VCtKdlNJQnJBSzNCaTVFU01uanJxMHI2U2dJdnd0ajYrUHhPZVUw?=
 =?utf-8?B?MmhyRjlRdVF0UlZ0QVZldXpXVUxCK0c5MDdla2lxVUhhQ3ozWFJXNktlUFNN?=
 =?utf-8?B?YjI4V01WL243Tzh2TDBFK1EyUVpMcG9TOXNNM1B5cFlFcVIwM2pmelFSL243?=
 =?utf-8?B?M0pwK05UcHZkM2ZqS0pwVDVyeTJMVGJocW5mRXEzWThQdmFqcUZURDFXTjY4?=
 =?utf-8?B?ZlRqdXdxU2o5UUpVR3dlZGhleXM4TUxHZjhUcGFyRHRBa0JFNGNId20wQmho?=
 =?utf-8?B?VHZuSHBYSm1rbjIxMUxxREsrQVpMa1p6U0FMRTlIMURsaHpMTzFJMjlNWmto?=
 =?utf-8?B?ZXVvV1JNRFJUNzFqNmFoL1FmTDFMRmQwSjhCUnFwa09qdVYvbWZ2YVR4STRj?=
 =?utf-8?B?SmpwNXArUmJQRUluQVdoVXFvU3JacldodFVuWUxPNGg5SjdDZkQ1U280STFP?=
 =?utf-8?B?UEFzWHU3K051U3UyWURKUWltQTVvaTNvTFhkblVtcnZPUmVxR0tXSGticzJP?=
 =?utf-8?B?WnpnaXJoQmt6SndnRS9MRVBucGtnQVpSbE8rUFVGUCtsM3ZrZFVpS05ITzdI?=
 =?utf-8?B?Vms3QnM3MmNySjJXV1ByV09OdXNlM28wYWsweHlJbEF6RWI0N2ZhWGZBSVFw?=
 =?utf-8?B?V2lZcnp2UmVhMVlrL0hIeVZOWWEyenc4YjdhTzFRSmlqZ3hmdW5Fb3d1YjZB?=
 =?utf-8?B?N3lKRjFUUnpFUTd6ZlFLdnk4NFRJemZ0RmZBdm5nZkVkNFhsa2I0Y2FVNWJx?=
 =?utf-8?B?TDVjbTFvT3dTYnVJWFFHcVFINElwL3lZUzdmbVVBeWlsL1FSQjZNNEgwek5k?=
 =?utf-8?B?bXFWbVgyMGpTWDdsQ2dBZWxZRVR1L0tmL0laeGJVQ3QxRmYzTlhuR2NzZ1ox?=
 =?utf-8?B?SE96bm1MSTFBdVprRklLeWc0U3pHVTdrN3ovNGU3MEFJanFqOFJadjhTRFc1?=
 =?utf-8?Q?2GiSSCeAY9sXKeC4UMq5rcJV5?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QjAxUEkrMUY1VzBGZ1JCR1JNK0h3RnpxZ3BYNFh3YlFETWErbW4yNzBET2kv?=
 =?utf-8?B?MHpsZE1Yd1M5NWFCS0RlUWMxamlJT2VrZWZVZHI4bGRqK0hsQ3kxbEZMS005?=
 =?utf-8?B?NDFweis5elQxK1NaS2lQZ2dZZ1pCcFRmem0wWGpHdHYvcUNqZjRtbmttd1pt?=
 =?utf-8?B?dEYxU1JOSENYUmczd2FySDZuTGE0eWpWYWFzMmNKQWRGRjBpUU9jY2hwT2lM?=
 =?utf-8?B?bkVEemdCbnJpUklJRWsrZENIRkN5NmQ2K2ZqMjRka2p6YnBxVnF1QmRFS21k?=
 =?utf-8?B?QWthREt1RUM1M1dweWp4eHFQdnRRWE9pdVBuUlJiMnpDL2tQcEkyRGZGcnhn?=
 =?utf-8?B?Znp1dkR0ZTF2S1FoQU5EYUN5WDg2aWJ2Q3kySkpZQSt5QndhN1dJb2EzOHYz?=
 =?utf-8?B?enhCd3ZieW4rU0l6V0lTNnBLdXVpMGE4OGdRc21WR3Q2eXMzZVZyOHQrYk5F?=
 =?utf-8?B?Y3BkNkd2Zi9hOWlqdmRUc2VhSWxSSm9mU0U2c091cjdKVUxGMDNGUFUremFR?=
 =?utf-8?B?T3FpYm1tcDlpYlh0Zm5qRitqblp1MmhqQXZySUxrTjJ2a1RoZmluMFE5bzZu?=
 =?utf-8?B?aVBYQ0ZuSXh6UnhjcUZDdngyOE5hSlFGUy9iMGJPYUxGNDVjYVVDc05IUTl0?=
 =?utf-8?B?VUxrZXVkNFoyNXdBUUF2OTRkV1g5KzZQdGYxVkxqdzVEUm40VW1VNm1nVElD?=
 =?utf-8?B?Z096VzBGMFRkbGNFd0ZpY09CT1kzTlZJTm5LUW9VZjlJN3Y5b3NWQjBZOHkw?=
 =?utf-8?B?L2lFeTZvelNVSXRrc0lCdlJ5UVl0SVhqUERaK3l5M2tQN2VRai8rSTFTQTM2?=
 =?utf-8?B?TitFd2VYNzlZblFwZlNja0dCcFhpMW5zMDhQaVFkK2I3Z2JNYko2RDRyMC9O?=
 =?utf-8?B?TzJmWnhmcjRtNGNSOU5KZHQxR0RGMHdmQmZqN3R0eGJ1TEsxYzE0dld2OTBF?=
 =?utf-8?B?QjM1TlJPMVZyOTRtQi8vWVcxV2xvUkRSczZCUmRSY0VmZ0R1aWpqeVk2MUtk?=
 =?utf-8?B?ZXhOU1pOVnJQd1lmNktkbSthcGdVQTJVbDhIY2hyR2VTampGdlZrT1NtdFpN?=
 =?utf-8?B?QjAzdEpweHlJVzYzb2lTd0lROG01RGMvY2w2bm9YVGRMUUtVaXFpYlJZd2sw?=
 =?utf-8?B?d3JXbWsxWnNkYVo4b3Ewa1htZ2R2Q0hnUFd5UUlPcnZ4cjJyTjU5WVh1UWVr?=
 =?utf-8?B?NWxnMDhSS014aE1obGY3UWxLR01RelVVcE9kZE9JeDdTNndGRHdRek8vd3dS?=
 =?utf-8?B?UWZDSzY3OTRuWTBqeTE3dE1mam1ZZ204M1FNc0t3dWhSVlpaaEpzbENXa0hh?=
 =?utf-8?B?Q0RoWG1rVlZjWTlIdWY3NWY3Vk1UT0RjZnUxOURDSHlaTE9zK01BTThuYU1F?=
 =?utf-8?B?TzMrZktDYjBOczNnaGFQaXpPMHdRVFpRRy9ONlpydVBxTmlsTy90STd4Tncz?=
 =?utf-8?B?QlNsMEIzSEdDQmVMTVVnTTNxNU15WTJtYTBwODhaNXZ4VjFzTU8xajY0bTht?=
 =?utf-8?B?cU52K3E3RFlvVDNQLzNGUlB0WXkzRHVQeEh5ZzcyL0FzTFF4ek11RFVvb0lj?=
 =?utf-8?B?MDhGdHc4Z0tNSnpOcGhiWE55cXNCQUxvUW5oek0vSVdCVVh6UHIzbmdHTmx5?=
 =?utf-8?B?bUN3UWNEcS81UXdQTGdPUGNoc3E3MVZvQmowVkw1ZXdXZXlxbUM0RUxBZ0ZW?=
 =?utf-8?B?b3cxWksyUU1EbFFLOGJPdjJ1L0RkRFovMVFvSm1qNEhIK1FnSlNKQ05LUk5j?=
 =?utf-8?B?Mi9lZmcxRnM2U1FLWXBVbFhvMkhHd2xsV0wyWkhRUjBBQlVlcUJ1alFkOTdL?=
 =?utf-8?B?S3VIZEg1bFJuL2NEV1F4RENSUDg1NENvUGN1eUljcUxUbENNbmc4OXptRXh0?=
 =?utf-8?B?S0NIekNRdzdLcUs5dEN4SDZJM0F4MHhCM0R6ZjhkamJWbldiM0tRWVJyUitk?=
 =?utf-8?B?a3IyQWVrekdmRmQ5VVR6T2JIb09QWkVka0tUUlFud0lLdklLRjN0Y0UvTTFy?=
 =?utf-8?B?bmdsNmlZaU5BNUFreURQbWFBQ0REQ0FqNFF2SlJaWXVJNzNJRUtNQzBEajhO?=
 =?utf-8?B?M055MDhHYUh3aVJ2RytLVVpmRXVLZklVQXBVNkdQNUxaSHMwU3I3SzQvc1JE?=
 =?utf-8?B?SHE0QzhsS0tybUdCazk4OUpXbmRwcC92Sm1iN3RBVHZrR2lmSnlGUnpLWS9W?=
 =?utf-8?B?NnFERzVTdUlzMDZhQzVSWTZObzV5WDVscnk2MjdGQXFUUUVZMnlYVGlEbUdP?=
 =?utf-8?B?YmNnaEZzVW9lU09pSnFQOGJmekF5UmtNSWdrY0w5aXdDd1VoeCtqR2UzVm5Z?=
 =?utf-8?B?eXVpUWxhUk90UnpEQnA1VnBjelhSU0U2dTlaaVQzdzVlWHg4Tzgvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244c69ef-dfaa-4df8-0bf8-08de62c9d375
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2026 02:13:30.7792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFWus2P0VnADdMjFwpO0l4K3WZ10ASITgRKHTfmphyJ22d80EPq98uIOCuDJl33ysKW+618GFbj9IrHUszUVRoFXub7aJlKvmpfF0tHKbt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYPPR06MB8243
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMC84XSBVcGRhdGUgdGVzdCBB
U1BFRUQgU0RLIHYxMS4wMCBmb3IgQVNUMjcwMCBBMQ0KPiANCj4gT24gMi8yLzI2IDA3OjE5LCBK
YW1pbiBMaW4gd3JvdGU6DQo+ID4gRnJvbTogSmFtaW4gTGluIDxqYW1pbl9saW5AYXNwZWVkdGVj
aC5jb20+DQo+ID4NCj4gPiB2MQ0KPiA+ICAgMS4gVXBkYXRlIHRlc3QgQVNQRUVEIFNESyB2MTEu
MDAgZm9yIEFTVDI3MDAgQTENCj4gPiAgIDIuIEZpeCBETUEgbW92aW5nIGRhdGEgaW50byBpbmNv
cnJlY3QgYWRkcmVzcyBmb3IgSTJDDQo+ID4gICAzLiBGaXggRUhDSTMvNCBJUlEgcm91dGluZyB0
byBHSUMNCj4gPg0KPiA+IEphbWluIExpbiAoOCk6DQo+ID4gICAgaHcvYXJtL2FzcGVlZF9hc3Qy
N3gwOiBGaXggRUhDSTMvNCBJUlEgcm91dGluZyB0byBHSUMNCj4gPiAgICBody9hcm0vYXNwZWVk
X2FzdDI3eDA6IFNvcnQgU1NQIGFuZCBUU1AgbWVtbWFwIHRhYmxlcyBieSBhZGRyZXNzDQo+ID4g
ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwOiBTb3J0IFNTUCBhbmQgVFNQIElSUSBtYXBzDQo+ID4g
ICAgaHcvaTJjL2FzcGVlZF9pMmM6IEZpeCBETUEgbW92aW5nIGRhdGEgaW50byBpbmNvcnJlY3Qg
YWRkcmVzcw0KPiA+ICAgIHRlc3RzL2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9hc3Qy
NzAwOiBFbmFibGUgUENJZTIgRFRTIHN0YXR1cw0KPiA+ICAgICAgZm9yIEFTVDI3MDAgdGVzdHMN
Cj4gPiAgICB0ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMDogVXBk
YXRlIHRlc3QgQVNQRUVEIFNESw0KPiA+ICAgICAgdjExLjAwIGZvciBBMQ0KPiA+ICAgIHRlc3Rz
L2Z1bmN0aW9uYWwvYWFyY2g2NC90ZXN0X2FzcGVlZF9hc3QyNzAwZmM6IFVwZGF0ZSB0ZXN0IEFT
UEVFRA0KPiBTREsNCj4gPiAgICAgIHYxMS4wMCBmb3IgQTENCj4gPiAgICBkb2NzL3N5c3RlbS9h
cm0vYXNwZWVkOiBMb2FkIHJhdyBVLUJvb3QgaW1hZ2UgaW4gQVNUMjcwMCBib290DQo+IGV4YW1w
bGUNCj4gPg0KPiA+ICAgZG9jcy9zeXN0ZW0vYXJtL2FzcGVlZC5yc3QgICAgICAgICAgICAgICAg
ICAgIHwgIDggKy0NCj4gPiAgIGh3L2FybS9hc3BlZWRfYXN0Mjd4MC1zc3AuYyAgICAgICAgICAg
ICAgICAgICB8IDE0ICstLQ0KPiA+ICAgaHcvYXJtL2FzcGVlZF9hc3QyN3gwLXRzcC5jICAgICAg
ICAgICAgICAgICAgIHwgMTQgKy0tDQo+ID4gICBody9hcm0vYXNwZWVkX2FzdDI3eDAuYyAgICAg
ICAgICAgICAgICAgICAgICAgfCAgMiArDQo+ID4gICBody9pMmMvYXNwZWVkX2kyYy5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCA4Nw0KPiArKysrKysrKysrKysrLS0tLS0tDQo+ID4gICAu
Li4vZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfYXNwZWVkX2FzdDI3MDAucHkgfCA3OCArKysrKysr
KysrLS0tLS0tLQ0KPiA+ICAgLi4uL2FhcmNoNjQvdGVzdF9hc3BlZWRfYXN0MjcwMGZjLnB5ICAg
ICAgICAgIHwgNTQgKysrKysrLS0tLS0tDQo+ID4gICA3IGZpbGVzIGNoYW5nZWQsIDE1MyBpbnNl
cnRpb25zKCspLCAxMDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gDQo+IFBsZWFzZSByZXNlbmQgdGhl
IHNlcmllcyBpbiBhIHRocmVhZGVkIHdheS4NCj4gDQpPdXIgbmV3IHNvbHV0aW9uIGlzIG5vdCBh
YmxlIHRvIHNlbmQgcGF0Y2hlcyBhcyBhIHRocmVhZC4NClRoZXJlZm9yZSwgSSByZXNlbnQgdjIg
dXNpbmcgdGhlIHByZXZpb3VzIGFwcHJvYWNoLg0KDQpbUEFUQ0ggdjIgMC84XSBVcGRhdGUgdGVz
dCBBU1BFRUQgU0RLIHYxMS4wMCBmb3IgQVNUMjcwMCBBMSAoUkVTRU5EKQ0KaHR0cHM6Ly9wYXRj
aGV3Lm9yZy9RRU1VLzIwMjYwMjAzMDIwODU1LjE2NDI4ODQtMS1qYW1pbi5fNUZsaW5AYXNwZWVk
dGVjaC5jb20vDQoNClRoYW5rcy1KYW1pbg0KDQo+IFRoYW5rcywNCj4gDQo+IEMuDQo=

