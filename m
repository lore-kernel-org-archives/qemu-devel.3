Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54769D3C91A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 14:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLKt-00057g-DK; Wed, 10 Dec 2025 09:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTLKs-00057U-3Q; Wed, 10 Dec 2025 09:38:34 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vTLKq-0001Nk-4s; Wed, 10 Dec 2025 09:38:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xGKJLa8/OTaDHVfOss7DhUTCMiJ0MMpHJGZOPPC4z0mxvm+eIdUf9IvhI5vVls3juLhix9orAEkb3FUg1ks5KTZ6L51APLLqWacUlGPKU6O8/GI2PM/j9tMdBoCjGh3ZMEyLbnsn7RPCeF0110mItLuChy+wlBUogPOrl58NfVHFlDEpFNEffw1+put9d93g9ti0AQGgbxemWsOwLzx7zHVugWnrlKAhTV3xX+gfZt2Kp8l5GkIrmUGQkbYciEQkrYdWdmHKEMjZOeRVYy1vaaDdLSOIWmvrifMRvuMM7wnplpYgZp+giyj1HTu4UtmjmzATK582hm/BjoBtIyUfew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UGpcNqmuiA3X+g+jQ48W4I/dzkAHM0DPlj+X6wMNvZQ=;
 b=nPYUAXCYOJJhJ5whnqrOrXGdaO1qTP5NVLI5cCNHaCr55XcNFjjyQrYu0dyZIhhSwuN/O+HsK74Gyyir1+Pd/W3ImnbzhQCSltQq2w8q9FzNylfzxreX+f9gYqI+I6WleB9+nkxBvKlQOgEORbje3DYd1Kda5dTO5pUafrTSHDMPepAY88W8dt8rFHnH+4ieLDuaWiDvaICmoJX207n7UGKTnQAq7WCsCtft0beIXavFezuHm9BtJPIy4g9nR21YBF+x4TOkir3p0EkPSXIZ3BItI8J6+H4XZbBUGG8eJ0TKGPNqX3v/oy7HA7znb9xmyE8UIU4u6raVTxlNTtzm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGpcNqmuiA3X+g+jQ48W4I/dzkAHM0DPlj+X6wMNvZQ=;
 b=K/dOawM9Yp9EDCehoi3Lw5jEbCSKEpcJDJSzCvisrhHve25sfMUOKMeUKgCcZoGse8sjulSA8s7oxibiAota+nOIv2GzPTGZvPMGwUKqOuvfQjeR5MBsEBo20MpR+ox8pQkt3Q2D4zMrULFZS5Hps77uwZk9wy3vCbKkaw4g7tj5a3wYbA4COHw1Ohe08VxspUuagFDD1Ms3YWSNyHRo5vim+wNMYanh+5+vXeWWhlyrjKjRP9aRS/T8aC6HIsN2wFI9/dP1ekAstv4icqL6NB64oXYWPnDhiyti+Zu7wFuK7W4VdTNkfWObfRFJIUoypilM6iIDMavc7NYX9ylprA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 14:38:25 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::e8c:e992:7287:cb06%5]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 14:38:25 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>, "ddutile@redhat.com"
 <ddutile@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>, Nathan
 Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "wangzhou1@hisilicon.com"
 <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>, 
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, Krishnakant Jaju <kjaju@nvidia.com>
Subject: RE: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
Thread-Topic: [PATCH v5 31/32] vfio: Synthesize vPASID capability to VM
Thread-Index: AQHcaPQNApqpy0IT2km0lyVPSEwimrUa8GUQ
Date: Wed, 10 Dec 2025 14:38:25 +0000
Message-ID: <CH3PR12MB7548A7288E01FBFCABD89033ABA0A@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-32-skolothumtho@nvidia.com>
 <2ce54748-5a35-4ae9-9dea-f893a3467825@redhat.com>
In-Reply-To: <2ce54748-5a35-4ae9-9dea-f893a3467825@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|MN0PR12MB5905:EE_
x-ms-office365-filtering-correlation-id: f6256345-cd0a-45be-b9ee-08de37f9c6db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?U1FLWXBlNlhzYmFqK0tTU1lDcEdUVW9NN0hNY2hxYjZuY1gvK0xBVWtxWWly?=
 =?utf-8?B?RTJFaTNYZVB6azd2MTU0Q3FCQjM2b1lMd1dJRVZVRXMwZDhGdmR6NEduajB4?=
 =?utf-8?B?R3MzeGdnajJsWDB6eEc4ZG1neGhQVWQ2clQ5dVNlb3Y1K0kra3A0Ly9rbHNF?=
 =?utf-8?B?OWh5S01iQnVCNE1kbStJNlNFM3dUOEVRK1RaNFlUVmppc0g2SGpXSCs1S0pT?=
 =?utf-8?B?clpCaFhneFZNOFpUazBvNWV3RzFQUXUwUXpEZVRVb1lRYnVHNTZiUUoyYThF?=
 =?utf-8?B?RDR6L0l6RkFUZTVENWpvc2dwcnNlNVNTNERqV281OGVPZWYvN2YvTC9kV0ps?=
 =?utf-8?B?VENvaHNFaEhrZzJHS0tWZ0tOd0M1eGJ6NitJVCtXODlTbldtNTVCbkJFeEVT?=
 =?utf-8?B?MVl0YXE3VHZMcW1oK2hZRGJvKzRodk9lS3RNSVVEYzAvdHVZY1BBUkNnTS9p?=
 =?utf-8?B?L1dtZ281VW5qMXJrcTRHeXJtRmM4ZDZ6NU5QWXkvS0wvYWlSaUs0dlB1Y1k1?=
 =?utf-8?B?bGRwL1Jzb2VjRk03NVlra3RodkN5Z3BuWU9zSVpZQkNNMTdra25HazRLa2JJ?=
 =?utf-8?B?YW56NzdzbTBXdTBJbFNaOUt3WUR3WXQ4TEovMnNSMk02dS95S2JwWGR1azhI?=
 =?utf-8?B?S1lQTG84Y2VMd0tjSzBKbTB3c2ZSdElDa2VQQmlJQ0JWUGxhSWxvYzhqMFZZ?=
 =?utf-8?B?WDlMcXN3WmxLSzNPUTh5UzlUdVVkamllYVE5eTFGd3dUZCtTamUyQnRFa29j?=
 =?utf-8?B?dVIxZEsrMG5abS92eVRQaDFxN2ROS21FZ2JyVkNVSTcxUFBOc1RSUFhmMzlO?=
 =?utf-8?B?alIxdHJZZ1BDQ21lNnhHQ29iYzcxc3A1ZytRZ1ZaT1Y1azBPa1F5aXFwRGdU?=
 =?utf-8?B?MzBKTkg3QUI1aDltd2I1aUdXdHVadElUSWx4Q1QwUHF3TllSbis4bENEaFpa?=
 =?utf-8?B?ZnByTGhraVVuenJ5bElPTG9IcEZYMkJJbDlyUnFNVnVtWGhqU3Z3aGU5TUhI?=
 =?utf-8?B?VjlucVFPVlVzZ3RMUFg4QThYTEtmQnNKa1I4T0NiaUd6Ym9TRTlxRVF6ZWNn?=
 =?utf-8?B?b2Q1OE9GZlE0Y2FmQWtxdlpyUGZrR1dpcDJIaHZqemlZNThqdnE0Rkt6VnJw?=
 =?utf-8?B?cnVDUTFhbk9MWUZFQUluNTFQc3VhTGFJcisxZFZiK1UyZlNZeXd2RnU2RGJJ?=
 =?utf-8?B?VW1ZMjVrckx5bW5maGlOU3U3UlJxcXBJYXlwTisvTFI5Y1pRZW01ZTMzWk5r?=
 =?utf-8?B?VThwTUtmeFhPbU5TVTVkd0s1TUM3eWJxLzdzL1FCSlA1bnVyVnF4UUcxdjlP?=
 =?utf-8?B?YlArRTlnVWhZVFNUMExWUUxaaFpnRmJ2SmdMOEdkR2ttdU9tSUVwVHBSdkx0?=
 =?utf-8?B?MFZ3NmRCWXp6VkxxbGNOdmUxTFpoSXVhMDFaV2NiYzJEREQrc1JweE12OUdC?=
 =?utf-8?B?QnJKaTZaUFllMUdibXRSYUJWalpaN2FzeHRUK0MrdmhyVDBXTEd5WWc0d3d3?=
 =?utf-8?B?L2ppc2JBQWlXY1dLL005eVIzait4cFk2c0lOaTRMcUVaRFNwMUJ2T2ZhTzRE?=
 =?utf-8?B?QWdJMWQyV1p4anNmOCsxY0N0ZnZzeVVCRjZCVm9tWXpIY2VKK25oU3U4TEM5?=
 =?utf-8?B?aEdyVVNrdnJiZUc3V1l3L0Z6eG03KzAxUlZTcGV0NXdnTUk0Q3NpTlliVlB6?=
 =?utf-8?B?cmp0ZVp1RUlRTVVBcm5BODVqUWxXR0RsR2xPNjU3cTUvQmY1UmtMd2RTRUxk?=
 =?utf-8?B?eXpMcHF3dWNCcGtndXlEQnVLSkc1cE11cGxhS1Q1NGJvNXlQM3NTSDBlZ28y?=
 =?utf-8?B?bzN4OGx0dlpnL3Q1cEZiVldYa2J3K05PN2xJV285WGNUbEhGcjhEN2pkRm1W?=
 =?utf-8?B?TzMzT2c2YXBGN0pZSGpKM2cyek5jNXZpRXB2Y1Z3UHI2N09HcWtzL0hRYU5L?=
 =?utf-8?B?Q0tlRlcvV1I2QnVhUGcwR0xFTFJVT0JPOU9zNVNFQjczTG0xMHBFbEZZWUVw?=
 =?utf-8?B?N0RsY1NLNGRGRDJPUHQ1ZU5Vb0pCdE1HMVcvenZpTVBYME91Q0FrbHZSK1BN?=
 =?utf-8?B?TUhTakFhS2tqdmc4KzBxOGtYejNHNzZ1Z2Fydz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjhTOVVUTGV0eGcycmUrSjBZUTR0bjZIYTBoTmdFR3JzS2NSdmMwK0tiYjZQ?=
 =?utf-8?B?U2FsNEJsS2JWWXd3Um1NSGg2SjQ4cE02aERoU0s5amwvQTBDRktwdGY2cG8v?=
 =?utf-8?B?T2JhRmpxcFJZbG44bVJuM0VKNmNVYThZSVVORU1YbVA3VzNTdWJ3UDJycGRw?=
 =?utf-8?B?bzIyMVp6N3JjaGgvUVVUNHl6djJYOFlDODhaTC90N09WZ3VpMFdveXNENkNR?=
 =?utf-8?B?RVkvaEsybVovWTM3ZUhCd3ZqRjlhbHZPK2FwRjdVRlRRVFcydGVwVUF6MkVi?=
 =?utf-8?B?ZzBieGFkZEwzMVhPK3FlWnJESlZyckRkQ0k4eEgxcDM2R1F3L0dFVnJMUEth?=
 =?utf-8?B?OGU1M3NFRVBNZWxoaGZmcVFhdTFkM2RqS3krUk1RMitqZ2FPazN6SFB4TEV3?=
 =?utf-8?B?eG5UU0RFc1drVVlqM3FnVE11blk2VlRxcTdqMm11d2NCbXNiRS82eHJYOS9z?=
 =?utf-8?B?WHI5bHdTVlRTVkhIL0o2R3FtOHlSK3hBZ2x3emdqMnc0SXZlcnY4bnl2aE9p?=
 =?utf-8?B?eFZwNlhtdThER2p1Zkx1bjgvN3lYSmtEUll0TnFwOE1ybk1mVk5uTEpWeXhy?=
 =?utf-8?B?cmlRTDIvcWFrYnBDNXJZcU84TTFsUHkxN2JpRDFkSjBxaXRMU2R5R1lidjIw?=
 =?utf-8?B?d1V2QXQyeFJZRzQvNSsvRU5FeHZjMVZBc2hCcERhQ0kwUElqUVgrMjVwY3NL?=
 =?utf-8?B?ci9iRUd1Q1BSMjI0N3RMQW55RTlJQ3lOeHlCQldENmFEVGE4SVdTNVI0TXpw?=
 =?utf-8?B?UWUydC9ocWZMK3E1ZWZRSEc0dW03dUlkT0JGTnA5Q1BzcC9ZandnOWFBRUFW?=
 =?utf-8?B?ci8yNnhweHVReDZPQ2pTNWNpazFOUVZ1RUVtNjBIcTE4aWlyTERrMmt6d1pj?=
 =?utf-8?B?UmJ0cXROS0RMdmV1cG5SdUlGNmlpTVNDVzJiS2ZsNHhJb0dwWnJjNUw3YWlz?=
 =?utf-8?B?dTR1V2pJY3RGMFIwZnRCblNVc3FrNGdIbUlNZ09iOTloYTlSZGFPVXFlbXV0?=
 =?utf-8?B?UlpKZTZwTFAzV1dycmNySWtvVWdoZFhnQWNCczJpcTdpS0dIMEZGeDdFSG1r?=
 =?utf-8?B?MWdWOFBFQmR2V3FHZitLTVgxZFhnQU9ZU3E3N3c0S0dDTWhkRnFBUHRZT2ln?=
 =?utf-8?B?eWNaM1lRaXBNTmpJSk5wQkd1SWdSTkEwVkRlZGtJR1k0MWNGS3JyWnhHdURT?=
 =?utf-8?B?cCtSY3NIUlJqNEFTUEYxQUxmSGlpdWJ0c00zRVFIWDFDRmNJYnZhRWZVR2Zw?=
 =?utf-8?B?MzlvaXFjWDVUdjR6aTdHUXJTRzVXKzJJOFFmYWJab1lLQWpGQWFLUHhIUlZs?=
 =?utf-8?B?SnVZSlJYd0RmNDJheWIwdUZ6dVBYVk4rTGdvMVJhcVV4S1RaUHdwdkpFNzNa?=
 =?utf-8?B?dVhEdU9yVkJMcjJkVWdGRTFhMmFROU9DSG9CSUtmeTNSRHl0TXYyVXZsZkRS?=
 =?utf-8?B?YVlWT2xQa3k4TEFSSjFHb3ZMd1Zvekk4ZXY5RjdqNUphL0JtVXhDODlCdVVI?=
 =?utf-8?B?c0NrLzdvcW1ZaTVEcUU2SHhqd01LK0FNdDlUQnNMRGRLRVd2NlVYczFOSS8r?=
 =?utf-8?B?aGNtVDFoY0dmSzBKRFZQRGNuUlVNUUJMR2t4aWU4UlZreUQyaWxGZnZMdjdG?=
 =?utf-8?B?ZnFCY2ExRndjcFJSZUxiaU9JRDNJYU9BTC9kdGFiZzRWb0prblpFbDJ6UC9S?=
 =?utf-8?B?bTJzOWlzSStPT0pEVEs2TEVJcGpSbXZ3cUNndGw2MlhaZzBmVkE3NDg5djdx?=
 =?utf-8?B?Ulp0TFJlcU1hV2J1ZDVudXgxNnJoWEVjNzYwWlhpakYvZHdBcVgzS29heWtx?=
 =?utf-8?B?SVl6dmV5bVRYQVQ2MStFY2NpTXc4eUZaekZaVUtJVW40Q3dDOFRPVjNGT2x4?=
 =?utf-8?B?NXU5eHE5Q2J6Vnp0MXk1OVN4VDBBWGUyYWR3aFNPbUdHRE0yQnpySXhXa0R6?=
 =?utf-8?B?aDY3aXQ3RDhMTDliZEVvRExzUTdaalR2VmlibCtDbHNSRUYzTjRaTDVpSkhl?=
 =?utf-8?B?RU9nZnRKSXBMYW0yTnF3Q09PNkZPMUN1aHc5OU5YZWduZ0ZuYkQwMmJ4dHpm?=
 =?utf-8?B?ZUszRVk0SEp1eG1CVk94a2dkczhhWnoyS1BNcHAycVVjQXhLWEpKZWwzSm5T?=
 =?utf-8?Q?vT3/rMu1hjJQrPtieFhYKcK1i?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6256345-cd0a-45be-b9ee-08de37f9c6db
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 14:38:25.5381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFpQ+X9OhrIx2KNDp+RV3gVFJSeAXhNqDm8khDVhKY8wysZnXYjCTsibPceXxuY5wkbU7Y0tKF6+9KCADI8qXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905
Received-SPF: softfail client-ip=2a01:111:f403:c10c::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SGkgQ8OpZHJpYywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IFNlbnQ6IDA5IERlY2VtYmVyIDIwMjUg
MTA6MTENCj4gVG86IFNoYW1lZXIgS29sb3RodW0gPHNrb2xvdGh1bXRob0BudmlkaWEuY29tPjsg
cWVtdS0NCj4gYXJtQG5vbmdudS5vcmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogZXJp
Yy5hdWdlckByZWRoYXQuY29tOyBwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc7IEphc29uIEd1bnRo
b3JwZQ0KPiA8amdnQG52aWRpYS5jb20+OyBOaWNvbGluIENoZW4gPG5pY29saW5jQG52aWRpYS5j
b20+Ow0KPiBkZHV0aWxlQHJlZGhhdC5jb207IGJlcnJhbmdlQHJlZGhhdC5jb207IE5hdGhhbiBD
aGVuDQo+IDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMgPG1vY2hzQG52aWRpYS5jb20+
Ow0KPiBzbW9zdGFmYUBnb29nbGUuY29tOyB3YW5nemhvdTFAaGlzaWxpY29uLmNvbTsNCj4gamlh
bmdrdW5rdW5AaHVhd2VpLmNvbTsgam9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tOw0KPiB6aGFu
Z2ZlaS5nYW9AbGluYXJvLm9yZzsgemhlbnpob25nLmR1YW5AaW50ZWwuY29tOyB5aS5sLmxpdUBp
bnRlbC5jb207DQo+IEtyaXNobmFrYW50IEphanUgPGtqYWp1QG52aWRpYS5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjUgMzEvMzJdIHZmaW86IFN5bnRoZXNpemUgdlBBU0lEIGNhcGFiaWxp
dHkgdG8gVk0NCj4gDQo+IEV4dGVybmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtz
IG9yIGF0dGFjaG1lbnRzDQo+IA0KPiANCj4gSGVsbG8gU2hhbWVlciwgWWksDQo+IA0KPiBPbiAx
MC8zMS8yNSAxMTo1MCwgU2hhbWVlciBLb2xvdGh1bSB3cm90ZToNCj4gPiBGcm9tOiBZaSBMaXUg
PHlpLmwubGl1QGludGVsLmNvbT4NCj4gPg0KPiA+IElmIHVzZXIgd2FudHMgdG8gZXhwb3NlIFBB
U0lEIGNhcGFiaWxpdHkgaW4gdklPTU1VLCB0aGVuIFZGSU8gd291bGQgYWxzbw0KPiA+IHJlcG9y
dCB0aGUgUEFTSUQgY2FwIGZvciB0aGlzIGRldmljZSBpZiB0aGUgdW5kZXJseWluZyBoYXJkd2Fy
ZSBzdXBwb3J0cw0KPiA+IGl0IGFzIHdlbGwuDQo+ID4NCj4gPiBBcyBhIHN0YXJ0LCB0aGlzIGNo
b29zZXMgdG8gcHV0IHRoZSB2UEFTSUQgY2FwIGluIHRoZSBsYXN0IDggYnl0ZXMgb2YgdGhlDQo+
ID4gdmNvbmZpZyBzcGFjZS4gVGhpcyBpcyBhIGNob2ljZSBpbiB0aGUgZ29vZCBob3BlIG9mIG5v
IGNvbmZsaWN0IHdpdGggYW55DQo+ID4gZXhpc3RpbmcgY2FwIG9yIGhpZGRlbiByZWdpc3RlcnMu
IEZvciB0aGUgZGV2aWNlcyB0aGF0IGhhcyBoaWRkZW4gcmVnaXN0ZXJzLA0KPiA+IHVzZXIgc2hv
dWxkIGZpZ3VyZSBvdXQgYSBwcm9wZXIgb2Zmc2V0IGZvciB0aGUgdlBBU0lEIGNhcC4gVGhpcyBt
YXkgcmVxdWlyZQ0KPiA+IGFuIG9wdGlvbiBmb3IgdXNlciB0byBjb25maWcgaXQuIEhlcmUgd2Ug
bGVhdmUgaXQgYXMgYSBmdXR1cmUgZXh0ZW5zaW9uLg0KPiA+IFRoZXJlIGFyZSBtb3JlIGRpc2N1
c3Npb25zIG9uIHRoZSBtZWNoYW5pc20gb2YgZmluZGluZyB0aGUgcHJvcGVyIG9mZnNldC4NCj4g
Pg0KPiA+DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS9CTjlQUjExTUI1Mjc2MzE4OTY5
QTIxMkFEMDY0OUM3QkU4Q0JFMg0KPiBAQk45UFIxMU1CNTI3Ni5uYW1wcmQxMS5wcm9kLm91dGxv
b2suY29tLw0KPiA+DQo+ID4gU2luY2Ugd2UgYWRkIGEgY2hlY2sgdG8gZW5zdXJlIHRoZSB2SU9N
TVUgc3VwcG9ydHMgUEFTSUQsIG9ubHkgZGV2aWNlcw0KPiA+IHVuZGVyIHRob3NlIHZJT01NVXMg
Y2FuIHN5bnRoZXNpemUgdGhlIHZQQVNJRCBjYXBhYmlsaXR5LiBUaGlzIGdpdmVzDQo+ID4gdXNl
cnMgY29udHJvbCBvdmVyIHdoaWNoIGRldmljZXMgZXhwb3NlIHZQQVNJRC4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+IFRlc3RlZC1ieTog
WmhhbmdmZWkgR2FvIDx6aGFuZ2ZlaS5nYW9AbGluYXJvLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGFtZWVyIEtvbG90aHVtIDxza29sb3RodW10aG9AbnZpZGlhLmNvbT4NCj4gPiAtLS0NCj4g
PiAgIGh3L3ZmaW8vcGNpLmMgICAgICB8IDM3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgIGluY2x1ZGUvaHcvaW9tbXUuaCB8ICAxICsNCj4gPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8v
cGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+ID4gaW5kZXggMDZiMDZhZmMyYi4uMjA1NGVhYzg5NyAx
MDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+ID4gKysrIGIvaHcvdmZpby9wY2kuYw0K
PiA+IEBAIC0yNCw2ICsyNCw3IEBADQo+ID4gICAjaW5jbHVkZSA8c3lzL2lvY3RsLmg+DQo+ID4N
Cj4gPiAgICNpbmNsdWRlICJody9ody5oIg0KPiA+ICsjaW5jbHVkZSAiaHcvaW9tbXUuaCINCj4g
PiAgICNpbmNsdWRlICJody9wY2kvbXNpLmgiDQo+ID4gICAjaW5jbHVkZSAiaHcvcGNpL21zaXgu
aCINCj4gPiAgICNpbmNsdWRlICJody9wY2kvcGNpX2JyaWRnZS5oIg0KPiA+IEBAIC0yNTAwLDcg
KzI1MDEsMTIgQEAgc3RhdGljIGludCB2ZmlvX3NldHVwX3JlYmFyX2VjYXAoVkZJT1BDSURldmlj
ZQ0KPiAqdmRldiwgdWludDE2X3QgcG9zKQ0KPiA+DQo+ID4gICBzdGF0aWMgdm9pZCB2ZmlvX2Fk
ZF9leHRfY2FwKFZGSU9QQ0lEZXZpY2UgKnZkZXYpDQo+ID4gICB7DQo+ID4gKyAgICBIb3N0SU9N
TVVEZXZpY2UgKmhpb2QgPSB2ZGV2LT52YmFzZWRldi5oaW9kOw0KPiA+ICsgICAgSG9zdElPTU1V
RGV2aWNlQ2xhc3MgKmhpb2RjID0NCj4gSE9TVF9JT01NVV9ERVZJQ0VfR0VUX0NMQVNTKGhpb2Qp
Ow0KPiA+ICAgICAgIFBDSURldmljZSAqcGRldiA9IFBDSV9ERVZJQ0UodmRldik7DQo+ID4gKyAg
ICB1aW50NjRfdCBtYXhfcGFzaWRfbG9nMiA9IDA7DQo+ID4gKyAgICBib29sIHBhc2lkX2NhcF9h
ZGRlZCA9IGZhbHNlOw0KPiA+ICsgICAgdWludDY0X3QgaHdfY2FwczsNCj4gPiAgICAgICB1aW50
MzJfdCBoZWFkZXI7DQo+ID4gICAgICAgdWludDE2X3QgY2FwX2lkLCBuZXh0LCBzaXplOw0KPiA+
ICAgICAgIHVpbnQ4X3QgY2FwX3ZlcjsNCj4gPiBAQCAtMjU3OCwxMiArMjU4NCw0MyBAQCBzdGF0
aWMgdm9pZCB2ZmlvX2FkZF9leHRfY2FwKFZGSU9QQ0lEZXZpY2UNCj4gKnZkZXYpDQo+ID4gICAg
ICAgICAgICAgICAgICAgcGNpZV9hZGRfY2FwYWJpbGl0eShwZGV2LCBjYXBfaWQsIGNhcF92ZXIs
IG5leHQsIHNpemUpOw0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgYnJl
YWs7DQo+ID4gKyAgICAgICAgY2FzZSBQQ0lfRVhUX0NBUF9JRF9QQVNJRDoNCj4gPiArICAgICAg
ICAgICAgIHBhc2lkX2NhcF9hZGRlZCA9IHRydWU7DQo+ID4gKyAgICAgICAgICAgICAvKiBmYWxs
dGhyb3VnaCAqLw0KPiA+ICAgICAgICAgICBkZWZhdWx0Og0KPiA+ICAgICAgICAgICAgICAgcGNp
ZV9hZGRfY2FwYWJpbGl0eShwZGV2LCBjYXBfaWQsIGNhcF92ZXIsIG5leHQsIHNpemUpOw0KPiA+
ICAgICAgICAgICB9DQo+ID4NCj4gPiAgICAgICB9DQo+ID4NCj4gPiArI2lmZGVmIENPTkZJR19J
T01NVUZEDQo+IA0KPiBUaGUgSG9zdElPTU1VRGV2aWNlIGNvbmNlcHQgd2FzIGludHJvZHVjZWQg
dG8gYWJzdHJhY3QgdGhlIHVzZSBvZg0KPiB0aGUgSG9zdCBJT01NVSBiYWNrZW5kcyBpbiBWRklP
IChhbmQgb3RoZXIgcGFydHMgb2YgUUVNVSk6DQo+IA0KPiAtIHRoZSBWRklPIElPTU1VIHR5cGUx
IGJhY2tlbmQsIGFsc28gcmVmZXJyZWQgYXMgJ2xlZ2FjeScsDQo+IC0gSU9NTVVGRA0KPiANCj4g
QWRkaW5nIGNvZGUgaW4gVkZJTyB1bmRlciBDT05GSUdfSU9NTVVGRCBzaG91bGQgYmUgYXZvaWRl
ZCBhbHdheXMNCj4gd2hlbiBwb3NzaWJsZS4gVGhlcmUgYXJlIGV4Y2VwdGlvbnMsIHN1Y2ggYXMg
Zm9yIHRoZSBkZWZpbml0aW9uDQo+IG9mIHRoZSBwcm9wZXJ0aWVzIGJlbG93IGluIHRoaXMgZmls
ZS4gVGhpcyBpcywgaG93ZXZlciwgZHVlIHRvIHRoZQ0KPiBkdWFsLWJ1cyBuYXR1cmUgb2YgdGhl
IFZGSU8gZGV2aWNlcyBhbmQgdGhlIGxpbWl0YXRpb24gb2YgUUVNVSBjbGFzcw0KPiBpbmhlcml0
YW5jZS4NCj4NClllcywgSSBkaWQgc2VlIHRoZSBDT05GSUdfSU9NTVVGRCB1c2FnZSBpbiB0aGlz
IGZpbGUsIGJ1dCB3YXMgdW5hd2FyZSBvZg0KdGhlIHJlYXNvbnMvY29uc3RyYWludHMuDQoNCj4g
SW4gdGhpcyBjYXNlLCBJIHRoaW5rIHdlIGNhbiBleHRlbmQgSG9zdElPTU1VRGV2aWNlIGFuZCBh
c3NvY2lhdGVkDQo+IGNsYXNzLCB0byBoYW5kbGUgUEFTSUQgc3VwcG9ydC4gUGxlYXNlIHJld29y
ayB0aGlzIHBhdGNoLiBJIGNhbg0KPiBtZXJnZSBhcyBhIHByZXJlcSBjaGFuZ2UuDQoNCkkgaGFk
IGEgZ28gYXQgZXh0ZW5kaW5nIHRoZSBIb3N0SU9NTVVEZXZpY2VDbGFzcyBpbiB2NCBoZXJlLA0K
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI1MDkyOTEzMzY0My4zODk2MS0y
Ni1za29sb3RodW10aG9AbnZpZGlhLmNvbS8NCg0KSXMgc29tZXRoaW5nIHNpbWlsYXIgeW91IGhh
dmUgaW4gbWluZCBoZXJlPw0KDQo+IA0KPiBBbHNvLCBJT01NVUZEIGJhY2tlbmQgaXMgbm90IHN1
cHBvcnRlZCBvbiBhbGwgcGxhdGZvcm1zLCBzbyB0aGVzZQ0KPiBjaGFuZ2VzLCBldmVuIGlmIGNv
cnJlY3QsIHdvbid0IGNvbXBpbGUuDQoNCkhtbS4uSSBhbSBub3Qgc3VyZSBJIGZvbGxvdyB0aGUg
Y29tcGlsZSBmYWlsdXJlIGNhc2UgbWVudGlvbmVkLiBJcyB0aGUgcHJvYmxlbQ0Kd2lsbCBiZSB3
aXRoIEhvc3RJT01NVURldmljZSBhYm92ZSBvciB3aXRoaW4gdGhpcyAjaWZkZWYgQ09ORklHX0lP
TU1VRkQNCmJsb2NrIGl0c2VsZj8NCg0KVGhhbmtzLA0KU2hhbWVlcg0KDQo=

