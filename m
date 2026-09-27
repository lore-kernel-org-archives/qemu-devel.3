Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D72C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqF2-0003Wp-5r; Sun, 27 Sep 2026 10:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqEp-0003WG-Vt
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:52:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqEo-0005lp-J3
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:52:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R0kk291656080
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l1K8AUQMG1popeWOnDbpMpom4vARA7T/1GLOtraLoxw=; b=ZQlUDYmmh8Ev+1lR
 gvZ3A+H4rxZGn6ewaDbAfcb1wmta2irHLRwJnTiMExEW0RGI/ISREAoUkFbQSAmf
 nslKoA+dyBROvrw7qTtLY98z9egdr36ASNdIioIxV/2l9TuSiRWbgg5JhHm0pgVX
 8/yFshw9Yy6gpnXP/gyiCQZOJoXqwQMw1B+XwXx5hXTN4pMTlk+MykuzYv+AfqXL
 oow9iNhVX+OJOS9H5ihLl1JD+LDPj1xD5dzIDRCUaCzvWA5tDG8aZRUplXnZfs0k
 UQYULXnyt52AeGtF4CpXAR4WEgImgA/9iJY7+N0FBZQqWYYIgI8n0mDBLNA9uVXM
 Yt0YqQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526k7t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:52:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a08ff8451so411698885a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790520739; x=1791125539; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l1K8AUQMG1popeWOnDbpMpom4vARA7T/1GLOtraLoxw=;
 b=HlQ6rERQXDRWXw369WFq+5dWvsEHoUWH+X7B+EB97oqCyBImlwbrbFzybnT/oIgdzi
 5jViY4VX75f4rrdvIABW5uJTSeMBH8FultSlmyUrFKa8Q8xc45Bt4414khyuTAQLB+f1
 jkqIvuI+XQWPBOLrA3nwq2LCMdV56WoWvwXSmR8fYt0O7Jx5Yp4UZVNMJTdAj8Xnq7L8
 9xc0ojd9sGzRnXb5Jh1SZlhxdIbC6el2G34/myrW3Qd2fTNwKG0mlN8x8ZEnsdrNmxpG
 EkfrHbMTsJBDEc4zaLIT3idiUUbbkp+iGmcCXAH50nJgLTTlbHQKsUNExMGXy3RPWphe
 UPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790520739; x=1791125539;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l1K8AUQMG1popeWOnDbpMpom4vARA7T/1GLOtraLoxw=;
 b=jsY74cDqekGXQVTgwUG9+h7BwM44WR9q5kAPDqjJ61iiHAiuNkYqyPl54L4r+j/JSv
 HtoXW3DZl1favLb3Uru8wWeHE35JyhsA6jit6WVxU3Zlkj4IzAYfzrkA6SewhJlzu52e
 /UNdGcnI+fbP0m0ETmS6gtcNzP3CMsKKwln2+AXBayMxJETyrmMfjvD25KVpgmPtSQyI
 6AX52X1XWmI1VB2AL7fNlIocKbmunSO68qysA1Vm330QmXX7WTCZt451vRYgBRldKgrN
 +H4suDs3ze62h+rIWr8r7lH9IL1UJCocYn+v+4WHhZ6XJ4jzdrEwvBdTr7L14nQ2tqC/
 ZLmg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3aluMuYyqQWzJAul8Dn648w98PnOJkKiXQnxhm11rX5QXHh16ZcxoHpvjciivX/pVUF1vJlhu724G@nongnu.org
X-Gm-Message-State: AFuF++nGDmIVgWX2b0GSGl/X5oyiBFKGBcfKy6PgqXCPvOmaDHHw/GXj
 7i1G5rue0cyfxxBr45YCRyact96mSsiZhgpLoSuBSfeHu+zRdhVmUsAkuN6QKFv5z5I+AYXuIvL
 qc+5oo8E9xpUpqSmKUQo04Nnq02W18kxtpTZbJmVQmkY9rG0hPPTvIZlaIg==
X-Gm-Gg: AYBFou0JGXJQxKdWZ5i0kk2dQ6Zd8SIjm9ndGRJpiWuXIX3st1ZFPsyR6GG6L4gnXlv
 PkYzNT3uQ3WqNa6ipiCnETMu00eIcXQnIRJVnmZ1UBAuV0ej/MwF+x7ct64BeEmfZtW/JTmg4t/
 ifgumdNEsovTXEEfEjDNL2BwlS5vk+YZEmqRBxlZ2Q2SXW/YLKV3uR0zL+86XsAeeCuTUg6f2rh
 rZmBht7l3CKxqhq0p3D0chhrvAPtqVMfRvbkhXC4ee/GPEwQqm1DBV9kcVuOhDK8TzFn+icu+lP
 nMOGpBa/lkt2fsV1VH5ZMgicrgjNQgQ8/nACJvSITEWE2wbodWTsbQC04rnskDnjqjXuQMsRTFh
 UKouqV0UD646t3LGfYh7JZxiP/XJZ5keWjA==
X-Received: by 2002:a05:620a:4003:b0:93c:7281:3be8 with SMTP id
 af79cd13be357-93c72817123mr270526085a.40.1790520739107; 
 Sun, 27 Sep 2026 07:52:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4003:b0:93c:7281:3be8 with SMTP id
 af79cd13be357-93c72817123mr270522685a.40.1790520738677; 
 Sun, 27 Sep 2026 07:52:18 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001778312sm160864335e9.8.2026.09.27.07.52.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:52:18 -0700 (PDT)
Message-ID: <43387704-4733-4da0-9104-7cd2c2615177@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 003/101] tcg: Annontate functions in tcg.h with
 QEMU_*_NONNULL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab92da3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WyHhD23IAqCWfTJX27FE6aTXnOTsuCPz
X-Proofpoint-ORIG-GUID: WyHhD23IAqCWfTJX27FE6aTXnOTsuCPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX09SSxLWe4wSq
 ha5nXSlb1B+kdU9l3Bv9sQhq3q5XiGxKmmSiPTCJlc60qs13+IQF2dDo4twCZ9RoibxN7sxpChd
 vc3JVueBfPPxn4KBluzoedrQK6k3ay1aVhOhzCxy4oj5QEUsi0b9pDy/l54JvEi5NW9dR0+y72X
 gblsPcs/eXPtgG5TeK00MALUEY3gruSNaDU8IiiP5lUYeBTKo8MFRRMEfhbvyZOaOpz3uHpu2yE
 6Tqm377rDV68y+kFWOp5LHmLKu6X0g+4yTfxT8R4fVyJlDA6TpSdmpzf43MCKX/QCMj6lKRbHWM
 g8YP4zhS/lEJ38iT75k3KAgvTyUi2CmCALsaI4PxothWa9SBSmBIYuHtganzI2bU4s2vTOMeXNl
 7SMXbnEcm8UhbrTOxgsVJ94GLR4kxv9YUaI87apAuG6eCErz2SbkJZJjpHRcrzA/gfG1HimZOhp
 ljMVBox7lXtRP/ssZZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX30kjh5g2PKcE
 Eudn/YcqximI4AmJqHcd0F7lFGNXzMes3n0jAI8RefdQNyPHfvCoBGboAKS55t1/Kr2OwhMqmwS
 wlpVm6s6kUe7yS0P/MnAhgNOadO/Cv4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270059
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h | 58 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 46 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

