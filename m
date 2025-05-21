Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11270C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHfBb-00042E-RT; Wed, 21 May 2025 04:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uHfBZ-00041v-B8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:52:25 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1uHfBV-0004fg-P6
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:52:25 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:4195:0:640:137b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 6423560C83;
 Wed, 21 May 2025 11:52:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:803e:400:b77e:ba0d:cfcc:d8a5] (unknown
 [2a02:6bf:803e:400:b77e:ba0d:cfcc:d8a5])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id BqJGfE0Fd4Y0-a7SfsiQQ; Wed, 21 May 2025 11:52:12 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1747817532;
 bh=HGquC7GNMsVVzLmjkeZklsmiHj3PwkxNFy8CAoCi1iY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=XSWDh/JKLwYsqrfwT+uvs+oSIjLnwa0VIqZGr01ePOqpubEJy4y+OHwuTteGVBCMQ
 KNcKBQ+NkDPJQehxmjidOwXFD3LsMnR7a+kyUUnXFG0nkNfUQnMjWhr8Ujbb5I11P+
 dzlPBk3Nu21d3XR8WB66KbNjJrFG81T6aEpPdXzk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5f7cd94d-d0de-4e06-957e-b246d4be534b@yandex-team.ru>
Date: Wed, 21 May 2025 13:52:11 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] tests/functional: add memlock tests
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20250417114008.169350-1-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20250417114008.169350-1-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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


On 4/17/25 16:40, Alexandr Moshkov wrote:
> Add new tests to check the correctness of the `-overcommit memlock`
> option (possible values: off, on, on-fault) by using
> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
> anonymous segments:
>
> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
> * if `memlock=on`, then Size, Rss and Locked values must be equal for
> every anon smaps where Rss is not 0;
> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
> smaps and anonymous segment with Rss < Size must exists.
>
> ---
>
> v5 -> v6:
> * add python3 shebang to tests/functional/test_memlock.py
>
> v4 -> v5:
> * refactor skipLockedMemoryTest decorator: using resource.getrlimit()
>    function instead of spawning a process
>
> v3 -> v4:
> * add skipLockedMemoryTest decorator to skip test if system's locked
>    memory limit is below the required threashold;
> * add to MemlockTest skipLockedMemoryTest decorator with 2 GB limit.
>
> v2 -> v3:
> Move tests to tests/functional dir, as the tests/avocado dir is being phased out.
> v2 was [PATCH v2] tests/avocado: add memlock tests.
> Supersedes: <20250414075702.9248-1-dtalexundeer@yandex-team.ru>
>
> v1 -> v2:
> In the previous send, i forgot to specify new patch version (v2)
> So i resend previous patch with version specified.
>
>
> Alexandr Moshkov (2):
>    tests/functional: add skipLockedMemoryTest decorator
>    tests/functional: add memlock tests
>
>   tests/functional/meson.build             |   1 +
>   tests/functional/qemu_test/__init__.py   |   2 +-
>   tests/functional/qemu_test/decorators.py |  18 ++++
>   tests/functional/test_memlock.py         | 104 +++++++++++++++++++++++
>   4 files changed, 124 insertions(+), 1 deletion(-)
>   create mode 100755 tests/functional/test_memlock.py

Gentle ping :)

Also add reviewers from get_maintainer.pl (forget to fix it after 
refactor on v3)


Best regards,

Alexander


