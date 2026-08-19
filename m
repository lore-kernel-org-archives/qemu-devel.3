Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3355C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 20:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwmgr-0007fY-R4; Wed, 19 Aug 2026 16:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwmgp-0007eC-Iq; Wed, 19 Aug 2026 16:15:11 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwmgn-0005vI-He; Wed, 19 Aug 2026 16:15:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 6E11580D14;
 Wed, 19 Aug 2026 23:15:04 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a71::1:2b] (unknown
 [2a02:6bf:8080:a71::1:2b])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 3Fdor6CaYuQ0-W34I26e4; Wed, 19 Aug 2026 23:15:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787170504;
 bh=U5G3v9NU+AdnBltF6hJWctZIuvVgvs7T/+Q8Q23AfaI=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OeCchM42SD+0RKoxRsgSdtf7w/P8WbUgQT/DpbtC/fx9JT99O368EqNjSr44Q9qse
 axgDlCNdQ93oVN+X2aoL6O7LTC0FrTrSA3fXjD3Upx9fDj25EKIGHTj3X5HSsHhd7i
 ZQofdY+2OmnUM57HA3irDWDU332aYmeeNJ8v8A9s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <887f9e6d-ca07-4b57-91ff-87179f42f308@yandex-team.ru>
Date: Wed, 19 Aug 2026 23:15:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/../test_hotplug_blk: drop unused nic
To: stefanha@redhat.com
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Daniil Tatianin <d-tatianin@yandex-team.ru>
References: <20260629201332.1001055-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260629201332.1001055-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

ping

On 29.06.26 23:13, Vladimir Sementsov-Ogievskiy wrote:
> From: Daniil Tatianin <d-tatianin@yandex-team.ru>
> 
> The test doesn't need any networking, so drop the net card.
> Also the test will break if at some moment q35 aliase refers
> to machine type with default virtio-net nic, which will clash with
> virtio-blk in the test, and
> 
>     self.wait_for_console_pattern('virtio_blk virtio0: [vda]')
> 
> will not work.
> 
> Let's make the test a bit more resistant to experiments with
> machine type.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/x86_64/test_hotplug_blk.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/x86_64/test_hotplug_blk.py b/tests/functional/x86_64/test_hotplug_blk.py
> index 7ddbfefc21..a9b43fe2e9 100755
> --- a/tests/functional/x86_64/test_hotplug_blk.py
> +++ b/tests/functional/x86_64/test_hotplug_blk.py
> @@ -66,6 +66,7 @@ def test(self) -> None:
>           self.set_machine('q35')
>   
>           self.vm.add_args('-accel', 'kvm')
> +        self.vm.add_args("-nic", "none")  # avoid creating default nic
>           self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
>           self.vm.add_args('-m', '1G')
>           self.vm.add_args('-append', 'console=ttyS0 rd.rescue')


-- 
Best regards,
Vladimir

