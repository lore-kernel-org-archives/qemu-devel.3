Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A5E606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bm+K24/I
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xURSw-000676-Lg; Fri, 20 Nov 2026 11:27:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xURSu-00065O-Cd
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:27:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xURSs-0001QN-Gn
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 11:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795192073;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8+VjHdHYzMDMZWrnPJV8acexpfYiqOeAAxT87GbAB8=;
 b=Bm+K24/I45cU8WubWq1ICYCfXSyiYlcadc8sQLrsKIfqeIhxf0u3mueeRhckM1gEXvaui5
 b2w22YZPy0w2iMYyrZFs5yCNVAaGKTNItq+C86cVZgGOfQMoTO75ctSVL6Rmm3wLFfRES/
 CbQgnad88G8nm6S58HFyVFpceD9P738=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-Q-PvJwaANo6epMPVSh_Rqg-1; Fri,
 20 Nov 2026 16:27:50 +0000
X-MC-Unique: Q-PvJwaANo6epMPVSh_Rqg-1
X-Mimecast-MFC-AGG-ID: Q-PvJwaANo6epMPVSh_Rqg_1795192069
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FAE21955BEF; Fri, 20 Nov 2026 16:27:48 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 549381956049; Fri, 20 Nov 2026 16:27:46 +0000 (UTC)
Date: Fri, 20 Nov 2026 16:27:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH 02/10] oslib: add qemu_debugger_attached()
Message-ID: <awB0_96HZmwfiYNd@redhat.com>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-3-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915203455.580999-3-den@openvz.org>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 15, 2026 at 10:34:46PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Code that watches for a hang has to tell a hang apart from a debugger
> stop, because under a debugger every thread stops and whatever liveness
> signal the watcher samples stops changing with them.
> 
> Linux reports the tracer in /proc/self/status and Windows has
> IsDebuggerPresent(). Answer false elsewhere, which leaves the caller
> behaving as it did before the check.
> 
> Match the Linux field at the start of a line. The Name: line holds
> fifteen characters of comm, enough to spell the field name and appear
> ahead of the real one.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  include/qemu/osdep.h |  9 +++++++++
>  util/oslib-posix.c   | 22 ++++++++++++++++++++++
>  util/oslib-win32.c   |  5 +++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 1ec5b42230..96afe09632 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -658,6 +658,15 @@ bool qemu_write_pidfile(const char *pidfile, Error **errp);
>  
>  int qemu_get_thread_id(void);
>  
> +/**
> + * qemu_debugger_attached:
> + *
> + * Returns true if a debugger is currently tracing this process. Meant for
> + * code that would otherwise mistake a debugger stop for a hang, and false
> + * on hosts where this cannot be determined.
> + */
> +bool qemu_debugger_attached(void);
> +
>  /**
>   * qemu_kill_thread:
>   * @tid: thread id.
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index dc001da66d..4eb6a40628 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -112,6 +112,28 @@ int qemu_get_thread_id(void)
>  #endif
>  }
>  
> +bool qemu_debugger_attached(void)
> +{
> +#ifdef CONFIG_LINUX
> +    static const char key[] = "TracerPid:";
> +    g_autofree char *status = NULL;
> +    const char *p = NULL;
> +
> +    if (!g_file_get_contents("/proc/self/status", &status, NULL, NULL)) {
> +        return false;
> +    }
> +    while ((p = strstr(p ? p : status, key))) {
> +        if (p == status || p[-1] == '\n') {
> +            return atoi(p + sizeof(key) - 1) > 0;
> +        }
> +        p += sizeof(key) - 1;
> +    }

Do we need a loop for this ?  IIUC, "TracerPid:" can only
be present in the file once, so a single strstr + atoi
(or realy qemu_strtoi) would be sufficient.

> +    return false;
> +#else
> +    return false;
> +#endif
> +}
> +
>  int qemu_kill_thread(int tid, int sig)
>  {
>  #if defined(__linux__)
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 5f3e8f4d98..6663d83151 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -228,6 +228,11 @@ int qemu_get_thread_id(void)
>      return GetCurrentThreadId();
>  }
>  
> +bool qemu_debugger_attached(void)
> +{
> +    return IsDebuggerPresent();
> +}
> +
>  char *
>  qemu_get_local_state_dir(void)
>  {
> -- 
> 2.53.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


