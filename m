Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73914FD5323
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 09:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvuUY-0005T1-I5; Fri, 27 Feb 2026 04:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vvuUX-0005SW-7y
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:50:37 -0500
Received: from mail-japanwestazlp170110001.outbound.protection.outlook.com
 ([2a01:111:f403:c407::1] helo=OS0P286CU010.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vvuUV-0008DJ-08
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 04:50:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoseUA8J/6++AERfbNalLhkgga156roRYrykdSi4ejL10aCiMQK2uS/f9+y9hkwEc48JSYsd7baYXL7zK9asDimSYq011DvML3LHRfWgrhvxmYGA5Ww4WJTNn/2bOVDjEd4T2NIzSW++/Pr5sRP1g+EvFb6fb0DntZbe6R3qiibTexAANLNcuGJTgeFBbw/y0SFcSKicpNcVucsuNy3QSHwUhTbRB1BVhtoue3vp5tAjmwYdRjdHH/ReWhNShtzAnItZAX/+LhWzF9Do/kG81jDrUJ2Cis59BZryrT3QBgZW2bYcAhxHQMMNiIqC5QdgQLQA3UWu2ZjcwGZvBbvqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d96lEPQ509zfqOjHZ4e909nqBpt1Znedu9L8XFWOikM=;
 b=xY6CRnNd6y7V/PHb0/D4gLouJ21lYUnChOWAczElWInRUPwfVa3rKfXApMFGykcrvf7lD1eNyIXO35qSST7oVM+OiUaQ40ScRMlrNwBAYe8YtG61aBjrt7OQ8t+xGjKPjIOqGLQkE6FmMZAYHGg1IM9bqVG1C9b7LkVvL54GF8pGSEZE5gLZXLAzH8oWy2Lt85OnGKLjCGMOm3FuuvtvmZf3ZiH7aopRiT6HiOjRkHRfDie3s/D0Ncp5vbaR6Os0UMbB6B7dZBMR3hKui9kHKX8zFLlXqjw3ITnthGQV9aEI9+0/oYRo0Cmkr0kJbXK4bpx1PkMiDR32oAXuc5NaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d96lEPQ509zfqOjHZ4e909nqBpt1Znedu9L8XFWOikM=;
 b=bOWrEIEvwQW2sutGrLWi0+YFCC5y3eYRU+tSw6pHzGbWBnUvLI2nU5LnGOOSS8SRMU43n/dOnIC6FvA0Pck1L9Mlu9K3s+sA9lV+Ppzt4t/7gT9SyhESYTEcNbpJeYDpnsOLRgzmMLLQ56se/V3Elmkconc5XXfhSLNZ3BcYk+WckNqAiRibQbzMmRtFQh7RGiHXju1qfR8Znt7iiuWDXjyaqcxv/VxRhrii6rEPFjjfoVsGTyoG7W67WZiBdlYhamKR4n7/4CyW2Ne8DMfh6gmnZu2QzmB2evOwgrMlRciKM/AR32kNNsCtBr3zLjzuIgjn1B7I7hpL18QRdkXMyQ==
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 (2603:1096:405:32e::20) by TY4PR01MB12634.jpnprd01.prod.outlook.com
 (2603:1096:405:1ea::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 09:50:30 +0000
Received: from TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f]) by TY7PR01MB16837.jpnprd01.prod.outlook.com
 ([fe80::5812:babf:b430:670f%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 09:50:30 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "anisa.su887@gmail.com" <anisa.su887@gmail.com>, "armbru@redhat.com"
 <armbru@redhat.com>, "david@kernel.org" <david@kernel.org>,
 "gourry@gourry.net" <gourry@gourry.net>, "imammedo@redhat.com"
 <imammedo@redhat.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>, "nifan.cxl@gmail.com"
 <nifan.cxl@gmail.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "venkataravis@micron.com"
 <venkataravis@micron.com>, "xiaoguangrong.eric@gmail.com"
 <xiaoguangrong.eric@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Thread-Topic: [PATCH v6 3/3] hw/cxl: Add a performant (and correct) path for
 the non interleaved cases
Thread-Index: AQHcpzO3f3dF0AEpTUO0LYNyxj4H1LWWTpoA
Date: Fri, 27 Feb 2026 09:50:29 +0000
Message-ID: <05672de2-df38-4174-8cba-972f079a9193@fujitsu.com>
References: <20260226152034.1523-1-alireza.sanaee@huawei.com>
 <20260226152034.1523-4-alireza.sanaee@huawei.com>
In-Reply-To: <20260226152034.1523-4-alireza.sanaee@huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB16837:EE_|TY4PR01MB12634:EE_
x-ms-office365-filtering-correlation-id: cb228dff-d975-44f0-2f3b-08de75e5a434
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|1580799027|38070700021; 
x-microsoft-antispam-message-info: 8XHezitKehNsT4oBpKj9UCjx5oPrBktzLF86OQSKnYy63Gdqw2U6QUiFZSML1nYOKHE9laycsn3+VgJ+slB+BIOE7TkoU/zv5GvOe7PbCzkhBCCxWsBshyHhBJznwHBvxAZAuVTpxg4g9pFRrtl2aUuAlLzAJlJpEYEnG+CU2hudtz1yKuAfOH+hUGNZUWXLgqBU70hwjnM5+stTg8cy5VdSNBOL7b2/eIXj+l4q4VKKV+lojnyU2MDLFRiQHsIaAzAK4IRz+KkMbmo0NrnxRLwGNp3xvIeaarFrxNliisDYvWl7/Pj4idgPRhGT2Ot1ERLEVyJOrrjGQVq09924DQw/3gpAr8dgMZx8bWKC25QpdKAKtFwX7Po0xKpWBVpLibSrO8c+fGDkoB8hOyaj2IaGwCJdhJKgaTx+IJeX5fmg4hDns2Jzd2gIPSr7I6nu61GP6DoujiJFRinkgx7JPsWUWAPCRgfc/sMBaZZGgb4W61S2kP3OyQi1puqF/i4gYypbaEeJtRS80FEzlZzUwA+vDC+fcUmZGuXjSWiyfZhfGJNue+u1GJZ3AQDEyKlKnAOt/zDKM1nn2YQrfI1Orq620zs2HnU4ZoV6QtOp1bhlyBFVhPnvNYmABJgieSJVL6w1X70fOp5RxcaBvJQDuJOWT6Xs1lMF5BSFB+xwSjaw0DFU6hFlwrU4E2rJeT2DousIgM3nBGBV86VouQ7buFqkwYPkYbiYtrvL5d+lCABc2307vnGGM+nzr3z9Rnba1andl5rVyLVX645qcICmzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY7PR01MB16837.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sm12WGxPc1RrNjZDazVpcllYZlBPcWllV0ppRnR6MVVqNU91bkFKRUdRR3Zl?=
 =?utf-8?B?ejdISzNUWFBjSWhZa1RrMHZ0dS9xMmwwTkpCcnVMamwrNCtpcU90RDAxMU9G?=
 =?utf-8?B?UDd3WHBrUnByTDBxOHZZaUZ0eGdrVG05bEsydmN3QVR0VGkvTTNZQzFpRUQr?=
 =?utf-8?B?TFNZVFpYSG9SdFowYlhtOUVEY3JLSXh4Ky93akNDL0YxYktFUmIwMmZQcjg1?=
 =?utf-8?B?em81bU1YMzBoTER0anBpcFc0OHhDL0M5bGZQRkhQYkw3WGhPd2k3djhOVm0v?=
 =?utf-8?B?aHhnVVdESXo4Z282dVFjWlNEZWo5NkZMc05oSDJab2NFV3NzU0ZyeXZJZW1v?=
 =?utf-8?B?NVBYV2Y5enFCNFNMTk1DM0UyVk8zS0ppSWU1QW13RGI1aXBjdFpDeFVsSk5K?=
 =?utf-8?B?ckpwbnhqc2g1NXVWa1FDT25GL1J5eXdJanFXeFg0YStPY2pqRVhDaEZSckNs?=
 =?utf-8?B?R0h3Y0NZYTVURGdKTDRIZlZhN1MrMUdGL2V4dUt2VUpnb2RjRG82cktMNDlT?=
 =?utf-8?B?WTFSbDNQYWU3V3VJTlNlakdKMW5lWVlQZTUrMWlIbUNCUTBoTjFOOThiVGlR?=
 =?utf-8?B?enBCc3UyaCttUnNXeU5yVWMzcGdhZTlZU2JTQ2pSZldOWjhyRGRLMFgrZlg2?=
 =?utf-8?B?U0M1M05kaDAyNGdGa1pQekdZd0RLdFZLcUxaNGlYcGRENVRGYldJYzZJMW0w?=
 =?utf-8?B?V3hSeXVabndJS3o4OFE0Rk5iSEY0VnhuV0RvOXB3WDVLeVBRSGllQUozT2RC?=
 =?utf-8?B?RlNtV2xjdWw4dFp2NXFnK3lDT2tvVTcvaHhnSHYxRUJOeVlLTmljTzZiWm1Q?=
 =?utf-8?B?alVrOEFSQXhWbGlkZ3FqWTFKWVJQSFhtVTRIOU04ZDN3cGlFYnZZQnJzVVUx?=
 =?utf-8?B?UHlVWE5SQm9WYTZPcnVYczJZVGlwM1duY09MTXZRMVNLckd3bjFYZ3pkQ2Ur?=
 =?utf-8?B?elR0R2MzVEtWKzBDbWk0T2wwSzl1Q05xckhqY0VIbzFVelBEVXVBRW9ScDEv?=
 =?utf-8?B?QSt6cEs4UHVuZ1E4NkNYbWZybDVTMjVuZ0k0Yk0vMnVzMThRRXA5WjdNQUh4?=
 =?utf-8?B?bjhpMEhLTTJXT3d2WW1EVjZyaXdJcHFTbi9VRXpJOWI4b3NjL3dsclF1OXpP?=
 =?utf-8?B?NTBLY2doNysyQldJbk1vV0Vqd2lXckRVY3pDSk92Tzk1S3A5SUk1RUg2Yklw?=
 =?utf-8?B?Y2dvS0VMWS9DTEtBcUp1MWJDdHdqZTZQS3ByWE5pUk1ZSDdiWC9KNCtUZnFH?=
 =?utf-8?B?Q243RE8xVUl0Rjdxc0NGaTY3ZTdYUGdrN3VkT3NUVGFPellqeFRKTFd5NWNT?=
 =?utf-8?B?VmtiSE9LVDFRUnh5SG0vL0F4ZnByMElGUVFUNGxFVnFqaVRmU2l5aE5pd1lB?=
 =?utf-8?B?aUp3Vk9aOE1obm9zTXF6N3l1Y3QrNzVCaVFKRWU3aTJwa1Zjd1pPbXYxdjJJ?=
 =?utf-8?B?dmM5MUlwOWxjWHFaSDN2K3lYUmdLNHpDMlFxRVRWQk5TTXJWZWY3Y2x6czNz?=
 =?utf-8?B?YXpSbGM1MVlWZmRIeGdUbjB3WEtzWi9XY1l1NmpnR3pyLzNDRWp4V0V3emJx?=
 =?utf-8?B?WjZHTHZqQTFvTkUwbjArRWpHLy90eVg0UGJRYmQwaHJ3ZWNlRkFCT0ZrZ05r?=
 =?utf-8?B?dXBLeUc5Z1BPSDlrMVJhNUhiY0ZtT2ZUWEN3KzJhVnRaampsL0xjaXpZRnJ2?=
 =?utf-8?B?WG1ZUWFwNndoOVR4TGVEL1diczlmS2toZlVibW8rY2gwN1JYNUdRcG0zMG02?=
 =?utf-8?B?TXVsL2xQUzBmTG0waGxWMlE5RmRFczFKQUlOY01RMmJSRFY0UU9FMTRJMFcx?=
 =?utf-8?B?dVk5czBUb211dmZyM3FXaWNadUZHUGMwN0ZYTFBxZVdEWW5ZT1BDNGV3SGVt?=
 =?utf-8?B?TlpFVjBuZE13TDlpZDF0NnNrYzZ6T2J1R3MvbW5TUWg3VzdPZWtGZlJ0bVFk?=
 =?utf-8?B?R2xqTEwwRlYzK01HNXpQY0F1ZjNRVVNYQmMzNm9GSXVIOWg4UE9QR04wNkZ5?=
 =?utf-8?B?L1BxakFmZjFVU2hqcmFSaU1PbmVwYzVKZW9xQVdHanlGV09saDZHeEpMNVYy?=
 =?utf-8?B?WFFFbWQ5UFZlSStRQm1MdzJpY1IwTzFDZ0lxV1hJcWc0UkRRMWUrNjY0QnBG?=
 =?utf-8?B?VWMveU5CZk5uTmZpOXlzclRIaGNldGFiRzd1UTZUaGQvdnR0a0NKYlBaR3pN?=
 =?utf-8?B?dGMydGN5Y1JCYWkrVGlCNHJpUGYzQzBMelRrMll1SGZQS04zbnB3T1dUZjFP?=
 =?utf-8?B?aFNkZEExM3hhQ1FNL0htUElDdkpzTkRKbldFM043MndkT2JDUWhYM2ZzNCtt?=
 =?utf-8?B?SWRNaU44dktucnFsVUFyeTJUV3psRWJXcjNvS1FBUS9HUU9uOUtnUGJ1b1pu?=
 =?utf-8?Q?nz10QjKnUS3M3jwg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2D6B54A6DC4C14095F9B06A9EA5E417@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB16837.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb228dff-d975-44f0-2f3b-08de75e5a434
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 09:50:29.5660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s4jhcumNmh8OpoqLOqQqalYZHm8pxy4kdXiK9CyObspjV4TRHnzrr7baSwDkQ/EtOsvJz3s/nHNxgp03LJ4syw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
Received-SPF: pass client-ip=2a01:111:f403:c407::1;
 envelope-from=lizhijian@fujitsu.com;
 helo=OS0P286CU010.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoodXBkYXRlZCB0aGUgcmVjaXBpZW50OiBzL3BwYm9uemluaUByZWRoYXQuY29tL3Bib256aW5p
QHJlZGhhdC5jb20pDQoNCg0KT24gMjYvMDIvMjAyNiAyMzoyMCwgQWxpcmV6YSBTYW5hZWUgd3Jv
dGU6DQo+IFRoZSBDWEwgYWRkcmVzcyB0byBkZXZpY2UgZGVjb2RpbmcgbG9naWMgaXMgY29tcGxl
eCBiZWNhdXNlIG9mIHRoZSBuZWVkIHRvDQo+IGNvcnJlY3RseSBkZWNvZGUgZmluZSBncmFpbmVk
IGludGVybGVhdmUuIFRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9uDQo+IHByZXZlbnRzIHVzZSB3
aXRoIEtWTSB3aGVyZSBleGVjdXRlZCBpbnN0cnVjdGlvbnMgbWF5IHJlc2lkZSBpbiB0aGF0IG1l
bW9yeQ0KPiBhbmQgZ2l2ZXMgdmVyeSBzbG93IHBlcmZvcm1hbmNlIGV2ZW4gaW4gVENHLg0KPiAN
Cj4gSW4gbWFueSByZWFsIGNhc2VzIG5vbiBpbnRlcmxlYXZlZCBtZW1vcnkgY29uZmlndXJhdGlv
bnMgYXJlIHVzZWZ1bCBhbmQgZm9yDQo+IHRob3NlIHdlIGNhbiB1c2UgYSBtb3JlIGNvbnZlbnRp
b25hbCBtZW1vcnkgcmVnaW9uIGFsaWFzIGFsbG93aW5nIHNpbWlsYXINCj4gcGVyZm9ybWFuY2Ug
dG8gb3RoZXIgbWVtb3J5IGluIHRoZSBzeXN0ZW0uDQo+IA0KPiBXaGV0aGVyIHRoaXMgZmFzdCBw
YXRoIGlzIGFwcGxpY2FibGUgY2FuIGJlIGVzdGFibGlzaGVkIG9uY2UgdGhlIGZ1bGwgc2V0DQo+
IG9mIEhETSBkZWNvZGVycyBoYXMgYmVlbiBjb21taXR0ZWQgKGluIHdoYXRldmVyIG9yZGVyIHRo
ZSBndWVzdCBkZWNpZGVzIHRvDQo+IGNvbW1pdCB0aGVtKS4gQXMgc3VjaCBhIGNoZWNrIGlzIHBl
cmZvcm1lZCBvbiBlYWNoIGNvbW1pdC91bmNvbW1pdCBvZiBIRE0NCj4gZGVjb2RlciB0byBlc3Rh
Ymxpc2ggaWYgdGhlIGFsaWFzIHNob3VsZCBiZSBhZGRlZCBvciByZW1vdmVkLg0KPiANCj4gQ28t
ZGV2ZWxvcGVkLWJ5OiBKb25hdGhhbiBDYW1lcm9uPGpvbmF0aGFuLmNhbWVyb25AaHVhd2VpLmNv
bT4NCj4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2FtZXJvbjxqb25hdGhhbi5jYW1lcm9uQGh1
YXdlaS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsaXJlemEgU2FuYWVlPGFsaXJlemEuc2FuYWVl
QGh1YXdlaS5jb20+DQo+IC0tLQ0KPiBUaGFua3MgR3JlZ29yeSBmb3IgdGhlIHJldmlldyBhbmQg
ZmVlZGJhY2sgb24gdGhlIHByZXZpb3VzIHZlcnNpb25zLg0KPiANCj4gQ2hhbmdlIGxvZzoNCj4g
djUtdjY6IFVzZSBvYmplY3RfdW5wYXJlbnQoKSBpbiB0aGUgdGhpcmQgY29tbWl0IHdoZW4gZGVs
ZXRpbmcgYWxpYXMgcmVnaW9ucy4NCj4gDQo+ICAgaHcvY3hsL2N4bC1jb21wb25lbnQtdXRpbHMu
YyB8ICAgNiArKw0KPiAgIGh3L2N4bC9jeGwtaG9zdC5jICAgICAgICAgICAgfCAxOTAgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBody9tZW0vY3hsX3R5cGUzLmMgICAg
ICAgICAgIHwgICA0ICsNCj4gICBpbmNsdWRlL2h3L2N4bC9jeGwuaCAgICAgICAgIHwgICAxICsN
Cj4gICBpbmNsdWRlL2h3L2N4bC9jeGxfZGV2aWNlLmggIHwgICA0ICsNCj4gICA1IGZpbGVzIGNo
YW5nZWQsIDIwNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvY3hsL2N4bC1j
b21wb25lbnQtdXRpbHMuYyBiL2h3L2N4bC9jeGwtY29tcG9uZW50LXV0aWxzLmMNCj4gaW5kZXgg
MDdhYWJlMzMxYy4uYTYyNDM1Nzk3OCAxMDA2NDQNCj4gLS0tIGEvaHcvY3hsL2N4bC1jb21wb25l
bnQtdXRpbHMuYw0KPiArKysgYi9ody9jeGwvY3hsLWNvbXBvbmVudC11dGlscy5jDQo+IEBAIC0x
NDMsNiArMTQzLDEyIEBAIHN0YXRpYyB2b2lkIGR1bWJfaGRtX2hhbmRsZXIoQ1hMQ29tcG9uZW50
U3RhdGUgKmN4bF9jc3RhdGUsIGh3YWRkciBvZmZzZXQsDQo+ICAgICAgICAgICB2YWx1ZSA9IEZJ
RUxEX0RQMzIodmFsdWUsIENYTF9IRE1fREVDT0RFUjBfQ1RSTCwgQ09NTUlUVEVELCAwKTsNCj4g
ICAgICAgfQ0KPiAgICAgICBzdGxfbGVfcCgodWludDhfdCAqKWNhY2hlX21lbSArIG9mZnNldCwg
dmFsdWUpOw0KPiArDQo+ICsgICAgaWYgKHNob3VsZF9jb21taXQpIHsNCj4gKyAgICAgICAgY2Zt
d3NfdXBkYXRlX25vbl9pbnRlcmxlYXZlZCh0cnVlKTsNCj4gKyAgICB9IGVsc2UgaWYgKHNob3Vs
ZF91bmNvbW1pdCkgew0KPiArICAgICAgICBjZm13c191cGRhdGVfbm9uX2ludGVybGVhdmVkKGZh
bHNlKTsNCj4gKyAgICB9DQo+ICAgfQ0KDQpbLi5zbmlwLi4uXQ0KDQoNCj4gKw0KPiArYm9vbCBj
Zm13c191cGRhdGVfbm9uX2ludGVybGVhdmVkKGJvb2wgY29tbWl0KQ0KPiArew0KPiArICAgIC8q
DQo+ICsgICAgICogV2FsayBlbmRwb2ludHMgdG8gZmluZCBib3RoIGNvbW1pdHRlZCBhbmQgdW5j
b21taXR0ZWQgZGVjb2RlcnMsDQo+ICsgICAgICogdGhlbiBjaGVjayBpZiB0aGV5IGFyZSBub3Qg
aW50ZXJsZWF2ZWQgKGJ1dCB0aGUgcGF0aCBpcyBmdWxseSBzZXQgdXApLg0KPiArICAgICAqLw0K
PiArICAgIG9iamVjdF9jaGlsZF9mb3JlYWNoX3JlY3Vyc2l2ZShvYmplY3RfZ2V0X3Jvb3QoKSwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdXBkYXRlX25vbl9pbnRlcmxl
YXZlZCwgJmNvbW1pdCk7DQo+ICsNCj4gKyAgICByZXR1cm4gZmFsc2U7DQoNCg0KU2luY2UgdGhp
cyBmdW5jdGlvbiBhbHdheXMgcmV0dXJucyBmYWxzZSBhbmQgaXRzIHJldHVybiB2YWx1ZSBpcyBu
ZXZlciB1c2VkLCBpdCBjYW4gYmUgZGVmaW5lZCBhcyB2b2lkLg0KV2l0aCB0aGF0IG1pbm9yIGNo
YW5nZSwgdGhlIHBhdGNoIGxvb2tzIGdvb2QgdG8gbWUuDQogIA0KUmV2aWV3ZWQtYnk6IExpIFpo
aWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQoNCj4gK30NCj4gKw0K

