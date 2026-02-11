Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899D5E9E2FA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 12:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq9Hk-0005CJ-P6; Wed, 11 Feb 2026 07:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vq9Hj-0005Bj-0k
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:25:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vq9Hg-00085f-NB
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 07:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770812730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Aefi61o6zp+6rmX8EEc23U6lF5pl+50hf2TUkblNyV0=;
 b=hjQHojZ+7RQFrEVhMCc1D5w5h+Mxhd9ZxET6tWuU6sEsZK4AZ+l+U43fjp3/twpVMN11vG
 L7416GKrHyMFXXNkfhILGYUOpr3Io2qPzM5ZPh8pqgbGUSWF6toN5OyAAwUbtGOYbQUjB+
 /GJ3gCRiD6Rt6Fp6fphH0D3q37d/2GM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-WvAQ6zqiO-i0Kw8T658f1g-1; Wed, 11 Feb 2026 07:25:29 -0500
X-MC-Unique: WvAQ6zqiO-i0Kw8T658f1g-1
X-Mimecast-MFC-AGG-ID: WvAQ6zqiO-i0Kw8T658f1g_1770812728
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-437681ecd32so2116236f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 04:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770812728; x=1771417528; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Aefi61o6zp+6rmX8EEc23U6lF5pl+50hf2TUkblNyV0=;
 b=IHPk2/lDy5bmh0U6fUwewKAEAaXnailj+GoNp1gUsU3s07IjkzrKZt6FzfTgxG3RP9
 jH8l/w1tG8UWFpVMYAVYRWoW4/1qMxYH2XZUoWRSc5E1EKCuNezG8AD084U+m28lrkPQ
 20TNLIXZmtXpgrJxPy3IYXyKIPUH3+9/Syd5zEO7hhgXbH4sT/lRQekGnZ3I0X8b/tim
 x0K731y3fSM0jYS8/Mj9UJUGLlo0q5FP6CnoijabXinxsubbmR6C9y71n3tUxtsBoIM+
 tNeGIOnoqbwtcLDClfinpnJoJu8v4+Y12Bl+Tx/aXhgPsSXjirgisFd/j7R5XhszsoLD
 KA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770812728; x=1771417528;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aefi61o6zp+6rmX8EEc23U6lF5pl+50hf2TUkblNyV0=;
 b=CBcQCXa6iqboiuY5o2gAlkLNoU4qaKGnJsgdTFkd8n7ubKcnynyUEilPqdS0MLyt+c
 hyUINXrnlx4bbh4h2J1zoSGVeSccmKoUE2yr0Tm6OjJU3prI8X015YViZe28GLtFBMZz
 IJSUEnpBZuq639e8xnl69MbsZwIS0VSvNd/1Qx6Ms9og3O5+oKHWHNoc/X6zh+i/H/RF
 pI8CO5nqzzaN/TZPnOLi4gXpARXyOqUcIlDv6ldSxVNWyuN+k+UZ7Jz7v0p8TTjuayyQ
 3cZXnVVCZ9LFJ5HZK+/1ErzTobBWhPI/gR1mNv8kGzmjTnSHNbEorg83KTkn4iNSjk/c
 B/Pw==
X-Gm-Message-State: AOJu0Yzm+dT94Wvr0xy+oS3xRxRhjuGt/U8y6fzQFTYY3ojc7L/2/s5y
 H2c7HiujGS/GVd/yfLg63r522DoFM2NcAb6I65ZHpSztkPdN+mHGn32X+/bDERbYr/0RV/TKeEj
 uEShPrH9r+vFOKQTPNas1amg05NA+CmQFQfmXZCEykDtEWq/3b181JR/R
X-Gm-Gg: AZuq6aIu5LuV5KKfOk3eYxiRn9viEZ40lqhDFRcFPQKJXWpLwUSVh6cxRIS//p5IoON
 bec/zulJc1o1EPUfV6hLEcEkEQIsdIrQPDNzhAoPyWry57SUMVdCpKJzis/m/gIijPVAkilLv/l
 NxyOobVY76fHBk3U04OQ2LPTwxmo72pPBThCECUGkSa99WJNwWhp1unwjc3GWFZRQksF3UFwm4w
 6R1ZUCRkzr49/jJD3seao5u+HedzbvjyYeM/AkYTiZkFV/+KW8qX/TwVRE6YGNSdnaT8cq20dns
 nu6n8OSN7j6zMdzM35CX1H4ThA1jFiBOo1t6s/h1QUpBMkr+Ez8VjNO15fVnKLyOfEfUSiPg4sq
 SylsmhzGowe3wxRr5mfUbSqLL
X-Received: by 2002:a05:6000:24c8:b0:436:34b8:e139 with SMTP id
 ffacd0b85a97d-43782b1a907mr3028823f8f.9.1770812727803; 
 Wed, 11 Feb 2026 04:25:27 -0800 (PST)
X-Received: by 2002:a05:6000:24c8:b0:436:34b8:e139 with SMTP id
 ffacd0b85a97d-43782b1a907mr3028791f8f.9.1770812727345; 
 Wed, 11 Feb 2026 04:25:27 -0800 (PST)
Received: from leonardi-redhat ([176.206.8.97])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783dfc8b9sm4145703f8f.24.2026.02.11.04.25.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 04:25:27 -0800 (PST)
Date: Wed, 11 Feb 2026 13:25:24 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH 1/1] igvm: Add NULL checks for igvm_get_buffer()
Message-ID: <aYx0Utf9FOVGP9lC@leonardi-redhat>
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

on a second thought: if you have to send a v2, what about reversing 
if and else? With an early return, we can remove the else clause entirely.

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
>+                igvm_free_buffer(ctx->file, header_handle);
>+                return -1;
>             }
>             igvm_free_buffer(ctx->file, header_handle);
>         }
>-- 
>2.53.0
>
>


