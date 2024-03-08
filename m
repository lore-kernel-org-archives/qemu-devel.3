Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93A2C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 09:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riWP8-0008P5-D4; Fri, 08 Mar 2024 04:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1riWOs-0008Oc-JK
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:20:22 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1riWOq-0005u7-9c
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 04:20:21 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412f55695d1so15244245e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 01:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709889619; x=1710494419; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1DtM7SysaaTPWtbhSSlGg8jnxIgSal51MQROhQqVPeI=;
 b=aHwu0JqMeeXLE4zFF+v7MnWsQqKCpJp5viMRi7itF+r7HDlHL+I8OGrMUpZepmLROh
 3QgTq24L4NLJnYfZvDl+L+SAiH8XBQfxoFhuGA5ezj/Y/72EhOCLgkBOFQrYLYW2S/JN
 ge6ZwPK1Mx3VJQcrHcZ0TFUJixEVUwIuKq/L2+KSbBbOl8bjWTCA6UarIlXCRKEWnYqm
 Eh3QTkWiDhVioP6bgcGS8DepP3SSuJ40TxZjk55gyiPVcVVzqFpJRdyqcr5iYLbIQt/x
 +FSIAq3XuKmupmuQZ+fAbtH4BTl3tpNOKM5OAxR4kFsceTg3FH4u4xjRvcJ+VjyaPQjv
 4y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709889619; x=1710494419;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1DtM7SysaaTPWtbhSSlGg8jnxIgSal51MQROhQqVPeI=;
 b=rBRA14Nt6f5Mq5VZeltFCpvmyYIKijWRU19d5fYbJL1gwMEwusGVhCIMI6ynXuHo+O
 p7jAhHmzc5zeHxRMYRGlbC5DnUX5D0R4n6l57aknLx8VTMGr9JxPIbc4c1X34jsOxkWX
 CVEKji6uz+FrHkP/KpZ4uNSDBR6ltNSCAajPVvYMM6RciF0YCtOzLfOi+QQKVDwimFKQ
 3E0JV0XYb7DdV3dNh5ubgOvzEQGQwgad8JhyMRvFGux+tJyB+fD8N1wD4vwzmyXyqMVZ
 KDH1c5lJJicW+X1uMbN0c/e52MhOQ9rznqiVn8r3MztYDIQT9Viu+aRfTrscfB3eGpVl
 hSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXygOtQ2RaJu4yJ+xZVDsMPDo70Zg0E4lY5kqPsRHd3GsBJVxDfsot5n6+rkBQcDkupcWVB28xeaM43kIPW8FWAZjfADYo=
X-Gm-Message-State: AOJu0Yx41CfVC2l+sQgHTHCgMvDxLmAqswkjUCbM75tRxlPS0rx/TEuB
 C79M/rRVidJV4yMTZQHwkZJvQiILLs4/ji70gZZhhcyaVe6nnLZmOAeHHT1RnLQ=
X-Google-Smtp-Source: AGHT+IFl50qbSuf4nEI74nS+9jCiaUms/aHCrf8f/zU7c70prJoiq6xWmPVfvSrVE0ZRfaM8jvBmUg==
X-Received: by 2002:a05:600c:538b:b0:413:194d:12b8 with SMTP id
 hg11-20020a05600c538b00b00413194d12b8mr514044wmb.40.1709889618527; 
 Fri, 08 Mar 2024 01:20:18 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c4f8800b0041315c8ceeasm2734168wmq.24.2024.03.08.01.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 01:20:18 -0800 (PST)
Date: Fri, 8 Mar 2024 10:20:17 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: "Wu, Fei" <fei2.wu@intel.com>
Cc: Alistair Francis <alistair23@gmail.com>, 
 Atish Kumar Patra <atishp@rivosinc.com>, pbonzini@redhat.com,
 palmer@dabbelt.com, 
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com,
 ved@rivosinc.com, sunilvl@ventanamicro.com, haibo1.xu@intel.com, 
 evan.chai@intel.com, yin.wang@intel.com, tech-server-platform@lists.riscv.org, 
 tech-server-soc@lists.riscv.org
Subject: Re: [RFC 1/2] hw/riscv: Add server platform reference machine
Message-ID: <20240308-48ff9db3408048d387d6cfa4@orel>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
 <CAKmqyKMQyDjLkeo+aU58rE6_Vb84QeeZP3FUafw5GuWpk1JmZQ@mail.gmail.com>
 <8f5d6664-c075-4d31-bf33-ce24ceeb9b13@intel.com>
 <CAHBxVyHP1hgGWg6EByX6XzqmTm_Tr0uw7tk65KWcytNYsKdw8w@mail.gmail.com>
 <CAKmqyKM08RwR7RybMGaN6CpmbHJrLwx0DSjz_A1w6h0AkW12rQ@mail.gmail.com>
 <18efc373-b98b-4a9f-96c5-c6821793138f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18efc373-b98b-4a9f-96c5-c6821793138f@intel.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 07, 2024 at 02:26:18PM +0800, Wu, Fei wrote:
> On 3/7/2024 8:48 AM, Alistair Francis wrote:
> > On Thu, Mar 7, 2024 at 5:13 AM Atish Kumar Patra <atishp@rivosinc.com> wrote:
> >>
> >> On Wed, Mar 6, 2024 at 4:56 AM Wu, Fei <fei2.wu@intel.com> wrote:
> >>>
> >>> On 3/6/2024 8:19 AM, Alistair Francis wrote:
> >>>> On Mon, Mar 4, 2024 at 8:28 PM Fei Wu <fei2.wu@intel.com> wrote:
...
> >>>>> +config SERVER_PLATFORM_REF
> >>>>> +    bool
> >>>>> +    select RISCV_NUMA
> >>>>> +    select GOLDFISH_RTC
> >>>>> +    select PCI
> >>>>> +    select PCI_EXPRESS_GENERIC_BRIDGE
> >>>>> +    select PFLASH_CFI01
> >>>>> +    select SERIAL
> >>>>> +    select RISCV_ACLINT
> >>>>> +    select RISCV_APLIC
> >>>>> +    select RISCV_IMSIC
> >>>>> +    select SIFIVE_TEST
> >>>>
> >>>> Do we really need SiFive Test in the server platform?
> >>>>
> >>> It's used to reset the system, is there any better choice?
> > 
> > If we add this now we are stuck with it forever (or at least a long
> > time). So it'd be nice to think about these and decide if these really
> > are the best way to do things. We don't have to just copy the existing
> > virt machine.
> > 
> We need a solution to poweroff/reboot, and sifive test is one of the
> hardware implementations, so in general I think it's okay. But I agree
> Sifive test looks a device for testing only.
> 
> > There must be a more standard way to do this then MMIO mapped SiFive hardware?
> > 
> The mapped MMIO mechanism leveraged by Sifive test by itself is kinda
> generic, the sbsa_ec for sbsa-ref is also an MMIO mapped device. These
> two devices look very similar except different encodings of the
> shutdown/reboot command.
> 
> Probably we can have a generic shutdown/reboot device in QEMU for both
> sifive test and sbsa_ec, and likely more (not in this patch series). In
> this way, sifive test device will be replaced by this more generic
> device. Any suggestions?

Operating systems shouldn't need to implement odd-ball device drivers to
function on a reference of a standard platform. So the reference platform
should only be comprised of devices which have specifications and already,
or will, have DT bindings. Generic devices would be best, but I don't
think it should be a problem to use devices from multiple vendors. The
devices just need to allow GPL drivers to be written. With all that in
mind, what about adding a generic GPIO controller or using SiFive's GPIO
controller. Then, we could add gpio-restart and gpio-poweroff.

Thanks,
drew

