Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EEFC982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8eMt-0007f3-7W; Mon, 21 Sep 2026 09:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eMs-0007dh-9N
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:47:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8eMq-0004Aq-NY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 09:47:38 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAeBIc419384
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NA9TAMRiCnoCA/GoQbga6IW1D7NoDZP/q+a7n6PcWuM=; b=kZgNoN9O62v46srK
 GzPn69HONSHHgAAkBFZupDIDKtKfPr1rnXdUbS8VWF45P6z7PT++eHU7bt83d3TJ
 go3So+P7Naln1cSUHQE2BW1LZqhzA+9xJMCqOLKHK5nMs3N5OC5DO8V39x6f/FN9
 wC3KNcM2lDQoRd1l5cUJIWEmspkqpLZ91sDW+p92nh7q7wdB4FxhqflcNlmQu/Zr
 oDRMWwY5nkwCikUVF//I/YovYTOgkd10ri4oH/sbif1U8DimJGl+P+tqJnl2Oapg
 EmgiJI6oNesXvRkmew+egprr/No2n9e0FlfElaOx80yDXM2s9jVgnpfJjjT5st05
 ET/fRw==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtyxq9jb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 13:47:34 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5c990236604so480855e0c.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 06:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789998454; x=1790603254; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NA9TAMRiCnoCA/GoQbga6IW1D7NoDZP/q+a7n6PcWuM=;
 b=bsCxl1LSxUys/Op0n8qwx5iqziTlwhxu9Nwlbk4MpmFxEoDnMAe0c91wdrCdoL8R1B
 X/unJf5wm+/tbvWZh1jnvjnIbPHzVPMXEsL/aP0IA24Og1hmdDiBwIcJtbMoHsPhhzvD
 uLGMULs89ODeizwIP7315qCoLfcSSNpbpT5CLY+14DYQ2UmrJHRL8wJZfmlQu+1MOvwb
 xyRW97VJ8FJvSeLNi5+IdnQtQFOfzCpX4tmnloqXVMWjSC5CIg36xiVnQkeRYoixclxq
 Y9V9O+OpHHG6GtaOMaUjTg/Qy/KNaihCUJb/lg+cdLkPNY/vL7PHzxFkBCUaW6UK9W2J
 QfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789998454; x=1790603254;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NA9TAMRiCnoCA/GoQbga6IW1D7NoDZP/q+a7n6PcWuM=;
 b=zJ6suYty/yXTG0p+smNq1rShtEFJXzLTK7zgBK9UQiKqc8BApH2bCYiTAOtdQwqSvq
 Vix7zLSFWHvd075uYWJ77zWAvmMiQZuoubNptrcnvjqI4gfffwJJrvUQ116Z2iizc44n
 JR7sYlM7aSt3FaZmntODVsIpvHgNZXUx7KwbZGrUnV/1aPCT0aXy3Uiwrgquim48yESA
 NiSL9to17o8ETErr2f0o2BbWivHKsAg4IiGiVQKobfFpuF7ubsk4z1Nwm4lW3pFBvbBU
 Qzsu2O6XTrRYplfiwl02pLVZ0H0OkVR4pOWKS9gd6QTV2hKaCjZ2NTZpKgYoyieheR5A
 mTDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfsys7Ibx+MHXeDfFzHPeL/Gmr6Ohvogd98rDAjvh7oS8EE1wEhrzYvmBawk0tkw6ACRwKlZjDr+9k@nongnu.org
X-Gm-Message-State: AFuF++mIkJYoUEDID/EdIP099pxKdhfwm5K5T4FKyaPwcfS0JbYbXUZ/
 MPeNKVDQWKkyTjWIJkhSy5xUjFERyX5Dr6LxecMx28jB3XVB4nIZtEUoyt+gcn2IAqL2iVEuYEh
 QWNta+b0b/4iGt3Mt/PWnJXApMoya6m+tsb9oTqjDTPPspiWxM7sqDDzwIA==
X-Gm-Gg: AYBFou3DlHBDozebU9Zyvzzks7WJ5yix1R4CKGJZ7OEBqXkJrwNrBbTIfABmTVS0W0Z
 JxZfq92868s1Gei/R35Rnt8wr4r4m9PWQxmEdpvLEy519ar0fQlKJ5wMZZhRHA7Xb70aUNJcIv5
 BjPcp9fbbmWsOsv2AcIdy5snZKledGQ/hMTFqsJeo5eQCB/yW/Ug7ZKWJ/TWlN0Hn/iWQdsKRmr
 aa2ajVHHkBZOrJQ/oNffM9Hu4y56niW5Odyi7zqLNT+XCePPEhOllFqS+wzkJwHAvfGjl6W0SbD
 ziQuIIGc5QhNmMZc6p+/CE3RsDLmLYGSYwTJYqzl/UtDmhIJhBvCW60MI6X1ASEJK13wbdkoekV
 x2qwZxNUaXfS2vcLYC/6i
X-Received: by 2002:a05:6122:330a:b0:5c9:c60e:f4b4 with SMTP id
 71dfb90a1353d-5c9c60ef7afmr3125599e0c.18.1789998453587; 
 Mon, 21 Sep 2026 06:47:33 -0700 (PDT)
X-Received: by 2002:a05:6122:330a:b0:5c9:c60e:f4b4 with SMTP id
 71dfb90a1353d-5c9c60ef7afmr3125557e0c.18.1789998452997; 
 Mon, 21 Sep 2026 06:47:32 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487244608a3sm22036353f8f.8.2026.09.21.06.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 06:47:32 -0700 (PDT)
Message-ID: <3a993ae5-39a8-4597-8090-13cca88e181e@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] target-info: Introduce target_riscv32
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com
References: <20260918-hw-riscv-cpu-int-v5-0-f98c5a244636@rev.ng>
 <20260918-hw-riscv-cpu-int-v5-9-f98c5a244636@rev.ng>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260918-hw-riscv-cpu-int-v5-9-f98c5a244636@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jwPI4urBl9EKBJAaPTZJmae1-WjM5K9V
X-Proofpoint-ORIG-GUID: jwPI4urBl9EKBJAaPTZJmae1-WjM5K9V
X-Authority-Analysis: v=2.4 cv=OtraWC/t c=1 sm=1 tr=0 ts=6ab13576 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=btlkdZlGvBFwkIDmIYSHuA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfXz85OvPHeDB+b
 otS8UyXl/IJwKJoXsiKe6MDNGxsuQKXDe03jNGBkt67yYkNcwC05lqYoaIhYUVV8WYUBHZ+D+C8
 rHCNs4wa847NUqrhjVA2y9ZfSnN/QXfa8vaeVOZLbZGVu5dqJqvndxucQ6825I/kZwyARYLs0nu
 eHT/pdikVlXDZKYT/NP3rfcvOgDu+EAjSA4uTGJ/ajJoZnClmI38URq0GFXcpiesbzi/+X+hXDO
 t0qUgXFazE9mPWkmG3/Ay5ir9E1WUsTW4SX/tsk7zk5UU7r9FJezYsyErSuNw03Qso1K0ql/BQ3
 qLCfw6S7c1YOXjs9qFuznni/9iF+DDeurVg4BRS7NwFH1oRRdDadzJPD4GQ1iK6UwlQJwjzG+R7
 yaLmrKQdZtb0oIqhPRmgg9oBQagJtpFOyz0c12LGEyCVLLLzYBT6pP/EHBCdqyafTPnHqm+fAlz
 De/o0HncyVl+c1UzOEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDIwMCBTYWx0ZWRfX18K9K0f+uRtW
 PO9ABvFmM6mF38v8tHKPpjzTx156unipA5LKVzP0tTBBvxs1NBJT+SWEPdixBsmjo7KLEymVt8K
 D65d7uLFV/HiqbFaMW4uu598sXhtqXU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210200
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

On 2026-09-18 0:05, Anton Johansson wrote:
> Will be used in the following commit to filter machines using
> TypeInfo::is_available, so a simple !target_riscv64() is not sufficient.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

