Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BBBC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 21:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubnE2-0006vz-Tp; Tue, 15 Jul 2025 17:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ubnCt-0006Yr-3a
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ubnCq-0003ye-61
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 17:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752614933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nlMQIeUfyxrF7ic/E+fe4VfE/z/IxfF+MiFfE/fsdDE=;
 b=h4Enfu/9bvufvqo13B36u5wLcyOQymQYPMFrx5q6j8yczfa9Z23Xp1T5Frh9bG+hXUdTPk
 JTT/ymumpftjpj/KYXYPNl0rqJ3HRBMuV8ctQxs9QdaHkvRofJPm4jfu1zqceDjgSSsbfK
 cY4BIm5WIb3GH/coYdk3ntIXthbNZxg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-3BzXPWMAM-a2drcPbItaNQ-1; Tue,
 15 Jul 2025 17:28:52 -0400
X-MC-Unique: 3BzXPWMAM-a2drcPbItaNQ-1
X-Mimecast-MFC-AGG-ID: 3BzXPWMAM-a2drcPbItaNQ_1752614931
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F351195608F; Tue, 15 Jul 2025 21:28:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34455180045B; Tue, 15 Jul 2025 21:28:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	John Snow <jsnow@redhat.com>
Subject: [PATCH 0/2] docs, python: bump sphinx preferred version
Date: Tue, 15 Jul 2025 17:28:46 -0400
Message-ID: <20250715212848.171879-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CI: https://gitlab.com/jsnow/qemu/-/pipelines/1928836481=0D
=0D
Unlike the previous series, this series only adjusts the *preferred*=0D
sphinx version to be higher, leaving the accepted version at 3.4.3, the=0D
version that CentOS Stream 9 still ships with.=0D
=0D
Unfortunately, this means we can't cut out the compatibility code for=0D
sphinx we're still carrying around just yet, but we'll await that=0D
glorious moment to arrive on some future day.=0D
=0D
Sphinx 6.2.1 is being chosen as the new default because it still offers=0D
support for Python 3.8+, but is new enough to support Python 3.13+.=0D
=0D
Distro version information for supported platforms as of 2025-07-15:=0D
=0D
distro              python3  pip     setuptools  sphinx=0D
-------------------------------------------------------=0D
alpine_3_19         3.11.13  23.3.1  70.3.0      6.2.1=0D
alpine_3_20         3.12.11  24.0    70.3.0      7.2.6=0D
alpine_3_21         3.12.11  24.3.1  70.3.0      8.1.3=0D
alpine_3_22         3.12.11  25.1.1  80.9.0      8.2.3=0D
centos_stream_9     3.9.23   21.3.1  53.0.0      3.4.3=0D
centos_stream_10    3.12.11  23.3.2  69.0.3      7.2.6=0D
debian_12           3.11.2   23.0.1  66.1.1      5.3.0=0D
fedora_41           3.13.5   24.2    69.2.0      7.3.7=0D
fedora_42           3.13.5   24.3.1  74.1.3      8.1.3=0D
freebsd             3.11.13  23.3.2  63.1.0      5.3.0=0D
homebrew            3.13.5   ---     80.9.0      8.2.3=0D
macports            3.13.5   25.1.1  78.1.1      8.2.3=0D
openbsd             3.12.11  25.1.1  79.0.1      8.2.3=0D
pkgsrc_current      3.12.11  25.1.1  80.9.0      8.2.3=0D
ubuntu_22_04        3.10.12  22.0.2  59.6.0      4.3.2=0D
ubuntu_24_04        3.12.3   24.0    68.1.2      7.2.6=0D
ubuntu_24_10        3.12.7   24.2    74.1.2      7.4.7=0D
ubuntu_25_04        3.13.3   25.0    75.8.0      8.1.3=0D
=0D
Akihiko Odaki (2):=0D
  docs: Bump sphinx to 6.2.1=0D
  MAINTAINERS: Add docs/requirements.txt=0D
=0D
 MAINTAINERS           | 1 +=0D
 docs/requirements.txt | 4 ++--=0D
 pythondeps.toml       | 4 ++--=0D
 3 files changed, 5 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.50.0=0D
=0D


