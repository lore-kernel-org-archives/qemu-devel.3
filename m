Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A432CA5FC7
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxK4-0006l6-71; Wed, 30 Sep 2026 12:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxK3-0006kA-Bv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:38:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBxK1-0002Dw-NU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:38:23 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxigQ703804
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /X9heYMx198TJ4LpE9DaFbTMUbyB208+qy68C9LGfEo=; b=l+MyQb3MfH2tgcK5
 VPHKOvsfvGGRgMw+0cuc0py1XX1oHyPDNvZpMC1I7bmRHtKsp3zKp67Sg/hHFl7e
 JRCr1Cu/711UMF7ZEpAsbIkXuIgFq9H5VBqZJl4W6zZrYUGrr7i3bMxJtEtb1oZ7
 Gq4z0b8NvFgKoAaRMby9Qm9C5Kwpxn0OkEnyosL0eRpL6kZHhFXhnEtA+Gn9gaYp
 gQq1E7hvdgu1gy3J/I2dhQBTsTRLuSLhhxRwsv/vv2O033r8fHISD5WG+obkBOS2
 uPVGuE655d1zFGdzxGbei3tiRnva27Wrteh0Zwzc7z9MLFUhPnvCxnxnywlYpU6M
 NaoEDw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h136tgvde-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:38:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a183a0e93so1185684985a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 09:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790786298; x=1791391098; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/X9heYMx198TJ4LpE9DaFbTMUbyB208+qy68C9LGfEo=;
 b=HxVZJyEYHf5fxChhAiKXxskaybLk8GlXnPPDCYBC13GK8v82C3/3allAPRER5RCzS+
 grHSttimzKmE8hMc1qN1S5bM8TGg413JtkHRb1vDDT9gFyINTVGD2Deh+c8symINRYJm
 w1cWimmqBVNP2JuIRQfdiaExUj9VbzCc2Ti7r+SRkeE8KUUeV7l0VfkY0cr+teJwmd9w
 iWBcHoBL8imn9UifjeAOuJ1fqYMhvUpS6chRZ3VyNTG7TGguzMHa929r48sY9Eba6fvU
 z58uBFTZ5vbHjGNw7mWplAGvR8Dycoaqh3QdZQ9Al4hk3uZMtooItDic6ve+p8UHPk9m
 bIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790786298; x=1791391098;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/X9heYMx198TJ4LpE9DaFbTMUbyB208+qy68C9LGfEo=;
 b=FY8gdmGFfjZ9efuKtvcDaBYE0WBG2y+ql0rLlCXX4Xdg+w8BL15va9LmnEf8vWj0c6
 NsnI08VR1btHbBwqMxEeL7UNFPXvfCY85V5l0TxtkxGKCO9RG3zupGYuq6IccUVPycZf
 lAg/yPy+ILsLlT3g5/Rk06V/Y6sU/WIZn2jXNGmv7A8ohR4cdI8fGuWjx5OWxTyUquUQ
 Qpgo8+EAAMWfi5ThBXxv7oWaRauCO0hgUxHJAGodrZkSBAVD5G6clVCEAG2wFbyGQyZV
 STKYciSwIbdj98a+ZWA3H93XwZw/WnxFtBPoofvpQjnn5cEV2Yn7O0mKZSJTNS+26qqj
 7pNg==
X-Forwarded-Encrypted: i=1;
 AKwUvByj+9pJ4ljumxVAsNrPmHKOe37Pz89X4I4yz8ghFIDBuzTbM6DbZzyxFwC75NcNYcr7olzA347EBJVK@nongnu.org
X-Gm-Message-State: AFuF++lq9QRJj1SiHz1wp2u3+5NC7VcCv6pl7coKFYShpf882h1lMUQ2
 T/ls/cagPqC48+AHe2a4CGFRK3aoBJUAlEIVmBxoFAMZbdh9+GHbOFf0ngPsyllazWUOYeMc8M9
 P3DXMBEV3p46yvVh6tfIVivOfKMiWUghsd5rUH0h7Qb6p/5K6SMiktG/BYQ==
X-Gm-Gg: AYBFou2XGSA763F0kWwLVEqkE/stxSOa1Z58RKt6bpOIFqzbF7HhDqcwV/lC2wf1+xz
 u66KPJJygOg3McXcPvLV/vFM5yiHIvHblR76JGvjsLZhI7F/x5eAhj/XFfSAh3vLog7qTYiK4vX
 jTbDCAUwnuDDcPyJ66sjsHjKQxGeXQ+bVw9ESkI5wMEyWt0LsvT96KyEIYEk2GYLdoq/smJXZPT
 2ywOHuS6F6X+noA75RCEwjBLBzrS4sCCVT8nW0wi5ySSUWJxbz4mDvVMxa4TVnGuPSQi7QpUQ2u
 YhgQ+fx+FoT2cblZrDJGeJsTPNCMr2SHreIB7IZd9ISGLtlCmAdvkb40DcYxbl7j4P0kzgZJTBZ
 E06BNh6v7gmKIOd3CuLQ=
X-Received: by 2002:a05:620a:72c8:20b0:915:83f3:780d with SMTP id
 af79cd13be357-93ca97abebemr258573985a.32.1790786297825; 
 Wed, 30 Sep 2026 09:38:17 -0700 (PDT)
X-Received: by 2002:a05:620a:72c8:20b0:915:83f3:780d with SMTP id
 af79cd13be357-93ca97abebemr258569585a.32.1790786297327; 
 Wed, 30 Sep 2026 09:38:17 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068bcb8fsm270211f8f.1.2026.09.30.09.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 09:38:16 -0700 (PDT)
Message-ID: <776d7089-49ae-46f6-bbc7-1380bb583511@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 18:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/27] hw/usb/dev-smartcard-reader: apply backpressure to
 bulk-out
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260805-smartcard-fixes-v1-0-187ee9122441@redhat.com>
 <20260805-smartcard-fixes-v1-11-187ee9122441@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805-smartcard-fixes-v1-11-187ee9122441@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX/S9zz6C+ab1N
 sU/+GgllkqfIc/ycUoLxFYEFwYEHYTmfaR6w6N7XJFqz7n7jDGEBCDDHy+yf5DqvGQAiFMt6dW4
 1Nq0/KYREp4gLO7HfdBVdFFOulNWoes=
X-Authority-Analysis: v=2.4 cv=aPFlOr9m c=1 sm=1 tr=0 ts=6abd3afb cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Au3avfe4EuKhBPopahV7ohaz_BHXrKaS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2NiBTYWx0ZWRfX/j29cbZZ9+KB
 0tcR7fnQbA4jpyYkRG28eAVC37Y7aTVZf6bsiny7DvHps54YLcuFFvCJlYX1GWIc1zinlejtGl4
 8obEkzwch0B4Wq1Ks/q9FUwFY3mTASeuPeM2eSfQi0eX4/O1byHc/h/z2RrBdbfqwuyqM4TBvJq
 Gcdzfp3mTC8HP8HpAQQerqsam9MMRRcgF6kPkFH3ncyvud4Dg4IldYIRokWlE68KB684/uD5jdg
 aJ0JtHuBDw3z/k036/uGqcLWq5cN/JQULlmTma+H+SsbXd4bQA99Da1NoAqG5kS1lniBIJSlymR
 LgF+pc7tae1YBKfzyfM+NHXvlGwgA4VNVvAUy3E63xqNydCVZjjpwTcD2tLA3oCqShTtfrEUybH
 vuoiymeWHsmYsKXXOwd6bwcixhfX5myodyvsuT9M/oz6Qhb6hldUHysubeckr+W6Tl5hDBQRHHP
 z0FrOENjwe6Q3XYKuUQ==
X-Proofpoint-GUID: Au3avfe4EuKhBPopahV7ohaz_BHXrKaS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300066
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

On 2026-08-05 13:51, Marc-AndrÃ© Lureau wrote:
> A guest can send bulk-out commands faster than the card backend produces
> responses. Each XfrBlock adds a pending answer slot, and other commands
> immediately allocate a bulk_in_pending entry. Once all
> BULK_IN_PENDING_NUM slots are full, ccid_reserve_recv_buf() returns NULL
> and responses are silently dropped.
> 
> NAK the bulk-out endpoint at message boundaries when bulk_in_pending_num
> + pending_answers_num >= BULK_IN_PENDING_NUM, so the guest retries
> later, giving the response pipeline time to drain.
> 
> Change ccid_write_data_block_answer() to peek the next answer before
> attempting to write the data block: if the bulk-in ring is full, the
> pending answer is preserved for retry rather than being consumed and
> lost. Update ccid_flush_pending_answers() to break on failure so it does
> not loop forever when the ring is full.
> 
> Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/dev-smartcard-reader.c | 38 ++++++++++++++++++++++++++++++--------
>   1 file changed, 30 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

