Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C0BFEC119
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 21:05:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58vg-0000px-Px; Tue, 24 Mar 2026 17:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w58ve-0000pO-TH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 17:04:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w58vd-0007ka-7v
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 17:04:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJD8Mu2146751
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 21:04:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V89SH7fzdI6s/DKcZSAtn2FLs5RPuF46HrwuLEVlRmI=; b=NVGD0bvJ6wP6Kgpd
 S9o5Ut5zKMNPgqH438SGsVuX7RxdktMm+HcYLQlhx89XnPPi7ZL8I9ieJbApGeFh
 LN+5WI/B7vtSKIRulXkONDx/nsuyheHW6YPNbMnGkR7m2hKCzLLTZVZ7pHunM9gb
 xIvxBw5x8cnjmGDch8ELykLfS73fb8a3ABNXv9CxiTi6dr9HBswFVtrHnRA3/gbT
 d1OU6QddD7M2avzzfSDuFTPGpvWlEnqPzN6cOt3/bbcmNEu1fbA6bs2kYyI/k8t+
 peJhpiK/b4oG35OhM93hl/c9t8lc7WvACAFwEjiuu1o2kt8pgs2F0Ex9Z5oXJS9j
 Xov6fg==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3nexuak9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 21:04:42 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-467008029a3so1192766b6e.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 14:04:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774386282; cv=none;
 d=google.com; s=arc-20240605;
 b=YIP5qULtNJu3pgWkw0sMwlJ3lT4mCZN64ZWso2BwYEvRZKcc9Rjn/2zPR6EWdqn9bg
 N/iI/fL9Xw7TvQSWgcLr2+zckfIL1l0yF0StkVmtcQ+knb/BCH9BUPBANesKv3AyHZ5L
 E987zCMstZA+bjSmqHK1mVgHPSI7ixdTidL/OEw+NRydh6RppZgkoViiu03cftdszjha
 KNhd0G3Tm0XLL1tOYqAxjR238LP8DbbcJYxavB2fUxg8po2oDUpqSziEsQ4EOYy2saj2
 DkLYFg0ZeYIy90nq+po3V+TVbb79rO8nRfVJbrVGrKhX/p9Jh6u+SOYqerLWBfbSpulT
 +HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=V89SH7fzdI6s/DKcZSAtn2FLs5RPuF46HrwuLEVlRmI=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=YeXwPE8Us9xsDVdfFhDNycBxhM2S+GjGhMfsNvTANSuGNJu0X1M+oxRgZFsbl0yEdF
 ZY2ioC2L8pwKlVMtwfmNKGLBq/lRmSSU9MP2HlW5LzM2mm0UswtOLtZFjo1JhSdAdYql
 f4laxuX8ds2X789VxZaP0PBocsHoTSmwqmA62ICbwYicP8+w56pmbzMNTXyYj6cKge/x
 3584BOoSxzN8S3W1QVq5Y0jz6Xq7GOqmqtxp4A6DQc+xVB3/kWaV2Y17Pkp9Q+jmiVMH
 Tgifo5Ahl9TRD+lZJWq10WY4uhDznwsXl2ATFYr8nPascvBCqTteOL+HqW/7KRn3yq16
 ph3A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774386282; x=1774991082; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V89SH7fzdI6s/DKcZSAtn2FLs5RPuF46HrwuLEVlRmI=;
 b=iC3RsWpfb5kSNXLRQQKPkCk6wTo7qVw1CUtjho2t0KGzgPIvTRUZr6exk0AXihGC1U
 CZ3AaBk9dBCk9g6BWPj7qyVAfZ3zessqY/358l12VcgxGjyLrXkDTAbuzs4oIAGSo1VN
 xIdos/15prsb6KqpbfiEf8iB/W9ScejExvDGeOg/djUm+wDZdOqbKdAABTGoJww2li2Y
 q8iTRQVJoQLu5UNKkJU2JfrI+YQkCbaVDonBe+CjxM6zr47d76nIt0ozzrT3ifV0iguR
 LWIH1QlA/nyHANs/vStJ55zxQLxSsp6+0umQabCqzDQEVgwS2OUGI9lidf4cw6tVEn5K
 X5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774386282; x=1774991082;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V89SH7fzdI6s/DKcZSAtn2FLs5RPuF46HrwuLEVlRmI=;
 b=tB1Aro0xUBMGlDNCPK/KdLOZf88tXOoYiIs8qZ6EKP+vLBcDH1+CksrzoF5AdmM8T2
 ob5lULf8EHIK9Eg8pvcJ/UYImk5lAwSebvLsDtF9dA4DcE9Pb+3BmIhPng0EANawuN31
 /4TxJXlg9yR/UKT+kI3PEj+tI1uOjaDB7+vcEQ6XAH5qQb9B0fvZj6zA36GPto18zAUK
 k7Fr+q+jYZbJOVltMsvCrSaNpciYM5wxcUoTsYEjwMqFzBv7auk1oH+7r6/hYlmogq1D
 Vb1Uh7jEDLo7CniFfkMl9if+VdDjsRP/TQzUST4RcBhxNP5tA300JVsuTg2OT01+wU4r
 yKVg==
X-Gm-Message-State: AOJu0Yw97vyzE3NVWOX69qTCZXUW/QX8C8XaLS97LNiaPPnVuRsk5Zk4
 S9dQTMfoig4zY4f7Sz9csD9SBxQysodjNZiBLlrVy3XnMDB5NCU0AwepgwQ6VSxuTfxHGWzxRdf
 ra4XHV8HFWbkQo7bFlpSviybPjADeJ/iGALc8VkeNbxp+RGJyq1OhlRVn8fSIN/4juldecEoGSX
 hVLkNRqlu+U39Huo7hE/BcsGjYLKZrNomU
X-Gm-Gg: ATEYQzyMN9111wtvqqPvrc8kevpJSa2mAdb+ppGF8YRG1tuJqjgEO6s0aLy5EaPnht2
 We2WRrwMxso30zh3VPUlNI9rbBcntHpHd8kBLDOkCtlxryBu7kPDjZORbX87SoK+nrutvHE/cA0
 oqZFE7xH/dTDc80bVQw+6l5VT/uwl+w4Jc+Qs1vft3SzC/sOxvHl2ezU/dIZqJuLQrDQKXYGi7C
 tW3Vvo=
X-Received: by 2002:a05:6808:2208:b0:467:2be4:9e33 with SMTP id
 5614622812f47-46a5baf4272mr714624b6e.6.1774386281676; 
 Tue, 24 Mar 2026 14:04:41 -0700 (PDT)
X-Received: by 2002:a05:6808:2208:b0:467:2be4:9e33 with SMTP id
 5614622812f47-46a5baf4272mr714599b6e.6.1774386281314; Tue, 24 Mar 2026
 14:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <b648b6b7ce4b4c1ab3bc00016d9233a5ede3563b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3Np8aWjb8PyoupVpWCWc8thTLghWn974OVC7M_-opqSrSQ@mail.gmail.com>
In-Reply-To: <CAATN3Np8aWjb8PyoupVpWCWc8thTLghWn974OVC7M_-opqSrSQ@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 18:04:29 -0300
X-Gm-Features: AQROBzAQfYTzOmR-DagzYOcWBOG0YquFVT6xtSfrgEOXibPtSO4NKfRE55AD6qY
Message-ID: <CABrGZ+GO+G2MrnP1W69vsSCrX_QcEsJw5Zhkd5yd_uhdoegpFQ@mail.gmail.com>
Subject: Re: [PATCH 07/13] target/hexagon: add v68 HVX IEEE float conversion
 insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MiBTYWx0ZWRfX29oVLWG/YPxg
 96Y7lIr5I37jiFabFSJgoc5DFmT7Cn+3Y2EnWc9SI9o9z0BsJ2z0ODDJ1qksmPRIdkVt+xA7UNu
 YpXJFyubDwAriK3WCHX7gZIq1vQ95Za3gpYnCjjuw3Pmdd+t/iwsL7zJ/w6EYMoAUVCajT+MfqK
 18guANGc+6Lmo67PFUh5m7DFXrTvMMcXv0pAKOHba6nPXYP/RIItKQiFBu2QXo4n+c5JcjmfT8G
 3PQPdGTXx5KTHTfSxWxBIQNip1i+gwokHRWGIUJFouH5R2xjRoNJ8PjSuA1+6Y/T7KYUpKvGtFi
 no1lElo+7l1IeHt5OYMUTVGwO5JRSESPjsqSbpVcqAKciwyJoD8saL33HRW6CMp/LVE4mL7uoDB
 HIh7W3836fFSKtnsntTYgHZTZfebBMUS23XlJ7vRu7CssJxSQO50uxfqmRPx4e69mAuu8f0/rDy
 hSWl7H5cXq1OTBl+MsA==
X-Proofpoint-GUID: r984qeqlF1_WaHyF84IuT4pODx4Ur2nd
X-Proofpoint-ORIG-GUID: r984qeqlF1_WaHyF84IuT4pODx4Ur2nd
X-Authority-Analysis: v=2.4 cv=Bd/VE7t2 c=1 sm=1 tr=0 ts=69c2fc6a cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=O_TXilX1zFGKBhMiD08A:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240162
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 23, 2026 at 6:26=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Mar 23, 2026 at 7:16=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>>
>> diff --git a/target/hexagon/mmvec/kvx_ieee.c b/target/hexagon/mmvec/kvx_=
ieee.c
>> index 33621a15f3..bbeec09707 100644
>> --- a/target/hexagon/mmvec/kvx_ieee.c
>> +++ b/target/hexagon/mmvec/kvx_ieee.c
>> @@ -131,3 +131,101 @@ uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float=
_status *fp_status)
>>      if (float16_is_pos_nan(f2) || float16_is_neg_nan(f1)) return a1;
>>      return fp_min_hf(a1, a2, fp_status);
>>  }
>> +
>> +uint16_t f16_to_uh(uint16_t op1, float_status *fp_status)
>> +{
>> +    return float16_to_uint16_scalbn(make_float16(op1),
>> +                                    float_round_nearest_even,
>
>
> Does HVX always use this rounding mode?  The scalar core uses the roundin=
g mode in USR.

Yeah, almost always this mode, with the exception of some
instructions. It's not configurable via USR (or anything else).

>> +
>> +int32_t conv_w_sf(uint32_t a, float_status *fp_status)
>> +{
>> +    float_status scratch_fpst =3D {};
>> +    const float32 W_MAX =3D int32_to_float32(INT32_MAX, &scratch_fpst);
>> +    const float32 W_MIN =3D int32_to_float32(INT32_MIN, &scratch_fpst);
>> +    float32 f1 =3D make_float32(a);
>> +
>> +    if (float32_is_any_nan(f1) || float32_is_infinity(f1) ||
>> +        float32_le_quiet(W_MAX, f1, fp_status) ||
>> +        float32_le_quiet(f1, W_MIN, fp_status)) {
>> +        return float32_is_neg(f1) ? INT32_MIN : INT32_MAX;
>> +    }
>
>
> Does float32_to_int32 handle these checks?

Hmm, I don't think they are exactly the same. For example,
float32_to_int32 will return INT32_MAX for any NAN. But the hexagon
implementation here returns INT32_MIN for negative NAN.

>>
>> +    return float32_to_int32_round_to_zero(f1, fp_status);
>
>
> Rounding mode?

This is one of those exceptions I mentioned earlier.

