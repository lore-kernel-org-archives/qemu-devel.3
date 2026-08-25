Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1EDC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 04:59:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyjFs-0007k4-Dw; Tue, 25 Aug 2026 00:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wyjFp-0007gm-0T
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:59:21 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1wyjFn-0001HN-DI
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 00:59:20 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2d58efc7356so47833975ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787633957; x=1788238757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EIlsxZYNsiuRPICbPOBzoHSvFAjyTxKWba+y+70tYRE=;
 b=QtCEDkfUKmJeaNeBacNnRetznDvr46uiBTldwmWyrneeab1Jnt98Q7yiL0r0K5ddtd
 ydfnkfnbDg44l3++Th27ll6I4lnM0tiGxkz+586vPbMJccMK6pW6nFS7HAx8RL2yiqCr
 XqS2JTo+iGL3K4u+PoXXKmkbKG1P6I5A3DFXZXAAMPVMSS15Sl6KfYuAL9LetBYnwQcY
 sXWzlL/Ex7CSqUEiBkgfF0jjxfL7YAxNaESaaAwmvrFZomegFEiVg+qdYXeisn8GNkFb
 /icoujWVPkrVB37jPSd7EUayOKjhQ2+o2TX+UMwx0nKeIrdr4z6MgKNK5Q4DJ4OPPOGT
 X1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787633957; x=1788238757;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EIlsxZYNsiuRPICbPOBzoHSvFAjyTxKWba+y+70tYRE=;
 b=kBM/aqLyyp+6ftdvS7em/pG/Kud6REkYMPbAUQuI2vzBMF/4rsckWCJszpQEvOWVHK
 9YmLmdpdhucft+AraqKE8nopOH/3X/hpIIgLHLPo/kJG0kwPSSiDRZQq2wDeAFx/xYpD
 kJWOfInsyDSaNJTwLO/McesVXbRDM83gWipHAB/sZUB3C22NgTBOw6gg5NG6rCgil7b+
 xHRoA9seUClPmX4EkGKCeHo8W9hRF3WRipkHfzn9+aIHCUoAHi8OQ0xUeXG9zEySYiiz
 ZSfTc/qADIqs6zf/6vdwGiyLoq8TtESa6OgtKdOEJOjCLW7yZaNiro8Hw0OOxGkQ1wed
 /VfA==
X-Gm-Message-State: AFuF++mZTKwZU0dxKH8fdiiVTswnFebxuNOHVYzGA/KPh5ePvfOrctFe
 4gLF8XEITtrnBcVFnDOTVYMF2V++PL3MoKYaVgaqPfQBiSsvIS59fYRp
X-Gm-Gg: AR+sD11tzgnD/vuVXKflEiKB7CAiGvnU6JCYIcuJmFlIaRi9sUcU6ThXmTsrY5Y2nT2
 RpYL7505CQNGcOd2fGZ2dKitGenyQHXZQZ6+3995HE/jCH08aTxIdiEV7vBd9CkEJKn2ZyXJU6N
 O/5FqJIO4ggziVtG/ZeAoEuDlQ82mM9mMOPF8H8/pAleU0bJAMjEhm1S1CDPd1fOrvxqB6QF8ex
 9QOQkT3tCSLhf8N0DuCnkeCF0nNWlzcNrmKtKWCqK1yHiFZAPJa6PiQT6QN4pbZyPULlgqjsZfY
 lDVJwEP3SKHb4ZjSx7s/3e3zLpePKSpEoGNQUbV+q8M/1TESr82i2TRsZLF7VWSl3kOJ993c7vA
 OZ54JVAj6ViNm5E/2LaWb8r9u0WxxUaH8tZB4n29lxH6WtTgTbmTueY/j2i+MfhFcbc0ConD2Ti
 gVJlKg9fAm+h2hn/g1K+JGWz7u5GcMrEa5vZZGdujUCHhl0B7b3W+5bCI4Bx69EonfGylZOQxd
X-Received: by 2002:a17:90b:3a8d:b0:395:4de0:b78f with SMTP id
 98e67ed59e1d1-395dee528b7mr39440853a91.1.1787633956591; 
 Mon, 24 Aug 2026 21:59:16 -0700 (PDT)
Received: from [10.3.172.9] ([61.213.176.11]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3964581202fsm2232272a91.0.2026.08.24.21.59.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 21:59:15 -0700 (PDT)
Message-ID: <7d31d96c-4d91-4f87-9728-85cb84b60c6e@gmail.com>
Date: Tue, 25 Aug 2026 12:59:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/2] migration/rdma: Allow multiple writes per chunk
To: Peter Xu <peterx@redhat.com>, Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com
References: <20260820125833.1541756-1-yanfei.xu@bytedance.com>
 <aodcq-LRjtFacLdc@x1.local>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <aodcq-LRjtFacLdc@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


On 2026/8/21 03:59, Peter Xu wrote:
> On Thu, Aug 20, 2026 at 08:58:31PM +0800, Yanfei Xu wrote:
>> My understanding is that within each iteration round, the HVAs carried by
>> different WRs never overlap, so serializing WRs within the same chunk isn't
>> necessary. This patchset builds on that assumption — please correct me if
>> I've missed or misunderstood anything.
>>
>> This series improves RDMA migration throughput during the iteration phase
>> and iterable stop-copy phase by allowing multiple writes to the same
>> registration chunk.
>>
>> RDMA tracks RAM in registration chunks.  During the final iterable
>> transfer, workloads always leave many scattered 4 KiB dirty pages, with
>> several pages falling into the same chunk.  The current code waits for
>> an earlier write to a chunk to complete before posting the next one.
>> These serial completion waits can leave send queue capacity unused and
>> limit RDMA bandwidth, increasing downtime.
>>
>> The first patch replaces the per-chunk transit bitmap with reference
>> counts.  The second patch removes the per-chunk wait.
>>
>> rdma_registration_start/stop functions called in each round synchronously
>> drain all in-flight WRs with cq, which can serve as a barrier between
>> rounds.
>>
>> The test configuration is:
>>
>>    RDMA chunk size:    32 MiB
>>    Guest:              32 vCPUs, 128 GiB RAM
>>    Test runs:          10
>>    Max HCA bandwidth:  100 Gbs
>>    Workload:           idle
>>
>> Average results:              Before       After
>>    pin-all is true
>>    Downtime                    396.7 ms     345.7 ms        ~12.9% improve
>>    Final iterable bandwidth    9952.0 MiB/s 11639.10 MiB/s  ~17.0% improve
>>
>>
>> Average results:              Before       After
>>    pin-all is false
>>    Downtime                    248.7 ms     191.1 ms        ~23.2% improve
>>    Final iterable bandwidth    5605.1 MiB/s 9826.0 MiB/s    ~75.3% improve
>>
>> Note: Final iterable bandwidth actually means the bandwidth during
>> qemu_savevm_state_complete_precopy_iterable(). non-iterable data doesn't
>> use RDMA Write.
> So I left some comment in patch 2, but maybe I should just comment directly
> here.. please check that first.
>
> If you would agree with what I said there (and you should have noticed
> another patch I sent days ago removing UNREGISTER path), I think what we
> really need might be:
Completely agree, very good suggestions. Will rework the patchset based on
these points (I might get to it in a few days).

Thanks for your detailed explanation!

Regards,
Yanfei

>
> - Move RDMA draining from ram_save_iterate()/complete() into each time we
>    finish scanning a round
>
> - Remove transit_bitmap completely (if you see after applying your this
>    series, the UNREGISTER should be the only user..), because with the
>    correct draining IIUC we don't need this anymore
>
> Thanks,
>

