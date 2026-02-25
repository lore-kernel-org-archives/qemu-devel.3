Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6381DF357D5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 10:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvC1B-0004L6-Rz; Wed, 25 Feb 2026 05:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0d-000411-5P; Wed, 25 Feb 2026 05:20:47 -0500
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1vvC0b-0002vM-Ek; Wed, 25 Feb 2026 05:20:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8/XsJJtJ/uBRzp4oYoS6vNUdVyzPMBe7aEM/WYL2Bpe4Qsas+9HVI+/oTUZ3iV3VNHKTe8zFOwzhQh/xYjbU4aNSRf6mMeTSwwiFG/qE+md459hKkOoTL4PmwuMVBKRSVcfmGJvTIJS4KZhYZ9/HxbaEmQ/KLlrdsJELpsGAl211xlDBi6WKMrfyJ1bzIMxZ7FPg0oG/MCE7OwU4b3TPxYEGGhorpSqdHWQl5fbK9VtOobWrZjyG18Bf2f1dAL9lig44v670Z5e6YJfmt9FaYG66e+W6m77HGOtsEVjSg/iOSGaspPp1y9ZBGp4byJfZPll3YidpCDJ0AXeJsgP1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znFZQxbJHrud6ZUejtmT4IeVUSlIskoYzfelS3UImS4=;
 b=o7bh60BaP6KP7tnjh+9+jdsuY2CkJpwmVRldeTZjK6j0I+FBQCR1UpMyWpnw8gILQXF+JJdgj2ydqzn5AQRBppPhc3Lvv9FtHmexY+j9krzBi3fF9UV/18t7l7f/ESv+KrdJllXgOldAFwUu9h6U+DM2DqAk0Bm0M4eUYzMi9Iqgvhzh1Iz04ti/78uZTL5+Myn3YY71mwzJwVo0EIy9jzDidDNukQXq++2J5nRHicSjRUP6cb3iHwdjQYjJJ1YZC4Nlqx/k6IL1lWMYii+ebqiGXi+UdsQjaDVTet+0c0HK37KWWUwIhDboVLp0JJ7z4rPFns1P11QJxIUIivurmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znFZQxbJHrud6ZUejtmT4IeVUSlIskoYzfelS3UImS4=;
 b=Wj49olVgTPBweN/0Z6elPxL7Eiu3lWT8jh+Xo//ZzLd0+hZ+0w8QT5cdoP2X1b0Sx7TjGqNrEIfrMF4ALWXuMFM0VkxfrBzU3C8M/2GS1X6vRFAcffkglQmcw3j8oliqfsDYTvw5zcI+OApK3MgcVPy/O7vQSI3q6mWSVSjIimfslMTKjDUKQ5bj5mdn/hpMmw4xbF/wGz7tz17hjt5i/Xm2KSY3Cw9ZjNyAUhzV5DxiXZO1B8x1M+8K8lnVUaD5ANT79qXUg+UyS7574EJxChUG/L+9o86wU4COzkejk37BRjxrhPjFG3LNLd22jSsw1KuQ7aQhDmZNGdCmgUydJg==
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com (2603:10a6:150:358::6)
 by GVXPR09MB6845.eurprd09.prod.outlook.com (2603:10a6:150:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Wed, 25 Feb
 2026 10:20:31 +0000
Received: from GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63]) by GV2PR09MB8755.eurprd09.prod.outlook.com
 ([fe80::939c:95df:4890:ce63%3]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 10:20:31 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v2 15/16] hw/virtio: Use DEVICE_LITTLE_ENDIAN for virtio-mmio
 legacy ops
Thread-Topic: [PATCH v2 15/16] hw/virtio: Use DEVICE_LITTLE_ENDIAN for
 virtio-mmio legacy ops
Thread-Index: AQHcpkBdc2KV82CMr0yIVNvOa7oNhw==
Date: Wed, 25 Feb 2026 10:20:29 +0000
Message-ID: <20260225102016.200654-16-djordje.todorovic@htecgroup.com>
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR09MB8755:EE_|GVXPR09MB6845:EE_
x-ms-office365-filtering-correlation-id: ceec2a43-13e6-413a-2365-08de745781a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 8ewAID9Yj9IzVBUDsqggIuuZbpNCpVTESwWgsfgVF6TFxl0yXRu7bd+vLU8jQnWsYnMMiB+wSpQss11/yAx466JCfS9hKVufHjU0fEB9A3d4yEuuvGr8pGvZkcp7UaccFgAt/dhhjhjfyKOZdmUoiwBo6ni9ZQIE+JpVraACK0g2DNeUb0x3PB/lZnK6gc+FteN6Qh2/kRxZUh6hMiZyZk3zCLH/MElIRNuMjnXi86r8C+YguhqvImqJjsS8faciZTSTPLkcGEMhX+WNWccA1oPe54YQf81kjneZME48wQe+MWNox2EbTBVv/HWTb5zpYT69qAAy4vk+Q9hegmJOCsAfR3D6Fjg71GNFcyHptFU2eZgMz3W5/Cy4NmdQVbPVGxtDZ8vcPfan7jb4dcYXb1K3PkisSpCVthjqLChVmILKFojmKbOVeubvdS50QcaO+Ls1oFupl9rBCiEYRgV422kEDXj9fl9AG94qQ/kSfglFrF4kNcE1ErUB4ElJ3I/WdsuH7JFYjb0eorlro1u2r6al7teWLNaTt0Fw0kUd4p7CuXOm0Zxhs5ASfnTLP53pMH254h7N1oOl5J3cPN+hc6Q2XTsp8+MZEtIER0wUCIIReBKV265JtK5/oq/qjTEkDig/MrFvEARQuVCNPCuXAMWWvo20Kw+OClJXQJZZEo7lBxatIQIBwAXX6PsBI/0UFbUy9wTw8n1NOluU9WEs4schVCBT4eRdm2KMHMTYXn/DkOA4/OsUD3wJVQ34hct2TfXO/yl9D9JbVar5b7uhvFeSAI8eLxrfl/xQ0E1eoV0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR09MB8755.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JBnzc6ndQ+8eN0YjfLe7XOzvEnx6vv7ZIT+awLdTMG7RWbZTP7CusUuZUz?=
 =?iso-8859-1?Q?QgZGfIjsIVEuuJH0G6VbnrFfiZrC1qYqw19sNtVVdWcM3i9DQ5hwqRVZ8V?=
 =?iso-8859-1?Q?NnhHoWrOpitCN4RnMsbEJWXOAL6vDTktCp6+g76YPXKZBnNhQK1+G+WDCN?=
 =?iso-8859-1?Q?VD0zj+QUjSjtg9sE2gMH57JaFvAzmAobvezPfdzzXre6QqB5tk68FW+NV9?=
 =?iso-8859-1?Q?i5zOGCV4lSerHuYuGzyExc7R0qhpa0myWUZGiJk+fHNY30DSuzkEjCuWCb?=
 =?iso-8859-1?Q?CwBAwMEPJU/a4rSiMG2ernhApBKgzhKBasaEt/oAfexcdn6iGZAYS4n23i?=
 =?iso-8859-1?Q?MUZuAghEMqu4JTQv1m8cyG6SZ98oclipaaLzz2Cyt6PNmhGJim2dUbUD7y?=
 =?iso-8859-1?Q?ecZD8RDku1YYU9Q+A2fI8miEA47M36xuzI/Ub6HV8SamBicLvrY7BhzYcK?=
 =?iso-8859-1?Q?FfKWCfC+y8ismjRXCR5jTsNKiYfbUnrYVb5Trgy7OfcM9OGYi2RetY0huh?=
 =?iso-8859-1?Q?/Bb1QnsVWVuF4ui4SZVQnMDsB28fm7mkkUo4Om3meMDj6gtU6luUhou3ON?=
 =?iso-8859-1?Q?baytUz2jKsYOFGPclF/xL5rmjEmr42ted+nJjcuXixMTI7MekHgZZa6vdf?=
 =?iso-8859-1?Q?3n6PrXMjHwOU0z06nzgk6SjSfKzV0m1xNMnQWCn71bOPTibAi7mYGOTwUC?=
 =?iso-8859-1?Q?b0VG2niDfouQrDpLdUU94yz038Hb2xz/b9oRmLbf+0DMJOvbPas9/s0QrD?=
 =?iso-8859-1?Q?PtkV9wbGFlRgqwkq+NfPyQmN9eLDtTcleeV2MDB4+PCHbT+EHa+gPL87P6?=
 =?iso-8859-1?Q?jYFOVdYMfNsGe1GShedl56EX9BAf8qQeEUmGwWb7Wei44LSi1PSqsmYNOS?=
 =?iso-8859-1?Q?VlVSX5YEDZiG+3rp/8aoS1qfBaSnaAOBwPAirqzO/LeKykLqcgrzfy4pfd?=
 =?iso-8859-1?Q?cY393GFZos+JmgIVjecCTcjd6vRgqQZIQY0sKd1ePbXrkpqVAb+qfjdZ0L?=
 =?iso-8859-1?Q?HoJAMH3ETU3kiI+ulMINKjutOsNIKqwtWFRsnZrmDYQjN1H6SBPmSgFV1B?=
 =?iso-8859-1?Q?KwttBVhvABaU6oAkp2Z8YonM6fVnTfYPaX9BnLD/kM9v/F6TzMxks9tKkt?=
 =?iso-8859-1?Q?HOafWHfyVt8dISzXJOLTyITreO5f93ZfMJvo136wqJzeXMzVybe49MdfJA?=
 =?iso-8859-1?Q?zZcn673d6rkLCcU8ciFGDhF0vWS6wx7R31ssGyOJPudmsBJ7ssD50O+BV5?=
 =?iso-8859-1?Q?VWLZ/lcP0d/CESiEMFKKwHazUt2O84HKEepJ0mgYzG4VvYS5gXuqB8yDgd?=
 =?iso-8859-1?Q?KHJ5t9Y/cH58ZS4PBGzFtUhH7HwrtQFqP5D/u1vT4jBdWkFJdMwDxcpX+6?=
 =?iso-8859-1?Q?039Z3u+Ni7ni68zf1B0v1Q84hIuWCAn4YoQ6fUf7qbuYHhSRoHF6Mp+lWg?=
 =?iso-8859-1?Q?RG2QnhM7DPqpujb+gh2PNQ1ZKCAK9TmOd7Y3zAwO+Y7nVie1nmXjbGD3QB?=
 =?iso-8859-1?Q?AzqTptShvOBhbZIjXPTCJh2Rz2RJgbG7K64uACb33sat+2CfVklWQ3sQpZ?=
 =?iso-8859-1?Q?9+o+rXGeiAPsXkmV10nz2s76JV44kRuhB+iC1nupGqXgF+aOGjHa4db9SG?=
 =?iso-8859-1?Q?ZNHKina+1raFHc9xoFZL3Xg7ljdo5Ugd5aRlNI6zE70rFW8Sj0CNVuamLC?=
 =?iso-8859-1?Q?KWmsTpbhgWSxul+fFSeiUxiS0CqITPJSUhVrqgA3z7epiyEOD0SnP+Po4s?=
 =?iso-8859-1?Q?Os7/52Mk4rszPJyYyQA6jpdpOpZkt1zYH5gkqrZqElFtIWUT0PYzLN0QA9?=
 =?iso-8859-1?Q?T0Qp/M1xM8kbPuJUYdlDoOyK81kpQG7USBBu9KeZye6km4cbFR7O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR09MB8755.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceec2a43-13e6-413a-2365-08de745781a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2026 10:20:29.7035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkTtAfJRhK4tMi7d+XzsKThhyNCfa1fbnHX2KqH3pJ1mOkoi/7Yq94MQMnYhcqSJgpKxNMQWXlyifEhHCoDBaaNgmc/GF/aWv5GM/XMf1VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR09MB6845
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
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

From: djtodoro <djordje.todorovic@htecgroup.com>

The virtio-mmio transport registers are always little-endian per spec.
DEVICE_NATIVE_ENDIAN caused a double byte-swap on BE targets, making
the kernel see a swapped magic value.
---
 hw/virtio/virtio-mmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 0b0412b22f..92ff793d2c 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -527,7 +527,7 @@ static void virtio_mmio_write(void *opaque, hwaddr offs=
et, uint64_t value,
 static const MemoryRegionOps virtio_legacy_mem_ops =3D {
     .read =3D virtio_mmio_read,
     .write =3D virtio_mmio_write,
-    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
 };
=20
 static const MemoryRegionOps virtio_mem_ops =3D {
--=20
2.34.1

