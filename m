Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3067606A6FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=snOtzcs3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUUri-0001BE-Kw; Fri, 20 Nov 2026 15:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrI-00017j-DC
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:20 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUUrD-0001rm-Sy
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 15:05:17 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1256339f8f.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795205113; x=1795809913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ifxOWI38pqFVNlpUdfEySqZ3Bxhw7VQg2EgZQ4sXqpo=;
 b=snOtzcs3dBopr3wHqj66Ysak83TSrGlHYN+XxxpW6l4ThxXl0IOzzMRGtU7VZFxKcp
 eM5oghfDhu23m5zBvueDM1nnXOb0GGWPHIMhsHe/wcUxHglQNvMfTTkkJ+BaM/HXB44J
 fPdEMbn4AmFVObkmw5rtV0iZcjpvC9Jg/ECAVF8h8lAqbEQHBketu7i/muM2JBPQwe+q
 SYejXUWBR3SGVo8WvgqG/BI7e0WuOYLrV+WuXfIy5iWf6VVlnE3rwrMD1u3ULdvQSEvM
 sc3j752otqNmqs/nLhxLGqCKz29OeHxbDLfIkko032SFHrCa9sOeHyUmeL32E1ivrIqY
 04ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795205113; x=1795809913;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ifxOWI38pqFVNlpUdfEySqZ3Bxhw7VQg2EgZQ4sXqpo=;
 b=txTeNLvjtd9ZgeXtFoy+WK6EFJRg9WfTX+ZeQc9cn+oV41JTrnOVCJuHUD2lj+jKUG
 19hZQBsFt7CVR8LmlsiUmURlovIkaBX8Qwkpv0jEpw5of3/77nWxihp9Ed0JkOX/6uqt
 PZpbsSgEDIeXlO8g/SOJrPid0PCyVXU6/lsIAcD+GCb9wOCMqRcr2ublhZl+7VSoc1Pu
 rZlZc1CtTQ8xsNLBCkBo95K7akcvC60GwQ4hlkVYPuEnqLn8HpqS59OGid9PoABYdtFp
 N8xpkXMQtH6U4OcZHZ4wL9h+IV3oG53QAV+lKgXMYY81XCiwyNOr1DFkbJ4ZSuTbftb9
 TPsg==
X-Gm-Message-State: APuU4Z/dndmAPuvL/MfJrRYFfYOb1tNLToSQ6KL11MyzgHQv0Bs3f6KU
 VRsKNBAwzOCYRuGpkAf6rMnczLos5kj4xhaG5k3IlyZPFCYBMqiriY5QN3l9uCiQfsI=
X-Gm-Gg: AZFdTZfdm+X6Mb382iqCENHygntqpPB4ZtC3bS5rwI52UtodzOtC7wENzUKM2/IeEjd
 D/OQMZsX11PmZgRbmZBqK2bExC89DLqpiN1URnj/jkoJROrrDaWEzSpjqxGvf3stTPFPqpcikBz
 7b9RfMqsii/pMKy1o2YGntln6NFohq2/XL4t/O5CcAyeTACkFGnZTyJn1CthWSpYmi/rqZvH3vU
 9Xj1HaZl2qV+mhEDaQceIVY2nYJbawpWhVCK2TeIt3g21dyov8ejzg+neOQoxyzyLpUgKtcWYtm
 Hc9dw/jlINnRbq5sDLL0qqYFwxzGT77tCV0sZzCOvqgyYfZrAEjCbG4q7AtcQrwn3e37laVqEyo
 cW/xhrD/4cRx06m+IAF0EvhoYJrFeRk6K7pwIuiybk8Q3Bvm3kwCLRDw1VJlVOsWDYCSXcsNoLl
 Ihn46GDEIu8gMQTBPFBicO7Wy9aA7tSKRi3vX2yQd/gKM0nMHP05X8uYTrjKrEZltjs0hNe4bGe
 iCEYyfxIFd8ZjkL1MkvE2/DE9m6a4cgYTA4Kw4xqFUer/vD3/ypiDiZDrCQ3Lm58J+tun9jim6s
 02UWTJoVOVRr0CeiZ3TCFP7zz5bQ
X-Received: by 2002:a05:6000:250e:b0:492:7efe:3fc4 with SMTP id
 ffacd0b85a97d-4abb4b86685mr9204284f8f.21.1795205113259; 
 Fri, 20 Nov 2026 12:05:13 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf629dsm6907611f8f.9.2026.11.20.12.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:05:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B0035F7FE;
 Fri, 20 Nov 2026 20:05:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 00/22] MAINTAINER updates and get_maintainer.py
Date: Fri, 20 Nov 2026 20:04:48 +0000
Message-ID: <20261120200511.822573-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I continued to update my port of get_maintainers.py and it grew a few
new options which I used in my recent talk. These are:

  --validate
  --list-maintainers
  --list-absent-maintainers-since

I also added the git and roles flags for compatibility with the way
the perl script is invoked by the git's cccmd.

There is now an ancillary script to plot maintainer experience so we
can see the distribution of experience in our maintainer pool.

On the way I found more inconsistencies in MAINTAINERS so I cleaned
those up while I was at it.

Alex.

Alex Bennée (22):
  scripts/get_maintainer.py: minimal argument parsing
  scripts/get_maintainer.py: resolve the source path
  scripts/get_maintainer.py: initial parsing of MAINTAINERS
  scripts/get_maintainer.py: add support for -f
  scripts/get_maintainer.py: add support reading patch files
  scripts/get_maintainer.py: add keyword (K:) support
  scripts/get_maintainer.py: implement basic git fallback support
  scripts/get_maintainer.py: add --list-[maintained|reviewed]-by
  scripts/get_maintainer.py: add --file-summary option
  scripts/get_maintainer.py: optimise glob matching with Paths
  scripts/get_maintainer.py: add support for gitlab handles
  scripts/get_maintainer.py: implement --noroles/--norolestats
  scripts/get_maintainer.py: expand --validate output to CSV summary
  scripts/get_maintainer.py: add --list-maintainers
  scripts/get_maintainer.py: add --list-absent-maintainers-since
  scripts/maintainer: add plot-maintainer-experience.py
  gitlab: add a check-maintainers task
  MAINTAINERS: update Daniel's entries to be consistent
  MAINTAINERS: make Collin's entries consistent with .mailmap
  MAINTAINERS: make LIU's entries consistent
  MAINTAINERS: use consistent capitalisation for Alistair
  MAINTAINERS: update security reporting links

 MAINTAINERS                                   |  48 +-
 .gitlab-ci.d/static_checks.yml                |   9 +
 .mailmap                                      |   1 +
 scripts/get_maintainer.py                     | 886 ++++++++++++++++++
 .../maintainers/plot-maintainer-experience.py | 163 ++++
 5 files changed, 1082 insertions(+), 25 deletions(-)
 create mode 100755 scripts/get_maintainer.py
 create mode 100755 scripts/maintainers/plot-maintainer-experience.py

-- 
2.47.3


