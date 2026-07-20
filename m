Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7DAC44529
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlu8N-0006DI-NC; Mon, 20 Jul 2026 15:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlu8M-0006DA-27
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:58:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlu8K-0004b5-Lr
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:58:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTaAN3397290
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wUE09qLti8Kz6+aESjhGCVpqOI5ryCfqpP1dLEI/3LI=; b=X2jR/RvLyP5wrteG
 5asUG9onnbBNNOr8XfoDGSyY4/bmJ8hw6/5caIr3cF0JRj4PCtXHvKdo3sr8z+yk
 AMbm6KJSzyZZcnIeg5to7DcoKpSRY+WpwDnYf3zzL5nJ+/TOKgubyxzDFDukqS6s
 /xDNmF4AyJexb8M+I2IFDEiuLolTYtIFT6A8Z1suYQc94rXtZEXsiTot5ZHmTSlY
 3cFFCU7O3l9FDSjEWbHnVRsODJDbenLhFGbCj5t/93fKcq6HA1J2N2biH5T7J/PO
 BV68Te7TqNAZDXGaRLGt70l/g12vOiiTbahpmsfKsM1BzDA/rtHl9LZA2ZhP0Key
 vAPxhQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqvc8pcq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:58:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so2883193a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784577514; x=1785182314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wUE09qLti8Kz6+aESjhGCVpqOI5ryCfqpP1dLEI/3LI=;
 b=EFrLCQttAXWi+JV30bW0EFezRY3G7YDWMX9adFbGrk8L+9Lrsph38xI1jVPk+i9Nop
 w9dFig5sYvTicVFYyoqwccqbegFmeMazrHt/Ew9X+pWOcB3V9dtuplTJufqZdjXRGdd9
 n5oGPgWB6xoiX1dN4GWElE1AlPnm4oUd5BcvyS1KCp9GrOeTZdz6fzq7cJuChk4BkEIZ
 n5xsqUfF+3rCjN+AiUMkdCypk+5b4J65OHwt9kdhuLe8GwSwb7VOm0m3TB/S8wO3Prn1
 En5iU7OacSkW5v8rb+zhYzLpCI9cmnLGantmmWtUrFWby4D6kB6xuxYFX8nZixvMsVpm
 65AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784577514; x=1785182314;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wUE09qLti8Kz6+aESjhGCVpqOI5ryCfqpP1dLEI/3LI=;
 b=gqoBwhEANOw2oosIAUqbtjY1bPeikisRiT2qI9YTOsJNhsBx0f/lmURPefUAv0dK+0
 5s3h2mtVGjRdO5aVwWIxoPUy1qNZxNVLHR2xVofw4dX3fR6G/SLx89TqiBkrhcSeF0Ej
 GGCP+MqKBDxjjJAKqGfoJ7xQNZCQ88LVe4Cs3qWRbwaGyiW8FBhgNa3U9iILxAC56273
 OJAPXvAKE9hZMFctpHgIthGx67yW2FgTUYDoBy2XWRS0yK43hi4MdCeeyTZHdt2fpUkx
 wkC8DFeKNrvPIH7Qy4utMN8AhvQiA8cHh30sY1dsC44lQSvldlOLMiHj7glbPi4I1XtQ
 8O2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEnkB5gUIbgYo2SC5VTAHcSOUReRCTwPo25hkENhaUnoHOqX7Y7HFcEHsp1t9L56e00gYCSpVtdujc@nongnu.org
X-Gm-Message-State: AOJu0YydlqDYO6120M3PxLlACxUEDYEE+IX7B3ni2hjtggU6kiugzLR2
 YHtPKIpd2h1KbIdbuzZQabgqsmE+TE3sddu/IngbOmN/PPSdViygMuzFY3y1q3qDOl9aMIcB8/d
 AiVlc+KBvu8VQeo1YYaS46FU6rhAppyuILtQWzim0HU0nYV71my3hlKvUtg==
X-Gm-Gg: AfdE7ckGEcgwkyIxlcVbuLv6mSQgU0ujR2gB1N/aWXFWwJU4vR6W8NrDJJfIYqaUcDr
 o4VPXP1oCqHZPNeD9W4ki7PkhqpFqay/4AA6gf6Fv9N2Ka98IUclfHmTTQIXDECidJfAm5yJA9u
 h73uyOBjISD0PcwrO/yE2bc+H2+6oiXkXyv+Ak6vVcipMjGyNy3actYf4YIbJsprQh6VsbTLNOJ
 nHiHV+xfOzbc+zdKM1CkaR0PRU5irl9kAf3/RYjd1PGKpqhWkWA4KcZ1cp2v7XDinDfaexW5Pyk
 18vuCsLWKoKtPEVln1gJpmAWe/vGYHj7h9drOv/hhmxaHEwI2NkCdUMsjT5Gn0HfrOdypUQQeo7
 /zh32Z5GqTX5AtGVJ0cp1dhAJFnOKc9QcYFs1+BkDFgoWUlKooVMdy80mOC6+Muw4A7+s
X-Received: by 2002:a05:6a21:e082:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3c38dc7b38dmr20803770637.39.1784577514409; 
 Mon, 20 Jul 2026 12:58:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:e082:b0:3b4:8c67:51d4 with SMTP id
 adf61e73a8af0-3c38dc7b38dmr20803746637.39.1784577513962; 
 Mon, 20 Jul 2026 12:58:33 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce29ffb13sm34012307c88.6.2026.07.20.12.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 12:58:33 -0700 (PDT)
Message-ID: <bcba56b9-0ba4-4e03-b521-c734e0b70eb1@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:58:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/tcg: correct why the magic syscall number is
 safe here
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260719074730.1520517-1-functioner@sjtu.edu.cn>
 <20260719074730.1520517-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260719074730.1520517-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxOCBTYWx0ZWRfXxAMS97LjACCd
 gmTKu3XkCOlLjGMgR03CKI52VC+3wisT/bu0S7Wh0o7+bn072mENfBrAE1Fa72G6VuwDPgYrxvY
 Sadjw4vSM4EmQ3EqH3YdrLgI6EfCthc=
X-Proofpoint-GUID: IsuK50zsHEwohKyyuNykAXseFgUAuaGj
X-Authority-Analysis: v=2.4 cv=OMYXGyaB c=1 sm=1 tr=0 ts=6a5e7deb cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=5TLrA0aiRsUHPPCtNbkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-ORIG-GUID: IsuK50zsHEwohKyyuNykAXseFgUAuaGj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxOCBTYWx0ZWRfXzRFoFsajWmte
 cTJDsN9gJysqQcfdG9yADnkJl5F3qRVFD0m1yuaGHx2oH3bzR8JG1ao6DmMxosdxa+QLmFJUhM1
 VMztPMs3Xw7P23Kk6J5avCcbV/YCd1EKjGtgofFBC9JGpzmaby3sAXxilmGuwucdfwSa/mnvqOa
 h3LyK+RaJ+qlYvQKU4RQOjbXuloAKzxwVI5WurvaIERfPbHCPtPowJrp2jjRGq1LC6JEvtmOeH+
 rwMf0/0F4fIYObYzzKCTTLQzTNlj7T5iyDpanfpduJp9v6bdZX42pOEZLRfRAbMU9oC8VGX7GVL
 XfKpYp9qx4q6kwTDabhxtpOV8y6b7eMU2hQ+smMqHjTzcy7A5S8fRnLGWr9IY4FcpwxNUozVY4r
 WLni6ccp15+qgECX03oR93LhVrwzlkKlBRz70vwHBhaMSd1OwfkmhlDQtlb9OR8rugW+HXHaIzO
 RR1BW+KbNTIRxX4CNAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200218
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

On 7/19/2026 12:47 AM, Ziyang Zhang wrote:
> The comment said 4096 was picked because no ISA in Linux uses it. The same
> comment already notes that mips 32 bits numbers from 4000, which makes 4096 its
> getpriority.
> 
> What actually keeps this test safe is the filter, which matches on the first
> argument as well, so a real syscall carrying this number is left alone. Say
> that instead.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  tests/tcg/multiarch/test-plugin-syscall-filter.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

