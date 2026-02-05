Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C264EECD9A9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7AN-00017a-IC; Thu, 05 Feb 2026 16:45:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7AJ-000153-Vi
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:45:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo7AF-0005i2-LV
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 16:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770327916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W1fQYKfdhpOC3AoT3ssi224pCnItO+N3X1YeHec3L28=;
 b=AaTg8ATyS8G81oJ65ih6XTIfDgd/pSAn17JuFKQZBKGxntgg3zYK+J6dEcd/HXCvQ2hmZU
 ppdh3U9m3KTIsoFr/3Rm4GB8IkjSJfC0fToQPBDeouQthM8KgP+WsoIRoU3v3nUVJhq/jg
 5brqQ4N+lMCdZehZRAHcSluPePAXdMI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-BwQGiE0tNs6dS6ywts5NBg-1; Thu, 05 Feb 2026 16:45:15 -0500
X-MC-Unique: BwQGiE0tNs6dS6ywts5NBg-1
X-Mimecast-MFC-AGG-ID: BwQGiE0tNs6dS6ywts5NBg_1770327913
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8946f1b8691so43392726d6.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 13:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770327913; x=1770932713; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W1fQYKfdhpOC3AoT3ssi224pCnItO+N3X1YeHec3L28=;
 b=Wdk0f2lD/WH/F91QHAb4LE4Ehp2rBNpSCPwjF3R31T7q80sHvQrt3ewIg6ozJ/ZZ0B
 e/2LjrJ8PnMHVaJ79JiAA9mQfxGCDCj0HyKX2rjBkAQAoFxzartRCoGGMZUC/zwHRBV/
 MEgAlLXAnWXZ3xAvjMNrk0jRfeDzmZbZ7V0tob9vAV1pAUZ2RX8p4eUmbaVAKDVIA8VT
 QJZ0Y4A928DTgt3DexrShUgyObEEHIJx9DRR3/V41z+gcvPzCQ5t7UjyOedB8h7yV2hD
 EcWu9ufIIAJ/VnP8a6bFp6cvbew2hR3U8mM9AcBENR/CXwMDjYzUSiygKAQ9l/22LsJ2
 McqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770327913; x=1770932713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1fQYKfdhpOC3AoT3ssi224pCnItO+N3X1YeHec3L28=;
 b=JAMlFbGpq5Dxw3d4FAvJxWgq8l3Orbj3I2mnPP9h88Fl1crsMgT1CyorNF8HylQEob
 vexPaaJEhp3lR5WGpBQSnGN3ZoiVT0XHbWgrWMzKvv1jEushvTwSO3JWqrJuWg6qccVs
 DqswpAnF3v/4V4gcunjN4GnUietGw10IoCRk+SXKyp+NF2IPzVIAjX6akIUpHTAAl0w3
 XHIHuU6POuqPHbdCojil/U5NxJ4yQLsEx//1pYG3p0zBmC7KcCaDof9gYwjzq3c3HgDn
 v3DiMxpZOrGLk6SKpLLf7VQ1QuZk9VfXre+A/cnfFQ+PxHz1gROmeZJRSwBY8B9ncguv
 fUmA==
X-Gm-Message-State: AOJu0Yw52q+yGB/WYcHU1KOQjUHA2UzoQOYqfU+Z4gjx6Iqe5vh8Ic7X
 UcTjHsFHJTZxEf+DsMTlPnHQEtbk+PuD0MkeZrRactwS2dOfkTH88JrU6rE8OhcMmkeJw09QI9F
 Qt/JhdLr2NqWGXrHmSG8Gd+PRr2YR4oIyXkspWitFIh0oBIEhqy3YNtAu
X-Gm-Gg: AZuq6aI5znMLzKJHIJOnd0V7W3LJyynFqwNOk4RQ2GXrST7v8iDjxEL1iCGPZpumyvV
 8Bqoc3n97ztoji8setemkJogk0d5nASSxNYLUFYIeMfI0tsbm1rV+8T7uPOuiQLQfs3xjXBElJk
 cUz8vRrVyjotZtwuGJnfczi5XAk/kxkV8qU5LX+TeQ8FteoP+AYwXT55BzkpfVYcsQEPQ7okCCs
 gnHzPgcE1SxAHiE0Yw9s60g5/LCWAM0ksleR07tiIqV5qRtLuHkK9H7DkAEtxPnURt+MCFhDSL/
 c6hVU4XnPf9uKeEgCaF5jwzfb/yADVfzDw/0TYxWarqrDFrpFj+fR+GQ1nj59kZShw7dG7IMfh1
 b+xc=
X-Received: by 2002:a05:6214:f23:b0:895:b3b:224e with SMTP id
 6a1803df08f44-8953ca7ec51mr8710356d6.37.1770327913233; 
 Thu, 05 Feb 2026 13:45:13 -0800 (PST)
X-Received: by 2002:a05:6214:f23:b0:895:b3b:224e with SMTP id
 6a1803df08f44-8953ca7ec51mr8709816d6.37.1770327912744; 
 Thu, 05 Feb 2026 13:45:12 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9ee9efasm22440985a.43.2026.02.05.13.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 13:45:12 -0800 (PST)
Date: Thu, 5 Feb 2026 16:45:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2 4/9] qapi: Implement qapi_dealloc_present_visitor
Message-ID: <aYUPZ6ZnWCgxvLxh@x1.local>
References: <20260202224101.20568-1-farosas@suse.de>
 <20260202224101.20568-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260202224101.20568-5-farosas@suse.de>
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

On Mon, Feb 02, 2026 at 07:40:56PM -0300, Fabiano Rosas wrote:
> Implement a visitor that frees the pointer members of the visited QAPI
> object in the same way that qapi_dealloc_visitor does, but similarly
> to qobject_input_visitor, takes an input QObject that will dictate
> which members get freed and which don't. Members not present in the
> input QObject will be left unchanged in the visited QAPI object.
> 
> This is useful to free memory just before perfoming a visit with
> qobject_input_visitor on a pre-existing, non-null QAPI object. If the
> same QObject is passed to both visitors, the pointers overwritten by
> the input visitor match the ones that are freed by the dealloc
> visitor.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  include/qapi/dealloc-visitor.h |   6 ++
>  qapi/qapi-dealloc-visitor.c    | 173 ++++++++++++++++++++++++++++++++-

First of all, I saw that all prior visitors should always have unit tests
under tests/unit/.  Maybe we should also attach an unit test?

>  2 files changed, 178 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qapi/dealloc-visitor.h b/include/qapi/dealloc-visitor.h
> index c36715fdf3..96c7bf35c3 100644
> --- a/include/qapi/dealloc-visitor.h
> +++ b/include/qapi/dealloc-visitor.h
> @@ -25,4 +25,10 @@ typedef struct QapiDeallocVisitor QapiDeallocVisitor;
>   */
>  Visitor *qapi_dealloc_visitor_new(void);
>  
> +/*
> + * Like qapi_dealloc_visitor_new but visits a QObject and only frees
> + * present members.
> + */
> +Visitor *qapi_dealloc_present_visitor_new(QObject *);
> +
>  #endif
> diff --git a/qapi/qapi-dealloc-visitor.c b/qapi/qapi-dealloc-visitor.c
> index 57a2c904bb..90b017cc93 100644
> --- a/qapi/qapi-dealloc-visitor.c
> +++ b/qapi/qapi-dealloc-visitor.c
> @@ -14,14 +14,146 @@
>  
>  #include "qemu/osdep.h"
>  #include "qapi/dealloc-visitor.h"
> +#include "qemu/queue.h"
> +#include "qobject/qdict.h"
> +#include "qobject/qlist.h"
>  #include "qobject/qnull.h"
>  #include "qapi/visitor-impl.h"
>  
> +typedef struct QStackEntry {
> +    QObject *obj;               /* QDict or QList being visited */
> +    void *qapi;

This one is only for debugging purpose, but not required, right?

I wonder if we could just rely on the unit test for correctness, otherwise
we kind of run some testing code with/without --enable-debug.  Not a huge
deal I think.. so see this a pure question.

> +    const QListEntry *entry;    /* If @obj is QList: unvisited tail */
> +    QSLIST_ENTRY(QStackEntry) node;
> +} QStackEntry;
> +
>  struct QapiDeallocVisitor
>  {
>      Visitor visitor;
> +    QObject *root;
> +    QSLIST_HEAD(, QStackEntry) stack;
>  };
>  
> +static void qapi_dealloc_pop(Visitor *v, void **obj)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
> +
> +    assert(se && se->qapi == obj);
> +    QSLIST_REMOVE_HEAD(&qdv->stack, node);
> +    g_free(se);
> +}
> +
> +static void qapi_dealloc_push(Visitor *v, QObject *obj, void *qapi)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +    QStackEntry *se = g_new0(QStackEntry, 1);
> +
> +    assert(obj);
> +    se->obj = obj;
> +    se->qapi = qapi;
> +
> +    if (qobject_type(obj) == QTYPE_QLIST) {
> +        se->entry = qlist_first(qobject_to(QList, obj));

I still don't yet understand why do we care about lists here.

I'm trying to guess, what this code wanted to do: we pushed the 1st entry
of the list into the stack, trying to make it as a reference for all the
items later within the list.

But IIUC we can still define the conditiona-dealloc visitor to be even
simpler, right?  Say, if the ref qobject has the qlist object, then free
the whole list?

IMHO there're three things we need to manage on conditional deallocations:
(1) struct, (2) list, (3) alternatives.  All the rest seem to be scalars.

So I wonder if we could define this visitor, so that it treats both (2) and
(3) the same way (to always dealloc as long as present).

That sounds at least making more sense when I picture that in migration
parameters: if we have a list in the parameters (e.g. cpr-exec-command), as
long as the list is present in the ref, we should free the whole thing
completely on the other one being visited.

> +    }
> +
> +    QSLIST_INSERT_HEAD(&qdv->stack, se, node);
> +}
> +
> +static QObject *qapi_dealloc_try_get_object(QapiDeallocVisitor *qdv, const char *name)
> +{
> +    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
> +    QObject *qobj;
> +    QObject *ret = NULL;
> +
> +    if (!se) {
> +        assert(qdv->root);
> +        return qdv->root;
> +    }
> +
> +    qobj = se->obj;
> +    assert(qobj);
> +
> +    if (qobject_type(qobj) == QTYPE_QDICT) {
> +        assert(name);
> +        ret = qdict_get(qobject_to(QDict, qobj), name);
> +    } else {
> +        assert(qobject_type(qobj) == QTYPE_QLIST);
> +        assert(!name);
> +        if (se->entry) {
> +            ret = qlist_entry_obj(se->entry);
> +        }
> +    }
> +
> +    return ret;
> +}
> +
> +static bool qapi_dealloc_present_start_struct(Visitor *v, const char *name,
> +                                              void **obj, size_t size,
> +                                              Error **errp)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +    QObject *qobj = qapi_dealloc_try_get_object(qdv, name);
> +
> +    if (!qobj) {
> +        return false;
> +    }
> +    assert(qobject_type(qobj) == QTYPE_QDICT);
> +    qapi_dealloc_push(v, qobj, obj);
> +    return true;
> +}
> +
> +static void qapi_dealloc_present_end_struct(Visitor *v, void **obj)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
> +
> +    assert(qobject_type(se->obj) == QTYPE_QDICT);
> +    qapi_dealloc_pop(v, obj);
> +
> +    if (obj) {
> +        g_free(*obj);
> +    }
> +}
> +
> +static bool qapi_dealloc_present_start_list(Visitor *v, const char *name,
> +                                            GenericList **list, size_t size,
> +                                            Error **errp)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +    QObject *qobj = qapi_dealloc_try_get_object(qdv, name);
> +
> +    if (!qobj) {
> +        return false;
> +    }
> +    assert(qobject_type(qobj) == QTYPE_QLIST);
> +    qapi_dealloc_push(v, qobj, list);
> +    return true;
> +}
> +
> +static void qapi_dealloc_present_end_list(Visitor *v, void **obj)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +    QStackEntry *se = QSLIST_FIRST(&qdv->stack);
> +
> +    assert(qobject_type(se->obj) == QTYPE_QLIST);
> +    qapi_dealloc_pop(v, obj);
> +}
> +
> +static void qapi_dealloc_present_free(Visitor *v)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +
> +    while (!QSLIST_EMPTY(&qdv->stack)) {
> +        QStackEntry *se = QSLIST_FIRST(&qdv->stack);
> +
> +        QSLIST_REMOVE_HEAD(&qdv->stack, node);
> +        g_free(se);
> +    }
> +    qobject_unref(qdv->root);
> +    g_free(qdv);
> +}
> +
>  static bool qapi_dealloc_start_struct(Visitor *v, const char *name, void **obj,
>                                        size_t unused, Error **errp)
>  {
> @@ -35,6 +167,21 @@ static void qapi_dealloc_end_struct(Visitor *v, void **obj)
>      }
>  }
>  
> +static bool qapi_dealloc_start_alternate(Visitor *v, const char *name,
> +                                         GenericAlternate **obj, size_t size,
> +                                         Error **errp)
> +{
> +    QapiDeallocVisitor *qdv = container_of(v, QapiDeallocVisitor, visitor);
> +    QObject *qobj = qapi_dealloc_try_get_object(qdv, name);
> +
> +    if (!qobj) {
> +        return false;
> +    }
> +    assert(*obj);
> +    (*obj)->type = qobject_type(qobj);
> +    return true;
> +}
> +
>  static void qapi_dealloc_end_alternate(Visitor *v, void **obj)
>  {
>      if (obj) {
> @@ -117,13 +264,14 @@ static void qapi_dealloc_free(Visitor *v)
>      g_free(container_of(v, QapiDeallocVisitor, visitor));
>  }
>  
> -Visitor *qapi_dealloc_visitor_new(void)
> +static QapiDeallocVisitor *qapi_dealloc_visitor_new_base(void)
>  {
>      QapiDeallocVisitor *v;
>  
>      v = g_malloc0(sizeof(*v));
>  
>      v->visitor.type = VISITOR_DEALLOC;
> +
>      v->visitor.start_struct = qapi_dealloc_start_struct;
>      v->visitor.end_struct = qapi_dealloc_end_struct;
>      v->visitor.end_alternate = qapi_dealloc_end_alternate;
> @@ -139,5 +287,28 @@ Visitor *qapi_dealloc_visitor_new(void)
>      v->visitor.type_null = qapi_dealloc_type_null;
>      v->visitor.free = qapi_dealloc_free;

IMHO, setting the hooks once then overwrite, is less clean than moving them
into qapi_dealloc_visitor_new() if dealloc_present visitor will do that.

>  
> +    return v;
> +}
> +
> +Visitor *qapi_dealloc_visitor_new(void)
> +{
> +    QapiDeallocVisitor *v = qapi_dealloc_visitor_new_base();
> +
> +    return &v->visitor;
> +}
> +
> +Visitor *qapi_dealloc_present_visitor_new(QObject *obj)
> +{
> +    QapiDeallocVisitor *v = qapi_dealloc_visitor_new_base();
> +
> +    v->visitor.start_alternate = qapi_dealloc_start_alternate;
> +    v->visitor.start_list = qapi_dealloc_present_start_list;
> +    v->visitor.end_list = qapi_dealloc_present_end_list;
> +    v->visitor.start_struct = qapi_dealloc_present_start_struct;
> +    v->visitor.end_struct = qapi_dealloc_present_end_struct;
> +    v->visitor.free = qapi_dealloc_present_free;
> +
> +    v->root = qobject_ref(obj);
> +
>      return &v->visitor;
>  }
> -- 
> 2.51.0
> 

-- 
Peter Xu


