Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4FECC624CE
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ETx-0006HK-KL; Mon, 31 Aug 2026 22:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1ETt-0006GM-1W; Mon, 31 Aug 2026 22:44:13 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1ETp-0003Kq-6M; Mon, 31 Aug 2026 22:44:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMLCqs0bC4OEM96+GaA3c8ZqSP5ontB163L7t/7fxQ50eCFgwH/+tiLZe68FC1s8r2DGHicJcSKv8CauyVJ6tBtvMSX9SwkVJdF5IXe/BIs2fR3oH3b0uXhJg09SO1mXlwS0MaoJYa4otZ6BXM84T3v8Iw1DdOnrDV9yNsallSnl8mypZPTkzYNZWTsHLi8iZ/jGL8XzeqQ6XpTrEC/dpgriKJrBljpcvdjkrOAlSg0uJVWipol+tB5N4OuYUpShbObhMO60KtT0LxekbdC8RobTWUMivRHKcwKzoD7jwjE313SIv4rPD2BqnZGlgdLATTlAP3o5Ogk/yW/NBCM7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FWtFCtxSiwMlz9z9t7s1tbL58XWfLOtZD1H+IvGCTPE=;
 b=y28TWQQhn6Wfrd2LNYiDAbEVR2zevT/nsGXkgJ5nEIwVHZXv9KVczfIrW/CgLTFZZFiJm5E45EsgoOR1ZnvtmNHJH+XrqxswnNSrqh6+V9iEz3Icjyt610lJqdfhXED/n7yboTR7tU1kSJn+3VJzU2ZN7mv0I1asUJLrfybPEZ+wMj7T5NChokCr9bPW4U/OV+M7MBuA8wKQPE+0cT7ccQ7wFurc4q4tdsJFnyL4NRY8hurGFzhq1kTbvqUp1TpUrU+IgLpKVrGC6s7wZqXvcVCJTHwK12RkE5XxpZeP2rHjn6N9pXsplpGfIFl4OXaEXN0uaQ7eq9YniQrmn9eWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FWtFCtxSiwMlz9z9t7s1tbL58XWfLOtZD1H+IvGCTPE=;
 b=OoWFaHQnQV2bA/6hLL3FymCdeJASDSK5M928VWYXL7nWhIE/DH1ri0oPxm0/R/Gtac2ajGrA0Ska/ttiyA6zHSYsbMivgt0TtGWzM2MQ/oIVDhuZkWuW9D0yjxyrkUtLksIioS7jX6uop3fdL8e/+F0UmyhY06hxqMnoYTiyDhJoaC2Dn59nB11JydgT13H6o+wL/jH/MC2iO0VeTVN0eBOrx2VlZkZNHD8UEYI2xyoC++dOZui35IuekX00CaKjv6zzP5DGogs4KLZ00Nl85AuEY9KwEOaJH/47z14ooL2/p2WVn6X3AQZ8IUsH+uiWIjUE9GHrfja9+tC1ZgLMqA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by SI4PR06MB8448.apcprd06.prod.outlook.com (2603:1096:4:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 02:44:01 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 02:44:01 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open list:ARM
 TCG CPUs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v4 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Topic: [PATCH v4 0/4] hw/usb: Add ASPEED USB Device Controller (UDC)
Thread-Index: AQHdObu+ZodCU1JLZkSOn/AECqi5lQ==
Date: Tue, 1 Sep 2026 02:44:01 +0000
Message-ID: <20260901024400.3488429-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|SI4PR06MB8448:EE_
x-ms-office365-filtering-correlation-id: 1774cbc8-aa59-4dd4-7b65-08df07d2e154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|921020|6133799003|10067099003|18002099003|3023799007|56012099006;
x-microsoft-antispam-message-info: YYp9eAIlBlOcbxj6XxLoUIuQtHCUM//ab5UvGfbfXIfpMoi2Tvw3CcqIy6FaYKEh/AxCnBaQT8xVrUVz5gn2d0pTxlZhEN6ycI+HAumsOEJPAgkUT4ZSoFNglBljk2dR2ckD0N7BVkN0uwHiVN53j/pnMPDemaJQI96l0R75LBIsdxOqP7L04WWTbX2LezKKC1XZE5BRAWns3+LxAb/fgHoExxnAizYD8VRBqXjCWC0KwmU2fJFEWdrVN4dBQZB2ma+LYSf6+V8xnOOwOhRSIsd6W2kx38TmrWisAJvR5yk7gJqhuNfg1G1wPKbv2zFxJDs+cjidaO7B9DxokAgVS0jH2ELfz8Cth9yqBP/TaUjrm9p9QBBSrOjBwEQumO6wulby8gJPklMe+h73icayNV145jwWpCPPjgziD+LoIK/Xk5YZ/SnOdNr/hFfUnS9S6N6UvEUJk4RWQ0iv1wkkjp5GGCrczhCj6TVx3SEqbSvDt/WrHomiweDwnzoxPFihTdTIg02NGxtc6lTdkSXIy/u4B4T1w7aDuhpFlT9gArZwSB4ue7QpJVsSOqQnVc6w0yq0XU6PF/9wShS8YXKKwOPJNP5MfvqlI3AJgwbLHPOWDTmjT2fk9f3leBGuC6cUK6eBFfBbLSHVtmjFbHN8aV9BIaGy4Tfdr1/vNKg9KAbqhw6Dg1KzdDg6RrFHwLnL2bnA3E9TjnjPgd01UMBxDpyvcOh/eOfTblu3oNLPhso9jaHKPYASpwfQgQGQIL2k
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(921020)(6133799003)(10067099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ow089/lLu7gDGXah3YrzJoQh3PQoZUz9LZETN/46WV8WlaL5VZ6si9Kbvy?=
 =?iso-8859-1?Q?sHKjyl+d6cQyoxbk+86E37PKju3uJeTqlr9vaJZ+bJdkI/5FnhDcUsXMNB?=
 =?iso-8859-1?Q?mkN8VA2gMqWg03giDd3KZJFu3jGaiWXha7Qc4GyY0MvqJSlUl2g8+DyroH?=
 =?iso-8859-1?Q?5Zlz4ST+ohKjeCmTnPbeo3YDnLSfIKr/PTsJNF6HyxVaRyceOUeFIg0cRy?=
 =?iso-8859-1?Q?2k263+Io+LnAtJXvoK2bzPWIwpR+BwIf1/LDajYikMXM5FqPz+dzdhBD2+?=
 =?iso-8859-1?Q?bxovNdFMVo9dmpR5apY7KdUqOWlO6JDfLpHGfxdHCYLVwo7jzuYCtD/jB0?=
 =?iso-8859-1?Q?55u40xgnQfJEi8fdT3RqBejA7RjypD3ISI35Va4Nm9kX3Pq5pE2I4/gBN7?=
 =?iso-8859-1?Q?uwtvPfKjGKeLaJu6n2QtbGVkwruZTlKoi5vtgcnyOx3Hq1VrcJ26OwNWZl?=
 =?iso-8859-1?Q?KXXYTinh+xa2Ydu1oPWmGeIlEfWEf8LX/Lldv5bCLzgFaNvqNPYAmWRiuu?=
 =?iso-8859-1?Q?pocvq99BC2oaRealQdke+bu4Y9PwIM0n8LYztG9glybJ554avRSXLfJ9or?=
 =?iso-8859-1?Q?D+2ksQr8WD2mAwsEuWZY/SldkHFGglthrhH69DM/rnty9QrWH9Alxf7/xo?=
 =?iso-8859-1?Q?68XKxMDiAdwlHQwzoaezDX9axJmIFK2wwgIwJr3tuOXxzltHfEymeOujqN?=
 =?iso-8859-1?Q?F2rL52znXyOmoQqO+9auj/qjSbrx6toyUkm4aomnhQ1+P4KW1UpapQEliR?=
 =?iso-8859-1?Q?s6fRZIOb0T2O0Z0cXvdIVf7VkYBajOvjdbqR1pBCzc7sbwQLHfckVwRYiV?=
 =?iso-8859-1?Q?6ANeADaNofvDXllQB3lh1APZCucAqJALQ5oHYLNFhKZ9ss330Pg5KjXgN+?=
 =?iso-8859-1?Q?/0iL3TZlf/9QhhDpvDiyN/mRbqnvX+dJgLd7ftjJHeRdpgChsNFcjMelD9?=
 =?iso-8859-1?Q?zjbHsX6MUrr0kCQrbR9HtkHDPBd8EIn2OW2NESrxfSFCp+XNwmyHv10KcY?=
 =?iso-8859-1?Q?/8PpthL7lzBmoDwqeSLhFtQ25rWo9MQxvNOYVkg/EHUrnWZINFsPEU1FyA?=
 =?iso-8859-1?Q?A0o7KfnY8IYH3D9J9Rw3oDM8OvnVtljGPUPhb3Dh2c1B4EjJ8LRoWluijL?=
 =?iso-8859-1?Q?IxRjdzIK5io+CoALVRyKTa7vD+ugPkQkI4+JnFFF2lS3lq3+Y1k97v03TP?=
 =?iso-8859-1?Q?mhYyzezRBARY1pvkWdS3bZeTG1WobgB2gCQwiRv/cZ4rblPIxU4WKsYbUM?=
 =?iso-8859-1?Q?dqPJEjNyGOu86kSL5GGQ4/ud8whW9HAdvEgEYsOha5V6BjRJ+iYTKu77rD?=
 =?iso-8859-1?Q?eRglXzzXlv64QUeePT1Q474B7gwgmo+Jaj7P06y6sS+HxCnXREISamKPcZ?=
 =?iso-8859-1?Q?B5kzUfGKkLjte3CCGrxzRWoV5R15nkxGP2ZEW2he/j8scsERAB0+BwpJGl?=
 =?iso-8859-1?Q?TZ4SMsKFgaZ9eaMXwp5jNfjiuUM8KjivhM9MKyp02cYwrwH1D3CtZcxbHa?=
 =?iso-8859-1?Q?5YQm5ePLRbt9WXbLnbxdPi/Bw3kY3MsPfbFbSn7G5Fun57Jx1BdFpqKl4d?=
 =?iso-8859-1?Q?mX/2W09lbGr0DEuyUydQ5B1qk20Xm5jHeaLEKBWUnHAtmoCEQ4KOnTur9f?=
 =?iso-8859-1?Q?tjdqyLilwhfVMIr76dGcmZpTLWLym/fayKJtQXuFQYZCbAdvTluvdfKyyo?=
 =?iso-8859-1?Q?279wQROWsUqqu7zFqg0PIW56Dvi7LIIgUmIFTwNhvJoY6IGZSmM6XAVJsI?=
 =?iso-8859-1?Q?YJbQr37I57bCR4dhLdanJOZfkwg6nyulQWhjWKPhH7StahMK7Js92Ut9fG?=
 =?iso-8859-1?Q?eRL5spJ72Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MmJ61n+GuFT0UoraZbZc8j8FipggYk+T9nuG9SSLarrrxAIrlHN7tooSTl0w2Xo+wvYZJI6ZVI/fBYloJNV38syGGOQ9oV2WWxUuUlo4LJUn7/LQoT+u1NtFFyc5DJ3hiIUjo06cHVghLZ9c0IsLEoklH5s5CJ1vuL/zxWWgg7DsJmW+aYhWhA3pRUVnzAo0h0nIladsIbQXfLmJjUmUtM+2JrcDpbX3oRSIo8XccEiNbLNLVO2ELx4oq8G+9Noct7rTyITEuIWVciaOxKw16VcBHxn3/E92gssHJTlkoLZ8denOuCf002ne5TC3vxcZZSLxlpom9A2LKN86sdB8UQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1774cbc8-aa59-4dd4-7b65-08df07d2e154
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 02:44:01.4293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4/Vz7J/iuZ6/qCgMd/M+Hq8hrVslXAji3x+sCwW4vdbnDsYO5EIGeT8X4+4e6sofI9Tzu3XgV1ZTy7r6+03XePhsjpCleviNBhNu+JENlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI4PR06MB8448
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This series adds a QEMU model for the ASPEED USB Device Controller (UDC),=
=0A=
driven by the Linux "aspeed_udc" gadget driver.=0A=
=0A=
It is the first step of a larger plan to model USB device-side support on=
=0A=
ASPEED BMC/BIC SoCs, which has three goals:=0A=
=0A=
1. Model the ASPEED UDC (AST2600 / AST1030). The AST2600 also has USB host=
=0A=
   (EHCI) controllers, so this series targets the AST2600 UDC: its gadget c=
an=0A=
   be attached to the SoC's own EHCI bus, letting the guest enumerate its o=
wn=0A=
   gadget and exercise the UDC end-to-end.  [this series]=0A=
=0A=
2. AST1030 UDC. The AST1030 has no USB host controller, so testing its UDC=
=0A=
   needs a second QEMU instance. The plan is to redirect the UDC gadget out=
=0A=
   of the guest using libusbredir and attach it to another QEMU that runs a=
=0A=
   USB host (a VMM, or an AST2600 / AST2700 guest).  [on-going]=0A=
   =0A=
3. ASPEED vHub, as a longer-term goal towards BMC KVM / Virtual Media suppo=
rt=0A=
   in QEMU.  [future]=0A=
=0A=
This series implements goal 1 only.=0A=
=0A=
Design=0A=
------=0A=
The UDC is modelled as two QOM objects, because a single object cannot be=
=0A=
both a SysBusDevice and a USBDevice:=0A=
=0A=
  - "aspeed.udc": the sysbus device (MMIO register map, IRQ and DMA engine)=
=0A=
    that the guest gadget driver programs.=0A=
=0A=
  - "aspeed.udc-gadget": a user-creatable USB device presented on a USB hos=
t=0A=
    controller's bus. It links back to its controller through the "udc"=0A=
    property.=0A=
=0A=
The SoC creates the controller; the gadget is added on the command line, e.=
g.=0A=
=0A=
  -device aspeed.udc-gadget,udc=3D/machine/soc/udc=0A=
     =0A=
Test result:=0A=
-----------=0A=
The default ASPEED SDK prebuilt image does not enable the UDC driver, so=0A=
build a kernel with CONFIG_USB_ASPEED_UDC=3Dy first.=0A=
=0A=
Start QEMU with the gadget attached to the on-SoC EHCI:=0A=
=0A=
  qemu-system-arm -machine ast2600-evb -drive file=3D<image>,if=3Dmtd,forma=
t=3Draw \=0A=
      -device aspeed.udc-gadget,udc=3D/machine/soc/udc -nographic=0A=
=0A=
In the guest, bring up a mass-storage gadget and verify enumeration and I/O=
:=0A=
=0A=
1. Before: only the host controllers are present=0A=
root@ast2600-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20=
-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4=
a22b-dirty uhci_hcd Generic UHCI Host Controller=0A=
=0A=
2. Enable the gadget=0A=
root@ast2600-default:~# ./usb-storage.sh=0A=
Using UDC: 1e6a2000.usb=0A=
[  598.582205] Mass Storage Function, version: 2009/09/11=0A=
[  598.582635] LUN: removable file: (no medium)=0A=
USB Mass Storage gadget is enabled.=0A=
Backing file: /home/root/jamin=0A=
root@ast2600-default:~# [  598.876395] usb 1-1: new high-speed USB device n=
umber 2 using ehci-platform=0A=
[  599.070035] usb 1-1: New USB device found, idVendor=3D1d6b, idProduct=3D=
0104, bcdDevice=3D 1.00=0A=
[  599.070821] usb 1-1: New USB device strings: Mfr=3D1, Product=3D2, Seria=
lNumber=3D3=0A=
[  599.071448] usb 1-1: Product: ASPEED USB Storage=0A=
[  599.072687] usb 1-1: Manufacturer: ASPEED=0A=
[  599.073384] usb 1-1: SerialNumber: 1234567890=0A=
[  599.103625] usb-storage 1-1:1.0: USB Mass Storage device detected=0A=
[  599.136326] scsi host0: usb-storage 1-1:1.0=0A=
[  600.230921] scsi 0:0:0:0: Direct-Access     Linux    File-Stor Gadget 06=
18 PQ: 0 ANSI: 2=0A=
[  600.243758] sd 0:0:0:0: Attached scsi generic sg0 type 0=0A=
[  600.263452] sd 0:0:0:0: Power-on or device reset occurred=0A=
[  600.289381] sd 0:0:0:0: [sda] 2048 512-byte logical blocks: (1.05 MB/1.0=
0 MiB)=0A=
[  600.297896] sd 0:0:0:0: [sda] Write Protect is off=0A=
[  600.306379] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled,=
 doesn't support DPO or FUA=0A=
[  600.424608]  sda:=0A=
[  600.425526] sd 0:0:0:0: [sda] Attached SCSI removable disk=0A=
=0A=
3. After: the gadget enumerates on the EHCI bus=0A=
root@ast2600-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20=
-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller=0A=
Bus 001 Device 002: ID 1d6b:0104 ASPEED ASPEED USB Storage=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4=
a22b-dirty uhci_hcd Generic UHCI Host Controller=0A=
=0A=
4. Mount and verify data=0A=
root@ast2600-default:~# mount /dev/sda /mnt/=0A=
root@ast2600-default:~# sha256sum /mnt/testfile=0A=
3308890a1289f6a327c014537523e8ebd0833301af3d25a7c5893dc7050d2c70  /mnt/test=
file=0A=
root@ast2600-default:~# umount /mnt=0A=
=0A=
5. Stop the gadget -> clean disconnect=0A=
root@ast2600-default:~# ./usb-storage.sh stop=0A=
Stopping USB gadget...=0A=
[  669.866439] usb 1-1: USB disconnect, device number 2=0A=
Stopped.=0A=
root@ast2600-default:~# [  669.968156] sd 0:0:0:0: [sda] Synchronizing SCSI=
 cache=0A=
[  669.969307] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result: host=
byte=3D0x01 driverbyte=3DDRIVER_OK=0A=
=0A=
root@ast2600-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.20=
-dirty-32e49fb4a22b-g32e49fb4a22b-dirty ehci_hcd EHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.20-dirty-32e49fb4a22b-g32e49fb4=
a22b-dirty uhci_hcd Generic UHCI Host Controller=0A=
=0A=
=0A=
The contents of this scripts=0A=
---------------------------=0A=
root@ast2600-default:~# cat  usb-storage.sh=0A=
#!/bin/sh=0A=
set -e=0A=
=0A=
G=3D/sys/kernel/config/usb_gadget/g1=0A=
IMG=3D/home/root/jamin=0A=
SIZE_MB=3D64=0A=
=0A=
mount_configfs()=0A=
{=0A=
    mountpoint -q /sys/kernel/config || mount -t configfs none /sys/kernel/=
config=0A=
}=0A=
=0A=
get_udc()=0A=
{=0A=
    ls /sys/class/udc | head -n 1=0A=
}=0A=
=0A=
stop_gadget()=0A=
{=0A=
    if [ ! -d "$G" ]; then=0A=
        return=0A=
    fi=0A=
=0A=
    echo "Stopping USB gadget..."=0A=
=0A=
    # Unbind UDC first=0A=
    if [ -f "$G/UDC" ]; then=0A=
        echo "" > "$G/UDC" 2>/dev/null || true=0A=
    fi=0A=
=0A=
    # Clear backing file to release image=0A=
    if [ -f "$G/functions/mass_storage.0/lun.0/file" ]; then=0A=
        echo "" > "$G/functions/mass_storage.0/lun.0/file" 2>/dev/null || t=
rue=0A=
    fi=0A=
=0A=
    # Remove function link from config=0A=
    rm -f "$G/configs/c.1/mass_storage.0" 2>/dev/null || true=0A=
=0A=
    echo "Stopped."=0A=
}=0A=
=0A=
start_gadget()=0A=
{=0A=
    mount_configfs=0A=
=0A=
    UDC=3D"$(get_udc)"=0A=
    if [ -z "$UDC" ]; then=0A=
        echo "ERROR: No UDC found in /sys/class/udc"=0A=
        exit 1=0A=
    fi=0A=
=0A=
    stop_gadget=0A=
=0A=
    echo "Using UDC: $UDC"=0A=
=0A=
    modprobe libcomposite 2>/dev/null || true=0A=
=0A=
    mkdir -p "$G"=0A=
    cd "$G"=0A=
=0A=
    echo 0x1d6b > idVendor=0A=
    echo 0x0104 > idProduct=0A=
    echo 0x0200 > bcdUSB=0A=
    echo 0x0100 > bcdDevice=0A=
=0A=
    mkdir -p strings/0x409=0A=
    echo "1234567890" > strings/0x409/serialnumber=0A=
    echo "ASPEED" > strings/0x409/manufacturer=0A=
    echo "ASPEED USB Storage" > strings/0x409/product=0A=
=0A=
    mkdir -p configs/c.1/strings/0x409=0A=
    echo "Mass Storage" > configs/c.1/strings/0x409/configuration=0A=
    echo 120 > configs/c.1/MaxPower=0A=
=0A=
    if [ ! -f "$IMG" ]; then=0A=
        echo "Creating backing image: $IMG"=0A=
        dd if=3D/dev/zero of=3D"$IMG" bs=3D1M count=3D"$SIZE_MB"=0A=
        mkfs.vfat "$IMG"=0A=
    fi=0A=
=0A=
    mkdir -p functions/mass_storage.0=0A=
=0A=
    # Make sure old LUN is detached before changing attributes=0A=
    echo "" > functions/mass_storage.0/lun.0/file 2>/dev/null || true=0A=
=0A=
    echo 0 > functions/mass_storage.0/stall=0A=
    echo 0 > functions/mass_storage.0/lun.0/cdrom=0A=
    echo 0 > functions/mass_storage.0/lun.0/ro=0A=
    echo 1 > functions/mass_storage.0/lun.0/removable=0A=
    echo "$IMG" > functions/mass_storage.0/lun.0/file=0A=
=0A=
    ln -sf functions/mass_storage.0 configs/c.1/mass_storage.0=0A=
=0A=
    echo "$UDC" > UDC=0A=
=0A=
    echo "USB Mass Storage gadget is enabled."=0A=
    echo "Backing file: $IMG"=0A=
}=0A=
=0A=
case "$1" in=0A=
    start|"")=0A=
        start_gadget=0A=
        ;;=0A=
    stop)=0A=
        stop_gadget=0A=
        ;;=0A=
    restart)=0A=
        stop_gadget=0A=
        sleep 1=0A=
        start_gadget=0A=
        ;;=0A=
    *)=0A=
        echo "Usage: $0 {start|stop|restart}"=0A=
        exit 1=0A=
        ;;=0A=
esac=0A=
=0A=
=0A=
v1:=0A=
  1. Add ASPEED UDC device controller=0A=
  2. Add ASPEED UDC gadget USB device=0A=
=0A=
v2:=0A=
  1. Replace dynamic memory allocation with fixed-size arrays.=0A=
  2. Use an OR gate to route the interrupt signals from the UDC and EHCI2.=
=0A=
  3. Split the "Add ASPEED UDC gadget USB device" patch into two patches:=
=0A=
    a. Add ASPEED UDC gadget USB device=0A=
      Implement EP0 control transfers.=0A=
    b. Add programmable endpoint DMA transfers=0A=
      Implement DMA transfers for programmable endpoints.=0A=
  4. Remove unused macros.=0A=
  =0A=
v3:=0A=
  1. Remove unused macros.=0A=
  2. Bind the gadget to the controller via a QOM link property=0A=
   ("usbgadget", weak) instead of writing the back-pointer directly=0A=
=0A=
v4:=0A=
  1. Move the "select USB" dependency to the appropriate patch.=0A=
=0A=
Jamin Lin (4):=0A=
  hw/usb/aspeed-udc: Add ASPEED UDC device controller=0A=
  hw/usb/aspeed-udc: Add ASPEED UDC gadget USB device=0A=
  hw/usb/aspeed-udc: Add programmable endpoint DMA transfers=0A=
  hw/arm/aspeed_ast2600: Wire up the UDC=0A=
=0A=
 include/hw/arm/aspeed_soc.h |    4 +=0A=
 include/hw/usb/aspeed-udc.h |   85 +++=0A=
 hw/arm/aspeed_ast2600.c     |   37 +-=0A=
 hw/usb/aspeed-udc.c         | 1059 +++++++++++++++++++++++++++++++++++=0A=
 hw/arm/Kconfig              |    1 +=0A=
 hw/usb/Kconfig              |    4 +=0A=
 hw/usb/meson.build          |    1 +=0A=
 hw/usb/trace-events         |   16 +=0A=
 8 files changed, 1204 insertions(+), 3 deletions(-)=0A=
 create mode 100644 include/hw/usb/aspeed-udc.h=0A=
 create mode 100644 hw/usb/aspeed-udc.c=0A=
=0A=
-- =0A=
2.53.0=0A=

