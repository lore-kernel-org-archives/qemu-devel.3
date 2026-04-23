Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84603FDEE52
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 22:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG26G-0005gk-UT; Thu, 23 Apr 2026 18:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26D-0005fp-Nz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wG26A-0005mX-Sd
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 18:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776981638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eibuoVQLosAhYhD7NnLqi8LJNK01VNDLHucLdwcBIXE=;
 b=VRScZa9KwuVGi5Q1Yz6DqfpYl6h3icY57UXJr7Ioy7MAWUKZHWu5m6kuhAqGzD2w23PO4d
 Nnz9UTj5JIpFW7hLNOqOxvN/SNUYy+WGTRVmr6u0utvWwNngCfb8u+Zi3l8I6J/JYnyQ0g
 S97HB+6QTjW6fIuGLSirQQ+wIqOuX1I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-K4nBqo3XPdKyOHJy6fUKUw-1; Thu,
 23 Apr 2026 18:00:35 -0400
X-MC-Unique: K4nBqo3XPdKyOHJy6fUKUw-1
X-Mimecast-MFC-AGG-ID: K4nBqo3XPdKyOHJy6fUKUw_1776981633
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9FDE91800454; Thu, 23 Apr 2026 22:00:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.143])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B82F43007572; Thu, 23 Apr 2026 22:00:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH 02/12] qapi/docs: remove unused QAPIDoc subsection members
Date: Thu, 23 Apr 2026 18:00:11 -0400
Message-ID: <20260423220022.2180059-3-jsnow@redhat.com>
In-Reply-To: <20260423220022.2180059-1-jsnow@redhat.com>
References: <20260423220022.2180059-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

All users of the QAPIDoc object should be iterating over all_sections
and not grabbing arbitrary subsections, if possible. Remove the 'body'
and 'sections' members, as they are no longer used.

Signed-off-by: John Snow <jsnow@redhat.com>
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
2.53.0


