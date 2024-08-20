Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193D5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 04:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgG1Y-0006bC-3i; Mon, 19 Aug 2024 23:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sgG1Q-0006Xp-Ti; Mon, 19 Aug 2024 23:59:05 -0400
Received: from mail-eastasiaazlp170100000.outbound.protection.outlook.com
 ([2a01:111:f403:c400::] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alvinga@andestech.com>)
 id 1sgG1O-0006bn-FX; Mon, 19 Aug 2024 23:59:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1PCzp8stfx84aYsB7vCoDDBGAXjZBkguAXYbmthmHoj65yCoSK2uzuCwYapKhYepMy4n9+J3Gvl1fpwLzRID9raRnyuQ5hn3WSBfzwzags+vbrNo/ARkvty/khFF/zuyEax025eQcBxd2cwPsW/1W5hwIHAruQ1g8rd4XBpaV2bvIrnt1FBL8RKxocfJPLH49aGAqIxAtxOYHNBXww+FTxDW06P2ywJGnCLiDawZP8sDB/lE6UP3UPBB3ZwaeDO1SO+G9nKlv0iuFJ0S8ynFmPmw/7VJVM1A5q2Fku/cGtlwWhYLaroTfNasb13+PTBARQpi9mBZuLCPZytrEePoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBK1jzPzko5LMXinzgdlUnv5d3g5HqUu3Rw++xrocHU=;
 b=basCwg1HyAYdXnFHtUVfZa6vU7PvYdB8Oj+lDMFQUSG5VwF3hPs8rIXkFJd95esrirnJk5CcNg9tEtNlwEq78Th7nqJJavSgBotXj6EEfZVPLhOkNOGUGSO8gjUhdX0SAOKy/BFRzWUcJ0phdeugjqkYnM3BsQwWrQJ/nQScgVvebQtD2UWad/bY0kc2dWFLRTalA9bd5FyHXJv0XHJw+1B2h4AnobI/ALoXiP0rMqIP/AbKyPnGiV7Ltqr6Lyrvs8QmcxL4Bo/aeD7U+/RdIXLKfnNHEXcQAkey3BG/xugTg9KoeSyFUBpuXCG0aOkFFoUS7q2NIL33IyPHFtHf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=andestech.com; dmarc=pass action=none
 header.from=andestech.com; dkim=pass header.d=andestech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=andestech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBK1jzPzko5LMXinzgdlUnv5d3g5HqUu3Rw++xrocHU=;
 b=HTBSE8HEXsAWEM1/fFhIbjBVrdkhqMl9Y3QjsiG8ii8mE9uH/dKRnKCzu/BrdcqJRR24Mp5IVRU/1orsGQUiSCjmbxC+UtEfl+r71V5RaQET/vjv4EUgJKxoXGcKx3sAWo3P/LQv/hhBCBUWL4lzzgb7urDCm+0odytrbf1SqHUY0F/7afunQSc+RpMQ2qX/gsKgNHvXLsMiEwNdVGJC0mwdlE1gPRcCBs/XacO5ZC57ngXmlGR6+D2fFro9XLM8XZ6pt912/nOOmi9muaACLNsI2aQzyUZYr1p/Cp7JP2EAhNVYB5RRzcJh1+rxE3zCOzAOzLDNlcBcsTdxKIlofQ==
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com (2603:1096:101:69::14)
 by SEYPR03MB7966.apcprd03.prod.outlook.com (2603:1096:101:175::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 03:58:48 +0000
Received: from SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e]) by SEYPR03MB6700.apcprd03.prod.outlook.com
 ([fe80::292f:e1ce:7df8:115e%4]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 03:58:47 +0000
From: =?big5?B?QWx2aW4gQ2hlLUNoaWEgQ2hhbmcosWmt9bnFKQ==?=
 <alvinga@andestech.com>
To: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "bin.meng@windriver.com" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: RE: [PATCH v3 2/2] target/riscv: Add textra matching condition for
 the triggers
Thread-Topic: [PATCH v3 2/2] target/riscv: Add textra matching condition for
 the triggers
Thread-Index: AQHa2z8alulrSc8qyk+rtdBJu4fnVbIvsgWw
Date: Tue, 20 Aug 2024 03:58:47 +0000
Message-ID: <SEYPR03MB67002DA61D8E15CD006817B1A88D2@SEYPR03MB6700.apcprd03.prod.outlook.com>
References: <20240721072422.1377506-1-alvinga@andestech.com>
 <20240721072422.1377506-3-alvinga@andestech.com>
In-Reply-To: <20240721072422.1377506-3-alvinga@andestech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=andestech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6700:EE_|SEYPR03MB7966:EE_
x-ms-office365-filtering-correlation-id: 50dab2a3-4442-4485-4055-08dcc0cc64d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?big5?B?b1E5d0dBd3lIVWJDQTlLa3VwU0ZubUhoL1MwclVFQ2xpeTQzVVp1NGx3cVlET0Jp?=
 =?big5?B?WFpDTU1ERHNHVm54KzBLQ0tZcjZIMkppTUR5amx2ellTMmJFalJMZDB3RTRBSVRn?=
 =?big5?B?c2dLVTR2d1paR2xzM1NqS21VOGFtdFBPMjY2MXVYTEtpS3ZUak8vY0VnUStTRG9m?=
 =?big5?B?WVhVbFVhcmRvUWpNRmxFLzV2YUpmN2FvYzhUWXV1V1EzT3dmNU9yTGpEZkRSTVc3?=
 =?big5?B?azVDNmpFRmlnci93WnQ2Yy9LRHU3cXlWNi8rQzQ1QTZwbEdwUnpJMFBFdWV1TytE?=
 =?big5?B?c0NEYitSQnBuUG5DSjQrSlUzc2J6NEczWEVzM1RPNFJjQ0wxRzR0VnljR2R0Z3BC?=
 =?big5?B?aC9YeG1WditTa2NQbCtua3pMNGNmQzJNeTB0K05FWUFDK0kxSmIxQ2FvWURkandO?=
 =?big5?B?SEtvZm0ralgwVlF6Qml6eGJ5Q0QwU0dTcG11WXpaV0ZJdnN2QzZ2dGxLdHc4d3VF?=
 =?big5?B?amNpMVV4S0FpN1NVTG0rWUtMTEc5WVVNMEw3WGNDRmZLTkthVVpaY0RZQWFodEFK?=
 =?big5?B?cUx1SGl6cjVySFZWTFJxZ0phUlNPZVpPNi9JWUZTTW1rbzdTUDVKNGhBTDdCK0M1?=
 =?big5?B?aHRRb1JRMWprVjNKVlJ6bitka1dybkFVczJxMDhobUFJWHNBakhKeVdEbnFZdW1D?=
 =?big5?B?cVNxd3huWUZNQmNZY2hWdUhMZWNJaFR3ckhGTGo4aTBNeWxNd1FmQkZXYndmY2pB?=
 =?big5?B?VkZteEtsd3ZCTUVmOVk5VTBpREp2MXo1c3YvNXVvZTBBSnJ1bmNhK0VyYWNUbzIr?=
 =?big5?B?YUI3RVZhZ0Y2bmlBOFZaNXp1Zk1ld2JtTS9CSENWaGx3TldJblNTRDRONHpKTVFN?=
 =?big5?B?MExiVGdsbzFCa2J4cFB5SXFBKy9aQVBURTdBU0JaRHpLaDJCVUJoSWRiRkRydWtw?=
 =?big5?B?aDdNanJuUHhuclk5d29qU1ZybXVyT21IbUJkMzdMRGtzM0NoYVJlYXlXY3pkTVA2?=
 =?big5?B?eWV5K3cwemVVZ0JObG5MWlFkOGp2RFdBZWowUG50RTNUeFB3R2RIVW4veHplMlB5?=
 =?big5?B?czR6SDlxdE5HUm5Qc21QWVhMblpiL1JGQytmWFRaUHRxNXdMaTkyUXVPZCtwNlE3?=
 =?big5?B?UG5BL2pvYVVOZ21GVWN2a01aemtlbXRoSGcvR3BFT2FRSmpIczVvL2dPazY1Z0po?=
 =?big5?B?MnZZYnpJMVJTRWcyR2NEWTBiZXRiZmFOSVdqa0xLSlNqaGhWMkt1SHFKdENBK0FV?=
 =?big5?B?V3lZelcwS2FNS0hvZ0UvWnR2Ry95WDFTSnRxVHoxcG1Vc21uL04xNmc2bHhtYi8w?=
 =?big5?B?L0dsd3M1Y0VkOUdEVkNCcURxRHNnTTlLK05QSGFMZjVoK0pRanNwOUtzd0l0RVEx?=
 =?big5?B?ZnRNQkVxSDgrUFZQMzVMQVV4Tmt4NkJhZXAvMGxXVjhPMmVpYjlvdlozNFloL1Vx?=
 =?big5?B?a0RwdkE4YVV1VC85MWUxckpKdldCY1lXdUYyMmhoSnowT0ZuNWdidnRRaEc3MFRw?=
 =?big5?B?eE9vUGM3QlJtaVdtYkwvemJNSVZIejFFSGRXc25pQno2R1NrS1EwUFhBaERydkFX?=
 =?big5?B?dlYwMW1sejl6ZGxwOVBiMzhwYjdPUEFPZmJNYTQ1Q0lHbGJISDRLbEd3dndsOEpu?=
 =?big5?B?OW5OdmkvYjIxVnF6RTlaM2Rlb0xLRnFXVTlQVlVsMW9Fem1BS3pDdng2UXYwaFRY?=
 =?big5?B?M0NWeTFCV3d5YmtTRlRtZ3R2Y1hjcmlReitITmVsUlNLZmxVOUtKSWxCVkJROGQw?=
 =?big5?B?QTVpdVpnTTBIbVNsUVRpRjZEMk5ZdlVRTm9FMGRFV2Y0ODRmb1lqNmh4cUlreFF1?=
 =?big5?B?cURrYkQvSmk1RDdrMlhqQ2RLMWJNWXd0Z3hvYXpXSG9WMnhmUWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SEYPR03MB6700.apcprd03.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?RHQ5dklGUndQNWRwMXIvV1VIUDdRM2drSGVIOXJDM2JmZGo1aE1kUzd1QVRuWksv?=
 =?big5?B?YzhpRStDeXA0SFlYRUdaTG1HMFVEWmJ1WHVOT0VwWXZHMjVrZzZnL0FOL0JxbG9h?=
 =?big5?B?RXkxTldrOTVERmVjdUYzMEEybk93YVlKWUMwRHYxUllBeWtoOS9qdTliaTBlL0ts?=
 =?big5?B?RGJyRzFlTGthS2tpa1N2QVZrcTdKSVIzVk9SUGRvSnc3MDBjeE8xMkNOK0Z0bHcv?=
 =?big5?B?M1duTEZ0b1NWQVgrTGFqU0Exdk9OV2pkV0hJZDJ6NjVjN05WT3VNQ2tXbWxYOVdy?=
 =?big5?B?a0xFaTBTeU9MaDFoU1o3UEVqSEJyV0RocThLMUFScUhuV0NxVlRuNDRPMWNVeXdp?=
 =?big5?B?NmQrNi81dGxUdUlOMkJiU3JhQkdSRWczMi9wa1pjWGRQZ0h4L0dJVEVFcjN2TEFr?=
 =?big5?B?U0M2SmxYSC9ZK2JGTkJxYnU4eGRMV0tNSXZ3aHh3TnZBdzJCN1BsemJxd2o2NUlC?=
 =?big5?B?OXVYYlpEQUFmaUtVbUxJS1dXYVdJQ3FMNGhSdmQrM2VUTm9qUW14OXBUaTJGbWxN?=
 =?big5?B?MGpuMmI0dURPMS9PZlhLMnNHMzZldmtJVlNYRzZIalFmQ0V3bFVRTXBiWkFwZDIr?=
 =?big5?B?YmpCMjIzQjJyZlVrcFJTTllqcHA3Y3NNaEcwcm1lZ2tqbGljVVdZR21VSlRteTFL?=
 =?big5?B?TkZHY1VlMmVOZElMQ1JJRUh4YzdhcmwxYTVNMEVQaFlic2cwMHB1QzlzQVBmYkVV?=
 =?big5?B?S1UwNzV4Rkpicy9VNXB0UlgxblJRL3kvK3F6bFdsM2ZHak9tUktMWnd5cmV3aldB?=
 =?big5?B?ek9UMVpNNHl6TlBtYVRIWTc5c1NpYzEwKzROdmZUYXFLdW8zVDBnZjRsSWhkaG1w?=
 =?big5?B?cDlqNDZkRkVkTk9EY3hmd3lzZ0IyLzZlelcxYktGZTdIZFhCNVFxR3J2UFptMXJu?=
 =?big5?B?WHBHY3FTdmpmamlhWStKdHovYm82aEErbWJqR0dab1pSOEZyYitKV2Z3VTNoSnpQ?=
 =?big5?B?d0lpdkdHUHpTOEduTjZuL09xay81RHdhWWVjbE5iTmdtdFN1UkRIWFBMdTRHcjk4?=
 =?big5?B?VHBhWURBZW1Wb05TMXFwS2NMbjdWK0pqemZyb1FYaXBWMzRIVWlld0NnUGhKaDhw?=
 =?big5?B?S0RSNkh2V3pEejQyUnNpSjVBbnZpVzJucCt2eWdLMFI3UU1GRTdtay9xZkNKVXl0?=
 =?big5?B?NnJ0dzE0ZnZzMmk4YXNRcUw2N2FGOWR3SXFYQ1l5cHJWZWRHN0M4VXhZa1lYVnhB?=
 =?big5?B?UFFiMjNSVkF4QWZQY2l0cHVUdU1pTU1VSDRxa1NoS2hmeDBHeXZxZkpNRGVVWGdh?=
 =?big5?B?UGlZcFpzVS9RZXA1T2t3NytQUmk1eW85UGJOU052dG5qWS9KOEhxSnZOa2RNV3Z5?=
 =?big5?B?R1dsUThTa2tMRUswSWhPYjVtN1JUdWY2eGRFVngrN1UrUVlDTEpOMnJUTXZJd3hR?=
 =?big5?B?aDZ1RmM3RGY4Tml2OGZCMlZzTWJPVnkrVk43MHc3MlZBL1FvWjR0c3Q5UFhnbDJE?=
 =?big5?B?T29jNU1LbXJpSEVibVZhcWxTYTl4Y1VocUhWK1hOSGdHOG1SekxwZXAwenkzNVpH?=
 =?big5?B?SDl0dmxpVHNOK01nNXEvT2dMUGNEUGtYcW5ZcTYxdzlEZitwcGRkaW1qT0cxK2wv?=
 =?big5?B?REtTSDVtU1Y0UjV0ZXd1Zkt6Y1psNDhWNVhyY3lwZTBadmY2RnNsbXp0TllxdXFU?=
 =?big5?B?aDUyMkYweWxjOE85TWR2WTZFL2tVYkxPek4wS25rMlNRK3Bqb3Q5blF6R0l1WnZW?=
 =?big5?B?c3R5dS9tcGZxeTRCaExMTkFwSlhpbHZZaXNtMGVTdGdVUGRpZExVSXI3WmZUdDBD?=
 =?big5?B?QjB3K2x4QlpCYmxtaFgyazlBNklFNXdrZ0FZd2hBeGJWTmsvcW1WNzBUTHVqN25x?=
 =?big5?B?bjVEUlpxUkhqcm5KczVNTDBob0paTjF2SmhCdmt0cHpKaWpXSUJRTTBWcTR0N2du?=
 =?big5?B?TUk0bUlMVWpEYmlNRXFjdkhaTUVYRXJqejV3L0ZOR1I2TEs1ckFRV0ZXbEM2enZ0?=
 =?big5?B?Wjd0bUwvSU1zV0FPSkpxMkQwdi9pTzY1Z3JiaUVzQ2FiRjgwVFFrSzVrbVhENlM3?=
 =?big5?Q?hsUMTGOS7/ntTS4y?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: andestech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6700.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dab2a3-4442-4485-4055-08dcc0cc64d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 03:58:47.7282 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e3ec21b7-ec6c-4041-9add-61aea8171458
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hMKmpA/KLXQ3dNnBQbr4Dxs51cK/pZVtzBDRWkfb9EyeurrEEXWHnBjjaFT1V5F+5zgXExxWEb6D95OVqrsFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7966
Received-SPF: pass client-ip=2a01:111:f403:c400::;
 envelope-from=alvinga@andestech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: 35
X-Spam_score: 3.5
X-Spam_bar: +++
X-Spam_report: (3.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MIME_CHARSET_FARAWAY=2.45, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

SGkgQWxpc3RhaXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWx2
aW4gQ2hlLUNoaWEgQ2hhbmcosWmt9bnFKSA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBTZW50
OiBTdW5kYXksIEp1bHkgMjEsIDIwMjQgMzoyNCBQTQ0KPiBUbzogcWVtdS1yaXNjdkBub25nbnUu
b3JnOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNv
bTsgYmluLm1lbmdAd2luZHJpdmVyLmNvbTsNCj4gbGl3ZWkxNTE4QGdtYWlsLmNvbTsgZGJhcmJv
emFAdmVudGFuYW1pY3JvLmNvbTsNCj4gemhpd2VpX2xpdUBsaW51eC5hbGliYWJhLmNvbTsgQWx2
aW4gQ2hlLUNoaWEgQ2hhbmcosWmt9bnFKQ0KPiA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjMgMi8yXSB0YXJnZXQvcmlzY3Y6IEFkZCB0ZXh0cmEgbWF0Y2hpbmcg
Y29uZGl0aW9uIGZvciB0aGUNCj4gdHJpZ2dlcnMNCj4NCj4gQWNjb3JkaW5nIHRvIFJJU0MtViBE
ZWJ1ZyBzcGVjaWZpY2F0aW9uLCB0aGUgb3B0aW9uYWwgdGV4dHJhMzIgYW5kDQo+IHRleHRyYTY0
IHRyaWdnZXIgQ1NScyBjYW4gYmUgdXNlZCB0byBjb25maWd1cmUgYWRkaXRpb25hbCBtYXRjaGlu
ZyBjb25kaXRpb25zDQo+IGZvciB0aGUgdHJpZ2dlcnMuIEZvciBleGFtcGxlLCBpZiB0aGUgdGV4
dHJhLk1IU0VMRUNUIGZpZWxkIGlzIHNldCB0byA0DQo+IChtY29udGV4dCksIHRoaXMgdHJpZ2dl
ciB3aWxsIG9ubHkgbWF0Y2ggb3IgZmlyZSBpZiB0aGUgbG93IGJpdHMgb2YNCj4gbWNvbnRleHQv
aGNvbnRleHQgZXF1YWwgdGV4dHJhLk1IVkFMVUUgZmllbGQuDQo+DQo+IFRoaXMgY29tbWl0IGFk
ZHMgdGhlIGFmb3JlbWVudGlvbmVkIG1hdGNoaW5nIGNvbmRpdGlvbiBhcyBjb21tb24gdHJpZ2dl
cg0KPiBtYXRjaGluZyBjb25kaXRpb25zLiBDdXJyZW50bHksIHRoZSBvbmx5IGxlZ2FsIHZhbHVl
cyBvZiB0ZXh0cmEuTUhTRUxFQ1QgYXJlIDANCj4gKGlnbm9yZSkgYW5kIDQgKG1jb250ZXh0KS4g
V2hlbiB0ZXh0cmEuTUhTRUxFQ1QgaXMgMCwgd2UgcGFzcyB0aGUgY2hlY2tpbmcuDQo+IFdoZW4g
dGV4dHJhLk1IU0VMRUNUIGlzIDQsIHdlIGNvbXBhcmUgdGV4dHJhLk1IVkFMVUUgd2l0aCBtY29u
dGV4dCBDU1IuDQo+IFRoZSByZW1haW5pbmcgZmllbGRzLCBzdWNoIGFzIHRleHRyYS5TQllURU1B
U0ssIHRleHRyYS5TVkFMVUUsIGFuZA0KPiB0ZXh0cmEuU1NFTEVDVCwgYXJlIGhhcmR3aXJlZCB0
byB6ZXJvIGZvciBub3cuIFRodXMsIHdlIHNraXAgY2hlY2tpbmcgdGhlbQ0KPiBoZXJlLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBBbHZpbiBDaGFuZyA8YWx2aW5nYUBhbmRlc3RlY2guY29tPg0KPiBS
ZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0K
PiAtLS0NCj4gIHRhcmdldC9yaXNjdi9kZWJ1Zy5jIHwgNjMNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gIHRhcmdldC9yaXNjdi9kZWJ1Zy5oIHwgIDMg
KysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDY1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4NCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9kZWJ1Zy5jIGIvdGFyZ2V0L3Jpc2N2L2Rl
YnVnLmMgaW5kZXgNCj4gZDZiNGEwNjE0NC4uNjJiYjc1ODg2MCAxMDA2NDQNCj4gLS0tIGEvdGFy
Z2V0L3Jpc2N2L2RlYnVnLmMNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2RlYnVnLmMNCj4gQEAgLTM2
NCwxMSArMzY0LDcyIEBAIHN0YXRpYyBib29sIHRyaWdnZXJfcHJpdl9tYXRjaChDUFVSSVNDVlN0
YXRlICplbnYsDQo+IHRyaWdnZXJfdHlwZV90IHR5cGUsDQo+ICAgICAgcmV0dXJuIGZhbHNlOw0K
PiAgfQ0KPg0KPiArc3RhdGljIGJvb2wgdHJpZ2dlcl90ZXh0cmFfbWF0Y2goQ1BVUklTQ1ZTdGF0
ZSAqZW52LCB0cmlnZ2VyX3R5cGVfdCB0eXBlLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgaW50IHRyaWdnZXJfaW5kZXgpIHsNCj4gKyAgICB0YXJnZXRfdWxvbmcgdGV4dHJh
ID0gZW52LT50ZGF0YTNbdHJpZ2dlcl9pbmRleF07DQo+ICsgICAgdGFyZ2V0X3Vsb25nIG1odmFs
dWUsIG1oc2VsZWN0Ow0KPiArDQo+ICsgICAgaWYgKHR5cGUgPCBUUklHR0VSX1RZUEVfQURfTUFU
Q0ggfHwgdHlwZSA+DQo+IFRSSUdHRVJfVFlQRV9BRF9NQVRDSDYpIHsNCj4gKyAgICAgICAgLyog
dGV4dHJhIGNoZWNraW5nIGlzIG9ubHkgYXBwbGljYWJsZSB3aGVuIHR5cGUgaXMgMiwgMywgNCwg
NSwgb3IgNiAqLw0KPiArICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gKyAgICB9DQo+ICsNCj4gKyAg
ICBzd2l0Y2ggKHJpc2N2X2NwdV9teGwoZW52KSkgew0KPiArICAgIGNhc2UgTVhMX1JWMzI6DQo+
ICsgICAgICAgIG1odmFsdWUgID0gZ2V0X2ZpZWxkKHRleHRyYSwgVEVYVFJBMzJfTUhWQUxVRSk7
DQo+ICsgICAgICAgIG1oc2VsZWN0ID0gZ2V0X2ZpZWxkKHRleHRyYSwgVEVYVFJBMzJfTUhTRUxF
Q1QpOw0KPiArICAgICAgICBicmVhazsNCj4gKyAgICBjYXNlIE1YTF9SVjY0Og0KPiArICAgIGNh
c2UgTVhMX1JWMTI4Og0KPiArICAgICAgICBtaHZhbHVlICA9IGdldF9maWVsZCh0ZXh0cmEsIFRF
WFRSQTY0X01IVkFMVUUpOw0KPiArICAgICAgICBtaHNlbGVjdCA9IGdldF9maWVsZCh0ZXh0cmEs
IFRFWFRSQTY0X01IU0VMRUNUKTsNCj4gKyAgICAgICAgYnJlYWs7DQo+ICsgICAgZGVmYXVsdDoN
Cj4gKyAgICAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsNCj4gKyAgICB9DQo+ICsNCj4gKyAg
ICAvKiBDaGVjayBtaHZhbHVlIGFuZCBtaHNlbGVjdC4gKi8NCj4gKyAgICBzd2l0Y2ggKG1oc2Vs
ZWN0KSB7DQo+ICsgICAgY2FzZSBNSFNFTEVDVF9JR05PUkU6DQo+ICsgICAgICAgIGJyZWFrOw0K
PiArICAgIGNhc2UgTUhTRUxFQ1RfTUNPTlRFWFQ6DQo+ICsgICAgICAgIC8qIE1hdGNoIG9yIGZp
cmUgaWYgdGhlIGxvdyBiaXRzIG9mIG1jb250ZXh0L2hjb250ZXh0IGVxdWFsIG1odmFsdWUuDQo+
ICovDQo+ICsgICAgICAgIGlmIChyaXNjdl9oYXNfZXh0KGVudiwgUlZIKSkgew0KPiArICAgICAg
ICAgICAgaWYgKG1odmFsdWUgIT0gZW52LT5tY29udGV4dCkgew0KPiArICAgICAgICAgICAgICAg
IHJldHVybiBmYWxzZTsNCj4gKyAgICAgICAgICAgIH0NCj4gKyAgICAgICAgfSBlbHNlIHsNCj4g
KyAgICAgICAgICAgIHN3aXRjaCAocmlzY3ZfY3B1X214bChlbnYpKSB7DQo+ICsgICAgICAgICAg
ICBjYXNlIE1YTF9SVjMyOg0KPiArICAgICAgICAgICAgICAgIGlmIChtaHZhbHVlICE9IChlbnYt
Pm1jb250ZXh0ICYgTUNPTlRFWFQzMikpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IGZhbHNlOw0KPiArICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICBicmVhazsN
Cj4gKyAgICAgICAgICAgIGNhc2UgTVhMX1JWNjQ6DQo+ICsgICAgICAgICAgICBjYXNlIE1YTF9S
VjEyODoNCj4gKyAgICAgICAgICAgICAgICBpZiAobWh2YWx1ZSAhPSAoZW52LT5tY29udGV4dCAm
IE1DT05URVhUNjQpKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4g
KyAgICAgICAgICAgICAgICB9DQo+ICsgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAg
ICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7
DQo+ICsgICAgICAgICAgICB9DQo+ICsgICAgICAgIH0NCg0KSSBoYXZlIHNvbWUgbmV3IGlkZWFz
IG9uIHRoaXMgcGFydC4NClNob3VsZCB3ZSByZXBsYWNlIHRoaXMgd2hvbGUgaWYtZWxzZSB3aXRo
IGp1c3QgdGhlIGZvbGxvd2luZyBzaW1wbGUgY29kZSA/DQoNCiAgICBjYXNlIE1IU0VMRUNUX01D
T05URVhUOg0KICAgICAgICAvKiBNYXRjaCBpZiB0aGUgbG93IGJpdHMgb2YgbWNvbnRleHQvaGNv
bnRleHQgZXF1YWwgbWh2YWx1ZS4gKi8NCiAgICAgICAgaWYgKG1odmFsdWUgIT0gZW52LT5tY29u
dGV4dCkgew0KICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICAgICB9DQogICAgICAgIGJy
ZWFrOw0KDQpUaG9zZSBtYXNrcyBvbiBtY29udGV4dCBoYXZlIGJlZW4gYXBwbGllZCBpbiB3cml0
ZV9tY29udGV4dCgpLg0KSSB0aGluayB3ZSBjYW4gc2tpcCB0aGUgbWFza3MgaGVyZS4NCldoYXQg
ZG8geW91IHRoaW5rID8NCg0KDQpSZWdhcmRzLA0KQWx2aW4gQ2hhbmcNCg0KPiArICAgICAgICBi
cmVhazsNCj4gKyAgICBkZWZhdWx0Og0KPiArICAgICAgICBicmVhazsNCj4gKyAgICB9DQo+ICsN
Cj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gK30NCj4gKw0KPiAgLyogQ29tbW9uIG1hdGNoaW5nIGNv
bmRpdGlvbnMgZm9yIGFsbCB0eXBlcyBvZiB0aGUgdHJpZ2dlcnMuICovICBzdGF0aWMgYm9vbA0K
PiB0cmlnZ2VyX2NvbW1vbl9tYXRjaChDUFVSSVNDVlN0YXRlICplbnYsIHRyaWdnZXJfdHlwZV90
IHR5cGUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgdHJpZ2dlcl9p
bmRleCkgIHsNCj4gLSAgICByZXR1cm4gdHJpZ2dlcl9wcml2X21hdGNoKGVudiwgdHlwZSwgdHJp
Z2dlcl9pbmRleCk7DQo+ICsgICAgcmV0dXJuIHRyaWdnZXJfcHJpdl9tYXRjaChlbnYsIHR5cGUs
IHRyaWdnZXJfaW5kZXgpICYmDQo+ICsgICAgICAgICAgIHRyaWdnZXJfdGV4dHJhX21hdGNoKGVu
diwgdHlwZSwgdHJpZ2dlcl9pbmRleCk7DQo+ICB9DQo+DQo+ICAvKiB0eXBlIDIgdHJpZ2dlciAq
Lw0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Jpc2N2L2RlYnVnLmggYi90YXJnZXQvcmlzY3YvZGVi
dWcuaCBpbmRleA0KPiBjMzQ3ODYzNTc4Li5mNzZiOGY5NDRhIDEwMDY0NA0KPiAtLS0gYS90YXJn
ZXQvcmlzY3YvZGVidWcuaA0KPiArKysgYi90YXJnZXQvcmlzY3YvZGVidWcuaA0KPiBAQCAtMTMx
LDYgKzEzMSw5IEBAIGVudW0gew0KPiAgI2RlZmluZSBJVFJJR0dFUl9WVSAgICAgICAgICAgQklU
KDI1KQ0KPiAgI2RlZmluZSBJVFJJR0dFUl9WUyAgICAgICAgICAgQklUKDI2KQ0KPg0KPiArI2Rl
ZmluZSBNSFNFTEVDVF9JR05PUkUgICAgICAgMA0KPiArI2RlZmluZSBNSFNFTEVDVF9NQ09OVEVY
VCAgICAgNA0KPiArDQo+ICBib29sIHRkYXRhX2F2YWlsYWJsZShDUFVSSVNDVlN0YXRlICplbnYs
IGludCB0ZGF0YV9pbmRleCk7DQo+DQo+ICB0YXJnZXRfdWxvbmcgdHNlbGVjdF9jc3JfcmVhZChD
UFVSSVNDVlN0YXRlICplbnYpOw0KPiAtLQ0KPiAyLjM0LjENCg0KQ09ORklERU5USUFMSVRZIE5P
VElDRToNCg0KVGhpcyBlLW1haWwgKGFuZCBpdHMgYXR0YWNobWVudHMpIG1heSBjb250YWluIGNv
bmZpZGVudGlhbCBhbmQgbGVnYWxseSBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIG9yIGluZm9ybWF0
aW9uIHByb3RlY3RlZCBmcm9tIGRpc2Nsb3N1cmUuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRl
ZCByZWNpcGllbnQsIHlvdSBhcmUgaGVyZWJ5IG5vdGlmaWVkIHRoYXQgYW55IGRpc2Nsb3N1cmUs
IGNvcHlpbmcsIGRpc3RyaWJ1dGlvbiwgb3IgdXNlIG9mIHRoZSBpbmZvcm1hdGlvbiBjb250YWlu
ZWQgaGVyZWluIGlzIHN0cmljdGx5IHByb2hpYml0ZWQuIEluIHRoaXMgY2FzZSwgcGxlYXNlIGlt
bWVkaWF0ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHJldHVybiBlLW1haWwsIGRlbGV0ZSB0aGUg
bWVzc2FnZSAoYW5kIGFueSBhY2NvbXBhbnlpbmcgZG9jdW1lbnRzKSBhbmQgZGVzdHJveSBhbGwg
cHJpbnRlZCBoYXJkIGNvcGllcy4gVGhhbmsgeW91IGZvciB5b3VyIGNvb3BlcmF0aW9uLg0KDQpD
b3B5cmlnaHQgQU5ERVMgVEVDSE5PTE9HWSBDT1JQT1JBVElPTiAtIEFsbCBSaWdodHMgUmVzZXJ2
ZWQuDQo=

