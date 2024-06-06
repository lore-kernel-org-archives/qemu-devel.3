Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E74C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 08:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8EA-0007tq-CX; Thu, 06 Jun 2024 04:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8E7-0007tP-GF
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sF8E5-0007uw-MK
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717661520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nfp19UPOB20xbdbfrYsfsdXmc0VAypqgspHKW+ngL4U=;
 b=J3DzLyMOI9mrDkuJP2lpJ6gUD3FEF18oa7E6CKGntOa7mYkxq2EeplrI47rTlvq4R7A9Rb
 l/BwLS4DbhrgGECiyHNsUzWF78B49CxCM/G6f9m/B+WspRnQddjg4xMuVGFFu6WIhXZx/6
 u+a0UHIVu5ThO+am4OEG6czHYtdbC8E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-4XnAH9q2OyaJpIxvUhVP2w-1; Thu, 06 Jun 2024 04:11:58 -0400
X-MC-Unique: 4XnAH9q2OyaJpIxvUhVP2w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a68f654dc69so63344766b.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 01:11:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717661517; x=1718266317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nfp19UPOB20xbdbfrYsfsdXmc0VAypqgspHKW+ngL4U=;
 b=FPWCHz5hLYumlhxIH/hm12TU4yxRbnFv4SiBqjEfubXoAWKJHXMMdmyQiXh8FYV+cI
 ScR2AvrTl4S6VZ6aNSZrmnMvGEGclh/ohdFsoU712ultoPqxzJF6dTMemyWw8yxuz9md
 dpZqWjlq3vL8LDDULTedwiw3DiMem9E9wTOITpGL/rhbdCGxct6npDIRrjaBVEYy2R18
 xdY8bZlvwm5uRPEKGw8Cq24GtjfHMU195grRm1qM6Enmd607D7iiR/izl+RE+RjeJhvC
 U5aO7ajkzwGiZzCpnAtYQgEdVYhI7/Ic8FfIl1l0gfiG9doVXw3cbzGg+Dbu/Ng4X+pi
 cSlw==
X-Gm-Message-State: AOJu0Yy9ongtmTXZ0O620HeHMDeVD1S/xxW7jtN1JXFAIg5W5Lj3bBkf
 iJc31DoPiav1hYfUebzW9Zu4OE3IEHJEK87w/NqIK1L+wX8Ru6gvDNIjIQ596J0dMbbdvu8rAsr
 OgyEju1H6t/sYX2RCRKS2WHwqtaa5tmID+zHMVP9yzJcXLWRWDu6knKww+r4PoDR6mAvO0TgK06
 yGUBiEg+AU6LOtAbbw0iRVocKGJo8iyFjWnP1C
X-Received: by 2002:a17:906:3650:b0:a69:280:f379 with SMTP id
 a640c23a62f3a-a699f88c6d8mr370081066b.45.1717661516403; 
 Thu, 06 Jun 2024 01:11:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlGWGjkenTA70Qm4nG1gz6DmejD1cgJAWiuUSJv8K31825bl+TD/cSr/lVVQk/DMMnCq2dvA==
X-Received: by 2002:a17:906:3650:b0:a69:280:f379 with SMTP id
 a640c23a62f3a-a699f88c6d8mr370078366b.45.1717661515831; 
 Thu, 06 Jun 2024 01:11:55 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805c9e13sm60544666b.54.2024.06.06.01.11.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 01:11:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] python: expect a working python3-tomli package for Python
 <3.11
Date: Thu,  6 Jun 2024 10:11:51 +0200
Message-ID: <20240606081153.2457559-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

pythondeps.toml is parsed using either Python's embedded tomllib parser
new in Python 3.11, or the external tomli library for older versions.
The latter however was absent in Ubuntu 20.04, so we include a copy of
the wheel in python/wheels.  (For Debian bullseye, it is included in
the backports repository).

Now that Ubuntu 20.04 is not supported anymore, it can be dropped;
and with it the "ensure" subcommand of mkvenv.py, which was only
needed to bootstrap the venv with the TOML parser needed by
"ensuregroup".

Back when mkvenv.py was implemented, John and I had an idea of an
"isolated mode" that does not use any system packages.  With these
patches this means that, as things stand, the isolated mode can only
work with Python 3.11+; older versions would need special code in
mkvenv.py to install tomli from PyPI if system_site_packages==False[1].
Since the isolated mode does not exist yet, this is left for the future
comtemplation.

Paolo

[1] isolated mode probably would benefit from installing distlib instead
of using the pip._vendor.distlib hack; therefore, adding tomli would
not be a huge deal anyway.

Paolo Bonzini (2):
  Revert "python: use vendored tomli"
  python: mkvenv: remove ensure command

 docs/devel/build-system.rst                |  13 ++-
 configure                                  |   4 -
 python/scripts/mkvenv.py                   | 105 ---------------------
 python/scripts/vendor.py                   |   3 -
 python/wheels/tomli-2.0.1-py3-none-any.whl | Bin 12757 -> 0 bytes
 5 files changed, 6 insertions(+), 119 deletions(-)
 delete mode 100644 python/wheels/tomli-2.0.1-py3-none-any.whl

-- 
2.45.1


