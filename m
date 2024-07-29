Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E06DC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 06:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYK0p-0007Mx-If; Mon, 29 Jul 2024 02:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYK0o-0007Jd-ML
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYK0n-0005Hz-Ai
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 02:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722235056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5rQucJ1JDx/8wmEdvMBFEgkvzAaO+b8sSTvJxn/JNM=;
 b=djUenkqtEdo908m84/JLkLFMqjdiWv895W/pWI9lg0i9gtmco/lo7KZqTaPrd78hG6Gd9z
 IMG2xWCAxHQ5sHiS4CUunA3dGmBHMrUizbTXBfDkYIlgBGPe6Bg+nAvGLmTP5Kqj6a3Pnp
 YtFGzLbDPGvUGhwdHMb4iplZFNaoBUs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-bGQRHbS5MUCpdUAqMj2jmQ-1; Mon,
 29 Jul 2024 02:37:32 -0400
X-MC-Unique: bGQRHbS5MUCpdUAqMj2jmQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC2F1955D56; Mon, 29 Jul 2024 06:37:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF9791955F40; Mon, 29 Jul 2024 06:37:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9178E21E6621; Mon, 29 Jul 2024 08:37:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 2/2] qapi/machine: Belatedly document target loongarch64 is
 since 7.1
Date: Mon, 29 Jul 2024 08:37:22 +0200
Message-ID: <20240729063722.839708-3-armbru@redhat.com>
In-Reply-To: <20240729063722.839708-1-armbru@redhat.com>
References: <20240729063722.839708-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Fixes: a8a506c39070 (hw/loongarch: Add support loongson3 virt machine type.)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240718141001.3077709-1-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 qapi/machine.json | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index f9ea6b3e97..fcfd249e2d 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -24,6 +24,8 @@
 #
 # @avr: since 5.1
 #
+# @loongarch64: since 7.1
+#
 # .. note:: The resulting QMP strings can be appended to the
 #    "qemu-system-" prefix to produce the corresponding QEMU executable
 #    name.  This is true even for "qemu-system-x86_64".
-- 
2.45.0


