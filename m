Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B290606D816
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PCRHVQsB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g5vcNKJF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOD3F-0006ZZ-CD; Tue, 03 Nov 2026 06:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOD3D-0006U5-NO
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:39 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOD3C-0000QB-03
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 06:51:39 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3AAm1r928140
 for <qemu-devel@nongnu.org>; Tue, 3 Nov 2026 11:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9MxsAa8DrRsVfGWJj5kcTg81B3JXOb/OMu3zez6lvRw=; b=PCRHVQsBOy+Uj04K
 N6S0VRnFhgm5gtsAUdDBXnRWD1ryJtRkrIPkKXbQi0qNst295ML5UoNUWMWmoDOf
 8R1cJ16rZErI9HC4t5TXCCmVcz0yS5cDje/mCEqfvth22ia92jwPxd7PfuEzhBVh
 Q0vZHjlYdCExIhh9IVNaz0FzTYrj8cn+PDONLTds3GCh6TaHzW43oTIxk8gBNcoD
 3ReB6Dwk3IRfuBTb/Ys4SqU4F1GbF3S2atLKdvj8CxqIWbhhy/fg+ZkNLCyZaWAl
 HWdYdi08mejy6N20KMeDMY/LKLEoz4HdWnSzV6bePL3oTna7NKuJnNndXIKHkstb
 dXRCXA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07ekjpe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 11:51:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f5844e383so665970785a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 03:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793706695; x=1794311495; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9MxsAa8DrRsVfGWJj5kcTg81B3JXOb/OMu3zez6lvRw=;
 b=g5vcNKJF7M0A0EWzG3VXpzVx+oY7T/vFYhPdoh0FZVdQ+EVRBhrHQjBaUT3WiFxcPA
 lCISju6l/qk3A2M9klFCRT/XXrcp2XH8xKggqOK93FZ/mp9YHIvTNaM+7xCH0xAV40oe
 k+bnb9KGaXETKC1s/b/mBDlD1Fp2YU5PfuAtAEeVlOU5PfsvlMw1wMplGw5I57zjcyNS
 l3cblPOtXWBLBefFZFZm2a+RynlKYHjMF/xz/HM+s8VTD1fJvFcwyL9GTTpxykOM06HM
 0xXle4K7xSxHLS3k6SSC3Vr4Y8HmxlI3c2k5CAyOfDDfQLaLgBfsxWE93LKuQnnIKFZr
 H1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793706695; x=1794311495;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9MxsAa8DrRsVfGWJj5kcTg81B3JXOb/OMu3zez6lvRw=;
 b=e/M9FFTGDimtDd0AdQbkPi3ZX7oGjrmge1Ae4oHbAfEpcb1LQVfELg4MlvS0sZgubd
 UTKC0JqmUGr1fXMYBcSZ8KLuPdEuS10tRl2FONQwd3wLM2eM/wicyBYb94LjUT6ujp4M
 jas9TXt44lTsxrRCqGff5SlLrJQZEm9S9+ZYKa0NWs7bwsB5YZavrNRIq08V89v59+HA
 ACmj+iIY8D7MjS3DSYFTYRlbKZy78dlf8qgyGq4+AIZew6dCCDw3Ov/CjgU1mbrwUTTn
 ZDJOHMKHf9MPAyzDefxKfGWQ6TljtvtFtlLuizgqh8coIhXUfy6Degs05BISg4Xw5xwd
 vcKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKXCzFif565zaIVIjf6LyzfUelyEMbnFDlN0KNLJ2eiS2pRNWw+mUCRhKj609+lSffy1big7/OLRAW@nongnu.org
X-Gm-Message-State: APuU4Z9VF35GhJuh8pCHDUjdeJuQ9/SDakK40173WeTCJwMK4g3LWm7M
 +cm9zs2mpu4u9mdgDJnxal5XkUltl62W06yuY1/X54vuz7ggdNonOPqWMALitYG07wWQZe6jfJZ
 HgnayGv69aaDK+myAStoRBc6d/heXVGA5Jr7AueOicAtmfDvCOi4elCI2fQ==
X-Gm-Gg: AYBFou2wuGhG6v1x7AN6/UM/sald9cU5b5XztF0sejpyInGzoNkp5Q+3QDjS8eQepHt
 9hyRSPOA5LoOJWN8GZDD8DqStzGVXJTctlnsI26x76vaGronNaOeQg0KaZRkcr+kIovFs5AzoNV
 dyz0IzvF49nucPMB2+ri8ZQc+THw/gpBMd+JS0L6e+eVFlDkytBh+2jPuZ7VmMdRdc1y3a8GDGs
 FfAQVQi8KWSKGGXpnA0maYt0xk0zGNnCw4Jcv2B1qo2IRd2f6KV0K7CH0ZL87jICgprJvfTlItO
 Emb3tJP7L5b5APbYMyDqlKE/LW/ay7QHX+QMBWhQIc7LH4K/ofppq44Fk4/lVlQqwn48D4RbZXE
 Ca/aJjT5iirY1Yu8bTv4sf2L6vJcTtwtpI13Dciu3qFj6OibqhSPaamdKcl3RD48RauY=
X-Received: by 2002:a05:620a:1a07:b0:93e:c12c:9dd3 with SMTP id
 af79cd13be357-94421796eafmr2123010285a.83.1793706695257; 
 Tue, 03 Nov 2026 03:51:35 -0800 (PST)
X-Received: by 2002:a05:620a:1a07:b0:93e:c12c:9dd3 with SMTP id
 af79cd13be357-94421796eafmr2123007185a.83.1793706694615; 
 Tue, 03 Nov 2026 03:51:34 -0800 (PST)
Received: from [192.168.0.4] ([79.127.134.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a98e8f9fsm57022465e9.13.2026.11.03.03.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 03:51:33 -0800 (PST)
Message-ID: <865c4fd3-ea62-474c-97fb-7940068553eb@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 12:51:31 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] net/eth.c: In eth_get_protocols(), don't report
 SCTP header off end of packet
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
References: <20261102201828.1879576-1-peter.maydell@linaro.org>
 <20261102201828.1879576-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261102201828.1879576-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NyBTYWx0ZWRfX/rlGgBLkQOWH
 4z2PtY3/jqMky3w3K6kxH//I+sYaYONCr8cMlUE83FZTDI3/HHAKPP5Ov/WhL+PE9/so6qZ/DBi
 T50RM8Hg3X4F6mOvtXuv45MtySYVaDyqhLkmrbetMD/efhRFmqVyorh0JFQVhdc1GbZyo/ggq1Y
 ZbbvWZoee2dmWBewDC6DM08lBT21YzmGvZwFY2TiGXOoVeqSENyvCPQe84Z0gfthRFSoRsuVVYv
 OCSVf7SVWu0Dl+lrKj81anvkBb+jajK6IGAGbZt2ejsC2uV2VAbp0sScJq1kUiPLNQORvquU+Le
 lVw4kNLvNoDeF4Tg1C1KFehMsYfoQTpAwRtgbbpFwHkXDOfqJSUJVVHEWd4DT2DagJR5dU+/d2M
 xcN8vIB2Yhu8QF59rrf5JgWFhYgZpF1PvX3zPN+JfNaWWAJTg/t8r7R6Pzy2/vFZFnwCQ80MiFB
 JmWOlrQxZIIFPTjYPeA==
X-Proofpoint-ORIG-GUID: YHycHMpD1N6D9Cb1fS8EESh8K6gTrBNR
X-Proofpoint-GUID: YHycHMpD1N6D9Cb1fS8EESh8K6gTrBNR
X-Authority-Analysis: v=2.4 cv=B/wsQ+tM c=1 sm=1 tr=0 ts=6ae9cac8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=iDw3GeftGWU4ZHOe0o4/TA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=u0tbCQwKhX-4yttcUEkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NyBTYWx0ZWRfX6nwBz+n6qnDp
 cTAVsSdVFxnZwRVK7bFKZvDsok5kQFXmhiVM1uGwTGxgIQmj60RP/jXStsfQAIbWqCGCbaRaeT1
 4AkA0vaKiU2q/gKgqmEPzx693NJP0qg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030047
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

On 2026-11-02 21:18, Peter Maydell wrote:
> eth_get_protocols() parses an ethernet packet and tells the caller
> about various offsets into it and other properties of the packet.
> For the L4 protocol, in both the IP_PROTO_TCP and IP_PROTO_UDP
> branches we implicitly check that the packet does contain a whole TCP
> or UDP header at the l4hdr_off offset, because _eth_copy_chunk() will
> fail if the input packet size isn't big enough for the whole header
> we are copying out of it.  But for IP_PROTO_SCTP we don't copy the
> SCTP common header.  In this case we should still do the length
> check, so we don't set l4hdr_info->proto to say there's an SCTP
> header present when there isn't.
> 
> This shouldn't have any visible effects if the downstream consumers
> of the l4hdr_info are conservative about checking before they access
> into the packet, but checking here too adds defence in depth, hence
> the cc to stable.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 907209e311 ("igb: Implement Rx SCTP CSO")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/net/eth.h | 2 ++
>   net/eth.c         | 9 ++++++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/eth.h b/include/net/eth.h
> index 46dc9ed5acd..e10684ed923 100644
> --- a/include/net/eth.h
> +++ b/include/net/eth.h
> @@ -394,6 +394,8 @@ typedef struct eth_l4_hdr_info_st {
>       bool has_tcp_data;
>   } eth_l4_hdr_info;
>   
> +#define SCTP_COMMON_HEADER_LEN 12
> +
>   void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>                          bool *hasip4, bool *hasip6,
>                          size_t *l3hdr_off,
> diff --git a/net/eth.c b/net/eth.c
> index bc26d38dc21..341d3bdf02b 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -213,7 +213,14 @@ void eth_get_protocols(const struct iovec *iov, size_t iovcnt, size_t iovoff,
>           break;
>   
>       case IP_PROTO_SCTP:
> -        l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
> +        /*
> +         * We don't copy the SCTP common header into l4hdr_info, but
> +         * don't report SCTP as present if the packet isn't big enough
> +         * to actually have an SCTP header.
> +         */
> +        if (*l4hdr_off > input_size - SCTP_COMMON_HEADER_LEN) {

Hmm don't we want the opposite "is SCTP common header complete" check?

            if (input_size >= *l4hdr_off
                && input_size - *l4hdr_off >= SCTP_COMMON_HEADER_LEN) {

> +            l4hdr_info->proto = ETH_L4_HDR_PROTO_SCTP;
> +        }
>           break;
>       }
>   }


