Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE8D4E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 09:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIlw3-0000RH-Bt; Wed, 04 Dec 2024 04:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlvv-0000Qx-1Z
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:44:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tIlvs-0001aS-AE
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 04:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733305469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soqovry5DXzwPssp9VgLzCCbsprjW6DZKK+SM4BZI5o=;
 b=B4t7Q6UqH66sv8mty5safZpWVw8tFfKDanjxJrGF4Lhf1u5mkCmW3b51DjvQl8XKJPhZnd
 ZJqDR7dqihwk/pPByKM7qNp3Onao8eV5FUTdJe4Aj8Q7HTPgd+CtpEQXa6/xHVAkxsfZww
 s+vrSZkNYXjqlV5QX7srZG8xlCzy81I=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-WlXZY3fDNLaMdXntG46fsw-1; Wed, 04 Dec 2024 04:44:27 -0500
X-MC-Unique: WlXZY3fDNLaMdXntG46fsw-1
X-Mimecast-MFC-AGG-ID: WlXZY3fDNLaMdXntG46fsw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d88bc8be25so79037786d6.3
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 01:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733305467; x=1733910267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=soqovry5DXzwPssp9VgLzCCbsprjW6DZKK+SM4BZI5o=;
 b=wnJh4hWK1NWdWu9kB3/+Dhy9hMxIu2fF7/9rsKO5yWEFOnH4S9mTkHaO1q9W563hnz
 t8FOcfr8YNkMpSsGSVxncyDMnooHKsjpppRkcH+damthX2hqmEv2cT7EjF7oqQ/sEvsy
 xcEfgiMwkAbOOs48WQmjpsVZ7dYH2Z7tl4GGYzpbVb7/vkS4NgJU+9329zuPgWNeHyjW
 sjvaAys0LKZbCMqAD08RSFuYGl52b8nuCq71hz/xGetGSPQ1A8o9QNtcdvAoIdea5IqE
 /4MXLri+gWCmIQvK0bFEXc+bGNaEGJt3Cb7wSkSyxiEIS9VAi8+vb1BGKIvOATue9PKN
 aWvw==
X-Gm-Message-State: AOJu0Yxh9KOHFeJraZrAnXYGj8ZFxai/U1KOyxRl4LURCDbTYsbvoKrc
 HMtq7BOst1PQQVyURvj0odHKPTwYHwAxrNHtyZFUMfHU4CT2g2a6isviOQhM74G2taX4PDzIY2h
 95lvo1J9RZqt99HSyyvJHyOX+R5nQ7Km/HehYrKEbpapF/AgFOnpGReSJwxSLA5sOR7TqJD9keC
 PAQxDCWNpBAuuiaoPYMoSS4XhqsFA=
X-Gm-Gg: ASbGncviKiX40Q7pc+QZOpj7x1gm3UFanopXEbiB0wU5rx+aZY9xDweVhve5UAtswoI
 Oa0cyqpIjC/jhGjSO30bF5ZwvMbhVb0btgw==
X-Received: by 2002:a05:6214:20ec:b0:6d4:382:6c68 with SMTP id
 6a1803df08f44-6d8b73ab98cmr104670596d6.28.1733305467321; 
 Wed, 04 Dec 2024 01:44:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGm1l+Ui5oKc2FhIrlfRBYnRuBZDYsYdnkotGoKnz6qNPLh37ywZPoOqzFA2xAuinIihlP7u7fNsDf6/O3RCZ4=
X-Received: by 2002:a05:6214:20ec:b0:6d4:382:6c68 with SMTP id
 6a1803df08f44-6d8b73ab98cmr104670436d6.28.1733305467035; Wed, 04 Dec 2024
 01:44:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1730713917.git.mprivozn@redhat.com>
 <699917b7868f7fbae3c076f013850ba9f8a5cb8d.1730713917.git.mprivozn@redhat.com>
In-Reply-To: <699917b7868f7fbae3c076f013850ba9f8a5cb8d.1730713917.git.mprivozn@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 4 Dec 2024 11:44:16 +0200
Message-ID: <CAPMcbCrFyeZ0zvJbinNawwYLZjvs8BM=FOo5G1V1Gx9+ZGmyug@mail.gmail.com>
Subject: Re: [PATCH 3/4] qga: Don't daemonize before channel is initialized
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000a6780506286ea073"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--000000000000a6780506286ea073
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:54=E2=80=AFAM Michal Privoznik <mprivozn@redhat.c=
om>
wrote:

> If the agent is set to daemonize but for whatever reason fails to
> init the channel, the error message is lost. Worse, the agent
> daemonizes needlessly and returns success. For instance:
>
>   # qemu-ga -m virtio-serial \
>             -p /dev/nonexistent_device \
>             -f /run/qemu-ga.pid \
>             -t /run \
>             -d
>   # echo $?
>   0
>
> This makes it needlessly hard for init scripts to detect a
> failure in qemu-ga startup. Though, they shouldn't pass '-d' in
> the first place.
>
> Let's open the channel first and only after that become a daemon.
>
> Related bug: https://bugs.gentoo.org/810628
>
> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> ---
>  qga/main.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index c003aacbe0..6240845f39 100644
> --- a/qga/main.c
> +++ b/qga/main.c
> @@ -1430,7 +1430,6 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>          if (config->daemonize) {
>              /* delay opening/locking of pidfile till filesystems are
> unfrozen */
>              s->deferred_options.pid_filepath =3D config->pid_filepath;
> -            become_daemon(NULL);
>          }
>          if (config->log_filepath) {
>              /* delay opening the log file till filesystems are unfrozen =
*/
> @@ -1438,9 +1437,6 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>          }
>          ga_disable_logging(s);
>      } else {
> -        if (config->daemonize) {
> -            become_daemon(config->pid_filepath);
> -        }
>          if (config->log_filepath) {
>              FILE *log_file =3D ga_open_logfile(config->log_filepath);
>              if (!log_file) {
> @@ -1487,6 +1483,20 @@ static GAState *initialize_agent(GAConfig *config,
> int socket_activation)
>
>      ga_apply_command_filters(s);
>
> +    if (!channel_init(s, s->config->method, s->config->channel_path,
> +                      s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD =
:
> -1)) {
> +        g_critical("failed to initialize guest agent channel");
> +        return NULL;
> +    }
> +
> +    if (config->daemonize) {
> +        if (ga_is_frozen(s)) {
> +            become_daemon(NULL);
> +        } else {
> +            become_daemon(config->pid_filepath);
> +        }
> +    }
> +
>      ga_state =3D s;
>      return s;
>  }
> @@ -1513,12 +1523,6 @@ static void cleanup_agent(GAState *s)
>
>  static int run_agent_once(GAState *s)
>  {
> -    if (!channel_init(s, s->config->method, s->config->channel_path,
> -                      s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD =
:
> -1)) {
> -        g_critical("failed to initialize guest agent channel");
> -        return EXIT_FAILURE;
> -    }
> -


The old flow:
run_agent call run_agent_once in loop
run_agent_once initialize channel for every run

after your changes
you expect to initialize the channel only once
this can cause issues on Windows during driver update
the default configuration on Windows is QGA + VirtioSerial and in CLI
--retry-path
during driver update (that can happen via Windows Update) the channel will
be closed
so QGA must reinitialize the channel

Theoretically, the same can happen on Linux with a UNIX socket



>      g_main_loop_run(s->main_loop);
>
>      if (s->channel) {
> --
> 2.45.2
>
>

--000000000000a6780506286ea073
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 4, =
2024 at 11:54=E2=80=AFAM Michal Privoznik &lt;<a href=3D"mailto:mprivozn@re=
dhat.com">mprivozn@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">If the agent is set to daemonize but for whate=
ver reason fails to<br>
init the channel, the error message is lost. Worse, the agent<br>
daemonizes needlessly and returns success. For instance:<br>
<br>
=C2=A0 # qemu-ga -m virtio-serial \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -p /dev/nonexistent_device \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -f /run/qemu-ga.pid \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -t /run \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -d<br>
=C2=A0 # echo $?<br>
=C2=A0 0<br>
<br>
This makes it needlessly hard for init scripts to detect a<br>
failure in qemu-ga startup. Though, they shouldn&#39;t pass &#39;-d&#39; in=
<br>
the first place.<br>
<br>
Let&#39;s open the channel first and only after that become a daemon.<br>
<br>
Related bug: <a href=3D"https://bugs.gentoo.org/810628" rel=3D"noreferrer" =
target=3D"_blank">https://bugs.gentoo.org/810628</a><br>
<br>
Signed-off-by: Michal Privoznik &lt;<a href=3D"mailto:mprivozn@redhat.com" =
target=3D"_blank">mprivozn@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 24 ++++++++++++++----------<br>
=C2=A01 file changed, 14 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index c003aacbe0..6240845f39 100644<br>
--- a/qga/main.c<br>
+++ b/qga/main.c<br>
@@ -1430,7 +1430,6 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (config-&gt;daemonize) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* delay opening/locking of=
 pidfile till filesystems are unfrozen */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;deferred_options.pid_=
filepath =3D config-&gt;pid_filepath;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 become_daemon(NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (config-&gt;log_filepath) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* delay opening the log fi=
le till filesystems are unfrozen */<br>
@@ -1438,9 +1437,6 @@ static GAState *initialize_agent(GAConfig *config, in=
t socket_activation)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_disable_logging(s);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (config-&gt;daemonize) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 become_daemon(config-&gt;pid_fil=
epath);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (config-&gt;log_filepath) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FILE *log_file =3D ga_open_=
logfile(config-&gt;log_filepath);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!log_file) {<br>
@@ -1487,6 +1483,20 @@ static GAState *initialize_agent(GAConfig *config, i=
nt socket_activation)<br>
<br>
=C2=A0 =C2=A0 =C2=A0ga_apply_command_filters(s);<br>
<br>
+=C2=A0 =C2=A0 if (!channel_init(s, s-&gt;config-&gt;method, s-&gt;config-&=
gt;channel_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;failed to initialize guest ag=
ent channel&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (config-&gt;daemonize) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ga_is_frozen(s)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 become_daemon(NULL);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 become_daemon(config-&gt;pid_fil=
epath);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0ga_state =3D s;<br>
=C2=A0 =C2=A0 =C2=A0return s;<br>
=C2=A0}<br>
@@ -1513,12 +1523,6 @@ static void cleanup_agent(GAState *s)<br>
<br>
=C2=A0static int run_agent_once(GAState *s)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (!channel_init(s, s-&gt;config-&gt;method, s-&gt;config-&=
gt;channel_path,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_critical(&quot;failed to initialize guest ag=
ent channel&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return EXIT_FAILURE;<br>
-=C2=A0 =C2=A0 }<br>
-</blockquote><div><br></div><div>The old flow:<br></div><div>run_agent cal=
l run_agent_once in loop<br>run_agent_once initialize channel for every run=
</div><div><br></div><div>after your changes<br>you expect to initialize th=
e channel only once</div><div>this can cause issues on Windows during drive=
r update</div><div>the default configuration on Windows is QGA + VirtioSeri=
al and in CLI --retry-path</div><div>during driver update (that can happen =
via Windows Update) the channel will be closed<br></div><div>so QGA must re=
initialize the=C2=A0channel<br><br></div><div>Theoretically, the same can h=
appen on Linux with a UNIX socket</div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0g_main_loop_run(s-&gt;main_loop);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;channel) {<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div></div>

--000000000000a6780506286ea073--


