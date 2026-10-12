Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1838CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGN86-0006fJ-5s; Mon, 12 Oct 2026 17:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGN84-0006ew-09
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:00:16 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGN82-00083K-6n
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:00:15 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so18517905e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791838812; x=1792443612; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GrtPc/3Yr+GEGva/aXJ3+/Un3nvtpMeG8JuAULk4QDk=;
 b=JtE2dhtcehFQE6plDIaWxpU/U27rcE/M17K34k1yijsjReyE6RU78wOhC97sBa2aYG
 MlmCRweNVwmWROI4IMd9oI/BnR+uBAZ6cDDHdrlwJ36dD8UoE/FJpzLOwz+n16h8CQL4
 mwdw9idPggw6dWcbhkhRIoJQzizSnieB0KZsKUPes1Zh3i8xxAKTF1t2am+/PFcqTq/I
 IzUxIvwgElIY0aUxeK+ZJc2X6uX0tRuweQQtWXC/6eDaVE0ASiaqdPFfYbZSh98/zYUJ
 tYj7kVbVQDom9rw01UrYs/sI+O3GX1XcdpHCKnZwLERcjp8IpsvOqq2sFZZBisvgNmRB
 S0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791838812; x=1792443612;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GrtPc/3Yr+GEGva/aXJ3+/Un3nvtpMeG8JuAULk4QDk=;
 b=jmjNNvF90NTmmuy3SbSqoA+mgUxRvDHqt0yw6T3UtaX67QWrd/5MHtz9RDaPjAbxUj
 +AucGFcTdMP+v4EZR7x33a0y3SN/2Tgtno9JAekmPqrm2K6qVdrJgW/3LXkQUdt3fMPf
 YSRL5Pf7aW8d1GYldZdV8inNJeoD5ig9iqs69tOU1aB6+qZjCTPOVK6AfOrCu+NZn/Aw
 /MzcofdzDSgpEwE+Z2wKUr5sih7wMZyPamBnvzZnoCYNC9vtbE3D8Zv5EpunR0RUk6UD
 Ixhka2XNTQA7baon2dXKya+zZX1B40VoTxpdpQagbxRflOmrU4z7Bg3W4jDZe0wvMjjh
 z9AA==
X-Gm-Message-State: AFq9FYLwigb21lqv6Q0mR14USN7Q95EVuHsVYLC5IjaiP81FN/Xa+TBj
 09dVeGJqjUDzG49ZRDJyVYvc4ouYOgUqPpgSN5nUQLxn9tamxMPdo+hw
X-Gm-Gg: AYBFou2BeKDgsL8z3Qr3ASOgXAwJwjNCSHMI+KVNN5fhoKEI17pjB2pduGj8GvxMW23
 MB0W3zkuLxxGYxbTN8yxTtbIcZw6ROo1BN+TbCFkgaxJiCL3n1iYbCs1HujIUsKFi+omuPIcq/w
 LbjaW85VEWidzMRtkfORKHjBe6JlB2wZ8Er6nRh2unzaGeR7ExvJzusv3rf5x57BYza3wdliCXy
 TgsIetqf0HNVSwqdPHLlN9nfE2y5QKJ/7nlmF7k1B7s+Vh9Wr5/S9+HVAyCZBzZ0g9o5+4KgMOI
 fkYdwm7YxZQR/byMzm50ZB1G8bfI8H6uVmHNWTrgAP9K2xZBcZ03DIwBcXva10K2MimtQrPr0Vq
 M+dJeHbVrA51ucZTdjNyFDoCJhinKRphWGZzLy9uwyYxuJZOoICFoqdM3spnTnTKR6W4K1ERjJP
 SmrHdAjGAAa3URGFzjZn4ZA+YwU2DgDKzoJAVCh+HFDvNCtX31UGeb0RsDmcdhGKIMfz5NSUoo0
 qamDsx0KFtUZ9rm0IMhxmec50fK/RLAHA==
X-Received: by 2002:a05:600c:4ecd:b0:4a1:96cd:2f60 with SMTP id
 5b1f17b1804b1-4a19ecf4c20mr81981365e9.3.1791838812449; 
 Mon, 12 Oct 2026 14:00:12 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1a571294fsm3649315e9.3.2026.10.12.14.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:00:11 -0700 (PDT)
Message-ID: <a7348b0ecf66d8027955774e84e57c9f4065f9fb.camel@gmail.com>
Subject: Re: [PATCH TRIVIAL] treewide: use qemu_dup() instead of dup()
From: Filip Hejsek <filip.hejsek@gmail.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel
 P." =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Michael Tokarev	 <mjt@tls.msk.ru>, Laurent Vivier
 <laurent@vivier.eu>, qemu-trivial@nongnu.org
Date: Mon, 12 Oct 2026 23:00:09 +0200
In-Reply-To: <90fe897aa35405fbada7a440c3fab848d81ea2b0.camel@gmail.com>
References: <20261012-use-qemu-dup-v1-1-03d94852a6c8@gmail.com>
 <CAMxuvazc5iHk=GDysFHVFN0xtf-g75AobhoKdPXaR6_Qz=dDNg@mail.gmail.com>
 <90fe897aa35405fbada7a440c3fab848d81ea2b0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x329.google.com
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

On Mon, 2026-10-12 at 22:12 +0200, Filip Hejsek wrote:
> I've actually intentionally left some dup()s unchanged for exactly this
> reason. They are the ones in qemu-nbd.c, migration/cpr-exec.c, and
> under linux-user/ and bsd-user/. I also didn't touch the tests, as I
> didn't consider evaluating them to be worth the effort.

Now that I think about it again, the use in qemu-nbd.c should probably
be replaced too... I'll probably send a v2.

Filip

