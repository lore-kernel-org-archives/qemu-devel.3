Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FBF2C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:42:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6XAl-00021C-GX; Tue, 15 Sep 2026 13:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XAe-0001zu-7M; Tue, 15 Sep 2026 13:42:17 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jic23@kernel.org>)
 id 1x6XAc-0001Vd-MB; Tue, 15 Sep 2026 13:42:15 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 063AB600D1;
 Tue, 15 Sep 2026 17:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70621F000FF;
 Tue, 15 Sep 2026 17:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789494132;
 bh=1AThVhaGeh4/PJ05r5sSt3mgE4UqxOGfJ9KavZCZd/Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=h7UYsLSDX/7CbrxPhBtoDfbdbGOSAGhcEu6okfZXeU3IOgDZMqCVEsEgf/62sAiFg
 R+QDQHo7trhbSxuIY+irX+KSLfDQM8Pgs7IVKat2yH4otYZzbzrCfblYngUbnvGxjs
 3eHhjGDplU8Ellbrjn2+oFa4wFO0ub4AzwHtHS+ce9fPvjZT+4xdV5uw77rqbyrguN
 MKN2GZD4vb++oOraSlkuFHGyUn/xH1oEriPdFxpJuhdHav5WMKIA32M+Z9QtWkMNiH
 ff5oKS/9pnsHYhvLeoiUXEJ+o7S5Bqmx2tFr3mDlZjl6X0smH7ESoJkUztQqu8hutJ
 dg1CwNIwl9RKQ==
Date: Tue, 15 Sep 2026 18:42:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Kevin Wolf
 <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Lukas Straub <lukasstraub2@web.de>, Eric Blake
 <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, linux-cxl@vger.kernel.org, Zhao Liu
 <zhao1.liu@intel.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 2/7] qapi: convert remaining simple intros for cxl.json
Message-ID: <20260915184206.0c7a608f@jic23-hlaptop>
In-Reply-To: <20260915151127.1002244-3-jsnow@redhat.com>
References: <20260915151127.1002244-1-jsnow@redhat.com>
 <20260915151127.1002244-3-jsnow@redhat.com>
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

On Tue, 15 Sep 2026 11:11:22 -0400
John Snow <jsnow@redhat.com> wrote:

> These are either structs or unions that are used in an inlinable
> context: i.e. the generated documentation is likely to feature a
> version of this documentation block that does not include the intro in
> context of another command, event, or structure.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks

