Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EADD2FEF8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 22:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkrY2-0007Ky-Ap; Tue, 27 Jan 2026 17:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vkrY0-0007Ak-FL
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:28:32 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vkrXy-0005aU-Uq
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:28:32 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RHce9T1268740
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 56M4RJTNwaWLfXOvidzbXiuTfQC28ZRDs5LycEOoliM=; b=bA9kY0WgCGXq49Gi
 NtWNTFSk+6w25vuL4hLUG/S/QD3RgI3wF4cJFbjhzBWb2dAb4mYRr195IPUQWv2R
 AbGJTUkT2qZaQQrqjSNgP0GZKTjd06t9TX0/ZMFL+NufV6VflIImbXXyI38jBqLO
 pmXQmBmEONZvUiQ4ox/3c40zlXEKqFQ7+llIGOGPMjNPDXbAMhxsUhKgEgW+t4p9
 SQHQzijds3hy8VmLWaznUaJdPEDNXc4aSaGLPD8iR9gTo7ZCEH1Ejhbi6Dj6kByi
 hjtLlDwE+DAzjZqQrHuzwcWetw6zzOBajoPlbgfQQVXj5j4Vqm4J8lwDeiOR7rjP
 hw62XA==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxnyauhmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:28:27 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6495ffdd360so6699038d50.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 14:28:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769552907; cv=none;
 d=google.com; s=arc-20240605;
 b=Ea/i1K+61CoD1a/f8puWUSdLs2oAvNKfIEWtjoEFHhXiwA98hsyCQaj8WKgWSUxRWf
 K0I1O4NuiJVJZnB7ETgJl1eOH3LV+nSSSU17kUbsz804uc/q2JpYWjfHLVRC6UBCHZRC
 QvH1qnP4vHJswAqXmcouDrvbuL4cr/2ph32QaBhcSFLwQevgacy1oCupruzPdTFqzHiJ
 8oRhXrmjQEuaWK0eBgJXF4ikym+yc2imE3IG5PnONH6uGVCtm+YKpKhDNWrUzjMebbFi
 e3YdUnBdtyg3iwkiIC1ULs1h0Yqlj2DyzmSWfEhHQJWIkRDlu/9PITr8NiB9Fjc98eVl
 72zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=56M4RJTNwaWLfXOvidzbXiuTfQC28ZRDs5LycEOoliM=;
 fh=0puyW1gqCM3gJMeL2RqT18d7JwASe4xVZz/DHcd6Rqk=;
 b=GHBjnzebRPQCA8SQB7m9nSygxqpetacNQWwZUApYz/hVWhwlL4utMy2M35CUS8PZZS
 9RR2he1FdJRNt00Z8McU+xholMbq/dJCrANQQFnc6pnJqA0gVYMm16r8b9Q567jaNq4g
 bNR65EcV1ZUu8cvxeiA/XKaz5tH4EETmiBsbEXOpKFQAERldxsms/abBNqlXIbRhk9a0
 5RMEyVMAnUhGfNXGp3qm06gIXKe8li0O23utwBuOaIXHntWDq+kVphthohZ509C3cFPD
 kREP5eskgNR1JOn+VOag31KX0kyWf9mGRJVkYHwNr+6NbaiYyrNC5+2Xi1uN5l/NEV5H
 QWWA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769552907; x=1770157707; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=56M4RJTNwaWLfXOvidzbXiuTfQC28ZRDs5LycEOoliM=;
 b=BCBDuB3LSZXum6PT9nBd86dUdtirjjRx+Pl5aGbayu1vBfe2xVssFZrvvqJVxgbl0A
 dVhqq6CTL232gwSRcJ6TKLTeDMmdwL8U8NCDoYWguVIQYwf5grEmKJfqtIBG6h+0oeqi
 vSQi4QD6xyoy8wPgwysksSMMqva4S/a2tvetHtZgFSTeBxputPQMRBSQX2tt6wXH7tbI
 kMwjh2epDf+oNfCTEe6c03b/T/dNVdzpkYGmiw1ruI8T1UhbULVJ6n63srV3mric9Sga
 pNGuZunCUtqCyL2TyTUzZDDlAYShCFqHaNXw+l/6bYGbmJQXxrh4cRN5AYaqqLB7AUGt
 W6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769552907; x=1770157707;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=56M4RJTNwaWLfXOvidzbXiuTfQC28ZRDs5LycEOoliM=;
 b=GtwW0eWdiM0CgUvk9i3deMuhmkZKPSAG3F0Srj3UBR/DB+HFJ3Plf/xK2ar2EopVtL
 RAMupkAZIO/9TvQu+8R6VXVzPHHmDyo46tMSR4Llv7WjKaERUJoHI7fY1/iR9DihTEtw
 LB4d3vcnPRv9FhkFq5s+gjfC0nJ9EOG7NFWjJvB+Stlsm/PrkIAk7hf59GdhdNNnToZJ
 RJk3FunJcNs7nsmzMtWNfvWmle2do7snBdkOQTnu2eF9zzChiuK9fEp34AYeYlMg3SmJ
 q/tJe7m7yKsNmE7iIDO00oGnSi+ObISdLc/OaBuFkCNwM6j4UOERKoHrJHEDmTKiP8p5
 ncgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQInP3WjKsvyvMuIGnple8ord5FmfXMIshiPYf27Q/AWuiR4NxzPxa870CshgSI8DghvGdC+Cy7+9b@nongnu.org
X-Gm-Message-State: AOJu0YxRwerV/2qu6SZKR16nqk2eKEKeNDe7Lfd0UXbIJGVLctl8VF7U
 HQY8hTFMfb/XohYNpDCVkRcJS4qhQ5XO3OfkkdLaydqWTafTCE3n/hWjd/sVGy1NgrWdONE941m
 BqJRRJJ7iJ3PCxx44djTKFH0fWoTSYbt5q5ubqfN9DpcxmtGBVjZUakVkHlVlIPStKEcTWGBoTT
 8DIH93pDkmgRn+r+LXwNUKqgfVqNIL65n7
X-Gm-Gg: AZuq6aLgT5EuLToO+BihfAI2EVXsjnPdUzrdjf/SKykCH/hSG4CUOW2f6xafkrJny9q
 ym0AHOQednf95zjwRh5uoxD+Gz5wLYjBZxnuH/E8DQasgrN977frv8Vy3RbBBtNIAdalk7BqFwR
 81YxV2F2RWZzRZ4u7Q7frUhjcp9PPzOwTG2vLpwpzhUVIDrrD1N1eRpe6SueiRSHdBf3g=
X-Received: by 2002:a05:690e:408c:b0:649:58f1:6cdc with SMTP id
 956f58d0204a3-6498fc54ed4mr2245104d50.66.1769552906715; 
 Tue, 27 Jan 2026 14:28:26 -0800 (PST)
X-Received: by 2002:a05:690e:408c:b0:649:58f1:6cdc with SMTP id
 956f58d0204a3-6498fc54ed4mr2245090d50.66.1769552906327; Tue, 27 Jan 2026
 14:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20260126223439.46974-2-marco.liebel@oss.qualcomm.com>
 <CAATN3Np1mWNkd3sF8uh7p+PyM4gfe02CfdfJROUwmYpL3Snnew@mail.gmail.com>
In-Reply-To: <CAATN3Np1mWNkd3sF8uh7p+PyM4gfe02CfdfJROUwmYpL3Snnew@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 16:28:09 -0600
X-Gm-Features: AZwV_QgAXd_vDRWZ6levTgCYcG3UmdCddNfTANaiXBBeZPT7uYfE5DyB8piltbg
Message-ID: <CAEqNhNZjDNVFcgW-oKWhpXtYEStSnZEvGDazR35Qd6sHJH70OA@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Remove unused is_finite()
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: gbhewR2hMjege3U_SBLRMDHb0htXDRJD
X-Authority-Analysis: v=2.4 cv=JZqxbEKV c=1 sm=1 tr=0 ts=69793c0b cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=biOOZfN7tpq30-K079IA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-ORIG-GUID: gbhewR2hMjege3U_SBLRMDHb0htXDRJD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE4MyBTYWx0ZWRfXyf2fF3ZI5keA
 QISrzzhHtHfo8BLqqjE74/ZvyDDJohleMvJxoBWJDVGrAiJDkCM1jEP6PwILyzfccHW/TrVHBSs
 VSHPTadOzLl3Oy5PbwsSKGjmoKfWKwsdAM/3wWpJpn5/BiIqdOe6AYRlQ3G3dhr8NNNn6DZlw5L
 k4qgoJzKyO0pjhiY7ljB0qi+T2tKFaIWFDT7Lb9Bm/0B/GxbOp94UkB9gdh+Qo2sl4Cv0UjiI7d
 EJOXnGbTPFCFQOqrxyWY9Ng1iRYZ9/fmigdLdEl8Pzgh8yTguJcz7S60vKl1A7RdDyllkm62O5W
 gSpxEbF4KG73K+7XJEbQPwyXRE3cZFjz7xQny0xWc5TqZgZfayTSMszJN7mx/g4Y+VJEnjfF5CQ
 I96JXHDUqXJlQOaHsoBd5U+nlf9HWfewUojnOGNLgiUHI7i03TczeJqMKNICxQFNpaBQu4lrqEW
 lgCUXmHb7w4jvMTOqPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270183
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jan 27, 2026 at 1:09=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Jan 26, 2026 at 3:35=E2=80=AFPM Marco Liebel <marco.liebel@oss.qu=
alcomm.com> wrote:
>>
>> is_finite() is defined but never called anywhere in the codebase.
>>
>> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
>> ---
>>  target/hexagon/fma_emu.h | 5 -----
>>  1 file changed, 5 deletions(-)
>
>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

