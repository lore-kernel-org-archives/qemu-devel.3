Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22843CC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGZmN-0007D1-6e; Tue, 13 Oct 2026 06:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZmG-0007CB-4f
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:30:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGZmE-0003HW-76
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 06:30:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D901el791192
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jpjxnfJAkJDYym8FzQWYz1Hf94IVqWFhGR+5oGS/Snk=; b=IlsDuvirKzeU5Ram
 f+6nFrzyMDnKeGxU41n+UA5rSeYIMAX3vNabVK4TlWhoRalniHKyUUu6SXffQRof
 bTstcU1nI+RotGV4n4vmneLh0msu5ynGjI+Fd8BmPhF+QFg5D+n4vqMyqLAhgZTi
 PfzIzJSV+n0VqaodHn5fBnLSw0gjfy7LiLfxUbmm2NJL7yZwnvWEbGravRSyfPBt
 ZhEdWH5yiUbCQ5NhYP453q4/TbPaOU0EyMbZE3bXx9KOd4OsdhSkvqB2E8x/jCVM
 cO9o01zI9PQowoWeXasD3joR1O1EmCa3EuP3/LvMhO8ltkWcdluE/WvN5aDQ8eWa
 OD0uJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hmjrcxv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 10:30:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ea8067974so718791885a.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791887432; x=1792492232; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jpjxnfJAkJDYym8FzQWYz1Hf94IVqWFhGR+5oGS/Snk=;
 b=bT4n6zSq0vbALrqwpu/GzqM0cn7lHyV+nC7dkUKUDu9UIMLBKhSiVOynTzuAf7iMPx
 wFYxihAQJWROrXxJQLkwva8nfmkxaSwnZv4stV5xn6w1cKihJl1kyowVj/pJKVIRq4r+
 cO6nFBXygqC6hSB5+jNASZcvM75AqnGNPHt6/C7gau5+ioJM4FdE5j2rU3n4yZ2YGv+2
 +8Dj2AlrajwoP2v4obP7Dj3/3AUuQw2r+765pv5N899pKhGQEGNhG5myljUEBng4ONkW
 5ot0UpKyReTxac7NYWYMTcEDIsey+hhAX7cKPommqJXhKZQ6n3JplNYe0RGXByoXpdrS
 9ouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791887432; x=1792492232;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jpjxnfJAkJDYym8FzQWYz1Hf94IVqWFhGR+5oGS/Snk=;
 b=0ga2TlxJ0rDWOaDsDPXa8VbjsVbjyCvw5gdZkA9oPqID+M+wUFptPaiQ5ddFQHgwxs
 4YhRUrP90Z/R/lgJYSD/nUX373Okq9r7dNYGc42X4Hm2Q0lcgGu9DUM8okiJJXez8JHV
 1Ce6UXpBD9zcAFhRS7Hd8tiJHt8WOk2Y/1g6VQnlbq5+kYPoxmwaOn48awmwMusvZH4T
 2qorHZm/bKBDTphJsDwFxXSly9vI/HK1UocD1FYGJIF4xvvvWqKu9nWulFYD0sRT+42R
 JKg6Kq2lRtINcAGPXpHA5VFOV0g89SSLpPDGa3J0DzMFF4fwbG8TF+maij1XIfvS4I0W
 FFEA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVL/P55RuERpUo2DKx2kPfV1B2EvMPOMYUcOMtew2hsPUxLGad8Hz55eJN2tTyEZgf04AFbqhcJG74@nongnu.org
X-Gm-Message-State: AFq9FYIuF5zpXROCLzcUlgMx0JslxC/qWm51PEDqbOR0tOmuVTUopebQ
 1AX72MMbFGmb2/mW+6YbUWaCrO8ogiPMutoiBlSCTm5IbYxQj4i0h9zyspXWBDEZDFKxjokfazN
 e7nVOTbiF6xWD7R1ONlADJxHsVFvf8/bZjELZg87T83wdo0fCLTOHbeFcJafKQUHYrKA4
X-Gm-Gg: AYBFou3wDcv3T+/yW7gLEp3zNhRicV9v8h2n4mtBmhU5xVLmJOyg40x7lZ5hlRUVqBS
 VHLVoObtnavDO24EAB8GEXUYPQYOUZPtgX/YYw+5CcRRtNIJ75u2oWVjSgMBf7G9FaHevgd5UO+
 dD4kInqWQsBbE4X9Cr/UG/fnXnCMP4lQ4LUf8hDL0lagqWtpyvYHfVlIgs0XujpRgQNxEeQBw7q
 QjFs09S/zBkuheEFMy04haKnoGChvx8Q4TYgpkVO/4dBWUt+crnRdolcDOMZvy1FmGsXCF4TZCd
 63v7PUfF1ki+DrahHEr+bY2Ajiq5jCpQ7Mq2AIJPEXUZ4xqaJt/kVHse/I1iw11EoedwA2viiB3
 BMg8KXiyimUVBJgNGi7e6+yvh62WWGb8rKw==
X-Received: by 2002:a05:620a:2947:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-93ebd279c98mr1959687685a.47.1791887431897; 
 Tue, 13 Oct 2026 03:30:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2947:b0:93b:ef24:bc8c with SMTP id
 af79cd13be357-93ebd279c98mr1959682385a.47.1791887431307; 
 Tue, 13 Oct 2026 03:30:31 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a198c80cb3sm168748515e9.3.2026.10.13.03.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 03:30:30 -0700 (PDT)
Message-ID: <a014937c-a647-400c-8dba-d4310f865a2f@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 12:30:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/86] hw/intc/arm_gicv5: Relax QEMU_GICV5_MIN_LPI_ID_BITS
 to 0
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261013083933.1024405-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX4ZfUVOT740dM
 gDtjIGB1058YpRaXGegy/d0rXgdRxsM1O904roXUYknbzhv3FJU+37MjzIb1d9oQcCDqD/UeJa+
 qup99BHT0cGIis6/Q5niC9ojq5Vx5lc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfXynO9yiClDaS5
 nZlPFuues7srJh4PWv/wsi2HHpnJI6giF6YVsF3xDLBTMyzPSXSZdQ3ZpwW717Ntk4D6P5LHObH
 wJp76xQnZngH/L61y86BQ6ZSo45wBlQkx0D2lQXssytuSsNOPF+ShGgo4NxzarMlQkg8mnrd3uJ
 w8g5t9weUanNpj2dTxGco7Vev3KaGRm9sOCi85OmElVjs/UlOPWfrLaqdKZj1pY1etZDMtlwYfT
 QPml7PVjxk+J/A9jb/oTcpBzIAc9KL8q/E70kY8g98D09O0w+yire0X3iA18qrvXCgLZjqEQYW7
 os1pku5ztApM4bgB8eQfaoDyIC2N9QFvTX4oBB2z6spbSI8RJbNR/fjXWBlL//3ZmsfxDu8AUlW
 KNOu3G59H43Y9Z7J2hOss+KQRwT4YkTRjM8mD4egWaO8qx5KjzkSbFm3LgM82EPr5xlgU3K37iS
 MzhYebKmZWlGpN1LjDw==
X-Proofpoint-ORIG-GUID: F7WPWAn9OI_Jn4BXKb525uqiqmHAx9S7
X-Authority-Analysis: v=2.4 cv=O5+sLx9W c=1 sm=1 tr=0 ts=6ace0848 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=8L6ZMB3pTTj5EbQMzgwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: F7WPWAn9OI_Jn4BXKb525uqiqmHAx9S7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130041
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

On 13/10/26 10:38, Peter Maydell wrote:
> The GICv5 specification allows implementations to declare a
> MIN_LPI_ID_BITS value in IST_IDR2, which specifies the minimum number
> of supported LPIs which can be configured (both for physical LPIs and
> for virtual LPIs in VMs).  It also notes (I_ZKLJR) that it doesn't
> expect most hardware implementations to require a minimum numberof
> LPI ID bits, and that this is mostly useful for the virtual IRS that
> a hypervisor might expose to a guest.
> 
> QEMU generally prefers to offer the guest the highest-flexibility
> setting when it comes to this kind of IMPDEF value, so for instance
> we set our supported ID and IAFFID bit size to the maximum the spec
> permits.  Since this value is a minimum rather than a maximum,
> "highest-flexibility" means allowing the guest to configure a very
> small LPI range if it wants to.  Our current setting of 14 for
> QEMU_GICV5_MIN_LPI_ID_BITS is the least-flexible the architecture
> permits and requires that guests always configure large LPI ranges.
> 
> Set QEMU_GICV5_MIN_LPI_ID_BITS to 0, as the spec suggests real
> hardware would.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/intc/arm_gicv5_common.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Still valid with A.a release.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

