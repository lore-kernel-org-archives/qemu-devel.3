Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D74CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorj-0001G2-G3; Wed, 20 May 2026 17:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPord-0000rH-Dq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorb-0005BW-TD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779314043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+i1b5mPHmFf4rxh+RWTQ6he4SOTkWF6HcUmeuWlKoY=;
 b=ZlfzmFE5LbrXlIvAbso49jhOeMskQMtKPjVSYjAPvpwpf3CXLuKjca9956Lh9sGdZr9ELM
 v+6zJJxRXHg86TqL+q2ZAjFBJ66ebXHrFxAcHO3Rb3zPyEDlKInpybbLoaiy75JYIkYwGU
 G0zlaMSGV5UFmU3oJcgAgl55cOTr0CU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-wCzTq9oLOGuinhReFPthPw-1; Wed,
 20 May 2026 17:54:01 -0400
X-MC-Unique: wCzTq9oLOGuinhReFPthPw-1
X-Mimecast-MFC-AGG-ID: wCzTq9oLOGuinhReFPthPw_1779314041
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED62518005B5
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:54:00 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9206B1956053; Wed, 20 May 2026 21:53:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:41 +0400
Subject: [PATCH 40/40] gitlab-ci: add --disable-hmp to build-without-defaults
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-40-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=668;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mZ8OMPN2Q+JQ1r4midLfoS8ytaGoD+qhLAUx/0/VcKo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyEkW6sse0ISidGi+o47FQKHfeP8JGjb9vwx
 QcixwMk9SWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5dyYD/42lBuW4gB3E4VKJOp75IqfUN47phmnFC40xl0OdTG8AY+q9+uZB09aXOrVKIkZEZHQYMs
 SIL0ArMBnCfKBj9ZH/Ns/+QS/G+kJBYrLA1bHggiDq151CUvzMkfh+3Fg6fs2hqJAeM4tx2WGT0
 Jz5yOrQLORHfXXJkiziuPQbyDuCQba6ay9kk/J+w3YfpVts8po2rcSpGiuPkxh/3hgmGOnIcNC4
 LkLStbrNgFdlrxE48706+JszF2+NalFpI3zuPcuJ1mKlVc4fiJ6UqQOiyNbFnitsJAnISRVYAKB
 MSqsviQd18985x6vNuH1rD9mG343dv1U9kBJuiZD5M+7UXS93Mhcqlt9/bNhmbqdM4Q8goxRNQz
 OTa8kRhi4fKs6957ZqSzB/4CqWDoHlgEHT13JwIOQz6N2nYrr7XxBOC2pm9b853OEN3/lhe/QYT
 B2ew9O742tj92JiXjOH2kD4tumrPJeK6nd0CBcKZ9L+eIkw17ZXlmXQeryR3FabvCdWfdL6TwyU
 l4xeu5FhI6DZSuBAs8zf005H6w0vrDfVYTNkHNLB4xexfx37pt48wdn4vBfWwZcGTF23F2GAxCk
 wW4Ltbq0r4CrIjWheGQ/E1NEF0Wltl2fs9C89+hIgYv7+KQhVajk2LkDHlEiNOhEqj+7A0TpYZL
 qAcg26XAIMkCVdg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

Test the HMP-disabled build configuration in CI to catch
regressions when HMP is compiled out.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 4b1949a3a52..e10b68820d6 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -661,6 +661,7 @@ build-without-defaults:
       --without-default-devices
       --without-default-features
       --disable-fdt
+      --disable-hmp
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip

-- 
2.54.0


