Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64F606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=KbQ4ogiv;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=bHQscCzH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJiwE-0007BQ-K0; Wed, 21 Oct 2026 22:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiwC-0007Av-UZ; Wed, 21 Oct 2026 22:53:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=748e7da1e=Alistair.Francis@wdc.com>)
 id 1xJiwB-0005r3-0q; Wed, 21 Oct 2026 22:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792637630; x=1824173630;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=6IJoC4c1pFsrAWeP9ezJhJim7S1f1ABtoQ78PyvZ6dE=;
 b=KbQ4ogivs2duaQgef7+qiDyoKIZyZN4RYJWgw+ZXFc2YQAwRGUhbI6Qb
 qWDhkSDS0Xi4xzvrrK0MCQkgFnw29YCmjOCRrouicpErEkqewoQpwwYPa
 cFlT/2328xrYT2nj1pGjHBX9J/medmbcVFyPIKEam8uVAHbCNd5Rtl6wu
 5eT73e2fq4BcWIx0bJRNh4hn2Y/k9o0VyEadkxgNxsFhsnr34pyYaNKWN
 ltoIjump0qKdmGApQmR7DAKfMijkjVN7PrusoFJx/Wh6lElP8d2Z+Z6bJ
 ++b+78iZSKt199dTa0LwkINoq2g7Q+7meyDOx2BwRpanWLdySLZ2cCHbS g==;
X-CSE-ConnectionGUID: PwHhe8klQBi6ULJJqeGRcg==
X-CSE-MsgGUID: FJ438YTUQKaPJyhfOpsdeA==
X-IronPort-AV: E=Sophos;i="6.27,171,1786982400"; d="scan'208";a="157737482"
Received: from mail-eastusazon11011026.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.26])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Oct 2026 10:53:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qh8aNPglVi8njGivPPfKIBND3JKINWDQLBN/xxAUFQ3u9iOdXV8FzqzxUa3E1sYyQJSpJIR8aziZTOTda4rmgT54TPuf5Q0DsFO5EFmvRzlqanUkp4O7Io33NvZU3DQdjit086sWQ8au6EzDro9+ILy/+1fcvpNgbyS6p/SF1YEc+qkqjdj0Qb6roNrb1g4XeCaqTr5lHgyU6gJL8v3QF6Uh0tv27thn4jpc2Cebh1U80bFzt5kE8TfnNEcjLfqVlGrBCIVLKWOWgrjj9aQhBYfYMVaK+pVErF8IixRV00x7VVATPd5X5pU7bDkIMYGaIJDr2fjYOWBh4O3QC1LiJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IJoC4c1pFsrAWeP9ezJhJim7S1f1ABtoQ78PyvZ6dE=;
 b=Y6zGdNSUxSN85Ow5KBSfm4o1owPALUOL2dkSWo1KtghmOY26ChPJ94/w1CDHKtgrmVYASUi3OkVde2MmJrSxk1+uNnc9wddEUzIpeMvU8Za/gGHKXlYkqBdyYSym0sKGvFkNhCRgM2sqtmpS+kUiO+aEeD31gGOgAkSUdQRvTBMyWygr9Mt2bE+Hn/YNgqnCYZXKRQvYvjDPO6jmiEGbmlVVBdBwUTxffXQ6RBYTRFTIIRgwLhp0hZfLu9ggv/STH68FqYvXeJ4GvoFEzVONszNklQnTqH3jhvceYDpwq0lxmkcXigeTgbEfddp0pUspUBPQFfQQydygsThxors7Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IJoC4c1pFsrAWeP9ezJhJim7S1f1ABtoQ78PyvZ6dE=;
 b=bHQscCzHKEkx1y7sCoeGuuu3G+XwjgtoCyP4tJ518njHdLec47RWrDkCFYLqWPoKKA9Uj4a48ocOsTljxfmkHA+QOznqVWnGNWD2JxR23nfv4acoPzltspup+VLoMDalwPvRVxaph2f7AZKHjYyDiZFsg6nmXWoyrwtx7U1zyvQ=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6437.namprd04.prod.outlook.com (2603:10b6:a03:1e4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 02:53:43 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0522.017; Thu, 22 Oct 2026
 02:53:42 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "rick@sloservers.com" <rick@sloservers.com>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
Thread-Topic: [PATCH] target/riscv: Use TSO barriers instead of full barriers
 for Ztso
Thread-Index: AQHdUnSo+fwfToMizkip1Cgd4ZK4rLcI/C2A
Date: Thu, 22 Oct 2026 02:53:42 +0000
Message-ID: <13b7fa89e7b101cdbf71cf524abe319821b2b1ab.camel@wdc.com>
References: <d6db9f89-36d6-436d-a915-407cd28e1778@sloservers.com>
In-Reply-To: <d6db9f89-36d6-436d-a915-407cd28e1778@sloservers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6437:EE_
x-ms-office365-filtering-correlation-id: 016805c9-6a59-4d99-66f4-08df2fe7aea0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|1800799024|366016|19092799006|18002099003|22082099003|261021123027099003|3023799007|38070700021|11063799006|261009223027099003|10067099003|261021121427099003|56012099006;
x-microsoft-antispam-message-info: hs+vBeGVtEn6RmzQtC8uMcwna1aw7+Zb7lyXlIOWx3H1L4jKB4GqvtgNjgt6DmvzsPYvFyFCEruZ1ADP+Xy8M1CHomwzJg0GArPaXUgzjXOsgepXSyRj7AitK4u+G/ckzghxlZiT/IHamZea2/WnfvaOB600hy7fQiy7YcQbqNPDSq5EhygaxP6oeJpzUSe+dsCmAUDMYoq4ezwcR/iIffLNrjFbTD9/rz7dHcWJGgIrFeI/uFluBzAsiLxvSDlLmp7XtY4GfwxWLLghcIiFuY+PoF5QzspbLV+TNc12mfBLFxADJZNQLCJHmnT6GbYq9UPQXoiEUcvND0tGAkT/m7rVI4KjE0esbTMR3p4xlAaF3Tt/CAAz598ih8I4+j2DvvgqvNXEz3hVFpkOPENMkmAs0FTLWYQKGtMDFMCW65XGHIkbfE7cvTM4+tYuqMWZv0EsyoMti+nlf8m+fVEsu9eiEJOhaumZNavbOAlutB75/9pBmcNW7QE0I//wuqBFgJA4NNO/L5GjSMYMBOvfbFL7ZLct2pl5ifSNEvNgTT4JcnQfSy/ZN1BahC5XbLCF/0src+KAJngMaEB0KVJTz4gS1+NTKAu5lQVNDNN/08MF9FMKv4H9a15vF8E5LF+2jyU5g1yBwwXl32F10ir7pZP+dpyij29oe4fe6FJH60y9kCYs6KuycqibRDe8z7taTkDZW2+GeVqF9w/gKsHwrn4XIaksqxuirlFYM8OMaNk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(1800799024)(366016)(19092799006)(18002099003)(22082099003)(261021123027099003)(3023799007)(38070700021)(11063799006)(261009223027099003)(10067099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmF4T2p0U2JCaXRUVXU4RWd3R0dRZGFsWk9NMDJFL0pPR0dDSExBbmFWbmVR?=
 =?utf-8?B?bHlLZE5RcUxUZEZJVG8vWGRFL3lSS1RXQ1NsZll5dllMWjRtUlFQeG9teE85?=
 =?utf-8?B?YjhRM1FPZ2Y1L0lKd1B4V2JnZC9hamM4bnhKZ0NHK3J4a3FXdDYrbkRIQjhU?=
 =?utf-8?B?MGx5VDYwbUJ2bHo2cWlSekhacFZPdlMrazI1d090VVFQWm1YY0hEMXlzSU5L?=
 =?utf-8?B?bEZqSThJSUtldXpScTZpMFp6eTdpQ1hqMVVvYkllK1QzbVVTWVFwcWZ1Um50?=
 =?utf-8?B?L0E0VUtsR3p4MHdtRzVDOFlLbWRLQ0xKdFlPREE4Q2IzTkxIOTdTbWd5SHhp?=
 =?utf-8?B?MGduUmV1Y25xeHR4TEpxdzhkT2tGUkE5OFRMY3c3Um9XZmlBdTRMaWJHSnh6?=
 =?utf-8?B?ZGsxdE85UTFGZHVjUmg0Z1dDUjl5eVZBNlVpRzlIa09FUEY3cEYxcnNJUFVO?=
 =?utf-8?B?VG5HajlTZWU4M0Jab1RCa0dTdlJJZ29kNWxINmwrb2h2WkZHY1VCekdrS0d6?=
 =?utf-8?B?b0hydndqcXdsczdCRGEzWWZJM2RlaFM1cXRtbjlIK0ViSWRpLzFQaXRMMGZU?=
 =?utf-8?B?Z1E0THIwUGJRVjcxcUxMVStvVGt0dzIxNWxMT3VjSjhSMUpyRzRySGpESlk3?=
 =?utf-8?B?OTBoL3pSQUtVaVVpdHZzaFJHSFNheERlM296MVZmK01YbEtoN05NbmUvVGdU?=
 =?utf-8?B?Rm5tWEdSV0x0bm14eEQ5RWxGV0cwQk5tTlJWUit3Z0VDTUR3ZmpHbFBqRlNs?=
 =?utf-8?B?VS9scG9teGRHakhVTllvSmptM2xkcVArRzd5VWZ1c2hGVFdEeGg2dXFUK2lo?=
 =?utf-8?B?akhvblhBdU95S0F0Q2hGNW5IUXZhUEwwRjZ1Y0hBU0phNDh3NWJNeFJKMmRM?=
 =?utf-8?B?YjRvNVB1VmRtcnJkaHFxS05NeVZlQy95VUFLQ1RQK0RqTjN1WVR3VWlub29P?=
 =?utf-8?B?ZWlNbHFXTVU4K2tTWTFMSjYyM0JWazhoVXU1NFpLeW9KNXRWa1hrQVV2L2xw?=
 =?utf-8?B?aFliU0dhSUZ1WHFBUmNoVDlCaUlTZWhzVldOdXlLdDI5b3pNQXVVSHhIb0Jk?=
 =?utf-8?B?RDdLK05SMGpXMWxoclFDajJXSmF4ZTJOYnBNRk9DTjZaK0pNdFVkdzFDREIz?=
 =?utf-8?B?TG05d1k2ZVVIVGsyd0d5czVJZ1c4ZndBN1hhUmtGYTlvNlUxQnRCVkdzTk9x?=
 =?utf-8?B?V21QeEh6M0xLcDgzSnlMd3ZZNjM3VWlzWDZneDU1SExoT0NMbVdQbUJHcjVZ?=
 =?utf-8?B?bVJaRE0xbSt4QVBRVWRURXpyS1dtZWtWRUNrektRMkdLRVVvNDJsRysyU1FN?=
 =?utf-8?B?ODlJSytHZ2Q4dTFaOFJhanROMDc1UkRpbmJ5OWJFUVkza3dWQ1I0bkpvMi9S?=
 =?utf-8?B?SXpTMmxoYzk4RC9XamhUcC9PTHBOMkxCTjZPb08vc0h6R0NuV0x6ZWF2bnNV?=
 =?utf-8?B?N1N3VXhuWGlLRkVlaDF2WWQwSmQ1TW13VitVTzIwbEJOR3dRQVRMSy9BcWhO?=
 =?utf-8?B?ZnhMYXlkTDI4YkRhcVdKb2h1R25sek1mak54Q2dlOVB4MHhGenFCNERQRWMv?=
 =?utf-8?B?WmdKUjNVbVRVYW5RdGlQRitiRnBiZjI0bzVIbldoWDdLaVdadUtMbVByRjc2?=
 =?utf-8?B?WFFVYWt3dUFIRGlNWUtOV2R0QWo0RGJQV1pBSGYwcTBFWllhM1k3d2V1bG96?=
 =?utf-8?B?djZ6dE9ZSnNtT3oxdnlSc3p5SXpXWldHWmFYemRra2xwQmZ6SWplOUtxV0Jj?=
 =?utf-8?B?VkpjcmhCR1h2VHZUUXpFTi9uZFF3SjIxK1BjNmtyRmRWUHBhRU5JOFBnd2lE?=
 =?utf-8?B?bnRjaXNHZzV4Vmt2dzNhbTl5NldCenFaNXZBRmpBN3ZBWGFiK2pGVjdXdGxh?=
 =?utf-8?B?dndTYjJJM1ZyRFN4MzZKTGp5QUtRb3hCODJrZzJaODc2aHRDdVFGLzlKVWRN?=
 =?utf-8?B?RWU3dnBSdnhzM0FnbFlhMzVYdGVzMk84RUxpREthb3NEb2hWTmtMYXY1dWlt?=
 =?utf-8?B?ZjVvRWNtbkVNWnJDTlkwNCtlbjVPV0RiZy84a2RsWVVXUW83a3lES0dtdWtH?=
 =?utf-8?B?SnRVZTdpdE02dVNYYmFRa0lBN3R4cjV3elRzdTBya1BnSExGT2haK3RrN041?=
 =?utf-8?B?YzdHZVcvREZCdjV2OS9CUjVleWc5VEF5cUtnMHY4SE1zU1hrUFJNSGZvL1VI?=
 =?utf-8?B?RW5DekNQUkd5WnJJYjJpc3dHU0ZMMGxmSHZVV0R5QmJQUDhKTStIa0Q3QXlH?=
 =?utf-8?B?RFkrL3FtczNlZ0Z6RGRMNzFVVjBoZUhRRVVjUkxuL3RqRHIxeTd6NGpaY3Fy?=
 =?utf-8?B?Kzd3SVdzRFNJc0xnQVFnVkR2N1huenFyZE1tV0MwdmJVTnFzRTRGY2FGUG1q?=
 =?utf-8?Q?UbJ/0nK8QE7ubZfhGKioH/MXdsO/0IRt7QYxP99RIiL3n?=
x-ms-exchange-antispam-messagedata-1: ZldSHOWjTRYbVMEQUyW1Wl5HqN6aju7JIq8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B961D1539566740AAF0C391C6832357@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XO+fGjdJKZZPz5nStwQk7Vx4QL7iqHYJ6293F6Ky5/3PyhkQH26Tlmnt7Dj+0DI7ZOandENXKttJ/7nqMyRlVnEcqJoIQRUCUafMBzuo6vJk9PQKX2kjsY4WJ3ByNsE+Rxss/Sa6DHgSYOC6VtKswQBCWfxxhiwrtIZKGibUQfRxIWkRwmYWFSrCsf2jYUamEwufUpzHROpg7GkkQI7CufO9sX9R2gWLhRDMNl3gIti47jmD2f+6Y9teXTqhwzRCp8oo1VaGrr/jfPgWZh3ztDaFpQ3xBRY+W89eaXLH3/TMJMCffuhc1WQZ610+74jhPFQOGvAokN1zoOPzyvFaXA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +i11qmH7o6INI1f71bUK0pIZwh6JiFoPqeMhx/ZbR++WAlJ0R36TtopgkFU7UWbXZeArQ50WBEGeghk/u5tCK3g4VL31ZFrqXAfSlYmpTSZjpkoOSR/0Pno1amEEUYTzhSH1UwLfUzcCqMkgn/i+TBkqU6EZAa6w0zVGHV1oKYaur9vsAlpOWle9SZanM5eWitHTthxIU/u0gqwfNRYJemU+1mekz1hCtZx4IVon7x7nEMpjD1qVTjSo9I2I8URPufVPGzx8huDdkwQXswi362wbKGEDdRB/sU99oDbZZwOZeB1uY9/0D627pZ/RKuRBifIt8z0dtldE1EiI8ZX7f44A/dm2uSST4kmqhE0D3Irq1aUKR0j1t6vplRHo7SYRlEvu4LnBwUHk4RHyZMQ5umEBYbBkRQVxUiRsQUjIZjt0mMA0Z+VCry/5ee4sxgCIlDNZk96rG+knL4AycXrs8fvTqCuXRlMZNbYcXfTcDVfl7doN1sLKW1dz561CYs8zFge1btV0OndNpV+KwegMtqEXKD2Nb48UWAjN490JWBnV+mQmUpRZfRfFFR4y59XWixq3fJhse2vYL8zP7Ds7M6ZvFJy3ipDiZ2KHpgHIoL8nXGsmWpV7o7+6gCBo+QqF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016805c9-6a59-4d99-66f4-08df2fe7aea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2026 02:53:42.3326 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoaVzR9Y+LIeq7OnhpI/wfKsxZr9aAexmCbFl6P+1BX7GnfNBQH9A7r+V/cFZrekCy3lcIXALZ5Trn96ptlVCmR3ZSWMDKcruePdJYka2hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6437
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=748e7da1e=Alistair.Francis@wdc.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gRnJpLCAyMDI2LTEwLTAyIGF0IDA2OjQ3IC0wNzAwLCBSaWNrIFJpY2hhcmQgd3JvdGU6DQo+
IFdpdGggWnRzbywgcGxhaW4gbG9hZHMgYW5kIHN0b3JlcyBmb2xsb3cgUlZUU08sIGJ1dCB0aGUg
YmFycmllcnMNCj4gYXJvdW5kIHRoZW0gdXNlIFRDR19NT19BTEwuwqAgVGhhdCBhbHNvIG9yZGVy
cyBhIHN0b3JlIGJlZm9yZSBhIGxhdGVyDQo+IGxvYWQsIHdoaWNoIFRTTyBkb2Vzbid0IHJlcXVp
cmUsIGFuZCBpcyBleHBlbnNpdmU6IG9uIHg4NiBob3N0cyBpdA0KPiBhZGRzIGEgbG9ja2VkIGlu
c3RydWN0aW9uIGFyb3VuZCBldmVyeSBsb2FkIGFuZCBzdG9yZSBpbiBhDQo+IG11bHRpLXRocmVh
ZGVkIGd1ZXN0Lg0KPiANCj4gVGhlIGJhcnJpZXIgYWZ0ZXIgYSBsb2FkIG5vdyBvbmx5IGtlZXBz
IGxhdGVyIGxvYWRzIGFuZCBzdG9yZXMNCj4gYmVoaW5kIGl0LCBhbmQgdGhlIGJhcnJpZXIgYmVm
b3JlIGEgc3RvcmUgb25seSBrZWVwcyBlYXJsaWVyIGxvYWRzDQo+IGFuZCBzdG9yZXMgYWhlYWQg
b2YgaXQuwqAgVGhhdCBpcyBhbGwgVFNPIG5lZWRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmlj
ayBSaWNoYXJkIDxyaWNrQHNsb3NlcnZlcnMuY29tPg0KDQpUaGFua3MhDQoNCkFwcGxpZWQgdG8g
cmlzY3YtdG8tYXBwbHkubmV4dA0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiBJIGZvdW5kIHRoaXMg
d2hpbGUgbG9va2luZyBpbnRvIHdoeSByaXNjdjY0IGd1ZXN0cyB3ZXJlIHNvIG11Y2gNCj4gc2xv
d2VyIHRoYW4gYWFyY2g2NCBvbmVzIHVuZGVyIGJzZC11c2VyIG9uIEZyZWVCU0QuwqAgVGhlIGRl
ZmF1bHQgLWNwdQ0KPiBtYXggZW5hYmxlcyBadHNvLCBhbmQgdHVybmluZyBpdCBvZmYgd2l0aCB6
dHNvPWZhbHNlIGFjY291bnRlZCBmb3INCj4gbW9zdCBvZiB0aGUgZGlmZmVyZW5jZS4NCj4gDQo+
IE9uIGFuIHg4Ni02NCBob3N0IHRoZSBwYXRjaCBtYWRlIHh6IGFsbW9zdCBmb3VyIHRpbWVzIGZh
c3RlciBhbmQgY3V0DQo+IHRoZSB0aW1lIG9mIGEgY2xhbmcgY29tcGlsZSBieSBhYm91dCAzMCUs
IHRoZSBzYW1lIGFzIHJ1bm5pbmcgd2l0aA0KPiB6dHNvPWZhbHNlLsKgIFRoZSBvdXRwdXQgZGlk
bid0IGNoYW5nZS4NCj4gDQo+IEkgYWxzbyB0ZXN0ZWQgaXQgb24gYSBSYXNwYmVycnkgUGkgM0Ir
LCB3aGljaCBpcyBhcm02NCBhbmQgZG9lc24ndA0KPiBnaXZlIFRTTyBvcmRlcmluZyBpbiBoYXJk
d2FyZSwgdG8gbWFrZSBzdXJlIHRoZSB3ZWFrZXIgYmFycmllcnMgc3RpbGwNCj4gaG9sZCB1cCB0
aGVyZS7CoCBFdmVyeXRoaW5nIHJhbiBjb3JyZWN0bHksIGFuZCB4eiB3YXMgYWJvdXQgMTIlDQo+
IGZhc3Rlci4NCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2aS5j
LmluYyB8IDQgKystLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYu
Yy5pbmMgfCA0ICsrLS0NCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJh
bnMvdHJhbnNfcnZpLmMuaW5jDQo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5z
X3J2aS5jLmluYw0KPiBpbmRleCA0MGI0YzlhYS4uZDMxZTQyOTUgMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydmkuYy5pbmMNCj4gKysrIGIvdGFyZ2V0
L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2aS5jLmluYw0KPiBAQCAtNDI0LDcgKzQyNCw3
IEBAIHN0YXRpYyBib29sIGdlbl9sb2FkKERpc2FzQ29udGV4dCAqY3R4LCBhcmdfbGINCj4gKmEs
IE1lbU9wIG1lbW9wKQ0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKgIGlmIChjdHgtPnp0
c28pIHsNCj4gLcKgwqDCoMKgwqDCoMKgIHRjZ19nZW5fbWIoVENHX01PX0FMTCB8IFRDR19CQVJf
TERBUSk7DQo+ICvCoMKgwqDCoMKgwqDCoCB0Y2dfZ2VuX21iKFRDR19NT19MRF9MRCB8IFRDR19N
T19MRF9TVCB8IFRDR19CQVJfTERBUSk7DQo+IMKgwqDCoMKgIH0NCj4gwqANCj4gwqDCoMKgwqAg
cmV0dXJuIG91dDsNCj4gQEAgLTQ4NSw3ICs0ODUsNyBAQCBzdGF0aWMgYm9vbCBnZW5fc3RvcmVf
dGwoRGlzYXNDb250ZXh0ICpjdHgsDQo+IGFyZ19zYiAqYSwgTWVtT3AgbWVtb3ApDQo+IMKgwqDC
oMKgIFRDR3YgZGF0YSA9IGdldF9ncHIoY3R4LCBhLT5yczIsIEVYVF9OT05FKTsNCj4gwqANCj4g
wqDCoMKgwqAgaWYgKGN0eC0+enRzbykgew0KPiAtwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9tYihU
Q0dfTU9fQUxMIHwgVENHX0JBUl9TVFJMKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHRjZ19nZW5fbWIo
VENHX01PX0xEX1NUIHwgVENHX01PX1NUX1NUIHwgVENHX0JBUl9TVFJMKTsNCj4gwqDCoMKgwqAg
fQ0KPiDCoA0KPiDCoMKgwqDCoCB0Y2dfZ2VuX3FlbXVfc3RfdGwoZGF0YSwgYWRkciwgY3R4LT5t
ZW1faWR4LCBtZW1vcCk7DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvdGNnL2luc25fdHJh
bnMvdHJhbnNfcnZ2LmMuaW5jDQo+IGIvdGFyZ2V0L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5z
X3J2di5jLmluYw0KPiBpbmRleCBhMjJlMmNhZS4uOGMyMWFiODcgMTAwNjQ0DQo+IC0tLSBhL3Rh
cmdldC9yaXNjdi90Y2cvaW5zbl90cmFucy90cmFuc19ydnYuYy5pbmMNCj4gKysrIGIvdGFyZ2V0
L3Jpc2N2L3RjZy9pbnNuX3RyYW5zL3RyYW5zX3J2di5jLmluYw0KPiBAQCAtNzMxLDcgKzczMSw3
IEBAIHN0YXRpYyBib29sIGxkc3RfdXNfdHJhbnModWludDMyX3QgdmQsIHVpbnQzMl90DQo+IHJz
MSwgdWludDMyX3QgZGF0YSwNCj4gwqDCoMKgwqDCoCAqIGFyb3VuZCB0aGUgbG9vcC4NCj4gwqDC
oMKgwqDCoCAqLw0KPiDCoMKgwqDCoCBpZiAoaXNfc3RvcmUgJiYgcy0+enRzbykgew0KPiAtwqDC
oMKgwqDCoMKgwqAgdGNnX2dlbl9tYihUQ0dfTU9fQUxMIHwgVENHX0JBUl9TVFJMKTsNCj4gK8Kg
wqDCoMKgwqDCoMKgIHRjZ19nZW5fbWIoVENHX01PX0xEX1NUIHwgVENHX01PX1NUX1NUIHwgVENH
X0JBUl9TVFJMKTsNCj4gwqDCoMKgwqAgfQ0KPiDCoA0KPiDCoMKgwqDCoCBtYXJrX3ZzX2RpcnR5
KHMpOw0KPiBAQCAtNzM5LDcgKzczOSw3IEBAIHN0YXRpYyBib29sIGxkc3RfdXNfdHJhbnModWlu
dDMyX3QgdmQsIHVpbnQzMl90DQo+IHJzMSwgdWludDMyX3QgZGF0YSwNCj4gwqDCoMKgwqAgZm4o
ZGVzdCwgbWFzaywgYmFzZSwgdGNnX2VudiwgZGVzYyk7DQo+IMKgDQo+IMKgwqDCoMKgIGlmICgh
aXNfc3RvcmUgJiYgcy0+enRzbykgew0KPiAtwqDCoMKgwqDCoMKgwqAgdGNnX2dlbl9tYihUQ0df
TU9fQUxMIHwgVENHX0JBUl9MREFRKTsNCj4gK8KgwqDCoMKgwqDCoMKgIHRjZ19nZW5fbWIoVENH
X01PX0xEX0xEIHwgVENHX01PX0xEX1NUIHwgVENHX0JBUl9MREFRKTsNCj4gwqDCoMKgwqAgfQ0K
PiDCoA0KPiDCoMKgwqDCoCBmaW5hbGl6ZV9ydnZfaW5zdChzKTsNCg==

