Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D8606A328
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=lPoLNZRZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP01J-0007Jo-9k; Thu, 05 Nov 2026 11:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xP01D-0007J5-9M
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:08:51 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xP01B-0005ob-H6
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:08:51 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so19769045e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793894928; x=1794499728; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=x0FCzfv9OYMEwCNlqdVnHJj1JgfOczdas0r9ze3o/f0=;
 b=lPoLNZRZkof3h0at6015NZh31bMwsij4yABe/qFM25TUmN6S7q6QBXYG7ww5aTWQHy
 8SkQf8MVE47rJk7k4WlP2M/mkLjdRtG5CXMX7wJCGQ+kfiRV50xENrf32whC1oRl1FsM
 IOIxVpPGFhScwUFnRek/7PQQwZ47iRbvKHVod2iQdbRFqNlVHzjjkOquOvdEvOCM8DTA
 U94EIVayyvH9s1Xso/kmFALOw3zdaifWRn+6QCNsexhnm6RThVFV0gmyp6E2knb/54pt
 XzS5zW0w00OIdz+Dwwtfs3qm4uakP+nsiULPwEhSg+8uqqT2UuDvCBOQD0fuhfmKT/y4
 wJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793894928; x=1794499728;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x0FCzfv9OYMEwCNlqdVnHJj1JgfOczdas0r9ze3o/f0=;
 b=O/tild8ckZDxLs6ElBbwGCdcxtLnJE1dwjKupv9Uh5xqaiSjx0iTD8XWIgkCed4BtN
 B9tbaJkGYikjGbjS9/R5UtQaSGJKHC1kQUrEr3Xevy6NJ3G+OcRC+DyBajFgCdAIOK6T
 6AX6SgaPJ/ZqggDdXsuukbBAFCf33uhiExmH7xnLvBSrXDIX9edWd4xMwAejs4UPmMBg
 sHEw2vhlrJD0JQ15rqkOxLE1nh0tJE+uzTowZIXrgLnRl3dh3tht94GAnXmgd9VgEQpQ
 0UjMbkxfCnRjTU9iqf31JS9TijgsePK4G12ONAqPywFcMNv7sLWE3Xc98abFtGxNZPN7
 OHNA==
X-Gm-Message-State: APuU4Z/+0m/INVL8HBNJ0LDpjmllAFLtz8RZ4o3bwgR5sqRviTI8v6er
 ED/qDQ0cprzBsXJvT7NqvS5fMIMhbcO3jlhV3N4JNwiIm78ta37UndLmfnMa8JMRsR0=
X-Gm-Gg: AYBFou0zGp5soycoXUJJpma8OkEJi5sltFnkkZ7pzJ9XglyzTz5gplPUrcGX4Zqk7kp
 D8XxSQddQBEl8qS8XIV+Ds3xuhfBV2GwqUAW0Qd994WW5O67nL8f6QP8TcdLqPvvmx4WgN85W7p
 9bV8LJWAnGZ1Y1cS9daOa2AeL4R8wAkcEr2cNZzX0OFU3Yl3p4vkEqormQ7IkWY3QSccahW/f33
 oClCaVBDlGw2U8WWcYIdIPZ96iH4C65hOz/GC8uWftmL0CWVmhS5ukpXULX6MbwNZI4hFJuP9ZZ
 dMXJfO8TsXo7+deKqgFIa8/+R9LOZBohZGIsnQQxgg69cJy9o9im2frtqfdzzk4CnhJ5AC3AMKQ
 fyGiBuh+e130GYdOY9DcZ5GM1Bs3jE4ZYJMfRO77jV/zTn8mjvsRX7YPWSduSrErOUamsQs6ufX
 49M6UOw7pVbfxLvScmzkQlgr9Cu7MIgCQY24j6q+PuPNYDaVAg6ZI1q61KSj6cCrlzdjc9uNlZA
 91ItUjr4qb8twbrvNXODlbJkKgR/Vojt7VZlpIPqHgKsp2K4Jb/T0zW9q8ArO30VskbzpiH5lpB
 R6lLQNzrsg5xU35WjdvOPiNUVGS9
X-Received: by 2002:a05:600c:474a:b0:4b5:d95c:2378 with SMTP id
 5b1f17b1804b1-4b5d95c241cmr41902635e9.34.1793894927605; 
 Thu, 05 Nov 2026 08:08:47 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57317cae5sm115414155e9.12.2026.11.05.08.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:08:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E0C235F8AF;
 Thu, 05 Nov 2026 16:08:45 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  Nicholas Piggin <npiggin@gmail.com>,  Harsh Prateek
 Bora <harshpb@linux.ibm.com>,  Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH v2 09/17] hw/ppc/spapr: Replace deprecated sprintf()
 with g_strdup_printf()
In-Reply-To: <20261105125203.40320-10-philmd@oss.qualcomm.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 5 Nov 2026 13:51:54
 +0100")
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-10-philmd@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Thu, 05 Nov 2026 16:08:45 +0000
Message-ID: <8733tf6z1u.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> Replace sprintf() by safer g_strdup_printf() to format the
> node name, silencing -Wdeprecated-declarations produced
> by Apple clang 17.0.0.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  hw/ppc/spapr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 54e3cc3cbe42..6f1a046a425d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -352,14 +352,13 @@ static void add_str(GString *s, const gchar *s1)
>  static int spapr_dt_memory_node(SpaprMachineState *spapr, void *fdt, int=
 nodeid,
>                                  hwaddr start, hwaddr size)
>  {
> -    char mem_name[32];
> +    g_autofree char *mem_name =3D g_strdup_printf("memory@%" HWADDR_PRIx=
, start);
>      uint64_t mem_reg_property[2];
>      int off;
>=20=20
>      mem_reg_property[0] =3D cpu_to_be64(start);
>      mem_reg_property[1] =3D cpu_to_be64(size);
>=20=20
> -    sprintf(mem_name, "memory@%" HWADDR_PRIx, start);

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>      off =3D fdt_add_subnode(fdt, 0, mem_name);

fun fact, ppc seems to be one of the arches that mixes fdt_add_subnode
with qemu_fdt_add_subnode.

>      _FDT(off);
>      _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

