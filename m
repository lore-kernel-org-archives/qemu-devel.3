Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8218D63939
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 13:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDkce-0000qn-0i; Wed, 20 Nov 2024 08:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDkcb-0000q1-TS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 08:19:53 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDkca-00085I-8A
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 08:19:53 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5cef772621eso8644355a12.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 05:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732108790; x=1732713590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=znWE5xJUoLsvveVy1LDnHfTbc4eDwLFD7E9DL5cBHUs=;
 b=FfHT/UaAILCgtpw4usUbskzyLukA0GXNx+sRRsYaXB/cbiiizc2cacp1lIvHcRo0az
 oZ/1BiyaSvkQqeXluFW1Moi18agS+zunn9FIDUSNJEA72a/lPuq+jJLhXOBSp7LoGSk8
 EUWGQGBIotnqI9hC54Cym74OOYKg1l2nM5yQFj9Gr/DkrfyYzwLL6HKaFrgrNsecRymF
 aDuGcR1pPTBgjp8Inz9nJLsnWOYATNzZ3ipXqxXSjAK0nBRsG85fQ9l485MR1FoiXNer
 MxCtRDbDv9TkDLr+XaabOWf0PIdMnC2qIyPa05f7IMrSaLYGE7pIKs96akNO4Y8ucjYB
 iw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732108790; x=1732713590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=znWE5xJUoLsvveVy1LDnHfTbc4eDwLFD7E9DL5cBHUs=;
 b=ICRf8OZc5xVTdWrcIzn71LbPD7jo6ZgSeMi7KOLEpicFXB6wF8D5w2LU4XV6KybLHU
 CcRDVyjFita6bUQqYEPw2QEqBLbxS7F+OQJ+6bK/niWhs7lkmgQbWRVSZSKpGyFSHvES
 Udv2BfMrRH2BzHJfyEsj3+s9zX3gbdk3v1c2+mGOh6l5ShVC9AAlNVZMcDd37jhr4vtq
 jaAiQLhLavu8QiHpZ5tumDo0WUqMpWcxZ/h9mw0x88PYTaOT5BlaM/a1JJxttzSTZepG
 zZZsEdnp8fn0hQ9qyTv6uCPjTRRF6jjAPBhSNw7JfIQqwJc6Qmc7cEUT1zvJ2Bq5ez8k
 ghgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNoMnLVyUeATtjyM43iOBTsD2q35d6i3XENYcpfKwjWaEa/eNeZ+VbqH92GzGyqcWoGnhk6Sg1l8l+@nongnu.org
X-Gm-Message-State: AOJu0Yy0XHj8fZu1TMULBGp0LOh+k5+z5T+gYgZtxuf/b1MJ0Mb0O2Kx
 6t5/qHdpuUP7rlQ3xBcQ2KrxiJgFaxc9yJD9rFPJKH8AqC2fxag6ePXJ7EeJoRRUBA/0EMhnYXu
 0X/UNU6Zjf1mYN0404ASlQYZ0SpLTXXu6iGFiXw==
X-Google-Smtp-Source: AGHT+IEVp7SBNfx2NeY0QKyGLicPBHsNgNjjvX4rC7n9Qmtlesb7vXM17bhMHA3z5Ay5mPaacoMNTgzGXYlBRT9f8CA=
X-Received: by 2002:a05:6402:5216:b0:5cf:c97c:8218 with SMTP id
 4fb4d7f45d1cf-5cff4cbe2e3mr1739396a12.22.1732108790420; Wed, 20 Nov 2024
 05:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20241120105106.50669-1-kwolf@redhat.com>
In-Reply-To: <20241120105106.50669-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Nov 2024 13:19:39 +0000
Message-ID: <CAFEAcA9M_-4=UdOTwV251qOxuELAxXtJW8QaZWTs4bUq7dJwxw@mail.gmail.com>
Subject: Re: [PULL v3 0/8] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 20 Nov 2024 at 10:52, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit e6459afb1ff4d86b361b14f4a2fc43f0d2b4d679:
>
>   Merge tag 'pull-target-arm-20241119' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-11-19 14:23:34 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 83987bf722b6b692bc745b47901be76a1c97140b:
>
>   vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-20 11:47:49 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Fix qmp_device_add() to not throw non-scalar options away (fixes
>   iothread-vq-mapping being silently ignored in device_add)
> - Fix qdev property crash with integer PCI addresses and JSON -device
> - iotests: Fix mypy failure
> - parallels: Avoid potential integer overflow
> - Fix crash in migration_is_running()

Hi; the hotplug_blk.py:HotPlug.test avocado seems to be failing:

https://gitlab.com/qemu-project/qemu/-/jobs/8423313170
https://gitlab.com/qemu-project/qemu/-/jobs/8423313162

[stdlog] 2024-11-20 12:49:35,669 avocado.test test L0740 ERROR| FAIL
1-tests/avocado/hotplug_blk.py:HotPlug.test -> AssertionError: 1 != 0
: Guest command failed: test -e /sys/block/vda

https://qemu-project.gitlab.io/-/qemu/-/jobs/8423313162/artifacts/build/tests/results/latest/test-results/09-tests_avocado_hotplug_blk.py_HotPlug.test/debug.log

Looks like the test called device_add, it succeeded, but
it didn't see the /sys/block/vda node appear in the guest.

(The test logic of "try the command, if it fails sleep for 1
second then try a second time and if that fails call it a
test error" doesn't seem super robust in the face of slow
CI runners, but OTOH it failed the same way on both jobs,
so I don't think that is the culprit here.)

thanks
-- PMM

