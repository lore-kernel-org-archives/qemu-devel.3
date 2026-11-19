Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E089606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZeGkt63v;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CKJ5ty1b
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwX4-0004Hk-Kk; Thu, 19 Nov 2026 02:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTwWz-00047j-Tj
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:26:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eashurov@redhat.com>)
 id 1xTwWy-0007Vz-6c
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 02:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795073162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u5RwmKytxv5XTXrXB+ZhuOXD3hvS9jkfRBPAqrNvQHc=;
 b=ZeGkt63voGVkoVqJg4kHniwTm0geeu5eNN9xGzkg0/hLHYbzE4TwbBjQTigGfDx4czAYSi
 lQLe2DDAQjZY3LGfb57KUCsWyGd8J+8WLyvuYC/Kyp/vzsVjTINVIxwvizzfx2UmG+rN+w
 3soCtwXM3/2LiCxqloWqlUD7XbyTI7E=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-GGosIbPBNRuHgK_GzKudzQ-1; Thu, 19 Nov 2026 02:25:58 -0500
X-MC-Unique: GGosIbPBNRuHgK_GzKudzQ-1
X-Mimecast-MFC-AGG-ID: GGosIbPBNRuHgK_GzKudzQ_1795073157
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5c1af1ee7c0so491015e87.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 23:25:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795073157; cv=none;
 d=google.com; s=arc-20260327;
 b=N6npig6aYQHghS48w5t0txqqvrW+N92HD5RFja828ZfoUETwmNlwWLcJ3QXS8Ye6xi
 8j2bgkCpRAkLbUyeZUW6aI/JBd6JYj5kWjSghozW06R+WaUOuqJZl9pxL1BdIMitl9eU
 oSPF2/bLom9WdM2ClC8IBu3sXhSUwggFI4v1XdGJMh4SYOE7bjUzoIvZ0qLHCDn/STuX
 Qu6LdQZto0na9vhYmTq0veoXYY+biVgjYqldkv5oYE7OC6bZCMOAqZqWu4w4zD16SF5t
 Qc0L2xWYBl+DTeWqw/Wzncc+2mMO9n/KnfDjXLbncyAccM7pJkMuugy6drKxSZPP/n3+
 pvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u5RwmKytxv5XTXrXB+ZhuOXD3hvS9jkfRBPAqrNvQHc=;
 fh=vGW0x/LIyq+JGE/jf62yfLKeIt/+RvVMH51dc4quSPk=;
 b=VCaiQOWF2JK6Yj01NJtNb2dT+tkt7WQN4B1QQpQ1x0+dIzq0HRnlGYCRW8qPONZK+z
 hHA+AI8UBWi5BcwHyVg64Vyx6KhVu6Cm2W9kUudLd1+FPlIixyn3tupg2bzSSsaLqaP3
 /3tDoB7xyR73Mdy0vITq79YKKi2djVumFvsXtb6lDb96NlPWMHw4rWK8iTNEuI3Uc9Ec
 ODU+PmkUNL05XWDfpNmmuAA5eYxXn1KyDXjNSMmMBk47Wu8KEilUeayT5FqsSFu4xl+k
 aJzytP8y5XTISXi4PaaZ/fwnZD2HUs6g/rrIm9i3Zfd+ZlS2/93H0jkzn5Efr/K/YOOa
 vRVA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795073157; x=1795677957; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u5RwmKytxv5XTXrXB+ZhuOXD3hvS9jkfRBPAqrNvQHc=;
 b=CKJ5ty1bmvDBgQZkWY+pTX5ldzFr5MRGo8JyB9aiqAD/3oj/6lmKUlhKoAkMstnN5L
 phbg9TTfxDF0LE73RauTu+F7MmG4YWaQH1ukvLuh5lEFjvH/MfxkyMC/lfQWF6jSXFQg
 iXbViq+NeBz6gGAFlHgsAXL//oLFgwrcuwSeUfc6sA3exYppKavB6o3A3pGVh0gyqUoo
 ljW9/o/5bCrbNQPfPxHUlzIo5vAMWS30uLpJKzTLRk5tkOkUfRH+euON0U4voMdSLuzx
 IOI6FNEC3ZLFWiFToZawJwbWLcyubWfxlBTC/qkX1mCzErO3YHO29fEKaC6rKWU0ZDr5
 fnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795073157; x=1795677957;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u5RwmKytxv5XTXrXB+ZhuOXD3hvS9jkfRBPAqrNvQHc=;
 b=B9nNZu8lZVIgltuOI0vLRem740UWEuqRl9dOBxKkx2V6Fdxs9DdPG8+8y05OJw8Vg1
 GnFeb+LlftbP8xYYFpWeS8ach12/yCGl5gjfCTgNBs3jDKkEkmFj3vX+rOW9zGAe+89B
 GleeZ2LHOL2l2K/9S+j62j16nsYVVlq7KEC4PcbdADo4DE4NeV53d9sRD952TL1wm7B7
 SZLCz19OxalEqu8NryP7ytIijlgawBEvTyQ3ZCQ5PFgsUfuh8L7gxmwZkd1sMxekfNuY
 LJG1QZKpkG89q1JrRD1VUrCPGfCwuk1YoPS/rwleW7aWgSTZO48JlagxpEWbRDnsQJIU
 Q79Q==
X-Gm-Message-State: APuU4Z82I07Kc0vPgBv3SESE5w3AyIYXpW86we5tC8aOtKNRNuj0Hmcf
 5J26a2pyedTHLxNmTnJWv6OwEfHPNdzahLwkXcBdGT4EQXGP7ckovePqbCo68RMWiH7p61f0/pK
 0M/D09lvL02qrHlIY6kMahLq7D9d3bBqIJRSkgHGdtkaeaTPSSuZA9QoaMdG9KUg9AdzTSNXkWH
 H3j0PlGZuMadnAbU5Te+3gtJLEwnNZNLM=
X-Gm-Gg: AYBFou3UjY8OOniZMHjldHiavesQZWnUGF64mIk2G+b4YCL8U9F9WfYNyvl6htGSgT5
 kbj4kQaZNqcR6PZEhPf8hHhz+p2nKUAjlheokXq3WXWStJQ+/N+bQYScMZWqo6oFR7848FBA/kv
 zEp5/inE4B7bbQifx9eqrVZpbl41JDERf4zMnlfO+TZ43UtQ/+R083KVTN2Y3lUcwiZjkiK8tG8
 hy8wEZCxq/2D0iQxBQ=
X-Received: by 2002:a05:6512:3c9f:b0:5bf:b996:d8ee with SMTP id
 2adb3069b0e04-5c1a9c285c0mr1578045e87.47.1795073157233; 
 Wed, 18 Nov 2026 23:25:57 -0800 (PST)
X-Received: by 2002:a05:6512:3c9f:b0:5bf:b996:d8ee with SMTP id
 2adb3069b0e04-5c1a9c285c0mr1578033e87.47.1795073156795; Wed, 18 Nov 2026
 23:25:56 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118080610.1322669-1-eashurov@redhat.com>
 <87pkw1cppj.fsf@pond.sub.org>
In-Reply-To: <87pkw1cppj.fsf@pond.sub.org>
From: Elizabeth Ashurov <eashurov@redhat.com>
Date: Thu, 19 Nov 2026 09:25:45 +0200
X-Gm-Features: AclHuK92RYpM9rSPB8t93u6JbuxvLtfetcaA6xuLHkp0CcfKme1tXr9xw6pZMR8
Message-ID: <CAK957kEjJwY4oVLP37Xz6SaXcnM1eimAEMfRRW-BcrQHWT06dg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] qga: Add Windows driver information commands
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com, 
 dholler@redhat.com, fdeutsch@redhat.com, yvugenfi@redhat.com, 
 kramdoss@redhat.com
Content-Type: multipart/alternative; boundary="000000000000db694a06609c09b7"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eashurov@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000db694a06609c09b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've rebased the series onto current master and sent v5. Please take a look
at v5.

On Thu, Nov 19, 2026 at 8:14=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> Doesn't apply for me.  What's your base?
>
>

--000000000000db694a06609c09b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>I&#39;ve rebased the series onto current master and sen=
t v5. Please take a look at v5.</p></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 19, 20=
26 at 8:14=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat=
.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Doesn&#39;t apply for me.=C2=A0 What&#39;s your base=
?<br>
<br>
</blockquote></div>

--000000000000db694a06609c09b7--


