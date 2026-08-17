Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4571BC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvqHt-0004WE-Iv; Mon, 17 Aug 2026 01:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHq-0004Vy-0v
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:31 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wvqHn-0004hN-IR
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 01:53:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1F1a89xIehDsoZTUiH7N7cqa3yJDRFmvddw3/xQhI62Rak9+hPOWQAZDcEo0WzI5HzylmzKzXih0p2bONe+OnKJ6gYeRyWhcQMhm5LJgU5ff7L9bp3xA8cOG9AfBWT+QYld5NHhQif3B8gOFtuQfJx3Cq4/Ut9dSjgL9KzJFdA64M51MK+Kfc3Fi3pMBLRP6BgMzfvUY8XbAwxy2fm5Wa9fgFsaf0n11r8xw8A3zf++xr4NVlKIaHjppOjVDxzfoZTxGdmBkHd9wiMkqXdxCbG0/o0PL40OMg0bKbNaLTXCm5DpHpmudSh5zZNeHzPQlCeSkDpOkzwVdqTCCt6CXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkMCqUMMZ3IT0PRtLA+CNPNcUNo5IgeLgF2EaJyQ5ns=;
 b=AMNboRDPIs1FwN44OC4RFWjRESPzPenYPxdSPIr9S7V7l0FqRq+VyYmmqSsroFDmG3NAuBx+w5GQspQ7PcLb7/YdujWwxFSp+kaZxoJYpUYWxgVcfOB3dyptAyZOcAu+qOJHy00wNFJ6zAspikGoVUNrZJPFIwihFnxGhSxrQQgDaqzJ5KWMzvz83v7NUOLthiWf40++XAspJYugeCy0cyvydsJIYQ7zenTT2lauzjlJRL2ywa1+LxdVtevnywfMCiGrqpNW3baQHN/4pI9EWdw0/H77ha1smdvcO/C8SOdevX1OP7RP5NR8md0LzetdFre8h+SV8867n6ySxM6ZiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkMCqUMMZ3IT0PRtLA+CNPNcUNo5IgeLgF2EaJyQ5ns=;
 b=jWZAJUrqOTAxi5zNx2snMsWiPVLg8qAZvZpiETlAc+rCxcvAKTqFiy/3zSqG/R31JXwMAa9/6bmI3RnHhkWCsAG980XwTiP/qotBSAnSb00ZCZhcp9+QQpuIPFxq4dMAnzQbGVCb/1uZS2fDv2DbO6mFrgg2hXM2AvXZnBf6yENJWf3+vOnmA6eRs8YEhxA/AeVTt1HY4YAsFCShLK8baOG5wSh7sUjJjzJPpPuXky5o25NfGSQ0gFuC2PJjATCCcSFJK/6f7vNEGr7kDWob4O9zjjb23qePkxgD4gWJXdl/+D6jOvSbOt6avtQK3u/kb8k9GzeDcHJIIQ1Oe6+UmA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYNPR06MB8880.apcprd06.prod.outlook.com (2603:1096:405:3c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:53:19 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:53:19 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "philmd@oss.qualcomm.com"
 <philmd@oss.qualcomm.com>, "clg@kaod.org" <clg@kaod.org>, "clg@redhat.com"
 <clg@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@mailo.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 0/3] hw/usb/hcd-ehci: Fix Coverity CID 1685236 and check
 DMA errors
Thread-Topic: [PATCH v3 0/3] hw/usb/hcd-ehci: Fix Coverity CID 1685236 and
 check DMA errors
Thread-Index: AQHdLgy0wYrhLdAIm0eFVUnT+/YE8w==
Date: Mon, 17 Aug 2026 05:53:19 +0000
Message-ID: <20260817055318.3826428-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYNPR06MB8880:EE_
x-ms-office365-filtering-correlation-id: bea0e6fe-8750-4935-2808-08defc23d726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|18002099003|56012099006|38070700021|10067099003;
x-microsoft-antispam-message-info: 3anxB2WZRW0tyUSZqQMJsnYpJRO/SWgyt201vi8yHmr9zR9Hp1nVdfwqoOfOUyc6QHUtio0XAT3DNgeu/pT4IMN+VpTHTSsRZHVidrmcrtEbNiA8cr05jWuwT/sFwXm5Y//gp8tiSwFABie4MuYUPg80Bltfc1TRm+CODEFL8xRndzSMw7lq0lIvsXia0jpyBVn0I65wXJXRe7faQa0qsL4PshX5prWzkNXMepaih91ECtkTUyWZyZdiuUtmVzBzCleXBcJIy/am8WNWy6tS0o8bwDbbV6X0OdLIL0TyNDiK0CkvWCrcxU5wWQy0RH/eTJNQNueVgDYffTFJf5WYiDOVYLt9v+Y5kIbzTxkOqJ7GayZjkWqw5Xou81sS6TLsFp6AmxKboVSnJMjeeAKnsquopLnxTRMVFuRHToLHtGB4ZlCWJpG5IgjjHrGI6pqmy4A/SfXFk8iQ3To5YAs5gGMgvYyFYe9HYPF1/6X9NxSAPZEepY3x3X3Jzul99+usZ52xGXJZYCYbKkq2GYcEzTa6KzBoaw+vqXcwcMQvA11+qme+ISs2dwyTzYr2X4iE47HBl6P/pwDtYLfSGYC2nWO79aDjK46YFfUD/2X49yfoT23NrjxlNDhgpdNpuMkFylVu7NdHpYBji2NW3G00/I+9iRAmBaFwFOFx1ypdQDMB0tWIYUZmIXpiElo846NXs6JtJnbCPnu/C9rwkM58fMeK2itvLTsYFv6u4xectTg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(56012099006)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ygeM3R2KgAz2Cz9/5qwBk+ojqslXidnj9ogoBvPNAo2i3UXADm17RRPdmp?=
 =?iso-8859-1?Q?tovMJIogbCJJAsq2xrbZ3nXBakzCiAnvgaRnWqDI6+L0NshFh+K//gizJg?=
 =?iso-8859-1?Q?ApwRHR6F7+aKFelWxnE7k/TNWC4JnWoc0NaChSj7hbOonpI8AWLBJM6gXc?=
 =?iso-8859-1?Q?msI0nCKxWTxCRiaBN3cjN4ScNlrgvKLsNKiztb4z+fLEtbYf1Bwygs5bZB?=
 =?iso-8859-1?Q?paKpzEvfOj98RCqMAAihmZ7N+VW4rNVqbOxDsD0xkHvR7cVbox0XYfJ743?=
 =?iso-8859-1?Q?uMZYzkAwYZKyPaze8fcA4qRHWdq5ZT9JgUYrL/BDJoUpw7lIgMB+7iARNH?=
 =?iso-8859-1?Q?1m4265afOMPdAMsjwyFzM/fg8qfLrWyhW1TcohGCL86iFrmamEIwutVvM/?=
 =?iso-8859-1?Q?Jgwg6ZIjpH3uNc7rCyMpaomjQcXVb8g57WxFg0EVo+xF/1BpMOgKxaPOd/?=
 =?iso-8859-1?Q?rHfXHK+IOFeK2TlfefeRz6ZQjs86GW9Z4ZgJFh5Z2YMRU92rV04sqjkRb+?=
 =?iso-8859-1?Q?HPu5B3+12qwPXsLRPMkpUusi7+SKmHMGz32Bz403ds3yknTWdFmx3tp26Z?=
 =?iso-8859-1?Q?CH3v7yqP2pb3g4c7LocDLiTl5T92JF26GVKIJNe8eq02P0I7dbd3jK0MUa?=
 =?iso-8859-1?Q?Dxg1nQtjrAA6nMp9JS5uL+JXe0DxQGDaWhilz0MpjKti+EZUlznmd4piOV?=
 =?iso-8859-1?Q?RHJv/TxjN1ZRw+HwqrbeQyhUetuwvyCdoGy4tjbC9tSvWeX5SIeqJpznEj?=
 =?iso-8859-1?Q?r5uPVs18OoE4id6GY8e/dK+/bdx/AiLTO00zmek8BhhzSjr55hm5shYlUi?=
 =?iso-8859-1?Q?o/0DOb5FPB9RbYHiOsqSa6DrAHgr183OguX7u27pADU3VWVvjUILtGfkox?=
 =?iso-8859-1?Q?yiSpCIDN6hwwiWbaf4knrOx3ITuGoFQoQO9B2fPIocSwB9AF4L2wd4L5Qb?=
 =?iso-8859-1?Q?LPDy36iI+3r/+LH3sf/knlDi7s9N43YM34V0sW1tEXogGo8daWAkvMJdNM?=
 =?iso-8859-1?Q?SMij7m9dLiVRX3umoJrXAeRp/lmQ2Osk+31/wZI/3ulWvetWbb2/Wpsg6z?=
 =?iso-8859-1?Q?9BJQikrfx0GRUoOuMuZap/tZv1adjm0BuAspn7d/SKq9yiMYDfStZY3iAZ?=
 =?iso-8859-1?Q?AU1pqyJlSJy82nd3XdRAORvT5LTfaG/VEBGscHOkKzAFNWtVStekEqPeWB?=
 =?iso-8859-1?Q?hjzQXlukWSBLUGARUk8tI6XPzmluY4UPqBCPBQdmIFJwvvvVQ/2XGlO+IT?=
 =?iso-8859-1?Q?EMnc7cnnBvhIHZWZedvUkbW7Ed54O8GxVSf+atEMPhqdK4NvsfiedRnz/U?=
 =?iso-8859-1?Q?EvF4k4ku5L9bm/uiHrRf6zyQ69JYUetTd2qqsKmgTDRHGnnv84Yj7KTGqc?=
 =?iso-8859-1?Q?PAmPgR/IOjfZ5LlXNiXdD5oJD8SwMphTN3GZt0UQ6LBDiD4B26clbp/D98?=
 =?iso-8859-1?Q?LtkT0DoWadgxYBvnmJj39ax/pHW7ziOVO85m09PeKYeeXyRHQE3iJAcZ4H?=
 =?iso-8859-1?Q?cOT5S8XWZ8bJkYCATepeyhsm9hkSOBSkuMjqRmANbRsiBQmuRQszwqfAap?=
 =?iso-8859-1?Q?WBsX4QgD2AdS2C/RCsAbJVQpmplBNb0K4nqNQ+jJ4CwYb9vASxyl3cYo7w?=
 =?iso-8859-1?Q?uqlZ04tQhVNluzkg3c49IH1leFEsGjOmUTYY1mabCM2OqmVeU0TI1bqcPq?=
 =?iso-8859-1?Q?bngW0eyFOwJcxcX/GjQWhy9gG1IKv6BRwQL3UdG2imd3QLqhpOuoM/uKx5?=
 =?iso-8859-1?Q?DqjQUTYVMIyt4208Ko8lh2VNt7oNyRLtEVQw/2n+JcCopDiPKW+qK4FMfV?=
 =?iso-8859-1?Q?sn2H0i9ClQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea0e6fe-8750-4935-2808-08defc23d726
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 05:53:19.6164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WojVTARelMQV4JcaHW7D9uIqQ7JDwvQ1BLGh6eF0B57EeGtk7VsupZen0ETYZcstH4LSH8I6pi6D1nOCJzbCNbO2WIfVELYfpDXpPkkYWXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8880
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

v1:=0A=
 1. Fix Fix Coverity CID 1685236=0A=
 =0A=
v2:=0A=
 1. Drops the dead NULL test and checks the actual accesses instead, and ma=
kes put_dwords() return void=0A=
    since no caller can act on a failed writeback.=0A=
=0A=
v3:=0A=
 1. Make get_dwords() return bool=0A=
=0A=
Jamin Lin (3):=0A=
  hw/usb/hcd-ehci: Check for DMA errors in get_dwords()/put_dwords()=0A=
  hw/usb/hcd-ehci: Make get_dwords() return bool=0A=
  hw/usb/hcd-ehci: Handle get_dwords() failures in async writeback=0A=
=0A=
 hw/usb/hcd-ehci.c | 90 ++++++++++++++++++++++-------------------------=0A=
 1 file changed, 42 insertions(+), 48 deletions(-)=0A=
=0A=
-- =0A=
2.53.0=0A=

