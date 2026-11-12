Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C572606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 00:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=jfJ7rIgE;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=H+lWzflN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRIHB-00080n-GW; Wed, 11 Nov 2026 19:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRIHA-00080W-N4; Wed, 11 Nov 2026 19:02:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=769f446c1=Alistair.Francis@wdc.com>)
 id 1xRIH8-0004a6-Js; Wed, 11 Nov 2026 19:02:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794441766; x=1825977766;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=EDs3P4UTQUNqzeBeV74H62OWIcQTAqkwsJLH0+pKZUQ=;
 b=jfJ7rIgE0wuwCuDnPJ41FZN6rBdhEj9MGHdehB8svuOJrOgRpYC6FT2G
 qgpvkVNYlS8i8CbuWPsBlXZl9Nr9EjsyZZ3jKAtvQldHlH1CwB0LYfaNb
 qfxlkxbBP6AqfdNHrZ8vYgrpAPFRxKXE9BC2W0C4d55AuRzQTjuZsh/pM
 cAlL/IVEAuVZ5YWOsPMlemXPxiP2IvmRJXCqh6/vqzcEBSDKN/BNu/jRa
 6t8IAqLi7XLuDGrhq7UBdkv4Yp9mJOHZqGjcY9RNhzBKqsGgpyDdBEbA0
 dxRnE0fjZq3Z+LXUTvUwIoGzZ8wxtEPheDOSPdGOf/74WFp+FjLObrQtG g==;
X-CSE-ConnectionGUID: usk/8+F1RESNxA+Tw8A3XQ==
X-CSE-MsgGUID: L6ij8JzwSaqT4CN14UFUwg==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; d="scan'208";a="159711684"
Received: from mail-southcentralusazon11012003.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.3])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 08:02:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plJmxCrwce6crRurYtPzbM7BoApgVnLdJX0Djayg+Eb403z+4rMCFHHU3aKCh4eTSeyDyzRkqau4CggBVq9kLW3Sk/NKqiLjtpfeL5P6AEYrEH/DmPFhptSRRIMTVzPepAdfAkd0iLmtY4qvMvH0K/pelqVlKsnH6hhG2ImWrpaoiIiirgI66eQzYlpF3jjPSoQfpYixplkBqodFpyT5MC2MrJxUOAfDr9J+g4ause1YdUCKl1xNbyBtm5uAS3zsGxLxxYuS5PRXEz1h4qYZlpMYqoqlDllq4D5VJoICeBCh8hAo8uMpFYigOLF263XmyTc3tVB0+Iy62ce+/w43hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDs3P4UTQUNqzeBeV74H62OWIcQTAqkwsJLH0+pKZUQ=;
 b=Nft/OFAyvgCiOdRBKwhO8QuyXAJVeehoMLVpao/fXwK9nBCfvHurSbQDpzJjL1tMyezPLA6l3Zy0ptq4cF8k2+D3N048O2hXwgiLRU5pBtYDIbEH8mu77GkhRMOv3MZU+XGJV89y9qUye0rPR5MuLy5xbQuCItfxZIjE6k7HOW7wjmnzW6iQ1Vn3xhxnVJHYANbr6ZJ8w3HRS5DHndYNrhHWxbD2tiKUBwevAwCll+8uRd0BBMut4eMpXZawk/0QqLfVlEMmBXXUHcCrgeu/OdSFNxbFhEEEJuLWE7rIP0Fcfr2vJyFVn7s5KPGONfDEe0o7AHRfeHSuIqpBv7tGPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDs3P4UTQUNqzeBeV74H62OWIcQTAqkwsJLH0+pKZUQ=;
 b=H+lWzflNJcetY08bEo5/cJU4HWt52+3KgThzon5ssN2okPvo/vB3B5KzyL1BatZP2vlzy9d6kzUTFUyFFHDy/j5l3LUHa6vsHcbiY6ykT7PhU87DXBi6LWl4ZzaFBfInecsDAk3RfdwLCOdaivWNiu2a4Opwhcg9uO1YSkWMlZ8=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by SJ0PR04MB7455.namprd04.prod.outlook.com (2603:10b6:a03:293::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 00:02:40 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 00:02:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "sunilvl@oss.qualcomm.com"
 <sunilvl@oss.qualcomm.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH for-11.2] hw/riscv/server_platform_ref: Fix mtimer
 frequency
Thread-Topic: [PATCH for-11.2] hw/riscv/server_platform_ref: Fix mtimer
 frequency
Thread-Index: AQHdccWz9iX+3qVpGEG98r2zJoPdf7cpjreA
Date: Thu, 12 Nov 2026 00:02:40 +0000
Message-ID: <5e6445457f7ee138a90a510a2f8322c6ba4cfc23.camel@wdc.com>
References: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
In-Reply-To: <20261111101609.1183263-1-sunilvl@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|SJ0PR04MB7455:EE_
x-ms-office365-filtering-correlation-id: e47c6692-cd46-4688-4682-08df40504489
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|19092799006|38070700021|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261028144727099003|261026140227099003|261102123227099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info: a/cCXGW4fjaIQCXuk/U72EiFbo+BMfSBNwjKS3lxTJ/v7y8k3fNw2Bwe1qfwlM6fiaillt3d5I5sWW0sERc8m+yiJ6l1toa/aVPMwoLj6Q4JGrhKJsONSa/+JilSB53kCl8l7UQXTxIX44l/bLu192qcFH/DuIo5JX8A4hSSCvmcrnhXiH/ZriQu5MWmIVJeeB/62OQ7RAUv7LTmQm73zVyI8VGM5HhKPmVdlqcsdDu5ZHLuWbFtKqN1ArZcZ1vnsxFTu9Kmz/JdRz7Dqch53d6WxQd5nt0JZGxI/D2S77wZk7/PE5ffNtQYKeAWgoERICm27Ez86LzyqOQloRXy8r7QuGcCueWq+6wp7euplO7VLNiDuVPdalx62UfYqtbgsjkBzjvpqgFvDJGj7Y/S78W1WrRWYb41UiMfhK0r3W05v9xsrWhutbuiQY+Vksk4l5+jqGNgDkGKkPYblWrH3acNilHN+JsQveMX74QOYFnnNrTdJb4oYZU9tA9U+CrjpLaXy26BIqopWOlfeR0O72JqJfr+Hhmc4YBtffLTDXcC92bA8DAhM32QzlEJ0sBvP+UhfrWb8qnjw9rh1uQcCzOyCJqyH9ve32Drk/4U+Ym5FiTjXuEDG7ZLraBfOpTDJfAnm4vH6fV+5vc/MVQhuSPwyTrTcHn4p4LEdIgbWHhrnpCpQrPWwXHtl3sJlZ9Udsd5ipyaTDXz96aTmdxVsW7gZs14W1q0VCoi8YG1tng=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(19092799006)(38070700021)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlVVR1gvQlJUMnIzWmJhZ0QwcHFPSmx3OVhVTGJWUkJOY0I2SUk3VEppK1Vn?=
 =?utf-8?B?NlcxZEgwZ3g0dGV1cmx4VmJkU0pieFlhLzU5OW9xdC9nMmxwYjR5ZXNhUUhI?=
 =?utf-8?B?ZGh0QlpuNmIvSUxFZVNVV0ZDeklzV0NNZ3JGVmRkRitCWS9nY21wR2Q3TVFI?=
 =?utf-8?B?VnhNY0xvMGhMajRCb3pqMmNvNzkxYlBWdGRmNWlmdU92d3dSc0w3ODBOZ2t4?=
 =?utf-8?B?c3ZPb1IxRlg4cjRPVHdmdkZ4b1FPL1haUE1XRDRWbUdxN3RHLzlqVm9teEd3?=
 =?utf-8?B?Q0QzcTUxVmw3c0tGNjV6UDNXTzNLQkROUGZmNDhNRENRdTZzL2thYjJMbXhn?=
 =?utf-8?B?TTlTTjdHaHYrNGZlM1VZNUxMVXh2NjFZN0tzVFhZOVhuN1k0UnE5emIvLzVa?=
 =?utf-8?B?WDBocFRoWkdud3FsQVJIOFJhTzFBQkRQa0FsNFVXcWkvV0Z6SVo0KzhJSWpV?=
 =?utf-8?B?dVdONWpmQ0pVeC9hbExFSGd4ZVdkVHVXdzdtbm11T1doMEY3amNMcVBtblly?=
 =?utf-8?B?aWIwZWtDdUEwcDJnaHp2WWZaRXk0ZE02UlhkS05IWWVKZEp2dWp0V0xvMmpa?=
 =?utf-8?B?dUpRWW80Y2psdjN5T0pBcXkzV0ZqNk1sUTdBUmRhNnp3VVBFRFBrMmlZWFM5?=
 =?utf-8?B?T2xTWmRrRHNzT2xKSkwvZisyTGVyK1VsbGpmaXFSRG80ZmUwRFpUZFY3RTB5?=
 =?utf-8?B?QzB4ZW51OVk0NG1HUU94anRMZDdpSGxDOEFsczRtdFJzcmtYMnAxVW5uaEFX?=
 =?utf-8?B?M1RQd1NnZWZyYmxTVUZOMkV3Q2VNN2N5V3g0Z3dSYmRTZDlLZk1PKzhQSkNC?=
 =?utf-8?B?a0ttaWp3WVpnTDJFSXQ2R2pUbzFWTG1Ed0FDWTBmandLcm1WMkJxQ2M5ekkx?=
 =?utf-8?B?aENZZ2VpMHcvNWRTUEt4eUhlWlJIQ1lPZ3hCZE1CbUFXRXNKMHBJSVdGWVhw?=
 =?utf-8?B?TWFsWjJPUWVZeWx5VkdiV21oekJsdGVRSGw2VFR5YmJheitzSGdXeGNSWTVT?=
 =?utf-8?B?U0tLWmJKS0NqczFnNGRsc2NBaU15MjJjM0QwS05nemt0ZG5DWTFweVBoMkZ5?=
 =?utf-8?B?b2d5RVRNUEdoU0Z6S1lWUGEwWmVoTFlVaXUyMDMyQllRcW43bEpWeEY1UnNZ?=
 =?utf-8?B?NkNpNld2K3J6U0NBQzZuMjVhVm0zNHI1NFR1VElXL1FtMlJlYklXMHJNQ253?=
 =?utf-8?B?OEg1SU9GalJqZXA2QTBzeEp1QUZ6SVJ3RFhmQlhZL1NJY2xsRmRscFRLVUlC?=
 =?utf-8?B?VXJMbUk2Y3pnYWFZcHpFK0hDVGF2cmd3Q1M5bmpOM0RhQ3E1bVBMVEpzVUhV?=
 =?utf-8?B?OFJmT1Vkdk1qcHpqMWdPTG1iZTRaaStKbnU3RGtlVWpQUTBZdFpwV2hLTW5p?=
 =?utf-8?B?RGlERC96K3VkaTlFemZZeGhibit1NDhGZ1FoaHpBb0xxbExjSWd1ZTY5QXJu?=
 =?utf-8?B?Wm1XWFFvNSsvNzFoNldjV2QyZEY1OGRnN2hxcWxteXU3R3N1eExjN1RmbEZu?=
 =?utf-8?B?Ry9FT0hZcFpMbDNBWGluaHYwRVp4RENVZ2gwbGtmQWVoUUxjUERhbTROR0FJ?=
 =?utf-8?B?dDB4TGFEV29BelZWZzVuQnNGYnRTZ21LeU5JWXUvblF6TDg3Z1NvZ0Mwc3V1?=
 =?utf-8?B?M25xUVhqZWlIUXdIM0ZEMzVacTUzUFpqTXMxVU4vRHhjaysraGlRelAvUWlr?=
 =?utf-8?B?ck9xdWlKVWhBY2tyMDZVaXRBYXFQK3BOT0xnTHllbnF6b2Q3ekRPbi9DOHJi?=
 =?utf-8?B?SlEvbWI5dkRKTHV1aHFmMDVjRmU1cWRvQVJSWDNETllXRTBEZEVYclBwd0hw?=
 =?utf-8?B?bVA0NTFCb1JSb1FlVFY5RCswc2lyQk85SDkxa1c3VFF6Qk5reXpmdWQ3anFj?=
 =?utf-8?B?aVlCWWJlS1A2KzFuWm9oRmRvWldJdXd0MkxVZ29CSU4rUTJjejNBVkkvZGxT?=
 =?utf-8?B?T2RHSFoyWW9udEFJaWsyMUtDRHNMY3ByeDErUjdtaEVPOC8zMjdQdFZZS3pB?=
 =?utf-8?B?c0kvcWFmMElsWmhMa0NiblcyMDBJVmZjRWpDRUZpbmFmTHZabTcwK29NS1Fm?=
 =?utf-8?B?OEI4OFFzRWJzT3d3RkFFUWxlTTdkVndDdEttSGQ0US9HTWtOa1pBc0cyTk1T?=
 =?utf-8?B?cG1Sa0dCanNVOTgyNW80ekd4aFRpL093Z1pUUjEyd2xkWFlJWkNyUmJxYmly?=
 =?utf-8?B?czBvcW4xeVNiK011Wkw2TzdFYkY3QVpKbkpWVUtSTitiZEQycE5McVl2ZjJs?=
 =?utf-8?B?dDNFQzd4VDJLamZmblIvdDMxaGwxTGowRlBQWWFZMkZNbVpFT2x3Q2FSdkhP?=
 =?utf-8?B?bkR5VXJ3dG1NTzZVbkRjSUl6KytoQlVBYkFRRkx1dWkzUlYxdHcwVnJDTndD?=
 =?utf-8?Q?qmAakhBKJ15OWU5nesJUIBuxfHThmS0GO9gTCUhM5AtEF?=
x-ms-exchange-antispam-messagedata-1: St8G1aGNITfbV0/K4cdepHlekEOWLUn4FLQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C956D20C33F6E489CA466CF91779751@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: yJZV4RGfGJEJvUH1n9XyolQY7R5rKkbJlIH61LmvoRXvuA5lWPHhl8JABlTVLdbdYTU56KfjEvONz2sVOJaZrpvUilOCdzy1LyCvXwpWlPn+PoA4qZuSqlVEPiAUagj8IS9RcqpWEF8ltHBcBfGfqXp4/lxUNOn8RYcb9Eid2pV3gUyeDXvxx8EVIK0tb2aMiK5NIlG0efa2EOBbwlyTPGrVNZOgxLZDkds9NLoX8ptiI49ywsW5CTuJFBZ7wRdrf2l3jlTuKkpRq0epvqC2mld+0ou9gyL646MPi7ATmYAttNPvdwXcUM43AMwO/1wHdfP0Rv13k37PlRh7gy2DLg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pE70yTDvNxbqX9ydwKDNATMw90xiAgW4s+4qUxMXRfkX0WOwC4dVHmcBGpBVw5NEY3OTCZ/KaAvZDEqatXTyZsgY9K9mp9cfa+kDkvoJQxf+ihjBn3ehz0kTLFF71I6PerfBLbHcE0GG3RmYulQTKBtZX6pH4ooKBuRPmx8+OIit8x5SBW7297REWseZidm+aF/MdZt45WjaKgJIiWpCn/3pk5a/5I1jszqIbojq0Gjpi/zmhSrJZCjewJszxfjPgJioaRzUIQz+KZAQj6GWM8FFUpZCS9VXVV3T791ruzwoL1NGU92SuyVEQa3OR62rfk8Nn9y3KIfFz9mg/norvDI/hh56A89Sir6YZKKZ6Go8Bw6sRq57O5+qGYHtV6Hg9mryGWKZXic6KZ+IfEATEsslyLKBy3Nn+4aLZReVq1d3BmOLTjflNq6zmMwFpSL5T/96xFneLzTOSPI2yV30PUy8VPARKiYtpGb23RT33lrdwcgGLus0kfcXu5Cj9TCPkiptDTZohWWkFZp+hqPB9kmNwJhfHooHj1dCCaj9oo2DkeItLUp/1ra6WYS8HEQy90Yt/uC7AVGsdVTXac5fKNCFIr56lVTWF7w1aqw+0WSw77rd306DRgX3teWXdIm9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47c6692-cd46-4688-4682-08df40504489
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 00:02:40.1229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8jg6VOiESm3hgKhNGmOYAIM+8hyYxe6hHePMOWO2oHD8WG0o6qXU0pzILUTXISoOGNrUAwdHgwFJdTRlRO9GgcSrqbws/C1Wwou8wcurHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7455
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=769f446c1=Alistair.Francis@wdc.com;
 helo=esa5.hgst.iphmx.com
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

T24gV2VkLCAyMDI2LTExLTExIGF0IDE1OjQ2ICswNTMwLCBTdW5pbCBWIEwgd3JvdGU6DQo+IFRo
ZSBSSVNDLVYgc2VydmVyIHJlZmVyZW5jZSBwbGF0Zm9ybSByZXF1aXJlcyBhIDEgR0h6IHRpbWVy
DQo+IGZyZXF1ZW5jeS4NCj4gQWx0aG91Z2ggdGhlIHRpbWVyIGZyZXF1ZW5jeSBpcyBhZHZlcnRp
c2VkIGFzIDEgR0h6IGluIHRoZSBkZXZpY2UNCj4gdHJlZSwNCj4gdGhlIG10aW1lciBkZXZpY2Ug
aXMgc3RpbGwgY3JlYXRlZCB3aXRoIGEgMTAgTUh6IGZyZXF1ZW5jeS4gVGhpcw0KPiBtaXNtYXRj
aA0KPiBjYXVzZXMgdGhlIE9TIHRvIGJvb3QgdmVyeSBzbG93bHkuDQo+IA0KPiBVc2UgdGhlIGNv
cnJlY3QgMSBHSHogZnJlcXVlbmN5IHdoZW4gY3JlYXRpbmcgdGhlIG10aW1lciBkZXZpY2UuDQo+
IA0KPiBGaXhlczogYzJmYTQzMjA4MDNiICgiaHcvcmlzY3Y6IHNlcnZlciBwbGF0Zm9ybSByZWZl
cmVuY2UgbWFjaGluZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFN1bmlsIFYgTCA8c3VuaWx2bEBvc3Mu
cXVhbGNvbW0uY29tPg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8gcmlzY3YtdG8tYXBwbHkubmV4
dA0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYu
YyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMNCj4g
Yi9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMNCj4gaW5kZXggNWY0ODViMWM3OWNiLi5m
ZWM5NjdmNzA4YzIgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYu
Yw0KPiArKysgYi9ody9yaXNjdi9zZXJ2ZXJfcGxhdGZvcm1fcmVmLmMNCj4gQEAgLTU1Niw3ICs1
NTYsNyBAQCBzdGF0aWMgdm9pZA0KPiBydnNlcnZlcl9yZWZfbWFjaGluZV9pbml0KE1hY2hpbmVT
dGF0ZSAqbWFjaGluZSkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmFzZV9o
YXJ0aWQsIGhhcnRfY291bnQsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJJ
U0NWX0FDTElOVF9ERUZBVUxUX01USU1FQ01QLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBSSVNDVl9BQ0xJTlRfREVGQVVMVF9NVElNRSwNCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBSSVNDVl9BQ0xJTlRfREVGQVVMVF9USU1FQkFTRV9GUkVRLCB0cnVlKTsN
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSVlNFUlZFUl9BQ0xJTlRfVElNRUJB
U0VfRlJFUSwgdHJ1ZSk7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqAgLyogUGVyLXNvY2tldCBp
bnRlcnJ1cHQgY29udHJvbGxlciAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgIHMtPmlycWNoaXBbaV0g
PSByaXNjdl9jcmVhdGVfYWlhKHN5c3RlbV9tZW1vcnksIHRydWUsIHMtDQo+ID5haWFfZ3Vlc3Rz
LA0K

