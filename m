Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A63CD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVUHv-0004Ui-LU; Fri, 05 Jun 2026 09:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wVUHs-0004US-4m
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 09:08:36 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wVUHp-0003eZ-0w
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 09:08:35 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 655D7qqD090192
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 5 Jun 2026 22:07:52 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=y7d0KA2x+tUY8JnMqAEETNoYIX2PRvJ9Q3QVPH/Wz7c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1780664872; v=1;
 b=iDVeh61dRkT28dTyiPvGYxVwB5m65zMI7+3K2NX+4TErt0WJi06/fpZHvJUNJ0Dk
 WWhnDYGqi9B2LOYWp9zHDNFMJBB9hKioRAwBw7jpsmh1w1FXyt6xCzPn13gDbU5R
 Jth75DEo11WmgFA99yke/pWcBMqpKxQh/8CgMXE3GutDerMVB5HGzoO1WgyGwl3V
 UMGazt5D6H94WHf0uY0POd6lI5GDStEwJJgyNU+v7rY8h+ILfsLUFnW9zifODxGP
 sioeLFkzWNQOEMXjdLQ6HeareizWCWa/JEGWy8A8j9Dlg6DGsbeVt+dbgGrhrjaj
 pUEBEYT05lBjWNjenWlb9g==
Message-ID: <dd1729c6-f6e8-4790-b166-a635e34b3b1c@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 5 Jun 2026 22:07:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ui: Regression calling eglInitialize() since v11.0.0
To: Alexander Kanavin <alex.kanavin@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 openembedded-core@lists.openembedded.org, Quan.Sun@windriver.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20260528202639.4097815-1-Quan.Sun@windriver.com>
 <DIV636CRY5LQ.2KV03HIYY2WKI@bootlin.com>
 <be287797-1941-4afa-8aef-b015ca194476@windriver.com>
 <CANNYZj8gMc8PdWMse=g1J7goZC5Ga=nwN5hA+uX02-G+LNHEwQ@mail.gmail.com>
 <7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org>
 <3bde2ef8-5565-4495-9904-dd3db839de1d@windriver.com>
 <CANNYZj8St8Foj7C1RZnGPFmzsAFyCEjvXVZa9DD5Wv6YQ8u1TQ@mail.gmail.com>
 <237df978-b1f2-4c66-ab4c-5894f7a44a02@mailo.com>
 <aiKEeH2UZgdePzjX@redhat.com>
 <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CANNYZj-x8efUVB9Z5d2T9Ye4so6v3zamHVTexRCGmzOmkB6EuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/06/05 21:52, Alexander Kanavin wrote:
> On Fri, 5 Jun 2026 at 10:10, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>> It's the same issue, I assure you. Qemu 10.x prints nothing and simply
>>>> starts, while qemu 11.x first tries glx/dri3 , then wayland/egl/vgem
>>>> (even though there's no wayland running on the build hosts), and then
>>>> finally crashes, with the traceback that RP provided.
>>>>
>>>> I don't think it's a race condition, as the failure is deterministic,
>>>> but I agree that something has changed in qemu's GL initialization
>>>> sequence.
>>>
>>> Cc'ing Marc-André & Akihiko
>>>
>>> Context:
>>>
>>> https://lore.kernel.org/openembedded-core/7da33301e8a0bae93a33695b4fd41f67a08e1b9f.camel@linuxfoundation.org/
>>
>> If it is an suspected regression between 10.2 and 11.0, then
>> I'd suggest someone who is able to reproduce the issue reliably
>> should do a 'git bisect' to narrow it down precisely.
> 
> I've done additional testing, and I can confirm:
> 
> 1. Reverting the following commit fixes the issue:
> 
> commit 52053b7e0a0e285ce3448b830053b05fb0a9b1a8
> Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Date:   Wed Mar 4 16:50:30 2026 +0000
> 
>      ui/sdl2: Implement dpy dmabuf functions
> 
> 2. Updating to 11.0.1 does not fix the issue. It includes a fix for a
> different, but related problem:
> 
> 674221887f ui/sdl2: Fix assumption of EGL presence at runtime
> 
> Note that the environment we run in is X11 without wayland, e.g. a
> XTigervnc server that provides a X11 display.

Cc'ing Pierre-Eric Pelloux-Prayer

My best bet is that SDL_HINT_VIDEO_X11_FORCE_EGL triggered the host 
issue, but the stack trace cited above contradicts with that. I don't 
exclude the possibility of a QEMU bug either.

Can you confirm the stack trace is from a run with X11? If so, the next 
step would be to symbolize the stack trace. Otherwise, re-generating the 
stack trace with X11 may help.

Regards,
Akihiko Odaki

