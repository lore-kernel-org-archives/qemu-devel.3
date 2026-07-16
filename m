Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FEEC44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPm6-0005oA-49; Thu, 16 Jul 2026 13:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPm4-0005nu-Rt
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:28 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPm3-0000QF-Ib
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:21:28 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so6839877a91.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222486; x=1784827286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=Xy93dwMYNU6yTK2RmmcpaB7TPQq+CcVUG6kWa2/KazD3lZWy2E+i9IqCD6L/WYaKOX
 4Q11KIIGss6TmufOaWM/OIZu3J1IE7iAqhpAdaBFxoN3cFDF0+H9PR+/LYCsA/PkX2Bi
 3c/m0dLPt57sI0xje0+H1b7FuwEOiUMEQ/tr6Q0+fRTE2NOPskGa3Lt3kSRvW6xq4Bdv
 qEGYKn3BfCPIEdZbY5zFYW9w2YeMwtnN/MijAiqpAGWvR3uMHElYGTdgwea2gt1+Pnea
 5PoJubyMF6588dHgLvZs4LiVK+xfvcWb5YbbZ8zY2Yn5g8vogJFJXEQx/EwC0zGP0KrZ
 v7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222486; x=1784827286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=iQp4e741RWeqANR+AnBnweSrNx7Xk2H8EAfqd4DwHpY=;
 b=nz10jgTOB8TDwteJShppOZ//b8LBEccJASqAxid5L6pHRjY2cpQIdbohaV3MqOEw8S
 qrQKs2EW+uV1L9sBPs25U1LuHEwrt8yR8tcgKNqG86Nuq7g/OyoBgCLljWw2JV7ysCkS
 Hw8qwXSxQiaNKSKd/rrPutaWpTVOFp1+i+grX44aH7zIjQm3PZa3vECR9xIW+mEmjpCn
 VFflRIXBy9N2qT2cMUPIZswh4g292mnJVXoJA0vYxPzoykpoP2JdHblw+XvIoUIJNViv
 aY8kMOfJo3tB0RadLqbh2oYu3d9R88nGEDLiHiVVVXxQMTbY7yr4wE5UQa56Y/3NOxte
 dJUw==
X-Gm-Message-State: AOJu0Yxi6GlP13zkA2ySSpyU1GVQxGXV8VirBC2dxrX70i8UvlU6Oz29
 LrjBIVRNXeH8LJrpkPR4eoO6hl1XnH5VoW/NvYRIny5YF4lz87399YB0lyeLpIy6gFo=
X-Gm-Gg: AfdE7cko48nkSZt53S/IbybrF8gPHf5+fu1e1kzCfoBku5gR4pEpt7H+DTtp8zEYG0V
 7GM51FNeiTqvBuWe32DTRY2BOo2ei4sBorgYvvARLqgsrxTstFBdMTCZyfAaDe3VF8Wy/EY0THU
 agKfm6KzEMr01Lzl13UmfaxauU5oI25usQgt3uBUDKSATSRxS1mX3VJigFRkvhP9dUk0PJHILO4
 0sM/oZu76sx1sbWsNbic40ETM7EBj/XreYJyXLsgxPse5T3fteE82dfFZZ75ZuFhe/sNBefZIsb
 tdEP1x2il++osjtj55IKTln9BPT93M1S9mwNS2ahmkITRG39CM9CEttQ/ZVcQrhDztYhbIYChNz
 ODauk98y3P49UAtzn2kDxW1QsY7qoDsRoJeajZTgLX8dl8LTkEhm238G6uUkJiwvMRLI440tOUS
 5IKKpXJRra1mh9jvF8MykmP+0vwYhshQ==
X-Received: by 2002:a17:90b:534f:b0:37f:9ce2:348f with SMTP id
 98e67ed59e1d1-38e2a03cc0cmr7396998a91.32.1784222485968; 
 Thu, 16 Jul 2026 10:21:25 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.21.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:21:25 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-stable@nongnu.org
Subject: [RESEND PATCH V10 01/15] qapi/misc: Fix missed query-iothreads items
Date: Fri, 17 Jul 2026 01:20:42 +0800
Message-ID: <20260716172108.87700-2-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The example is incomplete: it misses members @poll-max-ns, @poll-grow,
@poll-shrink, @aio-max-batch.  Messed up in commit 5fc00480ab1
(monitor: add poll-* properties into query-iothreads result) and
commit 1793ad0247c (iothread: add aio-max-batch parameter).

cc: qemu-stable@nongnu.org

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 qapi/misc.json | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index 22b7afed9f..c71a5fe657 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -123,11 +123,19 @@
 #     <- { "return": [
 #              {
 #                 "id":"iothread0",
-#                 "thread-id":3134
+#                 "thread-id":3134,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              },
 #              {
 #                 "id":"iothread1",
-#                 "thread-id":3135
+#                 "thread-id":3135,
+#                 "poll-max-ns":32768,
+#                 "poll-grow":0,
+#                 "poll-shrink":0,
+#                 "aio-max-batch":0
 #              }
 #           ]
 #        }
-- 
2.49.0


