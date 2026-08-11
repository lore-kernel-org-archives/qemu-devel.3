Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A166C5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 03:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtctx-00046R-S0; Mon, 10 Aug 2026 23:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctw-00045c-Gr; Mon, 10 Aug 2026 23:11:40 -0400
Received: from mail-koreacentralazlp170130006.outbound.protection.outlook.com
 ([2a01:111:f403:c40f::6] helo=SEYPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wtctu-0004L5-UZ; Mon, 10 Aug 2026 23:11:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FkYgp4+i6SVxLbOQxyljuqFE3CQy03EMvsVQwPxWVi90RxN8KzEoswVw6GPvS74cT5W4C1PlMHoIgOerQAFldoxjh2dDW8T+d1RoCMHBZHYxGev1p9OmR9nIfO+dmPadQHbdqq+yqP6/WpS/wElJiso6i8YcBYuAAbryoKvU34/bgzhDDafaq7cJqNMCRC0b+q07bIEpg7JyICidoEQ1udlX0ZsKCjae82KCBNs7dX/NF5uYxZBn3M5TDq/Yh2pP/9jVTBxRoOBRZUk0URW5hGjk07LQwWeVjGLpl9rP3hwXrejx6rsWjaeI7livHrKt9TAuvwpYFPAWvJx3lspHHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRzGCw9Hi6nSRWmZdKy55qviH7l5rHRPGVAWs/2wz6Y=;
 b=PsxNmV2kXP+nqNkn+e5g91hmyrEFv8g2aGg6fGMqKCrzMShPD0MuXwSUVbJp7l9W1UK6MMOCsob1Azs9bg/+S0v7MrXJz7Gs1mL4aVBRXAvEy6fsEoDglbRVBqNnBd+WYNFKvr+1YThrSBfDCZRpw5/ObwY1ypAEM/xNTwNc3bxy2+fcREOX2PWfJIeDyHmVzUrLsBeZp8cKsRNOmWZCws4rU8UJBfsmZPuOcamx/IGkVzDpJ2HFlKvxxSxZhVYSTOB6R2GwOy6NPo2mgMu5I1Mcjkb5diIJzzaAd0VcwjK0ykJlvhHkwJjvgQKQIIephKYyFk8D8fCkbaQEiiBZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRzGCw9Hi6nSRWmZdKy55qviH7l5rHRPGVAWs/2wz6Y=;
 b=k3NvezFjAI+p2ZJoU4J+Q9048k7e1nRM9I9S28lhQPwlugvM18ITJqJqjkfGi9UW1Qt7dhrhsAOgO2qPGstfErJTQX1xgAStD9orEr9CVpZhoJ6qeX3cYHpY8Dg9INJ4yN/iOPbZWp57LkU9Y4ts7Pv6ZU5WVCBd9rKi4PmNGWcnQcGYBLyelmnRV0GXdUzK+wAHwyy/WvbhW//dFZvsgPQzeHpNmljQ1IX2q9bo0Zw1mWA/OltLSlxOa6KExXSty7OE+u/4C+K8D5qXu7ZmOl1Y0sj8W7hIQ7V6bLowPCBfikNuB6kmdJdoFPTNyZXNNUjy3XeiPqjzWhk/id0fNA==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by TYZPR06MB5808.apcprd06.prod.outlook.com (2603:1096:400:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:10:46 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:10:46 +0000
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
Subject: [PATCH v3 15/16] hw/misc/aspeed_hace: Enable the crypto command on
 the AST2700
Thread-Topic: [PATCH v3 15/16] hw/misc/aspeed_hace: Enable the crypto command
 on the AST2700
Thread-Index: AQHdKT8AUpvX+TYPfUWpPZ2FMBJQoQ==
Date: Tue, 11 Aug 2026 03:10:46 +0000
Message-ID: <20260811031025.2784489-16-jamin_lin@aspeedtech.com>
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
x-ms-office365-filtering-correlation-id: 76f92c8d-346a-41ab-8607-08def7562338
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|22082099003|56012099006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info: V8hZA+r3dNkZPGMUcKuYsaBhNfoPMwu5mzXpDN8ejb89zyd+ZaUD0glal8n470tO1lMpRhJ8jA5dkzd44QpUdD1uDdQklYOqYRKXJHLAMHjxaGTfvY9/uwFUaYmvbfYq8xScBppc1NH0GPh8gDb69Y+EwqvOV2KivRhJGgMSROsa8RjBPWMY09RwjbYwVqVEaV2aMmTvYnT/Pje9MROCqNWOFf1MpZuQwXkC1P5OGpkKU2DIkTZstyIWddrOfR6BLcdHogJVQ1bYXS3Itk4fjbrxYI3pLkCIkMia7Hx5tzcVDRsm0qG0WdjCwlbuG8BEIJ2thtuIYzTVQNFExWg+79g0y6RZr55wvy89nC/o9LFGZg9K10JrkiXqd4uyq13yEYqq57zrw6AWYZTRSvZIZVOs8ld1n5Cbtw8fVGGLbl5fG8BUKJkhV53o+MWs9Rum+OoW0D+AHthAM7ja8z/463f3u2NseD23GEQ/H2p1NoInNDyh3lglFCAcSeHp9AooV0VDllBc8Dh69mcjFAgH7PZ+xNpiwIP+g4fDWYAahI1Dh09pQnQ2cCCg/VkDrTEjuhNrx4rTwFdzQ0xaXl8VOaReb9BySKPsVbCsikCJOLWTCbz9soUDLrjOn/H81a1MdgZuI3hGHggTqm85n/1FmwlTl3a1Dhz9gB7+xCsBM/ia2HuPa7uf4bHHt8xoSGNCjo1LHJiV0W6Uy7z4u8fNCgKn77dv7Kf83DsFbRKgL2g+q/PrOhXT3YojkSfqOXPQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(22082099003)(56012099006)(18002099003)(38070700021)(10067099003)(921020);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eKh4L5Qx40WlHexOJwTD3i7VKaPKIEL8C6C7TkIYgmMDRLnzIJljDiMpvC?=
 =?iso-8859-1?Q?u7Tj+4zGQpv0KsU9zDPOBVgQXjiFUBvfHtlmcz5YW1vluNIm58o3WqTglE?=
 =?iso-8859-1?Q?JQ7bs6Yd/CJH6dK6DtSzGybr6mwfWoz365MQ2IlGIlatiJYM0Uqzc4jBTK?=
 =?iso-8859-1?Q?o+ctpwjIXpopPySQKDW8HceTclupNOINhnjskc7aCCBB5o0DT0WEMamwIJ?=
 =?iso-8859-1?Q?MxejUIT8fdUyoM/1aPaFndKeqmD9lMjpZ3elIMkKaZapcH6RKiStiOs40l?=
 =?iso-8859-1?Q?x3Grz04dlV4uEa+SruHuq6981lHK5k0XamLjzs+ak/BuSlKD1GopkCc3Zu?=
 =?iso-8859-1?Q?uRIrTJwqaT7fTVu6qo4rzMTGxK2UWlUJPmNZpzj7sZMEeljX2uiKprTB99?=
 =?iso-8859-1?Q?FBwDcfBoGAmxwG1I1YddpqYob0yUyC6chCwL/3AXHzaHj3OlgbIWONqYza?=
 =?iso-8859-1?Q?K21HjRq/zNCSlcpHBR9T6xhxb23mZNdPDqQHKXbkpqTfw00GH1Nm2obSS2?=
 =?iso-8859-1?Q?DQGSHA3WbCjxidOGV1z748+Dtv0UpxOUIJOxOCyew6OktOVQ9D1jBcBdzS?=
 =?iso-8859-1?Q?edFPyfSCQ7QJ7wxXdnu/zxKro3ov6hWGyZLQR/bBWLFprRHjdum7Fvgsuh?=
 =?iso-8859-1?Q?yDuGaa/jrKuTfcgUy9k+QEo4QvuXPSf/jrW2lvXF6K/fab7muWyG5TmbdC?=
 =?iso-8859-1?Q?X1yfCZqqQI6cSOPq5l1KFg4DLzmrVy3F3zEyWf8T4Uks2gILB5R6VB4r0N?=
 =?iso-8859-1?Q?/ljadBK5Prut+u8E5vD0v1Ioge8/D8u//Lz+UpwLKZZN9Lz4F183/X+oXM?=
 =?iso-8859-1?Q?7q6AcTj5old2RyD5e9h/zh0E9OG659Ht3UW5aqtb5h+nI5iYSE9HvUYq/I?=
 =?iso-8859-1?Q?5t8ELSY5wsNM/XK3hwsVBiLA1hOushStA8HzPIGmlMLo8N7aFcgM9EbsCy?=
 =?iso-8859-1?Q?o60iEC43Wz7rtcVUtftMkA5f5FEU974dXppWuCO0r2Mk8KxwCjS+D+8gaE?=
 =?iso-8859-1?Q?srUf+OaSgDRuo/2g9PFrNdoL4C9WYhcgnNZ+px6LnrDXosxbX8vE5ztAzL?=
 =?iso-8859-1?Q?zbGBAVJ0B48fA6m1CyF/V96/MfH82oIoH/D4dshlqfZrFspr+zPXcO3XNN?=
 =?iso-8859-1?Q?RF2pulj7qYNw0hZ2UPvwHmhUyyuzMXMn5P49RWKhlGnvg+YtqbQ2z6zxYA?=
 =?iso-8859-1?Q?OiIz6xqfaASl7qqAQHnNu/e7T+0saC9Em8L2Iq7uXojdeA3nehEZqrNtVt?=
 =?iso-8859-1?Q?teahZNV/x3la6kPplcI0+nmekDraTQhrwitiPPeaNVS2KijxbJoCIKUrP8?=
 =?iso-8859-1?Q?r+obkyPYcC5aw0Nz4jBuS3LJWlTGP5TZPo89+TBCsbHzwfpQUbjBh5QHev?=
 =?iso-8859-1?Q?NBFSqeJOEzdzQp+ytVW0lOwY8M/vGP1SpFwlYPwwHkI4MbHYNI6vuBziUZ?=
 =?iso-8859-1?Q?XF9CvA4TB9TEdyv/1zq+u2QJxlX9SQT9vsuHRzvQ260IuzfoUUKwDCpyo1?=
 =?iso-8859-1?Q?assem3kMIh9rlbT7jlBsCfXC4iVMEILUlki4g9YouPIPWUZgaxwz5FxrpD?=
 =?iso-8859-1?Q?3A+fNV8O4tM9qWHWV/s6aDnavpQCqzxVBLImtcAT1IpE1jnjKjeas9y6tc?=
 =?iso-8859-1?Q?0p57A7mjMduWmH1PEeHb3eKgOcD0JfaeloIz3NfkIH8b4VS22R5U40pZJJ?=
 =?iso-8859-1?Q?UHf1tuH/04UpVGeW9pcSz4Cwl83nrqYmG/TNtGHi9aGnYwgerbTwVSRmLR?=
 =?iso-8859-1?Q?4neVedLvfpqOaQY7O5jL/qkDLMjGnNBKuZ9JzPSWaFAzTCvRLfZLtau+gC?=
 =?iso-8859-1?Q?qvEDZh8zWA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: nuWNl5htpxDDKCE6nkkFnOvcaDtAfRrdhLoqDWzjszGumSwi2s+Zxz3xs+ZKAyIeLJcxoiRZWMiC/vXs4as8AzLXUAACUBemu5/odaZ07BUfVEATeQ9ik5BTWuCInLstCB2H1meh6+7v98z/ZjEPXisJSYyIVXMywfbkz/co82+k6UxgzqOmt7IDDnzCxMqxFzAXc6smMzv0mxK8s6rbIoTjmkg+8/yRspFXguPlW0rFtRR+DIw5dOH1DIOobM7mPtPyvlOczUrf41NFIQ6uq0TvLZqnEyaLbVYubv+1xvTIs6J6xlvh0qTA/qKz4Tk9EmRc9/M/NjYGQLFabsKl0Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76f92c8d-346a-41ab-8607-08def7562338
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2026 03:10:46.2591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZ3zNoZLlxSLZPYYCiTXYdyo1CiNEmUi3XwrBXNsWoKina93zlJv9j46d7vhdZv/2mnLK9D4ZXVm2wHFPxsgbuj/FKlGyZmNnpGY2BkrBc8=
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

With direct/scatter-gather access, 64-bit DMA and AES-GCM all in place,=0A=
the AST2700 crypto engine is now fully modelled. Drop its temporary=0A=
interrupt-only workaround so the crypto command runs for real, like the=0A=
other HACE variants.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_hace.h |  1 -=0A=
 hw/misc/aspeed_hace.c         | 15 +--------------=0A=
 2 files changed, 1 insertion(+), 15 deletions(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_hace.h b/include/hw/misc/aspeed_hace.h=
=0A=
index b5416b0cb5..9b0e7683fa 100644=0A=
--- a/include/hw/misc/aspeed_hace.h=0A=
+++ b/include/hw/misc/aspeed_hace.h=0A=
@@ -49,7 +49,6 @@ struct AspeedHACEClass {=0A=
     uint32_t key_mask;=0A=
     uint32_t hash_mask;=0A=
     uint64_t nr_regs;=0A=
-    bool raise_crypt_interrupt_workaround;=0A=
     uint32_t src_hi_mask;=0A=
     uint32_t dest_hi_mask;=0A=
     uint32_t key_hi_mask;=0A=
diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c=0A=
index e455216dd4..0c53383903 100644=0A=
--- a/hw/misc/aspeed_hace.c=0A=
+++ b/hw/misc/aspeed_hace.c=0A=
@@ -1003,14 +1003,7 @@ static void aspeed_hace_write(void *opaque, hwaddr a=
ddr, uint64_t data,=0A=
         break;=0A=
     }=0A=
     case R_CRYPT_CMD:=0A=
-        /*=0A=
-         * The AST2700 crypto engine needs 64-bit DMA and AES-GCM, which a=
re=0A=
-         * added later; until then it keeps the temporary workaround of on=
ly=0A=
-         * raising the completion interrupt without running the command.=
=0A=
-         */=0A=
-        if (!ahc->raise_crypt_interrupt_workaround) {=0A=
-            do_crypt_operation(s, data);=0A=
-        }=0A=
+        do_crypt_operation(s, data);=0A=
 =0A=
         /* Hardware raises the crypt interrupt once the command finishes. =
*/=0A=
         s->regs[R_STATUS] |=3D CRYPT_IRQ;=0A=
@@ -1214,12 +1207,6 @@ static void aspeed_ast2700_hace_class_init(ObjectCla=
ss *klass, const void *data)=0A=
     ahc->dest_hi_mask =3D 0x00000003;=0A=
     ahc->key_hi_mask =3D 0x00000003;=0A=
 =0A=
-    /*=0A=
-     * Currently, it does not support the CRYPT command. Instead, it only=
=0A=
-     * sends an interrupt to notify the firmware that the crypt command=0A=
-     * has completed. It is a temporary workaround.=0A=
-     */=0A=
-    ahc->raise_crypt_interrupt_workaround =3D true;=0A=
     ahc->has_dma64 =3D true;=0A=
 }=0A=
 =0A=
-- =0A=
2.43.0=0A=

