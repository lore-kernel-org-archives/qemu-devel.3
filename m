Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801B8C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 11:47:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dFj-0006RB-Mf; Thu, 10 Sep 2026 07:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4dFf-0006R2-5J
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:47:35 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x4dFd-0000yR-Ky
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 07:47:34 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so44505035e9.2
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 04:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789040852; x=1789645652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Cu6kAUUrVGAjGbqzCbom5/mk/6/e4zh3ikX0viPTpQM=;
 b=UME0mZeHESX+odzoJBgjf4M/jnt7Bz6BWV/sb4E1fw1JoOmvWFtWRL7N7jgxzconub
 eOqSThVw/DToONCptYGeOCqmC/eEpdprxWF0LHV0Q9DYoFVoxxRIMex2JGIQs06+FuRU
 rxFfE1VNJj3Co8kW6jhEvy3d8BgTucXlW1aSC/MUTwq3772ycXn92c1GRGyNq0i0K0kv
 HYWmoBNmfnUnRJgoYb7ytW4dZofzwobuFMUiUzSOECYn10BRywPn/SnZxqgZ9DXiDVI4
 fRj8UqND7wy+QyjoEsNdXnbaLuuNXf6lgrtprTY1GpbHz89VAl9YHKod0rElnPo944Hn
 4DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789040852; x=1789645652;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Cu6kAUUrVGAjGbqzCbom5/mk/6/e4zh3ikX0viPTpQM=;
 b=R4zo9uqZhxlBYnO3io+/hD/QM0pjJmsUPRG4R6n5s94Xz+LV9RGumb8/cLaf0A5xu4
 Rnt7Joi6DEbQGDLLtySjfFwzug7bNT/ASQXiHqx8iV7MA+BmZ0YKpjV3QECHIZqviXxs
 ikwYch+yPz+MXYgnIog5H9dw5SC0wKyYZhGwzI5qzRXPbdplwPnUXN4eqA6imJEIKdVD
 3d+A8loVY2ZUxkunj2OD8XsiIcnxPN4eW/SJhbU4iqUZ2zFde+X78JafR1qsFB066BpM
 Uz+4tNvZH+l/xolNa65kCncuAFI7CMztStVh1yzZibM3x0hcbMPjz59iItwdsTm/bhbR
 thUA==
X-Gm-Message-State: AFuF++mojSQsw8xS2yx3aTaJfTK32WFjP4+Ud0zRMayD1V4rMgcT9Uep
 QWjTuP5WgW4JsIix9b8E9d6P1/eZ7Yzen8Co1+TAU0Ihi+OzHadeIzVcl818W5BXvzLrSUf5YCn
 pljhdyeU=
X-Gm-Gg: AYBFou0dzS+NeZivEKcg9kB9DRTuFsNdon/Wa4jllxukXEcQiJ0b4QX9xQzzfjF3oFn
 6Ng3kon7RX5zKQD4QBMWmrRvKcFRNuGFONq3TZrKl7nQszrUfRl6kjCc0/WFULuOoW2hZDjaQgH
 MyYqJCesOvDOZEWpko8A98YegWbohjubzRJTMf8rWaEynK0rXy0drBJIjtoeNw3hW2aTbLjyPgR
 nrsYlGr3PsMcdYSf8Iouic19lH6zyw+sn2semRzI8iI2Ap28IJjJz0zGTHGwnFcgV+e/E4wrhsK
 92hY/Absd+QpIrx1Rc2TPknw9uqGstxG6rLV18HPcBOii4L+OH2UYYgi30GWFWb5jyKoOQ+pcAN
 ASkhcAcR0XkfAChxWsLVl7Y7GIcQxUYMKEdfrqw7H0MPAMR+xaXyzy1v0XcO3UDq5QibUmhXPA/
 oCyXb2aO1LFCncd8SPZhFcvWPsJN0xFg2aMwg4IqDAsOqTDYTy6VwwEi+wiPjUWRaeBluTW98=
X-Received: by 2002:a05:600c:4e87:b0:49d:1df8:156d with SMTP id
 5b1f17b1804b1-49d1df815bdmr138491775e9.18.1789040851383; 
 Thu, 10 Sep 2026 04:47:31 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfdf6sm50692136f8f.34.2026.09.10.04.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:47:30 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 732645F8F3;
 Thu, 10 Sep 2026 12:47:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] tests/tcg: improve check for working cross compilers
In-Reply-To: <20260910100120.2076092-1-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 10 Sep 2026 11:01:20
 +0100")
References: <20260910100120.2076092-1-berrange@redhat.com>
User-Agent: mu4e 1.14.4-pre2; emacs 30.1
Date: Thu, 10 Sep 2026 12:47:29 +0100
Message-ID: <8733vh9vla.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When it finds a cross compiler, tests/tcg/meson.build tries
> building test_cc.c to validate that the compiler works. This
> includes "stdint.h" as a witness for working C library, however,
> that is not a good choice as it can be provided by the toolchain
> alone:
>
>   $ rpm -ql gcc-s390x-linux-gnu  | grep /stdint.h
>   /usr/lib/gcc/s390x-linux-gnu/16/include/stdint.h

Queued to testing/next, thanks.
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

