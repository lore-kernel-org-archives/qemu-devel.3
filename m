Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94395C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtl2W-0000dH-RP; Tue, 11 Aug 2026 07:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wtl2S-0000d4-NW
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:53:01 -0400
Received: from out162-62-58-211.mail.qq.com ([162.62.58.211])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo-cheng@vip.qq.com>)
 id 1wtl2Q-0000ok-2g
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 07:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vip.qq.com;
 s=s201512; t=1786449166;
 bh=jd8GTUmhEbs5oYlICH6ZQMUTNlNZIWVu+3J32pr7RWU=;
 h=Date:Subject:From:To:Cc;
 b=kBAGUl0D1MmAGrE6TVQAyUrJJOQGjJ46JfzXT2EW5IRUabES+hGv0jy2y9iNUovyM
 /qqKdA/nhju8Z4ktOwy/VaQ+kQEeQIe1QWYf7knm6y7HDUUYKN8za6N1xCm84s2PR+
 lo6TyvlRl+pjtfA0buORLjmj1YGoD7UK549k9DK8=
Received: from vip.qq.com ([111.52.124.140])
 by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
 id D2B80679; Tue, 11 Aug 2026 19:52:43 +0800
X-QQ-mid: xmsmtpt1786449163t6ejwhmmz
Message-ID: <tencent_7CCA5131E298B98FB02B48E362186F801A09@qq.com>
X-QQ-XMAILINFO: MyuUxGYaDVWV+T3CxxCEIv1X8L6DOEtNahQ9tPf2UyNlClUpAL+Joteev7XV8a
 P659Bjt5AS0A9XOfX6y+hNkMQFooUp7XFyQlnI7HCtQDpFhoXq/FpB2UEckksbOHlbRpevVXwQLp
 rnKcjKqPsENetWDqyWJqNnamY4thpIUQG04k+hQDjLWUIoVOSolJMQg6pikPjkA0h4eZHB9OqXSF
 uI8nKtjq/2oQJd/+3FrIplXU37Z3SAh27odv9VxT8eVFfagum/wbUqhQ2epy5aZkIeCpOlSB64BI
 gqrpJz5GqkuMFsEbmfZsYZkL99bt8MKuJKYcQdbdfHmbI/VMoxmsShu8U8w7qklDWG4c/AqifNkw
 /0CrvyU7YnKJVXAu1EpQUcvH/pw4SQi6mVaIDoSfNlGzrF14uTaBV/5LI5eJLtsZ9iV+vomyT7+M
 rSZdSEUiIp4mwZS0H0wo5+hFeD6zq9ppUrDz6YgCiPju6sUgDTaeyCKSxj1CxksP9k6ZbEy3QPFV
 +OQ6Bkm0LvzCJNiLdtvCOdHPPywCd12mB+hXXDDiMpRYM8RVWA8CRqhgEZGE7CV7KMCskIWEsyuM
 59w9kvsUQj/z7VDGwNvp1oMN2dk1DDE5lxJ5aueMmgj2nazhz6d3axtMpu6CZeDbJmFlcsTwQmKl
 Ua56ECCGxGlDMMK8aOBB1Yw1v2JyKWvD0prv4QTKQFeXFZ2Vp+ljVBjqrN61roJt8Eg/n7NyOALq
 skRl1KsJat8maFTXqtnxxVO+gdmBVIQBLugc8CIeVAhwxyWqQBNzab1evuh/5Er91DE77MWF7PEZ
 Y5WblACSIHzekQocx4oGh7XCERmKU2oy5kh/8XSCCYj46gqzC65hDQl8xXblREWW0zsvhU9KpTsD
 5Xe/bnHVbp/ncinURs8XolamtV0DedKmvTOcuGdGlJYzRpq49pWDeSCQPbsxTStiYMdIrKRX5jVL
 GUB4wqlE9OdWmqW6G3jcMB/xzYugAlWrGkgCFfLj7Qs3s57kkaFp62UfbEk/IYsMUJFrU5Uqp5ap
 M+i/7TcTTjskV/9nPg5JpXNSW8Scvrmqa6BVlkfKXy4hwG+m5qGgNS8BrkQuNKPhU94XDh0Bouuz
 1x3rvbcqVEya7fYBtaurkhYkQ0WZUk8Gi3wAHPuEiw2UveuluXkf6y1xJeWJxWW5WN8eFX
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
Date: Tue, 11 Aug 2026 19:40:24 +0800
Subject: [PATCH] docs/nvme: fix doubled word in detached namespace description
From: Leo Cheng <leo-cheng@vip.qq.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
X-OQ-MSGID: <178644916508.478580.4657247114929594302@vip.qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.58.211; envelope-from=leo-cheng@vip.qq.com;
 helo=out162-62-58-211.mail.qq.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Leo Cheng <leo-cheng@vip.qq.com>
---
 docs/system/devices/nvme.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index 98a4401..531f156 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -142,7 +142,7 @@ linked to an ``nvme-subsys`` device allows additional ``nvme-ns`` parameters:
   are hotplugged).
 
 ``detached`` (default: ``off``)
-  If set to ``on``, the namespace will be be available in the subsystem, but
+  If set to ``on``, the namespace will be available in the subsystem, but
   not attached to any controllers initially. A shared namespace with this set
   to ``on`` will never be automatically attached to controllers.
 
-- 
2.43.0



