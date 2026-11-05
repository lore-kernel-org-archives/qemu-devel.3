Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968406082BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XvbKB+Uo;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Kql32Fx6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOzPP-0005De-An; Thu, 05 Nov 2026 10:29:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xOzPN-0005DC-T2
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:29:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1xOzPM-00012h-0n
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 10:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793892581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnyEFMD5bKu5clECubxywcLnBEDqdA+HPkHOPDgjFAM=;
 b=XvbKB+Uoe4zyiuUFHrLBqq0lG1Muhv6ZWY0vky84Zv+ZKUkDP8niVfw+h0/8N8DgzKvmmM
 UQcj2kr6CrYRJpIfqnBSoc7qDteqX7SzGkXiJr3PXM7yXmoFsiOrLXAq02I8Dn3YYqPeVQ
 D6x7omG53jDhgdVE7UTIPESsDfFmir8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-MkSE181UPZ6wFODz8fwLSQ-1; Thu, 05 Nov 2026 10:29:40 -0500
X-MC-Unique: MkSE181UPZ6wFODz8fwLSQ-1
X-Mimecast-MFC-AGG-ID: MkSE181UPZ6wFODz8fwLSQ_1793892580
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c7a0f8250so41317596d6.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 07:29:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793892580; cv=none;
 d=google.com; s=arc-20260327;
 b=V0ho/peGP1Vj4fXx1VDdazILNrCfkV7MqqucwPTmHmhgF5Yl7ENkGu+4uqpOV9V0km
 jlnTEe6r3bTdC7LI75pgTB5pG8YXte3jiDxnElFLs4GbM8V+n92eesNu+kgRuwxPj8Rb
 WIyfJGqlXbKzJ4qMoPErsFxns4DxcdaXGGAg4DGxkoTZRC7bGj64QUWNlNk9Cwv3CELE
 kzA5kHDkpPb4LZwo0vYvNx2teHHQSfRuP74i2EJjp4dPZN65JryjMyLysJWwd8LZE0Ab
 WBs1T77Q1z3IkHW2N9aScDWsO0UnpScwoJJgq+Eaw7ATjwqpPHJNrcUAdMOcyO4IXT4A
 NMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WnyEFMD5bKu5clECubxywcLnBEDqdA+HPkHOPDgjFAM=;
 fh=wyYqx0NQxutiiU4yuzFtJ2RwrEKnodrcwdNDUBqGECI=;
 b=TUgNPKdfuDkoOFEKjcFiL5iy4WgABCc8/Ery4iwRYTZH1gzDrdmSSyTz5e2AcmvWC5
 gbo/vXtRJFW7KRVkvIY26j1AExdq/gmAUeAbdQMmQvC7I0sO8snxONRNLNlpIJwQcd+O
 vO2wxh/uTq8L9kZTTkdA/HuValVJZRtYzp+9bjU3+M7SjXgTwM26u7KdoABSQzdI+Dak
 d8v42+z8VDFhwiquLcjCXksQ+TY8aymno+xJqRnbdtVOGioHKvl/SwHEDLlm9uerV973
 yxgKcueBA1u99BXGGlVniMi4Vx3t1Xjw6SUVI686gN3wBqWhX4JdBnMv4pabVGNoqfXn
 XU/w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793892580; x=1794497380; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WnyEFMD5bKu5clECubxywcLnBEDqdA+HPkHOPDgjFAM=;
 b=Kql32Fx6Wa7bibBtg+l00s2kd55rZC7AHXQ9ei3e62zVonIsJKpuVUPLJHgeHAsTqN
 bm31W5AJm9fM/g1ZuNHCEHhtxlHCwUjUEQ1nfa5sgxkIPcjt2oFQeu+9URXw4DLDENUH
 lTkZzEtqGnhHHlPjHyDz2OYGnmQDV+zV6PAwxT7NS9Eg7t021pNS3ce0H/0xSDbCQdnT
 qPycReWl9ig1259cRmcgr7LiUmNKVsqkw1QUDRUSOm1X1318/yogOu2+Bkc5p33BxKXl
 yZrFBebovVuMJtJwILqR3OfOdpmTJ2PxcecD/qj2V1H2Fy+TSaFc2ZPD4MSuYARj9+nh
 56QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793892580; x=1794497380;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WnyEFMD5bKu5clECubxywcLnBEDqdA+HPkHOPDgjFAM=;
 b=UgFTqqkwleW070ftPMTgSD28h4PcTkSfT7e0u8cccLe06pNFuAij5Hdgb/rbW+/j+k
 cknrOia3E8xdwMUFAx9l7ptsI6od9cjIhZQSbFm+V8bXj1jWmfJAnqY0HPxZBFTFb8JQ
 bVxFOjwEQ0GB9dfqppcfQPQlaHX+XdQ3ZWZCo4pqAbvuQ4I9RtJ0iKUCQ4lW/+reorQn
 BJ7KO4RbSSAZ2uT1TqrqZBRkkM8+0CStXHirsiKWPlr3RwrCAxCvC7dlu2XM7joIKebX
 P7acAXVSn9B3LdHLaLnwUEwysj+m6K7W5gnq3XxFB/mjXnosJsh6zGSjHbwhazObB9XX
 tQiQ==
X-Gm-Message-State: APuU4Z8es9knIwKxwMGtCARHey6n44HwsB1DBDkUpeGJVX+pMFUqKTzM
 28WdUH5X8rzprsm42xeFIMlYv8K2rv6vSEiMfxmFIiAThGBhgjx86/o5mKbQOyaHu2OelLZa7hk
 z3TrbtuaNapmWmsCw9nCvIDiNSbtL19OID82ro5Lr7lilcfuMlXWCdoCoYbCi+Ryh+HWugJdjru
 b7g7pbP6LpNV7soFOxdRWbnlLs0d9VYao=
X-Gm-Gg: AYBFou2ra2a1+sss0VVW+ZCNhog8SEHGC/n80Yz4RUezW6Qv9OmVLjEfNgs54Bm/+9d
 rjOQSpgD/gQqWllO+bJIUBS3Wzw406dwlv/OBdj3WYs1JeWbfBUbDvIfWKegC+xfhLL8d4+I4VI
 fXVxDK3ZZ9t6ZxWLW0JvGej018I5bGGALlGoxmUmnWTyTfF1jNIP5wwNFQIeRDb9NlMNBlsHCcs
 0NqQW4Ka+m929Fg1diJHQtgPjhJ7n0xHBRhJAnzOySpe9MYnLLxU3Rzo1QJyOUDGRLL7/T4VA==
X-Received: by 2002:ad4:4eaa:0:b0:91c:6d30:7c2c with SMTP id
 6a1803df08f44-91ca4ba3932mr328995756d6.52.1793892579606; 
 Thu, 05 Nov 2026 07:29:39 -0800 (PST)
X-Received: by 2002:ad4:4eaa:0:b0:91c:6d30:7c2c with SMTP id
 6a1803df08f44-91ca4ba3932mr328995466d6.52.1793892579079; Thu, 05 Nov 2026
 07:29:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
 <20261105125203.40320-18-philmd@oss.qualcomm.com>
In-Reply-To: <20261105125203.40320-18-philmd@oss.qualcomm.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 5 Nov 2026 17:29:28 +0200
X-Gm-Features: AclHuK9F8ds1NUnep_sO2MDvEwiSehpgOjMaN3-jEOZwX-8jeVoCgePKPh3_RVQ
Message-ID: <CAPMcbCrrqrBf_7ofh1S=c=2DFTpZf1SjaqEYnVM=miKbSCk-FA@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] qga/vss-win32: Replace deprecated sprintf() by
 StrCatBuffA()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000f11ab3065f892969"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f11ab3065f892969
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 2:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> Formatting is not necessary, replace the deprecated
> sprintf() by StrCpyNA() and StrCatBuffA() calls.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  qga/vss-win32/install.cpp | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> index df00588c923a..1a3d5cbf75d5 100644
> --- a/qga/vss-win32/install.cpp
> +++ b/qga/vss-win32/install.cpp
> @@ -562,7 +562,8 @@ STDAPI DllRegisterServer(void)
>
>      /* Add this module to registry */
>
> -    sprintf(key, "CLSID\\%s", g_szClsid);
> +    StrCpyNA(key, "CLSID\\", sizeof(key));
> +    StrCatBuffA(key, g_szClsid, sizeof(key));
>

MSFT does not recommend to use StrCatBuffA due to security warning.
What about using StringCchCatA instead of snprintf, even in this case?


>      if (!CreateRegistryKey(key, NULL, g_szClsid)) {
>          goto out;
>      }
> @@ -572,7 +573,9 @@ STDAPI DllRegisterServer(void)
>          goto out;
>      }
>
> -    sprintf(key, "CLSID\\%s\\InprocServer32", g_szClsid);
> +    StrCpyNA(key, "CLSID\\", sizeof(key));
> +    StrCatBuffA(key, g_szClsid, sizeof(key));
> +    StrCatBuffA(key, "\\InprocServer32", sizeof(key));
>      if (!CreateRegistryKey(key, NULL, dllPath)) {
>          goto out;
>      }
> @@ -581,7 +584,9 @@ STDAPI DllRegisterServer(void)
>          goto out;
>      }
>
> -    sprintf(key, "CLSID\\%s\\ProgID", g_szClsid);
> +    StrCpyNA(key, "CLSID\\", sizeof(key));
> +    StrCatBuffA(key, g_szClsid, sizeof(key));
> +    StrCatBuffA(key, "\\ProgID", sizeof(key));
>      if (!CreateRegistryKey(key, NULL, g_szProgid)) {
>          goto out;
>      }
> @@ -590,7 +595,8 @@ STDAPI DllRegisterServer(void)
>          goto out;
>      }
>
> -    sprintf(key, "%s\\CLSID", g_szProgid);
> +    StrCpyNA(key, g_szProgid, sizeof(key));
> +    StrCatBuffA(key, "\\CLSID", sizeof(key));
>      if (!CreateRegistryKey(key, NULL, g_szClsid)) {
>          goto out;
>      }
> @@ -651,7 +657,8 @@ STDAPI DllUnregisterServer(void)
>          errmsg(hr, "CoCreateInstance(VSSCoordinator) failed");
>      }
>
> -    sprintf(key, "CLSID\\%s", g_szClsid);
> +    StrCpyNA(key, "CLSID\\", sizeof(key));
> +    StrCatBuffA(key, g_szClsid, sizeof(key));
>      SHDeleteKey(HKEY_CLASSES_ROOT, key);
>      SHDeleteKey(HKEY_CLASSES_ROOT, g_szProgid);
>
> --
> 2.55.0
>
>

--000000000000f11ab3065f892969
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 5, =
2026 at 2:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@oss.qualcomm.com">philmd@oss.qualcomm.com</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Formatting is not necessary,=
 replace the deprecated<br>
sprintf() by StrCpyNA() and StrCatBuffA() calls.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss=
.qualcomm.com" target=3D"_blank">philmd@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0qga/vss-win32/install.cpp | 17 ++++++++++++-----<br>
=C2=A01 file changed, 12 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp<br>
index df00588c923a..1a3d5cbf75d5 100644<br>
--- a/qga/vss-win32/install.cpp<br>
+++ b/qga/vss-win32/install.cpp<br>
@@ -562,7 +562,8 @@ STDAPI DllRegisterServer(void)<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Add this module to registry */<br>
<br>
-=C2=A0 =C2=A0 sprintf(key, &quot;CLSID\\%s&quot;, g_szClsid);<br>
+=C2=A0 =C2=A0 StrCpyNA(key, &quot;CLSID\\&quot;, sizeof(key));<br>
+=C2=A0 =C2=A0 StrCatBuffA(key, g_szClsid, sizeof(key));<br></blockquote><d=
iv><br></div><div>MSFT does not recommend=C2=A0to use=C2=A0StrCatBuffA due =
to security warning.</div><div>What about using=C2=A0StringCchCatA instead =
of snprintf, even in this case?</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0if (!CreateRegistryKey(key, NULL, g_szClsid)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -572,7 +573,9 @@ STDAPI DllRegisterServer(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 sprintf(key, &quot;CLSID\\%s\\InprocServer32&quot;, g_szClsi=
d);<br>
+=C2=A0 =C2=A0 StrCpyNA(key, &quot;CLSID\\&quot;, sizeof(key));<br>
+=C2=A0 =C2=A0 StrCatBuffA(key, g_szClsid, sizeof(key));<br>
+=C2=A0 =C2=A0 StrCatBuffA(key, &quot;\\InprocServer32&quot;, sizeof(key));=
<br>
=C2=A0 =C2=A0 =C2=A0if (!CreateRegistryKey(key, NULL, dllPath)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -581,7 +584,9 @@ STDAPI DllRegisterServer(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 sprintf(key, &quot;CLSID\\%s\\ProgID&quot;, g_szClsid);<br>
+=C2=A0 =C2=A0 StrCpyNA(key, &quot;CLSID\\&quot;, sizeof(key));<br>
+=C2=A0 =C2=A0 StrCatBuffA(key, g_szClsid, sizeof(key));<br>
+=C2=A0 =C2=A0 StrCatBuffA(key, &quot;\\ProgID&quot;, sizeof(key));<br>
=C2=A0 =C2=A0 =C2=A0if (!CreateRegistryKey(key, NULL, g_szProgid)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -590,7 +595,8 @@ STDAPI DllRegisterServer(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 sprintf(key, &quot;%s\\CLSID&quot;, g_szProgid);<br>
+=C2=A0 =C2=A0 StrCpyNA(key, g_szProgid, sizeof(key));<br>
+=C2=A0 =C2=A0 StrCatBuffA(key, &quot;\\CLSID&quot;, sizeof(key));<br>
=C2=A0 =C2=A0 =C2=A0if (!CreateRegistryKey(key, NULL, g_szClsid)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -651,7 +657,8 @@ STDAPI DllUnregisterServer(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errmsg(hr, &quot;CoCreateInstance(VSSCoor=
dinator) failed&quot;);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 sprintf(key, &quot;CLSID\\%s&quot;, g_szClsid);<br>
+=C2=A0 =C2=A0 StrCpyNA(key, &quot;CLSID\\&quot;, sizeof(key));<br>
+=C2=A0 =C2=A0 StrCatBuffA(key, g_szClsid, sizeof(key));<br>
=C2=A0 =C2=A0 =C2=A0SHDeleteKey(HKEY_CLASSES_ROOT, key);<br>
=C2=A0 =C2=A0 =C2=A0SHDeleteKey(HKEY_CLASSES_ROOT, g_szProgid);<br>
<br>
-- <br>
2.55.0<br>
<br>
</blockquote></div></div>

--000000000000f11ab3065f892969--


