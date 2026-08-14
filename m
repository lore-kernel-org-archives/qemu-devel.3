Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1CEC5CFCF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wukdD-0003xz-Qu; Fri, 14 Aug 2026 01:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukdB-0003xo-HO
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:39:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wukd9-0002S1-VP
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 01:39:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QX6O652714
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:38:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N6DSr/eQoc+sbI5lW2OXq3vNIWot91DT33wmH051d48=; b=gel/RY/lxDjmvRTO
 wwZYpqqsL4LwbwMAz3t31PdLtQ3e3J/Orla1xyglGaW+QS5C67liu865Z1RMA4kF
 kB3DjEjJdHj+bwlR3cWCDExT1fW/1nyZcMHjxky99CexJiw6GJw2w5DJmCVHg6G+
 RTcNUgWuQ/EMP7RcOlupq5mVaaCw8izluqEiwSW6gGBkU4JsDBWmbHeybcpumena
 AtY8g1PieTID4KrIFo0qwsWBPOABlVUORzr0JnsnGuKeqjp8/2yR4O3+z8cXUkh/
 +jjnZQ7Xi4cnLkaeV0aWhD5zmRnGP5DWkWpXjftezTK86RsrW5SNYVWdVgYcNeoG
 QnRk5w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1f94kgec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 05:38:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bff5c7035so13147261cf.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 22:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786685935; x=1787290735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N6DSr/eQoc+sbI5lW2OXq3vNIWot91DT33wmH051d48=;
 b=KopYLjlPQaNiTsH4hAx9V3JjxY2yI4zm+neaAWMRSnpZwM3ZoMSnKIZracjCFa0W/S
 JJ2hux1ZtSfk3wHsni8R6lyWlW5LOAzq0ktnTqk9d1h5weNYNAKCE1G5O05kg2HObU3z
 G+oBlANVtD3Zdmovu47oZ1LdKjF3l9x1Iw8ZvCIB4d6io8K4rWflaGctFEA9pOrG8+wI
 E979bzQOMcJOx9grAZ68GxD1yjZpOpb/wuK9Fsfk7lX80NZL+WG6JVrOtNTetoqN0sC8
 B/gIzN7f7vGxpiSceHPt3nnvjWzLRHvS7/QRvI1+gbvEDk0sNuf++amHJ+i/LnR5WzXP
 mZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786685935; x=1787290735;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N6DSr/eQoc+sbI5lW2OXq3vNIWot91DT33wmH051d48=;
 b=nKobaGmxyEG89TwRZEejD6Opo1HTlktXRbxoKC1klm6j4v9Fl3oqwC7KqnXYH2O0rA
 uvUPednG9KmOaZii2YvKMMtckbU0VEEmPyhNMinq/JZL9fJQkg6MIiAnFoYW6kGm63VT
 sBSlbIygxc6CoByDusYaUE4NzPd8S7V38jkeLPfJus/gqaoGG55cHOcLXOzwKPn4wKMd
 8KCptg9llEbF4JyvO/EZyCAZYBPvh4YUKdaH7OKYZ9X1+uI1Cvp9CHDwyAcNfPzvoUph
 wL/7dmMV6lpw4MrB35YYck9cghWYs2TOHVhToMOVGsuvh+9jtnJTQgWwCTStl/G3ypPf
 w68g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcMa/tnrnNDzOWL5da+tsSRTKf7LRNLpMBsbtN+ykuSNa+uL0erWyNtldV8yk8mv9dvMV6VDF/ItUU@nongnu.org
X-Gm-Message-State: AOJu0YxWVMbdHBoHtrb3Vxz7EkC1k3xS+JXuT3avYreZfpsNJyZyPm70
 jSa7e3S9Ovhef9JDLyvb//5BxrsMto/eE1Zm5u/78NkYIaTVx19mnz83emJFf6uPbwPEcHAHlcx
 XrOBxp2vqbX1fxO6MFdjpvZLxlbkc5tqWq/RXbdXgtgcPaIm8B3LRPRYV7w==
X-Gm-Gg: AR+sD10MyoJVlEWndftdfyQ23/2iATLkDa0bPqgxpwp7Y+dFtz+8g4+pf0j67pldGnW
 V1Z4cBFxxEi6RYaG5vAffmOZdjQ/aNhVhe0/juHlJW+Vg7013LeHQgWG+fm0xWNIik9izMp5n43
 nOhg1t1aCOgUz41XZdNDKSa/ddu6X2/4prVcSAepNQyARpXkVt/auRh2OWxVWwDAAPDkQcpUObD
 19PgDUUWoKPZSHJqrDQZDXm+wQKNsT9d5Zmaea8/aiFGE8wNoyj1fsNXcM0wbMBF3LlMFD8DKHZ
 ssq3XGgHhsKbL5v1dxTY9jndEeDJj28vuhSwyx+/lEvH79iW8ed/Jw0dY//D9XJdqrzWFL0WoKE
 k3Y4jv9PvdYpjIRp65cohZ63Lm9mELgdnLF4=
X-Received: by 2002:ac8:5cd4:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-52d8534fa81mr42267441cf.18.1786685935304; 
 Thu, 13 Aug 2026 22:38:55 -0700 (PDT)
X-Received: by 2002:ac8:5cd4:0:b0:51a:6feb:dc8a with SMTP id
 d75a77b69052e-52d8534fa81mr42267051cf.18.1786685934923; 
 Thu, 13 Aug 2026 22:38:54 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988af1068sm24487485e9.8.2026.08.13.22.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 22:38:54 -0700 (PDT)
Message-ID: <7116ef36-17b4-4518-8c10-dd49c7dd18bd@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 07:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] whpx: i386: synchronise PAT too
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260812082814.27217-1-mohamed@unpredictable.fr>
 <20260812082814.27217-5-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812082814.27217-5-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0MSBTYWx0ZWRfXxuhCR35Uo/Te
 qEt+2XJrGXGQj4GBefpuL31xKcAwSAAorZ1zi7l2kMfMv9XGFqvBCXA2M3RygzwCb3mvmjExKMv
 Rid04iyqKExt1voTQZ6g+z0ZSg9l3us=
X-Authority-Analysis: v=2.4 cv=VYDH+lp9 c=1 sm=1 tr=0 ts=6a7ea9f0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=NEAV23lmAAAA:8 a=EUspDBNiAAAA:8 a=Ab3XqzFObrGmvFtmBqkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 0EbmjW41a60JbmIOdxFSKHhj5IJ1nZNz
X-Proofpoint-ORIG-GUID: 0EbmjW41a60JbmIOdxFSKHhj5IJ1nZNz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0MSBTYWx0ZWRfX1fcyWxFqhpL6
 A9RJRvtKcSrsBj8nEh712ogDdck5y01Vrks6Q7l7BQ+sBh2EIUaoTpe2Yc16nRipLw3PiaDaIpF
 ujDzADeD4wjtIba0O0LuKHmohBqgGLoY2KNf2oTNUayOZvpzf2yZX1bfiqAV1ATrkU28GbPlueC
 vnqvwwe+IRhK47SG9qMZ0AFlWz/pnPkVo2LDxXE1V/jI8dl1+5U4IbLulYAi2pIFv78m5W3I8qp
 DrhdyUaAAZslNuTuEdFXzwVlkdC2VdT/EZdU+HZM0lqpBIeTLlckM9s0wyq1yBHHT5+9WHDxhBT
 /zMK3zmypztw5Fczy90wTS7OuVLG8LoaI9pEGgz8tOOjdSrun0h++sIf5xVszV5dDnpn2GrUXAV
 0m2Tay+jy2shgCPqMaODM8dGMhlNG9iFFnsF6aO4xRdGV0lhUWK+0fxxbl5MSyQhMhodhit35sM
 WybYO7tHi0nMeMhYUDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140041
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

On 12/8/26 10:28, Mohamed Mediouni wrote:
> https://github.com/cmspam/winq-emu hints that
> this might be wanted for some use-cases and
> it's a step towards full state sync.

The link might disappear or be updated, maybe include the relevant
justification here?

   > Linux uses PAT to mark virtio-gpu / Venus shared memory as
   > Write-Combining. Previously the partition's PAT was not
   > synchronised with the guest, so the guest's MTRR/PAT cache-type
   > computation could fall back to UC for memory that should be WC.

> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/i386/whpx/whpx-all.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


