Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21CBC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5RL-0005LX-Ly; Thu, 20 Aug 2026 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx5RK-0005LI-63
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:16:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx5RI-0004AT-A6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:16:25 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KG6vlf3503911
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:16:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 K54tQbk6atBOIof5Iga216fSQbpjuLP1Z7iQRUREEU0=; b=kmYb5tOm14T38Rgv
 7FHCs0QGegbnk8GBuIGZoStWkmM5GfL420SonUQicPv3zCmf0CoBY+y6oNQuVAxh
 Sfr1dtisoVF0cOGlpvQvU+5ySQ3Q6qnIVQG/knA0T9B24quWd9yv/s9Il7x/+mUE
 R43CVMPew0kEuKX/2cAjkM46VyOeEA5/2BBU9+osVg3xGLvpAgyzCjlHj/rzNpzy
 FIlWn3GXJI24xzMBkE/GL7tBZfoweOemPDfksEU08JnSZl9YZGIAvv5SKN8V34QV
 iujaCvVF9lbMzAatXwtgFa7fZqBBvLFb3ZqV/ht7E3UT3mdrkrLWa2EundICdpLv
 1FHIdg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xbv9uu3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 16:16:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so4562443a91.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787242580; x=1787847380; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K54tQbk6atBOIof5Iga216fSQbpjuLP1Z7iQRUREEU0=;
 b=ivmDQGU7O4wHq16DAu7LYXyTjDQGazsmnsWv5c5fyCuZWerwe032ojZlFpKT1skuEM
 tvswps4HVAa7b0UFRTMIxdDI0OQ8NHsamQ/S2ecf2OM/plUJF4GLovxQs8rhV1qwZy0f
 QPTSDi/jQHEygRfRtJamNXoGPIlum9FtFsuRDOKiCX2tDwdN7sJtGKddKTeFXGyE06i6
 ZNKdjZufvlnGjyiSzvGNpNRD7fO9HSCBL2TF15TsO1t9GLpQ6bENeAQ/zTnZqD1ZW8Sb
 7q9kK5C0VI+JrxOTaauAtBsIcqFb/fTMxEXQGnI7L0ib0Co+JcjFgvmjeKKKUS3Hpruo
 agpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787242580; x=1787847380;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K54tQbk6atBOIof5Iga216fSQbpjuLP1Z7iQRUREEU0=;
 b=Fwk6o9lkQlbcvEp7dsjKNN7mpYWqQjU6VbRJy8HtHQx9w5M4DRl5/nyCKKCOr1xC+W
 OIuZxulC9g5aiAY2zdqKrZuzAiMmaYgGGAIanOuxvey0HeSFQKus9RAJte92LjK121/I
 eQ9A1lnAm5+kP7F4LPC6SO//V8b90phPFd5lWNiVs7AJTQ4We4YW4cuDEwKKOTFI6yth
 4ROxBx6r2RdJeloUMeqX6SLznMN6M6EagGxVdJybdFb3NOgaGO+gd47OzuT/ZfQ7NIHb
 ZeXo5T+vn1zVDZSbN/C7zaM9aW8QHK89tvT6c4YQbtYextLYDgQV2oF0RjjhRbNiFA+b
 z4yg==
X-Gm-Message-State: AFuF++mZxKrPwNfclM5IXXrKouVLS4p3GTQQkuOr5Uf95RbnjGGVxvyU
 M9ix/bQpUR2Bj2d0o30kiJKKgitWl97SMfmXtBqdJlLJgZ13eS/8Ng1McGjFiHmzLfGPYwNh7W0
 0L3eBD9C+RFoya3xymIJuCN7o8WpeZaBxFo6LinRd5n5qxEjr75Hk2HQoNw==
X-Gm-Gg: AR+sD12Uf4Hz5MoTxZ3+wniSC0AVhCGakMqWKZ4izNyaTaS2El9QeyZ6VkzLp4c9d9j
 vo33iqTltZR8wWLvP+CEvo9wXhnhm9w3HKflBtV2m7yHv3agdHUfKgTxwgIzzT2f12111IB3zU4
 dRIu02d0BJLJDKMQzeLJ9n1RtYQk6mfTPDeUlcIIKtocM1JQl2C+EnKwWKOBp1F+PohoFk36DVR
 hY0trr3XCNeOE6e19En9+k1g2/ByrTWXNRpHGqUESk4WjdlL5a33NqNDUGTUw/v5hXlVtBrAs4k
 StMsFmIia75UhJqFEizkonjc2V4vDsV1k8offDmTylltxna8rwgFUigvxzMX6UnOsl2Lir3EsnU
 ejXqLdl6oEoThiFzoAQvdORImwVmlJogj3xUQ3DT4yRcCQdFmjhHdyFXQGMKj8GK/mdsz
X-Received: by 2002:a17:90b:3b41:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-3958049908amr25116293a91.0.1787242580359; 
 Thu, 20 Aug 2026 09:16:20 -0700 (PDT)
X-Received: by 2002:a17:90b:3b41:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-3958049908amr25116166a91.0.1787242579813; 
 Thu, 20 Aug 2026 09:16:19 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327bef3993dsm16605714eec.5.2026.08.20.09.16.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:16:18 -0700 (PDT)
Message-ID: <397f9e15-8be5-4e7d-8f5d-0eb686283154@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:16:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 033/104] tests/tcg/Makefile: skip user/system tests if
 target Makefile is not present
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-34-pierrick.bouvier@oss.qualcomm.com>
 <87y0e2p4hy.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87y0e2p4hy.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AMKAkK6n c=1 sm=1 tr=0 ts=6a872855 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=I01Nd7An3J9OhHWHF_EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEyMSBTYWx0ZWRfX8mdMrseDY/ul
 XPY9k2iq9+CHEGSdnjPtoqXPEajlS+qgn6gy73jzY/QM3XY11/AqB9OVc/pqufSEES+pjYqdh4/
 nR1mg4zf9ZjC/fK1m56ywqzXXHTcJ6dogAeubwmUCMC4D+fA9db2OTGVU5ZS3kPf20PkHGcQtFk
 dWorFd1ewJd7e1TX1oenAR2UgVIx0NIs0JxYHWbvs85H2e6o7HQzenkGYCwKQBfHtS26KTidkeR
 IjLjGTLcE5DyGxNlO2HcgMz7K7QeIApyv/tMwxza0lR9KOUrkWQ3B413eULl7W9YRIF/TgtGd3K
 RqEr7kH2Lo1DSG5oApx15SwqHMJu5Ya50LYQ7L1mzTfl+3idLKfX0Mv2b9qZzq7ha6ETrOiSUMK
 DNNYkjSPv3dHjXEotM33wVLvvYYbxI6VJXF1uqmH0rT7oqZYV+EhWTqJTaCa8s/mx4jIS+R8tmi
 cRECrKDNnfX36bhZjtQ==
X-Proofpoint-GUID: h_ABmJn9CJzHxZnS8n5UHJfS_hi93jqh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEyMSBTYWx0ZWRfX36AJCUJIgAiL
 O9e7UO0cR/aLss7dNzYbKRxpD8lDHFdScbcYn9rr4SzPwd2rqi30mvU5VsRoSYl34r+D+kG+sSf
 ximWzGIsxGiM/pQn4qtARh5qRkv+ElA=
X-Proofpoint-ORIG-GUID: h_ABmJn9CJzHxZnS8n5UHJfS_hi93jqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200121
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/19/2026 7:30 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> In the next commits, we'll port each architecture from Makefile to
>> meson, and it's easier to review those changes if we remove Makefiles
>> step by step.
>>
>> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> 
> Acked-by: Alex Bennée <alex.bennee@linaro.org>
> 

It seems like you are the official maintainer for
tests/tcg/Makefile.target, thus I'm not sure what is the Acked-by
semantic for a component you "own".

Do you expect another change to be able to send a reviewed-by?

Regards,
Pierrick

