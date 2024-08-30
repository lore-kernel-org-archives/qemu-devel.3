Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C070FCA1009
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk4TR-000802-EL; Fri, 30 Aug 2024 12:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk4TP-0007xl-KF
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:27:43 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sk4TN-0005CZ-Kw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 12:27:43 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5bec4e00978so2141581a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 09:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725035259; x=1725640059; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4blPcePziWLyzuPvJxOTQGTR3QYe2HPCb0g45Ev3gcA=;
 b=lpbPf1euRcgcVv+FB9CDvJk847JbLEUGQPd1Fj+PdLyIMoEFx9Cl1PH6iaxq4gtkwh
 M0hqCzrrWoShtVOZTSoWKxD+k+ee3ncGxSXIUDpJLyBE8iIOmURTBOQMcDS4DR03CWac
 MtK274ULzelTePu/kRUbhWNz0TwEgFFv81sAC5yLtSmzzmfVe3FJ3vpvil4pWfxPHOr9
 3Y5pi4S2FwJMBx0iSukFJliJHfh2sWSHI/QSNEZLQs0COWWOnkxvRBiY9wZzhR7lOg/f
 Q4vJQAXco1A2QaSq1I/M8TIn5beVTu+SiYFqlGeQhX3GCr864HwLXSnK1SDi9+JYVfEZ
 N2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725035259; x=1725640059;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4blPcePziWLyzuPvJxOTQGTR3QYe2HPCb0g45Ev3gcA=;
 b=lIbh6kisTZucnHGrtzQEGq7jLqRHQNuqwiFtvK1qs5sXnqCiOP38KgLhabsLYUIiBE
 gNUtMCv8evmEbDvgSKpmZavhDS9t/jpMAiAt0w2ZDfMRbf1opKeekQFnn+g4eFBekYEq
 8rAh5MAgT37buw87eXnzR9m2WnR/FR2rYCe9P2lEXY8QDhaRSSrAXKwQZEx69dJoqvoJ
 XzJHfP9nsRVDue1hstJNKMbcNkZPa392+xLcYv6IoksIGlL+mCgpfyg4VxLQkrUBYNBr
 2pcOSsaXAGZH38AHLH27VAwPcPxHvP1BA8h7m2m4OJF624Dc8hFt4N53dpYPEwsChTbP
 QJcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/Fz5K9cgkpjqbJZifgUWbaolYrRmxiDmUmqGBZOIQP7g4Y0nhjQW5EAvOL9qCfmxXc+uwxtVIfXMq@nongnu.org
X-Gm-Message-State: AOJu0YyfF602ZvTh2tyudzu+LPOTA1nxi1z32Vs5r5SQf3Po0En5GZiB
 24SOSjcSmf0VRAqX5R2GQMqYI96FJT3TvZA59LP4tEcc4zYBQhMspY6wtssYXNL+vbyHwTVa/0i
 F96D/+8uzWWPAUUTwRnv7ojkmYZ2Zt9868wmbag==
X-Google-Smtp-Source: AGHT+IFwkkcq1m0brgFB+wZdvpZoo9DWCXjBJZUFaFjTNuFDCSe61rwDAQw9f5TUteoh63/mT9oXpuuYj91NFQKfQew=
X-Received: by 2002:a05:6402:2696:b0:5c2:18fd:8a22 with SMTP id
 4fb4d7f45d1cf-5c21ed31392mr5566950a12.7.1725035258972; Fri, 30 Aug 2024
 09:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
 <b88fe895e6f71711387ca153f4f1b3fbb0aa2176.1724556967.git.mchehab+huawei@kernel.org>
 <CAFEAcA-OaQ1ypa7LXz5nOs+6+fjmYNHzNL0VVgapoXEHU=rHnQ@mail.gmail.com>
 <20240826035324.6b1edcc7@sal.lan>
In-Reply-To: <20240826035324.6b1edcc7@sal.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 17:27:27 +0100
Message-ID: <CAFEAcA-wD6U+onh3y4Y-LDTFuYoeWbGShkRPx7emi1ZPfKJP0w@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] target/arm: add an experimental mpidr arm cpu
 property object
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 26 Aug 2024 at 04:12, Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Sun, 25 Aug 2024 12:34:14 +0100
> Peter Maydell <peter.maydell@linaro.org> escreveu:
>
> > On Sun, 25 Aug 2024 at 04:46, Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Accurately injecting an ARM Processor error ACPI/APEI GHES
> > > error record requires the value of the ARM Multiprocessor
> > > Affinity Register (mpidr).
> > >
> > > While ARM implements it, this is currently not visible.
> > >
> > > Add a field at CPU storing it, and place it at arm_cpu_properties
> > > as experimental, thus allowing it to be queried via QMP using
> > > qom-get function.
> >
> > >  static Property arm_cpu_properties[] = {
> > >      DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
> > > +    DEFINE_PROP_UINT64("x-mpidr", ARMCPU, mpidr, 0),
> > >      DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
> > >                          mp_affinity, ARM64_AFFINITY_INVALID),
> > >      DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
> >
> > Why do we need this?
>
> The ACPI HEST tables, in particular when using GHESv2 provide
> several kinds of errors. Among them, we have ARM Processor Error,
> as defined at UEFI 2.10 spec (and earlier versions), the Common
> Platform Error Record (CPER) is defined as:
>
>    https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html?highlight=ghes#arm-processor-error-section
>
> There are two fields that are part of the CPER record. One of them is
> mandatory (MIDR); the other one is optional, but needed to decode another
> field.
>
> So, basically those errors need them.

OK, but why do scripts outside of QEMU need the information,
as opposed to telling QEMU "hey, generate an error" and
QEMU knowing the format to use? Do we have any other
QMP APIs where something external provides raw ACPI
data like this?

-- PMM

