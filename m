Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085B2C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 07:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2R7C-00011E-Rq; Thu, 02 May 2024 03:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s2R7B-000112-9y
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:44:25 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s2R79-0000dF-Hr
 for qemu-devel@nongnu.org; Thu, 02 May 2024 03:44:25 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-51f0b6b682fso664762e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 00:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1714635859; x=1715240659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1bvDu5ryWwLxWUvD92C2hlRURrOrB5Fy/Vxgc6TZ4wc=;
 b=e7Ukx3SJsrbAZenZVAoWAybHMi736e5c8JaHQn9K8PhpDPfd/nxMeQ4poUQn4+DGpk
 WCqSXN8lgtsn0ZDCeyB8vARbeF/Iv2pQq+AuC9LmZC6VxuqdtObG2K0MBIylGEFogbTA
 v+RKBuuje4HCX49GCy/loEu7sueHBoB6QARHjNCO2P9k0TG1zMYGr/fTJPVNEPmr98Rq
 oxK/jfAxhNFpnMbxfA43rBHETw7rFbqeV0XjtrqG2p9zzc2Gx8HXxek0KnUTQZMZmZcL
 V00WzYUl9uBB+qAsjBOTXwYLJLNRyTX08J5ERIjr7HTfiUzMHGBBIuVZkqBtl8PIPv4r
 OrRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714635859; x=1715240659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1bvDu5ryWwLxWUvD92C2hlRURrOrB5Fy/Vxgc6TZ4wc=;
 b=PEeDvj0kDH/Z5D+UVUOrskBc8SGOeUnjgT6Zx4CzY3IEh93Wx+IAwlrSSd1ejDJXNr
 3z/LU3oup8fPlNSD1xepoFk/3k63cZND6zbIhBdgKUAtsqcY488y62MfDbDk6wqvxwzZ
 /30dAOcSGZcXBZtzFI4Pn5TqnYIDubkEPJxirLHdjlyskdi+7+w+emZZHzVW/9bHIfI+
 w2h5q/2ZwofLpyL/JnnP4iiVCiI/ofjT/O5/TjLx+j9/s2xmbi93NaxXbeseXPYLIVft
 mU45jjaGQDRrVi10+5ACtJw/nDxaWmK/UYpD2g2vZRFiEqJWCGrlvuM1RuxHfFBczHfT
 VnUQ==
X-Gm-Message-State: AOJu0YwmUfiaDNAlUyvatxGwfwAnEd57KSCB8Eqpv9/AXIveMAVjtQgK
 HdvltCl1DmZuZyjXL3W8G3CLgpDxhjmxF6X59gzEQF998sVyOnqPJCI8kn8uoIRiIZ3u3xfyN/Y
 3
X-Google-Smtp-Source: AGHT+IGrSBoyq67aWJNFhg+ERE2Lk81zCkCIW5g4GbagoHzHed3nzkolkIarXlW74A03SVPgWHD5jg==
X-Received: by 2002:ac2:4c42:0:b0:518:eef0:45c0 with SMTP id
 o2-20020ac24c42000000b00518eef045c0mr1031255lfk.48.1714635859637; 
 Thu, 02 May 2024 00:44:19 -0700 (PDT)
Received: from lb01805.fkb.profitbricks.net ([212.227.34.98])
 by smtp.gmail.com with ESMTPSA id
 l17-20020adfe591000000b0034dac7e5f7bsm569465wrm.50.2024.05.02.00.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 00:44:19 -0700 (PDT)
From: Yu Zhang <yu.zhang@ionos.com>
To: qemu-devel@nongnu.org
Cc: mgalaxy@akamai.com, lizhijian@fujitsu.com, peterx@redhat.com,
 jinpu.wang@ionos.com, elmar.gerdes@ionos.com, armbru@redhat.com,
 berrange@redhat.com, Yu Zhang <yu.zhang@ionos.com>
Subject: [PATCH] MAINTAINERS: Update the reviewers for RDMA migration
Date: Thu,  2 May 2024 09:44:14 +0200
Message-Id: <20240502074414.236284-1-yu.zhang@ionos.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=2a00:1450:4864:20::136;
 envelope-from=yu.zhang@ionos.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

As the links [1][2] below stated, QEMU development community is currently
having some difficulties in maintaining the RDMA migration subsystem due
to the lack of resources (maintainers, test cases, test environment etc.)
and considering to deprecate it.

According to our user experience in the recent two years, we observed that
RDMA is capable of providing higher migration speed and lower performance
impact to a running VM, which can significantly improve the end-user's
experience during the VM live migration. We believe that RDMA still plays
a key role for the QoS and can't yet be replaced by TCP/IP for VM migration
at the moment.

Jinpu Wang is the upstream maintainer of RNBD/RTRS. He is experienced in
RDMA programming, and Yu Zhang maintains the downstream QEMU for IONOS
cloud in production.

With the consent and supports from Michael Galaxy, who has developed this
feature for QEMU, we would like to take over the maintainer's role and
create the necessary resources to maintain it further for the community.

[1] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00001.html
[2] https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg00228.html

Signed-off-by: Yu Zhang <yu.zhang@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>
Cc: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1f692202519..fa9c62aae3e1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3425,7 +3425,10 @@ F: util/userfaultfd.c
 X: migration/rdma*
 
 RDMA Migration
+R: Yu Zhang <yu.zhang@ionos.com>
+R: Jack Wang <jack.wang@ionos.com>
 R: Li Zhijian <lizhijian@fujitsu.com>
+R: Michael Galaxy <mgalaxy@akamai.com>
 R: Peter Xu <peterx@redhat.com>
 S: Odd Fixes
 F: migration/rdma*
-- 
2.34.1


