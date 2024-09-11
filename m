Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA92EE4995
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 11:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soLU1-0005oy-NG; Wed, 11 Sep 2024 07:26:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLTx-0005b1-6T
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1soLTv-00012X-F6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 07:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726053954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUsgEtQm7fnZMudj9WjI0fHYzHDLO+OTqJXQ84p4BdI=;
 b=Ydu7rOfnOD6HB1Ut8ox4++AKUK+Bjj9AhdMg9jW34eKZgoumro+fsj3vwjiY261wuJpDqi
 ij0ngaQPD6VOTxMg86kz2tNldfK2oKl4iJofr31zc3r+RKDEfu3vuQ0XtpCImo0ZEJuRBT
 pHxUeHZ+W+ZWsTivAB9+xMuurZGXDUM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-ioDD-BgzPSqbJeNHj7v3vw-1; Wed,
 11 Sep 2024 07:25:50 -0400
X-MC-Unique: ioDD-BgzPSqbJeNHj7v3vw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D10A1956089; Wed, 11 Sep 2024 11:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94BD830001AB; Wed, 11 Sep 2024 11:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D89021E6939; Wed, 11 Sep 2024 13:25:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, arei.gonglei@huawei.com, pizhenwei@bytedance.com,
 jonathan.cameron@huawei.com, fan.ni@samsung.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, jiri@resnulli.us, jsnow@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/8] qapi/crypto: Supply missing member documentation
Date: Wed, 11 Sep 2024 13:25:40 +0200
Message-ID: <20240911112545.2248881-4-armbru@redhat.com>
In-Reply-To: <20240911112545.2248881-1-armbru@redhat.com>
References: <20240911112545.2248881-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since we neglect to document the members of QCryptoAkCipherKeyType,
their description in the QEMU QMP Reference manual is "Not
documented".  Fix that.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/crypto.json | 4 ++++
 qapi/pragma.json | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 867b09d322..9431522768 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -602,6 +602,10 @@
 #
 # The type of asymmetric keys.
 #
+# @public: public key
+#
+# @private: private key
+#
 # Since: 7.1
 ##
 { 'enum': 'QCryptoAkCipherKeyType',
diff --git a/qapi/pragma.json b/qapi/pragma.json
index f03b9cc444..625eac99df 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -64,7 +64,6 @@
         'NetClientDriver',
         'ObjectType',
         'PciMemoryRegion',
-        'QCryptoAkCipherKeyType',
         'QCryptodevBackendServiceType',
         'QKeyCode',
         'RbdAuthMode',
-- 
2.46.0


