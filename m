Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADC010F2848
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69Q5-0003pn-9V; Fri, 27 Mar 2026 11:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w69Q2-0003pJ-VF
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:48:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w69Q1-0002vK-1o
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:48:18 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62RDhRU33701396
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 15:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HwBsEZ0gOTLfbXicz55c+qK5Q7ux3DRHReAXHn609ck=; b=jphIKpAnBecE086o
 +Ee3+Qrx+uSaivmr1R0qIquw/qUMeF7Z9FYgpNeVvl6e+ni9Duebjnv43IyZsklx
 Lrb/3K+xSILLI8nbQbNuGPSEmR9yu6NYffsXRjVsXVb5sQ5LxdfYr4c9xmvJAl5P
 7jjS3YGZH6ZiP6XLX86E7Py5IBHYX7N0eeOxh/ILtfjZfA7T3MdNKE1EIfefl2G1
 SvmeOoPUzB4wrpCb7Jjm/Nu47Vmmmyp/S98xc+KT9qZm3X+YjybPYkTTZObRclxs
 fHNelMGCAyDmJ8ZLYwa9Va1cjkr8L7DNJFv25o6zx4IMKPUIF5he8mZj4aMUDMiM
 OrHo8g==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5jcx2h1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 15:48:12 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-46724fd619cso8001830b6e.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 08:48:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774626492; cv=none;
 d=google.com; s=arc-20240605;
 b=NYy7DCsHS1vap4+RHyzRo4h+/5t7BD84vahS5z5A62w+AtW1EIT2Ijr/BdsLcYT66h
 cnR7wn63icg3PV680XF66oGt9mYsoEjGbJ1M1RZkhzOwAwpLjlxtaM/b9SsbqCuTnw2P
 9Ofdg0+Qa4qSf8DOWsGKY/vpftj3tN4Rbugj+w8T/53gHTCYcnjDvOCQW/fk4akFk5GE
 GoGbDTMtcYEe8h2xu3sTfq7GRzmzXipw0+sifxX4TTAn17G0l+2r4qpmRjmVO6VEzGtk
 GE5p9bbmcsIdF4rpOJrYYeUjX3fPfj93XKaFz6yJic8tNdrtpz4WB3skvE1rJA4qMDkt
 sgAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HwBsEZ0gOTLfbXicz55c+qK5Q7ux3DRHReAXHn609ck=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=FJhE47EriYDdZiATZmmljcG0YZiRoAZBQAAxnpjmnX1mAQDwtiuRbaewwhZRU7a9nF
 O4ZeW+IbCdNPkAcF0ujoVF+J8HdFw45Lxz6PfFf0xR1XCEkyheDUx/4d5eh1K68KiPRv
 XuYQUqjTJ6aGa4OTq+fbJ1k19P3sKZU3UHI/siIVQaOT+rgVCBQslD7CVpLvC76xlY/9
 03egmTNP0Ii6IMDEOrbT4hY2JkK21bpejh36Ryzr+gKCcpSyKwtMzGrr1rEyqPzI5clX
 iBSthx6e+KugdFSSgPtxlF+eulbS5vn47NSAH1L/zCjVs34tqb4tJ+4SU4DAk6CzzvSy
 5MGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774626492; x=1775231292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HwBsEZ0gOTLfbXicz55c+qK5Q7ux3DRHReAXHn609ck=;
 b=grF8saIhM2hk7eUImQreb5Yx3iMXO00HSqmEX3VDQgFWajM1ChZEd2AZ3irS9yIlkU
 4n8jvfXmeTGj2d6o/jLTdV79Uk+DdFZS+kl9bCHdSYrVVEtw5m5+kVgqFD/HKpcEvWy0
 VBUtk9uCeRPy4WsvwIpOH1cAe4OAzVA3OqWGELIKm0RPBA1NvN3c3TJbfAhFk242EFJm
 wme10fStNNDJussk7WmWfF3ZMvSvNqQhm7a0Sredz77CYM+sJ5s61lrb8cQJ98XuZzWM
 nMbX4r6wuF/KIvTbCmbprUqepjnh9s1VfdE+qU3d8SSXzJFlzGnOh7B58UCoLvkn9X67
 bgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774626492; x=1775231292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HwBsEZ0gOTLfbXicz55c+qK5Q7ux3DRHReAXHn609ck=;
 b=EdcLymOOyhjygrtIFeEvB36+3ljkqxkRYzh570NovsNsh3k2hvA2EdivxtEam5TPKp
 3pemx8V7OejXaepjOcnWJbuC1D6BnmMopHUxnH/REFVRwkxYDAu6HuYz6PPWZkUp3U/o
 WSi2ImqxTPl/PDb2SJmCFECWSid+BglcIRTACI5Q7Yfro1QyXsIaWUvjcEvUUNf69ina
 3jhvMrYejo6rapwr8D5mR5fJkXTCqJMkuYxaDK68u57prb5stDYTJNeTp3rtlfhXsaVq
 HOpEXu1ZUl8Z5dbewIQgK5MBn1fK4T5SdqQnlZe9fclyZyVwLGvarcI5s/JCZZBHdAYn
 RAHg==
X-Gm-Message-State: AOJu0YxVCNBlMA4ypPtCiErLnDf7C7zVXpf9hc+6+OVHSlm89T1EOj5b
 fDlAMJqgAERi2gPvuqVvKao4T2+sSsMeJftN/EeLBBWoVpujcaszAHrJ3R6Gp+41jKklv/Dc+P9
 YbqfIDsKKkWbLFHaW3oA+DTS1auZAvS2LY038HYTB36jE+gZoqq9bz+nV+T7o3Sk91sSojnXgz0
 HfvxyFVgXJtmaS1IgD8/i6s7+gRBnQDiig
X-Gm-Gg: ATEYQzzCDGOJVt1iw2DzlxLXLVF2u9BgjJn/JdAYw6aXDEGVuMahs8MNN0IPZHuti36
 GZAm1wwUqRAYNnCGjExVGLRqITXEZamPM3W6d2ZMR8LqHmm67aNRje4nSS8VFm6Cz+BcMZ19dvt
 QS31Dl3n8ECGvQ5L2ojzgAhYQc93dq69/dNlR7sp052NlTTZVtwMimVOJoDpgS3IOvr6moien3k
 z1W
X-Received: by 2002:a05:6808:3509:b0:463:a42c:503a with SMTP id
 5614622812f47-46a8aff1587mr1175584b6e.14.1774626492313; 
 Fri, 27 Mar 2026 08:48:12 -0700 (PDT)
X-Received: by 2002:a05:6808:3509:b0:463:a42c:503a with SMTP id
 5614622812f47-46a8aff1587mr1175562b6e.14.1774626491853; Fri, 27 Mar 2026
 08:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <82c5487435a72c68ceec1c09dd6fb986409328e1.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NpkMvcWubprGjd705iQ0XCAJD+toCnEv78E3=ZL+eSemg@mail.gmail.com>
In-Reply-To: <CAATN3NpkMvcWubprGjd705iQ0XCAJD+toCnEv78E3=ZL+eSemg@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 12:48:00 -0300
X-Gm-Features: AQROBzB9Fntl6rnH0uzxAKa7wbI-KyHP6wPJwDRx_p_-zsRJ8vKZ7zfSaDumg3I
Message-ID: <CABrGZ+Ft3G0Nk6YcjuBjYZ8FkrkF7PcSgrHeiRER7mOoczRg3A@mail.gmail.com>
Subject: Re: [PATCH 10/13] tests/hexagon: add tests for v68 HVX IEEE float
 arithmetics
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=NfTrFmD4 c=1 sm=1 tr=0 ts=69c6a6bc cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=LgFpps52YJag8_p1HlsA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: RSJAZi4CYmR-5_9QLqYh10HVZzBLwil1
X-Proofpoint-ORIG-GUID: RSJAZi4CYmR-5_9QLqYh10HVZzBLwil1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNiBTYWx0ZWRfX4f7Si4FWWcMO
 9SyftpeunEQLiGwH8NDGFhGO6/E064Fp3H6XCxg0z9/k5ayOXJsx6dWuC9HTb3kyG1YLf04rR/Q
 BOSsUvoHPw60qJg1e8aNXst2mbDMhrnSIkpGTDrv5Ne9OqN5QTylZeFcSahOFdu+6sx+aazm2cz
 hwLIYLrIq14L6JmhJZq1LnyT2p336UPrapW2b0/LUp/CTUNHIOvUAhD5ilSEgcuq5oKLfISuO6Q
 ZkrSMrL86RZNN+5VBf4ZgRx+Sx2BNgvPz/mpMzJJz9vVT9C/+cHjPXDI+J/3X9OD76OVGC8bXHG
 sx+PnWI6IvkDCVmEg5grFNTM1sv1hrgTh8y7F9k491HfXuZS/GCD6pRQWrB83m+8Xf7kuI1ylOT
 3Eq7w6Bf27jqzZdCXSrGICOO8/3cTpdFtouOho2AQEePEIkasGqik/O5rWzZGzO9U7e2R/mf12D
 V+nW5Tc2eYuPHG7ItZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270106
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Mar 24, 2026 at 4:05=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>
>> +        HVX_Vector *hvx_output =3D (HVX_Vector *)&output[0]; \
>> +        HVX_Vector hvx_buffer0 =3D *(HVX_Vector *)&buffer0[0]; \
>> +        HVX_Vector hvx_buffer1 =3D *(HVX_Vector *)&buffer1[0]; \
>> +        \
>> +        *hvx_output =3D \
>> +            Q6_V##type_res##_##vop##_V##type_arg##V##type_arg(hvx_buffe=
r0, \
>> +                                                              hvx_buffe=
r1); \
>> +        \
>> +        for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / bytes_##type_res; i+=
+) { \
>> +            expect[0].type_res[i] =3D \
>> +                raw_##type_res(op(float_##type_arg(buffer0[0].type_arg[=
i]), \
>> +                                  float_##type_arg(buffer1[0].type_arg[=
i]))); \
>> +        } \
>
>
> Put this in a loop over the input buffers to get more input values.  Then=
 change the second argument to check_output below.

Will do!

>>
>> +
>> +    check_output_sf(__LINE__, 1);
>> +}
>> +
>> +int main(void)
>> +{
>> +    init_buffers();
>
>
> The init_buffers function is designed to create inputs for non-FP functio=
ns.
> Create a new function to initialize the buffers with interesting FP value=
s (e.g., NaN, large FP values that will lead to overflow).
> Also, see my prior comment about FP flags.  We'll want to check those her=
e.
> We should also add some tests with packets.  See my prior comment about .=
new values.

Great ideas! Ok, will implement both.

