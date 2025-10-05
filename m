Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A6CCAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UDQ-0007Q6-IB; Sun, 05 Oct 2025 15:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDN-0007OW-R1
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UDM-0006Kq-AM
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9X9dIbEl6s4Z3IkjW3gtvVAsBNJXdx9I4ylsa8ctmA=;
 b=Gq005mLTynf2QwTyB3o3+fwUpXpUefwWAa4/lM1lOL5tsit1Yz38fHxaf99tVoT/1AKSSm
 s9uMUMc2a5FlXGsAq35yVj34NDwfN9j1cRBWl3qxhLpVV/yy0ihxGFhswdLgtihdTvt4ry
 kP260pYUZvgIPSwdwxru2iP8lRUDUb4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-9LVe8Q7GN9KZ0_BeGXzLUA-1; Sun, 05 Oct 2025 15:16:10 -0400
X-MC-Unique: 9LVe8Q7GN9KZ0_BeGXzLUA-1
X-Mimecast-MFC-AGG-ID: 9LVe8Q7GN9KZ0_BeGXzLUA_1759691769
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ee12ab7f33so2159087f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691769; x=1760296569;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9X9dIbEl6s4Z3IkjW3gtvVAsBNJXdx9I4ylsa8ctmA=;
 b=aBiPghS9svI3SQScQBFbUII/BQtRTc32fSgv18E7OqIwHn5Zg4tMrPmPpLrp4v44Uz
 8Zbu10WwZWajSCoBjltpDZ+o1EA9ywsZMd9zRlF26q42yQ5/OjsyzDUUT69i5+DsMCHD
 YP4UeL+Aex1GLXpuPL8ESHBpgpbGMl3zYkGQu+SBNnWtESWILxoLF0G9fqReElONp4op
 Cb44pjKMgWY7BSMabzSnqC6BgACB+zIGJzPG09U377lO9oRIZwJTXkbKRHwK6F9r5RWB
 K4KDtghrA4IhIVoUU9cfSZH42bN/66Zds5Pmw3pIQv+fA8jdHcfHHNvAuwSJMCI+g9kP
 b/LA==
X-Gm-Message-State: AOJu0YwAvKLvI6zwm58+yWSyWKnfFOgMOfIL/deFQgrk6Z4Y1U7DS6mt
 AP8slSHHClWvwAvW+UvMvhhY3kuO6FmEaU0EXYEUvtVfcfFl++sZl96kYwcS/zDGDNMdzjgLP3e
 QAL6Rd6EuNRZ6yoCdieYegpIjlwXrFfk+keu/+GCNWgoOe406IO63g0+ZtDuWOn+wZ1qJr1L30w
 wCJn0Ai0LYjKxNq1WbQkmt8jreRqMpaEe3Bg==
X-Gm-Gg: ASbGncu+Bks7PQwRtWzTiWTyH6lzEOzjly6Xx6Fq2jARz35LTEBwpn0/KA5a6988vlC
 AWhmF6za2kO+1ugAfqep+LZd8paPPaEObieMiXD0sP+KzWz5tMinhnLfJsAYCz5jBaiBNJ34wD2
 5MYx4dGrJd01P0ZoSeHqUkPPl7aYTYi/cbnkd3DNkly6t95HEErnLii+u94Hh6U6sNWrMQUQnpe
 8ZazRZTF31c9nr28cvXOT4znHsMa9zJSmeHmyX8UNYvnrBt7OzAySrN5+NdwR168f6rLq7BOwNC
 bnjrLVcA18R1j/fle31kbM/Sk5lEnybyYgSqkCU=
X-Received: by 2002:a05:6000:2401:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-4256719e9c6mr5917257f8f.32.1759691768659; 
 Sun, 05 Oct 2025 12:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOjobanu4yMzNe/1zq5h6ZXPy/A/BH9w8F+1A+e/yvEMTagvhieTZaj1Hz/o6LB4SeNmPQaw==
X-Received: by 2002:a05:6000:2401:b0:3ea:e0fd:28e8 with SMTP id
 ffacd0b85a97d-4256719e9c6mr5917238f8f.32.1759691768061; 
 Sun, 05 Oct 2025 12:16:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e9762sm17448010f8f.38.2025.10.05.12.16.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:16:07 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:16:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Abeni <pabeni@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 02/75] linux-headers: deal with counted_by annotation
Message-ID: <c3d9dcd87f0d228ea3ac5a42076da829cff401f0.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Abeni <pabeni@redhat.com>

Such annotation is present into the kernel uAPI headers since
v6.7, and will be used soon by the vhost_type.h. Deal with it
just stripping it.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <a1430f43cc954d2a931fa60581bda6d6af4bc771.1758549625.git.pabeni@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 scripts/update-linux-headers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 717c379f9e..64c0d7c4eb 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -90,6 +90,7 @@ cp_portable() {
         -e 's/<linux\/\([^>]*\)>/"standard-headers\/linux\/\1"/' \
         -e "$arch_cmd" \
         -e 's/__bitwise//' \
+        -e 's/__counted_by(\w*)//' \
         -e 's/__attribute__((packed))/QEMU_PACKED/' \
         -e 's/__inline__/inline/' \
         -e 's/__BITS_PER_LONG/HOST_LONG_BITS/' \
-- 
MST


