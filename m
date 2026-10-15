Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 851BFCC6B39
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPTS-0006IM-J4; Thu, 15 Oct 2026 13:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPTP-0006Hr-N0
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:42:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPTN-0007I9-Mb
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:42:35 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FF7aWt2999155
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 clTE/mWsu2FNMANhCCIkXwWLT2EwW5fLVnNMMfFZDkQ=; b=QjZwLlkUqvSred3O
 uRwQuHSMuz8X5PrUovIRkDXmACvNw6fV+7fGJXZPq5BgkR1fOtxrBF32u7xVs4Fg
 Ad8zi5DCZceKSa2Aj97K7EO+8nkRqs4MjFRtfB4+qYEoMxwWRfQN4mR0Cb6rGyKQ
 +i6tlfJqSLqzAGdnQTbo7cdsUDGmbJr14DEeEzzvukZ3nNv+8lE9FsAUctNkn36w
 MGvmd9ZQbVN5rfAGTazJBFuGHVRlUPtvdWBHENhD+X2FhBMBs6A+tR8WcChPmlL5
 7mi8C0aBIQfWZCJaK2pNCT9OZAXYTHcq9qpN2DKvz3sUgxYqiKZg0yzo51QspnTy
 PyAUeQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hausm27c5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:42:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-357e2bc3b1bso8687468eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792086150; x=1792690950; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=clTE/mWsu2FNMANhCCIkXwWLT2EwW5fLVnNMMfFZDkQ=;
 b=EdDHDKji8356kwnVw2BPBOWNOoFQCJ1w6wrAj/bGmXyXdfo/WgstbThTSFG7QctA5k
 uHTujLdvZX0MnBzw01SLEOkhRtzZBRNdjDsmwym/oaoUOQFlxJahqiTgadmu9NTH9Yvd
 9dLjQLVqbUS5+WQlglhAjOm/tRIwwefKRPJP3DYc/okZJ3luRuLs7eEoRrb6rQZ0iB8+
 Pjo5/TifS6z0um4HlN7eGm6PRZHEtzmIWdCts0im+NSAxmIK5riw/tGyTgN3OIomu+Ux
 hgiVjn9FT53PTMGAQhVNThQBbryrPnPQeidh5Dkel5RRTE3xIC3KDfxCpz9UK8IXg1h9
 mu/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792086150; x=1792690950;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=clTE/mWsu2FNMANhCCIkXwWLT2EwW5fLVnNMMfFZDkQ=;
 b=cpsFQXy43PqObvp7cfrxyVaZ+KSXlENQFWlIDVCuqgcUa/i5BMcHmVGJ3V3VGFvjLw
 mwKZngozt4X2uOPtx2UAdRms04uh2vXG0dp++E8OyTNe9mNGkz+a02WKnrSHGWINO0HM
 LmgxrFAWZUByz+TtRuXmNa5gteI9VwwThjMIEbNg+gzQff3/PmnepEVj6OTjPg7Na+Nc
 z03Nw3j9AXBEPnXBY9tCcMOxuMM1MjorQ3g+RlgvANoQHbxPjOJErzkIqPDKIE5dPcGY
 Ru8TBBMVbwPqrpvRhbumDI8UZGq5D35yGThQzwuzjIjVQLneMH+pv49/6Ifw8xO/e4X7
 ibMg==
X-Forwarded-Encrypted: i=1;
 AKwUvByxtXfO4XOrgIBJZtGcvQgvxb5ZAOYTSkvrpk5WmQXRrfsQwlOvU1odTcfrNtcsB0WsM9LM5zXDFI/M@nongnu.org
X-Gm-Message-State: AFq9FYJH5sF5EiGLoM09d2PGHJ1CCpqr8yO5l4yLMAWPnQJT/tr9lcns
 zXacw5Jj2ZAwwMGhgAIpKI5xFMNegY0Eih5aua4RLZuWFU8/OttFUd8PqZaDXytPe+XlSvNYR8k
 A3jALF/U7f0CJRFG9tA8nWY4YA/7a3CsWXuqO92hxtuUDMPJe0xyqdHNMHg==
X-Gm-Gg: AYBFou3a8dq5+pVJEEN9arLRNWZHczwTy8Qet7ht6ax2ro2YqMOQbgnwDE0RFUYC8LU
 JYUutsTKlYyBY9N4B1UMpVF0HfF4+2290aYwkoTQdL36Ct0KsZYfI9EzWeCOvLBSHwWjSh637BY
 RkHzcG9q8if5DJwJemZl2K4VSvm+P4Kj0tVoHuXiJTc59vK4+ZCRCwpgkjrQjfq+Sc3rXvWmGU7
 P+9kqi9bdfba7RWcaiKFC9weWVnjza7OZhjHoRTx2Ej/vRNu8yVLZKn9FhEMYCC9mQfYlrTA4hH
 xwI4WLIDQGeF4M+rK2LhYPkQs6BnKctkY0DYFud6Phy89ci0D/bLCBZlPuRTCC8fZGHa/retl5Z
 zThV3FOc8YxZACkJuXQCmQKWwVwu1QCO7wvIYHlgLEPUdFYUJayjcjDbFVRDIGY2vyM0Mmg==
X-Received: by 2002:a05:693c:41c5:20b0:35c:ba31:6fef with SMTP id
 5a478bee46e88-35cba3173b2mr10980962eec.36.1792086150303; 
 Thu, 15 Oct 2026 10:42:30 -0700 (PDT)
X-Received: by 2002:a05:693c:41c5:20b0:35c:ba31:6fef with SMTP id
 5a478bee46e88-35cba3173b2mr10980922eec.36.1792086149543; 
 Thu, 15 Oct 2026 10:42:29 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3605859e9afsm438872eec.23.2026.10.15.10.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:42:28 -0700 (PDT)
Message-ID: <9218a003-b19d-480e-ae11-cf3ed2b9e592@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 10:42:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/12] target/riscv/cpu: constify cpu parameter for
 riscv_cpu_mxl
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014210526.104215-7-pierrick.bouvier@oss.qualcomm.com>
 <b99355a2-a424-41b2-978b-8938de06cbda@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b99355a2-a424-41b2-978b-8938de06cbda@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PCbR7QaXBzNsN_uOYpdpPziGl4LnCWLh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX9xpi1aqyRPtC
 VGJKAdpU3NFfanmWpn6SZkb6U/pLxpvFY6MWHWAJ8PcEaubw36k3jQn+VkSd98xkNc5B7CYblHA
 kpc6EP4/znfTabbwWxx+IUs9+IVMXD6Ue6mE0VGSRjwD5lqnHWwGeitVxNZlCs2afBsIUn6fg0X
 Z3+iRzPWRG+lwAQ1WE6saSwebIuB+Gfj2iW25qDWvwJozTgGjs2njjekUpz1cK3RgLFliyvXSEs
 9sXSZ2qd+7DiEI58pCiWS34OG3uTIGzy/kIk5oDyH18DiYJNMEDaXqlsY7tYDYNSoQv/YH74oqy
 lBXYs23hC648NACctb192s01VboiIOx1gJoQLYTLiYqntWzHt/VNLUIMKzBDwR3aovF4CCaG2SN
 qV5EQRf5/NU3EPP0olhEIQCn1ULmPwgGrZ+IOSaFZC8jUSWFjmCezypBmXRBFqdlh+sWf4AaVYm
 BpHkd2fI7xAynNjXM8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MCBTYWx0ZWRfX8UP0oNa/l7Zm
 f6yspZ81rET7t5Trs59jm5GgA9QrBLknGAU8MlT8A7gJ06BMPpBAqEWSv1cK6S5+nt8m2xCmukF
 0o+pfaSlNm5F/X1xLZ/izC8q7MnQBWc=
X-Authority-Analysis: v=2.4 cv=Eb5d0/mC c=1 sm=1 tr=0 ts=6ad11087 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w896OpFReYsct-VA0D0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: PCbR7QaXBzNsN_uOYpdpPziGl4LnCWLh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150070
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/15/2026 10:37 AM, Philippe Mathieu-Daudé wrote:
> On 14/10/26 23:05, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>> index 8c8ffe94cd8..00650a66dcb 100644
>> --- a/target/riscv/cpu.h
>> +++ b/target/riscv/cpu.h
>> @@ -755,7 +755,7 @@ FIELD(EXT_TB_FLAGS, BIG_ENDIAN, 33, 1)
>>   #ifdef TARGET_RISCV32
>>   #define riscv_cpu_mxl(env)  ((void)(env), MXL_RV32)
>>   #else
>> -static inline RISCVMXL riscv_cpu_mxl(CPURISCVState *env)
>> +static inline RISCVMXL riscv_cpu_mxl(const CPURISCVState *env)
>>   {
>>       return env->misa_mxl;
>>   }
> 
> Reviewed 6 weeks ago and in Alistair riscv-next queue IIRC:
> https://lore.kernel.org/qemu-devel/20260901095229.72018-17-
> philmd@oss.qualcomm.com/
> 
> Anyway,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 

Did you flush the rest, or is it going through all submaintainers trees?

I feel that system wide series like this should be sent on their own at
once to avoid having a state spread across multiple people with
different latencies.

Regards,
Pierrick

