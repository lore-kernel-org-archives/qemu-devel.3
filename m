Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7092C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyc68-00072s-Lo; Mon, 24 Aug 2026 17:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyc66-00072V-Lp
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:20:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyc65-00042m-6B
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:20:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJGs1E2724725
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:20:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4ZdZSRljB4GLJ1gBMvoNxncDWNi9cpLk1GDJpeAAjQM=; b=FPP4KKKBwuS+tLTC
 ub6/iE0Yf4ZMTRj4D+p0UUVR3gtXmiqW2KqjOy4fNd1oAfYzVngEyYMfC6sLjYco
 xFyag+WltrDHTcBPh4cBd8M/3OgI7BZ3EIsVilAqE7+S+xOzOHTAaeQ5BneshSOu
 k60zZ+sT086BKjWnlQz3cw4pAIbdkorKzLev6XYnQeGrxA6YWdAkpno+zL2WTHBF
 UYeBx6Hq07UxX2kEmTeouAYkNSJorRajELxLI74JbZSUBdUcOv85bm/RmomjXhm/
 DXWOD6aXMAwWT1zbYA/6exfnSeQVxVSVcpDv847iLPqUDWM/ZB/pHYW9ke2cSjzU
 1wCPsA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf3cd3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:20:47 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d137a68so85227681cf.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787606446; x=1788211246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ZdZSRljB4GLJ1gBMvoNxncDWNi9cpLk1GDJpeAAjQM=;
 b=gtMX4iCOMlXaPRoiFb4P4qE5EWxZvA5LNjOrNDLoiWWzh9dBLfLgS4h7w7s5rPdamW
 elGlXS9fDzF1es5YL6XgUbUlxfGSSkqTkyqgy2U1Sklv7tKsafa8WVY0qsK8CI6XmqIa
 4YYbgwlMFHoFpRIxnOo9SPqSBPtirX5u+z7qRTeRxHxKSdphBDWHmbR+tY3xcS4JLu+m
 0DGaI7sXiU9MLIK4z1Vcfj2olwb2wGpnSE/9ceA8frsZ6x3qYPNgCJheGgXFAcj7iZf5
 j1jrfWW6/JkOKnxhOR7bYjVvUQk1PUxn2Pgb8UuS6GcsnKTWIdphGAbelV06mKc5fDhU
 p9WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787606447; x=1788211247;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ZdZSRljB4GLJ1gBMvoNxncDWNi9cpLk1GDJpeAAjQM=;
 b=kKQ+PM2MzEqa0h3WitI0foXZaDI/B9yOnXElRR56GDUUqC+4gXkjAKNU4c9UjBJC/v
 eFKQ4YJJnQUSvLioRuhs/EYJXCRMg5SB57cM4chXILsRvD9BUZ9dWFrOWVBgjybBHI4z
 MKoDkqegnP//NbT8zFDmqK4VXW793SS/pAK+KBIIJk+tb1wkPd7F5+vEZLLQgLKZd7ZS
 Hy5hRD0KDKImZ7o7m8TOQR0NPSoEB5HckLMVlq8Eo8hwJKFeeWwkLDcUtEJfGQy/HQ5+
 94Igd0BOrl0qZOxPwk5tnxkzF6duHuWO+meusIw3hxESZxTcl5pffCeL30A1gishdram
 GuIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpV61wRKun31RKtFjqPf6V2N6p0KlDfjY5puj6JBSa+TjYwYzUHv648MB7gEtfERhuw6EOIOBqkC2dF@nongnu.org
X-Gm-Message-State: AFuF++mwrrunAgZADReFIllpEVluuZGqI0ktYO03qCl1tdxtwTeAJopp
 T8p0Ofyk3HF+XVjGyhDm9GEWH2I1PmtlLhsxFVZ7DCaWNSLWJ92C/8xIusgNIzLUhycsWnLuODo
 PCxyNXOX1khCl+cfeinW1pokMNXRuABcixq9HVb0wvATZIi2cat2FrrFszg==
X-Gm-Gg: AR+sD10HbD4yR4292RalydRxPKitkZehfcmVIzbMakdgmMivzUmEO1S3GtQ7EqJ6hvn
 Jjis/KEOFrvAl74WReXcaI6qKvzgfu0SVVA9IYQIwZeDUBg4Z4RgOSvDBuTW+c/p0WpKr8j05l8
 wI/b1RtTwVFf0Usct8pN8CFmaLASz4WQqXGMHAQgKzlp2upf5T1IqVY4gY7B0M126Ida8hHbDch
 o5Z8tS/PqTQZL8YtqU9SAEqyLCRXw1R36v/HNqtX9voO2apHU+f5EsnB19qzWB+m1+ykAJiqO1M
 mnm1vljE0JsIDm8OkcTztlq9Q1qJ18ESYUpn1wVNgNSrOJGFoFzeTSg0+kI/fzBbnKXHECyNuwc
 aSevcpS5U4lYLXcTeb9+H4QSvOMAxl8rNn+g9p4EFnXpoBzOfs28=
X-Received: by 2002:a05:622a:8c7:b0:51b:60f1:689a with SMTP id
 d75a77b69052e-52e09bada2dmr232816281cf.7.1787606446506; 
 Mon, 24 Aug 2026 14:20:46 -0700 (PDT)
X-Received: by 2002:a05:622a:8c7:b0:51b:60f1:689a with SMTP id
 d75a77b69052e-52e09bada2dmr232815741cf.7.1787606446029; 
 Mon, 24 Aug 2026 14:20:46 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499d5cbd702sm5846055e9.0.2026.08.24.14.20.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 14:20:44 -0700 (PDT)
Message-ID: <7c8fde9b-9887-4aff-9218-7065e1615d23@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 23:20:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] system/physmem: Improve guest memory allocation
 failure error message
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260822122710.3731595-1-bin.meng@processmission.com>
 <20260822122710.3731595-2-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260822122710.3731595-2-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MCBTYWx0ZWRfXxF3bSgWJ4Xee
 dIxxN7/kYNly9h0YORpMpOxERz60y/Srr0WzJxSUaC8k6xnetozNvyHto5PyDwywpdj0gUBTVOk
 qTJaHoJgwKiVEojMITHhNm1t+XKH7GE=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8cb5af cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8
 a=ggrrtbxAnJjFAoMTagkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: RRg_UTQnzKrakg4zE1Di_raPr5JiibUN
X-Proofpoint-GUID: RRg_UTQnzKrakg4zE1Di_raPr5JiibUN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MCBTYWx0ZWRfX1QtxPDGQTOVE
 XjSMLqsWoBWBchNoa+F0/4si5UgX0zf1Pl6GrIbWZm5neddiUGfmx1qqWB+mO2ung0jQeZc1YOZ
 O5waf0SEi08Yhg80oXEpYuhOsK3d/94r2kxL3oHzILNvYr4uwJ8S6Aw6F/iS81g0NFVExlMk88/
 xu9kiyYnveuC7kwTzwH2jrfgr97BC+fo6WI35P1WKWW3C+piHRIX67t/aqZSxUMYjXzyYZ11z+B
 sd0yIgK1wiR3rGxSMyWs43RvlHW536AwXJu+bl6V6cks7XndC+HXOyGRdbRhzICRdy03YhcXXIL
 mFXMMQ6dp1jnODLFRaAOraxtr6lkH5HejcNaWb84HVYeq8KcNX/HQcXhcXxHvEjOd+CXCn7Verw
 r6NnfLHLTjX1o7qETyaLjseJ/Ktp2Eam6/G3XgVIU8jk5lgsrQpi7630to9XO7zR4nVnzPcWtw5
 wRTlHQfLDsUN5tWGjWw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240180
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

On 22/8/26 14:27, Bin Meng wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> When Linux refuses to overcommit a seriously wild allocation we get:
> 
>    $ qemu-system-i386 -m 40000000
>    qemu-system-i386: cannot set up guest memory 'pc.ram':
>    Cannot allocate memory
> 
> Slightly improve the error message, displaying the memory size
> requested (in case the user didn't expect unspecified memory size
> unit is in MiB):
> 
>    $ qemu-system-i386 -m 40000000
>    qemu-system-i386: Cannot set up 38.1 TiB of guest memory 'pc.ram':
>    Cannot allocate memory
> 
> Reported-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Tested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> 
> ---
> 
> Changes in v2:
> - Rebase onto current master
> - Update the source path from softmmu/physmem.c to system/physmem.c
> - Fix a typo in the commit message
> - Collect Peter Xu's Reviewed-by and Bin Meng's Tested-by

Thanks! :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
>   system/physmem.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

