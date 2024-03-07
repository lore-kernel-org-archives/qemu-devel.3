Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679B0C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 17:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riHml-0000mT-VN; Thu, 07 Mar 2024 12:44:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmS-0000fL-La
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1riHmR-0003yq-5n
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 12:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709833420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CtwhMuqCCTfOhM6zwFdR45z84+ew8UHy/GaUnkSATJM=;
 b=iqIprBfPQjUeLekbZY89L6W1y+t+b0iY/1AO7IdbJp/6rrys/KDIhF1Ym3p0efAUHj0UQr
 YdLuaNkKkRO2TEZ/1UnyfET2B0jP/zE9rSGS3LOp9c1BF/Z2yvW3WO9xFeOdXmatv5CN3E
 g5Q8SHZ6ojTAFscnMpvtQm2vWfevSvw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-kiItz8rtNBWdY3XxCPBJVQ-1; Thu, 07 Mar 2024 12:43:37 -0500
X-MC-Unique: kiItz8rtNBWdY3XxCPBJVQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D6187185A786;
 Thu,  7 Mar 2024 17:43:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07FB6492BFC;
 Thu,  7 Mar 2024 17:43:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/5] Sparc CPU naming and help text improvements
Date: Thu,  7 Mar 2024 18:43:29 +0100
Message-ID: <20240307174334.130407-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The Sparc CPU naming and the corresponding help text is somewhat
confusing for the users. We should avoid spaces in the Names and
provide clear information to the users what can be passed to the
"-cpu" option.
While we're at it, also remove the "+" from two of the CPU names
since this character is now not allowed in device names anymore
(and was worked around with an ugly hack in qom/object.c so far).

Thomas Huth (5):
  target/sparc/cpu: Rename the CPU models with a "+" in their names
  target/sparc/cpu: Avoid spaces by default in the CPU names
  target/sparc/cpu: Improve the CPU help text
  docs/system/target-sparc: Improve the Sparc documentation
  docs/about: Deprecate the old "UltraSparc" CPU names that contain a
    "+"

 docs/about/deprecated.rst    |  9 +++++
 docs/system/target-sparc.rst |  8 +++-
 qom/object.c                 |  8 ----
 target/sparc/cpu.c           | 71 +++++++++++++++++++++---------------
 4 files changed, 56 insertions(+), 40 deletions(-)

-- 
2.44.0


