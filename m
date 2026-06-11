Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE51CD8C9D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWxn-0004nr-4s; Thu, 11 Jun 2026 00:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxj-0004ly-Nb
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWxi-0005Xa-9x
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781151853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d+ZrUF5QiDAqJMi43LG3mwd5iMGaAwMF/E106IU4/XI=;
 b=NGmpSPM1hfpSzbRZ9oswrnuPkwHN1jxjexDpRxq4WlNZo+Q3nTT2eMEOlkbfmWE+8YxEQx
 5iY55V7OTVLOvSLGzkwpSJRhAxVIJ9FzAX/lz/WE77zSAhg2EOgSCZHStlLw4yAHRaiCz1
 terZyxNAWj23TLUs0wMWpU82tzqitvQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-AA-qXEJON7SKdNO9yWKqjA-1; Thu,
 11 Jun 2026 00:23:57 -0400
X-MC-Unique: AA-qXEJON7SKdNO9yWKqjA-1
X-Mimecast-MFC-AGG-ID: AA-qXEJON7SKdNO9yWKqjA_1781151836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B79A31955F06; Thu, 11 Jun 2026 04:23:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 38B961800586; Thu, 11 Jun 2026 04:23:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, linux-edac@vger.kernel.org,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 03/13] qapi/docs: remove unused QAPIDoc subsection members
Date: Thu, 11 Jun 2026 00:23:22 -0400
Message-ID: <20260611042332.482979-4-jsnow@redhat.com>
In-Reply-To: <20260611042332.482979-1-jsnow@redhat.com>
References: <20260611042332.482979-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

All users of the QAPIDoc object should be iterating over all_sections
and not grabbing arbitrary subsections, if possible. Remove the 'body'
and 'sections' members, as they are no longer used.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c3cf33904ef..b33edbba74f 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -732,8 +732,6 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         self.all_sections: List[QAPIDoc.Section] = [
             QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
         ]
-        # the body section
-        self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
         # dicts mapping parameter/feature names to their description
         self.args: Dict[str, QAPIDoc.ArgSection] = {}
         self.features: Dict[str, QAPIDoc.ArgSection] = {}
@@ -742,8 +740,6 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         self.errors: Optional[QAPIDoc.Section] = None
         # "Since" section
         self.since: Optional[QAPIDoc.Section] = None
-        # sections other than .body, .args, .features
-        self.sections: List[QAPIDoc.Section] = []
 
     def end(self) -> None:
         for section in self.all_sections:
@@ -766,7 +762,6 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
 
         # start new section
         section = self.Section(info, kind)
-        self.sections.append(section)
         self.all_sections.append(section)
 
     def new_tagged_section(
@@ -790,7 +785,6 @@ def new_tagged_section(
                 raise QAPISemError(
                     info, "duplicated '%s' section" % kind)
             self.since = section
-        self.sections.append(section)
         self.all_sections.append(section)
 
     def _new_description(
-- 
2.54.0


