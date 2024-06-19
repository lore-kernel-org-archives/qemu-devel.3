Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD22C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrqW-0004ih-7k; Wed, 19 Jun 2024 05:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrqV-0004iQ-FG
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrqT-0008ED-Vd
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718790193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zA5kjGZbxNjVDSYa5KXeNn72ukq9qyDurgG9G0ggYl4=;
 b=ZWk2+HQyoVN9iB7n8OJP5jSGTbrsi7nzBuAGyxlg2Pe7GQpnPGwT9pOPDwQLsn3mpf0pHd
 3Ro1JvM3aMAQ/Vx388IFm8Isl4k2ljXjbPQ/gfk54tCdBzmxcLSgKr4BLBt/t2dtW3hnyK
 mtQk2lilpbZ5+R2xgxtgspwGT7L2R6k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-bkZcPWbXN2uH6Keh5duH9g-1; Wed, 19 Jun 2024 05:43:12 -0400
X-MC-Unique: bkZcPWbXN2uH6Keh5duH9g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-421759c3556so3571375e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 02:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718790190; x=1719394990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zA5kjGZbxNjVDSYa5KXeNn72ukq9qyDurgG9G0ggYl4=;
 b=WuZqXivaDebcU3Nzhy8seE/pYfjz4s1aOORINJEKroW348Ms8QYRx6Y95omp93d+Mp
 ShWN365rzF2semw5ZVrhSMyLJic9PZSXHmprcz1RI0VxSWC/scyoCPVH80umisiIYIcj
 IxtH00l+hpincPZelECH/NsuaO/wnC9yXjjy2MTttDfvp0Ah66caygivW5GKBejTz8vp
 lqahZyxDbJuw939Chb93kJHnSzn9v5qe76vL/jJ62RFyKeTsWL9QgYcyirBCOZ9R3cLL
 CR2LgTQyXfX1HR7j+yyY9fDL6nhPqaLvTF4YVxjWnA2lhUp1sF4K0bZqQn5Vpjg4vOLj
 Ccfw==
X-Gm-Message-State: AOJu0YyR8F53XQ/pTkhBMgmuZq0Mo+Lbcn76/Pbgf7mLbRz1TFn1YjzQ
 M0LtaqUbsPmWu5d3XAgQS9FGzwyCkzL+kVznr16xPr5F0LvL5eb5cgPvFOD0fJTKQOAAS3NdkQv
 s3WFO+CJkwISiU15bpxAtOdhn0m0cBZDmSNLZZLKFOJKhGzczNINxeeHZ1tVz
X-Received: by 2002:a05:600c:1d1b:b0:424:7425:f8a0 with SMTP id
 5b1f17b1804b1-42474d34375mr22770675e9.15.1718790189985; 
 Wed, 19 Jun 2024 02:43:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFbTKkBJJue0oxvG+VGm66g65goFyUk2cE5/mwicQHWuiHWKN9xXu+ck8l1bl5E+Lo82CBPw==
X-Received: by 2002:a05:600c:1d1b:b0:424:7425:f8a0 with SMTP id
 5b1f17b1804b1-42474d34375mr22770405e9.15.1718790189574; 
 Wed, 19 Jun 2024 02:43:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4229447eaa5sm255168515e9.48.2024.06.19.02.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 02:43:09 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:43:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis
 <alistair23@gmail.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1
 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>, Andrew
 Jones <ajones@ventanamicro.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 09/12] tests/data/acpi/rebuild-expected-aml.sh: Add
 RISC-V
Message-ID: <20240619114307.3f8c2f14@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240524061411.341599-10-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-10-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Fri, 24 May 2024 11:44:08 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Update the list of supported architectures to include RISC-V.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> index dcf2e2f221..c1092fb8ba 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -12,7 +12,7 @@
>  # This work is licensed under the terms of the GNU GPLv2.
>  # See the COPYING.LIB file in the top-level directory.
>  
> -qemu_arches="x86_64 aarch64"
> +qemu_arches="x86_64 aarch64 riscv64"
>  
>  if [ ! -e "tests/qtest/bios-tables-test" ]; then
>      echo "Test: bios-tables-test is required! Run make check before this script."
> @@ -36,7 +36,8 @@ fi
>  if [ -z "$qemu_bins" ]; then
>      echo "Only the following architectures are currently supported: $qemu_arches"
>      echo "None of these configured!"
> -    echo "To fix, run configure --target-list=x86_64-softmmu,aarch64-softmmu"
> +    echo "To fix, run configure \
> +         --target-list=x86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
>      exit 1;
>  fi
>  


