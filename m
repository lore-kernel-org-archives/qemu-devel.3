Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BF4C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:37:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjivN-0001iD-BN; Tue, 14 Jul 2026 15:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivL-0001gD-S8
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjivJ-00056v-P0
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:36:11 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIwM9r1137082
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FVZcww5ehdUaMle+W+PQH/YLL7+qw+ENNbaJYAPM3D0=; b=isswnZ+oA8cXg4aO
 F6sU8MluNSUzqpKkKET7q474bu5aU99vysJaVmHDoJHpHb18aSGN/ZiEIe1yvTP8
 oip878n2/WiauQUAE9DpfRBLNMiO4vqapVbVmNy0DpwFUnANZWKWIxvcuRCGY9Fj
 S0YYU2bFQgjJaBSUXZ5SKJttExCOcqLWC09a1ycMaojWxOoUeRzm5RhRoQR4yBjc
 MUWlm1iEqIT0KUP+So6L1q5hb1JK7e0OeltmPDYTDfnu5hJZcX93Gp1UAJk3Cjgn
 MRTXxRg/b81crw/ud/8Rw85PziWAU9Fq09StAqGnPWs+gclXVonW9CgL7Z0W18rs
 FRMeFg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9mgft4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:36:08 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c12e43b98so78861441cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057767; x=1784662567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FVZcww5ehdUaMle+W+PQH/YLL7+qw+ENNbaJYAPM3D0=;
 b=dFD7pBqAd1pyXVDjhmlCdohPncqKP8aRgdShWV/xOU/dW+1Xcb+WHuPFlLE1C285tX
 f0KDY4lW9/gui9YBzpoKa54vl2x28FxLKt+hp99M6I0s+hhLStHbzbIiHZJUwNCZazOw
 aAyMqvpxwDK91aAwb7x9yAOmUz3tMev/g/wfJBbQ0HOHvLIPkWTRKyjaqB+lZyHAY2Uh
 2adhMWJAIJ40t1hqH/C1hkX8quFmW2pTViI6zcugsOGqfMUMvwqduJqOX6WwdZ5j70KE
 9NqSOpLNngTZEOqajb85+Q/y6/+8Tobxv0zk/DPCDPBfz4aEBGbW3fw1kkQ6q8NP5ZFk
 u2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057767; x=1784662567;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FVZcww5ehdUaMle+W+PQH/YLL7+qw+ENNbaJYAPM3D0=;
 b=BCYmxSqQ4IBGhedKcG2WXrclNhLOYmJTPTIsCWTriiDNfOv0i14zIch80CMVQsHgCd
 RiFySl8+6pLRLPhhlzXwBKXyI8qty3U3pBpmUh/qSRu5VNjF1ctjFgwru6U+c1qz0D39
 gwDmch42QOtdc+zk177EdKq97lI3ybyi7K+CijTlxuuW1VxoWWfKUWcLPumRbfvlozdq
 M9VX07pDerx0NFXiuYX9pHgMS4HtL32+piJlFhcK8laeek7x6Gl+Kv4/ys20xWebKgaL
 ETPYkZFUlPPjRxVdvvNtxEMWp+XKtliB1HN+uM5DV9ySzxqewOcznXffL2oiE4ox3PbN
 yNlg==
X-Gm-Message-State: AOJu0YyfjDICFD70TugF84NA1RzTGxO6dA+u+4r/Ga1nywpkMq1iJfTJ
 FLObZcv7kY+wWMgFozr6LAu+lVIITdSyBgHnKvQdW2Kmm1aI3LW5I6U5vq5Qs0lsOOgITGfGh0c
 Plb5IIomlR8h1fH2eCZrxhd4WvsjK8OXRSm6pDqfdQ7+cnh5KMx6/XVqnfN9G3byIxg==
X-Gm-Gg: AfdE7cmZPMdTJRrqJL4qwVAPA6ulW4cNBDWqp2KE91LJa9ytr4m7TCyir89bI1e1OMG
 prqj+91hjN18p4Od7sxMc849r8sHb0OMRN9JpHMmZX5+JwkXoPlhvhPnIf3fhd6iP8nwQGlyykp
 nthGvtJ4pHkUL+J4XsgyWKhfHSBN6e3dupCRYBgBa1d0wcfT+CubF35LGpgSwbEWjZqx8C4XgCd
 R6TblPaDkYJgbOW/5qAi/kdsaoawTV3kYnPG21ZfSHjgdq+iWm2xgYG2fLZ6o4LLknCrtJVvPBk
 7Nqrzvy8Z2eQkdEpmrcXGsP1qjgL9nkU2DpTD+LZ9Plgm8iTg3RpegQ1ux5ad4J5tplR0C6YTsp
 rLa3jqR3J0AJdQh1C+uYFkuTAa4QWVmCo4LTn3OECddPdR932BZ1eth3Ql9DxuLcuYg89
X-Received: by 2002:ac8:5806:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-51e3c1ce15emr51666601cf.30.1784057766482; 
 Tue, 14 Jul 2026 12:36:06 -0700 (PDT)
X-Received: by 2002:ac8:5806:0:b0:519:f420:d780 with SMTP id
 d75a77b69052e-51e3c1ce15emr51666141cf.30.1784057765584; 
 Tue, 14 Jul 2026 12:36:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464b7e22sm10235028f8f.25.2026.07.14.12.36.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:36:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/13] hw/display/qxl: fix TOCTOU in cursor chunk data_size
 handling
Date: Tue, 14 Jul 2026 21:35:10 +0200
Message-ID: <20260714193517.60708-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX5GnI2aToJD+h
 o6RxPy0IVl5k8REKlwz9BPpPkes64QlNJxolAp2jMdf/t4fkrcn5llw3wsXTX1xM9C11YMByIce
 W6tx8vzZum0gv3IF8FIqSblU2UdyXC7kY0tVAnYsivVWdASe48J8/cmGZWySdyRA9N+GnLE8V6m
 qujhrjkGVocGgqEEjoyRpGXQxYRRtq47en92+ozaW60cI0Gj5UP5GuaWybYNdO9nrNOUkNpV8P+
 8mnoCs5YAnPqKKaIV6GZG3XfQh4mZDiLXsd3Sc857dpI0bj5sTPJNlShxHplDwEp+XrV2DejDEd
 xp5Ih6fpXaFyInFGtURau5y5GKM3YBBunDhhX4NRnfqyi8J/KWhO7Aq1vQJ8Y6wGh058qYEfb74
 2pYsrNQ8j0O06dQhRQxdrslPnxkgFz6GEMIa8zUOcJ5Kgxzal3Vb+zBH6GnTwnU0biXO72qTdwE
 Dnu29Bvf1lYQqfIB03A==
X-Proofpoint-ORIG-GUID: zNEyOE19CURifJ0qGO1-lW8C1UavPTed
X-Proofpoint-GUID: zNEyOE19CURifJ0qGO1-lW8C1UavPTed
X-Authority-Analysis: v=2.4 cv=E+79Y6dl c=1 sm=1 tr=0 ts=6a568fa8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=csm7OsOMr3LbVpAVGOoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX0uA6azC8oC6W
 rUdr2WAcPwepbOpvMWtOYQMvrDpfQbvd3i310B0D26n/Jci41GMr4L3p/M4fiu9p5feJ7HyozPc
 vO+ZlXgxoLbsl3mdqvEkhu8VpWdu580=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140202
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Snapshot chunk.data_size into a host-local variable before passing it to
qxl_phys2virt() for validation, and pass it through qxl_cursor() and
qxl_unpack_chunks() so that no subsequent code re-reads the field.

Without this, a racing vCPU can inflate data_size between the
qxl_phys2virt() validation and the memcpy in qxl_unpack_chunks(),
causing a source read past the validated region. In practice the read
stays within the guest's own VRAM mmap, so the impact is limited.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3757
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260710134352.2313675-1-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/display/qxl-render.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 3bf634ee059..4799c9e8bef 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -217,7 +217,8 @@ void qxl_render_update_area_done(PCIQXLDevice *qxl, QXLCookie *cookie)
 }
 
 static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
-                              QXLDataChunk *chunk, uint32_t group_id)
+                              QXLDataChunk *chunk, uint32_t group_id,
+                              uint32_t chunk_data_size)
 {
     uint32_t max_chunks = 32;
     size_t offset = 0;
@@ -225,22 +226,21 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
     QXLPHYSICAL next_chunk_phys = 0;
 
     for (;;) {
-        bytes = MIN(size - offset, chunk->data_size);
+        bytes = MIN(size - offset, chunk_data_size);
         memcpy(dest + offset, chunk->data, bytes);
         offset += bytes;
         if (offset == size) {
             return;
         }
         next_chunk_phys = chunk->next_chunk;
-        /* fist time, only get the next chunk's data size */
         chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
                               sizeof(QXLDataChunk));
         if (!chunk) {
             return;
         }
-        /* second time, check data size and get data */
+        chunk_data_size = chunk->data_size;
         chunk = qxl_phys2virt(qxl, next_chunk_phys, group_id,
-                              sizeof(QXLDataChunk) + chunk->data_size);
+                              sizeof(QXLDataChunk) + chunk_data_size);
         if (!chunk) {
             return;
         }
@@ -252,7 +252,7 @@ static void qxl_unpack_chunks(void *dest, size_t size, PCIQXLDevice *qxl,
 }
 
 static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
-                              uint32_t group_id)
+                              uint32_t group_id, uint32_t chunk_data_size)
 {
     QEMUCursor *c;
     uint8_t *and_mask, *xor_mask;
@@ -272,11 +272,11 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
     case SPICE_CURSOR_TYPE_MONO:
         /* Assume that the full cursor is available in a single chunk. */
         size = 2 * cursor_get_mono_bpl(c) * c->height;
-        if (size != cursor->data_size || cursor->chunk.data_size < size) {
+        if (size != cursor->data_size || chunk_data_size < size) {
             qxl_set_guest_bug(qxl, "%s: bad monochrome cursor %ux%u"
                               " data_size %u chunk_size %u",
                               __func__, c->width, c->height,
-                              cursor->data_size, cursor->chunk.data_size);
+                              cursor->data_size, chunk_data_size);
             goto fail;
         }
         and_mask = cursor->chunk.data;
@@ -288,7 +288,8 @@ static QEMUCursor *qxl_cursor(PCIQXLDevice *qxl, QXLCursor *cursor,
         break;
     case SPICE_CURSOR_TYPE_ALPHA:
         size = sizeof(uint32_t) * c->width * c->height;
-        qxl_unpack_chunks(c->data, size, qxl, &cursor->chunk, group_id);
+        qxl_unpack_chunks(c->data, size, qxl, &cursor->chunk, group_id,
+                          chunk_data_size);
         if (qxl->debug > 2) {
             cursor_print_ascii_art(c, "qxl/alpha");
         }
@@ -325,19 +326,23 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
     }
     switch (cmd->type) {
     case QXL_CURSOR_SET:
+    {
+        uint32_t chunk_data_size;
+
         /* First read the QXLCursor to get QXLDataChunk::data_size ... */
         cursor = qxl_phys2virt(qxl, cmd->u.set.shape, ext->group_id,
                                sizeof(QXLCursor));
         if (!cursor) {
             return 1;
         }
+        chunk_data_size = cursor->chunk.data_size;
         /* Then read including the chunked data following QXLCursor. */
         cursor = qxl_phys2virt(qxl, cmd->u.set.shape, ext->group_id,
-                               sizeof(QXLCursor) + cursor->chunk.data_size);
+                               sizeof(QXLCursor) + chunk_data_size);
         if (!cursor) {
             return 1;
         }
-        c = qxl_cursor(qxl, cursor, ext->group_id);
+        c = qxl_cursor(qxl, cursor, ext->group_id, chunk_data_size);
         if (c == NULL) {
             c = cursor_builtin_left_ptr();
         }
@@ -351,6 +356,7 @@ int qxl_render_cursor(PCIQXLDevice *qxl, QXLCommandExt *ext)
         qemu_mutex_unlock(&qxl->ssd.lock);
         qemu_bh_schedule(qxl->ssd.cursor_bh);
         break;
+    }
     case QXL_CURSOR_MOVE:
         qemu_mutex_lock(&qxl->ssd.lock);
         qxl->ssd.mouse_x = cmd->u.position.x;
-- 
2.53.0


