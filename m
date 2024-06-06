Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AFBC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:53:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8rQ-0007S9-Qg; Thu, 06 Jun 2024 04:52:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sF8rI-0007Pt-6i
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:52:32 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sF8rD-0007U4-R3
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:52:31 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52b950aa47bso1024792e87.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717663942; x=1718268742;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MAdl9HG0A7SD6J5iLlRnKo1H1NZFxZUyoafYbOzAsuE=;
 b=czoqxu+8GpAYjPZa+SNhrWbiLywuQmiuJtqWtutSLH1eV8YTdv0S8VJsL1hhwUCmp+
 UTPfOzWVFg8l2wcjWRQISk9t6pkYVYJajpCfeJ+iatR+PG3XUcgTS+pSGBL9LMMOUL3U
 qGISr/N5hQhygysso0mhlpRu1uEeWXYXist0EvfbgAr7XZfAc8JD83i03ww44E1XiZIe
 s3KvONjMUkrAOCCqbVDeU1V+Fg/HGNcAlvgVAmgijLcxucMtbmt91TDyuXsRCSlxXQLi
 xyYPlJEd76E2bmJzpwLXQSWrib6jxYdx7Eywl4EcSzLocAzkxdgN0Dq87wO4FvgqYMWS
 UDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717663942; x=1718268742;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MAdl9HG0A7SD6J5iLlRnKo1H1NZFxZUyoafYbOzAsuE=;
 b=nlcxilqlvyFSJZoYnSwXDeJefve+vp7nXim7wDw709kLRuqW53tHUTzmC0wNJ8NtVP
 hdHCnQdjm6kIhm/RM81XAi9adFFso2z/tus+AAR7m0Fp1dWaITKmNbM0AJGwQYB4JXE+
 j4+7NzExWcIjFkFbXIVfkkg7gDqGzK8SYZc0IyFjNgD+pyCAjWPS82MSIqoYDqio9yEF
 mftqUam/2gdr01auCrb2txJuhD19r66uAZop2hXNIUPPSteNgV0rPWBhZeGuqg5WGPiR
 C9mL5L94++xAVePUTIiTR3sMew/lpmmPO4At6+BBmIqFpAAFl0lvfnsrjH1U38pGRx4e
 /fPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyU3cVQyS0xU/Whx0M0d/1sSIMDpzdxXBipwXlncE7BIm4MH56wGZUd2wYw6QYH3AB4aVk/0kjnEvBmDvgtpg3SzGngUQ=
X-Gm-Message-State: AOJu0YzzLQNY9XCup+Ldpx5hHzgCnq3wZG21feyP1KyTrZqdBP3V7ZZc
 KV7PFM73y9lbwR05rljiNhzUMZ0/ybP0pq6jyIxiNv+4CX48g9eKyecraRVc08iCrIa24KKEhRw
 oNcWG8UQe/809HZhZDgt94ugK0bCxjLFhpv0b2qmqc22TgWo=
X-Google-Smtp-Source: AGHT+IGT1IgCHeqhQI2n/zFaBui44Iy6XVK0HwUPkCgYQuH6Dsyv++q/a09sVJUc+QqtXWNr7z97V4ceaN648M18Ej8=
X-Received: by 2002:ac2:4c1a:0:b0:52b:88ec:b425 with SMTP id
 2adb3069b0e04-52bab4dd705mr2772891e87.27.1717663941162; Thu, 06 Jun 2024
 01:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20240605112556.43193-1-phil@philjordan.eu>
 <20240606082217.2459102-2-pbonzini@redhat.com>
In-Reply-To: <20240606082217.2459102-2-pbonzini@redhat.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Thu, 6 Jun 2024 10:52:09 +0200
Message-ID: <CAGCz3vsXwbB6Lk6SyKCbUey_fdgD2CGin-X-E1iqgKaHes3CGA@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] hvf x86 correctness and efficiency improvements
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::12a;
 envelope-from=lists@philjordan.eu; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, 6 Jun 2024 at 10:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Queued, thanks.

Thanks - also for reviewing, etc.!

> Thanks for persisting!  It sucks that the hv_vcpu_interrupt() API docs
> are not clear, but your tests are great.  The self-interrupt one is
> the case that I was most worried about, and you're covering it.
> Sorry for being a pain for nothing, at least retrospectively.

No worries - the concern is understandable, especially in the face of
the unfortunate apparent regression which turned out to be the dirty
page tracking bug.

And I agree, the hv_vcpu_interrupt docs, along with the rest of
Hypervisor.framework's, are terrible. There does not appear to have
been any thought about what a developer using that API might care
about. I've been working on integrating the HVF APIC/PIC/IOAPIC
implementations, and there are ambiguities and edge cases galore.
Unfortunately (?), the perf improvement is worth the trouble of trial
& error=E2=80=A6


Phil

