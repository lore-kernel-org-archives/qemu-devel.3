Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339F8C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTODg-00034E-MO; Fri, 26 Jan 2024 10:34:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTODd-00033O-Pz
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:34:13 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTODZ-0006FB-6Q
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:34:13 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-55790581457so374047a12.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706283247; x=1706888047; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M4Saib2ffvHXLnJNyPVgcq63SWcYMj7rwkJWn182XDM=;
 b=VcyXSRht3no2iRvyBrh2XW1lQnu7umJTDUHIhC99uHz7oo6MGDfvH6H72GHAO1f4bU
 wycdjohD4WLsXFhD5VaKncwQeiRs/zKpga7hI8GusekJudf5tf5rJc25+XXD20SaBBhS
 A7V9roiQr4R/4Q5/xZRj+TEbBPoKU3Ya9X6kI1x7sx4jUgV/YkFxQrK6beFjdcRF1Fvh
 iQDO18P0FKxDdDmaXdJmnVC+IIXV9y5I8xEnICh7sO4NYI2zpskiHYmeVgtLCWT0MGrb
 spOzpYzuG1SFWuLcXQ1soKByvzk2ltPaIMbrzpGTsttHkIXm/g9UghfS4FyGuMQ04Y3c
 6iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706283247; x=1706888047;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M4Saib2ffvHXLnJNyPVgcq63SWcYMj7rwkJWn182XDM=;
 b=tKkAghOtBHuSVgT3FezpxeGB+yIWM5LbOMX9uEvT8NdQWwY1cojoy5XpR727+zXC1T
 /fMuaJ7Mh+gwcP8/9FZeb7jtcYWy5I3+CTMpWPUg+A2tN0P37d6NySrkgR/MjWfrh1fo
 uXkOO17oYV5PrZxH1fUDVUHoYjGD6i5pVeTY5d5yX7rbFo16SbRFJfwsxp0GrBtynbNv
 55FaJsTKXot8w013i9i5ELrnq/z89+w29K8Lnvqbvuiv8lyKwrzjOuGPBwwAVIqmAdiC
 IAkcEFF7cIUzQx8dQsYw9ErLIfWUJ0Dpm9ngOVYtf/FW3L7+ikwPr3OGQQJulaQaLEDN
 UOPA==
X-Gm-Message-State: AOJu0YxLunojV17AbKH5/EGwRSQt9otK8QZ7OaJGK3nM9eTL7hlh3Ty7
 HbTNwX4Ei1UEyPdG2LH3KvScPo4nYBMFoJ7nl7r4uOOAwyex+eKHKB8l9DpXST/AmLePnAXaXVh
 0CwXVwDQBAm6NyNHT4XDgHWDZ/PLXk7jXSRpo0g==
X-Google-Smtp-Source: AGHT+IG1RgpPDHg/Tk9a1Ljt7riCeGAggNdSQjXAIweOSDuz+FDaRKVriWawUWF21cv3V4Yx8fZBlsfv334jNPewLMo=
X-Received: by 2002:aa7:d409:0:b0:55d:2b55:f1e2 with SMTP id
 z9-20020aa7d409000000b0055d2b55f1e2mr902001edq.37.1706283246891; Fri, 26 Jan
 2024 07:34:06 -0800 (PST)
MIME-Version: 1.0
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-2-dwmw2@infradead.org>
 <CAFEAcA8JtnXezmo-h-rFZcbqsN_-CnOYCTUfLfd_q=F0702U9g@mail.gmail.com>
 <d501dfc14c7b109844ff6d28f6be3bba86a1be89.camel@infradead.org>
In-Reply-To: <d501dfc14c7b109844ff6d28f6be3bba86a1be89.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 15:33:55 +0000
Message-ID: <CAFEAcA98ZW_1DtKvs-ZU=R9DOBwmnLPwnTBqPbTv7jE8zd1HoA@mail.gmail.com>
Subject: Re: [PATCH v3 01/46] net: add qemu_{configure, create}_nic_device(),
 qemu_find_nic_info()
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, 
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, 
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Song Gao <gaosong@loongson.cn>, 
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>, 
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jason Wang <jasowang@redhat.com>, Jia Liu <proljc@gmail.com>, 
 Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Magnus Damm <magnus.damm@gmail.com>, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, 
 Paul Durrant <paul@xen.org>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 26 Jan 2024 at 15:20, David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Fri, 2024-01-26 at 14:43 +0000, Peter Maydell wrote:
> >
> > > +NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
> > > +                            const char *alias);
> > > +bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
> > > +                               const char *alias);
> > > +DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
> > > +                                    const char *alias);
> >
> > Could we have doc comments that document the purpose and API
> > for these new global functions, please?
>
> Like this? I deliberately fatfingered the argument names and didn't
> even get a build warning, and I don't see any actual *documentation*
> being generated with it...?

We use the doc comment format to allow for potential future
documentation generation, but it's only actually generated
if there's a .rst file somewhere under docs/ that has a
kernel-doc:: directive referencing the .h file (for instance
there's one in docs/devel/memory.rst that results in
https://www.qemu.org/docs/master/devel/memory.html#api-reference )

For almost all internal functions, we set the relatively low
bar of "have a doc comment so people reading the header file
can see what the functions do". Where there's a more complex
subsystem that merits its own hand-written documentation
under docs/devel, then if the author of that documentation
is enthusiastic they can clean up and pull in specific headers
to add autogenerated docs. But the primary audience is the
human reader of the .h file.

> diff --git a/include/net/net.h b/include/net/net.h
> index 25ea83fd12..14614b0a31 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -207,10 +207,46 @@ int qemu_show_nic_models(const char *arg, const char *const *models);
>  void qemu_check_nic_model(NICInfo *nd, const char *model);
>  int qemu_find_nic_model(NICInfo *nd, const char * const *models,
>                          const char *default_model);
> +/**
> + * qemu_find_nic_info: Obtain NIC configuration information
> + * @typename: Name of device object type
> + * @match_default: Match NIC configurations with no model specified
> + * @alias: Additional model string to match (for user convenience and
> + *         backward compatibility).
> + *
> + * Search for a NIC configuration matching the NIC model constraints.
> + */
>  NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
>                              const char *alias);
> +/**
> + * qemu_configure_nic_device: Apply NIC configuration to a given device
> + * @dev: Network device to be configured
> + * @match_default: Match NIC configurations with no model specified
> + * @alias: Additional model string to match
> + *
> + * Search for a NIC configuration for the provided device, using the
> + * additionally specified matching constraints. If found, apply the
> + * configuration using qdev_set_nic_properties() and return %true.
> + *
> + * This is used by platform code which creates the device anyway,
> + * regardless of whether there is a configuration for it. This tends
> + * to be platforms which ignore `--nodefaults` and create net devices
> + * anyway. This behaviour is not advised for new platforms; use the
> + * qemu_create_nic_device() function instead, which creates the device
> + * only when it is configured.

I disagree about this paragraph. The behaviour we want for new
platforms is:

 * If this is modelling some board where the ethernet device is
   always present (eg it is soldered on to the board, or it is
   a part of the SoC that the board uses), then always create
   that device
 * If the hardware being modelled has the ethernet device as an
   optional device (eg physically removable like a PCI card),
   then the board should arrange that --nodefaults causes it to
   not be created

Basically if the guest OS is entitled to assume the ethernet
device is present then we shouldn't allow the machine to be
created with it not present, because all that will happen is
that the guest will fall over in bootup.

(Similar applies to things like whether the board should
honour the option to disable USB support or not.)

thanks
-- PMM

