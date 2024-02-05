Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A61C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 17:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2y1-0006zD-27; Mon, 05 Feb 2024 12:41:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX2xz-0006yv-8T
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:41:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rX2xx-0000Ut-7q
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 12:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707154867;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fdVhtIG6LceAs3TEVflqIDsV0QFMoYZpZ/zHEMf5vtk=;
 b=ZrYJ5Av8ARgxnxknddhrAjrSOxgtq9990ZRaXnPLCLwomUgCyZqIyZTRyHfW0Ew0ZV5Ouy
 CO6WSOQ6/tcXjLxDEn1HN/Oncu73ZTcarvpy3bvpEQEWpgHoXtvJEDeQF1JkHvw8k2l5LF
 aaosBSGoKQNY7p3sno77cnYN03fYDoA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-sIr1I87AOXyOQd99gwRA1w-1; Mon, 05 Feb 2024 12:41:05 -0500
X-MC-Unique: sIr1I87AOXyOQd99gwRA1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 69415185A782;
 Mon,  5 Feb 2024 17:41:05 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2934C2026D66;
 Mon,  5 Feb 2024 17:41:04 +0000 (UTC)
Date: Mon, 5 Feb 2024 17:41:02 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
Message-ID: <ZcEdrp-y5YFsfir4@redhat.com>
References: <20240205171819.474283-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205171819.474283-1-stefanha@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 05, 2024 at 12:18:19PM -0500, Stefan Hajnoczi wrote:
> C99 mixed declarations support interleaving of local variable
> declarations and code.
> 
> The coding style "generally" forbids C99 mixed declarations with some
> exceptions to the rule. This rule is not checked by checkpatch.pl and
> naturally there are violations in the source tree.
> 
> While contemplating adding another exception, I came to the conclusion
> that the best location for declarations depends on context. Let the
> programmer declare variables where it is best for legibility. Don't try
> to define all possible scenarios/exceptions.

IIRC, we had a discussion on this topic sometime last year, but can't
remember what the $SUBJECT was, so I'll just repeat what I said then.

Combining C99 mixed declarations with 'goto' is dangerous.

Consider this program:

$ cat jump.c
#include <stdlib.h>

int main(int argc, char**argv) {

  if (getenv("SKIP"))
    goto target;

  char *foo = malloc(30);

 target:
  free(foo);
}

$ gcc -Wall -Wuninitialized -o jump jump.c

$ SKIP=1 ./jump 
free(): invalid pointer
Aborted (core dumped)


 -> The programmer thinks they have initialized 'foo'
 -> GCC thinks the programmer has initialized 'foo'
 -> Yet 'foo' is not guaranteed to be initialized at 'target:'

Given that QEMU makes heavy use of 'goto', allowing C99 mixed
declarations exposes us to significant danger.

Full disclosure, GCC fails to diagnmose this mistake, even
with a decl at start of 'main', but at least the mistake is
now more visible to the programmer.

Fortunately with -fanalyzer GCC can diagnose this:

$ gcc -fanalyzer -Wall -o jump jump.c
jump.c: In function ‘main’:
jump.c:12:3: warning: use of uninitialized value ‘foo’ [CWE-457] [-Wanalyzer-use-of-uninitialized-value]
   12 |   free(foo);
      |   ^~~~~~~~~
  ‘main’: events 1-5
    |
    |    6 |   if (getenv("SKIP"))
    |      |      ~  
    |      |      |
    |      |      (3) following ‘true’ branch...
    |    7 |     goto target;
    |      |     ~~~~
    |      |     |
    |      |     (4) ...to here
    |    8 | 
    |    9 |  char *foo = malloc(30);
    |      |        ^~~
    |      |        |
    |      |        (1) region created on stack here
    |      |        (2) capacity: 8 bytes
    |......
    |   12 |   free(foo);
    |      |   ~~~~~~~~~
    |      |   |
    |      |   (5) use of uninitialized value ‘foo’ here


...but -fanalyzer isn't something we have enabled by default, it
is opt-in. I'm also not sure how comprehensive the flow control
analysis of -fanalyzer is ?  Can we be sure it'll catch these
mistakes in large complex functions with many code paths ?

Even if the compiler does reliably warn, I think the code pattern
remains misleading to contributors, as the flow control flaw is
very non-obvious.

Rather than accept the status quo and remove the coding guideline,
I think we should strengthen the guidelines, such that it is
explicitly forbidden in any method that uses 'goto'. Personally
I'd go all the way to -Werror=declaration-after-statement, as
while C99 mixed decl is appealing, it isn't exactly a game
changer in improving code maintainability.

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/devel/style.rst | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b50079..80c4e4df52 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -199,26 +199,6 @@ Rationale: a consistent (except for functions...) bracing style reduces
>  ambiguity and avoids needless churn when lines are added or removed.
>  Furthermore, it is the QEMU coding style.
>  
> -Declarations
> -============
> -
> -Mixed declarations (interleaving statements and declarations within
> -blocks) are generally not allowed; declarations should be at the beginning
> -of blocks. To avoid accidental re-use it is permissible to declare
> -loop variables inside for loops:
> -
> -.. code-block:: c
> -
> -    for (int i = 0; i < ARRAY_SIZE(thing); i++) {
> -        /* do something loopy */
> -    }
> -
> -Every now and then, an exception is made for declarations inside a
> -#ifdef or #ifndef block: if the code looks nicer, such declarations can
> -be placed at the top of the block even if there are statements above.
> -On the other hand, however, it's often best to move that #ifdef/#ifndef
> -block to a separate function altogether.
> -
>  Conditional statements
>  ======================
>  
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


