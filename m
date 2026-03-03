Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08C2EDA688
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 15:22:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxRZr-0004kU-U6; Tue, 03 Mar 2026 10:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRZm-0004ii-2z
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:22:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxRZj-0006Zp-CM
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 10:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772551336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=06RRmL+t9ChL3v88bXWN1WEewj6Z2ZOCOUR5LUlbABs=;
 b=HFfReeoqwCs9rM4qK0jDRL/5UEmlOPIymFphLvpF8GIy8OpnWiRh6Y1RvNqhzx2dHykiOL
 /KhYbXJvvu1xY0EINivCXyi6slBopKhHngbKum1Lz7ahyacxYm2wgNHGh1vOWq52ERddmS
 WNHpAWxZ0R39dWxduTnR27AV2abTK/I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-dptRpoT3N9S-FqyJEIu4wg-1; Tue, 03 Mar 2026 10:22:15 -0500
X-MC-Unique: dptRpoT3N9S-FqyJEIu4wg-1
X-Mimecast-MFC-AGG-ID: dptRpoT3N9S-FqyJEIu4wg_1772551334
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899f474fae1so173740436d6.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 07:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772551334; x=1773156134; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=06RRmL+t9ChL3v88bXWN1WEewj6Z2ZOCOUR5LUlbABs=;
 b=Nr5cV9S6UIfx+pADszhmclNEG/rQ6eSojzuqFaWnBGsiueA64pKHHnJsnhrQ36/zxr
 UqoEbCgx2u96VLt+QdTT6CGHFhu6yq34/XUShv3Hubl4n490ZHcSymm8fsfW8sMMGEJ7
 PA71p2UWiWWdrXbs3zzScX0qLYV7diHpjR12GSSMgee9+cPIqrdu0GLiHlSHPXP3jIQR
 9n57eGst756RMGfq/wpUHxWqp8bajzR8WglTa9QECY8y3xFb4iUVyaAC4pP3XRIZIIv4
 rNXB4obOyYsxWbWT0tNl5mH1MqTYkGX0bEFtrJtcS0y+g3bzfAHPgPgduCuymb2CbqyB
 ZRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772551334; x=1773156134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06RRmL+t9ChL3v88bXWN1WEewj6Z2ZOCOUR5LUlbABs=;
 b=ZuqL4KAiImZiMclb0b1yBeRbUVoP5iE+adN8xg2NoiH6zBAFvGYFo/Ae1uMj9WvBV4
 DMYfqiLlvLskkkFg2eMrBAc1can4ssfX4saU+TjpaGNlX2h9tWmNRNmDVckT6BpbZ/Yx
 pupM6ORmOkrId6bb9CLhDd7n/HJdLYsoslblP8SKii1qZ/g8t+A8/9/5qpMuDgmbV3NV
 1tawgWNpHM+j3uOY9458HwaeploPu8V5LRfha1gDcWivsssfdAxlgVboe1dj8rbODtgM
 Uve4RqAIMVC6UFdUMvjNycPb9LSXJKDVEAdqI00vynaigMiGOGkcCFYDiogg/ljM2hv7
 uopQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7Pcugjl7nB6PtHu0PeJxFlp4svJEQGUc02x4qpKhFp9aE7+qovrhEWHZDWvL7dw7ZMacc2DP1cnYJ@nongnu.org
X-Gm-Message-State: AOJu0YyUHAptezFkb7dEtjc85Gi1zW5nLF1PW10WVZcW2UUifmkHGn+9
 +zYv1+2nbCjW3MGJETsBN86kejoii+XQn4ZyD3GkwteerzmhRWtvl961z4x4QeVK09fFUNOn/sF
 /naGBAZvym/TIZYesHt+GvGaVia2h0P0lHlLl4CmtQu8teC9InxXS9Fi3
X-Gm-Gg: ATEYQzw0xCAtB2raRXD0qI/XES48A0ldZWNrFA3tuyL/wW88QemgX4aRrBN1oNECnMy
 vLxGDxkNItV5q6RelaUPpiT1rJLYA3qj6X9SoqX6NVBvxq6Z4n5MVpzObF/XDMqrvwrkDgfUjAn
 ZqETe4vOLCX22KSu8Giwhg68onOKv0eYuEfmZr+LRvRxedXwideEKwblDS4r4oA8BvQwbm6JK96
 YTR0MD/q+MsRptSQ6yVgBlKptYQhDfnjz0UwlDiYbALmId+ntVrB5BUKvY2EhxAjzJnkFW3vx0q
 uXyzFYr1PLZh3Af7AuSOoFMnlJfE78k9BMLJVfbl+hf9wYifyrMxkI/nTjSd64WZqkQQYZ38MYd
 R/BFv0agH7FvqiA==
X-Received: by 2002:ac8:5aca:0:b0:506:a290:70d6 with SMTP id
 d75a77b69052e-508ce94f226mr28294391cf.6.1772551333970; 
 Tue, 03 Mar 2026 07:22:13 -0800 (PST)
X-Received: by 2002:ac8:5aca:0:b0:506:a290:70d6 with SMTP id
 d75a77b69052e-508ce94f226mr28293921cf.6.1772551333430; 
 Tue, 03 Mar 2026 07:22:13 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50744ae9313sm134086301cf.29.2026.03.03.07.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:22:12 -0800 (PST)
Date: Tue, 3 Mar 2026 10:22:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 06/16] migration: factor out vmstate_pre_save() from
 vmstate_save_state()
Message-ID: <aab8mnOqwJh3AtgD@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-7-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-7-vsementsov@yandex-team.ru>
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

On Sat, Feb 21, 2026 at 12:02:04AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Simplify vmstate_save_state() which is rather big, and simplify further
> refactoring.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

One trivial thing..

> ---
>  migration/vmstate.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index b07bbdd366..810b131f18 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -430,6 +430,26 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
>      return true;
>  }
>  
> +static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
> +                             Error **errp)
> +{
> +    ERRP_GUARD();

I can come up with no reason a caller should pass in NULL for errp..  I
don't know why we assert(errp) so rarely in qemu for similar cases, but
iiuc that's what we really want here..

> +
> +    if (vmsd->pre_save_errp) {
> +        if (!vmsd->pre_save_errp(opaque, errp)) {
> +            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
> +            return false;
> +        }
> +    } else if (vmsd->pre_save) {
> +        if (vmsd->pre_save(opaque) < 0) {
> +            error_setg(errp, "pre-save failed: %s", vmsd->name);
> +            return false;
> +        }
> +    }
> +
> +    return true;
> +}
> +
>  static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>                                  void *opaque, JSONWriter *vmdesc,
>                                  int version_id, Error **errp)
> @@ -440,18 +460,8 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>  
>      trace_vmstate_save_state_top(vmsd->name);
>  
> -    if (vmsd->pre_save_errp) {
> -        ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
> -        if (ret < 0) {
> -            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
> -            return ret;
> -        }
> -    } else if (vmsd->pre_save) {
> -        ret = vmsd->pre_save(opaque);
> -        if (ret) {
> -            error_setg(errp, "pre-save failed: %s", vmsd->name);
> -            return ret;
> -        }
> +    if (!vmstate_pre_save(vmsd, opaque, errp)) {
> +        return -EINVAL;
>      }
>  
>      trace_vmstate_save_state_pre_save_done(vmsd->name);
> -- 
> 2.52.0
> 

-- 
Peter Xu


