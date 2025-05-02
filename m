Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F1BC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 15:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEV7F-0001Ka-6x; Mon, 12 May 2025 11:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEV70-0001AC-IP; Mon, 12 May 2025 11:30:39 -0400
Received: from out162-62-57-49.mail.qq.com ([162.62.57.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1uEV6v-0006Pn-VX; Mon, 12 May 2025 11:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1747063816; bh=VR6yBohnBOWmff6WZS83sMGnbNiRHrwEFLHpUzJJkfA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=UIIYCCuTx/GEK/3mh0vXMy0t8hHnoskjTkhxT0NZjNKd78ykxEpXValM+IN0XXSF3
 eXhEoQUoq7A121JMf4PptAtY3q8PLLRHPSZ+BtGx33b2jeabPmoiIALNPdg3/odkto
 jHLPQkUworOZPjiCQbpE/vFOqe3tWgoBXHeGKTnU=
Received: from localhost.localdomain ([117.147.34.74])
 by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
 id 601A7CD3; Mon, 12 May 2025 23:24:01 +0800
X-QQ-mid: xmsmtpt1747063441tweh6s15k
Message-ID: <tencent_07B217E7CB4D92340CF42772A024FA838207@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeah2krL13RxWWRRoaddUjXMHcb7pXyGtGun3dT9T+QaTsmhorWfDV
 WFir2fwPJ4DLENr+p/o69TmhMdIIsanLQmw3bFYlOQOX8Cpto1S5edJXeRk5lwU18uT9MYjyrnGx
 6KcFK2eP0jZK9FWOohoKv9Zd6zUPUXCLBcOzARWs2MeSyCI3biqkgC/031+ppV66LLsBZBzsZuWZ
 4kwSpB3PIX7LPKiOV5yumZIeruwQ981IZuVlvZr8P+Qk4YWUXCNJSBvDH8g1GIXyansStBMUwL6e
 MM7dWKk3UnSLSLOpTrJld8VrdVnYY54xNOtIuD76tf4B1RbURwuSbUX/Gmr0BdpzbKjUne/FLfgT
 YdfZqWLAPZd5lCNkLwreq++Syeoo1JM0uazep+QQoZjfWwHgKNjFXay4SbpaHZUtnvnCiBNbJHss
 0JVGaMh+o642UpYVWixesoLpge/vspWwiEQ2WZEPXP/061ukLkVZIQ6xO27v3I7myoubtpvlYCY7
 vFEvQjMiA8+eOPNeb5LjhmsfIyVLmK0ofZY88CcxZEF4uyWcGbdakOzmz5TI63kbp/eSBbfnYYxu
 jTt6CsDvupkjiMSNXqiOrw1N+PyaEjPK+VP2YohU4S0k0UGXYsRvjmf83PwrUVDO0UtDTrCdZK+A
 Jl/NOjN8n9yBmVC9G6A9JxqUn9oFCIbBK/Gl5bbOa14iTK6qs/7DJ8H49zH9m7mIK9xQj9/xL57K
 SB1rNkxbRQ2N66MhTaOjIIKSYsLGaQ22PZ9HEKzPzMgAlQFNo4qsgmkgWtYDhMuK82ZYweV66xvb
 YzQqukHbOBKRD1rVPypUaaIR/9BDRWDTcARIiIQXNhgyX29vWOa5rLCx4o2zzvj2pxDCS+46Xk6g
 hsUlgkDwJgSyoxOweuDUrgnQr3a1wgR7mtyAk9B26bSb1Rz5D/9qhblN7TWfZ3DVkyM05kt92Y4t
 7YV7dXqEmRSS0e3N5UFdgGkBvYJGEw4+GKIQvGxpE=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, stefanha@redhat.com,
 sunnyzhyy@qq.com, vsementsov@yandex-team.ru
Subject: Re: [PATCH v4 07/13] mirror: Pass full sync mode rather than bool to
 internals
Date: Sat,  3 May 2025 07:17:17 +0800
X-OQ-MSGID: <20250502231717.44042-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509204341.3553601-22-eblake@redhat.com>
References: <20250509204341.3553601-22-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.49; envelope-from=sunnyzhyy@qq.com;
 helo=out162-62-57-49.mail.qq.com
X-Spam_score_int: 67
X-Spam_score: 6.7
X-Spam_bar: ++++++
X-Spam_report: (6.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: reject
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

On Fri, 9 May 2025 15:40:24 -0500, Eric Blake wrote:
> Out of the five possible values for MirrorSyncMode, INCREMENTAL and
> BITMAP are already rejected up front in mirror_start, leaving NONE,
> TOP, and FULL as the remaining values that the code was collapsing
> into a single bool is_none_mode.  Furthermore, mirror_dirty_init() is
> only reachable for modes TOP and FULL, as further guided by
> s->zero_target.  However, upcoming patches want to further optimize
> the pre-zeroing pass of a sync=full mirror in mirror_dirty_init(),
> while avoiding that pass on a sync=top action.  Instead of throwing
> away context by collapsing these two values into
> s->is_none_mode=false, it is better to pass s->sync_mode throughout
> the entire operation.  For active commit, the desired semantics match
> sync mode TOP.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> v4: new patch
> ---
>  block/mirror.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Sunny Zhu <sunnyzhyy@qq.com>


