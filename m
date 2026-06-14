Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD09ACD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDg-0001SZ-SD; Sun, 14 Jun 2026 15:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDf-0001KQ-EH
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDc-0002vL-Rf
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FFLyL6q6f1wgZeDPSCW9Y0Lt5P1U/oslDNetNFUEjzE=;
 b=al93ML8XWrGrC/V8BUkqDlfvvfGIWg1B9hzKqXqcTmaLuWA08XbXLfGHW/GdChr68TljrI
 IxDhUixczr8muN5Y0jtkc602isUb4GFnsNxHNE9KpqVHhkoC6PwLRLu9GEAHWGFq7pKSnW
 p190ySkq38BtTRY/fxslOJ/URH6XJBk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-0RyA6bxjPiiihpc_eHrPhg-1; Sun, 14 Jun 2026 15:10:02 -0400
X-MC-Unique: 0RyA6bxjPiiihpc_eHrPhg-1
X-Mimecast-MFC-AGG-ID: 0RyA6bxjPiiihpc_eHrPhg_1781464201
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-45ef3aeeb41so1609162f8f.1
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464201; x=1782069001; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FFLyL6q6f1wgZeDPSCW9Y0Lt5P1U/oslDNetNFUEjzE=;
 b=lunR7vhi2bebF/BYaDnW1Sy8fd2w4HJ7pQFF1ksTEsG+Ux7WaUWt2MyI48GXWVxZEG
 r9k6vO6gRrO9hm9NeSiNvIGMz8sK1WA8/fyuZKP+4FG81LwFSuqmTqYvFtn/4UWl4stq
 K693AUoSg9aDGSrGbHrr+ADaUkY3WS2JbptOCxYi94C9XSt0cDDrO5j6TqtG8n77l+0O
 DzBJYE0wY7AWnm5tK2T+dSOHrt2phsRvu8ifJsHk2wDT4fmXVM/37g7edKfcHHcxRMHn
 pbtopc1BMub8i9OEKK/YDC6bq2P1TS004Z7vdVlwbYdS9W0lCUPndgg5kj6qnTU33+zy
 jcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464201; x=1782069001;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FFLyL6q6f1wgZeDPSCW9Y0Lt5P1U/oslDNetNFUEjzE=;
 b=W1XY21XKGyBi6P26/w5xyxDlfdGklNleoG/mfoPZQyIlvGx3Ur4vkdFVSoICY7ljpM
 3Vn5VK9QPIQQOygSu6J+x5y0h6DREm/r02kI+RcpKzgzMy+h3xaIxiu0QbQMdSZS8mYT
 06D9lmdmz5gz+PnV/oZRl1usOvqdToFBnKabVTS6pC+mNXOzE0LEH0NGBe8eLxnXAaMY
 ed2mzf6OxqqFZAOsChDLq/QitwIC1pAtVC3uO2mJZO3e2dadMNXesEnQg8VnhnwCaw0/
 WxhcN3nK9ke6RjdDH0HY+MDptEiY6VAAPpSdj8cakNbd97DDb5KPpfzh2/jVSne2OTs5
 Mq+Q==
X-Gm-Message-State: AOJu0YxqhCmSXMMaMl0OphYoQ5TfVjU/fDuDkbfdoFnvLtJiU/q66obF
 h025sET234C7/Lg/LhWts2ZODiPjaTmlQ7tSdgvSGSRYZnLAEnv+xAoOT6err64ZVqLXPGTo3RP
 8Sw1IwdLyOll6yisR4FGgZAASi096hI3aHDs4H3j7L/Djnnh9hEDxTh2qdpjYkdA8Tk5VIja5+r
 bf50uX8mIHbEG1D8Jfu1SE00tfSqhpLEeAfw==
X-Gm-Gg: Acq92OG67tJ1AamMktlDzsBDx3xy6FxsszeOhbblBZWlb5y/xDn2SeU7kG225zEq/3u
 sM8AT1aPZ4U7vCtBJJoBdMRJ9RjB7+GnDHVEENhJyvt53Urd8mq4F190D/Cj+Dvh+NGuFzmgotj
 EQF90WachZ8OlU1lusuUz1CunUK3MQ1iRRl738XDPSiXB6kxoy4chMww4C0YWd+q6tMB5PeQ6z0
 MuxjuO23V5AHxvFgnSihbvDoapZNSg9nnzMcECTpITqKTiSVVvjt9rdgskkp25pbOQRnO3LrWhh
 o8+YEegKaUn/gUSPnA2OQyYVnU/zXbdhfCKxk2ap3FehFVcY+5/hvF0D6E3VDqUuz5iU5nq/OxL
 +VNVIdIpNGQG3EdWNfs1Dr8xN0gE1XUO92Zt+8yBjbkk=
X-Received: by 2002:a05:6000:288f:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-4606dbe5c41mr14337382f8f.40.1781464200783; 
 Sun, 14 Jun 2026 12:10:00 -0700 (PDT)
X-Received: by 2002:a05:6000:288f:b0:460:3234:4472 with SMTP id
 ffacd0b85a97d-4606dbe5c41mr14337339f8f.40.1781464200165; 
 Sun, 14 Jun 2026 12:10:00 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c3782sm23716815f8f.25.2026.06.14.12.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:59 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Gregory Price <gourry@gourry.net>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Jonathan Cameron <jic23@kernel.org>, linux-cxl@vger.kernel.org
Subject: [PULL 103/106] hw/cxl: Add a performant (and correct) path for the
 non interleaved cases
Message-ID: <c7f16b110a833482eb99a153cfb5c0c630338f65.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alireza Sanaee via qemu development <qemu-devel@nongnu.org>

The CXL address to device decoding logic is complex because of the need to
correctly decode fine grained interleave. The current implementation
prevents use with KVM where executed instructions may reside in that memory
and gives very slow performance even in TCG.

In many real cases non interleaved memory configurations are useful and for
those we can use a more conventional memory region alias allowing similar
performance to other memory in the system.

Whether this fast path is applicable can be established once the full set
of HDM decoders has been committed (in whatever order the guest decides to
commit them). As such a check is performed on each commit/uncommit of HDM
decoder to establish if the alias should be added or removed.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Co-developed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260318171918.146-4-alireza.sanaee@huawei.com>
---
 hw/cxl/cxl-component-utils.c |   6 ++
 hw/cxl/cxl-host.c            | 201 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c           |   4 +
 include/hw/cxl/cxl.h         |   1 +
 include/hw/cxl/cxl_device.h  |   4 +
 5 files changed, 216 insertions(+)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index 07aabe331c..a624357978 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -143,6 +143,12 @@ static void dumb_hdm_handler(CXLComponentState *cxl_cstate, hwaddr offset,
         value = FIELD_DP32(value, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
     }
     stl_le_p((uint8_t *)cache_mem + offset, value);
+
+    if (should_commit) {
+        cfmws_update_non_interleaved(true);
+    } else if (should_uncommit) {
+        cfmws_update_non_interleaved(false);
+    }
 }
 
 static void bi_handler(CXLComponentState *cxl_cstate, hwaddr offset,
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 2dc9f77007..7e744312f1 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -264,6 +264,207 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr,
     return d;
 }
 
+typedef struct CXLDirectPTState {
+    CXLType3Dev *ct3d;
+    hwaddr decoder_base;
+    hwaddr decoder_size;
+    hwaddr dpa_base;
+    unsigned int hdm_decoder_idx;
+} CXLDirectPTState;
+
+static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
+                                              CXLFixedWindow *fw)
+{
+    CXLType3Dev *ct3d = state->ct3d;
+    MemoryRegion *mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
+    MemoryRegion *direct_mr;
+    g_autofree char *direct_mr_name;
+    unsigned int idx = state->hdm_decoder_idx;
+
+    if (ct3d->hostvmem) {
+        MemoryRegion *vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+
+        vmr_size = memory_region_size(vmr);
+        if (state->dpa_base < vmr_size) {
+            mr = vmr;
+            offset = state->dpa_base;
+        }
+    }
+    if (!mr && ct3d->hostpmem) {
+        MemoryRegion *pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+
+        pmr_size = memory_region_size(pmr);
+        if (state->dpa_base - vmr_size < pmr_size) {
+            mr = pmr;
+            offset = state->dpa_base - vmr_size;
+        }
+    }
+    if (!mr) {
+        return;
+    }
+
+    if (ct3d->direct_mr_fw[idx]) {
+        return;
+    }
+
+    direct_mr = &ct3d->direct_mr[idx];
+    direct_mr_name = g_strdup_printf("cxl-direct-mapping-alias-%u", idx);
+    if (!direct_mr_name) {
+        return;
+    }
+
+    memory_region_init_alias(direct_mr, OBJECT(ct3d), direct_mr_name, mr,
+                             offset, state->decoder_size);
+    memory_region_transaction_begin();
+    memory_region_add_subregion(&fw->mr,
+                                state->decoder_base - fw->base, direct_mr);
+    memory_region_transaction_commit();
+    ct3d->direct_mr_fw[idx] = fw;
+}
+
+static void cxl_fmws_direct_passthrough_remove(CXLType3Dev *ct3d,
+                                               uint64_t decoder_base,
+                                               unsigned int idx)
+{
+    CXLFixedWindow *owner_fw = ct3d->direct_mr_fw[idx];
+    MemoryRegion *direct_mr = &ct3d->direct_mr[idx];
+
+    if (!owner_fw) {
+        return;
+    }
+
+    if (!memory_region_is_mapped(direct_mr)) {
+        return;
+    }
+
+    if (cxl_cfmws_find_device(owner_fw, decoder_base, false)) {
+        return;
+    }
+
+    memory_region_transaction_begin();
+    memory_region_del_subregion(&owner_fw->mr, direct_mr);
+    object_unparent(OBJECT(direct_mr));
+    memory_region_transaction_commit();
+    ct3d->direct_mr_fw[idx] = NULL;
+}
+
+static int cxl_fmws_direct_passthrough(Object *obj, void *opaque)
+{
+    CXLDirectPTState *state = opaque;
+    CXLFixedWindow *fw;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_FMW)) {
+        return 0;
+    }
+
+    fw = CXL_FMW(obj);
+
+    /* Verify not interleaved */
+    if (!cxl_cfmws_find_device(fw, state->decoder_base, false)) {
+        return 0;
+    }
+
+    cxl_fmws_direct_passthrough_setup(state, fw);
+
+    return 0;
+}
+
+static int update_non_interleaved(Object *obj, void *opaque)
+{
+    const int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
+    bool commit = *(bool *)opaque;
+    CXLType3Dev *ct3d;
+    uint32_t *cache_mem;
+    unsigned int hdm_count, i;
+    int interleave_ways_dec;
+    uint32_t cap;
+    uint64_t dpa_base = 0;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+
+    ct3d = CXL_TYPE3(obj);
+    cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
+    cap = ldl_le_p(cache_mem + R_CXL_HDM_DECODER_CAPABILITY);
+    hdm_count = cxl_decoder_count_dec(FIELD_EX32(cap,
+                                                 CXL_HDM_DECODER_CAPABILITY,
+                                                 DECODER_COUNT));
+    for (i = 0; i < hdm_count; i++) {
+        uint64_t decoder_base, decoder_size, skip;
+        uint32_t hdm_ctrl, low, high;
+        int iw, committed;
+
+        hdm_ctrl = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + i * hdm_inc);
+        committed = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED);
+
+        /*
+         * Optimization: Looking for a fully committed path; if the type 3 HDM
+         * decoder is not commmitted, it cannot lie on such a path.
+         */
+        if (commit && !committed) {
+            return 0;
+        }
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_LO +
+                       i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_DPA_SKIP_HI +
+                        i * hdm_inc);
+        skip = ((uint64_t)high << 32) | (low & 0xf0000000);
+        dpa_base += skip;
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc);
+        decoder_size = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        low = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_LO + i * hdm_inc);
+        high = ldl_le_p(cache_mem + R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc);
+        decoder_base = ((uint64_t)high << 32) | (low & 0xf0000000);
+
+        iw = FIELD_EX32(hdm_ctrl, CXL_HDM_DECODER0_CTRL, IW);
+
+        if (iw == 0) {
+            if (!commit) {
+                cxl_fmws_direct_passthrough_remove(ct3d, decoder_base, i);
+            } else {
+                CXLDirectPTState state = {
+                    .ct3d = ct3d,
+                    .decoder_base = decoder_base,
+                    .decoder_size = decoder_size,
+                    .dpa_base = dpa_base,
+                    .hdm_decoder_idx = i,
+                };
+
+                object_child_foreach_recursive(object_get_root(),
+                                               cxl_fmws_direct_passthrough,
+                                               &state);
+            }
+        }
+
+        interleave_ways_dec = cxl_interleave_ways_dec(iw, &error_fatal);
+        if (interleave_ways_dec == 0) {
+            return 0;
+        }
+
+        dpa_base += decoder_size / interleave_ways_dec;
+    }
+
+    return 0;
+}
+
+void cfmws_update_non_interleaved(bool commit)
+{
+    /*
+     * Walk endpoints to find both committed and uncommitted decoders,
+     * then check if they are not interleaved (but the path is fully set up).
+     */
+    object_child_foreach_recursive(object_get_root(),
+                                   update_non_interleaved, &commit);
+
+    return;
+}
+
 static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
                                   unsigned size, MemTxAttrs attrs)
 {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 03a5d1751f..cba05ec57d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -427,6 +427,8 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    cfmws_update_non_interleaved(true);
 }
 
 static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
@@ -442,6 +444,8 @@ static void hdm_decoder_uncommit(CXLType3Dev *ct3d, int which)
     ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 0);
 
     stl_le_p(cache_mem + R_CXL_HDM_DECODER0_CTRL + which * hdm_inc, ctrl);
+
+    cfmws_update_non_interleaved(false);
 }
 
 static int ct3d_qmp_uncor_err_to_cxl(CxlUncorErrorType qmp_err)
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 998f495a98..d8cd8359d2 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -71,4 +71,5 @@ CXLComponentState *cxl_usp_to_cstate(CXLUpstreamPort *usp);
 typedef struct CXLDownstreamPort CXLDownstreamPort;
 DECLARE_INSTANCE_CHECKER(CXLDownstreamPort, CXL_DSP, TYPE_CXL_DSP)
 
+void cfmws_update_non_interleaved(bool commit);
 #endif
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 393f312217..ba551fa5f9 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -685,6 +685,8 @@ typedef struct CXLSetFeatureInfo {
     size_t data_size;
 } CXLSetFeatureInfo;
 
+typedef struct CXLFixedWindow CXLFixedWindow;
+
 struct CXLSanitizeInfo;
 
 typedef struct CXLAlertConfig {
@@ -712,6 +714,8 @@ struct CXLType3Dev {
     uint64_t sn;
 
     /* State */
+    MemoryRegion direct_mr[CXL_HDM_DECODER_COUNT];
+    CXLFixedWindow *direct_mr_fw[CXL_HDM_DECODER_COUNT];
     AddressSpace hostvmem_as;
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
-- 
MST


