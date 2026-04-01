Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8F110FCAE6
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 21:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w832L-0000OA-Jw; Wed, 01 Apr 2026 17:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w832J-0000Fm-OJ
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:23:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w832H-0002yS-Ql
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 17:23:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631J75Lw162659
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 21:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FAdPMvdfm6oiuK7q6guxJq/mG4vv5AQJqg2Cg7S8uZg=; b=ZArr4xrgWFdLIxsT
 jB9FWdvQgGgtMPaEhJPfU2TY9A9dg6lngXvsoY5S1O6AyCoFnl0cxczrJSYHsDbY
 bzAQNQXiPSaUWafBfTbpaCnLmszpZ1TJ065h4dDAwcwXM8ymWBtW/H2luYTsVu2B
 maoUFrGO1d2KLV17OC02/Y2NBIzLvBZekjzn0jYd4FLOBVlGzE6edhXMLZRzz5Y6
 0uu44PTAiYM6GGhJBI/8/j8UKRYa/3sXFKrxJcam+SJrpQkiN73pKOB6uT7o0G3v
 wn+abnB9AeZ9f3b279n5dSQZrNUOPBYDfea5FP6TBBKm0DbC1pARq4YM5Ki5SfO+
 lScZ9Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d94vvhqhe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 21:23:36 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-467e8ec004dso952383b6e.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 14:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775078616; cv=none;
 d=google.com; s=arc-20240605;
 b=C/aevob/VXPj/AYH7Hnimwje9Ze1z2nh0LP+vnrz/piTOvwCQaeDuVoKDQMsgGqjN8
 NUgRnndkNDTCqnsgAfipmU+Mt9xVBUbqD6OJ6roiNnZW/WohVrBbZgT+sXwoWzZnYJdo
 poHatGzQp3QEDmwiXFkS442wvENgXsjl0hufamyCd5M26FuCDEVYSWnmn3TnZy87TAF/
 becJe9HuorsddoNWdUO8iAfcVqf9MOZbXD2qaIkw0ilhlxj+PdDgIbcumPxO0u6jePdn
 XLyRRtBg7mrpmE1CPJRze40sV4KywxHrchRrTYYLPiQT3l/wjcSrVd0hG5nCllprbozp
 +oPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FAdPMvdfm6oiuK7q6guxJq/mG4vv5AQJqg2Cg7S8uZg=;
 fh=STCp3PQ88sR75xM6Wd7zfJieGdI9giry8k5QLTqiQOk=;
 b=QlTEpv7eCrBWamfm/67nv4GMCC/WnLUCe4Ame4VK4nzXZ12ePhWQDZYOamGZYB3oJz
 AQRACR3qv3GHv58MZE+uMjotbiNw3ZS/v9FF6TydMumfgectDKQYGzdd4UBTk+qOUMEv
 gzUNagdLgbofq5QxjwPcAWkYA8RkT9vI2H6qwl42Si00WGUttZA1Nqwd+qBaujuwNn6W
 ixa4pjEyc3yT7S3edfYUyiNMxRJMVVeANtd3vWPXgRyz9ErfBv909A+ZH2J2rYJrng/R
 wFYdS26sngCDNwjufCtUkhYHl0tCoTekGAjGJl5b/t52/JMGX+yIhL/wUc36SoIWP479
 ZRlQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775078616; x=1775683416; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAdPMvdfm6oiuK7q6guxJq/mG4vv5AQJqg2Cg7S8uZg=;
 b=MbGKLgaGS956WRZ+a6mFMHv5hoNdO2qwt43pSYAyNwJz5lvMu8YNuAtQgJ82pFw9k6
 yqsPpeYlsSHdlhh3eQa/6cQrmw92vBT5zxaeO8PlQAIwIWz2hzKVbI+ZtZBNoZuehHUJ
 u1leazknmfL/9wRxrzma+mQn1UW7rTIS/IBC0dCt/XR8ST1H0baWTRp61LUSporg5hgy
 WlKiqFYzHAjP0aHsrtOeW5Gq3ylUkUKrmFnRYe58SzZH+G/NuGbLQ2r0F8vf1q1LInzJ
 NMQ/bvkGm+yC4hQEmdjGtmkoVhyKvlZhvpdN4H5PuNl/wRzHj0QutQXLmdWQ2GfuBxg+
 vsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775078616; x=1775683416;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAdPMvdfm6oiuK7q6guxJq/mG4vv5AQJqg2Cg7S8uZg=;
 b=r6Xo/LlkBu46JUd7peY2NKAD4BxanBP8E1W6YwNG/l8Zb0Ta7KDBSFD5g+8uPVuydp
 GhQBD6oBXNDzSr9p/kmSWBFhG7U759GCAtsDmerXDlt5uVnUoKuIxbX/TSpsESUCBPpa
 FKGShO9Dz/joMa2oiv/iui7YEk9E50St3+j5C/sl28KBSu521i7VN/dSb/9ajJsq2I+U
 ehywLNO5PdKjNDpjMwYm6qDJZP4GIrlFoRtYXyZ0XYDIOmK2DueCBK0enF17UVv8YAgg
 rKvBCRdN2WVSc6ULOzhXeigqDzHzu5zYvXDO1ZBHZtjkcxYVY7Qnh4BdBZQ9x9/yGDnZ
 E+NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCHHriWhwMaaqjWsxgEN4dp7+WToUPN/P4fCpkeMxNHZDEzOs+MJd+fTZJi1aYgbuVpPRrmvlfI+4r@nongnu.org
X-Gm-Message-State: AOJu0YxVZXmZdWIymLhMHHp3UwT7jDIBwU1wkiZJRXbitwLWRqubPHuq
 oHM1OTHWvFWr6s/zhHFvhw6TvDBH4mW2yVVOvgfVBUC8BKQo9oB0aykThLNV7CjAQ9Q+p6D/f3G
 C0ApD4Fxq+ycdt99SNPePUMBR4q/xKc4oJN+8rW94nBOA27pipkCMl/etRlYeUWUtnY6nH+8VQD
 aMZgv8CWHz8pdZiKhqgYIxwenN3RHXSE2I
X-Gm-Gg: ATEYQzwcjqo2GGhRPLvMcP2baO5AK+cBwIu3gHwu4KQG70tHHwRqu1zkrTT1AQ6bmXC
 KEnFFCKNFW7j15WvXSV5awssr+g5l+XhUmwsonptJ33n7gQso8OSrmyljgobOEAbTQGefYuwtLi
 EDn+mLUn1iJIpCnO71ZMqXdP2bppEa50SAG61GywbQztwVs0+hPhVCh/VrkyUxSaNzKDJjPWu+M
 Ii3+rc=
X-Received: by 2002:a05:6808:228e:b0:469:fc59:b128 with SMTP id
 5614622812f47-46ae010af08mr3118431b6e.25.1775078615845; 
 Wed, 01 Apr 2026 14:23:35 -0700 (PDT)
X-Received: by 2002:a05:6808:228e:b0:469:fc59:b128 with SMTP id
 5614622812f47-46ae010af08mr3118406b6e.25.1775078615422; Wed, 01 Apr 2026
 14:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4f6bd77ba6c6c07c8796e805ce6e50539bde260e.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NrTa3qL1jZew7_3L2mfeK2PT3RFTkTDxQUZ_4NK7wAmAw@mail.gmail.com>
 <CABrGZ+GiQ-KiJVhyCHK4EfG__4=mbJhj1rhpfczASuQ+NT9-BQ@mail.gmail.com>
 <CAATN3Nq+BSfAFrCfFEfsOWaSt2JsHC4hVm+K5hJts-iAF83wTg@mail.gmail.com>
 <CAEqNhNa2ner=c6Zb-TYVTJ7Foa=quSRYG3MVHn6kpmG4OCGfxg@mail.gmail.com>
 <CAATN3NqwCo5D+6SPepoW2h-qwgdRSg9CDW_MRKWejHeSqvBqkA@mail.gmail.com>
In-Reply-To: <CAATN3NqwCo5D+6SPepoW2h-qwgdRSg9CDW_MRKWejHeSqvBqkA@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 18:23:23 -0300
X-Gm-Features: AQROBzA7Rt5HwaONRK-zWUBjiyTQTA3gyI7YeNgPyPV9JUn8c2LaYyxCJKTqQRk
Message-ID: <CABrGZ+F4SzKunQEk9B3pDwO9aYhZpPS3zNksLVv9o28ZL4C1wg@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/hexagon/cpu: add HVX IEEE FP extension
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 ale@rev.ng, anjo@rev.ng, marco.liebel@oss.qualcomm.com,
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDIwMSBTYWx0ZWRfX7D8JPuaefOgq
 cMEinQ2JRYi8MT54U70GhPrPJIBSuvebE5q+n++Rc0yILVk5p+MQbApnEJ65SQw43W28xMV+vDH
 ClI/CyOs41iP5SSgflFXeJ51e9MQURpr9SmQu8KACC0hOkEMaIHWJ92b8QjnRDMhS+qOqwopVJb
 AzPXw89G6DmMgxyaG8vWzdsIaV/0hIZ4IT9VsHWJvs+Cj7NItC0b9NZoYZ/YeIdMvbr9RKbnoo/
 h4kLvR81O2SPzln2UxCXBtgLC2zMxo/5/qQgS3fozCFZmTgFJtFRxLVtN6/83x/JuT6Tc5aya2Y
 2LHgZ/UymVjtuH26ulU5dlu5TBLwww7J6Ox6Wol2eE6ujEUgHOpDq3m4TULfHU4zvVNQRfDxZlR
 ufEErz3RmCoVc2eMvXzCflNCQu+o8paAZVrG4LStpv9p9GcD/Y5XahMA/96Fepw2YX4xBd1HOX3
 R+Btua3KYiZlEZmszJA==
X-Authority-Analysis: v=2.4 cv=DJSCIiNb c=1 sm=1 tr=0 ts=69cd8cd8 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=ytO2O6-1L5WBU-Cj2AUA:9 a=QEXdDO2ut3YA:10 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-ORIG-GUID: A0BiTFv2Zq5fn4QCYK6WS0dLJiJGeP9t
X-Proofpoint-GUID: A0BiTFv2Zq5fn4QCYK6WS0dLJiJGeP9t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010201
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Mar 24, 2026 at 4:46=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Tue, Mar 24, 2026 at 1:21=E2=80=AFPM Brian Cain <brian.cain@oss.qualco=
mm.com> wrote:
>>
>>
>>
>> On Tue, Mar 24, 2026 at 1:48=E2=80=AFPM Taylor Simpson <ltaylorsimpson@g=
mail.com> wrote:
>>>
>>>
>>>
>>> On Tue, Mar 24, 2026 at 10:52=E2=80=AFAM Matheus Bernardino <matheus.be=
rnardino@oss.qualcomm.com> wrote:
>>>>
>>>> On Mon, Mar 23, 2026 at 4:33=E2=80=AFPM Taylor Simpson <ltaylorsimpson=
@gmail.com> wrote:
>>>> >
>>>> > Better to leave the instruction alone and turn it into a nop by not =
generating any TCG.
>>>> >
>>>> > That way, the disassembly (-d in_asm) will still show what's actuall=
y in the binary.  You could add the check in gen_tcg_funcs.py.
>>>> >
>>>> > You could also consider adding some sort of marker in the disassembl=
y to indicate that the flag is needed for the instruction to do anything.
>>>>
>>>> Ah, good idea. Will do both for the next round, thanks.
>>>
>>>
>>> Note that we'll need to be careful with packets that use the result vec=
tor in a .new context.  For example
>>>     { V0.sf =3D vadd(V1.sf,V2.sf)
>>>       vmem(R19+#0x0) =3D V0.new }
>>> The problem is that the store wants to read the value from future_VRegs=
.  However, if the vadd is  nop, there is junk in future_VRegs.  So, we'll =
either have to get the store to read from the real VRegs or have the vadd c=
opy the old value of the destination into the future_VRegs value.  The firs=
t option will be more efficient because it will avoid the vector copy.
>>>
>>
>> For the sake of ease-of-verification we'll want to do whatever the ISS d=
oes.  It's not very obvious to me what it would do in this packet context b=
ased on the description of the nop-like behavior, but we'll follow the ISS'=
 lead.  In practical terms the garbage in future_VRegs is probably just as =
bad or good as any other value - if you bothered to execute this packet on =
the target w/o support for this opcode you probably don't care much about t=
he result.
>
>
> I'll be interested to know what the ISS and hardware do in this case.


Interesting, just found out that the hardware will assign zero to the
target register. Will change the code accordingly for v2.

