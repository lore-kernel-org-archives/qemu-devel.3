Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7073FCDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMQ4-0006nL-MJ; Wed, 24 Jun 2026 08:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHZE-0001vi-O6
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:58:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1wcHZ8-0007BY-Dg
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 02:58:34 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260624065824epoutp01118d6393b4fbb71ed4cda38d9ecfd741~78iHU3Ccl2897028970epoutp01h
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:58:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260624065824epoutp01118d6393b4fbb71ed4cda38d9ecfd741~78iHU3Ccl2897028970epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1782284304;
 bh=tfDD0MGn6DMs16KSSyQCL3ui7b7mwTBCvxz0d3V8ftk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=KA6W42KYLM3By1LVKjvGpBUC1N6jOZ07TwfcUTpme2pGWgBP95OjB2ImX/gBLW9CB
 1tTIggjAypCsD/ghULy7q9R+4KuzvXDnarlyhcw6Msw2yprmVSOhHjuPQkk195hppr
 jvuIoKuHO6cmntiUMmjz6weQFs/ZNlKSa/cfOb5M=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
 20260624065823epcas5p2df61ac6f453bff4bb2c28dc1a4458855~78iGYz_5Y0668806688epcas5p2k;
 Wed, 24 Jun 2026 06:58:23 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.91]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4glXp65cdCz6B9m7; Wed, 24 Jun
 2026 06:58:22 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20260624065822epcas5p4f37ca53858c532de93dc64c0ede33327~78iFFSTnu0450004500epcas5p4Q;
 Wed, 24 Jun 2026 06:58:22 +0000 (GMT)
Received: from arun-B560M-DS3H-V2 (unknown [107.99.41.170]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20260624065819epsmtip23063846861ed704455fe354261ddc1d3~78iC1Wvgk0602506025epsmtip2G;
 Wed, 24 Jun 2026 06:58:19 +0000 (GMT)
Date: Wed, 24 Jun 2026 20:17:27 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, cpgs@samsung.com, arun.george@samsung.com,
 vikash.k5@samsung.com, s.neeraj@samsung.com, dongjoo.seo1@samsung.com,
 dave@stgolabs.net, gost.dev@samsung.com
Subject: Re: [RFC 5/8] hw/cxl: Wire UIO capability into HDM decoder registers
Message-ID: <20260624144727.xuqbo5dfy5ze5pku@arun-B560M-DS3H-V2>
MIME-Version: 1.0
In-Reply-To: <20260616184049.42cdc02d@jic23-huawei>
X-CMS-MailID: 20260624065822epcas5p4f37ca53858c532de93dc64c0ede33327
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_5369a_"
CMS-TYPE: 105P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609104525epcas5p151a4e745f5303e79a2a92432180a6af7
References: <20260609105836.3702787-1-shrihari.s@samsung.com>
 <CGME20260609104525epcas5p151a4e745f5303e79a2a92432180a6af7@epcas5p1.samsung.com>
 <20260609105836.3702787-6-shrihari.s@samsung.com>
 <20260616184049.42cdc02d@jic23-huawei>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=shrihari.s@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 24 Jun 2026 08:09:17 -0400
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

------I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_5369a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 16/06/26 06:40PM, Jonathan Cameron wrote:
>On Tue,  9 Jun 2026 16:28:33 +0530
>Shrihari E S <shrihari.s@samsung.com> wrote:
>
>> Plumb the 'uio_capable' flag to CXL HDM decoder capability and
>> control register interfaces. The UIO bit in the capability register
>> is now set for CXL Type3 devices and ports when UIO support is
>> advertised via 'x-uio-svc' property.
>>
>> Per CXL 4.0 specification Section 8.2.4.20.7, the decoder control
>> UIO bit is validated against the advertised capability during
>> HDM decoder commit operations.
>>
>> Additionally, replace hardcoded HDM decoder control write masks
>> with spec-aligned 'WRMASK' definitions.
>I think we should be modifying that depending on whether it is uio_capable
>rather than saying it is 'writeable' but 'not writetable' if not UIO capable.
>
>A few other comments inline.
>

Hi Jonathan,

   Got your point, will change that in the next version of the patch.

Thanks,

>>
>> Signed-off-by: Shrihari E S <shrihari.s@samsung.com>
>> Signed-off-by: Dongjoo Seo <dongjoo.seo1@samsung.com>
>> ---
>> +/* CXL 4.0 specification 8.4.2.20.7 */
>> +#define CXL_HDM_DECODER_CTRL_WRMASK (    \
>> +    (0xfu << 0)   | /* IG */             \
>> +    (0xfu << 4)   | /* IW */             \
>> +    BIT(8)        | /* LOCK_ON_COMMIT */ \
>> +    BIT(9)        | /* COMMIT */         \
>> +    BIT(12)       | /* TYPE */           \
>> +    BIT(13)       | /* BI */             \
>> +    BIT(14)       | /* UIO */            \
>> +    (0xfu << 16)  | /* UIG */            \
>> +    (0xfu << 20)  | /* UIW */            \
>> +    (0xfu << 24))   /* ISP */
>Given the FIELD() macro defines appropriate masks, can we build this as
>	R_CXL_HDM_DECODER_0_CTRL_IG_MASK |
>	R_CXL_HDM_DECODER_0_CTRL_IW_MASK |
>etc
>That will make it both self documenting and ensure it aligns with the field
>defines.  If we get a bug at least it will only be in one place :)
>

Sure, will add those Fields instead of hardcoding.

>> +
>>  /* CXL r3.1 Section 8.2.4.20.1 CXL HDM Decoder Capability Register */
>>  int cxl_decoder_count_enc(int count)
>>  {
>> @@ -305,7 +318,7 @@ static void ras_init_common(uint32_t *reg_state, uint32_t *write_msk)
>>  }
>>
>>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>> -                            enum reg_type type, bool bi)
>> +                            enum reg_type type, bool bi, bool uio)
>>  {
>>      int decoder_count = CXL_HDM_DECODER_COUNT;
>>      int hdm_inc = R_CXL_HDM_DECODER1_BASE_LO - R_CXL_HDM_DECODER0_BASE_LO;
>> @@ -325,9 +338,12 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>>          ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 3_6_12_WAY, 0);
>>          ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, 16_WAY, 0);
>>      }
>> -    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO, 0);
>> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, UIO,
>> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio);
>>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>> -                     UIO_DECODER_COUNT, 0);
>> +                     UIO_DECODER_COUNT,
>> +                     (type == CXL2_TYPE3_DEVICE || CXL2_UPSTREAM_PORT) && uio ?
>> +                     decoder_count : 0);
>>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, MEMDATA_NXM_CAP, 0);
>>      ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY,
>>                       SUPPORTED_COHERENCY_MODEL,
>> @@ -341,7 +357,8 @@ static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
>>          write_msk[R_CXL_HDM_DECODER0_BASE_HI + i * hdm_inc] = 0xffffffff;
>>          write_msk[R_CXL_HDM_DECODER0_SIZE_LO + i * hdm_inc] = 0xf0000000;
>>          write_msk[R_CXL_HDM_DECODER0_SIZE_HI + i * hdm_inc] = 0xffffffff;
>> -        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] = 0x13ff;
>> +        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] =
>> +                                             CXL_HDM_DECODER_CTRL_WRMASK;
>I think file at least mostly aligns these long line wraps as
>        write_msk[R_CXL_HDM_DECODER0_CTRL + i * hdm_inc] =
>            CXL_HDM_DECODER_CTRL_WRMASK;
>

Sure, will rectify it.

>Given i think this needs to be dependent on whether the device is uio_capable
>maybe just bring the mask defines suggested above down here, and modify the
>UIO bit to fit whether it should be writeable.
>
>

Yeah, got it. Will check the UIO capability first and apply the mask. Thanks for
pointing it out.

>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>> index b7ad437cbc..4cdadc3e10 100644
>> --- a/hw/mem/cxl_type3.c
>> +++ b/hw/mem/cxl_type3.c
>> @@ -590,6 +590,11 @@ static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
>>      /* TODO: Sanity checks that the decoder is possible */
>>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, ERR, 0);
>>      ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
>> +    if (ct3d->uio_capable) {
>> +        ct3d->uio_enabled = FIELD_EX32(ctrl, CXL_HDM_DECODER0_CTRL, UIO);
>> +    } else {
>> +        ctrl = FIELD_DP32(ctrl, CXL_HDM_DECODER0_CTRL, UIO, 0);
>
>If it's not supported, shouldn't the write mask stop it being written?  I think
>that would be cleaner than overriding any write to 0 here.
>
>

yes, understood. Will do that in the next version of the patch.


------I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_5369a_
Content-Type: text/plain; charset="utf-8"


------I1Ri8ePFE5syy3iOprV_xv8GO54F8jwSmmauBZ9e3BMCG3p4=_5369a_--

