Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0752C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 18:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBetx-0006x7-RV; Mon, 27 May 2024 14:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBett-0006uR-2X
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:16:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sBetr-0006k4-IR
 for qemu-devel@nongnu.org; Mon, 27 May 2024 14:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716833806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0SG/L4NgD8oSC9bs/3RT412i8aFmgyc9us8nhBMLolY=;
 b=fsOC8uwkxgU33exxTVDeLIwc/2ufnPkj6guHbxHS576MR3ffIocuUfZa87ZB4AUMAyevvN
 eC+IXLFuJn964acXB2DOuRk/DJyfSOBoP8k2POYkYIumNm2do0adPtmvA83eZnsMc8bmIj
 XE5U0zy61lE6+hwCFHff0etp9VvTN/0=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-E-PlaemnM8SvkcHUARBnjw-1; Mon, 27 May 2024 14:16:44 -0400
X-MC-Unique: E-PlaemnM8SvkcHUARBnjw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-5b9b2a518b9so1932eaf.0
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 11:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716833804; x=1717438604;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0SG/L4NgD8oSC9bs/3RT412i8aFmgyc9us8nhBMLolY=;
 b=ahH4gNm4BcWi28OKdr4og0JzoPdyxD9bg6lDkJUCw/ucsXVOCmT52sHXN/juWwV7Ng
 0Bm348Fs1m0riJre8wYl0u9qTxIFwi8/TePhNAPzbT5uuvuT4eHr+gPJCKymNC3yG995
 xwiYFigQzIPZfhOeIHKxKPSw+qSJeMqiBbG+cSndAs4cutKCpA45KeEzq5NKpK++GiYr
 8Q5RBpwdqqWzkN3NixoaG3DsKMhu3jD1rVpfh3Plmid6TG4iDS4jbhqvOjpzFiQNgS3E
 gQo9SEXd+gVAzI2TDSz/uwWWxMFt4pjEGF7sIMPTKbhAJ5EMtFEnlGgxzUiMJudwi/G8
 UO6Q==
X-Gm-Message-State: AOJu0YyV24GN10WYFNMgZ0LyvfnY9b7EupClIjHCj7Oo5Oeu4ZLumtRd
 dbYUM4fg7SEL2UxdxZ54uGccEC4aF1VCfWM00RtgEHa1vxgi5Isl+iTX8u+bS4TJxYCYImdYWXV
 qnPXJh2XWrxujIRDDDohAu6ozeRzEfiUWLW4JuRssq/7N3IsEhqgm
X-Received: by 2002:a05:6870:55ce:b0:24f:c0ba:2b01 with SMTP id
 586e51a60fabf-24fc0ba2c85mr8352397fac.3.1716833803762; 
 Mon, 27 May 2024 11:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcI53bxlvillJ4FULZzoofAqKdQcCAUr/G64AhAt6wKqjyWhWuJEt8wyxgW6FhFgf63FwxGg==
X-Received: by 2002:a05:6870:55ce:b0:24f:c0ba:2b01 with SMTP id
 586e51a60fabf-24fc0ba2c85mr8352346fac.3.1716833802899; 
 Mon, 27 May 2024 11:16:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd09fd8sm314896085a.94.2024.05.27.11.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 11:16:42 -0700 (PDT)
Date: Mon, 27 May 2024 14:16:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 05/26] migration: precreate vmstate
Message-ID: <ZlTOCLFNF894T46U@x1n>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1714406135-451286-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Apr 29, 2024 at 08:55:14AM -0700, Steve Sistare wrote:
> Provide the VMStateDescription precreate field to mark objects that must
> be loaded on the incoming side before devices have been created, because
> they provide properties that will be needed at creation time.  They will
> be saved to and loaded from their own QEMUFile, via
> qemu_savevm_precreate_save and qemu_savevm_precreate_load, but these
> functions are not yet called in this patch.  Allow them to be called
> before or after normal migration is active, when current_migration and
> current_incoming are not valid.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/vmstate.h |  6 ++++
>  migration/savevm.c          | 69 +++++++++++++++++++++++++++++++++++++++++----
>  migration/savevm.h          |  3 ++
>  3 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 294d2d8..4691334 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -198,6 +198,12 @@ struct VMStateDescription {
>       * a QEMU_VM_SECTION_START section.
>       */
>      bool early_setup;
> +
> +    /*
> +     * Send/receive this object in the precreate migration stream.
> +     */
> +    bool precreate;
> +
>      int version_id;
>      int minimum_version_id;
>      MigrationPriority priority;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 9789823..a30bcd9 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -239,6 +239,7 @@ static SaveState savevm_state = {
>  
>  #define SAVEVM_FOREACH(se, entry)                                    \
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry)                \
> +        if (!se->vmsd || !se->vmsd->precreate)
>  
>  #define SAVEVM_FOREACH_ALL(se, entry)                                \
>      QTAILQ_FOREACH(se, &savevm_state.handlers, entry)
> @@ -1006,13 +1007,19 @@ static void save_section_header(QEMUFile *f, SaveStateEntry *se,
>      }
>  }
>  
> +static bool send_section_footer(SaveStateEntry *se)
> +{
> +    return (se->vmsd && se->vmsd->precreate) ||
> +           migrate_get_current()->send_section_footer;
> +}

Does the precreate vmsd "require" the footer?  Or it should also work?
IMHO it's less optimal to bind features without good reasons.

Thanks,

-- 
Peter Xu


