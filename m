Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F8606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=K3kxh8m1;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V43V9E6l;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=K3kxh8m1;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V43V9E6l
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJVl-0005SU-CI; Tue, 17 Nov 2026 08:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTJVf-0005S6-8v
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:46:07 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTJVd-0005WU-8D
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:46:06 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89C8C22235;
 Tue, 17 Nov 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794923163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8UDNljWugtEHLChkWtjrvWIwQDbqtoWizcxkR/pXgw=;
 b=K3kxh8m1ElIkr/mcwedAwP6FIroO3gRbzkqtxBKlFitoyE2qloRvUsA2FwT/t2lto4qpBF
 JiftBYeuJmfTfCFrSXiedXjhxdxV+kP11f7nVQsM7cS9v64Wq6QdQB/8f1qZGI26Ekr5+m
 a1ov9qflMA8GEdCM+NojHMmpmiWA/Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794923163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8UDNljWugtEHLChkWtjrvWIwQDbqtoWizcxkR/pXgw=;
 b=V43V9E6lhTThf1fiDTqyNsgtb0g69/dmEol8cNlS669wAzdGXgCtmduO9BuyAV1hC2isLS
 xZll4L/jyiB0p9Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794923163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8UDNljWugtEHLChkWtjrvWIwQDbqtoWizcxkR/pXgw=;
 b=K3kxh8m1ElIkr/mcwedAwP6FIroO3gRbzkqtxBKlFitoyE2qloRvUsA2FwT/t2lto4qpBF
 JiftBYeuJmfTfCFrSXiedXjhxdxV+kP11f7nVQsM7cS9v64Wq6QdQB/8f1qZGI26Ekr5+m
 a1ov9qflMA8GEdCM+NojHMmpmiWA/Ns=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794923163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8UDNljWugtEHLChkWtjrvWIwQDbqtoWizcxkR/pXgw=;
 b=V43V9E6lhTThf1fiDTqyNsgtb0g69/dmEol8cNlS669wAzdGXgCtmduO9BuyAV1hC2isLS
 xZll4L/jyiB0p9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0157E13302;
 Tue, 17 Nov 2026 13:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gLc3I5pa/GqBDwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 13:46:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>, Stefan Weil
 <sw@weilnetz.de>
Subject: Re: [PATCH 02/10] oslib: add qemu_debugger_attached()
In-Reply-To: <20260915203455.580999-3-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-3-den@openvz.org>
Date: Tue, 17 Nov 2026 10:45:56 -0300
Message-ID: <87mrr7sh9n.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[linaro.org:email,imap1.dmz-prg2.suse.org:helo,openvz.org:email,suse.de:email,qualcomm.com:email,intel.com:email];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[openvz.org:email, qualcomm.com:email,
 imap1.dmz-prg2.suse.org:helo, linaro.org:email, intel.com:email]
X-Spam-Score: -13.30
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Denis V. Lunev" <den@openvz.org> writes:

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
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
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
> @@ -658,6 +658,15 @@ bool qemu_write_pidfile(const char *pidfile, Error *=
*errp);
>=20=20
>  int qemu_get_thread_id(void);
>=20=20
> +/**
> + * qemu_debugger_attached:
> + *
> + * Returns true if a debugger is currently tracing this process. Meant f=
or
> + * code that would otherwise mistake a debugger stop for a hang, and fal=
se
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
>=20=20
> +bool qemu_debugger_attached(void)
> +{
> +#ifdef CONFIG_LINUX
> +    static const char key[] =3D "TracerPid:";
> +    g_autofree char *status =3D NULL;
> +    const char *p =3D NULL;
> +
> +    if (!g_file_get_contents("/proc/self/status", &status, NULL, NULL)) {
> +        return false;
> +    }
> +    while ((p =3D strstr(p ? p : status, key))) {
> +        if (p =3D=3D status || p[-1] =3D=3D '\n') {
> +            return atoi(p + sizeof(key) - 1) > 0;
> +        }
> +        p +=3D sizeof(key) - 1;
> +    }
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
>=20=20
> +bool qemu_debugger_attached(void)
> +{
> +    return IsDebuggerPresent();
> +}
> +
>  char *
>  qemu_get_local_state_dir(void)
>  {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

