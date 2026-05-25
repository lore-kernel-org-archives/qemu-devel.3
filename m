Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A7FCD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 04:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRN9k-0002cn-Kj; Mon, 25 May 2026 00:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN9X-0002RE-KE; Mon, 25 May 2026 00:43:00 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kane_chen@aspeedtech.com>)
 id 1wRN9W-0001QE-0g; Mon, 25 May 2026 00:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9WiWPFFRXaECc9K8R8bHR+L3ULM9BoGof3wolEXLm6a8LCO2mIHntlh6fYkH+aayC5DNJiKPBkRs9Ys+kn/nXRwMdXtnkmgL3z45Rlyq2PWElHZfVmSiNOqmQMKQn2kw/+EC6Zmxe88O2N1ymXLwG0EayPF1D1G6xRoMSEAt/+ZgdtgE1SmtYA85p//kGv5GtmzWrL+lFjBlOia79uKNeVrWH4MZx8aycoMsMIMLfs27n+utzKoOmrE/JQGvrPJQaSG68l5n7wFebKmLvOSyjRePgSontjo0CV44og66NfHc6JI7s7TExyjsyAGsyeYakaWx6EBk/IvFnnyMSKvyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YkZECpVHPv4cXaRBc78fVJj5965aq1gi0+NSamtnrc=;
 b=Ae68I3O0Lt/75F86FKmOGvBNsLPyA84JaLSOToimJ7j1K8jqsi9GAOsNFvUapz2ChYvsZadSPOqPqxgahbp7kOdVh2CwrYfCsLxSa2zMvxsruVuy0/8JQluxea782pGdrsAWUw1Twurl0EuJDEeXg2eQ20Gr2t7EQMB9a+GmAKoOqlnNDmoUYhVHrVmATAzKldms2bpbpgIoPHzCbmI2jwolUhfGqCyY0tusMLv4qsEhj3kNML/elFvg9NtFALldJ002nTwTTUPpL5Rh0XcVD3zStEyLbp7n8YIDcMG03b169s2/5zxn8gMwu7X/uMVjJW9WLzdGSxJUzNR4RYWmYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YkZECpVHPv4cXaRBc78fVJj5965aq1gi0+NSamtnrc=;
 b=R4OAfxnp29nQHNlYjZlkkhDz1TTaPBiPmhkuYCAQr50bmGro0ktf+ZgnmEToo+ovxH2bEkLF2lFLF30Il2iHb+2SfVYtR6PU6uEQ38GPbneNquJwSSS0qoO9buTFB/RjFcOH/0m0uY/BBradtO+pWIk9FNne+O2hiHOUj9mv1rO49cO/VI5Iupv0gicwUCyfHp4GOoO+woqlMqi8++dke0mygCOryZYX8vfnxVrEyF4Ada2xcRNc2GF5lWbp0UqjAFMxnBC+KAGYkkHgAJB90r+Ea/ESGIVmspMJAJaNaM2SwyJWobPZ+AJItw7IcAldBDiDIYSiICXO0lrRT7eLqg==
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com (2603:1096:4:239::11)
 by TYQPR06MB8085.apcprd06.prod.outlook.com (2603:1096:405:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 04:41:30 +0000
Received: from SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c]) by SI6PR06MB7631.apcprd06.prod.outlook.com
 ([fe80::afe5:a3f1:b435:e43c%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 04:41:30 +0000
From: Kane Chen <kane_chen@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Ninad Palsule <ninad@linux.ibm.com>, Joe
 Komlodi <komlodi@google.com>, Nabih Estefan <nabihestefan@google.com>, Jason
 Wang <jasowang@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use Resettable
 interface
Thread-Topic: [PATCH v1 00/23] hw/aspeed: Convert Aspeed devices to use
 Resettable interface
Thread-Index: AQHc7ADBTVFYQA+5Q0qXUei6Cq1nDQ==
Date: Mon, 25 May 2026 04:41:30 +0000
Message-ID: <20260525044129.3133916-1-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI6PR06MB7631:EE_|TYQPR06MB8085:EE_
x-ms-office365-filtering-correlation-id: 6c4bd672-e053-4216-05a6-08deba17e40d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info: B5jjIi06uxbQN+lhA8OD2TSupSRo3AwTuqDpKu5Y4n3etMnlCrmG4Ax8GBHFs/jCTlUWAMYJUbTKW7f1/iXHeoy6EJUiYS5mszrznqmnuG1sgZI2t3HG2gI10bmUITpdXQRdaugHJK6zr2hBBNHhtMbCk9XMqxvjBNoKd0sub688c95jxIDkPakfwm4bOPUXtT1munEAKEkNAbla3ezqGGl3VgIZUPfbscGuAQcaIWHMhkgXeEuV2zPRlfBDsvve4qS/0jQN0uonBbKXfZGxKar2dCVnoM1uK8sRxYZQZn12l/FBJLGFdhAPN3jp8mIckV74ewQH3qCOgQ1ieFlN3q0FicQhEWNBAMUPeHXSumMSW3mMNGL2DhObqjYJFj5Kx8DHTJCBOdu4lKcPdvjS2dBHnaqc8lsVoEIDrfajeX/3xMoVh3rZFyht3IUILSyTH/oPe1Od4GV36b7SY5mKyASPbh88sbzPfN/ufVf/uQRKG35Q0A9b6JzmOuYYkWCF0osALppm0Bnv6h/YViroMApjC7lIh8lefG4Ne+CL82qRE7qAZ941dtCVExaUX+GLIGjhUbsQXWqGPvAj9yvvBRa7JTenP7evdF6FPbAetZtL0EZSeAuYtchdwgXpj32pE21bcgexc1L87vZrPgcTxcZ64NR96BHmrhJ+i8oeL4RJSCld0NleVcyDTfxLwgkZAzzTaU8QEEMlNR2Pt6DXb5fuTXH3BhsKOOESz6qpfJ/QIB3hd8s3Wb+rbqAugpAMrhgZyByPdhYwEwTGtQ+kyw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI6PR06MB7631.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(56012099003)(38070700021)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CaNqeuqtMHqYRWAUvHkxBDy4j/FakJvnuhNlVlMtX4ok8+34L7tlCaEAiF?=
 =?iso-8859-1?Q?AfFpw+HKPqpohiKJsEdQ2iYOu00aCQf4c1ARgWGYq/cEE2fszF+KsKR814?=
 =?iso-8859-1?Q?hwHjGZveDClZFHnNkumekp/R+IV87/GwigJcqFiNi3cXXzj12NTzKU7R2+?=
 =?iso-8859-1?Q?rWyK9vCcMsddqQjFGBhT1Pf1S6V+f2q4hZw1SuLsll5uSoOXjXI4KkexT6?=
 =?iso-8859-1?Q?RXt+LLjzz5K/DVnz67iUS4r+V2CekOQTQ8K2ezopdg1QdmdpN3KcN9bQqM?=
 =?iso-8859-1?Q?vC7g5+3CGnmgwi6dr1j+rKz2GtTIRH0c4bugHcIq7GfbhkOkrQZRUlbXQV?=
 =?iso-8859-1?Q?Fbf3eB+BFxRgi4VtoowML4TMLW55F06r/o6AzT8etDJiFBoXbNogPtW6LD?=
 =?iso-8859-1?Q?sQ2VTRdFcyoVe7C5ZvPYOD6leIskEiFWvvCZO4C+FNwaTVcZKweXkOrD1s?=
 =?iso-8859-1?Q?J+YQIJD/UPTytm4qwGCC//iSVtnIl7qXTa4FeaKbRqQZZA7YO76NagChUJ?=
 =?iso-8859-1?Q?lQJUN3OZoBSUIEwpDTO0EQURr+YQUO2VanIzQCm7IFWNRToSuvdnlduFhq?=
 =?iso-8859-1?Q?fNvb09jH68trGo/XC563DB7CoqcR+PP8DZ793uSUYsznl5IUw/d0/DrFwK?=
 =?iso-8859-1?Q?AvN5aW23+WItAfZ6EIc0kqB1VnvVoT13H4ScyKFy9CxGfpsiMtQDw0Sf5w?=
 =?iso-8859-1?Q?22fy8fOvIP44S7aZsvmwXhlJPA+3l9h610g+RDDV9e5yPE5wuPNxvcvAMU?=
 =?iso-8859-1?Q?iF9C+Rm4GKUX1KtuOO39D2WzqiZjpe9o3UJTggS7oKT7Qo8uF69b2G2rzv?=
 =?iso-8859-1?Q?Xm11BrTYV4HLR4M5/pTIy97Iqf2l7udtYxEuIgjS4nvqsV/diXItxTvPC0?=
 =?iso-8859-1?Q?HpjMZ8TTKUpOoXkWFGhNetFZpsBpJ/1dIEj9hgk3jCCGhT8UBN7J4biUUx?=
 =?iso-8859-1?Q?4QdZ83fWEZrObbu/WOObB+hYF/JmWv0h/ueN/r4nZuJi0yqyotEmdH5yIn?=
 =?iso-8859-1?Q?/84WcKcWedQxcEk+l1hJb6R7x8P4nsFGq7fTSm0TGvYIyOTfGCoudDwDQ0?=
 =?iso-8859-1?Q?xVPBXnOQVaa2040uYXkrZ0LdI0Pwnht/NonZ0TLT4K9iUZyLtHMD80MAa5?=
 =?iso-8859-1?Q?wYHICfDZxrMdAnIfYgt3mtsQO5Y4qUUcCjjw5yV/b4vxgKCztfcuy6EcuX?=
 =?iso-8859-1?Q?0esbJxEJyXWxSbwb1EbDa+huIZqktLDzRVreMC6GU2ECqouQ2bGaOnHInQ?=
 =?iso-8859-1?Q?SFUp856QXxygHuEn3igo9FM/PswrU+CFFsdP36r6KfWajUyrXL1j/AML48?=
 =?iso-8859-1?Q?Vzo6oN4fc52n3QPfPQQ3/CnpLAKhqV1LkgDXuHh0nWGtUQcRoTN1oUgbH7?=
 =?iso-8859-1?Q?i9fb11ywRoqUCbaDRZcr/Kk0Yz7Y2/OiaTsVGyrflaHDLQ7J0vkeZDkGd2?=
 =?iso-8859-1?Q?/ejnrBGXikpV0XTLQBwNWgahhtLmOw4xtz3qVnSPUHFT+/9uvMFY7Vo+eW?=
 =?iso-8859-1?Q?kqex0RYHItIcsqUMAc5nVMg2lRoOyQqKkCM9ZFVcCrpjiPKhNUNNECEaFo?=
 =?iso-8859-1?Q?U0dFa6FbpIYBYYrKXq37hsYJWNR3X/ND9XbLwLfVOxsFZx6kTdMDqWkiKH?=
 =?iso-8859-1?Q?OJCUJHL+IvfyBe+yKDgIZgdsZexaT6L5B7GTkNxMBKCJWmymBBW7cDXu0D?=
 =?iso-8859-1?Q?2fS+/QdUQNF/+ea9jJawzAUXl3wScUpw8zyjGZ50ayAvkC22huAc5YEZ43?=
 =?iso-8859-1?Q?MtIDF1aOs36qczF3iv8tBAnwEZoNegfqMGYopCdu0/g+HReHH880kqe9+N?=
 =?iso-8859-1?Q?BUm95PJrow=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: k7NnupH6CNL7GxJLBahCJhqcmZKE1qFdL9dw4IU+rrwKyp+M/Vzlax6+Dwu3As0NqzepiFjBYTR41ZkIDdcWbPkjsLgErx/04NQwKuMbXAg5Z6cS9K6+bRuQAnykp2odJdalVZ6JOcehnlcuO9I/4V0wLbRxeqrPGIHLKARU2cyqqn8lQHxiwmIf4rodTeBMazeDT5ZjlMFvzPJy7PiWynfXButmxVtMk3pt/Aqx4cn+RBUS79yjr6ztA1UJu3YlLWbVRu/qWnsuSnIm8/rZKJVhGak5SZvWsQnHOUl1QORcmQOL/klv3EuVLPF1NlGzsfncvZDlcKW7Kj1f0p8b9A==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI6PR06MB7631.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4bd672-e053-4216-05a6-08deba17e40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 04:41:30.6199 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iAlIN0wqPqmFtJ8eiHcTK1lY90GLnnkPicd8yEwCseOCrT28BVhvb2ZwXg4lPXVDbkyoLAbpctSm3vveNwd1SNq2Rkaj8wqBGvH6ZiQFQCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR06MB8085
Received-SPF: pass client-ip=2a01:111:f403:c406::3;
 envelope-from=kane_chen@aspeedtech.com;
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

Hi,=0A=
=0A=
This series converts Aspeed device drivers from the legacy reset=0A=
callback registered via device_class_set_legacy_reset() to the=0A=
Resettable interface by setting rc->phases.hold directly.=0A=
=0A=
Best Regards,=0A=
Kane=0A=
---=0A=
=0A=
Kane-Chen-AS (23):=0A=
  hw/misc/aspeed_pwm: convert to use Resettable interface=0A=
  hw/misc/aspeed_peci: convert to use Resettable interface=0A=
  hw/misc/aspeed_hace: convert to use Resettable interface=0A=
  hw/misc/aspeed_sbc: convert to use Resettable interface=0A=
  hw/misc/aspeed_xdma: convert to use Resettable interface=0A=
  hw/misc/aspeed_lpc: convert to use Resettable interface=0A=
  hw/misc/aspeed_sdmc: convert to use Resettable interface=0A=
  hw/misc/aspeed_scu: convert to use Resettable interface=0A=
  hw/misc/aspeed_ltpi: convert to use Resettable interface=0A=
  hw/pci-host/aspeed_pcie: convert to use Resettable interface=0A=
  hw/timer/aspeed_timer: convert to use Resettable interface=0A=
  hw/gpio/aspeed_gpio: convert to use Resettable interface=0A=
  hw/sd/aspeed_sdhci: convert to use Resettable interface=0A=
  hw/ssi/aspeed_smc: convert to use Resettable interface=0A=
  hw/intc/aspeed_vic: convert to use Resettable interface=0A=
  hw/intc/aspeed_intc: convert to use Resettable interface=0A=
  hw/i3c/aspeed_i3c: convert to use Resettable interface=0A=
  hw/watchdog/wdt_aspeed: convert to use Resettable interface=0A=
  hw/net/ftgmac100: convert to use Resettable interface=0A=
  hw/fsi/aspeed_apb2opb: convert to use Resettable interface=0A=
  hw/rtc/aspeed_rtc: convert to use Resettable interface=0A=
  hw/adc/aspeed_adc: convert to use Resettable interface=0A=
  hw/i2c/aspeed_i2c: convert to use Resettable interface=0A=
=0A=
 hw/adc/aspeed_adc.c       |  7 ++++---=0A=
 hw/fsi/aspeed_apb2opb.c   |  7 ++++---=0A=
 hw/gpio/aspeed_gpio.c     |  7 ++++---=0A=
 hw/i2c/aspeed_i2c.c       | 14 ++++++++------=0A=
 hw/i3c/aspeed_i3c.c       |  7 ++++---=0A=
 hw/intc/aspeed_intc.c     |  7 ++++---=0A=
 hw/intc/aspeed_vic.c      |  7 ++++---=0A=
 hw/misc/aspeed_hace.c     |  7 ++++---=0A=
 hw/misc/aspeed_lpc.c      |  7 ++++---=0A=
 hw/misc/aspeed_ltpi.c     |  7 ++++---=0A=
 hw/misc/aspeed_peci.c     |  7 ++++---=0A=
 hw/misc/aspeed_pwm.c      |  7 ++++---=0A=
 hw/misc/aspeed_sbc.c      |  7 ++++---=0A=
 hw/misc/aspeed_scu.c      | 39 ++++++++++++++++++++++-----------------=0A=
 hw/misc/aspeed_sdmc.c     | 14 ++++++++------=0A=
 hw/misc/aspeed_xdma.c     |  7 ++++---=0A=
 hw/net/ftgmac100.c        | 14 ++++++++------=0A=
 hw/pci-host/aspeed_pcie.c | 21 ++++++++++++---------=0A=
 hw/rtc/aspeed_rtc.c       |  7 ++++---=0A=
 hw/sd/aspeed_sdhci.c      |  7 ++++---=0A=
 hw/ssi/aspeed_smc.c       |  7 ++++---=0A=
 hw/timer/aspeed_timer.c   |  7 ++++---=0A=
 hw/watchdog/wdt_aspeed.c  |  7 ++++---=0A=
 23 files changed, 130 insertions(+), 98 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

