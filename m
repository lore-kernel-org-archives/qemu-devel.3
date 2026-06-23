Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6FACDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwh8-0003x0-Ge; Tue, 23 Jun 2026 04:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwh3-0003wf-Q9
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:41:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwh1-0004we-P3
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:41:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6cgXc3063451
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kd9MtjhdiKVdRVP72ha4KQxAKIrSOtG+fdO+bhI3KPQ=; b=pzmyVseiQTUQPtKb
 GRuRKZkGN3R2i5cyo3jPmWyacdyYhjBbfsFR0X7D2r7BeVqy1Nh41a/FG6Qf4blM
 wRSsd4BiQUSOS+37AtLEaBlVP949gOgegnnKcZvjrbVUAlIG6sdyzTi5V81UFpmS
 /B50tWdQ/whiZcFo4w0Xf4UKDDCr7ZvA6/BjwCPb6O8/b+SzEmqOHMoUhpfg4ns9
 Uh4dTdKTGtxoPGTiNa/otDvOurskREL3IVMMeFTSb8cXII5m7K6L3egJcDaX3Hab
 4cTWL29KRiLdEi2rP4eC9j2w3qHwc5DzB1gYAi2VxwFP5lPWQvoQK/n4mm02mDcU
 hBTVIQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yjceff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:41:13 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-915c8347cd5so1104882485a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782204072; x=1782808872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kd9MtjhdiKVdRVP72ha4KQxAKIrSOtG+fdO+bhI3KPQ=;
 b=GdQSkseFBQvfiIGqhpE56FdIYf0Qkqz9DQtAQUDkBsRDXc7SWCq3JjT3M1q6Yv1Miw
 uhOU3fIfiUTQrfepmzZ0Xavv1XJ30bqjDXj6PVu7k3Mxa2vhiujn+uiaDvB87EbXGLGG
 KxG3T6TGKMDKgMLEczRxh1rhGhRDDzqlU/t4S9ydvrLSHNQnGIKkW5H9vqs40a0cL9yM
 2OwNDPb0Mtjnv2Xi0MQmOfEcn/SfQuIn8y4gzXM4CqDWUW9JlkqL0v8VdcH5LainqBL/
 K7G/hUWY5olsglZS+o7RVGFRloptB59w2nw8y50bLC1VBuXbT6LdLGpJJyB/yELybviq
 wheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782204072; x=1782808872;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kd9MtjhdiKVdRVP72ha4KQxAKIrSOtG+fdO+bhI3KPQ=;
 b=lLKmXMDpT663vvr2OsUmaJ5yMvxmi3O/kWefFjt7xdqJ0Dt1opf8r9//hjP67qkr5H
 Ux6BexB3RRgydrcBcSu7eq41x8Py2gB51P6bI/ewsLVsEMEqsUpnL2+qgv1O1mLM48To
 jgvm23HnKkUZqN4boO+c6Z34Y/DAiJAK5RUhlaZWHvAxknTmiXizWTVaR3rI74hdULGs
 hgPA82wWeZV6WXE2ABfae/BlT43YbRDCxZG9gKY8HWKgbWNQ96HvvLRYiAfmH84CAjcB
 omDj/DVDEXGElAI+wzxe6E7ewunIG4OdFtOOWGdSBqiX4Bbd8fazh78jV7ErYWigcD/R
 xXTw==
X-Gm-Message-State: AOJu0YyC6Lc/FxrmTpbH8xH5vVpWI0lDhmvt+O/g8Szh0GzqYs5yxFF4
 9wt0BaOMbl7qPAvLzUFoLLU0AoYufdI9we5DoClEGPhp1agz9pKYK+mV3LcKW9zZypTRK/gAZ4p
 2oMZcCvNVGjrKPGcOs3LGoBjQ+fyEgDZ4KYfCCC2OOA18oeplqZ/WwL3f3w0Ez5aOHbbC
X-Gm-Gg: AfdE7ckRhhtqSFbNLjpYvzb07r3fBKAaHSGOpjY3GUR54W5rxiPFb9BDt3j0dhmvxPF
 sNFkmvX4Jp48/jbM0H62kO2r45PGoPCd4RNuwDXRu4w8yfyWDyYsLpIFUPYKXAzA4uxvkoo4Ut5
 Vr+IJuIPzPEHUgEq6m9x1sA1YntegHw4cRBelWxekBzUDPqiyTRQoM4TPeOgW6rMLNyXgklxxC3
 1hUa/NxBObtQR6e0r7voO3ndFFwpPto1upIXn4stnKqiHQjZMgjJuU7pbHGOw7YLeE5utonNKio
 5ylX0PE4rU3//eWFpogC/0PpA70N0q9/0ro9iZ77TZWrkJkvQ04B9WHy53rXrl8hdAPW/9PLjQe
 2bQAfQJUxBPyqUe89DLviG3gUpGEmJ9eS2yCMPQTvZAshwr0/2sYqhJnMfw7Ohg==
X-Received: by 2002:a05:620a:3188:b0:915:e8fb:acc0 with SMTP id
 af79cd13be357-9266c5253b9mr245744185a.23.1782204071988; 
 Tue, 23 Jun 2026 01:41:11 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:915:e8fb:acc0 with SMTP id
 af79cd13be357-9266c5253b9mr245740685a.23.1782204071538; 
 Tue, 23 Jun 2026 01:41:11 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c5e99e1aasm463019966b.25.2026.06.23.01.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:41:10 -0700 (PDT)
Message-ID: <a0206dfa-d7bc-4fbc-b7aa-d2c551fbe52e@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:41:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] dump: report win-dmp via vmcoreinfo, guard
 guest-RAM reads during migration
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, berrange@redhat.com,
 peterx@redhat.com, farosas@suse.de
References: <20260619101834.228432-1-den@openvz.org>
 <CAJ+F1CKa5zmjo-5GCJW3BohCSBknjWsZmKRV1Oupa20A742w7w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJ+F1CKa5zmjo-5GCJW3BohCSBknjWsZmKRV1Oupa20A742w7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xU0otgWg5cRP3Q4U5BSyuijzsXjsP3ym
X-Proofpoint-GUID: xU0otgWg5cRP3Q4U5BSyuijzsXjsP3ym
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA2OSBTYWx0ZWRfX6GJXJoz26F1Z
 jOKm+q/LpD7H19NDgVfayON86h91tF2kRQg4fPW9ALq8fwqRgQZgHXaDBYNzhWwj/WCdtQ6DDc0
 KL6hfXa07YejaBsCZVjKn4bYnpp40UY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA2OSBTYWx0ZWRfX1PUq+UQRCzRb
 sfDv6bPQj1z2bD6VgL3LkM+OezXK5+S9E+MdbKCB7YIRe2D8Eq8kC/OZN4kikSyULEyK1Ovj7Vl
 hmxM216/66hhcB5j9c5dJEI9Urzxv2diRgy/Jw1jl1hQVn+QV4ekhjZ4kJFRqyUydglOjvEW1E0
 dw+tqYUpzmXXrPWkVdLGeIXzTuuin6ELiiHs7VZ0Vx7J7SSSW9gX5NUV35bCQsv7kgm0tmvE/x2
 Ga9wUt/apTOIPJFkrER+VEijd68lORXgunWMJUTcj0F/y2X8h8hmy5MQrsFXlpMEL5NJlrOUWk2
 Z8Dm5HeMYvSRhlH40J9EX6dSBTIwU3x7A5qpOtURtlyMWbnvGjGgK9H2If6Lobz5bfCUqb5xaEy
 tJuTddHYblhDBTvPPv9UlMJJ5WHMRiGRbjHsU0nhJkGqsl7rDd4qOD7bRNqXpgyI4G8ko63NgJc
 2H5vyHsT09+OhoW59Ow==
X-Authority-Analysis: v=2.4 cv=YLSvDxGx c=1 sm=1 tr=0 ts=6a3a46a9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=69wJf7TsAAAA:8 a=hznr0o02qFJ1HsWEPawA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 22/6/26 12:58, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Jun 19, 2026 at 2:19 PM Denis V. Lunev via qemu development
> <qemu-devel@nongnu.org> wrote:
>>
>> This series fixes Windows-dump (win-dmp) availability reporting and closes
>> a related hole found while doing so: several commands read guest RAM and
>> must not run while a migration destination is still receiving it.
>>
>> dump-guest-memory, memsave and pmemsave all read guest RAM on the main
>> thread with the BQL held. On a migration destination that RAM is either
>> still being loaded (precopy) or pulled from the source on demand
>> (postcopy, where the guest already runs). During precopy the read returns
>> incomplete data; during postcopy it deadlocks, as the read faults on a
>> not-yet-received page while the postcopy incoming path needs the BQL the
>> reader holds to install it. dump-guest-memory only guarded the precopy
>> phase and memsave/pmemsave had no guard at all, so a new
>> migration_guest_ram_loading() predicate captures both phases and all
>> three commands now use it.
>>
>> query-dump-guest-memory-capability also advertised win-dmp for every x86
>> VM, and dump-guest-memory accepted it unconditionally; win-dmp only works
>> when the guest has published a Windows dump header through vmcoreinfo.
>> win_dump_available() now reads that note back from the vmcoreinfo device
>> and validates it, keeping its original signature, so the dump.c call sites
>> are unchanged.
>>
>> The series also adds the first qtest coverage for dump-guest-memory:
>> capability list, ELF and kdump output, protocol errors, and win-dmp
>> reporting in both directions (the positive case forges a vmcoreinfo note,
>> so no Windows guest is needed).
>>
>> Tested:
>>   - Linux guest: win-dmp not advertised; an explicit win-dmp request is
>>     rejected without stopping the guest; elf/kdump dumps work.
>>   - Windows Server 2022 guest: win-dmp advertised once vmcoreinfo is
>>     populated; dump-guest-memory format=win-dmp produces a valid (PAGEDU64)
>>     crashdump.
>>   - Live postcopy migration: on the destination, dump-guest-memory, memsave
>>     and pmemsave are all refused immediately, without faulting a page.
>>
>> This supersedes the earlier "dump: enhance win_dump_available to report
>> properly" series, which obtained the note by reusing the dump setup path
>> (splitting dump_init() and stopping the vCPUs). Reading vmcoreinfo
>> directly is much smaller.
>>
>> Changes since v4:
>>   - Refuse guest-RAM reads (dump-guest-memory, memsave, pmemsave) while a
>>     migration destination is still receiving RAM, via a shared
>>     migration_guest_ram_loading() helper.
>>   - Decide win-dmp availability by reading vmcoreinfo directly instead of
>>     splitting dump_init()/dump_preinit() and stopping the vCPUs.
>>   - Add dump-guest-memory qtests.
>>
>> Denis V. Lunev (7):
>>    migration: add migration_guest_ram_loading() helper
>>    dump: refuse dump-guest-memory while guest RAM is being migrated
>>    system/cpus: refuse memsave/pmemsave while guest RAM is being migrated
>>    dump: make win_dump_available() check vmcoreinfo for a Windows dump
>>      header
> 
> Looks all good to me, except it needs
> s/cpu_physical_memory_read/physical_memory_read now. I can do that on
> MR
> 
> Philippe, do you know why physical_memory_read/write() do not return
> MemTxResult?

Because these is the legacy API we want to remove; commit b7ecba0f6f6
recommends to use address_space_*() instead:

   ``address_space_*``
   ~~~~~~~~~~~~~~~~~~~

   These functions are the primary ones to use when emulating CPU
   or device memory accesses.

   [...]

   ``physical_memory_*``
   ~~~~~~~~~~~~~~~~~~~~~~~~~

   These are convenience functions which are identical to
   ``address_space_*`` but operate specifically on the legacy global
   ``&address_space_memory`` address space (which might not be used by
   all machines), always pass a ``MEMTXATTRS_UNSPECIFIED`` set of memory
   attributes and ignore whether the memory transaction succeeded or
   failed. Expected users are hardware device models. For new code they
   are better avoided

   [...]

> 
>>    tests/qtest: add dump-guest-memory test
>>    tests/qtest/dump: reject win-dmp without vmcoreinfo
>>    tests/qtest/dump: cover win-dmp availability via vmcoreinfo
>>
>>   MAINTAINERS              |   1 +
>>   dump/dump.c              |   5 +-
>>   dump/win_dump-x86.c      |  42 +++++
>>   include/migration/misc.h |   3 +
>>   migration/migration.c    |   6 +
>>   system/cpus.c            |  11 ++
>>   tests/qtest/dump-test.c  | 331 +++++++++++++++++++++++++++++++++++++++
>>   tests/qtest/meson.build  |   1 +
>>   8 files changed, 398 insertions(+), 2 deletions(-)
>>   create mode 100644 tests/qtest/dump-test.c
>>
>>
>> base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
>> --
>> 2.53.0
>>
>>


