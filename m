Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6257C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjKsg-00005C-9c; Mon, 13 Jul 2026 13:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKsf-00004t-9T
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:55:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKsd-000517-NP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:55:49 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DH6Orq2191587
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0MY3yf0Xi9XEtxkuQyValem6kdNfO6JHvltZ7/yI4cQ=; b=oIqqlkIo0bsfku2n
 DLXI1ICKFXfaWt1zioZ6HcNO7gVhk1Yq4MMsXRR5AFlmjWndJXUOyG7OPnu/NHR5
 7ZQMsgop7K116nw2XIK92jC4elMFGK1jdlvwHGJNZc+EnsnO0urJDtmNDiu8+u8V
 eWJ4TA2g40VgSpP244nMsraT5k5YPJnQ7FAfmbBj84vB3EKou8rOYFRxcRL43rD5
 yJ0OP9faTsQbyL8hgwivqKrWDY0U3Ig6v+gd+M5SDDkntPEjqCOGgKA+cFjdLHIB
 D017Ism+VLzzzK6ixPHIfM4Vje1nAl74DYbXQqWR66Oz5Ihhk1N+8HWq+Ywl/Oe+
 p+rbOg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44jr60y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:55:46 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88ab059052so215782a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783965345; x=1784570145; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0MY3yf0Xi9XEtxkuQyValem6kdNfO6JHvltZ7/yI4cQ=;
 b=crZCFUnhaLMbTv5mBcUWyjR1+kar48TDc3z2SgdNcAJBLPPIiXF2ZLW9W05DJG7NqU
 j44iPZHcJ8l3Lh/Ju5iD5x5vyEu/frEjQpGb8GRMZRfRkIy6hsNSfkpwajZ0KVmIsgXo
 Krx4dT8KwyfiAtq8pU8g1c2IV9EKMj88WpQjeeLlCdZQjVqDLjWIpd1sdhFstPslXRPN
 yCCiHsBmiTF8pwTggZwcIOkyb0e03YX4jrhXxGoyC+R388fmZAW23MiKVZeQdIR4kj8c
 Cd88fX+T9NKP3s14cYM7G5eA4+34Q9k5D1XAdpXXp53IYbq565zuN+TtVfQbKjjdij0R
 DsNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783965345; x=1784570145;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0MY3yf0Xi9XEtxkuQyValem6kdNfO6JHvltZ7/yI4cQ=;
 b=gwBf/XF7G9G2Uh2Z7VF1IoBayLta4FrhQOfVZZaYaYgUInsYJQdH2NTTzlxZ1/87ip
 04dBIxUaN8m8fM4vewdOrn/N3rSqrNt4+l9yG+oQ+C2B7YGKF37I5Fi90qSeHd+7zJ69
 plCjKX0KjAzQbSBhurQj3jIE/AZTNTmxBT2vVLJxLrSoD361CX/eBMWg8JHownWpReTy
 x/HHAhR8aW4ifEz5lXqD/VpgjXGbY33jGYKS9PDszzgA/4mO+NATfgq/5ix1X5rloeqd
 EsS9ev+eLoqVfMltnanvsEE4qDfo7ZMK4EVas4ZWcR48S6nLrbWH5H8iKepqZ1jDoJ4F
 mb4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoW0xs+6fsPhq++Cnm2GpDidwENg9pGB4wNZXescA01gB6jXITEAXMO/MuXTK0UsYE00mDDQzuRtHjh@nongnu.org
X-Gm-Message-State: AOJu0YwhxGPKcDTnqRjAq89ODiYus27PQd+86enw2bXgl3QKSUKseVBC
 d734W9Wz8MLU0/KmdqMDU9kfQju4p9nFDd42Qti+7jDpQ93FdbV33dkvIbQMnw1RDmzVcLTdAzp
 N3bq/Sr04w5rWjChOUvepqrNzE+7SI58Dzi8ij5nQopc2cADn81w9Am/DopskJNO6ag==
X-Gm-Gg: AfdE7cnwX4D5/qmCSbEXMuqpnI8dpFZlKTnucQmsO3M7zsdu7pHyeXdukmwTrEE/fno
 lOowF/MxBnd/GGWsLIb4eZ/pEkZiDlubnBJJca6dMK4km9Je8/H+KVeQkCxheGXR2juP01YQioT
 IU0d1gsvr6/aT4BFybFjcKCqwsUfHC42KN4px/DknC2ushy//IJYK4XYmBNkwMw+pG9AgmvWNEu
 Jp7m57vNJHAAbU7rp+L7RKCiYJnFlpgX78xJbtaW5Ge0f3EXjk0U9iiA1M5BL2NXBXeMZc5LMRC
 nIMcVnG17jJjVv7yuozW6CS1S/Btu1umBpitcbCBkg9E3cCtWizAb6VvYhq9L0m6VORgzrMJVgT
 +qggRmybwrtanFK66ayAe5ZaZgsQqB4BXMWduTmyS3/duv8KrVR4naxSid8WJ+WkCwHTnNCaLdb
 4Iq+s=
X-Received: by 2002:a05:6a20:a104:b0:3bf:ecf8:abe with SMTP id
 adf61e73a8af0-3c0f049ad18mr15528028637.0.1783965345555; 
 Mon, 13 Jul 2026 10:55:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:a104:b0:3bf:ecf8:abe with SMTP id
 adf61e73a8af0-3c0f049ad18mr15528011637.0.1783965345124; 
 Mon, 13 Jul 2026 10:55:45 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b9a67c217sm14486002c88.8.2026.07.13.10.55.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 10:55:44 -0700 (PDT)
Message-ID: <609da4c6-1157-4f71-83db-31478e98bb7c@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:55:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] tests/docker: hexagon fix podman untar, 22.1.8
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260711185433.2021691-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711185433.2021691-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dODBlVaN8R_39h3K_jOTmcx-YAgh0j0F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfX4pCuCl0vBn5V
 ZYPznO/nJDdFa6RXn4OJn/jEf/j6EraIcGVaSsEQhx3pUkhoHPlLViHC8MwYbM4hStLF+vGc3uK
 5qja+juDw2UVvA2K6BG/ALOGMJlTysuvUpn0roVMBCBcThu7f/OzRVlbVT4xas3idgmihrYzggs
 Oqg+6CmaPhTxJWroE/V4QXHy/bgG2+R8RXQXI74wGBr5lrHonfqEwif0qOrmUGHakP8L06/4v6L
 4N1pyMarqxiPTivy87e9tTMFe6DqZbeqfK5tRa9SI4vBzJoU4AQ/ascJSwjizkZQ78EepsRlpGY
 SrpFjajVgBKYsjuMIMOHWoh0kWypmIPwx4ECX8a0O5LQSrVbxkavUbaQtWeFqjhHd/N2Kaye4dy
 jqQrUBiEeulJZltmChZIBGfj5/u8PhB+GNm/GSfjLGYGwaLKd7+Zf9HEh9e0BZWZYN3g2VV4Zmz
 N/DYQ/hEbGTJuqIoDQg==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a5526a2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kNvxLDztv5VAn86OOfUA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: dODBlVaN8R_39h3K_jOTmcx-YAgh0j0F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfX7LJgaCeEgkZt
 V3SXIFMd8wD+GGO0v3zEDwxH1+wy08W8jcdeTfmyFd2f6raRcRMw/lFiRbbAOEjNlmoHTRlUoAD
 EmU2W6o8lHefYxj5jR0kmCHok1Y4Zt0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130186
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

On 7/11/2026 11:54 AM, Brian Cain wrote:
> The --no-same-owner and --no-same-permissions tar flags from the v2
> patch would reduce some of the noise but not address the lchown issue
> that was the main cause.  Masking the failure would have been effective
> but would've masked any other legitimate failure mode too.
> 
> Instead, a new approach: use the .deb packages provided and avoid
> tar/podman interaction altogether.
> 
> Also -- some Hexagon compiler bugs fixed by 22.1.8:
> * https://github.com/llvm/llvm-project/issues/195495
> * https://github.com/llvm/llvm-project/issues/184531
> 
> v2: https://lore.kernel.org/qemu-devel/20260619211142.4126199-1-brian.cain@oss.qualcomm.com/
> 
> Brian Cain (1):
>   tests/docker: hexagon fix podman untar, 22.1.8
> 
>  .../dockerfiles/debian-hexagon-cross.docker   | 27 ++++++++++++-------
>  1 file changed, 17 insertions(+), 10 deletions(-)
> 


Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


