Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A450AC982E6
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 00:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8oY7-0001fb-HG; Mon, 21 Sep 2026 20:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x8oY4-0001ep-UK; Mon, 21 Sep 2026 20:39:53 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x8oY3-0006er-Bh; Mon, 21 Sep 2026 20:39:52 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26DAD60210;
 Tue, 22 Sep 2026 00:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FA41F000FF;
 Tue, 22 Sep 2026 00:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790037587;
 bh=50nU5Tf/W6+TzXP/ktV4AFtIrpd6f4nmN4oL0ztCO6M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=bxG0XaJLpm/aXAimXYdvFiz/HKzumzqEI6WtmKBvfa5ND+z1N/9hYELj8234sWiHG
 9IHG3aSqHDIzJnNCe2QiRy8OwkObbMhLaJlaFQNMNMhbjTazUeR+cCnu/6+jwTVX0z
 z1nkFH92wZ0xEXcJ0LQ3Z46EY8h4uR2MIv8etDgbtingkf8aU6nyw30qBL2NSyCnnJ
 Byw997+zzAlVnG95A/3Mf1LU+NAm33qcj1+JMBndvZKTGNS5yyMUjzaaubkhyxbn08
 CX13S3BjPoHWoQGdXTqpl8EWE+2RStdVHqPce1GNv3Y8l3a5N1ZHPtA0/1PfrhTn8Z
 rMdhrIH1f8Frg==
Date: Tue, 22 Sep 2026 01:39:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Xu
 <peterx@redhat.com>, Junjie Cao <junjie.cao@intel.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, linux-cxl@vger.kernel.org, Jason Wang
 <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@oss.qualcomm.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@mailo.com>, Lukas Straub
 <lukasstraub2@web.de>
Subject: Re: [PATCH v5 2/7] qapi: convert remaining simple intros for cxl.json
Message-ID: <20260922013942.0abc8165@jic23-hlaptop>
In-Reply-To: <20260917194614.549584-3-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
 <20260917194614.549584-3-jsnow@redhat.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=jic23@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 17 Sep 2026 15:46:09 -0400
John Snow <jsnow@redhat.com> wrote:

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

