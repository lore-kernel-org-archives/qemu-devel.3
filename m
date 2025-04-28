Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281A5C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 06:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9IBW-0003oa-8D; Mon, 28 Apr 2025 02:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBF-0003PX-5Y; Mon, 28 Apr 2025 02:41:34 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1u9IBC-0007AT-JI; Mon, 28 Apr 2025 02:41:28 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-224019ad9edso64965895ad.1; 
 Sun, 27 Apr 2025 23:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745822483; x=1746427283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+qJYGpC8zudJ6XJWHSpEsa6KVoxk0Yfz+c+aIsjTJ0=;
 b=IQYByhayqVNutAHN5Ov/06dBSOIxi0CUmkd6O1ji8nBTO/Xuk8MYadQkkZJW0UZIQH
 F3RQnRYBqF1VRf3SSIPvi7rZP8D3hFgOJooNhW8VkMjRGMaOwju+wfqRltqM/4YpZUwN
 DMmWQjkVAa7RhOhqTigguGDkL4J5cowk50+PcNOl18EamQ2Of3jy14rcVf4RRahhtSHh
 CYq6yvdukMnN9+ANv3xo04CkCV8ntrWKWhaKFd25rOzrUFyo7SPJmy7Nkbzylu7ZOUqf
 EZPi5ULjnGlkwFBRJooe7ADGFMEImwWYf8hdw37MGGzM1YPIan5HBzsaqAVqa7vW64ck
 Sf6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745822483; x=1746427283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+qJYGpC8zudJ6XJWHSpEsa6KVoxk0Yfz+c+aIsjTJ0=;
 b=FPHZibllCBV7CsO66BtJB2YvcaxyvS3inVfgfCo7/HLezh530LJRujxP5rzegH4pvP
 4Dlp6vpFP+8eV2QAoxB/t7CJ5tNyBDa/SECNY7/tbLOBtsm5hO2Axnn7mJCANKOPL5pS
 wj8sp6I43whFX6uoD10C33+KjEOH7CaXxGXluofxGCLs10vNQh09EsprU2rubj5xkX1X
 EGVxxtiFvSkjSm2SeVjFE97jgyG5tVrY8bTWRWCo5lZwUufP97oEftNUAqPVHkrXf6cm
 MMcyALPTKiItb4siRdpMlBqHVem/hvWVDFK9MuS5ZIglcOrFyh/oIOK+fsFtxcr4HJQ7
 +8nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwwMagM3/uPZI9Ex01JGehf8LRptye1VtKlRXbzFjg5HuCJq/MkPG+udXNWzAZNjYQnhmc8Nm2clOfyg==@nongnu.org,
 AJvYcCWxS3A7Y954u0la3mDDPWjc1BOBG8qDPO094k79aGC1SIk8Bl78aX2bUugNIBDiFUtKrwQbDEuOcA==@nongnu.org,
 AJvYcCXTjH8/Nabn72JnAAJ4Z1Qok5+6ANvh6vfxh4TbrfDijNp4oK2wb2nDg6qGdP93SQeyaRR+zdJvHed9pg==@nongnu.org,
 AJvYcCXx0x1P4UhE7TIIKFygvOn+XNDLOLaUqYOpeWDZGHiNBROLtGf0lmjyHaM66RxCSNxMijuSBeMXM70=@nongnu.org
X-Gm-Message-State: AOJu0YzIpP2K/L24Uai2RzJzEGJycabrL4H7IO1WEHUUfBbMh65JQHTl
 Z6T/kdXGaYNvj3eKAGk10HZZtvNtU3trJVATy4Xi7Rz3fnbvXghJxIOCiu5l
X-Gm-Gg: ASbGncuYdIGVIMqaVae1FdzoC+3L0DI3cBngX5uZirX+1BOr/Xcy8DkytXU3JkaZPHv
 WN0qD+nY0fPECsZEREd4wdcJXyZFeG0ackr2K6H53u5xAJyZaWobRJRbX4kAyn6Kt3wLza5Wvwb
 nkxp9MRYaEUW+IHQKGsL448pFk8n0YdUQjuoWHuKpxWeggFwkgKXk8FovlFOesK48+HRKfNJrw6
 E3ZuQGt9gTwjRwJQ47Gp3h8qjcd6hxJxr6s5HP+kCHsmY3XTyftHJ9U2zUqsGY/jrfdts5pCqwc
 VpStTiJVHlKmUWQkLKJSTKeqOFRabyZ7y2nnPA==
X-Google-Smtp-Source: AGHT+IHO3f+qZc9Iv97lxl2T4n0xLw+LFAlqa4f7UljrI/mIPNgu9dL4YuCAFvRtzFV72lSX8lpLmw==
X-Received: by 2002:a17:903:94c:b0:223:5ca8:5ecb with SMTP id
 d9443c01a7336-22dbf62335emr154850705ad.42.1745822482596; 
 Sun, 27 Apr 2025 23:41:22 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:bcb:2cf3:f1b5:b7f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbe328sm74721215ad.88.2025.04.27.23.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Apr 2025 23:41:21 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH v3 13/20] block: Fix type confict of the copy_file_range stub
Date: Mon, 28 Apr 2025 15:39:02 +0900
Message-ID: <938d2beba15d4bd496a600ee401995fbaa385c62.1745820062.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1745820062.git.ktokunaga.mail@gmail.com>
References: <cover.1745820062.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62e.google.com
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

Emscripten doesn't provide copy_file_range implementation but it declares
this function in its headers. Meson correctly detects the missing
implementation and unsets HAVE_COPY_FILE_RANGE. However, the stub defined in
file-posix.c causes a type conflict with the declaration from Emscripten
during compilation.

To fix this error, this commit updates the stub implementation in
file-posix.c to exactly match the declaration in Emscripten's headers. The
manpage also aligns with this signature.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 69257c0891..2758f31844 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2015,8 +2015,8 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 }
 
 #ifndef HAVE_COPY_FILE_RANGE
-static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
-                             off_t *out_off, size_t len, unsigned int flags)
+ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
+                        off_t *out_off, size_t len, unsigned int flags)
 {
 #ifdef __NR_copy_file_range
     return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
-- 
2.43.0


