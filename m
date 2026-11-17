Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2B606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=vlQHTn4l;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=17ZwiBdh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=oDYa0LUo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=XADUjylz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJld-0001rt-Kg; Tue, 17 Nov 2026 09:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTJla-0001m5-F4
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:02:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTJlY-0003m5-L1
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 09:02:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E48B91F792;
 Tue, 17 Nov 2026 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLMO6yGlwGcoAu7zaAIE0ZRH6W0u7YEMycdY2IbQIq4=;
 b=vlQHTn4lPgjp0RGNdtEErQpOSUAujmourvxGWGb71675Jv+TK5uBf2xmKrfaDyILLrvhdK
 TCzLTrn7xgo1ik6MjNQlvZaKUe9SlLUYY8B47ga0jdUYw6Wjc3vUGviIWkDGm3bdccx3+Z
 oZnOdHuD9fvUjykEYQSi+Uq8HM66yc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLMO6yGlwGcoAu7zaAIE0ZRH6W0u7YEMycdY2IbQIq4=;
 b=17ZwiBdh7iE2GMndhKnbXEvma4dCs0SxmAmkbTn5aXpTlc7J5cqITRwzBkT5pT0+TeLyme
 1ut4urs3YWvTtnBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oDYa0LUo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XADUjylz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLMO6yGlwGcoAu7zaAIE0ZRH6W0u7YEMycdY2IbQIq4=;
 b=oDYa0LUor2v5pbaS0GzGnRhdmfvzu38m3mGjZpeip4d8tlViWmSPHklkWjVGkxyTPHQ3vn
 1BOdtoqbNbtDVgaAqi0LzM1Pgp3Hr8F75ZSWbW5kWRmnFaSbxe3HtXRqkz+M0jGqpOL6fn
 ZzRmUnXW5XeJa0UANOnOWgPSEZivZa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WLMO6yGlwGcoAu7zaAIE0ZRH6W0u7YEMycdY2IbQIq4=;
 b=XADUjylzNzla7D0bOh/ou3H1lKAgvU/bG8XPmvvBM0GG6Q3RB/sgKMrD+HVpFD8Jw/C8iq
 ADoJNoV5Sz9oqrDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AA8413302;
 Tue, 17 Nov 2026 14:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sb88OXNe/GpUIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 14:02:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>, Stefan Weil
 <sw@weilnetz.de>
Subject: Re: [PATCH 03/10] oslib: add qemu_thread_states()
In-Reply-To: <20260915203455.580999-4-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-4-den@openvz.org>
Date: Tue, 17 Nov 2026 11:02:25 -0300
Message-ID: <87jymbsgi6.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[qualcomm.com:email,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,weilnetz.de:email,intel.com:email,openvz.org:email,linaro.org:email];
 DKIM_TRACE(0.00)[suse.de:+]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[8];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -13.51
X-Rspamd-Queue-Id: E48B91F792
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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
> A watchdog that reports a hang wants to say what every thread was doing,
> and that answer is host specific. Put it beside the other process
> introspection helpers rather than in the code that happens to need it
> first.
>
> Describe each thread by id, name, scheduler state and the wait channel
> it is parked on, all of which Linux exposes in /proc/self/task without
> privilege. That is already enough to separate a thread blocked on a
> userspace lock, which waits in a futex, from one blocked in the kernel,
> which names the primitive it sits on. Skip the caller, which is
> reporting rather than hanging.
>
> Hosts with no way to answer return NULL, leaving the caller to print
> its own message and nothing more.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  include/qemu/osdep.h | 10 +++++++
>  util/oslib-posix.c   | 71 ++++++++++++++++++++++++++++++++++++++++++++
>  util/oslib-win32.c   |  5 ++++
>  3 files changed, 86 insertions(+)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 96afe09632..8039bf91b8 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -667,6 +667,16 @@ int qemu_get_thread_id(void);
>   */
>  bool qemu_debugger_attached(void);
>=20=20
> +/**
> + * qemu_thread_states:
> + *
> + * Returns a newly allocated, newline terminated description of every th=
read
> + * in this process apart from the caller: its id, name, scheduler state =
and
> + * the wait channel it is parked on, or NULL on a host that cannot repor=
t any
> + * of that.
> + */
> +char *qemu_thread_states(void);
> +
>  /**
>   * qemu_kill_thread:
>   * @tid: thread id.
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 4eb6a40628..79887d370c 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -134,6 +134,77 @@ bool qemu_debugger_attached(void)
>  #endif
>  }
>=20=20
> +#ifdef CONFIG_LINUX
> +
> +static char *read_task_file(const char *tid, const char *name)
> +{
> +    g_autofree char *path =3D g_strdup_printf("/proc/self/task/%s/%s", t=
id, name);
> +    char *buf =3D NULL;
> +
> +    g_file_get_contents(path, &buf, NULL, NULL);
> +    return buf;
> +}
> +
> +static void append_thread_state(GString *out, const char *tid)
> +{
> +    g_autofree char *comm =3D read_task_file(tid, "comm");
> +    g_autofree char *stat =3D NULL;
> +    g_autofree char *wchan =3D NULL;
> +    char state =3D '?';
> +    char *rparen;
> +
> +    if (!comm) {
> +        return;
> +    }
> +    g_strchomp(comm);
> +
> +    stat =3D read_task_file(tid, "stat");
> +    if (stat) {
> +        /* comm can hold anything, ')' included, so scan from the right =
*/
> +        rparen =3D strrchr(stat, ')');
> +        if (rparen && rparen[1] =3D=3D ' ') {
> +            state =3D rparen[2];
> +        }
> +    }
> +    g_string_append_printf(out, "  %-7s %-16s %c\n", tid, comm, state);
> +
> +    wchan =3D read_task_file(tid, "wchan");
> +    if (wchan && wchan[0]) {
> +        g_string_append_printf(out, "      wchan %s\n", wchan);
> +    }
> +}
> +
> +char *qemu_thread_states(void)
> +{
> +    g_autoptr(GDir) dir =3D g_dir_open("/proc/self/task", 0, NULL);
> +    const char *tid;
> +    GString *out;
> +
> +    if (!dir) {
> +        return NULL;
> +    }
> +    out =3D g_string_new(NULL);
> +    while ((tid =3D g_dir_read_name(dir))) {
> +        if (atoi(tid) !=3D qemu_get_thread_id()) {
> +            append_thread_state(out, tid);
> +        }
> +    }
> +    if (!out->len) {
> +        g_string_free(out, TRUE);
> +        return NULL;
> +    }
> +    return g_string_free(out, FALSE);
> +}
> +
> +#else
> +
> +char *qemu_thread_states(void)
> +{
> +    return NULL;
> +}
> +
> +#endif /* CONFIG_LINUX */
> +
>  int qemu_kill_thread(int tid, int sig)
>  {
>  #if defined(__linux__)
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 6663d83151..d18886847c 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -233,6 +233,11 @@ bool qemu_debugger_attached(void)
>      return IsDebuggerPresent();
>  }
>=20=20
> +char *qemu_thread_states(void)
> +{
> +    return NULL;
> +}
> +
>  char *
>  qemu_get_local_state_dir(void)
>  {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

