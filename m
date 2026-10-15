Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA11CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHESf-0001qk-GO; Thu, 15 Oct 2026 01:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESZ-0001mh-Uw; Thu, 15 Oct 2026 01:56:59 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xHESY-0003DY-6S; Thu, 15 Oct 2026 01:56:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygkkEU0jt6gUB3jKKXWvm6STeNpK2p/rrrk1o/B9r9zLDmW70iSE7vUVfFPxhtm4x7b9mCfB4QBrFEZM94ArI6ISDvwt/+x/p9g4oXH9qMtRqOV9EvcAm7j+Ffvi0r3DFq6Bsv3uRfXLHrV2MgupuqXKSTTGFhWGUL8348d1zni2hqtt7Bp9VWOEceXZhrAQBxlnK0TVgyc83y5HUXBOAM/h7saZmki3WoV/7ZticIbzoY8F76OpR9/Xkj10iVih0xO/SvCmjRY9Qsl4VLVYAZlJTThj462QcOrbTUCmsgcj+phPa78mx46yGDIqxEL7OjcogdtlLb3TFNbOgksluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96pJWZj11nTPuPxAKmDhq8l6CowPiGbWNgCIFDbn2Eo=;
 b=dbxkoXnERpwZns52btqGkUfm3yLx+jECfDQmkytxxDkjfoHsR+VNHvz7iHkU0BEIjM2W0v4Gh5wwATO8U82dLmsMm//AuX6gQlHqIYF+5YxJxh1y4pIUFLavPr69qwwObPA19VLdC1EhHmDDlhqouKD7cxv3EicvfcZMD0FVXl7QfciezqKu/jEkO1fCeOw6uaE8+eT0H2gD1TSczalMWV7F9P2J5Npm+STmVoJiQyKqJf0inPRnvfYU3UaKazPtzzDUaXOG7OqAhl9kOC1DnUSCP0OylieDl8oijzXSkl9EtzOJXrvyvywz6ADWrLS19DEpufIJloMYcASZ9IoGoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96pJWZj11nTPuPxAKmDhq8l6CowPiGbWNgCIFDbn2Eo=;
 b=NReUWIB42Sm55BdPA+zQIIB8snFyAtIj0c72IxPY9KrLUEhl5WIrYhDExEf1sMRP4cBv2XGOEWUjxqVp+W7nFD7/GjOxlYwKqWsddhAeLSX/xKGi7/3SQDDVvrinFz6EqbpnzwG2ysw5H/A5PrKRoXoIyATBqgMWk0rwBaQDhl9+44tF3ZYpweWENGg8pa1YxUW2O9AkOGqtqfNtY0JMfC0qstQfhGU6TzQUjx8514uiwpb3ALnuAq6oeQXTlavjmSQ5ZejUx2Ho9FRxHgODIhBLXa1QpsXtIKusieZDtkk3S6cV1u6MBr7NEJTMagPfSN7hG7/5zYxs6/9GwgpNvw==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by TYNPR06MB8427.apcprd06.prod.outlook.com (2603:1096:405:3b6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 05:56:52 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 05:56:51 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Alistair
 Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v1 04/14] hw/block/m25p80: Add SFDP table for Winbond W25Q33PW
 flash
Thread-Topic: [PATCH v1 04/14] hw/block/m25p80: Add SFDP table for Winbond
 W25Q33PW flash
Thread-Index: AQHdXGn36CLnJAg31EmRuSJzw1s5Hg==
Date: Thu, 15 Oct 2026 05:56:47 +0000
Message-ID: <20261015055642.106204-5-jamin_lin@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|TYNPR06MB8427:EE_
x-ms-office365-filtering-correlation-id: 50f37fd9-dfbd-419f-ae03-08df2a811bd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|23010399003|38070700021|56012099006|921020|261009223027099003|18002099003|10067099003|6133799003|22082099003;
x-microsoft-antispam-message-info: N3ZzMAAVnnWpREjRevWa2z5nRlM72qNpVCnLbbA9WCvGxODOT9EaufpSD3/pH8snWMLF5FoapoGRn3lD8bJjgAtkedrjWkS6cVeZuUsl6b01UA1kkY3iJN5bPCc+iAeZX1NF3C2rcWSGszBaFAf4S8DYb1SuoxKdogR7FsM8fS4qwdg5h+uxNJEJZHXaV9joknY7SV/AtmpBKhVnYlLrRusjDy391mNqwuoQMtq1OxGAxXCOniIHvSIZtMynv+/Po3dlu6D4KjrK2U9C1JFj60ukqIi6XwTeNhGoe+2n/hhXBRPRMIEbCOXorN2XzVRMwiAMjxZ1BeTloB7XrZ4VZrQ+bclIeh46zK+rhRWa29L6JeBlhQYNROJ/5qChY7uDM2xmaJDnulOIF/RlY07nmYL7VomOMwNSZG3NuL1f6g70zXxe1LzM57wiRIMB0aiiDbFDaTuEoHe8AHx0j+TRTL0YXfeuN6H2O+kUqQQUiw3CqvaJJvcO1Sr8brSx7w5MojKyXmnKYRQDxOZbrKUePvESq4X1bpMEtisKSlbxYG98V6IlDCb+nJ0X/lxgiQ0S24RJyHZku6zbIZh6KzTgBDT6So4UoyY0K7HlpHIGl5DTNIwaWZc765sNg4IFGbRdj7iTv9/6Zca1d1aXJuZQRqXpuuY5Mb0upEiUoC0s9kYApsQIX5dTBxm2JUg1FQdy+vkODwUOeFxuqCr0LFUEGSrjNpTkMAsUYEVAKcdkaOpKB6bMt0DgE5rCdfXh73t3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(38070700021)(56012099006)(921020)(261009223027099003)(18002099003)(10067099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sd/sNGccAt7beIxSCFhpiPWVr3pALQ7Hd4u4xbzz4HluZvtLMCRCN9N4/m?=
 =?iso-8859-1?Q?2HA9ptD3OveNRZOUVpK7d/QoflOYHXkBi8CBSPoGzxlwA3eqeoIMMGyq6c?=
 =?iso-8859-1?Q?h5YS9+UQoiJ75PobljdlGUu2RriTU/t/n5+29LgCDWoqQfGJuCLxlXNs9l?=
 =?iso-8859-1?Q?tnYvNzex1fFlA1C8IQA77N0yJp00ibouVRvo/vWnde59wsze6nSrJmlfBs?=
 =?iso-8859-1?Q?w2zxhM175AuGl/kbc/05Cdva96elppHyUZ3WLVrRlZM8wdCa+uaLJcqCsq?=
 =?iso-8859-1?Q?aHxQ95CXstr9PH6AtsxrBbUnV3Xva/+jE26FuYMVdoZplR9hkcE9mbgc/f?=
 =?iso-8859-1?Q?HlWzPHYCcVDVAWxDUIEV1xPUCCJoueclTYX+CZOAAv6+dLxtn6a/0wu7CI?=
 =?iso-8859-1?Q?5r0V2raopB9wClVCMs8YalTOEm1nrzJSo16+ac3ZxPEppRprjI5veDVI3d?=
 =?iso-8859-1?Q?K09WSDHAW6nmOvBcnLEnruLMdJNsKtZR85PbWpPWa67B/keduyrtQlHWUy?=
 =?iso-8859-1?Q?1LIbJAGY6hTnh66J0zkH5N0P6T22QCQ4zrruUrs6XIgWVPSYiHLjPLfasP?=
 =?iso-8859-1?Q?yoSoXw2VpnwYoZKWg4lDJXAOhnsO+5F/XvVb38EV9jnRCbZfUNiqMHbPmW?=
 =?iso-8859-1?Q?jo6H/GqLaNTS6k6XJOIgu5r+SfDER0XI2/5ovKnxPgX16k7nAj+qSURWeE?=
 =?iso-8859-1?Q?BkLmcnKzglVr5QlF2ZJrAi4h0/2zu1SoHRhZaR5qEpju/OFsvBMQSUot7/?=
 =?iso-8859-1?Q?LJnfWuw0z97QyiO2KqG9qqR6m4RTGzJsrNogqJt3KdMdfa5Lm7/o/93au2?=
 =?iso-8859-1?Q?Yyus2mq/EuteN1L8cNli3GSAO4dVQHO41RPs2ea6rrxb8yMONIzvwVnmkU?=
 =?iso-8859-1?Q?RJT28qgX1qCspw+AhR/kJ107Zac76xICPUbU/b2r0iE3SskHnea055Gxzj?=
 =?iso-8859-1?Q?26nn/lwOwPVORSdQ1UMi/QjNlImArA3GFwglpnRB10xABy0XymXso+8PiF?=
 =?iso-8859-1?Q?cauxlSn36sqQepX/S/wdyqIAyYST4+pSjLKN3dsdhCmjhIiVqAvz91w2bO?=
 =?iso-8859-1?Q?MA2IhQ2nFyeePgCj7p2xaV6g+QIYXiy9knNZ8O9VmDZA9MFfItF0C5F+zU?=
 =?iso-8859-1?Q?UH6bqafR/AAF9/77kVvmodVnkt0DI16OBNSgDImf0Dq0V7Rhfc2qxdJ2Nm?=
 =?iso-8859-1?Q?nUZM/WPxYErJlsW4ElPfHLt059tWdSuFrFd/h4eHiCj3qvI/t3eIer0YPC?=
 =?iso-8859-1?Q?QqFLIlvdT+KUU1FupThNSgeHeda/O7jRcyKvhcmnMbFvQPg8DAl1Qasq+1?=
 =?iso-8859-1?Q?dzkf41ziPwNCrJtGdE+YY3xdHsDoCY2OSnOyWHIJernwRA5jjhc4+hY7Zs?=
 =?iso-8859-1?Q?+pENkniRiRB9thTHfDq7otZlVUlXyFxBnxCaPaRtpLqJiZLPNOQO9x/UOw?=
 =?iso-8859-1?Q?2VZXn0XizytSSN9mGrtWmIH3XGmWX0mHYXWgveMAa+V4AP3sYkS5CVXSaQ?=
 =?iso-8859-1?Q?VuE8aKQXC/nlYN7bvhqtZO1oV57I8wwBXoud0N45VGMVW1sIW/R5/1dd8U?=
 =?iso-8859-1?Q?GdEDc9EOGhSgBPMMDv4BjanO77FUSy9SWKJ/lC3zP/ZsQ88W6QC+nNfkIq?=
 =?iso-8859-1?Q?A2NJdqS7TQYu9gMNC8+FLXUs42tumCsXwKLdEePygyFRVE6HIZZQCKPxyX?=
 =?iso-8859-1?Q?GMcsyoNw09E1s4T67bxGEXD9kNM9RYr+iDhaOZU5AzaVmAVDv6kKpqSWeM?=
 =?iso-8859-1?Q?Kacs5EYScyXV6uK5qRAmjGgecjPxTRNr1TpS8i98x72JOgfVT1XStqVWdH?=
 =?iso-8859-1?Q?Qbcz9FgZhg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3pg23r5wX5iSAd1MnWr6bNs4euBEl6p9SmGs8UtXtz5RZ0WutQrigKfwvnS3ZR3lPFQ0MRnLnCQatLhlhROGI4LxFHTfriHuqsQZc61NFgxBOnwTdjx0kc4ZGmsbBhqmGaXfv+BK/YIjYBAqzX2hUglcIodFvkBjc77brGXd+ywPOVZz2RQMOi+/Rgo+4yq0boJBiI29pYwLBDDEZC+7BMX4TBQBpX6M8+IhTD0Yfel8h2u+75OkvP7ewA3ieMyhJLQhTBMq+EB7yk6W9Ay3P/AolxtQs3QL/L3IyfRA/VEAhKvtSt2CK2lurrV07ItQOl1qRbKoVQJN/DTaV0HWjQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50f37fd9-dfbd-419f-ae03-08df2a811bd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2026 05:56:47.8824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L83Ll/FPvtl4i0YDqWntn/yMWIjdrBj8kRlYyXi6b6BijgHG4BTMHnuvlHGdQ9rrR/A96RHQjUUkjgICvqF4hQCA7fcMBQkhuLGgX67U1l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8427
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

Add the SFDP data table for the Winbond W25Q33PW flash device. The table=0A=
was generated from a real device under Linux by dumping the SFDP content=0A=
using the following command:=0A=
=0A=
Example:=0A=
=0A=
```=0A=
hexdump -v -e '8/1 "0x%02x, " "\n"' \=0A=
    /sys/bus/spi/devices/spi1.0/spi-nor/sfdp=0A=
```=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/block/m25p80_sfdp.h |  1 +=0A=
 hw/block/m25p80.c      |  3 ++-=0A=
 hw/block/m25p80_sfdp.c | 36 ++++++++++++++++++++++++++++++++++++=0A=
 3 files changed, 39 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/hw/block/m25p80_sfdp.h b/hw/block/m25p80_sfdp.h=0A=
index c1e532de5a..61544fb7cc 100644=0A=
--- a/hw/block/m25p80_sfdp.h=0A=
+++ b/hw/block/m25p80_sfdp.h=0A=
@@ -23,6 +23,7 @@ uint8_t m25p80_sfdp_mx25l25635e(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_mx25l25635f(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_mx66l1g45g(uint32_t addr);=0A=
 =0A=
+uint8_t m25p80_sfdp_w25q33pw(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_w25q256(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_w25q512jv(uint32_t addr);=0A=
 uint8_t m25p80_sfdp_w25q80bl(uint32_t addr);=0A=
diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c=0A=
index e88efd913b..0e4bd93f34 100644=0A=
--- a/hw/block/m25p80.c=0A=
+++ b/hw/block/m25p80.c=0A=
@@ -353,7 +353,8 @@ static const FlashPartInfo known_devices[] =3D {=0A=
     { INFO("w25x16",      0xef3015,      0,  64 << 10,  32, ER_4K) },=0A=
     { INFO("w25x32",      0xef3016,      0,  64 << 10,  64, ER_4K) },=0A=
     { INFO("w25q32",      0xef4016,      0,  64 << 10,  64, ER_4K) },=0A=
-    { INFO("w25q33pw",    0xef6016,      0,  64 << 10,  64, ER_4K) },=0A=
+    { INFO("w25q33pw",    0xef6016,      0,  64 << 10,  64, ER_4K),=0A=
+      .sfdp_read =3D m25p80_sfdp_w25q33pw },=0A=
     { INFO("w25x64",      0xef3017,      0,  64 << 10, 128, ER_4K) },=0A=
     { INFO("w25q64",      0xef4017,      0,  64 << 10, 128, ER_4K) },=0A=
     { INFO("w25q80",      0xef5014,      0,  64 << 10,  16, ER_4K) },=0A=
diff --git a/hw/block/m25p80_sfdp.c b/hw/block/m25p80_sfdp.c=0A=
index 87878c2bf0..8ac603e212 100644=0A=
--- a/hw/block/m25p80_sfdp.c=0A=
+++ b/hw/block/m25p80_sfdp.c=0A=
@@ -296,6 +296,42 @@ define_sfdp_read(mx66l1g45g);=0A=
  * Windbond=0A=
  */=0A=
 =0A=
+static const uint8_t sfdp_w25q33pw[] =3D {=0A=
+    0x53, 0x46, 0x44, 0x50, 0x0a, 0x01, 0x00, 0xff,=0A=
+    0x00, 0x08, 0x01, 0x17, 0x80, 0x00, 0x00, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xe5, 0x20, 0xf9, 0xff, 0xff, 0xff, 0xff, 0x01,=0A=
+    0x44, 0xeb, 0x08, 0x6b, 0x08, 0x3b, 0x42, 0xbb,=0A=
+    0xfe, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00, 0x00,=0A=
+    0xff, 0xff, 0x44, 0xeb, 0x0c, 0x20, 0x0f, 0x52,=0A=
+    0x10, 0xd8, 0x00, 0x00, 0x14, 0x32, 0x01, 0x01,=0A=
+    0x81, 0xe3, 0x14, 0xc2, 0xe9, 0x63, 0x76, 0x33,=0A=
+    0x7a, 0x75, 0x7a, 0x75, 0xf7, 0xa9, 0xd5, 0x5c,=0A=
+    0x39, 0xf6, 0x6d, 0xff, 0xe9, 0x30, 0xf8, 0x80,=0A=
+    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xac, 0x00,=0A=
+    0x00, 0x00, 0x00, 0x00, 0xf7, 0xf5, 0xff, 0xff,=0A=
+    0x0f, 0x00, 0x00, 0x00, 0x06, 0x0d, 0x44, 0xbd,=0A=
+    0x27, 0xed, 0x08, 0x0d, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+    0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,=0A=
+};=0A=
+define_sfdp_read(w25q33pw);=0A=
+=0A=
 static const uint8_t sfdp_w25q256[] =3D {=0A=
     0x53, 0x46, 0x44, 0x50, 0x00, 0x01, 0x00, 0xff,=0A=
     0x00, 0x00, 0x01, 0x09, 0x80, 0x00, 0x00, 0xff,=0A=
-- =0A=
2.53.0=0A=

