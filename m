Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D683AC55162
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Aug 2026 17:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqZvi-0001qG-FB; Sun, 02 Aug 2026 13:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqZvZ-0001pG-Hd
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 13:24:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wqZvY-0006mP-5M
 for qemu-devel@nongnu.org; Sun, 02 Aug 2026 13:24:45 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672Eaeus1363513
 for <qemu-devel@nongnu.org>; Sun, 2 Aug 2026 17:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zvGvbLstQ5VKSoO9OJ8ikq8pcNIFgIFzZlnTirfgps0=; b=BbcFfD6ou378x34E
 +lfKahWJgwLRQOHuEmnRNMRZ1LuDnn+ace1wORfpECD5JP45+DFFf55RSGQpnnDm
 g4oq2SS6SXnUWpqiv2hojSAf3QMMy081nvQV0Y/j0q4s0drb6jxyoeJ5cnsvEHJn
 dnDNu/rHPSnP2iLNSiynjZm75WdkCJ+QbRYEd3mFkHAql/zkO8jsei4nMs6p+d/0
 kb6h3Ixv5kxZfnWaa+DVxAj45ibGTeAXMQNpcR3B51HigHN1JJtNceUhLLV8W/qB
 C4nzx1ZK6Xf/8lMVkh6JFBBgMW5DSkif+N5/YxoPTvasOCfQYtkw3gKrdTnNG2iv
 eE0GQQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fs9ygk2sh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 17:24:42 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bff5c7035so55442151cf.2
 for <qemu-devel@nongnu.org>; Sun, 02 Aug 2026 10:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785691481; x=1786296281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zvGvbLstQ5VKSoO9OJ8ikq8pcNIFgIFzZlnTirfgps0=;
 b=c4Q91qzhKdTKf0kY3rU/UXwJvTSmG/bwV3WvIqtoLmQyDEIzkbjDaeUQdtzxqC1Knd
 PrE3RLfPz6p8R0qWImgpmeHvvyzYrI8Jybw0JKnPcxgdmdjvi00/4O9lIa06RRZWwdIn
 W3+MWJo0tfuOAxkc92zAt7gJWQaHLW8kpegIrMMP97m57vmv/N5vZnPkv7Dniz8e4Nkr
 TC2o/ttHr9YarrHSPD2MF+eeq0d3OkJT3m/Beks7BWT4M82oWuwsoqiDNizth1HHo/dl
 WTkRwlm6nGOhhoTccZyKkIEe5leIhraasKYbXF+QM6Ha26s1gzSQLaYDZrdy0WY43OaI
 kZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785691481; x=1786296281;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zvGvbLstQ5VKSoO9OJ8ikq8pcNIFgIFzZlnTirfgps0=;
 b=KBdQcfbAwAmbAEZqDgApFzA5iqcKqr4Xh+pKKFRNytMkdl3em8XMYIjJg5zFUadRJz
 O0eMmqJUZ5N5NVU5od1tNa70Shxq3wa6dG5z+Zo0oOmoP7gulIr3psrcjP7+Hw8YEhwZ
 yEhkEPQYjixc2jZLF8TsEUXu2oGm/ygovuvSZdIy6E4w2y+o/Gix4cbnAPgdvRv6tNQE
 SRL8oqD7GK6TUQswNPwiWfxfHd00uMcupBbK9H+GbZkqlXnhk22w1OEVHr4eGnW0+FaX
 CVEv0VZIL9iHq0oBA/EetxkUtg78FpdY9VdDpGaqYOJ7M+cabrQnxIBcm6us15QmmzMN
 kySA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXVPkkHTLUOIYnRnKk+ZsFV8XXwgm6sCpQRUsNl7L3AYo9b63qS2ZBmZtkuPjSMJdL2cj66B/kjd+7@nongnu.org
X-Gm-Message-State: AOJu0YxS/cPGWioKYLUZccjoPAXG03EQQkzUxPoQfR6UIoi3rdo815W5
 T5PMPToqf5RjehORD8jvtCrF1g2yGS3yG+p2s4LZ9TPhUflro2IhTYZr2V8hB7pZS0QmG0E5S5I
 suI8hC+RbogBEEMKLUyFmpkYyamkbC87d2+z/CfeMBkVnvY11UFg/FYTtzg==
X-Gm-Gg: AR+sD112gJwi1TOpC9IkwS93SPvQ00ge64+NGupNZoO8m8qIi+aE2wqHcvmGFmMoWgk
 FI3y3GUOeKPTSWf4LkBCmVgdvDpVZhVKwrGLrVYbKw+pxwrJDa8a5YMVE4GN4WyawzlIlc8ccsS
 c+XCA5YAyg0pZomM01qx9QTRUQtriElPf5yaltscId044Ji4WFan6xg/r++QNM2Xvz7A8LiVjO3
 ukDDWdiWD4uYnbFoxeQ0N7z8Oj25g8GxACVCRx5MvZRYuYWFcUGz6H4vR20sZ/S+29l4Uuym2Eu
 6aOU+FpJY+ZsIzgdZvbPh+AUl9FdmfnQ9uKdmoiaZJaaqiIL0K0j6eGizUdhdJkJYGgiGnZ7HTM
 1SGEDLXgJZBsRvTyuvdeplXT9agzA5CzwNQdrPHe3bC55D5G7220=
X-Received: by 2002:a05:622a:1f98:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52b5666e2b4mr175383971cf.1.1785691481006; 
 Sun, 02 Aug 2026 10:24:41 -0700 (PDT)
X-Received: by 2002:a05:622a:1f98:b0:51b:ee11:e71e with SMTP id
 d75a77b69052e-52b5666e2b4mr175383581cf.1.1785691480638; 
 Sun, 02 Aug 2026 10:24:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b23f6fsm122505635e9.0.2026.08.02.10.24.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Aug 2026 10:24:39 -0700 (PDT)
Message-ID: <af745889-6e76-4ad6-ab9b-b5c87d442833@oss.qualcomm.com>
Date: Sun, 2 Aug 2026 19:24:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] target/s390x: Simplify LRVR
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
References: <20260731185628.23161-1-richard.henderson@linaro.org>
 <20260731185628.23161-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260731185628.23161-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE1OCBTYWx0ZWRfX9j0MD5mQzw8i
 GU4c4418HNRzmK+aZcbJPt9MaSldgqm4q7iy4k9tQPO1ZPpa3iLBiWfr/gFSu1TBhD81NzZ0Dj2
 a7uETgH0deh7j60hBQEcjwYcu3azZ+o=
X-Proofpoint-GUID: 0BsaGowO4LesvY6BU-oMUZz4EbZNSfWZ
X-Authority-Analysis: v=2.4 cv=Gu5yPE1C c=1 sm=1 tr=0 ts=6a6f7d5a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0BsaGowO4LesvY6BU-oMUZz4EbZNSfWZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE1OCBTYWx0ZWRfX88QspdKfA+uW
 4n4sWmSinL7RoBgJlYqNJvEM/k4MI54hmS51tznd3oN/vM38H4SAWJvLy2xgm54h9xdPuTcsMax
 vw8r4lkVRRctkSC2IHAA/CsRWVRVmEVvFxu5IC3aDB2m8d3AdQtdPcwBY9O7p0GMQS34zYjDszz
 VAUjVzFcbr5GqZzPmh/fozaeuC/x0q9NMIaqGO4AUB03Xt+uDiEtNHtIlI8DYd4GhYoid6xqLfo
 TJzJvPy1Q9gFcFUVrlI7LsySmXrY7Le2wFBcmw306wigkpdhv8Hfnm9gfg+X7cYlp7GGZynVO0I
 X21KtInnE8uKRnyhOTGllshw+bAqUwqoVGrVpIhA9o+Wy21Ds1erpryKH+/xek4Bo5N4iSdw4Cj
 /L0EfyIHeafAiS6IghCJUp0l+H+5D3IY4XzwYzHcBYFvnc0mPuVbhI5JgYRL1xi9Z/WbYJ5fHkG
 Basho1vNflBzQ44we1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020158
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

On 31/7/26 20:56, Richard Henderson wrote:
> If we drop TCG_BSWAP_IZ, we don't need to zero-extend r1 on input.
> Since the output gets passed to deposit in wout_r1_32, the high
> bits of the bswap output need not have any specific value, so we
> can drop TCG_BSWAP_OZ.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/tcg/translate.c     | 2 +-
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

