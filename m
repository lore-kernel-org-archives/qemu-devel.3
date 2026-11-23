Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0D7606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 04:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=XXGSEsFq;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=qOmT9ldf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVLoK-0008FI-KG; Sun, 22 Nov 2026 23:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVLoJ-0008F3-3X; Sun, 22 Nov 2026 23:37:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780e1cc66=Alistair.Francis@wdc.com>)
 id 1xVLoG-0005Da-NN; Sun, 22 Nov 2026 23:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1795408664; x=1826944664;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Yw5ftQ9XDgzgz+/f5iBBZxTg+SpgpFQNxv/Th0RPTHs=;
 b=XXGSEsFqTGMkVoplpVB+f+mQHQaxQClx4ucpwy1XkP/fP52gmzyGghSQ
 rH/VKBzRiMXB/q4gaVMM1Tz0ILr8kWKvcWQBJeAwbTgTR2ALJ+DQYlUQc
 vlAMyH1N8QzAZySNBn57ZgGM3cROsNUqRSrTz16QaUIsRqYLEBLcxZMu2
 3VCf3DPgKAE2SYV4sIQHRlcaB8jASxGI5woRIUg5HFxqBkp3vt9EJQ6QD
 d5aacR3U7YRl+qCllPAKX3Z21u9vcji33pCbKqdyZRXn1VlNOT76ZprjY
 cd1xlAuj3KILLf+acCedC72dt31h83MDpTQszWX1RYLqTLAY+CMsD5CMo g==;
X-CSE-ConnectionGUID: C3u27dcUSR6Dbx0EEVLP3A==
X-CSE-MsgGUID: F6a51zSCRm+vJT7hnE9DQw==
X-IronPort-AV: E=Sophos;i="6.27,227,1786982400"; d="scan'208";a="161458536"
Received: from mail-eastusazon11011011.outbound.protection.outlook.com (HELO
 BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.11])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 23 Nov 2026 12:37:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwYXEqa/kKSZyREPyKTkQz14ynl6RkBz5ItV123gSu8qEmTemtISIyOvvcAWcZTC2eoQgxinaNVLeVoXAa0uFgpQDJd2xJ5D4repdJi297j8bHJ1Nkb7aJP0d41YR+XJ3Vmv3ypwN3Q+X4wBkyXFlUhOkVjaDa7IsYuDwlU8bRZ1P1bwiNVb2UdAGzpCqOhTzv8gIjtvzO78SQQrqdTNOzhhl3RKjrN+t/zngMD9vGAMvtQi7RDrYdj+6qDvM3KSanWEOx5Of2uIyuCrrcu3By28Hh9TkzpHN2wTsSPqtFxGZmdNckXQbhNeK+8WqbT2gPya7kYie2bj05dk/tOlMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yw5ftQ9XDgzgz+/f5iBBZxTg+SpgpFQNxv/Th0RPTHs=;
 b=raIGSdpV5diLctdX4dUQQXcjeldMWDKhL5hUzqtsG9TQIRlbQ31ftHp4WSK0P8/onFUCcxK0mD3IqjRz2rol9KGaWBCVBIZp/lVm9sEzlbpYzzy7JjMEEbEpsIwRIGBfzUXDq2Ljd5HWdcyfSrz61Zj7BcH0gZAU/ROFKMSI3lFAUtMXRZ5JDv8eZWNCKZnxpGSRpDbTkYWUCnLmXEzjHQPaH90SvaOjKggKwkHbyG/G9eaQzfU3oSf047S03OLbdnwdZ5aFXLiZMN9OaMxRjcHpal1hNoqlHVclYOFwxx9k2YKtNJi8gJqlEzAB7a5lTNPpS7lGfb9fZ6IDpj29dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yw5ftQ9XDgzgz+/f5iBBZxTg+SpgpFQNxv/Th0RPTHs=;
 b=qOmT9ldfbnUKdKpwVu26CKrlO4pQlBo/nds9J+z4m58SreEdgm6HuKFdegp2HLiK3gezPXoH77ng8hwMueSyFwo5QAkZtn3MjMWhxPt2PcuYyKc3ApBATlvQlPthuZlH+5dC74LrjDkWsLGCnVRJ9zJo01Q32uzX2Vjw8IrBiZg=
Received: from MN6PR04MB9359.namprd04.prod.outlook.com (2603:10b6:208:4f2::13)
 by CO6PR04MB7796.namprd04.prod.outlook.com (2603:10b6:303:13b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 04:37:38 +0000
Received: from MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77]) by MN6PR04MB9359.namprd04.prod.outlook.com
 ([fe80::e729:bbef:5a37:2e77%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 04:37:29 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH] target/riscv: do not write RVG in misa CSR [GL4811]
Thread-Topic: [PATCH] target/riscv: do not write RVG in misa CSR [GL4811]
Thread-Index: AQHddhXWTF+BZBkbnUGjrRZsMbKTr7c7HIQA
Date: Mon, 23 Nov 2026 04:37:29 +0000
Message-ID: <b116030cc3500c7a77c8a721711c4f008b28bdec.camel@wdc.com>
References: <20261116215953.871862-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20261116215953.871862-1-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.1 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN6PR04MB9359:EE_|CO6PR04MB7796:EE_
x-ms-office365-filtering-correlation-id: ed23994f-c69b-4900-d6b3-08df491b7bb5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|19092799006|10070799003|18002099003|22082099003|260925022911599003|260925021911599003|260925021311599003|261009223027099003|3023799007|261021123027099003|261021121427099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|56012099006|10067099003|261102124527099003|261102123227099003|38070700021|11063799006;
x-microsoft-antispam-message-info: J+MKWHItHbYQTFvP5vR88s+ywIp139y14M0eVCWfUOnfscX9bqlWDNXDlbBTk7t8Qt9roHVMKFeVFKa0rx4Yo7VmzGWQ4+/Z9F4XFG+CSy7Om1XKF8RmFr+ndWJk+ALggHd8Bv0YbRu/IgTrubOrSkJ9b7bM/aKXzklLpypqG6T6gO0WsXak946sW/1x6r6TeO6PZ9YHvqYp72Fi6Z9964U8hKWZMjofdOzCWwtBl4W5/SR2yEXOv6XZrJqgQO4+7axO0vXxS+4VdT+MMJJPHZmx377OLX/n7qYro2md6f70UqCPo9zRSs8SxmS6h/RsHEJyYx3isdABSSD05DHUuKans3eovWPw05p9qeFAXrIQYgRunBRO6ZLP44pyVXBsmsKtywgvjyZHlZiQSxFbTU1V1D62US0aC68EBnJ/iWmXdxwl/y9CVfMVFP/3RHd4nEcNeSQ5IhLUXvr78VOd5Qz2hljIUj4c912CH8gRfo+wUuVGVs9+GQhWtAoN2+jbuBbgu91zuvQ9hZIurp1V2rp498Cu7FE7kV2BXiNYEWYNZwZPWI4wj9miCvvrYmV4kEZLpvBEfhtMM+xkaTCx7DNNMRZd2r+IqmvsBXdkP3KL3murgAU7AlvMN6O159D36IZ7IcDLYen8mHekHizSwny34AXzIh3uibeKQzmJzre0oB+hqviezVlOh12EQW/0SFRWQpWawFWtAvJv3sXXBBp2rYe6c0Hu9OSBlsqvCkk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN6PR04MB9359.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(19092799006)(10070799003)(18002099003)(22082099003)(260925022911599003)(260925021911599003)(260925021311599003)(261009223027099003)(3023799007)(261021123027099003)(261021121427099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(261102124527099003)(261102123227099003)(38070700021)(11063799006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXBYZnNIeUhCeFo5SVhaZG8wYkkwbDNYSC9iV2p4K3dEMit2N3Q4U1hyZENj?=
 =?utf-8?B?MWhRVS9SY1E1aytWbW1wNVpYVWFlbUpnMjJYSVdqbVhYS1pxUkVIei93ZFRX?=
 =?utf-8?B?djJVS0pTaUNlYXFmVGdiT0dQWFNQTEthZEJWS1hncER6UjlqRXloOGtyWUhj?=
 =?utf-8?B?UndSRHNsZlg1L0FsMUt3b0NTSmhtbW9lckVYUE5ndXllWG1qcjlwems2WjJ3?=
 =?utf-8?B?RmpoK0RXWklrR3QzbC8zWHRtcEdUckx6UHd2QjI1VGQ4NkxWTG43ajdjN09T?=
 =?utf-8?B?dVVZSnJscGxMSDdIODR6NEhnd0c1djhDK3FYa0Z3dFdlN3JRSzNBZTIyc01h?=
 =?utf-8?B?SC80SXE0cTBhNTIwNldGOHdTa3ozSzU5SStWUDhxZ3hYTkpmV001TlhFblZV?=
 =?utf-8?B?eE8vMlVxbXAzY1k2V2VKMVU0eWVTVENvbnpFbXdBdFNINnp3NWU4T25kTk1l?=
 =?utf-8?B?Wks0eXFrZExJUHdBTHlleUlDUGVyTDI1eFJYR3hqbHhqODQxN0J6bURiK2wv?=
 =?utf-8?B?eTIvSFJjUjRXNmRGamx4N3NLbnJzMWJ3eGVqdDdWN29wMVlLM2xOcll3Y1do?=
 =?utf-8?B?KzJhc0x2UHVtM2lURzNYV01oM0R0bEhCdVY1MUR1RElWakhJejJTNFVNVFRa?=
 =?utf-8?B?OEljdnpIaXVoSEkvbFVFcWJHc2w4Z2toZGxUVS9oSjlVRmd4RFB4NTNRbno2?=
 =?utf-8?B?M0pNQ3dML3hJMjVXZzI2Y0VrejZSQ0JpdjE4ZEtTNWxBVXRrTUVwNnZ4cXI4?=
 =?utf-8?B?dkJSR3hpYTBSNkQwanFDZGo2aWtsQTVPWXRnNWlGbk5YZlp6MGFGQWVTYW5N?=
 =?utf-8?B?eDlhU2R4bHJoMWU5Y21kRFdYYitPS3RNbThIRVY3Vy9pWVRWcTRyc1pDenVw?=
 =?utf-8?B?ZlZieE5kOTE0OFlWRWVOaFpDTjlQZkZJM1ZseTR3TGFDYkQvZmRzaHNIemNB?=
 =?utf-8?B?MHlJRmkxM1ZIUEpMWHNUV0pJZzB4bGFsTTBPd0JJZlRXVkpnSUoyaXNnRlQv?=
 =?utf-8?B?UXk1NW45L2xFZGZiNW9YTmxlM091MDExQktwNlRWS1hBb2h2UlV2Y05wbkEx?=
 =?utf-8?B?UWtTQVlzSlJGT0FLQk01RkZMdTZhQmxaclROVmNid0d6TmVBSmNVRlgxNzY0?=
 =?utf-8?B?U2hFb3JPcU1NVm82WUtzSnNLZ25tdStNaVVhSUpBSGk4cnNsMnJFd0Vub3RK?=
 =?utf-8?B?SjArVHdpT0ZvZW1HVnRKckQ0OVhvQUhEOUJEaENramxSZGpTV29kUjNIUFZZ?=
 =?utf-8?B?aHl4MkNzcWNBUnhWbEE1eEh1Y2lwYThWZEw2QUg2TmdmTCtIU25IcmNDcHpt?=
 =?utf-8?B?bm4xQzJyNHNYRnAvbTB3NnZBU2l3ZFZkVm9FZkUwTDFQOU41aDdEc1NpdjdB?=
 =?utf-8?B?dHp0ZDVoTmV5N0FaeWRlejNlVU1DUHFMY1A5ZHdYK1hLR21mSGp2VGdJM1BW?=
 =?utf-8?B?UEdHdU1ZWENqc1p0SjV1dCtWOVF3Yzdlb0JRcGdvYzNoQllqT2txcTFRNUY2?=
 =?utf-8?B?VzA2L1Jnd2Jwb2UwM242YkpMWURyRk1NVnJaMXJCRWtyanRnb0I4Q0I2LzRG?=
 =?utf-8?B?VVloUTd1WXhtdlliRnFqSXUzTW83SmcwVVdtN1lFZi9uc1REa2FTREZXZ1ZR?=
 =?utf-8?B?TUdJNktGYTViNXI4NUthd3lkNHlBVHdkMS9QNENSUWFSaE1lNkQvRWpxMFUx?=
 =?utf-8?B?TjVyVXhJcThHVXJzMnRDMW9KUmFQMTRCRndLTG5UNFhuZkpoL2tyYTB3SGpQ?=
 =?utf-8?B?ZTVzMzJOYmVVbmVjRENzTzdFUGtPMWZwdGx1TVdLUFV6RzVldlNqbUNyT2VH?=
 =?utf-8?B?NHhqYmhoMXNoamJkNVRJZ2dNc1RCUlVKU0ZienhEcWttRHpDam1TS2w2ME1y?=
 =?utf-8?B?OGdNak5QbEpiYUxtVEFNN2UwMHFsNGtEY1pmakg1dXBWWWx3cTE3SEtxaDh2?=
 =?utf-8?B?b1NOTlFnVFFKSUY5STNzTW54S3djcVhVV2tzQWRjckdvOExUbGpQai93ZmVU?=
 =?utf-8?B?VW9EenNzVlJ5VG0yRWRpV3NveHlGSHg5aHNUSWtSQWJ0WHlsc1NMU1BTWHN4?=
 =?utf-8?B?c2VzQVZkYWZNK3ZUZG9wSUc2eFdEdEdyWFRENXdQVkhCcmV2WllvNGVjMTd6?=
 =?utf-8?B?UlFMODJqWDMxLzMxL3RQdkt2MmJINFNTZ2xkK25SRHhsUEdESVBzT1lWZHFN?=
 =?utf-8?B?d2lMMTNxcURtM1BDZnZPNWVrdnhKN1JMTUtjdmdRWTZmODZrNW9xU0tkYUdv?=
 =?utf-8?B?Wkc5Tjl6ck9WUEtRMU9ybitaTm9YUFY2Rm1tSnFPbTNTN3JWNmI4aU4vQkRQ?=
 =?utf-8?B?VTlhcUx2cXc5djdxc2paMDRJeEYySW5veFJiL3pSZjREalRKWFZ3cWxwV3l5?=
 =?utf-8?Q?R97IShWvkD04oiIaeAVkk7vn6wC9F0DDUWNuvxmZyykkv?=
x-ms-exchange-antispam-messagedata-1: iP7feHjwxOJgXo6X5vnqhJzro1NSetnrh68=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C09249DDFBB933488A5651C05ED05EB9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fiTeDWXEA78H2yefLIP6wNp3XMo5ajVbTATsDZ+VV6g2PMnEJWW/a2pSrnBGxBo/cCa9kBT7H47CcOqlZK7dDLdg3KtZP5TlkQCCOkVjT0HcNcjw+EijeHgxlvP1H2uBgvRJGtTyzsg35CA2ZPIc6yaztJ/MOg6bFzLPoyvc3B1AXRrdpfdmXIRVIJZNECLqhXgWO+OOjGpOk4pXKpPh6N8z9LpPOE3Yfhzkb/sR5NpuVrE5fvpqw6VRHd+Je10wN6j4IxjMTM2fGmEmMsHObKzniCsPuxV06PRTO7CVk/s7g5hnRio2RPnrnDAX2VczYLClSnKgZa/xXhQjMPJQng==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z8/4jcCz/nT01caQ5FiprVkIbTX+ciMd5885i5XrFrn/4yO8QSwn0EZTqmOm2SSvHqROy1O4N7abxDRwaVFlogRhIudfq0LV4Feq7T2J5nRLIAeVGMXqmdwN2GH3s/2HdqMIEiAAhlWUjcMlFQ8dxhmKj6MnUubwRgi1MZwNTt1jomkZfFcZasM8LmK4+QD5R5fNvRX7F2TU/iU6ZDlsAFEZmbC0brotgiNqSG4Gboo90q/3e4ry9AdsdvGyBreRUvyWehwDTQ1ww8G1SDQ8NnFti7c/8GGUFvw9ssV8FTyfM8wRgazmSH8ow5lhVXIybypP7Ee+tsvxG10zGpqm3P0g2lmVu0VNWYeYq1XJVBQgBpZTD2LR+VzCTjXgZOpEKcTNiw7RFixby8DoSRGtiPEhmk9VMwmx2ZWQ8QDnjvWvQ6gTF6WGnINNLzG3aysw0AYEl6pAQtJHPGDvxTCqVFQ31TP3LCCWiThKbf+CpzbQoR7sor3o7AbMab83rQ96Vg12wsp/wyvVSyTP83wSmhtrbo1gNm6lo5CYyoEeCaIZdxIfZiqb4f3vYAsLuSHTKmMwat08qaye6n0Q8DIiynXPXi3NhXrA+Q12kZbBCuzyfsg2GK1Mo85iU8LeaLkC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN6PR04MB9359.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed23994f-c69b-4900-d6b3-08df491b7bb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 04:37:29.7308 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjetsQL/v9HrgS+YjGDmIkTxeInHzn7zHImV2lvhlERspsIJZEKey6vaARAJnuGZSvnLJBRcPSp4eaI76//J1DQUSjaOFLO4QXnhnEOVvqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7796
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=780e1cc66=Alistair.Francis@wdc.com;
 helo=esa1.hgst.iphmx.com
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

T24gTW9uLCAyMDI2LTExLTE2IGF0IDE4OjU5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToNCj4gSXQgc2VlbXMgbGlrZSB3ZSBjYW4ndCB3cml0ZSBSVkcgaW50byBtaXNhLsKg
IFRoZSBiaXQgaGFzIGJlZW4gbWFya2VkDQo+IGFzDQo+ICJSZXNlcnZlZCIgZm9yIHByaXYgc3Bl
Y3MgMS4xMSssIGkuZS4gaXQgZG9lcyBub3QgcmVwcmVzZW50IHRoZQ0KPiBleHRlbnNpb24gcGFj
ayAiSU1BRkRfWmljc3JfWmlmZW5jZWkiLsKgIFRoZSBvZmZpY2lhbCBleHBsYW5hdGlvbiwgYXQN
Cj4gbGVhc3QgZnJvbSB3aGF0IEkgY291bGQgZmluZCwgaXMgdGhhdCBzZXR0aW5nIFJWRyBpcyBy
ZWR1bmRhbnQgd2l0aA0KPiByZWFkaW5nIHJpc2N2LGlzYSBhbmQvb3Igb3RoZXIgZXh0ZW5zaW9u
IGRpc2NvdmVyeSBtZWNoYW5pc21zLg0KPiANCj4gVG8gbWFrZSBtYXR0ZXJzIG1vcmUgaW50ZXJl
c3RpbmcsICdnJyBpcyBzdGlsbCBzdXBwb3NlZCB0byBiZSBwcmVzZW50DQo+IGluDQo+IHJpc2N2
LGlzYS7CoCBUb29sY2hhaW5zIHdpbGwga2VlcCB1c2luZyAnZycgaW4gdGhlaXIgJ21hcmNoJyBu
b3JtYWxseQ0KPiB0b28uwqAgU28gYXNpZGUgZnJvbSBzcGFyaW5nIG9uZSBiaXQgaW4gdGhlIE1J
U0EgZXZlcnkgb3RoZXIgdXNlIG9mDQo+IFJWRw0KPiBpcyBzdGlsbCB2YWxpZC4NCj4gDQo+IFdl
IGhhdmUgYSBnb29kIGNodW5rIG9mIGNvZGUgdGhhdCB1c2VzIFJWRyBhcyBhIHN5bm9ueW0gZm9y
IHRoYXQNCj4gZXh0ZW5zaW9uIHBhY2sgYW5kLCBmb3Igbm93LCBJIGRvbid0IHNlZSBhIHJlYXNv
biB0byByZWZhY3RvciBpdC7CoCBXZQ0KPiB3aWxsIGNyb3NzIHRoYXQgYnJpZGdlIHdoZW4vaWYg
UlZHIGFjcXVpcmVzIGFub3RoZXIgb2ZmaWNpYWwgdXNlLg0KPiANCj4gRm9yIG5vdywgaWYgd2Un
cmUgcnVubmluZyBwcml2IHNwZWMgMS4xMSssIGZpbHRlciB0aGUgYml0IG91dCBvZg0KPiBtaXNh
Lg0KPiBVcGRhdGUgdGhlIGJpdCBkZXNjcmlwdGlvbiBpbiBtaXNhX2V4dF9pbmZvX2FyciB0b28g
Zm9yIGNsYXJpdHkuDQo+IA0KPiBSZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJv
amVjdC9xZW11Ly0vd29ya19pdGVtcy80ODExDQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBIZW5y
aXF1ZSBCYXJib3phDQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNvbW0uY29tPg0KPiAtLS0N
Cj4gwqB0YXJnZXQvcmlzY3YvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDcgKysrLQ0KPiDCoHRhcmdldC9yaXNjdi90Y2cvY3NyLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMTcgKysrKysrKysrKw0KPiDCoHRlc3RzL3RjZy9yaXNjdjY0L3N5c3Rl
bS9tZXNvbi5idWlsZCB8wqAgNyArKysrDQo+IMKgdGVzdHMvdGNnL3Jpc2N2NjQvdGVzdC1taXNh
LUcuU8KgwqDCoMKgwqAgfCA1MQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKg
NCBmaWxlcyBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IMKgY3Jl
YXRlIG1vZGUgMTAwNjQ0IHRlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtbWlzYS1HLlMNCj4gDQo+IGRp
ZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmMgYi90YXJnZXQvcmlzY3YvY3B1LmMNCj4gaW5k
ZXggMTVjMjdmNGNlNC4uM2IzMmQ3OTYwOSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L3Jpc2N2L2Nw
dS5jDQo+ICsrKyBiL3RhcmdldC9yaXNjdi9jcHUuYw0KPiBAQCAtMTYyMCw3ICsxNjIwLDEyIEBA
IHN0YXRpYyBjb25zdCBNSVNBRXh0SW5mbyBtaXNhX2V4dF9pbmZvX2FycltdID0NCj4gew0KPiDC
oMKgwqDCoCBNSVNBX0VYVF9JTkZPKFJWVSwgInUiLCAiVXNlci1sZXZlbCBpbnN0cnVjdGlvbnMi
KSwNCj4gwqDCoMKgwqAgTUlTQV9FWFRfSU5GTyhSVkgsICJoIiwgIkh5cGVydmlzb3IiKSwNCj4g
wqDCoMKgwqAgTUlTQV9FWFRfSU5GTyhSVlYsICJ2IiwgIlZlY3RvciBvcGVyYXRpb25zIiksDQo+
IC3CoMKgwqAgTUlTQV9FWFRfSU5GTyhSVkcsICJnIiwgIkdlbmVyYWwgcHVycG9zZQ0KPiAoSU1B
RkRfWmljc3JfWmlmZW5jZWkpIiksDQo+ICvCoMKgwqAgLyoNCj4gK8KgwqDCoMKgICogQXMgb2Yg
cHJpdiB2ZXJzaW9ucyAxLjExKyB0aGUgc3BlYyBtYXJrcyBSVkcgYXMgUmVzZXJ2ZWQuDQo+ICvC
oMKgwqDCoCAqIEludGVybmFsbHkgd2UnbGwga2VlcCB1c2luZyBpdCBhcyBhIHNob3J0Y3V0IGZv
cg0KPiArwqDCoMKgwqAgKiBJTUFGRF9aaWNzcl9aaWZlbmNlaS4NCj4gK8KgwqDCoMKgICovDQo+
ICvCoMKgwqAgTUlTQV9FWFRfSU5GTyhSVkcsICJnIiwgIlJlc2VydmVkIiksDQoNCkkgZG9uJ3Qg
dGhpbmsgdGhpcyBpcyBjb3JyZWN0LiBHIGlzIHN0aWxsICJJTUFGRF9aaWNzcl9aaWZlbmNlaSIs
IGNoZWNrDQoiVGFibGUgNjcuIFN0YW5kYXJkIElTQSBleHRlbnNpb24gbmFtZXMuIiBmb3IgZXhh
bXBsZS4NCg0KSXQganVzdCBpc24ndCBzZXQgdmlhIE1JU0EsIHdoaWNoIEkgZ3Vlc3MgbWFrZXMg
c2Vuc2UsIGFzIHdoYXQgZG9lcw0KdHVybmluZyBHIG9uL29mZiBtZWFuLi4uDQoNCj4gwqDCoMKg
wqAgTUlTQV9FWFRfSU5GTyhSVkIsICJiIiwgIkJpdCBtYW5pcHVsYXRpb24gKFpiYV9aYmJfWmJz
KSIpDQo+IMKgfTsNCj4gwqANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMg
Yi90YXJnZXQvcmlzY3YvdGNnL2Nzci5jDQo+IGluZGV4IGFmNDQ0ZTNlNmYuLjVmOGYwZGM4YTgg
MTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9yaXNjdi90Y2cvY3NyLmMNCj4gKysrIGIvdGFyZ2V0L3Jp
c2N2L3RjZy9jc3IuYw0KPiBAQCAtMjIwMCw2ICsyMjAwLDE1IEBAIHN0YXRpYyBSSVNDVkV4Y2Vw
dGlvbiByZWFkX21pc2EoQ1BVUklTQ1ZTdGF0ZQ0KPiAqZW52LCBpbnQgY3Nybm8sDQo+IMKgwqDC
oMKgIH0NCj4gwqANCj4gwqDCoMKgwqAgKnZhbCA9IG1pc2EgfCBlbnYtPm1pc2FfZXh0Ow0KPiAr
DQo+ICvCoMKgwqDCoCAvKg0KPiArwqDCoMKgwqDCoCAqIFJWRyBpcyByZXNlcnZlZCBmb3IgcHJp
diA+IDEuMTAgYnV0IHdlJ3JlIHNldHRpbmcgdGhlDQo+ICvCoMKgwqDCoMKgICogYml0IGludGVy
bmFsbHkgYXMgYSBzaG9ydGN1dCBmb3IgSU1BRkRfWmljc3JfWmlmZW5jZWkuDQo+ICvCoMKgwqDC
oMKgICovDQo+ICvCoMKgwqAgaWYgKGVudi0+cHJpdl92ZXIgPiBQUklWX1ZFUlNJT05fMV8xMF8w
KSB7DQo+ICvCoMKgwqDCoMKgwqDCoCAqdmFsICY9IH5SVkc7DQo+ICvCoMKgwqAgfQ0KPiArDQo+
IMKgwqDCoMKgIHJldHVybiBSSVNDVl9FWENQX05PTkU7DQo+IMKgfQ0KPiDCoA0KPiBAQCAtMjIy
OCw2ICsyMjM3LDE0IEBAIHN0YXRpYyBSSVNDVkV4Y2VwdGlvbiB3cml0ZV9taXNhKENQVVJJU0NW
U3RhdGUNCj4gKmVudiwgaW50IGNzcm5vLA0KPiDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBSSVND
Vl9FWENQX05PTkU7DQo+IMKgwqDCoMKgIH0NCj4gwqANCj4gK8KgwqDCoMKgIC8qDQo+ICvCoMKg
wqDCoMKgICogUlZHIGlzIHJlc2VydmVkIGZvciBwcml2ID4gMS4xMCBidXQgd2UncmUgc2V0dGlu
ZyB0aGUNCj4gK8KgwqDCoMKgwqAgKiBiaXQgaW50ZXJuYWxseSBhcyBhIHNob3J0Y3V0IGZvciBJ
TUFGRF9aaWNzcl9aaWZlbmNlaS4NCj4gK8KgwqDCoMKgwqAgKi8NCj4gK8KgwqDCoCBpZiAoZW52
LT5wcml2X3ZlciA+IFBSSVZfVkVSU0lPTl8xXzEwXzApIHsNCj4gK8KgwqDCoMKgwqDCoMKgIHZh
bCAmPSB+UlZHOw0KPiArwqDCoMKgIH0NCj4gKw0KDQpUaGVzZSBsb29rcyBnb29kLCB3ZSBqdXN0
IHNob3VsZG4ndCBjaGFuZ2UgdGhlIE1JU0FfRVhUX0lORk8gbmFtZQ0KDQpBbGlzdGFpcg0KDQo+
IMKgwqDCoMKgIC8qIE1hc2sgZXh0ZW5zaW9ucyB0aGF0IGFyZSBub3Qgc3VwcG9ydGVkIGJ5IHRo
aXMgaGFydCAqLw0KPiDCoMKgwqDCoCB2YWwgJj0gZW52LT5taXNhX2V4dF9tYXNrOw0KPiDCoA0K
PiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGIv
dGVzdHMvdGNnL3Jpc2N2NjQvc3lzdGVtL21lc29uLmJ1aWxkDQo+IGluZGV4IDNjOGIwMThkOWUu
LjhlN2MyOWE3ZmEgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9yaXNjdjY0L3N5c3RlbS9tZXNv
bi5idWlsZA0KPiArKysgYi90ZXN0cy90Y2cvcmlzY3Y2NC9zeXN0ZW0vbWVzb24uYnVpbGQNCj4g
QEAgLTg5LDYgKzg5LDEzIEBAIHRlc3RzICs9IHsNCj4gwqDCoCB9DQo+IMKgfQ0KPiDCoA0KPiAr
dGVzdHMgKz0gew0KPiArwqAgJ3Rlc3QtbWlzYS1HLlMnOiB7DQo+ICvCoMKgwqAgJ2NmbGFncyc6
IGNmbGFncywNCj4gK8KgwqDCoCAncWVtdV9hcmdzJzogWyctY3B1JywgJ21heCcsIHFlbXVfYXJn
c10sDQo+ICvCoCB9DQo+ICt9DQo+ICsNCj4gwqBpZiAncWVtdS1zeXN0ZW0tcmlzY3Y2NCcgaW4g
ZW11bGF0b3JzDQo+IMKgwqAgdGNnX3Rlc3RzICs9IHsNCj4gwqDCoMKgwqAgJ3Jpc2N2NjQtc29m
dG1tdSc6IHsNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9yaXNjdjY0L3Rlc3QtbWlzYS1HLlMN
Cj4gYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LW1pc2EtRy5TDQo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjQ1YTljYTcyMGINCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi90ZXN0cy90Y2cvcmlzY3Y2NC90ZXN0LW1pc2EtRy5TDQo+IEBAIC0wLDAgKzEsNTEgQEAN
Cj4gKy8qDQo+ICsgKiBUZXN0IGlmIFJWRyBpcyBiZWluZyBzZXQgaW4gbWlzYS7CoCBTZWUgR2l0
bGFiIDQ4MTEgZm9yIG1vcmUgaW5mby4NCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIFF1YWxj
b21tIFRlY2hub2xvZ2llcywgSW5jLiBhbmQvb3IgaXRzDQo+IHN1YnNpZGlhcmllcy4NCj4gKyAq
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsgKi8NCj4gKw0K
PiArLm9wdGlvbiBub3J2Yw0KPiArCS50ZXh0DQo+ICsJLmdsb2JhbCBfc3RhcnQNCj4gKw0KPiAr
X3N0YXJ0Og0KPiArCWxsYQl0MCwgdHJhcA0KPiArCWNzcncJbXR2ZWMsIHQwDQo+ICsNCj4gKwlj
c3JyCXQwLCBtaXNhDQo+ICsJbGkJdDEsIDENCj4gKwlzbGxpCXQxLCB0MSwgNg0KPiArCWFuZAl0
MSwgdDEsIHQwDQo+ICsJYm5legl0MSwgX2ZhaWwNCj4gKw0KPiArCWxpCWEwLCAwDQo+ICsJaglf
ZXhpdA0KPiArDQo+ICtfZmFpbDoNCj4gKwlsaQlhMCwgMQ0KPiArCWoJX2V4aXQNCj4gKw0KPiAr
dHJhcDoNCj4gKwkjIEFueSB0cmFwIGlzIGEgZmFpbCBjb2RlIDENCj4gKwlsaQlhMCwgMQ0KPiAr
DQo+ICsjIEV4aXQgY29kZSBpbiBhMA0KPiArX2V4aXQ6DQo+ICsJbGxhCWExLCBzZW1pYXJncw0K
PiArCWxpCXQwLCAweDIwMDI2CSMgQURQX1N0b3BwZWRfQXBwbGljYXRpb25FeGl0DQo+ICsJc2QJ
dDAsIDAoYTEpDQo+ICsJc2QJYTAsIDgoYTEpDQo+ICsJbGkJYTAsIDB4MjAJIyBUQVJHRVRfU1lT
X0VYSVRfRVhURU5ERUQNCj4gKw0KPiArCSMgU2VtaWhvc3RpbmcgY2FsbCBzZXF1ZW5jZQ0KPiAr
LmJhbGlnbgkxNg0KPiArCXNsbGkJemVybywgemVybywgMHgxZg0KPiArCWVicmVhaw0KPiArCXNy
YWkJemVybywgemVybywgMHg3DQo+ICsJagkuDQo+ICsNCj4gKwkuZGF0YQ0KPiArCS5iYWxpZ24J
MTYNCj4gK3NlbWlhcmdzOg0KPiArCS5zcGFjZQkxNg0K

