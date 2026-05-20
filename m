Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF974CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoqO-0006ik-9K; Wed, 20 May 2026 17:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoqA-0006Pb-QF
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPoq9-0004nV-24
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Au1bjnYBq8gJVhKy/ShzJcY2FC4Rk+tKFMcIE9soNJ0=;
 b=T6WunwTiMqKqJhWAEn0PEPLHP/+bWUU0lFJBs5H8oYJao6Aj1Lcw3EeHro5zr0XXRzZuWM
 KNbfMRq3syC7ZkZIQMeT3yp9vjAIbJjZCvq8F1HxcpMAH24DAKjqFAqXNUjMn4eQKDNUM7
 fNw+CHW71Hml+oiU0dS4zzy/6Gh2KVk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-A7P6BIwXORiiiFswbPkWpw-1; Wed,
 20 May 2026 17:52:30 -0400
X-MC-Unique: A7P6BIwXORiiiFswbPkWpw-1
X-Mimecast-MFC-AGG-ID: A7P6BIwXORiiiFswbPkWpw_1779313950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A5921956050
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:52:30 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB94B180075C; Wed, 20 May 2026 21:52:28 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:25 +0400
Subject: [PATCH 24/40] tests/qtest/pnv: drop unnecessary -serial mon:stdio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-24-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1624;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=y+jBGoxcJrIQ2FfjIUXDStP648LleiEG2EggA9iCaEo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDhh/NFkfk+etAqOpIMlKIyu0VqbpLDlrrT
 GINiF2nFEiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5UlMD/41fiNbstgLNEYkQTxWSAtcLsxrHMj/u7Fx32wbzvWcfVPlKsil1B0BEFuY/ZeRml0t/62
 E66DPodgaWVueSHQmv8ctnRFNwt50F8cQ8BPdgJ1TGge417PW+JuIxppzV1fVVi3NURlPQk+F6W
 8PwKkVD/z6ud+nEf7eTcBjmiZNv1lTkrKd20CKgBSiDyFGGTN5VjcjH6tke/hkrj/JXRuwN8jNZ
 KRNNp1BYj9lMyavo5eeGkSRVa54ymu0uy35FeZUedmXUb5Biyz5KTC48sp+/Ulm1OGRDqe5yswF
 OtENL/CfiFEuaMiewasERhb3S/M5EzS8jthwkGeqYFUgCDk+shM1BSAs5sqUvwiYLIcNx7wdZ/4
 tpcXCUSHeK91tWhvpOyZl9wUlq0Oz62Jfnq0a3G1EqbFPhWLGKXLMQE7RpWjOKcJmvpyXl/xfmz
 ghJsDNOqYOLuJka/T0Tpq0InKAVMskb4P4eA3CufW5l9C33+lKyVoIChTvs84dW+hXlkvwM4xY9
 0LkuncD5rEfA+Svjuv+eoXHpiF0Cu+5cvL4wg+yLeGHlkx0/x+r/qGTNIv9mBN9bVDLvxIUP/V2
 Hb+HrYQrX6JZi/IbOi/egyuTOiwXvOsBtbF06/IcyYgZJXR4H0oRnc+qU7gsOSsX/MYeZIw6Qzr
 4snWDrLI/dK60DQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The pnv-xive2-test and pnv-host-i2c-test pass "-serial mon:stdio"
but never use HMP commands. The "mon:" chardev prefix creates an
HMP monitor mux, which fails when HMP is disabled. Other pnv tests
(e.g. pnv-spi-seeprom-test) don't specify -serial at all.

Drop the unnecessary -serial mon:stdio option.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/pnv-host-i2c-test.c | 2 +-
 tests/qtest/pnv-xive2-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 51e613ebdcb..368d1a91401 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -415,7 +415,7 @@ static void test_host_i2c(const void *data)
     }
 
     qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
-                      "-nodefaults -serial mon:stdio -S "
+                      "-nodefaults -S "
                       "-d guest_errors",
                       machine, SMT, SMT);
 
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index 5313d4ef18b..b4f4b601c2a 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -549,7 +549,7 @@ static void test_xive(void)
     QTestState *qts;
 
     qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
-                      "-nodefaults -serial mon:stdio -S "
+                      "-nodefaults -S "
                       "-d guest_errors -trace '*xive*'",
                       SMT, SMT);
     init_xive(qts);

-- 
2.54.0


