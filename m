Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8558FD1D878
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 07:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vR3w4-0001e4-FU; Thu, 04 Dec 2025 02:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR3w2-0001dw-8h
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:39:30 -0500
Received: from mail-japaneastazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c405::5] helo=TYPPR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafer@jaguarmicro.com>)
 id 1vR3vx-0006PV-SR
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 02:39:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee/SeC8WqnT7AL6X3P+DbZjgoXzSA0RqVIZp8mCEOrzvqZAyUFxghGoLI48Lg3Nfcx5Wh47wdH0QFxCXCHEanhHbnmBGF41PIaamFFn44ylnACcTsq0cCqS9Xohd34t95DwwWylYJugwerslrSqJ6K6lyhtUNe2ZlaYyADzrr/7wuMMhwBZKUMC3WCruDnoa109gXJuImDvi5UgpmYj2P3YscJ7zpE4u4d1ASbbRIVs2EwNY3FkvBmcJB+CJesLFyt4HKXVt7VcW7p+yeSYlYoGnc6cp6B3gVdeQXMkiY8YbbMJAkpsJaDE1jtC3cKrt774HK9tZdiniWcH0i+99Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZeqaSZSmI0foc/PVHb9Eofx9EVRYY5KviSIxr0seYk=;
 b=CQNHBMEpFO9Fi0JyMBF+qLncoHpou4xLpxq0hxoV6DF3pd731UZ3O0Df3iyBapcEXA0YKGCTDrmf8Gy+1KgQhI4awJt6lzC8n603PNP6L3XeyFC3aHQf4kJlas8nmcZ6RUSfnxP6M2sOBBgIj7/51RNESojLlCLVbeFnXZWt/v6KtMNr4fFXWI4r+IKiLxlYpSh0db3wIOGwPb9x84pXTdswPnyD8+NoQBYJ4NoIqUX/+V7SPd1DXYnIORl7MIPL5TjXVwNOZz760gAzVWojRDHr5MDEKao2WFpbTsQIFhWnB6OLIRUq8I/UBYcsIJc45SzzntOtTwOC3vQ0yQqiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZeqaSZSmI0foc/PVHb9Eofx9EVRYY5KviSIxr0seYk=;
 b=e2EtHLgBNtg2cbi2MC2ocyfwASNhInOqVOf8xSXKg8cWpo+E8SSnkACNNX5F5EmeiluVJLRXV7aAEku16oJxYPUS6+vqvMWXhjuvoZu4GWXHxmY2zZDnsGtrgQkNglGcNiCpnIzGKlQyDIpbvVnQAycoY4+Wj4qcLQRRG/ILPSAcENgARb8Hlz5knhYos3Z11Zj+pVPfMusCZTFj785Efosk6uNtFLbkG+lvbNJF24ghLy7Imd//t5rlry/dlIhmvJVYkQWIY09hBUSbOAafn2tQHAjKYn2j5lDg0MvsQZY5nPFmm79/Vmri1UcBxHgP7xKB05wWdnYbmyzobWZQAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com (2603:1096:301:b4::10)
 by KU2PPFDF24F4212.apcprd06.prod.outlook.com (2603:1096:d18::4b0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 07:38:55 +0000
Received: from PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66]) by PUZPR06MB4713.apcprd06.prod.outlook.com
 ([fe80::1b36:28b0:4e5:de66%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 07:38:55 +0000
From: Wafer Xie <wafer@jaguarmicro.com>
To: mst@redhat.com, eperezma@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
Cc: leiyang@redhat.com, sgarzare@redhat.com, angus.chen@jaguarmicro.com,
 wafer@jaguarmicro.com
Subject: [PATCH 3/4] vhost: supported the virtio indirect desc of available
 ring
Date: Thu,  4 Dec 2025 15:37:49 +0800
Message-Id: <20251204073750.8953-4-wafer@jaguarmicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251204073750.8953-1-wafer@jaguarmicro.com>
References: <20251204073750.8953-1-wafer@jaguarmicro.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0035.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::7)
 To PUZPR06MB4713.apcprd06.prod.outlook.com
 (2603:1096:301:b4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4713:EE_|KU2PPFDF24F4212:EE_
X-MS-Office365-Filtering-Correlation-Id: 22dd23a6-3add-49e8-fbe8-08de33082d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?o+TjTRbBGs9adeHW2zDFPwqiWo9+U3m4dJ9z2npas/kkn6if01634gQxLNMI?=
 =?us-ascii?Q?MWDL5n7t5a8MCpiTUX51VzgMc18JKOfusqYq/IuLFaSgnuQZS2Vmj9y63RIx?=
 =?us-ascii?Q?iksvVu3j+O5JbIFpalOB2a0vtPtuFcJRkIvHUbr8gtWPAMOWqA4zUWdYsbte?=
 =?us-ascii?Q?ViCG/cqJ3oG7Hae4nsMtuAeJZBkI9iJN84p0qVVKKXWBmybZwBJhal6AlNS8?=
 =?us-ascii?Q?ZZky8DGq59xqmEkh0BxfC4t5oU00kceCt6O7yKaoBKu5O26nxA+PUMW9LJi2?=
 =?us-ascii?Q?Y+qAWWtQ3C839BYVe7WmbMZOTMHASWtExnPJOfaYq65TlIJLrUnHomsBM+d6?=
 =?us-ascii?Q?WGeLg5FhkBwFbAAIVunUJxNg7H4a4nomDFwz1Mrx/95fHkb/m23pniyJrjmV?=
 =?us-ascii?Q?76A9aSeA8LUCoVB/BdocWMz54jjdt7OoIcqGgB3ifA6ye/CXyALbz1tjBUK5?=
 =?us-ascii?Q?NAKjl2xrzLHuNXwm0B5/mhxFMVkRQS2Eu0DqQskklcSsIs2BTPMwN2oG+Cql?=
 =?us-ascii?Q?lw0ixjtIVfa6lIqZHdxV09iccWD9r94pQCsAvdAIEgZ2g/D0QmPFly2kFJPY?=
 =?us-ascii?Q?v7d0lMicF8DI5H/ofD1OCDWqLx2SRbEUkEh0KjnXCPt6216QBfGmaFwnhlc5?=
 =?us-ascii?Q?v0bkRUoKdRtMSFu0NFDRAzf97H6za2asccYND82ikN9lSjYKWXe/g0HxBO2I?=
 =?us-ascii?Q?Ne/p26UcVKTs7zEYX9GtL32vAKRbTv2pGZbmJaBXY8STtk1tLrlawIRkRigi?=
 =?us-ascii?Q?z98Vr98URHWWaw1LTPYZ0hYPXYTJOHiyRWGV4FIB6QoqcB4CuMaN81lBunbS?=
 =?us-ascii?Q?8Uu0vLiWtgLJfOgq/hOtfCfVTJMqQLF4pooANvqZ0y3TfMbF7Nyw+NVqKaOS?=
 =?us-ascii?Q?BQDM9QYkqRr+rvqO5ccvVtxHC6ipX2t6kT33P0Wv0fPHViRkw6zuih/J62bx?=
 =?us-ascii?Q?VcvAPqR88cpjYuNRNvvznTB/8lREVmLnpmC/UqddBeh35ykjbOPBTLsFTfEo?=
 =?us-ascii?Q?8ap8H+6uRsNynvbMjCTSd3dGLB7ySurpMBq8dSeyB8PPT7rT3M3XPJek1CC0?=
 =?us-ascii?Q?X25cIlsl5MEwqeb5J6a2qcuk4PrjOkKANZZqxol+VOr83e05CrfoiP+F/bBd?=
 =?us-ascii?Q?iKDTtUQPvSjgHEHXJSY3zShbFsoQmcYMgu8hUT31LatTDOrHhQ+Yj/TxIZGz?=
 =?us-ascii?Q?0LNyxQwWL3vOk7oCnLSY7OC30YDXZ/imK6pD2Tt9bE3+jLYaEjioOh9L+hHo?=
 =?us-ascii?Q?MYKTbsjiUVKQkT9QPrtH1vwAhZfatMFE4d+Do0PSHoDfnFIaRhDlN3ZRgr+k?=
 =?us-ascii?Q?eke+KyPNwtkOJClvwSqLYoJiiKqvNjGek70EPcS80wpOC2Gtcb9dO+B4/ykV?=
 =?us-ascii?Q?jue57QAdXgFaLuzCCmMJhZ8plis7OzcKAhof3nG/p6Wr9z8QQGMPc5k+t94r?=
 =?us-ascii?Q?ARkIjwobVVLgnSNeAARjDdMIpeuHbTdjgJEKrBsTEVHeVakObndasGHq/EIr?=
 =?us-ascii?Q?XvkemfeiMAKInK1nqHmxFg+75uId7tUsiV0X?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PUZPR06MB4713.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M6CIk5AfHY0PpjIgHEGn1e0c309BEPtMF6AwbQdkqXy7dXP7YtFOL30uxv/6?=
 =?us-ascii?Q?cLdToD4XID9cioMZeQXlmZvS904P+ChWQ7q6cpNOSTEuq9abtgg2gaDY0bAZ?=
 =?us-ascii?Q?tys6srCOV+MzLYHUxTG1Td5ptprVoLfJmpSvEWZArGvlzkUSHoe+XVv9wGU+?=
 =?us-ascii?Q?D5sATrSZQW03zsIuBLEZjUf5kcc8pI1feRtiWIRr0m35YkRcWrYV1T85Fz77?=
 =?us-ascii?Q?QIV3gqP+MWkOJex8vj1DjBezJDcSN+e2IR0ME3qww7kMn5zlo1uwiK7cbnMC?=
 =?us-ascii?Q?CGg6p9K/Y8iLYtmnIze85kvy5GGaJ2jSTnuBpGLm07iq2lmFpPA7caVT5XNi?=
 =?us-ascii?Q?xBOXl74f6Ceub7Lk6Kht6MtF4IpL8DA5Z2Bva4fznXXrVEv7W4FUowOvmQFk?=
 =?us-ascii?Q?00sIE2Atv0VqRV92cirOwyf0t1cfUoXh8jw3sNsdg71+rMRUGgPxvyfuQGoY?=
 =?us-ascii?Q?wcX+0mAp2HfPasmvx496POcV5grI9wyAL+PtoGmhNY0XmA7Lk5RkfzSMpDT3?=
 =?us-ascii?Q?MAdOjUpnAD65bmlOfrtuKnyJT8msIFje9LAz/FFz6omPSsZ3j8NVd2QGrXbr?=
 =?us-ascii?Q?nGq3FhVcct4OSppqGBk4fp6Q8FzujsTtqXZ+6fGkpKqUo2TkXZJlbagmBNy+?=
 =?us-ascii?Q?OFznDGZrbaM1ahribVuJVJPVejq1devwVw160Ict3xxYOXG9dP96Dnj0t/Sp?=
 =?us-ascii?Q?qhyOF6RAzJyTUMb0pIYhe+kE7G2z+b0dYITQFz4a9KPHfwPt54vdL1kxkLNH?=
 =?us-ascii?Q?kl3pNeii9JQ7QDM6F7vrj7RV9f8pfJnQiY5tl/XdurIV6Ufv72rxG5ytmiwe?=
 =?us-ascii?Q?C2WurJPtkWR+FyXjqtKg7zgOt5gmAxmcaJSR8jS2aiPySzbzDxFuUJungNAe?=
 =?us-ascii?Q?lWf/9Sk3VcpqGhraIbJI4VqMKc2wsMK6aM2jdRQacg5IR8mKmqU4rf14dn4y?=
 =?us-ascii?Q?c8qW5RLoq8Oqfni5DH/GIAUjdC6rTGG21NAyYGuIB0LCjpE5EkKJhzwkFNhB?=
 =?us-ascii?Q?W8NnXZ8Xl3+UZIRdf1rWg6o2HW6CQ0fXiupipBJdllCDhjCvtayNit8XUkOP?=
 =?us-ascii?Q?EgvJyWltY9hWVO2mJtBHuE/rsgmNCkh/DfnnLKz7zfr8Hjq++SDKtJq+n7H0?=
 =?us-ascii?Q?Z58Iwqatu4aPRdpDZIV8KCJ5FWQyibii9m0g0Wk4PQKDda8p2BOTjFcX+oQe?=
 =?us-ascii?Q?W7h2PlaDEYo/KRCTAtQq7Qbvuuxyw08lv5TUOt1Mtn/J8oabYyT74xzNEjef?=
 =?us-ascii?Q?96HO3b906oEOAnBIVJSElKXGlMnMwFr//ZsEveWXtx5n9gJEvbudITF/RTVJ?=
 =?us-ascii?Q?Lzizg5urr62j0Iwmzih9LUJ5FaygSyhH0dfrCZ54Z/+sT6l66Yzrw9TPJtLU?=
 =?us-ascii?Q?yCsm/5ocSAsAiOMweMo3H9MbidRY7JBKpTUGgRt5T7FmyNKJ8lGVQzAJRw0X?=
 =?us-ascii?Q?9+qTvNjU9jxBkUrS6yRw9ZpJ+xGq6K18HYQOl7JkrVSWw31P7cJqTWSXPTF2?=
 =?us-ascii?Q?6FSVPxNKBDAFusg31IVsZ1P1nriseLgGdNIN9m8wx1ksr2MDU/1HnK0Uwjra?=
 =?us-ascii?Q?jQNRwiCUo6Opko21v03wqP/w+CdAX0ncmeP4OzoT?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dd23a6-3add-49e8-fbe8-08de33082d89
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4713.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:38:55.2963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IWI6xfH/sR4xJ+QVz3cDYRFeunSJp3fojHvxUmsRFC1QvgFgsKAFtahhYbbBwo0z6HjfFQ4oTO3r62Guh8BXzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDF24F4212
Received-SPF: pass client-ip=2a01:111:f403:c405::5;
 envelope-from=wafer@jaguarmicro.com;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement the insertion of available buffers in the
indirect descriptor area of split shadow virtqueues.

Signed-off-by: Wafer Xie <wafer@jaguarmicro.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 183 +++++++++++++++++++++++++++--
 1 file changed, 175 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index ecc3245138..94ad5c3a57 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -189,6 +189,126 @@ static bool vhost_svq_vring_write_descs(VhostShadowVirtqueue *svq, hwaddr *sg,
     return true;
 }
 
+/**
+ * Write descriptors to indirect descriptor table
+ *
+ * @svq: The shadow virtqueue
+ * @sg: Cache for hwaddr
+ * @iovec: The iovec from the guest
+ * @num: iovec length
+ * @addr: Descriptors' GPAs, if backed by guest memory
+ * @indirect_desc: The indirect descriptor table
+ * @start_idx: Starting index in the indirect descriptor table
+ * @total_descs: Total number of descriptors in the table
+ * @write: True if they are writeable descriptors
+ *
+ * Return true if success, false otherwise and print error.
+ */
+static bool vhost_svq_vring_write_indirect_descs(VhostShadowVirtqueue *svq,
+                                                  hwaddr *sg,
+                                                  const struct iovec *iovec,
+                                                  size_t num,
+                                                  const hwaddr *addr,
+                                                  vring_desc_t *indirect_desc,
+                                                  size_t start_idx,
+                                                  size_t total_descs,
+                                                  bool write)
+{
+    bool ok;
+    uint16_t flags = write ? cpu_to_le16(VRING_DESC_F_WRITE) : 0;
+
+    if (num == 0) {
+        return true;
+    }
+
+    ok = vhost_svq_translate_addr(svq, sg, iovec, num, addr);
+    if (unlikely(!ok)) {
+        return false;
+    }
+
+    for (size_t n = 0; n < num; n++) {
+        size_t idx = start_idx + n;
+        indirect_desc[idx].addr = cpu_to_le64(sg[n]);
+        indirect_desc[idx].len = cpu_to_le32(iovec[n].iov_len);
+        indirect_desc[idx].flags = flags;
+        if (idx + 1 < total_descs) {
+            indirect_desc[idx].flags |= cpu_to_le16(VRING_DESC_F_NEXT);
+            indirect_desc[idx].next = cpu_to_le16(idx + 1);
+        }
+    }
+
+    return true;
+}
+
+/**
+ * Add descriptors to SVQ vring using indirect descriptors
+ *
+ * @svq: The shadow virtqueue
+ * @out_sg: The out iovec from the guest
+ * @out_num: The out iovec length
+ * @out_addr: The out descriptors' GPAs
+ * @in_sg: The in iovec from the guest
+ * @in_num: The in iovec length
+ * @in_addr: The in descriptors' GPAs
+ * @sgs: Cache for hwaddr
+ * @total_descs: Total number of descriptors (out_num + in_num)
+ * @indirect_desc: Pre-allocated indirect descriptor table
+ * @indirect_iova: IOVA of the indirect descriptor table
+ * @indirect_size: Size of the indirect descriptor table
+ *
+ * Return true if success, false otherwise and print error.
+ */
+static bool vhost_svq_add_split_indirect(VhostShadowVirtqueue *svq,
+                                         const struct iovec *out_sg,
+                                         size_t out_num,
+                                         const hwaddr *out_addr,
+                                         const struct iovec *in_sg,
+                                         size_t in_num,
+                                         const hwaddr *in_addr,
+                                         hwaddr *sgs, size_t total_descs,
+                                         vring_desc_t *indirect_desc,
+                                         hwaddr indirect_iova,
+                                         size_t indirect_size)
+{
+    bool ok;
+
+    /* Populate indirect descriptor table for out descriptors */
+    ok = vhost_svq_vring_write_indirect_descs(svq, sgs, out_sg, out_num,
+                                               out_addr, indirect_desc,
+                                               0, total_descs, false);
+    if (unlikely(!ok)) {
+        svq->indirect_ops->free(svq, indirect_desc, indirect_iova,
+                                indirect_size, svq->indirect_ops->opaque);
+        return false;
+    }
+
+    /* Populate indirect descriptor table for in descriptors */
+    ok = vhost_svq_vring_write_indirect_descs(svq, sgs, in_sg, in_num,
+                                               in_addr, indirect_desc,
+                                               out_num, total_descs, true);
+    if (unlikely(!ok)) {
+        svq->indirect_ops->free(svq, indirect_desc, indirect_iova,
+                                indirect_size, svq->indirect_ops->opaque);
+        return false;
+    }
+
+    /* Add a single descriptor pointing to the indirect table */
+    svq->vring.desc[svq->free_head].addr = cpu_to_le64(indirect_iova);
+    svq->vring.desc[svq->free_head].len =
+            cpu_to_le32(total_descs * sizeof(vring_desc_t));
+    svq->vring.desc[svq->free_head].flags = cpu_to_le16(VRING_DESC_F_INDIRECT);
+
+    /* Store indirect descriptor info in desc_state */
+    svq->desc_state[svq->free_head].indirect_desc = indirect_desc;
+    svq->desc_state[svq->free_head].indirect_iova = indirect_iova;
+    svq->desc_state[svq->free_head].indirect_size = indirect_size;
+
+    /* Move free_head forward */
+    svq->free_head = svq->desc_next[svq->free_head];
+
+    return true;
+}
+
 static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
                                 const struct iovec *out_sg, size_t out_num,
                                 const hwaddr *out_addr,
@@ -199,6 +319,8 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
     vring_avail_t *avail = svq->vring.avail;
     bool ok;
     g_autofree hwaddr *sgs = g_new(hwaddr, MAX(out_num, in_num));
+    size_t total_descs = out_num + in_num;
+    bool use_indirect;
 
     *head = svq->free_head;
 
@@ -209,16 +331,61 @@ static bool vhost_svq_add_split(VhostShadowVirtqueue *svq,
         return false;
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
-                                     in_num > 0, false);
-    if (unlikely(!ok)) {
-        return false;
+    /*
+     * Use indirect descriptors if:
+     * 1. Feature is negotiated
+     * 2. Total descriptors > 1
+     * 3. Callback is available
+     */
+    use_indirect = virtio_vdev_has_feature(svq->vdev,
+                                       VIRTIO_RING_F_INDIRECT_DESC) &&
+                   total_descs > 1 &&
+                   svq->indirect_ops &&
+                   svq->indirect_ops->alloc;
+
+    if (use_indirect) {
+        vring_desc_t *indirect_desc = NULL;
+        hwaddr indirect_iova = 0;
+        size_t indirect_size = 0;
+
+        /* Try to allocate indirect descriptor table */
+        ok = svq->indirect_ops->alloc(svq, total_descs,
+                                      &indirect_desc, &indirect_iova,
+                                      &indirect_size,
+                                      svq->indirect_ops->opaque);
+        if (ok) {
+            /* Allocation succeeded, use indirect mode */
+            ok = vhost_svq_add_split_indirect(svq, out_sg, out_num, out_addr,
+                                              in_sg, in_num, in_addr,
+                                              sgs, total_descs,
+                                              indirect_desc, indirect_iova,
+                                              indirect_size);
+            if (unlikely(!ok)) {
+                /* Failed to populate indirect descriptors, free and fallback */
+                svq->indirect_ops->free(svq, indirect_desc, indirect_iova,
+                                        indirect_size,
+                                        svq->indirect_ops->opaque);
+                return false;
+            }
+        } else {
+            /* Allocation failed, fallback to direct mode */
+            use_indirect = false;
+        }
     }
 
-    ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr, false,
-                                     true);
-    if (unlikely(!ok)) {
-        return false;
+    if (!use_indirect) {
+        /* Use direct descriptors */
+        ok = vhost_svq_vring_write_descs(svq, sgs, out_sg, out_num, out_addr,
+                                         in_num > 0, false);
+        if (unlikely(!ok)) {
+            return false;
+        }
+
+        ok = vhost_svq_vring_write_descs(svq, sgs, in_sg, in_num, in_addr,
+                                         false, true);
+        if (unlikely(!ok)) {
+            return false;
+        }
     }
 
     /*
-- 
2.34.1


