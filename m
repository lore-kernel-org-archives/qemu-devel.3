Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD188C531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 21:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn1OD-0001Ih-GR; Thu, 23 Jul 2026 17:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cybersnow_2001@tutamail.com>)
 id 1wn0S8-0005I1-Rl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:55:36 -0400
Received: from mail.w13.tutanota.de ([185.205.69.213])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cybersnow_2001@tutamail.com>)
 id 1wn0S6-0003qj-VY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 16:55:36 -0400
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w13.tutanota.de (Postfix) with ESMTP id CDE4516318FD8
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 22:55:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784840130; 
 s=s1; d=tutamail.com;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=wifAd4bap7IZtxyHbkHXuYwKmmzvAHVhIA2W1D6pZ0w=;
 b=byUKpGz8YXKv9TFBVtUhlgzy9b/YpQFxn6ZWDASFavhLIfmtguKMUCVHhmJVhY5X
 VRsEscal25RcYQjFEDwrfxIh4ZQ6Jtf+shu+TmEMFT+FBZ+VDht+2j4zK1xo635Bv3B
 Sts1fhqNIyLkCRTkwLcam88p6P+VMGx20ROpdwIJ9+/I+mXHHHm/uHydNPZjQdQSmZJ
 CLl8FHFEDngyF+PwC4Lc2neg8ksTirAQ6Q3GJLcmzLqKRf3hVe3856tJJWolCZjtzz5
 H0aaT19rvLh0tpvXsSBnUnsUAOMq66D6fHzsRPbfNZZ+1HS42ZM6QDrm2HnP6+1jxF5
 UQHUs55MFg==
Date: Thu, 23 Jul 2026 22:55:30 +0200 (CEST)
To: Qemu Devel <qemu-devel@nongnu.org>
Message-ID: <OyFkh7E--J-9@tutamail.com>
Subject: Git Recurse doesn't grab DTC subprojects
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: 0148cefbf77245a42b8d92790169c2e5f3889e2ac922109814e9377b88997be23fd058959082c4e525ef1b19740c34b7ef4478cd506e389835ad86d84f5ca78a4f:TurnOnPrivacy!:tutamail
Received-SPF: pass client-ip=185.205.69.213;
 envelope-from=cybersnow_2001@tutamail.com; helo=mail.w13.tutanota.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 23 Jul 2026 17:55:35 -0400
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
Reply-to:  cybersnow_2001@tutamail.com
From: cybersnow_2001--- via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When doing "git clone --shallow-submodules --recurse-submodules", the DTC directory isn't grabbed in the subprojects directory. This make impossible to build QEmu in an offline/standalone way. On github mirror, you can put a symlink of the actual DTC project. thanks.

