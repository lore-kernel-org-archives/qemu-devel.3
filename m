Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11460A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qBvQOEL9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt9i-0000vy-Sh; Thu, 22 Oct 2026 09:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9R-0000SU-Lu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9L-00056x-Kh
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a2069b9710so6168955e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676884; x=1793281684; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8C64Oblc06d1Q4TSN2UJSTMdDiz94K+JT5y1Cg6LH64=;
 b=qBvQOEL9iVOVK9QVJUGVVMVNMktjTkaPMKgKyZ/LzVe/8/3l3Ba9NKrMujBXIWc/bh
 ue3ISyaR5egDyiqgMQlNXYlIg4FnjEu2Q2its1dgGAx2pIfWZ4FR6ohX6xHexnr1LpEN
 WRQ5cO5Udfg1LvNjCaXG0cBAQSFnaFlR3ylrb4zaz7Tzm3L+H3tw+UlC7f//hN2sfQAf
 FYbWNhrLHXbI8BsQ6axTDXUosd26vTVjxVg5eAca/qZDOikrPyKHcb9IPP2ziElAlCdJ
 TiJdHKrjuFIU5Ri1bc91gHPrc4yAjNdfQh5u/f4lPUSgF0Tq1WcdmhMUQjXiKNA8+fuP
 CElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676884; x=1793281684;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8C64Oblc06d1Q4TSN2UJSTMdDiz94K+JT5y1Cg6LH64=;
 b=OVxqNTsLCY1eKIBGldTqcpFZqnMbWchLqQasAuiiiplLav0Mh8QwkwoUT4HB6OsCMu
 EAzX9mK2opB99/JX6o7Erg/kjIo78wjncbn3kdh4ioIBdibiqBo28WxEpgAkmI//S1Kw
 GNfWb2z+Gz/OviVUVOELY541kztspNWeQw8dP+SY2ccw1PUsKq3ePFd7X4ya25AElTqE
 iz4hyQWNTg8gzNboYcIxo/yJ+KmUWVq0+iyAUo2wK08BfCrkFAuWYOnjTilixq60ldBe
 ees0rVlXnx4lB9OIAGlqWA/eaJyUi8Iwyaq6Q047v8MSulVzjvG/CXkBgSgjs8wuQ9di
 Xb5Q==
X-Gm-Message-State: AFq9FYLNgOksVXynNEwBOkKcvT13mRrdBMgzGfo6qRnRXOg2OpDaZALE
 DfdMMdCIxAz7qbZ/Lyt+yIG/kqXtfMXIPHXGb0NyiGBCnBnvKLeGEKUY
X-Gm-Gg: AYBFou3wTzd4fGtGJTXCkTB0wPGF0ZGcyL9RhZmZQfxtsJi6ZKnVdAnJA+8gqY/sidF
 06mW6r/WYfcTE3ECwBJuyyQSi5tB0oDXLMjzYht2OM6AEX3J8F9Zp1bHmd10E5G+bQHNJfc8rYC
 vIdjkxJ+QOdAjEbYrKI8PvSFUDT/EmqWpNfckwgYg4zvcK790zVKVDdzXSq10zhyoOjf26BMWMO
 59aJ9lEwySJDNs+Zvi7aJzzinxd2MQir+mlz7zlP4+1PhOSTJKb2eaouwdr60ZbxnagWCJaZYtL
 nogfI/GeFBZw3OuASftCl6LgPWvTZVYAwjv/WpcjrxAg8KMVMGB6HDLWyYGbEANSxv9wyJuhrpp
 gYiUrzfXlGGS+Z7MltkQt2p8Z7vSRZz7E1pzG93UvRmyOZlyA136sM9qjfBY64Me+BsEQ8LSI8e
 jT86PKqpU3CZHs8IStqDCQcHHMadJijsrQFlKe00c+Dp0m5W5rGwBa1Dc8N3/9Iep9X0KvgvuXk
 1AH1Bt0/ICnKUTHYDi1Y9kuD3ArhSk0g7eukbKqcQG5hVrg83o5BhucAbJo9XjCbNQmVhagW+5m
 8chDTAvDEbCj5c9GOs43xOB1ZhW8PBoZ6/cV+M0Y0/rYbIo7ipMgvBzkXa3/HJ/iHqz39At5NBn
 2Mt2YACcfVQ==
X-Received: by 2002:a05:600c:4713:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4a1fd8a675emr112398905e9.1.1792676883654; 
 Thu, 22 Oct 2026 06:48:03 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.48.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:48:03 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:24 +0200
Subject: [PATCH 3/8] io/channel-socket: only clear O_NONBLOCK on received
 fds if set
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-vhost-user-posix-v1-3-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=timpambor@gmail.com; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

After receiving descriptors with SCM_RIGHTS the socket channel resets
O_NONBLOCK on each of them with fcntl(F_SETFL).  macOS rejects F_SETFL
on POSIX shared memory descriptors, so every message carrying such a
descriptor caused the connection to drop.  Those descriptors are passed
in blocking mode anyway, so there is nothing to change on them.  Query
the flags with F_GETFL first and only issue F_SETFL when O_NONBLOCK is
actually set.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 io/channel-socket.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 7920cee639..1785fd5bfe 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -520,8 +520,23 @@ static bool qio_channel_handle_fds(int *fds, size_t nfds,
         }
 
         if (!preserve_blocking) {
-            /* O_NONBLOCK is preserved across SCM_RIGHTS so reset it */
-            if (!qemu_set_blocking(*fd, true, errp)) {
+            /*
+             * O_NONBLOCK is preserved across SCM_RIGHTS so reset it.
+             *
+             * Some descriptors reject F_SETFL outright, e.g. POSIX
+             * shared memory on macOS.  They are passed in blocking
+             * mode anyway, so only touch descriptors that have it set.
+             */
+            int flags = fcntl(*fd, F_GETFL);
+
+            if (flags < 0) {
+                error_setg_errno(errp, errno,
+                                 "Can't get file descriptor %d flags", *fd);
+                return false;
+            }
+
+            if ((flags & O_NONBLOCK) &&
+                !qemu_set_blocking(*fd, true, errp)) {
                 return false;
             }
         }

-- 
2.55.0


