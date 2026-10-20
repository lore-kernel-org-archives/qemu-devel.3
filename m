Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83C4606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=d+XbyrTI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=UdshOvAn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIzP7-0003go-GJ; Mon, 19 Oct 2026 22:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzP6-0003ge-EC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:16:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIzP4-0004pA-LV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 22:16:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K0tI284031740
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TiNVEy6CC4w9W3jXopcVPBK9KZTk8YAy+FPuVCc/eaw=; b=d+XbyrTIqVGUVVpl
 5qwVov+v4TY81Wy7aRTPAdOoB7tiOtd6eQPvcILCujq+XqilAcFIXqecC/I6A1Sj
 K4cLrQ0JlizrMCeYwPRwq8k+b4gVngZi4J/coEVN+rSWJT4Xs2QbN46tWxCLjAPW
 fBjO0yyBHrbmevQ3OWf8oT30xku1ncSfd5BJ1aWezdQhYUBOodW1fmaQA0tXtTdy
 GgIj7FPRJ947JmEZjl3WTHfU3jQOh9QS3VInHx3BTiHRfSVVYTYuy6mHoNoRCpZE
 non4RBYGJlcXBZBcTpEy84dX5Lgm8Hwx2yRv+klbhOmsvf0s61dfonlb5xvqzF0a
 t5QGvw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5q8dkk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 02:16:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f20addba1so514191485a.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 19:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792462595; x=1793067395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TiNVEy6CC4w9W3jXopcVPBK9KZTk8YAy+FPuVCc/eaw=;
 b=UdshOvAnupHLo2EE6KWa7cx18RD3taPZbI1iTTA82V9iq2nniXtBBzTKZyCS+U8QOD
 9r9m20NOnkcjD/l8ZIZCCkQgQe00QjTGcEdhILobfVGmNZ0yI5lauUv6KtIgyKT1NrFK
 jldghdSLgLgnuZNbyYLRv4gOkGpTp0k4csI4/gCNs8NToqwDDpBg7Xeqn2MJKUC4APhC
 lUDMQCX+aQOCQnHD7unPlKt1wAzeHJVUOGjT9ml1LlSqi38pEXSLIqHMu/irAkSmh36e
 TCZRltTQJoPbXsjQZLlKMNmTsXbUVjkbDlVnfmI6hFdLmP2vjIqjB25FPucUVzIilQMG
 SC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792462595; x=1793067395;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TiNVEy6CC4w9W3jXopcVPBK9KZTk8YAy+FPuVCc/eaw=;
 b=qu+QbjFcKxAA7Z8+Vu9LcgzherAG8uSNYajruUE7Ie32S6QRz+F4burQYxrMZS+uOF
 pfJ7GIdjSG0nQEvFz255xBiNK47OSyP5XOOdhPb0J2SvlEPTjXgwZAJD1+EWxcnOl4Be
 lqcElp/pS2+puiCM1wr+04O06EdPUqsAPO5atHWdg2k+qeiUWg6n9f8lhdbu+sEjnROL
 u3XsQfOH46iKtoiCiRY9JxdM5ZqMVuM9falUcWnc6Q4/lM3S3HBZHuBNmTx+mb1CKjB2
 2VgKIYcSabQLKPPt5JjdUKWzFnh5ysifoZTkjIY5/hSHvWAuYMG4MZdhCYYLxWFFhJR/
 UO1Q==
X-Gm-Message-State: AFq9FYIdcxr58nCX3PUggMyphmqPKZW3+tKfAm/mlhj/u7KpD2FwnSXg
 HM8RPYjyOkWPQEMwIfg1lfWWeK0LdcSnKi+fVFPv8wklQgUG3dvgfDmLtd53CWyogW5PGPTcDfR
 nJQygru6VT4QgIqDgHxGGErUSFrip7MLjjWfBJWoYwGjRtoqGiWKaMKO6Ivo+MstmpA==
X-Gm-Gg: AYBFou3NqQtmvGsltjwx7dHzt0U8GPN0kzAwUo0DO+DAGZkSMcFKYlq2WqGcZW5+iEs
 Ws8cDYRUwq8XdFdCcGvXO64LOYp6a687a97DlN/p8CooUwTEwyimauFbzwuDzm6xU/up7v6bDa9
 NpNABhvcHc1m8z3/FqjzTk4mLPOW/hkbqVIuQ4gazxkW4Gl0/yVhB9cKqLXbvpb2eKa+0fMnY+S
 vPcSH/O4/QxRfP7rFobJa8s7TvKjUchXjYU+jHdSdvApNirq+JOY+aZSo5GZ3yTHN3RQQ2Xa8bT
 y2e8lR093CQoff93YiuhxLKTRwVGQXyhp2yVdsWE7QuTpEgiXtXsu7e89b3NHiXGD4kH9ukVExN
 KPXJ7rvRmN0DtnPKIkoOAHatl8dsECk6oI75EWvggPKpbD7lBOrCEa8NPYphO76WKi4dqrriDGi
 Tobdw=
X-Received: by 2002:a05:620a:3941:b0:93f:1936:b1f2 with SMTP id
 af79cd13be357-93f29deffc1mr1624750685a.81.1792462595595; 
 Mon, 19 Oct 2026 19:16:35 -0700 (PDT)
X-Received: by 2002:a05:620a:3941:b0:93f:1936:b1f2 with SMTP id
 af79cd13be357-93f29deffc1mr1624748985a.81.1792462595150; 
 Mon, 19 Oct 2026 19:16:35 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f4b0a612bsm108762385a.29.2026.10.19.19.16.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 19:16:34 -0700 (PDT)
Message-ID: <ee5e2402-d6b5-4149-8baf-81e8cedf0bd9@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 21:16:32 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: fix the allocframe framekey
To: Marco Liebel <marco.liebel@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Alessandro Di Federico <ale@rev.ng>,
 Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261016170848.4024042-1-brian.cain@oss.qualcomm.com>
 <CAJ+KCYN_aEF-WQ47FSVfukbpwKKW7KWgRu0ScP4RwhVf-TpdBw@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAJ+KCYN_aEF-WQ47FSVfukbpwKKW7KWgRu0ScP4RwhVf-TpdBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ehGsZNFTCRs2qIEpY7WGBaiWy2JB4HLs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAwOCBTYWx0ZWRfX5KlEmuFhDpaw
 s36Enm2a1l7FL8iUAZLPZ1+loRk0aZiydJBkwYZ9ZpS5yx4Ki4V+1M2StWOu/cE7jHwLg1cVYgE
 7pYwSDsWNrh0I4kFaeOpbj0A23t1B/GDHxqg2Hd+iuhKIkUr50/GnQCr3FsI4EldE3e7Ja7FEtL
 wewi86JREIEVOHBF79NViS1SBgm5F+H6ixW6CNh6FGs3O+eoY+JENJaTocLUX1zlQWWLubVo107
 0ZujiRvPs/HCyySfRWECo4dt/0guzfFoXgWG/7Utw35fmg1n6Y8jm8E9/G9GCx7X+NNKvEYvw7q
 jodeg4v/EqwL3Cxp4Cch3AekY7rgvKtsqbEVHwIhUk27cHsxANnjMZDaSFuBvTvu6dVT9tUj5U3
 Gq3aRID/LMnRKQNnncFlRT5rc9unjFSdt+jFKRumO1zIneT5uvgEBvjWh8sxStPSlIARVz2VnEu
 AZoMbBT1tEqlMlvIpEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAwOCBTYWx0ZWRfXwYdVgNK7clBp
 jDDH5l7LNM/4WyH0fvwTwZ/BmfD7n2/1O3HX/d2meAmeQsF34/Qc3f89Va6h+R54CiOQnW1BnGz
 9yLuVQIzB9AHB/1XBpyuKNdm/1Ymy9c=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad6cf04 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JkfEh2lVXA0MPjuTWAkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: ehGsZNFTCRs2qIEpY7WGBaiWy2JB4HLs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200008
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/2026 5:11 PM, Marco Liebel wrote:
> On Fri, Oct 16, 2026 at 12:08 PM Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>> The frame that allocframe pushes is {LR, FP}, and what is scrambled is
>> the LR word: FRAMEKEY is XOR'd into the upper 32 bits.  The generated
>> code for fFRAME_SCRAMBLE built the key from FRAMEKEY in both halves of
>> a 64-bit value, so it scrambled FP as well.  deallocframe and
>> dealloc_return only undo the upper word, so a FP restored from a frame
>> pushed with a non-zero FRAMEKEY was corrupt.
> I think the commit message is not quite right. AFAICT the error only
> shows up when idef-parser is used, FRAMEKEY is not 0, and allocframe
> is followed by dealloc_return.
>
> That also means the test doesn't cover the case that actually breaks,
> because it pops the frame with deallocframe. allocframe and
> deallocframe have the same bug, so FP comes back correct either way.
> Only the first check catches the bug, through the wrong FP word that
> allocframe stores in memory. The other checks pass with or without the
> fix.


fixed in v2: 
https://lore.kernel.org/qemu-devel/20261020015154.3600098-1-brian.cain@oss.qualcomm.com/


