Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EA4C44511
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJBJ-0001cx-FV; Fri, 10 Jul 2026 17:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJBI-0001c2-Lk
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:54:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJBH-0006pd-3q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:54:48 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3KC41622744
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wZ4ev25mf2yIvDDhyZup3uqowdmI4yCxUrNbot8ExUQ=; b=E8nf5FI9zyI9tVZi
 iWTMns4Yt9A93TRDPvPkOHyikCuD71hcdRNJnMQ4sD5daOt5uB3DxH1BTdBPhc92
 z57cfYK7/Qf3JdNS0qqvIVh/8V14bq++jGJ0kwRTk4+pIO7Y9eKonDXSI+ogV2r6
 h11ebi1D6ykbIo809GY/k18YCMHEeQqYjhg1UX2Ze9pQq+NAuWsTqEjVgjCSGdoM
 sOUkLKA7E1NaB9K7LV5/RPxlwHbzhlAISnDOhkBiU2bHJSdCMtHJo9l04MzN91zI
 xjZisT1JQhsUE0IY2KizasZX8t30YtixrBCjkIhaTObGulLhYeyTQTwTALgUp9XE
 O946mQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8vq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:54:35 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so27828161cf.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720475; x=1784325275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZ4ev25mf2yIvDDhyZup3uqowdmI4yCxUrNbot8ExUQ=;
 b=Y9P60b34EsA1a0NGfyyuvdeAwOJ6wt6wxzLK1rNoMQK2TRazCiG64MmVMAX9OrRRef
 cVqM55x3p/ygbgL6Ex8NSiJ3Kji1n35vOUzqnl26EKqLjx7ySkoSm73v3r7K5KenTv/1
 HLOpr2Sab0ZTrxCw6kUaiCycnAnJ6ghKwYgutSLTozBrmUUdCwN4oIN47jv90ZN9wCX9
 heB52yTcLZElS76jxWrrURJny+mXi5yT7bpbWTP+FgDSqTdLFlz57+7HXP48aftFKWNo
 fgdw0yhN6aM6mFAQP5U3TQGy9RXKjXbVtjdgT7ZbEdmkqNVfxuYAw6ADByYtOdXYmJzq
 AQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720475; x=1784325275;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wZ4ev25mf2yIvDDhyZup3uqowdmI4yCxUrNbot8ExUQ=;
 b=c9N2ck0YWvWMscnvO4rmIrAe6Fi5ot3tTF5VE3xwFKyBA/WNP3oLLQFsN+sIJV+1E5
 KvI5D5eF2wUf0TvqWiT3MxzM/dldmZHyxSRXunU2Nt+WgiwJUG39HJtLzN4/Nmyr86Q6
 krjELF2mgOXAMUa1AjrrgdMRIWA7nmhA5B0789pa7zMVIDP8XaDnxB87ApH1FJLActo0
 8lFxD6G5u/vG2iuubLTbrLLtnl2yVXxGxRChQGwRL66bQCYyLOCScOYzeCI5GdLhUCQZ
 PB+WdZvWkK1w5UkL0PDVto337dAAK2cRC0LkrefTrkiRQmdVPC2ByOjJzNl/RxewNt74
 fzbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnH65IWzgBcIQQxJIvkREwP2NcuYmo6CLugyq1xzSC74S0F+U9J/ulRYy4Ye3v+KV2i/nUE4v3/TRq@nongnu.org
X-Gm-Message-State: AOJu0YwyE1IyVwUjws+ehz55pyUZyyiT9afc6ot4YdOyf2UWvNm2VO4B
 h7Zd0rTQFA2smXK6aGn+ih75s1N/zgfNxqaUiiJ7FC7zybhMF6weNOScejPa7UmfAN1+EGIHqqr
 DB2+dh2aCzz9Puf6KU67U4CyLMrfgc9/CZZ9qDSe0JSgHUpQqH6PXxR3EuQ==
X-Gm-Gg: AfdE7cmpMR8V8QU4iMeZZPmZu4DplD5PuXeSFyKOkgkHhU7NAU4tC+cfBUXLSLsat6B
 JbJFWSvnliNLdwt/AO/fbNxNDRd30enO3BwhA/0fISq8wD8SIxTng2vbNdQFe7Dak/DIUS63SGe
 IINXcRP7ZlA3EMmxx4itVC04QuALSqd1g5cK9xZRsQwonbceI/GUntZbGHVD42JBzqEnPGOAHg0
 FPBIZvGPWkeweG7S/w03O3NyQMOWQllHFVIkOa0FUiwXexMRESkk/p+UdGZ6SsOHejm/afmzmhT
 l9tfWfglab27aDpzYYFIky9/WdVQAGM1qmnV/7Wwv4CiJB5dlNM8h0EJGlUIf1A9y/2Ylqy73Me
 OsZ1ATLuI2jhTIcoiobOeLa3gXoBZIo8lrM16SrOG0blbKYQQYEBFO0ZXgPNRbg==
X-Received: by 2002:ac8:58d2:0:b0:517:5f04:f24c with SMTP id
 d75a77b69052e-51cbf1ac31dmr7594731cf.39.1783720469928; 
 Fri, 10 Jul 2026 14:54:29 -0700 (PDT)
X-Received: by 2002:ac8:58d2:0:b0:517:5f04:f24c with SMTP id
 d75a77b69052e-51cbf1ac31dmr7594561cf.39.1783720469564; 
 Fri, 10 Jul 2026 14:54:29 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb742a49sm159722975e9.12.2026.07.10.14.54.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:54:28 -0700 (PDT)
Message-ID: <8630ccc0-5190-444e-bf02-e4da38e3537c@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/51] system: Remove cpu_watchpoint_insert error
 return path
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-21-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lBJDdVdGhe-s3iNaDuhwA4bGfpFGUL92
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX3WSqD+L/W6S2
 uRdqJIu+rlvDbi9v6OE7PIcan630v/ddtdqp5AFUYJ3dyeRZZr4YCet5vi6m/8FtTgbJCeqX2FU
 r0sh9JqNjyWVsle4ue53W9jlL+Zu3S+lXtlFxPCBrl93S+2b4LHZKiAfth6Cx9g3Q9Xg1Eve/rl
 L57GW5f30JqHu151g1rmzvQSe4yH/LIUU/jwp9tzqxkwSzyasimXyZqfPoj4K3jcR30HpGJfUGi
 J13HhSoDMmnmrC5WODDGAKWuKP9NBILJbEMKHjVoj99RvOqtBKXIhUWh8HG9QkEJs+E/BR8lnZt
 25NOji86/xWwG1McksdiZ1a5TknAgND6PcH09iZX4Jo7IArByxLOaRJTqi5yzvk21dP+90YNCPS
 gu5of3tFE0XWnE7oHz6p4TuytgUWOh7pkx1LvhWmBOVQlOO+e4yBQHQFRgXt4hCJ2ab9Wbp4wG1
 17pTvnvjncHprCrOhMg==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a516a1b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=pZVW5Mm1fYg_kLs75vEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: lBJDdVdGhe-s3iNaDuhwA4bGfpFGUL92
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyMCBTYWx0ZWRfX6e9K4vEPp3Ym
 qlkiPh1pNvHLemQ8S9mbm5vJ1nWCmF7oTDIlFCEEnlXvxpnc0pSbcGSZ8z7/xf1kdXMfdNovAdh
 3Sy2alg8qHq/EctwM4I3taoPV4tq59c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100220
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 10/7/26 22:53, Richard Henderson wrote:
> Move the validation of the address range to tcg_insert_breakpoint,
> which has to deal with gdbstub inputs.  Leave assertions behind
> in cpu_watchpoint_insert, but no error return path.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops.c | 3 +++
>   system/watchpoint.c       | 9 ++-------
>   2 files changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

