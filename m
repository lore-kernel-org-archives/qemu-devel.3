Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E887C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KEq-0003rO-Ir; Tue, 01 Sep 2026 04:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEp-0003ql-Rg; Tue, 01 Sep 2026 04:53:03 -0400
Received: from mail-japanwestazlp170120003.outbound.protection.outlook.com
 ([2a01:111:f403:c406::3] helo=OS8PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1x1KEo-0007J9-1N; Tue, 01 Sep 2026 04:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohzA9qtAzJod4R5gJshDaREWQPGZDjufm25f3/dHLVZPIG0npoeaLBSKYRzaHdq0eyrAVaVty1hkBWAQIUw1niQOklW3uuB6ngr9W5gzMI2y1q7vUBB6u1mqgz995wA9KKH7/Pn+3US2LdC4VVN/45lyqUupGXq58EEBcmsv06eu+XADhJR0ag/EWrbayH6CNB56uD2BsfFl+ss64F8D1giKXvzM2jMFpWI60rbBCmK2sq6U2GZcahCABAMar8U+cDe4S/M5BE0rj9KzdZLJxS0mYWyA/m0J05k4bz5Ki3KWiIjOD9dqke3xxCRHor9XAIm0IsS2cqYGGiZ7IOntJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqsxQhCLxp9ooaRakKxe/JYvm7MDhxaGA/9mnebv+rE=;
 b=xyRZ1nPpSIEt49lHx+jsgqdlpwDuhWdaKHNawQ9/KpfXzFO6o9HcBTJehoBzEBLjg584bDpHCt2NMv8YG7xZrqzKR59iaj9nIURkBLat+mNqtQyYQNUBtKa5uG9pgDEDwVFRQqjQbKgTvSbgUL8wedf7ZbyJP/AXOLZ3bcCMGu/oVQfVaCukPPrDW8BLDRkCt+1oZqq+fCVXYL9Lt9c4fklelSG4LJanYcp7a3RNXeTzIq+PtpAvTpIafy873EWcdEIe4e44SI2dZ+r/doZ1CZGsoyEEAws9B+nS13EZDdi7wsAuL8n2reu7GNqfC6+eCu/hos6TJVEdERwat/fqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqsxQhCLxp9ooaRakKxe/JYvm7MDhxaGA/9mnebv+rE=;
 b=qYe1DdjM9IlW7gW5FqJHbY3jhl16w42YKFIyJGZQW8TcvE7643TkK8vjoLUjvGlZC4YYcS3UKmHdZ9AEZgpSjMRQ/39PlFQZHrS5RM3TuVqYcM2KjkqI0OVUDrgteThdoicx43qcVBdv/6gV6gI96u4Gh9QyL/0AzgO39xUz3MLZrdBcgEtGant4vlTOenDio85qq9l9NTQCiwe+fhQlP1FEV2E7+/j+W570+pqYYhFAEReUQueTIQx64s23qXKD4wGYIjsmviszgm7nuuOU6QkMscA/EKartW6ih0yPf6yWH3yTgOnAtwpTCYJFRqUZLrIMlWpGyKGMaTCiOiAx1A==
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com (2603:1096:400:1cc::10)
 by KU2PPF557D403C2.apcprd06.prod.outlook.com (2603:1096:d18::495)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Tue, 1 Sep
 2026 08:52:47 +0000
Received: from TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3]) by TYZPR06MB4980.apcprd06.prod.outlook.com
 ([fe80::ea8a:7cb7:4822:2fb3%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:52:47 +0000
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
Subject: [PATCH v4 7/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC model
Thread-Topic: [PATCH v4 7/9] hw/arm/aspeed_ast10x0: Wire SEC SRAM to the SBC
 model
Thread-Index: AQHdOe9C0YFvrb2gIUSZ8ElFOtqhoQ==
Date: Tue, 1 Sep 2026 08:52:47 +0000
Message-ID: <20260901085238.995968-8-jamin_lin@aspeedtech.com>
References: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260901085238.995968-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB4980:EE_|KU2PPF557D403C2:EE_
x-ms-office365-filtering-correlation-id: ec8f3618-dcb7-47dc-3125-08df08066583
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|921020|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info: P64vCH/iNqec+PpxRf+m/eaCOOo47SS6/HAI3kDCQb6o8sv63f3zdSz/eOxD19BS2n/k1nuv8s+wSHHszkRiilysG9p5XP13m8QOfFZGVnUxLE92xb4s2EqsvGBNJX3yWNhYL/Jzk5fR50/rnckXFCUbJIL3RBZT8evH9uxVhtERd6m2De1f2RlT+fxxsvdJ5xrworKxzGVYilEldvK8vbKRO8kmHq7N0suUCM1gS5YQtyIqJyNF/lUFbI+LTtc7gfHdPtuoXjN1rmmPMP9wE26OCwK/w+8lTYJiN5spEqvEhIPEXrneUWUQqEqQvLetie6bnUiSAHT++Oz0Pun3FrlmbnVVmcIr1gNaOIWe8nvdlyXL3sU1sUtIpQ6hzJP0qFYmcphrAdkYbuwLzKbCeneKtUicuPivXgj0M6BF73BvolJrbERT/ytTn0X5HLwc7h8La7KdPRfAavvXkCNAUDhD+DzqJ4yE1a5c2lodtLwI/LfT+I+QMtR/0RSEVD5oYDiJgxJoftpXs3s/Sizf/Q+1gn+tKRQ1zWA5YLImGuEZ3/MCb58OYJIq49AyS3PfANqBkmdXVD1sXCPo769U2Av6j+TQYd3vn6VPPSd2U5p9WADoK1FkrZT+HuE/MuSlP1nfmod/GGg1Ud7uuWC3sp0bZHXBFwG0xz7yZs8mOLjgB6hhe6k/TIOR90fWAVtGe1EKUOOg+ZgowZIfyimKkbTU6inBZVgPGC7zomlGQ0Qo/KJH8Rtz4rpPPSbUKA9T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYZPR06MB4980.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(921020)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Y3bTT6lwGM52U3Lm3EL79jJj1De2toC2bJUyAA94YJz2uQ6zENT6lG7ymD?=
 =?iso-8859-1?Q?+++GGfpTS3Llkz6UcIKESvauPUUlQnt7G1LLbYDN+AOMUlaNBOhDhgiKpI?=
 =?iso-8859-1?Q?bnjFokyteWONsCccl/nR3eTH2QFAUVm59dV/gbpkMEficehXpOlE+TsmZ/?=
 =?iso-8859-1?Q?4tu8kExvz+Ev19KrBysVN5GEGukmnW1rtQY8O3GdYF9RZjid+m8Ub98neB?=
 =?iso-8859-1?Q?/zxDo+9kuZ611ZZZTbQiJkW/Ta3p5jWQLeJ0G56S//iiO5ByB+/UA2IZMe?=
 =?iso-8859-1?Q?52DXmc6lMMiacPHN0Lan/CpLC98P3rdh1HrKGwx2m5+oz7z0ObZu1nqGPq?=
 =?iso-8859-1?Q?lNHg+1pdqyjoi6dx1C7VKcqtgZq07Fcgp+uZuVSq5IuUu3I9yQeQww5DqV?=
 =?iso-8859-1?Q?wl6QWSyjaKXJxGYO2dCzLBtmPvTmq2F5Wn9+V2PFmxU/ZZD+W7dYyxcDjd?=
 =?iso-8859-1?Q?ng5UaYyMWaqoaeaY13q6L7I5Rxa53FUaMDQ75+KTdRLcU3uZ+mX/ng5PCs?=
 =?iso-8859-1?Q?wMEkBKXM3vlclhDGkIRioBHKlw8ZC5vxmAXt/dK9TEJgtmJr22USWlv33g?=
 =?iso-8859-1?Q?3l6YVdruF+5XDnMKC17YeLxIdCxk+kNyKiITNktjsuJjqtVVRmnUW2CeIr?=
 =?iso-8859-1?Q?2X1dY5/76Y3dolTCn00ZYzQG1B39tKh+3aDQb+r5fYm+cFbjhvYEjVqRN2?=
 =?iso-8859-1?Q?JiuORunnbVScLh2zB0X65nsmKz3bTGw89Us0XvhC091vAxdPKrY5UOtS3R?=
 =?iso-8859-1?Q?gv8W/WJT0G3ni121Rqbe0fIAWF9yNMu8wTViUqPNMa0qMrZBR/37JFpAN7?=
 =?iso-8859-1?Q?lQbiqJQueRs8JD/CebPRugCHAJLtMhj1NhHVpXt4gbIkWL6xRCimaABXCO?=
 =?iso-8859-1?Q?QVHQjxnIdGYTTAFwksZdc4OJvGOK6BlnujyyYgLjSKUCqMbvjlr9NgbDUe?=
 =?iso-8859-1?Q?EayXkwUARgODn5PqhL8kmsp4n7TRRy/wFht2FjfI4XXZkDT2kLUZNih7Xa?=
 =?iso-8859-1?Q?clCNh9lhkvBlJIrkZ1nCIHz574i94usAXH4mupx/pHLl09m5V8qzmaV4C9?=
 =?iso-8859-1?Q?4l7yXxV4nF95/cqHX7QHWUBHMfZtxgMOFJo5BTuicqEBgdHtW/g1cm79Fj?=
 =?iso-8859-1?Q?4rLuY14uTI12/28g11X7tOPvO3l89j6Sr0qrSOw/oE+hQQv3vgOwgYurZd?=
 =?iso-8859-1?Q?PdU00FWr8gZfeSeraxkvdBF/y/AOIRf9feFkoGcFzqoUvh7mCZ+TLp0YkU?=
 =?iso-8859-1?Q?PQ9rqIwd8cFhIrS99s6ZXRh1sJdHWyRWLssQcfcowLKwbxw2TCt9zxPHak?=
 =?iso-8859-1?Q?wuev3RaC7SQhd9l95pBOWhqjfB8tIgpxE2qQ6dQi1KZ741GQQmZcU+OU/u?=
 =?iso-8859-1?Q?SbZefvLeeHctjeGm6KWoEsGm3c/9kBK3Ub/1Kd8xIvX1yGFNZHl/14Hkpg?=
 =?iso-8859-1?Q?RmhF68//vhhjPnUnSKWglQCFc9gX6xzAUxFBYywkD6JVU4H809eL3uBBSu?=
 =?iso-8859-1?Q?TjtZC3pu3b1/RTsgG2yldculOtorVw7PgXum8B+NpOjaHsUWmT7iqSLZsk?=
 =?iso-8859-1?Q?ZNMrLFarSPnjFeMFXCLzh6s1yutBADWMdNKmY1LUyqYRCZ84vZiUjK9mF9?=
 =?iso-8859-1?Q?Rgq9Fy+05yvSqB3T4UxM5j3L55XHmmzIm1WgG/Ey8qNNBj5C6za89TDx5c?=
 =?iso-8859-1?Q?Mwu8bjUwye2s6Nny0TH/VdDGRwrRoKHlx5itusIElHeY7i+UTvAZG237Oc?=
 =?iso-8859-1?Q?RfP1bWWl/FheKgLffdXU7DVwdEgSZFzsGz5uhLE6hpQ4u1hSVbtWijJd8z?=
 =?iso-8859-1?Q?VHN63HuIKw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: af4z0QssIS7h0ztMp4Y3lt8ZdCaQR4ilvkOfcN8SklbzeQFanOr1PZwYz9er+aRDWdRmt+huHMJd92+B0nLMyayAH4wHNTY73u6xx8xUyqK/t4wzUphpRFKSnCB5ck0g0AXx9iMN8zOEYMB04bRUr+WZWuK7sSBVY8aD+yRWCJfkrLPmqxkOiTNftY6zeB9lw97o+WzUrug0Vs4VXyNitiIfhsz9ce4eauvqlrj1G4MofVFp7gWFmk/GP2tB4ak6eIEuz3N/BzOXliEfEHLSpfx7fR5zez3iZ/b1dhXeuXXPRP4lzvQia4tB3hMJhzeEXFvlZyqyyj4umpTKLtwP0Q==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4980.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8f3618-dcb7-47dc-3125-08df08066583
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 08:52:47.5183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5y9Mll2ixDNmQohKFrpCvP6sgC5NUskEiDzkdFzj3cysquPYOz0mTeDSYCrpvIfpeK9LrohkMyU4x6ONNk/wKAOpXoyGEEUm9qQ7gQgd4eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPF557D403C2
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

Introduce the "has_ecdsa" class attribute and enable it for the AST10x0 SBC=
,=0A=
as ECDSA is only supported on this platform.=0A=
=0A=
Add an "sram" link property to the SBC model and initialize a dedicated add=
ress=0A=
space for accessing the SEC SRAM. This will be used by the ECDSA verify com=
mand=0A=
to read the public key, signature, and digest from SRAM.=0A=
=0A=
Wrap the SEC SRAM in a container mapped at offset 0. This allows the ECDSA=
=0A=
engine added in a later patch to access the SRAM using relative offsets wit=
hout=0A=
requiring the SBC model to know the SRAM's system address.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/aspeed_sbc.h |  4 ++++=0A=
 hw/arm/aspeed_ast10x0.c      |  7 ++++++-=0A=
 hw/misc/aspeed_sbc.c         | 11 +++++++++++=0A=
 3 files changed, 21 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h=0A=
index eea6e2b27f..756c612356 100644=0A=
--- a/include/hw/misc/aspeed_sbc.h=0A=
+++ b/include/hw/misc/aspeed_sbc.h=0A=
@@ -40,12 +40,16 @@ struct AspeedSBCState {=0A=
     uint32_t regs[ASPEED_SBC_NR_REGS];=0A=
 =0A=
     AspeedOTPState otp;=0A=
+=0A=
+    MemoryRegion *sram;=0A=
+    AddressSpace sram_as;=0A=
 };=0A=
 =0A=
 struct AspeedSBCClass {=0A=
     SysBusDeviceClass parent_class;=0A=
 =0A=
     bool has_otp;=0A=
+    bool has_ecdsa;=0A=
 };=0A=
 =0A=
 #endif /* ASPEED_SBC_H */=0A=
diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c=0A=
index 5165dcce59..aeb5a4423d 100644=0A=
--- a/hw/arm/aspeed_ast10x0.c=0A=
+++ b/hw/arm/aspeed_ast10x0.c=0A=
@@ -250,8 +250,11 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSt=
ate *a, Error **errp)=0A=
         error_propagate(errp, err);=0A=
         return false;=0A=
     }=0A=
+    memory_region_init(&s->sram_container[1], OBJECT(s), "sec.sram-contain=
er",=0A=
+                       sc->sram_size[1]);=0A=
+    memory_region_add_subregion(&s->sram_container[1], 0, &s->sram[1]);=0A=
     memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM1],=
=0A=
-                                &s->sram[1]);=0A=
+                                &s->sram_container[1]);=0A=
 =0A=
     /* SCU */=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {=0A=
@@ -350,6 +353,8 @@ static bool aspeed_soc_ast10x0_realize(Aspeed10x0SoCSta=
te *a, Error **errp)=0A=
     }=0A=
 =0A=
     /* Secure Boot Controller */=0A=
+    object_property_set_link(OBJECT(&s->sbc), "sram", OBJECT(&s->sram[1]),=
=0A=
+                             &error_abort);=0A=
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sbc), errp)) {=0A=
         return false;=0A=
     }=0A=
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c=0A=
index 7397d9bbf0..f10f7ac578 100644=0A=
--- a/hw/misc/aspeed_sbc.c=0A=
+++ b/hw/misc/aspeed_sbc.c=0A=
@@ -306,6 +306,14 @@ static void aspeed_sbc_realize(DeviceState *dev, Error=
 **errp)=0A=
         }=0A=
     }=0A=
 =0A=
+    if (sc->has_ecdsa) {=0A=
+        if (!s->sram) {=0A=
+            error_setg(errp, TYPE_ASPEED_SBC ": 'sram' link not set");=0A=
+            return;=0A=
+        }=0A=
+        address_space_init(&s->sram_as, s->sram, TYPE_ASPEED_SBC ".sram");=
=0A=
+    }=0A=
+=0A=
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,=0A=
             TYPE_ASPEED_SBC, ASPEED_SBC_NR_REGS << 2);=0A=
 =0A=
@@ -325,6 +333,8 @@ static const VMStateDescription vmstate_aspeed_sbc =3D =
{=0A=
 static const Property aspeed_sbc_properties[] =3D {=0A=
     DEFINE_PROP_BOOL("emmc-abr", AspeedSBCState, emmc_abr, 0),=0A=
     DEFINE_PROP_UINT32("signing-settings", AspeedSBCState, signing_setting=
s, 0),=0A=
+    DEFINE_PROP_LINK("sram", AspeedSBCState, sram,=0A=
+                     TYPE_MEMORY_REGION, MemoryRegion *),=0A=
 };=0A=
 =0A=
 static void aspeed_sbc_class_init(ObjectClass *klass, const void *data)=0A=
@@ -355,6 +365,7 @@ static void aspeed_ast10x0_sbc_class_init(ObjectClass *=
klass, const void *data)=0A=
 =0A=
     dc->desc =3D "AST10X0 Secure Boot Controller";=0A=
     sc->has_otp =3D true;=0A=
+    sc->has_ecdsa =3D true;=0A=
 }=0A=
 =0A=
 static const TypeInfo aspeed_sbc_types[] =3D {=0A=
-- =0A=
2.53.0=0A=

