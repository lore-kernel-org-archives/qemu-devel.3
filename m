Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D69C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 17:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjKrn-0007Rm-Mr; Mon, 13 Jul 2026 13:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKrm-0007RR-HD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:54:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjKrk-0004j6-Rx
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 13:54:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DF8Bor1611572
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XudDL8/DOlqgEpdtbTXMimingHtN7ympSyhXeOtKK1U=; b=PZWD44XpZP+VLv4C
 gBMqaAUiQQHZ3tOKyf3uY9o6FT7wlF4Z7KfS+jcVQmEmjnmj+UxLTQuYeabGEpYy
 zEjYj04vUj6GQWrsZPTYFYGDSrfJirb6HWgNzO1DkT2MaULG+CmmLcu9WHTqrLtZ
 RyaBtZIa3SsM4IIjCEJuF6q/He2AUXE1tGwVGV4PBoLVbGczWRNTrp+GqEKOQWHq
 XxCvfM1H05mb4zIAmJg/h6VPoyCmKgRjcVcM02048bXsglXPTGDvfol9QKQ3ZAPP
 2nJ1BirzZNdz3L5ZrDlZFuWsebF3pOS9FfB50hnNSZ+STKI4uQjzvrLqq72Sx83E
 a9+CBA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcw4qt3m7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 17:54:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848544a8496so148354b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783965291; x=1784570091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XudDL8/DOlqgEpdtbTXMimingHtN7ympSyhXeOtKK1U=;
 b=YmWi/hY8tIrFI6GTmiN5SSa1WzBFyi/2YB7nq6PIxd0HJeOtiyDnU//LaztaXKxc3M
 UNSlHi3vaGGRShNbri+c1X0CI9votC8bLUiJYffgPfYY9LNzetfIo8irEr+bJZYvcwnw
 O1CXLKP89bcGdJ7xMX8nNl79+M6regalZr4qIGi9hQnUirebYkZPd/pINPxBAorSGR69
 bct02/cn2A95/h+4ffzqguKrrII629h2YSBuPcVhDhgrABuO7JwUzIqDCwtD2PnVB55q
 cAF2mXOdvFnMN7g4Ny+ljN6LRvxJJmZw3qSv1mVvHty5Nup/6nAanZdYVmyqO+BevPm1
 Cpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783965291; x=1784570091;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XudDL8/DOlqgEpdtbTXMimingHtN7ympSyhXeOtKK1U=;
 b=F2wnNkAbrZjuSgf8uqel43W/N/qi1b5Gdal6TrCNi+ukf8UsHLn6jLGbqmNy1fRYh7
 T8BO4nwlbu46jm/13R0kpE3y2uDwJrdgvAJFIfDbX8IllD1XRCxQ7o6xi8ERGZxjZXRq
 ZepZ1gBMjGCw1DfcIhCyF1uB1cxIBECf6zDruItGanjGVHxFJH9zX5Db7AIX2LoMSPAM
 zXiTJhAW0NEmELY6/lYY3whlhMKAM+MNNDdEeurFThU8AdfhTSt9ZbfVr8EhRAo43wdS
 1gd3Ex1vUdwBG44MmgbiuBPvk8P66Ko80vz2VvqqrhIAw46ntCV2uz1SVfilRSNjU6KV
 W24A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVQ3QJLiOgekDU+6vnvAbkugPTJ3PrEyjV1BORnge4DyHhgAm3NR2FnIUDMKmzOiFkbHoLX8Izsdul@nongnu.org
X-Gm-Message-State: AOJu0Yypd7IWvMJLY0xyshBUO6RVtg8ZKttz2CHoAebKNWf1LAma3GRX
 ArdCe6EPIwryfwJfz1YJFfUGjNVtoqp6zWDwGAx5SafozISikilwM3RJt51KvzWVCzVHEyIeDhQ
 v6Mf9Z7jdxMvRo2fyPjO7VfpdEMTiQnkVf93oMZ45Zp/F0fezC8iLk1Ns/w==
X-Gm-Gg: AfdE7clr2arm1EaWRKWieLSZwwx9vLBLWPumhCscJuoAQYAwDZdqtwS6rku6riV4g03
 buQxtznV3Vza3F+zYnleoLms1vNbm0HWbs4E2mW7rL9cx0n7jd+KlBsgs7RmVSml7Deh10JO6jH
 7IUA9RaxYih2pYSQi0Y0/A80XK8U79dUUP6XthbDdHkEBi0w73WGQWuu3oC5ngwZgjyESknSg6p
 HSktTaQo5F2XEw+2T1NoGM+SvdlMoeJfaPv1CidCIeNlegE2CmBYZqftt14dRFXdwTUqroUa+Xm
 TumPSojv51tkDA2Tk0MFJIb/FhRrXm0d7LxEzusONszYxzhLHw6jDGyz/lrWcYrHoI+6c4MmFww
 e2YrSkbaosbZyLVSjcxqYNmOyCnpFXnNs8zAg6EW2FwvN1BqWgHdS1cOMAbH/ZRsymsu/xqRm6R
 2rGvk=
X-Received: by 2002:a05:6a21:458f:b0:3c0:9c19:b277 with SMTP id
 adf61e73a8af0-3c110bd5d17mr8803827637.69.1783965290718; 
 Mon, 13 Jul 2026 10:54:50 -0700 (PDT)
X-Received: by 2002:a05:6a21:458f:b0:3c0:9c19:b277 with SMTP id
 adf61e73a8af0-3c110bd5d17mr8803801637.69.1783965290277; 
 Mon, 13 Jul 2026 10:54:50 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b987fc629sm26506426c88.0.2026.07.13.10.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 10:54:49 -0700 (PDT)
Message-ID: <a9725e6d-8d2d-483a-8cc5-1b80e845c3a9@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 10:54:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/2] contrib/plugins: add a minimal dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260711094523.622997-1-functioner@sjtu.edu.cn>
 <20260711094523.622997-2-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260711094523.622997-2-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfX9bbIDank4MeT
 dY2Pt0U6qO45j/neS4AtK1a9fvs35aeXdwakojZMnc5+zwxHDwEuel/BGJSKGze2J13pyrCcSD+
 SCfLe6lvLo/7xgoo537njESaanZ7xRVILpzsE6wH9MqMZVdAQxKFD8+FrxEntRNF4sEQr3M5ShG
 FIs6H+sYDAs3S0VPSgqK1R7Pxl7jUAP8zaAjkRdeDFAt03XnVxlYehEAWCVqmqODiQXHfvtik4D
 CPZEav7TjXr+amXuQKk9opebuc8koATI18W/aKYI/rPttSm2ITK9kO/eTGSBd4KUdBhT+xk9LPm
 HRwbLePRhXsXcYId/H68ywrQDYRr+nm4+2t/pivTcGRa8PBKlI1WjintV9AQMHqlOrvuYeU9vWr
 nacNDK/YOcXV+b7NBIO5Uz+Yd9UqZs1ABaTDmm14OM+1OHf9GE7dmXDAHBLscxHz5hOOz35VbS2
 I9LBTZhzg54GrqS32CA==
X-Authority-Analysis: v=2.4 cv=HJrz0Itv c=1 sm=1 tr=0 ts=6a55266b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=Lx1EvxgrAAAA:8 a=EUspDBNiAAAA:8 a=tWNmVKoxF6QGbF0OZH8A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=ZFi1QaP_tuf8dODdgmj-:22
X-Proofpoint-GUID: sMDA3yWTTjnoDFd-7SXSetUxTajth55e
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE4NiBTYWx0ZWRfXzZhUdKnmjIFT
 Q8iH+qWHNuj3qk/GfFSLw/tahDy7eESI8QgfIBsImzlUuTLU3F4lgrGPdTPcNX+6iI7sLBuzFiF
 eAahpgRF6QOwQipiwBV+oZJX3n9Ehdw=
X-Proofpoint-ORIG-GUID: sMDA3yWTTjnoDFd-7SXSetUxTajth55e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130186
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/11/2026 2:45 AM, Ziyang Zhang wrote:
> Add a minimal dlcall plugin that lets the guest invoke host functions
> through magic system calls. The plugin registers a vCPU syscall filter
> callback that intercepts a reserved syscall number and dispatches a set
> of pass-through operations: querying host attributes, loading and freeing
> shared libraries, resolving symbols, retrieving the last library error,
> and invoking a host function through a common interface.
> 
> The magic syscall number defaults to 4096 and can be overridden at load
> time with the "syscall_num=N" argument; values low enough to clash with a
> real syscall are rejected.
> 
> Co-authored-by: Kailiang Xu <xukl2019@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  contrib/plugins/dlcall.c    | 248 ++++++++++++++++++++++++++++++++++++
>  contrib/plugins/meson.build |   5 +
>  2 files changed, 253 insertions(+)
>  create mode 100644 contrib/plugins/dlcall.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

