Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8573CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7I2l-0002le-Q7; Fri, 10 Oct 2025 14:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v7I2i-0002lH-ID
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:40:40 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1v7I2b-0008Lc-LW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:40:39 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AFkPYu019486
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 18:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9K7GlK/O+shWI1W6Jv/aZ2tYeZJJT/UtMCEvFoMUWaY=; b=OFzRi78zKno9WU6V
 6J58alSUAaB09IXHFvS8loOZAeYy/yfvft51Z/82njX648Mf8xIoqW0+L2NKgQMd
 6a6MU/54ixev4tnigRSxWxuckRqK0AowseaXRAbBoZCmLeh2Ksj6JcGyjwIYFoo9
 pNJ1MQg24CFto9ZlU8WC2r3/rJWrd0LStwR/8HX/JzhfQyCOJjvDwnFNX7bc65LM
 geysv9J/XjX3RQvgzy/jBu4egPjRXXCQ4yOM057ifyqQIP3sj1Hx8HGb4tm2XgYV
 iMWSPXON+NakV5bWcQAeJaeyFTAo9QmNcusimW2yKMeTXrQwhoeFbLKv9I38FzAA
 +w++MA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4m7e03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 18:40:29 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8645d39787bso1276398885a.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760121628; x=1760726428;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9K7GlK/O+shWI1W6Jv/aZ2tYeZJJT/UtMCEvFoMUWaY=;
 b=k6zTocUDHpkTlMT8iG+N94G8AD0IM3lRd1cCD/H2WAtiuPXjFtMnUBdc6xb7VSAv0G
 d1xbF91nI+IXnMp0FLHXf0WVCSqJaWYH48E2vGAAHhTEtM4ppaodgWzJdObGHVM00ILF
 ImcDlXQk1q9zhukql9nBDICeBNEhczVD/RE7djAWAQWUZGqG0evgo7kxDPfHtebu4I16
 3/7FRjCGXwMhv1KZvvFvc/uc7Bcc9gSEe2xXIzj3Ows4jOpisazH/8dy3CM/GHm4Ell8
 TVr8mW3qrf2QIN+z0WaOJiSgWMz/PvxB8Nij99BY/EorsM3wBRUsg+Z+fMFzocgBCYP4
 tk4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiXLJ1O9v/FViWnGsLixYFPUWiYmOxm5m6olwZpGczcHE+N1QCWE2MgFNJ7Kv0VP2g6ktyDZ3RE93I@nongnu.org
X-Gm-Message-State: AOJu0Yw5QpB9QJpyAWCbTb3chUiUhXeM6lr3jC4nQKOI8ehqLFA/klSR
 iLF8g7Tj9pWIIQmDwcbWCyqAmxuoTn96uO3yF5ItxURqJn+hH7xZBxAtVbuqZ9OvlIICuyMFtAm
 gaEeBbXyUtHcdo+iJKOhC6JQx1zhdGFMsNA89QpE2y+k/zJKBbjiJkhTwmg==
X-Gm-Gg: ASbGnctDJKEghu8EJiqIsNvAUTO+lFSGjDXaZ1Jp/bC9YWYtvszpcinIG/XLEzULnFk
 Iav8hQ4WNWzZvapmdI3PUbEjaxAtag/Ipv4xiRKv4+TLeuzjiKxURAC+krvuOOt/QiNJOFsk9T2
 7NlOu+3UogjjjK66pS7vdNiiuPhcL7P1MsnwyZAAifnruPk/8YqgUQefpYaTXnh1a7SwqKhGPbL
 /7SnRNFIgcJrUG2jHa0UMWtCXPwr9noTlKFk7dhAHUC8QkaHxq7wdYrhZI0FcFi5jQ1NoDRY570
 33K/DtDUPRlIAd/kGvWGy8WPtJbQhIVPD6fEVZNubpRaQ3QKkHU5jc4ypawSmnEKkcZKFhPDgcc
 mDp4LSCBFFaOV6pL27NpTg4b0cJY=
X-Received: by 2002:a05:620a:c53:b0:865:916b:2751 with SMTP id
 af79cd13be357-883529b45a4mr1897969985a.14.1760121627622; 
 Fri, 10 Oct 2025 11:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3UieP3qlr01PM2MFg2Kr3W5HhqeoxZUmbFl8eIKb7TF4DGALweASNeXLbFdylzOzteBalJA==
X-Received: by 2002:a05:620a:c53:b0:865:916b:2751 with SMTP id
 af79cd13be357-883529b45a4mr1897965385a.14.1760121627078; 
 Fri, 10 Oct 2025 11:40:27 -0700 (PDT)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-884a28445c8sm440705785a.56.2025.10.10.11.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:40:26 -0700 (PDT)
Message-ID: <1b97ba20-7ba8-4281-b1de-d033a27c3c31@oss.qualcomm.com>
Date: Fri, 10 Oct 2025 13:40:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/hexagon: Add cs{0,1} coverage
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org,
 matheus.bernardino@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng,
 marco.liebel@oss.qualcomm.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
References: <20251008014754.3565553-1-brian.cain@oss.qualcomm.com>
 <20251008014754.3565553-2-brian.cain@oss.qualcomm.com>
 <024001dc389d$c5f5bf30$51e13d90$@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <024001dc389d$c5f5bf30$51e13d90$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX5hXdfEWYbKd7
 91uwcN1fbLSq8xc75wazLb37HEuP3zI9tMdj6jVpZh/USjwzRgfeh4T0OAcZAT78eY86fHlbJyL
 Rsca6slvK4hCNsLEfF/fdYCN8627JSbyyRnMb6Gpr5tP65wkqFBzp7I0ScamJy+y9HrvbJHJayY
 kcovUQgLpc3lB1K0Jt13ssm7hIdHVyLsgaKLFxZrDOTyUWluXpIOvL/Sf5HHPks5X23uUYYti98
 IqFDaBHfGtvjUAqxSpfCFrtaPMYUWYhanK3O4glQKboUS1lFIiernc8L2DwEs2N9LtcEpbb9hUT
 217CyDjnn0PynNf2wRkzAhRRgKzc3F61BST13Bm0X005byItvnGv/Lpt0ptuS45NUr2r65p80kY
 yc97vU1jVRJuvozyEucHZWKsyS3b8g==
X-Authority-Analysis: v=2.4 cv=B6G0EetM c=1 sm=1 tr=0 ts=68e9531d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=tkK3m9oNxmpf0B_v4QQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mV91rbnY2vEkHuTMa1f4nqAumVV3lBLY
X-Proofpoint-ORIG-GUID: mV91rbnY2vEkHuTMa1f4nqAumVV3lBLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 10/8/2025 4:51 PM, ltaylorsimpson@gmail.com wrote:
>
>> -----Original Message-----
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>> Sent: Tuesday, October 7, 2025 7:48 PM
>> To: qemu-devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
>> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
>> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
>> alex.bennee@linaro.org; quic_mburton@quicinc.com;
>> sid.manning@oss.qualcomm.com
>> Subject: [PATCH 2/2] tests/tcg/hexagon: Add cs{0,1} coverage
>>
>> Cover cs0,1 register corruption in the signal_context test case.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/tcg/hexagon/signal_context.c | 22 +++++++++++++++++++---
>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/tcg/hexagon/signal_context.c
>> b/tests/tcg/hexagon/signal_context.c
>> index 7202fa64b6..00bbb3efc7 100644
>> --- a/tests/tcg/hexagon/signal_context.c
>> +++ b/tests/tcg/hexagon/signal_context.c
>> @@ -26,7 +26,11 @@ void sig_user(int sig, siginfo_t *info, void *puc)
>>           "p1 = r7\n\t"
>>           "p2 = r7\n\t"
>>           "p3 = r7\n\t"
>> -        : : : "r7", "p0", "p1", "p2", "p3");
>> +        "r6 = #0x12345678\n\t"
>> +        "cs0 = r6\n\t"
>> +        "r6 = #0x87654321\n\t"
>> +        "cs1 = r6\n\t"
>> +        : : : "r6", "r7", "p0", "p1", "p2", "p3");
> Add cs0, cs1 to the clobber list.

I will fix it.



>>   }
>>
>>   int main()
>> @@ -52,7 +56,11 @@ int main()
>>       it.it_value.tv_nsec = 100000;
>>       timer_settime(tid, 0, &it, NULL);
>>
>> -    asm("loop0(1f, %1)\n\t"
>> +    asm("r9 = #0xdeadbeef\n\t"
>> +        "   cs0 = r9\n\t"
>> +        "   r9 = #0xbadc0fee\n\t"
>> +        "   cs1 = r9\n\t"
> Should these be inside the loop?


I think I might've misunderstood the design of the test case.  So yes I 
think so.  I will look into this.


>
>> +        "   loop0(1f, %1)\n\t"
>>           "1: r8 = #0xff\n\t"
>>           "   p0 = r8\n\t"
>>           "   p1 = r8\n\t"
>> @@ -74,10 +82,18 @@ int main()
>>           "   r8 = p3\n\t"
>>           "   p0 = cmp.eq(r8, #0xff)\n\t"
>>           "   if (!p0) jump 2b\n\t"
>> +        "   r8 = cs0\n\t"
>> +        "   r9 = #0xdeadbeef\n\t"
>> +        "   p0 = cmp.eq(r8, r9)\n\t"
>> +        "   if (!p0) jump 2b\n\t"
>> +        "   r8 = cs1\n\t"
>> +        "   r9 = #0xbadc0fee\n\t"
>> +        "   p0 = cmp.eq(r8, r9)\n\t"
>> +        "   if (!p0) jump 2b\n\t"
>>           "4: {}: endloop0\n\t"
>>           :
>>           : "r"(&err), "r"(i)
>> -        : "memory", "r8", "p0", "p1", "p2", "p3");
>> +        : "memory", "r8", "r9", "p0", "p1", "p2", "p3");
> Add cs0, cs1 to the clobber list.  Also, add sa0, lc0 due to the loop0 instruction.
>

I will fix it, thanks!


>>       puts(err ? "FAIL" : "PASS");
>>       return err;
>> --
>> 2.34.1
>

