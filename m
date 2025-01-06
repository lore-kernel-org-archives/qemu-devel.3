Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0FE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 09:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUja6-0002Lr-FO; Mon, 06 Jan 2025 04:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUja4-0002Ld-RP
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:39:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUja2-0001Rs-Vh
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 04:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736156366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j9Lahhyn8/w9w4Gx8V31EP67wte2cQjSucqnu/S1daw=;
 b=LPrMTugcIt1d0eK6myVHDZ2UqRuNt8H/j+cmAwX+Qi5x5HZqiaGhI9+JTLgO6ldCPJWJuF
 ILJmRCtoJ9dci4u2cxV0H5MDOk0FnSeydDw2XO7wVjqIJAtjOvbbe2dI1rA2L7FdBFxqQZ
 zurE5/IqE6RP7ZOvbDN9oxexdcBxHQ0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-YykBGIWyM_ecr3hScSlN5w-1; Mon, 06 Jan 2025 04:39:23 -0500
X-MC-Unique: YykBGIWyM_ecr3hScSlN5w-1
X-Mimecast-MFC-AGG-ID: YykBGIWyM_ecr3hScSlN5w
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d92efa9ff4so232045326d6.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 01:39:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736156362; x=1736761162;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j9Lahhyn8/w9w4Gx8V31EP67wte2cQjSucqnu/S1daw=;
 b=EIQjCd6Qak9gNpWpi4JVzc9MNxusGj52ANN1myGKYy0vdSmsdskgMFW9g2l3mznLln
 /8qxE8gDPb3VVxDxRdZT7t3Lovzne01YpJjNR9v/4HpdxnZg1kfmKCwudpUel6nWFClV
 7/4unqLXTVicuhJWPiL4YiZnEgfd57ixEXfBuiGHxDi5Mt5W9t5oue4/pLjeryGRz097
 9i2FTcMX6caL+1NmXSizlBiV90WdInNJXsO36mqNKZOr/c5dORL9qk5RgZYCxARgzjq2
 KBbG1lHPVEAwjnJ72bzIupUD5qpJPVnN1vUwTqa4HTKg5sRJV9zAVllA1jEx3VRla2vC
 O9Iw==
X-Gm-Message-State: AOJu0YzyNZFs+WYzQ+kYBKIJdkuhQhM4z4BTFdRug6xNqvSGG46DF+pd
 HuSq55GgjMa0oEYaVhmoXsnbQqeAp5k3Z5N2PUncbOiOYYq++0DopYqQpRElfgBX+279EpiKALD
 /9yRHcD/2OUMOv4YzbVFkT9nIw+kUPXRpIM+ZOdyfxT0Dtpqcx83x1V06G0sZJbeUIsv/rYIRgO
 No4CLYOVKDJOasiHfC4gL181vfPDginFlzHkH0Jw==
X-Gm-Gg: ASbGncv8lauDdGrUg9oBDVVxIh9LBEK1rDr9HUFIRZi56qPCTsqUJ1UF+/jRr/nem2N
 a4FVywF4C+w6PIwXqqtMCqhSBxC7l/6nHfctduwO4
X-Received: by 2002:a05:6214:767:b0:6d8:96a6:ec22 with SMTP id
 6a1803df08f44-6dd2335741dmr1005040946d6.23.1736156362662; 
 Mon, 06 Jan 2025 01:39:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiSR3VIry3XdTycXOdye54SlHk2YerLZe4eGWrFlPw3j/u2nTwQdbgv2uOsyH3ItWWxHfWEzmxKP6Y4ZQqB/4=
X-Received: by 2002:a05:6214:767:b0:6d8:96a6:ec22 with SMTP id
 6a1803df08f44-6dd2335741dmr1005040806d6.23.1736156362444; Mon, 06 Jan 2025
 01:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20241225083744.277374-1-demeng@redhat.com>
In-Reply-To: <20241225083744.277374-1-demeng@redhat.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Mon, 6 Jan 2025 11:39:11 +0200
Message-ID: <CAPMcbCpWoi1cg4Z792GMY3NSjSZTd=86qGM_7GVSKhsUDs3ngw@mail.gmail.com>
Subject: Re: [PATCH] qemu-ga: Optimize freeze-hook script logic of logging
 error
To: Dehan Meng <demeng@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000422612062b066768"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000422612062b066768
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>

On Wed, Dec 25, 2024 at 10:37=E2=80=AFAM Dehan Meng <demeng@redhat.com> wro=
te:

> Make sure the error log of fsfreeze hooks
> when freeze/thaw/snapshot could be logged
> to system logs if the default logfile of
> qga can't be written or other situations
>
> Signed-off-by: Dehan Meng <demeng@redhat.com>
> ---
>  scripts/qemu-guest-agent/fsfreeze-hook | 36 +++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/qemu-guest-agent/fsfreeze-hook
> b/scripts/qemu-guest-agent/fsfreeze-hook
> index 13aafd4845..c1feb6f5ce 100755
> --- a/scripts/qemu-guest-agent/fsfreeze-hook
> +++ b/scripts/qemu-guest-agent/fsfreeze-hook
> @@ -19,15 +19,43 @@ is_ignored_file() {
>      return 1
>  }
>
> +USE_SYSLOG=3D0
> +# if log file is not writable, fallback to syslog
> +[ ! -w "$LOGFILE" ] && USE_SYSLOG=3D1
> +# try to update log file and fallback to syslog if it fails
> +touch "$LOGFILE" &>/dev/null || USE_SYSLOG=3D1
> +
> +# Ensure the log file is writable, fallback to syslog if not
> +log_message() {
> +    local message=3D"$1"
> +    if [ "$USE_SYSLOG" -eq 0 ]; then
> +        printf "%s: %s\n" "$(date)" "$message" >>"$LOGFILE"
> +    else
> +        logger -t qemu-ga-freeze-hook "$message"
> +    fi
> +}
> +
>  # Iterate executables in directory "fsfreeze-hook.d" with the specified
> args
>  [ ! -d "$FSFREEZE_D" ] && exit 0
> +
>  for file in "$FSFREEZE_D"/* ; do
>      is_ignored_file "$file" && continue
>      [ -x "$file" ] || continue
> -    printf "$(date): execute $file $@\n" >>$LOGFILE
> -    "$file" "$@" >>$LOGFILE 2>&1
> -    STATUS=3D$?
> -    printf "$(date): $file finished with status=3D$STATUS\n" >>$LOGFILE
> +
> +    log_message "Executing $file $@"
> +    if [ "$USE_SYSLOG" -eq 0 ]; then
> +        "$file" "$@" >>"$LOGFILE" 2>&1
> +        STATUS=3D$?
> +    else
> +        "$file" "$@" 2>&1 | logger -t qemu-ga-freeze-hook
> +        STATUS=3D${PIPESTATUS[0]}
> +    fi
> +
> +    if [ $STATUS -ne 0 ]; then
> +        log_message "Error: $file finished with status=3D$STATUS"
> +    else
> +        log_message "$file finished successfully"
> +    fi
>  done
>
>  exit 0
> --
> 2.40.1
>
>

--000000000000422612062b066768
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Konstantin Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Wed, Dec 25, 2024 at 10:37=E2=80=AFAM Dehan Meng &lt;<a href=3D=
"mailto:demeng@redhat.com">demeng@redhat.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Make sure the error log of fsfr=
eeze hooks<br>
when freeze/thaw/snapshot could be logged<br>
to system logs if the default logfile of<br>
qga can&#39;t be written or other situations<br>
<br>
Signed-off-by: Dehan Meng &lt;<a href=3D"mailto:demeng@redhat.com" target=
=3D"_blank">demeng@redhat.com</a>&gt;<br>
---<br>
=C2=A0scripts/qemu-guest-agent/fsfreeze-hook | 36 +++++++++++++++++++++++--=
-<br>
=C2=A01 file changed, 32 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/scripts/qemu-guest-agent/fsfreeze-hook b/scripts/qemu-guest-ag=
ent/fsfreeze-hook<br>
index 13aafd4845..c1feb6f5ce 100755<br>
--- a/scripts/qemu-guest-agent/fsfreeze-hook<br>
+++ b/scripts/qemu-guest-agent/fsfreeze-hook<br>
@@ -19,15 +19,43 @@ is_ignored_file() {<br>
=C2=A0 =C2=A0 =C2=A0return 1<br>
=C2=A0}<br>
<br>
+USE_SYSLOG=3D0<br>
+# if log file is not writable, fallback to syslog<br>
+[ ! -w &quot;$LOGFILE&quot; ] &amp;&amp; USE_SYSLOG=3D1<br>
+# try to update log file and fallback to syslog if it fails<br>
+touch &quot;$LOGFILE&quot; &amp;&gt;/dev/null || USE_SYSLOG=3D1<br>
+<br>
+# Ensure the log file is writable, fallback to syslog if not<br>
+log_message() {<br>
+=C2=A0 =C2=A0 local message=3D&quot;$1&quot;<br>
+=C2=A0 =C2=A0 if [ &quot;$USE_SYSLOG&quot; -eq 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &quot;%s: %s\n&quot; &quot;$(date)&quot=
; &quot;$message&quot; &gt;&gt;&quot;$LOGFILE&quot;<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 logger -t qemu-ga-freeze-hook &quot;$message&q=
uot;<br>
+=C2=A0 =C2=A0 fi<br>
+}<br>
+<br>
=C2=A0# Iterate executables in directory &quot;fsfreeze-hook.d&quot; with t=
he specified args<br>
=C2=A0[ ! -d &quot;$FSFREEZE_D&quot; ] &amp;&amp; exit 0<br>
+<br>
=C2=A0for file in &quot;$FSFREEZE_D&quot;/* ; do<br>
=C2=A0 =C2=A0 =C2=A0is_ignored_file &quot;$file&quot; &amp;&amp; continue<b=
r>
=C2=A0 =C2=A0 =C2=A0[ -x &quot;$file&quot; ] || continue<br>
-=C2=A0 =C2=A0 printf &quot;$(date): execute $file $@\n&quot; &gt;&gt;$LOGF=
ILE<br>
-=C2=A0 =C2=A0 &quot;$file&quot; &quot;$@&quot; &gt;&gt;$LOGFILE 2&gt;&amp;=
1<br>
-=C2=A0 =C2=A0 STATUS=3D$?<br>
-=C2=A0 =C2=A0 printf &quot;$(date): $file finished with status=3D$STATUS\n=
&quot; &gt;&gt;$LOGFILE<br>
+<br>
+=C2=A0 =C2=A0 log_message &quot;Executing $file $@&quot;<br>
+=C2=A0 =C2=A0 if [ &quot;$USE_SYSLOG&quot; -eq 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$file&quot; &quot;$@&quot; &gt;&gt;&quot=
;$LOGFILE&quot; 2&gt;&amp;1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 STATUS=3D$?<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;$file&quot; &quot;$@&quot; 2&gt;&amp;1 |=
 logger -t qemu-ga-freeze-hook<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 STATUS=3D${PIPESTATUS[0]}<br>
+=C2=A0 =C2=A0 fi<br>
+<br>
+=C2=A0 =C2=A0 if [ $STATUS -ne 0 ]; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_message &quot;Error: $file finished with s=
tatus=3D$STATUS&quot;<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 log_message &quot;$file finished successfully&=
quot;<br>
+=C2=A0 =C2=A0 fi<br>
=C2=A0done<br>
<br>
=C2=A0exit 0<br>
-- <br>
2.40.1<br>
<br>
</blockquote></div>

--000000000000422612062b066768--


