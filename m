Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FA5D78336
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 16:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI97j-0001tg-6l; Mon, 02 Dec 2024 11:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI97h-0001tK-G1
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:18:09 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tI97g-0004vy-0e
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 11:18:09 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cf9ef18ae9so9594491a12.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 08:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733156286; x=1733761086; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZkFf+8xdrP7asRAatMX7VEEEUqL8YGc5jzVUJZnAZvo=;
 b=Awz92qyE8e5iqzpW5bNgycl2LV69vKkvUmaFH9jxfTDoYm9QIfDmuQIoUpRAvkA8xT
 vZ+aGyDagrdxZS41F+b7SEJIPeg4fEC6igre8/8UxiHt9O57bAmRCApQ0gdk+bngQqlZ
 O4jVp99Wo95CSK7E731t9XjKn+on9qBnRGwx01MlplXeZLi7oJVve/7R/o+qvmi0RJ7h
 sWYBzpOLie5EqvlN7jONJ8X/lUiwg0OXN4AV190RqqrXWmE66iV6xqurQCP5RNH7lyUL
 0WNcQc6oor8v1GxjZWSdKZrIRkECkJOQn5PRABfvlerPz8rIvbZ/kIAcaWDByr8McEUv
 bG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733156286; x=1733761086;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZkFf+8xdrP7asRAatMX7VEEEUqL8YGc5jzVUJZnAZvo=;
 b=PutSo54RrzlW8441/q/UIxSro1zyEO9NhQpUDQTzGCNeZ6IJLEUHwvrUamIobRf2k2
 vqzSpNrHmzFzYOaODE5sw7K8Fqb1JHYKR8xXQTtdFwvlBOIUVoCfFe1OdwCArCjSHinv
 rlTztQ8h8pg47bU0++7mhvMlhB3pMD4KhMohSt/1obGcN4A068iJDqjjeXrIVtemz7M3
 7od1WB12EbhPU9Le+ThTE8m63eBg3EA7qjRWI5qSP6UPEW0ZcboJR9VitcLnNWdZUrw8
 RCJXb5pv5vpbiL3U9yPUgW81ip73jiUj/e0MTOsrqSxulmbfNDX1szo7ZjU2zthBwdBk
 yIdQ==
X-Gm-Message-State: AOJu0YyeaDA2hLo4jIDJJKKwhGmASj1pf7m5JhGjeoPazpvsnFi/8hEo
 QKjXEgyx3bTheSC5klQu8K6juVmVid7pZYeLLZON/brnWKXecUKGQ+9nSH77D0hdH5E71CEtDD0
 TAjV3Tqf5t41/BUE78EcsiASkzsBo1IVeUsQfAzMdQ3cxWXCp
X-Gm-Gg: ASbGncumGG1FLVSIx68705MmRledtlIvywCdgrHtjuBvx+6s7oGALRs17CiDZQcsxyM
 C2cvTY2hRtsW6P1hWsqnfniQxBpfBwSHq
X-Google-Smtp-Source: AGHT+IFg5E1Ep87Qnttc83vaemLzGzW8bK512idvR0RJ+gdQebM2uCM3uCbupd0V+aAqS+vIYjRoTEx/ax88ihFQu7U=
X-Received: by 2002:a05:6402:4305:b0:5d0:9ae9:587a with SMTP id
 4fb4d7f45d1cf-5d09aea70d4mr20300845a12.4.1733156286144; Mon, 02 Dec 2024
 08:18:06 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2024 16:17:55 +0000
Message-ID: <CAFEAcA-t2xj9MD-U49TnYku-jtFnbiFSAvabh4RKxk89ZsuqBw@mail.gmail.com>
Subject: reminder: rc3 is tomorrow
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

A reminder that we'll be tagging rc3 tomorrow. This should have any
final bugfixes for 9.2 in it, as we would ideally like this to be the
last RC before final release. If there is anything still outstanding
that isn't already in a pull request, now is the time to let me know.
Pullreqs targeting rc3 should be on the list by lunchtime-ish UK time.

thanks
-- PMM

