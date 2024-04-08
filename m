Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56967C67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 09:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtlee-0003dg-Vh; Mon, 08 Apr 2024 05:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtlec-0003cU-G1
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:51:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtlea-0006I7-My
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 05:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712569863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKd/RBHH2eEUyzECHRh3wblVMLrd7XMNRJio0sNuBm8=;
 b=P11riQmBzo9vJWARsRhjRtkm5nT3gW0GHZ2M6gAgManfjyenYfBziY6if6AjI0rI5SZ8he
 N/zhSx7LMqsq5OvqvnxKriwUvKiLnpgvEnF6HIcGcEFzMaNv+nhPFhVmP70jH9GFrrm5TB
 M1bLT8tIjhrEf5D2iCICS7VWRHmsvvU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-eJzsdNaRMfGZrgPlp95S3g-1; Mon, 08 Apr 2024 05:51:02 -0400
X-MC-Unique: eJzsdNaRMfGZrgPlp95S3g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-343ee356227so1430787f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 02:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712569861; x=1713174661;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKd/RBHH2eEUyzECHRh3wblVMLrd7XMNRJio0sNuBm8=;
 b=G423M42u2xGUa/N2Eu1knWu+DQyvHNMS4fkx1eDlMo+fkFaVJVt/rYjzHTOE25Bz99
 0ld7OVkMG9RV2iPQolEseY4WbN/WfA/PLRfju2T+Fsfw+ROaVUwm8a3GspMl3IlCHkf9
 JAWEGPtUDTT6U8sWe+y2/oirdPM1c0cZx1Ov1tZnYuhPooXu0EJ9uCAwtWYQTC9N5BZX
 CuXAIF9JzzySovT+/Fo8NDKkxIEqQWnu2I0g4SkN9zxbEEvpY3DPVa6ss6TduJXg82sZ
 CQ+L4Q1Bir3kSu0t6/nJFsr+V3DxHCJpPd9Capqp4v94HXqj1ZdT4NDG/MUGKH/ewh70
 Ox/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz1OYLaPliJSAVw55hkyNVcVCQL3EnrSOSvgkcqCETFFkIKVLpbBliRwgM5kMi9iEfy8XO0SQOh3BHQh1cMHvC021q8Jc=
X-Gm-Message-State: AOJu0YysMuWW9R1JaA5C8RD1EgaYTuoTNm+KM0/4Zwqc57NQGGnQLe4t
 WNT4H1+8Aeg48YZ1xYKn+pXwikIJ54QrTjLQxTEe7M89Oiu8e7iA/M+Ib2gEdYoibczHvhEXsDt
 pZim42P1XooLB2+V+kHoxrxViXoAonWUvc3en1j9zdCyF4xuNC2GGp+aSQ4Mfk0aYsR8pdJVlvJ
 VWAYwkv4DWwFMsTPYa2PuGWDqOenA=
X-Received: by 2002:a5d:634d:0:b0:343:7785:fb04 with SMTP id
 b13-20020a5d634d000000b003437785fb04mr7540693wrw.67.1712569860907; 
 Mon, 08 Apr 2024 02:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj3ONXkGyun5tFE5IphDNdhqCH5yPaZOkaYesdBIGiDj94OXWI7dVDpie+nhYfB8erMnyTsT5aBNchOXT+4Vg=
X-Received: by 2002:a5d:634d:0:b0:343:7785:fb04 with SMTP id
 b13-20020a5d634d000000b003437785fb04mr7540680wrw.67.1712569860588; Mon, 08
 Apr 2024 02:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240404194757.9343-1-philmd@linaro.org>
 <20240404194757.9343-4-philmd@linaro.org>
In-Reply-To: <20240404194757.9343-4-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 11:50:48 +0200
Message-ID: <CABgObfb=Yfd55YiYgrN0YBN+bpZxJs4XHpac4t=kupHKm6oS0w@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 3/7] monitor: Rework stubs to simplify user
 emulation linking
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Apr 4, 2024 at 9:48=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> Currently monitor stubs are scattered in 3 files.
>
> Merge these stubs in 2 files, a generic one (monitor-core)
> included in all builds (in particular user emulation), and
> a less generic one to be included by tools and system emulation.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  stubs/fdset.c        | 17 -----------------

Oops, merging fdset.c breaks storage-daemon linking.

But it is not needed, all I need is

diff --git a/stubs/meson.build b/stubs/meson.build
index 0bf25e6ca53..67cf80aa846 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -10,7 +10,6 @@ stub_ss.add(files('qemu-timer-notify-cb.c'))
 stub_ss.add(files('icount.c'))
 stub_ss.add(files('dump.c'))
 stub_ss.add(files('error-printf.c'))
-stub_ss.add(files('fdset.c'))
 stub_ss.add(files('gdbstub.c'))
 stub_ss.add(files('get-vm-name.c'))
 stub_ss.add(files('graph-lock.c'))
@@ -28,7 +27,10 @@ if libaio.found()
 endif
 stub_ss.add(files('migr-blocker.c'))
 stub_ss.add(files('module-opts.c'))
-stub_ss.add(files('monitor.c'))
+if have_system or have_tools
+  stub_ss.add(files('monitor.c'))
+  stub_ss.add(files('fdset.c'))
+endif
 stub_ss.add(files('monitor-core.c'))
 stub_ss.add(files('physmem.c'))
 stub_ss.add(files('qemu-timer-notify-cb.c'))


Paolo

>  stubs/monitor-core.c | 20 +++++++++++++++-----
>  stubs/monitor.c      |  8 ++++++--
>  stubs/meson.build    |  5 +++--
>  4 files changed, 24 insertions(+), 26 deletions(-)
>  delete mode 100644 stubs/fdset.c
>
> diff --git a/stubs/fdset.c b/stubs/fdset.c
> deleted file mode 100644
> index 56b3663d58..0000000000
> --- a/stubs/fdset.c
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#include "qemu/osdep.h"
> -#include "monitor/monitor.h"
> -
> -int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
> -{
> -    errno =3D ENOSYS;
> -    return -1;
> -}
> -
> -int64_t monitor_fdset_dup_fd_find(int dup_fd)
> -{
> -    return -1;
> -}
> -
> -void monitor_fdset_dup_fd_remove(int dupfd)
> -{
> -}
> diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
> index afa477aae6..72e40bcc15 100644
> --- a/stubs/monitor-core.c
> +++ b/stubs/monitor-core.c
> @@ -1,6 +1,7 @@
> +/* Monitor stub required for user emulation */
>  #include "qemu/osdep.h"
>  #include "monitor/monitor.h"
> -#include "qapi/qapi-emit-events.h"
> +#include "../monitor/monitor-internal.h"
>
>  Monitor *monitor_cur(void)
>  {
> @@ -12,11 +13,22 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
>      return NULL;
>  }
>
> -void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> +int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
> +{
> +    errno =3D ENOSYS;
> +    return -1;
> +}
> +
> +int64_t monitor_fdset_dup_fd_find(int dup_fd)
> +{
> +    return -1;
> +}
> +
> +void monitor_fdset_dup_fd_remove(int dupfd)
>  {
>  }
>
> -void qapi_event_emit(QAPIEvent event, QDict *qdict)
> +void monitor_fdsets_cleanup(void)
>  {
>  }
>
> @@ -24,5 +36,3 @@ int monitor_vprintf(Monitor *mon, const char *fmt, va_l=
ist ap)
>  {
>      abort();
>  }
> -
> -
> diff --git a/stubs/monitor.c b/stubs/monitor.c
> index 20786ac4ff..2fc4dc1493 100644
> --- a/stubs/monitor.c
> +++ b/stubs/monitor.c
> @@ -1,7 +1,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-emit-events.h"
>  #include "monitor/monitor.h"
> -#include "../monitor/monitor-internal.h"
>
>  int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
>  {
> @@ -13,6 +13,10 @@ void monitor_init_hmp(Chardev *chr, bool use_readline,=
 Error **errp)
>  {
>  }
>
> -void monitor_fdsets_cleanup(void)
> +void monitor_init_qmp(Chardev *chr, bool pretty, Error **errp)
> +{
> +}
> +
> +void qapi_event_emit(QAPIEvent event, QDict *qdict)
>  {
>  }
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 0bf25e6ca5..ca1bc07d30 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -10,7 +10,6 @@ stub_ss.add(files('qemu-timer-notify-cb.c'))
>  stub_ss.add(files('icount.c'))
>  stub_ss.add(files('dump.c'))
>  stub_ss.add(files('error-printf.c'))
> -stub_ss.add(files('fdset.c'))
>  stub_ss.add(files('gdbstub.c'))
>  stub_ss.add(files('get-vm-name.c'))
>  stub_ss.add(files('graph-lock.c'))
> @@ -28,7 +27,9 @@ if libaio.found()
>  endif
>  stub_ss.add(files('migr-blocker.c'))
>  stub_ss.add(files('module-opts.c'))
> -stub_ss.add(files('monitor.c'))
> +if have_system or have_tools
> +  stub_ss.add(files('monitor.c'))
> +endif
>  stub_ss.add(files('monitor-core.c'))
>  stub_ss.add(files('physmem.c'))
>  stub_ss.add(files('qemu-timer-notify-cb.c'))
> --
> 2.41.0
>


