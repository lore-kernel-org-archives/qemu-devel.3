Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C305FC3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 12:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTLF6-0003NB-5V; Mon, 15 Jul 2024 08:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bfu@redhat.com>) id 1sTINH-0000hw-Nz
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bfu@redhat.com>) id 1sTINF-0007Bk-Mm
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 05:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721037120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=gWnaerq4VqejhtI3J8AaIYemLKLE4tyDuanVqba84gI=;
 b=WuqhW8pjOB+WBGCNemHLwS23mTeOjX4DNlufCkTM55otJaiinxgSWL0VMNDIuOmUZy5l6n
 GN87IzGVVRHVbsMhlbovGvDtNmhnRNZa1O37zbRrrFi4s1RrWmWLYUHq5/kn0D2ZPJyBgl
 BWS16eIUDvWLtpFA6UbY9Cd+l9GsHRk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-H91ii6S0PZy851mZPf0B1A-1; Mon, 15 Jul 2024 05:50:34 -0400
X-MC-Unique: H91ii6S0PZy851mZPf0B1A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c9f6677d8eso4489168a91.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 02:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721037032; x=1721641832;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gWnaerq4VqejhtI3J8AaIYemLKLE4tyDuanVqba84gI=;
 b=cuSQTdl4CCkH1nR5CmYI2I4KP/aZHsxcxHqLvPDj6lEhfQWo1QuB2+a9yoh3spvPgU
 Gmopwj3oC5WN3Ni5CALB2YNp1OccQn2OUPbU1of6PO8tVpVKHXLAldgqf2cyeYhW53nr
 uGBajZLa7Z9K96og3o4f2VZ7eQfkneGKoz5njAvRRw6vt8+tpKuD7ksnWTIfdtBdMQxN
 /F7jAdvCEWfGMmCH8voXYq/WPBv8OF7lA9gj6WSiRFM1flh/3LBGTlkdG3rtO2j2heoS
 GJQtSPkWUr7bfaFp9+0SdVIHNy0Lt0HjAwpsb40JPS0bJB3wyrT5IH7c7ydwSXqslP3y
 /WNg==
X-Gm-Message-State: AOJu0YyPHpdc6k6yR/DGL2zg8lHDHYWXCkLCA9f5iEhdPS7b+m8dz+ko
 pHGpzKzL8dfWiEdfOm8Vc06I1jK3uZTe49Xgw2C+BK4iHs2eryc39bInvs06RAVhquK6Lb1n2PI
 T2igD2IAQum9OLspABe4c7Aly6Jgs/nSquE7S3iXICoGKLSA5HGYONDBZ3mCbcAEXXM/0V4JAWr
 kwuFosYwSDpQG21H9J3FCWX/kyRq1NmX4MkkTCFcFx
X-Received: by 2002:a17:90a:43c6:b0:2c8:660d:cc2 with SMTP id
 98e67ed59e1d1-2ca35be1c8dmr15646111a91.4.1721037032514; 
 Mon, 15 Jul 2024 02:50:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8ergCTm9xuzsqmpTL5Iplp1c0LNwcKfBkoT1V9+j11zXfBG/3hgqXql7Z/bzwekZbpehDIdOfu63AEJhmfAk=
X-Received: by 2002:a17:90a:43c6:b0:2c8:660d:cc2 with SMTP id
 98e67ed59e1d1-2ca35be1c8dmr15646105a91.4.1721037032196; Mon, 15 Jul 2024
 02:50:32 -0700 (PDT)
MIME-Version: 1.0
From: Boqiao Fu <bfu@redhat.com>
Date: Mon, 15 Jul 2024 17:50:21 +0800
Message-ID: <CAFRHJ6J9uMk+HMZL+W+KE1yoRCOLPgbPUVVDku55sdXYiGXXHg@mail.gmail.com>
Subject: [PATCH] Manpage: Update description of 'user=username' for '-run-with'
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f31df1061d4628d4"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=bfu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jul 2024 08:55:45 -0400
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

--000000000000f31df1061d4628d4
Content-Type: text/plain; charset="UTF-8"

From: Boqiao Fu <bfu@redhat.com>
Date: Mon, 15 Jul 2024 17:04:32 +0800
Subject: [PATCH] Manpage: Update description of 'user=username' for
 '-run-with'

Manpage: the description of '-runs' didn't show this parameter will use
setuid, so the customer might get confused when 'elevateprivileges=deny' is
used. Since '-runas' is going to be deprecated and replaced by this
parameter in the coming qemu9.1, add the message here.

Signed-off-by: Boqiao Fu <bfu@redhat.com>
---
 qemu-options.hx | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index ad6521ef5e..264525ed16 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5025,7 +5025,8 @@ SRST

     ``user=username`` or ``user=uid:gid`` can be used to drop root
privileges
     by switching to the specified user (via username) or user and group
-    (via uid:gid) immediately before starting guest execution.
+    (via uid:gid) immediately before starting guest execution. Effectively
+    uses the setuid system call to switch to another user id.
 ERST
 #endif

-- 
2.43.0

--000000000000f31df1061d4628d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>From: Boqiao Fu &lt;<a href=3D"mailto:bfu@redhat.com"=
>bfu@redhat.com</a>&gt;<br>Date: Mon, 15 Jul 2024 17:04:32 +0800<br>Subject=
: [PATCH] Manpage: Update description of &#39;user=3Dusername&#39; for<br>=
=C2=A0&#39;-run-with&#39;<br><br>Manpage: the description of &#39;-runs&#39=
; didn&#39;t show this parameter will use<br>setuid, so the customer might =
get confused when &#39;elevateprivileges=3Ddeny&#39; is<br>used. Since &#39=
;-runas&#39; is going to be deprecated and replaced by this<br>parameter in=
 the coming qemu9.1, add the message here.<br><br>Signed-off-by: Boqiao Fu =
&lt;<a href=3D"mailto:bfu@redhat.com">bfu@redhat.com</a>&gt;<br>---<br>=C2=
=A0qemu-options.hx | 3 ++-<br>=C2=A01 file changed, 2 insertions(+), 1 dele=
tion(-)<br><br>diff --git a/qemu-options.hx b/qemu-options.hx<br>index ad65=
21ef5e..264525ed16 100644<br>--- a/qemu-options.hx<br>+++ b/qemu-options.hx=
<br>@@ -5025,7 +5025,8 @@ SRST<br>=C2=A0<br>=C2=A0 =C2=A0 =C2=A0``user=3Dus=
ername`` or ``user=3Duid:gid`` can be used to drop root privileges<br>=C2=
=A0 =C2=A0 =C2=A0by switching to the specified user (via username) or user =
and group<br>- =C2=A0 =C2=A0(via uid:gid) immediately before starting guest=
 execution.<br>+ =C2=A0 =C2=A0(via uid:gid) immediately before starting gue=
st execution. Effectively<br>+ =C2=A0 =C2=A0uses the setuid system call to =
switch to another user id.<br>=C2=A0ERST<br>=C2=A0#endif<br>=C2=A0<br>-- <b=
r>2.43.0<br></div></div>

--000000000000f31df1061d4628d4--


