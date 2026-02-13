Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C439EF48F3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 09:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqpLQ-0008Px-TY; Fri, 13 Feb 2026 04:20:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vqpLO-0008PP-Hs
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vqpLM-0008VF-6W
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 04:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770974406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t+Ph2Dve+Oh8pocPiLEHtz4fxRbDMZqI5zzhazdpTUk=;
 b=O/3Jp4BDe/SWG1y7ZaBNXcmoQ3G6nuDWm2Q78U4oGYH9V2fWoeqUdOUE4t3PjqP3pBtyKL
 j9zFdvmTqMvH74f9wRNGautV5bVJL3fnUz8sAUlv+cyencqw0gfIN5Z6ilSa0/ZRwseCi5
 f1jmoOcyjX2HmD+Y60HMlBZUYOZsGlU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-yGZKsnMiOTSy4jF4xsPLHQ-1; Fri, 13 Feb 2026 04:20:04 -0500
X-MC-Unique: yGZKsnMiOTSy4jF4xsPLHQ-1
X-Mimecast-MFC-AGG-ID: yGZKsnMiOTSy4jF4xsPLHQ_1770974403
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48069a43217so6267035e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 01:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770974403; x=1771579203; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t+Ph2Dve+Oh8pocPiLEHtz4fxRbDMZqI5zzhazdpTUk=;
 b=f2NqCzB+GfYkgxfkmALaJOVp/9Kn0TGE3x4EUCpjftt1zIy/QtftZFJg0A2w6+xqGN
 TBitcTCTSylzv2Ypy12KpHBNeIUZldXD2kWd67mXF3xSAjEMA4ImPhMS9U2MHOsUNQhe
 RQi0rksb4PkfUYxm7eIMaFSSshl+ULhIOKGOseLUin4zPitGNqvD0RMGpmHmlztU59Qk
 +APyhJrCXat1GWDwKA66hYNw0Vn0G2yfbcbGeChtMkSUXR7XYbunUvB0+sT4esaNd3UT
 pT8SBh/nQZArWMOVSCbmJwBAqIjpkgthGFRXpSchHXMahJBEF7PLiANPNqSVFNaopFI0
 KcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770974403; x=1771579203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t+Ph2Dve+Oh8pocPiLEHtz4fxRbDMZqI5zzhazdpTUk=;
 b=jzLEYvU6Rdy0RaifJ8Cn3E+IDfYK1ayYV5T463TM9dudOdRssZUTWGvA1fxiQs5jMz
 NWtEanCTO/ACbxu1ntlAxcuHUA9yvlLUTOpkBSytNz6YuAiFseBvLsoQ6ti6HKpMcMV5
 WAJAb1KFUhvWHzkrCATr6kkul3lFImw+JkbEiDqJ9plaq+6MvBsbG0o0Sfxe/9bPLUZX
 1D+trl+rW+z9txe5Xi546SJ/SSXPYmTtnFUwRFcmgSB1utdv7ZAFzcI7O3h3Y38lzdL8
 /4+t8I9TheLuFU9h/lyp8JxEML2aMKBNz2YLd1xaMmBbBzepX9vV+X+SOw9NHmWZBp9K
 dCAg==
X-Gm-Message-State: AOJu0YzIXNk01h4wmZy4CBIqSGUIkDqTYuX2+zt0SiD3+l39865lFQEf
 PDuS5V79KQRpXZot+FfMDUcjlFZ9b1RD9fOwv9C4h8W/6n1bfVTBzWL/Tr1n/vLChQSiLAXHxOv
 RbpTKXjKDPecAql609HaE6JyQFbXlZRq9rnxQ/M8aSU0IlaE0CvbPtcpQ
X-Gm-Gg: AZuq6aLP6BQMI9tErFYf4iF1Dyhq6qPUBqWGWkhFHHV+SXKTueqQi8+dMgelYtHsAiQ
 MEHDtmlrh4MDse3op9oN/lhT5HAelaQQsZsRLlfWCWqjWQka1vVmaDA8hs3tD9UmF1yqti63h5+
 nh2Nn46hbfxVCn8Dx5RwkTbYhwZPCBwhrYRL1eVLZFpmKcgsTOFrpid1MRL+fYFF+vuLbEZQIhe
 2G0woMht9L/NVlgYe68IorNAQefTu71A+7PDkir36zkVDig1h8td8+5RYHhPtVq+lv5B4K9g+yR
 bfcxb1JYeD9As7kNn2Arvd3Bq414f1v5Tt/gq1Z9ftIqoUlRaXTNQOimlqePUPR84XL32lbHiWD
 2gMyZZfVIoCmDuqlT/tQUMZqJ
X-Received: by 2002:a05:600c:524d:b0:480:4b5d:9ec with SMTP id
 5b1f17b1804b1-48373a656f9mr20518915e9.33.1770974403318; 
 Fri, 13 Feb 2026 01:20:03 -0800 (PST)
X-Received: by 2002:a05:600c:524d:b0:480:4b5d:9ec with SMTP id
 5b1f17b1804b1-48373a656f9mr20518645e9.33.1770974402841; 
 Fri, 13 Feb 2026 01:20:02 -0800 (PST)
Received: from leonardi-redhat ([176.206.8.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48371a10cacsm20971395e9.4.2026.02.13.01.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 01:20:02 -0800 (PST)
Date: Fri, 13 Feb 2026 10:20:00 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Oliver Steffen <osteffen@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v2] igvm: Add NULL checks for igvm_get_buffer()
Message-ID: <aY7staXCnSpb3K6Z@leonardi-redhat>
References: <20260212154114.1119944-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260212154114.1119944-1-osteffen@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Thu, Feb 12, 2026 at 04:41:14PM +0100, Oliver Steffen wrote:
>According to the documentation we are supposed to do a null-pointer
>check on the buffers returned by igvm_get_buffer() (part of the IGVM C
>library).
>Add these checks in the IGVM backend.
>
>Signed-off-by: Oliver Steffen <osteffen@redhat.com>
>---
> backends/igvm.c | 37 +++++++++++++++++++++++++++++++------
> 1 file changed, 31 insertions(+), 6 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index b01a19ba46..3b5edf1521 100644
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
>@@ -316,6 +324,11 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
>                 return -1;
>             }
>             data = igvm_get_buffer(ctx->file, data_handle);
>+            if (data == NULL) {
>+                error_setg(errp, "IGVM: No buffer for handle %d", data_handle);
>+                igvm_free_buffer(ctx->file, data_handle);
>+                return -1;
>+            }
>             memcpy(&region[page_index * page_size], data, data_size);
>             igvm_free_buffer(ctx->file, data_handle);
>         }
>@@ -426,6 +439,11 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>     }
>
>     data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
>+    if (data == NULL) {
>+        error_setg(errp, "IGVM: No buffer for handle %d", data_handle);
>+        result = -1;
>+        goto exit;
>+    }
>
>     if (ctx->machine_state->cgs) {
>         result = ctx->cgsc->set_guest_state(
>@@ -441,6 +459,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
>         result = -1;
>     }
>
>+exit:
>     igvm_free_buffer(ctx->file, data_handle);
>     if (result < 0) {
>         return result;
>@@ -778,9 +797,15 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>             }
>             platform =
>                 (IGVM_VHS_SUPPORTED_PLATFORM *)(igvm_get_buffer(ctx->file,
>-                                                                header_handle) +
>-                                                sizeof(
>-                                                    IGVM_VHS_VARIABLE_HEADER));
>+                                                                header_handle));
>+            if (platform == NULL) {
>+                error_setg(errp, "IGVM: No buffer for handle %d", header_handle);
>+                igvm_free_buffer(ctx->file, header_handle);
>+                return -1;
>+            }
>+
>+            platform = (IGVM_VHS_SUPPORTED_PLATFORM *)((void *)platform
>+                                        + sizeof(IGVM_VHS_VARIABLE_HEADER));
>             if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
>                 ctx->machine_state->cgs) {
>                 if (ctx->cgsc->check_support(
>-- 
>2.53.0
>

LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>


