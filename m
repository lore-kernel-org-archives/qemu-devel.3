Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BD1CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP29-0004h0-53; Thu, 01 Oct 2026 18:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP1o-0004GO-4p
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:13:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP1m-0003I4-KA
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:13:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691IvmwY3519791
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9kNL9DZ3LulD2blvbhnO6pWORCE7R+aZaUtTI6NaXGE=; b=PdURYj413Xb9MsvY
 owByaWS9kVlRDzUFa5EpGybl1zvBZl/YsHa0qecMgNDeF/xTrFFSzaYpX4zJyNTq
 jcrj+QvMEZtrQu1ODisk/3jbgcJe5x932ZRKyijbnraqjmtbvhWe8XN00rQwPVt8
 zRwLF2d0KU1gxIipHKcRT0MrcwPEJV3DFFrh0bOD8B41rPMyNxHG5vZrRYj4pN4f
 o+RjCkwVOpJFGYCXBw8XcSSXE2w4dyU5q/FqtNc0WCVBqDwaJjb4mC+Aq8TTMyD7
 HtrRI4xJQYGv6fDPBsf6OYX+JPj/6BZ3YEMa4H7NF84nycRuoq/d073aFbZ9zAlq
 IL0Faw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1w8tgmmm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:13:21 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ef0362d95so749434eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892800; x=1791497600; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9kNL9DZ3LulD2blvbhnO6pWORCE7R+aZaUtTI6NaXGE=;
 b=apqssZNatzOia4ZLbMYoB6aixMdR1IWPVAlkHudf6XnIDZNmNObq44YPlDmvrGiYB9
 t5mXVJYRv5OdacvD2jG9E6qMMn/sISNoOI5qIrzt9R478Z39+mEsqaKOAFnRw/MGIRii
 rMmozOdR/RjwVNLo4CkPX23oQS4hDKqhSFxkfw8oOM+yNWogxTckOtU/jZUs9NhX5ZLG
 gGCcnOBmKL0QXZPKuOsmSsaynx+DO7SPqNnBz3ZTaVpG5PRMHLMHrBKrVrH5lUK07NOD
 QtFcKCEjT6/7urt7zGgYfWAbznYjZD6YoyyJT1oULkfX2onA81Z3inGtHJWAvOOXqX4E
 bi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892800; x=1791497600;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9kNL9DZ3LulD2blvbhnO6pWORCE7R+aZaUtTI6NaXGE=;
 b=pxm6Tu6jmJk8rfU+9H19C1LUFyq16W3eVeNuE2gD1bnpGn0YBgDxG0UFVFrc51HATC
 KEVIIMyCddu9+a1NM5BJWBWqyBPTPuuRBuRS1C4TqAnihD3K02rq7QND7E+2zdi9L14F
 taViZU+b7GbVdTEaLjQDF/toNs3lz2kpoQ+36CqnG+wm10DC3nGgaSIaXohVuJWuSTA4
 CNH/IqIuuaCs8ssINT7FWEsM2TAELiKrxdqldWeRwX+NjLVrDk958pxIV3nw1dBe55Yw
 9nlHrRritsg2J9cf7UXdul3vXtPRGi9RJJ+9ZlGkG06HggI5YIR1GWN1GKd9UwAMGs7f
 eG5Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByAeQ/hiMYtLbjAmfUrTXSwbyL0NtPJmUWd66PVrDkcB28rVSWKB+0tNlUarz+PlLzAookpy+mH2lGr@nongnu.org
X-Gm-Message-State: AFq9FYLJjR3oToCD+T2PCHizquWjTcB2owG9CW9h30pnN4Umf+ALNfo3
 8GfPSImABA4v6HQEWx7jMwHEWM1Pzbg00Mw0mh01orWFSGrXcz94MqX0Za75OT4fN5CYIn4orQC
 vBZqKQyzHU4BiE3petDYrO6cYNGL1Mp0CK2Q1kLgteVepTcLUxkmyQgyN1w==
X-Gm-Gg: AYBFou0fLyZqiEYFIXhWuEFVV3iikPflKnZCIPVPYGI0ye5e58wxvfD2onbepmwKmrA
 bDZNHzG8lBbPIMJ3yClq8vVyMoEIPnlW6Rr9O0VedyxIimDcA5kod2Y/CHf76rTqrnjPZwN5bBu
 rSJasNsGOVxYNnhfzo2vUZeeSB37ANv1n58GktBHf+IUKN8dAAagzIwCpHHq5f5w9wE42PQRZO7
 9Hr5avh4dwQhbzeA+ze2Kro9KClUWLqal25b1YySHnJvqSZH4Fa3SC5mQsSMgn7HDJejvqN6JzB
 tu1aqXC/0q+CuGXY33BjgN1y7q2RuyD5TpkR09tSPg1uFykmUpRtIMgFX8Pfql8R9E+3j0G0vO+
 iQaTamJH/P+PmdqZNQjXlWkpDKFNjlBHVmLa53p4lfhZcUY77AHmKsbywzQbTPICJNe7P2g==
X-Received: by 2002:a05:7300:b905:b0:343:6622:ee15 with SMTP id
 5a478bee46e88-34f150a014bmr1026468eec.11.1790892800267; 
 Thu, 01 Oct 2026 15:13:20 -0700 (PDT)
X-Received: by 2002:a05:7300:b905:b0:343:6622:ee15 with SMTP id
 5a478bee46e88-34f150a014bmr1026427eec.11.1790892799566; 
 Thu, 01 Oct 2026 15:13:19 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f98527sm1008570eec.16.2026.10.01.15.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:13:18 -0700 (PDT)
Message-ID: <e6190d35-044c-4c15-9d50-da6c18428226@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:13:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/18] target/riscv: Compile time_helper.c once
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-17-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-17-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GmNWxuwrpFYOqCHolG8T6GU97tBRfyp2
X-Authority-Analysis: v=2.4 cv=ML/1C8Zl c=1 sm=1 tr=0 ts=6abedb01 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=nFgamq1sSFmvarFgJzkA:9 a=QEXdDO2ut3YA:10 a=VxAk22fqlfwA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX43DQwrfrLycs
 ldGK3AwbsuP/v3etFj38HqPEsVW+Jnx2fl6DCYjkWuxGPCIzBTzIVMLahMPqvofcqJ93/i4bb1b
 dn6txgzleQFj+bGTkddQbCCUht9zW/w8zWd7AcvLhk9iawMUhsN8+mdSXkkz3vtXcNhtm7sQV6K
 r8W6h9mf/N36KJhmi0aLpqhzWBbe37OhiEcKAB9C+JNZe8/ZcimShHM3OMEDEB1Ff0BoaxtZQ5A
 n4/+IS1+8b9nTrWV3mFh9493dl5bdgz2U0cgdDo38YGaPV+n/qYdGYNLs79ywRreCkoF3XMMgmh
 0J5qW2VsxU1IU4g7ef4hhF4SpOx2aE7CnnAk9T9jy6L2uDFk7MpjI0UdOjNTaNEX08EHXcgoXKz
 Kg8UOUwghcVjjfggPwG+s2aSuNzzA1LKJd4qNqcdlTwMmF6P+trqx6BNR6zeu8OdyJY8uh2i1wE
 PLxZmxrl2nFhWuzgG7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX47qCmO5GP1S6
 DL4JM2kp0P8Qy1GK2+o3A/fl0v0t4r6b0WcXkDiaLsjt9ZgLoVOft2AA83Bd9C1XVwCyBU11RaG
 uWQjJwckDMgalGjpsIpkCXeQNunO17k=
X-Proofpoint-ORIG-GUID: GmNWxuwrpFYOqCHolG8T6GU97tBRfyp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/1/2026 8:59 AM, Anton Johansson via qemu development wrote:
> File is already agnostic to target specifics at this point.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

