Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77A8D68BCF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 20:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tC2kW-0001pW-V9; Fri, 15 Nov 2024 15:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC2kV-0001p8-4K
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:16:59 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tC2kT-0008Fs-Hl
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 15:16:58 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5cedf5fe237so2632768a12.3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 12:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731701815; x=1732306615; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0DZ736icizDSiNlqE5YudJECLdTkNwJS11uCyrvNjz0=;
 b=h0qH4rJZBK1d4t3jW0nrhDN5S2OUCV9tpWgQlS/6Pt3No5QxLKcsJLw/Mf9wGL3fXK
 R6AcyromUXwlpaEJKdxpa4Q1+m/2aTligGJ8pWAH/lQcx9cSeOD60Jk5IESdD0rpK+dd
 qVccbeVNC/asGlAXNd0ZfbZbCxLw46e5y0g74pnweStabCKmOyR1yaGLVk+OsKjKWLy5
 sKd/oqejFU3zraoHaZm6Wzq1VcyVYzS1JKDWZCxSJXt5sd2XTtX0NEWWFCisdwvtBu1Y
 Dc3/dMfFNkznuvBjz2Lx10yaj8/wUwz2YIbVX7n+ZKOmvTafpDEh6gnIK+6fNK8wFCHE
 w4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731701815; x=1732306615;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0DZ736icizDSiNlqE5YudJECLdTkNwJS11uCyrvNjz0=;
 b=SWse/KIcgVBkopTKvUAPRg01YcfLBmsoDblsxxKaTWdFaqlx4fdlXoSRuB/4DW377i
 vefQ+3u3TOVMtXMEAGyS7w/uOAKltrH7LsbCtH4J4xImcn52f1oX9COZPGEwxBig1c99
 +DiArKlGedzCzSOxo5ATY4zvBOrvAQtethuNdheSEk2RZPwi3EuDCPG5+rq1G+6Vh+rc
 NMvtPsJumMQEyKXfwb95XOxrUfDyibyZJz0imjd62ms0J6QHvI7SqR30yWWpDQZzEuU5
 epvgBr2gipw1AIInd6Ghx6dVJCnUiYMbEonKy3afn1f3tr4uVFg4Byiy+jTpfGgcB3HK
 RG6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS0AeaZNODNEwlM7nKM1ORUm1+srXkvLs4Wu+twyjvgN6HBtC2dELy1X4fDhG7ptXPQnF9NULdzomk@nongnu.org
X-Gm-Message-State: AOJu0Yzf1jdaIyf8VMKSxqe2iIGWVcLdtPHFxVvApBTY3v89yvB7yZg9
 o7o6CK6dtfChC85Wh9GcDpdeCybnR0CwQh4kksEUga30Nr0KL1SLE+Nxo/kPLbxpNT7zDTf0jME
 kT7ymA+lXXiXwd61UD4fg2+ymJFYOImZkLiIG9A==
X-Google-Smtp-Source: AGHT+IGbvtxCO1hdEUdh6bL3O1ZUZgv+DRaP2UelWtxP1e2a5bZVGnr3H55ndXEjrE+18Fr+P+UYxKtwEXAta9/H8Vo=
X-Received: by 2002:a05:6402:2706:b0:5cf:924f:996d with SMTP id
 4fb4d7f45d1cf-5cf924fa1dfmr2053645a12.7.1731701815280; Fri, 15 Nov 2024
 12:16:55 -0800 (PST)
MIME-Version: 1.0
References: <20241114165657.254256-1-kwolf@redhat.com>
In-Reply-To: <20241114165657.254256-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Nov 2024 20:16:44 +0000
Message-ID: <CAFEAcA-y2K74jbPwPwrCo=OfCn_eJpGskX5KVivAMxzQXLThrw@mail.gmail.com>
Subject: Re: [PULL 0/8] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Thu, 14 Nov 2024 at 16:58, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:
>
>   Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 378a645b2f6125b1bdbd1fae3e8f30452d5b5934:
>
>   vl: use qmp_device_add() in qemu_create_cli_devices() (2024-11-14 17:55:51 +0100)
>
> ----------------------------------------------------------------
> Block layer patches
>
> - Fix qmp_device_add() to not throw non-scalar options away (fixes
>   iothread-vq-mapping being silently ignored in device_add)
> - iotests: Fix mypy failure
> - parallels: Avoid potential integer overflow
> - Fix crash in migration_is_running()
>

Hi; this seems to cause an error for the avocado test
tests/avocado/hotplug_blk.py:HotPlug.test

https://gitlab.com/qemu-project/qemu/-/jobs/8387009365
https://gitlab.com/qemu-project/qemu/-/jobs/8387009383

(12/51) tests/avocado/hotplug_blk.py:HotPlug.test: STARTED
(12/51) tests/avocado/hotplug_blk.py:HotPlug.test: ERROR: Could not
perform graceful shutdown (17.16 s)

If you dig through the build artefacts you can find the debug log:
https://qemu-project.gitlab.io/-/qemu/-/jobs/8387009383/artifacts/build/tests/results/latest/test-results/12-tests_avocado_hotplug_blk.py_HotPlug.test/debug.log

and it seems like the test sends a device_add command over
QMP and the result is that QEMU dies with an assertion failure.
The relevant device_add is

[stdlog]   "execute": "device_add",
[stdlog]   "arguments": {
[stdlog]     "driver": "virtio-blk-pci",
[stdlog]     "drive": "disk",
[stdlog]     "id": "virtio-disk0",
[stdlog]     "bus": "pci.1",
[stdlog]     "addr": 1
[stdlog]   },
[stdlog]   "id": "__qmp#00002"
[stdlog] }

Avocado helpfully hides the assertion message under a rock
in a different log file:
https://qemu-project.gitlab.io/-/qemu/-/jobs/8387009383/artifacts/build/tests/results/latest/test-results/12-tests_avocado_hotplug_blk.py_HotPlug.test/7f00b63ed810.log

qemu-system-x86_64: ../qapi/qobject-input-visitor.c:143:
qobject_input_try_get_object: Assertion `removed' failed.


I'm guessing this is Stefan's patches since they touch
the device_add path.

thanks
-- PMM

