Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457DB606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 05:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=qL57uNDc;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=DbOf211v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOTAU-0003PD-66; Wed, 04 Nov 2026 00:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTAR-0003Oe-Ia; Wed, 04 Nov 2026 00:04:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=761a35039=Alistair.Francis@wdc.com>)
 id 1xOTAP-0001vz-HX; Wed, 04 Nov 2026 00:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1793768649; x=1825304649;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=A0/+Ou+ix9ESAF5rPnC8b5yZhlUrzE2x8miUqWIPxQM=;
 b=qL57uNDcgb5nDkZE34oUdo1e5DXXBqZUnpTstMPwZmwyQBvC7W+cjayf
 Kr/EAbmw4zM6j6ADiCnomHWoD+cTcrdTxpmMYv1IBiPFBdhf5V9XxhKfn
 boElsXBAs6TBw/8pS7hIfT3sGvZDiBQ0dNwTZa7varA6SDvsfwr5hfMXQ
 bIqWPFbp/niyRdji+lZ8R3aze5JmeRk9hGRIU0Wg52iC1o80fGoD2mLb5
 zk+fua7cgUdQ1rmLDrleJ7aDn9LrK6EH0d4epUpqQAVpjlWU5WhdmVXZA
 nDB1CpNu8G81aSlMeTVsC2vQ7AL87d3Lb1B5MUpE9P52BbYuoSZj+yH+o w==;
X-CSE-ConnectionGUID: hExDzzI1St6m4k9dgqtGuA==
X-CSE-MsgGUID: jThzT3+qQH60n+iiQ+dLDA==
X-IronPort-AV: E=Sophos;i="6.27,194,1786982400"; d="scan'208";a="155540205"
Received: from mail-westus3azon11010066.outbound.protection.outlook.com (HELO
 PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.66])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Nov 2026 13:04:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoJ4QP3cn6to9qlctP96bBjeHgec0QOwvUcpaT8q2CVe9d67KCYFnCWy1eVNlUzFxhFEiVNQ9r5bmWMSQNj5N7KrEXReg9rauBErIIOMu/IIitfjM7tcn11/+lgrhdTDQpBLuIBitFQVLmZdrrlNw5EPck0P7Y9Pc9mQkvfSS1QzoNm7EqiIIrLtYIIStNXwdFJGqHl9tTtOhCZqGrKFKBwbBUr7AdPLuBoU/qadq5wp+Rldf+f+scxcJ3pT+J4A0+TuLEsK0OCk83iye0NO7e3/F1cXjYlKqGR/cJ0DUwJup8Zh/0Y2PhICnCj667poAr7lcoKJ5LpPdVpB1T4yRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A0/+Ou+ix9ESAF5rPnC8b5yZhlUrzE2x8miUqWIPxQM=;
 b=g04bduDC9PvSJ2dKHvMY0NRrjqh1zs2A6ndYr41ed/1BTflfAxNAXDnGrzitF2y3gXOC5LWRYRHo9bVDGgXriYd8c4gsu5uKhMloEcsIgdTSQW+NIcsGhlluhfN0Og+G11CXRQVuqe7TQ+z3KL8gLPIUgcNy4sv2VJBouNMDQL49OtVHH9hf14rmUvWtXORFjj1PcwhkD+U/XPLTdB+/yQYNqya2NvGqID+OUyXWpCLmMNERfFypUL4v0J88Txbe5Kgm49yhH1VwxFJi4h3R2pkb2+xT8ynpG5RlRKNSQRnCmD2M091LP1i/WeFzPwc2iW1+wHim9zCyLcrHvADdlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A0/+Ou+ix9ESAF5rPnC8b5yZhlUrzE2x8miUqWIPxQM=;
 b=DbOf211v3sOnMXiZgMN0y/3FmeKUlZHXHtIx3yjhYCt+mNTLBzVacyZtbUh8IW6pOpF0iWUlgUcsAqRlut6liNYyRPHS58+Vs5F7py6UjHdvWiIhAtqzRihtp5CyMCuFZ1Q7V+xX7ehhS5akIHet1TiXb7JKHNxZNOPp2bPKECI=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by BN0PR04MB7952.namprd04.prod.outlook.com (2603:10b6:408:157::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 05:04:04 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 05:04:04 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tanchi25@mails.ucas.ac.cn" <tanchi25@mails.ucas.ac.cn>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
 "liwei1518@gmail.com" <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH 1/5] hw/riscv: Build AIA glue only with APLIC and IMSIC
Thread-Topic: [PATCH 1/5] hw/riscv: Build AIA glue only with APLIC and IMSIC
Thread-Index: AQHdaa9ZvckJTQHYukadmp5QDe6fQLcdYHOA
Date: Wed, 4 Nov 2026 05:04:04 +0000
Message-ID: <a369e7930c076d16e5ace32e5bd6fce85db9080b.camel@wdc.com>
References: <20261101031547.125591-1-tanchi25@mails.ucas.ac.cn>
 <20261101031547.125591-2-tanchi25@mails.ucas.ac.cn>
In-Reply-To: <20261101031547.125591-2-tanchi25@mails.ucas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|BN0PR04MB7952:EE_
x-ms-office365-filtering-correlation-id: dc4566eb-a3fc-48cc-dfab-08df3a310c77
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|10070799003|1800799024|23010399003|376014|10067099003|22082099003|18002099003|38070700021|56012099006|4143699003|11063799006|261022105027099003|261026121527099003|261028144727099003|261021123027099003|261026140227099003|261021121427099003|261102123227099003;
x-microsoft-antispam-message-info: g06P6hHixJMppHYcDTS9EgM9iu7klTo7Ej93PNi7iuvjHYc6aPYZ9GTiI/j9gOFAo8kPbI68wBBWS0OAWR7NlxzmI8TmDXc5828QsEPfWp2AIEJLVLlK8PhlAjJmliG1YE+lqg9cAYlb8x7BzWHtxIYm9QVMvNMo+9pgi4YL1OabMh2siw6u3tkTN/CGdp/F8aHNMsAopNMfWN/hnObeKPq+UfEFApNasempn8fiHRE+fD3aTi92DuyIdp9g976fO0hBO6JlfAYrTYOdh+8nGZTNFCudgIVY+mcOpC9elUwg01aC/S6tXfnCy26pOMMynJ259RTzahK4OZL7OE9YNPLHoSpOv0sjz2RBc60oQmbHGp+erhGKDSZlsoVfX019+QfExu67Zzio++KV8P4KJBAmImhtu2q4g5WRMdC2y/kde8iquSulr+uSSWswligOu+t06HyNjXrjEcNoTqTYgUGFRs/yMxl3bjEtoW3bkiI4K7UysKDF3bTLRwnmkvkIC+9PbsdVA0Hjc9BPSaSu5M13gDHR+lYLL98TO5XUfrVkHEBEMjLDU1aVaX2SwyEx897Phel8bSM4iii3Jw/n407vA9krp2RQxEQm/TeTXPmUS5WRUu5OXA6AQUkIqRnJekECLlf8DvRY+/qF20dxkb6UTMMzHZRBjeJu6kcnYQo33OtmkGtoMWAEJlRM4hbGCStOHNqHooTg+TZ8LBEu9Qrps51oHq5HeZWekda3AN8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(10070799003)(1800799024)(23010399003)(376014)(10067099003)(22082099003)(18002099003)(38070700021)(56012099006)(4143699003)(11063799006)(261022105027099003)(261026121527099003)(261028144727099003)(261021123027099003)(261026140227099003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0FRaXNEbWZ3WVV3cnIxZkZzUzF4NUZ3Q25ZQ09NT1BHb1dyK3BDVmF2VjlG?=
 =?utf-8?B?ZVNwZ1NEZW1PU1hnc3FZUy9sN1pwSy9qWXdWdjBTSVR5QTFFdmlLU1pBY0Np?=
 =?utf-8?B?WitmcllMeFpTSmxDT1plVGJ4dUU2Z1pMSEt3NFpXelQ2Nnc4WTQ3ekpjNytG?=
 =?utf-8?B?WkkzME81RjlVUzRaY3lNQVRHVTZzSkxYYkh2eDd4THBOUXRUTjhYZHg2MkQ3?=
 =?utf-8?B?eWUzYXVGNVBmYndjQUpQTzhyVEQyZUVOVm1VMEhUN0hYeExsRlhEVDgvQVdR?=
 =?utf-8?B?VGVDYnRKcFFrMlNaejlvN2FZTjVHYTVWeWdpcWFiMVdEVHJpcUFETTlwQkVJ?=
 =?utf-8?B?eFVTcUd5d0NKcS9PWFpyVk5yYmRWdXJQZjFLbGI4bXBOMWtMMmZEMFpyWEJ6?=
 =?utf-8?B?VEt3eE15TDVQVXdjTml1SHM1M2pBNmFKTWU2eFFDbnJpMEp5bXAvYWN6N1I3?=
 =?utf-8?B?THRsMkNMTmtXdndDK3hjMnFqZHg1WE5YdmFJQitZeElnNlhSUWVQcVIrYnEv?=
 =?utf-8?B?c0JCM2s4Z1A1NFlMNmxyc1RkR0RFZWx1ZElGK1cwcjcxTXNEcTZFc1BDRGNY?=
 =?utf-8?B?S0ZTS2N0dnFGZFJ6dlM3YmlOYkU4VkVHZzBSTU92cEkwVTNzbVNSbFVxdzN2?=
 =?utf-8?B?ZnlZdlZDRjRWS3BzZFA4bnFGNTN2bm14WXVLbkJsN2pKM29ZZk5obGFJNTNu?=
 =?utf-8?B?QWppTW16M1lUT0xtYmJ3SENDenU3SUN6YzZmZnBGTC91UlJoT3RyZ3RrREo4?=
 =?utf-8?B?Z3R5dlExZkdWY2ltWVFXTDJVM3orWUNuUmRES250ZTNJc3o1NGZSczRrTUVa?=
 =?utf-8?B?WTQ5c25yNGpEdkpoS3dRK0xPVmNrSldkTHFJcWtBL0ZxSElOZ1BBMkhHOUVI?=
 =?utf-8?B?TnREMStaUk1HVHVpZEczUTRkOFQrcGFCeldnSjhtRHVxbFlFNHg0OHdCa1cw?=
 =?utf-8?B?K3dUY1JycWUvNTNhTHFRK3lDc2V0VHB4dm1oL3I5YXZqdFJqbmJxN1czZzVx?=
 =?utf-8?B?ODIxSm91Yi9iUDArS2hQWHl3aXVTQjVRenUzbjhHZ0tQcHFhN1dlRzNOdFNx?=
 =?utf-8?B?b0g2cUV0UFBmbmRQTnEyZW84UVJPLzRQWjJPK3RIME5wUFB5ZHJpQU1CckJ0?=
 =?utf-8?B?ZG92bm9KUlY4MkZQdXptV2JGRm5zUDlKcTIrbm5NdENDQ0l0TGtCdVliSkk0?=
 =?utf-8?B?WlUrQVlXeWpNNWlJL2gwZXY2dXpSbWZBWHZsMGVRSHZIWVJVZFZxVVp3Uitr?=
 =?utf-8?B?NEgwMWhrMkNDaWlUMUlvT3lvaXFzUCtkYXdJRlBJUWUydU5xZldtNERxUnZz?=
 =?utf-8?B?UEdLeWRNYjhqZitHamRpYzJSMDQvQXJXYnhjZHFCcnJsbnZlUUZGY0FuMjZU?=
 =?utf-8?B?ZXFHOURkTTB0QzRzOWs0U3BqaDFoYXhBRGZYVXBwZUg5NTlIdE9LMWlpK2Z5?=
 =?utf-8?B?QVZjamIxL0doVGdIKzJKTDNRWE9OT1lFT3AvSEI3bDhwWmJ2bzEwak5kR3BL?=
 =?utf-8?B?cW9TWmo5ci94Q1kwOTZoQWJiOGJXWE00NmhxSTV3eTA1T1YyMXNRd1V6ekxs?=
 =?utf-8?B?Wk5EN1JJRksxRGJGNGZMaHVWalR3QVhuK053SlFidW0xdzdsOXd0eFhidWdi?=
 =?utf-8?B?UFg1c3g2TlBFOXBQcDhVa1BjMUlUYTN1STY0K0o0bDROa0tGQ3h3WVZFZlVQ?=
 =?utf-8?B?MTBSaEg1YjBNSm82ZFlrTCtmTUV1bTRpeTNCMmFERnNzbzR1VEhHSFRERG9y?=
 =?utf-8?B?Qk1ORXE2a2hxZjhFY0hwUHp1d2ZaZFVRaHQ2bWdvVWttVWQ5RFNubXV2c3Uw?=
 =?utf-8?B?OVBtYTlnamNpekVTU1dzYnVDM2FqaTBwOGMrMGgzZDYyRlIxTVBNNERYVm04?=
 =?utf-8?B?R0hjTG1wLzZFajlJdzJOTU5oMXZ3NEJFUmZJejI5bnBaRnBtWXBhQ1ZPQVdQ?=
 =?utf-8?B?UnBoZHRjMEJ3UW1kQk1XYzMzS3AyUHlYMVo0M3NNMlZ5TkpxVm1vajgraC9y?=
 =?utf-8?B?MExLSlZoVUdaY1FoWTlQbHZwSHJaUjNYdlBFMENBWWVnNlJrK3kyUXVWRlhM?=
 =?utf-8?B?ZXVlbURlc3MrNEc1ZHQyRnZ3NlhOaEN5OS92R3dKMzBQYTRkR0NMRkgzdUJ0?=
 =?utf-8?B?dHlUZlU4cjhBKzl6aWQ1c3ZwalNQTlZmREsvUkxOK3UwQzlQQ2RENUdhd1Fo?=
 =?utf-8?B?aCtLZjBObWRZMDVqTTNEUzAvWmxaT0lDVDA2eDU3WEhJYXI4TEQ3Q3pGY1dp?=
 =?utf-8?B?ZHhqbXVTUUtlamJyZ1c4Qjl3aUNqSTlGcmtGMW5jTGgzRG9LcnBlWUxlL01O?=
 =?utf-8?B?MVd6Q29HcHdCb005TFNaSWc2NStnQnNWTTVQZXo1Ukw0RzMwRkdpcXpEQjFB?=
 =?utf-8?Q?7JZEMinHkBuV0Z2dsQZJEU7EJ9m2SBz2exCiaYwmF5aRl?=
x-ms-exchange-antispam-messagedata-1: nHoGqJrpZ3KvHxefWt8poJ/2RYaUu+opRac=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F4D3FFE678E374281FFB39D64318F67@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kds0j5rIWfZUzy5M/LaotKyyiRoClJdKty8K4LInZ1u81KISegf2+xfkNpbsCUJ19bJEZ4Cqgr8azzHbVz5t92iJOE24xuxX95rxWfvMmcOPRY0TMF6O/Fwkq39wd/Zjoo0Gw01esYklMdudkU2DRpsrv547OA00RKbikg5s3fDHT872MFKbmYdXvIrVWU1sNNoYO+SBjiMGX+9qxJK5f+Wk6a+jTiiX1NakK6XDCABv3KDJYUoo1TMXjvo6qCxz+u30X7z4xVd+OJnBSmY6DuVusFy4tVgP2ChYjKoVNpr5myR3fvHWgShOAJIqmzJdQBnGu04g6qJSlvQT571oTw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 600yN88yHRxSMLSyO388C2SSMozAR/jJkfo0n+B/ZfYUHw/WoTPktu+ZQLh63F0ifzQHnbTby8ja3lLT/yGJD8eZ1Q5XFU4uvD3T+6epg3HnPnVoQkiArtYiueXwjyOnFtBcTemk80cPPAGn1gw5W8ElFoM5jWtQiy9LJAF2PHm+O6qN/UEqdZzkIXH4P43zp6QqdwlwWdOlgP0iUMQ8tg2CaG5PCkP7LP/kpqZVwl4aIpw/ZUmVDzU4dV0jnWZbEHG58JX8lI9zGGSEmv4svL6CYw4FiUraY3CFnxyk0IE1iXx83gmuw8snMcCwcB/O7X/xj+EL6QIzMNJwhamy85QbIdPDPzoE5BebOrHyh7kMeIiJYfNirOBjxDgBQ82/R23Um7B7hGq+VkFuwU3moxRISdV0gLwNxjpyNk+KD3xLCgP9qU9N55chfQ5qCtp89ItvjcMKJByu5lDzBNhdWW9lk4OQ1uLPhWCBLXhb1rX//Z3GjQHAb2dRU6k85dTnJmoLT5t8rPelHEz5HmG6jse8oAwdNVhzRE3EEJF35JU2v8ZGQSpk0Oy7a3AoDm4qV7YpDRBoymzVEYv6sTANBw+Lr/0xpcHO7QETr/LpJXYMYu02RUVik/NhUyWy6sC4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4566eb-a3fc-48cc-dfab-08df3a310c77
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2026 05:04:04.6338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stKws66mHcTIGLaaqxopZR3Y7geE2ZCe9oa9WGJ8F6t4F/SJg+2G5Rjs6S+uzWE40yWHdBkez4SswMlsM3j9ZkZCUntaMawmE27nrMl09q8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7952
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=761a35039=Alistair.Francis@wdc.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU3VuLCAyMDI2LTExLTAxIGF0IDExOjE1ICswODAwLCBUYW4gQ2hpIHdyb3RlOg0KPiBody9y
aXNjdi9haWEuYyBpcyBidWlsdCB1bmNvbmRpdGlvbmFsbHksIGJ1dCByaXNjdl9jcmVhdGVfYWlh
KCkNCj4gcmVmZXJlbmNlcyB0aGUgQVBMSUMgYW5kIElNU0lDIGRldmljZSBpbXBsZW1lbnRhdGlv
bnMsIHdoaWNoIGFyZQ0KPiBvbmx5IGJ1aWx0IHdoZW4gdGhlaXIgcmVzcGVjdGl2ZSBLY29uZmln
IG9wdGlvbnMgYXJlIGVuYWJsZWQuDQo+IA0KPiBUaGlzIGNhdXNlcyB1bmRlZmluZWQgcmVmZXJl
bmNlcyB0byByaXNjdl9hcGxpY19jcmVhdGUoKSBpbg0KPiBtaW5pbWFsIFJJU0MtViBidWlsZHMg
dGhhdCBkbyBub3QgaW5jbHVkZSBBUExJQy4NCj4gDQo+IEJ1aWxkIGFpYS5jIG9ubHkgd2hlbiBi
b3RoIENPTkZJR19SSVNDVl9BUExJQyBhbmQNCj4gQ09ORklHX1JJU0NWX0lNU0lDIGFyZSBlbmFi
bGVkLiBNb3ZlIGltc2ljX251bV9iaXRzKCkgdG8gYWlhLmgNCj4gYXMgYSBzdGF0aWMgaW5saW5l
IGhlbHBlciwgc2luY2UgaXQgaXMgYWxzbyB1c2VkIGJ5IEZEVCBhbmQNCj4gQUNQSSBjb2RlIGlu
ZGVwZW5kZW50bHkgb2YgdGhlIEFJQSBkZXZpY2UgY3JlYXRpb24gaGVscGVyLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogVGFuIENoaSA8dGFuY2hpMjVAbWFpbHMudWNhcy5hYy5jbj4NCg0KUmV2aWV3
ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KQWxp
c3RhaXINCg0KPiAtLS0NCj4gwqBody9yaXNjdi9haWEuY8KgwqDCoMKgwqDCoCB8IDExIC0tLS0t
LS0tLS0tDQo+IMKgaHcvcmlzY3YvYWlhLmjCoMKgwqDCoMKgwqAgfCAxMiArKysrKysrKysrKy0N
Cj4gwqBody9yaXNjdi9tZXNvbi5idWlsZCB8wqAgMyArKy0NCj4gwqAzIGZpbGVzIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3
L3Jpc2N2L2FpYS5jIGIvaHcvcmlzY3YvYWlhLmMNCj4gaW5kZXggNTZmYzA2NDUzMy4uNDQ2M2Vh
MmJlOCAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvYWlhLmMNCj4gKysrIGIvaHcvcmlzY3YvYWlh
LmMNCj4gQEAgLTEzLDE3ICsxMyw2IEBADQo+IMKgDQo+IMKgI2luY2x1ZGUgImFpYS5oIg0KPiDC
oA0KPiAtdWludDMyX3QgaW1zaWNfbnVtX2JpdHModWludDMyX3QgY291bnQpDQo+IC17DQo+IC3C
oMKgwqAgdWludDMyX3QgcmV0ID0gMDsNCj4gLQ0KPiAtwqDCoMKgIHdoaWxlIChCSVQocmV0KSA8
IGNvdW50KSB7DQo+IC3CoMKgwqDCoMKgwqDCoCByZXQrKzsNCj4gLcKgwqDCoCB9DQo+IC0NCj4g
LcKgwqDCoCByZXR1cm4gcmV0Ow0KPiAtfQ0KPiAtDQo+IMKgRGV2aWNlU3RhdGUgKnJpc2N2X2Ny
ZWF0ZV9haWEoTWVtb3J5UmVnaW9uICpjb250YWluZXIsDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBtc2ltb2RlLCBpbnQg
YWlhX2d1ZXN0cywNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBtX2ltc2ljX3N0cmlkZSwNCj4gZGlmZiAtLWdpdCBh
L2h3L3Jpc2N2L2FpYS5oIGIvaHcvcmlzY3YvYWlhLmgNCj4gaW5kZXggNWRmMzI5MjYxMC4uZTRk
Y2M1YWFlMCAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvYWlhLmgNCj4gKysrIGIvaHcvcmlzY3Yv
YWlhLmgNCj4gQEAgLTEwLDggKzEwLDE4IEBADQo+IMKgI2RlZmluZSBIV19SSVNDVl9BSUFfSA0K
PiDCoA0KPiDCoCNpbmNsdWRlICJleGVjL2h3YWRkci5oIg0KPiArI2luY2x1ZGUgInFlbXUvYml0
b3BzLmgiDQo+IMKgDQo+IC11aW50MzJfdCBpbXNpY19udW1fYml0cyh1aW50MzJfdCBjb3VudCk7
DQo+ICtzdGF0aWMgaW5saW5lIHVpbnQzMl90IGltc2ljX251bV9iaXRzKHVpbnQzMl90IGNvdW50
KQ0KPiArew0KPiArwqDCoMKgIHVpbnQzMl90IHJldCA9IDA7DQo+ICsNCj4gK8KgwqDCoCB3aGls
ZSAoQklUKHJldCkgPCBjb3VudCkgew0KPiArwqDCoMKgwqDCoMKgwqAgcmV0Kys7DQo+ICvCoMKg
wqAgfQ0KPiArDQo+ICvCoMKgwqAgcmV0dXJuIHJldDsNCj4gK30NCj4gwqANCj4gwqBEZXZpY2VT
dGF0ZSAqcmlzY3ZfY3JlYXRlX2FpYShNZW1vcnlSZWdpb24gKmNvbnRhaW5lciwNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBib29s
IG1zaW1vZGUsIGludCBhaWFfZ3Vlc3RzLA0KPiBkaWZmIC0tZ2l0IGEvaHcvcmlzY3YvbWVzb24u
YnVpbGQgYi9ody9yaXNjdi9tZXNvbi5idWlsZA0KPiBpbmRleCA2YmRhYmI5NTQ0Li45NTcwMzFj
MDdkIDEwMDY0NA0KPiAtLS0gYS9ody9yaXNjdi9tZXNvbi5idWlsZA0KPiArKysgYi9ody9yaXNj
di9tZXNvbi5idWlsZA0KPiBAQCAtMSw1ICsxLDYgQEANCj4gwqByaXNjdl9zcyA9IHNzLnNvdXJj
ZV9zZXQoKQ0KPiAtcmlzY3Zfc3MuYWRkKGZpbGVzKCdhaWEuYycpKQ0KPiArcmlzY3Zfc3MuYWRk
KHdoZW46IFsnQ09ORklHX1JJU0NWX0FQTElDJywgJ0NPTkZJR19SSVNDVl9JTVNJQyddLA0KPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmX3RydWU6IGZpbGVzKCdhaWEuYycpKQ0KPiDCoHJp
c2N2X3NzLmFkZChmaWxlcygnYm9vdC5jJykpDQo+IMKgcmlzY3Zfc3MuYWRkKGZpbGVzKCdkZXZp
Y2UtY29tbW9uLmMnKSkNCj4gwqByaXNjdl9zcy5hZGQoZmlsZXMoJ2ZkdC1jb21tb24uYycpKQ0K

