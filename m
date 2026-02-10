Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B80EA3F2A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpjlu-0001YT-Rm; Tue, 10 Feb 2026 04:11:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlm-0001H5-MW; Tue, 10 Feb 2026 04:10:56 -0500
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vpjlj-0004jF-Sa; Tue, 10 Feb 2026 04:10:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDItqVA5P0JTCmAvQzDaSuKRuEaEz5cykkGH67Jxk0CfKsDB7lbztviB+NOfNGoHpmijrDLNx1cxwrdHd6CzMkCF1kVaanf7yI64MP/c9JM6ZSTV4tY/YpKqTUvmQmfxCrQ6kQKMxXcr6iXxcC7s6TgOHa3Azad75AHzO2AZEAbtPOkZWAL8/iA75PRu7JYGYLdKfNRkahop94706rm5xrcFBCe/IoKWXJdGVC06Hide2ipbiMpjudeCl54vOHjDNDr9WzqzLRBof+lTcR4VrcwmBU889ges63jFWOuID84T5zT9X0ikm1h+IqXrTjN2+tVd7wByi/aiCRQBEGmVFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tptWmcjjG0th2rGgP0TRbzpP7B1VjMK9fwenPJhZXuU=;
 b=NAtnyHhlAM5UK41I9IAXTL0zwuPkv0TdvnELftFPP4RNNrRwfMlRtBd3wI5siAfi478Tel7+jiFjvtgAAKnL3vhZDwpeDgkNTv9slqZ4xxfXhyv8DWR2HKplzEN6Elf1Y+yNgHYWbHiN2Wpn5Y1SrEKkOdfeqRe+oRZR3McGyhnegcUeSqkvMcgbPpwuKO+ZKLdtxCyhf2dYYMdG7LWZCkYkn57TK/jKQbqTxkWl+uOe/3YaqjV4mlao7uNy+fCsOMJan3SMd7nyE+Oy8XU5yuxDI4c4OWhsnRz83ttiF+gcsO0p5qESPEYJFptjV7I2jkNz5pw77eY+VzfRqoQU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tptWmcjjG0th2rGgP0TRbzpP7B1VjMK9fwenPJhZXuU=;
 b=T1emdpC0sUrv+qrY4F43+TmphdlvHiyeyZS2HvMOeUUpfU0XIFO9cpo6eM0O3xOZW2wuywPZfsywz8BUY9bYbnFFTfXp/2JYfExYoerVbkyBXy1F1W8lf3+EhWTNfP5rFPzbLPqp1HQA800ab+BU/8hLmjbI19VKJ2j3MuO6bY9+qcC93MInzQ4oNQvXljGgxqFgtzYId8xaeOKWqG6lmqEhzI/G1l2habxIwXsLTa7BeWnjxY/eAJeFWdPtS8kGa0KfQTHxHkMGCFhC2PEf1tLVSea4Fk9SwV+m0XxXyM7LuZk7LdQBUDrB1LGjKETOH92eUCS0NZOiEmon6xoC3g==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KUZPR06MB8268.apcprd06.prod.outlook.com (2603:1096:d10:62::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 09:10:34 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 09:10:34 +0000
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
 <nabihestefan@google.com>, Joe Komlodi <komlodi@google.com>, Patrick Venture
 <venture@google.com>
Subject: [PATCH v5 10/21] hw/i3c/dw-i3c: Treat more registers as read-as-zero
Thread-Topic: [PATCH v5 10/21] hw/i3c/dw-i3c: Treat more registers as
 read-as-zero
Thread-Index: AQHcmm0cduSNDtabkEm+JHF8IV8MdQ==
Date: Tue, 10 Feb 2026 09:10:34 +0000
Message-ID: <20260210091018.1553489-11-jamin_lin@aspeedtech.com>
References: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260210091018.1553489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KUZPR06MB8268:EE_
x-ms-office365-filtering-correlation-id: 853cd53f-8dde-4f19-45e6-08de68843f5f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?jAGE6019mt6It59W5QTqP9aGi7n/kTGZi8r0u212ZaSbe6zDP4/HDEVh7a?=
 =?iso-8859-1?Q?AbQTPJrYPWH2cvzRz47s/z1NLNz2Jion09FDjqklsw1D61YW7iIvHMjx8v?=
 =?iso-8859-1?Q?cDZ4euW8tfYsNncG0JvEdKbiyxFHDxtkOSFRN7Ym36n46S2+zdjpU57KvT?=
 =?iso-8859-1?Q?xetXsBnW58efMs3Rg3bZaI+5dkx0vXO0clr7+X/RdUXaA3D8xVCMb55rrK?=
 =?iso-8859-1?Q?Y/oAVJApBJZOK6onAd1MgWUteupEX4Ji8T4dssGtrOMyJq2wWQL01kMI6c?=
 =?iso-8859-1?Q?1FhHvU1aKT0Np/Yjub2g9OawS/Fe5hct8bXpkWlgSd8zE4RYGppxpqEN2i?=
 =?iso-8859-1?Q?Zu1eMo7+KmB9Yaaesoeox7erg3eaNZ8FyjCMuGPr0DEdt+4Xq36DluUZsc?=
 =?iso-8859-1?Q?PPVrFHX12Lxtiwixde22nvHy9ATL5QN26M8CiLoBWsgjY+Fik1f9xX70Wd?=
 =?iso-8859-1?Q?dNePKeiOYnDWxSU7pFsdViIPmoKexWnFuMmvwidhHLeGY36K3giM31vWO+?=
 =?iso-8859-1?Q?yqhqP3S48pmN5vkkQKujP2ck9cnxydGPkvd7MEWrovuRNpV5HPXyMOeSSA?=
 =?iso-8859-1?Q?YcKDTJG5A1oVe89c9iNCzw8OH7tbcBtjnlrM779Rr3sowKYJvimi3bvsoN?=
 =?iso-8859-1?Q?OEs2LWnKqpPYs3q1EF0s8kuz7+8oX9HtnDzJYAAGkPVv5elbRBwr//y5oX?=
 =?iso-8859-1?Q?OiqWhDAbYQtpTaFfxIDCMHpyq4hfIriG4i0T7UFssPq2RU83m0mjvdbv8M?=
 =?iso-8859-1?Q?NrzdJ5GC3Q9K7A0meE5u0Iod45ZGsaHateESyfkYyfmdnC3Pi/EL049MbP?=
 =?iso-8859-1?Q?/D4gpDjV+uw+kbNdIolyWZdrlUOOdW8qRKu2DtnIjRMKVAiu4w9unaVzAm?=
 =?iso-8859-1?Q?LNnboa+FDqzskDdWPo3qBNsRvS67IBaOq6XV1I0VEDatue1Yiv/4FCo5fi?=
 =?iso-8859-1?Q?mOToGrFdUH7aZmL/Krz8d8WWRJsY8L76fcUVddWq0DjTOUIviG3caoTnmk?=
 =?iso-8859-1?Q?k3koaMDu5+WBpQrl0neQ5DRtE5dDEf7DdaPo29HSNuXjVZa7DhCHAzcNNS?=
 =?iso-8859-1?Q?Ll0qx6ErN8wNrWC2sEkzS86NvknrgjbjrtV7RoYJE2ikMyUWZJ8rUU9Jld?=
 =?iso-8859-1?Q?TPNBoCgSjN2EwWjZgnvZ2FWi0yzcpfvlpPGo+eLBbu51oad5UEWU65HT4c?=
 =?iso-8859-1?Q?HbiJCKbjyyY7zumi5FYnPWWYk2r/BsGiaw9t9wfAbeCbsQg1y+4lxPIfKh?=
 =?iso-8859-1?Q?m6rSl59CiBcEgbdBHRXXkZIc3wyFmjGYgRaUiVYQQur8E9n3ky07Rw8XfD?=
 =?iso-8859-1?Q?9zCBzIcE+RceYv2se+Q/K+D4zeW4WGi5wfX8G0M8N09be9EUATmvUQyWxd?=
 =?iso-8859-1?Q?gk6ODzJ4PeE4DC/r/kHjnkNqbI/ZRRqa2IOq9O98Oe4wGx0g4NcwtfKAns?=
 =?iso-8859-1?Q?z7GfN6BJhhFlvI+Jh+dZETacs6WYbbMEgd8VrNZjV8I600Yaw3ZQCOxP3Q?=
 =?iso-8859-1?Q?Epkl0arta1X2XC4BGTqeuYLoB7uoPqeBe+SB1HBkigYNHHqrzoEgvOdB1B?=
 =?iso-8859-1?Q?UdxEl7nm0tflY87VWY0heX8pa00SZv0LN3kpz96etVXD5Ax+2BGI3DaAY/?=
 =?iso-8859-1?Q?ncLECTnw+oezHQwO4xGUguT0sHSiTdGUMDNCzWtml+j+lskIW9Y7zRhTeJ?=
 =?iso-8859-1?Q?Cuoq9d0iaBNtpy7J2BCD/i+oMODcVLCjjvrm+3N/?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?kDAByDg6ycLIB9KRW531S+zWZa0Vs6ZC4Jw+L1K7MqvRYAuqEVZ988bHJa?=
 =?iso-8859-1?Q?xIopVcH2bzoQvNPaB2SaDDJN2Jp2Mvf8+RTsspDd7gITnMlKZsi2qxwQjT?=
 =?iso-8859-1?Q?DBJv6xroBuduXrQ3nplS0g8uW+lL2o0IIgjhQQksETFzynhZrpbNWwkA69?=
 =?iso-8859-1?Q?NFTcG7LiauFOvVdurAXfA3jKpQQ2YmTLOOFINffbGSsyPR2HHUPi0EP8T+?=
 =?iso-8859-1?Q?E54DtV73bH0dOkwN/u1shbGZelNb90Fg05nk17tx2jPzG0kXLZNong5N2K?=
 =?iso-8859-1?Q?Qchdg3ooNjSxVkJ28gyN0PZflBphaL4m49r9d4p2OwKeckb+ZQxKcX7dXZ?=
 =?iso-8859-1?Q?qkITH9ieEcHOymFs4SxaLE08hQCPxpydC2/crkjNawz9qFFEjCwM6Bn+1Q?=
 =?iso-8859-1?Q?TjHcxp9qRh3bnnBi/xVrLkx6FiQAbjiGgM0X4ClS87786QRL5i1a80NrIx?=
 =?iso-8859-1?Q?YPnnsyPZS+a7R8l8HjnRPaC11I7+23Ks4D8XieJToCz/bmqrX61xEjhVB5?=
 =?iso-8859-1?Q?X2RHzS5erwyeMzbL1iwv7SCIM4axSWrDl/KpTbaSKj+L7Ko7q7s5rIAwB0?=
 =?iso-8859-1?Q?sTvUgZEKDEUZDe5P7yDXwE+g4TdGaFSj9Rl2jZyGUzlTUNKKitxDo+jFQG?=
 =?iso-8859-1?Q?aBHocyxmbeUSik/fzV72eFDaUSuD7QDHIuY5HfD9Qf9uwFABIeDrqtc8pa?=
 =?iso-8859-1?Q?m/vVM42PkWihpgkrKXgn9EGQ46xrsfag7bUK1RMTjbWogfBzCp2Eo/rUrq?=
 =?iso-8859-1?Q?bkquB9DM15ArKRAKsD6Aix6kG/Jp0z5p6LjDSVTr+aIqW+HtKxoTMYhBl8?=
 =?iso-8859-1?Q?inB5oHA+5M7DOKxTQbwmVd/rczHgxEpMrNXNnMyKlaG0TVU2D53KtVfdt8?=
 =?iso-8859-1?Q?LE2l1gDo3p+7gd5emmz/nBRoUIF4bPn51jHqo9kFS+1r9imGy0fMdCiXXT?=
 =?iso-8859-1?Q?rNj0zPjYzbo46Shoukb+ZOSFwohQpJwgIh3KT4EGHI71G5wn3YXBCENOSa?=
 =?iso-8859-1?Q?abesrKVrX4/VL5qLvd6LyN901ACvhpsyom01z9xbpmAsaXclv3Q+9twE+s?=
 =?iso-8859-1?Q?aaeNpSG0tY6qgiD38xsFOmsPN4wV45G+nZNVDZQcYeXlEs9trSVhsBXLs8?=
 =?iso-8859-1?Q?fePs+G+9V82YTARexEUbWrAwsYTNAueVwupOauz+kKbICLjUt38PvcuHrP?=
 =?iso-8859-1?Q?wgiVUQZEqM8ppRJaifTdyq+gVE3ci5np/ssRQ34W9G4uiA1rfdr+luf65n?=
 =?iso-8859-1?Q?jbfF6FTeLc9UyOG23EAcidhN9G+RHXcG+KBPFw0PcQ6gSUHfQ69+tP0nxi?=
 =?iso-8859-1?Q?5KCC1ZvyO+GQB3VupdDmhn7oxm+3d+HZbI1jI+lVWHhQHIhDEaGNVdGC+0?=
 =?iso-8859-1?Q?p9AeGKYO1y5+mMdogkcBqr/JVrC5I6tFTzPfSETlLk7Tk8c7OKIe9UOxl6?=
 =?iso-8859-1?Q?VUI0Y+mNK49CKpOO6i0Zsqk2wTKHS6bZdCC7TQTb+/OX4kbcm7iw+BAvt5?=
 =?iso-8859-1?Q?Qo9lBwd+/nYyg5rbAFV4SeRzyP8GSDK8rU6OODKK2xwqxn5dYBurMCjY+f?=
 =?iso-8859-1?Q?x4Jy36tMlmg5XDCTMDKRPCC2C3Op/msh1/qb5m1429EZD9+ZxRY3Im90kd?=
 =?iso-8859-1?Q?f6gRMrPbAmfRBUQ23s0T8poKrAInk221+TEA9EQzqoPj41y8Kphk7x3SOo?=
 =?iso-8859-1?Q?iXFmvOv9wWPYP4fa5bkz6Jlsz0ZfA1t69eLR+LSBYJPsXYhL0juJ4ozoIV?=
 =?iso-8859-1?Q?4hWb64NyDsyp6t9nmddigXUh6QCn+DujJ0VFAna63SN7AQ0xRtLh25dTBt?=
 =?iso-8859-1?Q?GfNgI3OdjA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853cd53f-8dde-4f19-45e6-08de68843f5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 09:10:34.0594 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MIqSYLgL++tBTeyDwjyRupm4plqC1HHE6k3kQSENPQ6XL6RHuCrSG45HPe31w1T30VBO4cwef5c15sNlA0qw1O8iul32HBsfJRuWjnFnRUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8268
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

RESET_CTRL and INTR_FORCE are write-only.=0A=
=0A=
Signed-off-by: Joe Komlodi <komlodi@google.com>=0A=
Reviewed-by: Patrick Venture <venture@google.com>=0A=
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/i3c/dw-i3c.c | 3 +++=0A=
 1 file changed, 3 insertions(+)=0A=
=0A=
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c=0A=
index 87c8f63da9..eeaf1125e4 100644=0A=
--- a/hw/i3c/dw-i3c.c=0A=
+++ b/hw/i3c/dw-i3c.c=0A=
@@ -342,7 +342,10 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offse=
t, unsigned size)=0A=
     uint64_t value;=0A=
 =0A=
     switch (addr) {=0A=
+    /* RAZ */=0A=
     case R_COMMAND_QUEUE_PORT:=0A=
+    case R_RESET_CTRL:=0A=
+    case R_INTR_FORCE:=0A=
         value =3D 0;=0A=
         break;=0A=
     default:=0A=
-- =0A=
2.43.0=0A=

