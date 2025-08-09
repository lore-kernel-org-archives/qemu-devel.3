Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA81C87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 07:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukdgY-0003Yc-V6; Sat, 09 Aug 2025 03:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukdgW-0003X3-DR
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 03:08:08 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ukdgS-0002Y4-QJ
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 03:08:08 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 57977s9D086436
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 9 Aug 2025 16:07:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=O7oaRLruSqWMEqi/GTMKCq74FkE4nGFlqM086H0a2JQ=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754723275; v=1;
 b=P3osKmf3THFWC9qVBlQLjVrJ8mOYMSWle0pRgegEIhYsRAAEAnQ47Ihwr26KgQxl
 j0gd6NyfOPPrWSI2cKHkgi+oTkRoONVPv/uXkj3/afVrYEQ3aiRJvwizK9J9gEHR
 zL/EjgaEdmqKDB/WQtaZYuRzyJnr8zgLYgu0WLH/nr1JJOXiFIu8Z6rr2gmeTweY
 QwqBrL6yonDjujvH1LTegL3r2gnAmSM4IGJLxtwVgbSAZ19tGojI5D87Z7gcufS9
 HIph/2q80AhA4nePEfJyAKpVcCGHYD8WSzZ1byhzTbsJPnzo+YMyu2sEB2JtzNUg
 Vp2aYnAwoztvpr3gRyRhEw==
Message-ID: <fcd5c891-b3c5-4b7d-a0ed-0e776d55ad5e@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 9 Aug 2025 16:07:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] error: Kill @error_warn
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
References: <20250808080823.2638861-1-armbru@redhat.com>
 <20250808080823.2638861-13-armbru@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250808080823.2638861-13-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/08 17:08, Markus Armbruster wrote:
> We added @error_warn some two years ago in commit 3ffef1a55ca (error:
> add global &error_warn destination).  It has multiple issues:
> 
> * error.h's big comment was not updated for it.
> 
> * Function contracts were not updated for it.
> 
> * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
>    error_prepend() and such.  These crash on @error_warn, as pointed
>    out by Akihiko Odaki.
> 
> All fixable.  However, after more than two years, we had just of 15
> uses, of which the last few patches removed eight as unclean or
> otherwise undesirable.  I didn't look closely enough at the remaining
> seven to decide whether they are desirable or not.
> 
> I don't think this feature earns its keep.  Drop it.

I want to note that the following patch series temporarily use 
&error_warn during its conversion to add errp parameters:
https://lore.kernel.org/qemu-devel/20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com/
("[PATCH v10 00/27] migration: propagate vTPM errors using Error objects")

I think this series needs to be rebased on top of the migration change.

I'm not sure if seven uses are insufficient to keep it.

I also have a general impression that perhaps a special error 
destination for error_report_err() is more useful. Today, there are many 
functions use Error, but there are also functions that still follow old 
error handling patterns. When legacy functions call functions with 
Error, a common pattern is to use error_report_err() and return -1.

"[PATCH 01/12] monitor: Clean up HMP gdbserver error reporting" and 
"[PATCH 09/12] ui/pixman: Consistent error handling in 
qemu_pixman_shareable_free()" are examples that will benefit from 
error_report_err() as an error destination. The migration patch series I 
mentioned earlier can also use one.

Perhaps it is nicer if there is an infrastructure shared by the special 
destinations. In particular, we can have common solutions for the three 
problems you pointed out:

 > * error.h's big comment was not updated for it.
 >
 > * Function contracts were not updated for it.

For these two problems, they can refer to "special error destinations" 
instead of listing them, and delegate explanations of them to 
corresponding ones.

 >
 > * ERRP_GUARD() is unaware of @error_warn, and fails to mask it from
 >    error_prepend() and such.  These crash on @error_warn, as pointed
 >    out by Akihiko Odaki.

For this problem, Error can tell that it is a special destination by 
leaving msg NULL, for example. ERRP_GUARD() then rewrites errp it is not 
&error_abort and msg is NULL.

Special destinations can also have a function pointer void (*)(Error*), 
which will be called by error_handle(). This way, we can ensure that 
having a special destination will not require changes to the common code.

By the way, I also asked for a comment with the migration patch series. 
Please reply the following if you have anything to say:
https://lore.kernel.org/qemu-devel/9c552525-72fa-4d1e-89a2-b5c0e446935a@rsg.ci.i.u-tokyo.ac.jp/

There is also an additional context:
https://lore.kernel.org/qemu-devel/aJMsRBd9-XOMRG78@armenon-kvm.bengluru.csb/

Regards,
Akihiko Odaki

> 
> Thanks-to: Akihiko  Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   include/qapi/error.h           |  6 ------
>   hw/display/virtio-gpu.c        |  8 ++++++--
>   hw/net/virtio-net.c            |  8 +++++++-
>   tests/unit/test-error-report.c | 17 -----------------
>   ui/gtk.c                       |  6 +++++-
>   util/error.c                   |  5 +----
>   6 files changed, 19 insertions(+), 31 deletions(-)
> 
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 41e3816380..b16c6303f8 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -533,12 +533,6 @@ static inline void error_propagator_cleanup(ErrorPropagator *prop)
>   
>   G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(ErrorPropagator, error_propagator_cleanup);
>   
> -/*
> - * Special error destination to warn on error.
> - * See error_setg() and error_propagate() for details.
> - */
> -extern Error *error_warn;
> -
>   /*
>    * Special error destination to abort on error.
>    * See error_setg() and error_propagate() for details.
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 0a1a625b0e..de35902213 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -242,6 +242,7 @@ static uint32_t calc_image_hostmem(pixman_format_code_t pformat,
>   static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>                                             struct virtio_gpu_ctrl_command *cmd)
>   {
> +    Error *err = NULL;
>       pixman_format_code_t pformat;
>       struct virtio_gpu_simple_resource *res;
>       struct virtio_gpu_resource_create_2d c2d;
> @@ -293,7 +294,8 @@ static void virtio_gpu_resource_create_2d(VirtIOGPU *g,
>                   c2d.width,
>                   c2d.height,
>                   c2d.height ? res->hostmem / c2d.height : 0,
> -                &error_warn)) {
> +                &err)) {
> +            warn_report_err(err);
>               goto end;
>           }
>       }
> @@ -1282,6 +1284,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>                              const VMStateField *field)
>   {
>       VirtIOGPU *g = opaque;
> +    Error *err = NULL;
>       struct virtio_gpu_simple_resource *res;
>       uint32_t resource_id, pformat;
>       int i;
> @@ -1317,7 +1320,8 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
>                                                res->width,
>                                                res->height,
>                                                res->height ? res->hostmem / res->height : 0,
> -                                             &error_warn)) {
> +                                             &err)) {
> +            warn_report_err(err);
>               g_free(res);
>               return -EINVAL;
>           }
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 6b5b5dace3..7848e26278 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -1289,6 +1289,8 @@ exit:
>   
>   static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
>   {
> +    Error *err = NULL;
> +
>       if (!virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
>           return true;
>       }
> @@ -1306,7 +1308,11 @@ static bool virtio_net_load_ebpf(VirtIONet *n, Error **errp)
>           return virtio_net_load_ebpf_fds(n, errp);
>       }
>   
> -    ebpf_rss_load(&n->ebpf_rss, &error_warn);
> +    ebpf_rss_load(&n->ebpf_rss, &err);
> +    /* Beware, ebpf_rss_load() can return false with @err unset */
> +    if (err) {
> +        warn_report_err(err);
> +    }
>       return true;
>   }
>   
> diff --git a/tests/unit/test-error-report.c b/tests/unit/test-error-report.c
> index 54319c86c9..0cbde3c4cf 100644
> --- a/tests/unit/test-error-report.c
> +++ b/tests/unit/test-error-report.c
> @@ -104,22 +104,6 @@ test_error_report_timestamp(void)
>   ");
>   }
>   
> -static void
> -test_error_warn(void)
> -{
> -    if (g_test_subprocess()) {
> -        error_setg(&error_warn, "Testing &error_warn");
> -        return;
> -    }
> -
> -    g_test_trap_subprocess(NULL, 0, 0);
> -    g_test_trap_assert_passed();
> -    g_test_trap_assert_stderr("\
> -test-error-report: warning: Testing &error_warn*\
> -");
> -}
> -
> -
>   int
>   main(int argc, char *argv[])
>   {
> @@ -133,7 +117,6 @@ main(int argc, char *argv[])
>       g_test_add_func("/error-report/glog", test_error_report_glog);
>       g_test_add_func("/error-report/once", test_error_report_once);
>       g_test_add_func("/error-report/timestamp", test_error_report_timestamp);
> -    g_test_add_func("/error-report/warn", test_error_warn);
>   
>       return g_test_run();
>   }
> diff --git a/ui/gtk.c b/ui/gtk.c
> index e91d093a49..9a08cadc88 100644
> --- a/ui/gtk.c
> +++ b/ui/gtk.c
> @@ -1181,6 +1181,7 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
>                                  void *opaque)
>   {
>       VirtualConsole *vc = opaque;
> +    Error *err = NULL;
>       uint64_t num_slot = GPOINTER_TO_UINT(touch->sequence);
>       int type = -1;
>   
> @@ -1203,7 +1204,10 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
>       console_handle_touch_event(vc->gfx.dcl.con, touch_slots,
>                                  num_slot, surface_width(vc->gfx.ds),
>                                  surface_height(vc->gfx.ds), touch->x,
> -                               touch->y, type, &error_warn);
> +                               touch->y, type, &err);
> +    if (err) {
> +        warn_report_err(err);
> +    }
>       return TRUE;
>   }
>   
> diff --git a/util/error.c b/util/error.c
> index daea2142f3..0ae08225c0 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -19,7 +19,6 @@
>   
>   Error *error_abort;
>   Error *error_fatal;
> -Error *error_warn;
>   
>   static void error_handle(Error **errp, Error *err)
>   {
> @@ -41,9 +40,7 @@ static void error_handle(Error **errp, Error *err)
>           error_report_err(err);
>           exit(1);
>       }
> -    if (errp == &error_warn) {
> -        warn_report_err(err);
> -    } else if (errp && !*errp) {
> +    if (errp && !*errp) {
>           *errp = err;
>       } else {
>           error_free(err);


