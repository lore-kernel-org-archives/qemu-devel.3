Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99297C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNQR-0005PY-Oy; Fri, 26 Jan 2024 09:43:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNQQ-0005Og-Es
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:43:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNQM-0001kl-EV
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:43:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40eacb6067dso9506745e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706280196; x=1706884996; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EhLQSD7+BW8XOT2H7obLO80KK16iLrWUr/ASvWBkRuk=;
 b=BMZGQSvzoOeTntngJ/IEvyrBpzW0wApmUBmM12jDwRt3BGnFKaI06PDYlOd5vD1yuO
 OJBN7PAJTozEyAiPyXM/YVkLbpcnZD5Bs6SZ2nsD1olS6yHCqt2W0V3fKYzL6j3K7w6b
 w4Qceuc56ThSGxmXWtxHE/h+LldImVlgCHEpkOjXX0QVHbbzyOUOJ9BnnSSdBBF0aNko
 rtg8LuapCA+O2M3ue1JCAy4+JW0f5iYQtV3+F20dhzMBFf04JxgKOUxFveChxBo5gmZm
 /gkPONYYvL5h4FbJzV1JQf+WIsHo2jx0gkmuAMsL0sBF2PCNytzkwHtLPWWXB3aTft8p
 Jh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706280196; x=1706884996;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EhLQSD7+BW8XOT2H7obLO80KK16iLrWUr/ASvWBkRuk=;
 b=j8dk9sNPLpITX8tS6mdKuOJHw7Meu6SxTuhbgLhNLmljCgnxh5fpjr8Ey/0r87bnXy
 5Lh0fXtTE8Bgmxm3SGtooIa1OmR1+8eZ7eg+Cuh8AiBicJXXSv4RnAbBSpLV2Trp8PLg
 HUua1OXlddZ6pWtJb3YpUL4tgdU/l2uckp9ZxJeoAZDqnlY40mFuNtiqA0jrGWzaGV6E
 Y6M+utBlis3LYOU3T/84squzRJRShqrysUfgv2NOuUOzoyDRLkLgj/ZppFUMymm0DQlz
 GyjTykl6xWUYTfTIM/Ku3KkfFVt3c0UEbiVgMxzwqi1hoLTazXW9PjcGlXAb4nt1Bt9m
 y2hw==
X-Gm-Message-State: AOJu0YxTrnCbrx9c4dkHbdEI2CBGujh4YgQzMz/qx8A7tx3X871kXslX
 c4C9S1wmTrvF39Qgbt4g8eubyaPGbNwIHbyfTgFkiuaBIxg+pEysxIktyHdToESRhx2U8DTdRuY
 U5O6u18mV5LuyJMF+AVpUFR3Du+bo1h+95LbvQQ==
X-Google-Smtp-Source: AGHT+IGgFYkEGapICfD+7OZIAc7B1qLYTLJlzePH6Kestx1lg5b0pP5KESins2khUNkI4Y7yAyfKuXsSzxAbztCM8KU=
X-Received: by 2002:a05:600c:1992:b0:40e:5577:189 with SMTP id
 t18-20020a05600c199200b0040e55770189mr568615wmq.147.1706280196041; Fri, 26
 Jan 2024 06:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-2-dwmw2@infradead.org>
In-Reply-To: <20240108204909.564514-2-dwmw2@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 14:43:05 +0000
Message-ID: <CAFEAcA8JtnXezmo-h-rFZcbqsN_-CnOYCTUfLfd_q=F0702U9g@mail.gmail.com>
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
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

On Mon, 8 Jan 2024 at 20:49, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Most code which directly accesses nd_table[] and nb_nics uses them for
> one of two things. Either "I have created a NIC device and I'd like a
> configuration for it", or "I will create a NIC device *if* there is a
> configuration for it".  With some variants on the theme around whether
> they actually *check* if the model specified in the configuration is
> the right one.
>
> Provide functions which perform both of those, allowing platforms to
> be a little more consistent and as a step towards making nd_table[]
> and nb_nics private to the net code.
>
> Also export the qemu_find_nic_info() helper, as some platforms have
> special cases they need to handle.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Paul Durrant <paul@xen.org>
> ---
>  include/net/net.h |  7 ++++++-
>  net/net.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/net.h b/include/net/net.h
> index ffbd2c8d56..25ea83fd12 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -207,7 +207,12 @@ int qemu_show_nic_models(const char *arg, const char *const *models);
>  void qemu_check_nic_model(NICInfo *nd, const char *model);
>  int qemu_find_nic_model(NICInfo *nd, const char * const *models,
>                          const char *default_model);
> -
> +NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
> +                            const char *alias);
> +bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
> +                               const char *alias);
> +DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
> +                                    const char *alias);

Could we have doc comments that document the purpose and API
for these new global functions, please?

thanks
-- PMM

