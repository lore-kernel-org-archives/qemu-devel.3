Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2A7CD6E55
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUgut-0008FT-TD; Wed, 03 Jun 2026 04:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgup-0008Es-Rd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:31 -0400
Received: from msg-2.mailo.com ([213.182.54.12] helo=mailo.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@mailo.com>) id 1wUgul-00033W-Qx
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 04:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailo.com; s=mailo;
 t=1780472770; bh=Opd4JDTiZiQ+bXFRjjMErjTYKosRlWG7rI10eDBAWxw=;
 h=X-EA-Auth:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 b=cpgfbI6+bSxQ+cbSnc4BK3syD/C2OdTBfT1grBpA6oyFxIjPRFHqh7MIShPgp0Ti9
 8g74L0DvCXwOtCH0mciT0K95n78WdG0cbGBdRVmo5C8TvSOdR8eQuwY+9Yg+N9h8Fk
 QN5Y844NRY8A4Bdwgp5BhRIt/ols55Ox1LZqx0BQ=
Received: by be1-2.in.mailobj.net [192.168.91.12] with ESMTP
 via ip-20.mailobj.net [213.182.54.20]
 Wed,  3 Jun 2026 09:45:30 +0200 (CEST)
X-EA-Auth: UPJTu16hX0sWagFtzPUSwDhOTQwz5urlH3eoz9AYSRAfIp4OM7eqSEN3rj9ThHDKDNsmpguAqAEcsCG0Us9kgvdmOmbhTZpq
Message-ID: <c9707c49-59ee-458c-8469-12943bab90c2@mailo.com>
Date: Wed, 3 Jun 2026 09:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/4] hw/mem: add spm-memory device for Specific Purpose
 Memory
Content-Language: en-US
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Huang, FangSheng (Jerry)" <FangSheng.Huang@amd.com>, qemu-devel@nongnu.org,
 imammedo@redhat.com, gourry@gourry.net
Cc: Zhigang.Luo@amd.com, Lianjie.Shi@amd.com
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
 <39411489-1473-44ad-ad56-392aa27990ab@kernel.org>
 <5ff45049-d96e-428c-915d-fc14cbcb5e58@amd.com>
 <d4297ad2-4695-4634-a12e-80d65a34e79f@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <d4297ad2-4695-4634-a12e-80d65a34e79f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=213.182.54.12; envelope-from=philmd@mailo.com;
 helo=mailo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 2/6/26 14:21, David Hildenbrand (Arm) wrote:
> On 6/2/26 12:02, Huang, FangSheng (Jerry) wrote:
>>
>>
>> On 6/2/2026 5:36 PM, David Hildenbrand wrote:
>>> On 6/2/26 10:44, fanhuang wrote:
>>>> This series adds a TYPE_MEMORY_DEVICE subclass `spm-memory`
>>>
>>> Very nitty: but spm already includes "memory". And I think most things on the
>>> cmdline use "mem" as abbreviation.
>>>
>>> "sp-mem" ? or simply "spm" ? Thoughts?
>>>
>> Good point — the duplication didn't quite register when I named it.
>> I lean toward simply `spm`: matches the `dimm` / `nvdimm` acronym-only
>> pattern.
> 
> Best to wait for more feedback :)

+1 for 'spm'



