Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C098DCC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZt8-0000qV-83; Tue, 13 Oct 2026 06:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGZt6-0000qE-KQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:37:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGZt4-0004Bl-Uq
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:37:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48b03f23305so2360124f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791887857; x=1792492657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1ClRIfEMJqxrNhVmW03aKtfEAOiVD/wd6hwYPaaiaZ0=;
 b=DhjW+AZU93NTmJPSt8+OgWAz+a1UjDZhlt6Yyx+5pw2MCHnEWdK1hDxlUrZaWPGeEX
 r+mXfORoq+W4XO9i/yjFAnBzIbRlOk1Hsv5B8IMnNgSyyZw3JTAu/9CYFq6uEb0CL5Q/
 Digypgk34UVf8Ckp1vzCh7tCpvwvFL5rvTcwJtBk+tKDQpI2auvcD3Vy7TcX8G7ggxX2
 ++nuwJVQrc+ITlihMcxyrQCaYltZ1Lr/sD7FNQ7NfXkmFeKu0q6/RIQOgHqODX1vOU0v
 0FmfM6CIm27gGZwnrXobkxGE82kXldWkW7OLN1o3lX5QsXcDgwEALY6p0mj3Zw93zoYB
 3KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887857; x=1792492657;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1ClRIfEMJqxrNhVmW03aKtfEAOiVD/wd6hwYPaaiaZ0=;
 b=OJL23E3cxqw1AI0gopxVUpWon4Wbm460n4InzKqAS1eUnY1wFArf3WTKNQdbeFmLV0
 T6zlciHmkQFCc5jwpnz0oxTllL+/dDf8ICUCYIZfd34tQ2n9y33mSIRoe54DIOI77c2T
 Z8U3LLV4hVf4soTQ4aLuaIA0VjK8btaob4MvBpZazVW8twnAcXsBtVBw/tTaSB1/Si2o
 aX/5ElkfzLp2Ds4OHr1fA7GcODULqw7GzFUVOegQ1lGtwQrCIUDFy06bPAdzTm2gK+Gc
 ttMLJDJ2y5JWTtwQhp3+xKlzbDHiWQPOAsyuSKM2GqwJsG/0etu+/OM/3MAA3aa6SawL
 j4hQ==
X-Gm-Message-State: AFq9FYJcqUKSSPMfLQn1qZYo/EA2AWOkjgV5fpAY/dhtEd+P773SmsGD
 Y0toYvmYBeQMgX8BsGkO19Pk9AhswK3Dxgk0XDK877LVQPNHwoGoYpQXrh7bJ1j+d8iCL82ne88
 CGbnLuYA=
X-Gm-Gg: AYBFou1Cn+bxy80wSxoWtAckOiaYTHECmUQ+/9mnfizIxVD/DWIjxdCkqCHbPO7G2iQ
 wS6aoJXXo1mNdZk5zg+eUlUwBkyUIuRFUiNikNLVjrc0lHeIxFVHxRfP18eh2Cp2fUKR9U0oT+J
 pW9YLFlNa/uzx4ldu6BPVjKun7ACTQJ4rYu4haP+W0KTtjJz7bWjNJ9gqfePSaHHT1IYApQvjnq
 Zs/uXc4w6UMHzxmbCDUPWsDPn8ces5eYCXZCcUYN5FiZW7hid7VEkkiQGdznoLendhyGWnIn+rj
 f6++lk/GyJo9gEhad7TCql7dc+DoU/M/nkulFtQBioH6l8PvqT80q9Bq5oljvQV2rmBZuc+E4j7
 ujxDcv02UV8zEHArQCgef5KBqrQ2yNzBVs83F88wzC1kf5KVPR1boeL2WCjMxWS/ERItW3q80NC
 pqbyTtQXnZ3g2uCbwap4gWa/DcSWWqnA5qgZzb7jQ/n/jsw61Ab0Hu5fs6TCQBz61ZbeYJ3A==
X-Received: by 2002:a05:6000:298d:20b0:48a:f404:6960 with SMTP id
 ffacd0b85a97d-48dbaadbf75mr17352492f8f.9.1791887856573; 
 Tue, 13 Oct 2026 03:37:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa608sm4772351f8f.18.2026.10.13.03.37.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 03:37:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7179E5F8E5
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 11:37:34 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] .dir-locals: include QEMU code in PYTHONPATH
In-Reply-To: <20260930163050.426737-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 30 Sep 2026 17:30:50 +0100")
References: <20260930163050.426737-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.4-pre6; emacs 30.1
Date: Tue, 13 Oct 2026 11:37:34 +0100
Message-ID: <87pkxdga35.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> When editing python code the linters tools have a hard time with our
> imports as they can't be found. To ease this we can expand a
> PYTHONPATH in .dir-locals so at least Emacs users can have less
> warnings in their editor.
>
> I still get complaints from python-mypy about missing library stubs
> that mean it can't do proper type analysis though.

Gentle ping for any fellow Emacers who also hack on the python code.

>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .dir-locals.el | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/.dir-locals.el b/.dir-locals.el
> index 3ac0cfc6f0d..51871619422 100644
> --- a/.dir-locals.el
> +++ b/.dir-locals.el
> @@ -1,2 +1,8 @@
>  ((c-mode . ((c-file-style . "stroustrup")
> -	    (indent-tabs-mode . nil))))
> +	    (indent-tabs-mode . nil)))
> + (python-mode .
> +              ((eval . (when-let* ((root (locate-dominating-file default=
-directory ".dir-locals.el")))
> +                         (setq-local process-environment (copy-sequence =
process-environment))
> +                         (setenv "PYTHONPATH"
> +                                 (concat (expand-file-name "python" root=
) ":"
> +                                         (expand-file-name "tests/functi=
onal" root))))))))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

