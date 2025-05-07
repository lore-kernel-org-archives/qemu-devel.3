Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BAAC3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 16:15:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uChPt-0002A5-H4; Wed, 07 May 2025 12:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lebrongandalf@gmail.com>)
 id 1uCgrn-0005ij-9g; Wed, 07 May 2025 11:39:27 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lebrongandalf@gmail.com>)
 id 1uCgrk-0000LO-H1; Wed, 07 May 2025 11:39:27 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e6e1cd3f1c5so30994276.0; 
 Wed, 07 May 2025 08:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746632362; x=1747237162; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Xuf152WHysRq+Z/dYsErZxczCzfSa1/+B94t6hcxHpU=;
 b=gXewaCcEAddckr+cf6EHWDXUgu+rybjR8AMd1Q7tKn8pr8xy8ZD7ZnTcfu4KXu3EeT
 OCU5Blvce0QywbwWHjpTlAv+7QaCia0Ld53cg3UIPqzG1zO5rRtfMVKVbVEpvVysFBWW
 O0cEQ93xou1EZnVcGgph80Pt2kZFf3UYoHd/scARtlY/PvyzLQSKDJk71s9+s8cEF5Tv
 6jU3XE/5Xeg7NfEyoDXns6iUyu8P4WR+7ctB49myHpGy0Ao31NJG3Q1uOn9ornTrgPy6
 P35EAOeW4pVAKXAJV5DKA6hZUm4J5NVfz6kdevj2xpvA9vDO8n71bAzSLEonfemGvjQV
 PGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746632362; x=1747237162;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xuf152WHysRq+Z/dYsErZxczCzfSa1/+B94t6hcxHpU=;
 b=gxHBAs2TaL1MN3OWcShpnulQYmSNxBW6DEpvOpC0QTfxveIazk9quwdzH+Gct7IFw8
 79UJFtF5LZLfhCvT9L+w5twzo4jjYj+gDBX/byTimtPW+jYzhLBXKRXg6vsoZnNeJUEU
 pK4FQ1eZlfK0INrT46LPqNkrr1f+C/JGrDlXHYYVulJb3cjrfZguMQZwJt0NOu/vw2GV
 uE7bWKHf4v2PNdzuzG5tsGpw8iDkNJglAFLaxkNh5dFdNT/B6IxcWg6JwASHFlAo5cR7
 rvZ3AWz8uOX0Ut0lxupAhtLmuXjKfmdA5cxA7l7IbjMSIql2aSJJy49GHXzTYSHxo5g7
 k/Ag==
X-Gm-Message-State: AOJu0Yx4SST5/7b8/u+Sk9U5yrQzXJa5yplVEG4YoPIZWqlsMgZU6Raa
 bht8hEkhCHNtmB4URC20rjm1vHROlzm6pLEL0uPw+bq93+VneDGsa51TpaxTehTIy+sFXM61v2t
 vQRs08RNCVDjI0ONWkChdbypakEzPgwhQQg==
X-Gm-Gg: ASbGncvxFB6kuoMJi7QQKEY9051mhR7zXkihk2uO7Bl7BBTr3n+7dRNsquflEzkIlFk
 QJhrZuijCjwbH/tibdmd5K6DyQjOJKlk53TMsvbyleuhv/qCRYO023SRto7E4tnuGq24hIXkYFy
 NtuN72vpMdVY0YQ5/H3H02
X-Google-Smtp-Source: AGHT+IG0kv6g2lyOF+VfiREYc7MvBQ8MzhsOK76+6wVLfEOFg23UDv49DdTopwvgdBylNHJiMRkT30fz1/cvkFumu6M=
X-Received: by 2002:a25:f449:0:b0:e78:d3db:7e11 with SMTP id
 3f1490d57ef6-e78d3db8ab2mr2706685276.10.1746632361867; Wed, 07 May 2025
 08:39:21 -0700 (PDT)
MIME-Version: 1.0
From: GanDalf LeBron <lebrongandalf@gmail.com>
Date: Wed, 7 May 2025 23:39:11 +0800
X-Gm-Features: ATxdqUEWTtV-j2xG-mwcdJmbs9Oa9ek--qlyiXJGYC9JMRznQTjPO8Rz3TyNkeA
Message-ID: <CA+V5jYUjqDc-UWKvQrX24c+MKtm+zdx4YCWU036180A4rX4ybQ@mail.gmail.com>
Subject: The current implementation status of ARM Secure SMMU in QEMU
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007b808506348d8911"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=lebrongandalf@gmail.com; helo=mail-yb1-xb32.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 May 2025 12:14:40 -0400
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

--0000000000007b808506348d8911
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there!

I am writing to inquire about the current implementation status of Secure
SMMU features in QEMU.

I understand that non-secure SMMU emulation for general peripheral DMA
(IOVA to PA translation and protection managed by the Normal World) is
well-established in QEMU. However, my current understanding is that
specific *Secure SMMU* functionality=E2=80=94where the SMMU's configuration=
 and
page tables are managed by Secure World software (e.g., at *Secure EL2)* to
protect DMA for secure peripherals or confidential VMs=E2=80=94may not yet =
be fully
implemented.

Could you please confirm or clarify this? Specifically, I'm interested in
whether QEMU supports management of SMMU page tables and configurations by
software running in Secure EL2?

Any pointers to existing support, relevant discussions, patches, or roadmap
information regarding Secure SMMU capabilities would be greatly appreciated=
.

Thank you for your time and efforts.

LeBronGanDalf

--0000000000007b808506348d8911
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p><br></p><p>Hi there!</p><p>I am writing to inquire abou=
t the current implementation status of Secure SMMU features in QEMU.</p><p>=
I understand that non-secure SMMU emulation for general peripheral DMA (IOV=
A to PA translation and protection managed by the Normal World) is well-est=
ablished in QEMU. However, my current understanding is that specific <stron=
g>Secure SMMU</strong> functionality=E2=80=94where the SMMU&#39;s configura=
tion and page tables are managed by Secure World software (e.g., at <b>Secu=
re EL2)</b> to protect DMA for secure peripherals or confidential VMs=E2=80=
=94may not yet be fully implemented.</p><p>Could you please confirm or clar=
ify this? Specifically, I&#39;m interested in whether QEMU supports managem=
ent of SMMU page tables and configurations by software running in Secure EL=
2?</p><p>Any pointers to existing support, relevant discussions, patches, o=
r roadmap information regarding Secure SMMU capabilities would be greatly a=
ppreciated.</p><p>Thank you for your time and efforts.</p><p>LeBronGanDalf<=
/p></div>

--0000000000007b808506348d8911--

