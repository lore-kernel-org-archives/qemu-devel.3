Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C67E0C5AD5A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 02:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtFrf-0005dk-9O; Sun, 09 Aug 2026 22:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFre-0005dK-I9
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:35:46 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtFrc-0002Hv-2I
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 22:35:46 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 679LD1Kb4103028
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w7c/Nu+f1sCVYmmy6FNNTIB/u/MgpM1CQ5Ksp/JBGa8=; b=TKZVnKlS8amfRjhJ
 DnHZ5FQOGY8fuDCAcO+E/acM5Xt2VgghnomRMPI96LNPFIk2Q7KLRoWznBmpb37g
 o66kzLB/PLUcrIztqNmxkOm+nCeQMllFRjTjVgB4y3Sko2GA8KuOxgS5+BFdR2f1
 81PBhWy3IhHK1GCKFQ4jWYnwrJbIitQWPKatSh17ZxSajBL0uZS9Qsc96meFTRmo
 aXNmM1Yl0HYDDRG3+/ho0GVZ8cC4Puly4QylQNMCskn6N8rRYY7FsP033vtalmfc
 rv832QTBQ9LSVUQ5MPDvkizRTlhlqoOfhQ/8+jq281hEhWHDWKdLBtHc3TxePamp
 UE/IqQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy18xrgnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 02:35:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52d33c89a29so11452611cf.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 19:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786329341; x=1786934141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=w7c/Nu+f1sCVYmmy6FNNTIB/u/MgpM1CQ5Ksp/JBGa8=;
 b=KgVWPzZWKdWzdNF4plqAc0R9NtPO6lQJxnhORqTrE3NU2l3Tw2cxyn3mP9yNZJOnF0
 ijtelb+7kxd3mSEhBHayotvN3p8wH1D/E16BXQF9ZNXPHIaTV3X74a2Bct3iT9FwpK3u
 XYnsDmso911inwEpJSp3+iV6+Rmfc86gZLheyK9TLybxZWk/PasiUo+/OFzH4DO08/Mg
 bofYtzDqNGd0PPhyaPqEHCfJUpd+d7P3ZlgOPeqWTKlNqizkYkVg09L/dfXOIwTqFw2Q
 ybMs0Bhay3hSSG9hFr2Eq8VIepsdDBACInUp76H7Z9Jt3SJNdGZVpDmbRubDqkwCc5EX
 f4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786329341; x=1786934141;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w7c/Nu+f1sCVYmmy6FNNTIB/u/MgpM1CQ5Ksp/JBGa8=;
 b=lXxOhjRLH5M1EJvGXSD+9f9VO1VDUkqsOIlEMdiAHfTK6PpDeejVLvJ/v+EHAIUX96
 qSr9EbQUV1JdC2KYSeYO2MOcgoTNsGgu6Rz7F32XcwyjkE+EPZlD9fEuiNPYaVdG1KXv
 4owJ04UUwlHUrguleT0pLWaW4d25+pFDFzPvYRylrw75GE9mprUOfAtzj+UujbuW+2dc
 yxmj8D9jY9kGVfqYNHWNLu/RxrTFRD5k2/3ywXokpDjh8YF+BkFWI0VJ0BleVlXXPrK9
 BqG97Tw4wY1P5sqjEY2kyg7esF9eRVPkCQCbkaqdpxdAh7m1oe05lP5TvXyW5rwTWACa
 F5Yg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq02/ICi5yVJAzcoeWEID/6rjkrNXK28UUtpX/057Bj1x7CiUKgLfbFSeaY0pHgohb0wZQtVgm8apCj@nongnu.org
X-Gm-Message-State: AOJu0YzuN9zBYbn0EuTiiqlZj6826ICyXGQZIeOPFLJic1i0NyAtquiv
 zxjmBxput/ThTrcGTIT2AicJ+E3KzR8d4QRb9BAw/5neaRDM3esNpeH6sFTu8QPFUr2F660Izdd
 ppWzO47b4Jg13zN19JJESHsb0Tg2kqT5A6uPlM3MpZnrmdskhGUrg6XpgCw==
X-Gm-Gg: AR+sD12MkGZ3R7E9X7wdsq0SyyGQ2w7U1hlKPuRqczKB7TPnuBmXzSV9HI9nvr/Yr7n
 GeZvQr1mlgRidaTZVVyvFnxAU9RquwZeZUKgDQAkdEbyYm6N1ppGn7y+caeXC7/w6mKXdFARkkE
 oKQFh4yuLbM7gbHI6HRyp6luctaoBaUeqQx0IpWm0Apkgl0vuy5xO20ZVf/1SZb4SVUOvYdDv1y
 MQ25UDSRwUr+a41AEV2ik39dJPr9P1pzGl1ygAlmqcIPAJUsiGwGNgQRhuSMEt5TCOwTV1SKTsZ
 cbT7R+vwbAgC33DFN1UQBt5nAbY456JVkS+m1CQCBXjnkQUBYt89hb77Dcnaw3MMkb912mN1KT6
 npGEhbO8HIK98GTBSJpT50xXT0iwugS6NGS4=
X-Received: by 2002:a05:622a:4812:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-52ce5fbdf93mr453150271cf.14.1786329340681; 
 Sun, 09 Aug 2026 19:35:40 -0700 (PDT)
X-Received: by 2002:a05:622a:4812:b0:516:d955:ea6 with SMTP id
 d75a77b69052e-52ce5fbdf93mr453150111cf.14.1786329340242; 
 Sun, 09 Aug 2026 19:35:40 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800214557esm27855462f8f.2.2026.08.09.19.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Aug 2026 19:35:38 -0700 (PDT)
Message-ID: <71cc7086-97de-41a5-b03c-4cd9bcdc2cbd@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 04:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/riscv: Improve riscv_has_ext
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
References: <20260809013343.664966-1-richard.henderson@linaro.org>
 <20260809013343.664966-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260809013343.664966-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDAyMCBTYWx0ZWRfX4BxMS9OhJuu3
 bBkBcsL93twsydewycCDkSnqt3lxg80TIjVSXJfOhxaXrnheCpLaNJQrVn1E9MJLrQkrWB0d9uA
 zViWkTCwgz1grscgqiEYka60UdtD9j0=
X-Proofpoint-ORIG-GUID: t6SUU5v2bRbBuMfZU3ue96pJJ_Q04gni
X-Proofpoint-GUID: t6SUU5v2bRbBuMfZU3ue96pJJ_Q04gni
X-Authority-Analysis: v=2.4 cv=bfZbluPB c=1 sm=1 tr=0 ts=6a7938fd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDAyMCBTYWx0ZWRfX4xYfNyvWB9pk
 IMmN4/UfSGofynWyZVTbhDAYIwStPvc4pCsuYTlIL+vLYgQMudenWAeHBJV1SZU+BLsqPaXkHMr
 FHSYlhKa98nrkcai76vTD5mqIq9vIbrP7KOKnOgxe347kZlUC3QMYgeDUIzx/9zPQwREqtBFBkU
 bOuv88r6tZmGQCQgSY5h+XnG103z/Xjg92pmrE5ppG/5CCgs19NbzfIUU5NazoI3o6aJJ5Tmg45
 fgCM1gtzxrdi4FJmdGgBnUhgRzgIwuKoUCiwSuXaPmLiwHXiOjucYxP3DEuSpp2HcyqSC2Ay6i/
 SATAujfdmM2oG0kbnVX4GrfKu7UPlSBL/ktx7quqJjWz7YkNxlhqCrtHyueF8m6DcPaDJ6Gkm+4
 6pvyqK6vkT310E0oCBCQs8WNQcvLGrj1fawlRqyEGA08NCe6uITxHkdoFt1nSJiGyPZFWc9Lllg
 xvq9mSbw7H6ACzy9/ag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100020
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

On 9/8/26 03:33, Richard Henderson wrote:
> Constify the env pointer and return bool.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/cpu.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

