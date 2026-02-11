Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B890E9E2FB
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9BO-0003H9-Bx; Wed, 11 Feb 2026 07:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vq9BM-0003Gx-VS
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vq9BK-0007He-QW
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770812336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ahrRLFEVaTI5eoqI6YZCEVDiIPbgPoS+pqcCElypmCA=;
 b=MLspamxjQdphyaEcf6J/uI4S5mKqu+afQJRMpF7hQgYxSB5jF+O+zutBqjfoenjrhbnFr7
 sZoI1Hw87GIrQTHynh37puUKpLrfCKfTXWKq1Phm48CSsUuBbJORqLrq9A6GIn79S6cvC2
 kC09eAWemyRaTX5rmPLkh6hlxK3obSE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-qR-yzxMVMrOYJaIdYInOKA-1; Wed, 11 Feb 2026 07:18:53 -0500
X-MC-Unique: qR-yzxMVMrOYJaIdYInOKA-1
X-Mimecast-MFC-AGG-ID: qR-yzxMVMrOYJaIdYInOKA_1770812332
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48349cc9c10so14640275e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 04:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770812332; x=1771417132; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ahrRLFEVaTI5eoqI6YZCEVDiIPbgPoS+pqcCElypmCA=;
 b=nN9598aAFpYU0otVa8l0nylJWK9H2/3pnOQedct9N3YLn3Bso7iLhNW+M5bFKUsKgQ
 cuWpWsrOieS+hgVwU8SLLUq4uwLn7F2AqFqdssx8nvJ4VenP7VK8iFVTNx9p6uqUFsoc
 YgBzz6muUIX8KKqhgu8rV+euJMQeDvqv1f7b2UAqt71mezuEZ80A5iXdz1+0F3vYwEl8
 KBw+zKkQ4dqsdK4+AFz3iLtIzuVtMENDzmLgiofF4UPiODVXFx7tLx9ZQEmhAJ0dr2JK
 d4zYu68VZ+cCt3J3uGAZdbbbP1NtEB6EGVbceOye8TMKMi5wNZSLZpF5j6DWS+FNXFeA
 TKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770812332; x=1771417132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ahrRLFEVaTI5eoqI6YZCEVDiIPbgPoS+pqcCElypmCA=;
 b=whDFFhZKTVR4FgxiBhGXhKGeugCMYF9HmFZZ0KGhzuWQYTCwB0tFV0ulri/GAx+4A9
 2NfEYQrzfAE8iNP8QetKxw1rk+a53bIM2KCI3snuGWyf8umNUhi/zHhmoN0Fo4KUc76p
 MAWQ1yNGwHDynYRcRF0fH/b5kYfM+3vMRBm+2TZIe7pxgucGFAyUxIGTLLGsfBwPTqdr
 3A0ZIuSR8kBkn4H+s1wzOyDS0wFMK/WBpFENcxZOoUyDN7r/QHTH2b39+yLXhCfq6KL4
 kBOqBslLsrTSIfI8IyFMyZFbfmqWfD5Utyh7/8Ur18WDccQUhAfrO2SRqdwn7n7VWaRh
 a4Lw==
X-Gm-Message-State: AOJu0YwftBcuVG9LDsdEqyj+GoPedOwwxXQqM2+U3vits/H0XEjv8eRk
 ClLadO1BpcU4AenusVS0TSbas4+RxIkxHJd7sQJnyZ5Ib06V7uSDnQp6vuf1LTscURZvtQs6/o8
 d6HxeD39b9uo68xBZB+xkGONbtusytmvNGHGJO1ZYeK47qnZ2Y1aV4C04
X-Gm-Gg: AZuq6aKrlb9bTsYtRIQppJnZ/nTszbM8rlyZM3dtd3W3/T8kI0NgH23H/Hz+VVqosC8
 0mKYFN2zO/CBcvlbI05nAd14xnwPyDRse6Ss1rRU3xWNkcAaRQNVhr6N9wwgmw/TObtbypKtn3X
 o79lx6pE2wlgZgahs/sPC3d/ohVdJK8V7E4s8XAdu23TCX3ppJlGjLrlAKCPSY9VG1DvW4e3HdE
 BhwfNlgWaYUJYolXxAtszTvgNQPoTo04r561GSmwOnbWbX13CfNSlvRk8L7r01BP1bxDSidqNsJ
 2rqvgb9MibfHMVVDymg8oEay/zjg+nHPFUt5cLHfioFXmztKYGuXpy1uFehzVxvCCSgLl3Ju9OW
 KQvhACQKc3h9nWsYt/8R77Vj+
X-Received: by 2002:a05:600c:3e14:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-4835d55c645mr26842425e9.33.1770812331790; 
 Wed, 11 Feb 2026 04:18:51 -0800 (PST)
X-Received: by 2002:a05:600c:3e14:b0:47e:e4ff:e2ac with SMTP id
 5b1f17b1804b1-4835d55c645mr26842015e9.33.1770812331262; 
 Wed, 11 Feb 2026 04:18:51 -0800 (PST)
Received: from leonardi-redhat ([176.206.8.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d834ebesm120990435e9.13.2026.02.11.04.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 04:18:49 -0800 (PST)
Date: Wed, 11 Feb 2026 13:18:47 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 1/1] igvm: Add NULL checks for igvm_get_buffer()
Message-ID: <aYxzMOommn-a-yiQ@leonardi-redhat>
References: <20260210112436.315197-1-osteffen@redhat.com>
 <20260210112436.315197-2-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260210112436.315197-2-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 10, 2026 at 12:24:36PM +0100, Oliver Steffen wrote:
>According to the documentation we are supposed to do a null-pointer
>check on the buffers returned by igvm_get_buffer() (part of the IGVM C
>library).
>Add these checks in the IGVM backend.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm.c | 86 ++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 56 insertions(+), 30 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index b01a19ba46..049cb36891 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -152,9 +152,17 @@ static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>                 (int)header_handle);
>             return -1;
>         }
>-        header_data = igvm_get_buffer(ctx->file, header_handle) +
>-                      sizeof(IGVM_VHS_VARIABLE_HEADER);
>-        result = handlers[handler].handler(ctx, header_data, errp);
>+        header_data = igvm_get_buffer(ctx->file, header_handle);
>+        if (header_data != NULL) {
>+            header_data += sizeof(IGVM_VHS_VARIABLE_HEADER);
>+            result = handlers[handler].handler(ctx, header_data, errp);
>+        } else {
>+            error_setg(errp,
>+                    "IGVM: No buffer for handle %d: "
>+                    "(type 0x%X)",
>+                    header_handle, type);
>+            result = -1;
>+        }
>         igvm_free_buffer(ctx->file, header_handle);
>         return result;
>     }
>@@ -316,7 +324,13 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
>                 return -1;
>             }
>             data = igvm_get_buffer(ctx->file, data_handle);
>-            memcpy(&region[page_index * page_size], data, data_size);
>+            if (data != NULL) {
>+                memcpy(&region[page_index * page_size], data, data_size);
>+            } else {
>+                error_setg(errp, "IGVM: No buffer for handle %d: ", data_handle);

nit: space and semicolon can be removed

>+                igvm_free_buffer(ctx->file, data_handle);
>+                return -1;
>+            }
>             igvm_free_buffer(ctx->file, data_handle);
>         }
>     }
>@@ -426,6 +440,11 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
>+    if (data == NULL) {
>+        error_setg(errp, "IGVM: No buffer for handle %d: ", data_handle);

ditto

>+        result = -1;
>+        goto exit;
>+    }
>
>     if (ctx->machine_state->cgs) {
>         result = ctx->cgsc->set_guest_state(
>@@ -441,6 +460,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>         result = -1;
>     }
>
>+exit:
>     igvm_free_buffer(ctx->file, data_handle);
>     if (result < 0) {
>         return result;
>@@ -778,33 +798,39 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>             }
>             platform =
>                 (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->file,
>-                                                                header_handle) +
>-                                                sizeof(
>-                                                    IGVM_VHS_VARIABLE_HEADER));
>-            if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
>-                ctx->machine_state->cgs) {
>-                if (ctx->cgsc->check_support(
>-                        CGS_PLATFORM_SEV_ES, platform->platform_version,
>-                        platform->highest_vtl, platform->shared_gpa_boundary)) {
>-                    compatibility_mask_sev_es = platform->compatibility_mask;
>-                }
>-            } else if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV) &&
>-                       ctx->machine_state->cgs) {
>-                if (ctx->cgsc->check_support(
>-                        CGS_PLATFORM_SEV, platform->platform_version,
>-                        platform->highest_vtl, platform->shared_gpa_boundary)) {
>-                    compatibility_mask_sev = platform->compatibility_mask;
>+                                                                header_handle));
>+            if (platform != NULL) {
>+                platform = (IGVM_VHS_SUPPORTED_PLATFORM *)((void *)platform
>+                                            + sizeof(IGVM_VHS_VARIABLE_HEADER));
>+                if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
>+                    ctx->machine_state->cgs) {
>+                    if (ctx->cgsc->check_support(
>+                            CGS_PLATFORM_SEV_ES, platform->platform_version,
>+                            platform->highest_vtl, platform->shared_gpa_boundary)) {
>+                        compatibility_mask_sev_es = platform->compatibility_mask;
>+                    }
>+                } else if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV) &&
>+                        ctx->machine_state->cgs) {
>+                    if (ctx->cgsc->check_support(
>+                            CGS_PLATFORM_SEV, platform->platform_version,
>+                            platform->highest_vtl, platform->shared_gpa_boundary)) {
>+                        compatibility_mask_sev = platform->compatibility_mask;
>+                    }
>+                } else if ((platform->platform_type ==
>+                            IGVM_PLATFORM_TYPE_SEV_SNP) &&
>+                        ctx->machine_state->cgs) {
>+                    if (ctx->cgsc->check_support(
>+                            CGS_PLATFORM_SEV_SNP, platform->platform_version,
>+                            platform->highest_vtl, platform->shared_gpa_boundary)) {
>+                        compatibility_mask_sev_snp = platform->compatibility_mask;
>+                    }
>+                } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
>+                    compatibility_mask = platform->compatibility_mask;
>                 }
>-            } else if ((platform->platform_type ==
>-                        IGVM_PLATFORM_TYPE_SEV_SNP) &&
>-                       ctx->machine_state->cgs) {
>-                if (ctx->cgsc->check_support(
>-                        CGS_PLATFORM_SEV_SNP, platform->platform_version,
>-                        platform->highest_vtl, platform->shared_gpa_boundary)) {
>-                    compatibility_mask_sev_snp = platform->compatibility_mask;
>-                }
>-            } else if (platform->platform_type == IGVM_PLATFORM_TYPE_NATIVE) {
>-                compatibility_mask = platform->compatibility_mask;
>+            } else {
>+                error_setg(errp, "IGVM: No buffer for handle %d: ", header_handle);

ditto

>+                igvm_free_buffer(ctx->file, header_handle);
>+                return -1;
>             }
>             igvm_free_buffer(ctx->file, header_handle);
>         }
>-- 
>2.53.0
>
>

Thanks!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


