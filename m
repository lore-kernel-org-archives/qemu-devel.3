Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16601C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 04:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnTrd-00007R-Eg; Sat, 25 Jul 2026 00:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wnTra-00005a-5c
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 00:19:50 -0400
Received: from sonic304-23.consmr.mail.gq1.yahoo.com ([98.137.68.204])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@netscape.net>)
 id 1wnTrW-0000m8-8c
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 00:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048;
 t=1784953182; bh=5d+TOFMpht5NNDS9biKMtmdNpshrH9FMk1WSBz5DJDE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To;
 b=JQgPy4k8R61WFgnGeYvVny5lIXTI7j3nsAgKJg++iF0x9N3q8xNn4FU+ZsGbhLVdTnrS+D7rRmfxqaC0RbAI5yQOP6f95MsK1qYuECtxzKXynF9P0Eapmo3FBbPzGOA3GsfYN3NQv66jarvD3t+lKH1kV7eVK1+hLpzaP0Yv7f2FnOrpCO3Vo2ix8H9VMODv8UeJfIK/IX4OShipimazDKAEpiUfxExk4kZxk7gW6j1pNui3zNeJBlSdk0UqpV2OJZT+w/NFcsg95bsvhHHr1cHzuN3NQO9u/uU9FPMqE40Yh2oJxWDRQZQMGXBt2D2tjyS2nvGyYNwvjyPLPL1l1Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1784953182; bh=JMp2hksYC9h2iMxPZiI2LMkkn+DKmGrYKmdRUNp0ANc=;
 h=X-Sonic-MF:Date:Subject:To:From:From:Subject;
 b=Fa45ZLi2Suk2MyAeE4H4oafQfoZa3oEGSZtWPmq4dFkYoBIrNLFxx5eq6+/NtdYV6xmxfRCxK1G1A5ZNfiZecrUS06uwKtLgH1w5VL0VzGd+iJl9OrMXt34pteTHIaqL7QtxEDEPITaNlGB7XFH6NjKfx/o5wCFAAQVjkbgEk16OYpCH47/MlK6+gYq+uhQWSnz4bk28AUsBiBA3oALejzZGxdaQMYCDUAPQ7ldXn02CVd43NmucAUGf2JxNfcY2ptPPvGoMKezZpGRKFjmxLjoSJkWsK3mrhASabpMaL+qVGjMec/q9yur6ZHgsAo2L1Ql4ckaamw663z7/VJeSCg==
X-YMail-OSG: rJYxrYUVM1nRXt3Qy7zIx.eZM2TW6z4DM2fg9rM5f_dNAHHDjeGqMF.gLEN5ZOF
 5VbTCmeathxj2nXzLUERWxS.waw5oOOJ5MW.4acgGFvPE6K8ml8i4f4dBgDpfF8d5yHGxfJnyiou
 CxwscuO446c8eiABZoFyHUX13GZ8kiQjZb2GxjZf3WsrzUKcQBmC.0uVfnyBObld6Bb9PUaNU9Pt
 QAahuLiWRRWSXdl9IIBtBPDy_pfpHo1lcKJHBGQdj6eIBZ0RIW4lXwARimTQdJdiSHSql3lAidkK
 rcTIyYkE3m356QTnnspR34qHaPWnJIK.ugF656XkQ6vUutLFtXa82bF4z2Hcr.7_cTQ21l90zD7G
 .WUFANtXjhJd7.LAxNJwWpOJrUqCsvRWa1bXKhfac53ej6QR2oYgBam9Qun79ndbL79NdjXeF3Qi
 JvvJULCmXR9tBydQju0_Y8Pu06XvnkyxerFUbQfONnvnWS4hfgobXsX0H8UuyHY5zYMcDd_fNops
 DGXA0HdKWHY.WGViDhW9yWSKxptBvheqCyae3QuFA.hgVXgnKG0vOjy2BjKgJakhar5fqhBe6stc
 7xi_NWuQWqVzmr.jrCpk5PzlDCGCBJY9.teJiueZMFMWjeLgCAjZvdhkdUC5eoNB1LPnEaf.Np7X
 oFl3.PLMN3J6USmu5E8NZ2Ez9ozBHBOX1Kbu3fQpVmeMLZGLCXXQes0ZxOZbR3DuA4h1pi9iL3jx
 8Gy5L8UgrIQmwc1MS99QUYTqTp5BmsDiPqgdsOVJoIy0AEQoZ2XsbWRQojmuNMkFS5ySszlC5U8N
 fVJfPGrsSAY_5CIdOq6vZXi4ddq_lrB_s0OE.tg1jXLdldiCdxuwT7Sr18lmOreTsDN4jbHOS.eA
 hFZW4vI8BjDKXS5duiX9C58eghMDH7w9brgmIstQb6i3vXwMCDx1mWdBe73T5O9b4m4zvgYEdj_b
 jRX35EJ4JpHBO5IMX279YljdJ1ihcQJwRvOkiQ07QcLKnrooIN8P.fXKm8xT0wkRMaxH8OrZs0RK
 n_dS3cb1eHcztY2xg6MTkHBDyinJwaIBCvFUtufquoOxtdr6qTa4iMfWgV3B9sQ8kqgOxBZuvsIk
 bum_W.mSNIurwVSwgANb0XA2SALU9aOJojqYyuPZGZbaiE7CJGdci8GVrghnv9fN_ZhPDtR7oqxL
 p09bGsxp1Qw7bYvAgLTFb9tCxVelA6TMSfUiGb50EVqASUuCtFWQ37lBA4Th8auLD1LXpKmhzIkD
 0W0gamQWvlX0_URxDk.pLt4j025tY.CBsQD6HiH540QnVcR6r5yQiT2eqR2nQ4WKWTMu5U4mKMUN
 O0Kec6Maj1aBMIv3SQWuHWtHJOxy1y2nwEmjJbYlNC6EPFGlFn9ov8XHyCjXPrHg5ZlThnpmtSR9
 AOuZ8Ow.YvZWG_pfuKRgKqMljGDIPk1NgQ9oj3PhNpYn84YPx3JdeK0LVZlzej0SxHhTns4YVV6X
 pH0ejD4yqdOvFMCs5TX.B0KgCxm7wZPsX9bwkbEicl7V1XYVY.SXzW5MsTgAUsZ.XAumg5GHrG.y
 TehNZ_TJnClE.p4Q_SJEkMA75GNQJATh38PlomTo.3hFT.5icYuI_BNXDcs3affkxMPHceV2CCsk
 l6seX69fu0Qvj9M4H4bkE8ynoDcE_8ImDPZ5pZTonHsxuVbrRfT83m5Rt4siqG2J9af8gvjEKzCI
 wmrDjzaAT3QvebJxzJIX0Fxl3Hs8xVuYedtMQgI5On1FNblhWjYgBxgEgpyEXpbLIqQ3dTID7.9t
 wRFjNTNR_aI_uVTQvbK61STvpb4BNdAbKqFxJAbGRDEcg8cFyI3I65P.t_mX_xUfvgNYmbOEylcq
 ZGTbGz05WO0TIEQ2XUS.jhEnSUSUlYjerHWk7LzBWTYXZFYDwNZrF21.hBZjXizN24ejVdtw_ez5
 jrpQziMTUuezzioaV6mkK_V_7fWW1yv0f9P_CinhsIUpWhEqL.FqC5eA8NPs4AXAQDg7viLs9c62
 Yzsb97Xi08MSmAgUVYQHaA264sS1aVASbSM1BadgdtfmwQ9ZTZAL6cxVTBw23t_1iIL.hBBzaLEa
 O_YWYy.nz7BTz1pSKqeiPkKcu1fzv6DexsKvV4T17LgGQdiu8x0lH5mzOJU7bh8LqG6ohBI7n7uF
 pEEpQj8T_VeIq5c6DxHj7bLXzJHJPuhQIkN8Fn0oB7HlqPus0A_WYSv7VWJm.D6HoRu86ZoARL_h
 feOaT8yZdZdQXr_Tby6CaDqnsJpbVFvcmhjP1NqooH3aXfA--
X-Sonic-MF: <brchuckz@netscape.net>
X-Sonic-ID: 40bad8fe-313d-4605-86de-681a2fcb2c82
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 25 Jul 2026 04:19:42 +0000
Received: by hermes--production-bf1-5f4bf6454b-bxwbj (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID b62fd084875c6d5e774985d82c647b03; 
 Sat, 25 Jul 2026 04:19:41 +0000 (UTC)
Message-ID: <dda25bc4-6d3c-4f36-94e0-ffdc8b9bc81d@netscape.net>
Date: Sat, 25 Jul 2026 00:19:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] xen/igd: get PCH info from host sysfs
To: Tomita Moeko <tomitamoeko@gmail.com>, Chuck Zmudzinski
 <brchuckz@aol.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20260709183517.25866-1-brchuckz@aol.com>
 <20260709183517.25866-2-brchuckz@aol.com>
 <5cb8d286-f013-4400-aef4-baddaa775995@gmail.com>
Content-Language: en-US
From: Chuck Zmudzinski <brchuckz@netscape.net>
In-Reply-To: <5cb8d286-f013-4400-aef4-baddaa775995@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26215
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.68.204; envelope-from=brchuckz@netscape.net;
 helo=sonic304-23.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/23/2026 9:09 AM, Tomita Moeko wrote:
>> ...
>> Also, use errp in xen_igd_passthrough_isa_bridge_create
>> to set errors from xen_pt_get_host_pch_info.
>> 
>> Signed-off-by: Chuck Zmudzinski <brchuckz@aol.com>
>> ---
>> Changes in v2:
>>   - call error_setg* after closing files instead of before closing
>>     files
>>   - in last line of commit message change "to propagate errors" to
>>     "to set errors"
>>   - add stable to Cc list
>> 
>> Changes in v3:
>>   - whitespace fix at line 380 of xen_pt_graphics.c
>>   - fix Cc address for qemu-stable
>> 
>>  hw/xen/xen_pt.c          |  2 +-
>>  hw/xen/xen_pt_graphics.c | 82 ++++++++++++++++++++++++++++++++++++++--
>>  include/hw/xen/xen_igd.h |  3 +-
>>  3 files changed, 82 insertions(+), 5 deletions(-)
>> 
>> diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
>> index 0fe9c0a..474606e 100644
>> --- a/hw/xen/xen_pt.c
>> +++ b/hw/xen/xen_pt.c
>> @@ -867,7 +867,7 @@ static void xen_pt_realize(PCIDevice *d, Error **errp)
>>          }
>>  
>>          /* Register ISA bridge for passthrough GFX. */
>> -        xen_igd_passthrough_isa_bridge_create(s, &s->real_device);
>> +        xen_igd_passthrough_isa_bridge_create(s, &s->real_device, errp);
> 
> The `errp` need to be handled here if any error occurs.

Do you mean calling it like this as a supported way to handle an error:

    xen_igd_passthrough_isa_bridge_create(s, &s->real_device, &error_fatal);

IIUC, that would cause Qemu to exit(1) here if there was any error.

I didn't do that because I thought if there was an error one of the
parents (pci or qdev) would handle the error appropriately since we
are passing 'errp' from xen_pt_realize which I think comes from pci
and qdev, but maybe not. I have not tested how an error is handled
with this version of the patch and I am certainly no expert in how
error handling should be done here, so thanks for alerting me to this
question.

I have also seen in the Qemu source the use of local_err and maybe
using &error_fatal is something like using a local_err instead of the
errp from xen_pt_realize.

I will accept any suggestions from more knowledgeable people about
how best to handle the errors here. I can also do some tests by
faking an error here and make sure the the error does get handled.
I do think if the LPC bridge creation fails it should be a fatal error
and if am reading the current code we have correctly, we currently
just print a message to stderr if bridge creation fails without doing
anything about that error. I also think maybe if for some reason we
can't get a revision number for the LPC bridge, maybe that should
not be a fatal error.

I will make sure the next version of the patch will not be posted until
I have verified the errors are handled appropriately.

Cheers,

Chuck

