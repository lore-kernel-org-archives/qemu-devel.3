Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FE4C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 11:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmXx1-0000k6-3i; Tue, 19 Mar 2024 07:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmXwz-0000jq-P0
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 07:48:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmXwy-00078b-4L
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 07:48:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56b0af675deso2099008a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 04:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710848890; x=1711453690; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5GP4EPM1trl9PftT7Hq/KdgUFdDTnpUxB4h4giz1ZbA=;
 b=V+A1Ffzm5cqz8vQKpP26lTPc2vb/F9YsT6xqvshSwnJW/bB5ESwr2IfCmWIA7KD98V
 nah9+tleN5N4G0pdJJ+ZH413PGhDVguny8sc7uiXd5O1QWvVEWn+1RI+Qlgvq7uwu575
 ZiBBFVlHMPG6UwfclpVIgo8qf3YjF+g8MM5IGzp7oWivXbNpWFHwXoBRYUbCsYzu8YjN
 VaT2reEbLQW0tUbHE+YKt+Vyp4uaP3BBygw1iMKImBoXkGxzQ5zWT6HmDu4ic5qbzxT4
 9h6OmrgfiXTf/ZPn7SpnSECPcAoLAlZp2EDvsFdpcGmc9+fWHb0FnFTfi/n2XHh7kvCW
 pcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710848890; x=1711453690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5GP4EPM1trl9PftT7Hq/KdgUFdDTnpUxB4h4giz1ZbA=;
 b=mAUiwI6Tn8840cwbDtWsHyZMgtq6V/vJKnG08R9p4nly39CnTkC52O6kALaKRZNulv
 cQ+ZE+9yzTCVXoFqdlXC56OkNKyXDClemrzhj7WX8KeBz1sWg9854e6CdEZktwUo6MHx
 cl4yRCPDehiVvERym1eaGJtLNU44dNO70ca+Vd2r1n62PEFeQj/aetQwqzgkxNsKLJ02
 IrpqCaTbv2kipygp/Bhp2VFx/yrAJF7/dYNRIbYkUqCTX42kAVbYKRWI1vFFhGyuIJMF
 jBXDm3AhdfXTP5kNB1xhLbGm0WPXHzmbN9i4Zx22A+hkc2KOFn9ZoJ6vCDWxcE4oQYyb
 ca2Q==
X-Gm-Message-State: AOJu0YzhWfPa243fo0dLCfDfsMCiuugaqnSzQXIAw0EQ4X1sWw8pxmCn
 8jtDs2q43lW6mFCEGFqBWTk8g1B5p19ea0gQH6FAATxHvpqI/WRvrbYtooYtu93px419QuDTsxa
 QzctanAeGhPUtXBSjliFMIGA50szyFL9GVhqF4Q==
X-Google-Smtp-Source: AGHT+IFYeD2+s8oQMDb21opPRkEg1mZ/QnFs2d0S7Qb/uFXIN0F/1r8BOCBJzrNSRdpsGF3s2FfhjrMHDISrPYv2+ZE=
X-Received: by 2002:a05:6402:4498:b0:568:c26d:8718 with SMTP id
 er24-20020a056402449800b00568c26d8718mr1766528edb.6.1710848890278; Tue, 19
 Mar 2024 04:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240318030437.17503-1-maxim.cournoyer@gmail.com>
In-Reply-To: <20240318030437.17503-1-maxim.cournoyer@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 11:47:59 +0000
Message-ID: <CAFEAcA9FefR6a48ZO5SgvjOGGYT3t4hxt9OqsybV2e-15HNzTQ@mail.gmail.com>
Subject: Re: [PATCH] build: Re-introduce an 'info' target to build a Texinfo
 manual.
To: Maxim Cournoyer <maxim.cournoyer@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Mon, 18 Mar 2024 at 03:05, Maxim Cournoyer <maxim.cournoyer@gmail.com> wrote:
>
> This reinstates
> <https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg09228.html>,
> which was committed at some point but reverted many years later in
> cleanups that followed the migration from Texinfo sources to the
> ReStructuredText (RST) format.  It's still nice to leave the option for
> users to easily generate a QEMU manual in the Texinfo format, taking
> advantage of the Sphinx texinfo backend.

As far as I can tell, we never committed that patch, because
(as noted in the discussion there) we don't particularly want
to generate texinfo output (and also because it was missing a
signed-off-by line). So this isn't a regression: we've never
generated info docs since we switched away from texinfo to
rst as our source format.

I don't think my position personally has changed on this one
since your previous patch submission. Other QEMU developers
are welcome to weigh in and disagree with me.

(If we do enable this we might want to see whether we need to
set texinfo_documents in conf.py or if the defaults are OK.)

thanks
-- PMM

