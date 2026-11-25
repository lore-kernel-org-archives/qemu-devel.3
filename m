Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB29606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ec3l6/Xe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h9kbB7AW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWA3B-00056T-H4; Wed, 25 Nov 2026 05:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWA39-000568-60
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:16:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWA37-0000w9-Ij
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 05:16:26 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AP9mH783763959
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 05sHJXlFCTGBLd6d2SWB97tyGXBhRSqOUbX1erMZV8c=; b=ec3l6/XeujefBv/P
 x5pC2PMQhVlk4aVhQGV/AaE+WxWtmgqNbTxSnYz9hrO5yyEGKDjaYmc7iYoPUX62
 FjBJuRUAoRQPG/wj0fJVjeEM29YwJgnHD1ulX3EbwLp657AdwJiPycNiQ4d9qmkD
 sd+tXrXcbYobcXZDryMsg5p7twktdQ1stGpqUv2VdH1i2SiE5Y8bZbSbA3beQ4jJ
 L8JmgL8hz28QaEspq6LP5VhlaJFeB0YcbZsIlpijxuUNOl2jr7poy/Gvbb0bwNKo
 b3g1uRRT0DmRcLIFAQZj99Sao5MtAbob4sGSDnikQ1g4kp2j9xu65Vym7gzOlxfI
 CjWRAw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vv2r9mq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 10:16:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2c0e6653so118911285a.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 02:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795601783; x=1796206583; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=05sHJXlFCTGBLd6d2SWB97tyGXBhRSqOUbX1erMZV8c=;
 b=h9kbB7AWMlzMUHQqZtdFcnBvGxTRESSX42aG48ENFBSs64ARS+7XGpeghBbiCI3s4D
 rne8ZWhAFxoNoLZgSfsaH1ElX4o9WJxVX04CrY53GW98sM+2+a5wS7Q0lTTALYPxwIZe
 GmajLAbyGBlATze+K/SUlh6dmk0n4EMTu8/68uR7sbDA1GwChncqdJobT6Pc+alYSlw3
 IwCEjp4GlRBzfLj4fwQcI0L5S/FaKK2fMk+sul6SFdy6stVtn4XSunVAY1HsRMEZl5VM
 dU8VK8ZsHBGlBkBIoIXHEk3we2xfidnaNUjaHkcOmoUuw9WOu9F/Nt5NikEbRbwlws4M
 TaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795601783; x=1796206583;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=05sHJXlFCTGBLd6d2SWB97tyGXBhRSqOUbX1erMZV8c=;
 b=Ro61TDynNvWos5vjL43K+W/ESSOUBpmGy/umreut6YwdeIsJbG+2XhzkFDX6o+HVPB
 SmXydL7hIZ7I4GdSy4YNPkAOlJj0FqrCOP7aEOWfqEH9XFxeqWbx6spWivW6g1R/+Jh6
 yVfd0dINCIfO1Kf0jxjDioPgMyFQI3MLOfWhOwUHdFp02KqR5U/mFUvLp49wige58guB
 OKMPpP5bp3Icas+gUA/+oK8I3mbJzEqbluEplVbies7dDucA++NUIhIrHSU7vAmczKmC
 6HI2au7vpCXdtfLH45QWjODEHWuMeHaQPEgHlqvBmGMcaOzKzBZvttO3yPBpEnXfcsic
 ULXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEmTft5mKjiUMyboD5RA62jlMRTBhnoupUILHQIZ59l1SFj1zOy0eYeWIiWSDz9JPBptAPQgbEthp7w@nongnu.org
X-Gm-Message-State: APuU4Z9wO7kTJHALsuwUMRWxl6olKWJ5KIq8mp3G6K05zHZ22CBtoA3j
 ZmhpAUc7UW/IT040kXKdK7gqWAZHpUQgqpRkBICPDinTg99kiiY03OcDdI9I9baDvVpa5hZlF3S
 +BnBL+4LXZVacZxmRkHNcN3JyjuXkK8u9587+WFGuO8EJPUQKeTFc4XxD/g==
X-Gm-Gg: AZFdTZeoXnWLuQUTd09LMt0TPNrwWqtEARZ6aXTr+SIZEUSnSaN6uixYQ+TqVMTDEbQ
 bIsP+6KIzfTjjysf+ofdahxxMQx0wynzkBzmBKjDmHvP7Q3tmH3L0rFTi1iEdhuq9pvjEd7yetz
 SZLOp4/DeOaBxQaDOC6jAsYGZMZ6qotNle4VLvwtat8fqv7ZRTWoVsgXMi0dUQP6MRG4Sb6PuSb
 9oqcx4v9+fly5cepNXxEZZWLtQOKL75TgCelRPXC471QvfgVF59gpZWF8etrCSNZlPZgm9kmRiH
 U0lYA2dpPJOdmf9KQF3Qm/99iJ9fem7xsvZwA0EZuEGKoSRzjqyEKeecuBXFgcJF9l/bforWy6h
 /GGLFEkcBo7dJDub5ZGhl0lUIHLOt7LcQsMJWGc12kTjzZ/JzyE8c0Bt4sHI8+JVVgNYPtrYTa5
 GozSXLP/A=
X-Received: by 2002:a05:620a:6c17:b0:93f:167e:d990 with SMTP id
 af79cd13be357-949bab3264emr2836095085a.50.1795601783357; 
 Wed, 25 Nov 2026 02:16:23 -0800 (PST)
X-Received: by 2002:a05:620a:6c17:b0:93f:167e:d990 with SMTP id
 af79cd13be357-949bab3264emr2836092185a.50.1795601782841; 
 Wed, 25 Nov 2026 02:16:22 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853368d3sm505034055e9.1.2026.11.25.02.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 02:16:22 -0800 (PST)
Message-ID: <e8e38910-ff5b-46b0-9f7e-1b651e7c13ca@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:16:21 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/qtest: add SJA1000 receive FIFO coverage
Content-Language: en-US
To: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261125083350.331457-1-haseebashraf091@gmail.com>
 <20261125083350.331457-3-haseebashraf091@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261125083350.331457-3-haseebashraf091@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX/Jf16phuQrsg
 m0gMpIJy/kbd3y33WVKxB1b3Hyt1aEIPdeGmBnpTz2MsWkdJYsxSfJCC9dboy3TqkJ4ipi7oMVt
 qEHS4FFnfP8zJ01KDAUYTlrGMsPX92w=
X-Proofpoint-GUID: ZfbeYbRemDOQA955poxb7oXr-rKmFiUp
X-Proofpoint-ORIG-GUID: ZfbeYbRemDOQA955poxb7oXr-rKmFiUp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX1QKqZIySywKR
 p03w80puoJ0XKEQtpp7j5LgP9k7Ko3dB1zmdE7JSha5UhLpXKKbDNhOCCNvyh3diSfEhA6DYfdg
 /TI1hf/rt4bE/5wWvy4EBU2lyNzJSMCyn4OXP7wwl90fUs7THeNOqZreQsWpyUS9sLP60mFcYg4
 E8rZhov+gpQBTSZu6B7bnKzAcLF+kIfynt/ncO8EFMhpxPduYyXanqCyKuqlyrco1AEpHwDgR3m
 DbkMB1UI1jdGCpcR5/vvRh5TZLKO0BAFQz0yXC47BHB5knd1yGlY6kmCmUnf94HBpzJalYrHJNX
 AXpxxzrcolcEfb/l65FOZg00IUF5ApRw+kxRnUnn06PUQ0iVR91v6gbs3pVqc79x70b+jJG4lzk
 KUXOux3bIsE+YhrwbreqJSUSljb3HAPznMGgj3S4rs1wqUrkfli42MUdKWWguSQqxlWHHnuYkvZ
 QhSVhHsM0pFgr8HAu/A==
X-Authority-Analysis: v=2.4 cv=A/z5rKWG c=1 sm=1 tr=0 ts=6b06b577 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=a_U1oVfrAAAA:8 a=9RHgTBgIIlUGDfOJocMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250040
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 25/11/26 09:33, Haseeb Ashraf wrote:
> From: Haseeb Ashraf <haseeb.ashraf@siemens.com>
> 
> Exercise RTR followed by data frames in both standard and extended
> formats, plus hardware and software reset recovery.  The cases detect
> FIFO misalignment caused by storing nonexistent RTR payload bytes and
> by retaining the receive write pointer across reset.
> 
> Signed-off-by: Haseeb Ashraf <haseeb.ashraf@siemens.com>
> ---
>   MAINTAINERS                   |   1 +
>   tests/qtest/kvaser-pci-test.c | 195 ++++++++++++++++++++++++++++++++++
>   tests/qtest/meson.build       |   1 +
>   3 files changed, 197 insertions(+)
>   create mode 100644 tests/qtest/kvaser-pci-test.c


> +static void test_reset_fifo(void)
> +{
> +    QTestState *qts = qtest_init("-machine pc -nodefaults "
> +                                 "-object can-bus,id=can0 "
> +                                 "-device kvaser_pci,canbus=can0,addr=04.0 "
> +                                 "-device kvaser_pci,canbus=can0,addr=05.0");
> +    QPCIBus *bus = qpci_new_pc(qts, NULL);
> +    Controller tx, rx;
> +
> +    setup_controller(&tx, bus, 4);
> +    setup_controller(&rx, bus, 5);
> +    send_frame(&tx, false, false, 8, 0x5e2);
> +    expect_frame(&rx, false, false, 8, 0x5e2);

Since 19fd038a6b74 ("qtest/libqos/pci: Enforce balanced iomap/unmap")
we need to clean BARs after system reset:

        qpci_iounmap(tx.dev, tx.bar);
        qpci_iounmap(rx.dev, rx.bar);

> +    g_free(tx.dev);
> +    g_free(rx.dev);
> +    qpci_free_pc(bus);
> +
> +    qtest_system_reset(qts);
> +    bus = qpci_new_pc(qts, NULL);
> +    setup_controller(&tx, bus, 4);
> +    setup_controller(&rx, bus, 5);
> +    send_frame(&tx, false, false, 8, 0x5e3);
> +    expect_frame(&rx, false, false, 8, 0x5e3);
> +    g_free(tx.dev);
> +    g_free(rx.dev);
> +    qpci_free_pc(bus);
> +    qtest_quit(qts);
> +}

LGTM for PeliCAN but we should cover BasicCAN RTR too IMO.

Regards,

Phil.

