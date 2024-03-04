Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE399C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 05:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1HJ-0006Ys-Sv; Mon, 04 Mar 2024 00:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh1HI-0006Yi-Ez
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 00:54:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1rh1HG-0001ue-Sd
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 00:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709531657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qcQ5iDW057ZbFqtvu2cmeNu5vWIKMutoxA1Js7s5iTc=;
 b=S3kElXu7owZN6BHcSrUtbA5KXQKd4WFWprwm7xIotiNeuxrkzP1NVx/uH2YIRCKYMzkT/1
 1S8pKmrg8NAr1agP1kvzmOCFpBtzfPr4VkKJ9k6XaFmRlGgIy/oEhl5SyMnnU1DP27+urg
 6Vmqd/SzatSjHzpuD6tSXm946Fwy4HE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-jZgKLGxXP5iJu4_W3X4F5Q-1; Mon, 04 Mar 2024 00:54:16 -0500
X-MC-Unique: jZgKLGxXP5iJu4_W3X4F5Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40fb505c97aso23311005e9.3
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 21:54:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709531655; x=1710136455;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qcQ5iDW057ZbFqtvu2cmeNu5vWIKMutoxA1Js7s5iTc=;
 b=BSfwuCOChzbjrf497XoPFX/+nNQDvRYbXAZDfOILQmgvNrpG6/vw1pkS/hqKTW8nv1
 8j5p+HWy4dYhi7t9P6aEXgMdfInBAJGSjxPZmdLSgOLp7rGgbtD2341opJhuoYH9JWTx
 08PgfbWZrFdFIkf0A7H43SmUdD9DViHYY3zlUOQM7M4Y2GEtdXf3sBqaRp6vAz8VHh16
 8wZquqQ/4Cyxau8fzysd9cQVifPTEcDgEgs5XBv+l51Tu4qHXlb6mzT+F8RIrM1m/fUv
 t+7UFSfEtYCY/d29wt6a9AkNcYG4IUcWCCF980oZdncFFerz20CZ5MWlvze5SqeT8YHW
 rgIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7LI6ZvxhqdEwZ5D4zfzJje/9fWVovUAEYEDFbOAkdPehtT81NfLnkknnAyszROnm6x4DzVUoBotggNwSuqgmeyEivUA=
X-Gm-Message-State: AOJu0YxYysptBSxJBHSGcFTVKOf3eD5bBJH7ItTygaWEM8LXGHhknPPe
 FT0gLYzrpgRNgwdGcXeAuikUCLjRxEBynDhPeLu4L3KEe1DL80jUb84W3dYhU5U9/QedRM49eeO
 g9mVV5lPvWDIFXR0FB4MLYK+xJ0vkPwxgSVg5yA+KPbNZmOgI7T7/ICI8XapaUFYVBIDraMq7XS
 wCtS60ZUaZXvbaJCemOitdR6qNrTw=
X-Received: by 2002:a05:600c:45cf:b0:412:c982:d9c with SMTP id
 s15-20020a05600c45cf00b00412c9820d9cmr5700894wmo.4.1709531655245; 
 Sun, 03 Mar 2024 21:54:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhvdFlqPlEzZnFJ4JA4yTa26suUhbKuqczdd9s5csXKqH/ZiwNDejxq6oMDp9JU0axc2nLlvgpnSBKQIg0rNQ=
X-Received: by 2002:a05:600c:45cf:b0:412:c982:d9c with SMTP id
 s15-20020a05600c45cf00b00412c9820d9cmr5700886wmo.4.1709531654984; Sun, 03 Mar
 2024 21:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
In-Reply-To: <20240304044510.2305849-1-zhao1.liu@linux.intel.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 4 Mar 2024 11:23:58 +0530
Message-ID: <CAE8KmOxvZFjtKkHiGGREx_b0QgfDjPWZ7Ex3nqAQQbiPKa_wrQ@mail.gmail.com>
Subject: Re: [PATCH] hw/core/machine-smp: Remove deprecated "parameter=0" SMP
 configurations
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, devel@lists.libvirt.org, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Mar 2024 at 10:02, Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 25019c91ee36..96533886b14e 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -105,8 +105,9 @@ void machine_parse_smp_config(MachineState *ms,
>          (config->has_cores && config->cores == 0) ||
>          (config->has_threads && config->threads == 0) ||
>          (config->has_maxcpus && config->maxcpus == 0)) {
> -        warn_report("Deprecated CPU topology (considered invalid): "
> -                    "CPU topology parameters must be greater than zero");
> +        error_setg(errp, "Invalid CPU topology: "
> +                   "CPU topology parameters must be greater than zero");
> +        return;
>      }

unsigned maxcpus = config->has_maxcpus ? config->maxcpus : 0;
 ...
 if (config->has_maxcpus && config->maxcpus == 0)

* The check (has_maxcpus && maxcpus == 0) seems to be repeating above,
maybe we could check if (maxcpus == 0) error_setg(). And same for
other topology parameters?
* Also a check to ensure cpus <= maxcpus is required I think.

Thank you.
---
  - Prasad


