Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A2ECD8CA8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY04m-0002Ed-Fi; Fri, 12 Jun 2026 07:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wY04j-0002EU-2j
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:29:25 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wY04g-0000hV-8n
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 07:29:24 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65CBSrai030512
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 12 Jun 2026 20:28:54 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=oeyjVfFzAMGGI73EVFAEQjGnyrzAUfH+IYNrMKpc5qM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1781263734; v=1;
 b=SKUTonxp/zHTYm2NMAOYvIU4ttM9fy4eFw40M/Cu8k7VjdNT5t5s7QCQ1ljXg08p
 iul80Ssjb5lqaCrkjk17IcUasDKd0B0NAayoyp249WTT+gp2Xf4tPI8VrKctArjx
 /IAw7pp7FZEdqM44z1lsruALPpE1U0IFg5CIsCv8yF5tOH6ZK4MsJSbDlnqDq1Tr
 msSPNQD72k1JanVwNjSySA+9bDgiw9opoE/C+4wpCszKhaSH5iDS+3ZMBS+Z0NBf
 99Z6TK1FTgYyVRXBONBkxSFOZ6aBbK/mg8VHtCyV+Bs31TX+BUJGYrDDoMTHuoo+
 7/Yw2cwXLKoghmPIRMwbcg==
Message-ID: <08119b07-8333-48ff-8f11-7e843a632a6a@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 12 Jun 2026 20:28:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/sdl2: Explicitly specify EGL platform
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Richard Purdie <richard.purdie@linuxfoundation.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260611-sdl-v1-1-93d4a51684bb@rsg.ci.i.u-tokyo.ac.jp>
 <CANNYZj_tg=DTXW3mdUGyifCDpeLAE5YWHLCNuuwQV_Y4fUsTpQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CANNYZj_tg=DTXW3mdUGyifCDpeLAE5YWHLCNuuwQV_Y4fUsTpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/06/11 23:44, Alexander Kanavin wrote:
> On Thu, 11 Jun 2026 at 13:58, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>> Resolving the issue described in the GitLab work item also requires:
>> https://github.com/libsdl-org/SDL/pull/15806
> 
> Thanks! The pull request is only towards SDL2. I believe SDL3 (via
> sdl2 compat layer) isn't affected (it sets the platform correctly in
> my testing). Is that right?

Upstream developers are working on a fix:
https://github.com/libsdl-org/SDL/pull/15809

Regards,
Akihiko Odaki

