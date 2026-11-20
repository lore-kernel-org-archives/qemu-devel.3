Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B7606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mZFMbQ8m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNNI-0002mv-2w; Fri, 20 Nov 2026 07:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUNNG-0002mX-6l
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:05:50 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUNNE-000602-Ec
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:05:49 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so6064805e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 04:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795176347; x=1795781147; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Zm/JDQEc5EiBdmseCAYtRA2phtmc5MdPPVP6lF9h4f4=;
 b=mZFMbQ8mpMzTgTnJXvFYKCgS6D9a4aTPIiRw/eYMIwbgarq9MIPSbpPawEwl3Af89D
 KLtjL2Ahyyo5Rf5kmJVNrm+DILh9upx4Uspo4ZQ0t8ZF1m7NhZRnefCptMXs1A6Khmnu
 xLNMJdCG4Bs4M3GF/n6jT/8eNPDumOQcJKdB9qDiewKLDBrDEKZtSemReiN0T160dm5D
 VdlJK6qlsdN2QLx4Ml3KqQ4rsls7sgrky1F8S2iahhjHi/hEUy/G67+zqIFsJiD0Mez2
 f0CVnfpPK/oyrXdul6wGaiiWEOg/BupIdNbCQptoCB6SCqpgohVUu3FZE6JS1GEMCabX
 56ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795176347; x=1795781147;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zm/JDQEc5EiBdmseCAYtRA2phtmc5MdPPVP6lF9h4f4=;
 b=iuKc4lbARUAPhxOu93mVjYL4rFOwxpKyBOF+So0WfO2noCHRCdkP4Y0e9cU34pUktK
 W4qQWOL2dDmEU4ESYSDZarPFAzjS9kFiNrjEfuUIOaZyInzlVDk7teF14IYo2+ZGqdkW
 kRQDtwTjDobmbOLuw0rVed2TM1hsMpDRrdKIjcyFiADsmELOq3LN61hwFk4WuIGDDO0N
 Jc4GKl8na7lDyISaIIG6qLZnCxWz8AK48gqniWkIDh9YkP5quWZx/AIdeEAgiof3lSXm
 kkpGJq111u8KU1jcMWq4hL0e433WwdGgK9o+e2Gzb63dzWdpgNMSwoXGhzethrBp/DGa
 IzRA==
X-Gm-Message-State: APuU4Z92tMvmmLn5Rxbz+3PCpm+8xtKXjzmK7UTrn6G3jkpslsaeNdsO
 QzwStk55GkQtVhWZIAL+eZpl+/+dVcirlt4PaQ0pVLP/o4SOkV2qcScbz5Pk74r/F/k=
X-Gm-Gg: AYBFou1y02iopRR7oCqYeWvy1IU9Imp7xDaYRVbDrBCAPSyzHeiyXibGSWAIPSJx9Y6
 ZPg72jwltOGmOVfPFcag8iQwIrQbuJG4YAcGURfrMXaJAL1qsXxEBUWc7xMK+UylyO6WF8w32o3
 vAk4qKg8PYVsrXbWDi2yFTpOLFDYyGyRVXRnW4+dnXdPEKoyjIrEKRzE3Asd+7PWOLTYg19KejF
 1X8EV1MfZPyVa3batdgnVtaklVEpAA/y2Y6/9ZM3Y9RXvzeTKuDI5Spk6UTj7ie2CMrb/P5SKgI
 ewHTHP92v7eSk5KWMFp4A76ji/F1rZuiFk0qGtt13YZrFz483jl8DaXEpSDKepsBjHOqX+B/aj7
 oaG3UEVpnGZRmXzJH5SOod6pK4uJEaJVO2SHmVlkSv8iGcuUVQYv1vWj67CbjSJPKF+2xIhE1x3
 aR9dkZrAqJy1CYHvJ/O5H8XPHCx4ncCG9N7OQF4NARFAECwanAM3sDE10+A6s2PE5CbGKTWze1o
 e/uwZEJMsE9WaP4uYB6F6jmJRkTZxDLkQQmTZ24UhT+GvxU09M4N7Xu/26YsoYiuYw5aqmmTFT6
 utxy/3GfhIb3mXGBoRVGUPqLVb0l
X-Received: by 2002:a05:600c:3b8a:b0:4a3:59c9:a754 with SMTP id
 5b1f17b1804b1-4bb8892da25mr62296645e9.22.1795176346822; 
 Fri, 20 Nov 2026 04:05:46 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm161917755e9.13.2026.11.20.04.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 04:05:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD5DF5F7FE;
 Fri, 20 Nov 2026 12:05:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nagendran K <nagendranjairam52@gmail.com>
Cc: qemu-devel@nongnu.org,  berrange@redhat.com,  philmd@linaro.org,
 daan.j.demeyer@gmail.com,  peter.maydell@linaro.org, alistair@alistair23.me
Subject: Re: [PATCH v3] hw/core/loader.c: Add Extended Tektronix HEX file
 support
In-Reply-To: <20261112184949.1042-1-nagendranjairam52@gmail.com> (Nagendran
 K.'s message of "Fri, 13 Nov 2026 00:19:48 +0530")
References: <20261112184949.1042-1-nagendranjairam52@gmail.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 20 Nov 2026 12:05:44 +0000
Message-ID: <87ik1r673b.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nagendran K <nagendranjairam52@gmail.com> writes:

> Add support for loading Extended Tektronix HEX files through the
> generic loader.
>
> The loader parses Extended Tektronix records, validates their
> checksums, and loads the data at the addresses specified in the file.
>
> This allows Extended Tektronix files to be loaded directly without
> manual conversion to another supported format.
>
> Tested by loading an Extended Tektronix file containing a simple UART
> application on the RealView EB machine. The application executed
> successfully and produced the expected UART output.
>
> Signed-off-by: Nagendran K <nagendranjairam52@gmail.com>

Ok before you send another version you should consider:

  - split whitespace and comment updates into their own patches
  - include a test case for the loader to show its use
  - verify the whole series applies and builds cleanly on upstream's master=
 branch

And the cover letter for the series should also include what changes
you've made between each iteration. You can also include a summary of
updates under the --- in the commit messages.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

