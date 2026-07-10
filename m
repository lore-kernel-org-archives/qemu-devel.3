Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A15C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 09:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi77p-00087z-Fx; Fri, 10 Jul 2026 05:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wi77m-00083G-TR
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:02:22 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wi77j-0004JA-QW
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 05:02:22 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id 81078C08DE;
 Fri, 10 Jul 2026 12:02:14 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:167::1:39] (unknown
 [2a02:6bf:8080:167::1:39])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id D2H0gF0XNOs0-IOYlYlAr; Fri, 10 Jul 2026 12:02:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783674134;
 bh=3RNHu0k2GXC1cUmekPekpzNS6OvJijsSqZv7S5v/1Bw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=UBp4lyvze8ZUq/yc3jNYAr/bK7eDqqIrSZelnLo4b3h8I7AZyt0JyoslsCx2IQTkE
 c87cLINJiX/GqCDsgaqnniCLBXRMfO3Jdp/e7BDVchf7CXpigFrwudDCTTfF1EF6/2
 BRv0wWBgPMwE8cEmYlkOjijxjXUSHDs1UO8Zjvnc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6d8371e3-6bf4-4053-b284-d3d2e76adcf4@yandex-team.ru>
Date: Fri, 10 Jul 2026 12:02:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/3] tests/functional: use QMP to query available machines
To: Thomas Huth <th.huth@posteo.eu>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260707061851.8298-1-th.huth@posteo.eu>
 <20260707061851.8298-4-th.huth@posteo.eu>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260707061851.8298-4-th.huth@posteo.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 07.07.26 09:19, Thomas Huth wrote:
> From: Ganesh Harshan <ganeshredcobra@gmail.com>
> 
> Replace parsing of "qemu -M help" in set_machine() with
> QMP "query-machines".
> 
> The previous approach relied on parsing human-readable CLI
> output and substring matching, which is fragile and prone to
> incorrect matches. It is also sensitive to output format changes.
> 
> Use QMP instead to retrieve structured machine information,
> ensuring accurate matching and better maintainability.
> 
> Cache the result at the class level to avoid repeated QEMU
> startup overhead.
> 
> Signed-off-by: Ganesh Harshan <ganeshredcobra@gmail.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-ID: <20260625165310.54113-1-ganeshredcobra@gmail.com>
> [thuth: Drop problematic self.vm.set_machine() statement]
> Signed-off-by: Thomas Huth <th.huth@posteo.eu>
> ---
>   tests/functional/qemu_test/testcase.py | 31 +++++++++++++++++++++-----
>   1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index eaec1bea13..4912a47a46 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -314,13 +314,32 @@ def setUp(self):
>           console_log.addHandler(self._console_log_fh)
>   
>       def set_machine(self, machinename):
> -        # TODO: We should use QMP to get the list of available machines
> -        if not self._machinehelp:
> -            self._machinehelp = run(
> -                [self.qemu_bin, '-M', 'help'],
> -                capture_output=True, check=True, encoding='utf8').stdout
> -        if self._machinehelp.find(machinename) < 0:
> +        cls = type(self)
> +
> +        if not hasattr(cls, "_machines"):
> +            tmp_vm = QEMUMachine(self.qemu_bin)
> +            tmp_vm.set_machine('none')
> +
> +            try:
> +                tmp_vm.launch()
> +                resp = tmp_vm.qmp('query-machines')
> +
> +                machines = resp.get('return', [])
> +                cls._machines = [
> +                    m.get('name') for m in machines if 'name' in m

This doesn't cover aliases, now tests using "q35" are skipped. I'm sending a patch..

> +                ]
> +
> +            finally:
> +                try:
> +                    tmp_vm.shutdown()
> +                except Exception:
> +                    pass
> +
> +        self._machines = cls._machines
> +
> +        if machinename not in self._machines:
>               self.skipTest('no support for machine ' + machinename)
> +
>           self.machine = machinename
>   
>       def require_accelerator(self, accelerator):


-- 
Best regards,
Vladimir

