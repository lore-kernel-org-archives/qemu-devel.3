Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DA606A332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=lLsRWUGf;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=KEy9TAa0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOpb7-0004an-70; Thu, 05 Nov 2026 00:01:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpaq-0004YV-DP; Thu, 05 Nov 2026 00:01:02 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpao-0004zd-9u; Thu, 05 Nov 2026 00:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793854854; x=1825390854;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=KGIfMLS+annOzzxRMbKh1kyi+Oy7MwPj3Hksu5+SrKI=;
 b=lLsRWUGfSUUJLhu0AYVX5hAer7hXS8ucKlIIMm+CGuKZi7Q817x0PClp
 mutCoa+SrtN7p6A/sW9EffJkpu3vj5WpCxVHc2YYoZkLRPZ2T2tHAI2Xa
 IUuvgIclyZuuhwyXLTmbTvI8CdeXTrdI0ZfjUWKNFfW+wFulnrojNAHCO
 JQnA5C2BRuIZ5mg8WGUCWFfeh+ZAUtMiLwkutT9N+ypRGplCPS24tkRLZ
 ukzkhtFvFwgn5TsCeuL3/53qosu6oTrwCzBT/P00akHTM7n0GVEH5ggqY
 DJjn4NDSB8bKeOzxQ8OBFV2jWPH9257RKX/J9sLTi/ehHQb9CutINYXhX w==;
X-CSE-ConnectionGUID: h8pT+tIeQLuFsrNBQ+u3Fg==
X-CSE-MsgGUID: Rz5NncJoTTi8YMOFTZvDRw==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; d="scan'208";a="155631452"
Received: from mail-southcentralusazon11013044.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.44])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Nov 2026 13:00:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jP4PpdS/sGLr0JpOs76cvmzOWRrvw85j3wwmwf2jEZrzIRh7tHWYgPToL9jjPfbs9wegsfeUcIXQpP1xhcB5d225MViYroiL5KHbArs+Xhy/MIjnBpdSficBy5nbiwGwNhB9ACorB0RARHxIvIVUFq5jxg5yy80T4B2kZzcImNjPdNSfZ33h8EvmdcNIc90Rlwt40z9iXIP+lCznxcLQTWVjVB9ceWmCQP+5mJwfpRFRXzQkxkCKsRhTXFy7DCMoOf1tB0J2hlf0UnM8Fo38JurcuEdAOJdIjKC1fY9GDPYEpc/iEnmV5ojJKcu3YZB4CHmA6vgm8MUZl+KkgmKOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGIfMLS+annOzzxRMbKh1kyi+Oy7MwPj3Hksu5+SrKI=;
 b=WmKCxbnPANmVlltKzNVnRMyL6QNzUdRM30IGdbytOVIEzJ53i0ITvdwhF9k5nCXJco7VWnNiUJcdlZWc1RKCOz2kpiemRlnA394d1O1CwS7iQtHnZEIFUxYwd9h7jv+k8eBB+PDPlvann2xhfN1fH/IvDc1WCVStfUvvxAYJylazpN3bGw1ZLbpa+EWNGcNwNsKJIAcZlhY5U+hPwFX8JyRaU+IUWLO1STODdrPgHfIJNpSyL1unf9wdM+oB8cUQC/rQC9AGnrQKBtLDfc89Gp1T3SZ3ONH04ihXHDfdwWP7cz0YX9bwx/PI0FnlgJG3UBMvIh83raRzOYG3hQIoFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGIfMLS+annOzzxRMbKh1kyi+Oy7MwPj3Hksu5+SrKI=;
 b=KEy9TAa0eyM8em3z51MyjRvIy4eyccibX9JYuV9RuP+cUWJzpM554mLFr1IC+y9eswH1oBWdMbf2ZgBsaamhha4GEGwFoKJD1tuYwy7gaM3Z6P5/rjI7XYIz/AmnK6QxZ8tVSNlp4KXBFGQ8UXlXcD8naXk3QGHv4RVPRbgW6sA=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH8PR04MB993683.namprd04.prod.outlook.com (2603:10b6:510:40f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:00:50 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 05:00:50 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 4/6] hw/riscv/server_platform_ref: fix UART baud rate
Thread-Topic: [PATCH 4/6] hw/riscv/server_platform_ref: fix UART baud rate
Thread-Index: AQHdYwjmKRN/k0OO8k6mJNS+Y0NE5Lce/y2A
Date: Thu, 5 Nov 2026 05:00:50 +0000
Message-ID: <6c0f1c2078a5b5db45a110fda4b73fd07eb8bbbc.camel@wdc.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
 <20261023160913.24992-5-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261023160913.24992-5-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH8PR04MB993683:EE_
x-ms-office365-filtering-correlation-id: 0e94bd63-d79f-4a93-ce63-08df3af9c302
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|19092799006|38070700021|261021123027099003|261022105027099003|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: w7WxgrcBBGXdIWZg+a/hePcE294d5zFIpajypafxeYhn8E9DIY0zllMdkLkG1VgGkQjv9MyazF0bGHCUSlc2VVvW6xLIW6dxH+W9enauJ3bwBqFP4meATlNgB+Lni+o6hhxwuOX5dlnfcz3uEKReqVgUAqmKBR5EznHM9DhYm0o0vrJI60JgPrcEJjbUV8gailhEOLI6h1OBL9QrrWJRNpL9lNg7UhDdlUPtOIsHIhmhiacpx8q//U5YsIQiC9VqTsweyYPRXabOlU1xnRMTECr4NK0x/2sr8+uEPtN8Xe5eAlneFNNvouccDnsC4bSQAPjq0s60gzTtsiLrsYKTxw9vXUTQCVVCtTDCludjN06b7wW9dbXIZf6Np/QtJQbeloeC0dLnFVMTW2mlVcmL5ZkyXDvRJe7WkGNSY/yAVuOCSwcg+EcP8V0Q9EHpX+taZaS9no1iKaH92L0israb+K0xL6f4rph1cAgq31Vdf4pjDQfYPCXLJuHake6YfKi9pa2wLnLeDlBUObfK3ZVF+p7tRKTQvbyCWwidD6OFY0gQJ8pjiJMF6UDehw9HMkRoBNcHnz1jS7vzhhrxEvx7tgQvKqcO9tkIwQJBPy8LMPJ7TojPiBq0ORqHsK6hxAXKft3Tym2DxjLioWnYCmoJZrQO8efB6Daw7ajBiA7E98g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(38070700021)(261021123027099003)(261022105027099003)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2NhNktTYno5SWdhYkVtUmNRdmw1S2lKY2tpT1hPTjFvUHg0SVhCWGtkV0Nk?=
 =?utf-8?B?ZytyY3YwYzJiNEs4bitqNDhnc2I2UkJkWU9HcUtXcW9iZmRFWllLQW1aUUs5?=
 =?utf-8?B?UmxVWGp5YkplcHNLWFNqQlBjZUN4TC9iczRWL2FZZFd4SHhFc1VZenEzTzFt?=
 =?utf-8?B?UmJSK216QWg5SjRRZUFMMytBSWRPSHpTSXFDNEl2U2VBcVVMUjBvMDIxbi9z?=
 =?utf-8?B?ZFU3T0NXQmtrU08ySDl4Sm5iQ0t1WjMyeHJQaThyQ2xLUmc3dVFCME1vc2JT?=
 =?utf-8?B?c0drcDlHeDJPRktiVVJxbkJkaDZ4b0VzMzBPWjE3b290TXlDQVFlNnh6RUxn?=
 =?utf-8?B?aXNEQWc1Q1FWRzNnWjhYYzEvYlNCV0cwdG1zWmoxMHM1RTNDTHVhNlRjOW5k?=
 =?utf-8?B?UWYwVURKVSswOXU2SlBLdktBSTNENlNzb25aQ1FGS0ZHZG9ka0xtVGN0TzYx?=
 =?utf-8?B?U05MVTZlTUkzdm5nVUpWT1IvcHdNWjYzNm94clNCQVFwRmhKRkV2c0htYjli?=
 =?utf-8?B?OE8zTloyVXhkdUJWUjE1UVJqZ1JXbHg0bFRhaTE0aGdNMG8yd1hON3BNZEVr?=
 =?utf-8?B?NTNCeURkRWZ6WGFGRmxLalF3Wkk1Y3lJTDF0WVNET1ozV1hqbnVlYTE4WDFv?=
 =?utf-8?B?SEZBZGtxS0RQak15SXh1M1RUalRaOW82Q3VUQ0FFamJGdDROS1ZpWm5jQ0hm?=
 =?utf-8?B?clZhSVdOTDZTTENWOUpreVZqcS95TExmSUsvZGNMS2VxSWYxMXVCcE1leUcy?=
 =?utf-8?B?aEtwZ2lHQnkrN0EvWmhlTkRtSUE0R2V6eU9tbGdUNDI0RjlDNm5GUHVYY0g5?=
 =?utf-8?B?YkdIZFdKNGlaRXNEa2FMdFlRNy9SL1ZvUlpsbWE1RkxnNWRkOFJxVEJmTnpY?=
 =?utf-8?B?NlY5aXdTckNaeXV4azcwRHZxM1BkNGh3aHFoRTU0alltUHZ2eGNBYWJqbTVM?=
 =?utf-8?B?a0dKaENDcllsV2hLb0w0NjBDTFZwY3lQaVpWeFBlU0p4WWk5TkIvZ0ltbHhs?=
 =?utf-8?B?eHJ5Wnc3ZE1jamprcEZHT3BtVTJRZFJ5SzNnOEhXZm13WXZ5SzBJNFBWbXND?=
 =?utf-8?B?WUtBaThuR2FDK09ZcmFZL3E2dnovUkVOd1ZoOHA0STNHY3ZKY3ZxVy9yK1lZ?=
 =?utf-8?B?RlJOVC9QOGMwZjQ1S1gwUnlMSmwyMVY3YUpOY05ybFJCS1lRR1hMMFhWcU83?=
 =?utf-8?B?OWZ5RjQ1cGxFK1hNM2FoRGdTSENXWmRyajdmdWlMcjJiNCt0NzRTd0N6WHlh?=
 =?utf-8?B?elF5dDEzaEUyc0JkVHY1ZnJVT3kyVndTdU9hdUJ3cUIyNUFsZFkyRmlvMXlK?=
 =?utf-8?B?STliSzZOR1NTODVoUWdSakVONXJjenRGQktkQkNZM0ZsWVc5S0oyZGxTeVRh?=
 =?utf-8?B?alNmbnVWYWxHNVEzR2JJbVFRdE9YUy9Ba1JlOWt6cmR6UWp4bE9hdFpPYmU2?=
 =?utf-8?B?TTBoRVFka2JOQUlLdzhZeEVJYlJMZmJINnR6T216L2RpZ2hQZXhKVXRyTGE5?=
 =?utf-8?B?UlluSDZZY1d0ZnYvREN4MUVNR2wyUVgxTDkxamhIakEwZnJIVHBXUEg2dU9p?=
 =?utf-8?B?QTl5VnNoRm0yb3g3STVZTTljcDJOMkZKUWlFT3FaRFhIUFFVOUo5OFY1UnlE?=
 =?utf-8?B?RzBvWWV2WU9UM2plYUlFL3FKUmdwRHN4WEtSL3BCYmpUOFdlc2F3Vlp3VkNn?=
 =?utf-8?B?bHlIRSs2eXYvN3U1OExLd1RpeVpSblhVSmI3Z3JFMXBFaGFGM1BVNlZONW1W?=
 =?utf-8?B?eXdsT3ZxYlN3NWJ1ZVdBcEYyUzBaRlFCc2NlWHJNeWxETVI0dUNBdzNleU1a?=
 =?utf-8?B?R2RXbWRlM1ZxVWJ4c3hWQm52dll4Y25yYjFWcjFuNDdFb0JpYkltcHNvZHRW?=
 =?utf-8?B?RllELzdoZXhneVdBdEF1R0E2TkFWK21ZWlB0NkdnQ05YSFVLNm9ydGQ5eDJo?=
 =?utf-8?B?aGlFREdjenF6VGxTSjRRT0NFQVJIbEhYWk8yWnZRVGxXUWFJcUJpNDlLYldn?=
 =?utf-8?B?ZUVRQ1J0M0ZOM0poK3RINVBPZTZ6dmxLOXYyZmFtUEFCSFB3YVZaSWJjUTA2?=
 =?utf-8?B?dUJYZTRCaTJBc0pYVUwyMFhaeWJGekFwMXAxb0htUUVIZmhRNFVIeDBkMUFH?=
 =?utf-8?B?NHRPb0x2NUZBWHhZSkxsSzAzNmhmMlpoZi9OaUcySXMvRGNhVlNpMFBaMVlI?=
 =?utf-8?B?RHFMaGc2eUlIWGJWVEh2bm5aVzgwd0t0SUhjdEpoMXREZUtTUmhSMDRYa1lw?=
 =?utf-8?B?NHJRZ1NFMzRRSThtVTlJV2x3T0VDUHFRYVc3Z3pyRDM0WXQxY2s3TFNJYW1z?=
 =?utf-8?B?QWN6eVJ3bkphdTFLVUYrdUorRDkzbnl4L1B2dWlHM1FvWm5IZFV2VWx5L1Q2?=
 =?utf-8?Q?KldbmZKuqOZmZJv/4EvI/+szjMfVU4g+PBMcaCz2O2dSR?=
x-ms-exchange-antispam-messagedata-1: 8BCUoX+9N/SVk5MWFRltEZ+Eez5xWg/YOrk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <419E978E35EC6745BFE46484B58CACDE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DmgBUOE2S2WSj8NNTmIcD0BzWxYJIWGdsotoNs8VVPy0ZJBOH+ISOfm7dPTzu4KkZ1TFI9pCHy9JGxEWDHy86DA7SjYBa9R1MD527I7sU8/tseOxe+gwrv+4eQ9UvMbHh4QLaQG1wGTi2d/sSG9e2eHmi/Vuu/UFxqW5AaNmbOf6iw34aX6tN03C2mQJV3yhIQFqvDSYdCgg/TAjcOmtGKshV0lTKe+4m/JlfGOjc4xctOyRmHx1ztgWrcs45FodVNyPaCFbe0q+6xsp6e5eLYJXzU8L/tu1gZ+eMHb9oovOyFDU9k/0PuQH4NvgwzwnX+ZXR9WQCazrsZxW29ha3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jWM+XvfTE/cySaSijdcstZzs1q/BixHljYoPBfTgSRo1f87jASQzxOdBlYN74kt1VqA7HqxX7D3pDgDUcvqDVHA2fz8NicoIzD7N/I/SZlwFFwCN2aB/ljSV7Ny8oekw3VWTTimkPM39ri3gXZyngcVOqx8c/f+qfN51gzfoqDdvpLFYYcccN+N2uohLrXi20Vi9TYj5OXsGYZEefbUCUw3iU4rZeJH5nO+NoHZfaEB3P5IP3JIXj4jwttf6jM7yEeRrSuiCB55Yu++D5QzQVDP9prLTZ7yw0wYOpdd8hnpH3rLIWn7lgn0aviisrwFB4tkn+SE4qlielwWfuQzPGHMV/uXsEBBGjlbeWYgPJ1IukL3eECxQTYhYHkG2tJP3JBLFMMF+h55FzwRMK8mtll/fpIKr4KmFLYuIGI2DEOY5/E088UbHHXPzaS3zQ/pbitwAm7kAQBATK57YSZxfeqwaD/Ea4g+9UJIOvmnJ+qiJi/9b78lyMUx14D7j+QWwGbvqh1SaLrXDnEg3hHPrgNHMstk1HNXPl2CUgtNmQC08pMv9SEM5pb8ZKNUB4uHyIU/o7Olj7RrpcWrE5gBvrWWSsarjtyc4lPCjkg1WVSf+a9vKbVdRKttf4eS5uO9C
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e94bd63-d79f-4a93-ce63-08df3af9c302
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 05:00:50.2566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1q8daHQlLkzy1GsVTr0+nvczSPj4ZXU65VA44slqs1YAYxImTAI+SXMEs0nVQVTU7AH/wkx59Zde71O1bvKTj7d+iyes3+IRjJjNVUkZLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB993683
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDEzOjA5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBUaGUgcmlzY3Ytc2VydmVyIDEuMCBzcGVjIHJlcXVpcmVzIGFuIFVBUlQgd2l0
aCAxMTUyMDAgYmF1ZCwgcGVyIHJ1bGUKPiAiSFBFUl8wMjAiIGRlc2NyaWJlZCBpbiBbMV0uCj4g
Cj4gQXQgdGhpcyBtb21lbnQgd2UncmUgZG9pbmcgdHdvIHRoaW5nczogdGhlIEZEVCBpcyBiZWlu
ZyBjcmVhdGVkIHVzaW5nCj4gdGhlIGRlZmF1bHQgVUFSVCBiYXNlIGJhdWQgb2YgMjMwNDAwLCBh
bmQgdGhlIGRldmljZSBpdHNlbGYgaXMgYmVpbmcKPiBjcmVhdGVkIHVzaW5nIGEgYmF1ZCBvZiAz
OTkxOTMuwqAgVGhpcyBvZGQgdmFsdWUgd2FzIGluaGVyaXRlZCBmcm9tCj4gdGhlCj4gUklTQy1W
ICd2aXJ0JyBtYWNoaW5lIHdoZW4gaW1wbGVtZW50aW5nIHRoZSBmaXJzdCBpbnRlcmFjdGlvbiBv
ZiB0aGUKPiByaXNjdi1zZXJ2ZXItcmVmIGJvYXJkLsKgIExpbnV4IGRvZXNuJ3Qgc2VlbSB0byBj
YXJlOiBkbWVzZyByZXBvcnRzIGEKPiBiYXNlIGJhdWQgb2YgMjMwNDAwLCBhIHZhbHVlIGRlcml2
ZWQgZnJvbSB3aGF0IHdlJ3JlIHdyaXRpbmcgaW4gdGhlCj4gRFQsCj4gYW5kIHRoZSBzZXJpYWwg
c2VlbXMgdG8gd29yayBmaW5lLgo+IAo+IFN0cmFpZ2h0IGV2ZXJ5dGhpbmcgdXAgYnkgc2V0dGlu
ZyB0aGUgcmVxdWlyZWQgYmFzZSBiYXVkIG9mIDExNTIwMAo+IGV2ZXJ5d2hlcmUgYXBwbGljYWJs
ZS7CoCBBbmQgZm9yIGdvb2QgbWVhc3VyZSBsZXQncyBhbHNvIGNoYW5nZSB0aGUKPiBib290Cj4g
dGVzdCB0byBiZSBzdXJlIHRoYXQgdXNlcnBhY2UgaXMgcmVhZGluZyB0aGUgaW50ZW5kZWQgc2Vy
aWFsIGJhc2UKPiBiYXVkLgo+IAo+IFsxXQo+IGh0dHBzOi8vZG9jcy5yaXNjdi5vcmcvcmVmZXJl
bmNlL3NlcnZlci1zb2MvdjEuMC9zZXJ2ZXJfc29jX3JlcXVpcmVtZW50cy5odG1sCj4gCj4gRml4
ZXM6IGMyZmE0MzIwODAzYiAoImh3L3Jpc2N2OiBzZXJ2ZXIgcGxhdGZvcm0gcmVmZXJlbmNlIG1h
Y2hpbmUiKQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phCj4gPGRhbmll
bC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNp
cyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBody9yaXNj
di9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDggKysr
KystLS0KPiDCoHRlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3NlcnZlcl9yZWYucHkgfCAz
ICsrKwo+IMKgMiBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
Cj4gCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYwo+IGIvaHcv
cmlzY3Yvc2VydmVyX3BsYXRmb3JtX3JlZi5jCj4gaW5kZXggMzE5MTYxNWMwMi4uZTg2YzM3NDAw
ZCAxMDA2NDQKPiAtLS0gYS9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMKPiArKysgYi9o
dy9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMKPiBAQCAtNjgsNiArNjgsNyBAQAo+IMKgCj4g
wqAjZGVmaW5lIFJWU0VSVkVSX1BMQVRGT1JNX0JVU19OVU1fSVJRU8KgwqDCoMKgwqDCoMKgwqAg
OAo+IMKgI2RlZmluZSBSVlNFUlZFUl9JT01NVV9IUE1fQ09VTlRFUlPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDQKPiArI2RlZmluZSBSVlNFUlZFUl9VQVJUX0JBU0VfQkFVRMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAxMTUyMDAKPiDCoAo+IMKgI2RlZmluZSBUWVBFX1JJU0NWX1NFUlZF
Ul9SRUZfTUFDSElORSBNQUNISU5FX1RZUEVfTkFNRSgicmlzY3YtCj4gc2VydmVyLXJlZiIpCj4g
wqBPQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShSSVNDVlNlcnZlclJlZk1hY2hpbmVTdGF0ZSwK
PiBSSVNDVl9TRVJWRVJfUkVGX01BQ0hJTkUpCj4gQEAgLTMxNSw3ICszMTYsNyBAQCBzdGF0aWMg
dm9pZAo+IGZpbmFsaXplX2ZkdChSSVNDVlNlcnZlclJlZk1hY2hpbmVTdGF0ZSAqcykKPiDCoAo+
IMKgwqDCoMKgIHJpc2N2X2NyZWF0ZV9mZHRfdWFydChtcy0+ZmR0LAo+ICZydnNlcnZlcl9yZWZf
bWVtbWFwW1JWU0VSVkVSX1VBUlQwXSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJWU0VSVkVSX1VBUlQwX0lSUSwgQUlBX1RZUEVfQVBMSUNf
SU1TSUMsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDAsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFJWU0VSVkVSX1VBUlRfQkFTRV9CQVVELAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaXJxX21taW9fcGhhbmRsZSk7Cj4gwqDCoMKgwqAg
bmFtZSA9Cj4gcmlzY3ZfZmR0X2dldF91YXJ0X25vZGVuYW1lKHJ2c2VydmVyX3JlZl9tZW1tYXBb
UlZTRVJWRVJfVUFSVDBdLmJhc2UpCj4gOwo+IMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3Bfc3Ry
aW5nKG1zLT5mZHQsICIvY2hvc2VuIiwgInN0ZG91dC1wYXRoIiwKPiBuYW1lKTsKPiBAQCAtNjE0
LDggKzYxNSw5IEBAIHN0YXRpYyB2b2lkCj4gcnZzZXJ2ZXJfcmVmX21hY2hpbmVfaW5pdChNYWNo
aW5lU3RhdGUgKm1hY2hpbmUpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAKPiBSVlNFUlZFUl9QTEFURk9STV9CVVNfTlVNX0lSUVMpOwo+IMKgCj4gwqDC
oMKgwqAgc2VyaWFsX21tX2luaXQoc3lzdGVtX21lbW9yeSwgbWVtbWFwW1JWU0VSVkVSX1VBUlQw
XS5iYXNlLAo+IC3CoMKgwqDCoMKgwqDCoCAwLCBxZGV2X2dldF9ncGlvX2luKG1taW9faXJxY2hp
cCwgUlZTRVJWRVJfVUFSVDBfSVJRKSwKPiAzOTkxOTMsCj4gLcKgwqDCoMKgwqDCoMKgIHNlcmlh
bF9oZCgwKSwgREVWSUNFX0xJVFRMRV9FTkRJQU4pOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMCwgcWRldl9nZXRfZ3Bpb19pbihtbWlvX2lycWNoaXAsCj4gUlZTRVJW
RVJfVUFSVDBfSVJRKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJW
U0VSVkVSX1VBUlRfQkFTRV9CQVVELAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc2VyaWFsX2hkKDApLCBERVZJQ0VfTElUVExFX0VORElBTik7Cj4gwqAKPiDCoMKgwqDC
oCBzeXNidXNfY3JlYXRlX3NpbXBsZSgiZ29sZGZpc2hfcnRjIiwgbWVtbWFwW1JWU0VSVkVSX1JU
Q10uYmFzZSwKPiDCoMKgwqDCoMKgwqDCoMKgIHFkZXZfZ2V0X2dwaW9faW4obW1pb19pcnFjaGlw
LCBSVlNFUlZFUl9SVENfSVJRKSk7Cj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlz
Y3Y2NC90ZXN0X3NlcnZlcl9yZWYucHkKPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0
X3NlcnZlcl9yZWYucHkKPiBpbmRleCBhZDI5MDk0ZGJlLi5mYTcyMjVjY2MxIDEwMDc1NQo+IC0t
LSBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3NlcnZlcl9yZWYucHkKPiArKysgYi90
ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9zZXJ2ZXJfcmVmLnB5Cj4gQEAgLTcxLDYgKzcx
LDkgQEAgZGVmIGRvX3Rlc3RfYm9vdF9saW51eF90ZXN0KHNlbGYsCj4gdHBtc3RhdGVfZGlyPU5v
bmUpOgo+IMKgwqDCoMKgwqDCoMKgwqAgd2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuKHNlbGYsICdM
aW51eCB2ZXJzaW9uJykKPiDCoMKgwqDCoMKgwqDCoMKgIHdhaXRfZm9yX2NvbnNvbGVfcGF0dGVy
bihzZWxmLCAnTWFjaGluZSBtb2RlbDogUklTQy1WIFNlcnZlcgo+IFBsYXRmb3JtJykKPiDCoAo+
ICvCoMKgwqDCoMKgwqDCoCAjIENoZWNrIHRoYXQgd2UgaGF2ZSB0aGUgaW50ZW5kZWQgYmFzZSBi
YXVkIGZvciB0aGUgc2VyaWFsCj4gK8KgwqDCoMKgwqDCoMKgIHdhaXRfZm9yX2NvbnNvbGVfcGF0
dGVybihzZWxmLCAnYmFzZV9iYXVkID0gMTE1MjAwJykKPiArCj4gwqDCoMKgwqDCoMKgwqDCoCAj
IFRlc3QgZTEwMDBlIG5ldHdvcmsgY2FyZCBmdW5jdGlvbmFsaXR5Cj4gwqDCoMKgwqDCoMKgwqDC
oCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ2UxMDAwZScpCj4gwqDCoMKgwqDCoMKg
wqDCoCB3YWl0X2Zvcl9jb25zb2xlX3BhdHRlcm4oc2VsZiwgJ05ldHdvcmsgQ29ubmVjdGlvbicp
Cg==

