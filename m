Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3472DEDEBF6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWhF-00066r-Ng; Tue, 03 Mar 2026 15:50:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh3-00060b-F5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:14 -0500
Received: from p-east2-cluster6-host2-snip4-6.eps.apple.com ([57.103.76.187]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWh0-0000ie-Lf
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:50:13 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 9389C180058D; Tue,  3 Mar 2026 20:50:07 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571008; x=1775163008;
 bh=0fWErJaX02RIx//K1QKWhyiArR5flxx/eaA9Q5gZ7qk=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=M5pmyZWXBskNeP+DvaPx8WFgusXbRRIEXmsD/9E1vhlXxseapSLFwvUNsDqVkFzW5omuzf8tFYCVP2uhjMQII39ZhX5KPg1TqzXgyftE8ZNwUfUchHrWwt4NdFA8ukFe1CBoaYE/zTZLkhXR3RdkPh26T0skJXKP4pmDs3grpdQlF6zrjtnp0hJJdymSBTYFsAGtMFWEdOvZLo//QwsW9z8ByJvCnQ74KEo52ySgFuADr3ILzSfrcfBu5BByStf4Y/rJYiSUAqNlYwYa+7ppfzgXvujLd6acMNhIZV711Pl+i7nFpy0HzLbdU3mt+uZPrj45iqdcnYCaYtj6gJEVAQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 991171800133; Tue,  3 Mar 2026 20:50:05 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH v3 2/9] Revert "elf-ops.h: Map into memory the ELF to load"
Date: Tue,  3 Mar 2026 21:49:52 +0100
Message-ID: <20260303204959.31156-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260303204959.31156-1-mohamed@unpredictable.fr>
References: <20260303204959.31156-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5dDjHihJFBf_6EKbP_B3CCetOZkn6m7C
X-Proofpoint-ORIG-GUID: 5dDjHihJFBf_6EKbP_B3CCetOZkn6m7C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX850W0F5FLzLS
 xliXMcF4/Td8BfxI5heIQI6XpYOAQHH9Z1GlEjSYzCwocSuzmq8rWZJmcADRU/064u/7zFh5U6q
 T1rmhnkT139E0nBD3BdrY43z58MYlvdcy3xELvmjKmyYZvCGq4H8sgYq3K1+KiLsxJMirk+j3Fx
 4jW12cf9sOrcWgFc3DRzoOqpk0lg9grMJQiodTzaQqD/PY7ZM1gCM8pMaPnI44kftNn2XZeekKg
 Kx/N0nUGGo1D/plVRQDBEfw5L4gZinPVtgXtLUmPNZ/K+KJXR7qk/dX2jsekqeK5sobhzWxrfzR
 iMiyFqdZR/Zj/g71jUM0cpE7svUsGaHDI2gHBYAdPvSpUfFyZBwkXGO+K5GukY=
X-Authority-Info-Out: v=2.4 cv=H4jWAuYi c=1 sm=1 tr=0 ts=69a74980
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=c_HyBtZksB4fQN2gfusA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1030 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABvdiNvL0MHYjUrMETfuTipG/uj5sd7ge+oZXp8BIL+f7AdmiP9a+5aXyz6kBYshpK4Ne/WAg+7NoAVilrrs0L8nV+DBEQanQHnvd51B361nZkFmxpiiqXqLGuqBIeT/VrDdG7E7bDlHPSDITFzhik4tTo4E2TyIEaNFbk/folj/a7L/wJ4aBR0R48iSI6PWoz7ZSimjKk85ZXyDZirePNcNq5puP9xraFqc39JttViT+T+q6iFT84SHMR1iEkkOOWBI2r6mBLYhhxZ5MTIBDLCldeuwA6f01avlScuQIyiC2DTroED91SBwi0bVFy/riVkaJdHM7XrWjUEOrBaeKZMawrjEUspwqeyAGdyovTuRBKv0fTnv85l6mUvXPue/2mkRWlvad2Ja+WWN+C7fMUUSyeUgOm4C5B3kNmwYlc7iAXASmAwl/+m3p10kDodWiusctFpvTC5i3MQNx7ZcKcwl7V3iv6XWo5Y7tVo+M5E9Bv5qZKhiIUU8tf710xMymu3zwf1Y8Z2sD1/6OXgK2nIzYnmr8K5fFWX1ZQdBOtKCot1dOV8asXhUqlPKeNPxG1sypilnX/F21+XVXndc8Rrkw1hcEbugGqEyWtu1eol8EPlsiiN5l2+rO/8CXHtWVfz3y9ZadiQWqyV5qq+lZQ79C/fCZGMQ7sTRB7MB2w1HLmlcWQNUnylCpqH2gNAj8YF5ziZTOZSjAN5nKGhvvVhjqwUllnaQtx9R/08g//99NgtimK9Sh5+RUIE5ZvCTM6FLfgnFl9SIC2dQ==
Received-SPF: pass client-ip=57.103.76.187;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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


