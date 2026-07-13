Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DA6C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj9oQ-0004rM-JB; Mon, 13 Jul 2026 02:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wj9oL-0004qV-Ty
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wj9oI-0004wN-90
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 02:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783922792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tFJWo3sAKMMnxGUbwRXyAS3ZFz1deahRn3V5EDNpkas=;
 b=HEa3eX78/YLBuDU5ydA4d5BgkeBlWbEPbGhIF1iGsbK4+0DJegU+YadLkdYoO0i+rEVInE
 w1MCzddDkHtg/L02wzEpSpmg67WGnhxB4wsZGb2AlySo3bqc2imvyUv57yGU3BZGAA5+76
 /8HDSHti2pwO6WEWWkxTsLneOMNfYAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-aj9PczqSMjWwSpPQ-wZeTQ-1; Mon,
 13 Jul 2026 02:06:28 -0400
X-MC-Unique: aj9PczqSMjWwSpPQ-wZeTQ-1
X-Mimecast-MFC-AGG-ID: aj9PczqSMjWwSpPQ-wZeTQ_1783922787
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 654B61955F03; Mon, 13 Jul 2026 06:06:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF35430001A1; Mon, 13 Jul 2026 06:06:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5EB0F21E6920; Mon, 13 Jul 2026 08:06:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org,  alistair23@gmail.com,  qemu-riscv@nongnu.org,
 bin.meng@processmission.com,  mzamazal@redhat.com,  mst@redhat.com,
 sgarzare@redhat.com
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark "Microchip PolarFire SoC Icicle
 Kit" orphaned
In-Reply-To: <CAEUhbmXaA6wpyUeVGL4Vn-zaP9LBFfmpTuWxDB=aMaXez_p=1w@mail.gmail.com>
 (Bin Meng's message of "Sat, 11 Jul 2026 19:04:14 +0800")
References: <20260710114305.2961898-1-armbru@redhat.com>
 <20260710114305.2961898-2-armbru@redhat.com>
 <CAEUhbmXaA6wpyUeVGL4Vn-zaP9LBFfmpTuWxDB=aMaXez_p=1w@mail.gmail.com>
Date: Mon, 13 Jul 2026 08:06:24 +0200
Message-ID: <87jyqzwhi7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Bin Meng <bmeng.cn@gmail.com> writes:

> On Fri, Jul 10, 2026 at 7:44=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Commit 4a16a1a7ad (MAINTAINERS: Remove Bin Meng from RISC-V
>> maintainers, 2025-01-28) removed the only M:, but left S: Supported.
>> This makes no sense.  Downgrade to S: Orphan.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 576ef6fff5..aa2df9cbe3 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1761,7 +1761,7 @@ F: tests/tcg/riscv64/test-crc32.S
>>
>>  Microchip PolarFire SoC Icicle Kit
>>  L: qemu-riscv@nongnu.org
>> -S: Supported
>> +S: Orphan
>>  F: docs/system/riscv/microchip-icicle-kit.rst
>>  F: hw/riscv/microchip_pfsoc.c
>>  F: hw/char/mchp_pfsoc_mmuart.c
>> --
>
> I plan to send a patch series to resurrect PolarFire SoC support.

Nice!  Please re-add yourself to MAINTAINERS then.


