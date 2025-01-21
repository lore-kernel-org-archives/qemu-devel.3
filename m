Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8C4C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDKj-0000Op-F7; Tue, 21 Jan 2025 07:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1taDKh-0000OM-0b
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:26:15 -0500
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1taDKd-0001Oo-M0
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:26:14 -0500
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-29ff8053384so3271355fac.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 04:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1737462369; x=1738067169;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eD2u5ftK+uDLA0ZH7doRbUZD+A+8L0XhRkSVlQLtdTI=;
 b=yLuevR/55Amhwzk/LF8V+YZ86KYGLP96a/f2a1HH6orc2v+DG04NayZX+OxAwlcppV
 NlBGYL2OHKRphDWuGkj8bR84MbXh4gnkT5VbHGcLBDdP0wC2hrppj3grtt4a2sWjq5ux
 FBsYo3tbe57NAeN7+94GCOIXcN0p4eFU69MpNze/NzhB2PsIrVA/91npJ3IqwXqRp9lJ
 +aKO9igSn7+BRS3h2CKsZZxs+T8P3Ft7kSGgtkoCdWmK3H5UAK20DZWAPd9Ijjl1aob8
 V8f34Euv6W+UEK6as5kzMU4NazfWxXzN8xqBSVI6CTFKEnsBHaKZc5x6eD8s/W4uuu6n
 1d7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737462369; x=1738067169;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eD2u5ftK+uDLA0ZH7doRbUZD+A+8L0XhRkSVlQLtdTI=;
 b=JllOZfOkXnx4+CV0cbb5VXIdt95r5RWYBykwRbagVHLv4/uIwNubuxRagQOjd5Mads
 efRSEWrXYUvQ/Jj9MHD27jDKBiR2Yq+4L1rhnxVFq9YpqO//VYGEKYS3oRNR0AVpPUNn
 IyWzG6WGJUG6ba3QS+xCtrVI0mr/DyNryezvbcIy7uc6Jrksq9scviwsleW5HfO3U0D6
 oyuPGdKhsU9ys2eL7ZM2zh7VKh/5T31Tm9r5u2zhxlZ1urhj1RomSBv+HCST0OjdDBPT
 do1o/dwsFyYKmc78q23Zhe6PRxwXd0PREFGwGNy3K57ZSjSvGL04bQCGEbF3inYrN/gy
 cYgg==
X-Gm-Message-State: AOJu0Yww+ddx2Oj3HqLoBnFw1pQ/CW84zmn4zXMEILr6Wplk+3/Cwgtn
 WV4qiW+rkxlMis8d4l1qMNp3aOpYKR6DA6ttvE1KDWtAx+HAl9qU6PIqMSfrZgGAS93LOWLYPTp
 aP7Gm3Tb2TngJNIqz7nNQ73EaBxIImDfmhhxuLQ==
X-Gm-Gg: ASbGnctWuntr1Xq4AWW2P7sJ3O/HihScb0QlY328n0EMEQABTECbWkfGYw41gk+kBUp
 Wmj1jGFqx8zkogTqTC6ZYlczpwBVVQyJlLv7B4dJc9xZwxIabSPhQ
X-Google-Smtp-Source: AGHT+IF22xJA35Zpcnf09AcZF3m4snT3ZcC10eoA4Bti0t9boJfZwvujpq4QMAjA6Za7jMCuDJ8RKPtYH/enpmczixQ=
X-Received: by 2002:a05:6871:4109:b0:29e:5aa6:2bb3 with SMTP id
 586e51a60fabf-2b1c084189emr9029742fac.1.1737462368504; Tue, 21 Jan 2025
 04:26:08 -0800 (PST)
MIME-Version: 1.0
References: <1735610174-37467-1-git-send-email-fuqiang.wng@gmail.com>
 <1735610174-37467-3-git-send-email-fuqiang.wng@gmail.com>
In-Reply-To: <1735610174-37467-3-git-send-email-fuqiang.wng@gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Tue, 21 Jan 2025 20:25:52 +0800
X-Gm-Features: AbW1kvbtME7QigaNq1ox2gda5paecx9n0APaMwFhs4Oq3joLWNNv2vGAXOIKHgI
Message-ID: <CAK9dgmYSkpZ0TL2CJiO6FXO2ufSQK0ZUe2Y_gj571p4+7OORcg@mail.gmail.com>
Subject: Re: [PATCH 2/2] improve precision of throttle_pct
To: fuqiang wang <fuqiang.wng@gmail.com>
Cc: qemu-devel@nongnu.org, huaminxu1@jd.com, 
 wangfuqiang49 <wangfuqiang49@jd.com>
Content-Type: multipart/alternative; boundary="00000000000049267a062c367b3e"
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=yong.huang@smartx.com; helo=mail-oa1-x2a.google.com
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

--00000000000049267a062c367b3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 9:56=E2=80=AFAM fuqiang wang <fuqiang.wng@gmail.com=
> wrote:

> Using the current algorithm, there are issues with precision not being
> handled correctly during division operations. (Even though double type
> casting is used in the function, it does not seem to have any effect.)
> Refer to the results of the test program from [1]. When there is a large
> discrepancy between current and quota, there is a noticeable error.


> The main derivation of the new algorithm is(For current > quota):
>                    ring_full_time_us * current
>     quota       =3D --------------------------------
>                    ring_full_time_us + throttle_us


>                    current - quota
>     throttle_us =3D ----------------- * ring_full_time_us
>                         quota


> In the actual code, first calculate the value of
> {(current-quota})\quota} and store the intermediate result as a double.
> Then, multiply it by ring_full_time_us.
>
> Test scenario:
> - generate dirty pages program: tests/migration/stress, dirtyrate is
>   about 1500MB/s with WP enable.
> - dirtyring size : 65536
> - dirtylimit: 333
>
> To facilitate testing, merge both the new and old algorithms into the
> same code, calculate the difference in throttle_us between them, and
> track the value of the next non-linear adjustment after a linear
> adjustment.
>
> The test results are as follows:
>
> - throttle_us difference:
>   [19003, 24755, 25231, 14630, 25705]
>
>   average: 21864
>
> - next non-linear adjustment":
>   [16764, 16368, 16357, 16591, 16347]
>
>   average: 16485
>
> Based on the test results, after merging this patch, the linear
> adjustment value will increase, allowing the quota to be reached one
> loop earlier.
>
> [1]:
> https://github.com/cai-fuqiang/kernel_test/tree/master/dirty_throttle_pct=
_test


Thanks for this work. This modified algorithm seems ok to me. Could you
share

the guestperf test result or other performance tests? Such that we could
observe

the improvement directly.


>
>
> Signed-off-by: wangfuqiang49 <wangfuqiang49@jd.com>

---
>  system/dirtylimit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/system/dirtylimit.c b/system/dirtylimit.c
> index c7f663e5b9..25439e8e99 100644
> --- a/system/dirtylimit.c
> +++ b/system/dirtylimit.c
> @@ -281,7 +281,7 @@ static void dirtylimit_set_throttle(CPUState *cpu,
>  {
>      int64_t ring_full_time_us =3D 0;
>      uint64_t sleep_pct =3D 0;
> -    uint64_t throttle_pct =3D 0;
> +    double throttle_pct =3D 0;
>      uint64_t throttle_us =3D 0;
>      int64_t throtlle_us_old =3D cpu->throttle_us_per_full;
>
> @@ -294,14 +294,14 @@ static void dirtylimit_set_throttle(CPUState *cpu,
>
>      if (dirtylimit_need_linear_adjustment(quota, current)) {
>          if (quota < current) {
> -            throttle_pct  =3D (current - quota) * 100 / current;
> +            throttle_pct  =3D (current - quota) / (double)quota;
>              throttle_us =3D
> -                ring_full_time_us * throttle_pct / (double)(100 -
> throttle_pct);
> +                ring_full_time_us * throttle_pct;
>              cpu->throttle_us_per_full +=3D throttle_us;
>          } else {
> -            throttle_pct =3D (quota - current) * 100 / quota;
> +            throttle_pct =3D (quota - current) / (double)current;
>              throttle_us =3D
> -                ring_full_time_us * throttle_pct / (double)(100 -
> throttle_pct);
> +                ring_full_time_us * throttle_pct;
>              cpu->throttle_us_per_full -=3D throttle_us;
>          }
>
> --
> 2.47.0
>
>
Yong

--=20
Best regards

--00000000000049267a062c367b3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_defa=
ult" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br></div><=
/div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Tue, Dec 31, 2024 at 9:56=E2=80=AFAM fuqiang wang &lt;<a href=3D"mailto:f=
uqiang.wng@gmail.com" target=3D"_blank">fuqiang.wng@gmail.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204=
,204,204);padding-left:1ex">Using the current algorithm, there are issues w=
ith precision not being<br>
handled correctly during division operations. (Even though double type<br>
casting is used in the function, it does not seem to have any effect.)<br>
Refer to the results of the test program from [1]. When there is a large<br=
>
discrepancy between current and quota, there is a noticeable error.</blockq=
uote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204,2=
04);padding-left:1ex">
<br>
The main derivation of the new algorithm is(For current &gt; quota):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring_f=
ull_time_us * current<br>
=C2=A0 =C2=A0 quota=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D -------------------------=
-------<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ring_f=
ull_time_us + throttle_us=C2=A0</blockquote><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-styl=
e:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0curren=
t - quota<br>
=C2=A0 =C2=A0 throttle_us =3D ----------------- * ring_full_time_us<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 quota =C2=A0</blockquote><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
In the actual code, first calculate the value of<br>
{(current-quota})\quota} and store the intermediate result as a double.<br>
Then, multiply it by ring_full_time_us.<br>
<br>
Test scenario:<br>
- generate dirty pages program: tests/migration/stress, dirtyrate is<br>
=C2=A0 about 1500MB/s with WP enable.<br>
- dirtyring size : 65536<br>
- dirtylimit: 333<br>
<br>
To facilitate testing, merge both the new and old algorithms into the<br>
same code, calculate the difference in throttle_us between them, and<br>
track the value of the next non-linear adjustment after a linear<br>
adjustment.<br>
<br>
The test results are as follows:<br>
<br>
- throttle_us difference:<br>
=C2=A0 [19003, 24755, 25231, 14630, 25705]<br>
<br>
=C2=A0 average: 21864<br>
<br>
- next non-linear adjustment&quot;:<br>
=C2=A0 [16764, 16368, 16357, 16591, 16347]<br>
<br>
=C2=A0 average: 16485<br>
<br>
Based on the test results, after merging this patch, the linear<br>
adjustment value will increase, allowing the quota to be reached one<br>
loop earlier.<br>
<br>
[1]: <a href=3D"https://github.com/cai-fuqiang/kernel_test/tree/master/dirt=
y_throttle_pct_test" rel=3D"noreferrer" target=3D"_blank">https://github.co=
m/cai-fuqiang/kernel_test/tree/master/dirty_throttle_pct_test</a></blockquo=
te><div><br></div><div><font face=3D"comic sans ms, sans-serif">Thanks for =
this work.=C2=A0This modified algorithm seems ok to me.=C2=A0Could you shar=
e</font></div><div><font face=3D"comic sans ms, sans-serif"><br></font></di=
v><div><font face=3D"comic sans ms, sans-serif">the guestperf test result o=
r other performance tests? Such that we could observe</font></div><div><fon=
t face=3D"comic sans ms, sans-serif"><br></font></div><div><font face=3D"co=
mic sans ms, sans-serif">the improvement directly<span class=3D"gmail_defau=
lt">.</span></font><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;border-left-color:rgb(204,204,204);padding-left:1ex"><br>
<br>
Signed-off-by: wangfuqiang49 &lt;<a href=3D"mailto:wangfuqiang49@jd.com" ta=
rget=3D"_blank">wangfuqiang49@jd.com</a>&gt;</blockquote><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0system/dirtylimit.c | 10 +++++-----<br>
=C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/system/dirtylimit.c b/system/dirtylimit.c<br>
index c7f663e5b9..25439e8e99 100644<br>
--- a/system/dirtylimit.c<br>
+++ b/system/dirtylimit.c<br>
@@ -281,7 +281,7 @@ static void dirtylimit_set_throttle(CPUState *cpu,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int64_t ring_full_time_us =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t sleep_pct =3D 0;<br>
-=C2=A0 =C2=A0 uint64_t throttle_pct =3D 0;<br>
+=C2=A0 =C2=A0 double throttle_pct =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t throttle_us =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0int64_t throtlle_us_old =3D cpu-&gt;throttle_us_per_ful=
l;<br>
<br>
@@ -294,14 +294,14 @@ static void dirtylimit_set_throttle(CPUState *cpu,<br=
>
<br>
=C2=A0 =C2=A0 =C2=A0if (dirtylimit_need_linear_adjustment(quota, current)) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (quota &lt; current) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_pct=C2=A0 =3D (current =
- quota) * 100 / current;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_pct=C2=A0 =3D (current =
- quota) / (double)quota;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throttle_us =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* throttle_pct / (double)(100 - throttle_pct);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* throttle_pct;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_ful=
l +=3D throttle_us;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_pct =3D (quota - curren=
t) * 100 / quota;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 throttle_pct =3D (quota - curren=
t) / (double)current;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0throttle_us =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* throttle_pct / (double)(100 - throttle_pct);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_full_time_us =
* throttle_pct;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu-&gt;throttle_us_per_ful=
l -=3D throttle_us;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.47.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><div style=3D"font-fam=
ily:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_default">Yong</div=
><br></div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><font face=3D"comic sans m=
s, sans-serif">Best regards</font></div></div></div>
</div>

--00000000000049267a062c367b3e--

