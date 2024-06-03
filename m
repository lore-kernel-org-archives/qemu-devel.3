Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB869C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 12:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE71B-0002dA-34; Mon, 03 Jun 2024 08:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE717-0002cV-W3
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:42:26 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sE715-0007wp-5W
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 08:42:25 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a2406f951so4479588a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418541; x=1718023341; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YE51ACmE/qwxiQHB3EfhHk2cKF0CPqpMWsQOs7Q+LPw=;
 b=wAp6ke9WwputQwgu/V+QaZnvjuJNVGXC2HHVLWz1YqMct7d1BxihC6aZzKAlBEyzHf
 TFbQWpt60IbOcxRRFC0C1cwYbVLGVdqFOlOIklO7VWhsUhBYJuFvCMwxjWessDzAbKxB
 y51aRD06FJhx1MD38xgGwcdFvu/+pwb8ntKEWkCBPldQT1rzY19JW6KxEVZLIPlJNpFO
 2jtamchAsBw0GlU/MW215xDxt8KdkXfYIG2gH261adQV2DTU5hNx2wX+UHQdf5rSoT6L
 n3au+qofKqh+FdpEcKFGYIZgqYIlfog7n1qFhROWxIzqzOXCbnoH/nRCCOKwck7GLDGE
 hdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418541; x=1718023341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YE51ACmE/qwxiQHB3EfhHk2cKF0CPqpMWsQOs7Q+LPw=;
 b=KRyPdqbCmfcgayE/gAIeDxJN5qSQFKys6LZWqUj7kVoYrQ6q+RNa5AysPnmUDRUG1s
 5AVs2Z2gOE64s09/MCSZGlImMAg2AFnDhKy8EDLEZiQKLhF0Z8ahRZufKknE8YsyYONE
 44NGtp1Ia1POflBE5eayYqXIAj6NTcGw4aNMBCnkWLjfB14B461h7yvJ8sl6l19qfMUO
 I4hjwyqD0YUTQKiWZLmer2E0EUSacb1Gdtr0vowpbMNhm+LBIxr7UJ/jLhzTU6WZpRs2
 wU7n03T6IyVa7LgmzR7lfpWhg2cqXkWRPs/SgTuzCvA/KCpqBPkxpbsumgFUfPFEl7oR
 GsTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcJd+j/lhUrbxKKDi0fnVjWcJphwqxM0Nbfu3xIys4jOFzJpMJzYd/l2rmuTyvatQHEQIP4jPgrhpf+g66bcT4zXwKYkg=
X-Gm-Message-State: AOJu0YzTwH0DL0Iw32m7Fv3OvL8E1dueB5n48qig+RiX2Rib5SZphRKQ
 Q/uP8/whxHcomslgl+sHC/DIY3HLHdzdImy4C2fM8SBnQJNdP3IWNYKzm3zlqWxNpctS7wylJ1a
 kfYnSBEdKOnKfwB3KECUnl9EKKAUZ7OSS2aWo0g==
X-Google-Smtp-Source: AGHT+IGNrvvaKPtx/dWBWL57jKzB/35jTMmsSruO6yIlN11V87UkcagxIj7sNZfr1WQTsCcFxxp0Zo0Stq5blXwnOyQ=
X-Received: by 2002:a50:a69b:0:b0:57a:303f:94c1 with SMTP id
 4fb4d7f45d1cf-57a364487d0mr5837551a12.29.1717418540997; Mon, 03 Jun 2024
 05:42:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240603051732.3334571-1-Shivasagar.Myana@amd.com>
In-Reply-To: <20240603051732.3334571-1-Shivasagar.Myana@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 13:42:09 +0100
Message-ID: <CAFEAcA8QBYXR2HMFWuYMnfXjmN+t4ciB=WwUcVx=NP-p0sLpNA@mail.gmail.com>
Subject: Re: [QEMU][PATCH v3 1/1] hw/net/can/xlnx-versal-canfd: Fix sorting of
 the tx queue
To: Shiva sagar Myana <Shivasagar.Myana@amd.com>
Cc: francisco.iglesias@amd.com, jasowang@redhat.com, qemu-devel@nongnu.org, 
 pisa@cmp.felk.cvut.cz, sai.pavan.boddu@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 3 Jun 2024 at 06:17, Shiva sagar Myana <Shivasagar.Myana@amd.com> wrote:
>
> Returning an uint32_t casted to a gint from g_cmp_ids causes the tx queue to
> become wrongly sorted when executing g_slist_sort. Fix this by always
> returning -1 or 1 from g_cmp_ids based on the ID comparison instead.
> Also, if two message IDs are the same, sort them by using their index and
> transmit the message at the lowest index first.
>
> Signed-off-by: Shiva sagar Myana <Shivasagar.Myana@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
> Changelog:
> v1 -> v2 : subject line is modified.
> v2 -> v3 : subject line is modified from "[QEMU][master][PATCH" to
> "[QEMU][PATCH".

The usual prefix is just "[PATCH]" (with optional 'vX' etc);
it's implicit that it's a QEMU patch because you sent it to the
QEMU mailing lists. But you didn't need to respin just for that --
the patch application tools strip off all the [] prefixes regardless.

Applied to target-arm.next, thanks.

-- PMM

