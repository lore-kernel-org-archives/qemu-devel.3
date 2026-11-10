Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8B2606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MC7k8vkD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQmeu-0000RW-Sp; Tue, 10 Nov 2026 09:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stephane.gonzalez.contact@gmail.com>)
 id 1xQlzJ-0005u4-K7
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:34:13 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stephane.gonzalez.contact@gmail.com>)
 id 1xQlzH-0005hm-MT
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:34:13 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6b429f71dbeso2184743a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 05:34:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794317649; cv=none;
 d=google.com; s=arc-20260327;
 b=gxlELWMBPl2CdmDRySlcl0XtOv1zG5OBvh+5LZbyYAPGVbOiAptCf5b9eMthzqwtOy
 EbtSxVCFsKas+rjxbiD4EgEXHDuXTs90Tc1ZCS8PJOYiWqeilL4q0dkVuAd1D4mWKafK
 Y5QCk6PXGq2CcaAYRLuUXYhFs2TctH1fFoiwGuAxPEh8yZr2tOK3kX8d3hSrou0ADOYj
 CLfKqSCQOkT2bu0PtnREJW6jEinVkFyrtdvFgm9UWLL4YhA7uufkUeiJijONbwI3jFiz
 gGr2Y1A7gLZBPEpK7WtaJl3v7cefoss1NUdXXnpazt80xmSO7/AV301n/twzpXhurctE
 kkjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=uQ5RLJBrcXBvHl2AJLJZLa7xLMXxvPeoNJndGPvLU38=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=aNxkWa7XmI/Fmfh2icbM1t4FixkxECC8G6wSPvo99Cd6XeNiylDE57TL1NWi1sEle6
 bLVu2Pjp7y6rAPv7rW2we3M0TmLj4nf5S5clobVMxGCRTe/iQKslopnNclNCFO3Z6UnV
 f1VDON2OSKrUnszY2+5dX8/fYEtGrm6IYMxQ5aybUr+vhnrHJRrniNUt8iOp9aI8+5Hx
 0xAP12Cc/gogjcsUUJBJCpt2V9w0dUstyDwAux0+SnPZyMIJhzPYP7aoQIX/bKWoiqRN
 0HSfdG+gpOzyV6UXrJ9yiMFyORBAbrKdE83JfDG1ePMbgKyBj3EZc9pZhjkwByySTraB
 wbEA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794317649; x=1794922449; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uQ5RLJBrcXBvHl2AJLJZLa7xLMXxvPeoNJndGPvLU38=;
 b=MC7k8vkDuZGTnT4D66hZrVo90JT1uK/O1yQZfjQn8YxV/c6JcreOLalHeb+tJ4LaK/
 rVzU92Iyb6keZjCAnGJxMdnxklO9WtX2wZPt9wLiD6ubGp3i7/JKKo46G1xicNYtq9XW
 usfnd3CCzMry1qEb9VuMdqKx5lG067706v6oYIapjhfKANKEaYJlAhecklHZkve+FjfM
 232VtxxBEaxL0VDfwv3q+SnB1o1+20Kg8AnHGGBqReS4RLLXbyS+4Ju44/g1dU0RZ+ll
 IfrQVPGvlZpMx0DQ/jXvrsUEOiJx59nIdFrprqoMohyNvEtEjjL0MO6tVAiDLjsqVUvw
 CSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794317649; x=1794922449;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uQ5RLJBrcXBvHl2AJLJZLa7xLMXxvPeoNJndGPvLU38=;
 b=akc8zMAo8k4DWS5DnwQvYZItEve395IIb6FyM+j72St130ZKNkGhu3MifsoQ98QHC9
 HvUkKs1l/DutdiEjYyBoDSNYsy0se3zoAdBMlgoC6FvcDSqUEai1e6XjXyOAHMg/prau
 TXIvG4j+spsD6OAfSJQSNZBI2tODRh3rAeCgjob47LMsZm2tEfXd2S7vS5F78F7k2+uB
 +bOaautM4QDmCBqyfwFXUE1aRcmTYsb+KZDdFKoiu20T8uWjO4KUBkXXOsF+Bh+24QOM
 ja/N8Iyl+IgXGG9KxIz8jNKMy9tIPAvQRa+fT2RmDkMOveoXRpUBT8n1NGoKg5EMGU94
 SLVQ==
X-Gm-Message-State: APuU4Z+GaCQ/nOFPELittM1VQF68Hi0YyYJGYoSuzMXlAJQmRnBC3QJS
 jDlaUJAm37UDZmLHC753opQIaEklayYxHxVWHKcOFs84p7mtGQlx7tXPmy42g2AkOJCsOJLPVjA
 /4k1xJODsBXMVmlqXBsMalP/h2NOkRTplwNKrtydzyY/G
X-Gm-Gg: AYBFou1INwiZVG1pxJe0nAw9GxNTdZpWXNQyEwpU08ERxVd9KoE6C7zZgAuz0NMNIRe
 g/4rQhEmaANRHIpW+lNqo2WMaXsYWr3ITMzfS9s4qLXajrEnmplkhhw8AJ8e7zF9T01j2X83h7y
 vQA/wg5W/8qNqmitfZE9LEoIXT0KYRalYJAfNS10V5W8YW3D5QdTy0TFebzhC0k5HzERq2kZFFA
 rtLGW57Z2oWhgrj22J34blZUdLOmXnbjMOKHb2rdJqlkoey5mdNAEi2pgu/qQwtnQQ39bw85+ix
 V1j3VyMB6psBwX1j+YemLImeuRruAyNRX1IxwWDbc5y5aoc/KEOKXPVo0FcrH9udCEFagFxKLlb
 a/FyJ1BX3H2gwVgAgpm+26I28K6ZGLAjnEzO73+X7538rtq9uyBp6NQ==
X-Received: by 2002:a17:907:ecc7:b0:c31:e9b7:f10b with SMTP id
 a640c23a62f3a-c50495965a1mr213265066b.42.1794317649028; Tue, 10 Nov 2026
 05:34:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Stephane <stephane.gonzalez.contact@gmail.com>
Date: Tue, 10 Nov 2026 14:33:58 +0100
X-Gm-Features: AclHuK_5i6siH9tEAhV6o3BDPh0gnyRhwc5p0PRDX636jvIf0U5NSRi9Pfn3bT0
Message-ID: <CAANz6d6yaBtJP6sJzeoPVR4hF4H6eYhRn5z7ybY-F=DHBBsJTQ@mail.gmail.com>
Subject: [RFC] hw/sparc: GRSPW SpaceWire controller model for leon3_generic
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000015af47065fec2267"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=stephane.gonzalez.contact@gmail.com;
 helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 10 Nov 2026 09:17:11 -0500
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
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--00000000000015af47065fec2267
Content-Type: text/plain; charset="UTF-8"

Hello,

I have written a model of the Gaisler GRSPW SpaceWire controller for the
leon3_generic machine, and I would like to know whether it could be
welcome upstream, and how it should be shaped before I send patches.

What it does today (out of tree, on top of stable-11.0):

- four GRSPW cores, at 0x80000A00-0x80000D00 with IRQs 10-13, listed in
  the APB plug&play table (Gaisler device 0x1F)
- registers, DMA descriptors, interrupts and time codes, modelled on the
  GRIP documentation
- an RMAP target (ECSS-E-ST-50-52C) on cores 2 and 3, including the
  8-bit RMAP CRC that the DMA channel can append and check
- the stock RTEMS 6 grspw and grspw_pkt drivers run unmodified

It also needs the LEON forced cache miss ASI, which the RTEMS drivers use
to read their DMA descriptors. This is a small, independent change that
I could send first.

The use case is LEON3 flight software development and testing without
hardware: the other end of each SpaceWire link is a host program that
simulates the equipment connected to the on-board computer.

Code, documentation and an RTEMS test suite:
https://github.com/stephane-showroom/qemu-spacewire-for-leon3

I know the current version does not follow QEMU conventions. My plan
before posting a series is to:

- replace the POSIX message queues and the private thread with a
  chardev backend handled in the main loop
- use QEMU types, coding style, trace events and qemu_log_mask
- add VMState, a qtest test and documentation in docs/system
- split the work: forced cache miss ASI, GRSPW core, RMAP target,
  leon3_generic wiring, tests and docs

My questions:

1. Would a GRSPW model be accepted for leon3_generic?
2. Transport: one chardev per core, or a single chardev multiplexing the
   four links? I currently multiplex them, so that one host program can
   simulate the whole environment of the on-board computer.
3. Where should it live: hw/net, hw/misc, or next to the other GRLIB
   devices?
4. The RMAP target reads and writes guest memory directly. Is
   address_space_rw() on the system address space the right approach?

Any feedback is welcome.

Thanks,
Stephane GONZALEZ

--00000000000015af47065fec2267
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I have written a model of the Gaisler GRSPW =
SpaceWire controller for the<br>leon3_generic machine, and I would like to =
know whether it could be<br>welcome upstream, and how it should be shaped b=
efore I send patches.<br><br>What it does today (out of tree, on top of sta=
ble-11.0):<br><br>- four GRSPW cores, at 0x80000A00-0x80000D00 with IRQs 10=
-13, listed in<br>=C2=A0 the APB plug&amp;play table (Gaisler device 0x1F)<=
br>- registers, DMA descriptors, interrupts and time codes, modelled on the=
<br>=C2=A0 GRIP documentation<br>- an RMAP target (ECSS-E-ST-50-52C) on cor=
es 2 and 3, including the<br>=C2=A0 8-bit RMAP CRC that the DMA channel can=
 append and check<br>- the stock RTEMS 6 grspw and grspw_pkt drivers run un=
modified<br><br>It also needs the LEON forced cache miss ASI, which the RTE=
MS drivers use<br>to read their DMA descriptors. This is a small, independe=
nt change that<br>I could send first.<br><br>The use case is LEON3 flight s=
oftware development and testing without<br>hardware: the other end of each =
SpaceWire link is a host program that<br>simulates the equipment connected =
to the on-board computer.<br><br>Code, documentation and an RTEMS test suit=
e:<br><a href=3D"https://github.com/stephane-showroom/qemu-spacewire-for-le=
on3">https://github.com/stephane-showroom/qemu-spacewire-for-leon3</a><br><=
br>I know the current version does not follow QEMU conventions. My plan<br>=
before posting a series is to:<br><br>- replace the POSIX message queues an=
d the private thread with a<br>=C2=A0 chardev backend handled in the main l=
oop<br>- use QEMU types, coding style, trace events and qemu_log_mask<br>- =
add VMState, a qtest test and documentation in docs/system<br>- split the w=
ork: forced cache miss ASI, GRSPW core, RMAP target,<br>=C2=A0 leon3_generi=
c wiring, tests and docs<br><br>My questions:<br><br>1. Would a GRSPW model=
 be accepted for leon3_generic?<br>2. Transport: one chardev per core, or a=
 single chardev multiplexing the<br>=C2=A0 =C2=A0four links? I currently mu=
ltiplex them, so that one host program can<br>=C2=A0 =C2=A0simulate the who=
le environment of the on-board computer.<br>3. Where should it live: hw/net=
, hw/misc, or next to the other GRLIB<br>=C2=A0 =C2=A0devices?<br>4. The RM=
AP target reads and writes guest memory directly. Is<br>=C2=A0 =C2=A0addres=
s_space_rw() on the system address space the right approach?<br><br>Any fee=
dback is welcome.<br><br>Thanks,<br>Stephane GONZALEZ</div>

--00000000000015af47065fec2267--

