Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CCECD1283
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 03:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpJcU-0001wz-GP; Tue, 26 Mar 2024 23:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rpJcS-0001wS-Ex
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:06:28 -0400
Received: from fout3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marmarek@invisiblethingslab.com>)
 id 1rpJcR-0004Wz-2L
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 23:06:28 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id 73D7713800CD;
 Tue, 26 Mar 2024 23:06:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 26 Mar 2024 23:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 invisiblethingslab.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1711508786; x=1711595186; bh=mH7qGKH3fb
 CivyC7O2Hbv2OPHkXyD7Im69azzuDMjbE=; b=ZOf9lyc6/HjY/wuJnLbLX2/GwE
 qfPsmb3WdAfan/JK7nNyrDQP5q6PnCDsFHyaLmzJ3zbXLXxnEqMa6lVrfZ3elMjg
 fekxlhfHdxlT7X5ik8oOmBMG702yFK3Fq0aa7MBaFxSgqxAYzqgHaDm25+HwTxON
 LwccVvhRoHocKX622oE87/9bINdRO8OuFUn0FuK4zp9OoTiLqUO2HmJbV7m560vF
 AArUt37PO3QVH6Ucixr34asDAOLv/rqPHDttCsN2O3lWl7aJ83/0Tl0DISGlSQ/G
 vfooRoNQn76qUTWFQSk95LWXcrU13DxyITj/i0ab7kUmZr0pKkAfe9X50T/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711508786; x=
 1711595186; bh=mH7qGKH3fbCivyC7O2Hbv2OPHkXyD7Im69azzuDMjbE=; b=n
 e3hzTjafh0pQimzREXXjk4LxZqrkNunjuhCA9UwpwTfpDFt6BYsC7eRNo3Pm2gVU
 T9Gl6zemCY5luFdxvXaehc862Ik/eEflHH0VF4trhtAmDu16iW8zaCVGI6LCUVy8
 l0ViZKriTCHtgKx1b2JZP62y0jzuxadjgAdNViWY8g+CnInOYw3ZbCNZH9tSoUJI
 /b10Lx2SXEdFaC5JwU5VDXK5LcOIrTnmK8DI56mKTmjDcolnsQxl0QWoh+5N9sl5
 YevkOOcJsBXcZ08zIaGuFvFhKMuxHYxmsauyyA5a8N/UfbzwDqMr/FfKG8zwgQRX
 TKvapsNXH5GuDIZkhuy6A==
X-ME-Sender: <xms:MY0DZhKuI7yUsOyDEfy6j-84ENrfBoT0RH0fZWuMxarBn4dvXQ0keg>
 <xme:MY0DZtJlI4arqU6pMh_XheXHyCUnD_ijcwSh6GiCUmZDvmW6wxqxc_J8xKYdrdzEi
 8z1HMI8bgFTDA>
X-ME-Received: <xmr:MY0DZptehdtUn7KU4swaQyd5ykHrZFqpuHavwCM-_guSHKqThW5yNhBvtisKrq75FNnhcWbo5eLQcPGq6BeRUTFS8CjJvnicLnLvMvFhoo9zKkN5WAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgheeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforghr
 vghkucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesih
 hnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpefg
 ueduhefgvdefheehudejheefudevueeghfekhfehleegveduteeuiedugffgffenucevlh
 hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghrmhgrrhgv
 khesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:Mo0DZib2jzD1Um_BjMVpKPIV1rPQ0ilBlB4411Zq5BmsvNqQNy_K_Q>
 <xmx:Mo0DZoa2vR8Mu19ip-g6SA7y2NnbAeaWWCtLCvxTqGiPqUFnwLGGUA>
 <xmx:Mo0DZmC3Me4IlH2JtSLC3gmmtkKvO56Tv3vh6Y_5xtoDZXVFUuDjnQ>
 <xmx:Mo0DZmblCNVCpDPUmPPZxT_VUw6QrxkwPFeyLs7nmVNxApMeKaEE1A>
 <xmx:Mo0DZiBiJDTMDcoPuxI5mcvjNJtag92ejgFlslpHTq3rFJByNQu0fA>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Mar 2024 23:06:24 -0400 (EDT)
From: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org (open list:X86 Xen CPUs)
Subject: [PATCH v3 1/2] hw/xen: detect when running inside stubdomain
Date: Wed, 27 Mar 2024 04:05:14 +0100
Message-ID: <e66aa97dca5120f22e015c19710b2ff04f525720.1711506237.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.527f002866de2be7c275c5000b6e5edfeb7e8368.1711506237.git-series.marmarek@invisiblethingslab.com>
References: <cover.527f002866de2be7c275c5000b6e5edfeb7e8368.1711506237.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=103.168.172.146;
 envelope-from=marmarek@invisiblethingslab.com;
 helo=fout3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Introduce global xen_is_stubdomain variable when qemu is running inside
a stubdomain instead of dom0. This will be relevant for subsequent
patches, as few things like accessing PCI config space need to be done
differently.

Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
Changes in v3:
- move to xen_hvm_init_pc()
- coding style
Changes in v2:
- use sigend int for domid to match xenstore_read_int() types
- fix code style
---
 hw/i386/xen/xen-hvm.c | 22 ++++++++++++++++++++++
 include/hw/xen/xen.h  |  1 +
 system/globals.c      |  1 +
 3 files changed, 24 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 7745cb3..3291c17 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -583,6 +583,26 @@ static void xen_wakeup_notifier(Notifier *notifier, void *data)
     xc_set_hvm_param(xen_xc, xen_domid, HVM_PARAM_ACPI_S_STATE, 0);
 }
 
+static bool xen_check_stubdomain(struct xs_handle *xsh)
+{
+    char *dm_path = g_strdup_printf(
+        "/local/domain/%d/image/device-model-domid", xen_domid);
+    char *val;
+    int32_t dm_domid;
+    bool is_stubdom = false;
+
+    val = xs_read(xsh, 0, dm_path, NULL);
+    if (val) {
+        if (sscanf(val, "%d", &dm_domid) == 1) {
+            is_stubdom = dm_domid != 0;
+        }
+        free(val);
+    }
+
+    g_free(dm_path);
+    return is_stubdom;
+}
+
 void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     MachineState *ms = MACHINE(pcms);
@@ -595,6 +615,8 @@ void xen_hvm_init_pc(PCMachineState *pcms, MemoryRegion **ram_memory)
 
     xen_register_ioreq(state, max_cpus, &xen_memory_listener);
 
+    xen_is_stubdomain = xen_check_stubdomain(state->xenstore);
+
     QLIST_INIT(&xen_physmap);
     xen_read_physmap(state);
 
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 37ecc91..ecb89ec 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -36,6 +36,7 @@ enum xen_mode {
 extern uint32_t xen_domid;
 extern enum xen_mode xen_mode;
 extern bool xen_domid_restrict;
+extern bool xen_is_stubdomain;
 
 int xen_pci_slot_get_pirq(PCIDevice *pci_dev, int irq_num);
 int xen_set_pci_link_route(uint8_t link, uint8_t irq);
diff --git a/system/globals.c b/system/globals.c
index e353584..d602a04 100644
--- a/system/globals.c
+++ b/system/globals.c
@@ -60,6 +60,7 @@ bool qemu_uuid_set;
 uint32_t xen_domid;
 enum xen_mode xen_mode = XEN_DISABLED;
 bool xen_domid_restrict;
+bool xen_is_stubdomain;
 struct evtchn_backend_ops *xen_evtchn_ops;
 struct gnttab_backend_ops *xen_gnttab_ops;
 struct foreignmem_backend_ops *xen_foreignmem_ops;
-- 
git-series 0.9.1

