Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=HiM+pxvt;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=rrDa++14
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVhrN-0005B0-3A; Mon, 23 Nov 2026 23:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=781b605ec=Alistair.Francis@wdc.com>)
 id 1xVhrJ-0005AE-3n; Mon, 23 Nov 2026 23:10:21 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=781b605ec=Alistair.Francis@wdc.com>)
 id 1xVhrF-0004Cf-Jc; Mon, 23 Nov 2026 23:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795493418; x=1827029418;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FgTh0Wjuv7kGcIGVJS9P/EqKh4IOcsxM4Y/7tVxYkVo=;
 b=HiM+pxvte4nXgel3QfP5m5smahVHMNiTCeDroEKgJWAxH2vobfHjXM3A
 G84CZCF0J1E3quFb7TjF+8+AguMjPIOBbEU7JheAfYrjHnxt0WlhVPAam
 E1DyGFrqruK1oZ0rLpffskqoYKD8wcCWV68/D1KSX2m1aMdtw56sINXp4
 Ef/IL7T8lcFPhWJVCFoXeaWkEmNzEZKLQEuEGlvfdfF16+H00iZoZ8oI8
 SzSDjL8Udj/tb1Ug5oOgIvYGtAkW4cXsNBCtyIMUvHhN1Q1c8RzWcpEfW
 qvC1Bvz6kmogfho/H2mFfqne1abeQPh4QlHM7zY2/CmbK8Tk/3yatfj1R Q==;
X-CSE-ConnectionGUID: 5T/of9OhSRGpNdruMbgW6A==
X-CSE-MsgGUID: hV99HJ68QOCrcIZxVYxnow==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; d="scan'208";a="161615779"
Received: from mail-northcentralusazon11010054.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.54])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 24 Nov 2026 12:10:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3Vc7LqHgj45/l5ex34wjiNUStGdN57Q6adqLA9AwLkUw4QeQC6yH4RGQh3boRXUEzlK6BSoDqBUGaUgQpvBOg+PMj1KS0KXttu/Vks8FZLfEROhAdbxDhx8hxs21A107iSqdUHgIVgi+X+2x7XX/nb/UtUKhOAGERZ6q3aXZqD5gCvoSldyujl8oIuFRqueDMZ/k01GfMlkwP/LzJMsego3e/71gQgRdTT7pk+5jHKKPQ+ZyovCFRvDt7lut0fYN0AhAc5PvgCHHTPk7BfPxDWW74kB5rA10Um9BPWg6q28NNreZYEuzWeFA/cx9rnvobmQoLcMqv3mS3K0TXjU0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgTh0Wjuv7kGcIGVJS9P/EqKh4IOcsxM4Y/7tVxYkVo=;
 b=EDj8cQGlngiYiGsi5YAPAAA7f2+uv2ZU0AGPtMct9c6hFnRcq5rkZkrPhNM81iTEQMvtKhxBsAJyHGyP7krFFEOHIToLcE5gBk6tcTc5YrvqjMeX+TMPLqrMyfjTsQYImHFqfCS4x6IP9IAOE+7VmfTZ+o5guW0j2sfx4LgOGNPGOsvpx+uEQdHiZ/6QgVynkXIu//QXGy+fezrwOPTDVGGTaH1FxGo21+mAVE2JZNQn1h0JV1eaVjG1v7FtP3E+1MNY7ERqM6ewEOpRmFOQa0WsDLWXwF1rVqKlhlWkKDS7CeDv7DfzFlfS6XwmaljaK0ujtV2TK8U/3+N8IagkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgTh0Wjuv7kGcIGVJS9P/EqKh4IOcsxM4Y/7tVxYkVo=;
 b=rrDa++145a3sBMiBldPBqRYcMayQcGTz1NkC8QvpeAhDAV9ijRr3ateKfwXthIbjcz3XpsvipTcxUCxIbiZrMegqD3jWZIMHBsbZvI/0Ec7+aVZGAvBHvNRjTrQLj85jUoiVmAA+AN/g2qR3Nz0GMPCFsobZydIOJq9N9OA0eJ8=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6818.namprd04.prod.outlook.com (2603:10b6:a03:224::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 04:10:07 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 04:09:50 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 1/1] target/riscv: do not write RVG in misa CSR [GL4811]
Thread-Topic: [PATCH v2 1/1] target/riscv: do not write RVG in misa CSR
 [GL4811]
Thread-Index: AQHde4HdG+1D1wW+BEK8dMXh5+YzZ7c8nEeA
Date: Tue, 24 Nov 2026 04:09:49 +0000
Message-ID: <015c727c90508107f6f9f76ca8b383ff11822d21.camel@wdc.com>
References: <20261123193545.15632-1-daniel.barboza@oss.qualcomm.com>
 <20261123193545.15632-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261123193545.15632-2-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6818:EE_
x-ms-office365-filtering-correlation-id: 3a7d4dfb-e54d-4408-de2b-08df49e0c8d1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|19092799006|366016|1800799024|376014|18002099003|22082099003|261009223027099003|261021121427099003|260925021911599003|260925022911599003|260925021311599003|261022105027099003|4143699003|56012099006|11063799006|261102123227099003|261028144727099003|261022075727099003|261102124527099003|261026140227099003|261026121527099003|10067099003|38070700021;
x-microsoft-antispam-message-info: owIMxkD/TCCQXo0Nq72C9KMxHhKPVINBlKubToPsmWfdGzuEz1cOpStS/WbqyGp0MQJZs+w4UAjoCcrLSTyGmWFZ7wU19fl8b2JmcEgxeJ5ePvi9N4yQpxOtf9I5tG+9heyefXd2O9j9qKq9CZyENvK/XpqSTcoYCX0SRMf2YtyOBNiMbNW4qwkGfHZgWgHerI4JPXL3L8KCA38/4I7ex4i2a9ZamWlktUvA4W3+uCjiED4Zpze+YNAkB0/xGkaLC7zE24Lasukx3mxuz3piAR841455zdWkYkHJ0zh/4/pyMpHBU/DthWpu9RPOZlpiR2HPH/cAsBAHDKFVrZI8i0bSzgYt5gkkps0FZIGG4+8PGYWBtYtfAKMc1LDmtilYlVKXYvvRqJWK/QpQm12/kQMIqAtRNJod+BOvwg+SMub0+J4Py+1gJcFB2G9k5gEa3lD9z2fO2/fw/0jDv/w4wCboIrYQWmv9gotxX6u+18X2z9ln5mWakLPZmP+zrW6fSCsMoe/BMV12CwIbULdaPYqGyTX8R2x5W1rtPB+YWr5MVVuRwwCB/bHEjox4/7ixp0JJIJ3Vnay/nMiQhRW7ZsYPSCetJtPA24Xkn9lqG4mFDS36qF4AVINulDT6gskOTmMtUhtjv1T/pX1l+1mgZY/fvXn3tlmu1vKrynwFJnXdgkH+UN5Bd4DlRDz6KJI0/fPkHk6fxEMI75L43tnh0NOvCINv7rq7UbRE4IGc5UA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(19092799006)(366016)(1800799024)(376014)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(260925021911599003)(260925022911599003)(260925021311599003)(261022105027099003)(4143699003)(56012099006)(11063799006)(261102123227099003)(261028144727099003)(261022075727099003)(261102124527099003)(261026140227099003)(261026121527099003)(10067099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2NMbWhHeGlJbkJZNkZLbzhFaEhKYnRiY2QxaXUvVWtOSnV4aHhOdGJIYkxH?=
 =?utf-8?B?T2NRdHB3N2RGU0FYVVpHc0VGakZCcnNNYmtsUy9uZm5Db0FJL1BnOEZGcTR5?=
 =?utf-8?B?UCtnY1lsRGMvaVZyQ1ZCNUc4cHhNS3VSVks1TW92cmxMRkRBUmxkZGFVWmps?=
 =?utf-8?B?ckVIS3hGcVlZQStVV3VwQ0hNNnlQTlZaUExZUmZQcGJBUXBLTDBjenZKaEJa?=
 =?utf-8?B?aFlZVjhqVGlZU0l3emljaEc4N0JyMmdNcDFGOWxjaXlpd09uMk8wUTZpb2ZT?=
 =?utf-8?B?ak56cm9oRzhtbEpiZVI5aXcxc1dBNm51M3pHck1HdWwvS0pjWXFOUEdXYkkx?=
 =?utf-8?B?RExOMXl0TXEvOUdBUGNIaFNEMWFKSkpKWW5hT05wV0U4WUU0a21SMjhxd21z?=
 =?utf-8?B?aXNKem1VTTZtMENIVFc5ZjkybkFEYjc4NmZMa2o3ZTN4MTBqSmwwcVJjaUR4?=
 =?utf-8?B?Tno4K0UveWNaMmxEMnQySlB6RkxpVXhHcVZyZUxFL3p5dkp0T1BwT3ZmYVVI?=
 =?utf-8?B?a3NmSm1mc0dRZkdJeGd3TXI4dnhjcmQrM0dnVkswMWYxZzhLNGZ1WTEzWStG?=
 =?utf-8?B?eFJ4b1RWc1Y0anJ1U3NuYjhkUzJ0azRITEtxMXFyVE1pZCsrdGVwNFMycGVX?=
 =?utf-8?B?bTlxVk1qcTRxeFE1MGF4MmVtbjVDNmtYeS93YTk2bkNOQzVwZjkxTUFWcTAy?=
 =?utf-8?B?TXBEblRFaythUWJZdldaK2VJMStmamhaOHIraFlxdzc5eVl5VThHZkdEdmNR?=
 =?utf-8?B?QXBiR2xsRiszQ3BjK3B4ZFNETzhFU3dpWEpQMXhRemtZajdMcjhyYldVWGhs?=
 =?utf-8?B?a1hTS0RpS1hlbmJValNTYUo5dkFWd3ZhWWhXdlIvOGJSald1QWNHRWJGbW9C?=
 =?utf-8?B?YVFrdHJqd2FwclpNb0pmU1licE9SUFp0TGNvYXB2VlZmVEV0U2swQlNIamd0?=
 =?utf-8?B?enN4Tms4SlpsYXZjOEp4Uk8wNS9zT0lnQ1BKYzRteGtOVDZwRFpMSllvSHFG?=
 =?utf-8?B?NzNlZEFOM2JINWVGdklTVXE3OEg3L1pZMTM4QW1aSXpMTmgzN2Mya2dSNW9L?=
 =?utf-8?B?WllXeVVGYXlIcTJyODJ5V0YzaGhyYjdGakZxZWhUNTVJTVNSS2lReXNWbDR6?=
 =?utf-8?B?MHdWeXVZU0h6SWJNTi9WN2pNR2lsbFlHMGJVcW5wV05udmFqc1BEWUxNbHZp?=
 =?utf-8?B?cXpHdjYyL1dCZkJndzJXeVJKNmFTQlRQSWgzVXJHNmx1VzlqZHlRaXIyYnlr?=
 =?utf-8?B?S2U4dWFtNTM4dzkxZnM3K0kzWEs2bmVyRkgwSlVQNmlTY0R3eDhQeTM3Qks2?=
 =?utf-8?B?WkVwK05qZUJiK24vNGhPalgwNEdGYklmSE1YQjY3QjdwSEo2UjBZV0pGSmh0?=
 =?utf-8?B?VXlpcktXWG5LZWYvV0Z2cjhrZ0pTVURiRW9GM2hvK01JVHlCRjZ5aXQ5K2xP?=
 =?utf-8?B?SnpkZHRVcDNEOTNGMEdwc0VtWVNmQmNoVzUvM3lBNFVLNHVtaVBoVjc2OEda?=
 =?utf-8?B?QVplcW1reGNRZlprK0lreXF0VWxWT09GaVJrSHcyWTNlY01sRmxZd0hPSkpR?=
 =?utf-8?B?dnY4UHNqa1BBd0l5WGJvK1FSbHh0QTdwZlZGR3Y5RkZWWVkyT2hMS1plR2Zu?=
 =?utf-8?B?TGQzeS9rbjlwOUp6aXBpaVVFUnlaR1FNanMyMks2by9RSkk2UFRaNWt3NDJx?=
 =?utf-8?B?VHJsQWFZaXV1eFVzMzNEVjZUa0pwOHAzYU9RNkozMDhtaG9XVFFKTWgxa0J1?=
 =?utf-8?B?cmVKY3ovMm5BSDZ4b3VMbGtwcG1tcFZGZ2h1WjZFV1pLNjZmL2xMZS9obTR0?=
 =?utf-8?B?SlpUMU9rWS9aNW4vdVpnOXk2dTR6Y1lrRzM3bGprSE8vRndOUW1NcWNwNEFO?=
 =?utf-8?B?Q0lqWUpsdVJsQWxkMldaNHl1anFOSlZwcE1HeS9maXhieERFa2M5SGNHQW1M?=
 =?utf-8?B?YjgyMyt2RHVKMDE5UU1jK3hhL3F5OHQrc2RXRklyMlJ0RU1rcHNqc2JIYTJE?=
 =?utf-8?B?dGJSaXhtbEVVazNoWnFSMkJ2bTFxQ1oyZlVlU0M0SjVid2N0bVVub1NuVnEz?=
 =?utf-8?B?Wi9rdnNRYnJQU3I3RUd4RGtFdWxOTXhLV3IrNGNpVDV3V2pHTStwaDVVUzVy?=
 =?utf-8?B?SHVZZXNabkVpdm1KQ1VhdFdYM210UjZyeXJuOWpGRW9rMGFNZ0t4Y3pIemh6?=
 =?utf-8?B?NGtIdTFVL0NNQ2lHVW4xWmVVT0ZMTjdON3AydTVIaDdnSUhsU0gvalVReUZS?=
 =?utf-8?B?K2FBNUlOMkgxMndnejJaWUVaeWUrQTkyTmVLM3JYMlJQT0hCUTlVNnh5dGdw?=
 =?utf-8?B?V1ZSQjh6cWhIdmpoRkFxNUI2U0F0elFHTUxRMUZlelpDYVFIOUlPdFhuWEkx?=
 =?utf-8?Q?Cwjna7XuY4m/59j1DyAVs60JueRGzpgLnMXmE8ssyzuOY?=
x-ms-exchange-antispam-messagedata-1: yKkOH15+Nwjgh6JTVoXbRoETbidP7wtMpsU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <28B66CEA4A2F5F4098AA5B5DFA0F7603@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IxeiMUI8ZPy2o+wXgW2IsgjBz59Zbik3q+4G0JHqbOgxu74QenMGK0ftsz3xGSWqvbMvFh7/gwUex32n1oSEsoJmCmGEuoaLMxPDmKj+/vSA7kXSt9gORLCHK9uk4NsbFXd30ssDpJtG4mjrPTndf5t8dMKK+f4XIfivT9GH+dD4yuAAymCyQN1ME9Jz9/+I9AP1/73cYqcOEpsBWKT4VDwayFzxPvu82CMwepfTGOSn1dtQ+NVq6aJCENdLZXz2HTJQoFcE9Y16JGnA8A1Z9mCzZquC73CXphjPqaKQLrWGYKMeUlNZN8c6xmUVElMT7P+5UEATDk7jwBTHBmxQAQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PgLZjhVF/qNtFrA57OhQYw0dAb+d+R2ab13ifNtpcD4i0wYZzwdqZUDB5af7EzPMGrzzbKwEyzIElwm/cazeyDZU/kFFlni/EPK/412iSo+qosnNmhT7xnf+I6eoZZJ2nxcX5lGXks+Vj+oHGtVhoPf/gzEiBDMDs8Y4T018B2DjqTvO6/l55n0gIt8WAub4tZry28pgqdufQ7ZQPHTi6bPZHpo67qig4skkCNGhHOfaxaGK/j1jZgTju65WEczxNIwzqvR8mvXSNl0S9zIV2L5KC1YOt80e0GxRQDBWeGx0V+Cj5V2CI18AALDnWdaS0YTShJnO9IG0WJO8tO3NXFmOmHlb9Wd7i/m1/t2Kor8CodhhkooQZnn8ROQufKNYbhIURhrzYd34NBhMpnB2ZArSxM2Of8P7XqGIaaz3ci2HVVpz45zVQ2YRi3kfzz9gIodJyD1K5OniJ1mLi+oiH8dHlPPCYHeuw/mSWT3KTedphKifNPe5kacZh1RB66rdxo2DfR9MDp2dHfNGvP+an8kS29/CHu1XtFP8aa6E4NyMZ87O1aAbSUVp/TMBd7Z/rfNdPgYLX11c2S1aot5x+TE6hsue4EaYWhi9FaC+nFrDmN8+Xv5Dt5iQqhkkI86+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a7d4dfb-e54d-4408-de2b-08df49e0c8d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 04:09:50.0114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYBAMj4CLX0OTIq5dkAJFO2XvGHf1W/O+dauI8TknC/XL9Onh0LgIxSqPPW3bUeGYCovuMjzTYaLTiH2XXktOgPrJSguTKvq6tz63OGMAOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6818
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=781b605ec=Alistair.Francis@wdc.com;
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gTW9uLCAyMDI2LTExLTIzIGF0IDE2OjM1IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSXQgc2VlbXMgbGlrZSB3ZSBjYW4ndCB3cml0ZSBSVkcgaW50byBtaXNhLsKg
IFRoZSBiaXQgaGFzIGJlZW4gbWFya2VkDQo+IGFzDQo+ICJSZXNlcnZlZCIgZm9yIHByaXYgc3Bl
Y3MgMS4xMSssIGkuZS4gaXQgZG9lcyBub3QgcmVwcmVzZW50IHRoZQ0KPiBleHRlbnNpb24gcGFj
ayAiSU1BRkRfWmljc3JfWmlmZW5jZWkiLsKgIFRoZSBvZmZpY2lhbCBleHBsYW5hdGlvbiwgYXQN
Cj4gbGVhc3QgZnJvbSB3aGF0IEkgY291bGQgZmluZCwgaXMgdGhhdCBzZXR0aW5nIFJWRyBpcyBy
ZWR1bmRhbnQgd2l0aA0KPiByZWFkaW5nIHJpc2N2LGlzYSBhbmQvb3Igb3RoZXIgZXh0ZW5zaW9u
IGRpc2NvdmVyeSBtZWNoYW5pc21zLg0KPiANCj4gVG8gbWFrZSBtYXR0ZXJzIG1vcmUgaW50ZXJl
c3RpbmcsICdnJyBpcyBzdGlsbCBzdXBwb3NlZCB0byBiZSBwcmVzZW50DQo+IGluDQo+IHJpc2N2
LGlzYS7CoCBUb29sY2hhaW5zIHdpbGwga2VlcCB1c2luZyAnZycgaW4gdGhlaXIgJ21hcmNoJyBu
b3JtYWxseQ0KPiB0b28uwqAgU28gYXNpZGUgZnJvbSBzcGFyaW5nIG9uZSBiaXQgaW4gdGhlIE1J
U0EgZXZlcnkgb3RoZXIgdXNlIG9mDQo+IFJWRw0KPiBpcyBzdGlsbCB2YWxpZC4NCj4gDQo+IFdl
IGhhdmUgYSBnb29kIGNodW5rIG9mIGNvZGUgdGhhdCB1c2VzIFJWRyBhcyBhIHN5bm9ueW0gZm9y
IHRoYXQNCj4gZXh0ZW5zaW9uIHBhY2sgYW5kLCBmb3Igbm93LCBJIGRvbid0IHNlZSBhIHJlYXNv
biB0byByZWZhY3RvciBpdC7CoCBXZQ0KPiB3aWxsIGNyb3NzIHRoYXQgYnJpZGdlIHdoZW4vaWYg
UlZHIGFjcXVpcmVzIGFub3RoZXIgb2ZmaWNpYWwgdXNlLg0KPiANCj4gRm9yIG5vdywgaWYgd2Un
cmUgcnVubmluZyBwcml2IHNwZWMgMS4xMSssIGZpbHRlciB0aGUgYml0IG91dCBvZg0KPiBtaXNh
Lg0KPiBUaGUgIkZpeGVzIiBjb21taXQgcmVmZXJzIHRvIHRoZSB2ZXJ5IGZpcnN0IHVzYWdlIG9m
IFJWRyBiZWluZw0KPiB3cml0dGVuDQo+IGluIE1JU0EuDQo+IA0KPiBGaXhlczogNGYxM2FiY2Iy
YmNiICgidGFyZ2V0L3Jpc2N2OiBhZGQgUlZHIGFuZCByZW1vdmUgY3B1LQ0KPiA+Y2ZnLmV4dF9n
IikNCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dv
cmtfaXRlbXMvNDgxMQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0K
PiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0
YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAt
LS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2Nzci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDE3ICsrKysrKysrKysNCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVp
bGQgfMKgIDcgKysrKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtbWlzYS1HLlPCoMKgwqDC
oMKgIHwgNTENCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hh
bmdlZCwgNzUgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cv
cmlzY3Y2NC90ZXN0LW1pc2EtRy5TDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L3Rj
Zy9jc3IuYyBiL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gaW5kZXggMmEzN2ZiNzM1Zi4uZWU4
ZDEwMmNlNSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiArKysgYi90
YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+IEBAIC0yMjE1LDYgKzIyMTUsMTUgQEAgc3RhdGljIFJJ
U0NWRXhjZXB0aW9uIHJlYWRfbWlzYShDUFVSSVNDVlN0YXRlDQo+ICplbnYsIGludCBjc3JubywN
Cj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiDCoMKgwqDCoCAqdmFsID0gbWlzYSB8IGVudi0+bWlzYV9l
eHQ7DQo+ICsNCj4gK8KgwqDCoMKgIC8qDQo+ICvCoMKgwqDCoMKgICogUlZHIGlzIHJlc2VydmVk
IGZvciBwcml2ID4gMS4xMCBidXQgd2UncmUgc2V0dGluZyB0aGUNCj4gK8KgwqDCoMKgwqAgKiBi
aXQgaW50ZXJuYWxseSBhcyBhIHNob3J0Y3V0IGZvciBJTUFGRF9aaWNzcl9aaWZlbmNlaS4NCj4g
K8KgwqDCoMKgwqAgKi8NCj4gK8KgwqDCoCBpZiAoZW52LT5wcml2X3ZlciA+IFBSSVZfVkVSU0lP
Tl8xXzEwXzApIHsNCj4gK8KgwqDCoMKgwqDCoMKgICp2YWwgJj0gflJWRzsNCj4gK8KgwqDCoCB9
DQo+ICsNCj4gwqDCoMKgwqAgcmV0dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gwqB9DQo+IMKgDQo+
IEBAIC0yMjQzLDYgKzIyNTIsMTQgQEAgc3RhdGljIFJJU0NWRXhjZXB0aW9uIHdyaXRlX21pc2Eo
Q1BVUklTQ1ZTdGF0ZQ0KPiAqZW52LCBpbnQgY3Nybm8sDQo+IMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIFJJU0NWX0VYQ1BfTk9ORTsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiArwqDCoMKgwqAgLyoN
Cj4gK8KgwqDCoMKgwqAgKiBSVkcgaXMgcmVzZXJ2ZWQgZm9yIHByaXYgPiAxLjEwIGJ1dCB3ZSdy
ZSBzZXR0aW5nIHRoZQ0KPiArwqDCoMKgwqDCoCAqIGJpdCBpbnRlcm5hbGx5IGFzIGEgc2hvcnRj
dXQgZm9yIElNQUZEX1ppY3NyX1ppZmVuY2VpLg0KPiArwqDCoMKgwqDCoCAqLw0KPiArwqDCoMKg
IGlmIChlbnYtPnByaXZfdmVyID4gUFJJVl9WRVJTSU9OXzFfMTBfMCkgew0KPiArwqDCoMKgwqDC
oMKgwqAgdmFsICY9IH5SVkc7DQo+ICvCoMKgwqAgfQ0KPiArDQo+IMKgwqDCoMKgIC8qIE1hc2sg
ZXh0ZW5zaW9ucyB0aGF0IGFyZSBub3Qgc3VwcG9ydGVkIGJ5IHRoaXMgaGFydCAqLw0KPiDCoMKg
wqDCoCB2YWwgJj0gZW52LT5taXNhX2V4dF9tYXNrOw0KPiDCoA0KPiBkaWZmIC0tZ2l0IGEvdGVz
dHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQv
c3lzdGVtL21lc29uLmJ1aWxkDQo+IGluZGV4IGNkZDJlOTlkMjIuLjU4OTcwYTBmMDEgMTAwNjQ0
DQo+IC0tLSBhL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiArKysgYi90
ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gQEAgLTExNiw2ICsxMTYsMTMg
QEAgdGVzdHMgKz0gew0KPiDCoMKgIH0NCj4gwqB9DQo+IMKgDQo+ICt0ZXN0cyArPSB7DQo+ICvC
oCAndGVzdC1taXNhLUcuUyc6IHsNCj4gK8KgwqDCoCAnY2ZsYWdzJzogY2ZsYWdzLA0KPiArwqDC
oMKgICdxZW11X2FyZ3MnOiBbJy1jcHUnLCAnbWF4JywgcWVtdV9hcmdzXSwNCj4gK8KgIH0NCj4g
K30NCj4gKw0KPiDCoGlmICdxZW11LXN5c3RlbS1yaXNjdjY0JyBpbiBlbXVsYXRvcnMNCj4gwqDC
oCB0Y2dfdGVzdHMgKz0gew0KPiDCoMKgwqDCoCAncmlzY3Y2NC1zb2Z0bW11Jzogew0KPiBkaWZm
IC0tZ2l0IGEvdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1taXNhLUcuUw0KPiBiL3Rlc3RzL3RjZy9y
aXNjdjY0L3Rlc3QtbWlzYS1HLlMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMDAwMC4uNDVhOWNhNzIwYg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL3RjZy9y
aXNjdjY0L3Rlc3QtbWlzYS1HLlMNCj4gQEAgLTAsMCArMSw1MSBAQA0KPiArLyoNCj4gKyAqIFRl
c3QgaWYgUlZHIGlzIGJlaW5nIHNldCBpbiBtaXNhLsKgIFNlZSBHaXRsYWIgNDgxMSBmb3IgbW9y
ZSBpbmZvLg0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVz
LCBJbmMuIGFuZC9vciBpdHMNCj4gc3Vic2lkaWFyaWVzLg0KPiArICogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+ICsub3B0aW9uIG5vcnZj
DQo+ICsJLnRleHQNCj4gKwkuZ2xvYmFsIF9zdGFydA0KPiArDQo+ICtfc3RhcnQ6DQo+ICsJbGxh
CXQwLCB0cmFwDQo+ICsJY3NydwltdHZlYywgdDANCj4gKw0KPiArCWNzcnIJdDAsIG1pc2ENCj4g
KwlsaQl0MSwgMQ0KPiArCXNsbGkJdDEsIHQxLCA2DQo+ICsJYW5kCXQxLCB0MSwgdDANCj4gKwli
bmV6CXQxLCBfZmFpbA0KPiArDQo+ICsJbGkJYTAsIDANCj4gKwlqCV9leGl0DQo+ICsNCj4gK19m
YWlsOg0KPiArCWxpCWEwLCAxDQo+ICsJaglfZXhpdA0KPiArDQo+ICt0cmFwOg0KPiArCSMgQW55
IHRyYXAgaXMgYSBmYWlsIGNvZGUgMQ0KPiArCWxpCWEwLCAxDQo+ICsNCj4gKyMgRXhpdCBjb2Rl
IGluIGEwDQo+ICtfZXhpdDoNCj4gKwlsbGEJYTEsIHNlbWlhcmdzDQo+ICsJbGkJdDAsIDB4MjAw
MjYJIyBBRFBfU3RvcHBlZF9BcHBsaWNhdGlvbkV4aXQNCj4gKwlzZAl0MCwgMChhMSkNCj4gKwlz
ZAlhMCwgOChhMSkNCj4gKwlsaQlhMCwgMHgyMAkjIFRBUkdFVF9TWVNfRVhJVF9FWFRFTkRFRA0K
PiArDQo+ICsJIyBTZW1paG9zdGluZyBjYWxsIHNlcXVlbmNlDQo+ICsuYmFsaWduCTE2DQo+ICsJ
c2xsaQl6ZXJvLCB6ZXJvLCAweDFmDQo+ICsJZWJyZWFrDQo+ICsJc3JhaQl6ZXJvLCB6ZXJvLCAw
eDcNCj4gKwlqCS4NCj4gKw0KPiArCS5kYXRhDQo+ICsJLmJhbGlnbgkxNg0KPiArc2VtaWFyZ3M6
DQo+ICsJLnNwYWNlCTE2DQo=

