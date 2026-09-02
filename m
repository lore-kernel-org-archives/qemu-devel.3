Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60421C61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1sa5-00044N-MP; Wed, 02 Sep 2026 17:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sa5-000447-1T
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:33:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1sa3-0005NI-EP
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 17:33:16 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682KHRv23044795
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 21:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1AzF/G6MbNuoFX4LgFQThFcdelHfAq7h2AQYlrfTcPM=; b=V7L/883XSeo1ocHB
 d704aqK3oSs7cKVLHuTAnYJHUIinQlvaSr1TSQbto0Of/FwgDZ2E5JjMvF1WHdW0
 9TWeBbz/lAq8YZBrVzZsd2JVBkBrJ0xqdvbMWszBxqw1D11+15IjA3l3qBzvI7m/
 eZqKZQmp5ofxnfsllIhtZeiG36S4ObSv9HlaXbBzCEgUxkrJS/3BSBA3/WMIAzXi
 zJ44UxA4KgaOaTSUWTkklcWFW2zmKy9eDgTa9I2ipiKvlenIYJbRfi7YzayYzHCI
 UNtqaL58Pfg+Tw8O62usz/CB8okz2yTAjaFpiTmhr0lQQqpQ8j1NkwCA0eZGVn8q
 Xls2KQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy363q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 21:33:14 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93917f4ccb4so231191085a.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788384793; x=1788989593; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1AzF/G6MbNuoFX4LgFQThFcdelHfAq7h2AQYlrfTcPM=;
 b=CUXLNmqejN//rRzx+2Jkx9GdpMCABBW9PuxQo+UxAD2uRT9S2/FEPLt0e4ph9jCQY2
 qMUKNQrPIMuz9crDMbo4WlkfaSkuCdeEyPAKuT/+tLRbNiRnWejjL4ySTFRhSfDJJMja
 8PTZf9gyn0+Yn7t7HEq9LapWhorGDKyKkkQr7IkzWoDgcMCaUZNama6xcGp4lwtwqqH9
 zuPBVCEQ9RpaoV1bjJtayEPvMLenRRLrAEnHjYwHq1kgnl58kGF1yZrqQUH8IkVmwZoY
 1mK6B2pusF6/TNcG2xeROSP9GYb66A62cugBqj2WitFrCvIT00myeP19sDqIA7UFy7JG
 pwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788384793; x=1788989593;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1AzF/G6MbNuoFX4LgFQThFcdelHfAq7h2AQYlrfTcPM=;
 b=cFNCQPSIaRl6gLPQ2rEYGateZHZQSA+wgd1Nd2c829OZivYd6/di9RvTuRp9iHNl4V
 2PF9uIOR2+vUSr/g7t3rL9CoridE6kJ5GLh3q81Hnqu9MzBU0T+BcnEwnY6Dr0ktIiTa
 HLkx2MbAXkLUeqLlbKdmcr9o5cDr0YZWHQ8tgRFAEvMYp8arhoySvyXhCPxGq2A3Ym7k
 1xErJVjXUxnm3MJk24qnoFej5lH/mJB3trtFitWLoZzXxuJyvLlnAxDM+quhtbWoVnwk
 St8zt2ukfrJQZ+RXAeLUs7aRoRSuLiIWg5P3tF3CYLJy1nrm/Wod1Hrtn6aDE2As7r0H
 kVEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzoSHjZIuoWHsj1vwtB9lDN6Ixz9vOnbGC7XTGsR7xmRqrlpRuwvBi5DWvsXcck3QMxFlPX+SdaqRo@nongnu.org
X-Gm-Message-State: AFuF++l9sVULMcDNTX5u3dToyxCAZaO7AaFfIss/EYtyGQWb04KzT3Xu
 d3+Ig+USP0CFp1qnWJw3QFQUd5zFmDqPi+98aH6EtF9YKAupaYEdmrBLbjhsat0wZjJjQ0fCIbB
 ceS9BDYrktk1OoxgqnC4WEZRNZU8Ue4P0n5rvo67DMiKziKHLktG7sLVIdQ==
X-Gm-Gg: AYBFou23UPHGxXYMHoIsmc9cIMCVs+qQyqF8CTq8+ZIQ38Bu4uKItVN4Z/QhhAI78a1
 sR56gC5qw/kVgMhKeRqJ7PJSJUkDbshAoNJl5Eth0ihGKqr1GKBO7hJH8Y3Kb3Hm0kLwWPdkYCM
 Ndz89nrI983yx2PeQmnw7BB07bEW1XUsXFz04GO9mnFNM1bGyo9SdhNO5ShNNxalcT+M7Cfc7/B
 V9VHdYdr4AU3DQAmnDWDaB51nfzNarcxp6ENB0TNg8dhdlOB5Bsiirco8Kevofk/XRrfIJLAuez
 TieAMU45Tje7tVYk2RHDwtzSxa9QIZobMezC0S+Q7tzJWZjn0Rc1aw+DIgCx9AW/kqCdtmN1P3i
 zs3UsIt25EU91yD/An4mvhfrbVw/J37GDPw==
X-Received: by 2002:a05:620a:47b6:b0:936:576e:227b with SMTP id
 af79cd13be357-93960f3c98amr816836785a.24.1788384793502; 
 Wed, 02 Sep 2026 14:33:13 -0700 (PDT)
X-Received: by 2002:a05:620a:47b6:b0:936:576e:227b with SMTP id
 af79cd13be357-93960f3c98amr816832185a.24.1788384793023; 
 Wed, 02 Sep 2026 14:33:13 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea5b4sm9107237f8f.27.2026.09.02.14.33.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 14:33:11 -0700 (PDT)
Message-ID: <97aa231e-a3b9-4558-bf62-248f0a751c10@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 23:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] hw/riscv/k230: Attach a standard SPI NOR flash
Content-Language: en-US
To: Kangjie Huang <flamboyant.h.01@gmail.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Portia Stephens <portias@oss.tenstorrent.com>,
 Bin Meng <bmeng.cn@gmail.com>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
References: <20260831-t_v4_spi_patch-v4-0-370d416f26b5@gmail.com>
 <20260831-t_v4_spi_patch-v4-3-370d416f26b5@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260831-t_v4_spi_patch-v4-3-370d416f26b5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a98961a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=VD9ueEoDFE-sBf3Wn70A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ZObpABlMLOulYG-T_rAsruMd8RIsgJz-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE5MCBTYWx0ZWRfXxHzfKzgLB0OD
 Komo4TuyrpOacz3Gj7ajPKE0p/0aj1u0aAJ680Jne5A/BIvyaqe4pswX6dnZRl2dRRHwKL1nf3L
 lFkjUMve1S7dmqjka3/jM/F+Iszbsy8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE5MCBTYWx0ZWRfX9+7POx8pPVvz
 BZ5rJpwKkdxRd9Xa2Rjyeh+7uk0hXk5InJ3ZQFk5SCidML7zNYTFZuVhhcAZb0izMiC7/NfrS/W
 q1QNoFrMLCp2f0qzZz0YX9ay/qJLl3oxgMSBNGmEAL+mfZI3Wt/AhsbfJzy0jnqRTmcCkxSwUcG
 VuiW9J+YmYr8QrLfuS/ppMgDYgxXiUM1Umjf7kASLcXFWx7MdF6cVff0bPutSZ4OVrJNBYgbt9P
 nZK6UV+PTBj/S/APwn9CwJBnU/2VuZl26ZAmfIfCx6WPS3rQ54mipErPFEwoNfptbJFmdFB08Sn
 5dca0aKFJq9LqkbTYes7gzQzI+g26Sf4yn+iYG8E9tFo4s0rZ+Gqoh+m6d1ZRwIq2jwuPtTaZJz
 gignbFtV1g/m0YxmYl2SPjTJ8Igk5WBO/uRsoKhk83HMWQLmw52kU/U8BI3mrw0ktWxk1o5gWJb
 w1K4ITfrXgwQC0bl+kg==
X-Proofpoint-ORIG-GUID: ZObpABlMLOulYG-T_rAsruMd8RIsgJz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020190
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

Hi Kangjie,

On 31/8/26 13:11, Kangjie Huang wrote:
> Add an optional `spi-flash` machine property and attach the selected
> M25P80-compatible flash device to logical spi0 CS0.
> 
> Add qtests covering the Standard 1-1-1 JEDEC ID read, a read at a fixed
> address, and an EEPROM read with a multi-byte command and a non-zero
> address.
> 
> Standard 1-1-1 transfers against the attached flash were also manually
> verified through the U-Boot and Linux SPI paths of the K230 SDK.
> 
> Enhanced SPI, IDMA and XIP paths are out of scope for this series.
> 
> Signed-off-by: Kangjie Huang <flamboyant.h.01@gmail.com>
> ---
>   docs/system/riscv/k230.rst      |  1 +
>   hw/riscv/Kconfig                |  1 +
>   hw/riscv/k230.c                 | 66 ++++++++++++++++++++++++++++++++
>   include/hw/riscv/k230.h         |  2 +
>   tests/qtest/k230-dwc-ssi-test.c | 83 +++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 153 insertions(+)


> diff --git a/tests/qtest/k230-dwc-ssi-test.c b/tests/qtest/k230-dwc-ssi-test.c
> index 42e3190cb4..a0ec580679 100644
> --- a/tests/qtest/k230-dwc-ssi-test.c
> +++ b/tests/qtest/k230-dwc-ssi-test.c
> @@ -80,6 +80,7 @@
>   #define K230_SSI_XIP_MODE_BITS          0x0fc
>   
>   #define K230_SSI_FIFO_DEPTH             256
> +#define K230_SSI_FLASH_SIZE              MiB

Less confuse as:

   #define K230_SSI_FLASH_SIZE              (1 * MiB)

