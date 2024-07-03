Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DD6C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8lu-0007qW-7q; Wed, 03 Jul 2024 18:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8ls-0007kq-PF
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8lc-0002zB-Tb
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UGyASDiFbODYa7hIKIzPzDlV0Bv9TAjx5HfpD5vtANQ=;
 b=ROcXKIAFzULHY9q0/arcs0MqoMEzARO37amDh3sSgOe2n9TF7ncKOIsEHTHyIwtR0/lpnM
 VJFsytHS9O8RrDCG09hSz1XUZFJSDr1nuohDwpkGgDVddwho7YqwfW4qq0fxw9meiXjDqG
 wGfXX2CLcLQYNBBfTIzuOMIozSVmAoY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-p2RyT2TIN7-HR1ZlKBbA5g-1; Wed, 03 Jul 2024 18:47:57 -0400
X-MC-Unique: p2RyT2TIN7-HR1ZlKBbA5g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57851ae6090so2669554a12.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:47:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046876; x=1720651676;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UGyASDiFbODYa7hIKIzPzDlV0Bv9TAjx5HfpD5vtANQ=;
 b=w9AhXB2TZbEaaWWBdeFmdC5754/OgPMQP8m3qgjXuAhplKXOK/v5D6Dm9lEOrjcG8v
 ypZYILn4JJt7BmhQ1q4RkpP5jXh9P+tR1ax13o/8hMxJKkOFGh7Hx/WRVBrgk2jcQ832
 zJbqDHgUDKFneyeAPFYV234DWqfDY7KHr/2SGdx2FOXmKqKrEpI5Z3ZSsCa7jDSr0roE
 YVH4my1zlrI2kJIOuGlFr2D/l+bBEvV01wBKely0Qr4qPw0M4g5GdTLEjaqfTkAW22Bd
 rYsKAmhKvyis+iqSmAsctt6EOX2QuQiqhuk1jTGR0wQKntep+Z26EGgOCN4haMypNYqi
 Qaow==
X-Gm-Message-State: AOJu0Yy8X4Gwb3DqSl20qGt2CFebiQvj9L48zy6XzwpB9VycFeP11SyU
 Zia5iFEEtGrRuFEmsTgRnr0X/CuL40FZ4B2RmCijqQf09q9jWGkzAr0AAiBr/TQQcds/fwssB5e
 HmNkSwsDF94W1Q62QI2tHVi//mCtwUFam+mYB6NaeCdrzndIg0cdt6/0Ea4QHhU/ZnYh8PLAj2Q
 7kWW7Fyv6vQrXmYlNCrGrLBZv795WhcA==
X-Received: by 2002:a05:6402:34d5:b0:57c:7ed7:897a with SMTP id
 4fb4d7f45d1cf-587a0635e59mr9511008a12.27.1720046876108; 
 Wed, 03 Jul 2024 15:47:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFddIdSxHvSZopxh2efHwEdaQjBLMxvfF26rQtKChqYpQvHtnDe4DGhezKvxkfjrjbZnzJKqw==
X-Received: by 2002:a05:6402:34d5:b0:57c:7ed7:897a with SMTP id
 4fb4d7f45d1cf-587a0635e59mr9510990a12.27.1720046875537; 
 Wed, 03 Jul 2024 15:47:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58612c835dfsm7620813a12.20.2024.07.03.15.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:47:55 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:47:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>
Subject: [PULL v3 46/85] qapi: clarify that the default is backend dependent
Message-ID: <0aa7f10c7af222a32e49e38df8383e394a0aa5c3.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

The default value of the @share option of the @MemoryBackendProperties
really depends on the backend type, so let's document the default
values in the same place where we define the option to avoid
dispersing the information.

Cc: David Hildenbrand <david@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-2-sgarzare@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/qom.json | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 8bd299265e..9b8f6a7ab5 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -600,7 +600,9 @@
 #     preallocation threads (default: none) (since 7.2)
 #
 # @share: if false, the memory is private to QEMU; if true, it is
-#     shared (default: false)
+#     shared (default false for backends memory-backend-file and
+#     memory-backend-ram, true for backends memory-backend-epc and
+#     memory-backend-memfd)
 #
 # @reserve: if true, reserve swap space (or huge pages) if applicable
 #     (default: true) (since 6.1)
@@ -700,8 +702,6 @@
 #
 # Properties for memory-backend-memfd objects.
 #
-# The @share boolean option is true by default with memfd.
-#
 # @hugetlb: if true, the file to be created resides in the hugetlbfs
 #     filesystem (default: false)
 #
@@ -726,8 +726,6 @@
 #
 # Properties for memory-backend-epc objects.
 #
-# The @share boolean option is true by default with epc
-#
 # The @merge boolean option is false by default with epc
 #
 # The @dump boolean option is false by default with epc
-- 
MST


