Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29133EA3F3E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 11:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vplhp-0000HK-IA; Tue, 10 Feb 2026 06:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vplhn-0000Gn-0d
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:14:55 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vplhk-0006Qt-1B
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 06:14:54 -0500
Received: from [192.168.10.111] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 61ABEBka051272
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 10 Feb 2026 20:14:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=3lrf5g/COcKWjdk+Ap1gLny3tRpi3V52BChNTXZ8+b8=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1770722082; v=1;
 b=Qh230gNFTiA2h9hva9V87RsoyYSSrYlwVph0bFKmBwgPqMJzg47rkRvslcR03pHo
 t0PQSrvTw+VSEzMdyWBqu9dInAFD+uU5NSBTEPj0JduFvJvAf1Nh1oGBSQxFOJsU
 O5xPZShVeinjwwnD4qYxtUVt5XNHptvfE7M2EzZhh1H9ZDFYsD695KDJeYdPg1WD
 EvbrngMOVHQE2K4QOnxW7KkRVYd+u2dyI/mLjP6gPw+7CY2CooefZlaKNrx89T2Y
 jsZwt9SF75lKgsTnGxO4JRzSCuoRyKTewWpFR5tn7skbqEGWAT7Ixxwx1r6KBCv1
 ph11u47euqXegq09Ij9eBQ==
Message-ID: <745fbb72-a977-4ec4-84ea-eefc33cf33a8@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 10 Feb 2026 20:14:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "rcu: Unify force quiescent state"
To: Jim MacArthur <jim.macarthur@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260209120336.41454-1-thuth@redhat.com>
 <0e63016c-2ca3-4074-8a5e-db46f22d8eda@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0e63016c-2ca3-4074-8a5e-db46f22d8eda@linaro.org>
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

On 2026/02/10 20:04, Jim MacArthur wrote:
> On 2/9/26 12:03, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> This reverts commit 55d98e3edeeb17dd8445db27605d2b34f4c3ba85.
>>
>> The commit introduced a regression in the replay functional test
>> on alpha (tests/functional/alpha/test_replay.py), that causes CI
>> failures regularly. Thus revert this change until someone has
>> figured out what is going wrong here.
>>
>> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3197
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   I just hit this again in the CI:
>>   https://gitlab.com/thuth/qemu/-/jobs/13018713844
>>   ... it's annoying, so I'd like to suggest to revert the offending
>>   patch 'til someone fixed this.
>>
> 
> Hi Thomas,
> 
> I am actively investigating this problem, but haven't made any important 
> progress so far. It's looking like a timing bug which is annoying to 
> track down. All I know for certain at the moment is that faking some of 
> the values returned by qemu_clock_get_ns to be deterministic improves 
> the failure rate, but does not remove it entirely. I'm fine with this 
> being reverted for now; we can add it back in once we figure out what 
> the true cause is.

Thanks for investigating this. Let's have the commit reverted until 
there is some progress:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

