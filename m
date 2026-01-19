Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5663DD29C33
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrU6-0000Oq-5F; Mon, 19 Jan 2026 10:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhrU3-0000Le-Ti
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:48:04 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhrU2-0004M3-4L
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 10:48:03 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 23BA0C01AE;
 Mon, 19 Jan 2026 18:48:00 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:934::1:38] (unknown
 [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id xlbrXW0CF0U0-f0WcHKWT; Mon, 19 Jan 2026 18:47:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768837679;
 bh=Aj5vQuXEAugLh82U0nzXTe+dKxUytT0FmHJwQEPQQhM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QNe5TGPq37HhXZsdAZJUI9lcTtJH7myQmvYj88VNUkxDoMPq9BykSC/OigbdikAmT
 mXVfjsllbsqkAvkh4kPENv1xZgrRwHdG+1B3kILesaPhzcm2gW0nLvhs6XTBIvEoqi
 gGHAxlHbISBBYR7EPwMk1hgXvzXlBsOuA8Gh2U7w=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5b4220cf-4537-4906-82a9-2213af7ee8a8@yandex-team.ru>
Date: Mon, 19 Jan 2026 18:47:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] follow-up for tpm_emulator errp story
To: stefanb@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, armbru@redhat.com, peterx@redhat.com
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251106194126.569037-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

ping. All patches reviewed, could they be merged?

On 06.11.25 22:41, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> Here are fix and small enhancements, following comments on
> already merged "tmp_emulator: improve and fix use of errp"
> by Markus.
> 
> Vladimir Sementsov-Ogievskiy (3):
>    tpm_emulator: print error on error-ignore path
>    tpm_emulator: drop direct use of errno variable
>    tpm_emulator: tpm_emulator_set_state_blobs(): move to boolean return
> 
>   backends/tpm/tpm_emulator.c | 61 +++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 37 deletions(-)
> 


-- 
Best regards,
Vladimir

