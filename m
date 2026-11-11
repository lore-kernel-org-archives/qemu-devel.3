Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49280606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=p5Ib+8RO;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=lKDpp1Bo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRHlK-0003bO-Sw; Wed, 11 Nov 2026 18:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xRHl7-0003XI-Nb; Wed, 11 Nov 2026 18:29:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=76810307e=Alistair.Francis@wdc.com>)
 id 1xRHl3-0000sd-3d; Wed, 11 Nov 2026 18:29:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794439784; x=1825975784;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=7SiVByInkWiovruiZvRpPaqvp9bC1VJ/zTKgJeL3+uM=;
 b=p5Ib+8ROUD007xMXb/2DQFZw0b4Y4xmou1zbv9R8q9KSAPZZrUBEmIz0
 H5CtT22QANDKVWmj0NeEiyn9EtkUyXjFDu3A0hqLUhynIGmpGkMSSNDPS
 TaLSSBmtW9na1+Oxpr0W+Ilt4vLeO9KNC/Te4iDkQOP0G8GfP917OtoNj
 71d5G9JDwnjHHxiQKGzty4gwaNuHMPtOvN/N4Rd/+uzwC6zpU1whdyFlO
 B0gnseykJLGi50JviohiiL7GrAnvzHINnjs4fB9jkzJJC2BIfqnAAVcDu
 5tRd8bnBxLyM/2+jeDmVVkWRnyAZK4hM6EVQ+hu3v4ZVmB1SnBlrYU/1q Q==;
X-CSE-ConnectionGUID: jpfyNBuaSdee67mxl35Uxg==
X-CSE-MsgGUID: SewPLcQiRe+yRtrvLl1aZQ==
X-IronPort-AV: E=Sophos;i="6.27,208,1786982400"; d="scan'208";a="161649974"
Received: from mail-southcentralusazon11012069.outbound.protection.outlook.com
 (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.195.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 12 Nov 2026 07:29:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aao3C54muy9mpO67sfxHiNtqBPGEjhNb8o7c3aj/PD3sol9wUL8R2YBJ0gpOSgEkrVMJ0gjORALi79oR1ELNNW1qmjSRWc3/I8QB9BuPV+CWtEuTtdDBl4rTcULTEv2kg808cV5EvjFsOIIRl1IT2T4N75hjdsgtAU0K5KJrltv42rjAHxE33us2KiNwnmPAqs7a+OSXXrreb5kslT3rAxNMHTdYiejJb1C44D46Go4q4H3GMHQwwDj2Z4bXLubl8e0vdGI5W5Ymw7dgTAqagA6rBH5hFO9hlW44KyAw6x/RHlqC81rVZf/G721bnRXIEsuQi7VJiYJQwxlX6njEyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SiVByInkWiovruiZvRpPaqvp9bC1VJ/zTKgJeL3+uM=;
 b=xk9ay1VjVuQn2Y0aHGfPDlrpzLoidhSAPo5TflRIer47FyFYCsV3a9LDp/V8YpCixGappS2JxSvagBkurJup37feHAHI+YJZQV/44EfBjfVUdYpQ7RjKKS1DWAvgrotO50BqLtjkHkn/bcod2eB5Ns3i0L1F/ryFiS+iRj9ktRDUKX196SxqbEHDNW0P0dVHIeVSwN2GRJUWbUQsWVy+isI7GZ9bdzsMaZ5P7feZWV4p596vHTJb+Y2ukHCg5SoMXYsOBMcHUxZ/U77ds2rkW++TAhJEOFf6JIHGi3/199rHH4FFW5Niryf6NHnKhZcdAU4YMJHPH01Mkfj/4zIF5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SiVByInkWiovruiZvRpPaqvp9bC1VJ/zTKgJeL3+uM=;
 b=lKDpp1BoqW4VRKO3GWHAOtdrkJS2ddJT67lX+1yFSqbMIXJZlfWLHhJswexeyMvz3ciz7PRSqJKKcunyWVDjCTyUaMisigxHDsg85olM72Xc5egQo9aVWra5to7OwCCO1Uj01mzBo0C5YmTzmpu0INoszA6o4wkDC/1YCMTqyrY=
Received: from SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7)
 by LV1PR04MB993571.namprd04.prod.outlook.com (2603:10b6:408:3f7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 23:29:33 +0000
Received: from SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b]) by SA6PR04MB9375.namprd04.prod.outlook.com
 ([fe80::701f:f350:2a05:fd2b%5]) with mapi id 15.21.0592.010; Wed, 11 Nov 2026
 23:29:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mpe@kernel.org" <mpe@kernel.org>, "asrinivasan@oss.tenstorrent.com"
 <asrinivasan@oss.tenstorrent.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "zhao1.liu@intel.com" <zhao1.liu@intel.com>, "alex.bennee@linaro.org"
 <alex.bennee@linaro.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "joel@jms.id.au" <joel@jms.id.au>
Subject: Re: [PATCH v3 8/9] tests/functional/riscv64: Add rcpu to tt-atlantis
 tests
Thread-Topic: [PATCH v3 8/9] tests/functional/riscv64: Add rcpu to tt-atlantis
 tests
Thread-Index: AQHdaCQDHEV8hv46dkyH+x+M9bRThrcpmLoA
Date: Wed, 11 Nov 2026 23:29:32 +0000
Message-ID: <8e67e153bf2ba7b6b749a6cbd7be489b44c3fcd8.camel@wdc.com>
References: <20261030040516.853444-1-portias@oss.tenstorrent.com>
 <20261030040516.853444-9-portias@oss.tenstorrent.com>
In-Reply-To: <20261030040516.853444-9-portias@oss.tenstorrent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR04MB9375:EE_|LV1PR04MB993571:EE_
x-ms-office365-filtering-correlation-id: 529e80df-565b-4bbf-f11b-08df404ba410
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|10070799003|23010399003|376014|18002099003|22082099003|261009223027099003|4143699003|261021123027099003|11063799006|10067099003|261102123227099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|56012099006|261021121427099003|38070700021;
x-microsoft-antispam-message-info: gZ92Z6Uq+iLUerm/VlNk/FlMt84VjV5UY8r/DDlKii7MFyulLrbCsan3zTQ16EznsJ+cleTyq9ygaMTzPHprVoYDKwOLsaKQk1xAHDWqNnUD7SlQRorx4bETu6U8oIBYChQ+zYtUXeYUrL4XWU/2uJvLn+FhuZ1Epmtf3icNk9kV7Zehjmx7XFFJQEJ/byGxvN5qaUTFumwFw5FRNWv5cviH5rvYmUZ67D0PL+M2xejAJHvM1qP/+hW3/V2P0erSrZ6Qq/rsgHz+CVPFMVKRJz6CuHFORrhce4Q2Ifvs7UBtj/0n1mxbEdvsVtfANeCEZ+eAlJ72GzBCeE/VaQy/5Eayp+kzUslg40H/x/FsNp1fZLNY9lDkycdqAuSlCG3/T+vW+3yHvsTrOXXG8jd1feeJfgguOHKS7pc17USTSRuZkpyhV5yq2Pu9TBzCV7wCWY+uZNFzp9DvQjXQ96j+S1Ww8He4gliDTuxxtzeWVzuz4lXPhpxZQDwCAJGkPuH2y+rZxz6/1ZWcWktp7prmTcvYskijZZhWgvu1WkfQvwqlFCXyw2ufa+I3UabmqOND3D08sqnDegEc77LM0G0z5hCayuTZGCjfQN8kWdnJQeSLDr2kqDPXOb8JBN7qc6fjFtNrziJYA2ghXG5CoTIJEaBas9oBDuLDYY0OQwY31lIjI4wAxp64uyAuwd2gDH/PGV49nd6VbPDmm0mURx1HirGgGSIpCkwX1Bc7T93xDsQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9375.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(261009223027099003)(4143699003)(261021123027099003)(11063799006)(10067099003)(261102123227099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(56012099006)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWVRa2kwVk1tZEhQbm1XYytIYk94NFh1YjYycS90RFB5Mk9LWlBxc3VFZGRV?=
 =?utf-8?B?MVZ6ZjUzYUtPTU1qSnpxcFBXNjdFQm1HaURQTk1aOVZoaUo2RSt6RWxadGdr?=
 =?utf-8?B?dkErblhUQnV0VW1vT09QN2tGT1pFQ1lrWFdCNEp3bC9WcGtNdGlrV0FJOHBD?=
 =?utf-8?B?ZGl5MXpxSTViYnJPK3R4T0tzak9DNkRoQnVVR0hGUUoybXorNUtxS0RNYjNl?=
 =?utf-8?B?Zk1IL2xrZTF6UXROeU9wQ3Bja21XSzJLZ3FMR08vTFhFaGd4dGJIL09EOGdR?=
 =?utf-8?B?T1R3TGN2WFAzSGlMd29RR3pvUVZjcStwSHVYWjZ5UmNyc3RaRmxWZDlhZEt0?=
 =?utf-8?B?WnlGaFl2RWtCaGJPbFl5OFFRSjR3Wk5qdVFQTi9TZmJJd3VnbW5FOHpoUFVW?=
 =?utf-8?B?OGMweWltakc5Ti9yQ2ErR2d0NGRNMTRHK1FXU3FWRGVQYUlnY2x4NkFpbjNq?=
 =?utf-8?B?QUlmOTFjazI2c0hueEZ3cytIYVg0OTQzY3d2LytJNFc4N21CS2gxcHdvcEls?=
 =?utf-8?B?NnpGcG5KMmlNOFVmZVB3UmtmbG1RTjhLSFR5aCsreHhXWkFWalU3aEZGeC9l?=
 =?utf-8?B?cTZuVTE0ZTNmRWxhcEdlYThFT2xQV2ZXL3B5OThNdGY0Q3dDVGhaWGswb0lC?=
 =?utf-8?B?WEk0UnFuaEVub1RzeVdTREdFZndCa3FCVTlLcmdyWng4TXJ0L29EQzFncldx?=
 =?utf-8?B?allDRlhMOExOdXN5MXdldm1FbERXMlp1VSsyak14VWlWVWlYTWVWMmNSbHB0?=
 =?utf-8?B?cmRub1grL3RwMCtjWDVwLysyKy9yMWdYYXU5bnplanNxQTNPbDV3cU1Vc2wv?=
 =?utf-8?B?YVpySlZFZVkrUnRHdGM3UmVQTlNFWmZIRVFsMktMMWdSSHlhTnExOVM1UW8z?=
 =?utf-8?B?czlPK3JFbVNMZzJwdmdDWG82VjVLMmtzNklHZUVCRHpkcjF5OVZPUnFnalhR?=
 =?utf-8?B?SXY1aGhtNmNuOXJIU1ZTektCeEFLSkVwUy9IeFJjUG5TSW9BdENEODdobUtN?=
 =?utf-8?B?TnhzTG4yN091VXh6bXlCN3JyQjBQS2RuSlA4cUtWdWkrRWtMUy9QMFE0eDFj?=
 =?utf-8?B?MnM4cHRjRTM0SHpKS2JMTTQrZFJuazV1SkJOU1M4NWNJU1pVbEZmYXZqRG95?=
 =?utf-8?B?VDFmeGFnNDFJTlRYelcrcE55MTJlRW1GYjUvTnl5eXdtQXU1VEZRQThFbnAy?=
 =?utf-8?B?RFB0Qk1DT0wvWVgyYmhmb2RGSFFFWXRIeEh3dDZSbTlZYmdDeHdqdzRERlVZ?=
 =?utf-8?B?dTY2YkxVZE1xcDFJWXg4empCb0FzMlIvSzZHYVNIWWp2cmU3eWNQNEMyeDhE?=
 =?utf-8?B?L0VtZTR3Ykh4cnhhTk1sNlpsS0FRUXgvNHdhWmM4WncxUURVSUhWb2VSWmtD?=
 =?utf-8?B?T0JHelJBV2hoZVpYWDcycytmN1N5RXRTV3JVZ0E2SjRhSzFYZHhZT085MTY0?=
 =?utf-8?B?bHRVMDB2Zy9lc2VuUFMybXdDNnFIOWVwQTVRUzg5SVVRdi9pRGxiV2lGbkZp?=
 =?utf-8?B?cXZLNEdYZDloUVE1bEs3d21mRlJEVjdDQXZVZ3FZYW5FQnFOS1pqdzdsVUpn?=
 =?utf-8?B?aDNkTng1bEN2L2djaE1zTHlYMUpOQTZVSWZZWllyaFhldDlVNDZkcG1uelFE?=
 =?utf-8?B?OGdQR3RmTWVwaEl4UUNnYy9PRmhscXQxM3dtRnN3cWx3VmtGMHpDTC91cGpY?=
 =?utf-8?B?VjNrSll3bVN6bzJwTHhUc2ZhMUFMN2RiQXZHVDk5ZXRCbzB0RVhlaDU3blB3?=
 =?utf-8?B?MUgzZ0N5cTVXV2NhSEFLSU5OZE5iVGVnamhqaW9xWTloNHVmZ2VPQnRmbnlE?=
 =?utf-8?B?akxTV1FvbmpnMkVRak1HTitIMHRtUGZaYzloYXh3anB5Ymhvem1hOFBjVncv?=
 =?utf-8?B?ZFJ2dzVpdnltc1FkYlV4azJCUmhvWkp5NDZiV3lCeG9NZFpnemJseEJFb1hh?=
 =?utf-8?B?aWZIMllFVndGU3p5NTdvT09xSFNTVTR6b0JvQjkzd2NDSStjWE12QWVKSFZM?=
 =?utf-8?B?cmpjU1M2N0VSSVJLN29Ld3Y1ZTFYc0Z0ZjdEaEpxaTh1T1VWR1grd29xelFk?=
 =?utf-8?B?NWgwTDVCUkdBNUtNZzNTR2Nxc1BXdFB3U1B6amF3bERSRTFXU2RrRk9uNno1?=
 =?utf-8?B?cnA2SHlTVFhpRmNMWFdrYjRCbXZScG5ETm14UjQva2tuVEcxbVdaNEZnclIx?=
 =?utf-8?B?OXpabExvZE9jbnRNempsN0RsSjFua0VwajJDdUZiSXBmOWRrd2U4Zm0xOGY4?=
 =?utf-8?B?elBEL2dVYXJISzhlYzg1c3RpMC81QXo3L2praVhWem9QOFZSMUxQdUhSKzJo?=
 =?utf-8?B?L1Z1eFlyb0hWbndsUTJhSFdqaVJrbVhSQ2dlYzBKOG50MDRWbC9sTnVEV2Jo?=
 =?utf-8?Q?GLGlnopc9Fb0evXlrVoA5mOzXgxB/mCPPEyUTFLVB4Mrb?=
x-ms-exchange-antispam-messagedata-1: Muy9yzLighfHEheopZXbDNvsQudN+4N9bJ8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD59C887EF36324E8EB5D286932D7396@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZEgkMliZvLx9koe8SoDOdZToYl1ethYQrC2ijCyrStjEzlF6pYARwGWQlebQVlZpHNNciOFJy7iRnbUuANmlMt+qHc0TA88XTn+g6atm9WicdVo+JZWHGKhuO3B7neN4Zpt/DY+o9dCJZUlhKjOFXD64Paf/tSV3tUnx21//8QA+SiMW07wtsHWSgo+OsOQyarhz6vsHohC2cQRudhZJEzH8Oiom7nNUtO9O1pB2A4AGKL3xcsJ7tBpUUJrklPuuatQ895zTnkYM4FHreYhx0BhU+YBLAkNk1HRjMdcI9mLNlSlufq6xPGqDg/aw8hjCd5tkn/G4jI8V1F+EmvT7dg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wh4dX6RoZ7eNDk0mbANY7LVarLmSCRRiYNMk3w7LY5ar/O8ivbKZPrEXiEh3oDwflhrHxva+uuNvkrDQYMilYuuRyQnFx598D2yVsOVKhsz4i1BLquJHRh/jUfBLxdMHooMhz0bpWTQeTJknxWDEFYKH0+7/Qd5nvSqRPY3q6Ffj3Z1Skm1Re9cEn+5TPT0iWeRI4fYTHG49iAr3/r2UYx9npsadug+wL3jRzeB2dntDD6fVD1NqG0GHmHyCV5p0pVfgm7Ecqcd8gI28lR84lqjGP14ll+UJuNT+gCvkfr66I2MSW/UZRVAiC+0jPI9pi4U3Rtdh1VvoLHdBEYlkK7+cM/guSNHsvws4FXCpWHouJ7RoUJDkAVsoL0iPqOrpnJBi1dDErboIs4jXl7tL4R6n3xKhhU9MUVSo3XB22lqutwOv6rkuqbYYzZE/wDxaN+7ETOZLdb3FV4AYoC3kepBw6mNhPOPMsKUCLXjFyyeQhtJIBoky1XyszZC5dmDoxVCQrguMS70sqrqC8YI8PXIy4oZhvMCnoGjlenaQRQWTeVYfsWibnb/Vp8wFS9T/8M8HPNKTp4hmtljmVZLbC62TxZu4EHJz/Y+ozocPhKQkHEMz2wVPl7fi72zBikbx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9375.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 529e80df-565b-4bbf-f11b-08df404ba410
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 23:29:32.8997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkEkWYfUdBmQsmwN4VFJS8ZWeLktjgLeY2kC4up/elQliF3OfgWJlXqQ5cwXiAPCjvnQGzgCJSsyJLv9JpA1bmOwypbzpEXRL3RpUpZHLHM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR04MB993571
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=76810307e=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
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

T24gRnJpLCAyMDI2LTEwLTMwIGF0IDE0OjA1ICsxMDAwLCBQb3J0aWEgU3RlcGhlbnMgd3JvdGU6
DQo+IFRoaXMgdXBkYXRlcyB0aGUgdHRfYXRsYW50aXMgdGVzdCB0byB0ZXN0IEFzY2Fsb24gYm9v
dCB3aXRoIHRoZSByY3B1DQo+IGVuYWJsZWQgYW5kIGRpc2FibGVkLiBUaGVyZSBpcyBjdXJyZW50
bHkgbm8gY29kZSBleGVjdXRpbmcgb24gdGhlDQo+IHJjcHUNCj4gYnV0IHRoaXMgdGVzdHMgdGhh
dCB0aGUgcmNwdSBtb2RlbCBkb2VzIG5vdCBicmVhayBBc2NhbG9uIGJvb3QuDQoNCkNhbiB3ZSB0
ZXN0IHRoZSBhY3R1YWwgUkNQVSBhcyB3ZWxsDQoNCkFsaXN0YWlyDQoNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBvcnRpYSBTdGVwaGVucyA8cG9ydGlhc0Bvc3MudGVuc3RvcnJlbnQuY29tPg0KPiAt
LS0NCj4gwqB0ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF90dF9hdGxhbnRpcy5weSB8IDEw
ICsrKysrKysrLS0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0
X3R0X2F0bGFudGlzLnB5DQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfdHRfYXRs
YW50aXMucHkNCj4gaW5kZXggNDhhYmQ1Y2QyNy4uOTQwZGRmZDg5NSAxMDA3NTUNCj4gLS0tIGEv
dGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfdHRfYXRsYW50aXMucHkNCj4gKysrIGIvdGVz
dHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfdHRfYXRsYW50aXMucHkNCj4gQEAgLTIyLDggKzIy
LDEwIEBAIGNsYXNzIFRUQXRsYW50aXMoTGludXhLZXJuZWxUZXN0KToNCj4gwqDCoMKgwqDCoMKg
wqDCoMKgICdyb290ZnMuZXh0Mi5neicpLA0KPiDCoMKgwqDCoMKgwqDCoMKgDQo+ICdiNmVkOTU2
MTAzMTBiNzk1NmY5YmYyMGM0YzljMGMwNWZlYTY0NzkwMGRmNDQxZGE5ZGZlNzY3ZDI0ZThiMjhi
JykNCj4gwqANCj4gLcKgwqDCoCBkZWYgZG9fdGVzdF9yaXNjdjY0X3R0X2F0bGFudGlzKHNlbGYs
IGNvbm5lY3RfZGlzayk6DQo+ICvCoMKgwqAgZGVmIGRvX3Rlc3RfcmlzY3Y2NF90dF9hdGxhbnRp
cyhzZWxmLCBjb25uZWN0X2Rpc2ssIHJjcHUpOg0KPiDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuc2V0
X21hY2hpbmUoJ3R0LWF0bGFudGlzJykNCj4gK8KgwqDCoMKgwqDCoMKgIGlmIG5vdCByY3B1Og0K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLm1hY2hpbmUgKz0gJyxyY3B1PW9mZicNCj4g
wqDCoMKgwqDCoMKgwqDCoCBrZXJuZWxfcGF0aCA9IHNlbGYuQVNTRVRfS0VSTkVMLmZldGNoKCkN
Cj4gwqDCoMKgwqDCoMKgwqDCoCByb290ZnNfcGF0aCA9IHNlbGYudW5jb21wcmVzcyhzZWxmLkFT
U0VUX1JPT1RGUykNCj4gwqANCj4gQEAgLTQ4LDkgKzUwLDEzIEBAIGRlZiBkb190ZXN0X3Jpc2N2
NjRfdHRfYXRsYW50aXMoc2VsZiwNCj4gY29ubmVjdF9kaXNrKToNCj4gwqDCoMKgwqDCoMKgwqDC
oCBzZWxmLnZtLmxhdW5jaCgpDQo+IMKgwqDCoMKgwqDCoMKgwqAgc2VsZi53YWl0X2Zvcl9jb25z
b2xlX3BhdHRlcm4ocGF0dGVybikNCj4gwqANCj4gK8KgwqDCoCBkZWYgdGVzdF9yaXNjdjY0X3R0
X2F0bGFudGlzX3JjcHUoc2VsZik6DQo+ICvCoMKgwqDCoMKgwqDCoCAjIHRlc3Qgd2l0aCB0aGUg
cmNwdSBlbmFibGVkDQo+ICvCoMKgwqDCoMKgwqDCoCBzZWxmLmRvX3Rlc3RfcmlzY3Y2NF90dF9h
dGxhbnRpcyhGYWxzZSwgVHJ1ZSkNCj4gKw0KPiDCoMKgwqDCoCBkZWYgdGVzdF9yaXNjdjY0X3R0
X2F0bGFudGlzKHNlbGYpOg0KPiDCoMKgwqDCoMKgwqDCoMKgICMgdHQtYXRsYW50aXMgbWFjaGlu
ZSBoYXMgbm8gUENJIGhvc3QgeWV0LCBzbyBubyBkaXNrDQo+IC3CoMKgwqDCoMKgwqDCoCBzZWxm
LmRvX3Rlc3RfcmlzY3Y2NF90dF9hdGxhbnRpcyhGYWxzZSkNCj4gK8KgwqDCoMKgwqDCoMKgIHNl
bGYuZG9fdGVzdF9yaXNjdjY0X3R0X2F0bGFudGlzKEZhbHNlLCBGYWxzZSkNCj4gwqANCj4gwqAN
Cj4gwqBpZiBfX25hbWVfXyA9PSAnX19tYWluX18nOg0K

