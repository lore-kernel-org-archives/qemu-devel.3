Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52613CD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 15:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs2IO-0002W6-84; Wed, 03 Apr 2024 11:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rs2IM-0002Vt-Ib
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rs2IK-0004Rl-P9
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 11:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712157174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avPOGR9B6sbOW1tStVHlUEOHbwdg/tnng/vTVObnbRs=;
 b=FL5O+LJ8RcRNRgeTA1R00OFhnJbNeRd9zkNRALp2klfHLuI1J0gdcWG+lC3GWzikAvvfYX
 buJTTJ6tXJGiFm6kFLouRehNSrMefiYRqVIwVVJ+qXLAIkXUerw7sefQHwa2m79lErlgac
 CZijTZ7rzQh4DRausHpeF1UeQtEnhGc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-WpFk4xiNOJaXajrGxIFSAQ-1; Wed, 03 Apr 2024 11:12:53 -0400
X-MC-Unique: WpFk4xiNOJaXajrGxIFSAQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2d6b41203b2so52979061fa.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 08:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712157171; x=1712761971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avPOGR9B6sbOW1tStVHlUEOHbwdg/tnng/vTVObnbRs=;
 b=mHn8zzEVTnEvAVt+wHoDxyNonjJOrspRusama20h1iJJkoEsjcXJkBO7EW7IADq9mC
 9xAlJYbxXx32S1LF5EYm6we7A2mTkenVEk9tnvA3DF89pFN8xJgnzEzzF4mEpv1prx10
 wohtvyLVGfMnr8IdjRuX7mKoK2T7RvEnmfFLbtyOAasEyYfaFf+wOxLDuUr2MXRFjoh1
 1+RRB28yKRvBge4f8zyuvXIKiBzfGxshrDanjMdoX8mHdlJguLjPj+CpdFuZ/hBcJPPo
 YqM6DDS6ej1v8YZ+hUb052pJg/mCKvfZjENQV1T4YnebPUT90QNWeINKrQ6KpdTyB7r7
 VF3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxfoqDtA0QpU1f+ebsb1G1ao77TF12U11G5guEpK4g5aamz0RSYAoPcXQANmMrJgsW7ctZSqs1V5H/BDwdCf1Kro6wa00=
X-Gm-Message-State: AOJu0YxFotMUQpffqxcMTIwq+RpiCwn8Jx+nOhOghCY65009DaBRZVBE
 t9uS3jO+2PaGfc6Gi3i8fm7SnYBOfqY8gueGq4qTKLR6r1v7ex+MwW2/Qy4H8FzNEvn7AKR3PJO
 yd4HV+N+jvTCWYGc4wPSlZ9ZfsKd3zIWTqcrxR8zZEMHzN/iCZT2v
X-Received: by 2002:a2e:920d:0:b0:2d8:4169:3a58 with SMTP id
 k13-20020a2e920d000000b002d841693a58mr1035352ljg.41.1712157171602; 
 Wed, 03 Apr 2024 08:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa3cY9uD/gqm5fvLSEutK153Bd2thoICgiSFphVkdrfVF7cSQIowAuE5xciGRQm9l1YkW7Bw==
X-Received: by 2002:a2e:920d:0:b0:2d8:4169:3a58 with SMTP id
 k13-20020a2e920d000000b002d841693a58mr1035326ljg.41.1712157171212; 
 Wed, 03 Apr 2024 08:12:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 fm18-20020a05600c0c1200b004161df7c9dbsm4805820wmb.32.2024.04.03.08.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 08:12:50 -0700 (PDT)
Date: Wed, 3 Apr 2024 17:12:45 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 isaku.yamahata@intel.com, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is
 not disabled
Message-ID: <20240403171245.22a857af@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240403145953.3082491-1-xiaoyao.li@intel.com>
References: <20240403145953.3082491-1-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed,  3 Apr 2024 10:59:53 -0400
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> A value 1 of PCAT_COMPAT (bit 0) of MADT.Flags indicates that the system
> also has a PC-AT-compatible dual-8259 setup, i.e., the PIC.
> 
> When PIC is not enabled (pic=off) for x86 machine, the PCAT_COMPAT bit
> needs to be cleared. Otherwise, the guest thinks there is a present PIC.

Can you add to commit message reproducer (aka qemu CLI and relevant
logs/symptoms observed on guest side)?

> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> changes in v2:
> - Clarify more in commit message;
> ---
>  hw/i386/acpi-common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 20f19269da40..0cc2919bb851 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>      acpi_table_begin(&table, table_data);
>      /* Local APIC Address */
>      build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
> -    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
> +    /* Flags. bit 0: PCAT_COMPAT */
> +    build_append_int_noprefix(table_data,
> +                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
>  
>      for (i = 0; i < apic_ids->len; i++) {
>          pc_madt_cpu_entry(i, apic_ids, table_data, false);


