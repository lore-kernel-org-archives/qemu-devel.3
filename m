Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cMFEqs5l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdEJ-0006v5-A9; Wed, 21 Oct 2026 16:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdE5-0006uD-1T
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:47:57 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdE2-00077i-N3
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:47:55 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-3ab3dd9681fso11213241fa.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:47:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615673; cv=none;
 d=google.com; s=arc-20260327;
 b=CM6zv/bODi7jVNlpQIohejzIvdhHTwdfHPsUxpGBdjFguvUizophCc1H9A+Ez27NZt
 SlVGEtNjgcFf88ZvNmfxd1MZ03L2DMaFBdaOGZIVsIa0sKk02l7juE/BZOxR7OuWF4D/
 3qtvUpGT8W0SETrxtyV1LNR0xgdg5zJ9PdAvoLeRMbbxOuLpTDrXFLxjjjeuhu+MCCtP
 j4tay5lY69YQE+dyM2zlaLV/scF2Bd/27Ns6lPYB3tSYVbXT5xyYeBA2frZ+TfvUyaO6
 +oivYKyraxQE/BiVMf6LrVzxqKtSB/FKvZnJ11/bGuLNgYnIvAeN659FMm8peMa6uH2t
 yhiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=e6Hj4c8XvcynZbZ4SsaVoF+0F56oqbfDXjkdtT5cm6w=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=S82yr3kD1UF1n/uRSCD1l3H9NOE+eUK2lKssp3MYGsEkHB/7Q1La3qgzKRM1uwEHwi
 AdSSbifp6Ol+1Z1GQ387OMGI4TwWwlG7OGBbG0t64LWHFVIFNW6+iIKxY4OyfeQaKi0i
 AfdORE96DIttqGVtyj4gVqzJgh/KKMNeJIJ+2PQyuaPIBlgj+0KA1/3x5Yxi8K5Fz4G6
 7mLX65yE2CqUyThQ64UJ4+7ARGLssAgBcdyBmOdQvl0B9odcArzTdE5KJiKpcdVqBftV
 hnU2Oj47o2zejEhOUG/wEq/7y/riH02fz+/w1j+zHtXoseveKRQSap5/eGj+OEhdw7oM
 cfIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615673; x=1793220473; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e6Hj4c8XvcynZbZ4SsaVoF+0F56oqbfDXjkdtT5cm6w=;
 b=cMFEqs5lSvZz1E8yqQEfMsdG1WfwREi2IW0ApPwsXvqpq4fFLyeO3MvBAORA7F5Vlz
 lSbmsAapLJNVTw7BDd7CqwKmm9JGwRulwoKiGSWyuVtY4XdB+l/yzgtLBVeB2ZOmtHBn
 +Z76LtJVTEl/fVgtuoiIoP55/+6REL0n+YSuzBwKWMMjCElcthRevJkKgy0qvdPejrdS
 PmTiRxkrWJdueq8GVVylShEYl9qwQE6RlpLpI/ai4OItixHn2dv29wQWHqjTii+H80kJ
 AnHvzLLF9feqLcvVtD02ipV2KQ2jCbQZJMTT2gGQ2/CKH0simkx7Qh2jmT4VzF1N+U9L
 CqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615673; x=1793220473;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=e6Hj4c8XvcynZbZ4SsaVoF+0F56oqbfDXjkdtT5cm6w=;
 b=EU0C7obQIlv/2zwg3CUhZvnrFFTGD8zlGIYyNHNcCPruF/ub6D+qgCd+YkJ9iYjYFL
 fq3RRinz6zk2k671ElvRvW4/mbKJznP18i/GdWq5ICH+8IajrpF9Ur8DfbMs58O/QMWf
 NGMa3UhBQQ5u57/jh5swRsy3i5lzfCI7PUttNmWQ+qCtfAlAlf5qKkRCHF1xMCE9JUUN
 M78T8wzCRDzPFQyMgvCpY2xgGjvHgUomi+/sjph+kSudqBeoN1LFE/EN8DA4Zecj9NDd
 NvS/BLJ89+FwFZdI2kc6gr1z2Y6kcTpBTX8PwYF3IAuW7KthXq0kVpcBdm+p81iVZukE
 UCwg==
X-Gm-Message-State: AFq9FYLs0msafqfFdD4U8oQmke4NkPtrBsMIL/CqzSbpMfHZAmJh5aXE
 S0fotKa3wdfvEoNm6kI2uyzVl2jVsimA1tNxVwAN9FihSuVtu/9ridPJKY+vI8Vo/sF3ptcVKTm
 CeftPnDYgPA+lBbj9ANfk9wHhwl/nOM+j+Y0IOWU=
X-Gm-Gg: AYBFou3GYjIQuITZ/sAF9ui3KSE8P/9VvCqzD1tcKudGQpXd2AKm2b7HYOGXkabs2rU
 Iw3s15EwzPnwK7RAqO/9j3z5rjzRU8luBsQImzvaDxC6aG8fbQBFSjKephToGJD2ybMhEdt5zsy
 /CwDLjdSxeQzNgpBQaYqv3mIlgXTWPTSSphrk6j4AlYxOBSWnhTP/x9UKcOAO/eek7qZZFc9FYZ
 IUB1eAsVc6+1F6rxQHHPimq/vysPPIEBdmDC+SOZ9DDA7pNPV8RYoK5TJEdKv8jhW2xZb+WHhYn
 9yraAiROZc0jrRYcpmVp3Mlvw4MqtjyXmiBcU84IOGVuyeVL6EWC9JVVkpjIWIvyKuO4rbvakiw
 ixWLe17h+hFVjWTeEFViHz23VK/PiU5y+vKJy4+JzcUd87Y8lRvMBB5so+EMytcjbFUkaML+r0p
 xssDwrYGBwkx58va1VYGvmBqvSTlctn6y8gFYqrElMXThTrMpCJrVV3Ts7yGXHxbx6oiPRioVrD
 Q==
X-Received: by 2002:a2e:be05:0:b0:3ab:2d6a:1a1c with SMTP id
 38308e7fff4ca-3ac441d7d93mr8708231fa.12.1792615672770; Wed, 21 Oct 2026
 13:47:52 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-99-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-99-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 16:47:40 -0400
X-Gm-Features: AclHuK8CGMa3SNmDuQflXSdsO98cH8zIEkjrtvmC9lfugqNisLmercxvV6fOFBM
Message-ID: <CAEdQ38EuXhL21CipUwwx1TW2H8GBqrQLhY9GPC8hPP9ZV4TsEw@mail.gmail.com>
Subject: Re: [PATCH v6 098/100] tcg: Generic expansion of
 tcg_gen_{non}atomic_qemu_cmpxchg_chk
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Subject says qemu_cmpxchg_chk but the functions are cmpxchg_chk.

