Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371C5CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:40:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbZGa-0005h5-71; Mon, 22 Jun 2026 03:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZGR-0005gZ-8g
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:40:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbZGP-0001TY-JU
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 03:40:14 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65M5BXAc4183477
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eXTU52eVJRb+cjcM0nE7/I0paAH5hdZTk066vT7Q52U=; b=dDnAYkllnpu3+qFS
 X2j8RnYnxewmIHALG6SkG4/IGBG4Bckm0Jj8qwr72giFP1PzZvjqMLo4dFuoF3Jz
 4sumDRdfoEg1ou+YSTPc2fO4TTvXjDfnEProRjsRxVluHAiG+7/xceyudkq0TXFq
 KXS8PRygRuAtBLyYc86jBJosM9BV6/rEuNMunQdBGSPRDWDKFmPw7TQJxY+O9a49
 2Eocyo1OOsFv45SlVCPs8NQiVhvxS6Z5qZqXXAdQzle4PuXKs0CWW6/AZzfmmTR5
 DtDB7gLXXTYOXtKJrmbelIlRDWuO9zwZdMXPI3dKqFZpaSnhxTLJZBNOjHOGC7Fe
 q1Z//w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewj6h5cwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 07:40:11 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9254309dfd4so31277485a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782114011; x=1782718811; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eXTU52eVJRb+cjcM0nE7/I0paAH5hdZTk066vT7Q52U=;
 b=B/REluBLf0wulr96AZw6g00RmjGWOfChEwqjAn/7cNZ1WHeR0ll+qcgbKYVy6vIVJe
 nGOf2GH/ZNNdid0lhZLaqSRR1F7R6b4ROOOeW5+6hINv1fBL9LNX4VXwrR9klStSX268
 aF0jAx6CeRGJYejIGcrkR3EukrFqReBgsi3FAWMURHiSRybaz4ddgxUr53MJHwH20VKk
 Azt9Q+AK2mYslF6egCCafYfdhAauDPIjDboQE0NpSvBgxth1xugGI3NTOZejfbqzvqKw
 Uv/z70q1wN9Y0ufASObYV7934SnSWQTsd+V/GVdX5FVSB8FRv+VHCCgYzG+DMwBbprIl
 lcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782114011; x=1782718811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXTU52eVJRb+cjcM0nE7/I0paAH5hdZTk066vT7Q52U=;
 b=JDRSDFCEfX1VTCMnM/mXCMHu0hJuGEYblXzmZpeYTAb/51DzOpqiW1w/s+190ugjHX
 A6qpVdscQkdcZW/33oSM89S3PJGJuX0vGDgU3JhnHfdev7k5wnpdWvJr/hmNer7D40uM
 8KDozi3baZpR8eCXm3ayZ+o5VnFBMQj3l2is2fJwTPx58ylGE4Vg3IBR9dcXuWnav93p
 mH9T5YAW0iGn0XBvARHil8wXzDm+jWQpFuaUgI9OLZRD4fUV10zsjZPIccOaDHd7NUIZ
 Rq6a5FpOnOpKO3ftCfe1bKN/ulF+GWfvNkFjrTU3UcTCRrOoQMtYbrRipgyKzTwi6ZBo
 EPrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Dy+hXPY/t4KUin1O15BN3z2DuMGWIkEXIbwmaJG9uaMtQqPOZj1VAD9oZkqmUm98yLqhiff/0s4r0@nongnu.org
X-Gm-Message-State: AOJu0YwYqjNQaS8CjfjgLQxIhklwud1Hp2O6p3O5bIvxKNqfl87cK5JS
 QcOqmzmHQ3FerLD9Hx74aS8XZkC2i8RUMukjmjV0RBDDOHFcrJ1/si9jOFN8UaLlqGM19B3JoBK
 0uNNw6qXG5eZ6nGr/nEthKTwrMb2SuSY/UjEeaJdJFKjESRKqbD2RVZpsDBVsH9hj2g==
X-Gm-Gg: AfdE7cmreU8BvDUgW2pznted9RhNa119KN5yyOiTNMUludrwJfP5e0aSR4fmWEu3zvv
 MNkIOIiDTN62Fv/I1NHdVXw58P3jspq1YWfFLtnSuTpbpOeoKEdFgnSbtmGYMYhg7gGj6HFRTEx
 ka5kIrRBc38U64XSSMT3I6jxhvIbWuwaW1fLJ9q9gVbrnRVeVnWQIhA8h3kzX11MALK2SI9/33S
 5Ycmthf2OqhdjY31hM+U9r82GK7dLCriuISyOgAMranWzONGr/f2tUn2qtHXQ+Gx0wFxY8c1OAg
 6v5qEh4EOpEtLBSofg/7N9mEV5nIaJ087osAKTB9yUm+Krh5CQs34xmAACnLVB1bJjL3uxLrRPI
 LmUcHJV+0tfMyvLtjIfmppdtaRbDRoXKvHOrouJMHJsCHjgSh3a/lwVKAAOhwOsy5e+A=
X-Received: by 2002:a05:620a:2b97:b0:915:b9f6:7191 with SMTP id
 af79cd13be357-920d337665dmr1560085085a.32.1782114010920; 
 Mon, 22 Jun 2026 00:40:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2b97:b0:915:b9f6:7191 with SMTP id
 af79cd13be357-920d337665dmr1560083885a.32.1782114010530; 
 Mon, 22 Jun 2026 00:40:10 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm325535055e9.0.2026.06.22.00.40.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 00:40:09 -0700 (PDT)
Message-ID: <9015744f-9736-447d-8728-e5991dbb5643@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 09:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: use cmd_array() instead of get_id()
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 anjo@rev.ng, ale@rev.ng
References: <20260622052120.2626472-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260622052120.2626472-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3NCBTYWx0ZWRfXyfU4zVM9ZjVE
 w9Omai/sns8b9HH5JexLVXxlyABXV+cFmtRfUwzw9+Kr41fPbxu997JvfbbxmveGXN0qB1IUWID
 /3a39XHcP9G1CVSg9MTHi5oODjPrh15/sXgiAuvbqAM2PqKm77yOZp0PJQ33vYlhGAdmjxuGUgX
 yfwGF0aJh4Am2UaEO8reWIHwGm++6wdCmJFKEUH6GNxUrHUhmo8swUIuH5WyDK4fyIyyigkAiqJ
 jA6MoCAANXQ78VIbmQ6MSetNE7uClyv/noAzaYbU8UdBG4ViOwFOHs3cjlrZ7soFi6sqwayC/Zy
 TmN5ysKaARNVgeKoIlZFGP/gJwc/1Sm4gcD7FfgMItZ6u5SLHwua3MUNaHhfB2gpR0gszutuEXc
 BWOSvmbKAcu5wi+7jn/qKcBWBO1nTWkP4d7qLyjWsYlOfeCL9X8tVxLcZJV6amQahVi2/eMdH5U
 PLMDF4d7qMZvT+bz/vQ==
X-Proofpoint-ORIG-GUID: V1Uae-tjrbjOc0XBBOpEeDPrDQqrHxi4
X-Authority-Analysis: v=2.4 cv=E7P9Y6dl c=1 sm=1 tr=0 ts=6a38e6db cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=YHtCQz03u7GMxPCSFBkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3NCBTYWx0ZWRfX1jwjb54pgDZw
 FzGuWeI9bZ+eWxCNmQ2tkZBvuXeTj053GCzAdcG5gEtGA9+11hd+Giwajv3G89hgZmR5mXFfR+a
 LZxG1g5nUxElF/uXTqo0CpwrHDZPUJA=
X-Proofpoint-GUID: V1Uae-tjrbjOc0XBBOpEeDPrDQqrHxi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220074
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

On 22/6/26 07:21, Brian Cain wrote:
> get_id() returns the compiler's short name not a program.
> Passing it directly as the command for the idef-parser preprocessing
> custom_target happened to work for native gcc/clang builds but
> breaks under cross compilers such as emcc or any ccache-wrapped compiler.
> 
> Link: https://lore.kernel.org/qemu-devel/CAJSP0QWzQEgoYMCgZX+9jCvrV6O3RqnA+df1DpT2R6MZvVXiNg@mail.gmail.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   target/hexagon/meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

