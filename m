Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87739EB3637
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 21:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxB74-0006BL-8I; Mon, 02 Mar 2026 16:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxB6z-0006Av-6x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxB6v-0007LD-IS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 16:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772488048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p5PXAm01sWCR1rj9OpI/yJDKmDCniShPjVpdtTOgBLA=;
 b=exz96rw59/gTAIh0g4nR26aaAKjcs5Kbh+jrgEepNB1eFN1CvUlrfItAkTAXW/zHYu2/YF
 IObHjevDqU1pD/5F+s8rfIJBStptc/636OJ01OyUh9SkPJkxzWoLgM3CLTZXbqOaHkrcxJ
 /EwDy9Bd8/WIs85iqDAappk+ZlPfbG4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-FXkqA2ZNNgCPY2ZMsr9qvw-1; Mon, 02 Mar 2026 16:47:27 -0500
X-MC-Unique: FXkqA2ZNNgCPY2ZMsr9qvw-1
X-Mimecast-MFC-AGG-ID: FXkqA2ZNNgCPY2ZMsr9qvw_1772488046
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-899ef673d82so36314546d6.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 13:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772488046; x=1773092846; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p5PXAm01sWCR1rj9OpI/yJDKmDCniShPjVpdtTOgBLA=;
 b=I3nsioXyFY42ZD7qnkQwmM5WudqiL9mBbm1iGtgJYlS8L0f2ZMhXDaPkLw90VS4r09
 CHojadhhsM0hAhpoGt9KGWOc2KY2LxhHohPkbno6UNg0kxJb0BFAJBVvMy89JgVMEC1t
 17vFY7rFWaw4LurCUf1ROcmJt5aNc7WKsH1m8f8si6xHkXusVSWblPBA6FVWNRV8Hs/A
 rP/BD2atjHPkbB197ZxvRgQdMHUEtBWKkHpTG6pboeSV7hs57x1X7OFMJ64Vbtyt31hQ
 VriPAr05M5H1nlTBMHZXYpugUUP/zwCOdr8JyXp6T9/KnJkTgvQP+yiAL8dFVOZ/knlR
 aafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488046; x=1773092846;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5PXAm01sWCR1rj9OpI/yJDKmDCniShPjVpdtTOgBLA=;
 b=Y7ldcUu9vcQUtCMGmAnLPOPM3R3I/F9gYvZ1Wi0yn93sdrbGJK2pugqLgshXjI+5dX
 sONvTzArXTtHquSyR699v4+JtZUoQ7AeWoGyInSlKIv3sQM+KFMv61xxXnrbR5R9pJL2
 Inkei/wTVUJ3XtgK/47ZpyKxg7deqkAtjSi6ddk3mylJfCmQEcnQnW3840KwrgyFANPZ
 jhrutVg1WginYYN8iisCUYnHGupRJURmVcNjhol2uxvn9bEI51LvRrTxv5e5DB3UiDOR
 G02E6opxPwpWq5jmzesnqZEPareKkdClWUNlSVfPO54t5xMi8FjEMhhSk7A+yKHzhsjp
 LsHQ==
X-Gm-Message-State: AOJu0YwoGhC7xJZuu2RFTtBhJbINUq3IT6as3p9Jmq193SMeod42QUbQ
 ebWSsdH02udW9wKhDGH9eRPPtPmMxZ0XIid9wBOOZe10xAnVeSphJHZeb7De68BxTl4shJriSRg
 VBAS3crdmdX3LKqsDIjoT2IbgMpWeOaeHO1yWKFv8SBHpnH5hn0PkHJ1r
X-Gm-Gg: ATEYQzy6xDPNsZBtSnaiHRMZfRWvAYwldySUuY+CoAht3DkzFMn2LZQcPMEGxZi2AlA
 ARa3xj43LHsXYcuYCVQqY4lG8gFaTZNcyaZOTOuxJaBGTHRF83Hxlho3cVmEcs0f65G5feotcZK
 dFSBn/Da5/X2OFZjAboPuW+cKQU7qUJNY/PjlsDlT8pZfmFCKbj9xKP4MKNUqPYe1A9RjjoMMbt
 13Rw4ukCRGPjxZMcz41imvCbUEzdwcagN7nquXdEWNjhMW1YbX4MndkU+HVPFnxqm2Q9rqhfLi+
 V3TQ/n2zWiZLMhJQt3lX9g3uY56v9AMMU4YmskObgRh+fzv1NEQ+f3E2lj8XGXI3vCs2Ah0s7KN
 AZLmw4CqT0jm9qQnNhYo4Z441j2yi2umBrmi6ss3JpLuqRf22G6J9q97U2+e0TB5nz548QSjs10
 c2BLiClQ==
X-Received: by 2002:a05:6214:ac7:b0:899:f5a4:8110 with SMTP id
 6a1803df08f44-899f5a48831mr86269336d6.56.1772488046384; 
 Mon, 02 Mar 2026 13:47:26 -0800 (PST)
X-Received: by 2002:a05:6214:ac7:b0:899:f5a4:8110 with SMTP id
 6a1803df08f44-899f5a48831mr86268946d6.56.1772488045830; 
 Mon, 02 Mar 2026 13:47:25 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a04849c78sm16753746d6.10.2026.03.02.13.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 13:47:25 -0800 (PST)
Date: Mon, 2 Mar 2026 16:47:24 -0500
From: Peter Xu <peterx@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH 3/4] migration: add
 VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC
Message-ID: <aaYFbKP8o6A2QY8D@x1.local>
References: <20260217152517.271422-1-alexander@mihalicyn.com>
 <20260217152517.271422-4-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217152517.271422-4-alexander@mihalicyn.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

On Tue, Feb 17, 2026 at 04:25:16PM +0100, Alexander Mikhalitsyn wrote:
> From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> 
> Add VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC, which
> helps to save/restore a dynamic array of pointers to
> structures.

Sorry for the late response.

> 
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> ---
>  include/migration/vmstate.h | 21 +++++++++
>  migration/vmstate-types.c   | 88 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 89f9f49d20a..bc6495a7f67 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -265,6 +265,7 @@ extern const VMStateInfo vmstate_info_bitmap;
>  extern const VMStateInfo vmstate_info_qtailq;
>  extern const VMStateInfo vmstate_info_gtree;
>  extern const VMStateInfo vmstate_info_qlist;
> +extern const VMStateInfo vmstate_info_ptrs_array_entry;
>  
>  #define type_check_2darray(t1,t2,n,m) ((t1(*)[n][m])0 - (t2*)0)
>  /*
> @@ -537,6 +538,26 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     = vmstate_offset_array(_s, _f, _type*, _n),          \
>  }
>  
> +/*
> + * For migrating a dynamically allocated uint32-indexed array
> + * of pointers to structures (with NULL entries and with auto memory allocation).
> + *
> + * _type: type of structure pointed to
> + * _vmsd: VMSD for structure
> + * start: size of structure pointed to (for auto memory allocation)
> + */
> +#define VMSTATE_VARRAY_OF_POINTER_TO_STRUCT_ALLOC(_field, _state, _field_num, _version, _vmsd, _type) { \
> +    .name       = (stringify(_field)),                                \
> +    .version_id = (_version),                                         \
> +    .num_offset = vmstate_offset_value(_state, _field_num, uint32_t), \
> +    .info       = &vmstate_info_ptrs_array_entry,                     \

I wonder if we need this hard-coded new info structure for this, more
below.

> +    .vmsd       = &(_vmsd),                                           \
> +    .start      = sizeof(_type),                                      \
> +    .size       = sizeof(_type *),                                    \
> +    .flags      = VMS_VARRAY_UINT32|VMS_POINTER,                      \
> +    .offset     = vmstate_offset_pointer(_state, _field, _type *),    \
> +}
> +
>  #define VMSTATE_VARRAY_OF_POINTER_UINT32(_field, _state, _field_num, _version, _info, _type) { \
>      .name       = (stringify(_field)),                                    \
>      .version_id = (_version),                                             \
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index 89cb2114721..3335377cd07 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -942,3 +942,91 @@ const VMStateInfo vmstate_info_qlist = {
>      .get  = get_qlist,
>      .put  = put_qlist,
>  };
> +
> +static int put_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_size,
> +                                const VMStateField *field, JSONWriter *vmdesc)
> +{
> +    const VMStateDescription *vmsd = field->vmsd;
> +    int ret;
> +    Error *local_err = NULL;
> +    void *pv;
> +
> +    /*
> +     * (ppv) is an address of an i-th element of a dynamic array.
> +     *
> +     * (ppv) can not be NULL unless we have some regression/bug in
> +     * vmstate_save_state_v(), because it is result of pointer arithemic like:
> +     * first_elem + size * i.
> +     */
> +    if (ppv == NULL) {
> +        error_report("vmstate: put_ptrs_array_entry must be called with ppv != NULL");
> +        return -EINVAL;
> +    }
> +
> +    /* get a pointer to a structure */
> +    pv = *(void **)ppv;

Here IIUC it's almost what VMS_ARRAY_OF_POINTER should do.  Could we
declare the vmsd with VMS_ARRAY_OF_POINTER so as to save this open-coded
dereference of pointer?

> +
> +    if (pv == NULL) {
> +        /* write a mark telling that there was a NULL pointer */
> +        qemu_put_byte(f, false);
> +        return 0;
> +    }
> +
> +    /* if pointer is not NULL, dump the structure contents with help of vmsd */
> +    qemu_put_byte(f, true);
> +    ret = vmstate_save_state(f, vmsd, pv, vmdesc, &local_err);

This looks really like VMS_STRUCT, except that it also tries to detect if
the pointer is NULL, then save some dumps.

Is it feasible to make both queues to always be available so as to reuse
VMS_STRUCT?  Or is it intentional here to avoid dumping queues where the
pointer is NULL?

Even if for the latter, I wonder if we can have better way to do it.  For
example, if we can integrate this directly into vmstate_save/load_state()
to support some new flag, VMS_ARRAY_OF_POINTER_DYNAMIC, then we can declare
some more "official" way to say some pointer of an dynamic array is NULL.

Thanks,

> +    if (ret) {
> +        error_report_err(local_err);
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
> +static int get_ptrs_array_entry(QEMUFile *f, void *ppv, size_t unused_size,
> +                                const VMStateField *field)
> +{
> +    int ret = 0;
> +    Error *local_err = NULL;
> +    const VMStateDescription *vmsd = field->vmsd;
> +    /* size of structure pointed to by elements of array */
> +    size_t size = field->start;
> +
> +    if (ppv == NULL) {
> +        error_report("vmstate: get_ptrs_array_entry must be called with ppv != NULL");
> +        return -EINVAL;
> +    }
> +
> +    /*
> +     * We start from a clean array, all elements must be NULL, unless
> +     * something we haven't prepared for has changed in vmstate_save_state_v().
> +     * Let's check for this just in case.
> +     */
> +    if (*(void **)ppv != NULL) {
> +        error_report("vmstate: get_ptrs_array_entry must be called with *ppv == NULL");
> +        return -EINVAL;
> +    }
> +
> +    if (qemu_get_byte(f)) {
> +        void *pv;
> +
> +        /* allocate memory for structure */
> +        pv = g_malloc0(size);
> +        ret = vmstate_load_state(f, vmsd, pv, vmsd->version_id, &local_err);
> +        if (ret) {
> +            error_report_err(local_err);
> +            g_free(pv);
> +            return ret;
> +        }
> +
> +        *(void **)ppv = pv;
> +    }
> +
> +    return ret;
> +}
> +
> +const VMStateInfo vmstate_info_ptrs_array_entry = {
> +    .name = "ptrs_array_entry",
> +    .get  = get_ptrs_array_entry,
> +    .put  = put_ptrs_array_entry,
> +};
> -- 
> 2.47.3
> 

-- 
Peter Xu


