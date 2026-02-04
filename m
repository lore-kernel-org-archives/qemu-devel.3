Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42F0EA7944
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vni9V-0005sB-PM; Wed, 04 Feb 2026 14:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9U-0005rX-TB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vni9S-0007h1-Sz
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:03:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ILMiljXUtFMJS+bsdsifeLy8ObMECoCfyJN5Gi3hDOg=;
 b=eOTDH9aVmQTbOnrnQepv8kprwQA0Sjd3ijMnUWC40WnbHr4c4td2HPBCqUc/OD/dOCiRCl
 vGzJ/ldBae4IX5vFv0SXrSzDvZMnP4cHxBvwP96hfJU9mEkdFxjkgr15R7gyZTN50jSNFp
 n7uLe3V5fzf9AAZamvh1+HuJ7crxfOA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647--vShM2N9OFuWzXqEDz1ibQ-1; Wed, 04 Feb 2026 14:02:55 -0500
X-MC-Unique: -vShM2N9OFuWzXqEDz1ibQ-1
X-Mimecast-MFC-AGG-ID: -vShM2N9OFuWzXqEDz1ibQ_1770231774
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso150596f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231774; x=1770836574; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ILMiljXUtFMJS+bsdsifeLy8ObMECoCfyJN5Gi3hDOg=;
 b=huv3qXx26tShqUNq1+20rGMYPYW2LHWaD30avL7ioLFJXnaOUp31FfZTOHpQW8s0/P
 sIF/w2iRtxwGfXAnCVjU6u7xz4H+1LWS9lLZWqID9+5dSXfdINzv9tWRwWVEaveV046p
 23vFplPjwYSQyEh9u04PAcXNxEpcJljkXMwPOdGyP34Unhjg0iNSbBYbR6nHrUSVFJwN
 A1NqAg6AZMAPlWisObryI0O75gwKd0s+jkxrriHUv3lev8qbpH9jMAy+oZEfOODbwBw7
 HPJHwWPItOiRxeX925mWgMWrkBb4NUAW7NTQ8WytZ4qib2bwO8TShUikLm5lSUSEcgOW
 L67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231774; x=1770836574;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILMiljXUtFMJS+bsdsifeLy8ObMECoCfyJN5Gi3hDOg=;
 b=nBszinFJlRN/Ml9xE4VYi9WJbZhavkxZ9GDKobLRv0y9QHzngExH5RUxXQkxU+G+0b
 Yy1Q4jW3fhg8HbhYSb5zJ4dKaE4G9PUZW7VyXoZ4oMMtMPygfZPRfjkQaMnCOeWHYwka
 h7lLWsBYXcGO1K/E2PbXWKhVw33oMh/17MGJgJDhQmr9t9AnIl+BDuS+16k5b8G3tMU7
 da8Rsw80ygHnFIWOdn33el5ERK323vMDQuclTtd4skt1Pk+Kq2ZM+lXUPtOcIsP2D/Ob
 k9HosBPXpijjKwk+5EIrwFTFld8Q4kNGjmoVby2S7GSu79r++h546ilWtpBcYEHYr9hr
 a93g==
X-Gm-Message-State: AOJu0Yz3C5xZOgTzkDaLI5tCvJAWNcTEueqnpHYAJytbj9gx8RTLPQgU
 rZv7ikYPq8tXax5mjgVehTluIZ5ZJHaOQktNBYzVuwEYRl24506oHMOdnfKhHY4I77fzTS4Ri2u
 cYOeVwNPDYz1lZcbwnIDhuxRofhv8VVIExC2KGmEUY9Mxr0uRzDSSevQZcw3pe+dLGgStUXJC4S
 6fNAb8w5PkOGLU0LbC3vM94UmNji46X0zQGQ==
X-Gm-Gg: AZuq6aKT0KXutiKexsMNqs5OpPT5wD/E6wvK+qKULkiaDeife7yZHG3HS+/mXSTqs+o
 DG0kAV+YpDo6DWD3fNKk5oB8Z3XuDO8Sj7rHE+pfGutKdrE7sviszZoF8cN+yejAjPv+C7vAiH/
 OdNlt9yMRvS/EDfdXrMrb5NQdLxJ2PtiBByu3hQrNPXC6OnieZx7uclw+Da8CzdUOsLtc6XZ0wO
 khfHhCGjKUOIzDLOqZXfcM2hDo4RHL5/a1k3pY+TsiyiX3LSmyIFlHDXQRbVNplYfdb+NVxFPTS
 2traZz0lonGI5iQNCdPTCyk0yH4c2rGFptuiUYL8SWw0+QqoCerzeXGxwOSwH92Cd418wzuBuvT
 OJQgVqWPCjwMo2hpBWFgNyNm8grn4gC9PdQ==
X-Received: by 2002:a05:600c:8b88:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-4830e93ebd2mr56399265e9.8.1770231773839; 
 Wed, 04 Feb 2026 11:02:53 -0800 (PST)
X-Received: by 2002:a05:600c:8b88:b0:47e:e20e:bb9c with SMTP id
 5b1f17b1804b1-4830e93ebd2mr56398925e9.8.1770231773356; 
 Wed, 04 Feb 2026 11:02:53 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f66sm7896393f8f.25.2026.02.04.11.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:02:52 -0800 (PST)
Date: Wed, 4 Feb 2026 14:02:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 01/51] vhost-user: ancilliary -> ancillary
Message-ID: <196ac2544107121f64eeae5dccd2e72e72d55ab5.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

My dictionary says the former spelling is incorrect.

Message-ID: <52339e58-4366-4b7c-872f-b28e05370a5d@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 93a9c8df2b..93f756d3f4 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -411,8 +411,8 @@ in the ancillary data:
 * ``VHOST_USER_SET_INFLIGHT_FD`` (if ``VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD``)
 * ``VHOST_USER_SET_DEVICE_STATE_FD``
 
-When sending file descriptors in ancilliary data, *front-end* should
-associate the ancilliary data with a ``sendmsg`` operation (or
+When sending file descriptors in ancillary data, *front-end* should
+associate the ancillary data with a ``sendmsg`` operation (or
 equivalent) that sends bytes starting with the first byte of the
 message header.  *back-end* can therefore expect that file descriptors
 will only be received in the first ``recvmsg`` operation for a message
-- 
MST


