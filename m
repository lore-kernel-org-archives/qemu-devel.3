Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E88CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 14:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl86z-00072G-SQ; Mon, 02 Sep 2024 10:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl86w-00071S-S9
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sl86u-0005qE-OW
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 10:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725287570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nlwRqd3JZWueRHVQcpPqVurrorHWGmaslSL9I9rQjlE=;
 b=exSMj52sEe+3RaHCnmyz/uN6RdHlf96q1GbXlIfbjemGr11rAqnwr/yf4vemvfAnTED/65
 pi1G65sJKSg+UZaMGuEGgI5krvHy7ownVULxU9Dn7y/HoIJj7WKhJ7hfTfIgqZL225KLd8
 kQVsPMQ2ty9D9Wn8A3gQR4XYZyJfUic=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-yEUTbvtbNBqXrTNjZEJYrw-1; Mon, 02 Sep 2024 10:32:47 -0400
X-MC-Unique: yEUTbvtbNBqXrTNjZEJYrw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42ac185e26cso40687385e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 07:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725287567; x=1725892367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nlwRqd3JZWueRHVQcpPqVurrorHWGmaslSL9I9rQjlE=;
 b=Z1Q2CVZ2OhfkfBvcrxsvygkRGx5hw1X9/GX//VnZqYRtWvm0MYSg9WZP4BpW+D/oLX
 SpY52UbpP5f9cqFvYAhYFUWctzFhTuiYP7wuRv3l1uvWIoVYmtu5NChg5cWN/9x+Tgb1
 FRH+XZ34NAYnG3C2KspISoOmMaDidZu5iVs5sraFvL0HGuG/UwWwMyxzFjf9YUAEKqX7
 xSrzmy35HwoX5TXWZ4lL/ZCpuqwA5QMaHCZMqghhDw6kS1DU4zxodKQ3QCuLzsJayTEL
 g2j0j+K9mEWN7dynXu6viTxZbDMurBYDxKdeCOOxw1N0Qbgf2cfgF2I95HR1++jdTqku
 LN2w==
X-Gm-Message-State: AOJu0YxEdpJXr2jP0SjjbuqiRFn8RAUl8CKejVHLB2Gtu616ze0GtuJL
 9SiBYQSeCRBh76XluDEncIF2NgONZ6YhLM6x48GX/QKiC8rK16EZHATA82pZZMmv9FpvEHeO6Rg
 ekW2+2OmGccKSiVv+dJl+VqqzUJUJbuCPkS5mgSCsKRpBsinhjgqW
X-Received: by 2002:a05:600c:1914:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-42bbb440222mr62749805e9.30.1725287566709; 
 Mon, 02 Sep 2024 07:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmGn2sBzLpAKpbLwOJ1GfGaOfb1d+T0WZpi1w6SGdMN65yeH0Nvhz1JUbt5TCpK13xTKW9dw==
X-Received: by 2002:a05:600c:1914:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-42bbb440222mr62749435e9.30.1725287565799; 
 Mon, 02 Sep 2024 07:32:45 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.206.174])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e33d83sm140158235e9.44.2024.09.02.07.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2024 07:32:45 -0700 (PDT)
Date: Mon, 2 Sep 2024 16:32:39 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Sergio Lopez <slp@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, 
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v5 13/16] backends/igvm: Process initialization sections
 in IGVM file
Message-ID: <igwotfd7xlk474xwh7sm33tdjhdapwskco4gzhb2ugyalftydt@huyvfx4db4w2>
References: <cover.1723560001.git.roy.hopkins@suse.com>
 <217c09a6da321b56c2bf9a1ed0b3b53b68e36b97.1723560001.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <217c09a6da321b56c2bf9a1ed0b3b53b68e36b97.1723560001.git.roy.hopkins@suse.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 13, 2024 at 04:01:15PM GMT, Roy Hopkins wrote:
>The initialization sections in IGVM files contain configuration that
>should be applied to the guest platform before it is started. This
>includes guest policy and other information that can affect the security
>level and the startup measurement of a guest.
>
>This commit introduces handling of the initialization sections during
>processing of the IGVM file.
>
>Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
>Acked-by: Michael S. Tsirkin <mst@redhat.com>
>---
> backends/igvm.c | 21 +++++++++++++++++++++
> 1 file changed, 21 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 7a3fedcc76..9120922a95 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -787,6 +787,27 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
>         }
>     }
>
>+    header_count =
>+        igvm_header_count(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION);
>+    if (header_count < 0) {
>+        error_setg(
>+            errp,
>+            "Invalid initialization header count in IGVM file. Error code: %X",
>+            header_count);
>+        return -1;
>+    }
>+
>+    for (ctx.current_header_index = 0;
>+         ctx.current_header_index < (unsigned)header_count;
>+         ctx.current_header_index++) {
>+        IgvmVariableHeaderType type =
>+            igvm_get_header_type(ctx.file, IGVM_HEADER_SECTION_INITIALIZATION,
>+                                 ctx.current_header_index);
>+        if (qigvm_handler(&ctx, type, errp) < 0) {
>+            goto cleanup;
>+        }
>+    }
>+
>     /*
>      * Contiguous pages of data with compatible flags are grouped together in
>      * order to reduce the number of memory regions we create. Make sure the
>-- 
>2.43.0
>


