Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1069C25B4F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 01:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4sin-0001CN-MI; Wed, 08 May 2024 21:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1s4sik-0001C9-1k
 for qemu-devel@nongnu.org; Wed, 08 May 2024 21:37:18 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1s4sih-0003ck-7q
 for qemu-devel@nongnu.org; Wed, 08 May 2024 21:37:17 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-61f2dc31be4so1088401a12.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 18:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1715218509; x=1715823309;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r60Klc+glqB6qsb95g/t7LoeJ5fA/8nA5CnSdTvVGNo=;
 b=0r3ivmEU07jQ6NxQ64o9zipB1qKkLTLx4oAm3eOvlHL61zv8RenH6cNY3+3ijUIacD
 9Y2y4EWtwWIH9Ok84nertsUA8sEaqwkMRXSpAzIuzdY1XIs7kkkRtQcAlQpDtfceY2cZ
 0KQTigEPBsPreF0i44hocH8PZOqoJ6pD5D4YdBtAZHhihr56g+003KbzL0LuGOmZ8pLk
 IOZQ5fLB1wOFrlwwhkSDEOTdQOlV5K9afQVcJ0XvYQxC8dEIN3wGLTB9Z7Zj2Hl+33NZ
 A73vClLps+G5aVhT46VrMazR4zxBoYzflgxStMiOqR0D4SggzkxmRIXjzoqDlUBuCzgg
 4d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715218509; x=1715823309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r60Klc+glqB6qsb95g/t7LoeJ5fA/8nA5CnSdTvVGNo=;
 b=U4FzE/f4ZEepQcIVbFfw2SLtVm1gmEGi1IRqSRjljHRFtefuaRdYcXK8QncnzmZw0f
 HHqZwvG7fyASwxMCbftR5unYzzFA12DOv0f1uQKUlHdzIM8dZYh9DfnSUZECSOcgCU0m
 CT5yBKsDVDRY/L3FM59X14hYUR8kxi9BPWC2++fT45+E+uzg6WL5KGiyljQ4GzSoqjE+
 I931dwWjE8R9y1a8T9CZEeDFwyi4lGOblpeqnppDGltRMpAuCDF46bFTpBCLD4VFDicA
 Ud5NidqEYrH3apRfzDvh34qWDbsE9wDx485+mgmsDXUToA4Nd7C7AcaZpklvD2jDfaff
 2wTw==
X-Gm-Message-State: AOJu0YyO7e6s42ySXwtr05TSdRRBF2ROW3fccml7GB4cxw/lnZgexOA+
 B34extcK5wPfyYQXQtepdeygKd/fG9pOHgul81ToY3h5djonVtPCjlX6n04+dlot7zso0VRp05A
 9DSSoW5gnVgZBdVtFlso7GcD5jKkXPQNGr4mLuygx2EczB30YzilGBKz9
X-Google-Smtp-Source: AGHT+IEIE5Q5Lom9um8mtT6CjhpCzVSTGUjyuzPvDTYA9uE26VIEuISUYq5bib6uEi4U0JFs2KenuiB5+Kil4sgaKTM=
X-Received: by 2002:a17:90a:6304:b0:2aa:c389:c9f0 with SMTP id
 98e67ed59e1d1-2b65fb18cadmr1877666a91.12.1715218508977; Wed, 08 May 2024
 18:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1712577715.git.yong.huang@smartx.com>
 <CAK9dgmaHJF-JWSRww1raYFYxCZ4b19ydH3nWQzv1-VqzqiJuDA@mail.gmail.com>
In-Reply-To: <CAK9dgmaHJF-JWSRww1raYFYxCZ4b19ydH3nWQzv1-VqzqiJuDA@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Thu, 9 May 2024 09:34:52 +0800
Message-ID: <CAK9dgmYfqNjRGEK40t32ZK5mV-+kCGidR6k33sbOoDxW41NUaw@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/2] Fix crash of VMs configured with the CDROM
 device
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000f0b2420617fb6dce"
Received-SPF: none client-ip=2607:f8b0:4864:20::52e;
 envelope-from=yong.huang@smartx.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000f0b2420617fb6dce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping2

Make sure that this patchset is not overlooked.

Yong

On Tue, Apr 23, 2024 at 9:45=E2=80=AFAM Yong Huang <yong.huang@smartx.com> =
wrote:

> Ping.
> I would appreciate comments on this series. Thanks,
>
> Yong
>
> On Mon, Apr 8, 2024 at 8:08=E2=80=AFPM Hyman Huang <yong.huang@smartx.com=
> wrote:
>
>> This patchset fixes the crash of VMs configured with the CDROM device
>> on the destination during live migration. See the commit message for
>> details.
>>
>> The previous patchset does not show up at https://patchew.org/QEMU.
>> Just resend it to ensure the email gets to the inbox.
>>
>> Please review.
>>
>> Yong
>>
>> Hyman Huang (2):
>>   scsi-disk: Introduce the migrate_emulate_scsi_request field
>>   scsi-disk: Fix crash of VMs configured with the CDROM device
>>
>>  hw/scsi/scsi-disk.c | 35 ++++++++++++++++++++++++++++++++++-
>>  1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> --
>> 2.39.3
>>
>>
>
> --
> Best regards
>


--=20
Best regards

--000000000000f0b2420617fb6dce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">Ping2</div><div class=3D"gma=
il_default" style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><br>=
</div><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms=
&quot;,sans-serif">Make sure that this patchset is not overlooked.<br></div=
><div class=3D"gmail_default" style=3D"font-family:&quot;comic sans ms&quot=
;,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:&=
quot;comic sans ms&quot;,sans-serif">Yong</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 23, 2024 at 9:45=
=E2=80=AFAM Yong Huang &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.hu=
ang@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:sol=
id;border-left-color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><d=
iv style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">Ping.</div><d=
iv style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">I would appre=
ciate comments on this series. Thanks,</div><div style=3D"font-family:&quot=
;comic sans ms&quot;,sans-serif"><br></div><div style=3D"font-family:&quot;=
comic sans ms&quot;,sans-serif">Yong</div></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Apr 8, 2024 at 8:08=E2=80=
=AFPM Hyman Huang &lt;<a href=3D"mailto:yong.huang@smartx.com" target=3D"_b=
lank">yong.huang@smartx.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">This p=
atchset fixes the crash of VMs configured with the CDROM device<br>
on the destination during live migration. See the commit message for<br>
details.<br>
<br>
The previous patchset does not show up at <a href=3D"https://patchew.org/QE=
MU" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU</a>.<br>
Just resend it to ensure the email gets to the inbox.<br>
<br>
Please review.<br>
<br>
Yong<br>
<br>
Hyman Huang (2):<br>
=C2=A0 scsi-disk: Introduce the migrate_emulate_scsi_request field<br>
=C2=A0 scsi-disk: Fix crash of VMs configured with the CDROM device<br>
<br>
=C2=A0hw/scsi/scsi-disk.c | 35 ++++++++++++++++++++++++++++++++++-<br>
=C2=A01 file changed, 34 insertions(+), 1 deletion(-)<br>
<br>
-- <br>
2.39.3<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000f0b2420617fb6dce--

