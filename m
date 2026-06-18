Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBD6CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJIA-0000Ka-JE; Thu, 18 Jun 2026 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJI9-0000K8-Ia
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:24:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJI8-0001Z1-8W
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:24:49 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IHt90t2548251
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:24:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c3sOatQZ96NQIOVh3/Ouow524MyDDJyiqQDkQOdqTGw=; b=Sxb2V4tgx5EYE3cF
 T9FATVQYLt9sxbXCvoIUqHEx4JxTUSTsteJbHjhOSybY/OuDMe9z884Oh68n4fjR
 C790e6i0BJXW1ZsdfgnrHY+tAk4Vj9IEcF+Zr8cxBJLJAK6hbfJlv6XczVTdOCDH
 Gjqw2hQlpyCv3G990ttmLBdM1kbDwaWnNvar5bILjKcsUQF2Ca+1/4+si+zCpdYo
 Ej2a+rptvLIW9NL3cN2v5u2Ca0ULMjhN5n/ZwdBEv8YAc4sTo9z1GPTfAgqV56bO
 SW5imXXQChGwZzzlKtsmNFWhWpqt5Z6ni8dMHsXEjJqwnfIkCQXfh7AjE3U+lnAH
 ymdmZA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtj8v7y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:24:47 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6c4335eef08so1478873137.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781814286; x=1782419086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c3sOatQZ96NQIOVh3/Ouow524MyDDJyiqQDkQOdqTGw=;
 b=KZcRIqL7OI0qPlglEl8qlFfbHjkGBuntbzECXH5rxUU8sahv6eDs1Bk/jHhi9xFGTi
 MR6gbwJ4Mg8es6LAn8DsMet3LW6VnumgEe3NTYNTylj6b/jNYMrNqw3wL38VlH2mTC6M
 BHLJN3Cq6a31jUXeIjF66lbOaAexIOHf+TPMIbkG4j41MGZU5XL3SarUlUvEEX8mq3Oo
 3cyc7j3hJDxJG/kqjM1b87gdx/2mCPdcyuBDV1M6oYFh3saTfOrNaHP/e3aYEPl4QJko
 /JIvXKk8bERqSpruoq3rjBe6i0pZivBPGJYhlySZ6hScGnA8ZAG1yWcDMfHv4DFGW6oC
 Bdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781814286; x=1782419086;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c3sOatQZ96NQIOVh3/Ouow524MyDDJyiqQDkQOdqTGw=;
 b=mcnwlY2VBPqyT42EnjANRzYZkAEIubFmMVc51jQ0A6NRHouWf7Z1XdjpldSfvJieDR
 OHunKJCzCeFaHkQLMPqmDjQEs1KddibyaG2Lmv0x5kobJxkhlG67uiBpONyuGi4WhewQ
 W2QRJxdlRYgT9o2B2X8YtRzKuPahqOK72UDZgBTGVibMXbD/O4TOuhbXdaIrXQ4/EabZ
 z0XA/S7TWOP0dSWeBvSFKPlsMj3Cmw8DDz13FiUsIfCrnjgfEcp1xVPG4sdnte+6iNlg
 P6ze8iTQHNM3PFy07LruV5F+1nWOqC8eWyUC/HLAH4CFxJXUC3gEoYFThiDnCGCrb6Gb
 pBwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ98ivVhk7SRF2b9u83ruJTNGUKCY1uhXgXk5YbeHKBH1dVWV0OJifV808W39M8aKxEtWJ1AG4EUiRzk@nongnu.org
X-Gm-Message-State: AOJu0YwTDTLIcobdURMj2CVFL9/nlO90wEhgRBS7WZw1OeSuxLlwuRG2
 cOuDk3HC9+e7ZwY/Y2jLBFEX6S/qHYMJrsjXnVegp27oZS4+shfHMJRw4cr35uq7OwbngYnG+i8
 N0blEOzD8emg3pn09+6gTHkts4ypIbzl4E7Bvj4xugwih3GT/X16NgoXUZU34/9muTQ==
X-Gm-Gg: AfdE7cmBW2at0MXGpiZtvmYMVawjIaslsTOYpnKsf5E8fKuG4856eWVAEpGuhWKzztM
 uqv6uNnSYoM/BP9+aZ1ne2CXRpKegsmeh5SFneFSBhikv544YZDvJFovOcEbzsNhNbBmsO/Hr8E
 QRMF5SRRoPOriaGmKz+Ym0OUZ3L79o1uqt3hukwNY1Q6O0DhqGV24VdjbY9NaLW741ZxpgzuUhV
 ZMYnwixC8KPf1Fd2IfRT8EB3pmjP7W2g+rDQGwhadyGsgqwid1IZJla6lxUy/thSE4GIJTJqraQ
 HI706TCpaevoCC2FSG30ATdXlsdGTOObclYs4TtZno2erdGna0Y43HBMrJPW3kt8tq+FPpa8ErF
 OAyuW5rp/he1pyOaxX85G2xAPfMHDCAnafPzZ3bV30s2kFSz2PqhqC8o27zkD5A==
X-Received: by 2002:a05:6102:e0e:b0:720:7dd1:5c8c with SMTP id
 ada2fe7eead31-72a1d205a20mr612546137.6.1781814286506; 
 Thu, 18 Jun 2026 13:24:46 -0700 (PDT)
X-Received: by 2002:a05:6102:e0e:b0:720:7dd1:5c8c with SMTP id
 ada2fe7eead31-72a1d205a20mr612537137.6.1781814286021; 
 Thu, 18 Jun 2026 13:24:46 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650bc429a1sm1472967f8f.30.2026.06.18.13.24.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 13:24:45 -0700 (PDT)
Message-ID: <0d4023d1-461c-4102-866e-cd825b5a53c9@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:24:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/13] common-user: Implement read_self_maps for FreeBSD
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260618195829.590072-1-richard.henderson@linaro.org>
 <20260618195829.590072-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618195829.590072-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NyBTYWx0ZWRfX5hZoT59ThJVc
 GhT0Xnrk2UYDXUXMBsChbKgd7yKeMzQcSOndcnKnlIIWRj8voJRMVf7BPAN/k/9aakZ0Cby1zCG
 lIdLRngAfmpwwaNgHizwWQPdFgIPSEc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NyBTYWx0ZWRfX2j2vvfOXs4Nb
 edfrQBFlgdOH6i1I4f4Ns/kUDB7JZ0Gz/fFI7REMGuRULn5fHGuK+PNZj4Af/wfyQPSKwaJlsz6
 uuFgwKVbsOblDJ5AW5y9ZdGmKHQuUXMM9WVbsNMcdJkautSNWN51Ss5KyIlKjJrgC1PcdqNReJz
 ogXJvTZrbCq2/ISZKYUygAfkHA364+Kf1u70uB7Q8LoGK9R85z5UhDuRAj9jZ2R65g+y7rL6EQ3
 AlL/MuCeslvRQYv4vkQ9g/LJTsToAQWmp6zbnDhyVaqGLhb18WeHXfpUl3Eooe+852PxCO1YET+
 I3IyTMJBhGp8DzGq7kOMSU5SUmOoA0PpNIBAmCjZLXvBZaeHzLgao1nvZmlNYzYaISpuno78KOP
 dHt7n8wMbLHqa0s3WfjHuxcNZ/FVqNdZXPkI4l+lTIVcbT623NDGWtBjLcb3PCMGrP+bFk6C2lO
 y366RlUHE8QSiCgjsSA==
X-Proofpoint-GUID: GzLx4_KXSAU0BFV6iqtHxiASAhou_yJB
X-Proofpoint-ORIG-GUID: GzLx4_KXSAU0BFV6iqtHxiASAhou_yJB
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a34540f cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180187
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

On 18/6/26 21:58, Richard Henderson wrote:
> Use sysctl to fetch the vm map of the current process.
> 

Co-developed with Warner?

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   common-user/selfmap.c | 45 ++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 44 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


