Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08651090221
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 12:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Cvu-0005X7-CZ; Thu, 19 Mar 2026 08:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaixuanli0131@gmail.com>)
 id 1w39RJ-0003rF-Dy
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:13:15 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kaixuanli0131@gmail.com>)
 id 1w39RG-0001UM-3g
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:13:12 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so267006f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 02:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773911588; cv=none;
 d=google.com; s=arc-20240605;
 b=E+3RgbWLYWB/67lqVoDMmdC69kguptGTY+ZOVkNCzCfI9QdziuXLFpKLtNzowGkn1N
 +aorCfRBbFDbmNiaHi6lRDJFZAaQYkE20kC3ZqNepkHlrxTUk/2Z6sifuXZPvED7qNsR
 ihroJG0cQxWy4hYazD9EvBVD76rLRMIWQhHuFbMKTwm1C756S4xpC82NBeXP/RPXQElX
 va0BJqCkGpvmNFzxM3cnJQ8avx+1P0XIFFfzsNVDjRoJzR5jD0EeagKx9Ec2G5v8dA9E
 6zozICUNv4W21W0xTsopDONNEy655I9PayDbLt1//Hct8Q/7omqknOJls5pQuAs7VIOs
 h8dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=sLqxu7g9uUSHs6PhlhyCBj0KsjT84KXNqehugl6HIsE=;
 fh=0AqpBOgfML+KKR+67JVrryUB9PgnRt/yLukaJSznPAU=;
 b=MvzA6qvnQ8jtgHOl8+58+Y/V4CtTw+WfKezqKBA2kQ15IhBAIRTxqzyuHQoPWUOsxH
 rIy022uiyJ/SG/oS8f6v8b7d4qwwjuAHIl0NPZhPhv7eaHreL/OQ4rIj3kdn05hUyPdb
 exti5yuNIqningK0uA2RM9rFyZ1df9OskJPAaDgvN+/Us9HghwHzrTO3YThf9S/omKNR
 0YISP7EoLz8FaVgeo7q7+KefxWvSg2SoVxfpNLzYbM+QKHOMaz9R6cdvYj3ckYNw9Pl6
 JkvseOaCcTyc7Jqq/M7+0qqggzaDEqLwLzOlK9PY73cm/C22UBG6kzIMQaQlButGUG4s
 MUrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773911588; x=1774516388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sLqxu7g9uUSHs6PhlhyCBj0KsjT84KXNqehugl6HIsE=;
 b=DQlULv9hVoygy8kNLcK8aTZ0TYoQ0+1awx5GhtdgMc7BG/bW5w90WspGEfIGA0e6T9
 uBKYhYrZitacRoY9ntcEJMXImKeuwav076GgB3L4LjSYPOwprW0lIzJJoh4r3SHQTzvM
 foI0nOq/Q48AdZDbpZE+yG51WrordnIjxXM8QWsSiBNQqsUOF8EtqGoR8wGOHWerLM2D
 UGgNL6Y0reaCHawLthTj/eCZfUAZdS41s3dobtbHmichf9qZf9b8KhlzeTjGSxSq5Gff
 rRV/iHlmNJxTDpgKtZGj+EQXeRJ5Ih1zd8GNxt2ewGcZy2pfiAyGh6JAqns7fHr05xW5
 4nbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773911588; x=1774516388;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sLqxu7g9uUSHs6PhlhyCBj0KsjT84KXNqehugl6HIsE=;
 b=otfKBxYTNpNtoMCJJJMsZO+o+xrccdr7JTdeZ2c9k3VzRmzHUixlONCSkMq/Zba3e1
 NAlnpw4zKr5xue6WT1gqp7Po4tgr+2KqIpaZITlLXloRzkajUGR5jOYjMnb5PviPgSgA
 +W0buvIcTpsbmimofolMStCu0Iej+gndLGt30H9F2KSZ5RX/6yJCmctnheoErrhWon8X
 YH90LlsXKprdoajiMMBbfU8VJTppy092qj9kGKRlkF6+TYyXdPZfRB0EM7xY/yUTDcm8
 yVd0PTLxolVePrApotH626gV1M/WQzv/1NReRmwpcEmj9GAVFA2FgFep/1vo0C/isnFz
 tWAw==
X-Gm-Message-State: AOJu0YzxD9pwE+v4kBFo0894cj7E3zeX8CgD4IZpuwJmnn0pENEErJHD
 +Ig0yyqgAmOTzo5euFqfRJvja5FeZEGkBR5dy0Qq4BweH44adU7h8kuAI0aOQ61mEo29yrTEkPf
 5XfygUQFk8F+RYaRgQzuTt2H0IFDrIUBFr+B7
X-Gm-Gg: ATEYQzy9JexkNJxSpBlZZgiesbyEUYGY6pS2M3s+99nu42l+VR0u8drndojr3oGtzZF
 CfXImK7YR6XFsEolMR8Lkc08LLayyAp/R/5MfHDc45xgP6Zkn6vHIo/omgdwWdCBAntYzQPhJ86
 l+1QQdOGhESalA3T7K21InX2giKupFpH1bImYNRZhOtDQMwsvbfBdjXN3I6h2hiqYHNThxGW8D1
 gpOgbn9lSakWmV3KUWLMK7DGl0yabzA4fvPRjjeNC97ilvf6RHMr4qOWnuVuc9jT1EvQ6n+rBgT
 jRbjzWKuZx6g++wKRQ==
X-Received: by 2002:a05:6000:420f:b0:439:c299:4d8f with SMTP id
 ffacd0b85a97d-43b527a51ccmr10613821f8f.17.1773911587462; Thu, 19 Mar 2026
 02:13:07 -0700 (PDT)
MIME-Version: 1.0
From: Kaixuan Li <kaixuanli0131@gmail.com>
Date: Thu, 19 Mar 2026 17:12:56 +0800
X-Gm-Features: AaiRm53RT3RbIWXxdXC1cDTi2MEh8gUbzes0Udy_thgI_Eel_zRRjUHRDZB9ESo
Message-ID: <CAGVefVU7AbunJKhw9_R7jFX+RJi81QLimnkOuDM8wwvG++hesw@mail.gmail.com>
Subject: [PATCH] hw/nvme: fix heap-buffer-overflow in nvme_abort (issues/3348)
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, 
 qemu-stable@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000008a2c8064d5cfacb"
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kaixuanli0131@gmail.com; helo=mail-wr1-x436.google.com
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, DEAR_SOMETHING=1.973,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Mar 2026 08:56:51 -0400
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

--00000000000008a2c8064d5cfacb
Content-Type: text/plain; charset="UTF-8"

Dear Sir or Madam,

Since my institution email address doesn't allow git email, I sent the
patch manually as follows:

In nvme_abort(), the submission queue pointer is dereferenced from the
  guest-controlled sqid before validating it with nvme_check_sqid():

      NvmeSQueue *sq = n->sq[sqid];

  Since sqid is a 16-bit value (range 0-65535) taken directly from CDW10,
  and n->sq[] is typically only max_ioqpairs+1 (65) entries, a malicious
guest can trigger an out-of-bounds heap read by sending an Abort command
  with a large sqid.

  ASan reports this as heap-buffer-overflow in nvme_abort.

  Fix this by moving the array dereference to after the nvme_check_sqid()
  bounds validation.

  Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3348
  Fixes: 75209c071a ("hw/nvme: actually implement abort")
  Cc: qemu-stable@nongnu.org
  Signed-off-by: Kaixuan Li <kaixuanli@ntu.edu.sg>
  ---
   hw/nvme/ctrl.c | 4 +++-
   1 file changed, 3 insertions(+), 1 deletion(-)

  diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
  index cc4593cd42..be6c7028cb 100644
  --- a/hw/nvme/ctrl.c
  +++ b/hw/nvme/ctrl.c
  @@ -6111,7 +6111,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest
*req)
   {
       uint16_t sqid = le32_to_cpu(req->cmd.cdw10) & 0xffff;
       uint16_t cid  = (le32_to_cpu(req->cmd.cdw10) >> 16) & 0xffff;
  -    NvmeSQueue *sq = n->sq[sqid];
  +    NvmeSQueue *sq;
       NvmeRequest *r, *next;
       int i;

  @@ -6120,6 +6120,8 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest
*req)
           return NVME_INVALID_FIELD | NVME_DNR;
       }

  +    sq = n->sq[sqid];
  +
       if (sqid == 0) {
           for (i = 0; i < n->outstanding_aers; i++) {
               NvmeRequest *re = n->aer_reqs[i];
  --
  2.34.1

Feel free to contact me if there are any questions.

Best regards,
Kaixuan

--00000000000008a2c8064d5cfacb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Sir or Madam,<div><br></div><div>Since my institution=
 email address doesn&#39;t=C2=A0allow git email,=C2=A0I sent the patch manu=
ally as follows:</div><div><br><div>In nvme_abort(), the submission queue p=
ointer is dereferenced from the<br>=C2=A0 guest-controlled sqid before vali=
dating it with nvme_check_sqid():<br><br>=C2=A0 =C2=A0 =C2=A0 NvmeSQueue *s=
q =3D n-&gt;sq[sqid];<br><br>=C2=A0 Since sqid is a 16-bit value (range 0-6=
5535) taken directly from CDW10,<br>=C2=A0 and n-&gt;sq[] is typically only=
 max_ioqpairs+1 (65) entries, a malicious<br>guest can trigger an out-of-bo=
unds heap read by sending an Abort command<br>=C2=A0 with a large sqid.<br>=
<br>=C2=A0 ASan reports this as heap-buffer-overflow in nvme_abort.<br><br>=
=C2=A0 Fix this by moving the array dereference to after the nvme_check_sqi=
d()<br>=C2=A0 bounds validation.<br><br>=C2=A0 Resolves: <a href=3D"https:/=
/gitlab.com/qemu-project/qemu/-/issues/3348">https://gitlab.com/qemu-projec=
t/qemu/-/issues/3348</a><br>=C2=A0 Fixes: 75209c071a (&quot;hw/nvme: actual=
ly implement abort&quot;)<br>=C2=A0 Cc: <a href=3D"mailto:qemu-stable@nongn=
u.org">qemu-stable@nongnu.org</a><br>=C2=A0 Signed-off-by: Kaixuan Li &lt;<=
a href=3D"mailto:kaixuanli@ntu.edu.sg">kaixuanli@ntu.edu.sg</a>&gt;<br>=C2=
=A0 ---<br>=C2=A0 =C2=A0hw/nvme/ctrl.c | 4 +++-<br>=C2=A0 =C2=A01 file chan=
ged, 3 insertions(+), 1 deletion(-)<br><br>=C2=A0 diff --git a/hw/nvme/ctrl=
.c b/hw/nvme/ctrl.c<br>=C2=A0 index cc4593cd42..be6c7028cb 100644<br>=C2=A0=
 --- a/hw/nvme/ctrl.c<br>=C2=A0 +++ b/hw/nvme/ctrl.c<br>=C2=A0 @@ -6111,7 +=
6111,7 @@ static uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)<br>=C2=
=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t sqid =3D le32_to_cpu(req=
-&gt;cmd.cdw10) &amp; 0xffff;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t cid =
=C2=A0=3D (le32_to_cpu(req-&gt;cmd.cdw10) &gt;&gt; 16) &amp; 0xffff;<br>=C2=
=A0 - =C2=A0 =C2=A0NvmeSQueue *sq =3D n-&gt;sq[sqid];<br>=C2=A0 + =C2=A0 =
=C2=A0NvmeSQueue *sq;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0NvmeRequest *r, *next;<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br><br>=C2=A0 @@ -6120,6 +6120,8 @@ st=
atic uint16_t nvme_abort(NvmeCtrl *n, NvmeRequest *req)<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return NVME_INVALID_FIELD | NVME_DNR;<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 + =C2=A0 =C2=A0sq =3D n-&gt;sq[sqid];<b=
r>=C2=A0 +<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0if (sqid =3D=3D 0) {<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; n-&gt;outstanding_aers;=
 i++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NvmeReque=
st *re =3D n-&gt;aer_reqs[i];<br>=C2=A0 --<br>=C2=A0 2.34.1<div><br></div><=
div>Feel free to contact me if there are any questions.</div><div><br></div=
><div>Best regards,</div><div>Kaixuan</div></div></div></div>

--00000000000008a2c8064d5cfacb--

