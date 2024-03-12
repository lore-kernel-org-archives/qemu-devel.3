Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFF4C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzVB-00044P-6b; Tue, 12 Mar 2024 06:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjzVA-00043x-4s
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 06:36:56 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjzUz-00075x-Bm
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 06:36:55 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56878bb1abdso418402a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 03:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710239803; x=1710844603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eg8lYdEsxAvAiX+Iihf9b9DdHc5YRHAbquME+iv17g=;
 b=kFJa6r49VDJN81Dq+RCYbo3Hs8FLj8LjeQ7Ws9CJsBh045XEKfRvVfXYBjgZWxVw/6
 haIYJjgS2yP19fvowSsuTvJSbU2vV+l6W/EYTGSMHxzyuT6z6jRLTQdhXrfsLMgzZDkd
 m/czhaecMfyQvN4OFr2a91BjgNzaZ6feCyqCwAERUC9w72I18VAt5bvfv5woJiCUx57t
 rNFUEA8McovNsbaYmqhY6yD89EqD1Q0Egp7qSvC0kk6PxeX4tDJnpbSqXdupLGr6wp/T
 LppCUp9/uHBMW1i3NwWiUkj9Ne9C0e3hFoZE1xbQ89M5PnVWfpdyTlX5d14hYreMFr6b
 XUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710239803; x=1710844603;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2eg8lYdEsxAvAiX+Iihf9b9DdHc5YRHAbquME+iv17g=;
 b=VkyK9gpFe9KfSmDLRKpSarZ/ArTGmJys/tJpnPvcqQ8I1jcmFns5XjKiVo49FoFROu
 kBInZEKnwDwsw7BJ3iNot/8BzTUKVZeNAI1lrMAxOv6j0fAepPOW2uTDnFtt5KWF61Md
 zsWfoBhIg0ijHxEVe7IOObdSkx+x1SSq27zhMurR62pGfZQXowLpGO1QrvxHBmwob++V
 kU4+Rxq4QT0S/dScf6XvsTBVHd4UZRomFlFfpZTsA+H1KRtplnmu0YnN7qLrtInkQ3aV
 Rc6/H0ii7p84s/+UWew4RxvC0+5+wY9PQPKpOl3f+oFDTpqpeUdPMBNzhxHwKqgEEfvp
 9Fxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs9AVO1GHDLReohrrY0pGiSkK+wBUgP3nEmslLr0414NN5vi0l5HMYFRpiZ0FYV6qHKBqg4TadFhgusZYW9bpbiJBhG5w=
X-Gm-Message-State: AOJu0YxjknVaI3oaEmgxTbNtANNgZhnjSVyRhRii15oKdQbFeIEJS/oh
 mVYt6qqahnYOjpkxaiiXeuhlqz4KslWAAnfCvKAM6wbW917jGILYVnmCNkidHMM=
X-Google-Smtp-Source: AGHT+IF7h9W8TnkrBA0Y70d0W1sC+QfWZv3+Fha8VO6Cy2idM9xl+7uwdDGpC4fCoerYGDha/Ag6wg==
X-Received: by 2002:a50:8ad7:0:b0:566:4dc1:522c with SMTP id
 k23-20020a508ad7000000b005664dc1522cmr1063846edk.15.1710239803414; 
 Tue, 12 Mar 2024 03:36:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fj10-20020a0564022b8a00b00565af2ea649sm3785110edb.14.2024.03.12.03.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 03:36:43 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4E4EA5F873;
 Tue, 12 Mar 2024 08:10:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH] gdbstub: Fix double close() of the follow-fork-mode socket
In-Reply-To: <20240312001813.13720-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 12 Mar 2024 01:07:01 +0100")
References: <20240312001813.13720-1-iii@linux.ibm.com>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 08:10:48 +0000
Message-ID: <87il1rq393.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> When the terminal GDB_FORK_ENABLED state is reached, the coordination
> socket is not needed anymore and is therefore closed. However, if there
> is a communication error between QEMU gdbstub and GDB, the generic
> error handling code attempts to close it again.
>
> Fix by closing it later - before returning - instead.
>
> Fixes: Coverity CID 1539966
> Fixes: d547e711a8a5 ("gdbstub: Implement follow-fork-mode child")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Queued to gdbstub/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

