Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FA7C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9PHq-00083X-4o; Tue, 21 May 2024 09:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHZ-0007kW-IM
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:58 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s9PHW-0001by-NO
 for qemu-devel@nongnu.org; Tue, 21 May 2024 09:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1716297114; x=1747833114;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0dE/fO+DHZfygGNvv8Lx3q8Dt93nwgJmL7gxtEqEPQA=;
 b=c/j4I7bhSuKLF1i38R74cJRFh3GpVRhdvwCnCK9o+WWv/0O9vhuzHY9y
 yoRVP/cFcfFGam4Ri5vklY5sOtJ/JV5CaYDOvx/ebx1JGUneP2tNXwnhh
 6rRO/ZGE+01xApFSB2d6P33/eAoahgI/jFasPfHS9WiEY60QcRKuu5vM+
 P7GWeuuoSGYmSVan6HO/HIMp2iJEZtY4cFXmXeqvMZLUvMx0Uy4w4mJWb
 M0xU3Hsn/HJx67ExTS5ztbBUCrkjVXgRpcxkLhJD2ohldcNIkmr+wAGwJ
 Gr2KrL3F5lLPmWND7sV6GlCny/UxA1ek+DIZLF6Gv1n5FIXBk47NzylRl A==;
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; d="scan'208";a="13004111"
X-MGA-submission: =?us-ascii?q?MDGq8+OYkkOKG5+DJmqOPG8PEpenaY6pYbuyD+?=
 =?us-ascii?q?Ap6RQ2Hbe+2Q1ANRCkLmb2Iu7V73i0SCtWFjYKT0JIwcP5cCo3kPzB6U?=
 =?us-ascii?q?7aQV5tGS/a9qkjjEAlp8sBVvEtHGzSC0a4AMxSsAV/I/FPVuVi98/V/S?=
 =?us-ascii?q?OvtFqCzvjPi34uxL1cu0HK2g=3D=3D?=
Received: from mail-dbaeur03lp2169.outbound.protection.outlook.com (HELO
 EUR03-DBA-obe.outbound.protection.outlook.com) ([104.47.51.169])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 15:11:53 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So5HxPW4MaavwqEFJLCKCVhkGx790Wydd2gPOBXv2iRlLwy/Uwn1+dtavxtJyfivf2SvGdUvXQcbYcxdjho+tmOVP+yZc9gtg8IX2MICIKawH3TrrNzGsbGDgWOi0EL8QSNOAbQMCvVEioRLdwuVsmalVMzhyTBIyNSJUKhLQ5Pqj/9qyNUkr4HMGj0LDFGIEDNqqzV0PHrKG1YltAkkMnvgSGrToZUEkAr4vDZ8+NWdZWfMaevLYT7AM4yin5vU/gi0xhFYVp7ZKIe/L7xSWbk7eunl9UtfGzjJCnuUhrw5/gc93kTLjqQXhwrLx3vwmPsY0xn+4U29FF/JKKFpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dE/fO+DHZfygGNvv8Lx3q8Dt93nwgJmL7gxtEqEPQA=;
 b=XafJC83IpvbcXr/Bhq3DO2/9fu5mIwktaT/cWExmqfFhDHqhYC3daaxXKqwh2qaHi0AlSMZKlM0NL8Tg6nDLowPkftm2tOqUsIoEYl0Q2zAb6mEqa5qR5Dg6v0cfF79zuI4Yd7LTlXszdSaJ9Bg5BPw08x/ktufRLRhH6rQMNEURdkvpNffs+Ts5NkYs0kbrs3JSxv9+jZ1K5HXx74ePNdsm3EeYD+Tgq0/nJRzmzXVZMlMeur2hqACEmfqo6xksgaDP6d3FSv2GfMJDNU+Gf66N7Ya2WMadTFkSzA+60zRx3xtguMl5hxR3zH0fdFDigXz5OItgcVWWFsNkHbgWIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB8PR07MB6249.eurprd07.prod.outlook.com (2603:10a6:10:140::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Tue, 21 May
 2024 13:11:51 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 13:11:51 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd 19/22] memory: add an API for ATS support
Thread-Topic: [PATCH ats_vtd 19/22] memory: add an API for ATS support
Thread-Index: AQHaq4By7GJRtLEAU06I3NQX0IDNRg==
Date: Tue, 21 May 2024 13:11:51 +0000
Message-ID: <20240521130946.117849-20-clement.mathieu--drif@eviden.com>
References: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240521130946.117849-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB8PR07MB6249:EE_
x-ms-office365-filtering-correlation-id: 123c417a-4e6a-48a1-e56b-08dc79979491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dVFLZVdrc0hwMWFTWHlFcXNEY1pNSmpmNEU3d2FZMXZ6WForend2NzNKWTRw?=
 =?utf-8?B?TWFMdlpHNXVjME40VUViZ0NpczZ1RHF0aVloVjJHQ3U3WlY5UUZFeENPVytp?=
 =?utf-8?B?cUZJNndYSlc5TEN5ak9aMXI5SWVWSy82NTlQdkl6cCtLQk52Y1RuQnRVZS9a?=
 =?utf-8?B?bVl6OTh2U240c29PU0xwY1NwcklXNjhwWXBwY1BpalFRVlBPZkNESStoVzJs?=
 =?utf-8?B?dmZ5NndjZHZMRnl2eHN4OThqckJQYTF3YlM2WlMrTk1oampnVnRuRTNJN0hW?=
 =?utf-8?B?SlVwTFlGY0dFZmRqWEwxWmFTTEk2aFFRekdRMmVmZ2RCUEZkS2w2Z0dOdmJF?=
 =?utf-8?B?ZUxSTkFHM2NPTVhOeWc2ZGRUZUI5dDgxcCtYd3FhL280UWcvMnFaUWFka09i?=
 =?utf-8?B?MWowTU5oT2lsOFo4QzVveDQyQU0zRU50M2R1K0RzcFB5UDhaZ1NiU1JXVW9I?=
 =?utf-8?B?N090ZzJiVkNReWVtZHpwRXZ6VW9RRy93UDZ6NlFKM28wQXlMV0ExNTBPemds?=
 =?utf-8?B?VXhnQmVQTkFzaGtYOGRKQkl3UDFCREhuUXZGZmNjb3FkL09tRm81Yk5keW1U?=
 =?utf-8?B?U0hBODlha0d4anB1NGVhSjZnOWlwb29OV1U3NDJkdE14cHR4bGNQWmxmWDl4?=
 =?utf-8?B?VjBKVFd2VkVzVmpnS1pBTCt4aVdac0NycHV5YkdLa1hMOWo4Q0x0V0FnMXp4?=
 =?utf-8?B?eUhLN0VpSFVHZ1YrSXpzU2RjSktZaVhSY09ienhIWU9KaitpSk1aVGhuOXU4?=
 =?utf-8?B?Ulp0Y0d0TXRFL3p6dXFMYjlrTVkwUTYxWFdiMHpaU3JEK01iMWRvMzBSL1VG?=
 =?utf-8?B?TnlPSXJuZUtzdFBxUWEzNGZiMy8xZ2hBK09MajdnZml4a3dXdmdVbWk4Qkt4?=
 =?utf-8?B?K0NHSUs1aWdOUkl6L3FBZlE5amRBU2dwNE1vc0xCUWhNNitYbGFXbEhoS2VT?=
 =?utf-8?B?R2pqLzJaRFdtaWc4SW16THJPbXRSSnFxbk9FQkpIZ3JtTGhLLzhQYXltYWpv?=
 =?utf-8?B?RDhCYzJ6ZE05V3RuNllGUW9hQTU3clpUQWhnQ0pDdERPa3h0TzdtODEwdStW?=
 =?utf-8?B?ZWNVWERHTG5RUDRqSjkvZlZzMEdrb1h2Zlp5NDdSWjE5R1FYWUFCUFpZdUdv?=
 =?utf-8?B?bmtnaEw3UmNLY2QzQ0o0VXZrWHpoL1ZpcTdpVGpwOVIwOXlvOWwwTjVnUmwy?=
 =?utf-8?B?eVRyeFdqaHBUa2pJMjJKaEhWTG14K2Y2SnYyVWNnTEo1NmRzV3RHejVEc2xV?=
 =?utf-8?B?Z05JKzYwSUFsdVByc2tHaGE2RXdLNUFaRy9GSmdzNVVqdVhRSFBuWjdQYyt6?=
 =?utf-8?B?SVgzaFV5S3YyMlEzeWZmc3VRNzV3d1R6Tm9oSmgvdmdsd1JLb2Y5MUI4bTE1?=
 =?utf-8?B?UlMvaG1VVkdpV0RKNmZ2emtCaThab0FZdDk1c1lsanBDZW1UUlo2Um1ITjJK?=
 =?utf-8?B?VGdZaEpzdWNZN05ycC9jbG1TOHZFOHhGSllBWnFIcGtCdmRrdVZNN25mcDJw?=
 =?utf-8?B?bzIrajhRQ1VVQ0pYNWJMQnNmNkE0S0xUSGtlak1tdmc3a2NGcDloZ3pBSUhQ?=
 =?utf-8?B?UFo2OE0yNGVqMThSRTF0MUlIYUZOa0N6cS9lU2RqZVNLL2k1alBxOXh5WnJ3?=
 =?utf-8?B?d0ZsemJHSkxrSXpHQjFzdFBKTDhmdkQyeGU5TTU1TFN6OEdVZDdqdWdpWWpF?=
 =?utf-8?B?SnFZSVByMVR0ZmE3djdMbVF5UHpaVDd0dzVRSUhJUFZRcGovcWxrbGdycXpK?=
 =?utf-8?B?bkV2THJjMGJ0L3lpODM2aFhRUERBenJYU3R0dEFIdG1TdUlNWVlZRE9RV3py?=
 =?utf-8?B?emhLM1dENVlzVWNVa3Zhdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkY1c2tzaUFTeEo0Z0FMWVBSVjRSNEV2MkNKYkJZUEFJazV3Rk5vcXRzdHBD?=
 =?utf-8?B?MmtDcDhORlBZaXB5RU42QnpVbmhPVTVGaG5hcU9NQ3FqQlA3aDBFZGdNVm1S?=
 =?utf-8?B?V2oyUmd2ZkFhZUNrVGM4UEx6RHRHbkxHc0dPeG1pTmZUZWFuV0NBaVovMTZi?=
 =?utf-8?B?SFVkcThZaUo1SHFjQlA2SXU5KzloNEFoRkFXRWlocVF5cHUvU1BOWEhHRnN2?=
 =?utf-8?B?Vk1HUU14MTNxN1A1d1RtZFpHUGJFWFhINEhMT3FSdmhUa1BkbDBUTitkUFdq?=
 =?utf-8?B?WCtSZHlCckNMRUM3NGZQZmJNZkpIWkdWcXU3aktqVFhRK2djM1pudjNaVjZI?=
 =?utf-8?B?eTNxL2FJYTU1UVFOZC9XWk51d2J5akorUXQ4akFWQm5CSTVKYlNlWFdwZXo3?=
 =?utf-8?B?dlExYXkvcDlrZkZVRkxrUWZWTlZMdy9mSVU1SmtWbmFOVy9nQk1TZEl3Y3NS?=
 =?utf-8?B?bGRPMDZXT0U5U3Jvb0tnR0gyOFcrQ2FKcWppeDRQcGdRWjI0S1hONmROazUv?=
 =?utf-8?B?YVppTFQrQ2lEVURubFB6VWJ2T0luUkpUbnk5L1dwNjZFUUtJYVRibDJibGlQ?=
 =?utf-8?B?aUlvdUJzOEtMdm1Uai84cTJvS1hKdEg2WmtDcHlUVDAwaU1hT0dNNk9OZU53?=
 =?utf-8?B?Ny9GY2dEb3NaZ2NPYnB2cjUyblRkQzVQSWRRRy9PbFNIbElKT2pRMkNkWE9R?=
 =?utf-8?B?elFXaWJYTXRSbzhqaksrUXZIL1F6bTI0UHB2dHdXUGlFbFNvc3Q5REtaZzRq?=
 =?utf-8?B?UUY5V01SbVF3c3BBTE55SVRER1BDVk9BRWJVOUZvdUVVUUdIOE0vcittbXJq?=
 =?utf-8?B?MFpIV3ZwR3FpcjZhTWJmVFhoTTR0bG1USHlSdTUyam9odlpjVWV5M290M083?=
 =?utf-8?B?WmZ5VG8yNWc3b0txaEVra09PUGJUS0dldEtCc09lZGNLYTdnVkRWaVlNRkYx?=
 =?utf-8?B?MUNKcEE5L1RJZk4vOHg4bkxxNnpTY0k4VTNZblVwajlTZE8vT0FDTk5vRVpP?=
 =?utf-8?B?TWYvRVM3VXpQRVlaNytsREVLOEZVZFR1MWNmSHQzclozdFlmN0g2TUtKSVho?=
 =?utf-8?B?YmlYMGNXS2R3cmxnZm5SMk91bjdQSUNjRFVWL2l5b29GVDNrSXNIQ3R2bjg0?=
 =?utf-8?B?eGVUTEVGaHpLQzN5dUVSRUJUNmNrR2hEaURZNlRudVRBd3JsdlVHSG10bnZn?=
 =?utf-8?B?M2hXbCtHS3ovSVFkVEp0OTN0RCtwaFkvWUZNc1FpSTgyb0kxRjJmYVpRdkJt?=
 =?utf-8?B?VkVjOUlhWnYrcmU2RVpzTlRsRlNreG5lVkp6azY1TVJqTHV5MUhGR3NPczZU?=
 =?utf-8?B?bW9GVm1lNC9ONnBNN0dyeDUzSW1RYy90ZkpCNzAxR2NHbDNrYm1sZmpiei9Q?=
 =?utf-8?B?d2hrOS9kRVNTSmp4VWFwQURkK3VwVktMVVFINnBaeFNrQU9PU1VYUDBuY3Nk?=
 =?utf-8?B?NW41SFJUc0xwbzNLVm1SOSt2V0ZpRkg2cVlOYmxGT2E5dzRPdE5scXk1L2ly?=
 =?utf-8?B?M2lNUDUxZmJNNDQ4SGlYTEM2UlA0dTJmUDIzdktvR1o0d05RU2ZscmhidE81?=
 =?utf-8?B?MDFxdDVpWU02aldjVEFiaXliNlFVdDA3ZnNIQ2ZYRDlYSWYxZXpzMEJxZTFO?=
 =?utf-8?B?d1BMbnRzL3ROcWliMWZIVHJhYVJQdHNwWEFyd1J2bzZsdlRJQU5mQ3JVV2ZU?=
 =?utf-8?B?QU5tZzlQdCtzTW1xQzZQU3BGSys0V3A4czJtTVAyUHFmeEVzVTg5UVJHYW9y?=
 =?utf-8?B?d2d6UVdLZjQ1dEZpR25Rcm9KRFVETEVLaXhMb3VyS2JpOFF0a0RmVG1zQ0Nu?=
 =?utf-8?B?eExvdjQySGEzVkVVQmV6TnM5Zk1CckJPcDRnMjdyS1B0d1Q1ZkdOUU5RTDda?=
 =?utf-8?B?a1A5MjZpWkpQSVVOMmlHWU80OGZ4dFpOcU43VWcwTlZXRmFTeE1rVXdzR25E?=
 =?utf-8?B?dzd2RzhnVTFmbTZRaFJYL2lWWUVnYStiL2llV0tlbkRNaHVNbVJLTEM3b3I1?=
 =?utf-8?B?aXlydkp4MXpLeWFldVFzWGc5TElESVRtLy9PUEZvU0h5RlNpdlhnb0E5NlZT?=
 =?utf-8?B?NUJjWFRzcDRqTm0xR1lCRkZYMU53Und0TndQZTBwd294bnZTVzlzQ3ZhNktp?=
 =?utf-8?B?U1N0aXpvVmRONWhpT01qQ1JoSHRjM0NUczlVd2JsS2hWVzdISlNXMEVaeGk0?=
 =?utf-8?Q?YKp4FwnS9w3rZ5NYFGFkpKY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6CF9DB33382284293B477FEEF7B683F@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123c417a-4e6a-48a1-e56b-08dc79979491
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 13:11:51.9146 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IWoqWKhHDysmLTuizscQic5ySeyh82m5AzW6LBZl9bfGPcTsNGbEvDV8sR9kCL9fFts91szZzUex0abkVrxcOY8rp9Lvm4pJRgLBBaTQ28CDOgetutiAdY93lvot/0dn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6249
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

SU9NTVUgaGF2ZSB0byBpbXBsZW1lbnQgaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb24gdG8g
c3VwcG9ydCBBVFMuDQoNCkRldmljZXMgY2FuIHVzZSBJT01NVV9UTEJfRU5UUllfVFJBTlNMQVRJ
T05fRVJST1IgdG8gY2hlY2sgdGhlIHRsYg0KZW50cmllcyByZXR1cm5lZCBieSBhIHRyYW5zbGF0
aW9uIHJlcXVlc3QuDQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNs
ZW1lbnQubWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaW5jbHVkZS9leGVjL21lbW9y
eS5oIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBzeXN0ZW0vbWVtb3J5LmMgICAg
ICAgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgNDYgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9l
eGVjL21lbW9yeS5oDQppbmRleCA1NmVmNDg3ODBmLi4wY2VkN2MzM2IxIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9leGVjL21lbW9yeS5oDQorKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0x
NDgsNiArMTQ4LDEwIEBAIHN0cnVjdCBJT01NVVRMQkVudHJ5IHsNCiAgICAgdWludDMyX3QgICAg
ICAgICBwYXNpZDsNCiB9Ow0KIA0KKy8qIENoZWNrIGlmIGFuIElPTU1VIFRMQiBlbnRyeSBpbmRp
Y2F0ZXMgYSB0cmFuc2xhdGlvbiBlcnJvciAqLw0KKyNkZWZpbmUgSU9NTVVfVExCX0VOVFJZX1RS
QU5TTEFUSU9OX0VSUk9SKGVudHJ5KSAoKCgoZW50cnkpLT5wZXJtKSAmIElPTU1VX1JXKSBcDQor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgID09IElP
TU1VX05PTkUpDQorDQogLyoNCiAgKiBCaXRtYXAgZm9yIGRpZmZlcmVudCBJT01NVU5vdGlmaWVy
IGNhcGFiaWxpdGllcy4gRWFjaCBub3RpZmllciBjYW4NCiAgKiByZWdpc3RlciB3aXRoIG9uZSBv
ciBtdWx0aXBsZSBJT01NVSBOb3RpZmllciBjYXBhYmlsaXR5IGJpdChzKS4NCkBAIC01NzEsNiAr
NTc1LDIwIEBAIHN0cnVjdCBJT01NVU1lbW9yeVJlZ2lvbkNsYXNzIHsNCiAgICAgIGludCAoKmlv
bW11X3NldF9pb3ZhX3JhbmdlcykoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11LA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBHTGlzdCAqaW92YV9yYW5nZXMsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCk7DQorDQorICAgIC8qKg0KKyAg
ICAgKiBAaW9tbXVfYXRzX3JlcXVlc3RfdHJhbnNsYXRpb246DQorICAgICAqIFRoaXMgbWV0aG9k
IG11c3QgYmUgaW1wbGVtZW50ZWQgaWYgdGhlIElPTU1VIGhhcyBBVFMgZW5hYmxlZA0KKyAgICAg
Kg0KKyAgICAgKiBAc2VlIHBjaV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbl9wYXNpZA0KKyAgICAg
Ki8NCisgICAgc3NpemVfdCAoKmlvbW11X2F0c19yZXF1ZXN0X3RyYW5zbGF0aW9uKShJT01NVU1l
bW9yeVJlZ2lvbiAqaW9tbXUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwgc2l6ZV90IGxlbmd0aCwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIG5vX3dy
aXRlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1V
VExCRW50cnkgKnJlc3VsdCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzaXplX3QgcmVzdWx0X2xlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAqZXJyX2NvdW50KTsNCiB9Ow0KIA0KIHR5cGVk
ZWYgc3RydWN0IFJhbURpc2NhcmRMaXN0ZW5lciBSYW1EaXNjYXJkTGlzdGVuZXI7DQpAQCAtMTg4
OCw2ICsxOTA2LDE0IEBAIHZvaWQgbWVtb3J5X3JlZ2lvbl9pb21tdV9yZXBsYXkoSU9NTVVNZW1v
cnlSZWdpb24gKmlvbW11X21yLCBJT01NVU5vdGlmaWVyICpuKTsNCiB2b2lkIG1lbW9yeV9yZWdp
b25fdW5yZWdpc3Rlcl9pb21tdV9ub3RpZmllcihNZW1vcnlSZWdpb24gKm1yLA0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VTm90aWZpZXIgKm4pOw0K
IA0KK3NzaXplX3QgbWVtb3J5X3JlZ2lvbl9pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihJ
T01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwgYm9vbCBleGVjX3JlcSwNCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgYWRkciwg
c2l6ZV90IGxlbmd0aCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBib29sIG5vX3dyaXRlLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIElPTU1VVExCRW50cnkgKnJlc3VsdCwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3QgcmVzdWx0X2xlbmd0aCwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCAq
ZXJyX2NvdW50KTsNCisNCiAvKioNCiAgKiBtZW1vcnlfcmVnaW9uX2lvbW11X2dldF9hdHRyOiBy
ZXR1cm4gYW4gSU9NTVUgYXR0ciBpZiBnZXRfYXR0cigpIGlzDQogICogZGVmaW5lZCBvbiB0aGUg
SU9NTVUuDQpkaWZmIC0tZ2l0IGEvc3lzdGVtL21lbW9yeS5jIGIvc3lzdGVtL21lbW9yeS5jDQpp
bmRleCA0OWYxY2IyYzM4Li5kOWQ2NmFlMmUxIDEwMDY0NA0KLS0tIGEvc3lzdGVtL21lbW9yeS5j
DQorKysgYi9zeXN0ZW0vbWVtb3J5LmMNCkBAIC0yMDA1LDYgKzIwMDUsMjYgQEAgdm9pZCBtZW1v
cnlfcmVnaW9uX3VucmVnaXN0ZXJfaW9tbXVfbm90aWZpZXIoTWVtb3J5UmVnaW9uICptciwNCiAg
ICAgbWVtb3J5X3JlZ2lvbl91cGRhdGVfaW9tbXVfbm90aWZ5X2ZsYWdzKGlvbW11X21yLCBOVUxM
KTsNCiB9DQogDQorc3NpemVfdCBtZW1vcnlfcmVnaW9uX2lvbW11X2F0c19yZXF1ZXN0X3RyYW5z
bGF0aW9uKElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBwcml2X3JlcSwNCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBleGVjX3Jl
cSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aHdhZGRyIGFkZHIsIHNpemVfdCBsZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgbm9fd3JpdGUsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VVExCRW50cnkgKnJlc3Vs
dCwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
c2l6ZV90IHJlc3VsdF9sZW5ndGgsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHVpbnQzMl90ICplcnJfY291bnQpDQorew0KKyAgICBJT01NVU1l
bW9yeVJlZ2lvbkNsYXNzICppbXJjID0gbWVtb3J5X3JlZ2lvbl9nZXRfaW9tbXVfY2xhc3Nfbm9j
aGVjayhpb21tdV9tcik7DQorDQorICAgIGlmICghaW1yYy0+aW9tbXVfYXRzX3JlcXVlc3RfdHJh
bnNsYXRpb24pIHsNCisgICAgICAgIHJldHVybiAtRU5PREVWOw0KKyAgICB9DQorDQorICAgIHJl
dHVybiBpbXJjLT5pb21tdV9hdHNfcmVxdWVzdF90cmFuc2xhdGlvbihpb21tdV9tciwgcHJpdl9y
ZXEsIGV4ZWNfcmVxLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYWRkciwgbGVuZ3RoLCBub193cml0ZSwgcmVzdWx0LA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVzdWx0X2xlbmd0aCwgZXJyX2NvdW50KTsN
Cit9DQorDQogdm9pZCBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdV9vbmUoSU9NTVVOb3RpZmll
ciAqbm90aWZpZXIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVU
TEJFdmVudCAqZXZlbnQpDQogew0KLS0gDQoyLjQ0LjANCg==

