Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBC1FD8FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvdy4-0001aB-Lb; Thu, 26 Feb 2026 11:12:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvdy1-0001ZF-JA
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:11:58 -0500
Received: from qs-2005g-snip4-2.eps.apple.com ([57.103.86.193]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vvdxz-0005fD-OA
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:11:57 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPS id
 56145180015C; Thu, 26 Feb 2026 16:11:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772122312; x=1774714312;
 bh=6S/q21pFn1OT/H9EqBcYzae2OwIFRQGq7oFgZeO8mDM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=G+xP7o5oaS4qPyfJS6AuGlAl73GhKB3Llfkp0J9V0UP5MDfojfiZX77iOxZ555dl13fwR+2R6nerfPoV1y6OPkLGMZfrqQ3iETpptzXO/cWbDRs/6Wv++YuVzLTUK7MhqEAxSB1szUJsewJcBTM8MsvFHMRhgXqF5HqECeLFlLZLE5u1sdt9XXtxbSW0njUDTCotbgRdRmCgtxb98OG3pYAHxNByRq5YbrcPoMMSQOO5f+YgHCthU6OKFDx4P8nW1o6M9gZpxEH3nSVeRBQdeiwE+Ef7qOapskSZVBreCM1EW3RtA4ewilkNcl9MXxaVJxkKQiQRZDhEs9XwmDIIfw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-0 (Postfix) with ESMTPSA id
 097CB1874A07; Thu, 26 Feb 2026 16:11:48 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] Revert "elf-ops.h: Map into memory the ELF to load"
Date: Thu, 26 Feb 2026 17:11:46 +0100
Message-ID: <20260226161146.68876-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=b6K/I9Gx c=1 sm=1 tr=0 ts=69a070c6
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=c_HyBtZksB4fQN2gfusA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE0NSBTYWx0ZWRfXzajmgqgc9gn6
 3nfu7bLQelLUHqO2/XJwUSM8mSi+TBOf960oziwJMU2c1xwShiOzbb3bpIsIOatX+0yZmZU2hUx
 EIm6VBaY0YZcrcEerX3xRyV+6dcq99AhaO3jvAJ/CTQg73c9sUQKFvKS4/pAbJKML/syM4Lyho8
 Nwu/itI4q8XPPvZ3+0wBl81/Pk23VjQipgIfK2HtmNcWC6XbfxJbwnu8swSDB92YIvlmACQaeVr
 YviICU+8pKs4Xfp6iUX0ReKT0vilk3eKg4aXjaJyIjLxDOu3Smq0R23cCBlGUTKGcLK50nPY55a
 bnPtqAyTCds7aePx4Yt9bPsZ8+TsI4RSDH6NjuenKW9Gf84Ii+JK2/x2wMi4sU=
X-Proofpoint-GUID: WRAdG0wSoPuTRCd6SgM7eweGGcE-Nl8j
X-Proofpoint-ORIG-GUID: WRAdG0wSoPuTRCd6SgM7eweGGcE-Nl8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1030
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602260145
X-JNJ: AAAAAAABGi2J0b637XDYQfOx5VmKkNoV1JPUiB4HHKbjC615WKXSPH3PyvOjSBw1bEqqceKe2/OdThVoKEPohxA4YfmFS1TGb5DtRB0MXVEMS64Li7G5oTraGi8BzNqyjAHXMk4akGhTieriJ3HlRU8YGfttluY0zbAgedNhjnu4zK5pFPJkRlQ3L46RFd7LgMlGSL2wDYrhcInUW+E2Q3mslvWq4L55PF8VcEboNh+7JpxyXEFzgIksrdaGCv/9H354bJsrWaVo3iJAxSq2DltemEO1n2Rg5ow9bJjGKLLmEgHrFDbK41wTF5nI2SFzX/4/GVBocJptkRyz3qtRS9iX27G4XsGd7pRyLscQ7JNcdVYlrJ7vyuj1K3aKz4R7UWQGyRilO8dNbfBh0CsdsNuekQrKWO2UQahELZrZMWIua6uqzlKhs8Bh01ezEkQYijHhixl5R/FedP4b4zE+SjoVHlZNttLqsdk+o8RHBoRbcg5AiWCAn1J24ydj9umHLWdhNJGVMyM5abY8t5Oh7ylt3qWxuynrs1Zr3HtOYNbHBAPyAEdbdljXz8w7+NDktmxH7aFhcCtYJELI40kqQgT4zsB1wbNH27WG8ZMiB7aj5JA=
Received-SPF: pass client-ip=57.103.86.193;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This reverts commit 816b9fe450220e19acb91a0ce4a8ade7000648d1.

Unfortunately, this optimisation breaks -kernel [x] on Windows hosts.

Reverting this commit enabled proceeding with kvm-unit-tests testing.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/hw/elf_ops.h.inc | 71 +++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/include/hw/elf_ops.h.inc b/include/hw/elf_ops.h.inc
index 9c35d1b9da..bcf484b938 100644
--- a/include/hw/elf_ops.h.inc
+++ b/include/hw/elf_ops.h.inc
@@ -325,11 +325,9 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
 {
     struct elfhdr ehdr;
     struct elf_phdr *phdr = NULL, *ph;
-    int size, i;
-    ssize_t total_size;
-    elf_word mem_size, file_size, data_offset;
+    int size, i, total_size;
+    elf_word mem_size, file_size;
     uint64_t addr, low = (uint64_t)-1, high = 0;
-    GMappedFile *mapped_file = NULL;
     uint8_t *data = NULL;
     ssize_t ret = ELF_LOAD_FAILED;
 
@@ -409,32 +407,20 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
         }
     }
 
-    /*
-     * Since we want to be able to modify the mapped buffer, we set the
-     * 'writable' parameter to 'true'. Modifications to the buffer are not
-     * written back to the file.
-     */
-    mapped_file = g_mapped_file_new_from_fd(fd, true, NULL);
-    if (!mapped_file) {
-        goto fail;
-    }
-
     total_size = 0;
     for(i = 0; i < ehdr.e_phnum; i++) {
         ph = &phdr[i];
         if (ph->p_type == PT_LOAD) {
             mem_size = ph->p_memsz; /* Size of the ROM */
             file_size = ph->p_filesz; /* Size of the allocated data */
-            data_offset = ph->p_offset; /* Offset where the data is located */
-
-            if (file_size > 0) {
-                if (g_mapped_file_get_length(mapped_file) <
-                    file_size + data_offset) {
+            data = g_malloc0(file_size);
+            if (ph->p_filesz > 0) {
+                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
+                    goto fail;
+                }
+                if (read(fd, data, file_size) != file_size) {
                     goto fail;
                 }
-
-                data = (uint8_t *)g_mapped_file_get_contents(mapped_file);
-                data += data_offset;
             }
 
             /* The ELF spec is somewhat vague about the purpose of the
@@ -530,23 +516,22 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
                 *pentry = ehdr.e_entry - ph->p_vaddr + ph->p_paddr;
             }
 
-            /* Some ELF files really do have segments of zero size;
-             * just ignore them rather than trying to create empty
-             * ROM blobs, because the zero-length blob can falsely
-             * trigger the overlapping-ROM-blobs check.
-             */
-            if (mem_size != 0) {
+            if (mem_size == 0) {
+                /* Some ELF files really do have segments of zero size;
+                 * just ignore them rather than trying to create empty
+                 * ROM blobs, because the zero-length blob can falsely
+                 * trigger the overlapping-ROM-blobs check.
+                 */
+                g_free(data);
+            } else {
                 if (load_rom) {
                     g_autofree char *label =
                         g_strdup_printf("%s ELF program header segment %d",
                                         name, i);
 
-                    /*
-                     * rom_add_elf_program() takes its own reference to
-                     * 'mapped_file'.
-                     */
-                    rom_add_elf_program(label, mapped_file, data, file_size,
-                                        mem_size, addr, as);
+                    /* rom_add_elf_program() seize the ownership of 'data' */
+                    rom_add_elf_program(label, NULL, data, file_size, mem_size,
+                                        addr, as);
                 } else {
                     MemTxResult res;
 
@@ -584,16 +569,14 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             struct elf_note *nhdr = NULL;
 
             file_size = ph->p_filesz; /* Size of the range of ELF notes */
-            data_offset = ph->p_offset; /* Offset where the notes are located */
-
-            if (file_size > 0) {
-                if (g_mapped_file_get_length(mapped_file) <
-                    file_size + data_offset) {
+            data = g_malloc0(file_size);
+            if (ph->p_filesz > 0) {
+                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
+                    goto fail;
+                }
+                if (read(fd, data, file_size) != file_size) {
                     goto fail;
                 }
-
-                data = (uint8_t *)g_mapped_file_get_contents(mapped_file);
-                data += data_offset;
             }
 
             /*
@@ -607,6 +590,7 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
             if (nhdr != NULL) {
                 elf_note_fn((void *)nhdr, (void *)&ph->p_align, SZ == 64);
             }
+            g_free(data);
             data = NULL;
         }
     }
@@ -619,9 +603,6 @@ static ssize_t glue(load_elf, SZ)(const char *name, int fd,
     }
     ret = total_size;
  fail:
-    if (mapped_file) {
-        g_mapped_file_unref(mapped_file);
-    }
     g_free(phdr);
     return ret;
 }
-- 
2.50.1 (Apple Git-155)


