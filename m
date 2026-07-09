Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4557CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 16:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whrUY-0007Do-EH; Thu, 09 Jul 2026 12:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whrUX-0007DX-Hk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:20:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1whrUW-0000JK-0X
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 12:20:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so16825965e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 09:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783614046; x=1784218846; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=V2zH3B8DR54Da2OQPJu7p3EDFlt4hMxq1o6ZjpD9yMA=;
 b=typkIB48fdv01x5oRcagqQwT+E1RUPqhwOdzmEBPz/kkyJFi3WNfC8932ylafaa6rr
 +PFTO85fXjsTTmua6R1WUF2rOfF+4eJr9jJOV+m0ceSZ6hD1l+xV45xg+7QBZ+4H1xHU
 8pfsRrgIyZ3BrENO1MAopKFyK6KCDvPlp7h2sUe7WeiJNQj3fRxGVQFB+QABV6W9ISSj
 JHRmD8izmcumw8FFNoo00uuVMaGawj4aHJLQUyo+gKEhupMaGVmeEg6eJ1CWG/sLx4Yw
 oGalkXbbFRDXe216EfmjUFvQ5/eVdgIROmpaUtVgMyfkvvOKNpBDeiGGLBON0pe6y7cN
 8OXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783614046; x=1784218846;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V2zH3B8DR54Da2OQPJu7p3EDFlt4hMxq1o6ZjpD9yMA=;
 b=rWMA/tm4zwws2E6zpTAaDpj13tWEUt6X4Ya5VF9wET8oDpMT5cVBA7eqeQHtCf37X0
 l7sFjh2l7ssQCsfyANvMLL6axLk2HBVcGw1HJwIuBsCthQaw8t9c3v1UOF45ApaaVMR2
 Q4LQCU6okXqRrtxE6O6GNNyfgxiBz75q9tNy/abXcI+fT+TsXK+EJThF+9n7lERjgKm4
 GZjSQoPpsPs3QyZYhkihqkqCtg/PO5FHjig5OiEanbJTfyr35I1e/EM6BwH1/2ERjTxU
 gexffAAFOEbMhLQJ1K2jh/dchGMpjKZufR1zgLuAjCvOKJ5Afc8D2VMJ4NopEANJr7w9
 gEQg==
X-Gm-Message-State: AOJu0YyMF6ftwGkGOxcyu3Hiaaoxy48fM3hB3FPrB7+xt7Bv7zYF/EeU
 s2tYtdMEG4XOorQX2oEL3ONCWxoXp93ckRkRbokevInXliKRcMtbCL2LBo3TL95Q5Ns=
X-Gm-Gg: AfdE7cl3+AhCsP7GxmxxYImysrhdCgK0GZOwdf/rWyNv+ZKh4k9oBRiiogvk4afgWZZ
 eERDqVfZLX1CQ7OTcXYZe/YGpc5Z645ZlesbufX4dgjlPblDqwaY48V3zXVLwlRdobwdn6I8snY
 AO2fwwHub9+J07mKO4Sqk7HlW4185oxH7RxZV3420B15LBU7Gif1GAZhD2xdKarcaHmAMJvhMHB
 a7KEOozC7thWUkIwuhBb2tFM2WYM2JYqShcHHzK9IEUz9n5X3wY8scbau3Y4+6bN7RZ/HYiD86N
 aJI4ThA3sWdgOqLIZC2FWIoFySMJa7DqQIR4TPPbzf0laE7rHToVdJDUL6ahNevL2jsPmK2h4Cr
 /1GyNkg+5vulwcUp+g9F8q++LX4iB6YnYyUiwkq87zLJYGUb90U5ly4Ncbk6kCJuVf8GLKYTC5Q
 ldn6kkNcW4MpkB
X-Received: by 2002:a05:600c:8b09:b0:493:ee3a:f05b with SMTP id
 5b1f17b1804b1-493ee3af190mr26840345e9.7.1783614046176; 
 Thu, 09 Jul 2026 09:20:46 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74b3edsm80781595e9.15.2026.07.09.09.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 09:20:45 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1791E5F82D;
 Thu, 09 Jul 2026 17:20:44 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Ilya Leoshkevich
 <iii@linux.ibm.com>,  Brian Cain <brian.cain@oss.qualcomm.com>,  Gustavo
 Romero <gustavo.romero@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,  Helge Deller
 <deller@gmx.de>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 21/91] tests/tcg/meson.build: add logic to skip tests
In-Reply-To: <20260706223343.988769-22-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Mon, 6 Jul 2026 15:32:33 -0700")
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-22-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Thu, 09 Jul 2026 17:20:44 +0100
Message-ID: <8733xsrv6r.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Instead of skipping tests and not declare them, always declare them and
> simply return an exit code 77 (SKIPPED for meson) and print reason why
> test is skipped.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

