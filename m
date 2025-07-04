Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C64EC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiKU-0008Vr-6L; Fri, 04 Jul 2025 11:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXiKT-0008VP-AF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:27:57 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXiKR-0002P8-Un
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:27:57 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e8187601f85so1002808276.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751642874; x=1752247674; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wnKi6BGNPRAYdbfQ5l2XWsHT9CI8r3fC1Nw+qXLLGMk=;
 b=J+vZNAkGVSIbozW/8CqE8GeCbGVhji/bpXd8mebPN33I04SYsxQpOie2AnxGrAJQ83
 8NIivY3+5uusse0cS4qgv3u+p+B+R1co/fIwyCNMsRKdygDZEnwMOJOz0IYIgksdvxzW
 PpPIziUDL0fmH60g/pAHXU0+W107co5UQbzUksdqnSoDTivG3SsHxP+9uEtDkwSfcqb8
 wbNnbCPxkQBeC5I+8xYsdk2qaqKl0poho4ZA6aV0w06u3wXC1vVQ6Em7Il9YEQw2edxS
 r//HJjHAohKZTPSrLVhrnhndGNtgc1GTNIROKX4Xw9v5Quh/nWV3I+B7Plb7qPjbVGz2
 KMRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751642874; x=1752247674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnKi6BGNPRAYdbfQ5l2XWsHT9CI8r3fC1Nw+qXLLGMk=;
 b=Ql3grZ34Nhuf4+MofMa5iaGQmgnraKrAOdeKx1d9z1WLm/iqlsroa1tbMXTFTTbTtT
 pReezcLAQj0LCP44pVusW79fRMB3aw29r6NeUpGXRUxkF7gIai0x0OmMJPksq7nSsJSu
 Nt25O+5uGolEDTXsso3Jz8EguamFBmu2LvO0pJ5iA9XnqEs6NDjelgLYKvW5OQnkVB6T
 rBfKLmddpyHU7k8DiGqSQ3x/NCydsycL7nujCCIsaozHtzkgsAYysu+uFaoSTPIpYsMy
 Cg0CsG1SIfL35syf8YPlnK6uIOivnUGc8C32UuWRigkitd1KsWDlFEdyGA16UHj7j/E+
 gK6g==
X-Gm-Message-State: AOJu0YzgmGjAd7blLOMq4SzYcUtDPi1bAhcDVkQ0fO/cjbA+lPRfGxSS
 4sP9sJiKNbCC9/1CpNnAzJhqbo24UmOn6mIuNoPaqV/WwqgjDV3SucShA8faQNWtceiZrDIqpgd
 9bklXN3zRZqX/5EIr7yChLo1p1BKtXZD5GwXBXWeDCA==
X-Gm-Gg: ASbGnctctvYDy+c+uVd6T6kX6ksiI9veJKTH/PzTAW9yW2pkh7kJUvbLSS0hbIq70Bh
 KVTmZgOyijqcDSSC+mfO6Co7KYGY21D3mZihNcZHmd6PlWQ2qwa36loFUXmMF7nYIdycs/OJhGx
 z5vDW6OiIhGNcoxDip0YxjjosoKDheK9tQG3Usbx7cfccM
X-Google-Smtp-Source: AGHT+IG72keRbW9GC1gcl/ivbPcRf5JeLtyy+/btNxSMM23Uwk7Q5mJHSSRe5htrsYRmwNRJCk6Nxf+X3bs2aaCnQC4=
X-Received: by 2002:a05:690c:b84:b0:70f:6ec6:62b2 with SMTP id
 00721157ae682-71668bc62f9mr36686157b3.8.1751642874118; Fri, 04 Jul 2025
 08:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 16:27:42 +0100
X-Gm-Features: Ac12FXyFl923Fo499NOKD0-hDSWLws1V5S6YQzJw32AWIcX70iqiLyPcMTiKx0w
Message-ID: <CAFEAcA8r7+zOj8t8hHQNorFi_M57ekC_PE0N8-pd-+e22tqVOw@mail.gmail.com>
Subject: Re: [PATCH v4 000/108] target/arm: Implement FEAT_SME2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Fri, 4 Jul 2025 at 15:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v4:
>   - Combined with "target/arm: SME1/SVE2 fixes".
>   - Updated for IDREG changes.
>   - Introduced vectors_overlap() in sme_helper.c,
>     for use with the multi-vector operations.
>   - Various H() macro adjustments per review.
>   - Dropped the premature optimization in PMOV.
>   - Reorg WHILE patches to not break whilegt in the middle.
>   - Replace DecodeCounter.stride with lg2_stride, and thus
>     multiply/divide with shifts.
>
> Patches lacking review:
>   009-target-arm-Fix-bfdotadd_ebf-vs-nan-selection.patch
>   041-target-arm-Implemement-SME2-SDOT-UDOT-USDOT-SUDOT.patch
>   059-target-arm-Implement-SME2-SQCVT-UQCVT-SQCVTU.patch
>   061-target-arm-Implement-SME2-SUNPK-UUNPK.patch
>   064-target-arm-Implement-SME2-SQRSHR-UQRSHR-SQRSHRN.patch
>   070-target-arm-Introduce-pred_count_test.patch
>   072-target-arm-Expand-do_zero-inline.patch (new)
>   074-target-arm-Split-out-do_whileg-from-helper_sve_wh.patch
>   090-target-arm-Implement-PMOV-for-SME2p1-SVE2p1.patch

Reviewed the remainders and queued to target-arm.next, thanks.

-- PMM

