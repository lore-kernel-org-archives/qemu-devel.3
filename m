Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452A5C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAquF-0005Nz-MR; Sun, 27 Sep 2026 11:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAquD-0005Jd-De
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:35:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAquB-0002ZN-Nh
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:35:09 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQcm4013820
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=dJj76bBt2zHLDC5S
 Jco3rUU8oQ0AzqQe1wwaMkmxmGyE2UCCCmjR+ICfGsuG4e7OBJQnlHQSq4/3Nogh
 GYiXl4o2jJnG2q+jXMrnwVmyesV/bFU0ZI5hEOsXEIa9mGSB2jBRYMWklqvBoKjb
 8CuHlKAYT4J1W0nDBW6x6xQ2CRGn4mztjPxOgjpr0ADYoSRmbnx8fGb+8iy90Bot
 pULIRa4wE6u/rFAt7pVyPOyLUP90ksjUab1ldVPYOjUYfaXmf5YnAbS/1oRv75DN
 78VJgodHRKhvjQAx379d0X2TGKVa551Vkt7an2eGvviMZazISagXgiqGETtQpU5e
 JFBEOg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tek474-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:35:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so647549985a.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523305; x=1791128105; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=YOpX63Su4//J8oKeW2f7QuPEgbkJ+AZJUoF3wNtq5roqQ+u6xwzLicGa1An7aQQ/6E
 38iPr2vH0NN0ilxZ0CyM9fpF7yN/5wqhwgs0u3X9fHsGun4KI6V2KAKR6N0LfJno4uyp
 +3nLF10lJ2CSGu3vlLqDVQOKLJsDIgMeQYv/O1zx1pg8QAKFmrpnaL3HEWpLjXN6QKHz
 jyiUyWUNVdf6WrZ1tY2EsvYoB+FEdIlRciuODopJAIZUffDAzZhSp8joabKzWXuVJBQN
 SAsO1/tYdv/knxcQIJjEiDBfWwmTpK06/b1jLy2n3TNqpGzZkO0TyJxrgXhdB11LhQDR
 3Oxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523305; x=1791128105;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=pXodDbUb9dsDdH8yGZSNfJVv0rg8XlQGy3/g0YXfmPprV4oxOHzsBIHXUWcOaSB8Rz
 wy2YgXHxnVk9Ufqlf2OOk9OgfZ0V49h6SLBsCTmV3VntYB8FU/Opy52x0eIlIGk2t5xk
 mbRB3v1rqIGdDq/TqUKFuJl3OWi7IjP/Q4a4RLTuDUz6OB8e+b61/Dnmnvxti3hquBGd
 KL+LjhgwwC30AapgWnl82C5FxAmIKnGdjmaPDbcx90Ryix1l4jYYJlD8z2g+x8WPBLfw
 9diywS2+wJfBPp4fg7Y//GJwsl4XwtO4QOeIiYHT+sFyW9FiSbKGe8qNrKEsVILfHZPW
 I1rA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwS3mvcSQP2BdOmd4TCG5B2lFHd0LXtS+Xjo44mw1em6BRYptRBNJHdJUUOZkSd9y7j7cqsdAJy7NNz@nongnu.org
X-Gm-Message-State: AFuF++nHEhPCwyEQ1SmYbFRZSoMFSL8bRRN6f9ehKlCDwltYfIlSdD1Q
 6gcMvhFVOxerh+s5QYBdZ7zYw6qaynkNye8XWN7T9GR4Xlcf+MZMb0strf53tGo5FskvoZRMZkc
 snqgP+rf2uCZA6o3wTeTBxP726sPpnOxHlxm9KBEd71VJzAxcTdCdYIsd4+xqD5FPqA==
X-Gm-Gg: AYBFou1FkFUHxMc2LEyMuBshLXVTHsmArY4Lv4nS02UppHkOdFmosa3S95N+snoO60V
 wQmXLeMyDPYiv40NEr6ous4uKxyu0jJc+vcVmumBg6zKzWf6xJ1Yc/QS0yJoRnf9I3vBOuuisWi
 Fl6uo71zsBf8jao9qIAyz/68TIm+ngDTlW0qTgNFCzLtxw6dgvUB8oDRm6Trr+BBNHIuAo6ZMtb
 q2YcY5abXwcLfAbKoR6x1Muv2unzabP7SUZj3ZU0OQNx8vcC6/nuxWXP7cC1wFo/bzsCTcxzu9u
 I0qqm7VRqDEmI4HuZGW1onf6JW//9iML/QDzKHMC17b0QX2me5TWu1IKcFxyXysvQ9R6mnCKNFg
 ElnG9hF2txEZ/MNCU8FwdP9SUKJV4JEBGuQ==
X-Received: by 2002:a05:620a:4012:b0:93b:d7a1:ba11 with SMTP id
 af79cd13be357-93c47555a91mr1420852985a.60.1790523305095; 
 Sun, 27 Sep 2026 08:35:05 -0700 (PDT)
X-Received: by 2002:a05:620a:4012:b0:93b:d7a1:ba11 with SMTP id
 af79cd13be357-93c47555a91mr1420848085a.60.1790523304499; 
 Sun, 27 Sep 2026 08:35:04 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fee9203f0sm143206255e9.1.2026.09.27.08.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:35:03 -0700 (PDT)
Message-ID: <d1f2da98-5890-4925-b574-0258ec7adbf0@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:35:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 022/101] tcg: Generic expansion of tcg_gen_shr_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-23-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-23-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX5BiDqEcd5zpl
 9qTL1V3HSh7B5fxOFLJKJLPJwrFoGGPPvxueS4TLQLM8w6oi9PMZ6blQY0oppmukuSq6/XNgJqi
 pQx3A1h4mR2mvz3VJ5CFFNHX05hKpAYqvu0tGQ6Znkrr4sGyKogZksd7AJzwQtliwk+RP2qixOH
 D2oqtviMMYgQQOGMGt8lTA3hvZDcZHGoX/NkNO+h2NdHAP6Ky438XUst97sM7fTqmf6ZWqGUqbN
 PfygV08mRyHYeudSjqjo5oOLbqb+V/YxyVDCrtbygdsXYasX8apWqXrBI3tbRhN5DfPM65L9pH6
 Vl8y+hiUEjkX/RGtduaom5nCUVan8n2ugWeKlcNex4xv0sDJNsUe1cTXpNZgLmttb9ogyKnaZtN
 92XDw3X6eoG2BsX0NswdUEjhfJjKI7QzpRNC8Vt/sEvN3+2a54EA/09Tx7P1cvWU+hbgfm5ujP4
 uaou0d9hq1Gblk3J1jA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MiBTYWx0ZWRfX9ak21WQjkkzX
 yl82JHpPeE0XRCX5qSqGwfi3izP56TM96wNZQxYZnWsxLJ+G6RVIDO0sA2OVFZ3fw/9KHlXZYKE
 VPnyLcyZdsvpiwr6K3fqXzNqmzVC4uA=
X-Proofpoint-ORIG-GUID: pbGlGBqQjKsMt2nFN9hRql34F7vSquxx
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab937aa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: pbGlGBqQjKsMt2nFN9hRql34F7vSquxx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270062
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
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

