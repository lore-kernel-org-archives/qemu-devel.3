Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98BFF55437
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 02:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv4OB-0003RW-1a; Tue, 24 Feb 2026 21:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O2-0003N7-9v; Tue, 24 Feb 2026 21:12:26 -0500
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vv4O0-0008Ty-Sd; Tue, 24 Feb 2026 21:12:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1SaqEGgvXBjGQaJac3qefewnnHaD1TaGOGHSNaRFRIY5PNgm1BlKJIDn+fCXTeazZqcvDUK6FaY6gMOdAn0ewvkSCaHp37yiFx6nGOJquIH3GdBnY+ajPgcaBDgwIFBJMSStBe3voeKb5lHOiPMDsg7rXQvNyZGp0hsFv1BG0HEqh9WFNnWR/VbhxM4//FX+R61VDk9lecRz6Q6iPP89hpqJ5qAK57xy86rk/4UesyCJab4m9F5Bw1Opn7bOCbW7Jrw8V6nW76FvD16jwClqZSxrIuN1YbWEd/R+uUE7uvjuX1ad5JCb7XJBCnktXWgJkkNIlKBpshz15Q8qzhVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=690KXiimusrqeKtoA/hFuYYO5Wii11mzJ+niotnpX10=;
 b=t3z/jxxmzMI80qhrbejNYtFn4NSDfLS2YZZOqatZTH4KR8vLKTw1S8XaK3zfOke9GswLJoFSBtLA4ROHMcmqidEBgqZmT1AIaC6XLxx09ZG11jhdqG7+tbJGiGqYegqPR0x6qSwfNEVIXvlufXDhGvX2OO7Dg4TZzvndxK1VqSwfWYdCgYJI1WsXRNeXJmdUH65yzxT0aHjtyjghtvE6mQzCmKnRt+H6dsQm2iDxYLMeNUjGGX3p0qfxNp+Fuk+Tdrl9G4xFW+7Cw9dN1bSTAayQwPAHbw9q+dFlehxpLS9Uk7/EcRGMae/Qy6DC1KVMKVNmBN6QG/OXPwByDr5Dew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=690KXiimusrqeKtoA/hFuYYO5Wii11mzJ+niotnpX10=;
 b=fCSi/6A0JMuVLV098LqKmr9BytV0FCqlR51079eZ0Y4VZ81dmGLECVNY+Q8WVPbDCUn+uuzgffIAOcXoKz4wtRMOx7Ro61bN0rQyx4iA9GZkVk1UDOfpv2CORBvQEt9TZ+MXY7feMGeUeKLfECMBQMZZ3TtwhRgelk4Kw5d39xnQsxFh5BtPcbLbk2ZElHv8MwOsesH1kFZ1DH9jT09bwcLwyoPf42glWU/4O1ouJMQxCoHka5gFWxEB3VNMIyecs1pmkSURkUe62ilVMnAoHw9rwwSSYXo/Kyy2Dagi0hwsZzSFO2hMOMiBstjpNS9d0PAL5JccgVm2yjXAO50FlA==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by OSNPR06MB8468.apcprd06.prod.outlook.com (2603:1096:604:487::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:12:12 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:12:12 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>, "komlodi@google.com" <komlodi@google.com>, Patrick
 Venture <venture@google.com>
Subject: [PATCH v7 07/22] hw/i3c/dw-i3c: Add more reset values
Thread-Topic: [PATCH v7 07/22] hw/i3c/dw-i3c: Add more reset values
Thread-Index: AQHcpfwnWSELSLRhakWSLlwqF/LHLA==
Date: Wed, 25 Feb 2026 02:12:12 +0000
Message-ID: <20260225021158.1586584-8-jamin_lin@aspeedtech.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|OSNPR06MB8468:EE_
x-ms-office365-filtering-correlation-id: eea814c8-2092-472b-9200-08de741349b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3iJTgk2Ih9l15rS07GG8/KlBQ3kohDPIcVrEMhw4Kw0/Z2+qYxR2X0mOEi?=
 =?iso-8859-1?Q?KO44HQsMI6xd9eAszOsHKe4TN5QM/RRat7l/DeV/R72rCzPFNcrJ+dcE1e?=
 =?iso-8859-1?Q?gs3XzE5W7C7Kcnd+yre6viMT3Cw6zhXlT9mtVcssjWSnrkTGWJuXyD9RZI?=
 =?iso-8859-1?Q?je6tFkEe5wzhx25USta6A8thuHboOXwFwfI0BxsMRsk2n1RUiWi4mY75M7?=
 =?iso-8859-1?Q?zSEnMSzHEJ47aFFal47NAgR4+dvTTaSW7tuU6FZ3IocaXMyW9rQGVd84H8?=
 =?iso-8859-1?Q?4CrQUfyEBjzQ33N+cO1gNEk1KrBGjrZeu+n4lC/iMg2VbDFP2n6KdJ09Yg?=
 =?iso-8859-1?Q?VguOTRtinxaogMg62wSyvtvkz7NJi1BgNDVn/20cxxp3ExsRVWgUN2/2xU?=
 =?iso-8859-1?Q?77YSeAMWA1eRKtGWNG/5ZlhB0hBuJDgx4UXY2w1nF2ujdjNCJpzETnHpMo?=
 =?iso-8859-1?Q?fJcmTvOIUmpP54K/0byjfvSrq7kANZHhkdoQAdwjK329L6R4UEmo8kxFVX?=
 =?iso-8859-1?Q?asysMEIRAomer7dv2zroOeboaNPFdp/A4K6E8Jgk+HXdlepsGdZIi1Vnpq?=
 =?iso-8859-1?Q?ODlqbyypfsAoEcOFz33NSD1y+JFj1qyFm1bzXgvC3wE+AqRBVkUSxjeryG?=
 =?iso-8859-1?Q?BbFe7HZAPwoITsBCE5cM0L482fW9JpoQZuUn/Xkb/6VXzUl2tJTsFZLU6S?=
 =?iso-8859-1?Q?aQC4qnSgMz+PReDevxwdZmIwLTIG1b7VS07wZ7DSmH+bETb+fThWI4rCmG?=
 =?iso-8859-1?Q?SsR0Mdb+1tkUwSqqynB4HhYERZrrQPke1BswuSILSG7dksfD8rZdsT02Mq?=
 =?iso-8859-1?Q?JhpGLTur+anXklSI18+LPIDAcGysoKV2eLOgCAsfUqUv8FH/bYX8xZ2dif?=
 =?iso-8859-1?Q?6Na304nqZXyGaSdODF/7SvTxsAp7ZhCIDOk1UDFzoiZVh5W9mfQ7ZMcUOA?=
 =?iso-8859-1?Q?Otc2G3XbPboq/1EwR2pAPPFtl658chETFAYPZyuC6TG2rYLlTVtDMKS73C?=
 =?iso-8859-1?Q?AWSLVzaLdawwQjqxcVgp0atnX/UR4N83crNy+ddQTAQHN1+ifkP2bBw8uX?=
 =?iso-8859-1?Q?go6JsyuyB53OFE49AdNjSevzb9Z6zPbN4m+9xolsnT07MseXNNzslBp18H?=
 =?iso-8859-1?Q?jmagd2LAnVlr0pInEUaxA+tRjyy5IuTUImiYehrTqiw8LL4Seqxo/A4LHh?=
 =?iso-8859-1?Q?wqSSA58EPe7UKjkJmPUYOaM8kS/2xDBjkBEhDt6jXF8J3VSK36Iu/vrGHz?=
 =?iso-8859-1?Q?kT/yXTQMRlt+0AVKLUhkmerl3MdveiajLKYN4HcA1BaxQDrb+L2yZC880q?=
 =?iso-8859-1?Q?arSmklYvPQPMmUCRDiwH8V8DrjNWVB8CmJcQXQfymkfHPYXNx0z0DrSyw0?=
 =?iso-8859-1?Q?cGMsUdtRrLbA7viiczc/2gKZRUpSUaLPGsDEA7RP4VhtNl3o7M/CA7R+2u?=
 =?iso-8859-1?Q?pIyhjiUn6li1kePc/9AIbnoKGrtsBHoHUybD7jSz+NQ0v67T626Njv/Lgy?=
 =?iso-8859-1?Q?HQzkoUKhVEasOevPFAUaKhFsTPRCHvTzf5yAJ6agXNmCEa/FqBYS6vWL1z?=
 =?iso-8859-1?Q?QwFIa1FrhtbTdVpaVm1Kr4Nf5eBR+7hbdvlxZgW6MhC5zhPxa9CnQjhNZb?=
 =?iso-8859-1?Q?6Q7TZUSC8d4u/hxYpQoY30AhrSS6wEI4pZZsSioca+mTto19iC++x6M12Q?=
 =?iso-8859-1?Q?Ucu8WYPVI3sLpzIFYDeSh15L7uuRkO7EkbnfaJFs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EG8GDbN/vrIU544EYYFey9bGF6GYOfqMJ1Kra1P7z0zud2qRYT55MYI/Bi?=
 =?iso-8859-1?Q?Mu0T5EMM1HhChStLCa9bkDQC176yqnUu7eLk1vk+YrgAqdh+7XbKKhLKxA?=
 =?iso-8859-1?Q?3Oi0wtrj/aOYsGyqx1gmJA9B51mcSTKrdxyPvO6MwOEavijctf1nMsIBFI?=
 =?iso-8859-1?Q?ul5nN2erYbJOgYBAiuhOpVZDbBiBCAyxBLtz+te3ilBpVk+YEbABwxnCA2?=
 =?iso-8859-1?Q?zgwZQAG6uqakHVcsjJY/pAeAoWXUsTOwPe6gLsa81yjuqhkZMZrF2jFNU4?=
 =?iso-8859-1?Q?IGFVIQmX1wu+4DBT6amJh5CT1o0wIsaZqeUXgEhvKXl4zc+5H36bSLbFOT?=
 =?iso-8859-1?Q?1TXl9KL3SaQUsNhwMzAvrgB3Ncpq7xdGBB05yuhxNG+e+pe6wL4fx+aLCh?=
 =?iso-8859-1?Q?/96rP2qCFh4IPzQMuGomce5fpJpAjxrTPSnnzw00vSQE0cWh7PrPFvqRib?=
 =?iso-8859-1?Q?TD8mOuCgzKxf79DoRFOp0rN2xCIWebzEAFJj6O1m7VvC1S5axMfQdmgFlD?=
 =?iso-8859-1?Q?4Y5PXr4OsqYOhThCV0T7vgPpsh0+udBXY3YkERsr3AzviH26spF2pbK3jt?=
 =?iso-8859-1?Q?3lQAZrJFIQ3Ze2uCg2R8XIejqiZgzMJJh7c440GKK4Rv3Zi4qeHueoipJB?=
 =?iso-8859-1?Q?NpuaatX8eiRxX6Iufb0cAShMoGExksaTZfNn8Pp97g15O4OBJs1iiWo4+L?=
 =?iso-8859-1?Q?1jHxMqH5edZbqVAcC2r+4ocHOS9o5KymWerkybaXtf9TnXyfwTkzZ+5/2C?=
 =?iso-8859-1?Q?U17P3TsLJE7bJZRr0DxT0b6DOGRW4++5b0ZjRZ6seCea614GQl3+fdpS/e?=
 =?iso-8859-1?Q?ZuewtSkRFlE82DDeiseodb3irV2qXtSbOzm/Em+cXnPzz3xFNfZWdJzO05?=
 =?iso-8859-1?Q?Oh01vFYmXiIK0ruEdMAhUcO/jASWwba/4U/MaMwxgVKpHjoAxFjitwfJz5?=
 =?iso-8859-1?Q?4jgMz1TqmRfReoJfDpv/QZzIydcJA/KhdJZuR89dwtXeDNpbpZPOrlNH3J?=
 =?iso-8859-1?Q?PtW4T56xORiQGGKN2aVuJ18XLODgJf2HMWEh72eXYvyhaW5M1GALEaL7Nf?=
 =?iso-8859-1?Q?6A+9HtkhwHMqYyX16wMOTpy16fsgrdJ80ahBCkcy2SG5iM/Hnog3E9Zusf?=
 =?iso-8859-1?Q?8Wxs5kN/2MDAd3lPXm9Zvu1x2dwpphVl4eCkqvd+2vyLOmqbrITOp0WVnP?=
 =?iso-8859-1?Q?NKWpqYcGsR/axRolOF+o8lUfepXdiyFcQdvL8pX58DTI17IjJHTi55k1he?=
 =?iso-8859-1?Q?Yl57HoWCfxTGFMUDrvF9BP1NHTCzLjUacmLfd92+KvhAKKdu2aP1HuctGM?=
 =?iso-8859-1?Q?pHQkrLQtaok8vyqFLMh0lhwiXILj9rjEaCXNrTsBLPhnp6ov9L3O4fbALU?=
 =?iso-8859-1?Q?z/PXC9fE3IJBPFPVNKteqCEDRpRJ3r05MT67STsNdYcPfozkSjgbeU/px8?=
 =?iso-8859-1?Q?Iel8NSrb3qNObU+XGcvi2TaR4atCeJXWw7kHp6yTsVIlLwLccNTPdMf9cL?=
 =?iso-8859-1?Q?bQ4g1yHyJPSdt6/O6iZYhrZEKAmc8kIbNCGD3BunD7U4KAVumud/6KjwRp?=
 =?iso-8859-1?Q?jIQkNQcWOJZjjkDmGKjJccs4lS9n9zZ16V7ntL1D1pnke+AyTOtGJ4Labh?=
 =?iso-8859-1?Q?bue4sdnNwO5uBxG76/1M/TanFzQdJtHCPWuRscyRBB5Bgrz9xpx3s3z5MQ?=
 =?iso-8859-1?Q?EsyJIPDvFl+mwJtJZvW3z3pFfFsssn7r8Q7jeJQhXNcb7vJswtebdLDRD6?=
 =?iso-8859-1?Q?aJKzdGR6gLYJQvKmrow70veNLnmYOO1qAt+xeNK33qjXEqh+gmIIOSXHCT?=
 =?iso-8859-1?Q?jyU7LTM0Ag=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea814c8-2092-472b-9200-08de741349b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 02:12:12.2138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 15egQJhWd9x8bljGhOv+9tw7D7tMDexpOwSlqf7t0vHM6nkMNFlcm05LxDRsOgdmB+F0LI/LwqMnsnFAGLJjeeojRs3gvUagsJ68MQ19BHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB8468
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
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

Adds reset values for the new registers added.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 20 +++++++++++++++++++-=0A=
 1 file changed, 19 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 48dde008de..28da6016a1 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -268,14 +268,32 @@ REG32(DEVICE_ADDR_TABLE_LOC1, 0x280)=0A=
     FIELD(DEVICE_ADDR_TABLE_LOC1, LEGACY_I2C_DEVICE, 31, 1)=0A=
 =0A=
 static const uint32_t dw_i3c_resets[DW_I3C_NR_REGS] =3D {=0A=
-    [R_HW_CAPABILITY]               =3D 0x000e00bf,=0A=
+    /* Target mode is not supported, don't advertise it for now. */=0A=
+    [R_HW_CAPABILITY]               =3D 0x000e00b9,=0A=
     [R_QUEUE_THLD_CTRL]             =3D 0x01000101,=0A=
+    [R_DATA_BUFFER_THLD_CTRL]       =3D 0x01010100,=0A=
+    [R_SLV_EVENT_CTRL]              =3D 0x0000000b,=0A=
+    [R_QUEUE_STATUS_LEVEL]          =3D 0x00000002,=0A=
+    [R_DATA_BUFFER_STATUS_LEVEL]    =3D 0x00000010,=0A=
+    [R_PRESENT_STATE]               =3D 0x00000003,=0A=
     [R_I3C_VER_ID]                  =3D 0x3130302a,=0A=
     [R_I3C_VER_TYPE]                =3D 0x6c633033,=0A=
     [R_DEVICE_ADDR_TABLE_POINTER]   =3D 0x00080280,=0A=
     [R_DEV_CHAR_TABLE_POINTER]      =3D 0x00020200,=0A=
+    [R_SLV_CHAR_CTRL]               =3D 0x00010000,=0A=
     [A_VENDOR_SPECIFIC_REG_POINTER] =3D 0x000000b0,=0A=
     [R_SLV_MAX_LEN]                 =3D 0x00ff00ff,=0A=
+    [R_SLV_TSX_SYMBL_TIMING]        =3D 0x0000003f,=0A=
+    [R_SCL_I3C_OD_TIMING]           =3D 0x000a0010,=0A=
+    [R_SCL_I3C_PP_TIMING]           =3D 0x000a000a,=0A=
+    [R_SCL_I2C_FM_TIMING]           =3D 0x00100010,=0A=
+    [R_SCL_I2C_FMP_TIMING]          =3D 0x00100010,=0A=
+    [R_SCL_EXT_LCNT_TIMING]         =3D 0x20202020,=0A=
+    [R_SCL_EXT_TERMN_LCNT_TIMING]   =3D 0x00300000,=0A=
+    [R_BUS_FREE_TIMING]             =3D 0x00200020,=0A=
+    [R_BUS_IDLE_TIMING]             =3D 0x00000020,=0A=
+    [R_EXTENDED_CAPABILITY]         =3D 0x00000239,=0A=
+    [R_SLAVE_CONFIG]                =3D 0x00000023,=0A=
 };=0A=
 =0A=
 static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)=0A=
-- =0A=
2.43.0=0A=

