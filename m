Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCCBE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 12:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV93D-0008Nr-DW; Tue, 07 Jan 2025 07:51:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tV933-0008NQ-VU
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:51:07 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tV930-00051C-5Q
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 07:51:05 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d3e9a88793so2814652a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 04:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736254260; x=1736859060; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r3tNCIod9+xZ6YFYPgaeZe+OWDBJ5yU6pC3G+GrD1EM=;
 b=GG3Fx7pse2lw3fkP6pBER8zK3cqq8GKIMT7BlQxNbVNl1f7/DCFmLKuDu3W4KIAGz/
 OP7+cj15nUtaiIQ4oxy+tm5qZ1xOWqCAL2reB+/oA3UIBKJH47i66Qbe5oGJ3H+D5Ivn
 qqu/bMvHrGuFmjUEsZWrbSHexx7wkNGoV7HXZBHzylsC9uPCWCsnhRbxy12sdD7b5iiJ
 IuCMgBt30HtIzQbGfOFaSXhwGvXWt/2FJxKRPputYoqVRwZQijqjKh7IvzFw0wt65CZa
 OQej+ix4mZyGT/Q9iCvGx9e1A4JEplbH86LJJZaQXM5AosWfKb8hekW2mumxyXw7N9n3
 A5+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736254260; x=1736859060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r3tNCIod9+xZ6YFYPgaeZe+OWDBJ5yU6pC3G+GrD1EM=;
 b=eW6d9OXMwCWMNXPjTfhk2XXVG15jZrKpLbicTpvntHAhvzS7jOF4wE0PJ3ViuU3uY6
 e6tZ/dRjJsLzOXepyHe9U9p+tfo2IbChvtOUenV4n/yllEMxQNUOsk+y7oNvD9HMgd3T
 5+1qfwnWSpmrYARi7y8jBD1C/bXuyr7o1JF+f//R6nojS5DzP1VahpBKUvQxZL5A0qCY
 +4g3ozjBenkaJ0diz8PHqYvgPiiyUt8ZuHG7CMyQ0Ke30PFAN3nPNRzRZQx9FSHecv9r
 O5BdWJTVpE0b4SBotyf4aag158Cq/X5n8xiRu14WPE5PKfJYBhh6I4bZlwAzf7KonPIU
 QatA==
X-Gm-Message-State: AOJu0YylAZheBbJuRJ9VCS47grHhT+bY5kyxqwkAK4OaFYxfiFVg+ZQ6
 OgcZ3x9CoFK/BdgrGvGmIiOr/BUpuYZBMXHHygA92MncgR8hIfnUSTzVwpEYDruMxQOXaD/rhYy
 uTJllqwYpuaLkgj9ZholAakjCrOcZyg==
X-Gm-Gg: ASbGnctyVRl+LqM5oBgUZvZbrVgaI3oG+WXppyz69SiSiFHuoP+Zz6XCU6yb/UgU+wf
 jjlRfFaKTpGHnwfeuMfd9dawRFkVyinqJxCRc
X-Google-Smtp-Source: AGHT+IHX00fxpwzadurkSQmtfKt7w7kSFuJM8403IBwIypUbYKfrKvoyclP2hC42PnlgCQrW3ncB6zzKFeoOzaGSzak=
X-Received: by 2002:a05:6402:388d:b0:5d3:ce7f:ac05 with SMTP id
 4fb4d7f45d1cf-5d81de169a3mr55649465a12.31.1736254259570; Tue, 07 Jan 2025
 04:50:59 -0800 (PST)
MIME-Version: 1.0
References: <20250107115245.52755-1-thuth@redhat.com>
In-Reply-To: <20250107115245.52755-1-thuth@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 7 Jan 2025 07:50:47 -0500
Message-ID: <CAJSP0QWxqDt0F5Nd0AnL4Zg=h_eec0-2-M8TbU4mCMU6AfLcdw@mail.gmail.com>
Subject: Re: [PATCH] tests/functional/test_x86_64_hotplug_cpu: Fix race
 condition during unplug
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x535.google.com
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

On Tue, 7 Jan 2025 at 06:52, Thomas Huth <thuth@redhat.com> wrote:
>
> When unplugging the CPU, the test tries to check for a successful
> unplug by changing to the /sys/devices/system/cpu/cpu1 directory
> to see whether that fails. However, the "cd" could be faster than
> the unplug operation in the kernel, so there is a race condition
> and the test sometimes fails here.
> Fix it by trying to change the directory in a loop until the the
> CPU has really been unplugged.
>
> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/test_x86_64_hotplug_cpu.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Thanks for fixing this! I'll keep an eye on the CI job status after
merging your next pull request.

Stefan

