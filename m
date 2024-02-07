Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882EFC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 15:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXjRp-0006sv-3Q; Wed, 07 Feb 2024 10:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXjRo-0006sF-4r
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 10:02:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rXjRm-0004Fq-ER
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 10:02:47 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40fc549ab9bso6258075e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707318163; x=1707922963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qgu9MGsdmjZQrVc+7nYOzECgxyqU39XM2Lj7rTWqRPU=;
 b=w5a43QuheYPkfNEzTNZ2EgkLEkfOvgoMKscRm69CEpNao6eaKWZagay9v6+w5fxR4R
 fw63/UtYm/Uc+j5VkFIL2pBVvqaRmzH8ySJtVYo3/m4y8OooMKOO0vjIWiTUKx7lKrrE
 Zk97X/har6VQ8+lkZdefx6wq+E9DWGpiAyOpk2WWjFKbhfShCRImxnLv3ZsyFNvS2tqy
 4WDDvxBnCP0Q2LqHvzGbrfryWuTcDHs5uLOi+ZW4UU+2k8TUUdE0Fhm9WSX0GzcmGqYf
 nQ1O7ChvNjCrPW1O1byuZIyBhpjM8l1F+glibipluh5FhZ39JqI9pVyU3mc2fCk1Cvhd
 9Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707318163; x=1707922963;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qgu9MGsdmjZQrVc+7nYOzECgxyqU39XM2Lj7rTWqRPU=;
 b=csCseHyYmG8HSSiOERAhv1v5/2XP2/fXW0zugodl/CNXg6CE/yAlbd+hjBHpl7H9rY
 tLfPFPpK4tFB9ALUoBtnKM3yOmE5Ewat3wQndREnvjwAa2SyYin8S68kzExoFnOkydLQ
 jvLVbqJfUioabHiROq2ZCCg9PkSPn5U/FlHdLxNJH2jwTnpW+w3RI8XJAbMEtNX6o7GD
 muDON9Ktbh4btD5LulOAjnzVTfobDP7B6NYBuUYVbmfeRWAg+hgpjMC/5WdV5RjnIvG6
 kTv8zPJ8QPzw0T4IkAxyIaGnG8cZrV5wHGYYBrpj3oNNN/1L8pYfGmHkfkwEZh3nomEK
 +T4Q==
X-Gm-Message-State: AOJu0YxBTpQozG+aXbanhvX7gGTVoC+AaQ+Gf8awCwFaBnRtRAFgXREp
 izg0z6pZAz18Ecg8eLrpQvZ3TzSlZPcssak9AOgxqhnXIyZBavAPmEmQtXchWbI=
X-Google-Smtp-Source: AGHT+IEGZr7uDm3vJJTQZIKqlhP9IDV/Wbo43R0XWSWUizQxPtnMU+v2jNSOIxeMcuissFdj5DjXEg==
X-Received: by 2002:a05:600c:13d6:b0:40e:aecc:25ac with SMTP id
 e22-20020a05600c13d600b0040eaecc25acmr4592884wmg.30.1707318163660; 
 Wed, 07 Feb 2024 07:02:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUCgHp/GLgXr5Gpvio1WqaKJjiQGfwEBCVpSicxUjUxJ5/5R49yLyJdA2XxgR9upI/rurDA0Wwn+KUUxPP9NIi6guWBiG2PGuJ0K8xyZDGGeliNpKOfU3TF2XrgHJ4BN32pwg/77dSUok7fIILJ98DfXlEo06R2Uu0PMzOGac0BQsf2ir9dnA/vIF2r1xZVR+mmEs43gb6apsynHjYyt5+UIoW2w3cnGUQaLl0b8vcAbmTUBU9Rnw9jn83/z6UuYnvRXhvl95iflkU9TR1RZy5MH2GMu1XyAYaIUTcIoJesleJ4266eK9xrQIIRbvh3XmjDopQH3h2jQXtKVVqBqzgVuwQJgXVb5EQObggpsjk=
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c0a1400b0040fd24653d4sm2373228wmp.36.2024.02.07.07.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:02:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87E1D5F7B1;
 Wed,  7 Feb 2024 15:02:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Ed Maste <emaste@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,  Warner Losh <imp@bsdimp.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos Santos
 Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Kyle Evans
 <kevans@freebsd.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/4] make vm-build-freebsd fixes
In-Reply-To: <20240206002344.12372-1-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 6 Feb 2024 01:21:59 +0100")
References: <20240206002344.12372-1-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 07 Feb 2024 15:02:42 +0000
Message-ID: <87sf24l3l9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

> v2: https://lists.gnu.org/archive/html/qemu-devel/2024-02/msg00890.html
> v2 -> v3: Structure the meson check similar to have_asan_fiber;
>           Reduce the context size a little (Philippe).
>
> v1: https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg05155.html
> v1 -> v2: Link with libinotify instead of disabling the inotify
>           support (Daniel).
>           Use a bit more context lines in order to prevent the
>           incorrect application of the test patch.
>
> Hi,
>
> I needed to verify that my qemu-user changes didn't break BSD, and
> Daniel Berrange suggested vm-build-freebsd on IRC. I had several
> problems with it, which this series resolves.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

