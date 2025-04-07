Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125B3C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 16:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1p3f-00039N-EV; Mon, 07 Apr 2025 12:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u1p3b-00037h-Ds; Mon, 07 Apr 2025 12:10:45 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u1p3Y-0006Uf-Lz; Mon, 07 Apr 2025 12:10:43 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:381b:0:640:f69d:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D95716131C;
 Mon,  7 Apr 2025 19:10:31 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b71c::1:1e] (unknown
 [2a02:6b8:b081:b71c::1:1e])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id UAffHF0FamI0-MJy0Ihhj; Mon, 07 Apr 2025 19:10:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744042231;
 bh=XYLUa6DXZ4QqC9pHmPyd89nN+CF6kSLdWayMb7drNWE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=zLgpX+RoMn/PIewQVkoJ/oO2BvP2LX3NH4pVnPbSICHOL7seVXKwp43EBs4fFJOBB
 YZM64pzQZHid/SBsHK6JXRG+8ox1dzSGcEt/sYde2MAr8A6pMxkV7fmoosvCUPa6WL
 gCAFP89wzNGUq5da+ImbQJ411GGLlRy/f5AX0zLA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6eab14b9-76bb-432a-9cee-5b0fa556009d@yandex-team.ru>
Date: Mon, 7 Apr 2025 19:10:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] qapi: synchronize jobs and block-jobs documentation
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 devel@lists.libvirt.org, pkrempa@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com
References: <20250404193154.707145-1-vsementsov@yandex-team.ru>
 <20250404193154.707145-2-vsementsov@yandex-team.ru>
 <747fxuxfvrmkesa5gnl5w343bacuenqhpfg2sgrcjl6wfyrbur@bvg7rw4lu4t3>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <747fxuxfvrmkesa5gnl5w343bacuenqhpfg2sgrcjl6wfyrbur@bvg7rw4lu4t3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 07.04.25 18:28, Eric Blake wrote:
> On Fri, Apr 04, 2025 at 10:31:53PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Actualize documentation and synchronize it for commands which actually
>> call the same functions internally.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   qapi/block-core.json | 59 +++++++++++++++++++++++++-------------------
>>   qapi/job.json        | 29 ++++++++++++++++++++--
>>   2 files changed, 61 insertions(+), 27 deletions(-)
>>
> 
> Overall makes sense, but one thing jumped out at me:
> 
>>   # @block-job-complete:
>>   #
>> -# Manually trigger completion of an active background block operation.
>> -# This is supported for drive mirroring, where it also switches the
>> -# device to write to the target path only.  The ability to complete is
>> -# signaled with a BLOCK_JOB_READY event.
>> +# Manually trigger completion of an active job in the READY or STANDBY
>> +# state.  Completing the job in any other state is an error.
>> +#
>> +# This is supported only for drive mirroring (which includes
>> +# drive-mirror, blockdev-mirror and block-commit job (only in case of
>> +# "active commit", when the node being commited is used by the guest)),
>> +# where it also switches the device to write to the target path only.
> 
> The doubly-nested parenthetical feels long.  Is there a more concise
> way of expressing the list of three commands, where one of the
> commands only supports it in the special case of "active commit"?
> 

Probably, move the big "(...)" to the second sentence:

Note that drive mirroring includes [...] the guest).

-- 
Best regards,
Vladimir


