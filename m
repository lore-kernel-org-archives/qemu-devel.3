Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A61C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhC6I-0001Ds-64; Mon, 04 Mar 2024 12:27:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC6B-00014w-Qh
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:27:36 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhC66-0008BV-M7
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:27:35 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5654f700705so6476011a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709573249; x=1710178049; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OsK3RyZYZWUR5Z9wap8UEQcdWqcTcuK6eVhZpvw0fZA=;
 b=cdvVfi4IjsnacaLgwibp0wAbtQ4T8tR5RmJxVe1v1Sw7FUgj99LlEW5PixTyL6fSlH
 pyVyVNutoE6y8VtZf2v8IYYsKmBjhEwuQTirLW5CD6lddCCogLTvQFoFF6XldAHmUr3v
 lE5YyCNWwuZe6Co8kxVhxHInShpcis9h41VivJWoDPZKo0DdPfsFQv+rWazIqmI82kkd
 GngpTpDju71Wrr2DqnoBqeDkmEeitSVd4zq9K3xKPKxvdxA0lqNrWPzfGun0apiX3abc
 F/QfAFWvqp8emjjlygrdiFvAXJEpsj7WzhDMQL1WK+g2t5G/8ZFdVsB26Xv2K7IaMXrD
 9jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573249; x=1710178049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OsK3RyZYZWUR5Z9wap8UEQcdWqcTcuK6eVhZpvw0fZA=;
 b=FRRezYXk6Sqa0kYhNj+Hnuzx2tYqFOmCCPnbz5eWVAwGzHtrvtKPt9wqHGMq9Bz3Ko
 oCWEk9rJyHZ+wTFwAxtIrfccuyeTdApgia9lh+ddB4WQ0Js9yTX0tZl9OdHM8hW+Yxka
 b7+GWfNPyjZQsTqy8vBTklCTV6PLKpbNPne/Rh2L4zqTqx7kCi+fCXQXsZz38D0YaMgk
 t+Xy/J7tS7zzIL20JkqNVfUN74jj+BbIlT8MLsLAYcFJXVGZpp3DbyW6WQAc6XoTcoXW
 S2NDuihMD0no1uTOd7pwPDRZOkBKib5ECtZiDZvyuqh6uj5dRFcHxZERbV2VzSMKFlPZ
 P0mg==
X-Gm-Message-State: AOJu0YwqlYimR1NL7BDGluiRdTycaSiODLZBk14/3ctTUM6s7ehnFkao
 fRBMSWOoAqjnKty5XfqpbfSYS/2UoQUrQWocd+DO/BLvZWs/+mKzoqZnNqL74XNMjYeCqC5eyXM
 GzOofAGZYeHnEMFpOtDOP4mqEWg59U87pcij6Xg==
X-Google-Smtp-Source: AGHT+IGqHkjkrcp6BSQB8yBv/kAcFtMU3rsWdkfZMaNKWBhg783wHsBsmP+BCwkNUmGnPYEWXs9/zr4nLJ2Eszdb6pY=
X-Received: by 2002:a50:9306:0:b0:564:fe6b:906a with SMTP id
 m6-20020a509306000000b00564fe6b906amr6469473eda.42.1709573249162; Mon, 04 Mar
 2024 09:27:29 -0800 (PST)
MIME-Version: 1.0
References: <20240302010627.12998-1-richard.henderson@linaro.org>
 <20240302010627.12998-4-richard.henderson@linaro.org>
In-Reply-To: <20240302010627.12998-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:27:18 +0000
Message-ID: <CAFEAcA8fnKOzy=Z+KXEAQNLCfN3M5nGdxnQvJt_iRrWMmC2cYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] linux-user: Implement PR_GET_TID_ADDRESS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Sat, 2 Mar 2024 at 04:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/syscall.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

