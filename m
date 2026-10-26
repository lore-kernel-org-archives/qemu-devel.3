Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B691606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=C0SI3+CC;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=kaQEUPus
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL8gk-0007QX-2D; Sun, 25 Oct 2026 20:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xL8gh-0007Q6-QE; Sun, 25 Oct 2026 20:35:43 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=752564754=Alistair.Francis@wdc.com>)
 id 1xL8gf-0000X8-J0; Sun, 25 Oct 2026 20:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1792974941; x=1824510941;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=zXF6brKyn/IhL8Dzn0HSP3xIm0LHRULY08Im0XYfn3g=;
 b=C0SI3+CCMhmQZAiGdSuMCrXRIzfL+pg+CrWaaRsb77uIUOxcfY8cGwSm
 EY5iqGIUl8hkFPo+v3L8SKMb6nazDtRtTq/MRsFcRaQ6B92W2RY7VOT4k
 sDyS844KYvz7ckayWRSNCAkgdb5mxMlrezVDrhJSnMBV/x0px4EMj/KsW
 PIuZ7bFD/DrAEA0IDYjpIjn0MbwYJWjy2Yt3YvNJGvOll1QhN46f2HrpM
 Vh71fh8EWgxcHTiCOpyrwb7y3wYOn4Ibj+dEi0OGi8OJfsnGwp9hv3Q+3
 AkSG7wxefI9TT1BCYWEZOeWpbBlJedX5wbc3hN6KJcjPD/NADD6bKQzFV g==;
X-CSE-ConnectionGUID: M0VEGkTDTRu/uttP70Kbxw==
X-CSE-MsgGUID: Odw/f0TNSS2b6X1wWDmtjQ==
X-IronPort-AV: E=Sophos;i="6.27,178,1786982400"; d="scan'208";a="158011861"
Received: from mail-northcentralusazon11013071.outbound.protection.outlook.com
 (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.71])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Oct 2026 08:35:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za8boWWxwuCwWJBOtgMVC+UHST7G7IvRQ+10+GEOXGbxOKb+sBZFmOK/QlorSExVwerLj4pgqBzrPQcOlv6ET3pfMfnlsj1y7nnf3UuyRfGAn1esO30RClMl4K7J5XNVHVSRTjN9DCGytmLyJfwvakWpSRv0PE7buGKPXx2QN/5Y21lBbZJkPVCTfDmm852hoEPK7sqxGJITvnAh2ajfGO6y8qPyqOgxHP+6cjYRMUWPOr3zPdhEETFuqmRCRtK52ScNapw1845csnClDrqwCrRMhiy2QuMOOJkY9F3+E8Xf0MiO7vVdw3kY/LMW9iWSgMkFr4blwP+TwWXfDOau6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXF6brKyn/IhL8Dzn0HSP3xIm0LHRULY08Im0XYfn3g=;
 b=amKUryJ9ZeTeY3yAF640TGOSSbEiB4rur0JZOMuoRTr5TBslyRRs4U54937Ofh9elmtUoiHs8iD2G30E8b0crIw7wuySRoZoIfskl46YjVOzEsvGwvreCseN4zrPoheYbvzEBcGCPj4T/Q7z5mMpDgSHNZWDdfOQZOZBiWmBD/gHswuJ6RchS9fAeIS67h3IhnFECAKW5qBf7zirwRFw/NeoF33f/Dn/ACXcD1qy4DxeaDhabGFv8eU+ZTSxwxwtXJwCib/SWTkV/gm0ysEvVO0uKW9jAnvKbCOAPzG5O901btybewQ8xc5B4iTJpr9HGMsV01oAZZlla+wG+kvByA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXF6brKyn/IhL8Dzn0HSP3xIm0LHRULY08Im0XYfn3g=;
 b=kaQEUPusDxD6xqmTE/EFdtHwQopKTiIM18BEqmzXewI41w9V2/szekNJVgP26aIBubB3a6jwNN++Ce2mg7bbRPdIbu+PuQHCLq+b6c2Duk9LSAAxE8EdACtj2rObwk4gycgDI8KPEGnQraUmfp7PK+gmGEWINDSlzL55oY7vfdU=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH0PR04MB7512.namprd04.prod.outlook.com (2603:10b6:510:53::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 00:35:33 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 00:35:32 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/kvm: Translate MSI addresses through the
 IOMMU
Thread-Topic: [PATCH] target/riscv/kvm: Translate MSI addresses through the
 IOMMU
Thread-Index: AQHdZHpaNue32szAEEKjHeNBppOh+rcO+tqA
Date: Mon, 26 Oct 2026 00:35:32 +0000
Message-ID: <641f3045bef1e36b91cf5249fbe6bf2f32862b6c.camel@wdc.com>
References: <20261025121334.40041-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261025121334.40041-1-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH0PR04MB7512:EE_
x-ms-office365-filtering-correlation-id: 90c34544-29f5-472f-92a5-08df32f90b23
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|23010399003|19092799006|38070700021|11063799006|56012099006|261009223027099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: BofgE13biQe2O6PvS+2TFdeJy0XvBYh0+qvigz3kQhSJ0cZ4y+Sn8l4TSj0cXqwGUz8AqLQMGE27hEajSm3U2Sh34smsS+80xetM9lXS9l7Lht4xKqx3S9LNNz2hFQhb+zOhkKTSKe2qlo0A3VTmOZx9B5O79HECybjIGmj55qoPqoMrVGtBtF59ov2pcOVGztUBj1VJPkk8gU1rMx/7WJnc3dRvVGkK0zQvl85f3petpFM5bOj38PwEUxPrprBkJW1zMGOiOGp//Fw3uE/nwyKxJTQjwO76hMzcGb4eH7DWkv8gNds/5+c8/q0Q20Rp5QqmbIaM/TCrNxjfUT09YwycIFgVTaYt5XRbZM7h1FMSeua5giCXy8lgB/uLk3SCod9vMlPZiLQ0Wq0AQyzju1sInrmjlt/cUtSdowMmeROXegTXdg7cBGUHuGb3zATu5179T9Rp2FYCz/1be9HTRT0TP2xn9L//24wqWlqMQrfSbERexPn/1eTlXYEYZVuuTPEGKyUHuH/C/niJE7FdAiQCqkjQROiSMfFFtpbht0jxoMZ6C/DHKJATpBt0e+cYbtFZpQVD3AZvzuaNB2GQR1liTevxPf09VXlJux6GBMXuilnRb9Oney1cVsj4b7IRxlUE1PsWT8VfveI7tfMh3xkGDLwnBgAL5sVRiBVEWOKQZoYgF6nHhT8QjAiGD8nB4ciNMMgohAMkjYHARz0wbp7ybAtuBz46JVb4M3KBR9I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(23010399003)(19092799006)(38070700021)(11063799006)(56012099006)(261009223027099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkFoeFVsV0F3eVN6MkM3eTd5UXRxTWFkU2M1RDVtMVpTT3VMb0tTOGE2ZDZh?=
 =?utf-8?B?dXRjV2ZDeWpHMjk3TFU3RktSRE1La0JPTmU5M3NPYlpTOHVvUmJqRjRFY1NO?=
 =?utf-8?B?dm1Xd1BRNkNYa05nb1BTOE9EL3JZcVVsWGswNFRXdkZJKy9DUXlMQkdJa2Jh?=
 =?utf-8?B?dTJITVFpcXVjanQ5TmlBT21zZkxIMUU0UURhOVlJdVNLYjNMU0t1ajV0anVE?=
 =?utf-8?B?ZTJGOFRSWFEwdGRRVGRBajJEOFlmcHNTOTg3N0ZBT1JOS1B3R0xYUEppcmk1?=
 =?utf-8?B?THMvQVlDQ244OElEYWNjUEgxaWUwTWhJWTA0L2hXMTJYTnpNNkVxSFBxaGZh?=
 =?utf-8?B?Ym5GYWVMdkFPcEVENWlzNk5MYnRqdGFGTFdqU3N4N2d6KzV0SHp4ZlBMd3Qv?=
 =?utf-8?B?SE02TlkzSlo1MUhUYngyeThFVEN4Zjd5Tmc2OStxTGUxcXVnVEJseXVpajBz?=
 =?utf-8?B?MDlQZUFjWG9iQ1ZjUHV2SittbjV2TWNjMG9LR0pmSytsZzFkYWc5Z1YrK0pi?=
 =?utf-8?B?RGQ0bi90Y1RjOFJFUXdvbGVGaXljUzRDdHVNbEM5KzRkUmlIS09JMjRVK3ox?=
 =?utf-8?B?UXNjakpBVTBZT2xoUStmME5wZnZPdVNJNnF3dVB2T1FodmN6WDhiTGhmenA0?=
 =?utf-8?B?ZXBUeVRISEtpTktNRFBraWdaQm5NdzBlK0tISHhaZjhOeUdFa3V2K1BnZEN0?=
 =?utf-8?B?VHladDlOeTEzaitibnprbnZnNm9IUFJRVkVLVUJYOGthamtqWTdaTlVIRFp2?=
 =?utf-8?B?T1B4M0pyNDd2dFhyR3k3NnlIbWFNRCs5MzYySkx4cjJnM2JIYW1GS2c5TjhT?=
 =?utf-8?B?SVVWVmY0ZTJCUDUwQTNMNCtSMnMrZXdNbVRLSWc1cFEydzNWL0FqMFNvZm1Q?=
 =?utf-8?B?R2JSRFcxL2gwZ1ZPYXF5Z0tHUndxRHh4VzV0SWNRMTVmdG9OL3ZSOXZLVm9D?=
 =?utf-8?B?dG94YlVSbFphVHBoQ1NsOFhWVFN0RzEvT2g3QXFRYWdabnhlcHBLc1M0U1BX?=
 =?utf-8?B?S0Z0dExiZlBQNzRBU3FNVmlSbnA4dnZKUTJpWkt1SW1WVDJ0eXc0cFpLaGtN?=
 =?utf-8?B?eFZtK3ErcWpmVi8rbWk4V2dlMVFVeU9veVNzbjRYblhlQ0ZKUDVnenJCK2ZJ?=
 =?utf-8?B?bXZGRXg1OEQ3WTViWFZqTzR1R2t6YndzZTlTUHlXME54eG84UDdUZTVIbVdh?=
 =?utf-8?B?UGpBWUhHN1VaWFNucWRZT0MxeDd6ckNZMXQvSDhqSVRmWDczL2dwNHFHSlV5?=
 =?utf-8?B?TkkrcTZRWTNDOVViVllLMWlJVWhPT2oxemNBR3I0aWtOQlpCbkw5OEg5Mm5I?=
 =?utf-8?B?UDhROHJKRHFsNDFDV3ZFU1JpdzJHblR2M0NLeUgyVWdXTFlBZk80VWZ6L0pu?=
 =?utf-8?B?ditHQ2cxbDB0TG5PZWkxZ0FpSFB2Y0U4SkpNNU9Kd1Zsd2JWc0w0M3o4WUFC?=
 =?utf-8?B?UHE3T00zZXFVZmkzYjc5ZnRiZmpPZ215Ryt6bFhDbTNoRlRrSzcwdW9sOWw5?=
 =?utf-8?B?aVhPYzdKVk5WWUpzVktJRWNMNTdoVWllSkFFUGRIVkkrQUZjUTF5dFJOQ091?=
 =?utf-8?B?QkJOMTJRc1ZtMTBWRlYraHhMT0RMN3VQaWdaYmhnSG1OMUlwdTBEMUFjb1Fz?=
 =?utf-8?B?T0xiMzlkb0h4b2ZoQ1JHeFpHOHltNVY3L1cxSklqUmhNQVlhM3RDVDA2VnJ0?=
 =?utf-8?B?TW5oMnU1NmhYekl3eFV5amV4ZUd6Smp3bFZpY0FPV05oeGNJVFVPbEhjMFNX?=
 =?utf-8?B?YWlGMlp6Z0lsbEFBU0xISjJlei9sSm0yK0p6aVBKT0JCazZnc0lSNW5JVzRS?=
 =?utf-8?B?UC9MbTRKT0RZaU56QmZKTGdNNkRKVzhHdEFIa0ZDMGRseG1lMUJRcXBHa000?=
 =?utf-8?B?UWk4eDVYNlhUdWJNWjBEc2tWOHBEckpKbzZienBhSHFPTkhORWJrQURwNmQ0?=
 =?utf-8?B?SXpmZG90ZC9CNzhjMEVnb0s5dkppUnJJQ2xLSkJKbHFudDM0VUZWSUc3bHZw?=
 =?utf-8?B?K1k3bHk5L3JmeWcyc3JZblNyYyt2Q2lrRWVaWTBNcEFzcmNVZDZBelpPWWZE?=
 =?utf-8?B?MzVTVVVpTmtleFA1bkU1MG11cS9CcE9XNkI4eC9OWnR2RW96QlFhekpXSXZM?=
 =?utf-8?B?bmFJbTFzeGJIV2h3Q0JMNjR2dXJ4K1RTaUVjendxRlIvREQvQ0dWSzMvVUVz?=
 =?utf-8?B?cnlYOEdmTTlheDI2c0V6WkFmWmEzY2tSVTlPQTBoVFVyRmJJa3ppOHRTQWdu?=
 =?utf-8?B?YzZHRndaMWQ3eXdHcXVLNG5kRVhQY0gyVXVKWnJjM3laMkhHaExEN0pyTzd3?=
 =?utf-8?B?RWViSmozTmQ4MUhXRXZlNE1VRjZEODUway9jUlIvajdLakpuR3JDMGZ4MU9Z?=
 =?utf-8?Q?P6H87pSmrJDN9WxhoXQH7LEUz7oXEZ9vXXTbmkGEelLZe?=
x-ms-exchange-antispam-messagedata-1: baJ0Xu1DLv65H2g8/dfYBWUxlh+j+AfvxZU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B15ACBF6E458F47AE21A8504F387165@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Xv/G4hRf4pUTtNfZ8jE1st9qC0xFOTx9xRMl9O1kaJE0R0d4rHOJp5E9kfZ2zif7fZ1BrEG1Jd06nHuQYESgeLiE9hJLoQRk0XoSkXtTSV2lM7lcQvyaWgTMOdMshrXMPH7S6CjeJ5qz5+nLWJb69C2OxM89j67SUKG8K4Djw5Qh7XLBKeD7LR39u1J8hMdnDDLjGs01BLnCoj0feeuush7LLjO+oMK1rBuLHrD643DqZ1FIp6Zr2b706+2Tjnh4igUCNY+ptAXI+3vZdIAVhyXR1h2iCDVYTWPqKTk2/qXJCkAM6tLkTjj2hX7sMhSpvxGP9FcCu27c3cVQPKf7Qw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X4DlXiWRXfcY6YL00xq9dOzhdkGOioAEhImAm7SEYU1Rv3Z0GiJ2P3K4TYvVr7h1gPYXibaH7JHpP9nq7LAl4THK3WmMCV2Vy2De5z4w0KqM5rYBlBhCgXlxN9Ngq1W2xP9IZVkmTmEFfS7vicgJuHhNDEqESDqG5nnCvXY0dM9RoOA2AEKqhy4sFl6B8r2QiNsT/cp+8x8dCSJghDihxbpPrgMcEWNCpe80FSI6kTXLqDHgtEb2HAXCy58fZs6OMjPSmHip2yfGVt/deGucr2YxNvUAp/NG8blEo/edfJp58QfvlojV3H8MHonm9IyNOGjUTVGJUKeAf+j5MP5eAamMZc+UaEePWbbS8u/OaYT/8dP0NVagnNDjraRPEaNXXgeUCsGCwDWQ5G8+N/ms+JRANTVclBR6fcVUPLvP0LsflLXmhIenucgtN9K1irWCCB55CusYtnfBd6ELLNSbDut74KslNlldspdSkR2HNVBua/r0VGGmCe2LVO3TeK64ijCKSwZzMgFs0oC6AWkdJG37o5KsQ6kdR3t3QrssTvnABxMOiRd8nuX/mAlPb/tPLdsxohTWLvnJTtMelAjDHX3On9LFyAFscRnp8HtAgLqgwEf0sQwDPyZkEhdEMk63
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c34544-29f5-472f-92a5-08df32f90b23
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 00:35:32.4597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGnDrNOKMK5yWNagcOw21RyLNNjDssMFvMrHWdI5juEfzegvHxsgDQ8zhs2tzpQD2ZhfBypD6cSAaR1G5T64bhw7eiuXgvRDyInwCToe8w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7512
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=752564754=Alistair.Francis@wdc.com;
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

T24gU3VuLCAyMDI2LTEwLTI1IGF0IDIwOjEzICswODAwLCBUYW4gQ2hpIHdyb3RlOg0KPiBLVk0g
aXJxZmQgYnlwYXNzZXMgdGhlIFBDSSBkZXZpY2UncyBJT01NVSBBZGRyZXNzU3BhY2UsIHNvIE1T
SQ0KPiBhZGRyZXNzZXMgcmVxdWlyaW5nIHRyYW5zbGF0aW9uIG1heSBmYWlsIHRvIHJlYWNoIHRo
ZSBndWVzdCBJTVNJQy4NCj4gDQo+IFRyYW5zbGF0ZSBNU0kgYWRkcmVzc2VzIHRocm91Z2ggdGhl
IGRldmljZSdzIElPTU1VIEFkZHJlc3NTcGFjZQ0KPiB3aGVuIHNldHRpbmcgdXAgS1ZNIHJvdXRl
cy4gT25seSBkaXJlY3QgSU1TSUMgbWFwcGluZ3MgYXJlDQo+IHN1cHBvcnRlZDsgQmFzaWMgTVNJ
IFBURSBhbmQgTVJJRiByZW1hcHBpbmcgYXJlIG5vdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRh
biBDaGkgPHRhbmNoaTI1QG1haWxzLnVjYXMuYWMuY24+DQoNCk15IExMTSByZXZpZXcgc3lzdGVt
IHNhaWQgdGhpczoNCg0KLSBbTUVESVVNXSB0YXJnZXQvcmlzY3Y6IGt2bS1jcHUuYyBrdm1fYXJj
aF9maXh1cF9tc2lfcm91dGUgY2FsbHMNCiAgcGNpX2RldmljZV9pb21tdV9hZGRyZXNzX3NwYWNl
LCBicmVha2luZyBLVk0gYnVpbGRzIHdpdGhvdXQgUENJLiBUaGUNCiAgc3ltYm9sIGlzIGRlZmlu
ZWQgb25seSBpbiBody9wY2kvcGNpLmMsIGJ1aWx0IHVuZGVyIENPTkZJR19QQ0ksIGFuZA0KICBo
dy9wY2kvcGNpLXN0dWIuYyBwcm92aWRlcyBubyBzdHViIGZvciBpdCwgd2hpbGUgdGFyZ2V0L3Jp
c2N2L0tjb25maWcNCiAgKFJJU0NWMzIvUklTQ1Y2NCkgaGFzIG5vIFBDSSBzZWxlY3QuIFBDSS1s
ZXNzIFJJU0MtViBtYWNoaW5lcyAoU1BJS0UsDQogIFNJRklWRV9FLCBTSUZJVkVfVSwgT1BFTlRJ
VEFOLCBTSEFLVElfQywgTUlDUk9DSElQX1BGU09DKSBidWlsZCBrdm0tDQpjcHUubw0KICB3aXRo
IENPTkZJR19LVk09eSBhbmQgQ09ORklHX1BDST1uIGFuZCBoaXQgYW4gdW5kZWZpbmVkIHJlZmVy
ZW5jZSBhdA0KICBsaW5rIHRpbWUuIFRoaXMgaXMgZXhhY3RseSB3aGF0IHRhcmdldC9hcm0vS2Nv
bmZpZyBhbmQNCiAgdGFyZ2V0L2kzODYvS2NvbmZpZyBwcmV2ZW50IHdpdGggc2VsZWN0IFBDSSBp
ZiBLVk0gYW5kIHRoZSBjb21tZW50DQogIGt2bV9hcmNoX2ZpeHVwX21zaV9yb3V0ZSgpIG5lZWRz
IHRvIGFjY2VzcyBQQ0lEZXZpY2UsIGNpdGluZyB0aGUgdmVyeQ0KICBBUk0gaW1wbGVtZW50YXRp
b24gdGhpcyBwYXRjaCBtb2RlbHMgaXRzZWxmIG9uLiBBZGQgc2VsZWN0IFBDSSBpZiBLVk0NCiAg
dG8gdGFyZ2V0L3Jpc2N2L0tjb25maWcgb3IgYWRkIGEgcGNpLXN0dWIuYyBzdHViLg0KDQotIFtM
T1ddIHRhcmdldC9yaXNjdjogaW4ga3ZtLWNwdS5jIGt2bV9hcmNoX2ZpeHVwX21zaV9yb3V0ZSwg
YWxsIHRocmVlDQogIGZhaWx1cmUgcGF0aHMgKGFkZHJlc3Nfc3BhY2VfdHJhbnNsYXRlIG1pc3Ms
IG5vbi1JTVNJQyB0YXJnZXQgc3VjaCBhcw0KICB0aGUgSU9NTVUgTVNJIHRyYXAgcmVnaW9uLCBt
ZW1vcnlfcmVnaW9uX2ZpbmQgZmFpbHVyZSkgcmV0dXJuIDEgd2l0aA0KICBubyB0cmFjZSBwb2lu
dCBvciBkaWFnbm9zdGljLCB3aGlsZSB0aGUgc3VjY2VzcyBwYXRoIGVtaXRzDQogIHRyYWNlX2t2
bV9yaXNjdl9maXh1cF9tc2lfcm91dGUuIEZ1bmN0aW9uYWxseSB0aGlzIGlzIGEgZ3JhY2VmdWwN
CiAgZGVncmFkYXRpb24gdG8gdGhlIHVzZXJzcGFjZSBNU0kgcGF0aCB3aGVyZSB0aGUgZW11bGF0
ZWQgcmlzY3YtaW9tbXUNCiAgaGFuZGxlcyBCQVNJQy9NUklGLCBidXQgaW4gdGhlIGZpZWxkIGFu
IG9wZXJhdG9yIGNhbm5vdCB0ZWxsIHdoZXRoZXINCiAgS1ZNIE1TSSByb3V0aW5nIHdhcyBzZXQg
dXAgb3Igc2lsZW50bHkgcmVmdXNlZC4gQWxzbywgdGhlIGNvbW1pdA0KICBtZXNzYWdlIHNheXMg
QmFzaWMgTVNJIFBURSBhbmQgTVJJRiByZW1hcHBpbmcgYXJlIG5vdCBzdXBwb3J0ZWQNCiAgd2l0
aG91dCBzdGF0aW5nIHRob3NlIGNvbmZpZ3VyYXRpb25zIGtlZXAgd29ya2luZyB2aWEgdGhlIHBy
ZS0NCmV4aXN0aW5nDQogIHVzZXJzcGFjZSBNU0kgcGF0aCwgc28gYSByZXZpZXdlciBjYW5ub3Qg
dGVsbCB3aGV0aGVyIHRoaXMgaXMgYQ0KICByZWdyZXNzaW9uIG9yIGEgZGVncmFkYXRpb24uIEFk
ZCBhIHRyYWNlIHBvaW50IG9uIHRoZSBmYWlsdXJlIHBhdGhzDQogIGFuZCBzdGF0ZSB0aGUgZmFs
bGJhY2sgZXhwbGljaXRseSBpbiB0aGUgY29tbWl0IG1lc3NhZ2UuDQoNClNvIGl0IHdvdWxkIGJl
IHdvcnRoIG1ha2luZyBzdXJlIGl0IGJ1aWxkcyB3aXRob3V0IFBDSSBhbmQgbWF5YmUgYWRkDQpz
b21lIGxvZ3M/DQoNCkFsaXN0YWlyDQoNCj4gLS0tDQo+IA0KPiBUaGUgQWRkcmVzc1NwYWNlIHRy
YW5zbGF0aW9uIGZvbGxvd3MgdGhlIGV4aXN0aW5nDQo+IGt2bV9hcmNoX2ZpeHVwX21zaV9yb3V0
ZSgpIGltcGxlbWVudGF0aW9uIG9uIEFSTS4NCj4gDQo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm0t
Y3B1LmMgfCA0NQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDC
oHRhcmdldC9yaXNjdi90cmFjZS1ldmVudHPCoCB8wqAgMyArKysNCj4gwqAyIGZpbGVzIGNoYW5n
ZWQsIDQ4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3Yva3Zt
L2t2bS1jcHUuYyBiL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jDQo+IGluZGV4IDQ1YWQ1ZTE1
MjUuLjU2NWNkZWM5ZDIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5j
DQo+ICsrKyBiL3RhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5jDQo+IEBAIC0xNTA3LDYgKzE1MDcs
NTEgQEAgaW50IGt2bV9hcmNoX3JlbGVhc2VfdmlycV9wb3N0KGludCB2aXJxKQ0KPiDCoGludCBr
dm1fYXJjaF9maXh1cF9tc2lfcm91dGUoc3RydWN0IGt2bV9pcnFfcm91dGluZ19lbnRyeSAqcm91
dGUsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgdWludDY0X3QgYWRkcmVzcywgdWludDMyX3QgZGF0YSwNCj4gUENJRGV2aWNlICpk
ZXYpDQo+IMKgew0KPiArwqDCoMKgIEFkZHJlc3NTcGFjZSAqYXM7DQo+ICvCoMKgwqAgaHdhZGRy
IHhsYXQsIGxlbiA9IHNpemVvZih1aW50MzJfdCksIHRyYW5zbGF0ZWQ7DQo+ICvCoMKgwqAgTWVt
b3J5UmVnaW9uU2VjdGlvbiBzZWN0aW9uOw0KPiArwqDCoMKgIE1lbW9yeVJlZ2lvbiAqbXI7DQo+
ICvCoMKgwqAgT2JqZWN0ICpvd25lcjsNCj4gKw0KPiArwqDCoMKgIGlmICghZGV2KSB7DQo+ICvC
oMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gK8KgwqDCoCB9DQo+ICsNCj4gK8KgwqDCoCBhcyA9
IHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShkZXYpOw0KPiArwqDCoMKgIGlmIChhcyA9
PSAmYWRkcmVzc19zcGFjZV9tZW1vcnkpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0K
PiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIFJDVV9SRUFEX0xPQ0tfR1VBUkQoKTsNCj4gKw0K
PiArwqDCoMKgIG1yID0gYWRkcmVzc19zcGFjZV90cmFuc2xhdGUoYXMsIGFkZHJlc3MsICZ4bGF0
LCAmbGVuLCB0cnVlLA0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKTsNCj4gKw0K
PiArwqDCoMKgIGlmICghbXIpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAxOw0KPiArwqDC
oMKgIH0NCj4gKw0KPiArwqDCoMKgIC8qDQo+ICvCoMKgwqDCoCAqIE9ubHkgZGlyZWN0IElNU0lD
IHdyaXRlcyBjYW4gYmUgcmVwcmVzZW50ZWQgYnkgYSBLVk0gTVNJDQo+IHJvdXRlLg0KPiArwqDC
oMKgwqAgKiBNU0kgcGFnZS10YWJsZSB0cmFuc2xhdGlvbnMgaW5zdGVhZCB0YXJnZXQgdGhlIFJJ
U0MtViBJT01NVQ0KPiB0cmFwDQo+ICvCoMKgwqDCoCAqIHJlZ2lvbiwgd2hpY2ggcmVxdWlyZXMg
ZnVydGhlciBCQVNJQy9NUklGIHByb2Nlc3NpbmcuDQo+ICvCoMKgwqDCoCAqLw0KPiArwqDCoMKg
IG93bmVyID0gbWVtb3J5X3JlZ2lvbl9vd25lcihtcik7DQo+ICvCoMKgwqAgaWYgKCFvd25lciB8
fCAhb2JqZWN0X2R5bmFtaWNfY2FzdChvd25lciwgVFlQRV9SSVNDVl9JTVNJQykpIHsNCj4gK8Kg
wqDCoMKgwqDCoMKgIHJldHVybiAxOw0KPiArwqDCoMKgIH0NCj4gKw0KPiArwqDCoMKgIHNlY3Rp
b24gPSBtZW1vcnlfcmVnaW9uX2ZpbmQobXIsIHhsYXQsIDEpOw0KPiArwqDCoMKgIGlmICghc2Vj
dGlvbi5tcikgew0KPiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDE7DQo+ICvCoMKgwqAgfQ0KPiAr
DQo+ICvCoMKgwqAgdHJhbnNsYXRlZCA9IHNlY3Rpb24ub2Zmc2V0X3dpdGhpbl9hZGRyZXNzX3Nw
YWNlOw0KPiArwqDCoMKgIG1lbW9yeV9yZWdpb25fdW5yZWYoc2VjdGlvbi5tcik7DQo+ICsNCj4g
K8KgwqDCoCByb3V0ZS0+dS5tc2kuYWRkcmVzc19sbyA9IHRyYW5zbGF0ZWQ7DQo+ICvCoMKgwqAg
cm91dGUtPnUubXNpLmFkZHJlc3NfaGkgPSB0cmFuc2xhdGVkID4+IDMyOw0KPiArwqDCoMKgIHRy
YWNlX2t2bV9yaXNjdl9maXh1cF9tc2lfcm91dGUoYWRkcmVzcywgdHJhbnNsYXRlZCk7DQo+IMKg
wqDCoMKgIHJldHVybiAwOw0KPiDCoH0NCj4gwqANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di90cmFjZS1ldmVudHMgYi90YXJnZXQvcmlzY3YvdHJhY2UtZXZlbnRzDQo+IGluZGV4IDkzODM3
ZjgyYTEuLjU3NjZmYmI0NTcgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90cmFjZS1ldmVu
dHMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L3RyYWNlLWV2ZW50cw0KPiBAQCAtMTIsMyArMTIsNiBA
QCBtc2VjY2ZnX2Nzcl93cml0ZSh1aW50NjRfdCBtaGFydGlkLCB1aW50NjRfdCB2YWwpDQo+ICJo
YXJ0ICUiIFBSSXU2NCAiOiB3cml0ZSBtc2VjYw0KPiDCoA0KPiDCoCMgb3BfaGVscGVyLmMNCj4g
wqByaXNjdl9leGNlcHRpb24odWludDMyX3QgZXhjZXB0aW9uLCBjb25zdCBjaGFyICpkZXNjLCB1
aW50NjRfdCBlcGMpDQo+ICIldSAoJXMpIG9uIGVwYyAweCUiUFJJeDY0IiINCj4gKw0KPiArIyBr
dm0tY3B1LmMNCj4gK2t2bV9yaXNjdl9maXh1cF9tc2lfcm91dGUodWludDY0X3QgaW92YSwgdWlu
dDY0X3QgZ3BhKSAiTVNJIGlvdmEgPQ0KPiAweCUiUFJJeDY0IiBpcyB0cmFuc2xhdGVkIGludG8g
MHglIlBSSXg2NA0K

