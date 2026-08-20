Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4193C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 06:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwwND-0002WH-5z; Thu, 20 Aug 2026 02:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwwN7-0002Ro-4n
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:35:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwwN5-00065H-Gl
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 02:35:28 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K5gRvl1438609
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cA6hnluAcZ72jTGvk0MBD9q0GfMRjBWEt5QacuiM9I4=; b=pBPBMaWbXkcx6cxb
 T0rkKhvP+Ue7L7GVBDvYp1dP06exKzyE3BH6/EgXSmMG9zQtMBNg/7nVKw9mo1WU
 HYYpirddFFNMlXS4/s2xEtlOMQQfC3Wsh+DZZ9UBBVBCFN43rAtQbIryeTSEYoOi
 s472CS2TBzBHDnK+fSSwn0ltJvOV20AAmLB0mIgipneuWRCd8mD0fmrZppzQ6xhj
 t3Vt4MiCwRCHpDwg+eE+F8znpARXoQ9DF98czuBQpQ3xBfygxr/yXv3gGjPC78a9
 qgBDFoZ9p4IZbazZCHeb5rE8AumSodxLO1VGx11TY1VMxqeTL9SofnJ5Ce8F3SJh
 hl4HvA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5daa407u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 06:35:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930a098ea19so287042885a.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 23:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787207717; x=1787812517; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cA6hnluAcZ72jTGvk0MBD9q0GfMRjBWEt5QacuiM9I4=;
 b=gf3tMcAmGjIP4HvkuTqX8SWbli6s7KEVD14CJ6UQ9VD9KDVGaPjaC8oQuWLchza5oy
 VTrFvdFz9M89yViX5Th3tBYyIbLqeWf3KnkRQImvbqX7DnT4vr8c4Feg/TTmsDnUkVTJ
 Tu42NqeuGbBZAz6LHXhzTldEQqPCfjuAJkBOMCCY38U/CdfURxoUH6qgSoKOn3zUb2rQ
 Opl3WiPl2Ych1LWYwBNyFpUbB/hKYpOuw1epYKpEq9mRgGH/WjhCCDaKQJ6pPJiatTH3
 eOLk4Fbv+QV0wEz2BshxS9lHurS/u+PXTJdAosnsctJVRvdKg5070Df/xmwj4aKuRygl
 b8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787207717; x=1787812517;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cA6hnluAcZ72jTGvk0MBD9q0GfMRjBWEt5QacuiM9I4=;
 b=IcJg6T9iwRIMDqjyeXDASlEiYZ+vwNQMb4DCFkZMHcrmZLHQkVgts6fGfmbBiU/3aY
 DoRlYsl9/oUShTlW5CubuHpN7GzITbfqs/ka7QKkEMSs5f4poq+oakILzlHuOMhGSKvB
 /5Z0O3RTrfVG+bY7/F4N7oT9/iEikbPE7eNlFBOzviuXRQznJjGl63IN7osnxj0Uu4pq
 Uq9VLD7AQbu+j1KtbL708k+zh1ok4Md4zRILPXdiKQGAdVNhQ1BR8QgWuSxKwV1NxHfl
 rdN8xU15ZEMLch8k3qdXDL93elvIwM0Oeqi7SdKH+tU/Ld3y3exZeI98c0R1pBr5tCbS
 Vfug==
X-Gm-Message-State: AOJu0YzK9ttEs3ve58gpAaiiQ5Ko5sjFJUhLJox+0vZYXT2MznijUrMj
 vNWA0QrTEGvS0Nu2H/UIXFsblGcwAsavDWTonhdCleVe6xBSii+NX+9MfsP3O5FLQhoOdhK1px4
 JGznTiayVSHATb3eWhkVXnEHQfpOgvSgIhoqaCNLZlMM21NqnPfmCFbLK8w==
X-Gm-Gg: AR+sD10xzQRUql5WRyIt73QOcWPt+kI495c1q23M1Z3kgsTczEn63eMvhQ8F2dSsgyC
 y+gl0Ix0ZbinRO/i7iMcgv6qt6q1hyWPWlpEyTfV5wBJcbe6n5wxE8GuLu3eGv8x3d+FPviQPks
 XRj9gPDYv27cIPNrNb1JO68JzegUmvqGKojYf//xNutCUg59vX9dspNAyIaYCUgKhbJwk4q2Fm/
 1eR3IAf3n7irLrSN4tdgBHvSHxq0c4gXP3QzoByJ9UWdLoM/Wtcm/VjwZseyAJ5PKt/lZGttqxC
 KSRlP6a3Pb+GceQeUeeQ7AajCPARsWMBaRxdnYXSXexBpDA7Ykr3Vr1uvbyMHOepvdIzsOh7aoH
 MYHMbuKFxSUM8rPBQarCCo8f8VGSv3zGOnyw7VeX0
X-Received: by 2002:a05:620a:489a:b0:92e:fd2c:6a26 with SMTP id
 af79cd13be357-9371e6ade25mr900693885a.24.1787207717675; 
 Wed, 19 Aug 2026 23:35:17 -0700 (PDT)
X-Received: by 2002:a05:620a:489a:b0:92e:fd2c:6a26 with SMTP id
 af79cd13be357-9371e6ade25mr900690085a.24.1787207717190; 
 Wed, 19 Aug 2026 23:35:17 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441725sm10033449f8f.3.2026.08.19.23.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2026 23:35:16 -0700 (PDT)
Message-ID: <7d92bb11-1fba-4104-8ef0-7b2e00d02b99@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 08:35:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390x/sclp: pv: only copy the original SCCB buffer
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Janosch Frank <frankja@linux.vnet.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260814125857.1729543-1-borntraeger@de.ibm.com>
 <9dd7335a-1257-4aaf-9a1e-f423a04a9fe3@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <9dd7335a-1257-4aaf-9a1e-f423a04a9fe3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fv3sol4f c=1 sm=1 tr=0 ts=6a86a02b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=o86ZDcQ0Z0Vg-zWIv1UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 1KeRRB6H3nUMIW9qp_3GPlFJ_NAlq5kx
X-Proofpoint-ORIG-GUID: 1KeRRB6H3nUMIW9qp_3GPlFJ_NAlq5kx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfXwqACXV7ipqla
 DCBzkVLabQNBouj0Us6p76dV2cP9rsivNaeDvxqEG9BjH+DV/SoNhFAxpU4+R/QXge1fO092Xvm
 kK2Wkym3ukLGL8VwzZi7gZpBt56Z+m8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0NiBTYWx0ZWRfX4NDPZ89DVQXM
 DuaHIshwIoWjQa1Vvipoz7P5NoPdQxTHbQMpOmbwlUPirLRfn/R2LToI8hB+8VUdAhqR6qKeqAQ
 y6csNlH+1rPzl5NNfYHB0Yytj+18i2bDS6e7RiI5xsTeNvrc6qJC+wkCvEuR1kXYd30IQiHbCdv
 q62vVLqiwAlLy7aiN5ap5zvZz/B9He7uzVd1HczWKI9gvLczSy/KAs1R5CeQ7JtIA7MlXJx7cRJ
 RAkyiFEg+Vl+x81Nxm84dj7Z3okP2SJL9nh3yUWxo1xqTSlvMgQHXZ22Y0Ed/Pp1fAGOOjhvFE1
 uqV0SB0sQo5qLwHUvS5SRw57PkDJtUeljg/dt4A4NGQllvnMRZxZnsYjedB9Km37QuSMGsqqC+c
 5psD1PYp8Ezhe2wrpSQt5+SPsVQfSphcuNLJMDAvfSODmfJ2/bj9UH5iLxaLTpAmn8dnZDkWkFM
 wQBdVdLbmCC6JB9ZU8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200046
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

On 19/8/26 13:06, Eric Farman wrote:
> 
> 
> On 8/14/26 8:58 AM, Christian Borntraeger wrote:
>> From: Christian Borntraeger <borntraeger@linux.ibm.com>
>>
>> With variable length and EXTENDED_LENGTH_SCCB, some callbacks might
>> change the length field. For example read SCP info might write a new
>> length into the SCCB header. We must not use that new length for the
>> buffer copy, since the buffer was allocated with the original length.
>> Only the length field in the work SCCB is changed, to indicate the
>> "necessary" size. Using the new length reads past the allocation, so
>> tools like ASAN might detect a buffer overrun.
>>
>> Secure guests do not have EXTENDED_LENGTH_SCCB, and the ultravisor checks
>> and sanitizes the length field, so no qemu heap contents are exposed to
>> the guest and the non pv-path already has the same header.length.
>>

Cc: qemu-stable@nongnu.org

>> Fixes: 0f73c5b30b8b ("s390x: protvirt: SCLP interpretation")
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>>   hw/s390x/sclp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Thanks! Applied for 11.2
> 


