Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28CEC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 11:03:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6pwI-00017N-1m; Tue, 14 May 2024 07:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6pwD-00016i-1P
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:03:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6pwB-0005a3-H8
 for qemu-devel@nongnu.org; Tue, 14 May 2024 07:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715684594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s8E68g1Q3n+SeLb2wWFwLMxJYbHiz5QDeW6WfmIzWXs=;
 b=W8nG6Z8QL01RvlcgKY2HpceLWxdIlvI28wTpL3hOjfV5GS1tZFRFLFcXbBj72M7aFNBTEO
 YNyaHqqjrj5FT/XI6WUeGo9LmfwGWsTs9jPiUQf3v4g1SdwcqWr76qK1gP5xwBPufC2Q4T
 sKSlDehiJO+SIeC2cvS9/FKTqS7L0PU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-We_BF_67MfS5-5UccmXmGg-1; Tue,
 14 May 2024 07:03:01 -0400
X-MC-Unique: We_BF_67MfS5-5UccmXmGg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5BBD3800082;
 Tue, 14 May 2024 11:03:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4FD8200B4DB;
 Tue, 14 May 2024 11:03:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 972E921E5E6B; Tue, 14 May 2024 13:02:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,  kkostiuk@redhat.com,  michael.roth@amd.com
Subject: Re: [PATCH 2/3] qga: Shorten several error messages
In-Reply-To: <20240514105829.729342-3-armbru@redhat.com> (Markus Armbruster's
 message of "Tue, 14 May 2024 12:58:27 +0200")
References: <20240514105829.729342-1-armbru@redhat.com>
 <20240514105829.729342-3-armbru@redhat.com>
Date: Tue, 14 May 2024 13:02:59 +0200
Message-ID: <874jb03bbw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> Some, but not all error messages are of the form
>
>     Guest agent command failed, error was '<actual error message>'
>
> For instance, command guest-exec can fail with an error message like
>
>     Guest agent command failed, error was 'Failed to execute child proces=
s =E2=80=9C/bin/invalid-cmd42=E2=80=9D (No such file or directory)'
>
> Shorten this to just just the actual error message.  The guest-exec
> example becomes
>
>     Failed to execute child process =E2=80=9C/bin/invalid-cmd42=E2=80=9D =
(No such file or directory)
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

[...]

To be squashed into the patch:

diff --git a/qga/commands.c b/qga/commands.c
index 27b16313ea..5a5fad31f8 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -15,7 +15,6 @@
 #include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 #include "commands-common.h"


