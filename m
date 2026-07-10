Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 479FAC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKEl-0005XI-Fr; Fri, 10 Jul 2026 19:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKEk-0005Tp-8g
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:02:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKEh-00036O-7r
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:02:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3DLC1830722
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wt9OPpBwPRNbzHZ+MXqddcVr4TGYZ6bBc9emh4V4MlQ=; b=CdOqsMRASxB0hZxG
 lp4SMMOIfz140FwHwao3vZDAx7D82yAmq4MHdb2qu3ABSW9JnBAIl6prH122Yl48
 aqJdbYkcu+upOFXWshZsNSGTHc5YOyfKj09Gv9KVkKR9kB4x8nsi+G1W2x3ujI9H
 5BxZ+6TCXu0d22G3Gv05sW7o2hp7mG1eQnxohJ0icfQRAhx0zvm6wxgs9QddLF3I
 ofFLLs6W2quKxUVod/VVZ+QZ/eRe7vc7wztBz8bDrt9pEdCpv2b2sOfnPrEl0ooH
 oHjDPekLQejoKipn2aRheA9rRH15Zhj0pFMeKtC/spQFQU171TUKHPTBHuV21jM8
 TVfmYA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanweckdr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:02:01 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso407206a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783724520; x=1784329320; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wt9OPpBwPRNbzHZ+MXqddcVr4TGYZ6bBc9emh4V4MlQ=;
 b=TejUBfJs4yyb5BwLLOt3BXMRc+vdmT92KQKol9TplvygDLekJWC0MAUcqm6Ef3i29W
 2ll6FZxQNdH6Jr+MHYdTbWvr3XXw5omMlnXJlkPz6g25sOtxsa9+fJzR3EjMuZDT5iIx
 Ima5GnrC7y1ZKUDdfT4gBXAPuDqemO6MH2C00LaoarJey3mVlV+O9uw3kvgFIg/IZzVH
 xqCzL26SvMy7ajudtFdGaN+gz67l82wpJ5ImHQBUMwb0XCDp+WDSRgvjVJ860uTUM4Oe
 p7Pv2zN2k/UwtHNo/N9VEmbjy5uXUqXo2i4GGW36s57vTvB3HyydCf9tsQNzic39W1VT
 HxGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783724520; x=1784329320;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wt9OPpBwPRNbzHZ+MXqddcVr4TGYZ6bBc9emh4V4MlQ=;
 b=S7lrJO3nuQL/Oe0VriI/RQx9OpSjpAcsaKTiqauXZAJNq7BqRyUkMszik0ULoMpCk2
 C3O/GL/zHmO+eSablftrrJEgEYf5p5CKnSsXSNDTK+7uxyZa/roSspbgX1hIXdFMZRPp
 9v4gE23/AW2VENMIUheij/LBfEFB2OwzKEDAvX3J1otlIGpZIQkSwo3D46JwxEeT0DDE
 +RkNQ4PC4SiMQiM5paoLkYxMKKIq1fQIs67B7j58/ZGLDRoE2sYQW8SscL4h0kqztRzz
 QJjc0pe2IBdksi3ZVhhm9bBL8+QBFSenyBbt/sQbvR3kWWyTJK73RpSLfLfHEEYN/FSB
 4YNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ronwm8HeDzRSGZ4V427gpnDu3h0wlGFlRUlt04MusA9DS38BpmYAHrVERl34yIEyWNUpPL1ID973hBA@nongnu.org
X-Gm-Message-State: AOJu0YzZ+vIZrwu22rtCfPcy+e81ECpAMNWiXEJBtkVVwlRdXwlMLN54
 1wAUIUvHsWFIEqpaw5bqAVYlWGx2BBiXhBtYY2LYl79DcYvFOPIGXzyQRWSb/mZ32i6Jc17fYS+
 jdx3x4lBkA7UOhIi+zHilHoTHXkNyQ7+NmvzZGJM/EM+L76ISfJWTzQQfRg==
X-Gm-Gg: AfdE7ck0HslvPcDOqR1wfSIF5w4KwP7la2C9Oz7U9cdrhm3STOhPgye7D8OTPOPzx+w
 H4p3MIeFywzGcDpV/+Izu8ibN/LxSBmJxQHTTP7KQZOoR8fZpGWk51ERVhUIzzK5lSNqrWicZha
 jCA6p7uMCqCDf2QYR3qJU5h/eqPXLvV2oLhZcwG8ngxrQKYo36tywcnrfv5+jOzoKxPVhMe5kSH
 hnoY7QCchgYCmxirR/KJJ5ADx8Q+5u/8XwX6ekoXMcfESN4hnSU09cnhACAMDCmkyW9XPUr0SWT
 4JVPYjgdEFAH6L7yJeuy1N7/3yYvHtnnh+e24CHawCTJgz5rB+o9RsPOtMH6fe6ZQYH/pb86s0/
 LtA1dbHmut6IqrFdPQNtqTl/+uUMyO4Drb/T9lg+gCVR2O81KSm3LUWeixs9xdkU5sApzziPb10
 oVGsA=
X-Received: by 2002:a05:6a21:3394:b0:3a8:21e0:1ffa with SMTP id
 adf61e73a8af0-3c110160cabmr1157494637.27.1783724520515; 
 Fri, 10 Jul 2026 16:02:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:3394:b0:3a8:21e0:1ffa with SMTP id
 adf61e73a8af0-3c110160cabmr1157443637.27.1783724520090; 
 Fri, 10 Jul 2026 16:02:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43861505c88.10.2026.07.10.16.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 16:01:59 -0700 (PDT)
Message-ID: <5ad9b263-fad5-40ce-a8d2-82c3c626afb1@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 16:01:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 29/98] tests/tcg/meson.build: check host cross cc is
 working
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-30-pierrick.bouvier@oss.qualcomm.com>
 <1425950c-0063-498d-9b61-9101bc68f60a@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <1425950c-0063-498d-9b61-9101bc68f60a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5179e9 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=2aFWFHZrbJ7EhV8P2DAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIzMSBTYWx0ZWRfX6V0cguTGLoX7
 l+fh1qjiX0BLTYc6N292R0TfhRCfiRTr7K/OESzZyCMp+skXOOtzjd89x8bfK1ombYmYi7Cqxog
 PYXhIUvJ+NbbHfhF96SFcRm5ZlYzaf0ooYgf0FK/oLG40CarSwx0HRgualGNQmUJnDrg5qSDLdq
 cGZCfjebPVFo9ILJyZIh+43/WJn1wT71ox872XLDPVvSN1j6DbFZyjX9RMOvKdunUWcbpDLZBIU
 QwmZL1ozvW3dnt6lZGkp20SdqsXHx/nTIBW8aZIPNmFBfTAkDN8blHVpUyGpq2zVnEHiZG6uTBS
 vYIRVVqA8lumaDw/tn6kTHms6Yen8dlIroMlIWKKSd5kM9i8PCyaDhd1/fhRvxCClrDgmaJmYpc
 pyLm4MENcUHAKL3Jrw8TmXAyyfFHC1xb1KG5q5VqXhuVbup4Gc7slfxo/C/LH88jFZv6yE5mtGL
 1kP1UOC4X1Oa7K5h8IQ==
X-Proofpoint-ORIG-GUID: 8U4VBGrPGOaMSGzmWlvllS9uZhJaN148
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIzMSBTYWx0ZWRfXxYhpBAA5w6KO
 0Jh1YP4W80Ctr6EfpYbmUsCtcGv1mqSR2Dne59ZpTfxwFDpwq/AxwgkadvG7HCbDCN6a+XuUVSX
 GyUJQ188lgRB18tlGsSvjX9Bjyj8RWA=
X-Proofpoint-GUID: 8U4VBGrPGOaMSGzmWlvllS9uZhJaN148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100231
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

On 7/10/2026 3:43 PM, Philippe Mathieu-Daudé wrote:
> On 10/7/26 23:42, Pierrick Bouvier wrote:
>> On Fedora, cross compilers are provided without runtime or header files.
>> Thus, even if program is present, it can't be used to compile files
>> directly. Check this, and fallback on docker if not working.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/meson.build | 13 +++++++++++++
>>   tests/tcg/test_cc.c   |  7 +++++++
>>   2 files changed, 20 insertions(+)
>>   create mode 100644 tests/tcg/test_cc.c
> 
> 
>> diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
>> new file mode 100644
>> index 00000000000..b8a0dae6c8a
>> --- /dev/null
>> +++ b/tests/tcg/test_cc.c
>> @@ -0,0 +1,7 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#include <stdint.h>
> 
> Why include this header?
>

On fedora distro, aarch64-linux-gnu-gcc will compile this example if no
header is required. By adding an explicit header, we make sure it
provides them, which is not the case.

>> +
>> +int main(void)
>> +{
> 
>      return 69;
> 
>> +}
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


