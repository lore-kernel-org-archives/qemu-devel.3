Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 373E2E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 16:46:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUqEx-00056a-3a; Mon, 06 Jan 2025 11:46:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tUqEY-00054b-36
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 11:45:43 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tUqEW-0007Ue-Gt
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 11:45:41 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3d0205bd5so22279400a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736181939; x=1736786739; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bbWBIifpojGW0xkwdwEaKNkDuatDG6bDkaU0P7ywEz4=;
 b=OXhcbuZ2Hzbdz4QRlC83xt9N4z7dVoUM5Cfpi3pQAUaq/mtop/llvJv5wd37qGrWhR
 EzALI/jdZtqy3Cma3vndu8bNtyhQJdiU3LW+QwG731I13hLnPgD9ZxCSOzKbe29jSF/7
 vNrKNwsfGl4/i6F0r0lVayAmcAOESD8KlpdnOhWA72JIyYj+8CC7xr/NMl1BkhX8mRZl
 b6YJSuICTSFysD+Dq18vVHM1nqDV5I9VHjYcASc/pkXHWJjzSysWj2nZKzZpFFrQPNyG
 8i2x7Cvu4prKM/cVGlFpOyY1dCVdLLwOvTLtvSUGPXJDDAhkY07udI4uYI14KaSOurg5
 UUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736181939; x=1736786739;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bbWBIifpojGW0xkwdwEaKNkDuatDG6bDkaU0P7ywEz4=;
 b=Qu9NzTaL6jgMqlm8bRB3CRX3SXxrsO4Qy96cWZ72cns7MQ+awiGFXTJqaJ73zs6zoU
 cfc4GVZksbOBQbqWV6B3F7kCR2JulYkliD576eZeHZoNhckERrQ0B0DAm+X6spIJXiRV
 F22h3fLoYWEJx3ZB6e3hQBoilbfF4wAZ21GJ0RcdpPX3kK/TQIiFNXM9FdkN1jDoPjVU
 dxpIfkr7WMu2joJjSCDUn9Klz8LQwfY9tgyK94S4imZWG3NWDVvNPwgtgGsVnX2H2vL/
 np7RgHZxbW5txKGZ0Qsg2RaGhg/DrcwUhurYw04VLdm7iC9TWj4X3HvUjX1LtP60lpJE
 5NrA==
X-Gm-Message-State: AOJu0Yz3DG2F+s6kRQ7WRfV5csN3aUUEAIT2o40UlPOqogjSxP1PJYxF
 ok1jOvRnXdIHPe/VG+3GgFSAPXBYV4MjQpL0ht/HBluNAVWxAIw2c0V0OeZR5oggRcarLVbTAOi
 p3iEHOjqzl4ObORpVB05I1bt9e0vOBpwH
X-Gm-Gg: ASbGncvSxcQUBvNZictiK9V4WPi+jlGBuWsQUxUcnx4JOCKLEdd9lhbVBb75GDTrQ4Q
 +4j8/jxC3WVF01k2yLm1C35Ez+tbBSurzY01n
X-Google-Smtp-Source: AGHT+IFl5Rila7pFH8AaHn5u+6lpD/lhrUYCycMMTUAgVCkdkPWtNk+uUYyuBaU2TB0zY1aVi2581GOybx64h+NXd90=
X-Received: by 2002:a05:6402:2109:b0:5cf:e66f:678d with SMTP id
 4fb4d7f45d1cf-5d81de083bamr56051652a12.28.1736181938363; Mon, 06 Jan 2025
 08:45:38 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 Jan 2025 11:45:26 -0500
Message-ID: <CAJSP0QW02Mf5Vtp9UbvAUc+UXKV0Exw_ggFCMAgVQ0+dH7Jf0w@mail.gmail.com>
Subject: test_x86_64_hotplug_cpu.py times out frequently in CI
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
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

Hi Thomas,
test_x86_64_hotplug_cpu.py times out frequently in CI runs. Here is an example:
https://gitlab.com/qemu-project/qemu/-/jobs/8777540230#L1151

The detailed test logs are here:
https://gitlab.com/qemu-project/qemu/-/jobs/8777540230/artifacts/browse/build/tests/functional/x86_64/test_x86_64_hotplug_cpu.HotPlugCPU.test_hotplug/

I looked at this failure with Dan and Peter on IRC. It was pointed out
that the final command assumes that device_del takes effect
immediately. The console log shows that the CPU was still visible to
the guest when the final command executed.

Could be a bug in QEMU, the test, or both?

2025-01-06 15:45:29,308: :/#
2025-01-06 15:45:29,313: cd /sys/devices/system/cpu/cpu0
2025-01-06 15:45:29,315: :/sys/devices/system/cpu/cpu0#
2025-01-06 15:45:29,320: cd /sys/devices/system/cpu/cpu1
2025-01-06 15:45:29,322: sh: cd: /sys/devices/system/cpu/cpu1: No such
file or directory
2025-01-06 15:45:29,325:
2025-01-06 15:45:29,330: :/sys/devices/system/cpu/cpu0# [    7.337146]
CPU1 has been hot-added
2025-01-06 15:45:29,330:
2025-01-06 15:45:29,335: cd /sys/devices/system/cpu/cpu1
2025-01-06 15:45:29,337: :/sys/devices/system/cpu/cpu1#
2025-01-06 15:45:29,342: cd /sys/devices/system/cpu/cpu1

Thanks,
Stefan

