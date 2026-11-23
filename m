Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8648A606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=comstyle.com header.i=@comstyle.com header.a=rsa-sha256 header.s=default header.b=GpqE+/y6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOvn-0005XO-PI; Mon, 23 Nov 2026 02:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>)
 id 1xVOvm-0005X5-CY; Mon, 23 Nov 2026 02:57:42 -0500
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>)
 id 1xVOvk-0001qB-Ji; Mon, 23 Nov 2026 02:57:42 -0500
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4jXywM4f1zz8PbY;
 Mon, 23 Nov 2026 02:57:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=
 content-type:message-id:date:mime-version:subject:to:cc
 :references:from:in-reply-to; s=default; bh=HCP+17hH+lfLwHRc7q/H
 gk0FpM0MbasuMsfUV9C0yd8=; b=GpqE+/y6iEJmpK1uS5hvYz8R+C81H8Q5t1zo
 HU+m01ryy/9wOi1i+nmBj1cjqy/F+GCC/lIqT51hTE3FuaArTd9JMm3UA835guZ6
 pCPiqGFvQLZZCHdkTXQzHwoDbxZ9XZPzJun807Et75fac7F/CD/2xYlhScV+ayZE
 IcWARH8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=content-type
 :message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to; q=dns; s=default; b=KGtFbV5LTJ9V7OFBmCKYvihMNLVdhv
 VsqaRummTpmFRxga23oKP938LtmVd4Zxo8bWUPAWdNTSpDrBiVYShti03SRFtRwS
 dgBlmiKPQWWjJdQ+dMdLJwJEuraUmfHSiFW8yDtwCON4f+tEIdAs4K/eHTd1aZ2A
 D8p/B0H2Ze9yo=
Received: from [IPV6:2001:470:b050:6:9651:79e5:aca2:6069] (unknown
 [IPv6:2001:470:b050:6:9651:79e5:aca2:6069])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4jXywM3zFQz8PbW;
 Mon, 23 Nov 2026 02:57:39 -0500 (EST)
Content-Type: multipart/alternative;
 boundary="------------kxQNEJmGrnhJI3oPf28ezp0T"
Message-ID: <6e03ffd6-6b13-4a40-8ff7-d1d310619f8b@comstyle.com>
Date: Mon, 23 Nov 2026 02:57:39 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] iotests: fix the dd() wrapper
To: Roman Bogorodskiy <bogorodskiy@gmail.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>
References: <20261122164905.59680-1-bogorodskiy@gmail.com>
 <20261122164905.59680-4-bogorodskiy@gmail.com>
Content-Language: en-US
From: Brad Smith <brad@comstyle.com>
In-Reply-To: <20261122164905.59680-4-bogorodskiy@gmail.com>
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
--------------kxQNEJmGrnhJI3oPf28ezp0T
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-11-22 11:48 a.m., Roman Bogorodskiy wrote:
> The dd() wrapper already uses status=noxfer on Linux. Use the same
> for FreeBSD to fix its consumers.
>
> Add a separate "elif" block rather than extending the already existing
> Linux block as dd on FreeBSD does not support --help.
> The "status=noxfer" is supported since FreeBSD 9.3 and 10.1, so it's
> been long enough to use it without a check.
>
> Signed-off-by: Roman Bogorodskiy<bogorodskiy@gmail.com>
> ---
>   tests/qemu-iotests/common.rc | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index 262fe63da8..82a6b1b5c4 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -64,6 +64,9 @@ dd()
>               else
>                   command dd $@
>               fi
> +   elif [ "$HOSTOS" == "FreeBSD" ]
> +   then
> +        command dd status=noxfer $@
>      else
>           command dd $@
>      fi

|Instead of adding another $HOSTOS check, I think it would be better to 
check if dd supports status=noxfer, and not rely on --help either. That 
way it works on any OS that supports it, without OS-specific checks. |

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 262fe63da820..c18ff7d72039 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -28,6 +28,13 @@ arch=$(uname -m)
  # make sure we have a standard umask
  umask 022
  
+if command dd if=/dev/null of=/dev/null status=noxfer >/dev/null 2>&1
+then
+    DD_NOXFER="status=noxfer"
+else
+    DD_NOXFER=""
+fi
+
  # bail out, setting up .notrun file
  _notrun()
  {
@@ -54,19 +61,7 @@ fi
  
  dd()
  {
-   if [ "$HOSTOS" == "Linux" ]
-   then
-        command dd --help | grep noxfer > /dev/null 2>&1
-
-        if [ "$?" -eq 0 ]
-            then
-                command dd status=noxfer $@
-            else
-                command dd $@
-            fi
-   else
-        command dd $@
-   fi
+    command dd $DD_NOXFER "$@"
  }
  
  # poke_file 'test.img' 512 '\xff\xfe'


--------------kxQNEJmGrnhJI3oPf28ezp0T
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
      cite="mid:20261122164905.59680-4-bogorodskiy@gmail.com">
      <pre wrap="" class="moz-quote-pre">The dd() wrapper already uses status=noxfer on Linux. Use the same
for FreeBSD to fix its consumers.

Add a separate "elif" block rather than extending the already existing
Linux block as dd on FreeBSD does not support --help.
The "status=noxfer" is supported since FreeBSD 9.3 and 10.1, so it's
been long enough to use it without a check.

Signed-off-by: Roman Bogorodskiy <a class="moz-txt-link-rfc2396E" href="mailto:bogorodskiy@gmail.com">&lt;bogorodskiy@gmail.com&gt;</a>
---
 tests/qemu-iotests/common.rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 262fe63da8..82a6b1b5c4 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -64,6 +64,9 @@ dd()
             else
                 command dd $@
             fi
+   elif [ "$HOSTOS" == "FreeBSD" ]
+   then
+        command dd status=noxfer $@
    else
         command dd $@
    fi</pre>
    </blockquote>
    <pre
style="color: rgb(255, 255, 255); font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; overflow-wrap: break-word; white-space: pre-wrap;">
<code>Instead of adding another $HOSTOS check, I think it would be better
to check if dd supports status=noxfer, and not rely on --help either.
That way it works on any OS that supports it, without OS-specific
checks.
</code>

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index 262fe63da820..c18ff7d72039 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -28,6 +28,13 @@ arch=$(uname -m)
 # make sure we have a standard umask
 umask 022
 
+if command dd if=/dev/null of=/dev/null status=noxfer &gt;/dev/null 2&gt;&amp;1
+then
+    DD_NOXFER="status=noxfer"
+else
+    DD_NOXFER=""
+fi
+
 # bail out, setting up .notrun file
 _notrun()
 {
@@ -54,19 +61,7 @@ fi
 
 dd()
 {
-   if [ "$HOSTOS" == "Linux" ]
-   then
-        command dd --help | grep noxfer &gt; /dev/null 2&gt;&amp;1
-
-        if [ "$?" -eq 0 ]
-            then
-                command dd status=noxfer $@
-            else
-                command dd $@
-            fi
-   else
-        command dd $@
-   fi
+    command dd $DD_NOXFER "$@"
 }
 
 # poke_file 'test.img' 512 '\xff\xfe'</pre>
    <p><br>
    </p>
  </body>
</html>

--------------kxQNEJmGrnhJI3oPf28ezp0T--

