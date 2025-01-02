Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B254E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 08:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTGXM-0003rC-KQ; Thu, 02 Jan 2025 03:26:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tTGXK-0003qu-0O
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 03:26:34 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tTGXH-00058a-1b
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 03:26:33 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29fae583cc8so5825407fac.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 00:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1735806388; x=1736411188;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=H+Y4ZPttg6EmS4h0dhKgqSmWyCOjDHVJON7G3N15hdo=;
 b=RDPYm6Fwu4lr1Nw1SzNmvM6DHsf8k2KnFi7bYy39jMEpWmTwrd55xQk/oUxvzNz4qU
 sH077HBupRcs9GYXa8Q5DlgEXW5M8XfPCRGaLWJPGplQ0BYh9jZV2n3TomLPatAPqNZX
 bvjh1q1F+XAmuioQpwTPLeqeZoyA8CEMzKuOrGRWWKrEWHSUnuFAuzC36YrHrebgxfRM
 PsNOCJ6ALrW2WoR+vfMqevw5kcsrL1jwba+45JSjs4V4ADYF2bLlLZpZhd1D8m5h7rBS
 MxuiSYeiAYwn710MkriW6Yt4P/cHZiGIDf2vBoZ8PK/jbRSgDPtmV0fveqfDMW9b0bpY
 adHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735806388; x=1736411188;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H+Y4ZPttg6EmS4h0dhKgqSmWyCOjDHVJON7G3N15hdo=;
 b=tcz6Diz4NOvQ8ywRVVBQ07aO6ff6wlfe4AIaz86BFf0Vh5mnQT9SNoz/H7aDvSDtTD
 LvX02zF+AsOWvcdS3bffRaXrI3mIUqzRxOJZXexO4ZzQQ/G3tmparAgxSjfqdnv12SYX
 0ybrlf8ywMYshS9lavxm2VkKlxSzyLK+eJP3+dJz9+iWyhAzdkvzCOuysBiW5B7CaxAx
 gPnvGxyxGIlZfwTE9inhGqfpEwYWOhc81U1d80vVilsl1JRY0guH5/09ZOA29z55aix9
 huG2hq01LVyU4sgEJwb1WTqooouYjTm6ISNaUjnaQqBDMt4eTPdVMewx2mqJ0oJnhjjf
 fSMQ==
X-Gm-Message-State: AOJu0YwQ2z35jtafU/zmJljeMpDe8ouDkiiCVqCNh4QgdR8fHtVGY63q
 SrweVn8RPR9tOZXccSHCb6UnZSYZSKGDIbKkNcegsbzOyxmpCj3XZokNO7AY9mQsoHxkx/FVAge
 3LpKgA5aLwPokBL6xf0eWwrmVGFFdGXvjgyCRWhCaxqz/cxMXRuueLA==
X-Gm-Gg: ASbGncv83tJiUaDUrUU/GeD/e+ZE5gw5JzqfR4JNsJUmEZso0yHnbabP4cCSp2Mtj5i
 9vxMq5CEQ0Peuenefh+ohcnrnwQ8MMiqwq3LOh80=
X-Google-Smtp-Source: AGHT+IHEHuqAZAziS/LBuIRnM0fza31Bv/nO7eAYVLQZP+vjw5XiVwUYNr0/gpCpo5uVYZYVcXoAiYlo93OFxOvGUj0=
X-Received: by 2002:a05:6871:d308:b0:29e:37af:a943 with SMTP id
 586e51a60fabf-2a7fcd3b648mr24654736fac.18.1735806387828; Thu, 02 Jan 2025
 00:26:27 -0800 (PST)
MIME-Version: 1.0
References: <155c8974fd72403b9b32d3e2827850b7f08937f3.1734695085.git.yong.huang@smartx.com>
 <f5d20cd31c44281a5ec29f8b263ba8c8624b2445.1734695085.git.yong.huang@smartx.com>
In-Reply-To: <f5d20cd31c44281a5ec29f8b263ba8c8624b2445.1734695085.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 2 Jan 2025 16:26:12 +0800
Message-ID: <CAK9dgmaa9Pk=bFWV_9sZ5rDvshA04Kvu1n0apWsScbRY=_7y2g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] qxl: Fix race on accessing cursor in struct
 SimpleSpiceDisplay
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000025539b062ab4eb02"
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

--00000000000025539b062ab4eb02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

- Ping

On Fri, Dec 20, 2024 at 7:46=E2=80=AFPM Hyman Huang <yong.huang@smartx.com>=
 wrote:

> Both the spice server and the qemu (iothread/main loop) context
> can access the cursor field in struct SimpleSpiceDisplay.
>
> Add the mutex lock before accessing cursor in
> qxl_spice_reset_cursor().
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>  hw/display/qxl.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/qxl.c b/hw/display/qxl.c
> index ae2d983299..07e171cb5d 100644
> --- a/hw/display/qxl.c
> +++ b/hw/display/qxl.c
> @@ -28,6 +28,7 @@
>  #include "qemu/atomic.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
> +#include "qemu/lockable.h"
>  #include "hw/qdev-properties.h"
>  #include "sysemu/runstate.h"
>  #include "migration/vmstate.h"
> @@ -298,10 +299,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)
>      qemu_mutex_lock(&qxl->track_lock);
>      qxl->guest_cursor =3D 0;
>      qemu_mutex_unlock(&qxl->track_lock);
> -    if (qxl->ssd.cursor) {
> -        cursor_unref(qxl->ssd.cursor);
> +    WITH_QEMU_LOCK_GUARD(&qxl->ssd.lock) {
> +        if (qxl->ssd.cursor) {
> +            cursor_unref(qxl->ssd.cursor);
> +        }
> +        qxl->ssd.cursor =3D cursor_builtin_hidden();
>      }
> -    qxl->ssd.cursor =3D cursor_builtin_hidden();
>  }
>
>  static uint32_t qxl_crc32(const uint8_t *p, unsigned len)
> --
> 2.39.1
>
>

--=20
Best regards

--00000000000025539b062ab4eb02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:comic sa=
ns ms,sans-serif">- Ping</div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Dec 20, 2024 at=
 7:46=E2=80=AFPM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com">y=
ong.huang@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-sty=
le:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Both the spic=
e server and the qemu (iothread/main loop) context<br>
can access the cursor field in struct SimpleSpiceDisplay.<br>
<br>
Add the mutex lock before accessing cursor in<br>
qxl_spice_reset_cursor().<br>
<br>
Signed-off-by: Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" tar=
get=3D"_blank">yong.huang@smartx.com</a>&gt;<br>
---<br>
=C2=A0hw/display/qxl.c | 9 ++++++---<br>
=C2=A01 file changed, 6 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/display/qxl.c b/hw/display/qxl.c<br>
index ae2d983299..07e171cb5d 100644<br>
--- a/hw/display/qxl.c<br>
+++ b/hw/display/qxl.c<br>
@@ -28,6 +28,7 @@<br>
=C2=A0#include &quot;qemu/atomic.h&quot;<br>
=C2=A0#include &quot;qemu/main-loop.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/lockable.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
=C2=A0#include &quot;sysemu/runstate.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
@@ -298,10 +299,12 @@ void qxl_spice_reset_cursor(PCIQXLDevice *qxl)<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_lock(&amp;qxl-&gt;track_lock);<br>
=C2=A0 =C2=A0 =C2=A0qxl-&gt;guest_cursor =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0qemu_mutex_unlock(&amp;qxl-&gt;track_lock);<br>
-=C2=A0 =C2=A0 if (qxl-&gt;ssd.cursor) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor_unref(qxl-&gt;ssd.cursor);<br>
+=C2=A0 =C2=A0 WITH_QEMU_LOCK_GUARD(&amp;qxl-&gt;ssd.lock) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qxl-&gt;ssd.cursor) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cursor_unref(qxl-&gt;ssd.cursor)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qxl-&gt;ssd.cursor =3D cursor_builtin_hidden()=
;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 qxl-&gt;ssd.cursor =3D cursor_builtin_hidden();<br>
=C2=A0}<br>
<br>
=C2=A0static uint32_t qxl_crc32(const uint8_t *p, unsigned len)<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div>

--00000000000025539b062ab4eb02--

