Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1815BEFCBBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 07:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w224U-0006kb-Pr; Mon, 16 Mar 2026 03:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w224S-0006jW-Gv
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:09:00 -0400
Received: from mail-japaneastazon11023072.outbound.protection.outlook.com
 ([52.101.127.72] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1w224Q-0007UK-0u
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 03:09:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4+WP/hcXY6hcBFK4M75L3wHVjKLRRrq4ULIkNfahLIKqQCMg2XkScSg9W9a6ZmOu3O1ttkc6Jccbya6Ek0SLf45zMAJkuIcsHsuTJ25HSeODY0hOge3MmodlpJZzCxXN/2IJJ2MPA2bxa5y2jE9i85hcvzSv1vPF2FlFy2fqT9pLEWKPcW0WPr2n3q3lmsVrVsm8Pm3Sv9lsDQEoNkjK+TyzxGS2g+sPxq1Vy9P2hmNmma0ZtMbUxS4At6JtDDL8h2asF4hV3YmrV16vPD5KoxwP9hXH57PNpQQPXVFRw1s605X1W/Wci/f1AcQNq36bWTzirEEp02zH30o1y1bvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRg0M1oLHjgNNHjJ+MpvsQ+OBCvlsNkUfbKEkoUVCzU=;
 b=H1IKHD/b4+CNsX0mkb8OQTbSbvng4Z2pSJ+AdgBag/zGoeXrP8GC78/b3tGVIeggej3wAuQ+hcKIUoOLV3yzgdpla0pRdm9xtGEABsC8xSypaV1eSsz74TKrpb+y+hHADuOvAVJfmVTIz54FeKXuzvlG/xzQ663vvWKAnU9oxTf8D3+px12EB9q+9r8KSD+hJzTp6g9Cj4aWt8WKg4Ij620QXENuzs2VEVLbAfxlSNAEDo/J/McniPFGhxhkSb6uSPqxqLjyaswy8TtO01tF1lDgl4CR/fAr5/5ipFLf5JN2WftsSuBsbh08EqTAo2zEqW3ScvoSQuQ+l4Iq44VmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRg0M1oLHjgNNHjJ+MpvsQ+OBCvlsNkUfbKEkoUVCzU=;
 b=D7PoWD3eX8e2wWOgAf3X5vC1ylEFgCv8gXdgbYMNqswUkKLq9mEAJPNPyfcL+M934K4soH0bzzuSD++jq8UQYBXKMXlRhsreFyzmoAnhWW2D68WRFhEg7u46B7Fi3n/huxsd+BZmjunSVeQs95TzcTgzDID/ppfPuDFn/5BSnKFrVi1hVCaPmpwIqFgqh+eYHYNZn2kJNX5Va8EOUHl5PN91uow4WQvtw3ISKi57GTX5KXJJ61yegu63kdyOmsCi6Z8Yv3K7roT8zyJe/3SMeJhBZW9r9ATFOV0opGqcBbE+A7ui0QzQG4JeIJdRGAAXP6ImYCYUV0WS8o7UBCc2/A==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by TYZPR06MB6859.apcprd06.prod.outlook.com (2603:1096:405:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 07:03:49 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 07:03:48 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 Kane Chen <kane_chen@aspeedtech.com>
Subject: [PATCH v1] MAINTAINERS: Add Kane Chen as reviewer for Aspeed machines
Thread-Topic: [PATCH v1] MAINTAINERS: Add Kane Chen as reviewer for Aspeed
 machines
Thread-Index: AQHctRMJQ+qkQ9z86EWYNRzFWd2IXg==
Date: Mon, 16 Mar 2026 07:03:48 +0000
Message-ID: <20260316070347.3079299-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|TYZPR06MB6859:EE_
x-ms-office365-filtering-correlation-id: ece178e6-f7a1-46f3-c8c5-08de832a2c47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|38070700021; 
x-microsoft-antispam-message-info: 4WxOWXAQDiyYBYFzoUolEq/a+IvjqZAH3uXx9eLsYFocD19WfSt4e0Qj0/DUoj4eCQoq9CMCLc8oWkk/LAPLXK0Wq7vuThgebmfasbL3nlRywrVY16dUe+EQ1A51BaTXpl0Mnx3RBf57vvKFisOz7UWm9Muwuht1+3cbG6uGtQbKJpvQxFx9rJOdYNCUDnuBWfBcUXyAOJWkuLKLn+6Pgu//gMvzGcrXyuj5l2WcdcHIknmhB5AZOLPmC7NLHCQdoOdQSbNmPLiWfqP5G2xi8W8Q4M3Vcycs1MkKfTbiYKQWE0TMujIHIFwhEB35qyehjB4ohp+nN0ET9DQLi+wGv665zRIkVteYxA11UOsOQnRuJr9lDKHyzaJTAIqQBBEuPRLgp43kU217Hhwfym5kQ7HM75FVdE6P/ULyEOgMIgYifkItYoD393saHk5TS5QfcWsR15M+oBHb6ResTs46/e+/+ffKHAVlXK+eL4T4Y08TZvLUSkD5zVQIT4pZvKQRk/o4h+PLUDWhEpnx8HiG7sprv8jaExyiZTcbYkmUKp+Z991hM2AaQxxruNtQs41iR75Tj0NROuW3n27BDdubYGX7B7lXTUIexhfGJjmrMN0DH4BOBfeaEvBj0mkArsUGm2bWuUf3nzddFEUpiDLPgXD7DU9k+6+xxDGJuymkIWszPjFaXTSJ3AVbeM8G9eQlwbrEmjxqQbiELizkBCFLMLILGI+WyqZFQcAMtkoyiQJIRBTIriw+en9OSJzXSrcpJ1RZS01EvovI9wujiVVlInUjlqJ6Qh00LP6XoYKGp0s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+wNmRKkNb86ag1pz0QQW16fJPOVm3QiJEgxrF8ksqM6VxzdQMm0EKuFpPf?=
 =?iso-8859-1?Q?zlkuRHVp5hV4swPl4zMFaBDkMCCHC7mcjVIo5/RRtCQzNpJVCVqDyWS/mz?=
 =?iso-8859-1?Q?UMNGetfAxCIfvEZXn8Vpy8gxJ8OJCGiCjksjepAxp+8iGvCkRQTv6f3qfV?=
 =?iso-8859-1?Q?FKpAQeN0buxFz9R1jG0deAruyeDK3t6Lh/4lWkOn8/pscmXVKxnrCvOck/?=
 =?iso-8859-1?Q?qcn0q4C9k7dKyYgK7qnI+V8R949NJ6BlPncvhghb5cPJzC+hDAlEghUpnj?=
 =?iso-8859-1?Q?debYmucNW9DrYwKn4p+W50Mlwy4v1hRawHrtXTGpXU1pQIfcS7Y03WcwVf?=
 =?iso-8859-1?Q?exPxECaxQdBFhYKi2taUUrSkJ0MW9bvpCTYXaoPo1Uq4cvFRljoXXjC3Ot?=
 =?iso-8859-1?Q?gJeAcWPuBis6V8RKKxGHb7GYy2g0WbtwL4kEzvWxlZUt+oU26truFjS4YD?=
 =?iso-8859-1?Q?ihg/8zIud9EXKqIxx7AJvCXJYsnevAViRnuxix0k72YzESamxNRqCaTJKW?=
 =?iso-8859-1?Q?azvioRq9pHaLpdH/WOMXji4KDza0idu6IihdTKU/al+99LC/0pc4WiiGXe?=
 =?iso-8859-1?Q?FyrOB+cMTu4UZKFpiu+o/hBM0iwOIq+0x3CaUckCSNqeOb0ePOKKpYDSFi?=
 =?iso-8859-1?Q?U8CDZjfAoqIP9sEqC0W3cfxBOS/LW4gNe6ZEleMd222uUwVTcrkgVIyS1X?=
 =?iso-8859-1?Q?20nR88jcAa24N7IKfk69p2DwOq81WcGq37FDi6xEtG3x+8VC87/1gFX3Y9?=
 =?iso-8859-1?Q?Md4RuIt+oB6bfYBpAxu3J/Kt1Qszus+pENKQu+OFinUnX2GMYR8MjpRYTu?=
 =?iso-8859-1?Q?ZKyxBXhV25RikLAJ10mKcyThlBm23dmBIuDWIxC7TNPs9TG8rJ/cpdYni3?=
 =?iso-8859-1?Q?BHdAkUPoVAvUUTmZemo8cycKic6UAWnBkWZFZD0H2VZn5/i1/4Vgj5phuG?=
 =?iso-8859-1?Q?vPGKJFDJQmO/4OyL/pneoycP4P4WlaeIYCS6UfbvqM+81+svpB/Tf5yQM7?=
 =?iso-8859-1?Q?eUjz/UCcWmNod4DskCi7TrlkMaWOarqkqVbvTyYnKn/OA07VMgr/ihfWn5?=
 =?iso-8859-1?Q?idfIG51MUyanavo9wIMJItZJa5Cm7gJLN0LtnTOyWJN6y2jEyV2SIYt/cx?=
 =?iso-8859-1?Q?GVaANXbKKfnsx447zjknRH8IiZ5Cs5CuH6tyHYQjtyaA0PpU3r6umE6WoA?=
 =?iso-8859-1?Q?OcJ/dzg6WgPM6O6UO3gQ+T4IYQgBi4eKHe4RkTNk0yXOP9+TfoPsj/wsYP?=
 =?iso-8859-1?Q?wvO2WSxPmLJIIcT9ysiJbt74npbNb2Akh3e+HsSxTYpzC/dIwM41nn2ge+?=
 =?iso-8859-1?Q?s4rVlvFPjwCoM8nqoNrzB8HGOrxKcZRnJuWkrFqt9WvEC1hlr5DU2ACD0l?=
 =?iso-8859-1?Q?7hd9Ts+Bq+R92WaZ/NGUTyFzCCrE8ql2He0ugoI4lkXIMWMlWLYf1T6dcg?=
 =?iso-8859-1?Q?AvtNDWMAtfxL25JBUzBwNWRtWmnEaTcco4ESxM7T1J9RIQqj+vJh6vvb+T?=
 =?iso-8859-1?Q?HA5VlqSMlh5gOcRrCeNlCezEs7V7eoeTH9TAkl9RW4XIJpq697y5gUczcz?=
 =?iso-8859-1?Q?/OxZi3LkSnz3U6/yVlyZMVJtuez04odxhh1nc2Z5A0nLQg4Xm6mDELi00L?=
 =?iso-8859-1?Q?heJirGBCRt2lI8s/czuUtjXOXimAsCYLtRo01P7ta25ncKOP+1fzvUl8r1?=
 =?iso-8859-1?Q?ZB6/vKjeZ4uEEfaKC37ffgFOGzayiiW+nOMYa2t/VOkTiQhWtSJ5Y0WA2s?=
 =?iso-8859-1?Q?hgqOZNjqpZSLPNvJHMRFTs6H/MQwmeNCZz7aKjD1DUZW0wJavhy7p0INTq?=
 =?iso-8859-1?Q?oottv7Ye5A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ece178e6-f7a1-46f3-c8c5-08de832a2c47
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 07:03:48.7795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvJgB/a9+wNJysSX8zXIOVGtZIwPfK2oWbeu4tAHZLtu7jgZYS/9Zvjx5wsMeKgI0NWNEq5Bx6zeJ2iF/PzuM86BkesPF3vAPElDiwcqMB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6859
Received-SPF: pass client-ip=52.101.127.72;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 MAINTAINERS | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 6730cee490..7c2bbbec54 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -1252,6 +1252,7 @@ M: Peter Maydell <peter.maydell@linaro.org>=0A=
 R: Steven Lee <steven_lee@aspeedtech.com>=0A=
 R: Troy Lee <leetroy@gmail.com>=0A=
 R: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
+R: Kane Chen <kane_chen@aspeedtech.com>=0A=
 R: Andrew Jeffery <andrew@codeconstruct.com.au>=0A=
 R: Joel Stanley <joel@jms.id.au>=0A=
 L: qemu-arm@nongnu.org=0A=
-- =0A=
2.43.0=0A=

