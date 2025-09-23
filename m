Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B79F1CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 14:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v149h-0005Cu-Ts; Tue, 23 Sep 2025 10:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v149f-0005CC-6t
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:38:07 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v149c-0002zt-TB
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 10:38:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 2071780B54;
 Tue, 23 Sep 2025 17:37:57 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b38::1:12] (unknown
 [2a02:6bf:8080:b38::1:12])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id tbY9rG0FkmI0-uje54IkS; Tue, 23 Sep 2025 17:37:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1758638276;
 bh=T04+Wxfc5FBSPfeTdZEmwGtnUzlz4DBavL1R9Yiciwg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=WPcT1380VUrVF0m2maxSO/CAjR4baikYgQkmDosPDx2kT8uCYNtpvd1KsbU2yba5o
 d/KoHwRKFZ5fWFnG5ZqJ/7lnU5ykFMKg9w7MOBBTBSXxlA1BlSxwtV6AEyY5Ppuy8G
 eCj/hnRs+IRjwXovaJDLCRbddvoieWwKtcL7jNGY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2855a1ab-fed9-49b1-9724-3c0631db5f8a@yandex-team.ru>
Date: Tue, 23 Sep 2025 17:37:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
To: Steven Sistare <steven.sistare@oracle.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local> <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
 <aMBGnHXieiXpBCqF@x1.local> <992bf553-e622-4e51-b1c7-f59c1413558e@oracle.com>
 <aMB0BL5SEGfwjTFm@x1.local> <1a3c46b8-985e-4768-a3d1-e797370c0822@oracle.com>
 <aMQ_65_BybkbtZL4@x1.local> <f81f1138-1450-4a71-8459-63f653018226@oracle.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <f81f1138-1450-4a71-8459-63f653018226@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19.09.25 20:16, Steven Sistare wrote:
> On 9/12/2025 11:44 AM, Peter Xu wrote:
>> On Fri, Sep 12, 2025 at 10:50:34AM -0400, Steven Sistare wrote:
>>>>>> How to guarantee src/dst device topology match
>>>>>> exactly the same with the new cmdline?
>>>>>
>>>>> That is up to the mgmt layer, to know how QEMU was originally started, and
>>>>> what has been hot plugged afterwards.  The fast qom-list-get command that
>>>>> I recently added can help here.
>>>>
>>>> I see.  If you think that is the best way to consume cpr-exec, would you
>>>> add a small section into the doc patch for it as well?
>>>
>>> It is not related to cpr-exec.  It is related to hot plug, for any migration
>>> type scenario, so it does not fit in the cpr-exec docs.
>>
>> IMHO it matters.. With cpr-transfer, QMP hot plugs works and will not
>> contribute to downtime.
> 
> I don't follow.  The guest is not resumed until after all devices that were
> present in old QEMU are hot plugged in new QEMU, regardless of mode.

Yes, but in case of cpr-transfer, source is still running at time when we do adding
devices to target through QMP. So, downtime is not started until we say "migrate-incoming".

> 
>> cpr-exec also works, but will contribute to
>> downtime.
>>
>> We could, in the comparison section between cpr-exec v.s. cpr-transfer,
>> mention the potential difference on device hot plugs (out of many other
>> differences), then also mention that there's an option to reduce downtime
>> for cpr-exec due to hot-plug by converting QMP hot plugs into cmdlines
>> leveraging qom-list-get and other facilities.  From there we could further
>> link to a special small section describing the usage of qom-list-get, or
>> stop there.
> 
> To hot plug a device, *or* to add it to the new QEMU command line, the manager
> must know that the device was added sometime after old QEMU started, and
> qom-list-get can help with that, by examining old QEMU initially and again
> immediately before the update, then performing a diff.  But again, this
> is independent of mode.
> 
> - Steve


-- 
Best regards,
Vladimir

