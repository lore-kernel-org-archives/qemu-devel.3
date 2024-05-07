Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E404C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 12:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4JYQ-0007IE-51; Tue, 07 May 2024 08:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4JYK-0007GH-FQ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s4JYH-0003pG-VW
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715083449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pcvgcU5Fv7ENt9oX7fAM/VFF5dv15GwmyrDXahZcKwk=;
 b=K9Uu150vu2facR5hHfQRq+iSH/WD7enfX0JkTsXNHl66u5K/0758bk2YlI5cEIIOE7norP
 ZBmryPoq1/kRlWcmy6dVteaEDRZXwBas6oicOmu2KaCf6VkjrmxhHsuLUe8NNzePs+ol35
 SchbLH1vUXZaIZOajk5ptPoqfbAR11g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-dian5aveMBWoet1Vg8o4fQ-1; Tue, 07 May 2024 08:04:07 -0400
X-MC-Unique: dian5aveMBWoet1Vg8o4fQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-34d9b4d3a4fso1878700f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715083446; x=1715688246;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pcvgcU5Fv7ENt9oX7fAM/VFF5dv15GwmyrDXahZcKwk=;
 b=WRmu1V/JPp8tPdSkGY6+Evnj7rZMI1yblsb0ofLVxAENwTS1xEdY1F7Xaew8J03Ppo
 csSN/espbg2KNdik8h9qr8uvqGWCixn+Hj4JCOeV28UrnGFRwc16UzibvlkVUHOgdVA4
 5mEKnXA07ZskWrtyT180lSItNgYrlJXX3AKNSKWEPvlDJ0rqV1UV0GzFBCa1ug9Ctaaj
 pxUvd1sTX5yiUzQ50vlx8DPCEitYcJyIfWVd8Re5R35GP+aa11n47DNwMqZJU0bQzxgP
 UTuQIxpfet0mQ96mS4sTUjQvutRD8kNbV9td23m3tpVEI0yTqKZh/pJZcizUDLcMnp3h
 nQ6g==
X-Gm-Message-State: AOJu0YyVMGVqMiSfptYStnTKOGWqVvMAuIOCkhNjdR/li5djLarq5luJ
 Lv5qt5z8I2e6Uc7GxTIMZpHYEX301pdhKqL5/uuGKSUepbg48fyHUguNYNXSRDehhVTrdoTz7ui
 y3pLYQ/x4pJCBb6brEUD+GDFfJGnWvEwA2nF6LUTicl7TVsCXblnywnqxyn/E92PWxrjBaEYfKx
 UUPrwEiSl0WEdghVMHSlNr45iMoRo=
X-Received: by 2002:adf:e2c3:0:b0:34f:7b5a:e52 with SMTP id
 d3-20020adfe2c3000000b0034f7b5a0e52mr2437225wrj.63.1715083446337; 
 Tue, 07 May 2024 05:04:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjhOvlN5UHEot4SPNujsoGBdV4L8i2bVx2jQT25HGOL0LoBXjdTMi9u2cezG6C1AW+w5GBsHKuPrnN6fICyrc=
X-Received: by 2002:adf:e2c3:0:b0:34f:7b5a:e52 with SMTP id
 d3-20020adfe2c3000000b0034f7b5a0e52mr2437207wrj.63.1715083446012; Tue, 07 May
 2024 05:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240507104926.179301-1-pbonzini@redhat.com>
 <CAFEAcA9uBWCNGDVX8C9nNV2xEHuZZPkMjHUWvvc8OM5h_ttv0Q@mail.gmail.com>
In-Reply-To: <CAFEAcA9uBWCNGDVX8C9nNV2xEHuZZPkMjHUWvvc8OM5h_ttv0Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 May 2024 14:03:53 +0200
Message-ID: <CABgObfaAFm1V8Vp7kYEua9a=5KTOsKzyZu9HgBssS5NNykqtpw@mail.gmail.com>
Subject: Re: [PATCH] configure: quote -D options that are passed to meson
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 7, 2024 at 1:58=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Tue, 7 May 2024 at 11:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > Ensure that they go through unmodified, instead of removing one layer
> > of quoting.
>
> Do you have an example of what goes wrong that we could
> mention in the commit message ?

I only found it by inspection. The only case I can think of is
"-Dpkg_config_path=3D/home/pbonzini/a path with spaces/".

I can add the following text:

---
-D is a pretty specialized option and most options that can have spaces
do not need it (for example, c_args is covered by --extra-cflags).
Therefore it's unlikely that this causes actual trouble.  However,
a somewhat realistic failure case would be with -Dpkg_config_path
and a pkg-config directory that contains spaces.
---

Paolo


