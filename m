Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B715C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 22:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5XKn-0001Ru-L6; Thu, 17 Apr 2025 18:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5XKm-0001Ri-Vp
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 18:03:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1u5XKj-0006Ww-Gt
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 18:03:48 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HClMuG014260
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 22:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u7jPwAgRZtqPwWh+y8oblS43njvR5wZAxwpsCWMSiZg=; b=EuCINfupwj1LJfwT
 V7trBQ0FALWznL1BHp4gzaICy2aqX9scwz3p/y8Q+rUCgl3lWY3dnR9Dtk1PcOmw
 Qxe07PilYuK9FfxowPhyQZVYCYaKCAu/Pcz/1Z/zhjcp7xBDma9KqIjzf8z965Ny
 InPFYwxIdwGmKWBQZShb653Tj1qbvxdhiUyVH8M0HLnJhnKjE/uKiskcAjPNkHAZ
 GU9lKEoMN30VlK6PttfBxHBsx6imcF+ojfZ6M3mdv0PzD0r1f+7+uOqnPR3Cq+8a
 vs+8mogt2nN8tcGVvwKyPRyBjaibhUOsQnp4mL4+ZBtdxdq4teVgBuTbxPstMIw0
 ocarXQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfs1g70m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 22:03:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-736fff82264so957003b3a.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 15:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744927420; x=1745532220;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u7jPwAgRZtqPwWh+y8oblS43njvR5wZAxwpsCWMSiZg=;
 b=LymsAPp6wYlTTNYI+kJKOhStW0zbmsL3PpIKRMWqyotLqOhLh3eNLViMD6ovKtNk+5
 UNDAkw3ZUdMDlq6eVZ4NO1JFvCnb4jNVXZMfhrinGfBfd+85Bs5jh4jK/rq0ao/4Se32
 jgkp83uxc1ydgyCJN2hJSeArV+LAD4LTRtB8wm+JF2KjqxVXWms8QlOJMgXVgZHM94wD
 Aj9ePJ9E2b4Qzky5Qt0lrDXlN27JbFQg7gaXhJVIm3gfnOowEU154w4Q3bT3NTCuy8jn
 HU1S1+12RpfhBK0ZpqTyq5LJlG8Mor9MvEYRZBICXc3TuEai1Tgkh7TX2A5gjuGC2vvm
 a5nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTm6m33ESCR2DGToZCPgTpJPiqeieyOfuLCzVnikUtLLnp4AK5f20hLD5jq1D/6+17ueCnSnO1qTuN@nongnu.org
X-Gm-Message-State: AOJu0Ywq97ouB8RbphQG+Hk7MNwZyk3e9WIDDfPq/0fggBwdkg8fJraE
 c4M+MerR8nnukwSc9D6IHih1kz+7OeC6I2wM5NEZX/KH1NZ/X/4xW/4EAwUPqwfERGELVR336Rn
 A1kk4YYgOEbb+IPzLsPpMUoM+FlkQ5x7Tjol7fU2qtcQEGzHYLuU+Bg==
X-Gm-Gg: ASbGncvkIstsBdiyL5RObSxQ8lj72hQPQV2Nl6tp5tF+zKEW/bzqiSuFnDl6mmwcswO
 gU/3Gx60yUMLnlT4P2ZTRxEp0wcIJ48+bITpAGyH1k/Yhyk9q+SVxLHqB+wdSvayoJGER6F669t
 ojqcDxSJcEpFO3IYKTv7FN37ecQH6tma46YMbM+bkE9ksBwsgYtnZsKaUuChsqk1nxlFnF/2FrF
 ubCvLWAOPEgojh9BSFrr0kQK0uFsGiE0RarYr7AXyt2Akti7HxpOZbYhwyzhpQZwrEZqdxCu5A1
 111Wz4PhAzeeeIue9+dprj/sCzuYs5UB0So9HBDZOzirlHpHXhy0LWyOsylOVBZvzIGLD/lzQM3
 y96hcYjOsCudJ
X-Received: by 2002:a05:6a00:23c6:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-73dbe52053dmr2445999b3a.5.1744927419744; 
 Thu, 17 Apr 2025 15:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMLbIP160DKIUrCL5ug9Pri5+sZhGP3N/HujhMMYCLvZ8zpbV9cSfycECa/k3xMp8HmXc93w==
X-Received: by 2002:a05:6a00:23c6:b0:734:26c6:26d3 with SMTP id
 d2e1a72fcca58-73dbe52053dmr2445955b3a.5.1744927419322; 
 Thu, 17 Apr 2025 15:03:39 -0700 (PDT)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8c038asm379697b3a.20.2025.04.17.15.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 15:03:39 -0700 (PDT)
Message-ID: <a95984f7-e0c2-476c-bf2c-0b98e28202fa@oss.qualcomm.com>
Date: Thu, 17 Apr 2025 17:03:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: update email address for Matheus Tavares (me)
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org
References: <c3a9a81f76262637d6d7d2d70c1264a8e18fd5b2.1744907562.git.matheus.bernardino@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <c3a9a81f76262637d6d7d2d70c1264a8e18fd5b2.1744907562.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P9I6hjAu c=1 sm=1 tr=0 ts=68017abd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=j8RhgVXbAAAA:8
 a=1cGLs3X8AAAA:8 a=unkj71DYAAAA:8 a=COk6AnOGAAAA:8
 a=oCJs8q-oAAAA:8 a=KKAkSRfTAAAA:8 a=ggQks4fKAAAA:8 a=lzDhS8hmAAAA:8
 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=Ty99M0EvZhIziIdKUUwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=3SzYsRL22XtqO3ZTpi69:22 a=d8ghUycwObenwynNfMyN:22
 a=5RyQM4v5J9L3wGZf4tZl:22
 a=TjNXssC_j7lpFel5tvFf:22 a=qUF70SbvcHBaGhGVny9j:22 a=cvBusfyB2V15izCimMoJ:22
 a=6g8pSQqS8yRHbJHhMaLw:22 a=rigQk1bY_8VmChEzA3fK:22 a=AlIIF0cMT2hfDT4axODj:22
X-Proofpoint-GUID: 9OL-_-5VZmCGz0N0QdUU1JSiTYnBkFyC
X-Proofpoint-ORIG-GUID: 9OL-_-5VZmCGz0N0QdUU1JSiTYnBkFyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=794 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504170162
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/17/2025 11:33 AM, Matheus Tavares Bernardino wrote:
> This is the new email I'll be using from now on.
>
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---


Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

Tested-by: Brian Cain <brian.cain@oss.qualcomm.com>


>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 33fe75400f..e4f45c6734 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -94,6 +94,7 @@ Leif Lindholm <leif.lindholm@oss.qualcomm.com> <leif@nuviainc.com>
>   Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
>   Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
>   Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
> +Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com> <quic_mathbern@quicinc.com>
>   Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
>   Paul Brook <paul@nowt.org> <paul@codesourcery.com>
>   Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>

