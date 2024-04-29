Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EC4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 18:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Vv9-0001mc-Po; Mon, 29 Apr 2024 14:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Vv0-0001lx-JN; Mon, 29 Apr 2024 14:40:04 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1Vuw-0007AE-Me; Mon, 29 Apr 2024 14:40:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id A233E60C64;
 Mon, 29 Apr 2024 21:39:51 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b739::1:30] (unknown
 [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id odVLPJ11IuQ0-EgLWb5mV; Mon, 29 Apr 2024 21:39:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714415991;
 bh=wMbNVOvntqncNXDVFHYmX4rx9vd06oTDFkfoab4XbBQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=bdvsqtw6cqFCNHo5IRwB0j2L9NNbd7eVkFDdQ/mJRAt+6RS0C6zLCyPn73zltptss
 WBJa1XEQ4itkQz/jm5HY/oax8XFVLX5NgDKNEMhbVYxadL7MqUX3MK1eNhAEleLs0w
 QtmAy+OzW94F+kKI0HKEPff7u6WBouaz80ucyQDQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <4c7cb398-7fb8-4c78-a9e2-aae46920a8b1@yandex-team.ru>
Date: Mon, 29 Apr 2024 21:39:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 6/6] iotests: add backup-discard-source
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
 <20240429115157.2260885-7-vsementsov@yandex-team.ru>
 <11fd6cbf-cd8b-4469-aefa-2bfddf5a3ca9@linaro.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <11fd6cbf-cd8b-4469-aefa-2bfddf5a3ca9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

[Add John]

On 29.04.24 17:18, Richard Henderson wrote:
> On 4/29/24 04:51, Vladimir Sementsov-Ogievskiy wrote:
>> Add test for a new backup option: discard-source.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
>> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
>> Message-Id: <20240313152822.626493-6-vsementsov@yandex-team.ru>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
>>   .../tests/backup-discard-source.out           |   5 +
>>   2 files changed, 157 insertions(+)
>>   create mode 100755 tests/qemu-iotests/tests/backup-discard-source
>>   create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out
> 
> This fails check-python-minreqs
> 
>    https://gitlab.com/qemu-project/qemu/-/jobs/6739551782
> 
> It appears to be a pylint issue.
> 
> 

tests/export-incoming-iothread:1:0: R0801: Similar lines in 2 files
==tests.backup-discard-source:[52:61]
==tests.copy-before-write:[54:63]
             'file': {
                 'driver': iotests.imgfmt,
                 'file': {
                     'driver': 'file',
                     'filename': source_img,
                 }
             },
             'target': {
                 'driver': iotests.imgfmt, (duplicate-code)



Hmm. I don't think, that something should be changed in code. splitting out part of this json object to a function? That's a test for QMP command, and it's good that we see the command as is in one place. I can swap some lines or rename variables to hack the linter, but I'd prefer not doing so:)


For me that looks like a false-positive: yes it's a duplication, but it should better be duplication, than complicating raw json objects by reusing common parts.


What to do? As described in 22305c2a081b8b6 "python: Reduce strictness of pylint's duplicate-code check", this check could be either be disabled completely, or we can increase min-similarity-lines config value.

I'd just disable it completely. Any thoughts?


-- 
Best regards,
Vladimir


