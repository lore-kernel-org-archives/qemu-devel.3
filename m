Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB944D2F7DA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 02:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1FwW-00032m-Lk; Wed, 16 Oct 2024 22:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1t1FwU-0002o9-5o
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 22:08:46 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1t1FwS-0005iU-Io
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 22:08:45 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb3110b964so4470521fa.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 19:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729130921; x=1729735721; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/lHDJsKUIaxi7z6e9EGaZueXzmZ5dFz/yaqT/pm6Ujw=;
 b=jzOKuI2U2l2QZyofjlhkLWwR5TQeZvk/I+pYbIGdE/N+9JjZhMQaz5Wkke9FQA1i7l
 KgMQtYGlzEfuyxB7+wzzuosDjwRejj68XfARJxIxLhevRleNmucMmoKfRK8XvGvl0ncu
 37nNfjlRY3PFqikJoP+79rCG4GtYI3W7P7Ke7DrVtVfDDdhNH4LQtZCf7DSQGsIWf3RM
 R65IIdlLSR7H6y0RReYZqea2qf23MgZPFLbdHHo5otG1iibB2DcmZkK4mDndV5f+tQd1
 nzet+RolprX6uNMNQUXblngqx2p2CzP4o/gq9PXE0+2x9OJNlp90Mj9i8o2memZxb8d/
 BIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729130921; x=1729735721;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/lHDJsKUIaxi7z6e9EGaZueXzmZ5dFz/yaqT/pm6Ujw=;
 b=HC7izhb54yXuzNVnwSs94JRtUrGqDi77qOa6qnC/CPanflJ8VJhAVFFmhWvnoWDP9b
 THC3qFzeF/I1DfI+Wt1fm0Uel9wxLTcwikMYznv62FdQRMWsjWLjgqr0wFOt/sDxkpsr
 fNXrjZtkKLZyrHWmWKjxw0/ym0IDh+O1/X8UAuwbrBGpYd7oP5+ATSOpTT/ZMt+1bFyM
 w2iGA5AV/Ps3I1liIyq4T6qHAkdIaIa8edrj75C0/WBeb18BGANW6W1kiI+trSOQGkZR
 dtMd3KN9K9/93VkZogNkjyi8EknNSrr9ZzXF2mJOaS9mxaLHL8xJ/zPVKk/pFWDBSRLj
 NJKg==
X-Gm-Message-State: AOJu0Yz6X/tMdKoglzSwaFFx7MWv1np+vpuGX+e0KslOR9WwrVzuCyYn
 3O+oCS8ukXctOmaqzvnhir5DpU/P3Hk7YLs/FpYJbloS7nmv4q/GlVNs4VHRBmwGYAUOZh4PBNc
 v2Dswq31TP9mwMitRDOC1tFzkRCu1dZXHrL9gN2L+5Q==
X-Google-Smtp-Source: AGHT+IGl2IOtvqPwzMAKGTLSwcyH96BJrwGnZstARHsI2MT+PPq1xKy7gFO7vlM/PKusqCbjXilZHQ/zmHIJhVyNS3A=
X-Received: by 2002:a2e:b8ce:0:b0:2fa:d84a:bd8f with SMTP id
 38308e7fff4ca-2fb3f2d1667mr84320471fa.30.1729130921177; Wed, 16 Oct 2024
 19:08:41 -0700 (PDT)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 17 Oct 2024 10:08:53 +0800
Message-ID: <CAOYM0N2N7v7aWzyGLdcrMbEknKrqOD1WDrp8u2Zh-cBL33z-Eg@mail.gmail.com>
Subject: How to use "subprojects/slirp.wrap"?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000053bb4b0624a2aa61"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x229.google.com
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

--00000000000053bb4b0624a2aa61
Content-Type: text/plain; charset="UTF-8"

I want to build qemu with libslirp which built from source code but not
from the system.
Maybe the "subprojects/slirp.wrap" is the right way, is it? But I can't
find more information about how to use it on the internet. Is there some
notes about that? Thanks.

--00000000000053bb4b0624a2aa61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I want to build qemu with libslirp which built from s=
ource code but not from the system.</div><div>Maybe the &quot;subprojects/s=
lirp.wrap&quot; is the right way, is it? But I can&#39;t find more informat=
ion about how to use it on the internet. Is there some notes about that? Th=
anks.<br></div></div>

--00000000000053bb4b0624a2aa61--

