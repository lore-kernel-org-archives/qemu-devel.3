Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28BEF433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsF-0008CL-E0; Wed, 15 Apr 2026 21:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrc-0007qt-88; Wed, 15 Apr 2026 21:49:53 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrZ-0007Ut-Es; Wed, 15 Apr 2026 21:49:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUYBmH/AAsXtX/FGHHHaKhHafScZlKXK7EgKl8NjM5X9tjkrTsgDZ3Qzydk9FYrfVf5LMb2Llg8T7cMsLvHt68NPko+oOIX/VWvPmiUJUFsEcWnJr4UDbh7ToF/Wu/QkLriHY6Xs+B7A3UoWUk2/M8BuQikC/78CRcvIrrOsbyKSFfmf4YA6oCgNs7TpcHQkHZWqlREQxeF6vY8AFwc3tHFZPQXEuBcZjBjdzO0fh0yPODACeLltqqVqQUMWb64g1ofUpXQosuI2XbghalXm/bRolbeEUVkq0TcyF5eGSqRMa4RUHouQj6J7UHDSeVMRiQathhH0KVd6Zl0qGMRsXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wa/emd/PJjKs9wMs6ydHNAYi0NcHOXOuM8AUwXVXJHo=;
 b=ZbXYKIPrKKvqXb74zNCrPACHllE2wXR0OblrPtLegltBopIMLEwElfQeF1cbr30hWAOTEMfCZoxLxCXdpmdhs/DRf1swhDRBJr7IrofLQ0M9T0eNntsyu64o6nG8MP0aj3GVAlKh0aUiNm9onhT2uXEG9JyfKBvKf2gYNhMIk9WSuS2NhB1kR04WvYdMPfivlarMJvUJyPP4nmzwcXajhwGce4yJg1I170dW0g18S2LfOzQIuvKa+ghv4B7Ztb0Ulp+oYVL7OG5QfckS3efjXbUE1HHBymtUwR57ZvNJMXQ/1ku0VQq3RwUtC1q+aZpRLpmFgBGCWbx/cSFkxNE59g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wa/emd/PJjKs9wMs6ydHNAYi0NcHOXOuM8AUwXVXJHo=;
 b=TR2AsKLRGCAptcZZQ9qK6i8XJ0V16+apJk1mL5jtPCYvlTLGNTsyqk3RAmqxZ6aBBnQpL0C1GAnSYX2I9GLZ+OY7dqruyXBPxSolcIlEAJoYC/ifqNZyAMgu7Wm20xeU4+r5NLObWk7AyJ4cXSXNxGEnoQ4C9a6k6eELyu4dqzFu1Q3LPRrhMox1AOwCMzrvL0bfXsapn6uM6440NqXSwR3uNxPFhmXrp+fI3qmlMPwtYZ6PgRv+6I83N40qK2wQV04g+5RAGX7A2NXz6z6lHZ7RcndwQitlK99LLyOtJzAsgq/8pBfRKuDUEeTldbBg9azWtR+jap/+l/qmmPB6Dw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:31 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:30 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 00/17] hw/usb/ehci: Add 64-bit descriptor addressing support
Thread-Topic: [PATCH v3 00/17] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHczUNDyQn0rzVUo0SoQKZT1U/UZg==
Date: Thu, 16 Apr 2026 01:49:29 +0000
Message-ID: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: d74ffba8-756e-4166-dc9d-08de9b5a6665
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|56012099003;
x-microsoft-antispam-message-info: AS938qfTdRaAYCq6DMGMz+gnH4fndw2SNmxdEPvvAaNIfxchcv8Md8PFFvlcpTzySz2jKmbX1rJF1lzPWQ0Hy08Yg8MA9QrTezrGKLOp223/662O+ZTonR6XI+tZaSvp7UMX/NzDmzoAtGDgSifrmbYd2cqgswRIJc+4rl9zijuOfIM/+ru0waDPrxSAnkMdLERZo/X+qTkyxw4gJx7NyVe3UZ5tmsWcw0IVR8AB5TnQm5zz+qawtEvcto/MgL6NMmIK6C0q2AzZljaNpEqzykiZngY6rPNX6LlKmcGnH2jcth6HkjYrVEq9xxlXYOh2NwazS+YKRTPdBQddU3d6NjzwyXvMWSUxLW4tPr4zUot35sD3OXrarSwXPKKpHX2y9y8VqLcbcQ6bEY04Q/+NsMH4UYIRhI3QaZQXqtrDCCmEKufE3XYPj5Z6MqOYk2qfrblPECchJrmpORjMG7hZcIxjhrb1o0P4xDyd3PSJ7XKkCBwfDM3GfEsTv5MRnJ7jKkWgRpzE+dF+xaocAB1sa4dl22f0o7VUDtLZmW7qCb/iUVnj5gsrsoZ4MnUfpXI5FQz6vZD+cFP9kbGkUMZzy9Mx6Y47icSKYfAuRTT5XCQTCJ2aJYwKfHJdgTKHZI82h+9EB7g+39qGBOU0Bnmyn+jNhqxFd8Qr6SWia700uwYtrYvmUzup8hH3Zva3dLp+Gw5RMULkIEz3VnT9lYsw+moNhUC1fZpbTRpUk9yRAwakrPaQ260Io8Rd53gcCSQ/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zl4NW5vQG6pNFEt7y8yNJes3FMR8DzeaMbvCiFJGfJcGsnWA+NWnCJF8ft?=
 =?iso-8859-1?Q?6cZMAM8Ooef+U9gFoXc7EysyW2o9s0tdqUVJimZuZ0Fa8vT2JQth6JyCfr?=
 =?iso-8859-1?Q?/3aqBAkLkH11Khy1iq+TZx+Zu83N1Nx+v46ZdzTyj50hSlq6Ex6/e+6qcF?=
 =?iso-8859-1?Q?E+3uU5svvDvWhrNJI1952rNoq37ifIRmWQbq1N3p5JaljlvSh41oGp91yx?=
 =?iso-8859-1?Q?wuZCiDW4MIjYh5IIBZVsQK+v8NYKHS7IjXaiux4wHVc1I9wTjgs6qCB/xA?=
 =?iso-8859-1?Q?GyOo672Le2JqttDFPp+Lrqn+tjsJMkwPhNReWs6yqSklUKCa/Q6oUCRY/d?=
 =?iso-8859-1?Q?f1mI7ju02HRk7IpWiUizUYDEvZYUQ46xs3tKuNAwi1s6u5XGfXxIAf1N2F?=
 =?iso-8859-1?Q?bSbVhiI4VvegoovGwIcWIxdsEuQWWU91qfgOIAfsX7eixUb2p9N+U5uafU?=
 =?iso-8859-1?Q?GPfn73pPi3TtoHjWwVSRfJcHoScs3feFWCidYzcSXaqmHTpEy5aBEC3EBF?=
 =?iso-8859-1?Q?dshqROchQkiAM8pMlMY4WASVIM36jHyt2aqjpy2c4/smw3VyLIXT+HlQrq?=
 =?iso-8859-1?Q?eQbUN5JAUfotQ2o1tDaXAq/qkBuFjXlDM33AsJQAcqdFp4q77fYy/PLhEW?=
 =?iso-8859-1?Q?Nt/OwdualXRkeJEJh9a6qj/br0nvjZzHmHh3clITfw8WkGK7Kt6hQfvY4M?=
 =?iso-8859-1?Q?bo15h4q5USi8l9AJjyyEsIm2AlMr+JlHg2SiAOcrVjY5Gq5iKSYIO9CDOd?=
 =?iso-8859-1?Q?3BfijbytSrmDqPYyuxsP368frbDFELp2LqEmnOqkGQ2dXoqeFxpELScWX9?=
 =?iso-8859-1?Q?W98kVkddk9iePiZZcOqXTgrM+WxgJl92SlckfDkwvmHBrWwlcrkEV4u1Mx?=
 =?iso-8859-1?Q?a6JNvBX4J0AuS0RPS7sfhMpWGq0pC0vYS0lYWgamS0OITbd40iYXyYL5Z2?=
 =?iso-8859-1?Q?HQhLKxAYmpf/ep1cAIaWCTTg++K0jrxHzajjISn0RewKd18bY74scCgJyU?=
 =?iso-8859-1?Q?D4haoZpoTXi0JnUx3g14rFTpD7q6rM4G+1FqzTsRtxwIO74Qvxx4eHBK1P?=
 =?iso-8859-1?Q?K/nSXaAa1C7aG6sDf6wJi1CRADFiD0Twl6lSpjlvYwdmTGEi52W+vExqSn?=
 =?iso-8859-1?Q?NSAWpFoGucrVPSIje3UCnjeqQY8vlbgW8K6hvyNMvJgn6UZpsxRMt6JlxT?=
 =?iso-8859-1?Q?BSDhRoquw9+b43FuqXiItxs28ADyTdzfb2ni9u1xIF7Xsp2qX+AF4auCKq?=
 =?iso-8859-1?Q?qPrhl6Ll+sFZ1vWoCtXyvcCEp3sisDIrxe09TN0Nnv2EBZO5/8bv5+QfAy?=
 =?iso-8859-1?Q?rdcF3aKXIJfTLmjNU6XcIi9TuO4D6+GrMK1dShvuuopdnEmMiCiIY2yP7Z?=
 =?iso-8859-1?Q?+QYVyC2aqUXvtJAteMQtmN0ffiZcGfiPJHEbaBr9L6AfiwqGm7mC1sl5Ox?=
 =?iso-8859-1?Q?PJDGr4qDyXHVkGTC+QTcB+OSngdz2PkCRqSpBIRT+hGWUVNoCYtH3qOFhN?=
 =?iso-8859-1?Q?fEoY3nZe0gIdZ8fLkp+Qd8WQyaYrsL0r+lkYSXko4ky7dwsKpuoIem5iHv?=
 =?iso-8859-1?Q?NvV9JFzcfmxLWY6CC93/UCwdh4hrDi3FzUStAgD5qQjJsXGQ3HH5OsEHkj?=
 =?iso-8859-1?Q?esYk16+cr8RmD3IfKjw4QTcA8HFsC/xNmYyCTsmB+2MmcWrIe+ezCuxANt?=
 =?iso-8859-1?Q?jU70eQpovg6qj949sINLYtx6wNRzKCXyPGc0VxtVygF7sZyRiR6x3K1t97?=
 =?iso-8859-1?Q?zQjU+s05sgiBdP+bFWvhb3o0HrPQgAw0yiVVz/TvVHPeGzvJZfzzH0XwXY?=
 =?iso-8859-1?Q?mQ+u5qUM6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: e3L7joKkkLXqPBwsiNA7ziSsLSA0bff/o5uJEEqbc/HaNnKjr0gsB1AfjPOxzrqgp4ARPB8u3S23mpDjyOsB0GMafwo5B2XfZ5SLv9KzrXOf1VTcn3iJybi8QowKVEETT/x6N+TuCnK/yLhkeFrSIj96wLanNATxQ2mSSBMgBeJd+DnIz0KJVPviOKyNm3Y4rl5Cj9tih3f2PZIZkKPS8T55G4I0ZgwkJiRUKfU5NBInlGpK5L63wqjwxA8+d1MOCv/mxEwsPRu7m/AfWfo+I/ZYRuXHbPLVT8klY7F6Q1z0iroPcac06Hql6zBGzNkwLdzXjz8+ovn08FsCtWpDtg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74ffba8-756e-4166-dc9d-08de9b5a6665
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:29.9970 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kyDpDipWUZyo4xVz4tIubge85bFSa5yLeCHztHnwBsBzoQ0bnJwwLwhDPzLyOBYxI8li0/rkrai7yVSvLTNJLwwvYGhCNrhRnt0999ccdhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
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

EHCI supports 64-bit addressing through the CTRLDSSEGMENT register,=0A=
which provides the upper 32 bits of descriptor addresses when the=0A=
controller advertises 64-bit capability.=0A=
=0A=
Currently QEMU EHCI model only partially supports this functionality and=0A=
descriptor addresses are effectively treated as 32-bit. This becomes=0A=
problematic on systems where system memory is located above the 4GB=0A=
boundary.=0A=
=0A=
The Linux EHCI driver enables 64-bit addressing if the controller=0A=
advertises the capability. During initialization it programs the=0A=
segment register to zero:=0A=
=0A=
  https://github.com/torvalds/linux/blob/master/drivers/usb/host/ehci-hcd.c=
#L600=0A=
=0A=
The driver also notes that descriptor structures allocated from the=0A=
DMA pool use segment zero semantics. Descriptor memory is allocated=0A=
using the DMA API and platforms may configure a 64-bit DMA mask,=0A=
allowing descriptor memory to be placed above 4GB.=0A=
=0A=
On AST2700 platforms, system DRAM is mapped at 0x400000000. As a=0A=
result, descriptor addresses constructed directly from the EHCI=0A=
registers do not match the actual system addresses used by the=0A=
controller when accessing queue heads (QH) and queue element transfer=0A=
descriptors (qTD).=0A=
=0A=
This patch series implements full 64-bit descriptor addressing support=0A=
in the EHCI emulation. Descriptor address handling is updated to use=0A=
64-bit values and the descriptor structures (QH, qTD, iTD and siTD)=0A=
are extended to support the upper address bits provided by the segment=0A=
register.=0A=
=0A=
In addition, a descriptor-addr-offset property is introduced so=0A=
platforms can apply an address translation when descriptor memory=0A=
resides above the 4GB boundary.=0A=
=0A=
The AST2700 machine uses this property to account for its DRAM mapping=0A=
at 0x400000000 and enables 64-bit EHCI DMA addressing.=0A=
=0A=
Test Result:=0A=
1. EHCI 32bits with ast2600-evb machine=0A=
Command line:=0A=
./build/qemu-system-arm \=0A=
  -machine ast2600-evb \=0A=
  -m 1G \=0A=
  -drive file=3Dimage-bmc,if=3Dmtd,format=3Draw \=0A=
  -nographic \=0A=
  -device usb-kbd,bus=3Dusb-bus.1,id=3Dmykbd \=0A=
  -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
  -device usb-storage,bus=3Dusb-bus.1,id=3Dmystorage,drive=3Dusbdisk=0A=
  -snapshot \=0A=
  -nographic=0A=
Result:=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0002 Linux 6.18.3-=
v00.08.01-g172b7e27a30d ehci_hcd EHCI Host Controller=0A=
Bus 001 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 001 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
Bus 002 Device 001: ID 1d6b:0001 Linux 6.18.3-v00.08.01-g172b7e27a30d uhci_=
hcd Generic UHCI Host Controller=0A=
=0A=
2. EHCI 64bits with ast2700a2-evb machine=0A=
Command line:=0A=
./build/qemu-system-aarch64 -M ast2700a2-evb -nographic\=0A=
 -bios ast27x0_bootrom.bin \=0A=
 -drive file=3Dimage-bmc,format=3Draw,if=3Dmtd \=0A=
 -snapshot \=0A=
 -device usb-kbd,bus=3Dusb-bus.3,id=3Dmykbd \=0A=
 -drive id=3Dusbdisk,if=3Dnone,file=3Dimage0.ext4,format=3Draw \=0A=
 -device usb-storage,bus=3Dusb-bus.3,id=3Dmystorage,drive=3Dusbdisk=0A=
Result:=0A=
root@ast2700-default:~# lsusb=0A=
unable to initialize usb specBus 001 Device 001: ID 1d6b:0001 Linux 6.18.3-=
v00.08.01-g172b7e27a30d uhci_hcd Generic UHCI Host Controller=0A=
Bus 002 Device 001: ID 1d6b:0002 Linux 6.18.3-v00.08.01-g172b7e27a30d ehci_=
hcd EHCI Host Controller=0A=
Bus 002 Device 002: ID 0627:0001 QEMU QEMU USB Keyboard=0A=
Bus 002 Device 003: ID 46f4:0001 QEMU QEMU USB HARDDRIVE=0A=
 =0A=
v1=0A=
 1. Fix checkpatch coding style issues=0A=
 2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors=0A=
 3. Add descriptor address offset property=0A=
 4. Enable 64-bit EHCI DMA addressing on AST2700=0A=
 5. Configure descriptor address offset for AST2700=0A=
=0A=
v2=0A=
 1. Remove unused EHCIfstn structure and dead code=0A=
 2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)=0A=
 3. Replace DPRINTF debug logs with trace events=0A=
 4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2=0A=
 5. Fix review issue=0A=
=0A=
v3:=0A=
 1. Add Migration version test function=0A=
 2. Add EHCI 64-bit buffer pointer fields description in commit log=0A=
=0A=
Jamin Lin (17):=0A=
  hw/usb/hcd-ehci: Remove unused EHCIfstn structure and dead code=0A=
  hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with=0A=
    qemu_log_mask(LOG_GUEST_ERROR)=0A=
  hw/usb/hcd-ehci: Replace DPRINTF debug logs with trace events=0A=
  hw/usb/hcd-ehci: Change descriptor addresses to 64-bit=0A=
  hw/usb/hcd-ehci: Add property to advertise 64-bit addressing=0A=
    capability=0A=
  hw/usb/hcd-ehci: Reject CTRLDSSEGMENT writes without 64-bit capability=0A=
  hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Add descriptor address offset property=0A=
  hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing=0A=
  hw/arm/aspeed_ast27x0: Set EHCI descriptor address offset=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for=0A=
    AST2600 SDK=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for=0A=
    AST2700 A1/A2=0A=
=0A=
 hw/usb/hcd-ehci.h                             |  55 ++-=0A=
 hw/arm/aspeed_ast27x0.c                       |   5 +=0A=
 hw/usb/hcd-ehci-pci.c                         |   4 +=0A=
 hw/usb/hcd-ehci-sysbus.c                      |   4 +=0A=
 hw/usb/hcd-ehci.c                             | 378 +++++++++++-------=0A=
 hw/usb/trace-events                           |  25 +-=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   7 +=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   7 +=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +=0A=
 9 files changed, 301 insertions(+), 191 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

