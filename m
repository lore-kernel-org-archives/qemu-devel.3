Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846D2EA8544
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 20:02:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzKK1-00051x-DC; Sun, 08 Mar 2026 16:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzKJV-0004wZ-22
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 16:01:29 -0400
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzKJT-0007yz-0w
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 16:01:20 -0400
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so10005023d50.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 13:01:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773000077; cv=none;
 d=google.com; s=arc-20240605;
 b=MNXslJECWk3T7lik/Q/1alHjMAIUriMFzQrIpJBfD/zwdRZDFvi5+EVzJkvU3/1G3x
 cIy+aR/sU4uggIsgOTTCJKLrrk1waPSDjK2xDwmHYUHNW5P2f6HtjnI935c3Q9q6Ge3a
 HOJni0/7Yv8F4fRMM6/SIshJG7AccOlqItSEVsgZMQZsguorr44YmookmDERuB5pRo9w
 7p9NqK04fEuJh+O4gjVFvhXC8J6gTAmf/a9Ud4VNRuzQAcKh0f97j2pUEI/v7xxkuYQo
 54csaBeO0RsPFwGiczCodu4Rh13aTE8GRpbG4KS8rY6MFMIOC4af3xEwEkem/g8hsj4z
 OgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=9bc3dDgxVp34vdvDvCS79W/jF4fvXXmgzLnO8vy1uMs=;
 fh=/dsQWE9qAzwcc+jTlwsRH4XYQweN91oJJenlTaim31c=;
 b=XB7GWXt2fruDGA+JJ+0Par9Ye1zkNjgR9t96viFdnzhwQviPaLHb95nA+fU0UvB04x
 9TSlZOxDb8JDp2SpTRmbExQdFVqcUif4FqBMmncvEzCNzisUxONt7lUE4TgLloJH4ANB
 /8IWU0KXz0/3cdXvtZzLnu15+i8M8+33wv188EnFdrgJQUCdtDVeL0tVtRNoelGC5SCi
 AuZa64ltEYqGTd4dP6gVQhpL9hUVmquQ6vTNzO8VwfSjeXILBr3arh7kplKuC5rCYHwv
 aVLvahOYEo1VYngLuCAH3Z97xDz4oRS+a11bNZRMuaAgQ8xEzLJLMch74y8X9tDLbKt0
 RzPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773000077; x=1773604877; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9bc3dDgxVp34vdvDvCS79W/jF4fvXXmgzLnO8vy1uMs=;
 b=wRFGTxcvE4Jio+S/mcz5oOk53qGw6vpOXqUIsey6I6r+LtqLrdT09BM7CHcxXn4nun
 9Z2wpIt/dUWmiqkNGm4esMsl+aXWnySzdvcIYen6ZlCWZ1vyoOY3ceXT1bWpCMRWl0VR
 61hzxTGQ2VvcU3Recp9yHDfRsFgJZYC/3yp0WgHJ4ihaYFcxCEqBu6E8EDU6scFHcNpn
 UTQUwtwV6BNvdn5uAtXEkDLGfBiCGSY68u9Pd4U2ZDZInoUFcTaNvj0nFjpGSQ/AgrUx
 60/SXMlwFziztFM74bYrbqV5m1wBZ0EGy4WJzBSD6siwXUcf1DFrIvMyQnHrTn/4e/XJ
 itUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773000077; x=1773604877;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9bc3dDgxVp34vdvDvCS79W/jF4fvXXmgzLnO8vy1uMs=;
 b=NSwEeQHj8wP1cMysBsG6iOvl4Hje9r1TG5yky4Fi53SdWCXTeCzQXUwzalwCNfSI9C
 dAC+QRrdWD5gPz6NNqcK7ghnY8LiOLkGNsCxSMHRE7acAC0wdSxF7MB5XxIWFj4KBxRI
 je9U09Zy48u2alpIXz0L6mmVtjMIEAIJ8zF7FmRkg7tslqQa3fwczkJ0+sALQrR+fnBg
 oPKk1xHFhi4G34fUE15X7dzgrSA8PWVsNJuis9Be6iRgPieoSdiCK7axihOoYJY7ncVH
 hNhsGsDit80n4mQk2TC9YkCvJ+eowVBl7Fe1LcFYjpTgJG9SsTe4h8vSch3hEtHkm3m/
 yL6A==
X-Gm-Message-State: AOJu0YwHgwFHmC4bNp5h8u5qh0MPiAxmfxnq7LHQchBHKsVStYmdZQfb
 ejktN+82P+FL6/P1heAtiCFxoNm2OLz8T7WKA/vJI8rx7+sb4VQH446M+0BFruNf6SDrpr6P5Il
 8MixryEbn9UKJ/vaghb3u7PCLIf2bpQIFCZM1+CAO4B/9tWzne7HcdCA=
X-Gm-Gg: ATEYQzwcdbjJPdVPT7L24w2nXqEK9EG40BMPA26esGrRWbWzs0Nq+QVoSL8F7upU6nJ
 fICM6a85WNcFxBHtXnSh/AMGVqQ9QtbE400/bdAA4ahtY2UWgrxuYgKShcvmY6Muq6WE6A9vlFp
 HAWk+FSkNiyrbxCFqTdM6UjZS4fGHGiEsTn1KnFLlQyPXZjjvLaBvGpQnKiUvFwJPyqV51VUvnG
 yJvjk3FNsKlsRfTIsm2mxabuydVmQYHEVRO2Mvg0rL7qpu4NeO9Y0PlkL4bENykK1FA1m50ZVl3
 ET0zy9YjxFiAnj9ePormL5W/myRkjJV6HTp2ER0vLCXONq3pvq1rhzyOBNuX+0HqeN4=
X-Received: by 2002:a05:690e:bc9:b0:649:d468:f79f with SMTP id
 956f58d0204a3-64d142f6aadmr9468038d50.59.1773000077322; Sun, 08 Mar 2026
 13:01:17 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 8 Mar 2026 20:01:06 +0000
X-Gm-Features: AaiRm52AsbPTUIDP-RIzT7BtBNrUJ9Ya2khg_ASm0ZdjnlfyGH369oVbxgAjPz4
Message-ID: <CAFEAcA8yiCxkyoGdCE-CZiDFK8gqim48_9XteOcBmbgSG2MnGA@mail.gmail.com>
Subject: skipping the x86_64/test_memlock.py functional test when QEMU built
 with asan
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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

The clang/gcc address sanitizers intercept calls to mlock() and
make them do nothing, because mlock doesn't play nicely with the
huge allocations the sanitizers do. This means that the functional
test x86_64/test_memlock.py fails, because it looks in /proc/ to
see if the binary actually locked anything, and fails because it
sees 0 pages locked.

What would be a good way to skip this test in this situation?

(1) Should we make QEMU's mem-lock related command line options
actively fail for an asan build (since they won't actually do
anything, and if a user runs one they probably would want to
know this)?  Then we could detect that particular error in the test.

(2) We could run the QEMU binary with
 ASAN_OPTIONS='bang' qemu-system-x86_64 -help >/dev/null 2>&1
which will exit success on a non-asan build and fail on an asan
build (with an error to stderr about the invalid ASAN_OPTIONS
syntax, which we send to /dev/null). Then we could use that to
decide whether to skip the test.

thanks
-- PMM

