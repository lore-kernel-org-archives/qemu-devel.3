Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E06CBD1D482
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 17:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdtYR-0000o0-Hq; Thu, 08 Jan 2026 12:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYN-0000mG-12
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:07 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1vdtYK-0000Bq-VE
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 12:12:06 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0c20ee83dso32430605ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 09:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767892322; x=1768497122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xxQcoTKXg/nKmhGL9kKREQkNiLaLDVkvfSGOXTJ+u/s=;
 b=dBibhPtwZ/0zx08/H+SdKhk1BlTOohbbqkhzpY+gRM+Od/84a+Xnvz+E6VsJQ72dMN
 78g4C9GrQWykjqB9BWyHjVd3wCPoFIKNCQx6NjhY1ATGpkEgf4ttk7r1RM2Y/9B0/EXt
 w7kcXAttegs9HzZnpUK7nPCCD5417hhXc7vGv26MHKhaJcT18jyAcEK+SEko5/AqE/Gf
 WaREXM23TaJdDF1PqiB0DK4oW8ykSPnLdIrjJ3IgSGdocXpkWoDoiaoyzghEzZ6QXul4
 M0cNuN2yQHYFiwkuxmipn7lKi9aGiSWYqDEV0zbAfMQrPLrBmsioNwen2ONjs/huKyw8
 W1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767892322; x=1768497122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxQcoTKXg/nKmhGL9kKREQkNiLaLDVkvfSGOXTJ+u/s=;
 b=Why0WpUNWiDgsFXn0ScYodH+0/jp9VRotelLpyh0D8qV+W1vxc7ryD8Il6q/W4coUc
 HZIMjggkiW/nPlqZTlkZj57LxUJhi0TVVcCc9EtcrtfYetxJcWk6SipNQABz0ywqcOuY
 MzVZFbzAmC0uWcvflGE0vcn9kEmsqRDV5EC5GeULn9Kw2jZNWZ297rotOd8wEta5bclT
 Mw/GkiiyO6RBUn0066+HZsGWsuGlEbgjZRSt2rTEK/nJV5W6EtLUG7iK6GuSMfRzPgAp
 KyK9FHFpnRsEQZ9kluSaQasiefF+iWCnrN9UjwHkdfMalZypEBV6C+t7gjyhvGyWisqG
 xYRw==
X-Gm-Message-State: AOJu0Yzm4jvwpYtkP1EeM6JmMPZ4g0/NgIWT1VnSGf3I+NFN8ouNFV6P
 KU1ZJzqz3/0mD+M8GF70wBpf5Wu2WBSpkr6kW8VSYxNKXYOO7N5fYvAedNVw5Cp4
X-Gm-Gg: AY/fxX4mnqxCXXVAsDThXhO/GS2SzDWO8HnajkVIQxC0Cx0VlDE7Ju2jWPOmfavflo3
 B4+WQIzmc60IOdh4MUOmtFWP71cHtvJS92pp/SSRjG5YC8fcpy4LoP04wmYMPteyhIdsmj0Cs0k
 +MtfmDkZY38xesXEe2LexS8wjcH52Fk699Wqha3Ca+jDLPSLP7QTvqJGcYJ5VL3wmiyOpQ/2/mp
 TSlaYVaj7AALXdKCwl3TaQyYIjoM0BfKCGZPp5vVagrcKlujkQKHzaqqteRVdnWj+15STK4kmgK
 x9ofqiFYOIkl0Eg3leri0pO9n1EISST9JtkDMaY58Lwxyu07xxfWpsz4MEYsaLLte11/7VjPzPP
 LWQgTwwHRkvYjeGhhMM30O8Hm97a1fv74NyepWw8lpPBDV9qDJxQ0ysFT3HyxPkcuvfI8zjB4Ss
 rEYPj3k7q3zg==
X-Google-Smtp-Source: AGHT+IH4d7wo6phOve3r104JMBlYPYXdTpv8Dv2u+Y3MSPl0E7vxa7SPRehmFffTodB3UoZmASzvTg==
X-Received: by 2002:a17:903:9cf:b0:296:4d61:6cdb with SMTP id
 d9443c01a7336-2a3ee43de38mr64339985ad.27.1767892322443; 
 Thu, 08 Jan 2026 09:12:02 -0800 (PST)
Received: from ktock.. ([240d:1a:3b6:8b00:7ace:63ca:408f:4cc4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c3a507sm82808355ad.3.2026.01.08.09.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 09:12:01 -0800 (PST)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 0/4] wasm: Enable 64bit guests on TCI using wasm64
Date: Fri,  9 Jan 2026 02:11:24 +0900
Message-ID: <cover.1767886100.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x633.google.com
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

V4:

- Rebased on the recent tree.

V3:

- Renamed the build tests on GitLab CI("build-wasm32" ->
  "build-wasm32-32bit", "build-wasm-wasm64" -> "build-wasm64-64bit",
  "build-wasm-wasm64l" -> "build-wasm64-32bit"). The same change has also
  been applied to container-cross.yml.

V2:

- Added a link to the Emscripten documentation about -sMEMORY64 in the
  configure script.
- Changed --wasm64-memory64 flag to --wasm64-32bit-address-limit to avoid
  exposing the -sMEMORY64 value directly to the users.
- Fixed GitLab CI to use --wasm64-32bit-address-limit instead of
  --wasm64-memory64.

V1:

This patch series enables the TCI of the Wasm build to run 64bit
guests. Unlike the previous series[1], this patch series is implemented by
adding support for WebAssembly's "wasm64" target which enables 64bit
pointers.

In the previous discussion[2], the main challenge of using wasm64 was its
limited adoption, particularly the lack of support in our dependency
(libffi) and some engines such as Safari.

For libffi, I've completed the addition of wasm64 support upstream[3] so it
can be used.

To support wasm32 engines, this patch uses Emscripten's compatibility
feature, -sMEMORY64=2 flag[4]. This flag still enables 64bit pointers in the
C code while Emscripten lowers the output binary to wasm32 and limits the
maximum memory size to 4GB. As a result, QEMU can run on wasm32 engiens
while still supporting 64bit guests.

# Overview of the build process

To compile QEMU with Emscripten, the following dependencies are required.
The emsdk-wasm-cross.docker environment includes all necessary components
and can be used as the build environment:

- Emscripten SDK (emsdk) v4.0.10
- Libraries cross-compiled with Emscripten (please see also
  emsdk-wasm-cross.docker for build steps)
  - GLib v2.84.0
  - zlib v1.3.1
  - libffi v3.5.2
  - Pixman v0.44.2

The configure script supports --cpu=wasm64 flag to compile QEMU with 64bit
pointer support.

emconfigure ./configure --cpu=wasm64 \
                        --static --disable-tools \
                        --target-list=x86_64-softmmu \
                        --enable-tcg-interpreter
emmake make -j$(nproc)

If the output needs to run on wasm32 engines, use
--wasm64-32bit-address-limit flag. This flag enables Emscripten's
-sMEMORY64=2 flag[4]. (Note: --wasm64-memory64=2 flag in the V1 patch has
been renamed to --wasm64-32bit-address-limit in V2)

emconfigure ./configure --cpu=wasm64 --wasm64-32bit-address-limit \
                        --static --disable-tools \
                        --target-list=x86_64-softmmu \
                        --enable-tcg-interpreter
emmake make -j$(nproc)

Either of the above commands generates the following files:

- qemu-system-x86_64.js
- qemu-system-x86_64.wasm

Guest images can be packaged using Emscripten's file_packager.py tool.
For example, if the images are stored in a directory named "pack", the
following command packages them, allowing QEMU to access them through
Emscripten's virtual filesystem:

/path/to/file_packager.py qemu-system-x86_64.data --preload pack > load.js

This process generates the following files:

- qemu-system-x86_64.data
- load.js

Emscripten allows passing arguments to the QEMU command via the Module
object in JavaScript:

Module['arguments'] = [
    '-nographic', '-m', '512M',
    '-L', 'pack/',
    '-drive', 'if=virtio,format=raw,file=pack/rootfs.bin',
    '-kernel', 'pack/bzImage',
    '-append', 'earlyprintk=ttyS0 console=ttyS0 root=/dev/vda loglevel=7',
];

The sample repository[5] (tcidev64 branch) provides a complete setup,
including an HTML file that implements a terminal UI.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg05376.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2025-04/msg01795.html
[3] https://github.com/libffi/libffi/pull/927
[4] https://emscripten.org/docs/tools_reference/settings_reference.html#memory64
[5] https://github.com/ktock/qemu-wasm-sample/tree/tcidev64

Kohei Tokunaga (4):
  meson: Add wasm64 support to the --cpu flag
  configure: Enable to propagate -sMEMORY64 flag to Emscripten
  dockerfiles: Add support for wasm64 to the wasm Dockerfile
  .gitlab-ci.d: Add build tests for wasm64

 .gitlab-ci.d/buildtest.yml                    | 26 ++++++++++++++---
 .gitlab-ci.d/container-cross.yml              | 20 +++++++++++--
 .gitlab-ci.d/container-template.yml           |  4 ++-
 .gitlab-ci.d/containers.yml                   |  4 ++-
 MAINTAINERS                                   |  2 +-
 configure                                     | 16 +++++++++-
 meson.build                                   |  4 +--
 ...2-cross.docker => emsdk-wasm-cross.docker} | 29 ++++++++++++++-----
 8 files changed, 86 insertions(+), 19 deletions(-)
 rename tests/docker/dockerfiles/{emsdk-wasm32-cross.docker => emsdk-wasm-cross.docker} (86%)

-- 
2.43.0


