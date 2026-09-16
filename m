Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C147EC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6tAy-0000gs-NQ; Wed, 16 Sep 2026 13:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x6tAl-0000fj-G1
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:11:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x6t9s-00073g-DJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 13:11:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68GH6UdK3559699
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0+2lfgTWtN3UlUiZVZ/IPqieSwNrnYdIMstsJpcoDIk=; b=dWj6RhZvcsqSSx1o
 lurLRNvrk+/vfMXTk1tNWR5weL/O2+X/izELplWI2cfXK8C+/gZCUS0J6QLKrkOF
 dg2/smuZBOjQzMwjNVbSXGgrYGnhyQcNgmi0kaI14CWlHOtFpDnmWV4MqaeU6WVu
 lElZXG0OgJriaZyoKmZRMeup6KgXztoXPZasMiUBlBTw7LIYRFg8aVwvxBCrg2ZG
 pddjX1oKp+wffnM0sNxwEHc8LwYhxVMN/x9N0pzAmSRkoAmEqo7JtZR4Npm6g5xc
 NyVjizOSj29X8Des8Va5un0oRgyiwcd1MO+jGGrROAVFMMNGu3h/LWZmvGqByhDA
 hA+LBw==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gqy7h80wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 17:10:47 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4ab4f652f9bso4246933b6e.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 10:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789578647; x=1790183447; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0+2lfgTWtN3UlUiZVZ/IPqieSwNrnYdIMstsJpcoDIk=;
 b=KjuFr7eaFVySiFFt2KoEeQcnlzOOpmuE1N27LMwkuLWp3sUokGhJPamKUqWdEz2MRG
 C1r4r9s2fAi0egxuNW5X4Z0QO2D9PIXJ+e31viTvzEbz1x7BVMPR6hgUUH1aMttqnSGi
 I5k6kBY4BUvbCtlLH+YsdazSxgDyPkIwI24tAEhO+HXEitVkagy5m2SVEOX+dlbJ/Dhf
 JrG3/XPW5CFUGkmyJqFdTz/1xuCXjXo1OhYdTuJh+k4Qp29Peh4DS0DBcWOibD6BCCze
 u6TsA/bP5IEZz7oACkZUmiaQfNv2w8IRyIfXdKbc9+WCGiMXb4Jb7CbA0BZkV3KAe4ls
 kV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789578647; x=1790183447;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0+2lfgTWtN3UlUiZVZ/IPqieSwNrnYdIMstsJpcoDIk=;
 b=f7tZ7weffeMElG09DY8FRrcSLgQbpg6UUpACA6thMoIKc9hl7iKYSH8cEkuYHDOJcU
 h2EO7SGwUa2tAvvE3DqENtAc/YPG1haBNlUQ9VkVyOXr+cCcWSgD9AfbLOUdV91Xe0hl
 x1RHYxsQs+rQgE05P0607Ezh1rHJhlxJzhq57lhdhltNnqQJ7YVCa8S3FQWUk25DGh8G
 Wno/jLBsTD1f3rgZ8rsttbh3TO8eM5/fPn6j7iFUAWmD6LY6Nl6hpd2nBaHBmCk13HES
 ont0e8tSoQGn9IIJQ0e5SQYJJxNZTBVL9p6xoZi/8QUTM+qEa34/ViQ0fKx3bdyjUikV
 3Adg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxvGCJb4tde3xPNK36Cmf9Izp4h73TkRjAtUS/vf0yiL7gRkv5geJswrH2GnrpcJcNGw7c2sKEb2wAK@nongnu.org
X-Gm-Message-State: AFuF++mJ4AizlITDNvAQvzpYP/GXosAfLHiJdbDp6SREKaXhi1bAYlda
 jNP1Mpwj+rIxVfeF+dim5Es7Fh87WAfC51CUeVP9IPxTQ1qD+VQ9DMh08PGAehfYodUvyD6UfHK
 0K+tXQRcRmniZYLJKbA5UD9ST9a/oiojv//64Ed6ChFoGneFh+Jbfsd0YeA==
X-Gm-Gg: AYBFou0bRtfLOJ7ZqYsY41ORrlduN2nrvC1w4EZYRH+L2/amFLpNkMIoEqkuEBbaIkb
 BM+JCnvQtfHXBkmSxwzFUrWYNTTvndzhwnpl6MsZOvKMTmCPy7XLEdCbFns7gWdYPF2MSP8Nz2R
 VkG6dtsc5tkdiKDJFCrKWWhn9G4V90aCJ/1lOlTkQ4RW7q63W2QA9l7m/InzwQ6Xf6np+zIXuqD
 FxUhwkkVVurOfDeW+7ZwXfhUiKMS8v/D3rjZgaZo3MYBVL67de3dDRqsO4VYu4WVCOYz+qUM/mN
 dqQEN+wbh0MeCVzkydiJ0A/1PABjeIrGgm27CXp76XbZj+Awb68qxwQE2+EBGEJQUzeOc1Ra4oj
 sPShA4OGvG7FCAu/Y3GYN3KBcRRbpcBlsls+ctg==
X-Received: by 2002:a05:6808:309f:b0:4b9:a88b:888c with SMTP id
 5614622812f47-4ca4c59e9b4mr4239525b6e.34.1789578646631; 
 Wed, 16 Sep 2026 10:10:46 -0700 (PDT)
X-Received: by 2002:a05:6808:309f:b0:4b9:a88b:888c with SMTP id
 5614622812f47-4ca4c59e9b4mr4239465b6e.34.1789578646027; 
 Wed, 16 Sep 2026 10:10:46 -0700 (PDT)
Received: from [192.168.68.102] ([189.110.107.170])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4cb6cd417bfsm271713b6e.9.2026.09.16.10.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2026 10:10:44 -0700 (PDT)
Message-ID: <8594dca6-0af0-41a1-878b-1e7847b5f043@oss.qualcomm.com>
Date: Wed, 16 Sep 2026 14:10:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/15] hw/riscv/virt.c: fix aclint soc/mtimer nodename
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 qemu-stable@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-9-daniel.barboza@oss.qualcomm.com>
 <725cf200-8a28-4fc9-8d96-4d705213505d@tls.msk.ru>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <725cf200-8a28-4fc9-8d96-4d705213505d@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIzNSBTYWx0ZWRfXxaXohxFI1Jav
 umaBJwizpzezt0j1KQNR/ewBpO5792Wa5j49S/SvGSRk34bm6XJUQsf4BYp/mO8u3cJABKjJANQ
 TlmdXQM2Bi9ilmDGNs9O22lmnYxKecPCsTnDufYhnHHl0WHZe5aLvsUFAzZkrNhVNfnAD1arlto
 lbhCsvEwdK59aMB5eFtIF+ysFfAoL/xyF6W/QCAENlUehmJn9sj+PIt3smbA96S+RHh/la14P9R
 HCEyS8IOMgqMShENRpLamkOBzfKDgEFGvfHijWuRoKZ7o64WmYEpw+t4oBfSmJdqr5CygkOGZnZ
 K6pyUEW9BJBWX4wOn/k0+4AR3Y6LFh+c8oGyIPr7ZmjrPJWVd+QP+F2NfEpoIvEOghZUKq+Cj2h
 ch9YSNGIQrxQERjKToeBcZMtWoC/8VY3FhoqtK5/5YyR2PddmMHCB6znvtFCe/vON9xe4/rKLWr
 7OPSKZquXnpRP7+8tkg==
X-Authority-Analysis: v=2.4 cv=L8aI0OT8 c=1 sm=1 tr=0 ts=6aaacd97 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=arNgJ3JLhM/z8Vk/iMOFgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=69wJf7TsAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8
 a=Z1dXUFJnXcOokC3gmg4A:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=efpaJB4zofY2dbm2aIRb:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: 5ScUvLQtwHqlhGvqoJ8x9hUqed_mNjMk
X-Proofpoint-ORIG-GUID: 5ScUvLQtwHqlhGvqoJ8x9hUqed_mNjMk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIzNSBTYWx0ZWRfX8TLCyipIX7pk
 MJORcZpfLSxA4RRIyzOUoetxEDmoL7FoTlSfmryu7KG9Kq0vMV0+V9uEcne6xUuveqsRswdyXJW
 CoyiHzFXVw1PRVbiY37gkMDEBVniM98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160235
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Michael!

On 9/16/2026 3:35 AM, Michael Tokarev wrote:
> On 8/28/26 23:39, Daniel Henrique Barboza wrote:
>> Running 'dtc' to generate a readable fdt for the virt machine produce
>> warnings:
>>
>>   $ dtc -I dtb -O dts virt.dtb > virt.dts
>> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2000000: simple-bus unit address format error, expected "2007ff8"
>> <stdout>: Warning (simple_bus_reg): /soc/mtimer@2008000: simple-bus unit address format error, expected "200fff8"
>>
>> This happens because the 'reg' field does not match the address in the
>> nodename.  The right fix, pointed out by Chao in [1], is to make the
>> nodename match the reg value:
>>
>> "In the current QEMU implement, `addr` is the MTIMECMP base address,
>> while the MTIME register is located at addr + RISCV_ACLINT_DEFAULT_MTIME."
>>
>> In other words, the 'reg' value is correct but the nodename isn't.
>>
>> We'll make the fix now, allowing the next patch to move the fixed version
>> of aclint FDT to fdt-common.
>>
>> [1] https://lore.kernel.org/qemu-devel/apHH1upnh8udUUT-@ChaodeMacBook-Pro.local/
>>
>> Cc: qemu-stable@nongnu.org
>> Suggested-by: Chao Liu <chao.liu@processmission.com>
>> Fixes: 954886ea6d ("hw/riscv: virt: Add optional ACLINT support to virt machine")
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   hw/riscv/virt.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> This patch is Cc'd to qemu-stable, but there's an interesting rebase twist here,
> it looks like.  This is commit v11.1.0-1035-g9d6ac47d318 in the master branch.
> 
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index a6ec9def16..83a4b7710d 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -234,7 +234,8 @@ static void create_fdt_socket_aclint(RISCVVirtState *s,
>>                  (s->memmap[VIRT_CLINT].size * socket);
>>           size = s->memmap[VIRT_CLINT].size - RISCV_ACLINT_SWI_SIZE;
>>       }
>> -    name = g_strdup_printf("/soc/mtimer@%lx", addr);
>> +    name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
>> +                           addr + RISCV_ACLINT_DEFAULT_MTIME);
> 
> Before this commit, `add` variable is declared in this function as
> unsigned long.  So this particular change is wrong, because now the
> format string does not match its argument:
> 
> ../hw/riscv/virt.c: In function 'create_fdt_socket_aclint':
> ../hw/riscv/virt.c:408:28: error: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'long unsigned int' [-Werror=format=]
>    408 |     name = g_strdup_printf("/soc/mtimer@%"HWADDR_PRIx,
>        |                            ^~~~~~~~~~~~~~~
>    409 |                            addr + RISCV_ACLINT_DEFAULT_MTIME);
>        |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        |                                 |
>        |                                 long unsigned int
> In file included from ../include/qemu/osdep.h:118,
>                   from ../hw/riscv/virt.c:21:
> /usr/x86_64-w64-mingw32/sys-root/mingw/include/inttypes.h:38:19: note: format string is defined here
>     38 | #define PRIx64 "llx"
> 
> However, the very next commit, v11.1.0-1036-ge6ea6bec5a3
> "hw/riscv/fdt-common, virt.c: add riscv_create_fdt_socket_aclint()",
> moves this whole function to another file, *and* changes the type of
> `addr` variable to hwaddr.  So now, everything fits.
> 
> But this single patch alone does not work.
> 
> Note also there's no mentions of this type change anywhere.
> 
> So, what was the actual issue ere?
> 
> I'm dropping this patch from the stable series for now, it is definitely
> wrong.

It is ok to drop this.  This is a FDT issue that has been around for several
years at this point and no one noticed.

In case you want to port it anyway the right fix would be this:


name = g_strdup_printf("/soc/mtimer@%lx", addr + RISCV_ACLINT_DEFAULT_MTIME);


This would fix the FDT nodename without messing with the format string.


> 
> It is also interesting that only win64 build of qemu detected this, all
> other went just fine.

Yep, this went unnoticed on my end since it didn't break on Linux during my
testing ...


Cheers,
Daniel

> 
> Thanks,
> 
> /mjt


