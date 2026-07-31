Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8EC54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpr2m-0006Z1-IH; Fri, 31 Jul 2026 13:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr2g-0006W3-HN
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:29:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wpr2e-00058f-57
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:29:05 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFO6pv070877
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6rBaOcxyeFVt9MXzBWnKjU7Em3OYiCJKsFHsSwopgY=; b=XsHWlUFr1wWmdVsj
 FXG9LP7+RplhY5wk7GJcqZ3+DPmWbudyA8k+Wlhw2++ogeEaIi8i9km92sMVdhPo
 yqjUwzWyk25mT7u+M2zZva55+VlrTq9HA/dcDCC3cTfJG6IVNyuFjg+TZq7HI8PV
 7Luf1HDZeBuLoQsmH1qs5rXF82hcU3bxb/e7fR1+BQwM6Cy4UTQDCnSVlSi1FA52
 o4ybNbu6jwbk5D3sFjvtJjNkusMFdeUQbsStr/o+USHdWdXqSzqPl4nhI3ieRUBs
 Yh+MTZH+8y8MUXTLkhWFTAzv23q2KKD+MvRk57Ala9+RNmknCu/5I6Foq3jPt4lt
 ILwoIw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frtyqhmt3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:29:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e667368f0so2103776a91.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785518941; x=1786123741; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A6rBaOcxyeFVt9MXzBWnKjU7Em3OYiCJKsFHsSwopgY=;
 b=YMnoLr59xL20r3BbAg9XoJ2UfNh9RcPHKrOF6iD8J+JwWfKYmmQGTw7r6ySpkpecXB
 jmM58r9cEED9Rz/eMP/oqce7rV4Z7Ke2NE5NFidNCipDXJAJYDL82IUdrMiDGcPAOHiu
 cthc/1VkAHjncPACWrWPfKT2gbQYrqtdFOkIyng3Ri4a6hBKYeCU6JvyH21ABSw7HWvt
 2DHbCc7X4i64+Zas7uRhfxTfHext1dYnMAYV8HqXcDpEgC1xq9KOF80KDHdEeiOC1YK+
 qFcaI3tobTRC6LhAypuFHECJottQsqsj9wetdIaTKfAF/c/WPIkmzjhlFOgt3AExBsOl
 A2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785518941; x=1786123741;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A6rBaOcxyeFVt9MXzBWnKjU7Em3OYiCJKsFHsSwopgY=;
 b=J6YrM/QNdpqxxVYl3GosUppmimgDXD39rmNKIJuX4jdBUrI6pQuYNJXW0arPIueeWh
 RO6tvfX27Z/CO1b5pEJLXKADrLcFaRXRRcahzz84jf+gUN75tjht3eAPGhQUhKjffFlJ
 6QVJIM1G9IT1VCifkbK9yNY+sgss5iR1BhdJQkcQPYqUBDZ8zS9PnKN8R4MhLm9Ghtes
 MBh1MXCLNZ2udask5A5xQOKWOiOstq8bANuV1BJHlJts6Lk5aIPsjYJYhRlHqf0HWxkn
 fgwEpUncK40Yrg69AF2zsmz7HvBHT6Rz0ncKMxjT1oT3REjvUVGhY5kJ2/INlYqr5UPT
 zsrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqCwBwuT9W2GT5d59QW2CLjMdZavAkTyWACo1J/RODYYJuD3nJVBkg3gdQPWEzm8hgS4s64PYxYWCyR@nongnu.org
X-Gm-Message-State: AOJu0YzdylFKTmNx0a+5Gb7F9mXbI4m0o5mZuUKj/AUJW8Jn5rv6FLjn
 j2uc6RSfIbaLU7+h29hu+diC6+XGe1bfUy0om1/5GPBlq85ufx9Yd9KoY/+26m/hRp4JXyN46KQ
 NvzhTdUPDtNe0PR6LJguQkj/qNfHnimH6BAlMlH9teBz080qgRmIMOrj7qw==
X-Gm-Gg: AR+sD107T42nUDNIuJzc1jRw+CnqCczaTumWyjYLjnZGKIXIPpQkMZitEUmWt0UHc5s
 5lQS4pbNVkOwOUD2zfG3KUQj1nDkki4Ca8FhrmmkunZ8HF0vwBp/8yWGrHF60nXjaXLZQIm7Rx4
 I6Q+vJ1csT8gfN1DdMS0jiovFjzBHxQt15ft+1xtFRHSRa3tVxRUX9Clplb/aBfidAGHaPIIsId
 WjzXJDydEsSxD4sSAtHim4POf2SIFWY7UFuJ9ZQllZ0PtIzshm5Zs3UYTWfUU+uiF1OKoITB557
 7qXJ8i+yhT1/N6sImX3wchoGglq9fW9UlCzj06P49esbW0lz19JbQ2QLHDJJdk4QpqNQFJKkNIE
 Bxr372ErQVs8VZKv0S/yzP17SOAhdPQO8MnkAHvTktXQYOM8reVNIT6cFtuVhp3bFMxRV
X-Received: by 2002:a17:90b:590b:b0:387:e0bb:57f7 with SMTP id
 98e67ed59e1d1-38fbc5736a3mr736669a91.40.1785518941401; 
 Fri, 31 Jul 2026 10:29:01 -0700 (PDT)
X-Received: by 2002:a17:90b:590b:b0:387:e0bb:57f7 with SMTP id
 98e67ed59e1d1-38fbc5736a3mr736632a91.40.1785518940944; 
 Fri, 31 Jul 2026 10:29:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2964c10sm1016460a91.4.2026.07.31.10.29.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:29:00 -0700 (PDT)
Message-ID: <7a97dc08-998f-4deb-9d96-9f83faa12799@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:29:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/18] hw/hexagon: move VTCM to the common machine state
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-3-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-3-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfXyb48jTvv3RAc
 4/8KVr9GwLmG8NZiBHBUyNvJN8YhedH9TMsYsXniyfEHisYfqqJp9W8pLWVCAkLc+sTy9EhjGb+
 IiDG/YJfGfnecAjWC/HOjota+ajqloKTGwQEBzQoe4fMnkkf8zMcQ23XoezbmQcjo/SMM+ZSFbR
 D9aB2MZj40AXSf7vQ8ch4f7wP8uSuC/0fhpxXgEi7aY38vooB3uLvLaSi8pkNsfFPYoJNLVhkCO
 +VftpavSzSlUPBuZcVuFgx8mCKe0/4SpQ5FObnRBj5eI6CeYDb4rbOmMsDrV2sj7dE3GKBA8e5k
 c/aPXN97rU2YRu0hFQ4cFpCJ0MdIL2/okp5DNe+RB/nKtW1kSEdohbEJzDVuKbMOjCqkXp7h2fT
 nn2YKHoJ2+DPh1zrf46pwbynr7V3k5zhEa7Ik1+yoY7sYXSP0Rd4g4lFRwCGtfO1k8wH2PeAGsG
 lpOEdyF5UDWI0uCx/EQ==
X-Proofpoint-ORIG-GUID: Ve9S83NE50Ie4MtJ5-7ZPY9MeSbbx3eM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNCBTYWx0ZWRfXxPK7HXEF4ng+
 S++8ocERxfM76YYsk3J3zWXyZsm8hMuXv3Qa9xqPwYYHwACpZQyTh3ImeR6aqv5wvX+OEm/DaYa
 0JoqpYqa2wqbZ30bNA+cMvC+VaPD+kU=
X-Authority-Analysis: v=2.4 cv=YaGNIQRf c=1 sm=1 tr=0 ts=6a6cdb5e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ZLA3atObecZe6dELdc4A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: Ve9S83NE50Ie4MtJ5-7ZPY9MeSbbx3eM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310134
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> The VTCM is described by the config table, so every machine can set it
> up the same way.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  include/hw/hexagon/hexagon.h | 1 +
>  include/hw/hexagon/virt.h    | 1 -
>  hw/hexagon/hex-subsys.c      | 8 ++++++++
>  hw/hexagon/virt.c            | 5 -----
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

