Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BDED132CD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 14:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7xhG-0006AG-K0; Mon, 04 Nov 2024 09:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7xh3-00068b-DI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:04:33 -0500
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7xh1-0005az-GL
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 09:04:32 -0500
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-539f8490856so4395534e87.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 06:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730729069; x=1731333869; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qrb71dAyXhLrPOdskubCZa9YPaib8kba88lnP/u9WL4=;
 b=VZpR7svFtFiqBTewoAoF63bGGDkiyngQry3jq7L4rLoSDQZYcD0Qfa4myqjKcjUvJa
 CRbLOxXmbXuNEnuRxqY25xg20arxG2R0x4g6y8k1z9gaDcNGzWCjJFNs+7Q89NB/UGA7
 KoKBku/L9kxexRtXwhcjUKCC7J3aVW3vbpluOPVefpSjq0gfgxNo04O9PMpE89LoMG9Q
 +DQgNIUrFG21C3JyblE6wR9dSVDh6bT04lEmGrFQOuLohmsDXlZ0SRDA+LcejbDAQlZb
 V+248ksfyArvZlRBmOgwjtj/f127kUlXk6RNhaJn1MsZAxzJmxByD37g/cNeUoigrTsS
 OMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730729069; x=1731333869;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qrb71dAyXhLrPOdskubCZa9YPaib8kba88lnP/u9WL4=;
 b=cH9kwAvF8WcKLkT7mgfHGKiX60fiHMGLK4y5mBbmkPv46JFxAq9xhKAEv6fB0F9NDG
 /QfGWf7lUsNxId5D6Y95tLpFwfyiEpvKJPY8ssTpz2acUw3UGVa2VBTeVW4G/gI8EQrh
 ZvLr0wUfew0F+S+0qscdD97cjrWppcrsaanA3wxgTxxh/fmDtUygUhLHjjPEvaO5w1A5
 qJ8plXpb06rHn/hFJuYJICBO+ljxT3qKKy7Gsa63MCAV1gN9rPzDe6XDdFIIJJm2epzL
 QNs5f03TloJtwXFTragwERTxxigBHscli+NylgiTA12L+8+gFvhulcPXr+9Hqd+7qANW
 esCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7kOr1Flw1Ajw0Du0I8O9/rZhEGuQlVgU03tAGwfz5ou8GjeO+emDXSP5oEQ9vbwvo35/vRWJMgkOt@nongnu.org
X-Gm-Message-State: AOJu0Yw2//Q5r5Nxd9nva1qpjVdl+SEtTGCPd0iwy3ikO+sxNcapygVo
 NWn0dLNdOExo+vTmY8SO+ejCSRDymj3HyuV4etk8COZev5tD/9UOigZzEV0PKnn4HxUdmqktBUS
 q0/MBu+z/BcbpndOT1p3ybxbyy8vH0ebv/+ECJA==
X-Google-Smtp-Source: AGHT+IHeKg2xdtAtgVBODakXma5MFDhTWSx6PfXxctWyPg/sg4kE+USkfTUpVRwa03AVlg501kzXSTMWUIFtc3si/M4=
X-Received: by 2002:a05:6512:68d:b0:539:f593:c19e with SMTP id
 2adb3069b0e04-53c79eb5fbcmr5713772e87.60.1730729068695; Mon, 04 Nov 2024
 06:04:28 -0800 (PST)
MIME-Version: 1.0
References: <20241014184847.1594056-1-roqueh@google.com>
In-Reply-To: <20241014184847.1594056-1-roqueh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 14:04:16 +0000
Message-ID: <CAFEAcA9Vikyioaz1u6Hbj8ROe_aVnjnwsg-yX-TV-NCs0U3hHA@mail.gmail.com>
Subject: Re: [PATCH] hw/net: Changing log error to trace message
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Nabih Estefan <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Mon, 14 Oct 2024 at 19:50, Roque Arcudia Hernandez <roqueh@google.com> wrote:
>
> From: Nabih Estefan <nabihestefan@google.com>
>
> Converting error to trace message to avoid spamming of message when
> there is nothing to transmit.
>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>  hw/net/npcm_gmac.c  | 5 ++---
>  hw/net/trace-events | 1 +
>  2 files changed, 3 insertions(+), 3 deletions(-)

Applied to target-arm.next, thanks, with the commit message
tweaked to:

    hw/net/npcm_gmac: Change error log to trace event

    Convert the LOG_GUEST_ERROR for the "tx descriptor is owned
    by software" to a trace message. This condition is normal
    when there is there is nothing to transmit, and we would
    otherwise spam the logs with it in that situation.

-- PMM

