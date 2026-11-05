Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48531606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=osdsh2qy;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=GgYHiQFZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOpL2-0001BS-16; Wed, 04 Nov 2026 23:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpKz-0001At-RN; Wed, 04 Nov 2026 23:44:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpKx-0001kD-Tw; Wed, 04 Nov 2026 23:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793853871; x=1825389871;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RJ6ILsQ5kd2cLcaCawdWM/v4+pWLOmaWEmnoLXi+s08=;
 b=osdsh2qyeNp3yqykqWTUHWxzUv7fBZHAvxOg2b1wA29LAZKDWiNfJdTR
 +UwkUC21hKJbyDu5ZPT04aG8x2WAs+3Ikg2CmSxKpR1dvX7ZJs+C7JO8n
 WjbIjK0N5RHdFXz21oJhVfLVK0RvI1a6p2nW18zB6Nvn5pRqozZy4bIkD
 BXUzh9OKD48Z7HpOvfFMQGXf3fT8aTfTGU/ATkW85KD5PCDt0z5L1UQBZ
 Slf6q5wA4paJKdl9gIwGggz1adjxsHYBPfMEz7WwmDtEfB8YH2OjBstyO
 /OWpSo5gfpZ6uAyU+yZFxR7TJftyqeJLScrLtiCW1bNn2Iv7yWkCEECip g==;
X-CSE-ConnectionGUID: XSsmN6y5Tp6kvg2vdWWaxw==
X-CSE-MsgGUID: pJ8BbKDkTOeiUQZ95CIa7Q==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; d="scan'208";a="160830879"
Received: from mail-westcentralusazon11010055.outbound.protection.outlook.com
 (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.55])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Nov 2026 12:44:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3DaXAnK/XRc1gvPHuX/8CLS+C5g1U+QgsrYVDxMwditcgxkb490NoU+brjIdAakAvRxS5m2cNTaz/F7knyx3apPrvYdGeNNhNxmBjWCTRvl7DVWFI0KES7+hTVE5jlXopF/oqy46fZjf9yFwd4W7aCiaZroxVH+oUTpmAJoz1gJa6R5lRDcSrFAs4KbHBg455OdI6z3FrmyJlY1TEc3tYHQY80BThB8zaiKsj01Rz3Oor88b0JkoQ9gVZGNSIq4TEEXDcxCqa8bEmHw8nCFJCVU2EsJiz/dIfWOZdcT5kvxFGh96QjXNmu6mZFKctZ3zVM7OsvIuug7K8BN60DzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ6ILsQ5kd2cLcaCawdWM/v4+pWLOmaWEmnoLXi+s08=;
 b=hYSMVE6JXxhXMSfp8oJRfVH/2hnc1kr4R+5II2fl0Cka6VsOuy+e/IUdBr8GN/fZ0ipwoCUOxPGwNIkyiaR0kfI5aRoHCpP9iHlC2I81OiuzutRx7c/NPjMSN/M2vw//J5OUGTqC0Kg7tAzK/tqgeE954vEKEin5xp37mDCie584Y+oIgTO9Gx5MIQZhsPv4UAiBy4yiTeOKRVVZm1UMzENR48wZi1q+MOm8AUa+Z7EPvnD5zdxkFnj+lLaieWuK2HcOZZfScMfTic553/2rb4jgTnSV8oW38TKsCCiM8w/0+N2eHV9CoGlQkWmVBLqU2gv5C/oEKH7EncaKGZajng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ6ILsQ5kd2cLcaCawdWM/v4+pWLOmaWEmnoLXi+s08=;
 b=GgYHiQFZ2E/rrHNE5QCnp4pIJhSSE+/8D6aFyaB3EaFZXoSZHt2ru0gN2LlqzB6JwRow9LktRPRgE2krKYu++g/ftDMX3rOwWUPUQYuJIdDFwVMENP+p42sgIOxP7rjX5Mdq3olyJrUyvFmO2hfm+pbTEy4mnwUup6Mi+8lngCo=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY1PR04MB8656.namprd04.prod.outlook.com (2603:10b6:a03:533::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:44:23 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 04:44:22 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 0/5] hw/riscv: Fix minimal RISC-V system builds
Thread-Topic: [PATCH 0/5] hw/riscv: Fix minimal RISC-V system builds
Thread-Index: AQHdaa9hz6duTKOcKU2b9FP1NyWtLrce7UeA
Date: Thu, 5 Nov 2026 04:44:22 +0000
Message-ID: <baab6c2b7704d955cd97f08056b65dde5d11f2ed.camel@wdc.com>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY1PR04MB8656:EE_
x-ms-office365-filtering-correlation-id: 4e15c15f-5226-4230-c2a4-08df3af7762e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|10070799003|366016|1800799024|22082099003|18002099003|6133799003|10067099003|38070700021|56012099006|11063799006|5023799004|261026140227099003|261028144727099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003;
x-microsoft-antispam-message-info: QccLzI9OImerezzGWcskX2QSx5UkplPrDg5XgMG9hntA7B6IwtmR4rP7fhCcoIdvWgWC4ZsyQCZnThCFE5a8nNcdSaxbI5puH87gS/n5fW9ZUa/RFqmyf5wprmeO1dBJKbFOK52RrM26KLNWsOzK2Ci5pfGsIFjvpiGVxRtUO6HccJi0fVkDRsviC+Jxr6vJWMbYLYGmVG7ArKS83P/oSWbEjL0xNeDHlxhrev1Hgu5UELIGOkqMKPqvFNhHhi6nOzr5rlaBymcB9WUhUcUlwnAWV4NexoTq1o5/LaVqAW820dW1FRV1MKJsW1XNuaB9ktPGQpgfKlQ1Ed6AgYAmB+nK2eNMqvt7srvISFcxq3utq1K2BpL2mqIKYnvX1+zgHZLBpXAV7dKaJPLigQM/TuTdKnnAZSrxzIrw1/PD1eO7zhYsjgpUsOnSqdhBCx7s6F8KSnYwRmbtglnS0mfYWHw177i/0sQAHyL+UQsapN7Esfe3mzPXe0QtIAiJ6LD5NSASs+BnHpHxfJH5m1Ed/IBwU2frwRJNZNUj3eLm41rkPCj1COU5p6TRFUuR6A038ObaFz5OEfZxDu51yjxe697CdHwvxyrFn7x1Fk/4CijVeI167WM21pnJlZMS7kiGlMmeIitsIA0cGa/9tz0b9F8/tfkIJyK9YXuUNNfgiKX8rXP2NIvf1NwnbRtItrB4Rp/75VnDzBkxmJDsGdc6AExaw9JjAzdmcAPtzGWvQks=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(10070799003)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(38070700021)(56012099006)(11063799006)(5023799004)(261026140227099003)(261028144727099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3VpSWlETXR0M1F6clVWckMxZ1JvbGpsWWhxM2E3aVZDaEdwUzk5K04rMUZm?=
 =?utf-8?B?L0s0ZkNianNzaCtmMzRSV1QvRXZpdTFxcG9rQXZsVk5scXd2NUVMS0ZsdXhN?=
 =?utf-8?B?WGwybFN5MnorRWw0aUVKQUJtSU5ySjFHVWRIajl0OWZCcUcyTmFhVVhJS1Ux?=
 =?utf-8?B?VitxK29lVnpvdDdDdlk2enlUbFFrb1JsOWdyeDh5aDRIZmNDdG5JSjF3eGND?=
 =?utf-8?B?NmlkaWhSR24vejdWUko0NWdlRWVwVGozcHN5MGxBYlJta2ZjNENYWXNJWWZF?=
 =?utf-8?B?bkdTT0FUSXo2VUhWeHE1WThGZHVtSnkxbkVwOGJGemZBRmVHUjZ3QUh6Y0Ny?=
 =?utf-8?B?K3pOdjAzNGNpa2pLQkFhdVdDSlJNOE9RcUhCUGNCWlg4cDBJWmxGWEl5azgz?=
 =?utf-8?B?ZklYZ0NJaThvZ2J1akRzS3Q4WXR6VkNYYkFVSFc0dk9EbnRFN09QQnd4akU0?=
 =?utf-8?B?cGoyWU8xYlVPUWpWamdnVS96cUZVa25KUmZlOUMwbXIxZmhaSUtTSmlVS2Fh?=
 =?utf-8?B?V3FOZlpCUjV0QndvR1A0Z3QrZHNBUHRKajljRVo4NVZPaGdlQUtvc2cyWXJv?=
 =?utf-8?B?SlRISEx4QzZTZ0Vxb2dmekRpREwvRUdEelNtSFhieXNGWU02emQzRjcxVHRj?=
 =?utf-8?B?cTFTaFNQOGcwTEVQZGtVUnRRZTFQZ1JnbDF0YlBqOGZRczY0N0MyZXhoQ3lL?=
 =?utf-8?B?R0w3bmhTdC9BU0R0WjI2QUtSR2p5U0xyNHlFTGpGakE0bVZ3VFVYRy9wMmpL?=
 =?utf-8?B?dXpzdCtDc0lQRjJLNWJSaUhuZm1ja0pWVndNVUZpeWFRR1BOcEhGWkUxRWNz?=
 =?utf-8?B?QVROYjJ6UnF5cWxab2FvRUxMMU0rTWRnemp0ZVhsK25xQldrSWJVNXM0ajVJ?=
 =?utf-8?B?OHV3WUNCeWsremRLWVRBby9DYTJmcDZQN1ZMcTlaVVg2dVBwdW9BQmdaQ1lj?=
 =?utf-8?B?NVNJVjFFQXE2ZmpFZ1BWSjZGblRrZG5oQ0tvYTdzVng5R2tKYS9zYTJmYnor?=
 =?utf-8?B?azlTcStUaFZaVGUvRUdVSmRlbVliS0hVbmxHQkhiOGdteFNvM3VxZmUvVlFY?=
 =?utf-8?B?Z3UwajdDNUpZTHZ3ejlDTkNSVFc3aThIK1hUSUhoVE45SjVSd3QydVh5Zzkx?=
 =?utf-8?B?R0lKZEVkT1NEOWVuMUhqcVlOZnYzWmpiNjBvNUErQUc5andIZFUyRDJIKzNs?=
 =?utf-8?B?MWxXWFVObFdNRzBmcVFTSmhRUThLajFuVVBVUHJyR3JzSGhENFB3TmJwcEtL?=
 =?utf-8?B?N1UyNXhoZzFnQWdvY1BtNm0rL1IzMkdQR0dkRnNFL2JaNjhmcDZRYUFvejZ1?=
 =?utf-8?B?Y1pka1cvT2lPUHlnVWFqNVFRM2h5UVFRQ1JrWVU5VURnd1VBSm9zTUpwYUVo?=
 =?utf-8?B?cGtUUXNKenhmYXFvUk9oSVBVSytJVUtUUEExeEZHVkY0SlBaVHc3SUczZWFO?=
 =?utf-8?B?U1VNdjlORWpYV2xPY1VsZVN3ZFRUV01tTzJycnZvQVA0SDhWTHBSSXlpY3pp?=
 =?utf-8?B?Z3AwcUozWjArOGRCbTNmL0pxU21GZjFiUHh5U240TnlxZU8vdm5OaWV0cUE0?=
 =?utf-8?B?SEkzZE5YaEFaRWZmdTR6cWRERDB0bFBraUxNZHJab0xYTmFZYVNIZ0lQb2tM?=
 =?utf-8?B?Y3RhaFZ6Mk9JVFhEZllVNDVqNCthU0ZSaFVocHZ1d0dMcVdKQmF3SUlHajN0?=
 =?utf-8?B?M044ZkdiNWdiREE4MzlCNnZUcVJyeGpVMU8xM2c2N0hDejI5RjdjbS90eXVW?=
 =?utf-8?B?UnVlV3puUTdLb2RJdlBIMlY0b1Fta3RHL3BtbDlHMjNNYVdNUmRkb0wranRy?=
 =?utf-8?B?MjlKT2xtbjBFZWdQenRwMjZhN2ltR2pLM2pHSzJwUlV3SWVvK0lhUDVsK0JK?=
 =?utf-8?B?V0dZdCt4SSs1WlJkMnJXT09ZVTFBbDRSN1VudUVvek5hQ3F2enV0UkVReVdH?=
 =?utf-8?B?TlQ3VGFwd2FUaTJoZUd2ejVMN0NoTlMycTQ5VEQ2c045N0szZnpaa3l3WkpX?=
 =?utf-8?B?M0d0cFRKWlRhcmFBckg3cWdraTdRNEg0QU84WUg3RTVJdjNIY3RXbFZrT0xi?=
 =?utf-8?B?NnRkNGp2dkNhcGFNeXZSenBzZC9PSnRCUUtma05OZElQd1ZDdDZjZXdsSi9t?=
 =?utf-8?B?RDRpMDdNVHkxMkdkYUI3bzRZNldDNktLOWFoa2J1ZGh6bTkyNTJLNnl2U28x?=
 =?utf-8?B?MWI1Q2dGWjNMR2pYckoySE5peW1UYW51OE9YOU41ZE1LQW9rWTJRWi8rV1pa?=
 =?utf-8?B?WEtsMTRUSUs5U0huL0JvRTNaRzdDNkorT1liT3NGSzJDOXhSZXBESjRxZXF0?=
 =?utf-8?B?SWw0aWlORUl5QTdmbU93UGtsZm9PdGNReXFpbiswNlBoSWRQY3dkUHZjZHd5?=
 =?utf-8?Q?Bh5QmDgC4rZ7IkuZqfEqovrD5WCNQP+1a2jvBzEzM7JHo?=
x-ms-exchange-antispam-messagedata-1: 567L424vDqfhXiaKF66BISEyo2VEWQDtpe0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FE229439D8E3E408B1D6B0C10AF8789@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nJotpDH/dH7QT9AG0ICKZsKDyqDFSlVIF8Up/+b8uYqMmRcPZ/H4IjKa+JXhzdLmRnZEV3oALI6dgAYzWwW70aHdUQC1NbNp26qm31bzNKn/CiqbbIQRU0AQOr4GtuVNciDqI2quhFqe0uZ4VltHzbPZTQTOx4nQdiUIfSie6eMU2B6JxN67EVau+ddjZacAljGSEwfpgrQgwUED296a+IOKwpqDl+XhU/lTIh2T9VFD9iNCNtGJZ4O4+MIsUzYKAheO5TpZkrJXpud9fs0AGKVSJtUC9w60opXIwyCw9rBBUgsTd8FSuL0Z7qqbvYMd81MoB8+QY+2Us+G/tMnJHQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XX/mrXsfMDgptDv1JBWZO6DH3iDrw4tAX35JjBZoVsChK2SWom198jtzJ430n0Cdjsv55+yiN5fSvJuyK+9oETLRmWqwhz5cXQ06eZAiYP+rhMiaisB46HZadVeCNeSYg5lfzo/xqfMG6SK6CDy98iLKRUEc3B/CdD+T29p4LAEXLzVyJURYUoqeWmEty79bx/nsFLFegGs4XRCu3grGfiy3zBdNQP3YaOH5rJp1UhXainZxeAHrPEadV14OyUK/nhxYavDwQCcTTlre+FxgRVu+98IlBJvN+5FeYluW3MzBhgEvqDLf9faC/lOmgi9ufZVQ9nlUhyUdupouLDItM5bc2yfkhoTCsb44RL82POft77ofO57fLrKtclGzRlLYFiZaDL20XZgyrqXvSR8Y13QS8liVh0MdakFVC3GyYM0fZNwihO7QhyIokFlQP6MiUkGa4ZtOa2eVIHej3QxkoD3RTIxacM8+0cvsJkUpOWg+OjQySEbCanNDUS63yq8uEqCDtMcPYqHMRCkEi4QyvsYFeM15QRXX5mp90+LfOKHqz+YJDMJ1mzzV6xWOhTCCzbLQ6OBaikwsoCUDwvp3cc7pdF6WR2qZpDeEP9Juusw/UxssyC8Qsd2CCK1SzPdz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e15c15f-5226-4230-c2a4-08df3af7762e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 04:44:22.3101 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5b6PwE22ZeFgbXn2degDOr2YdQzaRoPNm8BKfyLiB4rZSAkSkWbM7x2rZa7RPvTIL4VBawGSb7HeEpF66tCVszpoSlHRl9kRpop9f04kaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8656
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU3VuLCAyMDI2LTExLTAxIGF0IDExOjE1ICswODAwLCBUYW4gQ2hpIHdyb3RlOg0KPiBXaGls
ZSB0ZXN0aW5nIG1pbmltYWwgUklTQy1WIEtWTSBidWlsZHMgZm9sbG93aW5nIGZlZWRiYWNrIG9u
IG15IE1TSQ0KPiBhZGRyZXNzIHRyYW5zbGF0aW9uIHBhdGNoLCBJIGVuY291bnRlcmVkIHNldmVy
YWwgYnVpbGQgZGVwZW5kZW5jeQ0KPiBpc3N1ZXMgaGlkZGVuIGJ5IHRoZSBkZWZhdWx0IGRldmlj
ZSBjb25maWd1cmF0aW9ucy4NCj4gDQo+IFRoZSBmYWlsdXJlcyBjYW4gYmUgcmVwcm9kdWNlZCBv
biBhIFJJU0MtViBMaW51eCBob3N0IHdpdGggdGhlDQo+IGZvbGxvd2luZyBkZXZpY2UgY29uZmln
dXJhdGlvbjoNCj4gDQo+IMKgwqDCoCBjb25maWdzL2RldmljZXMvcmlzY3Y2NC1zb2Z0bW11L21h
dHJpeC1zaWZpdmUtZS5tYWs6DQo+IMKgwqDCoCBDT05GSUdfU0lGSVZFX0U9eQ0KPiANCj4gYW5k
IGNvbmZpZ3VyZSBvcHRpb25zOg0KPiANCj4gwqDCoMKgIC4uL2NvbmZpZ3VyZSBcDQo+IMKgwqDC
oMKgwqDCoMKgIC0tdGFyZ2V0LWxpc3Q9cmlzY3Y2NC1zb2Z0bW11IFwNCj4gwqDCoMKgwqDCoMKg
wqAgLS1lbmFibGUta3ZtIFwNCj4gwqDCoMKgwqDCoMKgwqAgLS13aXRob3V0LWRlZmF1bHQtZGV2
aWNlcyBcDQo+IMKgwqDCoMKgwqDCoMKgIC0td2l0aC1kZXZpY2VzLXJpc2N2NjQ9bWF0cml4LXNp
Zml2ZS1lDQo+IA0KPiBXaXRob3V0IHRoZXNlIGZpeGVzLCB0aGUgYnVpbGQgZmFpbHMgdG8gbGlu
ayB3aXRoIHVuZGVmaW5lZA0KPiByZWZlcmVuY2VzDQo+IHRvIEFQTElDLCBHUEVYLCBwbGF0Zm9y
bSBidXMsIGFuZCBSSVNDLVYgTlVNQSBoZWxwZXJzLiBUaGVzZQ0KPiBkZXBlbmRlbmNpZXMNCj4g
YXJlIG5vcm1hbGx5IGhpZGRlbiBieSB0aGUgZGVmYXVsdCBkZXZpY2UgY29uZmlndXJhdGlvbnMu
DQo+IA0KPiBUaGUgZmlyc3QgZm91ciBwYXRjaGVzIGZpeCB0aGVzZSBpc3N1ZXMgYnkgbWFraW5n
IEFJQSBhbmQgZGV2aWNlDQo+IGhlbHBlcnMgY29uZGl0aW9uYWwsIG1vdmluZyBwbGF0Zm9ybSBi
dXMgRkRUIGNyZWF0aW9uIHRvIHRoZSBtYWNoaW5lcw0KPiB0aGF0IHVzZSBpdCwgYW5kIHBhc3Np
bmcgc29ja2V0IHRvcG9sb2d5IGRpcmVjdGx5IHRvIEtWTSBBSUEuDQo+IA0KPiBUaGUgZmlmdGgg
cGF0Y2ggZml4ZXMgYSBzZXBhcmF0ZSBtaXNzaW5nIFNTSSBkZXBlbmRlbmN5IGZvdW5kIHdoZW4N
Cj4gYnVpbGRpbmcgYSBtaW5pbWFsIFJWMzIgT3BlblRpdGFuIGNvbmZpZ3VyYXRpb24uDQo+IA0K
PiBUaGUgYWZmZWN0ZWQgbWluaW1hbCBjb25maWd1cmF0aW9ucyBhbmQgZGVmYXVsdC1kZXZpY2Ug
UlYzMi9SVjY0DQo+IGJ1aWxkcyB3ZXJlIHRlc3RlZC4NCj4gDQo+IFRhbiBDaGkgKDUpOg0KPiDC
oCBody9yaXNjdjogQnVpbGQgQUlBIGdsdWUgb25seSB3aXRoIEFQTElDIGFuZCBJTVNJQw0KPiDC
oCBody9yaXNjdjogQnVpbGQgZGV2aWNlLWNvbW1vbiBvbmx5IGZvciBpdHMgdXNlcnMNCj4gwqAg
aHcvcmlzY3Y6IE1vdmUgcGxhdGZvcm0gYnVzIEZEVCBjcmVhdGlvbiB0byBtYWNoaW5lIGNvZGUN
Cj4gwqAgaHcvcmlzY3Y6IFBhc3Mgc29ja2V0IHRvcG9sb2d5IHRvIEtWTSBBSUENCj4gwqAgaHcv
cmlzY3Y6IFNlbGVjdCBTU0kgZm9yIElCRVgNCg0KVGhhbmtzIQ0KDQpBcHBsaWVkIHRvIHJpc2N2
LXRvLWFwcGx5Lm5leHQNCg0KQWxpc3RhaXINCg0KPiANCj4gwqBody9yaXNjdi9LY29uZmlnwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKysrKysNCj4gwqBody9yaXNjdi9haWEu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTEgLS0tLS0tLS0tLS0NCj4gwqBo
dy9yaXNjdi9haWEuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTcgKysrKysr
KysrKysrKysrKy0NCj4gwqBody9yaXNjdi9mZHQtY29tbW9uLmPCoMKgwqDCoMKgwqDCoMKgwqAg
fCAxMyArKy0tLS0tLS0tLS0tDQo+IMKgaHcvcmlzY3YvbWVzb24uYnVpbGTCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgNSArKystLQ0KPiDCoGh3L3Jpc2N2L3NlcnZlcl9wbGF0Zm9ybV9yZWYuYyB8
wqAgOSArKysrKysrLS0NCj4gwqBody9yaXNjdi92aXJ0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCAyMSArKysrKysrKysrKysrKysrKystLS0NCj4gwqBpbmNsdWRlL2h3L3Jpc2N2
L2ZkdC1jb21tb24uaMKgIHzCoCAzICstLQ0KPiDCoHRhcmdldC9yaXNjdi9rdm0va3ZtLWNwdS5j
wqDCoMKgwqAgfCAxMCArKysrKy0tLS0tDQo+IMKgdGFyZ2V0L3Jpc2N2L2t2bS9rdm0tc3R1Yi5j
wqDCoMKgIHzCoCAzICsrLQ0KPiDCoHRhcmdldC9yaXNjdi9rdm0va3ZtX3Jpc2N2LmjCoMKgIHzC
oCA1ICsrKystDQo+IMKgMTEgZmlsZXMgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKSwgMzkgZGVs
ZXRpb25zKC0pDQo=

