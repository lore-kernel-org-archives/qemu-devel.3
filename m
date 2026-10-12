Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2B2CA9ED6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG9mS-0001jt-Fv; Mon, 12 Oct 2026 02:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mM-0001ii-Is; Mon, 12 Oct 2026 02:45:00 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1xG9mK-0006MT-I1; Mon, 12 Oct 2026 02:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCqMji+yFyD6vM0oH/G405cHPbcwHyzpPwKef2hOut5k0py1tadGjDxFAkNszsjze/oMkn6FLpItO1pQJC6KUwEWYD9rDYGpSIMpKwjNQsChlTsg4UXNKMbXWjFVNaRWtuTwOXwo7bm6Zl7g7bUR+nR8frIPIjClZYOaB418zs21/booOT5HeVUXrS4HT8ZlEH9zBaDLXoe4wzPQ5byjBwKZK9fSqbjFNWkMq0zC2Go7+PiPET/JMuIG/+9OyU9rBLWd8dTLny9090kUkT8yxLGuFFBKQLVCWBMZ95U+6uek2oabxwnB+LkdUQV7lZmLeCOPZ3kI6znQm8KPymnCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OY27Qx08dW8Zys0s0KmIAxX730KvsQ8Jrawdepy6vQ=;
 b=cYlI/H0q4a9MOEaA67XvyZ2MGW1cS4dizF1ayvAZ/URtFVFu5rfnFO96KaAN3/T/kktYJe5PpAVf23jNEvc5P4QipAC0bJ4X55qS4lIlwalQ67aJmxGgySnXhEz+FnFqtWfQR6otZNEe0tP35vYbGEemOFa/kWfVwDlMaxvlA6Z7xeagcKADzD7QZG2uVqTZbQWIyYEZ9HHZ05jFGj3RVOR88tV0AgQTZreCov45J2j+jX4MLEF04QMEMsu8Sv6xMVnIPDEc8S1Ij+P+JB+2/O/C7l8IjW5Z7p4dxfzy78HZPXL5w2PqioRatI95VLAeA0ox7T3TCtsgjwasc3zlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OY27Qx08dW8Zys0s0KmIAxX730KvsQ8Jrawdepy6vQ=;
 b=E230XVgyYhKVk9QQIeAK/n+7Om5gIWVOIwpVV7vNWUqvOGIEQ062kLjqk0WxDyfdc17nWDpYTC1Y3c/zYSBlgm3I3Loe/9JTnHXKPy9J6J9TqQmEa3cWmrpWkRzU9Bf/n/cDgeDjlKoe8OVtqBzfb2pgRuCMmSikst0VusrEPjUz6x/Na4lYm3mcNegFad+QYoGvktJDt7G8vZUPhIiMy9WJq0C+nUqqrx0Mp4uEJDTRrG+Qpw54NWtZNIiIo+fi4gYuXZvTMg5k3amltE2K+ubyNY0iqYFHqqyNrbi2rxLMdyGYfNlGhUPt8W6ZOfhTiKGUYi0FrWCdEBpudZCY/Q==
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com (2603:1096:101:253::10)
 by SI6PR06MB7244.apcprd06.prod.outlook.com (2603:1096:4:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 06:44:47 +0000
Received: from SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6]) by SEZPR06MB7362.apcprd06.prod.outlook.com
 ([fe80::cd2d:35d2:a702:1de6%4]) with mapi id 15.21.0496.020; Mon, 12 Oct 2026
 06:44:47 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Ani Sinha
 <anisinha@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: [PATCH v2 01/12] hw/misc/unimp: Add create_unimplemented_devices()
 helper
Thread-Topic: [PATCH v2 01/12] hw/misc/unimp: Add
 create_unimplemented_devices() helper
Thread-Index: AQHdWhUsNiuZTkRDnU+UXALkHv/p8g==
Date: Mon, 12 Oct 2026 06:44:47 +0000
Message-ID: <20261012064445.2571633-2-jamin_lin@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR06MB7362:EE_|SI6PR06MB7244:EE_
x-ms-office365-filtering-correlation-id: 377113dd-cd0f-450d-eca2-08df282c4e8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|10067099003|261009220027099003|261009223327099003|261009221227099003|261009221727099003|261009223027099003|38070700021|921020|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: /r3B926Pmu0p8Sqh1nSBVqkUztlqDRjBCp4kjZZxtRw1baLUhhc8SyuFGjKcq3CKzaA+FjHZeZr7tWXDLg2NqqS+D3iJwe0MNsQctENqLIcfdB1DBMbOQEtbAoiFb3gemfK/NyYAjC7+vPSIF0yOq3wUlnWOTvWyJMaL5G8mjXNxKLU6siavr4O7Hjm8YamAgh++8mZUmcHOKIZvJs1DCbYqfwrKkJhAlpPtfBZZtt7XZg8JYsNIS9QQoMpSz61xxHdvBdEyhxkK63h8jDpXK9nNpYi73K/3WwO/w5hZCw+EdjLN0oZ4OhaZy9mTkXdiextaGyAQzI8vXaSpBgHZsd4qIaGSzzNuYhDC1B+pNPxew9yYFWU+8gAfh+GseUfK+RO6slCTsN2v2QXN2cGHFrAnvjfTr4tME8/YsgoIUtbA9RWlAwSljHscDw/EwBsgRhmdIyfKmM1lbmEAJ9WqvzFTdNtTKD14BQr5gaDYqVvlMTCKcWB4qOTdZLST6fW3ZnAPo66vNWYx08hFNKI65L0A/a2dRxlohMNnrncG8/nA/cDIyVIhcKK0Pegidx7Jmp1jFrdt5MCQJKfDbqidN6OpNALpMYC3HylNS0a5SA1h1H3RWpIkFIfJsntW/S/JEu6XWTT82xivbpWah8ZTXdsAh8J81+VGBqucM5qzmCF56DcDEg2Ue02bgsujDp09ifxqv0leO3wS+0EH9BTnGL/072C2WrsaWrioSzkNFXUrwfE3h5KjvqXvJJaUFV2F
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB7362.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009221727099003)(261009223027099003)(38070700021)(921020)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HaGTO3UxQ9xBQRw7UgMzDzTHtQWWOcq4ZM7MPwc3QkqG2GYvSxg90e+OWz?=
 =?iso-8859-1?Q?Kyv2uQKk7x6CZHDPZmo2h3raX5puVY2ZeiXjlk3HU2313Du/o6A+ZAZ13O?=
 =?iso-8859-1?Q?kxa9gsWVXGxUqRyYkqmT/wFsi751uH8Ah5M47FdSM4I4QcCG6SPDeZVyQF?=
 =?iso-8859-1?Q?RRFo+WGo7bgbfZiYkZdzlX5ZTBq3HHE5aoccUX6y3mKGjw/Te24/i6whh3?=
 =?iso-8859-1?Q?5W9CQiPd9UsaNKCtah8Ibcyv9P4FOdN/aGJy6I6JywSW4JWnl4VhmCmWlj?=
 =?iso-8859-1?Q?fQ8FrXptK2HBnPipUlo+dn5086+H9YdMBYvklJ8TtNMtDFifQOiPa74uYw?=
 =?iso-8859-1?Q?aJ13JJ7575YFye0PNyPPy7aGb8RyBBH6gkyeKIpHQZ0ikhdsvZnLJgBFwb?=
 =?iso-8859-1?Q?uhTKR3BuRx376SdGWfx+UMzIpKIUNzUOd8+5X7bhMhkjEwVhRJRSh4hMyP?=
 =?iso-8859-1?Q?++NNVMcCjR2l85v9ZYPA+WOrcIywtwxZ/PNrZfMIVMY6WOMd9QIZVH860c?=
 =?iso-8859-1?Q?Vu/WcIh2M2jdBeWQF7bzQSWe49lX3fYo23jUMtlh9nlZ4s9gdomo16kbyc?=
 =?iso-8859-1?Q?YGuNd8WnSijTYsa9brEYxQlyxWCfySQof2HffGxa2JP/am2I/vyyxaAJF5?=
 =?iso-8859-1?Q?CfHuWawR4OYtYhM9IIHYwJ22M7DmXlFv8E3B0f3OW/7/0QasGy450nxmhw?=
 =?iso-8859-1?Q?Jb8HjuTjlEUTJt2+/EO9RdE4yzP2GNk3BhIdYTy1GEEvjX+O913ycGX8ro?=
 =?iso-8859-1?Q?GDf6WO6mAew3pF31TPJKVDN4LoCkzwsLfWWnsfJxLy1K3/viB6eF1Lookb?=
 =?iso-8859-1?Q?cW73BrjIshkLBf5Gc8FwDg20idiO7yCPcWur20S5gVohmTEghzHkKz+b+/?=
 =?iso-8859-1?Q?BaiXnSDl5yanhvuwK7zCI06DzJaIpL4LmC61ZFib0oyQT883S6/6/lgmmx?=
 =?iso-8859-1?Q?w2UHPgLVpYIXu/cV4mVaxM6q71SCl+U4eAYgO7+xCgcSaMPz3V8ITkFZcj?=
 =?iso-8859-1?Q?LphuxlOM817r94sn78j3UQKI4prlyF0KHytI/6lTk4Q4E4p+r752hcKcZj?=
 =?iso-8859-1?Q?xEb+8TQhabyLHlORHZA8iEy/Fu7iueRCQLn7Bc7Hwc0waG2otw7LwAviMP?=
 =?iso-8859-1?Q?WWjZWJBQJSdlsHEeVOlOyMASbwDCICeD8ygiTnJqcbcM5qD+afjKiWvC8J?=
 =?iso-8859-1?Q?NlcM/D5fO1E4ys/GiJToYGrUUMrTOBPtW10qTslTa/BIriJRBfbdnW6fdR?=
 =?iso-8859-1?Q?GM/lMlMGaMXCY530Y2KH3TcUJmcqj6wpijYOTMZq9Obac4j2xM+4+T0ZW9?=
 =?iso-8859-1?Q?aEnT4JiB7wEpiPbe67SzToB1PiSJIsFkxcBW2qreDGwtFhToQDjzJaWgA+?=
 =?iso-8859-1?Q?AfsS5IAdHFzMSJF2jnhfSKFdPuu0YfZZ9CnjhqCvfni1qRLvsPnUdspm0K?=
 =?iso-8859-1?Q?dwyipmO4JVhBlJ1kqg5IQCcUVc0f+bRn6WUfunFYmWEi2ag4t8Qsl7IsVw?=
 =?iso-8859-1?Q?yO2DBn4bKc528vlq3U/pumUfosi9ncsp/DEC5YUZXxLJXsp07APDuJMySu?=
 =?iso-8859-1?Q?G7jvPcSpjd3enIAwWqD1O2IpXo9NY1GRSDXoixV+xKk98yjmsodtTwXtDr?=
 =?iso-8859-1?Q?KjTnfLjtvkWH3+lPO10AsxEOEvwo5jjXExMZa7De8L3ggEChjgh8v1ut4g?=
 =?iso-8859-1?Q?Te3SE4rCbshtAmxgqI2xm1sZQQhVWRqa1bRu1vxPk1IEB95qRbm4fYThUQ?=
 =?iso-8859-1?Q?GskGL0rIHERLAs+GXVVQO06CI4aTneIMGGw75w4/NYpm7NgxoCwUZR9ndr?=
 =?iso-8859-1?Q?27SUoohoCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MQieRVqGVrIY6fe1sQMr80cW4OZ9WWVwL7pb/l0SDaCiFmNYgOC0TVTcjxGAnk+NPvUv5BICp4UKTeJH9pum1gY/BIDwPFUc6zS0YwgkY1UVrkvsvn06xrFYBH5SCPtVYB96AgVrtDSvKNJeXDghf3MwkclDOBN2Ectpn7KOCIqEG67T6g9ztII78mwV4T6Xck9dUuoqo8is7sGPXQCrDPyJTId4YGDLWJ+lTu8rtR2p0tFXe4IlKdBCXS5GaOLCuIkuejKWv1272ZO7bgOWeuVPr5GhdqYhJU23BtKSE+ku/IdjiTu3YOEjxUg4ovU4o0BZg1evGNzhnpG0v8tFTA==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB7362.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377113dd-cd0f-450d-eca2-08df282c4e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2026 06:44:47.0750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drm0RmvWDjbGMmaoqXed3Ikkg0HLg4mEuwHN9ML3RPpHHLRdNMJgK4UbXuYqAaZszHrbZ6vu4aDqVLHrJcRQOG6qrLVp90m+x6T5qcbpMcM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7244
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

Several boards and SoCs create many unimplemented devices. Each of them=0A=
uses its own structure and helper to describe and map these devices.=0A=
=0A=
Add an UnimplementedDeviceConfig structure and a=0A=
create_unimplemented_devices() helper. The helper creates an=0A=
unimplemented device for each entry of a table, adds it as a QOM child=0A=
of the parent object, and maps it in a memory region container with=0A=
the given priority. The table is terminated by an empty entry.=0A=
=0A=
Suggested-by: Philippe Mathieu-Daud=E9 <philmd@oss.qualcomm.com>=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/misc/unimp.h | 21 +++++++++++++++++++++=0A=
 hw/misc/unimp.c         | 20 ++++++++++++++++++++=0A=
 2 files changed, 41 insertions(+)=0A=
=0A=
diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h=0A=
index 77a5077511..073575159d 100644=0A=
--- a/include/hw/misc/unimp.h=0A=
+++ b/include/hw/misc/unimp.h=0A=
@@ -25,6 +25,27 @@ struct UnimplementedDeviceState {=0A=
     uint64_t size;=0A=
 };=0A=
 =0A=
+typedef struct UnimplementedDeviceConfig {=0A=
+    const char *qom_name;=0A=
+    const char *region_name;=0A=
+    uint64_t offset;=0A=
+    uint64_t size;=0A=
+    int priority;=0A=
+} UnimplementedDeviceConfig;=0A=
+=0A=
+/**=0A=
+ * create_unimplemented_devices:=0A=
+ * @parentobj: the parent object=0A=
+ * @container: a #MemoryRegion within which @addr is a relative address=0A=
+ * @devconfigs: NULL terminated array of #UnimplementedDeviceConfig=0A=
+ *=0A=
+ * For each entries in @devconfigs, create a TYPE_UNIMPLEMENTED_DEVICE=0A=
+ * and mmap it in @container at UnimplementedDeviceConfig::offset.=0A=
+ * @container is expected to be a QOM child of @parentobj.=0A=
+ */=0A=
+void create_unimplemented_devices(Object *parentobj, MemoryRegion *contain=
er,=0A=
+                                  const UnimplementedDeviceConfig *devconf=
igs);=0A=
+=0A=
 /**=0A=
  * create_unimplemented_device: create and map a dummy device=0A=
  * @name: name of the device for debug logging=0A=
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c=0A=
index 521b84bf20..4c8dcbdff3 100644=0A=
--- a/hw/misc/unimp.c=0A=
+++ b/hw/misc/unimp.c=0A=
@@ -96,3 +96,23 @@ static void unimp_register_types(void)=0A=
 }=0A=
 =0A=
 type_init(unimp_register_types)=0A=
+=0A=
+void create_unimplemented_devices(Object *parentobj, MemoryRegion *contain=
er,=0A=
+                                  const UnimplementedDeviceConfig *devconf=
igs)=0A=
+{=0A=
+    const UnimplementedDeviceConfig *cfg;=0A=
+=0A=
+    for (cfg =3D devconfigs; cfg->qom_name; cfg++) {=0A=
+        DeviceState *dev =3D qdev_new(TYPE_UNIMPLEMENTED_DEVICE);=0A=
+        SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);=0A=
+=0A=
+        object_property_add_child(parentobj, cfg->qom_name, OBJECT(dev));=
=0A=
+        qdev_prop_set_string(dev, "name", cfg->region_name);=0A=
+        qdev_prop_set_uint64(dev, "size", cfg->size);=0A=
+        sysbus_realize_and_unref(sbd, &error_fatal);=0A=
+=0A=
+        memory_region_add_subregion_overlap(container, cfg->offset,=0A=
+                                            sysbus_mmio_get_region(sbd, 0)=
,=0A=
+                                            cfg->priority);=0A=
+    }=0A=
+}=0A=
-- =0A=
2.53.0=0A=

