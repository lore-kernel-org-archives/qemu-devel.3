Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABBDC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbFg-0007dy-VZ; Tue, 14 Jul 2026 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wjbFe-0007dC-Pk
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:24:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wjbFc-0001BR-SD
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:24:38 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EBOPib330082
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 11:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P5d+VWKSvm1N9rs5M8ZLToRc/Li7azgkfotqH7f6H5Q=; b=bmHbOctJenMe8vKK
 fGvSJTbzKm6+7+oHj4sD58eCchM7cR9Mkr5MvQSW9gRlu2lCFKJIa9YOx+rCR7ec
 drdxXVwp78SugMc0oc00n5wcvvrZIAQ4Of1/hs9LGboLc9RObsWnuqisLE6T4oWs
 34RyqNGugmemUCiAzBqwwVBbw30tZME2edZMkNrMoNvNxGnKLnN6bgbPs5J9zEXO
 VEjef/c8CdB86Sl4SVOuvy87yPOWs3kmX2vQfKHVorq9znvVYwa74rd4E6P6tppo
 C1UYDKpETjzylRZPrxoo3hDWF/ULhutZQZ6W45o+xdH7MZR3XUjoYrUYjWcov8LS
 3/kmNA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq0x07-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 11:24:35 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-81aea53d559so88450077b3.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784028275; x=1784633075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P5d+VWKSvm1N9rs5M8ZLToRc/Li7azgkfotqH7f6H5Q=;
 b=iHiHOhG1Z6gIlNRmHPb5jcvaPOWbuw/zIwPXAPQsP4Glq6C6TxnlAon0vJZ7CsZcms
 lU7FPP8uI3JtkVXKX66AAaTCPBIigFKTerLcnJsUI8XYTOGRWQdqWFHqooLfZRX9zSdj
 Ja3sQDlWzdyOZ/ziMR3MVmLnO7UNVOHdPSRd+N0kpGczaYjWGasUhqJXqi/dZbCKlAKl
 sijqqIu+JWaFyvtftZzM9ki880qtNUbHeZf4iA/b8C3G5bQfXv7XaHqYyUvWdw7uCbgf
 M/e4IULC1q2Wqul358k5F8O/ED+YpJdc3HYZLwaX0sNh9IRGzdEd3wCnVboLNmsfmHzH
 ZmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784028275; x=1784633075;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P5d+VWKSvm1N9rs5M8ZLToRc/Li7azgkfotqH7f6H5Q=;
 b=lTr2+KdQvknJ750e7VqkjO+wHHzPaZiqjFyIpMnvzAoLtprqCtEnq2BIGvNMbkTUaP
 EmBOdZeB7NwfozbSMZdMZPxUw2fzZlvZ1puNyZe1FgAtKaWeUB6ethL2j5x5h2nIZdrM
 x7qMaQgQbP6Y9iVKa9HBYByv4SasunCkDguDrZyOqzf/G+IrwM/vAfWuLaWnBHA4s0D4
 QHfSP5W1rSrWAXizN/upZgQyCo3ZHr0D87+M/tFZbRTvhdERyEOk8KrxeeqeuxVK6wDg
 3EXAQqWPUPvH6oKy5qFE6L/q/eWeLz/Y47oeJfGVGyLAqlzSaWXmWqapPhiFDxDDXtyL
 ZjAA==
X-Gm-Message-State: AOJu0YxdzuD0+E38x2KvJTyDc/WqM8DPRzNOqViq3jfLpHVKAPAu3jWJ
 PxRGNSC6WC8rAoV0V9lonAaMBvTc/tezpP0NHp2ei5dU2mTSL9xnEEeY1mMwuPk+hkEL+LzyVid
 GsHp7zRwqhJteF3MMIdVtu7uV4KxQpOXZcJWnt/3vyl2Kjw5HHGdlULJK+g==
X-Gm-Gg: AfdE7ckIhGaJSBkmw/ApnCiF+Zd3oirKuFjAYzcPPv0C19b2/rnJjidr94kUHATZQ1C
 COdoKxQgaNcGo+x5lUnHBJgksBeQ5jmd5JmEDgHFqUYHiyPNgCU4u2zAsMkYCIA1Yw0dOGQ5D18
 T+Ph2TahX4dCF+SAFiGr1Wa1EEO2TK9/7ph6YI0QGpFwHJWXmyrEXfY0PF2NbfXydZ4o9aQhA5P
 I+EbpM2vOP0HyDisvjo3bnxfiSijwUBlylYt71GWGGwYTeOGundccaFZMd6Bk4M57r3kymFwf0x
 5wUxaabeu7Lx83sQ6hPXXXLzEXF8WdGoh0EjXk0v3mk7Bg3GNxGubDjJ3r4Z4CoWrYhpO1KQFwa
 dQE9jkOTpBdC/ldJkMxIAB6hAeMp5PmW+tXe9bthCj28=
X-Received: by 2002:a05:690c:6885:b0:814:585f:73c8 with SMTP id
 00721157ae682-81e8feac8dbmr107657507b3.0.1784028274686; 
 Tue, 14 Jul 2026 04:24:34 -0700 (PDT)
X-Received: by 2002:a05:690c:6885:b0:814:585f:73c8 with SMTP id
 00721157ae682-81e8feac8dbmr107657277b3.0.1784028274248; 
 Tue, 14 Jul 2026 04:24:34 -0700 (PDT)
Received: from [192.168.15.9] ([179.94.34.129])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81e6c1a44e1sm140276897b3.29.2026.07.14.04.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 04:24:33 -0700 (PDT)
Message-ID: <2e2de5da-9eb0-4d56-b193-d8b06b7a3512@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 08:24:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] target/riscv: Implement Smsdid and Smmpt extension
To: Alistair Francis <alistair23@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com,
 alistair.francis@wdc.com, chao.liu.zevorn@gmail.com,
 liwei1518@gmail.com, rahul.pathak@oss.qualcomm.com
References: <20260511124705.28161-1-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKOOa9ZF4YGiTtLSS5sMj25zWkezK8JUCYXYVPkv7WpsKA@mail.gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAKmqyKOOa9ZF4YGiTtLSS5sMj25zWkezK8JUCYXYVPkv7WpsKA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExOCBTYWx0ZWRfX7ZX76E3QpB7x
 8SI4JsrA1hvf6+/ZfkiUPxLsxo8lA+/4sP1sqzFbsnN8RnzWNM+GW+CK2VwUx9oknzabxbYW/H9
 YAZBqOEE4ooXJAx2XhK8FLc1FQBWklrhA3WOSWjOd/x9TZJrotvHKulBOvR/7oreAOuCV6kzObB
 j9vp+5Rof5zx+2GB38ruFIuw0fuCmujwD8wSrHAwb/RZZIZTmauM1hgoyG33+wsbhMm38Ti09yk
 GwBIYhTFcIhv30aTc1Nt4FZjd2OpmKZhaudp8TvzQKQcpcJQj5QOBkQ+cZXfVUbJcG1uwZwVWbH
 lW2N7bGj9hFQ363p4pqhg9Kk5Me2/jwy8fyZtula6Ik1FLb61w/WJWJmRcZtwtwRlcwzYfniMhD
 mQ6wazoJLVUTQ7k+muR3Mk2xwrp6WLp1dfcGeuSFgs/Z+vRsOTnrxY6estY8RcfC7dmIoapgIcB
 iK3iqdcBTyV8mbigfjw==
X-Proofpoint-GUID: HVYQhYOOo8KPrD7r_u_ky3KVxIbkBZ77
X-Proofpoint-ORIG-GUID: HVYQhYOOo8KPrD7r_u_ky3KVxIbkBZ77
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExOCBTYWx0ZWRfX4ETG0m8BBx6W
 GwLb2UZ+xqXTmkouNo9QO4D0GZCJhv0IMogt2hjA5E52lfQXxcd+W+KTRYhtAw2hRbYLsNbVV4x
 Z74c8bwn0J0HcWcc+d0NK1Oug8KnTpw=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a561c73 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=hyj21kqpmCXl+EtBZfPtqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=xvfqbYfxAAAA:20 a=ID6ng7r3AAAA:8 a=SRrdq9N9AAAA:8 a=2gu42DaaSSrOd0dESpwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
 a=AkheI1RvQwOzcTXhi5f4:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140118
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hello,

On 5/12/2026 8:51 PM, Alistair Francis wrote:
> On Mon, May 11, 2026 at 10:48 PM LIU Zhiwei
> <zhiwei_liu@linux.alibaba.com> wrote:
>>
>> This patch set introduces support for the RISC-V Smmpt (Supervisor
>> Memory-tracking and Protection Table) extension
>> v0.3.4(https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
> 
> Thanks.
> 
> As this is a draft extension we need to support the latest version as
> described here [1].
> 
> So this will need to support version 0.49

Rahul has a POC for smsdid and smmpt version 0.49.  He's polishing some bits
w.r.t needed opensbi + qemu changes before sending them upstream.

Just letting you all know in case Zhiwei or someone else is planning to send
a 0.49 update.  Thanks,

Daniel


> 
> 1: https://wiki.qemu.org/Documentation/Platforms/RISCV#RISC-V_Foundation_Extensions
> 
> Alistair


