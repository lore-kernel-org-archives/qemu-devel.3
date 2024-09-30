Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC6FCE835E
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 15:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svITu-00022B-CK; Mon, 30 Sep 2024 11:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svITs-00021h-7J
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:38:36 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svITq-0007kd-9t
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:38:35 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c88b5c375fso2993930a12.3
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 08:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727710712; x=1728315512; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NDUaLykjQpA0k0/b9nwJpP5Bl7EtsznFNhLpL07taJU=;
 b=qw5GNqycPEO72e2/cGyRKqiodMjjDMQijsO5AaeKHwCeOd7ZYA2ggG853oOTyy9hA8
 OhorI+lxgNwU6VYaDwuPfzE1QrAut1gTYXg1qpmEE/B+Kzc6sivQWwG3bVYYe3PsV373
 tGyg3h+XIXPoOKe8aGF80I+1kXncNlROYHvZ2Mit/OH2s5hAc/TmvN7Odf6DyaIZj+oj
 1WGTMwYzGpaSR5+efVPj4/vIxXyC0kzgiCZUKC08ForUuSdRVbW2LrkfmEJAnZhaa+sr
 yU7QxEODxNkgUhDlB42FAuTffcX5vpm6oSK+sOZTirFTWAn6elGDm5rbDGoDTHRCdAY/
 mnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727710712; x=1728315512;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NDUaLykjQpA0k0/b9nwJpP5Bl7EtsznFNhLpL07taJU=;
 b=jP7mnAIl9OcEnVSyd9c48oludQ+cFNx7fqJcz8JZfdG327WnhUZf+3TECWV+kdarOk
 B/Nt371puNu+8LIsrgQYXs3V/q+H+4ybu8QWFRUa2oOg5RR4Ad7xrTUqMFX8RPzevkjR
 rARnjH+6QnF9fMmqi4pN/RqpwtUC/9VHIyn5V8YZrdYAL2vLOArVk8mXyfduibyOnwkE
 GxWSF1dUJd573U4OeliMJrnq8HRXloHZ7Lm/3mYyQQcRTVQoc/85zy7Gzla9ibjs1JhX
 wDrP/AJ52GLLj0vjPcvDB+dw/qdAwR8HG0FaC2xW1GsLXvA4n0vvCkWyZ87iUXPX2O84
 D7BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCietuQqOGCHDlkIFGDOPyRd9cCqN/ehDSSVXRlMOdmNWry0FE2Ek/GF53iNcBnP+9ghTPqpqXZypM@nongnu.org
X-Gm-Message-State: AOJu0YzClKFLU4oUN0ISzXVAkvItggw2hqJpYpF4QpukNVhKYQ5s2d5F
 mq4YeGV9SiiVJZcCSCu97P/+1tSkaW5coXYnSvRvy01dEdYssRLlcBEU37RjFNk3hAAodvCY0u4
 teAoxHvN61OwNEanotU+Ug303QpesXoal6o+TlQ==
X-Google-Smtp-Source: AGHT+IGkqH3JmkfH7BL5H0B3Bu+z47h4nTUl0RSy81pzWQ/yplo6+yYdCrSkey9u4rovtC3mj7PwJPkMBMs5AzN0mQY=
X-Received: by 2002:a05:6402:42c4:b0:5c5:cbfd:b3a8 with SMTP id
 4fb4d7f45d1cf-5c8824ccc12mr10713522a12.1.1727710712150; Mon, 30 Sep 2024
 08:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240915145339.1368029-1-alexjlzheng@tencent.com>
In-Reply-To: <20240915145339.1368029-1-alexjlzheng@tencent.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 16:38:20 +0100
Message-ID: <CAFEAcA81qhzHDmzZC0ywfrxjvQcRytb942b+CAh7VKCsnLLVWw@mail.gmail.com>
Subject: Re: [PATCH] qom: fix NULL pointer in object_initialize_with_type()
To: alexjlzheng@gmail.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net, 
 qemu-devel@nongnu.org, Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 15 Sept 2024 at 17:12, <alexjlzheng@gmail.com> wrote:
>
> From: Jinliang Zheng <alexjlzheng@tencent.com>
>
> Currently, object_initialize_with_type() calls object_class_property_init_all()
> before initializing Object->properties. This may cause Object->properties to
> still be NULL when we call object_property_add() on Object.
>
> For exmaple, if we extend DEFINE_PROP_ARRAY() to a version with a default value
> other than 0:
>         #define DEFINE_PROP_ARRAY_EXAMPLE(_name, _state, _field,        \
>                                 _arrayfield, _arrayprop, _arraytype)    \
>                 DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),              \
>                         _state, _field, qdev_prop_arraylen_virtio_net,  \
>                         uint32_t,                                       \
>                         .set_default = true,                            \
>                         .defval.u = <non-zero>,                         \
>                         .arrayinfo = &(_arrayprop),                     \
>                         .arrayfieldsize = sizeof(_arraytype),           \
>                         .arrayoffset = offsetof(_state, _arrayfield))
> We should have:
>         object_initialize_with_type
>           object_class_property_init_all
>             ObjectProperty->init() / object_property_init_defval
>               ...
>                 set_prop_arraylen

There's no set_prop_arraylen function in the codebase. Which
function do you mean here ?

>                   object_property_add
>                     object_property_try_add
>                       g_hash_table_insert(Object->properties)   <- NULL
>           obj->properties = g_hash_table_new_full()             <- initializing
>
> This patch fixes the above problem by exchanging the order of Ojbect->properties
> initialization and object_class_property_init_all().

So this happens only if the initializer for a class property attempts
to add a property to the object, right? That seems quite niche,
and it would be good to clarify that in the commit message.

I do wonder if it's something we ever intended to support.
In particular note that you cannot currently validly add a *class*
property to the class in the initializer for a class property
(because it would invalidate the iterator over the class properties).

Do you have a more concrete example of something you want to do
that you're currently running into this with?

> Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index 157a45c5f8..734b52f048 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -556,9 +556,9 @@ static void object_initialize_with_type(Object *obj, size_t size, TypeImpl *type
>      memset(obj, 0, type->instance_size);
>      obj->class = type->class;
>      object_ref(obj);
> -    object_class_property_init_all(obj);
>      obj->properties = g_hash_table_new_full(g_str_hash, g_str_equal,
>                                              NULL, object_property_free);
> +    object_class_property_init_all(obj);
>      object_init_with_type(obj, type);
>      object_post_init_with_type(obj, type);
>  }

On the other hand doing the initialization in this order
is certainly safe, so if it's all we need to do to handle
class prop initializers adding object properties maybe it's
fine to do so.

thanks
-- PMM

