Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 354E3C3DA49
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jul 2024 15:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sY5RH-0006Aa-HA; Sun, 28 Jul 2024 11:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qeed.quan@gmail.com>)
 id 1sY5NE-0005Qo-F8
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 10:59:49 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <qeed.quan@gmail.com>)
 id 1sY5NC-000807-Om
 for qemu-devel@nongnu.org; Sun, 28 Jul 2024 10:59:48 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a1337cfbb5so4948635a12.3
 for <qemu-devel@nongnu.org>; Sun, 28 Jul 2024 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722178784; x=1722783584; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QdEHwVGWhkUMNUBuntPhTADTGO7dhmSVAJ5TB9yRQb0=;
 b=RCz6jc6sw4PinjRVbDSGu84uOpma+ErLKDNlIh9JF3wpZkur+rJKRhjQtyNdVLr4I2
 50koiBLzUsAVU7N4I+tdSUZHvYC7qLeS8GXsY76RfhOtBZVl+FD0XWkrFT88+dkltNH8
 RXjDXCoUDroaVUar6hs9NZxcf3NQz5sIwPWlmXmdNTrFgE+dNczE9S3Y/tB2L1IGD+8T
 xiRLZ+e6Bj1vFzqzAgGomweria8KHJykevgdXgT3+yO00ldHwxwuu/5rhCmhNNIcR4bD
 NmLcLjR+p13dGSAG9ZE6r3Q9/66Z6CqodH2Xs9/qYkwIwrMrEhzPDzbRjNduhAKGFdFo
 xm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722178784; x=1722783584;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QdEHwVGWhkUMNUBuntPhTADTGO7dhmSVAJ5TB9yRQb0=;
 b=B4O8WltnkM/RQBSFuAZlUEHi1yJliHoe0DOWjCvnqSVcd9mO0CMnGYbDQnvGiksLS7
 hdRJHvGXP2uvXGaQIZ5BNqq2FVkUL7u7ZrCqCf8vCEf4yzegTNsbN4XnPK2gGZsNWK00
 PCElqi5n49tWEE8ZjWa6hxpFuwyng5y8SZ1wWM8XR+asKp7psgdtimK2cuI5cgfq3f4+
 HRyEiRUtybdN5OhiToCygbGjzuKneT+VQYg5P3F2GQphHyRyv/l+9CK4h3h5xPmJLUcx
 VHZRcenA1xmxnB5a2w6pjZsYS7Dgb5+pSd0Tdep2o1rzZdNrECagg2wSNSDAQ9f8hojk
 PYmA==
X-Gm-Message-State: AOJu0YzLtFu6XiISMRt47oqezqpmVuI8P8QBqh5hO9oTxnb7sy8SOIMh
 SO0XBbb/MZhjn+x9739iAUgFEznkkrrUr1/ovfNdXOon313togmOLeehwOEX42eOdBEA1H9oqxk
 FtQKuXxj7lueW7xnkNcZ/tgKPpsnzv3uZ
X-Google-Smtp-Source: AGHT+IEElpgth1UglKdOEEXkSO4Kypvr+smkKUMqZ9g8oqBo70uipqnVZKUW/KNEBGJHc9S15p2aboD3JRzoVWGDHf8=
X-Received: by 2002:a05:6402:3595:b0:5a2:a0d9:c1a2 with SMTP id
 4fb4d7f45d1cf-5b021f0cebemr3606248a12.26.1722178784294; Sun, 28 Jul 2024
 07:59:44 -0700 (PDT)
MIME-Version: 1.0
From: quan <qeed.quan@gmail.com>
Date: Sun, 28 Jul 2024 09:59:33 -0500
Message-ID: <CACUh7aGriKAtKtUW5c1X2ipy4RX0Mt_gwwfdQRC94EZNvE89jg@mail.gmail.com>
Subject: Using parallel port on the Pegasos 2
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, philmd@linaro.org
Content-Type: multipart/alternative; boundary="000000000000ad8243061e4ffea0"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=qeed.quan@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 28 Jul 2024 11:03:52 -0400
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

--000000000000ad8243061e4ffea0
Content-Type: text/plain; charset="UTF-8"

I am playing around with the parallel port on the pegasos 2 and I noticed
the following issue:
The parallel port on startup is set to iobase 0x378, then later it gets
remapped to iobase 0x3bc.
When I tried writing to the 0x3bc location with
trace:memory_region_ops_write on, I get logs about writing to the location
'parallel', so far so good, but the writes don't make it through (it never
calls parallel_ioport_write* functions)

I traced it through where it calls portio_write, and inside the
portio_write code:
This line always fails for me:
 const MemoryRegionPortio *mrp = find_portio(mrpio, addr, size, true);
This is due to the mrpio has the offset of 0x44 (0x3bc-0x378) in the list,
and the 'addr' in the code ranges from (0-15) (address relative to 0x3bc),
so it can never match the parallel io function to execute.

This seems like a bug to me. I think there is some issue where the
portio_list is not getting updated properly after the remapping to 0x3bc.

The other devices (Serial, RTC, PM, VGA) responds properly for me, so it is
only the parallel port that has this issue.

Quan

--000000000000ad8243061e4ffea0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am playing around with the parallel port on the pegasos =
2 and I noticed the following issue:<div>The parallel port on startup is se=
t to iobase 0x378, then later it gets remapped to iobase 0x3bc.</div><div>W=
hen I tried writing to the 0x3bc location with trace:memory_region_ops_writ=
e on, I get logs about writing to the location &#39;parallel&#39;, so far s=
o good, but the writes don&#39;t make it through (it never calls parallel_i=
oport_write* functions)</div><div><br></div><div>I traced it through where =
it calls portio_write, and inside the portio_write code:</div><div>This lin=
e always fails for me:</div><div>=C2=A0const MemoryRegionPortio *mrp =3D fi=
nd_portio(mrpio, addr, size, true);<br></div><div>This is due to the mrpio =
has the offset of 0x44 (0x3bc-0x378) in the list, and the &#39;addr&#39; in=
 the code ranges from (0-15) (address relative to 0x3bc), so it can never m=
atch the parallel io function to execute.</div><div><br></div><div>This see=
ms like a bug to me. I think there is some issue where the portio_list is n=
ot getting updated properly after the remapping to 0x3bc.</div><div><br></d=
iv><div>The other devices (Serial, RTC, PM, VGA) responds properly for me, =
so it is only the parallel port that has this issue.<br><br>Quan</div></div=
>

--000000000000ad8243061e4ffea0--

