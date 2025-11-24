Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496ECCFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 14:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNXHH-0006a0-U9; Mon, 24 Nov 2025 09:10:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXHF-0006PQ-QO
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:10:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vNXHC-0006G1-W9
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 09:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763993444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5yJ8PxoT8H7+zF6GdksQTawu9q9r3V5y2yE3fDtfpjA=;
 b=IV0FlhqoV5S3AVAE9Oy5D6cDT38SlCdm5FzaV9KSK39YO3vXY/EeQZZWuIOs+6qy54zDLX
 a3VD+Cb3yuwiDyBx1DXMKThHenu/h14URQfHsCrn6O2VgJvvxCFW1FJcw6XR1MrDUlqBwH
 XIH6UYYPJgzmXhv27YkMHVpUnyZ/nI8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-sG2FOCS3Nb2Nu4oyjeHxIg-1; Mon, 24 Nov 2025 09:10:41 -0500
X-MC-Unique: sG2FOCS3Nb2Nu4oyjeHxIg-1
X-Mimecast-MFC-AGG-ID: sG2FOCS3Nb2Nu4oyjeHxIg_1763993441
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b233e206ddso1159480585a.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 06:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763993441; x=1764598241; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5yJ8PxoT8H7+zF6GdksQTawu9q9r3V5y2yE3fDtfpjA=;
 b=fPcokK9DW4y7D+O2u73L8SE6U2lJnN6wXGk4Qtfw41jSZ92aJzuo4BXVK3ZtwXbFjG
 aCqDLd9RDnnwRJTbtVaod6/Yy14RtKkLLowary00lsyk0uzLcI1Mffl4PJmfku1vqFKS
 wdhGAzvm+Gnp3zjyT604odVWWh4x1ngeB5wjVtCAaJH/wI5/df8FHQYKeCddb2XpEnhE
 WpZz73fv3toAGzgBQjW2uXj/vZx5WtyV3jil89p5afYibKYSS0a9p9ZunQS/k+Pr5FTM
 eRbEb5xlB/5chr+UyqEk2Uh0FMlgckrQJgGWYRhikNE7n2EDxF/8GtIhDswQIl7FRZb7
 ai9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763993441; x=1764598241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5yJ8PxoT8H7+zF6GdksQTawu9q9r3V5y2yE3fDtfpjA=;
 b=evoDDc9KohP7FtcT6Gz7J2WdtYBWwwiI279l3iicnnkR0Q+4/5uY7dFQWmM5rqOvOJ
 Tb8Oc2jok8hgyxBJOBwjq+0CX/ykaDf3qCCJXEUguJVGcn/0j3saAdOB8oCGmoOIK5Wn
 7vLZN19K/+VckjOXV47T+Na62Ac1XVsBCd2QTJF/maGF5/2wBp8MTH6zd5qJ09X0FYyM
 vkc+Kqpkjld1JyUlDnLE2ifoh6osm8iVHIsa36vqNMZlzA8v9qhZbyY2uFt5zR7OQv4Y
 AikZBfNNfyqjiG8EakgOUia/GtgBLXqMDm+5sKAjpg0vZ3sZb0VnSCS2vN6FGukjAd0t
 3fMg==
X-Gm-Message-State: AOJu0YyzZmMxmLvvp1a5jtBaDgp0pblwB4MLa7HJ9hrnUpVwewIvmvGp
 aHSMPonQ0g1yo1ibae/QGsXGff4tngGyGlv2P6N2d7u1CYVC9sAYclYjYAQnkfxXpm9e4q4Fmks
 X4WRLTzLsePtvjhBqbFnezbIonTS7Zb6kAx0QJNawthzlZ6Kd+wEvChf6
X-Gm-Gg: ASbGncsms6d38IkJSzkKIovp6EQsMrDwwZsy2HH+nAsiErfcc0a/nOJzlGDyQ828BiJ
 sb/cuCXAYFCixIw0AbiQ8/GUtBH4M1k4d4Gjq9JTD2OSlfC+A3UPkyjWMIGVK9zEZxpBQWtNb4y
 yBSiYDCyhYZUyEoGvAM9RtLcZdiT725ereZviIU75nD6IuxPGNzR5YGQZ0lP9X4V2tVZbUonH/N
 1fUPLEliQJ6lBfK90x68DtcfBG6XpXuaWKhR81Kh/FpzlTnEXy/cGRSyHFJMRd7NjDfA1PTfeeg
 ugJauVrDwBKm6MfgZMG/94PEHPHoyuyKVlNf02tnkpjQSczNfw4wWG9Vs4qktKrOKEJsoCGgU4o
 Pt6fm5LbyqpQ5fzkiEHLs4ZWLbHhasYqs5ZRvYl9WczOh5TxbjT1eR9E3LYEi+g==
X-Received: by 2002:a05:620a:3194:b0:8a1:21a6:e054 with SMTP id
 af79cd13be357-8b33d23b160mr1496738185a.4.1763993441213; 
 Mon, 24 Nov 2025 06:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpSI87bRGrCUBBSc/vIiKKyeBZ8n81uvsYR5PmgPsFK3r+YnmvElkAMKMlgFVBAt0NbNViTw==
X-Received: by 2002:a05:620a:3194:b0:8a1:21a6:e054 with SMTP id
 af79cd13be357-8b33d23b160mr1496733385a.4.1763993440716; 
 Mon, 24 Nov 2025 06:10:40 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it.
 [87.12.139.91]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b3295c13c1sm955152585a.28.2025.11.24.06.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 06:10:40 -0800 (PST)
Date: Mon, 24 Nov 2025 15:10:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] igvm: make igvm-cfg object resetable
Message-ID: <msdqn2nscnmztk3aodzl2mpfr3tpvxdogjz4axmhuulvoujisz@givarxxkwjbi>
References: <20251118122133.1695767-1-kraxel@redhat.com>
 <20251118122133.1695767-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251118122133.1695767-2-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In the title:

s/resetable/resettable

On Tue, Nov 18, 2025 at 01:21:29PM +0100, Gerd Hoffmann wrote:
>Add TYPE_RESETTABLE_INTERFACE to interfaces.  Register callbacks for the
>reset phases.  Add trace points for logging and debugging.  No
>functional change, that will come in followup patches.
>
>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> include/system/igvm-cfg.h |  2 ++
> backends/igvm-cfg.c       | 36 +++++++++++++++++++++++++++++++++++-
> backends/trace-events     |  5 +++++
> 3 files changed, 42 insertions(+), 1 deletion(-)

The rest LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
>index 944f23a814dd..312f77c092b0 100644
>--- a/include/system/igvm-cfg.h
>+++ b/include/system/igvm-cfg.h
>@@ -13,6 +13,7 @@
> #define QEMU_IGVM_CFG_H
>
> #include "qom/object.h"
>+#include "hw/resettable.h"
>
> typedef struct IgvmCfg {
>     ObjectClass parent_class;
>@@ -23,6 +24,7 @@ typedef struct IgvmCfg {
>      *           format.
>      */
>     char *filename;
>+    ResettableState reset_state;
> } IgvmCfg;
>
> typedef struct IgvmCfgClass {
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index d00acf351249..4e3ef88ffc27 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -13,8 +13,11 @@
>
> #include "system/igvm-cfg.h"
> #include "system/igvm.h"
>+#include "system/reset.h"
> #include "qom/object_interfaces.h"
>
>+#include "trace.h"
>+
> static char *get_igvm(Object *obj, Error **errp)
> {
>     IgvmCfg *igvm = IGVM_CFG(obj);
>@@ -28,24 +31,55 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
>     igvm->filename = g_strdup(value);
> }
>
>+static ResettableState *igvm_reset_state(Object *obj)
>+{
>+    IgvmCfg *igvm = IGVM_CFG(obj);
>+    return &igvm->reset_state;
>+}
>+
>+static void igvm_reset_enter(Object *obj, ResetType type)
>+{
>+    trace_igvm_reset_enter(type);
>+}
>+
>+static void igvm_reset_hold(Object *obj, ResetType type)
>+{
>+    trace_igvm_reset_hold(type);
>+}
>+
>+static void igvm_reset_exit(Object *obj, ResetType type)
>+{
>+    trace_igvm_reset_exit(type);
>+}
>+
> OBJECT_DEFINE_TYPE_WITH_INTERFACES(IgvmCfg, igvm_cfg, IGVM_CFG, OBJECT,
>-                                   { TYPE_USER_CREATABLE }, { NULL })
>+                                   { TYPE_USER_CREATABLE },
>+                                   { TYPE_RESETTABLE_INTERFACE },
>+                                   { NULL })
>
> static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
> {
>     IgvmCfgClass *igvmc = IGVM_CFG_CLASS(oc);
>+    ResettableClass *rc = RESETTABLE_CLASS(oc);
>
>     object_class_property_add_str(oc, "file", get_igvm, set_igvm);
>     object_class_property_set_description(oc, "file",
>                                           "Set the IGVM filename to use");
>
>     igvmc->process = qigvm_process_file;
>+
>+    rc->get_state = igvm_reset_state;
>+    rc->phases.enter = igvm_reset_enter;
>+    rc->phases.hold = igvm_reset_hold;
>+    rc->phases.exit = igvm_reset_exit;
> }
>
> static void igvm_cfg_init(Object *obj)
> {
>+    qemu_register_resettable(obj);
> }
>
> static void igvm_cfg_finalize(Object *obj)
> {
>+    qemu_unregister_resettable(obj);
> }
>diff --git a/backends/trace-events b/backends/trace-events
>index 56132d3fd22b..45ac46dc2454 100644
>--- a/backends/trace-events
>+++ b/backends/trace-events
>@@ -21,3 +21,8 @@ iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%
> iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
> iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
> iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
>+
>+# igvm-cfg.c
>+igvm_reset_enter(int type) "type=%u"
>+igvm_reset_hold(int type) "type=%u"
>+igvm_reset_exit(int type) "type=%u"
>-- 
>2.51.1
>


