Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75279E9D826
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 23:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9WWJ-0004jn-FZ; Sun, 05 Apr 2026 19:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adeoluwaademoye@gmail.com>)
 id 1w9WWH-0004ix-V6
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:04:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <adeoluwaademoye@gmail.com>)
 id 1w9WWG-0008RP-Dw
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 19:04:41 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dbc4f2ad7bso215416a34.0
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 16:04:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775430277; cv=none;
 d=google.com; s=arc-20240605;
 b=BLaVKQGRZxpSm/Jt7GkjVkbJbWRJ3z82gjtEKTTY6Wq5PbKzop5w+5MVwfmBylby7g
 8jOS73pfOINNm9l6/YEAKvuQBhfDUP1Q7+pD0b0C7RYKa05IAI2oS5hDCuxdwiiho4Dy
 ykWixqWQkteLnrdEfoq/sKn0ihuWcMNhoBkEUNkbqm2fh5p0IvbjFY909AS4yxY6IGHL
 iunFYHHN/sYiy9CrChI6LuzxzEQ2XiS9TbXF64fxRgsCjumTfatAyd4NzAkFPxHfMtvi
 eUZxzG6n2I9PP9M+ZKeMotkPXea8p89n/KrI9DY7WLHUPvu8aPy8FsFF7L4IJLuFpKzs
 kwfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=VDnxGvJOyBI2mktZL5tVn6AG/Km8+01t+klSWX4VUpU=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=RU0T7ZW0oK41KyujorxFzW0PrOO4klFKetb0B/uq3dHmLpk/n4p5Mp+n96hKb3JzuK
 u24EBkNOp682sEUUYOlhEJhK+p3K2uZljBz2NL5R7HOx6NJIdqxMKXZ8wWjQYJVPlYKC
 aX4CGESC5GadYjxsB3HcxjSgizH5k3Yfxu4FJ9kUNBxGbjLvyBEk5n4P5nQfSuhGJBIF
 jW+mMQgyebDSBcY89QBpDCIXFqfftU7ZFz0temLsRaMwKGLLLpk40M2FpQbUsHWZPF4N
 Nb7amHeN2+V6YOhzf3R7S9oL9eNJvuE6zBUX18msp7bN/BRURg7Q/geW69oeQCctlA2+
 LVKA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775430277; x=1776035077; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VDnxGvJOyBI2mktZL5tVn6AG/Km8+01t+klSWX4VUpU=;
 b=mS+rNnVzy/PsRA3n6Vq8+T6ftX87lAfQM+04bShIcIRDZqkpbyEzmxFLXR84Ipf6Fa
 EgrV4H5t3IVR2w2gk3pMWCta3N2HMaVvTwFJFIcQ87YX7Rblb3OzA2g+262+4oh9U60k
 qd6UqmAYjYrw5bDRznuaILImwifc4Gen6BPNoEpwMKOXHio7ybIznGoQkKxtkgSm8gNV
 tEgg7JY27PoooJ6Jg8PuCbAAX6oBF9q4PkU0Cyu809UD2KSNvToFgz0Vwey2j2V0887V
 tX05MpfGF7J9tWw76VHgWoukyTgJNoL/usj5g3mDHGk93gyvSnKbryNEKIX0N3YsZozz
 8EIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775430277; x=1776035077;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDnxGvJOyBI2mktZL5tVn6AG/Km8+01t+klSWX4VUpU=;
 b=MvCke66b4bncJte9Nw0sYfdYLXWk/kcQ7+3IWrPuk2jmTSNJf7ycuNfkB8Ip6nb0cl
 8lUiTsKu3xTK+DNK6s3Qh/yDWxT/hIDHIkeuwCKeFEqxPn1hC0HoNgPApzsH18TQN3dt
 QcC5JsTDwBkX7RZCrPMUbd6bkMIuGf0+ruBc644SdmxLfXcKDfZpSTMqEFIKAo5TqYXu
 n1tuSic4CTHG0TVVA450ZDsq0/tYq4XkdqPUh7uR4WW9l1CgskGtz0ltt42909ondyS7
 CIl0t87HdoukwBZP6FQEwrS+trXirCf+1A6U6xgdkk7fy//ghhR/0Nmkhg+PAwbrpOEp
 vIHw==
X-Gm-Message-State: AOJu0YzyeH8fwrzUxHOAxKzb9cr8HNeegOt97sh2uCYSeltLBn88nKSw
 xMh1ydoJq7S8XCM7qlvQICqKpHYT+eAYsFEIU6YG1xlelU4RAPCnl6TSCnAQF05hA86A69Dh+mj
 Qz/i/VSus8UfAT2ra8GDCr8ER631kHwcbB3+rMibqsVvV
X-Gm-Gg: AeBDieuNLmAcbcgq6NhGRF7WkaFGAELoGrquQX8zIrzuD0zHYpfGXCdu3foO3UV/HgT
 UnM+2fwg+o4g8iYosZtQc2aEX7XIZZhrrBIPv3kGK4GY3HFI2+/kulrzhw1ZwGcRayWCzGwNpHt
 rkiUlInfWtR7J6luZmXJglRmYQElHjdBSFJMLIHrFzOK8lM0Ctpu0nmSCLTmZcP9mRGgKUJjz/+
 3mdJQp0ya/26fIMRGacT+BzVxfxwD+0isEMF0we7r/tPrGgV24KpTwqLb9Ev/JvsuRruHVmRqrj
 LSdyzgyi
X-Received: by 2002:a05:6830:4ac5:b0:7db:e661:bb52 with SMTP id
 46e09a7af769-7dbe661c648mr578431a34.4.1775430276954; Sun, 05 Apr 2026
 16:04:36 -0700 (PDT)
MIME-Version: 1.0
From: Adeoluwa Ademoye <adeoluwaademoye@gmail.com>
Date: Mon, 6 Apr 2026 00:04:25 +0100
X-Gm-Features: AQROBzDIfKXJv7c7eORSlrLG8ZGhrqkwOCdxqX7cbHipayXInzaEmImyF4kpDj8
Message-ID: <CAPxx-NymyR=iJ9CpdccOep=gO=L8gzjuTytXZ2DhGBhXpttSmg@mail.gmail.com>
Subject: [Newcomer] Introduction and seeking guidance on TCG / memory
 architecture
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000fb3dab064ebe926b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=adeoluwaademoye@gmail.com; helo=mail-ot1-x32b.google.com
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

--000000000000fb3dab064ebe926b
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I am an engineering student with a focus on systems programming and
low-level execution. To build foundational knowledge, I recently wrote a
stack-based virtual machine from scratch in C, implementing a dynamic type
system with runtime type dispatch, raw bytecode execution, and manual
memory ownership across the entire object graph.

I am now looking to channel that into real open source contribution, and
QEMU is where I want to start. The TCG subsystem and memory translation
layer are the areas that interest me most.

Before I dive into the codebase, could anyone point me toward the right
documentation or entry-level issues in the TCG or memory subsystem? I want
to make sure I am orientating myself correctly from the start.

Thank you for your time.

Best regards,
Daniel

--000000000000fb3dab064ebe926b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>Hi everyone,<br><br>I am an engineering student with a=
 focus on systems programming and low-level execution. To build foundationa=
l knowledge, I recently wrote a stack-based virtual machine from scratch in=
 C, implementing a dynamic type system with runtime type dispatch, raw byte=
code execution, and manual memory ownership across the entire object graph.=
<br><br>I am now looking to channel that into real open source contribution=
, and QEMU is where I want to start. The TCG subsystem and memory translati=
on layer are the areas that interest me most.<br><br>Before I dive into the=
 codebase, could anyone point me toward the right documentation or entry-le=
vel issues in the TCG or memory subsystem? I want to make sure I am orienta=
ting myself correctly from the start.<br><br>Thank you for your time.<br><b=
r>Best regards,<br>Daniel</div>

--000000000000fb3dab064ebe926b--

