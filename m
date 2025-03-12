Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFC3C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNFW-0002cr-Qg; Wed, 12 Mar 2025 10:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNFL-0002c0-RW
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:39:49 -0400
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNFJ-0004Yr-Sp
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:39:47 -0400
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso5827167276.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741790384; x=1742395184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lKLwDSRu++rXmRzCi9GDp+l5O7Md9kfsrLRYsLZZSZg=;
 b=O4fHTS/LEQT3sCXAa7EltR3jzlmrscraWHwK3SbnqprlU2NzWtYcx2WXBhaqUVD0n/
 oj6UujspSyXGd9bugwqE9tmkEE0I5LAq5LiAXZ5QZtu8K2OBK+Msi6A0VuL7TxlWTzCz
 /SO4kYiAxg6A9tv2nCt8PhbF6oByOD+NQ5xCw2N8JaJbR7ZlHHfa49aEkIiX8PWOtg85
 ODxNeacWROdisLagT0NWOCHo2gfuPbiK2gqQES9iX7BrwEFDiEPAde7lapyhfa5OY16J
 vtjxRhSRTxwRLm6EF7k9rzp0IQAXBTB3MtQMjo7TUKMR9zezWtDGsps0JOEF2ZeNdAF1
 lQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741790384; x=1742395184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKLwDSRu++rXmRzCi9GDp+l5O7Md9kfsrLRYsLZZSZg=;
 b=A75QnYuMVOaSp8fIlTFLm5TSylEysb2TiXLigXNkKbD0UE5WkePFkQIHyvTzCQ6X2d
 9cZlxTtiXnci3Yd1zeul92oz8RPvrmJobGqMsPK6/wUiYhqfITdy9+tBDMjYq2caamH9
 SaCmyN2oLXIJZmy6J5Ll+uxouqaTc9QK+isdH+SNnwUa+caA3O753nePS1+KL04eo8Qt
 bdvEqlM46KLXf1XrHa9jZe3m3m0jc4exVeCOffJHrVi3ABQP6Gi4SuYo7l6kzEsWaKvB
 1rpxsiFi2+GYfw2K8ZVDGuukabq/9WVw9/JSezl9aZKMSv+zI+kfZL0SQc1qrxQL1qcp
 2lLQ==
X-Gm-Message-State: AOJu0YxEZcgrqi5k35gBEvsjtyEXFtpQnzgpYT1PHTgUJKg9gr1B8EBj
 ZgOeWEadNGUxbCF5/tfaCunb9DJ80kvVH8bCCNfCm9KX6VGI52yeqGfcYfV4NXDLS8U7uee6Rxj
 hVfTU9VOKuslX8B4L5AMfEGpo9rZD2dayZ58bvA==
X-Gm-Gg: ASbGncuKx3rv2OOhTCO1FpPilROlHoMssCarIgjKTTHwu4G3LYjzZ33RJEsWMUDQ55C
 ybn118b3nAcSbMDfus/hrKV9qYPiCW/08jNUWGvots5B1Mz8gkryc8l2drTp+uS6z9LHD+qKX84
 wPbMvL8pQkelc6mjaJYOnfzd47HOk=
X-Google-Smtp-Source: AGHT+IFL1juRaO/mbK4s/530isYLkk48CtdohBLUnI+dbeubsc7FSf6gBSMwvkpexzm45xRSnwecrYtDPDWYy3B8oF0=
X-Received: by 2002:a05:6902:2101:b0:e5e:1062:bcfa with SMTP id
 3f1490d57ef6-e635bf12a3bmr26433005276.0.1741790383959; Wed, 12 Mar 2025
 07:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250307190415.982049-1-richard.henderson@linaro.org>
In-Reply-To: <20250307190415.982049-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 14:39:32 +0000
X-Gm-Features: AQ5f1Jp3S8FDkzyB7srqm6D25baWi6BKSGaG_XGbX0-baRHpvzYdL_yoNrNPxH4
Message-ID: <CAFEAcA8UeQLKrUSF8CpORFRzWSKsBMqa_vbNwCdsF5Nk6up5GA@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/arm: SME vs FP enable fixes
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Fri, 7 Mar 2025 at 19:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If SME Streaming Mode is enabled, but FP is disabled, we get two
> assertion failures within the translator.  Beyond the assertions,
> this combination should succeed because we're executing on the
> SME co-processor's registers, not the core cpu's AdvSIMD registers.

Patch 2 has a 'bool ret' declaration that needs to move to
the top of its block. Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

and applied to target-arm.next with that minor tweak.

thanks
-- PMM

