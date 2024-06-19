Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A17C2BA15
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 09:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJrTN-0007iC-3C; Wed, 19 Jun 2024 05:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrTJ-0007hO-KH
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:19:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJrTD-00048q-P7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 05:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718788750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxjXpMluHxc52Vobqk0TATP11svHSV6pn9tJ8XYJc34=;
 b=aTdirws68UyLI0/6dFyrT7TzHH2QVGGdgGwECOQXg3CGfwrDPcVKrk+Wx1/bF8rKS2Md0A
 fHmryHIrPxROdJxV5ZUAH18ezTT5AC/o9L9NBP6eE4whUSL3nIvZzbDLzueh5/hWvcjlA0
 rM9r+wsk33V7q1We5/a4Ee3WuV9rMhg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-dD3F01XWP7uK1DBXCpd0Mg-1; Wed, 19 Jun 2024 05:19:08 -0400
X-MC-Unique: dD3F01XWP7uK1DBXCpd0Mg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52c968340c8so5575191e87.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 02:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718788744; x=1719393544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxjXpMluHxc52Vobqk0TATP11svHSV6pn9tJ8XYJc34=;
 b=fX1Hd5wzl6u8SScqMZjjJWwyqIXRxf+Hr8J/0+LxovgReQ/9Pf0pYzqJwYY95GJbVZ
 5bbcctuKi5pRjZmdfTxhjHR5Lqj6SMTHMJi2B4DSaPl8+XGEnm9q7BmB/ugqxqpWxUL8
 1Idc+OQ7I29O/hnMFvNQ2iVww0tgE7AwGIkdTLTCPFWbF10gnjVxUiF3QT1YN8qT5S1c
 fXxtW+ri1K5qR4BsgXlCBL908H77wO/N42navOW8eEeUxREfQVeUYv7NqvZvJGYb89OK
 QSlvIdAsDGWusdQLFSZs9a5TaGj2G168IANSzQLrWD0ckN0M+LzmPsGHgUppdNMykzyq
 a09w==
X-Gm-Message-State: AOJu0Yx1PPbCy7v3lVhXQjZ5UJPgq2k5W/jNzTApHSInu2ysP4rr82gP
 HqT9vc2OGrkaLpJl4JwGLfR9Y+KjaRhwMQ+9FO0jGcCoVvCke6UaHKqEaiwZETQKTstZsqWm/0n
 v9gOQoeg/J7XdLwVu1/cPf58kBai5S2RMbIJIhvTalhVz9txLVw27
X-Received: by 2002:ac2:5605:0:b0:52c:891d:2ac4 with SMTP id
 2adb3069b0e04-52ccaa37401mr1300792e87.35.1718788744533; 
 Wed, 19 Jun 2024 02:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHfRW9tMc8QVRrzctKNOxvx9HWw/3XU+KapdD/SGF8j4lVSWwVSs09rqpWpdId4VkCsB6fDw==
X-Received: by 2002:ac2:5605:0:b0:52c:891d:2ac4 with SMTP id
 2adb3069b0e04-52ccaa37401mr1300774e87.35.1718788744114; 
 Wed, 19 Jun 2024 02:19:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247101a955sm41879905e9.0.2024.06.19.02.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 02:19:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 11:19:02 +0200
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
Subject: Re: [PATCH v2 07/12] meson.build: Add RISC-V to the edk2-target list
Message-ID: <20240619111902.241adcc3@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240524061411.341599-8-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-8-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 24 May 2024 11:44:06 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> so that ACPI table test can be supported.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index a9de71d450..576c803a8a 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -93,7 +93,7 @@ else
>    iasl = find_program(get_option('iasl'), required: true)
>  endif
>  
> -edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu' ]
> +edk2_targets = [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x86_64-softmmu', 'riscv64-softmmu' ]
>  unpack_edk2_blobs = false
>  foreach target : edk2_targets
>    if target in target_dirs


