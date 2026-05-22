Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA8CCD5BB5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 12:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQPR6-0004ia-Ty; Fri, 22 May 2026 08:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wQKv7-0005PE-Ts
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:07:49 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randomjack94dev@gmail.com>)
 id 1wQKv6-0002kn-I9
 for qemu-devel@nongnu.org; Fri, 22 May 2026 04:07:49 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5a62f43b76aso7875638e87.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779437266; x=1780042066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=loYQlF2qxM1tBZE5Eo5pBRl1/ffs/7Vck73oZUWkv6w=;
 b=T076DmjaPHzXosx2zT9hjx1H4T6ooplovn/HFYFmEzVShOKPl8Jz5Bd8/LVuge9RTk
 BW+wnDvn/pcC3H7SklVEsgi1C+AXodSbDzanResuOUfZKmBbDgSNHR9z/z4OrjADH+Me
 FTCLPR1/uR6ReGsfMBO0CICYel99nfrjx1GXFF+AsBq4B8HGT6dzjyd3PhdCECTue27E
 4NNelh7+O51ugI9unuiQ51JibZSEDxLlwDBoWBwiwClIUx7L1JIVlCv9kvvNNFJ/n2l/
 NSV7KfrInNKQwR5LEhDtmezGl9PB/8oK4e9LshzZWxsS0Pp3pSFNKreOJO0fSzT8mG7i
 I0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779437266; x=1780042066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=loYQlF2qxM1tBZE5Eo5pBRl1/ffs/7Vck73oZUWkv6w=;
 b=sinmV1OWfasBkhIpT6KpZbpBVdphx5Y+omg1RNU3K0IYkyOQmOEyk2EfQBc051vBdO
 HBnJBYN55WKFUVPn8XRG5BTrZnRhkk5LHg2b+XYt0A9CZFBuvuYdr0yI5xxK889kBCbb
 pmxmB0jlwBj6kJJzwJXUFQ+yjjImA5dh4OZhVDbFJBQIv4f8jOFRKVNwcu0+37pGRDgX
 /uCNTbGuQCKuNeR5YeAPb0dAQVKNas6BcWitjwOBpCnYRfb2khbyLkRaHdicvBKyd1KE
 uI7dc0G1e17Xi17vvQm6Dycmk9CxKzlh/Qk62FTg4PTrYw7r+NGY/mqIBP5gXXiQQMIV
 v4qg==
X-Gm-Message-State: AOJu0Yx/7RHjqrGAP9uDzCYHSupw/6RT+S+jvf6IgFJvCJOgsvgxJ1To
 CA+E6/YWPamVl2EMDtL7TvPM8MyRK4EsxrOndaDbHu/lumcCj39jHoStNJrjfeJLr7s=
X-Gm-Gg: Acq92OHciap2+N0r8FKirrZm96sulg5HVcQpEmOGwBnpHnGXKduimCs194UeLwLOhiO
 FHNIqjZksafnAoQm+Zpk92lhJOGi0CabFePRdy4mpKy7M9oJr3qwVT8XSrRHQeLj5Aeasha6bJn
 Kt4obYQguR+LJCCjYlaojsig7ontphUh3Uko80Fejo2aBuQm4W5Aq/aup86RGwrIHv1l52QBcn9
 fta+fcO4R50K9vMBKkyVny4RqmONnH+J1H2d3rGz5Ommcq8M91iIaxAlD1I5pzSDL+Oe6NBy/cf
 Ty1hwO8YHh3STBpgJdZgg/ujQk/NJwdNKW7t8UZbOmQi/qVVfpt/ry573FOTgXROsQd9pMPYoBs
 7sPIfQ5mD3vWkCtk+keoo4mfnjf9cgLD4fjk4JcUn0I/ErpG65gjNe/aePoonELsRIb1cBkpDwi
 d7iW9ED1r4SQZGkddtSN8ynOo=
X-Received: by 2002:ac2:5586:0:b0:5a2:c6f2:fd5a with SMTP id
 2adb3069b0e04-5aa3239b99fmr558679e87.21.1779437266002; 
 Fri, 22 May 2026 01:07:46 -0700 (PDT)
Received: from machine.. ([37.113.215.232]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cf95c9sm239722e87.78.2026.05.22.01.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 01:07:45 -0700 (PDT)
From: Evgeny Kolmakov <randomjack94dev@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, stefanha@redhat.com, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com, zhangckid@gmail.com,
 lizhijian@fujitsu.com, jasowang@redhat.com,
 Evgeny Kolmakov <randomjack94dev@gmail.com>
Subject: [PATCH 2/2] block/io: Use QEMU_LOCK_GUARD to simplify mutex handling
Date: Fri, 22 May 2026 11:06:44 +0300
Message-ID: <20260522080644.9531-3-randomjack94dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522080644.9531-1-randomjack94dev@gmail.com>
References: <20260522080644.9531-1-randomjack94dev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=randomjack94dev@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 May 2026 08:57:05 -0400
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

Replace qemu_mutex_(un)lock() calls with QEMU_LOCK_GUARD().

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
---
 block/io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index e8fb4ede4d..1020047888 100644
--- a/block/io.c
+++ b/block/io.c
@@ -719,14 +719,12 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
     Coroutine *self = qemu_coroutine_self();
     IO_CODE();
 
-    qemu_mutex_lock(&bs->reqs_lock);
+    QEMU_LOCK_GUARD(&bs->reqs_lock);
     QLIST_FOREACH(req, &bs->tracked_requests, list) {
         if (req->co == self) {
-            qemu_mutex_unlock(&bs->reqs_lock);
             return req;
         }
     }
-    qemu_mutex_unlock(&bs->reqs_lock);
 
     return NULL;
 }
-- 
2.43.0


