Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nlqZuouy;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OWE0F6eD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtOV-0001BE-Su; Fri, 30 Oct 2026 16:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtOP-00015i-VH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:40:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtON-0004y5-Gs
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:40:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIcwQ44119547
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KMTwQkDaEA2yowa6Xu+EOTIz5yfsID/yVIK9OKU1xvE=; b=nlqZuouyv3XZe3Lb
 yrrPHCFD55u1Alhyd0eeKPjp38aUhwYhMqZMGShHMAvJHy5cs4suommS6t1eH8vE
 h1A7g8vtnCBUHkL9wgQP3gnGkW1WhN9M80R5/h+z7aKrw+LLVz26Avn5dhc/pTtv
 T3PBdYLFdSFf9ZmQCDeqfSYz3TDu7R50d92pfOOUG90YfEtS7dhAMxgoHlu/Id5m
 nWe5yA8Z3nAWw7EthLJ2K4eyib+KPmam6rjI07Y3zwFU3q9bJupxcZoaIYl54FTW
 jy8JSMJDDhCbotqWqPOQuuu0MHlM8tn4NQvrzU0piWhvREBr/gFzIv7YZZ2hdSx4
 ZqBikQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0pu8bfb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:40:02 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36a223755e4so4390480eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793392801; x=1793997601; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KMTwQkDaEA2yowa6Xu+EOTIz5yfsID/yVIK9OKU1xvE=;
 b=OWE0F6eDFXyw18Vt3ZzZwEd6ygiwx41bttW8kTktsT+l8Mc0e6Dq5JDmoIFqes4WCn
 vZR8SMrN8DOQcJK5B5aN4Me0W95tYpeqDX4Rb+iJGrnPPoKFQmKAQ8l5zl9R3IQ5Suyo
 4SnLB3N5jUzNd3EEIislfmNtYeScIYDBnkhObhnCDcillWiAwUMJSpC6iI2xbuIjyRqL
 321szrB5HS8gYaAoKsWQ4f3M8i1EBQOaELATz4cGZtIv/lJ/4QR+y4JmjqFmCPOPN/ip
 mON0UJDoDmlnfan2sCAApIEsZ75YnW6DT/wSyKDWJuaToVmXQm+QSgKlR3TEqk6aRFip
 qF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392801; x=1793997601;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KMTwQkDaEA2yowa6Xu+EOTIz5yfsID/yVIK9OKU1xvE=;
 b=X9HonXqksj4kw1BB0CF+3/KHjLPxelbyG++cFGpNfHJ2DY0Cd4Gy9SKq3IpBRlQF0E
 C5J5Fe9uE1SjviX7FSdx4MR8dI9ltcxcNjD3IVujTA1Cym0Bgtz1kLQeY6dYb95egdjy
 x0VpJUhljfSXEOo3+Rpy9SllonqUN7i3rZLB7JlSY8aKFDatVMma2ek/+knZvU6hWApa
 9xC1AEHdBT46+RAnZn/McuNXK/QCfhPR9ujRBZk+1+kmuvO7x1F7BsPLVsHsaD7uh6wO
 v6UiDxKIoZ7CZTxLs0z5n8H7zqMvO4hX/pYQ1mAk5L29rXflxoXCwWTG36fO0utRKErY
 KHDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx71tVK0/2SZ/s+7K1YXjJ7U3mTSHVl0Fw4zzx1s07+xP1DkhwRmQU0yytbWz6c75tAs+DWW8ALMaNv@nongnu.org
X-Gm-Message-State: AFq9FYK/7+oFy0WSQpztg/aXXf0ZGHrm7pANKoYvy7/PdOiL4gdQFK2y
 FQ1Qqb7cwZE6uSewLlOMyoTyPvA/xKhz8zp2JssA3OLdA9HQv5TGi9cft446xpjx8ZNjgPXXHZ0
 eR7vpacv4xLHFa+2n5aDYd+RA3WCw+zEtCiM5Ggc8H4Q/BxSonHlGNqjGJA==
X-Gm-Gg: AYBFou3LWkPy08dNMK54wpmlw2t67qt3YI1km0nKKW6lxp5H9hBIicrAkHMyhVaHcuJ
 zQnTqMwp+xu63qbcRMwN4TqH+vQeZ+XPf9cgiLDpbmV2yYAOSw9/yY6r+Yh1QDF/8NS/yBNy+wR
 3Dkd5/+w7KM+8XuyMjvEpHxeqX0UOvAaxtP/k8Yp/Le+53e3EwvAsAfWLlaELAuHqp8CdfwZ67r
 lHiF07bjweTfDtSDlddQwxzASVtbUdYK79n2UrqMUjP+ZWS3EAvz+y974getvogW+Qei0Ej+hSo
 XSL47EroxO7E/oX/SxuVgMYZrr8698JunNqoza9/0Q/zwBD82Rvgu+oMUZWtP3OcvzQ8z6hE7hs
 Ih+cUMkemv/QuGZTBu6xZGvm1XtTyjPs+xaKp1EQ3Vdj8o0FCN8RxpMbHQFx0HA9B3vp20hSKqJ
 OUH64kLpSHoKAeaIW5HMzvlzSw6NV9QuatSpyXKTt6kow=
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id
 5a478bee46e88-36a423f04b7mr7382457eec.28.1793392801154; 
 Fri, 30 Oct 2026 13:40:01 -0700 (PDT)
X-Received: by 2002:a05:7300:3b1a:b0:351:52ec:60ee with SMTP id
 5a478bee46e88-36a423f04b7mr7382406eec.28.1793392800473; 
 Fri, 30 Oct 2026 13:40:00 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4291e38fsm10949891eec.15.2026.10.30.13.39.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 13:40:00 -0700 (PDT)
Message-ID: <f86fc05e-d14b-42d2-901e-97d52014fbc7@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:39:59 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/hexagon: let a lock owner service interrupts
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
 <20261029190208.1169519-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029190208.1169519-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ffVrknBpKgEPEZ009ibH3cQGf5f40kBf
X-Proofpoint-GUID: ffVrknBpKgEPEZ009ibH3cQGf5f40kBf
X-Authority-Analysis: v=2.4 cv=O92sLx9W c=1 sm=1 tr=0 ts=6ae500a2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=HzIgfIQohTklgzI2RiIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX6olnKavSNdBH
 D2naa1aNCa5/IajTe+ofLKp3HoPkJqAVfdPsg5T0NLI5uJkGeGm1rQw05Jq19rZN9lJLRLVFSiI
 cJTXd4HVqG2YwwF0OdO3LRHi+7m623hbrg8Zid88XzzKqOgedFAK24/EdOLwWvNfEfMqnqCWwEh
 /3JWHXuWV2nF12e4DqOGJUpHVGoKw8MqFEOXYiW3nKJkPyCkxs/sFu82cbgIZeAY+phNzfKseJi
 0R6nIXrB21ABa2K29YiCxo8QzaGctxxVk9L7J7PSN8w53InRyxsOE6EMKJClxRw7bY6x7lyx3xJ
 emA2r/0YPVGO0O68YbFj6iNVSrH09k8F9+25LKJmxPnYEEgrNB/j8j2vuiD/cIhXCrgEMqpqhE8
 v8VElrVRWbK7iJ6lM8ZgS/pXoYiaQnS/m7m6iIu3XgLqQXFza3UCDcHwrxUGRs5dUeSvPAueTle
 CJDrLcyeLB6p3W1Vdrg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfXzKe0of7nb3/X
 It9jtl1Q2KGMatBZNSe7pcOog4rxtu97H3EANn0ToBtQbBXJxQQsVWi7VbmJaF2M28y+18p1mJB
 flMEvymb8NzaonJ1My+qQBmNO8KMLLg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300082
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

On 10/29/2026 11:02 AM, Brian Cain wrote:
> hex_is_qualified_for_int() treated every thread whose k0 or TLB lock state
> was not UNLOCKED as unable to take an interrupt.
> 
> Block interrupts only in WAITING and QUEUED.  Previously an interrupt
> targeted at the owner of a contended lock was never delivered, so a guest
> waiting for it hung.
> 
> Fixes: c9f3f0e95427 ("target/hexagon: wake K0 and TLB lock waiters")
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_interrupts.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

