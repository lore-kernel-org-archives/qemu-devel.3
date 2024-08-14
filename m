Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBE5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 20:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seKGR-0008M2-Od; Wed, 14 Aug 2024 16:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seKGP-0008Kr-Bx
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 16:06:33 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seKGM-0007gR-Sk
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 16:06:33 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ef2cce8be8so3027821fa.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723665989; x=1724270789; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vM25kOL+kIlD5UWKXPq8/PQEgN2eOGwSdM3vNDHPTOI=;
 b=kPJijeQ4h9stFJS3U2Wew438FFi+Q2nBOQBZRXaStDd4tXntt2ahB8d3ZaflzfK+j8
 xNHKFLImr/vuyNtHxS3cyzqRapT/432M/jRgcHP6asR7LsPPKDuOgPisHbDxoG1Va3rl
 7DYoJLizfiaeZZ+luYF8akOJ9rDRZcZs9eaYutnOJ5NOU8FS1pekUWSk4jYQNiFJf9Hc
 mN7mAB1uI2RZdoaKEyet/tbxysLTbjCqJN/CSAb+GyH4tIRJO0nSU3TP7roUn8gGsFH4
 +lROkJPPIkNMOoH/aUPjuQLBxCQVIFhidKB1Zm/cmfmGYn4ZFSqI1tVlmalym797C/6o
 rKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723665989; x=1724270789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vM25kOL+kIlD5UWKXPq8/PQEgN2eOGwSdM3vNDHPTOI=;
 b=B7ViPb1n4UrNgP9fPPGp1mV1BNDABjJx4hbfpQhx7N7c9XaWg8zxBPHY+5f7zApx/9
 7hAj1Bln2qJmFZwPTviqEfW48wu2XM/JhgqKNiXXeFDv4GuhAefU4tqUm72MGFyaQHt3
 F+aup/dwksn5b+IYlcWMzWBpA/Lw6+drmyF2/bvsDV/onTjfjJ34KHtl3aNkWBojWXIr
 wtW9ml8CBIk5/3/FicW/MzjtIkDpDCJOixOYaELrLsQ2EQ3uRDWPAvCPhpLb69OrJata
 aaejIluztSK2VlFw5H2/yqtwyqINTAkoWhlB2cfMAOHDAm0TQH1x5EyF6gmLof5cyFNg
 Xp8Q==
X-Gm-Message-State: AOJu0Yw1vS8TP5M5iAB/DE9fYYrx/JbEVSEOVg8Ccqg3gWKl00JXL/Lo
 8XlgPTNFkG8GIQvw7FnTmdKsCtxPx08vARJYIVK12lK9HeS6lLr7wgCNSQB4/n/npyvc74Vk5h5
 wL3s0pcXACh9iP6WeVnKhvBT3JriqoyQOrzGFrg==
X-Google-Smtp-Source: AGHT+IFnf43d56G9pu9qXOdQzY2+gEw1mrsQDK7L6DiegSjkYWJT3pHdYiSZzCYPHDV1zSqyTJoJP2kZ724oVQQluks=
X-Received: by 2002:a05:651c:2121:b0:2f1:5d72:4239 with SMTP id
 38308e7fff4ca-2f3aa198545mr33896851fa.10.1723665988356; Wed, 14 Aug 2024
 13:06:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
In-Reply-To: <14c38495-131f-4798-bf41-da442ede23eb@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Aug 2024 21:06:16 +0100
Message-ID: <CAFEAcA8FFiiMXTcMR0WRP=Nhw3-+LYoP=X4OYrm5tnrp4L-wGQ@mail.gmail.com>
Subject: Re: [PATCH for-9.2 00/10] s390: Convert virtio-ccw, cpu to
 three-phase reset, and followup cleanup
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Nina Schoetterl-Glausch <nsg@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, 
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Wed, 14 Aug 2024 at 15:22, Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Am 13.08.24 um 18:52 schrieb Peter Maydell:
> > The main aim of this patchseries is to remove the two remaining uses
> > of device_class_set_parent_reset() in the tree, which are virtio-ccw
> > and the s390 CPU class. Doing that lets us do some followup cleanup.
> > (The diffstat looks alarming but is almost all coccinelle automated
> > changes.)
> >
> > Note that my testing here has only been "make check" and
> > "make check-avocado", which I know doesn't really exercise reset
> > very heavily.

> Nina, can you have a look at those patches?

If you plan to do any testing you'll want to locally fix the
silly mistake I made in patch 2 (a RESET_TYPE_COLD where
it should say RESET_TYPE_S390_CPU_NORMAL) -- see the review
comments on that patch. Sorry about that one...

thanks
-- PMM

