Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9446EF06E2
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Feb 2026 06:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voxpR-0000MB-4x; Sun, 08 Feb 2026 00:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpL-0000LU-Sf
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 00:59:24 -0500
Received: from mail-4317.protonmail.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <damien@zamaudio.com>)
 id 1voxpI-0007Sn-0K
 for qemu-devel@nongnu.org; Sun, 08 Feb 2026 00:59:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zamaudio.com;
 s=protonmail3; t=1770530356; x=1770789556;
 bh=l6zV3VfoX0Jfo79QCVIaB38GIKo3wJCYcks/wu4vMS0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=k8cRubfomQ1EaM2RJcPK4PeKMganjR9s1KY8fuZZkmgwpdNE83FKkzyCV7QUA1nob
 PnUrs6l1DNmkN3L2o0qT1uIGXWmB5QciLfSv5DAkoOxA+U8HH72e22RB+mhEtISy0i
 sIvPFIeECfqo8lfFeJ1tO+D5Ty61uAwuGz1XDwvic1ahnA3Sj7V59OPBLvMWaKdHOY
 bLwH9P5uMcKHDQW0pOHa3NBBF7f7ZMH4TMBropwuVbqcE2qqSov2gpJfT/DzEhBqFY
 CM1DC0cIpNd3ySxf8vBjcpZCiQbiaF1WXw8mIJswH1gC9hMFaX/a/yKYXBRo9iE1rn
 9WQ0cv/t7Y+hg==
Date: Sun, 08 Feb 2026 05:59:13 +0000
To: bug-hurd@gnu.org
From: Damien Zammit <damien@zamaudio.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 pbonzini@redhat.com, stefanb@linux.ibm.com, peter.maydell@linaro.org,
 kwolf@redhat.com, berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
Subject: [PATCH v5 0/5 qemu] GNU/Hurd support
Message-ID: <20260208055858.2166524-1-damien@zamaudio.com>
Feedback-ID: 43209410:user:proton
X-Pm-Message-ID: 27c7a87555fe4fee10747d1c7f0a5908f28f56f1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=damien@zamaudio.com;
 helo=mail-4317.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

This patchset is hopefully my final attempt to upstream qemu support for GN=
U/Hurd.
All review comments have been considered and addressed in the patches.
Some people want minimal diff to tpm header, others want me to delete code.
I went with the reduced diff because it's only one line of code change to f=
ix it,
and passed review originally in other attempts.

This has been rebased onto:
* cd5a79dc98 (origin/master, origin/HEAD) Merge tag 'for_upstream' of ...=
=20

TESTED: Compiles on GNU/Hurd using:
=09../configure --target-list=3Di386-softmmu,x86_64-softmmu
=09ninja

Executed qemu-system-{i386,x86_64} on GNU/Hurd x86_64 successfully.

Thanks,
Damien



