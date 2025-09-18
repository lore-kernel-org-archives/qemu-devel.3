Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 233C6CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 19:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzKBx-0006fL-4W; Thu, 18 Sep 2025 15:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzKBv-0006dI-Kz
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 15:21:15 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uzKBt-0001it-M5
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 15:21:15 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b07c081660aso232891566b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 12:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758223271; x=1758828071; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Hbc8XMQr4HmNl3+iCsqddA07FlLneSXGxCnZ8KS2I5g=;
 b=MRQ5j3uMtLAXBlPZqu6q/lz2tAV4gWP7kq28WmBteoLn2ChGEZdF0a2BN4BXCv/PY7
 r9Nn02NOHZGySdfYvahmAZN294QPnJhlR/B2EKXTwz9EjmyodvTszRWi4ERxVBqDcYtu
 ui7d7j/3/Mr/YQsnPbwlKY943TcGSYFjLbispKptZed0DbuVzJXPp7MlTWOZoQEUxvnC
 Q/QjHKIf4e3yAPe4IJkZWocV5/ARH0/FraKeuo/ygcQnB7Q+HGdLksaBPNJOWuPXDeVK
 jmN6P3ikUIP16ZMIzjXnGyran/0I3+b9Cj2UAM3bTSKxHKCIOJ0J3b2MsUxEM1T56rmm
 ZOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758223271; x=1758828071;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hbc8XMQr4HmNl3+iCsqddA07FlLneSXGxCnZ8KS2I5g=;
 b=g1JkY/4wxZPfPtTCn+PnqIZmVx9vrzskA42G9gX9XPYkGsUj6v1OEFGSz4TFKuGRMB
 3wqLI38gUI2O2GnGTi/Y/3HAHqcQH+zRIFv7tN0Z46mcYQX2asxdIATZ3yi/5wQjx9+o
 vIj758VUD3BbGbnjT93z+B2E5NQpPQoETeFFpdoSuhHqkozIlkcceZpGA6nygOrgDDuG
 7uAXGwBXpdhUcExg4trkh4+lw7w6xkuYZc4BSHWilRUqvH86ekyzG0Col+5uxoRPMzTH
 j5lvzE3sljLskXPD9+7f2KylV6agRXyTJAxm7TXKY6rBQC1CQuR0YnVGF3quG+Dn7mCJ
 hbDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC0Q4a1minBh90gSdPAt77VNty5Mh/4wO77zStTQd2XT004sHAe9rdYQmPyPVYaByN7P2lM7FY0S1k@nongnu.org
X-Gm-Message-State: AOJu0YxKSk/OwwyC5WBDu7SLBPXbNTou7SHSl3c0hrhqszEIPXvD09xK
 yA/LVyMgZilsPKOQE7zn0nfZBOOTfQoFQq5ZD1r20qSbiHrMyVXjFea+
X-Gm-Gg: ASbGncuqV3a6Pv1sohepTm3lAgQ8Dnf5DN5cMmKDErndrGXikMQNf+FqQWh352WZt2w
 99CnsuKH2nPir7hDfeSmU0ghhlWTg6cpj2IJkohHkMY7Pp3gXEnoPnFmkHi4ZVzYYXXntm3xNu1
 5XsytX4VZ8JyuudAGie63yhRcbFv1lCcVS80dJTeYHSawIE9kc5x6dq+YNwWNyjZqVWpvGkga/7
 CULgc+SojIYcbMtqcyFjKBExH4FQVPxzSJLlETxXb/E3uaxVaq1NRCHi/mXunhv1Ov2s+CzVfTN
 8jtGna3IrZOnEEi7AbKBG6rS4HCvjUfBXCK3FzNrKwcDHpd29ZCbSGwIlIq3Nh+R3SrhBX8tQwj
 YPkgDlGVgKLSXE1cQZ2VSkBmk3L46aAqUV8YFjX0qgJgQRYWchxy/K3IFbtFjNnsWwvwT
X-Google-Smtp-Source: AGHT+IEIhmrWa/kBNrvonqiIlKraZfZn9GxmDplxkiZQmklpuhxy+Ws+w8YPbxP2ZFxkaUqhwzT/tg==
X-Received: by 2002:a17:907:72c7:b0:b0c:b51b:81f6 with SMTP id
 a640c23a62f3a-b24f4ec0c02mr35009466b.43.1758223271028; 
 Thu, 18 Sep 2025 12:21:11 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b1fc73bb5a6sm255305466b.35.2025.09.18.12.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 12:21:10 -0700 (PDT)
Message-ID: <29c5d94258d8533ca3910656ca5ef1ce56e799db.camel@gmail.com>
Subject: Re: [PATCH v2] char-pty: add support for the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Cc: amit@kernel.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, 	lvivier@redhat.com, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, 	mst@redhat.com, noh4hss@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, 	qemu-devel@nongnu.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, 	nsg@linux.ibm.com
Date: Thu, 18 Sep 2025 21:21:09 +0200
In-Reply-To: <30058224264231a1d5c6315580b14e42119d16c0.camel@linux.ibm.com>
References: <aMq4Ta4aPwRgDrxR@redhat.com>
 <0A6C8C3D-68E7-4E88-BEBE-D653135915DF@gmail.com>
 <aMrfGUfCSWnvkXzT@redhat.com>
 <e2f80c7ad10b8b6376144ba5d959a2ad4739f81c.camel@gmail.com>
 <aMr1sn-LU2f-w49o@redhat.com>
 <15cc6bcd675f2e20efe4fbd6332018a693122b9c.camel@gmail.com>
 <aMvETd_dlUed-nlN@redhat.com>
 <8979fb7f27b9dbe48f6419d515c4d33a77cefe0a.camel@linux.ibm.com>
 <aMvHScAtr3E_H2KB@redhat.com>
 <e6c30d2143147ebf285e69b4a786c0ed0f5212d2.camel@linux.ibm.com>
 <aMvKBxaYLR065YKu@redhat.com>
 <30058224264231a1d5c6315580b14e42119d16c0.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

I will respond to all messages from this thread at once here.

Daniel P. Berrang=C3=A9 wrote:
> That we will always pass size info the guest regardless of the backend,
> across all ports, changes my view about whether it is  reasonable to
> enable resize by default given the known Linux guest bug.
>
> The impact of the guest bug is just about tolerable if we were only going
> to enable passing size information when the user had chosen 'stdio' backe=
nd
> as that is relatively rarely used and mostly by ad-hoc dev usage where it
> is perhaps easier for users to get a fixed guest kernel.
>
> If we enable this for all ports though, regardless of backend, then I thi=
nk
> we're going to cause too much pain for users with the inverted rows/cols,
> as its going to apply in every single deployment of QEMU using virtiocons=
ole.

Inverted rows/cols don't matter for 0x0 size, 0x0 is still 0x0 when
swapped. Sizes other than 0x0 will only be sent from supported backends
(but it will be supported by more than just stdio).

> If the chardev backends are defaulting to 0x0 for everything except
> the 'stdio' backend, then this series is surely going to break all
> existing usage of virtio-console for non-stdio backends ?

At least for Linux guests, if no size is sent, the kernel defaults to
0x0, so sending 0x0 is equivalent to not sending anything. Nothing new
will break by sending 0x0.

We still need to be careful not to reset the size to 0x0 after
userspace has changed it though. With the non-multiport interface, the
kernel will reapply the size every time it gets the config interrupt.
If some other use for the config interrupt is added in the future
besides resizing, it could become a problem.

Actually, from looking at Linux source, it appears that linux only
reads the size after getting the config interrupt. This seems to imply
that linux will ignore the initial value if no interrupt is sent. That
might be a bug.

Maximilian Immanuel Brandtner wrote:
> I agree that this is a much more significant issue and I like your idea
> of adding an opt-in parameter to support resizing for the virtio-
> console chardev.

The console-size property can already disable size support, so making
it an opt-in is only a matter of changing the default

> The smoothest solution would have been a spec-change.

Here is the spec change proposal (thanks to MST for submitting it!):
https://lore.kernel.org/virtio-comment/7b939d85ec0b532bae4c16bb927edddcf663=
bb48.1758212319.git.mst@redhat.com/

Best regards,
Filip Hejsek

