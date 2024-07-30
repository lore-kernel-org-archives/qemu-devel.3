Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F780C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhut-0007ek-6w; Tue, 30 Jul 2024 04:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYhur-0007cy-6m
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:09:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sYhup-0000n8-CB
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:09:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722326942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G2XFoWO1RnzCf9nM638IfpNE7Al6JEMVmLtPhwe6U+Q=;
 b=XXavOUkQIwE1suns/AQZhEcD+puV+U+J3Ec31/J9ufP6V/+Zo4k8fFTB8QvWI7B3VZ/sxo
 Vma82uPbVQOGOXL8xHFbxeeEjeyvsLX6ifQQae3x2Os7G/kdQxe21BUHmDP+qbI+uXx+PT
 KaT9u2yWlPg3uzcHPE95Vl1UZ1SoWB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-l_cyo9kaOP2C3FV39-TMeg-1; Tue,
 30 Jul 2024 04:08:59 -0400
X-MC-Unique: l_cyo9kaOP2C3FV39-TMeg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 476B81955D4D; Tue, 30 Jul 2024 08:08:58 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.34])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1F9D1955F3B; Tue, 30 Jul 2024 08:08:54 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Collin Walling <walling@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 0/1] s390x updates
Date: Tue, 30 Jul 2024 10:08:51 +0200
Message-ID: <20240730080852.649251-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 8e466dd092469e5ab0f355775c571ea96f3a8e23:

  gitlab-ci: Use -fno-sanitize=function in the clang-user job (2024-07-26 09:35:27 +1000)

are available in the Git repository at:

  https://github.com/davidhildenbrand/qemu.git tags/s390x-20240730

for you to fetch changes up to 442110bc6f3f308aedf884103fdba87ba906dfe7:

  target/s390x: move @deprecated-props to CpuModelExpansion Info (2024-07-29 21:47:16 +0200)

----------------------------------------------------------------
s390x updates:
- fixup for a s390x-only query-cpu-model-expansion extension

----------------------------------------------------------------
Collin L. Walling (1):
  target/s390x: move @deprecated-props to CpuModelExpansion Info

 qapi/machine-target.json         | 19 +++++++++++--------
 target/s390x/cpu_models_sysemu.c | 29 ++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.45.2



