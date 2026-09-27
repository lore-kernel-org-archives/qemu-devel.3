Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72FC98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqgY-00009N-Iv; Sun, 27 Sep 2026 11:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqgW-00008w-SC
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:21:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqgV-0000D2-Bk
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:21:00 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QNeb7c2253515
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YGYYECJAVP/SMZmt4kejHVzJ2wCm1Ok5CYFfwfhOG14=; b=GjTiRS1oABS6fsd2
 HAuR39Vkq2Dx3+Qbv8EOC+eJlPd+pbcOJ2xmj+Aee6Xyj+n/PFyKPgRhnnrTQ54v
 bf3eeLi0gR9yAWd79DYwyDM1OMrs93BFRKjvDVN6f9Q6SJ+eqyuvTYKCqGIph7mm
 qks5VjcRR+eQ0S9JivOLySlHCeHoDsQQLiXFLA6K09wzoNob1/3t3I0IV8qIG2mn
 9UtQqYtm7Uv2kDLTUmuQU58gBBQfqAteVpdPev7DcjaNK8HPSW4jKndaFXD6Hxt9
 3wJSk+SHy17fpYLLmb1ucJETNa6BlL8pUC49NbLlsa3dH6plBcGIyB2VkcpI9jcQ
 Ksp2uQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3rfug90-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:20:57 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9390a2c895bso692097485a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790522457; x=1791127257; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YGYYECJAVP/SMZmt4kejHVzJ2wCm1Ok5CYFfwfhOG14=;
 b=RZA9UmrSC79KxG+s+41LWD8jwkRMwqPZdUcM1Q4WCdETbpbHU++MQ5ZuUWoaKhEc7C
 0VtXeIEjngnN+QHIr9pfb8Hg/WzFxy++5vZBWbBe8gzwUdypOqZ18E02rY9/WWkd6b3/
 bIL8Oqfw+n8q03thbi0OG1u9506zrucBjXkOadTeqpgnC7fsNDHMD4XFfrhkK01YMfqO
 8pkhLnPgjdXgvd1coUfBcV+20BL+FuGLQPNSW+eqWVMu/oXQFM85UFJ5VmR+kKzwuTxt
 31EEwkc/TzFCBqe/1q/hooVf7p3PC2m4A1hMOpBdpDtgHtmSSnep93Ez2KLgEB630t1t
 M7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522457; x=1791127257;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YGYYECJAVP/SMZmt4kejHVzJ2wCm1Ok5CYFfwfhOG14=;
 b=m1+Jf3v5pg5mOTx0Pgl2QjETnCJE2sfNIGmCWsCw2AljCle2yeYy+mWzXJlmwAsxFW
 mg3hF/oFvNK5ZByHGnLro+aRvNi8HUkVOM8q5768XkWPHhO7vP4N23dkVF5vfEwqIwDp
 r81NgZrnrLtaq3Kef6ewLqHRi1cTCiegDIPv/yfy0sW4IlYeKeEWNKj3Jx40qhw2bu+P
 TsdEl7ghK//gkbIlNevrE6cNwEUyJKwmpWqXE2VEmbkydAbcHp7PUHcUCwt4pWaRkexw
 ESDcO6BqaQBnAK586x8AdmM3tMrJYEqnYy3ZOtpJQg2nLJs6GFOh22PTfNn24KpYCywz
 n/5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwjRGjMVeFRzVn0t0tKoY8w+N5kkeyDSulEtz7V/JRPp7MnTauJCJHW/bUPg5Rzq2U54wbzVpa+BMWu@nongnu.org
X-Gm-Message-State: AFuF++nNAhGcrC2oh3DNnik9r87PTE7thSNej06y45t2I0ooouknsJph
 qh5Fio1Babzh7+eRMEZC+37uu3gbEokr8Cn2VeqauGqMVjsM/rsKfKuKXdRfTDYUCxvThY0isTc
 JywT1p232WKRLruuYj7zBENaWXrGuFRtYZXhRn3L8irZr3EYLx5JW8oOIQA==
X-Gm-Gg: AYBFou1QbKjvYQvcb4sBGRVL4TZnGzbvWqQXZoPcd2GvNp3bp1WfseqQN2biei+xxJf
 nlkicuWxQJ/z9T9tMDR2gwsEhZrQnBAkBEhzz/SWAr+3X4rOgtMBajxxI7qqi5bV7rOVNFGQgud
 InKBUeFGvM/ZDlETzzCS1/bjDumHkmiWTA9WdFUTWnWGu2xxGcFuk3rOalyN2YD5xNNEVBMmrQQ
 JSYwWCQfgJUdKTyEGIX8oRFIQ3F+KygX+LeTTkpMXq+Soo47f1JOoedXFdYTMkWdpDjI1fd1/AP
 MaEI5frl4KEn/Fj3Squ2FWO5KF+FALB6btYjIoX51DFql9p7Ch87z/TQRSAuD7sKuKA+ixOtH/e
 5U5KnS1yTKTe8EC2fEADRTRrA845wYbtkNQ==
X-Received: by 2002:a05:620a:1d01:b0:939:4a34:621e with SMTP id
 af79cd13be357-93c43d37527mr1566483885a.28.1790522456949; 
 Sun, 27 Sep 2026 08:20:56 -0700 (PDT)
X-Received: by 2002:a05:620a:1d01:b0:939:4a34:621e with SMTP id
 af79cd13be357-93c43d37527mr1566479785a.28.1790522456463; 
 Sun, 27 Sep 2026 08:20:56 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a34a638sm20533265f8f.9.2026.09.27.08.20.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:20:55 -0700 (PDT)
Message-ID: <1acaa495-14af-40ff-a6d2-490632907fdb@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:20:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 012/101] tcg: Generic expansion of tcg_gen_add_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX1OY+pjDNzx2v
 ZrC1FpdbW4AIgRFBJbJBOAB9mWKmdixfq+apOJZwgAy1D4WhlM0vT7sqKXo55ImkqbWpoBDSYBq
 BOdtUTP7yeKYOqXRh4d4xYmhM/v/lBs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX6ArJKElUACB8
 Jy0hXTxX6oZKDa5fC3NQYKRBgKZyahFCxj6MdHj7zgLMRgdX8h5k/0oeV8TJvbk9YcHSDrDXLzT
 xDwmkNYbuXtqS0HDMAMug8cBzMzoHNQMHyxtvBBPqtut4FxtjFyvJ3nEDWTPPCM5jSU+KhhPWTp
 FJ09jOGY88HKYeOZIi7lKWgfIjTUIp+B5+ulrCc1BZTBwXtcBdNUsr4kS1zXe4Q7BTx/OFBYvw4
 ZzHTsthNmi0Hrc17A25qLzyrr3Vf5e10Uf6v1JYMxT6DqQ1Il6YCXmMWXVaKy+Y922tsHcBE9bB
 bMIb7tQlKI8+gLr/5r4dvlWZSmro02Q1IkOnZ9P1epm3Ur3YCjgrHfn5nBdPOpZhKfeCwsspiDe
 E/TFNbS+o2wACrbfjaHCeYpCl0BcriWlbzX4Ip7rf6knZEDS8iWzQOmZYtTEjMm24+wKmc2/yWn
 n+0xOa3hvaaAgiMtt2Q==
X-Proofpoint-GUID: 5KU_Y_wpxmqPIpm8sVPPUT4KN25k_o5R
X-Proofpoint-ORIG-GUID: 5KU_Y_wpxmqPIpm8sVPPUT4KN25k_o5R
X-Authority-Analysis: v=2.4 cv=K6G3jCWI c=1 sm=1 tr=0 ts=6ab93459 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  5 +++--
>   tcg/tcg-internal.h           |  9 +++++++++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 20 ++++++++++----------
>   4 files changed, 23 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

