Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7C6C4453D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 04:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn7Bk-0003Ip-EE; Fri, 24 Jul 2026 00:07:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wn7BU-0003HL-SX
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 00:06:57 -0400
Received: from mail-westeuropeazon11013058.outbound.protection.outlook.com
 ([52.101.72.58] helo=AM0PR02CU008.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaurav.sharma_7@nxp.com>)
 id 1wn7BP-00088q-71
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 00:06:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsACB+MHr79Tl/WZMb1SzjxypsAOLOk70CIOGg+Dt+uWFi4tpRHEU+Od9jfzdt0BwxQ+8LJFG6R0eAPTUeB6DSueJFgLu4t5FOcFXBnhfWl4spDh8ozWtj0MMHgyhMuaYONm/IwVZdVsJuQ/fyBL6cetocMlmeoZUf3gv6Rdm39jzEka2e8M5WEpdonSrKF7nee3Z+7N7ubhHrkOruABudQzaVydDjTVo0UAGFOCXsXt5bdKeUWwgVhTfAPQR6QV+jNRq7ZQOktkotedTeHrLdTIF0yEOlDVaVRlz5nNRqcOyfmKItCpiM6k/IqKV6ocStGS6pN3vUlfJbF+OQ0NmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agiYx02ayehHdHPFijBtswKatW6Whkh+Hr+RDiH7FfQ=;
 b=crUw+RgE0bIk8PusYhOLPtrVPrFHcPT/I/n9aQSRibBKr2HV5gEekUzfAPdobC9VNRZqD6OFsyiTmPCE3vaZIbv4WgMl1WPmD6wRzqrPhpBbBGq+xdfTuhvj8FQMd13gFoQYhAA7euVX3Ahw5B6D77w0S8/vXuHhJFBu2qWdhWw9j5u+LRp6HQXtTdsMVQTo6OeYaJuaUnmaBbAEJcKr46ouv8bWAfAmbBs2QpzezzQjMdCPXpFp5CzTL6Di7pIzRm8rp+7ZobuZ9MDvmsQEJU8FiY7ELdawxK9fh/1p+v3rZWtfrSFxh3LNURNCwqTj1Xc6I4hmGT/n0iBWuy5hPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=agiYx02ayehHdHPFijBtswKatW6Whkh+Hr+RDiH7FfQ=;
 b=ajtnBY60+XVNFox8TILhzxASkgznrw4WxHI/fZwWCdWSkgM2E4PAeLkJjYBLh0HmM96DIOsUz7TNjrx5nlGLk9SvtRvXC2oSRyYRCAWRbAVXTmxhgbeQMzMAF9Sz6lWXNXMbM6dQE7L5ILs2GO9yGCynlP3+l8QVKjOwqbatrvsSGVSElkc1JwkUi0okg5CtOvFac7sAO7B+tT9zwWQy6k5eLkHPViAg9goAQHfkp6eooPVQ9lFN4Pa5+u7RjRuY/ZWGrOJzbu5TwBY8wSEf4obKqGr4fusCGbZYhIFoVZ7eD9UR3bgKCImp9OnT1D4z0SScZGJVLeAeS83IxUphFg==
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 04:01:42 +0000
Received: from DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2]) by DB8PR04MB7177.eurprd04.prod.outlook.com
 ([fe80::cf7b:6007:220b:97a2%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 04:01:41 +0000
From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Bernhard Beschow <shentey@gmail.com>
Subject: RE: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric Multiprocessing
 boot support for i.MX8MP
Thread-Topic: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
 Multiprocessing boot support for i.MX8MP
Thread-Index: AQHdDWSQYf08EcE04EOcCOxujcqOMLZ8J0EQ
Date: Fri, 24 Jul 2026 04:01:41 +0000
Message-ID: <DB8PR04MB717781FAC6A65C0BE2AF1D0587CF2@DB8PR04MB7177.eurprd04.prod.outlook.com>
References: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
In-Reply-To: <20260706162859.3361063-1-gaurav.sharma_7@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR04MB7177:EE_|PR3PR04MB7356:EE_
x-ms-office365-filtering-correlation-id: f8fe6b62-fb03-4047-98b3-08dee9384514
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|19092799006|1800799024|376014|366016|3023799007|10067099003|5023799004|11063799006|56012099006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: ro/k81fRyIRytfVOp7RKOGa5CWd4d4yDRzjG0LNXkKkM78a8T1/HjUxvrBiuzQnpN6naLhTy2UMSuWaDP+NJVLSEZGTMjkEi67AWl8NzEeoLUy9MKYAUlyFVSyGRjNZPtPchhvisavts5jkaC+JkPa3WZVzRb4axc6mv/tJyYsZ8mbHLTAeiUTUp0DuzhF0dF7CkrTPa1z2mX+CTOj7XvTRApSzI04X7NCEtIt7IWZ+a/WOrDSfKhZ37gNHLMNKtf7+AJ5KnnfXSiS/+j2ARsNfD+a+Bf7lvm4dU0Ykiq2GlP5byS1UEVIl0EXDxEQ3KOP0YJrL8ZtIEUU+AF3wzUQyruQh9kzE9tpFsHk5aoE04Npm0bgnB+5SboaYQOriaS4xj5lD62yLba+KARcf8HORY5xBwbJ+XsUsKiP4UJYtC6TystNt2JAs/THezxPCQ1GjUftm5ApdXpKhUWnh5mm1yDiPU99C97awn0AMObQaRXacJXZPEKnzEsidGWu1daPErWuhfNYHsRT13ljHCrhVyQeR+JxKhYKjuDWMWfUADUALTIAxv+QZgL0TnTMtCBFT8nyO8hjlWzJhm2pzWU9P/P6jd4hzCvvs3Ifb5wd/DWSAob8+dqBNkxaCX7DuBxNTZ1+q34rofK5Mw1nxae/QKXcAWAZ8fjZPgUIUiKPucX6YtrN6/JbkEHK2+ZeU2xEPOEDGW7GnMDfCuTlzCTuGHgMmZsCC3+1dT1YIxzRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB8PR04MB7177.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(3023799007)(10067099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+jhubGMgzrV8eT23wwgY9JuVkLzV4SBsCgOJOPq7olHjR0cB4u9WMh510FOl?=
 =?us-ascii?Q?WCE+FEzAOEsfvMvEHKrQ6UbIAIBT6Lnpe+ea6roPLJz86aB8dHy3f9piWEHF?=
 =?us-ascii?Q?DxVicvvUdZvjGMRzFUa1W1r/qVMStXksncn1Xq9hJYbcpNSZJWydIbMVFtrC?=
 =?us-ascii?Q?c37AEAkDNOzHCCFqA4AZ+WGaNo/4yY3RINBqi5AX7EkymX7hUqwHkERpdeGA?=
 =?us-ascii?Q?y9zchQr++VrdJ24/ohUDZqjEiKVXOPXbCsAlCKhKfclk+q6qFaF2/Wemukdf?=
 =?us-ascii?Q?tLt1xruyfcVounvHNreckegWL52Q/YugkS9TS5evlHkgDQRWO2OeOApjprXy?=
 =?us-ascii?Q?O3JznYotnvhxhXw8CASbJlazlUT5g6KGNvzS6dnjjo5FrsT08SQO4vMqSOrM?=
 =?us-ascii?Q?Vdpuc/FamXWs+hsIiaCBruzdWfxu4yjGjB6EeQ2dHtdyOnH0vQA3IlLgVYA4?=
 =?us-ascii?Q?pmrf+akvRZka0RLKnDHfWG+7P8GY5bZS2l6gu/JMFMYwW4j+fZbOM7+rCGMw?=
 =?us-ascii?Q?ad6TtvFP5U5/85BXwWWjkXB9qsoeqgKXbt3e9wYPMxLypNy7wI1FnljDIJUu?=
 =?us-ascii?Q?cbc7fDnePDcPmfMuYWujVShAdqCsBPMyYqA0edGnBoTZXxfLbok90L+ZfjDA?=
 =?us-ascii?Q?v0+calIv3UlxuVyrLExG/wHs4QBA62gLJsDp0D8BsOrp1NjPF2MeWvRmo9mw?=
 =?us-ascii?Q?jKTshhqO+E5lXdbamg9NfTnLJom18iA4nrIaxEAuF7sOqIl/85E/rzy06DtY?=
 =?us-ascii?Q?R1XuWt4cLL/oquhdVTgpgGLwE/X3I9T0TFle/yos3oQ5n7LYIQX/Ud/KeYPM?=
 =?us-ascii?Q?4QarsGoNm12hdNTGSvJ5mBfffRmhnuVD++vfp1AYRRfvuBAOvz/A3RjqnkSo?=
 =?us-ascii?Q?O5QN9ZX9a1h3/eRD0j0Lgz1TqFEGxCT8kKl1CuRM9hfuB0AFOjb5poerE3qQ?=
 =?us-ascii?Q?NnP4WkoVMAGmEG3bNrcvKl36rlQLrV30QgwPGdESTd1qHnYuFoj13oxxodfj?=
 =?us-ascii?Q?Gwremt/Zr5AgYzWIyYBJMwKsNVtIPY6DY8tLdaywIHP9oQTsoG0mSP+2d2W+?=
 =?us-ascii?Q?75tp+UuwD5sgZxuUftTRKGkHAyGa2p1GAgq+0Ovv8e+yAhfTQdNbcyRxJlwN?=
 =?us-ascii?Q?fXz30N0HTaOJTLvdzf298Rnpvahffb4rYwEXeQ0B3U/xzB7ep1aIt6iTriYD?=
 =?us-ascii?Q?1t0uUQ+GHkYVS4M+ydCAyVQesDUAHPR7FtXsTxDQRyYw4AF5FG1cSBPYrav9?=
 =?us-ascii?Q?BIofM1k0YK8gk7fA+wxn0gke1CMtP/5wGS944B/90N4mhWCTfF/Mo+f1QReg?=
 =?us-ascii?Q?ESrM4pXuYephSTiAWVXyqm/ePd1Q/yHY7zQwx1z6ceHOFw1pkQJsnBXb9i4k?=
 =?us-ascii?Q?v+jg0NtKaFPV4WilDLXddYVEEjJEV8p8/ETm/zAgAHNIU8rXN9eCO9zPSCB3?=
 =?us-ascii?Q?NeOrXi8el6BgpTAwkhsXE+VOEyouPQMK3RCf3mBpPmPpTDB+hvnKiTxGMzbZ?=
 =?us-ascii?Q?VUWdBU8o0QrbwM2z4fWrpv2XPaT1YAW+qQ+2CfF+HKaxCaAnZUssU/jPYWOp?=
 =?us-ascii?Q?0a8PAngPuqNQhqZ9em5ZW3cb08ltmAdJiDuEfsfDwS+RCpPQcRM9za7MT2MJ?=
 =?us-ascii?Q?C/95lksXPqzRL33P1LroD1MSvmTlnX4/e72zZMF9HYSbkp3H60rmZA1/Mz4E?=
 =?us-ascii?Q?sIbuyYYyoL9UMQntSJ5M1nN4CJT3gz6DsuwNHPHzmK/QIl5T1GwQvhntFttE?=
 =?us-ascii?Q?1y1HDFRkyg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fe6b62-fb03-4047-98b3-08dee9384514
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 04:01:41.9148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xL78pXpGHzshGlcZwBQrHwr2H2nckvx8xVqrsSLv6EksDn595Lhu07VWWEvaKjXQNzkwgyAgl76J2Su4JzK83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
Received-SPF: pass client-ip=52.101.72.58;
 envelope-from=gaurav.sharma_7@nxp.com;
 helo=AM0PR02CU008.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Ping

> -----Original Message-----
> From: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> Sent: 06 July 2026 21:59
> To: qemu-devel@nongnu.org
> Cc: pbonzini@redhat.com; peter.maydell@linaro.org; Gaurav Sharma
> <gaurav.sharma_7@nxp.com>
> Subject: [PATCHv2 0/7] hw/arm: Adding Cortex-M7 Asymmetric
> Multiprocessing boot support for i.MX8MP
>=20
> Changes in v1:
>=20
> This series adds Asymmetric Multiprocessing (AMP) boot support for the
> Cortex-M7 core on the i.MX8MP SoC. The M7 firmware can be loaded and
> started from Linux running on the Cortex-A53 cores via the remoteproc
> framework.
>=20
> The series introduces the following peripheral models needed for AMP:
>   - GPC (General Power Controller)
>   - GPR (General Purpose Registers)
>   - SRC (System Reset Controller) authored by Bernhard Beschow
> <shentey@gmail.com>
>   - MU (Messaging Unit)
>   - Extends the CCM with M7 clock outputs and wires into the i.MX8MP SoC
>   - Enable Cortex-M7 boot in i.MX8MP EVK functional test
>=20
> Changes in v2:
>=20
> - Removed the usage of device_class_set_legacy_reset in imx8mp gpc,gpr,mu
> and
>   src.
> - Removed the usage of 'smp' , 'maxcpus' and 'enable-cm7' to make the
>   invocation simpler.
> - Cleaned up imx8mp_src by removing redundant/unused code.
> - Updated Maintainers and improved the imx8mp documentation
>=20
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
>=20
> Bernhard Beschow (1):
>   hw/misc: Add SRC (System Reset Controller) to i.MX8MP
>=20
> Gaurav Sharma (6):
>   hw/misc: Add i.MX8MP GPC (General Power Controller) IP
>   hw/misc: Add GPR (General Purpose Register) IP to iMX8MP
>   hw/misc: Add MU (Messaging Unit) IP to i.MX8MP device model
>   hw/misc: Extend i.MX8MP CCM with Cortex-M7 clock outputs
>   hw/arm: Enable Cortex-M7 AMP boot on i.MX8MP
>   tests/functional: Enable Cortex-M7 boot in i.MX8MP EVK functional test
>=20
>  MAINTAINERS                                 |  13 +-
>  docs/system/arm/imx8m.rst                   | 188 ++++++++++-
>  hw/arm/Kconfig                              |   4 +
>  hw/arm/fsl-imx8mp.c                         | 220 ++++++++++++-
>  hw/arm/imx8mp-evk.c                         |   3 +-
>  hw/misc/Kconfig                             |  12 +
>  hw/misc/imx8mp_ccm.c                        |   9 +
>  hw/misc/imx8mp_gpc.c                        | 146 +++++++++
>  hw/misc/imx8mp_gpr.c                        | 153 +++++++++
>  hw/misc/imx8mp_mu.c                         | 328 ++++++++++++++++++++
>  hw/misc/imx8mp_src.c                        | 275 ++++++++++++++++
>  hw/misc/meson.build                         |   4 +
>  hw/misc/trace-events                        |   5 +
>  include/hw/arm/fsl-imx8mp.h                 |  29 +-
>  include/hw/misc/imx8mp_ccm.h                |   3 +
>  include/hw/misc/imx8mp_gpc.h                |  34 ++
>  include/hw/misc/imx8mp_gpr.h                |  56 ++++
>  include/hw/misc/imx8mp_mu.h                 |  53 ++++
>  include/hw/misc/imx8mp_src.h                |  31 ++
>  tests/functional/aarch64/test_imx8mp_evk.py |   1 -
>  20 files changed, 1539 insertions(+), 28 deletions(-)  create mode 10064=
4
> hw/misc/imx8mp_gpc.c  create mode 100644 hw/misc/imx8mp_gpr.c  create
> mode 100644 hw/misc/imx8mp_mu.c  create mode 100644
> hw/misc/imx8mp_src.c  create mode 100644 include/hw/misc/imx8mp_gpc.h
> create mode 100644 include/hw/misc/imx8mp_gpr.h  create mode 100644
> include/hw/misc/imx8mp_mu.h  create mode 100644
> include/hw/misc/imx8mp_src.h
>=20
> --
> 2.34.1


