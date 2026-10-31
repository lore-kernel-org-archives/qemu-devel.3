Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A08606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nyt3DTQ0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xN4YX-0006hY-Kv; Sat, 31 Oct 2026 04:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xN4YB-0006YD-9U
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xN4Y8-0002IY-JZ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 04:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793435691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6IGnbNPJmyK+xecrnyShy4W/pad3F+iU/p6esKNX9Y8=;
 b=Nyt3DTQ09mYp+vpprjf2uj7AUmSKPPAWbpR55i3njs1xzbKpjE9Gy5JbZN3V3FAZkqQK2E
 w1SnVGmh3JhLE8L83YudgiLjz2eHWKclGNsXKvP73jaLFwjjyk9Vb4IszW2MzBAX5BHJdV
 0/iMH40GupIBfmwY5zS3ILF5gvzpQ6E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-DY46iF9cPnGt6_8CF1atcw-1; Sat,
 31 Oct 2026 04:34:44 -0400
X-MC-Unique: DY46iF9cPnGt6_8CF1atcw-1
X-Mimecast-MFC-AGG-ID: DY46iF9cPnGt6_8CF1atcw_1793435683
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B51A1800656
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 08:34:43 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCABB1956087
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 08:34:42 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] xen: require Xen 4.11.0 or later
Date: Sat, 31 Oct 2026 09:34:40 +0100
Message-ID: <20261031083440.1310849-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Xen 4.11 was released on July 10, 2018.  Require it to clean up
code that deals with old versions that lacked utility libraries.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                 |  44 ++------
 include/hw/xen/xen_native.h | 215 +-----------------------------------
 hw/xen/xen-operations.c     |   5 -
 scripts/xen-detect.c        | 152 +++----------------------
 4 files changed, 26 insertions(+), 390 deletions(-)

diff --git a/meson.build b/meson.build
index d18677e026a..8ab378e7b1b 100644
--- a/meson.build
+++ b/meson.build
@@ -975,7 +975,7 @@ endif
 xen = not_found
 if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
   xencontrol = dependency('xencontrol', required: false,
-                          method: 'pkg-config')
+                          version: '>=4.11.0', method: 'pkg-config')
   if xencontrol.found()
     xen_pc = declare_dependency(version: xencontrol.version(),
       dependencies: [
@@ -996,45 +996,23 @@ if get_option('xen').enabled() or (get_option('xen').auto() and have_system)
         dependency('xendevicemodel', required: false,
                    method: 'pkg-config',
                    disabler: true),
-        # optional, no "disabler: true"
         dependency('xentoolcore', required: false,
-                   method: 'pkg-config')])
+                   method: 'pkg-config',
+                   disabler: true)])
     if xen_pc.found()
       xen = xen_pc
     endif
   endif
   if not xen.found()
-    xen_tests = [ '4.11.0', '4.10.0', '4.9.0', '4.8.0', '4.7.1' ]
-    xen_libs = {
-      '4.11.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
-      '4.10.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ],
-      '4.9.0': [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
-      '4.8.0': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
-      '4.7.1': [ 'xenstore', 'xenctrl', 'xenforeignmemory', 'xengnttab', 'xenevtchn' ],
-    }
-    xen_deps = {}
-    foreach ver: xen_tests
-      # cache the various library tests to avoid polluting the logs
-      xen_test_deps = []
-      foreach l: xen_libs[ver]
-        if l not in xen_deps
-          xen_deps += { l: cc.find_library(l, required: false) }
-        endif
-        xen_test_deps += xen_deps[l]
-      endforeach
-
-      # Use -D to pick just one of the test programs in scripts/xen-detect.c
-      xen_version = ver.split('.')
-      xen_ctrl_version = xen_version[0] + \
-        ('0' + xen_version[1]).substring(-2) + \
-        ('0' + xen_version[2]).substring(-2)
-      if cc.links(files('scripts/xen-detect.c'),
-                  args: '-DCONFIG_XEN_CTRL_INTERFACE_VERSION=' + xen_ctrl_version,
-                  dependencies: xen_test_deps)
-        xen = declare_dependency(version: ver, dependencies: xen_test_deps)
-        break
-      endif
+    xen_test_deps = []
+    foreach l: [ 'xenstore', 'xenctrl', 'xendevicemodel', 'xenforeignmemory', 'xengnttab', 'xenevtchn', 'xentoolcore' ]
+      xen_test_deps += cc.find_library(l, required: get_option('xen'))
     endforeach
+
+    # Use -D to pick just one of the test programs in scripts/xen-detect.c
+    if cc.links(files('scripts/xen-detect.c'), dependencies: xen_test_deps)
+      xen = declare_dependency(version: '4.11.0', dependencies: xen_test_deps)
+    endif
   endif
   if xen.found()
     accelerators += 'CONFIG_XEN'
diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 5caf91a6162..260148ceabb 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -24,231 +24,18 @@
 extern xc_interface *xen_xc;
 
 /*
- * We don't support Xen prior to 4.7.1.
+ * We don't support Xen prior to 4.11.0.
  */
 
 #include <xenforeignmemory.h>
 
 extern xenforeignmemory_handle *xen_fmem;
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
-
-typedef xc_interface xendevicemodel_handle;
-
-#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40900 */
-
 #undef XC_WANT_COMPAT_DEVICEMODEL_API
 #include <xendevicemodel.h>
 
-#endif
-
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41100
-
-static inline int xendevicemodel_relocate_memory(
-    xendevicemodel_handle *dmod, domid_t domid, uint32_t size, uint64_t src_gfn,
-    uint64_t dst_gfn)
-{
-    uint32_t i;
-    int rc;
-
-    for (i = 0; i < size; i++) {
-        unsigned long idx = src_gfn + i;
-        xen_pfn_t gpfn = dst_gfn + i;
-
-        rc = xc_domain_add_to_physmap(xen_xc, domid, XENMAPSPACE_gmfn, idx,
-                                      gpfn);
-        if (rc) {
-            return rc;
-        }
-    }
-
-    return 0;
-}
-
-static inline int xendevicemodel_pin_memory_cacheattr(
-    xendevicemodel_handle *dmod, domid_t domid, uint64_t start, uint64_t end,
-    uint32_t type)
-{
-    return xc_domain_pin_memory_cacheattr(xen_xc, domid, start, end, type);
-}
-
-typedef void xenforeignmemory_resource_handle;
-
-#define XENMEM_resource_ioreq_server 0
-
-#define XENMEM_resource_ioreq_server_frame_bufioreq 0
-#define XENMEM_resource_ioreq_server_frame_ioreq(n) (1 + (n))
-
-static inline xenforeignmemory_resource_handle *xenforeignmemory_map_resource(
-    xenforeignmemory_handle *fmem, domid_t domid, unsigned int type,
-    unsigned int id, unsigned long frame, unsigned long nr_frames,
-    void **paddr, int prot, int flags)
-{
-    errno = EOPNOTSUPP;
-    return NULL;
-}
-
-static inline int xenforeignmemory_unmap_resource(
-    xenforeignmemory_handle *fmem, xenforeignmemory_resource_handle *fres)
-{
-    return 0;
-}
-
-#endif /* CONFIG_XEN_CTRL_INTERFACE_VERSION < 41100 */
-
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 41000
-
-#define XEN_COMPAT_PHYSMAP
-static inline void *xenforeignmemory_map2(xenforeignmemory_handle *h,
-                                          uint32_t dom, void *addr,
-                                          int prot, int flags, size_t pages,
-                                          const xen_pfn_t arr[/*pages*/],
-                                          int err[/*pages*/])
-{
-    assert(addr == NULL && flags == 0);
-    return xenforeignmemory_map(h, dom, prot, pages, arr, err);
-}
-
-static inline int xentoolcore_restrict_all(domid_t domid)
-{
-    errno = ENOTTY;
-    return -1;
-}
-
-static inline int xendevicemodel_shutdown(xendevicemodel_handle *dmod,
-                                          domid_t domid, unsigned int reason)
-{
-    errno = ENOTTY;
-    return -1;
-}
-
-#else /* CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41000 */
-
 #include <xentoolcore.h>
 
-#endif
-
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION < 40900
-
-static inline xendevicemodel_handle *xendevicemodel_open(
-    struct xentoollog_logger *logger, unsigned int open_flags)
-{
-    return xen_xc;
-}
-
-static inline int xendevicemodel_create_ioreq_server(
-    xendevicemodel_handle *dmod, domid_t domid, int handle_bufioreq,
-    ioservid_t *id)
-{
-    return xc_hvm_create_ioreq_server(dmod, domid, handle_bufioreq,
-                                      id);
-}
-
-static inline int xendevicemodel_get_ioreq_server_info(
-    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
-    xen_pfn_t *ioreq_pfn, xen_pfn_t *bufioreq_pfn,
-    evtchn_port_t *bufioreq_port)
-{
-    return xc_hvm_get_ioreq_server_info(dmod, domid, id, ioreq_pfn,
-                                        bufioreq_pfn, bufioreq_port);
-}
-
-static inline int xendevicemodel_map_io_range_to_ioreq_server(
-    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int is_mmio,
-    uint64_t start, uint64_t end)
-{
-    return xc_hvm_map_io_range_to_ioreq_server(dmod, domid, id, is_mmio,
-                                               start, end);
-}
-
-static inline int xendevicemodel_unmap_io_range_from_ioreq_server(
-    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int is_mmio,
-    uint64_t start, uint64_t end)
-{
-    return xc_hvm_unmap_io_range_from_ioreq_server(dmod, domid, id, is_mmio,
-                                                   start, end);
-}
-
-static inline int xendevicemodel_map_pcidev_to_ioreq_server(
-    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
-    uint16_t segment, uint8_t bus, uint8_t device, uint8_t function)
-{
-    return xc_hvm_map_pcidev_to_ioreq_server(dmod, domid, id, segment,
-                                             bus, device, function);
-}
-
-static inline int xendevicemodel_unmap_pcidev_from_ioreq_server(
-    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id,
-    uint16_t segment, uint8_t bus, uint8_t device, uint8_t function)
-{
-    return xc_hvm_unmap_pcidev_from_ioreq_server(dmod, domid, id, segment,
-                                                 bus, device, function);
-}
-
-static inline int xendevicemodel_destroy_ioreq_server(
-    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id)
-{
-    return xc_hvm_destroy_ioreq_server(dmod, domid, id);
-}
-
-static inline int xendevicemodel_set_ioreq_server_state(
-    xendevicemodel_handle *dmod, domid_t domid, ioservid_t id, int enabled)
-{
-    return xc_hvm_set_ioreq_server_state(dmod, domid, id, enabled);
-}
-
-static inline int xendevicemodel_set_pci_intx_level(
-    xendevicemodel_handle *dmod, domid_t domid, uint16_t segment,
-    uint8_t bus, uint8_t device, uint8_t intx, unsigned int level)
-{
-    return xc_hvm_set_pci_intx_level(dmod, domid, segment, bus, device,
-                                     intx, level);
-}
-
-static inline int xendevicemodel_set_isa_irq_level(
-    xendevicemodel_handle *dmod, domid_t domid, uint8_t irq,
-    unsigned int level)
-{
-    return xc_hvm_set_isa_irq_level(dmod, domid, irq, level);
-}
-
-static inline int xendevicemodel_set_pci_link_route(
-    xendevicemodel_handle *dmod, domid_t domid, uint8_t link, uint8_t irq)
-{
-    return xc_hvm_set_pci_link_route(dmod, domid, link, irq);
-}
-
-static inline int xendevicemodel_inject_msi(
-    xendevicemodel_handle *dmod, domid_t domid, uint64_t msi_addr,
-    uint32_t msi_data)
-{
-    return xc_hvm_inject_msi(dmod, domid, msi_addr, msi_data);
-}
-
-static inline int xendevicemodel_track_dirty_vram(
-    xendevicemodel_handle *dmod, domid_t domid, uint64_t first_pfn,
-    uint32_t nr, unsigned long *dirty_bitmap)
-{
-    return xc_hvm_track_dirty_vram(dmod, domid, first_pfn, nr,
-                                   dirty_bitmap);
-}
-
-static inline int xendevicemodel_modified_memory(
-    xendevicemodel_handle *dmod, domid_t domid, uint64_t first_pfn,
-    uint32_t nr)
-{
-    return xc_hvm_modified_memory(dmod, domid, first_pfn, nr);
-}
-
-static inline int xendevicemodel_set_mem_type(
-    xendevicemodel_handle *dmod, domid_t domid, hvmmem_type_t mem_type,
-    uint64_t first_pfn, uint32_t nr)
-{
-    return xc_hvm_set_mem_type(dmod, domid, mem_type, first_pfn, nr);
-}
-
-#endif
-
 extern xendevicemodel_handle *xen_dmod;
 
 static inline int xen_set_mem_type(domid_t domid, hvmmem_type_t type,
diff --git a/hw/xen/xen-operations.c b/hw/xen/xen-operations.c
index e00983ec447..d4b177e17e0 100644
--- a/hw/xen/xen-operations.c
+++ b/hw/xen/xen-operations.c
@@ -89,8 +89,6 @@ done:
     return rc;
 }
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40800
-
 static int libxengnttab_backend_grant_copy(xengnttab_handle *xgt,
                                            bool to_domain, uint32_t domid,
                                            XenGrantCopySegment *segs,
@@ -149,7 +147,6 @@ done:
     g_free(xengnttab_segs);
     return rc;
 }
-#endif
 
 static xenevtchn_handle *libxenevtchn_backend_open(void)
 {
@@ -406,7 +403,6 @@ struct xenstore_backend_ops libxenstore_backend_ops = {
 
 void setup_xen_backend_ops(void)
 {
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 40800
     xengnttab_handle *xgt = xengnttab_open(NULL, 0);
 
     if (xgt) {
@@ -415,7 +411,6 @@ void setup_xen_backend_ops(void)
         }
         xengnttab_close(xgt);
     }
-#endif
     xen_evtchn_ops = &libxenevtchn_backend_ops;
     xen_gnttab_ops = &libxengnttab_backend_ops;
     xen_foreignmem_ops = &libxenforeignmem_backend_ops;
diff --git a/scripts/xen-detect.c b/scripts/xen-detect.c
index db049e605cf..8c4f02fa3f6 100644
--- a/scripts/xen-detect.c
+++ b/scripts/xen-detect.c
@@ -1,143 +1,19 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
-/* Test programs for various Xen versions that QEMU supports.  */
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION == 41100
-  #undef XC_WANT_COMPAT_DEVICEMODEL_API
-  #define __XEN_TOOLS__
-  #include <xendevicemodel.h>
-  #include <xenforeignmemory.h>
-  int main(void) {
-    xendevicemodel_handle *xd;
-    xenforeignmemory_handle *xfmem;
+/* Test programs for Xen 4.11.0+.  */
+#undef XC_WANT_COMPAT_DEVICEMODEL_API
+#define __XEN_TOOLS__
+#include <xendevicemodel.h>
+#include <xenforeignmemory.h>
+int main(void) {
+  xendevicemodel_handle *xd;
+  xenforeignmemory_handle *xfmem;
 
-    xd = xendevicemodel_open(0, 0);
-    xendevicemodel_pin_memory_cacheattr(xd, 0, 0, 0, 0);
+  xd = xendevicemodel_open(0, 0);
+  xendevicemodel_pin_memory_cacheattr(xd, 0, 0, 0, 0);
 
-    xfmem = xenforeignmemory_open(0, 0);
-    xenforeignmemory_map_resource(xfmem, 0, 0, 0, 0, 0, NULL, 0, 0);
+  xfmem = xenforeignmemory_open(0, 0);
+  xenforeignmemory_map_resource(xfmem, 0, 0, 0, 0, 0, NULL, 0, 0);
 
-    return 0;
-  }
-
-#elif CONFIG_XEN_CTRL_INTERFACE_VERSION == 41000
-  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
-  #include <xenforeignmemory.h>
-  #include <xentoolcore.h>
-  int main(void) {
-    xenforeignmemory_handle *xfmem;
-
-    xfmem = xenforeignmemory_open(0, 0);
-    xenforeignmemory_map2(xfmem, 0, 0, 0, 0, 0, 0, 0);
-    xentoolcore_restrict_all(0);
-
-    return 0;
-  }
-
-#elif CONFIG_XEN_CTRL_INTERFACE_VERSION == 40900
-  #undef XC_WANT_COMPAT_DEVICEMODEL_API
-  #define __XEN_TOOLS__
-  #include <xendevicemodel.h>
-  int main(void) {
-    xendevicemodel_handle *xd;
-
-    xd = xendevicemodel_open(0, 0);
-    xendevicemodel_close(xd);
-
-    return 0;
-  }
-
-#elif CONFIG_XEN_CTRL_INTERFACE_VERSION == 40800
-  /*
-   * If we have stable libs the we don't want the libxc compat
-   * layers, regardless of what CFLAGS we may have been given.
-   *
-   * Also, check if xengnttab_grant_copy_segment_t is defined and
-   * grant copy operation is implemented.
-   */
-  #undef XC_WANT_COMPAT_EVTCHN_API
-  #undef XC_WANT_COMPAT_GNTTAB_API
-  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
-  #include <xenctrl.h>
-  #include <xenstore.h>
-  #include <xenevtchn.h>
-  #include <xengnttab.h>
-  #include <xenforeignmemory.h>
-  #include <stdint.h>
-  #include <xen/hvm/hvm_info_table.h>
-  #if !defined(HVM_MAX_VCPUS)
-  # error HVM_MAX_VCPUS not defined
-  #endif
-  int main(void) {
-    xc_interface *xc = NULL;
-    xenforeignmemory_handle *xfmem;
-    xenevtchn_handle *xe;
-    xengnttab_handle *xg;
-    xengnttab_grant_copy_segment_t* seg = NULL;
-
-    xs_daemon_open();
-
-    xc = xc_interface_open(0, 0, 0);
-    xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-    xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-    xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-    xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-
-    xfmem = xenforeignmemory_open(0, 0);
-    xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
-
-    xe = xenevtchn_open(0, 0);
-    xenevtchn_fd(xe);
-
-    xg = xengnttab_open(0, 0);
-    xengnttab_grant_copy(xg, 0, seg);
-
-    return 0;
-  }
-
-#elif CONFIG_XEN_CTRL_INTERFACE_VERSION == 40701
-  /*
-   * If we have stable libs the we don't want the libxc compat
-   * layers, regardless of what CFLAGS we may have been given.
-   */
-  #undef XC_WANT_COMPAT_EVTCHN_API
-  #undef XC_WANT_COMPAT_GNTTAB_API
-  #undef XC_WANT_COMPAT_MAP_FOREIGN_API
-  #include <xenctrl.h>
-  #include <xenstore.h>
-  #include <xenevtchn.h>
-  #include <xengnttab.h>
-  #include <xenforeignmemory.h>
-  #include <stdint.h>
-  #include <xen/hvm/hvm_info_table.h>
-  #if !defined(HVM_MAX_VCPUS)
-  # error HVM_MAX_VCPUS not defined
-  #endif
-  int main(void) {
-    xc_interface *xc = NULL;
-    xenforeignmemory_handle *xfmem;
-    xenevtchn_handle *xe;
-    xengnttab_handle *xg;
-
-    xs_daemon_open();
-
-    xc = xc_interface_open(0, 0, 0);
-    xc_hvm_set_mem_type(0, 0, HVMMEM_ram_ro, 0, 0);
-    xc_domain_add_to_physmap(0, 0, XENMAPSPACE_gmfn, 0, 0);
-    xc_hvm_inject_msi(xc, 0, 0xf0000000, 0x00000000);
-    xc_hvm_create_ioreq_server(xc, 0, HVM_IOREQSRV_BUFIOREQ_ATOMIC, NULL);
-
-    xfmem = xenforeignmemory_open(0, 0);
-    xenforeignmemory_map(xfmem, 0, 0, 0, 0, 0);
-
-    xe = xenevtchn_open(0, 0);
-    xenevtchn_fd(xe);
-
-    xg = xengnttab_open(0, 0);
-    xengnttab_map_grant_ref(xg, 0, 0, 0);
-
-    return 0;
-  }
-
-#else
-#error invalid CONFIG_XEN_CTRL_INTERFACE_VERSION
-#endif
+  return 0;
+}
-- 
2.56.0


