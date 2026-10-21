Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5E606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g/8eEsa0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJeo8-00072N-Sb; Wed, 21 Oct 2026 18:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJeo6-000728-TJ
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:29:15 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJeo5-0000sb-FX
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 18:29:14 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5b8f5e2ce5eso1380932e87.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 15:29:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792621751; cv=none;
 d=google.com; s=arc-20260327;
 b=hRzGjYQC8IbB1B3MHM+vXJd2aL1WFZrgi/HdYn2zoySqbwTwgosp8j0+IpvHrTOvva
 NEDT217SUgcRg+OtpRdeQdHHjrXWEairvOLHf1YlNOqL2JuzK79nVV5kfKsUF24M9h1G
 iAcCgVnQiX1cTeqcxokSMhCOWtKnQpk4sLhA3n1563KDxFO1q8PSm0UNGlkqso7IgX8K
 qd6lmU95aIQbZp46ZLBCZJvH5mTWRzMa9g8/cHcL7A7vHyDaFNIDXpa3JnDdWjrqN21x
 sGk9SS9qd4nNj9n1sGi1Jp+B+fGAV21BR5FHOsBFKZ6DUaqqP3qWznqQCHnOTZwej6Ku
 Vyug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PvQ0OuWV3qPIMZuX26onhau8UmlK2FBR16B67KPe5wU=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=Gf15wGAG3xenkJme9bcsHT7UmrlMT9GtCId+aHpXRBrKaAoRsO2dVakzVk5bN7XHxH
 Pa8vdaHQjirPIPn/Fac6pTOWaynonGTWT8MWdDZlFanZ/HFN9ng5Sr0iNSTsn1KPDvIR
 1PYe5PDYWaDjAMr25HkU4LwFFe/sSDNBIKYuOh2wdWcoeqoWetRnCznrenHCWhNZBn1R
 1f6jMQX25Fwkd3PAQH+hokA/Fg7nOImf4i2Ujy7i596Reo+mWk/MT2nrFvZZI6iGJOn4
 jKgfJtp4dAUYc4Y3lE+qTM6mssWPo5UYebRVe8AAx5zqgcT3PfVLwha/q2WrFuXDnQK2
 /G2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792621751; x=1793226551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PvQ0OuWV3qPIMZuX26onhau8UmlK2FBR16B67KPe5wU=;
 b=g/8eEsa0ZrwOd+QhO2btiORysI/us3IXe4vlexgaBPqv5lsPhLJsDNdwBmTfBFuD7L
 qyCNMOjctwI5YyJYj+GEHxR6qIqRM2pR3/ucNy+v6Yg3ZOniockN2TJRG8asyjPhDi7t
 q6CUyCM4l3HdqsIsnK6ft+JVvZfQ14EP2JoT5Xw8vdpF54CqE30UMjleLklrdvEl/mnQ
 olRE9O4uucFViexcNUOvRmRC+YW8vNsm0lm2FMh62NlPknOWwawdgpZhCB8NxJyZXfpp
 0V8oDbJLBr2gip4LcWSRK8EZLLeAMBmIIVDzZFKMaGm0j/bXpqngkBTXU4K3tV+uqEB1
 y3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792621751; x=1793226551;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PvQ0OuWV3qPIMZuX26onhau8UmlK2FBR16B67KPe5wU=;
 b=c1Dby+jw/j5gTDKGvUIpYwlUBxJemjZl3jv+N1ACGOo1x1fpzOHr5liWyglPIVN2QA
 E0t6rX6upTUhP8N2kSJaLJBbYktx0tdxjT9NlnHJTpdo1qjw8GCDufYkFD3R4QET3KLO
 CGEpbTIJSRNN6dNEz3yOBzkivGdnUOqiMLI9nMQ4GIE5qD1+Mrqy19a8Wm69lyFU6aB5
 iOyKbGqC3N0PsR7zjmtT1PXpgxjLoQIELIJ7xsbG/EB/yyLGdyFvstIf3SLumNULHgXW
 5xLoAWiDxMJZKsdLmo+5gMXCPxdVk4Np6DWsxZbTTwLBzB3kTx39iikziBtzyoK8ywK5
 rQEA==
X-Gm-Message-State: AFq9FYLLlktR4FiE0AGYJ5AWzv+ZhdKXs8iRgUX6OYcnMEcoA2roA176
 leZj7FkiS0QrS2FTfHY1zEQFvb4lnJvoy98ayLil6LEqHx9YKwjU7buXM7KXps4hghb/klIKWWr
 +7W5lO/G4u1NuL0+jsRJ6Nkmo64NuYAo=
X-Gm-Gg: AYBFou3U02JCLMLr6KWrYxAjY33A1qKvW91gmihwLjljhoHvKT0XOeW/C2KfP6jTUsQ
 UvPMCVZz8uyt64wAIrx8aBtwK8BKG96mAtbhc98Gn1mruKS//F5VhKJjM1SlY2WgIMu2YQS3LnV
 CIZVf5fkBh5BvJ6ERvmv843tQaHokB54VXh7Mp0RHX/Dph9Bl3eB/A3xWOuLN5gq5htWACqfRog
 yk9vzL5BB8vN9GLyylKAI3pWjjLBQVNXwgpKvMyloXBwZ7jKESJPHrZ1oZNbzmBC0dag5iEW17D
 JL+98ULPJ20sVgRvbbfQRg9c9yhjYBjTCbkCZXwaEnHjjKP9hfJGxXvc4hiG3N6DIclYxGowauw
 42zo+VcI3AcjtwlKSngIzCErhrm1+JN4VMOG0ruiR8uPT2f6oOLmyzKRkhjCxMq83/CooN4H5Mx
 +MhvGPRySj0mJUIxSUgB4SYlCtAylhD7QsQx8zJ/vVlG830VZ1sALC
X-Received: by 2002:a05:6512:3096:b0:5b8:ef11:387e with SMTP id
 2adb3069b0e04-5bfa1bf9575mr1251024e87.40.1792621750873; Wed, 21 Oct 2026
 15:29:10 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 18:28:57 -0400
X-Gm-Features: AclHuK_i9yJHQlSIR4Op9L_G2DgqYStFFIi_oeIWnDLJ-xTQqIxG5P4ytEPCWuM
Message-ID: <CAEdQ38EJsgNfAn-E7ySw9yVhvu0augiDXphVcnAGfR7gUiMNyQ@mail.gmail.com>
Subject: Re: [PATCH v6 000/100] tcg: Generic expansion of most operations
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 10:16=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This eliminates the majority of the code duplication between
> the _i32 and _i64 expanders.  What remains are those expanders
> that truly differ between the two widths, or that are only
> present for one width.
>
> Changes for v6:
>   - No __attribute__((alias)), since unsupported on MacOS.
>   - Constants canonicalized in tcg_constant_internal, as pointed out in r=
eview.
>   - Other flubs fixed, also per review.

I pointed out a bunch of trivial issues. checkpatch.pl also complains
about a things like

ERROR: storage class should be at the beginning of the declaration
#50: FILE: tcg/tcg-internal.h:63:
+QEMU_RET_ARG_NONNULL static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)

and

ERROR: space required after that ',' (ctx:VxV)
#123: FILE: tcg/tcg-op.c:322:
+    { tcg_gen_##NAME(TYPE, glue(C_,T1)(a), glue(C_,T2)(b), glue(C_,T3)(c))=
; }

Otherwise, this looks good to me. The whole series is.

Reviewed-by: Matt Turner <mattst88@gmail.com>

