Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83A8CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 23:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoVak-0000bV-KK; Tue, 19 Aug 2025 19:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uoVaj-0000bC-Ee; Tue, 19 Aug 2025 19:18:09 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uoVag-0004ej-PK; Tue, 19 Aug 2025 19:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=8mJ/H+B3WWoPw5u3X0fYS3ZxM7TJkaQhVy/SF2+0+z4=; b=lkWaBpFWggFk7gWQ
 mTziw6c2ZcFHWeInHkBRuEkFy1GIhRnA51j4cLRoFd3+E1NAC0RLuqC+E1pONCqWJ4dbzz+coF8IE
 n1+QoY2tZ0OivB5z8C1CXRrjC8L/YFe+Yg3a83PSn6EpVfrzPog6NTgPWHfG2ZXFMrm9utsaRbJwJ
 NXSgpM60SOchF1LVXhK1Eq4m/8+PSnd4hkoS5MkArEAE9xbxH8IqCCzYGm9qcw+ODKl93RpuEb0k/
 ci1YbtZ69C3XIBBp7aIqD/lJk+ozFj/yVonHw8B/esLAC1LNUtXe9Uu30rFQ7epItuiQlWxuig0Au
 qo7JBz1XH4FGVM0PgA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uoVaa-0056Cs-36;
 Tue, 19 Aug 2025 23:18:00 +0000
Date: Tue, 19 Aug 2025 23:18:00 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 devel@lists.libvirt.org, Stefan Weil <sw@weilnetz.de>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 04/12] util: set the name for the 'main' thread
Message-ID: <aKUGKNu0I8MXvsta@gallifrey>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819202708.1185594-5-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:15:39 up 114 days,  7:29,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Daniel P. Berrangé (berrange@redhat.com) wrote:
> The default main thread name is undefined, so use a constructor to
> explicitly set it to 'main'. This constructor is marked to run early
> as the thread name is intended to be used in error reporting / logs
> which may be triggered very early in QEMU execution.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  util/qemu-thread-posix.c | 12 ++++++++++++
>  util/qemu-thread-win32.c |  6 ++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 7c985b5d38..121d7ed69b 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -22,6 +22,18 @@
>  #include <pthread_np.h>
>  #endif
>  
> +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> +qemu_thread_init(void)
> +{
> +# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +    pthread_setname_np(pthread_self(), "main");
> +# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> +    pthread_setname_np("main");
> +# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> +    pthread_set_name_np(pthread_self(), "main");
> +# endif

Should this three way ifdef not be broken out somewhere;
it's already in qemu_thread_start() (and it looks like qjack_thread_creator
should use it)
(and the setname/set_name variety is hilarious).

Other than,


Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> +}
> +
>  static void error_exit(int err, const char *msg)
>  {
>      fprintf(stderr, "qemu: %s: %s\n", msg, strerror(err));
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 9595a5b090..5e6ca0c12f 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -332,6 +332,12 @@ static void set_thread_description(HANDLE h, const char *name)
>      SetThreadDescriptionFunc(h, namew);
>  }
>  
> +static void __attribute__((__constructor__(QEMU_CONSTRUCTOR_EARLY)))
> +qemu_thread_init(void)
> +{
> +    set_thread_description(GetCurrentThread(), "main");
> +}
> +
>  void qemu_thread_create(QemuThread *thread, const char *name,
>                         void *(*start_routine)(void *),
>                         void *arg, int mode)
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

