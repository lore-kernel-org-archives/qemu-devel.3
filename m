Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDEDC3DA5D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 10:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWvfN-0003zw-AP; Thu, 25 Jul 2024 06:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvfM-0003uX-3Z
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:25:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWvfJ-0001zo-F4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 06:25:43 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-59589a9be92so968209a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 03:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721903139; x=1722507939; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cfk88cf70gW4Jzzqc9ohoIeWumEFK5WnZk8O4FpBVL0=;
 b=PXD9BKvUKHBEl9+ITEPWT62DSvn0U+55hEe6wZBwVUYe7zPo512rF5Ts84if00pQFm
 KLrU2J13r+gsyG0PU4f7CLPnon+fbDRgPMRiogYkNQVq5Q3S55kHAfg5q4tL4dj2848v
 A+dwVq2InUHFkeVmzMc4z5uCr8jfVrPmIF8KRJsTuYAv8tmHPNv+ULn4E4A4IWVZ307F
 nrIu/k72lHfTX91wxvqVYkGvfoEaq+/DAvTr/ztiETrWFAyzlz4Sb9CxoveFKhLPZABx
 bDv95lywku+LSQeeAtmTYZuoLSB78pSqMefY6zfKl9dgByY+lHEEnIilq0HqhfqOiDX3
 bMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721903139; x=1722507939;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cfk88cf70gW4Jzzqc9ohoIeWumEFK5WnZk8O4FpBVL0=;
 b=W9iOw3x06R8FX8lN4RL+MkSoAr66S1XbN2tM9Czqe1e0ENYXZ4m0ghhRxFMsiDFhOJ
 eIiGXleoQef24JE9wZp5AEOzW5CWvJ+KptJjlio4waF7lxhYe9nbcGveOJkm+J+Cb+vX
 /I46f2bra9rhZX8pzUtDiAfPhQ2foFnoTy6RNJ/JwA5EprgLIHPlZeq4dv+1QheBUqQi
 jUQ70V2WsZmBzbOs2cg1MadYl0jn+j8acBP/U5WtGfNoLSi6Sip6ShPvMEk5qLYlBf68
 ghCBVRhONkL1MgeZwscW2nVd8+hwId1LsNZT+xG/kLXf3JhbyEHq6ezQ01qctx4NLaAe
 2A/w==
X-Gm-Message-State: AOJu0Yy8tWgsim57ACXcVq5wax4sXLfL/O68xa+J21CQYKowaYTDYoxU
 UpsYn61w9mW9cC/ihKQFEDdxMtPiHQCjbFynPQXDKx3V5s2GZpKe7uwz+/9OGlAMzZn0OrfeblA
 BjX44ri2iLvgLm6KUy1A95FIRJHxA5Nidf1Ob8A==
X-Google-Smtp-Source: AGHT+IGjDlNGcaB4Tb2p7QWipXLztktjOU4TlP5w43+UCjHdAy1zyMp+/1OB2NKPrmZmtwL+Oh71cvBv2c0PS3jgjms=
X-Received: by 2002:a50:955e:0:b0:5a1:7570:8902 with SMTP id
 4fb4d7f45d1cf-5ac2ae7aea6mr1246164a12.18.1721903139485; Thu, 25 Jul 2024
 03:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240723141529.551737-1-pbonzini@redhat.com>
 <20240723141529.551737-5-pbonzini@redhat.com>
In-Reply-To: <20240723141529.551737-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 11:25:28 +0100
Message-ID: <CAFEAcA925i7y4mZ=+yvRAKftSbKcRJ9J7pAmCSRBKcM7w1hWtA@mail.gmail.com>
Subject: Re: [PULL 04/11] Add support for RAPL MSRs in KVM/Qemu
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Anthony Harivel <aharivel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, 23 Jul 2024 at 15:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> From: Anthony Harivel <aharivel@redhat.com>
>
> Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
> interface (Running Average Power Limit) for advertising the accumulated
> energy consumption of various power domains (e.g. CPU packages, DRAM,
> etc.).
>
> The consumption is reported via MSRs (model specific registers) like
> MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
> 64 bits registers that represent the accumulated energy consumption in
> micro Joules. They are updated by microcode every ~1ms.

Hi; Coverity points out a couple of issues with this commit
(details below).


> +static void *kvm_msr_energy_thread(void *data)
> +{
> +    KVMState *s = data;
> +    struct KVMMsrEnergy *vmsr = &s->msr_energy;
> +
> +    g_autofree vmsr_package_energy_stat *pkg_stat = NULL;
> +    g_autofree vmsr_thread_stat *thd_stat = NULL;
> +    g_autofree CPUState *cpu = NULL;
> +    g_autofree unsigned int *vpkgs_energy_stat = NULL;
> +    unsigned int num_threads = 0;
> +
> +    X86CPUTopoIDs topo_ids;
> +
> +    rcu_register_thread();
> +
> +    /* Allocate memory for each package energy status */
> +    pkg_stat = g_new0(vmsr_package_energy_stat, vmsr->host_topo.maxpkgs);
> +
> +    /* Allocate memory for thread stats */
> +    thd_stat = g_new0(vmsr_thread_stat, 1);
> +
> +    /* Allocate memory for holding virtual package energy counter */
> +    vpkgs_energy_stat = g_new0(unsigned int, vmsr->guest_vsockets);
> +
> +    /* Populate the max tick of each packages */
> +    for (int i = 0; i < vmsr->host_topo.maxpkgs; i++) {
> +        /*
> +         * Max numbers of ticks per package
> +         * Time in second * Number of ticks/second * Number of cores/package
> +         * ex: 100 ticks/second/CPU, 12 CPUs per Package gives 1200 ticks max
> +         */
> +        vmsr->host_topo.maxticks[i] = (MSR_ENERGY_THREAD_SLEEP_US / 1000000)
> +                        * sysconf(_SC_CLK_TCK)
> +                        * vmsr->host_topo.pkg_cpu_count[i];
> +    }
> +
> +    while (true) {
> +        /* Get all qemu threads id */
> +        g_autofree pid_t *thread_ids =
> +            thread_ids = vmsr_get_thread_ids(vmsr->pid, &num_threads);

Here you are assigning the same value to the thread_ids variable
twice. What was the intention here ? (CID 1558553)

> +
> +        if (thread_ids == NULL) {
> +            goto clean;
> +        }



> +/* Read the scheduled time for a given thread of a give pid */
> +void vmsr_read_thread_stat(pid_t pid,
> +                      unsigned int thread_id,
> +                      unsigned long long *utime,
> +                      unsigned long long *stime,
> +                      unsigned int *cpu_id)
> +{
> +    g_autofree char *path = NULL;
> +    g_autofree char *path_name = NULL;
> +
> +    path_name = g_strdup_printf("/proc/%u/task/%d/stat", pid, thread_id);
> +
> +    path = g_build_filename(path_name, NULL);
> +
> +    FILE *file = fopen(path, "r");
> +    if (file == NULL) {
> +        pid = -1;
> +        return;
> +    }
> +
> +    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u"
> +        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
> +        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
> +           utime, stime, cpu_id) != 3)
> +    {
> +        pid = -1;
> +        return;

In this error-exit path we leak 'file', because we opened it but
didn't close it. (CID 1558557)

Also, both here and in the previous error-exit check we set pid = -1,
which is pointless because it's a function-local variable and nothing
is going to see the new value.

> +    }
> +
> +    fclose(file);
> +    return;
> +}

thanks
-- PMM

