Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87AAC61DB4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wynpb-0000p6-5q; Tue, 25 Aug 2026 05:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wynpY-0000n6-Kj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:52:32 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wynpW-0007KC-3t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 05:52:32 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67P9qMwI029102
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 25 Aug 2026 18:52:22 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=RtXHYWYowawBiSiPmjtghJvuVRi7ifnrUOVTfA42ZE0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1787651542; v=1;
 b=GrDl7kAV3/wSpSshgEz8Fx3F8U9bMzmVj0p2CAJ/BzioDYU8OPI+1fpN9qgpY0PU
 YmHUBnkXAm2akdh7mJRHY6J5ei5ktW853QgEs/SaasSP1PNW2T48e99EaLxRQgJ3
 dUb66GqgOzrLrkZCGO96dWfpwJ0AlS5baZQa87ceZleKUkqgbFx9Vger6aFt2ajW
 VUMrZZXmRFLaSAR3lFgDiTih2YVj2V04K4G2ykOFEzUMR+RejdS7lDc/zlsPxiHj
 Cq/CzIo+62F5ftYItl83AhbPZMM15G+h09ualiYPqMnVASYz33oRtsTNdceWz3S8
 ku62RjdjjNyzQ8GgYvq9rA==
Message-ID: <a163a214-7f57-4aaa-a604-68cc1848420a@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 25 Aug 2026 18:52:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] hw/input/ps2: answer unknown mouse commands with a
 resend
To: Christian Quante <christian@quante.one>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260825075127.34876-1-christian@quante.one>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260825075127.34876-1-christian@quante.one>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/25 16:51, Christian Quante wrote:
> v1: https://lore.kernel.org/qemu-devel/20260823071529.16389-1-christian@quante.one/
> 
> Patch 1 is the fix from v1 with its commit message corrected. Patch 2 is
> a comment-only follow-up Akihiko suggested, kept separate so patch 1
> stays a pure fix for stable.
> 
> Changes since v1:
> - commit message: the probe does not end in the same error either way.
>    Without a reply libps2 returns -EIO, with the resend -EPROTO (Akihiko
>    Odaki)
> - commit message: cite 06b3611fc2a3 instead of calling the keyboard
>    behaviour twenty years old, it is from 2016 (Akihiko Odaki)
> - commit message: name both unknown commands Linux runs into, 0xEC from
>    the ALPS probe and 0xE1 from the TrackPoint probe, at a 200 ms reply
>    timeout each
> - shorten the new comment. Its last sentence is gone as suggested
>    (Akihiko Odaki), and the sentence before it went as well: it described
>    the silence this patch removes, which belongs in this message rather
>    than next to the code that no longer produces it
> - new patch 2: give the keyboard path the same comment (Akihiko Odaki)
> - Cc: qemu-stable@nongnu.org (Akihiko Odaki)
> - Marc-André Lureau's Reviewed-by carried over: the code of patch 1 is
>    unchanged apart from the shortened comment
> 
> Christian Quante (2):
>    hw/input/ps2: answer unknown mouse commands with a resend
>    hw/input/ps2: say why unknown keyboard commands draw a resend
> 
>   hw/input/ps2.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
Now everything looks good to me. For the whole series:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

