Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47264CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LqN-0006kL-45; Wed, 24 Sep 2025 05:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpN-0005px-Aa
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpK-00055G-KV
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dSmdwGepvE9H8r72ac4KPADoXQRxf1WYajt+tsbQlxo=;
 b=C+Yz+JhA+KWpt+oiA40tl4RkM1rFObOIZn+P0ehNCBmM6H7EqJMvR+foNzMR9D0Pay7QVy
 vxjxhQnKcof8nNdDt+0+Rs/gEXzKbcXIHjmktxn8pC/QT021TM4NscY7W0JWLdjP/trHuf
 Y+a72ppgBLbLk26OgslG+vHuCTFyXe0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-b3WhJ2e3Pkmya3rqt_v5eQ-1; Wed, 24 Sep 2025 05:30:13 -0400
X-MC-Unique: b3WhJ2e3Pkmya3rqt_v5eQ-1
X-Mimecast-MFC-AGG-ID: b3WhJ2e3Pkmya3rqt_v5eQ_1758706212
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-62b77ca3f64so6554191a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706210; x=1759311010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSmdwGepvE9H8r72ac4KPADoXQRxf1WYajt+tsbQlxo=;
 b=gw59/wnlFGgtQMkeRyzTnx9HzYEONf5d1ACmzFLtHfzgXDpTQDXu+301BjGKlnMTOu
 wIKG32uIMohHff1/lPDsfQeOozH/e4HiZmX4+91fDM+4THmJ4agbC6ZOBqT708TQF2eP
 BXGyRIvSmbZTj+7CbrA7k1TLIWsB/d9er2ljnbyOhVFmTbMsbrRetwwsgVtfaYyudvjY
 IBuWr+g2m456ewtaUFKfaGFxA1I7lHrB1O9BhOkinAJHewGL3IrcWhpvg57ODudfbuuY
 YD7jz/g1v81K3MOEe3Zhhr1AiEJ7mz7s1JtxFwdDkroJ8rz2sqMTh1z2vl7Axu9Za2aC
 PMAA==
X-Gm-Message-State: AOJu0Yx34r6ANYDa/ZlGhqO36VHPIKkWB638I2Pe5s0azZahekIeqUcu
 oxQPS4M28KlUNQqv/4TPKd/rHU9Zj73kqYvP2TnmfwtWUWT9QQzn+5iusnU1tz55MIRk5k0avHv
 I6PbFdB37LQ/oNwfPMrl9Y2mXmpCMVDdExTCPxHO5+aSdJ2ZB8kPG4WDapHEgJRjvcIVSXeKRhv
 xCCI1HvkDyY9ykun9/w+pEuNvnMwwt0fAGd+Kl3jPx
X-Gm-Gg: ASbGncu9Ly1japKQyvyLreTwMEGkNZiQv0neuFCCVEKJPdEuTiHOqDWQsrLxCBH+JeB
 bJZa6zOBnWhsYTniv3U4gZa3TT04ImaderEswkmtgytsl/slxOIzdesPnaSriFTsTSguHzkzWHH
 tWAf3OrmVoqR3rf+txfuDf+x8f72v9QWXRwdITkgvAlLViEKglB32pvCb6BJbGxt1TQugV2t8qe
 VaeYluiREnjQPL4Hjze+ps6cXbviY0P0ch1fTw2dhoKfrP58HD7OuVSiAJdZYEH7DvD5/KcPe+4
 BD8Z8i0PMF/JNZn620EzqgoFLXyQBbw7iFES6vJKbMz+vWoHpNDtkyrtBPckjtJVOe+0JQt99lk
 AyKObabSUzdfxw2sh2JagLScryTZEF8Ma6MzXmeq5KvvAqQ==
X-Received: by 2002:a05:6402:324b:b0:615:6a10:f048 with SMTP id
 4fb4d7f45d1cf-63467801c85mr4221202a12.33.1758706210141; 
 Wed, 24 Sep 2025 02:30:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEw/G1iVZ7QiyE/vnosYDTU5639/gVvfD2Z1d/feOI81v0jov5GUlj4AI528rT089348XzSrw==
X-Received: by 2002:a05:6402:324b:b0:615:6a10:f048 with SMTP id
 4fb4d7f45d1cf-63467801c85mr4221176a12.33.1758706209695; 
 Wed, 24 Sep 2025 02:30:09 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62fadb1ee79sm12133259a12.33.2025.09.24.02.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:30:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 27/29] docs/code-provenance: clarify scope very early
Date: Wed, 24 Sep 2025 11:28:47 +0200
Message-ID: <20250924092850.42047-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AI policy in QEMU is not about content generators, it is about generated
content.  Other uses are explicitly not covered.  Rename the policy and clarify
its scope in the TL;DR section, as a matter of convenience to the reader.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index b5aae2e2532..dc3524ac177 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -285,8 +285,8 @@ Such tools are acceptable to use, provided there is clearly defined copyright
 and licensing for their output. Note in particular the caveats applying to AI
 content generators below.
 
-Use of AI content generators
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Use of AI-generated content
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 TL;DR:
 
@@ -294,6 +294,10 @@ TL;DR:
   believed to include or derive from AI generated content. This includes
   ChatGPT, Claude, Copilot, Llama and similar tools.**
 
+  **This policy does not apply to other uses of AI, such as researching APIs
+  or algorithms, static analysis, or debugging, provided their output is not
+  included in contributions.**
+
 The increasing prevalence of AI-assisted software development results in a
 number of difficult legal questions and risks for software projects, including
 QEMU.  Of particular concern is content generated by `Large Language Models
@@ -322,10 +326,6 @@ The QEMU project thus requires that contributors refrain from using AI content
 generators on patches intended to be submitted to the project, and will
 decline any contribution if use of AI is either known or suspected.
 
-This policy does not apply to other uses of AI, such as researching APIs or
-algorithms, static analysis, or debugging, provided their output is not to be
-included in contributions.
-
 Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
 ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
 generation agents which are built on top of such tools.
-- 
2.51.0


