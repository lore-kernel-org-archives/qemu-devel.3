Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCACC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtcuL-0004Nu-LY; Mon, 10 Aug 2026 23:12:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtcty-0004ES-Fa; Mon, 10 Aug 2026 23:11:42 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctw-0004JO-9O; Mon, 10 Aug 2026 23:11:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8fqVyYMB5V01WoVqU8xRoZDEOshO9bvF0i9TM6IW2B5eECPAtHZYHzh4B0imMut6rLxwaZkR2HuLIAYTAVRlLUE5wt5lHDzj8/BL5BUbelnWP5+CYHhicraPkb8VSdo7qWfm3IJFZzoa/jiEVbPQYBUNP/PuX1A4CRjicM9jHBQqrcl3PPYShNnVy8HT2GRcUp+GGae6bJrItzqaYptUEYIXEopyJHqTY+T3pfny8FGDInZoGAJ/y/ClJTv2rdcoPCgCzyzfkQQOofG4wrDc+EDTwsFP3waYvX29neHVUzDeNITwirReTQuItudBSSlHNfZoeRLAgcgxk3ZCebWSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqBW7h3RRRrRSEQozfoyesfbAwwmAPRjgRrzBhBsKaU=;
 b=p4/AQ0X1F+22I9BsL1mrSJYrshUxMbgTSaC2NxtDhhjqS9EWcuPguDehk5HiBpAIsMzI7QCyTJYVzCDKLJ+cnR9ERm0394R/V9ah+EmKGY7QUMmadoZ7jqNbf3/YHSOoZAPFj2CyOU4f0U7OFsxmtw58flFRdiIcC/X0NQRauPpal0e7d8ZGRgpsx17dr9Qs8Cf/H1pxxIrVtgvPJjvrIXNUAX5I1MxFNwY2VLi3Ia1kFEldckywd2HbSVD59vxPPLv5YQJ1PEMCtHUPpQFeoc8GrpsjWDa+1TOf0sMUWojCjpG90YGhoJvs+PImMiOaWVcbYPyyUs2QY1VQ479SeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqBW7h3RRRrRSEQozfoyesfbAwwmAPRjgRrzBhBsKaU=;
 b=Kww6vfl4uIJSyHKVnBI8axw/NmHr7qCcw7GXVM1UaVc0Hq7FPX9GeTvUQUdIpWOQylOT+Y6lf9z5vd68eMpztgnTePO4WuNsQquBQZgPmImZx7wG4QtTJFUXsuWojSC3+0KJ8is7B0ZKHcfSCliKI6L9uHyL5snrfS5QDiCQIQK4fKhM5qZe3UByjgEmLnZVpHItnMYq96bDfktysZOGY3j05ZjE1p8MhqSNY9hyauBqOD0xQXn+FSmTnbhR6uiKCp+i+RHGEYek58L5q040DYnX2HEGEnOcgKoCdOQM7Muku7+HZTZl9oeqkyWk6RDYVyU2GQNXp3AA1wv+KdQtkw==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:47 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v3 16/16] tests/qtest/aspeed-hace: Test the crypto command on
 the AST2700
Thread-Topic: [PATCH v3 16/16] tests/qtest/aspeed-hace: Test the crypto
 command on the AST2700
Thread-Index: AQHdKT8BAXhLi0V2W0mEofX9Ox5htg==
Date: Tue, 11 Aug 2026 03:10:47 +0000
Message-ID: <20260811031025.2784489-17-jamin_lin@aspeedtech.com>
References: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260811031025.2784489-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|TYZPR06MB5808:EE_
x-ms-office365-filtering-correlation-id: f30a62a9-2aff-473f-4104-08def75623f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: veWcVEVj0Dh8qS5zg7mvcdFa7iyz7y9fNPSMAgnOjOC3j7N/byIsALsj53sZksrcnAI64H9bw8YReOz3Kx6Y8dsTWE6J4yddV4ayBDtZOMVeiUXDEWQ3M3fOCBdYWlBZS1GBQo0DzTvTKg03YKxi5+Ql+VBqftpUBDVUrOeE419jS9SAZNmbAFhp38mtR07rWJnWRl1bF3WoImm6RAlxwHOxBa91asrA4UVaQFvE1TlOut09bmGouBvRw/Fu9dC6zyzNQm/fk8kDxvRC3mrMul3byAMtze/yAURvmZwURu0GYeyHSWaWTqJGahFo+UkoEGwQJDr+4joSWiyLKueaRWZduH0nYNfiAjj/zBG2gR88snoHxg3iHfgTp/Lfm1/aSqU81mzPZPIXObRion7j/lluiDpwnZp39FJFUlA8Xp8JDdUJl4oinTPCoHH9jAdXv7ZqQrHJtNnn96h6ArgT9Hw0IsvqB6LbZOrgFXhFgCQJN36JHFG+evHBAkKiGejEgS/sbhClnGBDRjOW2sQB5mvcJX/1sUPH1ANY94rMSU9Q7S5EbLCUaMFnkybxxVGPkZJXVIENng9osGkyk3ugAdZzG6CTuGIssxGQIFGOJKu5hsNIY3bppAamD2YE+jH3RThjdvCAaRmscSGo0cEnfPqfiUHaUMRws0RaXv4L2tdjqjiTnDxkBdEP/bDO0pbiBaU3QzrGGN/zew53qQf8qV17NXDvjTq5yN8xDsyk5O/xPYgJgf2KyJEBKg4aeDTu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rad+cfTjlt3/oa0A72mxkRUrRnvtLk4PGI72UVGcMPevctxFpC/FFAWVQy?=
 =?iso-8859-1?Q?bdt20HEu7RMsbWJfUnQcvWrFSckvUaSxZ+ZZfZ1P5fWD4ZeWMBdG7zXGvt?=
 =?iso-8859-1?Q?evUJPQp7eSLOaRcduYw0pPCdFAz5P3T9EdWBdYokBmhXiz/lvKGcE1N/YD?=
 =?iso-8859-1?Q?nQPtnqzQ/9RC8X55oOPGzu4vjWET9CGzKbeOerxo36+GOAI91W+8Z2TP0l?=
 =?iso-8859-1?Q?ll9OAnVT1n6nzBPmY4K7XyZRtxX4EJ6cfOv4AQKes2AHlH/q54ceziomy/?=
 =?iso-8859-1?Q?VNAE8NbNkVzitbITGdmWSmZn5lCpVcvmsbjv5ZvY/Gk7HaTlyZoQzao338?=
 =?iso-8859-1?Q?zZKRLRTfBngAwDZIJT21YRh2i1I+aK9BJHIdUI2mKxSV/915d7TGZuqCCy?=
 =?iso-8859-1?Q?a7JxKu01O22rFAx++eNfKEZjWXV15IJjogHVv5kcgnBGGPbP/mMFOC5iN/?=
 =?iso-8859-1?Q?rtF4xzt/VRoN4sWcEvAKYwJxRkDmNJ6ZIhb+Sc0QlDEdebtoAW6c7v2nPt?=
 =?iso-8859-1?Q?WQQt5MxQtNZY6A7DZYY9/1MDbuKeietBTtOn5wa/Ww9nsl35BnK93K/R6e?=
 =?iso-8859-1?Q?ErwDyxpTzCS8XDNEJ+PqLhRf5Yt3Uo4uLgRHbLan71bIO6B1ayqAMcGPU0?=
 =?iso-8859-1?Q?JCMjHBPoKOcjiJIQ18U4gv4Uff/2RiCRIpPSBhYuHQGs8T0xNu8mOOKKNu?=
 =?iso-8859-1?Q?s1S5t0oHUgpGIiIhiyxbPl1186SDEXrsN/smZGgi25J4RhqtPYU7vEnymy?=
 =?iso-8859-1?Q?V2gp/X2Js8Wb1pxeCcjl0/PG1Np3LRtLbB/QTNMEbmMJBQQKxTvUdKo5j1?=
 =?iso-8859-1?Q?gDBlxrIbQt3oI5WzUbYlimX8eQlRRIFkUuPvGQ1/oEmMY36afRulpBPgTw?=
 =?iso-8859-1?Q?Sx/546fSpd0QBQXuTbXFI6cQoQSd7dEC9Dv46doglF8hizL+oyVtvnVq/d?=
 =?iso-8859-1?Q?psx9qLt85Mwt6FuiPisY/jQHQJkVfHNWguo3fG85ny8lUuaScSkSZKuBWn?=
 =?iso-8859-1?Q?lGIy72nyyInTnV7cH3/HKX8YIBQL3EscHbAqcdaf6rgEmhAoEmPWTqLRLr?=
 =?iso-8859-1?Q?XJLu/bvfxKmQvlcTUV95ikKWIOgDSOcfoHrQbLp7COIy4MrowWmDuetoM1?=
 =?iso-8859-1?Q?eLh5yhv9pNHEIFD/oYpd4tMTjnDeLUiXo8lWSJlhK3nIyNwaTwUcQY11Uq?=
 =?iso-8859-1?Q?KUlwwVY7dKUeP/XjqoAcQPusiYDLZgS7Y0xkg96JyMOuoKo1xA+8TYfWd6?=
 =?iso-8859-1?Q?qoaN0nhLw7sCWbx8eb/wUAp4grqO5PrcyZHk467dlZ3jOsfqUKS0pJH3LF?=
 =?iso-8859-1?Q?KeXb9s6NK9C144xMsasa2/IY4/hAUNvNmG9eylctN92i2Xj7PmKRZ8WCIN?=
 =?iso-8859-1?Q?ivQ5djNYSBC/IjewabBM7sOJqJgX4LxeMsGPIygXbfHVDWiT8MSxyKLVDg?=
 =?iso-8859-1?Q?/Rzv0vDOkoW3Suu/pTEpCU6lYwfEt9E3oX/SErhm2rSePdqGbx4r7O2VHO?=
 =?iso-8859-1?Q?e+Px1bgzCyV7XtMsDjM6IJZEbRbIMioqCz493RTTPpQdN4vbfbG3V8R9ur?=
 =?iso-8859-1?Q?DFzYdlY/gkJp1dP7/AIubnTqrP32t7GEMHpjpyRXuSkndI7edibuBpuaUl?=
 =?iso-8859-1?Q?LGTakCeMM/hpvq2J7TxvRHMvj7MGmj9dJjmyZRGRZ4wAACVmMOSKr2i7KI?=
 =?iso-8859-1?Q?mwALO6zidiE7TvlJZKXkElYJlE6SKtwdymdR4cf7ZXx7B/GRwfcp/8+wQS?=
 =?iso-8859-1?Q?6s+eUzsOUJE5SooBjA19p0Lh1uJgTqynNKY92OVaEJFCKdnkRdlL1D98do?=
 =?iso-8859-1?Q?wy1XgnbDkA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nYz8gXvS1opFjwedHmUaTWGO8IOm91c+9VRcMPJf4i15Vu4FiGTJKcp3S5NHIwCvURiWd9ojDoyfB0tOfyAoFSMimocGQieWGmwoA15+VS5g8kmrGpwZ19LwO10NBkCbPKjFNIVyJO6lW2KRwagcopkUvdCMlKX3ZfrY7RDzMU/QepSDeng99hQQb147wOBM+gIb2DKDn+1ocx8x/KpIukNHAMuQgMF20crOvo0V/SK4qkiWwa1k3Xp5cGkzOhJa5zI4x5gmx+qoDd11CIVPd6YYXxZ41Z66NdEZPu3vPv5sRx42nk8gRTk6NFZQL7I4oGYfqRmttrsWlJmE/4xxjg==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30a62a9-2aff-473f-4104-08def75623f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:47.5234 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9gvPWbUFZKmEX6+vJ03UC/pHODI6dEvtN07CFN2EFjUQxsd8s6LDNXAqdY/fwtItEx5vKb8yxpGa0WETVZGbD55+AuT/wenADMvq2/+aYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5808
Received-SPF: pass client-ip=2a01:111:f403:c40f::6;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=SEYPR02CU001.outbound.protection.outlook.com
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

Cover the AST2700 crypto engine, which drives 64-bit scatter-gather DMA=0A=
and adds AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.=
=0A=
Add AES-128 and AES-256 GCM known-answer vectors (GCM specification /=0A=
NIST SP 800-38D, no associated data) and a dedicated GCM runner that=0A=
programs the tag buffer and reads the tag back, checking it after both=0A=
encryption and decryption. Register the AST2700 with all four modes.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 tests/qtest/aspeed-hace-utils.h |   1 +=0A=
 tests/qtest/aspeed-hace-utils.c | 163 +++++++++++++++++++++++++++++++-=0A=
 tests/qtest/ast2700-hace-test.c |   9 ++=0A=
 3 files changed, 172 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/tests/qtest/aspeed-hace-utils.h b/tests/qtest/aspeed-hace-util=
s.h=0A=
index 82b0b3f93d..a5601a3d65 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.h=0A=
+++ b/tests/qtest/aspeed-hace-utils.h=0A=
@@ -86,6 +86,7 @@ enum {=0A=
     CRYPT_MODE_ECB =3D 1 << 0,=0A=
     CRYPT_MODE_CBC =3D 1 << 1,=0A=
     CRYPT_MODE_CTR =3D 1 << 2,=0A=
+    CRYPT_MODE_GCM =3D 1 << 3,=0A=
 };=0A=
 =0A=
 /*=0A=
diff --git a/tests/qtest/aspeed-hace-utils.c b/tests/qtest/aspeed-hace-util=
s.c=0A=
index f582c88ef5..260eec043c 100644=0A=
--- a/tests/qtest/aspeed-hace-utils.c=0A=
+++ b/tests/qtest/aspeed-hace-utils.c=0A=
@@ -654,6 +654,8 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CRYPTO_CONTEXT      0x08=0A=
 #define HACE_CRYPTO_DATA_LEN     0x0c=0A=
 #define HACE_CRYPTO_CMD          0x10=0A=
+#define HACE_CRYPTO_GCM_ADD_LEN  0x14=0A=
+#define HACE_CRYPTO_GCM_TAG      0x18=0A=
 =0A=
 /* Crypto command bits */=0A=
 #define HACE_CMD_ENCRYPT         BIT(7)=0A=
@@ -666,7 +668,9 @@ void aspeed_test_addresses(const char *machine, const u=
int32_t base,=0A=
 #define HACE_CMD_ECB             (0x0 << 4)=0A=
 #define HACE_CMD_CBC             (0x1 << 4)=0A=
 #define HACE_CMD_CTR             (0x4 << 4)=0A=
+#define HACE_CMD_GCM             (0x5 << 4)=0A=
 #define HACE_CMD_AES128          (0x0 << 2)=0A=
+#define HACE_CMD_AES256          (0x2 << 2)=0A=
 =0A=
 /* Context buffer layout: IV (DES at +8), key at +0x10 */=0A=
 #define HACE_CTX_KEY_OFFSET      0x10=0A=
@@ -794,6 +798,59 @@ static const uint8_t tdes_ctr_ctext[8] =3D {=0A=
 static const uint8_t tdes_ctr_ivout[8] =3D {=0A=
     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };=0A=
 =0A=
+/*=0A=
+ * aes_gcm_tv_template[2] (AES-128) and [9] (AES-256), from the McGrew & V=
iega=0A=
+ * GCM spec (also NIST SP 800-38D), no AAD. Both cases share this plaintex=
t/IV.=0A=
+ */=0A=
+static const uint8_t aes_gcm_ptext[64] =3D {=0A=
+    0xd9, 0x31, 0x32, 0x25, 0xf8, 0x84, 0x06, 0xe5,=0A=
+    0xa5, 0x59, 0x09, 0xc5, 0xaf, 0xf5, 0x26, 0x9a,=0A=
+    0x86, 0xa7, 0xa9, 0x53, 0x15, 0x34, 0xf7, 0xda,=0A=
+    0x2e, 0x4c, 0x30, 0x3d, 0x8a, 0x31, 0x8a, 0x72,=0A=
+    0x1c, 0x3c, 0x0c, 0x95, 0x95, 0x68, 0x09, 0x53,=0A=
+    0x2f, 0xcf, 0x0e, 0x24, 0x49, 0xa6, 0xb5, 0x25,=0A=
+    0xb1, 0x6a, 0xed, 0xf5, 0xaa, 0x0d, 0xe6, 0x57,=0A=
+    0xba, 0x63, 0x7b, 0x39, 0x1a, 0xaf, 0xd2, 0x55 };=0A=
+static const uint8_t aes_gcm_iv[12] =3D {=0A=
+    0xca, 0xfe, 0xba, 0xbe, 0xfa, 0xce, 0xdb, 0xad,=0A=
+    0xde, 0xca, 0xf8, 0x88 };=0A=
+=0A=
+/* aes_gcm_tv_template[2] (AES-128) */=0A=
+static const uint8_t aes128_gcm_key[16] =3D {=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };=0A=
+static const uint8_t aes128_gcm_ctext[64] =3D {=0A=
+    0x42, 0x83, 0x1e, 0xc2, 0x21, 0x77, 0x74, 0x24,=0A=
+    0x4b, 0x72, 0x21, 0xb7, 0x84, 0xd0, 0xd4, 0x9c,=0A=
+    0xe3, 0xaa, 0x21, 0x2f, 0x2c, 0x02, 0xa4, 0xe0,=0A=
+    0x35, 0xc1, 0x7e, 0x23, 0x29, 0xac, 0xa1, 0x2e,=0A=
+    0x21, 0xd5, 0x14, 0xb2, 0x54, 0x66, 0x93, 0x1c,=0A=
+    0x7d, 0x8f, 0x6a, 0x5a, 0xac, 0x84, 0xaa, 0x05,=0A=
+    0x1b, 0xa3, 0x0b, 0x39, 0x6a, 0x0a, 0xac, 0x97,=0A=
+    0x3d, 0x58, 0xe0, 0x91, 0x47, 0x3f, 0x59, 0x85 };=0A=
+static const uint8_t aes128_gcm_tag[16] =3D {=0A=
+    0x4d, 0x5c, 0x2a, 0xf3, 0x27, 0xcd, 0x64, 0xa6,=0A=
+    0x2c, 0xf3, 0x5a, 0xbd, 0x2b, 0xa6, 0xfa, 0xb4 };=0A=
+=0A=
+/* aes_gcm_tv_template[9] (AES-256) */=0A=
+static const uint8_t aes256_gcm_key[32] =3D {=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08,=0A=
+    0xfe, 0xff, 0xe9, 0x92, 0x86, 0x65, 0x73, 0x1c,=0A=
+    0x6d, 0x6a, 0x8f, 0x94, 0x67, 0x30, 0x83, 0x08 };=0A=
+static const uint8_t aes256_gcm_ctext[64] =3D {=0A=
+    0x52, 0x2d, 0xc1, 0xf0, 0x99, 0x56, 0x7d, 0x07,=0A=
+    0xf4, 0x7f, 0x37, 0xa3, 0x2a, 0x84, 0x42, 0x7d,=0A=
+    0x64, 0x3a, 0x8c, 0xdc, 0xbf, 0xe5, 0xc0, 0xc9,=0A=
+    0x75, 0x98, 0xa2, 0xbd, 0x25, 0x55, 0xd1, 0xaa,=0A=
+    0x8c, 0xb0, 0x8e, 0x48, 0x59, 0x0d, 0xbb, 0x3d,=0A=
+    0xa7, 0xb0, 0x8b, 0x10, 0x56, 0x82, 0x88, 0x38,=0A=
+    0xc5, 0xf6, 0x1e, 0x63, 0x93, 0xba, 0x7a, 0x0a,=0A=
+    0xbc, 0xc9, 0xf6, 0x62, 0x89, 0x80, 0x15, 0xad };=0A=
+static const uint8_t aes256_gcm_tag[16] =3D {=0A=
+    0xb0, 0x94, 0xda, 0xc5, 0xd9, 0x34, 0x71, 0xbd,=0A=
+    0xec, 0x1a, 0x50, 0x22, 0x70, 0xe3, 0xcc, 0x6c };=0A=
+=0A=
 typedef struct CryptTest {=0A=
     QCryptoCipherMode mode;=0A=
     QCryptoCipherAlgo alg;=0A=
@@ -801,10 +858,13 @@ typedef struct CryptTest {=0A=
     const uint8_t *iv_out;=0A=
     const uint8_t *ptext;=0A=
     const uint8_t *ctext;=0A=
+    /* expected GCM authentication tag, or NULL for non-AEAD modes */=0A=
+    const uint8_t *tag;=0A=
     const uint8_t *key;=0A=
     const uint8_t *iv;=0A=
     const char *name;=0A=
     size_t keylen;=0A=
+    size_t taglen;=0A=
     /* algorithm | mode | key size selection */=0A=
     uint32_t cmd;=0A=
     size_t ivlen;=0A=
@@ -927,6 +987,36 @@ static const CryptTest crypt_tests[] =3D {=0A=
         .iv_out =3D tdes_ctr_ivout,=0A=
         .len =3D sizeof(tdes_ctr_ptext),=0A=
     },=0A=
+    {=0A=
+        .name =3D "aes128-gcm",=0A=
+        .cmd =3D HACE_CMD_AES128 | HACE_CMD_GCM,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_128,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_GCM,=0A=
+        .key =3D aes128_gcm_key,=0A=
+        .keylen =3D sizeof(aes128_gcm_key),=0A=
+        .iv =3D aes_gcm_iv,=0A=
+        .ivlen =3D sizeof(aes_gcm_iv),=0A=
+        .ptext =3D aes_gcm_ptext,=0A=
+        .ctext =3D aes128_gcm_ctext,=0A=
+        .tag =3D aes128_gcm_tag,=0A=
+        .taglen =3D sizeof(aes128_gcm_tag),=0A=
+        .len =3D sizeof(aes_gcm_ptext),=0A=
+    },=0A=
+    {=0A=
+        .name =3D "aes256-gcm",=0A=
+        .cmd =3D HACE_CMD_AES256 | HACE_CMD_GCM,=0A=
+        .alg =3D QCRYPTO_CIPHER_ALGO_AES_256,=0A=
+        .mode =3D QCRYPTO_CIPHER_MODE_GCM,=0A=
+        .key =3D aes256_gcm_key,=0A=
+        .keylen =3D sizeof(aes256_gcm_key),=0A=
+        .iv =3D aes_gcm_iv,=0A=
+        .ivlen =3D sizeof(aes_gcm_iv),=0A=
+        .ptext =3D aes_gcm_ptext,=0A=
+        .ctext =3D aes256_gcm_ctext,=0A=
+        .tag =3D aes256_gcm_tag,=0A=
+        .taglen =3D sizeof(aes256_gcm_tag),=0A=
+        .len =3D sizeof(aes_gcm_ptext),=0A=
+    },=0A=
 };=0A=
 =0A=
 /* DRAM offsets for the crypto test source, destination and context buffer=
s. */=0A=
@@ -944,6 +1034,8 @@ static const CryptTest crypt_tests[] =3D {=0A=
  */=0A=
 #define CRYPT_SG_FRAGS         3=0A=
 #define CRYPT_SG_FRAG_STRIDE   0x1000=0A=
+/* DRAM offset for the AES-GCM authentication tag write buffer. */=0A=
+#define CRYPT_OFF_TAG          0x60000=0A=
 =0A=
 /* Describes one registered crypto test (qtest_add_data_func() data pointe=
r). */=0A=
 typedef struct AspeedCryptoTest {=0A=
@@ -964,6 +1056,8 @@ static uint32_t crypt_mode_flag(uint32_t cmd)=0A=
         return CRYPT_MODE_CBC;=0A=
     case HACE_CMD_CTR:=0A=
         return CRYPT_MODE_CTR;=0A=
+    case HACE_CMD_GCM:=0A=
+        return CRYPT_MODE_GCM;=0A=
     default:=0A=
         return 0;=0A=
     }=0A=
@@ -1109,6 +1203,47 @@ static void crypt_run_sg(QTestState *s, uint32_t bas=
e, uint64_t dram,=0A=
     crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);=0A=
 }=0A=
 =0A=
+/*=0A=
+ * Run one AES-GCM operation in scatter-gather mode: like crypt_run_sg() b=
ut=0A=
+ * also program the tag write buffer (HACE18) with no associated data, and=
 read=0A=
+ * the authentication tag back into @out_tag.=0A=
+ */=0A=
+static void crypt_run_gcm(QTestState *s, uint32_t base, uint64_t dram,=0A=
+                          const CryptTest *t, bool encrypt, uint8_t *out,=
=0A=
+                          uint8_t *out_tag)=0A=
+{=0A=
+    const uint8_t *in =3D encrypt ? t->ptext : t->ctext;=0A=
+    uint64_t src_sg =3D dram + CRYPT_OFF_SRC_SG;=0A=
+    uint64_t dst_sg =3D dram + CRYPT_OFF_DST_SG;=0A=
+    uint64_t ctx =3D dram + CRYPT_OFF_CTX;=0A=
+    uint32_t cmd =3D t->cmd | HACE_CMD_ISR_EN | HACE_CMD_SRC_SG_CTRL |=0A=
+                   HACE_CMD_DST_SG_CTRL;=0A=
+=0A=
+    if (encrypt) {=0A=
+        cmd |=3D HACE_CMD_ENCRYPT;=0A=
+    }=0A=
+=0A=
+    crypt_write_ctx(s, ctx, t);=0A=
+    crypt_make_sg(s, dram, CRYPT_OFF_SRC, src_sg, in, t->len);=0A=
+    crypt_make_sg(s, dram, CRYPT_OFF_DST, dst_sg, NULL, t->len);=0A=
+=0A=
+    qtest_writel(s, base + HACE_CRYPTO_SRC, (uint32_t)src_sg);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DEST, (uint32_t)dst_sg);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CONTEXT, (uint32_t)ctx);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_DATA_LEN, t->len);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_GCM_ADD_LEN, 0);=0A=
+    qtest_writel(s, base + HACE_CRYPTO_GCM_TAG,=0A=
+                 (uint32_t)(dram + CRYPT_OFF_TAG));=0A=
+    qtest_writel(s, base + HACE_CRYPTO_CMD, cmd);=0A=
+=0A=
+    g_assert_cmphex(qtest_readl(s, base + HACE_STS) & HACE_CRYPTO_ISR, =3D=
=3D,=0A=
+                    HACE_CRYPTO_ISR);=0A=
+    qtest_writel(s, base + HACE_STS, HACE_CRYPTO_ISR);=0A=
+=0A=
+    crypt_gather_sg(s, dram, CRYPT_OFF_DST, out, t->len);=0A=
+    qtest_memread(s, dram + CRYPT_OFF_TAG, out_tag, t->taglen);=0A=
+}=0A=
+=0A=
 static void aspeed_test_crypto(const void *data)=0A=
 {=0A=
     const AspeedCryptoTest *c =3D data;=0A=
@@ -1145,6 +1280,29 @@ static void aspeed_test_crypto(const void *data)=0A=
     qtest_quit(s);=0A=
 }=0A=
 =0A=
+static void aspeed_test_crypto_gcm(const void *data)=0A=
+{=0A=
+    const AspeedCryptoTest *c =3D data;=0A=
+    const CryptTest *t =3D &crypt_tests[c->index];=0A=
+    QTestState *s =3D qtest_init(c->machine);=0A=
+    uint8_t out[64];=0A=
+    uint8_t tag[16];=0A=
+=0A=
+    g_assert_cmpuint(t->len, <=3D, sizeof(out));=0A=
+=0A=
+    /* Encrypt: ptext -> ctext, then check the authentication tag. */=0A=
+    crypt_run_gcm(s, c->base, c->dram, t, true, out, tag);=0A=
+    g_assert_cmpmem(out, t->len, t->ctext, t->len);=0A=
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);=0A=
+=0A=
+    /* Decrypt: ctext -> ptext, the recomputed tag must match. */=0A=
+    crypt_run_gcm(s, c->base, c->dram, t, false, out, tag);=0A=
+    g_assert_cmpmem(out, t->len, t->ptext, t->len);=0A=
+    g_assert_cmpmem(tag, t->taglen, t->tag, t->taglen);=0A=
+=0A=
+    qtest_quit(s);=0A=
+}=0A=
+=0A=
 void aspeed_add_crypto_tests(const char *prefix, const char *machine,=0A=
                              uint32_t base, uint64_t dram, uint32_t modes,=
=0A=
                              bool sg)=0A=
@@ -1152,6 +1310,7 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
t char *machine,=0A=
     int i;=0A=
 =0A=
     for (i =3D 0; i < ARRAY_SIZE(crypt_tests); i++) {=0A=
+        bool is_gcm =3D crypt_tests[i].mode =3D=3D QCRYPTO_CIPHER_MODE_GCM=
;=0A=
         g_autofree char *path =3D NULL;=0A=
         AspeedCryptoTest *t;=0A=
 =0A=
@@ -1173,7 +1332,9 @@ void aspeed_add_crypto_tests(const char *prefix, cons=
t char *machine,=0A=
         t->dram =3D dram;=0A=
         t->index =3D i;=0A=
         t->sg =3D sg;=0A=
-        qtest_add_data_func_full(path, t, aspeed_test_crypto, g_free);=0A=
+        qtest_add_data_func_full(path, t,=0A=
+                                 is_gcm ? aspeed_test_crypto_gcm :=0A=
+                                 aspeed_test_crypto, g_free);=0A=
     }=0A=
 }=0A=
 =0A=
diff --git a/tests/qtest/ast2700-hace-test.c b/tests/qtest/ast2700-hace-tes=
t.c=0A=
index 508a34dd6c..3f0217d635 100644=0A=
--- a/tests/qtest/ast2700-hace-test.c=0A=
+++ b/tests/qtest/ast2700-hace-test.c=0A=
@@ -94,5 +94,14 @@ int main(int argc, char **argv)=0A=
     qtest_add_func("ast2700/hace/sha384_accum", test_sha384_accum_ast2700)=
;=0A=
     qtest_add_func("ast2700/hace/sha256_accum", test_sha256_accum_ast2700)=
;=0A=
 =0A=
+    /*=0A=
+     * The AST2700 crypto engine uses scatter-gather with 64-bit DMA and a=
dds=0A=
+     * AES-GCM on top of the ECB/CBC/CTR modes shared with the AST2600.=0A=
+     */=0A=
+    aspeed_add_crypto_tests("ast2700", "-machine ast2700-evb", 0x12070000,=
=0A=
+                            0x400000000,=0A=
+                            CRYPT_MODE_ECB | CRYPT_MODE_CBC | CRYPT_MODE_C=
TR |=0A=
+                            CRYPT_MODE_GCM, true);=0A=
+=0A=
     return g_test_run();=0A=
 }=0A=
-- =0A=
2.43.0=0A=

