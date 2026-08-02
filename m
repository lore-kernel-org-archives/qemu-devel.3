Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B7C55175
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 14:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqX0r-00014v-LL; Sun, 02 Aug 2026 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX0e-0000zO-DF
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:17:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqX0c-0006QG-7m
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 10:17:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672B6bKN1487138
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 14:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F9fuzL+kITjOShAYfObkgw2B4GdiOXbGroKKVIUqsbg=; b=KTARCDc/BtPkZ6On
 3DGmIwujIGTDpahrvhNZJKSelm1Mq07gd93igRk8y6Wx8F5Ia/jZUn95tzbaSLyy
 BL/gchLlI4lmRM+IzvBxHbziwGrfUcyB1kmYVCq2gk5SqSvPMhlrzbUt0Yx7sw6m
 AOZYOYWfzOEEXotzbJFyu5LcT4UvIDoXXrcbVRl/ijMz7pdtqcTUUq9cUwev6yRo
 nxNlEeFBC6gHTBjkL4FBNYfhzrCWNO2hYirlf44oZS8jMYF/MfJYdTa/WsghaXjD
 0qZqukUSE2dUZ25yyqLP4mwhj78mcmxpvjn9pFZWYaORosGVH5aoR1PLc7/LI0Iw
 ZayvDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs8r6k02n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 14:17:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso50468971cf.1
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785680264; x=1786285064; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F9fuzL+kITjOShAYfObkgw2B4GdiOXbGroKKVIUqsbg=;
 b=NlT0ipFsbjNnJHHkkSAKawskZcAh06Bbwo+To/TTHPMWR9ApcMBtXsxaiEUptC+tvA
 aLOkq+DazXpIh3OtNmXSrAi2JGAOBgSoalDHmtn1+2PzBLHSWXtghwKG6y0Yh31L3sYZ
 Nzq8070s66q+NkB4hPRTB61KQeLu2FnU3TyoeWjh1qijJ4lpmkxIaXC3FDjTYXMePdX9
 biW/LH04b1OKnm85wRihK5yLRHwpfyHmHZOewnqdZJmLtE2MtxPz09aPjx4R0SVRmzO4
 A3HZ3GrZp7/wn0TIQbW7/KPBlcUCTv2zZwWw6mxjYS0dEY6t50/DYh3/faHPQr9IwQeY
 9BEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785680264; x=1786285064;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F9fuzL+kITjOShAYfObkgw2B4GdiOXbGroKKVIUqsbg=;
 b=IAXZcqbot29pCQNlCzMbr5IQ5Ht6zWvE+/0gSexOCqfWVQD07PYablsg6MZPfnAhkk
 schM2UGhpq4KsErfpP5nYT6xXV1XJTL0/IfV3A0HjY4QLvsAoUacbXlWllp15sY3dTne
 WBErVMTGF5eK4QfaPbJjnzh8Utm39hm7clxKPtPLiSnjbFI3irH0XAwbUrdn+ivApN8j
 VnPtgXA2EWWDWdP65efm++JYHarL0efdUclOf3T5/tbPACdNhHqP1rsWX4Ymbrg+O5NZ
 HZ4M0NNWGEjR4L5NO/AmEk3D977c2BlijP5uT6DfUO7KqHXgsZ44mrR/xsg/Vd7YEsMC
 gJgA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCRy92EUC1lrok3vEOzBNc4dUYQBYxeRWIa8cRZaWkf8OHBWns32Og1ZanYqInHKdIU0x2oUVcj8Mp@nongnu.org
X-Gm-Message-State: AOJu0YweIUE4buLC9KdQbGcGoQOH1Xrqcs4kO1gZ36S2CR8uEj+87pWZ
 w4dwrKl04FWToUxchJ1WjJFIYmGpFu6h2QsMdiMqNq8jKqPbGtEkwk3DeAJxTKhAqei5tXAVFWw
 gRpP5A5S84w/7muRhxZQGp20FucwF1c50+2KMmjTkZDamzolKYrBHHlMOWf43fFyNiw==
X-Gm-Gg: AR+sD135iDE9ohLjiXa15tXX6EGsRAmjXHjflRhoJTu2Jk3NTSusu8Ch89HpQ6uzrgs
 kfPmV8JQdBS/Mb+PYksGw/qacAMMIF6licxl9YgPYo27X3THjgg3ETmVYZ0sdgXM8nKGCpGQ8uH
 /Jb3bJmVhzKWW83eaLoVFY2XxjmcIX04cbZYiUlP71eo9EDsKJa+oF18v4YhBW1paR6zPljql5l
 EBe8/Q1HpKBDGR3Qpr2cCKdUu/XWrHxdC6c5DSRxM88s9ZE7rbvAjXWGTTe1UGSHWLNpmddCyhU
 D0g0MW3KAO+DCeGfsNW4/Smhjh8YOJxFSbL1o4y5jN71iNgeALTfuuzfFgLod+IXrxqFDUbhgAt
 Q+q4DIFbr8fkic0dc16qcM8CNEKbw5DHPDttx4N2aXJ70dOGpXaI=
X-Received: by 2002:ac8:6905:0:b0:51c:e6a:1b5a with SMTP id
 d75a77b69052e-52b5669e32fmr143576411cf.12.1785680264409; 
 Sun, 02 Aug 2026 07:17:44 -0700 (PDT)
X-Received: by 2002:ac8:6905:0:b0:51c:e6a:1b5a with SMTP id
 d75a77b69052e-52b5669e32fmr143575901cf.12.1785680264055; 
 Sun, 02 Aug 2026 07:17:44 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b917efsm225795835e9.11.2026.08.02.07.17.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 07:17:43 -0700 (PDT)
Message-ID: <2da79c9e-03c4-400b-bd71-0718815a4970@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 16:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] target/s390x: Convert op_ld32s to op_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731185628.23161-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX6b8IQMrKDS0d
 iWyt+7BFI98maG6s/fYKbUzKpvH7zDjJjlh12sagCIsQIO9njaTgzjtnPk9wF+poPWhQCOww84P
 Plcqp75nwoKvscsdUz+EAKN1+a88QiU=
X-Proofpoint-GUID: 1HCWgvNE15DoT0w65NNGypsLC6NNJ9RA
X-Proofpoint-ORIG-GUID: 1HCWgvNE15DoT0w65NNGypsLC6NNJ9RA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDEyNiBTYWx0ZWRfX3U/bBaSD9vfS
 a1WXfT0Lo8mBMNcIBsztLh1zBRslMWX36yjsB1fkJNaZ9fpbqFi4jUqzK39W5gzWGNqgvWkqbr+
 6DNlUYc2t5bwVRkMPOCCPgDRJvzsyPMn4w6490GQTl3xu+kgXcM85j6uWAekXc6RrGRgyy3BAcj
 r3tZTk5pNpCSmHlByPefJHpac5iHqil/oZNEXR4gPbbXAGItOVOtVAQ92Aj41v2JEI4NuAepT14
 IzImzu0p5y3yqN0Xcn4sTpWdURAqfbaaS2cSB2I0t7XXKwWtjee2Sua9o0csUqw5fSVFlrfW7ev
 /BtdzHCOt/QMKAlgzDcQz1YBMYwd0z3acl4ikcIUu76WipRwC65hZZaF05128SnRrbdtQTivFZz
 bMR0UuzCDXPW6ShHBQ/876H0OKW0UslO7yP2uYjES++3RWipAYJM2w8TW2YHzvyAxkWNsMX0NG+
 xCENnK6UvOOmIW4IXTQ==
X-Authority-Analysis: v=2.4 cv=Q5ziJY2a c=1 sm=1 tr=0 ts=6a6f5188 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020126
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

On 31/7/26 20:56, Richard Henderson wrote:
> Note that op_ld32s already or'd in insn->data, with the only
> use being MO_ALIGN.  We now put the entire MemOp in insn->data.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     |  7 -------
>   target/s390x/tcg/insn-data.h.inc | 14 +++++++-------
>   2 files changed, 7 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

