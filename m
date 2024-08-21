Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E832BC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 13:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sglYU-0006yR-Og; Wed, 21 Aug 2024 09:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sglYT-0006xu-Qh
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:39:18 -0400
Received: from mail-vs1-xe2f.google.com ([2607:f8b0:4864:20::e2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1sglYS-0008FB-An
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 09:39:17 -0400
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-498d7ab8fefso269174137.1
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2024 06:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724247555; x=1724852355; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O3dm7p2v7Jy6x5ueMRvAp6OK6Ue//DKjosRhS4/nHWk=;
 b=FXOy6oqg1w8I2W48Emix9uR/co5v1izoy139ZCRkhmc8NmQtUcUEeGGcMuzhD6/qL2
 h7xrixclxv3nVThq1wu0rpUnYPfSU+UMeyehtDgWxD/XEa6SmNwIEH3Eq5V0U6zXmx5b
 Vu+WP8+SabyBW8FY0GFLmC/qCLsK/g4W/3W1Xl3dG2pEK0rdli3Ssz46GDBl+Ra+K2X2
 dSDFy7V35v7EkRttQj+eqRgnDGWDBo5W1T3dZ9HuEdl5bkohaUVW0LvdXhoV7gqv2fKV
 dPFuebZfpsTJTqQVitDMFwSEvME7ajx9093P5gJ5lkbmcYSbD6NASDGn1WEByuxAa/MN
 iR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247555; x=1724852355;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3dm7p2v7Jy6x5ueMRvAp6OK6Ue//DKjosRhS4/nHWk=;
 b=kBcoBFyiOXIqmkHA5c/bzM7dAGX9MSpU/mQqm0nvdrnqQOjZRJYE0T+YH/UObkEdAM
 meYwyJq69QCt89k4+rjgJdIjIereMKNrjYUGAhQ16a35PDQmtyjifxXMxs/sXoi9tS2t
 gX/X9v37DfBR6zsFl9lnTh8RtzkxHjquqzyhVopXBRD7/dPP+xW+IHweR5lfnAKldF+G
 VT/Axc6oaxyfUz3c3BR0Z0BgDqM08XK7KFAQKFn2lMd4nKuQ1Ho8TJ+BbYDt0+KbMeRT
 ZI5RwrBuh6obrhI1aU1O6c13prLxaGYh6dptzbBeScksoyV34LvYU+mHqSTyT2m0IknB
 /ESw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeE8UpL1LBEzemCD9yGCt3lhoP4N4WMjZeBRC3dRCmxfkZdiPod2G+BijGNpc7OgeGt6L+1TMX3eoI@nongnu.org
X-Gm-Message-State: AOJu0YwKVD137tGMNDHRhUCE4uVoJidVAooPTw61q1Y330h31XyMuWaR
 SIJgFcGLpK7M+8RZzAakhXXS860Fdi2+oS0u1pqFaBLRLk5nJ3xPyQZ9r6t3slqKGnETmBCILh6
 m2aXl3LrZZx+zcrJ6n5wwV5sUH8M=
X-Google-Smtp-Source: AGHT+IEZcGejc2ShTBm0L+KzlMJAw1FcRM418JX5om+k1vhhnAWhTUYZTT1GYS2qaPTMGfLycxfjCnuhqA3gGvo+MC0=
X-Received: by 2002:a05:6102:3909:b0:493:ce48:a2ed with SMTP id
 ada2fe7eead31-498d2fbff87mr2340476137.29.1724247554844; Wed, 21 Aug 2024
 06:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240818114257.21456-1-dorjoychy111@gmail.com>
 <20240818114257.21456-5-dorjoychy111@gmail.com>
 <bffedf65-6046-4264-a2fe-011ff8c58860@amazon.com>
 <CAFfO_h7+FEzp-FrYM68A104CyNKgUfEReB+o9gYg5i-f=5DsVg@mail.gmail.com>
 <ZsNqerjjLCJ2OICd@redhat.com>
 <CAFfO_h5uQWrEKVK+E_QW7x64kdPms4uFeP8TjDVq7JEWANKXPw@mail.gmail.com>
 <ZsNuf4jSSF4F37Pp@redhat.com>
 <CAFfO_h6V1o3jx4sJ55+Wn7FiXpCcLNrZQtMboR4t6FMQuzg80w@mail.gmail.com>
In-Reply-To: <CAFfO_h6V1o3jx4sJ55+Wn7FiXpCcLNrZQtMboR4t6FMQuzg80w@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 21 Aug 2024 19:39:08 +0600
Message-ID: <CAFfO_h4gnhxKZFvcFNC0Uxd-rS+aK9Dyhr31ozB9EASM60E+Ng@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] machine/nitro-enclave: Add built-in Nitro Secure
 Module device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org, agraf@csgraf.de, 
 stefanha@redhat.com, pbonzini@redhat.com, slp@redhat.com, 
 richard.henderson@linaro.org, eduardo@habkost.net, mst@redhat.com, 
 marcel.apfelbaum@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2f;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vs1-xe2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hey Daniel,
The libvirt-ci repository has been updated with the libcbor
dependency. Should I just update my submodule locally to point to the
new master branch and then do a separate commit i.e., "Updated
submodule..." and _then_ do this[1] as part of whatever commit
introduces the libcbor dependency in QEMU?

[1] https://www.qemu.org/docs/master/devel/testing.html#adding-new-build-pre-requisites

Regards,
Dorjoy

