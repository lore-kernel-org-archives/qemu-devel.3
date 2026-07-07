Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FB3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8kQ-0004dw-Qn; Tue, 07 Jul 2026 12:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wh8kP-0004de-3p; Tue, 07 Jul 2026 12:34:13 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wh8kN-0003ME-Bd; Tue, 07 Jul 2026 12:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=DPatV5yTQvD197fS5ZQ6CMUoPUUvo+MM7+Mtlo2uD+Q=; b=R1/MlQ1rKA8e+jGQtfoJQI8fm6
 w9QXJpLpQBQ5zehrMPug9pcsRdGZ5B0lUe4VRJzphW2ENjayowB6LvhtO7VrhezVIiL44a/pCqW8D
 XWri3KC/YH0xNTv5ICDI8Pxp9LBeneduxP9HZFJ77l5qnBJk51VEDDH4WH2o+5SX2TA7aWXWYeIfD
 uG2zui1t9CQm2yhxeqTz4NBr4HEvI3YnSd6dBcWTTHFWTbjyqHGsKtI3gxlqc3Mxoifagi659HHm4
 anKNUhF5U6BA+aAzLO9dRpFQyYP4MFXvhiMOyF/b3VJ4r+N3ewiYOQwZnCJ+XTrYZu6800kBTFXrZ
 ny7eMvuoJCfVBkb/cNhPwFm+iTcLUzsYdPmbLi37RUIb4ttp08twmKkM5o1vnD9vt2zq9fEDyjip4
 wYkvcmpDoxli6CmjCxbtjJepUZj1iXS5u+IacrVcGgx9A2hf/vHlcKjSm/7nXaOmw+3BScX8HE1RU
 TUgg0vynqaUxO3aV0x0tOAATN4pBUna1OKZZJkdhI/sv+zMvyu/hetw+hFqB0jNaNIEdLACS4lxLW
 0JqYqZA6jU56HRVNFvf18Z6UxGWb1bx9VtTdgDljKbMqQJxt1PEoctb1W9ybdELoSN6RaI1Z0fAeO
 iSUjhmOGgIfGWU9b7gvIeUwwn8ITa/pYh4L2H29bA=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] tests/9p: reduce xattr size to 1k
Date: Tue, 07 Jul 2026 18:34:05 +0200
Message-ID: <5113275.31r3eYUQgx@weasel>
In-Reply-To: <9cc6ae91-9379-4469-8109-f3aed3f0f4b1@oss.qualcomm.com>
References: <E1wffqw-001Sc8-I9@kylie.crudebyte.com>
 <9cc6ae91-9379-4469-8109-f3aed3f0f4b1@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Monday, 6 July 2026 23:15:38 CEST Pierrick Bouvier wrote:
> On 7/3/2026 8:26 AM, Christian Schoenebeck wrote:
> > On host systems with ext4 and ea_inode capability not enabled, the max.
> > size for xattr values is slightly below 4k, which caused the new xattr
> > tests to fail on such host systems.
> > 
> > Reduce the xattr size for our tests to 1k to prevent them to fail on such
> > host systems.
> > 
> > Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> > Fixes: 04a62cdfe8 ("tests/9p: add 3 xattr FID limit test cases (local fs
> > driver)") Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> > 
> >  tests/qtest/virtio-9p-test.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Looks good for me, and fix the failure observed.

Good, thanks!

> In case you want the test to be more complete, you may try to detect
> ea_node presence, and adapt the size to it.

No need ATM. These tests actually don't require large xattr values right now.

/Christian




