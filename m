Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD787D68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 15:45:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBc1j-0001Wt-Jr; Thu, 14 Nov 2024 10:44:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBc1h-0001WS-Vw
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 10:44:58 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBc1f-0007o0-OZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 10:44:57 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2fb5740a03bso8151161fa.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 07:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731599093; x=1732203893; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GkhNWkpl50ktEuRk+CafywAeOJJnevTAjIQ40ac28BU=;
 b=IPblGl/tuIT8ywLOmhKZCO5QEhGGmYMEG8s1+6Hrve+/gB77GhevEM31YTItTB3b9G
 QAv17RXtICJfZ1nM2d1U+g+ChMCYt9CnsBUbvSuAbHn+67TYElxkoCXEq0aq4jQq88Ab
 x4SMHebuRsDlfGSPXw4Bu/yY2m9rhQ102SnaDi2skDkLRjkMeEKZlRSllP+MBqv4q1Ty
 T9de8u/aSji8Jas2wB5VI5P5s791VoFCaFp6sJg88+Vvm7fHHnY15egUFZtvwEhjHsPB
 yC5PpDwgh6DgK83kCcljZ2R3aqv4A16Vn4yQUR3Ifg8+dh8XbM7ClmQaTA9fBYPuUNIA
 yaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731599093; x=1732203893;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GkhNWkpl50ktEuRk+CafywAeOJJnevTAjIQ40ac28BU=;
 b=t3FqGreKcS+l63bhmi9SJq7FgJzTbYglsZfmG/loB8wV0JI8+aWIGMrnBlUXbei7+O
 iH7UswNFcVp/UerUtAcvWYvmexdws95tZcKSgu/oTiNWOL4q+hu+4UKMNyVcIHVYM2LD
 gdeKCZO7md9zKQUgtnba8olJnAjxrfI4MW3U+ei9xIPCSWyc0i+wGDzKF7oU3raufVp8
 9GuJVUbLbn6zPRU/F5A+T4L2WhMUX4wDf/0egE6NhR3v+ddTpAdTKgsRFiUPL3lyoHtX
 9gJgzLU5RTKYJub90j1KVwRIaxJDfYEMycY7M9L3o/2Gc1P0CVbXtVFotOCzEK4BfLr+
 AvKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY2geQARvwcyhyKc9g5k1/9VcnoAv6sAM20O7pdBKPumyJZ3pJY48Zy/NfriUuAbrdzXXB700dVOT0@nongnu.org
X-Gm-Message-State: AOJu0YwXltIGgDXl2LJGzR6JjEuqrVJxyaXQ/89xq6nH8/9S3dKBev/D
 XM5puIl40rPITyn2LSobzwC6RnKBA9FiBmW+LO5hrJaicOzSSwkdSUJikGknUouc+7SnO2ZTbVl
 CjTBJq5sc+gXwUgvRRidR6/zbAeJ03DBNCpAEDg==
X-Google-Smtp-Source: AGHT+IGWg38u++Iun/youHmT7OXtuhqQzvkqvbeU3yLkWOtsRw903njcHqvRRNFmz/mD0O4qwB83QRZpX2F1leaRUbc=
X-Received: by 2002:a2e:a912:0:b0:2ff:191d:f077 with SMTP id
 38308e7fff4ca-2ff425b142amr64742961fa.0.1731599093108; Thu, 14 Nov 2024
 07:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-19-eric.auger@redhat.com> <ZxuX4i9NjVRizB72@redhat.com>
 <cb6c8f62-c5dc-416d-865f-fbdf96164dac@redhat.com>
 <Zxub7ol4p8P_sWF8@redhat.com>
 <CAFEAcA_wQu17y0PyQwxw0wuf2H5y2VE5aX16nLP2-u7QUP2ggA@mail.gmail.com>
 <Zx-9WxXkmkMuGIlQ@redhat.com>
 <CAFEAcA9w0mb5bcU8p+fScQony-=oqLmNurGWpnL_sBneQCzxUg@mail.gmail.com>
 <Zx_EGxj2aqc_2-kY@redhat.com>
 <63c232c2-a325-48d6-8ed4-753a7c6e3b4e@redhat.com>
 <87ikstn8sc.fsf@redhat.com>
In-Reply-To: <87ikstn8sc.fsf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 15:44:42 +0000
Message-ID: <CAFEAcA_RGWq_ydkKCZGZ8Cn6g3_KSXu_K9bBC2u5g8=uBaJUUg@mail.gmail.com>
Subject: Re: [RFC 18/21] arm/cpu: Introduce a customizable kvm host cpu model
To: Cornelia Huck <cohuck@redhat.com>
Cc: eric.auger@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, richard.henderson@linaro.org, alex.bennee@linaro.org, 
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, 
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com, abologna@redhat.com, 
 jdenemar@redhat.com, shahuang@redhat.com, mark.rutland@arm.com, 
 philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 11 Nov 2024 at 14:29, Cornelia Huck <cohuck@redhat.com> wrote:
> That leaves some headscratchers (at least for me.) E.g. FEAT_UINJ, which
> is optional from v9.5, and mandatory from v9.6, but where I'm unsure how
> we'd discover it, especially as we do not have a way to discover the
> architecture extensions.

I think that's just an accidental omission from the FEAT_UINJ
documentation. There's a UINJ field in ID_AA64PFR2_EL1 which
tells you whether FEAT_UINJ is implemented:

https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/The-Armv9-6-architecture-extension

> I'm also not sure if I understand FEAT_CHK, which is listed as
> optional from v8.0 and mandatory from v9.4, but every aarch64 cpu is
> supposed to be compliant, because CHKFEAT might be a NOP (and this is
> only supposed to check for FEAT_GCS? Yes, I'm confused.)

CHKFEAT is there for cases where software (especially EL0 software)
might need a fast cross-OS-portable way to detect whether a feature
is present and enabled -- for instance if you want the compiler
to emit a function prologue sequence that includes "do XYZ if
GCS is on". CHKFEAT is in the hint area of the encoding space,
so for any CPU that pre-dates FEAT_CHK it will do nothing (which is
how "no features detectable with CHKFEAT are present" is indicated:
if you look at what CHKFEAT actually does it has a definition that
isn't how you'd naturally implement a feature-detect unless you
needed to make NOP mean no-features-present.)

Currently FEAT_GCS is the only feature where it has been deemed
necessary to provide this kind of is-it-enabled detection, but some
future features might also use the CHKFEAT mechanism.

If you're a piece of system software wanting to see if FEAT_GCS
is present you would use ID_AA64PFR1_EL1.GCS. (In particular, if
you're an OS then until you have enabled GCS for yourself via
GCSCR_EL1, CHKFEAT will tell you "not enabled", so you first need
to look at the ID register to see if the GCSCR_EL1 register is
there at all...)

thanks
-- PMM

