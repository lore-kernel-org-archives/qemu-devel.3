Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BD9C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MQe-00054V-9i; Fri, 10 May 2024 05:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s5MQS-00052n-38
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s5MQP-0001Cg-Vg
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715332819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMsT+bIrXtgcL6SXjD9Dpnx0OqUe5rSLDxu/TF05m8U=;
 b=E17EJKwJbXkH1WCW26qiUL9X3DmPl3r+xISmJ7QV3VyGHeon9BWGHGrTLdc/FVIJni7zIB
 ZMpRiUATxUgF0CzbtKNw1aYMWocysn4IZe1DkJ8ANjG7W0pqymk3oQgxiAHQZvLCWcYqF6
 KGcoVos4Jh+9795IyNtk1nwUZ0ZzHa0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-6dd8QDENNumj5ELNiqCB2g-1; Fri, 10 May 2024 05:19:18 -0400
X-MC-Unique: 6dd8QDENNumj5ELNiqCB2g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-349cafdc8f0so925556f8f.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715332756; x=1715937556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QMsT+bIrXtgcL6SXjD9Dpnx0OqUe5rSLDxu/TF05m8U=;
 b=RK6BHlLmlQsTOfZv+ma5JOE/UxYrfykOLDOMx3bLRBwzloJps0WmWVJCqawVgrD//3
 rs8ix3Qq0dscSGgwecq2NiXZMI0ohmU0QP32BI9dVY1wXqttkFeaBby067ozc9zkzoOS
 qSCFrIZLLI/uXKG+cHS1iDXHNwqqjqHh2sjA4/+iU+wS8w/3RL/JvtUCetjW3f4I98AZ
 en0/XL/xS9PFxi7ZUuOuWXvKJQKkXmT4Sh9hAOx4X0/bHTj39ElkD0iNmAZbNwLsFuFL
 xmplfBv/J1K5rQqbjD6eMKhQTmDETDnpHntVJGrGGatVU/kRjsxVe3ciCKRBMQbfZlFL
 wTIg==
X-Gm-Message-State: AOJu0YyeGGyDzXNCcLExBjMd6m6A6kaHTgE/smsZgipWL353aNkkB34D
 Mr6dCe4PD/05VFQ6lSl35LkOJEQ1b1YtEbnWzqSWY++t8UXDTvYZ7cOruOnW8R1RKiOi5ddYapZ
 iAxPW9XK4uqOrAVvI/iKyRFZYnnKksFur1vDuWpduIWlT09xBUONRdVkR0IH302tsYKIdTFsyM/
 nJDaXG4oZ0+WqmIEpzxBnPXl6SqdlIhYbmaRANnw==
X-Received: by 2002:a5d:4050:0:b0:34f:3293:83d9 with SMTP id
 ffacd0b85a97d-3504aa6321fmr1768648f8f.57.1715332756671; 
 Fri, 10 May 2024 02:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+XaDshGn4UYGkWVUFH5tyWszTl7KW2UxFqDcf/+zgR1Z7drlt/gDsKl4/jdFZpwOKhe59MWYKkjfSUBPpaJY=
X-Received: by 2002:a5d:4050:0:b0:34f:3293:83d9 with SMTP id
 ffacd0b85a97d-3504aa6321fmr1768631f8f.57.1715332756327; Fri, 10 May 2024
 02:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-4-pbonzini@redhat.com>
 <549e6861-b868-43d3-be7c-d99981fd6aa7@redhat.com>
In-Reply-To: <549e6861-b868-43d3-be7c-d99981fd6aa7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 May 2024 11:19:00 +0200
Message-ID: <CABgObfYn8Sx_cDap33eMEQj2+MLk0_T2a2=7SXrqh_djTXewzw@mail.gmail.com>
Subject: Re: [PATCH 03/13] s390: move css_migration_enabled from machine to
 css.c
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009ceccf0618160796"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--0000000000009ceccf0618160796
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 7:38=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
> I think this is wrong: By adding this to ccw_machine_2_9_class_options th=
e
> variable now always gets set to false, even for newer machines, since the
> *class_options functions are part of the "class_init" which is always
done.
> You have to add it to ccw_machine_2_9_instance_options() instead to make
it
> work as expected.

Indeed, this has to be squashed in:

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index aa90703d518..b7ddd36b8ba 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1159,6 +1159,7 @@ static void
ccw_machine_2_9_instance_options(MachineState *machine)
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ZPCI);
     s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_INT_SUPPRESSION);
     s390_cpudef_featoff_greater(12, 1,
S390_FEAT_ADAPTER_EVENT_NOTIFICATION);
+    css_migration_enabled =3D false;
 }

 static void ccw_machine_2_9_class_options(MachineClass *mc)
@@ -1171,7 +1172,6 @@ static void
ccw_machine_2_9_class_options(MachineClass *mc)
     ccw_machine_2_10_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    css_migration_enabled =3D false;
 }
 DEFINE_CCW_MACHINE(2_9, "2.9", false);

--0000000000009ceccf0618160796
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif"><br><font siz=
e=3D"2"><br>On Fri, May 10, 2024 at 7:38=E2=80=AFAM Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt; I thin=
k this is wrong: By adding this to ccw_machine_2_9_class_options the<br>&gt=
; variable now always gets set to false, even for newer machines, since the=
<br>&gt; *class_options functions are part of the &quot;class_init&quot; wh=
ich is always done.<br>&gt; You have to add it to ccw_machine_2_9_instance_=
options() instead to make it<br></font></span><div><font size=3D"2"><span s=
tyle=3D"font-family:arial,sans-serif">&gt; work as expected.</span></font><=
/div><div><font size=3D"2"><span style=3D"font-family:arial,sans-serif"><br=
></span></font></div><div><div class=3D"gmail_default"><font size=3D"2"><sp=
an style=3D"font-family:arial,sans-serif">Indeed, this has to be squashed i=
n:<br></span></font></div><font size=3D"2"><span style=3D"font-family:arial=
,sans-serif"></span></font></div><br><span style=3D"font-family:monospace">=
<span class=3D"gmail_default" style=3D"font-family:monospace,monospace;font=
-size:x-small"></span>diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s3=
90-virtio-ccw.c<br>index aa90703d518..b7ddd36b8ba 100644<br>--- a/hw/s390x/=
s390-virtio-ccw.c<br>+++ b/hw/s390x/s390-virtio-ccw.c<br>@@ -1159,6 +1159,7=
 @@ static void ccw_machine_2_9_instance_options(MachineState *machine)<br>=
=C2=A0 =C2=A0 =C2=A0s390_cpudef_featoff_greater(12, 1, S390_FEAT_ZPCI);<br>=
=C2=A0 =C2=A0 =C2=A0s390_cpudef_featoff_greater(12, 1, S390_FEAT_ADAPTER_IN=
T_SUPPRESSION);<br>=C2=A0 =C2=A0 =C2=A0s390_cpudef_featoff_greater(12, 1, S=
390_FEAT_ADAPTER_EVENT_NOTIFICATION);<br>+ =C2=A0 =C2=A0css_migration_enabl=
ed =3D false;<br>=C2=A0}<br>=C2=A0<br>=C2=A0static void ccw_machine_2_9_cla=
ss_options(MachineClass *mc)<br>@@ -1171,7 +1172,6 @@ static void ccw_machi=
ne_2_9_class_options(MachineClass *mc)<br>=C2=A0 =C2=A0 =C2=A0ccw_machine_2=
_10_class_options(mc);<br>=C2=A0 =C2=A0 =C2=A0compat_props_add(mc-&gt;compa=
t_props, hw_compat_2_9, hw_compat_2_9_len);<br>=C2=A0 =C2=A0 =C2=A0compat_p=
rops_add(mc-&gt;compat_props, compat, G_N_ELEMENTS(compat));<br>- =C2=A0 =
=C2=A0css_migration_enabled =3D false;<br>=C2=A0}<br>=C2=A0DEFINE_CCW_MACHI=
NE(2_9, &quot;2.9&quot;, false);</span><br>=C2=A0<br></div>

--0000000000009ceccf0618160796--


