Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E5CCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWv6j-0000OY-Nd; Tue, 09 Jun 2026 07:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWv6a-0000LL-C0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:58:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wWv6W-0006q1-8W
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 07:58:50 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659BnC0c2119393
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 11:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WV94LeCUWWRCiAQr1MOzMhlW2BYDNbcZEvo0GW87VEg=; b=EwcoBVjCZhrhb0tu
 /kIa2Ab+Iw0tU5MakE8+yUyMErn/6g3C4FJBdf49OYxYe+7zuBW3oTI3SidG6LoB
 X4l8U5oKb2FN9L0qkqB49qIhwst3ESwLLw/VUs64G4P5eoDaZ9y9/6pwLhLf+tYy
 qrsMBtRhoiQz+ejk2yrHUg2bJFniTWu+bRuSBxAH7ltT2A6OJ+VInJFfQJGcxIGl
 QFbwgUojYP6U68SUK4Zzy1GdWKY3eWCAPZUy/FRaeincWXSkG/nJmMffqCQhItsv
 GwzcIRHHWTtrJkzxTQWgvzD6Lb0mHX2AGHfG2dHw02MxSU1KVdET7Te58Z/vXAe+
 W1ecxg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wgkej-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 11:58:45 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51776d4355cso153571191cf.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 04:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781006325; x=1781611125; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WV94LeCUWWRCiAQr1MOzMhlW2BYDNbcZEvo0GW87VEg=;
 b=DHo3iS2tn15DzW8O4ZT+Yj+S27e5T0nsTAmUwno5CWOx9j5n+FdSGjBXqaEs19BLk+
 Exwv5KH1R1yHlPYIaGmQuDi3724U99Sa8v/S4Jcc4535QuQa+YL5ABanb9DeqB3EZAMB
 D08zZlKFRTRWagl+J7MRTZfHufj8MLQIj1OqqM63Dz1lPV9te8FVZOF7o2OaLuTuirAJ
 XXYwv/tzC5UIYKfvfyfWnWhH04mEbmRTkDHz/F2Gp759yTuJ9MBquhabd4PX+AI8vGHU
 NH6FMRYjbyH+3a1MrbIRzeCFZLDNiMk1vu72R+RFtpzY9Ec2VmrtNZkji6oOVV/9GFBN
 Kymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781006325; x=1781611125;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WV94LeCUWWRCiAQr1MOzMhlW2BYDNbcZEvo0GW87VEg=;
 b=Pbvc0i6yhuqmKKHKrSNf+un8ViiWOzR/GGWlDCcXExlI7vUs/C4XP4au5JLuO7VX0Y
 0qvlW/IH8S5oP9qgPa6+T0vDl1AmPub8Db/bpIb5v3Wsharaw/af+PjWzt/hVjagWf/1
 R3RLdqmoKIV82Erd1xnhagHesLLF/4MgREOhi0Um0cwxkVdKY3OP2RleOUsK3He2CYlB
 9Ohs8iEcagcG8AJRF12ZcGByjd7FxVp1mpc5sBlz/aE/EG8LzMbkzgVAmEVbi8SGnurP
 87wvxwiJZyBvGc7ObipYcou5vAwxfCq7CM31CX+EFXvsxZzfnwbb+QrQf5KAmEzpHMSX
 WE7w==
X-Gm-Message-State: AOJu0YzHDnU1YmSlZzPrt6WwYX8pINrIa2h9D+0gJ1WOdbRDTsCOu6FS
 TMrzQVsm4oZTrGm+QMRCLiIjUT9yUuWTsM9VosznIsPMHu+Hvxtw0pvp9r31fU9ke2FMei0KAwG
 /OQyUXStLOwBabOVGVStFBnPyG0ZVocOfMM0x7D/ZdXDVugYCSTjAmsbw6g==
X-Gm-Gg: Acq92OHdctB4VcGTKj2hDAAj7usYhb1TAI+kVOaPNjxHTOW4gmtSepQnT+mHZ7TFdEu
 gK5pHEC7FYmDE1F0ABP7jA/Hjaoq8HkFBnQMkrqXc28FvB1Kqz8hPsTwVCd/9PAYLzlo8azM4PW
 SXNDJnzzsGkZgBp6ye17IQVoIwaCx/nrcWSm/5VaC72cqHi7O0B+l8kHUSX+LCmn1DlYrn2EibB
 Ltwf5zBOorYG6+ZIMYU3aaNjf0SjDpGxmEfPhYBIi5Ffb2PA+yfxIIUBGBZvruk2yRO88MWcZ4S
 vXoYzyw5YZTSqNOubUCWX99plDG3Czxajfgnmw2V68fKJ4+s105Kz8V+Fxq0gu+nm1VumJSJjvX
 hF977VPT37g6vYv66LaDWJQ3/pyIDL8xb7sQjJ37ak0VNy2qx/0eRllpATh6G5g==
X-Received: by 2002:a05:622a:2c4:b0:517:91e5:108d with SMTP id
 d75a77b69052e-51798894807mr196167441cf.42.1781006325015; 
 Tue, 09 Jun 2026 04:58:45 -0700 (PDT)
X-Received: by 2002:a05:622a:2c4:b0:517:91e5:108d with SMTP id
 d75a77b69052e-51798894807mr196167261cf.42.1781006324568; 
 Tue, 09 Jun 2026 04:58:44 -0700 (PDT)
Received: from [10.156.84.244] (113.170.88.92.rev.sfr.net. [92.88.170.113])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b4d988sm8539854a12.25.2026.06.09.04.58.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 04:58:43 -0700 (PDT)
Message-ID: <154d2b26-87ed-495d-8dd0-f8923f474058@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 13:58:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fpu: Handle all rounding modes in
 partsN_uncanon_normal
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260608190155.637067-1-richard.henderson@linaro.org>
 <20260608190155.637067-2-richard.henderson@linaro.org>
 <CAFEAcA-u9nG8cnX2_suYNZj_+L3coWL+DT9VdewbO_OZfDR70w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA-u9nG8cnX2_suYNZj_+L3coWL+DT9VdewbO_OZfDR70w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDExMyBTYWx0ZWRfX9ItEdH/9z/Tk
 sNw4PQCYOq01Wmcrng3I3qAhWRGAufXAJng+/cZ0T3X7qgJgXVx/hN+pjBJ0nldb8E4gSTTkYB3
 GZ33dE0m5YWnvkxX1glAIrKu6SlYBXPuHkRI4MurSLsPZkpM0wr0THz0Sxdm1zUD+EPkIlR6Lt/
 2+W7xGoXar4aTfESDAch2Cpdd/5uuOHNn5Z2/IAG6OaFWDOO4PbS4zhgHcTF1Sr5VFW1ttRyeBO
 IbsJnMM44eMEMtE8fEvaQVMgCtKnRgoZ+s0NpT2yO+rl4lfx1jeCYaphMOtQvyz09bkdc2fckbr
 VmJa7LDJNgEjDq8t4U8GsiwYa440T8x58N+SnVyDUaulCNYbro0bNBvJOdd3V3GUCR4sm2sGjRP
 adlnO9/Qc/8fOdj8eY2g34XJaAx5JS1UpN8jGhnvtR+qxBjXLC0RNt7TtTr/1IRq5wal2HJA70l
 X88OBwhsWGM8a53yaTw==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a27fff6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=ASywmo1ADVsXjDI2RVyDAw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=mlxSHY1d4UzQDx6zSToA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 9r2VpWjtKV0w9Ofh3IUQSs6MigvVFSqX
X-Proofpoint-ORIG-GUID: 9r2VpWjtKV0w9Ofh3IUQSs6MigvVFSqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090113
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

On 9/6/26 10:24, Peter Maydell wrote:
> On Mon, 8 Jun 2026 at 20:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Missed float_round_nearest_even_max when recomputing round.
>>
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   fpu/softfloat-parts.c.inc | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Fixes: 72330260cdb ("softfloat: Add float_round_nearest_even_max")
> CC: qemu-stable@nongnu.org

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> (dunno if hexagon hits this codepath, but it doesn't hurt to put
> the fix into stable)
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


