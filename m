Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6ACC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 18:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJe2p-0007tT-28; Tue, 18 Jun 2024 14:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1sJe2n-0007sw-Cc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 14:59:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1sJe2l-0003Pk-G7
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 14:59:01 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7023b6d810bso4302236b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718737138; x=1719341938; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QAh+yTq26Zie4QBv0DzRJduQf49fUonZRJwH9J7HPMo=;
 b=Hf7TQc1P4ujLkT9lB/Oc07RAQijKXQTmGGWtq0qgeSQyTQ/7ZYgqj4avoyhk0xkXU+
 I8dEFzq9cuPcmY0QJQh28ZWu10swYCOSwNtAqBDqcNBCZShZotxHpaA4VEAMo6yLfMol
 vcGdrvmEFHhGLkEcBr0p6wxkSufPbUvjkWUD8kEoWCUX8F5GXVYlVLbf/We2wmPDyCGU
 9MKZ737TBU4Yb2GGyc1Gyf9FLjWTnDAIBNgl6ii2XkGt/lDb/PCoD0nW3TzqRWnqdrJm
 TUt1dzBxZWFUrMZbMnLi80d7eCjt3hXsICFZLFLSSZUfYZy5bDzKD9nSG3qYeGgPHJoK
 K33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718737138; x=1719341938;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QAh+yTq26Zie4QBv0DzRJduQf49fUonZRJwH9J7HPMo=;
 b=Bd4+ixd2nS/bKDCVexPtl/gIA8YxADIV8aXWJYUAN6azBNszQ3ty8uLBCFN1tX9EIV
 6y69EkWGpN0vQuuK5YKxRz+L1tgKQXZAXwwYiw/ljD91BSLOw8s++71lZ4+G9U1URw+w
 DrRuj09y0ZyAdr3nqKHGvQa/EcR2eHHGg81fgBTsjGQ16HXM2SQWVv/xgB0GjiTX1cep
 ELqLXhHEb1uehXhBDNYjAHxdAj8edSsBbXd0IeawmJQX+EorLB3hG5fVhmoHjB3ZJYRm
 MXTgUn3Rvkj3DQ+sHo0Di85jvD+6Q3zcIolZz5UChaAZMDJmZYgkgVVEc/J3xaZC5DZU
 5d0A==
X-Gm-Message-State: AOJu0YzOvxvefvIARr7YXYPnz4i9R7LaedBjYKOWDoF3mLeuQXYvOoJJ
 akHedBiYqo6yy8MX8puAO3w64FgXkah8tLvFgBGnt+f7QdsWYHfAiVIfGzLxczU8NarXIlL3XSp
 8H3yNG3k5tFfNPQX9Q8CRC89EhmM=
X-Google-Smtp-Source: AGHT+IF9tikkJxUDJSvFld1Ot4XdKQxG5+EJ8cnPlg7kyE4Ct+b+zRMluJxXQmz4swy8TA7O54QAY53p2aUR1r8/v1o=
X-Received: by 2002:a05:6a00:681a:b0:705:c0a1:61d8 with SMTP id
 d2e1a72fcca58-70629c21520mr528702b3a.4.1718737137753; Tue, 18 Jun 2024
 11:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240618135610.3109175-1-zheyuma97@gmail.com>
In-Reply-To: <20240618135610.3109175-1-zheyuma97@gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Tue, 18 Jun 2024 11:58:30 -0700
Message-ID: <CADBGO7_XF5REzENPGupwMB-EOHXS78SG5v=yZ6TRZ_7yVgWUtg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: Handle invalid address access in read
 and write functions
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008ee596061b2eac6d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pauldzim@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008ee596061b2eac6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:56=E2=80=AFAM Zheyu Ma <zheyuma97@gmail.com> wrot=
e:
>
> This commit modifies the dwc2_hsotg_read() and dwc2_hsotg_write()
functions
> to handle invalid address access gracefully. Instead of using
> g_assert_not_reached(), which causes the program to abort, the functions
> now log an error message and return a default value for reads or do
> nothing for writes.
>
> This change prevents the program from aborting and provides clear log
> messages indicating when an invalid memory address is accessed.
>
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display none \
> -machine accel=3Dqtest, -m 512M -machine raspi2b -m 1G -nodefaults \
> -usb -drive file=3Dnull-co://,if=3Dnone,format=3Draw,id=3Ddisk0 -device \
> usb-storage,port=3D1,drive=3Ddisk0 -qtest stdio
> readl 0x3f980dfb
> EOF
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  hw/usb/hcd-dwc2.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index 8cac9c0a06..b4f0652c7d 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *ptr, hwaddr
addr, unsigned size)
>          val =3D dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe00)) >>
2, size);
>          break;
>      default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
0x%"HWADDR_PRIx"\n",
> +                      __func__, addr);
> +        val =3D 0;
> +        break;
>      }
>
>      return val;
> @@ -1160,7 +1163,9 @@ static void dwc2_hsotg_write(void *ptr, hwaddr
addr, uint64_t val,
>          dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) >> 2,
val, size);
>          break;
>      default:
> -        g_assert_not_reached();
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset
0x%"HWADDR_PRIx"\n",
> +                      __func__, addr);
> +        break;
>      }
>  }
>
> --
> 2.34.1

Looks good to me.

Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>

--0000000000008ee596061b2eac6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><font face=3D"monospace">On Tue, Jun 18, 2024 at 6:56=E2=
=80=AFAM Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com">zheyuma97@gmai=
l.com</a>&gt; wrote:<br>&gt;<br>&gt; This commit modifies the dwc2_hsotg_re=
ad() and dwc2_hsotg_write() functions<br>&gt; to handle invalid address acc=
ess gracefully. Instead of using<br>&gt; g_assert_not_reached(), which caus=
es the program to abort, the functions<br>&gt; now log an error message and=
 return a default value for reads or do<br>&gt; nothing for writes.<br>&gt;=
<br>&gt; This change prevents the program from aborting and provides clear =
log<br>&gt; messages indicating when an invalid memory address is accessed.=
<br>&gt;<br>&gt; Reproducer:<br>&gt; cat &lt;&lt; EOF | qemu-system-aarch64=
 -display none \<br>&gt; -machine accel=3Dqtest, -m 512M -machine raspi2b -=
m 1G -nodefaults \<br>&gt; -usb -drive file=3Dnull-co://,if=3Dnone,format=
=3Draw,id=3Ddisk0 -device \<br>&gt; usb-storage,port=3D1,drive=3Ddisk0 -qte=
st stdio<br>&gt; readl 0x3f980dfb<br>&gt; EOF<br>&gt;<br>&gt; Signed-off-by=
: Zheyu Ma &lt;<a href=3D"mailto:zheyuma97@gmail.com">zheyuma97@gmail.com</=
a>&gt;<br>&gt; ---<br>&gt; =C2=A0hw/usb/hcd-dwc2.c | 9 +++++++--<br>&gt; =
=C2=A01 file changed, 7 insertions(+), 2 deletions(-)<br>&gt;<br>&gt; diff =
--git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c<br>&gt; index 8cac9c0a06..b4f=
0652c7d 100644<br>&gt; --- a/hw/usb/hcd-dwc2.c<br>&gt; +++ b/hw/usb/hcd-dwc=
2.c<br>&gt; @@ -1128,7 +1128,10 @@ static uint64_t dwc2_hsotg_read(void *pt=
r, hwaddr addr, unsigned size)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0va=
l =3D dwc2_pcgreg_read(ptr, addr, (addr - HSOTG_REG(0xe00)) &gt;&gt; 2, siz=
e);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>&gt; =C2=A0 =C2=A0 =
=C2=A0default:<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();=
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR, &quot;=
%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>&gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__func__, add=
r);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D 0;<br>&gt; + =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>&gt; =C2=A0 =C2=A0 =C2=A0}<br>&gt;<br>&gt; =C2=A0 =
=C2=A0 =C2=A0return val;<br>&gt; @@ -1160,7 +1163,9 @@ static void dwc2_hso=
tg_write(void *ptr, hwaddr addr, uint64_t val,<br>&gt; =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0dwc2_pcgreg_write(ptr, addr, (addr - HSOTG_REG(0xe00)) &gt;&g=
t; 2, val, size);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>&gt; =
=C2=A0 =C2=A0 =C2=A0default:<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_=
not_reached();<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST=
_ERROR, &quot;%s: Bad offset 0x%&quot;HWADDR_PRIx&quot;\n&quot;,<br>&gt; + =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0__func__, addr);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>&gt; =C2=
=A0 =C2=A0 =C2=A0}<br>&gt; =C2=A0}<br>&gt;<br>&gt; --<br>&gt; 2.34.1<br><br=
></font><div><font face=3D"monospace">Looks good to me.</font></div><div><f=
ont face=3D"monospace"><br></font></div><div><font face=3D"monospace">Revie=
wed-by: Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com">pauldzim@g=
mail.com</a>&gt;</font></div><div><br></div></div>

--0000000000008ee596061b2eac6d--

