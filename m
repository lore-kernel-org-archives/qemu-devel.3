Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE26C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9xQ-0007Aj-DE; Tue, 07 Jul 2026 13:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh9wX-00066J-56
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh9wV-0001Oh-1g
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTE7W4074162
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 17:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bb9Z49V+jkz/7dR7WxoOWLlWcXtrYUKSs7T5rpgriDM=; b=Uzdkao7bjs1Odz2v
 T0T4L8ep4oUHr0kN8AVmBPnnfBQ7cUgZxmdljFoJtDACYKLOs0NP9TEtSHm8zHOK
 9PmOVZU62PaXQP9uxgRodhei/5/MXXN0nir0nbd/2Ai/1pxKgwcSpFc0W4fKdI15
 uIN6jQfqfUJ1C42ATrH+C54YrbYIckBKEgmDLav3SHSz+UlZE9zsZ+RA/6F+35Ib
 lkRd3CJ3okYKTzqtdE64vknmsCh462G1KyuHr564d6tjZk82dUkvR1BYDXm3wXmo
 ZTCFmh5q78zeVRXdOVyMvV8FlQLyz3eniKiec6T0MijILrhOAnOzk2R4cFNNATlI
 lqd30Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun2n34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 17:50:44 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-37e5ef8299fso4702235a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783446644; x=1784051444; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bb9Z49V+jkz/7dR7WxoOWLlWcXtrYUKSs7T5rpgriDM=;
 b=juG2qtAE8XPgVUy0fHup3WNuCaAPPBLZvw0fuSPFpeApjbd+KAaAU9d35Jsg8zwRbI
 u/TZZCKPI17BiWA07jRQQj5pktDatAkDwz/hhAJQncGPpX+k2tezH/tiTttAv1hiQp/x
 YcEdnauUS3gYMvRlnRP/5eRlInySllxZCwL9Z7Mdf5pwJZwdjABHiSyRaPQncRdHwIQb
 4GCqNRemsy8G6r+51Nbmj8/zXMg4mPuTRbgQQXgRZTJ/BHhefH8EQXGsNKR3bOG3r/yB
 fm89n20h8pO3/30J5t2IGf+5/bnQ77Able2wZqDGApSYQexA1i2hVNnXMXJjNYx5yBC4
 eY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783446644; x=1784051444;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bb9Z49V+jkz/7dR7WxoOWLlWcXtrYUKSs7T5rpgriDM=;
 b=DraHqivDyzvx31j2oE64KxO7Y/kZr8WK29+4YZ8o25OP/k+KrgPsq91k++ZD6aKsZi
 hL420q86KgSUt5/CLi9iIoopZBbUG/QGEa6pplK9Q6Xht/5UbbYMImMbtK/atCVyG/WD
 WkmXJBdE56jObYLdONKQL999EwKrCysBaB6gSAxlGU9FZA0Un1ZN8YwNTGn7U0J+3OsM
 ACdVViv1yotAzT/gEOqt9leDuww0nTr1fQX9N/E4CM/j9UlQ1ztHIoelIo1EuDICGZPM
 YOxYmwMtBJtDqPzawVMSAdapCGQ/NFXTy3ZjUxFLAwOWkfg2ou5IpHhfUy7T3rMErKOI
 YMnA==
X-Gm-Message-State: AOJu0Yw2kBhbjlneslRiNjwYJMfI2hTNgXW27DdDThLR4K7CPBkTdqEU
 iGC6fMtxur8tFdfL4NSIbRwk3HimZwS7Dayr1XzOJFaq6n72zsU42NmcLtuNRgYGaIGqYKaopPA
 5baj+yQ+0nzIVfXo7spItWbzwnbMcOzPItjJoalbB+MMSLs5C08OHCerF6A==
X-Gm-Gg: AfdE7cnXA5hQWs5oVdOD1h4mjT838wf9pnMI88tGXd+8L+Rr9qAv8vvevWKRx4Aa9BB
 cLB1jHR7GJRNGc4Ns6TvXLU4NzKDGg8qlFl0ae6BMqSfD3iQYbwH2L5RbMZxmLmrM0+VAAVoHLU
 TnP1jT21wFa37fcexDA723YdBb+j4nKeZo4dfM2AfqBLlYrx5Xrw2XAcT/fW7fltaYNVHmUuDVg
 q2dqXvgsRst4v/QadCXiEZdtDfI1arn6LVfqIZAbsz1oImmz+C/bpZF3XRGD4Lp2gzddLSNd2Zz
 XOPCLTc5sxpkOJrUIW5c/blyNZFvEFvdJhsg5DHaVo+SJj9JV9TqmMiUhpBp0ARM8CFK1XTWszf
 mk5NADzUANYqjGFB4gdbpBk4OYO9wnnJnfYqAUFTdA9G/D1apcknWWX8PCZp2TjujokbpcF+Ev0
 VXbYs=
X-Received: by 2002:a17:90a:e703:b0:387:e0db:bc2f with SMTP id
 98e67ed59e1d1-387e0dbbd95mr3551578a91.37.1783446643820; 
 Tue, 07 Jul 2026 10:50:43 -0700 (PDT)
X-Received: by 2002:a17:90a:e703:b0:387:e0db:bc2f with SMTP id
 98e67ed59e1d1-387e0dbbd95mr3551558a91.37.1783446643223; 
 Tue, 07 Jul 2026 10:50:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accae5sm15456305eec.29.2026.07.07.10.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:50:42 -0700 (PDT)
Message-ID: <e1a99cca-579a-4407-a309-44be1a07a74b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:50:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Revert "tests/tcg: skip the vma-pthread test on CI"
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260706165445.57418-1-iii@linux.ibm.com>
 <20260706165445.57418-4-iii@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706165445.57418-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3NSBTYWx0ZWRfX7MNf6A3OIqt7
 NWHtV0864tMU5ZCz9owZFIanxL+y9J3BcMgqA+eKtlHap52Mgrb9vgLdu+SPKBGA/xJnhx9KxyX
 HbH4MvrcCQuAvaP6TBNjKg5z99ryQh4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3NSBTYWx0ZWRfX3vf6SvWv/3xU
 pycOL1KDzZkdQa44+HjaSpGG1jMosaYQKbnlLWr3qH+ih9XM4S2dndWWJMbViOULVNcDPXPFZXH
 Yu/SjDAHBi/7HsCMgjACe1HOFOVo5KP4laLefBpJrgFYpGQSO8OOa2WlovT4LfAOa81IOgmWtn0
 IkhPgQ/f1nnNrsyQ+mI13CJeMkpQBuGV15QW9wT03AQZjbXUvP7YmYsYRilZBZxUhr6QpeHJhIE
 ih7JzEKqH5GjzekwY7bn09UX7q+wllR3WAawZc0Vs3/cPZWqToz17znnxXyOxRyFfrEt6crQZxi
 BKXcLpJqg9Gf5381rV7BRhv3vG6JcmTfFqA1LvcjeiqPJNMcDKdINnncaY04ueiM+pc5HV2L3r/
 W8frf3Ikvvb46rxxLQkZ0o7TfN+MO6Kzgpfj/n8qHJEPePe/hhEgr/ez+I9rso6KBos17JJs+u0
 uKJ+d+F5rxeP2pcpYAg==
X-Proofpoint-GUID: qogIVoZx355fXCjNOQ0mK2_JlMdoptN-
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4d3c74 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=4K5PSgakuMuRw5cBoLQA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: qogIVoZx355fXCjNOQ0mK2_JlMdoptN-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070175
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

On 7/6/2026 9:51 AM, Ilya Leoshkevich wrote:
> Now that the page_check_range() race condition is fixed, let
> vma-pthread run on CI again.
> 
> This reverts commit 5842de51573fdbd7299ab4b33d64b7446cc07649.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tests/tcg/multiarch/Makefile.target | 9 ---------
>  1 file changed, 9 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

