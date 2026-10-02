Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E743CA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 13:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCcuk-000138-Ms; Fri, 02 Oct 2026 09:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuH-0000oe-Jj
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:33 -0400
Received: from mail-francecentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c20a::7] helo=PA4PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1xCcuF-0007Rf-Lo
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 09:02:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey7f44jo/54JSbAk2yPHmFIFGNTP3ZV0wVOg3jt1vd7yzj7RGugwedGSsISZa6y1Tpp0UBwyJggke4BX3eYFoTYe6DFy1uNXzVS3gLtVwdgNT6c4o8IiLOVIvhNP9MwUWrJnZ4+K6AefR3nwX0J6/aKakdXu40gpObCcwO40yz424xWDiNs1i0+lLbkcLwDhB6zVd8I/43TR0LV5y0eeEdBnATxYBGkoMoYwUjLE+fdQpAlEHMfYvIkfB0IGSMUvnN/P7EwJ3PnE/seYzmhfQN69fWo/N9B2uipcKXkKG2Txh/SVWn+bZ1oSjuHeTPcuo2yXfq1MyhS+bGSB5YoN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=u3tLDQ2s4pIb3tPPaGS3kl822H7tsWNUu0O9xhlHWSg3/YCmdJk4N7b8CzvsBIkSSwfR4pGL4BsZQqzQ6nak1U5n70+jHCW5sFCwiMEdpcUa6s+Q568b4gd1OOxoKh4s7ua9Sg2VugINENttf7E6pH7sultRa/PwGDGLC03ByOX9hsC40lA26+BumjsLoQV6i3Ol94IV0kZj2+AlMqXwE2MlAWsZv1JHDuVNYo+ydQgN4BoXqKLpGAdCDf1jkYQkwBRx7EhqKrDioRto8chSLq0BoJObbg8RZiVZnqwwV5C+59Pk1PxgyWrWSk0GrdgC1xb7qUtGaBI0m4pT2dxeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExIQu0ecC+MilHqTTHG4T+cwdoW/u9j+e/13UOC8evk=;
 b=q7k9OQjEnq97KHevX8fGDxUkovH3e7Q0GGJRkTRHGK1+u14UAfwcq135Sj28wkUxYnLEr/WTd62aSfBz2d/eRNjA7gmm1QoG1TquAIYmC9sLL5+J5jMWWR23Ua6+CzPyEZIspE5wPV/+DVLlxGatsEwnO6GGhVW8Huwq3f4OUB4kGawKqOrfIXiVkaR+OwNNHRbM/MPB4Xh9Qo7TEP0pP1cZbfW+ufMtbmrlfx8f0JGhxe8W0fUd/0Oi4Y7HS9LGSCizYTWYZ7MntkI745kbSC7kJdB6zxbyyP9eD+E65KV7sn2jCZ/h0+Ixjtj+EhBMhsZP6KdAo+BNJw1ssI6L+Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AMCPR08MB11995.eurprd08.prod.outlook.com
 (2603:10a6:20b:76f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 13:02:27 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::4e37:b189:ddcd:3dd8%7]) with mapi id 15.21.0472.012; Fri, 2 Oct 2026
 13:02:27 +0000
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Date: Fri, 02 Oct 2026 16:02:19 +0300
Subject: [PATCH v11 10/19] vhost-vsock: preserve vhost FD during CPR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-up-vsock-vhost-v5-v11-10-18fa09d8273d@virtuozzo.com>
References: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
In-Reply-To: <20261002-up-vsock-vhost-v5-v11-0-18fa09d8273d@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de, andrey.drobyshev@virtuozzo.com, bchaney@akamai.com, 
 dongli.zhang@oracle.com, vsementsov@yandex-team.ru, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dwmw2@infradead.org, 
 mark.kanda@oracle.com, sgarzare@redhat.com, den@openvz.org, 
 odaki@rsg.ci.i.u-tokyo.ac.jp, peterx@redhat.com, clg@redhat.com
X-Mailer: b4 0.16.0
X-ClientProxiedBy: VIUP296CA0042.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AMCPR08MB11995:EE_
X-MS-Office365-Filtering-Correlation-Id: 055025da-e6b5-48eb-f307-08df208568f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|52116014|7416014|376014|18002099003|22082099003|38350700014|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7xDvYJBAGXzBXoj625vw6OMxlOhxu/v4/lhLQX/FtpY2yASqfMiUuvQTSFXkGJKz8YXx6kyqoD2Dgclp/deVywDzK3DiSePZGi5tIuyBH3Ds9sja4gCN1kNY6sk5tf8gKIjSszzlmblimuo3OVVPBZfFGqAZobyp6e/Ky7WrWZ8dF3e0eQfx8oGM8Q0Ah4CRoTwowD3iMbMdiyLNQBdLgwBillLBtrB8LB1vcLyuY2hcrMriMZZTwouRZMD2Lt+4m71R2CdU/hF5Xxn0T0HlrSM7p6tptvKXNlwgCgdizUB75HXa70FqkkxR/ZM6wSUM8mwMRollVQXAjxBab0RkxJLHiGJB4ax3FmawM4hzQG7ALlHft1WY76L8ufCXKQ1u3PguZi9+uPEssHAFXipeGfnpG1vF/y+2KgNTlOX3ySjJ4AWCDSNJVagBCDSjLm1DhADNS1KAed1DMXlMaGa+XKAfh/CRSZq70yq7OwBgalRv91Q5FS8hEwfHmWqsVSI4nX+s9clYhK4z2tPJW8W2j2W9e2KAsb2/O925iWo/rthI5rMoxaQV2eeu0pqvhri87EG5IwoIwmwe1vkrZcY9ll3rV2D4ejNeDq1wJ1F8h11dAZXmRS22WCLsZCa3z4ae9lPYRw6jKqMKenlzb0ilGVIvNMDGW3FfOSm+5cHXUz6mfv2PEbBAYLpDn4QSQEa7WmXoan3M0zBUBwLF8SbkCp69Lx+OgS7pe59Qy25GBhI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(7416014)(376014)(18002099003)(22082099003)(38350700014)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dBbGNwVHpnT3QwRmRXZDB0dlVFaHJzV1liTDRBSzlSM1V6bGwrNER5WnI3?=
 =?utf-8?B?Z2lraXV6b0dhV1Q2a2g2aEZwRTc5S3gydTVpWFVyTm5lVDRXaFdveE1pQkxT?=
 =?utf-8?B?RUtqcnhiZ25vc21tbnFhK1V2bjVkb05EMVZZMGREZmRld0VGL1JoTTdzdjgv?=
 =?utf-8?B?TVBoaGp5aCtEekpCbnQ5OHUrMzJiZGgvRFVUVHRvN1VWVXY4Y2ZmY0hNUXg0?=
 =?utf-8?B?UTVmb3AzS0VEbUJtbEM0cyt4MGp2NExMR1ZUT2ZHblhGcDR6S3B4S3cvaDJR?=
 =?utf-8?B?aWI3Wk1meE1hUHZ5aHJ2N0xHbmFsbFFQYUNQZmdLUHUzMlAyMVZSa1hJT3Y0?=
 =?utf-8?B?SmFpQXlidER1b1k2ZDJ5K2dmM2hHckV4WjA2cU92KzZNbE1oeHNBc1ZxUElW?=
 =?utf-8?B?OTVlM1ZrNS9pUkFJQU5tcmVHSDBHUzhPNWpSelg5M0JIVFJrYUdONi9jbmtC?=
 =?utf-8?B?SC9DWGpORkFxbzk4OXQ3ek5JWFIzWWMxUmcxWGdoZmFIc3VVMEh0RFY2bytN?=
 =?utf-8?B?d1hvam5SMENHNERjclJCY2ZKWWpBYnJ5U2N6S1dPVWt1Tzh6ZndPMlpvbVRE?=
 =?utf-8?B?elhWckI1Ulp1bEM1NDNhSmFCbUwxaSsvcXg2d3k4U3V3OWRSODBqeGU4ZXpv?=
 =?utf-8?B?aFVrNDJRUWxzZFhULzVrNnRpU2I3RDVtMkxBYy9udTQrVHVNa2tvNm9NSExF?=
 =?utf-8?B?TjV4NmcwZDVwZmVBN0J5NFMvOGdySndHaXkyTWNrbExqMlYwU3ZmREtUdGpP?=
 =?utf-8?B?YUQvZDFqcXY2TXdCRnhnYVg1VEtFQkhaeTNFRU5PKzdJemdoT2E0Nmh3TmFU?=
 =?utf-8?B?ZHpKcWx6WWt2NDA3RXh1RWt1Uk9JOVVHVDFvYXRKQlFObGV2S2VVVThuVmw2?=
 =?utf-8?B?V1hBU3prU3FLa24xVEI3SVBYTFVVZ3lSSkVWU0NwQ2hhdGxwTURuVm4yRjdk?=
 =?utf-8?B?RGJ3bkRONytLTFM0dGFLajRuZ2JBajdZd1Z5K28zbmZUbWZWcERnano0Tk54?=
 =?utf-8?B?OFZCL29JeWFOWWJRcXdoVmxtdlBic0JqYVZPa3dQdlplZGxJVGtxdm44d0tE?=
 =?utf-8?B?c2tYTXhyV3dNNitqWHdaYTN6UnYwRXhkOHFKOFU5Q0p6V1p0c3Z0TTVLRm5i?=
 =?utf-8?B?UmhkUkNzOWluR3BxdThtTVBsazVvcEZVRGc1Q2ZkdVBYK1BWOHdGdC9JRWph?=
 =?utf-8?B?Y3FUaUdRblBjcnROS2NOSWJ1QXJGQ2g1MnQ1REExMGdUc2F1cGJ0TlR0L0tq?=
 =?utf-8?B?OGFsbXdFWDhRazVYOWgrU1RhUStnamdvcDNzS0lIakVZRFRPVFlZbUFFcEUw?=
 =?utf-8?B?cDVSWjNyaWx5QjB2Wkg5NmgvWk1uVUVCMEFWTlJ5VkIwTFdyemdtQXBHQnlW?=
 =?utf-8?B?TlMrL2hBcll0Ty8xM1RrV2x2WGY1aUVTWHdSRWlSYVlubXhuQW12RzNVbU5i?=
 =?utf-8?B?djNaZ0JZZktPZ1J1MnVtenFYbFRoT052anI5S1dIWFhUckcrL3hka2krejhY?=
 =?utf-8?B?YkhKMmVESFhjVU5nMG5OMlk2RE92UTJEb3ZGUWNCT3hiZldxTzRnUThZLy9R?=
 =?utf-8?B?eU9HWVF1L3pBb1FUTXRyUk40Y3R3YmxLcVRzSlpyZXFTdngwSU1mUFU5WGFt?=
 =?utf-8?B?eEVWZFV1Q29nVHd0QnZUZEJmQVNPOXVLdmNIK1gyT2xZRlFrd0g5UTJ3SGRr?=
 =?utf-8?B?MkcraWJ4RnFleXZnek1nSVUyZEF5ejZhV3JkR2N4b2JDSmdlTTFibGVCY21M?=
 =?utf-8?B?b2lOaGVuRldmZzFVTUNMOFA3YlA2V0pRRkovUlZGVi9leWdseDZ6VTBIeDND?=
 =?utf-8?B?bWVVZjVIbFAvREtaT0ZNam5ZYVRBQXZ3Y1ZqSXNuMkZNbWRpTkhKVmtCMHVz?=
 =?utf-8?B?SFY4VjJhTGdMVmoxalY5SWFXeUZ6UXBlQyszZW9CUGRCeUxnTTZGbFZwZ0M0?=
 =?utf-8?B?NytjWko5QW9LU3A3SmVubUwwblZ6aW0rZzJhT2I0bjlJMGpSNUZCL004d3E3?=
 =?utf-8?B?aldjR3diempad29qZCtheUNYbE5mYmh4ck9hYjFEZkhlbjVNLzFSMGVUYTYz?=
 =?utf-8?B?QUo1KzRUMktVOGYwdGtSZU14T2hhRy9MVVl0RGk0RGpqNDhsbUNpUk5PY2wx?=
 =?utf-8?B?a3d6aEpnLzNjL3Q5R05SNUNRNWhJV1dlRlFkRk02RXByajJkRCtHMGVIVUto?=
 =?utf-8?B?ak5HSkZpQ0JQUEt3bUY3WmhrK2R3Zk9FS3BMb3ZLYytjdVJEM0VVVTdxUzFz?=
 =?utf-8?B?NHFnQ09BNDRrMHdOUlRPSE1PVU9Ocmk0UTVlVUF2K2hLUDVJdmZHVllYdlRO?=
 =?utf-8?B?a0JhMkZ2RnNXb0s4QytSclMyeHNEL2pjQTh0WEtQZGtTYlQzdFV3ektHSE9G?=
 =?utf-8?Q?9pEEiqkXAJwKY5nk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055025da-e6b5-48eb-f307-08df208568f4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 13:02:27.4864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXaSENuZhApDBRXYlmUfrtqE9gAbfrN44dKK7uYyLT46zIyK/VfuzI/E9HILrBxaEUn8s3Ng2VXsnnVeegkTSA4t4O9KvP4kZGJCrf4+B/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMCPR08MB11995
Received-SPF: pass client-ip=2a01:111:f403:c20a::7;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=PA4PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

During CPR (checkpoint-restore) migration the guest keeps running on the
same host, so instead of reopening /dev/vhost-vsock on the destination,
we should reuse the FD from the source.  The FD is saved in the CPR
namespace (hash table) with cpr_save_fd() and then reclaimed on the
target via cpr_find_fd().

Use the (suffixed) device path as the key in CPR hash table.  Device
path is obtained with qdev_get_dev_path() and is essentially the
device's address on the underlying bus.  As any vhost-vsock device is
attached to a virtio bus, whose .get_dev_path() forwards to the proxy
device, and every proxy bus (PCI, MMIO, CCW) implements it, we should
always be getting a unique non-empty path with qdev_get_dev_path().

vhost_dev_init() (and thus VHOST_SET_OWNER) still runs in realize() here.
Deferring the ownership handoff to pre_save/post_load is done in a
following patch.  Until then CPR remains blocked, so the restore path
added here is not reachable yet.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 hw/virtio/vhost-vsock.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock.c b/hw/virtio/vhost-vsock.c
index 3ec20d87606..6e89007b2ce 100644
--- a/hw/virtio/vhost-vsock.c
+++ b/hw/virtio/vhost-vsock.c
@@ -69,6 +69,18 @@ static int vhost_vsock_set_running(VirtIODevice *vdev, int start)
     return 0;
 }
 
+/*
+ * Any vhost-vsock device is attached to a virtio bus, whose .get_dev_path()
+ * forwards to the proxy device, and every proxy bus (PCI, MMIO, CCW)
+ * implements it.  Thus qdev_get_dev_path() always returns a non-empty string,
+ * which guarantees us a unique CPR name.
+ */
+static char *vhost_vsock_cpr_name(DeviceState *dev)
+{
+    g_autofree char *path = qdev_get_dev_path(dev);
+    g_assert(path && path[0]);
+    return g_strdup_printf("%s/vhost-vsock", path);
+}
 
 static int vhost_vsock_set_status(VirtIODevice *vdev, uint8_t status)
 {
@@ -143,6 +155,8 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
+    bool cpr_incoming = cpr_is_incoming();
     int vhostfd;
     int ret;
 
@@ -170,7 +184,14 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (vsock->conf.vhostfd) {
+    if (cpr_incoming) {
+        /* Reuse the fd handed over from the source QEMU */
+        vhostfd = cpr_find_fd(cpr_name, 0);
+        if (vhostfd < 0) {
+            error_setg(errp, "vhost-vsock: could not find restored vhost FD");
+            goto err_blocker;
+        }
+    } else if (vsock->conf.vhostfd) {
         vhostfd = monitor_fd_param(monitor_cur(), vsock->conf.vhostfd, errp);
         if (vhostfd == -1) {
             error_prepend(errp, "vhost-vsock: unable to parse vhostfd: ");
@@ -186,6 +207,9 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
 
     if (!qemu_set_blocking(vhostfd, false, errp)) {
         close(vhostfd);
+        if (cpr_incoming) {
+            cpr_delete_fd(cpr_name, 0);
+        }
         goto err_blocker;
     }
 
@@ -207,11 +231,20 @@ static void vhost_vsock_device_realize(DeviceState *dev, Error **errp)
         goto err_vhost_dev;
     }
 
+    /* Register the fd for a future CPR after a fully successful realize */
+    if (!cpr_incoming && !cpr_save_fd(cpr_name, 0, vhostfd, errp)) {
+        goto err_vhost_dev;
+    }
+
     return;
 
 err_vhost_dev:
     /* vhost_dev_cleanup() closes the vhostfd passed to vhost_dev_init() */
     vhost_dev_cleanup(&vvc->vhost_dev);
+    if (cpr_incoming) {
+        /* The fd came from cpr_find_fd() and is closed now, drop the entry */
+        cpr_delete_fd(cpr_name, 0);
+    }
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
 err_blocker:
@@ -223,10 +256,12 @@ static void vhost_vsock_device_unrealize(DeviceState *dev)
     VHostVSockCommon *vvc = VHOST_VSOCK_COMMON(dev);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VHostVSock *vsock = VHOST_VSOCK(dev);
+    g_autofree char *cpr_name = vhost_vsock_cpr_name(dev);
 
     /* This will stop vhost backend if appropriate. */
     vhost_vsock_set_status(vdev, 0);
 
+    cpr_delete_fd(cpr_name, 0);
     migrate_del_blocker(&vsock->migration_blocker);
     vhost_dev_cleanup(&vvc->vhost_dev);
     vhost_vsock_common_unrealize(vdev);

-- 
2.47.1


