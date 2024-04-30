Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97D93C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jhl-0000Du-P0; Tue, 30 Apr 2024 05:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jhb-0000Cb-1a; Tue, 30 Apr 2024 05:23:08 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jhX-0002xj-Fi; Tue, 30 Apr 2024 05:23:06 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 8662E60CE1;
 Tue, 30 Apr 2024 12:22:57 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8829::1:3c] (unknown
 [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uMNsTV11RiE0-2gXoAqq4; Tue, 30 Apr 2024 12:22:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714468976;
 bh=i5zhcTTOSAAWqwjXFbi76tpftIAuFTZOg2McKXy51rw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=cWypHlDka/ESIa6/Xg6iD820u/da1wVfBTI55DySzKIEbvIe4fqewoj4kuqPp69Gc
 o1+p9RN92itALUuYZcx4VzXqPN6P+wabNgYmpkt8zmpVBTExSwEYhzFqFMixUR7Fmt
 RxzjZ/409omtUcIixHiVBpd3biM14JiMyQ7fOxT8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b7e0fd5d-4543-4b71-902e-aaae428430d1@yandex-team.ru>
Date: Tue, 30 Apr 2024 12:22:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] iotests: add backup-discard-source
To: Kevin Wolf <kwolf@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
 <20240429115157.2260885-7-vsementsov@yandex-team.ru>
 <11fd6cbf-cd8b-4469-aefa-2bfddf5a3ca9@linaro.org>
 <4c7cb398-7fb8-4c78-a9e2-aae46920a8b1@yandex-team.ru>
 <ZjC2RvxoyYc0KW0p@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZjC2RvxoyYc0KW0p@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 30.04.24 12:13, Kevin Wolf wrote:
> Am 29.04.2024 um 20:39 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> [Add John]
>>
>> On 29.04.24 17:18, Richard Henderson wrote:
>>> On 4/29/24 04:51, Vladimir Sementsov-Ogievskiy wrote:
>>>> Add test for a new backup option: discard-source.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
>>>> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
>>>> Message-Id: <20240313152822.626493-6-vsementsov@yandex-team.ru>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>    .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
>>>>    .../tests/backup-discard-source.out           |   5 +
>>>>    2 files changed, 157 insertions(+)
>>>>    create mode 100755 tests/qemu-iotests/tests/backup-discard-source
>>>>    create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out
>>>
>>> This fails check-python-minreqs
>>>
>>>     https://gitlab.com/qemu-project/qemu/-/jobs/6739551782
>>>
>>> It appears to be a pylint issue.
>>>
>>>
>>
>> tests/export-incoming-iothread:1:0: R0801: Similar lines in 2 files
>> ==tests.backup-discard-source:[52:61]
>> ==tests.copy-before-write:[54:63]
>>              'file': {
>>                  'driver': iotests.imgfmt,
>>                  'file': {
>>                      'driver': 'file',
>>                      'filename': source_img,
>>                  }
>>              },
>>              'target': {
>>                  'driver': iotests.imgfmt, (duplicate-code)
>>
>>
>>
>> Hmm. I don't think, that something should be changed in code.
>> splitting out part of this json object to a function? That's a test
>> for QMP command, and it's good that we see the command as is in one
>> place. I can swap some lines or rename variables to hack the linter,
>> but I'd prefer not doing so:)
>>
>>
>> For me that looks like a false-positive: yes it's a duplication, but
>> it should better be duplication, than complicating raw json objects by
>> reusing common parts.
>>
>>
>> What to do? As described in 22305c2a081b8b6 "python: Reduce strictness
>> of pylint's duplicate-code check", this check could be either be
>> disabled completely, or we can increase min-similarity-lines config
>> value.
>>
>> I'd just disable it completely. Any thoughts?
> 
> I think it would make sense to treat tests differently from real
> production code. In tests/, some duplication is bound to happen and
> trying to unify things across test cases (which would mean moving to
> iotests.py) often doesn't make sense. On the other hand, in python/ we
> would probably want to unify duplicated code.
> 

Agree. Happily, it turns out that tests already have separate tests/qemu-iotests/pylintrc file, so that's not a problem. Still I decided to anot disable the check completely, but just bump the limit, see "[PATCH] iotests/pylintrc: allow up to 10 similar lines"

-- 
Best regards,
Vladimir


