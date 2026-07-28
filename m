Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32499C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocvk-0006WU-Jm; Tue, 28 Jul 2026 04:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocvi-0006SC-C6
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:12:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocvg-00061H-UJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 04:12:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S827Dg2026254
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:12:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pdEz2DZ823mDmNwHSq8B0W51SCMFbYI2iThjgHUcjgM=; b=OU0Kctq+xl1LEjRZ
 6zigEq7zuIknldUp9kNh0HQ1YpNOroFEnlxs1scgirgK3I2nXjuyffK6SAxCPcOV
 dybe6H2Ji4xhOJ5go2MdzxXl+fs6gsQNqEw5W5eZyy1hekdaf8zEAit0rE1oWkx3
 WAqM/ogCddaduRwuUFegmah8/Eq3ysYjIZ7BrnNt3SBYJkUT7eR9AuTPLmTEiCL2
 zyQCUNzCIQcqD2XoIFOpHgXg6hq+6uHeGyxBw0P95AkQMXmRmMufWDapwpPw0XWe
 TGTK8zAmUhuXr1wsXiuMKofgX4/tkNLWF4Goo8Wjts14xEFI+VI38pgYwOzAAV5q
 nrdWZA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpq9hgcre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:12:47 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c12e43b98so44333591cf.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 01:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785226367; x=1785831167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pdEz2DZ823mDmNwHSq8B0W51SCMFbYI2iThjgHUcjgM=;
 b=fulsivLWABEVfz3gWkf8MtjzT+pYs15pmBzg9wPuj/jw5ArvugLFXf9rkxveVMf/qV
 ja0xCrZT84uBqycr2hWIWvO6bDNz0uL24ZJ4ckkfvYbv0s0GUeSulAa5OU1oo+FEDCKP
 htXl1PZLdoGuuhaOu3ybKb4jKT+K2cr5b/I0bFKsDJPN92jse/tjg4DwK2LuLo30Z7Ip
 mc3VBzwdt1Un3vIQDwbYKoFw4W/wII+0gtRjveg/GONV6RsbJlGJL4KEdoTMKeylnodF
 0/qdc7pwz6hqoEo3SKbULp07DqIw0O98ykUMEGCtmPtQfFnpuny0qCwfzG243ZEMT7Ng
 MWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785226367; x=1785831167;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pdEz2DZ823mDmNwHSq8B0W51SCMFbYI2iThjgHUcjgM=;
 b=ChXKdvfGjABhzXViLqFI3soGDJkKMus14X7ku58VwQYgaGqgDXbqiYJPVCWxASWnKm
 GYjQfdA4zWKGNKvzAk+1fKfiH7fpKq9DtgTyUJMqEJ9D9ao186tSWDLlP6IuOStoFDSw
 JRTaD78sB7aVVRCPLynhDS0hQqH9iiU0dOwTEkFPWNmFswR8onJRts52Fz7d8fKmQS2+
 Abf44Xd0o+uCUWZLcRdPGajs/1SavxYHr8KJF9vUPFE4ZD7bJ/ZPKZsxzOHm5pqdG4ez
 CKECDgY5dkasHwfBU85qb3FWdUHVVBbTRKKY+fpji7rHpvKAAxDgbF3EDNGGeFGJ75G5
 mnZA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqp5oU19sI8mU2Hc31UEHcTr8XhcW7WO9E+7iJBXdGGlXy61DZsRB0En2aAH7Cuu2hCLnHJcqtVnlKk@nongnu.org
X-Gm-Message-State: AOJu0Yyyd2FBCFQnvSDVVo6/KCu0WphlQOF47N7hEnJX17/jlrxJJ1yk
 SchrweP8qw9qxlZTJg7bGJlRlsHEsm33qLqgS/qP67Zhsk4brP7lkiKfylLJsf4NHBuQW0ORM87
 gAjC1hMlf5jBO9dOeNEAtsiDKlC+NT6HSMVfnyZhJJfXE2WS1guA2h0kWow==
X-Gm-Gg: AR+sD13yfVtIrHkXRGBa/egXQiNUeBhhHvzI3pcXLQInjjVGsgK67fl0pYg7HrNmbKt
 bXrnS2UYRC2pFv0lntpYMh6guJGTZV7oWFgI3eAfpQcLcSqqOdXXTLApDLwTVeJKrKCusa+YurR
 fQ55Wf2H2N5VR7st20va5k/hSjIEwdACJC7uxRs0B0Gl+GaBzH+V51YKbBbev4MMzXMwJV5aqC7
 shBu65jPNjBLb2pcF4IStS1AaTPSl+XyFMU6rYVsk2lycuRK/NHFdy+2xzP28aVEjxBM3KdSpF+
 uudCMZeX3OeqIRY+fZv+/IQMF95XiqrUGHiISBRnwbqfh9Z2IcyTsnqra+keTLOLMXJSgZ/HynG
 ZQS19E+L6DJnWLm2eYi/bjHEqDzkWotXtcnpEJWiVDGI1pnNdcRc=
X-Received: by 2002:a05:622a:1a81:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-529d6fae8b8mr10171441cf.9.1785226367398; 
 Tue, 28 Jul 2026 01:12:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1a81:b0:51c:20:aea7 with SMTP id
 d75a77b69052e-529d6fae8b8mr10171251cf.9.1785226367007; 
 Tue, 28 Jul 2026 01:12:47 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96b9abc0sm35431474f8f.32.2026.07.28.01.12.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 01:12:46 -0700 (PDT)
Message-ID: <fe1645fe-ef67-4340-8f17-29fb571a42e0@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 10:12:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 095/103] tests/tcg/xtensa: xtensaeb system tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-96-pierrick.bouvier@oss.qualcomm.com>
 <3b4719d5-6dfe-4bdf-83cf-563d9caa0996@oss.qualcomm.com>
 <0ff8f6cd-41dd-480b-a7ff-c23dc35792a7@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <0ff8f6cd-41dd-480b-a7ff-c23dc35792a7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX2QNezf1db7xk
 SzBB4MEnAtbajP8pOLK7sgAaLGBsp886LvQXGd2VtXjCWyd9ZBb1JtwSMtocGwjBAmFGL7eHMm+
 0EaASDEqH5WtfMOcGJtUcVTNYvUY1oE=
X-Proofpoint-GUID: E5lMpDU3Cy-Hm19o5Y4XK761O6HEOPKs
X-Proofpoint-ORIG-GUID: E5lMpDU3Cy-Hm19o5Y4XK761O6HEOPKs
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a68647f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=LkBW791Ab6_GARc62icA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2OSBTYWx0ZWRfX/uzQ+gW1HTQH
 B1nOjBbmg5tJFh5MwTdUxEbLJ7XXVgZkl5Kit+mk76MItEoZDEpD/lQX2YQLEu0KdDKxkAcQqOw
 nd5SoWQJgxRJ67g/fIVoq6UyzT3PjL5Yu++gmoSLwos7sL2uDdbiJzrs5r7Gi+g9z7idi4x0FY3
 JbI/ExydXXQeH0Kvlzt2y7ynPUnG+YP7DHT/Rw5iJQM9rcGtjxUJvFx7zuxzgNqnvAZtNGrtf1i
 abxk+L8hvorwiEg0u7CagqeEOPD1CF/N9kTCiUsphOawUij3EzEhYDwPn7BTR1vMN/fELZEjTBU
 3pd0kOcNMbGXW8C+TA93O3m8gb2uKpqMlA5KegiwGqJ0TQQe8qih+/KVhaTcwROG6b7AmqWsQOF
 Ff3/3MXu8UTauaexgZJLgZ9KFcsOSyL9ySS/qGWL0VpOwMfCQPd8hBuHJdGJFRF71D1izLGvjaR
 KWli15gIyNc+SpoajGA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280069
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

On 28/7/26 09:56, Pierrick Bouvier wrote:
> On 7/27/26 10:06 PM, Philippe Mathieu-Daudé wrote:
>> On 28/7/26 06:42, Pierrick Bouvier wrote:
>>> Deactivate test_timer which is flaky with xtensaeb (25% of the time)
>>>    ./build/pyvenv/bin/meson test -C build xtensaeb-softmmu-test_timer 
>>> --repeat 100 -j 100
>>
>> Is this comment still accurate?
>>
> 
> Definitely a leftover, I'll remove it, thanks.

Removing the leftover:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    tests/tcg/xtensa/meson.build               | 16 +++++++++++++++-
>>>    tests/tcg/xtensaeb/Makefile.softmmu-target |  5 -----
>>>    2 files changed, 15 insertions(+), 6 deletions(-)
>>>    delete mode 100644 tests/tcg/xtensaeb/Makefile.softmmu-target

