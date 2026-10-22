Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C960A2600
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QyRHA9UM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJouP-0001s7-FM; Thu, 22 Oct 2026 05:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJouN-0001rh-OE
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:16:23 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJouM-00082b-3z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 05:16:23 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-8ad98c3fb15so13949247b3.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 02:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792660580; cv=none;
 d=google.com; s=arc-20260327;
 b=DRwWczSujP/0azsLhzx/C0jN2N9gUh547sYoJEQAGQvaAx4TCo6faPfcQ4oxCyQNv3
 ivGyzk/vBGL8JIANdz2URwxR63V1Hlh5VMlCb2e4l247H1xpzcKj59gBkaKHcGW3V82B
 KvNlrABYhGY1O4YdLDB7f8WZFces3kPf/fNzardd82xrLMLMTZVYatwrTV4U188QJGMT
 5y0KqdvKUXtuSWNJfsvl5ENEpGnj0pXLYuTtIEisk9MKUI5ci2nlUSOEvIMfLsaEHUuI
 1ruk0g2JOQGbolhVVVZKrXIJ9xl+XjTzJEXlz+55DTHQtMPTv2KIgMa2STuEYPal6kN1
 eUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mkbYpg0DfpCAM2m6RewudVlfpB4h7QkVLCJ6/xXWLQ4=;
 fh=Jk14+0MXrH6xd5IYbIRbQllLVQdNwTceNoVxiK2vNr4=;
 b=mo+etMQ0+pjUV5bDrIcCUyUz5WWPTtJH0Uqxapp6sWLV18yob4DOT2PZOq1uR3T23/
 uXQ2gqvF6lD2BlrEENxpooUhctnXvyBPSvRKUREmGMmbkKstIa2gaLf+UShS44+C8tIs
 27jPrw7AClGPAG6icB0cHAXT4semd5H2Emly3JoQfCYR4u76gmgaUMo2wVUX+4mgR0NU
 Q5x1yG9zo+60Bqh9PKZtPEUhheLqDLPmN2iUmRtpebrDTeqQm7i0Nv2IMiHDSTPiajhP
 znEp2JjbBAuH5S+9SAzkyz2fyB+oSQvzAIUx0wYZlduYcFlx5i9/fdgeSqpfbLLijn6P
 efCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792660580; x=1793265380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mkbYpg0DfpCAM2m6RewudVlfpB4h7QkVLCJ6/xXWLQ4=;
 b=QyRHA9UMgc2KtZrJP5AnUmmmOkd7QvoKCz2D24gHprhWgZNGeb9Ro6rPVK1d+iZkXf
 jYIJfx8mUmvWdNBAgfUkZ9XxsuIyUNGcEYldzEnPrg52nBRUR4paiNMYKfN+LUUYzi0W
 78YjKll0XCTFRlkXESvV0okAVpQf2EyvDSUFeKkoxWPevyQ7VZ/169M+e5CM0EI2em3b
 lMeMEDmdV0i+ybrwHSVmVtyWOiEh/Cum/xgsrD9CSfpRzy/C1G31lHuGhhmNpfVXVHsJ
 UCgUHmmBVtV4UshnlCiNkIGaibDYMP2pM5HdJoaJlHtIPg9XvZ4eJmGZ0he1y2kYl7wt
 LKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792660580; x=1793265380;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mkbYpg0DfpCAM2m6RewudVlfpB4h7QkVLCJ6/xXWLQ4=;
 b=brCC4MA6gXNJ76Lto/XfXcn39d40EufxTRLpRxHzO/B175c+L97jb9Tgjep3phqbLQ
 g0qdHUvv7YOpaP6hT6YHk9XyUldwh7f8Mo9FyJkWqvXcmp7jlCIsvd0jh4OKRvcmP5o6
 IWV2j/zacYbY7TjcKZSlcTEN345bEECnB5ViOESlb61jEragVtbvmBb2u0yd/ODc0MD9
 8uuRdOWYjEe4v5mFJTAO4N7fAQLT0KSxRh0T9ZRwH6Qn+JMZJ3NViPe/fwWG340aWb+y
 d7ZasPWr75oQj106B0zZmVzoSJtjUGCabWzNHE8VW4q6i4a/nol+isf2kRZmQKHaBzRc
 MVVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIRVRR9D4pPx/DdVTOGoK0TLp4mhhYfINea2YQtoVBqjKCrtQ7j1adNcMrfwsZUCRy0tdpuzUu/feg@nongnu.org
X-Gm-Message-State: AFq9FYLAIW9s8wJOl0dXz8Bsw0aMt94OQ4OMHuDQ5EhLkNOUMslH7WR9
 iXNNusypy0NlqjJXhG46kszzTe6kC/3lMoXUMbzlIPJbRpOzmdOVZAh41VXbUYSTGxL3cWln/9J
 HDgNncS4w9Vc4iMUDyBfpKsHOOAcT38avo4A80jkmAg==
X-Gm-Gg: AYBFou2tVR4Ame4PgWT5cBWvQqeSuKDr2WzBalvo++Y+dnG/kqjvA5WjcC1cov0M8al
 TX97nFyXt9vMt1pA+aBfZVuvX8ftCajFZCMpDLK/I/CCtRjHe6IXqhSFhipourCAQMxvjiiXDy2
 n0WLDurYNhvoqB2ABmBbK0OoVRMWXbdgHrZ0HWZmht8NAEN7j07oGTSGn/qdh76IGDA8koEdGk3
 w1h7tfX2Jcgthzp6lIyLn3XELfa80juoG+ONEdGtQP4hdGkE4uOJhKNuJBa7G/kjsspCwaO+BEa
 5g/nTxW59Tufo1uFiU0+VAQsXy5OX6gw4yNQYiyJuJflKqMuw8lz9pfbshp9pw47ULBdNin5LRe
 lz/+3IfKk3iQ9uU0GQMVoxrXtC03ef8UdbkTbqHwfswKlkTo5zSKdJFTp9MDHELQY96d+nNYmiU
 KvaR3zpG7dJxcHbk8KRdul
X-Received: by 2002:a05:690c:4990:b0:8b0:97f5:a854 with SMTP id
 00721157ae682-8b133d5dcbdmr29819977b3.33.1792660580573; Thu, 22 Oct 2026
 02:16:20 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022075219.312757-1-frederic.petrot@univ-grenoble-alpes.fr>
 <20261022075219.312757-2-frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <20261022075219.312757-2-frederic.petrot@univ-grenoble-alpes.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2026 10:16:09 +0100
X-Gm-Features: AclHuK_cBSGxKCrC9HQCH78B6uxeCiAolhZDOV5oNPU6IeIS-f2uVL5YsL30SvM
Message-ID: <CAFEAcA-rw1_a5q7jB_Rx3KoH2_aPE48odM_99kx+Tz_J_LYw_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: fix pmp sanitize error for x-rv128
To: frederic.petrot@univ-grenoble-alpes.fr
Cc: daniel.barboza@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 08:52, <frederic.petrot@univ-grenoble-alpes.fr> wrot=
e:
>
> From: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-grenoble-alpes=
.fr>
>
> UndefinedBehaviorSanitizer reports an undefined behavior due to shifts
> larger than type in the handling of the pmp configuration registers for t=
he
> x-rv128 cpu.
> Adding an "i128" version for the functions accessing the pmpcfg registers
> to properly handle the 128-bit case.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fr=C3=A9d=C3=A9ric P=C3=A9trot <frederic.petrot@univ-greno=
ble-alpes.fr>

> +Int128 pmpcfg_csr_read_i128(CPURISCVState *env, uint32_t reg_index)
> +{
> +    int i;
> +    Int128 cfg_val =3D 0;

I think you need "=3D int128_zero();" here, to avoid a compile
failure when Int128 is the struct type rather than the compiler's
native int128 type.

thanks
-- PMM

