Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF16CC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7qB-00024h-Kx; Mon, 28 Sep 2026 05:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7qA-000248-OV
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:40:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7q9-0006wP-7o
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:40:06 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MKcr1446723
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 egEpYpJ3422O0zgRIN6fjZmeBQVf87C2JmKPRSnlRb8=; b=A8WopTznFfXV3Id3
 VVM9pp6dyhJNJpHGTFdZ/bm1YDbmqAE7yHFOg0xrEoWS95/Kd2j6CWckHe8KIl29
 AgRlgOySdzk9yl4SBkBfz5W9qyC1Dg2k6saeQdV4lcJtylUPkkOX0ol5a2F+xt9Q
 3WrTk/likd1kvV76G6NQL0DrmSYcvfIewMw7ddbgiltv6db/THP0hX4ZcnsDw2iJ
 Y+s/7W8sZ7L6zOVj03nJSAsg2eNfneBy9gxY7T/4FOoaAraZnlwxYyK71oqAQPNV
 eM12B2PlWSjgL8Vdd7yXELXIpXoY6d4eoyr3np0egw0R47OKDqb+zHm45e2sxdFb
 MPdRAw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gynfkr2jc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:40:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939f3426a7cso667512685a.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588403; x=1791193203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=egEpYpJ3422O0zgRIN6fjZmeBQVf87C2JmKPRSnlRb8=;
 b=Q0ps3mOQ6ZbNr1hGNMFLKDV7wzNo3Rdj8iOL2ZhIvYQkfw7c4/cbhi3gJJUyvZOmJQ
 WZoiOlK6H7riFaZmEBGxBd6oaokR3sDvGj5he7ZjEGUHl9HKiipNt6Vqz+kbZfxNSDjG
 W5kTIQTlJpCgmbLktOYcHnSfl+fMd6uMTjRBL57n4tCOr7NVUmK/PGJ/5ftf7AlNO8wS
 H5N2Dv1NNF/EIJw3xXyACIP2gLy3GmqwZnjmg6EUUoHB5ceIFfyKx0x3CUEK7TzvSYNk
 2u1ufnl4DdNxNRaDXu/Qu98zsu069hQlRuIbMa7rHNUHLfqeP00pUzcy25M2oXR9EQul
 X2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588403; x=1791193203;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=egEpYpJ3422O0zgRIN6fjZmeBQVf87C2JmKPRSnlRb8=;
 b=QZ58Eh7fBPhTV/GcbaCZGLOk+QxocUxZB5pqiEL0iXdvdO8z2Nge1gPhP4Umu0zzS2
 zpyL+kqfDXgti4qD23BqaYLOOT/0T0DQJzO5E1SKwYjdDsMqWvBTov0aOb3y0J7fUcx/
 CanKTb/hISjVZFjr/ZLWb2iGJz227G1+uFYZygUcTj+zi4hedz59VDaMre80uhCS42AF
 4deJHBu6/Epx/EzQuHI39zNCQMLHL4oqkWX+soVW6p0IKGSBcop3Wg8qZyUyvxgGaRtO
 7+NSSjvG+V5SawPugnbi6GbVF0o/X85OuK4SmQpD1DRNLlmfsRIBiEkVeCEF0x0lcnwr
 Ez4w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC7cLeXzgBvWYoL66oWxi7tTt8jg3wh8k1Ve80X+KYeVgpUaUNY58tluHGnO40EmPn95pnGCft4HBr@nongnu.org
X-Gm-Message-State: AFuF++kjrPl21lYeqNX0dkH1N3i5Gz6+5cd2WFLEpBEQ4O8GqcnmTWZk
 Dz5CrA/Es+s0N2B/shndw4OP4UBlJsAiJnfX1OxywS5cSpCamhFcpiA4p1ZEyLfveEyXvRGVDaq
 ZOmi6suYLt1ITb+BZHCfG0BrMypGgTNhaV2Jsw5jf/rDFdq0drE00iS5NGdYzj++egQ==
X-Gm-Gg: AYBFou3Tamn3Ea7s7EkMJpU9LQjljWqui9RLnOSRK3ITBppw+rjUSqMCRbvDEsStUf1
 qUTrLIqyTYZXBtedqN3KkKceXpa44sBsryoFRyzMz+t+nfwUbya/ZR450sKIIHqIKlLGIf6NgG4
 +A3mi9fbIpR9NtzH+EEtXMQyW9b8rdYKsbzOJ/eUvKtWTJIrHTnzTJ0oja81nxQiF69kdenlk7q
 5RDrqEj2yrSj8l5kkQ7EtCrH6ZwAfJq2h/mWPuECFdEJ8xa2pFgY8I/RJ/owHov4/rYa+YkGA4k
 /l4PCMdyKhXu0lk/6roPeA7znokAibpLZMKqhjQOtbWyu4ufhK9fHcckjfqo7jfQtL/pjXISjcs
 yEkYM0KTFW2Aor1b8TVvlT8XNCUcOrXFxIg==
X-Received: by 2002:a05:620a:7010:b0:939:f522:b2f7 with SMTP id
 af79cd13be357-93c43cd31b9mr1954986985a.33.1790588403185; 
 Mon, 28 Sep 2026 02:40:03 -0700 (PDT)
X-Received: by 2002:a05:620a:7010:b0:939:f522:b2f7 with SMTP id
 af79cd13be357-93c43cd31b9mr1954984485a.33.1790588402675; 
 Mon, 28 Sep 2026 02:40:02 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00178174dsm119607685e9.10.2026.09.28.02.40.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:40:01 -0700 (PDT)
Message-ID: <8b6ed8c5-cf02-4db4-afc0-689b6ddfbd82@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] target/arm: Parenthesize tbflags arguments in
 TBFLAG macros
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260925215004.456336-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX7MRutjOdUgz9
 2WNFPyB1SCDFRy0xyf06ZCou2LXIas35SdzShDkpE4b8Um4tdZcnUELPJVM5fuGXBn9jWRud8hZ
 gBRHxMex77rc5EB72aZ9UjvQMs9lZesxwhi8pxRc66JqZbqmMK1G+YRYlQvp5tyabiaiYhxaRE8
 u60PG40C/I/qYpuJ7AXxQNBLaJ7uaKcDyCC06v7dQ2W9mXd2cHMYJ8Nk3INq57fRZxMpYNnWyM8
 Pqp4dupyRJcIlOYnykJrjU53kDIpoojUCW5H+cH4esTdqVlHbP74IestXIuIhsYT5QwWIYGAh+C
 /1r6qamUXTczjztU0MUWgRJIt1zdD7nYNFQeAxNUKhcr01xEL86sU5A9fUQ3hWV47wV2xyGTlz0
 xS3pn4EDixOtSM4IMykKxpi/fp+kSP4fDc8s+1S2LoRf8atHajWHSpAF+tE8GeMuTfNDw7l+HNl
 tPCGuxIVcAxvOAAJKhw==
X-Authority-Analysis: v=2.4 cv=e6aT2qp/ c=1 sm=1 tr=0 ts=6aba35f3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: D7PdWODAPtg5TsxhGw2eFaV9Mnnz2FR3
X-Proofpoint-ORIG-GUID: D7PdWODAPtg5TsxhGw2eFaV9Mnnz2FR3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX5+PFHFqKNfjK
 X29agPrcRxwJK6fU77AqsTNu0eFQcA1r4uWWciyX2VHWRlI+JHypCaVWJ9wp2/wbA9E7M9+Xgz+
 tHEJjim9IJo/lx0Q7I0CHUrX8fXsa10=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280038
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

On 25/9/26 23:49, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e3f931dba26..8c50e91004d 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2583,21 +2583,21 @@ FIELD(TBFLAG_A64, MTX, 49, 2)
>    * word either is or might be 32 bits only.
>    */
>   #define DP_TBFLAG_ANY(DST, WHICH, VAL) \
> -    (DST.flags = FIELD_DP32(DST.flags, TBFLAG_ANY, WHICH, VAL))
> +    ((DST).flags = FIELD_DP32((DST).flags, TBFLAG_ANY, WHICH, VAL))

Subject mentions "tbflags arguments" but only add parenthesis to the
@DST argument. I understand @WHICH and @VAL are likely safe, so simply
update the subject?

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


