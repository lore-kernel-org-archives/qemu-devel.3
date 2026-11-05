Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCE606A326
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=UsBMJmcu;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ojYdaPPM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOpbZ-00056J-Cs; Thu, 05 Nov 2026 00:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpbX-00054D-V1; Thu, 05 Nov 2026 00:01:39 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7622369f3=Alistair.Francis@wdc.com>)
 id 1xOpbW-00054b-21; Thu, 05 Nov 2026 00:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793854898; x=1825390898;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=fNgh+FI8t5LE90rkRst6rcWkSNKSsn4/6Mbc1Fj8sSQ=;
 b=UsBMJmcuC3I5KsitK7ViWlBF36SIXHlJ4O24vcsJz5MHbcv3FLClnW3L
 KJUKC4yeNtdv4XlkNcJvjOR/ywZiLeyQN/I8jfQSBSKHZ2vhNycy+DHr5
 LPAt88F+FP41UWCyM56KR6VzZ1fupysCuP/rj+66fKxSlxz3PBbIxuovP
 nFz0f1kErsOiVIZawVP9qORC8KL/hA8/8+8yYNoiiRstIrKqIL+3x4syP
 4wQx08Hxu0f66qy207LSyUR1IykJO6ZwRL7jAPsNSa38OQRTWuyjvQn5p
 LXFA/XNxl1wxOlUPfAEa2M8guV/BAnlts/nrm13S5FG5JOMtNMgU8rdYJ w==;
X-CSE-ConnectionGUID: nrCkhZvhSqCQdqTIyR6vNw==
X-CSE-MsgGUID: M4sVNfzJQq6E/G/MHw/Asw==
X-IronPort-AV: E=Sophos;i="6.27,196,1786982400"; d="scan'208";a="155631495"
Received: from mail-northcentralusazon11010061.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.61])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 05 Nov 2026 13:01:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFioxI/NYdZWpLUhNQXgCum2HIIUzfpY1L3srOkb6QylxWOiyl2/neJn1n9WKzF1RdGFM+Jop1dlXEmJapnWWbhWkEttUQda7NYoUkeFPLoFhNdrJCuXwIgs8MSwC3tyZRq2oiTxUGOcioSrm94zQ1oPAZw/bXE+I67A6MKUR6AzwJuj6JJQ1pbIdNRgCyPakeNMnT1gXs60CU0Kvfuv0rrgQYGjzgnNBbj2jux/LCvcE+CtlibhzJdllsxf7hMDBWEkOGvqze/g8KJF4BexXPN1yaXt/DL/xWOQNUDLu0gI7ffUdpiHYYwfODFwP02CgfjzgVRd2t/Nm/0Kjnv4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNgh+FI8t5LE90rkRst6rcWkSNKSsn4/6Mbc1Fj8sSQ=;
 b=uEzpygGMHE0HDgzSzleySq9EeeDKVl2M54zygKlqXr/CsnqdaAEzgY3Pi1xp6w1yELBkLKgDA3onuV286keNcsrlUGJVrD5CTWMDaMlPSG4K4ArPV3hqYJiz3JTUG5OaiGEp7MTSv68YC2GFaxGbQw/9HMVbavGwn53QBdZXBzsBd4S08KFeoTN6ZqWSqQf3lRd7zvGiqmgh/lqoO7DSKuaqnjhPZRlR3c6d+C66OstsX/CkRwfjvpHJ9t1grt/r8xfxvqItOVnY3cOt+jAwDUGZ9XmuZvJQC252nFHJzSQxdIDb8FVAc7EnVlorGaV7Xek50oYiua2hB5b2wqZYEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNgh+FI8t5LE90rkRst6rcWkSNKSsn4/6Mbc1Fj8sSQ=;
 b=ojYdaPPMwHIAyyw3ik+RAtuXmySrOGrzv7T/InQW8DHrrV5LbpQfAlz9ZRO5ovl7g20V/didHwaQKxYq2iTJW2UgmxJrPvLppYXf3pFjMaUByy9Pk5VXqAQ9/iQAFAJk0/QH4v6rZwfMYoWEVZD6sAPr3MEY2GbIjQp8UBem1ns=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by PH8PR04MB993683.namprd04.prod.outlook.com (2603:10b6:510:40f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 05:01:34 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 05:01:34 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 5/6] hw/riscv/virt.c: fix base baud in serial_mm_init()
Thread-Topic: [PATCH 5/6] hw/riscv/virt.c: fix base baud in serial_mm_init()
Thread-Index: AQHdYwjqt7Sq8BTXGkGKnHF/WZSHEbce/2AA
Date: Thu, 5 Nov 2026 05:01:33 +0000
Message-ID: <4e1646899998bf3f64a842ee5e8c3a2e161ce2d2.camel@wdc.com>
References: <20261023160913.24992-1-daniel.barboza@oss.qualcomm.com>
 <20261023160913.24992-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261023160913.24992-6-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|PH8PR04MB993683:EE_
x-ms-office365-filtering-correlation-id: 6f767743-bc9c-4170-a9c7-08df3af9dd14
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|10070799003|376014|19092799006|38070700021|261021123027099003|261022105027099003|5023799004|11063799006|56012099006|4143699003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: QAEY211yvuLQEUR0irFVnq4o3ZkE7m9LGwXJ4yybSE6PDbkn1iPVNVRe9zF60E+ksARicrQXjcAjPOb/xFFUOmiv/e2Lv0BZmGQIEE2frjp0LNVSDmf4boInKfFuNPnagV/rqLXWGteG2V9QgJ34CkmOvE0+xWNH2NUpn3iLvoHJ6Q3JNA4Y6VfLMG+mMRj5WW11kkw5VCzLzJ2m8OtxRtBKqvb9q2rSPUeZtpPx8OXIr8AuV3k3EhyDQ3qsFWRVsmRJCY0se6jR2ieJdRKngNLIXceeMQnAJb+3dcX3J4YqbVMAwWiUz85NnQhCPepHIvbewOUqoS/jpucudv6x0hYGYEZx941bMwktmezPh17IMboh4xL6RQ71Q1W8LpL3AG7GT73but2EhQtLJ35R3q2EQeZZ6hj0WW622oL2hOpFBGVwm0XECQhufNO3CHH9QFb4mkPZsL25zpwMzW+dT5fzDoTyE7qMYJdEn0paJ35JC0BCyk7nXIz8zBvbbIrY/vd1EgMqJxRTaszipW9d+jipYUrjtmR5ZCCcUcdTNpJTJkknElEYOfDEmxtqQt2Y1jck29eRu38Eq1ObWBBDuXuzmfnIkWQsBbFdRlJudTBYjoqc1vY2A/COJDGG8HgXUQf92OWNvohcKgkpAk5NeMkuJ4CsM2tAfpeqMVZCLYuROZR/fRsuCDRO1RSxUnRmxbVmEn8B+2bVLAotv0DjMK3fHoUR5x9IYCrUg+W/V08=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(19092799006)(38070700021)(261021123027099003)(261022105027099003)(5023799004)(11063799006)(56012099006)(4143699003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWdhOWJNQlo1L1B5OTlUYi9Bd3hTK3ZnUW1ka2VQZlVOeldFMnRCenJBM09T?=
 =?utf-8?B?VlBuYTRVVHA1WWJScjhXUXZEU0dUdkVpRnZQSjZjTmw4S0xOaXZNYkJxeVRi?=
 =?utf-8?B?VUh5NjA0SFpzSG9UTGpSZWxyVXpKbEhjT0V3R1hrbjBqT2RmaEJyNW1oWDRG?=
 =?utf-8?B?SVpJYXkzNEJhMERmWmtWUkR0T0JoRjNnQTBkU2h2OXhmL2hSamxRRnU4ZUdY?=
 =?utf-8?B?QkxUVUd1ZTNNTGErMURMUlFpZ0NvWmlCL3lCVUxYbHhQcjdKV0F1V0VvOWc2?=
 =?utf-8?B?WnRjSWtHT2U1QVJlRWRJZmtFeERmOFlJRlpHT09zd1docXNDTzFpbjZIdkF6?=
 =?utf-8?B?RVNPYlpaanRkRzEvM3pvV2pKL09BaVJzMld2aWZkR3hJZkE4TjdEWkdpUXh3?=
 =?utf-8?B?M2RRZ0U0cjV5TEVmMzliek53MjF6VXQ0YWJyejQzeG1sc091VnhtZEdGVld6?=
 =?utf-8?B?UEV4M3o2TEdNZ21yNTEwSkxpNC8zK0NYZStJOHF5Y3Nhdi9meEJOR2hPc1Fy?=
 =?utf-8?B?c01OcVVWdDFTeXNrZU96OGZ2c3ljYVlCYTNUSnF0L0NHYTZCWHpRd3ErMFNT?=
 =?utf-8?B?Q2t3NVlNOVpzUjdMdis2WVJpRzlJZTJPWnlnZFU1RUhiVG00TTZsNVB5VDdV?=
 =?utf-8?B?TGZrc0lqQ3FLR2Q0a1BiZEFMd3djem16dFZZcnh0dWFpUnNGTjhydHRiUkZF?=
 =?utf-8?B?dlBxUVB0OEVZVC9PWmRXdkk5eFFFcnBTRXJyeEVSbFBoWitOTkZLMzZvN1FK?=
 =?utf-8?B?d2dhaTFsTXAxVXUwT1VKMWFHZDBHRmlaNDlERld4bllmbVpPaFdGUEVlN3N6?=
 =?utf-8?B?VXhIT0pXNEM3WDFJWGUrcFNGS3YzQkMzdHRNSUdEcEllQ2l4OVQzUEFiMlE2?=
 =?utf-8?B?Q3RmOCtWcTlkc1k1dVA3ODdkT1BRTjk2R1V1U2V1SzkzVndIQUtYWDY4MS8y?=
 =?utf-8?B?NTBubUlyQW9GUnZTd21ha2Uwbis2UlVqbFJuRmhZZGNISkEvYjVzMXliZllv?=
 =?utf-8?B?NDBCYW4zYnJScmxDL3BuNGQxMzUwbTk4S3I4YlV3ZGdSMm1RZGR4MWhKVUd5?=
 =?utf-8?B?VEhzT3JLRjVvYy9oUTBWMmNVT0dEWFJVTE1QYmRid21WSlpRZm90Tm5xaWZr?=
 =?utf-8?B?SmEvMzVMTnZsOHBHL0hBbHc2TFF5TFZtc01CbEdHUk5SOEdJVlhBSjlkQVFo?=
 =?utf-8?B?cXZJalZOSHZvRUJUbFdkblR3Mk85OUEvUU1MWUZ5bkwzL1AvRFlhRHpmRlR4?=
 =?utf-8?B?M013ZXVYeGtreHkrT2dJSHExSmN4ck1XaGtUWFQ0R1hodzlaRFc5eWoyMWxX?=
 =?utf-8?B?bzdGakIrNkZwUi92RldZcXNDWjN4ZDQwUi9yU0MrVVE1RDJjWGpLUDRWSFY3?=
 =?utf-8?B?NFBPS0ZqTHZwYk42QURqZ2hUcWExNzA3clUrc1ZNYWxxeVpkcDRMNEswa0M3?=
 =?utf-8?B?VS9vZG02aFYyK0NYcTFBbHBGeHBtTURHbzdZZVU5dzdLbGxyRU1obkE4ME5n?=
 =?utf-8?B?WWJUOWg2dlgxdnNmTWpsNTcxczM2OUcrQWNjU0tvTTd6Q0hUajRzRy9Bbkhq?=
 =?utf-8?B?R3ZHUmtyUndXazUvNFJ1ZGhYN3hJd3Z2T2p0cEpqZ29pOFlXU3V2SDhqL21u?=
 =?utf-8?B?bDY1RE83b1BRbVJSTlJCV012VmNjcnF5WnF0azdqa0V5ekE3RTFKRldPOWtZ?=
 =?utf-8?B?UndUd0NHN08xc3VZUG51NEdBNU91M3pYOUVsb1NSNitSL2NUaHlzUXlSSEYz?=
 =?utf-8?B?L01hbkhUalpZbkdkVjhTL2lzTklNWGYyUmE4K1hUaU9xR3pJRFltNGNFMXVD?=
 =?utf-8?B?RVlkdUs1c1pnWUpydVdQMnNvamZrUjJFVmlIZDhWeWhqUWV0WWRUWGRqTjZv?=
 =?utf-8?B?Nkd5UTlBc0djdG44SkQza3kwWHRIZ1JhSTFjSDVVbDhnZTFaSlNtMmU4SThT?=
 =?utf-8?B?QVllenRnWUhRYi9VUWpya3UrdTB6RnBJZkpHalExUUp3VzR6cFY1UE5NVnh3?=
 =?utf-8?B?V1ZtcFhDcW5PZjhpcjJ6eWpyWWtCcEF0bzZHUmo3OEczU3IybmlKbnJjMFBk?=
 =?utf-8?B?UlBGZlZiUWw5UXZNSkFPK1dTajBGY3RSNzcrK1ErcEcyV0FzZ1VDcXo5c3Jz?=
 =?utf-8?B?UmRHWHovbVhKRzlXc1NwcW5uWlZOVHArVWtKVXFKak9jTWdKbEhRemlvOE5m?=
 =?utf-8?B?TW9nR1VSQUJRcXloTHBVMld3a01UNlkwRFhzWWhFWlJCWlVxeWJGdXE1MXVu?=
 =?utf-8?B?Yk5MczVKbmhNUTdyTUxTMjA3cElyakRLRXMvS0tNNzcrMHJKSzdDNFh0bmFp?=
 =?utf-8?B?di9FZ0YwL3Nia0NmOWc5V3ZsNURIU2ZCQnBrUGFFbGU0L0hWOTVkRTRoQzhj?=
 =?utf-8?Q?zs9QcETRPzGjL9gxQje3je64igoF0vki/Nv0p2ewxAWNq?=
x-ms-exchange-antispam-messagedata-1: iMZpjM5odZEL2agfF3QJXTQjpEST3xZ8Igg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1403E1402FC5E34FA86BA282D834A0DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: CSD61vti1y2dooROpjoBLX/NklOBegMjf0UVdqu+T68xZ6AHugXuq0pJ1Bz7EGEtkiGvXRHpcqDaQFDS10HvXvnwZHpJ1BBCWo+Ebw27n0qiD49+oIHA0wRqgmnUStyk3TxYftrWPfcYTY5Sums5ActtPK+Q1HN19yRAlOHxlsc0qdoKsmY1HPJ7U87D1VxQpk/dTMbn35HZ0ciKnLCFfcGrdmjjVy6qrSyuQgSma0OP8b6OF8lN6ud0dVzuSH+xmSlKrbXYdTYHjzkuxWcB0zvoei6o+dniSQ1MHvCKRFRaw4mDkIRrxuHNRGtuXRCcWzNfCUKzN0I5HuHs1NCnaw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VJg50pmpCJ3IbANJ5z5YUO5mSsn6kcUDzSg98ogaIGCQsqh6PsGwibOYlgxoQZbCcQX8+aHvGIV9XRdijMW4Q3WL5oOdVRKGXKgCxk2hSi5bDAtjRZeP0vJBlawqeqd3t8sPRMR0ojwPFGmutWtNJZiI9RiLGIKyWuNT++uxs4hzf9sw3B7I1E3GOcrKPfwVKvpl9FO7oqt1NGjPpnXAkcPdxqO8rCTB+c3n+RN8NZCHvouFMjlhELPhC8wecNS19l5xHOjJEys0nhJ1e2tqOuCbgOOQjVBmaqXsTGrW7EdBGQ9x2K6wzYZulB2bDpS1n4Gfzlw1Knoqi9FkVSktA0terVQcsovaQI8gwFWmnooIEA0ZNKMwLI3B4960N7kv568fjOKlAqVQVOm2//UOYQmUJo0AnuybxfUB2HSH7w7kd67FYTw3L7Jp5R+OigcjM+3Qd2p0irwLNSAyw5VfiJ7+WlrOwhIdZguBFQTJZFwQNhEztMqpfphB4YeennoedZlBTLbmohVXQbp6/u1+Va89uGftW/a7RNSw9ct17DTge8M+FBXY1K2NUGNcoaEGYoQRImVc/H/y06Vw73eVn+QIiaMMed/Ibuy0i9aVdqbtXqE1ucuKTzjlsRZsJyfa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f767743-bc9c-4170-a9c7-08df3af9dd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2026 05:01:33.8545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgZLHxEKRytSNuiqxXpxA2D9vLPNMUZtgFCurq5m/ChFhkwlSn8w5UpJbhgEmqSlc17e9CjirVPbJmbEV3F6SrDhoQtM1yIifulMlhecrAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB993683
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=7622369f3=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTEwLTIzIGF0IDEzOjA5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gV2UndmUgYmVlbiB1c2luZyBhIGJhc2UgYmF1ZCBvZiAzOTkxOTMgdG8gY3Jl
YXRlIHRoZSBVQVJUIGRldmljZXMNCj4gd2hpbGUsIGF0IHRoZSBzYW1lIHRpbWUsIHJlcG9ydGlu
ZyBhIGNsb2NrIGZyZXF1ZW5jeSB0aGF0IHJlcHJlc2VudHMNCj4gYSAyMzA0MDAgYmF1ZCByYXRl
Lg0KPiANCj4gVGhpcyBwYXR0ZXJuIGRhdGVzIGJhY2sgdG8gdGhlIGluaXRpYWwgUklTQy1WIHBv
cnQgYW5kIHNvIGZhciBzZWVtcw0KPiB0bw0KPiBiZSBkb2luZyBva2F5LsKgIExpbnV4IHRoaW5r
cyB0aGF0IHdlIGhhdmUgYSAyMzA0MDAgYmF1ZCBzZXJpYWxzIGFuZA0KPiBub3RoaW5nIHNlZW1z
IG9mLsKgIE9yIGJldHRlciB5ZXQ6IG5vIG9uZSBoYXMgY29tcGxhaW5lZCBhYm91dCBhDQo+IHBv
dGVudGlhbCBidWcgaW4gdGhlIFVBUlQgZGV2aWNlcyBzaW5jZSAyMDE4Lg0KPiANCj4gQWxsIHRo
aXMgc2FpZCwgc2V0IHRoZSBVQVJUcyBiYXVkIHJhdGUgaW4gc2VyaWFsX21tX2luaXQoKSB0byBt
YXRjaA0KPiB3aGF0IExpbnV4IGhhcyBiZWVuIHNlZWluZyBhbGwgdGhpcyB0aW1lLg0KPiANCj4g
Rml4ZXM6IDA0MzMxZDBiNTZhMCAoIlJJU0MtViBWaXJ0SU8gTWFjaGluZSIpDQo+IFNpZ25lZC1v
ZmYtYnk6IERhbmllbCBIZW5yaXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVh
bGNvbW0uY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJh
bmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoGh3L3Jpc2N2L3ZpcnQuY8Kg
wqDCoMKgwqDCoMKgwqAgfCAxMCArKysrKystLS0tDQo+IMKgaW5jbHVkZS9ody9yaXNjdi92aXJ0
LmggfMKgIDIgKysNCj4gwqAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNjdi92
aXJ0LmMNCj4gaW5kZXggYzQ0NDdkOTcxYi4uMDNjMTdjZTdkOCAxMDA2NDQNCj4gLS0tIGEvaHcv
cmlzY3YvdmlydC5jDQo+ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBAQCAtOTA4LDEzICs5MDgs
MTUgQEAgc3RhdGljIHZvaWQgdmlydF9tYWNoaW5lX2luaXQoTWFjaGluZVN0YXRlDQo+ICptYWNo
aW5lKQ0KPiDCoMKgwqDCoMKgwqDCoMKgIFZJUlRfUExBVEZPUk1fQlVTX05VTV9JUlFTKTsNCj4g
wqANCj4gwqDCoMKgwqAgc2VyaWFsX21tX2luaXQoc3lzdGVtX21lbW9yeSwgcy0+bWVtbWFwW1ZJ
UlRfVUFSVDBdLmJhc2UsDQo+IC3CoMKgwqDCoMKgwqDCoCAwLCBxZGV2X2dldF9ncGlvX2luKG1t
aW9faXJxY2hpcCwgVUFSVDBfSVJRKSwgMzk5MTkzLA0KPiAtwqDCoMKgwqDCoMKgwqAgc2VyaWFs
X2hkKDApLCBERVZJQ0VfTElUVExFX0VORElBTik7DQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMCwgcWRldl9nZXRfZ3Bpb19pbihtbWlvX2lycWNoaXAsIFVBUlQwX0lS
USksDQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUklTQ1ZfVklSVF9V
QVJUX0JBU0VfQkFVRCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
ZXJpYWxfaGQoMCksIERFVklDRV9MSVRUTEVfRU5ESUFOKTsNCj4gwqANCj4gwqDCoMKgwqAgaWYg
KHNlcmlhbF9oZCgxKSkgew0KPiDCoMKgwqDCoMKgwqDCoMKgIHNlcmlhbF9tbV9pbml0KHN5c3Rl
bV9tZW1vcnksIHMtPm1lbW1hcFtWSVJUX1VBUlQxXS5iYXNlLA0KPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAwLCBxZGV2X2dldF9ncGlvX2luKG1taW9faXJxY2hpcCwgVUFSVDFfSVJRKSwgMzk5
MTkzLA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXJpYWxfaGQoMSksIERFVklDRV9MSVRU
TEVfRU5ESUFOKTsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDAsIHFkZXZfZ2V0X2dwaW9faW4obW1pb19pcnFjaGlwLCBVQVJUMV9JUlEpLA0KPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUklTQ1ZfVklSVF9VQVJU
X0JBU0VfQkFVRCwNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNlcmlhbF9oZCgxKSwgREVWSUNFX0xJVFRMRV9FTkRJQU4pOw0KPiDCoMKgwqDCoMKgwqDC
oMKgIHMtPnVhcnQxX3ByZXNlbnQgPSB0cnVlOw0KPiDCoMKgwqDCoCB9DQo+IMKgDQo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L3ZpcnQuaCBiL2luY2x1ZGUvaHcvcmlzY3YvdmlydC5o
DQo+IGluZGV4IGU1MTY4OThmOWEuLmY2NmQyZjMzNDIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUv
aHcvcmlzY3YvdmlydC5oDQo+ICsrKyBiL2luY2x1ZGUvaHcvcmlzY3YvdmlydC5oDQo+IEBAIC0x
MjEsNiArMTIxLDggQEAgZW51bSB7DQo+IMKgI2RlZmluZSBWSVJUX1BMSUNfU0laRShfX251bV9j
b250ZXh0KSBcDQo+IMKgwqDCoMKgIChWSVJUX1BMSUNfQ09OVEVYVF9CQVNFICsgKF9fbnVtX2Nv
bnRleHQpICoNCj4gVklSVF9QTElDX0NPTlRFWFRfU1RSSURFKQ0KPiDCoA0KPiArI2RlZmluZSBS
SVNDVl9WSVJUX1VBUlRfQkFTRV9CQVVEwqAgMjMwNDAwDQo+ICsNCj4gwqBib29sIHZpcnRfaXNf
YWNwaV9lbmFibGVkKFJJU0NWVmlydFN0YXRlICpzKTsNCj4gwqBib29sIHZpcnRfaXNfaW9tbXVf
c3lzX2VuYWJsZWQoUklTQ1ZWaXJ0U3RhdGUgKnMpOw0KPiDCoHZvaWQgdmlydF9hY3BpX3NldHVw
KFJJU0NWVmlydFN0YXRlICp2bXMpOw0K

