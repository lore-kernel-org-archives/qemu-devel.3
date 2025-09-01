Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 858FECA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 07:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usz64-0003Or-0S; Mon, 01 Sep 2025 03:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim@guixotic.coop>)
 id 1usz61-0003OS-Vl
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:36:58 -0400
Received: from mailtransmit04.runbox.com ([2a0c:5a00:149::25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maxim@guixotic.coop>)
 id 1usz5y-00083c-Sz
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 03:36:57 -0400
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
 by mailtransmit04.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <maxim@guixotic.coop>) id 1usz5s-003pQq-JW
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:36:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=guixotic.coop; s=selector1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From;
 bh=TfFTItT7AbcOz8u7frRjsI7Oww6/+nRddvlAIbk1Pyk=; b=TbQlNUXbZq6CVdWiNVoTq+sm+o
 nw5/u+CKxEXHxDThdjkGtHiBOmJv4//+FYGAklagA0YsYEyYPuSDJASfsoGsyg/FRvhKmDMXG6Xwu
 +G6qZ2L4gCBLG3dDVH2AybAKoYeL4Le/QzASmUb5rfyD/hCliAZwJhhQdVKBH93d99HvZNu4lgiDM
 huA9TN0Tk+edlH77iuS8jsTJMCkVOqjIXAY4iX5Msm8adJ1r16rqt0NRktrbu+p+YtiFcVpYtxmFN
 svUMd0X5HJeWNZSOHUWrD8jdglN/w9beegZ5+n166V3HvPylfzXwQuuZXu/0jblQrRq99OfUTpc8+
 X1vWBPRw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
 by mailtransmit03.runbox with esmtp (Exim 4.86_2)
 (envelope-from <maxim@guixotic.coop>)
 id 1usz5r-0005jw-Cw; Mon, 01 Sep 2025 09:36:47 +0200
Received: by submission02.runbox with esmtpsa [Authenticated ID (1476852)]
 (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256) (Exim 4.93)
 id 1usz5b-008VrA-6l; Mon, 01 Sep 2025 09:36:31 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests: honor $TMPDIR for test_virtio_version
In-Reply-To: <c1b6e93a-1c85-4626-8ea6-5efee2bf9489@tls.msk.ru> (Michael
 Tokarev's message of "Mon, 1 Sep 2025 09:41:32 +0300")
Organization: Guixotic
References: <20250831125255.7066-1-maxim@guixotic.coop>
 <c1b6e93a-1c85-4626-8ea6-5efee2bf9489@tls.msk.ru>
Importance: high
Date: Mon, 01 Sep 2025 16:36:27 +0900
Message-ID: <87h5xmaakk.fsf@guixotic.coop>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a0c:5a00:149::25;
 envelope-from=maxim@guixotic.coop; helo=mailtransmit04.runbox.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

Hi,

Michael Tokarev <mjt@tls.msk.ru> writes:

[...]

>> diff --git a/tests/functional/x86_64/test_virtio_version.py b/tests/functional/x86_64/test_virtio_version.py
>> index a5ea73237f..501545f655 100755
>> --- a/tests/functional/x86_64/test_virtio_version.py
>> +++ b/tests/functional/x86_64/test_virtio_version.py
>
>> @@ -68,7 +70,9 @@ def run_device(self, devtype, opts=None, machine='pc'):
>>           """
>>           Run QEMU with `-device DEVTYPE`, return device info from `query-pci`
>>           """
>> -        with QEMUMachine(self.qemu_bin) as vm:
>> +        with QEMUMachine(
>> +                self.qemu_bin,
>> +                base_temp_dir=os.environ.get('TMPDIR', '/var/tmp')) as vm:
>
> I don't think /var/tmp is a good choice here, - I'm a bit surprised it
> come from you when your OS doesn't have /var/tmp by default - shouldn't
> it be /tmp here?

I thought I'd make the smallest possible change compared the current
behavior, to maximize the chances this lands. The current behavior comes
from the default base_temp_dir value of QEMUMachine, which defaults to
/var/tmp.

If you prefer to fallback to just '/tmp' rather than '/var/tmp', that's
fine for me as well, though it could be surprising considering
QEMUMachine normally uses /var/tmp at run time.

-- 
Thanks,
Maxim

