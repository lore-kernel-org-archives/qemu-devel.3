Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A08C54F4C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 07:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wocRN-0001mq-C5; Tue, 28 Jul 2026 03:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocRL-0001mS-7t
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:41:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wocRJ-0001Lv-Et
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 03:41:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aX661714737
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 giPBnEI96T4bwZjk6T3xAP764Ot/xwEzjoOzvxVGNjk=; b=VhCyu08F0njw8P2x
 VPIwpKez+Fy9+0uifvtXr/xFgld0CjJT/1m+LIVwU+jfwClAoW9GFOuG9OrBWDwU
 NfoiqItmT54j0KLSniqpZYzm70wTuxvC/ukFE7Z5vTcnTwV7Ae6LZAs6En1v+6b1
 Zx0cHYHqe3MNiAfk8yeeIIVzg3+OSR2wJxj+DaKz5ky/KYDMBcFLIyOi6QqeASMJ
 DymKxhYRZTFbhP4EqOkyN1Y/ButFrNeYE7lGY3GmN2ykLzgBjPF6unoYgSnEwbmI
 ySAGifiQ9LjLzjafzXDZTvodfw3w4YhIfnxFvJ6R1rUquTGhuktxbgIkVi/3BEbo
 rCm0WA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkkkn7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 07:41:22 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-522de3c645dso12139881cf.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 00:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785224481; x=1785829281; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=giPBnEI96T4bwZjk6T3xAP764Ot/xwEzjoOzvxVGNjk=;
 b=kNL18Zpz8292mh4btE7gL16rhN+1uXY0RhUu8nLoAcdsKJuFLGR7A9e5txyfht/f1I
 rv2x10irV6MSVqjj/Xu8sQddrG8VJOCb5V5kRi/BQl+CQ7J0Sy9WBvgAXpym0wYmcw2q
 6kCTzgCPBrZAwbB1ZrG7/yp2WnUpb7+xzRjH8Vw6WA+CcM2mtD5eUh9Iqvj1RQTFJQJE
 RC3ECDRCkEEbip9JoTyXH677Xb9fluqQBG/9Eay3UOebhCXM8ewF7hlh6YOu4JZQQoxa
 w+lHLD2z/afACW5qHLbmO92nJmJySTuKRMKA01J/4mjh8g0z/rkJ/81yPNEkqLkkje8C
 p3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785224481; x=1785829281;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=giPBnEI96T4bwZjk6T3xAP764Ot/xwEzjoOzvxVGNjk=;
 b=GWm4A+zkTPZ8KU8nzoqXJmoSf8pdZN0OMOCITYIzWD0OS8MnkSs3mWUBnWy6s0mu+A
 1z+B/4ARA2IcI8LOkE+v/Ioi9mFRrXM0VGEA4MUcHBLkQ2qmSyLw2yZWuD/DYj4n+2Es
 +PvofQFvkGgnc5GuzHAC8AF3EZGykBk+vbURdkc0eOjNWQ/saIM4MZ+3IGJT2QMbU0Li
 qEJXKcbzfqe2tsfDFJYL6GmhQStK49CbvzHXvg354bV7P9VF1/LvdgaSd9LNGZoXqktC
 Nmbh7W0WYII+oHAxsB08riJSFVSQsKOEXt0xjT5a7NMtpZEnu9cCm7fBr3Ows/hXmzhT
 W6Ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RouFMcsGya8RKw5qQY7uV+5Sbze44+0SkkunnSpQyZ9sM7UEtR2X0odeh9sAelrx5jMp8cXM3gTyaiy@nongnu.org
X-Gm-Message-State: AOJu0YwZVIXAUNDI2zsBwoVPWifFSnoPXw2LdcPz5aIaBOWQ0om9SjOT
 siS+p4Mu+2SyrPDob9oYihMsFG0LHTXa5xmqPs7rZElr0nBrO+dxxVaQktrE7EVv8Bm3zyDN8Sw
 vtBMpgveAYJr02DdAIlyOntvq39NEXsNwQWKnw5wKR43BtqiTQW96GpHDkQ==
X-Gm-Gg: AR+sD11pyuHsiSxM1c91USovt2Zq0IkUYKIlVzFW5jkjmMdEfamPGHNK5saqPcF/0PM
 D6QuwpqrvyP3wZFrxNKqY01DRBUKNaENSPzt0pc0H0/BfRD2a37DNQYhE/5tK8M0dcQzu4ZR/nN
 nYlN/htphtQrxso5pv3HvsCOn5zcV0V9cfSTnTItu8wHQ/nJu7UNjpMxRuqwQnUYz1g3TkPKoKU
 ItRDCU5pto3LcxJpLN8iju2gAXAtYNkGSyqJtH+FH2jcngSXXr/5gpTvSuSfPFqmGDgLlSYepIl
 r+zZ/aNquexSH/A0einXNnHcTUVEQKcO9fBv3RVVLSH6D49fBHuof3qaKRay7llKkbs3ExXFCi+
 BY25DM4CRfDwcsmLxXGHQQheOkQQfH28DMoasuZbc3ah/otMg8wk=
X-Received: by 2002:a05:622a:1107:b0:528:2473:a8f5 with SMTP id
 d75a77b69052e-529d6fe1cc9mr10352561cf.26.1785224481626; 
 Tue, 28 Jul 2026 00:41:21 -0700 (PDT)
X-Received: by 2002:a05:622a:1107:b0:528:2473:a8f5 with SMTP id
 d75a77b69052e-529d6fe1cc9mr10352291cf.26.1785224481237; 
 Tue, 28 Jul 2026 00:41:21 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4625161sm53381045e9.14.2026.07.28.00.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2026 00:41:20 -0700 (PDT)
Message-ID: <a3f1ed53-435e-4dde-93db-f526459d83e5@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 09:41:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 000/103] tests/tcg: run tests with meson
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
 <02bde797-6c3c-4c3f-aa82-121e20360866@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <02bde797-6c3c-4c3f-aa82-121e20360866@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: LjVBiK0odJSQJoORxWvFC0AB1qHdb4Tl
X-Proofpoint-GUID: LjVBiK0odJSQJoORxWvFC0AB1qHdb4Tl
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a685d22 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=MClhaetC8WwY12CTWZ8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA2NSBTYWx0ZWRfX7cNmKpmMHglr
 QGsXZ3uk65GadroOWVjfx9sAobccfnvDxxUI/rdoaFWaE7XO81mgBBV3YLOcpYro9wwIDiwZMCZ
 7CLzISYFLLhcVegg7UYH3FgdcOSgZ3DuZtoOXGJUxziRdWoJdA9b2LipIsJplOFHghzknhG5hxT
 OeaYpqPfb9oADs+P/gG5lyp2q4NxPkxTRBDNNEkfjeAduZdGmpfOonxZE445YQg5mZsDysXcvPA
 zrNtMxcj61mHjsAjDS8ST9lhWk8pvJQmXTYLfOeBplV873PbOECV+WiZyNqz03PVz6ftO/bLsUY
 kT02nBKldkmNsyS0G4S535oSlGFn15dPj33A/KNzsELW+hBnqfWIYU96aMFjvIcQhC1W5IOIRg7
 x1i0UgDC2oowvW4auV6OHzju+sxIfId9l+C3kYIbRpaoHzPOKRnl2tZXyZgVcuA0KaheskV7vMm
 Wm/PVFx7ZDqnmmwUZpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA2NSBTYWx0ZWRfX1Ob2exV7vILl
 XAESlnn4Xa5r9UE9y5DxigPjeQu4i/p0yAHosR6/0oKmLJIh983YgFHSoKFFCUMEBiiO1joGO8j
 LPU4+n48RQGMUwxt71buXr0n6lL9saE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280065
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

On 28/7/26 06:58, Pierrick Bouvier wrote:
> On 7/27/2026 9:41 PM, Pierrick Bouvier wrote:
>> This series replaces TCG tests makefiles with meson, with the
>> goal of having something more readable and maintainable in the long term.
>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>> them with meson directly.
>>
> 
> General patches still needing for review:
> - 4
> - 29
> - 96-103 (new patches for configure + makefile removal)
> 
> Also, most of arch files still need review. If you maintain one of these
> archs, you can take a look as the series is now almost ready and there
> should not be any significant syntax changes, so it's safe to spend your
> time on it.

IIUC we don't want to partially apply this series. What is the plan
if archs are left unreviewed?

