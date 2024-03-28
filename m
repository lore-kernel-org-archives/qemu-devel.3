Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30CECD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 17:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpt6k-0006zK-Mm; Thu, 28 Mar 2024 13:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpt6i-0006wL-1c
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 13:00:04 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rpt6f-0006yN-Ns
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 13:00:03 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56b0af675deso1407711a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711645199; x=1712249999; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4d9qK/KHNG2a5Kl+d0D1I4QoIBsfySbEwohNRhMRaW0=;
 b=AB4+dNXrajH3yHrsM9qBDBSxjqdTidUuyOvHu3n24gFUVwGn1js4QhEvkuoHmxFXsn
 BS7iudKDMLdSZ7ZqkYpm+I2ejfIpBeCM+VMoL1aBJ6boEc8lj3Zf6WQGfX8WSKve2Q6x
 MO+hhc9JDh1oKt3FGaQkwPoKECBq9aNQDVoMo6gb7Ci9j5H1+6Q8MoPttNKPoaDW6yyK
 f9VtxAS+kTrr5zS1q8UCFnX5EcawJ6HELNb6wFfglddPZgn1D2by5p02F/kZGISVKr/X
 CAbfVH9FvUrrmrg72sBae8BqqxfiXz/82heppeQtAZG4sCME6IqVhpcshNpvZ1Pnb6Y7
 9oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711645199; x=1712249999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4d9qK/KHNG2a5Kl+d0D1I4QoIBsfySbEwohNRhMRaW0=;
 b=cKpGovycJ8PYesRpXe+6YAtiTAtAwXcLOmvXVNG2FgWLSL/Kk56TCupSRduSgzmjyO
 R/fN+MZGIzKLRix2g7mrxaLBAV4+99+C1KFFZlXK641HWXp/eNq0qYIRCXIvySukXOWb
 BYGxgos4uYqciIxbmdxE9UllpBZlPtHZSNuNN1E/lzVFHkUXBRVr98v2wYQVyoT7XkRJ
 AabCwSf2kK9SJ+3LCROIZENZv4Znd15RnQAwjvUa+DHGyYh9ofkozE9TBodZTg5zCP0j
 Kq+wPizjS1EKw7l2DsZgy68Nc3vmSa15vAf5IMJBefgdiEG/ADfG/E7lqo4Pycpkbtti
 /A9A==
X-Gm-Message-State: AOJu0YwsnKOEPsWdSzJ8Ww3KKeGhVzdXFcGEVsXJKN8p1ZrKhOGlJv+l
 sKSNdNsSRBfM18rZc2KW2r5fYalTNMT9RFNaeQJAU1m8nn7IkkLk/zgNKmMf2sBegW5evwWa36Q
 Fe5DQKI3n9ZCvK5XhhAiftrq3ulP7vegUP8RIrg==
X-Google-Smtp-Source: AGHT+IH07AbXIgMxuE1vp/ipZUTnoz33ta9WLCg+sfEYeWh+EweC3g0kjDBgzcMOl8hvfit+Stj7do6dNfG1m8IYrB0=
X-Received: by 2002:a50:f610:0:b0:56c:3644:9945 with SMTP id
 c16-20020a50f610000000b0056c36449945mr2899384edn.7.1711645199407; Thu, 28 Mar
 2024 09:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240328163851.1386176-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240328163851.1386176-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Mar 2024 16:59:48 +0000
Message-ID: <CAFEAcA_SfA6hUKQcBbGrT-vvJHn1yFWg6h=+rUCtYiwML-699w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs: sbsa: update specs, add dt note
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 28 Mar 2024 at 16:39, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Hardware of sbsa-ref board is nowadays defined by both BSA and SBSA
> specifications. Then BBR defines firmware interface.
>
> Added note about DeviceTree data passed from QEMU to firmware. It is
> very minimal and provides only data we use in firmware.
>
> Added NUMA information to list of things reported by DeviceTree.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

