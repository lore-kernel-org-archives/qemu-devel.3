Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE60CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOq3-0003ho-Ia; Wed, 07 Oct 2026 06:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOq0-0003go-Ib
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:25:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOpk-0006M8-2z
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:25:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jsms2312951
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VjhEdA9OzuCbz558+ILXGSYykxzlicBuYRhUlO5AT78=; b=O7eFjA0rWCMNXVJ5
 lPvxstwp2zTxDX5edaMPgtsrwTjY7aSKMo22a08qadZzA00HRP+jo5ETZ9VJ/6gp
 lO5upg6l5vKD5B/PgEhOu1D5B4AuiMPoYlYdWI0dTI1tqO/kczAtmwoHtIq8wYqa
 kS52svwgc6oM19nn4BRUjsyEh0cNAl+TD6VtlDhdiC/cjZXX7GEANxsO94mab31A
 BTECFqRLuWy2n5ceM7gn7XGI4HyXAgz/tju1qn672aQk0D6Wv56Mpej7elN47GtW
 aORA3LTNaO16UBRQOzFRmKhUv7uEeateIFAGiim5efbC37XWUNZ3movbLi3YgW2w
 eTxfCA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h53askxpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:25:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934956beec8so841626185a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368710; x=1791973510; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VjhEdA9OzuCbz558+ILXGSYykxzlicBuYRhUlO5AT78=;
 b=Qr1yHNLPonwxRdX1Y8eJpyUVTbmNNgQMNQR6fq7392NFzKYmjZO/moXLYaKtWrOMCT
 ptuNXRLqxHUNJCphsR1SCHuO7RcVbry1u4gM+e/Rrx8BwjLzT2SVLySDw5ERIjipP9eC
 qr86mHwRLN3HZMf01HFqzMj5JUCMn4Bubu7WZ2uFr0vVVrV5fBSy1LSRc8MaMVKoCX/c
 SugfpeJADo+tn4XkcO+JyUmYrHan14JcbDFLl5XoqId7K5xQzfpxjhnZQMHahNhfTF5k
 fT3+PBQB6w3o/7Y9SPTOVtkJaZU1mMlgTkwmMOKZWLi9H2DIdp4jDujvxK7H3ygK0WH0
 wQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368710; x=1791973510;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VjhEdA9OzuCbz558+ILXGSYykxzlicBuYRhUlO5AT78=;
 b=XgvisdYce521/ringYxHbpkSmCAL+SZQoADgPPEbTJv1vdLMAz37aIFMb45UeaYVQs
 iV4fi2CeB4Jxg6+1KtgIFMZQaRQO9jB5gpqI5hBoVGyPxLSjAUpPMfHS2AXpvLj7KTmq
 R4KGSaRW4DMeiila5v3in8eBkGbJMmqGRng1AO5vpkMp4IDSa9e3CCKgnbajnPxsaA8t
 3pjprBkljYujWK+BNIOHSIxuTO07V9Y12elxjIQxVAnYw8gPmawP7Tx2axEkv7GkQKHt
 E3NuAJYOQZ1spnM1RfppNL/n4ljLmH1eQpDyzvgxHzxMhj4cXZoBdsy+dy2B7EL+vEHa
 k12w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxPp4rIXYlFMjkCF0qFyj3KQ3ryeLfXuZhYUKxXQUN6qdQ8h2OjuBTN4y+nK6r15mIi3Chb2hBBRPWL@nongnu.org
X-Gm-Message-State: AFuF++ktrayMJbxd/duRrpa8IpgUyQCeK17LYSfaPKagwR+bEZeNyiRk
 8w9dA6L1XOujkvY0c+8iuRmPj/FS2ixDAu1/6MRNKxqtP08LzbQuaPcecvy0AKo9+oOzJ/wU/ZC
 +UpYri9eiUjlzBvlLka3e9kdkZQQS5fAmGstbT22YvMzMZMxvQLaGziBu0g==
X-Gm-Gg: AYBFou0iLPOlwvbC5bMZlwHOfL7qM1hkKR12V39PDvedQ2Mwr8dRrWuwvTqmnJtNB/b
 qLkeVlyH3f9c4IejO3RIIlVZtpuXAHFuAZoSyxrfFW+o9XGe471eisjCzuaNSTnETQ2Y3Umxko7
 iCPN7L96wyoShvtWelD81hyccqJQQyR7u3uKOGtnFOzdTUx8UdLCrbzG8qopPvexVGxEo0f+oGb
 nrBJneicSVkPHQ7Tu46ODzN/al4Ttf1xWS2rREicDamMkVbqGpUdKWDNeJ7rxf396avmeBztMI5
 /AyerwHu4L4l5a9rMzhc6vNvKmgNF/qZfS6pnTm8M1LuBUTGvj06X+v3qFDUvGD2Gufoxq5NGpl
 LUEzDMzqJlKTAbjGCDUM6kEBCYmpHYPksrg==
X-Received: by 2002:a05:620a:4090:b0:939:6dea:4f1b with SMTP id
 af79cd13be357-93e9b808128mr293504985a.49.1791368709649; 
 Wed, 07 Oct 2026 03:25:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4090:b0:939:6dea:4f1b with SMTP id
 af79cd13be357-93e9b808128mr293501385a.49.1791368709043; 
 Wed, 07 Oct 2026 03:25:09 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1f8fbsm4303513f8f.33.2026.10.07.03.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:25:08 -0700 (PDT)
Message-ID: <17cb7c7c-5f22-4a03-8855-4d1ec91d347a@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:25:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] target/riscv: Compile pmp.c once
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-14-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-14-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: k7zypyIBZMclVXZ-elDOCfBEGVQmfhpM
X-Proofpoint-GUID: k7zypyIBZMclVXZ-elDOCfBEGVQmfhpM
X-Authority-Analysis: v=2.4 cv=Xt5vqlF9 c=1 sm=1 tr=0 ts=6ac61e06 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_LGBUc0nY78mWi6BnIYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX4saDLypfci3K
 chQnPoejoQZMv/+ltrnTMScKN6XHcOphdlG4G8piSt8oM16JXo5pnn6PIhSojZR+cl5KJd5HEaG
 agaG/WKVYRksMKuo4A8sjapfUSl+ZK1X7Ob8zqH6GoApY3awryAlc9Jf5W8GsyQg9Ys5oRWI/PQ
 dPcDHI0O+I+1YcUqFwpBA9mdNRVmDeEtkxQqh0ZzbKFoqn8Mw7XIvPcZB5R9jCZbujIPi/LqB8H
 NfkQVNjNTWmmCr5GbZ5UUa0cbtATbD4kFK+oSnXbMj/pHTxgcqWiFaKexOCqVvgomYJdVWIiTpv
 xu/LN9UFkT6mq1sccRk8qzzEdZaqOQl4PGVmyBSmkGmmNsXCpN3aWh4I/vHWVytTUQue/MZnREo
 8BrSq7BHQoTDPrPtXniYQ623PAq+meubOoxb8buq+pgORaZDSN1LsLZ8dJCd4hsD2PUUO/+TaFZ
 74hSLoZMU8RzsO53nOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX69B69w50P/8i
 8l0RXyhJ5ipeCYzAgV5kdRDllbCZakwtaqOgd71YUHJ9FvGvY++Paz17G51kZXRWTiAH638foyf
 EFiIWnVIp/rIdNtJptEBUJd+wG6Kafg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070041
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 7/10/26 10:43, Anton Johansson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/tcg/pmp.c       | 5 +++--
>   target/riscv/tcg/meson.build | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
> index 99345d63dc..2d7194de10 100644
> --- a/target/riscv/tcg/pmp.c
> +++ b/target/riscv/tcg/pmp.c
> @@ -638,19 +638,20 @@ uint64_t pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index)
>       if (addr_index < pmp_regions) {
>           val = env->pmp_state.pmp[addr_index].addr_reg;
>           int g = pmp_get_granularity_g(env);
> +        const unsigned long_bits = target_long_bits();

We need to fetch this information from @env. Maybe riscv_cpu_mxl_bits()?
>           switch (pmp_get_a_field(env->pmp_state.pmp[addr_index].cfg_reg)) {
>           case PMP_AMATCH_OFF:
>               /* fallthrough */
>           case PMP_AMATCH_TOR:
>               /* Bit [g-1:0] read all zero */
> -            if (g >= 1 && g < TARGET_LONG_BITS) {
> +            if (g >= 1 && g < long_bits) {
>                   uint64_t granule = 1ULL << g;
>                   val = ROUND_DOWN(val, granule);
>               }
>               break;
>           case PMP_AMATCH_NAPOT:
>               /* Bit [g-2:0] read all one */
> -            if (g >= 2 && g < TARGET_LONG_BITS) {
> +            if (g >= 2 && g < long_bits) {
>                   val = deposit64(val, 0, g - 1, -1ULL);
>               }
>               break;


