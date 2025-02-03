Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA68C02193
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 11:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teuGc-0005KF-MO; Mon, 03 Feb 2025 06:05:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teuGa-0005Jd-Ra
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:05:24 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teuGZ-00031c-72
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 06:05:24 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so3776516276.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 03:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738580721; x=1739185521; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LDSYdTk7W2r/HSiYGKt1rfZ/4rIklisHtShfHV6m7HU=;
 b=rW5KWA0zEuDBQes5+ltayr32eIRBRtl80bkjS76pLieCNOd9kPY2E1nC7q1zF53FtA
 SJAoe5i6Cjf70WMmS8uGq66bS+B9vSeB6DcjdOoMBBOhDvHBqtN1rwqErVhskR5CFW19
 lbzYW1uA6U2fC3OzKFAUFzkVi76k72EpPqZrR6B1J9VLoPvUByjAY+R85tudqtN1E0iV
 OP/IxCVDxDiEc35Cl+4HEqZXcpX4UeQ9LYttINgXLe/xqnbAeeZs4m6gSfS8HabjUA6Y
 X+LD72RTp4fLYGpmHhXJ44f2otmlemIR+ok2rPZdrzGv0DMKjKg69/OUPjmwjaDNUWJ6
 0RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738580721; x=1739185521;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LDSYdTk7W2r/HSiYGKt1rfZ/4rIklisHtShfHV6m7HU=;
 b=j5tFAGPjS6K/52WXdqYn9QsaPm3QMOMYYOxuuHaeluo99gw20B0We4iqle44UUL+Zr
 O3QC4ADVxBp3v25FSA4DT0zBJNG7faJqVH2N9cOFLMJVrKM6TmKpCdFELhG+lir1pl7Z
 Wsk6Kd2WnRtjzbGcEYkIo9dBUkfM6dKPt0h5XDQFjIfrUgWddE8LEwCEKxGncw8swnWJ
 r07eZMcpLiZRV1rVSdO54vvM5ZOt07Li2sPeE3+B0G95CQfAdf3KKNhlQJ+o6jiAC6PZ
 8zf/xmSJMnLbBU8nsAFPMgDbrWbwCNhTWUcdpypaMfYNPhlAKuXlgQYiUbQ5jjWdkBgw
 s0kw==
X-Gm-Message-State: AOJu0Yzug8LN78YK3s1nqtqD1z4FUUYSCAS0mgPv0wUKTyBOqsa9LBy1
 XOIIShhqcMbMEY0rYTIZnKmEluRookwRwPxZZ351lBVhEYxJktDf1BdXzAcklXz4Sw84uQY7/Qo
 JBwolwDSrzrarYA2g6Pd2izavQMFZKm1iueLP5g==
X-Gm-Gg: ASbGnctAfakyWjBTYhkToV+yNaMQTyTXXIxMj+BEiLAUItY0RQcRVd5IP4babVXqkYy
 7GT8D+qAezq2wzsTMOqlP+x7fO5MNCMOXpU/cvziIWAIZJpBvAA0dvAg04cxQqPi443HPtZ+l/Q
 ==
X-Google-Smtp-Source: AGHT+IEM1FDHtoyjw2plUdFZ/Sr+XAWagj77P/jlwaibblGJHcs1sCgtDGngEQBm2dhnF1sMp35bBSGKXvStu5dpPj4=
X-Received: by 2002:a05:6902:f84:b0:e58:1501:23a6 with SMTP id
 3f1490d57ef6-e58a4bb016emr14187676276.43.1738580721597; Mon, 03 Feb 2025
 03:05:21 -0800 (PST)
MIME-Version: 1.0
References: <20250116112536.4117889-1-peter.maydell@linaro.org>
 <20250124172224.815473-1-pbonzini@redhat.com>
In-Reply-To: <20250124172224.815473-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2025 11:05:10 +0000
X-Gm-Features: AWEUYZlT3hwoKLnuYXB_LNnNI2g5yt4aCPciY6YYr0H0z6-953tLr0ZLwrLhnzQ
Message-ID: <CAFEAcA-191pk0zeUP5-=Z6JFJitPzw8cXwcVerYLNFrLGRQa0g@mail.gmail.com>
Subject: Re: [PATCH 0/2] target/i386: Fix 0 * Inf + QNaN regression
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Fri, 24 Jan 2025 at 17:22, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Queued, thanks.

Thanks; do you plan to send a pullreq with these in soon?
I ask because the Arm FEAT_AFP set is now ready to land
and it has a dependency on these.

thanks
-- PMM

