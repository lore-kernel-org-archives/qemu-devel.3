Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09703C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7xd-0003Pp-2e; Mon, 28 Sep 2026 05:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7xS-0003JO-La
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:47:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7xP-0007gJ-RN
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:47:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9MLwP1196202
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jIsoFeHHvaY+Edl2Fhm97jT70PusKY9/fTCIaM081PA=; b=gsN9j9S7Y10+QRVP
 pGEwgiTngDHBLhWHNr4s3RseqQl94nEn5tvFuHitg7UMFLy8ru6wPLoiGYM4Iouk
 NFCKIXT8Q95j+5I7KDpxASEJD9sySJJ7HVW1dicATt2/PuZlyNClgKpZoigr7OD/
 ov/5MOpxqZC3ilmmxTyPwDcWuXf+50qpk5DMTvnvpHD6EDg2sBy3RoyB8Xw+4Vsl
 llgomsq0qz/U/h7dT/dz5LLRczszZjAPVxC9R8lPu8NXArw11LCp1AUwQVmgN943
 lytHg8tt609yPJ8kv8GkVSDEA5MKaQfGgC2+vUwvbBra/HF0rKyHzeNgezoReGxS
 hlF0Lw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyj2s0xr3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:47:34 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a183a0e93so625297685a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588853; x=1791193653; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jIsoFeHHvaY+Edl2Fhm97jT70PusKY9/fTCIaM081PA=;
 b=XK+E9t+I7xAwjju8z3O1HiLI3C+47AjN4uiPDSEGO69B+S6wX7HgN9UQBGNA99Tt/S
 UE/HwlBg0RY6KQWsX3A8PrbjdhoEeE6dpfx+Ig2kqORlF/2+g45bkfu6R95yISVrje+K
 u0gSYlp3boSVN0b0KuW5rr/e+mniD+3w3Ww0c+ETS0q8rT3R6l6kED7+Q6xW8Js2hGQP
 UmFolKMgTxkY25U61pjme0RmpXkv/30jd+2PnmgL2BaoNh497WB83xC3JGiwGJhOboUU
 IpB5KAZqN/89gIJz4qeY3BCc/OsB3iQSLBDDkizJcq8jdakxB0vES+Wgsuc5Ckg7CAYo
 XI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588853; x=1791193653;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jIsoFeHHvaY+Edl2Fhm97jT70PusKY9/fTCIaM081PA=;
 b=PtwGSU+lezc5qDS9fnw5BnL0WCXjb2q2hgmslYMCJTJyVj/8KPn+BpKopuCLZ+aehO
 QXYH8Q4ORuiqYSXDvvU2iMRivPenIq92H4yZ0C/ApBjxdPDwV/ENaBFc+Uqie/iWD010
 KpOhhwRdyXf6zNpwwFcBbmyeAh1hEAuC35QoK3F95pCYeVRpOXfDjbbh8IsCEhzutzoY
 pY983eUhtju/uHKpD2LZ+eaRwg3uFHsY5FIDAzaNx3PZ+RpybByg1wtI9l/hop17eXhy
 7QZWFM2Dep3E0em/4WjzYZ/EIpkYPPSpXvkvzwC3VZ5HTF5TYgvOMYK2TGuGjMCW/LEU
 CuFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxviexc5Xxhxi4EgNyZYBYlqXCraVX3TTx0rfaa60/E0P97JxKhdo6ct4BtoQ5ie9kNbuLnUN8iFYVj@nongnu.org
X-Gm-Message-State: AFuF++lddKXSQdN5cmVsGVJw0Ylv4UnB9ph+HusfJ+AkEKaPkBjckwi5
 gWrlVtDtPiDEXjHey/ACcwQMrEaA4PcbneR8Sf1II8cgEaqTz0i5dFjXURBjnPXwEnCf8PvOXPi
 90N/7xHnmecMomscWTFk610N+mVrW+O/T6N/2pgrIPSUVX2BQSDeg1sUB01ZEpTyiIA==
X-Gm-Gg: AYBFou2gBrdifHc7mmwhp21XbDbjOEDSbfV6+RU2jzajfjn3CfiU3KN/h4Paxv6+wIR
 QdGZU9mGEVIdTDfSH1rdGpdxsOrKO3Fb+b15LQn/1DyZaFTF1XNfru55GAu6FRccGO65NpEEyah
 Kqo79ZQ+O7dOmUlEAPLC3Fhhy+pDDOVwvPX5JkogRd6McJ89lhTEcd/2bi6j8dk8prOS08iGaKe
 KpHW1Bv3VbpOL7fUpmJoj2n4FjUfHBr0BmcDp1t5qdMaBr2eSpH75SpBo671g1aPVK0nvwsX48w
 Z3RkjQ5yVtqO6c09stNaJKgOTXV4SIFzGCvFK6sutmE5fKwcGiShvPBKcdcz0uqp9hqVIL2AxJF
 mzwhyJ9frSh4U9YmOj/uyMooGjCY3dLx7Xg==
X-Received: by 2002:a05:620a:4621:b0:93c:65f2:7d63 with SMTP id
 af79cd13be357-93c65f27f7dmr1099623485a.31.1790588853205; 
 Mon, 28 Sep 2026 02:47:33 -0700 (PDT)
X-Received: by 2002:a05:620a:4621:b0:93c:65f2:7d63 with SMTP id
 af79cd13be357-93c65f27f7dmr1099621285a.31.1790588852821; 
 Mon, 28 Sep 2026 02:47:32 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a746c57sm25054246f8f.35.2026.09.28.02.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:47:32 -0700 (PDT)
Message-ID: <ba93a66c-7fd5-43f2-92a8-37db56ebd39d@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:47:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 026/101] tcg: Generic expansion of tcg_gen_shri_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX9yDn4ae2NCx6
 +6Pnkfee++EUqTYQdpe4yxSGgxQIJJgMjzm1RDzd/6RHzGSrxJnulk018/0d+TI5ofYSEcisjEq
 FgO7JUkVil+9DWuV4WtzscOwg/6a2XLvIPaXt0l8qAtWB6D+x8/eW16tWPS3HvIFTfkI6bPQndB
 Rifk/2hJggcnXDvWBl9MKara5KuTmsO3iBFMxYPGAubGscw7xdy254EXDvZIhBywb0llGOhOSVe
 HF9ol2AE8nYwEvE+tgmL7hRlI8NBPAf+L9Y3nF/fuCij8/L1SxBntK+qu4rnHsUOvsdCgyiTM+Y
 OzfyPTaExrSiEUH1BTgaKFxyTcZIpArRUM0DUeYb+XQ1FuFs5TLIy8WmW06kuZNFJes/K+RuNfv
 FaH+NB6ypYRi9OqJ4EXGurdP7kyOmnCWlgNEYnsK2IincN4RYc/7/jQMsysZzibJMO/NnNncUvC
 4wEJynBLMgz243FcnHA==
X-Proofpoint-ORIG-GUID: 6eLmVSozxt0LzMIRwcMOSWbfdurE_F3S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX+zO4Djf5svSF
 gTq+jBDDXsvfTixv4A5tsW8KA2vyddYKZSgPFAsg5WiIhNVa9qA7/RWVCfT5q9pKlg0Y1BGfbav
 j/Nx4B+Pf+6DFdJ3A6ZZw6LhjKhQ8jQ=
X-Proofpoint-GUID: 6eLmVSozxt0LzMIRwcMOSWbfdurE_F3S
X-Authority-Analysis: v=2.4 cv=TptzFzXh c=1 sm=1 tr=0 ts=6aba37b6 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280038
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
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 30 ++++++++++--------------------
>   3 files changed, 11 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

