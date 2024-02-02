Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315A2C47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVuci-0007Ew-MF; Fri, 02 Feb 2024 09:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVucg-0007Ed-IQ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:30 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rVuce-0003X4-06
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:34:30 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5bdbe2de25fso2003379a12.3
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 06:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1706884343; x=1707489143;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PWIhENDvXfMFSWtCO6YUY0woaTX98rtfuiZ8IDwKSl8=;
 b=bVQbkrEqWhYVPXj/c/7lj7s4gCyw+7lM9a08tHQov+cL5raTqf8DlqVE20pm6lapfI
 RDZPgtnkc3Y+GCPKFiBJSYpWM/VhLRcNCChsWQJsWlQxqp22lZRrNzBgduesuG9DD0Ba
 WvduV8wTsX7mtgnFmTK3rM4/LnwEDAgN8MrKn4wBpDrMmXgqnXyckXRP8aczdp8oQsP8
 WPJRWSf6ziL8Iyk157ZevPF48fMLqblSNseAfMPuIuZeiUSBRmCapVseC5O98AXWzkkM
 L8PiFyfU7593zzI5P3gqDUamMI0rXghcrsBUTx8+rPuoHTOTV2+IKV8uxC69GE7gGQU8
 bAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706884343; x=1707489143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PWIhENDvXfMFSWtCO6YUY0woaTX98rtfuiZ8IDwKSl8=;
 b=M3ocrV03ph9iE+g8LZvNJQB3RF5YknZn/WrLviStRUtV/ZcgxLACtWws5mMiWKJTq0
 YJGk5dTkG8IdXQaI60zTqdliSwk/Xq5NPz2u3HxJPHI/I9gwxixMvGnrbPhShOHPH4ic
 bLaTPPiFos9EUAyi8ki8y6JGp6EfUe5qkV2JhFMNB1lZq3YEilN6dPaHqe3jOJ3nYkNp
 sp8PVkmjCMOAFa3tU/+ThESil+1FiDz719v7ww7xyZNekc2+fZ/Hv1c7MYADnf8o90FE
 bTpaceyXoiaL1nY+I8CTbrZODs7hcc7TzaPoSvON18iXxTLnF31omEKV97Mx//dxkuJa
 jNqw==
X-Gm-Message-State: AOJu0YyFvfrd4qh0ZzqxQrfFvbUUDNL027+uBRMIDcu4sxe1cFUtt94F
 4W4z3ku4BW22TJF2eqOSm9ZNDXMLXFTNH+MhLX6WnMMTxEUkrkZLx28zBJWuiXOGi1cIBC++Q3Z
 x9xoWSA==
X-Google-Smtp-Source: AGHT+IEDHFd7S46+3iO8juUvFmWhaxmjdQoJFVqH21ZoGUyTW7iA7fcnklTfQysqaeDBBRNVk9nZ7Q==
X-Received: by 2002:aa7:8155:0:b0:6df:edcd:f44c with SMTP id
 d21-20020aa78155000000b006dfedcdf44cmr2411635pfn.6.1706884342759; 
 Fri, 02 Feb 2024 06:32:22 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUUSmbrf4xSri8oNplYdvK2jwVmdgBKOmjS1hZztyd+Tikio6dmbjPzoffCYO12c8rhtkmCtWThW2nrYHwBy6JGHI9McBZhBkC67Tjkc+6UGLmLrSpAesXyqWy//FWU62KaBE/F/64PLw==
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 f32-20020a056a000b2000b006dde023cce8sm1684703pfu.57.2024.02.02.06.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 06:32:22 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH v3 0/3] Adjust the output of x-query-virtio-status
Date: Fri,  2 Feb 2024 22:32:14 +0800
Message-Id: <cover.1706883915.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Sorry for the late post of version 3. The modifications are as follows:

v3:
- Rebase on master
- Use the refined commit message furnished by Markus for [PATCH v2 1/2] 
- Drop the [PATCH v2 2/2]
- Add [PATCH v3 2/3] to declare the decoding functions to static
- Add [PATCH v3 3/3] to Define VhostDeviceProtocols and
  VirtioDeviceFeatures as plain C types

Since Markus inspired all of the alterations above, we would like to
thank him for his contribution to this series.

Please review,
Yong

v2:
- Changing the hmp_virtio_dump_xxx function signatures to implement
  the bitmap decoding, suggested by Philippe. 

This patchset is derived from the series:
https://lore.kernel.org/qemu-devel/cover.1699793550.git.yong.huang@smartx.com/
Please go to the link to see more background information.

The following points are what we have done in the patchset:
1. Take the policy of adding human-readable output just in HMP.
2. For the HMP output, display the human-readable information and
   drop the unknown bits in practice.
3. For the QMP output, remove the descriptive strings and only
   display bits encoded as numbers.

Hyman Huang (3):
  qmp: Switch x-query-virtio-status back to numeric encoding
  virtio: Declare the decoding functions to static
  qapi: Define VhostDeviceProtocols and VirtioDeviceFeatures as plain C
    types

 hw/virtio/meson.build       |   3 +-
 hw/virtio/virtio-hmp-cmds.c | 702 +++++++++++++++++++++++++++++++++++-
 hw/virtio/virtio-qmp.c      | 684 +----------------------------------
 hw/virtio/virtio-qmp.h      |   3 -
 qapi/virtio.json            | 231 +-----------
 5 files changed, 723 insertions(+), 900 deletions(-)

-- 
2.31.1


