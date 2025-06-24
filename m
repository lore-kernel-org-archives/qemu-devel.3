Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F45BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4XN-0005H1-DB; Tue, 24 Jun 2025 10:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4XI-0005G8-4J
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:22:10 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU4XB-000425-0G
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:22:07 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-70e5e6ab7b8so5587017b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750774918; x=1751379718; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N6ERwjSwc4Lvfs6V+g6dO5+AgbvIJfeKB0vOKAA/zDQ=;
 b=bu55ROvUtlQBgmHspVE6WShRjb/Mmr/aeEGYCPVHNDRd1EWl4F3E5jn/4obxo8FcBI
 oNiyzPr0B3wBIkuKqFDxdPjT87fpKfoc5+oyYhhYlUxu7FWd+7DLeoa0g8fB7KZEBXzp
 +hxLJbqjBor4LvwfuOBvpa+QsrPOKgG9s5z2SRaVdU8sMeQgIMQmIYCvlHfMpXNEMBar
 1JAkZmOl+3qabCKpZCwyDl+aCiKD7tskuvN5kRm8Tsa1c+OzenRSjkEo8nl7e4tmq6CS
 qzi30Y1m58/G22LCNcMIAfLBCIs3qfmp5iGITqzYhLAv+a5Nvj57G7AV5LD3GZwRemy2
 YOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750774918; x=1751379718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6ERwjSwc4Lvfs6V+g6dO5+AgbvIJfeKB0vOKAA/zDQ=;
 b=axQvvks9stXFGnYyGq9tZFr0tKRvu0xHq2RJpKT9JtAPfKJSXIqtsMw7Ipnr/5nqBi
 docKl8k5PS3OYkoZKGOZTph9W1Z/hoFycYNkl2mveGk0tuV78wWnYPLRdmRAitwuAgTV
 9WuewJY/cxA+XoTk+Zeko0vjz88bjn+5AH0tRxEeBaLyfo30ncXJvQWiRQFTfY9xSnop
 4+IWA2XiypASSgcDegCbxNHFC2sFFPJ5aTIrj79dNmqpB20AKmK58hSjSX2K5HI8MTbZ
 SNlVc9gSuYQemfELR5QuaPrCb9Bc9Q40ewJJpONfI8bch+hoTPMJo7AKQv/5dr/YHLn9
 ppxQ==
X-Gm-Message-State: AOJu0Yx89nwn1GNBBothSAEuLmgSKplQQORq0oF7GBTZBuTcJiogImdy
 4hstHZr/fn5qMqSpIDMejtkZHda0QctBAcjyK2RNi6hdZ43XhrYw4PKktrvK9tfMz8Vb4lsyad/
 bUo7QG7b4kiLg7LU6+QJkg9S6o/0ZyXguhqMjajJFWg==
X-Gm-Gg: ASbGncsuBttQiR1eaEMVXOTqt8WutXqPmIvscuV/RgVN1H0OARLCv7LQS62zaFweZHP
 h1OLdP81uY/EU7AMQ8/GdBJxa9riRbjnguRG/dfyEufXsSyvZ4gnia1PavUc30H4Nt48pMObp69
 OeQ5Bey06KA3p7ljEdY0cyH/kyEd8qdLDVpmBcTSs7ac34
X-Google-Smtp-Source: AGHT+IHj+LGGja7CFE2e8BwG66OX8RLc1si+Dg1i5bnw2qfRzHYK3ZT/6S+MV//Qh24F30Pto5EFq1z+jaTYt7A+R50=
X-Received: by 2002:a05:690c:fca:b0:70e:21be:a6c5 with SMTP id
 00721157ae682-71404771bd2mr390397b3.26.1750774918219; Tue, 24 Jun 2025
 07:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-92-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-92-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 15:21:47 +0100
X-Gm-Features: AX0GCFtmaRr2XHILKDl-DBL2eACHEXZzVeIUWLYW7_3eUr29KrE-n02N35C2F7I
Message-ID: <CAFEAcA95y+y_uXM0mhRY3VqHtV8Uagd38pBDmvrWO6WrBgf0ag@mail.gmail.com>
Subject: Re: [PATCH v2 091/101] target/arm: Implement SME2 counted predicate
 register load/store
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112b.google.com
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

On Sun, 22 Jun 2025 at 01:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Implement the SVE2p1 consecutive register LD1/ST1,
> and the SME2 strided register LD1/ST1.
>



> +static bool gen_ldst_zcrr_c(DisasContext *s, arg_zcrr_ldst *a,
> +                            bool is_write, bool strided)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +
> +    tcg_gen_shli_i64(addr, cpu_reg(s, a->rm), a->esz);
> +    tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, a->rn));
> +    return gen_ldst_c(s, addr, a->rd, a->png, a->esz, is_write,
> +                      a->nreg, strided);
> +}
> +
> +static bool gen_ldst_zcri_c(DisasContext *s, arg_zcri_ldst *a,
> +                            bool is_write, bool strided)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +
> +    tcg_gen_addi_i64(addr, cpu_reg_sp(s, a->rn),
> +                     a->imm * vec_full_reg_size(s));
> +    return gen_ldst_c(s, addr, a->rd, a->png, a->esz, is_write,
> +                      a->nreg, strided);
> +}
> +
> +TRANS_FEAT(LD1_zcrr, aa64_sme2_or_sve2p1, gen_ldst_zcrr_c, a, false, false)
> +TRANS_FEAT(LD1_zcri, aa64_sme2_or_sve2p1, gen_ldst_zcri_c, a, false, false)
> +TRANS_FEAT(ST1_zcrr, aa64_sme2_or_sve2p1, gen_ldst_zcrr_c, a, true, false)
> +TRANS_FEAT(ST1_zcri, aa64_sme2_or_sve2p1, gen_ldst_zcri_c, a, true, false)
> +
> +TRANS_FEAT(LD1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, false, true)
> +TRANS_FEAT(LD1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, false, true)
> +TRANS_FEAT(ST1_zcrr_stride, aa64_sme2, gen_ldst_zcrr_c, a, true, true)
> +TRANS_FEAT(ST1_zcri_stride, aa64_sme2, gen_ldst_zcri_c, a, true, true)

These seem to be missing the

  if IsFeatureImplemented(FEAT_SVE2p1) then CheckSVEEnabled(); else
CheckStreamingSVEEnabled();

SVE-enabled checks that the pseudocode has?

thanks
-- PMM

