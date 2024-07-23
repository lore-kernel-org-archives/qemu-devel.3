Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B3CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 16:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWIYg-0006sQ-EV; Tue, 23 Jul 2024 12:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWIYZ-0006mJ-Cn
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1sWIYP-0001YF-91
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 12:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721752795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SGTSsnU7IzUczG7GKAokId4CNGsKIlF6nc34Cio1mnQ=;
 b=Atmmt4t0ZtWuCPDw8YghkRbrKYpqUA1hMCn1DpfF4FqgiqSSVW667hmsJ9iUcgqvw7MA1l
 n7WS6QyGw44dwrUSLHEONlfMVOgKXhmbMm7tV1wCt/f7SQ1Lo+UiBNUbXENXHBAv1ThDPf
 oOV4DC90tTmA66gWkxLiYK9QJ76l3rs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-_ROfWzjHNC-Mpl4Wlu9hhg-1; Tue, 23 Jul 2024 12:39:54 -0400
X-MC-Unique: _ROfWzjHNC-Mpl4Wlu9hhg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42794cb8251so45690195e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 09:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721752790; x=1722357590;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SGTSsnU7IzUczG7GKAokId4CNGsKIlF6nc34Cio1mnQ=;
 b=rq+5H7YLHbaiUf9tqmr7wWYVjlsszu9n6tqqWAd0YLI38xGnNSVi02dV4FxxcXDR4L
 zJMk28rDN7+rZaIrzg9HHLfAtN3EE+jbq0ZMl+P7cImc6kgazJfTPcIJ6JMR/BLzrD19
 SUHKlyTWiUnGkxL7mPyoKlBLv8vBGfMumWdoXvoUOu3sM9JplMcWkwYuGA4YyVaXKvlQ
 O1ReFCKOUJDNfPbb0X4n83lW1iWL2uEBhCQSxjSsyuM/Xw54Ut4P1xPGMN+7La5sXnSk
 RFnO9jncfPL7OOwIYeTr76xyN8z9rfSLFXD+/1ErR59JP6gdAj0ODkP9zIaQ+r2hb4jC
 SA4g==
X-Gm-Message-State: AOJu0YwX8ObJdmZHz9WIGOuIsoXmI8wA+gh0KYyHLL4gWcq9jZjNQqAR
 O8II1BT3WHmedTPtqK6rf3JZtjTnBnWvuUIkUKc3Pds/TH/xikkxleodabAXay6DUqSFzkO4mMZ
 LigXW4ZhG9zdeCGGTOn23Kq1f8hLGgx3Nnv69iqBHYpAcSNRM4HKoBIKLX+YFpHvdisnkgZeWQK
 jYWATEeYnVRCl0gf1NgBVAd528m/3rJDicVA==
X-Received: by 2002:a05:600c:4f0c:b0:426:5f8f:51a4 with SMTP id
 5b1f17b1804b1-427daa2815cmr63475415e9.12.1721752790672; 
 Tue, 23 Jul 2024 09:39:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExGvcB9WZ3pMXoee+ZTAFTrxea7wH+qLKZSBSBX6Eg7LJ/8ouhXgDveN6Pzn/yph+08EQMpw==
X-Received: by 2002:a05:600c:4f0c:b0:426:5f8f:51a4 with SMTP id
 5b1f17b1804b1-427daa2815cmr63475145e9.12.1721752790006; 
 Tue, 23 Jul 2024 09:39:50 -0700 (PDT)
Received: from localhost
 (p200300cfd74b1cd04af1f18b763c5dac.dip0.t-ipconnect.de.
 [2003:cf:d74b:1cd0:4af1:f18b:763c:5dac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d7263687sm178773225e9.4.2024.07.23.09.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 09:39:48 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 0/2] virtio: Always reset vhost devices
Date: Tue, 23 Jul 2024 18:39:38 +0200
Message-ID: <20240723163941.48775-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

As explained in patch 2 (the main one) of this series, we currently
don’t issue the RESET_DEVICE command to vhost back-ends, even though we
fully intend to do so.

The problem is that sending this command is gated behind a vhost_started
check, but at that point (during the device reset process), the device
is actually stopped, and so vhost_started is false.  We still want to
send RESET_DEVICE there, so patch 2 removes the vhost_started condition.

This means that we need to be able to call VirtioDeviceClass.get_vhost()
when vhost_started is false.  For most .get_vhost() implementations,
that’s perfectly fine; but three of them (crypto, gpu, net) dereference
some pointers, so if any of them is NULL, we have to explicitly return
NULL in those implementations.  That’s what patch 1 is for.


This time, I’ve run `make check` with ubsan; I can confirm that v1
generated errors for vhost-net, but with patch 1 added, it’s clean.
I’ve also run the CI pipeline:
https://gitlab.com/hreitz/qemu/-/pipelines/1384524949
Specifically, clang-system passed:
https://gitlab.com/hreitz/qemu/-/jobs/7406688234
The only failure is msys2-64bit, which timed out (re-tried repeatedly),
but judging from https://gitlab.com/qemu-project/qemu/-/pipelines, I
think that’s expected.


v2: Added patch 1, left patch 2 unchanged.


Hanna Czenczek (2):
  virtio: Allow .get_vhost() without vhost_started
  virtio: Always reset vhost devices

 include/hw/virtio/virtio.h  |  1 +
 hw/display/vhost-user-gpu.c |  2 +-
 hw/net/virtio-net.c         | 19 +++++++++++++++++--
 hw/virtio/virtio-crypto.c   | 18 +++++++++++++++---
 hw/virtio/virtio.c          |  8 ++++++--
 5 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.45.2


