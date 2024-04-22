Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F18C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryt9Y-0001Ka-CB; Mon, 22 Apr 2024 08:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ryt9W-0001KP-DB
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:10 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1ryt9T-0006LI-IX
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:52:09 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-4365c1451d4so25732021cf.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1713790323; x=1714395123; darn=nongnu.org;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=I5wzfSHgmIzLBtRvgwttMTr9uxSnAajMfCmUr+jteX0=;
 b=SrYt3Mu0mhg1bq6dodZZufkYjrtHLkk1j8quirSRLcgDBK0B9QrrvB/iPgLn5NiOSA
 GSRHeOzl0ScA3RaRg7TqJrUtuh/6WArr1Y8fZ8lqmx/j8NjwJyJpDrpAiKJN4lc4SpI4
 oRq93ADjx9jlh3DNlswSL3aibZzCT3bQIDW0EcHIWOfbW3EoNC0TQoT29iRMOdFnN0YI
 FI3x1onxQqHG7B2Lza+sFDtF9Z9mmonvUjnuuZkZWPOeFknGGEvM+U2OWTpsh6jQEn2o
 hU3MQRupaFL9/BIPv76v3jwXyPreTUTtV6w2dY69tz3xf7Etn74AnL9kvae2PRUaLHch
 VXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790323; x=1714395123;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I5wzfSHgmIzLBtRvgwttMTr9uxSnAajMfCmUr+jteX0=;
 b=nsKnFuMEQCAZfII97M36GSjGQZ712UUCfd8Rtq2ZFS44dhk07Ml6sV5tNNeixjoCHy
 wVAOLATUAnbB9gQXOltFoFr9W/uFcszvW4hawB4hoUFLaKA0a7bqOwpy9A8YioLt1vz4
 kkjtAuWNWyaCTOFL/bauh53RAtxiZ4nXqp/ih4vhaKsOmpyX2IxklHiiyt5CGQYvlWrW
 kS3cKLSQyohgI5QgjZOTr1Xr3Sicp55gSBS5YHK57+2ZFgmGilJCbNz1swUyXgvm7HOk
 1BWbSqvCllm9PFU6IHsvaWSl23dXv1J2YMROwWig/a3O+BqXBYFbU4bEPP8DuGNwmJcw
 1Krw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnlYoKPkxE49+Byo7Hg8lyx4neUMqFkH8/o5+DiRHoiM01ZmlYrBoB2PSgaPaWJE3NYNxDz2VgVc0KIUPJZ3rwKRCFyWc=
X-Gm-Message-State: AOJu0YyveopiBiAAImZnT6ZdpPAuQ2GV2lRuH0Jir40+kG4M97q5+S87
 FuFrbLpdS1485VKXpW+UAZcsf5Q98fgdfWv2lK4MlN0hNLCvWTW1rWWAVdCp4DRgdFIDkZGZlF4
 g9a8+8WX79pvgzEku6ZA4k+OwhRrXyao9QpBQUQ==
X-Google-Smtp-Source: AGHT+IGO6iqCVwTfBy+asamLm7yM96G8bDPOGaBhp8VKuewNclHamoXekHYrVsrT/DNttp0w13aGfjOugnaWLh8wpDk=
X-Received: by 2002:ac8:5f46:0:b0:439:d06b:331e with SMTP id
 y6-20020ac85f46000000b00439d06b331emr959995qta.28.1713790323036; Mon, 22 Apr
 2024 05:52:03 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 22 Apr 2024 05:52:02 -0700
From: =?UTF-8?B?55qu5oyv5Lyf?= <pizhenwei@bytedance.com>
In-Reply-To: <20240422085312.1037646-1-lizhijian@fujitsu.com>
References: <20240422085312.1037646-1-lizhijian@fujitsu.com>
Mime-Version: 1.0
Date: Mon, 22 Apr 2024 05:52:02 -0700
Message-ID: <CABoGonL4-htfynDa6gWJaj-VrdUybs_-_EJQT_GZKk97PSp-Rg@mail.gmail.com>
Subject: Re: [PATCH] backends/cryptodev-builtin: Fix local_error leaks
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: "arei.gonglei" <arei.gonglei@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000071f4b90616aee7ce"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=pizhenwei@bytedance.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000071f4b90616aee7ce
Content-Type: text/plain; charset="UTF-8"

Hi, Please add the following message: Fixes: 2fda101de07("virtio-crypto:
Support asynchronous mode") LGTM. Reviewed-by: zhenwei pi <
pizhenwei@bytedance.com> > From:"Li Zhijian"<lizhijian@fujitsu.com> >
Date:Mon, Apr 22, 2024, 16:50 > Subject:[External] [PATCH]
backends/cryptodev-builtin: Fix local_error leaks > To:<
arei.gonglei@huawei.com>,<pizhenwei@bytedance.com> > Cc:<philmd@linaro.org
>,<qemu-devel@nongnu.org>,"Li Zhijian"<lizhijian@fujitsu.com> > It seems
that this error does not need to be propagated to the upper, > directly
output the error to avoid the leaks >  > Closes:
https://gitlab.com/qemu-project/qemu/-/issues/2283 > Signed-off-by: Li
Zhijian <lizhijian@fujitsu.com> > --- >  backends/cryptodev-builtin.c | 9
+++++---- >  1 file changed, 5 insertions(+), 4 deletions(-) >  > diff
--git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c > index
a514bbb310..940104ee55 100644 > --- a/backends/cryptodev-builtin.c > +++
b/backends/cryptodev-builtin.c > @@ -23,6 +23,7 @@ >   >  #include
"qemu/osdep.h" >  #include "sysemu/cryptodev.h" > +#include
"qemu/error-report.h" >  #include "qapi/error.h" >  #include
"standard-headers/linux/virtio_crypto.h" >  #include "crypto/cipher.h" > @@
-396,8 +397,8 @@ static int cryptodev_builtin_create_session( >      case
VIRTIO_CRYPTO_HASH_CREATE_SESSION: >      case
VIRTIO_CRYPTO_MAC_CREATE_SESSION: >      default: > -
error_setg(&local_error, "Unsupported opcode :%" PRIu32 "", > -
      sess_info->op_code); > +        error_report("Unsupported opcode :%"
PRIu32 "", > +                     sess_info->op_code); >          return
-VIRTIO_CRYPTO_NOTSUPP; >      } >   > @@ -554,8 +555,8 @@ static int
cryptodev_builtin_operation( >   >      if (op_info->session_id >=
MAX_NUM_SESSIONS || >                builtin->sessions[op_info->session_id]
== NULL) { > -        error_setg(&local_error, "Cannot find a valid session
id: %" PRIu64 "", > -                   op_info->session_id); > +
error_report("Cannot find a valid session id: %" PRIu64 "", > +
        op_info->session_id); >          return -VIRTIO_CRYPTO_INVSESS; >
   } >   > --  > 2.31.1

--00000000000071f4b90616aee7ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"white-space:pre-wrap"><span>Hi,

Please add the following message:
Fixes: 2fda101de07(&quot;virtio-crypto: Support asynchronous mode&quot;)

LGTM.
Reviewed-by: zhenwei pi &lt;<a href=3D"mailto:pizhenwei@bytedance.com" targ=
et=3D"_blank">pizhenwei@bytedance.com</a>&gt;

&gt; From:&quot;Li Zhijian&quot;&lt;<a href=3D"mailto:lizhijian@fujitsu.com=
" target=3D"_blank">lizhijian@fujitsu.com</a>&gt;
&gt; Date:Mon, Apr 22, 2024, 16:50
&gt; Subject:[External] [PATCH] backends/cryptodev-builtin: Fix local_error=
 leaks
&gt; To:&lt;<a href=3D"mailto:arei.gonglei@huawei.com" target=3D"_blank">ar=
ei.gonglei@huawei.com</a>&gt;,&lt;<a href=3D"mailto:pizhenwei@bytedance.com=
" target=3D"_blank">pizhenwei@bytedance.com</a>&gt;
&gt; Cc:&lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@l=
inaro.org</a>&gt;,&lt;<a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_b=
lank">qemu-devel@nongnu.org</a>&gt;,&quot;Li Zhijian&quot;&lt;<a href=3D"ma=
ilto:lizhijian@fujitsu.com" target=3D"_blank">lizhijian@fujitsu.com</a>&gt;
&gt; It seems that this error does not need to be propagated to the upper,
&gt; directly output the error to avoid the leaks
&gt;=C2=A0
&gt; Closes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2283"=
 target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/issues/2283</a>
&gt; Signed-off-by: Li Zhijian &lt;<a href=3D"mailto:lizhijian@fujitsu.com"=
 target=3D"_blank">lizhijian@fujitsu.com</a>&gt;
&gt; ---
&gt;=C2=A0 backends/cryptodev-builtin.c | 9 +++++----
&gt;=C2=A0 1 file changed, 5 insertions(+), 4 deletions(-)
&gt;=C2=A0
&gt; diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin=
.c
&gt; index a514bbb310..940104ee55 100644
&gt; --- a/backends/cryptodev-builtin.c
&gt; +++ b/backends/cryptodev-builtin.c
&gt; @@ -23,6 +23,7 @@
&gt; =C2=A0
&gt;=C2=A0 #include &quot;qemu/osdep.h&quot;
&gt;=C2=A0 #include &quot;sysemu/cryptodev.h&quot;
&gt; +#include &quot;qemu/error-report.h&quot;
&gt;=C2=A0 #include &quot;qapi/error.h&quot;
&gt;=C2=A0 #include &quot;standard-headers/linux/virtio_crypto.h&quot;
&gt;=C2=A0 #include &quot;crypto/cipher.h&quot;
&gt; @@ -396,8 +397,8 @@ static int cryptodev_builtin_create_session(
&gt; =C2=A0 =C2=A0=C2=A0 case VIRTIO_CRYPTO_HASH_CREATE_SESSION:
&gt; =C2=A0 =C2=A0=C2=A0 case VIRTIO_CRYPTO_MAC_CREATE_SESSION:
&gt; =C2=A0 =C2=A0=C2=A0 default:
&gt; - =C2=A0 =C2=A0 =C2=A0=C2=A0 error_setg(&amp;local_error, &quot;Unsupp=
orted opcode :%&quot; PRIu32 &quot;&quot;,
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sess_=
info-&gt;op_code);
&gt; + =C2=A0 =C2=A0 =C2=A0=C2=A0 error_report(&quot;Unsupported opcode :%&=
quot; PRIu32 &quot;&quot;,
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 sess_info-&gt;op_code);
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return -VIRTIO_CRYPTO_NOTSUPP;
&gt; =C2=A0 =C2=A0=C2=A0 }
&gt; =C2=A0
&gt; @@ -554,8 +555,8 @@ static int cryptodev_builtin_operation(
&gt; =C2=A0
&gt; =C2=A0 =C2=A0=C2=A0 if (op_info-&gt;session_id &gt;=3D MAX_NUM_SESSION=
S ||
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 builtin-&gt;ses=
sions[op_info-&gt;session_id] =3D=3D NULL) {
&gt; - =C2=A0 =C2=A0 =C2=A0=C2=A0 error_setg(&amp;local_error, &quot;Cannot=
 find a valid session id: %&quot; PRIu64 &quot;&quot;,
&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 op_in=
fo-&gt;session_id);
&gt; + =C2=A0 =C2=A0 =C2=A0=C2=A0 error_report(&quot;Cannot find a valid se=
ssion id: %&quot; PRIu64 &quot;&quot;,
&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 op_info-&gt;session_id);
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 return -VIRTIO_CRYPTO_INVSESS;
&gt; =C2=A0 =C2=A0=C2=A0 }
&gt; =C2=A0
&gt; --=C2=A0
&gt; 2.31.1</span></div></body></html>

--00000000000071f4b90616aee7ce--

