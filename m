Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4B0F433D4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBsO-0008JF-3p; Wed, 15 Apr 2026 21:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrf-0007rU-DC; Wed, 15 Apr 2026 21:49:56 -0400
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wDBrd-0007Ut-AL; Wed, 15 Apr 2026 21:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSO8so45sVV/IY3qD9I4FDlXistynRyfePX+AiKygCd67VUdVzJCM319ue0HOBUbbep9r1lU4rtvq4k44UF9OGqKBzLdFq/qmMVzqTuVE2lv4BbPxt/j3sM5rZbJoWlN3RBZQ9ZAwKnVh05g15h6d3pMMkhUoMSXkYwj4cV0MvNy59hVhbwvvUt/EmiHaxM5wHDEnHGViXgU25pSFxpxkUfECjtp/EgzKkviqFJQe/Kfnp4GrzMfy87b6H04OOtlEoLV0kiCJ3rZdckqs8QoCoJ+nEIvkySZBc7tSK35f7fmatCvy5YzXGXsqP5DcqMIltN9E4iRpeJmrkMbslT0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DPUuYGkfIR6j1AbiEpDRbnOQ1Z8Qp5SXYAhDVwcsM6k=;
 b=f9loNBb2x49Px5zp//6jDcn4IRQosnmmupDcgAGNpKxKxg72hg62qhtG1GYo+TMGqF9F3hv6O/IzwJ3eyf+PUpXiRgY8JsNR7S3gyfJOQz4eAnlAkV/q/8oBNxwoalRQ6AK/PMiv2XMBLQ1TQwXJztskIAtIWe0XeRO8Z3NeqGL+LjM5RCBWXWoNYOaQ4tgHo21KUdOxUhEW3kn6yy/R/bMFxZmazlIwTWuEVsERgGxMTlBaKGymrBSOI/b8VHZzbLkKBrQH2KrNZFR0xHcLeU1kCtuQ1DFxPCjpk9rsGGzG5e4WkvrxviG+poJ8h+q8fOuc6EsH3Zh2H0N/CprpcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPUuYGkfIR6j1AbiEpDRbnOQ1Z8Qp5SXYAhDVwcsM6k=;
 b=qo0GL3T9Ba+ynRpxo2AsQpn7/ZxKg8T9DJA5oQAjVFBiI93vZABzLqNR9TEX+Kj3gUZpqoaRivWajjt+bpbMx4WaIy8V8zQirw/WJuLgD4zxqOrgWFU4A6S1m4oqT7+preKAJ21pqkyNE0hmhxufANajik76uVir6yTVW4BUJlN/O87D2poxgVVtQTEQ3jz4IHVlgrCuV0T8GgCrBipWWv8A45cot7fWGnpnOF2x5ERoUZZPYEro9Cwl2POqvTOZey8xGNnarRTQjj89YhCvWiLHR+PLn6noMKZd7bVc8lGwcuNVI44Inl3GMn4Gv3amaIhPS6GOV3WgvYHtI9/q+w==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEYPR06MB6202.apcprd06.prod.outlook.com (2603:1096:101:c7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:49:38 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:49:38 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@linaro.org" <philmd@linaro.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "flwu@google.com" <flwu@google.com>, "nabihestefan@google.com"
 <nabihestefan@google.com>
Subject: [PATCH v3 04/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...) with
 qemu_log_mask(LOG_GUEST_ERROR)
Thread-Topic: [PATCH v3 04/17] hw/usb/hcd-ehci.c: Replace fprintf(stderr, ...)
 with qemu_log_mask(LOG_GUEST_ERROR)
Thread-Index: AQHczUNIl3qnO/08SECSdkVJPlcLgA==
Date: Thu, 16 Apr 2026 01:49:38 +0000
Message-ID: <20260416014928.1279360-5-jamin_lin@aspeedtech.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEYPR06MB6202:EE_
x-ms-office365-filtering-correlation-id: 1e8c41dd-f38e-4a3f-c326-08de9b5a6b71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Mbuq+qMGJmjvwmlYxQlota8PUBmeeyIug7oh4aCt44wrkOF82Zz3LVUsOXnekwtaXDb3NK6KdP/6gEdDMa4VhJ187doon6tfUQNh9EOmrTjD2R1k16t88B3y4HhjOgzH8vbqzifnhKAu56y36ef8YxVamjh0qyl97Zacy1HW1r6V36hoBzrsrvlPxLqgpjEokW4SdUoK+SSKp77nAI2gQdOjS9LuUHuJJyYEBt7VGhaa1ep7eS8hW/9Z7mnr8Aqr3lqKC3NnMThQwJgkeKum1LoHOAS6T5TxKx1bD8dLI0SUobtBnshetHLoJ492za6UYjiJAz3mpRkKI+XA9cZYFbyILJZjBbaYnqkJcjWrOucF20t7olLaeUloCxKfFe69wporErEvjWgUn0qXqdY5IWzDNT+qhhdwysPczskDl6PlcY4Ea8ARxziEMUaZu85CIh5s38ntDepPfFcl0OgFXx3PRo2A367L+07P5t26AHmX3kKJj+3FcX8sJWr9JNeDjbnPEiV4d/A7bF5SO8wKTSGfGSgHOdbP/FInEZloLl0soS06HB2Daq8t8wuv78FIhVsOm+Pg93tPc3Z425Ung60HvVUsCx15ZUT0aR4VcU4jvYM5htGI36D++TmudoYj29b9o23N551KuAA5MHJFQcg46JBaZpDSAi/Kzgv+4UFjEMEa2oNAAmThbUW3/lcQXQihJU89SsjwY2qwdF6cWJYJ15UbuG15BtjTiShNWEItqgkrdvCy/aVJMTBZ7T6qe5DOTwq5HBKS+Lq3AqYNK9vrN9M+Sv8qf7VDKoEMvv4/lEBrS4DVRKXuiryex8Y+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iGn3Y3jt5M1kh6V0zzOaue3PTOWrmrzuHefDXZ2OimX5gkkiBNriwKVJPi?=
 =?iso-8859-1?Q?LXviJa3ZWo4NCa8Zx9O9cV9HNofOmlq6eWH6WpKDaPj2I2q2aGanDcplVe?=
 =?iso-8859-1?Q?KJaeGvhmOd7pTJpa8ir8VrsLsDEaNTxZgmlFgMarH5z2YSudo29QhZdl2z?=
 =?iso-8859-1?Q?YhozWwN/GLsGmKKiJz4zWKVrh+3Od0+2SqWVdyrT//boIyRN7H8csUvauo?=
 =?iso-8859-1?Q?ryOfPniB2diGzZd/DmqLyK5OX8oWmJhokZO6LUKTwMpT7Inf5Gp2946+KF?=
 =?iso-8859-1?Q?tXGrjs29XrtEyju4FvgmjW8537/albZedynuH9LZevNSZpRml2uL4rhUZD?=
 =?iso-8859-1?Q?73PGPyywS4JNVWvVSF+Yt/nVfxcyv2fxaOaOTMsumC8qKCXShVAW77uqOl?=
 =?iso-8859-1?Q?QEBzaxf8tBEyiMqrdFEVf767XGgZDWjYSSyvf3IMNQt9ygEAcr+AfeKww0?=
 =?iso-8859-1?Q?fHQf20yE6IoyP4gXErJeTLGs4MkKjgSFUflZ76N6Aj38jGkjctTxzatc1T?=
 =?iso-8859-1?Q?fib5fLJ8b1HB3jyZfyfb+frAUMPfEys8Nepf9EKpTYSLxcyN+C56B3W3tU?=
 =?iso-8859-1?Q?zrsJJfS9SyTrEw9MPU0Zx4QBRffD7o+Vx1bQknP3OoRHg6wDpd6PXN4HRl?=
 =?iso-8859-1?Q?vjC8KxbVvRz5ph7AvV1MWsb24Ms789SM5+qlfAxA/rTDdrkYwbUlFZsMk1?=
 =?iso-8859-1?Q?RhNsgMGq6QKeir2eF3rb87oGawAx+sU59NpTx8dpVt51OiHNn0q03ZQl91?=
 =?iso-8859-1?Q?UUNqr+d6IIpWZ60vcV8yd9WSNzhohzHptsmmY7xbnjTIPlNmrUDeEIi25m?=
 =?iso-8859-1?Q?4LFMO7GLCQr8GN/oDmErvoAtcKhMo+BWFFk2l7Nk934qJEfpDvbOFXDvCL?=
 =?iso-8859-1?Q?Y6x73f+krHjRkltsShaDJz/Vhbkax+0vLRKAnCOGYIrajekz5ciNO/neDx?=
 =?iso-8859-1?Q?YlQlKEbZczI0UGzoS5rYxGMwCGuybnucYC+0R/xU7rH9GC0/9NDy7sf3bI?=
 =?iso-8859-1?Q?Za0SL5l7g0u5auPmxt0C8s6siSti6z7zINs/At95adoVGLHIn7Tgf76Wwe?=
 =?iso-8859-1?Q?MP12HuaIEl6wiMqEj9ratwKL+55Ne8U2TD3vKudMtA9EvSvGtLdzFzjTpi?=
 =?iso-8859-1?Q?LdWhNFOZQlopGmzsefP9rqL3cYCeDB13spGbGWD2wy1Zvpjr/GCcZsNhwH?=
 =?iso-8859-1?Q?9z4KgiERz5SG/AE+tgje5JXhxDRizu/yXGO6lbkqXn2qx1aC/sjP57R/ex?=
 =?iso-8859-1?Q?4R6++79Jjedbqlg//eEDlSgyRFt/0qoCJ9sQaHCWo5EazB/+tgyo6SAdL1?=
 =?iso-8859-1?Q?d9oeJcMFLBxRDo+fJokSgiI5UZ4ZGCCt92cb0jI3BoHMECLtAawCV4vlHW?=
 =?iso-8859-1?Q?YJKqYhpXEYqo8FCwFcIdzdiPaT4Xdk8Xbgn5NVZMJWxSx5+b/nzcagiW2K?=
 =?iso-8859-1?Q?EwXO+5FKGfLLJPxq+HsDdJBB61XbRvcNn3zLQvSQDH+ert/1X8TPm1/3Hb?=
 =?iso-8859-1?Q?PZ/KwaGDO93URHIxGlTZ4owdVa9danW8wwxBOD8C3EUwnYmwbrYNWBmdOJ?=
 =?iso-8859-1?Q?QS3Jl2SKlJGQcIpTQKw62y13fwnX32VkXX0k8VgC+Owd4jhB1EBJrPWbnv?=
 =?iso-8859-1?Q?oIjJTesFhF5mIsYLurV7HF5FTZjy0rNeTe03gRBNHY+YLslnkCSOOMdrrG?=
 =?iso-8859-1?Q?7Q0i3+lP5mZvLDzk17JMCSzhS8dx9PvLDDuWChvLNYkaJkqWkgianTDodC?=
 =?iso-8859-1?Q?5IUqFAPGRVp0CVcj9wM5hJQVwNKeF+fictmwDd2UygCEXNUfSruuMsKplX?=
 =?iso-8859-1?Q?voU0vYUwaA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TF8KPomgOKoz/0bV6bEke5Lf2a9Rl5xlQWKcCRvIvKrzyb+yF8hc/SCT3hjVqvladmSBUkiOT/1Zjxn4i/XVaCH5r7DJGQmlBkCBWGJanDDZv9EMWfCr/SnDS5sICZVWtM89u6Ty6j6BGP+8Y9bryAkIVkAz9LeT84yiT9YOeES4JDz3S0Ur1gSil+I7AG6u4iv2TDiVjZzmb9lVtU80UUe08QRR0POyCIP+5MKRNUK3d87SSI/XO6Y5tpqxOD4Ur9qLsq2W6YucynK0pFoexwsjX3vgenHcVJnoK/7/ElVJjpU+7S9J036uQk/DCOLYv5O4bRannO+zqX9fENGPJw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8c41dd-f38e-4a3f-c326-08de9b5a6b71
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 01:49:38.4947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASVQvH1Zt1EpNTgOhboFU2KZZqRTwtuUUXlrpvF4jGqVMRDEEhAyOTMBHFBh+3cagZVVkOHDHof1K7WbkFjPKmKQCp1mD29egGfSqjaC0Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6202
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYPPR03CU001.outbound.protection.outlook.com
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

Replace direct fprintf(stderr, ...) calls with qemu_log_mask()=0A=
using LOG_GUEST_ERROR in the EHCI controller implementation.=0A=
=0A=
Direct writes to stderr are discouraged in QEMU as they bypass=0A=
the logging framework and cannot be filtered or controlled at=0A=
runtime. Using qemu_log_mask() ensures that guest-visible errors=0A=
are properly categorized and can be managed via QEMU logging=0A=
options.=0A=
=0A=
All affected messages correspond to guest-triggerable error=0A=
conditions, so LOG_GUEST_ERROR is used consistently.=0A=
=0A=
This change improves integration with QEMU's logging infrastructure=0A=
and aligns with upstream coding guidelines.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 hw/usb/hcd-ehci.c | 43 +++++++++++++++++++++++++------------------=0A=
 1 file changed, 25 insertions(+), 18 deletions(-)=0A=
=0A=
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c=0A=
index 9b92384bac..bebd137f94 100644=0A=
--- a/hw/usb/hcd-ehci.c=0A=
+++ b/hw/usb/hcd-ehci.c=0A=
@@ -36,6 +36,7 @@=0A=
 #include "qemu/error-report.h"=0A=
 #include "qemu/main-loop.h"=0A=
 #include "system/runstate.h"=0A=
+#include "qemu/log.h"=0A=
 =0A=
 #define FRAME_TIMER_FREQ 1000=0A=
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)=0A=
@@ -425,7 +426,7 @@ static int ehci_get_pid(EHCIqtd *qtd)=0A=
     case 2:=0A=
         return USB_TOKEN_SETUP;=0A=
     default:=0A=
-        fprintf(stderr, "bad token\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "bad token\n");=0A=
         return 0;=0A=
     }=0A=
 }=0A=
@@ -532,7 +533,7 @@ static void ehci_free_packet(EHCIPacket *p)=0A=
     }=0A=
     if (p->async =3D=3D EHCI_ASYNC_FINISHED &&=0A=
             p->packet.status =3D=3D USB_RET_SUCCESS) {=0A=
-        fprintf(stderr,=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
                 "EHCI: Dropping completed packet from halted %s ep %02X\n"=
,=0A=
                 (p->pid =3D=3D USB_TOKEN_IN) ? "in" : "out",=0A=
                 get_field(p->queue->qh.epchar, QH_EPCHAR_EP));=0A=
@@ -1042,8 +1043,9 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
         /* not supporting dynamic frame list size at the moment */=0A=
         if ((val & USBCMD_FLS) && !(s->usbcmd & USBCMD_FLS)) {=0A=
-            fprintf(stderr, "attempt to set frame list size -- value %d\n"=
,=0A=
-                    (int)val & USBCMD_FLS);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "attempt to set frame list size -- value %d\n",=
=0A=
+                          (int)val & USBCMD_FLS);=0A=
             val &=3D ~USBCMD_FLS;=0A=
         }=0A=
 =0A=
@@ -1101,7 +1103,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case PERIODICLISTBASE:=0A=
         if (ehci_periodic_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: PERIODIC list base register set while periodic schedu=
le\n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1109,7 +1111,7 @@ static void ehci_opreg_write(void *ptr, hwaddr addr,=
=0A=
 =0A=
     case ASYNCLISTADDR:=0A=
         if (ehci_async_enabled(s)) {=0A=
-            fprintf(stderr,=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
               "ehci: ASYNC list address register set while async schedule\=
n"=0A=
               "      is enabled and HC is enabled\n");=0A=
         }=0A=
@@ -1200,7 +1202,7 @@ static int ehci_init_transfer(EHCIPacket *p)=0A=
 =0A=
     while (bytes > 0) {=0A=
         if (cpage > 4) {=0A=
-            fprintf(stderr, "cpage out of range (%u)\n", cpage);=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "cpage out of range (%u)\n", cp=
age);=0A=
             qemu_sglist_destroy(&p->sgl);=0A=
             return -1;=0A=
         }=0A=
@@ -1306,7 +1308,8 @@ static void ehci_execute_complete(EHCIQueue *q)=0A=
         break;=0A=
     default:=0A=
         /* should not be triggerable */=0A=
-        fprintf(stderr, "USB invalid response %d\n", p->packet.status);=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "USB invalid response %d\n",=0A=
+                      p->packet.status);=0A=
         g_assert_not_reached();=0A=
     }=0A=
 =0A=
@@ -1354,7 +1357,7 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
            p->async =3D=3D EHCI_ASYNC_INITIALIZED);=0A=
 =0A=
     if (!(p->qtd.token & QTD_TOKEN_ACTIVE)) {=0A=
-        fprintf(stderr, "Attempting to execute inactive qtd\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "Attempting to execute inactive qtd=
\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1395,7 +1398,8 @@ static int ehci_execute(EHCIPacket *p, const char *ac=
tion)=0A=
             p->packet.actual_length);=0A=
 =0A=
     if (p->packet.actual_length > BUFF_SIZE) {=0A=
-        fprintf(stderr, "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "ret from usb_handle_packet > BUFF_SIZE\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1479,8 +1483,9 @@ static int ehci_process_itd(EHCIState *ehci,=0A=
             case USB_RET_SUCCESS:=0A=
                 break;=0A=
             default:=0A=
-                fprintf(stderr, "Unexpected iso usb result: %d\n",=0A=
-                        ehci->ipacket.status);=0A=
+                qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                              "Unexpected iso usb result: %d\n",=0A=
+                              ehci->ipacket.status);=0A=
                 /* Fall through */=0A=
             case USB_RET_IOERROR:=0A=
             case USB_RET_NODEV:=0A=
@@ -1584,7 +1589,8 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
 =0A=
     /* section 4.8, only QH in async schedule */=0A=
     if (async && (NLPTR_TYPE_GET(entry) !=3D NLPTR_TYPE_QH)) {=0A=
-        fprintf(stderr, "non queue head request in async schedule\n");=0A=
+        qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                      "non queue head request in async schedule\n");=0A=
         return -1;=0A=
     }=0A=
 =0A=
@@ -1606,7 +1612,7 @@ static int ehci_state_fetchentry(EHCIState *ehci, int=
 async)=0A=
 =0A=
     default:=0A=
         /* TODO: handle FSTN type */=0A=
-        fprintf(stderr, "FETCHENTRY: entry at %X is of type %u "=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "FETCHENTRY: entry at %X is of type=
 %u "=0A=
                 "which is not supported yet\n", entry, NLPTR_TYPE_GET(entr=
y));=0A=
         return -1;=0A=
     }=0A=
@@ -2112,13 +2118,14 @@ static void ehci_advance_state(EHCIState *ehci, int=
 async)=0A=
             break;=0A=
 =0A=
         default:=0A=
-            fprintf(stderr, "Bad state!\n");=0A=
+            qemu_log_mask(LOG_GUEST_ERROR, "Bad state!\n");=0A=
             g_assert_not_reached();=0A=
         }=0A=
 =0A=
         if (again < 0 || itd_count > 16) {=0A=
             /* TODO: notify guest (raise HSE irq?) */=0A=
-            fprintf(stderr, "processing error - resetting ehci HC\n");=0A=
+            qemu_log_mask(LOG_GUEST_ERROR,=0A=
+                          "processing error - resetting ehci HC\n");=0A=
             ehci_reset(ehci);=0A=
             again =3D 0;=0A=
         }=0A=
@@ -2175,7 +2182,7 @@ static void ehci_advance_async_state(EHCIState *ehci)=
=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad asynchronous state %d. "=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "ehci: Bad asynchronous state %d. "=
=0A=
                 "Resetting to active\n", ehci->astate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
@@ -2225,7 +2232,7 @@ static void ehci_advance_periodic_state(EHCIState *eh=
ci)=0A=
 =0A=
     default:=0A=
         /* this should only be due to a developer mistake */=0A=
-        fprintf(stderr, "ehci: Bad periodic state %d. "=0A=
+        qemu_log_mask(LOG_GUEST_ERROR, "ehci: Bad periodic state %d. "=0A=
                 "Resetting to active\n", ehci->pstate);=0A=
         g_assert_not_reached();=0A=
     }=0A=
-- =0A=
2.43.0=0A=

