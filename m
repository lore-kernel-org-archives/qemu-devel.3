Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E302606A696
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 03:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=nXpRsQ8r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKOj-0000hg-KX; Sun, 22 Nov 2026 22:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xVKOh-0000hU-1M
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 22:07:15 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1xVKOe-0008NO-Vh
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 22:07:14 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jXrT54yZTz8PbY;
 Sun, 22 Nov 2026 22:07:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; s=default; bh=1rCelnQmh8wGVmCuZf7K
 ZxvePcRuOfHeuKW4m04cLl4=; b=nXpRsQ8rF08qNZjntYxft/LNZVDpXsUKmXT6
 AG2Amg0/ECS8Y8HbFhjCjzq867dWki5vT/6y6j91qspCwc8WTrx5uM9y4Mkpb3lp
 Xs7b021iWy3uK9kGee9Tq5L5Nk99JOLTi/9vbuSpCMtpsFV5JEKv2bpc+81m01LY
 mv4+6RU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=content-type
 :message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to; q=dns; s=default; b=h258xAYNJ+bBJ8OC/ePt76p/p/NaNS
 Ut6c2flBII7dfXcllAcMpB+GJcjP0kzEbvp99cDISlovrn/mZOqoCheSRRXs4x1P
 JHZvE3GFnIntmcSiUhGcEQiXHiTKJgtg+ZXrw4prgoX9oQX/UD6JD5MXYS0UMqBJ
 6nKBoL2H1+wLk=
Received: from [IPV6:2001:470:b050:6:d8a4:f822:d294:7369] (unknown
 [IPv6:2001:470:b050:6:d8a4:f822:d294:7369])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jXrT54Js9z8PbW;
 Sun, 22 Nov 2026 22:07:05 -0500 (EST)
Content-Type: multipart/alternative;
 boundary="------------AIX1edLV2HbqMh7iNUIP53T3"
Message-ID: <b4a10e5a-711e-4d13-a7a1-64f95ae9c082@comstyle.com>
Date: Sun, 22 Nov 2026 22:07:05 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] tests/qtest: unset socket timeout
To: Roman Bogorodskiy <bogorodskiy@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
 <20261122164905.59680-5-bogorodskiy@gmail.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <20261122164905.59680-5-bogorodskiy@gmail.com>
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a multi-part message in MIME format.
--------------AIX1edLV2HbqMh7iNUIP53T3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-22 11:48 a.m., Roman Bogorodskiy wrote:
> The qtest_socket_accept() sets a timeout on a listening
> socket. FreeBSD also inherits this timeout for the accepted socket,
> which breaks some tests. Explicitly set timeout on the accepted socket
> to 0.
>
> Signed-off-by: Roman Bogorodskiy<bogorodskiy@gmail.com>
> ---
>   tests/qtest/libqtest.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 7f66c1bbb3..c3d84f9ca9 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -151,6 +151,19 @@ static int qtest_socket_accept(QTestState *s, int sock)
>       }
>       if (ret == -1) {
>           fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
> +    } else {
> +        /*
> +         * Accepted sockets might inherit listener's timeout on
> +         * some systems, so set it to 0 explicitly
> +         */
> +        memset(&timeout, 0, sizeof(timeout));
> +        if (setsockopt(ret, SOL_SOCKET, SO_RCVTIMEO,
> +                       (void *)&timeout, sizeof(timeout))) {
> +            fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
> +                    __func__, strerror(errno));
> +            close(ret);
> +            return -1;
> +        }
>       }
>   
>       return ret;

|The patch looks good to me. This affects the BSDs: an accepted socket 
inherits SO_RCVTIMEO from the listening socket, so the 250 ms accept 
timeout also applies to the qtest and QMP reads. Could the comment say 
"BSD systems" instead of "some systems"? Reviewed-by: Brad Smith 
<brad@comstyle.com>|


--------------AIX1edLV2HbqMh7iNUIP53T3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2026-11-22 11:48 a.m., Roman
      Bogorodskiy wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20261122164905.59680-5-bogorodskiy@gmail.com">
      <pre wrap="" class="moz-quote-pre">The qtest_socket_accept() sets a timeout on a listening
socket. FreeBSD also inherits this timeout for the accepted socket,
which breaks some tests. Explicitly set timeout on the accepted socket
to 0.

Signed-off-by: Roman Bogorodskiy <a class="moz-txt-link-rfc2396E" href="mailto:bogorodskiy@gmail.com">&lt;bogorodskiy@gmail.com&gt;</a>
---
 tests/qtest/libqtest.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 7f66c1bbb3..c3d84f9ca9 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -151,6 +151,19 @@ static int qtest_socket_accept(QTestState *s, int sock)
     }
     if (ret == -1) {
         fprintf(stderr, "%s failed: %s\n", __func__, strerror(errno));
+    } else {
+        /*
+         * Accepted sockets might inherit listener's timeout on
+         * some systems, so set it to 0 explicitly
+         */
+        memset(&amp;timeout, 0, sizeof(timeout));
+        if (setsockopt(ret, SOL_SOCKET, SO_RCVTIMEO,
+                       (void *)&amp;timeout, sizeof(timeout))) {
+            fprintf(stderr, "%s failed to set SO_RCVTIMEO: %s\n",
+                    __func__, strerror(errno));
+            close(ret);
+            return -1;
+        }
     }
 
     return ret;</pre>
    </blockquote>
    <pre><code>
The patch looks good to me. This affects the BSDs: an accepted socket
inherits SO_RCVTIMEO from the listening socket, so the 250 ms accept
timeout also applies to the qtest and QMP reads.

Could the comment say "BSD systems" instead of "some systems"?

Reviewed-by: Brad Smith <a class="moz-txt-link-rfc2396E" href="mailto:brad@comstyle.com">&lt;brad@comstyle.com&gt;</a></code></pre>
    <p><br>
    </p>
  </body>
</html>

--------------AIX1edLV2HbqMh7iNUIP53T3--

