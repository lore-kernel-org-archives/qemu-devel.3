Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920BDCA0FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 23:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usUaa-0005c1-SQ; Sat, 30 Aug 2025 19:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUaY-0005Zm-VW; Sat, 30 Aug 2025 19:02:26 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>)
 id 1usUaW-00073g-Uh; Sat, 30 Aug 2025 19:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=oLnEruikFcqGa4FsV/YF/95hmcT2KmaxYImIASMTDOs=; b=Rxid9MTKckT4EIPR
 kpwrnrJKnc0YcSRwxir6XzpgjXifO2XKERfhWFy0EqI+2bg167hhe0upJ50VnQjqO75eos4QpDofo
 8dMzNT/c3fTHC9jySsP86vkntkdsO6pgrDMdvMTZA1gItVGBHZRSMz23g/Jf8nJcUCk5Gjho3xDbI
 k1jqycfx8wPdtZmVraC8CsjaEkeG4/mHPZ7KsFTTwnUdQAs94f1tYF9oDgilkF2xEwlE+6ZfxPfhx
 jWCUCm7oUXpZaT2A8PFp0lfZgsADA//cKNUUIm8I0wkKCmAfwWPrke0ajeA+5iqvJwX46wvKltWMX
 dSEdIa1mMuKZmgfbIw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1usUaV-007aUm-0C;
 Sat, 30 Aug 2025 23:02:23 +0000
Date: Sat, 30 Aug 2025 23:02:23 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 04/14] util: expose qemu_thread_set_name
Message-ID: <aLOC_3gDfmpNCsx7@gallifrey>
References: <20250829180354.2922145-1-berrange@redhat.com>
 <20250829180354.2922145-5-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829180354.2922145-5-berrange@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 23:02:19 up 125 days,  7:15,  1 user,  load average: 0.00, 0.00, 0.00
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
> The ability to set the thread name needs to be used in a number
> of places, so expose the current impls as public methods.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  include/qemu/thread.h    |  1 +
>  util/qemu-thread-posix.c | 30 ++++++++++++++++++------------
>  util/qemu-thread-win32.c |  6 +++---
>  3 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index 3a286bb3ef..27b888ab0a 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -215,6 +215,7 @@ void *qemu_thread_join(QemuThread *thread);
>  void qemu_thread_get_self(QemuThread *thread);
>  bool qemu_thread_is_self(QemuThread *thread);
>  G_NORETURN void qemu_thread_exit(void *retval);
> +void qemu_thread_set_name(const char *name);
>  
>  struct Notifier;
>  /**
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 7c985b5d38..ddaa1de4dd 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -329,6 +329,21 @@ static void qemu_thread_atexit_notify(void *arg)
>      notifier_list_notify(&thread_exit, NULL);
>  }
>  
> +void qemu_thread_set_name(const char *name)
> +{
> +    /*
> +     * Attempt to set the threads name; note that this is for debug, so
> +     * we're not going to fail if we can't set it.
> +     */
> +# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> +    pthread_setname_np(pthread_self(), name);
> +# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> +    pthread_setname_np(name);
> +# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> +    pthread_set_name_np(pthread_self(), name);
> +# endif
> +}
> +
>  typedef struct {
>      void *(*start_routine)(void *);
>      void *arg;
> @@ -342,20 +357,11 @@ static void *qemu_thread_start(void *args)
>      void *arg = qemu_thread_args->arg;
>      void *r;
>  
> -    /* Attempt to set the threads name; note that this is for debug, so
> -     * we're not going to fail if we can't set it.
> -     */
>      if (qemu_thread_args->name) {
> -# if defined(CONFIG_PTHREAD_SETNAME_NP_W_TID)
> -        pthread_setname_np(pthread_self(), qemu_thread_args->name);
> -# elif defined(CONFIG_PTHREAD_SETNAME_NP_WO_TID)
> -        pthread_setname_np(qemu_thread_args->name);
> -# elif defined(CONFIG_PTHREAD_SET_NAME_NP)
> -        pthread_set_name_np(pthread_self(), qemu_thread_args->name);
> -# endif
> +        qemu_thread_set_name(qemu_thread_args->name);
> +        QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
> +        g_free(qemu_thread_args->name);
>      }
> -    QEMU_TSAN_ANNOTATE_THREAD_NAME(qemu_thread_args->name);
> -    g_free(qemu_thread_args->name);
>      g_free(qemu_thread_args);
>  
>      /*
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 9595a5b090..62eaa11026 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -316,7 +316,7 @@ void *qemu_thread_join(QemuThread *thread)
>      return ret;
>  }
>  
> -static void set_thread_description(HANDLE h, const char *name)
> +void qemu_thread_set_name(const char *name)
>  {
>      g_autofree wchar_t *namew = NULL;
>  
> @@ -329,7 +329,7 @@ static void set_thread_description(HANDLE h, const char *name)
>          return;
>      }
>  
> -    SetThreadDescriptionFunc(h, namew);
> +    SetThreadDescriptionFunc(GetCurrentThread(), namew);
>  }
>  
>  void qemu_thread_create(QemuThread *thread, const char *name,
> @@ -356,7 +356,7 @@ void qemu_thread_create(QemuThread *thread, const char *name,
>          error_exit(GetLastError(), __func__);
>      }
>      if (name) {
> -        set_thread_description(hThread, name);
> +        qemu_thread_set_name(name);
>      }
>      CloseHandle(hThread);
>  
> -- 
> 2.50.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

