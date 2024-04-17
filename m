Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5E0C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 16:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rx8Df-0004YX-UR; Wed, 17 Apr 2024 12:33:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rx8De-0004Xd-0Y
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rx8Da-0005t5-JI
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 12:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713371585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi4ZpGXmlYij7zH2evT0UvHnWnLyb71KaqbmQhjls6s=;
 b=WkDZomaGOMK1CEmlLTIPXEFhHp+yTP02xMNU03Z0BmR83HLeGDwBjGKGOpGcEJfcpVSfpE
 C9yjEA2cAAc4834Ty0U38OBic5BErj8APoq2dFE+5sBcaRaL+exniaRqc08hMjk3tWlo1v
 9Iw4Kwnwa9ZjrS95EtIDbWngGm5kYZk=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-ZiluvimsOA2SqH4LbvYmkA-1; Wed, 17 Apr 2024 12:33:03 -0400
X-MC-Unique: ZiluvimsOA2SqH4LbvYmkA-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-61ab173fe00so69252827b3.3
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 09:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713371583; x=1713976383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fi4ZpGXmlYij7zH2evT0UvHnWnLyb71KaqbmQhjls6s=;
 b=Yo2yxlzy0Mt6vuIfqAOgSgPfjHt1UAoe3QUzoGLZUkGAWEGlCG6Mej5N65kMUXFpMW
 Rdc2+zpvR04oiZBXqSbFG3Bp+V0tNShQCwmuj6dXbzVIrYjT7vGkeaGIEYTWwqpmv0Q6
 IMcARqZZCu5f+1rAQYjIofHRJp6M95OQQKZ+Lz/qeO49NqB4+Z2yNBODzzygCVaMfWFf
 6GwQSOCHbrvRzm/6MGjMSoVALf2c75+7aTbiPHiqw3DAjkE2lsiHqLS+Dnezx9ASxZk2
 hD08MjZGTweNdiuHoAsGQs9nCu2Z/UX8eKef+F4zGDgFa3BNOX9P4fuma/jChW0g7OQ8
 RjeQ==
X-Gm-Message-State: AOJu0Yw80FandY7uTli808kM4aFfZQm14Y6rv2nBX+ldTzwSYnxdtd60
 h/J+KMi0THxVppHdpY8gRL7gkBqb9KE+PvxZwaehzfiuAymfpEzm7gER3qQb0BfjI/i7SHg4fuI
 A0PIpLNwX2Y8JN5h/Pi+DPhEMPaIVsyC+m9fqbnGL+PJo8A8ManPP0YJF4BJozVSDzXKJZlnvzP
 h3HnXdDwERNbCoRGcu8QtAnRZJa4M=
X-Received: by 2002:a05:690c:806:b0:615:a86:f77b with SMTP id
 bx6-20020a05690c080600b006150a86f77bmr17004751ywb.26.1713371581352; 
 Wed, 17 Apr 2024 09:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFWBHnRxh2hA+SlgG4N1eWtpb8iK4SSNT2DdI4GBC2RFnW/05hNlWLBAZ5iWrJP6D9ZXFJ+NZ1u5DYMaE0RVE=
X-Received: by 2002:a05:690c:806:b0:615:a86:f77b with SMTP id
 bx6-20020a05690c080600b006150a86f77bmr17004733ywb.26.1713371581007; Wed, 17
 Apr 2024 09:33:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240329153155.17840-1-aidan_leuck@selinc.com>
 <LV8PR22MB4551BA53C529BBFB006CF581E3082@LV8PR22MB4551.namprd22.prod.outlook.com>
In-Reply-To: <LV8PR22MB4551BA53C529BBFB006CF581E3082@LV8PR22MB4551.namprd22.prod.outlook.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 17 Apr 2024 19:32:50 +0300
Message-ID: <CAPMcbCrh8=gfOipGF+z_yHt_tng4KcqBaGoYH_jcFpVoU2n-8w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Implement SSH commands in QEMU GA for Windows
To: Aidan Leuck <aidan_leuck@selinc.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "philmd@linaro.org" <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000745fd406164d6814"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

--000000000000745fd406164d6814
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi Aidan,

Thank you for these patches. Currently, I don't have any comments.
I asked QE from my team to test this patch and wait for feedback.
Also, QEMU is in the code freeze stage now, so I plan to merge all QGA
patches after release.

Best Regards,
Konstantin Kostiuk.


On Tue, Apr 16, 2024 at 5:46=E2=80=AFPM Aidan Leuck <aidan_leuck@selinc.com=
> wrote:

> Hello Konstantin,
>
> Is there anything you would like to see addresses in this patch before it
> merges? This patch has been up for a bit and there hasn't been any activi=
ty
> in a while. Our team is motivated to get this merged, so let me know if
> there is anything I can do on my end to make the review easier for you. I
> understand as a maintainer your position is voluntary and unpaid so if yo=
u
> just haven't had time to look it over and validate it, I completely
> understand.
>
> Thank you,
> Aidan Leuck
>
> -----Original Message-----
> From: aidan_leuck@selinc.com <aidan_leuck@selinc.com>
> Sent: Friday, March 29, 2024 9:32 AM
> To: qemu-devel@nongnu.org
> Cc: kkostiuk@redhat.com; philmd@linaro.org; Aidan Leuck <
> aidan_leuck@selinc.com>
> Subject: [PATCH v6 0/2] Implement SSH commands in QEMU GA for Windows
>
> From: aidaleuc <aidan_leuck@selinc.com>
>
> This patch aims to implement guest-ssh-add-authorized-keys,
> guest-ssh-remove-authorized-keys, and guest-ssh-get-authorized-keys for
> Windows. This PR is based on Microsoft's OpenSSH implementation
> https://github.com/PowerShell/Win32-OpenSSH. The guest agents will
> support Kubevirt and allow guest agent propagation to be used to
> dynamically inject SSH keys.
>
> https://kubevirt.io/user-guide/virtual_machines/accessing_virtual_machine=
s/#dynamic-ssh-public-key-injection-via-qemu-guest-agent
>
> Changes since v5
> * Fixed spurious formatting
>
> Changes since v4
> * Moved qapi/error.h to commands-common-ssh.c
> * Changed <qga-qapi-types.h> to "qapi/qapi-builtin-types.h"
> * Removed stbool.h from commands-common-ssh.h
>
> Changes since v3
> * Renamed commands-ssh-core.c/h to commands-common-ssh.c/h
> * Fixed styling errors discovered by checkpatch.pl
> * Moved some header includes to the commands-common-ssh.h
>
> Changes since v2
> * Set indent to 4 spaces
> * Moved all comments to C style comments
> * Fixed a segfault bug in get_user_info function related to non zeroed
> memory when a user did not exist.
> * Used g_new0 instead of g_malloc where applicable
> * Modified newlines in qapi-schema.json
> * Added newlines at the end of all files
> * GError functions now use g_autoptr instead of being freed manually.
> * Refactored get_ssh_folder to remove goto error statement
> * Fixed uninitialized variable pgDataW
> * Modified patch order so that the generalization patch is the first patc=
h
> * Removed unnecssary ZeroMemory calls
>
> Changes since v1
> * Fixed styling errors
> * Moved from wcstombs to g_utf functions
> * Removed unnecessary if checks on calls to free
> * Fixed copyright headers
> * Refactored create_acl functions into base function, admin function and
> user function
> * Removed unused user count function
> * Split up refactor of existing code into a separate patch
>
> aidaleuc (2):
>   Refactor common functions between POSIX and Windows implementation
>   Implement SSH commands in QEMU GA for Windows
>
>  qga/commands-common-ssh.c  |  50 +++
>  qga/commands-common-ssh.h  |  10 +
>  qga/commands-posix-ssh.c   |  47 +--
>  qga/commands-windows-ssh.c | 789 +++++++++++++++++++++++++++++++++++++
>  qga/commands-windows-ssh.h |  26 ++
>  qga/meson.build            |  12 +-
>  qga/qapi-schema.json       |  17 +-
>  7 files changed, 893 insertions(+), 58 deletions(-)  create mode 100644
> qga/commands-common-ssh.c  create mode 100644 qga/commands-common-ssh.h
> create mode 100644 qga/commands-windows-ssh.c  create mode 100644
> qga/commands-windows-ssh.h
>
> --
> 2.34.1
>
>

--000000000000745fd406164d6814
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>=C2=A0Hi Aidan,</div><div><br></div><div>Thank you fo=
r these patches. Currently, I don&#39;t have any comments.</div>I asked QE =
from my team to test this patch and wait for feedback.<div>Also, QEMU is in=
 the code freeze stage now, so I plan to merge all QGA</div><div>patches af=
ter release. <br></div><div><br></div><div><div><div><div><div><div><div di=
r=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div=
 dir=3D"ltr"><div>Best Regards,</div><div>Konstantin Kostiuk.</div></div></=
div></div><br></div></div></div></div></div></div><br><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 16, 2024 at 5:46=E2=
=80=AFPM Aidan Leuck &lt;<a href=3D"mailto:aidan_leuck@selinc.com">aidan_le=
uck@selinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hello Konstantin, <br>
<br>
Is there anything you would like to see addresses in this patch before it m=
erges? This patch has been up for a bit and there hasn&#39;t been any activ=
ity in a while. Our team is motivated to get this merged, so let me know if=
 there is anything I can do on my end to make the review easier for you. I =
understand as a maintainer your position is voluntary and unpaid so if you =
just haven&#39;t had time to look it over and validate it, I completely und=
erstand. <br>
<br>
Thank you,<br>
Aidan Leuck<br>
<br>
-----Original Message-----<br>
From: <a href=3D"mailto:aidan_leuck@selinc.com" target=3D"_blank">aidan_leu=
ck@selinc.com</a> &lt;<a href=3D"mailto:aidan_leuck@selinc.com" target=3D"_=
blank">aidan_leuck@selinc.com</a>&gt; <br>
Sent: Friday, March 29, 2024 9:32 AM<br>
To: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
Cc: <a href=3D"mailto:kkostiuk@redhat.com" target=3D"_blank">kkostiuk@redha=
t.com</a>; <a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@li=
naro.org</a>; Aidan Leuck &lt;<a href=3D"mailto:aidan_leuck@selinc.com" tar=
get=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br>
Subject: [PATCH v6 0/2] Implement SSH commands in QEMU GA for Windows<br>
<br>
From: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@selinc.com" target=3D"_bla=
nk">aidan_leuck@selinc.com</a>&gt;<br>
<br>
This patch aims to implement guest-ssh-add-authorized-keys, guest-ssh-remov=
e-authorized-keys, and guest-ssh-get-authorized-keys for Windows. This PR i=
s based on Microsoft&#39;s OpenSSH implementation <a href=3D"https://github=
.com/PowerShell/Win32-OpenSSH" rel=3D"noreferrer" target=3D"_blank">https:/=
/github.com/PowerShell/Win32-OpenSSH</a>. The guest agents will support Kub=
evirt and allow guest agent propagation to be used to dynamically inject SS=
H keys. <br>
<a href=3D"https://kubevirt.io/user-guide/virtual_machines/accessing_virtua=
l_machines/#dynamic-ssh-public-key-injection-via-qemu-guest-agent" rel=3D"n=
oreferrer" target=3D"_blank">https://kubevirt.io/user-guide/virtual_machine=
s/accessing_virtual_machines/#dynamic-ssh-public-key-injection-via-qemu-gue=
st-agent</a><br>
<br>
Changes since v5<br>
* Fixed spurious formatting <br>
<br>
Changes since v4<br>
* Moved qapi/error.h to commands-common-ssh.c<br>
* Changed &lt;qga-qapi-types.h&gt; to &quot;qapi/qapi-builtin-types.h&quot;=
 <br>
* Removed stbool.h from commands-common-ssh.h<br>
<br>
Changes since v3<br>
* Renamed commands-ssh-core.c/h to commands-common-ssh.c/h<br>
* Fixed styling errors discovered by <a href=3D"http://checkpatch.pl" rel=
=3D"noreferrer" target=3D"_blank">checkpatch.pl</a><br>
* Moved some header includes to the commands-common-ssh.h<br>
<br>
Changes since v2<br>
* Set indent to 4 spaces<br>
* Moved all comments to C style comments<br>
* Fixed a segfault bug in get_user_info function related to non zeroed memo=
ry when a user did not exist.<br>
* Used g_new0 instead of g_malloc where applicable<br>
* Modified newlines in qapi-schema.json<br>
* Added newlines at the end of all files<br>
* GError functions now use g_autoptr instead of being freed manually.<br>
* Refactored get_ssh_folder to remove goto error statement<br>
* Fixed uninitialized variable pgDataW<br>
* Modified patch order so that the generalization patch is the first patch<=
br>
* Removed unnecssary ZeroMemory calls<br>
<br>
Changes since v1<br>
* Fixed styling errors<br>
* Moved from wcstombs to g_utf functions<br>
* Removed unnecessary if checks on calls to free<br>
* Fixed copyright headers<br>
* Refactored create_acl functions into base function, admin function and us=
er function<br>
* Removed unused user count function<br>
* Split up refactor of existing code into a separate patch<br>
<br>
aidaleuc (2):<br>
=C2=A0 Refactor common functions between POSIX and Windows implementation<b=
r>
=C2=A0 Implement SSH commands in QEMU GA for Windows<br>
<br>
=C2=A0qga/commands-common-ssh.c=C2=A0 |=C2=A0 50 +++<br>
=C2=A0qga/commands-common-ssh.h=C2=A0 |=C2=A0 10 +<br>
=C2=A0qga/commands-posix-ssh.c=C2=A0 =C2=A0|=C2=A0 47 +--<br>
=C2=A0qga/commands-windows-ssh.c | 789 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-windows-ssh.h |=C2=A0 26 ++<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 12 +=
-<br>
=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +-<br>
=C2=A07 files changed, 893 insertions(+), 58 deletions(-)=C2=A0 create mode=
 100644 qga/commands-common-ssh.c=C2=A0 create mode 100644 qga/commands-com=
mon-ssh.h=C2=A0 create mode 100644 qga/commands-windows-ssh.c=C2=A0 create =
mode 100644 qga/commands-windows-ssh.h<br>
<br>
--<br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000745fd406164d6814--


