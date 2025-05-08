Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 708FCC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0Os-0001wQ-Sk; Thu, 08 May 2025 08:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD0Oi-0001m4-2I
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:30:45 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uD0Od-0003NJ-NO
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:30:41 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e78e3200bb2so951697276.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746707437; x=1747312237; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D6r6BB7JBGH4WNavhR65hfhL6xnyqBdJlsUdZs0LRq8=;
 b=LalNoA8rsfFhX8TWR8YOWQC+jqvShSZ45TBSxFUAe/shLsz+2eDUMTRj4IVSIHYgut
 c35CUII7vv2isVmaQ3ylVqt/W9b/ZRrLP9s5qpGKzUkJWLnk8/AK3Zb/tQvvBDSNQ+Zt
 S8AFDmLf8IjaIGlQGSIXIWAfIJGEvYs7NvoEFvRmm2mPBccjCFYtqioRefJdQYOND8E8
 jAjHzyivsCyejd3g4KYIkiJn/yA4I20kqyIs3PLW2l7VGUsKMJSZIQcGl0arcwwqF/Wz
 8FXPHWhTpq5w6DQSwD/naWE258JaZe+0cdCq/J1g0W8itZ1EBLWYijHVLvoDDrm3JeHY
 JRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746707437; x=1747312237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6r6BB7JBGH4WNavhR65hfhL6xnyqBdJlsUdZs0LRq8=;
 b=I2nLzcz1EEjK5kVlmT7khBRrRNLz1yBHugu6UK9xW8s1SVjLFeQGS+ZHvgHWK7L5Ls
 RLx0IjtJ5K556ZhH5RvdGJG8JzHcFZx9qZE0wItRiDbOXeG7GT3MmYa3QE0QlwgAmhWc
 l3zy61tZ1k7dg1FAjlP2YAR73rLXly8DsKogcgWdctekV0LzcMPOomsU/OWhCVo5jpzI
 91Fg1IZJupfQVSknpSmOF6mLmqC9xXzvoIBiLzwbzpEBrfs0iqnW0sLo/qCvQotA8F5B
 wrENoRq3B5lUHqimUMK1SYBjqYMkE6rfk6oMshc+c24it/RWMaDBXHv+0BZVh/wkif5z
 T6JA==
X-Gm-Message-State: AOJu0Yzcg+enZZfqGCRENUO4Hgfnmn7M4i/J2+jpYwqOXDEX3iUSAH0c
 6GjTJEXpdMg+LLD43doLXl2ztc5Z3qWJP4lyb3JwLsgB+pWGMzmC43e4kRRh4Y3Anf6ukAR4bNC
 6isXoFI0b3CxRhxobCKzgtgmNIg4e9XhCCGZ4uA==
X-Gm-Gg: ASbGnctlYqXxLWZda3rGcyHh7oJwEeUAmYbEOm2Jzs6C2Bbk/3K800RC/U9I/9BtFPY
 Y6k5dYnpv5B88KZLp2BT4xR47PbJb0gPxzUlN00dMiWmKUz14MC8H3mR9oDWP22DzfI3RM1l7i+
 VwrRVxL9l2Ksff7Ef7pUPQOkw=
X-Google-Smtp-Source: AGHT+IEAMYo4LEp+04zKMY+LGOXTWGY/WUsCAdod+T1ufkbACKHZPBWD5fkCeI+EC8fSsP9Hu19t/wFSHw2d8U9Q0go=
X-Received: by 2002:a05:6902:1812:b0:e78:f173:5ed9 with SMTP id
 3f1490d57ef6-e78f17369e2mr2039888276.25.1746707437485; Thu, 08 May 2025
 05:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <8c8f9a7e77e25a87b54335f7c376cb079fe67655.1746706766.git.mst@redhat.com>
In-Reply-To: <8c8f9a7e77e25a87b54335f7c376cb079fe67655.1746706766.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 May 2025 13:30:25 +0100
X-Gm-Features: ATxdqUH5NTh6ANbx1v1VUsNt1op3jk2_40vNBjWIii3ayQg3ahaD8o66Pej75ok
Message-ID: <CAFEAcA-ideWjVhKjK6xTcSFoKPY3C_9BJ0jp-UE-7qCkGGt8FQ@mail.gmail.com>
Subject: Re: [PATCH RFC] meson: require int128 type
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Thu, 8 May 2025 at 13:21, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> compilers that QEMU requires support int128
> (though arithmetic might be more challenging).
> As virtio wants to use int128 with bitwise opts only,
> make it simple by failing configure if not there.

IIRC the problem is not the compiler version but whether
or not it's targeting a 32-bit host: compilers will
implement an int128 based on 2 64-bit registers, but
not one based on 4 32-bit registers. Did you check this
on all our supported host platforms ?

(We've deprecated 32-bit host support, but not dropped
it yet, I think.)

thanks
-- PMM

