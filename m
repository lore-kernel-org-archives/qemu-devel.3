Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBBFC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBM0-0002qJ-I1; Fri, 10 Jul 2026 09:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBLy-0002q8-02
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:33:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiBLw-000436-9H
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:33:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AD5tUP776079
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l3sHVaFFyDhN00ZG0BgAnCuumh5vcSMnXT/droohkA8=; b=ej04xoNvA+KkxlZs
 V4hi2fPMsKCKmYh5u3ukbALl6ydrdKsvDMfAgG+gGnstatoliuJk5xAl5JuSx8wC
 h1mE1s0o3b6DheyU8yA23QK/4fJ2+jxwCqhDnzGMrsZFcTNPVD1VyteSA8EmlH/H
 4AYpENyf/wQcwx2fk8ASFvFPJH4khW1/QSFD+SHP/FiXDH8TVcWPphHoMDvDyfHM
 rE1FOcZUg+ciXuAG6OpWpZmN23b9iE6SSIih434FEs4ziySG9ZlcdqMw3SpLTu8z
 hJUQKeLUMlPaBhoVK8KpHnoFAdrHYXIWJUch5+hfJL9Rxj0QFuYN0muSrKoHOO+a
 nMv02w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fax5dguqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 13:33:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e695a3b28so223549085a.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783690391; x=1784295191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l3sHVaFFyDhN00ZG0BgAnCuumh5vcSMnXT/droohkA8=;
 b=DW2cMN85FtSjG5wrgguZ+WuCPrHkVrht9hjDQeqtX7MsncNtX8g94EwlUJeuJBy025
 w4T3qKIc3yeh3YXp9J9+7aijbuUS+DOv3UGiUSFMS/8XbtSo6g1VqqkHW8OzLQazUr6W
 +PIOW+KpagOA3tBcsj2ISb4T3+Odx9VdM4k7tf7gmbJ/sQzXPq5+fJY/DrAuEVNfRdxu
 pLOXHLijJxtr6hIrNQcInq9uWYK9B9pdHbwgAlyy4PX9PzEIXB2CaXDUWQKUYmh7COKW
 VKGKdSh3VIm+CjnJ3p09P3uFkvfTp2hXHPwYE+anjMhaGLr2lbjF8o9g8UO75oDdtHru
 3CCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783690391; x=1784295191;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l3sHVaFFyDhN00ZG0BgAnCuumh5vcSMnXT/droohkA8=;
 b=WDN10HB+5I/slmA93gmCjAlFk5xVyQXEZQoFVyB6o+gCqVlC5URP6/oxhUWkJ2JgDF
 skFOKqdW1YEWEI5C1sAYg6I1m77FuU2xPLzJdjbLxTmInw7pG4uS6vCTHDZ8q8pLNP2F
 7qU3px378z4qtDAuDiQnRmqN5oCN6NtWYJnwNd/C+NsNvGGgg/45VJi+PVCTgPTMHcm+
 UbrI4Z+YtFAwxfvizZUuO5n1eoK0RUT7BujUU00OxrqTsPDrWDC9N6Oqf7W430hCYW01
 vhBKkQ3svrn2CItQfEyzHgjkg/lHo8zxkLPv5IgL7WUjekz0Z6Wsw7RAedmLZsq/99FV
 Q2/w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqtgBTEYrlOTjcusibWsSf0i0xRAsQqu0zv62V+iZJMqfhns8riXDVk0txr3RFiVnNdsLH2eAVB4BzX@nongnu.org
X-Gm-Message-State: AOJu0YyVmoydPov7FPwHjfIb0mth+tbf2E+3S4f/SHuiJaPFelNl7nyg
 GAlsKo7uT9awGvgJbLQoXj+YowVP6ziPJLISRtMAJiyK6yhVIEagRruyzy4k+8j9M786ixLLV7x
 WR5N2JrQe35bUk5BPdZQmW7VH59XTi0QTB5YcFox+VeaMo3ZfIDn/zlz/QQ==
X-Gm-Gg: AfdE7cmzu88DU5cMw+mdLAX6BUmKsfeOIQpRM/3CtP/DwMe4GZcPMigrLQTbmyt61yO
 EY2jPngKBu0m0YDodaDs/rjaI1FJ7PPjCwODC6CQp0Uyw1zFGNNxttOhdFY0XkfHOlw6EDtpIws
 5WwZjxPlVRqScJjpR1MXhSNiA8iI1tEXpOUJtRjRjQYE2HzulPGu2FgR/pjncMc33u1P3N83JFR
 WSEJjPJ0DUGIJbZPkW3knS5RT8JLBDoxqmCjJgEqftu62clQ5WcDt4HIsMJ9AFG0iXhJXBaTns4
 jIO6ttw7EcFBHHdLXlEk27zT0Z8EDJ4bhv9/DcaF7sEWADou5aPaq1t7/Mu+I7xhLiAWJj706Ep
 kiKoIv0xeUEu+zCaWxeSPxVpHUQe3ZaLOP2wSHnKWreyFYny1MR5B9QxxmkSebA==
X-Received: by 2002:a05:622a:4d8e:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-51caa02bee5mr34779611cf.8.1783690391129; 
 Fri, 10 Jul 2026 06:33:11 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8e:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-51caa02bee5mr34779231cf.8.1783690390727; 
 Fri, 10 Jul 2026 06:33:10 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f3c42sm141177365e9.1.2026.07.10.06.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 06:33:09 -0700 (PDT)
Message-ID: <c89a4917-2727-4db3-8711-2cd4e4fa6691@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Regularise the status fields (again)
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@mailo.com, alex.bennee@linaro.org
References: <20260710111403.2953873-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710111403.2953873-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfX3csyK7fVOhxc
 dlur9oLKGEkvHykjga7/v0GB05++5ous/8z9F7VmIaR5yG+mRRytRPvi+CgNBvXtjv/H6FQu9/F
 7tQ9Ycq9vNwY5K/5mmef5weTTbzrbn0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDEzNSBTYWx0ZWRfX3j/B5KFeOZLB
 rrxhofwA8WXkSpTFnTwQ8GEzDOkP0rQEN5K7i2QZjFU+ET8ZjrRzXNBTCB9f4gJpP6oIrVsP5cF
 901Yo6GWkJzqu2gduH6KuZY1k5eB5x4/Ds41weLrZR7AonVODHO+R+hNcRr+eBeeBTn+c4LFX0M
 MbihHI/i7LsP3pKGKu4e3RQ2n7t/sP6zZtux/dN22KI1raUDjr0RAXOh3bRwiDpWD4ZbEI+gJag
 bpisN11txg+jSVCIHbXRb+1ClJICU4DDm0jImdSxvqWUSZI5SxvdmgevTRMTUTn+1FwE2M+LOyH
 qRBaLGzp121jFona7JkgajgW15hMpKSG6jJWBm5HQv37DXP48B+0FHByIkoOWuYzMEuXkm0QNMo
 2jkVTe8ygyxe71Cbo9QxEvLDaRlJiAeDSnqf2XZHpmgGxaHCxYsuilxycoNvLE9HNi+94ZyWmsg
 MrinsJD/O4vVnNxzk+A==
X-Proofpoint-GUID: cVLB8VPwRwvCpUPo68eGG38fWIBoObE0
X-Proofpoint-ORIG-GUID: cVLB8VPwRwvCpUPo68eGG38fWIBoObE0
X-Authority-Analysis: v=2.4 cv=M/x97Sws c=1 sm=1 tr=0 ts=6a50f498 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100135
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

On 10/7/26 13:14, Markus Armbruster wrote:
> Orphaned isn't a state, Orphan is.
> 
> Fixes: fb7001e458 (MAINTAINERS: Remove PhilMD from firmware sections, 2026-04-17)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..576ef6fff5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2937,7 +2937,7 @@ F: include/hw/isa/vt82c686.h
>   
>   Firmware configuration (fw_cfg)
>   R: Gerd Hoffmann <kraxel@redhat.com>
> -S: Orphaned
> +S: Orphan

Oops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


