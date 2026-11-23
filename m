Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E408606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=QlHeEAVR;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=aQ6V/bu2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJeV-0008AE-2P; Sun, 22 Nov 2026 21:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJeT-0008A0-1w; Sun, 22 Nov 2026 21:19:29 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVJeQ-0005n8-5w; Sun, 22 Nov 2026 21:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795400366; x=1826936366;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1kbz8oOQqJ3HcPR/X8sWDKxZTHbcLP8EUzlqaKaCEkw=;
 b=QlHeEAVRA3jWFxHKg88juGoD+EYndLZ9Kl0LEzuuMHSWUGrS52cD8QW4
 PTHY9y4ykaEJbtHcycBru1tGSdiDnN+7XDD7nvtE4kwIZEdBJ3ynCzRlI
 /lObvdDERTYI8n87+MvNYq/cNzLp/v8HKXSRnTtyem5Zns1kR9mT/DL+x
 GPTPZIl5mzZDompucq1GZoOd9efneJ6egT2w+ysQ6D0uTBnlOvbJeUEaY
 WsMJUceCYkyxHWZo56yvRKpZwKZoR9v0W5UmAOew8PCwRasIhIAWZgaTD
 /1B1YltZ+Uo9Hq+S6rkitBYtiTPIehusibywQVP4IPzEdkQFJ3awEIIQo w==;
X-CSE-ConnectionGUID: IgsqeB46SkyFDb7gsQetyA==
X-CSE-MsgGUID: gPbl2DzbQr6IJMGAh6yHeA==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="160550329"
Received: from mail-eastus2azon11011071.outbound.protection.outlook.com (HELO
 BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.71])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 10:19:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7t+WyD0rLIY9PFdwS8F/uH6OACQiE7hQvDteh6l/MOPcZ82he+3ezhd36aUPtlUe8pyIit+VU5c1ex2R4yJ3fj8dmz2/0rFqlFwXxBRccwSxaxdpgBmv7fgBHA0mXs2vbpGTJoZ+GrJEMdZJTa4qIqhXjZjyv+k1RIXnISpvjwCcrRp89aExAP35T8+0H9hx0HDq7qqin3EWX8+u2OkJIsUKH/DTG/D7+FwY9Ik9x9LqTAlwsIgYPcRBDTdJWBinAD9XNPXBQ7/A8iLCTU1OIr8YW84P3WEnB+/hcwGFUFFAWIFckhpKj1pFEVyxVZzinttQ2l0CngD1e5Yqpgtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kbz8oOQqJ3HcPR/X8sWDKxZTHbcLP8EUzlqaKaCEkw=;
 b=yxyglnRUcRsye5185OYL4vCoAs+q3kIFM0Lu5gy4T7L2CoRG8DyCnYp/eRDdww35iFwUyXaSHGrjVGY1tbTGw9Rd5aRAHRzH/JHl2DDlJgBwxA1rZtFXt4wNZC2BQyWgz3Lyf+x5HVzZpHe97BCf0QoeQ+dZhvjon3WwUIc4jPeGZ+PUMSkn2150nyx7VnZp7cUrwy6hjgpltmc+W+Mq+MPF1kic9wXdY41lDiDh5rGmnTlNVEhgw9e5IYwsBD4pB4SKkwEf4vIVZb65tIi8YiD35n051qaM8B+DxqvxBeleynQ3u6uFV/KSBAg/g0gQ6F/a1O5YL1/ODbyEFU8pDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kbz8oOQqJ3HcPR/X8sWDKxZTHbcLP8EUzlqaKaCEkw=;
 b=aQ6V/bu2c7sCdTFpdYAURFuE5XZd3k1L4iqxTjZ1dDz9/Ijt9a+ltBkMxgLZZdiNi9ES9fvpHh1W7234ZYm60WS6TU7B1bGJtZHar3sGVW3GCA2iPTvyk5aQrxZVTN5ly0h+FFllgsDbB1SU8qn2iUJtKJwc8davsJONb3RhrGg=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CH8PR04MB636038.namprd04.prod.outlook.com (2603:10b6:610:70a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 02:19:20 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 02:19:20 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: fix hideleg write masks [GL4814]
Thread-Topic: [PATCH v2] target/riscv: fix hideleg write masks [GL4814]
Thread-Index: AQHdebXEYZKiKZpoSEWomw70FmDtKLc67quA
Date: Mon, 23 Nov 2026 02:19:20 +0000
Message-ID: <91b24095d1b5b9cdd182cb8ec73443d03a7f4eee.camel@wdc.com>
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
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CH8PR04MB636038:EE_
x-ms-office365-filtering-correlation-id: cd2b5788-9137-4451-8a2b-08df49082ed1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|19092799006|10070799003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|261021121427099003|261021123027099003|261026140227099003|261102123227099003|261022105027099003|261028144727099003|56012099006|10067099003|38070700021|11063799006;
x-microsoft-antispam-message-info: xBx8lvvJmng47EPnPVGmLTQc622X7L/qj85q+KDE63hi3dueowTraFt/kfHeuNbhtgH7hIsVMa1RVUr1aAFVvRWVEypoZBA4++zJJRCnTPv0LTit5RucnH/cLGNAa5gsrT4CoRbUMEYZdRo54bXprsH/iHGgSr35SQSD5Z5/Fz9821mVIJ7/hfxjjTVSnzHciKRkkkZ5ee79Cmuc9PtUgP9ZnXTQpCUtpUlR1hSf3KDJe5/lYpTQp25stQGtYzFq3tnhxwcpySKD2p3B5zmWraHHW7s1XIEMrKJKg6vSl8rGYyCfg3hBTbZdBNubinvOm1RalHEzny6OH6YNwVBXvEVEfU9aeDe3+gMSFImUu6qytls/waTMn1CODhQuin67J5XgZnugIwm3ucYVXab4qJIUd8rqYeAfCl28KCvasT/7j5E7LLv9qk0qtNfv5IoIP2GbcQUf06gBlNdjtnDcq82tiHJ9ypoyRv49SHIeOUkkA53tFVREGR5W3qrtNVMWU352j5ZwWOeO+fJSjTDZ49SvW7CA2/2EEJLHoiX7ad/gmsA7p4OjtyItuSPAaXDbCbfAYifxZ9oD+2FB+1ZxHilA1O1DAeSdceVecSOAy/Q2RIx6suUHBOKZo4834vfVjg4YyDboqqvataYU/GGSKnMSWlDuElf+KDtZ5fTZVuY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(10070799003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cThtU3FjcWV1TnNIWUtjbjdTc21FTW9SdmNJRlRvVXA2dksvNkx3Q2JNRVdk?=
 =?utf-8?B?STA0QkJaaXJ2N0xZVm5SaGtyODV0dGZpWGpEVktXLzBOUklDcGFhSlIyeDFv?=
 =?utf-8?B?V3N4SlNCTkJ3bU1WYVRwYldJUnpzQ3hVOGJyVzlCTmx4U20zNEVUaUlId29S?=
 =?utf-8?B?ZmFPRGxicFMwNjdWNDFDUDBQMlhxVWt6RWplZllYZStNSFRnSDhHdXRlaUZl?=
 =?utf-8?B?QnBOMUNtTzJHNnp5YU41emFaY3FIdVJkTG5NNWxmWTVSQ1ZOMzFMRUZTSmFw?=
 =?utf-8?B?cWNtL2h1QWVQM3ljN3VST0NRYWdZZVNnY3BXVzhOb3BZZjJaSFJhVDdWSGZY?=
 =?utf-8?B?Q3lqYld6VVl6TlB4Q0ZVeW9ZMmZaVk5pT1Z2VmJiekpGci9RQitCQlc4VWJY?=
 =?utf-8?B?Y3gwNVNBaGNzOTEra0FkSEplMExnYVYyUVdCK1p3cU9vNUxVa1dFRlYwOUVB?=
 =?utf-8?B?WG5pV3MwdVJ5b1d2NiszU0ZFcTlIREF5QXdnTEJHWkNLTjFGNzhzSkhkZzdp?=
 =?utf-8?B?TG8rWnkvSkhXZVh5QWdNY0NiZGNvOW8wYnRBZmNHbFFOamhsbGhZNTQvVjFQ?=
 =?utf-8?B?cWQ0aEhZTTN3bTVTTHh5SkRObGd3MlU4UE9uOUxWQ0dKODUxQklrRS8zZTZ6?=
 =?utf-8?B?WEVUcjRqazNrazNMcHhzK3N4Z0tOaDNSZ2h0aUVSLzhBVlAyT08vRWVyUkZB?=
 =?utf-8?B?SjdKTHVQdUpudGJhSnI2LzczRE9vbE16Nk1OSDVBYzZMSS9sMzF4YmNjM2pX?=
 =?utf-8?B?VTlCcDZlQllsQkhQdnc3WUhkeEpxWVpjMXc5MTZTdVFJR29IbHdKVVpGUjc2?=
 =?utf-8?B?Z3VEK0wxU3hkV2JtcjEybHlsbE44cFh3Uzc1UEgvSjhXeWdFeXFMcXRTSEVE?=
 =?utf-8?B?Nlcxd3dEK1pBeUVoQVRlYXBQenBLMHFKMTRzVTNLamo3enJGQ1BKdjlBK1NR?=
 =?utf-8?B?UnlPQmtrSGJhV1BuN1ExYU5IVWk2L2Rkb0tpalVpb1Q1SysySmY2Rk8zWHZY?=
 =?utf-8?B?TVpKWG1jajk0aytSNzRxUnljM1VQWFZnMWJNZDFlWEl6ZUx6cm55aUtsSmo1?=
 =?utf-8?B?eHo5WVVUcDlEL1Y0Wk1xZ1o5eXBza1R2YWpQMUsvRCtTaHNkYmpQYmdFa0Jv?=
 =?utf-8?B?czExQmwwZ0pZL3JXUWxwcHNHUEhiU2JyYTRDZEhWT0JjTGhGZ0Z2VkRscWhZ?=
 =?utf-8?B?UjJwejhhaFNpd2NkNlVNUm5xdGxGRTZQZUZKc3J4RHhwTitCQ0QzcURxejdO?=
 =?utf-8?B?aVJEMDVUSXBYVzJ3bGFpK1dCbjZWaDBKMUNPQnVPTjBhbmhKODlvWTQ3ZGs3?=
 =?utf-8?B?UVMyZEpmcC9Odmp5ZnBvYlUvSzFrd0RPSnBsNlEzdmtGYWNta0grQklHRUZZ?=
 =?utf-8?B?R1VlN2JGS2M0ajQvcmtRamtlTkJ2Nm4wYXVUekVVUUt1V2JEczRkUW96UzN2?=
 =?utf-8?B?MHJ2NUxnMmdrUTV3VDQwUGpESmNOYmczS21MMUxMeXlDNTdNMUx4WXQybGk2?=
 =?utf-8?B?U1laRnlQcGxtaHV1QjNxTGY1cE9GRllhRzRkcHRBMW5lbkgreWROOWZEWFdV?=
 =?utf-8?B?b0JZQllsVkkreHJsWlBsL2Jmci9FZXgzSUFadHR4QkFxb0h2a1N0MUtMRk1p?=
 =?utf-8?B?dVFFQ0xQenc0d05FWmdUSEU2VDJvTDIwNktIMkhNZnpjblJpQk1wbGx3T1JH?=
 =?utf-8?B?NGs3dDI2L2cxMzBpRW91WFlNODdRaHd2QVhyTGh4SmZkbjRlc25aUmowY25y?=
 =?utf-8?B?VUNTV3lBdFBZdU1PRU14TzNkYzBPd2dFZTFRMnhXQy9ub09sVkc1QzlBQUJr?=
 =?utf-8?B?dnRrMC94STl0a291WXJXWnhVV0sxV0FNMmhVcnMyTnM0M0RMYTV0Vnk1cWRK?=
 =?utf-8?B?bDJ1dTNQazNKQTVKU0NoeXZ5Tm9GdWl3blVUdytNV29GcWxJL0hEeFhnaHFX?=
 =?utf-8?B?a3NuenpCWDFHbVFwclNaVVY4NXVxbUM1TjB2UnFVc1pySjhlTnZzSlR1TVd5?=
 =?utf-8?B?WTFjM254ZDFQbTJmbmRoSmVFZ0hBYzN0U243NW1WNEtJbnpjbVpuRWZYdnpn?=
 =?utf-8?B?cGU4STlTRGx6QzJSTjdqNjU2OXF5Ujh1dEErNGhGQ1FxMkxtUVBTS20vdy9m?=
 =?utf-8?B?OWlad3BKZ0l5UHpIb1MxZkFLRW52bms2QjBXa1h0cmdIRkZYUEpZd05hL3l1?=
 =?utf-8?B?SHU2NnF1MWhOQlgwNjBmVmJGR2w0WHdkeGVwYkFtN3R4bFJibUZmTVlaMEl3?=
 =?utf-8?B?cXhURjFaOUx4SWh3ZDJDa2xCdHdycUtFME5nZ25nNmR2VGp5TVZmRmhvaDhN?=
 =?utf-8?B?VksxQ1B6MUpCWW5IUlNkNHJpUUxjS1NmSGdxTFZGQ2pDc2QvK3ZzMXBzMHdF?=
 =?utf-8?Q?mtOaBqSEHcQajLgbCiwduvp6xbpAsnSToWxdkXIsRi2Ic?=
x-ms-exchange-antispam-messagedata-1: hKMt8VY2VfMyyk3NmszCTvREFY7q8rKE4RY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4EF74C49083D9428D8B06108A6DF88F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Zky2D/0b3XLRVLsRW20RRKxSp63FvskIoiz5s9ibYEuZNiMrreCONKghQO1dTEtV3SsbC29FsQ+RdI01xn8xQLG2z+/3vqGIG9REWs7ZmgFRuiXCohitms9zrXuz6V6340Prx+6nWKoFALFCvgkiL1CFso1yRPdXPwncW+LL87F9TBhn4w2eWD+Cj+FtFD9E+/cK/kxGkq6bKAoGM7wpVPbWhE2v0dU9GN/BlFODxUJPP924Oh/tytlu6f3nVp1VEkJ43gl1gGeoNHf7vnyteZFk1Jnhj5pPoq1ufjKibXp5v/Mqx2t3MuuKdipf+VTDajTxe5XEUy38OlrEt9ujuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KgCaCP32sB7+D0X3oPr0hYzVMmf8I/jeYuwVNqdXesVzve97/5P3P1X5+QvjRN3NDuByYA/IM/iXSJB3PBSz8aZ5Mr7uxNyqajfZjD2rH1+Y1a/+V4QPCnJoH+tGwZzxpTJIV7RS0Tw9v9eyp+2QkDmyuYV4aWgUSXnNnPHbjObOmoSBrsSyRRXhoTY+eJ06kEgUhZaO2o5xfdJFJdVltcf0qTAwYgaL0JtQl93sI7Mxvuk5XXKiEd4KgQyRFAAor4ZnC9k27C+xuHr0PIFXahg9PPJ7gaMJZDLqUVS/BE2ricOgLL7hoKSOG3lkyb1HbvuVNAQfQPEe62v4hCvJhCKXXhHH00fEGcMNW7hIagl8FAiBQeKrYvcd40JyxYJAds0tcFxzyWnvcx6rsG92vivxJINyaqs9JcMcaccwyO9BOVkn19k2Yxeb4w39l7jftoqOwyVffuIXJXdq2MUNpunangKLDiOmCaLRKD8yPLeEVYd30QENC17YAWwDct/7A/HhMKN9hxjeUDa/Mvw67IA2B4ZlRVxXrAVXzUyDm/cNArQNXV1vYYgep2w6oFDBDQ+ZnW6gEr2fh/vNzF82SgBj6RbbFeeGUAADqseA8vJXI+hdwhlKeZUkPROsUlR2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b5788-9137-4451-8a2b-08df49082ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 02:19:20.3691 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3U8a02Oa+PWr/J5pG/vlIUYqb80+uTafeD1x18kQBPr2Cb5MTZFgXuIMxqGBDE354HHh72KAupusEGIShSQloOCc0DoRafsTNKJmR8W2IGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR04MB636038
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
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
LmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsaXN0YWlyIEZyYW5j
aXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxpc3RhaXINCg0KPiAtLS0NCj4gDQo+
IENoYW5nZXMgaW4gdjI6DQo+IC0gYWRkIGEgY29tbWVudCBleHBsYWluaW5nIHdoeSB3ZSdyZSBj
aGVja2luZyBleHRfc21haWEgY2hlY2sgYWxvbmcNCj4gd2l0aA0KPiDCoCBSVkggKFNhc2hpa28p
Lg0KPiAtIHYxIGxpbms6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAy
NjExMTYyMDUxMzQuODQ2ODc2LTEtZGFuaWVsLmJhcmJvemFAb3NzLnF1YWxjb21tLmNvbS8NCj4g
DQo+IA0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMjcgKysrKysrKysrKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29u
LmJ1aWxkIHzCoCA4ICsrKysNCj4gwqB0ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LWhpZGVsZWcuU8Kg
wqDCoMKgIHwgNjQNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMg
Y2hhbmdlZCwgOTkgaW5zZXJ0aW9ucygrKQ0KPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90
Y2cvcmlzY3Y2NC90ZXN0LWhpZGVsZWcuUw0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNj
di90Y2cvY3NyLmMgYi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+IGluZGV4IGFmNDQ0ZTNlNmYu
LjVkMzM2M2NmNGEgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gKysr
IGIvdGFyZ2V0L3Jpc2N2L3RjZy9jc3IuYw0KPiBAQCAtNDk5Nyw2ICs0OTk3LDMzIEBAIHN0YXRp
YyBSSVNDVkV4Y2VwdGlvbg0KPiBybXdfaGlkZWxlZzY0KENQVVJJU0NWU3RhdGUgKmVudiwgaW50
IGNzcm5vLA0KPiDCoHsNCj4gwqDCoMKgwqAgdWludDY0X3QgbWFzayA9IHdyX21hc2sgJiB2c19k
ZWxlZ2FibGVfaW50czsNCj4gwqANCj4gK8KgwqDCoCAvKg0KPiArwqDCoMKgwqAgKiBUaGUgc3Bl
YyBtZW50aW9ucyBvbmx5ICJ3aGVuIEggaXMgaW1wbGVtZW50ZWQiLCBidXQgc2luY2UNCj4gd2Un
cmUNCj4gK8KgwqDCoMKgICogcmVhZGluZyBhIENTUiB0aGF0IGV4aXN0cyBvbmx5IHdpdGggZXh0
X3NtYWlhIGlzIGVuYWJsZWQNCj4gKG12aWVuKSwNCj4gK8KgwqDCoMKgICogd2UncmUgYWxzbyBj
aGVja2luZyBmb3Igc21haWEuDQo+ICvCoMKgwqDCoCAqLw0KPiArwqDCoMKgIGlmIChyaXNjdl9o
YXNfZXh0KGVudiwgUlZIKQ0KPiArwqDCoMKgwqDCoMKgwqAgJiYgcmlzY3ZfY3B1X2NmZyhlbnYp
LT5leHRfc21haWEpIHsNCj4gK8KgwqDCoMKgwqDCoMKgIC8qDQo+ICvCoMKgwqDCoMKgwqDCoMKg
ICogVGhlIEFJQSBzcGVjIHN0YXRlcyBpbiBzZWN0aW9uICJJbnRlcnJ1cHQgZmlsdGVyaW5nIGFu
ZA0KPiB2aXJ0dWFsDQo+ICvCoMKgwqDCoMKgwqDCoMKgICogaW50ZXJydXB0cyBmb3Igc3VwZXJ2
aXNvciBsZXZlbCI6DQo+ICvCoMKgwqDCoMKgwqDCoMKgICoNCj4gK8KgwqDCoMKgwqDCoMKgwqAg
KiAiV2hlbiB0aGUgSCBleHRlbnNpb24gaXMgaW1wbGVtZW50ZWQsIGlmIGEgYml0IGlzIHplcm8g
aW4NCj4gdGhlDQo+ICvCoMKgwqDCoMKgwqDCoMKgICogc2FtZSBwb3NpdGlvbiBpbiBib3RoIG1p
ZGVsZWcgYW5kIG12aWVuLCB0aGVuIHRoYXQgYml0IGlzDQo+ICvCoMKgwqDCoMKgwqDCoMKgICog
cmVhZC1vbmx5IHplcm8gaW4gaGlkZWxlZyAoLi4uKS4gQnV0IGlmIGEgYml0IGZvciBvbmUgb2YN
Cj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBpbnRlcnJ1cHRzIDEzLTYzIGlzIGEgb25lIGluIGVpdGhl
ciBtaWRlbGVnIG9yIG12aWVuLA0KPiB0aGVuIHRoZQ0KPiArwqDCoMKgwqDCoMKgwqDCoCAqIHNh
bWUgYml0IGluIGhpZGVsZWcgbWF5IGJlIHdyaXRhYmxlIG9yIG1heSBiZSByZWFkLW9ubHkNCj4g
emVybywNCj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBkZXBlbmRpbmcgb24gdGhlIGltcGxlbWVudGF0
aW9uLiINCj4gK8KgwqDCoMKgwqDCoMKgwqAgKg0KPiArwqDCoMKgwqDCoMKgwqDCoCAqIFdlJ3Jl
IG1ha2luZyB0aGUgc2ltcGxlciBjaG9pY2Ugb2YgbWFraW5nIGFsbCBiaXRzIHJlYWQtDQo+IG9u
bHkNCj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB6ZXJvIGlmIHRoZSBiaXQgaXMgemVybyBvbiBib3Ro
IG1pZGVsZWcgYW5kIG12aWVuLCBhbmQNCj4gd3JpdGFibGUNCj4gK8KgwqDCoMKgwqDCoMKgwqAg
KiBvdGhlcndpc2UuwqAgV2UncmUgbm90IGdvaW5nIHRvIHNwZWNpYWwgY2FzZSBiaXRzIDYzOjEz
Lg0KPiArwqDCoMKgwqDCoMKgwqDCoCAqLw0KPiArwqDCoMKgwqDCoMKgwqAgbWFzayAmPSAoZW52
LT5taWRlbGVnIHwgZW52LT5tdmllbik7DQo+ICvCoMKgwqAgfSBlbHNlIHsNCj4gK8KgwqDCoMKg
wqDCoMKgIG1hc2sgJj0gZW52LT5taWRlbGVnOw0KPiArwqDCoMKgIH0NCj4gKw0KPiDCoMKgwqDC
oCBpZiAocmV0X3ZhbCkgew0KPiDCoMKgwqDCoMKgwqDCoMKgICpyZXRfdmFsID0gZW52LT5oaWRl
bGVnICYgdnNfZGVsZWdhYmxlX2ludHM7DQo+IMKgwqDCoMKgIH0NCj4gZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBiL3Rlc3RzL3RjZy9yaXNjdjY0
L3N5c3RlbS9tZXNvbi5idWlsZA0KPiBpbmRleCAzYzhiMDE4ZDllLi42YzA4ODA2Y2M5IDEwMDY0
NA0KPiAtLS0gYS90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gKysrIGIv
dGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IEBAIC04OSw2ICs4OSwxNCBA
QCB0ZXN0cyArPSB7DQo+IMKgwqAgfQ0KPiDCoH0NCj4gwqANCj4gK3Rlc3RzICs9IHsNCj4gK8Kg
ICd0ZXN0LWhpZGVsZWcuUyc6IHsNCj4gK8KgwqDCoCAnY2ZsYWdzJzogY2ZsYWdzLA0KPiArwqDC
oMKgICdxZW11X2FyZ3MnOiBbJy1tYWNoaW5lJywgJ3ZpcnQsYWlhPWFwbGljLWltc2ljLGFpYS1n
dWVzdHM9NycsDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICctY3B1Jywg
J21heCcsIHFlbXVfYXJnc10sDQo+ICvCoCB9DQo+ICt9DQo+ICsNCj4gwqBpZiAncWVtdS1zeXN0
ZW0tcmlzY3Y2NCcgaW4gZW11bGF0b3JzDQo+IMKgwqAgdGNnX3Rlc3RzICs9IHsNCj4gwqDCoMKg
wqAgJ3Jpc2N2NjQtc29mdG1tdSc6IHsNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0
L3Rlc3QtaGlkZWxlZy5TDQo+IGIvdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1oaWRlbGVnLlMNCj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMC4uYTA3ZDQ4NDMwZg0KPiAt
LS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtaGlkZWxlZy5TDQo+
IEBAIC0wLDAgKzEsNjQgQEANCj4gKy8qDQo+ICsgKiBUZXN0IGlmIGJpdHMgNjM6MTYgZnJvbSBo
aWRlbGVnIGJlY29tZXMgd3JpdGFibGUgd2hlbg0KPiArICogdGhleSBzaG91bGRuJ3QuwqAgRGVy
aXZlZCBmcm9tIEdpdGxhYiA0ODE0Lg0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoYykgUXVhbGNv
bW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMNCj4gc3Vic2lkaWFyaWVzLg0KPiArICog
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+
ICsjZGVmaW5lIENTUl9NVklFTiAweDMwOA0KPiArI2RlZmluZSBDU1JfSElERUxFRyAweDYwMw0K
PiArDQo+ICsub3B0aW9uIG5vcnZjDQo+ICsJLnRleHQNCj4gKwkuZ2xvYmFsIF9zdGFydA0KPiAr
DQo+ICtfc3RhcnQ6DQo+ICsJbGxhCXQwLCB0cmFwDQo+ICsJY3NydwltdHZlYywgdDANCj4gKw0K
PiArCS8qIE1hc2sgZm9yIDYzOjE2LsKgICovDQo+ICsJbGkJdDAsIC0xDQo+ICsJc2xsaQlzMCwg
dDAsIDE2DQo+ICsNCj4gKwkvKiBtaWRlbGVnID0gMCwgbXZpZW4gPSAwOiBoaWRlbGVnIGJpdHMg
NjM6MTYgc2hvdWxkIGJlDQo+IHplcm8uwqAgKi8NCj4gKwlsaQl0MCwgMA0KPiArCWNzcncJbWlk
ZWxlZywgdDANCj4gKwljc3J3CUNTUl9NVklFTiwgdDANCj4gKwlsaQl0MSwgLTENCj4gKwljc3J3
CUNTUl9ISURFTEVHLCB0MQ0KPiArDQo+ICsJY3Nycgl0MSwgQ1NSX0hJREVMRUcNCj4gKwlhbmQJ
dDEsIHQxLCBzMA0KPiArCWJuZXoJdDEsIF9mYWlsDQo+ICsNCj4gKwlsaQlhMCwgMA0KPiArCWoJ
X2V4aXQNCj4gKw0KPiArX2ZhaWw6DQo+ICsJbGkJYTAsIDENCj4gKwlqCV9leGl0DQo+ICsNCj4g
K3RyYXA6DQo+ICsJIyBBbnkgdHJhcCBpcyBhIGZhaWwgY29kZSAxDQo+ICsJbGkJYTAsIDENCj4g
Kw0KPiArIyBFeGl0IGNvZGUgaW4gYTANCj4gK19leGl0Og0KPiArCWxsYQlhMSwgc2VtaWFyZ3MN
Cj4gKwlsaQl0MCwgMHgyMDAyNgkjIEFEUF9TdG9wcGVkX0FwcGxpY2F0aW9uRXhpdA0KPiArCXNk
CXQwLCAwKGExKQ0KPiArCXNkCWEwLCA4KGExKQ0KPiArCWxpCWEwLCAweDIwCSMgVEFSR0VUX1NZ
U19FWElUX0VYVEVOREVEDQo+ICsNCj4gKwkjIFNlbWlob3N0aW5nIGNhbGwgc2VxdWVuY2UNCj4g
Ky5iYWxpZ24JMTYNCj4gKwlzbGxpCXplcm8sIHplcm8sIDB4MWYNCj4gKwllYnJlYWsNCj4gKwlz
cmFpCXplcm8sIHplcm8sIDB4Nw0KPiArCWoJLg0KPiArDQo+ICsJLmRhdGENCj4gKwkuYmFsaWdu
CTE2DQo+ICtzZW1pYXJnczoNCj4gKwkuc3BhY2UJMTYNCg==

