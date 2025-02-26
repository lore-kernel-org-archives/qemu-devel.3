Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C536AC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 09:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnDi4-0007Wj-8C; Wed, 26 Feb 2025 04:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnDi1-0007WA-IA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:28:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tnDhy-0003sh-Kb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 04:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740562080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LqjoTPCNXTlzrQnLWYnPRe/vV/y5hKFQxCIl5mEDcXk=;
 b=CQC8tgR+kQknTbxzWl9Gk1OYXeplHtgp5GdV7ZbT3FXi1Xq0m9J7nwYQvXzxw9gK+Pbq/b
 zHOJhBZSHZAfJZlIKGMlb2HYmwIi/LflQk2E8gvsXiA6EyzNHxQ3coXXS+YBFA47k+VAoF
 LS1QFsYcd6r4lNwiIWxFwoWCcfu3wWk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-OzcA2yJtPcW0blk3w4cCtQ-1; Wed, 26 Feb 2025 04:26:33 -0500
X-MC-Unique: OzcA2yJtPcW0blk3w4cCtQ-1
X-Mimecast-MFC-AGG-ID: OzcA2yJtPcW0blk3w4cCtQ_1740561993
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6e669366564so169201506d6.0
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 01:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740561993; x=1741166793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LqjoTPCNXTlzrQnLWYnPRe/vV/y5hKFQxCIl5mEDcXk=;
 b=xERmR+ObTa4OXb+nL1tgQEcRbKFrEKRvkjK5Y/+srMqfLSjrf5IhZXInBJBD61Z4uW
 fMhWZ/ov51ByQDxtvhtvR4PIB/lBlFTJr13DC2tBY/n8LZfyZHTuFOvG3eKNAP6DH/3k
 tLkqUDdMEKuXR1ml/EvAQdTM55pF314YJLAEwv7VCpma/qCfJLPJIBOdsr9ByPHrQz4D
 9W/2YXU2B0WIomnOLroja9Zw4qA8rU1Y6PIIcyZbjIrXqZuq2leM3TYkrf+D0nN2nHMv
 HyOkoLDvnSRlWvLxrGXzb+qycnfeOOxdjLn3SQ0RvySBG3uK1/nm8VrGsYPI9s4aJ4pF
 IKRg==
X-Gm-Message-State: AOJu0YxMN0IsiBjGKP36MSVMCH0xW/WIuy3V2WKjB2ZAlZTVPoTR6r/Y
 dm3bhbdaBNbHGKzGiwLdzrxHAHY3+TsnnOg9JaqEzblA+EMheqZnlJsWfPfcjR2AUEycoPrcRxb
 9eJjW21ljYEP+WuP2SdNZothviCef9j/r+tgjIuJLyvd8G3pPfiJ9Nyq/AW9u7/JVv4adK8avX+
 xB1JEwE94qWZbYPDTADjBXmTAZFUQ=
X-Gm-Gg: ASbGncsC6CCaqvon3g0JiwvFXcvV9gMY2tTIThUHGX+JX6XPc0v5Sua4nL0Ul4IfDEm
 DnD5QynvBi6UfDUQ5UFb1HD5GpcpjJd13bgfcjR6cfK0R3M8Ee4Xfvj54BS0POsViYzblUM9JMr
 g=
X-Received: by 2002:a05:6214:124f:b0:6d8:8d16:7cec with SMTP id
 6a1803df08f44-6e87abcd064mr103217246d6.37.1740561993334; 
 Wed, 26 Feb 2025 01:26:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFtQIaGZFJkGDkYtmncMGb4E7HusqGTbqL+mKjSB4lI+R0UjJvqIBH/1RYUqglP40EszXzcZswUCHQj77e/gw=
X-Received: by 2002:a05:6214:124f:b0:6d8:8d16:7cec with SMTP id
 6a1803df08f44-6e87abcd064mr103217066d6.37.1740561993068; Wed, 26 Feb 2025
 01:26:33 -0800 (PST)
MIME-Version: 1.0
References: <cover.1736261360.git.mprivozn@redhat.com>
 <7a42b0cbda5c7e01cf76bc1b29a1210cd018fa78.1736261360.git.mprivozn@redhat.com>
In-Reply-To: <7a42b0cbda5c7e01cf76bc1b29a1210cd018fa78.1736261360.git.mprivozn@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 26 Feb 2025 11:26:22 +0200
X-Gm-Features: AQ5f1JoBtM3MXu-4X-njTo65QRCUUJlIFNlaSLruXTXdDnFHbsTgUXtdaLwH-XY
Message-ID: <CAPMcbCph6TD4hyhgRkMTfuHsNOOT4M-qck9c_70PHvXnWERy0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] qga: Don't daemonize before channel is initialized
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jtomko@redhat.com
Content-Type: multipart/alternative; boundary="0000000000004e833f062f082bbe"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000004e833f062f082bbe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Tue, Jan 7, 2025 at 4:52=E2=80=AFPM Michal Privoznik <mprivozn@redhat.co=
m> wrote:

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
> Reviewed-by: J=C3=A1n Tomko <jtomko@redhat.com>
> ---
>  qga/main.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/qga/main.c b/qga/main.c
> index 68ea7f275a..35f061b5ea 100644
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
> @@ -1513,8 +1523,9 @@ static void cleanup_agent(GAState *s)
>
>  static int run_agent_once(GAState *s)
>  {
> -    if (!channel_init(s, s->config->method, s->config->channel_path,
> -                      s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD =
:
> -1)) {
> +    if (!s->channel &&
> +        channel_init(s, s->config->method, s->config->channel_path,
> +                     s->socket_activation ? FIRST_SOCKET_ACTIVATION_FD :
> -1)) {
>          g_critical("failed to initialize guest agent channel");
>          return EXIT_FAILURE;
>      }
> @@ -1523,6 +1534,7 @@ static int run_agent_once(GAState *s)
>
>      if (s->channel) {
>          ga_channel_free(s->channel);
> +        s->channel =3D NULL;
>      }
>
>      return EXIT_SUCCESS;
> --
> 2.45.2
>
>

--0000000000004e833f062f082bbe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Jan 7, 2025 at 4:52=E2=80=AFPM Michal Privoznik &lt;<a hre=
f=3D"mailto:mprivozn@redhat.com">mprivozn@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">If the agent is set to =
daemonize but for whatever reason fails to<br>
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
Reviewed-by: J=C3=A1n Tomko &lt;<a href=3D"mailto:jtomko@redhat.com" target=
=3D"_blank">jtomko@redhat.com</a>&gt;<br>
---<br>
=C2=A0qga/main.c | 24 ++++++++++++++++++------<br>
=C2=A01 file changed, 18 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/qga/main.c b/qga/main.c<br>
index 68ea7f275a..35f061b5ea 100644<br>
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
@@ -1513,8 +1523,9 @@ static void cleanup_agent(GAState *s)<br>
<br>
=C2=A0static int run_agent_once(GAState *s)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 if (!channel_init(s, s-&gt;config-&gt;method, s-&gt;config-&=
gt;channel_path,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 s-&gt;socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {<br>
+=C2=A0 =C2=A0 if (!s-&gt;channel &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 channel_init(s, s-&gt;config-&gt;method, s-&gt=
;config-&gt;channel_path,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;socket_activation ? FIRST_SOCKET_ACTIVATION_FD : -1)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_critical(&quot;failed to initialize gue=
st agent channel&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return EXIT_FAILURE;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -1523,6 +1534,7 @@ static int run_agent_once(GAState *s)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (s-&gt;channel) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ga_channel_free(s-&gt;channel);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;channel =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0return EXIT_SUCCESS;<br>
-- <br>
2.45.2<br>
<br>
</blockquote></div>

--0000000000004e833f062f082bbe--


