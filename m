Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E70C982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8zpV-00068p-LR; Tue, 22 Sep 2026 08:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8zpU-00068d-77
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:42:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8zpS-000229-5j
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 08:42:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68MBQ09n2870508
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 arWOd1YZjin+s97irG0BUOgBx1yXEFBswo99xboATrY=; b=EgVOFUQ5Su3Py7J1
 oUwmQ7+tvJglm7Mmu8UdmwwyYei6VuuvuExYmrXOFN94cBHFUDsSvMtA1vcYKOXR
 5sN0c0VNyugY75Fz7n1h1uHH6hLJLr8Os0rr6LYMW1OXtXKK3z2QUElIPankP70I
 v0Zakik5S+4E0e2grBvkTc14jWw5XwCsYfUEwSnNCx9HuWNOGYcnQHCHgpoOrJAm
 8RKVX3tyt6tXAKAR/LHPkpeTVw1AGMiAkWfCUdw3ZrNZxLdAqFBUIgpQ97zDKSDU
 oVHjVbOW8lz7txLiqofnOZNzjQw0whTKjVkP4SkjWsAQZIsmzPj6tiZ6v3BiLVnc
 ipX0vQ==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guj111ygr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 12:42:30 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-78f2fe53829so3604950137.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790080950; x=1790685750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=arWOd1YZjin+s97irG0BUOgBx1yXEFBswo99xboATrY=;
 b=g9u+Ano7u7jLVXW1WeoF7TubbyIeoz+IKaLAtEIGH9iaOdryrEYQPDajanmpS8/QaH
 ENugNrnqBKGG/zseS2cB13WMLgm8KB3tq1PL76qcTj7eoSfonxMqqurbqAJhnIgBnGMY
 JEvl2lY8kR4co3M8MT8CuK1ZgGL3N5zbHUJHBR5wWzExKgXYuqplVGJo3s1keWV5bs6N
 6/X+yYb9KXQ+gvcmUuMHVKyQzV65eQ9R/Th9rkhUobWDU7wQuK93yafPXbLpNJ/88FED
 UP6zENodlLozGdooeYloIGRn1bKVIR9Wbz+LKIBHSZLc4QbT4yK99pvsReDwVl2lL4oZ
 oDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790080950; x=1790685750;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=arWOd1YZjin+s97irG0BUOgBx1yXEFBswo99xboATrY=;
 b=huUKKS38DHV8B0JRfMw75QT2jyNcQDWNifpyovQpaR4zHmRkCCFKmiADfvYixhM6+m
 qj5H2IrGKYJPsljR7hhcpJeEjS5UFG6M1tpj0m0w1WsVCGCH4WziFGX+vtI5ENtF+QZS
 V7/L8LOItwnyfwj56UWItAwWwisvaEtNJu4EqTM07IVNTtHyopwDeSpY/YQC4wu9NGR7
 9ITsNogEuZHzt+djbdZ7RKMUFUA14BTHh5Vb6ZFFRbQ8u+fcpgy7CK880L4/4Ij7hmVO
 /yEmeUqE9Os2ApWM4avvryGlTpxYU21SsQQxPtbqMdXXKSnB+zPZYKWRjs+NJnRGOjvU
 wB5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBywUDMG4oReOop5Avp7bbbv4eyorJ8luG3XLth5b700I0DPBjvqCkwuMpAvwJ9l80CZS/RYKJK14516@nongnu.org
X-Gm-Message-State: AFuF++nzFgQQ7LLt9Bh7tSpLtuXl4DEm3SfBu1RQP/b/y6+/+I6Y/2EW
 tOOgDS804elL5xQ4XRXZvsTIWKV40z+vZ/HStQRlboQBS2Lagg7v6yrG4buU+IrDT7VM7H3maW8
 IM1vWhnfCi2d5YgO1VSrSATqBEncapX0aOyClZ2aM9CsLOjFycet6euN1Lg==
X-Gm-Gg: AYBFou0UrpB8iHO8okBKz1vNKcVUKxwk2cQFRz85Ah81QIC5bJn/9IJoFb8upnBLw2Q
 l3omBAIIEdop+1CW8lEDPEwBU5Wav+qqr/GBbllTLSg8pUMhjhB9mAzdnzA7sWcOewTevlDV1J7
 CHvG7UvmLa7TYsdv6REzYXnThv/NMQgx+aouJI7PWEROFRhngVcFtKHZjAFfOSqkFPpalzkTMB+
 yMOI1CH3zj9o/wmsjF52kcRUvz0/9R7QkEWfWT2A2aT5KgWKnnMgwiUl3Xov8RlTyb8Lok6CSbq
 tRm2VH5iljhtd7LWozGBqtL25DfmC7uwy/6CTNYxn9PHopppsPQxukT631H93eYlhgF2VHkZ05q
 +mpsTKaTzpuuum7Czbw4=
X-Received: by 2002:a05:6102:397a:b0:7a5:673f:7a2d with SMTP id
 ada2fe7eead31-7a5673f8391mr6381750137.6.1790080949877; 
 Tue, 22 Sep 2026 05:42:29 -0700 (PDT)
X-Received: by 2002:a05:6102:397a:b0:7a5:673f:7a2d with SMTP id
 ada2fe7eead31-7a5673f8391mr6381743137.6.1790080949461; 
 Tue, 22 Sep 2026 05:42:29 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.52])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8ce2623sm95041775e9.13.2026.09.22.05.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 05:42:28 -0700 (PDT)
Message-ID: <c5276fc9-6d13-465a-b92c-6fbbd020cee1@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 14:42:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/pci-bridge: honour CONFIG_CXL in PXB
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20260922115613.1926083-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260922115613.1926083-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: KYWEiYlk0kOt0zrMI56AnlMLkEf-OZET
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NCBTYWx0ZWRfX+sQoMuqmfJ3l
 /EjSq6BoUlKK4bQA9NwjPizevttxYg8G8Mda+JKz0Jr5v1bqOFGsov6h9KbDWtASuspOt+08j33
 f+oZpcOpsl9BizzPPWmg0G6mKju6j54=
X-Proofpoint-ORIG-GUID: KYWEiYlk0kOt0zrMI56AnlMLkEf-OZET
X-Authority-Analysis: v=2.4 cv=atQnmiZV c=1 sm=1 tr=0 ts=6ab277b6 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=QTt6BuOzr45adi7bDCnRgQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NCBTYWx0ZWRfX1XQtYQMcDiI+
 ddOyPrjaB5NDoVcte1sNqZqQ2YHpkjGEgEb7RpDWegBqbcLeegdvAS7r/kjWgowk0Z5qf4Ectgf
 J13BK3pK5RSsPlI0j8xfGn/6VH1n/gNiDZZRWNSO36S9bjMhG7rvY3aGCgdyGYwJyRZC5dCCX5N
 ia2BNOZINlbPF3Dn+co9oQKTNnDE6B6sVW3YtbGZgugKJqjmAQy+PV6h9kJ8j9E6m0Q1ztNteuO
 e8Y9sjvC6rntM4nGeRZ8iYOyDD40beIx6lPjZngQo4YjBdXxMCk25IADS/tkQ11FmnNcuKQgg/f
 juBi25P8thFXHGEAd2ENMZnEa4ndZvWsC8Ocq8dWHOuI/BXT103AK/iSLuBLw2NnGT4FW0HYJx4
 DNR202Gc8bR7gK14muwEYao71EBQ7qa0aWNru55BHcgVwNEtUAbqegtCH5KMaaSm7gbztkGvnhY
 vuh9hApC3zUeZtFDNyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220184
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

On 2026-09-22 13:56, Daniel P. BerrangÃ© wrote:
> If CONFIG_CXL=n is added to the Kconfig, the build fails to link
> the PXB device:
> 
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_realize':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:202:(.text+0x330): undefined reference to `cxl_component_register_block_init'
> /usr/bin/ld.bfd: libsystem.a.p/hw_pci-bridge_pci_expander_bridge.c.o: in function `pxb_cxl_dev_reset':
> /home/berrange/src/virt/qemu/build/../hw/pci-bridge/pci_expander_bridge.c:309:(.text+0x768): undefined reference to `cxl_component_register_init_common'
> 
> Fixes: 6e4e3ae936 (hw/cxl/component: Implement host bridge MMIO (8.2.5, table 142))
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/pci-bridge/pci_expander_bridge.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

