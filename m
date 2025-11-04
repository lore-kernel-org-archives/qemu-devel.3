Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0C3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 01:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG67O-00065z-Cs; Mon, 03 Nov 2025 20:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vG67F-00065e-GE
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 20:45:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vG676-0002yH-TS
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 20:45:45 -0500
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5A41jKno006433
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Nov 2025 10:45:21 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+vcwEBs5aVKP++vMmN7Wp5skzSxIfKTKloJVWm0AGx0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1762220721; v=1;
 b=cyI6MFghNpIu70S98t6TIlK+8WhaDYZr7+kTPBoy7Ge7v3Y4Y+RsJrLqLhmcggtM
 Ba8EDQJRDzj1npoyv38tBVem3Vn0WjLbXtZ+zqyxG++Kj79mISKuYllbcnFpAXM6
 XgC8+eCgIydxv78Hxs9lWguS9bAf4s7P09n2ycEOx+V+srBfEqN7TvRt6GVDhKaP
 xBepyTKlQGY0j6EQwkzPQwkymVILd8sFfFwzXctzfIB3eeUcfVAJAoJY/ofrBlb2
 UaLyOAnhcVjS/SOJ6A17q+KOMu6ujguMmDmt8ErTYHiA+F3ZG2aQx3AyerQV3cS7
 YvXpKo2809Ts5SH0xsBcfA==
Message-ID: <ebb0ac51-fbf0-4f93-8a9b-12880d2a0126@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 4 Nov 2025 10:45:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Regression with the "replay" test on target alpha
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
 <20251028173430.2180057-4-pbonzini@redhat.com>
 <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <cb41dc20-5a87-42b6-8819-08f5a1ee4303@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2025/11/03 22:59, Thomas Huth wrote:
> On 28/10/2025 18.34, Paolo Bonzini wrote:
>> From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>> Borrow the concept of force quiescent state from Linux to ensure readers
>> remain fast during normal operation and to avoid stalls.
> 
>   Hi Akihiko,
> 
> looks like this commit has introduced a regression with the "replay" 
> functional test on the alpha target.
> When I run something like:
> 
>   pyvenv/bin/meson test --no-rebuild -t 1 --setup thorough \
>    --num-processes 1 --repeat 10 func-alpha-replay
> 
> in the build folder, approx. half of the test runs are failing for me now.
> 
> I bisected the issue to this patch here - when I rebuild qemu-system- 
> alpha with the commit right before this change here, the above test runs 
> work fine, so I'm pretty sure that the problem has been introduced by 
> this commit here.
> 
> Could you please have a look?

I cannot reproduce it with commit 55d98e3edeeb ("rcu: Unify force 
quiescent state").

Can you provide meson-logs/testlog-thorough.txt so that I can look into 
the failure you are facing? If you think you have something useful for 
debugging, please share it to me too.

Regards,
Akihiko Odaki

