Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863AAF3ED42
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 10:45:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBVpM-0007qe-5L; Sat, 11 Apr 2026 06:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wBVpJ-0007qT-WA
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 06:44:34 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wBVpH-0000rU-Ci
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 06:44:33 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63BAiGUr028703
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 11 Apr 2026 19:44:16 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=hD1tC1p6bsgeECjItEP/pP246ZpgC59D+lcFFzDPkaA=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1775904256; v=1;
 b=JI96ssUVMVzy2mGQRBE51ul045qlfWmEZcdCBeQhVevmrm9Fj6kr9E/fwPDOv9Mv
 vOcYxnkxxx9Hji1F4ll8+qjI8/+qhsx76VzuEtDMYRXHMldfKqJCFa9dFSUd7e2v
 k7LjYL4M92zjYn/QofXvahU3SPgM47o+5l0/8yy1X1NHf+SiKd30O7R+3ymhbXL0
 7mp6POPEitFi3nltx6NZ5MoV2HMFEb9hfJZoTvl3jPD3mvKwqPjFV1BlGJzmgKb8
 R5GN8t9qxqlD10jW4OH+cFhOhxr24OrnefloNhU/vVa3qVVT9wbMuyuSPWFglAol
 0VJH4tQWuu6NZam4pcGpLg==
Message-ID: <a3c93b9f-0bf5-4379-9486-8100aa399168@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 11 Apr 2026 19:44:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: fix inverted mouse cursor
To: =?UTF-8?Q?Benno_F=C3=BCnst=C3=BCck?= <benno.fuenfstueck@neodyme.io>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260409144639.3610-1-benno.fuenfstueck@neodyme.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2026/04/09 23:46, Benno Fünstück wrote:
> From: Benno Fünfstück <benno.fuenfstueck@neodyme.io>
> 
> When using virtio-gpu-gl, if the guest uses hardware mouse cursor acceleration then the mouse cursor can end up being a resource with the flag Y_0_TOP set. In this case, we need to make sure to flip the cursor data such that display clients render it correctly.
> 
> For example, this fixes mouse cursor rendering for wlroots-based window managers (like Sway) in Linux guests.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2315
> Signed-off-by: Benno Fünfstück <benno.fuenfstueck@neodyme.io>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

