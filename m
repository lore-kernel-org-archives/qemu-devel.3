Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39B7CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkBQ-0005fU-L0; Mon, 22 Jun 2026 15:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbkBP-0005fJ-6v
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wbkBN-0007Sf-Oz
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782155984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ArlL/K4PQS9R2JFdvSHgnWwQplhUvBDXK0L5R9yhgA8=;
 b=cexQTW7Z08btly16zVul8DqOEJcDdwUfTR0GEXJqtRL9SYIxOfamnZDhw3xk1EfUZ4E+1/
 3wWLQ562DsZuTgWDZG9f5cPfenLcm8Ne7OR9nEzadfomxHq8Vyl84FPe44NeZsgIXbaAuO
 AqwRM5EYE/M4v+oJejO1MBhrlnDBK2M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-Rh_Xk_t7NSyPaeY6OQCsrg-1; Mon, 22 Jun 2026 15:19:40 -0400
X-MC-Unique: Rh_Xk_t7NSyPaeY6OQCsrg-1
X-Mimecast-MFC-AGG-ID: Rh_Xk_t7NSyPaeY6OQCsrg_1782155980
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157f1be083so819344885a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782155980; x=1782760780; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ArlL/K4PQS9R2JFdvSHgnWwQplhUvBDXK0L5R9yhgA8=;
 b=BRHpwLp4xwRfEvJ1IJU7+eHPHrcYcJNCPBq8xg9SzGsbI0TscbkmvgFpKiQ73jXwXe
 W8pk/Ichu7AK8CYZcHL/ymH/R2Kxf0WolNRTypVXOGSkb/Cw0LwvG5/XXWzr3sHUgmcF
 k/nyhS7d5EmD8phL8k4woUia233CO9kLuBBMJLtY3EwHiXzRLXVhllCXrUxwip74+xK4
 vDIjtu9I6kIwPED+0OQr5Um5tKqfjzEsxZyUd2XBXh9JyS8eZFnTkC1q4f2oA/R36mCp
 BxAaj4pqJVmmzWqVdHlJbj43ejgb7kYPIu5OfJ7pyut401apixrYPQ+fGfwC60QPQnPS
 6/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782155980; x=1782760780;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArlL/K4PQS9R2JFdvSHgnWwQplhUvBDXK0L5R9yhgA8=;
 b=XJx+sQu6v5U0H22CTQ6ojM7EY5w6qECxHGVYxBOZJwcv+ETJLuzBh8DHgKd5KlRGRj
 lyr5lmBwmf/F91hdhcBQdgMKPCnObrByycF2uuw4N09uOrGs7l0VEMbN49AJJE/1GFvc
 w6SvTATzD5wKVPW3zoQiDOPW08BiCWWlH+/tvVvsK1OsMYJmzc1xK5PZp/+Dsc6wpjFH
 lgwf5vsbDGISNFZDTw+VckM3ZEH/lEKb/8u4ZcAps9oPej1FIKic4dCUQcgQKvxkSYvh
 WimmdbOkvuDBTe6OOtn+oKxvHNMybHFKNq9zyw6IS3c2F5l9V95XjGXP3dIwAjuFw846
 UXdg==
X-Gm-Message-State: AOJu0YwQ5gLDJKStKsSTqO6L6OMvWt5nq0OApImQ21SahIom6fR+91Bn
 aDQCL5yAVBRX+eIEXMZu+E59yZEg4oXUa24syuoH4eYGQq42sILSgFVDomyERBUvUyKmPxBzoFL
 4b/22RuhJMOPWS2EbVu5LST/F3/dy4/gKM5pykjibQ7q3RfSWyPF9i8ld
X-Gm-Gg: AfdE7cnSv0gOifFnYlo9/iBVcpqVKtN88G8IFjwaxNbBU3PQzyj1GXQz+vXUoGkSeAE
 N8za/pRpmo5gNDypyb63iPpTKLNm+MMufGnOBcMibOvzcs8T4RiM37tyqlYJKa6B8/QKDqdxlub
 uGsi+gSe3WiPVBtjOnGSZITUtpst3phWQD9rI9+N5ZVB40lydm/6XNLP+enSEnwOPv9xLAjV1yd
 Ko2LJPx8ov2dt2HXphwgpbmg60egAxRniwuTDKm4+0+cR75h5Jcsl4hZ/lmL4GrJbnaJFjqejA4
 QObyhLuX7iWhvzprAlC/jxfclcF32Pb0bwWizjXzY5otRJ/hkUpVGGc6/U8X5wOXCU2+AGLF+w1
 eKmI/WZ2CJpGvj4DaIN8kxCepcX40ROBUj3+w/EJ+cphG90OW+2cB4OLEyiEIHP5amGcNvy88
X-Received: by 2002:a05:620a:45ab:b0:915:9fba:878f with SMTP id
 af79cd13be357-921d0b3601fmr1786162485a.5.1782155979850; 
 Mon, 22 Jun 2026 12:19:39 -0700 (PDT)
X-Received: by 2002:a05:620a:45ab:b0:915:9fba:878f with SMTP id
 af79cd13be357-921d0b3601fmr1786156085a.5.1782155979242; 
 Mon, 22 Jun 2026 12:19:39 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-157.dsl.bell.ca. [174.91.117.157])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-925fda621f7sm58985785a.15.2026.06.22.12.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:19:38 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:19:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com
Subject: Re: [RFC PATCH 0/5] migration: fast snapshot load
Message-ID: <ajmKyRQtzOl7rCIM@x1.local>
References: <20260618032010.88755-1-aadeshveer07@gmail.com>
 <CA++cPvLSxOLmLDpq4AwYndT1jvu6j17YQLxUexLX1MkxMtCznw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA++cPvLSxOLmLDpq4AwYndT1jvu6j17YQLxUexLX1MkxMtCznw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 19, 2026 at 06:48:57PM +0530, Aadeshveer Singh wrote:
> From 70ab2949ef99968c2fc16e6a0d9860a993514367 Mon Sep 17 00:00:00 2001
> From: Aadeshveer Singh <aadeshveer07@gmail.com>
> Date: Fri, 19 Jun 2026 18:12:36 +0530
> Subject: [PATCH] migration: postcopy-blocktime support for fast snapshot load
> 
> Add postcopy-blocktime support to fast snapshot load by calling
> mark_postcopy_blocktime_begin(), on all page faults intercepted by fault
> thread.
> 
> There is no need to call mark_postcopy_blocktime_end(), as
> postcopy_mapped_ram_load_page() calls postcopy_place_page() and
> postcopy_place_page_zero() which call the end marking internally.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> ---
>  migration/postcopy-ram.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 0ee294a381..2f4698fbed 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1436,6 +1436,12 @@ static void *postcopy_ram_fault_thread(void *opaque)
>                                                  msg.arg.pagefault.feat.ptid);
>  
>              if (migrate_fast_snapshot_load()) {
> +                WITH_QEMU_LOCK_GUARD(&mis->page_request_mutex)
> +                {
> +                    mark_postcopy_blocktime_begin(msg.arg.pagefault.address,
> +                                                  msg.arg.pagefault.feat.ptid,
> +                                                  rb);
> +                }
>                  if (postcopy_mapped_ram_load_page(
>                          mis, rb, rb_offset, msg.arg.pagefault.address, 1)) {
>                      break;

Let's squash this directly to your core patch 4, then mention it in the
commit log.

Even if I left quite some comments, most of them are small nitpicks. It's
good to know there're only a few postcopy functions need some touch, and
most logics can be reused.

The RFC series looks a great start, thank you!

-- 
Peter Xu


