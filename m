Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B260C606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=PJJ9uhuY;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=V3YIZ+9j
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKjw-00043K-9R; Sun, 22 Nov 2026 22:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKju-000438-Ii; Sun, 22 Nov 2026 22:29:10 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVKjs-0005GJ-LQ; Sun, 22 Nov 2026 22:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795404556; x=1826940556;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=B0UWaBG7HstfFEqRnCkdQiFovatjM8XHKnCI7ZwbYM8=;
 b=PJJ9uhuYjmPm/T20c4j5UXLljF9AnRwGFQPhQM3YcFVFLk0vV7MXusKE
 xF6HYa5eVlmEU5ePUWqC+XdGrDtC4U3CNgU9kfQjyNSCSUo3ZmQ5obLhD
 Md4VGjugA4WIgElEtbLe4w8rE53ZvKHQPFmwX59tAsHYUeBLs7Dirq4sc
 PGYJvoR4yU6OjIznMmwV7gKbxAC49Sb2BrzKk30Jz3b7HnOPOpWCnm043
 HMrxoRAX/Cjhj+7a2H/iceiUiv6CENz8+sLewu94ArHanLTtMAm3DCg49
 SiBueaBjL3Z5ClCHlLmIpN1RgKm2IeplLGHXhwVdq5oGAj0dX6V8qtfKg g==;
X-CSE-ConnectionGUID: HF6/YjFHQryI/+X9kGALvA==
X-CSE-MsgGUID: vJHBD3E2S+mt1IZEcCVviA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="162505969"
Received: from mail-northcentralusazon11013062.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.62])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 11:29:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1SnqbrXxIaBY2Jii+zq+IMXGfnqT/8JCJhhtmUUtFgFMQ8xhKS8+iBdfXi3/3u/LznpMl9QjZl+wAOv53mRgySpjOzQ2wsGYMuxVBvcUwzgf7rgSwTeR+bpGwPDyjVfc4lgfkK678+m8HAwNFeAKxTY3SwrGVIxU8c5jzDqBEqkxzpy7OlCaOgs5CkqAM8qXV80JXGt6ELUWVMRMUGNWzHlgiEPtrAnobbkf2vlfLj0cORyankcx5SRHxi/rWpe59uPbue/yqBaMhEF8l/fyIgL4NHTS9gOVC/lTvUoXwAVhsBVT2fqTG4zVVAp+u8yeMW00nhZWYxKhohBUEv1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0UWaBG7HstfFEqRnCkdQiFovatjM8XHKnCI7ZwbYM8=;
 b=vNUCfNu+R1D01vQJwJ3lIVz7SMkh5Q5RzS8vzUckCRlrVcvzwaj6PdMiAEBkFP6uFHmNSOt+lNy4xbv3x29VQYFNdBOwZWCX4q/reyJDdc8u7gkSeDyv3K2MBPokR3iZG8TWTuI1s3iHClG8HiH/Ms5t05udvxS4VCDmQnje2iW3FJ8HjXxYEtSiCzv3KSHRiNoQ3xm8dualoJIoHzwbwCkYhmdKEB+UI17EGn2/En7EGUvi0jbKA9ZW/wCy+xRqzM/ilEJXLasncBqkiTd2Q8wznIMe3SjEKIT9Ut9n0tpCADiaRdFr3ya3py4qqydZSfAXSJmMM5tpj5IZreM7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0UWaBG7HstfFEqRnCkdQiFovatjM8XHKnCI7ZwbYM8=;
 b=V3YIZ+9jgp4xisn2Cu188mDwJXiOcxNERssvcBZUWcrN9JNcyA6zsz7mFrvjO4Yvh3UYpdhVoD6YWdFMFdsjMMu/P/2giKfqSTLP34GHTSb0n1gMJb3CK16rbyXjfbuEhRUwMOUEIjm4K70iYeUiKOpNmK9GvpDawPmkzv6lddw=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by MN6PR04MB9453.namprd04.prod.outlook.com (2603:10b6:208:4f1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 03:29:05 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 03:29:05 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 1/2] target/riscv/tcg/op_helper: avoid env_archcpu() to
 access cbom_blocksize
Thread-Topic: [PATCH v4 1/2] target/riscv/tcg/op_helper: avoid env_archcpu()
 to access cbom_blocksize
Thread-Index: AQHdcVm8VrXqJ+n0+kmNaRunAhQAmLc7Et+A
Date: Mon, 23 Nov 2026 03:29:04 +0000
Message-ID: <da4f73f385c9edc3c892ebd1549d9cf76d224ce6.camel@wdc.com>
References: <20261110212312.56809-1-daniel.barboza@oss.qualcomm.com>
 <20261110212312.56809-2-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261110212312.56809-2-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|MN6PR04MB9453:EE_
x-ms-office365-filtering-correlation-id: 321a17e6-2266-4910-b668-08df4911ed08
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|19092799006|10070799003|261009223027099003|18002099003|22082099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261028144727099003|56012099006|4143699003|10067099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: IqpK7M7mzx7Xc5ipd0dX3/H4F28iHjdEbW3Ot890VubQyo5hZC9JgBs5s4/MK6sr5AhsNpbTyMP0u4W2YBChG4qqy9N6Oz4kwBdzsBiYWT3XkinpQvE/HMSr2ROOzvhhUpF9UKklmrZ0JDtyb5epndb63wnDzxIyeKo+YGUYcq1pwjobDbjR3238FeLeEiXiqz2YsKOUtzr2xMgeyGiFCLUFUcELGY9fXPx4f5Ln5fz2amiPB0NTvxF85YL37QNfzMNOY06/b7nad40KYdp8xhqNx2bhjWt5MtSA2C/RYYs56XpKXZ0glDaLJfozywHlXIffjp08BSGrECL9ZqW09adprfJwhhPnyS0MpiHtwFUuTqyuto0qDmbh1Ly5un2Y6oHLaKe5szazH5lxEr6wCVJKjxl7xG7nL3M+/iQHPYGPthhWdyuvYeoEHv1gzhXe/rK1lU68m5+a10HEBh5YfwyQK/V6PBsuxn5RGhkMPp0XRV4ktT22mNOLHaYVVyFWGnPrO2/eD1BRHVrm2tujoHMzqAUPSsUSvxz7GY5WZSmQBlHIzu7hEuxxwgdzOl9mPMvHij4n5gpnNVF+ncDeGic0hH8pWBDoG/F2twm30bl8jkoxREAizf0h7nA/rF4CDZhkgMlO2/CYbTmInZS+w2Iouj1/kzn+zGTVIjQZQ4HbfGLRvri8Hyd0TYmDWdXbWs0QX+KT6evKIS/uCkIwPPtXAmDSzgf6eWkOiZZ2O94=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(19092799006)(10070799003)(261009223027099003)(18002099003)(22082099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261028144727099003)(56012099006)(4143699003)(10067099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0ZidG1OYVR6bzdrQlF6MGpMcHk2ZUEvQUlBZmhRamxDVWIrWlZ6clVpMVZo?=
 =?utf-8?B?eUtrbUVYRXJCamRheFBNLy8vKzRWQXZqTCtkbUFWOEVUOWpZb2o4M24xbHI3?=
 =?utf-8?B?QnB0MTZvZUwvN25ZUUhJaWtvTTg1UTd3dG8rY3dIL3B5VWNGQi9ybld0SjhW?=
 =?utf-8?B?dG13Rmt2cEFqMUlJR1dtaFJZM3Y3N0ZXUUg1SnBIZGJTeGZKdDFPNFB5b2lS?=
 =?utf-8?B?M0EwRFh2dThtZGZiMndvZ1BKSFhBVUM2cVFSdG0rK05zc0ViNUlocGdUR1B6?=
 =?utf-8?B?K1JkZmJKWi9VU1M5UWxhNHFQamI5azZqS2tWeUN4QXVKTTJvVWZMeGhrNDZF?=
 =?utf-8?B?TnRZdEM0d1JDRVVwK0V2ZVVzVk0xN1lhbSt1ODNteGdtR2pFM3J2K0hwamhX?=
 =?utf-8?B?eXI0QkdvWWRJK0tmdkNGbUpXZDl1M3BqeWlOeERka2RZV1lWSXNSdnRFdWcv?=
 =?utf-8?B?akpZdmNtWlBhWXRXOXBIbVdmYUZ5ZzlMTmhnRXJoRm5veDFuUjFmbFNxTGRS?=
 =?utf-8?B?ZzhOZ1JNdElXNnJ3c1lpZE92YU1xN1JJdGtIZGVCRVZOZ2ZJcTk2WmtuYitW?=
 =?utf-8?B?eTFBYjFCcFEyM1NXa2l6M2pWTW9UK21IVHdmRWFjNFYwTHpFNG51aEtNVHRl?=
 =?utf-8?B?MUQrYmF6MDhUemRBcnVDN3pWQXgxUUNiNHRDTlphUlJvVlVkYUhHbHRWbzBj?=
 =?utf-8?B?Z2U3RjJCNm5nR2ZyVlBlK3FQdnpoeDI5SGFRSDhiQ0FhMzJTalV3dVFXMUNF?=
 =?utf-8?B?MGJYL2owbGc1VkJyS2JHR0NXbkhkVkpIREwwcUM4R1ZlU0ZNSEtYR0swMmFX?=
 =?utf-8?B?cWxhN3l4WVIvYmdsbGFFQXAvMHI1MVVaSWJ2emRMM25HQWFoUDF0eHNrNVdp?=
 =?utf-8?B?WUNyS3dkOEtyVVVsMnNtaXFvaXp2REtNYngyZEMxTkNwZDQ0Rmk3NXhPYytG?=
 =?utf-8?B?MVRzb3JqbnAyK3JGQU5Bb1JJN3p2Rlh5eFY3bk9VR2QvUllxb3B0MGtJTmNv?=
 =?utf-8?B?WWZoSVF3N1ErWm5Ldk5nY3JrL3Zmd2hFbmNvNklreVFDUkJxYjh4QVZQSTha?=
 =?utf-8?B?QlhhQmJuUDVsK3MyMHB5TmtYK25ydjdVbGFCZWlId09XVFd3T2lPUTZSWk1Z?=
 =?utf-8?B?M0NCYXhDZm1jWG4vQWtWbWxrd2ZpbWJZU05OcXVlQ0VrY3FzN29SVmd5SW54?=
 =?utf-8?B?cTFISERsSXUvNTZKVWlmRUdkNmpOQ29yNll2dWFoSE9zcVppYUtKOUkwZzY0?=
 =?utf-8?B?ZEg5VXdENjRkK1kvSmROSW5EQWdEVmd3UzlmTmdkdEpPU3huTEFGSDVVdTBG?=
 =?utf-8?B?eVdaV0RlblNLUFFmZ005cHNSNlpYMEUrb3p4K09mVHh4c3RnNTNGZ3JuYUNG?=
 =?utf-8?B?R0ZiZnhEK0NzNDJvOW9yYm9pM3d5WHBVQUZWQUUxL0ZUclZ6Yzc4ODU2dVFD?=
 =?utf-8?B?Ym9FbEh3aHA0WHdmL3NNZzdWWi9GZzNxbm4zSXE4VW5tSzNvZ25jVUliYkhZ?=
 =?utf-8?B?SlJkenZVMTFpekpLZk4rNU9YWk5QZUVGZ2c2azRaMTFTZ2JObzBwS3VjK2R1?=
 =?utf-8?B?QUFWcThzRVp4bUZ2K3NJUVlhWm5HUjdJWVFVaVhXOVMwd0pON3FWWThRWEkz?=
 =?utf-8?B?MDVSNi80M1Y3S0VoZlpSZVFkdkw5YXhJTHU5QnhQbGlUell6am41VVRqTUFU?=
 =?utf-8?B?THBkd01Qb3puajdRTWZ3QlAxRkpWR0V0cHcrcFYzb0pFMkhEb1prdjhtNUVm?=
 =?utf-8?B?dnpUVXZiZHMrQXBqU0o3M2lTSG1ZYm41WXJIQjhPcm5odjFPR3NQN2QraHRS?=
 =?utf-8?B?elJrM3R2OTJkZHRyWkVJWFZlazd2K1RzK1FpRFpsaVlWQW5JSTlTUGRjZC8z?=
 =?utf-8?B?bERyODU4Vkt5cmtoNEozbng1N3F5Yk9RUDFhSHBvVDE3ZDd6Y2dKcXp3dE9K?=
 =?utf-8?B?YmZmV0tiOFkvNWZ5MzRsaUtheStSTThUbUFtTGk4Q0M1aVA3N3hWd2NnZG5G?=
 =?utf-8?B?RHVpYkh4QzAxbnVyOUl5b1VyQXhlT1NPdXJ2R2lBbk9UdzBsSTMwOVJGVWJt?=
 =?utf-8?B?STRWVWZidnJkbXBGSG8yU3BkM2l1Vml5dUhPdGJYdTJWb3RoZW9iczBxNDNs?=
 =?utf-8?B?QUdwamNkbWI4bFNmWDM0elIySk1sTDZtZmxDS01LbjlIRXV5ZlgwNTlwaHJV?=
 =?utf-8?B?SWpaUUtRaUx0QjdsemtyRUxXd0JHejByL3R4SmpvN2FQUEl3MnF6UzNUdlJH?=
 =?utf-8?B?Ym5LbWh4OVY1STZHVk5uYk9zbXh1N3MvYWVGSTNyamRacDZMbzZtMUc2emJ4?=
 =?utf-8?B?Wit6S2pmZVhXM0gzZzlCS3VQS0pSVmwwV2JZU3lvRGNnc2Y1VGUrbE0xaFh0?=
 =?utf-8?Q?zrlSNBjrFyrarbrvNxMS40ottzOlFv2/L+mHQIPh6o3GE?=
x-ms-exchange-antispam-messagedata-1: cvpkaH9vuOEmlUmw8uyKJMIkEqPudOatsRc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD111B15EDD18F4A8CE16DD71895AB9C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: X65w4lYp/VJUyXetTqOqkMWapPuR/0ExN+sjb7Bdy+wt5n1yx1PlM8bVz0eEKdZzUw9/vNOMyoUFsrn84XthKSiUmAwSTX0JYMAit0iU1kodFjbeey4IhhGRYceH+TBSnqU5+rfRCD2EVjtzzDHlmmpwcmWKsyUWsgx5VCXdmgd+gYcwyGsQapl/6sxM28KIOh19ygA4UBiLEE2j49d3ROuIC16t0ZpQwbNDr1NIb7enpb/FBXiUU2R7L99me0N301sr/TIxBofrkDhBw/5RXHzD2xPNwnuGPA1v6Tc5OFuwv0NhCVVk1ZdrCW8TMdVjWZaf/UP34J4tWVyL/f41kg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vE4bgjzt2jbYF9RXszOJejs7O2SIGo58qceyGAvH/0FMFTUyfOxAbpy+TImHbMn3ErA3O+BJ/FEaGwu/u9nFArQhO5byBFrQwRwyHwCzWlTQTdyhRzVWy8a2VhJG5oZoEIT+HfXVkFyXq0D0rW5MKY6lGnQwUpDNJrMcxulOftJxY9CWRIfmKH79HeGius1d7q6e9yVkTLA/CKa9jV8n5n0B4zaVsy+NyWmQ5jn1aFpDvO99Z4GNZC+p1Y+vsWEYCenU4gRC9osCzDrWHOQPEv6MWUOzi8jkb/TSRM8nbQ4OHi6cD4Wsoti0zaUXNENX30MpYbpKwbRYU6IYs2V+GbTBbb7/SLzM4rrz7g/dCd81KfwSEOuU9v6lkWD0HCW46KArqyMoH6eYe43wHwUVjBleK4RgC8OpdvYlHp/hytAbkfsRxNfXVjb2MZ/ugfVuv7stkBaEc1iY1QwbRi06Z83rGXmOvKuUA30Ft/NJOK3xKuKcQBlmxKAxol2aYqx58xlKBfefs1TidqcUS1s57j54+9aVVUiDGJggMQMWgEXbSWD/uWP2YXpQ5Dv/3phjaM0G4vUAOp7eAkPskTLo3NETgz8ipxl9PRhl7bipf7YsKnPiHxRM0O7lz5zIlf/f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 321a17e6-2266-4910-b668-08df4911ed08
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 03:29:04.8676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abrgl37dTdHcxcnzFn4L6HJazKHiBenXAOAnQSR3+pIWKl+WYuQS/a9WAyC8+wBJ+LoLxIxFf74U3VEBqYZ5m6UvIajDtXcixeS+b7ZheEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9453
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

T24gVHVlLCAyMDI2LTExLTEwIGF0IDE4OjIzIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gVGhlcmUgaXMgbm8gb3RoZXIgdXNlIGZvciB0aGUgUklTQ1ZDUFUqIHBvaW50
ZXIgYXNpZGUgZnJvbSBhY2Nlc3NpbmcNCj4gY3B1LT5jZmcuwqAgVXNlIHRoZSByaXNjdl9jcHVf
Y2ZnKGVudikgaW5saW5lIHRvIHJldHJpZXZlDQo+IGNmZy5jYm9tX2Jsb2Nrc2l6ZSBpbnN0ZWFk
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGFuaWVsIEhlbnJpcXVlIEJhcmJvemENCj4gPGRhbmll
bC5iYXJib3phQG9zcy5xdWFsY29tbS5jb20+DQoNClJldmlld2VkLWJ5OiBBbGlzdGFpciBGcmFu
Y2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKg
dGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYyB8IDMgKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rhcmdl
dC9yaXNjdi90Y2cvb3BfaGVscGVyLmMNCj4gYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBlci5j
DQo+IGluZGV4IGY5Yzc5ZmU2YjkuLmQ3YWY1NmVmNjEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9y
aXNjdi90Y2cvb3BfaGVscGVyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIu
Yw0KPiBAQCAtMjI5LDkgKzIyOSw4IEBAIHN0YXRpYyB2b2lkIGNoZWNrX3ppY2JvbV9hY2Nlc3Mo
Q1BVUklTQ1ZTdGF0ZQ0KPiAqZW52LA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRhcmdldF91bG9uZyBhZGRyZXNzLA0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHVpbnRwdHJfdCByYSkNCj4gwqB7DQo+IC3CoMKgwqAgUklTQ1ZDUFUgKmNwdSA9
IGVudl9hcmNoY3B1KGVudik7DQo+ICvCoMKgwqAgdWludDE2X3QgY2JvbWxlbiA9IHJpc2N2X2Nw
dV9jZmcoZW52KS0+Y2JvbV9ibG9ja3NpemU7DQo+IMKgwqDCoMKgIGludCBtbXVfaWR4ID0gcmlz
Y3ZfZW52X21tdV9pbmRleChlbnYsIGZhbHNlKTsNCj4gLcKgwqDCoCB1aW50MTZfdCBjYm9tbGVu
ID0gY3B1LT5jZmcuY2JvbV9ibG9ja3NpemU7DQo+IMKgwqDCoMKgIHZvaWQgKnBob3N0Ow0KPiDC
oMKgwqDCoCBpbnQgcmV0Ow0KPiDCoA0K

