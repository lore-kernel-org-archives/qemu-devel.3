Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDFD606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=OjxCQAPs;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=D1kdhZ6p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJjm-0001ga-2h; Sun, 22 Nov 2026 21:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJji-0001fr-VM; Sun, 22 Nov 2026 21:24:54 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJjg-00074s-NM; Sun, 22 Nov 2026 21:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795400692; x=1826936692;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=JYyifyAZt6UqCLZnm6w5sNYwb7qGryCFvBtV6LXfmnw=;
 b=OjxCQAPs9Zef+PdiXWZLM5ILzkI9K/jvfPRNl8FU07BY1JyXkiHtAoak
 TS3tmRaIW1mby5afFrTaZDIgdOOLu0HfhT8ErXmQLorJc8A6DU/k5ZOhB
 fb2INxR41Vuly59g5rN1TthoALBvywgiOhIfiowwKX0zAO6lnj4s+eryl
 kgO8IpFBAV+mc5F3T1+b1xbmA5lhxvBGET8ofTJ7qEhI1N3/DrHDT2PxB
 JSJRco/J34Serurm6d2Y7IO5MYkFfbSy9LEXW8T2ED37VLiEl/waFZgBX
 NSTKTXtjpS/kMpmneGTPnVFUAYBM5Qls9tvGooJ4cV/VmhCKEM2R1/cdt A==;
X-CSE-ConnectionGUID: CmoLVWRFRTKVpzgtcj9PaQ==
X-CSE-MsgGUID: M3dKPXJ+RZu/B3Bn7QXQEg==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="159904806"
Received: from mail-westus2azon11010061.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:24:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CajQn6jk2AH7Rj6+rj/Q1RprLu5csx3v3ZgqHOuAWCIdvvHIhK9SESxdPG8yo/NIcur57e79p1eTxaiwx1H/5B7rH+X4yKgzsJWMCrNvKCnMkDGQxE+0erZ/+AeXKNdvcAL0EzegsEI5HuF+sJwDAr67CO2blfiFYkDwBH6lea44pzXDAUDtnvhxXWJax4QcANnuokvStWItAAb+3a5QZm3ISENfORTMQcTw2CGBjDHPAlcIBtRjlq/QDaTTX7VO+SCOO7lf7ztLK6+hQi/pv+lCeqHXUx6pih3+/9hzEfeEXUqQNz4/L7b9d5TkXgCg87UlIIUzUI6kQj5BE9lYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYyifyAZt6UqCLZnm6w5sNYwb7qGryCFvBtV6LXfmnw=;
 b=EM+Ix4fgcIDSwi/DHP0wrDIXWnN7OcM320TKrrd0xGtt2r7MWGWT4xGcyqludSw37VryHbkhjlHLyrSMgpnDtGBUo9YBcyOS9KNP3k+Tkep0bUhxG19e8wLKrgac4aMETbyEzw0Cmg80JrvN1EEtI90nnQAU/yfMu1G19H4T31EqtkPubip09Sj2rOeGndq3D/c/ubNz2lqRmlPzShT2oBCDy7mVEaukwA7MZRs+/s2VBOlvNAIMWxZNZ+fmro9c0mlCnueiGSC8mT0pAEAny/i90HJe6ZZNg9GJaaR+pmOQwsSrgkBviZrg6jWEUV5eYgYN9IAS7ap5Oi3ncrTggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYyifyAZt6UqCLZnm6w5sNYwb7qGryCFvBtV6LXfmnw=;
 b=D1kdhZ6pZ8ZoA2mPd4WksGqkwJ4O8oAYvahCaWkXhMsYbe1PEB130nb186MNDu0tdbYJHH6UtypjHVx4UvBula+RyVT1e5coh9nkdltdSp+YROIgoHl24goBfhoQxM1bhZdJzTLgIW+j0GgrSTFMJnv3p9v43MreTV09MwsURMQ=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6929.namprd04.prod.outlook.com (2603:10b6:a03:22c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 02:24:47 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:24:47 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: fix hideleg write masks [GL4814]
Thread-Topic: [PATCH v2] target/riscv: fix hideleg write masks [GL4814]
Thread-Index: AQHdebXEYZKiKZpoSEWomw70FmDtKLc68DEA
Date: Mon, 23 Nov 2026 02:24:47 +0000
Message-ID: <99dd5a2762f05a5c897138f72fee85aa2c8b73f0.camel@wdc.com>
References: <20261121124215.1294032-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261121124215.1294032-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6929:EE_
x-ms-office365-filtering-correlation-id: 85c57acc-1783-42f8-e01e-08df4908f1f6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|10070799003|1800799024|19092799006|38070700021|10067099003|260925021911599003|261026140227099003|11063799006|260925022911599003|260925021311599003|56012099006|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261021121427099003|261028144727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 4m7JdWAReEMdx766ZfFuVwU23v0ZxHhgbj0Vn9K0NCM59iw8OLvjsMaWlLZOKtAv8g1pMv0dIwKXbWAsIOv+Quz7bNlVqDOXpuk2jJQYY040BhHRvHI8OmWvi9q2wHKaRFcDipihGknTO/J0XqKJIHQYmOZEZwNn8xH9uCOv5pDPQr0cGKQlZUFAHSn9SOLo6hGkiPRw9btkq2pYcJL7o3d/uVPHr5JqcYnUXzAS5Ht5SFY/KlPqQJbyNl9YnCPgq/FX5B2meJLDKkSsMX9P/ib8yIGd6tPpb9DoMjeL7Tx1MUKDvOwk9PUUQ72CqFPGGDs2WZfzQsoCHrV8SEDVKFeMV18RodA8PMH5sXcycv/yYFetpyYNHwl32uhw+vH5SnEPwdDXsgJaXQeWnJTRiyw/xFU6q7os3siT6/d0IeMg1PTvGmJ0QmFD5SA7HZWZUuYh5wttBfSzHASefzORDAvCzEDTbkhScY2RkhMMyFR4D+8vGJB2am9SnwSkgqOXq6ElBbhPERin397+shZekAVcuEYQRAoaap4dR6122yLZldzPGf157Qhrw3vERF8gfxP+cWiMAODFXU08tbO3XJLe5vXkiITF4Xc5zS8rE8hLaRceCfGXAojFHNTYpgPQcIlQnvkR1bZlOmUkMBMCHBIlN8MNClGryphSLM266m0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(10070799003)(1800799024)(19092799006)(38070700021)(10067099003)(260925021911599003)(261026140227099003)(11063799006)(260925022911599003)(260925021311599003)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y3ppeWY5U0pjRjNTcnAwd3dPMlR5eDgveGZpOC9QVkI0MEJUK3hLcUNOd2tk?=
 =?utf-8?B?V2lkbWt1b3J0N2RGb0Ywc1ZxN2lxd2szQ3BIMHBXalJUUGo1NEFiQ3A0Y09Y?=
 =?utf-8?B?UExFazQ3MHJpWkwrV0tCdkgyRUdScXN4ZWpGd3huM1FrS2RhbG14ZTJ5cGFi?=
 =?utf-8?B?L1BSUUZUd3kyODZVU3EzUlpTekE3WkZIcHNQcnBZY29Ddy9DdkJPVFV2bzZD?=
 =?utf-8?B?blM1eUhPNUw1TFUzbGhoZEtuV2QrNnA5dnRKY0RXZzRjQkdvUmpmN3YvdjIr?=
 =?utf-8?B?UXZIUmg5bGlLWVZzMVd3V2NDZTVOUnFRdW9JVmI4dGZZMXQ4NzI1Y0RyV1JQ?=
 =?utf-8?B?dXNQYlVQcDFSR09BdnB1Ry9Nd3lFWHZtaGNKRktwS0tUSWQwMWQxcW1OeitW?=
 =?utf-8?B?N2laYndaRWd6U2xmTyswWm9tUnNLenB4M2VSaEw0WmFZdG00MUtQVFR0UnEv?=
 =?utf-8?B?L2RlYmRQc0NVbHRyRTA2aE9NTEF0TzhQYmtxYUcreitvdW80SUZ1L0RmQzFR?=
 =?utf-8?B?VW1VaklxYlNPWVJBS1AzNGhsTENtbExXc0lsR1VaeHJrL1g3T0ViK2MySXRQ?=
 =?utf-8?B?ZzNremZSbG1lOWoyd2YyRUwvcXBEZWZqZHhpVTFxejVHdy95V2t1a0NzQmxy?=
 =?utf-8?B?QkEvNi9IZUhGY2d1Y1hNZDFIUVhVYWRVYzdYbHRYUjd3cmlESlVmRllwVGRT?=
 =?utf-8?B?R1Nyd1hqOHBCOVRMc2NSbnM5a09jb0FINGRjb2Y5MERrQStpTUdvNUJHU3E1?=
 =?utf-8?B?QWFxOERtdnE3c1dpSlpZbTY4RUpidGNuczZ0QlVpbEtsN0k4RlRvSmxITUxv?=
 =?utf-8?B?UlZrL1U4S09Ic3RsY3Q4ckd2MGozZ0VGWHphSnZMVTBJVEZoOU9UN0FBWUFB?=
 =?utf-8?B?cUU2TnUvRXBWNGY1Nm5HU1lJNnRxblNMcmdmbEgzbmhpY2ZacEZmamVCMnVw?=
 =?utf-8?B?MG12Mk82RWZza3ZzSVhTd1B6dG8rdkZtZXNucmtwOEQ0TXI2QWxEQWZXY1h6?=
 =?utf-8?B?aEt0eG5UQUFUMkhFZ08zcFJicFdvaHF6RU5DWlRMSkxjcHZXYWRqaVk4UEc1?=
 =?utf-8?B?WEJaMERCQ0FDb1RjdXNxNzBubDd5Y29OVTZ0YmtpL096Rll3RHRBdkpIMTQz?=
 =?utf-8?B?R3RnU0o5dVdvZE9UOFpsZklrYXh6a2tDLzFuRHk3b3Yvd3ZlczZ5VjgxMHcx?=
 =?utf-8?B?OElkOFRTaEJSRllWTU10b05hTXR6L1UwL3JKd2lId2ZIdXpyYXdzN29MZUdq?=
 =?utf-8?B?cGI3b1E4dklqVEFURUlaM2wyNDFZMmlEVXkrSmp1b3pETmFzbG9KY3YxQmN0?=
 =?utf-8?B?czRpb0pVaWpPSjRpVkJEK0xyYUtKbmRsSU1PSkdmbWxOYzFwS0JUT3VvNmh6?=
 =?utf-8?B?M2piOTZOYUhqUGt5b2J4b21wci82ZG9BOUQ5cGlZOFg2YnkwazIyWlAyUERQ?=
 =?utf-8?B?SW52aERNL3VhYTZULzRwa1FsRkxiZHNPUVRwaDNsU2l6OWRPbWlFVTB0RXZJ?=
 =?utf-8?B?TStHNkpJNWh4ZVhPclorMTBRMVBldVN1UmFjVDlRWWhvVXU1UEJXbnF6K1Fj?=
 =?utf-8?B?RWJ6VU04dzNPQ2lyWXBZclJlV0tQRWhveCtURXdSQWl3bkZ6SkJ3ZEZsa2Fu?=
 =?utf-8?B?UktkN3Zya1IrT2sxdWVUQTR4eGtSbWw4ekFIRE1TT1dLdnhIeDh3MjYranVM?=
 =?utf-8?B?WUpaT0JxM3M0QU40Y3JMZDhnRXZrdUVaRWl2alovdmxjWkhjSzZMV0dOUlNq?=
 =?utf-8?B?cE10dlBCR2tKbElFL3JwMHd5ZFl1WlZqZ25RTzNTT08vd0xQc3NGSGRHTnF4?=
 =?utf-8?B?b1BGZWVvRFY5SXlHS05VV3A1VXRpRE1lNy9oRjV4aHRpb0h2SnBPU0lRWExv?=
 =?utf-8?B?d0VNZFo0T1FFUnhPVzlTVGZEOGlUNnZTUnZtcG1EL2FoQnFRYzBRQ1hEdGI3?=
 =?utf-8?B?QXFWL3cyaVJIZTd2MUNsZ1hHcDI1LzFic0UxbzhDcVhjZW91T2JEdWdKSmNO?=
 =?utf-8?B?V0c3WER2RTBkOXllbGhhWjRGc3ppQkYxb3RMdGZ1dDlCMUE0bE1sYnpJNHhE?=
 =?utf-8?B?dnhmMWxGWXJWQlBLMFJMSFV5TW1nQ08yVmRzMjh0UVdmU1pxOGlRYlJUVVkr?=
 =?utf-8?B?NVdqdWxUS1dRQ2pydmdCQ0tOQ1VXcGw1VGdjMHQrMW1nalpxZ2hWeTlkcmdX?=
 =?utf-8?B?Z3F5ZVZJbURBdmZ5bk5KcmZJMGR2SWRWa2lndk5BVTljZ1RjY0RSaG0yWita?=
 =?utf-8?B?SGU5TzFRVXd2SkJKK2k1ajJUak9yMlF6c2hybHJlcnpGamxldXFLUllBRmxD?=
 =?utf-8?B?eXIyS3RqWkpMRmNCUGVSNVlDaHhQT0Nxa2FEV0lIWVorWEFaN0IySWlkZm1v?=
 =?utf-8?Q?lSywEMwY12PUy4c8G2zTPzntCvsDT9U43ktYxfc9ShLIn?=
x-ms-exchange-antispam-messagedata-1: 6Uh3W81Yf0ghItdJTRFDlhW/pYENlYS047Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F384F8730EC6A43A667302CD40E01A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XYsn0YN+0fKgIxWzVmYJOzYBsw3FiTYKmE+XWtl9j7lEwYh0PBy9+sW4moczFhDsg13zkCIQg9CEO6h7B/ZIyB/6ud7DYWXWoIIGilsfzmDmsmxqypuzQMFKCCga8RS3fRg+yoUghkrtFsHJy5Idm5rq5E2SHv9Iqs7ymjRSy7GOnW5K4QhfC0kSELld02lctt5TnW10UrpHoqJdz3qXrKqYyrQHXR94SwYkDHkMmMpqBL6ryq7dhVWaLbzuxWReTe6qK77feCGFpOhf9YVENLu+SXHp4o12Il8BqHyTLJJ+lXcBV+uNKo6sbaEexODTR2ePvGu0tNGQvqROJwCBAQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uvGceCu/ssE0CUSxJ/9W3kbS7kaSzJZT7dI/XWsNu7gN5s7T8NJmDK2BzYDecgCuYM2xgbb2+pcOUeO6FqZ6nS0giyJVj0I3VK3DvpSQ3segrwg/rwFNE/wI8xEQW1D9X1SBW715tQm+7cQNec5UUt150s97gfJ3Dy0fMio/j95GcWw1dHurIpypnc5xzaI86JQspLuymALb+m3emTRwxyTqzLcT8BcQLJjJ8Gy05t8YOwfrJO0GRHNeFg8wgiTfFjx+sEbPpiKL1aSaDG0geke8iMXHDX2cfV1VgEATObFfT1qQemujILWhq6wqs7+CviNP5zdawp0fmJ1DMSbjyCK/864+4JsNSB+urS08jUJ7pMa7CdV+jo/Bw1dbkN71+gUyu7/EMHvrXGwvhN+OdFqEYEXeT1bq6nRJ+1U0ilTwhN+kk1XqicxreggdenQ7l0pCP5Kkag6NFDOVESfjTKXRkZPp3/aACLoE7ukWb8VOFDsdArSm4BQqmR2kRDlWlIlLTFE6ibdU3Ws73dghZD3cQpLCWNLz+hclzg1Hgh8fJMKsfl783CJP/bjAaBRZlrqO2bNHBdg57B4XB/4J/aUlNq5H5/8F8HrCkkMkBTSgihCWsAGahxEeO/UWvLJc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c57acc-1783-42f8-e01e-08df4908f1f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:24:47.7253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lc4wRVWKQwDj6rKeUGHuqZ4Hlddph0bnpIflcoVOooc7lPIseu+Bz9ECPrrxrlzA/og6D5tT5LeniCeCFTLMQDomTm/ZHZbiMi9fpK0WkNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6929
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTExLTIxIGF0IDA5OjQyIC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gV2UgbmVlZCB0byBjaGVjayBoaWRlbGVnIHdyaXRhYmxlIGJpdHMgd2l0aCBt
aWRlbGVnIGFuZCBtdmllbi4gUHJpdg0KPiBzcGVjDQo+IHNheXM6DQo+IA0KPiAiRm9yIGJpdHMg
b2YgbWlkZWxlZyB0aGF0IGFyZSB6ZXJvLCB0aGUgY29ycmVzcG9uZGluZyBiaXRzIGluDQo+IGhp
ZGVsZWcsDQo+IGhpcCwgYW5kIGhpZSBhcmUgcmVhZC1vbmx5IHplcm9zLiINCj4gDQo+IEZvciBt
dmllbiwgdGhlIEFJQSBzcGVjIHNheXM6DQo+IA0KPiAiV2hlbiB0aGUgSCBleHRlbnNpb24gaXMg
aW1wbGVtZW50ZWQsIGlmIGEgYml0IGlzIHplcm8gaW4gdGhlIHNhbWUNCj4gcG9zaXRpb24gaW4g
Ym90aCBtaWRlbGVnIGFuZCBtdmllbiwgdGhlbiB0aGF0IGJpdCBpcyByZWFkLW9ubHkgemVybw0K
PiBpbg0KPiBoaWRlbGVnIi4NCj4gDQo+IEZpbHRlciBoaWRlbGVnIHdyaXRhYmxlIGJpdHMgYnkg
dXNpbmcgbWlkZWxlZyBhbmQsIGlmIHRoZSBwcm9wZXINCj4gY29uZGl0aW9ucw0KPiBhcmUgbWV0
LCBtdmllbi4NCj4gDQo+IEZpeGVzOiBkMDI4YWM3NTEyZjEgKCJ0YXJnZXQvcmlzY3Y6IEltcGxl
bWVudCBBSUEgQ1NScyBmb3IgNjQgbG9jYWwNCj4gaW50ZXJydXB0cyBvbiBSVjMyIikNCj4gUmVz
b2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMv
NDgxNA0KPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQ0KPiA8ZGFuaWVs
LmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2
LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gDQo+IENoYW5nZXMgaW4gdjI6
DQo+IC0gYWRkIGEgY29tbWVudCBleHBsYWluaW5nIHdoeSB3ZSdyZSBjaGVja2luZyBleHRfc21h
aWEgY2hlY2sgYWxvbmcNCj4gd2l0aA0KPiDCoCBSVkggKFNhc2hpa28pLg0KPiAtIHYxIGxpbms6
DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjExMTYyMDUxMzQuODQ2
ODc2LTEtZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbS8NCj4gDQo+IA0KPiDCoHRhcmdl
dC9yaXNjdi90Y2cvY3NyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjcgKysrKysr
KysrKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkIHzCoCA4ICsr
KysNCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LWhpZGVsZWcuU8KgwqDCoMKgIHwgNjQNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgOTkgaW5z
ZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0
LWhpZGVsZWcuUw0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMgYi90
YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+IGluZGV4IGFmNDQ0ZTNlNmYuLjVkMzM2M2NmNGEgMTAw
NjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2
L3RjZy9jc3IuYw0KPiBAQCAtNDk5Nyw2ICs0OTk3LDMzIEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlv
bg0KPiBybXdfaGlkZWxlZzY0KENQVVJJU0NWU3RhdGUgKmVudiwgaW50IGNzcm5vLA0KPiDCoHsN
Cj4gwqDCoMKgwqAgdWludDY0X3QgbWFzayA9IHdyX21hc2sgJiB2c19kZWxlZ2FibGVfaW50czsN
Cj4gwqANCj4gK8KgwqDCoCAvKg0KPiArwqDCoMKgwqAgKiBUaGUgc3BlYyBtZW50aW9ucyBvbmx5
ICJ3aGVuIEggaXMgaW1wbGVtZW50ZWQiLCBidXQgc2luY2UNCj4gd2UncmUNCj4gK8KgwqDCoMKg
ICogcmVhZGluZyBhIENTUiB0aGF0IGV4aXN0cyBvbmx5IHdpdGggZXh0X3NtYWlhIGlzIGVuYWJs
ZWQNCj4gKG12aWVuKSwNCj4gK8KgwqDCoMKgICogd2UncmUgYWxzbyBjaGVja2luZyBmb3Igc21h
aWEuDQo+ICvCoMKgwqDCoCAqLw0KPiArwqDCoMKgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZI
KQ0KPiArwqDCoMKgwqDCoMKgwqAgJiYgcmlzY3ZfY3B1X2NmZyhlbnYpLT5leHRfc21haWEpIHsN
Cj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+ICvCoMKgwqDCoMKgwqDCoMKgICogVGhlIEFJQSBzcGVj
IHN0YXRlcyBpbiBzZWN0aW9uICJJbnRlcnJ1cHQgZmlsdGVyaW5nIGFuZA0KPiB2aXJ0dWFsDQo+
ICvCoMKgwqDCoMKgwqDCoMKgICogaW50ZXJydXB0cyBmb3Igc3VwZXJ2aXNvciBsZXZlbCI6DQo+
ICvCoMKgwqDCoMKgwqDCoMKgICoNCj4gK8KgwqDCoMKgwqDCoMKgwqAgKiAiV2hlbiB0aGUgSCBl
eHRlbnNpb24gaXMgaW1wbGVtZW50ZWQsIGlmIGEgYml0IGlzIHplcm8gaW4NCj4gdGhlDQo+ICvC
oMKgwqDCoMKgwqDCoMKgICogc2FtZSBwb3NpdGlvbiBpbiBib3RoIG1pZGVsZWcgYW5kIG12aWVu
LCB0aGVuIHRoYXQgYml0IGlzDQo+ICvCoMKgwqDCoMKgwqDCoMKgICogcmVhZC1vbmx5IHplcm8g
aW4gaGlkZWxlZyAoLi4uKS4gQnV0IGlmIGEgYml0IGZvciBvbmUgb2YNCj4gK8KgwqDCoMKgwqDC
oMKgwqAgKiBpbnRlcnJ1cHRzIDEzLTYzIGlzIGEgb25lIGluIGVpdGhlciBtaWRlbGVnIG9yIG12
aWVuLA0KPiB0aGVuIHRoZQ0KPiArwqDCoMKgwqDCoMKgwqDCoCAqIHNhbWUgYml0IGluIGhpZGVs
ZWcgbWF5IGJlIHdyaXRhYmxlIG9yIG1heSBiZSByZWFkLW9ubHkNCj4gemVybywNCj4gK8KgwqDC
oMKgwqDCoMKgwqAgKiBkZXBlbmRpbmcgb24gdGhlIGltcGxlbWVudGF0aW9uLiINCj4gK8KgwqDC
oMKgwqDCoMKgwqAgKg0KPiArwqDCoMKgwqDCoMKgwqDCoCAqIFdlJ3JlIG1ha2luZyB0aGUgc2lt
cGxlciBjaG9pY2Ugb2YgbWFraW5nIGFsbCBiaXRzIHJlYWQtDQo+IG9ubHkNCj4gK8KgwqDCoMKg
wqDCoMKgwqAgKiB6ZXJvIGlmIHRoZSBiaXQgaXMgemVybyBvbiBib3RoIG1pZGVsZWcgYW5kIG12
aWVuLCBhbmQNCj4gd3JpdGFibGUNCj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBvdGhlcndpc2UuwqAg
V2UncmUgbm90IGdvaW5nIHRvIHNwZWNpYWwgY2FzZSBiaXRzIDYzOjEzLg0KPiArwqDCoMKgwqDC
oMKgwqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgwqAgbWFzayAmPSAoZW52LT5taWRlbGVnIHwgZW52
LT5tdmllbik7DQo+ICvCoMKgwqAgfSBlbHNlIHsNCj4gK8KgwqDCoMKgwqDCoMKgIG1hc2sgJj0g
ZW52LT5taWRlbGVnOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDCoCBpZiAocmV0X3ZhbCkg
ew0KPiDCoMKgwqDCoMKgwqDCoMKgICpyZXRfdmFsID0gZW52LT5oaWRlbGVnICYgdnNfZGVsZWdh
YmxlX2ludHM7DQo+IMKgwqDCoMKgIH0NCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0
L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBiL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5i
dWlsZA0KPiBpbmRleCAzYzhiMDE4ZDllLi42YzA4ODA2Y2M5IDEwMDY0NA0KPiAtLS0gYS90ZXN0
cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gKysrIGIvdGVzdHMvdGNnL3Jpc2N2
NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IEBAIC04OSw2ICs4OSwxNCBAQCB0ZXN0cyArPSB7DQo+
IMKgwqAgfQ0KPiDCoH0NCj4gwqANCj4gK3Rlc3RzICs9IHsNCj4gK8KgICd0ZXN0LWhpZGVsZWcu
Uyc6IHsNCj4gK8KgwqDCoCAnY2ZsYWdzJzogY2ZsYWdzLA0KPiArwqDCoMKgICdxZW11X2FyZ3Mn
OiBbJy1tYWNoaW5lJywgJ3ZpcnQsYWlhPWFwbGljLWltc2ljLGFpYS1ndWVzdHM9NycsDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICctY3B1JywgJ21heCcsIHFlbXVfYXJn
c10sDQo+ICvCoCB9DQo+ICt9DQo+ICsNCj4gwqBpZiAncWVtdS1zeXN0ZW0tcmlzY3Y2NCcgaW4g
ZW11bGF0b3JzDQo+IMKgwqAgdGNnX3Rlc3RzICs9IHsNCj4gwqDCoMKgwqAgJ3Jpc2N2NjQtc29m
dG1tdSc6IHsNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtaGlkZWxlZy5T
DQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1oaWRlbGVnLlMNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMC4uYTA3ZDQ4NDMwZg0KPiAtLS0gL2Rldi9udWxsDQo+
ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtaGlkZWxlZy5TDQo+IEBAIC0wLDAgKzEsNjQg
QEANCj4gKy8qDQo+ICsgKiBUZXN0IGlmIGJpdHMgNjM6MTYgZnJvbSBoaWRlbGVnIGJlY29tZXMg
d3JpdGFibGUgd2hlbg0KPiArICogdGhleSBzaG91bGRuJ3QuwqAgRGVyaXZlZCBmcm9tIEdpdGxh
YiA0ODE0Lg0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVz
LCBJbmMuIGFuZC9vciBpdHMNCj4gc3Vic2lkaWFyaWVzLg0KPiArICogU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+ICsjZGVmaW5lIENTUl9N
VklFTiAweDMwOA0KPiArI2RlZmluZSBDU1JfSElERUxFRyAweDYwMw0KPiArDQo+ICsub3B0aW9u
IG5vcnZjDQo+ICsJLnRleHQNCj4gKwkuZ2xvYmFsIF9zdGFydA0KPiArDQo+ICtfc3RhcnQ6DQo+
ICsJbGxhCXQwLCB0cmFwDQo+ICsJY3NydwltdHZlYywgdDANCj4gKw0KPiArCS8qIE1hc2sgZm9y
IDYzOjE2LsKgICovDQo+ICsJbGkJdDAsIC0xDQo+ICsJc2xsaQlzMCwgdDAsIDE2DQo+ICsNCj4g
KwkvKiBtaWRlbGVnID0gMCwgbXZpZW4gPSAwOiBoaWRlbGVnIGJpdHMgNjM6MTYgc2hvdWxkIGJl
DQo+IHplcm8uwqAgKi8NCj4gKwlsaQl0MCwgMA0KPiArCWNzcncJbWlkZWxlZywgdDANCj4gKwlj
c3J3CUNTUl9NVklFTiwgdDANCj4gKwlsaQl0MSwgLTENCj4gKwljc3J3CUNTUl9ISURFTEVHLCB0
MQ0KPiArDQo+ICsJY3Nycgl0MSwgQ1NSX0hJREVMRUcNCj4gKwlhbmQJdDEsIHQxLCBzMA0KPiAr
CWJuZXoJdDEsIF9mYWlsDQo+ICsNCj4gKwlsaQlhMCwgMA0KPiArCWoJX2V4aXQNCj4gKw0KPiAr
X2ZhaWw6DQo+ICsJbGkJYTAsIDENCj4gKwlqCV9leGl0DQo+ICsNCj4gK3RyYXA6DQo+ICsJIyBB
bnkgdHJhcCBpcyBhIGZhaWwgY29kZSAxDQo+ICsJbGkJYTAsIDENCj4gKw0KPiArIyBFeGl0IGNv
ZGUgaW4gYTANCj4gK19leGl0Og0KPiArCWxsYQlhMSwgc2VtaWFyZ3MNCj4gKwlsaQl0MCwgMHgy
MDAyNgkjIEFEUF9TdG9wcGVkX0FwcGxpY2F0aW9uRXhpdA0KPiArCXNkCXQwLCAwKGExKQ0KPiAr
CXNkCWEwLCA4KGExKQ0KPiArCWxpCWEwLCAweDIwCSMgVEFSR0VUX1NZU19FWElUX0VYVEVOREVE
DQo+ICsNCj4gKwkjIFNlbWlob3N0aW5nIGNhbGwgc2VxdWVuY2UNCj4gKy5iYWxpZ24JMTYNCj4g
KwlzbGxpCXplcm8sIHplcm8sIDB4MWYNCj4gKwllYnJlYWsNCj4gKwlzcmFpCXplcm8sIHplcm8s
IDB4Nw0KPiArCWoJLg0KPiArDQo+ICsJLmRhdGENCj4gKwkuYmFsaWduCTE2DQo+ICtzZW1pYXJn
czoNCj4gKwkuc3BhY2UJMTYNCg==

