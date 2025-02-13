Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EBEC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidn6-0006S5-Hz; Thu, 13 Feb 2025 13:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atharvd440@gmail.com>)
 id 1tidn5-0006Rw-32
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:18:23 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atharvd440@gmail.com>)
 id 1tidn3-0008VW-Jv
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:18:22 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-726feeee4f0so671913a34.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739470699; x=1740075499; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iF1+I86Ia42rL38I1n84EFM3MkycqzzinBgk2wkIoSQ=;
 b=Ubb46/8Ui2UnGN/6cLYL7h4CwiucEt1PIK5+VzCdPghvtEzdzGbCrZM2UBAlpdIp16
 qooK0zgfOJxsYxBWdHGYk4uXufJW7V/v6Btu4g080q/YEHt+jwbbTP5DJ8S3NHEe5fff
 tdrpvyCh/OvJVeeAWWk6HsN5Orejh+dJjxwPhJ6Rc2yRojzG+RYUqE0TmhLp6pYpiGvv
 s0kJEKBlBLDK2JkSMmWMY9oslE5YhKFwPKEpQR7zFBa8X02G2GNQ/LEvA9l4M6kxkDk7
 0iw8T/ozEEB3+cc0ZgXEbyW5TSTZhLyW7lQ9YRCqgRZVuSqgg0zU8TaJq2hMtMDWpBlg
 KIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739470699; x=1740075499;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iF1+I86Ia42rL38I1n84EFM3MkycqzzinBgk2wkIoSQ=;
 b=qnfmzI1hB/PK9jf8djfgH0gGqIrmVkap1EQOPZYsgqPW0OMphCmxLmGvsHehJBZCFD
 yzai7OEeonrdjXizfSqABa8YgyChXKapTwPju1BX36GKXjKxbcV+cey2o+DGjetBnSSv
 wwA9kBwfq9QyB0VbrJXIGkMBAlosuyZ7U4iWeO9XoyV1cRf4laNPWolvLCB0yp3Ztf3Z
 /QWVfNgYth3kF719igAViwoo8wyezskkoV0CO5C0A36BAdkcC+y/V+GhSa78jqFqCR5n
 Cbn8xt8nATDGSVWcO4e0KNlBOPZWJUHjpxg4NFrGgFM6ieseCB9gCIl7Fau+Pj/bwdMY
 71bw==
X-Gm-Message-State: AOJu0YwIE0iwcgDQyCauDmLKT3RpWl/bo/XjLvvbtwztqnEU/AR1S7lj
 mJFLl9M/I3FymDeYX3ym2lMO3LxVH175r/Ra/5QRD6RYDzVtA8dcaSNkqiUcPLaTBvglDOFqQzS
 xSgX47pI3vZrwfrH0M7xxj8ur+vnBtw==
X-Gm-Gg: ASbGncvDwApFJYgkyrQOFWv7738ny2H924G3k558p5XdeTwZgH1Kw55b9bMF19uHMMY
 IhbrWGhiEVI/y7H6wRq7cCFA7mTEABRZ9W4CBONfeOixlFE6rr9RJuT6mo7xo7+72DmhsS7K1A7
 0=
X-Google-Smtp-Source: AGHT+IGT7jUAgMYOWUgyP9OwxBEUs016Ypxzkf28Y25wpD6ZeXZGvTwm/otM1CipBR0M/i9FK/6F5n9nat8vqtqcf20=
X-Received: by 2002:a05:6871:a085:b0:2ba:11d9:e08d with SMTP id
 586e51a60fabf-2ba11da130cmr1615966fac.21.1739470699372; Thu, 13 Feb 2025
 10:18:19 -0800 (PST)
MIME-Version: 1.0
From: Atharv Dubey <atharvd440@gmail.com>
Date: Thu, 13 Feb 2025 23:48:07 +0530
X-Gm-Features: AWEUYZnJ3zzoJgXFM5e-qdWYXlNvDt8aaMbqd6kIl5n8r6b_N0Hsr27wGl9I72c
Message-ID: <CAKTQj-53s_n=7qdm5eV8vrCLR-AKHBpq1pqCewNKPmyYtHVZJw@mail.gmail.com>
Subject: Question Regarding the PowerPC arch Support
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000022275d062e0a1505"
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=atharvd440@gmail.com; helo=mail-ot1-x335.google.com
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

--00000000000022275d062e0a1505
Content-Type: text/plain; charset="UTF-8"

Hello,

I am new user to qemu and wanted to ask if qemu supports AHCI mode in
PowerPC emulation.

Regards,
Atharv Dubey

--00000000000022275d062e0a1505
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<div><br></div><div>I am new user to qemu and =
wanted to ask if qemu supports AHCI mode in PowerPC emulation.=C2=A0 =C2=A0=
</div><div><br></div><div>Regards,=C2=A0</div><div>Atharv Dubey</div></div>

--00000000000022275d062e0a1505--

