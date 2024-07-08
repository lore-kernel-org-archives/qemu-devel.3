Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB45C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQoeR-000531-5g; Mon, 08 Jul 2024 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQoeE-0004UY-UH
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:43:23 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luchangqi.123@bytedance.com>)
 id 1sQoeB-0007jU-S5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:43:18 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-58b0dddab8cso5816696a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1720446191; x=1721050991; darn=nongnu.org;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=pKSoI62ZUHwdahf8CJHoLPgyPIsD1XRZd3RLyVHnlDQ=;
 b=d6NuDdMAo/nQ1Co7iagXpDmMPpAzrxAo2h5ChmCVSE04riDUH8BvIiuE+Jdt+PIFNH
 QgQ0kc1kxA3p5Y186g4VI/9Q5ntwqOmyv4xYt27lUV+eMWmXlRHix/Ld4BZ6nvpcSDBZ
 4pXwC/losrRRJLE36imyLr9FUfslRcdKu10wSmy6NXUdjfuiMkNLCBp63toMdDiFCt8T
 s8nDv1ygG44dS912xF7M+S/ps8L5Xk8w1THfNukE5WdlVP/xEzjuGrKe/MICE0+hZ6CQ
 Xn/tIlEYw75y+tYeDdzE7pxhtSq8JbIIoNI+HhkytrKHCoheseNJMB38q63paE9hgLbA
 0OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720446191; x=1721050991;
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pKSoI62ZUHwdahf8CJHoLPgyPIsD1XRZd3RLyVHnlDQ=;
 b=dg9FlB0YZmX0y5yXYV5MDWc4nNc8ECntJYfv+TuEo5vi+URvwUee9ZogTfWNXiyHdg
 u1RxN+NypPq6ivTLef0zMWce7moxvF16yha/4sOe49QRnT7/ly+w7FE42im9kUGDomb9
 iGKiiUW2IOadyOwul4BzSkdcqfoZvj0FWx2svT7e0usrPWgngGth9aY00Oi/HXgYLPo9
 KOmxy9GtzLVW0OMT5FC8y0pz2isjHOJoM4KqH4JNYQomUt+ETUMneMylgsNW3Gh+Vexo
 zv4QyPHjp4HfE8CjCu7lANlIrNRdZ3aAiWb0doQy2nitxgPBfxaUbrFNqV7bhfR68AKz
 0wxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpjiAMXu5OptvdKkZKRWpBEPS9YJT+upiw/Ri09bQyREwWjfShQJHHn7kr12Nf5ddl+5CH3TDj1ZWYEYx88t3H0LdS5ko=
X-Gm-Message-State: AOJu0YwKi2rmpbKp6aO6e6jqvGgTwQYDGP68V4opNDNuf0MpyB2ocaVH
 lx3/EYhC6/Xrk+kQ+X+Ws5KYAQI9Vbe/J/U1NZ180bxYnW6njA4HWZZg4vIjCiDP8uPKEoDzbcT
 5FT2kL9vKX0Q5Zlk4DO0/Y538M31w3Zqbt5bNQA==
X-Google-Smtp-Source: AGHT+IEb7DUflzK3koDxp5vmhGGCZ1uxhwUX1hC1CK7WuGmiJ6LsuEmdBT9YNcLaWO9q18ugsLEfL2G3ojf5vMY1wqU=
X-Received: by 2002:a05:6402:1d4e:b0:57c:5fcf:b570 with SMTP id
 4fb4d7f45d1cf-58e5aecb1d7mr8232289a12.32.1720446191373; Mon, 08 Jul 2024
 06:43:11 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 8 Jul 2024 09:43:10 -0400
From: =?UTF-8?B?5Y2i6ZW/5aWH?= <luchangqi.123@bytedance.com>
In-Reply-To: <20240708130107.11495-1-luchangqi.123@bytedance.com>
References: <20240708130107.11495-1-luchangqi.123@bytedance.com>
Mime-Version: 1.0
Date: Mon, 8 Jul 2024 09:43:10 -0400
Message-ID: <CAO5cSZBVDAZzZ-MZJmGe3NCS0tW53z0E9F44CDfQ5icE0okF-w@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] Support persistent reservation operations
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, fam@euphon.net, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@dlhnet.de, 
 kbusch@kernel.org, its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org, 
 pizhenwei@bytedance.com
Content-Type: multipart/alternative; boundary="00000000000017a6e7061cbc981e"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=luchangqi.123@bytedance.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--00000000000017a6e7061cbc981e
Content-Type: text/plain; charset="UTF-8"

Hi,

I am sorry.  There may be a problem with the mailbox server, and all emails
cannot be send out. Please ignore the above emails.
From: "Changqi Lu"<luchangqi.123@bytedance.com>
Date: Mon, Jul 8, 2024, 21:01
Subject: [PATCH v8 00/10] Support persistent reservation operations
To: <qemu-block@nongnu.org>, <qemu-devel@nongnu.org>
Cc: <kwolf@redhat.com>, <hreitz@redhat.com>, <stefanha@redhat.com>, <
fam@euphon.net>, <ronniesahlberg@gmail.com>, <pbonzini@redhat.com>, <
pl@dlhnet.de>, <kbusch@kernel.org>, <its@irrelevant.dk>, <foss@defmacro.it>,
<philmd@linaro.org>, <pizhenwei@bytedance.com>, "Changqi Lu"<
luchangqi.123@bytedance.com>
Stefan, the issue you mentioned has been fixed. Almost all patches have
been reviewed, thank you very much to Stefan and Klaus. v7->v8: - Fix
num_keys may be less than 0 at scsi_pr_read_keys_complete(). - Fix buf
memory leak at iscsi driver. v6->v7: - Add buferlen size check at SCSI
layer. - Add pr_cap calculation in bdrv_merge_limits() function at block
layer, so the ugly bs->file->bs->bl.pr_cap in scsi and nvme layers was
changed to bs->bl.pr_cap. - Fix memory leak at iscsi driver, and some other
spelling errors. v5->v6: - Add relevant comments in the io layer. v4->v5: -
Fixed a memory leak bug at hw/nvme/ctrl.c. v3->v4: - At the nvme layer, the
two patches of enabling the ONCS function and enabling rescap are combined
into one. - At the nvme layer, add helper functions for pr capacity
conversion between the block layer and the nvme layer. v2->v3: In v2
Persist Through Power Loss(PTPL) is enable default. In v3 PTPL is
supported, which is passed as a parameter. v1->v2: - Add sg_persist
--report-capabilities for SCSI protocol and enable oncs and rescap for NVMe
protocol. - Add persistent reservation capabilities constants and helper
functions for SCSI and NVMe protocol. - Add comments for necessary APIs.
v1: - Add seven APIs about persistent reservation command for block layer.
These APIs including reading keys, reading reservations, registering,
reserving, releasing, clearing and preempting. - Add the necessary
pr-related operation APIs for both the SCSI protocol and NVMe protocol at
the device layer. - Add scsi driver at the driver layer to verify the
functions Changqi Lu (10): block: add persistent reservation in/out api
block/raw: add persistent reservation in/out driver scsi/constant: add
persistent reservation in/out protocol constants scsi/util: add helper
functions for persistent reservation types conversion hw/scsi: add
persistent reservation in/out api for scsi device block/nvme: add
reservation command protocol constants hw/nvme: add helper functions for
converting reservation types hw/nvme: enable ONCS and rescap function
hw/nvme: add reservation protocal command block/iscsi: add persistent
reservation in/out driver block/block-backend.c | 403
++++++++++++++++++++++++++++ block/io.c | 164 ++++++++++++ block/iscsi.c |
425 ++++++++++++++++++++++++++++++ block/raw-format.c | 56 ++++
hw/nvme/ctrl.c | 326 ++++++++++++++++++++++- hw/nvme/ns.c | 5 +
hw/nvme/nvme.h | 88 +++++++ hw/scsi/scsi-disk.c | 368
++++++++++++++++++++++++++ include/block/block-common.h | 40 +++
include/block/block-io.h | 20 ++ include/block/block_int-common.h | 84
++++++ include/block/nvme.h | 100 ++++++- include/scsi/constants.h | 52
++++ include/scsi/utils.h | 8 + include/sysemu/block-backend-io.h | 24 ++
scsi/utils.c | 81 ++++++ 16 files changed, 2241 insertions(+), 3
deletions(-) -- 2.20.1

--00000000000017a6e7061cbc981e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div id=3D"editor_version_1.17.2_YqoEMP31" style=
=3D"word-break:break-word"><div style=3D"margin-top:4px;margin-bottom:4px;l=
ine-height:1.6"><div dir=3D"auto" class=3D"" style=3D"font-size:16px">Hi,</=
div></div><div style=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><=
div dir=3D"auto" class=3D"" style=3D"font-size:16px"><br></div></div><div s=
tyle=3D"margin-top:4px;margin-bottom:4px;line-height:1.6"><div dir=3D"auto"=
 class=3D"" style=3D"font-size:16px">I am sorry.=C2=A0 There may be a probl=
em with the mailbox server, and all emails cannot be send out. Please ignor=
e the above emails.</div></div></div><div class=3D"history-quote-wrapper" i=
d=3D"lark-mail-quote-172044618"><div style=3D"list-style-position:inside"><=
div class=3D"adit-html-block adit-html-block--collapsed" style=3D"border-le=
ft:none;padding-left:0px"><div><div class=3D"adit-html-block__attr history-=
quote-meta-wrapper history-quote-gap-tag" id=3D"lark-mail-quote-meta-narEfr=
smo" style=3D"padding:12px;background:rgb(245,246,247);color:rgb(31,35,41);=
border-radius:4px;margin-top:24px;margin-bottom:12px"><div id=3D"lark-mail-=
quote-27ea1886fc7d5a7915997f00642e34d4"><div style=3D"word-break:break-word=
"><div style=3D""><span style=3D"white-space:nowrap">From: </span><span sty=
le=3D"white-space:nowrap">&quot;Changqi Lu&quot;&lt;<a style=3D"white-space=
:pre-wrap;word-break:break-word;text-decoration:none;color:inherit" href=3D=
"mailto:luchangqi.123@bytedance.com" class=3D"quote-head-meta-mailto">lucha=
ngqi.123@bytedance.com</a>&gt;</span></div><div style=3D""><span style=3D"w=
hite-space:nowrap">Date: </span> Mon, Jul 8, 2024, 21:01</div><div style=3D=
""><span style=3D"white-space:nowrap">Subject: </span> [PATCH v8 00/10] Sup=
port persistent reservation operations</div><div style=3D""><span style=3D"=
white-space:nowrap">To: </span><span style=3D"white-space:nowrap">&lt;<a st=
yle=3D"white-space:pre-wrap;word-break:break-word;text-decoration:none;colo=
r:inherit" href=3D"mailto:qemu-block@nongnu.org" class=3D"quote-head-meta-m=
ailto">qemu-block@nongnu.org</a>&gt;</span>, <span style=3D"white-space:now=
rap">&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;text-decora=
tion:none;color:inherit" href=3D"mailto:qemu-devel@nongnu.org" class=3D"quo=
te-head-meta-mailto">qemu-devel@nongnu.org</a>&gt;</span></div><div style=
=3D""><span style=3D"white-space:nowrap">Cc: </span><span style=3D"white-sp=
ace:nowrap">&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;text=
-decoration:none;color:inherit" href=3D"mailto:kwolf@redhat.com" class=3D"q=
uote-head-meta-mailto">kwolf@redhat.com</a>&gt;</span>, <span style=3D"whit=
e-space:nowrap">&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;=
text-decoration:none;color:inherit" href=3D"mailto:hreitz@redhat.com" class=
=3D"quote-head-meta-mailto">hreitz@redhat.com</a>&gt;</span>, <span style=
=3D"white-space:nowrap">&lt;<a style=3D"white-space:pre-wrap;word-break:bre=
ak-word;text-decoration:none;color:inherit" href=3D"mailto:stefanha@redhat.=
com" class=3D"quote-head-meta-mailto">stefanha@redhat.com</a>&gt;</span>, <=
span style=3D"white-space:nowrap">&lt;<a style=3D"white-space:pre-wrap;word=
-break:break-word;text-decoration:none;color:inherit" href=3D"mailto:fam@eu=
phon.net" class=3D"quote-head-meta-mailto">fam@euphon.net</a>&gt;</span>, <=
span style=3D"white-space:nowrap">&lt;<a style=3D"white-space:pre-wrap;word=
-break:break-word;text-decoration:none;color:inherit" href=3D"mailto:ronnie=
sahlberg@gmail.com" class=3D"quote-head-meta-mailto">ronniesahlberg@gmail.c=
om</a>&gt;</span>, <span style=3D"white-space:nowrap">&lt;<a style=3D"white=
-space:pre-wrap;word-break:break-word;text-decoration:none;color:inherit" h=
ref=3D"mailto:pbonzini@redhat.com" class=3D"quote-head-meta-mailto">pbonzin=
i@redhat.com</a>&gt;</span>, <span style=3D"white-space:nowrap">&lt;<a styl=
e=3D"white-space:pre-wrap;word-break:break-word;text-decoration:none;color:=
inherit" href=3D"mailto:pl@dlhnet.de" class=3D"quote-head-meta-mailto">pl@d=
lhnet.de</a>&gt;</span>, <span style=3D"white-space:nowrap">&lt;<a style=3D=
"white-space:pre-wrap;word-break:break-word;text-decoration:none;color:inhe=
rit" href=3D"mailto:kbusch@kernel.org" class=3D"quote-head-meta-mailto">kbu=
sch@kernel.org</a>&gt;</span>, <span style=3D"white-space:nowrap">&lt;<a st=
yle=3D"white-space:pre-wrap;word-break:break-word;text-decoration:none;colo=
r:inherit" href=3D"mailto:its@irrelevant.dk" class=3D"quote-head-meta-mailt=
o">its@irrelevant.dk</a>&gt;</span>, <span style=3D"white-space:nowrap">&lt=
;<a style=3D"white-space:pre-wrap;word-break:break-word;text-decoration:non=
e;color:inherit" href=3D"mailto:foss@defmacro.it" class=3D"quote-head-meta-=
mailto">foss@defmacro.it</a>&gt;</span>, <span style=3D"white-space:nowrap"=
>&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;text-decoration=
:none;color:inherit" href=3D"mailto:philmd@linaro.org" class=3D"quote-head-=
meta-mailto">philmd@linaro.org</a>&gt;</span>, <span style=3D"white-space:n=
owrap">&lt;<a style=3D"white-space:pre-wrap;word-break:break-word;text-deco=
ration:none;color:inherit" href=3D"mailto:pizhenwei@bytedance.com" class=3D=
"quote-head-meta-mailto">pizhenwei@bytedance.com</a>&gt;</span>, <span styl=
e=3D"white-space:nowrap">&quot;Changqi Lu&quot;&lt;<a style=3D"white-space:=
pre-wrap;word-break:break-word;text-decoration:none;color:inherit" href=3D"=
mailto:luchangqi.123@bytedance.com" class=3D"quote-head-meta-mailto">luchan=
gqi.123@bytedance.com</a>&gt;</span></div></div></div></div><div><div style=
=3D"white-space:pre-wrap">Stefan, the issue you mentioned has been fixed.

Almost all patches have been reviewed, thank you very much
to Stefan and Klaus.


v7-&gt;v8:
- Fix num_keys may be less than 0 at scsi_pr_read_keys_complete().
- Fix buf memory leak at iscsi driver.

v6-&gt;v7:
- Add buferlen size check at SCSI layer.
- Add pr_cap calculation in bdrv_merge_limits() function at block layer,
  so the ugly bs-&gt;file-&gt;bs-&gt;bl.pr_cap in scsi and nvme layers was
  changed to bs-&gt;bl.pr_cap.
- Fix memory leak at iscsi driver, and some other spelling errors.

v5-&gt;v6:
- Add relevant comments in the io layer.

v4-&gt;v5:
- Fixed a memory leak bug at hw/nvme/ctrl.c.

v3-&gt;v4:
- At the nvme layer, the two patches of enabling the ONCS
  function and enabling rescap are combined into one.
- At the nvme layer, add helper functions for pr capacity
  conversion between the block layer and the nvme layer.

v2-&gt;v3:
In v2 Persist Through Power Loss(PTPL) is enable default.
In v3 PTPL is supported, which is passed as a parameter.

v1-&gt;v2:
- Add sg_persist --report-capabilities for SCSI protocol and enable
  oncs and rescap for NVMe protocol.
- Add persistent reservation capabilities constants and helper functions fo=
r
  SCSI and NVMe protocol.
- Add comments for necessary APIs.

v1:
- Add seven APIs about persistent reservation command for block layer.
  These APIs including reading keys, reading reservations, registering,
  reserving, releasing, clearing and preempting.
- Add the necessary pr-related operation APIs for both the
  SCSI protocol and NVMe protocol at the device layer.
- Add scsi driver at the driver layer to verify the functions


Changqi Lu (10):
  block: add persistent reservation in/out api
  block/raw: add persistent reservation in/out driver
  scsi/constant: add persistent reservation in/out protocol constants
  scsi/util: add helper functions for persistent reservation types
    conversion
  hw/scsi: add persistent reservation in/out api for scsi device
  block/nvme: add reservation command protocol constants
  hw/nvme: add helper functions for converting reservation types
  hw/nvme: enable ONCS and rescap function
  hw/nvme: add reservation protocal command
  block/iscsi: add persistent reservation in/out driver

 block/block-backend.c             | 403 ++++++++++++++++++++++++++++
 block/io.c                        | 164 ++++++++++++
 block/iscsi.c                     | 425 ++++++++++++++++++++++++++++++
 block/raw-format.c                |  56 ++++
 hw/nvme/ctrl.c                    | 326 ++++++++++++++++++++++-
 hw/nvme/ns.c                      |   5 +
 hw/nvme/nvme.h                    |  88 +++++++
 hw/scsi/scsi-disk.c               | 368 ++++++++++++++++++++++++++
 include/block/block-common.h      |  40 +++
 include/block/block-io.h          |  20 ++
 include/block/block_int-common.h  |  84 ++++++
 include/block/nvme.h              | 100 ++++++-
 include/scsi/constants.h          |  52 ++++
 include/scsi/utils.h              |   8 +
 include/sysemu/block-backend-io.h |  24 ++
 scsi/utils.c                      |  81 ++++++
 16 files changed, 2241 insertions(+), 3 deletions(-)

--=20
2.20.1</div></div></div></div></div></div></body></html>

--00000000000017a6e7061cbc981e--

