Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81149EDA686
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:39:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRpy-0001Nv-P6; Tue, 03 Mar 2026 10:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRpw-0001Mb-Su
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRpu-0003gt-P2
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772552339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qnp0WS1kDmCWui2rb97PlarS0z+8ZRhkxshtWZDVXV0=;
 b=SKOOESJNQYUamiFzizrmYlfonYzyvVEUb9QShIo+qTDs4Kz4MpvfbOSz9MQYDaXEejBY1+
 NgMb2l4jKmv4jJKJTlPFf4lpXc1qJ4Ub4kZ2dz76qVvrxm1ZcxElhUqAMyw/6as7duwLF2
 BYzhDECRipPtH7M7RuETVrS+JobRBYw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-kZu-MxH2MNiULvY_Jt4cYw-1; Tue, 03 Mar 2026 10:38:58 -0500
X-MC-Unique: kZu-MxH2MNiULvY_Jt4cYw-1
X-Mimecast-MFC-AGG-ID: kZu-MxH2MNiULvY_Jt4cYw_1772552337
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-899fa82ebb9so145344556d6.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772552337; x=1773157137; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qnp0WS1kDmCWui2rb97PlarS0z+8ZRhkxshtWZDVXV0=;
 b=tUSv7lYlVm0hnU0fSmlzyvz27mxLXAft5NBwhmYn3n0/U5ZY7BZNtVwMlbG/erG41z
 dONzqkooBeS6WWt7uaWQiGCPf52nNKcN+ava2+JsjUNFAyxk5fSTMuOQhIeEbc1ShKP2
 /ZRj251VT5ZKuQXvjy2TFG2fheSJgEDLuTFkm4bJV1GrI8GbvgtC9ZgohH7/KiXrTCbk
 ZiQxdgDwyv0O6qpXt7ShuKhUY/Gpl8JFR2q5hqucNdOeUYVj2AlScwq+55XoZsNZuJMt
 DMitWCMhuc/1ofN8yHJajuE5G1QEZbNUssnxulps+E2PO9jRxrMfPRYWjatK6DTFKeMi
 aiRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772552337; x=1773157137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qnp0WS1kDmCWui2rb97PlarS0z+8ZRhkxshtWZDVXV0=;
 b=IpelJxqh5ZUTq9NUrufxxVJ9M2Y2TkAF0zRnORtSMhbVQFco9F2jnfB2pSuxPaHOxJ
 6yJXAT63oLAD6GNwW0Z/AyGZ3VIZg30tArnGoflzBOQ+OtXxp976PFa1/Y1srGzIBR7I
 0MyuQNvRgziKDE4C/0uj8AfQ9BfNJxtfzNsnpr75o9J/00dKog7t7DaH9kD/aEIt/XMZ
 GtbEGTd/29Nm6bKosj8pGAcLbvnAPAtBbI5Qf2UE8vAsquguUmsqk+lvsKjgqfuhah8R
 kqVnHl5CRkwhXUgC511SfWOQjzfWWOI1c4j7DC3RTv9ILF49LuT/tamgx68hssjpCKP8
 rd3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9fbTrJWKEDh9oTpPb/sNCELBij1GXMsAjpSIxwEQyCaVJlYT2hJLLwQyefktl7tGJPU8uk/BvQkb7@nongnu.org
X-Gm-Message-State: AOJu0YwjSaAXOqZ36kjTPp48YGMa58OZlxegdu7UqDyBLLcUj3SzQMAK
 SsPxF/yceFI3qBm6TUoObKKLLPVStv5Aantje50ki1yS8y1E9OuS2FQdl/ZldcCt7nHVy27rJb+
 YFoamV05noHp4PtQQI3wMpikebmgqBYGMrK2v5b1I7CU9rd/nvL/mRLzY
X-Gm-Gg: ATEYQzz7ITQFuLCAMA33T6sFnaO+ZHQlBj/W2iUXMnqodRzZ7dOU87rl5tSLLqpuunb
 tdVfFLEm56RWrCZGXKGthZz6qds3EiimG5VCmL0NLgYH6YH7gUdNcj27EGfo7Q3Xeq7zYVarh4I
 mRnvmFkaEWerKgw0IoBNPQnYqP5TFrNaWNJ3lAuSz7UHa5fLricLGOiatwN42TKU92FgbThsKmF
 GVVDyK6VFJ54VUO3obnRcUb6F5Appjlm5YYI3VPqkrKlI90MaRqortFgZR8WM1XCMR8KHGDeeWO
 br9MRCm6ppbvlFH0hKRZt+4WrrIRkWAxdP0wcEHIsvH9/l2i8C19zQ13RGnTA8Csp0XQvcJxB88
 S/q73VLhbu8jvlA==
X-Received: by 2002:a05:620a:4892:b0:8c7:7a3:501c with SMTP id
 af79cd13be357-8cbc8df715fmr2001297385a.52.1772552337426; 
 Tue, 03 Mar 2026 07:38:57 -0800 (PST)
X-Received: by 2002:a05:620a:4892:b0:8c7:7a3:501c with SMTP id
 af79cd13be357-8cbc8df715fmr2001292885a.52.1772552336898; 
 Tue, 03 Mar 2026 07:38:56 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a083a95fbsm24953276d6.38.2026.03.03.07.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:38:56 -0800 (PST)
Date: Tue, 3 Mar 2026 10:38:45 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 07/16] migration: factor out vmstate_save_field() from
 vmstate_save_state()
Message-ID: <aacAhTY55cp4QgQu@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-8-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-8-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Sat, Feb 21, 2026 at 12:02:05AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Simplify vmstate_save_state() which is rather big, and simplify further
> refactoring.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I wonder how hard it is to have this helper also cover the rest in the loop
over elements, on e.g. VMS_ARRAY_OF_POINTER, vmdesc_loop being able to
change, and all the nullptr handling.

I had a feeling that you intentionally skipped those because it'll not be
as trivial - I think it's fine, but IIUC we can always figure a way out.
Can be done later.  Agree this is an improvement already,

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/vmstate.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 810b131f18..d8c30830d6 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -26,6 +26,9 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
>                                     Error **errp);
>  static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
>                                     void *opaque, Error **errp);
> +static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
> +                                void *opaque, JSONWriter *vmdesc,
> +                                int version_id, Error **errp);
>  
>  /* Whether this field should exist for either save or load the VM? */
>  static bool
> @@ -450,6 +453,26 @@ static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
>      return true;
>  }
>  
> +static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
> +                               const VMStateField *field,
> +                               JSONWriter *vmdesc, Error **errp)
> +{
> +    if (field->flags & VMS_STRUCT) {
> +        return vmstate_save_state(f, field->vmsd, pv, vmdesc, errp) >= 0;
> +    } else if (field->flags & VMS_VSTRUCT) {
> +        return vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
> +                                    field->struct_version_id,
> +                                    errp) >= 0;
> +    }
> +
> +    if (field->info->put(f, pv, size, field, vmdesc) < 0) {
> +        error_setg(errp, "put failed");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                                  void *opaque, JSONWriter *vmdesc,
>                                  int version_id, Error **errp)
> @@ -542,21 +565,8 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                  vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
>                                        i, max_elems);
>  
> -                if (inner_field->flags & VMS_STRUCT) {
> -                    ret = vmstate_save_state(f, inner_field->vmsd,
> -                                             curr_elem, vmdesc_loop, errp);
> -                } else if (inner_field->flags & VMS_VSTRUCT) {
> -                    ret = vmstate_save_state_v(f, inner_field->vmsd,
> -                                               curr_elem, vmdesc_loop,
> -                                               inner_field->struct_version_id,
> -                                               errp);
> -                } else {
> -                    ret = inner_field->info->put(f, curr_elem, size,
> -                                                 inner_field, vmdesc_loop);
> -                    if (ret < 0) {
> -                        error_setg(errp, "put failed");
> -                    }
> -                }
> +                ret = vmstate_save_field(f, curr_elem, size, inner_field,
> +                                         vmdesc_loop, errp) ? 0 : -EINVAL;
>  
>                  written_bytes = qemu_file_transferred(f) - old_offset;
>                  vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
> -- 
> 2.52.0
> 

-- 
Peter Xu


