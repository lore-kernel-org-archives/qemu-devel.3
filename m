Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FFFC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 11:51:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiXjy-0004fz-2j; Thu, 13 Feb 2025 06:50:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tiXjw-0004fl-6t; Thu, 13 Feb 2025 06:50:44 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tiXju-0006Oc-4R; Thu, 13 Feb 2025 06:50:43 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-868f18a629bso56041241.2; 
 Thu, 13 Feb 2025 03:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739447434; x=1740052234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwTsUC7qnoyMb0cBsViBWnABsE0czzMRLcT5TQs84zc=;
 b=l8l3LBvyFXT9WUtllFlkM55uvSWVe/wPwyfv5V9KrHK+NplCiGysnpJw107KRkeOqZ
 m8566WKs/mXIpfs384qsaeAm8qvNyf3QQ1s0nZRN/lt34US5JtoA62WUmrLLuq5tIyi3
 Wk6Ibw0P12def1cJrFKz1RqHfXqGC+J1xpAXhQxXrRRf5va3xg0vo1m/o9zGQwZYH4ep
 44ytkEuio7xD2gxRJcm6YfXkf21egw6QrEjnTL2pAMVBhbyaze07fUq0eM5FD4pMrpg7
 dQ8/g3ygHfQxCkb53av5fVyi8VRLD0bPMe1DU/E+lHxh4dBJYm24rz4jR/JVMX0X8C9R
 oAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739447434; x=1740052234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZwTsUC7qnoyMb0cBsViBWnABsE0czzMRLcT5TQs84zc=;
 b=nzCGZso4l4pYex2QRj3d4YyErjukOGSlPwBBucyOBNNHw3+Ktf/lNJlvBno3T/1wmU
 PgUgH8ugRd7R2rO+mvd2HkdMj0Cfp/+b9tttN2FTRVtzE+dtD7zGv95hiuhKTdV6k9PZ
 oyeAbd9g0PS3yUdxpki5LGhy0AmaXbnz4a+PuR58G4ObX7JddZzxGGuq2R5vt3Q5sZgg
 WUHyt6pUOIgWHBlCPiudqemXo8Hzqsz8nWHuqC+xcQA6wdawkJlbKO7u6AsyWiMKYJxQ
 xbNibg+vsbP7d3UbMTs42xjweRhoq+RYOjonKHRwi5T213QrkRII8Z0Zo7xuoc9vgnna
 0xuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX35VlSZf143U8uKqb+PRwlY/e4WRKoekopj4szvyNtsV6r1i8XbwMk88m2grtGZ5M2GhtvrwXleFxENg==@nongnu.org
X-Gm-Message-State: AOJu0YzvJC01Tn3xd+oeO9HxhvZeK/jeGQteMhHxvUc0+c6ZMZzO1jQV
 Y5mZm3h2Ts/WcSh4MStW/HgooUS8ULDOEIKLL3hUOsJ5YvYBufK77L+CO54VQ5jQsZCzcH/trHe
 JoOBCJr6ueGVlDsQgHxJP+uyiG0c=
X-Gm-Gg: ASbGnctS3Rr5arHoPMJY1ZPP55AUoC9RkWWQU5CgxmzeVFwEX+zhOy+hTxM9wk3mWtf
 wYyjBF1bzkODtLOEPBg41AsZwYD4QHvniJQcYdf5F9DAbA1KOiJ6Ii5oKHHrgA7kkBDGi7cs7AA
 ==
X-Google-Smtp-Source: AGHT+IE6kdHBCo7NIKrVTWpV1mIiRWcGQ06tLs/1s2Sis9uzCyjdAuHBqae6SjBibt/AQbReGabz5eo2PICran5EVCc=
X-Received: by 2002:a05:6102:3589:b0:4bb:9b46:3f88 with SMTP id
 ada2fe7eead31-4bc03591122mr3077403137.11.1739447434645; Thu, 13 Feb 2025
 03:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20250213114541.67515-1-graf@amazon.com>
In-Reply-To: <20250213114541.67515-1-graf@amazon.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 13 Feb 2025 17:50:21 +0600
X-Gm-Features: AWEUYZkwm_xmqCCEyjW7mUXSx_jEgpOW6vIuhceVc5fI1Ml1fgJZonTxXeI43fE
Message-ID: <CAFfO_h7p8gyxZw34H-YqW5t=QGdCnn7jF3FvJbRSKhX4=t34_g@mail.gmail.com>
Subject: Re: [PATCH] hw/virtio/virtio-nsm: Respond with correct length
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Vikrant Garg <vikrant1garg@gmail.com>, qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007297d6062e04aab3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000007297d6062e04aab3
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 13, 2025, 5:45 PM Alexander Graf <graf@amazon.com> wrote:

> When we return a response packet from NSM, we need to indicate its
> length according to the content of the response. Prior to this patch, we
> returned the length of the source buffer, which may confuse guest code
> that relies on the response size.
>
> Fix it by returning the response payload size instead.
>
> Fixes: bb154e3e0cc715 ("device/virtio-nsm: Support for Nitro Secure Module
> device")
> Reported-by: Vikrant Garg <vikrant1garg@gmail.com>
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  hw/virtio/virtio-nsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>


Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>

Thanks for fixing!

Regards,
dorjoy

--0000000000007297d6062e04aab3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 13, 2025, 5:45 PM Al=
exander Graf &lt;<a href=3D"mailto:graf@amazon.com">graf@amazon.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">When we return a response p=
acket from NSM, we need to indicate its<br>
length according to the content of the response. Prior to this patch, we<br=
>
returned the length of the source buffer, which may confuse guest code<br>
that relies on the response size.<br>
<br>
Fix it by returning the response payload size instead.<br>
<br>
Fixes: bb154e3e0cc715 (&quot;device/virtio-nsm: Support for Nitro Secure Mo=
dule device&quot;)<br>
Reported-by: Vikrant Garg &lt;<a href=3D"mailto:vikrant1garg@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">vikrant1garg@gmail.com</a>&gt;<br>
Signed-off-by: Alexander Graf &lt;<a href=3D"mailto:graf@amazon.com" target=
=3D"_blank" rel=3D"noreferrer">graf@amazon.com</a>&gt;<br>
---<br>
=C2=A0hw/virtio/virtio-nsm.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"au=
to">Reviewed-by: Dorjoy Chowdhury &lt;<a href=3D"mailto:dorjoychy111@gmail.=
com">dorjoychy111@gmail.com</a>&gt;</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Thanks for fixing!</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Regards,</div><div dir=3D"auto">dorjoy=C2=A0</div></div>

--0000000000007297d6062e04aab3--

