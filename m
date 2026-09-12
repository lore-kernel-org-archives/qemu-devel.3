Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD141C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 09:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5KRv-0007C8-77; Sat, 12 Sep 2026 05:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x5KRs-0007Bg-Eu
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 05:55:04 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1x5KRp-0006By-6T
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 05:55:04 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id AD425C0B16;
 Sat, 12 Sep 2026 12:54:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:8a5::1:9] (unknown [2a02:6bf:8080:8a5::1:9])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id rsN1gmTaemI0-1wcGwbDi; Sat, 12 Sep 2026 12:54:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1789206894;
 bh=WxjrT8TKzNeTuyKEUZkChzQx3NcuXSvb6IAlkoBmrro=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=wRiDDHYFpZAfMku5kTuzaDQ94x8r+smOcp+pERfW2aY5Os1Dm+SczJ4D2r/eVPqx6
 yYx4UZmBypNouVdTWBQ6Pj0gc9/FEqj8DlaoltKYDuuhflkcg4fjIIK+sbnGXa/CsR
 tyeLnkBj8juoFtHvws040t0+ioz+gnJgoB8xSg9k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <576a4fd5-9846-477e-a4df-7603c758378c@yandex-team.ru>
Date: Sat, 12 Sep 2026 12:54:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/75] pci, vhost, virtio, iommu, apci: features, fixes
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <cover.1789117222.git.mst@redhat.com>
 <6134ac71-f451-4caf-88df-af001641a05f@linaro.org>
 <20260911155428-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260911155428-mutt-send-email-mst@kernel.org>
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

On 11.09.26 23:00, Michael S. Tsirkin wrote:
> On Fri, Sep 11, 2026 at 09:06:26AM -1000, Richard Henderson wrote:
>> On 9/10/26 23:01, Michael S. Tsirkin wrote:
>>> The following changes since commit 1df256f5968e9f7c3c4533a1383b071c044a36d6:
>>>
>>>     Merge tag 'qom-qapi-pr-pr-v1' ofhttps://gitlab.com/marcandre.lureau/qemu into staging (2026-09-08 18:35:31 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>>>
>>> for you to fetch changes up to 2f8991c0b9c400f55897849a538580039b61865a:
>>>
>>>     MAINTAINERS: add Junjie Cao as CXL reviewer (2026-09-11 04:59:15 -0400)
>>>
>>> ----------------------------------------------------------------
>>> pci, vhost, virtio, iommu, apci: features, fixes
>>>
>>> new vhost-user-media device
>>> virtio-net now supports live-TAP local migration
>>> cxl now supports CFMW restrictions and per-window options
>>> intel_iommu now supports concurrent page fault handling with PRI
>>> pci now batches memory transactions around mapping updates
>>> vhost-user-blk now allows toggling inflight-migration at runtime
>>> virtio-rtc now supports smeared UTC clock type
>>> intel_iommu now exposes SMPWC when SVM is enabled
>>> new reviewer for CXL patches
>>>
>>> Fixes, cleanups all over the place
>>
>> https://gitlab.com/qemu-project/qemu/-/pipelines/2840522620
>>
>> Between the 6 failing jobs, I think there are 2 failures replicated:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/16454091774#L800
>>
>> 18/34 func-quick+func-x86_64 - qemu:func-x86_64-linters               FAIL
>> 6.00s   exit status 1
>> 34/34 func-thorough+func-x86_64-thorough+thorough -
>> qemu:func-x86_64-tap_migration     ERROR            0.19s   0 subtests
>> passed
>>
>>
>> r~
> 
> That's the new test. I dropped that.
> 
> 
> The func-rx-vnc is due to the test using a fixed port which is
> always a bad idea, making the test flaky.
> 
> Pushed to same tag, could you try again pls?
> 
> Vladimir FYI tests/functional: add test_tap_migration is dropped
> due to linter issues and missing iproute2 dependency.
> 

OK, no problem, I'll resend it

-- 
Best regards,
Vladimir

