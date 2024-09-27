Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C573CEBF8A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 09:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1su7Kt-00069e-JE; Fri, 27 Sep 2024 05:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1su7Ks-00063j-1a
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 05:32:26 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1su7Kq-00030R-AJ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 05:32:25 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so2342360a12.0
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 02:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727429542; x=1728034342; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NeLzLn8y0XZDBEY9KKK8lH2JIymsBq5bE/4ZDfwDvo8=;
 b=yb87XhxXz60ASu1aWX9hGc1exN7k5YqfKyyqSACoJTAGWsFTJU10fKMagcAwhdVTSc
 maZ2G/u+Jf5UmEiyKg4QrRJtbEsn7LmFZJWbR5aKd5PoCYMAgQ4oI8chvy5yd+8zQSCB
 PggkYbm0aYd8o+ba1OmGDfHj8YqnqsfKxgxpiarUVLZJdf88NOJSLr8XqdatOImgiyla
 tEnJl9fDzaifKKzgdZrQmZ29WW4GWhfyDBKqsnjnHvWpq3E6D760as+buuhFZA9V3Epn
 j2GttqN+/SL3xKeGvoBLjz/JaNF4+lIJHlE/m/e4CYPi2yYP9FPhPgeYlfcVrH7X58b+
 WYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727429542; x=1728034342;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NeLzLn8y0XZDBEY9KKK8lH2JIymsBq5bE/4ZDfwDvo8=;
 b=Ze/5KEJtQhUas7OSTbq6heIB8ogXVJjUasI7BunX6ijT8w3ozUshC7wDx5M7Eg3uGG
 6AJvkXUTCylIE0wXT/bg4ualT2KsHk/S+dGWeR5Kzl/vlmyit9OTl1nPagg8Dsa+5Rl7
 7T8PevT78chGGEbAwm0PpZQQMPqGlo903wHuheCTiJlcuIaYL2UG8USBA94GB0FcdZkk
 9FW0bzaz8UZ6VxyJZBYTrgbGSISxt5Iex+LtxEvjGokyR25GsIk7gAQEX/b6lVkc76M0
 FyNcE/UsvC9sGopmpYqVK1uEvEZOfYQXkfqZhgic85ebro+6/IHrzZDiMM8ye9h7pKDF
 mPpw==
X-Gm-Message-State: AOJu0YxMxQdOkhkpjkAt5wUIEapiBI/LnnVSBkfWyMX3jWpP6UPIAbc8
 0MpuWTQFE9P3SZIwtWmeCWGhrVziRgRFWIhVVsKXe2qQo36SxXA9bTRCzXruYUDN0txw5h1sVoh
 y4cMfq9XZjio+qeTkdk0yCuFw6p4pv4q2p/iXBQ==
X-Google-Smtp-Source: AGHT+IFL87iTRXD1OtWeR9sIhN3y5dQ4K4OweMIhUxdWMfFOBIBbTBx7jQfnT3jZv6nhsK0mWEgiYLDK9/ABTQCCY/E=
X-Received: by 2002:a05:6402:280d:b0:5c4:23b2:ec35 with SMTP id
 4fb4d7f45d1cf-5c8824e5166mr2074528a12.10.1727429542502; Fri, 27 Sep 2024
 02:32:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240924100329.248738-1-david@redhat.com>
In-Reply-To: <20240924100329.248738-1-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Sep 2024 10:32:11 +0100
Message-ID: <CAFEAcA84GzWXByn+PPHV9DGmpzqV9bMNdL62-eoH2nwbU4-x5g@mail.gmail.com>
Subject: Re: [PULL 0/6] Host Memory Backends and Memory devices queue
 2024-09-24
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 24 Sept 2024 at 11:03, David Hildenbrand <david@redhat.com> wrote:
>
> Hi,
>
> due to reset changes this contains a bit of churn that touches various
> architectures, but it's all fairly minimal and straight-forward.
>
> The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
>
>   Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/davidhildenbrand/qemu.git tags/mem-2024-09-24
>
> for you to fetch changes up to 78c8f780d3f0d6d17aa93d6f99ff72960080fdd7:
>
>   hostmem: Apply merge property after the memory region is initialized (2024-09-24 11:33:35 +0200)
>
> ----------------------------------------------------------------
> Hi,
>
> "Host Memory Backends" and "Memory devices" queue ("mem"):
> - Kconfig fix for virtio-based memory devices
> - virtio-mem support for suspend+wake-up with plugged memory
> - hostmem fix when specifying "merge=off"
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

