Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9FFCD6E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 06:40:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUfHQ-0003NN-PH; Wed, 03 Jun 2026 02:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHN-0003MY-ML
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUfHL-0000ih-Jb
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 02:40:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780468837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4y/6ennxqyh6+fGPAsY9sB38dHmNtGfn1T32J7Dqc4=;
 b=ENgr5gM9qf07FxGMWBTEl28RjEtrU0CpQ8ymYiGNwGA3Dbia8B4fFekjmdiPGGRtwJ59yc
 upelL3/HV/F3iE2uRjJ8JPns3YfMAIGFOXBiR7rWEVTweJhnvx1/Luzrus2iq4nV5VRO7j
 a6LtR/k6EG1HyoTzXD2+SxC4n6qjmxU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-ZP7JcVruOEWp5cdQMsTa6g-1; Wed,
 03 Jun 2026 02:40:36 -0400
X-MC-Unique: ZP7JcVruOEWp5cdQMsTa6g-1
X-Mimecast-MFC-AGG-ID: ZP7JcVruOEWp5cdQMsTa6g_1780468835
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F2C2180049F; Wed,  3 Jun 2026 06:40:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5604414; Wed,  3 Jun 2026 06:40:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35D3021E6A02; Wed, 03 Jun 2026 08:40:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@mailo.com, pierrick.bouvier@oss.qualcomm.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 01/38] MAINTAINERS: Improve another "Overall" section
 headline
Date: Wed,  3 Jun 2026 08:39:55 +0200
Message-ID: <20260603064032.3733394-2-armbru@redhat.com>
In-Reply-To: <20260603064032.3733394-1-armbru@redhat.com>
References: <20260603064032.3733394-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Having scripts/get_maintainer.pl report "Overall" like

    $ scripts/get_maintainer.pl -f cpu-target.c
    Richard Henderson <richard.henderson@linaro.org> (maintainer:Overall)
    Paolo Bonzini <pbonzini@redhat.com> (reviewer:Overall)
    "Philippe Mathieu-Daudé" <philmd@mailo.com> (reviewer:Overall)
    qemu-devel@nongnu.org (open list:All patches CC here)

    John Doe <jdoe@example.org> (maintainer:Overall)

is less than useful.  Commit 6347e1f1cc (MAINTAINERS: Improve section
headlines, 2019-06-06) took care of the issue, but then commit
79ac391592 (MAINTAINERS: Add an 'overall' entry for accelerators,
2020-06-18) added another instance.  Take care of that one.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 75b88d07d3..3637b4a235 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -531,7 +531,7 @@ F: tests/functional/x86_64/test_kvm_xen.py
 
 Guest CPU Cores (other accelerators)
 ------------------------------------
-Overall
+Overall CPUs other accelerators
 M: Richard Henderson <richard.henderson@linaro.org>
 R: Paolo Bonzini <pbonzini@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@mailo.com>
-- 
2.54.0


