Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD20D2FEF4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 22:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkrbc-0005As-IP; Tue, 27 Jan 2026 17:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vkrbO-00051s-Qc
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:32:11 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vkrbM-0006Yo-0Y
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 17:32:01 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RH25l81335293
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 93c9sWK/KkUUm2o40SfpWLg/a8epTVJpltQaMUeU8/E=; b=iVsD27iUEdj52yQe
 RPEFq36RA95aNx05bOgYbNEiHrQxLSyXPro15xTwvk5doZi+EnVVXP8nlPkHwK28
 ZR8fyTd2CcTS9SK6R/Lrom4MVtowKQ6+wqrQ4iFGRsO0En/E5NzLYId9ejn2PNZ9
 CnqJtEe/aW+KMFLQlZXyKsU27wVP6eq+5yoMg8IocpSph2y+jgbcwijndFhzN8AV
 YY0OJlU4tsTv+P0l8sicmuQg1qQH6ey7jc3o2XADVas8U7PJ69KFEhzrwdXkavLa
 Yc+8ho8P+bqIYhcA+W10q1eCsq1erVwJbM6lMfz196XQt3k4CrccXW1BwAGaC7H5
 mrxyYw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1dfryjy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 22:31:58 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-79456b49895so5953857b3.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 14:31:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769553118; cv=none;
 d=google.com; s=arc-20240605;
 b=FgiTb7ve9ZDV/T25YIY4hmQKRwQliNvah3JcGu/qSedgW3MI+D/V+hJLmymyU+lajZ
 H1J1i9+QfA3B3c3F/S3NS9FMZcaBTiYLOeEYxn9qIMtFNFCOUt+snTxt8OUWfrhv6Y3b
 8nLAszttWloR6K7dGjmYD+0MI/C+qj4k1UAc6VayxCIiUwebD1nYIh2N3/p8gjtvEWp2
 YU5BXSoroy4kPYLgpiYRz/ul+6khO4S65P89U0evIhh8sth12GTWoINdFn2ja60Ncuvb
 nRnGoLTw6/VEeZKsIH6xRkWHDkrOHvhr/o2yUjfNhyX/x9yAYEYg5f1vY1UNCr35pYyC
 A3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=93c9sWK/KkUUm2o40SfpWLg/a8epTVJpltQaMUeU8/E=;
 fh=NQp3XXUj57xQcYczVbvMj5YZLQEMlmZU+N/xz9MpQVg=;
 b=YTssW+ZdsOw32/Jfo0zMqdRJXdVbRqsmQx1ruE2+0vkIJiDif/UHFnUM1iE42xcN2t
 FH3+reDMAMFws2Gm5ucrukrSXBPhFv6+nJpi+XUXtAuLZQYnxbvVNaxrSkoGX8KqbLXz
 8wG4U4CiSiEumul1+5SxjR+Vc6rUnu2rjQJ83jF1tNU4a6vFOeaash0pMaD1jK7p+7O1
 8VHc2ikvUquNeClQSRxG76WTIeLxe586igWx/JbSE0xHMxLDbK8axASmR5+YnznXlaRU
 ByVfmRzQXeGeW64N/E2y8d7dXz1LodBshA7AgO45syFwG4zgpBT6RW+vYqYinDop4RbH
 C1BQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1769553118; x=1770157918; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=93c9sWK/KkUUm2o40SfpWLg/a8epTVJpltQaMUeU8/E=;
 b=hOBmoIX+W+u1cZl+n1fbrYWEjU0Jcyv9J7znp72pKkWpCN968fAiEaURm9CoIuGSij
 swoGOfbHynqasdP67iwmULbjaaw3BS5BSBxXo2IXAaDviMdeF3e3qkmnWbCanvX6L0Pu
 uvUHoQ7HCWDERlXYvnUzr77IuOyAF28VGi8SyzVZKIOgMId4hpYhACspGxor5XO9mO7s
 kJy3X+rhKEytoi1kVU1o29W/Li0yZ79Mhj6zHdTglMDOhoPipKpOrPYWasoa/Ro7KnBR
 szX0IUIAFci0et/LQPvf5O7prpPrs5b7/kfMOpH0idlHoms0hLbxOwwHqSdCDEZyKKVW
 grfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769553118; x=1770157918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=93c9sWK/KkUUm2o40SfpWLg/a8epTVJpltQaMUeU8/E=;
 b=ee13yUl8uf2kyYwKZrtNz+wVK9PPVsuXk7rZ7YaZMPQAeEo3xnOfDTZXuK0pjtoYN8
 llwMVv9NbAp/W//VuVDeVBreQKJKTuGv9m0Njdv76XEfsbOO3r9b6NRLqRzIYdDC5A7v
 bvgN1z5fr58ST2rgjbXxuJ45HDrJK8TxUxZp0ocWFZNCJMJLKMzzq2rjbPbUOtX2BxXa
 VPJf+FU3t0NXIS+xBGka49k5/w/b3I7nBhMsd70TsA0h72IS2VhjS1uRxG7CCdFw55U5
 OW3p8tdH5CUKCn/xEJ5mUtnQ1LPhBl1omN4ZSpgwYUe3Y29lnRJKbQGt+vCDk1gbusR3
 svdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVTtxjTO2O9iDQHJ9CNvxzqX201O9fhZksrxI0FgxnsmlQPy9y1X8esRvtUFRn/U+GV365wrpKQriX@nongnu.org
X-Gm-Message-State: AOJu0Yz8A2tnlYZkPtkOPNmn6gwBZlDeJqadwx3VdpM0tthQCaSoqmc2
 PU1IioGxJvxLF2jpJww7RL1Lx2H7XxPoBkNKC1vifqatvuBwa4ePSctHGODDJ4U/GDrlXbTd4FX
 NRTR9M44XKIYGDSqsdPM1Zqut5Mzm6Uy/wcMiRvNdJ1u1Xa/i66V/uhQ2xCxxhwvIndzDr9hEkn
 WXXcPs6sxcBYkIA8FK4wxhP5NYvAtVI9KFXeyXtQ+c
X-Gm-Gg: AZuq6aIT/aFW1H1welH2x5vFPOjtaQ/tvMQvraEzBag140kwJYVhpGvzHUQ9ioQJlmz
 ca23v09ivWTL0v03/qfL/ON44VZS83Ctei7TIouB6i4o+Q3fBAR+tz/ruzG5PPtppkhEt7JnYO1
 T8wVEIKG7DNDDpFJ4sSIfcRtoYrtEnaeZpTBF+RePXn6hh4izMyMGQRg/EohUopEiHdJY=
X-Received: by 2002:a05:690e:1408:b0:649:5bdd:cbc4 with SMTP id
 956f58d0204a3-6498fb1f12emr2263628d50.41.1769553118189; 
 Tue, 27 Jan 2026 14:31:58 -0800 (PST)
X-Received: by 2002:a05:690e:1408:b0:649:5bdd:cbc4 with SMTP id
 956f58d0204a3-6498fb1f12emr2263622d50.41.1769553117828; Tue, 27 Jan 2026
 14:31:57 -0800 (PST)
MIME-Version: 1.0
References: <20260122223423.1076448-1-marco.liebel@oss.qualcomm.com>
 <CAATN3NoZiPj5wfVm6+4MGEnrVX4sdZhnS4Wj7-_0SUe5u0wZ5w@mail.gmail.com>
 <CAJ+KCYO7YK7RSMz=LwT3H8vHK5Y5KJWa9oWb=ZweQ10DA4jpGQ@mail.gmail.com>
 <CAATN3Nqtq3ioP=9ch4=9jo0B3Q4tNrgkfrDm7sG0MLuFprC3pw@mail.gmail.com>
In-Reply-To: <CAATN3Nqtq3ioP=9ch4=9jo0B3Q4tNrgkfrDm7sG0MLuFprC3pw@mail.gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 16:31:42 -0600
X-Gm-Features: AZwV_Qhtycct7ZB6HNQFRdA9_Ghj-ELtOvDMWu4yE8uHtCtsVAUXV_KfG1vX3ko
Message-ID: <CAEqNhNY6K1ePn_yR+p_1VpbyKnzXhFCtNXSrxkTjBTkxMkXvhw@mail.gmail.com>
Subject: Re: [PATCH] target/hexagon: Change DisasContext packet type
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDE4MyBTYWx0ZWRfXwVMu+sI4jjKF
 y7d1JKtxh9AjZ5OPhASUKgxt/lQxkh9t1OdwcmMl/R5Ech2lvh8zg2scJdqqUSpjIRKzQ7aGtHv
 nxXfwSOT52s5s+k7P1eDVsIOtJqOm8VapPyREg21MTzZfF1RMypPNi4zqDWwX82cm8Sy5dCopHv
 syCuN54v1q5zxNLIAMS1oVh5bnCtgcvV5nxNMm7/pLwDZXNIFLk0QxnlBxnxwNM4FF0Tqf12qE7
 dQrCXhVhROom07VVSaF0ts9tD75m3FyNCVVPumtXlT+lcKlGWBZVXBj/mG++UjWw57J5jAovpmo
 qCGoc0gIxxfSL1g0McWV9XdRzm8XNpdJ2hXmc/Si5j1ILi5ku6S2bWV0IajlZ4WLg0VXe3TW2Xg
 m5r7I9b3f4SV8QgvXjP6C6WtHEY/TjEbxtapkhQ2P/UXEUZkeRdlNZbf/DQSf5JWSg+Z+Ar78+j
 mf2+faophOwaBiQx61Q==
X-Proofpoint-GUID: QX6m-6poPZ1jedAWn-CWG--2yMPsiG8J
X-Proofpoint-ORIG-GUID: QX6m-6poPZ1jedAWn-CWG--2yMPsiG8J
X-Authority-Analysis: v=2.4 cv=YeuwJgRf c=1 sm=1 tr=0 ts=69793cde cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=o5uyStZ8BK62zvfJR_MA:9 a=QEXdDO2ut3YA:10 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_04,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270183
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Jan 27, 2026 at 1:07=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Jan 26, 2026 at 3:07=E2=80=AFPM Marco Liebel <marco.liebel@oss.qu=
alcomm.com> wrote:
>>
>> On Sat, Jan 24, 2026 at 5:41=E2=80=AFPM Taylor Simpson <ltaylorsimpson@g=
mail.com> wrote:
>>>
>>> This patch would be alot smaller if you kept pkt as-is and added a new =
member
>>> Packet packet;
>>
>>
>> That would reduce the patch size, but it wouldn=E2=80=99t remove the ris=
k of a dangling pointer
>> and would introduce an alias instead. Is there a specific reason we need=
 to keep the
>> pointer around?
>
>
>  There's a bunch of code throughout target/hexagon where a variable named=
 "pkt" is a pointer to a packet.  If you really want to get rid of the poin=
ter in DisasContext, do 2 things
>
> Name the field in DisasContext something else, e.g., packet.
> Don't eliminate the local "Packet *pkt" variables in various functions, e=
.g., gen_end_tb.
>
> Then, it will be clear that "packet" is the actual struct and "pkt" is a =
pointer.

IMO the types should be enforced by the compiler such that no one
could ever confuse the struct and pointers to it.

Whereas having a "Packet *" that outlives the DisasContext or whose
lifetime relative to the DC's is not always clear - that does set us
up for confusion.

>
> Thanks,
> Taylor
>

