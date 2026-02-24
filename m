Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696E4EFB80E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 06:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vumLX-0002ND-PA; Tue, 24 Feb 2026 01:56:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLN-0002HU-7r; Tue, 24 Feb 2026 01:56:29 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vumLL-0005Lc-E8; Tue, 24 Feb 2026 01:56:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/e8JcQ6WEQKXyRItQfiQzTorAokb0Ox5oTHysS+WAGAImJbFB2DCEqy9rywBUvjKj5QKWnyI+MrwIMkxNqTAaURuzvxwha+yrI/+JaFF7tOCDsYftnqPGe5s8oDpmeTt6egO4gaOMkUToyBNmW0EFKOvQ+GNLK/LcEJgPLNlg3O3olC5T+hdMtLjm/4esdnJrx6H5NinQYJY16nLGL677iBsctlDvMAjqkEeTjx2VuR6lMVJRhEpZC+druru6zNTeWPLgRya5MkEWcA73YImm9qNaL1z21hwfu+gtNXrwBFmeWzEst9SlWia9Yc6bhb1xMS4nbeN/8rEHrKX9L3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLMVteDKeSztFnB7DlEdsXNoavsyA9g+dxs2AI28N50=;
 b=VU5g73S3G0ojfjVk5SOPA2H8FYYSnwJ352IuUC/bgfkI1p5gZCOVJXaA9ogGc+O80uKMYdZzkta5IUML+biSmqCuineCqs0yPkWKly6BQVjtcbJoh4dFhDkpXWgg93FEWrkn0ojbYI1k5dGsOKbkH1ntbVmE2lGgw9ZeYmZnz5aLRsCx5xFRBB1Wft3LlTdWKNS0O4eWyhWpOZxIyWCKxbGxtvR2eZhV/Hk9gdmoQK7xpy3gS7DaH+M+Fp+vLJJCRAkXbX65m1c6lDct6GMxR1xoZlo5tYMtp7mf21gbymQcyzdUCNGW/s0HObzLOjHOgUj/1NMBuCuTfYzNmZcf5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLMVteDKeSztFnB7DlEdsXNoavsyA9g+dxs2AI28N50=;
 b=hRRaR6HPUC5NUDlSw3c3D+4qxbKAX8Pi8WnaqCXtqfGCxG+ADhI02Cq7f2OS54jwhE+/RsG2bVNSKB8xlNRJ2ADCEL9Ftkqp5R3gn+Yw4R7lzNgvfQ/A79zFa0zsbkMeSjOq3KW+KFwD6CLe6K61CHKfyByaxk5RlFjlc6MG8MHu5mVAwjeqVdao+rdsYvt9qzOoW57AM59j01ZnkZ/AZWv/j98guPkiXYvaZDTEVal7TTNfxOVQgdcYProejOY6sTY0APVBRltuH91uudbWXfRQhp5FiKeiSBBHBH2B95Y7cwgt6p8qlNIuEe6uV1qXRTNOjOFJfxbgbel7b3VmzQ==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by KL1PR06MB6109.apcprd06.prod.outlook.com (2603:1096:820:d1::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 06:56:06 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 06:56:05 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v3 06/15] hw/misc/aspeed_scu: Implement TSP reset and power-on
 control via SCU registers
Thread-Topic: [PATCH v3 06/15] hw/misc/aspeed_scu: Implement TSP reset and
 power-on control via SCU registers
Thread-Index: AQHcpVqll9uqL8XBHEGA/qoh5piBTw==
Date: Tue, 24 Feb 2026 06:56:05 +0000
Message-ID: <20260224065556.3847942-7-jamin_lin@aspeedtech.com>
References: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260224065556.3847942-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|KL1PR06MB6109:EE_
x-ms-office365-filtering-correlation-id: c3063286-0c91-41b2-66a9-08de7371c80c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?V+mDx+qCP9LbA8R8YXaJXeHeHHqm3qbWu7w3Ow3zYRvVuRh0mvrgg3Wowz?=
 =?iso-8859-1?Q?xGrUI37R63hkzZ3Xe50HrzW1Symaw+7/NQVu+YEhtmPIeDu4md2veo4a9I?=
 =?iso-8859-1?Q?dmnDmIfsWgDm5dumK3xcb6H11tZ5Qn0phpAv4iSU6kBGVIzbVjz74lJ5+Q?=
 =?iso-8859-1?Q?55GLk76zDIZzOglqTUxrN8c83C9Lbh9qH6PNdpK0HE16f6boZ8Pa0UPWnP?=
 =?iso-8859-1?Q?84v1vHLbu23hfqKkTQ+lO567FTQOhiS9k3aXnZ2Qu1ZZqwnGdvZ1s2sV0K?=
 =?iso-8859-1?Q?ngqE0LoyG4jld3aILOiM3+Av7ccveDbU4dt5jhmBvwLYo1f69GkeahTqFz?=
 =?iso-8859-1?Q?PGcsc//r0domUI0kYhRDoHEvn57tsx8I3KLwf5XI8qdEu46bRywlAWouep?=
 =?iso-8859-1?Q?YrcGC0S541zEsGv+CEeHas+38t3EHaK9g1Df/UIAayIRzqvIGvaqd40RzI?=
 =?iso-8859-1?Q?s4mGj6nwyhyeSEzNQfVBXgdCnkzzRhBjO4Tl3n4UX+knMPOmiXHPdmaQOk?=
 =?iso-8859-1?Q?sE2IWV3pqjULuVsqFOyBXqydvPmce7PT3yMk5lR9KumsiBRiIT9S0nbEI5?=
 =?iso-8859-1?Q?n5E+5PxYprVHBjDvrtB3OWBzFt7+Agtu8UiR7mEEhI+Ply0OhxIDTRG5XD?=
 =?iso-8859-1?Q?wa3RHpy+lQ0Cave7kG6W6vHIqtBGkKa/pwO6wmazPmHZeKsViZQzaWYPPs?=
 =?iso-8859-1?Q?WhJnZPro0f07MG1iizMfE6Jd1psaf1kf6GLnlcs7Z6vKiZBzPYLpAXsfWQ?=
 =?iso-8859-1?Q?t3ecThfClEtfNLzoNT9dthUqYEgmVCLblMB+YLzMqs8v3DY+R2AIObRkOn?=
 =?iso-8859-1?Q?TaEovfauNGtKvpQD4zmZmZUT99w11BnVNGMVsvOtp6n2WPcb7s2xAuFDkt?=
 =?iso-8859-1?Q?TkiOjokM033QJO6HJdnBVhhDrq0GqdZRy78xHGIe2COT8LI93atNClTmXU?=
 =?iso-8859-1?Q?kgapX5q/FNcDT0fxmcX/y3bEAjIH2l5+5T80Kn/YfXNosg2H7VgEoWJGrS?=
 =?iso-8859-1?Q?ScSDZkMNA235adJZJV+oCM7LHaX2oQSDlHjJ8zvV682B8X//CLRBfYZefX?=
 =?iso-8859-1?Q?XaDpaGSgVcDqqrDt0ddPA+kwVLLS3UICcDMje6Vqfi7+96kkgkn3/vIdAY?=
 =?iso-8859-1?Q?8d5xQKLaiwlqzbtCp/4OuezAcLpuhAeQWZVkwi/qVRLusXoHypWqwh4KuS?=
 =?iso-8859-1?Q?BKpBY5BL0/1gohj7Zpz2Pm4CxG5yYplXEECX6VkKUrn1ZA/Xp9I5AzSunY?=
 =?iso-8859-1?Q?r8o6gXycK11g4qOLE2qpPBBVQImuKvdZ6OD2m8sM0wyo7ifSd8Q2S2c+M2?=
 =?iso-8859-1?Q?fAtjKVO/qx1mCw8M5gfTYjvQCpHuW+XfNwx+802mHaHw+XADxbfOfU9EAQ?=
 =?iso-8859-1?Q?7fl6f8QHLgXBXr7KeivRD2djcKYCBbAaC44hk+qY2wPs5ZxZKRNyveE44G?=
 =?iso-8859-1?Q?I57J1ISR8uu0+Shb2rs7joSiD4OT53+8fDTBpQBVOMjJIbEEtolNmEdayt?=
 =?iso-8859-1?Q?hxAmP2Pi8f9mlueDZQdcyyJvZhKQ5te0dkK2bgcKUqINN9SH13XOvqZX6b?=
 =?iso-8859-1?Q?WxoXbVihrgqtDQu3IWL/S6AZmdJlbOViEu/5jMkJF2DI62BoPF0Iyit/fv?=
 =?iso-8859-1?Q?AtkZgu33qMCB5r2EJMklBNnHnPnN2iKuxk9v3kuDDyHIBfNQPs317RgYdR?=
 =?iso-8859-1?Q?8E9O13ppqrtEEzAB0WcNhBEyz6RByuYrGRhFzMnU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RwCTxoZ8IOM7Bxu9a/XGXm/jkYeUwqD+9iBxgR8P5pgpoxqOHgj3Qm5Ycv?=
 =?iso-8859-1?Q?1ctA5bnueVhrcNXJ3xjYwSSIIRygl3s8Cq9yTwXygGUi5enwFRmKMNFDur?=
 =?iso-8859-1?Q?R0bkpqBYPUvXJ2Kvp+VUsgwqfrAMpg+WzQhQU/tNPpqvqKAeUTL2Y1PVyH?=
 =?iso-8859-1?Q?MC9erBz6VI8/eJ3I0MdSlFNak2qnQ7aaRaElYYP3kqrf7k+F62Rrs67++A?=
 =?iso-8859-1?Q?EITR9Fz12k8RPZLY9FTw2SEomd89FMpyXF9bYJj8XtudCrecJigSVp0ckq?=
 =?iso-8859-1?Q?M45vrCqIucuovHQ98fzhkBUrqIn3rRcByD7CttEeV5zLYkdakcsN5eofzN?=
 =?iso-8859-1?Q?zpH8QsDqaQ4hqPpzt9GIZ2u5alP62gqNMwIK+nRaZSYK598ss2B+x9OmZu?=
 =?iso-8859-1?Q?RfOVezqdFqgnObmp98/FGFnbtr2HQSrN31JI/5EpwImHleoSH1a1Fe6KHv?=
 =?iso-8859-1?Q?IfPBLVf+jurNQpbCuUMRdvSC47IKazXOGQEqaiOZYo4mQd/dXgLElTMObH?=
 =?iso-8859-1?Q?2lZtsfOoAvY9up377DW5dkSz5IZnVtFReEj6759zXqWZIolUsLf40H/v/x?=
 =?iso-8859-1?Q?jPIpR+gM5d7kDoFPHt7tKe+Nci9xdXbjkXMtDCCcvjatcTxuKY78NxaLQm?=
 =?iso-8859-1?Q?ggyBRcDC9x2XLozHzxkCRZssoJ/Aga+ArdG8fqjMI7s64/xGXpGaMbeo0N?=
 =?iso-8859-1?Q?AJWOdKg4o2kbKsvF93u8RHH198iQ9VFSMk1/FVv2hetioP4cme8Rt0LEl8?=
 =?iso-8859-1?Q?TRq4Fr7Wf7F8FE7EphKPj+VahKg8o3UPxvjA8vb31NH3RWPoueRuG6WVi4?=
 =?iso-8859-1?Q?o5EXzHg8qEHaoCvQvF+0YFgWyCuMGhSBfAB8gUa1KWfYRkt5KTm1tzDjeO?=
 =?iso-8859-1?Q?dWTMN7I/YvkwiYDxzmHKH1wdYYhD8wVROKyA3OO/+qgAz4gj6sOPak+pma?=
 =?iso-8859-1?Q?alSkgR9IPuH1Q7PJeSeQnbTneiNKpxJ53A2Y7DP4MZG7ImYKN1ASfA/8TC?=
 =?iso-8859-1?Q?7yZO+xjW7XWzsN6yIeZI4Y44Jtqc70H1eRPjdgX286uVK9VrNUD2+nq70v?=
 =?iso-8859-1?Q?Z/hZv3Mj+KuABoxmictK9oFt3A6PZE/TH9YOucPsXNWml4q/YkGj9homZG?=
 =?iso-8859-1?Q?ydBUSMF85fS+RO7fRhy5Bp+INv7hNABY2nQBKY8tBWhjBoMmfrntvN2DiJ?=
 =?iso-8859-1?Q?VqG6aQiFRBCFVCAuDUV6U5bB32y5W60YUxE+Cv3wZEQ4tsgq7WdGzkr6TB?=
 =?iso-8859-1?Q?eddIl0Q6XS9VD/8Lr0bvF2iiL/c3vtoGIQLU7HHAKObcoWLs9HkaAHqgMe?=
 =?iso-8859-1?Q?3Fwa2kKf+H4p+TgPzQAzRUNdABWBcnMCFy3VE1t8iA3uO6bu03fpn3Y9D7?=
 =?iso-8859-1?Q?FmNWLaBSQOHl5Xz5nEEkjmr1C4GLmaveW7fZ6a5OTc7+E79izsX851xdfP?=
 =?iso-8859-1?Q?HLOhTrglc1CPnJ7ydemCOrXQOsx5t58arUqD93IVhjmV7DycSOZ8bI4W/4?=
 =?iso-8859-1?Q?J9vXEIzv3hg63eilxPKE8Y8vnAN96LjT3+Z5Up8M84tPpS+dKf8b4ye4d4?=
 =?iso-8859-1?Q?bMFJQTaFLedc2rCYhGg/hShnvozwy9oMl3kafSxxdn29HWemH3XNGafn0v?=
 =?iso-8859-1?Q?fZY3/fk9WaQ9BgoWArHCOJpOd/3QmcZt4uYroScXKVKcB9v2HtpkqZu9I1?=
 =?iso-8859-1?Q?oEQmgG2NGul7bBcAvQoNccinTQZWZy/5wmgrtds/WDGK6sJ6AZoD5lLRg2?=
 =?iso-8859-1?Q?2+b1Ozty0+hWmscj/dqCs848NBzOhpeg9NDc6I4EqfDhasF4nz10o2CgFL?=
 =?iso-8859-1?Q?Ur+f7WZRhQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3063286-0c91-41b2-66a9-08de7371c80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 06:56:05.7089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feJ2QCWoL7A70kMxxoGYWBOvMBiQ8Sj+HLfwAO7APaLscT7BKBYvJUlD9lTXqKIckbrHm+9Scgg9NpAKr/75UFDqdEw8en8egIjr3uIYz2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6109
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

This patch implements TSP reset and power control logic in the SCU module=
=0A=
for AST2700. It introduces support for the following behavior:=0A=
=0A=
1. TSP Reset Trigger (via SCU 0x220):=0A=
=0A=
   - TSP reset is triggered by writing 1 to bit 9 (RW1S) of SYS_RESET_CTRL_=
2.=0A=
=0A=
2. TSP Reset State and Source Hold (via SCU 0x160):=0A=
=0A=
   - Upon reset, bit 8 (RST_RB) is set to indicate the TSP is in reset.=0A=
   - Bit 10 (RST_SRC_RB) is set to indicate the reset was triggered by an e=
xternal source.=0A=
   - Bit 1 (RST) is a software-controlled bit used to request holding TSP i=
n reset.=0A=
   - If an external reset source is present and bit 1 is set, bit 9 (RST_HO=
LD_RB)=0A=
     will also be asserted to indicate the TSP is being held in reset.=0A=
   - If bit 1 is cleared, RST_HOLD_RB will be deasserted accordingly.=0A=
=0A=
3. Hold Release and Power-on:=0A=
=0A=
   - If RST_HOLD_RB is clear (0), TSP is powered on immediately after reset=
 is deasserted.=0A=
   - If RST_HOLD_RB is set (1), the user must write ENABLE (bit 0) to TSP_C=
TRL_0 to release=0A=
     the hold and power on TSP explicitly.=0A=
   - Writing ENABLE (bit 0) is a one-shot operation and will auto-clear aft=
er execution.=0A=
=0A=
4. Reset Status Clear (via SCU 0x224):=0A=
=0A=
   - The reset status can be cleared by writing 1 to bit 9 (RW1C) of SYS_RS=
T_CLR_2,=0A=
     which will deassert RST_SRC_RB and potentially trigger power-on if no =
hold is active.=0A=
=0A=
5. TSP Power Control Logic:=0A=
=0A=
   - handle_ssp_tsp_on() clears RST_SRC_RB and RST_RB (if not held), and in=
vokes=0A=
     arm_set_cpu_on_and_reset(cpuid) to power on the TSP core (CPUID 5).=0A=
   - handle_ssp_tsp_off() sets RST_RB and RST_SRC_RB; if RST is active, als=
o asserts=0A=
     RST_HOLD_RB and invokes arm_set_cpu_off(cpuid).=0A=
=0A=
The default values are based on EVB (evaluation board) register dump observ=
ations.=0A=
TSP reset control shares the same helper functions and register bit layout =
as SSP,=0A=
with logic selected by cpuid and distinct external reset sources.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 37 ++++++++++++++++++++++++++++++++++++-=0A=
 1 file changed, 36 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index 56f7e214b9..15c8b06487 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -147,6 +147,7 @@=0A=
 =0A=
 /* SSP TSP */=0A=
 #define AST2700_SCU_SSP_CTRL_0          TO_REG(0x120)=0A=
+#define AST2700_SCU_TSP_CTRL_0          TO_REG(0x160)=0A=
 #define AST2700_SSP_TSP_ENABLE          BIT(0)=0A=
 #define AST2700_SSP_TSP_RST             BIT(1)=0A=
 #define AST2700_SSP_TSP_RST_RB          BIT(8)=0A=
@@ -155,6 +156,9 @@=0A=
 #define AST2700_SCU_SYS_RST_CTRL_1      TO_REG(0x200)=0A=
 #define AST2700_SCU_SYS_RST_CLR_1       TO_REG(0x204)=0A=
 #define AST2700_SCU_SYS_RST_SSP         BIT(30)=0A=
+#define AST2700_SCU_SYS_RST_CTRL_2      TO_REG(0x220)=0A=
+#define AST2700_SCU_SYS_RST_CLR_2       TO_REG(0x224)=0A=
+#define AST2700_SCU_SYS_RST_TSP         BIT(9)=0A=
 =0A=
 #define AST2700_SCU_CLK_SEL_1       TO_REG(0x280)=0A=
 #define AST2700_SCU_HPLL_PARAM      TO_REG(0x300)=0A=
@@ -1002,7 +1006,10 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
 =0A=
     switch (reg) {=0A=
     case AST2700_SCU_SSP_CTRL_0:=0A=
-        cpuid =3D s->ssp_cpuid;=0A=
+    case AST2700_SCU_TSP_CTRL_0:=0A=
+        cpuid =3D (reg =3D=3D AST2700_SCU_SSP_CTRL_0) ?=0A=
+                s->ssp_cpuid : s->tsp_cpuid;=0A=
+=0A=
         if (cpuid < 0) {=0A=
             return;=0A=
         }=0A=
@@ -1058,6 +1065,28 @@ static void aspeed_ast2700_scu_write(void *opaque, h=
waddr offset,=0A=
         }=0A=
         s->regs[AST2700_SCU_SYS_RST_CTRL_1] &=3D ~active;=0A=
         return;=0A=
+    case AST2700_SCU_SYS_RST_CTRL_2:=0A=
+        if (s->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        if (data & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_off(s, s->tsp_cpuid, AST2700_SCU_TSP_CTRL_=
0);=0A=
+        }=0A=
+        s->regs[reg] |=3D data;=0A=
+        return;=0A=
+    case AST2700_SCU_SYS_RST_CLR_2:=0A=
+        if (s->tsp_cpuid < 0) {=0A=
+            return;=0A=
+        }=0A=
+        data &=3D 0x00001fff;=0A=
+        oldval =3D s->regs[AST2700_SCU_SYS_RST_CTRL_2];=0A=
+        active =3D data & oldval;=0A=
+        if (active & AST2700_SCU_SYS_RST_TSP) {=0A=
+            handle_2700_ssp_tsp_on(s, s->tsp_cpuid, AST2700_SCU_TSP_CTRL_0=
);=0A=
+        }=0A=
+        s->regs[AST2700_SCU_SYS_RST_CTRL_2] &=3D ~active;=0A=
+        return;=0A=
     default:=0A=
         qemu_log_mask(LOG_GUEST_ERROR,=0A=
                       "%s: Unhandled write at offset 0x%" HWADDR_PRIx "\n"=
,=0A=
@@ -1086,7 +1115,9 @@ static const uint32_t ast2700_a0_resets[ASPEED_AST270=
0_SCU_NR_REGS] =3D {=0A=
     [AST2700_HW_STRAP1_SEC2]        =3D 0x00000000,=0A=
     [AST2700_HW_STRAP1_SEC3]        =3D 0x1000408F,=0A=
     [AST2700_SCU_SSP_CTRL_0]        =3D 0x000007FE,=0A=
+    [AST2700_SCU_TSP_CTRL_0]        =3D 0x000007FE,=0A=
     [AST2700_SCU_SYS_RST_CTRL_1]    =3D 0xFFC37FDC,=0A=
+    [AST2700_SCU_SYS_RST_CTRL_2]    =3D 0x00001FFF,=0A=
     [AST2700_SCU_HPLL_PARAM]        =3D 0x0000009f,=0A=
     [AST2700_SCU_HPLL_EXT_PARAM]    =3D 0x8000004f,=0A=
     [AST2700_SCU_DPLL_PARAM]        =3D 0x0080009f,=0A=
@@ -1116,6 +1147,10 @@ static void aspeed_ast2700_scu_reset(DeviceState *de=
v)=0A=
     if (s->ssp_cpuid > 0) {=0A=
         arm_set_cpu_off(s->ssp_cpuid);=0A=
     }=0A=
+=0A=
+    if (s->tsp_cpuid > 0) {=0A=
+        arm_set_cpu_off(s->tsp_cpuid);=0A=
+    }=0A=
 }=0A=
 =0A=
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *dat=
a)=0A=
-- =0A=
2.43.0=0A=

