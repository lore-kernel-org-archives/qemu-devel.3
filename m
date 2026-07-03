Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB22C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 06:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfXeL-0007Tq-Qp; Fri, 03 Jul 2026 02:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeK-0007TE-71; Fri, 03 Jul 2026 02:45:20 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wfXeI-0003vj-Ga; Fri, 03 Jul 2026 02:45:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3vjy/wKPx9o8ae2LMeECTH0B/gRfE/j1+u5f310mFw4gJ0qdCEow+OmjGfCJvcimoA/HaU6xWRohZi+hAWP6KoYnal9fclHRm4MPDbmj8v1kHxyaA7u+lnOCselKKpEUuXGZhU9Dz5OOAyIpQ+f4ntMCX2E2XtSAl2Y5HddxqY+K61/4og4xBkdeIYI3ego9Fnxqdi1hxW+g5aivIuSjLwwaLLpZKoeXokDI9JRyyDghze/ylPg9kO4QbfFQUVpXxNwcvv+iXWTjsO1innBSyDCcoYG98WMFWQknAFQ+hWqVEXBJ/PB1Le2KjkRz6xyOS4V1zXV8xWtaZrd2s0WqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IG/mIx3zg1qz/S0rM2O+K049LYNd7vkISrmfOCt+G00=;
 b=hf06giFkNeshVV3doezrr9744G1eOHn+uMRJ3VTtVruPLACR40QNDNAkYjqQL+HgtYTn0B7WGNF7f7OOCZeJww9J1shcAVYuLEfAGzXZorYULFTFqsVkx2dm1+HUwN4KQIp/JaQJpYn/+98EhlBBwD/xR3qYGF84A0U3jLII72UhX9LJDBszM04M4HAZgyphIqP1jn0juC6aB8J73rJQ+o+9eI/N4mXGmlAAL9RyiTIgvW3NR1/Yqfr2GJhw76/CbdSvoPaOYwbSIRMcIXz176MMWpKLH6JJlo2enUJYUnGVJh5OZZXYD2qLSLfu5XTgQB52nbLNfQViHDOMwEiPXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IG/mIx3zg1qz/S0rM2O+K049LYNd7vkISrmfOCt+G00=;
 b=jW9qPtA8TCHHS0q89Wyl3Lpcy4afSJiwg0mbKO1tSpvRbO9gZi3dzFf0w8Haorr9a+W33je8vc2jicDbTT+tb09YtAmRSrPWY0wWBXjO+qHVPVOPOfoOBtilpuP+QFr/LEKjb3Mt1qtKUBjHvS3wULS28Yu/n/hz0PcQuIydBxQW/klJH5qpK+/sChkbyQ4/I8zn4FC8LA5E3hsHG5/N9ACPL5U0Avz7IMTFt/dnn3F4xI0iTcPWeY765Ye6FZdDKNjbaAzkPZC9U/vRhIK9JUJUp3Rf+cXSYvxBqy2K4LpV5Fy28kRRFnTRIVC9dZzPDeYmIsmyYhNqbIQzirjkrw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by PUZPR06MB5499.apcprd06.prod.outlook.com (2603:1096:301:100::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 06:45:09 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 06:45:09 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 2/5] hw/misc/aspeed_scu: Drop noisy unhandled read logs for
 AST2700 SCU/SCUIO
Thread-Topic: [PATCH v1 2/5] hw/misc/aspeed_scu: Drop noisy unhandled read
 logs for AST2700 SCU/SCUIO
Thread-Index: AQHdCrd9OX+OfxPUYkiIkU/UmZNxng==
Date: Fri, 3 Jul 2026 06:45:09 +0000
Message-ID: <20260703064506.937904-3-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: de156685-4c32-4d8e-04a9-08ded8cea02e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|6133799003|56012099006;
x-microsoft-antispam-message-info: KK6UfQn8735Nv9sphjsp01uqamyAsDqgWOPk2H1zC4KjuqZ0TcvjsJKZJ8nhttZwRPyb2vPwCBs3L3YRbHkpQLW4xACmYudAedlbDxcjWfcMf6e9a3mZEp5XlCLOy+xiAEqiqwWfycHbj33rvtZ8sJXT/rrnY1FE4QhxRcyO9gEpV1EZhKawkqIC84N962D/fnId9lWkysZ9eRpDzxGpgbY7o9NTArd7520JueWr0aRrH6DN8gkq4ORteO3iF+Sgnk56dKQkZBGijymfY0YPw5saKXi2S+eWBb9E9z+lx8S0fLXf6952rX7QP16BRXZsiXvjT+xddQ0XDD9D1Lq77mRpRmbc25cgBfDM6ziy7YxSAcFScNHn2c39tJuT/idN9+WxJbOV5n7e6WbbbsPMS+Umoj4cYXiE2DDI+GsYa8YNxBM95kGR1ub3FXdbWK3rN8Sce6mikXv79FIYkgipw18g+C63Ferad+YI7nExglyp4UPxyRDc9R5+jjkqdsDnG9qiocJaaSVApNzLpl0SCLhKiwqQJC8/C1jJq64ERjsS8enTFXs2q5PLp1ek7Nj5GhM+ibw80cdNCf23VETFMJOyY3LnBoIF4r9zAlu3hNbhOxy4AjDgl0CfY/6RCgalOAzDsEh0Mr9M7qm4+O/pneQ4A7ddytyPG8RlGp2g465VxZ6oI6+H3LAIRc/eHXssl6APO/4DLuVrH0/5D09zXqLJ6E813YsTqAbzhjb7YDw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(6133799003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QMUtms06Uo4OOMKTh8Vv49A2sp9N7E03MlE1SBZlenYHnMX9wy+Jg9ng3Y?=
 =?iso-8859-1?Q?Gj6EACQIFSxfu5W3EP14a189UXBnvM3Q9wAXTAJqCHvgEpO0o6AKJtc6iS?=
 =?iso-8859-1?Q?ArMabr1gtHFi4C6jwyJ+8Kek4+SbVW7jY518sk47fLswrKBaI5x0hGYU0e?=
 =?iso-8859-1?Q?6MhrAI60IiX1uOLxELY4ilO3KZYDA9UmpvYyi9oTdue5+C8Cke0u8CVXD4?=
 =?iso-8859-1?Q?Oc2h4Dfd4lYW4IuOLLM7GBU0IMuii8wjKAohhj8/+ySoFsc/lOLIBlaId3?=
 =?iso-8859-1?Q?In8KMjP/aLtYaTJlBDcGebkDQKXk5LtRM/otGVzBdN7WHUwdS93DbeK18K?=
 =?iso-8859-1?Q?44gVqndJEN2FDVfEOhGejiLTS1aQj+qn8fz3m4/dhyOVihNTKMXmqogTw7?=
 =?iso-8859-1?Q?N2Sr3T3od3sIzOoHzIm3QeZ0CGeeC2J4XjbEOH483S/mdqQm80Ds7/Wmq5?=
 =?iso-8859-1?Q?cj03K//+MVtLUK8Mzo+h5PbTUpJ/v12jzjxH0vinI/VGbgPcVLaUbg+/aH?=
 =?iso-8859-1?Q?iOUwMVQekf55/baQvQsCzPUmJmYdG8+TDUpaFDw8s7Yw7NPBlc+8sk2UGz?=
 =?iso-8859-1?Q?1jcBAj4u0Tu7RWr1Lr1aybWmDAc+ye8Re5rD7SMqsF6Qiv+Wo9+4tuoc8F?=
 =?iso-8859-1?Q?vXniLPirb7vPsUD9fY1MRQsbBregyspoNgHUpVCaDbCA22SjSdB180GYnm?=
 =?iso-8859-1?Q?PY3Xaq4/Lt4f/Ij8vfEO0xDBgtdtcojUOJdQzxqKsuACKjF5oX2vMpdf1L?=
 =?iso-8859-1?Q?tW9o1SQv6ZPzY5l7b0XlBfc7uQE8BF7UKTJdHXwBxc+yGwwVURc8r+jVVM?=
 =?iso-8859-1?Q?VMakxGSdZ9uUS+8hrzdlWtwmj+atJ6DfUsvg4XthSW2Qoqeg/nLGDUhQLd?=
 =?iso-8859-1?Q?HownIP8P1Vk6ypfSl/q73bN1nd3T4pkJ6BX8lI7oOwpTMcZXhrCi5KvBcy?=
 =?iso-8859-1?Q?3PbpG+x3G1SnQAqB4KKFbyDdh8KeYhTv+m9Gf+O0DCPj3P0g2ZFQdpBCLo?=
 =?iso-8859-1?Q?kmbYvx/Y2yze8rNeykRXpj+f0C2PL/1bl6RLWH8y1yF1a70UldK5mQq02q?=
 =?iso-8859-1?Q?fWmg253EGLklM6Cd0ts6aoBCXWL+5T401STXBEN1gcNdLLz4V5wa8aMNqw?=
 =?iso-8859-1?Q?1bMcuPquI3c4Bjw1bLJq7qsBHv8owDKQN/h14IY0ODVorlI9tDTAL65jTZ?=
 =?iso-8859-1?Q?FpQrqCmAYyjwjVBTf/ZxHrTsIljIj3DXm71oIsgWZp4Cf2Gej5DTocomHg?=
 =?iso-8859-1?Q?a0xiC7f5W57TvCAW+4wcBVgIHaGYkUQ1FYVqpHGf9wKRPjDdc6wwQ2UhtN?=
 =?iso-8859-1?Q?78sZf7tNHVOxqCK690JgD8ImlmplAjyq5n8OgPdAgFcEptKWBrZuz4J1KL?=
 =?iso-8859-1?Q?Z1+Y/2t45t29Z5QTD1IBN8sVllBZUGMipQgW4ZQ+CJlG+S4gxlHQNZ/tIb?=
 =?iso-8859-1?Q?UTWCCceL63CpKB0LsI88HmBx7DEhkTWX/Bnq5/3gnOb031llRhtLcKmNEy?=
 =?iso-8859-1?Q?jQgu17CWpO1ExeefQ//cLIrihCEtnTgZ+ekAr8nCZAXRMeLDRm/NmYEBRt?=
 =?iso-8859-1?Q?GWIHuATyrXnOdzvmuT0i3LYVgQNAMGo6WPlEyiJKxlz4qUwRXCsVle/LNa?=
 =?iso-8859-1?Q?nYAhTWLOs2kTIMAOD05znnRu41gJVFtEDHqXdMl3QpXX4P8QcT3ifvzqUU?=
 =?iso-8859-1?Q?jC6Io7x41iTZPjdTs8uz5zDNvR8hOiBMVif6bgpBDuwEVAhO4AnhWoISJa?=
 =?iso-8859-1?Q?k365vbVUMKWxBMlj6BwmGfUbMFFASUrfHP22aSMBCx/wO2meUnM4R84EMr?=
 =?iso-8859-1?Q?ONCtMToaQw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: dyMJahGziRMJo26CzamTtbpV3v8fDpPB7mdb3Y2lBQci4TMFTkcPnmR3DmoH9lfXcIB28zCwlx1Zzill2PFw4Zvmax8JmVUqh5RaynSGCpWufPqbR4ne1OZ64ulC7XcWHkCPBxwdxFYH0W6ZtBfvQuCrRMuM86XvYdHq73J9t9kPPcb26qpUREbECK1BNrZTePIbpwYflRTZP1MPBQnRjrl86cHD/FIl3vhLK1DkO/a3ecgakXjx6zGyvEzYmDF2pcieL1+2uypmp1FW2sPTOGuGNiNfJ37RPp6jRiKbEoI15GFnShBOIozj8rq+sOLZw1ZX8bILklfFAJBIpUf5SQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de156685-4c32-4d8e-04a9-08ded8cea02e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2026 06:45:09.5264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +oxw1Lghg3LpOsWmcuJMYAOK/3xOdmuEKYWFGFHCWPS92ecMjE5m713/vKf2ZLQUOJgD956eoW1+N1TmnhtVgEwi7OOfmxfPfhUzfCpr2gE=
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

The AST2700 SCU/SCUIO read handlers currently emit LOG_GUEST_ERROR=0A=
messages for all registers that are not explicitly handled.=0A=
=0A=
However, most SCU registers are simple read-back registers without=0A=
side effects, and do not require explicit handling in the read path.=0A=
Returning the stored register value is sufficient.=0A=
=0A=
Emitting "Unhandled read" logs for these cases generates excessive=0A=
and misleading noise during normal guest operation, making it harder=0A=
to spot real issues.=0A=
=0A=
Remove the default unhandled read logging from the SCU and SCUIO read=0A=
handlers to reduce log noise and align with common QEMU device model=0A=
behavior for passive registers.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/misc/aspeed_scu.c | 14 --------------=0A=
 1 file changed, 14 deletions(-)=0A=
=0A=
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c=0A=
index fe731a28bd..ed7f5e648d 100644=0A=
--- a/hw/misc/aspeed_scu.c=0A=
+++ b/hw/misc/aspeed_scu.c=0A=
@@ -849,13 +849,6 @@ static uint64_t aspeed_ast2700_scu_read(void *opaque, =
hwaddr offset,=0A=
         return 0;=0A=
     }=0A=
 =0A=
-    switch (reg) {=0A=
-    default:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",=
=0A=
-                      __func__, offset);=0A=
-    }=0A=
-=0A=
     trace_aspeed_ast2700_scu_read(offset, size, s->regs[reg]);=0A=
     return s->regs[reg];=0A=
 }=0A=
@@ -961,13 +954,6 @@ static uint64_t aspeed_ast2700_scuio_read(void *opaque=
, hwaddr offset,=0A=
         return 0;=0A=
     }=0A=
 =0A=
-    switch (reg) {=0A=
-    default:=0A=
-        qemu_log_mask(LOG_GUEST_ERROR,=0A=
-                      "%s: Unhandled read at offset 0x%" HWADDR_PRIx "\n",=
=0A=
-                      __func__, offset);=0A=
-    }=0A=
-=0A=
     trace_aspeed_ast2700_scuio_read(offset, size, s->regs[reg]);=0A=
     return s->regs[reg];=0A=
 }=0A=
-- =0A=
2.43.0=0A=

