Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC7BC636E5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 16:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjLyy-0000yZ-L4; Wed, 28 Aug 2024 12:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66cf5289.v1-8712f5fbd02c4d08bc5dea98d5df5fc4@bounce.vates.tech>)
 id 1sjLyx-0000xl-9Z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:57:19 -0400
Received: from mail137-25.atl71.mandrillapp.com ([198.2.137.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.66cf5289.v1-8712f5fbd02c4d08bc5dea98d5df5fc4@bounce.vates.tech>)
 id 1sjLyv-0007SS-LC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 12:57:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1724863113; x=1725123613;
 bh=Vfw4UjiIvn5BMezQQ2ACcscxr03OJTFE65zr3iU6S+U=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=aMc0CDJmaQ1h6U0J5Qre0/9oXdv+RvLrY/VggU1Ep1dpvVObpsMUKirD+6POSSDMR
 2DuxfWEOhkurBxclqMGbER1bQ3flrG7Gp+/9joU5ijyCtbqmOyfU7uCYEQtyzwLCWL
 kl1L1vdxXg+/8CG5gwIbEXlMOcypWrDJ6pzT7Ekswb3WqEcGsCC+fw55xoi1X2pbXq
 noPm8UvevbPrx7VFNu4Yhd0uVOfswAIYTr4SHc+kFhHLPOti3iWI5rfeJqrHvZjlM5
 0FOruUoCUwamFcJ37GRejictd3mP7OYKqxHzkOY0n1xVSFKytTBk/6e6wldmuX6wVS
 07Xy8WqGWu4IA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1724863113; x=1725123613; i=anthony.perard@vates.tech;
 bh=Vfw4UjiIvn5BMezQQ2ACcscxr03OJTFE65zr3iU6S+U=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=JBXGOSxSgEljhpXduvKLV7lAr5IJTcXAEDItqnyEZkKLqKulr7YM8hf+OThrcjIYl
 M9V6FPzysiZNm5gZDgV/wv9RHQS30Bw/K9FHNrUSh6CQTkw/DR6og0pC8nEOhZse8R
 1YdXKXj7XMcdiM999rNI8iSD96BQQdNn3BVBd12iaODJEVzWP9DcrCbgNU8B3mORNH
 Dk+D9dNK9rHr29I+yDMNeUJwnr2UUAVTRpQ5sCfF4EL9b+0I0EKk/oVjPwCnyDI+Hq
 9CmHYUV8SXenrmtGpHDD6oShMxBHC6/vLwlNZcT9lQxbRGKgadO79ZlDgrHLIvjzyt
 utlXLPCI2+k9A==
Received: from pmta07.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail137-25.atl71.mandrillapp.com (Mailchimp) with ESMTP id
 4Wv98T3tYPz35hTXc
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 16:38:33 +0000 (GMT)
From: Anthony PERARD <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v3=202/3]=20Update=20Xen's=20features.h=20header?=
Received: from [37.26.189.201] by mandrillapp.com id
 8712f5fbd02c4d08bc5dea98d5df5fc4; Wed, 28 Aug 2024 16:38:33 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1724863112535
To: =?utf-8?Q?Marek=20Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Message-Id: <Zs9SiEQtWIsvlhXk@l14>
References: <cover.f5d45e3c2fb87552abfaf80982b0b724fca2134c.1714955598.git-series.marmarek@invisiblethingslab.com>
 <e167b362448dc3abc677f3b925a58c55d6158da7.1714955598.git-series.marmarek@invisiblethingslab.com>
In-Reply-To: <e167b362448dc3abc677f3b925a58c55d6158da7.1714955598.git-series.marmarek@invisiblethingslab.com>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.8712f5fbd02c4d08bc5dea98d5df5fc4?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20240828:md
Date: Wed, 28 Aug 2024 16:38:33 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=198.2.137.25;
 envelope-from=bounce-md_30504962.66cf5289.v1-8712f5fbd02c4d08bc5dea98d5df5fc4@bounce.vates.tech;
 helo=mail137-25.atl71.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Mon, May 06, 2024 at 02:33:21AM +0200, Marek Marczykowski-G=C3=B3recki w=
rote:
> Update it to get XENFEAT_dm_msix_all_writes for the next patch.
> 
> Signed-off-by: Marek Marczykowski-G=C3=B3recki <marmarek@invisiblethingsl=
ab.com>

Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>

Thanks,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech


