Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5F3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz99-0003ce-M6; Tue, 07 Jul 2026 02:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz90-0003aT-IA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgz8z-0001Go-0q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:18:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66749AMY2526856
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:18:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sPS9dcWV+S1JX8Ns7wiptWy5J1MYrcZBYN4hXn9jJZU=; b=Lz4PHizM/kUeVduf
 AkcA4fNnhQR+VW2GMFHQU53vLRQA1ps4nnSUywRDlXbl07rySjEfOUPYXTG435nT
 5JpRM/8p+qcEKXWiDra1rKum9nq0GEEsGkezUl4X1zbsfq1haWXmOW9s94lNywbB
 jUQOaL21Qqd8ZDYwk8/DWZb7ac7wWnHXBcNOzZv7wD71jCbXridKWTOg7Q0/QB3Z
 +V1qlrQGMQ8pZetf+RXOOPVNKyrkBHprmdCq1ILMidR0kZa2pcRL5OVf21ycaEgr
 VbCqEXXaU82zdqgCm77ZH2tXg2gppYPTYrKSJoUg2uCbkVMo6yUjwHfeVyyASDXI
 4HrdWw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98mb1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:18:55 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c110a3b6aso54359201cf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405134; x=1784009934; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sPS9dcWV+S1JX8Ns7wiptWy5J1MYrcZBYN4hXn9jJZU=;
 b=YVKYQvauYYaOneDnokIhobdIBBJanmEYVtdkowaReHoWciB7o0dPY9xJPIEOUX1d3B
 pshcYRw+DbLPxeVMkSvedoYF+rTDuu2+8c58CBYVzdNuH4JTBsqqlQ8wwLn9nPysWLKP
 yijOEi0Jp+kDRHL5VOuGTkSuZckb6Nx0ofJ5QSVOP/e9wYmCh58KgPupGjtgBQAptxuW
 CJIscplYU/aDATPMwsANwoHOYbOdN9fh5LcO3YRXd0aCUO1hCq5YCjVvxA61bdpqfE5/
 iZPkKDBXQtvk4/1DojepvJm7VlgkiRKKYhj+lRsMlKL0NcI5nVSoNw6zMGIC59XNodiW
 3d5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405134; x=1784009934;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sPS9dcWV+S1JX8Ns7wiptWy5J1MYrcZBYN4hXn9jJZU=;
 b=jjQ4r1hF553i1MKbEbRYl0CL3S1S4LEDnOlhjtwed9cWJnkOws6xt6uOdHPXrzCYzC
 4umFqnYZWIUGD6iTABAMsCFTbEIflbMnWvBuWqkuNPdQRa0zBcyGdWj14QZg0sdw7MWy
 VW6k5Ijlo6VjMmFqLGpGFTTyo05rib2VkrorpCjylqi2SEbHUSBe+sgxLmh/kERWLWBO
 yLNEgWKl1B2+1C6Se/VNdBoSOOgzYZ2h6BosiIMSV47qPRsD4IySG8eGTO5EAbsCLX6p
 OyE3F/52jjng+8zsH84Y/VyNI3rh4ZkNK53yJcpeOyGrdgyaOVGhd1Mi/lum8bjNTVa1
 Omiw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpfnI3y88LxEtGBD5K+zrH0Gb3Il7hyd57g4sPM0zyle59Iv2ua29z4aQHRHw3Jx3vxtfujQROlnQJV@nongnu.org
X-Gm-Message-State: AOJu0YzR0NjrKSe7L2YV8bDqcd7yoKZ2yl4VQzMmclX8UePjHOWH9hYt
 DwUkd1h1YL/F8rwvaEKlwt8MYRQH8PlRFx6ktyRn72x0zX0fLzYkPcngRNfXbf1GZ9QlDSrW+jh
 FVP58yqvld6+Umr5BNOCgOE26vjUuwpnovc5HfOTDFvLljhHmMWzuyrZEGQ==
X-Gm-Gg: AfdE7cm4j/eUCw5E74e96UApcO6pW4aS1FeIh3WPhRjgjP05ZXviLUOzuKOtGQWf7j2
 XuZDW/KcJf6DCh594Ledd3IPaHBNHZwU2MYqCRoV3TMWo6dneFd6pEbwa1IYPx0WXdXEbLfogLg
 tGq0uukc2ycc/WYO3pOsCGlPEvtfe5rEVCcQSmxw8KvYHKihFsp57XWpP6A5x3Eh/RaMOGCxHTq
 4kq/5pXFAnWJN3DQnxCED+dWOVhKGbO/E98yJrKWkB4arEF+btZMBU3FLES6WXhZSl1uGfQhIaq
 Bvs/n56VYuWI+cmcgTsX66Gn/3bRZvQDk3vy86KantMHquPTRIkHBfOQpgs85oGuvMB/7HvAHf5
 b7bpVTVcy1mIftPziz3tZ2W3WNlVwEW/vorXxmTmN38i+Z6xsJLAbxm6r0VFIfQ==
X-Received: by 2002:a05:622a:146:b0:51a:8b64:69e2 with SMTP id
 d75a77b69052e-51c747bdf9dmr40519301cf.7.1783405134188; 
 Mon, 06 Jul 2026 23:18:54 -0700 (PDT)
X-Received: by 2002:a05:622a:146:b0:51a:8b64:69e2 with SMTP id
 d75a77b69052e-51c747bdf9dmr40519091cf.7.1783405133774; 
 Mon, 06 Jul 2026 23:18:53 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e01c9faesm25789915e9.1.2026.07.06.23.18.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:18:53 -0700 (PDT)
Message-ID: <b844ad78-2449-4b69-9ce1-2dabaa3de46c@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:18:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 87/91] tests/tcg/xtensa/crt.S: align .text section
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706223343.988769-88-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c9a4f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX9M3Rp+N5Th+v
 XayNARRhPVoYVJI16Up5mOnDUM517HaDl4S/EOGwFqR6WSEnN6rgYR7TezGLXJkj1tUW0RdraNH
 loY+Pelkv8sDiHXAz9bYDRhCQxwM57bgFbwo/JnwNHzYgwzMlVKssgezH6JoPP0RAxK5U28vZLD
 RpXeU9rIc/1JjiiwdeiKSavTZrV8TOQDrCwM3VRak8J1J7boYnO4XqaP9XyuBUtmHFCgEm5z3AF
 KFngUXZ8oOrFw/XIdVvR0+JQf1t4Hq15BK/d1P8Bw8q9zLNJJ4JMT0idcKG46HTDC2dBtGBN+dD
 06lm9V2OBMRXwddFn/melZLAyXoCsGrNHB9HA9WC0cY89lqOHReEgWGiLljR/4dv7uNDAxIJvfi
 DEyRMxzYnvFio3QeRN1QfJrV8F73RZJ/Bs4oz4OJ9MrjmSCShoZlyKh7PbI4A+da+SqxIQbndyC
 RfGUWm7P5Y3Ep8q6I0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX7hNu9LqV+4zx
 xDzC1MQfYBSW1JgalQ6N1FmnAtxZf5id8jgRx4OLgzwhJYRcZ1ao/tt4snM7kfUG/cbHLf26zm8
 ii1Si7XwOI1xLr9YstFWNcQH68c7T/A=
X-Proofpoint-GUID: DSIWhKxVAFiqJJF-mKApLwAB_H1OOZ6Q
X-Proofpoint-ORIG-GUID: DSIWhKxVAFiqJJF-mKApLwAB_H1OOZ6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058
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

On 7/7/26 00:33, Pierrick Bouvier wrote:
> Needed, else we get this error:
> dangerous relocation: l32r: misaligned literal target: .text
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/xtensa/crt.S | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

