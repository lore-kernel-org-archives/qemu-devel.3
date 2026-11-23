Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295BD606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=BLWY/HP4;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=jR4pEwss
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJlx-0002Xf-HJ; Sun, 22 Nov 2026 21:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJlu-0002Wa-MO; Sun, 22 Nov 2026 21:27:10 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJls-0002ci-Jo; Sun, 22 Nov 2026 21:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795400828; x=1826936828;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CCRzxMfMgrBjnMq1o+6LSrlmZhT0vW2PSHugOk2XgLY=;
 b=BLWY/HP4PeOLKtHwBS8BIZHON/Mj95bbJ0m4MyKk35oXQz3Rgj4b7nTn
 6Xoscym7AkcdLxmhuLICjM7ys7hPqCR0zPzknsLAG4vweY1EpH/9sFqqM
 By92B2Z2P+Dh/IWSQfUWsX7FVJrJl/DK3GAUH7cuO1M1iiKVXyKmvV+US
 5aHV94dL56j+iIl4wS7oUUCIL305NhRuVMpCdVdxqGvbwp1DcP+DA9LZN
 K2E2Sq1qSKx5iVodY6tc4yAqu0tLUINqtVP/a/np7EZ25aKdEZ1CJl6MN
 DIG6M0tao0xp5EL3r5KzAjodnnS6pRBaqQt7iX0HY2q+ofkdQ3qjKsPme A==;
X-CSE-ConnectionGUID: NBXyJXAtRnqQNTAgICX0cg==
X-CSE-MsgGUID: /hYal4iVS76mq0laPPxwsQ==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="159904909"
Received: from mail-westus3azon11010016.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.16])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:27:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sGIsnrCv4kGsgrOSUUtxrenGv0C4jOUdX+duQAcWLDTXx6GR3Eku19nTdST5D8CWI48ZgQBzbxdE/PWJgvZLxfTtJ9fPQMzi45vSXL7F+gGNhzRdoI29prHwtz7P+FaKY4Jz3pUjKQ6YGl1oVonKWVSwtWjcGB7MrNP4hPQlTXIubQhFe2Mo1xBZrY/ZDgE+XvSvdlZjPlFgcqmQNWhg+HWkvdY3jQnkVOMTzvd91BbipnwnAyNJ74j0CSK1HyMvJwHHjqfE2QBfaSXZjTIIahGkbYChf02gjUKc1nxbImv70VTLLoUcfXc3uNdBrOF5etB6pduD7y1k+IJBJ7jEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCRzxMfMgrBjnMq1o+6LSrlmZhT0vW2PSHugOk2XgLY=;
 b=kBXCwIhoSeNXfuKw5tx4CXWoN66NmroJn+Xg70RTLVAM9e+QxgHkl6BdV9BAUHXNB9vk/mBaqDbVBiDPu/9TxaFLBJ5uBJOKB0Gzgvg6Sy1A+JlmjeOrY6jtE5Telfy63H+74AZm5ODlLo6MuTpLObQwvUKaeWJvLuJE+phGbtbivBQWkp0PVb4KVRzDEeavxKAOTj5LhiExmHHiiY4x92WY6Czpn1F/LwfONr6L1NBlDqoHNkIG5cbX+3uISav2DltHfoKmjKM724/PfetqNGA3qfyqhgLYdl7GgOoYlxUaYQmrgYjfHhRGKtowNLxfMMUQ4Oz/4FX+YvbsidPWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCRzxMfMgrBjnMq1o+6LSrlmZhT0vW2PSHugOk2XgLY=;
 b=jR4pEwssbowYv1p3lf665L7I4epN/8r7v0UwIlhraSD0ks0K4XbDBvW+ojo/IX/LrtfhCpIxeppLsoZMQ8YOC9jWUB4B1D/xpbqMXrwpeEsawZ8yi4uSWTe08w5iquUenwpjz//1GjQWbPkXYR5LTQMxsN2bwv/PUtchm0i119c=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BY5PR04MB6929.namprd04.prod.outlook.com (2603:10b6:a03:22c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Mon, 23 Nov
 2026 02:27:03 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:27:03 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "farman@linux.ibm.com" <farman@linux.ibm.com>, "zhao1.liu@intel.com"
 <zhao1.liu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "asrinivasan@oss.tenstorrent.com" <asrinivasan@oss.tenstorrent.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "mpe@kernel.org" <mpe@kernel.org>,
 "visitorckw@gmail.com" <visitorckw@gmail.com>, "qemu-s390x@nongnu.org"
 <qemu-s390x@nongnu.org>, "npiggin@gmail.com" <npiggin@gmail.com>,
 "portias@oss.tenstorrent.com" <portias@oss.tenstorrent.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "mjrosato@linux.ibm.com"
 <mjrosato@linux.ibm.com>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "joel@jms.id.au" <joel@jms.id.au>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "mst@redhat.com" <mst@redhat.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2] tests/functional: use immutable tuxboot kernel URLs
Thread-Topic: [PATCH v2] tests/functional: use immutable tuxboot kernel URLs
Thread-Index: AQHdcqpvXsy/WOZUdkuH7aStzYndJrc6/uiA
Date: Mon, 23 Nov 2026 02:27:03 +0000
Message-ID: <7724d24789e82aae1faa73400fd31824b8cdb85b.camel@wdc.com>
References: <20261112133320.418012-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261112133320.418012-2-marcandre.lureau@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BY5PR04MB6929:EE_
x-ms-office365-filtering-correlation-id: 88cdb2a3-f713-4f83-11a6-08df49094297
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|10070799003|1800799024|19092799006|38070700021|10067099003|261026140227099003|261026135527099003|11063799006|261026130827099003|56012099006|261022105027099003|261022075727099003|261021123027099003|261009223027099003|261102123227099003|261021130227099003|261021133027099003|261021121427099003|261021135927099003|261028144727099003|261022113327099003|261022115727099003|261026121527099003|22082099003|18002099003|13003099007;
x-microsoft-antispam-message-info: /99Y0SBcJrEYw/DacezgI6ce9RekqCgnpDLz7WKW2PDY5QH/Kb5VBFRS6+ndX2EU3rOWDrxmoWCzQrUPh12H4pcyt36lBCuRdmr5Y51RFaNyt41OCkOFKt1RZFOXcgO4HMZdke3aMeyxpi7Q11BshitEdeKWA3qvdYhb8yLy4yu8Hi1tvW/xZ4RFeVnY1d6leV0fx2NkCcVai//kjbH5jM3/GgyhuDmgrZ5TwHu3aUZ/JsQa0yavGOQsvdJUA8shrsWgV+eImeA98xPb5ePSChygjoV6bK3ATJ9q0SFTvwrF3C6fDyddbO7TlprvWjxbXodzSP0UpPznoumtgfd10o2+NEgTdHssC3i8faQHYTCd6hsbeIwjYUtOam6q47DMPViQ1m4sG+S4ENwlPOui1jLw+7W2ONhJUrUcun2Lk0FoeM5O4+d22Fq+IP9GY91NzhEOQ5DaW6XKpYX6Gqz3HZqRqAzZYvz5nis6H8wIWnsksnclIGKXlNLqqo0GbUaHPAndnQr2OU6ONEx98F5o+rPBX2B52Vx5QU4rNQTMrlO+q27/kaVEqM3WYTpwDWFz+WpgqVT8WkqEv6hEOTIZYfo3heIYwy+p36kHlVr6W/+WsyXAdwQhhBtPcWMCvRgy388Ae/Q08snn3LwmU3P2hXiQrCKaateMo3o+QUO9+D4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(10070799003)(1800799024)(19092799006)(38070700021)(10067099003)(261026140227099003)(261026135527099003)(11063799006)(261026130827099003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(261102123227099003)(261021130227099003)(261021133027099003)(261021121427099003)(261021135927099003)(261028144727099003)(261022113327099003)(261022115727099003)(261026121527099003)(22082099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U05CT2FhbGMxcDJacWNPWlpISHV6ZEtRWDhja1oyMkZCOVBkc0NxU1MrV2FC?=
 =?utf-8?B?ZC9uWnFDZ0pOeWhSbVlRT00rUVNCUUxlQzlEckViMWJPVGl0UUMwM2syNDdj?=
 =?utf-8?B?K3A4b00wL3g1aHVDMk5QM0t4c3RQczE1ZDJtR0txek1yVWUrNFczVlpTaFVq?=
 =?utf-8?B?dTlleGRTa2dWSkYyNU1qZDdqZUw1UElZR0o2U3hkYlcxeVlveklvZ1pJalpX?=
 =?utf-8?B?bEJDUFVuRlR3RUR0YlNIc3o1eVFQRDBJT21PZ241aVFnOUkxQktOK2xpME8x?=
 =?utf-8?B?RllxWjBFSXArbUNCTWRsZEJibFcrWkZQbFlFeTN6cFk0d2hrK0Y1d0NnQjcr?=
 =?utf-8?B?aUJ4S1VJMWJRRXNYS0hWeCtoNWpDUjlKT2FmVVcxRXlneVM5MUhBaHZaU0Ns?=
 =?utf-8?B?b2ZnV05Gc0tZVldXMThhRjJOZHNxWGlqM3hNbllaalhYeUtTMm9KamNlSlZm?=
 =?utf-8?B?dUo1S3FWa2lGY3d1R1A5T0U3M0ZVRW9xUnNzNnNBTTVBNDhIS1R1NGprK3Fs?=
 =?utf-8?B?RzNGNW4rdXlNNmR2cmZuR2UvekJ3amhPT1NMd1J2ckpqRzF1Slo1V1cvQVZu?=
 =?utf-8?B?SHVMenhNeTdVSmxLYmRtY29VZ1FSYll6Ty9VWWJWWS8wM255QnVmdDdhclFj?=
 =?utf-8?B?eDdEaDE3eDBHV1NzMnVuaEQ2UVVqTzZ0Y0ozZHFmTzdtSXVqcU9adDBmaDd5?=
 =?utf-8?B?U3hiMGg5L3k2Zzl5dnFVY244YU1BMGVCWDkxeFFydE1DTlkxTEVEV1lBcnBu?=
 =?utf-8?B?T2F3NmkvTTdNQnU1eHRQb0dENENWZW1YM0lHdStPT1N3QjIvTzBsRjhsb1JD?=
 =?utf-8?B?dDlKNHRTV2hKRjMvMlp6N3A4VWNqaitjZGtmbXVGWWlSMHFlSXp3U3dORUFs?=
 =?utf-8?B?YUtFd3VCRHpmWnpuZjRrQkthN1VIMXdza0t2RkcxOXQ4YU9jdnlFdHN0WWJi?=
 =?utf-8?B?VFo1c2svT3ZwQU14dHVLTE1raE1wOXF1ZFFrZnJ5anpRaGpWdW9seWczRkx0?=
 =?utf-8?B?cEhnNmp1dVptNklSUkw4UUVrZk9SRFdOUFczTUpLOGlQV09FM2hzSEptMEVy?=
 =?utf-8?B?dCtUSWhJMWNwancwNVlpckh1QVdJZzV1RERhMTVRREpHOGFUOTZ6UDFsSUx5?=
 =?utf-8?B?MGVZM2pNc2c1MU96ZFdEdUx0cTZKd3F4blBwY1RpWHNidkpLVTV4M21wOVI3?=
 =?utf-8?B?ZGc3a3ZSWW1maFFBRGNUK1NKQmp0UUN6V1dUOVR0T2ZXbFBnU0pYcFBjeERr?=
 =?utf-8?B?M3p4d2xsSXBHemJNWURidXFFcVA1NnBjaGlZZDV0TGhCS29SVGRrWi81YVJP?=
 =?utf-8?B?TmJRbkoybEF3bXRUTm95bDltWnZ1T2RRM1FwQ0hhSCtuWFdrblkrd1MwM0J0?=
 =?utf-8?B?dWRMcjBjZ0Q2TkVRRWg1amlwK0RYNmlZQWVnblNOZEl1YktXaGNtYmpYK2Ni?=
 =?utf-8?B?NS9iQXNwMkl6ZFZNNExCbmRBOU16dnhVKzVpdXVVREZLWXV2YjBFVVV6cTJm?=
 =?utf-8?B?cmI2a09aUnRlMlk2cWJIQjFyUm1MWkdMTmR6b1EzMW52Y3JpUllCQTJpVU9Y?=
 =?utf-8?B?S2UvWGdwZ3pKeENzTWthaEhJS1dzakRDRkhGQ2xUeVVVMzNJUkY4SzhCQXV4?=
 =?utf-8?B?Nmo1V1Rua0F5algwamRIa0R6V09UYkE0UWhRK05DTWE0VHJqR0JFUWNmdVJa?=
 =?utf-8?B?eWVuL0NmQ1VoM0FpYU5ueDRJeitYMEx4a3pzOGo4UVlubU5BL05LcTRxM3FL?=
 =?utf-8?B?aWlzTEJxcEJoSkwxRVRnZUxqeHB5WklLSTdUWFF1bXRWWHlHNmJFZUlNaG5x?=
 =?utf-8?B?dHVkSXFPbHV2N0cxMzl2U1YrUTMrVEs2TUFFVVMyNkNqS3l4OVhQcUZhWTZG?=
 =?utf-8?B?dnpWeWQ3WnlBSUZyN0ZBRXdjamVNYXpGZ0hPNUZkaXpjZkhUZ3pWYklQdjhN?=
 =?utf-8?B?T2JnY1ovZ1RRN3FLYTRHTlNCQzhKVUJmRTdoM0hhUjExOGd2cGo3bWFaRDN6?=
 =?utf-8?B?ZmVGQ3lidnAyV2t3eDQwdVZUaG9PTVp4OWFTVnhoY1V6RWdqbEpLcU5BSW9k?=
 =?utf-8?B?ZEM1TGZEY2J3eEgrNFRTNG9UYUl0MU1uSjNMTjlZVnAxL0hKRDh4UEJDSElm?=
 =?utf-8?B?K0ZxUTRDa3hpVjJuaHNFTldiWWp5WDBTaVl2Nll2bW9PaVMzTWtiTy9QSXZP?=
 =?utf-8?B?ZTQ0RUhpQU9DbEYwWDgxbkFTSCt3bW1BOXIvR01JdkNBa2QyNFBzYk5QL1Bi?=
 =?utf-8?B?Qk9Lb1FuSlA2anB3aFMydERucDVmWi8wWjBWLzBOMThaSDAzM09wV1FCWnlk?=
 =?utf-8?B?clFjM2JuZHFyTm9mc2d5b1A3SXltNitkOFdJdkhiVHRWWXJObXVzUUFKcFVB?=
 =?utf-8?Q?rSy1JSdOP7Kge+gYA313f2GckLXY8h2nMrbdO9HPqRBRN?=
x-ms-exchange-antispam-messagedata-1: 4kfhPlKb4fDKcF3aUbUgSD15gpc1Mxcguow=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54A6C9A983F3FA4D8EDAE2CC2A105211@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IkY4dYX9XJY8r+dTyU7J6Py24EhFqeqaM0IkU4Dixq2cTRyKxvVBADFyRrakHzuKK1lRcOUbF+jyNI+Gj6XU//Uo4ke92+h0mYL3dpztdeIjilCOzjaJepRVgBs0lKD7YUU/QobdjlhpGqeSYMV7Fmf/UyzcY2T7Qrwu7me/2ERZ6PQIR6ppOpvjc/zSd/TklHSqc9V9lIWmrkapuTXGS70Qk0EhVwF5SKU2/x73glWFNMI5ZsAUlXD5VPbyEedtLchUomjaKyRQdkVvvYt2+BqbWm4zAuVPoaQueYq0YTWmMQCWAyYta1lopBoVo3fycbiEjDqfiSD71kWzBRTQcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EmFktU87TYxE8bqWqDIevUhq1U1FrUnmFg2sFXK2y+CuArKli4tYztAKydTB9XZxXcO520gUiAliw08i2/L6nSJPuYnzW5KgH2+Fu9NRrYCZbx2sln4tJjxRU8sV7V/ru1gS9RdPqNfTNaLF2cjYCngN983iUXu7tLw7rYY3MzGyZ+qcoGLee7aL8fHf2j6X4LMCTBCFyhIHFnqy5seSEM7yZJ7nsUtbBK92eNBe1Mlct+ys80K55q5pDjKKWi2J1MH2cLW71KptTuZnJr4bR7/xAZyRU+moro+Jo6BbAJ6ZlvxdlzRHgCpEnq9NF0AtfSPRyhIWvLDzrcU+9uA5YRN5FbHdXJ25lMY8oX3SRHvSPQphx2/PBmZDQ5b+JIzRq1SFXvsjlYRPQxgUP6Lc01FoPvTfORT6gyCFjJxHFqW7azK9uQELvor5KZSZwHhftwW5XxNiK6aOTI1z/Ju15YrsNV/3AAYGmpvOiUPym/2PLOFZKo72z4B3N7/A6nZ27LgbB1M5+UQI4uCUxn4rsp6qA65Y1bdElEfNEV63WIo2Cq9PZUrAukj1Be2EfN1OoGfa4W3DS3bbEJxrDrXkU7dxmGso4n1xvRBTbBFAeuVycsHr8O1DSqmcbXvPltfu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cdb2a3-f713-4f83-11a6-08df49094297
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:27:03.0531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Md0+gTkUNRh3dMOYE7NlRAIFKDd7evcCCwIekuPXyBrQVax37GT9JGsnkv+kcQALa/TV1m/QPaKcY2T2G/9D/YmCpIjX5qXotq+DtUIdoPc=
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

T24gVGh1LCAyMDI2LTExLTEyIGF0IDE3OjMzICswNDAwLCBtYXJjYW5kcmUubHVyZWF1QHJlZGhh
dC5jb20gd3JvdGU6DQo+IEZyb206IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVh
dUByZWRoYXQuY29tPg0KPiANCj4gdHV4Ym9vdCByZWJ1aWxkcyB0aGUgNi4xOC41NCBrZXJuZWwg
aW1hZ2VzIGluIHBsYWNlLCBzbyB0aGUgVVJMcw0KPiB3aXRob3V0IGEgZGF0ZXN0YW1wIG5vdyBz
ZXJ2ZSBjb250ZW50IHRoYXQgZG9lcyBub3QgbWF0Y2ggdGhlDQo+IHJlY29yZGVkDQo+IGhhc2hl
cyBhbmQgdGhlIHR1eHJ1biB0ZXN0cyBmYWlsIHRvIGZldGNoIHRoZWlyIGFzc2V0cy4gUG9pbnQg
dGhlDQo+IHg4Nl82NCwgYXJtNjQgYW5kIHMzOTAgdGVzdHMgYXQgdGhlIGltbXV0YWJsZSAyMDI2
MDkzMCBzbmFwc2hvdHMgYW5kDQo+IGtlZXAgdGhlIGhhc2hlcyB0aGF0IHdlcmUgcmVjb3JkZWQg
YWdhaW5zdCB0aGVtLCBpbnN0ZWFkIG9mDQo+IGltcGxpY2l0bHkNCj4gc3dpdGNoaW5nIHRvIHRo
ZSByZWJ1aWx0IGltYWdlcy4NCj4gDQo+IERvIHRoZSBzYW1lIGZvciB0aGUgcmlzY3Y2NCA2LjEx
Ljkga2VybmVsIGFzc2V0cywgd2hpY2ggc3RpbGwgdXNlZA0KPiBub24tZGF0ZXN0YW1wZWQgVVJM
czsgdGhlaXIgcmVjb3JkZWQgaGFzaGVzIGFscmVhZHkgbWF0Y2ggdGhlDQo+IDIwMjQxMTIyDQo+
IHNuYXBzaG90Lg0KPiANCj4gRml4ZXM6IDhhYzFhYWIyMWZjYSAoInRlc3RzL2Z1bmN0aW9uYWw6
IHVwZGF0ZSBhcm02NCB0dXhydW4gaW1hZ2VzIikNCj4gRml4ZXM6IDA5OTYxZmFmYzVhMCAoInRl
c3RzL2Z1bmN0aW9uYWw6IHVwZGF0ZSBzMzkweCB0dXhydW4gaW1hZ2VzIikNCj4gRml4ZXM6IDQ2
N2M5ZWI3ZGQzMSAoInRlc3RzL2Z1bmN0aW9uYWw6IHVwZGF0ZSB4ODZfNjQgdHV4cnVuIGltYWdl
cyIpDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVh
dUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRlc3RzL2Z1bmN0aW9u
YWwvYWFyY2g2NC90ZXN0X3R1eHJ1bi5wecKgwqDCoMKgwqAgfCA0ICsrLS0NCj4gwqB0ZXN0cy9m
dW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9taWxrdl9kdW8ucHnCoMKgIHwgNCArKy0tDQo+IMKgdGVz
dHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfdHRfYXRsYW50aXMucHkgfCAyICstDQo+IMKgdGVz
dHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfdHV4cnVuLnB5wqDCoMKgwqDCoCB8IDIgKy0NCj4g
wqB0ZXN0cy9mdW5jdGlvbmFsL3MzOTB4L3Rlc3RfdHV4cnVuLnB5wqDCoMKgwqDCoMKgwqAgfCA0
ICsrLS0NCj4gwqB0ZXN0cy9mdW5jdGlvbmFsL3g4Nl82NC90ZXN0X3R1eHJ1bi5wecKgwqDCoMKg
wqDCoCB8IDQgKystLQ0KPiDCoDYgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0
L3Rlc3RfdHV4cnVuLnB5DQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9hYXJjaDY0L3Rlc3RfdHV4cnVu
LnB5DQo+IGluZGV4IDJmZjMyMTU4MmQzOC4uMDM1OTg0ZDhlM2U1IDEwMDc1NQ0KPiAtLS0gYS90
ZXN0cy9mdW5jdGlvbmFsL2FhcmNoNjQvdGVzdF90dXhydW4ucHkNCj4gKysrIGIvdGVzdHMvZnVu
Y3Rpb25hbC9hYXJjaDY0L3Rlc3RfdHV4cnVuLnB5DQo+IEBAIC0xNywxMCArMTcsMTAgQEANCj4g
wqBjbGFzcyBUdXhSdW5BYXJjaDY0VGVzdChUdXhSdW5CYXNlbGluZVRlc3QpOg0KPiDCoA0KPiDC
oMKgwqDCoCBBU1NFVF9BUk02NF9LRVJORUwgPSBBc3NldCgNCj4gLcKgwqDCoMKgwqDCoMKgDQo+
ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20va2VybmVscy82LjE4LjU0L2FybTY0L0ltYWdl
Lmd6JywNCj4gK8KgwqDCoMKgwqDCoMKgDQo+ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20v
a2VybmVscy8yMDI2MDkzMC82LjE4LjU0L2FybTY0L0ltYWdlLmd6Jw0KPiAsDQo+IMKgwqDCoMKg
wqDCoMKgwqANCj4gJzM5ZjQ2MzNiYmNiNDQ0MjY3ZDRkODI5YmQyOGQ4ODY4YTI4N2M0YzE2MGNk
YTY0YjBmZDIzZmIwOTA1NzFjNGUnKQ0KPiDCoMKgwqDCoCBBU1NFVF9BUk02NF9WTUxJTlVYID0g
QXNzZXQoDQo+IC3CoMKgwqDCoMKgwqDCoA0KPiAnaHR0cHM6Ly9zdG9yYWdlLnR1eGJvb3QuY29t
L2tlcm5lbHMvNi4xOC41NC9hcm02NC92bWxpbnV4Lnh6JywNCj4gK8KgwqDCoMKgwqDCoMKgDQo+
ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20va2VybmVscy8yMDI2MDkzMC82LjE4LjU0L2Fy
bTY0L3ZtbGludXgueA0KPiB6JywNCj4gwqDCoMKgwqDCoMKgwqDCoA0KPiAnNjQ4N2ViMTEzZWY2
ZTg0MWFlZGFiNmNiNmZhNzA0MDA2Mzc3ZDY4ZjY0ZGQ1NDQ1NzBhYTQyZjQ2MmE1MmI4NScpDQo+
IMKgwqDCoMKgIEFTU0VUX0FSTTY0X1JPT1RGUyA9IEFzc2V0KA0KPiDCoMKgwqDCoMKgwqDCoMKg
DQo+ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20vYnVpbGRyb290LzIwMjYwOTI0L2FybTY0
L3Jvb3Rmcy5leHQ0LnpzdA0KPiAnLA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9y
aXNjdjY0L3Rlc3RfbWlsa3ZfZHVvLnB5DQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rl
c3RfbWlsa3ZfZHVvLnB5DQo+IGluZGV4IDZhN2UyYTVkMTk2Ny4uZmRjODNkN2M4Mjg0IDEwMDc1
NQ0KPiAtLS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF9taWxrdl9kdW8ucHkNCj4g
KysrIGIvdGVzdHMvZnVuY3Rpb25hbC9yaXNjdjY0L3Rlc3RfbWlsa3ZfZHVvLnB5DQo+IEBAIC0x
NCwxMSArMTQsMTEgQEAgY2xhc3MgTWlsa3ZEdW9NYWNoaW5lKExpbnV4S2VybmVsVGVzdCk6DQo+
IMKgwqDCoMKgIHRpbWVvdXQgPSAxMjANCj4gwqANCj4gwqDCoMKgwqAgQVNTRVRfS0VSTkVMID0g
QXNzZXQoDQo+IC3CoMKgwqDCoMKgwqDCoCAnaHR0cHM6Ly9zdG9yYWdlLnR1eGJvb3QuY29tL2tl
cm5lbHMvNi4xMS45L3Jpc2N2NjQvSW1hZ2UnLA0KPiArwqDCoMKgwqDCoMKgwqANCj4gJ2h0dHBz
Oi8vc3RvcmFnZS50dXhib290LmNvbS9rZXJuZWxzLzIwMjQxMTIyLzYuMTEuOS9yaXNjdjY0L0lt
YWdlJywNCj4gwqDCoMKgwqDCoMKgwqDCoA0KPiAnMTc0ZjhiYjg3ZjA4OTYxZTU0ZmEzZmNkOTU0
YThlMzFmNDY0NWY2ZDZhZjRkZDQzOTgzZDVlOTg0MTQ5MGZiMCcNCj4gwqDCoMKgwqAgKQ0KPiDC
oMKgwqDCoCBBU1NFVF9EVEJTID0gQXNzZXQoDQo+IC3CoMKgwqDCoMKgwqDCoA0KPiAnaHR0cHM6
Ly9zdG9yYWdlLnR1eGJvb3QuY29tL2tlcm5lbHMvNi4xMS45L3Jpc2N2NjQvZHRicy50YXIueHon
LA0KPiArwqDCoMKgwqDCoMKgwqANCj4gJ2h0dHBzOi8vc3RvcmFnZS50dXhib290LmNvbS9rZXJu
ZWxzLzIwMjQxMTIyLzYuMTEuOS9yaXNjdjY0L2R0YnMudGFyDQo+IC54eicsDQo+IMKgwqDCoMKg
wqDCoMKgwqANCj4gJzk3ZTVlNjVhN2U2YzY4MzAzZTUzNDg2YWYxMjBjMDg0NmVlOGRmNTcyZTlj
MTVmMGM0ZGNjYjgzMWQwY2VmNGInDQo+IMKgwqDCoMKgICkNCj4gwqDCoMKgwqAgQVNTRVRfUk9P
VEZTID0gQXNzZXQoDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVz
dF90dF9hdGxhbnRpcy5weQ0KPiBiL3Rlc3RzL2Z1bmN0aW9uYWwvcmlzY3Y2NC90ZXN0X3R0X2F0
bGFudGlzLnB5DQo+IGluZGV4IDQ4YWJkNWNkMjdjMi4uN2NkNTIzNDQzMmQ5IDEwMDc1NQ0KPiAt
LS0gYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF90dF9hdGxhbnRpcy5weQ0KPiArKysg
Yi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF90dF9hdGxhbnRpcy5weQ0KPiBAQCAtMTQs
NyArMTQsNyBAQA0KPiDCoGNsYXNzIFRUQXRsYW50aXMoTGludXhLZXJuZWxUZXN0KToNCj4gwqAN
Cj4gwqDCoMKgwqAgQVNTRVRfS0VSTkVMID0gQXNzZXQoDQo+IC3CoMKgwqDCoMKgwqDCoCAnaHR0
cHM6Ly9zdG9yYWdlLnR1eGJvb3QuY29tL2tlcm5lbHMvNi4xMS45L3Jpc2N2NjQvSW1hZ2UnLA0K
PiArwqDCoMKgwqDCoMKgwqANCj4gJ2h0dHBzOi8vc3RvcmFnZS50dXhib290LmNvbS9rZXJuZWxz
LzIwMjQxMTIyLzYuMTEuOS9yaXNjdjY0L0ltYWdlJywNCj4gwqDCoMKgwqDCoMKgwqDCoA0KPiAn
MTc0ZjhiYjg3ZjA4OTYxZTU0ZmEzZmNkOTU0YThlMzFmNDY0NWY2ZDZhZjRkZDQzOTgzZDVlOTg0
MTQ5MGZiMCcpDQo+IMKgwqDCoMKgIEFTU0VUX1JPT1RGUyA9IEFzc2V0KA0KPiDCoMKgwqDCoMKg
wqDCoMKgICgnaHR0cHM6Ly9naXRodWIuY29tL2dyb2Vjay9saW51eC1idWlsZC10ZXN0L3Jhdy8n
DQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF90dXhydW4ucHkN
Cj4gYi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQvdGVzdF90dXhydW4ucHkNCj4gaW5kZXggNjIw
M2E0NTA2MGNlLi5iNDcwYzA1MzAwYTcgMTAwNzU1DQo+IC0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwv
cmlzY3Y2NC90ZXN0X3R1eHJ1bi5weQ0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL3Jpc2N2NjQv
dGVzdF90dXhydW4ucHkNCj4gQEAgLTE3LDcgKzE3LDcgQEANCj4gwqBjbGFzcyBUdXhSdW5SaXNj
VjY0VGVzdChUdXhSdW5CYXNlbGluZVRlc3QpOg0KPiDCoA0KPiDCoMKgwqDCoCBBU1NFVF9SSVND
VjY0X0tFUk5FTCA9IEFzc2V0KA0KPiAtwqDCoMKgwqDCoMKgwqAgJ2h0dHBzOi8vc3RvcmFnZS50
dXhib290LmNvbS9rZXJuZWxzLzYuMTEuOS9yaXNjdjY0L0ltYWdlJywNCj4gK8KgwqDCoMKgwqDC
oMKgDQo+ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20va2VybmVscy8yMDI0MTEyMi82LjEx
LjkvcmlzY3Y2NC9JbWFnZScsDQo+IMKgwqDCoMKgwqDCoMKgwqANCj4gJzE3NGY4YmI4N2YwODk2
MWU1NGZhM2ZjZDk1NGE4ZTMxZjQ2NDVmNmQ2YWY0ZGQ0Mzk4M2Q1ZTk4NDE0OTBmYjAnKQ0KPiDC
oMKgwqDCoCBBU1NFVF9SSVNDVjY0X1JPT1RGUyA9IEFzc2V0KA0KPiDCoMKgwqDCoMKgwqDCoMKg
DQo+ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20vYnVpbGRyb290LzIwMjQxMTE5L3Jpc2N2
NjQvcm9vdGZzLmV4dDQueg0KPiBzdCcsDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFs
L3MzOTB4L3Rlc3RfdHV4cnVuLnB5DQo+IGIvdGVzdHMvZnVuY3Rpb25hbC9zMzkweC90ZXN0X3R1
eHJ1bi5weQ0KPiBpbmRleCAxZGQ2NjJhYWFmMDUuLjQyMGU3MTQ2YmIxMCAxMDA3NTUNCj4gLS0t
IGEvdGVzdHMvZnVuY3Rpb25hbC9zMzkweC90ZXN0X3R1eHJ1bi5weQ0KPiArKysgYi90ZXN0cy9m
dW5jdGlvbmFsL3MzOTB4L3Rlc3RfdHV4cnVuLnB5DQo+IEBAIC0xNywxMCArMTcsMTAgQEANCj4g
wqBjbGFzcyBUdXhSdW5TMzkweFRlc3QoVHV4UnVuQmFzZWxpbmVUZXN0KToNCj4gwqANCj4gwqDC
oMKgwqAgQVNTRVRfUzM5MFhfS0VSTkVMID0gQXNzZXQoDQo+IC3CoMKgwqDCoMKgwqDCoCAnaHR0
cHM6Ly9zdG9yYWdlLnR1eGJvb3QuY29tL2tlcm5lbHMvNi4xOC41NC9zMzkwL2J6SW1hZ2UnLA0K
PiArwqDCoMKgwqDCoMKgwqANCj4gJ2h0dHBzOi8vc3RvcmFnZS50dXhib290LmNvbS9rZXJuZWxz
LzIwMjYwOTMwLzYuMTguNTQvczM5MC9iekltYWdlJywNCj4gwqDCoMKgwqDCoMKgwqDCoA0KPiAn
NWVmZWIzMTc1NGIyMTE0NDBlMTU5NWFiMTEzNTViYjAwNmZlNzhhMmMwNjA0ZWQwYThjNTVjNDU5
OGI3MWFlYycpDQo+IMKgwqDCoMKgIEFTU0VUX1MzOTBYX1ZNTElOVVggPSBBc3NldCgNCj4gLcKg
wqDCoMKgwqDCoMKgDQo+ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20va2VybmVscy82LjE4
LjU0L3MzOTAvdm1saW51eC54eicsDQo+ICvCoMKgwqDCoMKgwqDCoA0KPiAnaHR0cHM6Ly9zdG9y
YWdlLnR1eGJvb3QuY29tL2tlcm5lbHMvMjAyNjA5MzAvNi4xOC41NC9zMzkwL3ZtbGludXgueHoN
Cj4gJywNCj4gwqDCoMKgwqDCoMKgwqDCoA0KPiAnNWJiZDRkMzRlMDk1MGY4ODA1M2E5YmZkMTYw
Nzg4OTZkZjRiMWVlMTY5NmZjMmFkNjI0ODhlNjgxYTZiZGQ4ZScpDQo+IMKgwqDCoMKgIEFTU0VU
X1MzOTBYX1JPT1RGUyA9IEFzc2V0KA0KPiDCoMKgwqDCoMKgwqDCoMKgDQo+ICdodHRwczovL3N0
b3JhZ2UudHV4Ym9vdC5jb20vYnVpbGRyb290LzIwMjYwOTI0L3MzOTAvcm9vdGZzLmV4dDQuenN0
Jw0KPiAsDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL3g4Nl82NC90ZXN0X3R1eHJ1
bi5weQ0KPiBiL3Rlc3RzL2Z1bmN0aW9uYWwveDg2XzY0L3Rlc3RfdHV4cnVuLnB5DQo+IGluZGV4
IDFhMTEzOGQxNmFlYS4uZDJlNjAwOGFlNzA4IDEwMDc1NQ0KPiAtLS0gYS90ZXN0cy9mdW5jdGlv
bmFsL3g4Nl82NC90ZXN0X3R1eHJ1bi5weQ0KPiArKysgYi90ZXN0cy9mdW5jdGlvbmFsL3g4Nl82
NC90ZXN0X3R1eHJ1bi5weQ0KPiBAQCAtMTcsMTAgKzE3LDEwIEBADQo+IMKgY2xhc3MgVHV4UnVu
WDg2VGVzdChUdXhSdW5CYXNlbGluZVRlc3QpOg0KPiDCoA0KPiDCoMKgwqDCoCBBU1NFVF9YODZf
NjRfS0VSTkVMID0gQXNzZXQoDQo+IC3CoMKgwqDCoMKgwqDCoA0KPiAnaHR0cHM6Ly9zdG9yYWdl
LnR1eGJvb3QuY29tL2tlcm5lbHMvNi4xOC41NC94ODZfNjQvYnpJbWFnZScsDQo+ICvCoMKgwqDC
oMKgwqDCoA0KPiAnaHR0cHM6Ly9zdG9yYWdlLnR1eGJvb3QuY29tL2tlcm5lbHMvMjAyNjA5MzAv
Ni4xOC41NC94ODZfNjQvYnpJbWFnZScNCj4gLA0KPiDCoMKgwqDCoMKgwqDCoMKgDQo+ICcyNGEz
YWRlNjEwYzJjYzQyNmZmODIxMDUwZGU4YTM1OTMwYjAzNzEzNTdkOTRjYzJjMzM0YWJhYzY2NTg1
NTJiJykNCj4gwqDCoMKgwqAgQVNTRVRfWDg2XzY0X1ZNTElOVVggPSBBc3NldCgNCj4gLcKgwqDC
oMKgwqDCoMKgDQo+ICdodHRwczovL3N0b3JhZ2UudHV4Ym9vdC5jb20va2VybmVscy82LjE4LjU0
L3g4Nl82NC92bWxpbnV4Lnh6JywNCj4gK8KgwqDCoMKgwqDCoMKgDQo+ICdodHRwczovL3N0b3Jh
Z2UudHV4Ym9vdC5jb20va2VybmVscy8yMDI2MDkzMC82LjE4LjU0L3g4Nl82NC92bWxpbnV4Lg0K
PiB4eicsDQo+IMKgwqDCoMKgwqDCoMKgwqANCj4gJzc3YmY0NGNjYTQ4YzljMWI5YzE0MmUxNmEy
MzExZDU4YjhhZTM0NjJiNjFiY2U0NGJjYWY5MjQzYjVmMjY2MjgnKQ0KPiDCoMKgwqDCoCBBU1NF
VF9YODZfNjRfUk9PVEZTID0gQXNzZXQoDQo+IMKgwqDCoMKgwqDCoMKgwqANCj4gJ2h0dHBzOi8v
c3RvcmFnZS50dXhib290LmNvbS9idWlsZHJvb3QvMjAyNjA5MjQveDg2XzY0L3Jvb3Rmcy5leHQ0
LnpzDQo+IHQnLA0K

