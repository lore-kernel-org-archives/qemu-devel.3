Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 957BA105F7AF
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13Xe-0004Te-42; Fri, 13 Mar 2026 10:31:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w13XW-0004TB-Gl
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w13XS-0003Qj-BF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773412249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rHz11Jd2F7USk5v8J66F80Kb6gcRXtAlmsInfWDvNjQ=;
 b=KkUxe2hC7lnKkfJtG7Y3RS5xRfxb9jOF12YGWKILdBaisaI3lqblu8IUbYfZDiKYqw6ljh
 5prTpmq5V0Uo9wIW7sf0BQR5yN2YuSK9td8IP3piOAKaVRidigUF4pWWhUUegxtFy3g1JZ
 n85bekN9craFmm3g9obVuDjgvCQ/5/8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-6TrKezIkP36UXzrraDiL7A-1; Fri, 13 Mar 2026 10:30:48 -0400
X-MC-Unique: 6TrKezIkP36UXzrraDiL7A-1
X-Mimecast-MFC-AGG-ID: 6TrKezIkP36UXzrraDiL7A_1773412247
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cd7d66afceso1479572385a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773412247; x=1774017047; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rHz11Jd2F7USk5v8J66F80Kb6gcRXtAlmsInfWDvNjQ=;
 b=SUNHtMTjQueHc7nkHr638M1iz3P80XKL9oBW5lPXcHpbD8IrVHwxT4adFbKUoVf4k6
 6Aj4RNB/OoOibCSQTc8tXYBIRb8pDwK9hLDHzee5wvgKQNMZCoozqeLpCD4Ml/QEJ4Za
 rFzSyxTtMBhy0hks8lMku0+LUGv85urcZmtBGzWZuAMnOMhDo/kbNvZrd+PN+Lfr/PQ3
 jeXc3TsQSWyZCvTxPL0/9nUv/OcTyt2Qqg26dNAkuGv/7c5VR21xC6yNhD7a/Sgjk1G+
 H1qM3X4u4ClJlK3KutBj00LuySwA3WmmaDsbG6EVXu/h14sgrSU4lfBk9JNICwNXGwEa
 mJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773412247; x=1774017047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rHz11Jd2F7USk5v8J66F80Kb6gcRXtAlmsInfWDvNjQ=;
 b=RJYRvaROEEbRNEgPTZpQsRtEnCZHzCiehnXD5jAMYEDExNfT7tx/pf1rnSbziMY2Ja
 dE+veNZKHyB1AKlkfnwdCNESQWhp6gTSfLdj8ZLhasOLhDqESsq+wiY3q8iNCC53OwwS
 B4M+O14Y6ztqPhzUNzTJ06d+/gybn5WCwCW4pg7f0oLwZXQxFZWMnm3+Yuied9ZTk69n
 aRi0+VkRR3DaMK6p34w6HvMCWdwRItysYHTdEewvXduzSz7RpNhFweU/CNZM5A07w/6O
 t5McnZnHZa800fOxGDIqBk6k0YLgFAmedegWd5um+FIlWneVTMxMqAz12Ncu3LEZcAv9
 mUQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkotVSzak5KTiQH8JxQ8fDI/ISqO2zRFrij2YveA5RaNgKf19sgPRVlmw6fjrAe5WNEJ7ElkfQYJd5@nongnu.org
X-Gm-Message-State: AOJu0YxgNBCyFM7cCSk4yFCiV6FkvUFGlS7c8p5obkfGHjS85RkGsmsQ
 p5M7T4MbSHlaBNuewKK3Li4+aWs6yBqZO/TMRDVlU2Fy0aLZf/hJWe3GD+QGuS1ZuLbpOw/xydP
 hWxPd+XRLHhucmz7dLyU1oY4bkr46J3O8UtIapdr8IAMiw6c8IysAFfx7
X-Gm-Gg: ATEYQzyrUQUAGIeNkwKXaM1S2k9zTRjl/NIHPWNVL+7ah0FsloHrcK33D8/t/Xfx4Ec
 CwT7xSf2NEiaEd5Jp+L895JQvv/npJ80U0qC7ySRPKdI2RWSMF+rWupnKoZVDDGnvVBs77DXau7
 PAWZfC8Ej6Zttwx3OdYy+TNdg/hrDUoCb0yLLJ+H+AeXQL9ib6L9euEtLhHchDnvHSOzBm/bfi6
 jPDoVinAIM5JXR2+ChNL32Hksc3dOO5DTHVdNCx5OmAgAa5PvyWF0B6oGIwJYJCVtU+q2z0rKF1
 4Fy0kVE9i4MHAGKugtKM15OmaiLc0sNTJLZxTu/xza5uI2SYMi62JQzb6gQpqJlRc6h2XgQWVxI
 bGORRVuQoAIqUUw==
X-Received: by 2002:a05:620a:4153:b0:8cd:92e7:71bd with SMTP id
 af79cd13be357-8cdb5baa9d4mr477019885a.74.1773412247230; 
 Fri, 13 Mar 2026 07:30:47 -0700 (PDT)
X-Received: by 2002:a05:620a:4153:b0:8cd:92e7:71bd with SMTP id
 af79cd13be357-8cdb5baa9d4mr477009885a.74.1773412246554; 
 Fri, 13 Mar 2026 07:30:46 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda21540f5sm550052785a.45.2026.03.13.07.30.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:30:45 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:30:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: farosas@suse.de, qemu-devel@nongnu.org, whollins@google.com,
 jansene@google.com, jpcottin@google.com
Subject: Re: [PATCH v2] vmstate: validate VMStateDescription::fields upon
 registration
Message-ID: <abQflF_Ju2VI7pBa@x1.local>
References: <20260312210802.899803-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312210802.899803-1-rkir@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Mar 12, 2026 at 09:08:02PM +0000, Roman Kiryanov wrote:
> The vmstate_save_state_v() function does not support
> NULL in VMStateDescription::fields and will crash if
> one is provided.
> 
> This change prevents this situation from happening
> by explicitly crashing earlier.
> 
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Peter Xu <peterx@redhat.com>

Thanks for the generosity, all kudos to Fabiano.  Let's replace this line
with:

Reviewed-by: Peter Xu <peterx@redhat.com>

> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> v2:
>  - Moved the assert from vmstate_save_state_v to the registration
>    path (vmstate_register_with_alias_id) and the qtest validation path
>    (vmstate_check) to catch missing fields earlier.
> ---
>  migration/savevm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 197c89e0e6..20c2b99231 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -861,6 +861,8 @@ static void vmstate_check(const VMStateDescription *vmsd)
>      const VMStateField *field = vmsd->fields;
>      const VMStateDescription * const *subsection = vmsd->subsections;
>  
> +    assert(field || vmsd->unmigratable);
> +
>      if (field) {
>          while (field->name) {
>              if (field->flags & (VMS_STRUCT | VMS_VSTRUCT)) {
> @@ -900,6 +902,9 @@ int vmstate_register_with_alias_id(VMStateIf *obj, uint32_t instance_id,
>      /* If this triggers, alias support can be dropped for the vmsd. */
>      assert(alias_id == -1 || required_for_version >= vmsd->minimum_version_id);
>  
> +    /* If vmsd is migratable it MUST have valid fields. */
> +    assert(vmsd->fields || vmsd->unmigratable);
> +
>      se = g_new0(SaveStateEntry, 1);
>      se->version_id = vmsd->version_id;
>      se->section_id = savevm_state.global_section_id++;
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 

-- 
Peter Xu


