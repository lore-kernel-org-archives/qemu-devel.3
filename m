Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038DDC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgo3-0001sZ-Ta; Mon, 11 Mar 2024 10:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rjgnw-0001rs-JT
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:39:05 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rjgnt-0002az-Io
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:39:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41312232c7aso22406315e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1710167939; x=1710772739; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CQwXoVjjKkf5ofxVuJNzw8djEb1STgxmk43Yqpc2Y7s=;
 b=RoJHwnKaEWDmZZO6ps7sbhLvE3MzCCUpQFiTXUxRJG3DGV18bU6lbQPI2vZVfmLy4D
 oDnYATTiER+yFfJhzx3ExP6l8FzTPXQKqQz0dM8Tvywp7QbAkHlC+pxdLMJEYaErmnU4
 Idp3mtuNQ/kQGQemJ6Qop15NG8AZk5LIqLfFDQz7ZRl1aMQYiwlNgO5O8Cdt1Jc6mPq7
 R8ZF4kcJcYMKqIHNi0QHAMbqqWfPKrZEleqI9UF+sHUCdI7cA5NNMwrXGbBumxm9IaHf
 P5H5h3sW9VJq9yVf+AW/T/qw0oytae3mTqZaRoaMp2pjxh3I2JjlNW4l/r6A7Bn9yl3q
 ZZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710167939; x=1710772739;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CQwXoVjjKkf5ofxVuJNzw8djEb1STgxmk43Yqpc2Y7s=;
 b=FslZe4TueHQLBZPvQmkmJ9Qy/VpjLSzPa/FJIMKmTKSVFHReOJ8BDEEb2SJlNTPf+z
 +I+wZrf3LcMb4j0U4/6GUSr9O/3FBJgUi/yEDe474m5xPccxK+zc4xqOKlGSvM6koTKV
 5dSVXRQ2wR0NugZUuujsBZlLn4Vb8uN37rTVkWqtapiqB2CrqphbluhAQtdv+nknIZCb
 792rmsqU1UUbV8dL8ox92VV+eRYDZPqt1zBAV45JooaorrfymnxogJP9vzWK9MyW92W+
 8DtpHSUbpqpziWUIJx1M/MP4aKT6ShKU84A3EIDt1mP5PRzFG/5yW0iPdxLjI/ZersmZ
 UtSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDaRl4rtXhiI8DDESyklV33ojQAUaut6sK1HdVPNcCd7BpQIougTt9uPvR3FQQO/KUDpNrFMzxN9k9IMgV/mCb+D8gy5w=
X-Gm-Message-State: AOJu0Yy+c7WRV5ZGURV0i5UINdCqrOnOQYWPygGO+DMxnr3G1odQVK0+
 NIKv/zSPPW3ik8w0bZt0gy8mU35jFe2IOurQ+2lpcvnxK+b3+gH6mYLW2VnIYGM=
X-Google-Smtp-Source: AGHT+IFzXUb1PAMvjtNOELAdCeUFVZFYTrT6HDLvIf4V21TcC3zfKgb+/PEWRNvLUX9I9XA+azYs0w==
X-Received: by 2002:adf:ab48:0:b0:33e:9f16:33c with SMTP id
 r8-20020adfab48000000b0033e9f16033cmr953296wrc.18.1710167938469; 
 Mon, 11 Mar 2024 07:38:58 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c310900b00412e3717ae6sm16008207wmo.36.2024.03.11.07.38.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 07:38:58 -0700 (PDT)
Date: Mon, 11 Mar 2024 15:38:57 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: "Wu, Fei2" <fei2.wu@intel.com>
Cc: Alistair Francis <alistair23@gmail.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, pbonzini@redhat.com,
 palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com,
 ved@rivosinc.com, sunilvl@ventanamicro.com, haibo1.xu@intel.com, 
 evan.chai@intel.com, yin.wang@intel.com, tech-server-platform@lists.riscv.org, 
 tech-server-soc@lists.riscv.org
Subject: Re: [RISC-V][tech-server-soc] [RISC-V][tech-server-platform] [RFC
 1/2] hw/riscv: Add server platform reference machine
Message-ID: <20240311-bef101446cc9ea2b033b417d@orel>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
 <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
 <CAHBxVyHP1hgGWg6EByX6XzqmTm_Tr0uw7tk65KWcytNYsKdw8w@mail.gmail.com>
 <CAKmqyKM08RwR7RybMGaN6CpmbHJrLwx0DSjz_A1w6h0AkW12rQ@mail.gmail.com>
 <18efc373-b98b-4a9f-96c5-c6821793138f@intel.com>
 <20240308-48ff9db3408048d387d6cfa4@orel>
 <fee8e89a-7d87-43b8-bc87-af76a67c4317@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fee8e89a-7d87-43b8-bc87-af76a67c4317@intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32f.google.com
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

On Mon, Mar 11, 2024 at 04:55:24AM -0700, Wu, Fei2 wrote:
> On 3/8/2024 5:20 PM, Andrew Jones wrote:
> > On Thu, Mar 07, 2024 at 02:26:18PM +0800, Wu, Fei wrote:
> >> On 3/7/2024 8:48 AM, Alistair Francis wrote:
> >>> On Thu, Mar 7, 2024 at 5:13 AM Atish Kumar Patra <atishp@rivosinc.com> wrote:
> >>>>
> >>>> On Wed, Mar 6, 2024 at 4:56 AM Wu, Fei <fei2.wu@intel.com> wrote:
> >>>>>
> >>>>> On 3/6/2024 8:19 AM, Alistair Francis wrote:
> >>>>>> On Mon, Mar 4, 2024 at 8:28 PM Fei Wu <fei2.wu@intel.com> wrote:
> > ...
> >>>>>>> +config SERVER_PLATFORM_REF
> >>>>>>> +    bool
> >>>>>>> +    select RISCV_NUMA
> >>>>>>> +    select GOLDFISH_RTC
> >>>>>>> +    select PCI
> >>>>>>> +    select PCI_EXPRESS_GENERIC_BRIDGE
> >>>>>>> +    select PFLASH_CFI01
> >>>>>>> +    select SERIAL
> >>>>>>> +    select RISCV_ACLINT
> >>>>>>> +    select RISCV_APLIC
> >>>>>>> +    select RISCV_IMSIC
> >>>>>>> +    select SIFIVE_TEST
> >>>>>>
> >>>>>> Do we really need SiFive Test in the server platform?
> >>>>>>
> >>>>> It's used to reset the system, is there any better choice?
> >>>
> >>> If we add this now we are stuck with it forever (or at least a long
> >>> time). So it'd be nice to think about these and decide if these really
> >>> are the best way to do things. We don't have to just copy the existing
> >>> virt machine.
> >>>
> >> We need a solution to poweroff/reboot, and sifive test is one of the
> >> hardware implementations, so in general I think it's okay. But I agree
> >> Sifive test looks a device for testing only.
> >>
> >>> There must be a more standard way to do this then MMIO mapped SiFive hardware?
> >>>
> >> The mapped MMIO mechanism leveraged by Sifive test by itself is kinda
> >> generic, the sbsa_ec for sbsa-ref is also an MMIO mapped device. These
> >> two devices look very similar except different encodings of the
> >> shutdown/reboot command.
> >>
> >> Probably we can have a generic shutdown/reboot device in QEMU for both
> >> sifive test and sbsa_ec, and likely more (not in this patch series). In
> >> this way, sifive test device will be replaced by this more generic
> >> device. Any suggestions?
> > 
> > Operating systems shouldn't need to implement odd-ball device drivers to
> > function on a reference of a standard platform. So the reference platform
> > should only be comprised of devices which have specifications and already,
> > or will, have DT bindings. Generic devices would be best, but I don't
> > think it should be a problem to use devices from multiple vendors. The
> > devices just need to allow GPL drivers to be written. With all that in
> > mind, what about adding a generic GPIO controller or using SiFive's GPIO
> > controller. Then, we could add gpio-restart and gpio-poweroff.
> > 
> I agree with most of what you said. Regarding generic devices, syscon
> looks a better choice than gpio in the current situation.
> 
> Linux kernel has these configurations enabled for virt, and I'm not
> going to add a new soc for this new board currently, we can use the same
> syscon interface for power, and it has already well supported.
> 
> config SOC_VIRT
> 	bool "QEMU Virt Machine"
> 	select CLINT_TIMER if RISCV_M_MODE
> 	select POWER_RESET
> 	select POWER_RESET_SYSCON
> 	select POWER_RESET_SYSCON_POWEROFF
> 	select GOLDFISH
> 
> For the qemu part, we can remove device 'sifive_test' and manage that
> memory region directly with MemoryRegionOps, similar to what
> hw/mips/boston.c does.

OK, that sounds good. Also, I guess the real concern is whether firmware
(e.g. OpenSBI) supports the platform's power-off device, since firmware
will present the SRST SBI call to Linux, so Linux doesn't need to worry
about it at all. However, if we want Linux to worry about it, then we
can't forget to ensure we can implement the syscon interface in AML for
ACPI too. Indeed, we should be introducing ACPI support for this reference
machine type at the same time we introduce the machine in order to ensure
all device selections have, or will have, both DT and ACPI support.

Thanks,
drew

