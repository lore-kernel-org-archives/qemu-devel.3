Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6A7CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDkYu-0003U7-DR; Mon, 05 Oct 2026 11:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkYe-0003R1-Jj
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:24:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xDkYc-0000aI-FL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 11:24:52 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 695EP9rr2651656
 for <qemu-devel@nongnu.org>; Mon, 5 Oct 2026 15:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AN//rTIt/mdsTYyc2alHYhAvylVPM4qi8YqPQzbGywQ=; b=FMIa+DeVe1RMqNva
 YWamziNgQe+15tXD1/U/W3PwdGXfQybDqSOH1j16EeVO5vXLykQQMiGktV12fY7H
 Y2PIAMfM0pcgvuGPiTa9WAV8k5CnjFJYxITVzG40QcmFeAlvqSF9YltHRoYOAXe5
 TtfuU1EWytVAMxmgmb7qQX486fYqaAuzGZDUnBOw/tgU3UGxecRqR58BxuZglUJh
 0GESymKZSYz0Qi0RlXst5uzBhfjMa7Guf7QYwCY/hw9Z5a8Kn9dTDHniaH8NVsze
 3MCzFzacD41/SXJ0fqzLxSxpFSdpR7+kILjnVaPXdde/NSMFj5wJnL+oecFXMkEh
 x3yc+A==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h49tvs31r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 15:24:49 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-34ef0362d95so3646017eec.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 08:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791213888; x=1791818688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AN//rTIt/mdsTYyc2alHYhAvylVPM4qi8YqPQzbGywQ=;
 b=GuSefkRcRyQ2nAxBSA9ocYqbGQkx6i/ma2XSFx1evelWCTROlvChMRk4JjVjq4XABo
 n4zJE5x36dsxn6cquHErs9mTW3EtqUtKOvCmkeq0uj98EpsY1ZpnTM7bkjFml9rsLUO5
 +kBnBBZGFUCfwoPeVEN7tsODHIYhYMfvFufiTofmtLbmArKwm3uLeMeKxmHVn+FBRcKG
 gH+qAbxmGu7GC2+8Q6ogD5Iedc25ASqaqooBf98Uaxfdvq57t/ad8uC0NRVrV7fnDR+s
 B9JgUsQxJzTYCGaQsQ0bgC/DvnCD7uHwvKw/044Trpv3M6S7IirUx62na63Xrn4hLxzC
 4yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213888; x=1791818688;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AN//rTIt/mdsTYyc2alHYhAvylVPM4qi8YqPQzbGywQ=;
 b=Nb12TKRLKXLKDZUqKcCXP5f/Bnzi3zMjkIGjrOHqrpFJkm24IQCA2G6t2F5LXP764u
 OZTfLzAe/M8QIxUQNovur7yMqVK3U+H0wet+6w2yeTdci7I726cnTweHqqjNKR/El5Gt
 z5Rq6zGsn3djebxlDYVmjMf9evPIMmSrrvscfc+d32r4R9o3NrX4iwJ6eZ5kFhnKY0+j
 K8sAmqpUFaq+11UxLrDSCWcLfErDvuIN273EZ4Xl5TDRd0ivRYcO1BMo3l43EQXpNAZV
 PeXOMslQ4qGPLx4j2q4zPcO4DViAhF80XXBP+1LBgz7IqvuaW/ArO/5o+jRww85blX0n
 dQVw==
X-Gm-Message-State: AFuF++lSPWMws/opv5lnPqeHaelWDMXQlVWGrVViEVrx6inSu3YCUEgz
 +s1HUNUf05iNm+m21sXWQlhO7L/1TRyPIZm7ZhINEFvr2IUS/DR2tBHF2jOf6/MDd9KL8rx7xW2
 i1/zIcFGquN/L0ZyvmPAqmc8FBT7v3E87DOPQSb9keqtg9tdrGSdFun7rQbcjaoQB3A==
X-Gm-Gg: AYBFou2o+7LCgRSDq8YM2KFofQRfnIllc+gteT4AAJr9dpctRaD67KRUMKzA5Ss0+HY
 Ubmb75m9X4EwFlvd1Uwlyz7OUjKe21WlZD8FgdC/vZqbpKnuCVyZNIfuYAnwYdZD40thtFE/ar/
 nDvUI5I0tfYbw0Tjdw4/+Mb70Sv+VnSs3lKLf97jB6ClKw8P+Dl95SLujTBpt0HuqKjz7KFqd0u
 2q+Ikt1S7V1bL937oxbP28sd7Ij/0QE8PHCPlg36rk2ZG/YVH1bfbuSLWCHMt6MqwsFkhbB85pI
 Gsatx61RcobusfVFHnU8MTpcecsrqxNMh+ab/hGXWTpfKeDewt8XvGQpL+pYBxae2o2Rb0J/6rf
 yyYt4DzsZuerd/wkrWusQF0D8ZUrEVh/+6Ez8SXM/lJvg3gFl3SEsJcGdc71yxH07sXjnWw==
X-Received: by 2002:a05:693c:69c9:b0:351:29c8:643 with SMTP id
 5a478bee46e88-35129c80efcmr5232382eec.18.1791213888142; 
 Mon, 05 Oct 2026 08:24:48 -0700 (PDT)
X-Received: by 2002:a05:693c:69c9:b0:351:29c8:643 with SMTP id
 5a478bee46e88-35129c80efcmr5232348eec.18.1791213887506; 
 Mon, 05 Oct 2026 08:24:47 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35129de5740sm12934824eec.18.2026.10.05.08.24.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:24:47 -0700 (PDT)
Message-ID: <dbaa6214-ae92-45bd-9bbd-8a630eae51ad@oss.qualcomm.com>
Date: Mon, 5 Oct 2026 08:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tests/tcg: add missing tests after meson transition
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Dominic P
 <gcc@gcc.dp11.uk>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aN9lOr9m c=1 sm=1 tr=0 ts=6ac3c141 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20AIOXeW19usebo6yxIA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: hEMURpxd0qgG0TTMuAYHhX384KMXznRR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX8lq2NLPkaL7e
 nQ7kg3oUhoTdkQHMlgeIEYwPSfQw5g000HNs+GyHEhf+OkWB6MiukpwmxoClDtPZx374W+tsx9Y
 ZIiIABYchr+Edy4i2Aj81WZzUQm8oE9fWx2pL1J6ZRiE+uMe8iXIa8El85KW+gRsMslb7sMHRbQ
 es2KB2A9jTxeAqv4KUqqSa9V2LHtbMRMAZlbDttpzNPpI0Gh6yfrl1Ms8JSKfw/UzbyPio/v16b
 cdosB7mycu3Zy88jhV9n0zAd7WyFRKqSbCq+5NRu6VnB65aikLeRrub5Noqv9t19ab6U7VrB8vV
 lXUS7wsc7WYZuxkDZYbZRiToQy5HfWSREU9DF6cD7XWKngSZN7zpXPkpbf2JqcMDnrmjhrwVdoC
 J15dUqUgF0NSdu/J5Taqng2jTpvN+TNmZaU6ezGkZ3+eg+nLG9qTjYMM1gBVijIPpulgwnjxkCf
 cSYvLFSWvZNJZtBXYPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfXy2gZ4iDtKHpD
 fK0z0sCk7WGHxFEjyuq6WULOSZooqMNdwffO4NOdUgo1V3CcD01oklU7mXNJBaq3ouoJlmJWow9
 w+khj5oP1lXU7ZzVKhfXT6GkXDKoYaM=
X-Proofpoint-ORIG-GUID: hEMURpxd0qgG0TTMuAYHhX384KMXznRR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060
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

On 10/1/2026 9:37 AM, Pierrick Bouvier wrote:
> Those tests were (wrongly) skipped when we moved from Makefiles to meson, add
> them back.
> 
> Dominic P (1):
>   tests/tcg/i386: Build test-i386-opt-shr
> 
> Pierrick Bouvier (2):
>   tests/tcg/multiarch: add missing vma-pthread test
>   tests/tcg/multiarch: add missing test_pnew_jump_loads.c test
> 
>  tests/tcg/hexagon/meson.build   | 1 +
>  tests/tcg/i386/meson.build      | 1 +
>  tests/tcg/multiarch/meson.build | 1 +
>  3 files changed, 3 insertions(+)
> 

This was merged into master (2a0ac9c8ac2d303ca515dc819043409aef18cab5).

Regards,
Pierrick

