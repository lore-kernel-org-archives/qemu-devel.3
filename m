Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A558F9D0CD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 14:11:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCeTU-0007Fz-2Y; Tue, 14 Apr 2026 10:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wCeTS-0007Fh-U7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:10:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matyas.bobek@gmail.com>)
 id 1wCeTR-0004gm-Di
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 10:10:42 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43cf5ad500fso4802944f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776175839; x=1776780639; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ojH+0GhZzsy9lL/3YqQAdJcb0iyQTrLQZ1w109BwJWU=;
 b=PYlhBogbjDT1hMwlPA3BjuL92SF7xZ+BXnQmuOmSUJ1SkPANS1KWzg0JOfL11VnmXF
 TmXyHJ+MhVFIaeJHPsGg0XiZ51R4zwadBYgB2P7qyyPaqEDOcNuMhnJJeuYSf+Curzfe
 CKX1/g0BxMByZfTpk2+VlJ4CD43A4tu+RjVXmcnlcgxFAOEdifQgTEbMrtxslM8S1S2A
 ZQJ2APXO1fodVUSmHifeIoFnfbewpKVZuwCAthuZw8q7oAzhqEkDPh3zJJQ5w/gcUj45
 X9vu1ViYwKzbb4jhcOVTCg7m76sN5bVOTq/UwZxwVxwhqfZWAfGY967NLAcz5ZOVTa1m
 +Plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776175839; x=1776780639;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ojH+0GhZzsy9lL/3YqQAdJcb0iyQTrLQZ1w109BwJWU=;
 b=TeLIRvmmoLNvqRw5CAtPwgHMGKSnLZFtztfE3Virj9gJvzudLci5y73tEvxqMLetkP
 3l9ZFqacXsoIpvc425YSBcKYZxeyvcXrxhSbTbs3wrr5NohINyiLCh2A3qPm8IgXgopV
 zVuk2wDg5pDX72m/fpadKc6n2TDBW4RltV1v337p49A7blaVfnYAtJjYuzpF1gPWcmpm
 CGllnhy3r8tTjrev/OljLSpNhhKV3yvXzp8RQB/YRBTWtkcv2NbGvCVrL2RNJ6Pq4ksh
 7rZF5sdKSlQRHw5cg0U5Xk/cUtMIj7c3882jy+46gTCz489DbfdvvBJDkPq5+o/gQcNy
 pAzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pslz0cw3q0IqwBb6xXhMv6OkxyFd5ZJYrBOjtWDCcBjcYnhGclUSPP/N22S9l4r0nBZAKWTj3oiUa@nongnu.org
X-Gm-Message-State: AOJu0YzyOtt+hGOw4ZMYqIVO7JhybOd1KIr4dPkG6VmQrPM6VIO3YrQV
 P3WdUVZUEpOvwjueevMMFNx3gJSwM9CcnmrXtGEojZ5N18zsCbQULwiK
X-Gm-Gg: AeBDievQIHP7BqxWvj/xwq8nUPcd8wrk6OXR/Ude/pM+FeCECnL5zFJPwXLghMRkHel
 wKonffhy5zVhBb8J2Zz46k2phiZvaW9jj+cQWjteK06TtHpul13JA/7Lo9SQC9exfnLyqDxnmzq
 98e24dXyWRF53Y7xUVPbfGcutcb62apEBe295UR0wkBHk+8dyTDIsjgpJKA6sogT+LeUmy4GJWu
 HQmoShR8SY5j7lwFGnaA9j7V+LgaDNJfuGjhIfcwhCEepQxEqTYi5/ZdUMo4ZOdHBneaKqpybu/
 PSkrk7BVct49OzyJG9J7vga+lbASy3V1lMsp8rrGpw/o2LmQ3DaV+n6BzuJeiHuRGs/Txp+sP9d
 is5Q7B8osJjPZ55USRYnsd3zzZCJxZvKwfHq33qAAJJomVZBqXS9NmkICPXW0MthuFx/wuuGFbs
 BdAn3UGrgb72UuneIJze7KGSMBVMmeC8EF4lHNvf5OViZuHdQEZyPgCV/uTEI=
X-Received: by 2002:a05:6000:26cc:b0:43d:20e9:b0e1 with SMTP id
 ffacd0b85a97d-43d6427b788mr26936118f8f.7.1776175839192; 
 Tue, 14 Apr 2026 07:10:39 -0700 (PDT)
Received: from [172.21.2.2] (nat-wifi-b.pod.cvut.cz. [147.32.88.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d7c135fd6sm22829437f8f.28.2026.04.14.07.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 07:10:38 -0700 (PDT)
Message-ID: <2cca9ec5db79c0cc58b37607234ba19215cdeb1c.camel@gmail.com>
Subject: Re: [PATCH] scripts/checkpatch: Reject another license boilerplate
 pattern
From: =?UTF-8?Q?Maty=C3=A1=C5=A1?= Bobek <matyas.bobek@gmail.com>
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Tue, 14 Apr 2026 16:10:37 +0200
In-Reply-To: <20260414135018.13585-1-shentey@gmail.com>
References: <20260414135018.13585-1-shentey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=matyas.bobek@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 2026-04-14 at 15:50 +0200, Bernhard Beschow wrote:
> The pattern us used 56 times in QEMU.
>=20
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
> =C2=A0scripts/checkpatch.pl | 1 +
> =C2=A01 file changed, 1 insertion(+)

Tested-by: Matyas Bobek <matyas.bobek@gmail.com>

Thanks, Matt

