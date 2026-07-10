Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38B8C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJcT-0007Se-41; Fri, 10 Jul 2026 18:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJcR-0007SV-5C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:22:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJcP-0006L7-Jz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 18:22:50 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Bf71830545
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /UaOH/rYIYuLpbnUqyn3OjTkykLJ82z+58CA73Wpowk=; b=FD7+FkPBNdJizeLe
 BmZ5uKn/QR4rgcKjD7v/2jvej+n70eQct+n7wt53k1QCk/3y/Jp4HKLhodmLOy/I
 czzquCYRYsORo2qskGgBbJ0+ijTX9Gu7F/qG+WwHZkgp65PZs0CPABHBypf9Er+X
 rGehD948Mv5fhbpezVYwon2ZVZtP58o0nc2bTd0JyqVn+WULTppVKOZ4wnSpCkgn
 BtC34H9sPbUJPzdJNnEUrwt88DDNOvgfDuSdFlRlp5BzKZYOoQ68NFC/Re2vEp+M
 OiTNUn6aFtY/RrMkmZigxdHUDzxX+NY9TJyYUnvm2jZucWlBImUFA6S+Vc8TsvkI
 tJbC9A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwecgt2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 22:22:47 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso21964831cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 15:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783722167; x=1784326967; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/UaOH/rYIYuLpbnUqyn3OjTkykLJ82z+58CA73Wpowk=;
 b=NskE0EwUlPf1hrRXZvei36MxhJl00b1uUL5EO/s3vlvkw4rxxeeJ8MdxlGU9eBZeJz
 YD6OCazPU9a4bgnZn5tyHtv8W1Up/SuEN2Tx9q2wRbdBT+JO/BoYtGSc6wuPRJoikuXj
 ae02Tw9hmUEdOSrHtih2syFhV1ZwlKPOl/Jhydjin5fl/Y3KmV0fmEUV2jtIgsE/wmj8
 eZTOfYOfNHGQ1iu7pw6FFyHIe2rAicYl4hf7Cic/kC52xOWKZ9nVF1BUdOEiYCRenus6
 mqB40uxJeEhGiLWnDBu/igDBYlnuElLM3r16vs93wsxLdLrmEVwbARrher53In+paxt7
 edCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783722167; x=1784326967;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/UaOH/rYIYuLpbnUqyn3OjTkykLJ82z+58CA73Wpowk=;
 b=MAvhZMP5SNJRH8hyz15F0bpL0RQwbPKnk3ls8ogdGUhzDGGqJ2XBrWZ2EYYqyQGdIb
 E6vlTiFAfEucpHu6/8sMNBWnc1Pv4UMM5Z7tBC8sjskXpeMxJHh2Z4vpl4HZ4QYQOZO4
 wxcqaSKex3/hF3717+OWVnTKIfkQaYtO3k4vHBznWV27dam3jBJNEqXxLRT38W2RAsUs
 ny1Jzw7T5qisPsWI7EhMoFWZCAN2ROONVNBNPA/JGgiKkvVp9oMGup8RtLKl2pAv/eH0
 J41F+WS11JmUfwaHElb3i/VKXBQj2AaM5F81H3txioD7Km4D81CHaFqYkuRRnNJx+dEU
 PzoA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWMNp7Jt6fd+o6sOPQ84PezVOtHekNKIYqgE+B4zZOajPIaFpdk5YporP6qXN//xn4+NfPdb+A3Ezg@nongnu.org
X-Gm-Message-State: AOJu0YxhTwD5uqm6t6bP409/Pow4n0+NktccA6mCUq/pVcbbxau5vSy1
 ZVFmdpaEz4ohUD1hbltEkjFaAHnP6lgA0+K6bSDSIk3whXsvuniFaqTncwErD5yy3xOtyyGoOEp
 E5+4arvh/gjnxhXf+tkn2EfDbMaIUxew+YrOZVGaZsPhvA2vaoOuixV4mzQ==
X-Gm-Gg: AfdE7cnifMsxgfldhWIevoQ1JeBIdTMcTQXU1bd0Er0XxBNgdq4fi4MGNhyuZSMezs8
 dy8TJfaiovY5yQOqB03Bhbro9Jh7GstK8Y0X6HEIe8Bjr26UEifU+vTDxhU1SomBDyh5CZ3YDEV
 uGno+0mIl+twS297t/Em7J7hggW9kACLJgNeQvGp/UnKqTTyRWsYPUslzXXxBe7abzssOBidosy
 Rc8OX0WY4RnerzeBGJePPgbu/C1Njw7+q2+A9KSXpihAl1j5qpBio6uCdtPxMzs8B+Q6EVUiP7P
 ISvSV3yHGwjotGV1c6DCdwYWvIUFn8A5lLqegfTcSJ+nXoDulNjNY4gnCqGVgbsX+CN3ioAa37o
 zQA4iupjUunLgO7eOSXtRJyvcXVrarNZgzfri0NjVvA7iFFUVS6T1K4BlrWPHUg==
X-Received: by 2002:a05:622a:4d8e:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-51caa02bee5mr54861961cf.8.1783722166903; 
 Fri, 10 Jul 2026 15:22:46 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8e:b0:51b:fcc1:a0b7 with SMTP id
 d75a77b69052e-51caa02bee5mr54861671cf.8.1783722166514; 
 Fri, 10 Jul 2026 15:22:46 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6f373csm278939565e9.14.2026.07.10.15.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 15:22:45 -0700 (PDT)
Message-ID: <bee98b6b-9faa-4218-afdb-81cef308e52c@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 00:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 58/98] tests/tcg/m68k: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
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
 <20260710214343.2065491-59-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710214343.2065491-59-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a5170b7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfXwS1X+prMrXB/
 bI5RKGt5ldGtIiS+3vgFhB/6lZZkN9k2ud6VUbWeRMsjcvLzU3FqjIT3EX3kgvAEWzEGuVT9bMm
 vFJrLKGBkjF3U3s3chVh5J7iYMmx5dPAO2ykadqNv9F1mIiWYwRyThy55pCuvO8HEAprTrkmCUh
 uMTfZkeDld/RcLEkRnsPCs/F8/kC1hhbyYknjXnQt9lyp0pjLuqdou3g4dx7ig1cKoBqPlJU1ce
 75U5ijYJvcSXDOzIo/zqvV7le9znzB5G2dUKL+0xTPQ9+BlohHI82S0kz5bjz1VO3viA1t2FiDq
 QrDBj7KD+6J0fN8DFa/x9WAqYTQ5jT5uzzaC2X3B27G8mhu5Aquv0ALhcaFA51zMRtGrQesMqmN
 5CrVIghl1h58JcjOkZ6t80IU3TPalXHJv5RmAiVv8e1AIawoUQJ3NJG+gR757vrFnKQrmLzYcOi
 VvWnFzP0FFt+pt58O5w==
X-Proofpoint-ORIG-GUID: cMg9Mo45WSQZFgtMlxjKeIiR2sc98wyz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIyNCBTYWx0ZWRfX1h0un52p1x9N
 DRW9WTn91N4HrXwblHqKgIN2zYLdg7UVNkxULu1tJBor9t0QjcDHAH5taqnkFQp6tJ2kCqpxeIr
 KBeqrQeIjYp6cQwIGIPlMj8dwAduOhs=
X-Proofpoint-GUID: cMg9Mo45WSQZFgtMlxjKeIiR2sc98wyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100224
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

On 10/7/26 23:43, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/m68k/Makefile.target |  7 -------
>   tests/tcg/m68k/meson.build     | 23 +++++++++++++++++++++++
>   tests/tcg/meson.build          |  1 +
>   3 files changed, 24 insertions(+), 7 deletions(-)
>   delete mode 100644 tests/tcg/m68k/Makefile.target
>   create mode 100644 tests/tcg/m68k/meson.build

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

