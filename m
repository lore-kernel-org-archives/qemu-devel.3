Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306D6EA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoB2-0004wi-AZ; Tue, 10 Feb 2026 08:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cookieandcream560@gmail.com>)
 id 1vpn8l-00069s-8m
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:46:51 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cookieandcream560@gmail.com>)
 id 1vpn8i-0000s1-JU
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:46:51 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d18a9d2b1aso4545265a34.2
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 04:46:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770727607; cv=none;
 d=google.com; s=arc-20240605;
 b=Tij0zTBfuaiWRgD7CmJl6Kj4VI5FvkTNgIogja4evRSeZhZNUHOCwOvT+wQR6YKiqT
 CMV/Q3jDQHb/QeMftu6bN3kzT0VVhXz+7OapEbvL752JOXf4BgahGOgyDKKEZ+0QK12O
 J1BMjnuhLh6Qi8pKz8s1qquwlkQIeJHhshqblNIINCwrGWV8H6JW8GdIsZd4Q7aRZyqx
 I0nOAnp3dJwh9IkSh3WixmhaE1NrbvFxarWkJOqu1DS5hUevzuyCy6IX8e/giN0EHU6F
 33oyqE7w8c6BUrq6JPGjYXIKL8qjpH/CHPOKFoSfQ+aZrP1VYy39U6dUjzfj7jhiTTgj
 nVBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Fz7rrm62Iai8QWAXp1Zq+zNQeQyO8M0Y60PHVEbxvy8=;
 fh=9xG44hfyBuHuSHw1x4+i3NWKppwpIVPiAci0jLIbeQc=;
 b=Hz7GVa18r4zZpT0iTiV4T/fiLxykfTbU7Is3QbymJOWtWbYasUfFJYOjpHUDuoKGTA
 pHbZAxWL4eUJxUz/G9vZi95Y8krTUQ8Vd7vu+6MuVCytF0D8FyQo0GP4zHrUr6sHEtpr
 6KhWHBJkdbmLbu/muCWIbP9aDVU+3JDg+1+s39pJZDjiqmv2CQUOWnEDgNG1p7dOvnp6
 Zp1SgOioNiwhLaUEosII9Y0NZPatYZ5QRy0mzvNv4IGMLjNewog905nrSvP6TCZjNncV
 WfAPAHi1gaGYASSfOayf/yjaOEMs5hSzCwN7VvrqIP0j8gvBmU9qEVBdM4CeIQhtRFwI
 2P6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770727607; x=1771332407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Fz7rrm62Iai8QWAXp1Zq+zNQeQyO8M0Y60PHVEbxvy8=;
 b=Ba012SY6cIvYMMIUt8tGsM/LfKBHAy7hpuw7E93kaU2hhn/jgA5MIjp74/7yDJrf+t
 6MJWu1Knard3+1aXfPhPPIJLV2INbGFvs/jP/k8EfnCwj4K+QLg2c+aM36ARN9NsBkZ0
 q7ar1kxILXytXA85/uIoqWmHml25F5e850B5rwRTtLFe0noZftuqq8NHfijca8ODJB0A
 qRS4dwMkiy9mIXA7RGX6CyXW0CgORGylPhXsjGaN/QLP/p85MtpmXQ07HwP4BvV82Cew
 +F+y3zmulWLIeabs2GwCkAzSk6Y3oErOkz0LMftk+53s2HVtC0M21iYohFEsTPqWe3nc
 x7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770727607; x=1771332407;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fz7rrm62Iai8QWAXp1Zq+zNQeQyO8M0Y60PHVEbxvy8=;
 b=QGVDPBx9482/fT/G0sscAmsOIq71WSjZrwj/Ang8OkkjR5CHnvaLPq2ghEGkrV0/hA
 n4FWUUsAK+bW2WmbOIr5eQSEQ2uyZIkZag1nEz67uZ6WtEsOI303GuqxKSqcZ5LeDvUd
 W7V6sRQNTUz6gmhyIL5h8mFG8rm4bM+4NKiLvZ4nxu0lKqm5U3/7rn+H/zNYffiutar/
 ISPo+H8sSzFW9A6umaSO+VJaSYa5+CTFFD/PPUNksuJ+R5PoXGdXcpxRMmYO7oESLlB6
 icewtXxAIkkZcp0RSniBFmHRgyspHB8OkOs76Sul1oLZvRoxOtV8Vb0aIyYg7ZAjcrNm
 YbSg==
X-Gm-Message-State: AOJu0Ywq2W1fz9yuF5VOYDiu+csL/WeajPBxgAt2z8mzyxfYYwn65F8u
 EyRehURvUthjGoX9NBXInUEa0EhpMID9U2XZhpNj5BSHyUqGhC9zIN8Ick5LqFhu4yAUAlTabmm
 qdStFTvWSmjI+HyK6pd6Qn6WWR5nVt8VPT4KNmQ==
X-Gm-Gg: AZuq6aLL7XL6+HzE8+jXoUUp8SRp3MC3zXQg/qgA90f2CEXpoUZBX++rCIBdv2fHsKF
 8ZuuevhqzGVOSK3l4jLNB+G/HR+PjIVosqJDdF+9fHVc73y8vOOEyUhGFdp88BCfu0rYgFAm4Y+
 cdCrQcIpxH5YYZc36zucLa5HNHlwBR90JR8wlb02k5cc2J5YEQuy5E14llkEn5KKD8I7D6ADqe6
 ZJC2SFQ7ASVWvJPeAZZLuygHV4JMwURsEwBU9Rk34cGtqm7NGeQ7KhPZQY3O4MnpJpzAiWdrlLE
 4jOBP2iA
X-Received: by 2002:a05:6830:82be:b0:7d2:eb51:ca21 with SMTP id
 46e09a7af769-7d464487fd8mr10314770a34.23.1770727606711; Tue, 10 Feb 2026
 04:46:46 -0800 (PST)
MIME-Version: 1.0
From: Oblivionsage <cookieandcream560@gmail.com>
Date: Tue, 10 Feb 2026 13:46:34 +0100
X-Gm-Features: AZwV_Qj7A9ZcmCzTAmz7zRyx6kLeixDnbVgS-5m_bVkhJl38RRj1mhtHzzk-ydk
Message-ID: <CAJ9qJssSwxkmEVethg57-Ph6maEfButSaV-r07ma9_x1sp6wYg@mail.gmail.com>
Subject: [PATCH] block/vmdk: fix OOB read in vmdk_read_extent()
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000fdfa0e064a77a5dd"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=cookieandcream560@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Feb 2026 08:53:13 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000fdfa0e064a77a5dd
Content-Type: text/plain; charset="UTF-8"

From d335821a1f814eb3059ab5e6a7cd771360b698c4 Mon Sep 17 00:00:00 2001
From: Oblivionsage <cookieandcream560@gmail.com>
Date: Tue, 10 Feb 2026 13:33:25 +0100
Subject: [PATCH] block/vmdk: fix OOB read in vmdk_read_extent()
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
    qemu-stable@nongnu.org,
    kwolf@redhat.com,
    hreitz@redhat.com,
    fam@euphon.net

Bounds check for marker.size doesn't account for the 12-byte marker
header, allowing zlib to read past the allocated buffer.

Move the check inside the has_marker block and subtract the marker size.

Fixes: CVE-2026-2243
Reported-by: Halil Oktay (oblivionsage) <cookieandcream560@gmail.com>
Signed-off-by: Halil Oktay (oblivionsage) <cookieandcream560@gmail.com>
---
 block/vmdk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 89e89cd10e..cd8b4ec7c8 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1951,10 +1951,10 @@ vmdk_read_extent(VmdkExtent *extent, int64_t
cluster_offset,
         marker = (VmdkGrainMarker *)cluster_buf;
         compressed_data = marker->data;
         data_len = le32_to_cpu(marker->size);
-    }
-    if (!data_len || data_len > buf_bytes) {
-        ret = -EINVAL;
-        goto out;
+        if (!data_len || data_len > buf_bytes - sizeof(VmdkGrainMarker)) {
+            ret = -EINVAL;
+            goto out;
+        }
     }
     ret = uncompress(uncomp_buf, &buf_len, compressed_data, data_len);
     if (ret != Z_OK) {
--
2.47.3

--000000000000fdfa0e064a77a5dd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">From d335821a1f814eb3059ab5e6a7cd771360b698c4 Mon Sep 17 0=
0:00:00 2001<br>From: Oblivionsage &lt;<a href=3D"mailto:cookieandcream560@=
gmail.com">cookieandcream560@gmail.com</a>&gt;<br>Date: Tue, 10 Feb 2026 13=
:33:25 +0100<br>Subject: [PATCH] block/vmdk: fix OOB read in vmdk_read_exte=
nt()<br>To: <a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org<=
/a><br>Cc: <a href=3D"mailto:qemu-block@nongnu.org">qemu-block@nongnu.org</=
a>,<br>=C2=A0 =C2=A0 <a href=3D"mailto:qemu-stable@nongnu.org">qemu-stable@=
nongnu.org</a>,<br>=C2=A0 =C2=A0 <a href=3D"mailto:kwolf@redhat.com">kwolf@=
redhat.com</a>,<br>=C2=A0 =C2=A0 <a href=3D"mailto:hreitz@redhat.com">hreit=
z@redhat.com</a>,<br>=C2=A0 =C2=A0 <a href=3D"mailto:fam@euphon.net">fam@eu=
phon.net</a><br><br>Bounds check for marker.size doesn&#39;t account for th=
e 12-byte marker<br>header, allowing zlib to read past the allocated buffer=
.<br><br>Move the check inside the has_marker block and subtract the marker=
 size.<br><br>Fixes: CVE-2026-2243<br>Reported-by: Halil Oktay (oblivionsag=
e) &lt;<a href=3D"mailto:cookieandcream560@gmail.com">cookieandcream560@gma=
il.com</a>&gt;<br>Signed-off-by: Halil Oktay (oblivionsage) &lt;<a href=3D"=
mailto:cookieandcream560@gmail.com">cookieandcream560@gmail.com</a>&gt;<br>=
---<br>=C2=A0block/vmdk.c | 8 ++++----<br>=C2=A01 file changed, 4 insertion=
s(+), 4 deletions(-)<br><br>diff --git a/block/vmdk.c b/block/vmdk.c<br>ind=
ex 89e89cd10e..cd8b4ec7c8 100644<br>--- a/block/vmdk.c<br>+++ b/block/vmdk.=
c<br>@@ -1951,10 +1951,10 @@ vmdk_read_extent(VmdkExtent *extent, int64_t c=
luster_offset,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0marker =3D (VmdkGrainMa=
rker *)cluster_buf;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0compressed_data =
=3D marker-&gt;data;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0data_len =3D le32=
_to_cpu(marker-&gt;size);<br>- =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0if (!data_l=
en || data_len &gt; buf_bytes) {<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -E=
INVAL;<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (!data_len || data_len &gt; buf_bytes - sizeof(VmdkGrainMarker)) {=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0ret =3D uncompress(unc=
omp_buf, &amp;buf_len, compressed_data, data_len);<br>=C2=A0 =C2=A0 =C2=A0i=
f (ret !=3D Z_OK) {<br>--<br>2.47.3</div>

--000000000000fdfa0e064a77a5dd--

