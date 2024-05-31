Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 948B7C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwgk-0003fy-G2; Fri, 31 May 2024 03:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sCwgi-0003fH-0P
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:28:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1sCwgg-0003V2-Ak
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717140508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LBlmB0K9IxKq/mtRnKYW7CPmiy+20mlJSKQscMkGD0Y=;
 b=OfNdlVQPGkQr9Opyo7FOG+kQoaa/L5aJ39/RD9Gphjr8IY1L1bsHszaLLpVbKacsF1k7/B
 jzYKNm74s6zJrqkVWUQs+FfHqRMwPksbqpVjlXdwr6XSITvvhI2u2u6j+nfPS5vEFKT5zQ
 qRBszo/mdUWnVoQxvimopCT1+kaOSJ4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-H4BM6TYMMrGcJy6dxUvSmw-1; Fri, 31 May 2024 03:28:26 -0400
X-MC-Unique: H4BM6TYMMrGcJy6dxUvSmw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4212e3418b1so2599485e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 00:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717140505; x=1717745305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LBlmB0K9IxKq/mtRnKYW7CPmiy+20mlJSKQscMkGD0Y=;
 b=ABvpBa6B4bqREIL/b8a2PYBrHv/8aqKah07ipfjsn6LhjhYfKomzxtbw2aiQb3d5/E
 IzoosLgi3vh6kgd6f9YMvUcyXgL28jm0UL7b8UjH1xOwrgB8GGJfdT9bv2RdnXvjDjCT
 aEXDTrRardDmclEJNxn1QAzMa85tAjGILTNikVCIR7XhZGvlXXPXFIXcvUPDRFm/MPDO
 Tba2I34syhhv9gGIsj8qDQNXTFEC43QLdSkkUahNXTguyjQZN+YZEg0norrZGVc3uQL+
 tLLHTfskW6MN9y1gEAl4EchaCsgMh+bPHRiPxWn/oM8H9amu+Nubv/fBfPohh5k6W/x/
 VCQQ==
X-Gm-Message-State: AOJu0YyK9N50k2toP5Z9y4Om3W0n+IzEGXpnOH5Sed7nPHPqB+HagdEh
 yBLxNEC6hQD11hv9mh9M7NpxMKQD19jUADVUH/qS6j1vAFMO5UXmxQfM0KQLhgldyIWQrtJsPiP
 gwngkPHOxFm2mmho4tdmzDc+JYbjca6qgHJQwsVnmGHoO9XqUOYLgy+KPloVHuumpkUMQUqF75V
 o5M2Ao+vZqpyfbV+IlIcGfudomzLo=
X-Received: by 2002:a5d:55cf:0:b0:354:f753:e0e3 with SMTP id
 ffacd0b85a97d-35e0f273fb2mr645923f8f.19.1717140505533; 
 Fri, 31 May 2024 00:28:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHy2LgIw79+zT6WFMRcXNIpft+q/ODj5utj8Ym444sVFKhm0FymqnQsoScWPFtpkhK+fUtMeUp/yK3CWXNIpTE=
X-Received: by 2002:a5d:55cf:0:b0:354:f753:e0e3 with SMTP id
 ffacd0b85a97d-35e0f273fb2mr645907f8f.19.1717140505156; Fri, 31 May 2024
 00:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240530074453.21780-1-npiggin@gmail.com>
 <20240530074453.21780-4-npiggin@gmail.com>
In-Reply-To: <20240530074453.21780-4-npiggin@gmail.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 31 May 2024 12:58:08 +0530
Message-ID: <CAE8KmOwS-hWtq31Qs7Kac2wYvveLNQgHKkKvP_2O_W1x_7JT7A@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] tests/qtest/migration-test: Enable on ppc64 TCG
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, 30 May 2024 at 13:17, Nicholas Piggin <npiggin@gmail.com> wrote:
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>      /*
> -     * On ppc64, the test only works with kvm-hv, but not with kvm-pr and TCG
> -     * is touchy due to race conditions on dirty bits (especially on PPC for
> -     * some reason)
> -     */
> -    if (g_str_equal(arch, "ppc64") &&
> -        (!has_kvm || access("/sys/module/kvm_hv", F_OK))) {
> -        g_test_message("Skipping tests: kvm_hv not available");
> -        goto test_add_done;
> -    }
> -
> -    /*
> -     * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
> -     * there until the problems are resolved
> +     * On s390x with TCG, migration is observed to hang due to the 'pending'
> +     * state of the flic interrupt controller not being migrated or
> +     * reconstructed post-migration. Disable it until the problem is resolved.
>       */
>      if (g_str_equal(arch, "s390x") && !has_kvm) {
>          g_test_message("Skipping tests: s390x host with KVM is required");
> --
> 2.43.0

Reviewed-by: Prasad Pandit <pjp@fedoraproject.org>

Thank you.
---
  - Prasad


