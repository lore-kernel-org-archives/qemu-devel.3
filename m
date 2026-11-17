Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE1D606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qbwsjaoK;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=V6OU6vJL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Lh7mYuRX;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=+jkBd30O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTNh0-0002uz-CI; Tue, 17 Nov 2026 13:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTNgy-0002uM-DI
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:14:04 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xTNgw-0006EK-Cm
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:14:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C219B1F7B7;
 Tue, 17 Nov 2026 18:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794939239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HRvPMLPIaqt0SW7auP6kK7RdUV6lOjE5RzMB5BdCz0=;
 b=qbwsjaoKvF4K3Q2PHWDe59ITBk0DraGEYq7ksbmjIuvOzDKhYF+mJlln5mQNqg0NAB7p4P
 d6EB6rNPFc2wEeOJESIUL52M0miByrHBZaIui7x+vPKYvlSQkgAh/HQ2viMunYFxYV8ZmD
 d/fy06EkeOeXCtxEFpbq7PDjoNeBXxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794939239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HRvPMLPIaqt0SW7auP6kK7RdUV6lOjE5RzMB5BdCz0=;
 b=V6OU6vJLYO5dKJj9q2y35NNwSi5Z8VSOZX15Cezb7gId/1DsE7Jigc43QRDnGxbsHUWBNb
 wPWOCG3z7QJESmBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Lh7mYuRX;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+jkBd30O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794939237; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HRvPMLPIaqt0SW7auP6kK7RdUV6lOjE5RzMB5BdCz0=;
 b=Lh7mYuRX7VjmFlaPCetzgB3z0zEMvQ0I1e+4juWk3scsVsAb1gUGZiCPxdD+cyTmwmvKnE
 GzJ6bGeKNJL5I3K+DbX0wos8IYwBj/FZp3rFbUTxtNQULT8LcFWvhnWf9oI69J7xHC7cN2
 qBsypJv1SjPhe6PpEWpv0bjrfdqkmlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794939237;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HRvPMLPIaqt0SW7auP6kK7RdUV6lOjE5RzMB5BdCz0=;
 b=+jkBd30Oxa9lt/S4rLhU6T03X/zTr2af3fj2JvtZO0YRNUZHqvnmpxnqU6gerTEU3kQyrz
 i5cHYykvTAbvh5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15C4B13302;
 Tue, 17 Nov 2026 18:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 62roJ2SZ/GpmKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Nov 2026 18:13:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 04/10] oslib: report kernel stacks in qemu_thread_states()
In-Reply-To: <20260915203455.580999-5-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-5-den@openvz.org>
Date: Tue, 17 Nov 2026 15:13:54 -0300
Message-ID: <87h5hfs4v1.fsf@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C219B1F7B7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,openvz.org:email,intel.com:email,qualcomm.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linaro.org:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
> A wait channel names the primitive a thread is parked on but not the
> path that got it there, and for a thread wedged in a syscall that path
> is the answer.
>

Talking internally with other people that also deal with these kinds of
issues I got the impression (and that's my opinion as well) that having
the warning message and wchan is already very useful. I wonder if we
should separate the other "secondary" sources of data somehow so the
user can opt out of them.

For instance, the stack information will most likely never be available
in a production setup, so that could be behind a knob. Likewise, the PC
addition in patch 6 is nice, but slightly invasive.

One other passing thought is about large hosts with many CPUs. There's
probably a sweet spot of workload vs. amount of cpus vs. watchdog_ms
that would trigger a long sequence of processing and printing stacks
that the admin might not even spot in the logs if the VM operation
continues apparently unaffected.

I wonder whether the above might lead to the feature just being off all
the time.

Maybe putting a precedence to the information we print and providing a
bql-watchdog-level=3D[1-5] option so a more conservative environment could
just enable the warning message, then wchan, and so on. Just a thought,
I actually like the simplicity of having just _ms and _abort.

> Read /proc/tid/stack when the report is built, and keep the wait
> channel for when it cannot be. The file is restricted to CAP_SYS_ADMIN
> in the init namespace, so ask once rather than failing per thread, and
> say why the report came back thinner. Skip a running thread, which has
> no settled stack to unwind, and cap the frames, because the deep end of

What this "settled stack" statement means in practice? I think having
even a partial view of the stack up to a point would already be
elucidative, even if the last few frames are bogus.

For example, I see a few:

  1822761 CPU 0/KVM        R
      pc 0x7fb3bbcfae0f ioctl+0x41
      wchan 0

whereas something like this looks more interesting:

  1821448 CPU 0/KVM        R
      pc 0x7fbe91119e0f ioctl+0x41
      [<0>] preempt_schedule_thunk+0x16/0x30
      [<0>] srcu_gp_start_if_needed+0x38d/0x520
      [<0>] __synchronize_srcu.part.0+0x7d/0xb0
      [<0>] kvm_swap_active_memslots+0x133/0x180 [kvm]
      [<0>] kvm_set_memslot+0x47f/0x600 [kvm]
      [<0>] kvm_vm_ioctl+0x1113/0x16e0 [kvm]
      [<0>] __x64_sys_ioctl+0x97/0xc0
      [<0>] do_syscall_64+0x7d/0x160
      [<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

> a stack is rarely the part that explains the hang.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  include/qemu/osdep.h |  4 ++--
>  util/oslib-posix.c   | 52 +++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 5 deletions(-)
>
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 8039bf91b8..c15ffd7880 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -672,8 +672,8 @@ bool qemu_debugger_attached(void);
>   *
>   * Returns a newly allocated, newline terminated description of every th=
read
>   * in this process apart from the caller: its id, name, scheduler state =
and
> - * the wait channel it is parked on, or NULL on a host that cannot repor=
t any
> - * of that.
> + * kernel stack, or NULL on a host that cannot report any of that. Where=
 the
> + * kernel stack is privileged the description falls back to a wait chann=
el.
>   */
>  char *qemu_thread_states(void);
>=20=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 79887d370c..6a683b849e 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -145,13 +145,39 @@ static char *read_task_file(const char *tid, const =
char *name)
>      return buf;
>  }
>=20=20
> +#define THREAD_STACK_FRAMES 12
> +
> +/*
> + * /proc/tid/stack is restricted to CAP_SYS_ADMIN in the init namespace,=
 so
> + * ask once instead of failing per thread, and say why the report is thi=
nner.
> + */
> +static bool thread_stacks_readable(void)
> +{
> +    static int readable =3D -1;
> +    g_autofree char *path =3D NULL;
> +    g_autofree char *buf =3D NULL;
> +
> +    if (readable >=3D 0) {
> +        return readable;
> +    }
> +    path =3D g_strdup_printf("/proc/self/task/%d/stack", qemu_get_thread=
_id());
> +    readable =3D g_file_get_contents(path, &buf, NULL, NULL);
> +    if (!readable) {
> +        warn_report("kernel stacks need CAP_SYS_ADMIN, falling back to w=
chan");
> +    }
> +    return readable;
> +}
> +
>  static void append_thread_state(GString *out, const char *tid)
>  {
>      g_autofree char *comm =3D read_task_file(tid, "comm");
>      g_autofree char *stat =3D NULL;
> +    g_autofree char *stack =3D NULL;
>      g_autofree char *wchan =3D NULL;
> +    g_auto(GStrv) lines =3D NULL;
>      char state =3D '?';
>      char *rparen;
> +    int i;
>=20=20
>      if (!comm) {
>          return;
> @@ -168,9 +194,26 @@ static void append_thread_state(GString *out, const =
char *tid)
>      }
>      g_string_append_printf(out, "  %-7s %-16s %c\n", tid, comm, state);
>=20=20
> -    wchan =3D read_task_file(tid, "wchan");
> -    if (wchan && wchan[0]) {
> -        g_string_append_printf(out, "      wchan %s\n", wchan);
> +    /* A running thread has no settled kernel stack to unwind */
> +    if (state !=3D 'R' && thread_stacks_readable()) {
> +        stack =3D read_task_file(tid, "stack");
> +    }
> +    if (!stack) {
> +        wchan =3D read_task_file(tid, "wchan");
> +        if (wchan && wchan[0]) {
> +            g_string_append_printf(out, "      wchan %s\n", wchan);
> +        }
> +        return;
> +    }
> +
> +    lines =3D g_strsplit(stack, "\n", 0);
> +    for (i =3D 0; i < THREAD_STACK_FRAMES && lines[i]; i++) {
> +        if (lines[i][0]) {
> +            g_string_append_printf(out, "      %s\n", lines[i]);
> +        }
> +    }
> +    if (lines[i]) {
> +        g_string_append(out, "      ...\n");
>      }
>  }
>=20=20
> @@ -183,6 +226,9 @@ char *qemu_thread_states(void)
>      if (!dir) {
>          return NULL;
>      }
> +    /* Emit the permission notice ahead of the listing, not inside it */
> +    thread_stacks_readable();
> +
>      out =3D g_string_new(NULL);
>      while ((tid =3D g_dir_read_name(dir))) {
>          if (atoi(tid) !=3D qemu_get_thread_id()) {

