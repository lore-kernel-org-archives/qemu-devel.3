Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ACCC55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRCF-00039J-Ls; Thu, 30 Jul 2026 09:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpRC7-00038W-3k
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:53:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpRC5-0008Tu-7O
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 09:53:06 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDZbhx1155148
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 13:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 neAU0fljC1DgOnCQxT/NhcU5uhl1G/cgMuNYLfgeLKw=; b=OwnPvcDxSdzrygYd
 dH1pBUqeDvtHjQ4te2IYnZuVbODnyuSphAn5DvjTQWZipRpek02W8fgxkjHgfKcO
 jsu+a/Nu2PAR9o38O6lK6tTzC3BY75LNA8iHb/U0XwISaZDgrZ1gdWSw5SuXgQJX
 JK0NZTy97v18OLGRLrvcWOJaVSrz7YyjVqZqtXfQE/RUehlzXI78/rEmkGg68CzJ
 CZpCNyDqdc1D/VtssXOup+o9ilkMKw4ijf4v0h5ReKYnRy3w8mkBAJKzUbeVF/zj
 F8IictUXJQDeUfzEPt6lBkHbmsp8gxZA0bfWTmARVpbG22al1P3VWQLvuh0pF8VC
 S2Ek1A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr7msg26t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 13:53:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso38539691cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785419579; x=1786024379; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=neAU0fljC1DgOnCQxT/NhcU5uhl1G/cgMuNYLfgeLKw=;
 b=c0sV7tUACMLa9Y8ZrdIu3ZS/9C/C0ZCQeUf/R/cDs9QmZR+USt04O8SQQd0k3ui6kj
 4xsCn05wlg/MvXrj1HA0i8BOm9Gw5Aka826kzXNkXvV3DAgt5sQjBxA1Y9amYbdTbUxk
 L7ZauRjnOOev1ITZxUnk6rJZYicqufncLFmKe4T5BPD1sigHxyXHAOqTzFlwyLqGstwq
 r7Aa1193OApb6pVezezUtwoSq3g3f7gxKxNtQmYG9U21WDO5bN423OEeb3KvyeWB/wpA
 iB9K97f8ozYjzcA24HAur00qFsETb4UhtGRr8gGk8M8FAFY5gbJ6MA5I7CUzHq/yqvUO
 FwMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785419579; x=1786024379;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=neAU0fljC1DgOnCQxT/NhcU5uhl1G/cgMuNYLfgeLKw=;
 b=oLuDB+NWOWjE/Sdw+/DIwOgGNVtuYEP6xaQsNj/gerhaQDsEOUd418hWPX7P2xdHbA
 buaXOoBhFeyItTUmXlCUbY6zIuCZOBViE9hDJF8+WBUtkTg9TPV3S+ZnmxkRw64HW2FX
 wLl5L7wbgyGfUgNigGKZZsl9q4OqVfZX7KeD9C8T7NJjKcdC62DI8d35kupkPPPW5kF3
 aH/r/TYFE+My2mHPhAk3it4dnqpq6EMq1Vf2I/fX3z4y/jH0g4Oz+60/qB8jTD94uWIP
 brrQaDFhTMFejElDx+t1t8QseePCFXyOOrRLKXdh+HdzzXFfydsbYmab/1/auNzfJUfL
 S69g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq14HoXhctXTwRDiSvGVw9n/EsrA7yk6fHStjRriYP2VFYz0uFdXBdXIMJ/3vu1SODYqui4FBcED0BV@nongnu.org
X-Gm-Message-State: AOJu0YwwC9jDlq4oVgLxhP0ftep/OmqYtRzMuEzmvil8nFzXuz1JfJhJ
 0eB1g/5/acshGJDzGh2mjNOkZINSvE6QG3NqP/NRlBRushnNxU+Td3mchjYbRJ6Xi1Az3Xw9miO
 v1sVeSbdIouUbBHdjo9BfxKEUYKCm7n2TCr36Jq7NBZ7qRpWX2T0wXpE5uw==
X-Gm-Gg: AR+sD12+iuMlyWBhbaC/Jz1RiDePgBfG1jTuhLNZY3zyZO+hbANKK/6ftGXMmF7+Ysx
 0ROnXv9PjvWo4B7Zk2p+pvdvWRLu1YzxAKhViTmLIQ1OVf1TtFTfJjBA+zQQSxfRFL5aTTHoha9
 ZWiZaLIFshC6ytzZOmRxOQgRYe7etjKGYdk22bEIZj5kTdpkuEwjSqek3l2bTLf56+Ym9aI7RX6
 07Pbvc+vk240EeaN9dvp4DiFXa6vrEHO3VnAbXR4WcUdXm6gmIXofb79v+aWPPGdBXHzyBQPJoY
 Qar4Wljq+bBfx+n92NRdGAu+wOxuqJaLqrcsyFrC2FG5blBDxqtjLLc+pDZsCqs0EFMRcUrEA9q
 +oNrb5SXbaNn/Ym8f90zvXEu13WkbtHVp4inuAZsFiiYBe37/KvA=
X-Received: by 2002:ac8:7d86:0:b0:51c:15f2:4bd3 with SMTP id
 d75a77b69052e-52b38496833mr31336491cf.22.1785419579459; 
 Thu, 30 Jul 2026 06:52:59 -0700 (PDT)
X-Received: by 2002:ac8:7d86:0:b0:51c:15f2:4bd3 with SMTP id
 d75a77b69052e-52b38496833mr31336301cf.22.1785419579020; 
 Thu, 30 Jul 2026 06:52:59 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f1a7f7sm75094005e9.5.2026.07.30.06.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 06:52:58 -0700 (PDT)
Message-ID: <148b4e40-35aa-424c-b542-669e2a871dd7@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 15:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730081325.1816193-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX0K+c9V7HCFGR
 MzFop6kSeHOxhyPOuebEnsMWe1HdDzC/4oSJtOfQUA6XACFo0pFhy5AbWmoweH4Wo3vgBBJUqVe
 lEzXgDzkI91OATfDD61st9WQCYl1GP4=
X-Proofpoint-GUID: 9PHN8_NF5sAU5Pm6r421yhVEBuralCm1
X-Proofpoint-ORIG-GUID: 9PHN8_NF5sAU5Pm6r421yhVEBuralCm1
X-Authority-Analysis: v=2.4 cv=P4YKQCAu c=1 sm=1 tr=0 ts=6a6b573c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=-51qIya2eyH0n3aCwt4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwNSBTYWx0ZWRfX67jCoTpBlaSU
 WUSYS/uqiQA9ttbi4CMqg6Zckt9Mwc1Z6y6AxjkagMGjkDKNoBCqQOrrJ2wP3pbMwHOsdUpfmAz
 7619pM7H0RhRn393oyQUYpkMzO+dOLLHtgrd+h1J3h4QHxOdxrqog/cdXrh4wCLbwz3PdXz753B
 0aaQAeduH4gt/Q/jyHbUFtRjgianQZhE4XbzF6GxU4waKV/MTQSz39HrXS2Oq8OyECU4Oi4M2tf
 zONiReauFfBCA3y/YcDt0/I4mhJ1GofgsIhB69MP24x1iiM5PyHsT4zz1lbEt6eLCn1HgVwyEMX
 kBYESqRZ0/r2jWGUb4GTUXQp2ABV0tH4LyZrV8OJgMHwcSoHFzciDBtDVX5NpWYHMP1NcY4xEWI
 96zRBTalTpkEDoe7iet9KKnq6C162hPov86zXFCPWoVHElmFORHIRb5TCqP5ROoERO7aGyhqVbr
 6WZ4drYbP4SCCBgjKnw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300105
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/7/26 10:13, Denis V. Lunev wrote:
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Stefan Hajnoczi <stefanha@redhat.com>
> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Thanks!

