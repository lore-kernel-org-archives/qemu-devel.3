Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059EDC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXeO-0007VZ-Fs; Fri, 03 Jul 2026 02:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeM-0007UX-I1; Fri, 03 Jul 2026 02:45:22 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeK-0003vj-TW; Fri, 03 Jul 2026 02:45:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O401hHrFNYFIcEA3cFPNrMDpV/6Yh+Zz6SFQLDt/491LtAdRS1ewSo8IjQ2l8CnMqk2xgVmTI2pm2QH0+y5K1k3yLBXBzNaCv4LUGWMjLtBg9Fq08BuCsv8h131AnFPHtEqye5VyCm4DQxSaXj2kMEVSCjmu2T2AmPN3jvTYQ9usL7blNgno/DH2sxB5dShW2TaeT11Fess00Q/YoNjoOnzoQKwFC9JzX3WsU8QZfMhCunXsJ712CCAdmoxToWxYTYpPWIfRQimDatVg7vrGJJ4xHNE5khq6mQu2jvysqRa9+MzKlALfFmZt9ST0bIYh+N/Xrfl9VBXlSAnxtaihCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lakpgZ2Q4MYJbV+Pu9olh0rvl8qptcjCupV8N9kxpE0=;
 b=eHbDbgvd74sMV55L9bi9CJ5uCnih4U1Yqdn9CWkvh3wNtuWNOVa6iXl0GxtvOU4ylHXq25LnjlAh/hGGw+2xmxvvxPxI78dTTLzz3z9WNW2VPmZLJvmBlJXR2DT486LNa+opQZZ+m2jahLdEdJlfm96Pu61/ywLRHi1PVH58mytaLFZrVO1JDVFaw7XwCjUnJHE7erqoXS3YuD7KBVjKppU9zsnOfsgAFfjd+5BBIQeNJMYX8jhfHJvtatZyhSbAufyN8+WNgrC/cSUfGifd1LrMN7BafSMPdA1TpttOgYKEbSgkiPXfUJszU2WZr0pcKGepWQxtDv2CnYk9xBbJKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lakpgZ2Q4MYJbV+Pu9olh0rvl8qptcjCupV8N9kxpE0=;
 b=XYaLXKoLQaOk1vHRdfLNgNSW1cE3n+IY0YD4vAr9rw2Xpxw/j/Pqc6xx4I1zPPrkAvBU6KsnR9NbOHKe+ldV5t8OfDcZvGp0IvA1ngmI+0ahPqq+XNo84pQl0ICV/xys+v7y0/vQHHQrhoiyxJVg21KnLrFvB9NSq4lTjX67CMjgN0JSAl3E9Hhz104zS7deeZjnM0VRU8FmELlh8pnfB5ucO0jkNqBjuxVwc3IxBmYUOmtK7XaD8K+DiMcv1v4BJ+M/KIkZ+p+q7mSLN5yaGkW3aP7JDVclQ+fnZ8Fqpi7UJ0rBeYdVr+7dRXy+88cGYvhpFp2l4XgnxTdbXzgtIg==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:45:10 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:45:10 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/5] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and
 data registers
Thread-Topic: [PATCH v1 3/5] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control
 and data registers
Thread-Index: AQHdCrd+iC79Vj4fL06LCsXU/z5kZA==
Date: Fri, 3 Jul 2026 06:45:10 +0000
Message-ID: <20260703064506.937904-4-jamin_lin@aspeedtech.com>
References: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260703064506.937904-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|PUZPR06MB5499:EE_
x-ms-office365-filtering-correlation-id: ccc1d50e-d538-4a22-2cf7-08ded8cea0d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|56012099006;
x-microsoft-antispam-message-info: frt1ZgidOk4iXYXjbkldlKc0BqoGP8e+o49bpLz6JsWU82rPalpBLtQD99gZhHNl4bjAGrSRB9Mz+6OIzNiNcVgqPIaL/lEgnTlYwjpcQ0kdV8CzPVd0CcivjWbJBez+QGX8NrlFUhbInbTvuYwzsyOHW2iVXJvtATWAJsP5pN8/rl7WniuUKE/Nd2EZP/6B5dOmUEXelwnf8jMWjQ/1dOjrc33iLzPnZTLJHkGu+w/oIoyjzB5qoir6nkhu5hDz48armVtYxO5qKQgKTtFsyufYkNh7mRQoHVfLFE+O46iRRTIr+Y8VgMuDHixlo2PRR3BhAujIpCybIdH9Y6KVCohbyadnX3Kqpp0esrNXDx6Wb5N+psJEX0fdBR3hLJ0B+5nWAeyB5MyL2JpAJLh9wbKrkosG3pxL/7WI0vIS1E6QUFhFPeOoOsOlxooDvxfAebGLzPj+M9VO+MJfhe9gULZWNAKST4DwCjOCadVfv4gqmhzyvkzLrvmq+cp9i0WFhWF9VZXD9exGsoseMASJs7QcnDEF2w4xS4m87SEGauD3UMIVVaB3x4Slkbf2wtcm+A+nny1ytU6UB0lMwUznFs+0uyVNsFLEiKNiMsxfEZVT5ZEQZuz585hCVM14gPdHS6G7x49gO/7b9s/j0sF1fJ7d9aUiRwUP7fL8kdillDKWxw42wV1OGkrn2ASitgIZ8nln2kX+EEgV+2hWu5AXaiU5WJBRceiRwOrKS4wv67Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ciq2hHYoAZg8FugU0+AthpMJb4BxlyED52Re0LNXUgxCr9zuZD8Jgd42OR?=
 =?iso-8859-1?Q?whYgHYQuZBb+jX8GLp16LrhbSaHjdElLLEfDxohoqZjLwYFDzikp4Ogdcx?=
 =?iso-8859-1?Q?EP+qI8XNMceyp6Kjiw9Vk20Zwz49uM1cVMnkaVtiyg4da2oo9kQgsB9c4W?=
 =?iso-8859-1?Q?qB37d1/QQQK5zpnoWXhpYEOm8QpwG92TVLcy8YIO30i/TKzXim+3ryYUSB?=
 =?iso-8859-1?Q?MlL3CL6wT0qFZeUxotkYm7qWmj5XY9BV6TndrDZa5i+c04/lJSRLg6cAsm?=
 =?iso-8859-1?Q?pn16QiGBNCh5tBtT+ZJo0KKwLn23qD7uyStjc6rnLfMlr2q2gOgj8x/DON?=
 =?iso-8859-1?Q?Pj50yVYdgs+xBYDMgBFNzB08oz2P1mhz8xA6+5NfCF+whKCCXfnTXkqviT?=
 =?iso-8859-1?Q?datLNus2OLkFHGltjeQ9V6XzvSVBhtBzv1NbbjH4MkGzDdf1UOP7duIRzE?=
 =?iso-8859-1?Q?J/fwqDA+CkW5rvlutaJsTVnYp97dFZaV11Mwq2gTpOXzoc8x074qj9Y0VC?=
 =?iso-8859-1?Q?L0TdjRM0HeHSUOOEeO+5O4cS33FI1W8ViOUNDWda6jCWuH9BLHaWmDnnv5?=
 =?iso-8859-1?Q?joR6g3R+Ra8u66G5Tyctruwrp+Kuxr4NrCNYZLYyjAaL8UBSkGgqoFMa6g?=
 =?iso-8859-1?Q?WGY7gVMytbByC4cZlKMC1EFmyUCiNKMLyolCNcF1UaIbv/iOlVA7PkM9KP?=
 =?iso-8859-1?Q?AbtnFWmpUmy+UeCO4S7sX+IspkjCQSkM8BL7avWJDgErSipm64FauvNX7E?=
 =?iso-8859-1?Q?BclvHWfbr3txOfQc9Q41TI7il9IObtgA8JPihVg17Nnhr0HmU0acXx5pNH?=
 =?iso-8859-1?Q?NmAKq5Y5PWCw0liisw49HvRaNuGaI5292tKZXZJt/YqO6uA1l3p1Xr9iSM?=
 =?iso-8859-1?Q?6g6UUCDVzl+HgXS9+In5quLFAbR70o24HbsSHmQP0rVfqqdcHDf0GE3lhr?=
 =?iso-8859-1?Q?Bu6vHt59OK7q0JwoXzaZQxxA7X/qyJlNU9PWO4bOCV69hUBsNOLgp5oLgL?=
 =?iso-8859-1?Q?V2BEjPC4T4DDuyjm0vEi0FXR3/YL4XL1ywR++ko85jQxzcVh6v83o4RgG6?=
 =?iso-8859-1?Q?vTwssIOu+qWSbEl95gJt+orLbil5CbS3vbd7nBmY/6OnjzNQOoh9T8Utmo?=
 =?iso-8859-1?Q?1ArYtksDFUpOLZAsmsyRXld/12auQJCyEfo+0eVeg+BMeUR8WXIJMG86J0?=
 =?iso-8859-1?Q?g1NySOtnOtSHRxDfMeWVWCBtY/UuYg7AYcdcFnnZQjsXsGjQ9zUGXK9NN6?=
 =?iso-8859-1?Q?Ms/4b3gUe5fKOm1qFoNiIjIIbZl7L0qGe+FHzi3Zo0xt9sJMAFWjJLzbrH?=
 =?iso-8859-1?Q?kTc/p2AggMa8GDbEAhPjmXU16+/iHWJePr8WS4ZwAWOJNLP4nPNTPVkQBH?=
 =?iso-8859-1?Q?gvNqNQ6sZgjOa8/hAmA7vUhPUEC2r0k9xGmfX7O+QWDW3oR4S8lY6whQj+?=
 =?iso-8859-1?Q?1WTjuxjS5Ts3+qGJEL1ebK+9qR1ZU6egFGULi5LNt9FVtUTCtCMyHIEVjA?=
 =?iso-8859-1?Q?7fs9CfhsuwZ6Y6n6NHe0wdh2klh1Gvs+ytZXWI2xmbk8P5Y0qeEq1UZWmd?=
 =?iso-8859-1?Q?ktICFd4lsgRxO69uBmR6ozHSHc7Gw+YClu/4O3S71Vsj5ODaZGWoFnxOk2?=
 =?iso-8859-1?Q?A8mvgudoXhT40q/BeHGe0UTaLdJrT9l7/l+e9jKO+hRiQKV6wA8HNAdprf?=
 =?iso-8859-1?Q?PAEbjyyAi16Vv60Pa3JQLTY5+pXB7SsxDSj31UnwCwnIFGSR8//7y3BZK+?=
 =?iso-8859-1?Q?UPmWWcPLzhqrm/71A/z/1NDh06oxuW2fvJehbl7MPYz8nEwQGilF9qofZE?=
 =?iso-8859-1?Q?phMoegBBdw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: q2kdrB3bJguSF1CBsV92/F+cqQ7MUDsyHc2igBNBlBxmr4L9pZk3qapZHlj/g1+GeaPz03UfrP80Qrknnbuy/N/f1YExj7RFh/qxk0YH7lNlNEAyCRXUT6/JsEy+mmD4gnRzWZ7avDHHuUYZJAahI/W0v9symbjQS6ly18DH7zTwO4N7zTCqklxhZlbqjT/fDIBR6As6sHW4oYgr5Iknhony8VbAv8474NQUSO3hxKC1ZySl2aBRuxQeN7fP2bA6g5+gnzcp/8zX4H0XVoViqg++Fx/oAQo14Nh8K3gbuUK95OI28xVeqwrh9IzmyFibM0H5cSWRX76IBKiCdl7g6Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc1d50e-d538-4a22-2cf7-08ded8cea0d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:45:10.5690 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eyJ7q7Xgvf91QrSQb3CjUk5x2DMKaf2/xg0jKMcriBsJXxOPCdGW0cqwmWwrnTBkMTr28kYYtmqLJqb06ob0GFjw+Y3SsvN8PRpLdilVybc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5499
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

Implement basic behavior for RNG_CTRL and RNG_DATA:=0A=
=0A=
- RNG_CTRL allows guest to enable/disable the RNG via the DIS bit.=0A=
  Only bits [0:3] and bit 5 are writable; other bits are masked.=0A=
- The VLD bit (bit 31) is updated by the model to reflect the RNG=0A=
  enable state, and is not writable by the guest.=0A=
- When RNG is enabled, reads from RNG_DATA return a newly generated=0A=
  random value.=0A=
- When RNG is disabled, RNG_DATA return 0.=0A=
=0A=
This provides a minimal functional model of the RNG sufficient for=0A=
software that expects readable random data without modeling full=0A=
hardware behavior.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 25 +++++++++++++++++++++++++=0A=
 1 file changed, 25 insertions(+)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index ed7f5e648d..5dbf81c0ce 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -160,6 +160,11 @@=0A=
 #define AST2700_SCU_CPU_SCRATCH_1   TO_REG(0x784)=0A=
 #define AST2700_SCU_VGA_SCRATCH_0   TO_REG(0x900)=0A=
 =0A=
+#define AST2700_SCUIO_RNG_CTRL          TO_REG(0xF0)=0A=
+#define AST2700_SCUIO_RNG_CTRL_MASK     0x2F=0A=
+#define AST2700_SCUIO_RNG_CTRL_DIS      BIT(0)=0A=
+#define AST2700_SCUIO_RNG_CTRL_VLD      BIT(31)=0A=
+#define AST2700_SCUIO_RNG_DATA          TO_REG(0xF4)=0A=
 #define AST2700_SCUIO_CLK_STOP_CTL_1    TO_REG(0x240)=0A=
 #define AST2700_SCUIO_CLK_STOP_CLR_1    TO_REG(0x244)=0A=
 #define AST2700_SCUIO_CLK_STOP_CTL_2    TO_REG(0x260)=0A=
@@ -954,6 +959,14 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque=
, hwaddr offset,=0A=
         return 0;=0A=
     }=0A=
 =0A=
+    switch (reg) {=0A=
+    case AST2700_SCUIO_RNG_DATA:=0A=
+        if (!(s->regs[AST2700_SCUIO_RNG_CTRL] & AST2700_SCUIO_RNG_CTRL_DIS=
)) {=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D aspeed_scu_get_random();=
=0A=
+        }=0A=
+        break;=0A=
+    }=0A=
+=0A=
     trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);=0A=
     return s->regs[reg];=0A=
 }=0A=
@@ -977,6 +990,18 @@ static void aspeed_ast2700_scuio_write(void *opaque, h=
waddr offset,=0A=
     trace_aspeed_ast2700_scuio_write(offset, size, data);=0A=
 =0A=
     switch (reg) {=0A=
+    case AST2700_SCUIO_RNG_CTRL:=0A=
+        data &=3D AST2700_SCUIO_RNG_CTRL_MASK;=0A=
+        if (data & AST2700_SCUIO_RNG_CTRL_DIS) {=0A=
+            data &=3D ~AST2700_SCUIO_RNG_CTRL_VLD;=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D 0;=0A=
+        } else {=0A=
+            s->regs[AST2700_SCUIO_RNG_DATA] =3D aspeed_scu_get_random();=
=0A=
+            data |=3D AST2700_SCUIO_RNG_CTRL_VLD;=0A=
+        }=0A=
+        s->regs[reg] =3D data;=0A=
+        updated =3D true;=0A=
+        break;=0A=
     case AST2700_SCUIO_CLK_STOP_CTL_1:=0A=
     case AST2700_SCUIO_CLK_STOP_CTL_2:=0A=
         s->regs[reg] |=3D data;=0A=
-- =0A=
2.43.0=0A=

