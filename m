Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C688CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP0e-0002ys-VG; Thu, 01 Oct 2026 18:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP0d-0002vu-Da
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP0b-0003Cx-Qc
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:11 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsR0O2267818
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7n8eiZT0moyKyUk4kNfsl+2TaeH6oGKZxKYcMFmSniI=; b=Pvy8VZJtzxdvqi0r
 vqFh6rGa093HfltjBp7MNeEZMAe8XI8aQ/uPa4URuwW5uge7vdLXuxb8+i680gfM
 3VX+kb7UKZeOSKrRrBGFzowSa0awv4awl4rTBddfLtRCso+dCEj6/fUjDa5n++Sh
 A1gUUIkRJvxl6maqog0SCajIxP0jY6xv9TVrlpoFlCmbASb0d4td74sXdV7jqzmg
 Q0NdYJf7ps8n0NjuHyELI6gPQ9JRPfrJL3iv7/FqqR0H1FU4ALY0d6gFPIzlo1Z5
 ZZVOq3sqle9DPQAdGGJihJ1bjbzvXB2WQmBRLEFvJ48Dcxty43EcRA2FxqxMF4Uy
 KkFrUw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvqa4uv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:12:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34afa104860so4691314eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892727; x=1791497527; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7n8eiZT0moyKyUk4kNfsl+2TaeH6oGKZxKYcMFmSniI=;
 b=PSIXr/zs1UjBWGgUCOr0DggntO/ncNKbeRAMo9zVYisVYvq53nfvMqZIlComS23Tui
 S/o2xOOOJ/S4j9mMt60SENSpvievDfTSTCJx+fJ9OtxFq3SRbDY3umH7wsMrYv592a65
 oTfP2vEouhGsD0CDVwg3Ex7RlldOpAZahdxHJf303ceLN+PEFzkOAucfO4Mzi4A74yto
 q9F1BkG3qU+POtc0X743gpqPwcC/KHTWU6Q0HJGt9nsjMj8rWYP0v4fET9/x8eyVQsCN
 W/JtZi2YYGWz+3+d8mMYS4cwlMO9A73dEHNhXZf2m9NePTtDZIeEuT7hdmWD6amY4/rr
 4JZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892727; x=1791497527;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7n8eiZT0moyKyUk4kNfsl+2TaeH6oGKZxKYcMFmSniI=;
 b=fZ/YIVKvk12dhGvkZbww94nU92VQA+hYl1df9dxPYvZnjic6unq7OmOeo7c8W4ZX7i
 BFWqAhInmChQ2UlogH0QPMe9LJwGqfvmnL2YWAHUI6K3fwnc/HXQqFn3dDHXmm7F/SAM
 GBulLgPO0HLgz+YP8zQqXCbMhJEy3h/xNSbIE7l2V+TncckZQw3LSca0G2jQyf5POpNb
 /LH/0493j37kDPmRgfkVyvYGleiZikUePF7B1N0LjdQlMONrrm3NgqjzznFTw14gy0d0
 f5iFZReLOEoksv0XHovDyJiLenfcSXdouYbDJKY30hsNyCwiCx+LNKkT/V7vRWDqk9es
 t8HA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxRhjvxFdmRvpROVwH8ily4H/AfiJ1CkS6GaWeS1LSgt8hstELg+DuSsE12lhtmIrksYPOmUbC9miq@nongnu.org
X-Gm-Message-State: AFuF++mqa4xZsf89oC85Sp4+nq8D/Lro+zsR7zDYCCMknprW3w+yZvQt
 tqg1vo0pDtZ881PoTz4dSW4EQlkfWhSL/8O63izzv7T70lOW8q6NiJqGFqrqRY9SDP8V2onVaYP
 LHGlOjs8U49BTXxCnz/HeOgqzvAqLY/rCc8Sf1znEm20yeD5XeV+XXgCq7A==
X-Gm-Gg: AYBFou0bhsvsNjNO+iTMCrlgGSatRRdyDVhwPtwUkVUmsGrwjDA+W4Nbr+/GpzbegjV
 XXBPoMjNGV0TtUX3CoKBZT9ZchU+fwHpSC8EtqDiTnZMqMmtNsQkYTZbBtONV6D2kOBw7HYrrvW
 xhAkFFwoLCvpAU8SI56dax9OXrYRNM3G9Y39xlNLijxh58I/2Dxu2U/8+OofWQX4+w2v5j255N+
 PecwCv2qjKx6vjfb6kYzPQsTwWo5PUlxgXfaBHm5n9FgN4B+noqRq/9b9FrzP2cQAzcNA9iYq4U
 WIJPjN8fHd874ZIl5VZJgENPfZBArRgIwLxfZEJsEi7E+7eBMMVKPO5sGhoeq4a4CfPPAWyGQda
 sBSAb2CfjwIbhanKx3dD04gMxprG4hpQngc16YTwiKfklMi0mtkigif7fQyfLpe81C8A1Lg==
X-Received: by 2002:a05:693c:62db:b0:33e:a173:4aab with SMTP id
 5a478bee46e88-34f150ab94emr684451eec.14.1790892727114; 
 Thu, 01 Oct 2026 15:12:07 -0700 (PDT)
X-Received: by 2002:a05:693c:62db:b0:33e:a173:4aab with SMTP id
 5a478bee46e88-34f150ab94emr684419eec.14.1790892726541; 
 Thu, 01 Oct 2026 15:12:06 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fd4dd2sm1195237eec.20.2026.10.01.15.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:12:06 -0700 (PDT)
Message-ID: <7cef718b-b2db-4392-8246-fb88830ffb70@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:12:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] target/riscv: Compile tcg-cpu.c once for system-mode
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-12-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-12-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX6Gn8C4MS57t2
 mveVoBe14YWVHNFSw7x6LC1Z9hzQH0uIcPteyXjrvNq9aMqnjSL3b1Qy/cqs+m4+Q0vFWdcy+jd
 o47Pka6WG+uan+oWiP7SuhiDd5AfeDCSRqDBazwd1Sg9DBRkDYvK5GyVr9X9vDgFwYlyAnYTnxk
 cdtGiKI544WmFK+zEpg7TB2eLaCt+UdncYuUvJXCmwpl8xaf1TUR8+ucynsgc18CJuwGfTiKcjn
 0wlXaTsL/rXF6GxwA0si9K2llo0SnPyDXG/fOiyETtyZ8pX9OGF4JyvOI0HPlIiIKQmudSiiIXI
 LWjPqKU8SX5ufmVmstSUTp+ICfBOYQuPFJf6LcPhamzjdpW/jKprWG0fECRS2WYQvX7zfezD+A6
 G2R+1LTF8akRAhltb4oq6nAwhxGP2OLqURyjPe84/YIux0htZJItMUjsV/iS3gNvQWHyom578UU
 W/hdLoALZvnA++q9JLw==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abedab8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nULji4kO_cyZGrGR1ukA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: m7ICe-r-mzB83DR9pexovva_hSoPe4Yq
X-Proofpoint-ORIG-GUID: m7ICe-r-mzB83DR9pexovva_hSoPe4Yq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX4tXQy2rZto0Y
 70mIZ2K/R2tgo54/6GNnHPzACUnhhNT/4St59XrFG9oWuDe8vDYnV3+rjmUa9Ahdu+s2saItKlG
 gc64apYmiPQydbQJdabW46Lo0k2JV8A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> Remaining target_ulongs are replaced by their corresponding type in
> CPUArchState.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/tcg-cpu.c   | 8 ++++----
>  target/riscv/tcg/meson.build | 3 ++-
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

