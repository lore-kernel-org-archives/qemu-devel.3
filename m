Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC0CFCC067
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 19:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vybDY-0006T0-S1; Fri, 06 Mar 2026 14:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCO-0004Cc-QJ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:02 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vybCM-0000Qf-2h
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 14:51:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso72344085e9.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 11:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772826656; x=1773431456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Msw/rTa8Xu2Of6o1/fUJKClgRIjYd2FntFGU5RPSt8=;
 b=RdqUKpk41Pi0wNveg95z2Rlm5vvmCb109tgotCdupyPgCwVC/bxQYxrZ3+aYy1L8MD
 h4CIvE3UeSv6Jhs9vyEyXi0w5h8c/NdfrlMChD0dRCGE8SRX9YZ5QGK6szfKHLgPMv2N
 92r8FmHJzkno4pBMCJhMyOBACawgTOs+b/jmayBk6bk0qmpeHGn1EVoP4U5Ql8w1QVRr
 F7iRE432dmQK6BmJILqxIi2Dp1gWwLgjh72pluEdN86Uz4oGqS9P3sqhmDz+LeglfMZd
 NW8+82Yp773/Dkwvqw9z8ZXNxuGfGvp1h0xh+q76ZM/+s4oz49ldRDIxUIF1dyNWXAat
 AQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772826656; x=1773431456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1Msw/rTa8Xu2Of6o1/fUJKClgRIjYd2FntFGU5RPSt8=;
 b=KK0cMdCM9lmlgXiNIA659dqpst6e2utaGvIVu7K9loLfcezUTB7B66nu6W8Lg9mCqZ
 E7KewPnrbgRU2Z8aO9HXPsob2dvZ0GrmN/JoVCpeqqnhqqu/qnafoFN5WoFo2yP29/YP
 A+5qAXyIPHUkU0OXnWDhueDIMrwAkjgADVz9ed9Q9GdDUF9TeU7xu4i3SWnG0a3WJVwI
 RsT+Gg2qHYKTkMzvO0ybDuAw5vAXNEToRPqvMRslw8HvZq8+OrocGEm9MP9cIgtsXMXM
 0ncGACYygPzHMn1jYf8glyGdHaovwo6Gw6aiSpMOzjCsl9Oc6m0150auHMNWti+2nm+I
 kbOQ==
X-Gm-Message-State: AOJu0YzecvM/2xYtpxEh5edkPwDPCjBoSMk5BF7aXSMsnoE3mAPODa5I
 K7jcfoEIjxMyNX9nxpt1QpamV6nSZjFQAxEQazGHeyVZHs7DFVD7utw8H4r9MGovuY4=
X-Gm-Gg: ATEYQzw96cEoPiB25mXUxNadCeZ5w2f6L2D/rCiEFDotj7rt+GsZZUPiSFYrJ+3Q7YX
 tgFUMHsW8/JweYPBpcVFcs8M+hUm0eWQGYdGxQ7iOQBJtsjzZz/IZCLuKLdspXFgpBOhaZsdLuD
 /+F7BMnWxAGwfhxb0bpmtFImFPzvtlSqyH3iMfPSHx/s41fnmvdeokQyaHAY2jf3eSoMFPSX0UT
 fB+Gd+8oa3DyBx6vf295sGGT8PbEQKysiy56sd173sksbluosfPlv81sYmwa5+z0zvhSuRQmytk
 Bdi/taPwXODz8p5Yccxqc4Esl5ZuRyDluhoBacw7+cgburUsiKUuW8nStGRv53+i0A5W20e6Cp/
 ttRL5zUNzXc/ke39yXwVriVBVWZq0QzyBb1G+FOzMfQtTQ8JYWTnyFh76utAjgvCJKemFLNDr0H
 lU/Zq6+xAOQbBbWfpSjE0Y8nE=
X-Received: by 2002:a05:600c:8714:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-48526957d50mr50071825e9.22.1772826656552; 
 Fri, 06 Mar 2026 11:50:56 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad2812sm227680615e9.1.2026.03.06.11.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 11:50:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 49E4B689DD;
 Fri, 06 Mar 2026 19:50:50 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 14/20] docs/system: virtio-gpu: Update Venus link
Date: Fri,  6 Mar 2026 19:50:41 +0000
Message-ID: <20260306195048.2869788-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260306195048.2869788-1-alex.bennee@linaro.org>
References: <20260306195048.2869788-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Change virtio-gpu Venus link, pointing it at the Mesa Venus
documentation instead of the protocol. The Mesa doc provides more
information and also has a link to the protocol.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-13-dmitry.osipenko@collabora.com>
Message-ID: <20260304165043.1437519-15-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 89153103b9f..ef5fb0401d5 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -83,7 +83,7 @@ of virtio-gpu host memory window. This is typically between 256M and 8G.
 .. parsed-literal::
     -device virtio-gpu-gl,hostmem=8G,blob=true,venus=true
 
-.. _venus: https://gitlab.freedesktop.org/virgl/venus-protocol/
+.. _venus: https://docs.mesa3d.org/drivers/venus.html
 
 DRM native context is supported since release of `virglrenderer`_ v1.0.0
 using `drm`_ protocol.  ``DRM`` virtio-gpu capability set ("capset") requires
-- 
2.47.3


