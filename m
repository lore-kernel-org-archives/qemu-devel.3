Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C26CD1284
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 15:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqxYR-0005k4-0v; Sun, 31 Mar 2024 11:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqxYP-0005jv-Ky
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 11:57:05 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rqxYM-0005hd-Bw
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 11:57:04 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a466a1f9ea0so193701566b.1
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711900620; x=1712505420; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Zof4UHYcJPPCzMCxseWYLpRg4dcWsvJk8SW3JmWhycg=;
 b=KeaDRKnSGBLQvWE0NPVYj2t+9eMk2tQeBYF1/FqFlyDURIVtnDOnsE9+EugCzUCFPO
 8rwWbj18ebYdV/A4GfuCz43spzmatXdtIiTonWC6aYa5ZMi9U1byO/ocdLw6KkKKbaMM
 Uiwe8HPudBCXmSLDKOJaa3JcQcz0aVeHig6q5peOnoa6prR4hho9gMC3i6L9EqvCvEYI
 wc0IY+XE7XNS7ZL/92xo4u3BzlE/nciYkD7MeTkkuxIIgCyDpwyOYv3ivPh6Pyq6V173
 NlnsyZ7wctnIpsV649L5L1mISl7Pb2We0NDVhnO0sfi4/kB4CCkEKzx/5+UTzIeXWfCS
 7YRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711900620; x=1712505420;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zof4UHYcJPPCzMCxseWYLpRg4dcWsvJk8SW3JmWhycg=;
 b=gdBEeXzxlq/G/VY/gZaifQsZq7MscbmqPNMwPhbbVJ6iYo2mCMHmit73paFOBGK+CO
 Q1umFB+mYbpTJq8JlTcXM6BDtbFbLqBMugBfrFNR505n2MTlq6YXiblN5ERQrT2fAlAe
 +85SemXI4k7kMSDyMmrW4/Kz6iVAeh4qLMRBYrpS6ds+HYYyPjDl8/p/Jy+gOQiVb3mB
 FQVXb998K08xK9pzgCL2pPNQLuB6qOPdLjZjK9Dw3BYmJNGHM3GOf58du092kKA58FTH
 TIsEV70Zc8IKMCavbKYAiRy6HeFK11XA8r3Wh6XdxakwZDaOq9H0Kq3So4ssCSrqAONJ
 ZqZQ==
X-Gm-Message-State: AOJu0Yz6XuzfjR472VVWuzl0BwZfrYabWiTy7wU+fUmSg95sIv9QzW+9
 48Ly8SF0qg5EmGgGASWZ2ndKyvkAtowK6zBiLVQt8o5Kc7nIoVKhIIRwwdjgHTVFPEAaB0ufnYo
 Vp2y2G6lPPzAaHetmKEmFpS5dtq1s5bMK3+zPa1HzV1TPnkB2wns=
X-Google-Smtp-Source: AGHT+IEPltyvKxXXBu0BSB4DlfMRcOjaElr8++UTpqAvbAvJ+ALLLP+GSQ0IKvFIVjnSMV53taUrHTT75DEKl3yUIRg=
X-Received: by 2002:a50:a448:0:b0:56c:1735:57a2 with SMTP id
 v8-20020a50a448000000b0056c173557a2mr5945996edb.31.1711900620676; Sun, 31 Mar
 2024 08:57:00 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 Mar 2024 16:56:50 +0100
Message-ID: <CAFEAcA_+196BzNONPjpfF5O5EOfw4FA7TkMWFNdby4XtsK+Jrg@mail.gmail.com>
Subject: QEMU cirrus CI jobs failing to start
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

https://gitlab.com/qemu-project/qemu/-/issues/2256


The Cirrus CI jobs for macos and freebsd are failing to start:

Unschedulable: "0/2 nodes are available: 1 node(s) didn't match Pod's
node affinity/selector, 1 node(s) had untolerated taint
{virtual-kubelet.io/provider: azure}. preemption: 0/2 nodes are
available: 2 Preemption is not helpful for scheduling."
Waiting for pod
gitlab-runner/runner--bkh5w23-project-11167699-concurrent-1qldjp to be
running, status is Pending
ContainersNotInitialized: "containers with incomplete status:
[init-permissions]"
ContainersNotReady: "containers with unready status: [build helper]"
ContainersNotReady: "containers with unready status: [build helper]"
Waiting for pod
gitlab-runner/runner--bkh5w23-project-11167699-concurrent-1qldjp to be
running, status is Pending
ContainersNotReady: "containers with unready status: [build helper]"
ContainersNotReady: "containers with unready status: [build helper]"
WARNING: Failed to pull image with policy "": image pull failed:
Back-off pulling image
"registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master"
ERROR: Job failed: prepare environment: waiting for pod running:
pulling image "registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master":
image pull failed: Back-off pulling image
"registry.gitlab.com/libvirt/libvirt-ci/cirrus-run:master". Check
https://docs.gitlab.com/runner/shells/index.html#shell-profile-loading
for more information


Anybody know what's going on here?

thanks
-- PMM

