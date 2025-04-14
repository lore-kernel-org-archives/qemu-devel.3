Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3ACC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 14:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4KMq-0001yO-SV; Mon, 14 Apr 2025 10:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u4KMm-0001ve-Qm
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:00:53 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1u4KMk-0001eS-Pr
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 10:00:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ca1:0:640:740c:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id EB76E60EFC;
 Mon, 14 Apr 2025 17:00:45 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7316::1:b] (unknown
 [2a02:6b8:b081:7316::1:b])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h0HPe80FYuQ0-BMQtqttI; Mon, 14 Apr 2025 17:00:45 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744639245;
 bh=XPGblc8uji1R45gjtCZMazmDkP/lt9hnfvgbUJft+vA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=fE0mtsF6LIm89moKFk9qv+KHhD0AEI43eMA6VZVjWq34ddNebsbxyodzv854uxre8
 3wlcZuCvchaglBtYdRaD1grlVYkB/YQ5KnzBy1maWoEIvQBFTv8VKR9zyZWpMOimjV
 pFF8Z61mofaBaa3ub8J92PcAolFWkosDCvxLXBco=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <39c33337-d0aa-459f-aa16-f08dd18e3780@yandex-team.ru>
Date: Mon, 14 Apr 2025 19:00:43 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/avocado: add memlock tests
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
References: <20250414075702.9248-1-dtalexundeer@yandex-team.ru>
 <cbf25ba4-7e0a-423a-8662-efdb98ce50d4@redhat.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <cbf25ba4-7e0a-423a-8662-efdb98ce50d4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 4/14/25 14:14, Paolo Bonzini wrote:
> On 4/14/25 09:57, Alexandr Moshkov wrote:
>> Add new tests to check the correctness of the `-overcommit memlock`
>> option (possible values: off, on, on-fault) by using
>> `/proc/{qemu_pid}/smaps` file to check in Size, Rss and Locked fields of
>> anonymous segments:
>>
>> * if `memlock=off`, then Locked = 0 on every anonymous smaps;
>> * if `memlock=on`, then Size, Rss and Locked values must be equal for
>> every anon smaps where Rss is not 0;
>> * if `memlock=on-fault`, then Rss and Locked must be equal on every anon
>> smaps and anonymous segment with Rss < Size must exists.
>
> Hi Alexandr,
>
> tests/avocado is being phased out and will no longer be present in 
> QEMU 10.1.  Can you write the test using the framework in 
> tests/functional instead?
>
> Thanks,
>
> Paolo

Yes, of course. Thanks for reply!


Best regards,

Alexandr


