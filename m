Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958ECC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbX5-0000zG-DY; Thu, 01 Feb 2024 13:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicholas.h.briggs@gmail.com>)
 id 1rVbX1-0000SO-04
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:11:25 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nicholas.h.briggs@gmail.com>)
 id 1rVbWz-0004lo-8d
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:11:22 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ddd19552e6so699388b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 10:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706811079; x=1707415879; darn=nongnu.org;
 h=message-id:to:cc:subject:date:mime-version:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ILQRObGwz6JehoNJM2hA6rPy+W1sDYepGEieXi9kJ3g=;
 b=fr3HsQWHAhg33l6+OWKx01brQhGWbuNYcME+daVRqkAgOKm6uv/qP8Y4wlEUP+VLFM
 +n9WXDAvJ0Hz/QTQgxNf09bs0KvOqMqOnUW4ivhoCGXKF/EdBYBpkdJ5DHrcgY0RxSAZ
 nqAaHXIXyL140LxqMjON29Iwn0gNVOw07PP8QiLlq046wq0Y7AxEl07dHt+IkMivaFT1
 ABBKAxHa2amQfZCz8QSNxpPmIGxon/FcShinOLsKskXE/3Z1UtM3N84NdQxRWhqtFWCz
 85h5aIXtkgkZGkYBAMQcX4wlrujOzl8M0DCK6jaibKggJcjXREL1n0iPD0MijAgjDTxG
 q4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706811079; x=1707415879;
 h=message-id:to:cc:subject:date:mime-version:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ILQRObGwz6JehoNJM2hA6rPy+W1sDYepGEieXi9kJ3g=;
 b=bJeynxtCcjZjBqs5JWdeAlFXQUx5LQVpDXVPn2I4ZOsgffjE6Keyz9IiS7DbVbCQpq
 VD5DIC869rHz1v5bs78WCjtUcSx3MWbdp9fliW1CUpNTZfotKR88mYyGPWmIX2+Wnb6l
 9N/izpLQ09eL5Mw9K88y2wYj5BHufL00rCSO4EmbBIiBNA9LWavNleKfvIN0v+Xxbp9z
 01KmWdAV+q2dQPMvKp1CIESahQPCjU921joyPvsMtnm8Fd3mTUTs+C0QTqZozbuHy6cG
 KBHf7AiD+zF1DsECUnok6yI3wrDHhYpq6h5jBgJMbQgHMRvn1wMvg1lbX8PamFuy5xTU
 5CQQ==
X-Gm-Message-State: AOJu0YzKEJAWosRqDW14YAcfRE7UgvM3VjWKakQX825y1ywswrVGFl3Y
 k4cOVZNGU9zHBquzhSnE8BK416Ydk3yNRJ6PI+S8PVzCKApjeu1zgndPd7nqUds=
X-Google-Smtp-Source: AGHT+IH1jVvHWHxKawDZs3lHZMMLe/8Fko/95uvRHmvhu4dqtpMo0Li7ppKg7wWRECZEZj/as+1yrg==
X-Received: by 2002:a62:f209:0:b0:6dd:a0af:7b0d with SMTP id
 m9-20020a62f209000000b006dda0af7b0dmr5342437pfh.30.1706811078592; 
 Thu, 01 Feb 2024 10:11:18 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX81UUUJOhSanCf5x3PI9hB3aBntvVvKsN/C7sVC+BB8DrRWDaVSla7LwUP0RqYNDmYvNej+XgbybHrE8tzxo1lsYpjVNKVhnRp9Qw=
Received: from smtpclient.apple ([2601:647:4481:77f0:30f6:e699:d7aa:38e1])
 by smtp.gmail.com with ESMTPSA id
 w23-20020aa78597000000b006dde44a2d16sm28406pfn.199.2024.02.01.10.11.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 01 Feb 2024 10:11:18 -0800 (PST)
From: Nick Briggs <nicholas.h.briggs@gmail.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_B83639D9-65C1-4433-B874-B3FD0F5651BC"
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.15\))
Date: Thu, 1 Feb 2024 10:11:17 -0800
Subject: [PATCH] Avoid unaligned fetch in ladr_match()
Cc: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Message-Id: <833CE971-9EBB-4B41-8CFD-6DC6827FDE4C@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.15)
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=nicholas.h.briggs@gmail.com; helo=mail-pf1-x434.google.com
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


--Apple-Mail=_B83639D9-65C1-4433-B874-B3FD0F5651BC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

There is no guarantee that the PCNetState is allocated such that
csr[8] is allocated on an 8-byte boundary.  Since not all hosts are
capable of unaligned fetches the 16-bit elements need to be fetched
individually to avoid a potential fault.  Closes issue #2143

Signed-off-by: Nick Briggs <nicholas.h.briggs@gmail.com>
---
 hw/net/pcnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 494eab8479..ad675ab29d 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -632,7 +632,7 @@ static inline int ladr_match(PCNetState *s, const =
uint8_t *buf, int size)
 {
     struct qemu_ether_header *hdr =3D (void *)buf;
     if ((*(hdr->ether_dhost)&0x01) &&
-        ((uint64_t *)&s->csr[8])[0] !=3D 0LL) {
+        (s->csr[8] | s->csr[9] | s->csr[10] | s->csr[11]) !=3D 0) {
         uint8_t ladr[8] =3D {
             s->csr[8] & 0xff, s->csr[8] >> 8,
             s->csr[9] & 0xff, s->csr[9] >> 8,
--=20
2.31.1


--Apple-Mail=_B83639D9-65C1-4433-B874-B3FD0F5651BC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Monaco;" class=3D"">There is no =
guarantee that the PCNetState is allocated such that</div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Monaco;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">csr[8] =
is allocated on an 8-byte boundary.&nbsp; Since not all hosts =
are</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Monaco;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">capable of unaligned fetches the 16-bit elements need to be =
fetched</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Monaco;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">individually to avoid a potential fault.&nbsp; Closes issue =
#2143</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Monaco; min-height: =
15px;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""></span><br class=3D""></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Monaco;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">Signed-off-by: Nick Briggs &lt;<a =
href=3D"mailto:nicholas.h.briggs@gmail.com" =
class=3D"">nicholas.h.briggs@gmail.com</a>&gt;</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Monaco;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">---</span></div><div style=3D"margin: 0px; font-stretch: =
normal; font-size: 11px; line-height: normal; font-family: Monaco;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;hw/net/pcnet.c | 2 +-</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;1 file changed, 1 insertion(+), 1 =
deletion(-)</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Monaco; min-height: =
15px;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D""></span><br class=3D""></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Monaco;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">diff =
--git a/hw/net/pcnet.c b/hw/net/pcnet.c</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">index 494eab8479..ad675ab29d =
100644</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Monaco;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">--- a/hw/net/pcnet.c</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">+++ b/hw/net/pcnet.c</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Monaco;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">@@ =
-632,7 +632,7 @@ static inline int ladr_match(PCNetState *s, const =
uint8_t *buf, int size)</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;{</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; struct =
qemu_ether_header *hdr =3D (void *)buf;</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; if =
((*(hdr-&gt;ether_dhost)&amp;0x01) &amp;&amp;</span></div><div =
style=3D"margin: 0px; font-stretch: normal; font-size: 11px; =
line-height: normal; font-family: Monaco;" class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D"">-&nbsp; =
&nbsp; &nbsp; &nbsp; ((uint64_t *)&amp;s-&gt;csr[8])[0] !=3D 0LL) =
{</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Monaco;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">+&nbsp; &nbsp; &nbsp; &nbsp; (s-&gt;csr[8] | s-&gt;csr[9] | =
s-&gt;csr[10] | s-&gt;csr[11]) !=3D 0) {</span></div><div style=3D"margin:=
 0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; =
uint8_t ladr[8] =3D {</span></div><div style=3D"margin: 0px; =
font-stretch: normal; font-size: 11px; line-height: normal; font-family: =
Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; s-&gt;csr[8] &amp; 0xff, s-&gt;csr[8] &gt;&gt; =
8,</span></div><div style=3D"margin: 0px; font-stretch: normal; =
font-size: 11px; line-height: normal; font-family: Monaco;" =
class=3D""><span style=3D"font-variant-ligatures: no-common-ligatures" =
class=3D"">&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; s-&gt;csr[9] =
&amp; 0xff, s-&gt;csr[9] &gt;&gt; 8,</span></div><div style=3D"margin: =
0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">--&nbsp;</span></div><div style=3D"margin:=
 0px; font-stretch: normal; font-size: 11px; line-height: normal; =
font-family: Monaco;" class=3D""><span style=3D"font-variant-ligatures: =
no-common-ligatures" class=3D"">2.31.1</span></div><div class=3D""><span =
style=3D"font-variant-ligatures: no-common-ligatures" class=3D""><br =
class=3D""></span></div></body></html>=

--Apple-Mail=_B83639D9-65C1-4433-B874-B3FD0F5651BC--

