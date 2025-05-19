Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27240C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:32:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1Xa-0000W4-9j; Mon, 19 May 2025 10:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1XW-0000Vr-1d
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:32:26 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH1XQ-00071O-7c
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:32:25 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-703cd93820fso39575077b3.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747665137; x=1748269937; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kdShHZiHFHvFcUelGV29idzXHFoE9B+g0kognMMc0BU=;
 b=R2oS6X9Gjgnht69fc/hTgQLwp0LRqiQLUSq/Heool+4IAHIcT1tvpiXlCiaR6eEGqd
 lZ+t+Ih5kpT/1wqbk3ApqTl5mC7fFL3Nr3MUYutI08bVgOCAmAgniebfYKDBNpp1IFfX
 dNNY9sZcRVzU40ae4aNFhXpk1La4erala2u3Lc7XKtqDhYbEIaOQYyyNZaEt/IfDOE3p
 4noL2hD5yc5iMgMyCwufIsrpIqyY+dmaLqHJ1DZ1wooNb7L0pD76LLBfVjrG5I2q7Kl7
 1TYZs05l92tmCuxuCvqcsyIKEYGmDWzsFq8MDNESQ44z/EF5Y2/PAOZi6HPERGocc+kn
 Oz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747665137; x=1748269937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kdShHZiHFHvFcUelGV29idzXHFoE9B+g0kognMMc0BU=;
 b=FruzcmK3ZCe0TlRsaG29s/W2Wur1Uk0LrUWLiFMuFrgn4/qSz0EZ0DEQqGfzTNZOdX
 udxIVxOA5NzxrKVr31KV3YeO8hocRJ3m+78P288NG5mrttXjdR1PhhsPkxiNXNzFZWse
 EuUo8te4691Y2ACyJFpZjclVSNLPEa9rQOInt8EDiRnoXLOJMJLHH03geIY6thl9y85g
 +2bfeQHAucZDwvds2gG98YzlKLOSuZVgQPyrVSEPD9qxBlAX8+qruskUuThNzHtb3aqh
 Qr4McsTXKr9MEbEQlz5eJlldtnbG7hGO6VhXdpEVdZal2LV4BlCxmMSMbYtYvsAV5+Z5
 uY3w==
X-Gm-Message-State: AOJu0YwwGcORvZFpEs1Zmf+MUHI684yCg83olEz0evFjNHC7DzjDRoIj
 XygRxEhkRlpREEZQ2dxZoQuYWF5//bWFkAMeOtBLfErhRlf8XM4ZIRYYmQ6WyKeXOVXMqTV0wBk
 wyRrJpqUHRFLv13bZg4i4kDZp4v2xU80gPc1uxjFTZOutPPIcAcyv
X-Gm-Gg: ASbGncsdi3pHqsmvfA2uKTdZTYWfmoHdbY+Wh2xpFzKO/RnZ2b6l3MepO8BcMppRGaI
 Pr8aCi63/fgTGyVtLA50mzOdx/LcvOwwc+boXyf8F5S+h+MvI6hwMrBY5ot78kKU24Q06Bf+4jc
 JsVLzDQ+NHk71sJznwVJkEOHxTv9sQu8l69A==
X-Google-Smtp-Source: AGHT+IHg/7GLXr5FbAlVSHG73eQlyix4+GJN1svEZHN0dEKnURkLmqG+LZ7KSLlkknwxGNEAIK2VmgoSB6KTNDsVGX8=
X-Received: by 2002:a05:690c:7093:b0:708:c7db:ceac with SMTP id
 00721157ae682-70cab0bb1e4mr166174987b3.24.1747665137326; Mon, 19 May 2025
 07:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250429163212.618953-1-peter.maydell@linaro.org>
In-Reply-To: <20250429163212.618953-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 15:32:05 +0100
X-Gm-Features: AX0GCFszqV7sHadLxm1PovC1_LZcnY95Au-vHxORxWkaroaMF1KvjtpgYXWDL_M
Message-ID: <CAFEAcA_hV=962gFfKc-7D91X-MXxVs=VrKQVzOKaLS2gJDt5Lw@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs: Avoid duplicate labels with a sphinx extn
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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

Ping? Any opinions on this?

In the interim we've applied commit 82707dd4f0 to drop
the specific duplicate-label that is causing problems
right now, so patch 2 here will need the obvious trivial
update. But I do think this is a better approach than
forever avoiding defining labels in .rst.inc files...

thanks
-- PMM

On Tue, 29 Apr 2025 at 17:32, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Sphinx requires that labels within documents are unique across the
> whole manual.  This is because the "create a hyperlink" directive
> specifies only the name of the label, not a filename+label.  Some
> Sphinx versions will warn about duplicate labels, but even if there
> is no warning there is still an ambiguity and no guarantee that the
> hyperlink will be created to the intended target.
>
> For QEMU this is awkward, because we have various .rst.inc fragments
> which we include into multiple .rst files.  If you define a label in
> the .rst.inc file then it will be a duplicate label.  We have mostly
> worked around this by not putting labels into those .rst.inc files,
> or by adding "insert a label" functionality into the hxtool extension
> (see commit 1eeb432a953b0 "doc/sphinx/hxtool.py: add optional label
> argument to SRST directive"). However, we let one into the codebase
> without initially noticing, in commit 7f6314427e ("docs/devel: add a
> codebase section"), because not all versions of Sphinx warn about
> the duplicate labels.
>
> This patchset resolves the problem by implementing a small Sphinx
> extension. The extension lets you write in a .rst.inc:
>
>   .. uniquelabel:: mylabel
>
> and it will be as if you had written:
>
>   .. _foo/bar-mylabel
>
> where foo/bar.rst is the top level document that includes the
> .rst.inc file.
>
> Patch 1 is the extension; patch 2 is the use of it to fix the
> problem in qemu-block-drivers.rst.inc. (Concretely, the result is
> that instead of an ambiguous "nbd" label, we now have separate
> "system/images-nbd" and "system/qemu-block-drivers-nbd" labels.
> We want to link to the former, because the latter is in the
> manpage, not the proper HTML manual.)
>
> This patchset is a bit RFC quality -- I have not tested it
> super thoroughly, and the extension itself is written based on
> our existing ones, because I'm neither a Python nor a Sphinx
> expert. I figured I'd send it out to see if people agreed that
> it was the right way to solve this problem.
>
> (In theory we could remove the SRST(label) functionality from
> the hxtool extension and have the .hx files use uniquelabel.
> Not sure that's worthwhile at this point.)
>
> PS: I find that our extensions are confused about whether they
> should set "required_arguments = 1" or "required_argument = 1";
> probably the latter are all bugs that happen to have no bad
> side effects...
>
> thanks
> -- PMM
>
> Peter Maydell (2):
>   docs: Create a uniquelabel Sphinx extension
>   docs: Use uniquelabel in qemu-block-drivers.rst.inc
>
>  docs/conf.py                           |  1 +
>  docs/devel/codebase.rst                |  2 +-
>  docs/sphinx/uniquelabel.py             | 74 ++++++++++++++++++++++++++
>  docs/system/qemu-block-drivers.rst.inc |  2 +-
>  4 files changed, 77 insertions(+), 2 deletions(-)
>  create mode 100644 docs/sphinx/uniquelabel.py
>
> --

