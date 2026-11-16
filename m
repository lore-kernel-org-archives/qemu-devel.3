Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86504606A323
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=uIXNs000
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4q5-0001OF-0y; Mon, 16 Nov 2026 17:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT4q3-0001MS-4q
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:06:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xT4q0-0007JS-2l
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:06:09 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so41751405e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 14:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794866766; x=1795471566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iSl82pf68eky5rj/Wy/mgNp8GeF/QAYY1AU9MspxO7s=;
 b=uIXNs000pNPrrBygMqz9YFScZ0Hj2sQf2M7RmIqa2K9x0zQ+/KlIn680o5dEUhlxoB
 1Q6tXfYr8s1WKAVIcXtuNQkh4IV0mjVHAgdbgcQMNQFGC54HBb08YlGM6g3KBsmTTs+j
 xd95NmdyQgIneOHK0vEGhnf1qHHRgtuuNasRiK/oiuyyjZafaEbsTfr4CcSXwY5gDCK7
 YX9a5SM9T6fK6NpMTOd4W8nkWYwRn9kybYpjb6h4nNGnd7aOMhh80KBEqnsWXILaspOQ
 T3Sw/oCWZj1HgTo91qQpDE8RaVuBZnTKZecyt9ozJBRHlj+EBsUtSTwUgMXa6Wle1FLb
 gKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794866766; x=1795471566;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iSl82pf68eky5rj/Wy/mgNp8GeF/QAYY1AU9MspxO7s=;
 b=NqyHoOleMYN47eVTyPyINAfBAJHFcLT+xD3IbRtINz0qvDN+J3DhkKVQ44vx1JXSyo
 b5fiV2nrxsLwpahYIcJQR+ZHEV2Gpd+I1fVsQuFFyVrYwcSSxKn6pQ9TtELgj2Q8eiUr
 H16c+RN1Ux7p7Co5zb+ftrBWeJytzxVW8mWA9aqX5KwVgg1bYTOfu4kPNUQrKfl1qji0
 MaJjZoJQAHDIcHowxk5iMT5qzyYixkYddH+N+rZoYjWLVCsyKsPAtXKa1jlx3POSPbEe
 E+9RPWRXPqHN25DMQz4zUfjmqa43fOUf0V6o1dN/3ilxpE2lAMX7+n6c4xW/NqAgxZdV
 ba7g==
X-Gm-Message-State: APuU4Z8m28T1MnjPEh9qXstrfMX/VRjjPoctMmc4yI7D7zSb5ZwF42LW
 Yek/u5ieO4h1pgHEMR6lEKhY+BXJl+E9EdLNy/V7EJ4OoEMR+tF8euhODHAqRBAuxDU=
X-Gm-Gg: AYBFou02uP3SAGzPIx19fCaJbK4hxD7spIN5gy8eFsjOYgxAsVUKj8Ay75eJAbxdzuL
 8xwg5cvNEigIxciOxX6Bu6mgO2Vyie3xkSqaYG87FbuJ6vJF4A3bQlTchlbP+rDeiFOyMtrKxbs
 QdFh7F4z8M85Rwdt8KaiPfrYH0D5xN0r1spgOc3oKkUZkA36oCMEDAqK/6OdeHJWK5liYxO5Jg4
 JPaz7q5WAyb0zn+EPwGMv9p90yc1fk0HeK9lXZ8L0897sjpKqZhZasowgzUDkKT+gl834sT43Yj
 t99ASuThanfAsmeN+15XaAVBWrFAVgysdZSW+YW9XwOX+MgffFBWo15BZbCy1aIYnXoX2qfoerR
 FvGXnMSEenYVUj/+UWddzDSYQ8JFAoVKQ08fKTQ/78x6i19JpkI4zcwa/+9teQZmdC24IjdNDBP
 1lsESR/1VClMPBTwLiEf6Gb5/lsw9hUE4n5RDpsZrTJ8QDWQFaoYlCxLb7JTBJug7aKkpggilKM
 yY5IcaMedN5SLE4fWtuEEXPslVZmspnT6QSSGwnVhGweSjReIS9jO1hYfYBzifi3wU20MDaddqN
 Q+/mXhLDdqnXtMfXBzeNBbbUTgui
X-Received: by 2002:a05:600c:4746:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4bb55a6a642mr268352355e9.11.1794866765749; 
 Mon, 16 Nov 2026 14:06:05 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7840b05bsm27362675e9.7.2026.11.16.14.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 14:06:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 46C4A5F8FE;
 Mon, 16 Nov 2026 22:06:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Hanna
 Reitz <hreitz@redhat.com>,  qemu-block@nongnu.org (open list:Floppy)
Subject: Re: [RFC PATCH] hw/block: validate the fdc sector position fits
 within bounds
In-Reply-To: <20260812172842.60524-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Wed, 12 Aug 2026 18:28:42 +0100")
References: <20260812172842.60524-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Mon, 16 Nov 2026 22:06:04 +0000
Message-ID: <87a4n8ig8j.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Previously the guest controlled the value of last_sec and wasn't
> particularly careful to check it didn't exceed the media size. We
> can't re-use drv->last_sec as that changes as we do operations so we
> set media_last_sect when the geometry is probed.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3800
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Cc: qemu-stable@nongnu.org

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

