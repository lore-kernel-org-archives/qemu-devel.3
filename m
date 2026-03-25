Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B889109C048
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Rhu-0000wD-Og; Wed, 25 Mar 2026 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5Rht-0000vl-0X
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w5Rhr-0007RA-DD
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774458465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N2lw7/zZDYpBP7c+P6ld1nNIZwotUhEH9R1hopqB+h8=;
 b=hM0sNjz0McwftcBgHhEe5q0XhHVuj4IcgwyPsIOKUFDSN4SWy1VwiAihIz/PR5G8TpSfdv
 knE9+3APfbGwVCTCr681z8ztUujtKtxGgUIwViMqAMOKlZkvR3ItkgHFSfWsK7raYrZvnE
 zQ6JIzfqLMnSFiOnLym0SnagTQAmHss=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-uhbpv1x5OU6QXy62RAWsqg-1; Wed, 25 Mar 2026 13:07:43 -0400
X-MC-Unique: uhbpv1x5OU6QXy62RAWsqg-1
X-Mimecast-MFC-AGG-ID: uhbpv1x5OU6QXy62RAWsqg_1774458463
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5091327215dso255831cf.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774458463; x=1775063263; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N2lw7/zZDYpBP7c+P6ld1nNIZwotUhEH9R1hopqB+h8=;
 b=AJmRYZwGdLH2eRrizoSnzTxO59KBl2wYTvSoWNg6bauC82E4MX4aFVG9jJ8FDDH4fM
 sUs7u//8YIrx5pMg4jba/tdPpMzaLNX89ZFPY753ntzC8XnJGuELejy+e8rDH3Lqmejg
 0Z3O14kC8vXSQH+Ap+d+T6tN5aetX6a0hRER7DWVMefx9WqjvQy3wtVTYfDqeUisWUEJ
 jfKdxeEMW7Z8zYXF6jbuDxix1Nx1F3hL49IWaE0OZAM8QDTx3Yk1Vq/ukERIcSVd8bEI
 7XFI+0wJWcH7bmU1OOoPuqDj3l3X6K3kB/JAc8waLqhquNmdz2oQgfZXhXgnVIs7x/xm
 JUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774458463; x=1775063263;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2lw7/zZDYpBP7c+P6ld1nNIZwotUhEH9R1hopqB+h8=;
 b=hE5nsrvRNzM/5SQdUO/Y6nLSecL1DwHBg/zzKWKQdk/2cXvSjNzepF2JD04Hh8yRil
 JoT96StNKU1agJ2snDgCBK2AwLl1apt0X8mpzEiY+2CKOzmpjs7mpR8cHqc2J1fEsMnd
 z8QhXffTRlzb3LjN//nYWkzPjpXhNvKObtyjYsJSNutYelSOwMZbwC64wF4olYLXnm1u
 yMiB8UrdtJo33mB4zIyTBVSV3+kUKLd0et1q++uEMh+bSbUamVZs06yJmO899VtNXhC6
 SX4eWXT0135/+Vc2POQJmymY6ruJkkbt6cetkEkSggE5pJ/B/1+8UwtAYVLduKqGgIqh
 4hPw==
X-Gm-Message-State: AOJu0Yw6wdGjS3Bk345kre2vhZ7KvEgCq+FySGaHQGrSDXMvRAflVeHr
 Hlchj9lUzS1Itu4RAl28uKrKuqLlRj+bUModiNXFrLaKC3AhTjr683w8MmTEtQjCpGATOPRwxoJ
 iw8BGQ+pi4FCE5u3jtFe9XNRKZpNlQVu7e2Q6sGvuy9xCrdjE0ZeGolQL
X-Gm-Gg: ATEYQzxr7vk+gp1JcCLHstqy7tGs9zhRmQEj64mfZc1m5ZIysksZ9xOT8Vxtig9m88L
 y91ht6lHfhqbXn3CQwp38n6WuulM4jfIrvpcNiJAwuKV7E7NOMZMv9BJOxaoEW9Ptvzylcz6COD
 4l14UskufX6VvFMIcs756Yyy4b7xK36N4MKt2cDTF8xcKwXWpAhKqRNODROZXAyIFTJQKmI0wxO
 z0iTuSS8UqD09aYqshuToUtHrvSvR0/KBBAmCEVOuLRJQkysBvm5yBfdWinpIoi0MIKh9QuDM+J
 7PEiAFpBJhshTJdZ+P8UrtauYQwX4bCXHct6g4rYIv+Xfe/hsuhAskk6alQK3fVHtFLAGIJFqyJ
 ba6imdw/RRvIELw==
X-Received: by 2002:a05:622a:5b95:b0:509:2448:41a with SMTP id
 d75a77b69052e-50b80de0052mr59922011cf.42.1774458462736; 
 Wed, 25 Mar 2026 10:07:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5b95:b0:509:2448:41a with SMTP id
 d75a77b69052e-50b80de0052mr59921411cf.42.1774458462154; 
 Wed, 25 Mar 2026 10:07:42 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b9239fd9bsm2893441cf.22.2026.03.25.10.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:07:41 -0700 (PDT)
Date: Wed, 25 Mar 2026 13:07:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [RFC PATCH v1 05/17] vmstate: Remove vmdesc_loop
Message-ID: <acQWXMP1VjSeXUvL@x1.local>
References: <20260324194333.30004-1-farosas@suse.de>
 <20260324194333.30004-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260324194333.30004-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Mar 24, 2026 at 04:43:20PM -0300, Fabiano Rosas wrote:
> The vmdesc_loop variable is being used as a hacky way of writing the
> JSON description only for the first element of a compressed
> array. There are also a few implicit uses, such as writing the JSON
> for the first non-compressed element after a compressed portion.
> 
> Future work will have trouble with this. Use a simple boolean to be
> explicit now.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/vmstate.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index dec9cf920b..7a12245d36 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -622,8 +622,9 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>              void *first_elem = opaque + field->offset;
>              int i, n_elems = vmstate_n_elems(opaque, field);
>              int size = vmstate_size(opaque, field);
> -            JSONWriter *vmdesc_loop = vmdesc;
>              bool is_null_prev = false;
> +            bool use_vmdesc = true;
> +
>              /*
>               * When this is enabled, it means we will always push a ptr
>               * marker first for each element saying if it's populated.
> @@ -673,7 +674,7 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                      is_null != is_null_prev) {
>  
>                      is_null_prev = is_null;
> -                    vmdesc_loop = vmdesc;
> +                    use_vmdesc = true;
>  
>                      for (int j = i + 1; j < n_elems; j++) {
>                          void *elem = *(void **)(first_elem + size * j);
> @@ -686,8 +687,13 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                      }
>                  }
>  
> +                if (use_dynamic_array) {
> +                    use_vmdesc = true;
> +                }

[1]

> +
>                  ok = vmstate_save_field_with_vmdesc(f, curr_elem, size, vmsd,
> -                                                    inner_field, vmdesc_loop,
> +                                                    inner_field,
> +                                                    use_vmdesc ? vmdesc : NULL,
>                                                      i, max_elems, errp);
>  
>                  /* If we used a fake temp field.. free it now */
> @@ -708,19 +714,16 @@ static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
>                       * NOTE: do not use vmstate_size() here because we want
>                       * to dump the real VMSD object now.
>                       */
> -                    ok = vmstate_save_field_with_vmdesc(f, curr_elem,
> -                                                        field->size, vmsd,
> -                                                        field, vmdesc_loop,
> -                                                        i, max_elems, errp);
> +                    ok = vmstate_save_field_with_vmdesc(
> +                        f, curr_elem, field->size, vmsd, field,
> +                        use_vmdesc ? vmdesc : NULL, i, max_elems, errp);
> +
>                      if (!ok) {
>                          goto out;
>                      }
>                  }
>  
> -                /* Compressed arrays only care about the first element */
> -                if (vmdesc_loop && vmsd_can_compress(field)) {
> -                    vmdesc_loop = NULL;
> -                }
> +                use_vmdesc = false;

Hmm...

vmsd_can_compress() can return arbitrary things depending on the field
itself, now we always do the dedup almost for everything.

The patch did add above [1] to make AUTO_ALLOC be ok, by enforce setting
TRUE for it for every loop, but what about other cases where
vmsd_can_compress() may return false (where the field does not support
compression)?

>              }
>          } else {
>              if (field->flags & VMS_MUST_EXIST) {
> -- 
> 2.51.0
> 

-- 
Peter Xu


