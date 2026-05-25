Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771D8CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 14:30:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRWJM-0000Ez-UB; Mon, 25 May 2026 10:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wRWJK-0000Eo-Pt
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wRWJH-0001z5-Ae
 for qemu-devel@nongnu.org; Mon, 25 May 2026 10:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779719377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eGJuMgn1DdTEV+yMNrKJpD671bt2NQfQhiNmsvrl3Wo=;
 b=UNYT/W64+5suVsEafchGxVe8pGUWn+oZ6xZRhPE5ensZtB0NWzsuly3m6u+u4YKwXziUuN
 1/nEUKZ2EVCPBGf5Yn8pdAl27Qq8MaQmirTJ1a6OYMZsUB4yMPF2aXq4pQeOIFhKZcok/G
 M3pOMjpXRMY331uOiCjAE29PgfIEM2U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-ZY3LYtOoNGWh2EI_91n-bw-1; Mon, 25 May 2026 10:29:36 -0400
X-MC-Unique: ZY3LYtOoNGWh2EI_91n-bw-1
X-Mimecast-MFC-AGG-ID: ZY3LYtOoNGWh2EI_91n-bw_1779719375
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4518f777225so6941823f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 07:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779719375; x=1780324175; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eGJuMgn1DdTEV+yMNrKJpD671bt2NQfQhiNmsvrl3Wo=;
 b=dsdLOoV9cGP2tHykgivNpDADbMWkplcFPNpsASBcQsWNkyzP2uNY1coyGQ0/tLFRMb
 lPWFVrymAtoFJAAS5ICoga56jhq4C/gfz1OmyyCSsOVICRHyT8Ncjzk4qyCG6wdAHY0c
 alCwLeeiVKFG6iUxoWTQeM93OH+VH269kpth9RQZErypDaTY3jzQLaVR75ytdbeaOKKs
 wxKAvi9EBnDvKexN8Pdo80FWVspL5KOozKiA8oiHgwdj2A+Z8G/xfmiL8LWWVvYgpw0Y
 iYa22Gav9d4XbvxXnpSaSLG/EYQODpVuImpnV7BzFdKklJf3bnoJibb6ohBetNiT3KGZ
 uVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779719375; x=1780324175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGJuMgn1DdTEV+yMNrKJpD671bt2NQfQhiNmsvrl3Wo=;
 b=l3Gh8FxqxkSEoIc/XogYeCx9CW+kwZJ+d0kvFT+M+hUJTKNaUfpG4RxWaoliZf8G3+
 H64FcbgnoXso7cDNAIAA1G1eesj2ts/1oda6N0VlWupsdtOFtIwby6E0fU18DEUpnnOy
 peLL7S+hsJnprkQSwyP4m19jUCZFf70Mi+sbzkVoUVcUdRpJ3yoZvwqiw/bSVG0On26c
 gcGESs0In7WWbYYElFPxtMHC8JD4lEqRqny3on3zzMnb0xTPzToReSjpJLnfu1Pnj6aI
 cNho5U73VawHfDlh1wvVgC2XcaqHPSzZZR9/AdKcsASNu4J2BAWXT/PKPL48EQe8Dbai
 Fx/g==
X-Gm-Message-State: AOJu0YzdsaXtC0fXnpM2ummx0t4HVkufXnA1zwkavXM7KMLnk6NSqWX1
 YJF+LRtdTafPtoKdyIjb5c6exDhHsklwVKJv9G/Ge3YXtj6DWyxwGlM6rHlPRhq96dbVzFSkgS9
 IB7WPkTiKA7/DnX6uEnKvEYUm+eezfBzsEcuZd75MnR2qKN8P5xmAIqmx
X-Gm-Gg: Acq92OGnf4MGa42T44tIyW9w9DiHtzXSxmxfbGHMzY2dOajyVMm4PrV9lg7HArQncxf
 NoBGSG3O3XZ/ggsUj7PU1amBQbABvEmG0Y/wmVdkwZTZ8u0WEm5S09HpOEq5TlSDfXm9KpX4hiM
 qzdOmHzleX9ULF+biCIZWQ6PbUU0gzyMiqGRwUKL4QU5Qn+eIn4t7Rg+1wxoxq2Zi2O5m5O+zNq
 BLBpT7odwGF34sR2PHtBySHZMmZsgy6OStbhrQIqS0Ae9If4XA2E6rtNVKjA7AbU3MEDaDmMWm8
 Hit6WdplpZ7evn044PzffC1/MAJExsIPQYoyCaf/SK/P8nJ1y7fNKodwXPIEgk44IKWrSJSdg9w
 BhbziUwp+y8QMRztZ6iPfT311Q7hCmV+U5CK47/5Py5T+ENPH5Yd4Oq3rlPVLXcJvhf2YrfI=
X-Received: by 2002:a05:6000:186c:b0:43b:4f86:e985 with SMTP id
 ffacd0b85a97d-45eb38a650bmr26173520f8f.33.1779719374653; 
 Mon, 25 May 2026 07:29:34 -0700 (PDT)
X-Received: by 2002:a05:6000:186c:b0:43b:4f86:e985 with SMTP id
 ffacd0b85a97d-45eb38a650bmr26173468f8f.33.1779719374200; 
 Mon, 25 May 2026 07:29:34 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9dd03sm30400530f8f.7.2026.05.25.07.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 07:29:33 -0700 (PDT)
Date: Mon, 25 May 2026 16:29:28 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH] igvm: fix handling of optional variable header types
Message-ID: <ahRY5N-euXCG4U7T@sgarzare-redhat>
References: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260525-igvm_optional-v1-1-28edc607acfd@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 25, 2026 at 12:56:51PM +0200, Luigi Leonardi wrote:
>The IGVM spec defines bit 31 of the variable header type as an
>optional flag: if set, a loader that does not recognize the header
>type may safely skip it. If clear, the loader must reject the file.
>
>Currently, all the types with the optional bit set are not
>recognized as valid headers.
>
>Implement optional header handling by masking bit 31 before matching
>against the handler table, and skip with a warning any unrecognized
>header that has the optional bit set.
>
>Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c | 24 +++++++++++++++++++++---
> 1 file changed, 21 insertions(+), 3 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index c347d0c17e..408917f826 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -26,6 +26,7 @@
> #include <igvm/igvm.h>
> #include <igvm/igvm_defs.h>
>
>+#define IGVM_VHT_OPTIONAL_BIT (1U << 31)

The best would be to have this exposed by the library headers.
I see you opened https://github.com/microsoft/igvm/pull/121 exactly for 
that, so I'd wait that one merged before merging this and I'd like to 
add an #ifndef here to define it if not defined by the library, so we 
will be ready when we will update the dependency.

>
> /*
>  * Some directives are specific to particular confidential computing platforms.
>@@ -139,8 +140,16 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>     const uint8_t *header_data;
>     int result;
>
>+    /*
>+     * Bit 31 of the variable header type indicates that the header is
>+     * optional and can be safely ignored by a loader that does not
>+     * support it. If the bit is clear, the file cannot be loaded.
>+     * https://docs.rs/igvm_defs/0.4.0/igvm_defs/struct.IgvmVariableHeaderType.html
>+     */
>+    IgvmVariableHeaderType base_type = type & ~IGVM_VHT_OPTIONAL_BIT;

What about adding a function to mask that bit?

So we will have a single point where to put this comment and use the 
function everywhere.

Ideally that function should be provided by the igvm library IMHO.

That said base_type & type is confusing IMO. What about raw_type (the 
one with flags, etc.) and type (the one after the mask) ?

>+
>     for (handler = 0; handler < G_N_ELEMENTS(handlers); handler++) {
>-        if (handlers[handler].type != type) {
>+        if (handlers[handler].type != base_type) {
>             continue;
>         }
>         header_handle = igvm_get_header(ctx->file, handlers[handler].section,
>@@ -166,6 +175,13 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>         igvm_free_buffer(ctx->file, header_handle);
>         return result;
>     }
>+
>+    if (type & IGVM_VHT_OPTIONAL_BIT) {
>+        warn_report("IGVM: Skipping unsupported optional header type 0x%"
>+                    PRIX32, type);
>+        return 0;
>+    }
>+
>     error_setg(errp,
>                "IGVM: Unknown header type encountered when processing file: "
>                "(type 0x%X)",
>@@ -787,7 +803,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>          header_index++) {
>         IgvmVariableHeaderType typ = igvm_get_header_type(
>             ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
>-        if (typ == IGVM_VHT_SUPPORTED_PLATFORM) {
>+        IgvmVariableHeaderType base_type = typ & ~IGVM_VHT_OPTIONAL_BIT;

Now `typ` is used just to define `base_type`, can we just mask the value 
returned by igvm_get_header_type() ? (Or `typ &= ...`). I mean I don't 
see any value on defining a new variable.

Thanks,
Stefano

>+        if (base_type == IGVM_VHT_SUPPORTED_PLATFORM) {
>             header_handle = igvm_get_header(
>                 ctx->file, IGVM_HEADER_SECTION_PLATFORM, header_index);
>             if (header_handle < 0) {
>@@ -947,7 +964,8 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>          ctx.current_header_index++) {
>         IgvmVariableHeaderType type = igvm_get_header_type(
>             ctx.file, IGVM_HEADER_SECTION_DIRECTIVE, ctx.current_header_index);
>-        if (!onlyVpContext || (type == IGVM_VHT_VP_CONTEXT)) {
>+        IgvmVariableHeaderType base_type = type & ~IGVM_VHT_OPTIONAL_BIT;
>+        if (!onlyVpContext || base_type == IGVM_VHT_VP_CONTEXT) {
>             if (qigvm_handler(&ctx, type, errp) < 0) {
>                 goto cleanup_parameters;
>             }
>
>---
>base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
>change-id: 20260525-igvm_optional-ca1592b613be
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


