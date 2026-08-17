Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87A9C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 04:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvoXw-0001L1-2H; Mon, 17 Aug 2026 00:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoXS-0001Ie-JV
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:01:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvoXM-0000I3-QL
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 00:01:30 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GLCbt04058363
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V6GQ9fb2Dxqi354smc5sS84D22sNRgosJmQi3+m8/Yo=; b=L51Xbf5pKvQ+xS/3
 ALnJnQWB6j6E8eMIJfK4vcfYVVnHC8MdswKnBResiwqF3BKyXfoQb31IebxEWWMa
 6oqtIQgLRWuPoX8ef3AZONXsd778zUkEm7t5FD75GrO62/Fv080rV2KyiFerqQ6C
 Hwt8lM+U3lhIHYnVtMDc/Y4w2dvVjjNrQUpUbqcULOT4oud+tbLaPZL5dsnarUyl
 en1vnywDXjN5iMPOp4scRRltLFQr9MCsHFZmZRqAqy7wyC6Zld1dARv4vms6bW3c
 rA0MP7pazBx3sp4eLoYbKkHifA/wCJRh4fEfG4Iyo0jdTS1Qoi/ZE7c3o7zf1EO2
 AGK6WQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2hd7vxc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 04:01:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so305539285a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 21:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786939279; x=1787544079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V6GQ9fb2Dxqi354smc5sS84D22sNRgosJmQi3+m8/Yo=;
 b=MUzDYIChndZyTL0S/Y9O7UfWtn6ssZXLu0dg/wE5AJq8v1S8IwqdW/ngcrJ2Za8oVs
 vz8TAiZteWsU5JJnD0PpNLOGUhCF04KAyIxkVFoq6LY/22IwVRC2rmZpm84BvPSK3zt+
 LcswqE8g0Rwf+wCH9ZFkpvUClnHhuia0UOPkd9wOyeGm4PtUWPuSvvBMDs102C/UbMAs
 UYpTR+NtmNmcowH7stbWSZhEcsSu5ppyLLcm0mfSRVY6/Ais+ULlfgbsewFSFmZOyYXE
 Q6yeXKEbsoac3vGSkgPHNR+mVTm0FBdZu9FfzPEA+jc/0XwkuGe05vNo61d/5D91Y2vr
 bZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786939279; x=1787544079;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V6GQ9fb2Dxqi354smc5sS84D22sNRgosJmQi3+m8/Yo=;
 b=m2eol5ycjsDsNwsZw/iO2b8OJwskKatAqHOBS7h0FDWlFEq3PLsElScSxoU+SeOExS
 q+K0B/Ufzo4vysuIHhki6X/BSHfdvh85NEdFn7CaWG2GcWpC0hPSdHh0uuonj7r250Mr
 XsyLIUprIbDL7F4df7D0Hq2DKu2iNXkXFu9c/vKpJAtninumiWhYT4qmFUpmH9T2wEyF
 h+BEaeSXXr7uINdUuyRGi2xmEvi/ixUJcVY3JUYficb7G5gV8+nCUhwU58A+hr+GdkmO
 c+j3JSluuyMT/O6WTlgRpJS4bc45xzOd1Id9uwGf4jD0aGxJe4PuuUL6Do23NMBql/f1
 cdzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmT3EGAbfzmIm/Wqx+Dv+u42IvNvIKWnqhvVp1hmJfl+1lYJM59W6eIcyCUXq67h4wZ7X/6il6xzd6@nongnu.org
X-Gm-Message-State: AOJu0YxpRJyrhHd+4Wm5hO8xDpK59EkqkF7ZnVlnW2klQ1TFYlpMEkzx
 KvyuE82xFwnfGW5+Qsc2lpGmgn/6tPw7LGc6bXyZUjxneIU6HZ9XEYA07l/iA7O+NUPSlUaxQT/
 /74IJNpTKlVlgtZhnCSSWWNZF93h7oTdtCIUhUyF45emE8WG13Be1ue98/A==
X-Gm-Gg: AR+sD10qMcf11Sh2HRqNNYqIGXpwoA9DyIlpgG2AP6w0Elmb2L3doQE4Ko6VUWfya3J
 d+buM5NJISLl8rVJXtZ4Om3eSNdi1/rAghIwDUMHZlLCr3/gaVVjsaOxZ0UeArexcAVCA5G1JRb
 PFzMnKpwXksYKturZ8Ng+po9abnaBcTmjIwjMFNxyQ0hCDFAWlI3CIv8EC2iuNS0rMQG9JZIBJD
 H1MvgqJQESqg9LuT3v7EQ8WMUffF6Gvmqvofm0rOdy6xYwPRziDpN1/DAasD67+czT2pwJugjtT
 aVuqovLusTCeijnsodt6xxeHhvaDxsTRewxmmJVpibulbxmYSjRqwqu2u8KNSvgwfSOI0ZQwXlD
 OGtc41M5E0tvz9B+oDD0MKUp4HKflOUsc+Ug=
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-936d236395cmr2143328685a.27.1786939279257; 
 Sun, 16 Aug 2026 21:01:19 -0700 (PDT)
X-Received: by 2002:a05:620a:f06:b0:92e:7d53:8e8d with SMTP id
 af79cd13be357-936d236395cmr2143325485a.27.1786939278872; 
 Sun, 16 Aug 2026 21:01:18 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3158asm428662f8f.7.2026.08.16.21.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 21:01:18 -0700 (PDT)
Message-ID: <f54d8c2f-3d30-47f5-809a-ddb60c8df03d@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 06:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/10] build: add optional librpmi dependency
Content-Language: en-US
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260814045315.3416169-2-subrahmanya.lingappa@oss.qualcomm.com>
 <7c5a0b1d-12db-4be2-b20c-9d132b027a76@oss.qualcomm.com>
 <CAPxK-6c5ucsJttV6WVTQSe=O3s+q-tL=-Mv42iJPUBftFAXFhA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAPxK-6c5ucsJttV6WVTQSe=O3s+q-tL=-Mv42iJPUBftFAXFhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfXy3BuQEtqhxag
 tmc+v9sMeltrnxHo4yrjIrIjH7C0NaoyZMueGSYOteC1Lk4u46VP+GzrnmjPzisaanjM9d6dMPU
 9KE2gYz5vk3PiPYgkCGOw7Td+Ye3s4LAjToIz+HCNOA54gyR5usnqvoXbkMeEa6zR9slc+fW3tX
 2TZ+6jNmrPwuuCwWWFDDNdWjOgXix3kZwdQyvz5SumNDXgp0lWTwfTyZvSIvVIYy3TqUxxNDRi9
 7M51YttSEexNtWE60ycp70l++VhySKjChh2eC2W8qCjjVPLyNySWBnpdkD9nKQqb2kCttI+Co/X
 O0cFvfK/9UQ+JoSEkvKE6X2jA8c1ee0eSTJMR8jixZCsLZO1kRaF98B3zhxk3sCmR5Vj+4GToqH
 0mM4b+kep6o1lgGUXaQ4ybVK5WlU00m17m1zAi/e1DP3OHPrtg5HV6E8y77yZHyHItmhC+uVqnm
 ROqYOMBhH3Appz2XkMw==
X-Proofpoint-GUID: gKjo61huZH2vsSK7BWPqchxCkQHKQSEy
X-Authority-Analysis: v=2.4 cv=Ja2Ma0KV c=1 sm=1 tr=0 ts=6a828790 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kmPEfuMoTeVt9x6YpBYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: gKjo61huZH2vsSK7BWPqchxCkQHKQSEy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDAyNyBTYWx0ZWRfX8Hy2Nb4VJCXj
 ow/X7uEdZQ8fpQiO8deopfzZd+y8xs7N9cWX0lSh1+mB6N8QOOfpbPnOL8CBhoJdCwOtzGxl4bW
 /LDt7yutmldDxk1FIukmOwuNA9zijRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170027
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

On 14/8/26 20:34, Subrahmanya Lingappa wrote:
> Philippe,
> 
> On Fri, Aug 14, 2026 at 11:14 AM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Hi,
>>
>> On 14/8/26 06:53, Subrahmanya Lingappa wrote:
>>> Add a meson option and config probe for librpmi so RISC-V machines can
>>> opt into RPMI support when the library is available. Keep the dependency
>>> optional so default builds without librpmi continue to work.
>>>
>>> Signed-off-by: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>
>>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>    Kconfig.host                  |  3 +++
>>>    meson.build                   | 14 ++++++++++++++
>>>    meson_options.txt             |  2 ++
>>>    scripts/meson-buildoptions.sh |  3 +++
>>>    4 files changed, 22 insertions(+)
>>
>> Could you provide a cover letter so we can understand the changes
>> with the previous versions? It is hard to figure out why we are
>> at v8 and what we have to review again.
>>
> I was incrementally fixing issues and sending out versions.
> 
> This mail with subject line has the change logs from previous few
> versions, you might have missed;
>   as it was with all the previous versions' cover letters.
> "[PATCH v8 00/10] riscv: add initial RPMI virt support"

Apparently neither the mailing list nor myself received it:
https://lore.kernel.org/qemu-devel/7c5a0b1d-12db-4be2-b20c-9d132b027a76@oss.qualcomm.com/

But indeed it is on the riscv@ list...
https://lore.kernel.org/qemu-devel/20260814045315.3416169-1-subrahmanya.lingappa@oss.qualcomm.com/
> 
> Please let me know if you'd like it to list change log from all the
> previous versions instead.

You could have proactively done it directly, saving time to all
readers ;) Not needed anymore, I'll import it from riscv@, thanks.

