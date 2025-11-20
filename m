Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA48CF8864
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5cq-0007Ct-RV; Thu, 20 Nov 2025 09:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vM4IE-0001zx-9O
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 08:01:46 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <language.lawyer@gmail.com>)
 id 1vM4IC-0006y5-Gc
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 08:01:46 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-429c7869704so730317f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 05:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763643702; x=1764248502; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCfFWku/1xsXAfo7s3Bc/FmCppPeSa1oiiEWTvBMHBk=;
 b=lBINq7absFqE8jM2N+yZ+MDsLwoLET934HdgRl5ikOLp7Zy7CXdI/pZ3eTbRFb/+VT
 qU3xhbcTfhQt+AbANZ9xzXzex5J4X7oh9fpq8vGNZ4dH8Mt+HMNlLTFKoRcsrf6snTA5
 XNroivggQddIUdH4vtlDrjTrYFPI9J4P0WB3hoqVWFg/Dm37huQetVm0Xx/MjjL+VeC6
 kRltbuZqpBUetzy5XlNSriDk/te3ZHDauXjccKGNxcYV+qGdPdCFendK4KOur1+O2Tty
 2ZYObIZiOPahGyG2WTgPj+puOq/Z+j1DH8zZyoCiJD8v3pjoKCFRL0zurzmfTiLSGJrv
 5Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763643702; x=1764248502;
 h=content-transfer-encoding:subject:from:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lCfFWku/1xsXAfo7s3Bc/FmCppPeSa1oiiEWTvBMHBk=;
 b=rOMP+QSTzs3ZtzV2/MZoxUrIqbMyNpWeVRj58MzXBUVzMSFxMabsFu1eCTTHV58XIl
 v1pz96snFtdmJBLjdk7cEaXo7+u1YrJjbTZgN4HrvfoQNdmPH8w7M2Uk0hF0OD6O7ALg
 rasGQJp79tJIK62+p3yBwvfahy4Fwqp0/BpcYmr5QzuA9M19mTnpdF9f0e02Cbye1B//
 SPiSPIOg2uiMoL1XEelluoHsk49DMqF5nER/5thCzrp2DjIcJeDk/iEKv7t8hrR8Z6fk
 Y4+oalV8vMSirTADSwvWMkIgbLd4ZSnZgZ79w30EcVARJOXKr/BkSjjW9GcawloPPTZK
 4qSw==
X-Gm-Message-State: AOJu0YyqsBbTOrwNm5PXLsVAZZkp4uIUgZlrwfvWg/+xnhyCRzyVGQba
 y7Z4Bv2+s/LzvI0bwmgvCqONCw1+e1K97JDaiz8/oZU79fjIJVIUUWNuCMYkGg==
X-Gm-Gg: ASbGncvTWQeT2S1EHlMMfvf+6tn9dHs1d6SVwSExnQZEEQOk3ZlsMkwFCyXkzejOZ4w
 gkLzzAdrhympes01gwVeDeQcbq35KEA850IoGs9NtelMPIwv8O9fNwwnY/3+dDNe0IBxYVeHRnd
 T3iveSnwnxmSCYqj4f0LhNiNTNabmdUg4RI1Ovhu5k5DURDfzLKEEd33LkoBnkzvDaQnGoUf+L+
 DURS9JYCQMtEjosfBhkww9VvBhM+AaSarQ1e805gHA4SzVLamochZdscPqGBSuhi6SmbsCRR7jN
 Ocptn3FvswKT5XuZo+ERGVN/Ss52ZrJw/wycLNARcEDzMMd1V16i0rC5XvVmCZArVAhl6J31hy8
 zQPaKUZa0XrTOuWI9et09QDwX0iBwH4bOeblxZGHx5ohBk/YjPYzqvfAeFY3Kafib5Jh5vqYEjY
 V7l/iDAjqYvzsWm3ALDiZmlcKPkA==
X-Google-Smtp-Source: AGHT+IFLcKTGGdluurfHKaVpkyPISPiobH4HQY8EBrMi62znznaGJZ5Yxn0yF1tI44/V/mo4QYwqnA==
X-Received: by 2002:a05:6000:4006:b0:42b:2e94:5a8f with SMTP id
 ffacd0b85a97d-42cb9a5593emr2463462f8f.52.1763643701506; 
 Thu, 20 Nov 2025 05:01:41 -0800 (PST)
Received: from [192.168.43.207] ([188.113.193.112])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd8e54sm5282754f8f.40.2025.11.20.05.01.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 05:01:40 -0800 (PST)
Message-ID: <5e07267f-b990-47fc-ade7-934209ea942f@gmail.com>
Date: Thu, 20 Nov 2025 18:01:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org
From: Andrey Erokhin <language.lawyer@gmail.com>
Subject: [PATCH] hw/9pfs: Follow native symlinks when security-model=mapped
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=language.lawyer@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 20 Nov 2025 09:27:05 -0500
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

A directory mounted via virtfs with security-model=mapped[-xattr|-file] can contain "native" symlinks

This can happen e.g. when booting from a rootfs directory tree (usually with writable overlay set up on the host side)

Currently, with security-model=mapped, QEMU expects that all host "symlinks" are in "mapped" format, i.e. are files containing the linked path, so it tries to open with O_NOFOLLOW and fails with ELOOP in case of a native symlink

This patch gives such cases a second chance: trying to open as a native symlink, by reusing security-model=[none|passthrough] else if branch

QEMU issues:
https://gitlab.com/qemu-project/qemu/-/issues/173 (from https://bugs.launchpad.net/qemu/+bug/1831354)
https://gitlab.com/qemu-project/qemu/-/issues/3088 (dup of the first one)


Signed-off-by: Andrey Erokhin <language.lawyer@gmail.com>


diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 31e216227c..b4f8be2c81 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -468,12 +468,14 @@ static ssize_t local_readlink(FsContext *fs_ctx, V9fsPath *fs_path,
  
          fd = local_open_nofollow(fs_ctx, fs_path->data, O_RDONLY, 0);
          if (fd == -1) {
+            if (errno == ELOOP) goto native_symlink;
              return -1;
          }
          tsize = RETRY_ON_EINTR(read(fd, (void *)buf, bufsz));
          close_preserve_errno(fd);
      } else if ((fs_ctx->export_flags & V9FS_SM_PASSTHROUGH) ||
                 (fs_ctx->export_flags & V9FS_SM_NONE)) {
+native_symlink:;
          char *dirpath = g_path_get_dirname(fs_path->data);
          char *name = g_path_get_basename(fs_path->data);
          int dirfd;


