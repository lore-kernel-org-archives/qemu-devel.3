Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FE8CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXZ6y-0005mn-QL; Thu, 11 Jun 2026 02:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZ6w-0005m8-4U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:41:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXZ6u-00049x-QO
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 02:41:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GVii3712178
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j6xoN9s2k2z6WBjErH2B5a4ve+qKzH72nuHagBkgw7o=; b=Xyr9xpaCmjKMKv1g
 XbgKl34KARoqGMIHM5Xl+Q8rYjdzHgw1ypsA/ZQ1H61HajOcIWUNUgw5zDtrSQT7
 twIuqElAbNwe3EI11j7MOZyEfQhZij5TZWb2YYFdYWUbVxwrEiXIPAc+nr0esuSd
 kKz8CYEkoOrVmQl9pPhA5YUUp73RkeZAgrlSvjk75zfX1hyHqWdcZFitBibtJwDy
 ernWVnug0jWLN0k0oWLtcShC18uNXcBTHPeCIfHMihEbrC63M8xIRpOWFL6ZC7Yg
 MfN5rlcwCaXYa0LoF02tXCU8e2FXXgh7l8ao5WgDbT0MaygpWlLXrWH3pVsR2cqt
 KNfIQQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ua0q9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 06:41:51 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517878a92c5so168995071cf.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 23:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781160110; x=1781764910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6xoN9s2k2z6WBjErH2B5a4ve+qKzH72nuHagBkgw7o=;
 b=jgJhyySJ56kS3xTuJk8pDLk2gXLM2+z2BnQfQeNaGIo2WStyp1IMYCFDbJKNhIrvsc
 WSTR55lNYlTOEU6OMuwdK/YHzXhhkji57oFemI1uOPl1I54JGbWGLvT9R/vepN+wLKWC
 ttFCcqk+ZxpV4Ji0kn6B/YEOMh92BwzLQwDeGxdhZSrrfrDpy3ggQPhAjeMaMSxssOLN
 fWtxergAr3ucXjENKaIOl01ZbmiDRcdnTkfnA2zml+NdRMfUUoUNH3oInp5XAOG+Rx0x
 Wvminj8+OFAkB2/lHjbJCQvRcBLBYVYn6SKabMuxqpDMRgewUalHo/7xxuVw6UAjQwrg
 ZPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781160110; x=1781764910;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j6xoN9s2k2z6WBjErH2B5a4ve+qKzH72nuHagBkgw7o=;
 b=FwvwKIuoypDRUw0t6FtJICfLIpdpkRHbLw35faqwL1JvcAuMmctLH/cean+xlX3FXr
 f6EonBm/O8CwKXum1hgm2BfWGlHPP+VZO6UGOA/vXiKLUodbmg8VL1lny4Us1l9vwGXi
 spaJVNryBjpamoUWUuhbn05smdSVXD0SZ2quXZQlq667iKklRNm1kxVksrM4cOSqX5n0
 umH8fSqKahpjKvEB4ffHZQ1IvhloZlD4UZzvyAxiSCjsVntMbG4/OLPQSqN9s4WcdWmW
 SesZROaowqwL/1oD/E+XgUVzApSv7xYzMJZXSH2d9J02aR1h2bP+XMD4wB4JEKjuU1Xo
 nbpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zbFL61aLJAZvOGQgmidf10/s6FZ3311S0lio68zvZ9zTqQHNDdBRhzX8aCrw8cxzom2VRoQyV63qm@nongnu.org
X-Gm-Message-State: AOJu0YxL02kA73XYXj2nBhgA45Ryf1isVmYtk1svDKU0gCqzGk74WMsy
 0TlNYZFDMsCLOkmuCHY/a85SF+ToXbCVbgAu27So99JHQPalpR7APYiGulMTcCsjnkCt0DmajYn
 zJ/AiqWYBYyH17x6sSekvaTN9DTzr8rz/fXlRbjLdhcLyPoBij3S//sozcw==
X-Gm-Gg: Acq92OH+cefTowygUFd/RZSqoiKr9nylmpj1JN4rWi1HzSwogupDUsOTYoG+9JVVRw6
 jTl3CTaVsuc1Zv+gXXXHCwiWKBw0IkDRQFr5PlFc2f27jDtXCN3lJoPCxkLv9Uqwp7KsCSth/6S
 cNfkNgc364OypXcY7/2Df7qdYjpdiHlOpYl3FOjvHB+43G1Y/bsY4LEE1uY5EgMdqmFneZFGJNF
 iE1alc0Eqo2waldhYwtihjC4qq2SPTM+cS2Opx36cdAx9DrbIrDk1tlBIdbG/ndJcDlng4cPnAw
 7uyB2eDeBg032PouOb6vCLAcPoDaYY+sS76NFc0l2ubZ3Fn8+CJhWZbTJyRzErGDuj+eDOzI5sx
 5H2wv/v1we2KwwpsXdcOh5yTt6XpGAH2HrIOmMnGcceb5CNVKc97E3RLkFZaahf55ezr43AbvMN
 gGdD2RJQ==
X-Received: by 2002:ac8:5915:0:b0:517:6d75:a2cf with SMTP id
 d75a77b69052e-517ee204de9mr24562541cf.43.1781160110643; 
 Wed, 10 Jun 2026 23:41:50 -0700 (PDT)
X-Received: by 2002:ac8:5915:0:b0:517:6d75:a2cf with SMTP id
 d75a77b69052e-517ee204de9mr24562131cf.43.1781160110164; 
 Wed, 10 Jun 2026 23:41:50 -0700 (PDT)
Received: from [10.156.84.244] (218.170.88.92.rev.sfr.net. [92.88.170.218])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfcb0f14edbsm17924666b.3.2026.06.10.23.41.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 23:41:49 -0700 (PDT)
Message-ID: <6c41aedd-9862-4b42-832c-cd0f706bb855@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 08:41:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ppc/pnv: Remove Power8E and Power8NVL pnv chips
Content-Language: en-US
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 kvm@vger.kernel.org, Misbah Anjum N <misanjum@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
References: <20260610090800.3672832-1-adityag@linux.ibm.com>
 <20260610090800.3672832-3-adityag@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260610090800.3672832-3-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfXymgM/gF9bPy4
 6jSf9W2aBoY9tBys2vg+ykTNlxmcez68srGtNS3RMncidER66uAQ3936MXEdH44qROzojlXGFUa
 i/hLs0kIeLY6cVTlFtwMt72YA0BjuiY=
X-Authority-Analysis: v=2.4 cv=atOCzyZV c=1 sm=1 tr=0 ts=6a2a58af cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=/nYmEve+L4YsDi96RCWAbw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA2MyBTYWx0ZWRfXwvH4ixDZHyGB
 WGrQfjMqU/6S068M8/+LdPaC6FkaqxnzgjuQ2AokpU+M/j3eZ5IGdVJavbwye59ZSQbTi0+0mCs
 1wQtJy96BRsVBeUe7EsGfi0HHMrTRFf7eOPmT+ZMR4JayXQoKlMnJY0o/sSm7mOPRxTbVOCDD/3
 IIDJgTAYaBA+zrOinSgowUeX9Zi3rCPwZs1G+C6NrnuKVmXMll9HNA8V1q+4fOAG0n4sdXaZ4yS
 JYGfWhwD2j3O6zCpR0WOGNSGDvFGwjV2IV+KuqDg/iyghR2H5hcW8NusG/NWaDXgvkAIGT/bsWT
 d9b50Qn123Veh+sQ94MOF+/ICsqLhbjzOB23s724+I1BuVkgMecSQzW5jV0hFGjIjRU9nLvdC8d
 NsPUqIzsWk2QWkLRIpUAvCiQI98v+p5Njt6e9i7yW8s3rxG/qHtmQr1GJY4pp9RqnNzIbtlQ1wo
 AD2Na+PEpgWBVnyxqIg==
X-Proofpoint-GUID: 4aCdLtXpOQS49kPF2sisxaHkgM9pfrmL
X-Proofpoint-ORIG-GUID: 4aCdLtXpOQS49kPF2sisxaHkgM9pfrmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

On 10/6/26 11:07, Aditya Gupta wrote:
> Power8E and Power8NVL were deprecated since QEMU 10.1, with
> commit 264a604e7163 ("target/ppc: Deprecate Power8E and Power8NVL")
> 
> Accordingly, remove usage of 8E and 8NVL chips from powernv, as it's old
> and unmaintained now.
> 
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   docs/system/ppc/powernv.rst |  2 +-
>   hw/ppc/pnv.c                | 62 -------------------------------------
>   hw/ppc/pnv_core.c           |  2 --
>   include/hw/ppc/pnv.h        |  8 -----
>   tests/qtest/pnv-xscom.h     |  9 ------
>   5 files changed, 1 insertion(+), 82 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

