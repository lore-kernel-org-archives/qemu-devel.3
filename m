Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B354DC71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 00:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPrux-00060b-5m; Thu, 12 Jun 2025 20:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3CWtLaAcKClY8CA9C164CC492.0CAE2AI-12J29BCB4BI.CF4@flex--komlodi.bounces.google.com>)
 id 1uPruH-0005qi-AJ
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:29 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3CWtLaAcKClY8CA9C164CC492.0CAE2AI-12J29BCB4BI.CF4@flex--komlodi.bounces.google.com>)
 id 1uPruF-0000Zd-Nl
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 20:04:28 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-235e1d66fa6so14388205ad.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 17:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1749773065; x=1750377865; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=qzeXApkoHKyQHwiWeTNus/brrOxPdJq1kjayormL0Vs=;
 b=U6HMRmO5/2Q5kFg8xS3AKQE63dUheuOX6DAITITb/HZn7q/wp/8N9Wdpd8xOG1Thoj
 9d8Fry/dsnjSQmxHhP9piVGAwRFMylWppCEsNN5Be9muWd1PmnPkemtg6UnE6vjNJgQC
 EuoavtADB61I44GCcZUgyDWHs9yyvPtXf/nqyHcyx8qHA1x5MnCRCtNu5pJXM1TbrBgW
 +G/6O6WBgtA7WC0txHKf2J/sy1NnIMvvRxAaWa3Tn5k5P6eQPIEp9mUxTFO1lTvTu3+e
 3AQZ8jbLO66JQDvJMVzGjISJ/cCpLI5MZIFlEuvd9h55SQ1QbumLO05vKB6hU+8moEJs
 JOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749773065; x=1750377865;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qzeXApkoHKyQHwiWeTNus/brrOxPdJq1kjayormL0Vs=;
 b=Tna3q5YkJNhBEGPKG2sl2AHPbwx8wiltuEeuPE9w9pnBbdTFhxqY1RpbkQLunevu6U
 zLVjEoF2rCfwwQ1XVdLrqqh8VDfiR9FUIs5+dIrdCXML2ASiduc3T5rcTltq6tgGmq+R
 AqFz/UEsJimBIVmyY6JLSIm0BYOOWB9DZ7iUbTmbP1zW6aJJ/j5V6vEczHDWzVUlqmXd
 fOmEg+skWFOuc6YXlvqYr4Yb9xREFZI1wuklOTygw/YTE/JsZBd0dpYhdPL5J7o+5KC9
 /fUo26TeWT2j50LuNnaR22/1WfHzjj5+X+eemZDTBHcrdwjgm2rz6ylH8/HcLE+tl0hv
 lBqA==
X-Gm-Message-State: AOJu0YzUyxyrv4xbUJgGRehx/yPXU7E6JEQdxHl2ZkrAmiAWU7bPc+VX
 sMeiI7odmIpEKrcrVcMQgeflKKN6SLdmAkwC1UdNekgS9EQhQ3w9+z3Zy75WL6m/IcyQzmx4DVW
 VA5LneL6Ez19ZbJXKyOdFvsHSiD/njPoDCtrLG2MsWlLv8bLnV7X1zrI847lWPyJgg6SKk9CLWn
 HnObak4UrQxn4LhgJXBVhV9WK3537V4G0W8HpbDtwL
X-Google-Smtp-Source: AGHT+IGLKDmLbZW/qGezSxYha2G+BZmAVQInMd45qP0gEERp59ero1+jqvHP6nwox2JBl1Byld/1jiqT+PWI
X-Received: from pgbda8.prod.google.com ([2002:a05:6a02:2388:b0:b2c:4d7e:b626])
 (user=komlodi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f684:b0:234:aa5b:e7b1
 with SMTP id d9443c01a7336-2365d8ad4aamr11086965ad.18.1749773065089; Thu, 12
 Jun 2025 17:04:25 -0700 (PDT)
Date: Fri, 13 Jun 2025 00:04:01 +0000
In-Reply-To: <20250613000411.1516521-1-komlodi@google.com>
Mime-Version: 1.0
References: <20250613000411.1516521-1-komlodi@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250613000411.1516521-10-komlodi@google.com>
Subject: [PATCH 09/19] hw/i3c/dw-i3c: Treat more registers as read-as-zero
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, clg@kaod.org, 
 peter.maydell@linaro.org, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, andrew@codeconstruct.com.au, joel@jms.id.au, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3CWtLaAcKClY8CA9C164CC492.0CAE2AI-12J29BCB4BI.CF4@flex--komlodi.bounces.google.com;
 helo=mail-pl1-x649.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

RESET_CTRL and INTR_FORCE are write-only.

Signed-off-by: Joe Komlodi <komlodi@google.com>

Reviewed-by: Patrick Venture <venture@google.com>
---
 hw/i3c/dw-i3c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 4f40f999f4..bf51c00935 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -359,7 +359,10 @@ static uint64_t dw_i3c_read(void *opaque, hwaddr offset, unsigned size)
     uint64_t value;
 
     switch (addr) {
+    /* RAZ */
     case R_COMMAND_QUEUE_PORT:
+    case R_RESET_CTRL:
+    case R_INTR_FORCE:
         value = 0;
         break;
     default:
-- 
2.50.0.rc1.591.g9c95f17f64-goog


