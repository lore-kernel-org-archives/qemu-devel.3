Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7179DCAC5AA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1hti-0005NK-4G; Thu, 25 Sep 2025 05:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1htg-0005N4-5r
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:04:16 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v1htU-000790-W9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:04:15 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-63606491e66so267512d50.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758791037; x=1759395837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dld1ba+AnsgKXWbWk45Ixi30ieyIRKmfsUvvsafRSDw=;
 b=JgNOfjhmZ8S5KCyPybDVmINegLz6pMSM/eBTsf/yQpMVfdyczCAEqb1QEfBDnwRc1F
 3V35aPvgeUvkb0y3CVYft8ngE4s9FUjvtQAwQrfBhtN17DDecCIqReghL0TYZbc1Es6j
 NT/hQI0CDeTX3jFm67JOurGX2ikAfvFM1wkN2Gi/pKdeaaGZc94GnNb8utKR0hsERXlv
 crM7K6Dn5AHL/0ku1tjVEL7obfoQhVXVD/ai+LzFhV3H+5Qlq/R16zXRiiV5nmXNgT0g
 Msh9UwEQ/2yqMaeyqLUdwW/TN5tJCuxxOHovYM1j7tjjXnU6Ku4vzEH5qgMc9DKUeblH
 mB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758791037; x=1759395837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dld1ba+AnsgKXWbWk45Ixi30ieyIRKmfsUvvsafRSDw=;
 b=t5wLBUeY2YqqJk5zSJuPfDloAP5gXxkq9lT+nmZaGpnH2L0WiPB6gnOXpwinq6MtMf
 jzbZitnQrc5kZVLFBckxe+nYFNUs4bTRsPRspA9ntJVv/gW6arEG33ARm0++ERqIOFa6
 O0NnY6jfrV4W9vcZSiJlN611MomJGIFHO1lgSHa+ZRnX+q2cLFMgpKHL6x83StYAnplE
 S6J/h0P10VMSRk8jPAIdzfek4O6NlfoP537OhoYXPV0cuS7JDMAkP+hMMQFGUcDV48Co
 vWO2N6Ue58FdSA5Mg95/F2reiCT7k9QiP2cg5ClvGyYXh8zBogVKfzk1k1s8stZohI2y
 97vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmshHx3SkFyXmg/+cqUO5GdU2/8J8KRPESkSZb7szzJEpvz7FTDP/N2RRhOzxjKntoZsSlbuHLcBjU@nongnu.org
X-Gm-Message-State: AOJu0YzT/f85tcc8jfKxvWGYcudtR2svJAhZU83Kr8lk/HTLd2bIUNpm
 aajpQbmdqgbC84HidKkZk2ggho2ESxBWxYavQUShsL2S2EY1xfpzXuwsKD8C8Emr9/4o7PNtwL3
 kLKeHdOPfa6F82ESidayx9YFuoZLFqeU65GL/icHLcQ==
X-Gm-Gg: ASbGncv54lGOHI+c+KwGaw0XPvxX9dmYQq7u+uNr5iRA6AWTpaY1FV3IE10heRJopbA
 6cVOXBm06/VVFbhIrROAVxxPtgyIMzgdkVrOY/JCbTvnd5IjvcGa7sIGf/y75Vps1YF2iOOBuG+
 aaEP0bK5cqkabqew6VP3Ylgvnw4XRdMlvmbL6t5fuU4hfEdHoudHsPWv/aZe5r/V9PWVLZOegy+
 yvytqPE
X-Google-Smtp-Source: AGHT+IFsXzWZE+4zUQOVmvdNOCEHj7f2t08r+lPLOHkxnkmA+HY6VUlD3JYex/uosUNK66D0wqoYsT0oeRI9Id5po7Y=
X-Received: by 2002:a53:d016:0:b0:632:9d08:e3ec with SMTP id
 956f58d0204a3-6361a86132cmr1749195d50.25.1758791037315; Thu, 25 Sep 2025
 02:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
In-Reply-To: <aNRfHQoBgwBMjK04@x1.local>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Sep 2025 10:03:45 +0100
X-Gm-Features: AS18NWBXqgC9-2Kmdr52HoJSaRceusD4OCyhIWSuLaEKc23hV4JiRu6tTV83fME
Message-ID: <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 24 Sept 2025 at 22:14, Peter Xu <peterx@redhat.com> wrote:
> Side note: when I was trying to test hotplugs with i386/q35, unfortunately
> I didn't really see when the address space was destroyed, maybe there's a
> bug somewhere; I put that info into appendix at the end.

This is https://gitlab.com/qemu-project/qemu/-/issues/2517

I got blocked on that because I ran into a weird "I have some
memory that needs to be freed by the RCU callback, but only
after the callback has freed some other RCU stuff". I see
Paolo made a reply on that bug -- I would need to get back
to it and reproduce whatever it was I was doing.

-- PMM

