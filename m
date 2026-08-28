Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C112C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 07:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzqnl-0006RN-7c; Fri, 28 Aug 2026 03:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzqnj-0006RC-8e
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:14:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzqnh-00025g-AL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 03:14:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S676Qc1043780
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E0bUTxfwZzRKQ56qyaIvzWAoxUQ9jzhCX9a4qDlz2H0=; b=iqJYFJqDzC7nvolT
 9Yj4WypR4/fYrLM2fnu3BNykx1pnZFpdN9RJbOBYks0BC1CHIdxWAVB8rpFt3tbz
 aZh4wYoT6KiWIq6eChFlxd9dPuOtQUljoOru2z9Nad14W3Vx3zRu9ueqSik5yeVt
 3UanGMf7LJohPWCPJQ/Am5JSJ7RFQtrjm0gFpwcoFRFmXqXuxl6gnIdKcKgRPmlI
 KrJAk0YDU8GzZHQ7rLYRMZF6T7NCRHqUh6hExG0Aec5Sr+OtDgdHuN9ehc32McZw
 iF/hzYyTmiGvRg9B2C2dy5mX1xujhA/X6IxEw1zGbg64LLuUaKmpUd9T72GX2D/4
 VR2TMg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatnc2qg8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 07:14:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52fc16ac179so3342681cf.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787901294; x=1788506094; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E0bUTxfwZzRKQ56qyaIvzWAoxUQ9jzhCX9a4qDlz2H0=;
 b=WdT5AQzbl/zhxbfpKJ/jDgVJJA7fxF1CvdYzcXYtH2BtNSqr0O49T2QwQUKaLI6wU0
 iKcOwxUMCayxQKsLU2Pr2x3eAyLFdS5NzQTt7MIq5xgN3GIsN83mYNtB6/LIozFXcxM0
 jgO3+A3v2BTGTM1S9qUVE9Mwvp+wPfyUi/eQXS0lee6ApqVXSOvVp0Zpcc3ImarQpPJh
 M6NO9e5za2vte6a99jFen+J17VKLFLbxL/oLCIw2++KONRqxILGpYOQRfj/4IPsdasI1
 HnrmN4AzIj9xYb8xPZrRYnGKzkOOM89MJKjE++QsUrDja85Xl0DTFlk6070r7lT7YPVi
 /fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787901294; x=1788506094;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E0bUTxfwZzRKQ56qyaIvzWAoxUQ9jzhCX9a4qDlz2H0=;
 b=WzFx32gdv0AqOSAsaA1xM3HpykG1u1LFJoH9Bjdefw5PvmAU/kmUarLny0RjFm+PEb
 sxrei09d5uLs/pS5jM3ppnwOX2zVNKr+1aP5YF7AAh6BRmkTrYkeyhQXSY7KM4qiNljI
 b2rSSu8luqJoE97vgKSsFhDbqB5J5I7rSNGpXvCp/Z+CTmtT3RPOTCtMr3FZPVjZVTXj
 1RUIwgoTQDITtm8YOuwyjobYRX0WZwwkNzEZosT6nCK8gQcRGtBt3AkTrOAXO6IjZ0w3
 bDdb31NCUhhQiUUGn6ExO27/0dq+DQr9TGISQLq8xs6nbkNqzrPCuWA1c9o2x1yinFL2
 MZBg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHAfbRLkMPa0L+Y6uRMGP5vkcjvYY2JgHi5EMQGoP/AOgLepyF1/KXe5ITZ38vcWa8Ki97zU7G7gen@nongnu.org
X-Gm-Message-State: AFuF++lEJQ4p+tVoXkBuy8oc7/SYno6RiYPSsVZRVo0dnw05qYqSq4Ng
 zeHmBlVO7wXnsYRkF+aM7l1Hmhm2ikmhX9RpYCiAOVSt9ssRG1xhdyiZ5EcYKsgJaG7vFirjSsy
 am7vjmR4WjAZ3y14FE8jZLR4r52ZJ/kq5mFdfQt4KuPdXB1gY03GWz/ri0g==
X-Gm-Gg: AR+sD10C6WjX6BkpPuStGvhGAdLglHwGNgtK3Jq0Naw0h5B5VHHU0ZtvlQLYx+1IJZg
 1tO7W8HAvBj4sQnSRkU3onua2vZgOVAj1XwdVgMd2UKvFXxIg4QsfJNURFpTuseFksZtOYGVabT
 QwxeJDSP8STOZmFnteLoClREIs3CPPyd6ON8TGk1oftHBssFANcgXXBxzBIpBYNz0BVUvTql/1p
 GBh1swe2DATB28vqcrgeTygmq3y32dndtZvZGIhngWvbC52NLt+jDMMG5DT1JjqRRMHdqLHCjBm
 Vo5ApsFsVPgeTjJn+igYyzloiRPLzIuRUwr1RZ9U50NQvGxplrTqZyKtjeU4+wCY5X6FYkT1n8V
 9dXD9pNK8Wcky3OHG0GL8etMUIOSdgbaYFQ==
X-Received: by 2002:ac8:5fcd:0:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-52fa1d142e0mr129429321cf.15.1787901293564; 
 Fri, 28 Aug 2026 00:14:53 -0700 (PDT)
X-Received: by 2002:ac8:5fcd:0:b0:52d:6f91:86e with SMTP id
 d75a77b69052e-52fa1d142e0mr129428941cf.15.1787901293144; 
 Fri, 28 Aug 2026 00:14:53 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbab3f3asm1898437f8f.3.2026.08.28.00.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 00:14:52 -0700 (PDT)
Message-ID: <d49d0c5a-43c9-47bd-96b3-13c6a35d1be7@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 09:14:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 07/96] tests/qtest: add test for K230 gsdma
Content-Language: en-US
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>
Cc: "dingtao0430@163.com" <dingtao0430@163.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "caojunze424@gmail.com" <caojunze424@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Ani Sinha <anisinha@redhat.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
 <20260824054806.2790041-8-alistair.francis@wdc.com>
 <CAJ+F1CJ+RxPZ+5kZkzTPzXG=2_cOWOmn_5tXFC28_4n1YuwD1g@mail.gmail.com>
 <3964c25b8758c558c3630215c34f0f2186d57d0d.camel@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <3964c25b8758c558c3630215c34f0f2186d57d0d.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA2MCBTYWx0ZWRfX0j/OnoO2/DRq
 OXOFpn1+K8R81dzsBHuoJMln4JNsu3Xiu1UzIqSCnztXD5mUM3QL2uWpym9pAyjMotldSt6aaA6
 oZQNZIFPZ0p8FypKmV/9h1RdRzsNjo7ParfWeyCZYo2JyGqsRseS1mCNY4PM06GVOqRkrQgoU+X
 2eCsxvYO6qxw8/HpI6EPC9BR2qc8abeoTnFCadi1BKviMe4Hm1b4SZQXK2q10TV4c711zGSjj2R
 qiYa2HREeXZM3Rtj0QjX7EZ9jwIt0ROHCwt3mWItV5/kl3kPTm7Ddl4S0HZB0taJCIGJzJKfilO
 HVr47nxKhm8gXjlZDMZyVwevqgUahuOWw99WXt7pI4q5wwkdqwUHs1Jm+SM0og4PA0OFCalpsh2
 /5gPvrTQfbl4cWZ+c9OM22wQS2GwMhOF1FFOw7JqjddicOZHkKxZ300frxZOeVxCG0t0Fd3fh38
 7/VVnOPirFCwUkRT1PA==
X-Proofpoint-ORIG-GUID: am6xYZq7OeWHckwr0QPa0LNDtuM3PJW6
X-Authority-Analysis: v=2.4 cv=HfUkiCE8 c=1 sm=1 tr=0 ts=6a91356e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=Byx-y9mGAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8
 a=KSiKIhZyWGKUsWaFgV0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA2MCBTYWx0ZWRfX8HkxXYgwqLVc
 3YckdLK6Kt+t13+ZRtSQq9PNhy6/ucwXhjnzyp1ZZyqIRr79qaOripxwraPY6+9e5PCHZI8kpWt
 S1E5yUBft0Gtitsu4avCtjpz78BlpEY=
X-Proofpoint-GUID: am6xYZq7OeWHckwr0QPa0LNDtuM3PJW6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280060
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

On 27/8/26 01:08, Alistair Francis wrote:
> On Tue, 2026-08-25 at 10:40 +0400, Marc-André Lureau wrote:
>> On Mon, Aug 24, 2026 at 9:55 AM <alistair23@gmail.com> wrote:
>>>
>>> From: Tao Ding <dingtao0430@163.com>
>>>
>>> This commit adds test cases for GSDMA.
>>> Imitate the behavior of the driver, set LLT and sdma registers.
>>> After the data transmission is completed, check the destination
>>> address data.
>>>
>>> Update MAINTAINERS for this test.
>>>
>>> Run this qtest:
>>>      $ mkdir build && cd build && ../configure --target-
>>> list="riscv64-softmmu"
>>>      $ QTEST_QEMU_BINARY=./qemu-system-riscv64   tests/qtest/k230-
>>> gsdma-test
>>>
>>> Signed-off-by: Tao Ding <dingtao0430@163.com>
>>> Reviewed-by: Daniel Henrique Barboza
>>> <daniel.barboza@oss.qualcomm.com>
>>> Reviewed-by: Junze Cao <caojunze424@gmail.com>
>>> Message-ID: <20260808062227.66961-4-dingtao0430@163.com>
>>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>>   MAINTAINERS                        |   3 +
>>>   docs/system/riscv/k230.rst         |   1 +
>>>   include/hw/misc/k230_decomp_gzip.h |  92 ++++++
>>>   hw/misc/k230_decomp_gzip.c         | 511
>>> +++++++++++++++++++++++++++++
>>>   tests/qtest/k230-gsdma-test.c      | 201 ++++++++++++
>>>   hw/misc/Kconfig                    |   3 +
>>>   hw/misc/meson.build                |   1 +
>>>   hw/misc/trace-events               |   8 +-
>>>   tests/qtest/meson.build            |   2 +-
>>>   9 files changed, 816 insertions(+), 6 deletions(-)
>>>   create mode 100644 include/hw/misc/k230_decomp_gzip.h
>>>   create mode 100644 hw/misc/k230_decomp_gzip.c
>>>   create mode 100644 tests/qtest/k230-gsdma-test.c


>>> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
>>> index 2d6d2238c5..16db4ba0cc 100644
>>> --- a/hw/misc/trace-events
>>> +++ b/hw/misc/trace-events
>>> @@ -443,8 +443,6 @@ iommu_testdev_dma_verify(uint32_t expected,
>>> uint32_t actual) "expected=0x%x actu
>>>   iommu_testdev_dma_result(uint32_t result) "DMA completed
>>> result=0x%x"
>>>   iommu_testdev_dma_armed(bool armed) "armed=%d"
>>>
>>> -# vmlaunchupdate.c
>>> -launch_update_write(void) ""
>>> -vmlaunch_reset_enter(void) ""
>>> -vm_launchupdate_finalize(void) ""
>>> -restore_host_x86_igvm(void) ""
>>> +# k230_decomp_gzip.c
>>> +k230_decomp_gzip_read(uint64_t offset, unsigned int size, uint64_t
>>> value) "K230 DECOMP GZIP read: [0x%"PRIx64"] size %u -> 0x%"PRIx64
>>> +k230_decomp_gzip_write(uint64_t offset, unsigned int size,
>>> uint64_t value) "K230 DECOMP GZIP write: [0x%"PRIx64"] size %u <-
>>> 0x%"PRIx64
>>
>> ../hw/misc/vmlaunchupdate.c: In function ‘restore_host_x86_igvm’:
>> ../hw/misc/vmlaunchupdate.c:151:5: error: implicit declaration of
>> function ‘trace_restore_host_x86_igvm’; did you mean
>> ‘restore_host_x86_igvm’? [-Wimplicit-function-declaration]
>>    151 |     trace_restore_host_x86_igvm();
>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> bad conflict resolution, probably
> 
> That's my fault! Sorry about that. I'm not sure how that slipped
> through my build tests.

Well, it passed our CI. Is IGVM not tested?

> 
> Thanks for fixing it
> 
> Alistair


