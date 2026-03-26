Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0611610A62C4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5kKq-0003V4-NF; Thu, 26 Mar 2026 09:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w5kKl-0003UL-Hs
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:01:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w5kKj-00059p-7q
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:01:11 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QAH8iq4015282
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 13:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ud0KfbO7t1Nbmay0cytwMuXp+W6rqr1AXrnytsMAJEc=; b=UBs5FY1Gterfm83q
 s8Aojmcm3vcUEiM4ddMqpuQdNDCBcZu2o/N5u4w5Gc3gxbVMwoglT8bUy2XeM+6g
 8m8U7JpBjnt13J9h1nqpnqZNYPjlUroJumE1z+AdqjYxxMAq1wtSCgOrMCMB1Dfm
 IlJmzPXLzB4EkGnttnsM4lb3RYFutLWEIag2rsoOBi1srCS4TvRJnoWw6A+/RmkY
 o/Q1HF+SAFqMw3NOiPy6lAFP4Y12wxFCXBZWe+lab4DQhKyZ+PWiq84j56RK6qOt
 s1JW8qJhdKgnghGZhYFojN6pRl+2IgfZxvNbSPomNLAiEukPdd/0AkWtuhcmFSkv
 lY3x8A==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4w1q9u0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 13:01:01 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-464bbea2120so1498852b6e.3
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 06:01:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774530060; cv=none;
 d=google.com; s=arc-20240605;
 b=dJfboHIgpxhf7ttJyB97OWjHENmKNeDjjrgxntTCqp6+mM2WZU+9AxXNrGKY7M0CSu
 989sJ6dvlRIssZ+m6NBMAEQEN3kSFeSXFq+wj5Ag2Zo8YAiOlcT+K15pSBTaP9y2Utby
 AwcoT34ViMMK6BarizqOx95Z+vwzJnrNA6nleoyVOUH116JFtG7SaXfV0pSOfUhzI7/c
 49aZzFCQJ431YrA2QjEq7GY4RLX/Cb6WamvBAA3kZEysY4RXiGCvnzlAgdDoyw9CZF24
 zcg3cDtnbUu3e9y4AYoYUIIOiRdpXhziKw0jkb46v83Aoph3/D9AaHJirYGPPElko8ia
 c2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ud0KfbO7t1Nbmay0cytwMuXp+W6rqr1AXrnytsMAJEc=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=jH1Va1sZ6OH7fAce1vi0XLT/TABliZE+xspQyqJMyr9Yx6sPjOp8Yh5x3grC/7clZ9
 lVSxaDtpXiS5Fg0XWOscG979hHPin/L3P98xJCu7zNqogZ0pCdxmZzZVyp4+LB65lv6P
 /qfQmUZm7bUhjyb0LLOVjTMMuwFFSMfLgVrid5JWIDG4PxEC8SEOk9w6jf9HfElLsXRC
 lNfe6N1u1sCbSGYvBi+fSNcWssxb7lIehilYbgmsKZMXnD2aIQk4SqdYQwImSThFgfV1
 gdpXOTv4384ZFR0F5knZjnBFUIz6QrVwR4Bem88SUrktHGXtSApwOiU0uZZVrwGkA8ev
 /S4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774530060; x=1775134860; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ud0KfbO7t1Nbmay0cytwMuXp+W6rqr1AXrnytsMAJEc=;
 b=GfCsgxUtmxfv2U9w1QDwX8bE5EaCjCWEN0wiDeZqKD7QARQ6vJH6TjgFCHI/Vxas88
 UWHJnzgTQLYXypPUOWDPrmzlN/7kldBffNJfM2Lsk3pVorsgLYSxrwN5Gq18VEp/CflD
 ZnB1PNaA+Yg1Z7uVt2mchFRq1S/gyV+jytFioBTSD7aW5MZ03d2wmCfmOKc+wdpMGDym
 X7A9GgNpuqRGvnqE5gstp7HWBi2AN1Ta6HdfmDK8mMH8TkmIMtvzsi1jbiqX4NxZTaAf
 AuwCLqr91dLMUNLWirM+4ZXLBb/9kYEqsoKukBJyIaLd2Xmq3O8H4v8h+9CP9biKsZYS
 elWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774530060; x=1775134860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ud0KfbO7t1Nbmay0cytwMuXp+W6rqr1AXrnytsMAJEc=;
 b=Pk+WljQBlGRa4p7bW6VjhsIFqJlCfIKay++fkC3ZbkRGXQS60J9/VxWvnKStxDYUoJ
 5o91be2scD2FdROi81RsRBwvvn8/P9hGoem2jAuSoFY6MVFSlSic3VoUjYaNPX2Eg/57
 vA+FH8Cgp9872GIxY8S7cDyAWkb7ZN3uoNvf4Jikp1XWpqrCw1/RS/cVz8WBIwwvB59O
 nLMYHeiYs8FYGrkLUvuQ3pBg27raKGMoZemnEmrYjU0ONqsl9QQ4Hq7Id0PQPTi3PMVA
 7aMWMPa2gbVuAcrt+YCADA6cYfMrRH7iwV/HFdjBHTXlgeywL49gFzWCvnkPFGI5Mxi0
 nPxQ==
X-Gm-Message-State: AOJu0YwVlqXEeel8dkTYRGRIj2NQsG/tH6tIz6FP45QXOk2hCCeuZ4PW
 8JaicnwLhOfpmN31XzGOcA1Nj4qGOc7ANy2hPEE6K2pS+8av+oOq3xYLmIaGPloCPGAw0UYgvvI
 /VlrivjtqvDgG6pAuF0Hij0wqkSPtDL42rdOuNPeVfoGm11QL2pagqPVQOknn4YVhdz26HfIhl5
 xCspa1CpZGJxXOi2IWlFlmCksv3aYw9KmZ
X-Gm-Gg: ATEYQzy7xwMxTUl9BECdv+s+EVQAcE6vkGY7h7kXMO995fLhKpHoG6U8R9WoDO3U+fA
 9fjuAWKkV7I+107RgdrpHunS+rw7AMSVTZrL6fc/DQjGK2vOIW2bu6S2dT6RYiljyHiMg3sD0kF
 SE5N9fin1doG/IvNpMQNtCirXSW27nWAFUG/yRxAApuajgOcSMtXh+mIrbhUPKiEU50v6X8pYgn
 Oo6MlY=
X-Received: by 2002:a05:6808:1911:b0:467:1462:a9b3 with SMTP id
 5614622812f47-46a5c6b4cb3mr3667610b6e.38.1774530060440; 
 Thu, 26 Mar 2026 06:01:00 -0700 (PDT)
X-Received: by 2002:a05:6808:1911:b0:467:1462:a9b3 with SMTP id
 5614622812f47-46a5c6b4cb3mr3667555b6e.38.1774530058443; Thu, 26 Mar 2026
 06:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <c687d91e8ad5b476593aa1969113e8c51987f156.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3NpAk+oPcPgiBwauV12-kk3H8E=v9ytv3ifSMuS=0r-K8w@mail.gmail.com>
In-Reply-To: <CAATN3NpAk+oPcPgiBwauV12-kk3H8E=v9ytv3ifSMuS=0r-K8w@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:00:46 -0300
X-Gm-Features: AQROBzAbR2cq6QMf_E4IdxEzfn2m5gVKBk0xxfjr4BRK5mBAT0e7WMMRjwZnaBw
Message-ID: <CABrGZ+EEkuXnUvmMcq4qSK9ZmPgMOV2y7W8ban_CgYq3-SbarA@mail.gmail.com>
Subject: Re: [PATCH 08/13] target/hexagon: add v68 HVX IEEE float compare insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: RZWYFecGHw51jGi53oGak8r2ZQFvfwwZ
X-Authority-Analysis: v=2.4 cv=HvV72kTS c=1 sm=1 tr=0 ts=69c52e0d cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=qAS1vpt3FCguH2Yi1pEA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MSBTYWx0ZWRfX3LaNtjg4moKv
 vH9TlkDfvQMTjGOC9BZAxCfCeHdu3ZwTFe728ezc5dYgUjsQVB+qoGoSOtz9Y6oI9asVL6Zn5gS
 RNUljHWCemqn2HQ5QHSl75GYWxrZEv2DVJhFV+M15pkcRPIN40in6VRUyfhphGta9BbdLMA3kOB
 efQXohWPGVZpIrf2NHLh7S9OBXKq6eRDlJ+Y0o7fnnRssQE2a2p5nYNTDKrRgyqXMCc/aND9EUQ
 vyHSBDeEXPWrQwyUoYdFY3p7WF+udZ/GnD3IAYK4+wgZSU7+XfMTc8X/5S5UU0MsrzkJG5qcrhM
 j0jzIuD4O0TtwyaF1j/8L+p+yjXgjm8tFe9q1M9sDtbsMm5AHa7UsI9/ftaazPVWJhUdHNK8Mzp
 5ZP+z+wkZ2V7GgdFA1Ls3485und/d7PkfpdpskH+LfVna3bQP9zUt1OhHj03QwUVkA5AmffrB+W
 G3G8PIgwtXxMyfANyZg==
X-Proofpoint-GUID: RZWYFecGHw51jGi53oGak8r2ZQFvfwwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On Mon, Mar 23, 2026 at 6:42=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> Add HVX IEEE floating-point compare instructions:
>> - V6_vgthf, V6_vgtsf: greater-than compare
>> - V6_vgthf_and, V6_vgtsf_and: greater-than with predicate-and
>> - V6_vgthf_or, V6_vgtsf_or: greater-than with predicate-or
>> - V6_vgthf_xor, V6_vgtsf_xor: greater-than with predicate-xor
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>  target/hexagon/mmvec/macros.h                | 10 ++++
>>  target/hexagon/attribs_def.h.inc             |  2 +
>>  target/hexagon/hex_common.py                 |  1 +
>>  target/hexagon/imported/mmvec/encode_ext.def | 10 ++++
>>  target/hexagon/imported/mmvec/ext.idef       | 61 ++++++++++++++++++++
>>  5 files changed, 84 insertions(+)
>>
>> diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros=
.h
>> index 2af3d2d747..c342507d1a 100644
>> --- a/target/hexagon/mmvec/macros.h
>> +++ b/target/hexagon/mmvec/macros.h
>> @@ -356,4 +356,14 @@
>>                 extract32(VAL, POS * 8, 8); \
>>      } while (0);
>>
>> +#define fCMPGT_SF(A, B) \
>> +    (float32_is_any_nan(A) || float32_is_any_nan(B) ? \
>> +     (int32_t)(A) > (int32_t)(B) : \
>
>
> Seems odd to do an integer comparison of two NaN's

Oh, this is incorrect, indeed. HVX ordering goes like this: QNaN >
SNaN > +Inf > numbers > -Inf > SNaN_neg > QNaN_neg

I'll fix it in v2.

