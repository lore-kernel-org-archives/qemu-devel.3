Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67775C0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 15:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQbu-00036U-R5; Mon, 27 Jan 2025 10:01:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQbo-00030l-TW
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:01:04 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQbn-00008w-9z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 10:01:04 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e46ebe19368so6367496276.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 07:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737990062; x=1738594862; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+C5I7CFoAxs4fjig91TFCyeC8lhhlKttbQmuiJJyAI=;
 b=Fbj/n41QOsqLyc6ucPpBd0b8zI4Cu1VvQMy/h22T/LkLIUA7r4HyFkfDhPWVUuKElu
 4nhnEpWWBooiyMyy9gszilTACH/t/JSISKYHQXXhUxJhEYusbcM5h8E+M6ah/77nEsDP
 yqfbTCtZKpjdGzoYb3uiyoTHbt3Fn6b4xxHJImVgAXAdyMMh1EyPPBd/PDkjQbPvUKLn
 hSAxf9YQJN4aPNdd2mOn0Ct0cLQ7rNgGg++oVN/hZbq2sybsSi0V8ZukpUxZHWxD6LJg
 EVCwue/QZUnV37qs9KDZr3J+mXs/GFvCFDjvKhs7EiwQTMqtEJeCk5cJpIBTMVNayyBr
 muKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737990062; x=1738594862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z+C5I7CFoAxs4fjig91TFCyeC8lhhlKttbQmuiJJyAI=;
 b=R1tLv8RWzNUC6wfTx/ko6fhYj7VVb3ZL7PI7EhHITESW0OGYLv95Pbt1xLMGO6Vo+D
 Bi2Iiu2q1ZSwl77vlGDH1RiuMSeP8ylrMBtlSxebAI2trn6jfjGTldlEOL3nsep+XYcM
 f9Z/0Td4iXJGH7vRzJOQmIYO2A7b2LGPK+e2pf5+lWG56FrJfBTs0K74YpkiaHGh93+a
 3pjnvzXDx03HPmgMbpFGgrFZy0+VudqXtInPSG2hsAPpP6noUJHAWptcdPIBJw0BmLUP
 EPY0jbK8hpUp5YPZNRt4jnSSDoT0E874Jr1edbqTUBY25vcQykkx+tPeRURsT259o1/Y
 HdFQ==
X-Gm-Message-State: AOJu0Yzx3NAgdj2VgtTXX0tzqqlu9Cw00GdPHSoOz2T2ATb0qrIqQkZK
 7qYQA3NQkl9hIo+u+nPc+9shIbtGdmdJ2QAClj3bcOmyW4bO+R27VO1W6alYJ8mOIRRjQ/GCklC
 z/fWXZwUxtUdrUkxuD5Vabokd3dUHO/EfChQ5wsuhBgIR/2zX
X-Gm-Gg: ASbGncsdIZ2Bz+HeyDl8831NjA/wu8bOwzZ8QQIIsfFWt9LXQvjYGYz2AE/LertDbJK
 HrsuWtVZpZFwd3FrgA42DK0BhBp/wxLMlwB0ayuN81794tK0oj8lpLuOMGtJDwqw=
X-Google-Smtp-Source: AGHT+IFjyIdNwvPG36Lvi2VJOj/b510smma0eJaNLoOo4sfQxle7eudVWyqcZjdSd0JscqruOrJSXwjyqRXf49w3jKA=
X-Received: by 2002:a05:6902:2b8e:b0:e57:a314:cf2a with SMTP id
 3f1490d57ef6-e57b1047a16mr25669177276.16.1737990061479; Mon, 27 Jan 2025
 07:01:01 -0800 (PST)
MIME-Version: 1.0
References: <20250124101709.1591761-1-thuth@redhat.com>
In-Reply-To: <20250124101709.1591761-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 15:00:50 +0000
X-Gm-Features: AWEUYZn3aSKleID4eXj9a_tVllj3b5eCTUPBsh8-6cqEBIGegnJd0Jxa2lCy6lM
Message-ID: <CAFEAcA8R00Y1w2W6NnUTORXvCkMijb59kyXLnyLXPWuG3-a=Pg@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Add a test for the arm microbit machine
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Fri, 24 Jan 2025 at 10:17, Thomas Huth <thuth@redhat.com> wrote:
>
> We don't have any functional tests for this machine yet, thus let's
> add a test with a MicroPython binary that is available online
> (thanks to Joel Stanley for providing it, see:
>  https://www.mail-archive.com/qemu-devel@nongnu.org/msg606064.html ).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                           |  1 +
>  tests/functional/meson.build          |  1 +
>  tests/functional/test_arm_microbit.py | 31 +++++++++++++++++++++++++++
>  3 files changed, 33 insertions(+)
>  create mode 100755 tests/functional/test_arm_microbit.py



Applied to target-arm.next, thanks.

-- PMM

