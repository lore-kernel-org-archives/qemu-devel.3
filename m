Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7B8C61DF0
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 05:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ulP-0005ve-7Z; Mon, 31 Aug 2026 01:40:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0ulJ-0005v0-Rx; Mon, 31 Aug 2026 01:40:53 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x0ulH-0001D1-V5; Mon, 31 Aug 2026 01:40:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLwwaSTsCMS8HZWW8DXloPYwbYVM0qcLrWn+fR+ZND+8Elkp4G2UcXYzizzQ8AQzsTuVUfbxpM+lh6ldYeY8qTR2mUp30uu+B5CAoEXMsrjYZf3Ey0vzf5bAnULvdOzgieukTdRLNucSNs4B/HPSGG7d21FcY98GI/y2eIKqUd9Y4lOt/ku+2NKjBG+1CSaJnSpF1Z7B9NqiN064bexOh2P6RQid7EyR6Pmu21/U/4i3ECZ9jaEWy8e30jDb9FRwyU4jF38s17xB9Sga+sS92/VB3cY7zK3HGnhgnyf/bxFnykZZ58K13TAadIiQVBumApOrYwoQD1iEoa3JDFJvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bMNji62OVqESY6Oa0c86noOgSBnhL2pshX2h5sRspo=;
 b=ljZ8XbQ9a3SuvU2T2eRs4htvkwG8D6iDqzzFKJV8WYFszXgzpHtdU3hYSGjr6Thz+BKQlM4NPZi0UED1iXFsYoTv7lBoBXe1tn1xvQwDGmC/LVFwLUfdt5lfT3GnQhTMzs0uOuLAHV1KVb1NM7PnKK1InoHUGnQtBofSHtFRlNXiO7EEJpSDzsljpl79Ddumw0aft8p537Ry1pWUce1SZrbfuy64DNTorNtUvg2kwTBo+nxGF6kZ1l4ACoMQji4B8uMjE+J7Lm1ekHV/QYYyc5tkBCmw3FV6Ag960+tU6BjLoSLyjhN+r24xW23O/WIDlxznuYH4ZWX4YbOX+sV4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bMNji62OVqESY6Oa0c86noOgSBnhL2pshX2h5sRspo=;
 b=Y8Sz8NDs07tIIWSKCRRbeXyHvOJ1rsFO+B2LkEQUDvb7cHOKFZEWELDrXjjSPIMGwpmt47Ewb2umiELMfnS/I8pWUxuQtDFtUY0lp2sdcJF3riox0/MnQgwjJrIGMsBj/1h8mOMSG386ZAt6HoQDrbBr8+a/ofSr17I/k5PG57CcmTXMOpHn6PrFdlZO8+ZmR216lm8+Xg4/ykRQR/hTsStsFzzgM2JIaA7EUrgYx21QcGF/ulBL0NEkhETwtoJXdWTSJ8LuDtLrjYK4POvWaZRoEvXmW080AXincW7zSaKTOOuucr1LOMbc7BMDl02oivDXlBylTSf1dl5GlRTVjw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB6326.apcprd06.prod.outlook.com (2603:1096:400:41c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 05:40:44 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 05:40:44 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Kane Chen <kane_chen@aspeedtech.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
Thread-Topic: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
 config straps
Thread-Index: AQHdOQq/ZVVR1B36oUiONki7DBaaLra3pBYw
Date: Mon, 31 Aug 2026 05:40:43 +0000
Message-ID: <TYZPR06MB498011A498561881D34A279CFCA92@TYZPR06MB4980.apcprd06.prod.outlook.com>
References: <20260831053658.462203-1-kane_chen@aspeedtech.com>
 <20260831053658.462203-2-kane_chen@aspeedtech.com>
In-Reply-To: <20260831053658.462203-2-kane_chen@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB6326:EE_
x-ms-office365-filtering-correlation-id: ae541ece-30ee-44e1-05d7-08df07226682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|4143699003|6133799003|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info: +GM5Kj0aYFf+yF2EJfE6EaHiY/TPl4PPWbKBsTspVHXz7fmtnYNPZ4vnGk1aoBJR3cuO+xNgJfQQ4Mx7LfqGAbX1NLGuJrh04wtsszxdov9dsFJ+DN+SUyf6YcdjT2pqZ/52LqMcnxPZVCr9ElTjvG4J6xUfMUwjAmX5h7ZL6PiQKzUAqHc5umLm/ocWgas/qO/6RVbAMDqc8fI+aKP1H5XTYod4n0Y5KzEh/UQOSDdfrg05KxUDS1R5zyDah+bp9aJERQnZG5DW6VCE9MR0lROc1BTX1Al6rf4b2pF72odEcsBZBG1js9wT+tQk3rdGEAOEeDQmDFYL3dw55M0AkQMA3HDMCKJGKfCSMeL0vLB4yYgF56tGI40Y45I6w+cVnTMTxwfUxx2XdHBalFfRKuqN4vMu7EBnwPUVkzGUMxmelsLXLLlS9GC3qBpRmsXC9HV6feoMh+hwr72q3vuXOAn/vAiI1MfnYn/H61ElR1yEY10SdjLHLoMgLZcv9T4e9VLXeSRURwU76hDAViPbUGy972WvjBuvI8jkrJeXBV8sU8aYXiLovjr9tJJPxp9gLsaLq7N9vhkk7CtBRh78uWrhqVnxMlYYt+Tqj0qnAJrLMZHT4gzJNJgWLBqEKyE9Woph14qN2eZdySBY4dBa5JfcUofNRbsm160ay4JbVtlla6D15QlQc8h9NdLGNjKR1tWrGnGVKoX+7ew/eh31RaTDDYrq7FdtJozCN85D3F0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003)(56012099006)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AUmae53GzswUtCFMqxOkMlCyebzdq2LDZtXMGyAh185eUUhNAeekKaxruz?=
 =?iso-8859-1?Q?LQ5d1FpobjY79/KNAURWm9aillJD3mC12wZpwHLIw3p0O6a+6Sw1mrsx31?=
 =?iso-8859-1?Q?6dMzbrJHmpDWDlJpGLWxkMQAE8rzb2WEPQAaUbUGNWsJDXpbzKW2LVOd3W?=
 =?iso-8859-1?Q?3WAyHFv3G0FTAiPmG6mTTMWr76RhCruNbQ7XGCqczlnAYGqtwT/Q2fgBwM?=
 =?iso-8859-1?Q?uXVNRG5EOHLYvno9x92nabgotmBTey9iEeEhhheZpIMRoPrlw+XgnWKwVJ?=
 =?iso-8859-1?Q?bh/xLo/k+vwaf0C3/BiXI9tzZmR28Fe7OTDI2ro7iTSEIBg6FDMJUBDYF1?=
 =?iso-8859-1?Q?jqwaMv0L8zf8lHMCV+JQldFmcW8ZwGbl14q3/t9GC4/40sNRAzKiRuRaN3?=
 =?iso-8859-1?Q?3deJm+F84g0j4/MYCT2mGD/SwF7aNTWbFOBXBAdJ+4g9ZCi9LODDOMX6DK?=
 =?iso-8859-1?Q?5V4R4hRZQbuZs6957cXpIRkA9AZNfAFAY26SfeTcdOqkY++kx6ijontpwh?=
 =?iso-8859-1?Q?DOuKfKnizv/ur9b89S7F2hiqelKbrKxgpoFfZrZdvpEECKGkM+kAAvb4sZ?=
 =?iso-8859-1?Q?/Eupewg3patQsK2zdIoxw49Ld+/igtXwo6e7SiRiWsRkxyma+HTyIvyqY4?=
 =?iso-8859-1?Q?qaf4B1wZ4K7Rr9BDFE5HbJUnuzz8bG74j37wFma6DwCvKELW+8AUcy2kCk?=
 =?iso-8859-1?Q?8Hh9EdYGKnolzJOIuGY178QAoqNFeoigdiR6WagRCRkNRmpU4CdOWU6xE8?=
 =?iso-8859-1?Q?332GM+64lfkQA7Sy/uEiYUTG3K890Y/B5Zq/V/w/Fi3pIejs+MK74CAsgZ?=
 =?iso-8859-1?Q?LyGT9wE2+4OwnltoFmr7gMCoor4i0aDbsuAxsXf9Pptev9lSFmkumcIreU?=
 =?iso-8859-1?Q?UshsYJf5yLJXf4S00H33aMZCC3qFqYb3wvBBMBa7M/571fyjuxoyPRhEEN?=
 =?iso-8859-1?Q?ATNV+Urho3op3/kbPeWxUYKpLTpV1nhzTZqvMWo9DaQyev1vOhhEWpQe0n?=
 =?iso-8859-1?Q?pYRI1OkR9RfBX6dY0298ZAWyHPIeMMICtQcN/XaAv6t6alm1iuMcN++m8K?=
 =?iso-8859-1?Q?WHzNMQ/ofoyvIxgPSv1o7S6LlF0WqbUKYRA57v9aILlWDYo8Tx3dgsSznx?=
 =?iso-8859-1?Q?AxcQcwHp+n1zQwFTLTk7gBKzn3PQUrWkGJvjvgPOhneUOkXNdt+qWjHc51?=
 =?iso-8859-1?Q?XNiepGBrTxfFtGdm8maPhLnL1YUBTL/LOCfB7F850WTPpV33nn4Dnyoxhg?=
 =?iso-8859-1?Q?hC5U4bRc91H0oGQwmuOspeJZ+3uA1xTtt66CnyZYr6i2RdtCCOfrGJOuKG?=
 =?iso-8859-1?Q?e8k6OUTgWAgUFEjxH8yd7wtqiYvjPqHRRwgL/L4LtczRcBcx8OczTPb9V8?=
 =?iso-8859-1?Q?U1GT2w0nr2sjFP1MqWA6mtSOfvMhaLvAJ9jZXAtO7LKjKpA+GHjPI4kZI8?=
 =?iso-8859-1?Q?ItOMdcjYMhsmBiBSWstDN0ULAnO8SVIl1NRL8th8iqZ8+6+ZZoeuymPe5H?=
 =?iso-8859-1?Q?zyN8yXvsq1ouXCVZomKiDFpxWZWufvk4++9cGcVuB6vi63O/QTkDwx7foo?=
 =?iso-8859-1?Q?R+DS9IqyeDcO9wGObeER/0edEPX7uUO7rHkpEvxYlwVPU5tl9fyZTbXL8S?=
 =?iso-8859-1?Q?vlJmxEj9DQeOl5Csj6Q1xH4rn7Oz2+8rLvy7VeoMqk8Alv8ECcNy/azF2h?=
 =?iso-8859-1?Q?xqRYRuOQSBWhgg6JQnoelfp5QMVj2veO6mSssFiWekA+u7E3Jm2kK3qNq7?=
 =?iso-8859-1?Q?I33V+ONnAhWbHm+ArRNjO3fE8tExnL8ls2UPqo0orZxXHojqCXkXWs650s?=
 =?iso-8859-1?Q?wIYtlcRRyw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ik/7dnsHyXQyZRp+Pbptxd07xD9NmtATk06TclovtcMuKpPx5r+JnOqgQ74az8mi4xNxdGuMYRmQLSvU2O0edyRIbFsjwiHdAg6b2RqagELTD8wjJy/PHdsYn/UvAqp3kP+e5FIGFtkZFhlSr6ZSV1kK7yyL39JoiKKONMt96t8LO5i5R8oGfTDw3KxVthM4YHlfCeGuzvJhfrPwDqWJIGXQklYoHqKnIB02ThkPy6TAubxeCHID8FPZ3PLIAzsP6EASrb6uqhViJeF1e/N260yy8R+lCJFmVZixwJLae7Du406E3O4dNtoW5BM6b/GjeOxxgT2ggBywLFqPaBH/pQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae541ece-30ee-44e1-05d7-08df07226682
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 05:40:43.9744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N5HS4IugvN+Wkj8FXMXkwyp/6r1R220dc0cNNkN6dbPYTj56JhjfL39wiVx4angykKJHvBPj7nDvrTg9aOnnOAoRRaTcoeLIzkjbo1aqEBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6326
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

> Subject: [PATCH v1 1/2] hw/misc/aspeed_sbc: Derive ABR state from OTP
> config straps
>=20
> The eMMC ABR (Alternate Boot Recovery) enable state was controlled by a
> fixed "emmc-abr" machine property, and the logic reflecting it in R_STATU=
S
> was broken so ABR could never actually be reported as enabled.
>=20
> Instead of relying on the property, read the ABR strap value directly fro=
m the
> OTP configuration space and derive the enable state from it, matching how=
 the
> real hardware determines ABR. The now-unused "emmc-abr" property is
> removed.
>=20
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>  include/hw/misc/aspeed_sbc.h |  1 -
>  hw/misc/aspeed_sbc.c         | 35
> ++++++++++++++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
> index 07c7c22a86..7152497b2a 100644
> --- a/include/hw/misc/aspeed_sbc.h
> +++ b/include/hw/misc/aspeed_sbc.h
> @@ -32,7 +32,6 @@ OBJECT_DECLARE_TYPE(AspeedSBCState,
> AspeedSBCClass, ASPEED_SBC)  struct AspeedSBCState {
>      SysBusDevice parent;
>=20
> -    bool emmc_abr;
>      uint32_t signing_settings;
>=20
>      MemoryRegion iomem;
> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c index
> 1dfcf14e5b..5d4da39d30 100644
> --- a/hw/misc/aspeed_sbc.c
> +++ b/hw/misc/aspeed_sbc.c
> @@ -60,6 +60,9 @@
>  #define MODE_REGISTER_A             (0x3000)
>  #define MODE_REGISTER_B             (0x5000)
>=20
> +/* OTP Address */
> +#define OTP_CFG0                (0x800)
> +
>  static uint64_t aspeed_sbc_read(void *opaque, hwaddr addr, unsigned int =
size)
> {
>      AspeedSBCState *s =3D ASPEED_SBC(opaque); @@ -261,17 +264,44 @@
> static const MemoryRegionOps aspeed_sbc_ops =3D {
>      },
>  };
>=20
> +static bool aspeed_get_abr_state(AspeedSBCState *s) {
> +    uint32_t value;
> +    int i;
> +    bool enable =3D false;
> +    int config_offset;
> +
> +    /*
> +     * ABR is a strap setting, and each strap setting consists of six
> +     * sub-values. Read all sub-values to retrieve the latest setting.
> +     */
> +    for (i =3D 17; i < 28; i +=3D 2) {
> +        config_offset =3D OTP_CFG0;
> +        config_offset |=3D (i / 8) * 0x200;
> +        config_offset |=3D (i % 8) * 0x2;
> +
> +        aspeed_sbc_otp_read(s, config_offset);
> +        value =3D s->regs[R_CAMP1];
> +        enable ^=3D (value >> 11) & 0x1;
> +    }
> +
> +    return enable;
> +}
> +
>  static void aspeed_sbc_reset_hold(Object *obj, ResetType type)  {
>      AspeedSBCState *s =3D ASPEED_SBC(obj);
> +    bool abr;
>=20
>      memset(s->regs, 0, sizeof(s->regs));
>=20
> +    abr =3D aspeed_get_abr_state(s);
> +
>      /* Set secure boot enabled with RSA4096_SHA256 and enable eMMC
> ABR */
>      s->regs[R_STATUS] =3D OTP_IDLE | OTP_MEM_IDLE;
>=20
> -    if (s->emmc_abr) {
> -        s->regs[R_STATUS] &=3D ABR_EN;
> +    if (abr) {
> +        s->regs[R_STATUS] |=3D ABR_EN;
>      }
>=20
>      if (s->signing_settings) {
> @@ -323,7 +353,6 @@ static const VMStateDescription vmstate_aspeed_sbc
> =3D {  };
>=20
>  static const Property aspeed_sbc_properties[] =3D {
> -    DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),
>      DEFINE_PROP_UINT32("signing-settings", AspeedSBCState,
> signing_settings, 0),  };
>=20
> --
> 2.43.0

Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>

