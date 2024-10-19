Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 062FBD3E1BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 07:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t249j-0005HE-Rc; Sat, 19 Oct 2024 03:45:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t249h-0005Gl-Qk
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:45:45 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t249g-0006lk-9K
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:45:45 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea76a12c32so2376789a12.1
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 00:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729323943; x=1729928743; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0wyymaC6beqcqd1286NHD1IZ08lXBxOM3cyXORWGk34=;
 b=QYotnVgOar/QF+IS1qJUNL3FrOaHh+FPxJAJfA/0hNGFbVSXuSohHsM0eDXB77B8Ln
 +kXzkpU0zt/ibLY8p97pGVc/K6PPEIPXxnbQCHXXyrknZJWFKIGBF9I6rEqAT3Jmmjcx
 fT9ScWk0fcfwUDGkYmHASgssc4TXi2qwriMW6InvpaanoUUKRA5T1vrgZUVcXjdqX9ZQ
 z+DWgPCL95pOm1jVA9AsE1olNkybfHHb2fUbjp+jVxtxrk3XSViOKhldQF3oRMwKnlth
 ps/vJGWe6INNG36BVDyzxcdNCnyRqxC9bobVEuiIms4mWDKYqhJnKQ85eaN5hoA3CO3M
 SVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729323943; x=1729928743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0wyymaC6beqcqd1286NHD1IZ08lXBxOM3cyXORWGk34=;
 b=lI4OrrHu0GBj5O0XF35QwD8uADpIfweQ+xrZ5dj3G8oFc2OUYjTHiNFMPGIJg0ly3z
 Le/CtJHPiyJyK1RgMH/jWBe0H1xW/xqHxu2MISRQ/YCqRg6kvq6DHjT4WyLZUp5rSvEj
 Rl72sP6OPCSFy0OtdagvZ5Cre3TyzDh9hYZWpEa2/7IK7eBXe+dCtSnEeWS6+YfCEWhd
 TBWaXzgDPKeU4H0/cmbkOK0VqLF9VDDZL7EvYwWkUD9XDSGmWex+zAYoc1yYVa/OJrZK
 RUtPqyVbj6meCdE5Gx8if1WvPNIVwoIdae8N4Ov+o7W5IrYB3O0ZXm+bqT32qypljVM9
 vjLw==
X-Gm-Message-State: AOJu0YwuaQdzRC3dGx7f30jAq7ho6fdZG2zE0mUP0kQaKqbRtai7dhLw
 WcM29280BjXgJYkl1YhB4HEDMiNBAOuyPTSm0eWUsDdB/7F7Rlicc7vIr9nFn8iY/eM2Mg3W5MV
 nmZB+iW1ZXPy0V+0oRUq/+iFrvBc=
X-Google-Smtp-Source: AGHT+IFZ2jeu+Wn/CLgaSsS3kmRmxBEo3FRvYGhM6fPUArDtuWuEpWpTwZbOMe1dxSLBN7O+1P6Wt7B9NhuViJKKSvI=
X-Received: by 2002:a05:6a21:1519:b0:1d8:d235:b561 with SMTP id
 adf61e73a8af0-1d92c32cb67mr7492684637.0.1729323942867; Sat, 19 Oct 2024
 00:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <AM9PR09MB4851B248008D8045D466EA0B84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
In-Reply-To: <AM9PR09MB4851B248008D8045D466EA0B84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Sat, 19 Oct 2024 09:45:31 +0200
Message-ID: <CAGQJe6rpiYnA06TNv1hT5rtMTj4q8AEVBOu2JXoSh2UxyPEkHQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] Add micromips to P5600
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000050fb880624cf9bf2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=arikalo@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000050fb880624cf9bf2
Content-Type: text/plain; charset="UTF-8"

>
> Add micromips to P5600.
>
> Cherry-picked d7bf2c2f7f2e03b55c6e9c57eec5c3e6207005a0
> from https://github.com/MIPS/gnutools-qemu
>
> Signed-off-by: Faraz Shahbazker <fshahbazker@wavecomp.com>
> Signed-off-by: Matthew Fortune <matthew.fortune@imgtec.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>  target/mips/cpu-defs.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

-- Aleksandar

--00000000000050fb880624cf9bf2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Add micromips to P5600.<br>
<br>
Cherry-picked d7bf2c2f7f2e03b55c6e9c57eec5c3e6207005a0<br>
from <a href=3D"https://github.com/MIPS/gnutools-qemu" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/MIPS/gnutools-qemu</a><br>
<br>
Signed-off-by: Faraz Shahbazker &lt;<a href=3D"mailto:fshahbazker@wavecomp.=
com" target=3D"_blank">fshahbazker@wavecomp.com</a>&gt;<br>
Signed-off-by: Matthew Fortune &lt;<a href=3D"mailto:matthew.fortune@imgtec=
.com" target=3D"_blank">matthew.fortune@imgtec.com</a>&gt;<br>
Signed-off-by: Aleksandar Rakic &lt;<a href=3D"mailto:aleksandar.rakic@htec=
group.com" target=3D"_blank">aleksandar.rakic@htecgroup.com</a>&gt;<br>
---<br>
=C2=A0target/mips/cpu-defs.c.inc | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br></blockquote><div><b=
r></div><div>Reviewed-by: Aleksandar Rikalo &lt;<a href=3D"mailto:arikalo@g=
mail.com">arikalo@gmail.com</a>&gt;<br><br>-- Aleksandar<br> <br></div></di=
v></div>

--00000000000050fb880624cf9bf2--

