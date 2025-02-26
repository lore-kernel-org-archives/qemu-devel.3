Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE58C021BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDqz-0002wW-5d; Wed, 26 Feb 2025 04:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnDqy-0002wD-0S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:37:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnDqp-0005Kw-Lk
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740562629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tFkReY5jvkZLJ3jT0t1+v4ahwlz/hJLOHV/OmrLaHAA=;
 b=Q22G5Uy8Qa40jeYEgWCm13ZFWjqQHdsM1I+mgjYNFBlcGc1sycujn9lohs+dlmHr0Fl3pp
 N9xZNOIuHZROC/0p4W6Zv2E4ZrisgGd2iJQ3sYuiaDLO3AptNR0rOi09pliUHFd/O19bN3
 9uQX23AS/92XBIpshDkJa9jYrnTbTLg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-kH2xitGEO2mbTTu6W5Q96Q-1; Wed,
 26 Feb 2025 04:37:02 -0500
X-MC-Unique: kH2xitGEO2mbTTu6W5Q96Q-1
X-Mimecast-MFC-AGG-ID: kH2xitGEO2mbTTu6W5Q96Q_1740562617
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 828DD1800983; Wed, 26 Feb 2025 09:36:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3448619560A3; Wed, 26 Feb 2025 09:36:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BB06D21E675E; Wed, 26 Feb 2025 10:36:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Thomas
 Huth <thuth@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH 04/10] docs/qapidoc: support header-less freeform sections
In-Reply-To: <87frk3fr45.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 24 Feb 2025 13:45:46 +0100")
References: <20250224033741.222749-1-jsnow@redhat.com>
 <20250224033741.222749-5-jsnow@redhat.com>
 <87frk3fr45.fsf@pond.sub.org>
Date: Wed, 26 Feb 2025 10:36:54 +0100
Message-ID: <87wmdd11zd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> The code as written crashes when a free-form documentation block doesn't
>> start with a heading or subheading, for example:
>>
>> | ##
>> | # Just text, no heading.
>> | ##
>>
>> The code will attempt to use the `node` variable uninitialized. To fix,
>> create a generic block to insert the doc text into.
>>
>> (This patch also removes a lingering pylint warning in the QAPIDoc
>> implementation that prevents getting a clean baseline to use for
>> forthcoming additions.)
>>
>> Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freeform QMP sections)
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  docs/sphinx/qapidoc.py | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> index 5f96b46270b..5a4d7388b29 100644
>> --- a/docs/sphinx/qapidoc.py
>> +++ b/docs/sphinx/qapidoc.py
>> @@ -421,6 +421,8 @@ def freeform(self, doc):
>>              node = self._start_new_heading(heading, len(leader))
>>              if text == '':
>>                  return
>> +        else:
>> +            node = nodes.container()
>>  
>>          self._parse_text_into_node(text, node)
>>          self._cur_doc = None
>
> Let's add a suitable free-form block to tests/qapi-schema/doc-good.json
> to catch regressions.  Not worth a respin by itself.

With the appended obvious fixup:
Reviewed-by: Markus Armbruster <armbru@redhat.com>


diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index f64bf38d85..0a4f139f83 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -11,6 +11,10 @@
 # = Section
 ##
 
+##
+# Just text, no heading.
+##
+
 ##
 # == Subsection
 #
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index ec277be91e..0a9da3efde 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -56,6 +56,9 @@ event EVT_BOXED Object
 doc freeform
     body=
 = Section
+doc freeform
+    body=
+Just text, no heading.
 doc freeform
     body=
 == Subsection


