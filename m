Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35774C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8hj-0003iC-Ji; Tue, 07 Jul 2026 12:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8hD-0003d5-2A
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:30:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8hB-0002fi-4a
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:30:54 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT4j94130349
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 16:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aM07CAE5GFvsV0+GQHeQIk2WeKoXx6OGDZx9o1YM4mA=; b=bI5gNy6fZ2uIewVk
 7BgHamozZxd/ZIuRuzGrjxV4qWMw+WnPZHb0dVYFNFXDYI943xKl1mdbSeFZ4E6G
 HoNpTrLarACdUGuaZVOoRaJPioT5L7MGsSt2TgQRBgtmWbPiDdXRfm7eiZ/VUczR
 fy2r8ZXQXxluaBpMVUkRyZ6dAYbslmqB9Cqh78UU5Zp4rHsMR7sDj0LVI5c1t9RH
 Yq1A3FM1dVsLlqKQs7EjatQF0qoxfPDLV941scmVO/rh/2ZbGPakboxfscOIjEhg
 JffODBH1ydpmWD8nr/LFhtyWYTOiSZgucLxuAgIbJThAyS4eQOLebNUtMqWJFBYy
 O0q0jQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15b108-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 16:30:51 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9aa197d5easo1127237a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783441850; x=1784046650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aM07CAE5GFvsV0+GQHeQIk2WeKoXx6OGDZx9o1YM4mA=;
 b=A8Nl2zRQUQcwR+R2ss5cgLk2coF/wjVlCYBPSRuUZM2iw1b9e/LXC/bteZADZ0RGnp
 kr0ZdeLzWSOxSOlQlct9CRwKQFijhadRpdUwZEsI66QbHcWFH9NqTQ10H+y5toQ3JOQc
 pb/jN2ul1sI5TDMKZT0vqT0E1qSQP+4e6Wa8vkuC6zp9zxLt9K/somTm9lCWeWDHnTLQ
 74jOso2HZwycIHXVB47C8U14TScIHRg5OXdAN4Tg3PsMqnSlGqNX0X+2V7V0qop7EUYM
 ChLrTUR5CUv2meXNoUT18w9CTfwOr0fVHWSsugCLqDGB8Fcu30tg+fq5fElk0H4Jqwjz
 fpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783441850; x=1784046650;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aM07CAE5GFvsV0+GQHeQIk2WeKoXx6OGDZx9o1YM4mA=;
 b=MvC8OQJ2+oO486/Ikv+tPnbiVkFNM+0/JtRTDIbSGIbyhqRcns7A8M1WfDS7EJgjOZ
 s0iCKLhvhcFs9OJwMrzy4+8hLv79eEUXW1WUuO7toTxYPJCbdD8cc1XDCFLtRI/eKS8f
 RG5fyiPy8KQDrOEibFkqYmT/shjvdQUr2rr/SKf9jXinIpA2fWUv7r+a2zkd6JAzDN0h
 Jtq5MIxNMlWNXgZ7qhk11fqfCA4lxEdciGkE25wuV8DzCrHlZaC6cnb4+tZs3h+LcEAS
 3VqBpcUMLc1UNWfbhmx7HbzstRsNDQmnUatR7mIDSS7+FJVvb8+A6TxHc973Gn7TxXLJ
 NWZA==
X-Gm-Message-State: AOJu0YzTY5lCPhMT7Az0HBhjrmE80C6aeFEayjAvYZAUvKWBSlAqGr/S
 NAEFrBpeDIf90NM4qUkB3ozjhngecndl1xtu5b2v+YplAavB0TPlfVdi/2bWm65RFS1V2VRwY8y
 qoaezHWhKA67JFGqeN8xX8F8/CnX1OQtrUDsXcyfXKo6L7g2ekRc4aifQIg==
X-Gm-Gg: AfdE7cmzX5GbiYytJl017H0ycZyKJ5Si6BVgU+an0d16YEsAAD0kBABexs6VRnTtC0Q
 2hHIAhVdHSlIYQiX3fv8AE2rBMhPsW7VGVdZw2kSMNZCyPuJgYSbhULCv4x7P+fqF/pht8u9HoK
 1+xVRsVTWAB+r9agbmWEfVIiFCwPlYoWlOF5bSJo2RalJgctsD+nBl/UjPEgsm4nYcsl8s8gS5f
 alEZrPC6wMQe83VzntVtIU+Vags9zE5tWNoSLpu7dgUwaBEcp7cJsY+7tQWcwSVMxsuUqf5iNOo
 ea0YuSB8dSgTwwx0Bon/RJgzxWRIJjTdkR1ikkrX4dBWe8Tj9dHWlWgSg5hp9mF+woQmP97sjaC
 MRUBvKrWiKkzvr3/UAEDdaQmFxTT2lw6SWV+yPo9U3zdI9EBKsZUa0QqQcg2ZzMh9YiGTGZS2zh
 ez0N4=
X-Received: by 2002:a17:90b:17c5:b0:385:39ac:fe4b with SMTP id
 98e67ed59e1d1-387d92f2e6cmr3599863a91.17.1783441850296; 
 Tue, 07 Jul 2026 09:30:50 -0700 (PDT)
X-Received: by 2002:a17:90b:17c5:b0:385:39ac:fe4b with SMTP id
 98e67ed59e1d1-387d92f2e6cmr3599812a91.17.1783441849717; 
 Tue, 07 Jul 2026 09:30:49 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311748394acsm10344712eec.8.2026.07.07.09.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 09:30:49 -0700 (PDT)
Message-ID: <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:30:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
 <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMo8BfJg09ca6Kxw0WLLj0SQLBcOCwYmSN=e3u063oY-fgrdfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ShUTbGVluEPorOh_P2zEZzNPB2D1Pviv
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4d29bb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=JEfHp8oQ6s9cwy_FA1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ShUTbGVluEPorOh_P2zEZzNPB2D1Pviv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MSBTYWx0ZWRfXwBeyZiTXtovu
 9R5zjlW2zer/bDEU0yeERm8zuhN5WMjgNRS0Oqy2SavNDEyusOd9Mq8WdRbLRwCKfwUeBe+rP3i
 8m7bfdxYvWjg6VaUPrw5yp9EZGJsels=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MSBTYWx0ZWRfX0XwzXPOkoLhC
 jxErx7u78E/BCR6Yz5zPlFJQz883g7dWfOlWfB05YnIkpmD9z0O3FcjxCU876WAwiBFCwsRHLOL
 Y4EufvmlFwYeJVhRwqYCmtRE5TzxunDbvvKzDVijsiNbxmXKQxoPsjrnE+fzpMnCFl74jMcTHsb
 Ar75ro5quVFxO1zi0JDZ2SMdAXv0P/GRFPkJJJTsAMuQ9u72ZrLZ1rt4qwJCYIXX8QyTG02xp4y
 6QO7x+bxbhEibu4SJJEAUj0x/lufp2CfrHfRYIWfIHXTRg+/8CA0pVW8LLJRa+T+BszGWMfw2it
 Oi0h1OjdAVeedwgHlHDdTjjfeNDNASfnOnqQDoG/TNXx6rWglSqeY571ezHJ1/soqUbAgjByu7Q
 4GcIvnGlKRoCv7TfdosNrkCEqw9RJZUCOKr6fw7xy1AV2tWAueUEDEzNKP5MdUjUZsr7CX7RFST
 pHS3Qd7x/hHIwvK8uLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070161
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/7/2026 6:45 AM, Max Filippov wrote:
> On Mon, Jul 6, 2026 at 3:43 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> Needed, else we get this error:
>> dangerous relocation: l32r: misaligned literal target: .text
> 
> This flag wasn't needed before because crt.S hasn't been built
> with text-section-literals, why is it needed now?
>

Previously, .S and .c were compiled in different steps, with different
options. Now, with meson, we have to provide a single compiler command
for all the files (no intermediate steps), which is a *hard* requirement
to save user from dealing with compilation details in arch files.

One consequence is that .c + .S combination gets
-mtext-section-literals, which triggers this. Easily fixed by adding the
.align section.

I can add this in commit description, if you're ok with this
explanation, and accept the patch.

Regards,
Pierrick

>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/tcg/xtensa/crt.S | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/tcg/xtensa/crt.S b/tests/tcg/xtensa/crt.S
>> index 909872cd385..de8fd8c1cd7 100644
>> --- a/tests/tcg/xtensa/crt.S
>> +++ b/tests/tcg/xtensa/crt.S
>> @@ -6,6 +6,7 @@
>>      jx      a2
>>
>>  .text
>> +.align 4
>>  .global _start
>>  _start:
>>  #if XCHAL_HAVE_WINDOWED
>> --
>> 2.47.3
>>
>>
> 
> 


