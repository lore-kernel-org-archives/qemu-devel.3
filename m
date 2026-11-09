Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AB606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xby43k6B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A0xf26rd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQN1L-00075r-9E; Mon, 09 Nov 2026 05:54:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQN16-00075H-0R
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:54:24 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQN14-0004Ob-6C
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 05:54:23 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A99uljg3600451
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 10:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kb1lb1LVcsMnvJbi80nyHJKSjbDlscoiqA5aa895qKc=; b=Xby43k6BBVjCw1KR
 TnW+hICZLmUjTTXuy6iATeGqE7flKFgGRqqIt12sqi3u2aeJ0s5a1xi0vnljFcEA
 gO9U8R9zSapO1l/jh4AhnW38labLN403shh/eeMnlki20Lhkjd+8IdJ3Mh3AtaZY
 XF2Po3UfqjMM0ARC8e11Rfde1AiofPgIvSn1LcWZZIxTnQUrv4yOUji7wDi6/h1P
 QFcI2Zvnhs1i9JcFVTl+GKxXYSvyhFGl9gxE0bwPCZ0z80B/hhhZTZUpfCwN9UPp
 Wge2zmL74LL2tcduaMmxVCea/prcnt5KvsvbD7eC06g2nvzAWOnbQpDtIi2DDmPy
 6lOqxw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua588ngt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 10:54:17 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-980b637ed69so129691241.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 02:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794221656; x=1794826456; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kb1lb1LVcsMnvJbi80nyHJKSjbDlscoiqA5aa895qKc=;
 b=A0xf26rdrob3g8f0wpVTaa5J2lQythW+mnP7cfSgLmWEDHN7Eo192X5bO9OKaf0vRb
 +s0K1f6HO2WP0wUpal9XYhrcC5otyHO51FrpwjongyGNvMFspqw7Sn3yes1gnq2giM7+
 FkPKg2PBse7B8DkG6G423cdi0f8ZRaBuX98KqCG/of4IVmaj75b3s+6ANSnBpfxCzpZM
 nTRmJtLu3mO/+xpDoOQKEiXmI/7fP0wMM1WXHq1CQqYhPr1CI2u7o8JpPVWsOvX5pWQW
 elHUawRWbhkcnuPNwA9dV4r17LcJxZwz1A0DjUW9xhxaMoymyotSMii+FSAJ8ktVlK3w
 bdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794221656; x=1794826456;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kb1lb1LVcsMnvJbi80nyHJKSjbDlscoiqA5aa895qKc=;
 b=eSikPUt1l/wxx7+/urbZKxEPzJjgv6L4FqueZtErjpmQ71iFnVJHQiRjY4miF3fLY/
 CFNZm/PtettTkPryRe2MrsfVa96uTKloclPXAenTLgXVV2lsAD+kQwPVnomlQ9C7neYw
 BkL8xvzx7WDrIfkDm8VBkv8pPCs92junsXYf+Q7nzsw4RWxoD+JQT09GYv+xOSU6tCiJ
 8QlqadTj7GDfVJoGlyzM/R26NFKnYeCKk0t2/YyJsviMdco7+ybysujdiNmMdlsjUjzl
 A7sQjpXU8ebljj7PJ7JKeoXPVoCgvNMPWzhhgCwwKCnCvd1oxyy17h8BFnQr8GG3sP0g
 sOcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEnMhce4IU4UiQAgk05Y/KayHnvJBaV1wfsFQhF8SZ/zdt0yPU3/3wt3UbKyyZLswOXajN8yerKziYv@nongnu.org
X-Gm-Message-State: APuU4Z/BszucKW53/bN7h4H0LK8H3rptnD0S/xL+X9yMnjt9wmXbTAdi
 8YVU9QmLVbe8nbnmjOJotb3pEVUiCfHLWtmkDr+umy3TPT/Ac/ksnergjZlb+1oa6FDmmGYDcMa
 d+krFDpgLJWIKgEkhLkQfaaqk64oqt2c7QsF2hTnSTeXOAZL2U/O5MWzNmQ==
X-Gm-Gg: AYBFou3GIJcI4R9XRlOtW6GQYJRCsIE9Lp9L32Oumn3Y6PhnncbuauuOLzwBD9GSf7T
 YTI3hWVacJqywuRxx6eyf4RkNM6kAY29YlpulIYLAgqNO/RGlxnTVi//rrMWO75IBqHbsQLwjyi
 ihvvK2ECRekG9onBRjZSd2Osm7RTcxk09r3wYTdUj5ininSrmzpTccweVqaru4F/uwyb5zrfh4o
 zBux62IQ0FuhL8WtfcXx25YbAKJ05AjTOWCzH0Vi/o2V5Mc1ztsees2RtjTes3MHunTlNr9J9d7
 dXLH9FFYWmd2PaY983zJNgz8X7meenJssRm8f+rg4oRkzANJB+NY7l4brpOdPdEOSWyFJZdeJH5
 0uqlCH97y/wuLEnOm8LALS2iV43BZ7CWrfd9u/Vrh+ECB0KELp1w68N+NbRaF+lnMHropg600pt
 Qi4CiV9w==
X-Received: by 2002:a05:6102:6055:b0:7a8:2a34:432e with SMTP id
 ada2fe7eead31-7d2db0df66amr630874137.9.1794221656567; 
 Mon, 09 Nov 2026 02:54:16 -0800 (PST)
X-Received: by 2002:a05:6102:6055:b0:7a8:2a34:432e with SMTP id
 ada2fe7eead31-7d2db0df66amr630867137.9.1794221656032; 
 Mon, 09 Nov 2026 02:54:16 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-496150c6e90sm7674615f8f.2.2026.11.09.02.54.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 02:54:15 -0800 (PST)
Message-ID: <e10dc545-52bf-4418-99b3-e0fdb43de0ba@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 11:54:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/i386: move bios functions into x86-bios.c
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20261106191356.1207295-1-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106191356.1207295-1-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0MyBTYWx0ZWRfX04x/NSd0gDdT
 vnNYd6OVnNZ32VK1KbHyek3ZIBYW5SFBQidkffAWVgoKXprDrVGf/tw6Xf60gzBOQwQNfYKuJy/
 392h1R0R/hVxtbxCG/fB8mAsAS1KgYwDZ5GNeeD9+OEyjyagdaorvT6TokpYo7/ntQbu9fbLFt+
 Ke4CUfo9RTbExxAKyVVtmxKfZlXmDuWYLpZgkMhwmXf70Qv9ySz4GUdGV0EIorNDR2cn3EPoS4i
 UfIc3ckAL33eEQeK8UsMDGbdXxAxoXg25jYh7Qn24JSDmyMfTGdKIB30Ir+c+cxYEEH5j2w3AJs
 INHaFeblsYt7QzqFu9/dUABMxNqvikoJH/8SGaVzckB+Vu1JHB4yoUFbFEM2o9xw2yeehQVqKBM
 yngYrnoE5taRy6eNroYQq19yeNJTLQXFp9cGj/l821qCadLY3sM6G4lM4F9AC/BU+YSFrF7bA6H
 0nQ/VUk7j3zluTKAMFg==
X-Proofpoint-ORIG-GUID: CIACzypKTyUAGOB9Za8JfNb5MUZp4duU
X-Proofpoint-GUID: CIACzypKTyUAGOB9Za8JfNb5MUZp4duU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0MyBTYWx0ZWRfXyQuZU9XDsNhg
 w5l6tr3qouQ+9U2f5v2VXcOyPG87vk215ze+5yMGHl91921WYXapvalHvWUGJJBqaLqzoBibCmI
 qZmRm1eESfkORw+uhEhJSGA/jrXh+lg=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af1a659 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=VWpyO1KW-ja7qVc6LdkA:9
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090043
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

On 6/11/26 20:13, John Snow wrote:
> Currently, these functions are located in x86-common.c. However, when
> configuring QEMU with `--without-default-devices`, we encounter a
> linking error at final assembly time where these functions cannot be
> located.
> 
> Split these functions out into a new x86-bios.c module to allow
> defaultless compilations of x86_64 to succeed.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   hw/i386/x86-bios.c   | 143 +++++++++++++++++++++++++++++++++++++++++++
>   hw/i386/x86-common.c | 125 -------------------------------------
>   hw/i386/x86.c        |   1 -
>   hw/i386/meson.build  |   1 +
>   4 files changed, 144 insertions(+), 126 deletions(-)
>   create mode 100644 hw/i386/x86-bios.c

What are the changes since v1, do I need to review again or
can you keep my R-b tag?
https://lore.kernel.org/qemu-devel/c76a70ea-f788-47a6-8a0e-229694e6c571@oss.qualcomm.com/

