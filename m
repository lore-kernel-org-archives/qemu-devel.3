Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DB8C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu67v-0003Xj-Kj; Wed, 12 Aug 2026 06:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu67p-0003XP-KT
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:23:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wu67o-0001se-69
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 06:23:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495590dde14so9395705e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786530234; x=1787135034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=a32BofuPkjCcUJakrtJX3LjdPynwS/DMnY3BE6yCNDg=;
 b=MGNBFcnga6JrgYL5gglt6KArOIzbP+dBXdsXCWssZIPXDOroA3vFX2/XQ1edeORoZX
 c9BPoHRi0TepSj2Hm1U1NxzXizZ8lv+wyh4U5m8iS6Y4uzD7phcwgdZI5ABVObrprX5s
 9xCIuzwJLjG83VH4FcyG7Ox7D3Pp1/JDeHsZFhyH+nFu3a2iGVc1iAj9vL2lYSlMg9z5
 GWF7eSsGIep7mGkAOIr2w2AqV2ZebQExZXCLrOAl085iRUsah5myacnB12RMpVvyDQV+
 m4IzjXwtujAxfgFLkDapW4c6CnfIzSaAAc8a8O+K4/X0AAe90YkZlXJl8iPd4Yq8SPMR
 Ml9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786530234; x=1787135034;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a32BofuPkjCcUJakrtJX3LjdPynwS/DMnY3BE6yCNDg=;
 b=iYg1LKEf1ZmZZAr+hAVoXGt16foF6q7WKSAAsZ50o83qa1XGa5koaZ8Xnt9cBkU3Lf
 y03iiH4kUwubYPknGaIacA3uM5N7k07porBkrIYlAY5+nBJW6QSAff2q3f65VVjJNmSw
 DkAXxA9e9729T12pap8N8rJRh/RZJv3UihcnEsW34/PIrsCRk1/YGrvTfx20PClw0l/e
 asbHv8e5/Wx1jUoHYQyx/Z02sj8paNiVuXSTmnVXqiULuQ/ewKCn+5BuPb9pZtBb1Wzt
 AWeXTnXipF7//J8wyjHgzx6d4PHE3d6Q8kFQgRpc05/M5ATM9R84VQ5Ts1bHG3CMH0cT
 +Q7A==
X-Gm-Message-State: AOJu0YyKQBTj2d/bkp+eqXSNjbGJclF+lgKfTTtwd6lz9+x2r2ti0pRY
 O/Fx/DWp3V89zilh6OcRUCrTEuUbn6vjcCXQFU/nsnWymBnt6pJn8le8Hm1z/e7IQ+8=
X-Gm-Gg: AR+sD10NSG4zbbfdoFXCf6ZYCWoYs7Kwh7sCT6iWZzmFu3m25QkhesAn5QmK+gK4p0o
 ZYK5Kb2dFE6rRwSClvD8zlGfqr38QqsTqKUw77W/X8CAkT0HNuDqKX5rQR90stIZZRnX1k6UZ6L
 hy97/Wtuv4OEQeaInwgYDsEv61h3DuTEB9BcRebdI6Qlq8YLBnmVUArwls2lTN3g+eosj/gRW53
 6hiFdGsfjbnCie87vVqTJ1Gg6Ek5LOf8kB7k/utiEutBIExHZCt/E0hB3gPB0rh5uEIrqRD3eeo
 8Yb8Vd2QGNFR1ZNsmxs96KlojeSRjDKFoTA6U3Xhg/7Wh8yn/2rGdsx/tcw6nbHvXB0rGW9aNRO
 rFWw33NU3y6mXjGMALThwlPrFxIxA7ZB5u1hmh5nLKUPQp8yK1Gz0EZCz08nEgc0+c5pQnIvoRY
 OcyX29wlyVkcFzsjDyx+ICfgRqeziwVpSjs4++5t1q7ovLRtdpaGxx+0PlAE2o
X-Received: by 2002:a05:600c:500d:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-4997c0f76c5mr49854255e9.1.1786530233767; 
 Wed, 12 Aug 2026 03:23:53 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997c9942aesm34082995e9.13.2026.08.12.03.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 03:23:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF5BE5F886;
 Wed, 12 Aug 2026 11:23:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Ilya
 Leoshkevich <iii@linux.ibm.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Helge Deller <deller@gmx.de>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH v6 098/103] configure: directly pass gdb path as a meson
 option
In-Reply-To: <20260728044248.137626-99-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 27 Jul 2026 21:42:42 -0700")
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-99-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre5; emacs 30.1
Date: Wed, 12 Aug 2026 11:23:51 +0100
Message-ID: <87cxvn1vt4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Move the remaining bit of the detection logic to meson. We can assume
> gdb can be probed since gdb-9 has been published more than 6 years ago.
> If ./configure --gdb is set, make sure the given program exists by using
> find_program(..., required: true).
>
> Also, using a proper meson option lists this at end of meson summary.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

