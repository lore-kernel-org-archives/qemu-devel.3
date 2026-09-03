Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCDCC624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2EK1-0006mS-GD; Thu, 03 Sep 2026 16:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2EJz-0006m6-DJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:46:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2EJs-0001WJ-Qy
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:46:07 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683JhDBw1306076
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 20:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X3xKm61AK53HZBoa70C+OowGIwRjpapvGR6bd3gAquo=; b=eCjuAkbBQEeBlsV5
 loFhy4lO+gjsOWhmMtNS/pBJM1GX8HnffMeRbqSR9iG/C3AEbmp1ou6Qier8u2DX
 fxmImwuggnTk8qJK2NfSVDM+BpND+VcxRi8xTiN8jU9CdxIF2qa+9XkR143GDc+u
 MJcx/LdpKjebHiKWCsWLRfvRVrYiVGFh60MGF7A4w86I6RTwdADbYghpr+bcsi9R
 d2CW4B8DMG+qDFlTu2WN58/yZDvgWGuLxW5yX8VWGkV7iIWx/IwRXMGGmSmztp4+
 UQDFW+MAEiDO9y/Xnsvh23iNyaOGhxjFl+dMGSckMcCLY0gMuykZlJ6nuP1ufh9E
 4Pltbg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf82kahtj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 20:45:59 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-398d7e0f3b4so284354a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788468358; x=1789073158; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X3xKm61AK53HZBoa70C+OowGIwRjpapvGR6bd3gAquo=;
 b=kDLIRIrGIJMKxKp6tPSDvfbLLAlTTPE+FDpSbi6rRllsNYwbmW6e0MB7w96A9vgMkZ
 fkhdaBTG5Zd0HiD//MaHqbrsRmQlEkZBPyodVPtgdz2ePsgj0p5B6s9e0vXs+RxEugmF
 YT6Rq3G3PYCkpinWW9nW0YyJt0YheomutC2Op+ml+xTazuGFDix+JXbKAp11zgrz6vrn
 bWjQKMMbel1Imqe1YvKXZY1+u2Xde/kl4hLM99dIZcg6f9g6L4YlD+Vt8q+VnGYBTr4Q
 Yzdz07yp4qBIWwktxmzYzfy/dVU3AuBSbqrm4DMqXilGJsK/8h/ImbPm+s9rflV0wacD
 So+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788468358; x=1789073158;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X3xKm61AK53HZBoa70C+OowGIwRjpapvGR6bd3gAquo=;
 b=gRvA9ad8cJokAoq3ecEcFABBg/BCTu1XtC8Bl26/UAbazkxAl+sSIrZwO0U8YtTGh2
 QXnSEJHwX1lRHP5JBJFDB7dnMHE8+Gs8/byjx2a82qbOifoFeppW6tSmLlEGiH/Uddl6
 n5NduQ5j7M6lzNC+aT48ELMwFs+vuR/LdLzsfwwqto7F/RDLOxFuCVZdDkTyfx646FYx
 33+SIWTF1N/mtcX07FbD25dn41t5FVM86LF6ZqkZj4SPjXf599fHDrN224ymsVCdpTOP
 5CAFPYLo5ckV8JjfdWnk9LYrhap55wq9wo80GGjpwCQZHObSzCQRZxT7vECgv9f24jPV
 0SIw==
X-Forwarded-Encrypted: i=1;
 AKwUvByLIx7TxCHRHifDP9mQiq9AeVI1S2Z+oZw1+tUF/jdsM3lRw92jqYt1lk7THks/kw5d84e8NgqXnYnT@nongnu.org
X-Gm-Message-State: AFuF++lqRxk73Prj54I/6DlgzWlbrRMImuRST1EojHbgl8ZA5c8Bk6YZ
 XUA7CeC6NpSJGCOwMgRH7rSzFpHp9Aq/DQxSYmkY7XgTtqOzPU3HLTd4H1gWGJr6aYb5/y+WBAe
 6cCkiccBGXxuHjYQ8ij/wxGuvuGPb/A0GC/gPWjamINWzClXQaPhQM+HCfw==
X-Gm-Gg: AYBFou1RbcsnIXI7PwCGYYPgj5h7XpyN7OfcfPGCOha1YIMWfVBtdHy2z7qHwYIQEEp
 wYUtxtdQ61m/ZD1lo9ZD9P0My91ahUndMMueK7xqwoUOTO4qbMpj9ZciUWs9YPK7oBSbzI1qP9O
 SrQfmHa9Vvuc8vJw04nk7VomR+KwNUcFJKLG217Ly4U8Kj//bGa8/Kuf2cnq2yc2YBOmwb/8f8R
 SHDJ6cfIdutjqqpluBL1/WhJqw4PN0zM3aJ3+fLqTT6z12d8oA6dYyl+dOopqeukl3zNEEb+JLT
 Sra8OgrciJWsP9hP8yC/EdnUh5qrZzfbsac79+up1LmhE5lm6xcNbp20nXRhpOoEx8S4lQfp61D
 GKwYTZun/svEGDi3FRQ6DLsLDpqrpB+MN74JCKBCh0VSV1tcjt8DWb0QunZoM2ekjpOjQ
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39b262e28c2mr1735179a91.25.1788468357835; 
 Thu, 03 Sep 2026 13:45:57 -0700 (PDT)
X-Received: by 2002:a17:90b:2c88:b0:398:ba56:b926 with SMTP id
 98e67ed59e1d1-39b262e28c2mr1735069a91.25.1788468356903; 
 Thu, 03 Sep 2026 13:45:56 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa36b37sm1305141eec.14.2026.09.03.13.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 13:45:56 -0700 (PDT)
Message-ID: <efd26440-893c-4fe0-9ef6-039826c184aa@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 13:45:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] tests/tcg/hexagon: add vgather/vscatter
 region-length tests
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com
References: <20260820215117.1788954-1-brian.cain@oss.qualcomm.com>
 <20260820215117.1788954-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260820215117.1788954-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LKR-TdIwKM3I7LnXq3l-8nE8mqJ8s6qB
X-Proofpoint-ORIG-GUID: LKR-TdIwKM3I7LnXq3l-8nE8mqJ8s6qB
X-Authority-Analysis: v=2.4 cv=OuJ/DS/t c=1 sm=1 tr=0 ts=6a99dc87 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=8C46N-NFlvTOp0xBK9EA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE4MSBTYWx0ZWRfX/lJO6mFT+OIu
 y4eokrabQhhy/wW5wFOhxvYLYIdWuqX4WviiNFGbD5OUTyIFC/G4WpGy20AjWQs9n+1F20vjft/
 dwRPuhz/ZADOJPZkw+0g7SlqxDnfRXHDl7d3tEHuSe4LO/ETL7n/h8+aiGBO8whM8PVHB7oWOWh
 rLynCVpakFOJnGr8gVbyV2bM6QNCWy7mGdUz8GMCQ9f3JW9R/ls/++sSF3mFd5NEkmOd9JPD9j0
 llc3l0hAdNzFUQFipl88iUEXZD3s4IxDHId2yeyQnIzikgTcR+TK95EZKStJ3M+DkIMCsI1E6vd
 s24bxpLlrbvk4M0sAFDXLAfG2sugKrO07eGg9gUrsnN1N5jFnlgVEckoW6v3lo2Ibg28/zEbQzx
 WGLdx5vY8mkBvpedvDRU6AjK9Ah69NyyaJDhlD453fvg7c8jGBiWo+VBZ4lyijDNPmx/D1KxtoN
 /LaAqM3hxIrBtmA6PHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE4MSBTYWx0ZWRfXw+ipSjQFH02U
 0Qb5gS35uWNPYZ+8vbr08vXWM090NsIpX7ad4TJc+Mrth+9g3yyL4Ru/gzuDaikee0cs30WSqoZ
 gxewoW0F7RpZWM8jnq4f1sp0w+3JHIg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/20/2026 2:51 PM, Brian Cain wrote:
> Cover the case where an offset lies beyond the region length: it
> must be dropped rather than read/written.
> 
> Place one dropped gather offset on a PROT_NONE page to verify that
> the instruction does not access memory for that lane.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/scatter_gather.c | 138 ++++++++++++++++++++++++++++-
>  1 file changed, 137 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/hexagon/scatter_gather.c b/tests/tcg/hexagon/scatter_gather.c
> index bf8b5e03172..9b38b537af0 100644
> --- a/tests/tcg/hexagon/scatter_gather.c
> +++ b/tests/tcg/hexagon/scatter_gather.c
> @@ -31,7 +31,11 @@
>  #include <stdio.h>
>  #include <string.h>
>  #include <stdlib.h>
> +#include <assert.h>
>  #include <inttypes.h>
> +#include <sys/mman.h>
> +#include <hexagon_types.h>
> +#include <hvx_hexagon_protos.h>
>  
>  typedef long HVX_Vector       __attribute__((__vector_size__(128)))
>                                __attribute__((aligned(128)));
> @@ -85,6 +89,24 @@ unsigned int   word_predicates[MATRIX_SIZE] __attribute__((aligned(128)));
>  /* make this big enough for all the operations */
>  const size_t region_len = sizeof(vtcm);
>  
> +/* Mu (region length - 1); offset is kept iff offset <= Mu */
> +#define GATHER_LEN_TEST_MU 127
> +#define GATHER_LEN_TEST_PAGE_SIZE 4096
> +static unsigned char *gather_len_test_src;
> +static unsigned char gather_len_test_dst[128] __attribute__((aligned(128)));
> +static unsigned char gather_len_test_dst_ref[128];
> +static unsigned short gather_len_test_offsets[MATRIX_SIZE]
> +    __attribute__((aligned(128)));
> +
> +/* offsets are unique so a dropped write can't be masked by another lane */
> +#define SCATTER_LEN_TEST_MU 127
> +static unsigned short scatter_len_test_dst[128] __attribute__((aligned(128)));
> +static unsigned short scatter_len_test_dst_ref[128];
> +static unsigned short scatter_len_test_offsets[MATRIX_SIZE]
> +    __attribute__((aligned(128)));
> +static unsigned short scatter_len_test_values[MATRIX_SIZE]
> +    __attribute__((aligned(128)));
> +
>  /* optionally add sync instructions */
>  #define SYNC_VECTOR 1
>  
> @@ -96,7 +118,7 @@ static void sync_scatter(void *addr)
>       * synchronization.  Normally the dummy load would be deferred as
>       * long as possible to minimize stalls.
>       */
> -    asm volatile("vmem(%0 + #0):scatter_release\n" : : "r"(addr));
> +    asm volatile("vmem(%[addr] + #0):scatter_release\n" : : [addr] "r"(addr));
>      /* use volatile to force the load */
>      volatile HVX_Vector vDummy = *(HVX_Vector *)addr; vDummy = vDummy;
>  #endif
> @@ -855,6 +877,112 @@ void check_gather_16_32_masked(void)
>                   MATRIX_SIZE * sizeof(unsigned short));
>  }
>  
> +/* vgather must drop elements whose offset is beyond the region */
> +void create_gather_region_len_test(void)
> +{
> +    unsigned char *mapping;
> +
> +    mapping = mmap(NULL, 2 * GATHER_LEN_TEST_PAGE_SIZE,
> +                   PROT_READ | PROT_WRITE,
> +                   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +    assert(mapping != MAP_FAILED);
> +    assert(mprotect(mapping + GATHER_LEN_TEST_PAGE_SIZE,
> +                    GATHER_LEN_TEST_PAGE_SIZE, PROT_NONE) == 0);
> +    gather_len_test_src = mapping + GATHER_LEN_TEST_PAGE_SIZE - 256;
> +
> +    for (int i = 0; i < 256; i++) {
> +        gather_len_test_src[i] = (unsigned char)(13 + 7 * i);
> +    }
> +    memset(gather_len_test_offsets, 0, sizeof(gather_len_test_offsets));
> +    gather_len_test_offsets[0] = 0;
> +    gather_len_test_offsets[1] = GATHER_LEN_TEST_MU - 1;
> +    gather_len_test_offsets[2] = GATHER_LEN_TEST_MU;
> +    gather_len_test_offsets[3] = GATHER_LEN_TEST_MU + 1;
> +    gather_len_test_offsets[4] = 256;
> +    memset(gather_len_test_dst, FILL_CHAR, sizeof(gather_len_test_dst));
> +}
> +
> +/* gather with a region shorter than the source buffer, using HVX */
> +void vector_gather_region_len(void)
> +{
> +    HVX_Vector voff = *(HVX_Vector *)gather_len_test_offsets;
> +
> +    Q6_vgather_ARMVh((HVX_Vector *)gather_len_test_dst,
> +                      (int)(uintptr_t)gather_len_test_src,
> +                      GATHER_LEN_TEST_MU, voff);
> +
> +    sync_gather(gather_len_test_dst);
> +}
> +
> +/* gather with a region shorter than the source buffer, using C */
> +void scalar_gather_region_len(unsigned char *dst)
> +{
> +    for (int i = 0; i < MATRIX_SIZE; i++) {
> +        unsigned short off = gather_len_test_offsets[i];
> +        if (off <= GATHER_LEN_TEST_MU) {
> +            dst[2 * i] = gather_len_test_src[off];
> +            dst[2 * i + 1] = gather_len_test_src[off + 1];
> +        }
> +    }
> +}
> +
> +void check_gather_region_len(void)
> +{
> +    memset(gather_len_test_dst_ref, FILL_CHAR,
> +           sizeof(gather_len_test_dst_ref));
> +    scalar_gather_region_len(gather_len_test_dst_ref);
> +    check_buffer(__func__, gather_len_test_dst, gather_len_test_dst_ref,
> +                 sizeof(gather_len_test_dst_ref));
> +}
> +
> +/* vscatter must drop elements whose offset is beyond the region */
> +void create_scatter_region_len_test(void)
> +{
> +    memset(scatter_len_test_offsets, 0, sizeof(scatter_len_test_offsets));
> +    scatter_len_test_offsets[0] = 0;
> +    scatter_len_test_offsets[1] = SCATTER_LEN_TEST_MU - 3;
> +    scatter_len_test_offsets[2] = SCATTER_LEN_TEST_MU - 1;
> +    scatter_len_test_offsets[3] = SCATTER_LEN_TEST_MU + 1;
> +    scatter_len_test_offsets[4] = SCATTER_LEN_TEST_MU + 73;
> +

After discussion, there is no specific reason to use different offsets
than GATHER ones (testing before, on and after frontier). It would be
nice to unify both.

> +    for (int i = 0; i < MATRIX_SIZE; i++) {
> +        scatter_len_test_values[i] = 0x4100 + i;
> +    }
> +    memset(scatter_len_test_dst, FILL_CHAR, sizeof(scatter_len_test_dst));
> +}
> +
> +/* scatter with a region shorter than the destination buffer, using HVX */
> +void vector_scatter_region_len(void)
> +{
> +    HVX_Vector voff = *(HVX_Vector *)scatter_len_test_offsets;
> +    HVX_Vector vval = *(HVX_Vector *)scatter_len_test_values;
> +
> +    Q6_vscatter_RMVhV((int)(uintptr_t)scatter_len_test_dst,
> +                       SCATTER_LEN_TEST_MU, voff, vval);
> +
> +    sync_scatter(scatter_len_test_dst);
> +}
> +
> +/* scatter with a region shorter than the destination buffer, using C */
> +void scalar_scatter_region_len(unsigned short *dst)
> +{
> +    for (int i = 0; i < MATRIX_SIZE; i++) {
> +        unsigned short off = scatter_len_test_offsets[i];
> +        if (off <= SCATTER_LEN_TEST_MU) {
> +            dst[off / 2] = scatter_len_test_values[i];
> +        }
> +    }
> +}
> +
> +void check_scatter_region_len(void)
> +{
> +    memset(scatter_len_test_dst_ref, FILL_CHAR,
> +           sizeof(scatter_len_test_dst_ref));
> +    scalar_scatter_region_len(scatter_len_test_dst_ref);
> +    check_buffer(__func__, scatter_len_test_dst, scatter_len_test_dst_ref,
> +                 sizeof(scatter_len_test_dst_ref));
> +}
> +
>  /* print scatter16 buffer */
>  void print_scatter16_buffer(void)
>  {
> @@ -1035,6 +1163,14 @@ int main()
>      print_scatter16_32_buffer();
>      check_scatter_16_32_masked();
>  
> +    create_gather_region_len_test();
> +    vector_gather_region_len();
> +    check_gather_region_len();
> +
> +    create_scatter_region_len_test();
> +    vector_scatter_region_len();
> +    check_scatter_region_len();
> +
>      puts(err ? "FAIL" : "PASS");
>      return err;
>  }


