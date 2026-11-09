Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7E606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nbO/Koui
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW4e-00076u-Ty; Mon, 09 Nov 2026 15:34:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackyli@google.com>)
 id 1xQW3E-0006LA-At
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:33:20 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackyli@google.com>)
 id 1xQW32-0007mQ-VB
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:33:02 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b71ee00f0dso236a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794256376; cv=none;
 d=google.com; s=arc-20260327;
 b=i3ohz8jhRxTSg/QfkvezYZm6ctR2evAZ1PpBfETXL+89bwOhkNhb6qJZ9NN6dtKYpv
 Ke/qEtp6VxfIn3/8m39CYhq/HxkJMXZUq3+7JBpRs664r8igVOjGocGJFeAglRZ0l6NI
 Qcg0oUsyvbUzK9mUMWZ8JD19gZnjMdKkysWY4Oxf6opaIdDQGO4cCPYFZzu70hH5aRb1
 Zo9ZRli29NWA4c5RisA0+/xYEvnOp8jyBkiUf509eg60nOcmha/JJn0AIa8uhU2JW2+F
 tD5vccvf9TtOUSlWg4+Ij0HpsQEEBFfo70ji40iwDTyLu3eDV8mNVApknuar2d6ebLc2
 Z7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=165JbOwrpL8kCvVqo1jNXjLNxKVGY9GaIcI53TtUHLE=;
 fh=nXKOFFq0bf43oBX6ZOTUnSs1+4z2+WY1bofxZGtCs2A=;
 b=iTkLm1U8UmX9427t7FTkICZhdLzMfwPFj8/Ptm8eH/mctsw+cwvz1xsSLDi343HISt
 lXf//pHfKn/XZPHkcEtVSF20Mar1XqSn+7vkvFFsecGEIA8FAmbnx7jTwQVGGQ8IUX/s
 Dxl91XecBX8BddyqCqsOeauhFXNVsBmEO9kHeosXFnL7+5/1GOMC5LYo4f6lJ0IOz/po
 OtrdO+I8iB0JUtW5MYLNGPZHm9SIZekFubgv3LnzkuHGdwpoghNtUzZBuRYbfxj04vRM
 yrDZcz6Jq+f4AMCKQyUquj5O0D4aLUNym08sGD+NmSfoz+IBrDexXjhsey74q5pIrlqf
 hu8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794256376; x=1794861176; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=165JbOwrpL8kCvVqo1jNXjLNxKVGY9GaIcI53TtUHLE=;
 b=nbO/KouiqXHyqn5P4rLICZokC7eYGLKwJbCjTBt6JI0uX5owL5Cy9k0y/JUgmWP8qN
 ROdaX5DEKUpZeZQCQR14E9woW1LxgUkRxZcaX5PysNdnVjO7BABPZTfJxr5PO+8+WKD6
 xJKrS3EHTCBjs3KNT/T6EQYHzVcTTLbytf6Du/OfKICPSe5ipXKX7KCshpdO6nlYFz4a
 ywXfR8EVxvUIltKaRxb18C1O4QEkRW434dT0WQ0XGn695Pmmw90lH5XDShzwtxcW5U/u
 h+B+iqAEGubIvK29tyKshs1eO0s5pU9bLb7a7Pqx/5LVbE7vMbp6Y6fs5nCcezQA6i08
 +2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256376; x=1794861176;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=165JbOwrpL8kCvVqo1jNXjLNxKVGY9GaIcI53TtUHLE=;
 b=aaXgbQfDSxIZnZ1STMUcrm4MEitqUfz/oH57fZ7QZlSHQx8eiZdwwZ3JcAFhAUh1my
 krrupRCbsfWRCtMuc9ERZMGr7f8emJGYTTGCjdHRQ6jpyv7Q09IXqNrwX7olzlXe0Vr3
 C97kkCD2OQHPg9zUCaaWN+wZbGzwP0aXh6cVvSArY0m9BZAJ26jWzQzFQvR3hqzCyV6Y
 WOlg+SDVGJJox1RQyIwmaDZ42FC66XgHd66V85MnYqF7KZoeE7r9hQ/tf6+FF4G+LTSW
 DSCmxYOTQ6nryzUbuEj0mPIx9kOjCAmPE7jn64MvJA8KvtHkfjNf++VTJFg45GMHpWkU
 O0IA==
X-Forwarded-Encrypted: i=1;
 AL+hErFn/auyQuNWS4UEHJnSqpWLbVIYvo657JyLmj1JR5g3O9kT3OchwvqdhJs2ysQLiuSEqfKOzc9CgbG9@nongnu.org
X-Gm-Message-State: APuU4Z/EYGcT6ZsS1rsQXZ0920jrSlB6+4fsH8200mXREySpzoSTbooL
 3/9IjC/jkQVxY0EtuhfIYtePPa7eSYA3KkjKfN79mL93BIG/uukAPfq0rexrgAMRFlFyyYBqXj0
 PemyBnVga/PPSZHFCAFaakpVOzK0LZvV5xDt5gJU=
X-Gm-Gg: AYBFou3CKN60d9nGlJmN2p06+wgCGdvlYN2v1BOGdvcQrrPIidd0brtWeBL6FfYqUNf
 +OPFXhhlIWRkxopK8A62pX7VfknTbCp8yHr0drwHtQR9oQRNG5ubbOk8GOYnDgeon/wq7oQNe9a
 oH3qPap9uETgA7Vm2iShNEQ/P15/bPgRyG/hqUSl+FnCd56wYKjHfAszOdanw8bywX1BMcRdJIm
 NOggLb82H2+ZDYLEhSqC3+NMa8fHc0BeArspmr5HRPRkfer+ccTPriWW9mOqY7lkjziw8eX4Dp0
 B5FvF1hbrpmtaDCeIyDE+RrDOxZ06iofXglwGLIQpcPqfvf+c5u+Xxr6XLI41zNA3OObt4mZZPQ
 /+2hNf3N8e2dtj8hRP9FxIb76ZvvrUwQOJYs8d6aP+K2nL2jL5bPgLbzpyzkqeys+IFjz
X-Received: by 2002:aa7:d8d6:0:b0:6b4:629a:6352 with SMTP id
 4fb4d7f45d1cf-6b75782b234mr12816a12.5.1794256375885; Mon, 09 Nov 2026
 12:32:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260818-feature-pkey-dev-v1-0-8c0ef96a4da9@google.com>
 <20260818-feature-pkey-dev-v1-2-8c0ef96a4da9@google.com>
 <ab4fc31d-8605-4556-a51c-f5180baa2d79@intel.com>
In-Reply-To: <ab4fc31d-8605-4556-a51c-f5180baa2d79@intel.com>
From: Jacky Li <jackyli@google.com>
Date: Mon, 9 Nov 2026 12:32:44 -0800
X-Gm-Features: AclHuK_zmTRiDksS4Mpg0-0K_IoPYaWenW3iu_ZRy33xJO17sQCov-t1LMYoZnQ
Message-ID: <CAJxe5cu9-iH5KPZnqfmWwtBtYgitf5W-FHNPMbwN7uS-7=knZA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] kvm: Add guest memory Pkey initialization
To: Dave Hansen <dave.hansen@intel.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org, 
 James Houghton <jthoughton@google.com>, Mingwei Zhang <mizhang@google.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>,
 Brendan Jackman <jackmanb@google.com>, Reiji Watanabe <reijiw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=jackyli@google.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 8/18/26 15:03, Dave Hansen wrote:
> Is an environment variable a normal way of enabling qemu features? It
> seems a bit unusual to me.

It isn't -- it was a shortcut for the RFC. v2 will replace it with a proper
QEMU option.

> I would also guess that you might want some kind of an enabling mode
> that lets users opportunistically enable pkeys when running on
> pkey-enabled hardware, but not complain too loudly if they are unavailable.

Agreed. The plan is on/off/auto: "auto" enables it when the host supports
PKU and a key can be allocated, and otherwise falls back silently (with a
trace event); "on" refuses to start if it can't be enabled. The default
stays "off" for now.

Thanks for the review, and sorry for the slow reply!

