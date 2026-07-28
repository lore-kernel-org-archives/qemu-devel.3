Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493B9C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 05:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZyw-0004RR-JR; Tue, 28 Jul 2026 01:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woZym-0004Pt-Cm
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:03:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woZyj-00046z-Qx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 01:03:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S46WAi1821206
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /QzAUaBZN1ChbuF1z0pVvK7e6Vsmp0UZU2ghSbduRl0=; b=mSVgmOBuP+JqzhQF
 uFkcQl56+HT+L4D0Nb4SfmP2p/+y4AdIiNjxE1k7GTGgLJV/SaFxx9WiNnOhyoqE
 tELBS27uK3hME4P8cTn/i4duv/7hwItHlrxUYhhK3ACYUe5aghbhH/1ejNDHIgSC
 5xg5O10CejmtZ/JIbf6RJr+aMfAP/m8V9OYcG4eWuiQX4WszHdZQsUZlt9l8UuJJ
 lD9CiV8ur0I7Fl7uDvUm/fM1IgvaBVAaR+KxqDxj2g+fVgXodZ93X40ZfWc1eo38
 a44J3VWXTF+zppnqvQPsEGHr2NIey++CcajP6Uh88AMY2QBMle6jQmx5I5YhKIRc
 LmBNQQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn3y05j7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 05:03:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5276aa86d00so42051611cf.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 22:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785215024; x=1785819824; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/QzAUaBZN1ChbuF1z0pVvK7e6Vsmp0UZU2ghSbduRl0=;
 b=O8oQQXPdTxXTK/4bvIdBDoRI5fzs74oQ/lBnsoR8W4lauWwEhhmtAaMjfn/Vk40d8E
 ZfMum58zl/hi++G3RCVye4RJLlIufSdvcDT3AN+NUM4hbHylq5dJBQVeTtIJtxvGoBsy
 a/ALF3UV0oLecqeVRhdj7ro96xzg7udY5dy39uctAb6NKt/aX0hX9TwXMTGIifTev53o
 DGIcEeJyvsc47tGhCWjU36c7zbJ/y02HnelX3Il4oY1TAPg2qlnIZro5y2v6B/MzoUxU
 nUMr0nXD49yR+w5fQGbHAGAKYIDEzcmBtuwMuxdjwsm/O3WsyCN+Pc25GRN5E34CQ2v7
 mUyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785215024; x=1785819824;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/QzAUaBZN1ChbuF1z0pVvK7e6Vsmp0UZU2ghSbduRl0=;
 b=PQ0JIHbjVzvi5CTBWOG9xspp/xc4FRw6khqFBKj54tA8ExkvluO/xeFZlsKK2HLZbB
 3sByikYHQEafyZyOnIKLAAK8Gt3gM9+4n4mnmh+PRr823fcMjV4kwolPq+d0v5HS/fRU
 j2wtcJ4Vt/a4VhNhqe0/sdE8xm+h9GR/wY81+xUZEn+G5d+dcjmz4D2uPjohW6U2pxqz
 Qm1H1hSVWR4JgLftXFLNvNqCJmftVBy1xaiFwYu5oSrekydVRky7IcMd1wDengfoB81Z
 F+QVCsbYBMwLG7+zYuUPQHHz3z7I2CPQA0URQw0wz7ABF3Q09aV0M9/XtnhhZkDJMXYX
 hMIw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrq74u7ikees3nw/JLcc7fNMncOBQh1OgzGnGOhhLd5oQh2o2FeOnZivXS1FIX8FGmZ5GyP0L0YE036@nongnu.org
X-Gm-Message-State: AOJu0Yzee/26E19vX3WGsLxIZkRj16ePhtsRw0Ns1UtodNFefl1Up+4X
 YRfz9lUvjmIeyWn8wPD5ELLelM7Z1DkQwSijSJ0y1LznBVeFS8d0V34qATYUfjLZW//XI6OwtU5
 F0S+ROpNkS361wU6ErVMtWKidKhIWzlxNcCzU2BwmASqgU5lFMRCq25TTGw==
X-Gm-Gg: AR+sD12S4dXDQIJhZDNdJAO0xwyMzFhDLFg2m9R6QE+xnQ/jT3+HpL9yU5voL/wgqYK
 pFmwrezJJkHNHCNN5wJBgjpxbkEbr1260mLaNbOgGhQg0m3BBbdqeTDTFIdNLCQzMEVjyOyGzs1
 pp0G81Xr9YqY0AYeGxmepBNLOBoHJKkVlksdyEXOJgtAHGggDsdBEINYx6SMs0QQBxHUT1HEKU2
 5lpjBo4jmgokkJNvnRIbZjK4OV8AOs/6a2C4FmM4xnrHD5u03yeG7HNsHvn8qdkFuhAjxqo1jzb
 M9Qsn+PU1VJIfWwbfZeRBhEfQZy9uvA7fNGjK13um3EZMknmIS72Q2umFCYLNXxA1pMMq6FBdm7
 SqGrNVoYHx7erfgHvlAuQswU/xFTl7WyxF65nseCc4AdEzcHOoQI=
X-Received: by 2002:a05:622a:15ce:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-529d6ff38edmr6319391cf.28.1785215023725; 
 Mon, 27 Jul 2026 22:03:43 -0700 (PDT)
X-Received: by 2002:a05:622a:15ce:b0:51c:1132:c80d with SMTP id
 d75a77b69052e-529d6ff38edmr6319181cf.28.1785215023345; 
 Mon, 27 Jul 2026 22:03:43 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44afaecsm52120415e9.2.2026.07.27.22.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 22:03:42 -0700 (PDT)
Message-ID: <923cbdcd-a603-4be7-822b-f0d99e000c6c@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 07:03:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 029/103] tests/tcg/meson.build: check host cross cc is
 working
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Brian Cain
 <brian.cain@oss.qualcomm.com>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
 <20260728044248.137626-30-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260728044248.137626-30-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fbidDUQF c=1 sm=1 tr=0 ts=6a683830 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX1mOzthAfiq7S
 X0fV0CPGFvr403WCpyvmjd39JILgUnUU2kMJurq2t58Vp2PDIAzc+4oNAF1jyuBU4CxnZk0q7pY
 LcVjoB5ab031Zdd9WLltC9cSbga6368=
X-Proofpoint-ORIG-GUID: Sc6_SOcTNORcDcT5WhL5jSD3kuEBcAIg
X-Proofpoint-GUID: Sc6_SOcTNORcDcT5WhL5jSD3kuEBcAIg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MyBTYWx0ZWRfX1qOkSnerqIlc
 kx2U1Bw/cFe2x0/Pb4dvplcjcwJjwil+eXrtQm6JpiJNh2u3hlLIEbOTR/jBObl9xuNose/R9Q1
 U5ZwVeMJr9eRPcamHyFNda6+gfoKWFOg4NAxLLXfrrlDBX8zWIlJH8yWAHAE8prb3p6TnCsOLW2
 3AKsBdPB3829ATBpi4Uz53AuM6Il3uUeg+RNqL8oBRNwAVzYyA5luRG9ukXFB3/6r2zUYOtvxaX
 y5FpYqFmV1Vh6xCkFEs9wkl0XvJSO3t4vGmbwmus6k3ShBLlHuaUK0k/qDVSPDSNShKzdXlcHqP
 XghxxXqtQAj4WnN2iZVq9iywkm6CmofN8HTaBwbLeRGR1AoNxZh0N+PMyIgBiu67x7yG9utme69
 bUuOL/y8CQYEQmxabakR1RF+2psOyzC68XzDltI+JMFjZB1QASxYIqbjPe/2YqcuyPkKAG8hMaT
 flLjkiz9yNILx69Pg2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280043
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 28/7/26 06:41, Pierrick Bouvier wrote:
> On Fedora, cross compilers are provided without runtime or header files.
> Thus, even if program is present, it can't be used to compile files
> directly. Check this, and fallback on docker if not working.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 12 ++++++++++++
>   tests/tcg/test_cc.c   |  9 +++++++++
>   2 files changed, 21 insertions(+)
>   create mode 100644 tests/tcg/test_cc.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

