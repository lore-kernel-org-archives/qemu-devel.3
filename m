Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC9606A329
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=proofpoint20171006 header.b=MLUwFL1E;
	dkim=pass (2048-bit key, unprotected) header.d=nutanix.com header.i=@nutanix.com header.a=rsa-sha256 header.s=selector1 header.b=WY+d/9q1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOXWE-0004n2-O5; Wed, 04 Nov 2026 04:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xOXWB-0004mk-0L
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:42:55 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thanos.makatos@nutanix.com>)
 id 1xOXW9-000215-1H
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:42:54 -0500
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A48K5X42312601; Wed, 4 Nov 2026 01:42:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=Y6iH9KP2SqdL2rtmkpqs35IC13gFdEH7HsRLsrPFo
 xY=; b=MLUwFL1EUrkom/IXqdfoUJnYM10vivNFKjlPlE9tHceiCTgYbPt4Ptr7Y
 fOEzSo7aaQD2OvR3nDVOrdbW9vr+pZXyOJHKCD09p5RtwS1yH0fmg4KkmGeFkpVZ
 o5fIB4nRC4K4BVU9oRAs2zMRoj87ukn4WFKFXFPyHJlBtMCBf4n/4j0sFAZBsTDR
 1PdphBh0E4UB9Y+o18Rz637eFykyXJz3yerTCFx3hmMQE8xcxkdRd0KPJtW3SM74
 V/kko454P2FX9xmWZODX6opIB6hH8DQUxgbeswcNaZrmvg0oJyqYR6OXH9RnXh3X
 wvZ3SplUCHuOjelHwnRx9kYzOHWKw==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11020125.outbound.protection.outlook.com [52.101.85.125])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4hpthc5psv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 01:42:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GU1jVnVoLYciiqxZ6jISBiEwX0emzNO4oOraejdsZeUdQBdhGn9OEc+gFXzMWbWJc1JcwEu+tzyZiX+LUP3ZRWadevKf52WDirTRbm27s4/eUSWqIJ2Zjwkzpq9cfqyRAdZAXwW9U2uxC05eSmfjaXV5riNCTroSBPU7ctTIpvxEjYljkt9KsYBXo7gyNaD9y0UZSIu+b4ka1XJZhHfeWUq6UnaiF6lKxi04tUw1sm3bWEOhUTqi1zvrl6sHWe7pGoPe9eLlLLoi17RvW70NwZvPnyw0aUpuuOPLc2VHWUUAFumi4CjnJtCqhpqjkjbhNPDfWq2SSfhQ00CGJT+EDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6iH9KP2SqdL2rtmkpqs35IC13gFdEH7HsRLsrPFoxY=;
 b=d0qx936BcnqfGjh4DVI7EA/ITweNR5MfmMCoR04x38LEMsyjz5Twn7EiF6+o8lwb8/RoQqWVJif5f3BA6HpAcdEnBE0nb+YbidYOkqGm9yZI2vuvv50wjrDyUeu5YAlZAOUdsYMbr0SbR9DitUYaCpzoK8TnNYukuzXxdUTMTbObsj/AbAnOCe55Hrspm14rfFILwP62FIXD275N4Pjde/RkIlqwo91lqXdI074otQ1IkplZ2jAh8uUCRx6f4Es33E2eFmDweB34y6T+3pQUC1roRG8Onoiq6TlGsxumBFIDq6PJCMSNegcSta0hcw7T3MdRya2DfpUClTDbrBmj4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6iH9KP2SqdL2rtmkpqs35IC13gFdEH7HsRLsrPFoxY=;
 b=WY+d/9q1fqUPvcsPeDpN1+o4ZsMI1AdQkQibvgBn9I5UkQ/PxDH2zI5aqUcwtdvT9tTx+IrMGqScbWqvbWLD7oouhuBUTCnMjozdNNsskICJjTA/b3aZzsIuiYPmCObsfYzvSG7P/kJAzs7b9KNbb96Gz/ZC2UPUZzbCx4XH2Dzhxg4nEi4nXXSn9MkMdH5I8rwZHFhMWyrafZm7x9JBLFfvoDpBfBX6VrAFU8H0REIiXoOaceuCe+a5Q0uYW/QvWYTqGdmvfG3GXyqDUJXaYmesBN415r0utDCeyJ6KCmvS22n6xGu/+kJb9esGm8NVSPkaRnY8DRuySxBS8IOu3Q==
Received: from IA0PR02MB9462.namprd02.prod.outlook.com (2603:10b6:208:406::6)
 by PH0PR02MB7304.namprd02.prod.outlook.com (2603:10b6:510:b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 09:42:39 +0000
Received: from IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d]) by IA0PR02MB9462.namprd02.prod.outlook.com
 ([fe80::c493:aabb:b834:f53d%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 09:42:38 +0000
From: Thanos Makatos <thanos.makatos@nutanix.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Weqaar Janjua
 <weqaar.janjua@packetfive.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "kraxel@redhat.com"
 <kraxel@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, John Levon
 <john.levon@nutanix.com>
Subject: RE: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Thread-Topic: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Thread-Index: AQHdUFDXMB8TRwEHfkqkhaZP9v8zO7cAZo+AgBDNTACAACxzgIADOEwAgABip4CAAB9aAIABzuCAgADWDwCAAGF7AIAAEd0AgAWmKwCAAAe/8A==
Date: Wed, 4 Nov 2026 09:42:38 +0000
Message-ID: <IA0PR02MB9462D1A915186AAF67B906668B682@IA0PR02MB9462.namprd02.prod.outlook.com>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
 <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
 <20261030191556-mutt-send-email-mst@kernel.org>
 <20261031120516.2846639-1-weqaar.janjua@packetfive.com>
 <20261031135234-mutt-send-email-mst@kernel.org>
 <20261031185807.2866788-1-weqaar.janjua@packetfive.com>
 <10c48a35-82c7-439c-be8f-15b9dd89501b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <10c48a35-82c7-439c-be8f-15b9dd89501b@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9462:EE_|PH0PR02MB7304:EE_
x-ms-office365-filtering-correlation-id: 55a1d620-a853-4a4c-ab01-08df3a57f6e4
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|1800799024|366016|261009223027099003|38070700021|261021123027099003|4143699003|56012099006|261028144727099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: +X9W8cGJiFau266A7qva2Wtp4ga4PNP4PwkwCwawN74fchSTwigRPevijpowogzcdxyDk2DJhB35BhJSWV3EjUfceil6lb5sjXQ4kQTrqhs0l7K6v1b3Jw2pRWjYJfA5cvy5fOT1Vo7u6/XyOlxIcZQa+sxkz0qh6jYmhauwevu5w6wCABKJ/urqC49qrGsVVXxeu4r1sy7ZE8UvFdZX0k5crHLO8IySnfDFK1rIs8gT1eAt+GQyzQsmM4Jx0xrfeOqklKEAWLlNq4500Lxitlcnj12PCgV1YKaNiXXIIRthmPyd3zT/vyFPBS+iueODbtpMVyzmkZeOpX05s1ZXArsjCsvgNcrIiH9h6qzOAh5gSHAKGmjV5kaLT4WCdWxtoyA6aWYRggVNnIcUqFAMt2d5BzxnAPx+gs1L1VpNVBBlDvKAf+ZJb/3KyH5j5Y2LMScUNlBu46+tYGqLUq04TS72WOZDFCowhnqxaf1pL7R3Nr/TXPpJVMLD8PqgLKdnpS/PXIdHKsy398rXJUaHydIjHf/0mIwa+3V9rrcbTLHcHI+wDaqfK+rd1SvVZIxeKuqACzSU9q/7XM14kCJECW1J8UU/1yDfQI1cmR3s6M5408QlViq2BGabRbpoegEfRx/q4vMXaX29TVPdkqB67Due1FIt4zwFuPx92D9fTzEbBM7K9P4OO2bthfQucWZ509Jrypjh1oQmXGuCHZN8HUIugpEET2ucUr32kzlqsaE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9462.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(261009223027099003)(38070700021)(261021123027099003)(4143699003)(56012099006)(261028144727099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkNkbXA4ZFJRYzhlVi9ZbWQwSkZjRGFtTjNsTkdzcC8xSFdsOXRwekFPUnE1?=
 =?utf-8?B?VTZQdkJpNkNlMXBWVlpJa2dXc2lLT0RuY0tvSEt0dzdqc1pRMzd4b01PV2R1?=
 =?utf-8?B?UzFvS2NOaTNqMk1GbUIrYUFvN0ZRLzE2c3hyb05SQVZybWhSalZKbVBvem5R?=
 =?utf-8?B?dXZmSGtHVkoxT2pWdEJWSDgxSlNKTDJuS3cvU01OSmhnaU1GMVZVSEt3cjdi?=
 =?utf-8?B?ZDZTTE5ieWZlMG51bkZseTBYeFlucnlRdlo3Q0JCRkJXRGZiR3BHTzhhQ3dO?=
 =?utf-8?B?dEs3djFyWHNHclU3bjVQb2xkZ3plQnBsZDQ1RERYbmQ3WEJoTUtVem1ZT2Ry?=
 =?utf-8?B?dXoxRzZoaEw0QTg0TUZuNEMxb3pybmI2RmlVS21PVFNLWTBYRnNxVkFOOGNs?=
 =?utf-8?B?dGNDeTdMcHZMREgxbjdyMEJHVXZRTy9iTXEwMGVIRzlkajl1bFlqVVUyOXlQ?=
 =?utf-8?B?MjFRZ0N3U3MzVDBEZytpeXF4RW1XM2FaWGxUck5nQktSSTB3ZElGRDIxcklC?=
 =?utf-8?B?RSszMTVMMldmRzdxK29NYUlvRm1qcVYyZy9oSnZiSWhORXAraW50OUJPTHJi?=
 =?utf-8?B?VXV1WWttUzlNdXBSaU1tWE5Gc1UwV1BrenZ3dDBROTlHVXRPMEt1SFJ4Q2FN?=
 =?utf-8?B?cldPSUJJY0MvcURCTHRtOEJnbEljSEt4dWw1c1NTb0FTSksvUWxJTm1KT0g0?=
 =?utf-8?B?ZTkyWkwxTExrZWJFb0w1dVJURWhTVEtlK285Sis1bVNER3JCaWIraURCUlVE?=
 =?utf-8?B?aWJNZGhOZXkrdDJpQXhyTG9jLzZzbXVCbkFOMXBLWm9IalhvbmNpcE50a3c1?=
 =?utf-8?B?UldrbVUvV2lvcm9BVVJsSXU0YXFOeU10U2h6QUF4eCtZMC82Q0FCYlcyVVhm?=
 =?utf-8?B?bmZHY3R1V2hwMGtpQ0hrSU5ZZDFVbG4vMkxSWm5yOUUvZ3FibHdzSVBMK2pT?=
 =?utf-8?B?N3pZWEhOY3ZhSU9OY0w3Uk5DSXNndmR1VFd5eHZtcnl2b1VEaVFrdmllc2V3?=
 =?utf-8?B?M3cxNVBBa2hkZTl6VDFmWGJ4VjU5YXdvd1pwdHlDcW50YS9mckFxeXJGNkVL?=
 =?utf-8?B?b1V1MHBiWWgwNlJ6ZmdYS0szdklMKzliak1rR0xrT0dhdTlETGRoRkpudXlC?=
 =?utf-8?B?eW9LdTZmTHU0N0o1ZWRoaXU4eldrY29WS3Vxb05xL05JdHV6dUNpV2sxN1Qw?=
 =?utf-8?B?UEhGeXMzZHV2ZlgvSDRQWjVhOFMraWtHd0JjcXZOQmhZT2xyMnlFeUR0SEtV?=
 =?utf-8?B?emhzcklrMDhVYkxoUGZhdGlQWDZ3c0ZGV2RYenBlRCsxUTFpS2lseVZrVE9D?=
 =?utf-8?B?TWFqV2ZMZi9CS0Y2RnRVU2dpak5BZUN2eVpXcTZvcVJleTV2NnRVUGQyUXlW?=
 =?utf-8?B?MmpZbTRjMjFERmRIM0Z5bEhYeW1OV2JGaU1DQVMycHdSVUFXUWVMWFFDakll?=
 =?utf-8?B?WWtaQ0ppYTNtai83S1l4RThUWFdEbFdPQjBCeHRFSHNabFo3WFJ6NjNTd29k?=
 =?utf-8?B?c0JKTVpuOFF5Wi9ld1c4OUE0QzZpYXJ2Tk9HaEIvclEwYm9heDYvcVlaMU9q?=
 =?utf-8?B?OCtocHVTb2ltUitSK1c2RVdJbmIyUE8xbWM4NXRDUHFodFMyYkxSeWI0REky?=
 =?utf-8?B?S2JDTUJtTnJxVlp2YlZmTHBQOGh2eG5kU1JEZUl4K0krd0RhZnIyMHR1Z09Q?=
 =?utf-8?B?SlplSjJjaTdBckdIT25jbjhWcitYSzA5bm1NRmpXWWc3Q25OYWZGbEdmSUo1?=
 =?utf-8?B?RkhaMzkvYkJKT0w0RE5xNWNkVUQxRklqUkhsZTYrWXV4RHlWZ2hJS2svb2lI?=
 =?utf-8?B?c1ZUWGlkMW5BVVdvbWI2ZC8raGFpbU1yemtJKzAzWHpuSXBnejBacDhLTjFp?=
 =?utf-8?B?SWdRK3QyYzZYNjRqUmRXRFFCY1B2SkNENmgrMjg0S3RLSjJJNVpCM2pyeDIy?=
 =?utf-8?B?aEQwTm9OV2QzNk5wWVRUZFpQaTlBREdMRTllc1g0eEpGZ1BzSUZFSmZYdmE3?=
 =?utf-8?B?d3pEandaTWVOTFhFTUVDZ05Sc3g1YVl2alk1SkR3UlNpdDBwNCtOS3MyQTdM?=
 =?utf-8?B?M0pyWFlFbkxrMjB0MG9ERkp0Tkc3bWhBNzQ2SWJ2YUgwT29UMnhxaS80QjAz?=
 =?utf-8?B?dk4rSi9GMEV6M0pzaEU1bHJUblc1eDRJelVqSjk3K1lrZ3N1RkNVb2QxcytV?=
 =?utf-8?B?Wk05YTA2elBqK0pCTlQ3ZGYybE45OGhVN3Y1S3BvcDVMZHVsdDN2VlJPOGVZ?=
 =?utf-8?B?YmVpTXAzTmF5WWYwc0tKY3Z1ajJSMDBINklsaTZISDNVNzZQQ2psaXRJb3N2?=
 =?utf-8?B?UWxNem9yeWRnREJVWXhEblpYWDlUWVF3RTJNRkdHWTNLdkdKN2ZQQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zHwWJIS0mJEwNMLilKGv1X1bejQH+60ExjG3U8NRFTPnUhzLULuQN7Q+Jnd1IC9YYbx0c+qkxRLykS9jELARo6XZZfD7apV4eiG1Wc67yr+TYlX1ERNsdY90brnrSho8WblD9jdakwfSJ2kELceE7HNFimYWV1/TeLBqVc06Lpy2I/8RZk0OSyoc4ktf0OqvPGIfbQGNrG7E5QrkWAgmUhULeaDIzfM2auZBgOSAbKpfdYseyNzCN1gBHqcfERji9VX3G5xpBK+nwbcev8N8GF7HowqfIUL5pve4B7SgyNYPLqR/hnWaUA70EeJHSmYf4Yh+alpRcCfFSzsuaivAQg==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9462.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a1d620-a853-4a4c-ab01-08df3a57f6e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 09:42:38.8061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VCtaEH2pv5Rpzx+SlRMapgfGV2ws5DHKCduk08N5NDh1RDLxrBRjAfKMlbRLgd4PD29fgaw1e74njpTAlHYLkrObpEc6GOW1U6kbNYlxLSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7304
X-Authority-Analysis: v=2.4 cv=PoMG/AM3 c=1 sm=1 tr=0 ts=6aeafe12 cx=c_pps
 a=bA8WxO540RzhAQ9tgvMHlg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VofLwUrZ8Iiv6rRUPXIb:22 a=jxMXjlTPpCISP5mWtjnE:22 a=69wJf7TsAAAA:8
 a=ct_sAU3VAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=omOdbC7AAAAA:8 a=K-d1ZF-32PP0CJY9qNIA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22 a=ICdHMht3yOFE3MFFIwwE:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: XLzQaHM5sGK-IP5YAp5xQ90_dGmePTWf
X-Proofpoint-GUID: XLzQaHM5sGK-IP5YAp5xQ90_dGmePTWf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzOCBTYWx0ZWRfXw649gOCneQPn
 7zLSobJuUWGTEfuC+o1pi8vh3motHkqleIZmIPBNDwpZ319OqR0ljReO1iaQDcevuy7NRzarid9
 osd6sP/3NJfv4FQA0MgOILC9LnMV+uE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzOCBTYWx0ZWRfXyLH3xGckt8Of
 apa8NePGnENroEJO0hteKa/vXl80l8KLRryMEevRVJcGh/ORP4hyVfenq7mPkUT3Kb9XZK3d+I7
 gRt2y/Eqh5BrVPRgxMv3gLpB/ne54mbTZwtwYRTAvRtU1JTZoYJS4naZJMyF+8nXSbdT2tzhxqI
 8JcbyY2QL+qtCb4gR/91kneZpkPLbE4W+UoxXOAVTxq+MU4wqSbdgq1csIwzWyqVoqEgTZ8b7fc
 mthVQHlfTWdDuOw578Yv2Hfy1F/uTjuJhK8E2APtG5x5D13uMlGLk/ACRT2nfzKcBk7RFGTYqup
 ylGeYNAf1Mj+gTn7RgdEZfYHTWYu+E5tR/DMjwnO+gJd8poMcRHe3OQwIj7jJxuf1Lh7J8CDRcm
 eJ2NJbiHMqMO8aZyM/5AiO+MW/0cm4i/kGXttfLZEZ33l+rvaYhd+SecLwyfxIEpgZ5SUZHcC1n
 GdimqP/5243eEfhLDpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_02,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=thanos.makatos@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMr
dGhhbm9zLm1ha2F0b3M9bnV0YW5peC5jb21Abm9uZ251Lm9yZyA8cWVtdS0NCj4gZGV2ZWwtYm91
bmNlcyt0aGFub3MubWFrYXRvcz1udXRhbml4LmNvbUBub25nbnUub3JnPiBPbiBCZWhhbGYgT2YN
Cj4gQWtpaGlrbyBPZGFraQ0KPiBTZW50OiAwNCBOb3ZlbWJlciAyMDI2IDA5OjE0DQo+IFRvOiBX
ZXFhYXIgSmFuanVhIDx3ZXFhYXIuamFuanVhQHBhY2tldGZpdmUuY29tPjsgTWljaGFlbCBTLiBU
c2lya2luDQo+IDxtc3RAcmVkaGF0LmNvbT4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsg
a3JheGVsQHJlZGhhdC5jb207DQo+IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZzsgcGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tOw0KPiBqYXNvd2FuZ2lvQGdtYWlsLmNvbTsgcGJvbnpp
bmlAcmVkaGF0LmNvbTsgZmFyb3Nhc0BzdXNlLmRlOw0KPiBsdml2aWVyQHJlZGhhdC5jb207IG1h
cmNlbC5hcGZlbGJhdW1AZ21haWwuY29tOyBwZXRlcnhAcmVkaGF0LmNvbTsNCj4gbGl6aGlqaWFu
QGZ1aml0c3UuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMC82XSBodzogQWRkIENudWFz
IHZpcnR1YWwgZGV2aWNlcw0KPiANCj4gIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS18DQo+ICAgQ0FVVElPTjogRXh0ZXJu
YWwgRW1haWwNCj4gDQo+IHwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tIQ0KPiANCj4gT24gMjAyNi8xMS8wMSAzOjU4LCBX
ZXFhYXIgSmFuanVhIHdyb3RlOg0KPiA+IE9uIFNhdCwgT2N0IDMxLCAyMDI2IGF0IDAxOjU0OjA4
UE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gPj4+IE15IGNvbmNlcm4gd2l0
aA0KPiA+Pj4gdmlydGlvIGRldmljZSBpcyB0aGF0IGl0IHdvdWxkIGhpZGUgdGhlIGxheWVyIHdl
IHdhbnQgcGVvcGxlIHRvDQo+IHdvcmsgd2l0aC4NCj4gPj4NCj4gPj4gUGVvcGxlIGJlaW5nIHRo
ZSBzdHVkZW50cz8NCj4gPg0KPiA+IFN0dWRlbnRzIGluIHRoZSBjb250ZXh0IG9mIHRyYWluaW5n
IGFuZCBza2lsbCBidWlsZGluZywgYW5kDQo+IHJlc2VhcmNoZXJzDQo+ID4gZnJvbSBhY2FkZW1p
YSBhbmQgaW5kdXN0cnkgd29ya2luZyBvbiByYWNrLXNjYWxlIHN5c3RlbXMuIEl0IGlzIGFsc28N
Cj4gaW50ZW5kZWQNCj4gPiBmb3IgdXBza2lsbGluZyBhbmQgb25ib2FyZGluZyBzdGFmZiwgYW5k
IGZvciBkZXZlbG9waW5nIGFuZA0KPiB2YWxpZGF0aW5nDQo+ID4gdXNlci1zcGFjZSBhbmQga2Vy
bmVsLXNwYWNlIGNvZGUgb24gYSBjb21wbGV0ZSBzb2Z0d2FyZS1kZWZpbmVkDQo+IHJhY2stc2Nh
bGUNCj4gPiBPUlYzIHN5c3RlbS4gV2l0aCB2aXJ0aW8gdGhlIHRyYW5zcG9ydCBhbmQgdGhlIGRy
aXZlciBhcmUgYWxyZWFkeQ0KPiBkZWZpbmVkLCBzbw0KPiA+IHRoZXJlIHdvdWxkIGJlIG5vIGRl
dmljZS1zcGVjaWZpYyBQQ0llIGRyaXZlciBmb3IgdGhlbSB0byB3cml0ZSwNCj4gd2hldGhlcg0K
PiA+IGFzIGEgdHJhaW5pbmcgZXhlcmNpc2Ugb3IgYXMgY3VzdG9tIGtlcm5lbC1zcGFjZSBQQ0ll
IGNvZGUgdGhhdA0KPiBpbmR1c3RyeQ0KPiA+IGFuZCBhY2FkZW1pYyByZXNlYXJjaGVycyBkZXZl
bG9wIGFuZCB3YW50IHRvIHZhbGlkYXRlLg0KPiANCj4gSSBoYXZlIHJldmlld2VkIHRoZSBzZXJp
ZXMsIGFuZCBpdCBsb29rcyBpbnRlcmVzdGluZy4NCj4gDQo+IEkgYW0gd29uZGVyaW5nIGlmIHZm
aW8tdXNlciBtaWdodCBiZSBiZXR0ZXIgc3VpdGVkIGZvciB5b3VyIHVzZSBjYXNlLg0KPiBXaGls
ZSB0aGUgY29kZSBpcyBjbGVhbiBhbmQgd291bGQgc2VydmUgd2VsbCBhcyB0ZWFjaGluZyBhbmQg
cmVzZWFyY2gNCj4gbWF0ZXJpYWwsIHVwc3RyZWFtaW5nIGl0IHRvIFFFTVUgcmVxdWlyZXMgaW50
ZWdyYXRpbmcgd2l0aCBRRU1VJ3MNCj4gY29tbW9uDQo+IGluZnJhc3RydWN0dXJlIGFuZCBtZWV0
aW5nIGl0cyBhcmNoaXRlY3R1cmFsIHJlcXVpcmVtZW50cywgd2hpY2ggaXMNCj4gY3VycmVudGx5
IG1pc3NpbmcuDQo+IA0KPiBTcGVjaWZpY2FsbHksIHRoZSBpbXBsZW1lbnRhdGlvbiBieXBhc3Nl
cyBRRU1VJ3MgbmV0d29yayBzdGFjaywgYW5kDQo+IG1pZ3JhdGlvbiBpcyBub3QgZnVsbHkgaW1w
bGVtZW50ZWQuDQo+IA0KPiBGaXhpbmcgdGhlc2UgaXNzdWVzIGlzIGNlcnRhaW5seSBwb3NzaWJs
ZSwgYnV0IGl0IHdvdWxkIHJlcXVpcmUgYQ0KPiBzaWduaWZpY2FudCBlZmZvcnQgZnJvbSBib3Ro
IHlvdSBhbmQgdGhlIHJldmlld2Vycy4gVW5mb3J0dW5hdGVseSwNCj4gdGhlcmUNCj4gaXMgY3Vy
cmVudGx5IHZlcnkgbGl0dGxlIGJhbmR3aWR0aCBmb3IgcmV2aWV3aW5nIG5ldHdvcmsgcGF0Y2hl
czsgSQ0KPiBvbmx5DQo+IHdvcmsgb24gdGhpcyBpbiBteSBzcGFyZSB0aW1lLCBhbmQgSSBoYXZl
bid0IHNlZW4gbXVjaCBhY3Rpdml0eSBmcm9tDQo+IEphc29uIHJlY2VudGx5IGVpdGhlciAodW5s
ZXNzIEkgbWlzc2VkIHNvbWV0aGluZykuDQo+IA0KPiBGdXJ0aGVybW9yZSwgZml4aW5nIHRoaXMg
bWlnaHQgYWN0dWFsbHkgY29uZmxpY3Qgd2l0aCB5b3VyIGdvYWxzLg0KPiBUaWdodGVyIGludGVn
cmF0aW9uIHdpdGggUUVNVSBpbnRlcm5hbHMgd291bGQgY291cGxlIHlvdXIgZGV2aWNlDQo+IGlt
cGxlbWVudGF0aW9uIG1vcmUgY2xvc2VseSB0byBRRU1VLCBtYWtpbmcgaXQgaGFyZGVyIHRvIGtl
ZXAgcGFjZQ0KPiB3aXRoDQo+IHVwc3RyZWFtIGRldmVsb3BtZW50IGFuZCBpbmNyZWFzaW5nIHRo
ZSBjb2RlYmFzZSBzaXplLiBUaGlzIGV4dHJhDQo+IGJ1cmRlbg0KPiBtYXkgYmUgdW5kZXNpcmFi
bGUgaWYgeW91ciBwcmltYXJ5IGZvY3VzIGlzIHRlYWNoaW5nIGFuZCByZXNlYXJjaC4NCj4gDQo+
IFVzaW5nIHZmaW8tdXNlciB3b3VsZCBzYXZlIHlvdSB0aGUgZWZmb3J0IG9mIHVwc3RyZWFtaW5n
IGFuZCBrZWVwaW5nDQo+IHVwDQo+IHdpdGggUUVNVSBpbnRlcm5hbCBjaGFuZ2VzLiBPbmUgZG93
bnNpZGUgaXMgdGhhdCBpdCBkb2VzIG5vdCBzdXBwb3J0DQo+IG1pZ3JhdGlvbuKAlHRob3VnaCBJ
IHN1c3BlY3QgdGhhdCBpc24ndCBhIHJlcXVpcmVtZW50IGZvciB5b3VyIHVzZSBjYXNlDQo+ICh0
aG91Z2ggUUVNVSBSRE1BIG1pZ3JhdGlvbiBkZXZlbG9wZXJzIG1pZ2h0IGJlIGRpc2FwcG9pbnRl
ZCkuDQoNCkpvaG4gaGFzIHBpY2tlZCB1cCB0aGUgbWlncmF0aW9uIHBhdGNoZXMgdG8gYWRkIGxp
dmUgbWlncmF0aW9uIHRvIHZmaW8tdXNlci4NCg0KPiANCj4gUmVnYXJkbGVzcyBvZiB0aGUgYXBw
cm9hY2gsIHlvdSB3aWxsIHN0aWxsIG5lZWQgdG8gcmVzZXJ2ZSB0aGUgZGV2aWNlDQo+IElEDQo+
IGJ5IHVwZGF0aW5nIHRoZSBkb2N1bWVudGF0aW9uLg0KPiANCj4gUmVnYXJkcywNCj4gQWtpaGlr
byBPZGFraQ0KDQo=

