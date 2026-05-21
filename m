Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696C7CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3qI-0006OI-UX; Thu, 21 May 2026 09:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kees@kernel.org>) id 1wQ3Wt-0001lT-Lx
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:33:39 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kees@kernel.org>) id 1wQ3Wq-0005CF-Qr
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:33:39 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 33DD644634;
 Thu, 21 May 2026 13:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58EF1F00A3D;
 Thu, 21 May 2026 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779370407;
 bh=Z+Ub2Rsd9ANQzKOVawxbbCdlC+pecLG/P/kzOLcGitU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZpoUzNBkBmEW2LjaiIoOOC4s+n979icMv2wlmoYSc25V3dGNAjG0gbL9a5wg2u47P
 VMxYDF0mYXlyeJyFUXl8jiRf3bxPYJJCLvPOeZSAS7DGYujM6mps9FRxfnjPXWQxhX
 xRaSPhmPxfOjP6QLUe/QgXf9nn4rloFvMFaamf2Q86gUDNKjRzgCW+SsEmbE7ZNswt
 y17z+o7t1YKntzAEH8VfbQJr1zSboc8FGZbuD7YpeFtpKlorEPTAdUvz75ERJ5b83/
 QUEgdBC7DVG7whLHuJRPnbclLcdfN+VSV+tx+pv1gVT/04XqXEZRewE4Hdv/XUfpxv
 A6xTQa8PPiphg==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Petr Pavlu <petr.pavlu@suse.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Corey Minyard <corey@minyard.net>, Gabriel Somlo <somlo@cmu.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bart Van Assche <bvanassche@acm.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Hannes Reinecke <hare@suse.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
 Tiwei Bie <tiwei.btw@antgroup.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "David E. Box" <david.e.box@linux.intel.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Sean Christopherson <seanjc@google.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Johansen <john.johansen@canonical.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Georgia Garcia <georgia.garcia@canonical.com>, kvm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-modules@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-um@lists.infradead.org,
 linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
 qemu-devel@nongnu.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org,
 linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 07/11] moduleparam: Route DEFINE_KERNEL_PARAM_OPS get pointer
 via _Generic
Date: Thu, 21 May 2026 06:33:20 -0700
Message-Id: <20260521133326.2465264-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521133315.work.845-kees@kernel.org>
References: <20260521133315.work.845-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3477; i=kees@kernel.org;
 h=from:subject; bh=2lh9CsqKOjpmr9LD0n2okA9BehPWair2DlPnlZ1PFPc=;
 b=owGbwMvMwCVmps19z/KJym7G02pJDFn8nIvObEzOv8f9Ny7fU3+K4MU31w3MLlQyBTD1ZzTfl
 utOmiLfUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJH4IkaGFVpms4oL+z/8iFoh
 P+POhcufipWWltm+L/CUOcml8euoBcP/rN0OUi7qm2bpPqgPYTsts70rWLI43Obl45kHtE0r/7Q
 yAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=kees@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2026 09:52:46 -0400
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

Make the DEFINE_KERNEL_PARAM_OPS family route their _get argument to
either .get (struct seq_buf *) or .get_str (char *) at compile time
based on the pointer's actual function signature. Two helper macros
do the routing:

  _KERNEL_PARAM_OPS_GET     - return the pointer if it has the seq_buf
                              signature, otherwise NULL of that type
  _KERNEL_PARAM_OPS_GET_STR - mirror image for the char * signature

Both use _Generic; only the two valid function-pointer types are
listed, so any third-party type is a compile error rather than
silently falling through.

Now a callback whose body has been migrated from char * to struct
seq_buf * needs no change at its kernel_param_ops initialization site,
because the macro picks up the new type automatically and assigns to
the correct field.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/moduleparam.h | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index c52120f6ac28..795bc7c654ef 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -85,15 +85,32 @@ struct kernel_param_ops {
  *
  *   static DEFINE_KERNEL_PARAM_OPS(my_ops, my_set, my_get);
  *
- * Routing the @_set and @_get function pointers through the macro
- * (rather than naming the struct fields at every call site) lets the
- * field layout change in one place when callbacks are migrated to a
- * new signature.
+ * @_get may be either of:
+ *   int (*)(struct seq_buf *, const struct kernel_param *) (seq_buf)
+ *   int (*)(char *, const struct kernel_param *)           (legacy)
+ *
+ * The macro uses _Generic to route the function pointer to the
+ * matching field (.get or .get_str) at compile time, leaving the
+ * other field NULL. Each helper matches the wrong prototype signature
+ * and returns NULL, falling through to the default branch otherwise;
+ * if @_get has neither expected signature the assignment to the
+ * fields gets a normal compile-time type-mismatch error.
  */
+#define _KERNEL_PARAM_OPS_GET(_get)					\
+	_Generic((_get),						\
+	    int (*)(char *, const struct kernel_param *): NULL,		\
+	    default: (_get))
+
+#define _KERNEL_PARAM_OPS_GET_STR(_get)					\
+	_Generic((_get),						\
+	    int (*)(struct seq_buf *, const struct kernel_param *): NULL, \
+	    default: (_get))
+
 #define DEFINE_KERNEL_PARAM_OPS(_name, _set, _get)			\
 	const struct kernel_param_ops _name = {				\
 		.set = (_set),						\
-		.get_str = (_get),					\
+		.get = _KERNEL_PARAM_OPS_GET(_get),			\
+		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
 	}
 
 /* As DEFINE_KERNEL_PARAM_OPS, with KERNEL_PARAM_OPS_FL_NOARG set. */
@@ -101,14 +118,16 @@ struct kernel_param_ops {
 	const struct kernel_param_ops _name = {				\
 		.flags = KERNEL_PARAM_OPS_FL_NOARG,			\
 		.set = (_set),						\
-		.get_str = (_get),					\
+		.get = _KERNEL_PARAM_OPS_GET(_get),			\
+		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
 	}
 
 /* As DEFINE_KERNEL_PARAM_OPS, with an additional .free callback. */
 #define DEFINE_KERNEL_PARAM_OPS_FREE(_name, _set, _get, _free)		\
 	const struct kernel_param_ops _name = {				\
 		.set = (_set),						\
-		.get_str = (_get),					\
+		.get = _KERNEL_PARAM_OPS_GET(_get),			\
+		.get_str = _KERNEL_PARAM_OPS_GET_STR(_get),		\
 		.free = (_free),					\
 	}
 
-- 
2.34.1


