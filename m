Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDC9606A329
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QSuxdLbV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F/5GJxmk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJS9g-0004eR-KD; Wed, 21 Oct 2026 04:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJS9f-0004e6-28
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:58:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJS9d-0002Vo-GB
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 04:58:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L8IkhQ594915
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 08:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s6+GYDcBMiqNXqH6GEqGkTy2qELSA4lfYtlvGuhHTYo=; b=QSuxdLbVnDcF/U3i
 F5TnYibgWrI0SfJhrjwPFktadDvq58PbQhrOOySlvF4aJTB10yOyYXYrhgs+bDes
 QT80m0lhnZ+8qNLBplJbmNEQYSxBZW4ZQwiUKzjZXp9AK14rrwVbN2jn+Le7Ml0c
 bwNUTAXsHLrwJJv8mxv+UPLW/5DVnuQvT0SIz8zW1hWd8RGjZ2XzNmNREPfOk9ea
 WZgfjPkB+6y4r6EfuWpa/P/I0vITmL3KVRSwuAAtMefLfFaC3USUfUbFUtNHXY2G
 tlKXrNXRb8VXkdNZDtzbDFGRba7WwPXVaHkjFHOYFYj9XEa+p9gsPE+/tKKLRh3U
 TtbQfw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedajk4m6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 08:58:36 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cbf2fd504so88719785a.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792573115; x=1793177915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=s6+GYDcBMiqNXqH6GEqGkTy2qELSA4lfYtlvGuhHTYo=;
 b=F/5GJxmk8kf8Yq5R83dX63Rvn9hUMwMUa2uLTOyfEApcAzSt9fbxC2fuzJ99KAJ3xY
 TCklNwqOPBp4Os1O+LqhTUAaCBhjgGQq3H75EqISsXQ1Tro3QF+F45rU/bcWiBig5+xt
 Bk3STVuHRFPkNObZeCIT/hsMqr7A5LCmZ6oPaEBmAlUcVYtxv5thc3T5o/OHJ3i++178
 SwDH/YLAhFdUyiTMZRElqfxXIDGYiXUSINJ9TxHq/48goPyAFzkz8VK8uc3c+bYEBQw5
 lWt6W17vWpdLo3p0GPquuJP6NfhhgiSo3RFbXZueg850cbhQgv5cnbvZAZrOXC4Eoeos
 Qbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792573115; x=1793177915;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s6+GYDcBMiqNXqH6GEqGkTy2qELSA4lfYtlvGuhHTYo=;
 b=C7ADczifYodh/RdivbmRYaqom0dqvPzyb0QelZV3zm4mrsXFZJc/olNOHg+XlzGzOh
 qr7OJJ1YK5iTRnxym+5KYseJ+Xm3K0wMXBIj4ylB3jz4g5Xzk4n/BgfvPDBXlO9NuouH
 u5QQ1bkOrTD5X7KdOCJJwNgP9zTcBjcnbyz8GmeFpRI3+i6a7JDo+aCkimNOXesqBCqu
 1hIuqBfZK+RFZQkF+dJRv03Xl1adHO2ZLDRNt3L53rIJ5L/64zAExGDFaNuPoZ/mNPgP
 q8gm8wHJvhyVgMBpjiPDBK3YUYmnTECUm9UQaITa5WiHHi2U6/+xoNnJmMYDHe1/T9FC
 wGlQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwdWKnn6ihN6YZxE2Wp7GMkLtm+Yr3ER+4J7X0uVTZYyH99i/cOXdZi+NlBphqIlvK5w4/Yof16ntR9@nongnu.org
X-Gm-Message-State: AFq9FYJy3aJhabYuroNlJfrwLjXlGZCz7vhcqux7RUSxJ/1+PZsLc+mC
 bJj9ki/DBvac3djzuKoxftHJcStnde459FSt9C7ji6gLh8yRQObpgNB2k9+NkzGvOAtdyuWveqF
 95x+fPt8cco/+2YRD+bHvT7KKQo+qIg/tn35BdZrMcM/+P3JjQbms5kwcLg==
X-Gm-Gg: AYBFou3TC4csmEUo5yfwBkEfl8px0jM7eq/SRP8bZPt6dpP7vF9nLdcKVUtm4z4btlT
 KBPXL9oT9xDfzhD4V8hlMbwGgfJqL2UCBxuiHaXFC5xVcWKKx0XE6aVV0FqrmMs4QOcFxmQzrH7
 7z4QKjJqkys4SvXsXudN4tMjv/9HcsbUxWdso5EjWJ7Yqkat39+uY/5guqPxRBWn8+VhojWfHAd
 XcrjV1dAH49FRIlWxRgdpBJmNFkRhhwKjwRvUcw/C0yt/KRahwYuR04KaXz7rqpQCsVK6Krmy4R
 1JfLLeMvM8+jSlADjV5js7qwhQlFjQmf2fOxsnUAAm3vVBse1jZJR39nWR0HmUgeo2/+PcBPWns
 ViR4GK+C+OH7NEjs/cPdKOfjnAG27hlO0Nw==
X-Received: by 2002:a05:620a:688e:b0:93b:d7a3:45cc with SMTP id
 af79cd13be357-93f57f50edemr300834885a.53.1792573115452; 
 Wed, 21 Oct 2026 01:58:35 -0700 (PDT)
X-Received: by 2002:a05:620a:688e:b0:93b:d7a3:45cc with SMTP id
 af79cd13be357-93f57f50edemr300833485a.53.1792573115024; 
 Wed, 21 Oct 2026 01:58:35 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c374sm3798560f8f.58.2026.10.21.01.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:58:34 -0700 (PDT)
Message-ID: <2a478631-5399-4aa2-8b35-90882e993e83@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:58:32 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] tests/xilinx-zynq-sdhci-test: fix GIOChannel leak
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffman <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20261021-nohmp-next-v2-0-85471fca83db@redhat.com>
 <20261021-nohmp-next-v2-9-85471fca83db@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021-nohmp-next-v2-9-85471fca83db@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfX0vaIFuR+REQo
 RX0gyj/nhtwjsKipxMKJBMkvJE15IgXlxnf+rDRmUVXfFnyo/WfEfGyRDILkD4i+JXMw+1B9K6K
 46aOPDvWldlJ8N0fyrQwyUGbxrLbEbcOfWaP8V50eIzC1OMfZCUr0iRpAhtXtTOC0LUyKkGlecS
 Whwm9/ixHC2aKiMCHwL9WP8ZJ6A3TQaa+SoxP0W+8ilC6+iLW9fi5eYB81oyg/tUxej9hHrsAF+
 6n+e7xpcobgUMVJ7U3PB7mm9xXz0urAFRhp6KnsB1V6phQQOMbSwhBDiL0argtt0u5tzHGEKlJv
 iYk+XzOYhRPZsEcoWfLMBmbqD5lcJOGRLBh5AXHHuuFlRMehgFfNq+Ugm+bRbBoufNYHoQcXlbJ
 Wom8HiXX9ZXiyC+YcyqLhIQ6sedZd/9dRIcVXCnulExI8m1p/9RQOulypJEa1mKhEftYbitFLVN
 k7nSDobXWiUuDdc476A==
X-Proofpoint-GUID: rG5afbMTQVbKBUlOcXNQaYOmgGVUKHzY
X-Proofpoint-ORIG-GUID: rG5afbMTQVbKBUlOcXNQaYOmgGVUKHzY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNSBTYWx0ZWRfX4axOSkIpdeGt
 Hu6W0nOGQcfQsWN5op8ruFm/9R7bGuc5RieU7Y95AH9ihuXRKMtVU1Wi/pDO5ehWUj9cy9UUc9e
 tt0AXJmDoIPyYwmflu9UQWQbD8Lrh7E=
X-Authority-Analysis: v=2.4 cv=HrTjiETS c=1 sm=1 tr=0 ts=6ad87ebc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Y2_p3rjERIUfMriRnaYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210035
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 21/10/26 09:51, Marc-AndrÃ© Lureau wrote:
> Reported by ASAN.
> 
> Fixes: 255c627c645b ("qtest: add xilinx-zynq SDHCI sdma test")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   tests/qtest/xilinx-zynq-sdhci-test.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

