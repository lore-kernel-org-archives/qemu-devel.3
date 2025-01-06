Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70932E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 16:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUqIM-0005u9-1q; Mon, 06 Jan 2025 11:49:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUqIK-0005tk-Fp
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 11:49:36 -0500
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tUqII-0007gr-N2
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 11:49:36 -0500
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e46ac799015so17879298276.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 08:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736182173; x=1736786973; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nxfNvLUy32b5m16uWv1RUhxL+6TPjwmEwO15LPii5CM=;
 b=sA1eLcmafdM1wTtJktSehw6qSCgOsTDT9cJNzxBPeGmKehcZYZbHpsxaJkuZSf2qqF
 NalRDQgy/2Bj8ejXg/OLfBS0sPJfU4njEuguEIXoaIxFXUsNUjgELTTuGl9nMdCmYZnj
 7h4bbanBS2oJAHZXgGHO2G66noR9CPw405xC4r0IgjpL1quh5U+/ofwhVMRUHtv8WkMQ
 /ZFBiG86+F9tHeP2Ta1O0A/TGDLHBzjxm4fVBy2E6mlMdoQPsTCpAZihCXypWzro0Zd1
 3KRFS5XyuBseNku2z3a1xzY0sgppIDDHhpCJMvRh8fMDXslfN063ktK/MmzTjges7ggy
 oCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736182173; x=1736786973;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxfNvLUy32b5m16uWv1RUhxL+6TPjwmEwO15LPii5CM=;
 b=mlhzvEntP89ETXz6YZjIg2KgtHpGauEcw0UX80ovns2rwqc8fpaFHZbCm1PAfFcsSE
 AubQ/LTC5wQmxieUHcqOqRu+TwkCPueir2FNC/MPjPdyoF8CVJ8iFED/02uEOeyFS4hG
 3FTRVYOTSMahw2Gb4s28hG1QnoCeSB6r2zGSgzL3mQahVBYsGgQORYy/zOBqRvnBhf/2
 c/Nvudhfc7QEQjGVVTOLu3ptCFAySFieEgIZkLpYO/7LrNh+HeTiFVOaCRWBz8m8swhz
 UXHmbxESLRkE9ikccUe46eNejI4mjaYGjFWhnS+qWQEu/7pWeDeMOrPmbvIkiVH1H074
 qmcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUELCmWJ4TT88FYOz58+U2zyNkwmPM4J4OcCV7s7l73iXWQf3Mb/fl03bEqRLiGQJkcrbgKqowQejSu@nongnu.org
X-Gm-Message-State: AOJu0Yx11IxlCNVrE4DN1atuf4c2lhtK4jrksYH4drFSGMtxlIH9Sgoh
 WgwPkcxyIYnck7JrdTU1hLtSuWLU5B1jtF2mK0tn2cdsVqT3wGsb6vpohmHsLCKSikm3rXUokaE
 C7IrF8+2notpBV2NesvOm9upjox0SPlGLugUg8Q==
X-Gm-Gg: ASbGncsrvtJyPZRKdgP4AHR+h4r1wFHWcTLH0Nk+3+hvB8YWtGI45Zh4zv/hNXc05pI
 ZGHhiwMXgQMy/mf26wH5k2SHfccEfeY4LmzE2dn8=
X-Google-Smtp-Source: AGHT+IEMJ/EA44haRhoNqqcgYvMaKfo4A9GLrtA1T4dE2BKErqnvnQp0LThjFSldEgZFgyVyuelVTPxaFaDoN6w4puY=
X-Received: by 2002:a25:806:0:b0:e3a:e3e:2747 with SMTP id
 3f1490d57ef6-e538c400dcemr36714143276.32.1736182173403; 
 Mon, 06 Jan 2025 08:49:33 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QW02Mf5Vtp9UbvAUc+UXKV0Exw_ggFCMAgVQ0+dH7Jf0w@mail.gmail.com>
In-Reply-To: <CAJSP0QW02Mf5Vtp9UbvAUc+UXKV0Exw_ggFCMAgVQ0+dH7Jf0w@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2025 16:49:22 +0000
Message-ID: <CAFEAcA8C916fiLab_86JhXMe5sjVQBjFZQVCP6YP+715pn9qLQ@mail.gmail.com>
Subject: Re: test_x86_64_hotplug_cpu.py times out frequently in CI
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb30.google.com
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

On Mon, 6 Jan 2025 at 16:45, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> Hi Thomas,
> test_x86_64_hotplug_cpu.py times out frequently in CI runs. Here is an example:
> https://gitlab.com/qemu-project/qemu/-/jobs/8777540230#L1151
>
> The detailed test logs are here:
> https://gitlab.com/qemu-project/qemu/-/jobs/8777540230/artifacts/browse/build/tests/functional/x86_64/test_x86_64_hotplug_cpu.HotPlugCPU.test_hotplug/
>
> I looked at this failure with Dan and Peter on IRC. It was pointed out
> that the final command assumes that device_del takes effect
> immediately. The console log shows that the CPU was still visible to
> the guest when the final command executed.
>
> Could be a bug in QEMU, the test, or both?
>
> 2025-01-06 15:45:29,308: :/#
> 2025-01-06 15:45:29,313: cd /sys/devices/system/cpu/cpu0
> 2025-01-06 15:45:29,315: :/sys/devices/system/cpu/cpu0#
> 2025-01-06 15:45:29,320: cd /sys/devices/system/cpu/cpu1
> 2025-01-06 15:45:29,322: sh: cd: /sys/devices/system/cpu/cpu1: No such
> file or directory
> 2025-01-06 15:45:29,325:
> 2025-01-06 15:45:29,330: :/sys/devices/system/cpu/cpu0# [    7.337146]
> CPU1 has been hot-added
> 2025-01-06 15:45:29,330:
> 2025-01-06 15:45:29,335: cd /sys/devices/system/cpu/cpu1
> 2025-01-06 15:45:29,337: :/sys/devices/system/cpu/cpu1#
> 2025-01-06 15:45:29,342: cd /sys/devices/system/cpu/cpu1

Though the fact that there is no final shell prompt after
the last 'cd' command is perhaps evidence against this being
a simple race where the guest execution of the "cd" command
beat the guest handling of the hot-unplug event.

-- PMM

