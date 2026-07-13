Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8FEC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOPX-0005TN-Oy; Mon, 13 Jul 2026 17:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOPV-0005T7-Ug
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:41:57 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOPU-0002yj-88
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:41:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9Q4w2256830
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Nw0Re6ybYmhcZlR6aRDV6iPkXzUArsolrWZWMDxCg6Q=; b=R2y2/39u/QNEIwWD
 vJGJoks3GIhDB2k4j9KLVoh9PDgiFZLrHGtkNSpNXEHwwLSAEwcl2HyrRnnDcbdQ
 EaGrgRUACI8H2m96l0c22ajm6HbXDr73laJV2h6k2uiKni1SPRuCdaNtoQnsY7wd
 G/rhXOJjUOR44zm/7un9IJyKHkEHrgs0rmFHFts9XxC5KSWXTgLNxcnm2n7/iVTu
 em362ZVEYAJG954O4bSJBJ8ZMTlxNJnXmyO8QmmLV0B4Kkgnt26+c8y26uI/ayZZ
 uHO40v7V45OQ4UMGkYSKjfP3dlBiD2mw/1udFvZDUgNPvSvdizTGgPOZzdZPAbXH
 3Sv9eg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk9tnf2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:41:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3812b0c6f23so263512a91.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783978913; x=1784583713; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nw0Re6ybYmhcZlR6aRDV6iPkXzUArsolrWZWMDxCg6Q=;
 b=F6jkc6VT/8qfYWyJLUF3TPhIf+LPiNATb5VrYaPNcJ/ThJct7h4k8qV9zRWaUU7X1C
 IB+ixz40wCNkBWjbcYH0HFyv2W/MlZUuKQJ/rbYGYa4ZZmOWE0J7HPD+lsQYEIs5Bok4
 oJraTrP/osGa1wWe6qb9vxfTWq/qCsg3NjIbFTaXCzeUPN6cXvCGyive0BtbtDVLZCik
 IZMgEn2GiPb2Tkx7pJavzSPaLYJJAo0Z2cp2fRVJrzRLZjz7knt02lNxuCneQ78xXWm3
 NxDktdr2Mht+jRj9f3b6tcFbgEDHUciFaMAuimSq9QpVof0TQBs+QZoPgJGEk49G6ZBt
 mVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783978913; x=1784583713;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nw0Re6ybYmhcZlR6aRDV6iPkXzUArsolrWZWMDxCg6Q=;
 b=dJ9cRaJfzfid2PrgUu/kEi0xsu3vHKPWTH1Hq2d05LAtsSoMZj/hDnOZpVevbZiRJn
 8Sz4h2ZZw9fZ1U9gUNWZRLL24dWP7pdqn+mWue6iPxLkbW7IQPU2evobSLKStf+542Mt
 oRzrU9oUlb+djB3Bun/z4REbuHn19dIXSNunMQ1LeZpZJHHb7WEeVGghS5sC0QwNTZL4
 AWk6hj+xRMuKt2zpMkBMjt0dnVS+6lSLwxiKufNfSsW4esM+IcAU17gUPwWm3rVlm+6r
 zG8VAgEiFddF+lS0WO9+6WIR9M0HgrrSy+qM5sdY5rAV0CAnR9t4bF0cbOkjlfBKpjNr
 f5UA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo/5gmp0BxoNT3uO7Y4CpTEami2dFbl8QBe10jyjObm8lDok2EBOJWmG6B6pzlyR/8DJaq04G24Gz4@nongnu.org
X-Gm-Message-State: AOJu0YxVFv+liiCdjeVH2HNCMyFEs3d2cHrt+ZXOR3a0r03I6SLwVdBL
 CPqxQZD1sQ2yFolTmrijEzHmOUWD7rSRCtgQyV2L7sTcll80Q3ZWuJw/hUYdcMlw2qeNW+3YR/9
 ptdbwnH5cjWuIGZtKZOuruLhbVnD0d9uNHa3LN0/SOTB398knR+gEhhrX1w==
X-Gm-Gg: AfdE7ckamRP57PjN7ijPmbQYXoiFaCCGlhUX/ECTRQCy0m9jYkopTwd2M6P9O2GMjJe
 aO04shVGksIvQxdZbqzmkbPucLj/7rmlB2iFmviXW19IyNRpHOqxBApAMd3jUhWke+w8GhOhk/G
 ZML64WoDaOmiQioCE3umXU8EZ1JsmDv8MB2uil3kIxQKwfmguB0nsva+sfn6A6HZbDg2QBN6r+U
 pSPflkI/DDNh/56a3thwyRdHmnpkxCNr8tyFKPMEwcBLxjifj1MqRa58PN4vsXCKhxbJCBnH4LV
 4lIaFroTDZeRIdKSZVRAdCxGkAHv1OBBC7IrIRY/aHfkWmlQjyud0HbLhL9/weh7DbVu1ujgUoJ
 EU+28UIRsLhr5FhsiCKfTFIplS7H92XdDhHpgXtkGzAEHeDbLicqVU1kq8LFOuYmJ4c1l5Q7O+U
 ReKEM=
X-Received: by 2002:a05:6a21:6e0c:b0:3c1:85d:fa22 with SMTP id
 adf61e73a8af0-3c110bcce4emr10728153637.65.1783978913479; 
 Mon, 13 Jul 2026 14:41:53 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e0c:b0:3c1:85d:fa22 with SMTP id
 adf61e73a8af0-3c110bcce4emr10728130637.65.1783978913006; 
 Mon, 13 Jul 2026 14:41:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ba45b7049sm7282839c88.12.2026.07.13.14.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 14:41:52 -0700 (PDT)
Message-ID: <8aa04066-49a1-4053-9407-2403a3b368d7@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:41:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/14] target/hexagon: fix get_phys_addr_debug with
 in-page offset
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <dd52bfe14af72beffce026a67e930b68dd6a67e7.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <dd52bfe14af72beffce026a67e930b68dd6a67e7.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyMiBTYWx0ZWRfX3KQW6QgwgF8r
 WlINiDewPJncNBxVgreXw2tT4wDyRrzgdP9c5rlUE5pHryxFHTTQsMdEaYxz51Zn7rbiL6cwaIQ
 aLK8iehKed16DXw5AtA7Atb1ZrEVbGrbb/i8ykhKr+BRpv7Q8pMVRHFi98f3EAAJgNoW+znR/6d
 E63cJikACXXGaw9g3odc9wzcxc0y5RgYmLT3HOG0jeZwyVZbob/W0nBvIy9093N1lSusLC50z6z
 e1mjEZujKq/hf3oH9G4tQCo8/bXv5dLTfL4SxR8mvRsTmMMnAbhCCUCTsLRZ9uNTpfMhtGhhPFH
 X5Y4xNHoYcOfEaTefC46VmH3rDj6hrz/amt7qnf07eDX5nkCqMe4oyGV9Wwl1SxTMUa6oOgD3Em
 2qaqZ5Qd7YdLY5xS1z5IRXwIi9sC5IASBlXEZjsmhBmLGhQqGry2nno//i5ZyBtbDSxC5Vlho8A
 ScAyf+9GuUdvAelwg6Q==
X-Proofpoint-ORIG-GUID: iueKvrAxfpVav5BsgkbhKKkEcUUQsycx
X-Authority-Analysis: v=2.4 cv=UMHt2ify c=1 sm=1 tr=0 ts=6a555ba2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=a7JpWODm79vIuW5QHDsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: iueKvrAxfpVav5BsgkbhKKkEcUUQsycx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyMiBTYWx0ZWRfX94efToUUulEM
 xv+pIfSJpKcr6ZUlpBMNV3daBc1Y0LgpU638uhoyq32UAlwLb2/FN0Jsf1O/MPK+BtQONYUR7U+
 Eu2kXLm3g38N5LOvAfY2mZf8++n1IgM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130222
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> As documented:
> 
>      * @get_phys_addr_debug: Callback for obtaining a physical address.
>      * This must be able to handle a non-page-aligned address, and will
>      * return the physical address corresponding to that address.
> 
> When MMU is enabled, hexagon_cpu_get_phys_addr_debug() returns the
> physical address page-aligned, not corrected to reflect the exact byte
> the virtual addr maps to within the page. Let's fix that. The
> MMU-disabled case is already correct.
> 
> This would break semihosting argument reads when it is added for Hexagon.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

