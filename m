Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13757CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT1xY-0008Se-8j; Fri, 29 May 2026 14:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT1xV-0008SO-PW
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:29:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT1xU-0006qW-7d
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:29:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2O4K1912441
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 njIg5umJhE1zBoWifVLdaYyOhOBR3pp7Za+c7sWmla4=; b=MuEXMLqc3plATiLz
 TqgKs+y68dLL1sxQN86EqeN+Zy3HYMqrfZurmnrmsXb6HaXuI1YiGxqQaAkICRCk
 AfR5xOfAPNCzqzcG1Tq9n7/v5IPdfVYQuQd/lf53nZ5Lft1ym73EuJ7jYTmjUeTX
 Pu9bI700rRvFDtbpD4kkfD0xMaRPwr0vavhmz4nK3cEbEfrFUuIsrTu147KHgaKI
 qfM8BJjoikEpljpR8On4Jc6YWnVCrSsPN8Wewz3wyI2q2c6Ot78whbn+/Ol1NKiP
 Fi1pLgVYA9dNRRWiDVqtrNknCwNJwK/rZ6pMyQk55r9zrpvHiG3y+YgD6tgvUWqV
 WSK09A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efbu51pw0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:29:21 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304e7fbfaf5so4535130eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780079360; x=1780684160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=njIg5umJhE1zBoWifVLdaYyOhOBR3pp7Za+c7sWmla4=;
 b=eIKg9ewWI+VhIG7y7bEUBi7qBKv8xDTqG1u0vmPgxmAEx7kre+IiQ/iG5qoKlLSmwY
 Q4u9rW0Y0Q+k3sMctUGGkOUoxmYlnsf0MFYmmra+muG8vXg7N78T1za86Ef0xBrIf6Gd
 pe6JMihMti+t5FguGyKEl+9SMYGp8bKDi4jY4Aixi662cQVrnpbrqUUB1sonorjuvD2r
 REvYc6CtEZMLYKh0t9uTaZenQvPTAIf5tLDz5UkAs0HfVA4JbsTtbBWOMDhKagsnodbv
 Q35MMra0cbwh7XNLT6dFmum4DgOuFUkl5aPIwJz7xMp5+8vkS4UgUFvIJlKKFd0jCq7E
 0Y9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780079360; x=1780684160;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=njIg5umJhE1zBoWifVLdaYyOhOBR3pp7Za+c7sWmla4=;
 b=TL8/gWDtFeAXADpTr13NlWIR/j1wXpn6XAqoBt3Xpso7q8UY6QaDYm7C8e+s2UhNCM
 97URjeMJCXF1FUeYxAZmdkwleeeyizg4BcMFyJo1TpanpdIVMTJWRHSCCjHjyij5tA+8
 I6rF149eXWTB7TySMxBHi2wq2u2xNkISFhBlukal/dLiKgDk9wzjvy738C8NQyAPV5NU
 JBmwR/GE92PVGG/TbIpWKJ88vjOS5wE+QZab55b0lUZknZXwQrR29sadDxX7ID+iczq4
 75Pn2ZrqTAIuMkFCTbjLrVwzrk1yMF4NGkhg4hMzvvRNB0bORSp4FrzGypbuDYSExYLN
 X2Xg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4xH2uqtgo6bxdxdXv/U/v50PjE2gEUHhUkI2jftSx2iow7AmLPtvUhLtV3SL9jLtrteKyVHIgIN3C@nongnu.org
X-Gm-Message-State: AOJu0YwTG5olysziq+swJqLHyehF0gGWjGTWU5mMbpXNzSmqA9srQbqx
 P/GqQFnym86W8U0MgLVJcM8lcTd2TERBMc4oZtrqjYYVStM3Or+EGqopMo903faq9u/26TNnvPF
 A22YtdnUkW8FXzl3qjlxA4vkdYEoL1m402er5NdgnuRtj2HdlmoyMeOjnvA==
X-Gm-Gg: Acq92OEC4CZQE9JBWnX6XIRQRDiNerF5Bsc3KXYXcDxZ4aMTZFyesluXgKm0JfkvLc/
 x5pAFDBjHNp2APY2yZEibdjepygf3mEhXMsFzwZHsZnLfGQpVXFNLFI+rDVfpglU0jqPQnJEIuL
 uIobz0RLPSW3gkpkICR6DcDAm5dusxCBtP6t+ZNFw4LbAtqT2IPEFfWFmdP1KYOASqTel2dFddL
 5+gvI8GrSrin8dOW5c4fJ31vdSuPPNmcC0tlu+mHZqXwl+RETvA9nvneMH60ArZqT4/lbJdl+z/
 7S+q8CAVFQJKsBDylamnBUTUXbSA12Fh36PoLa32JyNydJ3s1aB30EH1mMZXImtwf7anhi9efii
 pVUasXFOr2THb1ErVSQ6wH4dcwuL2r2CxufZLlfQVSH4eaZd+iZMeqImePenG4GJNpDjx7l/Tcw
 UQ+jsZfcF7LHNHhZkLB0C7vkZn
X-Received: by 2002:a05:7301:129b:b0:304:e58b:cccb with SMTP id
 5a478bee46e88-304fa49e4c9mr520799eec.2.1780079360443; 
 Fri, 29 May 2026 11:29:20 -0700 (PDT)
X-Received: by 2002:a05:7301:129b:b0:304:e58b:cccb with SMTP id
 5a478bee46e88-304fa49e4c9mr520755eec.2.1780079359144; 
 Fri, 29 May 2026 11:29:19 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed53d06asm1928475eec.14.2026.05.29.11.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:29:18 -0700 (PDT)
Message-ID: <cce86e0b-c685-4f23-873c-ca5499d8e442@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:29:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configure: use debian-all-test-cross for mipsel tcg tests
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20260529181713.612230-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529181713.612230-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SMRykuvH c=1 sm=1 tr=0 ts=6a19db01 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=h0jhMV4BvdzU68O-UhgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Qi8Y-W3G8EHfIlD86aV0ikKz-lWuqtYq
X-Proofpoint-ORIG-GUID: Qi8Y-W3G8EHfIlD86aV0ikKz-lWuqtYq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NCBTYWx0ZWRfX3e8/dfgjOpFK
 3N28x0rT9Vt1nXGdXWyE+WVQcmVA33CSAHA/ike6RfthYy+hdXNI71JICX8GgrYPx2/c1t/s8BM
 +OCdaH2wYE5tDWRCyrRZNIntNJCRSqpAshoM/by9ua/2H//ATy7x26hLBR01Gki2M8xl/BSV823
 jYaBttXHILemWJGJUga8pUeZecUTNYLaCcMzB3B6Luyq5azPzeRJpmlObbrUbDfmCJq4sFdQXnp
 bRTQ7VqjxTyTfKML4arBe6QNVjExsSBG7z/6ylA9QrQrbQ9MKGqg++2Zb55LdQgMKsFkfQHlyZP
 Rl9kuCV2ZUSe/xbrI5uWZ4BtAV1S12GJ6iaqx+I8WqSHzmk4679+6jjDR35jqe5zYbV6bUxkXHZ
 XPPhDVBilvIMcZrt61F0hcbZGzZrIetFfLH0F0YZTT3papCZNmkmYp3c51CWB+u5hf+T0U/0qEt
 cbGFZ3k9hrk0TrF7Qiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290184
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/29/2026 11:17 AM, Alex Bennée wrote:
> Although we have had the mips compilers in all-test-cross for a while
> we had been surviving using the mipsel cross compiler image. However
> when that was removed we missed updating the container to use.
> 
> Fixes: 366bb88e785 (buildsys: Remove MIPS cross containers)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Isn't that tested in our CI?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

