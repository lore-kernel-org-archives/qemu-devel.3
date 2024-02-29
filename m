Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD1DC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfbEW-0007Ri-Ht; Thu, 29 Feb 2024 02:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfbES-0007RA-MN; Thu, 29 Feb 2024 02:53:32 -0500
Received: from mail-tyzapc01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2011::701]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1rfbEP-0000Mb-VA; Thu, 29 Feb 2024 02:53:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tz5lsplfPjGnYiuHXMv9Y2c34YsonhrNlFsCXbAAG7cSSgRKxyXjDnPMY38Vb6iFiG1c3iMyxKXOhg6+qlkM+1M9pL7ZiM+hpIijX5cIG77hsQIcI9DXChj1T+4XoyIc7RFG/bwCpjDJBoGDeg5KfdILplwoN4xYyGcZzbfdkX+khSMIrs/DXrQfI8V0PRFjPnXwaRySF/dKsMJmXWEE+xAoXM/RVoiTkWn3OTOxQBi/v1x+qLDpkfup5A+4ibZQzgLxPn0nVUU2yLhobUzwZW7YBeVq+xnoifU/QFEPuwDiwXX3Pm8ATTxmYQEFZXYiT9k9Roig478aCDaayLtyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf7TGjL0wbQlIe0OFPDM2a/OY7A+fWhyVDiF/jBStyc=;
 b=ICErPIYQYK7fixM7fN8t7nyWIxZ7UkwKVyJ0eiVjeLUWRU4MnwK6Tazj152B5HArrtC63mOQ46GgBGTWws/0NNEz7N2RLRY0KQpRrS1PEAm7yh1OtmryP+wHc3ik7ePSZTENu6odp9e3lUnfKExoA3MLBwKbbuW+mBYi1dd6ry6ss5fmgBd5YMGXz6k24x0shz2w08miW0LWZzJbFNtYL/7mxP3xwXRoPpbBff2AdQmipe8nWaRHnZKXrc46CfPX21TWIQTGYRal0W2erm8fQlIep4XhHRyPEzWTzRwjQL8j2lEhQfpdQxfjRwayHYIUW5p1VGXIfyTYgjYRCVaktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf7TGjL0wbQlIe0OFPDM2a/OY7A+fWhyVDiF/jBStyc=;
 b=WFTKk3l4RJ4U040nduYhzWbesj0o9H9VUNJYGwBtbHoWFXreZH1X03hnbCIPcpHdCjU6ETN3gAZ2eyytHnX9mdslvP76pLVU5QwZBPcLdC4vuMRHd2c1vVdsWpv/vHRal85wCEV0OyZFfpSVs9WVu51tH+3AbGqEk7DdmeRkiPQ1IpshNHmRYR/RtIZyO5GapJZwGmCKf1qDFZ5oyO02qSAr1OezKBgcto0IYzeEhSn4XVtPlUXpBSsWJgEa2x9dtPJWZYujcYDiTaQgfKfa4jUogRnrP/PbSa5RwEZIfv+pWR/MaYC1flOooHyYKGLBpB08UC5TDX/dQtC3OjxtPw==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB6415.apcprd06.prod.outlook.com (2603:1096:990:14::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.31; Thu, 29 Feb 2024 07:53:22 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::14c9:526b:24b5:109d%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 07:53:22 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>, "clg@kaod.org" <clg@kaod.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>, "joel@jms.id.au"
 <joel@jms.id.au>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Yunlin Tang
 <yunlin.tang@aspeedtech.com>
Subject: RE: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
Thread-Topic: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
Thread-Index: AQHaauLiedApTYd2DEatyfju4PLRdbEg8W0g
Date: Thu, 29 Feb 2024 07:53:22 +0000
Message-ID: <SI2PR06MB5041B1EA856220BB77B8809DFC5F2@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <20240229074234.976164-1-jamin_lin@aspeedtech.com>
 <20240229074234.976164-9-jamin_lin@aspeedtech.com>
In-Reply-To: <20240229074234.976164-9-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB6415:EE_
x-ms-office365-filtering-correlation-id: 4b839f0b-d15a-493b-bff1-08dc38fb8087
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jpmf2noSSBa7+mSsGpwLJeYCEdo0blxSO5UPNsFZkUAgBTdX7Njw6kAEnfFtvgcipU0HIElOv/1oc9NCZWBTVrpT5zBe/Usznt7cPXmu4nOOLv9GbSwqzC1NtMgPSB4FP1oczzXzu135vS0TfAFpmwWf+fAu5zGHNWmFZG2XpTKhFDvNY6v9SjJqegLdH/tAF02iQ6T04gncDNHcCNxAV+/rDuEqo+ZjGpZKxWlTDA+4t2I0SKuqNlArYHEcUyfJlnRQShaOE7OFWJMxz+Tn65RnOKAn2ajUhfeNpG8i/QnmDIkZyvZw+zSKqHWmnFvUrOY8/A5vDQX2SLa9gyyQ9gSZ1YvdclkL4RyR9URKlpnca5qZQxtGn3QwNj4WYaIn14PMqSKO5Gyia5d/MET0chMXuX5izQHvN/EOsgBewqcf1IPL+YjRR8Uu5oyakdWl6BqhYmgN4lLu5IaN84h6lW9kxcgxksS5AOuEDOJj/58U3ezC7sh5tVZykBsiFy5OkkoywINxWBcjk1AATFded1OJbaASUhkSbDpxyTfWbKIJtYSbDI1e1SUFaPH3cS3hhi0s2jgJFNudXgLmOQ0rLY2TugWKA16nVPpi2rhI/C6xMp/YJHyGsaV2DesgUP3wFIPGhViAm1ipjrmdC2ZaHhlhRO/4xJRbEDtyctgC1GI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nYosMpGT34giyjKOFUkMU0tOE3YQGqKPcdXsvtjmyvpdAuakhwD8zfMQ1V2L?=
 =?us-ascii?Q?mN1aW9O7aMbguJG5TVqpfHlTeBWtLcNYK7nGpkWDPdM2LDi/8Y9igIhggUYf?=
 =?us-ascii?Q?4CNsf/D7KWVf2p2x2B9xgU2j+GiXfzASdCiuQLokw0dxwgQuDPV1YTCvjkLi?=
 =?us-ascii?Q?qCawp4SPk8U/uzMdGYiWCvdcZIJ7fXIDSwqrI3JeEjy2L48Ei9SsyoQu14rA?=
 =?us-ascii?Q?1Xbksr+o5Hm61AAi474e//MjbnuIZ/9UtsnzTjKWPDttm3B+TvvtrNGfcJNk?=
 =?us-ascii?Q?Fndwa0qPSvNQizQljYXMaq+hljp+fm7olwJwO5bfBmnFC1TLg5JayJZeD8Xg?=
 =?us-ascii?Q?McSYir3NLJFnaLHcXYmuNhq/x4lbyzOucoWclRYUpZ7SEeOp/seeN9+HHFDZ?=
 =?us-ascii?Q?6hAX/LcPaSS89bA2aYu+2Rc97oGL4bgqHQpFwtfBYVo5tdsDzW3HrC+pVqky?=
 =?us-ascii?Q?CO7ZilCGm/uDdh04iTu0sAnAv+CYq/zZXFyP+zAl/XbSU7WnmO4r9qI/OAXQ?=
 =?us-ascii?Q?QUZ4ubUTRH2oQNrU+9pHRXD4SVm3lT7IiEpjoZkfH2Dvj4cRSR3TvTG9z5zM?=
 =?us-ascii?Q?pH4FLxlFhgP48dpEDfnZ/kOns8Y5ptdQQir/zLXRCWDJP1BoDSMhd0Wh0YJS?=
 =?us-ascii?Q?LNW9KC6/uGlP8ETD6yMvUHq63O7WwkrV1mjUpXlW+b9BfSlfsa/rHm+rH9Sw?=
 =?us-ascii?Q?lebCKBTbl/u0Vf8qODifCkOClKNjd4m9dRbfkWetWh4GUBOtrIGOPPWeSDWj?=
 =?us-ascii?Q?Vt0LU/GynQpt7B9kgySAtTSpuqayFj//tTBNPhUdbFA+k5/IueNnQGkP7AGu?=
 =?us-ascii?Q?uQXLMYqQ/4MGMzs3ZzdZBfTKk7VGoeNu5gQ5sn+0Si4LrgluGdf7SmOnD/00?=
 =?us-ascii?Q?bdcTdGzGUrPRqD0RnhwYbOWrd6TGyXc+AJu4pLVz3QgN0C4fdsxGcdxJpRTE?=
 =?us-ascii?Q?sZhb9TyV1Pg3ia3ctzZV8WZ3Pds8FgRZ/AnW9ZIMULCY2qPVq2NrPycHjQUL?=
 =?us-ascii?Q?5RTQ8yOftT+xdwzYXAi8fkAu+9KnbaEak3LXisHzq+TxkcgyGduYxbwXlmOp?=
 =?us-ascii?Q?JYEjHh0HW3s8v/oFQqVi8TPD2oLK88YlVn6hAWfZKr7XYfLAIivYzEqQZD4+?=
 =?us-ascii?Q?aA2Zkqa21pdbwpqSyb3aG0HSgC+cjbSH9FutZS9YSgbhlMb8PzxPPJ+JvDTb?=
 =?us-ascii?Q?qZKGe72lPYmMUa+AfifmOJF/jihiIrsVtTfA96maO8PHWh2XCAh/TJJTgZON?=
 =?us-ascii?Q?rFwWhQILKyn2vuXv2avNdQpoFa9gex2Tk0u17uev4mG/TVyupmS92MP8cSQk?=
 =?us-ascii?Q?4oOKi0NUW5omhrCcHczxa/FnYy4ts7ocB1E+4qa86CNKXspbvrL2uRUrw7d+?=
 =?us-ascii?Q?ijKMQYFiM7qCjVe9VphvX7c6r+oedYCBIjDb3msWXCbU1Ixo15OVQmJScn1M?=
 =?us-ascii?Q?MfeauhPKyv3YFlOum19OyCoN/j87/b9Hyz2dk8V2ZmTT8OhV1ABL8DDulCFX?=
 =?us-ascii?Q?ZWo1o0nWiNENKxbNblxLzjyQ+5yrR2rHPwKoOauImg0DkzpRkB5TMlEXeCOP?=
 =?us-ascii?Q?OoIuPUy3FWjQ6VHOW0sJE4C4Wzk+o8agOR0094vT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b839f0b-d15a-493b-bff1-08dc38fb8087
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 07:53:22.3706 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: am+RvT4cnKf1T0KYY4nDe0dvecqE5akw3R7fT3JiHRS+VpMPTT6DBM9wF/hLIE7qJm8E1FNDgumIdnTtDq7Dc5n0AOpy4K3cHxQSNgzMv24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6415
Received-SPF: pass client-ip=2a01:111:f403:2011::701;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> -----Original Message-----
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> Sent: Thursday, February 29, 2024 3:43 PM
> To: clg@kaod.org; peter.maydell@linaro.org; andrew@codeconstruct.com.au;
> joel@jms.id.au; qemu-arm@nongnu.org; qemu-devel@nongnu.org
> Cc: Troy Lee <troy_lee@aspeedtech.com>; Jamin Lin
> <jamin_lin@aspeedtech.com>; Yunlin Tang <yunlin.tang@aspeedtech.com>
> Subject: [PATCH v1 8/8] aspeed: Add an AST2700 eval board
>=20
Hi all,

I tried to send the patch series to support AST2700 but I encountered some =
patches
were rejected by server IP 211.20.114.70.

Error Log:
qemu-devel@nongnu.org
eggs.gnu.org
Remote Server returned '550-[SPF] 211.20.114.70 is not allowed to send mail=
 from aspeedtech.com. 550 Please see http://www.openspf.org/Why?scope=3Dmfr=
om;identity=3Djamin_lin@aspeedtech.com;ip=3D211.20.114.70'
qemu-arm@nongnu.org
eggs.gnu.org
Remote Server returned '550-[SPF] 211.20.114.70 is not allowed to send mail=
 from aspeedtech.com. 550 Please see http://www.openspf.org/Why?scope=3Dmfr=
om;identity=3Djamin_lin@aspeedtech.com;ip=3D211.20.114.70

Did you encounter the same errors before?
My send email command as following.
git send-email=20
--cc troy_lee@aspeedtech.com=20
--cc jamin_lin@aspeedtech.com=20
--cc yunlin.tang@aspeedtech.com=20
--to-cmd "./scripts/get_maintainer.pl ../v1-patch/*.patch" ../v1-patch/*.pa=
tch

Thanks-Jamin

> AST2700 CPU is ARM Cortex-A35 which is 64 bits.
> Add TARGET_AARCH64 to build this machine.
>=20
> According to the design of ast2700, it has a bootmcu(riscv-32) which is u=
sed
> for executing SPL.
> Then, CPUs(cortex-a35) execute u-boot, kernel and rofs.
>=20
> Currently, qemu not support emulate two CPU architectures at the same
> machine. Therefore, qemu will only support to emulate CPU(cortex-a35) sid=
e
> for ast2700
>=20
> Signed-off-by: Troy Lee <troy_lee@aspeedtech.com>
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  hw/arm/aspeed.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c index
> 8854581ca8..4544026d14 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -178,6 +178,12 @@ struct AspeedMachineState {  #define
> AST2600_EVB_HW_STRAP1 0x000000C0  #define AST2600_EVB_HW_STRAP2
> 0x00000003
>=20
> +#ifdef TARGET_AARCH64
> +/* AST2700 evb hardware value */
> +#define AST2700_EVB_HW_STRAP1 0x000000C0 #define
> AST2700_EVB_HW_STRAP2
> +0x00000003 #endif
> +
>  /* Tacoma hardware value */
>  #define TACOMA_BMC_HW_STRAP1  0x00000000  #define
> TACOMA_BMC_HW_STRAP2  0x00000040 @@ -1588,6 +1594,26 @@ static
> void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
>      aspeed_machine_class_init_cpus_defaults(mc);
>  }
>=20
> +#ifdef TARGET_AARCH64
> +static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void
> +*data) {
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "Aspeed AST2700 EVB (Cortex-A35)";
> +    amc->soc_name  =3D "ast2700-a0";
> +    amc->hw_strap1 =3D AST2700_EVB_HW_STRAP1;
> +    amc->hw_strap2 =3D AST2700_EVB_HW_STRAP2;
> +    amc->fmc_model =3D "w25q01jvq";
> +    amc->spi_model =3D "w25q512jv";
> +    amc->num_cs    =3D 2;
> +    amc->macs_mask =3D ASPEED_MAC0_ON | ASPEED_MAC1_ON |
> ASPEED_MAC2_ON;
> +    amc->uart_default =3D ASPEED_DEV_UART12;
> +    mc->default_ram_size =3D 1 * GiB;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +#endif
> +
>  static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
>                                                       void *data)
> { @@ -1711,6 +1737,12 @@ static const TypeInfo aspeed_machine_types[] =3D=
 {
>          .name           =3D MACHINE_TYPE_NAME("ast1030-evb"),
>          .parent         =3D TYPE_ASPEED_MACHINE,
>          .class_init     =3D
> aspeed_minibmc_machine_ast1030_evb_class_init,
> +#ifdef TARGET_AARCH64
> +    }, {
> +        .name          =3D MACHINE_TYPE_NAME("ast2700-evb"),
> +        .parent        =3D TYPE_ASPEED_MACHINE,
> +        .class_init    =3D aspeed_machine_ast2700_evb_class_init,
> +#endif
>      }, {
>          .name          =3D TYPE_ASPEED_MACHINE,
>          .parent        =3D TYPE_MACHINE,
> --
> 2.25.1


