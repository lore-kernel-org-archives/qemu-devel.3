Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E5C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:59:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLKG-00073C-Mk; Thu, 17 Jul 2025 05:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4o-0006Ho-KS; Thu, 17 Jul 2025 05:38:56 -0400
Received: from mail-francesouthazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c207::3] helo=MRWPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1ucL4h-0002Od-Hk; Thu, 17 Jul 2025 05:38:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvFKhQ+BbfA2rgrADkyP1iSZbHIbr2Hki8ksIe56YXt8/0iCPWBVRQfX8mH+yVLvOD2j2bW5ALenaRVpszOdOd4e+I0HEkAVSmuCFBDA0H23DLCxpWACQ0OEdpq3tGPTSCFxlhEGrWXUSphA4HFuNu41kbJNgkddtk3RLYrLGOLo6toDD/94Nn3NZ+EjEvDCS1BFXR8fgqZ61cuohKqxSGm0O7nk0RXBK5M6kpbT2lM9gAp3kY1sn7/rKiYzLHjS7tJA6OkMOA5LnKNotEmp0MQmVNWIclqGpZUhPKXRtABVdgkQ2Q+dMqtK5rA3ZcV6jZeQlQbfBpq+WoCLitjhjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkbA2EFpCE8EdrJOXub9w3ZF2ptppwJCPO20HSmM0bs=;
 b=P+hG6qvrmCM7SP3krTgsJQA8+KpzXs7XSTuq2v04SWZpusD/G1IoR/vpLNayNW8C1UuQYcq8aX0FMU1yNC3gD1pdIfkeO36K/60mtRxuSjHkgSRT36dC3Lq77/Vc4QoT3AhkzrSq29m0J9I260FaUhkBMEECPyMvx8IhFeFA2MpW03JeGMw9cI76T8S5AZJGqyllVcQl7QNfLcaIrznitUk/IyMRgkcmSFTKfPd09QQZwVi2CvKQhIU09TKFcKBEhW0l6ZKLKlKDFvd5vLQj3u7v2a1rIwG6wLn6Hq/FS85H5XHepLAGcHhkv0JdzsEgf730ci3WM1qPmTtjeWPC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkbA2EFpCE8EdrJOXub9w3ZF2ptppwJCPO20HSmM0bs=;
 b=WlDwUeNVjLZsgJCccA5e3sLIQYAlrJx5CRKoRgoZSr3Gb7+VJXvE01DMuBEhhN+7nN7lBieFZo9OXhNkr/ySu+AjurBLwU6YJyjq9uCzge6JmaWB0O/YgLAQZyQMBq36khNNhWUWQhBzqoeIWTKjqB4i2sw7BSi3pLPdVh268JwQC28oxHFwF8VLQvBo2ulQRJGuDjGupjUiaOJQT2a5ADb+gdWcbUovYOrlVlRo4HONfpMV30MGiuQlQOAVz0+ps5DEcbRNHVZ3JexTAIa70jma8nrJSTIpesB0t+WwZLqeOuBqKMjJjlc0HywGvORj+x6vEYcRLNsGeripJzarEw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by DB8PR09MB4124.eurprd09.prod.outlook.com (2603:10a6:10:fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 09:38:41 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%3]) with mapi id 15.20.8857.026; Thu, 17 Jul 2025
 09:38:41 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Topic: [PATCH v6 00/14] riscv: Add support for MIPS P8700 CPU
Thread-Index: AQHb9v6UGrCoAbtlqECp61EdLa3+xw==
Date: Thu, 17 Jul 2025 09:38:41 +0000
Message-ID: <20250717093833.402237-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|DB8PR09MB4124:EE_
x-ms-office365-filtering-correlation-id: 0117e925-2239-41b3-bd10-08ddc515b743
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?FccK9xr2gp5gl/BwEfmkA+28knbYCBTaSwDbJ1UYX52lF+HD4I3RQrVQ3H?=
 =?iso-8859-1?Q?/kfqJXClOdauxZFHdjwyHJzn/rWH66qwGWO+xqsJSbfUhUGvEU9qOKu4RA?=
 =?iso-8859-1?Q?JMQdGGLYCP4Gw6gZyyQiIe1JKa9nE5N8fwh+f+dJBlSQ/PFmF/iPT0WB5T?=
 =?iso-8859-1?Q?4gyOdkTjNXQWhfWZrIwDh8JDteRzJeekfmsZRQ5WSNagDQTXkgjoXLCKtG?=
 =?iso-8859-1?Q?Bzk69xWCH7JHh0/L4D7BpTblOkdQnZzBzj/pVZnNjO6gpWEzmKUZZyE53o?=
 =?iso-8859-1?Q?WYAl9aG/+/Ji3FqidvBXPL0ifTLzHDKz6EXWJlcQ0D0PfhRMiYAXSOK05q?=
 =?iso-8859-1?Q?ObB+HXW5Mkj/RFrL/Z8SG814cYOdnleo1pHa/xZjgsR0pKtuozJkYTXYOm?=
 =?iso-8859-1?Q?LFY70DxAh5V2RHDgfuncIhEHCwCUM6CeOPBq3o+YdDMIhimev4JPWeiVTx?=
 =?iso-8859-1?Q?4EhzfMnZRqF/PAtSFrYTORpruV802P0R9v5hl9gGyZkLe7JKIG6XsMFruu?=
 =?iso-8859-1?Q?R4rYhfO2zEkieeFhgBaQ9V+0oZLthrYRq8x5AWoNAKWYq+smqSlzS7QnqP?=
 =?iso-8859-1?Q?+g/SlWdxIxcVGKotcWGIZchBpmY3Xl02ZG4EPVACI3RGHxEftPitwIJ7Yg?=
 =?iso-8859-1?Q?r0qM3J52Pz9zaJxBxKpFoNAOIerCjqxf/Pm/jQXlOlSqfRI6Mk6jEkMr6+?=
 =?iso-8859-1?Q?9Ek7pYDWMAt9W+/TII0o1McU6Hj8/wqRjZ3r1egG7vulbh4YlmALX9Va4y?=
 =?iso-8859-1?Q?3ieFnR96Hhy+THLMhWhYdXNhIHdbtJzYsjR8qoqMywetOhWI0Dvl1odXam?=
 =?iso-8859-1?Q?WPhgnOH/pFNYgLWOP1U+L0LUldmAzeOZPBEW42i06SVqDZVKkgbdKt+yQu?=
 =?iso-8859-1?Q?ejFr1hNQ551+0s3+ysbWbAeF5EmAvcIO6BHvORHI6xKrgva6RjN5dT7HBF?=
 =?iso-8859-1?Q?/gTz3nbmz5BRwWNosWAbybjybd9Jz51176TbJ7v7eWwlPExo+1hnUmnS9U?=
 =?iso-8859-1?Q?BuBHERd7ium+OwysYdcxaeAox0MgzV6QtKLJzJ9GXgETI+Q7O1WDl0u5vv?=
 =?iso-8859-1?Q?0/cQ3maPjhSXui62ed90x8MrjHrY5bhgMI2YmHP6Wd58mE+Lu8w4iwcbn4?=
 =?iso-8859-1?Q?k7zJIwc80C3mWeQusacwOXJ8e222hwjVaryFgRmKutT+kQb4/8kehjrPi3?=
 =?iso-8859-1?Q?6yAFbtxvne3fDKKniwF8BrE7ikuPdrHhdI1ZU1Hfi9D1RULH5E5V9ZL4GQ?=
 =?iso-8859-1?Q?AoCZ5i2f80FCWQMfPeCRv888/6ioTJAHpI83zqhpHmW2CsqvU2n5+SBQ6c?=
 =?iso-8859-1?Q?1IzwzMa5tmWTJPZ1g2zAdrRLmtpTJAWCbuM05LLL4H+mIOGD6Ejf3yQeHC?=
 =?iso-8859-1?Q?DZhcg8f9CoEMlBasw6JluwiDLo9WNwHBcLuRmR8XyPCxuCVSKi6iA0C7Ir?=
 =?iso-8859-1?Q?EFXkLVZhYMjldjV+5GxBL++ItEj0x/g8F1Gm3se16j8Y3QDCzTdnZv4jSC?=
 =?iso-8859-1?Q?5JtdSWaRdcsaXfIKH/zYSXY5Ot2V/6zrdNII+BxnmH8g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6uFPchd1DaDJZ2qfvyXSrHXZhRNdbt5570Wi/XiarSxOFFZuwHa7kPjyV+?=
 =?iso-8859-1?Q?dyKMBZBF1YpQ67mcrdTJ8+h86V6PiQ4OapP3Rh+T5GgQgHKeEOgzbLFlLq?=
 =?iso-8859-1?Q?Ogk97Ui6oeAs48x8pmnHG14ZJDqM37C5Y0JUEAXh6UvTEXhjBtxbrR8kN7?=
 =?iso-8859-1?Q?hGbHEypiESq6cg2WdMAznwcol5+WQKcXh7+pdj8s3IJRqXfsOEpfYihD7G?=
 =?iso-8859-1?Q?7hixkuzGmU3cO3vF6UP58hmjLN/P/RlrguiSVGh3fBdYOu3eaz6fH/HcuS?=
 =?iso-8859-1?Q?6ae5q6f1sGbOe/ClTAOaJJqH+QBNlt6XamQH+z1kJBrhY7/0M4pU2zeqNC?=
 =?iso-8859-1?Q?TfBZvAhZmBaVaATDULQLjQUAdR+SqVe9YjpjzqDvIPMdrwDQu9ffyXwO9F?=
 =?iso-8859-1?Q?ErUTnyBE5eJiQZnRJ1NAVlE95O7Yx+SWRgzsInPburnCqiJIu7TG4u46Us?=
 =?iso-8859-1?Q?ap1H1kBW4dIM6dm7HT2vTrzOoiwSrm2vSFDrGCmgB/t6+UxtHuRRogTIEd?=
 =?iso-8859-1?Q?UpDjS8In1p57urYYCchXYjQVQSjomq+jFBGHJWT1dVkwA2HwygaC25igMd?=
 =?iso-8859-1?Q?JM43O9ElWXKduvudF9zJodGZp/w3MsTQdylRgUgp90bg1mO6OOb6IxaiJs?=
 =?iso-8859-1?Q?xejeEl6Ki5i+6ci/ZDN3NzoX9FZQvpp3+1zOfeopN9/3SfsgqyvPHhJhz9?=
 =?iso-8859-1?Q?bvOgNoD/33DlW4k/Qm0msNzPxUYg1QwQbHIlQzkz5VKk9fKdFi2kivkSyN?=
 =?iso-8859-1?Q?mSMcd6+IcGZ03ZpXH/Yi1mRgNvRa//bT2aSUWAsKWGxuRg6T2OkClxOHJo?=
 =?iso-8859-1?Q?DBgHzuueWTTkXz3V12EVOo1x1kqNQetH1ZdpRr+xB9jMjjh4RfqMLlopXg?=
 =?iso-8859-1?Q?IqYX88fCpg+hwVP8rqLPyknykzwvgErEKf7Nzo/dW07sKomiCcMfIOd67Z?=
 =?iso-8859-1?Q?Sqmp8I4fBLEjfjGTG96Pfm1SCHIPkkT+LxjGKMRTpSDlc4e7l0KPtlWAQ4?=
 =?iso-8859-1?Q?e+7FgThaSU5W+qizoWAJ76AAKwJNGKJCtwFdj5onnmi/vstoIIOiFLbEpa?=
 =?iso-8859-1?Q?d8CRqJozuXBkZU//bDpNB4xUVv3bIEjwpdCxBLPphtdRRSXo1mrU86Xhgh?=
 =?iso-8859-1?Q?/UHgYYr/UJYI8todT3YWXRTYqmuFpAW6FydxH5M3Sdzd/jBA5ueB+d0QJZ?=
 =?iso-8859-1?Q?imEXaF+907ZpjWae1L18CPGZb1UYEptJadkvgNwGPTecHQYQpIeeLJxsqw?=
 =?iso-8859-1?Q?YEr8c9+El9UGCk9AbsNH7nLyaUVkkx8YK4/9YY0PElspHCLDh3THm6YOoR?=
 =?iso-8859-1?Q?bdvb1x20drWuD+9CqUDtS1Nb1oNJbqwgEFyO4bZIoYm1rzEbN09pWR57Jz?=
 =?iso-8859-1?Q?qnNJiYIbMuEQxQjq4qUKrjRjoLaVvNsIwos6Rv+s0Aql7iCpdUs8W59VIt?=
 =?iso-8859-1?Q?yRWr1gmJ9DmaokNy8qT2haNnP+K2UX6t7m643nN3BVhTCsUfPsAcEUj2g+?=
 =?iso-8859-1?Q?vaszeTxZuQhz2CvTyTIjlYCV4WUUrwrlebTMz6TvKNovi7taOIJlUoRQ7R?=
 =?iso-8859-1?Q?5X2PfXNIN/0YqiSwaBbSpxLgjZv3n7c0TXG6zqZqXB48Q1JEZGcKhh9H3O?=
 =?iso-8859-1?Q?zCJhgKluds5hOZOCtk8eGEW63PRJE1SbnE0dhIcfui7ctxLjHLz0ZjCSR0?=
 =?iso-8859-1?Q?cmiwX/NUeHEUEmVySOY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0117e925-2239-41b3-bd10-08ddc515b743
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 09:38:41.5700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0J+rRNpbesXRnLwM23DZPQFgds3JnZLJxpWGcb/GX6YDFsfv52qI82uYLVqwbxK4bYX2fh0UBWtGnfRBTWo9HkZMOSTgRobKVMPGcgUE40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB4124
Received-SPF: pass client-ip=2a01:111:f403:c207::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=MRWPR03CU001.outbound.protection.outlook.com
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

I addressed several comments in this version, major ones:
  - split CPC / CMGCR into separated changes
  - split CPS into a separated change
  - added functional tests for boston-aia board

Djordje Todorovic (14):
  hw/intc: Allow gaps in hartids for aclint and aplic
  target/riscv: Add cpu_set_exception_base
  target/riscv: Add MIPS P8700 CPU
  target/riscv: Add MIPS P8700 CSRs
  target/riscv: Add mips.ccmov instruction
  target/riscv: Add mips.pref instruction
  target/riscv: Add Xmipslsp instructions
  hw/misc: Add RISC-V CMGCR device implementation
  hw/misc: Add RISC-V CPC device implementation
  hw/riscv: Add support for RISCV CPS
  hw/riscv: Add support for MIPS Boston-aia board mode
  hw/pci: Allow explicit function numbers in pci
  riscv/boston-aia: Add an e1000e NIC in slot 0 func 1
  test/functional: Add test for boston-aia board

 configs/devices/riscv64-softmmu/default.mak |   1 +
 docs/system/riscv/mips.rst                  |  20 +
 docs/system/target-riscv.rst                |   1 +
 hw/intc/riscv_aclint.c                      |  21 +-
 hw/intc/riscv_aplic.c                       |  11 +-
 hw/misc/Kconfig                             |  20 +
 hw/misc/meson.build                         |   3 +
 hw/misc/riscv_cmgcr.c                       | 234 ++++++++++
 hw/misc/riscv_cpc.c                         | 239 ++++++++++
 hw/pci/pci.c                                |  15 +-
 hw/riscv/Kconfig                            |   6 +
 hw/riscv/boston-aia.c                       | 489 ++++++++++++++++++++
 hw/riscv/cps.c                              | 197 ++++++++
 hw/riscv/meson.build                        |   3 +
 include/hw/misc/riscv_cmgcr.h               |  49 ++
 include/hw/misc/riscv_cpc.h                 |  73 +++
 include/hw/riscv/cps.h                      |  76 +++
 target/riscv/cpu-qom.h                      |   1 +
 target/riscv/cpu.c                          |  40 ++
 target/riscv/cpu.h                          |   7 +
 target/riscv/cpu_cfg.h                      |   6 +
 target/riscv/cpu_cfg_fields.h.inc           |   3 +
 target/riscv/cpu_vendorid.h                 |   1 +
 target/riscv/insn_trans/trans_xmips.c.inc   | 142 ++++++
 target/riscv/meson.build                    |   2 +
 target/riscv/mips_csr.c                     | 228 +++++++++
 target/riscv/translate.c                    |   3 +
 target/riscv/xmips.decode                   |  35 ++
 tests/functional/meson.build                |   1 +
 tests/functional/test_riscv64_boston.py     |  78 ++++
 30 files changed, 1994 insertions(+), 11 deletions(-)
 create mode 100644 docs/system/riscv/mips.rst
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 hw/misc/riscv_cpc.c
 create mode 100644 hw/riscv/boston-aia.c
 create mode 100644 hw/riscv/cps.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h
 create mode 100644 include/hw/misc/riscv_cpc.h
 create mode 100644 include/hw/riscv/cps.h
 create mode 100644 target/riscv/insn_trans/trans_xmips.c.inc
 create mode 100644 target/riscv/mips_csr.c
 create mode 100644 target/riscv/xmips.decode
 create mode 100755 tests/functional/test_riscv64_boston.py

--=20
2.34.1

