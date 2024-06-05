Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103E9C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 15:29:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEsZU-0000cW-Ky; Wed, 05 Jun 2024 11:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZT-0000bU-2U
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weifeng.liu.z@gmail.com>)
 id 1sEsZO-0007WL-E8
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 11:29:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6f8ec7e054dso4836398b3a.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 08:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717601336; x=1718206136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wnvAk+khpr2juqijwqQqqwCt+1oaDBBIFgjTnKucVmw=;
 b=S1HGTRoHFGy6p9kTSwCZWQ4IeGTMLQL5ZaMAZ/q+Iu39Am20mJHqgEKghoFVCtLOyK
 lVb8aBEPgJsDoBPu2hcxDUzNMi20pXWwxtOPZb7ofrM6nJNEGRhMo2dP0AbQz96oqC25
 HjRRDI0GLH7gKdMZ2dH3WZHO+0QeWVS7bWpEcJeVf3wznJs4eXGo1NYua/zgzbCJpA8T
 U689sE904KSt05c2/oFR2U9PG9fqL1CMi5DRUpRGFx5L0hvzCLMMUQjFQAd6rdxnmhHW
 ZB9ggqMOsUjlL7AG8VX4MXbukUa6jrm5JAGUQhcPFKmD+/VUi7zSf6/rT1OysEG6eFO/
 +7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717601336; x=1718206136;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnvAk+khpr2juqijwqQqqwCt+1oaDBBIFgjTnKucVmw=;
 b=e8ecvaK+zWwB+JCl9Xjqdkxylc58NvE6/kRsmgXlzfx3DV/jLM5hNjTzn1zBSesr44
 /GGtfWl/ASbZh1GEi4orYgiUsM/pwQwUFyuVixaBkcaWVJI4cC1ebg94osrG9LC07cYf
 5P65dCOtqocG3Bo+13qMYfgz3wx6ycVhXjm3FkdHUPZbU684/le0sxSSq9wLxkDIA6f2
 81FIrLGi9fL3W+RzX8d5Xu/nyN6OQlZDpt1mC9rAlc2KC6ZfgFCupVNeSYTKY3J798yC
 ZzuBBWKRLM0SLSx4gtOE0yyw+ybdyvIJE56vjrDRqfp48xK0pW9iXADhojcSu2J2kHFE
 J51g==
X-Gm-Message-State: AOJu0Yx8e7bHkBy79mj6Ql4Bgq6KIvRlwv04Nvo5/R3BNcNb3lN+kpc4
 GkRA+QO6Hs06rVK0rTNw9QWROO8VkkSpWkCyjA+Pzqs98nAiQnLAup3Z/3vdGYw=
X-Google-Smtp-Source: AGHT+IGW5mFxyHEu6KNjm0Xw2zQogC9KWJKPIQ49rdjdrTIrdztDbBT4aljHUfnqEXxmaV2NKFeQkg==
X-Received: by 2002:a05:6a00:2ea9:b0:6f8:c6e4:1829 with SMTP id
 d2e1a72fcca58-703e5a1bbfdmr3335658b3a.25.1717601335712; 
 Wed, 05 Jun 2024 08:28:55 -0700 (PDT)
Received: from localhost ([103.192.227.74]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702688e7e3dsm5526536b3a.215.2024.06.05.08.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 08:28:55 -0700 (PDT)
From: Weifeng Liu <weifeng.liu.z@gmail.com>
To: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Weifeng Liu <weifeng.liu.z@gmail.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>,
 Huang Rui <ray.huang@amd.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/3] virtio-gpu: Enable virglrenderer backend for rutabaga
Date: Wed,  5 Jun 2024 23:28:27 +0800
Message-ID: <20240605152832.11618-1-weifeng.liu.z@gmail.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=weifeng.liu.z@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Greetings,

I'd like to introduce you my attempt to enable virglrenderer backend for
rutabaga empowered virtio-gpu device.  I am aware that there have been
effort in supporting venus in virtio-gpu-virgl.c [1], but there is no
reason to prevent us from leveraging the virglrenderer component in
rutabaga_gfx, especially it being not very hard to add this
functionality.

Generally, the gap is the polling capability, i.e., virglrenderer
requires the main thread (namely the GPU command handling thread) to
poll virglrenderer at proper moments, which is not yet supported in
virtio-gpu-rutabaga device. This patch set try to add this so that
virglrenderer backend (including virgl and venus) can work as expected.

Slight change to rutabaga_gfx_ffi is also a requirement, which is
included in [2].

Further effort is required to tune the performance, since copying is
present before the rendered images get displayed. But I still think this
patch set could be a good starting point for the pending work.

For those interested in setting up environment and playing around with
this patch set, here is guideline in brief:

1. Clone the master/main branch of virglrenderer, compile and install it.

	git clone https://gitlab.freedesktop.org/virgl/virglrenderer
	cd virglrenderer
	meson setup builddir \
	  --prefix=$INSTALL_DIR/virglrenderer \
	  -Dvenus=true
	ninja -C builddir install

2. Clone the patched CrosVM, build and install rutabaga_gfx_ffi.

	git clone -b rutabaga_ffi_virgl https://github.com/phreer/crosvm.git
	cd crosvm/rutabaga_gfx/ffi
	export PKG_CONFIG_PATH=$INSTALL_DIR/virglrenderer/lib64/pkgconfig/
	meson setup builddir/ \
	  --prefix $HOME/install/rutabaga_gfx/rutabaga_gfx_ffi/ \
	  -Dvirglrenderer=true
	ninja -C builddir install

3. Applied this patch set to QEMU, build and install it:

	cd qemu	
	# Apply this patch set atop main branch ...
	mkdir builddir; cd builddir
	../configure --prefix=$INSTALL_DIR/qemu \
	  --target-list=x86_64-softmmu \
	  --disable-virglrenderer \
	  --enable-rutabaga_gfx
	ninja -C builddir install

4. If you are lucky and everything goes fine, you are prepared to launch
   VM with virglrenderer backed virtio-gpu-rutabaga device:

	export LD_LIBRARY_PATH=$INSTALL_DIR/virglrenderer/lib64/:$LD_LIBRARY_PATH
	export LD_LIBRARY_PATH=$INSTALL_DIR/rutabaga_gfx_ffi/lib64/:$LD_LIBRARY_PATH
	$INSTALL_DIR/qemu/bin/qemu-system-x86_64
	$QEMU -d guest_errors -enable-kvm -M q35 -smp 4 -m $MEM \
	  -object memory-backend-memfd,id=mem1,size=$MEM \
	  -machine memory-backend=mem1 \
	  -device virtio-vga-rutabaga,venus=on,virgl2=on,wsi=surfaceless,hostmem=$MEM \

Note:

- You might need this patch set [3] to avoid KVM bad address error when
  you are running on a GPU using TTM for memory management.

[1] https://lore.kernel.org/all/dba6eb97-e1d1-4694-bfb6-e72db95715dd@daynix.com/T/
[2] https://chromium-review.googlesource.com/c/crosvm/crosvm/+/5599645/1
[3] https://lore.kernel.org/kvm/20240229025759.1187910-1-stevensd@google.com/

Weifeng Liu (3):
  virtio-gpu: rutabaga: Properly set stride when copying resources
  virtio-gpu: rutabaga: Poll rutabaga upon events
  virtio-gpu: rutabaga: Add options to enable virgl and venus contexts

 hw/display/virtio-gpu-rutabaga.c | 104 ++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-gpu.h   |   1 +
 2 files changed, 104 insertions(+), 1 deletion(-)

-- 
2.45.0


