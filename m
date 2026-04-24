Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2806FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXU-0004oi-7L; Fri, 24 Apr 2026 04:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXQ-0004oI-9f; Fri, 24 Apr 2026 04:05:24 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXJ-0001Eb-JF; Fri, 24 Apr 2026 04:05:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ1Bah7GTse3DnG/B3l6VnbTdGd+GUqIQk3hMNyfqTjxl7yEVjI9k75vBciO2dpU4ibyz573HCbiTTnUFhvrkvjVWot7oWd63UNo6/5ZWSnI2lmgTvhIMDrhnLp1mGG/2Gnhg3P1KzLqqxg17FAowSpqZf5ez+R5h/k9dirG0i3Yrt762ySEa/sQ8BTYgAO1r20yNzUkLFki08jGjIKD6t9YL93O1BgTJNmWFLob+G80KxNxJUs5fotorHWffQk0lCyI+T3esP9/W03GsylcnokK5wi84/6RKokivUAsh676D/ey4Vqn3ukq0wXwzeKLnEtqzRZR4ILZeMAWMHAZkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm6vt3hAfAXmEe5kqhpupkD5Le1r+KL3i5nCQPHnFB0=;
 b=diMSAeXGkMr24BPnHBBe899HlHeRwoD2p4DOQS4vzoRV2d+W8DRHKg0yNX9OaXYZJpe2/v3emZ8AXZwxJ55xLvRGLn0EIn9DFr49BMS/MJFBErjHipyFUj3HgEE+jt+NOX48uVgEd3Tnz+zc7LLLyyv25/CdQWcibo5v92I7jXLth1mgA1vxE3fZ0kssWxYMN625dIBf/t35/BMv9WW7nlfhT27274foVNtK0e3dddenk8M8Hs5N2qifGzUPkbMnJJAG1wzmIrbQf8ZPA+Sd9PcuOsN1fhgVHJ6/zPezMyFFk5EK4PPwP9igxUQYvdpMsTamzfqUaNYTGuMMkRw5zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm6vt3hAfAXmEe5kqhpupkD5Le1r+KL3i5nCQPHnFB0=;
 b=qZgWVsDSbpWlIT/xlKb3N8x8RAmHa6kVCIeNM03zoLxoZ1vA5LZO1cNx72hF4+NsKU7+gTHDKP+rOVoU/wLOv0/q4Zgo3jtXST6z+S6hkrNf9shO2iftRSxs8bDjR/rLh2zyu+WnmUag6OKrgZTQq++6VV28XURYWuQfOu/+vGvSApa0h+c+snPWs62kD5hJUak0oROlzI0l0GF30nhBldrxmdNAYeGJ+62MclrsD/KcPkyaHMaJo+H7Nt53uhQq7UvqEF8Wmzx7VPJR1ygm3H8CLlmjWkScx84rHyNgRTcV5q+mzk4PULXEylpa8+wkZmjwxsNYkzO1NHGCg6Jatg==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB5790.apcprd06.prod.outlook.com (2603:1096:101:b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:05:09 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Laurent Vivier <laurent@vivier.eu>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:sPAPR pseries"
 <qemu-ppc@nongnu.org>, "open list:S390 general arch..."
 <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 00/18] hw/usb/ehci: Add 64-bit descriptor addressing support
Thread-Topic: [PATCH v5 00/18] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Thread-Index: AQHc08ERDBq7Kcw9RE+yRUQsaiStsQ==
Date: Fri, 24 Apr 2026 08:05:08 +0000
Message-ID: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB5790:EE_
x-ms-office365-filtering-correlation-id: 39c8df92-043d-40b7-a895-08dea1d833fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021|18002099003|56012099003;
x-microsoft-antispam-message-info: Q9oz54E7h3jzRnQVGKIoUQ8PHwhqOmgU161jkn9LQGh6RQBF8w0xRbxGvlgR+hD8R7yUPNouxaBtZ4Q4M0dctRZOFveHRBFr2D8Agp6n/1xJMLciIvnJusawDah25RVrSe949wdGUaPA9EhBlDzq5/egWS6AeRYOOU1fV+SL7NzzGQaHjiGnmDSeSZJdIn+xL+tzhiOAXZmQvK3QTrhiyJnVGaK3uzp6YTa1SXY3uDFsfHPzrGOvpwEknKDOQI1Lrngr1v21nfZT96pxA2zs1F1aA7a/6e7jmvUbg7i7uttT+2IzRQuicbuD0ZGJuTxdXecYI8LVeZXu+0w3zygJ6G/I5QS75yUSQBButsS5V/re4JnaxrNr7qv9CIH56TJymVTQeaMuety20IlHW7ehK9K2w4xUvFU5bPnjY5NLV+3FIfmJadCZO2QCT0DWjwCPFtCPcr0QcsB8qYNsfzq+pBmwTICEDO0NZzXtE+/BENr/kpXo38R77WrQwemYx5HIxNfUB25w5fT0yDmYcpmAj8+MjIgIWY7GgR6n3xiv6Rt/5R4cwDs6OOK+jgxH59uAPnSKCPF4OYtMr7TdA6wtf4btPROAY3fJtFA4WJy4/n95GrFoFNeaMIv5jvaBVo/d3yFLgyPoV+j/lPFr0Evu249phKAsrSarv+qYg4gFy13z6P1ACW7o7WZ/wTPpm+N45+QfmEcYt4uQta120AbJJFBvB/h+MXCoyXPt2ctA/MIYsBj+tznwiuznx2tiVglKo9DZcNUzWgPAnQlzsM25yw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tqWZzt5TIFM+blDwA+yx9CysuIT0Ih9phGbpKBKxq0dRx45dBP1XsPSWNO?=
 =?iso-8859-1?Q?h2GN/b3vxWx5oKe7zVYf8aSTfFloF85nO8RCb/44y5ia07p02BcqxukT5V?=
 =?iso-8859-1?Q?PozeNWImXNDHVQQEbcuh2aHU1mN9ZIbCvoNeziH4vWRjdmgulrUi6frCYp?=
 =?iso-8859-1?Q?MzTsU3/UHl2kC/PtwHdac9Fj0OT0abPoFiz+D1AUITfpuwEHtAuNlKg/lL?=
 =?iso-8859-1?Q?EsDZI0NarJJO+l+XCxcxu8l/9O+OFMAgdGDIgNwLvuh0CXi8+13gUX6NeG?=
 =?iso-8859-1?Q?Jed7B+qHo1E8I2NhbSpcKQY9m2K2Pui4NnhFXy3aV+9b2j1m2DyePVB6Lz?=
 =?iso-8859-1?Q?mdvOvedIMuxny59uht58826BLiPugYGxeqLzAZ8OA6paOB8oDL369fsMcS?=
 =?iso-8859-1?Q?NmAWuoeVUgV/+kzyxwzCRDmptlO9LX0B8zYDEgDZ9mrYqPcdF+xCTtUi6e?=
 =?iso-8859-1?Q?1JVLeS3E6CSDBpxaQBAf59hu+h9mIpD5gav4BH7WIpEU0z8XcQcTuyo2r8?=
 =?iso-8859-1?Q?J4M+0qcw+G/azWlSGujH+H29KLB1KJdaLh1WrzxzjUnyU5RNrWffH13afi?=
 =?iso-8859-1?Q?vERGTTZN7y1MLmNqJM43npzkXoFp9a2eOHiU3Kb1/2LQfnBtzBOKHEPnuE?=
 =?iso-8859-1?Q?gMR9YCKP8eHKOcO1YDRVLvvi3jxUN3T17Kz4LHbZwe4BnCzxlsZoyfq7D2?=
 =?iso-8859-1?Q?44tLZFtjacQQ64swlXHBiNH2DSOFpHq9lsLgN/nTnLIRncLmHzsZn4lHjZ?=
 =?iso-8859-1?Q?AWebBuT1zb8Y3hNT2GQYU6uG5MOtIEKBtlOy1VuZofw9uPczg7pWxL14GP?=
 =?iso-8859-1?Q?p/IKqSo1kNTGLlhnQfsbzs0B4HIzihzElqirbxyLjKrv2uf7q5ofl01KQM?=
 =?iso-8859-1?Q?WvaKiMs8WDRUxkwyZKfOp+bQg9cdQSNbgnRl6H8G7bqRPcr1P0gS7oMn1V?=
 =?iso-8859-1?Q?9jB+Glrecoc23EoO+edEJKgPAv7XB5HHuxTFAA9kEVauHD9PTmxkfQP/WF?=
 =?iso-8859-1?Q?dZw6pWH9D/55hygV/5BOIQaZw0Rw0vgssEDpELwScdOgjXlxsNmOKJ2YQM?=
 =?iso-8859-1?Q?zMIvQ3j3IccjLn5v9T3yVI773OSLUHdJPUV6KKbb9fJIwwW9G029aqCWSC?=
 =?iso-8859-1?Q?1RJiCpX7+aAvUb7iS9/GEtXfY5CkNu9wFl4/pvcXNbIdqWjv1y8svn5tVo?=
 =?iso-8859-1?Q?JQakhMy4af2HO3M6DYENYzLIGrBpPz3YB7XMct2flVgTfmygZaKA6RaJZ3?=
 =?iso-8859-1?Q?ph46C+/nWVrprTAy/duh7kErsAMa/jUPpO0riDL9C1an2CDpH4g1Z5JN3O?=
 =?iso-8859-1?Q?XXKbHJY66j/gZWlO7kHn2Nvr/fgqggBWM1btcq+F1XXr+soEwvdmm27k0v?=
 =?iso-8859-1?Q?9at3QBtaYI75bcku9MJKhjIDJZ6tDbpxQkrk2+916Ie+M5jaPEgQKPAkMn?=
 =?iso-8859-1?Q?Cg4U2fdQeIp/G9NEw98D7yJxlRi5XIGrp1/lYZfbclj0MrYMmvkopuVKim?=
 =?iso-8859-1?Q?qePBqlE8rr4icw6ty0VJGrtUssD8IqyJy/KzuSvQ+NHyd+riIVKg2Jc64n?=
 =?iso-8859-1?Q?xhQQPgskJEoQGJy1WIDi2V/ekZST04q6SSVeDWHM3dIqD9MJryVvh5CvLp?=
 =?iso-8859-1?Q?9t9Sv2Dx00HuJNx1zUzm6jIpMGeYI7MAt1DlRLJ3F62/07/oe8AGpopQfq?=
 =?iso-8859-1?Q?zd7GnHVHLt0sHBhE7nZJ+3SBbQBLFMpJK2lCNE0LESrnqqVS0VZMtQ+LGK?=
 =?iso-8859-1?Q?PwINnebVXoHDHgX1Uf/eMJx6+HI9K0U70ORzQzd1zJC82aFUv9mK648t8E?=
 =?iso-8859-1?Q?4evaFLlPdg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: aPAorfGJ1d+j2/KR6sPMscow6LBikLRIPNIFoa7v2lWtd03B5OMl+hmZ/XsrQ+TL29bzoz/rjn5RS/gRa1jVXvSjKUQUrPk7Z/cs86yqTGxeSQ1kyU5jRuGoSxz7Jgb9hxNK5UDRSQ798dS/nbngtQ5FRF7CoiS6UWon+rvcZozcjlB2LaMAq0AZtNuBdGOg/3DFABZU8/5UJMY/UnjYmVcjxuHNqoT9Vx3Dnt5gTnKL1c86ElvC39Y9LWW+f9NEaD6Wb/fx/1vx05+SE/IzRWrExGTZXrIz5legHWteeXo7AH3zBklv06x5pYNVDYURcOEan8wdKnPLKbXD+mGMlA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c8df92-043d-40b7-a895-08dea1d833fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:09.0139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oja83aCUHx2vK7iCO+fgmSnXEgPF+YjWmflS4qiuBCNUhT6iOzaETvsR9WT4g9vvBeBVb5K+OPRzJg1Cd/xqa9P0WM8RdXYqkR4y5sFjVco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5790
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
Add a ctrldssegment-default property so platforms can provide a=0A=
descriptor address offset when constructing descriptor addresses.=0A=
This allows systems where DRAM resides above 4GB to access EHCI=0A=
descriptors correctly.=0A=
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
v4:=0A=
 1. Reorder patches in the series=0A=
 2. Fix EHCI migration issues=0A=
 3. Introduce a common properties macro for both sysbus and PCI=0A=
 4. Drop the descriptor address offset property=0A=
 5. Add ctrldssegment-default property=0A=
 6. Address review comments=0A=
=0A=
v5:=0A=
 1. Add 11.0 machine compatibility properties=0A=
=0A=
Jamin Lin (18):=0A=
  tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for=0A=
    AST2600 SDK=0A=
  hw/usb/hcd-ehci: Remove unused EHCIfstn structure and dead code=0A=
  hw/usb/hcd-ehci.h: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Fix coding style issues reported by checkpatch=0A=
  hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with=0A=
    qemu_log_mask(LOG_GUEST_ERROR)=0A=
  hw/usb/hcd-ehci: Replace DPRINTF debug logs with trace events=0A=
  hw/usb/hcd-ehci: Introduce common properties macro for sysbus and pci=0A=
  hw/core: Add 11.0 machine compatibility properties=0A=
  hw/usb/hcd-ehci: Change descriptor addresses to 64-bit with migration=0A=
    compatibility=0A=
  hw/usb/hcd-ehci: Add property to advertise 64-bit addressing=0A=
    capability=0A=
  hw/usb/hcd-ehci: Implement 64-bit QH descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit qTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit iTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Implement 64-bit siTD descriptor addressing=0A=
  hw/usb/hcd-ehci: Add ctrldssegment-default property=0A=
  hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default=0A=
  hw/arm/aspeed_ast27x0: Enable 64-bit EHCI DMA addressing=0A=
  tests/functional/aarch64/test_aspeed_ast2700: Add USB EHCI test for=0A=
    AST2700 A1/A2=0A=
=0A=
 hw/usb/hcd-ehci.h                             |  64 +--=0A=
 include/hw/core/boards.h                      |   3 +=0A=
 include/hw/i386/pc.h                          |   3 +=0A=
 hw/arm/aspeed_ast27x0.c                       |   4 +=0A=
 hw/arm/virt.c                                 |   8 +=0A=
 hw/core/machine.c                             |   6 +=0A=
 hw/i386/pc.c                                  |   3 +=0A=
 hw/i386/pc_piix.c                             |  11 +-=0A=
 hw/i386/pc_q35.c                              |  11 +-=0A=
 hw/m68k/virt.c                                |   7 +=0A=
 hw/ppc/spapr.c                                |  13 +-=0A=
 hw/s390x/s390-virtio-ccw.c                    |  11 +=0A=
 hw/usb/hcd-ehci-pci.c                         |   2 +-=0A=
 hw/usb/hcd-ehci-sysbus.c                      |   2 +-=0A=
 hw/usb/hcd-ehci.c                             | 382 +++++++++++-------=0A=
 hw/usb/trace-events                           |  25 +-=0A=
 .../aarch64/test_aspeed_ast2700a1.py          |   7 +=0A=
 .../aarch64/test_aspeed_ast2700a2.py          |   7 +=0A=
 .../functional/arm/test_aspeed_ast2600_sdk.py |   7 +=0A=
 19 files changed, 384 insertions(+), 192 deletions(-)=0A=
=0A=
-- =0A=
2.43.0=0A=

