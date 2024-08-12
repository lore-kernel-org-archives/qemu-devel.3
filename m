Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BEEC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 12:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdU1D-0000y2-GP; Mon, 12 Aug 2024 08:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdU0c-0000pW-OB
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sdU0Z-0005Cp-Mf
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 08:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723465122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+qGtt7DecWsaYa078rnNColEwnmTfR+FwPF62fWUwI=;
 b=S75/7K3sN4ZRc1NY/MlvbgkQb2lezMDEgRDDcr+Rh322YrYD8DSqBfToOLE353Kv4keofc
 2SqaWqjG7CN0GnEO2xGrIvG3tKHFry832693pkvT7UtgVQyT9yVlS7s2yKP+Tm7/q0++NM
 9wKLyVW3gKh7Jo1G/vb/3Kfd7y9rBDw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-K73UFZh6PLGWOsz5TJgarQ-1; Mon, 12 Aug 2024 08:18:40 -0400
X-MC-Unique: K73UFZh6PLGWOsz5TJgarQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so2510501f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 05:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723465119; x=1724069919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+qGtt7DecWsaYa078rnNColEwnmTfR+FwPF62fWUwI=;
 b=IhAV4XpoOQaMusMmUOF7UYhJ5NxP1+EpM/LPjATLGItW+XH8AFlHU1B8tT7Fq9fRa8
 ntcws0naX7x7nebSKU/DakqsSHDNIpPHCHUjrkQYOJ+aijrVUkuk6mz1WA3uOP29ejrU
 FVrJV90M6R0u61OpnNoGztpWV7xihrfO/wbfdLp43y1i8Msf3+e+4bWP9LfaH0Gew1W+
 SkiQCG0vlPPUWE5qdNn2KYehb/GWsrYCPK8EEKLTrFdAY9mtZ3Meir8DCkur0r+ng2x3
 l7+MgCH7OtUYfkh5RtwLsAGG7OoaRcNvGN1rW1SAy+KXD/apu40oVPFKJIthFQnAx150
 rV1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyHB/6zfcmBFsVRNijnRUP70AtV9qh0976YDLsZodsp33z+B3q6ZR94notplmzq3qZZc2KSFHQEh+gqGBO/Into1NA9Qk=
X-Gm-Message-State: AOJu0YzGYM/2kYOYXuIcPe9BUkZzeE9M/jLjMdlFU1XQzo57sRBELJ0u
 /DGh8UhOEYS5mdxoCRViFXHphNhu+Z8zAcrhLAlvE/scK3xF35sTfONBLjDn02qSSEnHJwaP0GY
 4T3M2IYF6F3QuhHKxya3x+uSH39fvIC6QMYgZDr/oh+mUbGhPEqFz
X-Received: by 2002:adf:e648:0:b0:367:8fc3:a25b with SMTP id
 ffacd0b85a97d-3716cd24da5mr85353f8f.42.1723465119516; 
 Mon, 12 Aug 2024 05:18:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvn7aBmirysigb+mAf2PbbXoKygbHjCt9KGqkykLwECr83whgfjpT5qByVtoR4q2CnWzaHOQ==
X-Received: by 2002:adf:e648:0:b0:367:8fc3:a25b with SMTP id
 ffacd0b85a97d-3716cd24da5mr85335f8f.42.1723465119006; 
 Mon, 12 Aug 2024 05:18:39 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429c751b021sm101318075e9.21.2024.08.12.05.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 05:18:37 -0700 (PDT)
Date: Mon, 12 Aug 2024 14:18:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 00/10] Add ACPI CPER firmware first error injection
 on ARM emulation
Message-ID: <20240812141835.50749f0e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240808145735.70f81f76@foz.lan>
References: <cover.1723119423.git.mchehab+huawei@kernel.org>
 <20240808145735.70f81f76@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 8 Aug 2024 14:57:35 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Thu,  8 Aug 2024 14:26:26 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
> > v6:
> > - PNP0C33 device creation moved to aml-build.c;
> > - acpi_ghes record functions now use ACPI notify parameter,
> >   instead of source ID;
> > - the number of source IDs is now automatically calculated;
> > - some code cleanups and function/var renames;
> > - some fixes and cleanups at the error injection script;
> > - ghes cper stub now produces an error if cper JSON is not compiled;
> > - Offset calculation logic for GHES was refactored;
> > - Updated documentation to reflect the GHES allocated size;
> > - Added a x-mpidr object for QOM usage;
> > - Added a patch making usage of x-mpidr field at ARM injection
> >   script;

stopping review at 5/10 and expecting a version with
GHES source to error status block mapping fetched from
HEST in guest RAM, instead of pre-calculated offsets
in source code  (as in this series) to avoid migration
issues and keeping compat plumbing manageable down the road.

> Forgot to mention: I dropped the PIN cleanup from this series, submitting 
> it in separate - and it is not related anymore with this changeset:
> 
> https://lore.kernel.org/qemu-devel/ef0e7f5fca6cd94eda415ecee670c3028c671b74.1723121692.git.mchehab+huawei@kernel.org/T/#u
> 
> Thanks,
> Mauro
> 


