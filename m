Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C262D3943A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 15:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8Jsz-00084l-9r; Thu, 02 Apr 2026 11:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w8Jsp-00084G-BW
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:23:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w8Jsn-0004qh-Nt
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 11:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775143375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wVxhGblpV1TZYDb1qXr/eh8XkzboMwrZ6XwIrmuKazc=;
 b=PH84eYkEKOctldZR7BxOyySA9IJDdJVqlq1DGTmf6HcL6ZmGLyycFE6pqcILQslLuWgoIh
 enK2lBnkwHBgT2vebELneUkI9v0P6X59kJtTpceevVC/hRF6U0ICj3G9iM/262emvDchzO
 Dzz5r3fpiuY1EN8V6KDvhmaJlebGHv0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-Y7BB6A0MMe6ahNPpVCJRdg-1; Thu, 02 Apr 2026 11:22:54 -0400
X-MC-Unique: Y7BB6A0MMe6ahNPpVCJRdg-1
X-Mimecast-MFC-AGG-ID: Y7BB6A0MMe6ahNPpVCJRdg_1775143373
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82c70d1f56eso558369b3a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775143373; x=1775748173; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wVxhGblpV1TZYDb1qXr/eh8XkzboMwrZ6XwIrmuKazc=;
 b=YryqXRqfBGCm9Wj53rmbTFMSSGdc/L9433GIYHKAarR2otcbp3L9g/ooWxEGH6f7c6
 zAwN7rpUy5vdOTdYfRncCFVHCXUiB5hyqyISAmoN1i61vo++po79E2i3KkKfsCMmIhnv
 5Hu6AuzgKbNL3t2OZ5HPrMbly5rvOX2aD+FLXKa2R6RpNG2b6F/eb392CDOKrs7FI8nt
 5l7X7p6UsGjpxOPJ5G/l982OOMn6V7vQ9e5mRwurHaO9YogYX6ptGmVn5gbPC0UvxCE4
 TYEdMrpfvX8QiVWFEbNtBqWF1n9nppZMEYwOElv/97BgYLIvlzN1ybi6sOb+fDvlkfhD
 X3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775143373; x=1775748173;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wVxhGblpV1TZYDb1qXr/eh8XkzboMwrZ6XwIrmuKazc=;
 b=BA/ppqs42pcFm7OBB970lD3ONuoKWsqlukcIsB8li49NELTaXNgpndEeuixuX9ZdoN
 GoVEktKs1owVM8YuLHatzayIbrrsr2IjMecXzhETKBNBmE63AVh2oDm3IL64NB+nd4Tp
 JVq8J8RGDqGkrhVgE0ALJ3QHVUKGyqg9NeGZ+ItILS/OJnmCksgxzm7tPK2dD1b6VzpE
 xH34J18GlYdtPWXc4oHOvvoiSzZODEpByYPo1fpnWBu25p+7yuzrGDyeIIYCQuAmBaLS
 1Pbnj/+i+u4BWiiw1j/evBO8oMCCBISDMzZDcYNI0cCijGN869lBFUahonXfdn+bwvUq
 JCyw==
X-Gm-Message-State: AOJu0Yw82WCcSGryjBDKwkRvfnWSAWpZimFqvUVzVsTG88MIa5v8hT46
 6Lz1bn25oGTG0kpEplaUDt8KG0v7rIZA3cocx95Labsv4FpJ+bOP41jn/9uS5Zi4ALk6/AMlpjt
 m0Igy1pafoRSbZKw/FZZsavJS93VF/jLKqiy5xtpXphgGU08YozOq1oWn
X-Gm-Gg: ATEYQzz9xQfD49mxNKnGmAi0Ntrmv37zFRgdscarnkUnuj0ESwtCy8M6To9GBMtHc89
 WMZTBfMOBQDvRASt7ZupoUCCGb+jCC60q1WOpdNP+oOYiNqzjRobzpBGH/olR1X+wJ9g7CG9VUk
 CqIyKG3JDFgKmpEwNcZ6LMq+6o4HmDUMv5DejEX2XrqJRhQmeqmiD0CELubyMtLa3Z3T8V7vsLm
 yqERHAei2JQ2hNpLbRZH+rvm4kXd3wFYI6KJXr82U9K/ImuNPOfanZoaAV7731qq1kMXdw4degT
 QqS/Tf9sfZA+uOovGheVWZyx7JfPsf9KFPpg6fYAPPby8FyUOKJ6WCqqyuVv+b5FaX1LcBrkByR
 HsXseBZcZGsfH
X-Received: by 2002:a05:6a00:130a:b0:82c:e46d:df45 with SMTP id
 d2e1a72fcca58-82ce8ad12e8mr8244534b3a.53.1775143373245; 
 Thu, 02 Apr 2026 08:22:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:130a:b0:82c:e46d:df45 with SMTP id
 d2e1a72fcca58-82ce8ad12e8mr8244511b3a.53.1775143372692; 
 Thu, 02 Apr 2026 08:22:52 -0700 (PDT)
Received: from fedora ([49.36.108.200]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b3baffsm3459722b3a.14.2026.04.02.08.22.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 08:22:52 -0700 (PDT)
Date: Thu, 2 Apr 2026 20:52:45 +0530
From: Arun Menon <armenon@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: Re: [RFC v2 6/7] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Message-ID: <ac6Jxd2DAonGz1g6@fedora>
References: <20260319135316.37412-1-armenon@redhat.com>
 <20260319135316.37412-7-armenon@redhat.com>
 <177452442289.34609.7771820064527102277.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177452442289.34609.7771820064527102277.b4-review@b4>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.542,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Mar 26, 2026 at 03:27:02PM +0400, marcandre.lureau@redhat.com wrote:
> On Thu, 19 Mar 2026 19:23:15 +0530, Arun Menon <armenon@redhat.com> wrote:
> 
> Hi
> 
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6cf0e2f404e..fcd6043c992 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -40,6 +40,7 @@
> >  
> >  GlobalProperty hw_compat_10_2[] = {
> 
> Let's not forget to update this to 11.0 for 11.1 :)

Yes I shall base it on top of 20260331140347.653404-1-cohuck@redhat.com

> 
> >
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index e61c04aee0b..9ce342fe8ac 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -33,6 +33,17 @@
> >  #include "trace.h"
> >  #include "qom/object.h"
> >  
> > +/* command and response buffers; part of VM state when migrating */
> > +typedef struct TPMCRBMigState {
> > +    uint32_t cmd_size;
> > +    uint8_t *cmd_tmp;
> 
> Could we name them after the name of the state fields?
> command_buffer_len && command_buffer_data ?

This will be not needed.

> 
> > +
> > +    uint32_t rsp_size;
> > +    uint8_t *rsp_tmp;
> 
> (response_buffer_len ..)
> 
> Actually, you should not need an extra MigState at all. Check how
> GByteArray are handled in in ui/vdagent.c for example. (I have a doubt
> that it may eventually leak if loading for a running state, where data
> != NULL though, I would have to check - we may want to use realloc for
> buffers)

I am thinking of adding a separate VMStateInfo for GByteArray. The .get
and .put functions will call actual GLib API to set the size of the
buffer or create a new one if the existing data == NULL.

const VMStateInfo vmstate_info_g_byte_array = {
    .name = "GByteArray",
    .get = get_g_byte_array,  // Creates a new GLib object iff data!=NULL
    .put = put_g_byte_array,
}


We will not require any pre-save and post load hooks in that case.
We can also use it in the ui/vdagent.c.

> 
> > @@ -347,18 +361,118 @@ static int tpm_crb_pre_save(void *opaque)
> > [ ... skip 30 lines ... ]
> > +    } else {
> > +        s->mig.rsp_tmp = NULL;
> > +        s->mig.rsp_size = 0;
> > +    }
> > +    s->mig.rsp_offset = (uint32_t)s->response_offset;
> > +    return 0;
> 
> If you get rid of MigState, the original response_offset field will
> proably have to be uint32_t too.
> 
> > [ ... skip 14 lines ... ]
> > +        g_free(s->mig.cmd_tmp);
> > +        s->mig.cmd_tmp = NULL;
> > +        g_free(s->mig.rsp_tmp);
> > +        s->mig.rsp_tmp = NULL;
> > +        return false;
> > +    }
> 
> Suggesting g_clear_pointer(&ptr, g_free)
> 
> > +
> > +    if (s->mig.cmd_tmp) {
> > +        if (s->command_buffer) {
> > +            g_byte_array_unref(s->command_buffer);
> > +        }
> 
> Slightly neater:
> g_clear_pointer(&s->command_buffer, g_byte_array_unref);
> 
> > +        s->command_buffer = g_byte_array_new_take(s->mig.cmd_tmp,
> > +                                                  s->mig.cmd_size);
> > +        s->mig.cmd_tmp = NULL;
> > +    } else {
> > +        if (s->command_buffer) {
> > +            g_byte_array_set_size(s->command_buffer, 0);
> > +        }
> > +    }
> > +    if (s->mig.rsp_tmp) {
> > +        if (s->response_buffer) {
> > +            g_byte_array_unref(s->response_buffer);
> > +        }
> 
> Or you could simply without condition:
> 
> g_clear_pointer(&s->command_buffer, g_byte_array_unref);
> s->command_buffer = g_byte_array_new_take(s->mig.cmd_tmp, s->mig.cmd_size);
> 
> This will also reset the size to 0 if cmd_tmp is NULL and cmd_size is 0.
> 
> > +        s->response_buffer = g_byte_array_new_take(s->mig.rsp_tmp,
> > +                                                   s->mig.rsp_size);
> > +        s->mig.rsp_tmp = NULL;
> > +    }
> 
> Missing
>     s->response_offset = s->mig.rsp_offset;
> 
> > +    return true;
> > +}
> > +
> > +static const VMStateDescription vmstate_tpm_crb_chunk = {
> > +    .name = "tpm-crb/chunk",
> > +    .version_id = 1,
> > +    .needed = tpm_crb_chunk_needed,
> > +    .pre_save = tpm_crb_chunk_pre_save,
> > +    .post_load_errp = tpm_crb_chunk_post_load,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_UINT32(mig.cmd_size, CRBState),
> 
> Could be version 0, I think.

Yes, will change it

> 
> -- 
> Marc-André Lureau <marcandre.lureau@redhat.com>
> 

Regards,
Arun Menon


