Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B69BFD0045
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 23:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwTKF-00035d-Fz; Sat, 28 Feb 2026 18:02:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alberto10pumas@gmail.com>)
 id 1vwTKE-00035P-0O
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 18:02:18 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alberto10pumas@gmail.com>)
 id 1vwTKC-00068I-9C
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 18:02:17 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-386b553c70eso46972191fa.0
 for <qemu-devel@nongnu.org>; Sat, 28 Feb 2026 15:02:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772319734; cv=none;
 d=google.com; s=arc-20240605;
 b=KzhsOitx3hF89LzB+gM/q1Tcx36m7l0KUxQ3cpG75rFWYFu/YH1st/KG6n0CV/CM7h
 pkyJG6YmQsdzvSwdCR2b/40IK5p6eap2LSHtFDUo68+ID16/hwzEABt6zZ6ARpMCTIwa
 upgVVC9FrZiHqc9g9XJnp86jM/QYq3MeN+uk9bFqSKXxkiHkqyGBS6YHNMJrBAh6nwrh
 hkRJv5HBlohq9RaId2Zx+WigXetv2O7I5hTvgq+YxSBntzWCrpDOYqxR/I1y4NoptxVO
 pHSH5WDih28FZPFLv389FyeSndOUwfGKmlT/5leH09Yocl1LxmdCxJigaacR47CgMRsT
 a7Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=lF4ZEx54Ieal5oRvXB49KsMbBMYW64s4wlmnPT//q1c=;
 fh=3vh/zEc2LchxTGmvN5Zmj1ueGz1+WUScTrY7YTQh89g=;
 b=JJIpuj9Vc6UqoRKYfi1moqKjk6O8aGcEPjfkJdx8aLeytBqE7EfqUFht0EkYY+SDhD
 ijH1tz/QDX+QPjwjEVr/ev3ql+7u1+Q0hLqYFUq6YGoGIxO2KVx67CcqIh+hQVMBR6st
 IFIPwK/M7M9K0FM7yi7uR8XQU/wztbkV7Qe6qVStqSLx6Mti8eT3v48ZGUidcifOIqFI
 1z3F803vC8Ri25SVYoLLTuwP2fjAPpEYTQR79QmhcfbKXnMR1cZQsx+QTjceLiPdRAvA
 hw373gL7UEGS0a+XANoxHGVMbHy+yn+01hFuTweaMyrDnL0KY5EUpKWKTMk6Zu31q8fu
 bT7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772319734; x=1772924534; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lF4ZEx54Ieal5oRvXB49KsMbBMYW64s4wlmnPT//q1c=;
 b=KTkRxSfxXB99z2je3i0Jw4mmtJ3iZZyZucCIGVMalYxuwQOVjKqaYIBl8BpNpj4hmd
 6sT9FaViYQlK0RicM34LRMoHF899WH/coE/8H7EE07cEQq+5yN/lqK9IFY41JLH77Niw
 hvYK3v8z6MAakbOd2AUMFiDtNzUqUZcUX++IXYw1QYzP3ZhNtk+fcdT1SohaL016HqSV
 9AprfwGOlQH7cN3obxFa6YsSj1BVRs9xcuVMaqGzfEkVgMFuyn9Dx77qaDAPy3QdpKoi
 +nARLp35h72FBP567xmABHePsOSwjVPau4UeAUaVO44JTsuWZFWRTueJCPyKYQNKvtWc
 tVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772319734; x=1772924534;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lF4ZEx54Ieal5oRvXB49KsMbBMYW64s4wlmnPT//q1c=;
 b=oyNM100R1IY2YvR7p7oiJyRW3snJOATz0bsZLZtt6dKROSDXHWyfmRSCBF1j5wqb15
 vVdjcExWZWsFMq7ARL3KaemApjxrpUKs/pwo3sOTWolD7ea5lNkf7ZQBCZ6IAssHtsC6
 NzwZCtLxcpD0Uwc7hwHdHm9uWE8grtCqS8Ee4aJxS1u7gOkPtLOTgFi83YZpv14CxuFI
 B0pubKctV0n5r3v1gHHkdqlFgAXiYfs+YqBajLgg0zPy2nj/vKZoI34pWjnDIZ4gemcC
 +dhnslE4KMzP3EB0CO1Qdw/GZi2CG1dHwKepmw6Rs0x26/JN9blnTLAqAw5yfkFQWoaC
 SKvw==
X-Gm-Message-State: AOJu0Yxg3CU+0qtmABAoAdapRHySL6320nTgX8MwdiWZ8FPrwNeKt+pD
 ycYUXf1dsA/Eey/ThCC4oxLYLvNLpUwhYUYxyQmctzTJrmyynVt8KD4L7w479aUvGKZ4Z00s0r9
 uXR9FO7fzWZW5e2/R5HkCDW+WQ+pM5hM=
X-Gm-Gg: ATEYQzzQO/9REbdqqCqGwwMZbXA98FSOz9JeqYENQiWjZ2U+jCHEwiixVPQYBY9yX+u
 KsnIwy/0jUcSY3MxYY0Ni5B836UOp0+V8GijFKkFKWDPTEGskA26so//ySU6EmyQ+1UI0/19pTQ
 6ZDCsJiMC9GXS/cNehU66iQzQf0XxcoRM2IZUfgKU9MvAFGGQ5kYFCPpwE/mevT/sMVM0kKMMQA
 uQP1CQZZZVgGf2z+DTVjUgQ9ackXaitX9JZtJewk0n0QzSWWS48l0O8Gm5Lxlm93cqHpsZ5lRKY
 u8Y8A2w0oOcKMpiEDRKE
X-Received: by 2002:a2e:bc18:0:b0:38a:615:7d9f with SMTP id
 38308e7fff4ca-38a0615802emr30408301fa.38.1772319733320; Sat, 28 Feb 2026
 15:02:13 -0800 (PST)
MIME-Version: 1.0
From: Alberto Hernandez Cardenas <alberto10pumas@gmail.com>
Date: Sat, 28 Feb 2026 17:02:02 -0600
X-Gm-Features: AaiRm50W_H1-Rt0hbSg8RFwjQqcfApoGcA2TBdjpj0wfzjS5ho6_o7z9EoID1ag
Message-ID: <CAHLkteN0M6RXMsCwEWdaXdf26jDc49caYCQaOSjBqJUGNY0MhA@mail.gmail.com>
Subject: GSoC 2026 Interest - virtio-rtc vhost-user device - Alberto H.
To: mvaralar@redhat.com, francesco@valla.it, garzare@redhat.com
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, alex.bennee@linaro.org
Content-Type: multipart/alternative; boundary="000000000000220ee4064bea5807"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alberto10pumas@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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

--000000000000220ee4064bea5807
Content-Type: text/plain; charset="UTF-8"

Hi Mentors and QEMU community,

My name is Alberto, I am a computer engineering student from Mexico
(UPIICSA). I want to participate in GSoC 2026 with QEMU.

I already installed Fedora 43 and I compiled QEMU from source successfully.
I am studying the code right now. I know C and I am learning Rust because I
want to help with the new components of the project.

I saw this issue on GitLab: *"Writing a large amount of data to the
virtio-serial chardev device causes the channel to become blocked"* issue
#3251 <https://gitlab.com/qemu-project/qemu/-/issues/3251>.

I am very interested in this problem. I want to understand why
vsc->have_data is causing a blockage. I think this is a good way for me to
learn how QEMU works with devices.

I have some questions:

   -

   Is someone working on this issue right now?
   -

   Can I try to solve this as a "test task" for my GSoC proposal?
   -

   Do you have any other small tasks or "Bite Sized" issues for a new
   student like me?

I am very happy to learn and contribute to QEMU. Thank you for your time!

Best regards,

Alberto Hernandez Cardenas. (Nickname: betillo)
GitLab: alberto10pumas@gmail.com

--000000000000220ee4064bea5807
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p>Hi Mentors and QEMU community,</p><p>My name is Alberto=
, I am a computer engineering student from Mexico (UPIICSA). I want to part=
icipate in GSoC 2026 with QEMU.</p><p>I already installed Fedora 43 and I c=
ompiled QEMU from source successfully. I am studying the code right now. I =
know C and I am learning Rust because I want to help with the new component=
s of the project.</p><p>I saw this issue on GitLab: <b>&quot;Writing a larg=
e amount of data to the virtio-serial chardev device causes the channel to =
become blocked&quot;</b>=C2=A0issue=C2=A0<a href=3D"https://gitlab.com/qemu=
-project/qemu/-/issues/3251" class=3D"gmail-router-link-exact-active gmail-=
router-link-active"><span class=3D"gmail-gl-align-middle">#3251</span></a>.=
</p><p>I am very interested in this problem. I want to understand why <code=
>vsc-&gt;have_data</code> is causing a blockage. I think this is a good way=
 for me to learn how QEMU works with devices.</p><p>I have some questions:<=
/p><ul><li><p>Is someone working on this issue right now?</p></li><li><p>Ca=
n I try to solve this as a &quot;test task&quot; for my GSoC proposal?</p><=
/li><li><p>Do you have any other small tasks or &quot;Bite Sized&quot; issu=
es for a new student like me?</p></li></ul><p>I am very happy to learn and =
contribute to QEMU. Thank you for your time!</p><p>Best regards,</p><p>Albe=
rto Hernandez Cardenas. (Nickname: betillo)=C2=A0<br>GitLab: <a href=3D"mai=
lto:alberto10pumas@gmail.com">alberto10pumas@gmail.com</a></p></div>

--000000000000220ee4064bea5807--

