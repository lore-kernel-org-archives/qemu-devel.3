Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A6C60A2616
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=XGogudow;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=rWcv1OOv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQZaX-0007Tf-Sx; Mon, 09 Nov 2026 19:19:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=767f8a997=Alistair.Francis@wdc.com>)
 id 1xQZaV-0007OS-4F; Mon, 09 Nov 2026 19:19:47 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=767f8a997=Alistair.Francis@wdc.com>)
 id 1xQZaT-0005yy-4v; Mon, 09 Nov 2026 19:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1794269985; x=1825805985;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pnE0J4AajhSBIbSd0+iViRKjtkQmxK22S5dPH6sPUlM=;
 b=XGogudowjWeFgdoXY75Ay3ULjdzjka2nv93STHRdb1KHIlmBu88antmG
 wRsSF0HWhNepISZ7rpDwt4Jj4qJb5q9Sd5B5Fmx2i7bKd8zLMEoFrY2Cd
 sjCjuMx3Z0OGeRRHN0yDeYJ/cu1ICWhMZHoxS8dE9lfOLqDRzufjrbZ2n
 9xzZTfSKg89cVqOTG3xUQsLC5Mah0UjHRWVnTGEF70mJX+hUC6U5YlT/K
 bMjLYlBu6XnaqOELEiXB8mwmkT8uJRkw1myRPHRVOwio318owqvWTJ3qJ
 zSZp0pkBqIcSG6Iq6m/f1ebh/duVGpReENAFhMLa3gSJ/z4twpyNa9mrQ A==;
X-CSE-ConnectionGUID: fanr+FFhSi6MS4jfJl2CbA==
X-CSE-MsgGUID: mYc5/glhTqKi0imuFoUpAg==
X-IronPort-AV: E=Sophos;i="6.27,204,1786982400"; d="scan'208";a="156226896"
Received: from mail-southcentralusazon11013048.outbound.protection.outlook.com
 (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.48])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 10 Nov 2026 08:19:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUKLV19V9APlEGXs1ObP5suRZF5Jgrvey+Y4NesiQ8O5z2afuEs2kZX/FEGJlcL86/JbMGDvVSvq+SAEyzzHQgAqnlNd4tLuvTHZI54+fmrts4f2IAWAK7RRxu7GI7ETQ2y7mLiM18krAhsr0865P44OGP0xNcUaSuNthu3cyvmVR4uaPTpd67iMEqnM8NIjj7hMp+GG1KQ4Yfn/ZAE1jcbGdtBEphzJsTBKYLnfeBRe+RqK0nc4z7Q6+JrreGBoy1cD6Qk95TlN/W1DanDYb9De6eK9TlwLKIsZHf5j8xoHkZKq9FHdkL7Omeir/NO1WD2ZsJw2CxRnPKI2uiMVWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnE0J4AajhSBIbSd0+iViRKjtkQmxK22S5dPH6sPUlM=;
 b=bzPcLefw/xxuf5yvdAA7RdGkuydRRsxZzLw5cU+KpeywLK+SIgdDl2t1IHwa6Af6fDOe01rqP1OK9VM+NdlX+iiaUQINEzzgI2T0gtUTy3kycSFl/bfWuTvawnGtcoEcGhGSQpkndyEYwEyoI4QyWabwXPYCtyozVnaGMM3g1uk92FZ0Cke7KKNcNkzvL21iZnhqWnzXwTJGaeB6wGntTunNyfEN3pWoEKw7Rqg8X6Ob6tlikwTjh4HcsVagVm1yifvN6x9U+dQKvC/r/jFxSweBMlL2NXWVaBHa50E8z/j01Lbmt5qLsRPYDna/zY1x+Bom+TfZ3IzUIjdnLav+IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnE0J4AajhSBIbSd0+iViRKjtkQmxK22S5dPH6sPUlM=;
 b=rWcv1OOvCx4bCYSpi2y2Y/LotF1EDI6/wJJqmh8+fn/gyTguTDDMvPmAJPjrLeJC3fYDtWTitpgCQnq4yxKl963jTzwiW6XOIkhbOxkUzWwFdGhPCUSeHVUyt/MuV5nFejv4qB5GEuWEe3kNB5rDdBdvpM2ZfrySkUpvVOKMGTI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CY1PR04MB9740.namprd04.prod.outlook.com (2603:10b6:930:108::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 10 Nov
 2026 00:19:40 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 00:19:40 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "wxchen0913@gmail.com" <wxchen0913@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Use gen_goto_tb() for vsetivli exits
Thread-Topic: [PATCH] target/riscv: Use gen_goto_tb() for vsetivli exits
Thread-Index: AQHda7moMofMdF6h2UCmh9Q9LSYCIrcmeuWA
Date: Tue, 10 Nov 2026 00:19:40 +0000
Message-ID: <52b3e15468c25d65fceacdf943ce49482833461c.camel@wdc.com>
References: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
In-Reply-To: <20261104-research-vsetivli-direct-chain-20261103-v1-1-ace12cf5280a@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CY1PR04MB9740:EE_
x-ms-office365-filtering-correlation-id: e0e2108e-e03b-40b6-deb3-08df3ec04fe0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|376014|23010399003|366016|1800799024|19092799006|3023799007|38070700021|261026140227099003|261021123027099003|261009223327099003|261021121427099003|11063799006|261102123227099003|261022105027099003|261026121527099003|56012099006|261022075727099003|261028144727099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003|18002099003|22082099003|10067099003|6133799003;
x-microsoft-antispam-message-info: WG+hVvA0Yf3xHdFU4uiNHJ6IzC3W+xeLSQDuEelG7WdSBAohFFkt7a6/HvbNy2kYvNDXvqXqbXDAFhhgiSVE369xdwXq/CtuK7PRlfjH/oVxUgG8tNlpZSC6kFVX/LiVmuWNQTx7w6GW+6UGjLF4F3WxpeCjRmPqOb6oIPQ7/hEhHIV81J4KX/unpCz5t96wISkFNUcx507F8razkYo1YMFp6IfJbr0NQn4A11dYDUIz0qCLepbtoN9d44DiTc3tfFklcp7E+M9T8Xj31kLT8P5Wxc5HFAqHya51Xf2bJcR+3z4Jq4D4gDtizLndaj1ADjBiMcLKHBDB4JgmRT1ihkzvz7qi3yQMV9NxuAW57ij8a809F1/vhAcDphUz5NrbcaYsjYrBq/pucKMo0pKq1lXTKt5cJocDA1gdV1RWt+rrUCOHYYqzSfSXBlH/B4tfkfxgfXnoikNliLrKeU9bYLAt0oofJWuOosH6cIQVeQsdYpUNyoiNgs+wIOJIFHm6yaIHSCR5OR0LTELhs5VY5W5aiAYB3TWYhYBLKG7KaqhfEg7KWN3DaG6LaaDnXjyVP2Or3iK/nl49SG03fBjCEO7QJjcgNJ/Mb4yGAQENcIP2a9EYZyJnYavofI8n1UlR8PH8NwhItFfXf83WefNwbIplGJz5DJ+vTbuiM3olRNa21l/QdZbqumIqmzt6lB8+9AOs8caB250LyRjYx2QhhEHCmKpAEF22WIc7UNpLLWY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(23010399003)(366016)(1800799024)(19092799006)(3023799007)(38070700021)(261026140227099003)(261021123027099003)(261009223327099003)(261021121427099003)(11063799006)(261102123227099003)(261022105027099003)(261026121527099003)(56012099006)(261022075727099003)(261028144727099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(18002099003)(22082099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmwxUHFZemIrdE9kUHFGNDd1VFd6N1FSRWd1b3hqR2cwUEphK0Y3bnViU0FM?=
 =?utf-8?B?TUhsNjJGbDhIWXRVM0JaakIyZHE0dG5TN3d5U1NwQVo4SDF1QkU5d2VxUE5J?=
 =?utf-8?B?cUxxamFsRVFLOHNzT3RLT2JvemdmTVVaTk9tTEZUc3Nja0FiT2gxZEd4eWlq?=
 =?utf-8?B?bUk4WEswcjg1cW02RTh3TGlRQWc3cVdMTWhHVHNKNkpqV28zZEhLZnBvT0ZR?=
 =?utf-8?B?KzVtdmlGdU10OWpxbWE0NmJ6SUtyRjF0MU9JR1dncmV5WGhIWWZiKzJPc1lJ?=
 =?utf-8?B?UlFPek93Z0xIVzBRRkNKWG8yYjJlblMwcWl5dFZYckd4eTc2bG5RYmxINzlw?=
 =?utf-8?B?d1VWTGZpYUN2d1dxdUNFV1JXSUFGMWxhbERmVU13UG9uQkpwdDdscU85NXVT?=
 =?utf-8?B?Tk9VaGhVcFpkdmNEVXl2K2JIZXRJSVA5dFBaV1RudUlkZlljbHIxa1gzYWlM?=
 =?utf-8?B?VGFYVHJFM0lwQkN6N3p0ZlJZQ3NVQmlOVUJuMzN4MjB6QkptNFFTeTlDU3hF?=
 =?utf-8?B?Vmd6dGNlVkNMeVRiRGhoUXVMSkMyNjE1K0NIN2dHMWYwTjhKbkRQUFlQSlhq?=
 =?utf-8?B?OWI4ejd1KzZ5YzgzT2p3UGtHejJ0WERReDBpMFgxK1hFQ3FhcHRnMGtJdm85?=
 =?utf-8?B?M2pWRVFSTHZYRW9yNTVwMFBIMjV3UXhDQlJCaE1RSmpQR0tFQXhnMkI1WDFV?=
 =?utf-8?B?anFqcEs3bE1QTFNvRlZaUEFGaitoUG9Ld0hUVjJVdDkxL0pkeXpKVXpRZVA4?=
 =?utf-8?B?ZWlNSTRXaXdZOFRzNEhjK3ZIN2QvcktZSnBObUIrbHBLbXA1aWVTR0JHL1lv?=
 =?utf-8?B?MVZMVjhwWTQ1cGVhTDQwVnZpbTdNSW5ZdmN4cWxERlNPemswME5HZ0EyUjVx?=
 =?utf-8?B?Z0Y0VGVieFNGUXQ5bmQ5TlRZajQwc2VSRFJpb095WW5hVnZMcDJTNUhRZ3pX?=
 =?utf-8?B?aVNuK1FPaHFxMmhNNytiajFNSVdDdXlRdi94QSszQVNTSzhHYW9oUHlrR2Jw?=
 =?utf-8?B?dy9xNGYveWp2YzZTQUU5TDNhZzhwR05aMHhyU2lDT2psUFNPdGVmbFdlVml3?=
 =?utf-8?B?T1U0QjJ4RS96Mks0aGdZM2tDRzU4NmFQQkFvZk91dGxsYmRsbmJvQTQ5UHBZ?=
 =?utf-8?B?S0w5elB6NUZvU094NWJxejhraktGam1nYVJ0cFcybWxNWEFnbkMzQ3BsOGNz?=
 =?utf-8?B?d2lVOElzSGlOUWlLTFBkNFBkWXR6dXNyTHdyeExsZWdSN1hMWmt6ZDN2ci9q?=
 =?utf-8?B?b1RlVnZrUFJIbmpOTkhPYUphVERPSzg2bUZIbVl4WGJOdVcxNGJWVk5EblJC?=
 =?utf-8?B?QlNYMXU3Qk5OcUhPemlacGpHa2V5VGJ3K3FId25rcjNEN3JmaDlUSlMrSEVt?=
 =?utf-8?B?YWVwcXFCSFdEUHVPMTdMTXFTUEZsd3FxRjRoOE1NNEY4UEdzSVRoM1VFZmgr?=
 =?utf-8?B?aTd4VWN0SitnSXB0N2RMZElmWDkvVlhyTlZOWnlHdGZTMVV0VFNjWURtak8z?=
 =?utf-8?B?b2swL0hpWmxPcHpvRXArQlpZZTBSNkFEYU44MVp0QmMrSnNiZzZrTEtZMUlx?=
 =?utf-8?B?R3F2allZWlRvNzV0UmRHY3NyZElIRnNVcm9sb3QzRnJiU05BZ3pJZFRHd1lE?=
 =?utf-8?B?SHltbExHaUgzV3RxMkJmejV3R0lHeE1ZQjNjTHlkT2QwaTRhMHBXQ3JHUW5P?=
 =?utf-8?B?cFpCRkdKbEsvNG9iaW5CUmdkZ3dNSWU4WCtHMEdQZlVuMC9HT2l2MS9iejM0?=
 =?utf-8?B?Wm9oV2c2QlQ4ei8yRWZ3a0ZhMGJwTG05WXFKWi81WldwQlB6R0RwaHprM3Bh?=
 =?utf-8?B?NVpDSENibUN0aldsVDhoMlBUWldDTTVzZWF5Q05vNFdiclhKajlobmUra3l1?=
 =?utf-8?B?czZ2djh0MGk0STdoSHBPdWx1Y2FHVkpobHVnZDMyVjFtZXFTRWd5RkovOHFq?=
 =?utf-8?B?QWEyd0dRaE5TRzAvSUYzemQ1Zk4vcGNMMlBCeDBVS1JsMy9vRnRzRys4SXBn?=
 =?utf-8?B?M3prRFR5Q1FkVEg2UHNzMTNrNUNaQytUZ1BEZjRIWmt3VEFqR1ZlUUR2Rmxh?=
 =?utf-8?B?NXB4eGdaN2RNclBoTWQzWmxuZjd0Tnk0eWpUSkxkMzFkNEhydm5Celc3WnpQ?=
 =?utf-8?B?YXJWa3J1K0pSd1dFTWZLZ1QrNXNiWGF3WHZlUG1vV1ZCWjRhRk1ZU0x1UlJD?=
 =?utf-8?B?YmJNTFJOdStaNEJwYTdwUlF3ZEtQWWp2VzZuTDFTSS9jUndwWXQvcUs5K0tB?=
 =?utf-8?B?VXYxZFpmdzQydjdRZy84UW13REtkTG9VWjRrbitVdUlJY3NTK2E1VDRFSUV4?=
 =?utf-8?B?NngweWZNQUlIMWJWUzRpNEQrcXY4alpIWUR4QUdJYUo3dlQ0RnRiVkhUdDZk?=
 =?utf-8?Q?0u+o0YNBRELiXnIv7//NS4JcFFCUo4AdSMG/4SztpMS8E?=
x-ms-exchange-antispam-messagedata-1: Lfab5iqHjmSvqSIUs9Kv5hsOYVw3BicN+Aw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE03046D5934B34F88557D5C08F2FC73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lPiHGNI4YvRNLgcjgOl9FlX46wmswNBEEab6YcWCzSHkUDDlV8ZMUO/qJ8N0n02WhHKErVlILyME2HZIB+sf+JIYoMzoQoRtSG6DzgCepIPqM85WSyAnXRgb3VPVNPKy5K+LJN+oqj/h8db1vZ9+PJWLbTfc9FiDwo7gUNtgi9+qiRqE8kW7DZaFINHv7wxo81XiRYslcNW5oQSgaFO8nccdLLxpEBxTm/IP8xvgoE9e3tyGxi8QRCET4xtYLDvo8kH/2znP5DaSZQSl3eemYF9qRNNmwTKga3WSgg0m8meaV/+gUuMuo1uIKDWhIfVU0eiMZHLBn8GMZnplff8hfw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Tbr1+MCNqzglGdgInzZY52mzP9KTMpJWQhur5SSMRUR58ErHmwg+jm4u6tCZv/2vWlP+WaEoCEOhI7VF6KDT6qMC4Popepb+6SeY8nNoBoaeSYSYn9eNghrNWzPb0k2DOP6ti5iNO2l2LDLAgHXCVz8Y+C8sn5CFiVguZMP8JaQhVSU+8do5vZsvGiPbdbABqqX5DD89WJsaieplBtTWZ8zyLO6FesR0ZAEVzMImwGoFn+iMGAeAx/aef0JEKKsqR93aY6Diaj/UPANxplRg0syFGv5C3WLadJ0QYGnb9LxTEUq35b3TAldB4pgP+jLYoFPJ1qMPXt4hkhK9SBVaRQQyHP0EH6/dqunzVqupwRp9yiXY+/nAmU8pHRvzrxKGNP9siCdfQ6cisMVdQclovDqdFd8qsrY+yyip6QR4JLLehvERrU92e30ejXcJvYQ0GhDF7jYsiNnZHQN0aA4VwDv6rw4oIstpNB9rxXozxo3Fz3o1PzESK8FS03PWKMtyl9RhScl59wuHKh2S6nJQo341wkNskxAPeAUHbtWKv6Cz3efIMhKPmV0DUsDGG5hZTocwvlJDmJwkGP4hdlMigMSQUsJajd99IbGhpBUZjLIGUDfcRHAc66hwRrcj4/AO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e2108e-e03b-40b6-deb3-08df3ec04fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2026 00:19:40.4614 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ktXYRPykUE5NOLx2n+C9ypM99p2OHU70CXEcwDmDpVdg50P35No9oK3kvUm00b8GsZjDP7JZnKmGGlGZQTa29DK8AKepF1iyZOo2wbDArk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB9740
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=767f8a997=Alistair.Francis@wdc.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gV2VkLCAyMDI2LTExLTA0IGF0IDAxOjM0ICswODAwLCBXWCBDaGVuIHdyb3RlOg0KPiBUaGlz
IGNoYW5nZSBhZGp1c3RzIHRoZSB0cmFuc2xhdGlvbiBleGl0IG9mIGB2c2V0aXZsaWAuIFdoaWxl
DQo+IHByZXNlcnZpbmcNCj4gdGhlIGV4aXN0aW5nIGhlbHBlciwgc3RhdGUgdXBkYXRlIGZsb3cs
IGFuZCBUQiBib3VuZGFyaWVzLCBpdCB1c2VzDQo+IHRoZQ0KPiBnZW5lcmljIGBnZW5fZ290b190
YigpYCBwYXRoIHRvIHJlZHVjZSB0aGUgb3ZlcmhlYWQgb2YgcmVwZWF0ZWQNCj4gc3VjY2Vzc29y
LVRCDQo+IGxvb2t1cHMuDQo+IA0KPiBgdnNldGl2bGlgIGlzIHVzZWQgdG8gc2V0IHRoZSB2ZWN0
b3IgbGVuZ3RoIGFuZCB0eXBlLCBhbmQgYm90aCBpdHMNCj4gQVZMIGFuZA0KPiB2dHlwZSBlbmNv
ZGluZ3MgYXJlIHByb3ZpZGVkIGJ5IGltbWVkaWF0ZXMuIEdpdmVuIHRoZSBDUFUNCj4gY29uZmln
dXJhdGlvbiBhbmQNCj4gdGhlIHNvdXJjZSBUQiBleGVjdXRpb24gY29udGV4dCwgYWZ0ZXIgdGhp
cyBpbnN0cnVjdGlvbiBjb21wbGV0ZXMNCj4gbm9ybWFsbHksDQo+IHRoZSB2ZWN0b3Igc3RhdGUg
Y2hhbmdlcyByZWxldmFudCB0byBzdWJzZXF1ZW50IHRyYW5zbGF0aW9uIGFyZQ0KPiBkZXRlcm1p
bmlzdGljLiBUaGVyZWZvcmUsIHRoaXMgZXhpdCBpcyBlbGlnaWJsZSBmb3IgZGlyZWN0IFRCDQo+
IGxpbmtpbmcuDQo+IA0KPiBNZWFzdXJlZCBvbiBhbiBBTUQgUnl6ZW4gQUkgOSBIIDM2NSAoeDg2
LTY0KSBob3N0LCB1c2luZyBxZW11LXJpc2N2NjQNCj4gd2l0aCAtY3B1IHJ2NjQsdj10cnVlLHZs
ZW49MTI4LGVsZW49NjQuIEEgUklTQy1WIEdDQyAxNC4yLjAgY2MxIGJ1aWx0DQo+IGZvcg0KPiBy
djY0Z2N2IGNvbXBpbGVzIHRoZSBwYWNrYWdlcyB3aXRoIC1PMiAtZzAgLW1hcmNoPXJ2NjRnY3Yg
LQ0KPiBtYWJpPWxwNjRkLg0KPiBPbmx5IGNjMSBydW5zIHVuZGVyIGVtdWxhdGlvbjsgbWFrZSwg
dGhlIGNvbXBpbGVyIGRyaXZlciwgYXNzZW1ibGVyDQo+IGFuZA0KPiBsaW5rZXIgcnVuIG9uIHRo
ZSBob3N0Lg0KPiANCj4gRWFjaCB2YXJpYW50IGlzIHdhcm1lZCB1cCBvbmNlLCBmb2xsb3dlZCBi
eSB0aHJlZSBwYWlyZWQgY2xlYW4gYnVpbGRzDQo+IGluDQo+IEFCL0JBL0FCIG9yZGVyLCB1c2lu
ZyAtajEgYW5kIGZpeGVkIGhvc3QgQ1BVIGFmZmluaXR5IChDUFUgNykuIE1lZGlhbg0KPiBidWls
ZA0KPiB3YWxsIHRpbWVzIGFyZToNCj4gDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgQmVmb3JlIChzKcKgwqDCoCBBZnRlciAocynCoMKgwqAgV2FsbCB0aW1lIHJlZHVjdGlv
bg0KPiDCoCBMWjQgMS4xMC4wwqDCoMKgwqDCoMKgwqDCoCAxMjUuMDE3wqDCoMKgwqDCoCAxMjMu
MDYwwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxLjU3JQ0KPiDCoCB6bGliIDEu
My4xwqDCoMKgwqDCoMKgwqDCoMKgIDcxLjA2MsKgwqDCoMKgwqDCoCA3MC4zMTDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEuMDYlDQo+IA0KPiBJbiBhIHNlcGFyYXRlIHVudGlt
ZWQgdGVzdCwgYSBsb29wIGV4ZWN1dGVzIHR3byB2c2V0aXZsaSBpbnN0cnVjdGlvbnMNCj4gcGVy
DQo+IGl0ZXJhdGlvbiBmb3IgMzcgaXRlcmF0aW9ucy4gSG9zdC1zaWRlIEdEQiBlbnRyeSBicmVh
a3BvaW50cyBzaG93DQo+IHRoYXQNCj4gaGVscGVyX2xvb2t1cF90Yl9wdHIoKSBlbnRyaWVzIGF0
IHRoZSB0d28gc3VjY2Vzc29yIFBDcyBmYWxsIGZyb20gNzQNCj4gdG8gMC4NCj4gVGhlIGd1ZXN0
IHN0aWxsIGV4ZWN1dGVzIDc0IHZzZXRpdmxpIGluc3RydWN0aW9ucy4gSW5pdGlhbCBUQg0KPiBk
aXNwYXRjaCBhbmQNCj4gbGluayBlc3RhYmxpc2htZW50IHN0aWxsIG9jY3VyIHRocm91Z2ggdGhl
IG5vcm1hbCBkaXNwYXRjaGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV1ggQ2hlbiA8d3hjaGVu
MDkxM0BnbWFpbC5jb20+DQoNClRoYW5rcyENCg0KQXBwbGllZCB0byByaXNjdi10by1hcHBseS5u
ZXh0DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5z
L3RyYW5zX3J2di5jLmluYyB8IDMgKy0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cv
aW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCj4gYi90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJh
bnMvdHJhbnNfcnZ2LmMuaW5jDQo+IGluZGV4DQo+IGEyMmUyY2FlNmNlOGU1YTA1NWMxMDZmYjc2
YzMwNWM5MmFjNTNkM2MuLmIyOTljODJkN2EyOTA1NzQzM2UyODBiNDliNQ0KPiAyMjBlNmFkNzE0
OThmIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJhbnMvdHJhbnNfcnZ2
LmMuaW5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5p
bmMNCj4gQEAgLTIzNCw4ICsyMzQsNyBAQCBzdGF0aWMgYm9vbCBkb192c2V0aXZsaShEaXNhc0Nv
bnRleHQgKnMsIGludCByZCwNCj4gVENHdiBzMSwgVENHdiBzMikNCj4gwqDCoMKgwqAgZ2VuX2hl
bHBlcl92c2V0dmwoZHN0LCB0Y2dfZW52LCBzMSwgczIsIHRjZ19jb25zdGFudF90bCgwKSk7DQo+
IMKgwqDCoMKgIGdlbl9zZXRfZ3ByKHMsIHJkLCBkc3QpOw0KPiDCoMKgwqDCoCBmaW5hbGl6ZV9y
dnZfaW5zdChzKTsNCj4gLcKgwqDCoCBnZW5fdXBkYXRlX3BjKHMsIHMtPmN1cl9pbnNuX2xlbik7
DQo+IC3CoMKgwqAgbG9va3VwX2FuZF9nb3RvX3B0cihzKTsNCj4gK8KgwqDCoCBnZW5fZ290b190
YihzLCAwLCBzLT5jdXJfaW5zbl9sZW4pOw0KPiDCoMKgwqDCoCBzLT5iYXNlLmlzX2ptcCA9IERJ
U0FTX05PUkVUVVJOOw0KPiDCoA0KPiDCoMKgwqDCoCByZXR1cm4gdHJ1ZTsNCj4gDQo+IC0tLQ0K
PiBiYXNlLWNvbW1pdDogZDczMTQ5MjgzMjA1NjQ1NjI1YmZhOWZlMDI5Y2ZiNjhlNGM0YTlhZQ0K
PiBjaGFuZ2UtaWQ6IDIwMjYxMTA0LXJlc2VhcmNoLXZzZXRpdmxpLWRpcmVjdC1jaGFpbi0yMDI2
MTEwMy0NCj4gNjk1MzZmMDdiZTM3DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo=

