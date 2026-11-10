Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77511606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IdEv8zqG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQo87-0002qi-5o; Tue, 10 Nov 2026 10:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo86-0002qN-4G
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:51:26 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQo84-0007E9-Mu
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 10:51:25 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b300713befso18350647b3.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 07:51:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794325883; cv=none;
 d=google.com; s=arc-20260327;
 b=MdhJwtAtFuf1f9AlGlmrCLzNvdcePe+KeZN2FEsAK6PsqOv7LF8EjfQuGuXEt0NGRR
 0o9BBsyQH9QQP0IRKE5jk+xgW8s6fjOcH437NM+Xgrd3eyF+Xa4moYJZFwLNrujdmkhM
 yWqvgn2Ml7acXGC0qbcMcwc3OHVf5XAR/AhsG28x8zDchlSh8dMTo8HVZvnlgs1ln3nn
 lCTw00f1ISXR3SE7lFtcoYSSsgc/fgD2xFkrLz6OjkE34c/3zuSncAUPJID/nHZt3fUJ
 UnjMhrdLNUzQAAVeRI0xdvzygrL2SmECrphyJU9WBROVrZmUmqI7nWzF5mFvbSK/x66l
 ZEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=t3QS2QBBfRe/21EvaTw4KynHcucGx8rR8a9dawl+hOU=;
 fh=kcMqnS/hJUwNpfuCppCDf3FNNhF2MmmzGCBFK0eEBhU=;
 b=POmtdzpGLP5DmgoDIu/76W142P7fH+hrJqLMCF69ukxQoN4T1VD8Uv22CjuPXelPbl
 V9FjOCmfY8VUAZUFD17Fzh8cTPaNxqeH4MHu/omO+oNPkSqBmjQPbuWKicsdXSvCcT9B
 tKrk/as0NjebEVLym25wRVbikcYn9l7VHptntKougLOBqv7dEEbOwVmRGsbDjeh+XGqG
 xs///zYl5zkxWLaFd9IcXOlEcpZGoeJv/TFCPHf5mTVvV7wGZZjXzJmyYYS5d9tluYOh
 IfmOX4+cY9Dz99puCMrXgPEMN+ZN7VEm/s9VDfkcNdr65mi3Pgmb5EN0uSM4Gf55VO+m
 dbMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794325883; x=1794930683; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=t3QS2QBBfRe/21EvaTw4KynHcucGx8rR8a9dawl+hOU=;
 b=IdEv8zqGPXMT9po78qv7T+yvChghdJn3dv9naR0BkG8v+CFfCbNLO0AVViL1EbP6ag
 edHWM7RZeu9QRw4aNbB+vMtivNGclTU8pVWyFQC+zcDjBhnEUl05llgzYC/vgvxZLqGI
 dtuLIGK46bGOxiGNfItvp25Q6xEuxsmwJHCR9E6bU6gnBGxe2bX1//j8lTJ5zkMTTQoe
 b37CqjwhdoW6WyH7DRb+LuwM/dbDMZrP1LS24ObTWPs+143jAGuSIvvZ6OS54glTfyTE
 yAsaETct/yqNSlOc3U4MCTmQnTL5nwwaDk17Oh5Wv6s9oNyn2grB+DBpKizQBd3ydGDh
 F6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794325883; x=1794930683;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t3QS2QBBfRe/21EvaTw4KynHcucGx8rR8a9dawl+hOU=;
 b=HfpKPVsZQQMoWT3q9SLWrbvPqjBfJkWoMkI8Hj0nIam4Z8J88X3f9TJrQqGRxDl9ca
 kRyfuqVD0o2GYBWBpUDKHy1/4i2R4WZw6uFObROKEavzwG15nLHUXPULmefOYK9AmF3x
 mzetSMLfY67BmUCujr1zSsR/q0nEXunOr37ImaolQodIBKS99YmzNlGqsxaITZ0ZpZgD
 yNnNDH24iket5hi9yNmgscatIKXFrfqD1p0ok+9fIL7bSickzH15WYPKWOI9JhRx+YDD
 ILaem2wOlFvMWVBNdb8NQGOeMnCRsWslbrefwHEkq61KoXMgZm6/yszimGPwb5tXEqU7
 hzRg==
X-Gm-Message-State: APuU4Z/fVIileJ/xjG3qZPI+AEFDdj5bBJ94zbzRdJLoUvongAwmXpcK
 npCKTcuJUzcnhyznFnT55Xldbc4R2qKj3xvg+1IJh58DNG8mjwZzgFqgAVU92g4axd6MVNuTZwJ
 8lE+UfCOSL5bdbxLVXCFdvN0rPHESdHegcj9ng21MnA==
X-Gm-Gg: AYBFou0XvjVOfv8P14L7xq0ILOUBG16VqaPrix0ZnKBKEMsuDHhoGazfl89Qn8n2bdx
 kTVkj8y9zU4SFL0PjYsv+ikKC6dIqInDbS2wqQCeym1cCmhhQQ7L70RG8pe7pnhzJaThifBDaaf
 P6iniMVgG1CbNB1yePZXAMFFxtB4opRtwJ/H7N5zUHXqUTzQBaI5Px2wkV/zIKNjGyiOrRYpdbk
 APUUOjzogXGO2QrX3kUdLA5PKYVo6MYYNwCN4eu79FfvlcDP/bZ7WrWDK00DX8tFqKbNoDw/uwC
 jC7Vp8Eos8LHEw1mOBNnO5OW/aOYA/CxwcqjmAtTC33haUF3VAj5olaIhDZuu+Jn4bkmyXAlZBX
 N7KemWDAHz+mM1uIADRBfdeq2Kae1gXDHYH9i14jDWjKyHDcuvkw8juXtVwzlMDAH1vnWcUODUQ
 65LWMcSovCU6Ezt5PdtzyU
X-Received: by 2002:a05:690e:4811:b0:67b:d8b7:da1d with SMTP id
 956f58d0204a3-67c5687a157mr1511415d50.70.1794325881669; Tue, 10 Nov 2026
 07:51:21 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109-eth-v2-0-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
 <20261109-eth-v2-6-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261109-eth-v2-6-334cc08e2f2e@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 15:51:09 +0000
X-Gm-Features: AclHuK-sBtUbabE-fZrkHE17eY8Y_xGEaaGfLE2Vymzkb5eleg9vYBsGy8gPMm4
Message-ID: <CAFEAcA9oD+D7L5XJ+=bOWbtRLvOO6XrrvGcBruDmMv82Oqsxeg@mail.gmail.com>
Subject: Re: [PATCH v2 06/14] net/eth.c: In eth_parse_ipv6_hdr(), fix check of
 input size
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Matlack <dmatlack@google.com>,
 Alex Williamson <alex.williamson@nvidia.com>, qemu-stable@nongnu.org, 
 Lazymio <mio@lazym.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 9 Nov 2026 at 05:31, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> We already have some L4/L5 header bound checks. Add the missing
> coverage for IPv6.
>
> The IPv6 header parser incorrectly derives L4 offsets greater than
> actual values. Adding a bound check without fixing it would reject
> valid packets while fixing it without adding a bound check can result
> in an out-of-bounds access, so fix it along with the bound check
> addition.

> +
> +            /*
> +             * Detect a subsequent fragment per RFC 8200.
> +             *
> +             * A subsequenet fragment contains no extension headers while the

typo: "subsequent"

> +             * Next Header value identifies the first header after the
> +             * Per-Fragment headers of the original packet.
> +             *
> +             * The subsequent fragment is detected by checking if the Fragment
> +             * Offset is nonzero.
> +             */
> +            subsequent = extract16(be16_to_cpu(buf), 3, 13);
> +            break;

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

