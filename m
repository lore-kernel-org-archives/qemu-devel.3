Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64E4C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqsE-0003UA-Hx; Sun, 27 Sep 2026 11:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqs3-0003Sy-5W
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:32:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqs1-0002DZ-ST
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:32:54 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxtSF718590
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:32:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pWRxHLL7UvxLTxa0FlKia9HsEzGA06HZW+GDmyFZZFo=; b=LdzXm5RroJ1KBisf
 WDaeF4VWFwXaxxlR1ODf/eVYXXHZubcpY38gulQocbQ6IRDy8xO6Wk4Lx0xc2ia+
 N1moVYgpXCR4icNHst2Mrr41rEemi6kDdaBblIckF1A+lU64+MOM+s5+ujbIDC6c
 LtYHZmBPFs22NQVUdrWeDUxB7oidhuC9IruIZeayyvFEpfbDx5h7I9UJm1YrvPDz
 3w8yyeYsHWrRzh7aiWU7zZpoFAUEdtX65MhcjHVBUyPufPLArRqe1+h5KA9lr8vp
 undcFcZzeWbWiRfVoc54x3FGQf7SAS89tIvR0gEa3oU1GMW59MSxNfagMJ3qebHP
 Fj1NGA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx526k9uh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:32:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9308eafb465so647301585a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523172; x=1791127972; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pWRxHLL7UvxLTxa0FlKia9HsEzGA06HZW+GDmyFZZFo=;
 b=TBfBxqCLxcMtbmLEWaRfT4/usFaeKWlkaU/35c4hXaIHThBi8F+U92jkEckrKKiHXg
 bq247wbZ9KVW7JgBmauRQ5KQVNVyRXWE5+53LRIPHGBLJ7QlY1+JV1Mb6mR9Fs+PZdDu
 azuiXGcAN30EnAdsOP/gFGjqAN6jPCmCxxo1C8sQaT4PIk/pm5MGHvmxx8ELI77k6jOh
 jxcRu89HQBfMyNEYzjJ99HMZgwhMUjsFMAIaD9lLUhL4OrjS+ZNF1oz11b1J4GOXhQi4
 TngP4G2XqAEPf2xCcDOgAOLphB5KtbXVw0dK5SDE6bV/BS644OSAz9VIXq9blTMqRaqV
 I9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523172; x=1791127972;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pWRxHLL7UvxLTxa0FlKia9HsEzGA06HZW+GDmyFZZFo=;
 b=BUozJo5eekjnm1dKWEoJdlp+p3tkC2LC5w6ECUeXx9k2i8eX95s77XCrYg1UXhwkr+
 5abkWxmisdezk1zaEzwvrIDMsHll563LTf+ieVh8UBzlyWQksxEkU07jhcgyb7JiGnoA
 xwyoFbo5dPbs2gD76wn5gMEzRR4aq8zXugVGVed6e38JnW4FCcohckCVRMg33V+sMxXK
 JqxsZslb5b7urP+qx+1aZsCNt9Ap4lknDSFkpurcf7ZaLtYWTtLXBwo8JdPjRM3Qg8KU
 RSs/mpBGQcuBsA9f+kIDwljV3lwYUHykFSj0WL0fzvJ596MXO7nJyi+SmHtz1T9+kWrF
 VHsA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzPB9EBa7PDOzSnS+4ZCPHAwgf179k0orYAGE3+icuPTMSq/visDjyewHAkkEA1fVGqELm0ToHLUOPI@nongnu.org
X-Gm-Message-State: AFuF++lM5oCnsvinYmgJwaNY6stQaF/4WTOjBdlyot2FdPdf6Xp6t1hu
 YmqXsNvltGy7KkBQQA1UgPSEyNTcS67gEt3DJZ8qToQBh5KlFjnoCftI1r2bNx9pmJuu+mDjeMC
 E6kb9n377YD/AZoW8eh5yO9ERjb3vn0Kyskfv1uerU5gTOxC9w/bM/h2pcQ==
X-Gm-Gg: AYBFou3/9jzL927nocv4HZwCaYzPCEjwKOLY/+UbrN7GcF+0BFfxdPRFM7d3KDOccvd
 /63qIJ+PTaF+8oBua4gZqx5YmvXkXC2kWxqNf/BIObQ9kFpA+hvDD1fuZelLPrDmuHX9QwgU1lz
 hcGjiG8QvVicuWQ4p2AT3APGfsRKB7cGe1TfXOcLD8a8Z4+8Zrh1OVdRsx4H8fCNpQTqdU39+To
 auObIKBwsDe5trbYlg1y1GplRzbP1sE0H63QYJ+K955QmkdfW9+IOej9zXZnw4/XTCtbh3+j/ff
 VDy4qB/82T+fOTbIF5aAvsuPQqw5svljUAQifJegPWDbX3C4+y2U6JX6QqI4K7UlFNLdFp3pw8W
 VM/U9cUfV1HUVon42BFfw83UjWwxEBnUDcQ==
X-Received: by 2002:a05:620a:1789:b0:93b:d7a1:ba0f with SMTP id
 af79cd13be357-93c47554f70mr1518749285a.58.1790523171734; 
 Sun, 27 Sep 2026 08:32:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:93b:d7a1:ba0f with SMTP id
 af79cd13be357-93c47554f70mr1518745085a.58.1790523171314; 
 Sun, 27 Sep 2026 08:32:51 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018f1375sm60381115e9.8.2026.09.27.08.32.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:32:50 -0700 (PDT)
Message-ID: <05d77125-2f8e-48cc-8ea6-9f189a2a7f76@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:32:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 017/101] tcg: Generic expansion of tcg_gen_subfi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VvS2kO2n c=1 sm=1 tr=0 ts=6ab93724 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: IL5Wwck-sGn1X0N0KP0Z5qVV_AH0c5XV
X-Proofpoint-ORIG-GUID: IL5Wwck-sGn1X0N0KP0Z5qVV_AH0c5XV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXz52HEYNOjj4I
 0ZvamaV8G+gYI3i3MJjnfSbQFZjB7bDrW1p/T2iwcswMkw0swif75bfY2Tv8YvhDu4dOhL65hfp
 dbOsyJGECjz2bozP6oZWRFugr0WMzl/YxFGac5rHfCcbBgC0ch+32XZ/IDYJ4zYNF9wJX1HcY4Q
 rVQWzkBa6LwMwIJSWco41CXRoFPPHxPO0XIGSS2VUHU1T6qmleIZMe6N9S47DsEKQeeI8G237SA
 bVOGI/2VEgi76hyjHlk+Grj6g03RbCreWSM/1jX30STqhIixoFDiEGR+XxScMYiVsmhg4IuRvIL
 HvlPu8JefzcCLqJYQPnI8/tne9sr0t8iTiNqswIr+joeqasEvbesFNPqvfyQqzWL6wEUetERtkM
 IxNEPrsnMlDmhHiBEkXlKeCPN2FoGvWXeaR3iujiYo2rsO9wYSMc37JiUTAVm/0DbFnSvNV/8Lr
 zaY7SdIhN6KAm6TeZlA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX9F23SZlnBbMQ
 dMpCIKSZQ3yVGh7pU3oe6VdBEWfHaxLbeB0nVP0iIZbxpXY5QiU+UNO1w8Ds/eL8OJjLeC/TwJJ
 o0ffz4HXU6fvsX+jgDrsqF7uJCJpvFw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
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
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 21 ++++++---------------
>   3 files changed, 7 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

