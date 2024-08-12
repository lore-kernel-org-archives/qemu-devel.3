Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A28C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 14:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdWGk-0004bV-1t; Mon, 12 Aug 2024 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdWGi-0004Zb-K4; Mon, 12 Aug 2024 10:43:32 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdWGg-0001Nx-P9; Mon, 12 Aug 2024 10:43:32 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ef2fccca2cso46253041fa.1; 
 Mon, 12 Aug 2024 07:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723473807; x=1724078607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wGyo4Ota7IN9p3OAlFvfW6UPVbQjlVeiFu4N+jDzYsA=;
 b=McN0BS/SRrJcTJ0MOUDloIouoV4sEd+UCaMbkjnYe5gQMr34QuepckZR25LqSUcl4e
 BgH4pf1aQdK+VX2f591HnUALthXl+DLMhUI51M23Kb4UWS3wM4o8kA+EXgC9P6lzfMak
 t/1auDs5G2rPoJwZo7YpaQQSgzR2nLVGYZuAZpzv9blrrzyo9KZ2CLgC6cDXSeIOCemS
 ttDM78ljAVZcPArQYjEsiqX8ao4hd+NQ51f/Ot+MZ/IKXM1lWSWsV3+1R8Pnw2UWsxed
 8tGvduxV8d1WqMNCkKLNqRvZ3WXc4TyXESotrEcacOkAbvhnBEN02BPrYRNsNm1jxyMf
 cJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723473807; x=1724078607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wGyo4Ota7IN9p3OAlFvfW6UPVbQjlVeiFu4N+jDzYsA=;
 b=whscoAXE8eyGKkNseRPnFLEYP0u3AnDwLnh0/VaNbX5yduz4QDGVeKIQgyLX2aDl4v
 WxDpAiw/w6A1RYG2oACraCprXCjFW8fSKiLOgheEsDsG0bC+PYnxvvxFuv96bVldUiP5
 cQpwB+9u7/TiMc5uElapV4fHy3OjKVDSaCuwOKMbuK/fqDvWooEEWYK7LmmxGCrpc1Yz
 qRwass2LxsNbel4u1XnF3SWixOqJuJ/TJw/eN69SJD6tUyweYzC1gJ5f2i6nj1AXALOn
 hr676obAkzjQHye81VOcS5p8syNdaTISWWXoRz4ROq51OnxxqKBykYF6VIAZ/PAP5GM3
 5PBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0NOq8aaV7E7Zo9SkQjhLUKlCRIbFdZF9T39zHnqLjJ6ynTlsQbCI8F3RMt57xawocQVzRp72Xa6UQ5+qvxPiGKMgzK/M=
X-Gm-Message-State: AOJu0YxplpxIoAR0N7rAtje2S5tCcZUiRk4ZyJFUodB+GYlwUif/n+rs
 FKUa1zH0gQM2cJbuTmDyWFFfgigYVFnreWptx27fgmVp+gXn6VJINKYY0BT0
X-Google-Smtp-Source: AGHT+IHf+GrcNeCgfTASMEzpaI+gz8P1yuoD2MuDnfhR6ptYtAz+9LKwVOD0MRrD2jHO9uREr+DluA==
X-Received: by 2002:a2e:97c6:0:b0:2f2:9048:f55 with SMTP id
 38308e7fff4ca-2f2b7154333mr2776361fa.25.1723473806744; 
 Mon, 12 Aug 2024 07:43:26 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f291df3be5sm8649931fa.29.2024.08.12.07.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 07:43:26 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, edgar.iglesias@amd.com,
 qemu-block@nongnu.org
Subject: [PATCH v1 0/1] block/file-posix: Avoid maybe-uninitialized warning
Date: Mon, 12 Aug 2024 16:43:22 +0200
Message-ID: <20240812144324.116343-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x234.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Hi,

I ran into the following build-warning when building QEMU
with GCC 14.1.0:
[925/1857] Compiling C object libblock.a.p/block_file-posix.c.o
FAILED: libblock.a.p/block_file-posix.c.o=20
aarch64-poky-linux-gcc -mcpu=3Dcortex-a57+crc -mbranch-protection=3Dstandar=
d -fstack-protector-strong -O2 -D_FORTIFY_SOURCE=3D2 -Wformat -Wformat-secu=
rity -Werror=3Dformat-security --sysroot=3D/opt/yoxen/arm64/sysroots/cortex=
a57-poky-linux -Ilibblock.a.p -I. -I../qemu -Iqapi -Itrace -Iui -Iui/shader=
 -Iblock -I/opt/yoxen/arm64/sysroots/cortexa57-poky-linux/usr/include/glib-=
2.0 -I/opt/yoxen/arm64/sysroots/cortexa57-poky-linux/usr/lib/glib-2.0/inclu=
de -fdiagnostics-color=3Dauto -Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 =
-g -fstack-protector-strong -Wempty-body -Wendif-labels -Wexpansion-to-defi=
ned -Wformat-security -Wformat-y2k -Wignored-qualifiers -Wimplicit-fallthro=
ugh=3D2 -Winit-self -Wmissing-format-attribute -Wmissing-prototypes -Wneste=
d-externs -Wold-style-declaration -Wold-style-definition -Wredundant-decls =
-Wshadow=3Dlocal -Wstrict-prototypes -Wtype-limits -Wundef -Wvla -Wwrite-st=
rings -Wno-missing-include-dirs -Wno-psabi -Wno-shift-negative-value -isyst=
em /home/edgar/src/c/qemu/qemu/linux-headers -isystem linux-headers -iquote=
 . -iquote /home/edgar/src/c/qemu/qemu -iquote /home/edgar/src/c/qemu/qemu/=
include -iquote /home/edgar/src/c/qemu/qemu/host/include/aarch64 -iquote /h=
ome/edgar/src/c/qemu/qemu/host/include/generic -D_GNU_SOURCE -D_FILE_OFFSET=
_BITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -ft=
rivial-auto-var-init=3Dzero -fzero-call-used-regs=3Dused-gpr -O2 -pipe -g -=
feliminate-unused-debug-types -Os -fPIE -MD -MQ libblock.a.p/block_file-pos=
ix.c.o -MF libblock.a.p/block_file-posix.c.o.d -o libblock.a.p/block_file-p=
osix.c.o -c ../qemu/block/file-posix.c
In function =E2=80=98raw_refresh_zoned_limits=E2=80=99,
    inlined from =E2=80=98raw_refresh_limits=E2=80=99 at ../qemu/block/file=
-posix.c:1522:5:
../qemu/block/file-posix.c:1405:17: error: =E2=80=98zoned=E2=80=99 may be u=
sed uninitialized [-Werror=3Dmaybe-uninitialized]
 1405 |     if (ret < 0 || zoned =3D=3D BLK_Z_NONE) {
      |         ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
../qemu/block/file-posix.c:1401:20: note: =E2=80=98zoned=E2=80=99 was decla=
red here
 1401 |     BlockZoneModel zoned;
      |                    ^~~~~
cc1: all warnings being treated as errors

It looks like a false positive and this fix avoids the warning.

Cheers,
Edgar

Edgar E. Iglesias (1):
  block/file-posix: Avoid maybe-uninitialized warning

 block/file-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
2.43.0


