Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF9B5E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 16:41:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTOFX-0006gh-9n; Thu, 02 Jan 2025 11:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tTOFU-0006gO-RZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:40:40 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tTOFS-0006qg-9t
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 11:40:40 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5f31d3b4f8cso2723451eaf.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 08:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1735836036; x=1736440836;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=493mkm1pX9X72Ew70E0BmZM1WLY+xV8E4iQyDiVRPjA=;
 b=KnmzRbOLaO0xFiOpVIFW4H2f3fX6S83/qDs8yekiT+UeK43NR9Rb6xirND7sfTKcKi
 17+hPC2zpfnCtLZ/2Xna1OEwebzoLpw1JQy3wDxWOwyym2KBi1l+P/cEy0A4ZMaQqYv0
 XznaB864/I84JUler9ZolIbt3xqsTRrjRfPl+GjkIIyOeyzGFpufA7v2m/emKXBoWAR1
 oOy89C3DhE5mCuyijFqmkL5rdTIUD3KzSmOoQ2nUHAXdZSzBImE1lDv1YHrKGl1E0wau
 jqHHC6JR4///WTH6eYkh6lqPiiU4U0aO7mbGutfu1j8rHsd+jVQlUU+XyvrIi6+oqkWD
 2X7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735836036; x=1736440836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=493mkm1pX9X72Ew70E0BmZM1WLY+xV8E4iQyDiVRPjA=;
 b=MXYOVu3SXwoY3mF+ZWfNxfKfZLt4cDzK6VvHzOfbE6eFduZNjAZwGKN1X01konAkV4
 tNIRid301i4Sxsa9BnURrXhKO6DlvMUEFwUFqHBgABfkq9LAC4eyZb56x3UASoPrkGkf
 SH7t0FKR32MFYQw4mse/Tj606BGnXrwlyepbq9eTeezsrCDGzMOCZ9VzsWTzvgMjq7TD
 kg82sDUeR0gxHkshrFX/CuLFfPPAAXhXCWjZ06jdKe3XwuVtleB0MUen5S1kM94NU4x6
 Q2EFtyes3k4vYnvCW7F8jQRf28tRwTGzbX04fQv/JUAcY1pBgl+GTFG88uH9Te4Gi//g
 5QIg==
X-Gm-Message-State: AOJu0YzPECHCt0M7LIg37N+pZniN/lUqo5INWqeWhSLXOGrxg0plMtU7
 kgXT6a8MIphjetMRAbYwoARRtbQefv0FP9h7gBa/ywNdR0urvQmKvmLVVWk+JXoQdIAxKvs8gbe
 V2eZaoUBLwhr8pjSqBn0Ti/wn4KOGRgc8E7SKPw==
X-Gm-Gg: ASbGncvC5/o9l825DnjtLJl0s0JE11ywUaJ0raof5b19NmEraQPof0OFqpbTR9netzv
 hLcISsblUpu5vsiij9gA0dVs86ho3cGSVBqlmgPQ=
X-Google-Smtp-Source: AGHT+IFtN2unVMZ4QYYL6vOveRAv85FxOR+GDKlRoor1ff5nw5rA+3nPCb9HM+/nZto2Pr6Ypd3bKmKivR/ofD984C4=
X-Received: by 2002:a05:6871:6204:b0:29f:ed90:8d11 with SMTP id
 586e51a60fabf-2a7fb431b61mr24724230fac.29.1735836035677; Thu, 02 Jan 2025
 08:40:35 -0800 (PST)
MIME-Version: 1.0
References: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
 <1735610174-37467-2-git-send-email-fuqiang.wng@gmail.com>
In-Reply-To: <1735610174-37467-2-git-send-email-fuqiang.wng@gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 3 Jan 2025 00:40:18 +0800
Message-ID: <CAK9dgmZV4NCe3RrA-rKsAvsG2aXeoqKStXVO5Wrc7dXS19V8PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] optimize the dirtylimit_throttle_pct trace event
To: fuqiang wang <fuqiang.wng@gmail.com>
Cc: qemu-devel@nongnu.org, huaminxu1@jd.com, 
 wangfuqiang49 <wangfuqiang49@jd.com>
Content-Type: multipart/alternative; boundary="0000000000004b98bc062abbd2db"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=yong.huang@smartx.com; helo=mail-oo1-xc2b.google.com
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

--0000000000004b98bc062abbd2db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 9:56=E2=80=AFAM fuqiang wang <fuqiang.wng@gmail.com=
> wrote:

> The current dirtylimit_throttle_pct trace event is triggered when the
> throttle time is adjusted linearly. Modify the trace event so that it
> can record non-linear adjustments.


Please target the optimization mentioned above in a single patch.
.


> Additionally, since the throttle time
> might be adjusted again at the end of the dirtylimit_set_throttle
> function, move the trace event to after this process and calculate the
> final adjustment time and sleep percent.
>

If need, I'd advise dividing this into a different patch.


>
> This patch can fix the following issue:
>
> 1. The current dirty rate at 1000MB/s and the dirty limit value at
>    10000MB/s, before merge this patch, this trace event will print:
>
>      CPU[2] throttle percent: 98, throttle adjust time 191590 us
>      CPU[2] throttle percent: 98, throttle adjust time 191002 us
>      CPU[2] throttle percent: 98, throttle adjust time 191002 us
>
>    After merge this patch, there will be no print.
>
> 2. The current dirty rate is 1000MB/s and the dirty limit rate value is
>    333MB/s, before merge this patch, this trace event will print:
>
>      CPU[3] throttle percent: 98, throttle adjust time 32666634 us
>
>    It will only print linear adjustment, and the adjust time
>    will be larger and only have positive values.
>
>    After merge this patch, print as following:
>      CPU[2] throttle percent: 97, throttle adjust time 128766 us
>      CPU[2] throttle percent: 94, throttle adjust time -61131 us
>      CPU[2] throttle percent: 92, throttle adjust time -16634 us
>      ...
>      CPU[2] throttle percent: 74, throttle adjust time -390 us
>      CPU[2] throttle percent: 73, throttle adjust time -390 us
>
> Signed-off-by: wangfuqiang49 <wangfuqiang49@jd.com>
> ---
>  system/dirtylimit.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index 7c071248bb..c7f663e5b9 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -281,31 +281,30 @@ static void dirtylimit_set_throttle(CPUState *cpu,
>  {
>      int64_t ring_full_time_us =3D 0;
>      uint64_t sleep_pct =3D 0;
> +    uint64_t throttle_pct =3D 0;
>      uint64_t throttle_us =3D 0;
> +    int64_t throtlle_us_old =3D cpu->throttle_us_per_full;
>
>      if (current =3D=3D 0) {
>          cpu->throttle_us_per_full =3D 0;
> -        return;
> +        goto end;
>

The current dirty rate is zero, indicating nothing needs to be done,

including displaying the trace event. return directly seems justified.

>      }
>
>      ring_full_time_us =3D dirtylimit_dirty_ring_full_time(current);
>
>      if (dirtylimit_need_linear_adjustment(quota, current)) {
>          if (quota < current) {
> -            sleep_pct =3D (current - quota) * 100 / current;
>

s/sleep_pct/throttle_pci/ , why ?


> +            throttle_pct  =3D (current - quota) * 100 / current;
>              throttle_us =3D
> -                ring_full_time_us * sleep_pct / (double)(100 - sleep_pct=
);
> +                ring_full_time_us * throttle_pct / (double)(100 -
> throttle_pct);
>              cpu->throttle_us_per_full +=3D throttle_us;
>          } else {
> -            sleep_pct =3D (quota - current) * 100 / quota;
> +            throttle_pct =3D (quota - current) * 100 / quota;
>              throttle_us =3D
> -                ring_full_time_us * sleep_pct / (double)(100 - sleep_pct=
);
> +                ring_full_time_us * throttle_pct / (double)(100 -
> throttle_pct);
>              cpu->throttle_us_per_full -=3D throttle_us;
>          }
>
> -        trace_dirtylimit_throttle_pct(cpu->cpu_index,
> -                                      sleep_pct,
> -                                      throttle_us);
>      } else {
>          if (quota < current) {
>              cpu->throttle_us_per_full +=3D ring_full_time_us / 10;
> @@ -323,6 +322,19 @@ static void dirtylimit_set_throttle(CPUState *cpu,
>          ring_full_time_us * DIRTYLIMIT_THROTTLE_PCT_MAX);
>
>      cpu->throttle_us_per_full =3D MAX(cpu->throttle_us_per_full, 0);
> +
> +end:
> +    if (cpu->throttle_us_per_full - throtlle_us_old) {
> +        if (current) {
> +            sleep_pct =3D ring_full_time_us * 100 / (ring_full_time_us +
> +                    cpu->throttle_us_per_full);
> +        } else {
> +            sleep_pct =3D 0;
> +        }
> +        trace_dirtylimit_throttle_pct(cpu->cpu_index,
> +                                      sleep_pct,
> +                                      cpu->throttle_us_per_full -
> +                                      throtlle_us_old); }
>

This changes the interface of the trace event,  We can keep
the throttle_us and add the delta meanwhile:
trace_dirtylimit_throttle_pct(cpu->cpu_index,
                                                sleep_pct,
                                                throttle_us,
                                                cpu->throttle_us_per_full
- throtlle_us_old)

 }
>
>  static void dirtylimit_adjust_throttle(CPUState *cpu)
> --
> 2.47.0
>
>

--=20
Best regards

--0000000000004b98bc062abbd2db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Tue, Dec 31, 2024 at 9:56=E2=80=AFAM fuqiang wang &lt;<a href=3D"mai=
lto:fuqiang.wng@gmail.com">fuqiang.wng@gmail.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);pad=
ding-left:1ex">The current dirtylimit_throttle_pct trace event is triggered=
 when the<br>
throttle time is adjusted linearly. Modify the trace event so that it<br>
can record non-linear adjustments. </blockquote><div><br></div><div><div st=
yle=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_def=
ault">Please target the optimization mentioned above in a single patch.<br>=
</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=
=3D"gmail_default">.</div></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left=
-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Additiona=
lly, since the throttle time<br>
might be adjusted again at the end of the dirtylimit_set_throttle<br>
function, move the trace event to after this process and calculate the<br>
final adjustment time and sleep percent.<br></blockquote><div><br></div><di=
v><div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"=
gmail_default">If need, I&#39;d advise dividing this into a different patch=
.</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border=
-left-color:rgb(204,204,204);padding-left:1ex">
<br>
This patch can fix the following issue:<br>
<br>
1. The current dirty rate at 1000MB/s and the dirty limit value at<br>
=C2=A0 =C2=A010000MB/s, before merge this patch, this trace event will prin=
t:<br>
<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 98, throttle adjust time 19159=
0 us<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 98, throttle adjust time 19100=
2 us<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 98, throttle adjust time 19100=
2 us<br>
<br>
=C2=A0 =C2=A0After merge this patch, there will be no print.<br>
<br>
2. The current dirty rate is 1000MB/s and the dirty limit rate value is<br>
=C2=A0 =C2=A0333MB/s, before merge this patch, this trace event will print:=
<br>
<br>
=C2=A0 =C2=A0 =C2=A0CPU[3] throttle percent: 98, throttle adjust time 32666=
634 us<br>
<br>
=C2=A0 =C2=A0It will only print linear adjustment, and the adjust time<br>
=C2=A0 =C2=A0will be larger and only have positive values.<br>
<br>
=C2=A0 =C2=A0After merge this patch, print as following:<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 97, throttle adjust time 12876=
6 us<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 94, throttle adjust time -6113=
1 us<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 92, throttle adjust time -1663=
4 us<br>
=C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 74, throttle adjust time -390 =
us<br>
=C2=A0 =C2=A0 =C2=A0CPU[2] throttle percent: 73, throttle adjust time -390 =
us<br>
<br>
Signed-off-by: wangfuqiang49 &lt;<a href=3D"mailto:wangfuqiang49@jd.com" ta=
rget=3D"_blank">wangfuqiang49@jd.com</a>&gt;<br>
---<br>
=C2=A0system/dirtylimit.c | 28 ++++++++++++++++++++--------<br>
=C2=A01 file changed, 20 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/system/dirtylimit.c b/system/dirtylimit.c<br>
index 7c071248bb..c7f663e5b9 100644<br>
--- a/system/dirtylimit.c<br>
+++ b/system/dirtylimit.c<br>
@@ -281,31 +281,30 @@ static void dirtylimit_set_throttle(CPUState *cpu,<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t ring_full_time_us =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sleep_pct =3D 0;<br>
+=C2=A0 =C2=A0 uint64_t throttle_pct =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t throttle_us =3D 0;<br>
+=C2=A0 =C2=A0 int64_t throtlle_us_old =3D cpu-&gt;throttle_us_per_full;<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0if (current =3D=3D 0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_full =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto end;<br></blockquote><div><br></div><div =
class=3D"gmail_default"><p style=3D"color:rgb(0,0,0)"><font face=3D"comic s=
ans ms, sans-serif">The current dirty rate=C2=A0is zero, indicating nothing=
 needs to be done,</font></p><p style=3D"color:rgb(0,0,0)"><font face=3D"co=
mic sans ms, sans-serif">including displaying the trace event. return direc=
tly seems justified.</font></p></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid=
;border-left-color:rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0ring_full_time_us =3D dirtylimit_dirty_ring_full_time(c=
urrent);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (dirtylimit_need_linear_adjustment(quota, current)) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (quota &lt; current) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_pct =3D (current - quota) =
* 100 / current;<br></blockquote><div><br></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">s/sleep_p=
ct/throttle_pci/ , why ?</div></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_pct=C2=A0 =3D (current =
- quota) * 100 / current;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throttle_us =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* sleep_pct / (double)(100 - sleep_pct);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* throttle_pct / (double)(100 - throttle_pct);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_ful=
l +=3D throttle_us;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_pct =3D (quota - current) =
* 100 / quota;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_pct =3D (quota - curren=
t) * 100 / quota;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throttle_us =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* sleep_pct / (double)(100 - sleep_pct);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* throttle_pct / (double)(100 - throttle_pct);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_ful=
l -=3D throttle_us;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_dirtylimit_throttle_pct(cpu-&gt;cpu_inde=
x,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_pct,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_us);<b=
r>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (quota &lt; current) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_ful=
l +=3D ring_full_time_us / 10;<br>
@@ -323,6 +322,19 @@ static void dirtylimit_set_throttle(CPUState *cpu,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring_full_time_us * DIRTYLIMIT_THROTTLE_P=
CT_MAX);<br>
<br>
=C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_full =3D MAX(cpu-&gt;throttle_u=
s_per_full, 0);<br>
+<br>
+end:<br>
+=C2=A0 =C2=A0 if (cpu-&gt;throttle_us_per_full - throtlle_us_old) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (current) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_pct =3D ring_full_time_us =
* 100 / (ring_full_time_us +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-=
&gt;throttle_us_per_full);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_pct =3D 0;<span class=3D"g=
mail_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"> =
=C2=A0</span><br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_dirtylimit_throttle_pct(cpu-&gt;cpu_inde=
x,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_pct,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;throttl=
e_us_per_full -<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throtlle_us_old=
); }<br></blockquote><div style=3D"font-family:&quot;comic sans ms&quot;,sa=
ns-serif" class=3D"gmail_default"><br></div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif" class=3D"gmail_default">This changes the i=
nterface of the trace event, =C2=A0We can keep</div><div class=3D"gmail_def=
ault"><font face=3D"comic sans ms, sans-serif">the throttle_us and add the =
delta meanwhile:</font></div><div class=3D"gmail_default"><font face=3D"com=
ic sans ms, sans-serif">trace_dirtylimit_throttle_pct(cpu-&gt;cpu_index,=C2=
=A0</font></div><div class=3D"gmail_default"><font face=3D"comic sans ms, s=
ans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sleep_pct,</font></div><div class=3D"gmail_=
default"><font face=3D"comic sans ms, sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throt=
tle_us,</font></div><div class=3D"gmail_default"><font face=3D"comic sans m=
s, sans-serif">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu-&gt;throttle_us_per_full -=C2=A0thro=
tlle_us_old)</font></div><div style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif" class=3D"gmail_default"><br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-=
style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
=C2=A0}<br>
<br>
=C2=A0static void dirtylimit_adjust_throttle(CPUState *cpu)<br>
-- <br>
2.47.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best re=
gards</font></div></div></div>

--0000000000004b98bc062abbd2db--

