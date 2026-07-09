Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B24C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whu27-0004FY-Px; Thu, 09 Jul 2026 15:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whu21-0004Es-OZ
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:03:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whu1z-0003qo-WA
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:03:33 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXBi52327999
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 19:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Er7MRw3ieAt0fH6wqagny0GxXPQ0cx9M8263p5k5AZg=; b=Zvzh39bWSutt+QIQ
 wMKJpyPuINFFH+nLvdf+TOUZ/VbDXzBVTD4LGOQCBNEF8jvNfrJhLTYCJO2QXGu8
 mVw+SLeYbqxNKtPxUAolGL8Au9mE9xX7M93A725UtlbF2sZumpjR4QKmjpXNNaB8
 HhA76OHqotsT4OGqpQg/Gs0NphOSsTI25SNwzqrNPNy1ucJQ5B8hr1mxFzYSgoD3
 7qlSH2jGWHZADkPQW3bypZZ/biuzlU/Y6w/VdDDmIp0tk3qUiBv+R8KmcNuyJZEk
 /Feo/2k/Kbp/kPdJ8lzVRbpgG88h30ZXwlhqwaH7tWi3EV/ZntNO9LSh3XKrefw8
 Ju8//A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24rsyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:03:30 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so207683a91.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783623810; x=1784228610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Er7MRw3ieAt0fH6wqagny0GxXPQ0cx9M8263p5k5AZg=;
 b=SuwHwRY+m4UTQLFXaxiVKSkivY/DB3djh4iys/zQTeFKFVcn6JGDOQj1N63q2DdKsc
 p6De/8p6qOEOrj/ZhE0IBei/03ysyLkQnXXcRYVxE5ru81ilc032FoYO0yJMKrJe1oZa
 r+hEIoYvlae5zwK3/0tY4Rx+5RflbuL20aug4ci8I4WoKUBUFdhPwdWVsG2foMUmU4U9
 spH5aXAcLxOt9dE9TOxcDB8hI4C8SQkZtZv+IJuOMmMO77/1aRQQnZVn9rKezIYOfnAp
 MhQbrTrXQ2ytloP2EJbYqwSjKqyEF+0Byn4EE6BPZn8KxJor5lMT7r2Bm26YTL792JN+
 QK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783623810; x=1784228610;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Er7MRw3ieAt0fH6wqagny0GxXPQ0cx9M8263p5k5AZg=;
 b=NBThyV77u3VwZnK8PMD1jyuch7sb8M55JUVHGf5wB5+HbY36MvVkAz7VE+iozLTt5x
 rLhO2usuZcWZNiTU8J3S8QfGuCE1a60jnRGDrj8LuTCWJmJOYWv8RIG77ME8kKFbzpO9
 nenWInYqOmPn46kRN9TiUsA3PPDqeciydZ7LyW0LlhO4PwLEbi9UxeU4I8i584lBwfYY
 ELXKvPrr7XWjXVTqdR1R7T4GAb4/Dwc9waVRXPPMG8fv61t2BqINN2gQvNVH02djBthc
 lMxjjguXmLAW8Sv7yRQCkBxbIY6dz0TAGMrSRIUSUwJ/9onnfZ/GpFtKczZ9DqrrMzUL
 m8Xg==
X-Gm-Message-State: AOJu0YzdNVYZgUu6l6L2GaldcQDCFzqvoPRp8VaYZUoYlykPuRii7nNN
 j0cvkVuxTcCOyv7axHF0fByU6HIBoaaivyKb6Ypg9WXRWQqZb/IaacAH08Zm+1q5OGNLsCC621m
 nQHjpa19JokKhZyNBYi/+ThKdaMGcEBXTRJ2FKlSsqzm/NxNRjsH2pBZWPw==
X-Gm-Gg: AfdE7cmCKzXSPzjGsMkyAU9CihMf3OWfu7bB+1fckn/qbNytJ1csHLBPSey2LQz9NJt
 iVS4Z95h4t1PuzZy6kTN6X7lcUVyA9JOe5GOR58GdW9FZ6UKaip4NR2jwg1FJfjdaYNdSVffPSu
 VVNG6tjXo60NKWQe98tF/AhvFkS6kVcM9Km9TyUKkQ51P7X6x7u7ZNEnqkx9zPwj8WK48Q91GNp
 UqOwsTtDcOCTtNBAPhfRvY1UFDKnSLspzNcvWY5C0aZOuSRan7nXHFGG5m91wYRbS8rADYCkDfG
 pYUE11V00aH+tW+g0dBc9GA2a74FYlK3E09Ge+GL7YgtkHesFfZBCvfm6bnHuu2zKRsfwpr+h0w
 wAa5o1+Rm76XB8Ev6DNtA7UWjxEeglMHPPmr2FQuQQVbLOQWkyX9GqlhqTP67l4/wRUCbiLdOSJ
 0KYk0=
X-Received: by 2002:a17:90b:2709:b0:387:e0db:3d88 with SMTP id
 98e67ed59e1d1-389434634ebmr8418701a91.35.1783623809594; 
 Thu, 09 Jul 2026 12:03:29 -0700 (PDT)
X-Received: by 2002:a17:90b:2709:b0:387:e0db:3d88 with SMTP id
 98e67ed59e1d1-389434634ebmr8418672a91.35.1783623809174; 
 Thu, 09 Jul 2026 12:03:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f596asm33487218eec.2.2026.07.09.12.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 12:03:28 -0700 (PDT)
Message-ID: <3f2dd388-ea87-462a-9438-10ddef3f1c82@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 12:03:27 -0700
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
 <99d7064e-50f3-4947-884a-6f6c14f2cee2@oss.qualcomm.com>
 <84fddbf3-e523-4a23-b95e-cc6102e459c3@oss.qualcomm.com>
 <CAMo8BfKGqu=GbDhp525Oqt4VVCC7cPSYZ5obsUuuFQYKvreeKQ@mail.gmail.com>
 <422b0dd7-b3a2-45fc-a76f-43c18f95c426@oss.qualcomm.com>
 <968352f9-089f-4409-800a-3efef59d114d@oss.qualcomm.com>
 <CAMo8BfLPahC0T-8U=y=Jacx5zNvO=4jFXiCFfWvYUKtyNVk=Qg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAMo8BfLPahC0T-8U=y=Jacx5zNvO=4jFXiCFfWvYUKtyNVk=Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pi1VQCQwc71zFmUNRTKd0k80_5lQKNxM
X-Proofpoint-ORIG-GUID: pi1VQCQwc71zFmUNRTKd0k80_5lQKNxM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4OCBTYWx0ZWRfX7BE5tEy07HZW
 0Yvm3Zkcerf0J/XUJDvyR9clWviQuhe3G4Tos2yfMj8VaVri76i7JHCqtKRk6ZBn7HvEC/Ay+S1
 TcTYd8a+0aeVVHjKdkWilVLNIHutPqU=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a4ff082 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=lBGSq0RoqLA3r9s40UAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4OCBTYWx0ZWRfXz2mpgTu9t30O
 El7Kb6qjKpnuxWD7M21s0fc1Z/ZwTl0Bpwj8xnMU6Hx4DuFS7uLN2XT9qkLnvHSsbaIyjXE9i/R
 SJsrR4N97ogh8YwUstFou1VOvw0UL1Ux8nFJk/Xj9M7DIib3koZVdFZ/xUNiXcrxG/sjjjOkC1i
 /ba3vZVXUPXMr9TcvDu+4XovvxjTEC/U6mia5OlqoFSdeENAIABgeg0xaVjhNoznEwfFf/0BS8r
 hoxVlrCSfwFWDGyw/EW/4q4+uewoxy9t5gpGlRsjC238z9vMPgzLIxB/w4F7l9i++mSg97xCqxx
 vl45dyFo4Un5W7GTGWo9b0zyQ/OokXpXn+BsCqyL7d3jbYBaSI3xneW6zOSHQkm8LBCoPbm0Gs+
 JzNfoMfJzTp9K66iBHWqVuPnOYoLsEqNzdjceo1BoOrEGXpldNRCTZYU1TIHwi/T/YbZFNl0G8v
 JF7tfqkKGDpEzNwBrhg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090188
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

On 7/9/2026 11:42 AM, Max Filippov wrote:
> On Thu, Jul 9, 2026 at 8:24 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>> If you have a chance to take a look, I observed that test_timer.S is
>> flaky on xtensaeb with kc705_be. It fails with a probably of 25% on my
>> machine.
> 
> This is a rather well-known issue that for a core with .clock_freq_khz
> that is not
> exactly matching the icount argument used to run the timer test it
> will sometimes
> fail. The easiest way to fix it is probably changing the default core
> clock frequency.
> The more useful way to fix it would be to make the core clock of the
> `sim` machine
> adjustable and set it to the value that matches the icount.
> 

Could you share the magic command arguments that achieve this?
I can edit test qemu args to match this.

Regards,
Pierrick

