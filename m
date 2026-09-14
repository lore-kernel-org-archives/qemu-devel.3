Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870DCC88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CXj-0003UY-1V; Mon, 14 Sep 2026 15:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CXh-0003UC-1Q
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:40:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6CXf-0005kz-Cf
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 15:40:40 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYoTf2074670
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 f+PoPQix/eB7bSXszbcz+h6pBr/8J2HvlBaII2MK5VQ=; b=UPuNJAoB87hYujxZ
 4lbi51oheKtSRvaUo1h9eriYSr3xgj5ewAE0qCuwM4GBW0DfAcGWXgPxm4UxHHZF
 P9jK+VIYHy7Ag64sMmoRTY/QXeOqVDm9g9p9TLqWc1KLK8zw8H9/G2cJlEJI2bSI
 S9+K4Fv6DrLLP17yhQD+j0hUgrKQPzNGExBfl1HVPMVhI75KYeI/AtpJK2R8hVk7
 NqAZZZXDVI0ghqIKfv/g/se1QZj0pHiJfmL7lmud1qEklW2zu2HXgKe6l4pbJdPn
 LtWdJRCV6b7mop083+q8MKy2KXg/dLbXRqR8kXaxPtQP0EEyjsD89eOUV61FaJsR
 1fTj/A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdevtp98-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 19:40:37 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39de1f85cb2so1564694a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 12:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789414837; x=1790019637; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=f+PoPQix/eB7bSXszbcz+h6pBr/8J2HvlBaII2MK5VQ=;
 b=P6VTyPFeE5F+4prkXm7tMvFtFxmbsbiEBg/S4uRIfYiRs0VOEjBFy3xdU2ZsZTEu+a
 1p9FtdiAanv9Kvr736yycfEpFaniyz2ym/nO0VS3iZIOR7aUUEvRzz3QqSHsM0J/4erC
 Z2jU9sjuO6RCstP9ueqKvobzc7p7bi5YGZ3Q6aW2KWP3dQvIBU2FuAzScT39lCH/N84R
 vrSJ366MO4C3H/f8Olkh6qrzpka4Ft8TqlYEKmij7Jx2JCUnxbY0u1DMbMDahUDYMSlU
 rl/5w1xK+9m7ys68Egz6LI1M8lWTQm2qOMQsOmxw4jvwTYsqBg+3gKBgtr6f+u2A6e2q
 lf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414837; x=1790019637;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=f+PoPQix/eB7bSXszbcz+h6pBr/8J2HvlBaII2MK5VQ=;
 b=BPNNK29TUXMhYmqRcp9R9Ypd3bH/XlpHA74ml1aURuH1lOft9nSw2j/bI8xW9PbTHv
 302KCqEOmED3L9QKNVF/AgRUm2AKagebqO8NOygFRlpH+Lu1bbDbQ2xZVi3yUkZLsG9O
 tO2DIOafvt9f1lymrKr3LZKm7SMI05K5LnGiZfK/zCImpB7rSijJisawRqkD3mEVcasw
 R+NjCpFv4SBCT9egnyW+cL8CCS8Z5JFn5gINv1uK3+YxYW/XAwa183sEajtAd58FRva3
 vrXT6s7Uo/RV8wdvu32eKuyTEKn6dgRHWOJwczDUhKhLuIn/J2OtFiuJsDAmFOJa6cNe
 G+EQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy62gJ8OZ6oVWJcM+jGINm0U9kEA+ovATbdX9AWOoq9MwhoV+lHwV6xhTIi5SMPUsI3O9dT1JfoCXuZ@nongnu.org
X-Gm-Message-State: AFuF++mMvh4x97XHVsWl5IxargbAQBAeRQ7l1Hs3+m7IFMfE4ijJTMHz
 XtrZjOuHnXf9cf5MaoaNZrHfi//4qavu5K5VzBUrpoVf8S1S+Kwt8Yr3dcm1nvqwx8wuvYrd9tc
 c8Sd2qo5C/iigXD8nxIPjTAQXWwU+QG+JnSsObFV8aq4m7oC4GyYFNZKScg==
X-Gm-Gg: AYBFou220hl5DqUTrhw8QucI4Aob83C+EFm8MkCQPLxe0I5vYU8EimuTWUqHFzzkfBM
 jf5rQBw4+S8bJhDpaqgq67mEnvzfcTFohkL8OBzdCJdeYKsndoXLIlYXKfjwFdEUrQwJzGhs7o7
 ILnhLFSvonPKBCImHln7eXLpKgCU06zU9K3Z0ytdGPuUOcH3qgx77OffZ9eh6OQAoipWGprslNJ
 J1Gr5nLvzvRuLpHhhiNv9z8kq2wJY0Wc6mwn0Rdm5LiXbtIh26aXkBd7oWvLSvCtm4dKHeFOohP
 UJ2u/EqxB6vxtEZpm0YrKlIecz4yvSfrrdAWBo/ZtYYnj0CMxPdaVMS7nQnrINezZWn107lrwOW
 fgaJ7eFAOMSckQkHrbA/uf2TQt3jmJIb7OAU+I3rA2471qWsPRirS4YBa3lTTqta7WoV2
X-Received: by 2002:a17:90b:3ec8:b0:39d:f351:8f0c with SMTP id
 98e67ed59e1d1-39df351afb2mr5098032a91.13.1789414836831; 
 Mon, 14 Sep 2026 12:40:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3ec8:b0:39d:f351:8f0c with SMTP id
 98e67ed59e1d1-39df351afb2mr5097978a91.13.1789414836400; 
 Mon, 14 Sep 2026 12:40:36 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365bb6ba0sm25624467c88.15.2026.09.14.12.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 12:40:35 -0700 (PDT)
Message-ID: <cf18c6a7-764a-4d87-ba41-a5fbadf304fc@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 12:40:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] target/hexagon: rename LEN to OFFS_REG_END in VTCM
 macros
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260905195955.2001304-1-brian.cain@oss.qualcomm.com>
 <20260905195955.2001304-7-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905195955.2001304-7-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: l0x2pZr9rr4-2mfCHtPmBAL11LtN9Fhp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX4mp4Kqx2RN1d
 46E4lZVlTClUE7UGV5AECogi4sFkUtrs2f94ESjrZkKCyDMK4A7RbqNVs+KrUNprOt993fY2Fzd
 31ZM8BZWaEl0Rft8H8KKL03rQOYGxIs=
X-Proofpoint-GUID: l0x2pZr9rr4-2mfCHtPmBAL11LtN9Fhp
X-Authority-Analysis: v=2.4 cv=ftpJ914f c=1 sm=1 tr=0 ts=6aa84db5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=4ryBTKhK-9f61IUUWfgA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4MCBTYWx0ZWRfX6KGcCMjX3dVe
 2iKWzP0Ljk1ascQtw3EPMDiP5nElbLiQKU7KV0zGaC7PVX9M7gyO8qPuH/mloV+3G1Xjjnk60+X
 4G/Lf6+v4PHW/J4MmUL3bNtDC9cxvq1D2gXesbehapDJ0s28xYlUpf01f9+rmrR6t6BGCSdrbvn
 4Ole/2b4dFUw+60SzUl/LF04DRFXC5x2aO/nd6OEL+r96nxgWKZLpn8ZKB3Xkkg3pAndK80wo5+
 iAOJXnM15ubncW3tyP3PEpiOBaEH1XHfR33yDoRr0V7RxKxX/BEZRE8YptdwW/ykQ+gRX9XW3nn
 4jXPQ7zJknpIHA7HCEraqDgYCPDcEtd+f+yNRIWMTg8F0daSx+WVERYR+FLnJjzkU6582nBEAvI
 Y1BqtAQLbdc88SYZzT3TFQBrb34dR9l9ufGiH31drLnSuLriifWkoLceweW5tPtVQS00Ttfo5NF
 Vivhqi6R3nmOoJMD3Mg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140280
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

On 9/5/2026 12:59 PM, Brian Cain wrote:
> LEN suggested a region size, but the parameter is actually the region's last
> valid byte offset. Rename it to OFFS_REG_END to make the semantics clearer.
> 
> Link: https://lore.kernel.org/qemu-devel/63513430-7bd1-486c-b693-49d1076562ed@oss.qualcomm.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/mmvec/macros.h | 76 +++++++++++++++++++----------------
>  1 file changed, 42 insertions(+), 34 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

