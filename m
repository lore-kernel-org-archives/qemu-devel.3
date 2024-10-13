Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E278ACF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 16:33:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t01WN-0006Ur-3o; Sun, 13 Oct 2024 12:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t01WL-0006NX-4u
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:32:41 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t01WJ-0006Wo-Fq
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 12:32:40 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-50d5d4ef231so34764e0c.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 09:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728837158; x=1729441958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OE1X5d1las6KGC8Xym6My3KDLgRP4SYiJBqV6ksxV44=;
 b=F8nsglOmFo3gYS3Bhe+I9r62enXEPPKTsSgnfzIFdP/M7VCCJdLVyzerC3iDgfQ+60
 wa1q5tuzdp281XLGNFFNcn+hb4g9Ofh5nnzJRvldknuPyyoM3GLSRpYaG/ABsJ5WmB8Z
 quqqynOH+cSgFur7ZYES2pYtCzlb6fi2sXUUb+ZRdAfih1JE0I4occUqaTxosRqfiWX0
 RufGr+DJvhDcB5XYsnNd5MInAGaPJjMXEsLlEnilMahOkvry/DI/TAreVCf/IvuSkOtH
 ZlDD6w9W4RwxUiqGY3RSAXaC/VIXYds3DKPnopnKNMCloCK7cX8gqXiRQ0PbN5bQ3pJ+
 DbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728837158; x=1729441958;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OE1X5d1las6KGC8Xym6My3KDLgRP4SYiJBqV6ksxV44=;
 b=XNGcK74oRN+1Sv6aDyFIQgWyqaMKoCywvhk6bcH/pA5xv77h6qGhiXojSZ4G8yge2o
 cAij0Anz1gYCaMIJv+IDZDdzXaHleYBft24oajB6UGOp/lyKysVlrIhsioGip7CHv1CD
 9TDM3nqDmc0ns7ukVRza1ej+FGFIlUPebIJrgFPKIkKpbhiL45dwHzqct3Sitdzj/jn4
 xGscCQIvXqBxJqu4XXm2dDA4xSZ3stxE1mmvq2OCw5TSdDtCExJ9B/TjlxBY4dOPe52D
 b2iG/BMo0t9IZctQwCz1jk+0r7BmQngb3Uv7OJyvQR6gMVREo7XKoTU1GL/PSAkey/h8
 c7Bw==
X-Gm-Message-State: AOJu0YzPpwBOUIcwvTik7cM3wjsZcVDZ9hP5Hvje8NX83wJAhiPPUX2Y
 Y3aWKc4epx0hUPsi+jxfKIE7Vlbmghdj8ZyCLQ34KYJLi8F+N8wlDkPW8RK2RL1T4TbtgzerGWW
 Hnwqv3veOMn58O7Fm8MiOp9QdMjwmbbp5
X-Google-Smtp-Source: AGHT+IEKlyQBZFSl89hQEYmsTk9olYDMNNsJE+zFFXIZ62XIc4bg9CyeTNJfsxmfwkaVi90kJt/tGZxjZddwYcu0I/c=
X-Received: by 2002:a05:6122:7cb:b0:50d:5ab3:5209 with SMTP id
 71dfb90a1353d-50d5ab3b1f4mr491954e0c.8.1728837157797; Sun, 13 Oct 2024
 09:32:37 -0700 (PDT)
MIME-Version: 1.0
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Sun, 13 Oct 2024 22:32:36 +0600
Message-ID: <CAFfO_h4Byz-RNv+HjTnbmo0NWL_BA4JM_3c_7ecFWa0wE21Pkw@mail.gmail.com>
Subject: possible bug in recent crypto patches in master branch
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alexander Graf <graf@amazon.com>
Content-Type: multipart/alternative; boundary="000000000000aa48ed06245e449e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000aa48ed06245e449e
Content-Type: text/plain; charset="UTF-8"

Hi,
I think there maybe some bugs caused by the recent crypto patches that got
merged to master. ref:
https://lore.kernel.org/qemu-devel/CAFEAcA-e_1WFLun2HptTt2bSzXkSMBnxKAK_UzUhwRh_fb66Fg@mail.gmail.com/T/#t

I think before these patches the "qcrypto_hash_bytes" or
"qcrypto_hash_bytesv" apis used to behave such that a user of the apis
could pass his own allocated buffers. In that case, the passed buffers
would be used to fill in the hash result instead of allocating a new
buffer. But I think in the master branch now, these apis always allocate
the result buffer regardless of it's users passing their own buffers or
not. So this is problematic for wherever the users of the apis are passing
their own allocated buffers. For example, I see target/i386/sev.c is one
such api user. Am I missing something here or does this look like it's a
clear bug?

If I am correct, I think it makes sense to keep the old behavior of the
apis where new buffers are not allocated if the user supplies one (I think
it probably also makes sense if we force the users to always provide the
bufffer instead of the apis themselves allocating them). I noticed this bug
in the nitro-enclave work I am doing where rebasing the branch builds but
the actual behavior is buggy because of this new change of the api
implementations.

Regards,
Dorjoy

--000000000000aa48ed06245e449e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><div>I think there maybe some bugs cause=
d by the recent crypto patches that got merged to master. ref: <a href=3D"h=
ttps://lore.kernel.org/qemu-devel/CAFEAcA-e_1WFLun2HptTt2bSzXkSMBnxKAK_UzUh=
wRh_fb66Fg@mail.gmail.com/T/#t">https://lore.kernel.org/qemu-devel/CAFEAcA-=
e_1WFLun2HptTt2bSzXkSMBnxKAK_UzUhwRh_fb66Fg@mail.gmail.com/T/#t</a><br><br>=
</div><div>I think before these patches the &quot;qcrypto_hash_bytes&quot; =
or &quot;qcrypto_hash_bytesv&quot; apis used to behave such that a user of =
the apis could pass his own allocated buffers. In that case, the passed buf=
fers would be used to fill in the hash result instead of allocating a new b=
uffer. But I think in the master branch now, these apis always allocate the=
 result buffer regardless of it&#39;s users passing their own buffers or no=
t. So this is problematic for wherever the users of the apis are passing th=
eir own allocated buffers. For example, I see target/i386/sev.c is one such=
 api user. Am I missing something here or does this look like it&#39;s a cl=
ear bug?<br><br></div><div>If I am correct, I think it makes sense to keep =
the old behavior of the apis where new buffers are not allocated if the use=
r supplies one (I think it probably also makes sense if we force the users =
to always provide the bufffer instead of the apis themselves allocating the=
m). I noticed this bug in the nitro-enclave work I am doing where rebasing =
the branch builds but the actual behavior is buggy because of this new chan=
ge of the api implementations.<br><br></div><div>Regards,<br></div><div>Dor=
joy<br></div>
</div>

--000000000000aa48ed06245e449e--

