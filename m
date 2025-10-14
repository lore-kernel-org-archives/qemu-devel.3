Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BB4CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 12:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8eWQ-0005Eh-62; Tue, 14 Oct 2025 08:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8eWN-0005EY-T3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:52:56 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8eWH-0003u1-N1
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 08:52:55 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-636de696e18so1999426a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760446363; x=1761051163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0hCF37KjFI/Dt92BwrOrHQsosxgCV2ZktrD+jHlYVoc=;
 b=jV0glTze0ITYgjUXBzmXLg4lgSab3rSECE94+zAJTypBTEk5MJs2Ot3wNnC8nYgt6j
 V5qRr2/Q3wyC8c2AAFJNICqKA83qarwfCcyipLUO0N5xrG5eLfTjhTtwxujBtPH039CV
 82uKpqIZhNlCPU+IvYIE5BffLoqE+PDHAEeYZqIX24J/UhNnk9ZIypM0SqBm9ypCnX5h
 EtA/5FIqA1UrECl8qvfHLnkhvEfqC3kfH4sWx/l7zfUNakekEvxJFytx3YwY2jGhgTnP
 xtGBVQOfBVeLzBSSZQuFWX5GOya89l8IiVGAa+gofFScYqoLVzqtC3Sgaj6qeemLyJN0
 2JvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760446363; x=1761051163;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0hCF37KjFI/Dt92BwrOrHQsosxgCV2ZktrD+jHlYVoc=;
 b=JGgeg77tAvSi+PUYW9N7TzPHRocqNCWZtt3RH8ogAOTxkf+XHVIGb/lIx6VlNyoeVP
 vAM77S5FR8BGUA4UVBAd2EqUOa1qbaHp/F5ZY8KDySPv/KWFKRzjOkncAnLSIitc5YWe
 br0CTDXgxEt4f3h1KNM+5msDBJtIBeeyI30iOSW6/829+8mdVbVg1f26OXmiiVe3pLm7
 6K6s2q5EnO9MLOnWnbt1eJE2uO9PTOysT7SX5hO/ZvOzyEmFQRRo9lsU/NpHFYXB23o/
 DdQpyGY4+3gTysGG/2KEslXCsJ1gDPzMHSyZ29CaNzDhKOkvNd0zOxivOajGiwjvKWg7
 B4Ww==
X-Gm-Message-State: AOJu0YzomUbNKubfQto3sO4I35aGFL5r6phOAOJZzen0RfSi5GaN8IFt
 vF9nByd+BFJYwmtFKGZ5ERUe7rUwVuxmjvvM2HzWXFaPbX80ce1c8qlX40WChQ/wwmbDy3o5ZJl
 qiUD9
X-Gm-Gg: ASbGnctBZuMBYiTI/Qd/LZdH485cjDShmA3wgtSM+8sclCfiTVLzncdu2mqNlkcvEGC
 NjLaQoc2CAn85ysndIid3EqRoh0m8kkfw2rVSA0Lkxr1PCFAVvBRkvDullwFuSk+dwqkKE46MDM
 1U+pNil2Bstt5nHNqpXJ9bd2FO/Sd4psJpY4ORfx9GINX67uOTHbfjckxGfowkrQjGPE/rWQGrX
 yhwTwCox1Umi5KpqZh9QCWgUOTG6koizWsbOcMGMg6EPrK8JSAed2A4FiXP6oomNO8pSjLU3HNL
 X5ktjKlXm43nQuvYFKUZrCsiWo7p5c6FX1rH6eW/1AljaZ9BfGJqyeO0xsMiYbFc7eqCHn1vxbR
 +WCRSBfWINSQyf/FPz3uELcIBi6SwSNXTlXL4BSVE0lCpVuGVVfHXty5p
X-Google-Smtp-Source: AGHT+IGi0FYoYLj/LYiZMNxK736V6JmSe+ADIWij5DqXb1JBnzPukUaNQGu7yAjuVL6E1Uqs7CTiLw==
X-Received: by 2002:a05:6402:848:b0:62f:337b:beed with SMTP id
 4fb4d7f45d1cf-639d5c576d9mr21785137a12.30.1760446363483; 
 Tue, 14 Oct 2025 05:52:43 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a52b71438sm11004782a12.25.2025.10.14.05.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 05:52:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF8C55F812;
 Tue, 14 Oct 2025 13:52:41 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v7 00/25] tcg-plugins: add hooks for discontinuities
In-Reply-To: <cover.1759744337.git.neither@nut.email> (Julian Ganz's message
 of "Mon, 6 Oct 2025 11:56:55 +0200")
References: <cover.1759744337.git.neither@nut.email>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Tue, 14 Oct 2025 13:52:41 +0100
Message-ID: <87a51tlk6e.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Julian Ganz <neither@nut.email> writes:

> Some analysis greatly benefits, or depends on, information about
> certain types of dicontinuities such as interrupts. For example, we may
> need to handle the execution of a new translation block differently if
> it is not the result of normal program flow but of an interrupt.

I think we are almost there. I see Richard made some comments and there
is at least one re-base fix to make. I've also left some questions on
the test cases.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

