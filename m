Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E6510AB80E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:28:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qNK-000577-7C; Thu, 26 Mar 2026 15:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5qNC-00056k-S3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5qNA-0006Yk-V5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774553284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+AQFEM/bDUwhFhaUjquukyM/k0D8kUONqsyI1dILsh4=;
 b=LFVaHKTvo09/3mf1Zgs1h64CTZM9u7kXPy6og25t+mRHT4iaG9aYxouFHGFS/wxtO4OUPP
 tHoC6YeqFmGWKLKFTTr/lYw/ULbmrw+9VzNQiIg+jSr0aP6h//uwERw1NYbaIg4yd3wfCV
 gZNiA4FlX63z5m0he/kV2LEPAQxodiM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-nBNOMUBdOQeBeqZ4vDdS5A-1; Thu, 26 Mar 2026 15:28:03 -0400
X-MC-Unique: nBNOMUBdOQeBeqZ4vDdS5A-1
X-Mimecast-MFC-AGG-ID: nBNOMUBdOQeBeqZ4vDdS5A_1774553282
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4987c698so35359061cf.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 12:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774553282; x=1775158082; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+AQFEM/bDUwhFhaUjquukyM/k0D8kUONqsyI1dILsh4=;
 b=YgoALH8ZLm5ecxCZ0juW26U0aCVl9LScOJBSudZSaymhgW80jHNTlaJvOgTFNdqQCX
 f9L6IKoXClCU9rTSPkR7CRGBU4xT/7XOatIqLKDrnx/x0NgyDjIcYWGpe0emfLYk4Rej
 PAbaS5CXcITq7cO5KTsrbW3NAaAJC8m/5nHAaxt3f2c6qDZzh5MhWsUMQ6Oi2CzrSxPt
 cVMjENe0fkSkW7ar7xpnAcRt9QusY7IzgUiEI5rS/FMGnoKFZUtsGpvUoJC+5cEM6XCv
 C0swwJpSXupzCLMBM6ppS2wacjt4SE3xwRSKmkIgDcKbGTSlyp3zCqZY36rZdvFsgaxw
 J1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774553282; x=1775158082;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AQFEM/bDUwhFhaUjquukyM/k0D8kUONqsyI1dILsh4=;
 b=CJAdtJmlmGvm0unpkcvW/P0WUirU4J2DqwwQoAHItPj0dFPftPFR67WO2hv/kLgVGm
 EWGPh6S/ysdiZJzPxrPv3BSE/RfGrBtZG1ENVdcUHrRKVWW2R4yqk4QnDF5FMZZfcjph
 N/7y/w4A9Jrogg7fWAxfQEB4+/tIkuWP2AQn2bVpJ3jts9wZS48AP+425kWQrb6JLHQz
 s8QEPnjiaKuWHq+a70R5zHPWU3+8XDZhYxfFMV1/zfYZci59GZ0XvqsmuXv14H/hBE4x
 hxtIkHdW5HaY6t3iNvjrDNGSWOgm6cn5fvUzRNtm5ONcViz9snGrdKXqWgJ5OLnegf9D
 +UOQ==
X-Gm-Message-State: AOJu0Yx+go7pivXlnn1IBfYwC/cAojFr3XU9qd5vOAbWrXTm6je3bl8t
 T4ojrrs2hu++r+JXTOjtZzBzWTQYG5mkHxiA9mSFJnMUdxzY7//cFw8Fhhg51Q+22cqPa3bKgOG
 K0kpi6xKD2RI15IiaNMy/ENsksaDWjqTqvdfgUqvUtp505pdznJ9VAs5VAG8yPNCDZjE1EmxCFu
 UaEvB228OiQzUfwerrG+9AfDlpxXyXAxjj5rhXPQ==
X-Gm-Gg: ATEYQzzxppwXupJdIc6MN054MnxszYLO7EtR96uM/N3R69L5i/AaUJ638obXfF68Wh/
 KOuAYu93u7LCCv8PXJ0JFLdeywJETUspf74O2fLPBrSoQ1+MSNOhElJEGBrriYv1JFGh0WM6RWK
 cE7QIOviXrytgdQKGK1yYQtF0GW1p/nDBdbIvraxAJ9pesrjLF8eN7aPMmU2nrMPcUPVbejTr9x
 ufaPloW/hQjMBXdjJc5uJj/n/dAuj8WXF1Umd0XPSREFJuK0aa4iYcDo9fy1FzC02JqSOp7qfUf
 bLVzh4d3Suuq/TZtkMKlLTqxvcw7mgFGo4j3oMGozPWjRnQpen3td3HrWUlvAx5W3zJh6oPbqUF
 hkkJNya/BcxU+DQ==
X-Received: by 2002:ac8:5f49:0:b0:50b:8b8c:f68b with SMTP id
 d75a77b69052e-50b9958e2b0mr35507161cf.39.1774553282105; 
 Thu, 26 Mar 2026 12:28:02 -0700 (PDT)
X-Received: by 2002:ac8:5f49:0:b0:50b:8b8c:f68b with SMTP id
 d75a77b69052e-50b9958e2b0mr35506761cf.39.1774553281485; 
 Thu, 26 Mar 2026 12:28:01 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b923dd712sm30944271cf.29.2026.03.26.12.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 12:28:01 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:27:59 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH RFC 04/10] vmstate: Limit the vmdesc_loop dedup trick to
 compressable field
Message-ID: <acWIv8ZtxETTlXR_@x1.local>
References: <20260317232332.15209-1-peterx@redhat.com>
 <20260317232332.15209-5-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317232332.15209-5-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Tue, Mar 17, 2026 at 07:23:26PM -0400, Peter Xu wrote:
> We have a trick in vmstate_save_vmsd_v() where we will try to compress
> multiple JSON vmstate field dumps into one line with a count to avoid
> duplicated entries.
> 
> That only applies to the cases where vmsd_can_compress() should return
> true.  For example, vmsd_desc_field_start() later (who will take the
> updated max_elems as the last parameter) will ignore the value passed in
> when vmsd_can_compress() returns false.
> 
> Add that check to the trick too, it will be used later to bypass this logic
> to some special new VMSD fields.
> 
> No functional change intended in this patch alone.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/vmstate.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index e29a8c3f49..caa7b50bce 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -578,7 +578,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  }
>  
>                  /*
> -                 * This logic only matters when dumping VM Desc.
> +                 * This logic only matters when dumping VM Desc, and only
> +                 * when the VMSD field can be compressed.
>                   *
>                   * Due to the fake nullptr handling above, if there's mixed
>                   * null/non-null data, it doesn't make sense to emit a
> @@ -587,7 +588,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                   * vs. nullptr). Search ahead for the next null/non-null element
>                   * and start a new compressed array if found.
>                   */
> -                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
> +                if (vmdesc && vmsd_can_compress(field) &&
> +                    (field->flags & VMS_ARRAY_OF_POINTER) &&
>                      is_null != is_prev_null) {
>  
>                      is_prev_null = is_null;
> -- 
> 2.50.1
> 

This patch unfortunately stops working when I start to test
analyze-migration.py. I plan to use another similar patch below to replace
this one:

From e72df6470e64715caaf3857a899fe63086bf4628 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 17 Mar 2026 19:23:26 -0400
Subject: [PATCH] vmstate: Update max_elems early and check field compressable
 once

QEMU has a trick in vmstate_save_vmsd_v(), where it will try to compress
multiple JSON entries into one with a count to avoid duplicated entries.

That only applies to the cases where vmsd_can_compress() should return
true.  For example, vmsd_desc_field_start() later (who will take the
updated max_elems as the last parameter) will ignore the value passed in
when vmsd_can_compress() returns false.

Do that check once at the start of loop, and use it to update max_elems, so
that max_elems keeps 1 for uncompressable VMSD fields, which is more
straightforward.

This also paves way to make this counter work for ptr marker VMSD fields
too.

No functional change intended in this patch alone.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index e29a8c3f49..05badef42f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -556,7 +556,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
                 bool is_null;
-                int max_elems = n_elems - i;
+                /* maximum number of elements to compress in the JSON blob */
+                int max_elems = vmsd_can_compress(field) ? (n_elems - i) : 1;
 
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -587,7 +588,8 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                  * vs. nullptr). Search ahead for the next null/non-null element
                  * and start a new compressed array if found.
                  */
-                if (vmdesc && (field->flags & VMS_ARRAY_OF_POINTER) &&
+                if (vmdesc && max_elems > 1 &&
+                    (field->flags & VMS_ARRAY_OF_POINTER) &&
                     is_null != is_prev_null) {
 
                     is_prev_null = is_null;
@@ -626,7 +628,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 /* Compressed arrays only care about the first element */
-                if (vmdesc_loop && vmsd_can_compress(field)) {
+                if (vmdesc_loop && max_elems > 1) {
                     vmdesc_loop = NULL;
                 }
             }
-- 
2.50.1

-- 
Peter Xu


