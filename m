Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608ECC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Rm-0004Yk-5Z; Tue, 07 Jul 2026 13:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wh9Rg-0004YH-Or; Tue, 07 Jul 2026 13:18:56 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wh9Rd-0007lz-3e; Tue, 07 Jul 2026 13:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=cBCF1BTEc9yGf8jrHpE+Apg5YdNXY/5jhxo6Adq/MEs=; b=VHPNhPcxfJ0LgzshIEybkPfGJL
 nuG+2VIIjiw/JAkzznByIkpm7jiNVjkESL8r5jknjPuuem7J2VGK7djFoVOu2T3D0ZcGxjDoLKi1n
 mCDhIjHkiNYE8D36ZsZ+NRJvVk5qekrUMu5N7DWTirdjWvDDvzFbOmS3J4FSesvf0f8/2G1Oihzmx
 49TTMp+NCuwKSI4lQK6nPqisAFNjX/eWM2AZyZB4GHdHd7RRLdk2jM9BZiGFNvRQ3GZFxOPSW2Elf
 AXk5gNdXcGuI9Db1zM7KwyfVmEsiSXOOIney2hmIfDiyg3zBLkGRzj6v4VXaJvkPgdEN+ZUkp6CXK
 ogO0RUZ0ZN4xT3vMKe+X+Dgo10wDWW84JHafOBODcpWaQTVrGaY/yT/AC/9+4EQ8GvAE7C4FgR41L
 wS+SWj70Tt7U1PixmgS0ZwdbA6AMlmqaP5LUAqr8Cosh6tPO5McxIWkyRxmWfwcpPE9B0iqkDK3pV
 fZjZiRomfzUPorySVSU7ABFguNqrKPY/vp0cECDflqWdHkd0xlDK/CtrZzf8br5QoNyHPcP22aZZ1
 u21gSFhxmqNQNYUciE1fg5g/nwF7VUzpTIAuff4uTl4/O6DRQQXZVn3lGGJRHVw1fgTAGGGy+q9GK
 NnnzED9lJP56Z/YBNuptjbCHaQIuz40KeenBKy1X0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] tests/9p: reduce xattr size to 1k
Date: Tue, 07 Jul 2026 19:18:49 +0200
Message-ID: <1960804.tdWV9SEqCh@weasel>
In-Reply-To: <E1wffqw-001Sc8-I9@kylie.crudebyte.com>
References: <E1wffqw-001Sc8-I9@kylie.crudebyte.com>
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

On Friday, 3 July 2026 17:26:08 CEST Christian Schoenebeck wrote:
> On host systems with ext4 and ea_inode capability not enabled, the max. size
> for xattr values is slightly below 4k, which caused the new xattr tests to
> fail on such host systems.
> 
> Reduce the xattr size for our tests to 1k to prevent them to fail on such
> host systems.
> 
> Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Fixes: 04a62cdfe8 ("tests/9p: add 3 xattr FID limit test cases (local fs
> driver)") Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



