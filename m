Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE197C624C6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzU7-0001Ks-6o; Mon, 02 Mar 2026 04:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU5-0001Je-QH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:37 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU3-0007hf-Ot
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:37 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48370174e18so23233225e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 01:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772443354; x=1773048154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlEaot0Az2g5Lcmwus88Zh0yOjbHLCxHpraQxrLX9JA=;
 b=ZQgDHMUEjPYCMV/vN4gcsHqFzVFlocxIrLpFaoJe1U1As+cwSDZJyOmDVlNZqxD9TY
 vFAX6od6mwUAlQLJOkeuDPOXAVg8iYA8V/LzVEIAn2M0Wf1q+Lgjc6dzgzMOWr5ZAYSu
 vfG2SNtTKUgB6Ugpsu7yBrdqA7weBQxkEnSvestEeUeSxhoc30A382jXWqBNWNizxY8H
 PEuokdsuzPlORbuH0gwTkBFJ/p71t8CPCsluWdu0OmOONBunozwnPe6GHECZA4sm8DaY
 T3GNKFrcM06hzFtIpVIt1t2S3BeJ63hpQXa2ay6a0vV+SnQg0g6MextZ93/dFBxgYeeY
 qxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772443354; x=1773048154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HlEaot0Az2g5Lcmwus88Zh0yOjbHLCxHpraQxrLX9JA=;
 b=neTGxJhRZ2dGsNI+u0X4Qhwqz8C/uRbfpt63/IXg7C/OHD2r4tNN6870YdzJ2HYjKc
 +K0FukJr7m08WxwPUAUpeHl134c+x9F5JN5tveaZ2yebt+A/nIT9Gd4aHWRJpEjl65aR
 kJ7m+3PdtUrViIf2fhhf8n3e5P6dZYPQkwr2WuwZQ4pNftO+L2MyAjuWgVlDKNhmKV7B
 ENzWBqi5YpUgwgw+Yl7LBSxeA6n+/0pvvuzv3qYyb46TFwyNpgNilX6oBen+8eHVjxN6
 wZuzAMuSEiI+7tboA5DBuda1vMJIGGVT6H6BznM1vh0n2q7KE1g50U30p+sTHY1vPBL/
 FEcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTsrfDuPwID+624SGg32U7YF7dDbVp8a0baih29qhp1mpJzONi1UssdPADSOiGuTiiznSfDgbERYMQ@nongnu.org
X-Gm-Message-State: AOJu0YzDQaKEKClOGWlRbKnaWVU0x8t5gQFGjDQKgIxOq672CSNNdAJq
 e5GFCY4ykMFl3fecx3qVZAATGZX1gsUoqAf5HFbhE9mJ0CTMRAxCClaFNxGeIFfBvj0=
X-Gm-Gg: ATEYQzxCr4k8i4nPYWt8ntrNqmTDWXJ/xk/f7C2IwlQj9Vc6o8Alhj/H2f7nOs+kpjW
 bVv37eIub2Y68ObHvErO/QUto3/RrTB/QyGNLi16eMCBPCv8BJsqgCzIf2oTreIVVfos3wa3Y6Z
 z6RDn9O2WkZra7dse8WjgH7OLFUSUO7vwGR5OF3yHz0YQh5vUkPHbmkdITI0xMBDydXfDgHx0mp
 AE8YmivI/E7s6yR/c//8LRi/P05x2w70FE0OGHQsecYoiQFYGCM4qa7dyuziaBG0pea5c6L7h6f
 OwtGecNnOb3aTgr1MBhpe9vpiOJA/OGwdaWA2ntPzRNzKioG4dKZvoEqzvqlQR3vgI3rKY9FcYJ
 a3kDpXaFPqdoOImvoliMmjFfvEqh9zqeuBvtSs/xADoYheLm5aOy3fEHXtwVlG1cTO74ng99/TO
 aunXLlb1QdJMhVfOE13vIb3GfIl3IOMWBL0ZfCo9A2IuG2abddvJZZOzVTYz/b9iWVkn35aJJ56
 TParigtfaq1VEx+0tBQrnOfpEXCNWM=
X-Received: by 2002:a05:600c:6488:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-483c9bbc297mr214797835e9.17.1772443354251; 
 Mon, 02 Mar 2026 01:22:34 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb9d9c6sm129435305e9.14.2026.03.02.01.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 01:22:33 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 6/9] chardev: Don't attempt to unregister yank function
 more than once
Date: Mon,  2 Mar 2026 09:22:22 +0000
Message-ID: <20260302092225.4088227-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302092225.4088227-1-peter.maydell@linaro.org>
References: <20260302092225.4088227-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

tcp_chr_free_connection() can be called multiple times in succession,
in which case the yank function will get as argument a NULL s->sioc
that has been cleared by the previous tcp_chr_free_connection() call.

This leads to an abort() at yank_unregister_function().

 #0  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
 #1  __GI_abort () at abort.c:79
 #2  qtest_check_status (s=0x513000005600) at ../tests/qtest/libqtest.c:209
 #3  qtest_wait_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:273
 #4  qtest_kill_qemu (s=0x513000005600) at ../tests/qtest/libqtest.c:285
 #5  kill_qemu_hook_func (s=0x513000005600) at ../tests/qtest/libqtest.c:294
 #6  g_hook_list_invoke (hook_list=0x55ea9cc750c0 <abrt_hooks>, may_recurse=0) at ../glib/ghook.c:534
 #7  sigabrt_handler (signo=6) at ../tests/qtest/libqtest.c:299
 #8  <signal handler called>
 #9  __GI_raise (sig=6) at ../sysdeps/unix/sysv/linux/raise.c:51
 #10 __GI_abort () at abort.c:79
 #11 yank_unregister_function (instance=0x7fb26f2ea9a0,
     func=0x55ea9bcc0a10 <char_socket_yank_iochannel>, opaque=0x0) at
     ../util/yank.c:151
 #12 tcp_chr_free_connection (chr=0x51300000ffc0) at ../chardev/char-socket.c:385
 #13 tcp_chr_disconnect_locked (chr=0x51300000ffc0) at ../chardev/char-socket.c:477
 #14 tcp_chr_disconnect (chr=0x51300000ffc0) at ../chardev/char-socket.c:495
 #15 tcp_chr_hup (channel=0x514000000040, cond=G_IO_HUP, opaque=0x51300000ffc0) at ../chardev/char-socket.c:536
 #16 qio_channel_fd_source_dispatch (source=0x50c0000b5fc0, callback=0x55ea9bcd6770 <tcp_chr_hup>,
     user_data=0x51300000ffc0) at ../io/channel-watch.c:84
 #17 g_main_dispatch (context=0x50f000000040) at ../glib/gmain.c:3381
 #18 g_main_context_dispatch (context=context@entry=0x50f000000040) at ../glib/gmain.c:4099
 #19 g_main_context_iterate (context=0x50f000000040, block=block@entry=1, dispatch=dispatch@entry=1,
     self=<optimized out>) at ../glib/gmain.c:4175
 #20 g_main_loop_run (loop=0x502000055690) at ../glib/gmain.c:4373

Commit ebae6477dc ("chardev: check if the chardev is registered for
yanking") seems to have encountered a similar issue, but checking
s->registered_yank is not a complete solution because that flag
pertains to the yank instance, not to each individual function.

Skip the yank_unregister_function() in case s->sioc is already NULL,
which indicates the last yank function was already removed.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[PMM: rebased]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 chardev/char-socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 5adeb90865..4e82915cf1 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -370,7 +370,8 @@ static void tcp_chr_free_connection(Chardev *chr)
 
     tcp_chr_set_msgfds(chr, NULL, 0);
     remove_fd_in_watch(chr);
-    if (s->registered_yank &&
+
+    if (s->registered_yank && s->sioc &&
         (s->state == TCP_CHARDEV_STATE_CONNECTING
         || s->state == TCP_CHARDEV_STATE_CONNECTED)) {
         yank_unregister_function(CHARDEV_YANK_INSTANCE(chr->label),
-- 
2.43.0


