Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF44EF0716
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 06:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpL9Z-00062n-JV; Mon, 09 Feb 2026 01:53:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpL9R-00062G-Vw; Mon, 09 Feb 2026 01:53:42 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpL9P-0005KI-1d; Mon, 09 Feb 2026 01:53:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEpRd5+2+5WE2+1qiZHFrEEpih+ShLPbPdUu3u1TdqcM9TmNJaNviCVoufrQbV1dC4TIb/S0xg2YqZHrLYmn9svi9yEmc7i97Ske/kSsq+YHmlL8jJ2p6F84pffXYQesLg2/pExKFBHjChbzHTQr0RKDo8ok0q1cqQRx2I0DEvlvX24DFMTSp2kS8V37SLDAkJfG4WPxBbWwdwAJDtm0pBn9zveloHSmI5Fb3W7QWhHEWDqM/RiQlY27ONW0W+IPa273YZVC8y5qIrOSjzEXUBPyotSzut0meU3Ck0Bg+2XgIPTroCo/w82+KbWBbiKX7y+24i6NG6ff2vzKoj5N4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dTDm+bpLdzsGVQTqHfDZv8G5AzlwzN19KO2AAHaStg=;
 b=d7c6GDuO7Fx5htN34oXnAZKr6DCrEr8Hxv5JV4p6pZkHrne26/9a/2hbb7rzdux3RwtQNOXAgFi+buZc3fy9u2lXpMdcTCb75V6aIa6p4sUnbzkVX/LJvT12+ftla6S4P0NOOSMvQg9+V/zaulxEdpFqqkfjJvJAS6Db+1NP+dnlv5BZ1C3aoc4lG+BYn9murc/N42HuxVyNEZ5yhPG5TOiTSzcG47we0A0ol8mh2TAKILWxSX2F90jHSSMPRuRP4NB5muE5ld5wurgl3Co43EUNaRCynNP2HkmG73UhNWl1gbUpUXOUBOUlw8ycXmSVfqlexRXoxTLvu/3nhArXDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dTDm+bpLdzsGVQTqHfDZv8G5AzlwzN19KO2AAHaStg=;
 b=PcfVBHE2vS2VnLwJ2bLAVKcLJwevNp2EmY8PJkUP1zExgUb4zLVXOOFeJ5deNuNntx6QqPuhOejRd9k7w7IFSpsld1l2W8rYJqTNRos0UH2cFg4iy9IX5OSDcZikHlovHPO9N0O3TT6l9kXCXx7ycLWGG6fESwqtN4yIe0Ad6EH9/wdt0IY9nDn8kJOu+XXJeQTtj0Ui1ZKPR1jx5ryrJPOUKt+VW2HmZn+kFrn2VwLqHEK296olXNX738NRfXDoFOJtT3zKqWYL+X0SRyENnQHG1chrp1xF0HCPwVzj4ZCABdw3yxHgDBZuXxrtsb+9+CR4TWlahnJgOSCwP0hKZQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5812.apcprd06.prod.outlook.com (2603:1096:101:ac::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 06:53:28 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 06:53:28 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: RE: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
Thread-Topic: [PATCH v1 02/10] hw/i2c/aspeed_i2c: Increase I2C device register
 size to 0xA0
Thread-Index: AQHclyopCTDjMhIGHUuNVV2chvQZwLV1abWAgAQ295CAAFIHAIAAAGYA
Date: Mon, 9 Feb 2026 06:53:27 +0000
Message-ID: <TYPPR06MB820621BFAC1540186D847023FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
References: <20260206053340.3716041-1-jamin_lin@aspeedtech.com>
 <20260206053340.3716041-4-jamin_lin@aspeedtech.com>
 <ba061380-7377-4814-b0ff-2a95743fcb8d@kaod.org>
 <TYPPR06MB8206CDA8BB8B49777541C144FC65A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <4800192a-05bf-40c8-8b76-8cb87ac384d1@kaod.org>
In-Reply-To: <4800192a-05bf-40c8-8b76-8cb87ac384d1@kaod.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5812:EE_
x-ms-office365-filtering-correlation-id: 584c0fd4-f5d8-48cd-5ad7-08de67a7edb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?dExBM2puTHNNbE9vaDJXeDdaZjRpMlpKU3RjN1ZBTnFFRXUrcldEZllodG43?=
 =?utf-8?B?KzM5eTgrcURaZHhYaU16UEgwQ1cvRktOVmJtSUx2Y3U2WUtxaFV5azArVWx3?=
 =?utf-8?B?STFiNy8yYXVsV2w1VExmSi9wbkZNTmtFZ205MXZkRUJsSEFVK1JZT1cvSUVT?=
 =?utf-8?B?MWZGVUpGUkFRNThNMnVmbjY4Q1BnWDlyY201MVdyZHF0aVZLRDhsV2FYcUR5?=
 =?utf-8?B?TFZOb0l1UEYyY250YWJKWnJiMUphUmRZbGdkeStnSDlOK0J3Y01JMTlQVzB3?=
 =?utf-8?B?SVY1am9zQm44aTFnSVRzYUhkc042R2VOWmdYcXlML29vanVmQnFsc1VTaEhH?=
 =?utf-8?B?cU5NRnpDZlFTT3psbUdzYVoxRVN4aUJ0Vk9jV0lGQVZKWURES2Zoa3hDVUF1?=
 =?utf-8?B?VjJzRHNJcTluQUJDeUMrV1F6M2s4elFEakZaY1A4YTk4TzliVk43Y2Z6dWNl?=
 =?utf-8?B?OGUvUy9TM2d5ekJYRExBRmJzNVhjc2hkNGdNL09nTU1WSlpCRTkrUm9mN2lD?=
 =?utf-8?B?SGlaY1EwMXZqTWIwTGx4dWxKTGttZm9keTB4Y21mdjgzNHdROEtER0UrYlBY?=
 =?utf-8?B?VEtZMDU0TkVtNHUvQzQ2TlFSZ2t3T0V2Z2lpSURJYUN0MEZEZkVGNHFkWmg0?=
 =?utf-8?B?cDEwMHNSdkhEcWdvRFRNa1RYT1VEVWlFM0NydmdZUFd1MUZkRzArbzFnbTd4?=
 =?utf-8?B?d3AvRFpuU2ZRSmszMDNMNTltMjV2UXJ0MEVYTHRVNnpuYURQNGVjbUE0YVRi?=
 =?utf-8?B?SHlpdUZBUjV1am45M2RCU1UwTGpNOXdqVGZ3RTNscVpZNXQ1dk9OZS95L1hI?=
 =?utf-8?B?WVhKQlQwb2pNRURuR04wSHowRnFXK1NMYys4K3ZSbkZjNmhtSDFTU0tvTG1U?=
 =?utf-8?B?S1hMbE14eThRcVE1eTQ4bFZGRUtRbERyWGFIbkd6TlkxUUV1c0hUMHUxZDdG?=
 =?utf-8?B?RTRYeDRHOEljR0dTRk9IbzBBMDZxZ1NlN21Qc1VpMmlaWGZjTGE2U2o1UjR3?=
 =?utf-8?B?NzFxMmxiZmszUjJVRlB4WFpwUWw4dElPRXgvSDRRUmhlVndwUjVZRWgvemZi?=
 =?utf-8?B?bEpmOUg5RlI0VUxTb1NqRzhmaytSMnB4ZmJmTU5oM3phU05jU201d1A5QU5q?=
 =?utf-8?B?TzdUZTQrV3B1ZmNZNmNqdW0vQkxyNDNId1haM2pGLzhhY0VvQTNOcnhlZDV1?=
 =?utf-8?B?NnZjWlJkUFdnVTFwMTd1QjRuN1ZJSHU1WFdWNGNFN3Z5WmZ5NStWVUdqdmRR?=
 =?utf-8?B?dExPQ1ExVmN3VFU1Yk9vVy92bkQ1UElmdjA5c01XZlI1VG1iL0IrMWc4SDl2?=
 =?utf-8?B?eit4NmVnNFVpUXc1c2dXNDUrM0JrcUpqR0ZRTGtiSytxUWhDcGV5cG1yZksv?=
 =?utf-8?B?SmFBZ1lhN1RpNSt4ZjBZQlFXSFFIZDExSStTTW9LR08vNFVaU2N2Sk00WS9R?=
 =?utf-8?B?cXdZb2hXVkFmTkl3OWZ5enRmT0EzQjdYUG9PVjZlcW5XcEhNR0ovK29SajFO?=
 =?utf-8?B?Q1VGSUpjcVBmNXpTc1FPdUwwQ2lGZ3c1S0NpVEtMMm9TbXVBKzkrR1ErdkxC?=
 =?utf-8?B?ckpLUmhTSDFRRjdJcjBFVlUrM3dwdkJnb1paekNoQXM0ZG5uMDJaRjN2RGZM?=
 =?utf-8?B?OHRtQmdNK2sxL2VkdFM3SmU4aitsNk5qdVkxSmRXVVhJOXZKQ3JrQnZGeXVm?=
 =?utf-8?B?QWdxb1pjVWI5Tk9vZjQwUXVDM3U3a01yV0ZNSCtCWklFeGNSK2l1ZEFHSFg4?=
 =?utf-8?B?aWFKSmw4dWVkeEVqWlErY20zSWIzQkV6eEwrQTNCeU0wZFlzdmxpK1pUSE9v?=
 =?utf-8?B?Mm9CRzM1S1pFWEJOZVFJOFRMQjVNVXoxZ01vQXdXai9abjZnNUlaaWNSUWRp?=
 =?utf-8?B?Vm9VNlQzeHhISlJOOVMvenkvQ25aNVFYR1U1UGswMHhwTUp3RnhERVdzdWpm?=
 =?utf-8?B?Ni9zd0pwNlVFNEZLUkFFb0FtK0lxMU90c2xpUTVhWURZdXpkU21IWEdJKzNx?=
 =?utf-8?B?ZE9Id283azJpV1pZQ3dyZzRLejVYUnorWmo1QVp3YUtNSmk4ZkkzUTlNRURz?=
 =?utf-8?B?L2xwTUFPa3FlQXVCOGNOQ2pwRXVhN3B2MnhPM1NNQW1uNGZySUNaNHdyVEc4?=
 =?utf-8?B?NDJXMTJWcytvYmFYTHBJbHFBRThxZGNQZU9hK0tiUmJUMUlCT3BlbS92U203?=
 =?utf-8?Q?cw1pJmpnuK5OMNd5oTfwHzEQgOhBQB6ZvY1O99CVEUzL?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjhrM0hJQ2tXc1QxR0wvRzFTYmFCaTFoUi95ZFJBZVZDQzlWVG5UbXpabFpk?=
 =?utf-8?B?QWNJN3pDVnFRNXV0RzlpQUMxMXREbURqM1orY1kxM2xrejJuVVlXTlZEYWdw?=
 =?utf-8?B?K05jNVp0U2NxeDRNR3lCbGpoTXppelkreEN2TFAwVEFEWEtuUS9id0pjUTZX?=
 =?utf-8?B?Y3ZVZE9QcExjWk9ObkkxTjlDWS9VSjNwSXdNVThaRXZEUVFLVm55dVRKeitZ?=
 =?utf-8?B?SlFVZ0lLYkM1WVFQSG9qL0Q4aVlOOEtGdTFVTHBsN1BWZ01NTU10eXZWQkdM?=
 =?utf-8?B?MVpGcjZWRXBPbnJnZkNqWFhTaXk0aVJPM0Z0ZEdrYm9CNFFRbTZYZ0dXUExz?=
 =?utf-8?B?NndSZkxiYk1PRjR6eDI5eVhKYnNrQnNEdDhWbW56YTNaZzNsOXI2S3dUZWlO?=
 =?utf-8?B?U3E3UTYxQ0RuUFpXMURXeGQzaDFCRzZ0aDdXNURYMGZMbmdOUGlieGtSeVhY?=
 =?utf-8?B?eUEzbGw1cXFKc1lVNXdURzUrcCtUS1NkTCtnaU5WSGplSjNsOUloRVV1UjBh?=
 =?utf-8?B?NVlDWEhwU2Ewc0NLeCs3bmErdjRxd3B2MGZSaFE3RHIzYzhubXFpbjUyeXBx?=
 =?utf-8?B?WTdFV3h3TmFRWk1ubVhWVmFSaVFUSUpCV3lMY1pnVGVtS1A1NlB1VTdkektm?=
 =?utf-8?B?U01YQ04xbVVVMklMdmwvWnNSbThqUko5MGFVUm8vb1JqeVJCMWxTVFJ2eGhj?=
 =?utf-8?B?bURrOVo0Y1J3OWs3cjhyOVlNaXJrb2Q0amx1Vk5qRFhpR0ExRm5UTmlRZHdG?=
 =?utf-8?B?cE5RdGU2Yzh3UDJYL1oyaDhOc1hrQ0drMm1oYXRUVEJmVWoxT01Yc3BlSENv?=
 =?utf-8?B?RVFnUXEvV2tYL21IdjlsODhOSlk5UmdQZnU5N08yYlVtMFdYK2t4bUZ6ck1M?=
 =?utf-8?B?czhkODEwWkhxeHNrSDVRTG5qQm1rZFhsRzdZOW50T1NFekxxaHBpK3BGeFE0?=
 =?utf-8?B?bTAwRTN3Q25SeWNXNDYraFdOdFZXc2FEblduVllaUHRENGtjNHI5UnVNR2xG?=
 =?utf-8?B?VDVWUVFVRjJxZWs2SHAyNG5PeUpDOXFhenhKZU9zNjA3NE9wR0VVbnRVeC8r?=
 =?utf-8?B?d2xTVFhGc012TjI0M1MrazgzclU2ZDh3WEZmN0NydDhVTmk5LzN0RTRyMEtH?=
 =?utf-8?B?ME9INTQ0TkxjVUdTeE5LQUxzYktmV1ZlcnR6aUxibzdtTGFlbkxlL0lDb1dB?=
 =?utf-8?B?QTQrUHdPRGRURUM5elBXK0xwZm56QUZSV0phOGVWN2Y0M3J4Z0ppdjRPcHZI?=
 =?utf-8?B?KzJxNjgrdDhkK1phekJoSHdLTmFPbVU3VStCSEtCOWUrSzg1ZG02N2N0WVZr?=
 =?utf-8?B?dXJvUUs4dUg3SVVuYStIcnEvbEM0UWlHd1ZTZWo0amYzMDZKbTRTQjZaNUhE?=
 =?utf-8?B?enJIcDRHc2hwb3l4WW1ic21qWXAxemRVUTI3K2JPVWQ5QWtQVTd3NFd1UG9u?=
 =?utf-8?B?SmtacDZTWTd2eDFOU2NFUElCNE45YXpieDVZS1lCM0dhZzEzay9YUitLemNB?=
 =?utf-8?B?MkxIc3d0c0xiUW11ZWd3VUtSNWRVM2F6WWV0a3l4NFRLVWxNdHhjdVdGUFRF?=
 =?utf-8?B?ZlI1MUx3L3FYU3QwK2ljQVlPcXNjQ1ZtNTE0OGtVeUo1RGE3ZWl5WVhFdXF4?=
 =?utf-8?B?bUQydXdqQUF2dXNCQU9qbXNVYUVWaWk0NEpZV0VBeXhKSkdzbEVKV1RacFk4?=
 =?utf-8?B?MlJIVUlDMWNuNXAyNlM0eUs2WFNnY3VCUWZsbVA1TllrczhyUWpYWnU3VmJm?=
 =?utf-8?B?Wnc4YjlaSFRsZUV3WUdGOFBOZVJTeWRDT3lQRkVOcnM0Q1JuN1V4MXhqcFBx?=
 =?utf-8?B?TTd4VCsvWFl3YTUwZVQ4bXpVc3A1dzhRZ0wvZ1NhZjBBejg5eHdRWGlrL3Uy?=
 =?utf-8?B?eS9hUktLclBIZDkrNjM4SnpFQXZBQlJyUUs2eGtLbDFLbCswWVdEelZZdkc4?=
 =?utf-8?B?MjdlR1lzVHJhZ3d5QmZDM3VPaHNqZXcrYjNLbTltWWZncW5HdElsTzVaOTVz?=
 =?utf-8?B?Y0tocURRMjVmOXE1MVV6eWwrVXdUWmFKRmFYRVNXV0EydllHUDZyaVMrd09W?=
 =?utf-8?B?K2liY0twZGd6eDBKaEFOM2hDOHpjZk1aU3ZkU29SU25sS0gvbVNLREFvWEw3?=
 =?utf-8?B?QzR1SkRwOUFnTkRZdFE1K0tqcitQNGxLUUMyOU5OeENHTlVlbGluYS9vV3U0?=
 =?utf-8?B?TDJTRmxiZ0NTY2JuNXVrKzJMZzdRZU9PMW1UR2dTNGJsOFJianEvWVUyM3k0?=
 =?utf-8?B?bVN2RS8vTkxwbXRKRExBRDdvZ1RqaDE3YVFsRm5qSkRFZlloRVlETis2M041?=
 =?utf-8?B?a05zc3UzWlhldUlEQUo3MGllZVdnZmFhdVB3OVNJY1EzY2tsbUdidz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584c0fd4-f5d8-48cd-5ad7-08de67a7edb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 06:53:27.7609 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6EB32BOY63y8tWIgTskrG1dO1zat9vpUr5EqrWbOQ5ZRWpeRxqT3Dd3FLG2ieQeptXEjotV93bQTHn5iXQo/p01V5xAjkmXnZmVcCHSkM/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5812
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=OS8PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

SGkgQ8OpZHJpYw0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDIvMTBdIGh3L2kyYy9hc3Bl
ZWRfaTJjOiBJbmNyZWFzZSBJMkMgZGV2aWNlIHJlZ2lzdGVyDQo+IHNpemUgdG8gMHhBMA0KPiAN
Cj4gSGVsbG8gSmFtaW4sDQo+IA0KPiBPbiAyLzkvMjYgMDM6MDIsIEphbWluIExpbiB3cm90ZToN
Cj4gPiBIaSBDw6lkcmljDQo+ID4NCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAwMi8xMF0g
aHcvaTJjL2FzcGVlZF9pMmM6IEluY3JlYXNlIEkyQyBkZXZpY2UNCj4gPj4gcmVnaXN0ZXIgc2l6
ZSB0byAweEEwDQo+ID4+DQo+ID4+IE9uIDIvNi8yNiAwNjozMywgSmFtaW4gTGluIHdyb3RlOg0K
PiA+Pj4gQWNjb3JkaW5nIHRvIHRoZSBBU1QyNzAwIEExIGRhdGFzaGVldCwgdGhlIHJlZ2lzdGVy
IHNwYWNlIGZvciBlYWNoDQo+ID4+PiBJMkMgZGV2aWNlIGluc3RhbmNlIGhhcyBiZWVuIGV4cGFu
ZGVkIGZyb20gMHg4MCBieXRlcyB0byAweEEwIGJ5dGVzLg0KPiA+Pg0KPiA+PiBXYXMgdGhhdCBj
aGFuZ2UgaW50cm9kdWNlZCB3aXRoIHRoZSBBMSA/IG9yIEEwID8NCj4gPj4NCj4gPg0KPiA+IFRo
ZSBjaGFuZ2Ugd2FzIGludHJvZHVjZWQgaW4gQTEuDQo+ID4gQm90aCBBMSBhbmQgQTIgdXNlIHRo
ZSBzYW1lIGRldmljZSByZWdpc3RlciBzaXplIG9mIDB4QTAuDQo+IA0KPiANCj4gV2Ugc2hvdWxk
IGFkZCBhIGZpeGVzIHRhZy4NCj4gDQpXaWxsIGFkZC4NCg0KVGhhbmtzLA0KSmFtaW4NCj4gVGhh
bmtzLA0KPiANCj4gQy4NCj4gDQo+IA0KPiA+IFRoYW5rcywNCj4gPiBKYW1pbg0KPiA+DQo+ID4+
IFRoYW5rcywNCj4gPj4NCj4gPj4gQy4NCj4gPj4NCj4gPj4NCj4gPj4+IFVwZGF0ZSB0aGUgQVNU
MjcwMCBJMkMgY29udHJvbGxlciBjb25maWd1cmF0aW9uIHRvIHJlZmxlY3QgdGhlIG5ldw0KPiA+
Pj4gcmVnaXN0ZXIgbGF5b3V0IGJ5IGluY3JlYXNpbmcgdGhlIHBlci1kZXZpY2UgcmVnaXN0ZXIg
c2l6ZSB0byAweEEwDQo+ID4+PiBhbmQgYWRqdXN0aW5nIHRoZSByZWdpc3RlciBnYXAgc2l6ZSBh
Y2NvcmRpbmdseS4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBKYW1pbiBMaW4gPGphbWlu
X2xpbkBhc3BlZWR0ZWNoLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgaHcvaTJjL2FzcGVlZF9p
MmMuYyB8IDM2ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiA+Pj4N
Cj4gPj4+IGRpZmYgLS1naXQgYS9ody9pMmMvYXNwZWVkX2kyYy5jIGIvaHcvaTJjL2FzcGVlZF9p
MmMuYyBpbmRleA0KPiA+Pj4gY2YzYTAwMzk3OC4uZTE2ODJjOWJkZCAxMDA2NDQNCj4gPj4+IC0t
LSBhL2h3L2kyYy9hc3BlZWRfaTJjLmMNCj4gPj4+ICsrKyBiL2h3L2kyYy9hc3BlZWRfaTJjLmMN
Cj4gPj4+IEBAIC0xMjA2LDM3ICsxMjA2LDM3IEBAIHN0YXRpYyB2b2lkIGFzcGVlZF9pMmNfaW5z
dGFuY2VfaW5pdChPYmplY3QNCj4gPj4gKm9iaikNCj4gPj4+ICAgICAqDQo+ID4+PiAgICAgKiBB
ZGRyZXNzIERlZmluaXRpb25zIChBU1QyNzAwKQ0KPiA+Pj4gICAgICogICAweDAwMCAuLi4gMHgw
RkY6IEdsb2JhbCBSZWdpc3Rlcg0KPiA+Pj4gLSAqICAgMHgxMDAgLi4uIDB4MTdGOiBEZXZpY2Ug
MA0KPiA+Pj4gKyAqICAgMHgxMDAgLi4uIDB4MTlGOiBEZXZpY2UgMA0KPiA+Pj4gICAgICogICAw
eDFBMCAuLi4gMHgxQkY6IERldmljZSAwIGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHgyMDAgLi4uIDB4
MjdGOiBEZXZpY2UgMQ0KPiA+Pj4gKyAqICAgMHgyMDAgLi4uIDB4MjlGOiBEZXZpY2UgMQ0KPiA+
Pj4gICAgICogICAweDJBMCAuLi4gMHgyQkY6IERldmljZSAxIGJ1ZmZlcg0KPiA+Pj4gLSAqICAg
MHgzMDAgLi4uIDB4MzdGOiBEZXZpY2UgMg0KPiA+Pj4gKyAqICAgMHgzMDAgLi4uIDB4MzlGOiBE
ZXZpY2UgMg0KPiA+Pj4gICAgICogICAweDNBMCAuLi4gMHgzQkY6IERldmljZSAyIGJ1ZmZlcg0K
PiA+Pj4gLSAqICAgMHg0MDAgLi4uIDB4NDdGOiBEZXZpY2UgMw0KPiA+Pj4gKyAqICAgMHg0MDAg
Li4uIDB4NDlGOiBEZXZpY2UgMw0KPiA+Pj4gICAgICogICAweDRBMCAuLi4gMHg0QkY6IERldmlj
ZSAzIGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHg1MDAgLi4uIDB4NTdGOiBEZXZpY2UgNA0KPiA+Pj4g
KyAqICAgMHg1MDAgLi4uIDB4NTlGOiBEZXZpY2UgNA0KPiA+Pj4gICAgICogICAweDVBMCAuLi4g
MHg1QkY6IERldmljZSA0IGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHg2MDAgLi4uIDB4NjdGOiBEZXZp
Y2UgNQ0KPiA+Pj4gKyAqICAgMHg2MDAgLi4uIDB4NjlGOiBEZXZpY2UgNQ0KPiA+Pj4gICAgICog
ICAweDZBMCAuLi4gMHg2QkY6IERldmljZSA1IGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHg3MDAgLi4u
IDB4NzdGOiBEZXZpY2UgNg0KPiA+Pj4gKyAqICAgMHg3MDAgLi4uIDB4NzlGOiBEZXZpY2UgNg0K
PiA+Pj4gICAgICogICAweDdBMCAuLi4gMHg3QkY6IERldmljZSA2IGJ1ZmZlcg0KPiA+Pj4gLSAq
ICAgMHg4MDAgLi4uIDB4ODdGOiBEZXZpY2UgNw0KPiA+Pj4gKyAqICAgMHg4MDAgLi4uIDB4ODlG
OiBEZXZpY2UgNw0KPiA+Pj4gICAgICogICAweDhBMCAuLi4gMHg4QkY6IERldmljZSA3IGJ1ZmZl
cg0KPiA+Pj4gLSAqICAgMHg5MDAgLi4uIDB4OTdGOiBEZXZpY2UgOA0KPiA+Pj4gKyAqICAgMHg5
MDAgLi4uIDB4OTlGOiBEZXZpY2UgOA0KPiA+Pj4gICAgICogICAweDlBMCAuLi4gMHg5QkY6IERl
dmljZSA4IGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHhBMDAgLi4uIDB4QTdGOiBEZXZpY2UgOQ0KPiA+
Pj4gKyAqICAgMHhBMDAgLi4uIDB4QTlGOiBEZXZpY2UgOQ0KPiA+Pj4gICAgICogICAweEFBMCAu
Li4gMHhBQkY6IERldmljZSA5IGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHhCMDAgLi4uIDB4QjdGOiBE
ZXZpY2UgMTANCj4gPj4+ICsgKiAgIDB4QjAwIC4uLiAweEI5RjogRGV2aWNlIDEwDQo+ID4+PiAg
ICAgKiAgIDB4QkEwIC4uLiAweEJCRjogRGV2aWNlIDEwIGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHhD
MDAgLi4uIDB4QzdGOiBEZXZpY2UgMTENCj4gPj4+ICsgKiAgIDB4QzAwIC4uLiAweEM5RjogRGV2
aWNlIDExDQo+ID4+PiAgICAgKiAgIDB4Q0EwIC4uLiAweENCRjogRGV2aWNlIDExIGJ1ZmZlcg0K
PiA+Pj4gLSAqICAgMHhEMDAgLi4uIDB4RDdGOiBEZXZpY2UgMTINCj4gPj4+ICsgKiAgIDB4RDAw
IC4uLiAweEQ5RjogRGV2aWNlIDEyDQo+ID4+PiAgICAgKiAgIDB4REEwIC4uLiAweERCRjogRGV2
aWNlIDEyIGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHhFMDAgLi4uIDB4RTdGOiBEZXZpY2UgMTMNCj4g
Pj4+ICsgKiAgIDB4RTAwIC4uLiAweEU5RjogRGV2aWNlIDEzDQo+ID4+PiAgICAgKiAgIDB4RUEw
IC4uLiAweEVCRjogRGV2aWNlIDEzIGJ1ZmZlcg0KPiA+Pj4gLSAqICAgMHhGMDAgLi4uIDB4RjdG
OiBEZXZpY2UgMTQNCj4gPj4+ICsgKiAgIDB4RjAwIC4uLiAweEY5RjogRGV2aWNlIDE0DQo+ID4+
PiAgICAgKiAgIDB4RkEwIC4uLiAweEZCRjogRGV2aWNlIDE0IGJ1ZmZlcg0KPiA+Pj4gLSAqICAg
MHgxMDAwIC4uLiAweDEwN0Y6IERldmljZSAxNQ0KPiA+Pj4gKyAqICAgMHgxMDAwIC4uLiAweDEw
OUY6IERldmljZSAxNQ0KPiA+Pj4gICAgICogICAweDEwQTAgLi4uIDB4MTBCRjogRGV2aWNlIDE1
IGJ1ZmZlcg0KPiA+Pj4gICAgICovDQo+ID4+PiAgICBzdGF0aWMgdm9pZCBhc3BlZWRfaTJjX3Jl
YWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKSBAQA0KPiA+Pj4gLTE2NzAsOCAr
MTY3MCw4IEBAIHN0YXRpYyB2b2lkDQo+ID4+PiBhc3BlZWRfMjcwMF9pMmNfY2xhc3NfaW5pdChP
YmplY3RDbGFzcw0KPiA+PiAqa2xhc3MsIGNvbnN0IHZvaWQgKmRhdGEpDQo+ID4+PiAgICAgICAg
ZGMtPmRlc2MgPSAiQVNQRUVEIDI3MDAgSTJDIENvbnRyb2xsZXIiOw0KPiA+Pj4NCj4gPj4+ICAg
ICAgICBhaWMtPm51bV9idXNzZXMgPSAxNjsNCj4gPj4+IC0gICAgYWljLT5yZWdfc2l6ZSA9IDB4
ODA7DQo+ID4+PiAtICAgIGFpYy0+cmVnX2dhcF9zaXplID0gMHg4MDsNCj4gPj4+ICsgICAgYWlj
LT5yZWdfc2l6ZSA9IDB4YTA7DQo+ID4+PiArICAgIGFpYy0+cmVnX2dhcF9zaXplID0gMHg2MDsN
Cj4gPj4+ICAgICAgICBhaWMtPmdhcCA9IC0xOyAvKiBubyBnYXAgKi8NCj4gPj4+ICAgICAgICBh
aWMtPmJ1c19nZXRfaXJxID0gYXNwZWVkXzI2MDBfaTJjX2J1c19nZXRfaXJxOw0KPiA+Pj4gICAg
ICAgIGFpYy0+cG9vbF9zaXplID0gMHgyMDsNCj4gPg0KDQo=

