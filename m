Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3828DC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgyzX-0002uJ-P1; Tue, 07 Jul 2026 02:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgyzW-0002u4-BA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:09:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgyzU-0007zR-L3
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:09:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6674ALgC2501539
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 06:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1/8L/hYAqjOo/qr8iNduNRjUIW5+tdAdo4KbvZFxWsU=; b=NoXN9ax6Tny3d72o
 bVBqDFOV3LtRBZilTda64Qu4bviz7isxtf4J8P7uQxa8DNHQ2TMvSMufx4gQsyih
 AcXRQvoXymNIcbxRwlQfGoj4WuqqVUs5TVOstyvyffZ+E8wo2g4JWxe066tarLgL
 EHoV6NdgcfEbUlHtGfRIXCE8sda5fbJFEB711TdLCH/Xd9k1oAcrlbcjJTLnWK72
 RKEq+JW5baBPgHB7DoBT86FIDe39lGZebE2NEMX0LQdvucpTEDfT2a1m5wIJLJYS
 8F/pcJT2XC3YsiJt+FlKDIwtfdwNuOEcy8LcbzevYbAyYOs+ZBEBcZHJtNdHbWYN
 ccqwGQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hscvya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:09:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c075c1e25so28849481cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 23:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783404546; x=1784009346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/8L/hYAqjOo/qr8iNduNRjUIW5+tdAdo4KbvZFxWsU=;
 b=JDhTuujn4aRx5zWpLYVvVghj6a4VcJ3sOCJZMJQiQpfbga2q+/ant4CdGGu64QMidp
 89QSoMq/CpIXahbeAF2cg/K4yR2jU+QHjtVwSc7+aOnKyIAefkEe7aIHlC406nbutS/r
 NC2H2I3VlY7RiN/GB2xdGYO48SqOaBZCxvE5JgLy0jotXsFP5yLp0+tHz1irwO+VYmh9
 hQAHRMgcanoawEmxE4+vmgacMrr8bTeHHyJq5S657/VdInO7BPg0HBu9KL52FZdvXLox
 2Buf39t42B4LCkavD1leQ8oKWrGR9gn28jZQRc9koqegw3nMiSOGlFsdF+kQTNrzWsFH
 /Jgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783404546; x=1784009346;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/8L/hYAqjOo/qr8iNduNRjUIW5+tdAdo4KbvZFxWsU=;
 b=BzJBrImnZSBVGIZRMljKUyvqgd6Anp8qOtt6RqiTRSVpzWKvjRm40teiT7dNnz/C2v
 idSo71qkX9aUvhGXwQySa87wzIg8HIxz3Fud4ymq2UIvyVqKpA1LJdANCX/V5O4pj7Sa
 Ghdl5TsXMgvjsr3vjgxRLialFXNLtPu6/aXKgzjiy1MURgmYC44XfNfeSn0UTrQvdqc2
 +OmAL9L76MtOg5y5ecuuXiwO0jV3ZU4zaCdJGq3ZZUGawqZa9yindcYnR90w2oIDgSev
 gQaO5DvNrf9K09tTWCAamTyfLuaN9PSWSbbA1RbZmX9eGBdzrPckYfXAaTSma4DgM6pL
 kmDw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcjbTKWqpCh7GiRNh1Jaz1xuAP14alCJMiIj2g+Uv7ZISBm+g9xiVkKgCXsxJc/jHETm0KO+hw5ujV@nongnu.org
X-Gm-Message-State: AOJu0YyamjFGqfU2Jr6OLf+sR4ZEBr5haHPgKjaSCXalXdEbGqsd4Dcn
 Yn1ZZLDIRRGlWCVA24fjBXgOIFYy6puhZOYNU3L66P/AOAm6/2YFqwphJvj5y7D0Lmf/RoeIU4l
 M4c51Q9S3kDqqDCv0G6DnBwrctQ7ieNRkSveum9k8/0rU8pTtI6JipIMqJg==
X-Gm-Gg: AfdE7cn9qLG6NMf+w3ZTHUIU2sY1EP6q7mW1aKg5fCEk0oPVW+VZQvKcE5TjfmFF9Tq
 DcFjRXd9BTHnqQRIZUhXPgrGdg9e3GByhfjUjDFQHQIBP/7wYbb9tTeuXAv/6uOU9RVT5RyzsyK
 At3QSpuwESamuBhNEiCIIEHXLD3AICwalBC45biKVifCRcqsc4mb58ciEleDfoYRt4MJuyvwzsa
 hkGu1w8WGkntVkCyYAxqLnsTLMjO7a02+uiiIsZkxDtUCogmqDJJ+7VVsvY5rVHH96hdzQYMJrn
 gOSpIKqun86MQkgm9trCnTXNPUFJgNt9hk8LVE12U1oiwLV5wLWaAYcbKU7g6mONzxdfKD/anrr
 EJhQswSsWZ5QLP59Cjn0Le871+wT/KrY6IngQlN5PEEGxVpptRdlfm7qeZ8cUdQ==
X-Received: by 2002:ac8:5c94:0:b0:51a:8c9c:7f3f with SMTP id
 d75a77b69052e-51c749159c4mr50730031cf.66.1783404546433; 
 Mon, 06 Jul 2026 23:09:06 -0700 (PDT)
X-Received: by 2002:ac8:5c94:0:b0:51a:8c9c:7f3f with SMTP id
 d75a77b69052e-51c749159c4mr50729801cf.66.1783404545959; 
 Mon, 06 Jul 2026 23:09:05 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d7801sm31511669f8f.16.2026.07.06.23.09.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 23:09:05 -0700 (PDT)
Message-ID: <c3cf704b-b052-4c22-b2c3-beeb0e1586ed@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 08:09:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/pci/pcie_doe: Check mailbox length for overflows
Content-Language: en-US
To: alistair23@gmail.com, alistair.francis@wdc.com, tangtao1634@phytium.com.cn,
 mst@redhat.com, qemu-devel@nongnu.org
References: <20260707020750.788960-1-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260707020750.788960-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: bmdAVyXPXDi91ugkyIfFy_uRxpGLbuOH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfXyHQ0Z00jweIT
 cNRPtzBokR5DIVrio7cgEPWV4nIeRhYlXXf0k3hYVk9lX5yrsEM0sIC1XqumB1F9cvR/X0RoxqW
 EYJ22tlejYPfelKcIW1d2RVl49ZzGVSN6J4spPNAc7ODIX5TIXvq8psjdkJtzX15r57/na4JFBF
 DvrSWSF5c+N/GM58QirD/vR8eSgroHu8zfwmeE79Ad8Eu8kqWrA0Kvl4QT/9qDw5rUpWWryTy5t
 m1hY0uHhXiJjx7UW5PA0aTfL5yGfxwyyMEahFjfS6jmSWBFaW/9yD8WXe+EykZnXe8JCJpHbk7t
 cLw7c6RNhG/T3feoQNHgcF0/Yap1PvVKfes7dHtd5W2G4PihNWQVq8nY3Ks8zDM/08CIIIC/V4m
 BDMjG48kzUPXE6rZhKppyrlX+zlDXt0NRxTt4n4O/4OVHczexQTIk0/JwTjrB87xhinA1SWpe/F
 pdToRaQ+m0Xil9ec20w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NiBTYWx0ZWRfX77s+2xVd/Fqw
 854UKj7eOba1Ma2AhKTv01SayMIP2P6nAsoJ+m5xz0QiyczTuzErv+IV8ztqzwh5IuCPT+kc4BT
 pUX2ZLdqTo8h7N25lU4yXaemXFBQYBI=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c9803 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: bmdAVyXPXDi91ugkyIfFy_uRxpGLbuOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070056
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

On 7/7/26 04:07, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> It was possible that a guest could overflow the `doe_cap->write_mbox`
> buffer by writing more then PCI_DOE_DW_SIZE_MAX dwords.
> `doe_cap->write_mbox_len` would continue to increment and there were no
> bounds checks on the length when offsetting into doe_cap->write_mbox.
> 
> This patch adds a check and reports a guest error if we would overflow.
> 
> On an overflow we also silenty discard the entire object as instructed
> to do in the PCIe spec when the length specified in the header
> (up to PCI_DOE_DW_SIZE_MAX dwords) doesn't match the length of the
> object.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3679
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/pci/pcie_doe.c | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

