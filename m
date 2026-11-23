Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680EB606A327
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=bxCw5QsV;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=NLqfV3AC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKkl-0004OV-RD; Sun, 22 Nov 2026 22:30:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKkc-0004N2-AN; Sun, 22 Nov 2026 22:29:56 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKka-0005Ig-7t; Sun, 22 Nov 2026 22:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795404600; x=1826940600;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QbwviJj2CMyCQpuH1p1+RRUkg19PnnIBYRMeXPSOuzc=;
 b=bxCw5QsVV4FLbJn6u2g92S1t0iEzemWmjf+civ+C+8+MIaa9l5fEFjhC
 5oaQKu23CcPPI7Bd3HpC/ISmFCFBU2NjDRGAXWdyTRgY7gq9OLjiJtddu
 LtNGPqNxTXbGUd8OLmQhjzUzbxtDF7fIPdERr9GdzBjj1SBI7L8jWzPxL
 Zhj1/OHhtgCl8y6ejZBXin4VRtNg/Vb3j91I76lds860GfK3FeYtp9cHZ
 CjLw1Zm+5U4vj1cCGkyWRh9pmDS/+ibCmH6NS2Uhf7RnCFHgpkrIP8yXf
 UIuPH2dzMd7TBm8N9XSE/AwpocP1MAN0tA+GtItnM0lHYRwctWL6JBfs1 w==;
X-CSE-ConnectionGUID: vMI6rOqJSbilKFx/XBQ59w==
X-CSE-MsgGUID: sdUJA4d8TROe10In5ZS/lQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="157283758"
Received: from mail-southcentralusazon11013070.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.70])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 11:29:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIGxxWSUZvRAwnrkgq0PwWuazRGvSmudOPWKvW5OgCXQNUDrWySeAK94qZKSXKMTtaBIfFcY7c38UTCXtq5vVV/LYuvvmZFse94qqb6VJ9ihXCoE3reZMDPVEfbMSR+pIEfkjKgj//gUiixv/PM6gkSzk+jLzcelV20IM7t9Aj//T53wLPADHvlmrieEDOVR6mFvwhOq0HG5EzMrY14SwSmYgX+l0n8EZ/9um8vxY8QbRI1AC7LlGrkeC6KZjhq1Q6vOQlDMVSh6Ni35rDKwCCWkrNhLecU8q7Ad9lC5Bg96YblKdfiLI9GzHJfpmjmmUG0UNqWmW8mIdnHDyJznoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QbwviJj2CMyCQpuH1p1+RRUkg19PnnIBYRMeXPSOuzc=;
 b=uPCinnIOdkGzq8orWxDhOFmOoe9G4dM7sBqUIiiWWIU9PpLVdZeWzZwzZzIzJaw9L2zbK/5aFJnmvSGTpp35erDKeivgir8lehNly6b5NaW05YPiskFAFVptmd4QB9QULoVFsz+0vIezvlr+eM7P4uBwowp0bfPrFmdjWT+AztGfawp2BzuR0LKg0EAPka8EWssk/Et9zGNecNRjpAVwzO0AH0apdIo4Gw+sYPz161xeR++4mEk+gXqRZfEg6o1tPS3OSIFCx6gtoJH5pNHUxrjKNxixMEI1vJQHGv3s+2r0oceoA9M2KG178y2iHMrxL71sOT/ZeN02CzJRpBF0MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbwviJj2CMyCQpuH1p1+RRUkg19PnnIBYRMeXPSOuzc=;
 b=NLqfV3AC14AnrJNbnqz0jhlJqsP7EMIT68y/DxBgOJiDR87cSSzhtiywDYiXoRiZnFc2mPy1fFFR/3sWkFPnSyW9ZYCUCz2DVt4c4kwkS+rbb5Ycm1+/RUPEaW89UCrgsqLXN5tJW3+9GzAkoTVb+M6LDOZdgWG9EwiTLLzsOQo=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9453.namprd04.prod.outlook.com (2603:10b6:208:4f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 03:29:48 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 03:29:48 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qinzhengxiang@foxmail.com" <qinzhengxiang@foxmail.com>,
 "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>
Subject: Re: [PATCH v4 2/2] target/riscv: raise access fault for Zicbom
 MMIO-like accesses
Thread-Topic: [PATCH v4 2/2] target/riscv: raise access fault for Zicbom
 MMIO-like accesses
Thread-Index: AQHdcVm7Fk/joSuGh0SqJ22h+y43W7c7ExOA
Date: Mon, 23 Nov 2026 03:29:48 +0000
Message-ID: <78bd07a0dbb54c3c401c74b58e9178cab0bd186a.camel@wdc.com>
References: <20261110212312.56809-1-daniel.barboza@oss.qualcomm.com>
 <20261110212312.56809-3-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261110212312.56809-3-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9453:EE_
x-ms-office365-filtering-correlation-id: 07c20d4b-0782-4697-883e-08df491206d1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|19092799006|10070799003|261009223027099003|18002099003|22082099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: dZPCoItGNxNM2tN4ouJsgFChgJfhk9gvVGJDtr+fZEFG50+/BQQkgl8FU5Jwy2gyu7IsU7d56BP510cRrG52FH9TjCDhEC/slC6e1Z5SZbBFAQFJegOGcb6vN4zwRG6t8Pn1s0UmJXrJlZwM7RE+HSfjr8z520MeAr2MB5H3A7jCFFLVTrQFzf2SMOiOtiwZHYJm0qre2Lt2M1lUN1N3tjICGhosRONab2uWwPsztiCGGNR6sBMJfNlsP4bumf8dYm6VBrUvI7XsWgFhfWLGKVu0sV8nrqk4q9cJJ9uZNrj2cikAMcT3+PyOqxjTG41klFMorxCHIVJUtVGid7xyf8UwVsstz3H1MubX+eS8vwoWKKlYp7kH0KwhlfEWddPI9yn+dchLHelDIJFtjEZVCRjbrfPWYwa6BHLrxN0/Pf0l1OzoKd8ejzy4fcWpyQPfWhohQFLYx2ldwsogppDNVtlKnFJshFspCV9aLasZyAhHOtPTAEhDcBgeHr64jVM+ad6NF3NIHmGHrDSG02WiWoG8DB/UAq5NgIP3BFlU5tMYjAKdoiNtGMp5ZxuukH9S9Rg1aBcK/R2A9zcffaU89FV+dBnPqxDWa3frpXsiV7MC7jvfuCSsvDOuwr8GP2SHYZD4w9+ZUokWEjVlC/m3lq7l1k2BNoyqukgempgx5VDCTBs4YwIiz/0Ej4ehgykrtmgJTA08HSZbM1pyRdrvqyAnHzjantnqjv4GT5qy0/Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(19092799006)(10070799003)(261009223027099003)(18002099003)(22082099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Si9udTdYcGF2ekJYMGpjMklrYWlBYkZpUkVmdlBmKytGeDFFSGpTRUh0a2Ru?=
 =?utf-8?B?VXNXdXB5QzhoOGNwMDgweGZJMXFCaVNrdVNSbU1CVW85TFpNSlhOczRqV2FI?=
 =?utf-8?B?c1E2UEgwVXhVak96YS9CUGp2V3pOV1JPMnhGdEpXN0ZaV045NW1tOU8zOEVq?=
 =?utf-8?B?eDcvc2NUbHJLYmdYMFBrbnk1VjJ3WkI2YytTWFZoYzkrRU5lUlNad3NkanM4?=
 =?utf-8?B?WmFTOEs1Z25WOUdUNUJ4RDRlVnEyRzNBNGVDQldnRlMvcmVvZ09kall4UEpK?=
 =?utf-8?B?UFBLd1VWVEF6NTEzTzFQQ2RWMFZ0ZzN5V21Mc0VpUENGdXlWUzhqRjA4ZjN5?=
 =?utf-8?B?dmgzeXJ0QmFSaHh2WDhzRDJvWW9FK0xCL25YVmhwRWRCQUNtWUphT2ZCajJV?=
 =?utf-8?B?WjUzSEVpMURXQ2NXNUV4TFpmakI0ZDJQcE1SSCtNRXY3VVFNbjJzb2ZXKzFL?=
 =?utf-8?B?UWRNa0lKVTl2NzhReWVUSFNtMkttbHkycGtFaWZHb3M0RWRoU3FnSmRFdXI5?=
 =?utf-8?B?b2lNQjdqSHMrQnNSWm1ZZHVqaERWYnJPVllTTDU2WUQwS2U4OGRuUURrSjgz?=
 =?utf-8?B?S1RCUGZ2d3VkNE9yQ3dRV2lpeHcrVC81ODRUUXRNL1RNRFdjWUpPTFpFUjBF?=
 =?utf-8?B?Uk0veDZvelE5d2YzRlJCaWJaL1NYWFdMaHNLZ2kvTk9tNEtnaFdQemk0d1R3?=
 =?utf-8?B?dUlJMWhQdE9VSEVWVkxJemF4eDJ3R0dpRGt6SmtKVUtHL0V3VldIZW1pTkNn?=
 =?utf-8?B?N0dWcm1vQTlTSHFCQVAzLzY5SXZHRFhBUjVYUFVPUWYxK3FqV3E4T3VlYnRK?=
 =?utf-8?B?cGhLZ0VGOXhBY1Y0M3FzZTBWNk1pWHN5Yzh0SVdKdEp1VU16ZG5VdDlkRys4?=
 =?utf-8?B?Qjdjc0hsNVZIN1hrZThPZTM1K28rV0V0Q2pabG1UMzRxQUpnUlc2TEx2ejA3?=
 =?utf-8?B?ZTdjK3djUTdqVG53RDN0S3lwdUVYc3AxYWFoR3l6cUswQTFsMjNqc1AwQ2xU?=
 =?utf-8?B?SGUza1d0cHE3TVNCY0FHTjB4U053TTRqRER2M1I0QjZRTis1UERlUWtpejV6?=
 =?utf-8?B?MWwvVW9KNVRpQk1wVVBaZTRWM0R1VC85ZUZOUFpZalNKUEdQanB1YzZxTWlG?=
 =?utf-8?B?dFdleUZKVld1N2h3MGVZRXFkWnBOdEtrZzQ1dkZqck5YNzhSTzFoNEdSSmJG?=
 =?utf-8?B?ZWdLRWJZSy9wTkR6QUNvREJSYjBuVnFmd2ZhUXdwZGRrMFBiNjlqbVp5VmRm?=
 =?utf-8?B?NGVySVJXdlFFS1NQRVJpN0YxOHJDdmQvUnU1Y3hIczgzNGJiRmdkL05pQytV?=
 =?utf-8?B?Qm1LZ0xsWU5pTmtlbm9IcDhQWjNhNW1MQndReDFCTjduOVBrSGpKUHBDVk16?=
 =?utf-8?B?aUdEN1djQVlpbXUwbk5hMlNxT1RXTUF4Tk81MWwwUXU2SDhkYTVCalRLVTly?=
 =?utf-8?B?Z0thbjBkSVhUajg5Q2paZEtqQU9hcWV0THNmWXdjYm96bG9ZZDIxcmx2d29h?=
 =?utf-8?B?eWxMclVKd0swdWdoSFowM3F1aW9zdlJYUlI2LzVsNCtTbmhxMDdtUHluVEVE?=
 =?utf-8?B?c0MySkNieXgvL1g1L29nU2xLRzVESFZsZWJ0aTBiYklEb1B3NThqcW02UnVn?=
 =?utf-8?B?Wkh0RWNaUS9aYklLOStQak5WR3I1OUZuUHVxSzZUL0cwNkk5R0VjMHFrY3Fx?=
 =?utf-8?B?em5xRWtPT2diKytCalZQL29qTHF3aFhHVXJlNi95VGwrcTcrd3dUVlM2L0xr?=
 =?utf-8?B?SE13bGdNcVhkOTFucnU1QkJmNmtlaEU1aVBudWZ4dUNSTXVIVFZra1MvTVo0?=
 =?utf-8?B?RUdPVnU0ZnYxK3dpZGRFM0ptQnNLa3hQMUJQOStzWmJEV0NjWXJQblkxVWJV?=
 =?utf-8?B?MWNWcW9nVy9TdDIzWWRUSStzaUtUdUJsaTFNQTAxQXJsSklKZzhtK3g5ZW4y?=
 =?utf-8?B?dWZjaWpYWnNreHVZYm1ZQmV3dUdtUFVQeDhIQzVBNmFDK2VoRE5xQnFxSnU2?=
 =?utf-8?B?NE8vYVVld2ExZWIxWTdrbVdSV3ZOSkszaXhhV3o4TzJJdzh0Y0dxYmNKa2Vm?=
 =?utf-8?B?RFR4WkJIbmp5cE50cEg2b2cwK2k1cEw0dlRwMGMyMTRmbWhNTE5iM1g1SkZG?=
 =?utf-8?B?TGVVMlFNNHMwRS9DUUNsYVBvOUdwWW85bHBtcXhwRzRNL3ZsS1pPOEZ0NS9Z?=
 =?utf-8?B?UllaeC8wc2V3YUQ2MlVEMXY2ZmZvcFpMMEFTeXkyZlJtVlNjcTJRSy9yNlB3?=
 =?utf-8?B?TWpnWEFqVWNTT0lsQjZ2SnJidE5ySFQ5ZXBLWEsvWHlvMHhxZWZDWGVic09Q?=
 =?utf-8?B?OXBRRGNGZ1VFMTZBWVlYUnUxdno1dVJlNytSQlFJUXdpRGpENzk0N21MKzhQ?=
 =?utf-8?Q?q0ntmxTa/nOjsogfzZNFJ3Uwv0y+xdGVU3wc0Z3xRxzIz?=
x-ms-exchange-antispam-messagedata-1: mEpZA0FHC82sR6pwOrWbTDKCCdO2x6yNHTE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DCB4E1BBC92C2489BC455B6EE7812C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h3Nn5CysWIN/j/sOItX0APqqMrUvT9WC4zYRInqXCmxTYyTSLKkmqTCMeehn03nkT9ZjLx0W59KOihoqcf61kfANHe+ZWZJAaSRHKyICsXF5pFB7IKRlEFWKMRvPgML7SFYZFzsaTvoB4yci0SZxiWQiSsexuEc5PUMuTUrUXJ7VP0Pi/v697jW7MRq2PiBJUqDPAt/Gz/hyvMdT1UJQKp9JIrkw3ZZzdvE0gT7GERuJC0y4MszRUloe0ePIP89CyoclN7QcNFROsazgbkNahusctWfPkr/hYdM2orSBdCLr2MzzKUo+SEgQiZpgv2rhIVyO3d5CY4b8ecIMxjnBjA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BogqqDUavbakCzFB5H8zkhApa9NIllEWtOsr7pyltQ6nwedEGl9dA5wIx99fqluevRNxgIo8fHGVXD5MG5o4/93L+E8ev1qfb0E7w8of08ZJjoTINGiCADGVnbMzXwBVg7gNtciPLRfly8xSB/PTVoBH+mT8+34zriEDDAUZz2omLEXPC4p73pC8NhGzwXidIIMstqTxV40FKOiU6W7FEU9utW5+S6+ekWI7VtcR65RJTc5HqOSf7941tURIkEjGPXzikZ6LBFYo2lJDFkLVcNWJLWGOq3MWzlzGDONYRKR0Tfjfpyb1oaBz4SpDBx+FGFIs/HAXV4IVosSvFY1FPZZQy8U+peAOrIHzFrbpG9FvgDbTSx/39Z6ikGOMhK4T50Z31dKocl7e82NgAtIB3wgiPSSHhXW3bKhOKNGt9EKTR0D66BhNNY/8U1uTgB6vX0Cguipq88YPNBOQiM1L3Xs9iqAMGxJbOJEq+OzV0TuwxNadHivYhhH6Wdy8e764bsxUMubHOnTlbT5I6o1BztJSKMP9DUji0lrJnRV9+fer5SITGS0iKi1VD+a+5CyfwwL8QTQUmq1K/D7wG8nxh3ppvwewXvlAexiIeYqeGstgSUxZn0BH1ccunbiOAMz7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c20d4b-0782-4697-883e-08df491206d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 03:29:48.2266 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ka0RTTw9k1z4XYAiKDme3FyjPNAa9HsVX0hTIQr+ws1bvAxQAM92SNduonrl8oul8vIO2Ql+TUObfWsKF+2c4nJfDsmEbjpjoXmLdtdQ3Go=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9453
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTExLTEwIGF0IDE4OjIzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gRnJvbTogWmhlbmdYaWFuZyBRaW4gPHFpbnpoZW5neGlhbmdAZm94bWFpbC5j
b20+DQo+IA0KPiBjaGVja196aWNib21fYWNjZXNzKCkgY3VycmVudGx5IHRyZWF0cyBhbnkgcHJv
YmVfYWNjZXNzX2ZsYWdzKCkNCj4gcmVzdWx0DQo+IG90aGVyIHRoYW4gVExCX0lOVkFMSURfTUFT
SyBhcyBhIHN1Y2Nlc3NmdWwgYWNjZXNzLiBIb3dldmVyLCBhIHJlc3VsdA0KPiB3aXRoIFRMQl9N
TUlPIG1lYW5zIHRoYXQgdGhlIHRhcmdldCBpcyBNTUlPLWxpa2UgYW5kIHNob3VsZCBub3QgYmUN
Cj4gdHJlYXRlZCBhcyBhIG5vcm1hbCBjYWNoZSBibG9jayBtYW5hZ2VtZW50IHRhcmdldC4NCj4g
DQo+IFJhaXNlIGEgc3RvcmUvQU1PIGFjY2VzcyBmYXVsdCBmb3IgWmljYm9tIGFjY2Vzc2VzIHRv
IE1NSU8tbGlrZQ0KPiByZWdpb25zDQo+IHNvIHRoYXQgY2JvLmNsZWFuLCBjYm8uZmx1c2ggYW5k
IGNiby5pbnZhbCBkbyBub3Qgc2lsZW50bHkgc3VjY2VlZCBvbg0KPiBub24tY2FjaGVhYmxlL01N
SU8tbGlrZSBtZW1vcnkuDQo+IA0KPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUt
cHJvamVjdC9xZW11Ly0vaXNzdWVzLzM1MDENCj4gUmV2aWV3ZWQtYnk6IERhbmllbCBIZW5yaXF1
ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiBSZXZpZXdl
ZC1ieTogQ2hhbyBMaXUgPGNoYW8ubGl1Lnpldm9ybkBnbWFpbC5jb20+DQo+IFJldmlld2VkLWJ5
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9zcy5xdWFsY29tbS5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFpoZW5nWGlhbmcgUWluIDxxaW56aGVuZ3hpYW5nQGZveG1haWwuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJv
emFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFs
aXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gwqB0YXJnZXQv
cmlzY3YvdGNnL29wX2hlbHBlci5jIHwgNiArKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jp
c2N2L3RjZy9vcF9oZWxwZXIuYw0KPiBiL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVyLmMNCj4g
aW5kZXggZDdhZjU2ZWY2MS4uNTJhYTU0NWVlYyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2
L3RjZy9vcF9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5jDQo+
IEBAIC0yMzEsNiArMjMxLDcgQEAgc3RhdGljIHZvaWQgY2hlY2tfemljYm9tX2FjY2VzcyhDUFVS
SVNDVlN0YXRlDQo+ICplbnYsDQo+IMKgew0KPiDCoMKgwqDCoCB1aW50MTZfdCBjYm9tbGVuID0g
cmlzY3ZfY3B1X2NmZyhlbnYpLT5jYm9tX2Jsb2Nrc2l6ZTsNCj4gwqDCoMKgwqAgaW50IG1tdV9p
ZHggPSByaXNjdl9lbnZfbW11X2luZGV4KGVudiwgZmFsc2UpOw0KPiArwqDCoMKgIHVpbnQ2NF90
IGZhdWx0X2FkZHIgPSBhZGRyZXNzOw0KPiDCoMKgwqDCoCB2b2lkICpwaG9zdDsNCj4gwqDCoMKg
wqAgaW50IHJldDsNCj4gwqANCj4gQEAgLTI1MSw3ICsyNTIsMTAgQEAgc3RhdGljIHZvaWQgY2hl
Y2tfemljYm9tX2FjY2VzcyhDUFVSSVNDVlN0YXRlDQo+ICplbnYsDQo+IMKgwqDCoMKgwqAgKi8N
Cj4gwqDCoMKgwqAgcmV0ID0gcHJvYmVfYWNjZXNzX2ZsYWdzKGVudiwgYWRkcmVzcywgY2JvbWxl
biwgTU1VX0RBVEFfTE9BRCwNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtbXVfaWR4LCB0cnVlLCAmcGhvc3QsIHJhKTsNCj4gLcKg
wqDCoCBpZiAocmV0ICE9IFRMQl9JTlZBTElEX01BU0spIHsNCj4gK8KgwqDCoCBpZiAocmV0ICYg
VExCX01NSU8pIHsNCj4gK8KgwqDCoMKgwqDCoMKgIGVudi0+YmFkYWRkciA9IGZhdWx0X2FkZHI7
DQo+ICvCoMKgwqDCoMKgwqDCoCByaXNjdl9yYWlzZV9leGNlcHRpb24oZW52LA0KPiBSSVNDVl9F
WENQX1NUT1JFX0FNT19BQ0NFU1NfRkFVTFQsIHJhKTsNCj4gK8KgwqDCoCB9IGVsc2UgaWYgKHJl
dCAhPSBUTEJfSU5WQUxJRF9NQVNLKSB7DQo+IMKgwqDCoMKgwqDCoMKgwqAgLyogU3VjY2Vzczog
cmVhZGFibGUgKi8NCj4gwqDCoMKgwqDCoMKgwqDCoCByZXR1cm47DQo+IMKgwqDCoMKgIH0NCg==

