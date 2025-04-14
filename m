Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D93BC369B9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 19:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4PU6-00046w-Ih; Mon, 14 Apr 2025 15:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4PTo-00044y-4h
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 15:28:32 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4PTm-0004ni-D2
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 15:28:27 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so8156267a12.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744658904; x=1745263704; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=l1zzlrDIDwaTayR2kV3gq/FOGLB5fEU+SLShVH4iQ9U=;
 b=emYq6ylvb75YX6gVJNKB4H5mzbBQExEZnsKHbencOGal1LSRXyQUZ06RufB9Pf4pm7
 CaSvoD14cix1Nx9W4ieQhIn67X8oYL7hr/sXKJjzfAnjKn0ZJlPh+Gd81B2k7pMrcFKQ
 wWsKTb0Yg+OYiuahiZ/d+rF5rnl86z1mmvIEtviO6ZJC2VfgAtKUh+g6o5kAHfFJt2y8
 mnnsfSbHEE5ykpgodOq0aVW4zHHXLiJCOTS+44L7QqP7eS6XFB6bETAw7gtnK0DqEkII
 zv/kKvV6JbQt6pcQSGY1gjhsiUCxq85iE8ceWAAhouEK91TjHoOwvnyEQlAY4lt1B3Ei
 jzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744658904; x=1745263704;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1zzlrDIDwaTayR2kV3gq/FOGLB5fEU+SLShVH4iQ9U=;
 b=OKWPTVqIfm6rEgpGfsXtATWKkUgEXg6+dk8pqSay8VnOFTVw7WkU4xXiSZHgHmTYDB
 qTwqc5u2t87zJYpDu1hXNFDi5j7y0R3YJVOBJTNoKn6vLQ7hhGrauxbrBFC2wUu/73Wt
 8AHpdcbM89z5Ng/WbN7LKXcHxsZRAh5ENTv5CpQCWOW7H1zZGXe7m0HrucVdmPJhwWJk
 WacOtLTY0FYb8oBhVgiNjm53a5WX1IoM19TVmpCkLKD4uKo+RSQXJBozDwGjZI2Fjjx/
 VDwxTtIfgvadZq+pmPmO39nArMldPEHAdE2ZnGdPcyQCeLwP19gGE7yotRxD1O8bddza
 1Jxg==
X-Gm-Message-State: AOJu0Yyk62a1HggKzYC7RUPVlc5o4igqeSeE1T2iSYVJFfSQvJPfXCRU
 biilw5xoE30lhdtIX5i+6CvqN67hWrHp1gWpOFfVHhv3RroIgf+uaDuFQh3vltdtUokeOsRpDJw
 q0Q5ImpRqhNwExtaly8v+BwRikcyel01b
X-Gm-Gg: ASbGncsUy19HJStrv8Bb1kJHbStM9KbyhD4r4VZCm9wPLL/ushI3a+s72Fsl/8qWLqR
 lMAMWeUe4HKCAd18/u/GuA0MbCGqe+mSMKxlO8S5Svfikc3zcbcrKVmmwCu23GXOy7KQ2EXEChK
 MMVQZNpWEUrzGdE5PS35NLvxNa/fXs6Z8=
X-Google-Smtp-Source: AGHT+IHxSVWWZpinelYsTBhZir3QrzJKbPZzClqnmsVtJZy6ASKBjey9/HsVKJ6W3cwsNfX+2sgud0kR9g6HDhpRFMg=
X-Received: by 2002:a05:6402:5007:b0:5f3:816b:c0cc with SMTP id
 4fb4d7f45d1cf-5f3816bc1aemr11395913a12.10.1744658904037; Mon, 14 Apr 2025
 12:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250409131942.1706923-1-alex.bennee@linaro.org>
In-Reply-To: <20250409131942.1706923-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 14 Apr 2025 15:28:10 -0400
X-Gm-Features: ATxdqUEQ_8EYlclkq62GddDrrHXVfqTb4a5OeblVQQgunUMlyjeUfkHu6y-itJ4
Message-ID: <CAJSP0QVQ0JsUP7tCyTjbCusFe2xEBLzqS4CiTfgULx7=zFV8qg@mail.gmail.com>
Subject: Re: [PULL for 10.0 0/3] final fixes (tcg tests, plugins)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Applied, thanks!

Stefan

