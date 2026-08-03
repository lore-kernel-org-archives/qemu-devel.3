Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20400C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wquHV-0004uQ-3C; Mon, 03 Aug 2026 11:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wquHQ-0004tl-Ea
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:08:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wquHO-0001mC-W1
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 11:08:40 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 673EBn0G2014449
 for <qemu-devel@nongnu.org>; Mon, 3 Aug 2026 15:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lD++9sW9X9nQu7a+bRVRvZrd8c2u6K/gMrhifbdKc98=; b=gRkMP3B7lfOHcfSV
 NM1EY2VapfVzyO4iIQaeQIKBuZpxkhV/0XhvfmYkfs9xi8sBOEkHxVC7kt771uaa
 uch0knql1d0EcnnjU+w4mTs8gSo+CCM6SVAPh7q558JqmOvXYQEwfOqGx09k6Kh7
 l+Ca7Uf8ayMk9jF3gJiEnI4G2ZR8ME9iPaLN5+vfv+4PGa3AQhQUXK1e7GMqB65d
 g97DDTV41pp9ikpnjyKMLvAMbNMs4O7aRPp1TEukJ7nvi6nZA9YLGi4Cs1WxDBtd
 RUGNKP1JROKDjeGUX0sYfV9PTqBhtIvrAmW2mL0V9gBPIWor0N3nqlSahr+ecO5K
 K3Xf/g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ft9fakucp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 15:08:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a97644aso34525021cf.2
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785769716; x=1786374516; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lD++9sW9X9nQu7a+bRVRvZrd8c2u6K/gMrhifbdKc98=;
 b=Wi+OAFuN1jfB9Uc/b9LnokZ9iN0d6H/Yxsdj+OVJLA7WgU1hIB6V4qPxuWv6jIH/Pc
 Qm5OA4EYZ1TJAbmW/F9fLvXJFlMpnmTZhhl7e4HqIQMPmJSbTPTe6NKRHrn2o6EhdeMh
 Jca4MkSEwqPcTmyPR+5lbocNtzInp0Z7b7VjsZPgsL9m8FNx4N8iktbs0jNo/3Wvq1PN
 jFGyV/DtS0zbeHdB/OwDgGuJtM8JSAujTzvzDFypILZWkAgzru+OGH9zmZFQ2mXGnDSr
 gPdtIOEUPXmN7AlL6/DIae8jKBw14A1V8B1uZg2I6cA+ejSvSHX5niM9syiLmmcO54na
 mfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785769716; x=1786374516;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lD++9sW9X9nQu7a+bRVRvZrd8c2u6K/gMrhifbdKc98=;
 b=IjMwccwNDPW/+1XFT5VMGa5WISh5SjoRvmklfjtpoM4mvzq6cTJzb36HpP3fqYtvls
 1Nf0RiEykoQ8rNSCbkc9Lc8U5BvMgoJCQiKHLuAMq3bVYGFuupxDWUDSDawpgunOO72+
 VwNf6xHCKYW6evtx89XSschOJla2sUDRjF4DvOJ0cxY0JL0JMjw24yrVIVJIo7lrkssa
 j8prpua/AfIJFb668QpSl8UpDCM0r1X/ZObGI7Le3Y39J2VKExrxBu4sUEdJjjrW4BFu
 g2wzvZbr0Ag/jjn/9e8l9cgy6esoUT5LOT5FKdMr7s07mwKtiX05a2j7MXBsEQ5RZpVu
 cdXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqW82I+rjGFQFWSP4svbcorIhiaTVxbRC3HJkXFs8Kv9G9smgk+Riplo+bu5iUZhG8znrk0ICrRt9IW@nongnu.org
X-Gm-Message-State: AOJu0YzOASbwrwS5DyWdnjxDgspmCwBr0u1cwheW6rm17sBqaIw1Nlez
 4h4Oq0uAcFx1jw6g9Htf6IxwEONPdHjDszfBeX9Q7FPtbThGvJNd8D6xgCxaYBjZ9u0LWTB6LQ4
 4cB6/5EqhvVzW1VcNa//W+uxA9T9PzsvJPAWVt5Tl7+yh1pn4qj5sKINwxg==
X-Gm-Gg: AR+sD13FUVzY3pm539Tr2NaaHuvo1D+CiDsrgMMeC0lgeFOzFlI7WJLl4V/K1Qbl4OU
 91QYdLmoTR2DW4qAK27dBO0kk86Fu2oEhZeipNtuIQQ/M1OvE/8+S9T8j40yGjaCBcu/F5h8S9q
 6s9mGPO6aFll6f6CMNH0LIR0WD4N4RQvzZYEU79Vfa+RhjjM88e58dsrIWKCQ2zzqTCUFAGlmBR
 Eb+HEbrTZH8hzfpvMW/xx9w4n1qaCUYYBzCqfsdXYZS7ytkfbE0phHrTZZBFQRG5BoU5VGdqmj8
 MhI9dw3Ln2iSgJ1aC1CtXCiBUXV2HHQfz2E0fPznaVoQ7HBKnDSY1dJJIKfxuMS8nnYu0MTVVUB
 SCv83Dsqgv+KBxaGzQph2aR7dziRyHz6TVho=
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-52b56845401mr217949311cf.41.1785769715816; 
 Mon, 03 Aug 2026 08:08:35 -0700 (PDT)
X-Received: by 2002:a05:622a:c07:b0:51c:17cd:1fd4 with SMTP id
 d75a77b69052e-52b56845401mr217948591cf.41.1785769715428; 
 Mon, 03 Aug 2026 08:08:35 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4981248661fsm2051025e9.3.2026.08.03.08.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 08:08:34 -0700 (PDT)
Message-ID: <3ad7fc1e-a9cf-4992-a98d-aa4a476bc45f@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 17:08:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] tcg: Fix opcode dump for bswap
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, qemu-arm@nongnu.org, git@xen0n.name, 17746591750@163.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, philmd@mailo.com
References: <20260731000503.170446-1-richard.henderson@linaro.org>
 <20260731000503.170446-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260731000503.170446-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PZPPQChd c=1 sm=1 tr=0 ts=6a70aef4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Y4BCUQXyt4A9JXyutdN1EC3p8FJcDt7f
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEzNSBTYWx0ZWRfXxi11wHvlaRmS
 upoeNiIQIs44fS0Er+/QNr3U4OzlXUXh8b2QTjJCY/nAR0VANLI8++BWNDNjjY6UjxKI64ycVZc
 1I6WsruDOf5Ta8p5UzBV/Rs9BVWhSg0=
X-Proofpoint-ORIG-GUID: Y4BCUQXyt4A9JXyutdN1EC3p8FJcDt7f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEzNSBTYWx0ZWRfXwdGtHoBNydDS
 ofyMltiHeW/unY16ueDGznZ5AVLJ8fIMC1wGXL3D6ySG/Cuwur5Mv0Of6SFakEvZCBhsbOgqw1e
 ZJMLpAbJMCNQjoU4uF1yOUtZTMdnpXnPLc7qZj+3hcPLdIQJncNtV7Xk/sLu/hixJdeQMMDbic3
 CDVyC85FdR3WvNct/utEhbPNB0+1Zv0iJ42Qonnn9wbRBfU2M2oxuK364jZ06TiKXValn35anf9
 rLX6XHMrpVranupsSMvWqVZqlStgSTPZ6qUq9pjK1YCTRTuVDFTRMCVkFWMYj3BQVp2YqfQPMzY
 fbpME6Yf4FEqVsrZ6QuXN/N/BVMj1TOXaFGD3N5shLDj0447I2ySPpz4O/b1kVz3QhL+r4AJEnF
 PT9nA5Zp/yJ7SxceFOPUtpTldjQkv79yLeH/x7iuj8ICFp+cIiOarWivCxpOrm/m+d/yuDXbgze
 2Oy1gUEok/OY2XzNi/A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030135
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

On 31/7/26 02:04, Richard Henderson wrote:
> We use an array of char for bswap_flag_name, so some
> entries in the array are non-null but empty.  Check that.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Fixes: 587195bd590 ("tcg: Add flags argument to bswap opcodes")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

