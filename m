Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72963E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxj3-0005M5-8t; Tue, 10 Dec 2024 05:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d06a9d843fb65351e0e4dc42ba0c404f01ea92b3@kylie.crudebyte.com>)
 id 1tKxj0-0005Kd-17; Tue, 10 Dec 2024 05:44:18 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d06a9d843fb65351e0e4dc42ba0c404f01ea92b3@kylie.crudebyte.com>)
 id 1tKxiy-0007Rv-HG; Tue, 10 Dec 2024 05:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=mdn+juAp1H+ifnO6QfL+yqBHc4TpJOra8ZUsGcrKC1o=; b=V6kqx
 fgAdpH9ogd4fAp0GjueTnT+bveisJBwfSTWVEKFZrRNx8hBNuR+meGkqEhI2iIyF52FUn0oKZbiOF
 bbpHmSZqteyRQxKeW17tKfWFrC86pwsHDfmmo9kbi0V/AeI2JuGLq+cjaLB5LmfGgg+0RkVugTDQf
 gWxl89xJBOikIS17U1c3Wjhe+BYfEmwqz1Jbz+DPj/EPmDdOOGaum0JKuCcLz8wZAKWiPwTwdNP9S
 UKdhU2eEOEP0Qp1Oja1QguVAwsKMWyncRHxarxqTnELQZS+74RaOWyeUzdqJEzdq6VaJv6x3eZZMh
 lEM1ZXDLLZ8a/dCSXJN/1f++dii0PpFSJATWpgkHghEqv4cgSlPJnEjA42lEOLlNk9ei3Q4GV8fgp
 yd853yTFIyhO7hpE66U1oK0V0PGZfuyT833zVILuw+iPta+apY9o83uQ45zgeZHGbNIdEf20Cmeow
 INFtV5ZxmEIeewslfBKwde7H/aK6F2HLSFoOxLSBfmvYhVbXzmCKKZuZ23sVkjJpP+9ql06WEC7MW
 9Qb64zWyBY5oXK33WMAWlfH8GBG6NjKu7YhZ2dtJsrLF++qDTSo7spDf7bv9YuNvAxpTT3PoNaR9Z
 rSbLPfusLMNUpnG1fPGrDczsLEVOu4HqKCoUwYt9nlhZotHDInU+0tpBECYve8=;
Message-Id: <cover.1733825219.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 10 Dec 2024 11:07:00 +0100
Subject: [PULL for-9.2 0/1] 9p queue 2024-12-10
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d06a9d843fb65351e0e4dc42ba0c404f01ea92b3@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit 1cf9bc6eba7506ab6d9de635f224259225f63466:

  Update version for v9.2.0-rc3 release (2024-12-03 17:56:12 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20241210

for you to fetch changes up to d06a9d843fb65351e0e4dc42ba0c404f01ea92b3:

  9pfs: fix regression regarding CVE-2023-2861 (2024-12-10 10:24:52 +0100)

----------------------------------------------------------------
* Fix a regression regarding CVE-2023-2861 with security_model=passthrough
  which caused certain sockets on guest to fail.

----------------------------------------------------------------
Christian Schoenebeck (1):
      9pfs: fix regression regarding CVE-2023-2861

 hw/9pfs/9p-util.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

