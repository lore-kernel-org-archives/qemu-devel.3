Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC671CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 23:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoVra-0005Fl-Ue; Tue, 19 Aug 2025 19:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uoVrY-0005Er-Lx; Tue, 19 Aug 2025 19:35:32 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1uoVrW-0006jV-Ce; Tue, 19 Aug 2025 19:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=CcBWsk6IIAL60Jwr/SlC60OdgA4w8DiRBUty3Z0qwCo=; b=ld/nJT/osP6evm3z
 BLHPOFVRUCQuQE10aba2lliSaQGDM4NGsKD1lPOIinWo0XQwxQuihu3diyMxLBOjuChzzWTL3s7Aa
 jzjwGYv6aI7cMtVVIYzP0GqDBChk/6g+jijYHCTqW3tOGhZGl/+t21F+5KtoffDRksTW+i2vxZ0zz
 5siUK8k6AKUGtI4IvUDRHntKFwrTe5cm4Xb4PYpS+VTGTGlQ7ZGLNsmM+m9qOFH8SnBpwccTTHeqJ
 cJAToCwOqy+iNdeEjMAO4SOzVI+oeR00HVzjpfmx7pwJmPy/rFa9XAywdmzUc8j1is1Hi6WUN2YYJ
 OoDBOvL/8f3h4L/bWA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uoVrS-0056Pr-2B;
 Tue, 19 Aug 2025 23:35:26 +0000
Date: Tue, 19 Aug 2025 23:35:26 +0000
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
Subject: Re: [PATCH 05/12] util: add API to fetch the current thread id
Message-ID: <aKUKPsen9jOvi_O0@gallifrey>
References: <20250819202708.1185594-1-berrange@redhat.com>
 <20250819202708.1185594-6-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819202708.1185594-6-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:33:13 up 114 days,  7:46,  1 user,  load average: 0.00, 0.00, 0.00
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
> For logging it is useful to include the current thread id. On
> POSIX there is no standard API for this, so try the Linux gettid()
> syscall preferentially, otherwise fallback to casting the result
> of thread_self() to an integer.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c | 11 +++++++++++
>  util/qemu-thread-win32.c |  5 +++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 3a286bb3ef..96eee82679 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -215,6 +215,7 @@ void *qemu_thread_join(QemuThread *thread);
>  void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  G_NORETURN void qemu_thread_exit(void *retval);
> +uint64_t qemu_thread_get_id(void);
>  
>  struct Notifier;
>  /**
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 121d7ed69b..f240a93632 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -532,3 +532,14 @@ void *qemu_thread_join(QemuThread *thread)
>      }
>      return ret;
>  }
> +
> +uint64_t qemu_thread_get_id(void)
> +{
> +#ifdef CONFIG_GETTID
> +    return (uint64_t)gettid();
> +#elif defined(SYS_gettid)
> +    return (uint64_t)syscall(SYS_gettid);
> +#else
> +    return (uint64_t)pthread_self();

My reading of the manpage is that is not guaranteed to be castable.
It also explicitly says it's not the same as gettid.  Albeit probably is.

Dave

> +#endif
> +}
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 5e6ca0c12f..f6956717b2 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -412,3 +412,8 @@ bool qemu_thread_is_self(QemuThread *thread)
>  {
>      return GetCurrentThreadId() == thread->tid;
>  }
> +
> +uint64_t qemu_thread_get_id(void)
> +{
> +    return (uint64_t)GetCurrentThreadId();
> +}
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

