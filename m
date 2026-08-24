Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D246AC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wycIL-000449-2k; Mon, 24 Aug 2026 17:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycIJ-00043c-61
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:33:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wycIH-0000Ei-Jl
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 17:33:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OJH3MF3320743
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WhPc3VkRhRzyZ0MLYLTycQp/V7Wwg4XGSmMUQ3ehIE4=; b=o96MYyW9RGk6fZcB
 ZrFprSIICBPLQUXlwdoy/SRYMoBNTOOzfXvR64yTqesO0z39Js/YlfLXJya0ldp8
 VhN1rbd4Z6NAM+Q2PDO4Ll4XxJ1VUji1XNRldmnGdNu+Z0M57ie8EWklVQtf1Lqi
 S3dgvvV4s5/HjBPiV8VIcfYFJNhd0mw4Svcfep5ToWEoc9I0WmTN6s1Tqd+gROyW
 icDIiba9SVvET9IAvegD67XmfIc79qH4Yw2+jMWulH3BqEioF8ePLiy5JMGqRB98
 05f4zVPZ/qDcuKs4HgCycDzzXGt+iD3NzTfMG58j+kANKSeuA0L8beuvSYQhjtwD
 3/yH1w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8kdsjy98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 21:33:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso42163661cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787607203; x=1788212003; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WhPc3VkRhRzyZ0MLYLTycQp/V7Wwg4XGSmMUQ3ehIE4=;
 b=bHxu8cBOluXCywPKEz1rKONTktKNehQS6ZLt42UPpjSEAapZaGj7AWzM0wLoVQwHKJ
 Mmd2K2BSP2FtfaxLAdqwXIqGSa2IYo7/6LlMF3dejpJhmE8EajHE9dy70CC7NIb+97qT
 XIag3O10T0MyRybnWsh9cGyr4bU6k0YuU8wAgZCXY7sWkrXpFrKzSaWIdDhHxz4sRNqw
 DqjAFhWRj2crZ/EoEdg0BBgWvmvj6Con6IBcbXJhjRJAj3/oPR2IY52mDAey3BN7IOsG
 BbXLogI24I7yQz8RHRW4IKZN7KmBMftGzk9zjDHcn0RKVyg5KdKvV04Vq9hwxxZSXrOM
 gCjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787607203; x=1788212003;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WhPc3VkRhRzyZ0MLYLTycQp/V7Wwg4XGSmMUQ3ehIE4=;
 b=Kgu4cvQYdivBFxHc7ZN1NpboNZEBAADJV4nlNFukW6wI6/F7PEnsvZsNVzQamsC7UI
 wl85wXEEd/29w75xjH0YExX6kmWjedbrauqpe9zfBzilo/4QaDu+mqfELBdg2dIrdpG3
 FMudL7cUB7aogx0rPrYhg1MaOU6DcFnCvpZH47kFAiZrpRd/XaRjb6MABVtKGYvpYOYl
 p6a4fMIf9/bSyMFxbjHhLk+Eyz+tEBpZDf+Xoc3wJUbePi0Epd8gzCjUoKkOZA5NBGnb
 7mZsBxwhu5xrOGYqiDKQho+Z9g/gLpjMJH47JTRNTaxk7XjrT+Tiv3c7CHogJ4ofHH/W
 Vd1w==
X-Gm-Message-State: AFuF++nNoCB02TyCtRvvk1WYQnuQx1wk3I5eIn1GA09JW7AeWCIlBuKN
 Q+jC6wzp56JbCNG9s0V0Bxnpr7AIBEJPhA4CfYKl7jSg7DbTWfEnYrhcoMIEEvgfQqa2oMb5Wqs
 fEVXRCNEuTFsrSMSxwdnfMWQo7lXjE3PLr+eZNxhe+yoQXTAUaKgv1pijD6fjvghC89d6
X-Gm-Gg: AR+sD10xqUMoXXjkxgz7NqXwNxyN5Dr0MrUuekaM+4nhzpeayqhyYBGJcCPee9pQ2ea
 jIVzE8m0JQvSpQOIGfc8pPkpTvplbZnGnenTXe9LdGIN2d4CKHugovoGbm2CA3MQd2YH7Sy5gHD
 3MH78jQNm8lBzn7rK/mEY15YkDnZMhHpl040F3uqfhtpK+wqs9esr+J5QUhWfs5WTfVMEvf8Z8y
 ZKd+STykdSxUlm/IhPjim7COCDBAA9L7+UjKO9lWNEztCUk0S3lYFWn6MR/v20GZyLGZskqgECW
 EIRK1WZluk52CMhuZ62cGuap/iR9KIuYiBqJ3f3fBf2tN12Y6ZCynM+XWq5mUdMoMB2RckmGSEM
 eQB/ZJoAiqMLP5QkhxLyDofMVoAYl0dnI02uGD40ZsoeVy9Cy9Oc=
X-Received: by 2002:a05:622a:244a:b0:52e:2e04:44f2 with SMTP id
 d75a77b69052e-52e2e04477cmr44280051cf.20.1787607202804; 
 Mon, 24 Aug 2026 14:33:22 -0700 (PDT)
X-Received: by 2002:a05:622a:244a:b0:52e:2e04:44f2 with SMTP id
 d75a77b69052e-52e2e04477cmr44279461cf.20.1787607202271; 
 Mon, 24 Aug 2026 14:33:22 -0700 (PDT)
Received: from [192.168.20.232] (82-66-243-121.subs.proxad.net.
 [82.66.243.121]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69a6esm9292305f8f.5.2026.08.24.14.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 14:33:21 -0700 (PDT)
Message-ID: <e5a133f4-6c7a-4db0-8cab-090e112a5940@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 23:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] disas: Replace straggling CS_ARCH_SYSZ
Content-Language: en-US
To: Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260824143033.306201-1-farman@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824143033.306201-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX2EjPMKZxmq6J
 pePDGhqRML+DwIAhl51l/jG7iDV58/hVo82AynhgsrtTCDnZuRZD3kmcYQMUtatxXKM7r0+LdNF
 F3BtW7PUdfcu3oYZWGHf36Rp9NKJtKk=
X-Proofpoint-ORIG-GUID: UNG4bhjHlAcuuUuorDUgTtPsm_a_N7Q0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDE4MiBTYWx0ZWRfX1As5oQQlISa5
 fjVV8rule4WZv+Hv/tA44ZhyHTgEEmYFsQIr5EavlE86A4epXRPwDnNS3fVZAw/I7pTw0bT6xvk
 RoD0fSuPK+y3J2/jexjeyxL0OWrtU+wv+nbYinY9rPeXnmHcYyq3XTdOrG7WSPwUL3cBQq5FBqQ
 rRcnL28xZHI36DUTTJO5xvfUw3M3Y/u/0aqRogePSPG4f3M8sl/G/hlqBC+ONF4j9hhzcrM9ggc
 q8/RNeNP+oZwNaEwTYjk1i5uEICcR9BE/0FZ7PLw+yDwmlINqIs8tL8FZCSzX2fjxdWVkKsMlnC
 FHGqHdOOLY7AfFnxvIS6yRl2++ZnqgWIMsYbFBOunViTypac7ImaBnwMaAo30SgR3uzFbohsVhY
 G5yau5zJZuZGidlN/OAx4VbXtHml3NukDFiLbIkol90yqYPjqdDDk2ciNlIf9uKJRGbHRQhpv23
 PRa2TXdPxFs+zdo2A/w==
X-Proofpoint-GUID: UNG4bhjHlAcuuUuorDUgTtPsm_a_N7Q0
X-Authority-Analysis: v=2.4 cv=d8DFDxjE c=1 sm=1 tr=0 ts=6a8cb8a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=lbskcjEx90pOFJH4cTSgiA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=-DuG6ggHnZLhH3crdFAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_06,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240182
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

On 24/8/26 16:30, Eric Farman wrote:
> When updating to capstone v6, the define CS_ARCH_SYSZ was replaced
> with CS_ARCH_SYSTEMZ, except here. On systems without capstone-devel
> installed, this causes a compile error:
> 
>    ../disas/disas-host.c: In function ‘initialize_debug_host’:
>    ../disas/disas-host.c:78:24: error: ‘CS_ARCH_SYSZ’ undeclared (first use in this function); did you mean ‘CS_ARCH_SH’?
>       78 |     s->info.cap_arch = CS_ARCH_SYSZ;
>          |                        ^~~~~~~~~~~~
>          |                        CS_ARCH_SH
>    ../disas/disas-host.c:78:24: note: each undeclared identifier is reported only once for each function it appears in
> 
> Rather than making capstone required, replace the constant
> with the same one used elsewhere after that change.
> 
> Fixes: c8220a096f ("target/s390x: Update capstone disassembly to v6")
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   disas/disas-host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

