Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B716606A31F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packetfive-com.20260707.gappssmtp.com header.i=@packetfive-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=droo+xkQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNEHs-0003xe-GI; Sat, 31 Oct 2026 14:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xNEHl-0003wL-Dp
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 14:58:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1xNEHj-0001bl-Bs
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 14:58:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso15573375e9.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 11:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20260707.gappssmtp.com; s=20260707; t=1793473113; x=1794077913;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=733QDyVjQk4hMWQF0Vjh3ZYZWRiDLavbteDQOd/Qy4Y=;
 b=droo+xkQravopjCrePrutCQtVxVXZg1DCUP/oTSSqxDHHMZREIuj5QJ3+LbOV+HJzA
 +u0oPJGLsCyufdDR+yN54DCjltrnQSRCrAiefXLu2VDMsKqrNJZPBfJqoLQR4TbSnm1i
 KXE/trXBlrSrAiHzEN0foyUfL6CcapgkH6NQlsQiR5VAWyfonjOKhktlkY2Q66YVkxJE
 HdmRCMCx5FuIrCnUbbs/Pl7iu+8epsilqqwZKCU7ec561F9M/pi0g+d168TCy2BnnOE5
 ZeYdLSclWwykPJ90yuMhStXCRttuP6qgOjTPm3HWo2m1EIemcOAWprRC8QDNfUjBN9y1
 oqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793473113; x=1794077913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=733QDyVjQk4hMWQF0Vjh3ZYZWRiDLavbteDQOd/Qy4Y=;
 b=ObEPzMirjb3fQ0DWKprFMOZmFDTT6/RfjKLnqruqr8Lm8Yzb0VdA6mS1B8etWPxEpQ
 8lBi9hhpVjDcgdfgwF9Wjps2zgBiI46zak8nOcsJqiYtqNyM+ESgd/uo0xgccOokR0jf
 dGh+PA0Xh0rhjWVNVSeYDpEnrpe70+RzDRyaswIlxv49n9aIqfboUGnLX5B2eMzK+UaJ
 LxUkNb2r38recccTygQObvlO8azCxo8dIfMRUZRAiVqHVdsBmVuBCm4spgkGD/AIrx4+
 7YwU7+i4HEoqMWdpHAvH2KlcjzGb9yI4FVs4JUFHlThAKLSV6ar0r0/QCAAfp3K4WjoR
 o2mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx0UMZ7mjom7/7p5xkHQwGpcwnbFfC93nC+3zk5WKgJFo+2HqPjcAum8loYWj0wKI8cxGwplXtkIh7F@nongnu.org
X-Gm-Message-State: AFq9FYJMVmf0sVSpGnZSp8KpO21LbDgpv4zCurHxfLc/8/ayhux8DOLb
 bfThWHLyH0d7fdl6gJ6Zi+BSNCFrqztxcYK9mVFwI30AM1EKYMhxMh8bUyNhPNAhSF0=
X-Gm-Gg: AYBFou37g/uYrfF9lsZ/o+zfW5FyWbJTXN47I9/4J6baWD8h3ct+Xkg0VklIs3Pg0js
 ArhUhi5YOaZIWWfZMvv9Yj7n3cQsDOnSp6iImF0v8CJr3SPuzTnwvX7Vu2rwhDyysVqxTguti0w
 eBrb6a3gMh99Yh7QmRaETpGwoIKcLK572JyQ2dmDILJ2fT+NUz8EYR0j/QvBEDRGK5cNi6TeRBY
 qohvJ4XCWHk/qz23Cyt9fCZguweYH4UZ4nN002Y9CQyWbluXCNU5EwBgUPxKmIGThw9yy9zlkNw
 Nau6v/UWBzupRjIMQyXcEVsYvoWsnr+QsfEaBWAPCK5MMzEBvDm+S0iP5qquvDwItMbYtpBig7p
 tkXj4FBUxkJSBGAPoF3fPy/rHkx4VBFxsb4ZUwjiso1qYOiq6E3jVUi3jV+uKWxxK2UbM8IXjP7
 cZ+2LX1d3mmiuiVJ+F8PEUvcqYorYIskq/+vLIiQ0ojjnvwBI0oX5VHdxgJZJKte80itke4sQei
 zjgsvFx6bcIJFmYVPEczDS0KAHpnO1D2nt6IzMBvr/QlMlNiIq1PcqvwA62LoUssI4JgsbysTdC
 b57LCLP+F9M9A+EVNPYHCDv7Oe4HBAkjcqADmLsqikaLAg==
X-Received: by 2002:a05:600c:8b54:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4ac16bc547dmr139733315e9.9.1793473112709; 
 Sat, 31 Oct 2026 11:58:32 -0700 (PDT)
Received: from node-dev.home ([2001:bb6:1895:f400:7a91:41fd:83ea:4c4b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac0a66caefsm117496785e9.5.2026.10.31.11.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 11:58:32 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org,
 kraxel@redhat.com, peter.maydell@linaro.org,
 pierrick.bouvier@oss.qualcomm.com, jasowangio@gmail.com,
 pbonzini@redhat.com, farosas@suse.de, lvivier@redhat.com,
 marcel.apfelbaum@gmail.com, peterx@redhat.com, lizhijian@fujitsu.com,
 odaki@rsg.ci.i.u-tokyo.ac.jp
Subject: Re: [PATCH v3 0/6] hw: Add Cnuas virtual devices
Date: Sat, 31 Oct 2026 18:58:04 +0000
Message-ID: <20261031185807.2866788-1-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031135234-mutt-send-email-mst@kernel.org>
References: <20260929202358.725310-1-weqaar.janjua@packetfive.com>
 <20261016153247.1815153-1-weqaar.janjua@packetfive.com>
 <20261027080746.2468700-1-weqaar.janjua@packetfive.com>
 <20261027063724-mutt-send-email-mst@kernel.org>
 <20261029115735.2716219-1-weqaar.janjua@packetfive.com>
 <20261029134859-mutt-send-email-mst@kernel.org>
 <20261029194227.2735464-1-weqaar.janjua@packetfive.com>
 <20261030191556-mutt-send-email-mst@kernel.org>
 <20261031120516.2846639-1-weqaar.janjua@packetfive.com>
 <20261031135234-mutt-send-email-mst@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::330;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, Oct 31, 2026 at 01:54:08PM -0400, Michael S. Tsirkin wrote:=0D
> > My concern with=0D
> > virtio device is that it would hide the layer we want people to work wi=
th.=0D
>=0D
> People being the students?=0D
=0D
Students in the context of training and skill building, and researchers=0D
from academia and industry working on rack-scale systems. It is also intend=
ed=0D
for upskilling and onboarding staff, and for developing and validating=0D
user-space and kernel-space code on a complete software-defined rack-scale=
=0D
ORV3 system. With virtio the transport and the driver are already defined, =
so=0D
there would be no device-specific PCIe driver for them to write, whether=0D
as a training exercise or as custom kernel-space PCIe code that industry=0D
and academic researchers develop and want to validate.=0D
=0D
Thanks,=0D
=0D
Weqaar=0D

