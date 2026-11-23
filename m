Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224C0606A32C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 01:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=QJAYFLhn;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=U8NFUdWn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJJE-0003jd-1k; Sun, 22 Nov 2026 20:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJJB-0003iq-Q4; Sun, 22 Nov 2026 20:57:29 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJJA-0000zK-4k; Sun, 22 Nov 2026 20:57:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795399048; x=1826935048;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TrXkJbm1+oJbXJdQx8srD11vZRvW8Wyg0cEnJUbaWHM=;
 b=QJAYFLhnhv0ILCemiin/HUENVW6d1YUMs8Il76g5mWjlijLEx7f5TlJ1
 2X2aFfFbGZTYuH47g4N1VL7+dJiHyJbG8JXmoIj2fdztmH94Bp5I+kegS
 AXXh6q+EVHsrPWW3SOOvR9lob7ma3/StsVMCfXYoJukQ4hdy7ItS0Z4HC
 +HdYgDjZ3PXHVO9oawpmceoig9kuYbB1I6lrjvAluJVji2Xy95JisM7r9
 266qOKwQOq0bR1NosRZL5RBjSZgyLR/pxCtz6he6K6WwHGl0YMG8Bcr3K
 5+YViCRItkLdpOHQ0Sx3TPtsIEovEASbebKHG47o5ydTci52wh/jy0WHQ A==;
X-CSE-ConnectionGUID: 5Ajud8ebTUuq9UbyPHoUHw==
X-CSE-MsgGUID: Mh6jh5qUSS+6DhHBQxR4aA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="157277674"
Received: from mail-northcentralusazon11010071.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.71])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 09:57:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDK7QosbSTGVgGQmlchH9e42vD+SDp9T1/BGiWYU1laO03s1LcoFSXb26NYoP1ODkYUJCXsIFvZuz02IKEWbtky+SxAe9tzSGtGnS9TelG5lw9S7daK5ZVOTNFQyDJC0FkT5ZlZrXtP8/Ic1MXgrVRoElKBEwo4rN9wIWxCu4AyACVpnc/eelFT2zVELL8TYNtWAod5iisQ1wLVF1yAEZY9w7Z9OraRNfQxqeQn4vHZ1itCeTpbETzYeJ6ph9x7NXJ899pyPA/KVMaGUAA5o9/4JFxSkZ2rOcwQl/BF6nVDydgKp9S3CjbOj2X7Lie+zv9eEayOZlHtY7kMmDVvCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrXkJbm1+oJbXJdQx8srD11vZRvW8Wyg0cEnJUbaWHM=;
 b=qPGHnXhZyRNpTPl3NmTGGtfQyrfDvtnYOZHotXhTGSwW0u2Ucl6E4U0r7GkJUXROfrfFszPpyNue3oyqhN2xzUuqwufrGpvF7G+8WZxo3Gl4f2WbaKMARajmTiKDDD2duEW1ZEQ3c7txba8vs9um4W1WNLox3pR54k7tnGLX1jyw29d841lrP7LxWupSSwQnrjS6SMvIKi+tvkeEWmbrCKZy9mRfOXKmx12OTivH+JM/9hbOy1Ry4SJi68Z1UnqnsDUJMGf+gNGXsYyNGhmi0kV/06e/styxACGzDiSeyXKIG4QW81t1qNKLt/oxJ3/om4EAH+5r+S7eItXBsAedZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrXkJbm1+oJbXJdQx8srD11vZRvW8Wyg0cEnJUbaWHM=;
 b=U8NFUdWnbQG//eTZy2oeTZbxswontNJ4tOPd11YBHvQxw/JHjY97zkHYSQU4+/aoR7gCGmjGnWlzVQkLIC4HueKta93CgZKDvi30NYfz9yMNON2Fk8gY9wgaa4tuGZ118KSA3ULPEna7rFVNqZORUm3HYrosMkUOc454YNKKkqY=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BN0PR04MB7919.namprd04.prod.outlook.com (2603:10b6:408:152::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 01:57:24 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 01:57:24 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Thread-Topic: [PATCH] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Thread-Index: AQHdcUzJmkS6rDAkpUKEAjL91VQuMbc6+VyA
Date: Mon, 23 Nov 2026 01:57:24 +0000
Message-ID: <580e6a1337cd69e97cd2ac5a4039fd9cd42b8e94.camel@wdc.com>
References: <20261110195023.20927-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261110195023.20927-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BN0PR04MB7919:EE_
x-ms-office365-filtering-correlation-id: 3bb0500c-c1a8-4ccc-2332-08df49051e42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|10070799003|23010399003|366016|18002099003|22082099003|6133799003|261009223027099003|10067099003|5023799004|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261021135927099003|261022105027099003|38070700021;
x-microsoft-antispam-message-info: PROBfik7o/5qaQw3X9CkghqMabDCLjqP6cd0KzB1MDycx2XcX30AzHEqSOscUYi3hEYFQKUwDXb4isvTSgYLyFUNUBCJU7LMeFHO11AM/DiirCXQgSuS+kUvRfg1haH5fsoVPG5v5JAwQfLpYnNWZfnp4B+Z9PZ7cXB6/VbfAl2X0vq/bqbTxDnUmnhXT7QvymhFL72Et5nBVp50CHSHfwdd6p2h8mlrUksx7EVIdi9sQoDBatHIrWXNsBd/kSTDIZu2+titZS2YnRrTamD1iFeZny+DTRQgTjDftAOBj0yUKFwCbq0Ckcs7R/zr1E1B/6zl8oYV2yXoLY6slD5A1+1E6d7jVVquG9oLN+w5fmKpz7PKQjFz42KyyK1assHuZQlxu6JfCKIcyuycamoIE8Yg57Isi54Ab7/WeB78KyCH2M+McAr/vX3G0wfYGhymtD0Y8XvFQ3NUYWlPxD4jxNOkHgyRtB/PbdcbdGt4Xl5LDeua+gmDJYIwJEDErQxYoOmqj0w/yB7L4gtQ0uyihwcz5x/i3LijElP2IIjs2mfnS0CHA5S4JUrVhvd3yVpvMT4lLVDZ8LsCkVyc2BGAqD+Q2C6C2R8Z84p4bi4jyvtbFPXpRB0Wd3aYEfEO6QgH5LCX2qiN74heiC2dFf1z3GngjG+wXBm/cfjWv5MOVFmod6g0PZjCiDvbtNrLWJe3Nom6Ae8Pw+8gh+KAFaNpeJSsU2Ha532JbbD/SXadvhM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(10070799003)(23010399003)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(10067099003)(5023799004)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261021135927099003)(261022105027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NENHUEwvMFVHR01uZStYSCtNUmVZWHlJTndZcWNJMTRWTnRZU0Jha2l5SzU1?=
 =?utf-8?B?QndQWjdiek1tbTVldE9BNTF1ZTdpazJOMDFxZzQxMm8xbEhDdmxTN3Z4R0Rr?=
 =?utf-8?B?RW5adWFad1NBK2c4WUJsc1lZUFo4QzhrZ2tDWUx3QlA0YVFkZmNJeSt2WXNS?=
 =?utf-8?B?UFhLYXNvMXJpWFRGaG9oVTVuMzNxZG9uK0RrZzg2SE1ieVRpVk56eEF0NDF5?=
 =?utf-8?B?amdqQVZCY2J6MXhZNHF1TFBpMWVwTnRnd2RnWEtFcG1JeitxaVd6R3hyRnBw?=
 =?utf-8?B?VzE3emN0dEl1TU9Fd3NqZWNaQ0daZ2tEWVQ0TTRRckJ6VEl0VFhaQ3ZtbEJN?=
 =?utf-8?B?UHoxL0FIblJ4ZkRBcllXU1JTbGp1azc3YTZIejVRSkhsdUlZV095SXoxbGZU?=
 =?utf-8?B?M0ZKZEdKeUJEZkIvakxDQXFvKzUvL250M2wxM0Y0aktVTUZiaTBrb245MzQ3?=
 =?utf-8?B?Vk1YckdKc0dtNGR6WjJaZ2VndjFibDg1MjRweFZiNmk1R01ITVc2djljdmJj?=
 =?utf-8?B?ZDNBbzBTZktENkRPSzFNR0toNU1VWXZJNjU0bDlVQzM2WUNZMHZhRjA1Y3dn?=
 =?utf-8?B?eU9YWHBOTkNHbDBmL2ozWHRSVEwwZkYxQVdRSVIwVmhYckVHUzVNOWphQ3lX?=
 =?utf-8?B?Uk94am9VWjNsQlhTdjJIRERNeFRtcGZja25ydjdhZU90aXA1Q1JEUWd3bmtF?=
 =?utf-8?B?TW5SditBUTNuc2hYV0xBNi9DYjJUbDZuZnFoNjB5dXRWUGZjcXl3WXlFZ3pu?=
 =?utf-8?B?bldSYTBhOGZmdVJWWUhZbm9HbjlORVN4bEpmTjNGdlo3RGVnT1ZONDNiaUZQ?=
 =?utf-8?B?d1Z3WCtncDlVckpEaXpkRitxSXh4dUxEV2Zob2xwNGNlcE9BUFZkVCtoaWpL?=
 =?utf-8?B?cEhrd1EyWjg2U1loTmxHLyt5QnRuaTNXU21qWlhmWjNUdTh2a0N0VjJnN0ln?=
 =?utf-8?B?ZWp4T0Y5L2dWVm5hMlh2MlBLYWxvcnJGdGVJTlV1KzJMdkNoK09NMFFXY2My?=
 =?utf-8?B?RzNybmlISC9RVW9TM201Y1dqd3REdG1Wa0JFaGEvZXVTMHcvUFkycHArdmJx?=
 =?utf-8?B?a2taelU5ZFZ2d000Mmd6MHJnMGo4VkdtUndrSXVITXZWN3JWYm5Kb2N3MCtI?=
 =?utf-8?B?UEI5NVhBblVzM1pvRWJDNkZuQmpKRVU4bGt4eG9qZGYvK0ZlUDJvRFlwK2ND?=
 =?utf-8?B?SGVTRVh5SVdtYXEySm5ZY0FKM09QTXBHZjVyTzhRR1dOeFI2eFlOeEEwS3No?=
 =?utf-8?B?NitzQzlwYTBQQjBPdk9udW53Uzd6TTFKeThEVXIrZnh2K3BxUGdxaHlnNVRU?=
 =?utf-8?B?QWczMVRrcUhJeE4yeTZ0NlFwSksxSWFZV0l6UURvT2Q1cGhNZDNLNEhPVUxv?=
 =?utf-8?B?NmF4L0NmU0hNSG9zOHN0V2RWMnlEeVZkTmtNTW85dGNMYXZFKzFWYnNBdDJQ?=
 =?utf-8?B?dFlyd2dZZ1BFVllMZGFVekZjYVNBcEE2SlQ3eTZ5QnJvSUJFcUp3NURjcTFh?=
 =?utf-8?B?eEplcll1NjVUL215N0l1Q1BOWVo2Z2tRQ0dES3hYQlJkclVNR3BKVFZCc3JR?=
 =?utf-8?B?SlRpZGhpaUt1Ky9rcllxcm9IOEgvSThvUWZUK1hDcDRObDIxTStUc0Nwa2RK?=
 =?utf-8?B?aWl4aUc2UFF6VW1JbWMyWDdxWGU0T0JVY1pVaityVVI5QmkvWHpVcWh1SEhR?=
 =?utf-8?B?MWQ3ZTBFMnU3NDQ1VXF6aXVVOG1mWkFaaC83ZkViZS9XTTlRZHhzTU55N3dU?=
 =?utf-8?B?LytkV0Y2eFhYU1Y5b0ZpOGx5UTMwQkFyZVVxOXJCcUNnQjdrUHd6QzZOZXp4?=
 =?utf-8?B?K2d6NzVEKy9OVXFaVHY4OUVmL3RIRGYxcVdCRC9PdnZHTzA1YXRDbSt0WjJn?=
 =?utf-8?B?eDU0NHdwRmRIcytuRHk1T2RCSit2VDcyb1FmYlZBZ0JENS9TN2Z2WlRQUHBV?=
 =?utf-8?B?TUFSMGRZaW5VWkJPRGFNL1p3WlMvT25Ta09ueDM2N1ZJdTZjenhSeE9URHM4?=
 =?utf-8?B?NjllRXkyYzlzZmJGRFlObGZsdFlMVHRMSXFuVmhra3hzK3AxajRzM1FoRU5i?=
 =?utf-8?B?NTBTektITUlQQ2FUNEsvKzFTL1QvQ3FXVnV2TGkzL0wxazRNY0VLdjdTSW84?=
 =?utf-8?B?NzU0azQ2aVRJd2JBV2licy9iYnBLZDcyd3lJc3RRaC83b2dHMjRrK1JuUmlJ?=
 =?utf-8?B?WkJrRFhnZmZBVDlxUnFHUVpGczkrTWVzYU4wTWlsMVBOYnh6dTZNaThVa2hz?=
 =?utf-8?B?eXNLRzlrME8vb0F2cXQ1LzdxUW03NTFjNEVmYkdxTEJOY0ZBTjVtWU1OUVNR?=
 =?utf-8?B?SE5WZGJCVnNlK2pWSytOaXFHbjljS3FDeTlReENuNjVFUW1OZ2cycXJhWnBK?=
 =?utf-8?Q?wtcipgJc2QRUZP8P3QDfF/CowZ6s6JX+35adxcX9hcbT4?=
x-ms-exchange-antispam-messagedata-1: UUUwKtrlUDkH5xvTDRAOTbhW7vZeH8/mA4s=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B737062D7E5B94C84AAC16B79DC036F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZFWVVQKTU6T6lxZ0NkVYqYqYsB0tOgUjZ2qd/UMKR3C+F3qEUO6TCWjaZAXBRYejG1KjT5N6MVzh/uTTCl3xMqnA8Rs/4ASdOAxMK9xrMtA7fivRxC8/rgtcuF25SXdGVFuZYv3+6NANfQKU0dX4J+J5fFzjh3BBWa4d0SR8SqsCpt9t6ueHdvX6SfctAML+yP5iPu8x3d555PGb85xo+tyQAM87nrLPOrI8R2z3cnl5Dgn1KuuhL7wszkJNRyTSgRene8t/tEuv+LLcdaYybGsyW1MkzvHL3sdGDQynZ6QNVNf9cwF9RmlixYhbRnonsip/NkjOvXw8/V1CY+hyOg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YOoyFsCsNc+AkXps8EtoVByGgicjhr5MZ7nDkyrGLhWom/4ZYbNFyGocboXotszcUJETM0TDSk+uLnxU/vNhHM4XGjPS7D3YPvLJkWg5LbMa2OaAvfk5d6xKnK5O4BPwkoNfifCo2vkWox9K6pyaB5qqwYapDN4DwxYCFIoX6sN9X12Q6myEOMHTGM+B9OzFinzzsa/Pwz8qA6VnWRldtRsMJb5kkKGmIU3WhbcMEvKyDdK+BKKBNn1rWRVf2rDqgQCXfqpmJZeLvCawGHcWXn9z9o5112RBhTqu/LxK7nswI63qKqhHaLImJ4HKTUYIloRlDXB9REA45rCcF3m7is+idD8+PojJ8XA29SGNABobldmyGy+6Ru66oDk6FP7u+zoWr8Bv3atHy/8lLlhs/9UTOo+BhXrSPwJjzcBrw3O8Ps6A+DhYDqVA6aILicF2U5aYqaHaISKxt6Nak9ew3sNgfPaPObobjxsnDv9PKX3IFBsu5QrgnkDEf2V3kQ4WBO3/dZnv7tFMNuOAzvdQujtQ9KFEFYuAlqyBxmyntzS81TCnKC4KgEZO6+x72PlO4GX2kf5bJvEvYvFooC/sez/B/v0AeXnbR5YUgnFKGfsDjQenpRS8tjquqhKASklV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb0500c-c1a8-4ccc-2332-08df49051e42
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 01:57:24.0980 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoTmfIcq0mlOlwVXUw28NyC4Y4Xwa8h5fI9tSBmE/+RzrRYOHm5kXMpVVaE72ARJofm8ZFduaOBa2ZdfM1KNOTrVa+cc58irrAfwZsk4pec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7919
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gVHVlLCAyMDI2LTExLTEwIGF0IDE2OjUwIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gV2UncmUgbGVhdmluZyBlbnYtPml0cmlnZ2VyX2VuYWJsZWQgdW50b3VjaGVk
IGR1cmluZyByZXNldCgpIHdoaWxlIGF0DQo+IHRoZSBzYW1lIHRpbWUgcmVzZXR0aW5nIHRyaWdn
ZXJzIHRvIEFEX01BVENIICh0eXBlIDIpLg0KPiANCj4gU28sIGluIGNhc2Ugd2UgcmVzZXQgdGhl
IENQVSBkdXJpbmcgYW4gaXRyaWdnZXIgc2Vzc2lvbiwgdHJhbnNsYXRpb24NCj4gY29kZSB3aWxs
IGVudGVyIGl0cmlnZ2VyX21hdGNoIGhlbHBlciBldmVyeSB0aW1lICh2aWEgY3R4LT5pdHJpZ2dl
ciksDQo+IGFuZCB0aGUgaGVscGVyIHdpbGwgZG8gbm90aGluZyBzaW5jZSB0aGVyZSdzIG5vIHR5
cGUgMyB0cmlnZ2VycyBzZXQuDQo+IEFuZCB3ZSdsbCBrZWVwIGRvaW5nIHRoYXQgdW50aWwgc29t
ZXRoaW5nIGVsc2UgY2xlYXJzDQo+IGVudi0+aXRyaWdnZXJfZW5hYmxlZC7CoCBUaGlzIGlzIGEg
bmljaGUgY2FzZSB0aGF0IGl0J3MgYSBiaXQgaGFyZCB0bw0KPiBoaXQNCj4gYnV0IGl0IHdpbGwg
Y29zdCBhIGJpdCBvZiBwZXJmb3JtYW5jZSBmb3Igbm8gZ29vZCByZWFzb24uDQo+IA0KPiBGb3Vu
ZCB3aGlsZSByZXZpZXdpbmcgYW4gaXRyaWdnZXIgcmVsYXRlZCBwYXRjaC4NCj4gDQo+IEZpeGVz
OiA1YTRhZTY0Y2FjNDkgKCJ0YXJnZXQvcmlzY3Y6IEFkZCBpdHJpZ2dlciBzdXBwb3J0IHdoZW4g
aWNvdW50DQo+IGlzIGVuYWJsZWQiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUg
QmFyYm96YQ0KPiA8ZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3Rh
aXINCg0KPiAtLS0NCj4gwqB0YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMgfCAxICsNCj4gwqAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlz
Y3YvdGNnL2RlYnVnLmMgYi90YXJnZXQvcmlzY3YvdGNnL2RlYnVnLmMNCj4gaW5kZXggOGI1OGNi
ZDA3YS4uOTg4YmM4MTVkNyAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L3RjZy9kZWJ1Zy5j
DQo+ICsrKyBiL3RhcmdldC9yaXNjdi90Y2cvZGVidWcuYw0KPiBAQCAtMTIxMyw0ICsxMjEzLDUg
QEAgdm9pZCByaXNjdl90cmlnZ2VyX3Jlc2V0X2hvbGQoQ1BVUklTQ1ZTdGF0ZQ0KPiAqZW52KQ0K
PiDCoMKgwqDCoCB9DQo+IMKgDQo+IMKgwqDCoMKgIGVudi0+bWNvbnRleHQgPSAwOw0KPiArwqDC
oMKgIGVudi0+aXRyaWdnZXJfZW5hYmxlZCA9IGZhbHNlOw0KPiDCoH0NCg==

