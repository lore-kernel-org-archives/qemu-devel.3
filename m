Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16059CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 02:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEdua-0008Ip-IB; Wed, 07 Oct 2026 22:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xEduG-0008Hn-Kq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:30:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xEduE-0000Ij-EE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 22:30:52 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6981hb8E2452531
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 02:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dkPt4b9RC9E93J7DjrdNx/7Q8tjA4QC9e1gV6qNF9Cs=; b=KN0S3zqNJVjo5m6N
 rVZF0AFAo2ccTwDH3Dgn5au6EABCmnGb9wqXPHdNZoLvZf4tg9HT9BjFY+pqx0qh
 PA+kHpkuL77GdHJ9inj0yFQp2ZuEaXrWqo6LqofdDzqOLmUxPeltj4MYdPsCfOkN
 iQYBGsskm2TYG1MzU56pa1ov/o9Lm+JNSTBaWPelgej7vLbz46pinzblk2ekxcpJ
 2EEJociBNfXijEelfPteOPbW0wwYW9twYZaZtP0kOqHzGr4DUjChtjBUcSP7ziYF
 ULpoFaEIS9q+NXUzkaTeqTUKlXpldjsMMPx0V24bql4wDgRhO4Pv4mUgs4GCBe1q
 Zp7+YQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe68qmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:30:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cc0b31ecaso1022305585a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 19:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791426645; x=1792031445; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dkPt4b9RC9E93J7DjrdNx/7Q8tjA4QC9e1gV6qNF9Cs=;
 b=VR31NBc8+EYxfe2g/HRUdYEr8Dly0OOP4dHQStxAjDykfcTDjJoSC8mZXBLylv7VUf
 tgzCQp19b/ktNvt0/OSgAxcTwpqucAndxs9WT/GpbiUkn9EvPEjTQobw7tsg8UKqEWm6
 IGut7tFYtT/WKRkMd4aN+5Tje+hEwl0Js+zf+40qU2Jgic+J2NQw6GqP/2GdJQw437J3
 suPA+dhTDroN5zZfXq7eiPRnsgespn6bkIO7t5UYBYP7b//vQ58M4oi+AWSGaG0JVkQs
 wH67IHXX9eXNidZ3i+oDIoblbbhPeeCXXGK8fAx9B3maKbjecUTkEesYJu1cIZttRB1n
 HljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791426645; x=1792031445;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dkPt4b9RC9E93J7DjrdNx/7Q8tjA4QC9e1gV6qNF9Cs=;
 b=nkKZJ7EorPbXJ8J3vjYO5zMLT9Gg8Ulen/o6o+URvGrA5ubKVCVHMp9uzvledHtXyt
 WkvNEq+UBP6KU94jOYwTLZCEDkEG4nZjlNdqXZylh2cRxSiU6oF2OMdP9HwK/JEgfhfH
 Mkc2eOEcgC2yqb5NBpScwpxkbYKems+SQq0m+YU/VjJFa/AKcc7TXRMzl7s0ws+7smhn
 NkQHoXIYfYD5DrZhvubO8mqCnBMPdXS1Ws1s+6bDvy3V5YGdGnpwh9/OQa/jcnyJUYzi
 XAGNrly+7W+LmMQT+e+r9ePK0LKfX14sDEQh65rQguz7l1sd2H26p6UUctclb40xnRYi
 VzAQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBykhfMnZKKaOXY+G4fVY1lIOexB/8n7AnSmZFsm8dPrEfMuy/2Wl7qRgiAjgMOBJKa9MoTpIUmLYVhA@nongnu.org
X-Gm-Message-State: AFuF++kFmbODyCIGCmoKbzr0P3ODue4nDdl243agUeqBlp1V/zlWgOuw
 Xf3PFWRRPB8Gpm6u00jLf2vwQ3bIWkk44DQYvDw+sjEprqNvN3Vw3TMKhHSI1zj4KVXnHT6fEnT
 Su4c+vyslQUsndCAScQXY0rpuTWOpv5YxdEkseyUILadcm0eBg9WkEPo2sg==
X-Gm-Gg: AYBFou0YnJmzmXdS6zlLU5bGfTpVze+hof6XlUsxHAFMazgaQTciULpCTsVDikDa2SW
 tNbxIGGjPyuySsFK15o3r9FF8O3ki6aJ93L9V2YhKE9TBriZDFz8EMjXYo+FzqwvoBgvW8lWZux
 zOKlf3i/fsZXTAmhjA81vsvrEmZ0Xwu8dOoVOgrV0lQ5RZD45wRxXwkt5FHY9nHEiE691edJDUZ
 nggMiuMzw91hoKEob2PHu9aafAMPxB1LBhacm2D9l5pXODwBMFfvfKDbKM1kAp1Jt8MB1Ic7eF1
 CUv0VJKN87+f5s8DWDSplFa1zCN5iBfZ4J/AF+aNd2El2Fa4X7oA0GCWMS7TMsaal+LohGQd/y1
 sFFQUHnEZT4v/gv9tGcTk+BwCpmhtPvwBLAxX
X-Received: by 2002:a05:620a:27c1:b0:93a:14c:32ad with SMTP id
 af79cd13be357-93e9af3458dmr854002985a.0.1791426645387; 
 Wed, 07 Oct 2026 19:30:45 -0700 (PDT)
X-Received: by 2002:a05:620a:27c1:b0:93a:14c:32ad with SMTP id
 af79cd13be357-93e9af3458dmr854000085a.0.1791426644925; 
 Wed, 07 Oct 2026 19:30:44 -0700 (PDT)
Received: from [192.168.10.208] ([185.243.168.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93e991eca24sm360692885a.39.2026.10.07.19.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 19:30:44 -0700 (PDT)
Message-ID: <9d481666-8d8e-43ae-b1c3-d5a9141d783f@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 23:30:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/11] target/riscv: Add smmpt-sdidlen property for the
 mmpt SDID field
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, qemu-riscv@nongnu.org, rahul@summations.net,
 xiangyi.zeng@linux.alibaba.com, cxx194832@alibaba-inc.com
References: <20260723200325.24969-1-zhiwei_liu@linux.alibaba.com>
 <20260723200325.24969-3-zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260723200325.24969-3-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MOg5o7NPxlYHC9CS65zRkPFcMJDLYl7s
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac70056 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=Adc43iEMMYzOb2FTIT2GVQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=SRrdq9N9AAAA:8 a=g7JV1MsSeyImncLccn4A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: MOg5o7NPxlYHC9CS65zRkPFcMJDLYl7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwOSBTYWx0ZWRfX7UINJQOaMRtZ
 a/lAgsq8jcTpHrYRoFn8ftmzmAwY5fNAXx9lCFVcttD4HVKp8UUAYDMAhLaa4qDwNh1t580ohPd
 I99XWqj3Rd1bCyqMtlLungAZ7VahWO/KfVMVER4W3hmmbEwXxwk1WPUshsjW8LSz8Fn3Ftnl7TL
 15J8+8uQbmgshetUiWtNAXwCLch3Ic1V9JcZj+pEkNP5RXMMNPjv61eYWEW8yWu5iFmUUz8lqCn
 LOtJugLRkdvW5NH8ijOJh75Vz8431mwi6Wi2FVPBtGlavVLz58/9crz3EDgJ4taFbaBnbyCEwmm
 aiGfyUq8Eer56R53e4yNAl3wQfSz/hgOtG2sbwxS9TEKeu8Ytlypqbq11YHiooQn6x3F7NeedzO
 FWWO6IWmhYZfXutENX+DsHOyeLhGV7kW5t1BBU+30EnBwyt8mosmBGDKx06Ir8cBqKnfdi/VuNE
 44v8wxh2ULTTT+yUMVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwOSBTYWx0ZWRfXxJTXM4t80cqU
 8i0U9czjntLy1YiPCZn5ZtXQ3bqkaBlpv8MYLRvcGZ0RAz1PWorzL8oDxmDmuzN02qqD0wsyYFc
 hNJnDk3xuE4rw8UjYIsTYiyo3d8mlcY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_01,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080009
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Zhiwei,

On 7/23/2026 5:03 PM, LIU Zhiwei wrote:
> The number of implemented SDID bits is UNSPECIFIED and may be zero. The
> number of implemented SDID bits, termed SDIDLEN, may be determined by
> writing one to every bit position in the SDID field, then reading back
> the value in mmpt to see which bit positions in the SDID field hold a
> one. The least-significant bits of SDID are implemented first: that is,
> if SDIDLEN > 0, SDID[SDIDLEN-1:0] is writable. The maximal value of
> SDIDLEN, termed SDIDMAX, is 6.
> 
> Model this by adding a configurable "smmpt-sdidlen" CPU property. The value
> defaults to SDIDMAX (6) to preserve the current behaviour. The mmpt write
> handler now keeps only the low SDIDLEN bits of the SDID field, making the
> SDIDLEN discovery sequence work as specified.
> 
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/cpu.c                | 45 +++++++++++++++++++++++++++++++
>   target/riscv/cpu_bits.h           |  3 +++
>   target/riscv/cpu_cfg_fields.h.inc |  1 +
>   target/riscv/tcg/csr.c            | 11 ++++++--
>   4 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5a82e6563b..0f96e487fa 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1434,6 +1434,7 @@ static void riscv_cpu_init(Object *obj)
>       cpu->cfg.pmu_mask = MAKE_64BIT_MASK(3, 16);
>       cpu->cfg.vlenb = 128 >> 3;
>       cpu->cfg.elen = 64;
> +    cpu->cfg.sdidlen = MMPT_SDIDLEN_MAX;
>       cpu->cfg.cbom_blocksize = 64;
>       cpu->cfg.cbop_blocksize = 64;
>       cpu->cfg.cboz_blocksize = 64;
> @@ -1939,6 +1940,48 @@ static const PropertyInfo prop_vlen = {
>       .set = prop_vlen_set,
>   };
>   
> +static void prop_sdidlen_set(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    RISCVCPU *cpu = RISCV_CPU(obj);
> +    uint8_t value;
> +
> +    if (!visit_type_uint8(v, name, &value, errp)) {
> +        return;
> +    }
> +
> +    if (value > MMPT_SDIDLEN_MAX) {
> +        error_setg(errp, "smmpt-sdidlen must be between 0 and %d",
> +                   MMPT_SDIDLEN_MAX);
> +        return;
> +    }
> +
> +    if (value != cpu->cfg.sdidlen && riscv_cpu_is_vendor(obj)) {
> +        cpu_set_prop_err(cpu, name, errp);
> +        error_append_hint(errp, "Current '%s' val: %u\n",
> +                          name, cpu->cfg.sdidlen);
> +        return;
> +    }

This is something I'll eventually get to but I think we're being too protective
with vendor CPUs.  If users wants to use a vendor CPU and then change stuff that
would either misconfigure or mischaracterize it, we should just let them.  It's
a conscious decision in the command line to change the configuration of user
CPUs, i.e. users that do that are liable to any consequences too.


All this to say that we should get rid of this particular check.  Everything
else LGTM.


Thanks,
Daniel

> +
> +    cpu_option_add_user_setting(cpu, name);
> +    cpu->cfg.sdidlen = value;
> +}
> +
> +static void prop_sdidlen_get(Object *obj, Visitor *v, const char *name,
> +                             void *opaque, Error **errp)
> +{
> +    uint8_t value = RISCV_CPU(obj)->cfg.sdidlen;
> +
> +    visit_type_uint8(v, name, &value, errp);
> +}
> +
> +static const PropertyInfo prop_sdidlen = {
> +    .type = "uint8",
> +    .description = "smmpt-sdidlen",
> +    .get = prop_sdidlen_get,
> +    .set = prop_sdidlen_set,
> +};
> +
>   static void prop_elen_set(Object *obj, Visitor *v, const char *name,
>                            void *opaque, Error **errp)
>   {
> @@ -2853,6 +2896,8 @@ static const Property riscv_cpu_properties[] = {
>       {.name = "vlen", .info = &prop_vlen},
>       {.name = "elen", .info = &prop_elen},
>   
> +    {.name = "smmpt-sdidlen", .info = &prop_sdidlen},
> +
>       {.name = "cbom_blocksize", .info = &prop_cbom_blksize},
>       {.name = "cbop_blocksize", .info = &prop_cbop_blksize},
>       {.name = "cboz_blocksize", .info = &prop_cboz_blksize},
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 4ed4843e3d..642edf3369 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -1171,6 +1171,9 @@ typedef enum CTRType {
>   #define CSR_MMPT        0x382
>   #define CSR_MSDCFG      0x74E
>   
> +/* Maximal number of implemented SDID bits (SDIDMAX) */
> +#define MMPT_SDIDLEN_MAX    6
> +
>   /*
>    * MMPT register layout for MXLEN=32:
>    * MODE[31:30], 0[29:28], SDID[27:22], PPN[21:0]
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 6b616388be..4a8c9b9e21 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -174,6 +174,7 @@ TYPED_FIELD(uint64_t, mimpid, 0)
>   TYPED_FIELD(uint32_t, pmu_mask, 0)
>   TYPED_FIELD(uint16_t, vlenb, 0)
>   TYPED_FIELD(uint16_t, elen, 0)
> +TYPED_FIELD(uint8_t,  sdidlen, 0)
>   TYPED_FIELD(uint16_t, cbom_blocksize, 0)
>   TYPED_FIELD(uint16_t, cbop_blocksize, 0)
>   TYPED_FIELD(uint16_t, cboz_blocksize, 0)
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 8ffe85caa9..8d38d7a972 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -5608,6 +5608,11 @@ static RISCVException write_mmpt(CPURISCVState *env, int csrno,
>                                    target_ulong val, uintptr_t ra)
>   {
>       uint32_t mode_value = 0;
> +    /*
> +     * Only the least-significant SDIDLEN bits of the SDID field are
> +     * writable; the remaining bits are WARL and read as zero.
> +     */
> +    uint64_t sdid_mask = MAKE_64BIT_MASK(0, riscv_cpu_cfg(env)->sdidlen);
>       if (!riscv_cpu_cfg(env)->ext_smmpt) {
>           goto set_remaining_fields_zero;
>       }
> @@ -5621,7 +5626,8 @@ static RISCVException write_mmpt(CPURISCVState *env, int csrno,
>               /* Only write the legal value */
>               env->mptmode = mode_value;
>           }
> -        env->sdid = (val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32;
> +        env->sdid = ((val & MMPT_SDID_MASK_32) >> MMPT_SDID_SHIFT_32)
> +                    & sdid_mask;
>           env->mptppn = val & MMPT_PPN_MASK_32;
>       } else if (riscv_cpu_xlen(env) == 64) {
>           mode_value = (val & MMPT_MODE_MASK_64) >> MMPT_MODE_SHIFT_64;
> @@ -5632,7 +5638,8 @@ static RISCVException write_mmpt(CPURISCVState *env, int csrno,
>               mode_value += SMMPT43 - SMMPT34;
>               env->mptmode = mode_value;
>           }
> -        env->sdid = (val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64;
> +        env->sdid = (((uint64_t)val & MMPT_SDID_MASK_64) >> MMPT_SDID_SHIFT_64)
> +                    & sdid_mask;
>           env->mptppn = val & MMPT_PPN_MASK_64;
>           /* Smmpt64: root table PPN bits 2:0 must be zero (32KiB alignment) */
>           if (env->mptmode == SMMPT64) {


