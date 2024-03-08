Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788F5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:12:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVKv-0001pI-CV; Fri, 08 Mar 2024 03:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVKt-0001ng-39
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:12:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riVKq-0005kO-Sw
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:12:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709885527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGdBMXFyNuow7c9/afzsrFX0KZ2elXNGTJLmvllxqVw=;
 b=GCMAB0tMEUcrGrkYoYDUDy4tFjMSDW8bubSzDdA2HUYywfTgb5jE6ow1sJk6rvFwuFFT2+
 QRESnvGaOyetOw/qx7PK68Tz/5N8F0RIccg+ksFjx4ZYTYhlrpW2zpqeJioqK6EVCl4WmU
 vHic6wC+KNGkwGMOyuaa4A7Gow4IRbA=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-JOpdH4YkP5qjSqqGTQtKvA-1; Fri, 08 Mar 2024 03:12:05 -0500
X-MC-Unique: JOpdH4YkP5qjSqqGTQtKvA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-29bae9b83a8so226875a91.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 00:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709885524; x=1710490324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGdBMXFyNuow7c9/afzsrFX0KZ2elXNGTJLmvllxqVw=;
 b=wt7sB1d5ZCRu0eDdlbRine8xugRnINHxhH+PsjJsz+0JcTnlOb4XO964gaqOo9jvp1
 4EPSENxCHtPJDD/7e5p51T2WPkEL+vHcopOJqrVO2v9olwXpCerFW3UnD0pkO1Dwwtye
 P/v2SVVdH4qNCm82NWlsIdks+bQt0ziCEBo/jiQHV4+I94FF8DbMPdUJkA0vM8uQUHKX
 ewVyz/cQZ2OKBb3i/iL1jrsQCu0J/j7CcnJIpD1xqqeYDkSDeaCKteCZC03DTE4h6nIU
 3d0ts+6LYn6bRPzPgUC+XwTbzjT1hcHhsf0K8f+YwkHXWswuqBHx5+eOaMaWqIar3sev
 QUow==
X-Gm-Message-State: AOJu0YxodcIzYef7us4qfGj4WH9MoNtnHssikHhx8f3mNpi42H3bv4E5
 nfFx7sYsIrNsnCP1nG3ClnwzllP4f9t1VawwOA8WjE0ATm8zgRNkZkwRIYnbVsfe3xSVxmmtyrK
 3aaCdlb6cy9gkDCT86DEBE0L4zYsdZMCJJ9uVyDQ2IOsv7W+SNzzT
X-Received: by 2002:a17:90a:f3d4:b0:29b:780c:c671 with SMTP id
 ha20-20020a17090af3d400b0029b780cc671mr1223575pjb.0.1709885524108; 
 Fri, 08 Mar 2024 00:12:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3GopOkMEIZwbMicXOa2UlkUF2h7KQI864mwoNPU7zu40FNtNHKyzv39n/W0E25QXamWsN3w==
X-Received: by 2002:a17:90a:f3d4:b0:29b:780c:c671 with SMTP id
 ha20-20020a17090af3d400b0029b780cc671mr1223562pjb.0.1709885523673; 
 Fri, 08 Mar 2024 00:12:03 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a0cc800b0029b5f69830dsm2952622pjt.22.2024.03.08.00.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 00:12:03 -0800 (PST)
Date: Fri, 8 Mar 2024 16:11:52 +0800
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 05/25] s390/stattrib: Add Error** argument to
 set_migrationmode() handler
Message-ID: <ZerISAelT7evfqeB@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-6-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306133441.2351700-6-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

On Wed, Mar 06, 2024 at 02:34:20PM +0100, Cédric Le Goater wrote:
> This will prepare ground for future changes adding an Error** argument
> to the save_setup() handler. We need to make sure that on failure,
> set_migrationmode() always sets a new error. See the Rules section in
> qapi/error.h.
> 
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Since this whole set is mostly migration relevant, I plan to include this
patch in next Monday's pull.

S390 maintainers, please let me know if you have comments / objections
before that, thanks!

> ---
> 
>  Changes in v4:
> 
>  - Fixed state name printed out in error returned by vfio_save_setup()
>  - Fixed test on error returned by qemu_file_get_error()
> 
>  include/hw/s390x/storage-attributes.h |  2 +-
>  hw/s390x/s390-stattrib-kvm.c          | 12 ++++++++++--
>  hw/s390x/s390-stattrib.c              | 15 ++++++++++-----
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/s390x/storage-attributes.h b/include/hw/s390x/storage-attributes.h
> index 5239eb538c1b087797867a247abfc14551af6a4d..8921a04d514bf64a3113255ee10ed33fc598ae06 100644
> --- a/include/hw/s390x/storage-attributes.h
> +++ b/include/hw/s390x/storage-attributes.h
> @@ -39,7 +39,7 @@ struct S390StAttribClass {
>      int (*set_stattr)(S390StAttribState *sa, uint64_t start_gfn,
>                        uint32_t count, uint8_t *values);
>      void (*synchronize)(S390StAttribState *sa);
> -    int (*set_migrationmode)(S390StAttribState *sa, bool value);
> +    int (*set_migrationmode)(S390StAttribState *sa, bool value, Error **errp);
>      int (*get_active)(S390StAttribState *sa);
>      long long (*get_dirtycount)(S390StAttribState *sa);
>  };
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index 24cd01382e2d74d62c2d7e980eb6aca1077d893d..eeaa8110981c970e91a8948f027e398c34637321 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -17,6 +17,7 @@
>  #include "sysemu/kvm.h"
>  #include "exec/ram_addr.h"
>  #include "kvm/kvm_s390x.h"
> +#include "qapi/error.h"
>  
>  Object *kvm_s390_stattrib_create(void)
>  {
> @@ -137,14 +138,21 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
>      }
>  }
>  
> -static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val)
> +static int kvm_s390_stattrib_set_migrationmode(S390StAttribState *sa, bool val,
> +                                               Error **errp)
>  {
>      struct kvm_device_attr attr = {
>          .group = KVM_S390_VM_MIGRATION,
>          .attr = val,
>          .addr = 0,
>      };
> -    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +    int r;
> +
> +    r = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
> +    if (r) {
> +        error_setg_errno(errp, -r, "setting KVM_S390_VM_MIGRATION failed");
> +    }
> +    return r;
>  }
>  
>  static long long kvm_s390_stattrib_get_dirtycount(S390StAttribState *sa)
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index c483b62a9b5f71772639fc180bdad15ecb6711cb..b743e8a2fee84c7374460ccea6df1cf447cda44b 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -60,11 +60,13 @@ void hmp_migrationmode(Monitor *mon, const QDict *qdict)
>      S390StAttribState *sas = s390_get_stattrib_device();
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
>      uint64_t what = qdict_get_int(qdict, "mode");
> +    Error *local_err = NULL;
>      int r;
>  
> -    r = sac->set_migrationmode(sas, what);
> +    r = sac->set_migrationmode(sas, what, &local_err);
>      if (r < 0) {
> -        monitor_printf(mon, "Error: %s", strerror(-r));
> +        monitor_printf(mon, "Error: %s", error_get_pretty(local_err));
> +        error_free(local_err);
>      }
>  }
>  
> @@ -170,13 +172,15 @@ static int cmma_save_setup(QEMUFile *f, void *opaque)
>  {
>      S390StAttribState *sas = S390_STATTRIB(opaque);
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> +    Error *local_err = NULL;
>      int res;
>      /*
>       * Signal that we want to start a migration, thus needing PGSTE dirty
>       * tracking.
>       */
> -    res = sac->set_migrationmode(sas, 1);
> +    res = sac->set_migrationmode(sas, true, &local_err);
>      if (res) {
> +        error_report_err(local_err);
>          return res;
>      }
>      qemu_put_be64(f, STATTR_FLAG_EOS);
> @@ -260,7 +264,7 @@ static void cmma_save_cleanup(void *opaque)
>  {
>      S390StAttribState *sas = S390_STATTRIB(opaque);
>      S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
> -    sac->set_migrationmode(sas, 0);
> +    sac->set_migrationmode(sas, false, NULL);
>  }
>  
>  static bool cmma_active(void *opaque)
> @@ -293,7 +297,8 @@ static long long qemu_s390_get_dirtycount_stub(S390StAttribState *sa)
>  {
>      return 0;
>  }
> -static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value)
> +static int qemu_s390_set_migrationmode_stub(S390StAttribState *sa, bool value,
> +                                            Error **errp)
>  {
>      return 0;
>  }
> -- 
> 2.44.0
> 

-- 
Peter Xu


