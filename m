Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89581EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpR9-0003xS-1S; Wed, 04 Mar 2026 11:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR7-0003wX-Jz
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:51:01 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxpR3-0002SI-7f
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:51:01 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6611d20c026so876955a12.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772643055; x=1773247855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzHkTR4JqWnhH9thHwZCJ8/0KIT+iOpkuJdDWK3JNNc=;
 b=DEcdXsp+r6NcAaFG26wCRyzBNbM1mvRwRjz5dmer0bdjQksHtivdNclMOtNNl9fXRH
 mRZGThM0bodRPmAaZn3vVOUj6RJDhooj3+yQHAraxMm9kyVdzOxmzCcyUKUIV7LSO5cR
 cj6/Z8Kkrl4RMxnM/TBmHiNyBi8qpNYHZqP4CURtwBtOewnfk3NcDRP94brG/hp/ZrzR
 Z0Kvy1VsEfT79hKB/z0FYmStrxg3c3nYGxHnjW4tg/uIAxV8G3zuCWslgDS+peXWEUyK
 1uVqzY7X0rpKKZx2R61p+95w3qvBEBb3vrdMKrP9UjpT5aHVvb2OPUzgZOXePpu6+Dhu
 bV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643055; x=1773247855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EzHkTR4JqWnhH9thHwZCJ8/0KIT+iOpkuJdDWK3JNNc=;
 b=fB2d29TO3cga7F4widJTOVCzqcJXl9tRgMRWtbAwPu9g+73e022zOVfgNqALa0T84K
 yBQrrieecxMqgEUIyXmUoU7zRuoUG87kCMtkvXYCj8LruYHspdw4dMHpx32mVbN218j6
 M0/eTy73p+RqosMVdqHysJICowhfCAiWTKvs3cvOS9a+2i+kb0leV+Zk2PJP5YLR1rE/
 7K1slxPJM50E5AbbSFbvoXcSEvt9VIKrOLPAGREt4Z0tY5VpVG0nPrrffmIfeSn7ojnD
 bTAzrkS3qh7zG1Cxh+tP7Wfv4HI5JMLziXHlWW4bHUpxmvhXFaqt/TH5ZFXBw9IHOYpr
 kJsQ==
X-Gm-Message-State: AOJu0YzS5udPBku2C0pmgDLPOTp2GRtnMePCRKxpM5fQW2ObaOeFen8X
 Rq3kAqXslwwaKPNOZcYLt5LGfFms7gQi9xSqKhCgmVBZKQssdWl9acD6vYxYWY/0+rQ=
X-Gm-Gg: ATEYQzyoZm6EV5+4uhbFqLtv7euctlHCsI3T2v5PwBdDXwlgn70lzko9E9sYYHXQJeV
 L6sJ8pC9CyX+0wMycY6pSQkEjWtbH7tM6JCzRXmtquwDwZZ6GNLB0oK4nrjezPk8QTdSzYranyc
 exAHE0vDHC4Ya9GWewVMsAvdXdp/ev+hXiD98UPfgwUdaRq01akMZyY6WJ5FQBT9hKcyjLjMLiK
 Aju7winJnDbIiziMYrpuT0aM+lO+Ih69mYLj7n6NQygYIRHSUYi/RfW07YlpDHJn63NrJjW5mUw
 cLHZjaSRmv6J8XrCUDNxRiudOCumJGtp4m6ci3ct7C7ORhRIJ5AeIuT2UUH6N+fBZLjiS11RXaE
 8HCia+jAYv8gGIZMdlGn4J1rPVnQkHK3I0JCMJYIxrZSkGmJHKm5qRFO6AL9moBWtJCJp09L+1D
 N8hCEXAadx667BRHw1UVYfXmUSZNga/StwbQ==
X-Received: by 2002:a05:6402:4403:b0:649:cec1:6cf1 with SMTP id
 4fb4d7f45d1cf-660eef457a9mr1609764a12.0.1772643055531; 
 Wed, 04 Mar 2026 08:50:55 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabf6d113sm5470817a12.19.2026.03.04.08.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:50:51 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E384E62D8C;
 Wed, 04 Mar 2026 16:50:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Yiwei Zhang <zzyiwei@gmail.com>
Subject: [PATCH 13/20] docs/system: virtio-gpu: Add link to Mesa VirGL doc
Date: Wed,  4 Mar 2026 16:50:35 +0000
Message-ID: <20260304165043.1437519-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260304165043.1437519-1-alex.bennee@linaro.org>
References: <20260304165043.1437519-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Extend virtio-gpu documentation with a link to the Mesa VirGL
documentation.

Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Message-ID: <20260303151422.977399-12-dmitry.osipenko@collabora.com>
---
 docs/system/devices/virtio/virtio-gpu.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/docs/system/devices/virtio/virtio-gpu.rst b/docs/system/devices/virtio/virtio-gpu.rst
index 086e2fcf27b..89153103b9f 100644
--- a/docs/system/devices/virtio/virtio-gpu.rst
+++ b/docs/system/devices/virtio/virtio-gpu.rst
@@ -61,7 +61,7 @@ on typical modern Linux distributions.
 virtio-gpu virglrenderer
 ------------------------
 
-When using virgl accelerated graphics mode in the guest, OpenGL API calls
+When using `virgl`_ accelerated graphics mode in the guest, OpenGL API calls
 are translated into an intermediate representation (see `Gallium3D`_). The
 intermediate representation is communicated to the host and the
 `virglrenderer`_ library on the host translates the intermediate
@@ -70,6 +70,7 @@ representation back to OpenGL API calls.
 .. parsed-literal::
     -device virtio-gpu-gl
 
+.. _virgl: https://docs.mesa3d.org/drivers/virgl.html
 .. _Gallium3D: https://www.freedesktop.org/wiki/Software/gallium/
 .. _virglrenderer: https://gitlab.freedesktop.org/virgl/virglrenderer/
 
-- 
2.47.3


