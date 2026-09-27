Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B02DC9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:59:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqLI-0005D0-H3; Sun, 27 Sep 2026 10:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqLH-0005Cr-2R
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:59:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqLF-0006OO-JJ
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:59:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QMHbq5882838
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MPHYZ9+TTXhn7dydHh2D9e9t5XpnIrRFT0K1wVKLxoY=; b=K30PUGdY18z5tZhf
 UWdf6W/yfymMK+gwwMlJ3m0qydgdKQWfNmW/zGRSbP1RX/7+75l8epjPrp8NjRnd
 /ITC7oMDmVjH6OWz2bgOAz+JDrblCYj1Uu45LFPmreTm4jlVRxClP/8GWo3gAK2/
 nAvgqEadjJKLRbr3WiKJYFNAcwhv5XSuPQfXEqYk8lU0O52Lh1LNZO5x8TV7IEM7
 YKiULRMtYNUEFOs3uGVpKSmtbm+gzv3B7Dxxf2SUecfpk+dY139KF4AjouRDgpSr
 YvyW9jW1WfVo0CmoeybM+rTGIjlHjrN9Q+efnuqpRYZBa4OTdTGedh9fPwmCfimh
 aRpV2Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp3eyp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:59:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93c444b438aso485692685a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790521139; x=1791125939; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MPHYZ9+TTXhn7dydHh2D9e9t5XpnIrRFT0K1wVKLxoY=;
 b=KmeksjTyc3RmaxNoYgOIJ0SK2excyjNXYZeoygD40e57m9CKHDTjvMWM0MJ63UtUmg
 3U0pxOiONcVwnXNwUiwuhNCyLzQ6E0FKHZEcXzrZCVqYHNQrKY4fbfbv5aHjlZFLHPyq
 //Io/zBcqKU4A9Y8+bFxE/qfdg/TBvpdT19AH+qN0zCcDDJ1+wpvwZ65+tUnvtfZd3iV
 UQsLR9hpMXZRpfkBtO1FRgzuYlOzjRvynVg7OXXeUASTT338ByBfg7u7sKV6SsEfvxJK
 lm0eHC3av4Eehcyvg28LZZFEOwDMmx5X/GVEw4qdo6n62SguKS9trnhAIhPbX+WkFSS6
 6XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790521139; x=1791125939;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MPHYZ9+TTXhn7dydHh2D9e9t5XpnIrRFT0K1wVKLxoY=;
 b=mX8kfwy7klCja/NHlAKIbj3RKHpmbHrKPHWXHgwCwlhQM/rIJvXnDfxFUp1pIlia/2
 QfKK5TUjrybqCRW58ApxgOWkny1R/+SoyEcvR1KICPGWVSB9VMqWpiDZj8WOCVlpEal0
 DDCMp4MJSQxhwGV/porPSGr7C15uadTEIJSK/Ib/iHXUVTnz/GVK+TMcaAnHuAqXQfz8
 DlOx2N4670uPbvTY1qLkR2lJnzFMa9qE5tECtTqp43eSmdELFOyed7um4i95EvW9skvJ
 XjxQUKFXeaHos+ENFSR2aH58IULGLbPqPQnnr8RuVzNRzkrETpSi2pMKCNSEthT8SgIe
 N1JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7pcDLipqi0OMUC9xf8say4ttvCMkADUlntfeooUOA76Ehsfht05VHlv7G+2shpmdEYyY0/6aCl5bH@nongnu.org
X-Gm-Message-State: AFuF++lmDK7DML/ht9QGfHu+wyQN6/idBUK/h+/pN9k3e/rJuJz6/rSe
 9YlZ3R0C9yt1SQ3EgjcTuR1A6Lny52k3EffCJhl/PCvBd/51Q2g6NrIPOXoywyXOzbIlTZhRfLy
 V/LK1roWb/LOvjHBtEdEr3D33V7UhEqNBdetgqfh15+f/matSfpDOf4eshuqHb+syyA==
X-Gm-Gg: AYBFou0c1Z3gIegWWVjbLjfTs1srXvJv4vg6dUgi2TnGff65t5UqXimehyE2sFrnioS
 imQ/ql1U2HnA2hFgd7WDZ6pbdtYKKEbOhYFiSzot/ebXnn5VS8tglLojY5gOQNb17yUy441k9Xa
 8Zpb/9jVqo98KnvO4NR3O/IrwE1cSgiD00i3VAX5u6rhKTDfWrxdQ+6uIbSqKb0+NZ8eK9ZibE1
 tTDlbULlxbv40c9WhFG/xGkGOUrS8hznjiiKa7K68QSnKW/UsJvVnX3WBYHI3xtu6UIz20jK3ze
 d7kzBkMalXpPQbNjj0DKgeqFitYiRbo2EZZFm+z8rGMC/HW/FNIJjo/uAJoQzJ6HY0mWCp1TFMx
 1LnoGEzIq5Oj43BKt5w/DKEwA6AahTgH8Fw==
X-Received: by 2002:a05:620a:4623:b0:93b:d7a2:83d2 with SMTP id
 af79cd13be357-93c43d41d2cmr1572523285a.65.1790521139569; 
 Sun, 27 Sep 2026 07:58:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:93b:d7a2:83d2 with SMTP id
 af79cd13be357-93c43d41d2cmr1572519785a.65.1790521139125; 
 Sun, 27 Sep 2026 07:58:59 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017656cesm61226175e9.3.2026.09.27.07.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:58:58 -0700 (PDT)
Message-ID: <edd96338-d01a-4826-ab4e-311d0c184947@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:58:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 086/101] tcg: Split out gen_bitswap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-87-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-87-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX0J6RH71s/y4A
 AhU4zqdnOh2y7fq5RBeJuMVfA1+mJq88kCeX9v66F/gAvXf7nfUxcafSpDLGH1K5O2If7RCj/69
 v4XtxFyPFhxpyCN9XYaDhao/UbaGOF8BPescDrV5Z48Mu2URbc4gA/XOhSV4+CNo90QdA1IGCEv
 oWqdkbOjtyJ6UmSfzxs1S0f01kYurg9n3ZErHAU7RY/qNtaJyW+pUiVNFo6Y/eZUB9T6ozt6IvP
 N1xcPngPHFH6871DyyxLNllO4sSOD/cd15UEWbxKBxNCU6/BnLwjKJ5/jbTdVDWWm+5wGCSUfid
 TneKYeyLlwC4jsMk1CeT1I/N/eZ3LyencLnkBkZfrFIgdFyX/XcHRsODfdga7Dr0i7onz3AZSBY
 3JPJevy4TZC0YjgdSukHBVUHQ81fQHjnwqZMRCujAziEr+3bj0Rbfn7ifd0J12bCxci7yQkxx6F
 YR5KgA5Kq0t+MvJ+Cyg==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab92f34 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: qd7wdEc6Jo1HJQBBiPcyuNKabxd4ngCo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX8GQCAUpnojvA
 3aa3LcamPtq7PYQzxxfHADBhu7ROxjuRKtRcsNL89stDJ19cLpYzaw8AwF/JuJnMhKB6sBeRj3n
 1BGFRR49YiCr+7hCwWacYEYTQZxhUEE=
X-Proofpoint-ORIG-GUID: qd7wdEc6Jo1HJQBBiPcyuNKabxd4ngCo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
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

On 27/9/26 10:59, Richard Henderson wrote:
> We'll need this for other generic expansions.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op.c | 58 ++++++++++++++++++++++------------------------------
>   1 file changed, 25 insertions(+), 33 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

