Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF6606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=Q+3WW/DN;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=bin/aPgT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRMKf-0000PP-1M; Wed, 11 Nov 2026 23:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMKb-0000OY-7Y; Wed, 11 Nov 2026 23:22:37 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRMKZ-0001iv-48; Wed, 11 Nov 2026 23:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794457362; x=1825993362;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=l24QjPdFTYQtuEhO4FeVGHaQF404IsXNabhunzT/TNg=;
 b=Q+3WW/DNWcPmMtzLj36rzNtDlDwIfMD/Zb+nPzrafIP9bAW7k9R86E8B
 dRTBEwLKYuLDjhRTPHEjXNEJ0StfSrGGi8t71sdluygs/ajvygFs0uxP8
 k62AWtMWw8P+rxDAlo7Tc6Cre9jx7KZiXuDj1nQiWIt7JmH8xIInjQTZu
 sEOafLCLRyMiBqg4ui7/YSIVJ5TD8ZC3HAPTRgl4CVreKVmc0TJOn46oh
 S+JlJwljwaAalbaDQ0dkmnChpWq3gX67pcR+DooOIn/JLgtpzZPhaN+0L
 au5EFESSWEeE/KKFj3e/Rcl84t4AHsl0FGuHoip1GthLXz9CvABTTDzuF g==;
X-CSE-ConnectionGUID: bTPdWDePRviZXL3Qe/FfSg==
X-CSE-MsgGUID: uLm6WdrTRrm90QUnmUv55g==
X-IronPort-AV: E=Sophos;i="6.27,209,1786982400"; d="scan'208";a="160698873"
Received: from mail-centralusazon11010031.outbound.protection.outlook.com
 (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.31])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 12:22:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CV/l0hxTcSpXwMRx2I+007C/s7HbMGt1Q3Cex9PWoBIbm6pQbOyD6myIDMdLetZ9EXFK4RojYQRNeCzNEE8vzIXqLJJSV5kELzyE9m3BYF4mE5p+3jxirowRRHVIEfLEyVZLKpkXBDjAkgaRIEzxt4moXKIdQM+JpFb2In5+FUdZKpQATsTiZOGkUQwyhFWOmHb6Zw/wgm8vYliG1cSl6eY+omzjOa+83g9jDVZqgJnOIm/1pR4LOXSRIFeyGiZtnhFYRdxzyU3spAvJrFZd2EGy2UFHJtOghAYwlq+dFGc8w4GF7baL0woec0w0sTJyDuWQlMPIF3FpbMK2C4BC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l24QjPdFTYQtuEhO4FeVGHaQF404IsXNabhunzT/TNg=;
 b=YxD6tFoKPBLTBufw54PwCmvUN0thTI0X7LGE8jKaU0vQ1cmqo4nCiS2v8uAZi5QMa64EK0N6T0DgRfThbebXQS9uzEF8kwfQCYa0QFh9TU9tcbpu+QfwNBhBuGCA+HPGbJP+tq8d9kyOT9mrUKIUWxeg5hZ3mUP785pKp/Q0eQRpp3NA/EK38hkWlIp8gB3YVAzl+55SODnOFnii05LOJj2ubZgpruP+7zhj0zBKUZ/46i43GxhK7nbihqrC231Vc5TKw/12yhUKZffGRKoz8vcyiYRsIIY9U8PP/+n1EObREBMijxd/WfAqJtf0o3c9XHNntCJgEEuNcIYFGHS6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l24QjPdFTYQtuEhO4FeVGHaQF404IsXNabhunzT/TNg=;
 b=bin/aPgTfQZ4rZ/2GzmYKnq3sRfccsKJlexFqnBKt/Swpzm58lvUKR1nf1tHqOoOgSFy/kr8bDpm5ZyN2dZeSA3GKs9/No3qt9vfOy1D6Zbv6NxuGHlGgKaHMELYKuwaKPtDdvt9yZ6NZ/+o9CHVpyNo8SbDf6sfctDZc+rdnHU=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by MW4PR04MB7443.namprd04.prod.outlook.com (2603:10b6:303:7f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 04:22:25 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 04:22:25 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "nutty.liu@hotmail.com" <nutty.liu@hotmail.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v3] target/riscv/kvm: Translate MSI addresses through the
 IOMMU
Thread-Topic: [PATCH v3] target/riscv/kvm: Translate MSI addresses through the
 IOMMU
Thread-Index: AQHdZuTuoj0qvF/4f0G5cPZgKD9cxLcp7QqA
Date: Thu, 12 Nov 2026 04:22:25 +0000
Message-ID: <097325543176f4a50aeb485f2027824a376d867a.camel@wdc.com>
References: <20261028140122.1560-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261028140122.1560-1-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|MW4PR04MB7443:EE_
x-ms-office365-filtering-correlation-id: 5831cfac-264a-43e7-400e-08df40748df7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|10070799003|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261021121427099003|261021123027099003|261028144727099003|261026140227099003|261102123227099003|56012099006|10067099003|11063799006|38070700021;
x-microsoft-antispam-message-info: XKEOP6F+Q9ioQWEpR7lQMlvl4btAvNKwBaEtsOZmf/iuahGJNK85jQ9oeyQGMYkMnJs+8pHnb6PCJl4rCBmH9l/oazQnX7ZhFGhxiy9R/iP3mJNMIj1b3Ej+WrV3T4li5jBGLb/urNnw9U6qGgbJMfc13+15qklGmI6PreG7XIVpj9soYstUL2yTJHeL6t4EmlMff41u4yxa3u9J74GbC8LVsnSpdm4m13+rLlOcDA0Sw17W7UAG/1GGaZA85ehOOsMYeYWgLk+47HcF79Q0nykfEEkiRev2O2RxdK2y9gsn5VKFdBqoA50qTCuP+Vw1YsfgQz90q8Pz7e9Z2FQ8rF1nK6Z9ydYp/7J0GMQ/e5RDEXFq2hqufZRFF4T/ZHI+jqCVkZjvp2mofeiGWsZAFjvu2ycTqpJ8c89WVLP1HVoQgC8W1Jkj+535fq2MmYychlHC2V/QVSQ44LyI7zO2zPYDwaWH+X91DZ++Z/edpgyjrWyzKdM2YmXtHBIQR04lIjzJPrcU2EBaVDwje921Zy0LmajLKAXNGZdZCwKfa1sGe8OpXEFEikdapX0pKzABlZXLIvMj8oT3qeCaSAYK9pVzVMXbA1yADHJYhgGUBZjOwbCihCySkjjfi3xFtqxM8BbOfguUSj694wYIjKSyEaLUAj8cfX1+/7aMwZqPt31As6EnS+1LFcXq3/FUjYNk67C5c854wQJkXB7PxEcQL1KIC4sNOax0IBm1NAESbZ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(10070799003)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026140227099003)(261102123227099003)(56012099006)(10067099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZWNUdpZHZMdFIrWXFTVXYvWFZiK1ZYSmVHTG9Wbld4eDRGQ0FkWlRnd1Fa?=
 =?utf-8?B?cW9QQ2E3c21rS2tlWEdTMG5VTVdicHZXSnFRSVhRSTRuSkF0aG9KLzBZcHRD?=
 =?utf-8?B?VGRMeDJ3dGRya0lObGFDcVkyZXFudFRSaEtuaUV1NUNBcmVYUXZQbnR1aEVh?=
 =?utf-8?B?bHdaVVNYVzNIQzN0anRhVHBEczVzbXArb3ZZaHpyeWZtSGtVNTYyUElwbk1n?=
 =?utf-8?B?STAzamNmNVJBeUZmQ09lYllhYklySGhSWkU4TzBPOUxmdHJWZjE3YTRlN2lJ?=
 =?utf-8?B?TGpzY1ozdFN6OHRKdTJzc0ZIMCthbG1IWDdCY2pWVU9CSEdjaWJFbDY1VHlT?=
 =?utf-8?B?ZGJxUHdPa0VCOXhGLzFuTzZoTkN6WU04b1Z5ZWIwOVhINVh3dnlzc3ZtNnVO?=
 =?utf-8?B?MTZ1bVFKOUlaQ1BhdmYxSHJUTTh2RjRrZXVvSjY1TldIRGhZTE1wT00wV3NX?=
 =?utf-8?B?eUlKeXlTcm5VQVY0K1dSWVFrbnl0VmVZRW4rUGJWOHFYZUhnQlIwY1FKbjk3?=
 =?utf-8?B?dythMExySkM2dHdLekJOSlQ4QWt6SUhyRDhUQldiVkRobEk4aTRwdHdIRXRR?=
 =?utf-8?B?U0FVWWVCVkc4QVRIY2tkUVhlUjFJQU9Xb0pnRFdyMU9CRlRmMUdxNzIreDNO?=
 =?utf-8?B?UCs5K3RzOXNsUUFiQWlBcTdDT3NNYXYreGlpdFBCR2Q0bklGTjltVVVYZUVB?=
 =?utf-8?B?Z3lXWkkwaDJpZ09acFN3NlY4cENDWncrWm9OMVJMeDE5Wno5b1ZhbUkyVXla?=
 =?utf-8?B?WVpSQnZ3c2JUZVBQeXpCUWlpemsrK01vOFYvbExwd3BGY1dzdjIrTmRUWlUz?=
 =?utf-8?B?ejJ2dFRGdDMyRisveFpaSE5iZDJJUXhDSXJQYWRrSlJyNmYxYks1ZXVhc0xR?=
 =?utf-8?B?SEp0RFFWUm9aWkI4QURtQnMyYVk0UGx0T3N1OUJLREJsc1FuQzhlWS9kOTh4?=
 =?utf-8?B?V0IyR3JqdlFUdWN1SlNSd0FwWVc2akpuN2ZEcVVuV2psczRoZytydHZYRGFJ?=
 =?utf-8?B?dEZ0SGJseHVVQksvSnpWeVdveUluRk1KVGU3WjNidXlMWitob0ZEeVd5YVpt?=
 =?utf-8?B?SjdHYWtaSDY2QWc4Ui95bW9pclRoSmplT3JPVGp3eVd2cjFGbk10Wk96SURS?=
 =?utf-8?B?Z0J1ZC93K0JlamlEY1ZwR2JPOG96MmpnKzcwb1dyek5uekNjMVR2WGhabEdv?=
 =?utf-8?B?Vk9tdUZVZE1ya1lxeC9MZXpFN0JybXhVR1VadjFXOU8yTVB6YlVGQUFyWDZR?=
 =?utf-8?B?VzBCbDN2ajA0aXQ5U3lqVjA3b2t4TDJKR3VwWmZFWW5uUzZzcG0xNGpKa2t0?=
 =?utf-8?B?SjVzd3dpNnRmeS94R3VYbGR6TTRaSDdhQ1BucFU1dDhHRGt3Mzh0cDNyV0Ux?=
 =?utf-8?B?eXhJTS9hNitjdEsxNUdlcHc5Qm9QQW13a2xrNUZHa3lycFRrMHRXT3BQemVN?=
 =?utf-8?B?RW84dEpYSkRWaWtENzZ0eDJHTGJ4OXJabFRvSm1lZkk0MGMxRWhCNkIxZHU5?=
 =?utf-8?B?VGRDZkFHd08vTGtkVHNOQ3pGT2JtNUkxVHgwK2s1UG1qTmQ2WjhRWjh3bHYv?=
 =?utf-8?B?WUFGWk1uNmVuM1NsU0V1V25TbkJXNlY5YTFnVkVwUTFjRTgvZkg3Z2EyemVR?=
 =?utf-8?B?RWlrTEpFdjJUY2xFN3hBaFNmR3BRaUM1TDQ4VEhTaDJ2WkxUK3lYM0xzaHlJ?=
 =?utf-8?B?OWt0S0kvaUp2TDkyNnBndlUxV3pPU3ZEcERsNVBJOFlKMFdLZnB4ZVgzMWxC?=
 =?utf-8?B?MUZ0Vi8zNGhoeHdmcnl1OVpacWhlWVR6Y1h2OEtPdm1qZ1pubVdrTUxteDRN?=
 =?utf-8?B?QzJjYjNSNGJTQzRpZXVpMXE4amhYeWJWMFYyQzZhendrand1a3JoZkZIemtm?=
 =?utf-8?B?UlVsbGVQT2dnOThiU1pOZS8yOFF6R09paExqbUZ6NS81KzR3Q2MvQUJkRXBO?=
 =?utf-8?B?bmFEKzVXK1FEUWxoUzRXc0pFQW0rZlpWOFRoSEhjUCs5S3JaWmlyVE53bEJr?=
 =?utf-8?B?OWxnek9IOEN1WGYwT0FwWjNEM0ZjT2c1T3h3STBmLzdHWXRWTkd1WTEyRk80?=
 =?utf-8?B?aUdhMnVlS2N6MnBVd0hEV3RKWDIwalZhSDR2NDhEdFgreFBTSkZoU3FOK2Vj?=
 =?utf-8?B?QWtIVGxub2h1NldpdGtNcmNxcEN5MExmdmhIcnZ6Tm1reldXOEo4K01YZ0Q2?=
 =?utf-8?B?TE56NVE2ODZ3c1F1V0c2Um9rRkJuZEw3YVQ4SVNIYmYveHkrcXBDb0R4b2pZ?=
 =?utf-8?B?NWZRMVJHNU5FTkxFVGdrMEVCSURVcFJHZU5CaitpVllab3RMckVzZlcxU0cz?=
 =?utf-8?B?bDRYNEUxTkJRcUNrUnFzemx0WDlKOWlKOWNzNXZjY0cvMXdmclJndER4aFpi?=
 =?utf-8?Q?laJt4kZ/29or2U2AiJHz4o0BIARK0MaLIZ5n3zpb7tcVw?=
x-ms-exchange-antispam-messagedata-1: pBUAbZ/lwMU0/nv9uNWyfVkjvjXtty8dBkU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <930B2BE09FE65A439F181992A112C091@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: R5nRQ1pcT3pglnXTvgLHknMg7NALo6OVExa9bu7v/6ZhZ7sSuTy8rTULxtBI0mHa3ERYXopNqV6FBKPbAaWNXuRaz5ZRdo8CieCa4ddPEMZZe2sAoQNUcQ0q6XuEzoSss13amv4NcifczAWoBqfPn4vOlqAMNw/Zv/O4ECQRkTNO4khT3LZUFAfIhn1p1VAOpPJHgTrfBC2l10GMSvV8EHlr9eW57xYGrDOgGJzcT1jh6c9F/PWdiyehgqCsNzY5BTHi5PAdvCqW+HlbNaGvaDBUh6JVEh07AC3YjbytLaoEe4o+jVIb9p0rj/OpxxW3oxysIiMLjc+dCRU+4Gnscw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LeFyx4RezVeMBU3UpWTWivyNwLd0prEQe83eCv60BYME3MwERGAG6LKuS21z7CkUFZfigxt8Xhn08+yjOq2e/xiSsJLgGG04fkfS4+wJYb3SRPm5sUOjhWg00Z++pI9Yt9SPM3zTsM4ppotF/9EWGRxH+LOX5NdYrHFcp5tdjH47wE57rpBXXsSCwuaPhtsEJhzxK5uA8QayemkVCd966Erc2/qgH0yEHYGSOQ7P51dAKhI0dCVSsn8WrXaES+uMJD1/sitpT87egjLSZAXklRISE2KJ5qZw5yQzmUfyNvLJdz3HPHWmTvsqEdrHkqxl4OkLCbXt5QLMHsWUbk9xMaAoHBhCYzmcK0l2BxS8WKKsNbNILSUU78qyQq2jHDAJ0UriXV3BMDfgncRiRGKM7nc85M7Pv9NdLbj/AA7ankY11cefG6JxAZWGfwc/nYohogjTIoWoxZjYO/F0njZhqBFfsog30eg3naq6uCqgD8elD9rHDRLCSJDJ6ljvONH+8VHt8ihWtYiKlBYmAL6NsgVoMhxcHPLE5zzM5gk93s1rGN5by1kbmga2AN5Xo2Dnw2j649Tds6B/axrroY+W7V8ZNDslvNupuhnqKwVc2DQbw+TLQ0JsBNmj7YK8Z146
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5831cfac-264a-43e7-400e-08df40748df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 04:22:25.1728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzypelJlTWTpz53+0tebSGmgEky4PKWTVSjMBolX8aRdlo/pEwxyQ7vF5b7/64ZWterGrtamxZ/+Wt/PwZvzQ0qmN95TghtbqlUbXE5b/58=
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTEwLTI4IGF0IDIyOjAxICswODAwLCBUYW4gQ2hpIHdyb3RlOgo+IEtWTSBp
cnFmZCBieXBhc3NlcyB0aGUgUENJIGRldmljZSdzIElPTU1VIEFkZHJlc3NTcGFjZSwgc28gTVNJ
Cj4gYWRkcmVzc2VzIHJlcXVpcmluZyB0cmFuc2xhdGlvbiBtYXkgZmFpbCB0byByZWFjaCB0aGUg
Z3Vlc3QgSU1TSUMuCj4gCj4gVHJhbnNsYXRlIE1TSSBhZGRyZXNzZXMgdGhyb3VnaCB0aGUgZGV2
aWNlJ3MgSU9NTVUgQWRkcmVzc1NwYWNlIHdoZW4KPiBzZXR0aW5nIHVwIEtWTSByb3V0ZXMuIE9u
bHkgZGlyZWN0IG1hcHBpbmdzIHRvIGFuIElNU0lDIE1lbW9yeVJlZ2lvbgo+IGFyZSBpbnN0YWxs
ZWQgaW4gS1ZNIHJvdXRlcy4KPiAKPiBPdGhlciBJT01NVSBNU0kgcmVtYXBwaW5nIGZvcm1zIGFy
ZSBub3QgY29udmVydGVkIHRvIEtWTSByb3V0ZXMgYW5kCj4gY29udGludWUgdG8gdXNlIHRoZSBl
eGlzdGluZyB1c2Vyc3BhY2UgTVNJIGRlbGl2ZXJ5IHBhdGguCj4gCj4gU2VsZWN0IFBDSSBmb3Ig
UklTQ1Y2NCBLVk0gYnVpbGRzLCBhcyBRRU1VIGN1cnJlbnRseSBlbmFibGVzIHRoZQo+IFJJU0Mt
ViBLVk0gdGFyZ2V0IG9ubHkgZm9yIHJpc2N2NjQtc29mdG1tdSBidWlsZHMgYW5kIHRoZSBNU0kg
cm91dGUKPiBmaXh1cCByZXF1aXJlcyBQQ0kgc3VwcG9ydC4gQWxzbyB0cmFjZSB0cmFuc2xhdGlv
biBmYWlsdXJlcyB0byBoZWxwCj4gZGlhZ25vc2Ugcm91dGUgc2V0dXAgZmFpbHVyZXMuCj4gCj4g
U2lnbmVkLW9mZi1ieTogVGFuIENoaSA8dGFuY2hpMjVAbWFpbHMudWNhcy5hYy5jbj4KPiBSZXZp
ZXdlZC1ieTogTnV0dHkgTGl1IDxudXR0eS5saXVAaG90bWFpbC5jb20+CgpUaGFua3MhCgpBcHBs
aWVkIHRvIHJpc2N2LXRvLWFwcGx5Lm5leHQKCkFsaXN0YWlyCgo+IC0tLQo+IAo+IENoYW5nZXMg
aW4gdjM6Cj4gLSBSZW1vdmUgdGhlIHVudXNlZCBsZW5ndGggdmFyaWFibGUgYW5kIHBhc3MgTlVM
TCB0bwo+IMKgIGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlKCksIGZvbGxvd2luZyBOdXR0eSBMaXUn
cyByZXZpZXcuCj4gCj4gQ2hhbmdlcyBpbiB2MiAoYmFzZWQgb24gQWxpc3RhaXIgRnJhbmNpcydz
IHJldmlldyk6Cj4gLSBTZWxlY3QgUENJIGZvciBSSVNDVjY0IEtWTSBidWlsZHMuCj4gLSBBZGQg
dHJhY2UgZXZlbnRzIGZvciBNU0kgdHJhbnNsYXRpb24gZmFpbHVyZXMuCj4gCj4gwqB0YXJnZXQv
cmlzY3YvS2NvbmZpZ8KgwqDCoMKgwqDCoCB8wqAgMiArKwo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9r
dm0tY3B1LmMgfCA1NAo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4g
wqB0YXJnZXQvcmlzY3YvdHJhY2UtZXZlbnRzwqAgfMKgIDQgKysrCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDYwIGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L0tjb25m
aWcgYi90YXJnZXQvcmlzY3YvS2NvbmZpZwo+IGluZGV4IDExYmMwOWI0MTQuLjBjZjJjOGUxYzQg
MTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L0tjb25maWcKPiArKysgYi90YXJnZXQvcmlzY3Yv
S2NvbmZpZwo+IEBAIC03LDMgKzcsNSBAQCBjb25maWcgUklTQ1Y2NAo+IMKgwqDCoMKgIGJvb2wK
PiDCoMKgwqDCoCBzZWxlY3QgQVJNX0NPTVBBVElCTEVfU0VNSUhPU1RJTkcgaWYgVENHCj4gwqDC
oMKgwqAgc2VsZWN0IERFVklDRV9UUkVFICMgbmVlZGVkIGJ5IGJvb3QuYwo+ICvCoMKgwqAgIyBr
dm1fYXJjaF9maXh1cF9tc2lfcm91dGUoKSBuZWVkcyB0byBhY2Nlc3MgUENJRGV2aWNlCj4gK8Kg
wqDCoCBzZWxlY3QgUENJIGlmIEtWTQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yva3ZtL2t2
bS1jcHUuYyBiL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jCj4gaW5kZXggNDVhZDVlMTUyNS4u
YTFlZWNkNzJiNyAxMDA2NDQKPiAtLS0gYS90YXJnZXQvcmlzY3Yva3ZtL2t2bS1jcHUuYwo+ICsr
KyBiL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jCj4gQEAgLTE1MDcsNiArMTUwNyw2MCBAQCBp
bnQga3ZtX2FyY2hfcmVsZWFzZV92aXJxX3Bvc3QoaW50IHZpcnEpCj4gwqBpbnQga3ZtX2FyY2hf
Zml4dXBfbXNpX3JvdXRlKHN0cnVjdCBrdm1faXJxX3JvdXRpbmdfZW50cnkgKnJvdXRlLAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dWludDY0X3QgYWRkcmVzcywgdWludDMyX3QgZGF0YSwKPiBQQ0lEZXZpY2UgKmRldikKPiDCoHsK
PiArwqDCoMKgIEFkZHJlc3NTcGFjZSAqYXM7Cj4gK8KgwqDCoCBod2FkZHIgeGxhdCwgdHJhbnNs
YXRlZDsKPiArwqDCoMKgIE1lbW9yeVJlZ2lvblNlY3Rpb24gc2VjdGlvbjsKPiArwqDCoMKgIE1l
bW9yeVJlZ2lvbiAqbXI7Cj4gK8KgwqDCoCBPYmplY3QgKm93bmVyOwo+ICsKPiArwqDCoMKgIGlm
ICghZGV2KSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+ICvCoMKgwqAgfQo+ICsKPiAr
wqDCoMKgIGFzID0gcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKGRldik7Cj4gK8KgwqDC
oCBpZiAoYXMgPT0gJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHJl
dHVybiAwOwo+ICvCoMKgwqAgfQo+ICsKPiArwqDCoMKgIFJDVV9SRUFEX0xPQ0tfR1VBUkQoKTsK
PiArCj4gK8KgwqDCoCBtciA9IGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlKGFzLCBhZGRyZXNzLCAm
eGxhdCwgTlVMTCwgdHJ1ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKTsKPiAr
Cj4gK8KgwqDCoCBpZiAoIW1yKSB7Cj4gK8KgwqDCoMKgwqDCoMKgIHRyYWNlX2t2bV9yaXNjdl9m
aXh1cF9tc2lfcm91dGVfZmFpbGVkKGFkZHJlc3MsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICJhZGRyZXNzIHRyYW5zbGF0aW9uCj4gZmFpbGVkIiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIm5vbmUiKTsKPiArwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIDE7Cj4gK8KgwqDCoCB9Cj4gKwo+ICvCoMKgwqAgLyoKPiArwqDCoMKgwqAgKiBPbmx5IGRp
cmVjdCBJTVNJQyB3cml0ZXMgY2FuIGJlIHJlcHJlc2VudGVkIGJ5IGEgS1ZNIE1TSQo+IHJvdXRl
Lgo+ICvCoMKgwqDCoCAqIE1TSSBwYWdlLXRhYmxlIHRyYW5zbGF0aW9ucyBpbnN0ZWFkIHRhcmdl
dCB0aGUgUklTQy1WIElPTU1VCj4gdHJhcAo+ICvCoMKgwqDCoCAqIHJlZ2lvbiwgd2hpY2ggcmVx
dWlyZXMgZnVydGhlciBCQVNJQy9NUklGIHByb2Nlc3NpbmcuCj4gK8KgwqDCoMKgICovCj4gK8Kg
wqDCoCBvd25lciA9IG1lbW9yeV9yZWdpb25fb3duZXIobXIpOwo+ICvCoMKgwqAgaWYgKCFvd25l
ciB8fCAhb2JqZWN0X2R5bmFtaWNfY2FzdChvd25lciwgVFlQRV9SSVNDVl9JTVNJQykpIHsKPiAr
wqDCoMKgwqDCoMKgwqAgdHJhY2Vfa3ZtX3Jpc2N2X2ZpeHVwX21zaV9yb3V0ZV9mYWlsZWQoYWRk
cmVzcywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIm5vbi1JTVNJQyB0
YXJnZXQiLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IG1lbW9yeV9y
ZWdpb25fbmFtZShtcikpOwo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMTsKPiArwqDCoMKgIH0K
PiArCj4gK8KgwqDCoCBzZWN0aW9uID0gbWVtb3J5X3JlZ2lvbl9maW5kKG1yLCB4bGF0LCAxKTsK
PiArwqDCoMKgIGlmICghc2VjdGlvbi5tcikgewo+ICvCoMKgwqDCoMKgwqDCoCB0cmFjZV9rdm1f
cmlzY3ZfZml4dXBfbXNpX3JvdXRlX2ZhaWxlZChhZGRyZXNzLAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAibWVtb3J5IHJlZ2lvbiBsb29rdXAKPiBmYWlsZWQiLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IG1lbW9yeV9yZWdpb25fbmFtZSht
cikpOwo+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gMTsKPiArwqDCoMKgIH0KPiArCj4gK8KgwqDC
oCB0cmFuc2xhdGVkID0gc2VjdGlvbi5vZmZzZXRfd2l0aGluX2FkZHJlc3Nfc3BhY2U7Cj4gK8Kg
wqDCoCBtZW1vcnlfcmVnaW9uX3VucmVmKHNlY3Rpb24ubXIpOwo+ICsKPiArwqDCoMKgIHJvdXRl
LT51Lm1zaS5hZGRyZXNzX2xvID0gdHJhbnNsYXRlZDsKPiArwqDCoMKgIHJvdXRlLT51Lm1zaS5h
ZGRyZXNzX2hpID0gdHJhbnNsYXRlZCA+PiAzMjsKPiArwqDCoMKgIHRyYWNlX2t2bV9yaXNjdl9m
aXh1cF9tc2lfcm91dGVfdHJhbnNsYXRlZChhZGRyZXNzLCB0cmFuc2xhdGVkKTsKPiDCoMKgwqDC
oCByZXR1cm4gMDsKPiDCoH0KPiDCoAo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdHJhY2Ut
ZXZlbnRzIGIvdGFyZ2V0L3Jpc2N2L3RyYWNlLWV2ZW50cwo+IGluZGV4IDkzODM3ZjgyYTEuLjUw
OTgwYzAzMWQgMTAwNjQ0Cj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RyYWNlLWV2ZW50cwo+ICsrKyBi
L3RhcmdldC9yaXNjdi90cmFjZS1ldmVudHMKPiBAQCAtMTIsMyArMTIsNyBAQCBtc2VjY2ZnX2Nz
cl93cml0ZSh1aW50NjRfdCBtaGFydGlkLCB1aW50NjRfdCB2YWwpCj4gImhhcnQgJSIgUFJJdTY0
ICI6IHdyaXRlIG1zZWNjCj4gwqAKPiDCoCMgb3BfaGVscGVyLmMKPiDCoHJpc2N2X2V4Y2VwdGlv
bih1aW50MzJfdCBleGNlcHRpb24sIGNvbnN0IGNoYXIgKmRlc2MsIHVpbnQ2NF90IGVwYykKPiAi
JXUgKCVzKSBvbiBlcGMgMHglIlBSSXg2NCIiCj4gKwo+ICsjIGt2bS1jcHUuYwo+ICtrdm1fcmlz
Y3ZfZml4dXBfbXNpX3JvdXRlX3RyYW5zbGF0ZWQodWludDY0X3QgaW92YSwgdWludDY0X3QgZ3Bh
KQo+ICJNU0kgaW92YSA9IDB4JSJQUkl4NjQiIGlzIHRyYW5zbGF0ZWQgaW50byAweCUiUFJJeDY0
Cj4gK2t2bV9yaXNjdl9maXh1cF9tc2lfcm91dGVfZmFpbGVkKHVpbnQ2NF90IGlvdmEsIGNvbnN0
IGNoYXIgKnJlYXNvbiwKPiBjb25zdCBjaGFyICpyZWdpb24pICJNU0kgaW92YSA9IDB4JSJQUkl4
NjQiIGZhaWxlZDogJXMgKHJlZ2lvbj0lcykiCg==

