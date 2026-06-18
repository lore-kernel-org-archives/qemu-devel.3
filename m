Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CFFACD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waBrn-0007zu-Oz; Thu, 18 Jun 2026 08:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrm-0007zW-4o
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waBrk-0007Xs-G5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 08:29:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IAriIq3763792
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HDXqqZ40gMOjetGP947qwpAyTFvS5rl4u1GZMvX9fQI=; b=OiDYXLkfZ2soZ459
 b/2gk2qEjSRGlnQhA63zBWoF5+ARHgQ04P4Pzvi1eNewChQ9Dw4k6EmApplQ81Mv
 kLxbSgYTSNVbnSUGblSEXEb45nPyNKyBKUItrqR1NDsyDVUW4LCvdCKtvTfQL45z
 TjfG/asug4U5Zc5rrAGkwho0h32HKfoHaRzn2Oomkr/JtfzP0S38w/+OmoC7KkO7
 Rumic3m5sgjdnzMb/x8BXpBCbwgJ1/Lj0ZvCc1vqF/rNlOOuEkj42CeP/zokF169
 QUtOvBrjsiMT3xCB05IP5jTq2rRY7kEPsZW1Rd5RxxmVpjaRTvRbD5wRRRM/ctc6
 QyAYYg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vk3apu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 12:28:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccd3213beaso913456d6.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781785737; x=1782390537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HDXqqZ40gMOjetGP947qwpAyTFvS5rl4u1GZMvX9fQI=;
 b=OIcMbWp3QjpZlK1HTMKZwZWt6Z8/FGoI3zPEB0yZuzHOhSZGsIFRgWAm8M42Wm4/j8
 nozla9BbnRR6m5rVCZxNMsyY2k8vXovTE1E/8M7cK2Y+AwsMQ0cwyJKkSgrOFKBEo4gP
 biCtXC3ZwYVsca2nTs6onX9rFAKfjJ7Oar8/s3v019dEc8qVDDUSJ92PC/YEKgrOWMBP
 y1rUHSoS7PrfC4kzQHFYv9HbtNrnSsht2mjiqauEF24MIbVUcseM6nlxgDoYX/umh482
 sb6SxTNL1x5XrfsXaDDpisUFfxdgy2bbL83VW/XGbn0xf+iRPrGkIX6hY2zf49cNeqiR
 GSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781785737; x=1782390537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HDXqqZ40gMOjetGP947qwpAyTFvS5rl4u1GZMvX9fQI=;
 b=Y659wXhf4XVSsJP0xSZxMWN+k2ECsb4bWq25LWfre6vtU64nKQfSHqW4Yuugj7Rj1a
 JrEv9MDPri/Y3XNfsS+R/Bz9YhdXOhGgCaRsThwI/LPyEc8hl/gZPFjbh9ajSLZOHao4
 s0562nR8t7wGuh0mjE6hrnbFZ6bfYSlA5H4lrJUnTLABXrDBqyL07xO2xRJMmi+z6oTL
 QHX2N7lYK8ZfAfqhCTkXQsj8O2QwP/7HzgnpecAXVfBeqNGz7uZk9ZTId8Ge6XjMKSc6
 TdG/HoqRmY3ND2NpnrDdSKCsLpJw8noLdK95IT9uSkuh6fteWv905C3c+hXzJ5B4bGCq
 sEvg==
X-Gm-Message-State: AOJu0YwZcC3A6OdXdFDC+zsMhSIRzsmZDMBZBv0HI+4QXSC+ibL4EDMx
 vkVlu2qnoiFRqHaybaauPtFdw+5ItfeIiK7JpQuidaAFJLGQAkjM08w1NPCgVZJW9NL8ZETLQpD
 uPP+d5oSDHAOmoSosTOOdTrE5jD4D7+cSoJOvQa8OH1Yv5zsa0LaTHtR5vO+0r2g0Sw==
X-Gm-Gg: AfdE7cmey6jVjXsajOyxrem1IdwJ0BQ75Rwylwou35OEtjAFKg9/mEVMCeVlAKZOHLd
 hUL591ZwuG5ANZXgtZKkKFWzqMUz4KBBAfNZKtDgaP+27FGRoHP9CfjqLrHfkqFwW0j1lugZi+J
 +ybQAc+CGH2EI++h+rgOFSXDHblT/JEr7agmXfgBAoRrIsl0UCGZe9r4ddHFlattTNMN43Pq55x
 /5AUPhoXmlMPT32jJrlVY7m5XplyJ0cm4vT6zpLbrLVA4sxTn5Fg+83BF6M5c3B0QWGOmmZx9TM
 OGerP1M+WW1Nw4Ayw6U82hCDbz6BGMW79wxdJq3PEipRhNp68PGUvt2RbUKS2Lnp2W/DRsT733N
 z2zl2oe9eb853W4KF3RgWGoMcpVSyHb/+Vwrrz9rLrGSC7BS8LWLDVrzOAI1CUz7a9E7c
X-Received: by 2002:a05:620a:25d2:b0:915:d5d6:f1fa with SMTP id
 af79cd13be357-91dbb9489aamr1228003485a.31.1781785737334; 
 Thu, 18 Jun 2026 05:28:57 -0700 (PDT)
X-Received: by 2002:a05:620a:25d2:b0:915:d5d6:f1fa with SMTP id
 af79cd13be357-91dbb9489aamr1227997785a.31.1781785736720; 
 Thu, 18 Jun 2026 05:28:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a96d14sm224951325e9.12.2026.06.18.05.28.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jun 2026 05:28:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/48] system/memory: Constify various AddressSpace arguments
 (notify)
Date: Thu, 18 Jun 2026 14:27:41 +0200
Message-ID: <20260618122825.90331-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618122825.90331-1-philmd@oss.qualcomm.com>
References: <20260618122825.90331-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7bYw_G256jNXCqSSdyKzkog3XWU7TbqQ
X-Authority-Analysis: v=2.4 cv=DNy/JSNb c=1 sm=1 tr=0 ts=6a33e48a cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nR6OtcKYjoWMIbXoh8MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 7bYw_G256jNXCqSSdyKzkog3XWU7TbqQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfXzEuC8x5pkgNG
 1f/YaxWmmlpQVRdr7b4qvAsc+tn6QrPzZNrZa4ArnjJjdDUPDh+3ShQo3GGhmlthQ/OyCjMCoD6
 waEtvp26BiPAjAWGJ7oaU5xXtKgaY+o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDExNiBTYWx0ZWRfX17SXo/qdQqpk
 OM6zL1X2UY1sw8y15brJL0jW1bMovM0oL+hal1eUP4xJgoNRruVR9+z+ml4+XcvZ9ECYDdnwwbJ
 qZpZJ2Pw817INYD5PQKr/uFqJVMUB7pD0HoOUP8pmzmJcfX6CXNDoiyOknsG4gEszVugPM2qX4a
 mWqWB8pk0nxNxruYK+e1PeisVZyG40UPAw0VDQZQNJklYIe3hwYDmngv66rP0M6cU1hsRwj8CxY
 I0ZwU0HtwcS4mFuIHo5cbmlNTQ6Gv//Me8d0zHZxHVTn8srl+d2rda42YDNKiUmJ4WReqGTVWu9
 6l9CBMjc4xPIMu6exE1mCqj1Dqlkkrw7IwOQfSWysD3PekOxqWGLc5wuK9FML9XZ+ycghxtiTaH
 VSKAE2GfpJW74p+TgWa+OJKq1vE+fDbqhv9hHPjswcANqaKsVNkxeJM0mw01AgsUKPntyuSrUO7
 gTyey0oYdQP0YruBqug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Mark the AddressSpace structure const when it is only accessed
read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260616020359.18627-4-philmd@oss.qualcomm.com>
---
 include/system/memory.h | 2 +-
 system/memory.c         | 6 +++---
 system/physmem.c        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 3acaa309755..7ecad33130c 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2703,7 +2703,7 @@ void address_space_destroy_free(AddressSpace *as);
  *
  * @as: an initialized #AddressSpace
  */
-void address_space_remove_listeners(AddressSpace *as);
+void address_space_remove_listeners(const AddressSpace *as);
 
 /**
  * address_space_rw: read from or write to an address space.
diff --git a/system/memory.c b/system/memory.c
index 93c714104b2..8436668c181 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3009,7 +3009,7 @@ void memory_global_dirty_log_stop(unsigned int flags)
 }
 
 static void listener_add_address_space(MemoryListener *listener,
-                                       AddressSpace *as)
+                                       const AddressSpace *as)
 {
     unsigned i;
     FlatView *view;
@@ -3074,7 +3074,7 @@ static void listener_add_address_space(MemoryListener *listener,
 }
 
 static void listener_del_address_space(MemoryListener *listener,
-                                       AddressSpace *as)
+                                       const AddressSpace *as)
 {
     unsigned i;
     FlatView *view;
@@ -3179,7 +3179,7 @@ void memory_listener_unregister(MemoryListener *listener)
     listener->address_space = NULL;
 }
 
-void address_space_remove_listeners(AddressSpace *as)
+void address_space_remove_listeners(const AddressSpace *as)
 {
     while (!QTAILQ_EMPTY(&as->listeners)) {
         memory_listener_unregister(QTAILQ_FIRST(&as->listeners));
diff --git a/system/physmem.c b/system/physmem.c
index a0561177afd..e8a2c438c7d 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3565,7 +3565,7 @@ address_space_unregister_map_client_do(AddressSpaceMapClient *client)
     g_free(client);
 }
 
-static void address_space_notify_map_clients_locked(AddressSpace *as)
+static void address_space_notify_map_clients_locked(const AddressSpace *as)
 {
     AddressSpaceMapClient *client;
 
-- 
2.53.0


