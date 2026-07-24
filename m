Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269FFC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnIvp-0001TC-MG; Fri, 24 Jul 2026 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnIvo-0001T4-7q
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:39:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wnIvl-00050q-ML
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 12:39:27 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODbGC53178246
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 abwVVKFMUkeLGRYSRUrW/g85Rlg2Lsw5qKY7Y4NmFsg=; b=Pz8jQSxxXiHNkT3l
 MJsWuV7ZIdxa33mXjlRF6R3bpHgnLMjN3cAFOxLQ8+a1fbWd+o+kQkw8CwQUn6TU
 iudcgeXAaYCMWuv4yLAtVa6DXklt1MHZUYtbk+n9WDZngRG+hJYxJwHOjWhymjcB
 r+KPi5oNXDaA8P7G84ndLuz6ulZUd+abrMd5hY/9+lhayO3vDhKFj5Jo7oAQpF0k
 KfNBmeuweBlnBg1eOPUAEwdX0RV7HaK+g682OagED9qdiUewyfSdSZddZ/LK34nO
 TC42afNi25ZDUEaCWSoRfMBgOjIf3u3rC514aoBRQXT9GcJpZnYRBpR6ZePHya6Z
 MjIJAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm5yahesq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 16:39:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so11685315ad.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784911161; x=1785515961; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=abwVVKFMUkeLGRYSRUrW/g85Rlg2Lsw5qKY7Y4NmFsg=;
 b=L/tq/bibBp13U67BodqgR7pjmH0OtgsYbleOZAg6ad0F8IcWdr1hGzTBBxK1h8MlsK
 ICXHhhWO0AMG8+gDWjU2/NqHb9j185Jmf7i1yI0PJkmy5GBPkiNN/NEIAoIyDuN6iDdo
 PVSP8w847jqVJ1O8T/xtVIbSR7cNSqsHKpRPdpvwl0P7nHfR/+2uDTlKcOnvnpaj3q4x
 z6yXEvKcKW/mvBi8P6ZJ0bY/mlQ0BK17Lsg4acgf59wHifSlNKNhkAgv/+nk/hjpYTT5
 5AP/QQ9xnAPyW7n4A0Caf2kJoXoXtpLVwZtBtUaNvj0Ui61KZ28BlQQpCM1XClwMqfhG
 NZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784911161; x=1785515961;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=abwVVKFMUkeLGRYSRUrW/g85Rlg2Lsw5qKY7Y4NmFsg=;
 b=NgNlzU6uuTEnCpl6Ei2CF/OFoTy3wh0tfTyT0Y3iv1D9urS+YbshFk2N6qpJp7Hoy8
 GguegEgvEK/R1EDEnu4W0d0eeUkfBKh0U0ui3PzScQ4k7Yq+KrBC7H0dqQnzAYHLERes
 kjw8FDAhv0VVnGh8ipZG4NJMRKXsS/dM42ibk9jEI7VM+LEO3P0qlP/zBgTtoCIZ8Tjk
 +QcHYGHZRn7FtMsDq7L9rjvSzyD2X4UB72gh9hIbC2EJYfyxZYk680K6CUarDDb6YA9o
 xSll+krzLvQGyPmG1gASjRKPj0EccHs1sIuqG2VM0zsHor5M/Jp8E05HfVE9D8oMUalj
 hoMQ==
X-Gm-Message-State: AOJu0Yw4qlRM3k6x/VLy4P45uhpSfxj1iT9yN0GqfaGbejIjWU4GTM52
 hAk574JY6CCuagz0ZWuwqz8kx9+sYzuOUqFV2tRM+EcgRaO5+6bDS+Eg1/+Ez421OqHQLTVyKGi
 3d3iAx4D6UdJr4wEe12cr5x5rtBsD6GrIQcffexWmJTT3puISdLfvGuVJSw==
X-Gm-Gg: AR+sD13r3m+vj3kzXjGetiBXwZLcnMCHAtN/OqJT0WylWDscXNKm8WKq/LLdaU2OWNm
 mZ3OKzEA6Bnd3MTDlLdQKjgLq4kKdcucHFXjm5fPLMVZFZIrRcb2CHl5Gp+0hE1BNAgahq444SH
 mDO978SQLEIQdwWoZP4PwE9I+UacVDbOI4H47TcNFw5ppsVlZJ4Yq1bPVcg+O7b3k5BrYUR5CtW
 e/XgaYvB/O0MINyJv26e4F2AXQxPjcbNXhfZLbfWx00hnV5m6pEIwmGnMu5mIE6VtHBHlWNnq0n
 JJsizaLnDMudm+/hrjAXArHmr1zj89G3cWtQeBrpopdhn0OKdN2JNnhY0IrAgnBoEpM6017Hc4L
 secmJFaxCSVtnhIar4gwMw8qL5+2F/SGlSqMsSqgmNGWa7XCr+1H6Dhf+pk+l9tEwTNoI
X-Received: by 2002:a05:6a21:6b87:b0:3c3:9ed1:2549 with SMTP id
 adf61e73a8af0-3c44b1c8696mr8729304637.41.1784911161418; 
 Fri, 24 Jul 2026 09:39:21 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b87:b0:3c3:9ed1:2549 with SMTP id
 adf61e73a8af0-3c44b1c8696mr8729249637.41.1784911160917; 
 Fri, 24 Jul 2026 09:39:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e127asm1822384eec.2.2026.07.24.09.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 09:39:20 -0700 (PDT)
Message-ID: <2e27ef8e-a9fb-4275-9a51-6e88b63563d0@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 09:39:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 97/98] configure: remove --cross-cc* options
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-98-pierrick.bouvier@oss.qualcomm.com>
 <87wlupst0e.fsf@draig.linaro.org>
 <0ed09a8f-2de8-4910-b853-cd717dbf3317@oss.qualcomm.com>
 <87se59r999.fsf@draig.linaro.org>
 <c16b4480-06fd-4d96-b628-5c423d300988@oss.qualcomm.com>
 <87mrvhr3co.fsf@draig.linaro.org> <amMnKWlFFi56kFdQ@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <amMnKWlFFi56kFdQ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0OSBTYWx0ZWRfXwwWYpfP2xXfD
 JEaO2gGfTVQeCy9P4krCQXvuU8pBai/rIl7z56mR0qB0wDFzj5jBry3w4QJAIJCAtNa262Q1b+G
 DjNMJ65HXNGA8emSi2VfmMAwJ/F5VuM=
X-Authority-Analysis: v=2.4 cv=Rtz16imK c=1 sm=1 tr=0 ts=6a63953a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=vTr9H3xdAAAA:8 a=EUspDBNiAAAA:8 a=_u7hgyyAXYC7x8ToJSsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: O9cHS1jm9kJhGJeQxsuy8Cc_5iSFW_hq
X-Proofpoint-ORIG-GUID: O9cHS1jm9kJhGJeQxsuy8Cc_5iSFW_hq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0OSBTYWx0ZWRfX/9ZT1OPvYRdA
 1/qA6Z2b2ytEVcNcKvsbbbk4b2NBRk4u9r7g93+cRo8jiabQyV/1YZSwcn7UcoOD7FioJHQq6R5
 BJd7IeWOjYgGVsjELuhBWMdCiOCcBqRMeCrLFGJpuYYxt2AxAlHeEWXcM2+gILPT27KUlzwvJ+z
 RW+q8amVgf2bdoeFKe+Nz+QFSgnaf+zDjabQR4ryePlCGNXyqvZQcsyjd7XcCO/I/2KrguGK8e8
 BaiNmnPS3NTApM4/0FGzheOiBNSbNCMid354ZalZiJa+ciBVmWxqZFpoZ8cXnJDChK0je8yw4x+
 3Ek7Y2kdFSwUxK2Qu1vfWO2ddVLNSl+T1Y7RGJolYnqvZuXZOr13T3+0xbt+S7mj9BPdg+lpNR5
 AWg2vqgNm4wkbUonnh1TmGKsorWEZO0LL0QIOXxNgLGQGJrGxU50rgHhoRUA2tuWj+b2g8/TwSb
 N13VKhCyPkUMFml1fXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240149
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

On 7/24/2026 1:49 AM, Daniel P. Berrangé wrote:
> On Thu, Jul 23, 2026 at 07:02:47PM +0100, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> On 7/23/2026 8:55 AM, Alex Bennée wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> On 7/20/2026 6:14 AM, Alex Bennée wrote:
>>>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>>>
>>>>>>> Those options were useful a few years ago, before containers were
>>>>>>> available as an alternative for missing cross compilers. Simplify the
>>>>>>> workflow by removing those options and maintaining only the container
>>>>>>> based approach.
>>>>>>
>>>>>
>>>>> I was expecting some discussion around this patch, and to start it when
>>>>> the comment comes. Question is "Should we provide this feature or not?".
>>>>> I totally agree with you that we need to support other configurations we
>>>>> have in our CI, like MacOS and compilers from homebrew.
>>>>>
>> <snip>
>>>
>>> The way I see it is that we offer native cross compilers (with a focus
>>> on debian at the moment), and the containerized ones: people have a choice.
>>> We can add any additional compiler name for other distros.
>>> Also, as Ilya mentioned before, cross compiler on fedora, for instance,
>>> are not providing any sysroot. So it makes them unusable in our case.
>>
>> No sysroot at all - even for compiler headers? We don't need the linux
>> sysroot for building softmmu tests.
> 
> Historically that was the case, as the cross compilers primary use case
> was kernel / firmware builds, which could be done with "freestanding"
> mode and thus no dep on C library.
> 
> Since Fedora 40, it appears that in addition to glibc & binutil packages,
> there are now sysroot packages shipped for glibc for each Fedora arch:
> 
>   https://kojipkgs.fedoraproject.org/packages/glibc/2.39/8.fc40/noarch/
> 
> Note those package names change in each release, so latest would be
> 
>   sysroot-s390x-fc44-glibc
> 
> NB. I've not tried actually using this myself
>

Thanks for sharing it Daniel. In all cases, it's handled in next version
of series (current one has the cc test, but I added a typo so it's
broken) to detect is cc works or not.

> With regards,
> Daniel

Thanks,
Pierrick

